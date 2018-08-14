 LIST P=16F84A

;LANGUAGE               RISC-like architecture
;GITHUB                 https://github.com/neo-pascal
;WRITTEN BY             Neo Ayestaran
;DATE                   15/03/18             
;FILE SAVED AS          Binary2Decimal.ASM
;FOR PIC 16F84A         18 pin device
;CRYSTAL                4MHz
;CODE PROTECTION        OFF
;SOFTWARE FUNCTION      'Display an 8-bit binary value and ask the user to work out the decimal value'

 ORG 0
 GOTO MAIN

 #include "LCD_Module_16x2_4Bit.inc"

TITLE_PAGE
        MOVLW   'B'
        CALL    SEND_CHAR             
        MOVLW   'i'
        CALL    SEND_CHAR             
        MOVLW   'n'
        CALL    SEND_CHAR             
        MOVLW   'a'
        CALL    SEND_CHAR             
        MOVLW   'r'
        CALL    SEND_CHAR
        MOVLW   'y'
        CALL    SEND_CHAR             
        MOVLW   ' '
        CALL    SEND_CHAR
        MOVLW   '2'
        CALL    SEND_CHAR
        MOVLW   ' '
        CALL    SEND_CHAR     
        MOVLW   'D'
        CALL    SEND_CHAR             
        MOVLW   'e'
        CALL    SEND_CHAR             
        MOVLW   'c'
        CALL    SEND_CHAR             
        MOVLW   'i'
        CALL    SEND_CHAR             
        MOVLW   'm'
        CALL    SEND_CHAR             
        MOVLW   'a'
        CALL    SEND_CHAR
        MOVLW   'l'
        CALL    SEND_CHAR       

        MOVLW   LINE2
        CALL    GOTO_LINE

        MOVLW   'B'
        CALL    SEND_CHAR
        MOVLW   'y'
        CALL    SEND_CHAR             
        MOVLW   ' '
        CALL    SEND_CHAR             
        MOVLW   'N'
        CALL    SEND_CHAR             
        MOVLW   'e'
        CALL    SEND_CHAR 
        MOVLW   'o'
        CALL    SEND_CHAR            
        MOVLW   ' '
        CALL    SEND_CHAR
        MOVLW   'A'
        CALL    SEND_CHAR             
        MOVLW   'y'
        CALL    SEND_CHAR
        MOVLW   'e'
        CALL    SEND_CHAR
        MOVLW   's'
        CALL    SEND_CHAR     
        MOVLW   't'
        CALL    SEND_CHAR             
        MOVLW   'a'
        CALL    SEND_CHAR             
        MOVLW   'r'
        CALL    SEND_CHAR             
        MOVLW   'a'
        CALL    SEND_CHAR             
        MOVLW   'n'
        CALL    SEND_CHAR             
        ;MOVLW   0
        ;CALL    SEND_CHAR
        CALL     DELAY50
        CALL     DELAY50
        CALL     DELAY50
        RETURN

MODE_PAGE
	    MOVLW   '5'
        CALL    SEND_CHAR             
        MOVLW   's'
        CALL    SEND_CHAR             
        MOVLW   'e'
        CALL    SEND_CHAR             
        MOVLW   'c'
        CALL    SEND_CHAR             
        MOVLW   ' '
        CALL    SEND_CHAR
        MOVLW   'T'
        CALL    SEND_CHAR             
        MOVLW   'i'
        CALL    SEND_CHAR             
        MOVLW   'm'
        CALL    SEND_CHAR             
        MOVLW   'e'
        CALL    SEND_CHAR             
        MOVLW   'd'
        CALL    SEND_CHAR
        MOVLW   ' '
        CALL    SEND_CHAR             
        MOVLW   'M'
        CALL    SEND_CHAR
        MOVLW   'o'
        CALL    SEND_CHAR
        MOVLW   'd'
        CALL    SEND_CHAR     
        MOVLW   'e'
        CALL    SEND_CHAR             
        MOVLW   '?'
        CALL    SEND_CHAR   
          
        MOVLW   LINE2
        CALL    GOTO_LINE

        MOVLW   'G'
        CALL    SEND_CHAR
        MOVLW   'r'
        CALL    SEND_CHAR             
        MOVLW   'e'
        CALL    SEND_CHAR             
        MOVLW   'e'
        CALL    SEND_CHAR             
        MOVLW   'n'
        CALL    SEND_CHAR 
        MOVLW   '='
        CALL    SEND_CHAR            
        MOVLW   'Y'
        CALL    SEND_CHAR
        MOVLW   'e'
        CALL    SEND_CHAR             
        MOVLW   's'
        CALL    SEND_CHAR
        MOVLW   '/'
        CALL    SEND_CHAR
        MOVLW   'R'
        CALL    SEND_CHAR     
        MOVLW   'e'
        CALL    SEND_CHAR             
        MOVLW   'd'
        CALL    SEND_CHAR             
        MOVLW   '='
        CALL    SEND_CHAR             
        MOVLW   'N'
        CALL    SEND_CHAR             
        MOVLW   '0'
        CALL    SEND_CHAR             
        RETURN

