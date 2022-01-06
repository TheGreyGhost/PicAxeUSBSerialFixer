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

'pullup %00001000	' enable pullup on pinC.3

dirs = %00001  ' C.0 output (hserout), all others inputs.

'  HSERSETUP B4800_4, %01010 ' HSEROUT_N_POLARITY | HSERIN_T_POLARITY | HSEROUT_OFF 

'algorithm is:
' a) Starting conditions: CTS is low
' b) Raise serout high (serial break)
' c) Maintain break until CTS goes high
' d) If CTS goes high while serial reply is toggling, then 
'    i) wait until toggling stops (goes low)
'    ii) maintain break until serial reply starts toggling
'    iii) terminate the break then start passing through 
' e) If CTS goes high while serial reply is not toggling, then 
'    ii) maintain break until serial reply starts toggling
'    iii) terminate the break then start passing through 
' f) Once CTS goes low, stop passing through and start serial break again

ctsPinLow:

	HSERSETUP B4800_4, %01010 ' HSEROUT_N_POLARITY | HSERIN_T_POLARITY | HSEROUT_OFF 
	high hseroutPin
  hserin byteRX             ; clear the buffer if anything still in there
	hserin byteRX             ; clear the buffer if anything still in there
	
waitForCtsPinHigh:
	let b0 = pins & %10000 'C.4 is CTS
	if b0 <> 0 then 
		goto ctsPinHigh
	endif	
  let b1 = pins & %100 ' C.2 is reply serial from picaxe being programmed
	if b1 <> 0 then
		toggletimeout = 20
	else
	  if toggletimeout > 0 then 
			dec toggletimeout 
		endif
	endif
  goto waitForCtsPinHigh

ctsPinHigh:
	do until toggletimeout = 0 
	  let b1 = pins & %100 ' C.2 is reply serial from picaxe being programmed
		if b1 <> 0 then
			toggletimeout = 20
		else
		  if toggletimeout > 0 then 
				dec toggletimeout 
			endif	
		endif
	loop
  
waitUntilToggling:
	do 
	  let b0 = pins & %10100 'C.4 is CTS, C.2 is reply serial from picaxe being programmed
	loop until b0 <> %10000

	b0 = b0 & %10000
	if b0 = 0 then 
		 goto ctsPinLow
	endif
	
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

	
  	
	
	
 