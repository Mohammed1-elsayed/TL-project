
_clear:

;Project_SW.c,29 :: 		void clear(){
;Project_SW.c,30 :: 		WEST_GREEN = 0;
	BCF        PORTD+0, 5
;Project_SW.c,31 :: 		SOUTH_RED = 0;
	BCF        PORTD+0, 0
;Project_SW.c,32 :: 		WEST_RED = 0;
	BCF        PORTD+0, 3
;Project_SW.c,33 :: 		SOUTH_YELLOW = 0;
	BCF        PORTD+0, 1
;Project_SW.c,34 :: 		SOUTH_GREEN = 0;
	BCF        PORTD+0, 2
;Project_SW.c,35 :: 		WEST_YELLOW = 0;
	BCF        PORTD+0, 4
;Project_SW.c,36 :: 		}
L_end_clear:
	RETURN
; end of _clear

_main:

;Project_SW.c,37 :: 		void main() {
;Project_SW.c,38 :: 		trisb = 0b00000000;
	CLRF       TRISB+0
;Project_SW.c,39 :: 		trisD = 0b00000000;
	CLRF       TRISD+0
;Project_SW.c,40 :: 		trisc = 0b00110000;
	MOVLW      48
	MOVWF      TRISC+0
;Project_SW.c,41 :: 		portC = 15;
	MOVLW      15
	MOVWF      PORTC+0
;Project_SW.c,42 :: 		portB = 0;
	CLRF       PORTB+0
;Project_SW.c,43 :: 		portD = 0;
	CLRF       PORTD+0
;Project_SW.c,45 :: 		while(1){
L_main0:
;Project_SW.c,46 :: 		if (AUTO_MANU_SW == 1) {
	BTFSS      PORTC+0, 4
	GOTO       L_main2
;Project_SW.c,47 :: 		portC = 15;
	MOVLW      15
	MOVWF      PORTC+0
;Project_SW.c,48 :: 		Clear();
	CALL       _clear+0
;Project_SW.c,49 :: 		can_ = 1;
	MOVLW      1
	MOVWF      _can_+0
;Project_SW.c,50 :: 		Auto();
	CALL       _Auto+0
;Project_SW.c,51 :: 		}else {
	GOTO       L_main3
L_main2:
;Project_SW.c,52 :: 		Manual();
	CALL       _manual+0
;Project_SW.c,53 :: 		}
L_main3:
;Project_SW.c,54 :: 		}
	GOTO       L_main0
;Project_SW.c,55 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_manual:

;Project_SW.c,56 :: 		void manual(){
;Project_SW.c,57 :: 		if(can_ == 1){
	MOVF       _can_+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_manual4
;Project_SW.c,58 :: 		can_ = 0;
	CLRF       _can_+0
;Project_SW.c,59 :: 		change = MANUAL_SW;
	MOVLW      0
	BTFSC      PORTC+0, 5
	MOVLW      1
	MOVWF      _change+0
;Project_SW.c,60 :: 		if(MANUAL_SW == 1){
	BTFSS      PORTC+0, 5
	GOTO       L_manual5
;Project_SW.c,61 :: 		portC.B0 = 0;
	BCF        PORTC+0, 0
;Project_SW.c,62 :: 		portC.B1 = 0;
	BCF        PORTC+0, 1
;Project_SW.c,63 :: 		portC.B2 = 1;
	BSF        PORTC+0, 2
;Project_SW.c,64 :: 		portC.B3 = 1;
	BSF        PORTC+0, 3
;Project_SW.c,65 :: 		SOUTH_YELLOW = 0;
	BCF        PORTD+0, 1
;Project_SW.c,66 :: 		SOUTH_GREEN = 0;
	BCF        PORTD+0, 2
;Project_SW.c,67 :: 		WEST_RED = 0;
	BCF        PORTD+0, 3
;Project_SW.c,68 :: 		SOUTH_RED = 1;
	BSF        PORTD+0, 0
;Project_SW.c,69 :: 		WEST_YELLOW = 1;
	BSF        PORTD+0, 4
;Project_SW.c,70 :: 		for(i = 1; i <= 3; i++){
	MOVLW      1
	MOVWF      _i+0
L_manual6:
	MOVF       _i+0, 0
	SUBLW      3
	BTFSS      STATUS+0, 0
	GOTO       L_manual7
;Project_SW.c,71 :: 		portB = i;
	MOVF       _i+0, 0
	MOVWF      PORTB+0
;Project_SW.c,72 :: 		if(change  != MANUAL_SW || AUTO_MANU_SW == 1) break;
	CLRF       R1+0
	BTFSC      PORTC+0, 5
	INCF       R1+0, 1
	MOVF       _change+0, 0
	XORWF      R1+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__manual35
	BTFSC      PORTC+0, 4
	GOTO       L__manual35
	GOTO       L_manual11
L__manual35:
	GOTO       L_manual7
L_manual11:
;Project_SW.c,73 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_manual12:
	DECFSZ     R13+0, 1
	GOTO       L_manual12
	DECFSZ     R12+0, 1
	GOTO       L_manual12
	DECFSZ     R11+0, 1
	GOTO       L_manual12
	NOP
	NOP
;Project_SW.c,70 :: 		for(i = 1; i <= 3; i++){
	INCF       _i+0, 1
;Project_SW.c,74 :: 		}
	GOTO       L_manual6
L_manual7:
;Project_SW.c,75 :: 		portB = 0;
	CLRF       PORTB+0
;Project_SW.c,76 :: 		WEST_YELLOW = 0;
	BCF        PORTD+0, 4
;Project_SW.c,77 :: 		WEST_GREEN = 1;
	BSF        PORTD+0, 5
;Project_SW.c,78 :: 		}else{
	GOTO       L_manual13
L_manual5:
;Project_SW.c,79 :: 		portC.B0 = 1;
	BSF        PORTC+0, 0
;Project_SW.c,80 :: 		portC.B1 = 1;
	BSF        PORTC+0, 1
;Project_SW.c,81 :: 		portC.B2 = 0;
	BCF        PORTC+0, 2
;Project_SW.c,82 :: 		portC.B3 = 0;
	BCF        PORTC+0, 3
;Project_SW.c,83 :: 		WEST_GREEN = 0;
	BCF        PORTD+0, 5
;Project_SW.c,84 :: 		WEST_YELLOW = 0;
	BCF        PORTD+0, 4
;Project_SW.c,85 :: 		SOUTH_RED = 0;
	BCF        PORTD+0, 0
;Project_SW.c,86 :: 		WEST_RED = 1;
	BSF        PORTD+0, 3
;Project_SW.c,87 :: 		SOUTH_YELLOW = 1;
	BSF        PORTD+0, 1
;Project_SW.c,88 :: 		for(i = 1; i <= 3; i++){
	MOVLW      1
	MOVWF      _i+0
L_manual14:
	MOVF       _i+0, 0
	SUBLW      3
	BTFSS      STATUS+0, 0
	GOTO       L_manual15
;Project_SW.c,89 :: 		portB = i;
	MOVF       _i+0, 0
	MOVWF      PORTB+0
;Project_SW.c,90 :: 		if(change  != MANUAL_SW || AUTO_MANU_SW == 1) break;
	CLRF       R1+0
	BTFSC      PORTC+0, 5
	INCF       R1+0, 1
	MOVF       _change+0, 0
	XORWF      R1+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__manual34
	BTFSC      PORTC+0, 4
	GOTO       L__manual34
	GOTO       L_manual19
L__manual34:
	GOTO       L_manual15
L_manual19:
;Project_SW.c,91 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_manual20:
	DECFSZ     R13+0, 1
	GOTO       L_manual20
	DECFSZ     R12+0, 1
	GOTO       L_manual20
	DECFSZ     R11+0, 1
	GOTO       L_manual20
	NOP
	NOP
;Project_SW.c,88 :: 		for(i = 1; i <= 3; i++){
	INCF       _i+0, 1
;Project_SW.c,92 :: 		}
	GOTO       L_manual14
L_manual15:
;Project_SW.c,93 :: 		portB = 0;
	CLRF       PORTB+0
;Project_SW.c,94 :: 		SOUTH_YELLOW = 0;
	BCF        PORTD+0, 1
;Project_SW.c,95 :: 		SOUTH_GREEN = 1;
	BSF        PORTD+0, 2
;Project_SW.c,96 :: 		}
L_manual13:
;Project_SW.c,97 :: 		}
L_manual4:
;Project_SW.c,98 :: 		if(change  != MANUAL_SW) {can_ = 1;}
	CLRF       R1+0
	BTFSC      PORTC+0, 5
	INCF       R1+0, 1
	MOVF       _change+0, 0
	XORWF      R1+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_manual21
	MOVLW      1
	MOVWF      _can_+0
L_manual21:
;Project_SW.c,99 :: 		}
L_end_manual:
	RETURN
; end of _manual

_Auto:

;Project_SW.c,100 :: 		void Auto(){
;Project_SW.c,101 :: 		WEST_GREEN = 0;
	BCF        PORTD+0, 5
;Project_SW.c,102 :: 		SOUTH_RED = 1;
	BSF        PORTD+0, 0
;Project_SW.c,103 :: 		WEST_RED = 0;
	BCF        PORTD+0, 3
;Project_SW.c,104 :: 		SOUTH_YELLOW = 0;
	BCF        PORTD+0, 1
;Project_SW.c,105 :: 		SOUTH_GREEN = 0;
	BCF        PORTD+0, 2
;Project_SW.c,106 :: 		WEST_YELLOW = 1;
	BSF        PORTD+0, 4
;Project_SW.c,107 :: 		j = 0;
	CLRF       _j+0
;Project_SW.c,108 :: 		tens = 0;
	CLRF       _tens+0
;Project_SW.c,109 :: 		for(i = 0; i < 38; i++){
	CLRF       _i+0
L_Auto22:
	MOVLW      38
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Auto23
;Project_SW.c,110 :: 		if(AUTO_MANU_SW == 0) {
	BTFSC      PORTC+0, 4
	GOTO       L_Auto25
;Project_SW.c,111 :: 		portB = 0;
	CLRF       PORTB+0
;Project_SW.c,112 :: 		clear();
	CALL       _clear+0
;Project_SW.c,113 :: 		break;
	GOTO       L_Auto23
;Project_SW.c,114 :: 		}
L_Auto25:
;Project_SW.c,115 :: 		j++;
	INCF       _j+0, 1
;Project_SW.c,116 :: 		PORTB = j + tens;
	MOVF       _tens+0, 0
	ADDWF      _j+0, 0
	MOVWF      PORTB+0
;Project_SW.c,117 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_Auto26:
	DECFSZ     R13+0, 1
	GOTO       L_Auto26
	DECFSZ     R12+0, 1
	GOTO       L_Auto26
	DECFSZ     R11+0, 1
	GOTO       L_Auto26
	NOP
	NOP
;Project_SW.c,118 :: 		tmp = (tens / 16 )* 10;
	MOVF       _tens+0, 0
	MOVWF      R0+0
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	MOVLW      10
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVF       R0+0, 0
	MOVWF      _tmp+0
;Project_SW.c,119 :: 		if(j + tmp == 3){
	MOVF       R0+0, 0
	ADDWF      _j+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSC      STATUS+0, 0
	INCF       R1+1, 1
	MOVLW      0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Auto40
	MOVLW      3
	XORWF      R1+0, 0
L__Auto40:
	BTFSS      STATUS+0, 2
	GOTO       L_Auto27
;Project_SW.c,120 :: 		WEST_YELLOW = 0;
	BCF        PORTD+0, 4
;Project_SW.c,121 :: 		WEST_GREEN = 1;
	BSF        PORTD+0, 5
;Project_SW.c,122 :: 		}else if(j + tmp == 23){
	GOTO       L_Auto28
L_Auto27:
	MOVF       _tmp+0, 0
	ADDWF      _j+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSC      STATUS+0, 0
	INCF       R1+1, 1
	MOVLW      0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Auto41
	MOVLW      23
	XORWF      R1+0, 0
L__Auto41:
	BTFSS      STATUS+0, 2
	GOTO       L_Auto29
;Project_SW.c,123 :: 		WEST_GREEN = 0;
	BCF        PORTD+0, 5
;Project_SW.c,124 :: 		WEST_RED = 1;
	BSF        PORTD+0, 3
;Project_SW.c,125 :: 		SOUTH_RED = 0;
	BCF        PORTD+0, 0
;Project_SW.c,126 :: 		SOUTH_YELLOW = 1;
	BSF        PORTD+0, 1
;Project_SW.c,127 :: 		}else if(j + tmp == 26){
	GOTO       L_Auto30
L_Auto29:
	MOVF       _tmp+0, 0
	ADDWF      _j+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSC      STATUS+0, 0
	INCF       R1+1, 1
	MOVLW      0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Auto42
	MOVLW      26
	XORWF      R1+0, 0
L__Auto42:
	BTFSS      STATUS+0, 2
	GOTO       L_Auto31
;Project_SW.c,128 :: 		SOUTH_YELLOW = 0;
	BCF        PORTD+0, 1
;Project_SW.c,129 :: 		SOUTH_GREEN = 1;
	BSF        PORTD+0, 2
;Project_SW.c,130 :: 		}
L_Auto31:
L_Auto30:
L_Auto28:
;Project_SW.c,131 :: 		if(j == 9){
	MOVF       _j+0, 0
	XORLW      9
	BTFSS      STATUS+0, 2
	GOTO       L_Auto32
;Project_SW.c,132 :: 		tens += c_;
	MOVF       _c_+0, 0
	ADDWF      _tens+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _tens+0
;Project_SW.c,133 :: 		j = 0;
	CLRF       _j+0
;Project_SW.c,134 :: 		PORTB = j + tens;
	MOVF       R0+0, 0
	MOVWF      PORTB+0
;Project_SW.c,135 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_Auto33:
	DECFSZ     R13+0, 1
	GOTO       L_Auto33
	DECFSZ     R12+0, 1
	GOTO       L_Auto33
	DECFSZ     R11+0, 1
	GOTO       L_Auto33
	NOP
	NOP
;Project_SW.c,136 :: 		i++;
	INCF       _i+0, 1
;Project_SW.c,137 :: 		}
L_Auto32:
;Project_SW.c,109 :: 		for(i = 0; i < 38; i++){
	INCF       _i+0, 1
;Project_SW.c,138 :: 		}
	GOTO       L_Auto22
L_Auto23:
;Project_SW.c,139 :: 		clear();
	CALL       _clear+0
;Project_SW.c,140 :: 		}
L_end_Auto:
	RETURN
; end of _Auto
