; Input:
;	R0: indirizzo inizio stringa (termina con 0)

; Output:
;	R0: num parole scritte in maiuscolo lette
;	(solo scritte in maiuscolo, no cifre, no segni, no minuscole)

;	A = 65, Z = 90, SP = 32

;*************** PROGRAMMA NON PROVATO! ***************

CONTA_WORD

	; salvo registri
	st 	r1, save1
	st 	r2, save2
	st 	r3, save3
	st 	r4, save4
	st 	r5, save5
	st 	r6, save6

	; r1 sarà contenitore del char
	and		r2, r2, #0		; r2: contatore parole

	ld 		r3, A 			; r3 = - ASCII('A')
	ld 		r4, Z			; r4 = - ASCII('Z')
	ld 		r5, SP			; r5 = - ASCII(' ')

loop
	ldr		r1, r0, #0		; r1 = char[i]
	brz		fine

	add		r6, r1, r5		; = ASCII(char[i]) - 32
	brnp	inizioParola	; char[i] != ' '

	; char[i] = ' ', mi porto al prossimo char
	add 	r0, r0, #1
	brnzp 	loop


; inizio di una possibile parola
inizioParola
	; verifico se > ASCII('A')
	add		r6, r1, r3
	brn 	prossimaParola		; char[i] < ASCII('A') => ciò che segue non è parola
	; verifico se < ASCII('Z')
	add		r6, r1, r4
	brp 	prossimaParola		; char[i] > ASCII('Z') => ciò che segue non è parola

; trovato carattere iniziale di una possibile parola!
controllaParola
	add		r0, r0, #1			; i++
	ldr		r1, r0, #0			; r1 = char[i]
	brz 	stringaInterrotta

	; controllo se è uno spazio => (se si) conto parola
	add		r6, r1, r5
	brz		contaParola

	; no spazio => lettera della stessa parola! Controllo se lettera sta nel range:  A < char[i] < Z
	add		r6, r1, r3
	brn 	prossimaParola		; carattere non è una maiuscola, la parola che stavo leggendo non va contata, cerco prossima parola
	add		r6, r1, r4
	brp 	prossimaParola		; carattere non è una maiuscola, la parola che stavo leggendo non va contata, cerco prossima parola

	; lettera sta nel range! passo al carattere successivo
	brnzp controllaParola


prossimaParola
	; scorro le lettere fino a che non trovo uno spazio (separatore alla prossima parola)
	add		r0, r0, #1
	ldr		r1, r1, #0
	brz 	fine
	add		r6, r1, r5
	brnp 	prossimaParola 		; sto leggendo una NON-parola, continuo a leggere caratteri fino al prossimo spazio

	; trovato spazio, cerco prossima parola
	brnzp loop


contaParola
	add		r2, r2, #1
	add		r0, r0, #1
	brnzp	loop


stringaInterrotta
	add		r2, r2, #1		; stavo leggendo l'ultima parola

fine
	add		r0, r6, #0		; r0 = contatore
	ld 		r1, save1
	ld 		r2, save2
	ld 		r3, save3
	ld 		r4, save4
	ld 		r5, save5
	ld 		r6, save6
	ret



SP		.fill	-32
Z		.fill	-90
A		.fill	-65

save1	.blkw	1
save2	.blkw	1
save3	.blkw	1
save4	.blkw	1
save5	.blkw	1
save6	.blkw	1