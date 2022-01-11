' This program is used to add a serial break before transmission
' It is used to compensate for a USB to serial cable that does not
'   properly send a serial break
'  (The PICAXE programming requires a serial break to initiate programming)
' How it works:
' The TX from the PC is connected to hserin C.1 via an inverter (hserin can only do T = idle high).
' hserout C.0 is connected to the serin of the PICAXE to be programmed.
' The serout of the PICAXE to be programmed is connected directly to the RX to the PC
' 
' Step by step:
' 1) Connect PC to PICAXEprogrammer and PICAXEprogrammer to the PICAXE to be programmed
' 2) Power up the PICAXEprogrammer.  It will start sending a serial break
' 3) Power up the PICAXE to be programmed.
' 4) Start the program download.  The PICAXEprogrammer will stop sending the break and will pass through
'    the transmission to the PICAXE.
' 5) Once no transmission has been received for 5 seconds, the PICAXEprogrammer will start sending break
'     again
' 
' A jumper is also provided to disable the serial break, i.e. 
' Jumper not installed = insert serial break
' Jumper installed = passthrough only (do not insert a break)

symbol HSEROUT_N_POLARITY = %00010
symbol HSERIN_T_POLARITY = %00000
symbol HSEROUT_OFF = %01000
symbol HSEROUT_ON = %00000

symbol ENDBREAK_DELAY_MS = 1 '4800 baud -> 1ms ~ 5 bits
symbol BREAK_WAIT_S = 5 ' the serial break will be reasserted if the PC doesn't establish contact within this time
symbol IDLE_TIME_BEFORE_BREAK_S = 5 ' the serial break will be reestablished after this length of idle time

symbol hseroutPin = C.0
symbol ctsPin = C.4

symbol breakJumper = pinC.3 ' if jumper is installed (bridge to ground) then insert serial break, otherwise don't.
symbol picaxeReply = pinC.2	' 
symbol sendingbreak = b0
symbol byteRX = w1
symbol byteRXlsb = b2
symbol lasttime = w2
symbol delta = w3
symbol programdetected = w4
symbol waittime = w5
symbol toggletimeout = b12

;'pullup %00001000	' enable pullup on pinC.3
;
;dirs = %00001  ' C.0 output (hserout), all others inputs.
;
;'  HSERSETUP B4800_4, %01010 ' HSEROUT_N_POLARITY | HSERIN_T_POLARITY | HSEROUT_OFF 
;
;'algorithm is:
;' a) As soon as CTS goes high, start sending continous serial breaks 
;' b) As soon as a serial reply is detected, stop sending breaks and start passing through
;' c) Once CTS goes low, stop passing through and return to a)
;
;ctsPinLow:
;  HSERSETUP B4800_4, %00010 'HSEROUT_N_POLARITY | HSERIN_T_POLARITY | HSEROUT_ON
;  hserin byteRX             ; clear the buffer if anything still in there
;	hserin byteRX             ; clear the buffer if anything still in there
;
;waitforCTShigh:
;	do
;		b0 = b0 & %10000  'pin4 = CTS in
;	loop until b0 <> 0
;
;  hserin byteRX             ; clear the buffer if anything still in there
;	hserin byteRX             ; clear the buffer if anything still in there
;
;serialBreakUntilReply:
;	do 
;	  hserout 1, ("")
;		b0 = b0 & %10100		'pin4 = CTS in, pin 2 = PICAXE reply
;	loop until b0 <> %10000
;	b0 = b0 & %10000
;	if b0 = 0 then ctsPinLow
;	
;passthrough:
;	b0 = b0 & %10000
;	do 
;	  byteRX = $FFFF            ; set up a non-valid value
;	  hserin byteRX             ; receive 1 byte into w1
;		if byteRX <> $FFFF then 
;		  hserout 0, (byteRXlsb) ' lsb of w1
;		else
;		  b0 = pins & %10000
;		end if	
;	loop until b0 = 0
;	
;	goto ctsPinLow
;
;
;'algorithm is:
;' a) As soon as CTS goes high, start sending continous serial breaks while attempting to pass through
;' b) Once pass through is detected, passthrough without serial breaks.
;' c) Once CTS goes low, stop passing through and return to a)
;
;ctsPinLow:
;
;  HSERSETUP B4800_4, %00010 'HSEROUT_N_POLARITY | HSERIN_T_POLARITY | HSEROUT_ON
;  hserin byteRX             ; clear the buffer if anything still in there
;	hserin byteRX             ; clear the buffer if anything still in there
;
;waitforpassthrough:
;	b0 = b0 & %10000
;	do 
;	  byteRX = $FFFF            ; set up a non-valid value
;	  hserin byteRX             ; receive 1 byte into w1
;		if byteRX <> $FFFF then 
;		  hserout 0, (byteRXlsb) ' lsb of w1
;			goto passthrough
;		else
;		  hserout 1, ("")
;		  b0 = pins & %10000
;		end if	
;	loop until b0 = 0
;	
;	goto ctsPinLow
;	
;passthrough:
;	b0 = b0 & %10000
;	do 
;	  byteRX = $FFFF            ; set up a non-valid value
;	  hserin byteRX             ; receive 1 byte into w1
;		if byteRX <> $FFFF then 
;		  hserout 0, (byteRXlsb) ' lsb of w1
;		else
;		  b0 = pins & %10000
;		end if	
;	loop until b0 = 0
;	
;	goto ctsPinLow

