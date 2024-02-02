kernel:
   call setVideoMode
   call changeColorPallete
   mov si, testStr
   call printString
   call readUserKey



   jmp $



setVideoMode:
   mov ah, 0x00
   mov al, 0x03
   int 0x10
   ret

changeColorPallete:
   mov ah, 0x0B
   mov bh, 0x00 ;1 pallete, 0 background
   mov bl, 0x04 ;color value
   int 0x10
   ret

;to print hex, move into dx the hex string
;include the print string routine
include 'printString.asm'
;include the print hex routine
include 'printHex.asm'


getInput:
  mov di, cmdString

readUserKey:
  mov ah, 0x00
  int 16h

  mov ah, 0eh
  cmp al, 0xD
  je runCmd
  int 10h
  mov [di], al
  inc di
  jmp readUserKey

runCmd:
  mov byte [di] , 0
  mov al, [cmdString]
  cmp al, 'A'
  je successFunc
  cmp al, 'N'
  je endProgram
  jmp notFound

notFound:
  mov si, failure
  call printString
  jmp getInput

endProgram:
  cli
  hlt

successFunc:
  mov si, success
  call printString
  jmp getInput
  ret


testStr: db 'Welcome to PanagopoulOs', 0xA, 0xD, '----------------------------------------------------------------------', 0xA, 0xD, 0xA, 0xD, 'A) File Program Browser', 0xA, 0xD, 0
success:        db 0xA, 0xD, 'Command ran successfully!', 0xA, 0xD, 0
failure:        db 0xA, 0xD, 'Oops! Something went wrong :(', 0xA, 0xD, 0
cmdString:      db ''

printFail:
   mov si, testtesttest
   call printString
   hlt
testtesttest: db 'pidaras', 0
test2: db 'success', 0

times 512-($-$$) db 0
