; INPUT:
;	R0: N
; OUTPUT:
;	R0: Fibonacci(N)

;	Fibonacci(N) = Fibonacci(N-1) + Fibonacci(N-2)
;	F1 = 1, F2 = 1, Fn (n<=0) = 0
;	(non considerare eventuale overflow)


FIBONACCI
	; controllo casi base
	add	r0, r0, #0		; aggiorno CC
	brp noZero
	
	;qui n<=0
	and	r0, r0, #0
	ret

noZero
	add	r0, r0, #-2		; se =1 o =2 diventerà 0 o neg
	brp	noUno

	; qui n = 1 o n=2
	and	r0, r0, #0
	add	r0, r0, #1
	ret


noUno
	st 	r1, s1
	st 	r2, s2
	st 	r3, s3

	;calcolo F(n), necessito due oggetti F(n-1) e F(n-2)

	; inizializzo termini 
	and	r1, r1, #0
	add	r1, r1, #1		; R1 = F(n-1)
	and	r2, r1, #0		; R2 = F(n-2)

loop
	add	r3, r1, r2 		; R3 = F(n)
	add	r0, r0, #-1		; n--
	brz	fine			; se =0 ho finto 

	; altrimenti devo calcolare F(n) shiftando F(n-1) e F(n-2)
	add	r2, r1, #0		; F(n-2) = F(n-1)
	add	r1, r3, #0		; F(n-1) = F(n)
	brnzp loop

fine
	add	r0, r3, #0
	ld 	r1, s1
	ld 	r2, s2
	ld 	r3, s3
	ret


s1	.blkw	1
s2	.blkw	1
s3	.blkw	1