;print a hex string
;can only print ASCII chars
;so we have to make our hex into ASCII
;for example 0x12AB will be ASCII 0x12AB


printHex:
    pusha
	mov cx, 0 ;initialize loop counter
hexLoop:
    cmp cx, 4 ;check for end of loop
	je endHexLoop

	;convertToAscii
	mov ax, dx
	and ax, 0x000F   ;convert all nums to 0 and keep last one
	add al, 0x30     ;add 0x30 to get ascii value
	cmp al, 0x39     ;check if less than 0x39 -> 0-9 or greater than 0x39 -> A-F
	jle moveIntoBx
	add al, 0x7     ;to get A to F

moveIntoBx:
    mov bx, hexString + 5 ;base address of hex string + length of string
	sub bx, cx            ;subtract loop counter
	mov [bx], al
	ror dx, 4             ; rotate right 4 bits
	add cx, 1             ; increment counter
	jmp hexLoop

endHexLoop:
	mov si, hexStringText
	call printString
    mov si, hexString
	call printString
	popa 
	ret


hexStringText: db 'Hex Number: ',0
hexString: db '0x0000',0xA, 0xD,0

