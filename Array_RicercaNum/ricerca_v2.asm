; riceve in R0 l’indirizzo del primo elemento di un array di numeri in complemento a due;
; riceve in R1 l’indirizzo dell’ultimo elemento dell’array;
; riceve in R2 un numero N in complemento a due;
; restituisce in R0 l’indice I di N in A, cioè la posizione di N partendo da 1. Se il numero N non è
	; presente in A, viene restituito il valore 0
	

	.orig 	x3000

	lea	r0, aInizio		; indirizzo cella 1
	lea	r1, aFine		; indirizzo ultima cella
	ld	r2, n1			; carico numero da cercare		
	jsr	cercaN

	lea	r0, aInizio		; indirizzo cella 1
	lea	r1, aFine		; indirizzo ultima cella
	ld	r2, n2			; carico numero da cercare
	jsr	cercaN

	lea	r0, aInizio		; indirizzo cella 1
	lea	r1, aFine		; indirizzo ultima cella
	ld	r2, n3			; carico numero da cercare
	jsr	cercaN

exit	brnzp	exit			; evito che la cpu prosegua



aInizio	.fill 	19
	.fill	27
	.fill 	51
	.fill 	0
aFine	.fill 	10


; definisco numeri per provare
n1	.fill	27
n2	.fill 	10
n3	.fill	31

;*********************************************************************************************
; Input:
	; R0 = indirizzo prima cella
	; R1 = indirizzo ultima cella
	; R2 = numero ricercato
; Output:
	; R0 = indice N (partendo da 1), se non c'è 0
	; R1 = indirizzo ultima cella
	; R2 = numero ricercato


cercaN
	st	r3, sr3		; io vado ad utilizzare r3 ed r4. Supponendo che ci sia del contenuto,
	st	r4, sr4			; lo salvo e lo ripristino alla fine. 
			; Si potrebbe ripristinare anche r1 ed r2 in quanto vengono modificati, ma il programma chiamante sa del loro utilizzo

	; preparo i registri da confrontare, così eseguo una volta sola
	not 	r1, r1
	add	r1, r1, #1	; r1 = - r1 ( = - puntatore fine array)
	not	r2, r2
	add	r2, r2, #1	; r2 = - r2 ( = - numero cercato)
   	
	and 	r4, r4, #0	; r4 = contatore

   	; è possibile ricevere un array vuoto e andare direttamente alla conclusione?
ciclo	add	r3, r0, r1	; = r0-r1, prima cella - ultima cella, ho finito quando r0 è più grande di r1
	brp	notFound
	
	add	r4, r4, #1	; contatore++
	ldr	r3, r0, #0	; r3 = elemento array (prendo il contenuto di un registro per leggere in memoria)
	add	r3, r3, r2	; r3 = numero corrente, r2 = numero negato da cercare -> CONFRONTO

	brz	found		; se = zero -> TROVATO 
   ; non trovato devo passare al successivo
	add	r0, r0, #1	; puntatore al successivo
	brnzp	ciclo


notFound
	and	r0, r0, #0	; = non trovato
	brnzp	fine

found
	and	r0, r0, #0	; r4 contiene indice del'elem trovato
	add	r0, r0 , r4
	;brnzp 	fine inutile, segue subito dopo

fine	
	ld	r3, sr3
	ld	r4, sr4
	ret

sr3	.blkw	1
sr4	.blkw	1
;*********************************************************************************************

	.end