;Scrivere un sottoprogramma che riceve in R1 e R2 gli indirizzi di due celle di memoria contenenti due numeri...
	
; programma principale
		.orig	x3000

		lea	r1, num1	; load effective address: carica in un registro un indirizzo, in questo
		lea	r2, num2	; 	caso carica in r2 l'indirizzo num2
		jsr	confronta

		lea	r1, num3
		lea	r2, num4
		jsr	confronta

		lea	r1, num5
		lea	r2, num6
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
; sottoprogramma che confronta num1 con num2, da risultato in R0. Utilizzo la somma: a + (-b)
;	R1 = indirizzo di num1		R2 = indirizzo di num2

confronta	
		st	r1, salva1	; salvo gli indirizzi in due celle di memoria
		st 	r2, salva2

	; come leggo da memoria il contenuto della cella con indirizzo che ho in un gpr?
		ldr	r1, r1, #0	; r1 = num1 -> metto in r1 il contenuto della cella di memoria con indirizzo r1
		ldr	r2, r2, #0	; potevo usare: ldi r2, salva2

		and	r0, r0, #0
		not 	r2, r2	
		add	r2, r2, #1
		add	r1, r1, r2

		brn 	minore
		brz 	uguale

	; non ho saltato prima quindi risultato positivo r1>r2
		add	r0, r0, #1
		brnzp 	fine
		
minore		add	r0, r0, #-1
		brnzp 	fine

uguale		add	r0, r0, #0

fine		
		ld	r1, salva1	; ricarico in r1 e r2 gli indirizzi iniziali
		ld	r2, salva2

		ret
	
; queste servono al mio sottoprogramma (la cpu non le deve fetchare) ret lo blocca
salva1 		.blkw 	1
salva2 		.blkw 	1
;*****************************************************************************************************************

		.end