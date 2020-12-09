; Programma che conta le doppie, lettere consecutive uguali in una stringa data

	.orig	x3000
	lea	r0, stringa
	lea	r1, succ
	add	r1, r1, #-2	; la cella prima è lo zero terminatore di stringz, quella prima ancora l'ultima lettera
	jsr	CONTA_DOPPIE
stop	brnzp	stop



stringa	.stringz	"aaBB cc Dd ggNgg"
succ	.blkw	1
;****************************************************************************************************
; INPUT: 
	; r0 = indirizzo cella primo carattere della stringa
	; r1 = indirizzo cella ultimo carattere della stringa
; OUTPUT:
	; r0 = numero di doppie (lettere consecutive uguali, senza contare ripetizioni di oltre due)


CONTA_DOPPIE

	st	r2, save2
	st	r3, save3
	st	r4, save4

	not	r1, r1
	add	r1, r1, #1	; r1 = -r1 = -(indirizzo finale)

	and	r4, r4, #0	; azzero contatore

loop	add	r2, r1, r0	; confronto indirizzo puntato con ind. finale
	brzp	fine		; quando r0 supera r1 ho finito. Ma io sto esaminando due lettere alla volta,
					; se sto puntando all'ultima, non c'è una successiva

   ; restano almeno due caratteri
	ldr	r2, r0, #0	; carico char in r2			-> array[i]
					; se incremento il puntatore e poi lo incremento di nuovo, partirò due lettere dopo. Quindi salto alcune lettere
	ldr	r3, r0, #1	; carico char "successivo" in r3	-> array[i+1]

	add	r0, r0, #1	; incremento puntatore per prossima iterazione

   ; confronto i due caratteri lettera[i] elettera[i+1]
	not	r3, r3
	add	r3, r3, #1
	add	r3, r3, r2
	brnp	loop		; lettere sono diverse

	add	r4, r4, #1	; ho trovato una coppia => incremento contatore
	brnzp	loop

fine	add	r0, r4, #0
	ld	r2, save2
	ld	r3, save3
	ld	r4, save4
	ret


save2	.blkw	1
save3	.blkw	1
save4	.blkw	1

;****************************************************************************************************
	.end