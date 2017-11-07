      ; Ejemplo de transmisi�n serial
		  ; Primavera 2017 ITESO

			ORG 00H
			sjmp main;
			ORG 40H
main:       mov SCON,#01000000b   ; sm0 sm1 sm2 ren tb8 rb8 ti ri
							                    ; uart 8 bits banderas limpias
			mov TMOD, #00100000b        ; G T!/C M1 M0 G T!/C M1 M0
			mov TH1,#0FDH                ; T! autorecarga para baudrate de 9600 bps
			mov TL1,#(-3)
			setb TR1

			mov A,#'H'
imprime:	mov SBUF,A
espera:		jnb TI, espera
            clr TI
            inc A
			sjmp imprime
			nop
			nop
			END

       ; Ejemplo de recepci�n serial
		   ; Primavera 2017 ITESO

/*
      ORG 00H
			sjmp main;
			ORG 40H
main:       mov SCON,#01000000b   ; sm0 sm1 sm2 ren tb8 rb8 ti ri
							                    ; uart 8 bits banderas limpias
			mov TMOD, #00100000b  ; G T!/C M1 M0 G T!/C M1 M0
			mov TH1,#0FDH         ; T! autorecarga para baudrate de 9600 bps
			mov TL1,#(-3)
			setb TR1
			setb REN

espera:		jnb RI, espera
            clr RI
            mov A,SBUF
			sjmp espera
			nop
			nop
			END  */

	/*
	ORG 00H
	JMP Main
	ORG 0040H
Main:
	MOV SCON,#01000010B  ;Modo0, Modo1,Modo2, REN, TB8,RB8,TI,RI
	MOV TMOD,#00100000B 	;GATE,!TIMER/COUNTER,M1,M0,GATE,!TIMER/COUNTER,M1,M0
	MOV TH1,#(-3)
	MOV TL1,#0FDH
	SETB TR1
	MOV A,#30H
Valida:
	JNB TI,$
	CPL TI
	MOV SBUF,A
	INC A
	SJMP Valida

	END
*/
