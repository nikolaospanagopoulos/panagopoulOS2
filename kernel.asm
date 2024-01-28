kernel:
   call setVideoMode
   call changeColorPallete
   mov si, testStr
   call printString
   mov dx, 0x12AB              ; sample hex number to print
   call printHex
   jmp $



setVideoMode:
   mov ah, 0x00
   mov al, 0x03
   int 0x10
   ret

changeColorPallete:
   mov ah, 0x0B
   mov bh, 0x00
   mov bl, 0x04
   int 0x10
   ret


;include the print string routine
include 'printString.asm'
;include the print hex routine
include 'printHex.asm'


testStr: db 'Welcome to PanagopoulOs', 0xA, 0xD, 0
