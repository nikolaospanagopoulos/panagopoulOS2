org 0x7c00 ;origin 




_start:
    mov bx, 0x1000              ; load sector to memory address 0x1000 
    mov es, bx                  
    mov bx, 0x0                 ; ES:BX = 0x1000:0x0

    ;; Set up disk read
    mov dh, 0x0                 ; head 0
    mov dl, 0x0                 ; drive 0
    mov ch, 0x0                 ; cylinder 0
    mov cl, 0x02                ; starting sector to read from disk










read_disk:
    mov ah, 0x02                ; BIOS int 13h/ah=2 read disk sectors
    mov al, 0x01                ; # of sectors to read
    int 0x13                    ; BIOS interrupts for disk functions

    jc read_disk                ; retry if disk read error (carry flag set/ = 1)

    ;; reset segment registers for RAM
    mov ax, 0x1000
    mov ds, ax                  ; data segment
    mov es, ax                  ; extra segment
    mov fs, ax                  ; ""
    mov gs, ax                  ; ""
    mov ss, ax                  ; stack segment

    jmp 0x1000:0x0              ; never return from this!



times 510 - ($ - $$) db 0 ; pad everything with 0s

dw 0xAA55 ;last 2 bytes 
