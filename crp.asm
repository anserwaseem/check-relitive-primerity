[org 0x100]
jmp start

GCD_message: db	10, 13, '  GCD = $'
GCD:         db	10, 13, '  $'
prime:       db	10, 13, 'Numbers are relatively prime $'
notPrime:    db	10, 13, 'Numbers are not relatively prime $' 

DEC_IN:
        push bp
        mov bp, sp
        pusha

        mov bx, [bp+6];1st number
        mov dx, [bp+4];2nd number

        call GCD_AB

        popa
        pop bp
        ret 4

GCD_AB:
        cmp dx, bx
        je eq

        cmp dx, bx
        ja swap
        jmp l


eq:     push bx
        call DEC_OUT
        jmp exitGCD_AB

; swapping bx and dx so that bx has greater value and dx has smaller one.
swap:   mov cx, bx
        mov bx, dx
        mov dx, cx

; doing  bx = bx mod dx  untill dx = 0
l:      mov ax, bx      ; dividend in AX;20
        mov bx, dx      ; divisor in BX;9
        xor dx, dx      ; remainder
        div bx          ; perform division. <- WORD division ; Stores integer result in AL and remainder in DX

        cmp dx, 0x00
        jne l

        push bx
        call DEC_OUT

exitGCD_AB:     ret


DEC_OUT:
        cmp bx, 1
        jne displayNotPrime

; clearing the screen
        mov ax, 0xb800 		; load video base in ax
		mov es, ax 			; point es to video base
		xor di, di 			; point di to top left column
        mov ax, 0x0720      ; space char in normal attribute
        mov cx, 2000        ; number of screen locations
        cld                 ; auto increment mode
        rep stosw           ; clear the whole screen

; printing GCD =
        mov  dx, GCD_message     
        mov  ah, 9          ; service 9 – write string               
        int  0x21           ; dos services 

; printing the value of GCD        
        add bx, 30h         ; adding 30h in ascii
        mov si, GCD         ; pointing si to GCD string
        mov [si], bl        ; inserting value of bl at the start of GCD string
        mov  dl, GCD        
        mov  ah, 9          ; service 9 – write string               
        int  0x21           ; dos services 
; printing Numbers are relatively prime
        mov  dx, prime      
        mov  ah, 9          ; service 9 – write string               
        int  0x21           ; dos services 

        jmp exitDEC_OUT

displayNotPrime:
; printing Numbers are not relatively prime
        mov  dx, notPrime       
        mov  ah, 9          ; service 9 – write string               
        int  0x21           ; dos services 

exitDEC_OUT:    ret


start:

push 12;1st number
push 93;2nd number
call DEC_IN

mov ax, 0x4c00 ; terminate program
int 0x21