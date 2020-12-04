; Scrivere un sottoprogramma che:
	; - Riceve in r0 un numero in modulo e segno
	; - Restituisce in r0 il complemento a due 

	.orig	x3000

	ld	r0, n1
	JSR MStoC2

	ld	r0, n2
	JSR MStoC2

	ld	r0, n3
	JSR MStoC2

	ld	r0, n4
	JSR MStoC2
stop	brnzp	stop



; numeri in modulo e segno che caricherò
n1	.fill	b0000000000001100		; +12
n2	.fill	b1000000000001100		; -12 che in complemento a due sarà un altro numero
n3	.fill	b0000000000000000		; +0
n4	.fill	b1000000000000000		; -0

;**************************** CONVERTITORE ****************************
; Se il numero ha il primo bit a 0 la codifica coincide
; La codifica è diversa per i numeri negativi, ma si tratta sempre di avere, in entrambi i casi, il primo bit a 1 (con gli altri bit codificati diversamente)

MStoC2
	and	r0, r0, r0		; verifico segno di r0
	brn 	conv				; se positivo o nullo la conversione non cambia
	ret

 	; anche nel caso dello zero posso farlo (non è necessario gestirlo diversamente)
		; modulo e segno ha due zeri e il complemento a 2 ha un negativo in più = no rischio overflow

    ; numero negativo in modulo e segno
conv
		st 		r1, sr1		; non altero i valori
		ld		r1, msb
		and		r0, r0, r1	; gli tolgo il bit significativo = ottengo il modulo
		not 		r0, r0
		add		r0, r0, 1	; ho reso il modulo negativo
		ld		r1, sr1
		ret

msb	.fill	b0111111111111111
sr1	.blkw	1
;**********************************************************************
	.end