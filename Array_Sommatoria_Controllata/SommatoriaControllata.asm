; Input:
;	R0: indirizzo cella di un array che termina con uno zero

; OUTPUT:
;	R0:	
		; -2 se underflow
		; -1 se risultato negativo
		; 0 se risultato nullo
		; 1 se risultato positivo
		; 2 se overflow

;********* PROGRAMMA NON TESTATO!!! *********

SOMMATORIA
	st 	r1, save1
	st 	r2, save2
	and	r2, r2, #0

loop
	ldr	r1, r0, #0		; r1 = array[i]
	brz fineArray
	brp	pos

	; r1 negativo
	add	r2, r2, #0		; aggiorno CC
	brzp noProblem

	; r2 neg -> possibilità underflow
	add	r2, r2, r1		; r2 += array[i]
	brn sommaFatta		; r1 neg, r2 neg, ris neg

	; si è verificato underflow
	and	r0, r0, #0
	add	r0, r0, #-2
	brnzp 	fine


; r1 positivo
pos 
	add	r2, r2, #0		; aggiorno CC
	brnz noProblem

	; r2, pos -> possibilità di overflow
	add	r2, r2, r1		; r2 += array[i]
	brp 	sommaFatta		; r1 pos, r2 pos, ris pos

	; si è verificato overflow
	and	r0, r0, #0
	add	r0, r0, #2
	brnzp 	fine


noProblem
	add	r2, r2, r1
sommaFatta
	add 	r0, r0, #1		; punt++
	brnzp 	loop


fineArray
	and	r0, r0, #0
	add	r2, r2, #0		; aggiorno CC
	brp 	scrivi1
	brz 	fine 			; c'è già scritto zero
	; negativo
	add	r0, r0, #-1
	brnzp	fine


scrivi1
	add	r0, r0, #1

fine
	ld 	r1, save1
	ld 	r2, save2
	ret
	
save1	.blkw	1
save2	.blkw	1
