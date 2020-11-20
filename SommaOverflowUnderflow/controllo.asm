; Scrivere un sottoprogramma che riceve in R0 e R1 due numeri num1 e num2 in complemento a due, li
; somma, restituisce in R1 il risultato e in R0 la seguente indicazione:
; R0 = -1 se si è verificato underflow
; R0 = 0 se la somma ha avuto esito corretto
; R0 = +1 se si è verificato overflow
; Qualora per la realizzazione del sottoprogramma fosse necessario utilizzare altri registri della CPU, il
; sottoprogramma stesso deve restituire il controllo al programma chiamante senza che tali registri risultino
; alterati

; programma principale
	.orig	x3000

	ld	r0, num1
	ld	r1, num4
	jsr	sommauo

	ld	r0, num1
	ld	r1, num2
	jsr	sommauo

	ld	r0, num1
	ld	r1, num3
	jsr	sommauo

	ld	r0, num4
	ld	r1, num5
	jsr	sommauo

	ld	r0, num4
	ld	r1, num6
	jsr	sommauo

stop	brnzp 	stop

	num1		.fill	32760
	num2		.fill	5
	num3		.fill	10
	num4		.fill	-32760
	num5		.fill	-5
	num6		.fill	-10

;******************************************************************************************************
; Input:
	; R0: num1
	; R1: num2
; Output:
	; R0: Controllo 	
		; -1 	UNDERFLOW sommo 2 concordi negativi e risultato positivo
		;  0 	OK (sommo 2 discordi)
		; +1 	OVERFLOW sommo 2 concordi positivi con risultato negativo
	; R1: Risultato (num1 + num2)


sommauo
	add 	r0, r0, #0	; controllo segno r0 (aggiorno CC)
	brn	n1neg		; segno negativo (primo bit a 1 verifico underflow)
   ;num1pos
	and	r1,r1,r1	; controllo segno r1
	brn 	disc		; segni discordi
	brnzp	concpos

; qui num1 neg
n1neg	and 	r1,r1,r1
	brzp	disc		; segni discordi
	brn	concneg


; qui discordi
disc	add	r1, r0, r1
	and 	r0, r0, #0	; r0 = 0 (somma ok)
	ret


; numeri concordi positivi, controllo overflow
concpos	add	r1, r0, r1
	brn	over		; somma di due positivi con risultato negativo
	and	r0, r0, #0
	ret

; si è verificato overflow
over	and	r0, r0, #0
	add	r0, r0, #1
	ret


; numeri concordi negativi, controllo underflow
concneg	add	r1, r0, r1
	brzp	under		; somma di due negativi con risultato positivo
	and	r0, r0, #0
	ret

; si è verificato overflow
under	and	r0, r0, #0
	add	r0, r0, #-1
	ret

;******************************************************************************************************
	.end