; INPUT:
;	R0: N (n>=0)

; OUTPUT:
;	R0: Sn

; Sn = 2 * |Sn-1| - 2 * Sn-2
; s1 = 1, s2 = 1

	.orig	x3000
	ld		r0, num1
	jsr		SEQ1
	ld		r0, num2
	jsr		SEQ1
	ld		r0, num3
	jsr		SEQ1
stop	brnzp	stop


num1	.fill	6
num2	.fill	2
num3	.fill	-4


;*********************************************************
SEQ1
	add		r0, r0, #0		; aggiorno CC
	brp		noNeg

	;qui zero o negativo
	and 	r0, r0, #0
	ret


noNeg
	add		r0, r0, #-2		; escludo s1 e s2
	brp		calcSn

	; qui negativo o zero => s1 o s2
	and		r0, r0, #0
	add		r0, r0, #1
	ret

calcSn
	st		r1, save1
	st		r2, save2
	st		r3, save3
	st		r4, save4

	; qui devo calcolare sn
	and		r1, r1, #0
	add		r1, r1, #1		; r1 = Sn-1 = 1
	add		r2, r1, #0		; r2 = Sn-2 = 1

loop
	; calcolo: 2 * |Sn-1|
	add		r3, r1, #0
	brp		sn1Pos

	; qui calcolo modulo
	not		r3, r3
	add		r3 r3, #1

sn1Pos
	; r3 = |Sn-1|
	add		r3, r3, r3		; r3 = 2 * |Sn-1|

	; calcolo: - 2 * Sn-2
	add		r4, r2, r2		; r4 = 2 * (Sn-2)
	not		r4, r4
	add		r4, r4, #1		; r4 = -2 * (Sn-2)

	add		r3, r3, r4		; r3 = Sn


	add		r0, r0, #-1		; n--
	brz		fine			; se n=0 -> fine

	add		r2, r1, #0		; Sn-2 = Sn-1
	add		r1, r3, #0		; Sn-1 = Sn
	brnzp		loop

fine
	add		r0, r3, #0
	ld		r1, save1
	ld		r2, save2	
	ld		r3, save3
	ld		r4, save4
	ret


save1	.blkw	1
save2	.blkw	1
save3	.blkw	1
save4	.blkw	1

;*********************************************************

	.end