GREEN_BUTTON
        BSF     PORTIOB,BIT7     ;GREEN LED ON
GREEN_BUTTON_WAIT_FOR_DEPRESS
        CALL    DELAY
        BTFSS   PORTIOA,BIT1
        GOTO    GREEN_BUTTON_WAIT_FOR_DEPRESS        
        BCF     PORTIOB,BIT7     ;GREEN LED OFF
        MOVLW   1
        MOVWF    TIMED_MODE	
        RETURN  

RED_BUTTON
        BSF     PORTIOB,BIT6     ;RED LED ON
RED_BUTTON_WAIT_FOR_DEPRESS
        CALL	DELAY
        BTFSS   PORTIOA,BIT0
        GOTO    RED_BUTTON_WAIT_FOR_DEPRESS       
        BCF     PORTIOB,BIT6     ;RED LED OFF
        MOVLW   2
        MOVWF   TIMED_MODE        
        RETURN

MAIN

;== DEFINE PORT-A (A0-A4) ==
;===========================

TRISA       EQU     85H
PORTIOA     EQU     05H

;==== DECLARE VARIABLES ====
;===========================

COUNT           EQU 015H
INDEX           EQU 016H
HUNDREDS        EQU 017H
TENS            EQU 018H
NUMERIC         EQU 019H
TIMED_MODE      EQU 4

SET_PORTIOAIN
        CLRF    PORTIOA         ;ENSURE PORT IS CLEAR
        MOVLW   B'00011111'     ;SET UP A0-A4 AS INPUTS
        ;TRIS    PORTIOA         ;DO IT    
        BANKSEL  TRISA
        MOVWF    PORTIOA
     
        CALL INITIALISE_LCD

        BSF     PORTIOB,BIT6     ;RED LED ON
        BSF     PORTIOB,BIT7     ;GREED LED ON
        CALL    DELAY10
        BCF     PORTIOB,BIT6     ;RED LED OFF
        BCF     PORTIOB,BIT7     ;GREED LED OFF

SPLASH
        MOVLW   DISPLAY_ON
        CALL    SET_DISPLAY
        CALL    TITLE_PAGE    ;DISPLAY TITLE PAGE
        CALL    DELAY10

DISPLAY_MODE_PAGE
        CALL    CLEAR_DISPLAY
		CALL    MODE_PAGE    ;DISPLAY TITLE PAGE
		MOVLW   4
        MOVWF   TIMED_MODE
 
CHECK_MODE    
        CALL	DELAY
        BTFSS   PORTIOA,BIT1                   ;TEST PORTA BIT1
        CALL    GREEN_BUTTON                   ;IF BIT1 IS SET LO THEN CALL GREEN_BUTTON
        BTFSC   TIMED_MODE,BIT0                ;TEST PORTA BIT1
        GOTO    DISPLAY_TIMED_RANDOM_BINARY    ;IF BIT1 IS SET LO THEN GOTO DISPLAY_TIMED_RANDOM_BINARY
        
        BTFSS   PORTIOA,BIT0                   ;TEST PORTA BIT0
        CALL    RED_BUTTON                     ;IF BIT0 IS SET LO THEN CALL RED_BUTTON
        BTFSC   TIMED_MODE,BIT1                ;TEST PORTA BIT0
        GOTO    DISPLAY_RANDOM_BINARY          ;IF BIT0 IS SET LO THEN GOTO DISPLAY_RANDOM_BINARY        
        
        MOVLW   COUNT
		INCF    COUNT,W
		MOVWF   COUNT
		MOVWF   HUNDREDS
		MOVWF   TENS
	
        GOTO    CHECK_MODE

