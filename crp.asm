[org 0x100]
jmp start

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
ret 4

GCD_AB:

;mov ax, 0; 0 means numbers are not relatively prime

cmp dx, bx
je eq

cmp dx, bx
ja swap



eq:     ;mov ax, 1
        push bx
        call DEC_OUT

; swapping bx and dx so that bx has greater value and dx has smaller one.
swap:   mov cx, bx
        mov bx, dx
        mov dx, cx

; doing  bx = bx mod dx  untill dx = 0
l:      ;push ax
        mov ax, bx ; number to divide goes in AX
        mov bx, dx ; dividing-by (operand)
        div bx     ; perform division. <- WORD division ; Stores integer result in AL and remainder in DX
;swapping bx and dx
        ; mov cx, dx 
        ; mov dx, bx
        ; mov bx, cx

        cmp dx, 0x00
        jne l

        push bx
        call DEC_OUT
ret

DEC_OUT:
        cmp bx, 1
        jne displayNotPrime

        mov  dx, prime      
        mov  ah, 9              ; service 9 – write string               
        int  0x21               ; dos services 

displayNotPrime:
        mov  dx, notPrime     
        mov  ah, 9              ; service 9 – write string               
        int  0x21               ; dos services 
ret

start:

push 20;1st number
push 9;2nd number
call DEC_IN

;23
;45
;DEC_IN call
;bp
;GCD_AB call
;