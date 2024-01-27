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



print:
    mov bx, 0
.loop:
    lodsb
    cmp al, 0
    je .done
    call printChar
    jmp .loop
.done:
    ret

printChar:
    mov ah, 0eh
    int 0x10
    ret



testStr: db 'Test Test Test',0

setVideoMode:
   mov ah, 0x00
   mov al, 0x03
   int 0x10
   ret



times 510 - ($ - $$) db 0 ; pad everything with 0s

dw 0xAA55 ;last 2 bytes 
