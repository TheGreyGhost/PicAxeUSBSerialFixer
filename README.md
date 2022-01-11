# PicAxeUSBSerialFixer
 Circuit to program the PICaxe using a standard USB to Serial converter.
 
 The PICAxe requires a particular download USB-to-serial cable (https://picaxe.com/hardware/cables/picaxe-usb-download-cable)
 
 If (like me) you already have another USB-to-serial adapter, you will probably find that it does not work properly - 
 program downloads won't start.
 
 The reason is that the PICAXE requires a Serial Break signal in order to start communicating with the programmer.
 A Serial Break is where the PICAXE serial input is set to high for longer than a single frame (~ 12 bits)
 A normal serial byte has a start bit (high), 8 bits of data (high or low), then several stop bits.
 
 When the PICAXE detects that the serial input has been high for longer than a frame, it enters a program ready mode:
 While the input is held high, every second or it sends a signature block on the serial output (chip type and 
 other information) and waits for further transmission.
 
 Some USB-to-serial adapters don't send a serial break, so the PICAXE never enters programming mode.
 
 With some deft timing and patience this can be done manually - start a download, briefly short the serial input to 5V with a 10k resistor and with a 
 bit of luck the download will work.  Unless your PICAXE needs all five pins and hence uses the disconnect command, in which case it is a real pain in butt.
 
Alternatively you can use a PICAXE "SerialFixer" to add a serial break:
Step by step:
 1) Connect PC to PICAXEprogrammer and PICAXEprogrammer to the PICAXE to be programmed
 2) Power up the PICAXEprogrammer
 2a) Optional: Power up the PICAXE to be programmed, if it doesn't use the disconnect command
 3) Start the program download.  The PICAXEprogrammer will start sending a break.
 3a) Optional: if the PICAXE to be programmed isn't already on, turn it on now
 4) Once the PICAXEprogrammer detects a reply from the PICAXE being programmed, it stops sending break and will pass through
    the transmission from the PC to the PICAXE.
 5) Once the programming is finished, the PICAXEprogrammer will start idling again.

It's not 100% reliable- you may need to try the download a couple of times, but in my experience most of the time it will work first attempt.      

The jumper on the SerialFixer board can be used to disable the break, i.e.:
Jumper not installed = insert serial break
Jumper installed = passthrough only (do not insert a break)

## Footnote
You might be asking yourself why I went to all this trouble?

I'd have to have rocks in my head given that the official AXE027 cable (https://picaxe.com/hardware/cables/picaxe-usb-download-cable/) costs a lot less
than the time and effort to build this circuit!

Unless, of course, COVID-19 had pushed out the estimated delivery time to 3 months...





