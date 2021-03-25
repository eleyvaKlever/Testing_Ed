_main:
;RF4463PRO.c,467 :: 		void main()
SUB	SP, SP, #20
;RF4463PRO.c,470 :: 		asm{nop};
NOP
;RF4463PRO.c,471 :: 		asm{nop};
NOP
;RF4463PRO.c,472 :: 		asm{nop};
NOP
;RF4463PRO.c,473 :: 		asm{nop};
NOP
;RF4463PRO.c,474 :: 		asm{nop};
NOP
;RF4463PRO.c,476 :: 		portInit();
BL	_portInit+0
;RF4463PRO.c,477 :: 		nop_10();
BL	_nop_10+0
;RF4463PRO.c,478 :: 		UART1_Write_Text("Start Demo System\n\r");
ADD	R11, SP, #0
ADD	R10, R11, #20
MOVW	R12, #lo_addr(?ICS?lstr1_RF4463PRO+0)
MOVT	R12, #hi_addr(?ICS?lstr1_RF4463PRO+0)
BL	___CC2DW+0
ADD	R0, SP, #0
BL	_UART1_Write_Text+0
;RF4463PRO.c,479 :: 		Sound_Init(&GPIOB_ODR, 7);
MOVS	R1, #7
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
BL	_Sound_Init+0
;RF4463PRO.c,480 :: 		LED_GREEN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;RF4463PRO.c,481 :: 		Sound_Play(3000, 100);
MOVS	R1, #100
MOVW	R0, #3000
BL	_Sound_Play+0
;RF4463PRO.c,482 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_main0:
SUBS	R7, R7, #1
BNE	L_main0
NOP
NOP
NOP
;RF4463PRO.c,483 :: 		Sound_Play(4000, 100);
MOVS	R1, #100
MOVW	R0, #4000
BL	_Sound_Play+0
;RF4463PRO.c,484 :: 		LED_GREEN =0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;RF4463PRO.c,485 :: 		rfInit();
BL	_rfInit+0
;RF4463PRO.c,486 :: 		nop_10();
BL	_nop_10+0
;RF4463PRO.c,487 :: 		rf4463Config();
BL	_rf4463Config+0
;RF4463PRO.c,488 :: 		nop_10();
BL	_nop_10+0
;RF4463PRO.c,490 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
_rfInit:
;RF4463PRO.c,495 :: 		void rfInit()
SUB	SP, SP, #20
STR	LR, [SP, #0]
;RF4463PRO.c,497 :: 		vRf4463PowerOnReset();
BL	_vRf4463PowerOnReset+0
;RF4463PRO.c,498 :: 		if( ucRf4463DeviceAvailability() == SUCCESS )
BL	_ucRf4463DeviceAvailability+0
CMP	R0, #0
IT	NE
BNE	L_rfInit2
;RF4463PRO.c,500 :: 		UART1_Write_Text("Radio On!!!\n\r");
ADD	R11, SP, #4
ADD	R10, R11, #14
MOVW	R12, #lo_addr(?ICS?lstr2_RF4463PRO+0)
MOVT	R12, #hi_addr(?ICS?lstr2_RF4463PRO+0)
BL	___CC2DW+0
ADD	R0, SP, #4
BL	_UART1_Write_Text+0
;RF4463PRO.c,501 :: 		}
L_rfInit2:
;RF4463PRO.c,502 :: 		UART1_Write(get_battery_voltage());
BL	_get_battery_voltage+0
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
BL	_UART1_Write+0
;RF4463PRO.c,503 :: 		}
L_end_rfInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _rfInit
_rf4463Config:
;RF4463PRO.c,508 :: 		void rf4463Config()
SUB	SP, SP, #24
STR	LR, [SP, #0]
;RF4463PRO.c,514 :: 		for( allocatCounter = 4; allocatCounter < 16; allocatCounter++ ) RF_MODEM_MOD_TYPE_12_data[allocatCounter] = RF_MODEM_MOD_TYPE_12[dataRate][allocatCounter - 4];
; allocatCounter start address is: 12 (R3)
MOVS	R3, #4
; allocatCounter end address is: 12 (R3)
L_rf4463Config3:
; allocatCounter start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_rf4463Config4
MOVW	R0, #lo_addr(_RF_MODEM_MOD_TYPE_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_MOD_TYPE_12_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_dataRate+0)
MOVT	R0, #hi_addr(_dataRate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #12
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_MOD_TYPE_12+0)
MOVT	R0, #hi_addr(_RF_MODEM_MOD_TYPE_12+0)
ADDS	R1, R0, R1
SUBS	R0, R3, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
ADDS	R3, R3, #1
UXTB	R3, R3
; allocatCounter end address is: 12 (R3)
IT	AL
BAL	L_rf4463Config3
L_rf4463Config4:
;RF4463PRO.c,516 :: 		if(freq3<8)
MOVW	R0, #lo_addr(_freq3+0)
MOVT	R0, #hi_addr(_freq3+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CS
BCS	L_rf4463Config6
;RF4463PRO.c,518 :: 		for( allocatCounter = 4; allocatCounter < 12; allocatCounter++ ) RF_MODEM_TX_RAMP_DELAY_8_data[allocatCounter] = RF_MODEM_TX_RAMP_DELAY_8_433[dataRate][allocatCounter - 4];
; allocatCounter start address is: 12 (R3)
MOVS	R3, #4
; allocatCounter end address is: 12 (R3)
L_rf4463Config7:
; allocatCounter start address is: 12 (R3)
CMP	R3, #12
IT	CS
BCS	L_rf4463Config8
MOVW	R0, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_dataRate+0)
MOVT	R0, #hi_addr(_dataRate+0)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #3
MOVW	R0, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_433+0)
ADDS	R1, R0, R1
SUBS	R0, R3, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
ADDS	R3, R3, #1
UXTB	R3, R3
; allocatCounter end address is: 12 (R3)
IT	AL
BAL	L_rf4463Config7
L_rf4463Config8:
;RF4463PRO.c,519 :: 		for( allocatCounter = 4; allocatCounter < 15; allocatCounter++ ) RF_MODEM_OOK_CNT1_11_data[allocatCounter] = RF_MODEM_OOK_CNT1_11_433[dataRate][allocatCounter - 4];
; allocatCounter start address is: 12 (R3)
MOVS	R3, #4
; allocatCounter end address is: 12 (R3)
L_rf4463Config10:
; allocatCounter start address is: 12 (R3)
CMP	R3, #15
IT	CS
BCS	L_rf4463Config11
MOVW	R0, #lo_addr(_RF_MODEM_OOK_CNT1_11_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_OOK_CNT1_11_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_dataRate+0)
MOVT	R0, #hi_addr(_dataRate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #11
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_OOK_CNT1_11_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_OOK_CNT1_11_433+0)
ADDS	R1, R0, R1
SUBS	R0, R3, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
ADDS	R3, R3, #1
UXTB	R3, R3
; allocatCounter end address is: 12 (R3)
IT	AL
BAL	L_rf4463Config10
L_rf4463Config11:
;RF4463PRO.c,520 :: 		for( allocatCounter = 4; allocatCounter < 16; allocatCounter++ ) RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[allocatCounter] = RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433[dataRate][allocatCounter - 4];
; allocatCounter start address is: 12 (R3)
MOVS	R3, #4
; allocatCounter end address is: 12 (R3)
L_rf4463Config13:
; allocatCounter start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_rf4463Config14
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_dataRate+0)
MOVT	R0, #hi_addr(_dataRate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #12
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433+0)
ADDS	R1, R0, R1
SUBS	R0, R3, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
ADDS	R3, R3, #1
UXTB	R3, R3
; allocatCounter end address is: 12 (R3)
IT	AL
BAL	L_rf4463Config13
L_rf4463Config14:
;RF4463PRO.c,521 :: 		for( allocatCounter = 4; allocatCounter < 16; allocatCounter++ ) RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[allocatCounter] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433[dataRate][allocatCounter - 4];
; allocatCounter start address is: 12 (R3)
MOVS	R3, #4
; allocatCounter end address is: 12 (R3)
L_rf4463Config16:
; allocatCounter start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_rf4463Config17
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_dataRate+0)
MOVT	R0, #hi_addr(_dataRate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #12
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433+0)
ADDS	R1, R0, R1
SUBS	R0, R3, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
ADDS	R3, R3, #1
UXTB	R3, R3
; allocatCounter end address is: 12 (R3)
IT	AL
BAL	L_rf4463Config16
L_rf4463Config17:
;RF4463PRO.c,522 :: 		for( allocatCounter = 4; allocatCounter < 16; allocatCounter++ ) RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[allocatCounter] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433[dataRate][allocatCounter - 4];
; allocatCounter start address is: 12 (R3)
MOVS	R3, #4
; allocatCounter end address is: 12 (R3)
L_rf4463Config19:
; allocatCounter start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_rf4463Config20
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_dataRate+0)
MOVT	R0, #hi_addr(_dataRate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #12
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433+0)
ADDS	R1, R0, R1
SUBS	R0, R3, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
ADDS	R3, R3, #1
UXTB	R3, R3
; allocatCounter end address is: 12 (R3)
IT	AL
BAL	L_rf4463Config19
L_rf4463Config20:
;RF4463PRO.c,523 :: 		for( allocatCounter = 4; allocatCounter < 13; allocatCounter++ ) RF_MODEM_AGC_WINDOW_SIZE_9_data[allocatCounter] = RF_MODEM_AGC_WINDOW_SIZE_9_433[dataRate][allocatCounter - 4];
; allocatCounter start address is: 12 (R3)
MOVS	R3, #4
; allocatCounter end address is: 12 (R3)
L_rf4463Config22:
; allocatCounter start address is: 12 (R3)
CMP	R3, #13
IT	CS
BCS	L_rf4463Config23
MOVW	R0, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_dataRate+0)
MOVT	R0, #hi_addr(_dataRate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #9
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_433+0)
ADDS	R1, R0, R1
SUBS	R0, R3, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
ADDS	R3, R3, #1
UXTB	R3, R3
; allocatCounter end address is: 12 (R3)
IT	AL
BAL	L_rf4463Config22
L_rf4463Config23:
;RF4463PRO.c,524 :: 		for( allocatCounter = 4; allocatCounter < 13; allocatCounter++ ) RF_MODEM_BCR_OSR_1_9_data[allocatCounter] = RF_MODEM_BCR_OSR_1_9_433[dataRate][allocatCounter - 4];
; allocatCounter start address is: 12 (R3)
MOVS	R3, #4
; allocatCounter end address is: 12 (R3)
L_rf4463Config25:
; allocatCounter start address is: 12 (R3)
CMP	R3, #13
IT	CS
BCS	L_rf4463Config26
MOVW	R0, #lo_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_dataRate+0)
MOVT	R0, #hi_addr(_dataRate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #9
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_BCR_OSR_1_9_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_BCR_OSR_1_9_433+0)
ADDS	R1, R0, R1
SUBS	R0, R3, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
ADDS	R3, R3, #1
UXTB	R3, R3
; allocatCounter end address is: 12 (R3)
IT	AL
BAL	L_rf4463Config25
L_rf4463Config26:
;RF4463PRO.c,525 :: 		}
IT	AL
BAL	L_rf4463Config28
L_rf4463Config6:
;RF4463PRO.c,528 :: 		for( allocatCounter = 4; allocatCounter < 12; allocatCounter++ ) RF_MODEM_TX_RAMP_DELAY_8_data[allocatCounter] = RF_MODEM_TX_RAMP_DELAY_8_850[dataRate][allocatCounter - 4];
; allocatCounter start address is: 12 (R3)
MOVS	R3, #4
; allocatCounter end address is: 12 (R3)
L_rf4463Config29:
; allocatCounter start address is: 12 (R3)
CMP	R3, #12
IT	CS
BCS	L_rf4463Config30
MOVW	R0, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_dataRate+0)
MOVT	R0, #hi_addr(_dataRate+0)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #3
MOVW	R0, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_850+0)
ADDS	R1, R0, R1
SUBS	R0, R3, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
ADDS	R3, R3, #1
UXTB	R3, R3
; allocatCounter end address is: 12 (R3)
IT	AL
BAL	L_rf4463Config29
L_rf4463Config30:
;RF4463PRO.c,529 :: 		for( allocatCounter = 4; allocatCounter < 11; allocatCounter++ ) RF_MODEM_AFC_GEAR_7_data[allocatCounter] = RF_MODEM_AFC_GEAR_7_850[dataRate][allocatCounter - 4];
; allocatCounter start address is: 12 (R3)
MOVS	R3, #4
; allocatCounter end address is: 12 (R3)
L_rf4463Config32:
; allocatCounter start address is: 12 (R3)
CMP	R3, #11
IT	CS
BCS	L_rf4463Config33
MOVW	R0, #lo_addr(_RF_MODEM_AFC_GEAR_7_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AFC_GEAR_7_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_dataRate+0)
MOVT	R0, #hi_addr(_dataRate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #7
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_AFC_GEAR_7_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_AFC_GEAR_7_850+0)
ADDS	R1, R0, R1
SUBS	R0, R3, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
ADDS	R3, R3, #1
UXTB	R3, R3
; allocatCounter end address is: 12 (R3)
IT	AL
BAL	L_rf4463Config32
L_rf4463Config33:
;RF4463PRO.c,530 :: 		for( allocatCounter = 4; allocatCounter < 15; allocatCounter++ ) RF_MODEM_OOK_CNT1_11_data[allocatCounter] = RF_MODEM_OOK_CNT1_11_850[dataRate][allocatCounter - 4];
; allocatCounter start address is: 12 (R3)
MOVS	R3, #4
; allocatCounter end address is: 12 (R3)
L_rf4463Config35:
; allocatCounter start address is: 12 (R3)
CMP	R3, #15
IT	CS
BCS	L_rf4463Config36
MOVW	R0, #lo_addr(_RF_MODEM_OOK_CNT1_11_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_OOK_CNT1_11_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_dataRate+0)
MOVT	R0, #hi_addr(_dataRate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #11
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_OOK_CNT1_11_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_OOK_CNT1_11_850+0)
ADDS	R1, R0, R1
SUBS	R0, R3, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
ADDS	R3, R3, #1
UXTB	R3, R3
; allocatCounter end address is: 12 (R3)
IT	AL
BAL	L_rf4463Config35
L_rf4463Config36:
;RF4463PRO.c,531 :: 		for( allocatCounter = 4; allocatCounter < 16; allocatCounter++ ) RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[allocatCounter] = RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850[dataRate][allocatCounter - 4];
; allocatCounter start address is: 12 (R3)
MOVS	R3, #4
; allocatCounter end address is: 12 (R3)
L_rf4463Config38:
; allocatCounter start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_rf4463Config39
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_dataRate+0)
MOVT	R0, #hi_addr(_dataRate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #12
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850+0)
ADDS	R1, R0, R1
SUBS	R0, R3, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
ADDS	R3, R3, #1
UXTB	R3, R3
; allocatCounter end address is: 12 (R3)
IT	AL
BAL	L_rf4463Config38
L_rf4463Config39:
;RF4463PRO.c,532 :: 		for( allocatCounter = 4; allocatCounter < 16; allocatCounter++ ) RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[allocatCounter] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850[dataRate][allocatCounter - 4];
; allocatCounter start address is: 12 (R3)
MOVS	R3, #4
; allocatCounter end address is: 12 (R3)
L_rf4463Config41:
; allocatCounter start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_rf4463Config42
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_dataRate+0)
MOVT	R0, #hi_addr(_dataRate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #12
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850+0)
ADDS	R1, R0, R1
SUBS	R0, R3, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
ADDS	R3, R3, #1
UXTB	R3, R3
; allocatCounter end address is: 12 (R3)
IT	AL
BAL	L_rf4463Config41
L_rf4463Config42:
;RF4463PRO.c,533 :: 		for( allocatCounter = 4; allocatCounter < 16; allocatCounter++ ) RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[allocatCounter] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850[dataRate][allocatCounter - 4];
; allocatCounter start address is: 12 (R3)
MOVS	R3, #4
; allocatCounter end address is: 12 (R3)
L_rf4463Config44:
; allocatCounter start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_rf4463Config45
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_dataRate+0)
MOVT	R0, #hi_addr(_dataRate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #12
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850+0)
ADDS	R1, R0, R1
SUBS	R0, R3, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
ADDS	R3, R3, #1
UXTB	R3, R3
; allocatCounter end address is: 12 (R3)
IT	AL
BAL	L_rf4463Config44
L_rf4463Config45:
;RF4463PRO.c,534 :: 		for( allocatCounter = 4; allocatCounter < 13; allocatCounter++ ) RF_MODEM_AGC_WINDOW_SIZE_9_data[allocatCounter] = RF_MODEM_AGC_WINDOW_SIZE_9_850[dataRate][allocatCounter - 4];
; allocatCounter start address is: 12 (R3)
MOVS	R3, #4
; allocatCounter end address is: 12 (R3)
L_rf4463Config47:
; allocatCounter start address is: 12 (R3)
CMP	R3, #13
IT	CS
BCS	L_rf4463Config48
MOVW	R0, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_dataRate+0)
MOVT	R0, #hi_addr(_dataRate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #9
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_850+0)
ADDS	R1, R0, R1
SUBS	R0, R3, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
ADDS	R3, R3, #1
UXTB	R3, R3
; allocatCounter end address is: 12 (R3)
IT	AL
BAL	L_rf4463Config47
L_rf4463Config48:
;RF4463PRO.c,535 :: 		for( allocatCounter = 4; allocatCounter < 13; allocatCounter++ ) RF_MODEM_BCR_OSR_1_9_data[allocatCounter] = RF_MODEM_BCR_OSR_1_9_850[dataRate][allocatCounter - 4];
; allocatCounter start address is: 12 (R3)
MOVS	R3, #4
; allocatCounter end address is: 12 (R3)
L_rf4463Config50:
; allocatCounter start address is: 12 (R3)
CMP	R3, #13
IT	CS
BCS	L_rf4463Config51
MOVW	R0, #lo_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_dataRate+0)
MOVT	R0, #hi_addr(_dataRate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #9
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_BCR_OSR_1_9_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_BCR_OSR_1_9_850+0)
ADDS	R1, R0, R1
SUBS	R0, R3, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
ADDS	R3, R3, #1
UXTB	R3, R3
; allocatCounter end address is: 12 (R3)
IT	AL
BAL	L_rf4463Config50
L_rf4463Config51:
;RF4463PRO.c,536 :: 		}
L_rf4463Config28:
;RF4463PRO.c,537 :: 		for(allocatCounter = 4; allocatCounter < 11; allocatCounter++ ) RF_SYNTH_PFDCP_CPFF_7_data[allocatCounter] = RF_SYNTH_PFDCP_CPFF_7[dataRate][allocatCounter - 4];
; allocatCounter start address is: 12 (R3)
MOVS	R3, #4
; allocatCounter end address is: 12 (R3)
L_rf4463Config53:
; allocatCounter start address is: 12 (R3)
CMP	R3, #11
IT	CS
BCS	L_rf4463Config54
MOVW	R0, #lo_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
MOVT	R0, #hi_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_dataRate+0)
MOVT	R0, #hi_addr(_dataRate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #7
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_SYNTH_PFDCP_CPFF_7+0)
MOVT	R0, #hi_addr(_RF_SYNTH_PFDCP_CPFF_7+0)
ADDS	R1, R0, R1
SUBS	R0, R3, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
ADDS	R3, R3, #1
UXTB	R3, R3
; allocatCounter end address is: 12 (R3)
IT	AL
BAL	L_rf4463Config53
L_rf4463Config54:
;RF4463PRO.c,539 :: 		GPIO_SET(mode);
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
BL	_GPIO_SET+0
;RF4463PRO.c,542 :: 		pcBuffer[0]  = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;RF4463PRO.c,543 :: 		pcBuffer[1]  = 0x00;    // 0x0000
ADDS	R1, R2, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,544 :: 		pcBuffer[2]  = 0x01;    // ¹² 1¸ö²ÎÊý
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;RF4463PRO.c,545 :: 		pcBuffer[3]  = 0x00;   // 0x0000
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,546 :: 		pcBuffer[4]  = 98;  // freq  adjustment
ADDS	R1, R2, #4
MOVS	R0, #98
STRB	R0, [R1, #0]
;RF4463PRO.c,547 :: 		ucRf4463SetCommand( 5 , RF4463_PROPERTY_GLOBAL_XO_TUNE , pcBuffer );
MOVS	R1, #0
MOVS	R0, #5
BL	_ucRf4463SetCommand+0
;RF4463PRO.c,548 :: 		vBufferSetToZero( pcBuffer, 20 );
ADD	R0, SP, #4
MOVS	R1, #20
BL	_vBufferSetToZero+0
;RF4463PRO.c,554 :: 		pcBuffer[0]  = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;RF4463PRO.c,555 :: 		pcBuffer[1]  = 0x00;    // 0x0003
ADDS	R1, R2, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,556 :: 		pcBuffer[2]  = 0x01;    // ¹² 1¸ö²ÎÊý
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;RF4463PRO.c,557 :: 		pcBuffer[3]  = 0x03;   // 0x0003
ADDS	R1, R2, #3
MOVS	R0, #3
STRB	R0, [R1, #0]
;RF4463PRO.c,558 :: 		pcBuffer[4]  = 0x40;  // tx = rx = 64 byte, ÆÕÍ¨ PH£¬high performance mode  ?????????????????????
ADDS	R1, R2, #4
MOVS	R0, #64
STRB	R0, [R1, #0]
;RF4463PRO.c,559 :: 		ucRf4463SetCommand( 5 , RF4463_PROPERTY_GLOBAL_CLK_CFG , pcBuffer );
MOVS	R1, #1
MOVS	R0, #5
BL	_ucRf4463SetCommand+0
;RF4463PRO.c,560 :: 		vBufferSetToZero( pcBuffer, 20 );
ADD	R0, SP, #4
MOVS	R1, #20
BL	_vBufferSetToZero+0
;RF4463PRO.c,567 :: 		pcBuffer[0]  = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;RF4463PRO.c,568 :: 		pcBuffer[1]  = 0x10;    // 0x1000
ADDS	R1, R2, #1
MOVS	R0, #16
STRB	R0, [R1, #0]
;RF4463PRO.c,569 :: 		pcBuffer[2]  = 0x09;    // ¹² 9¸ö²ÎÊý
ADDS	R1, R2, #2
MOVS	R0, #9
STRB	R0, [R1, #0]
;RF4463PRO.c,570 :: 		pcBuffer[3]  = 0x00;   // 0x1000
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,572 :: 		if(mode == tx_test_mode)
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_rf4463Config56
;RF4463PRO.c,574 :: 		pcBuffer[4]  = 0xff;   //  ÐèÒª·¢ËÍ255¸ö×Ö½ÚµÄPreamble
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #255
STRB	R0, [R1, #0]
;RF4463PRO.c,575 :: 		}
IT	AL
BAL	L_rf4463Config57
L_rf4463Config56:
;RF4463PRO.c,578 :: 		pcBuffer[4]  = 0x08;   //  ÐèÒª·¢ËÍ8¸ö×Ö½ÚµÄPreamble
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #8
STRB	R0, [R1, #0]
;RF4463PRO.c,579 :: 		}
L_rf4463Config57:
;RF4463PRO.c,582 :: 		pcBuffer[5]   = 0x14;   //Òª¼ì²â20 bit Í¬²½×Ö£¬
ADD	R2, SP, #4
ADDS	R1, R2, #5
MOVS	R0, #20
STRB	R0, [R1, #0]
;RF4463PRO.c,583 :: 		pcBuffer[6]   = 0x00;   // ·Ç±ê×¼µÄpreamble Éè¶¨£¬Ã»ÓÐÓÃ
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,584 :: 		pcBuffer[7]   = 0x0f;   // Ç°µ¼ÂëTimeoutµÄÊ±¼ä   ????????????????????????????????????????????????????????????
ADDS	R1, R2, #7
MOVS	R0, #15
STRB	R0, [R1, #0]
;RF4463PRO.c,585 :: 		pcBuffer[8]   = 0x31;  // Ç°µ¼ÂëµÄ³¤¶ÈÒÔ byte ¼ÆËã£¬ 1st = 1£¬Ã»ÓÐmanchest  ±àÂë£¬Ê¹ÓÃ±ê×¼µÄ 1010.¡£¡£
ADDW	R1, R2, #8
MOVS	R0, #49
STRB	R0, [R1, #0]
;RF4463PRO.c,586 :: 		pcBuffer[9]   = 0x0;     //  ·Ç±ê×¼µÄPreambleµÄ Patten 4th byte
ADDW	R1, R2, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,587 :: 		pcBuffer[10]  = 0x00;   //  ·Ç±ê×¼µÄPreambleµÄ Patten 3rd byte
ADDW	R1, R2, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,588 :: 		pcBuffer[11]  = 0x00;  //  ·Ç±ê×¼µÄPreambleµÄ Patten 2nd byte
ADDW	R1, R2, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,589 :: 		pcBuffer[12]  = 0x00;  //  ·Ç±ê×¼µÄPreambleµÄ Patten 1st byte
ADDW	R1, R2, #12
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,590 :: 		ucRf4463SetCommand( 13 , RF4463_PROPERTY_PREAMBLE_TX_LENGTH , pcBuffer );
MOVS	R1, #0
MOVS	R0, #13
BL	_ucRf4463SetCommand+0
;RF4463PRO.c,591 :: 		vBufferSetToZero( pcBuffer, 20 );
ADD	R0, SP, #4
MOVS	R1, #20
BL	_vBufferSetToZero+0
;RF4463PRO.c,596 :: 		pcBuffer[0]  = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;RF4463PRO.c,597 :: 		pcBuffer[1]  = 0x11;    // command = 0x1100
ADDS	R1, R2, #1
MOVS	R0, #17
STRB	R0, [R1, #0]
;RF4463PRO.c,598 :: 		pcBuffer[2]  = 0x05;    // ¹² 5¸ö²ÎÊý
ADDS	R1, R2, #2
MOVS	R0, #5
STRB	R0, [R1, #0]
;RF4463PRO.c,599 :: 		pcBuffer[3]  = 0x00;   // command = 0x1100
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,600 :: 		pcBuffer[4]  = 0x01;   //  Í¬²½×ÖÔÚ length field ¶¨Òå²¢·¢ËÍ£¬Í¬²½×Ö²»ÄÜÓÐ´í£¬²»ÊÇ 4FSK£¬ ²»ÊÇmanchest ±àÂë£¬Ö»ÓÐ 2¸ö×Ö½Ú
ADDS	R1, R2, #4
MOVS	R0, #1
STRB	R0, [R1, #0]
;RF4463PRO.c,602 :: 		if(mode == tx_test_mode)
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_rf4463Config58
;RF4463PRO.c,604 :: 		pcBuffer[5]  = 0x55;   //Í¬²½×Ö 3
ADD	R2, SP, #4
ADDS	R1, R2, #5
MOVS	R0, #85
STRB	R0, [R1, #0]
;RF4463PRO.c,605 :: 		pcBuffer[6]  = 0x55;   // Í¬²½×Ö2
ADDS	R1, R2, #6
MOVS	R0, #85
STRB	R0, [R1, #0]
;RF4463PRO.c,606 :: 		}
IT	AL
BAL	L_rf4463Config59
L_rf4463Config58:
;RF4463PRO.c,609 :: 		pcBuffer[5]  = 0x2d;   //Í¬²½×Ö 3
ADD	R2, SP, #4
ADDS	R1, R2, #5
MOVS	R0, #45
STRB	R0, [R1, #0]
;RF4463PRO.c,610 :: 		pcBuffer[6]  = 0xd4;   // Í¬²½×Ö2
ADDS	R1, R2, #6
MOVS	R0, #212
STRB	R0, [R1, #0]
;RF4463PRO.c,611 :: 		}
L_rf4463Config59:
;RF4463PRO.c,613 :: 		pcBuffer[7]  = 0x00;   // Í¬²½×Ö1
ADD	R2, SP, #4
ADDS	R1, R2, #7
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,614 :: 		pcBuffer[8]  = 0x00;  // Í¬²½×Ö 0
ADDW	R1, R2, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,618 :: 		pcBuffer[0]  = 0x11;
MOVS	R0, #17
STRB	R0, [R2, #0]
;RF4463PRO.c,619 :: 		pcBuffer[1]  = 0x12;    // command = 0x1200
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;RF4463PRO.c,620 :: 		pcBuffer[2]  = 0x01;    // ¹² 1¸ö²ÎÊý
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;RF4463PRO.c,621 :: 		pcBuffer[3]  = 0x00;   // command = 0x1200
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,622 :: 		pcBuffer[4]  = 0x81; //   1ÊÇcRC ÖÖ×Ó£¬CRC = itu-c, enable crc
ADDS	R1, R2, #4
MOVS	R0, #129
STRB	R0, [R1, #0]
;RF4463PRO.c,626 :: 		pcBuffer[0]  = 0x11;
MOVS	R0, #17
STRB	R0, [R2, #0]
;RF4463PRO.c,627 :: 		pcBuffer[1]  = 0x12;    // command = 0x1206
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;RF4463PRO.c,628 :: 		pcBuffer[2]  = 0x01;    // ¹² 1¸ö²ÎÊý
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;RF4463PRO.c,629 :: 		pcBuffer[3]  = 0x06;   // command = 0x1206
ADDS	R1, R2, #3
MOVS	R0, #6
STRB	R0, [R1, #0]
;RF4463PRO.c,630 :: 		pcBuffer[4]  = 0x02;   //  tx = rx = 120d--1220 (tx packet£¬ph enable, not 4fsk, ÊÕµ½Ò»°üÊý¾Ýºó£¬RX off,CRC ²»·­×ª £¬CRC MSB£¬ data MSB
ADDS	R1, R2, #4
MOVS	R0, #2
STRB	R0, [R1, #0]
;RF4463PRO.c,634 :: 		pcBuffer[0]  = 0x11;
MOVS	R0, #17
STRB	R0, [R2, #0]
;RF4463PRO.c,635 :: 		pcBuffer[1]  = 0x12;    // command = 0x1208
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;RF4463PRO.c,636 :: 		pcBuffer[2]  = 0x03;    // ¹² 3¸ö²ÎÊý
ADDS	R1, R2, #2
MOVS	R0, #3
STRB	R0, [R1, #0]
;RF4463PRO.c,637 :: 		pcBuffer[3]  = 0x08;   // command = 0x1208
ADDS	R1, R2, #3
MOVS	R0, #8
STRB	R0, [R1, #0]
;RF4463PRO.c,638 :: 		pcBuffer[4]  = 0x00;   //  Length Field = LSB,  length Ö»ÓÐ1¸ö×Ö½Ú£¬length ²»·ÅÔÚ FiFoÀïÃæ£¬¹Ì¶¨°ü³¤Ä£Ê½
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,639 :: 		pcBuffer[5]  = 0x00;   //ÓÃÓÚ¿É±ä°ü³¤Ä£Ê½£¬¶¨ÒåÄÄ¸ö Field °üº¬ÁË length Filed
ADDS	R1, R2, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,640 :: 		pcBuffer[6]  = 0x00;   // ÓÃÓÚ¿É±ä°ü³¤Ä£Ê½£¬µ÷Õû¿É±ä°ü³¤µÄ length
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,645 :: 		pcBuffer[0]   = 0x11;
MOVS	R0, #17
STRB	R0, [R2, #0]
;RF4463PRO.c,646 :: 		pcBuffer[1]   = 0x12;    // 0x120d
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;RF4463PRO.c,647 :: 		pcBuffer[2]   = 0x0c;    // ¹² 12¸ö²ÎÊý
ADDS	R1, R2, #2
MOVS	R0, #12
STRB	R0, [R1, #0]
;RF4463PRO.c,648 :: 		pcBuffer[3]   = 0x0d;   // 0x120d
ADDS	R1, R2, #3
MOVS	R0, #13
STRB	R0, [R1, #0]
;RF4463PRO.c,649 :: 		pcBuffer[4]   = 0x00;   //  Field 1 µÄ³¤¶È £¨¸ß4Î»£©
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,650 :: 		pcBuffer[5]   = payload_length;   //  field 1 µÄ³¤¶È£¬ £¨µÍ 8Î»), ×Ü¹²14¸ö×Ö½Ú
ADDS	R1, R2, #5
MOVS	R0, #14
STRB	R0, [R1, #0]
;RF4463PRO.c,651 :: 		pcBuffer[6]   = 0x04;   // field 1 ²»ÊÇ 4FSK£¬manchest, whiting, PN9,
ADDS	R1, R2, #6
MOVS	R0, #4
STRB	R0, [R1, #0]
;RF4463PRO.c,652 :: 		pcBuffer[7]   = 0xaa;   // field 1 crc enble, check enbale, ·¢ÉäÒ²ÓÐCRC£¬cRCµÄSeed ºÍCRC_seedÀïÃæµÄÒ»Ñù
ADDS	R1, R2, #7
MOVS	R0, #170
STRB	R0, [R1, #0]
;RF4463PRO.c,653 :: 		pcBuffer[8]   = 0x00;  //  field2 µÄ³¤¶È£¨¸ß4Î»£©
ADDW	R1, R2, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,654 :: 		pcBuffer[9]   = 0x00;    //  field 2 µÄ³¤¶È£¬ £¨µÍ 8Î»)£¬ ³¤¶È = 0 ±íÊ¾Õâ¸öfield Ã»ÓÐÊ¹ÓÃ
ADDW	R1, R2, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,655 :: 		pcBuffer[10]  = 0x00;   // field 2 ²»ÊÇ 4FSK£¬manchest, whiting, PN9
ADDW	R1, R2, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,656 :: 		pcBuffer[11]  = 0x00;  //  field 2 µÄCRCÉèÖÃ
ADDW	R1, R2, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,657 :: 		pcBuffer[12]  = 0x00;  //  field 3 µÄ³¤¶È£¬ £¨µÍ 8Î»)£¬ ³¤¶È = 0 ±íÊ¾Õâ¸öfield Ã»ÓÐÊ¹ÓÃ
ADDW	R1, R2, #12
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,658 :: 		pcBuffer[13]  = 0x00;    //  field 3 µÄ³¤¶È£¬ £¨µÍ 8Î»)£¬ ³¤¶È = 0 ±íÊ¾Õâ¸öfield Ã»ÓÐÊ¹ÓÃ
ADDW	R1, R2, #13
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,659 :: 		pcBuffer[14]  = 0x00;   //  field 3 ²»ÊÇ 4FSK£¬manchest, whiting, PN9
ADDW	R1, R2, #14
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,660 :: 		pcBuffer[15]  = 0x00;  //  field 3 µÄCRCÉèÖÃ
ADDW	R1, R2, #15
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,664 :: 		pcBuffer[0]   = 0x11;
MOVS	R0, #17
STRB	R0, [R2, #0]
;RF4463PRO.c,665 :: 		pcBuffer[1]   = 0x12;    // 0x1219
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;RF4463PRO.c,666 :: 		pcBuffer[2]   = 0x08;    // ¹² 8¸ö²ÎÊý
ADDS	R1, R2, #2
MOVS	R0, #8
STRB	R0, [R1, #0]
;RF4463PRO.c,667 :: 		pcBuffer[3]   = 0x19;   // 0x1219
ADDS	R1, R2, #3
MOVS	R0, #25
STRB	R0, [R1, #0]
;RF4463PRO.c,668 :: 		pcBuffer[4]   = 0x00;   //  field4 µÄ³¤¶È£¨¸ß4Î»£©
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,669 :: 		pcBuffer[5]   = 0x00;   //  field 4 µÄ³¤¶È£¬ £¨µÍ 8Î»)£¬ ³¤¶È = 0 ±íÊ¾Õâ¸öfield Ã»ÓÐÊ¹ÓÃ
ADDS	R1, R2, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,670 :: 		pcBuffer[6]   = 0x00;   //   field 4 ²»ÊÇ 4FSK£¬manchest, whiting, PN9
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,671 :: 		pcBuffer[7]   = 0x00;   // field 4 µÄCRCÉèÖÃ
ADDS	R1, R2, #7
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,672 :: 		pcBuffer[8]   = 0x00;  //  field5 µÄ³¤¶È£¨¸ß4Î»£©
ADDW	R1, R2, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,673 :: 		pcBuffer[9]   = 0x00;    //   field 5 µÄ³¤¶È£¬ £¨µÍ 8Î»)£¬ ³¤¶È = 0 ±íÊ¾Õâ¸öfield Ã»ÓÐÊ¹ÓÃ
ADDW	R1, R2, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,674 :: 		pcBuffer[10]  = 0x00;   //  field 5 ²»ÊÇ 4FSK£¬manchest, whiting, PN9
ADDW	R1, R2, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,675 :: 		pcBuffer[11]  = 0x00;   // field 5 µÄCRCÉèÖÃ
ADDW	R1, R2, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,682 :: 		pcBuffer[0] = 0x11;
MOVS	R0, #17
STRB	R0, [R2, #0]
;RF4463PRO.c,683 :: 		pcBuffer[1]  = 0x20;    // 0x200c
ADDS	R1, R2, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;RF4463PRO.c,684 :: 		pcBuffer[2]  = 0x01;    // ¹² 1¸ö²ÎÊý
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;RF4463PRO.c,685 :: 		pcBuffer[3]  = 0x0c;   // 0x200c
ADDS	R1, R2, #3
MOVS	R0, #12
STRB	R0, [R1, #0]
;RF4463PRO.c,687 :: 		if(freq3<8)
MOVW	R0, #lo_addr(_freq3+0)
MOVT	R0, #hi_addr(_freq3+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CS
BCS	L_rf4463Config60
;RF4463PRO.c,689 :: 		if(dataRate>=dr_256k)
MOVW	R0, #lo_addr(_dataRate+0)
MOVT	R0, #hi_addr(_dataRate+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CC
BCC	L_rf4463Config61
;RF4463PRO.c,690 :: 		pcBuffer[4]  = 0x4f;
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #79
STRB	R0, [R1, #0]
IT	AL
BAL	L_rf4463Config62
L_rf4463Config61:
;RF4463PRO.c,691 :: 		else if(dataRate>=dr_19p2)
MOVW	R0, #lo_addr(_dataRate+0)
MOVT	R0, #hi_addr(_dataRate+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	CC
BCC	L_rf4463Config63
;RF4463PRO.c,692 :: 		pcBuffer[4]  = 0x5e;
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #94
STRB	R0, [R1, #0]
IT	AL
BAL	L_rf4463Config64
L_rf4463Config63:
;RF4463PRO.c,694 :: 		pcBuffer[4]  = 0xd2;
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #210
STRB	R0, [R1, #0]
L_rf4463Config64:
L_rf4463Config62:
;RF4463PRO.c,695 :: 		}
IT	AL
BAL	L_rf4463Config65
L_rf4463Config60:
;RF4463PRO.c,698 :: 		if(dataRate>=dr_115p2)
MOVW	R0, #lo_addr(_dataRate+0)
MOVT	R0, #hi_addr(_dataRate+0)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	CC
BCC	L_rf4463Config66
;RF4463PRO.c,699 :: 		pcBuffer[4]  = 0x69;     // 15k
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #105
STRB	R0, [R1, #0]
IT	AL
BAL	L_rf4463Config67
L_rf4463Config66:
;RF4463PRO.c,700 :: 		else if(dataRate>=dr_19p2)
MOVW	R0, #lo_addr(_dataRate+0)
MOVT	R0, #hi_addr(_dataRate+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	CC
BCC	L_rf4463Config68
;RF4463PRO.c,701 :: 		pcBuffer[4]  = 0x5e;     // 10k
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #94
STRB	R0, [R1, #0]
IT	AL
BAL	L_rf4463Config69
L_rf4463Config68:
;RF4463PRO.c,703 :: 		pcBuffer[4]  = 0x18; // 8k
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #24
STRB	R0, [R1, #0]
L_rf4463Config69:
L_rf4463Config67:
;RF4463PRO.c,704 :: 		}
L_rf4463Config65:
;RF4463PRO.c,716 :: 		pcBuffer[0] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;RF4463PRO.c,717 :: 		pcBuffer[1] = 0x20;    // 0x204e
ADDS	R1, R2, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;RF4463PRO.c,718 :: 		pcBuffer[2] = 0x01;    // ¹² 1¸ö²ÎÊý
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;RF4463PRO.c,719 :: 		pcBuffer[3] = 0x4e;   // 0x204e
ADDS	R1, R2, #3
MOVS	R0, #78
STRB	R0, [R1, #0]
;RF4463PRO.c,720 :: 		if(dataRate==dr_500)
MOVW	R0, #lo_addr(_dataRate+0)
MOVT	R0, #hi_addr(_dataRate+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	NE
BNE	L_rf4463Config70
;RF4463PRO.c,721 :: 		pcBuffer[4]  = 0x3a;
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #58
STRB	R0, [R1, #0]
IT	AL
BAL	L_rf4463Config71
L_rf4463Config70:
;RF4463PRO.c,723 :: 		pcBuffer[4]  = 0x40;  //  rssi ¶ÁÊýÆ«²î£¬ÓëÕæÊµÖµµÄ²îÖµ
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #64
STRB	R0, [R1, #0]
L_rf4463Config71:
;RF4463PRO.c,732 :: 		pcBuffer[0] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;RF4463PRO.c,733 :: 		pcBuffer[1]  = 0x22;    // 0x2200
ADDS	R1, R2, #1
MOVS	R0, #34
STRB	R0, [R1, #0]
;RF4463PRO.c,734 :: 		pcBuffer[2]  = 0x04;    // ¹² 4¸ö²ÎÊý
ADDS	R1, R2, #2
MOVS	R0, #4
STRB	R0, [R1, #0]
;RF4463PRO.c,735 :: 		pcBuffer[3]  = 0x00;   // 0x2200
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,736 :: 		pcBuffer[4]  = 0x08;  //0x10;   //   PA mode  = default , Ê¹ÓÃClass E Ä£Ê½£¬¶ø²»ÊÇ Switch Current Ä£Ê½  ????????
ADDS	R1, R2, #4
MOVS	R0, #8
STRB	R0, [R1, #0]
;RF4463PRO.c,737 :: 		if(power==7)
MOVW	R0, #lo_addr(_power+0)
MOVT	R0, #hi_addr(_power+0)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	NE
BNE	L_rf4463Config72
;RF4463PRO.c,738 :: 		pcBuffer[5]  = 127;   //  ÉèÖÃÎª×î´ó¹¦ÂÊ
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #127
STRB	R0, [R1, #0]
IT	AL
BAL	L_rf4463Config73
L_rf4463Config72:
;RF4463PRO.c,739 :: 		else if(power==6)
MOVW	R0, #lo_addr(_power+0)
MOVT	R0, #hi_addr(_power+0)
LDRB	R0, [R0, #0]
CMP	R0, #6
IT	NE
BNE	L_rf4463Config74
;RF4463PRO.c,740 :: 		pcBuffer[5]  = 50;
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #50
STRB	R0, [R1, #0]
IT	AL
BAL	L_rf4463Config75
L_rf4463Config74:
;RF4463PRO.c,741 :: 		else if(power==5)
MOVW	R0, #lo_addr(_power+0)
MOVT	R0, #hi_addr(_power+0)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_rf4463Config76
;RF4463PRO.c,742 :: 		pcBuffer[5]  = 30;
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #30
STRB	R0, [R1, #0]
IT	AL
BAL	L_rf4463Config77
L_rf4463Config76:
;RF4463PRO.c,743 :: 		else if(power==4)
MOVW	R0, #lo_addr(_power+0)
MOVT	R0, #hi_addr(_power+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_rf4463Config78
;RF4463PRO.c,744 :: 		pcBuffer[5]  = 20;
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #20
STRB	R0, [R1, #0]
IT	AL
BAL	L_rf4463Config79
L_rf4463Config78:
;RF4463PRO.c,745 :: 		else if(power==3)
MOVW	R0, #lo_addr(_power+0)
MOVT	R0, #hi_addr(_power+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BNE	L_rf4463Config80
;RF4463PRO.c,746 :: 		pcBuffer[5]  = 15;
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #15
STRB	R0, [R1, #0]
IT	AL
BAL	L_rf4463Config81
L_rf4463Config80:
;RF4463PRO.c,747 :: 		else if(power==2)
MOVW	R0, #lo_addr(_power+0)
MOVT	R0, #hi_addr(_power+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_rf4463Config82
;RF4463PRO.c,748 :: 		pcBuffer[5]  = 10;
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #10
STRB	R0, [R1, #0]
IT	AL
BAL	L_rf4463Config83
L_rf4463Config82:
;RF4463PRO.c,749 :: 		else if(power==1)
MOVW	R0, #lo_addr(_power+0)
MOVT	R0, #hi_addr(_power+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_rf4463Config84
;RF4463PRO.c,750 :: 		pcBuffer[5]  = 7;
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #7
STRB	R0, [R1, #0]
IT	AL
BAL	L_rf4463Config85
L_rf4463Config84:
;RF4463PRO.c,752 :: 		pcBuffer[5]  = 4;
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #4
STRB	R0, [R1, #0]
L_rf4463Config85:
L_rf4463Config83:
L_rf4463Config81:
L_rf4463Config79:
L_rf4463Config77:
L_rf4463Config75:
L_rf4463Config73:
;RF4463PRO.c,753 :: 		pcBuffer[6]  =0x00; //???????? 0x00;   // CLK duty = 50%£¬ ÆäËû = Default
ADD	R0, SP, #4
ADDS	R1, R0, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,754 :: 		if((dataRate<=dr_115p2)||(dataRate==dr_500))
MOVW	R0, #lo_addr(_dataRate+0)
MOVT	R0, #hi_addr(_dataRate+0)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	LS
BLS	L__rf4463Config128
MOVW	R0, #lo_addr(_dataRate+0)
MOVT	R0, #hi_addr(_dataRate+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	EQ
BEQ	L__rf4463Config127
IT	AL
BAL	L_rf4463Config88
L__rf4463Config128:
L__rf4463Config127:
;RF4463PRO.c,755 :: 		pcBuffer[7]  = 0x3d;  // ???????? 0x5d;   // PA ramp time = default
ADD	R0, SP, #4
ADDS	R1, R0, #7
MOVS	R0, #61
STRB	R0, [R1, #0]
IT	AL
BAL	L_rf4463Config89
L_rf4463Config88:
;RF4463PRO.c,757 :: 		pcBuffer[7]  = 0x5d;
ADD	R0, SP, #4
ADDS	R1, R0, #7
MOVS	R0, #93
STRB	R0, [R1, #0]
L_rf4463Config89:
;RF4463PRO.c,764 :: 		pcBuffer[0] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;RF4463PRO.c,765 :: 		pcBuffer[1]  = 0x30;    // 0x3000
ADDS	R1, R2, #1
MOVS	R0, #48
STRB	R0, [R1, #0]
;RF4463PRO.c,766 :: 		pcBuffer[2]  = 0x0c;    // ¹² 12¸ö²ÎÊý
ADDS	R1, R2, #2
MOVS	R0, #12
STRB	R0, [R1, #0]
;RF4463PRO.c,767 :: 		pcBuffer[3]  = 0x00;   // 0x3000
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,768 :: 		pcBuffer[4]  = 's';    //0x00;   //  match 1 µÄÖµ
ADDS	R1, R2, #4
MOVS	R0, #115
STRB	R0, [R1, #0]
;RF4463PRO.c,769 :: 		pcBuffer[5]  = 0xff;   //  match 1 mask
ADDS	R1, R2, #5
MOVS	R0, #255
STRB	R0, [R1, #0]
;RF4463PRO.c,770 :: 		pcBuffer[6]  = 0x40;   // eable match 1, match 1µÄÖµÓëÍ¬²½×ÖµÄÏà¾àµÄ¾àÀë, 0 = match
ADDS	R1, R2, #6
MOVS	R0, #64
STRB	R0, [R1, #0]
;RF4463PRO.c,771 :: 		pcBuffer[7]  = 'w';    //  match 2 µÄÖµ
ADDS	R1, R2, #7
MOVS	R0, #119
STRB	R0, [R1, #0]
;RF4463PRO.c,772 :: 		pcBuffer[8]  = 0xff;   //  match 2 mask
ADDW	R1, R2, #8
MOVS	R0, #255
STRB	R0, [R1, #0]
;RF4463PRO.c,773 :: 		pcBuffer[9]  = 0x01;   // enable match 2, match 2µÄÖµÓëÍ¬²½×ÖµÄÏà¾àµÄ¾àÀë  , and function
ADDW	R1, R2, #9
MOVS	R0, #1
STRB	R0, [R1, #0]
;RF4463PRO.c,774 :: 		pcBuffer[10] = 'w';   //     match 3 µÄÖµ
ADDW	R1, R2, #10
MOVS	R0, #119
STRB	R0, [R1, #0]
;RF4463PRO.c,775 :: 		pcBuffer[11]  =0xff;;    //  match 3 mask
ADDW	R1, R2, #11
MOVS	R0, #255
STRB	R0, [R1, #0]
;RF4463PRO.c,776 :: 		pcBuffer[12]  =0x02;;    // enable match 3, match 3µÄÖµÓëÍ¬²½×ÖµÄÏà¾àµÄ¾àÀë    and function
ADDW	R1, R2, #12
MOVS	R0, #2
STRB	R0, [R1, #0]
;RF4463PRO.c,777 :: 		pcBuffer[13]  = 'x';    //   match 4 µÄÖµ
ADDW	R1, R2, #13
MOVS	R0, #120
STRB	R0, [R1, #0]
;RF4463PRO.c,778 :: 		pcBuffer[14]  = 0xff;   //   match 4 mask
ADDW	R1, R2, #14
MOVS	R0, #255
STRB	R0, [R1, #0]
;RF4463PRO.c,779 :: 		pcBuffer[15]  = 0x03;   //  enable match 4, match 4µÄÖµÓëÍ¬²½×ÖµÄÏà¾àµÄ¾àÀë    and function
ADDW	R1, R2, #15
MOVS	R0, #3
STRB	R0, [R1, #0]
;RF4463PRO.c,782 :: 		rf_init_freq();
BL	_rf_init_freq+0
;RF4463PRO.c,783 :: 		}
L_end_rf4463Config:
LDR	LR, [SP, #0]
ADD	SP, SP, #24
BX	LR
; end of _rf4463Config
_portInit:
;RF4463PRO.c,788 :: 		void portInit()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;RF4463PRO.c,791 :: 		_SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI2_PB13_14_15 );
MOVW	R2, #lo_addr(__GPIO_MODULE_SPI2_PB13_14_15+0)
MOVT	R2, #hi_addr(__GPIO_MODULE_SPI2_PB13_14_15+0)
MOVW	R1, #772
;RF4463PRO.c,790 :: 		SPI2_Init_Advanced( _SPI_FPCLK_DIV8, _SPI_MASTER | _SPI_8_BIT | _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION | _SPI_MSB_FIRST |
MOVS	R0, #2
;RF4463PRO.c,791 :: 		_SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI2_PB13_14_15 );
BL	_SPI2_Init_Advanced+0
;RF4463PRO.c,793 :: 		UART1_Init_Advanced( 115200, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10 );
MOVW	R0, #lo_addr(__GPIO_MODULE_USART1_PA9_10+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_USART1_PA9_10+0)
PUSH	(R0)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
MOV	R0, #115200
BL	_UART1_Init_Advanced+0
ADD	SP, SP, #4
;RF4463PRO.c,800 :: 		GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_12 );  // RF4463nSEL
MOVW	R1, #4096
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;RF4463PRO.c,801 :: 		GPIO_Digital_Input( &GPIOC_BASE, _GPIO_PINMASK_12 );   // RF4463nIRQ
MOVW	R1, #4096
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Input+0
;RF4463PRO.c,802 :: 		GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_11 );  // RF4463nSDN
MOVW	R1, #2048
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;RF4463PRO.c,804 :: 		GPIO_Digital_Input( &GPIOC_BASE, _GPIO_PINMASK_11 );   // RF4463GPIO0
MOVW	R1, #2048
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Input+0
;RF4463PRO.c,805 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_10 );  // RF4463GPIO1
MOVW	R1, #1024
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;RF4463PRO.c,807 :: 		GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_7 );   // Buzzer
MOVW	R1, #128
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;RF4463PRO.c,808 :: 		GPIO_Digital_Input( &GPIOB_BASE, _GPIO_PINMASK_8 );    // Boton
MOVW	R1, #256
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Input+0
;RF4463PRO.c,810 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_6 );   // LED_RED
MOVW	R1, #64
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;RF4463PRO.c,811 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_7 );   // LED_GREEN
MOVW	R1, #128
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;RF4463PRO.c,812 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_8 );   // LED_BLUE
MOVW	R1, #256
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;RF4463PRO.c,817 :: 		}
L_end_portInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _portInit
_vRf4463PowerOnReset:
;RF4463PRO.c,824 :: 		void vRf4463PowerOnReset(){
SUB	SP, SP, #36
STR	LR, [SP, #0]
;RF4463PRO.c,837 :: 		uint8_t pcBuffer[ 7 ] = { RF_POWER_UP };
MOVS	R0, #2
STRB	R0, [SP, #27]
MOVS	R0, #1
STRB	R0, [SP, #28]
MOVS	R0, #0
STRB	R0, [SP, #29]
MOVS	R0, #1
STRB	R0, [SP, #30]
MOVS	R0, #201
STRB	R0, [SP, #31]
MOVS	R0, #195
STRB	R0, [SP, #32]
MOVS	R0, #128
STRB	R0, [SP, #33]
;RF4463PRO.c,839 :: 		vRF4463SetPinSDN( PIN_LEVEL_HIGH );
MOVS	R0, #1
BL	_vRF4463SetPinSDN+0
;RF4463PRO.c,840 :: 		Delay_us( 16 );
MOVW	R7, #191
MOVT	R7, #0
NOP
NOP
L_vRf4463PowerOnReset90:
SUBS	R7, R7, #1
BNE	L_vRf4463PowerOnReset90
NOP
NOP
NOP
;RF4463PRO.c,841 :: 		vRF4463SetPinSDN( PIN_LEVEL_LOW );
MOVS	R0, #0
BL	_vRF4463SetPinSDN+0
;RF4463PRO.c,843 :: 		Delay_ms( 6 );
MOVW	R7, #6463
MOVT	R7, #1
NOP
NOP
L_vRf4463PowerOnReset92:
SUBS	R7, R7, #1
BNE	L_vRf4463PowerOnReset92
NOP
NOP
NOP
;RF4463PRO.c,845 :: 		vRF4463SetPinSelect( PIN_LEVEL_LOW );
MOVS	R0, #0
BL	_vRF4463SetPinSelect+0
;RF4463PRO.c,846 :: 		vRf4463SPIWriteBuffer( sizeof( pcBuffer ), pcBuffer );
ADD	R0, SP, #27
MOV	R1, R0
MOVS	R0, #7
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,847 :: 		vRF4463SetPinSelect( PIN_LEVEL_HIGH );
MOVS	R0, #1
BL	_vRF4463SetPinSelect+0
;RF4463PRO.c,848 :: 		UART1_Write_Text("Power On Reset Apply\n\r");
ADD	R11, SP, #4
ADD	R10, R11, #23
MOVW	R12, #lo_addr(?ICS?lstr3_RF4463PRO+0)
MOVT	R12, #hi_addr(?ICS?lstr3_RF4463PRO+0)
BL	___CC2DW+0
ADD	R0, SP, #4
BL	_UART1_Write_Text+0
;RF4463PRO.c,849 :: 		}
L_end_vRf4463PowerOnReset:
LDR	LR, [SP, #0]
ADD	SP, SP, #36
BX	LR
; end of _vRf4463PowerOnReset
_vRf4463SPIWriteBuffer:
;RF4463PRO.c,856 :: 		void vRf4463SPIWriteBuffer( uint16_t usWriteLength, uint8_t * pcWriteBuffer ){
; pcWriteBuffer start address is: 4 (R1)
; usWriteLength start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; pcWriteBuffer end address is: 4 (R1)
; usWriteLength end address is: 0 (R0)
; usWriteLength start address is: 0 (R0)
; pcWriteBuffer start address is: 4 (R1)
; pcWriteBuffer end address is: 4 (R1)
; usWriteLength end address is: 0 (R0)
MOV	R5, R1
;RF4463PRO.c,860 :: 		while( usWriteLength-- ){
L_vRf4463SPIWriteBuffer94:
; pcWriteBuffer start address is: 20 (R5)
; usWriteLength start address is: 16 (R4)
; usWriteLength start address is: 0 (R0)
UXTH	R3, R0
SUBS	R2, R0, #1
; usWriteLength end address is: 0 (R0)
; usWriteLength start address is: 16 (R4)
UXTH	R4, R2
; usWriteLength end address is: 16 (R4)
CMP	R3, #0
IT	EQ
BEQ	L_vRf4463SPIWriteBuffer95
; usWriteLength end address is: 16 (R4)
;RF4463PRO.c,861 :: 		ucRf4463SPIByte( *pcWriteBuffer++ );
; usWriteLength start address is: 16 (R4)
LDRB	R2, [R5, #0]
UXTB	R0, R2
BL	_ucRf4463SPIByte+0
ADDS	R5, R5, #1
;RF4463PRO.c,862 :: 		}
UXTH	R0, R4
; usWriteLength end address is: 16 (R4)
; pcWriteBuffer end address is: 20 (R5)
IT	AL
BAL	L_vRf4463SPIWriteBuffer94
L_vRf4463SPIWriteBuffer95:
;RF4463PRO.c,863 :: 		}
L_end_vRf4463SPIWriteBuffer:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vRf4463SPIWriteBuffer
_vRf4463SPIReadBuffer:
;RF4463PRO.c,871 :: 		void vRf4463SPIReadBuffer( uint16_t usReadLength, uint8_t * pcReadBuffer ){
; pcReadBuffer start address is: 4 (R1)
; usReadLength start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; pcReadBuffer end address is: 4 (R1)
; usReadLength end address is: 0 (R0)
; usReadLength start address is: 0 (R0)
; pcReadBuffer start address is: 4 (R1)
;RF4463PRO.c,872 :: 		uint8_t ucRxCounter = 0;
; ucRxCounter start address is: 20 (R5)
MOVS	R5, #0
; pcReadBuffer end address is: 4 (R1)
; usReadLength end address is: 0 (R0)
; ucRxCounter end address is: 20 (R5)
MOV	R4, R1
;RF4463PRO.c,876 :: 		while( usReadLength-- ){
L_vRf4463SPIReadBuffer96:
; ucRxCounter start address is: 20 (R5)
; usReadLength start address is: 24 (R6)
; pcReadBuffer start address is: 16 (R4)
; pcReadBuffer start address is: 16 (R4)
; pcReadBuffer end address is: 16 (R4)
; usReadLength start address is: 0 (R0)
UXTH	R3, R0
SUBS	R2, R0, #1
; usReadLength end address is: 0 (R0)
; usReadLength start address is: 24 (R6)
UXTH	R6, R2
; usReadLength end address is: 24 (R6)
CMP	R3, #0
IT	EQ
BEQ	L_vRf4463SPIReadBuffer97
; pcReadBuffer end address is: 16 (R4)
; usReadLength end address is: 24 (R6)
;RF4463PRO.c,877 :: 		pcReadBuffer[ ucRxCounter++ ] = ucRf4463SPIByte( 0 );
; usReadLength start address is: 24 (R6)
; pcReadBuffer start address is: 16 (R4)
ADDS	R2, R4, R5
STR	R2, [SP, #4]
MOVS	R0, #0
BL	_ucRf4463SPIByte+0
LDR	R2, [SP, #4]
STRB	R0, [R2, #0]
ADDS	R5, R5, #1
UXTB	R5, R5
;RF4463PRO.c,878 :: 		}
UXTH	R0, R6
; pcReadBuffer end address is: 16 (R4)
; usReadLength end address is: 24 (R6)
; ucRxCounter end address is: 20 (R5)
IT	AL
BAL	L_vRf4463SPIReadBuffer96
L_vRf4463SPIReadBuffer97:
;RF4463PRO.c,879 :: 		}
L_end_vRf4463SPIReadBuffer:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vRf4463SPIReadBuffer
_ucRf4463SPIByte:
;RF4463PRO.c,887 :: 		uint8_t ucRf4463SPIByte( uint8_t pcWriteData ){
; pcWriteData start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; pcWriteData end address is: 0 (R0)
; pcWriteData start address is: 0 (R0)
;RF4463PRO.c,888 :: 		return SPI2_Read( pcWriteData );
; pcWriteData end address is: 0 (R0)
BL	_SPI2_Read+0
UXTB	R0, R0
;RF4463PRO.c,889 :: 		}
L_end_ucRf4463SPIByte:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ucRf4463SPIByte
_vRF4463SetPinSDN:
;RF4463PRO.c,897 :: 		void vRF4463SetPinSDN( uint8_t ucPinVal ){
; ucPinVal start address is: 0 (R0)
; ucPinVal end address is: 0 (R0)
; ucPinVal start address is: 0 (R0)
;RF4463PRO.c,898 :: 		RF4463nSDN = ucPinVal;
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
_SX	[R1, ByteOffset(GPIOB_ODR+0)]
; ucPinVal end address is: 0 (R0)
;RF4463PRO.c,899 :: 		}
L_end_vRF4463SetPinSDN:
BX	LR
; end of _vRF4463SetPinSDN
_vRF4463SetPinSelect:
;RF4463PRO.c,907 :: 		void vRF4463SetPinSelect( uint8_t ucPinVal ){
; ucPinVal start address is: 0 (R0)
; ucPinVal end address is: 0 (R0)
; ucPinVal start address is: 0 (R0)
;RF4463PRO.c,908 :: 		RF4463nSEL = ucPinVal;
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
_SX	[R1, ByteOffset(GPIOB_ODR+0)]
; ucPinVal end address is: 0 (R0)
;RF4463PRO.c,909 :: 		}
L_end_vRF4463SetPinSelect:
BX	LR
; end of _vRF4463SetPinSelect
_ucRf4463DeviceAvailability:
;RF4463PRO.c,917 :: 		uint8_t ucRf4463DeviceAvailability(){
SUB	SP, SP, #36
STR	LR, [SP, #0]
;RF4463PRO.c,937 :: 		if( ucRf4463GetCommand( 9, RF4463_CMD_PART_INFO, pcBuffer ) == NOT_SUCCESS ){
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #1
MOVS	R0, #9
BL	_ucRf4463GetCommand+0
CMP	R0, #1
IT	NE
BNE	L_ucRf4463DeviceAvailability98
;RF4463PRO.c,938 :: 		UART1_Write_Text("Not Found Radio Data\n\r");
ADD	R11, SP, #13
ADD	R10, R11, #23
MOVW	R12, #lo_addr(?ICS?lstr4_RF4463PRO+0)
MOVT	R12, #hi_addr(?ICS?lstr4_RF4463PRO+0)
BL	___CC2DW+0
ADD	R0, SP, #13
BL	_UART1_Write_Text+0
;RF4463PRO.c,939 :: 		return NOT_SUCCESS;
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463DeviceAvailability
;RF4463PRO.c,940 :: 		}
L_ucRf4463DeviceAvailability98:
;RF4463PRO.c,958 :: 		usPartInformation = ( ( pcBuffer[ 2 ] << 8 ) | pcBuffer[ 3 ] );
ADD	R2, SP, #4
ADDS	R0, R2, #2
LDRB	R0, [R0, #0]
LSLS	R1, R0, #8
UXTH	R1, R1
ADDS	R0, R2, #3
LDRB	R0, [R0, #0]
ORRS	R1, R0
UXTH	R1, R1
;RF4463PRO.c,960 :: 		if( usPartInformation != 0x4463 ){
MOVW	R0, #17507
CMP	R1, R0
IT	EQ
BEQ	L_ucRf4463DeviceAvailability99
;RF4463PRO.c,961 :: 		return NOT_SUCCESS;
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463DeviceAvailability
;RF4463PRO.c,962 :: 		}
L_ucRf4463DeviceAvailability99:
;RF4463PRO.c,964 :: 		return SUCCESS;
MOVS	R0, #0
;RF4463PRO.c,965 :: 		}
L_end_ucRf4463DeviceAvailability:
LDR	LR, [SP, #0]
ADD	SP, SP, #36
BX	LR
; end of _ucRf4463DeviceAvailability
_ucRf4463GetCommand:
;RF4463PRO.c,973 :: 		uint8_t ucRf4463GetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer ){
; ucCommand start address is: 4 (R1)
; ucLength start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
UXTB	R7, R0
UXTB	R8, R1
STR	R2, [SP, #4]
; ucCommand end address is: 4 (R1)
; ucLength end address is: 0 (R0)
; ucLength start address is: 28 (R7)
; ucCommand start address is: 32 (R8)
;RF4463PRO.c,974 :: 		if( ucRf4463CheckCTS() == NOT_SUCCESS ){
BL	_ucRf4463CheckCTS+0
CMP	R0, #1
IT	NE
BNE	L_ucRf4463GetCommand100
; ucLength end address is: 28 (R7)
; ucCommand end address is: 32 (R8)
;RF4463PRO.c,975 :: 		return NOT_SUCCESS;
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463GetCommand
;RF4463PRO.c,976 :: 		}
L_ucRf4463GetCommand100:
;RF4463PRO.c,978 :: 		vRF4463SetPinSelect( PIN_LEVEL_LOW );
; ucCommand start address is: 32 (R8)
; ucLength start address is: 28 (R7)
MOVS	R0, #0
BL	_vRF4463SetPinSelect+0
;RF4463PRO.c,979 :: 		ucRf4463SPIByte( ucCommand );
UXTB	R0, R8
; ucCommand end address is: 32 (R8)
BL	_ucRf4463SPIByte+0
;RF4463PRO.c,980 :: 		vRF4463SetPinSelect( PIN_LEVEL_HIGH );
MOVS	R0, #1
BL	_vRF4463SetPinSelect+0
;RF4463PRO.c,982 :: 		if( ucRf4463CheckCTS() == NOT_SUCCESS ){
BL	_ucRf4463CheckCTS+0
CMP	R0, #1
IT	NE
BNE	L_ucRf4463GetCommand101
; ucLength end address is: 28 (R7)
;RF4463PRO.c,983 :: 		return NOT_SUCCESS;
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463GetCommand
;RF4463PRO.c,984 :: 		}
L_ucRf4463GetCommand101:
;RF4463PRO.c,986 :: 		vRF4463SetPinSelect( PIN_LEVEL_LOW );
; ucLength start address is: 28 (R7)
MOVS	R0, #0
BL	_vRF4463SetPinSelect+0
;RF4463PRO.c,987 :: 		ucRf4463SPIByte( RF4463_CMD_READ_BUF );
MOVS	R0, #68
BL	_ucRf4463SPIByte+0
;RF4463PRO.c,988 :: 		vRf4463SPIReadBuffer( ucLength, pcParametersBuffer );
LDR	R1, [SP, #4]
UXTB	R0, R7
; ucLength end address is: 28 (R7)
BL	_vRf4463SPIReadBuffer+0
;RF4463PRO.c,989 :: 		vRF4463SetPinSelect( PIN_LEVEL_HIGH );
MOVS	R0, #1
BL	_vRF4463SetPinSelect+0
;RF4463PRO.c,991 :: 		return SUCCESS;
MOVS	R0, #0
;RF4463PRO.c,992 :: 		}
L_end_ucRf4463GetCommand:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRf4463GetCommand
_ucRf4463CheckCTS:
;RF4463PRO.c,1000 :: 		uint8_t ucRf4463CheckCTS(){
SUB	SP, SP, #28
STR	LR, [SP, #0]
;RF4463PRO.c,1001 :: 		uint16_t usTimeoutCounter = 0;
;RF4463PRO.c,1003 :: 		usTimeoutCounter = RF4463_CTS_TIMEOUT;
; usTimeoutCounter start address is: 8 (R2)
MOVW	R2, #2500
; usTimeoutCounter end address is: 8 (R2)
;RF4463PRO.c,1006 :: 		while( usTimeoutCounter-- ){
L_ucRf4463CheckCTS102:
; usTimeoutCounter start address is: 16 (R4)
; usTimeoutCounter start address is: 8 (R2)
UXTH	R1, R2
SUBS	R0, R2, #1
; usTimeoutCounter end address is: 8 (R2)
; usTimeoutCounter start address is: 16 (R4)
UXTH	R4, R0
; usTimeoutCounter end address is: 16 (R4)
CMP	R1, #0
IT	EQ
BEQ	L_ucRf4463CheckCTS103
; usTimeoutCounter end address is: 16 (R4)
;RF4463PRO.c,1007 :: 		vRF4463SetPinSelect( PIN_LEVEL_LOW );
; usTimeoutCounter start address is: 16 (R4)
MOVS	R0, #0
BL	_vRF4463SetPinSelect+0
;RF4463PRO.c,1008 :: 		ucRf4463SPIByte( RF4463_CMD_READ_BUF );
MOVS	R0, #68
BL	_ucRf4463SPIByte+0
;RF4463PRO.c,1009 :: 		if( ucRf4463SPIByte( RF4463_CMD_READ_BUF ) == RF4463_CTS_REPLY ){
MOVS	R0, #68
BL	_ucRf4463SPIByte+0
CMP	R0, #255
IT	NE
BNE	L_ucRf4463CheckCTS104
; usTimeoutCounter end address is: 16 (R4)
;RF4463PRO.c,1011 :: 		vRF4463SetPinSelect( PIN_LEVEL_HIGH );
MOVS	R0, #1
BL	_vRF4463SetPinSelect+0
;RF4463PRO.c,1012 :: 		return SUCCESS;
MOVS	R0, #0
IT	AL
BAL	L_end_ucRf4463CheckCTS
;RF4463PRO.c,1013 :: 		}
L_ucRf4463CheckCTS104:
;RF4463PRO.c,1014 :: 		vRF4463SetPinSelect( PIN_LEVEL_HIGH );
; usTimeoutCounter start address is: 16 (R4)
MOVS	R0, #1
BL	_vRF4463SetPinSelect+0
;RF4463PRO.c,1015 :: 		}
UXTH	R2, R4
; usTimeoutCounter end address is: 16 (R4)
IT	AL
BAL	L_ucRf4463CheckCTS102
L_ucRf4463CheckCTS103:
;RF4463PRO.c,1016 :: 		UART1_Write_Text( "[ RF4463 ] CTS failed\r\n" );
ADD	R11, SP, #4
ADD	R10, R11, #24
MOVW	R12, #lo_addr(?ICS?lstr5_RF4463PRO+0)
MOVT	R12, #hi_addr(?ICS?lstr5_RF4463PRO+0)
BL	___CC2DW+0
ADD	R0, SP, #4
BL	_UART1_Write_Text+0
;RF4463PRO.c,1017 :: 		return NOT_SUCCESS;
MOVS	R0, #1
;RF4463PRO.c,1018 :: 		}
L_end_ucRf4463CheckCTS:
LDR	LR, [SP, #0]
ADD	SP, SP, #28
BX	LR
; end of _ucRf4463CheckCTS
_GPIO_SET:
;RF4463PRO.c,1020 :: 		void GPIO_SET(unsigned char mydata)
; mydata start address is: 0 (R0)
SUB	SP, SP, #8
; mydata end address is: 0 (R0)
; mydata start address is: 0 (R0)
;RF4463PRO.c,1024 :: 		pcBuffer[0] = 0x13;     // gpio ÉèÖÃ
ADD	R2, SP, #0
MOVS	R1, #19
STRB	R1, [R2, #0]
;RF4463PRO.c,1026 :: 		switch(mydata)
IT	AL
BAL	L_GPIO_SET105
; mydata end address is: 0 (R0)
;RF4463PRO.c,1028 :: 		case tx_normal:
L_GPIO_SET107:
;RF4463PRO.c,1029 :: 		case rx_normal:
L_GPIO_SET108:
;RF4463PRO.c,1030 :: 		pcBuffer[1]  = 3;                // GPIO0=1
ADD	R3, SP, #0
ADDS	R2, R3, #1
MOVS	R1, #3
STRB	R1, [R2, #0]
;RF4463PRO.c,1031 :: 		pcBuffer[2]  = 2;                // GPIO1=0
ADDS	R2, R3, #2
MOVS	R1, #2
STRB	R1, [R2, #0]
;RF4463PRO.c,1032 :: 		break;
IT	AL
BAL	L_GPIO_SET106
;RF4463PRO.c,1034 :: 		case tx_test:
L_GPIO_SET109:
;RF4463PRO.c,1035 :: 		pcBuffer[1]  = 3;                // GPIO0=1
ADD	R3, SP, #0
ADDS	R2, R3, #1
MOVS	R1, #3
STRB	R1, [R2, #0]
;RF4463PRO.c,1036 :: 		pcBuffer[2]  = 3;                // GPIO1=1
ADDS	R2, R3, #2
MOVS	R1, #3
STRB	R1, [R2, #0]
;RF4463PRO.c,1037 :: 		break;
IT	AL
BAL	L_GPIO_SET106
;RF4463PRO.c,1039 :: 		case rx_test:
L_GPIO_SET110:
;RF4463PRO.c,1040 :: 		pcBuffer[1]  = 2;                // GPIO0=0
ADD	R3, SP, #0
ADDS	R2, R3, #1
MOVS	R1, #2
STRB	R1, [R2, #0]
;RF4463PRO.c,1041 :: 		pcBuffer[2]  = 20;               // GPIO1=RX DATA
ADDS	R2, R3, #2
MOVS	R1, #20
STRB	R1, [R2, #0]
;RF4463PRO.c,1042 :: 		break;
IT	AL
BAL	L_GPIO_SET106
;RF4463PRO.c,1044 :: 		case rf_off:
L_GPIO_SET111:
;RF4463PRO.c,1045 :: 		pcBuffer[1]  = 2;                // GPIO0=0
ADD	R3, SP, #0
ADDS	R2, R3, #1
MOVS	R1, #2
STRB	R1, [R2, #0]
;RF4463PRO.c,1046 :: 		pcBuffer[2]  = 2;                // GPIO1=0
ADDS	R2, R3, #2
MOVS	R1, #2
STRB	R1, [R2, #0]
;RF4463PRO.c,1047 :: 		break;
IT	AL
BAL	L_GPIO_SET106
;RF4463PRO.c,1048 :: 		}
L_GPIO_SET105:
; mydata start address is: 0 (R0)
CMP	R0, #0
IT	EQ
BEQ	L_GPIO_SET107
CMP	R0, #1
IT	EQ
BEQ	L_GPIO_SET108
CMP	R0, #2
IT	EQ
BEQ	L_GPIO_SET109
CMP	R0, #3
IT	EQ
BEQ	L_GPIO_SET110
CMP	R0, #4
IT	EQ
BEQ	L_GPIO_SET111
; mydata end address is: 0 (R0)
L_GPIO_SET106:
;RF4463PRO.c,1050 :: 		pcBuffer[3]  = 0x21;  //0x20;   //  gpio2, h = tx mode
ADD	R3, SP, #0
ADDS	R2, R3, #3
MOVS	R1, #33
STRB	R1, [R2, #0]
;RF4463PRO.c,1051 :: 		pcBuffer[4]  = 0x20; // 0x14;  //   gpio3
ADDS	R2, R3, #4
MOVS	R1, #32
STRB	R1, [R2, #0]
;RF4463PRO.c,1052 :: 		pcBuffer[5]  = 0x27;   // nIRQ
ADDS	R2, R3, #5
MOVS	R1, #39
STRB	R1, [R2, #0]
;RF4463PRO.c,1053 :: 		pcBuffer[6]  = 0x0b;  // sdo
ADDS	R2, R3, #6
MOVS	R1, #11
STRB	R1, [R2, #0]
;RF4463PRO.c,1055 :: 		}
L_end_GPIO_SET:
ADD	SP, SP, #8
BX	LR
; end of _GPIO_SET
_nop_10:
;RF4463PRO.c,1057 :: 		void nop_10()
;RF4463PRO.c,1059 :: 		asm{nop};
NOP
;RF4463PRO.c,1060 :: 		asm{nop};
NOP
;RF4463PRO.c,1061 :: 		asm{nop};
NOP
;RF4463PRO.c,1062 :: 		asm{nop};
NOP
;RF4463PRO.c,1063 :: 		asm{nop};
NOP
;RF4463PRO.c,1064 :: 		asm{nop};
NOP
;RF4463PRO.c,1065 :: 		asm{nop};
NOP
;RF4463PRO.c,1066 :: 		asm{nop};
NOP
;RF4463PRO.c,1067 :: 		asm{nop};
NOP
;RF4463PRO.c,1068 :: 		asm{nop};
NOP
;RF4463PRO.c,1070 :: 		}
L_end_nop_10:
BX	LR
; end of _nop_10
_rf_init_freq:
;RF4463PRO.c,1072 :: 		void rf_init_freq(void)
SUB	SP, SP, #24
;RF4463PRO.c,1079 :: 		frequency = (freq3 * 100) + (freq2 * 10) + freq1;
MOVW	R0, #lo_addr(_freq3+0)
MOVT	R0, #hi_addr(_freq3+0)
LDRB	R1, [R0, #0]
MOVS	R0, #100
SXTH	R0, R0
MUL	R2, R1, R0
SXTH	R2, R2
MOVW	R0, #lo_addr(_freq2+0)
MOVT	R0, #hi_addr(_freq2+0)
LDRB	R1, [R0, #0]
MOVS	R0, #10
SXTH	R0, R0
MULS	R0, R1, R0
SXTH	R0, R0
ADDS	R2, R2, R0
MOVW	R0, #lo_addr(_freq1+0)
MOVT	R0, #hi_addr(_freq1+0)
LDRB	R0, [R0, #0]
ADDS	R2, R2, R0
; frequency start address is: 8 (R2)
SXTH	R2, R2
;RF4463PRO.c,1080 :: 		frequency = (frequency * 10000) + 5000;
MOVW	R0, #10000
MUL	R1, R2, R0
; frequency end address is: 8 (R2)
MOVW	R0, #5000
ADDS	R1, R1, R0
; frequency start address is: 8 (R2)
MOV	R2, R1
;RF4463PRO.c,1082 :: 		if(frequency>=7600000)                                  // 760~1050
MOVW	R0, #63360
MOVT	R0, #115
CMP	R1, R0
IT	CC
BCC	L_rf_init_freq112
;RF4463PRO.c,1084 :: 		OUTDIV = 4;
MOVS	R0, #4
STRB	R0, [SP, #0]
;RF4463PRO.c,1085 :: 		BAND = 0;
MOVS	R0, #0
STRB	R0, [SP, #2]
;RF4463PRO.c,1086 :: 		VCO = 0xff;
MOVS	R0, #255
STRB	R0, [SP, #1]
;RF4463PRO.c,1087 :: 		}
IT	AL
BAL	L_rf_init_freq113
L_rf_init_freq112:
;RF4463PRO.c,1088 :: 		else if(frequency>=5460000)                             // 546~759.9
MOVW	R0, #20512
MOVT	R0, #83
CMP	R2, R0
IT	CC
BCC	L_rf_init_freq114
;RF4463PRO.c,1090 :: 		OUTDIV = 6;
MOVS	R0, #6
STRB	R0, [SP, #0]
;RF4463PRO.c,1091 :: 		BAND = 1;
MOVS	R0, #1
STRB	R0, [SP, #2]
;RF4463PRO.c,1092 :: 		VCO = 0xfe;
MOVS	R0, #254
STRB	R0, [SP, #1]
;RF4463PRO.c,1093 :: 		}
IT	AL
BAL	L_rf_init_freq115
L_rf_init_freq114:
;RF4463PRO.c,1094 :: 		else if(frequency>=3850000)                             // 385~545.9
MOVW	R0, #48912
MOVT	R0, #58
CMP	R2, R0
IT	CC
BCC	L_rf_init_freq116
;RF4463PRO.c,1096 :: 		OUTDIV = 8;
MOVS	R0, #8
STRB	R0, [SP, #0]
;RF4463PRO.c,1097 :: 		BAND = 2;
MOVS	R0, #2
STRB	R0, [SP, #2]
;RF4463PRO.c,1098 :: 		VCO = 0xfe;
MOVS	R0, #254
STRB	R0, [SP, #1]
;RF4463PRO.c,1099 :: 		}
IT	AL
BAL	L_rf_init_freq117
L_rf_init_freq116:
;RF4463PRO.c,1100 :: 		else if(frequency>=2730000)                             // 273~384.9
MOVW	R0, #43024
MOVT	R0, #41
CMP	R2, R0
IT	CC
BCC	L_rf_init_freq118
;RF4463PRO.c,1102 :: 		OUTDIV = 12;
MOVS	R0, #12
STRB	R0, [SP, #0]
;RF4463PRO.c,1103 :: 		BAND = 3;
MOVS	R0, #3
STRB	R0, [SP, #2]
;RF4463PRO.c,1104 :: 		VCO = 0xfd;
MOVS	R0, #253
STRB	R0, [SP, #1]
;RF4463PRO.c,1105 :: 		}
IT	AL
BAL	L_rf_init_freq119
L_rf_init_freq118:
;RF4463PRO.c,1106 :: 		else if(frequency>=1940000)                             // 194~272.9
MOVW	R0, #39456
MOVT	R0, #29
CMP	R2, R0
IT	CC
BCC	L_rf_init_freq120
;RF4463PRO.c,1108 :: 		OUTDIV = 16;
MOVS	R0, #16
STRB	R0, [SP, #0]
;RF4463PRO.c,1109 :: 		BAND = 4;
MOVS	R0, #4
STRB	R0, [SP, #2]
;RF4463PRO.c,1110 :: 		VCO = 0xfc;
MOVS	R0, #252
STRB	R0, [SP, #1]
;RF4463PRO.c,1111 :: 		}
IT	AL
BAL	L_rf_init_freq121
L_rf_init_freq120:
;RF4463PRO.c,1114 :: 		OUTDIV = 24;
MOVS	R0, #24
STRB	R0, [SP, #0]
;RF4463PRO.c,1115 :: 		BAND = 5;
MOVS	R0, #5
STRB	R0, [SP, #2]
;RF4463PRO.c,1116 :: 		VCO = 0xfa;
MOVS	R0, #250
STRB	R0, [SP, #1]
;RF4463PRO.c,1117 :: 		}
L_rf_init_freq121:
L_rf_init_freq119:
L_rf_init_freq117:
L_rf_init_freq115:
L_rf_init_freq113:
;RF4463PRO.c,1119 :: 		DIV = OUTDIV/2;
LDRB	R0, [SP, #0]
LSRS	R0, R0, #1
UXTB	R0, R0
;RF4463PRO.c,1121 :: 		newData = (frequency*DIV)/3;
MUL	R1, R2, R0
; frequency end address is: 8 (R2)
MOVS	R0, #3
UDIV	R2, R1, R0
;RF4463PRO.c,1122 :: 		INTE = (newData/100000)-1;
MOVW	R0, #34464
MOVT	R0, #1
UDIV	R0, R2, R0
SUBS	R0, R0, #1
; INTE start address is: 12 (R3)
UXTB	R3, R0
;RF4463PRO.c,1123 :: 		FRAC = (newData-(INTE+1)*100000)*16384/3125;
UXTB	R0, R0
ADDS	R1, R0, #1
SXTH	R1, R1
MOVW	R0, #34464
MOVT	R0, #1
MULS	R0, R1, R0
SUB	R0, R2, R0
LSLS	R1, R0, #14
MOVW	R0, #3125
UDIV	R0, R1, R0
;RF4463PRO.c,1124 :: 		FRAC = FRAC+0x80000;
ADD	R0, R0, #524288
;RF4463PRO.c,1126 :: 		FRAC_0 = FRAC;
; FRAC_0 start address is: 16 (R4)
UXTB	R4, R0
;RF4463PRO.c,1127 :: 		FRAC>>=8;
LSRS	R0, R0, #8
;RF4463PRO.c,1128 :: 		FRAC_1 = FRAC;
; FRAC_1 start address is: 20 (R5)
UXTB	R5, R0
;RF4463PRO.c,1129 :: 		FRAC>>=8;
LSRS	R0, R0, #8
;RF4463PRO.c,1130 :: 		FRAC_2 = FRAC;
; FRAC_2 start address is: 24 (R6)
UXTB	R6, R0
;RF4463PRO.c,1134 :: 		pcBuffer[0] = 0x11;
ADD	R2, SP, #3
MOVS	R0, #17
STRB	R0, [R2, #0]
;RF4463PRO.c,1135 :: 		pcBuffer[1]  = 0x20;    // 0x2051
ADDS	R1, R2, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;RF4463PRO.c,1136 :: 		pcBuffer[2]  = 0x01;    // ¹² 1¸ö²ÎÊý
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;RF4463PRO.c,1137 :: 		pcBuffer[3]  = 0x51;   // 0x2051
ADDS	R1, R2, #3
MOVS	R0, #81
STRB	R0, [R1, #0]
;RF4463PRO.c,1138 :: 		pcBuffer[4]  = 0x08|BAND;  //  high performance mode , clk outpu = osc /4
ADDS	R1, R2, #4
LDRB	R0, [SP, #2]
ORR	R0, R0, #8
STRB	R0, [R1, #0]
;RF4463PRO.c,1141 :: 		pcBuffer[0] = 0x11;
MOVS	R0, #17
STRB	R0, [R2, #0]
;RF4463PRO.c,1142 :: 		pcBuffer[1]  = 0x40;    // 0x4000
ADDS	R1, R2, #1
MOVS	R0, #64
STRB	R0, [R1, #0]
;RF4463PRO.c,1143 :: 		pcBuffer[2]  = 0x08;    // ¹² 8¸ö²ÎÊý
ADDS	R1, R2, #2
MOVS	R0, #8
STRB	R0, [R1, #0]
;RF4463PRO.c,1144 :: 		pcBuffer[3]  = 0x00;   // 0x4000
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,1145 :: 		pcBuffer[4]  = INTE;   //  default value
ADDS	R0, R2, #4
STRB	R3, [R0, #0]
; INTE end address is: 12 (R3)
;RF4463PRO.c,1146 :: 		pcBuffer[5]  = FRAC_2;   //  defaul value
ADDS	R0, R2, #5
STRB	R6, [R0, #0]
; FRAC_2 end address is: 24 (R6)
;RF4463PRO.c,1147 :: 		pcBuffer[6]  = FRAC_1;   //  default value
ADDS	R0, R2, #6
STRB	R5, [R0, #0]
; FRAC_1 end address is: 20 (R5)
;RF4463PRO.c,1148 :: 		pcBuffer[7]  = FRAC_0;   // frac ,from WDS
ADDS	R0, R2, #7
STRB	R4, [R0, #0]
; FRAC_0 end address is: 16 (R4)
;RF4463PRO.c,1149 :: 		pcBuffer[8]  = step_500K_step1;   // channel step1  from wds
ADDW	R1, R2, #8
MOVS	R0, #136
STRB	R0, [R1, #0]
;RF4463PRO.c,1150 :: 		pcBuffer[9]  = step_500K_step0;   // channel step0  from wds
ADDW	R1, R2, #9
MOVS	R0, #137
STRB	R0, [R1, #0]
;RF4463PRO.c,1151 :: 		pcBuffer[10] = 0x20;  //  from wds Ã»ÓÐÕâ¸öÖµ
ADDW	R1, R2, #10
MOVS	R0, #32
STRB	R0, [R1, #0]
;RF4463PRO.c,1152 :: 		pcBuffer[11]  = VCO;    // from wds Ã»ÓÐÕâ¸öÖµ
ADDW	R1, R2, #11
LDRB	R0, [SP, #1]
STRB	R0, [R1, #0]
;RF4463PRO.c,1154 :: 		}
L_end_rf_init_freq:
ADD	SP, SP, #24
BX	LR
; end of _rf_init_freq
_ucRf4463SetCommand:
;RF4463PRO.c,1159 :: 		uint8_t ucRf4463SetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer ){
; ucCommand start address is: 4 (R1)
; ucLength start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
UXTB	R7, R0
UXTB	R8, R1
STR	R2, [SP, #4]
; ucCommand end address is: 4 (R1)
; ucLength end address is: 0 (R0)
; ucLength start address is: 28 (R7)
; ucCommand start address is: 32 (R8)
;RF4463PRO.c,1160 :: 		if( ucRf4463CheckCTS() == NOT_SUCCESS ){
BL	_ucRf4463CheckCTS+0
CMP	R0, #1
IT	NE
BNE	L_ucRf4463SetCommand122
; ucLength end address is: 28 (R7)
; ucCommand end address is: 32 (R8)
;RF4463PRO.c,1161 :: 		return NOT_SUCCESS;
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463SetCommand
;RF4463PRO.c,1162 :: 		}
L_ucRf4463SetCommand122:
;RF4463PRO.c,1164 :: 		vRF4463SetPinSelect( PIN_LEVEL_LOW );
; ucCommand start address is: 32 (R8)
; ucLength start address is: 28 (R7)
MOVS	R0, #0
BL	_vRF4463SetPinSelect+0
;RF4463PRO.c,1165 :: 		ucRf4463SPIByte( ucCommand );
UXTB	R0, R8
; ucCommand end address is: 32 (R8)
BL	_ucRf4463SPIByte+0
;RF4463PRO.c,1166 :: 		vRf4463SPIWriteBuffer( ucLength, pcParametersBuffer );
LDR	R1, [SP, #4]
UXTB	R0, R7
; ucLength end address is: 28 (R7)
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,1167 :: 		vRF4463SetPinSelect( PIN_LEVEL_HIGH );
MOVS	R0, #1
BL	_vRF4463SetPinSelect+0
;RF4463PRO.c,1169 :: 		return SUCCESS;
MOVS	R0, #0
;RF4463PRO.c,1170 :: 		}
L_end_ucRf4463SetCommand:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRf4463SetCommand
_vBufferSetToZero:
;RF4463PRO.c,1175 :: 		void vBufferSetToZero( uint8_t * pcBufferToClean, uint16_t uslength ){
; uslength start address is: 4 (R1)
; pcBufferToClean start address is: 0 (R0)
SUB	SP, SP, #4
; uslength end address is: 4 (R1)
; pcBufferToClean end address is: 0 (R0)
; pcBufferToClean start address is: 0 (R0)
; uslength start address is: 4 (R1)
;RF4463PRO.c,1176 :: 		uint16_t usPosition = 0;
;RF4463PRO.c,1178 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
; usPosition start address is: 16 (R4)
MOVS	R4, #0
; pcBufferToClean end address is: 0 (R0)
; uslength end address is: 4 (R1)
; usPosition end address is: 16 (R4)
STRH	R1, [SP, #0]
MOV	R1, R0
LDRH	R0, [SP, #0]
L_vBufferSetToZero123:
; usPosition start address is: 16 (R4)
; pcBufferToClean start address is: 4 (R1)
; uslength start address is: 0 (R0)
; pcBufferToClean start address is: 4 (R1)
; pcBufferToClean end address is: 4 (R1)
CMP	R4, R0
IT	CS
BCS	L_vBufferSetToZero124
; pcBufferToClean end address is: 4 (R1)
;RF4463PRO.c,1179 :: 		pcBufferToClean[ usPosition ] = 0x00;
; pcBufferToClean start address is: 4 (R1)
ADDS	R3, R1, R4
MOVS	R2, #0
STRB	R2, [R3, #0]
;RF4463PRO.c,1178 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
ADDS	R4, R4, #1
UXTH	R4, R4
;RF4463PRO.c,1180 :: 		}
; uslength end address is: 0 (R0)
; pcBufferToClean end address is: 4 (R1)
; usPosition end address is: 16 (R4)
IT	AL
BAL	L_vBufferSetToZero123
L_vBufferSetToZero124:
;RF4463PRO.c,1181 :: 		}
L_end_vBufferSetToZero:
ADD	SP, SP, #4
BX	LR
; end of _vBufferSetToZero
_get_battery_voltage:
;RF4463PRO.c,1183 :: 		float get_battery_voltage()
SUB	SP, SP, #12
STR	LR, [SP, #0]
;RF4463PRO.c,1185 :: 		uint8_t write_buf[] = { 0x08 };
;RF4463PRO.c,1189 :: 		ucRf4463SetCommand( 8, RF4463_CMD_GET_ADC_READING, read_buf );
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #20
MOVS	R0, #8
BL	_ucRf4463SetCommand+0
;RF4463PRO.c,1190 :: 		battery_adc = (read_buf[2] << 8) | read_buf[3];
ADD	R2, SP, #4
ADDS	R0, R2, #2
LDRB	R0, [R0, #0]
LSLS	R1, R0, #8
UXTH	R1, R1
ADDS	R0, R2, #3
LDRB	R0, [R0, #0]
ORR	R0, R1, R0, LSL #0
UXTH	R0, R0
;RF4463PRO.c,1191 :: 		return 3.0 * battery_adc / 1280;
BL	__UnsignedIntegralToFloat+0
MOVW	R2, #0
MOVT	R2, #16448
BL	__Mul_FP+0
MOVW	R2, #0
MOVT	R2, #17568
BL	__Div_FP+0
;RF4463PRO.c,1192 :: 		}
L_end_get_battery_voltage:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _get_battery_voltage
