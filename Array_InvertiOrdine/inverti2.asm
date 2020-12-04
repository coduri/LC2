; Scrivere un sottoprogramma che:
	; riceve in R0 l’indirizzo del primo elemento di un array di numeri in complemento a due, ordinati per valori crescenti;
	; riceve in R1 l’indirizzo dell’ultimo elemento dell’array;
	; restituisce l’array con i numeri ordinati per valori decrescenti.



	.orig 	x3000

	lea	r0, aInizio		; indirizzo cella 1
	lea	r1, aFine		; indirizzo ultima cella		
	jsr	ordina

exit	brnzp	exit			; evito che la cpu prosegua



aInizio	.fill 	2
	.fill	6
	.fill 	8
	.fill 	20
	.fill 	26
aFine	.fill 	39

;*********************************************************************************************
; Input:
	; R0 = indirizzo prima cella
	; R1 = indirizzo ultima cella
; Output:
	; R0 = indirizzo prima cella
	; R1 = indirizzo ultima cella
	; Svolge lavoro su memoria invertendo le posizioni


ordina
	st	r2, sr2		; salvo r2
	st	r3, sr3		; salvo r3

ciclo	ldr	r2, r0,#0	; r2 = contenuto di r0 (primo +i)
	ldr	r3, r1,#0	; r3 = contenuto di r1 (ultimo -i)

	str	r2, r1, #0	; prendo r2 e lo salvo nella cella di "indirizzo r1"
	str	r3, r0, #0	; prendo r3 e lo salvo nella cella di "indirizzo r0"

	add	r0, r0, #1	; muovo il puntatore di una cella a destra
	add	r1, r1, #-1	; muovo il puntatore di una cella a sinistra

   ; controllo se r0 >= r1, il confronto lo faccio in r2
	not 	r2, r1		; il contenuto di r2 non mi serve più
	add	r2, r2, #1		; (alla prossima iterazione verrà ricaricato)
	add	r2, r2, r0
	brn	ciclo

   ; altrimenti ho finito
	ld	r2, sr2
	ld	r3, sr3
	ret	


sr2	.blkw	1
sr3	.blkw	1
sr4	.blkw	1
;*********************************************************************************************

	.end