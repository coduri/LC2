		.orig	x3000		; dice all'assembler in quale cella di memoria caricare il codice
		lea	r0,array	; carico in R0 l'indirizzo della prima cella dell'array
		and 	r2,r2,#0	; inizializzo R2 (sarà il totalizzatore)
ciclo		ldr	r1,r0,#0	; carico in R1 l'i-esimo elemento dell'array
		brz	fine		; eseguo una verifica sull'elemento appena caricato (se Zero salto a fine)
		add 	r2,r1,r2	; aggiorno R2
		add	r0,r0,#1	; incremento il puntatore
		brnzp	ciclo		; salto incondizionato (ciclo)
fine		st	r2,result	; salvo il risultato, contenuto in R2, in una cella di memoria
stoqui		brnzp	stoqui		; ferma l'esecuzione, evita l'esecuzione di non istruzioni

; le righe seguenti non sono istruzioni per la CPU, ma direttive per l'assembler
; in seguito alla traduzione in binario: i bit sono bit, la cpu li leggerebbe e li interpreterebbe come istruzioni

array		.fill	15		; .fill e' una direttiva all'assembler che dice di riservare e inizializzare una cella 
		.fill	-2		; memoria con il valore scritto accanto (tipicamente per costanti)
		.fill	5
		.fill	0
		.fill	13		; non verrà letto -> il ciclo termina alla lettura di 0 (riga 5)

result		.blkw	1		; direttiva che richiede di riservare un numero di celle (tipicamente per variabili)
		.end			; indica all'assembler che non c'e' altro contenuto da tradurre
