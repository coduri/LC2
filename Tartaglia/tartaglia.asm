; INPUT:
;	R0: indirizzo prima cella array, che termina con 0 (A)
;	R1: indirizzo prima cella di array vuoto (T)

; OUTPUT:
;	Riempire l'array T:	T[0] = 1, T[N+1] = 1, T[I] = A[I-1]+A[I]


TARTAGLIA
	st 		r2, save2
	st 		r3, save3

	and		r2, r2, #0
	add		r2, r2, #1		; r2 = 1
	str		r2, r1, #0		; T[0] = 1

	add		r1, r1, #1		; T(i++)

	ldr		r2, r0, #0		; r2 = A[i]
	add		r0, r0, #1		; A(i++) => r2 = A[i-1]

loop
	ldr		r3, r0, #0		; r3 = A[i]
	brz		fine

	add		r2, r2, r3		; r2 = A[I-1] + A[I]
	str		r2, r1, #0		; T[I] = r2

	add		r2, r3, #0		; r2 = nuovo "vecchio" elemento

	add		r1, r1, #1		; T(i++)
	add		r0, r0, #1		; A(i++)
	brnzp	loop


fine
	and		r2, r2, #0
	add		r2, r2, #1		; r2 = 1
	str		r2, r1, #0		; T[N+1] = 1	
	ld 		r2, save2
	ld 		r3, save3
	ret


save2	.blkw	1
save3	.blkw	1