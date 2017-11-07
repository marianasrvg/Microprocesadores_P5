;Pr�ctica 5 de Fundamentos de Microprocesadores
; OTO�O 2017, profesor Mario Alberto Peredo
; Luisa Flores, Juli�n L�pez y Mariana Sierra

LINEA EQU 31H		;CUENTA DE CARACT�RES POR RENGL�N		

		ORG 0000H
		SJMP RESET
		ORG 0040H

RESET:	MOV P0,#00H			;INICALIZAR PANTALLA
		MOV P3,#38H			
		;ESPERAR 4.1 milisegundos
		SETB P0.7
		CLR P0.7
		MOV P3,#38H			
		;ESPERAR 100 microsegundos
		SETB P0.7
		CLR P0.7
		MOV P3,#38H			
		;ESPERAR x
		SETB P0.7
		CLR P0.7
		
		MOV P3,#01H			;LIMPIAR PANTALLA			
		SETB P0.7
		CLR P0.7
		
		MOV P3,#00001110B	;ENCENDER PANTALLA, CON CURSOS, SIN PARPADEO
		SETB P0.7
		CLR P0.7
		
		MOV P3,#80H			;POSICIONAR CURSOR
		SETB P0.7
		CLR P0.7
		
		MOV LINEA,#20H		;INICIALIZAR EN 0 LAS CUENTAS

MAIN:	JB P2.6,ASCII		;DETECTAR SI ES EN C�DIGO ASCII
		
DATO:	JNB P2.7,MAIN			;DETECTAR SI EL DATO ESTA DISPONIBLE
		;DETECTAR SI HAY QUE ENVIAR POR EL PUERTO SERIAL
		
		MOV A,P2			;GUARDAR EL DATO QUE NO ES EN C�DIGO ASCII
		ANL A,#00001111B	
		MOV R0,A			; R0 = TECLADO DIRECTO
		CLR P2.7			;LISTO PARA RECIBIR OTRO DATO
		SJMP T_DATO
		SJMP MAIN

ASCII:	CLR P2.6

		JNB P2.7,$			;DETECTAR SI EL 1ER DATO ESTA DISPONIBLE
		MOV A,P2			
		ANL A,#00001111B	
		MOV R1,A			; R1 = ASCII_1
		CLR P2.7			;LISTO PARA RECIBIR OTRO DATO
		
		JNB P2.7,$			;DETECTAR SI 2DO EL DATO ESTA DISPONIBLE
		MOV A,P2		
		ANL A,#00001111B	
		MOV R2,A			; R2 = ASCII_2
		CLR P2.7			
				
		;TRANSMITIR EL DATO ASCII
		SJMP MAIN
		
		
		
T_DATO:		DJNZ LINEA, FIN_LCD		;CAMBIAR A 33D SI NO ES SUFICIENTE
			MOV A, LINEA
			CJNE A,#10H, TRANSMITIR
			
			CLR P0.5
			
			MOV P3,#0C0H
			SETB P0.7
			CLR P0.7
			
			
TRANSMITIR:	SETB P0.5		;ACTIVAR RS

			MOV A,R0
			ADD A,#30H		;SUMARLE 30H PORQUE NO ES HEXA
			MOV R0,A
			MOV P3,R0		;MANDAR EL DATO		
			SETB P0.7
			CLR P0.7
			
			CLR P0.5		;DESACTIVAR RS
			SJMP MAIN


FIN_LCD:	MOV LINEA,#20H
			CLR P0.5		;RS = 0 POR SI ACASO
			
			MOV P3,#01H			;LIMPIAR PANTALLA			
			SETB P0.7
			CLR P0.7
			
			MOV P3,#80H			;MOVER EL CURSOR
			SETB P0.7
			CLR P0.7
			
			SJMP TRANSMITIR
			
TA_DATO:	DJNZ LINEA, FIN_LCD		;CAMBIAR A 33D SI NO ES SUFICIENTE
			MOV A, LINEA
			CJNE A,#10H, TRANSMITIR_A
			
			CLR P0.5
			
			MOV P3,#0C0H
			SETB P0.7
			CLR P0.7
			
			
TRANSMITIR_A:	SETB P0.5		;ACTIVAR RS

			MOV P3,R0		;MANDAR EL DATO		
			SETB P0.7
			CLR P0.7
			
			CLR P0.5		;DESACTIVAR RS
			SJMP MAIN


FIN_LCD_A:	MOV LINEA,#20H
			CLR P0.5		;RS = 0 POR SI ACASO
			
			MOV P3,#01H			;LIMPIAR PANTALLA			
			SETB P0.7
			CLR P0.7
			
			MOV P3,#80H			;MOVER EL CURSOR
			SETB P0.7
			CLR P0.7
			
			SJMP TRANSMITIR_A
				
		
	
		
		
		
		END