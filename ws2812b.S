#include <avr/io.h>

#define __SFR_OFFSET 0

BYTE_REG = 18
BIT_COUNTER = 19
BYTE_COUNTER_L = 28
BYTE_COUNTER_H = 29

.equ PORT, PORTB				; change pin and port here
.equ PIN, 2

	.global setup_pin
setup_pin:
	in r18, DDRB				; setup pin output
	ori r18, (1 << PIN)
	out DDRB, r18	
	ret

	.global update_leds
update_leds:					; getting parameters and setting up registers
	cli							; turning off interrupts 
	mov XH, r25					; pointer to array of values 
	mov XL, r24

	mov BYTE_COUNTER_H, r23		; length of array r23 r22
	mov BYTE_COUNTER_L, r22

send_bytes:
	ldi BIT_COUNTER, 8
	ld BYTE_REG, X+
start:					; one  zero
						; 0 	0
	sbi PORT, PIN		; 2		2
	dec BIT_COUNTER		; 3		3
	nop					; 4		4
	sbrs BYTE_REG, 7	; 6		5
	cbi PORT, PIN		; -		7
	breq next_byte		; 7		8
	nop					; 8		9
	nop					; 9		10
	nop					; 10	11
	nop					; 11	12
	nop					; 12	13
	sbrc BYTE_REG, 7	; 13	15
	cbi PORT, PIN		; 15	-
	lsl BYTE_REG 		; 16	16
	nop					; 17	17
	nop 				; 18	18
	rjmp start			; 20	20

next_byte:				; 8		9
	cpi BYTE_REG, 0x80	; 9		10	check if last bit is high
	ldi BIT_COUNTER, 8	; 11	12
	ld  BYTE_REG, X+	; 12	13
	brne skip_clear		; 13	15	skip clearing pin if last bit is low
	cbi PORT, PIN		; 15	-	clear pin 
skip_clear:
	sbiw r28, 1			; 17	17
	breq end			; 18	18
	rjmp start			; 20	20
end:
	sei					; turning on interrupts
	ret					; returning from subroutine

