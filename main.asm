	list p=18F4520
	#include "P18F4520.inc"
	CBLOCK
	count
	countA
	ENDC
	ORG	0x00
	BRA	Initial
	
	ORG	0x08
	BRA	interrupt

	ORG	0x2A
Initial
	
	;�}��ŧi
	BANKSEL	TRISB
	MOVLW	b'00000000'
	MOVWF	TRISB

	MOVLW	0x00
	MOVWF	count	

	MOVLW	0x02
	MOVWF	countA

	;�p�ɾ��ŧi
	MOVLW	b'11111101'
	MOVWF	T1CON
	
	MOVLW	(.65536-.62500)/.256
	MOVWF	TMR1H
	MOVLW	(.65536-.62500)%.256
	MOVWF	TMR1L
	


	BSF	IPR1,TMR1IP ;�]Timer1�����u�����_
	BCF	PIR1,TMR1IF	;�M��Timer1���_�X��
	BSF	PIE1,TMR1IE	;�}�Ҥ��_�\��
	
	BSF	RCON,IPEN	;�Ұʤ��_�u�����Ǫ��\��
	BSF	INTCON,GIEH ;�ҰʩҦ����u�����_
	
main
	BANKSEL	PORTB
	MOVF	count,0
	CALL	TABLE
	MOVWF	PORTB
	GOTO	main
		
interrupt
	DECFSZ	countA,1	
	GOTO	notime

	BCF	PIE1,TMR1IE	;�������_�\��
	BCF	PIR1,TMR1IF	;�M��Timer1���_�X��

	MOVLW	(.65536-.62500)/.256
	MOVWF	TMR1H
	MOVLW	(.65536-.62500)%.256
	MOVWF	TMR1L

	MOVLW	0x02
	MOVWF	countA
	
	INCF	count
	INCF	count
	
	
	BSF	PIE1,TMR1IE	;�}�Ҥ��_�\��
	RETFIE	FAST

notime ;�ɶ��٥���1S
	BCF	PIR1,TMR1IF	;�M��Timer1���_�X��
	MOVLW	(.65536-.62500)/.256
	MOVWF	TMR1H
	MOVLW	(.65536-.62500)%.256
	MOVWF	TMR1L
	RETFIE	FAST


;�@���C�q��ܾ�	
TABLE	
	ADDWF PCL,1
	retlw	03FH
	retlw	006H	
	retlw	05BH
	retlw	04FH
	retlw	066H
	retlw	06DH
	retlw	07DH
	retlw	007H
	retlw	07FH
	retlw	06FH
	;�p�ƾ��k�s 		
	MOVLW	0x00
	MOVWF	count
	RETURN

	END