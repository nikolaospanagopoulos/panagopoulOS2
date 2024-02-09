kernel:
mainMenu:
   call setVideoMode
   call changeColorPallete
   mov si, testStr
   call printString
   call getInput


   jmp $




include './screenAsm/videoMode.asm'
;to print hex, move into dx the hex string
;include the print string routine
include 'printString.asm'
;include the print hex routine
include 'printHex.asm'

include './printRegisters.asm'

reboot: ;warm reboot option
  jmp 0xFFFF:0x0000 ;reset vector
   

getInput:
  xor di, di  
  mov di, cmdString

readUserKey:
  mov ax, 0x00
  int 0x16

  cmp al, 0xD
  je runCmd
  mov ah, 0x0e
  int 0x10
  mov [di], al
  inc di
  jmp readUserKey

runCmd:
  mov byte [di] , 0
  mov al, [cmdString]
  cmp al, 'A'
  je fileBrowser
  cmp al, 'P'
  je printRegistersVal
  cmp al, 'R'
  je reboot
  cmp al, 'N'
  je endProgram
  jmp notFound

notFound:
  mov si, failure
  call printString
  jmp getInput
  ret

endProgram:
  cli
  hlt


printRegistersVal:
  call setVideoMode
  call changeColorPallete

  mov si, registersPringHeading
  call printString

  call printRegisters



  mov si, goBackStr
  call printString

  mov ah, 0x00
  int 0x16
  jmp mainMenu



fileBrowser:
  call setVideoMode
  call changeColorPallete

  mov si, filetableHeading
  call printString

  ;load file table from it's memory location
  ;reset counter for chars
  xor cx, cx
  mov ax, 0x1000 ;file table location
  mov es, ax
  xor bx, bx
  mov ah, 0eh

filetableLoop:
  inc bx ;increment bx
  mov al, [ES:BX] ;to al move memory position of file table
  cmp al, '}' ;end of filetable
  je stop
  cmp al,'-' ;we are at sector number of element
  je sectorNumberLoop
  cmp al, ','
  je nextElement
  inc cx
  int 0x10
  jmp filetableLoop

sectorNumberLoop:
  cmp cx, 21
  je filetableLoop
  mov al, ' ' ;pad with spaces
  int 0x10
  inc cx
  jmp sectorNumberLoop

nextElement:
  xor cx, cx ;reset counter to 0 again to print next element
  mov al, 0xA
  int 0x10
  mov al, 0xD
  int 0x10
  mov al, 0xA
  int 0x10
  mov al, 0xD
  int 0x10
  jmp filetableLoop

stop:
  mov si, goBackStr
  call printString
  mov ah, 0x00
  int 0x16
  jmp mainMenu
  ret
filetableHeading: db 'fileName           fileSector', 0xA, 0xD ,\
                     '--------           ----------', 0xA, 0xD, 0


testStr: db 'Welcome to PanagopoulOs', 0xA, 0xD, '----------------------------------------------------------------------', 0xA, 0xD, 0xA, 0xD, 'A) File Program Browser', 0xA, 0xD, 'N) End Program',0xA, 0xD, 'R) Reboot',0xA,0xD, 'P) Print Registers',0xA,0xD,0
success:        db 0xA, 0xD, 'Command ran successfully!', 0xA, 0xD, 0
failure:        db 0xA, 0xD, 'Oops! Something went wrong :(', 0xA, 0xD, 0
goBackStr:      db 0xA,0xD,0xA, 0xD, 'Press any key to go back', 0xA, 0xD, 0
registersPringHeading: db 0xA, 0xD, 0xA, 0xD, 'Register        Memory location',0xA,0xD,0
cmdString:      db ''




times 1024-($-$$) db 0
