org 0x7c00 ;origin 




_start:
   call setVideoMode
   call changeColorPallete
   mov si, testStr
   call print

   jmp $



changeColorPallete:
   mov ah, 0x0B
   mov bh, 0x00
   mov bl, 0x04
   int 0x10
   ret



; include the print string routine
include 'printString.asm'


testStr: db 'Test Test Test',0

setVideoMode:
   mov ah, 0x00
   mov al, 0x03
   int 0x10
   ret



times 510 - ($ - $$) db 0 ; pad everything with 0s

dw 0xAA55 ;last 2 bytes 
