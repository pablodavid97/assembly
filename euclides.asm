;
; euclides.asm
;
; Author : Pablo
;

.include "m328P.inc"

.org 0x0000

start:
	; carga los valores iniciales
	ldi r16, 0xFF    
	out DDRB, r16  	
	ldi r17, 5 ; a
	ldi r18, 25 ; b
	ldi r19, 0; zero

	call euclides

euclides:
	mov r20, r17
	cp r17, r18
	breq loop

	cp r17,r18
	brge greater

	cp r17, r18
	brlt less 

greater:
	sub r17, r18
	jmp euclides

less:
	sub r18, r17
	jmp euclides

loop:
	sbi	PORTB, 5		 
	rcall	delay_05
	cbi	PORTB, 5		 
	rcall	delay_05
	dec r20

	cp r20, r19
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
