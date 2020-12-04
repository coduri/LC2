; Scrivere un sottoprogramma che:
; Riceve in r0 l'indirizzo del primo elemento di un array di numeri in modulo e segno ( zero è il tappo dell'array)
; Restituisce in r0 il risultato IN MODULO E SEGNO della sommatoria di tutti i numeri dell'array (trascurare eventuale overflow)

	.orig	x3000


	lea	r0, array
	jsr	sommarms
stop	brnzp	stop


; numeri in modulo e segno
array	.fill	b0000000000001100		; +12
	.fill	b1000000000001101		; -13
	.fill	0

;**************************** Somma Array Modulo e Segno ****************************
sommarms
	st	r7, sr7		; ho salvato in r7 il primo indirizzo di ritorno, quindi no problem
	st	r1, sr1
	st	r2, sr2

	and	r1, r0,r0	; r1 = r0 (r0 and r0)	R1 -> puntatore ad array
	and	r2, r2, #0	; r2 = 0 		R2 -> risultato sommatoria

ciclo	ldr	r0, r1, #0	; r0 = array[i]
	brz 	fine		; se zero ho fintio di scorrere l'array

   ; modulo e segno != 0
	jsr	MStoC2
	add	r2, r2, r0	; qui r0 sarà convertito
	add	r1, r1, #1	; i++
	brnzp 	ciclo

fine	add	r2, r2, #0	; aggiorno cc
	brzp	torna

   ; qui sommatoria negativa, devo farla diventare in modulo e segno
	not 	r2, r2
	add	r2, r2, #1	; R2 = modulo della sommatoria
	ld	r1, segnoNeg
   	add	r2,r2,r1
   ; risultato in modulo e segno

torna	add	r0, r2, #0
	ld	r7, sr7
	ld	r1, sr1
	ld	r2, sr2
	ret

segnoNeg .fill 	b1000000000000000
sr1	.blkw	1
sr2	.blkw	1
sr7	.blkw	1
;************************************************************************************




;**************************** CONVERTITORE ****************************

MStoC2
	and	r0, r0, r0
	brn 	conv
	ret

conv 
		st 		r1, saver1
		ld		r1, msb
		and		r0, r0, r1	; gli tolgo il bit significativo e il resto è il numero stesso
		not 	r0, r0
		add		r0, r0, 1
		ld		r1, saver1
		ret

msb	.fill	b0111111111111111
saver1	.blkw	1
;**********************************************************************
	.end