CONVERT_DECIMAL_TO_BINARY

        CALL    CLEAR_DISPLAY
		MOVLW   'C'
        CALL    SEND_CHAR             
        MOVLW   'o'
        CALL    SEND_CHAR             
        MOVLW   'n'
        CALL    SEND_CHAR             
        MOVLW   'v'
        CALL    SEND_CHAR             
        MOVLW   'e'
        CALL    SEND_CHAR
        MOVLW   'r'
        CALL    SEND_CHAR
        MOVLW   't'
        CALL    SEND_CHAR
        MOVLW   ' '
        CALL    SEND_CHAR
        
        MOVLW   '1'
		BTFSS   COUNT,BIT7
        MOVLW   '0'  
		CALL    SEND_CHAR
        MOVLW   '1'
		BTFSS   COUNT,BIT6
        MOVLW   '0'  
		CALL    SEND_CHAR
        MOVLW   '1'
		BTFSS   COUNT,BIT5
        MOVLW   '0'  
		CALL    SEND_CHAR
        MOVLW   '1'
		BTFSS   COUNT,BIT4
        MOVLW   '0'  
		CALL    SEND_CHAR
		MOVLW   '1'
		BTFSS   COUNT,BIT3
        MOVLW   '0'  
		CALL    SEND_CHAR
        MOVLW   '1'
		BTFSS   COUNT,BIT2
        MOVLW   '0'  
		CALL    SEND_CHAR
        MOVLW   '1'
		BTFSS   COUNT,BIT1
        MOVLW   '0'  
		CALL    SEND_CHAR
        MOVLW   '1'
		BTFSS   COUNT,BIT0
        MOVLW   '0'  
		CALL    SEND_CHAR
        MOVLW   LINE2
        CALL    GOTO_LINE
        RETURN

DISPLAY_DECIMAL
        CALL    CLEAR_DISPLAY
        MOVLW   'A'
        CALL    SEND_CHAR
        MOVLW   'n'
        CALL    SEND_CHAR             
        MOVLW   's'
        CALL    SEND_CHAR             
        MOVLW   'w'
        CALL    SEND_CHAR             
        MOVLW   'e'
        CALL    SEND_CHAR 
        MOVLW   'r'
        CALL    SEND_CHAR            
        MOVLW   ' '
        CALL    SEND_CHAR
        MOVLW   'i'
        CALL    SEND_CHAR             
        MOVLW   's'
        CALL    SEND_CHAR
		MOVLW   '.'
        CALL    SEND_CHAR
        MOVLW   '.'
        CALL    SEND_CHAR
        MOVLW   '.'
        CALL    SEND_CHAR 
        MOVLW   ' '
        CALL    SEND_CHAR
	
		CLRF    INDEX
		CLRF    NUMERIC
COUNT_HUNDREDS_LOOP	
        CALL	DELAY
		INCF	INDEX,F
		INCF    NUMERIC,F
		MOVLW   .100
		SUBWF   HUNDREDS,F
		BTFSC	STATUS,C
		GOTO 	COUNT_HUNDREDS_LOOP	
		DECF	NUMERIC,F
		CLRF    HUNDREDS		
		MOVLW   .48
		ADDWF   NUMERIC,W       
        MOVWF   NUMERIC
        CALL    SEND_CHAR

        BTFSS   INDEX,BIT1
        GOTO    VALUE_LESS_THAN_100

REMOVE_HUNDREDS
        CALL	DELAY
        MOVLW   .100
        SUBWF   TENS,W
        MOVWF   TENS
        DECF	INDEX,F
        BTFSS	INDEX,C
        GOTO    REMOVE_HUNDREDS

VALUE_LESS_THAN_100
		CLRF    INDEX
		CLRF    NUMERIC
	
COUNT_TENS_LOOP	
        CALL	DELAY
		INCF	INDEX,F
		INCF    NUMERIC,F
		MOVLW   .10
		SUBWF   TENS,F
		BTFSC	STATUS,C
		GOTO 	COUNT_TENS_LOOP	
	
		DECF	NUMERIC,F		
		MOVLW   .48
		ADDWF   NUMERIC,W       
        MOVWF   NUMERIC
        CALL    SEND_CHAR

        MOVLW   .10
		ADDWF   TENS,W       
        MOVWF   TENS

		MOVLW   .48
		ADDWF   TENS,W       
        MOVWF   TENS
        CALL    SEND_CHAR
        CLRF    TENS
        CLRF    INDEX

        MOVLW   LINE2
        CALL    GOTO_LINE

        MOVLW   'P'
        CALL    SEND_CHAR
        MOVLW   'r'
        CALL    SEND_CHAR             
        MOVLW   'e'
        CALL    SEND_CHAR             
        MOVLW   's'
        CALL    SEND_CHAR             
        MOVLW   's'
        CALL    SEND_CHAR 
        MOVLW   ' '
        CALL    SEND_CHAR            
        MOVLW   'r'
        CALL    SEND_CHAR
        MOVLW   'e'
        CALL    SEND_CHAR             
        MOVLW   'd'
        CALL    SEND_CHAR
        MOVLW   ' '
        CALL    SEND_CHAR
        MOVLW   't'
        CALL    SEND_CHAR     
        MOVLW   'o'
        CALL    SEND_CHAR             
        MOVLW   ' '
        CALL    SEND_CHAR             
        MOVLW   'e'
        CALL    SEND_CHAR             
        MOVLW   'n'
        CALL    SEND_CHAR             
        MOVLW   'd'
        CALL    SEND_CHAR       
        RETURN

