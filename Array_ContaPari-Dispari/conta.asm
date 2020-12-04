; Il candidato scriva un sottoprogramma denominato CONTA_PARI_DISPARI che riceve:
	; In R0 l’indirizzo della prima cella di una zona di memoria contenente una sequenza di numeri
	; In R1 l’indirizzo della cella contenente l’ultimo numero della sequenza di cui al punto 1.

; Il sottoprogramma deve restituire:
	; 1. nel registro R0 il conteggio di quanti numeri pari sono presenti nella sequenza;
	; 2. nel registro R1 il conteggio di quanti numeri dispari sono presenti nella sequenza



	.orig x3000
	lea	r0, testa
	lea	r1, coda
	jsr	CONTA_PARI_DISPARI

stop	brnzp	stop




testa	.fill	112
	.fill	-27
	.fill	-1232
	.fill	450
	.fill	15
coda	.fill	120		; mi aspetto r0=4, r1=2

;************************************************************************************************
; INPUT:
	; r0 = ind. inizio
	; r1 = ind. fine
; OUTPUT:
	; r0 = num pari		-> 0 come ultima cifra
	; r1 = num dispari	-> 1 come ultima cifra

CONTA_PARI_DISPARI
	
	
	st	r2, save2
	st	r3, save3
	st	r4, save4
	
	not	r1, r1
	add	r1, r1, #1		; R1: - (indirizzo fine)

	and 	r5, r5, #0		; R5: contatore a pari
	and 	r6, r6, #0		; R6: contatore a dispari


ciclo	
	add	r2, r1, r0		; controllo se ho finito
	brp	fine			; ho finito quando ind. corrente è oltre ind. finale

	ldr 	r2, r0, #0		; r2 = array[i]
	and	r2, r2, #00001		; verifico bit meno significativo, inutile fare un .fill con il valore
					; N.B. nel caso dell'and i bit mancanti sono 0 (nel caso dell'add viene esteso il primo bit complemento a 2)
	brz	pari

    ; qui è dispari
	add	r4, r4, #1
	brnzp 	prossimo

pari	
	add	r3, r3, #1	; e vado a "prossimo"

prossimo
	add	r0, r0, #1		; incremento puntatore
	brnzp	ciclo

fine
	add	r0, r3, #0
	add	r1, r4, #0

	ld	r2, save2
	ld	r3, save3
	ld	r4, save4
	ret


save2		.blkw	1
save3		.blkw	1
save4		.blkw	1

;************************************************************************************************
	.end

