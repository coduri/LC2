; INPUT:
;	R0: indirizzo iniziale di una stringa (.stringz)
;	R1: un carattere (ascii)	(c)
;	R2: intero >=1	(n)

; OUTPUT
;	R0: la posizione carattere C dopo averlo letto N volte, altrimenti 0

; es) se N = 1, C=es	-> stampo la posizione della seconda e che trovo


	.orig	x3000
	lea	r0, stringa
	ld	r1, char
	ld	r2, num
	jsr	TROVA_OCC_SUCC
stop	brnzp	stop


stringa	.stringz "ciao amico come stai?"
char	.fill	111	; = 'o'
num	.fill	2	; il numero di lettere da saltare



TROVA_OCC_SUCC
	st 	r3, save3   		; caratteri
	st 	r4, save4		; contatore posizione
	and 	r4, r4, #0
	add	r2, r2, #1		; perche' cerco la N+1esima occorrenza

	not	r1, r1   		; carattere che cerco negato
	add	r1, r1, #1


loop
	ldr	r3, r0, #0		; r3 = char[i]
	brz	fineString 		; leggo zero = finita la stringa

	add 	r4, r4, #1		; posizione++

	; confronto
	add	r3, r3, r1
	brz	trovato

	add	r0, r0, #1		; i++
	brnzp	loop

; trovato uno
trovato
	add	r2, r2, #-1		; n--
	brz	finito			; se r2 = 0	-> sono arrivato all'occorrenza che volevo
	; altrimenti incremento e torno al loop
	add	r0, r0, #1
	brnzp	loop


; sono arrivato a fine stringa senza trovare cio' che volevo
fineString
	and	r0, r0, #0
	ld 	r3, save3
	ld 	r4, save4
	ret

; ho raggiunto cio' che volevo
finito
	add	r0, r4, #0		; r0 = posizione
	ld 	r3, save3
	ld 	r4, save4
	ret


save3	.blkw	1
save4	.blkw	1

	.end