DISPLAY_RANDOM_BINARY
        
        CALL    CONVERT_DECIMAL_TO_BINARY
        
        MOVLW   LINE2
        CALL    GOTO_LINE	         
    	MOVLW   'G'
        CALL    SEND_CHAR             
        MOVLW   'r'
        CALL    SEND_CHAR             
        MOVLW   'e'
        CALL    SEND_CHAR             
        MOVLW   'e'
        CALL    SEND_CHAR             
        MOVLW   'n'
        CALL    SEND_CHAR             
        MOVLW   ' '
        CALL    SEND_CHAR             
        MOVLW   'f'
        CALL    SEND_CHAR             
        MOVLW   'o'
        CALL    SEND_CHAR             
        MOVLW   'r'
        CALL    SEND_CHAR             
        MOVLW   ' '
        CALL    SEND_CHAR             
        MOVLW   'a'
        CALL    SEND_CHAR             
        MOVLW   'n'
        CALL    SEND_CHAR             
        MOVLW   's'
        CALL    SEND_CHAR             
        MOVLW   'w'
        CALL    SEND_CHAR             
        MOVLW   'e'
        CALL    SEND_CHAR             
        MOVLW   'r'
        CALL    SEND_CHAR             

DISPLAY_RANDOM_BINARY_LOOP
        CALL	DELAY
        BTFSS   PORTIOA,BIT1       ;TEST PORTA BIT1
        CALL    GREEN_BUTTON       ;IF BIT1 IS SET LO THEN CALL GREEN_BUTTON
        BTFSC   TIMED_MODE,BIT0    ;TEST PORTA BIT1
        GOTO    REVEAL_ANSWER      ;IF BIT1 IS SET LO THEN GOTO REVEAL_ANSWER
        
        GOTO    DISPLAY_RANDOM_BINARY_LOOP

DISPLAY_TIMED_RANDOM_BINARY

        CALL    CONVERT_DECIMAL_TO_BINARY
        MOVLW   LINE2
        CALL    GOTO_LINE	         
    	MOVLW   'A'
        CALL    SEND_CHAR             
        MOVLW   'n'
        CALL    SEND_CHAR             
        MOVLW   's'
        CALL    SEND_CHAR             
        MOVLW   'w'
        CALL    SEND_CHAR             
        MOVLW   'e'
        CALL    SEND_CHAR             
        MOVLW   'r'
        CALL    SEND_CHAR             
        MOVLW   ' '
        CALL    SEND_CHAR             
        MOVLW   'i'
        CALL    SEND_CHAR             
        MOVLW   'n'
        CALL    SEND_CHAR             
        MOVLW   ' '
        CALL    SEND_CHAR             
        MOVLW   '5'
        CALL    SEND_CHAR             
       		   
DISPLAY_TIMED_RANDOM_BINARY_LOOP
        
        CALL    DELAY50
        CALL    DELAY10
        MOVLW   LEFT
        CALL    MOVE_CURSOR
        CALL	DELAY
        MOVLW   '4'
        CALL    SEND_CHAR

        CALL    DELAY50
        CALL    DELAY10
        MOVLW   LEFT
        CALL    MOVE_CURSOR
        CALL	DELAY
        MOVLW   '3'
        CALL    SEND_CHAR

        CALL    DELAY50
        CALL    DELAY10
        MOVLW   LEFT
        CALL    MOVE_CURSOR
        CALL	DELAY
        MOVLW   '2'
        CALL    SEND_CHAR

        CALL    DELAY50
        CALL    DELAY10
        MOVLW   LEFT
        CALL    MOVE_CURSOR
        CALL	DELAY
        MOVLW   '1'
        CALL    SEND_CHAR

        CALL    DELAY50
        CALL    DELAY10
        ;GOTO    REVEAL_ANSWER

REVEAL_ANSWER
        CALL    DISPLAY_DECIMAL

END_PROMPT   
        CALL	DELAY
        BTFSS   PORTIOA,BIT0          ;TEST PORTA BIT0
        CALL    RED_BUTTON            ;IF BIT0 IS SET LO THEN CALL RED_BUTTON
        BTFSC   TIMED_MODE,BIT1       ;TEST PORTA BIT0
        GOTO    DISPLAY_MODE_PAGE     ;IF BIT0 IS SET LO THEN GOTO DISPLAY_MODE_PAGE        

        GOTO    END_PROMPT

        END
   