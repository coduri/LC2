; R0 indirizzo array0
; R1 indirizzo array1
	; uguale lunghezza, 	0 tappo finale
; R2 indirizzo che conterrà arr2

; OUTPUT
;	arr2 = a0[i] + a1[i]
; 	R0 = num overflow/underflow



SOMMA_ARRAY
	st 	r3, save3
	st 	r4, save4
	st 	r5, save5
	and 	r5, r5, #0

ciclo
	ldr	r3, r0, #0 		; r3 = arr0[i]
	brz	fine 			; ho letto uno zero -> fine array
	brp 	checkOver

	; r3 e' neg
	ldr	r4, r1, #0		; r4 = arr1[i]
	brzp 	noProblem      		; r3 neg, ma r4 pos

	; qui r3 neg e r4 neg
	add	r3, r3, r4		; arr + arr
	brnz 	eseguiStore
	; underflow
	add 	r5, r5, #1
	brnzp 	eseguiStore

checkOver
	ldr	r4, r1, #0		; r4 = arr1[i]
	brnz 	noProblem      		; r3 pos, ma r4 neg

	; qui r3 pos e r4 pos
	add	r3, r3, r4		; arr + arr
	brzp 	eseguiStore
	; overflow
	add 	r5, r5, #1
	brnzp 	eseguiStore

noProblem
	add	r3, r3, r4		; arr + arr

eseguiStore
	str	r3, r2, #0		; memorizzo cella di arr2

	add	r2, r2, #1		; incremento indici arr
	add	r0, r0, #1
	add 	r1, r1, #1

	brnzp 	ciclo

fine
	; sposto r5 in r0 e ripristino i registri
	add r0, r5, #0

	ld 	r3, save3
	ld 	r4, save4
	ld 	r5, save5
  	ret

save3	.blkw	1
save4	.blkw	1
save5	.blkw	1

; per overflow controllo se r3 pos e r4 pos	-> risu pos?
; per underflow	controllo se r3 neg e r4 neg -> ris neg?
