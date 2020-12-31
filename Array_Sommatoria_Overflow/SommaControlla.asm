	.orig	x3000
	lea	r0,	first
	lea	r1,	last
	ld	r2,	costante
        jsr     CONTA_OVER 
stop	brnzp	stop

first	.fill	89
	.fill	32000
	.fill	-160
last	.fill	76

costante	.fill	5000



CONTA_OVER
; salvataggio registri
	st	r3, saveR3
	st	r4, saveR4

	not	r1, r1 		; -(ultimo)
	add	r1, r1,	#0
ciclo	
	add	r3, r0, r1
	brp	fine

	ldr	r3, r0, #0	; r3 = arr[i]

	; arr[i] negativo -> non devo controllare overflow 
		brnz    sommaebasta

	; arr[i] positivo -> sommo e vedo overflow
		add	r3, r3, r2    	; arr[i] + N
		brzp   	aggiorna 	; risultato positivo -> tutto ok

		; risultato negativo
		add	r4, r4, #1			; r4 = contatore
		brnzp aggiorna


sommaebasta
	add		r3, r3, r2    	; arr[i] + N

aggiorna
	str     r3, r0, #0      ; ho aggiornato la memoria
	add	r0, r0, #1
	brnzp   ciclo

fine
	add	r2, r4, #0
	ld      r3, saveR3
	ld      r4, saveR4
	ret

saveR3	.blkw 1
saveR4	.blkw 1
        
        .end