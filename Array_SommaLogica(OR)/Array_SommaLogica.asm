; Sviluppare sottoprogramma che in R0 ha il primo indirizzo di un array che termina con una stringa di 16 zeri
; In R1 ha una stringa a 16bit, deve eseguirel'OR tra gli elementi dell'array e la stringa in R1

; a NOT(OR) b = aNeg AND bNeg

	.orig	x3000

	lea	r0, array
	ld	r1, var1
	jsr	OR_ARRAY

stop	brnzp	stop

array	.fill	b1111000011110000
	.fill	b0000111100001111
	.fill	0

var1	.fill	b0101010101010101


;***********************************************************************
; INPUT:
 	; r0 = puntatore
 	; r1 = elemento

OR_ARRAY
	st	r2, save2
	not	r1, r1		; NOT(a) non devo cambiare segno in complemento a 2 aggiungendo 1, 
					; sto lavorando con operatori booleani

loop	
	ldr	r2, r0, #0	; R2 = array[i]
	brz	fine		; se leggo zeri esco dal ciclo (condizione iniziale)
	not 	r2, r2		; NOT(b)
	and	r2, r1, r2	; NOT(a) AND NOT(b) = NOT(a OR b)
	not	r2, r2
	str	r2, r0, #0	; salvo r2 nella cella di indirizzo contenuto in r0
	add	r0, r0, #1
	brnzp	loop

fine	
	ld	r2, save2
	ret
	

save2	.blkw	1

;***********************************************************************

	.end