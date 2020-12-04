; Il candidato scriva un sottoprogramma denominato CONV_MAIUS che riceve nel registro R0 l’indirizzo della
; prima cella di una zona di memoria contenente una stringa di caratteri codificati ASCII (un carattere per cella).
; La stringa è terminata dal valore 0 (corrispondente al carattere NUL). 
; Il sottoprogramma deve:
	; 1. convertire tutte le lettere minuscole contenute nella stringa nelle corrispondenti lettere maiuscole;
	; 2. restituire nel registro R0 il conteggio delle lettere convertite.



		.orig	x3000
		lea	r0, stringa
		jsr	CONV_MAIUS
stop		brnzp	stop

stringa		.stringz	"stringa di PROVA 0!"	; dovrebbero essere 9 i caratteri convertiti


;****************************************************************************************************
; Input:
	; R0 = indirizzo prima cellla della stringa (che termina con tutti i bit a 0)
		; (Maiuscole 65-95, minuscole 97-122)
; Output:
	; R0 = numero di lettere convertite
	
CONV_MAIUS 
		st	r1, sr1
		st	r2, sr2
		st	r3, sr3
		st	r4, sr4
		st	r5, sr5
		st	r6, sr6

		ld	r2, minore	; = -97
		ld	r3, maggiore	; = -122
		ld	r5, conv	; = -32

		and	r6, r6, #0	; contatore
ciclo		
		ldr	r1, r0, #0	; r1 = i-esima lettera
		brz	fine		; ho letto lo zero terminatore


	; controllo se >= 97
		add	r4, r2, r1
		brn	noMin		; numero minore di 97, non è minuscola

	; >=97 controllo se <= 122
		add	r4, r3, r1
		brp 	noMin		; numero maggiore di 122, non è minuscola

	; è nel range
		add	r1, r1, r5	; minuscolo -> MAIUSCOLO
		str	r1, r0, #0	; Metto nella cella di indirizzo contenuto in r0 il valore di r1			
		add	r6, r6, #1	; contatore di conversioni ++
	   ; nel caso in cui sono nel range continuo

noMin		add	r0, r0, #1	; puntatore ++
		brnzp	ciclo

fine		add	r0, r6, #0	; copio in r0 il contatore (sommo r6+0 = r6) lo scrivo in r0

		ld	r1, sr1
		ld	r2, sr2
		ld	r3, sr3
		ld	r4, sr4
		ld	r5, sr5
		ld	r6, sr6

		ret


sr1		.blkw	1
sr2		.blkw	1
sr3		.blkw	1
sr4		.blkw	1
sr5		.blkw	1
sr6		.blkw	1

minore		.fill	-97
maggiore	.fill	-122
conv		.fill	-32

;****************************************************************************************************

		.end