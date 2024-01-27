; print String routine


print:
	pusha
    mov bx, 0
.loop:
    lodsb
    cmp al, 0
    je .done
    call printChar
    jmp .loop
.done:
	ret
	popa

printChar:
    mov ah, 0eh
    int 0x10
	ret

    
