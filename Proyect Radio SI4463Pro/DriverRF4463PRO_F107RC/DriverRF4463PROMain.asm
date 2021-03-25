_Int_SPI2:
;driverspi.c,15 :: 		void Int_SPI2() iv IVT_INT_SPI2 ics ICS_AUTO {
;driverspi.c,17 :: 		if ( SPI2_SRbits.RXNE ) {
MOVW	R0, #lo_addr(SPI2_SRbits+0)
MOVT	R0, #hi_addr(SPI2_SRbits+0)
_LX	[R0, ByteOffset(SPI2_SRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_Int_SPI20
;driverspi.c,18 :: 		ucSPI2ByteReceived = ( unsigned char )SPI2_DR;      // lee el Byte recibido
MOVW	R0, #lo_addr(SPI2_DR+0)
MOVT	R0, #hi_addr(SPI2_DR+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucSPI2ByteReceived+0)
MOVT	R0, #hi_addr(_ucSPI2ByteReceived+0)
STRB	R1, [R0, #0]
;driverspi.c,21 :: 		}
L_Int_SPI20:
;driverspi.c,22 :: 		}
L_end_Int_SPI2:
BX	LR
; end of _Int_SPI2
_vSPI2Init:
;driverspi.c,29 :: 		void vSPI2Init ( void ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;driverspi.c,31 :: 		_SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI2_PB13_14_15 );
MOVW	R2, #lo_addr(__GPIO_MODULE_SPI2_PB13_14_15+0)
MOVT	R2, #hi_addr(__GPIO_MODULE_SPI2_PB13_14_15+0)
MOVW	R1, #772
;driverspi.c,30 :: 		SPI2_Init_Advanced( _SPI_FPCLK_DIV8, _SPI_MASTER | _SPI_8_BIT | _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION | _SPI_MSB_FIRST |
MOVS	R0, #2
;driverspi.c,31 :: 		_SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI2_PB13_14_15 );
BL	_SPI2_Init_Advanced+0
;driverspi.c,35 :: 		NVIC_IntEnable( IVT_INT_SPI2 );
MOVW	R0, #52
BL	_NVIC_IntEnable+0
;driverspi.c,36 :: 		}
L_end_vSPI2Init:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vSPI2Init
_vRF4463ISR:
;driverrf4463pro.c,28 :: 		void vRF4463ISR() iv IVT_INT_EXTI15_10 ics ICS_AUTO{
SUB	SP, SP, #4
STR	LR, [SP, #0]
;driverrf4463pro.c,29 :: 		if( EXTI_PR.B12 ){
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_LX	[R0, ByteOffset(EXTI_PR+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463ISR1
;driverrf4463pro.c,30 :: 		EXTI_PR.B12 |= 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_SX	[R0, ByteOffset(EXTI_PR+0)]
;driverrf4463pro.c,31 :: 		LED_RED = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;driverrf4463pro.c,32 :: 		ucRF4463IRQ = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
STRB	R1, [R0, #0]
;driverrf4463pro.c,33 :: 		vRF4463ClearInterrupts();
BL	_vRF4463ClearInterrupts+0
;driverrf4463pro.c,34 :: 		}
L_vRF4463ISR1:
;driverrf4463pro.c,35 :: 		}
L_end_vRF4463ISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vRF4463ISR
_vRF4463Init:
;driverrf4463pro.c,42 :: 		void vRF4463Init ( void ) {  // MODE,
SUB	SP, SP, #24
STR	LR, [SP, #0]
;driverrf4463pro.c,45 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init2:
; i start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_vRF4463Init3
;driverrf4463pro.c,46 :: 		RF_MODEM_MOD_TYPE_12_data[ i ] = RF_MODEM_MOD_TYPE_12[ rate ][ i-4 ];
MOVW	R0, #lo_addr(_RF_MODEM_MOD_TYPE_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_MOD_TYPE_12_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
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
;driverrf4463pro.c,45 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,47 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init2
L_vRF4463Init3:
;driverrf4463pro.c,50 :: 		if ( freq3 < 8 ) {
MOVW	R0, #lo_addr(_freq3+0)
MOVT	R0, #hi_addr(_freq3+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CS
BCS	L_vRF4463Init5
;driverrf4463pro.c,51 :: 		for ( i = 4; i < 12; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init6:
; i start address is: 12 (R3)
CMP	R3, #12
IT	CS
BCS	L_vRF4463Init7
;driverrf4463pro.c,52 :: 		RF_MODEM_TX_RAMP_DELAY_8_data[ i ] = RF_MODEM_TX_RAMP_DELAY_8_433[ rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
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
;driverrf4463pro.c,51 :: 		for ( i = 4; i < 12; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,53 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init6
L_vRF4463Init7:
;driverrf4463pro.c,54 :: 		for ( i = 4; i < 11; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init9:
; i start address is: 12 (R3)
CMP	R3, #11
IT	CS
BCS	L_vRF4463Init10
;driverrf4463pro.c,55 :: 		RF_MODEM_AFC_GEAR_7_data[ i ] = RF_MODEM_AFC_GEAR_7_433[ rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_AFC_GEAR_7_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AFC_GEAR_7_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #7
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_AFC_GEAR_7_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_AFC_GEAR_7_433+0)
ADDS	R1, R0, R1
SUBS	R0, R3, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;driverrf4463pro.c,54 :: 		for ( i = 4; i < 11; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,56 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init9
L_vRF4463Init10:
;driverrf4463pro.c,57 :: 		for ( i = 4; i < 15; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init12:
; i start address is: 12 (R3)
CMP	R3, #15
IT	CS
BCS	L_vRF4463Init13
;driverrf4463pro.c,58 :: 		RF_MODEM_OOK_CNT1_11_data[ i ] = RF_MODEM_OOK_CNT1_11_433[ rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_OOK_CNT1_11_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_OOK_CNT1_11_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
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
;driverrf4463pro.c,57 :: 		for ( i = 4; i < 15; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,59 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init12
L_vRF4463Init13:
;driverrf4463pro.c,60 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init15:
; i start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_vRF4463Init16
;driverrf4463pro.c,61 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433[ rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
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
;driverrf4463pro.c,60 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,62 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init15
L_vRF4463Init16:
;driverrf4463pro.c,63 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init18:
; i start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_vRF4463Init19
;driverrf4463pro.c,64 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433[ rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
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
;driverrf4463pro.c,63 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,65 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init18
L_vRF4463Init19:
;driverrf4463pro.c,66 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init21:
; i start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_vRF4463Init22
;driverrf4463pro.c,67 :: 		RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433[ rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
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
;driverrf4463pro.c,66 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,68 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init21
L_vRF4463Init22:
;driverrf4463pro.c,69 :: 		for ( i = 4; i < 13; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init24:
; i start address is: 12 (R3)
CMP	R3, #13
IT	CS
BCS	L_vRF4463Init25
;driverrf4463pro.c,70 :: 		RF_MODEM_AGC_WINDOW_SIZE_9_data[ i ] = RF_MODEM_AGC_WINDOW_SIZE_9_433[ rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
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
;driverrf4463pro.c,69 :: 		for ( i = 4; i < 13; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,71 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init24
L_vRF4463Init25:
;driverrf4463pro.c,72 :: 		for ( i = 4; i < 13; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init27:
; i start address is: 12 (R3)
CMP	R3, #13
IT	CS
BCS	L_vRF4463Init28
;driverrf4463pro.c,73 :: 		RF_MODEM_BCR_OSR_1_9_data[ i ] = RF_MODEM_BCR_OSR_1_9_433[ rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
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
;driverrf4463pro.c,72 :: 		for ( i = 4; i < 13; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,74 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init27
L_vRF4463Init28:
;driverrf4463pro.c,75 :: 		}
IT	AL
BAL	L_vRF4463Init30
L_vRF4463Init5:
;driverrf4463pro.c,77 :: 		for ( i = 4; i < 12; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init31:
; i start address is: 12 (R3)
CMP	R3, #12
IT	CS
BCS	L_vRF4463Init32
;driverrf4463pro.c,78 :: 		RF_MODEM_TX_RAMP_DELAY_8_data[ i ] = RF_MODEM_TX_RAMP_DELAY_8_850[ rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
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
;driverrf4463pro.c,77 :: 		for ( i = 4; i < 12; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,79 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init31
L_vRF4463Init32:
;driverrf4463pro.c,80 :: 		for ( i = 4; i < 11; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init34:
; i start address is: 12 (R3)
CMP	R3, #11
IT	CS
BCS	L_vRF4463Init35
;driverrf4463pro.c,81 :: 		RF_MODEM_AFC_GEAR_7_data[ i ] = RF_MODEM_AFC_GEAR_7_850[ rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_AFC_GEAR_7_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AFC_GEAR_7_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
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
;driverrf4463pro.c,80 :: 		for ( i = 4; i < 11; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,82 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init34
L_vRF4463Init35:
;driverrf4463pro.c,83 :: 		for ( i = 4; i < 15; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init37:
; i start address is: 12 (R3)
CMP	R3, #15
IT	CS
BCS	L_vRF4463Init38
;driverrf4463pro.c,84 :: 		RF_MODEM_OOK_CNT1_11_data[ i ] = RF_MODEM_OOK_CNT1_11_850[ rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_OOK_CNT1_11_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_OOK_CNT1_11_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
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
;driverrf4463pro.c,83 :: 		for ( i = 4; i < 15; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,85 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init37
L_vRF4463Init38:
;driverrf4463pro.c,86 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init40:
; i start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_vRF4463Init41
;driverrf4463pro.c,87 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850[ rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
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
;driverrf4463pro.c,86 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,88 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init40
L_vRF4463Init41:
;driverrf4463pro.c,89 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init43:
; i start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_vRF4463Init44
;driverrf4463pro.c,90 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850[ rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
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
;driverrf4463pro.c,89 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,91 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init43
L_vRF4463Init44:
;driverrf4463pro.c,92 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init46:
; i start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_vRF4463Init47
;driverrf4463pro.c,93 :: 		RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850[ rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
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
;driverrf4463pro.c,92 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,94 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init46
L_vRF4463Init47:
;driverrf4463pro.c,95 :: 		for ( i = 4; i < 13; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init49:
; i start address is: 12 (R3)
CMP	R3, #13
IT	CS
BCS	L_vRF4463Init50
;driverrf4463pro.c,96 :: 		RF_MODEM_AGC_WINDOW_SIZE_9_data[ i ] = RF_MODEM_AGC_WINDOW_SIZE_9_850[ rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
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
;driverrf4463pro.c,95 :: 		for ( i = 4; i < 13; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,97 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init49
L_vRF4463Init50:
;driverrf4463pro.c,98 :: 		for ( i = 4; i < 13; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init52:
; i start address is: 12 (R3)
CMP	R3, #13
IT	CS
BCS	L_vRF4463Init53
;driverrf4463pro.c,99 :: 		RF_MODEM_BCR_OSR_1_9_data[ i ] = RF_MODEM_BCR_OSR_1_9_850[ rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
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
;driverrf4463pro.c,98 :: 		for ( i = 4; i < 13; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,100 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init52
L_vRF4463Init53:
;driverrf4463pro.c,101 :: 		}
L_vRF4463Init30:
;driverrf4463pro.c,102 :: 		for ( i = 4; i < 11; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init55:
; i start address is: 12 (R3)
CMP	R3, #11
IT	CS
BCS	L_vRF4463Init56
;driverrf4463pro.c,103 :: 		RF_SYNTH_PFDCP_CPFF_7_data[ i ] = RF_SYNTH_PFDCP_CPFF_7[ rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
MOVT	R0, #hi_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
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
;driverrf4463pro.c,102 :: 		for ( i = 4; i < 11; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,104 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init55
L_vRF4463Init56:
;driverrf4463pro.c,108 :: 		vRF4463GPIO_SET( mode );                                                      // PARAMETRO CONFIGURABLE
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
BL	_vRF4463GPIO_SET+0
;driverrf4463pro.c,111 :: 		app_command_buf[ 0 ] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,112 :: 		app_command_buf[ 1 ] = 0x00;    // 0x0000
ADDS	R1, R2, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,113 :: 		app_command_buf[ 2 ] = 0x01;    // Total 1 Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,114 :: 		app_command_buf[ 3 ] = 0x00;    // 0x0000
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,115 :: 		app_command_buf[ 4 ] = 98;      // freq  adjustment    ( rango desde 0 - 127 Low cap - High Cap )
ADDS	R1, R2, #4
MOVS	R0, #98
STRB	R0, [R1, #0]
;driverrf4463pro.c,116 :: 		spi_write( 5, app_command_buf );
MOV	R1, R2
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,119 :: 		app_command_buf[ 0 ] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,120 :: 		app_command_buf[ 1 ] = 0x00;    // 0x0003
ADDS	R1, R2, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,121 :: 		app_command_buf[ 2 ] = 0x01;    // Total 1 Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,122 :: 		app_command_buf[ 3 ] = 0x03;   // 0x0003
ADDS	R1, R2, #3
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,123 :: 		app_command_buf[ 4 ] = 0x40;  // tx = rx = 64 byte, ordinary PH,high performance mode  ?????????????????????
ADDS	R1, R2, #4
MOVS	R0, #64
STRB	R0, [R1, #0]
;driverrf4463pro.c,124 :: 		spi_write( 5, app_command_buf );
MOV	R1, R2
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,128 :: 		spi_write( 0x08, RF_FRR_CTL_A_MODE_4_data );    // disable all fast response register
MOVW	R1, #lo_addr(_RF_FRR_CTL_A_MODE_4_data+0)
MOVT	R1, #hi_addr(_RF_FRR_CTL_A_MODE_4_data+0)
MOVS	R0, #8
BL	_spi_write+0
;driverrf4463pro.c,131 :: 		app_command_buf[ 0 ] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,132 :: 		app_command_buf[ 1 ] = 0x10;    // 0x1000
ADDS	R1, R2, #1
MOVS	R0, #16
STRB	R0, [R1, #0]
;driverrf4463pro.c,133 :: 		app_command_buf[ 2 ] = 0x09;    // Total 9 Parameters
ADDS	R1, R2, #2
MOVS	R0, #9
STRB	R0, [R1, #0]
;driverrf4463pro.c,134 :: 		app_command_buf[ 3 ] = 0x00;   // 0x1000
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,136 :: 		if ( mode == tx_test_mode ) {
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_vRF4463Init58
;driverrf4463pro.c,137 :: 		app_command_buf[ 4 ] = 0xff;     //  Need to send 255 bytes of Preamble
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #255
STRB	R0, [R1, #0]
;driverrf4463pro.c,138 :: 		}
IT	AL
BAL	L_vRF4463Init59
L_vRF4463Init58:
;driverrf4463pro.c,140 :: 		app_command_buf[ 4 ] = 0x08;   //  Need to send 8 bytes of Preamble
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,141 :: 		}
L_vRF4463Init59:
;driverrf4463pro.c,144 :: 		app_command_buf[ 5 ]   = 0x14;       //To detect 20 bit sync word,
ADD	R2, SP, #4
ADDS	R1, R2, #5
MOVS	R0, #20
STRB	R0, [R1, #0]
;driverrf4463pro.c,145 :: 		app_command_buf[ 6 ]   = 0x00;       // Non-standard preamble settings, useless
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,146 :: 		app_command_buf[ 7 ]   = 0x0f;       // Time of the preamble Timeout   ????????????????????????????????????????????????????????????
ADDS	R1, R2, #7
MOVS	R0, #15
STRB	R0, [R1, #0]
;driverrf4463pro.c,147 :: 		app_command_buf[ 8 ]   = 0x31;       // The length of the preamble is   byte Calculation , 1st = 1 NO manchest  Encoding, using standard 1010.??
ADDW	R1, R2, #8
MOVS	R0, #49
STRB	R0, [R1, #0]
;driverrf4463pro.c,148 :: 		app_command_buf[ 9 ]   = 0x0;        //  Non-standard Preamble Patten 4th byte
ADDW	R1, R2, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,149 :: 		app_command_buf[ 10 ]  = 0x00;       //  Non-standard Preamble Patten 3rd byte
ADDW	R1, R2, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,150 :: 		app_command_buf[ 11 ]  = 0x00;       //  Non-standard Preamble Patten 2nd byte
ADDW	R1, R2, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,151 :: 		app_command_buf[ 12 ]  = 0x00;       //  Non-standard Preamble Patten 1st byte
ADDW	R1, R2, #12
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,152 :: 		spi_write(13, app_command_buf);
MOV	R1, R2
MOVS	R0, #13
BL	_spi_write+0
;driverrf4463pro.c,155 :: 		app_command_buf[ 0 ] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,156 :: 		app_command_buf[ 1 ] = 0x11;         // command = 0x1100
ADDS	R1, R2, #1
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,157 :: 		app_command_buf[ 2 ] = 0x05;         // Total 5 Parameters
ADDS	R1, R2, #2
MOVS	R0, #5
STRB	R0, [R1, #0]
;driverrf4463pro.c,158 :: 		app_command_buf[ 3 ] = 0x00;         // command = 0x1100
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,159 :: 		app_command_buf[ 4 ] = 0x01;         // The synchronization word is defined and sent in the length field, and the synchronization word cannot be wrong,Not 4FSK, not manchest encoding, only 2 bytes
ADDS	R1, R2, #4
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,161 :: 		if ( mode == tx_test_mode ) {
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_vRF4463Init60
;driverrf4463pro.c,162 :: 		app_command_buf[ 5 ] = 0x55;      //Sync word 3
ADD	R2, SP, #4
ADDS	R1, R2, #5
MOVS	R0, #85
STRB	R0, [R1, #0]
;driverrf4463pro.c,163 :: 		app_command_buf[ 6 ] = 0x55;      // Sync word 2
ADDS	R1, R2, #6
MOVS	R0, #85
STRB	R0, [R1, #0]
;driverrf4463pro.c,164 :: 		}
IT	AL
BAL	L_vRF4463Init61
L_vRF4463Init60:
;driverrf4463pro.c,166 :: 		app_command_buf[ 5 ] = 0x2d;    //Sync word 3
ADD	R2, SP, #4
ADDS	R1, R2, #5
MOVS	R0, #45
STRB	R0, [R1, #0]
;driverrf4463pro.c,167 :: 		app_command_buf[ 6 ] = 0xd4;    // Sync word 2
ADDS	R1, R2, #6
MOVS	R0, #212
STRB	R0, [R1, #0]
;driverrf4463pro.c,168 :: 		}
L_vRF4463Init61:
;driverrf4463pro.c,170 :: 		app_command_buf[ 7 ] =  0x00;        // Sync word 1
ADD	R2, SP, #4
ADDS	R1, R2, #7
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,171 :: 		app_command_buf[ 8 ] = 0x00;        // Sync word 0
ADDW	R1, R2, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,172 :: 		spi_write( 9, app_command_buf );
MOV	R1, R2
MOVS	R0, #9
BL	_spi_write+0
;driverrf4463pro.c,175 :: 		app_command_buf[ 0 ] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,176 :: 		app_command_buf[ 1 ] = 0x12;        // command = 0x1200
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,177 :: 		app_command_buf[ 2 ] = 0x01;        // Total 1 Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,178 :: 		app_command_buf[ 3 ] = 0x00;        // command = 0x1200
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,179 :: 		app_command_buf[ 4 ] = 0x81;        // 1?cRC ??,CRC = itu-c, enable crc
ADDS	R1, R2, #4
MOVS	R0, #129
STRB	R0, [R1, #0]
;driverrf4463pro.c,180 :: 		spi_write( 5, app_command_buf );
MOV	R1, R2
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,183 :: 		app_command_buf[ 0 ] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,184 :: 		app_command_buf[ 1 ] = 0x12;        // command = 0x1206
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,185 :: 		app_command_buf[ 2 ] = 0x01;        // Total 1Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,186 :: 		app_command_buf[ 3 ] = 0x06;        // command = 0x1206
ADDS	R1, R2, #3
MOVS	R0, #6
STRB	R0, [R1, #0]
;driverrf4463pro.c,187 :: 		app_command_buf[ 4 ] = 0x02;        //  tx = rx = 120d--1220 (tx packet,ph enable, not 4fsk, After receiving a packet of data,RX off,CRC Do not flip ,CRC MSB, data MSB
ADDS	R1, R2, #4
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,188 :: 		spi_write( 5, app_command_buf );
MOV	R1, R2
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,191 :: 		app_command_buf[ 0 ] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,192 :: 		app_command_buf[ 1 ] = 0x12;        // command = 0x1208
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,193 :: 		app_command_buf[ 2 ] = 0x03;        // Total 3 Parameters
ADDS	R1, R2, #2
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,194 :: 		app_command_buf[ 3 ] = 0x08;        // command = 0x1208
ADDS	R1, R2, #3
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,195 :: 		app_command_buf[ 4 ] = 0x00;        // Length Field = LSB,  length Only 1 byte,length Not put In FiFo, fixed packet length mode
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,196 :: 		app_command_buf[ 5 ] = 0x00;        // Used for variable packet length mode, which defines which Field contains length Filed
ADDS	R1, R2, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,197 :: 		app_command_buf[ 6 ] = 0x00;        // Used for variable packet length mode, adjust the length of variable packet length
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,198 :: 		spi_write( 7, app_command_buf );
MOV	R1, R2
MOVS	R0, #7
BL	_spi_write+0
;driverrf4463pro.c,201 :: 		app_command_buf[ 0 ]  = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,202 :: 		app_command_buf[ 1 ]  = 0x12;       // 0x120d
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,203 :: 		app_command_buf[ 2 ]  = 0x0c;       // Total 12 Parameters
ADDS	R1, R2, #2
MOVS	R0, #12
STRB	R0, [R1, #0]
;driverrf4463pro.c,204 :: 		app_command_buf[ 3 ]  = 0x0d;       // 0x120d
ADDS	R1, R2, #3
MOVS	R0, #13
STRB	R0, [R1, #0]
;driverrf4463pro.c,205 :: 		app_command_buf[ 4 ]  = 0x00;       //  Field 1 length (?4?)
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,206 :: 		app_command_buf[ 5 ]  = payload_length;   //  field 1 length, (? 8?), ?Total14???
ADDS	R1, R2, #5
MOVS	R0, #14
STRB	R0, [R1, #0]
;driverrf4463pro.c,207 :: 		app_command_buf[ 6 ]  = 0x04;       // field 1 Is not 4FSK,manchest, whiting, PN9,
ADDS	R1, R2, #6
MOVS	R0, #4
STRB	R0, [R1, #0]
;driverrf4463pro.c,208 :: 		app_command_buf[ 7 ]  = 0xaa;       // field 1 crc enble, check enbale, There are also launchingCRC,cRC?Seed ?CRC_seed?????
ADDS	R1, R2, #7
MOVS	R0, #170
STRB	R0, [R1, #0]
;driverrf4463pro.c,209 :: 		app_command_buf[ 8 ]  = 0x00;       //  field 2 length(?4?)
ADDW	R1, R2, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,210 :: 		app_command_buf[ 9 ]  = 0x00;           //  field 2 length, (? 8?), length = 0 Means thisfield did not use
ADDW	R1, R2, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,211 :: 		app_command_buf[ 10 ] = 0x00;       // field 2 Is not 4FSK,manchest, whiting, PN9
ADDW	R1, R2, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,212 :: 		app_command_buf[ 11 ] = 0x00;       //  field 2 ?CRCSet up
ADDW	R1, R2, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,213 :: 		app_command_buf[ 12 ] = 0x00;       //  field 3 length, (? 8?), length = 0 Means thisfield did not use
ADDW	R1, R2, #12
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,214 :: 		app_command_buf[ 13 ] = 0x00;           //  field 3 length, (? 8?), length = 0 Means thisfield did not use
ADDW	R1, R2, #13
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,215 :: 		app_command_buf[ 14 ] = 0x00;       //  field 3 Is not 4FSK,manchest, whiting, PN9
ADDW	R1, R2, #14
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,216 :: 		app_command_buf[ 15 ] = 0x00;       //  field 3 ?CRCSet up
ADDW	R1, R2, #15
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,217 :: 		spi_write( 16, app_command_buf );
MOV	R1, R2
MOVS	R0, #16
BL	_spi_write+0
;driverrf4463pro.c,220 :: 		app_command_buf[ 0 ]  = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,221 :: 		app_command_buf[ 1 ]  = 0x12;       // 0x1219
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,222 :: 		app_command_buf[ 2 ]  = 0x08;       // Total 8Parameters
ADDS	R1, R2, #2
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,223 :: 		app_command_buf[ 3 ]  = 0x19;       // 0x1219
ADDS	R1, R2, #3
MOVS	R0, #25
STRB	R0, [R1, #0]
;driverrf4463pro.c,224 :: 		app_command_buf[ 4 ]  = 0x00;       // field4 length(?4?)
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,225 :: 		app_command_buf[ 5 ]  = 0x00;       // field 4 length, (? 8?), length = 0 Means this field did not use
ADDS	R1, R2, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,226 :: 		app_command_buf[ 6 ]  = 0x00;       // field 4 Is not 4FSK,manchest, whiting, PN9
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,227 :: 		app_command_buf[ 7 ]  = 0x00;       // field 4 ?CRCSet up
ADDS	R1, R2, #7
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,228 :: 		app_command_buf[ 8 ]  = 0x00;       // field5 length(?4?)
ADDW	R1, R2, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,229 :: 		app_command_buf[ 9 ]  = 0x00;       // field 5 length, (? 8?), length = 0 Means this field did not use
ADDW	R1, R2, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,230 :: 		app_command_buf[ 10 ] = 0x00;       // field 5 Is not 4FSK,manchest, whiting, PN9
ADDW	R1, R2, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,231 :: 		app_command_buf[ 11 ] = 0x00;       // field 5 ?CRCSet up
ADDW	R1, R2, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,232 :: 		spi_write( 12, app_command_buf );
MOV	R1, R2
MOVS	R0, #12
BL	_spi_write+0
;driverrf4463pro.c,235 :: 		spi_write( 0x10, RF_MODEM_MOD_TYPE_12_data );   // //  2FSK ,  module source = PH fifo, disable manchest, tx, rx Do not flip, deviation Do not flip
MOVW	R1, #lo_addr(_RF_MODEM_MOD_TYPE_12_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_MOD_TYPE_12_data+0)
MOVS	R0, #16
BL	_spi_write+0
;driverrf4463pro.c,238 :: 		app_command_buf[0] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,239 :: 		app_command_buf[1]  = 0x20;    // 0x200c
ADDS	R1, R2, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,240 :: 		app_command_buf[2]  = 0x01;    // Total 1Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,241 :: 		app_command_buf[3]  = 0x0c;   // 0x200c
ADDS	R1, R2, #3
MOVS	R0, #12
STRB	R0, [R1, #0]
;driverrf4463pro.c,243 :: 		if ( freq3 < 8 ) {
MOVW	R0, #lo_addr(_freq3+0)
MOVT	R0, #hi_addr(_freq3+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CS
BCS	L_vRF4463Init62
;driverrf4463pro.c,244 :: 		if ( rate >= dr_256k ) {
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CC
BCC	L_vRF4463Init63
;driverrf4463pro.c,245 :: 		app_command_buf[ 4 ] = 0x4f;
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #79
STRB	R0, [R1, #0]
;driverrf4463pro.c,246 :: 		}
IT	AL
BAL	L_vRF4463Init64
L_vRF4463Init63:
;driverrf4463pro.c,247 :: 		else if ( rate >= dr_19p2 ) {
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	CC
BCC	L_vRF4463Init65
;driverrf4463pro.c,248 :: 		app_command_buf[ 4 ]  = 0x5e;
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #94
STRB	R0, [R1, #0]
;driverrf4463pro.c,249 :: 		}
IT	AL
BAL	L_vRF4463Init66
L_vRF4463Init65:
;driverrf4463pro.c,251 :: 		app_command_buf[4]  = 0xd2;
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #210
STRB	R0, [R1, #0]
;driverrf4463pro.c,252 :: 		}
L_vRF4463Init66:
L_vRF4463Init64:
;driverrf4463pro.c,253 :: 		}
IT	AL
BAL	L_vRF4463Init67
L_vRF4463Init62:
;driverrf4463pro.c,255 :: 		if ( rate >= dr_115p2 ) {
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	CC
BCC	L_vRF4463Init68
;driverrf4463pro.c,256 :: 		app_command_buf[4]  = 0x69;        // 15k
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #105
STRB	R0, [R1, #0]
;driverrf4463pro.c,257 :: 		}
IT	AL
BAL	L_vRF4463Init69
L_vRF4463Init68:
;driverrf4463pro.c,258 :: 		else if ( rate >= dr_19p2 ) {
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	CC
BCC	L_vRF4463Init70
;driverrf4463pro.c,259 :: 		app_command_buf[4]  = 0x5e;        // 10k
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #94
STRB	R0, [R1, #0]
;driverrf4463pro.c,260 :: 		}
IT	AL
BAL	L_vRF4463Init71
L_vRF4463Init70:
;driverrf4463pro.c,262 :: 		app_command_buf[4]  = 0x18; // 8k
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #24
STRB	R0, [R1, #0]
;driverrf4463pro.c,263 :: 		}
L_vRF4463Init71:
L_vRF4463Init69:
;driverrf4463pro.c,264 :: 		}
L_vRF4463Init67:
;driverrf4463pro.c,265 :: 		spi_write(5, app_command_buf);
ADD	R0, SP, #4
MOV	R1, R0
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,268 :: 		spi_write( 0x0C, RF_MODEM_TX_RAMP_DELAY_8_data );            // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
MOVS	R0, #12
BL	_spi_write+0
;driverrf4463pro.c,269 :: 		spi_write( 0x0D, RF_MODEM_BCR_OSR_1_9_data );                // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
MOVS	R0, #13
BL	_spi_write+0
;driverrf4463pro.c,270 :: 		spi_write( 0x0B, RF_MODEM_AFC_GEAR_7_data );                // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_AFC_GEAR_7_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_AFC_GEAR_7_data+0)
MOVS	R0, #11
BL	_spi_write+0
;driverrf4463pro.c,271 :: 		spi_write( 0x05, RF_MODEM_AGC_CONTROL_1_data );                // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_AGC_CONTROL_1_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_AGC_CONTROL_1_data+0)
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,272 :: 		spi_write( 0x0D, RF_MODEM_AGC_WINDOW_SIZE_9_data );        // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
MOVS	R0, #13
BL	_spi_write+0
;driverrf4463pro.c,273 :: 		spi_write( 0x0F, RF_MODEM_OOK_CNT1_11_data );                // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_OOK_CNT1_11_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_OOK_CNT1_11_data+0)
MOVS	R0, #15
BL	_spi_write+0
;driverrf4463pro.c,276 :: 		app_command_buf[ 0 ] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,277 :: 		app_command_buf[ 1 ] = 0x20;    // 0x204e
ADDS	R1, R2, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,278 :: 		app_command_buf[ 2 ] = 0x01;    // Total 1Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,279 :: 		app_command_buf[ 3 ] = 0x4e;   // 0x204e
ADDS	R1, R2, #3
MOVS	R0, #78
STRB	R0, [R1, #0]
;driverrf4463pro.c,281 :: 		if ( rate == dr_500 ) {
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	NE
BNE	L_vRF4463Init72
;driverrf4463pro.c,282 :: 		app_command_buf[ 4 ] = 0x3a;
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #58
STRB	R0, [R1, #0]
;driverrf4463pro.c,283 :: 		}
IT	AL
BAL	L_vRF4463Init73
L_vRF4463Init72:
;driverrf4463pro.c,285 :: 		app_command_buf[ 4 ] = 0x40;  //  rssi Reading deviation, the difference with the true value
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #64
STRB	R0, [R1, #0]
;driverrf4463pro.c,286 :: 		}
L_vRF4463Init73:
;driverrf4463pro.c,287 :: 		spi_write(5, app_command_buf);
ADD	R0, SP, #4
MOV	R1, R0
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,290 :: 		spi_write( 0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data );  // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVS	R0, #16
BL	_spi_write+0
;driverrf4463pro.c,291 :: 		spi_write( 0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data );   // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVS	R0, #16
BL	_spi_write+0
;driverrf4463pro.c,292 :: 		spi_write( 0x10, RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data );   // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVS	R0, #16
BL	_spi_write+0
;driverrf4463pro.c,295 :: 		app_command_buf[0] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,296 :: 		app_command_buf[1]  = 0x22;    // 0x2200
ADDS	R1, R2, #1
MOVS	R0, #34
STRB	R0, [R1, #0]
;driverrf4463pro.c,297 :: 		app_command_buf[2]  = 0x04;    // Total 4Parameters
ADDS	R1, R2, #2
MOVS	R0, #4
STRB	R0, [R1, #0]
;driverrf4463pro.c,298 :: 		app_command_buf[3]  = 0x00;   // 0x2200
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,299 :: 		app_command_buf[4]  = 0x08;  //0x10;   //   PA mode  = default , ??Class E mode,?Is not Switch Current mode  ????????
ADDS	R1, R2, #4
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,300 :: 		if ( power == 7 ) {
MOVW	R0, #lo_addr(_power+0)
MOVT	R0, #hi_addr(_power+0)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	NE
BNE	L_vRF4463Init74
;driverrf4463pro.c,301 :: 		app_command_buf[ 5 ]  = 127;   //  Set to maximum power
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #127
STRB	R0, [R1, #0]
;driverrf4463pro.c,302 :: 		}
IT	AL
BAL	L_vRF4463Init75
L_vRF4463Init74:
;driverrf4463pro.c,303 :: 		else if ( power == 6 ) {
MOVW	R0, #lo_addr(_power+0)
MOVT	R0, #hi_addr(_power+0)
LDRB	R0, [R0, #0]
CMP	R0, #6
IT	NE
BNE	L_vRF4463Init76
;driverrf4463pro.c,304 :: 		app_command_buf[ 5 ]  = 50;
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #50
STRB	R0, [R1, #0]
;driverrf4463pro.c,305 :: 		}
IT	AL
BAL	L_vRF4463Init77
L_vRF4463Init76:
;driverrf4463pro.c,306 :: 		else if ( power == 5 ) {
MOVW	R0, #lo_addr(_power+0)
MOVT	R0, #hi_addr(_power+0)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_vRF4463Init78
;driverrf4463pro.c,307 :: 		app_command_buf[ 5 ]  = 30;
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #30
STRB	R0, [R1, #0]
;driverrf4463pro.c,308 :: 		}
IT	AL
BAL	L_vRF4463Init79
L_vRF4463Init78:
;driverrf4463pro.c,309 :: 		else if ( power == 4 ) {
MOVW	R0, #lo_addr(_power+0)
MOVT	R0, #hi_addr(_power+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_vRF4463Init80
;driverrf4463pro.c,310 :: 		app_command_buf[ 5 ]  = 20;
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #20
STRB	R0, [R1, #0]
;driverrf4463pro.c,311 :: 		}
IT	AL
BAL	L_vRF4463Init81
L_vRF4463Init80:
;driverrf4463pro.c,312 :: 		else if ( power == 3) {
MOVW	R0, #lo_addr(_power+0)
MOVT	R0, #hi_addr(_power+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BNE	L_vRF4463Init82
;driverrf4463pro.c,313 :: 		app_command_buf[ 5 ]  = 15;
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #15
STRB	R0, [R1, #0]
;driverrf4463pro.c,314 :: 		}
IT	AL
BAL	L_vRF4463Init83
L_vRF4463Init82:
;driverrf4463pro.c,315 :: 		else if( power == 2 ) {
MOVW	R0, #lo_addr(_power+0)
MOVT	R0, #hi_addr(_power+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_vRF4463Init84
;driverrf4463pro.c,316 :: 		app_command_buf[ 5 ]  = 10;
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #10
STRB	R0, [R1, #0]
;driverrf4463pro.c,317 :: 		}
IT	AL
BAL	L_vRF4463Init85
L_vRF4463Init84:
;driverrf4463pro.c,318 :: 		else if ( power == 1 ) {
MOVW	R0, #lo_addr(_power+0)
MOVT	R0, #hi_addr(_power+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_vRF4463Init86
;driverrf4463pro.c,319 :: 		app_command_buf[ 5 ]  = 7;
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #7
STRB	R0, [R1, #0]
;driverrf4463pro.c,320 :: 		}
IT	AL
BAL	L_vRF4463Init87
L_vRF4463Init86:
;driverrf4463pro.c,322 :: 		app_command_buf[ 5 ]  = 4;
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #4
STRB	R0, [R1, #0]
;driverrf4463pro.c,323 :: 		}
L_vRF4463Init87:
L_vRF4463Init85:
L_vRF4463Init83:
L_vRF4463Init81:
L_vRF4463Init79:
L_vRF4463Init77:
L_vRF4463Init75:
;driverrf4463pro.c,324 :: 		app_command_buf[ 6 ] = 0x00; //???????? 0x00;   // CLK duty = 50%, other = Default
ADD	R0, SP, #4
ADDS	R1, R0, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,326 :: 		if ( ( rate <= dr_115p2 )||( rate == dr_500 ) ) {
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	LS
BLS	L__vRF4463Init310
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	EQ
BEQ	L__vRF4463Init309
IT	AL
BAL	L_vRF4463Init90
L__vRF4463Init310:
L__vRF4463Init309:
;driverrf4463pro.c,327 :: 		app_command_buf[ 7 ]  = 0x3d;  // ???????? 0x5d;   // PA ramp time = default
ADD	R0, SP, #4
ADDS	R1, R0, #7
MOVS	R0, #61
STRB	R0, [R1, #0]
;driverrf4463pro.c,328 :: 		}
IT	AL
BAL	L_vRF4463Init91
L_vRF4463Init90:
;driverrf4463pro.c,330 :: 		app_command_buf[ 7 ]  = 0x5d;
ADD	R0, SP, #4
ADDS	R1, R0, #7
MOVS	R0, #93
STRB	R0, [R1, #0]
;driverrf4463pro.c,331 :: 		}
L_vRF4463Init91:
;driverrf4463pro.c,332 :: 		spi_write( 8, app_command_buf );
ADD	R0, SP, #4
MOV	R1, R0
MOVS	R0, #8
BL	_spi_write+0
;driverrf4463pro.c,336 :: 		spi_write( 0x0B , RF_SYNTH_PFDCP_CPFF_7_data );      // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
MOVT	R1, #hi_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
MOVS	R0, #11
BL	_spi_write+0
;driverrf4463pro.c,339 :: 		app_command_buf[ 0 ]  = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,340 :: 		app_command_buf[ 1 ]  = 0x30;    // 0x3000
ADDS	R1, R2, #1
MOVS	R0, #48
STRB	R0, [R1, #0]
;driverrf4463pro.c,341 :: 		app_command_buf[ 2 ]  = 0x0c;    // Total 12 Parameters
ADDS	R1, R2, #2
MOVS	R0, #12
STRB	R0, [R1, #0]
;driverrf4463pro.c,342 :: 		app_command_buf[ 3 ]  = 0x00;    // 0x3000
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,343 :: 		app_command_buf[ 4 ]  = 's';     // 0x00;   //  match 1 Value of
ADDS	R1, R2, #4
MOVS	R0, #115
STRB	R0, [R1, #0]
;driverrf4463pro.c,344 :: 		app_command_buf[ 5 ]  = 0xff;    //  match 1 mask
ADDS	R1, R2, #5
MOVS	R0, #255
STRB	R0, [R1, #0]
;driverrf4463pro.c,345 :: 		app_command_buf[ 6 ]  = 0x40;    // enable match 1, match 1 The distance between the value of and the synchronization word, 0 = match
ADDS	R1, R2, #6
MOVS	R0, #64
STRB	R0, [R1, #0]
;driverrf4463pro.c,346 :: 		app_command_buf[ 7 ]  = 'w';     //  match 2 Value of
ADDS	R1, R2, #7
MOVS	R0, #119
STRB	R0, [R1, #0]
;driverrf4463pro.c,347 :: 		app_command_buf[ 8 ]  = 0xff;    //  match 2 mask
ADDW	R1, R2, #8
MOVS	R0, #255
STRB	R0, [R1, #0]
;driverrf4463pro.c,348 :: 		app_command_buf[ 9 ]  = 0x01;    // enable match 2, match 2 The distance between the value of and the synchronization word  , and function
ADDW	R1, R2, #9
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,349 :: 		app_command_buf[ 10 ] = 'w';     //     match 3 Value of
ADDW	R1, R2, #10
MOVS	R0, #119
STRB	R0, [R1, #0]
;driverrf4463pro.c,350 :: 		app_command_buf[ 11 ] = 0xff;;   //  match 3 mask
ADDW	R1, R2, #11
MOVS	R0, #255
STRB	R0, [R1, #0]
;driverrf4463pro.c,351 :: 		app_command_buf[ 12 ] = 0x02;;   // enable match 3, match 3 The distance between the value of and the synchronization word    and function
ADDW	R1, R2, #12
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,352 :: 		app_command_buf[ 13 ] = 'x';     //   match 4 Value of
ADDW	R1, R2, #13
MOVS	R0, #120
STRB	R0, [R1, #0]
;driverrf4463pro.c,353 :: 		app_command_buf[ 14 ] = 0xff;    //   match 4 mask
ADDW	R1, R2, #14
MOVS	R0, #255
STRB	R0, [R1, #0]
;driverrf4463pro.c,354 :: 		app_command_buf[ 15 ] = 0x03;    //  enable match 4, match 4 The distance between the value of and the synchronization word    and function
ADDW	R1, R2, #15
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,355 :: 		spi_write( 16, app_command_buf );
MOV	R1, R2
MOVS	R0, #16
BL	_spi_write+0
;driverrf4463pro.c,357 :: 		rf_init_freq();     // FUNCION DE FRECUENCIA ( REVISAR PARAMETROS )
BL	_rf_init_freq+0
;driverrf4463pro.c,358 :: 		}
L_end_vRF4463Init:
LDR	LR, [SP, #0]
ADD	SP, SP, #24
BX	LR
; end of _vRF4463Init
_vRF4463GPIO_SET:
;driverrf4463pro.c,364 :: 		void vRF4463GPIO_SET( unsigned char ucData ) {
; ucData start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
; ucData end address is: 0 (R0)
; ucData start address is: 0 (R0)
;driverrf4463pro.c,367 :: 		ucAppCommandBuf[0] = 0x13;     // gpio Set up
ADD	R2, SP, #4
MOVS	R1, #19
STRB	R1, [R2, #0]
;driverrf4463pro.c,369 :: 		switch ( ucData ) {
IT	AL
BAL	L_vRF4463GPIO_SET92
; ucData end address is: 0 (R0)
;driverrf4463pro.c,370 :: 		case tx_normal:
L_vRF4463GPIO_SET94:
;driverrf4463pro.c,371 :: 		case rx_normal: ucAppCommandBuf[ 1 ] = 3;                 // GPIO0=1
L_vRF4463GPIO_SET95:
ADD	R3, SP, #4
ADDS	R2, R3, #1
MOVS	R1, #3
STRB	R1, [R2, #0]
;driverrf4463pro.c,372 :: 		ucAppCommandBuf[ 2 ] = 2;                // GPIO1=0
ADDS	R2, R3, #2
MOVS	R1, #2
STRB	R1, [R2, #0]
;driverrf4463pro.c,373 :: 		break;
IT	AL
BAL	L_vRF4463GPIO_SET93
;driverrf4463pro.c,375 :: 		case tx_test:   ucAppCommandBuf[ 1 ] = 3;                 // GPIO0=1
L_vRF4463GPIO_SET96:
ADD	R3, SP, #4
ADDS	R2, R3, #1
MOVS	R1, #3
STRB	R1, [R2, #0]
;driverrf4463pro.c,376 :: 		ucAppCommandBuf[ 2 ] = 3;                // GPIO1=1
ADDS	R2, R3, #2
MOVS	R1, #3
STRB	R1, [R2, #0]
;driverrf4463pro.c,377 :: 		break;
IT	AL
BAL	L_vRF4463GPIO_SET93
;driverrf4463pro.c,379 :: 		case rx_test:   ucAppCommandBuf[ 1 ] = 2;                 // GPIO0=0
L_vRF4463GPIO_SET97:
ADD	R3, SP, #4
ADDS	R2, R3, #1
MOVS	R1, #2
STRB	R1, [R2, #0]
;driverrf4463pro.c,380 :: 		ucAppCommandBuf[ 2 ] = 20;                // GPIO1=RX DATA
ADDS	R2, R3, #2
MOVS	R1, #20
STRB	R1, [R2, #0]
;driverrf4463pro.c,381 :: 		break;
IT	AL
BAL	L_vRF4463GPIO_SET93
;driverrf4463pro.c,383 :: 		case rf_off:    ucAppCommandBuf[ 1 ] = 2;                 // GPIO0=0
L_vRF4463GPIO_SET98:
ADD	R3, SP, #4
ADDS	R2, R3, #1
MOVS	R1, #2
STRB	R1, [R2, #0]
;driverrf4463pro.c,384 :: 		ucAppCommandBuf[ 2 ] = 2;                // GPIO1=0
ADDS	R2, R3, #2
MOVS	R1, #2
STRB	R1, [R2, #0]
;driverrf4463pro.c,385 :: 		break;
IT	AL
BAL	L_vRF4463GPIO_SET93
;driverrf4463pro.c,386 :: 		}
L_vRF4463GPIO_SET92:
; ucData start address is: 0 (R0)
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463GPIO_SET94
CMP	R0, #1
IT	EQ
BEQ	L_vRF4463GPIO_SET95
CMP	R0, #2
IT	EQ
BEQ	L_vRF4463GPIO_SET96
CMP	R0, #3
IT	EQ
BEQ	L_vRF4463GPIO_SET97
CMP	R0, #4
IT	EQ
BEQ	L_vRF4463GPIO_SET98
; ucData end address is: 0 (R0)
L_vRF4463GPIO_SET93:
;driverrf4463pro.c,388 :: 		ucAppCommandBuf[ 3 ]  = 0x21;     //0x20;   //  gpio2, h = tx mode
ADD	R3, SP, #4
ADDS	R2, R3, #3
MOVS	R1, #33
STRB	R1, [R2, #0]
;driverrf4463pro.c,389 :: 		ucAppCommandBuf[ 4 ]  = 0x20;     // 0x14;  //   gpio3
ADDS	R2, R3, #4
MOVS	R1, #32
STRB	R1, [R2, #0]
;driverrf4463pro.c,390 :: 		ucAppCommandBuf[ 5 ]  = 0x27;     // nIRQ
ADDS	R2, R3, #5
MOVS	R1, #39
STRB	R1, [R2, #0]
;driverrf4463pro.c,391 :: 		ucAppCommandBuf[ 6 ]  = 0x0b;     // sdo
ADDS	R2, R3, #6
MOVS	R1, #11
STRB	R1, [R2, #0]
;driverrf4463pro.c,392 :: 		spi_write( 7, ucAppCommandBuf );
MOV	R1, R3
MOVS	R0, #7
BL	_spi_write+0
;driverrf4463pro.c,393 :: 		}
L_end_vRF4463GPIO_SET:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRF4463GPIO_SET
_vRF4463FifoReset:
;driverrf4463pro.c,398 :: 		void vRF4463FifoReset( void ) {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;driverrf4463pro.c,401 :: 		p[ 0 ] = FIFO_INFO;
ADD	R2, SP, #4
MOVS	R0, #21
STRB	R0, [R2, #0]
;driverrf4463pro.c,402 :: 		p[ 1 ] = 0x03;   // reset tx ,rx fifo
ADDS	R1, R2, #1
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,403 :: 		spi_write( 2, p );
MOV	R1, R2
MOVS	R0, #2
BL	_spi_write+0
;driverrf4463pro.c,404 :: 		}
L_end_vRF4463FifoReset:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vRF4463FifoReset
_vRF4463ClearInterrupts:
;driverrf4463pro.c,410 :: 		void vRF4463ClearInterrupts( void ) {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;driverrf4463pro.c,413 :: 		p[ 0 ] = GET_INT_STATUS;
ADD	R2, SP, #4
MOVS	R0, #32
STRB	R0, [R2, #0]
;driverrf4463pro.c,414 :: 		p[ 1 ] = 0;               // clr  PH pending
ADDS	R1, R2, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,415 :: 		p[ 2 ] = 0;               // clr modem_pending
ADDS	R1, R2, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,416 :: 		p[ 3 ] = 0;               // clr chip pending
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,417 :: 		spi_write( 4, p );
MOV	R1, R2
MOVS	R0, #4
BL	_spi_write+0
;driverrf4463pro.c,418 :: 		spi_read( 9, GET_INT_STATUS );
MOVS	R1, #32
MOVS	R0, #9
BL	_spi_read+0
;driverrf4463pro.c,419 :: 		}
L_end_vRF4463ClearInterrupts:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vRF4463ClearInterrupts
_vRF4463EnableRxInterrupt:
;driverrf4463pro.c,424 :: 		void vRF4463EnableRxInterrupt( void ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,427 :: 		p[ 0 ] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,428 :: 		p[ 1 ] = 0x01;            // 0x0100
ADDS	R1, R2, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,429 :: 		p[ 2 ] = 0x03;            // 3Parameters
ADDS	R1, R2, #2
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,430 :: 		p[ 3 ] = 0x00;            // 0100
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,431 :: 		p[ 4 ] = 0x03;            // ph, modem int
ADDS	R1, R2, #4
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,432 :: 		p[ 5 ] = 0x18;            // 0x10;   // Pack received int
ADDS	R1, R2, #5
MOVS	R0, #24
STRB	R0, [R1, #0]
;driverrf4463pro.c,433 :: 		p[ 6 ] = 0x00;            //preamble int, sync int setting
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,434 :: 		spi_write( 0x07, p );     // enable  packet receive interrupt
MOV	R1, R2
MOVS	R0, #7
BL	_spi_write+0
;driverrf4463pro.c,435 :: 		}
L_end_vRF4463EnableRxInterrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRF4463EnableRxInterrupt
_vRF4463EnableTxInterrupt:
;driverrf4463pro.c,440 :: 		void vRF4463EnableTxInterrupt( void ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,443 :: 		p[ 0 ] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,444 :: 		p[ 1 ] = 0x01;            // 0x0100
ADDS	R1, R2, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,445 :: 		p[ 2 ] = 0x02;            // 2Parameters
ADDS	R1, R2, #2
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,446 :: 		p[ 3 ] = 0x00;            // 0x0100
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,447 :: 		p[ 4 ] = 0x01;            // Ph  int
ADDS	R1, R2, #4
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,448 :: 		p[ 5 ] = 0x20;            //  enable  packet sent interrupt
ADDS	R1, R2, #5
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,449 :: 		spi_write( 0x06, p );     // enable  packet receive interrupt
MOV	R1, R2
MOVS	R0, #6
BL	_spi_write+0
;driverrf4463pro.c,450 :: 		}
L_end_vRF4463EnableTxInterrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRF4463EnableTxInterrupt
_vRF4463RfStandby:
;driverrf4463pro.c,455 :: 		void vRF4463RfStandby( void ) {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;driverrf4463pro.c,458 :: 		p[ 0 ] = CHANGE_STATE ;   // CHANGE_STATE Command
ADD	R2, SP, #4
MOVS	R0, #52
STRB	R0, [R2, #0]
;driverrf4463pro.c,459 :: 		p[ 1 ] = 0x01 ;           // sleep mode
ADDS	R1, R2, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,460 :: 		spi_write( 2, p );
MOV	R1, R2
MOVS	R0, #2
BL	_spi_write+0
;driverrf4463pro.c,461 :: 		}
L_end_vRF4463RfStandby:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vRF4463RfStandby
_vRF4463TxStart:
;driverrf4463pro.c,466 :: 		void vRF4463TxStart( void ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,469 :: 		p[ 0 ] = START_TX ;       // start Command
ADD	R2, SP, #4
MOVS	R0, #49
STRB	R0, [R2, #0]
;driverrf4463pro.c,470 :: 		p[ 1 ] = freq_channel;    // channel 0
ADDS	R1, R2, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,471 :: 		p[ 2 ] = 0x30;            // Back after launch Readymode, Do not retransmit, launch immediately
ADDS	R1, R2, #2
MOVS	R0, #48
STRB	R0, [R1, #0]
;driverrf4463pro.c,472 :: 		p[ 3 ] = 0;
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,473 :: 		p[ 4 ] = 0;               //payload_length; // Total to transmit 10 bytes
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,474 :: 		spi_write( 5, p );
MOV	R1, R2
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,475 :: 		}
L_end_vRF4463TxStart:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRF4463TxStart
_vRF4463RxStart:
;driverrf4463pro.c,480 :: 		void vRF4463RxStart( void ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,483 :: 		p[ 0 ] = START_RX ;       // start Command
ADD	R2, SP, #4
MOVS	R0, #50
STRB	R0, [R2, #0]
;driverrf4463pro.c,484 :: 		p[ 1 ] = freq_channel;    // channel 0
ADDS	R1, R2, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,485 :: 		p[ 2 ] = 0x00;            // Enter receiving mode immediately
ADDS	R1, R2, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,486 :: 		p[ 3 ] = 0;
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,487 :: 		p[ 4 ] = 0;               // payload_length; // Total to receive 10 bytes
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,488 :: 		p[ 5 ] = 0;               // unchanged after preamble timeout
ADDS	R1, R2, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,491 :: 		p[ 6 ] = 0x08;
ADDS	R1, R2, #6
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,492 :: 		p[ 7 ] = 0x08;
ADDS	R1, R2, #7
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,493 :: 		spi_write( 8, p );
MOV	R1, R2
MOVS	R0, #8
BL	_spi_write+0
;driverrf4463pro.c,494 :: 		}
L_end_vRF4463RxStart:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRF4463RxStart
_vRF4463RxStartTest:
;driverrf4463pro.c,499 :: 		void vRF4463RxStartTest( void ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,502 :: 		LED_GREEN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;driverrf4463pro.c,504 :: 		p[ 0 ] = START_RX;        // start Command
ADD	R2, SP, #4
MOVS	R0, #50
STRB	R0, [R2, #0]
;driverrf4463pro.c,505 :: 		p[ 1 ] = freq_channel;    // channel 0
ADDS	R1, R2, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,506 :: 		p[ 2 ] = 0x00;            // Enter receiving mode immediately
ADDS	R1, R2, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,507 :: 		p[ 3 ] = 0;
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,509 :: 		p[ 4 ] = 0;
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,510 :: 		p[ 5 ] = 0;               // unchanged after preamble timeout
ADDS	R1, R2, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,513 :: 		p[ 6 ] = 0x08;
ADDS	R1, R2, #6
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,514 :: 		p[ 7 ] = 0x08;
ADDS	R1, R2, #7
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,515 :: 		spi_write( 8, p );
MOV	R1, R2
MOVS	R0, #8
BL	_spi_write+0
;driverrf4463pro.c,516 :: 		}
L_end_vRF4463RxStartTest:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRF4463RxStartTest
_vRF4463RxInit:
;driverrf4463pro.c,521 :: 		void vRF4463RxInit( void ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;driverrf4463pro.c,522 :: 		Flag.is_tx = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;driverrf4463pro.c,523 :: 		vRF4463FifoReset();           // fifo_reset();  // Buffer empty
BL	_vRF4463FifoReset+0
;driverrf4463pro.c,524 :: 		vRF4463EnableRxInterrupt();   // enable_rx_interrupt();
BL	_vRF4463EnableRxInterrupt+0
;driverrf4463pro.c,525 :: 		vRF4463ClearInterrupts();      // clr_interrupt();  // Clear interrupt factor
BL	_vRF4463ClearInterrupts+0
;driverrf4463pro.c,527 :: 		if ( mode == rx_test_mode ) {
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BNE	L_vRF4463RxInit99
;driverrf4463pro.c,528 :: 		vRF4463RxStartTest();      // rx_start_test();
BL	_vRF4463RxStartTest+0
;driverrf4463pro.c,529 :: 		}
IT	AL
BAL	L_vRF4463RxInit100
L_vRF4463RxInit99:
;driverrf4463pro.c,531 :: 		vRF4463RxStart();        // rx_start();    // Enter receiving mode, after receiving data, return to Readymode
BL	_vRF4463RxStart+0
;driverrf4463pro.c,532 :: 		}
L_vRF4463RxInit100:
;driverrf4463pro.c,533 :: 		}
L_end_vRF4463RxInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vRF4463RxInit
_vRF4463TxData:
;driverrf4463pro.c,538 :: 		void vRF4463TxData( void ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;driverrf4463pro.c,541 :: 		Flag.is_tx = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;driverrf4463pro.c,542 :: 		LED_RED ^= 1;
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_LX	[R0, ByteOffset(GPIOC_ODRbits+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;driverrf4463pro.c,543 :: 		vRF4463FifoReset();            // fifo_reset();  // Buffer empty
BL	_vRF4463FifoReset+0
;driverrf4463pro.c,544 :: 		spi_write_fifo();              // Fill the buffer with data
BL	_spi_write_fifo+0
;driverrf4463pro.c,545 :: 		vRF4463EnableTxInterrupt();    // enable_tx_interrupt();
BL	_vRF4463EnableTxInterrupt+0
;driverrf4463pro.c,546 :: 		vRF4463ClearInterrupts();       // clr_interrupt();  // Clear interrupt factor
BL	_vRF4463ClearInterrupts+0
;driverrf4463pro.c,547 :: 		vRF4463TxStart();              // tx_start();    // Enter launch mode, start launch
BL	_vRF4463TxStart+0
;driverrf4463pro.c,548 :: 		rf_timeout = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_rf_timeout+0)
MOVT	R0, #hi_addr(_rf_timeout+0)
STRH	R1, [R0, #0]
;driverrf4463pro.c,549 :: 		Flag.rf_reach_timeout = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;driverrf4463pro.c,552 :: 		while ( nIRQ ) {
L_vRF4463TxData101:
MOVW	R0, #lo_addr(GPIOC_IDRbits+0)
MOVT	R0, #hi_addr(GPIOC_IDRbits+0)
_LX	[R0, ByteOffset(GPIOC_IDRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463TxData102
;driverrf4463pro.c,555 :: 		if ( Flag.rf_reach_timeout ) {
MOVW	R1, #lo_addr(_Flag+0)
MOVT	R1, #hi_addr(_Flag+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463TxData103
;driverrf4463pro.c,556 :: 		VRF4463SDNReset();
BL	_VRF4463SDNReset+0
;driverrf4463pro.c,557 :: 		vRF4463Init();        //SI4463_init();  // RF Module initialization
BL	_vRF4463Init+0
;driverrf4463pro.c,558 :: 		break;                // Forced out
IT	AL
BAL	L_vRF4463TxData102
;driverrf4463pro.c,559 :: 		}
L_vRF4463TxData103:
;driverrf4463pro.c,560 :: 		}
IT	AL
BAL	L_vRF4463TxData101
L_vRF4463TxData102:
;driverrf4463pro.c,562 :: 		tx_cnt++;
MOVW	R1, #lo_addr(_tx_cnt+0)
MOVT	R1, #hi_addr(_tx_cnt+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;driverrf4463pro.c,564 :: 		vRF4463RxInit();          // rx_init();                //rf After the transmission is completed, enter the receiving mode
BL	_vRF4463RxInit+0
;driverrf4463pro.c,565 :: 		}
L_end_vRF4463TxData:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vRF4463TxData
_vRF4463TxCont:
;driverrf4463pro.c,570 :: 		void vRF4463TxCont( void ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;driverrf4463pro.c,573 :: 		LED_RED = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;driverrf4463pro.c,574 :: 		fifo_reset();  // Buffer empty
BL	_fifo_reset+0
;driverrf4463pro.c,575 :: 		spi_write_fifo();  // Fill the buffer with data
BL	_spi_write_fifo+0
;driverrf4463pro.c,576 :: 		enable_tx_interrupt();
BL	_enable_tx_interrupt+0
;driverrf4463pro.c,577 :: 		clr_interrupt();  // Clear interrupt factor
BL	_clr_interrupt+0
;driverrf4463pro.c,578 :: 		tx_start();    // Enter launch mode, start launch
BL	_tx_start+0
;driverrf4463pro.c,579 :: 		rf_timeout = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_rf_timeout+0)
MOVT	R0, #hi_addr(_rf_timeout+0)
STRH	R1, [R0, #0]
;driverrf4463pro.c,580 :: 		Flag.rf_reach_timeout = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;driverrf4463pro.c,583 :: 		while( nIRQ ) {
L_vRF4463TxCont104:
MOVW	R0, #lo_addr(GPIOC_IDRbits+0)
MOVT	R0, #hi_addr(GPIOC_IDRbits+0)
_LX	[R0, ByteOffset(GPIOC_IDRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463TxCont105
;driverrf4463pro.c,591 :: 		}
IT	AL
BAL	L_vRF4463TxCont104
L_vRF4463TxCont105:
;driverrf4463pro.c,592 :: 		}
L_end_vRF4463TxCont:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vRF4463TxCont
_rf_init_freq:
;driverrf4463pro.c,597 :: 		void rf_init_freq ( void ) {
SUB	SP, SP, #24
STR	LR, [SP, #0]
;driverrf4463pro.c,603 :: 		ulFrequency = ( freq3 * 100) + ( freq2 * 10) + freq1;
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
; ulFrequency start address is: 8 (R2)
SXTH	R2, R2
;driverrf4463pro.c,604 :: 		ulFrequency = ( ulFrequency * 10000) + 5000;
MOVW	R0, #10000
MUL	R1, R2, R0
; ulFrequency end address is: 8 (R2)
MOVW	R0, #5000
ADDS	R1, R1, R0
; ulFrequency start address is: 8 (R2)
MOV	R2, R1
;driverrf4463pro.c,607 :: 		if ( ulFrequency >= 7600000 ) {
MOVW	R0, #63360
MOVT	R0, #115
CMP	R1, R0
IT	CC
BCC	L_rf_init_freq106
; ulFrequency end address is: 8 (R2)
;driverrf4463pro.c,609 :: 		ucBAND = 0;
; ucBAND start address is: 12 (R3)
MOVS	R3, #0
;driverrf4463pro.c,611 :: 		}
; ucBAND end address is: 12 (R3)
IT	AL
BAL	L_rf_init_freq107
L_rf_init_freq106:
;driverrf4463pro.c,614 :: 		else if ( ulFrequency >= 5460000 ) {
; ulFrequency start address is: 8 (R2)
MOVW	R0, #20512
MOVT	R0, #83
CMP	R2, R0
IT	CC
BCC	L_rf_init_freq108
; ulFrequency end address is: 8 (R2)
;driverrf4463pro.c,616 :: 		ucBAND   = 1;
; ucBAND start address is: 0 (R0)
MOVS	R0, #1
;driverrf4463pro.c,618 :: 		}
UXTB	R3, R0
; ucBAND end address is: 0 (R0)
IT	AL
BAL	L_rf_init_freq109
L_rf_init_freq108:
;driverrf4463pro.c,621 :: 		else if ( ulFrequency >= 3850000 ) {
; ulFrequency start address is: 8 (R2)
MOVW	R0, #48912
MOVT	R0, #58
CMP	R2, R0
IT	CC
BCC	L_rf_init_freq110
; ulFrequency end address is: 8 (R2)
;driverrf4463pro.c,623 :: 		ucBAND   = 2;
; ucBAND start address is: 0 (R0)
MOVS	R0, #2
;driverrf4463pro.c,625 :: 		}
; ucBAND end address is: 0 (R0)
IT	AL
BAL	L_rf_init_freq111
L_rf_init_freq110:
;driverrf4463pro.c,628 :: 		else if ( ulFrequency >= 2730000 ) {
; ulFrequency start address is: 8 (R2)
MOVW	R0, #43024
MOVT	R0, #41
CMP	R2, R0
IT	CC
BCC	L_rf_init_freq112
; ulFrequency end address is: 8 (R2)
;driverrf4463pro.c,630 :: 		ucBAND   = 3;
; ucBAND start address is: 0 (R0)
MOVS	R0, #3
;driverrf4463pro.c,632 :: 		}
; ucBAND end address is: 0 (R0)
IT	AL
BAL	L_rf_init_freq113
L_rf_init_freq112:
;driverrf4463pro.c,635 :: 		else if ( ulFrequency >= 1940000 ) {
; ulFrequency start address is: 8 (R2)
MOVW	R0, #39456
MOVT	R0, #29
CMP	R2, R0
IT	CC
BCC	L_rf_init_freq114
; ulFrequency end address is: 8 (R2)
;driverrf4463pro.c,637 :: 		ucBAND   = 4;
; ucBAND start address is: 0 (R0)
MOVS	R0, #4
;driverrf4463pro.c,639 :: 		}
; ucBAND end address is: 0 (R0)
IT	AL
BAL	L_rf_init_freq115
L_rf_init_freq114:
;driverrf4463pro.c,644 :: 		ucBAND   = 5;
; ucBAND start address is: 0 (R0)
MOVS	R0, #5
; ucBAND end address is: 0 (R0)
;driverrf4463pro.c,646 :: 		}
L_rf_init_freq115:
; ucBAND start address is: 0 (R0)
; ucBAND end address is: 0 (R0)
L_rf_init_freq113:
; ucBAND start address is: 0 (R0)
; ucBAND end address is: 0 (R0)
L_rf_init_freq111:
; ucBAND start address is: 0 (R0)
UXTB	R3, R0
; ucBAND end address is: 0 (R0)
L_rf_init_freq109:
; ucBAND start address is: 12 (R3)
; ucBAND end address is: 12 (R3)
L_rf_init_freq107:
;driverrf4463pro.c,663 :: 		app_command_buf[ 0 ] = 0x11;           // SET property    MODEM_CLKGEN_BAND
; ucBAND start address is: 12 (R3)
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,664 :: 		app_command_buf[ 1 ] = 0x20;           // Group  // 0x2051
ADDS	R1, R2, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,665 :: 		app_command_buf[ 2 ] = 0x01;           // Num Arguments // Total 1 Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,666 :: 		app_command_buf[ 3 ] = 0x51;           // Number  // 0x2051
ADDS	R1, R2, #3
MOVS	R0, #81
STRB	R0, [R1, #0]
;driverrf4463pro.c,667 :: 		app_command_buf[ 4 ] = 0x08 | ucBAND;  // Argumento  //  high performance mode , clk outpu = osc /4
ADDS	R1, R2, #4
ORR	R0, R3, #8
; ucBAND end address is: 12 (R3)
STRB	R0, [R1, #0]
;driverrf4463pro.c,668 :: 		spi_write( 5, app_command_buf );
MOV	R1, R2
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,670 :: 		app_command_buf[ 0 ]  = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,671 :: 		app_command_buf[ 1 ]  = 0x40;    // 0x4000         FREQ_CONTROL_INTE
ADDS	R1, R2, #1
MOVS	R0, #64
STRB	R0, [R1, #0]
;driverrf4463pro.c,672 :: 		app_command_buf[ 2 ]  = 0x08;    // Total 8 Parameters
ADDS	R1, R2, #2
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,673 :: 		app_command_buf[ 3 ]  = 0x00;   // 0x4000
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,674 :: 		app_command_buf[ 4 ]  = 0x3B;  //ucINTE;   //  default value
ADDS	R1, R2, #4
MOVS	R0, #59
STRB	R0, [R1, #0]
;driverrf4463pro.c,675 :: 		app_command_buf[ 5 ]  = 0x09;  //ucFRAC_2;   //  defaul value
ADDS	R1, R2, #5
MOVS	R0, #9
STRB	R0, [R1, #0]
;driverrf4463pro.c,676 :: 		app_command_buf[ 6 ]  = 0x55;  //ucFRAC_1;   //  default value
ADDS	R1, R2, #6
MOVS	R0, #85
STRB	R0, [R1, #0]
;driverrf4463pro.c,677 :: 		app_command_buf[ 7 ]  = 0x55;  //ucFRAC_0;   // frac ,from WDS
ADDS	R1, R2, #7
MOVS	R0, #85
STRB	R0, [R1, #0]
;driverrf4463pro.c,678 :: 		app_command_buf[ 8 ]  = step_500K_step1;   // channel step1  from wds  // al parecer aquí esta el ancho del canal
ADDW	R1, R2, #8
MOVS	R0, #136
STRB	R0, [R1, #0]
;driverrf4463pro.c,679 :: 		app_command_buf[ 9 ]  = step_500K_step0;   // channel step0  from wds
ADDW	R1, R2, #9
MOVS	R0, #137
STRB	R0, [R1, #0]
;driverrf4463pro.c,680 :: 		app_command_buf[ 10 ] = 0x20;  //  from wds Without this Values
ADDW	R1, R2, #10
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,681 :: 		app_command_buf[ 11 ] = 0xFF;//ucVCO;    // from wds Without this Values
ADDW	R1, R2, #11
MOVS	R0, #255
STRB	R0, [R1, #0]
;driverrf4463pro.c,682 :: 		spi_write( 12, app_command_buf );
MOV	R1, R2
MOVS	R0, #12
BL	_spi_write+0
;driverrf4463pro.c,683 :: 		}
L_end_rf_init_freq:
LDR	LR, [SP, #0]
ADD	SP, SP, #24
BX	LR
; end of _rf_init_freq
_ucRf4463SPIByte:
;driverrf4463pro.c,703 :: 		unsigned char ucRf4463SPIByte( unsigned char ucData ) {
; ucData start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; ucData end address is: 0 (R0)
; ucData start address is: 0 (R0)
;driverrf4463pro.c,706 :: 		ucSPI2ByteReceived = 0;
MOVS	R2, #0
MOVW	R1, #lo_addr(_ucSPI2ByteReceived+0)
MOVT	R1, #hi_addr(_ucSPI2ByteReceived+0)
STRB	R2, [R1, #0]
;driverrf4463pro.c,708 :: 		SPI2_Read ( ucData );
; ucData end address is: 0 (R0)
BL	_SPI2_Read+0
;driverrf4463pro.c,710 :: 		while ( SPI2_SRbits.RXNE );                // espera la recepcion
L_ucRf4463SPIByte116:
MOVW	R1, #lo_addr(SPI2_SRbits+0)
MOVT	R1, #hi_addr(SPI2_SRbits+0)
_LX	[R1, ByteOffset(SPI2_SRbits+0)]
CMP	R1, #0
IT	EQ
BEQ	L_ucRf4463SPIByte117
IT	AL
BAL	L_ucRf4463SPIByte116
L_ucRf4463SPIByte117:
;driverrf4463pro.c,712 :: 		ucSPI2ByteReceived = ( unsigned char ) SPI2_DR;
MOVW	R1, #lo_addr(SPI2_DR+0)
MOVT	R1, #hi_addr(SPI2_DR+0)
LDR	R2, [R1, #0]
MOVW	R1, #lo_addr(_ucSPI2ByteReceived+0)
MOVT	R1, #hi_addr(_ucSPI2ByteReceived+0)
STRB	R2, [R1, #0]
;driverrf4463pro.c,730 :: 		return ( ucSPI2ByteReceived );
MOVW	R1, #lo_addr(_ucSPI2ByteReceived+0)
MOVT	R1, #hi_addr(_ucSPI2ByteReceived+0)
LDRB	R0, [R1, #0]
;driverrf4463pro.c,731 :: 		}
L_end_ucRf4463SPIByte:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ucRf4463SPIByte
_spi_write:
;driverrf4463pro.c,736 :: 		void spi_write( unsigned char tx_length, unsigned char *p ) {
; i start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,739 :: 		i = 0;
;driverrf4463pro.c,736 :: 		void spi_write( unsigned char tx_length, unsigned char *p ) {
STRB	R0, [SP, #4]
;driverrf4463pro.c,739 :: 		i = 0;
;driverrf4463pro.c,736 :: 		void spi_write( unsigned char tx_length, unsigned char *p ) {
STR	R1, [SP, #8]
; i end address is: 0 (R0)
;driverrf4463pro.c,739 :: 		i = 0;
; i start address is: 0 (R0)
MOVS	R0, #0
; i end address is: 0 (R0)
;driverrf4463pro.c,740 :: 		while ( i != 0xFF ) {
L_spi_write118:
; i start address is: 0 (R0)
CMP	R0, #255
IT	EQ
BEQ	L_spi_write119
; i end address is: 0 (R0)
;driverrf4463pro.c,741 :: 		i = check_cts();
BL	_check_cts+0
; i start address is: 0 (R0)
;driverrf4463pro.c,742 :: 		}
; i end address is: 0 (R0)
IT	AL
BAL	L_spi_write118
L_spi_write119:
;driverrf4463pro.c,745 :: 		nSEL = 0;                              // habilita escritura
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,747 :: 		for ( i = 0; i < tx_length; i++ ) {
; i start address is: 24 (R6)
MOVS	R6, #0
; i end address is: 24 (R6)
UXTB	R4, R6
L_spi_write120:
; i start address is: 16 (R4)
LDRB	R2, [SP, #4]
CMP	R4, R2
IT	CS
BCS	L_spi_write121
;driverrf4463pro.c,748 :: 		j = *( p + i );
LDR	R2, [SP, #8]
ADDS	R2, R2, R4
;driverrf4463pro.c,749 :: 		ucRf4463SPIByte( j );
LDRB	R0, [R2, #0]
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,747 :: 		for ( i = 0; i < tx_length; i++ ) {
ADDS	R2, R4, #1
; i end address is: 16 (R4)
; i start address is: 24 (R6)
UXTB	R6, R2
;driverrf4463pro.c,750 :: 		}
UXTB	R4, R6
; i end address is: 24 (R6)
IT	AL
BAL	L_spi_write120
L_spi_write121:
;driverrf4463pro.c,752 :: 		nSEL = 1;                              // desabilita escritura
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,753 :: 		}
L_end_spi_write:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _spi_write
_check_cts:
;driverrf4463pro.c,758 :: 		unsigned char check_cts( void ) {           // This Command follows the Command and reads the response
SUB	SP, SP, #4
STR	LR, [SP, #0]
;driverrf4463pro.c,761 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,763 :: 		nSEL = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,764 :: 		ucRf4463SPIByte( 0x44 );
MOVS	R0, #68
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,765 :: 		i = ucRf4463SPIByte(0);
MOVS	R0, #0
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,766 :: 		nSEL = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODRbits+0)
MOVT	R1, #hi_addr(GPIOB_ODRbits+0)
_SX	[R1, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,767 :: 		return ( i );
;driverrf4463pro.c,768 :: 		}
L_end_check_cts:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _check_cts
_spi_read:
;driverrf4463pro.c,773 :: 		void spi_read( unsigned char data_length, unsigned char api_command ) {
; api_command start address is: 4 (R1)
; data_length start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
; api_command end address is: 4 (R1)
; data_length end address is: 0 (R0)
; data_length start address is: 0 (R0)
; api_command start address is: 4 (R1)
;driverrf4463pro.c,777 :: 		p[ 0 ] = api_command;
ADD	R2, SP, #4
STRB	R1, [R2, #0]
; api_command end address is: 4 (R1)
;driverrf4463pro.c,778 :: 		i = 0;
; i start address is: 4 (R1)
MOVS	R1, #0
; data_length end address is: 0 (R0)
; i end address is: 4 (R1)
UXTB	R5, R0
UXTB	R0, R1
;driverrf4463pro.c,779 :: 		while ( i != 0xFF ) {
L_spi_read123:
; i start address is: 0 (R0)
; data_length start address is: 20 (R5)
CMP	R0, #255
IT	EQ
BEQ	L_spi_read124
; i end address is: 0 (R0)
;driverrf4463pro.c,780 :: 		i = check_cts();                // Check if you can send Command
BL	_check_cts+0
; i start address is: 0 (R0)
;driverrf4463pro.c,781 :: 		}
; i end address is: 0 (R0)
IT	AL
BAL	L_spi_read123
L_spi_read124:
;driverrf4463pro.c,783 :: 		spi_write( 1, p );    // Send Command
ADD	R2, SP, #4
MOV	R1, R2
MOVS	R0, #1
BL	_spi_write+0
;driverrf4463pro.c,785 :: 		i = 0;
; i start address is: 0 (R0)
MOVS	R0, #0
; data_length end address is: 20 (R5)
; i end address is: 0 (R0)
UXTB	R4, R5
;driverrf4463pro.c,786 :: 		while ( i != 0xFF ) {
L_spi_read125:
; i start address is: 0 (R0)
; data_length start address is: 16 (R4)
CMP	R0, #255
IT	EQ
BEQ	L_spi_read126
; i end address is: 0 (R0)
;driverrf4463pro.c,787 :: 		i = check_cts();        //Check whether the data can be read
BL	_check_cts+0
; i start address is: 0 (R0)
;driverrf4463pro.c,788 :: 		}
; i end address is: 0 (R0)
IT	AL
BAL	L_spi_read125
L_spi_read126:
;driverrf4463pro.c,790 :: 		nSEL = 1;
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,792 :: 		nSEL = 0;
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,793 :: 		ucRf4463SPIByte( 0x44 );
MOVS	R0, #68
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,794 :: 		for ( i = 0; i < data_length; i++ ) {        // Read data
; i start address is: 20 (R5)
MOVS	R5, #0
; data_length end address is: 16 (R4)
; i end address is: 20 (R5)
L_spi_read127:
; i start address is: 20 (R5)
; data_length start address is: 16 (R4)
CMP	R5, R4
IT	CS
BCS	L_spi_read128
;driverrf4463pro.c,795 :: 		spi_read_buf[ i ] = ucRf4463SPIByte( 0xFF );
MOVW	R2, #lo_addr(_spi_read_buf+0)
MOVT	R2, #hi_addr(_spi_read_buf+0)
ADDS	R2, R2, R5
STR	R2, [SP, #8]
MOVS	R0, #255
BL	_ucRf4463SPIByte+0
LDR	R2, [SP, #8]
STRB	R0, [R2, #0]
;driverrf4463pro.c,794 :: 		for ( i = 0; i < data_length; i++ ) {        // Read data
ADDS	R5, R5, #1
UXTB	R5, R5
;driverrf4463pro.c,796 :: 		}
; data_length end address is: 16 (R4)
; i end address is: 20 (R5)
IT	AL
BAL	L_spi_read127
L_spi_read128:
;driverrf4463pro.c,797 :: 		nSEL = 1;
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,798 :: 		}
L_end_spi_read:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _spi_read
_spi_fast_read:
;driverrf4463pro.c,803 :: 		void spi_fast_read( unsigned char api_command ) {
; api_command start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
; api_command end address is: 0 (R0)
; api_command start address is: 0 (R0)
;driverrf4463pro.c,806 :: 		p[0] = api_command;
ADD	R1, SP, #4
STRB	R0, [R1, #0]
;driverrf4463pro.c,807 :: 		i = 0;
; i start address is: 4 (R1)
MOVS	R1, #0
; api_command end address is: 0 (R0)
; i end address is: 4 (R1)
UXTB	R4, R0
;driverrf4463pro.c,808 :: 		while ( i != 0xFF ) {
L_spi_fast_read130:
; i start address is: 4 (R1)
; api_command start address is: 16 (R4)
CMP	R1, #255
IT	EQ
BEQ	L_spi_fast_read131
; i end address is: 4 (R1)
;driverrf4463pro.c,809 :: 		i = check_cts();                // Check if you can send Command
BL	_check_cts+0
; i start address is: 4 (R1)
UXTB	R1, R0
;driverrf4463pro.c,810 :: 		}
; i end address is: 4 (R1)
IT	AL
BAL	L_spi_fast_read130
L_spi_fast_read131:
;driverrf4463pro.c,812 :: 		nSEL = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODRbits+0)
MOVT	R1, #hi_addr(GPIOB_ODRbits+0)
_SX	[R1, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,814 :: 		nSEL = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODRbits+0)
MOVT	R1, #hi_addr(GPIOB_ODRbits+0)
_SX	[R1, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,815 :: 		ucRf4463SPIByte( api_command );    // Send Command
UXTB	R0, R4
; api_command end address is: 16 (R4)
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,816 :: 		for ( i = 0; i < 4; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #0
; i end address is: 16 (R4)
L_spi_fast_read132:
; i start address is: 16 (R4)
CMP	R4, #4
IT	CS
BCS	L_spi_fast_read133
;driverrf4463pro.c,817 :: 		spi_read_buf[ i ] = ucRf4463SPIByte( 0xFF );   // Read out all the 4 registers Value of
MOVW	R1, #lo_addr(_spi_read_buf+0)
MOVT	R1, #hi_addr(_spi_read_buf+0)
ADDS	R1, R1, R4
STR	R1, [SP, #8]
MOVS	R0, #255
BL	_ucRf4463SPIByte+0
LDR	R1, [SP, #8]
STRB	R0, [R1, #0]
;driverrf4463pro.c,816 :: 		for ( i = 0; i < 4; i++ ) {
ADDS	R4, R4, #1
UXTB	R4, R4
;driverrf4463pro.c,818 :: 		}
; i end address is: 16 (R4)
IT	AL
BAL	L_spi_fast_read132
L_spi_fast_read133:
;driverrf4463pro.c,819 :: 		nSEL = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODRbits+0)
MOVT	R1, #hi_addr(GPIOB_ODRbits+0)
_SX	[R1, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,820 :: 		}
L_end_spi_fast_read:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _spi_fast_read
_spi_write_fifo:
;driverrf4463pro.c,825 :: 		void spi_write_fifo( void ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;driverrf4463pro.c,828 :: 		i = 0;
; i start address is: 0 (R0)
MOVS	R0, #0
; i end address is: 0 (R0)
;driverrf4463pro.c,829 :: 		while ( i != 0xFF ) {
L_spi_write_fifo135:
; i start address is: 0 (R0)
CMP	R0, #255
IT	EQ
BEQ	L_spi_write_fifo136
; i end address is: 0 (R0)
;driverrf4463pro.c,830 :: 		i = check_cts();                // Check if you can send Command
BL	_check_cts+0
; i start address is: 0 (R0)
;driverrf4463pro.c,831 :: 		}
; i end address is: 0 (R0)
IT	AL
BAL	L_spi_write_fifo135
L_spi_write_fifo136:
;driverrf4463pro.c,833 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,835 :: 		nSEL = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,836 :: 		ucRf4463SPIByte( WRITE_TX_FIFO );
MOVS	R0, #102
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,838 :: 		if ( mode == tx_test_mode) {
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_spi_write_fifo137
;driverrf4463pro.c,839 :: 		for (i = 0; i < payload_length; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #0
; i end address is: 16 (R4)
L_spi_write_fifo138:
; i start address is: 16 (R4)
CMP	R4, #14
IT	CS
BCS	L_spi_write_fifo139
;driverrf4463pro.c,840 :: 		ucRf4463SPIByte( tx_test_aa_data[ i ] );   // Send 10 test data
MOVW	R0, #lo_addr(_tx_test_aa_data+0)
MOVT	R0, #hi_addr(_tx_test_aa_data+0)
ADDS	R0, R0, R4
LDRB	R0, [R0, #0]
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,839 :: 		for (i = 0; i < payload_length; i++ ) {
ADDS	R4, R4, #1
UXTB	R4, R4
;driverrf4463pro.c,841 :: 		}
; i end address is: 16 (R4)
IT	AL
BAL	L_spi_write_fifo138
L_spi_write_fifo139:
;driverrf4463pro.c,842 :: 		}
IT	AL
BAL	L_spi_write_fifo141
L_spi_write_fifo137:
;driverrf4463pro.c,844 :: 		for ( i = 0; i < payload_length; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #0
; i end address is: 16 (R4)
L_spi_write_fifo142:
; i start address is: 16 (R4)
CMP	R4, #14
IT	CS
BCS	L_spi_write_fifo143
;driverrf4463pro.c,845 :: 		ucRf4463SPIByte( tx_ph_data[ i ] );
MOVW	R0, #lo_addr(_tx_ph_data+0)
MOVT	R0, #hi_addr(_tx_ph_data+0)
ADDS	R0, R0, R4
LDRB	R0, [R0, #0]
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,844 :: 		for ( i = 0; i < payload_length; i++ ) {
ADDS	R4, R4, #1
UXTB	R4, R4
;driverrf4463pro.c,846 :: 		}
; i end address is: 16 (R4)
IT	AL
BAL	L_spi_write_fifo142
L_spi_write_fifo143:
;driverrf4463pro.c,847 :: 		}
L_spi_write_fifo141:
;driverrf4463pro.c,848 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,849 :: 		}
L_end_spi_write_fifo:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _spi_write_fifo
_spi_read_fifo:
;driverrf4463pro.c,854 :: 		void spi_read_fifo( void ) {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;driverrf4463pro.c,857 :: 		i = 0;
; i start address is: 0 (R0)
MOVS	R0, #0
; i end address is: 0 (R0)
;driverrf4463pro.c,858 :: 		while ( i != 0xFF ) {
L_spi_read_fifo145:
; i start address is: 0 (R0)
CMP	R0, #255
IT	EQ
BEQ	L_spi_read_fifo146
; i end address is: 0 (R0)
;driverrf4463pro.c,859 :: 		i = check_cts();                   // Check if you can send Command
BL	_check_cts+0
; i start address is: 0 (R0)
;driverrf4463pro.c,860 :: 		}
; i end address is: 0 (R0)
IT	AL
BAL	L_spi_read_fifo145
L_spi_read_fifo146:
;driverrf4463pro.c,862 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,864 :: 		nSEL = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,865 :: 		ucRf4463SPIByte( READ_RX_FIFO );
MOVS	R0, #119
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,866 :: 		for ( i = 0; i < payload_length; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #0
; i end address is: 16 (R4)
L_spi_read_fifo147:
; i start address is: 16 (R4)
CMP	R4, #14
IT	CS
BCS	L_spi_read_fifo148
;driverrf4463pro.c,867 :: 		rx_buf[ i ] = ucRf4463SPIByte( 0xFF );      // Receive 10 test data
MOVW	R0, #lo_addr(_rx_buf+0)
MOVT	R0, #hi_addr(_rx_buf+0)
ADDS	R0, R0, R4
STR	R0, [SP, #4]
MOVS	R0, #255
BL	_ucRf4463SPIByte+0
LDR	R1, [SP, #4]
STRB	R0, [R1, #0]
;driverrf4463pro.c,866 :: 		for ( i = 0; i < payload_length; i++ ) {
ADDS	R4, R4, #1
UXTB	R4, R4
;driverrf4463pro.c,868 :: 		}
; i end address is: 16 (R4)
IT	AL
BAL	L_spi_read_fifo147
L_spi_read_fifo148:
;driverrf4463pro.c,869 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,870 :: 		}
L_end_spi_read_fifo:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _spi_read_fifo
_VRF4463SDNReset:
;driverrf4463pro.c,875 :: 		void VRF4463SDNReset( void ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;driverrf4463pro.c,878 :: 		SDN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,879 :: 		Delay_ms( 2 );        // delay_1ms( 2 );        // RF Module reset  DELAY
MOVW	R7, #23999
MOVT	R7, #0
NOP
NOP
L_VRF4463SDNReset150:
SUBS	R7, R7, #1
BNE	L_VRF4463SDNReset150
NOP
NOP
NOP
;driverrf4463pro.c,880 :: 		SDN = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,881 :: 		Delay_ms( 10 );       // delay_1ms( 10 );        // Delay 10ms for RF module to enter working state
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_VRF4463SDNReset152:
SUBS	R7, R7, #1
BNE	L_VRF4463SDNReset152
NOP
NOP
NOP
;driverrf4463pro.c,883 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,885 :: 		nSEL = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,886 :: 		for ( i = 0; i < 7; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #0
; i end address is: 16 (R4)
L_VRF4463SDNReset154:
; i start address is: 16 (R4)
CMP	R4, #7
IT	CS
BCS	L_VRF4463SDNReset155
;driverrf4463pro.c,887 :: 		ucRf4463SPIByte( RF_POWER_UP_data[ i ] );   // send power up Command
MOVW	R0, #lo_addr(_RF_POWER_UP_data+0)
MOVT	R0, #hi_addr(_RF_POWER_UP_data+0)
ADDS	R0, R0, R4
LDRB	R0, [R0, #0]
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,886 :: 		for ( i = 0; i < 7; i++ ) {
ADDS	R4, R4, #1
UXTB	R4, R4
;driverrf4463pro.c,888 :: 		}
; i end address is: 16 (R4)
IT	AL
BAL	L_VRF4463SDNReset154
L_VRF4463SDNReset155:
;driverrf4463pro.c,889 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,891 :: 		Delay_ms( 20 );               //delay_1ms( 20 );        // Delay 20ms RF module enters working state, but CTS still needs to be judged later, this delay can be removed
MOVW	R7, #43391
MOVT	R7, #3
NOP
NOP
L_VRF4463SDNReset157:
SUBS	R7, R7, #1
BNE	L_VRF4463SDNReset157
NOP
NOP
NOP
;driverrf4463pro.c,892 :: 		}
L_end_VRF4463SDNReset:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _VRF4463SDNReset
_ucASCIIToByte:
;utils.c,41 :: 		unsigned char ucASCIIToByte( unsigned char * pcASCIIBuffer ){
; pcASCIIBuffer start address is: 0 (R0)
SUB	SP, SP, #4
; pcASCIIBuffer end address is: 0 (R0)
; pcASCIIBuffer start address is: 0 (R0)
;utils.c,42 :: 		ucMSBNibble = 0;
MOVS	R1, #0
MOVW	R3, #lo_addr(_ucMSBNibble+0)
MOVT	R3, #hi_addr(_ucMSBNibble+0)
STRB	R1, [R3, #0]
;utils.c,43 :: 		ucLSBNibble = 0;
MOVS	R2, #0
MOVW	R1, #lo_addr(_ucLSBNibble+0)
MOVT	R1, #hi_addr(_ucLSBNibble+0)
STRB	R2, [R1, #0]
;utils.c,45 :: 		ucMSBNibble = ( pcASCIIBuffer[ 0 ] - 0x30 );
LDRB	R1, [R0, #0]
SUBS	R1, #48
STRB	R1, [R3, #0]
;utils.c,46 :: 		if( ucMSBNibble > 9 ){
UXTB	R1, R1
CMP	R1, #9
IT	LS
BLS	L_ucASCIIToByte159
;utils.c,47 :: 		ucMSBNibble -= 7;
MOVW	R2, #lo_addr(_ucMSBNibble+0)
MOVT	R2, #hi_addr(_ucMSBNibble+0)
LDRB	R1, [R2, #0]
SUBS	R1, R1, #7
STRB	R1, [R2, #0]
;utils.c,48 :: 		}
L_ucASCIIToByte159:
;utils.c,50 :: 		ucLSBNibble = ( pcASCIIBuffer[ 1 ] - 0x30 );
ADDS	R1, R0, #1
; pcASCIIBuffer end address is: 0 (R0)
LDRB	R1, [R1, #0]
SUBW	R2, R1, #48
MOVW	R1, #lo_addr(_ucLSBNibble+0)
MOVT	R1, #hi_addr(_ucLSBNibble+0)
STRB	R2, [R1, #0]
;utils.c,51 :: 		if( ucLSBNibble > 9 ){
UXTB	R1, R2
CMP	R1, #9
IT	LS
BLS	L_ucASCIIToByte160
;utils.c,52 :: 		ucLSBNibble -= 7;
MOVW	R2, #lo_addr(_ucLSBNibble+0)
MOVT	R2, #hi_addr(_ucLSBNibble+0)
LDRB	R1, [R2, #0]
SUBS	R1, R1, #7
STRB	R1, [R2, #0]
;utils.c,53 :: 		}
L_ucASCIIToByte160:
;utils.c,55 :: 		return ( ucMSBNibble << 4 | ucLSBNibble );
MOVW	R1, #lo_addr(_ucMSBNibble+0)
MOVT	R1, #hi_addr(_ucMSBNibble+0)
LDRB	R1, [R1, #0]
LSLS	R2, R1, #4
UXTH	R2, R2
MOVW	R1, #lo_addr(_ucLSBNibble+0)
MOVT	R1, #hi_addr(_ucLSBNibble+0)
LDRB	R1, [R1, #0]
ORR	R1, R2, R1, LSL #0
UXTB	R0, R1
;utils.c,56 :: 		}
L_end_ucASCIIToByte:
ADD	SP, SP, #4
BX	LR
; end of _ucASCIIToByte
_vASCIIToHex:
;utils.c,61 :: 		void vASCIIToHex( unsigned char *pcHexConvertBuffer, unsigned char *pcASCIIConvertBuffer, unsigned char ucConversionLength ){
; ucConversionLength start address is: 8 (R2)
; pcASCIIConvertBuffer start address is: 4 (R1)
; pcHexConvertBuffer start address is: 0 (R0)
SUB	SP, SP, #4
; ucConversionLength end address is: 8 (R2)
; pcASCIIConvertBuffer end address is: 4 (R1)
; pcHexConvertBuffer end address is: 0 (R0)
; pcHexConvertBuffer start address is: 0 (R0)
; pcASCIIConvertBuffer start address is: 4 (R1)
; ucConversionLength start address is: 8 (R2)
;utils.c,62 :: 		unsigned char ucASCIICounter = 0;
;utils.c,64 :: 		for( ucASCIICounter = 0; ucASCIICounter < ucConversionLength; ucASCIICounter++ ){
; ucASCIICounter start address is: 24 (R6)
MOVS	R6, #0
; pcHexConvertBuffer end address is: 0 (R0)
; ucConversionLength end address is: 8 (R2)
; ucASCIICounter end address is: 24 (R6)
STRB	R2, [SP, #0]
MOV	R2, R0
LDRB	R0, [SP, #0]
L_vASCIIToHex161:
; ucASCIICounter start address is: 24 (R6)
; pcHexConvertBuffer start address is: 8 (R2)
; ucConversionLength start address is: 0 (R0)
; pcASCIIConvertBuffer start address is: 4 (R1)
; pcASCIIConvertBuffer end address is: 4 (R1)
; pcHexConvertBuffer start address is: 8 (R2)
; pcHexConvertBuffer end address is: 8 (R2)
CMP	R6, R0
IT	CS
BCS	L_vASCIIToHex162
; pcASCIIConvertBuffer end address is: 4 (R1)
; pcHexConvertBuffer end address is: 8 (R2)
;utils.c,65 :: 		ucMSBNibble = 0;
; pcHexConvertBuffer start address is: 8 (R2)
; pcASCIIConvertBuffer start address is: 4 (R1)
MOVS	R3, #0
MOVW	R5, #lo_addr(_ucMSBNibble+0)
MOVT	R5, #hi_addr(_ucMSBNibble+0)
STRB	R3, [R5, #0]
;utils.c,66 :: 		ucLSBNibble = 0;
MOVS	R4, #0
MOVW	R3, #lo_addr(_ucLSBNibble+0)
MOVT	R3, #hi_addr(_ucLSBNibble+0)
STRB	R4, [R3, #0]
;utils.c,68 :: 		ucMSBNibble = ( pcASCIIConvertBuffer[ ucASCIICounter * 2 ] - 0x30 );
LSLS	R3, R6, #1
SXTH	R3, R3
ADDS	R3, R1, R3
LDRB	R3, [R3, #0]
SUBS	R3, #48
STRB	R3, [R5, #0]
;utils.c,69 :: 		if( ucMSBNibble > 9 ){
UXTB	R3, R3
CMP	R3, #9
IT	LS
BLS	L_vASCIIToHex164
;utils.c,70 :: 		ucMSBNibble -= 7;
MOVW	R4, #lo_addr(_ucMSBNibble+0)
MOVT	R4, #hi_addr(_ucMSBNibble+0)
LDRB	R3, [R4, #0]
SUBS	R3, R3, #7
STRB	R3, [R4, #0]
;utils.c,71 :: 		}
L_vASCIIToHex164:
;utils.c,73 :: 		ucLSBNibble = ( pcASCIIConvertBuffer[ ( ucASCIICounter * 2 ) + 1 ] - 0x30 );
LSLS	R3, R6, #1
SXTH	R3, R3
ADDS	R3, R3, #1
SXTH	R3, R3
ADDS	R3, R1, R3
LDRB	R3, [R3, #0]
SUBW	R4, R3, #48
MOVW	R3, #lo_addr(_ucLSBNibble+0)
MOVT	R3, #hi_addr(_ucLSBNibble+0)
STRB	R4, [R3, #0]
;utils.c,74 :: 		if( ucLSBNibble > 9 ){
UXTB	R3, R4
CMP	R3, #9
IT	LS
BLS	L_vASCIIToHex165
;utils.c,75 :: 		ucLSBNibble -= 7;
MOVW	R4, #lo_addr(_ucLSBNibble+0)
MOVT	R4, #hi_addr(_ucLSBNibble+0)
LDRB	R3, [R4, #0]
SUBS	R3, R3, #7
STRB	R3, [R4, #0]
;utils.c,76 :: 		}
L_vASCIIToHex165:
;utils.c,78 :: 		pcHexConvertBuffer[ ucASCIICounter ] = ( ( ucMSBNibble << 4 ) | ucLSBNibble );
ADDS	R5, R2, R6
MOVW	R3, #lo_addr(_ucMSBNibble+0)
MOVT	R3, #hi_addr(_ucMSBNibble+0)
LDRB	R3, [R3, #0]
LSLS	R4, R3, #4
UXTH	R4, R4
MOVW	R3, #lo_addr(_ucLSBNibble+0)
MOVT	R3, #hi_addr(_ucLSBNibble+0)
LDRB	R3, [R3, #0]
ORR	R3, R4, R3, LSL #0
STRB	R3, [R5, #0]
;utils.c,64 :: 		for( ucASCIICounter = 0; ucASCIICounter < ucConversionLength; ucASCIICounter++ ){
ADDS	R6, R6, #1
UXTB	R6, R6
;utils.c,79 :: 		}
; ucConversionLength end address is: 0 (R0)
; pcASCIIConvertBuffer end address is: 4 (R1)
; pcHexConvertBuffer end address is: 8 (R2)
; ucASCIICounter end address is: 24 (R6)
IT	AL
BAL	L_vASCIIToHex161
L_vASCIIToHex162:
;utils.c,80 :: 		}
L_end_vASCIIToHex:
ADD	SP, SP, #4
BX	LR
; end of _vASCIIToHex
_vHexToASCII:
;utils.c,85 :: 		void vHexToASCII( unsigned char *pcASCIIConvertBuffer, unsigned char *pcHexConvertBuffer, unsigned char ucConversionLength ){
; ucConversionLength start address is: 8 (R2)
; pcHexConvertBuffer start address is: 4 (R1)
; pcASCIIConvertBuffer start address is: 0 (R0)
SUB	SP, SP, #4
UXTB	R3, R2
MOV	R2, R1
MOV	R1, R0
; ucConversionLength end address is: 8 (R2)
; pcHexConvertBuffer end address is: 4 (R1)
; pcASCIIConvertBuffer end address is: 0 (R0)
; pcASCIIConvertBuffer start address is: 4 (R1)
; pcHexConvertBuffer start address is: 8 (R2)
; ucConversionLength start address is: 12 (R3)
;utils.c,86 :: 		unsigned char ucHexConvCounter = 0;
;utils.c,88 :: 		for( ucHexConvCounter = 0; ucHexConvCounter < ucConversionLength; ucHexConvCounter++ ){
; ucHexConvCounter start address is: 0 (R0)
MOVS	R0, #0
; pcASCIIConvertBuffer end address is: 4 (R1)
; pcHexConvertBuffer end address is: 8 (R2)
; ucConversionLength end address is: 12 (R3)
; ucHexConvCounter end address is: 0 (R0)
STR	R2, [SP, #0]
MOV	R2, R1
UXTB	R6, R0
UXTB	R0, R3
LDR	R1, [SP, #0]
L_vHexToASCII166:
; ucHexConvCounter start address is: 24 (R6)
; pcASCIIConvertBuffer start address is: 8 (R2)
; pcHexConvertBuffer start address is: 4 (R1)
; ucConversionLength start address is: 0 (R0)
; pcHexConvertBuffer start address is: 4 (R1)
; pcHexConvertBuffer end address is: 4 (R1)
; pcASCIIConvertBuffer start address is: 8 (R2)
; pcASCIIConvertBuffer end address is: 8 (R2)
CMP	R6, R0
IT	CS
BCS	L_vHexToASCII167
; pcHexConvertBuffer end address is: 4 (R1)
; pcASCIIConvertBuffer end address is: 8 (R2)
;utils.c,89 :: 		pcASCIIConvertBuffer[ ucHexConvCounter * 2 ]            = pcHexChar[ pcHexConvertBuffer[ ucHexConvCounter ] >> 4 ];
; pcASCIIConvertBuffer start address is: 8 (R2)
; pcHexConvertBuffer start address is: 4 (R1)
LSLS	R3, R6, #1
SXTH	R3, R3
ADDS	R5, R2, R3
ADDS	R3, R1, R6
LDRB	R3, [R3, #0]
LSRS	R4, R3, #4
UXTB	R4, R4
MOVW	R3, #lo_addr(_pcHexChar+0)
MOVT	R3, #hi_addr(_pcHexChar+0)
ADDS	R3, R3, R4
LDRB	R3, [R3, #0]
STRB	R3, [R5, #0]
;utils.c,90 :: 		pcASCIIConvertBuffer[ ( ucHexConvCounter * 2 ) + 1 ]    = pcHexChar[ ( pcHexConvertBuffer[ ucHexConvCounter ] & 0x0F ) ];
LSLS	R3, R6, #1
SXTH	R3, R3
ADDS	R3, R3, #1
SXTH	R3, R3
ADDS	R5, R2, R3
ADDS	R3, R1, R6
LDRB	R3, [R3, #0]
AND	R4, R3, #15
UXTB	R4, R4
MOVW	R3, #lo_addr(_pcHexChar+0)
MOVT	R3, #hi_addr(_pcHexChar+0)
ADDS	R3, R3, R4
LDRB	R3, [R3, #0]
STRB	R3, [R5, #0]
;utils.c,88 :: 		for( ucHexConvCounter = 0; ucHexConvCounter < ucConversionLength; ucHexConvCounter++ ){
ADDS	R6, R6, #1
UXTB	R6, R6
;utils.c,91 :: 		}
; ucConversionLength end address is: 0 (R0)
; pcHexConvertBuffer end address is: 4 (R1)
; pcASCIIConvertBuffer end address is: 8 (R2)
; ucHexConvCounter end address is: 24 (R6)
IT	AL
BAL	L_vHexToASCII166
L_vHexToASCII167:
;utils.c,92 :: 		}
L_end_vHexToASCII:
ADD	SP, SP, #4
BX	LR
; end of _vHexToASCII
_vBufferSetToZero:
;utils.c,97 :: 		void vBufferSetToZero( unsigned char * pcBufferToClean, unsigned int uslength ){
; uslength start address is: 4 (R1)
; pcBufferToClean start address is: 0 (R0)
SUB	SP, SP, #4
; uslength end address is: 4 (R1)
; pcBufferToClean end address is: 0 (R0)
; pcBufferToClean start address is: 0 (R0)
; uslength start address is: 4 (R1)
;utils.c,98 :: 		unsigned int usPosition = 0;
;utils.c,100 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
; usPosition start address is: 16 (R4)
MOVS	R4, #0
; pcBufferToClean end address is: 0 (R0)
; uslength end address is: 4 (R1)
; usPosition end address is: 16 (R4)
STRH	R1, [SP, #0]
MOV	R1, R0
LDRH	R0, [SP, #0]
L_vBufferSetToZero169:
; usPosition start address is: 16 (R4)
; pcBufferToClean start address is: 4 (R1)
; uslength start address is: 0 (R0)
; pcBufferToClean start address is: 4 (R1)
; pcBufferToClean end address is: 4 (R1)
CMP	R4, R0
IT	CS
BCS	L_vBufferSetToZero170
; pcBufferToClean end address is: 4 (R1)
;utils.c,101 :: 		pcBufferToClean[ usPosition ] = 0x00;
; pcBufferToClean start address is: 4 (R1)
ADDS	R3, R1, R4
MOVS	R2, #0
STRB	R2, [R3, #0]
;utils.c,100 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
ADDS	R4, R4, #1
UXTH	R4, R4
;utils.c,102 :: 		}
; uslength end address is: 0 (R0)
; pcBufferToClean end address is: 4 (R1)
; usPosition end address is: 16 (R4)
IT	AL
BAL	L_vBufferSetToZero169
L_vBufferSetToZero170:
;utils.c,103 :: 		}
L_end_vBufferSetToZero:
ADD	SP, SP, #4
BX	LR
; end of _vBufferSetToZero
_vBufferSetTo255:
;utils.c,108 :: 		void vBufferSetTo255( unsigned char * pcBufferToClean, unsigned int uslength ){
; uslength start address is: 4 (R1)
; pcBufferToClean start address is: 0 (R0)
SUB	SP, SP, #4
; uslength end address is: 4 (R1)
; pcBufferToClean end address is: 0 (R0)
; pcBufferToClean start address is: 0 (R0)
; uslength start address is: 4 (R1)
;utils.c,109 :: 		unsigned int usPosition = 0;
;utils.c,111 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
; usPosition start address is: 16 (R4)
MOVS	R4, #0
; pcBufferToClean end address is: 0 (R0)
; uslength end address is: 4 (R1)
; usPosition end address is: 16 (R4)
STRH	R1, [SP, #0]
MOV	R1, R0
LDRH	R0, [SP, #0]
L_vBufferSetTo255172:
; usPosition start address is: 16 (R4)
; pcBufferToClean start address is: 4 (R1)
; uslength start address is: 0 (R0)
; pcBufferToClean start address is: 4 (R1)
; pcBufferToClean end address is: 4 (R1)
CMP	R4, R0
IT	CS
BCS	L_vBufferSetTo255173
; pcBufferToClean end address is: 4 (R1)
;utils.c,112 :: 		pcBufferToClean[ usPosition ] = 0xFF;
; pcBufferToClean start address is: 4 (R1)
ADDS	R3, R1, R4
MOVS	R2, #255
STRB	R2, [R3, #0]
;utils.c,111 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
ADDS	R4, R4, #1
UXTH	R4, R4
;utils.c,113 :: 		}
; uslength end address is: 0 (R0)
; pcBufferToClean end address is: 4 (R1)
; usPosition end address is: 16 (R4)
IT	AL
BAL	L_vBufferSetTo255172
L_vBufferSetTo255173:
;utils.c,114 :: 		}
L_end_vBufferSetTo255:
ADD	SP, SP, #4
BX	LR
; end of _vBufferSetTo255
_vBufferSetToValue:
;utils.c,119 :: 		void vBufferSetToValue( unsigned char * pcBufferToClean, unsigned char ucValue, unsigned int uslength ){
; uslength start address is: 8 (R2)
; ucValue start address is: 4 (R1)
; pcBufferToClean start address is: 0 (R0)
SUB	SP, SP, #4
UXTH	R3, R2
UXTB	R2, R1
MOV	R1, R0
; uslength end address is: 8 (R2)
; ucValue end address is: 4 (R1)
; pcBufferToClean end address is: 0 (R0)
; pcBufferToClean start address is: 4 (R1)
; ucValue start address is: 8 (R2)
; uslength start address is: 12 (R3)
;utils.c,120 :: 		unsigned int usPosition = 0;
;utils.c,122 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
; usPosition start address is: 0 (R0)
MOVS	R0, #0
; pcBufferToClean end address is: 4 (R1)
; ucValue end address is: 8 (R2)
; uslength end address is: 12 (R3)
; usPosition end address is: 0 (R0)
STRB	R2, [SP, #0]
MOV	R2, R1
UXTH	R4, R0
UXTH	R0, R3
LDRB	R1, [SP, #0]
L_vBufferSetToValue175:
; usPosition start address is: 16 (R4)
; pcBufferToClean start address is: 8 (R2)
; ucValue start address is: 4 (R1)
; uslength start address is: 0 (R0)
; ucValue start address is: 4 (R1)
; ucValue end address is: 4 (R1)
; pcBufferToClean start address is: 8 (R2)
; pcBufferToClean end address is: 8 (R2)
CMP	R4, R0
IT	CS
BCS	L_vBufferSetToValue176
; ucValue end address is: 4 (R1)
; pcBufferToClean end address is: 8 (R2)
;utils.c,123 :: 		pcBufferToClean[ usPosition ] = ucValue;
; pcBufferToClean start address is: 8 (R2)
; ucValue start address is: 4 (R1)
ADDS	R3, R2, R4
STRB	R1, [R3, #0]
;utils.c,122 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
ADDS	R4, R4, #1
UXTH	R4, R4
;utils.c,124 :: 		}
; uslength end address is: 0 (R0)
; ucValue end address is: 4 (R1)
; pcBufferToClean end address is: 8 (R2)
; usPosition end address is: 16 (R4)
IT	AL
BAL	L_vBufferSetToValue175
L_vBufferSetToValue176:
;utils.c,125 :: 		}
L_end_vBufferSetToValue:
ADD	SP, SP, #4
BX	LR
; end of _vBufferSetToValue
_vSerializeUUID:
;utils.c,130 :: 		void vSerializeUUID( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer ){
; pcHexConvertBuffer start address is: 4 (R1)
; pcTextConvertBuffer start address is: 0 (R0)
SUB	SP, SP, #4
; pcHexConvertBuffer end address is: 4 (R1)
; pcTextConvertBuffer end address is: 0 (R0)
; pcTextConvertBuffer start address is: 0 (R0)
; pcHexConvertBuffer start address is: 4 (R1)
;utils.c,131 :: 		unsigned char ucCounter = 0;
;utils.c,133 :: 		for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
; ucCounter start address is: 20 (R5)
MOVS	R5, #0
; pcTextConvertBuffer end address is: 0 (R0)
; pcHexConvertBuffer end address is: 4 (R1)
; ucCounter end address is: 20 (R5)
STR	R1, [SP, #0]
MOV	R1, R0
LDR	R0, [SP, #0]
L_vSerializeUUID178:
; ucCounter start address is: 20 (R5)
; pcTextConvertBuffer start address is: 4 (R1)
; pcHexConvertBuffer start address is: 0 (R0)
; pcHexConvertBuffer start address is: 0 (R0)
; pcHexConvertBuffer end address is: 0 (R0)
; pcTextConvertBuffer start address is: 4 (R1)
; pcTextConvertBuffer end address is: 4 (R1)
CMP	R5, #12
IT	CS
BCS	L_vSerializeUUID179
; pcHexConvertBuffer end address is: 0 (R0)
; pcTextConvertBuffer end address is: 4 (R1)
;utils.c,134 :: 		pcTextConvertBuffer[ ucCounter * 2 ]         = pcHexChar[ pcHexConvertBuffer[ ucCounter ] >> 4 ];
; pcTextConvertBuffer start address is: 4 (R1)
; pcHexConvertBuffer start address is: 0 (R0)
LSLS	R2, R5, #1
SXTH	R2, R2
ADDS	R4, R1, R2
ADDS	R2, R0, R5
LDRB	R2, [R2, #0]
LSRS	R3, R2, #4
UXTB	R3, R3
MOVW	R2, #lo_addr(_pcHexChar+0)
MOVT	R2, #hi_addr(_pcHexChar+0)
ADDS	R2, R2, R3
LDRB	R2, [R2, #0]
STRB	R2, [R4, #0]
;utils.c,135 :: 		pcTextConvertBuffer[ ( ucCounter * 2 ) + 1 ] = pcHexChar[ pcHexConvertBuffer[ ucCounter ] & 0x0F ];
LSLS	R2, R5, #1
SXTH	R2, R2
ADDS	R2, R2, #1
SXTH	R2, R2
ADDS	R4, R1, R2
ADDS	R2, R0, R5
LDRB	R2, [R2, #0]
AND	R3, R2, #15
UXTB	R3, R3
MOVW	R2, #lo_addr(_pcHexChar+0)
MOVT	R2, #hi_addr(_pcHexChar+0)
ADDS	R2, R2, R3
LDRB	R2, [R2, #0]
STRB	R2, [R4, #0]
;utils.c,133 :: 		for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
ADDS	R5, R5, #1
UXTB	R5, R5
;utils.c,136 :: 		}
; pcHexConvertBuffer end address is: 0 (R0)
; pcTextConvertBuffer end address is: 4 (R1)
; ucCounter end address is: 20 (R5)
IT	AL
BAL	L_vSerializeUUID178
L_vSerializeUUID179:
;utils.c,137 :: 		}
L_end_vSerializeUUID:
ADD	SP, SP, #4
BX	LR
; end of _vSerializeUUID
_vSerializeMACAddress:
;utils.c,142 :: 		void vSerializeMACAddress( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer ){
; pcHexConvertBuffer start address is: 4 (R1)
; pcTextConvertBuffer start address is: 0 (R0)
SUB	SP, SP, #16
STR	LR, [SP, #0]
MOV	R7, R0
; pcHexConvertBuffer end address is: 4 (R1)
; pcTextConvertBuffer end address is: 0 (R0)
; pcTextConvertBuffer start address is: 28 (R7)
; pcHexConvertBuffer start address is: 4 (R1)
;utils.c,143 :: 		unsigned int usCounter = 0;
;utils.c,146 :: 		vHexToASCII( pcDeviceMAC, pcHexConvertBuffer, 6 );
ADD	R2, SP, #4
MOV	R0, R2
; pcHexConvertBuffer end address is: 4 (R1)
MOVS	R2, #6
BL	_vHexToASCII+0
;utils.c,148 :: 		for( usCounter = 0; usCounter < 6; usCounter++ ){
; usCounter start address is: 4 (R1)
MOVS	R1, #0
; pcTextConvertBuffer end address is: 28 (R7)
; usCounter end address is: 4 (R1)
MOV	R0, R7
L_vSerializeMACAddress181:
; usCounter start address is: 4 (R1)
; pcTextConvertBuffer start address is: 0 (R0)
CMP	R1, #6
IT	CS
BCS	L_vSerializeMACAddress182
;utils.c,149 :: 		pcTextConvertBuffer[ usCounter * 3 ]         = pcDeviceMAC[ usCounter * 2 ];
MOVS	R2, #3
MULS	R2, R1, R2
UXTH	R2, R2
ADDS	R3, R0, R2
LSLS	R2, R1, #1
UXTH	R2, R2
ADD	R4, SP, #4
ADDS	R2, R4, R2
LDRB	R2, [R2, #0]
STRB	R2, [R3, #0]
;utils.c,150 :: 		pcTextConvertBuffer[ ( usCounter * 3 ) + 1 ] = pcDeviceMAC[ ( usCounter * 2 ) + 1 ];
MOVS	R2, #3
MULS	R2, R1, R2
UXTH	R2, R2
ADDS	R2, R2, #1
UXTH	R2, R2
ADDS	R3, R0, R2
LSLS	R2, R1, #1
UXTH	R2, R2
ADDS	R2, R2, #1
UXTH	R2, R2
ADDS	R2, R4, R2
LDRB	R2, [R2, #0]
STRB	R2, [R3, #0]
;utils.c,151 :: 		if( usCounter != 5 ){
CMP	R1, #5
IT	EQ
BEQ	L_vSerializeMACAddress184
;utils.c,152 :: 		pcTextConvertBuffer[ ( usCounter * 3 ) + 2 ] = ':';
MOVS	R2, #3
MULS	R2, R1, R2
UXTH	R2, R2
ADDS	R2, R2, #2
UXTH	R2, R2
ADDS	R3, R0, R2
MOVS	R2, #58
STRB	R2, [R3, #0]
;utils.c,153 :: 		}
L_vSerializeMACAddress184:
;utils.c,148 :: 		for( usCounter = 0; usCounter < 6; usCounter++ ){
ADDS	R1, R1, #1
UXTH	R1, R1
;utils.c,154 :: 		}
; usCounter end address is: 4 (R1)
IT	AL
BAL	L_vSerializeMACAddress181
L_vSerializeMACAddress182:
;utils.c,155 :: 		pcTextConvertBuffer[ 18 ] = '\0';
ADDW	R3, R0, #18
; pcTextConvertBuffer end address is: 0 (R0)
MOVS	R2, #0
STRB	R2, [R3, #0]
;utils.c,156 :: 		}
L_end_vSerializeMACAddress:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _vSerializeMACAddress
_vSerializeIPAddress:
;utils.c,161 :: 		void vSerializeIPAddress( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer ){
; pcHexConvertBuffer start address is: 4 (R1)
; pcTextConvertBuffer start address is: 0 (R0)
SUB	SP, SP, #16
STR	LR, [SP, #0]
MOV	R8, R0
MOV	R6, R1
; pcHexConvertBuffer end address is: 4 (R1)
; pcTextConvertBuffer end address is: 0 (R0)
; pcTextConvertBuffer start address is: 32 (R8)
; pcHexConvertBuffer start address is: 24 (R6)
;utils.c,162 :: 		unsigned char ucCounter = 0;
;utils.c,165 :: 		memset( pcTextConvertBuffer, '\0', sizeof( pcTextConvertBuffer ) );
MOVS	R2, #4
SXTH	R2, R2
MOVS	R1, #0
MOV	R0, R8
BL	_memset+0
;utils.c,167 :: 		for( ucCounter = 0; ucCounter < 4; ucCounter++ ){
; ucCounter start address is: 28 (R7)
MOVS	R7, #0
; ucCounter end address is: 28 (R7)
L_vSerializeIPAddress185:
; ucCounter start address is: 28 (R7)
; pcHexConvertBuffer start address is: 24 (R6)
; pcHexConvertBuffer end address is: 24 (R6)
; pcTextConvertBuffer start address is: 32 (R8)
; pcTextConvertBuffer end address is: 32 (R8)
CMP	R7, #4
IT	CS
BCS	L_vSerializeIPAddress186
; pcHexConvertBuffer end address is: 24 (R6)
; pcTextConvertBuffer end address is: 32 (R8)
;utils.c,169 :: 		ByteToStr( pcHexConvertBuffer[ ucCounter ], pcConvertText );
; pcTextConvertBuffer start address is: 32 (R8)
; pcHexConvertBuffer start address is: 24 (R6)
ADD	R3, SP, #4
ADDS	R2, R6, R7
LDRB	R2, [R2, #0]
MOV	R1, R3
UXTB	R0, R2
BL	_ByteToStr+0
;utils.c,171 :: 		strcat( pcTextConvertBuffer, Ltrim( pcConvertText ) );
ADD	R2, SP, #4
MOV	R0, R2
BL	_Ltrim+0
MOV	R1, R0
MOV	R0, R8
BL	_strcat+0
;utils.c,173 :: 		if( ucCounter != 3 ){
CMP	R7, #3
IT	EQ
BEQ	L_vSerializeIPAddress188
;utils.c,174 :: 		strcat( pcTextConvertBuffer, "." );
MOVS	R2, #46
STRB	R2, [SP, #11]
MOVS	R2, #0
STRB	R2, [SP, #12]
ADD	R2, SP, #11
MOV	R1, R2
MOV	R0, R8
BL	_strcat+0
;utils.c,175 :: 		}
L_vSerializeIPAddress188:
;utils.c,167 :: 		for( ucCounter = 0; ucCounter < 4; ucCounter++ ){
ADDS	R7, R7, #1
UXTB	R7, R7
;utils.c,176 :: 		}
; pcHexConvertBuffer end address is: 24 (R6)
; pcTextConvertBuffer end address is: 32 (R8)
; ucCounter end address is: 28 (R7)
IT	AL
BAL	L_vSerializeIPAddress185
L_vSerializeIPAddress186:
;utils.c,177 :: 		}
L_end_vSerializeIPAddress:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _vSerializeIPAddress
_vUARTISR:
;uarthandler.c,78 :: 		void vUARTISR() iv IVT_INT_USART1 ics ICS_AUTO{
;uarthandler.c,79 :: 		LED_BLUE =~ LED_BLUE;
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_LX	[R0, ByteOffset(GPIOC_ODRbits+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;uarthandler.c,81 :: 		if( USART1_SRbits.RXNE == 1 ){
MOVW	R0, #lo_addr(USART1_SRbits+0)
MOVT	R0, #hi_addr(USART1_SRbits+0)
_LX	[R0, ByteOffset(USART1_SRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUARTISR189
;uarthandler.c,82 :: 		ucTempByteUART = USART1_DR;
MOVW	R0, #lo_addr(USART1_DR+0)
MOVT	R0, #hi_addr(USART1_DR+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucTempByteUART+0)
MOVT	R0, #hi_addr(_ucTempByteUART+0)
STRB	R1, [R0, #0]
;uarthandler.c,83 :: 		if( ucTempByteUART == '\n' ){
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	NE
BNE	L_vUARTISR190
;uarthandler.c,84 :: 		pcRxUARTBuffer[ usUARTMessageLength++ ] = ucTempByteUART;
MOVW	R3, #lo_addr(_usUARTMessageLength+0)
MOVT	R3, #hi_addr(_usUARTMessageLength+0)
LDRH	R1, [R3, #0]
MOVW	R0, #lo_addr(_pcRxUARTBuffer+0)
MOVT	R0, #hi_addr(_pcRxUARTBuffer+0)
ADDS	R1, R0, R1
MOVW	R2, #lo_addr(_ucTempByteUART+0)
MOVT	R2, #hi_addr(_ucTempByteUART+0)
LDRB	R0, [R2, #0]
STRB	R0, [R1, #0]
MOV	R0, R3
LDRH	R0, [R0, #0]
ADDS	R0, R0, #1
STRH	R0, [R3, #0]
;uarthandler.c,85 :: 		ucUARTDataReady = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucUARTDataReady+0)
MOVT	R0, #hi_addr(_ucUARTDataReady+0)
STRB	R1, [R0, #0]
;uarthandler.c,86 :: 		ucTempByteUART = 0;
MOVS	R0, #0
STRB	R0, [R2, #0]
;uarthandler.c,87 :: 		LED_BLUE = PIN_LEVEL_LOW;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;uarthandler.c,88 :: 		}
IT	AL
BAL	L_vUARTISR191
L_vUARTISR190:
;uarthandler.c,90 :: 		pcRxUARTBuffer[ usUARTMessageLength++ ] = ucTempByteUART;
MOVW	R3, #lo_addr(_usUARTMessageLength+0)
MOVT	R3, #hi_addr(_usUARTMessageLength+0)
LDRH	R1, [R3, #0]
MOVW	R0, #lo_addr(_pcRxUARTBuffer+0)
MOVT	R0, #hi_addr(_pcRxUARTBuffer+0)
ADDS	R2, R0, R1
MOVW	R1, #lo_addr(_ucTempByteUART+0)
MOVT	R1, #hi_addr(_ucTempByteUART+0)
LDRB	R0, [R1, #0]
STRB	R0, [R2, #0]
MOV	R0, R3
LDRH	R0, [R0, #0]
ADDS	R0, R0, #1
STRH	R0, [R3, #0]
;uarthandler.c,91 :: 		ucTempByteUART = 0;
MOVS	R0, #0
STRB	R0, [R1, #0]
;uarthandler.c,92 :: 		}
L_vUARTISR191:
;uarthandler.c,93 :: 		}
L_vUARTISR189:
;uarthandler.c,94 :: 		if( USART1_SRbits.ORE == 1 ){
MOVW	R0, #lo_addr(USART1_SRbits+0)
MOVT	R0, #hi_addr(USART1_SRbits+0)
_LX	[R0, ByteOffset(USART1_SRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUARTISR192
;uarthandler.c,96 :: 		ucTempByteUART = USART1_SR;
MOVW	R0, #lo_addr(USART1_SR+0)
MOVT	R0, #hi_addr(USART1_SR+0)
LDR	R0, [R0, #0]
MOVW	R1, #lo_addr(_ucTempByteUART+0)
MOVT	R1, #hi_addr(_ucTempByteUART+0)
STRB	R0, [R1, #0]
;uarthandler.c,97 :: 		ucTempByteUART = USART1_DR;
MOVW	R0, #lo_addr(USART1_DR+0)
MOVT	R0, #hi_addr(USART1_DR+0)
LDR	R0, [R0, #0]
STRB	R0, [R1, #0]
;uarthandler.c,98 :: 		LED_BLUE = PIN_LEVEL_LOW;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;uarthandler.c,99 :: 		}
L_vUARTISR192:
;uarthandler.c,100 :: 		}
L_end_vUARTISR:
BX	LR
; end of _vUARTISR
_vUARTTxInit:
;uarthandler.c,108 :: 		void vUARTTxInit(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;uarthandler.c,109 :: 		UART1_Init_Advanced( 921600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10 );
MOVW	R0, #lo_addr(__GPIO_MODULE_USART1_PA9_10+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_USART1_PA9_10+0)
PUSH	(R0)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
MOV	R0, #921600
BL	_UART1_Init_Advanced+0
ADD	SP, SP, #4
;uarthandler.c,110 :: 		}
L_end_vUARTTxInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUARTTxInit
_vUARTRxInit:
;uarthandler.c,115 :: 		void vUARTRxInit(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;uarthandler.c,116 :: 		USART1_CR1bits.RE       = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(USART1_CR1bits+0)
MOVT	R0, #hi_addr(USART1_CR1bits+0)
_SX	[R0, ByteOffset(USART1_CR1bits+0)]
;uarthandler.c,117 :: 		USART1_CR1bits.RXNEIE   = 1;
MOVW	R0, #lo_addr(USART1_CR1bits+0)
MOVT	R0, #hi_addr(USART1_CR1bits+0)
_SX	[R0, ByteOffset(USART1_CR1bits+0)]
;uarthandler.c,119 :: 		NVIC_IntEnable( IVT_INT_USART1 );
MOVW	R0, #53
BL	_NVIC_IntEnable+0
;uarthandler.c,120 :: 		}
L_end_vUARTRxInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUARTRxInit
_vUARTRxMessage:
;uarthandler.c,125 :: 		void vUARTRxMessage(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;uarthandler.c,126 :: 		unsigned int usCounter = 0;
;uarthandler.c,135 :: 		vUARTCommands( pcRxUARTBuffer );
MOVW	R0, #lo_addr(_pcRxUARTBuffer+0)
MOVT	R0, #hi_addr(_pcRxUARTBuffer+0)
BL	_vUARTCommands+0
;uarthandler.c,137 :: 		memset( pcRxUARTBuffer, '\0', sizeof( pcRxUARTBuffer ) );
MOVW	R2, #2048
SXTH	R2, R2
MOVS	R1, #0
MOVW	R0, #lo_addr(_pcRxUARTBuffer+0)
MOVT	R0, #hi_addr(_pcRxUARTBuffer+0)
BL	_memset+0
;uarthandler.c,138 :: 		usUARTMessageLength = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_usUARTMessageLength+0)
MOVT	R0, #hi_addr(_usUARTMessageLength+0)
STRH	R1, [R0, #0]
;uarthandler.c,139 :: 		}
L_end_vUARTRxMessage:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUARTRxMessage
_vUARTCommands:
;uarthandler.c,144 :: 		void vUARTCommands( unsigned char * pcInBuffer ){
; pcInBuffer start address is: 0 (R0)
SUB	SP, SP, #72
STR	LR, [SP, #0]
; pcInBuffer end address is: 0 (R0)
; pcInBuffer start address is: 0 (R0)
;uarthandler.c,145 :: 		unsigned char ucCommandCounter = 0;
;uarthandler.c,146 :: 		unsigned char ucCounter = 0;
;uarthandler.c,147 :: 		unsigned char ucPosition = 0;
;uarthandler.c,152 :: 		unsigned int usTempData = 0;
;uarthandler.c,153 :: 		unsigned char ucDeviceModel = 0;
;uarthandler.c,155 :: 		unsigned int usTempChannel = 0;
;uarthandler.c,156 :: 		unsigned int usTempNetwork = 0;
;uarthandler.c,157 :: 		unsigned char ucIgnoreNetwork = 0;
MOVS	R1, #0
STRB	R1, [SP, #67]
;uarthandler.c,159 :: 		unsigned int usTempNode = 0;
;uarthandler.c,160 :: 		unsigned int usTempDestination = 0;
;uarthandler.c,161 :: 		unsigned int usTempTable = 0;
;uarthandler.c,162 :: 		unsigned int usTempCommand = 0;
;uarthandler.c,163 :: 		unsigned char ucTempBufferLength = 0;
;uarthandler.c,165 :: 		for( ucCommandCounter = 0; ucCommandCounter < UART_Commands; ucCommandCounter++ ){
MOVS	R1, #0
STRB	R1, [SP, #68]
; pcInBuffer end address is: 0 (R0)
MOV	R7, R0
L_vUARTCommands193:
; pcInBuffer start address is: 28 (R7)
LDRB	R1, [SP, #68]
CMP	R1, #22
IT	CS
BCS	L_vUARTCommands194
;uarthandler.c,166 :: 		if( strstr( pcInBuffer, pcUARTCommand[ ucCommandCounter ] ) ){
LDRB	R1, [SP, #68]
LSLS	R2, R1, #2
MOVW	R1, #lo_addr(_pcUARTCommand+0)
MOVT	R1, #hi_addr(_pcUARTCommand+0)
ADDS	R1, R1, R2
LDR	R1, [R1, #0]
MOV	R0, R7
BL	_strstr+0
CMP	R0, #0
IT	EQ
BEQ	L__vUARTCommands345
;uarthandler.c,167 :: 		switch( ucCommandCounter ){
IT	AL
BAL	L_vUARTCommands197
;uarthandler.c,168 :: 		case UART_CMD_WHO:
L_vUARTCommands199:
;uarthandler.c,169 :: 		UART1_Write_Text( "DONGLE\r\n" );
ADD	R11, SP, #58
ADD	R10, R11, #9
MOVW	R12, #lo_addr(?ICS?lstr24_DriverRF4463PROMain+0)
MOVT	R12, #hi_addr(?ICS?lstr24_DriverRF4463PROMain+0)
BL	___CC2DW+0
ADD	R1, SP, #58
MOV	R0, R1
BL	_UART1_Write_Text+0
;uarthandler.c,170 :: 		Sound_Play( 1000, 100 );
MOVS	R1, #100
MOVW	R0, #1000
BL	_Sound_Play+0
;uarthandler.c,171 :: 		Delay_ms( 30 );
STR	R7, [SP, #4]
MOVW	R7, #32319
MOVT	R7, #5
NOP
NOP
L_vUARTCommands200:
SUBS	R7, R7, #1
BNE	L_vUARTCommands200
NOP
NOP
NOP
LDR	R7, [SP, #4]
;uarthandler.c,172 :: 		Sound_Play( 1000, 100 );
MOVS	R1, #100
MOVW	R0, #1000
BL	_Sound_Play+0
;uarthandler.c,173 :: 		break;
MOV	R3, R7
IT	AL
BAL	L_vUARTCommands198
;uarthandler.c,174 :: 		case UART_CMD_SEND:
L_vUARTCommands202:
;uarthandler.c,178 :: 		memset( pcTempBuffer, '\0', 50 );
ADD	R1, SP, #8
MOVS	R2, #50
SXTH	R2, R2
MOV	R0, R1
MOVS	R1, #0
BL	_memset+0
;uarthandler.c,180 :: 		ucPosition = 5;
; ucPosition start address is: 16 (R4)
MOVS	R4, #5
;uarthandler.c,181 :: 		for( ucCounter = 0; ucCounter < usUARTMessageLength; ucCounter++ ){
; ucCounter start address is: 0 (R0)
MOVS	R0, #0
; pcInBuffer end address is: 28 (R7)
; ucPosition end address is: 16 (R4)
; ucCounter end address is: 0 (R0)
UXTB	R3, R4
MOV	R4, R7
L_vUARTCommands203:
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 12 (R3)
; pcInBuffer start address is: 16 (R4)
MOVW	R1, #lo_addr(_usUARTMessageLength+0)
MOVT	R1, #hi_addr(_usUARTMessageLength+0)
LDRH	R1, [R1, #0]
CMP	R0, R1
IT	CS
BCS	L_vUARTCommands204
;uarthandler.c,182 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
ADDS	R1, R4, R3
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands323
ADDS	R1, R4, R3
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands322
IT	AL
BAL	L_vUARTCommands208
; ucCounter end address is: 0 (R0)
; ucPosition end address is: 12 (R3)
L__vUARTCommands323:
L__vUARTCommands322:
;uarthandler.c,183 :: 		break;
IT	AL
BAL	L_vUARTCommands204
;uarthandler.c,184 :: 		}
L_vUARTCommands208:
;uarthandler.c,185 :: 		pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
; ucPosition start address is: 12 (R3)
; ucCounter start address is: 0 (R0)
ADD	R1, SP, #8
ADDS	R2, R1, R0
ADDS	R1, R4, R3
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
ADDS	R1, R3, #1
; ucPosition end address is: 12 (R3)
; ucPosition start address is: 8 (R2)
UXTB	R2, R1
;uarthandler.c,181 :: 		for( ucCounter = 0; ucCounter < usUARTMessageLength; ucCounter++ ){
ADDS	R1, R0, #1
; ucCounter end address is: 0 (R0)
; ucCounter start address is: 4 (R1)
;uarthandler.c,186 :: 		}
; ucPosition end address is: 8 (R2)
; ucCounter end address is: 4 (R1)
UXTB	R3, R2
UXTB	R0, R1
IT	AL
BAL	L_vUARTCommands203
L_vUARTCommands204:
;uarthandler.c,189 :: 		break;
MOV	R3, R4
; pcInBuffer end address is: 16 (R4)
IT	AL
BAL	L_vUARTCommands198
;uarthandler.c,190 :: 		case UART_CMD_END:
L_vUARTCommands209:
;uarthandler.c,196 :: 		ucPosition = 6;
; ucPosition start address is: 8 (R2)
; pcInBuffer start address is: 28 (R7)
MOVS	R2, #6
;uarthandler.c,198 :: 		for( ucCounter = 0; ucCounter < usUARTMessageLength; ucCounter++ ){
; ucCounter start address is: 0 (R0)
MOVS	R0, #0
; pcInBuffer end address is: 28 (R7)
; ucCounter end address is: 0 (R0)
MOV	R3, R7
L_vUARTCommands210:
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 8 (R2)
; ucPosition end address is: 8 (R2)
; pcInBuffer start address is: 12 (R3)
MOVW	R1, #lo_addr(_usUARTMessageLength+0)
MOVT	R1, #hi_addr(_usUARTMessageLength+0)
LDRH	R1, [R1, #0]
CMP	R0, R1
IT	CS
BCS	L_vUARTCommands211
; ucPosition end address is: 8 (R2)
;uarthandler.c,199 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
; ucPosition start address is: 8 (R2)
ADDS	R1, R3, R2
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands325
ADDS	R1, R3, R2
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands324
IT	AL
BAL	L_vUARTCommands215
; ucCounter end address is: 0 (R0)
; ucPosition end address is: 8 (R2)
L__vUARTCommands325:
L__vUARTCommands324:
;uarthandler.c,200 :: 		break;
IT	AL
BAL	L_vUARTCommands211
;uarthandler.c,201 :: 		}
L_vUARTCommands215:
;uarthandler.c,198 :: 		for( ucCounter = 0; ucCounter < usUARTMessageLength; ucCounter++ ){
; ucPosition start address is: 8 (R2)
; ucCounter start address is: 0 (R0)
ADDS	R1, R0, #1
UXTB	R1, R1
; ucCounter end address is: 0 (R0)
; ucCounter start address is: 4 (R1)
;uarthandler.c,203 :: 		}
; ucPosition end address is: 8 (R2)
; ucCounter end address is: 4 (R1)
UXTB	R0, R1
IT	AL
BAL	L_vUARTCommands210
L_vUARTCommands211:
;uarthandler.c,207 :: 		break;
; pcInBuffer end address is: 12 (R3)
IT	AL
BAL	L_vUARTCommands198
;uarthandler.c,208 :: 		case UART_CMD_STAGE:
L_vUARTCommands216:
;uarthandler.c,216 :: 		break;
; pcInBuffer start address is: 28 (R7)
MOV	R3, R7
IT	AL
BAL	L_vUARTCommands198
;uarthandler.c,217 :: 		case UART_CMD_REBOOT:
L_vUARTCommands217:
;uarthandler.c,220 :: 		LED_BLUE = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOC_ODRbits+0)
MOVT	R1, #hi_addr(GPIOC_ODRbits+0)
_SX	[R1, ByteOffset(GPIOC_ODRbits+0)]
;uarthandler.c,221 :: 		LED_GREEN = 0;
MOVW	R1, #lo_addr(GPIOC_ODRbits+0)
MOVT	R1, #hi_addr(GPIOC_ODRbits+0)
_SX	[R1, ByteOffset(GPIOC_ODRbits+0)]
;uarthandler.c,222 :: 		LED_RED = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOC_ODRbits+0)
MOVT	R1, #hi_addr(GPIOC_ODRbits+0)
_SX	[R1, ByteOffset(GPIOC_ODRbits+0)]
;uarthandler.c,224 :: 		Delay_ms( 1000 );
STR	R7, [SP, #4]
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_vUARTCommands218:
SUBS	R7, R7, #1
BNE	L_vUARTCommands218
NOP
NOP
NOP
LDR	R7, [SP, #4]
;uarthandler.c,225 :: 		SystemReset();
BL	_SystemReset+0
;uarthandler.c,226 :: 		break;
MOV	R3, R7
IT	AL
BAL	L_vUARTCommands198
;uarthandler.c,227 :: 		case UART_CMD_PING:
L_vUARTCommands220:
;uarthandler.c,231 :: 		break;
MOV	R3, R7
IT	AL
BAL	L_vUARTCommands198
;uarthandler.c,232 :: 		case UART_CMD_TEST:
L_vUARTCommands221:
;uarthandler.c,234 :: 		memset( pcTempBuffer, '\0', 50 );
ADD	R1, SP, #8
MOVS	R2, #50
SXTH	R2, R2
MOV	R0, R1
MOVS	R1, #0
BL	_memset+0
;uarthandler.c,236 :: 		ucPosition = 5;
; ucPosition start address is: 16 (R4)
MOVS	R4, #5
;uarthandler.c,238 :: 		for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
; ucCounter start address is: 0 (R0)
MOVS	R0, #0
; pcInBuffer end address is: 28 (R7)
; ucPosition end address is: 16 (R4)
; ucCounter end address is: 0 (R0)
UXTB	R3, R4
MOV	R4, R7
L_vUARTCommands222:
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 12 (R3)
; pcInBuffer start address is: 16 (R4)
CMP	R0, #12
IT	CS
BCS	L_vUARTCommands223
;uarthandler.c,239 :: 		pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
ADD	R1, SP, #8
ADDS	R2, R1, R0
ADDS	R1, R4, R3
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
ADDS	R2, R3, #1
UXTB	R2, R2
; ucPosition end address is: 12 (R3)
; ucPosition start address is: 8 (R2)
;uarthandler.c,238 :: 		for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
ADDS	R1, R0, #1
UXTB	R1, R1
; ucCounter end address is: 0 (R0)
; ucCounter start address is: 4 (R1)
;uarthandler.c,241 :: 		}
; ucPosition end address is: 8 (R2)
; ucCounter end address is: 4 (R1)
UXTB	R3, R2
UXTB	R0, R1
IT	AL
BAL	L_vUARTCommands222
L_vUARTCommands223:
;uarthandler.c,251 :: 		break;
MOV	R3, R4
; pcInBuffer end address is: 16 (R4)
IT	AL
BAL	L_vUARTCommands198
;uarthandler.c,252 :: 		case UART_CMD_REMOVE:
L_vUARTCommands225:
;uarthandler.c,255 :: 		memset( pcTempBuffer, '\0', 50 );
; pcInBuffer start address is: 28 (R7)
ADD	R1, SP, #8
MOVS	R2, #50
SXTH	R2, R2
MOV	R0, R1
MOVS	R1, #0
BL	_memset+0
;uarthandler.c,257 :: 		ucPosition = 7;
; ucPosition start address is: 16 (R4)
MOVS	R4, #7
;uarthandler.c,259 :: 		for( ucCounter = 0; ; ucCounter++ ){
; ucCounter start address is: 0 (R0)
MOVS	R0, #0
; pcInBuffer end address is: 28 (R7)
; ucPosition end address is: 16 (R4)
; ucCounter end address is: 0 (R0)
MOV	R9, R7
UXTB	R3, R4
L_vUARTCommands226:
;uarthandler.c,260 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 12 (R3)
; pcInBuffer start address is: 36 (R9)
ADD	R1, R9, R3, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands327
ADD	R1, R9, R3, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands326
IT	AL
BAL	L_vUARTCommands231
; ucCounter end address is: 0 (R0)
; ucPosition end address is: 12 (R3)
L__vUARTCommands327:
L__vUARTCommands326:
;uarthandler.c,261 :: 		break;
IT	AL
BAL	L_vUARTCommands227
;uarthandler.c,262 :: 		}
L_vUARTCommands231:
;uarthandler.c,263 :: 		pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
; ucPosition start address is: 12 (R3)
; ucCounter start address is: 0 (R0)
ADD	R1, SP, #8
ADDS	R2, R1, R0
ADD	R1, R9, R3, LSL #0
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
ADDS	R4, R3, #1
UXTB	R4, R4
; ucPosition end address is: 12 (R3)
; ucPosition start address is: 16 (R4)
;uarthandler.c,259 :: 		for( ucCounter = 0; ; ucCounter++ ){
ADDS	R1, R0, #1
UXTB	R1, R1
; ucCounter end address is: 0 (R0)
; ucCounter start address is: 4 (R1)
;uarthandler.c,264 :: 		}
; ucPosition end address is: 16 (R4)
; ucCounter end address is: 4 (R1)
UXTB	R3, R4
UXTB	R0, R1
IT	AL
BAL	L_vUARTCommands226
L_vUARTCommands227:
;uarthandler.c,266 :: 		usTempData = atoi( pcTempBuffer );
ADD	R1, SP, #8
MOV	R0, R1
BL	_atoi+0
;uarthandler.c,269 :: 		break;
MOV	R3, R9
; pcInBuffer end address is: 36 (R9)
IT	AL
BAL	L_vUARTCommands198
;uarthandler.c,270 :: 		case UART_CMD_CHANNEL:
L_vUARTCommands232:
;uarthandler.c,272 :: 		memset( pcTempBuffer, '\0', 50 );
; pcInBuffer start address is: 28 (R7)
ADD	R1, SP, #8
MOVS	R2, #50
SXTH	R2, R2
MOV	R0, R1
MOVS	R1, #0
BL	_memset+0
;uarthandler.c,274 :: 		ucPosition = 8;
; ucPosition start address is: 16 (R4)
MOVS	R4, #8
;uarthandler.c,278 :: 		for( ucCounter = 0; ; ucCounter++ ){
; ucCounter start address is: 0 (R0)
MOVS	R0, #0
; pcInBuffer end address is: 28 (R7)
; ucPosition end address is: 16 (R4)
; ucCounter end address is: 0 (R0)
MOV	R9, R7
UXTB	R10, R4
L_vUARTCommands233:
;uarthandler.c,279 :: 		if( pcInBuffer[ ucPosition ] == ',' ){
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 40 (R10)
; pcInBuffer start address is: 36 (R9)
ADD	R1, R9, R10, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #44
IT	NE
BNE	L_vUARTCommands236
; ucCounter end address is: 0 (R0)
;uarthandler.c,280 :: 		ucPosition++;
ADD	R1, R10, #1
; ucPosition end address is: 40 (R10)
; ucPosition start address is: 0 (R0)
UXTB	R0, R1
;uarthandler.c,281 :: 		break;
UXTB	R7, R0
; ucPosition end address is: 0 (R0)
IT	AL
BAL	L_vUARTCommands234
;uarthandler.c,282 :: 		}
L_vUARTCommands236:
;uarthandler.c,283 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 40 (R10)
ADD	R1, R9, R10, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands329
ADD	R1, R9, R10, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands328
IT	AL
BAL	L_vUARTCommands239
; ucCounter end address is: 0 (R0)
L__vUARTCommands329:
L__vUARTCommands328:
;uarthandler.c,284 :: 		ucIgnoreNetwork = 1;
MOVS	R1, #1
STRB	R1, [SP, #67]
;uarthandler.c,285 :: 		break;
UXTB	R7, R10
IT	AL
BAL	L_vUARTCommands234
;uarthandler.c,286 :: 		}
L_vUARTCommands239:
;uarthandler.c,287 :: 		pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
; ucCounter start address is: 0 (R0)
ADD	R1, SP, #8
ADDS	R2, R1, R0
ADD	R1, R9, R10, LSL #0
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
ADD	R4, R10, #1
UXTB	R4, R4
; ucPosition end address is: 40 (R10)
; ucPosition start address is: 16 (R4)
;uarthandler.c,278 :: 		for( ucCounter = 0; ; ucCounter++ ){
ADDS	R1, R0, #1
UXTB	R1, R1
; ucCounter end address is: 0 (R0)
; ucCounter start address is: 4 (R1)
;uarthandler.c,288 :: 		}
; ucPosition end address is: 16 (R4)
; ucCounter end address is: 4 (R1)
UXTB	R10, R4
UXTB	R0, R1
IT	AL
BAL	L_vUARTCommands233
L_vUARTCommands234:
;uarthandler.c,290 :: 		usTempChannel = atoi( pcTempBuffer );
; ucPosition start address is: 28 (R7)
ADD	R1, SP, #8
MOV	R0, R1
BL	_atoi+0
;uarthandler.c,292 :: 		if( ucIgnoreNetwork == 0 ){
LDRB	R1, [SP, #67]
CMP	R1, #0
IT	NE
BNE	L_vUARTCommands240
;uarthandler.c,293 :: 		for( ucCounter = 0; ; ucCounter++ ){
; ucCounter start address is: 0 (R0)
MOVS	R0, #0
; ucPosition end address is: 28 (R7)
; pcInBuffer end address is: 36 (R9)
; ucCounter end address is: 0 (R0)
UXTB	R3, R7
MOV	R7, R9
L_vUARTCommands241:
;uarthandler.c,294 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 12 (R3)
; pcInBuffer start address is: 28 (R7)
ADDS	R1, R7, R3
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands331
ADDS	R1, R7, R3
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands330
IT	AL
BAL	L_vUARTCommands246
; ucCounter end address is: 0 (R0)
; ucPosition end address is: 12 (R3)
L__vUARTCommands331:
L__vUARTCommands330:
;uarthandler.c,295 :: 		break;
IT	AL
BAL	L_vUARTCommands242
;uarthandler.c,296 :: 		}
L_vUARTCommands246:
;uarthandler.c,297 :: 		pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
; ucPosition start address is: 12 (R3)
; ucCounter start address is: 0 (R0)
ADD	R1, SP, #8
ADDS	R2, R1, R0
ADDS	R1, R7, R3
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
ADDS	R2, R3, #1
UXTB	R2, R2
; ucPosition end address is: 12 (R3)
; ucPosition start address is: 8 (R2)
;uarthandler.c,293 :: 		for( ucCounter = 0; ; ucCounter++ ){
ADDS	R1, R0, #1
UXTB	R1, R1
; ucCounter end address is: 0 (R0)
; ucCounter start address is: 4 (R1)
;uarthandler.c,298 :: 		}
; ucPosition end address is: 8 (R2)
; ucCounter end address is: 4 (R1)
UXTB	R3, R2
UXTB	R0, R1
IT	AL
BAL	L_vUARTCommands241
L_vUARTCommands242:
;uarthandler.c,299 :: 		usTempNetwork = atoi( pcTempBuffer );
ADD	R1, SP, #8
MOV	R0, R1
BL	_atoi+0
;uarthandler.c,303 :: 		}
MOV	R3, R7
; pcInBuffer end address is: 28 (R7)
IT	AL
BAL	L_vUARTCommands247
L_vUARTCommands240:
;uarthandler.c,307 :: 		}
; pcInBuffer start address is: 36 (R9)
MOV	R3, R9
L_vUARTCommands247:
; pcInBuffer end address is: 36 (R9)
;uarthandler.c,309 :: 		break;
; pcInBuffer start address is: 12 (R3)
; pcInBuffer end address is: 12 (R3)
IT	AL
BAL	L_vUARTCommands198
;uarthandler.c,310 :: 		case UART_CMD_INFO:
L_vUARTCommands248:
;uarthandler.c,337 :: 		break;
; pcInBuffer start address is: 28 (R7)
MOV	R3, R7
IT	AL
BAL	L_vUARTCommands198
;uarthandler.c,338 :: 		case UART_CMD_SEARCH:
L_vUARTCommands249:
;uarthandler.c,342 :: 		break;
MOV	R3, R7
IT	AL
BAL	L_vUARTCommands198
;uarthandler.c,343 :: 		case UART_CMD_OVERRIDE:
L_vUARTCommands250:
;uarthandler.c,345 :: 		break;
MOV	R3, R7
IT	AL
BAL	L_vUARTCommands198
;uarthandler.c,346 :: 		case UART_CMD_RESET_FTY:
L_vUARTCommands251:
;uarthandler.c,348 :: 		break;
MOV	R3, R7
IT	AL
BAL	L_vUARTCommands198
;uarthandler.c,349 :: 		case UART_CMD_OVERRIDE_SET:
L_vUARTCommands252:
;uarthandler.c,351 :: 		break;
MOV	R3, R7
IT	AL
BAL	L_vUARTCommands198
;uarthandler.c,352 :: 		case UART_CMD_DISCOVER:
L_vUARTCommands253:
;uarthandler.c,356 :: 		case UART_CMD_FIND:
L_vUARTCommands254:
;uarthandler.c,360 :: 		break;
MOV	R3, R7
IT	AL
BAL	L_vUARTCommands198
;uarthandler.c,361 :: 		case UART_CMD_UNBLOCK:
L_vUARTCommands255:
;uarthandler.c,362 :: 		break;
MOV	R3, R7
IT	AL
BAL	L_vUARTCommands198
;uarthandler.c,363 :: 		case UART_CMD_SET_TX_POWER:
L_vUARTCommands256:
;uarthandler.c,365 :: 		memset( pcTempBuffer, '\0', 20 );
ADD	R1, SP, #8
MOVS	R2, #20
SXTH	R2, R2
MOV	R0, R1
MOVS	R1, #0
BL	_memset+0
;uarthandler.c,366 :: 		ucPosition = 9;
; ucPosition start address is: 16 (R4)
MOVS	R4, #9
;uarthandler.c,367 :: 		for( ucCounter = 0; ; ucCounter++ ){
; ucCounter start address is: 0 (R0)
MOVS	R0, #0
; pcInBuffer end address is: 28 (R7)
; ucPosition end address is: 16 (R4)
; ucCounter end address is: 0 (R0)
MOV	R9, R7
UXTB	R3, R4
L_vUARTCommands257:
;uarthandler.c,368 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 12 (R3)
; pcInBuffer start address is: 36 (R9)
ADD	R1, R9, R3, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands333
ADD	R1, R9, R3, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands332
IT	AL
BAL	L_vUARTCommands262
; ucCounter end address is: 0 (R0)
; ucPosition end address is: 12 (R3)
L__vUARTCommands333:
L__vUARTCommands332:
;uarthandler.c,369 :: 		break;
IT	AL
BAL	L_vUARTCommands258
;uarthandler.c,370 :: 		}
L_vUARTCommands262:
;uarthandler.c,371 :: 		pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
; ucPosition start address is: 12 (R3)
; ucCounter start address is: 0 (R0)
ADD	R1, SP, #8
ADDS	R2, R1, R0
ADD	R1, R9, R3, LSL #0
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
ADDS	R4, R3, #1
UXTB	R4, R4
; ucPosition end address is: 12 (R3)
; ucPosition start address is: 16 (R4)
;uarthandler.c,367 :: 		for( ucCounter = 0; ; ucCounter++ ){
ADDS	R1, R0, #1
UXTB	R1, R1
; ucCounter end address is: 0 (R0)
; ucCounter start address is: 4 (R1)
;uarthandler.c,372 :: 		}
; ucPosition end address is: 16 (R4)
; ucCounter end address is: 4 (R1)
UXTB	R3, R4
UXTB	R0, R1
IT	AL
BAL	L_vUARTCommands257
L_vUARTCommands258:
;uarthandler.c,373 :: 		usTempData = atoi( pcTempBuffer );
ADD	R1, SP, #8
MOV	R0, R1
BL	_atoi+0
;uarthandler.c,375 :: 		break;
MOV	R3, R9
; pcInBuffer end address is: 36 (R9)
IT	AL
BAL	L_vUARTCommands198
;uarthandler.c,376 :: 		case UART_CMD_SEND_RF_MESSAGE:
L_vUARTCommands263:
;uarthandler.c,378 :: 		ucPosition = strlen( pcUARTCommand[ UART_CMD_SEND_RF_MESSAGE ] ) + 1;
; pcInBuffer start address is: 28 (R7)
MOVW	R1, #lo_addr(_pcUARTCommand+84)
MOVT	R1, #hi_addr(_pcUARTCommand+84)
LDR	R1, [R1, #0]
MOV	R0, R1
BL	_strlen+0
ADDS	R1, R0, #1
; ucPosition start address is: 20 (R5)
UXTB	R5, R1
;uarthandler.c,383 :: 		vBufferSetToZero( pcTempBuffer, 50 );
ADD	R1, SP, #8
MOV	R0, R1
MOVS	R1, #50
BL	_vBufferSetToZero+0
;uarthandler.c,384 :: 		for( ucCounter = 0; ; ucCounter++ ){
; ucCounter start address is: 0 (R0)
MOVS	R0, #0
; ucPosition end address is: 20 (R5)
; pcInBuffer end address is: 28 (R7)
; ucCounter end address is: 0 (R0)
MOV	R9, R7
UXTB	R3, R5
L_vUARTCommands264:
;uarthandler.c,385 :: 		if( pcInBuffer[ ucPosition ] == '|' ){
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 12 (R3)
; pcInBuffer start address is: 36 (R9)
ADD	R1, R9, R3, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #124
IT	NE
BNE	L_vUARTCommands267
; ucCounter end address is: 0 (R0)
;uarthandler.c,386 :: 		ucPosition++;
ADDS	R7, R3, #1
UXTB	R7, R7
; ucPosition end address is: 12 (R3)
; ucPosition start address is: 28 (R7)
;uarthandler.c,387 :: 		break;
IT	AL
BAL	L_vUARTCommands265
; ucPosition end address is: 28 (R7)
;uarthandler.c,388 :: 		}
L_vUARTCommands267:
;uarthandler.c,389 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
; ucPosition start address is: 12 (R3)
; ucCounter start address is: 0 (R0)
ADD	R1, R9, R3, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands335
ADD	R1, R9, R3, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands334
IT	AL
BAL	L_vUARTCommands270
; pcInBuffer end address is: 36 (R9)
; ucCounter end address is: 0 (R0)
; ucPosition end address is: 12 (R3)
L__vUARTCommands335:
L__vUARTCommands334:
;uarthandler.c,391 :: 		return;
IT	AL
BAL	L_end_vUARTCommands
;uarthandler.c,392 :: 		}
L_vUARTCommands270:
;uarthandler.c,393 :: 		pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
; ucPosition start address is: 12 (R3)
; ucCounter start address is: 0 (R0)
; pcInBuffer start address is: 36 (R9)
ADD	R1, SP, #8
ADDS	R2, R1, R0
ADD	R1, R9, R3, LSL #0
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
ADDS	R4, R3, #1
UXTB	R4, R4
; ucPosition end address is: 12 (R3)
; ucPosition start address is: 16 (R4)
;uarthandler.c,384 :: 		for( ucCounter = 0; ; ucCounter++ ){
ADDS	R1, R0, #1
UXTB	R1, R1
; ucCounter end address is: 0 (R0)
; ucCounter start address is: 4 (R1)
;uarthandler.c,394 :: 		}
; ucPosition end address is: 16 (R4)
; ucCounter end address is: 4 (R1)
UXTB	R3, R4
UXTB	R0, R1
IT	AL
BAL	L_vUARTCommands264
L_vUARTCommands265:
;uarthandler.c,395 :: 		usTempDestination = atoi( pcTempBuffer );
; ucPosition start address is: 28 (R7)
ADD	R1, SP, #8
MOV	R0, R1
BL	_atoi+0
;uarthandler.c,400 :: 		vBufferSetToZero( pcTempBuffer, 50 );
ADD	R1, SP, #8
MOV	R0, R1
MOVS	R1, #50
BL	_vBufferSetToZero+0
;uarthandler.c,401 :: 		for( ucCounter = 0; ; ucCounter++ ){
; ucCounter start address is: 0 (R0)
MOVS	R0, #0
; ucPosition end address is: 28 (R7)
; pcInBuffer end address is: 36 (R9)
; ucCounter end address is: 0 (R0)
UXTB	R3, R7
L_vUARTCommands271:
;uarthandler.c,402 :: 		if( pcInBuffer[ ucPosition ] == '|' ){
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 12 (R3)
; pcInBuffer start address is: 36 (R9)
ADD	R1, R9, R3, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #124
IT	NE
BNE	L_vUARTCommands274
; ucCounter end address is: 0 (R0)
;uarthandler.c,403 :: 		ucPosition++;
ADDS	R7, R3, #1
UXTB	R7, R7
; ucPosition end address is: 12 (R3)
; ucPosition start address is: 28 (R7)
;uarthandler.c,404 :: 		break;
IT	AL
BAL	L_vUARTCommands272
; ucPosition end address is: 28 (R7)
;uarthandler.c,405 :: 		}
L_vUARTCommands274:
;uarthandler.c,406 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
; ucPosition start address is: 12 (R3)
; ucCounter start address is: 0 (R0)
ADD	R1, R9, R3, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands337
ADD	R1, R9, R3, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands336
IT	AL
BAL	L_vUARTCommands277
; pcInBuffer end address is: 36 (R9)
; ucCounter end address is: 0 (R0)
; ucPosition end address is: 12 (R3)
L__vUARTCommands337:
L__vUARTCommands336:
;uarthandler.c,408 :: 		return;
IT	AL
BAL	L_end_vUARTCommands
;uarthandler.c,409 :: 		}
L_vUARTCommands277:
;uarthandler.c,410 :: 		pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
; ucPosition start address is: 12 (R3)
; ucCounter start address is: 0 (R0)
; pcInBuffer start address is: 36 (R9)
ADD	R1, SP, #8
ADDS	R2, R1, R0
ADD	R1, R9, R3, LSL #0
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
ADDS	R2, R3, #1
UXTB	R2, R2
; ucPosition end address is: 12 (R3)
; ucPosition start address is: 8 (R2)
;uarthandler.c,401 :: 		for( ucCounter = 0; ; ucCounter++ ){
ADDS	R1, R0, #1
UXTB	R1, R1
; ucCounter end address is: 0 (R0)
; ucCounter start address is: 4 (R1)
;uarthandler.c,411 :: 		}
; ucPosition end address is: 8 (R2)
; ucCounter end address is: 4 (R1)
UXTB	R3, R2
UXTB	R0, R1
IT	AL
BAL	L_vUARTCommands271
L_vUARTCommands272:
;uarthandler.c,412 :: 		usTempNode = atoi( pcTempBuffer );
; ucPosition start address is: 28 (R7)
ADD	R1, SP, #8
MOV	R0, R1
BL	_atoi+0
;uarthandler.c,417 :: 		vBufferSetToZero( pcTempBuffer, 50 );
ADD	R1, SP, #8
MOV	R0, R1
MOVS	R1, #50
BL	_vBufferSetToZero+0
;uarthandler.c,418 :: 		for( ucCounter = 0; ; ucCounter++ ){
; ucCounter start address is: 0 (R0)
MOVS	R0, #0
; ucPosition end address is: 28 (R7)
; pcInBuffer end address is: 36 (R9)
; ucCounter end address is: 0 (R0)
UXTB	R3, R7
L_vUARTCommands278:
;uarthandler.c,419 :: 		if( pcInBuffer[ ucPosition ] == '|' ){
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 12 (R3)
; pcInBuffer start address is: 36 (R9)
ADD	R1, R9, R3, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #124
IT	NE
BNE	L_vUARTCommands281
; ucCounter end address is: 0 (R0)
;uarthandler.c,420 :: 		ucPosition++;
ADD	R10, R3, #1
UXTB	R10, R10
; ucPosition end address is: 12 (R3)
; ucPosition start address is: 40 (R10)
;uarthandler.c,421 :: 		break;
IT	AL
BAL	L_vUARTCommands279
; ucPosition end address is: 40 (R10)
;uarthandler.c,422 :: 		}
L_vUARTCommands281:
;uarthandler.c,423 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
; ucPosition start address is: 12 (R3)
; ucCounter start address is: 0 (R0)
ADD	R1, R9, R3, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands339
ADD	R1, R9, R3, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands338
IT	AL
BAL	L_vUARTCommands284
; pcInBuffer end address is: 36 (R9)
; ucCounter end address is: 0 (R0)
; ucPosition end address is: 12 (R3)
L__vUARTCommands339:
L__vUARTCommands338:
;uarthandler.c,425 :: 		return;
IT	AL
BAL	L_end_vUARTCommands
;uarthandler.c,426 :: 		}
L_vUARTCommands284:
;uarthandler.c,427 :: 		pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
; ucPosition start address is: 12 (R3)
; ucCounter start address is: 0 (R0)
; pcInBuffer start address is: 36 (R9)
ADD	R1, SP, #8
ADDS	R2, R1, R0
ADD	R1, R9, R3, LSL #0
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
ADDS	R2, R3, #1
UXTB	R2, R2
; ucPosition end address is: 12 (R3)
; ucPosition start address is: 8 (R2)
;uarthandler.c,418 :: 		for( ucCounter = 0; ; ucCounter++ ){
ADDS	R1, R0, #1
UXTB	R1, R1
; ucCounter end address is: 0 (R0)
; ucCounter start address is: 4 (R1)
;uarthandler.c,428 :: 		}
; ucPosition end address is: 8 (R2)
; ucCounter end address is: 4 (R1)
UXTB	R3, R2
UXTB	R0, R1
IT	AL
BAL	L_vUARTCommands278
L_vUARTCommands279:
;uarthandler.c,429 :: 		usTempTable = atoi( pcTempBuffer );
; ucPosition start address is: 40 (R10)
ADD	R1, SP, #8
MOV	R0, R1
BL	_atoi+0
;uarthandler.c,434 :: 		vBufferSetToZero( pcTempBuffer, 50 );
ADD	R1, SP, #8
MOV	R0, R1
MOVS	R1, #50
BL	_vBufferSetToZero+0
;uarthandler.c,435 :: 		for( ucCounter = 0; ; ucCounter++ ){
; ucCounter start address is: 0 (R0)
MOVS	R0, #0
; ucPosition end address is: 40 (R10)
; pcInBuffer end address is: 36 (R9)
; ucCounter end address is: 0 (R0)
L_vUARTCommands285:
;uarthandler.c,436 :: 		if( pcInBuffer[ ucPosition ] == '|' ){
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 40 (R10)
; pcInBuffer start address is: 36 (R9)
ADD	R1, R9, R10, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #124
IT	NE
BNE	L_vUARTCommands288
; ucCounter end address is: 0 (R0)
;uarthandler.c,437 :: 		ucPosition++;
ADD	R0, R10, #1
UXTB	R0, R0
; ucPosition end address is: 40 (R10)
; ucPosition start address is: 0 (R0)
;uarthandler.c,438 :: 		break;
UXTB	R7, R0
; ucPosition end address is: 0 (R0)
IT	AL
BAL	L_vUARTCommands286
;uarthandler.c,439 :: 		}
L_vUARTCommands288:
;uarthandler.c,440 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 40 (R10)
ADD	R1, R9, R10, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands341
ADD	R1, R9, R10, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands340
IT	AL
BAL	L_vUARTCommands291
; ucCounter end address is: 0 (R0)
L__vUARTCommands341:
L__vUARTCommands340:
;uarthandler.c,442 :: 		break;
UXTB	R7, R10
IT	AL
BAL	L_vUARTCommands286
;uarthandler.c,443 :: 		}
L_vUARTCommands291:
;uarthandler.c,444 :: 		pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
; ucCounter start address is: 0 (R0)
ADD	R1, SP, #8
ADDS	R2, R1, R0
ADD	R1, R9, R10, LSL #0
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
ADD	R3, R10, #1
UXTB	R3, R3
; ucPosition end address is: 40 (R10)
; ucPosition start address is: 12 (R3)
;uarthandler.c,435 :: 		for( ucCounter = 0; ; ucCounter++ ){
ADDS	R1, R0, #1
UXTB	R1, R1
; ucCounter end address is: 0 (R0)
; ucCounter start address is: 4 (R1)
;uarthandler.c,445 :: 		}
; ucPosition end address is: 12 (R3)
; ucCounter end address is: 4 (R1)
UXTB	R10, R3
UXTB	R0, R1
IT	AL
BAL	L_vUARTCommands285
L_vUARTCommands286:
;uarthandler.c,446 :: 		usTempCommand = atoi( pcTempBuffer );
; ucPosition start address is: 28 (R7)
ADD	R1, SP, #8
MOV	R0, R1
BL	_atoi+0
;uarthandler.c,451 :: 		vBufferSetToZero( pcTempBuffer, 50 );
ADD	R1, SP, #8
MOV	R0, R1
MOVS	R1, #50
BL	_vBufferSetToZero+0
;uarthandler.c,452 :: 		for( ucTempBufferLength = 0; ; ucTempBufferLength++ ){
; ucTempBufferLength start address is: 20 (R5)
MOVS	R5, #0
; ucTempBufferLength end address is: 20 (R5)
; ucPosition end address is: 28 (R7)
; pcInBuffer end address is: 36 (R9)
MOV	R4, R9
UXTB	R3, R7
UXTB	R0, R5
L_vUARTCommands292:
;uarthandler.c,453 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' || pcInBuffer[ ucPosition ] == '\0' ){
; ucTempBufferLength start address is: 0 (R0)
; ucPosition start address is: 12 (R3)
; pcInBuffer start address is: 16 (R4)
ADDS	R1, R4, R3
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands344
ADDS	R1, R4, R3
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands343
ADDS	R1, R4, R3
LDRB	R1, [R1, #0]
CMP	R1, #0
IT	EQ
BEQ	L__vUARTCommands342
IT	AL
BAL	L_vUARTCommands297
; ucTempBufferLength end address is: 0 (R0)
; ucPosition end address is: 12 (R3)
L__vUARTCommands344:
L__vUARTCommands343:
L__vUARTCommands342:
;uarthandler.c,455 :: 		break;
IT	AL
BAL	L_vUARTCommands293
;uarthandler.c,456 :: 		}
L_vUARTCommands297:
;uarthandler.c,457 :: 		pcTempBuffer[ ucTempBufferLength ] = pcInBuffer[ ucPosition++ ];
; ucPosition start address is: 12 (R3)
; ucTempBufferLength start address is: 0 (R0)
ADD	R1, SP, #8
ADDS	R2, R1, R0
ADDS	R1, R4, R3
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
ADDS	R1, R3, #1
; ucPosition end address is: 12 (R3)
; ucPosition start address is: 24 (R6)
UXTB	R6, R1
;uarthandler.c,452 :: 		for( ucTempBufferLength = 0; ; ucTempBufferLength++ ){
ADDS	R1, R0, #1
; ucTempBufferLength end address is: 0 (R0)
; ucTempBufferLength start address is: 20 (R5)
UXTB	R5, R1
;uarthandler.c,458 :: 		}
; ucPosition end address is: 24 (R6)
; ucTempBufferLength end address is: 20 (R5)
UXTB	R3, R6
UXTB	R0, R5
IT	AL
BAL	L_vUARTCommands292
L_vUARTCommands293:
;uarthandler.c,464 :: 		break;
MOV	R3, R4
; pcInBuffer end address is: 16 (R4)
IT	AL
BAL	L_vUARTCommands198
;uarthandler.c,465 :: 		default:
L_vUARTCommands298:
;uarthandler.c,467 :: 		break;
; pcInBuffer start address is: 28 (R7)
MOV	R3, R7
IT	AL
BAL	L_vUARTCommands198
;uarthandler.c,468 :: 		}
L_vUARTCommands197:
LDRB	R1, [SP, #68]
CMP	R1, #0
IT	EQ
BEQ	L_vUARTCommands199
LDRB	R1, [SP, #68]
CMP	R1, #1
IT	EQ
BEQ	L_vUARTCommands202
LDRB	R1, [SP, #68]
CMP	R1, #2
IT	EQ
BEQ	L_vUARTCommands209
LDRB	R1, [SP, #68]
CMP	R1, #3
IT	EQ
BEQ	L_vUARTCommands216
LDRB	R1, [SP, #68]
CMP	R1, #4
IT	EQ
BEQ	L_vUARTCommands217
LDRB	R1, [SP, #68]
CMP	R1, #5
IT	EQ
BEQ	L_vUARTCommands220
LDRB	R1, [SP, #68]
CMP	R1, #6
IT	EQ
BEQ	L_vUARTCommands221
LDRB	R1, [SP, #68]
CMP	R1, #7
IT	EQ
BEQ	L_vUARTCommands225
LDRB	R1, [SP, #68]
CMP	R1, #8
IT	EQ
BEQ	L_vUARTCommands232
LDRB	R1, [SP, #68]
CMP	R1, #11
IT	EQ
BEQ	L_vUARTCommands248
LDRB	R1, [SP, #68]
CMP	R1, #13
IT	EQ
BEQ	L_vUARTCommands249
LDRB	R1, [SP, #68]
CMP	R1, #14
IT	EQ
BEQ	L_vUARTCommands250
LDRB	R1, [SP, #68]
CMP	R1, #15
IT	EQ
BEQ	L_vUARTCommands251
LDRB	R1, [SP, #68]
CMP	R1, #16
IT	EQ
BEQ	L_vUARTCommands252
LDRB	R1, [SP, #68]
CMP	R1, #17
IT	EQ
BEQ	L_vUARTCommands253
LDRB	R1, [SP, #68]
CMP	R1, #18
IT	EQ
BEQ	L_vUARTCommands254
LDRB	R1, [SP, #68]
CMP	R1, #19
IT	EQ
BEQ	L_vUARTCommands255
LDRB	R1, [SP, #68]
CMP	R1, #20
IT	EQ
BEQ	L_vUARTCommands256
LDRB	R1, [SP, #68]
CMP	R1, #21
IT	EQ
BEQ	L_vUARTCommands263
IT	AL
BAL	L_vUARTCommands298
; pcInBuffer end address is: 28 (R7)
L_vUARTCommands198:
;uarthandler.c,469 :: 		}
; pcInBuffer start address is: 12 (R3)
; pcInBuffer end address is: 12 (R3)
IT	AL
BAL	L_vUARTCommands196
L__vUARTCommands345:
;uarthandler.c,166 :: 		if( strstr( pcInBuffer, pcUARTCommand[ ucCommandCounter ] ) ){
MOV	R3, R7
;uarthandler.c,469 :: 		}
L_vUARTCommands196:
;uarthandler.c,165 :: 		for( ucCommandCounter = 0; ucCommandCounter < UART_Commands; ucCommandCounter++ ){
; pcInBuffer start address is: 12 (R3)
LDRB	R1, [SP, #68]
ADDS	R1, R1, #1
STRB	R1, [SP, #68]
;uarthandler.c,470 :: 		}
MOV	R7, R3
; pcInBuffer end address is: 12 (R3)
IT	AL
BAL	L_vUARTCommands193
L_vUARTCommands194:
;uarthandler.c,471 :: 		}
L_end_vUARTCommands:
LDR	LR, [SP, #0]
ADD	SP, SP, #72
BX	LR
; end of _vUARTCommands
_Timer2_interrupt:
;DriverRF4463PROMain.c,16 :: 		void Timer2_interrupt() iv IVT_INT_TIM2 {
;DriverRF4463PROMain.c,17 :: 		TIM2_SR.UIF = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_SR+0)
MOVT	R0, #hi_addr(TIM2_SR+0)
_SX	[R0, ByteOffset(TIM2_SR+0)]
;DriverRF4463PROMain.c,18 :: 		Flag.rf_reach_timeout = 1; //Enter your code here
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,19 :: 		}
L_end_Timer2_interrupt:
BX	LR
; end of _Timer2_interrupt
_vRF4463MainCommandProcessor:
;DriverRF4463PROMain.c,22 :: 		void vRF4463MainCommandProcessor ( ) {
SUB	SP, SP, #4
;DriverRF4463PROMain.c,24 :: 		}
L_end_vRF4463MainCommandProcessor:
ADD	SP, SP, #4
BX	LR
; end of _vRF4463MainCommandProcessor
_InitTimer2:
;DriverRF4463PROMain.c,30 :: 		void InitTimer2(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;DriverRF4463PROMain.c,31 :: 		RCC_APB1ENR.TIM2EN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
_SX	[R0, ByteOffset(RCC_APB1ENR+0)]
;DriverRF4463PROMain.c,32 :: 		TIM2_CR1.CEN = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
_SX	[R0, ByteOffset(TIM2_CR1+0)]
;DriverRF4463PROMain.c,33 :: 		TIM2_PSC = 1124;
MOVW	R1, #1124
MOVW	R0, #lo_addr(TIM2_PSC+0)
MOVT	R0, #hi_addr(TIM2_PSC+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,34 :: 		TIM2_ARR = 63999;
MOVW	R1, #63999
MOVW	R0, #lo_addr(TIM2_ARR+0)
MOVT	R0, #hi_addr(TIM2_ARR+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,35 :: 		NVIC_IntEnable(IVT_INT_TIM2);
MOVW	R0, #44
BL	_NVIC_IntEnable+0
;DriverRF4463PROMain.c,36 :: 		TIM2_DIER.UIE = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
_SX	[R0, ByteOffset(TIM2_DIER+0)]
;DriverRF4463PROMain.c,37 :: 		TIM2_CR1.CEN = 1;
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
_SX	[R0, ByteOffset(TIM2_CR1+0)]
;DriverRF4463PROMain.c,38 :: 		}
L_end_InitTimer2:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _InitTimer2
_main:
;DriverRF4463PROMain.c,42 :: 		void main() {
SUB	SP, SP, #4
;DriverRF4463PROMain.c,44 :: 		Delay_ms( 2000 );                    // delay de depuracion
MOVW	R7, #13823
MOVT	R7, #366
NOP
NOP
L_main299:
SUBS	R7, R7, #1
BNE	L_main299
NOP
NOP
NOP
;DriverRF4463PROMain.c,48 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_6 );
MOVW	R1, #64
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,49 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_7 );
MOVW	R1, #128
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,50 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_8 );
MOVW	R1, #256
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,52 :: 		GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_7 );
MOVW	R1, #128
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,53 :: 		Sound_Init( &GPIOB_ODR, 7 );
MOVS	R1, #7
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
BL	_Sound_Init+0
;DriverRF4463PROMain.c,54 :: 		Sound_Play( 1000, 100 );
MOVS	R1, #100
MOVW	R0, #1000
BL	_Sound_Play+0
;DriverRF4463PROMain.c,56 :: 		LED_RED      = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,57 :: 		LED_GREEN    = 1;
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,58 :: 		LED_BLUE     = 1;
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,60 :: 		Delay_ms( 100 );
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_main301:
SUBS	R7, R7, #1
BNE	L_main301
NOP
NOP
NOP
;DriverRF4463PROMain.c,62 :: 		LED_RED      = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,63 :: 		LED_GREEN    = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,64 :: 		LED_BLUE     = 0;
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,66 :: 		InitTimer2();
BL	_InitTimer2+0
;DriverRF4463PROMain.c,69 :: 		vUARTTxInit();                // configura todos las parametros de USART
BL	_vUARTTxInit+0
;DriverRF4463PROMain.c,70 :: 		vSPI2Init();                  // configura todos los parametros de SPI
BL	_vSPI2Init+0
;DriverRF4463PROMain.c,75 :: 		freq3 = 9;
MOVS	R1, #9
MOVW	R0, #lo_addr(_freq3+0)
MOVT	R0, #hi_addr(_freq3+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,76 :: 		freq2 = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_freq2+0)
MOVT	R0, #hi_addr(_freq2+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,77 :: 		freq1 = 5;
MOVS	R1, #5
MOVW	R0, #lo_addr(_freq1+0)
MOVT	R0, #hi_addr(_freq1+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,80 :: 		power = 7;
MOVS	R1, #7
MOVW	R0, #lo_addr(_power+0)
MOVT	R0, #hi_addr(_power+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,82 :: 		rate  = dr_1p2;
MOVS	R1, #0
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,84 :: 		mode  = master_mode;          // para
MOVS	R1, #0
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,88 :: 		VRF4463SDNReset();
BL	_VRF4463SDNReset+0
;DriverRF4463PROMain.c,89 :: 		vRF4463Init();
BL	_vRF4463Init+0
;DriverRF4463PROMain.c,93 :: 		LED_GREEN    = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,94 :: 		LED_BLUE     = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,96 :: 		while ( 1 ) {
L_main303:
;DriverRF4463PROMain.c,99 :: 		if ( mode == master_mode ) {
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main305
;DriverRF4463PROMain.c,100 :: 		vRF4463TxData();
BL	_vRF4463TxData+0
;DriverRF4463PROMain.c,101 :: 		}
IT	AL
BAL	L_main306
L_main305:
;DriverRF4463PROMain.c,102 :: 		else if ( mode == slave_mode ) {
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main307
;DriverRF4463PROMain.c,103 :: 		vRF4463RxStart();
BL	_vRF4463RxStart+0
;DriverRF4463PROMain.c,104 :: 		}
L_main307:
L_main306:
;DriverRF4463PROMain.c,106 :: 		}
IT	AL
BAL	L_main303
;DriverRF4463PROMain.c,107 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
