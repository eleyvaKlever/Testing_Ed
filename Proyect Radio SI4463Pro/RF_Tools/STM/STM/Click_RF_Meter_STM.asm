_systemInit:
;Click_RF_Meter_STM.c,31 :: 		void systemInit()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Click_RF_Meter_STM.c,33 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_AN_PIN, _GPIO_INPUT );
MOVS	R2, #1
MOVS	R1, #0
MOVS	R0, #0
BL	_mikrobus_gpioInit+0
;Click_RF_Meter_STM.c,34 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_CS_PIN, _GPIO_OUTPUT );
MOVS	R2, #0
MOVS	R1, #2
MOVS	R0, #0
BL	_mikrobus_gpioInit+0
;Click_RF_Meter_STM.c,36 :: 		mikrobus_spiInit( _MIKROBUS1, &_RFMETER_SPI_CFG[0] );
MOVW	R0, #lo_addr(__RFMETER_SPI_CFG+0)
MOVT	R0, #hi_addr(__RFMETER_SPI_CFG+0)
MOV	R1, R0
MOVS	R0, #0
BL	_mikrobus_spiInit+0
;Click_RF_Meter_STM.c,38 :: 		mikrobus_logInit( _LOG_USBUART_A, 115200 );
MOV	R1, #115200
MOVS	R0, #32
BL	_mikrobus_logInit+0
;Click_RF_Meter_STM.c,40 :: 		Delay_ms( 100 );
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_systemInit0:
SUBS	R7, R7, #1
BNE	L_systemInit0
NOP
NOP
NOP
;Click_RF_Meter_STM.c,41 :: 		}
L_end_systemInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _systemInit
_applicationInit:
;Click_RF_Meter_STM.c,43 :: 		void applicationInit()
SUB	SP, SP, #108
STR	LR, [SP, #0]
;Click_RF_Meter_STM.c,45 :: 		rfmeter_spiDriverInit( (T_RFMETER_P)&_MIKROBUS1_GPIO, (T_RFMETER_P)&_MIKROBUS1_SPI );
MOVW	R1, #lo_addr(__MIKROBUS1_SPI+0)
MOVT	R1, #hi_addr(__MIKROBUS1_SPI+0)
MOVW	R0, #lo_addr(__MIKROBUS1_GPIO+0)
MOVT	R0, #hi_addr(__MIKROBUS1_GPIO+0)
BL	_rfmeter_spiDriverInit+0
;Click_RF_Meter_STM.c,46 :: 		Delay_ms( 100 );
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_applicationInit2:
SUBS	R7, R7, #1
BNE	L_applicationInit2
NOP
NOP
NOP
;Click_RF_Meter_STM.c,47 :: 		mikrobus_logWrite( "---------------------------------", _LOG_LINE );
ADD	R11, SP, #4
ADD	R10, R11, #34
MOVW	R12, #lo_addr(?ICS?lstr1_Click_RF_Meter_STM+0)
MOVT	R12, #hi_addr(?ICS?lstr1_Click_RF_Meter_STM+0)
BL	___CC2DW+0
ADD	R0, SP, #4
MOVS	R1, #2
BL	_mikrobus_logWrite+0
;Click_RF_Meter_STM.c,48 :: 		mikrobus_logWrite( "          RF Meter Click         ", _LOG_LINE );
ADD	R11, SP, #38
ADD	R10, R11, #34
MOVW	R12, #lo_addr(?ICS?lstr2_Click_RF_Meter_STM+0)
MOVT	R12, #hi_addr(?ICS?lstr2_Click_RF_Meter_STM+0)
BL	___CC2DW+0
ADD	R0, SP, #38
MOVS	R1, #2
BL	_mikrobus_logWrite+0
;Click_RF_Meter_STM.c,49 :: 		mikrobus_logWrite( "---------------------------------", _LOG_LINE );
ADD	R11, SP, #72
ADD	R10, R11, #34
MOVW	R12, #lo_addr(?ICS?lstr3_Click_RF_Meter_STM+0)
MOVT	R12, #hi_addr(?ICS?lstr3_Click_RF_Meter_STM+0)
BL	___CC2DW+0
ADD	R0, SP, #72
MOVS	R1, #2
BL	_mikrobus_logWrite+0
;Click_RF_Meter_STM.c,50 :: 		}
L_end_applicationInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #108
BX	LR
; end of _applicationInit
_applicationTask:
;Click_RF_Meter_STM.c,52 :: 		void applicationTask()
SUB	SP, SP, #52
STR	LR, [SP, #0]
;Click_RF_Meter_STM.c,54 :: 		signal = rfmeter_getSignalStrenght( _RFMETER_DEF_SLOPE, _RFMETER_DEF_INTERCEPT );
MOVW	R1, #0
MOVT	R1, #16800
MOVW	R0, #52429
MOVT	R0, #48332
BL	_rfmeter_getSignalStrenght+0
MOVW	R1, #lo_addr(_signal+0)
MOVT	R1, #hi_addr(_signal+0)
STR	R0, [R1, #0]
;Click_RF_Meter_STM.c,56 :: 		mikrobus_logWrite( "Signal strenght: ", _LOG_TEXT );
ADD	R11, SP, #4
ADD	R10, R11, #18
MOVW	R12, #lo_addr(?ICS?lstr4_Click_RF_Meter_STM+0)
MOVT	R12, #hi_addr(?ICS?lstr4_Click_RF_Meter_STM+0)
BL	___CC2DW+0
ADD	R0, SP, #4
MOVS	R1, #1
BL	_mikrobus_logWrite+0
;Click_RF_Meter_STM.c,57 :: 		FloatToStr( signal, logTxt );
MOVW	R0, #lo_addr(_signal+0)
MOVT	R0, #hi_addr(_signal+0)
LDR	R0, [R0, #0]
MOVW	R1, #lo_addr(_logTxt+0)
MOVT	R1, #hi_addr(_logTxt+0)
BL	_FloatToStr+0
;Click_RF_Meter_STM.c,58 :: 		mikrobus_logWrite( logTxt, _LOG_TEXT );
MOVS	R1, #1
MOVW	R0, #lo_addr(_logTxt+0)
MOVT	R0, #hi_addr(_logTxt+0)
BL	_mikrobus_logWrite+0
;Click_RF_Meter_STM.c,59 :: 		mikrobus_logWrite( "dBm", _LOG_LINE );
MOVS	R0, #100
STRB	R0, [SP, #22]
MOVS	R0, #66
STRB	R0, [SP, #23]
MOVS	R0, #109
STRB	R0, [SP, #24]
MOVS	R0, #0
STRB	R0, [SP, #25]
ADD	R0, SP, #22
MOVS	R1, #2
BL	_mikrobus_logWrite+0
;Click_RF_Meter_STM.c,61 :: 		Delay_ms( 100 );
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_applicationTask4:
SUBS	R7, R7, #1
BNE	L_applicationTask4
NOP
NOP
NOP
;Click_RF_Meter_STM.c,62 :: 		mikrobus_logWrite( "-----------------------", _LOG_LINE );
ADD	R11, SP, #26
ADD	R10, R11, #24
MOVW	R12, #lo_addr(?ICS?lstr6_Click_RF_Meter_STM+0)
MOVT	R12, #hi_addr(?ICS?lstr6_Click_RF_Meter_STM+0)
BL	___CC2DW+0
ADD	R0, SP, #26
MOVS	R1, #2
BL	_mikrobus_logWrite+0
;Click_RF_Meter_STM.c,63 :: 		}
L_end_applicationTask:
LDR	LR, [SP, #0]
ADD	SP, SP, #52
BX	LR
; end of _applicationTask
_main:
;Click_RF_Meter_STM.c,65 :: 		void main()
;Click_RF_Meter_STM.c,67 :: 		systemInit();
BL	_systemInit+0
;Click_RF_Meter_STM.c,68 :: 		applicationInit();
BL	_applicationInit+0
;Click_RF_Meter_STM.c,70 :: 		while (1)
L_main6:
;Click_RF_Meter_STM.c,72 :: 		applicationTask();
BL	_applicationTask+0
;Click_RF_Meter_STM.c,73 :: 		}
IT	AL
BAL	L_main6
;Click_RF_Meter_STM.c,74 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
