printRegisters:
  
  mov si, regString
  call printString
  call printHex

  mov byte [regString + 2], 'a'
  call printString
  mov dx, ax
  call printHex

  mov byte [regString + 2], 'b'
  call printString
  mov dx, bx
  call printHex

  mov byte [regString + 2], 'c'
  call printString
  mov dx, cx
  call printHex

  mov word [regString + 2], 'si'
  call printString
  mov dx, si
  call printHex

  mov byte [regString + 2], 'd'
  call printString
  mov dx, di
  call printHex

  mov word [regString + 2], 'cs'
  call printString
  mov dx, cs
  call printHex

  mov byte [regString + 2], 'd'
  call printString
  mov dx, ds
  call printHex

  mov byte [regString + 2], 'e'
  call printString
  mov dx, es
  call printHex

  ret



regString: db 0xA, 0xD, 'dx              ',0