'algorithm is:
' a) Starting conditions: CTS is low
' b) Keep serout low
' c) As soon as CTS goes high:
'    i) perform a break for then wait until the picaxe reply goes high
'    ii) start passing through
' d) Once CTS goes low, stop passing through and return to a)
ctsPinLow:

	HSERSETUP B4800_4, %01010 ' HSEROUT_N_POLARITY | HSERIN_T_POLARITY | HSEROUT_OFF 
	low hseroutPin
  hserin byteRX             ; clear the buffer if anything still in there
	hserin byteRX             ; clear the buffer if anything still in there
	
waitForCtsPinHigh:
	do 
		let b0 = pins & %10000 'C.4 is CTS
	loop until b0 <> 0

ctsPinHigh:
	high hseroutPin
	pause 3
	
	do 
	  let b1 = pins & %100 ' C.2 is reply serial from picaxe being programmed
	loop until b1 <> 0
	
waitforfirstprogrambyte:		
	low hseroutPin
  HSERSETUP B4800_4, %00010 'HSEROUT_N_POLARITY | HSERIN_T_POLARITY | HSEROUT_ON

passthrough:
	b0 = b0 & %10000
	do 
	  byteRX = $FFFF            ; set up a non-valid value
	  hserin byteRX             ; receive 1 byte into w1
		if byteRX <> $FFFF then 
		  hserout 0, (byteRXlsb) ' lsb of w1
	  else
		  b0 = pins & %10000
		end if	
	loop until b0 = 0
	
	goto ctsPinLow


;' algorithm is:
;' 1) Trigger a serial break
;' 2) Wait 10 ms
;' 3) Once the serial reply from PICAXE goes high, set the transmit line low
;' 4) Start serial receive on serin from PC.  Timeout after 2 seconds.
;' 5) If serial was received, continue to relay.  Otherwise, trigger the break again (repeat from 1)
;
;triggerbreak:
;'	if breakJumper = 1 then prepforwaitnext
;	HSERSETUP B4800_4, %01010 ' HSEROUT_N_POLARITY | HSERIN_T_POLARITY | HSEROUT_OFF 
;	high hseroutPin
;	pause 10
;	do 
;	  let b0 = pins & %100 ' C.2 is reply serial from picaxe being programmed
;	loop until b0 <> 0
;
;waitforfirstprogrambyte:		
;	lasttime = time
;	programdetected = 0
;	low hseroutPin
;  HSERSETUP B4800_4, %00010 'HSEROUT_N_POLARITY | HSERIN_T_POLARITY | HSEROUT_ON
;	do 
;	  byteRX = $FFFF            ; set up a non-valid value
;	  hserin byteRX             ; receive 1 byte into w1
;		
;		if byteRX <> $FFFF then 
;			programdetected = 1
;		else
;		  delta = time - lasttime
;		if delta > BREAK_WAIT_S then 
;			goto triggerbreak		
;		end if	
;		endif
;	loop until programdetected = 1
;	
;passingthrough:
;  hserout 0, (byteRXlsb) ' lsb of w1
;	
;prepforwaitnext:	
;	lasttime = time
;	
;waitnext:
;  byteRX = $FFFF            ; set up a non-valid value
;	hserin byteRX             ; receive 1 byte into w1
;	if byteRX = $FFFF then
;		delta = time - lasttime
;		if delta > IDLE_TIME_BEFORE_BREAK_S then 
;			goto triggerbreak		
;		end if	
;	  goto waitnext
;  end if	
;
;	goto passingthrough

;	do 
;	 let b0 = pins & %101000 
;	  byteRX = $FFFF            ; set up a non-valid value
;	  hserin byteRX             ; receive 1 byte into w1
;		
;		if byteRX <> $FFFF then 'or breakJumper = 1 then
;			stopbreak = 1
;		else
;		  stopbreak = 0
;		endif
;	loop until stopbreak = 1



;serialbreak:
;  HSERSETUP B4800_4, %01010 ' HSEROUT_N_POLARITY | HSERIN_T_POLARITY | HSEROUT_OFF 
;  high hseroutPin
;
;	do 
;	  byteRX = $FFFF            ; set up a non-valid value
;	  hserin byteRX             ; receive 1 byte into w1
;		
;		if byteRX <> $FFFF then 'or breakJumper = 1 then
;			stopbreak = 1
;		else
;		  stopbreak = 0
;		endif
;	loop until stopbreak = 1
;		
;receiving:		
;	low hseroutPin
;	pause ENDBREAK_DELAY_MS
;  HSERSETUP B4800_4, %00010 'HSEROUT_N_POLARITY | HSERIN_T_POLARITY | HSEROUT_ON
;
;passingthrough:
;  hserout 0, (byteRXlsb) ' lsb of w1
;	lasttime = time
;	
;waitnext:
;  byteRX = $FFFF            ; set up a non-valid value
;	hserin byteRX             ; receive 1 byte into w1
;	if byteRX = $FFFF then
;		delta = time - lasttime
;		if delta > IDLE_TIME_BEFORE_BREAK_S then 'and breakJumper = 0 then
;			goto serialbreak		
;		end if	
;	  goto waitnext
;  end if	
;
;	goto passingthrough

	
  	
	
	
 