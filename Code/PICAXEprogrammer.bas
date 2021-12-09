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
' Jumper installed = insert serial break
' Jumper not installed = passthrough only (do not insert a break)

symbol HSEROUT_N_POLARITY = %00010
symbol HSERIN_T_POLARITY = %00000
symbol HSEROUT_OFF = %01000
symbol HSEROUT_ON = %00000

symbol ENDBREAK_DELAY_MS = 1 '4800 baud -> 1ms ~ 5 bits
symbol IDLE_TIME_BEFORE_BREAK_S = 5 ' the serial break will be reestablished after this length of idle time

symbol hseroutPin = C.0

symbol breakJumper = pinC.3 ' if jumper is installed (bridge to ground) then insert serial break, otherwise don't.

symbol sendingbreak = b0
symbol byteRX = w1
symbol byteRXlsb = b2
symbol lasttime = w2
symbol delta = w3
symbol stopbreak = w4

'pullup %00001000	' enable pullup on pinC.3

serialbreak:
  HSERSETUP B4800_4, %01010 ' HSEROUT_N_POLARITY | HSERIN_T_POLARITY | HSEROUT_OFF 
  high hseroutPin

	do 
	  byteRX = $FFFF            ; set up a non-valid value
	  hserin byteRX             ; receive 1 byte into w1
		
		if byteRX <> $FFFF then 'or breakJumper = 1 then
			stopbreak = 1
		else
		  stopbreak = 0
		endif
	loop until stopbreak = 1
		
receiving:		
	low hseroutPin
	pause ENDBREAK_DELAY_MS
  HSERSETUP B4800_4, %00010 'HSEROUT_N_POLARITY | HSERIN_T_POLARITY | HSEROUT_ON

passingthrough:
  hserout 0, (byteRXlsb) ' lsb of w1
	lasttime = time
	
waitnext:
  byteRX = $FFFF            ; set up a non-valid value
	hserin byteRX             ; receive 1 byte into w1
	if byteRX = $FFFF then
		delta = time - lasttime
		if delta > IDLE_TIME_BEFORE_BREAK_S then 'and breakJumper = 0 then
			goto serialbreak		
		end if	
	  goto waitnext
  end if	

	goto passingthrough

	
  	
	
	
 