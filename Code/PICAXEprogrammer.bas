' This program is used to add a serial break before transmission
' It is used to compensate for a USB to serial cable that does not
'   properly send a serial break
'  (The PICAXE programming requires a serial break to initiate programming)
' How it works:
' The TX from the PC is connected to hserin C.1 via an inverter (hserin can only do T = idle high).
' hserout C.0 is connected to the serin of the PICAXE to be programmed.
' The serout of the PICAXE to be programmed is connected directly to the RX to the PC and also to C.2
' 
' Step by step:
' 1) Connect PC to PICAXEprogrammer and PICAXEprogrammer to the PICAXE to be programmed
' 2) Power up the PICAXEprogrammer
' 2a) Optional: Power up the PICAXE to be programmed, if it doesn't use the disconnect command
' 3) Start the program download.  The PICAXEprogrammer will start sending a break.
' 3a) Optional: if the PICAXE to be programmed isn't already on, turn it on now
' 4) Once the PICAXEprogrammer detects a reply from the PICAXE being programmed, it stops sending break and will pass through
'    the transmission from the PC to the PICAXE.
' 5) Once the programming is finished, the PICAXEprogrammer will start idling again.
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

symbol breakJumper = pinC.3 ' if jumper is not installed (bridge to ground) then insert serial break, otherwise don't.
symbol picaxeReply = pinC.2	' 
symbol sendingbreak = b0
symbol byteRX = w1
symbol byteRXlsb = b2
symbol lasttime = w2
symbol delta = w3
symbol programdetected = w4
symbol waittime = w5
symbol toggletimeout = b12


'algorithm is:
' a) Starting conditions: CTS is low
' b) Keep serout low
' c) As soon as CTS goes high:
'    i) perform a break for 3 ms then wait until the picaxe reply goes high
'    ii) drop the break and start passing through
' d) Once CTS goes low, stop passing through and return to a)
' If pin C.3 is low (jumper installed) stay in passthrough only

ctsPinLow:

	HSERSETUP B4800_4, %01010 ' HSEROUT_N_POLARITY | HSERIN_T_POLARITY | HSEROUT_OFF 
	low hseroutPin
  hserin byteRX             ; clear the buffer if anything still in there
	hserin byteRX             ; clear the buffer if anything still in there
	
waitForCtsPinHigh:
	do 
		let b0 = pins & %11000 'C.4 is CTS, C.3 is passthrough mode
	loop until b0 <> %01000		' until C.4 high or C.3 low
  b0 = b0 & %01000
	if b0 = 0 then passthroughOnly

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
	b0 = b0 & %11000
	do 
	  byteRX = $FFFF            ; set up a non-valid value
	  hserin byteRX             ; receive 1 byte into w1
		if byteRX <> $FFFF then 
		  hserout 0, (byteRXlsb) ' lsb of w1
	  else
		  b0 = pins & %11000
		end if	
	loop until b0 <> %11000			; until C.4 low or C.3 low
	
	goto ctsPinLow

passthroughOnly:
	low hseroutPin
  HSERSETUP B4800_4, %00010 'HSEROUT_N_POLARITY | HSERIN_T_POLARITY | HSEROUT_ON
	b0 = b0 & %01000			; C.3 low is passthrough mode
	do 
	  byteRX = $FFFF            ; set up a non-valid value
	  hserin byteRX             ; receive 1 byte into w1
		if byteRX <> $FFFF then 
		  hserout 0, (byteRXlsb) ' lsb of w1
	  else
		  b0 = pins & %01000
		end if	
	loop until b0 <> 0
	
	goto ctsPinLow

	
  	
	
	
 