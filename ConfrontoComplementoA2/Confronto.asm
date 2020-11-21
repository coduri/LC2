;	Scrivere un sottoprogramma che RICEVE in R1 e R2 (chi lo chiama carica i due numeri) due numeri num1 e num2 (in complemento a due), li
;	confronta, restituisce in R0 la seguente indicazione:
;	R0 = -1 se num1 < num2
;	R0 = 0 se num1 = num2
;	R0 = +1 se num1 > num2
;	Qualora per la realizzazione del sottoprogramma fosse necessario utilizzare altri registri della CPU, il
;	sottoprogramma stesso deve restituire il controllo al programma chiamante senza che tali registri risultino
;	alterati.
	
; programma principale
		.orig	x3000		; dice all'assembler che il programma inzia da qui

		ld	r1, num1
		ld	r2, num2
		jsr	confronta	; chiamata a sottoprogramma, fa un salto ma prima salva in r7 il p.c. da cui riprendere

		ld	r1, num3
		ld	r2, num4
		jsr	confronta

		ld	r1, num5
		ld	r2, num6
		jsr	confronta

stop		brnzp 	stop

; sono parte del programma chiamante e stanno qui (ma fuori dal sottoprogramma)
	num1		.fill	10
	num2		.fill	23
	num3		.fill	17
	num4		.fill	17
	num5		.fill	-10
	num6		.fill	-20
;**************************************************Da consegnare**************************************************
; sottoprogramma che confronta R1 (num1) con R2 (num2), da risultato in R0. Utilizzo la somma: a + (-b)

confronta	
		st	r1, salva1	; salvo r1 e r2 in due celle di memoria, in quanto il confronto modifica i valori r1 e r2
		st 	r2, salva2	;	e la consegna richiede che non siano alterati

		and	r0, r0, #0	; azzero r0 (cella del risultato)
		not 	r2, r2		; nego num2 (complemento a 1)
		add	r2, r2, #1	; r2 = - r2 (complemento a 2)
		add	r1, r1, r2	; R1 = num1 -num2

		brn 	minore		; risultato somma precedente negativo -> r1 < r2
		brz 	uguale		; risultato somma precedente zero -> r1 = r2

	; non ho saltato prima quindi risultato positivo r1 > r2
		add	r0, r0, #1
		brnzp 	fine
		
minore		add	r0, r0, #-1
		brnzp 	fine

uguale		add	r0, r0, #0
		;brnzp fine	-> è ovvio perché proseguo sequenzialmente
fine		
		ld	r1, salva1	; ricarico in r1 e r2 i termini dell'operazione di confronto
		ld	r2, salva2
		ret			; torno al programma principale
	
; queste servono al mio sottoprogramma (la cpu non le deve fetchare) ret evita che ciò accada
salva1 		.blkw 	1
salva2 		.blkw 	1
;*****************************************************************************************************************

		.end