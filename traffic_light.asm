;
; Traffic_Light.asm
;
; Created: 4/24/2018 8:38:45 PM
; Author : Pablo
;

.org	0x0000			 
.include "m328P.inc"
rjmp	main			; State that the program begins at the main label

main:
	ldi	r16, 0xFF		
	out	DDRD, r16		; Set Data Direction Register D to output for all pins
	ldi r17, 3 ; situations
	ldi r18, 0 ; i

loop:
	cpi r18, 0
	breq case1

	cpi r18, 1
	breq case2

	cpi r18, 2
	breq case3

	cpi r18, 3
	breq case4

switch_end: 

	inc r18
	cp r18, r17
	breq reset

	rjmp	loop			; Loop again

reset:
	jmp loop

case1:
	rcall activateTrafficLight1_red
	rcall deactivateTrafficLight1_yellow
	rcall deactivateTrafficLight1_green

	rcall deactivateTrafficLight2_red
	rcall deactivateTrafficLight2_yellow
	rcall activateTrafficLight2_green

	rcall delay_02

	jmp switch_end

case2:
	rcall activateTrafficLight1_red
	rcall deactivateTrafficLight1_yellow
	rcall deactivateTrafficLight1_green

	rcall deactivateTrafficLight2_red
	rcall activateTrafficLight2_yellow
	rcall activateTrafficLight2_green

	rcall delay_03

	jmp switch_end

case3:
	rcall deactivateTrafficLight1_red
	rcall deactivateTrafficLight1_yellow
	rcall activateTrafficLight1_green

	rcall activateTrafficLight2_red
	rcall deactivateTrafficLight2_yellow
	rcall deactivateTrafficLight2_green

	rcall delay_02

	jmp switch_end

case4:
	rcall deactivateTrafficLight1_red
	rcall activateTrafficLight1_yellow
	rcall activateTrafficLight1_green

	rcall activateTrafficLight2_red
	rcall deactivateTrafficLight2_yellow
	rcall deactivateTrafficLight2_green

	rcall delay_02

	jmp switch_end

activateTrafficLight1_red:
	sbi	PORTD, 2
	ret

activateTrafficLight1_yellow:
	sbi	PORTD, 3
	ret

activateTrafficLight1_green:
	sbi	PORTD, 4
	ret

deactivateTrafficLight1_red:
	cbi	PORTD, 2
	ret

deactivateTrafficLight1_yellow:
	cbi	PORTD, 3
	ret

deactivateTrafficLight1_green:
	cbi	PORTD, 4
	ret

activateTrafficLight2_red:
	sbi	PORTD, 5
	ret

activateTrafficLight2_yellow:
	sbi	PORTD, 6
	ret

activateTrafficLight2_green:
	sbi	PORTD, 7
	ret

deactivateTrafficLight2_red:
	cbi	PORTD, 5
	ret

deactivateTrafficLight2_yellow:
	cbi	PORTD, 6
	ret

deactivateTrafficLight2_green:
	cbi	PORTD, 7
	ret

delay_02:
	ldi	r16, 80
	jmp outer_loop

delay_03:
	ldi	r16, 30
	jmp outer_loop

delay_04:
	ldi	r16, 100
	jmp outer_loop

outer_loop:
	ldi	r24, (3037 & 0xFF)
	ldi	r25, (3037 >> 8)

delay_loop:
	adiw	r24, 1
	brne	delay_loop
	dec	r16
	brne	outer_loop
	ret