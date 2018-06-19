;
; factorial.asm
;
; Author : Pablo
;

.include "m328P.inc"
.org 0x0000
        
start:        
	; carga los valores iniciales 
	ldi r16, 0xFF    
	out DDRB, r16    
	ldi r17, 3 ; factorial    
	ldi r18, 1 ; n
	ldi r19, 1 ; condicion 
	ldi r20, 0 ; zero    
	
	call factorial
                
factorial:
	mov r21, r18      
	cp r17, r19
    breq loop

    mul r18, r17 ; n * n - 1
    mov r18, r0
    dec r17

    jmp factorial

loop:
	sbi	PORTB, 5		 
	rcall	delay_05
	cbi	PORTB, 5		 
	rcall	delay_05
	dec r21

	cp r21, r20
	breq end

	rjmp loop

delay_05:
	ldi	r16, 58

outer_loop:
	ldi	r24, (3037 & 0xFF)
	ldi	r25, (3037 >> 8)

delay_loop:
	adiw	r24, 1
	brne	delay_loop
	dec	r16
	brne	outer_loop
	ret      
	      
end:
	rjmp end

.end
