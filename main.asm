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
	
	;腳位宣告
	BANKSEL	TRISB
	MOVLW	b'00000000'
	MOVWF	TRISB

	MOVLW	0x00
	MOVWF	count	

	MOVLW	0x02
	MOVWF	countA

	;計時器宣告
	MOVLW	b'11111101'
	MOVWF	T1CON
	
	MOVLW	(.65536-.62500)/.256
	MOVWF	TMR1H
	MOVLW	(.65536-.62500)%.256
	MOVWF	TMR1L
	


	BSF	IPR1,TMR1IP ;設Timer1為高優先中斷
	BCF	PIR1,TMR1IF	;清除Timer1中斷旗標
	BSF	PIE1,TMR1IE	;開啟中斷功能
	
	BSF	RCON,IPEN	;啟動中斷優先順序的功能
	BSF	INTCON,GIEH ;啟動所有高優先中斷
	
main
	BANKSEL	PORTB
	MOVF	count,0
	CALL	TABLE
	MOVWF	PORTB
	GOTO	main
		
interrupt
	DECFSZ	countA,1	
	GOTO	notime

	BCF	PIE1,TMR1IE	;關閉中斷功能
	BCF	PIR1,TMR1IF	;清除Timer1中斷旗標

	MOVLW	(.65536-.62500)/.256
	MOVWF	TMR1H
	MOVLW	(.65536-.62500)%.256
	MOVWF	TMR1L

	MOVLW	0x02
	MOVWF	countA
	
	INCF	count
	INCF	count
	
	
	BSF	PIE1,TMR1IE	;開啟中斷功能
	RETFIE	FAST

notime ;時間還未到1S
	BCF	PIR1,TMR1IF	;清除Timer1中斷旗標
	MOVLW	(.65536-.62500)/.256
	MOVWF	TMR1H
	MOVLW	(.65536-.62500)%.256
	MOVWF	TMR1L
	RETFIE	FAST


;共陰七段顯示器	
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
	;計數器歸零 		
	MOVLW	0x00
	MOVWF	count
	RETURN

	END