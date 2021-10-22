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
 
 With some deft timing this can be done manually - start a download, briefly short the serial input to 5V and with a 
 bit of luck the download will work.
 
Alternatively you can use a PICAXE "SerialFixer" to add a serial break:
1. The SerialFixer is connected between the USB-to-serial adapter and the PICAXE being programmed 
2. When idle, the SerialFixer sends a high output to the serial input of the PICAXE being programmed.  This causes
    the picaxe to enter programming mode and to start sending its signature block.
3. When programming starts, the SerialFixer detects the transmission from the USB-to-serial adapter and then
  a. briefly (~ 4 bits) sends a low output to the PICAXE being programmed, then
  b. passes the serial transmission from the programmer directly to the PICAXE being programmed (with a short buffer
      delay to account for the 4 bits added at the end of the serial break)
      
When transmission has stopped for 5 seconds, the SerialFixer re-enters the idle state.

