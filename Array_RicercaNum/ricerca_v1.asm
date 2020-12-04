; Scrivere un sottoprogramma che:
	; riceve in R0 l’indirizzo del primo elemento di un array A di numeri in complemento a due diversi da zero; 
	; la prima occorrenza del valore 0 costituisce il tappo dell’array, cioè ne indica la fine;
	; riceve in R1 un numero N in complemento a due;
	; restituisce la posizione di N partendo da 1. Se il numero N non è
		; presente in A, viene restituito il valore 0.
	

	.orig 	x3000

	lea	r0, array
	ld	r1, n1
	jsr	cercaN

	lea	r0, array
	ld	r1, n2
	jsr	cercaN

	lea	r0, array
	ld	r1, n3
	jsr	cercaN


fine	brnzp	fine



array	.fill 	159
	.fill	237
	.fill 	89
n1	.fill 	-131
	.fill 	51
	.fill 	0

n2	.fill 	101
n3	.fill	237
;*********************************************************************************************
; Input:
	; R0 = indirizzo prima cella
	; R1 = numero da cercare
; Output:
	; R0 = indice N (partendo da 1), se non c'è 0
	; R1 = numero da cercare


cercaN
	st	r1, save1
	st	r2, save2
	st 	r3, save3

	and	r3, r3, #0		; azzero r3 che sarà contatore
	not	r1, r1			; numero che cerco negativo (per confronto)
	add	r1, r1, #1
ciclo
	ldr	r2, r0, #0		; r2 = valore puntato
	brz	notFound		; se il valore è 0 esco

   ; r2!=0
	add	r3, r3, #1		; contatore++

   ; confronto r2 con r1
	add	r2, r2, r1
	brz	esci			; se zero è quello che cercavo

   ; altrimenti
	add	r0, r0, #1		; puntatore++
	brnp	ciclo


esci	; inizializzo registri e ritorno al programma
	add	r0, r3, #0		; r0 = contatore
	brnzp	ripristino

notFound
	and 	r0, r0, #0		; r0 = 0 (nessun risultato trovato)
	; va a ripristino

ripristino
	ld	r1, save1
	ld	r2, save2
	ld 	r3, save3
	ret


save1	.blkw	1
save2	.blkw	1
save3	.blkw	1
;*********************************************************************************************

	.end