;Scrivere un sottoprogramma che riceve in R1 e R2 gli indirizzi a due celle di memoria contenenti gli indirizzi ai numeri...
	
; programma principale
		.orig	x3000

		lea	r1, a1		; load effective address, r1 contiene indirizzo di a1 che contiene l'indirizzo num1
		lea	r2, a2
		jsr	confronta

		lea	r1, a3
		lea	r2, a4
		jsr	confronta

		lea	r1, a5
		lea	r2, a6
		jsr	confronta

stop		brnzp 	stop

	a1		.fill 	num1	; contiene indirizzo num1 (indirizzo della cella contenente il valore num1)
	a2		.fill 	num2
	a3		.fill 	num3
	a4		.fill 	num4
	a5		.fill 	num5
	a6		.fill 	num6
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
		st	r1, salva1	; salvo gli indirizzi in due celle
		st 	r2, salva2

		ldr	r1, r1, #0	; r1 = indirizzo di num1
		ldr	r1, r1, #0	; r1 = num 1

		ldr	r2, r2, #0 	; r2 = indirizzo di num2
		ldr	r2, r2, #0	; r2 = num2

		and	r0, r0, #0
		not 	r2, r2	
		add	r2, r2, #1
		add	r1, r1, r2

		brn 	minore
		brz 	uguale

	; non ho saltato prima quindi sicuramente risultato positivo r1>r2
		add	r0, r0, #1
		brnzp 	fine
		
minore		add	r0, r0, #-1
		brnzp 	fine

uguale		add	r0, r0, #0

fine		
		ld	r1, salva1	; ricarico in r1 e r2 gli indirizzi iniziali
		ld	r2, salva2

		ret			; torno al programma principale
	
; queste servono al mio sottoprogramma (la cpu non le deve fetchare) ret lo blocca
salva1 		.blkw 	1
salva2 		.blkw 	1
;*****************************************************************************************************************

		.end