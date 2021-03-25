_Int_SPI1:
;driverspi.c,11 :: 		void Int_SPI1() iv IVT_INT_SPI1 ics ICS_AUTO {
;driverspi.c,13 :: 		if ( SPI1_SRbits.RXNE ) {
MOVW	R0, #lo_addr(SPI1_SRbits+0)
MOVT	R0, #hi_addr(SPI1_SRbits+0)
_LX	[R0, ByteOffset(SPI1_SRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_Int_SPI10
;driverspi.c,14 :: 		ucSPI1ByteReceived = ( unsigned char )SPI1_DR;      // lee el Byte recibido
MOVW	R0, #lo_addr(SPI1_DR+0)
MOVT	R0, #hi_addr(SPI1_DR+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucSPI1ByteReceived+0)
MOVT	R0, #hi_addr(_ucSPI1ByteReceived+0)
STRB	R1, [R0, #0]
;driverspi.c,17 :: 		}
L_Int_SPI10:
;driverspi.c,18 :: 		}
L_end_Int_SPI1:
BX	LR
; end of _Int_SPI1
_vSPI1Init:
;driverspi.c,22 :: 		void vSPI1Init ( void ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;driverspi.c,24 :: 		_SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI1_PB345 );
MOVW	R2, #lo_addr(__GPIO_MODULE_SPI1_PB345+0)
MOVT	R2, #hi_addr(__GPIO_MODULE_SPI1_PB345+0)
MOVW	R1, #772
;driverspi.c,23 :: 		SPI1_Init_Advanced( _SPI_FPCLK_DIV64, _SPI_MASTER | _SPI_8_BIT | _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION |
MOVS	R0, #5
;driverspi.c,24 :: 		_SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI1_PB345 );
BL	_SPI1_Init_Advanced+0
;driverspi.c,26 :: 		SPI1_CR2bits.RXNEIE  = 1;       // habilitacion de ISR para RX
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(SPI1_CR2bits+0)
MOVT	R0, #hi_addr(SPI1_CR2bits+0)
_SX	[R0, ByteOffset(SPI1_CR2bits+0)]
;driverspi.c,28 :: 		NVIC_IntEnable( IVT_INT_SPI1 );
MOVW	R0, #51
BL	_NVIC_IntEnable+0
;driverspi.c,29 :: 		}
L_end_vSPI1Init:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vSPI1Init
_vRF4463ISR:
;driverrf4463pro.c,29 :: 		void vRF4463ISR() iv IVT_INT_EXTI0 ics ICS_AUTO{
SUB	SP, SP, #4
STR	LR, [SP, #0]
;driverrf4463pro.c,30 :: 		if( EXTI_PR.B0 ){
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_LX	[R0, ByteOffset(EXTI_PR+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463ISR1
;driverrf4463pro.c,31 :: 		EXTI_PR.B0 |= 1;
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_LX	[R0, ByteOffset(EXTI_PR+0)]
ORR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_SX	[R0, ByteOffset(EXTI_PR+0)]
;driverrf4463pro.c,32 :: 		LED_GREEN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_SX	[R0, ByteOffset(GPIOE_ODRbits+0)]
;driverrf4463pro.c,33 :: 		ucRF4463IRQ = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
STRB	R1, [R0, #0]
;driverrf4463pro.c,34 :: 		vRF4463ClearInterrupts();
BL	_vRF4463ClearInterrupts+0
;driverrf4463pro.c,35 :: 		}
L_vRF4463ISR1:
;driverrf4463pro.c,36 :: 		}
L_end_vRF4463ISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vRF4463ISR
_vRF4463Init:
;driverrf4463pro.c,42 :: 		void vRF4463Init ( void ) {  // MODE,
SUB	SP, SP, #28
STR	LR, [SP, #0]
;driverrf4463pro.c,45 :: 		for ( i = 4; i < 16; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init2:
LDRB	R0, [SP, #24]
CMP	R0, #16
IT	CS
BCS	L_vRF4463Init3
;driverrf4463pro.c,46 :: 		RF_MODEM_MOD_TYPE_12_data[ i ] = RF_MODEM_MOD_TYPE_12[ ucRF4463Rate ][ i - 4 ];
LDRB	R1, [SP, #24]
MOVW	R0, #lo_addr(_RF_MODEM_MOD_TYPE_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_MOD_TYPE_12_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #12
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_MOD_TYPE_12+0)
MOVT	R0, #hi_addr(_RF_MODEM_MOD_TYPE_12+0)
ADDS	R2, R0, R1
LDRB	R0, [SP, #24]
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,45 :: 		for ( i = 4; i < 16; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,47 :: 		}
IT	AL
BAL	L_vRF4463Init2
L_vRF4463Init3:
;driverrf4463pro.c,50 :: 		if ( ucRF4463Freq3 < 8 ) {
MOVW	R0, #lo_addr(_ucRF4463Freq3+0)
MOVT	R0, #hi_addr(_ucRF4463Freq3+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CS
BCS	L_vRF4463Init5
;driverrf4463pro.c,51 :: 		for ( i = 4; i < 12; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init6:
LDRB	R0, [SP, #24]
CMP	R0, #12
IT	CS
BCS	L_vRF4463Init7
;driverrf4463pro.c,52 :: 		RF_MODEM_TX_RAMP_DELAY_8_data[ i ] = RF_MODEM_TX_RAMP_DELAY_8_433[ ucRF4463Rate ][ i - 4 ];
LDRB	R1, [SP, #24]
MOVW	R0, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #8
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_433+0)
ADDS	R2, R0, R1
LDRB	R0, [SP, #24]
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,51 :: 		for ( i = 4; i < 12; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,53 :: 		}
IT	AL
BAL	L_vRF4463Init6
L_vRF4463Init7:
;driverrf4463pro.c,54 :: 		for ( i = 4; i < 11; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init9:
LDRB	R0, [SP, #24]
CMP	R0, #11
IT	CS
BCS	L_vRF4463Init10
;driverrf4463pro.c,55 :: 		RF_MODEM_AFC_GEAR_7_data[ i ] = RF_MODEM_AFC_GEAR_7_433[ ucRF4463Rate ][ i - 4 ];
LDRB	R1, [SP, #24]
MOVW	R0, #lo_addr(_RF_MODEM_AFC_GEAR_7_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AFC_GEAR_7_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #7
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_AFC_GEAR_7_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_AFC_GEAR_7_433+0)
ADDS	R2, R0, R1
LDRB	R0, [SP, #24]
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,54 :: 		for ( i = 4; i < 11; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,56 :: 		}
IT	AL
BAL	L_vRF4463Init9
L_vRF4463Init10:
;driverrf4463pro.c,57 :: 		for ( i = 4; i < 15; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init12:
LDRB	R0, [SP, #24]
CMP	R0, #15
IT	CS
BCS	L_vRF4463Init13
;driverrf4463pro.c,58 :: 		RF_MODEM_OOK_CNT1_11_data[ i ] = RF_MODEM_OOK_CNT1_11_433[ ucRF4463Rate ][ i - 4 ];
LDRB	R1, [SP, #24]
MOVW	R0, #lo_addr(_RF_MODEM_OOK_CNT1_11_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_OOK_CNT1_11_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #11
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_OOK_CNT1_11_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_OOK_CNT1_11_433+0)
ADDS	R2, R0, R1
LDRB	R0, [SP, #24]
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,57 :: 		for ( i = 4; i < 15; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,59 :: 		}
IT	AL
BAL	L_vRF4463Init12
L_vRF4463Init13:
;driverrf4463pro.c,60 :: 		for ( i = 4; i < 16; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init15:
LDRB	R0, [SP, #24]
CMP	R0, #16
IT	CS
BCS	L_vRF4463Init16
;driverrf4463pro.c,61 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433[ ucRF4463Rate ][ i - 4 ];
LDRB	R1, [SP, #24]
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #12
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433+0)
ADDS	R2, R0, R1
LDRB	R0, [SP, #24]
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,60 :: 		for ( i = 4; i < 16; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,62 :: 		}
IT	AL
BAL	L_vRF4463Init15
L_vRF4463Init16:
;driverrf4463pro.c,63 :: 		for ( i = 4; i < 16; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init18:
LDRB	R0, [SP, #24]
CMP	R0, #16
IT	CS
BCS	L_vRF4463Init19
;driverrf4463pro.c,64 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433[ ucRF4463Rate ][ i - 4 ];
LDRB	R1, [SP, #24]
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #12
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433+0)
ADDS	R2, R0, R1
LDRB	R0, [SP, #24]
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,63 :: 		for ( i = 4; i < 16; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,65 :: 		}
IT	AL
BAL	L_vRF4463Init18
L_vRF4463Init19:
;driverrf4463pro.c,66 :: 		for ( i = 4; i < 16; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init21:
LDRB	R0, [SP, #24]
CMP	R0, #16
IT	CS
BCS	L_vRF4463Init22
;driverrf4463pro.c,67 :: 		RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433[ ucRF4463Rate ][ i - 4 ];
LDRB	R1, [SP, #24]
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #12
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433+0)
ADDS	R2, R0, R1
LDRB	R0, [SP, #24]
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,66 :: 		for ( i = 4; i < 16; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,68 :: 		}
IT	AL
BAL	L_vRF4463Init21
L_vRF4463Init22:
;driverrf4463pro.c,69 :: 		for ( i = 4; i < 13; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init24:
LDRB	R0, [SP, #24]
CMP	R0, #13
IT	CS
BCS	L_vRF4463Init25
;driverrf4463pro.c,70 :: 		RF_MODEM_AGC_WINDOW_SIZE_9_data[ i ] = RF_MODEM_AGC_WINDOW_SIZE_9_433[ ucRF4463Rate ][ i - 4 ];
LDRB	R1, [SP, #24]
MOVW	R0, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #9
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_433+0)
ADDS	R2, R0, R1
LDRB	R0, [SP, #24]
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,69 :: 		for ( i = 4; i < 13; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,71 :: 		}
IT	AL
BAL	L_vRF4463Init24
L_vRF4463Init25:
;driverrf4463pro.c,72 :: 		for ( i = 4; i < 13; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init27:
LDRB	R0, [SP, #24]
CMP	R0, #13
IT	CS
BCS	L_vRF4463Init28
;driverrf4463pro.c,73 :: 		RF_MODEM_BCR_OSR_1_9_data[ i ] = RF_MODEM_BCR_OSR_1_9_433[ ucRF4463Rate ][ i - 4 ];
LDRB	R1, [SP, #24]
MOVW	R0, #lo_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #9
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_BCR_OSR_1_9_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_BCR_OSR_1_9_433+0)
ADDS	R2, R0, R1
LDRB	R0, [SP, #24]
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,72 :: 		for ( i = 4; i < 13; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,74 :: 		}
IT	AL
BAL	L_vRF4463Init27
L_vRF4463Init28:
;driverrf4463pro.c,75 :: 		}
IT	AL
BAL	L_vRF4463Init30
L_vRF4463Init5:
;driverrf4463pro.c,77 :: 		for ( i = 4; i < 12; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init31:
LDRB	R0, [SP, #24]
CMP	R0, #12
IT	CS
BCS	L_vRF4463Init32
;driverrf4463pro.c,78 :: 		RF_MODEM_TX_RAMP_DELAY_8_data[ i ] = RF_MODEM_TX_RAMP_DELAY_8_850[ ucRF4463Rate ][ i - 4 ];
LDRB	R1, [SP, #24]
MOVW	R0, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #8
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_850+0)
ADDS	R2, R0, R1
LDRB	R0, [SP, #24]
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,77 :: 		for ( i = 4; i < 12; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,79 :: 		}
IT	AL
BAL	L_vRF4463Init31
L_vRF4463Init32:
;driverrf4463pro.c,80 :: 		for ( i = 4; i < 11; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init34:
LDRB	R0, [SP, #24]
CMP	R0, #11
IT	CS
BCS	L_vRF4463Init35
;driverrf4463pro.c,81 :: 		RF_MODEM_AFC_GEAR_7_data[ i ] = RF_MODEM_AFC_GEAR_7_850[ ucRF4463Rate ][ i - 4 ];
LDRB	R1, [SP, #24]
MOVW	R0, #lo_addr(_RF_MODEM_AFC_GEAR_7_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AFC_GEAR_7_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #7
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_AFC_GEAR_7_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_AFC_GEAR_7_850+0)
ADDS	R2, R0, R1
LDRB	R0, [SP, #24]
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,80 :: 		for ( i = 4; i < 11; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,82 :: 		}
IT	AL
BAL	L_vRF4463Init34
L_vRF4463Init35:
;driverrf4463pro.c,83 :: 		for ( i = 4; i < 15; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init37:
LDRB	R0, [SP, #24]
CMP	R0, #15
IT	CS
BCS	L_vRF4463Init38
;driverrf4463pro.c,84 :: 		RF_MODEM_OOK_CNT1_11_data[ i ] = RF_MODEM_OOK_CNT1_11_850[ ucRF4463Rate ][ i - 4 ];
LDRB	R1, [SP, #24]
MOVW	R0, #lo_addr(_RF_MODEM_OOK_CNT1_11_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_OOK_CNT1_11_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #11
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_OOK_CNT1_11_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_OOK_CNT1_11_850+0)
ADDS	R2, R0, R1
LDRB	R0, [SP, #24]
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,83 :: 		for ( i = 4; i < 15; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,85 :: 		}
IT	AL
BAL	L_vRF4463Init37
L_vRF4463Init38:
;driverrf4463pro.c,86 :: 		for ( i = 4; i < 16; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init40:
LDRB	R0, [SP, #24]
CMP	R0, #16
IT	CS
BCS	L_vRF4463Init41
;driverrf4463pro.c,87 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850[ ucRF4463Rate ][ i - 4 ];
LDRB	R1, [SP, #24]
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #12
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850+0)
ADDS	R2, R0, R1
LDRB	R0, [SP, #24]
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,86 :: 		for ( i = 4; i < 16; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,88 :: 		}
IT	AL
BAL	L_vRF4463Init40
L_vRF4463Init41:
;driverrf4463pro.c,89 :: 		for ( i = 4; i < 16; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init43:
LDRB	R0, [SP, #24]
CMP	R0, #16
IT	CS
BCS	L_vRF4463Init44
;driverrf4463pro.c,90 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850[ ucRF4463Rate ][ i - 4 ];
LDRB	R1, [SP, #24]
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #12
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850+0)
ADDS	R2, R0, R1
LDRB	R0, [SP, #24]
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,89 :: 		for ( i = 4; i < 16; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,91 :: 		}
IT	AL
BAL	L_vRF4463Init43
L_vRF4463Init44:
;driverrf4463pro.c,92 :: 		for ( i = 4; i < 16; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init46:
LDRB	R0, [SP, #24]
CMP	R0, #16
IT	CS
BCS	L_vRF4463Init47
;driverrf4463pro.c,93 :: 		RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850[ ucRF4463Rate ][ i - 4 ];
LDRB	R1, [SP, #24]
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #12
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850+0)
ADDS	R2, R0, R1
LDRB	R0, [SP, #24]
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,92 :: 		for ( i = 4; i < 16; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,94 :: 		}
IT	AL
BAL	L_vRF4463Init46
L_vRF4463Init47:
;driverrf4463pro.c,95 :: 		for ( i = 4; i < 13; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init49:
LDRB	R0, [SP, #24]
CMP	R0, #13
IT	CS
BCS	L_vRF4463Init50
;driverrf4463pro.c,96 :: 		RF_MODEM_AGC_WINDOW_SIZE_9_data[ i ] = RF_MODEM_AGC_WINDOW_SIZE_9_850[ ucRF4463Rate ][ i - 4 ];
LDRB	R1, [SP, #24]
MOVW	R0, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #9
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_850+0)
ADDS	R2, R0, R1
LDRB	R0, [SP, #24]
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,95 :: 		for ( i = 4; i < 13; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,97 :: 		}
IT	AL
BAL	L_vRF4463Init49
L_vRF4463Init50:
;driverrf4463pro.c,98 :: 		for ( i = 4; i < 13; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init52:
LDRB	R0, [SP, #24]
CMP	R0, #13
IT	CS
BCS	L_vRF4463Init53
;driverrf4463pro.c,99 :: 		RF_MODEM_BCR_OSR_1_9_data[ i ] = RF_MODEM_BCR_OSR_1_9_850[ ucRF4463Rate ][ i - 4 ];
LDRB	R1, [SP, #24]
MOVW	R0, #lo_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #9
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_BCR_OSR_1_9_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_BCR_OSR_1_9_850+0)
ADDS	R2, R0, R1
LDRB	R0, [SP, #24]
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,98 :: 		for ( i = 4; i < 13; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,100 :: 		}
IT	AL
BAL	L_vRF4463Init52
L_vRF4463Init53:
;driverrf4463pro.c,101 :: 		}
L_vRF4463Init30:
;driverrf4463pro.c,102 :: 		for ( i = 4; i < 11; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init55:
LDRB	R0, [SP, #24]
CMP	R0, #11
IT	CS
BCS	L_vRF4463Init56
;driverrf4463pro.c,103 :: 		RF_SYNTH_PFDCP_CPFF_7_data[ i ] = RF_SYNTH_PFDCP_CPFF_7[ ucRF4463Rate ][ i - 4 ];
LDRB	R1, [SP, #24]
MOVW	R0, #lo_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
MOVT	R0, #hi_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R0, #0]
MOVS	R0, #7
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_SYNTH_PFDCP_CPFF_7+0)
MOVT	R0, #hi_addr(_RF_SYNTH_PFDCP_CPFF_7+0)
ADDS	R2, R0, R1
LDRB	R0, [SP, #24]
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,102 :: 		for ( i = 4; i < 11; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,104 :: 		}
IT	AL
BAL	L_vRF4463Init55
L_vRF4463Init56:
;driverrf4463pro.c,108 :: 		vRF4463GPIO_SET( ucRF4463Mode );                              // PARAMETRO CONFIGURABLE
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
PUSH	(R0)
BL	_vRF4463GPIO_SET+0
ADD	SP, SP, #4
;driverrf4463pro.c,111 :: 		app_command_buf[ 0 ] = 0x11;    // SET PROPERTY
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,112 :: 		app_command_buf[ 1 ] = 0x00;    // 0x0000
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,113 :: 		app_command_buf[ 2 ] = 0x01;    // Total 1 Parameters
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,114 :: 		app_command_buf[ 3 ] = 0x00;    // 0x0000
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,115 :: 		app_command_buf[ 4 ] = 98;      // freq  adjustment    ( rango desde 0 - 127 Low cap - High Cap )
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #98
STRB	R0, [R1, #0]
;driverrf4463pro.c,116 :: 		spi_write( 5, app_command_buf );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,119 :: 		app_command_buf[ 0 ] = 0x11;    // SET PROPERTY
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,120 :: 		app_command_buf[ 1 ] = 0x00;    // 0x0003
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,121 :: 		app_command_buf[ 2 ] = 0x01;    // Total 1 Parameters
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,122 :: 		app_command_buf[ 3 ] = 0x03;    // 0x0003
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,123 :: 		app_command_buf[ 4 ] = 0x40;    // tx = rx = 64 byte, ordinary PH,high performance mode  ?????????????????????
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #64
STRB	R0, [R1, #0]
;driverrf4463pro.c,124 :: 		spi_write( 5, app_command_buf );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,128 :: 		spi_write( 0x08, RF_FRR_CTL_A_MODE_4_data );    // disable all fast response register
MOVW	R0, #lo_addr(_RF_FRR_CTL_A_MODE_4_data+0)
MOVT	R0, #hi_addr(_RF_FRR_CTL_A_MODE_4_data+0)
PUSH	(R0)
MOVS	R0, #8
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,131 :: 		app_command_buf[ 0 ] = 0x11;    // SET PROPERTY
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,132 :: 		app_command_buf[ 1 ] = 0x10;    // 0x1000
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #16
STRB	R0, [R1, #0]
;driverrf4463pro.c,133 :: 		app_command_buf[ 2 ] = 0x09;    // Total 9 Parameters
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #9
STRB	R0, [R1, #0]
;driverrf4463pro.c,134 :: 		app_command_buf[ 3 ] = 0x00;    // 0x1000
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,136 :: 		if ( ucRF4463Mode == tx_test_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
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
;driverrf4463pro.c,144 :: 		app_command_buf[ 5 ]   = 0x14;       // To detect 20 bit sync word,
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #20
STRB	R0, [R1, #0]
;driverrf4463pro.c,145 :: 		app_command_buf[ 6 ]   = 0x00;       // Non-standard preamble settings, useless
ADD	R0, SP, #4
ADDS	R1, R0, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,146 :: 		app_command_buf[ 7 ]   = 0x0f;       // Time of the preamble Timeout   ????????????????????????????????????????????????????????????
ADD	R0, SP, #4
ADDS	R1, R0, #7
MOVS	R0, #15
STRB	R0, [R1, #0]
;driverrf4463pro.c,147 :: 		app_command_buf[ 8 ]   = 0x31;       // The length of the preamble is   byte Calculation , 1st = 1 NO manchest  Encoding, using standard 1010.??
ADD	R0, SP, #4
ADDW	R1, R0, #8
MOVS	R0, #49
STRB	R0, [R1, #0]
;driverrf4463pro.c,148 :: 		app_command_buf[ 9 ]   = 0x0;        // Non-standard Preamble Patten 4th byte
ADD	R0, SP, #4
ADDW	R1, R0, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,149 :: 		app_command_buf[ 10 ]  = 0x00;       // Non-standard Preamble Patten 3rd byte
ADD	R0, SP, #4
ADDW	R1, R0, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,150 :: 		app_command_buf[ 11 ]  = 0x00;       // Non-standard Preamble Patten 2nd byte
ADD	R0, SP, #4
ADDW	R1, R0, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,151 :: 		app_command_buf[ 12 ]  = 0x00;       // Non-standard Preamble Patten 1st byte
ADD	R0, SP, #4
ADDW	R1, R0, #12
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,152 :: 		spi_write(13, app_command_buf);
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #13
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,155 :: 		app_command_buf[ 0 ] = 0x11;         // SET PROPERTY
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,156 :: 		app_command_buf[ 1 ] = 0x11;         // command = 0x1100
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,157 :: 		app_command_buf[ 2 ] = 0x05;         // Total 5 Parameters
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #5
STRB	R0, [R1, #0]
;driverrf4463pro.c,158 :: 		app_command_buf[ 3 ] = 0x00;         // command = 0x1100
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,159 :: 		app_command_buf[ 4 ] = 0x01;         // The synchronization word is defined and sent in the length field, and the synchronization word cannot be wrong,Not 4FSK, not manchest encoding, only 2 bytes
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,161 :: 		if ( ucRF4463Mode == tx_test_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_vRF4463Init60
;driverrf4463pro.c,162 :: 		app_command_buf[ 5 ] = 0x55;      // Sync word 3
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #85
STRB	R0, [R1, #0]
;driverrf4463pro.c,163 :: 		app_command_buf[ 6 ] = 0x55;      // Sync word 2
ADD	R0, SP, #4
ADDS	R1, R0, #6
MOVS	R0, #85
STRB	R0, [R1, #0]
;driverrf4463pro.c,164 :: 		}
IT	AL
BAL	L_vRF4463Init61
L_vRF4463Init60:
;driverrf4463pro.c,166 :: 		app_command_buf[ 5 ] = 0x2d;    // Sync word 3
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #45
STRB	R0, [R1, #0]
;driverrf4463pro.c,167 :: 		app_command_buf[ 6 ] = 0xd4;    // Sync word 2
ADD	R0, SP, #4
ADDS	R1, R0, #6
MOVS	R0, #212
STRB	R0, [R1, #0]
;driverrf4463pro.c,168 :: 		}
L_vRF4463Init61:
;driverrf4463pro.c,170 :: 		app_command_buf[ 7 ] =  0x00;        // Sync word 1
ADD	R0, SP, #4
ADDS	R1, R0, #7
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,171 :: 		app_command_buf[ 8 ] = 0x00;         // Sync word 0
ADD	R0, SP, #4
ADDW	R1, R0, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,172 :: 		spi_write( 9, app_command_buf );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #9
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,175 :: 		app_command_buf[ 0 ] = 0x11;        // SET PROPERTY
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,176 :: 		app_command_buf[ 1 ] = 0x12;        // command = 0x1200
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,177 :: 		app_command_buf[ 2 ] = 0x01;        // Total 1 Parameters
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,178 :: 		app_command_buf[ 3 ] = 0x00;        // command = 0x1200
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,179 :: 		app_command_buf[ 4 ] = 0x85;        // 1?cRC ??,CRC = itu-c, enable crc   ( original 0x81; )
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #133
STRB	R0, [R1, #0]
;driverrf4463pro.c,180 :: 		spi_write( 5, app_command_buf );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,183 :: 		app_command_buf[ 0 ] = 0x11;        // SET PROPERTY
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,184 :: 		app_command_buf[ 1 ] = 0x12;        // command = 0x1206
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,185 :: 		app_command_buf[ 2 ] = 0x01;        // Total 1Parameters
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,186 :: 		app_command_buf[ 3 ] = 0x06;        // command = 0x1206
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #6
STRB	R0, [R1, #0]
;driverrf4463pro.c,187 :: 		app_command_buf[ 4 ] = 0x02;        //  tx = rx = 120d--1220 (tx packet,ph enable, not 4fsk, After receiving a packet of data,RX off,CRC Do not flip ,CRC MSB, data MSB
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,188 :: 		spi_write( 5, app_command_buf );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,191 :: 		app_command_buf[ 0 ] = 0x11;        // SET PROPERTY
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,192 :: 		app_command_buf[ 1 ] = 0x12;        // command = 0x1208
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,193 :: 		app_command_buf[ 2 ] = 0x03;        // Total 3 Parameters
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,194 :: 		app_command_buf[ 3 ] = 0x08;        // command = 0x1208
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,195 :: 		app_command_buf[ 4 ] = 0x00;        // Length Field = LSB,  length Only 1 byte,length Not put In FiFo, fixed packet length mode
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,196 :: 		app_command_buf[ 5 ] = 0x00;        // Used for variable packet length mode, which defines which Field contains length Filed
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,197 :: 		app_command_buf[ 6 ] = 0x00;        // Used for variable packet length mode, adjust the length of variable packet length
ADD	R0, SP, #4
ADDS	R1, R0, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,198 :: 		spi_write( 7, app_command_buf );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #7
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,201 :: 		app_command_buf[ 0 ]  = 0x11;
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,202 :: 		app_command_buf[ 1 ]  = 0x12;       // 0x120d
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,203 :: 		app_command_buf[ 2 ]  = 0x0c;       // Total 12 Parameters
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #12
STRB	R0, [R1, #0]
;driverrf4463pro.c,204 :: 		app_command_buf[ 3 ]  = 0x0d;       // 0x120d
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #13
STRB	R0, [R1, #0]
;driverrf4463pro.c,205 :: 		app_command_buf[ 4 ]  = 0x00;       //  Field 1 length (?4?)
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,206 :: 		app_command_buf[ 5 ]  = payload_length;   //  field 1 length, (? 8?), ?Total14???
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #66
STRB	R0, [R1, #0]
;driverrf4463pro.c,207 :: 		app_command_buf[ 6 ]  = 0x04;       // field 1 Is not 4FSK,manchest, whiting, PN9,
ADD	R0, SP, #4
ADDS	R1, R0, #6
MOVS	R0, #4
STRB	R0, [R1, #0]
;driverrf4463pro.c,208 :: 		app_command_buf[ 7 ]  = 0xaa;       // field 1 crc enble, check enbale, There are also launchingCRC,cRC?Seed ?CRC_seed?????
ADD	R0, SP, #4
ADDS	R1, R0, #7
MOVS	R0, #170
STRB	R0, [R1, #0]
;driverrf4463pro.c,209 :: 		app_command_buf[ 8 ]  = 0x00;       //  field 2 length(?4?)
ADD	R0, SP, #4
ADDW	R1, R0, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,210 :: 		app_command_buf[ 9 ]  = 0x00;           //  field 2 length, (? 8?), length = 0 Means thisfield did not use
ADD	R0, SP, #4
ADDW	R1, R0, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,211 :: 		app_command_buf[ 10 ] = 0x00;       // field 2 Is not 4FSK,manchest, whiting, PN9
ADD	R0, SP, #4
ADDW	R1, R0, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,212 :: 		app_command_buf[ 11 ] = 0x00;       //  field 2 ?CRCSet up
ADD	R0, SP, #4
ADDW	R1, R0, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,213 :: 		app_command_buf[ 12 ] = 0x00;       //  field 3 length, (? 8?), length = 0 Means thisfield did not use
ADD	R0, SP, #4
ADDW	R1, R0, #12
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,214 :: 		app_command_buf[ 13 ] = 0x00;           //  field 3 length, (? 8?), length = 0 Means thisfield did not use
ADD	R0, SP, #4
ADDW	R1, R0, #13
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,215 :: 		app_command_buf[ 14 ] = 0x00;       //  field 3 Is not 4FSK,manchest, whiting, PN9
ADD	R0, SP, #4
ADDW	R1, R0, #14
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,216 :: 		app_command_buf[ 15 ] = 0x00;       //  field 3 ?CRCSet up
ADD	R0, SP, #4
ADDW	R1, R0, #15
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,217 :: 		spi_write( 16, app_command_buf );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #16
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,220 :: 		app_command_buf[ 0 ]  = 0x11;
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,221 :: 		app_command_buf[ 1 ]  = 0x12;       // 0x1219
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,222 :: 		app_command_buf[ 2 ]  = 0x08;       // Total 8Parameters
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,223 :: 		app_command_buf[ 3 ]  = 0x19;       // 0x1219
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #25
STRB	R0, [R1, #0]
;driverrf4463pro.c,224 :: 		app_command_buf[ 4 ]  = 0x00;       // field4 length(?4?)
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,225 :: 		app_command_buf[ 5 ]  = 0x00;       // field 4 length, (? 8?), length = 0 Means this field did not use
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,226 :: 		app_command_buf[ 6 ]  = 0x00;       // field 4 Is not 4FSK,manchest, whiting, PN9
ADD	R0, SP, #4
ADDS	R1, R0, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,227 :: 		app_command_buf[ 7 ]  = 0x00;       // field 4 ?CRCSet up
ADD	R0, SP, #4
ADDS	R1, R0, #7
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,228 :: 		app_command_buf[ 8 ]  = 0x00;       // field5 length(?4?)
ADD	R0, SP, #4
ADDW	R1, R0, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,229 :: 		app_command_buf[ 9 ]  = 0x00;       // field 5 length, (? 8?), length = 0 Means this field did not use
ADD	R0, SP, #4
ADDW	R1, R0, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,230 :: 		app_command_buf[ 10 ] = 0x00;       // field 5 Is not 4FSK,manchest, whiting, PN9
ADD	R0, SP, #4
ADDW	R1, R0, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,231 :: 		app_command_buf[ 11 ] = 0x00;       // field 5 ?CRCSet up
ADD	R0, SP, #4
ADDW	R1, R0, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,232 :: 		spi_write( 12, app_command_buf );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #12
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,235 :: 		spi_write( 0x10, RF_MODEM_MOD_TYPE_12_data );   // //  2FSK ,  module source = PH fifo, disable manchest, tx, rx Do not flip, deviation Do not flip
MOVW	R0, #lo_addr(_RF_MODEM_MOD_TYPE_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_MOD_TYPE_12_data+0)
PUSH	(R0)
MOVS	R0, #16
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,238 :: 		app_command_buf[0] = 0x11;
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,239 :: 		app_command_buf[1]  = 0x20;    // 0x200c
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,240 :: 		app_command_buf[2]  = 0x01;    // Total 1Parameters
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,241 :: 		app_command_buf[3]  = 0x0c;   // 0x200c
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #12
STRB	R0, [R1, #0]
;driverrf4463pro.c,243 :: 		if ( ucRF4463Freq3 < 8 ) {
MOVW	R0, #lo_addr(_ucRF4463Freq3+0)
MOVT	R0, #hi_addr(_ucRF4463Freq3+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CS
BCS	L_vRF4463Init62
;driverrf4463pro.c,244 :: 		if ( ucRF4463Rate >= dr_256k ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
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
;driverrf4463pro.c,247 :: 		else if ( ucRF4463Rate >= dr_19p2 ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
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
;driverrf4463pro.c,251 :: 		app_command_buf[ 4 ]  = 0xd2;
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
;driverrf4463pro.c,255 :: 		if ( ucRF4463Rate >= dr_115p2 ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	CC
BCC	L_vRF4463Init68
;driverrf4463pro.c,256 :: 		app_command_buf[ 4 ]  = 0x69;        // 15k
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #105
STRB	R0, [R1, #0]
;driverrf4463pro.c,257 :: 		}
IT	AL
BAL	L_vRF4463Init69
L_vRF4463Init68:
;driverrf4463pro.c,258 :: 		else if ( ucRF4463Rate >= dr_19p2 ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	CC
BCC	L_vRF4463Init70
;driverrf4463pro.c,259 :: 		app_command_buf[ 4 ]  = 0x5e;        // 10k
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #94
STRB	R0, [R1, #0]
;driverrf4463pro.c,260 :: 		}
IT	AL
BAL	L_vRF4463Init71
L_vRF4463Init70:
;driverrf4463pro.c,262 :: 		app_command_buf[ 4 ]  = 0x18; // 8k
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #24
STRB	R0, [R1, #0]
;driverrf4463pro.c,263 :: 		}
L_vRF4463Init71:
L_vRF4463Init69:
;driverrf4463pro.c,264 :: 		}
L_vRF4463Init67:
;driverrf4463pro.c,265 :: 		spi_write( 5, app_command_buf );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,268 :: 		spi_write( 0x0C, RF_MODEM_TX_RAMP_DELAY_8_data );            // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
PUSH	(R0)
MOVS	R0, #12
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,269 :: 		spi_write( 0x0D, RF_MODEM_BCR_OSR_1_9_data );                // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
PUSH	(R0)
MOVS	R0, #13
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,270 :: 		spi_write( 0x0B, RF_MODEM_AFC_GEAR_7_data );                // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_AFC_GEAR_7_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AFC_GEAR_7_data+0)
PUSH	(R0)
MOVS	R0, #11
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,271 :: 		spi_write( 0x05, RF_MODEM_AGC_CONTROL_1_data );                // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_AGC_CONTROL_1_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_CONTROL_1_data+0)
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,272 :: 		spi_write( 0x0D, RF_MODEM_AGC_WINDOW_SIZE_9_data );        // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
PUSH	(R0)
MOVS	R0, #13
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,273 :: 		spi_write( 0x0F, RF_MODEM_OOK_CNT1_11_data );                // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_OOK_CNT1_11_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_OOK_CNT1_11_data+0)
PUSH	(R0)
MOVS	R0, #15
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,276 :: 		app_command_buf[ 0 ] = 0x11;
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,277 :: 		app_command_buf[ 1 ] = 0x20;    // 0x204e
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,278 :: 		app_command_buf[ 2 ] = 0x01;    // Total 1Parameters
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,279 :: 		app_command_buf[ 3 ] = 0x4e;   // 0x204e
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #78
STRB	R0, [R1, #0]
;driverrf4463pro.c,281 :: 		if ( ucRF4463Rate == dr_500 ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
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
;driverrf4463pro.c,287 :: 		spi_write( 5, app_command_buf );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,290 :: 		spi_write( 0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data );  // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
PUSH	(R0)
MOVS	R0, #16
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,291 :: 		spi_write( 0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data );   // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
PUSH	(R0)
MOVS	R0, #16
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,292 :: 		spi_write( 0x10, RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data );   // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
PUSH	(R0)
MOVS	R0, #16
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,295 :: 		app_command_buf[ 0 ]  = 0x11;
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,296 :: 		app_command_buf[ 1 ]  = 0x22;    // 0x2200
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #34
STRB	R0, [R1, #0]
;driverrf4463pro.c,297 :: 		app_command_buf[ 2 ]  = 0x04;    // Total 4Parameters
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #4
STRB	R0, [R1, #0]
;driverrf4463pro.c,298 :: 		app_command_buf[ 3 ]  = 0x00;   // 0x2200
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,299 :: 		app_command_buf[ 4 ]  = 0x08;  //0x10;   //   PA mode  = default , ??Class E mode,?Is not Switch Current mode  ????????
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,301 :: 		if ( ucRF4463Power > 0 || ucRF4463Power < 127 ) {
MOVW	R0, #lo_addr(_ucRF4463Power+0)
MOVT	R0, #hi_addr(_ucRF4463Power+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	HI
BHI	L__vRF4463Init406
MOVW	R0, #lo_addr(_ucRF4463Power+0)
MOVT	R0, #hi_addr(_ucRF4463Power+0)
LDRB	R0, [R0, #0]
CMP	R0, #127
IT	CC
BCC	L__vRF4463Init406
IT	AL
BAL	L_vRF4463Init76
L__vRF4463Init406:
;driverrf4463pro.c,302 :: 		app_command_buf[ 5 ]  = ucRF4463Power;   //  Set to maximum power
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVW	R0, #lo_addr(_ucRF4463Power+0)
MOVT	R0, #hi_addr(_ucRF4463Power+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,303 :: 		}
IT	AL
BAL	L_vRF4463Init77
L_vRF4463Init76:
;driverrf4463pro.c,305 :: 		app_command_buf[ 5 ]  = 127;
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #127
STRB	R0, [R1, #0]
;driverrf4463pro.c,306 :: 		}
L_vRF4463Init77:
;driverrf4463pro.c,308 :: 		app_command_buf[ 6 ] = 0x00; //???????? 0x00;   // CLK duty = 50%, other = Default
ADD	R0, SP, #4
ADDS	R1, R0, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,310 :: 		if ( ( ucRF4463Rate <= dr_115p2 )||( ucRF4463Rate == dr_500 ) ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	LS
BLS	L__vRF4463Init405
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	EQ
BEQ	L__vRF4463Init405
IT	AL
BAL	L_vRF4463Init80
L__vRF4463Init405:
;driverrf4463pro.c,311 :: 		app_command_buf[ 7 ]  = 0x3d;  // ???????? 0x5d;   // PA ramp time = default
ADD	R0, SP, #4
ADDS	R1, R0, #7
MOVS	R0, #61
STRB	R0, [R1, #0]
;driverrf4463pro.c,312 :: 		}
IT	AL
BAL	L_vRF4463Init81
L_vRF4463Init80:
;driverrf4463pro.c,314 :: 		app_command_buf[ 7 ]  = 0x5d;
ADD	R0, SP, #4
ADDS	R1, R0, #7
MOVS	R0, #93
STRB	R0, [R1, #0]
;driverrf4463pro.c,315 :: 		}
L_vRF4463Init81:
;driverrf4463pro.c,316 :: 		spi_write( 8, app_command_buf );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #8
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,320 :: 		spi_write( 0x0B , RF_SYNTH_PFDCP_CPFF_7_data );      // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
MOVT	R0, #hi_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
PUSH	(R0)
MOVS	R0, #11
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,323 :: 		if ( ucRF4463MatchEnabled ) {
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463Init82
;driverrf4463pro.c,324 :: 		app_command_buf[ 0 ]  = 0x11;               // SetProperty
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,325 :: 		app_command_buf[ 1 ]  = 0x30;               // 0x30 group
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #48
STRB	R0, [R1, #0]
;driverrf4463pro.c,326 :: 		app_command_buf[ 2 ]  = 0x0c;               // Total 12 Parameters
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #12
STRB	R0, [R1, #0]
;driverrf4463pro.c,327 :: 		app_command_buf[ 3 ]  = 0x00;               // 0x00 Index
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,328 :: 		app_command_buf[ 4 ]  = ucRF4463ByteMatch1; // match 1 Value of
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVW	R0, #lo_addr(_ucRF4463ByteMatch1+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch1+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,329 :: 		app_command_buf[ 5 ]  = ucRF4463ByteMask1;  // match 1 mask
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVW	R0, #lo_addr(_ucRF4463ByteMask1+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask1+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,330 :: 		app_command_buf[ 6 ]  = ucRF4463MatchEnableReg; //  0x40; // enable match 1, match 1 The distance between the value of and the synchronization word, 0 = match
ADD	R0, SP, #4
ADDS	R1, R0, #6
MOVW	R0, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnableReg+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,331 :: 		app_command_buf[ 7 ]  = ucRF4463ByteMatch2; // match 2 Value of
ADD	R0, SP, #4
ADDS	R1, R0, #7
MOVW	R0, #lo_addr(_ucRF4463ByteMatch2+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch2+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,332 :: 		app_command_buf[ 8 ]  = ucRF4463ByteMask2;  // match 2 mask
ADD	R0, SP, #4
ADDW	R1, R0, #8
MOVW	R0, #lo_addr(_ucRF4463ByteMask2+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask2+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,333 :: 		app_command_buf[ 9 ]  = 0x01;               // enable match 2, match 2 The distance between the value of and the synchronization word  , and function
ADD	R0, SP, #4
ADDW	R1, R0, #9
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,334 :: 		app_command_buf[ 10 ] = ucRF4463ByteMatch3; // match 3 Value of
ADD	R0, SP, #4
ADDW	R1, R0, #10
MOVW	R0, #lo_addr(_ucRF4463ByteMatch3+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch3+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,335 :: 		app_command_buf[ 11 ] = ucRF4463ByteMask3;  // match 3 mask
ADD	R0, SP, #4
ADDW	R1, R0, #11
MOVW	R0, #lo_addr(_ucRF4463ByteMask3+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask3+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,336 :: 		app_command_buf[ 12 ] = 0x02;;              // enable match 3, match 3 The distance between the value of and the synchronization word    and function
ADD	R0, SP, #4
ADDW	R1, R0, #12
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,337 :: 		app_command_buf[ 13 ] = ucRF4463ByteMatch4; // match 4 Value of
ADD	R0, SP, #4
ADDW	R1, R0, #13
MOVW	R0, #lo_addr(_ucRF4463ByteMatch4+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch4+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,338 :: 		app_command_buf[ 14 ] = ucRF4463ByteMask4;  // match 4 mask
ADD	R0, SP, #4
ADDW	R1, R0, #14
MOVW	R0, #lo_addr(_ucRF4463ByteMask4+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask4+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,339 :: 		app_command_buf[ 15 ] = 0x03;               // enable match 4, match 4 The distance between the value of and the synchronization word    and function
ADD	R0, SP, #4
ADDW	R1, R0, #15
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,340 :: 		spi_write( 16, app_command_buf );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #16
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,342 :: 		if ( ucRF4463MatchEnableReg == 0x00 ) {
MOVW	R0, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnableReg+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_vRF4463Init83
;driverrf4463pro.c,343 :: 		ucRF4463MatchEnabled = 0;                // deshabilita el Match
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R1, [R0, #0]
;driverrf4463pro.c,344 :: 		}
L_vRF4463Init83:
;driverrf4463pro.c,363 :: 		}
L_vRF4463Init82:
;driverrf4463pro.c,366 :: 		rf_init_freq();     // FUNCION DE FRECUENCIA ( REVISAR PARAMETROS )
BL	_rf_init_freq+0
;driverrf4463pro.c,367 :: 		}
L_end_vRF4463Init:
LDR	LR, [SP, #0]
ADD	SP, SP, #28
BX	LR
; end of _vRF4463Init
_vRF4463GPIO_SET:
;driverrf4463pro.c,373 :: 		void vRF4463GPIO_SET( unsigned char ucData ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,376 :: 		ucAppCommandBuf[0] = 0x13;     // gpio Set up
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #19
STRB	R0, [R1, #0]
;driverrf4463pro.c,378 :: 		switch ( ucData ) {
IT	AL
BAL	L_vRF4463GPIO_SET84
;driverrf4463pro.c,379 :: 		case tx_normal:
L_vRF4463GPIO_SET86:
;driverrf4463pro.c,380 :: 		case rx_normal: ucAppCommandBuf[ 1 ] = 3;                 // GPIO0=1
L_vRF4463GPIO_SET87:
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,381 :: 		ucAppCommandBuf[ 2 ] = 2;                // GPIO1=0
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,382 :: 		break;
IT	AL
BAL	L_vRF4463GPIO_SET85
;driverrf4463pro.c,384 :: 		case tx_test:   ucAppCommandBuf[ 1 ] = 3;                 // GPIO0=1
L_vRF4463GPIO_SET88:
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,385 :: 		ucAppCommandBuf[ 2 ] = 3;                // GPIO1=1
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,386 :: 		break;
IT	AL
BAL	L_vRF4463GPIO_SET85
;driverrf4463pro.c,388 :: 		case rx_test:   ucAppCommandBuf[ 1 ] = 2;                 // GPIO0=0
L_vRF4463GPIO_SET89:
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,389 :: 		ucAppCommandBuf[ 2 ] = 20;                // GPIO1=RX DATA
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #20
STRB	R0, [R1, #0]
;driverrf4463pro.c,390 :: 		break;
IT	AL
BAL	L_vRF4463GPIO_SET85
;driverrf4463pro.c,392 :: 		case rf_off:    ucAppCommandBuf[ 1 ] = 2;                 // GPIO0=0
L_vRF4463GPIO_SET90:
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,393 :: 		ucAppCommandBuf[ 2 ] = 2;                // GPIO1=0
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,394 :: 		break;
IT	AL
BAL	L_vRF4463GPIO_SET85
;driverrf4463pro.c,395 :: 		}
L_vRF4463GPIO_SET84:
LDRB	R0, [SP, #12]
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463GPIO_SET86
LDRB	R0, [SP, #12]
CMP	R0, #1
IT	EQ
BEQ	L_vRF4463GPIO_SET87
LDRB	R0, [SP, #12]
CMP	R0, #2
IT	EQ
BEQ	L_vRF4463GPIO_SET88
LDRB	R0, [SP, #12]
CMP	R0, #3
IT	EQ
BEQ	L_vRF4463GPIO_SET89
LDRB	R0, [SP, #12]
CMP	R0, #4
IT	EQ
BEQ	L_vRF4463GPIO_SET90
L_vRF4463GPIO_SET85:
;driverrf4463pro.c,397 :: 		ucAppCommandBuf[ 3 ]  = 0x21;     //0x20;   //  gpio2, h = tx mode
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #33
STRB	R0, [R1, #0]
;driverrf4463pro.c,398 :: 		ucAppCommandBuf[ 4 ]  = 0x20;     // 0x14;  //   gpio3
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,399 :: 		ucAppCommandBuf[ 5 ]  = 0x27;     // nIRQ
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #39
STRB	R0, [R1, #0]
;driverrf4463pro.c,400 :: 		ucAppCommandBuf[ 6 ]  = 0x0b;     // sdo
ADD	R0, SP, #4
ADDS	R1, R0, #6
MOVS	R0, #11
STRB	R0, [R1, #0]
;driverrf4463pro.c,401 :: 		spi_write( 7, ucAppCommandBuf );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #7
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,402 :: 		}
L_end_vRF4463GPIO_SET:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRF4463GPIO_SET
_vRF4463FifoReset:
;driverrf4463pro.c,407 :: 		void vRF4463FifoReset( void ) {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;driverrf4463pro.c,410 :: 		p[ 0 ] = FIFO_INFO;
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #21
STRB	R0, [R1, #0]
;driverrf4463pro.c,411 :: 		p[ 1 ] = 0x03;   // reset tx ,rx fifo
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,412 :: 		spi_write( 2, p );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #2
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,413 :: 		}
L_end_vRF4463FifoReset:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vRF4463FifoReset
_vRF4463ClearInterrupts:
;driverrf4463pro.c,419 :: 		void vRF4463ClearInterrupts( void ) {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;driverrf4463pro.c,422 :: 		p[ 0 ] = GET_INT_STATUS;
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,423 :: 		p[ 1 ] = 0;               // clr  PH pending
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,424 :: 		p[ 2 ] = 0;               // clr modem_pending
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,425 :: 		p[ 3 ] = 0;               // clr chip pending
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,426 :: 		spi_write( 4, p );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #4
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,427 :: 		spi_read( 9, GET_INT_STATUS );
MOVS	R0, #32
PUSH	(R0)
MOVS	R0, #9
PUSH	(R0)
BL	_spi_read+0
ADD	SP, SP, #8
;driverrf4463pro.c,428 :: 		}
L_end_vRF4463ClearInterrupts:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vRF4463ClearInterrupts
_vRF4463PartInfo:
;driverrf4463pro.c,430 :: 		void vRF4463PartInfo( void ) {  // Solicitud totalmente operativa
SUB	SP, SP, #16
STR	LR, [SP, #0]
;driverrf4463pro.c,433 :: 		p[ 0 ] = PART_INFO;
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,437 :: 		spi_write( 1, p );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #1
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,438 :: 		spi_read( 9, PART_INFO );
MOVS	R0, #1
PUSH	(R0)
MOVS	R0, #9
PUSH	(R0)
BL	_spi_read+0
ADD	SP, SP, #8
;driverrf4463pro.c,439 :: 		}
L_end_vRF4463PartInfo:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _vRF4463PartInfo
_vRF4463EnableRxInterrupt:
;driverrf4463pro.c,444 :: 		void vRF4463EnableRxInterrupt( void ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,447 :: 		p[ 0 ] = 0x11;
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,448 :: 		p[ 1 ] = 0x01;            // 0x0100
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,449 :: 		p[ 2 ] = 0x03;            // 3Parameters
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,450 :: 		p[ 3 ] = 0x00;            // 0100
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,451 :: 		p[ 4 ] = 0x03;            // ph, modem int       0x03;
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,452 :: 		p[ 5 ] = 0x18;            // 0x10;   // Pack received int
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #24
STRB	R0, [R1, #0]
;driverrf4463pro.c,453 :: 		p[ 6 ] = 0x00;            //preamble int, sync int setting
ADD	R0, SP, #4
ADDS	R1, R0, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,454 :: 		spi_write( 0x07, p );     // enable  packet receive interrupt
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #7
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,455 :: 		}
L_end_vRF4463EnableRxInterrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRF4463EnableRxInterrupt
_vRF4463EnableTxInterrupt:
;driverrf4463pro.c,460 :: 		void vRF4463EnableTxInterrupt( void ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,463 :: 		p[ 0 ] = 0x11;
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,464 :: 		p[ 1 ] = 0x01;            // 0x0100
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,465 :: 		p[ 2 ] = 0x02;            // 2Parameters
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,466 :: 		p[ 3 ] = 0x00;            // 0x0100
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,467 :: 		p[ 4 ] = 0x01;            // Ph  int
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,468 :: 		p[ 5 ] = 0x20;            //  enable  packet sent interrupt
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,469 :: 		spi_write( 0x06, p );     // enable  packet receive interrupt
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #6
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,470 :: 		}
L_end_vRF4463EnableTxInterrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRF4463EnableTxInterrupt
_vRF4463RfStandby:
;driverrf4463pro.c,475 :: 		void vRF4463RfStandby( void ) {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;driverrf4463pro.c,478 :: 		p[ 0 ] = CHANGE_STATE ;   // CHANGE_STATE Command
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #52
STRB	R0, [R1, #0]
;driverrf4463pro.c,479 :: 		p[ 1 ] = 0x01 ;           // sleep mode
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,480 :: 		spi_write( 2, p );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #2
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,481 :: 		}
L_end_vRF4463RfStandby:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vRF4463RfStandby
_vRF4463TxStart:
;driverrf4463pro.c,486 :: 		void vRF4463TxStart( void ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,489 :: 		p[ 0 ] = START_TX ;              // start Command
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #49
STRB	R0, [R1, #0]
;driverrf4463pro.c,490 :: 		p[ 1 ] = ucRF4463FreqChannel;    // channel 1 default
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,491 :: 		p[ 2 ] = 0x30;                   // Back after launch Readymode, Do not retransmit, launch immediately
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #48
STRB	R0, [R1, #0]
;driverrf4463pro.c,492 :: 		p[ 3 ] = 0;
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,493 :: 		p[ 4 ] = 0;                      // payload_length; // Total to transmit 10 bytes
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,494 :: 		spi_write( 5, p );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,495 :: 		}
L_end_vRF4463TxStart:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRF4463TxStart
_vRF4463RxStart:
;driverrf4463pro.c,500 :: 		void vRF4463RxStart( void ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,503 :: 		p[ 0 ] = START_RX ;              // start Command
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #50
STRB	R0, [R1, #0]
;driverrf4463pro.c,504 :: 		p[ 1 ] = ucRF4463FreqChannel;    // channel 0
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,505 :: 		p[ 2 ] = 0x00;                   // Enter receiving mode immediately
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,506 :: 		p[ 3 ] = 0;
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,507 :: 		p[ 4 ] = 0;                      // payload_length; // Total to receive 10 bytes
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,508 :: 		p[ 5 ] = 0;                      // unchanged after preamble timeout
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,511 :: 		p[ 6 ] = 0x08;
ADD	R0, SP, #4
ADDS	R1, R0, #6
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,512 :: 		p[ 7 ] = 0x08;
ADD	R0, SP, #4
ADDS	R1, R0, #7
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,513 :: 		spi_write( 8, p );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #8
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,514 :: 		}
L_end_vRF4463RxStart:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRF4463RxStart
_vRF4463RxStartTest:
;driverrf4463pro.c,519 :: 		void vRF4463RxStartTest( void ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,522 :: 		LED_GREEN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_SX	[R0, ByteOffset(GPIOE_ODRbits+0)]
;driverrf4463pro.c,524 :: 		p[ 0 ] = START_RX;        // start Command
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #50
STRB	R0, [R1, #0]
;driverrf4463pro.c,525 :: 		p[ 1 ] = ucRF4463FreqChannel;    // channel 0
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,526 :: 		p[ 2 ] = 0x00;            // Enter receiving mode immediately
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,527 :: 		p[ 3 ] = 0;
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,529 :: 		p[ 4 ] = 0;
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,530 :: 		p[ 5 ] = 0;               // unchanged after preamble timeout
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,533 :: 		p[ 6 ] = 0x08;
ADD	R0, SP, #4
ADDS	R1, R0, #6
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,534 :: 		p[ 7 ] = 0x08;
ADD	R0, SP, #4
ADDS	R1, R0, #7
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,535 :: 		spi_write( 8, p );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #8
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,536 :: 		}
L_end_vRF4463RxStartTest:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRF4463RxStartTest
_vRF4463RxInit:
;driverrf4463pro.c,541 :: 		void vRF4463RxInit( void ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;driverrf4463pro.c,542 :: 		Flag.is_tx = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;driverrf4463pro.c,543 :: 		vRF4463FifoReset();           // fifo_reset();  // Buffer empty
BL	_vRF4463FifoReset+0
;driverrf4463pro.c,544 :: 		vRF4463EnableRxInterrupt();   // enable_rx_interrupt();
BL	_vRF4463EnableRxInterrupt+0
;driverrf4463pro.c,545 :: 		vRF4463ClearInterrupts();      // clr_interrupt();  // Clear interrupt factor
BL	_vRF4463ClearInterrupts+0
;driverrf4463pro.c,547 :: 		if ( ucRF4463Mode == rx_test_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BNE	L_vRF4463RxInit91
;driverrf4463pro.c,548 :: 		vRF4463RxStartTest();      // rx_start_test();
BL	_vRF4463RxStartTest+0
;driverrf4463pro.c,549 :: 		}
IT	AL
BAL	L_vRF4463RxInit92
L_vRF4463RxInit91:
;driverrf4463pro.c,551 :: 		vRF4463RxStart();        // rx_start();    // Enter receiving mode, after receiving data, return to Readymode
BL	_vRF4463RxStart+0
;driverrf4463pro.c,552 :: 		}
L_vRF4463RxInit92:
;driverrf4463pro.c,553 :: 		}
L_end_vRF4463RxInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vRF4463RxInit
_vRF4463TxData:
;driverrf4463pro.c,558 :: 		void vRF4463TxData( void ) {
SUB	SP, SP, #24
STR	LR, [SP, #0]
;driverrf4463pro.c,561 :: 		ucRF4463IRQ = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
STRB	R1, [R0, #0]
;driverrf4463pro.c,563 :: 		Flag.is_tx = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;driverrf4463pro.c,566 :: 		LED_RED =~ LED_RED;
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_LX	[R0, ByteOffset(GPIOE_ODRbits+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_SX	[R0, ByteOffset(GPIOE_ODRbits+0)]
;driverrf4463pro.c,567 :: 		vRF4463FifoReset();            // fifo_reset();  // Buffer empty
BL	_vRF4463FifoReset+0
;driverrf4463pro.c,568 :: 		spi_write_fifo();              // Fill the buffer with data
BL	_spi_write_fifo+0
;driverrf4463pro.c,569 :: 		vRF4463EnableTxInterrupt();    // enable_tx_interrupt();
BL	_vRF4463EnableTxInterrupt+0
;driverrf4463pro.c,570 :: 		vRF4463ClearInterrupts();       // clr_interrupt();  // Clear interrupt factor
BL	_vRF4463ClearInterrupts+0
;driverrf4463pro.c,571 :: 		vRF4463TxStart();              // tx_start();    // Enter launch mode, start launch
BL	_vRF4463TxStart+0
;driverrf4463pro.c,572 :: 		rf_timeout = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_rf_timeout+0)
MOVT	R0, #hi_addr(_rf_timeout+0)
STRH	R1, [R0, #0]
;driverrf4463pro.c,574 :: 		Flag.rf_reach_timeout = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;driverrf4463pro.c,576 :: 		if ( ucRF4463IRQ ) {
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463TxData93
;driverrf4463pro.c,577 :: 		UART1_Write_Text( "[ UART1 ] TX INT\r\n" );
ADD	R11, SP, #4
ADD	R10, R11, #19
MOVW	R12, #lo_addr(?ICS?lstr1_DriverRF4463PROMain+0)
MOVT	R12, #hi_addr(?ICS?lstr1_DriverRF4463PROMain+0)
BL	___CC2DW+0
ADD	R0, SP, #4
MOV	R4, R0
MOV	R0, R4
BL	_UART1_Write_Text+0
;driverrf4463pro.c,578 :: 		}
L_vRF4463TxData93:
;driverrf4463pro.c,581 :: 		while ( nIRQ ) {     //nIRQ
L_vRF4463TxData94:
MOVW	R0, #lo_addr(GPIOD_IDRbits+0)
MOVT	R0, #hi_addr(GPIOD_IDRbits+0)
_LX	[R0, ByteOffset(GPIOD_IDRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463TxData95
;driverrf4463pro.c,584 :: 		if ( Flag.rf_reach_timeout ) {
MOVW	R1, #lo_addr(_Flag+0)
MOVT	R1, #hi_addr(_Flag+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463TxData96
;driverrf4463pro.c,585 :: 		VRF4463SDNReset();
BL	_VRF4463SDNReset+0
;driverrf4463pro.c,586 :: 		vRF4463Init();        //SI4463_init();  // RF Module initialization
BL	_vRF4463Init+0
;driverrf4463pro.c,587 :: 		break;                // Forced out
IT	AL
BAL	L_vRF4463TxData95
;driverrf4463pro.c,588 :: 		}
L_vRF4463TxData96:
;driverrf4463pro.c,589 :: 		}
IT	AL
BAL	L_vRF4463TxData94
L_vRF4463TxData95:
;driverrf4463pro.c,591 :: 		tx_cnt++;
MOVW	R0, #lo_addr(_tx_cnt+0)
MOVT	R0, #hi_addr(_tx_cnt+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(_tx_cnt+0)
MOVT	R0, #hi_addr(_tx_cnt+0)
STR	R1, [R0, #0]
;driverrf4463pro.c,593 :: 		vRF4463RxInit();          // rx_init();                //rf After the transmission is completed, enter the receiving mode
BL	_vRF4463RxInit+0
;driverrf4463pro.c,594 :: 		}
L_end_vRF4463TxData:
LDR	LR, [SP, #0]
ADD	SP, SP, #24
BX	LR
; end of _vRF4463TxData
_vRF4463TxCont:
;driverrf4463pro.c,599 :: 		void vRF4463TxCont( void ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;driverrf4463pro.c,602 :: 		LED_RED = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_SX	[R0, ByteOffset(GPIOE_ODRbits+0)]
;driverrf4463pro.c,603 :: 		vRF4463FifoReset();                     //  fifo_reset();  // Buffer empty
BL	_vRF4463FifoReset+0
;driverrf4463pro.c,604 :: 		spi_write_fifo();                       // Fill the buffer with data
BL	_spi_write_fifo+0
;driverrf4463pro.c,605 :: 		vRF4463EnableTxInterrupt();             //  enable_tx_interrupt();
BL	_vRF4463EnableTxInterrupt+0
;driverrf4463pro.c,606 :: 		vRF4463ClearInterrupts();               //  clr_interrupt();  // Clear interrupt factor
BL	_vRF4463ClearInterrupts+0
;driverrf4463pro.c,607 :: 		vRF4463TxStart();                       //  tx_start();    // Enter launch mode, start launch
BL	_vRF4463TxStart+0
;driverrf4463pro.c,608 :: 		rf_timeout = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_rf_timeout+0)
MOVT	R0, #hi_addr(_rf_timeout+0)
STRH	R1, [R0, #0]
;driverrf4463pro.c,609 :: 		Flag.rf_reach_timeout = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;driverrf4463pro.c,611 :: 		ucRF4463IRQ = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
STRB	R1, [R0, #0]
;driverrf4463pro.c,614 :: 		while( nIRQ ) {          //nIRQ ) {
L_vRF4463TxCont97:
MOVW	R0, #lo_addr(GPIOD_IDRbits+0)
MOVT	R0, #hi_addr(GPIOD_IDRbits+0)
_LX	[R0, ByteOffset(GPIOD_IDRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463TxCont98
;driverrf4463pro.c,622 :: 		}
IT	AL
BAL	L_vRF4463TxCont97
L_vRF4463TxCont98:
;driverrf4463pro.c,623 :: 		}
L_end_vRF4463TxCont:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vRF4463TxCont
_rf_init_freq:
;driverrf4463pro.c,628 :: 		void rf_init_freq ( void ) {
SUB	SP, SP, #44
STR	LR, [SP, #0]
;driverrf4463pro.c,634 :: 		ulFrequency = ( ucRF4463Freq3 * 100 ) + ( ucRF4463Freq2 * 10 ) + ucRF4463Freq1;
MOVW	R0, #lo_addr(_ucRF4463Freq3+0)
MOVT	R0, #hi_addr(_ucRF4463Freq3+0)
LDRB	R1, [R0, #0]
MOVS	R0, #100
SXTH	R0, R0
MUL	R2, R1, R0
SXTH	R2, R2
MOVW	R0, #lo_addr(_ucRF4463Freq2+0)
MOVT	R0, #hi_addr(_ucRF4463Freq2+0)
LDRB	R1, [R0, #0]
MOVS	R0, #10
SXTH	R0, R0
MULS	R0, R1, R0
SXTH	R0, R0
ADDS	R1, R2, R0
SXTH	R1, R1
MOVW	R0, #lo_addr(_ucRF4463Freq1+0)
MOVT	R0, #hi_addr(_ucRF4463Freq1+0)
LDRB	R0, [R0, #0]
ADDS	R0, R1, R0
SXTH	R0, R0
STR	R0, [SP, #20]
;driverrf4463pro.c,636 :: 		ulFrequency = ( ulFrequency * 10000 );
LDR	R1, [SP, #20]
MOVW	R0, #10000
MULS	R0, R1, R0
STR	R0, [SP, #20]
;driverrf4463pro.c,639 :: 		if ( ulFrequency >= 7600000 ) {
LDR	R1, [SP, #20]
MOVW	R0, #63360
MOVT	R0, #115
CMP	R1, R0
IT	CC
BCC	L_rf_init_freq99
;driverrf4463pro.c,640 :: 		ucOUTDIV = 4;
MOVS	R0, #4
STRB	R0, [SP, #4]
;driverrf4463pro.c,641 :: 		ucBAND = 0;
MOVS	R0, #0
STRB	R0, [SP, #8]
;driverrf4463pro.c,642 :: 		ucVCO = 0xFF;
MOVS	R0, #255
STRB	R0, [SP, #6]
;driverrf4463pro.c,643 :: 		}
IT	AL
BAL	L_rf_init_freq100
L_rf_init_freq99:
;driverrf4463pro.c,646 :: 		else if ( ulFrequency >= 5460000 ) {
LDR	R1, [SP, #20]
MOVW	R0, #20512
MOVT	R0, #83
CMP	R1, R0
IT	CC
BCC	L_rf_init_freq101
;driverrf4463pro.c,647 :: 		ucOUTDIV = 6;
MOVS	R0, #6
STRB	R0, [SP, #4]
;driverrf4463pro.c,648 :: 		ucBAND   = 1;
MOVS	R0, #1
STRB	R0, [SP, #8]
;driverrf4463pro.c,649 :: 		ucVCO    = 0xFE;
MOVS	R0, #254
STRB	R0, [SP, #6]
;driverrf4463pro.c,650 :: 		}
IT	AL
BAL	L_rf_init_freq102
L_rf_init_freq101:
;driverrf4463pro.c,653 :: 		else if ( ulFrequency >= 3850000 ) {
LDR	R1, [SP, #20]
MOVW	R0, #48912
MOVT	R0, #58
CMP	R1, R0
IT	CC
BCC	L_rf_init_freq103
;driverrf4463pro.c,654 :: 		ucOUTDIV = 8;
MOVS	R0, #8
STRB	R0, [SP, #4]
;driverrf4463pro.c,655 :: 		ucBAND   = 2;
MOVS	R0, #2
STRB	R0, [SP, #8]
;driverrf4463pro.c,656 :: 		ucVCO    = 0xFE;
MOVS	R0, #254
STRB	R0, [SP, #6]
;driverrf4463pro.c,657 :: 		}
IT	AL
BAL	L_rf_init_freq104
L_rf_init_freq103:
;driverrf4463pro.c,660 :: 		else if ( ulFrequency >= 2730000 ) {
LDR	R1, [SP, #20]
MOVW	R0, #43024
MOVT	R0, #41
CMP	R1, R0
IT	CC
BCC	L_rf_init_freq105
;driverrf4463pro.c,661 :: 		ucOUTDIV = 12;
MOVS	R0, #12
STRB	R0, [SP, #4]
;driverrf4463pro.c,662 :: 		ucBAND   = 3;
MOVS	R0, #3
STRB	R0, [SP, #8]
;driverrf4463pro.c,663 :: 		ucVCO    = 0xFD;
MOVS	R0, #253
STRB	R0, [SP, #6]
;driverrf4463pro.c,664 :: 		}
IT	AL
BAL	L_rf_init_freq106
L_rf_init_freq105:
;driverrf4463pro.c,667 :: 		else if ( ulFrequency >= 1940000 ) {
LDR	R1, [SP, #20]
MOVW	R0, #39456
MOVT	R0, #29
CMP	R1, R0
IT	CC
BCC	L_rf_init_freq107
;driverrf4463pro.c,668 :: 		ucOUTDIV = 16;
MOVS	R0, #16
STRB	R0, [SP, #4]
;driverrf4463pro.c,669 :: 		ucBAND   = 4;
MOVS	R0, #4
STRB	R0, [SP, #8]
;driverrf4463pro.c,670 :: 		ucVCO    = 0xFC;
MOVS	R0, #252
STRB	R0, [SP, #6]
;driverrf4463pro.c,671 :: 		}
IT	AL
BAL	L_rf_init_freq108
L_rf_init_freq107:
;driverrf4463pro.c,675 :: 		ucOUTDIV = 24;
MOVS	R0, #24
STRB	R0, [SP, #4]
;driverrf4463pro.c,676 :: 		ucBAND   = 5;
MOVS	R0, #5
STRB	R0, [SP, #8]
;driverrf4463pro.c,677 :: 		ucVCO    = 0xFA;
MOVS	R0, #250
STRB	R0, [SP, #6]
;driverrf4463pro.c,678 :: 		}
L_rf_init_freq108:
L_rf_init_freq106:
L_rf_init_freq104:
L_rf_init_freq102:
L_rf_init_freq100:
;driverrf4463pro.c,680 :: 		ucDIV = ucOUTDIV / 2;
LDRB	R1, [SP, #4]
MOVS	R0, #2
UDIV	R0, R1, R0
STRB	R0, [SP, #5]
;driverrf4463pro.c,682 :: 		ulData = ( ulFrequency * ucDIV ) / 3;          // ucDIV = 88.5 = 88   //// UCdiv = 2
LDRB	R1, [SP, #5]
LDR	R0, [SP, #20]
MULS	R1, R0, R1
MOVS	R0, #3
UDIV	R0, R1, R0
STR	R0, [SP, #16]
;driverrf4463pro.c,683 :: 		ucINTE = ( ulData / 100000) - 1;               // ulData = 6 000 000  //// ULdATA = 9 000 000
LDR	R1, [SP, #16]
MOVW	R0, #34464
MOVT	R0, #1
UDIV	R0, R1, R0
SUBS	R0, R0, #1
STRB	R0, [SP, #7]
;driverrf4463pro.c,684 :: 		ulFRAC = ( ulData - ( ucINTE + 1 ) * 100000 ) * 16384 / 3125;         // ulFRAC = 15 728 640
LDRB	R0, [SP, #7]
ADDS	R1, R0, #1
SXTH	R1, R1
MOVW	R0, #34464
MOVT	R0, #1
MULS	R1, R0, R1
LDR	R0, [SP, #16]
SUB	R1, R0, R1
MOVW	R0, #16384
MULS	R1, R0, R1
MOVW	R0, #3125
UDIV	R0, R1, R0
STR	R0, [SP, #12]
;driverrf4463pro.c,685 :: 		ulFRAC = ulFRAC + 0x80000;
LDR	R0, [SP, #12]
ADD	R0, R0, #524288
STR	R0, [SP, #12]
;driverrf4463pro.c,687 :: 		ucFRAC_0 = ulFRAC;
LDR	R0, [SP, #12]
STRB	R0, [SP, #11]
;driverrf4463pro.c,688 :: 		ulFRAC >>= 8;
LDR	R0, [SP, #12]
LSRS	R0, R0, #8
STR	R0, [SP, #12]
;driverrf4463pro.c,689 :: 		ucFRAC_1 = ulFRAC;
LDR	R0, [SP, #12]
STRB	R0, [SP, #10]
;driverrf4463pro.c,690 :: 		ulFRAC >>= 8;
LDR	R0, [SP, #12]
LSRS	R0, R0, #8
STR	R0, [SP, #12]
;driverrf4463pro.c,691 :: 		ucFRAC_2 = ulFRAC;
LDR	R0, [SP, #12]
STRB	R0, [SP, #9]
;driverrf4463pro.c,695 :: 		app_command_buf[ 0 ] = 0x11;           // SET property    MODEM_CLKGEN_BAND
ADD	R0, SP, #24
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,696 :: 		app_command_buf[ 1 ] = 0x20;           // Group  // 0x2051
ADD	R0, SP, #24
ADDS	R1, R0, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,697 :: 		app_command_buf[ 2 ] = 0x01;           // Num Arguments // Total 1 Parameters
ADD	R0, SP, #24
ADDS	R1, R0, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,698 :: 		app_command_buf[ 3 ] = 0x51;           // Number  // 0x2051
ADD	R0, SP, #24
ADDS	R1, R0, #3
MOVS	R0, #81
STRB	R0, [R1, #0]
;driverrf4463pro.c,699 :: 		app_command_buf[ 4 ] = 0x08 | ucBAND;  // Argumento  //  high performance mode , clk outpu = osc /4
ADD	R0, SP, #24
ADDS	R1, R0, #4
LDRB	R0, [SP, #8]
ORR	R0, R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,700 :: 		spi_write( 5, app_command_buf );
ADD	R0, SP, #24
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,702 :: 		app_command_buf[ 0 ]  = 0x11;
ADD	R0, SP, #24
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,703 :: 		app_command_buf[ 1 ]  = 0x40;    // 0x4000         FREQ_CONTROL_INTE
ADD	R0, SP, #24
ADDS	R1, R0, #1
MOVS	R0, #64
STRB	R0, [R1, #0]
;driverrf4463pro.c,704 :: 		app_command_buf[ 2 ]  = 0x08;    // Total 8 Parameters
ADD	R0, SP, #24
ADDS	R1, R0, #2
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,705 :: 		app_command_buf[ 3 ]  = 0x00;   // 0x4000
ADD	R0, SP, #24
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,706 :: 		app_command_buf[ 4 ]  = ucINTE;   //  default value
ADD	R0, SP, #24
ADDS	R1, R0, #4
LDRB	R0, [SP, #7]
STRB	R0, [R1, #0]
;driverrf4463pro.c,707 :: 		app_command_buf[ 5 ]  = ucFRAC_2;   //  defaul value
ADD	R0, SP, #24
ADDS	R1, R0, #5
LDRB	R0, [SP, #9]
STRB	R0, [R1, #0]
;driverrf4463pro.c,708 :: 		app_command_buf[ 6 ]  = ucFRAC_1;   //  default value
ADD	R0, SP, #24
ADDS	R1, R0, #6
LDRB	R0, [SP, #10]
STRB	R0, [R1, #0]
;driverrf4463pro.c,709 :: 		app_command_buf[ 7 ]  = ucFRAC_0;   // frac ,from WDS
ADD	R0, SP, #24
ADDS	R1, R0, #7
LDRB	R0, [SP, #11]
STRB	R0, [R1, #0]
;driverrf4463pro.c,712 :: 		if ( ulRF4463Step == 250 ) {
MOVW	R0, #lo_addr(_ulRF4463Step+0)
MOVT	R0, #hi_addr(_ulRF4463Step+0)
LDR	R0, [R0, #0]
CMP	R0, #250
IT	NE
BNE	L_rf_init_freq109
;driverrf4463pro.c,713 :: 		app_command_buf[ 8 ]  = step_250K_step1;   // channel step1  from wds  // al parecer aqu? esta el ancho del canal
ADD	R0, SP, #24
ADDW	R1, R0, #8
MOVS	R0, #34
STRB	R0, [R1, #0]
;driverrf4463pro.c,714 :: 		app_command_buf[ 9 ]  = step_250K_step0;   // channel step0  from wds
ADD	R0, SP, #24
ADDW	R1, R0, #9
MOVS	R0, #34
STRB	R0, [R1, #0]
;driverrf4463pro.c,715 :: 		}
IT	AL
BAL	L_rf_init_freq110
L_rf_init_freq109:
;driverrf4463pro.c,716 :: 		else if ( ulRF4463Step == 500 ) {
MOVW	R0, #lo_addr(_ulRF4463Step+0)
MOVT	R0, #hi_addr(_ulRF4463Step+0)
LDR	R0, [R0, #0]
CMP	R0, #500
IT	NE
BNE	L_rf_init_freq111
;driverrf4463pro.c,717 :: 		app_command_buf[ 8 ]  = step_500K_step1;   // channel step1  from wds  // al parecer aqu? esta el ancho del canal
ADD	R0, SP, #24
ADDW	R1, R0, #8
MOVS	R0, #68
STRB	R0, [R1, #0]
;driverrf4463pro.c,718 :: 		app_command_buf[ 9 ]  = step_500K_step0;   // channel step0  from wds
ADD	R0, SP, #24
ADDW	R1, R0, #9
MOVS	R0, #68
STRB	R0, [R1, #0]
;driverrf4463pro.c,719 :: 		}
L_rf_init_freq111:
L_rf_init_freq110:
;driverrf4463pro.c,721 :: 		app_command_buf[ 10 ] = 0x20;  //  from wds Without this Values
ADD	R0, SP, #24
ADDW	R1, R0, #10
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,722 :: 		app_command_buf[ 11 ] = ucVCO;    // from wds Without this Values
ADD	R0, SP, #24
ADDW	R1, R0, #11
LDRB	R0, [SP, #6]
STRB	R0, [R1, #0]
;driverrf4463pro.c,723 :: 		spi_write( 12, app_command_buf );
ADD	R0, SP, #24
PUSH	(R0)
MOVS	R0, #12
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,724 :: 		}
L_end_rf_init_freq:
LDR	LR, [SP, #0]
ADD	SP, SP, #44
BX	LR
; end of _rf_init_freq
_ucRf4463SPIByte:
;driverrf4463pro.c,744 :: 		unsigned char ucRf4463SPIByte( unsigned char ucData ) {
SUB	SP, SP, #4
;driverrf4463pro.c,746 :: 		ucSPI1ByteReceived = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucSPI1ByteReceived+0)
MOVT	R0, #hi_addr(_ucSPI1ByteReceived+0)
STRB	R1, [R0, #0]
;driverrf4463pro.c,748 :: 		SPI1_DR = ucData;
LDRB	R1, [SP, #4]
MOVW	R0, #lo_addr(SPI1_DR+0)
MOVT	R0, #hi_addr(SPI1_DR+0)
STR	R1, [R0, #0]
;driverrf4463pro.c,750 :: 		while ( !SPI1_SRbits.TXE );                // espera a que el buffer este vacio
L_ucRf4463SPIByte112:
MOVW	R0, #lo_addr(SPI1_SRbits+0)
MOVT	R0, #hi_addr(SPI1_SRbits+0)
_LX	[R0, ByteOffset(SPI1_SRbits+0)]
CMP	R0, #0
IT	NE
BNE	L_ucRf4463SPIByte113
IT	AL
BAL	L_ucRf4463SPIByte112
L_ucRf4463SPIByte113:
;driverrf4463pro.c,752 :: 		while ( SPI1_SRbits.BSY );                // espera a que el buffer este vacio
L_ucRf4463SPIByte114:
MOVW	R0, #lo_addr(SPI1_SRbits+0)
MOVT	R0, #hi_addr(SPI1_SRbits+0)
_LX	[R0, ByteOffset(SPI1_SRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_ucRf4463SPIByte115
IT	AL
BAL	L_ucRf4463SPIByte114
L_ucRf4463SPIByte115:
;driverrf4463pro.c,754 :: 		return ( ucSPI1ByteReceived );
MOVW	R0, #lo_addr(_ucSPI1ByteReceived+0)
MOVT	R0, #hi_addr(_ucSPI1ByteReceived+0)
LDRB	R0, [R0, #0]
;driverrf4463pro.c,756 :: 		}
L_end_ucRf4463SPIByte:
ADD	SP, SP, #4
BX	LR
; end of _ucRf4463SPIByte
_spi_write:
;driverrf4463pro.c,761 :: 		void spi_write( unsigned char tx_length, unsigned char *p ) {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;driverrf4463pro.c,764 :: 		i = 0;
MOVS	R0, #0
STRB	R0, [SP, #4]
;driverrf4463pro.c,765 :: 		while ( i != 0xFF ) {
L_spi_write116:
LDRB	R0, [SP, #4]
CMP	R0, #255
IT	EQ
BEQ	L_spi_write117
;driverrf4463pro.c,766 :: 		i = check_cts();
BL	_check_cts+0
STRB	R0, [SP, #4]
;driverrf4463pro.c,767 :: 		}
IT	AL
BAL	L_spi_write116
L_spi_write117:
;driverrf4463pro.c,769 :: 		nSEL = 0;                              // habilita escritura
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,771 :: 		for ( i = 0; i < tx_length; i++ ) {
MOVS	R0, #0
STRB	R0, [SP, #4]
L_spi_write118:
LDRB	R1, [SP, #8]
LDRB	R0, [SP, #4]
CMP	R0, R1
IT	CS
BCS	L_spi_write119
;driverrf4463pro.c,772 :: 		j = *( p + i );
LDRB	R1, [SP, #4]
LDR	R0, [SP, #12]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [SP, #5]
;driverrf4463pro.c,773 :: 		ucRf4463SPIByte( j );
LDRB	R0, [SP, #5]
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,771 :: 		for ( i = 0; i < tx_length; i++ ) {
LDRB	R0, [SP, #4]
ADDS	R0, R0, #1
STRB	R0, [SP, #4]
;driverrf4463pro.c,774 :: 		}
IT	AL
BAL	L_spi_write118
L_spi_write119:
;driverrf4463pro.c,776 :: 		nSEL = 1;                              // desabilita escritura
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,777 :: 		}
L_end_spi_write:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _spi_write
_check_cts:
;driverrf4463pro.c,782 :: 		unsigned char check_cts( void ) {           // This Command follows the Command and reads the response
SUB	SP, SP, #8
STR	LR, [SP, #0]
;driverrf4463pro.c,785 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,786 :: 		nSEL = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,787 :: 		ucRf4463SPIByte( 0x44 );
MOVS	R0, #68
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,788 :: 		i = ucRf4463SPIByte( 0 );
MOVS	R0, #0
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
STRB	R0, [SP, #4]
;driverrf4463pro.c,789 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,790 :: 		return ( i );
LDRB	R0, [SP, #4]
;driverrf4463pro.c,791 :: 		}
L_end_check_cts:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _check_cts
_spi_read:
;driverrf4463pro.c,796 :: 		void spi_read( unsigned char data_length, unsigned char api_command ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,800 :: 		p[ 0 ] = api_command;
ADD	R0, SP, #5
ADDS	R1, R0, #0
LDRB	R0, [SP, #16]
STRB	R0, [R1, #0]
;driverrf4463pro.c,801 :: 		i = 0;
MOVS	R0, #0
STRB	R0, [SP, #4]
;driverrf4463pro.c,802 :: 		while ( i != 0xFF ) {
L_spi_read121:
LDRB	R0, [SP, #4]
CMP	R0, #255
IT	EQ
BEQ	L_spi_read122
;driverrf4463pro.c,803 :: 		i = check_cts();                // Check if you can send Command
BL	_check_cts+0
STRB	R0, [SP, #4]
;driverrf4463pro.c,804 :: 		}
IT	AL
BAL	L_spi_read121
L_spi_read122:
;driverrf4463pro.c,806 :: 		spi_write( 1, p );    // Send Command
ADD	R0, SP, #5
PUSH	(R0)
MOVS	R0, #1
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,808 :: 		i = 0;
MOVS	R0, #0
STRB	R0, [SP, #4]
;driverrf4463pro.c,809 :: 		while ( i != 0xFF ) {
L_spi_read123:
LDRB	R0, [SP, #4]
CMP	R0, #255
IT	EQ
BEQ	L_spi_read124
;driverrf4463pro.c,810 :: 		i = check_cts();        //Check whether the data can be read
BL	_check_cts+0
STRB	R0, [SP, #4]
;driverrf4463pro.c,811 :: 		}
IT	AL
BAL	L_spi_read123
L_spi_read124:
;driverrf4463pro.c,813 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,814 :: 		nSEL = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,815 :: 		ucRf4463SPIByte( 0x44 );
MOVS	R0, #68
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,816 :: 		for ( i = 0; i < data_length; i++ ) {        // Read data
MOVS	R0, #0
STRB	R0, [SP, #4]
L_spi_read125:
LDRB	R1, [SP, #12]
LDRB	R0, [SP, #4]
CMP	R0, R1
IT	CS
BCS	L_spi_read126
;driverrf4463pro.c,817 :: 		spi_read_buf[ i ] = ucRf4463SPIByte( 0x00 );             // 0x00
LDRB	R1, [SP, #4]
MOVW	R0, #lo_addr(_spi_read_buf+0)
MOVT	R0, #hi_addr(_spi_read_buf+0)
ADDS	R0, R0, R1
STR	R0, [SP, #8]
MOVS	R0, #0
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
LDR	R1, [SP, #8]
STRB	R0, [R1, #0]
;driverrf4463pro.c,816 :: 		for ( i = 0; i < data_length; i++ ) {        // Read data
LDRB	R0, [SP, #4]
ADDS	R0, R0, #1
STRB	R0, [SP, #4]
;driverrf4463pro.c,818 :: 		}
IT	AL
BAL	L_spi_read125
L_spi_read126:
;driverrf4463pro.c,819 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,820 :: 		}
L_end_spi_read:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _spi_read
_spi_fast_read:
;driverrf4463pro.c,825 :: 		void spi_fast_read( unsigned char api_command ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,828 :: 		p[0] = api_command;
ADD	R0, SP, #5
ADDS	R1, R0, #0
LDRB	R0, [SP, #12]
STRB	R0, [R1, #0]
;driverrf4463pro.c,829 :: 		i = 0;
MOVS	R0, #0
STRB	R0, [SP, #4]
;driverrf4463pro.c,830 :: 		while ( i != 0xFF ) {
L_spi_fast_read128:
LDRB	R0, [SP, #4]
CMP	R0, #255
IT	EQ
BEQ	L_spi_fast_read129
;driverrf4463pro.c,831 :: 		i = check_cts();                // Check if you can send Command
BL	_check_cts+0
STRB	R0, [SP, #4]
;driverrf4463pro.c,832 :: 		}
IT	AL
BAL	L_spi_fast_read128
L_spi_fast_read129:
;driverrf4463pro.c,834 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,835 :: 		nSEL = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,836 :: 		ucRf4463SPIByte( api_command );    // Send Command
LDRB	R0, [SP, #12]
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,837 :: 		for ( i = 0; i < 4; i++ ) {
MOVS	R0, #0
STRB	R0, [SP, #4]
L_spi_fast_read130:
LDRB	R0, [SP, #4]
CMP	R0, #4
IT	CS
BCS	L_spi_fast_read131
;driverrf4463pro.c,838 :: 		spi_read_buf[ i ] = ucRf4463SPIByte( 0xFF );   // Read out all the 4 registers Value of
LDRB	R1, [SP, #4]
MOVW	R0, #lo_addr(_spi_read_buf+0)
MOVT	R0, #hi_addr(_spi_read_buf+0)
ADDS	R0, R0, R1
STR	R0, [SP, #8]
MOVS	R0, #255
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
LDR	R1, [SP, #8]
STRB	R0, [R1, #0]
;driverrf4463pro.c,837 :: 		for ( i = 0; i < 4; i++ ) {
LDRB	R0, [SP, #4]
ADDS	R0, R0, #1
STRB	R0, [SP, #4]
;driverrf4463pro.c,839 :: 		}
IT	AL
BAL	L_spi_fast_read130
L_spi_fast_read131:
;driverrf4463pro.c,840 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,841 :: 		}
L_end_spi_fast_read:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _spi_fast_read
_spi_write_fifo:
;driverrf4463pro.c,846 :: 		void spi_write_fifo( void ) {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;driverrf4463pro.c,849 :: 		i = 0;
MOVS	R0, #0
STRB	R0, [SP, #4]
;driverrf4463pro.c,850 :: 		while ( i != 0xFF ) {
L_spi_write_fifo133:
LDRB	R0, [SP, #4]
CMP	R0, #255
IT	EQ
BEQ	L_spi_write_fifo134
;driverrf4463pro.c,851 :: 		i = check_cts();                // Check if you can send Command
BL	_check_cts+0
STRB	R0, [SP, #4]
;driverrf4463pro.c,852 :: 		}
IT	AL
BAL	L_spi_write_fifo133
L_spi_write_fifo134:
;driverrf4463pro.c,854 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,855 :: 		nSEL = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,856 :: 		ucRf4463SPIByte( WRITE_TX_FIFO );
MOVS	R0, #102
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,858 :: 		if ( ucRF4463Mode == tx_test_mode) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_spi_write_fifo135
;driverrf4463pro.c,859 :: 		for ( i = 0; i < payload_length; i++ ) {
MOVS	R0, #0
STRB	R0, [SP, #4]
L_spi_write_fifo136:
LDRB	R0, [SP, #4]
CMP	R0, #66
IT	CS
BCS	L_spi_write_fifo137
;driverrf4463pro.c,860 :: 		ucRf4463SPIByte( tx_test_aa_data[ i ] );   // Send 10 test data
LDRB	R1, [SP, #4]
MOVW	R0, #lo_addr(_tx_test_aa_data+0)
MOVT	R0, #hi_addr(_tx_test_aa_data+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,859 :: 		for ( i = 0; i < payload_length; i++ ) {
LDRB	R0, [SP, #4]
ADDS	R0, R0, #1
STRB	R0, [SP, #4]
;driverrf4463pro.c,861 :: 		}
IT	AL
BAL	L_spi_write_fifo136
L_spi_write_fifo137:
;driverrf4463pro.c,862 :: 		}
IT	AL
BAL	L_spi_write_fifo139
L_spi_write_fifo135:
;driverrf4463pro.c,864 :: 		for ( i = 0; i < payload_length; i++ ) {
MOVS	R0, #0
STRB	R0, [SP, #4]
L_spi_write_fifo140:
LDRB	R0, [SP, #4]
CMP	R0, #66
IT	CS
BCS	L_spi_write_fifo141
;driverrf4463pro.c,865 :: 		ucRf4463SPIByte( ucRF4463TXdata[ i ] );
LDRB	R1, [SP, #4]
MOVW	R0, #lo_addr(_ucRF4463TXdata+0)
MOVT	R0, #hi_addr(_ucRF4463TXdata+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,864 :: 		for ( i = 0; i < payload_length; i++ ) {
LDRB	R0, [SP, #4]
ADDS	R0, R0, #1
STRB	R0, [SP, #4]
;driverrf4463pro.c,866 :: 		}
IT	AL
BAL	L_spi_write_fifo140
L_spi_write_fifo141:
;driverrf4463pro.c,867 :: 		}
L_spi_write_fifo139:
;driverrf4463pro.c,868 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,869 :: 		}
L_end_spi_write_fifo:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _spi_write_fifo
_spi_read_fifo:
;driverrf4463pro.c,874 :: 		void spi_read_fifo( void ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,877 :: 		i = 0;
MOVS	R0, #0
STRB	R0, [SP, #4]
;driverrf4463pro.c,878 :: 		while ( i != 0xFF ) {
L_spi_read_fifo143:
LDRB	R0, [SP, #4]
CMP	R0, #255
IT	EQ
BEQ	L_spi_read_fifo144
;driverrf4463pro.c,879 :: 		i = check_cts();                   // Check if you can send Command
BL	_check_cts+0
STRB	R0, [SP, #4]
;driverrf4463pro.c,880 :: 		}
IT	AL
BAL	L_spi_read_fifo143
L_spi_read_fifo144:
;driverrf4463pro.c,882 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,883 :: 		nSEL = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,884 :: 		ucRf4463SPIByte( READ_RX_FIFO );
MOVS	R0, #119
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,885 :: 		for ( i = 0; i < payload_length; i++ ) {
MOVS	R0, #0
STRB	R0, [SP, #4]
L_spi_read_fifo145:
LDRB	R0, [SP, #4]
CMP	R0, #66
IT	CS
BCS	L_spi_read_fifo146
;driverrf4463pro.c,886 :: 		rx_buf[ i ] = ucRf4463SPIByte( 0xFF );      // Receive 10 test data
LDRB	R1, [SP, #4]
MOVW	R0, #lo_addr(_rx_buf+0)
MOVT	R0, #hi_addr(_rx_buf+0)
ADDS	R0, R0, R1
STR	R0, [SP, #8]
MOVS	R0, #255
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
LDR	R1, [SP, #8]
STRB	R0, [R1, #0]
;driverrf4463pro.c,885 :: 		for ( i = 0; i < payload_length; i++ ) {
LDRB	R0, [SP, #4]
ADDS	R0, R0, #1
STRB	R0, [SP, #4]
;driverrf4463pro.c,887 :: 		}
IT	AL
BAL	L_spi_read_fifo145
L_spi_read_fifo146:
;driverrf4463pro.c,888 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,889 :: 		}
L_end_spi_read_fifo:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _spi_read_fifo
_VRF4463SDNReset:
;driverrf4463pro.c,894 :: 		void VRF4463SDNReset( void ) {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;driverrf4463pro.c,897 :: 		SDN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,898 :: 		Delay_ms( 6 );        // RF Module reset  DELAY
MOVW	R7, #8318
MOVT	R7, #5
NOP
NOP
L_VRF4463SDNReset148:
SUBS	R7, R7, #1
BNE	L_VRF4463SDNReset148
NOP
NOP
NOP
;driverrf4463pro.c,899 :: 		SDN = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,900 :: 		Delay_ms( 10 );       // Delay 10ms for RF module to enter working state
MOVW	R7, #35710
MOVT	R7, #8
NOP
NOP
L_VRF4463SDNReset150:
SUBS	R7, R7, #1
BNE	L_VRF4463SDNReset150
NOP
NOP
NOP
;driverrf4463pro.c,902 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,903 :: 		nSEL = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,904 :: 		for ( i = 0; i < 7; i++ ) {
MOVS	R0, #0
STRB	R0, [SP, #4]
L_VRF4463SDNReset152:
LDRB	R0, [SP, #4]
CMP	R0, #7
IT	CS
BCS	L_VRF4463SDNReset153
;driverrf4463pro.c,905 :: 		ucRf4463SPIByte( RF_POWER_UP_data[ i ] );   // send power up Command
LDRB	R1, [SP, #4]
MOVW	R0, #lo_addr(_RF_POWER_UP_data+0)
MOVT	R0, #hi_addr(_RF_POWER_UP_data+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,904 :: 		for ( i = 0; i < 7; i++ ) {
LDRB	R0, [SP, #4]
ADDS	R0, R0, #1
STRB	R0, [SP, #4]
;driverrf4463pro.c,906 :: 		}
IT	AL
BAL	L_VRF4463SDNReset152
L_VRF4463SDNReset153:
;driverrf4463pro.c,907 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,910 :: 		}
L_end_VRF4463SDNReset:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _VRF4463SDNReset
_ucASCIIToByte:
;utils.c,41 :: 		unsigned char ucASCIIToByte( unsigned char * pcASCIIBuffer ){
SUB	SP, SP, #4
;utils.c,42 :: 		ucMSBNibble = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,43 :: 		ucLSBNibble = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,45 :: 		ucMSBNibble = ( pcASCIIBuffer[ 0 ] - 0x30 );
LDR	R0, [SP, #4]
ADDS	R0, R0, #0
LDRB	R0, [R0, #0]
SUBW	R1, R0, #48
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,46 :: 		if( ucMSBNibble > 9 ){
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
LDRB	R0, [R0, #0]
CMP	R0, #9
IT	LS
BLS	L_ucASCIIToByte155
;utils.c,47 :: 		ucMSBNibble -= 7;
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
LDRB	R0, [R0, #0]
SUBS	R1, R0, #7
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,48 :: 		}
L_ucASCIIToByte155:
;utils.c,50 :: 		ucLSBNibble = ( pcASCIIBuffer[ 1 ] - 0x30 );
LDR	R0, [SP, #4]
ADDS	R0, R0, #1
LDRB	R0, [R0, #0]
SUBW	R1, R0, #48
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,51 :: 		if( ucLSBNibble > 9 ){
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
LDRB	R0, [R0, #0]
CMP	R0, #9
IT	LS
BLS	L_ucASCIIToByte156
;utils.c,52 :: 		ucLSBNibble -= 7;
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
LDRB	R0, [R0, #0]
SUBS	R1, R0, #7
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,53 :: 		}
L_ucASCIIToByte156:
;utils.c,55 :: 		return ( ucMSBNibble << 4 | ucLSBNibble );
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #4
UXTH	R1, R1
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
LDRB	R0, [R0, #0]
ORR	R0, R1, R0, LSL #0
UXTB	R0, R0
;utils.c,56 :: 		}
L_end_ucASCIIToByte:
ADD	SP, SP, #4
BX	LR
; end of _ucASCIIToByte
_vASCIIToHex:
;utils.c,61 :: 		void vASCIIToHex( unsigned char *pcHexConvertBuffer, unsigned char *pcASCIIConvertBuffer, unsigned char ucConversionLength ){
SUB	SP, SP, #8
;utils.c,62 :: 		unsigned char ucASCIICounter = 0;
MOVS	R0, #0
STRB	R0, [SP, #4]
;utils.c,64 :: 		for( ucASCIICounter = 0; ucASCIICounter < ucConversionLength; ucASCIICounter++ ){
MOVS	R0, #0
STRB	R0, [SP, #4]
L_vASCIIToHex157:
LDRB	R1, [SP, #16]
LDRB	R0, [SP, #4]
CMP	R0, R1
IT	CS
BCS	L_vASCIIToHex158
;utils.c,65 :: 		ucMSBNibble = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,66 :: 		ucLSBNibble = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,68 :: 		ucMSBNibble = ( pcASCIIConvertBuffer[ ucASCIICounter * 2 ] - 0x30 );
LDRB	R1, [SP, #4]
MOVS	R0, #2
SXTH	R0, R0
MULS	R1, R0, R1
SXTH	R1, R1
LDR	R0, [SP, #12]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
SUBW	R1, R0, #48
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,69 :: 		if( ucMSBNibble > 9 ){
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
LDRB	R0, [R0, #0]
CMP	R0, #9
IT	LS
BLS	L_vASCIIToHex160
;utils.c,70 :: 		ucMSBNibble -= 7;
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
LDRB	R0, [R0, #0]
SUBS	R1, R0, #7
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,71 :: 		}
L_vASCIIToHex160:
;utils.c,73 :: 		ucLSBNibble = ( pcASCIIConvertBuffer[ ( ucASCIICounter * 2 ) + 1 ] - 0x30 );
LDRB	R1, [SP, #4]
MOVS	R0, #2
SXTH	R0, R0
MULS	R0, R1, R0
SXTH	R0, R0
ADDS	R1, R0, #1
SXTH	R1, R1
LDR	R0, [SP, #12]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
SUBW	R1, R0, #48
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,74 :: 		if( ucLSBNibble > 9 ){
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
LDRB	R0, [R0, #0]
CMP	R0, #9
IT	LS
BLS	L_vASCIIToHex161
;utils.c,75 :: 		ucLSBNibble -= 7;
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
LDRB	R0, [R0, #0]
SUBS	R1, R0, #7
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,76 :: 		}
L_vASCIIToHex161:
;utils.c,78 :: 		pcHexConvertBuffer[ ucASCIICounter ] = ( ( ucMSBNibble << 4 ) | ucLSBNibble );
LDRB	R1, [SP, #4]
LDR	R0, [SP, #8]
ADDS	R2, R0, R1
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #4
UXTH	R1, R1
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
LDRB	R0, [R0, #0]
ORR	R0, R1, R0, LSL #0
STRB	R0, [R2, #0]
;utils.c,64 :: 		for( ucASCIICounter = 0; ucASCIICounter < ucConversionLength; ucASCIICounter++ ){
LDRB	R0, [SP, #4]
ADDS	R0, R0, #1
STRB	R0, [SP, #4]
;utils.c,79 :: 		}
IT	AL
BAL	L_vASCIIToHex157
L_vASCIIToHex158:
;utils.c,80 :: 		}
L_end_vASCIIToHex:
ADD	SP, SP, #8
BX	LR
; end of _vASCIIToHex
_vHexToASCII:
;utils.c,85 :: 		void vHexToASCII( unsigned char *pcASCIIConvertBuffer, unsigned char *pcHexConvertBuffer, unsigned char ucConversionLength ){
SUB	SP, SP, #8
;utils.c,86 :: 		unsigned char ucHexConvCounter = 0;
MOVS	R0, #0
STRB	R0, [SP, #4]
;utils.c,88 :: 		for( ucHexConvCounter = 0; ucHexConvCounter < ucConversionLength; ucHexConvCounter++ ){
MOVS	R0, #0
STRB	R0, [SP, #4]
L_vHexToASCII162:
LDRB	R1, [SP, #16]
LDRB	R0, [SP, #4]
CMP	R0, R1
IT	CS
BCS	L_vHexToASCII163
;utils.c,89 :: 		pcASCIIConvertBuffer[ ucHexConvCounter * 2 ]            = pcHexChar[ pcHexConvertBuffer[ ucHexConvCounter ] >> 4 ];
LDRB	R1, [SP, #4]
MOVS	R0, #2
SXTH	R0, R0
MULS	R1, R0, R1
SXTH	R1, R1
LDR	R0, [SP, #8]
ADDS	R2, R0, R1
LDRB	R1, [SP, #4]
LDR	R0, [SP, #12]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
LSRS	R1, R0, #4
UXTB	R1, R1
MOVW	R0, #lo_addr(_pcHexChar+0)
MOVT	R0, #hi_addr(_pcHexChar+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;utils.c,90 :: 		pcASCIIConvertBuffer[ ( ucHexConvCounter * 2 ) + 1 ]    = pcHexChar[ ( pcHexConvertBuffer[ ucHexConvCounter ] & 0x0F ) ];
LDRB	R1, [SP, #4]
MOVS	R0, #2
SXTH	R0, R0
MULS	R0, R1, R0
SXTH	R0, R0
ADDS	R1, R0, #1
SXTH	R1, R1
LDR	R0, [SP, #8]
ADDS	R2, R0, R1
LDRB	R1, [SP, #4]
LDR	R0, [SP, #12]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
AND	R1, R0, #15
UXTB	R1, R1
MOVW	R0, #lo_addr(_pcHexChar+0)
MOVT	R0, #hi_addr(_pcHexChar+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;utils.c,88 :: 		for( ucHexConvCounter = 0; ucHexConvCounter < ucConversionLength; ucHexConvCounter++ ){
LDRB	R0, [SP, #4]
ADDS	R0, R0, #1
STRB	R0, [SP, #4]
;utils.c,91 :: 		}
IT	AL
BAL	L_vHexToASCII162
L_vHexToASCII163:
;utils.c,92 :: 		}
L_end_vHexToASCII:
ADD	SP, SP, #8
BX	LR
; end of _vHexToASCII
_vBufferSetToZero:
;utils.c,97 :: 		void vBufferSetToZero( unsigned char * pcBufferToClean, unsigned int uslength ){
SUB	SP, SP, #8
;utils.c,98 :: 		unsigned int usPosition = 0;
MOVW	R0, #0
STRH	R0, [SP, #4]
;utils.c,100 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
MOVS	R0, #0
STRH	R0, [SP, #4]
L_vBufferSetToZero165:
LDRH	R1, [SP, #12]
LDRH	R0, [SP, #4]
CMP	R0, R1
IT	CS
BCS	L_vBufferSetToZero166
;utils.c,101 :: 		pcBufferToClean[ usPosition ] = 0x00;
LDRH	R1, [SP, #4]
LDR	R0, [SP, #8]
ADDS	R1, R0, R1
MOVS	R0, #0
STRB	R0, [R1, #0]
;utils.c,100 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
LDRH	R0, [SP, #4]
ADDS	R0, R0, #1
STRH	R0, [SP, #4]
;utils.c,102 :: 		}
IT	AL
BAL	L_vBufferSetToZero165
L_vBufferSetToZero166:
;utils.c,103 :: 		}
L_end_vBufferSetToZero:
ADD	SP, SP, #8
BX	LR
; end of _vBufferSetToZero
_vBufferSetTo255:
;utils.c,108 :: 		void vBufferSetTo255( unsigned char * pcBufferToClean, unsigned int uslength ){
SUB	SP, SP, #8
;utils.c,109 :: 		unsigned int usPosition = 0;
MOVW	R0, #0
STRH	R0, [SP, #4]
;utils.c,111 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
MOVS	R0, #0
STRH	R0, [SP, #4]
L_vBufferSetTo255168:
LDRH	R1, [SP, #12]
LDRH	R0, [SP, #4]
CMP	R0, R1
IT	CS
BCS	L_vBufferSetTo255169
;utils.c,112 :: 		pcBufferToClean[ usPosition ] = 0xFF;
LDRH	R1, [SP, #4]
LDR	R0, [SP, #8]
ADDS	R1, R0, R1
MOVS	R0, #255
STRB	R0, [R1, #0]
;utils.c,111 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
LDRH	R0, [SP, #4]
ADDS	R0, R0, #1
STRH	R0, [SP, #4]
;utils.c,113 :: 		}
IT	AL
BAL	L_vBufferSetTo255168
L_vBufferSetTo255169:
;utils.c,114 :: 		}
L_end_vBufferSetTo255:
ADD	SP, SP, #8
BX	LR
; end of _vBufferSetTo255
_vBufferSetToValue:
;utils.c,119 :: 		void vBufferSetToValue( unsigned char * pcBufferToClean, unsigned char ucValue, unsigned int uslength ){
SUB	SP, SP, #8
;utils.c,120 :: 		unsigned int usPosition = 0;
MOVW	R0, #0
STRH	R0, [SP, #4]
;utils.c,122 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
MOVS	R0, #0
STRH	R0, [SP, #4]
L_vBufferSetToValue171:
LDRH	R1, [SP, #16]
LDRH	R0, [SP, #4]
CMP	R0, R1
IT	CS
BCS	L_vBufferSetToValue172
;utils.c,123 :: 		pcBufferToClean[ usPosition ] = ucValue;
LDRH	R1, [SP, #4]
LDR	R0, [SP, #8]
ADDS	R1, R0, R1
LDRB	R0, [SP, #12]
STRB	R0, [R1, #0]
;utils.c,122 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
LDRH	R0, [SP, #4]
ADDS	R0, R0, #1
STRH	R0, [SP, #4]
;utils.c,124 :: 		}
IT	AL
BAL	L_vBufferSetToValue171
L_vBufferSetToValue172:
;utils.c,125 :: 		}
L_end_vBufferSetToValue:
ADD	SP, SP, #8
BX	LR
; end of _vBufferSetToValue
_vSerializeUUID:
;utils.c,130 :: 		void vSerializeUUID( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer ){
SUB	SP, SP, #8
;utils.c,131 :: 		unsigned char ucCounter = 0;
MOVS	R0, #0
STRB	R0, [SP, #4]
;utils.c,133 :: 		for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
MOVS	R0, #0
STRB	R0, [SP, #4]
L_vSerializeUUID174:
LDRB	R0, [SP, #4]
CMP	R0, #12
IT	CS
BCS	L_vSerializeUUID175
;utils.c,134 :: 		pcTextConvertBuffer[ ucCounter * 2 ]         = pcHexChar[ pcHexConvertBuffer[ ucCounter ] >> 4 ];
LDRB	R1, [SP, #4]
MOVS	R0, #2
SXTH	R0, R0
MULS	R1, R0, R1
SXTH	R1, R1
LDR	R0, [SP, #8]
ADDS	R2, R0, R1
LDRB	R1, [SP, #4]
LDR	R0, [SP, #12]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
LSRS	R1, R0, #4
UXTB	R1, R1
MOVW	R0, #lo_addr(_pcHexChar+0)
MOVT	R0, #hi_addr(_pcHexChar+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;utils.c,135 :: 		pcTextConvertBuffer[ ( ucCounter * 2 ) + 1 ] = pcHexChar[ pcHexConvertBuffer[ ucCounter ] & 0x0F ];
LDRB	R1, [SP, #4]
MOVS	R0, #2
SXTH	R0, R0
MULS	R0, R1, R0
SXTH	R0, R0
ADDS	R1, R0, #1
SXTH	R1, R1
LDR	R0, [SP, #8]
ADDS	R2, R0, R1
LDRB	R1, [SP, #4]
LDR	R0, [SP, #12]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
AND	R1, R0, #15
UXTB	R1, R1
MOVW	R0, #lo_addr(_pcHexChar+0)
MOVT	R0, #hi_addr(_pcHexChar+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;utils.c,133 :: 		for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
LDRB	R0, [SP, #4]
ADDS	R0, R0, #1
STRB	R0, [SP, #4]
;utils.c,136 :: 		}
IT	AL
BAL	L_vSerializeUUID174
L_vSerializeUUID175:
;utils.c,137 :: 		}
L_end_vSerializeUUID:
ADD	SP, SP, #8
BX	LR
; end of _vSerializeUUID
_vSerializeMACAddress:
;utils.c,142 :: 		void vSerializeMACAddress( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer ){
SUB	SP, SP, #20
STR	LR, [SP, #0]
;utils.c,143 :: 		unsigned int usCounter = 0;
MOVW	R0, #0
STRH	R0, [SP, #16]
;utils.c,146 :: 		vHexToASCII( pcDeviceMAC, pcHexConvertBuffer, 6 );
MOVS	R0, #6
PUSH	(R0)
LDR	R0, [SP, #28]
PUSH	(R0)
ADD	R0, SP, #12
PUSH	(R0)
BL	_vHexToASCII+0
ADD	SP, SP, #12
;utils.c,148 :: 		for( usCounter = 0; usCounter < 6; usCounter++ ){
MOVS	R0, #0
STRH	R0, [SP, #16]
L_vSerializeMACAddress177:
LDRH	R0, [SP, #16]
CMP	R0, #6
IT	CS
BCS	L_vSerializeMACAddress178
;utils.c,149 :: 		pcTextConvertBuffer[ usCounter * 3 ]         = pcDeviceMAC[ usCounter * 2 ];
LDRH	R1, [SP, #16]
MOVS	R0, #3
MULS	R1, R0, R1
UXTH	R1, R1
LDR	R0, [SP, #20]
ADDS	R2, R0, R1
LDRH	R1, [SP, #16]
MOVS	R0, #2
MULS	R1, R0, R1
UXTH	R1, R1
ADD	R0, SP, #4
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;utils.c,150 :: 		pcTextConvertBuffer[ ( usCounter * 3 ) + 1 ] = pcDeviceMAC[ ( usCounter * 2 ) + 1 ];
LDRH	R1, [SP, #16]
MOVS	R0, #3
MULS	R0, R1, R0
UXTH	R0, R0
ADDS	R1, R0, #1
UXTH	R1, R1
LDR	R0, [SP, #20]
ADDS	R2, R0, R1
LDRH	R1, [SP, #16]
MOVS	R0, #2
MULS	R0, R1, R0
UXTH	R0, R0
ADDS	R1, R0, #1
UXTH	R1, R1
ADD	R0, SP, #4
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;utils.c,151 :: 		if( usCounter != 5 ){
LDRH	R0, [SP, #16]
CMP	R0, #5
IT	EQ
BEQ	L_vSerializeMACAddress180
;utils.c,152 :: 		pcTextConvertBuffer[ ( usCounter * 3 ) + 2 ] = ':';
LDRH	R1, [SP, #16]
MOVS	R0, #3
MULS	R0, R1, R0
UXTH	R0, R0
ADDS	R1, R0, #2
UXTH	R1, R1
LDR	R0, [SP, #20]
ADDS	R1, R0, R1
MOVS	R0, #58
STRB	R0, [R1, #0]
;utils.c,153 :: 		}
L_vSerializeMACAddress180:
;utils.c,148 :: 		for( usCounter = 0; usCounter < 6; usCounter++ ){
LDRH	R0, [SP, #16]
ADDS	R0, R0, #1
STRH	R0, [SP, #16]
;utils.c,154 :: 		}
IT	AL
BAL	L_vSerializeMACAddress177
L_vSerializeMACAddress178:
;utils.c,155 :: 		pcTextConvertBuffer[ 18 ] = '\0';
LDR	R0, [SP, #20]
ADDW	R1, R0, #18
MOVS	R0, #0
STRB	R0, [R1, #0]
;utils.c,156 :: 		}
L_end_vSerializeMACAddress:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _vSerializeMACAddress
_vSerializeIPAddress:
;utils.c,161 :: 		void vSerializeIPAddress( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer ){
SUB	SP, SP, #16
STR	LR, [SP, #0]
;utils.c,162 :: 		unsigned char ucCounter = 0;
MOVS	R0, #0
STRB	R0, [SP, #13]
;utils.c,165 :: 		memset( pcTextConvertBuffer, '\0', sizeof( pcTextConvertBuffer ) );
MOVS	R2, #4
SXTH	R2, R2
MOVS	R1, #0
LDR	R0, [SP, #16]
BL	_memset+0
;utils.c,167 :: 		for( ucCounter = 0; ucCounter < 4; ucCounter++ ){
MOVS	R0, #0
STRB	R0, [SP, #13]
L_vSerializeIPAddress181:
LDRB	R0, [SP, #13]
CMP	R0, #4
IT	CS
BCS	L_vSerializeIPAddress182
;utils.c,169 :: 		ByteToStr( pcHexConvertBuffer[ ucCounter ], pcConvertText );
ADD	R5, SP, #4
LDRB	R1, [SP, #13]
LDR	R0, [SP, #20]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
UXTB	R4, R0
MOV	R1, R5
UXTB	R0, R4
BL	_ByteToStr+0
;utils.c,171 :: 		strcat( pcTextConvertBuffer, Ltrim( pcConvertText ) );
ADD	R4, SP, #4
MOV	R0, R4
BL	_Ltrim+0
MOV	R1, R0
LDR	R0, [SP, #16]
BL	_strcat+0
;utils.c,173 :: 		if( ucCounter != 3 ){
LDRB	R0, [SP, #13]
CMP	R0, #3
IT	EQ
BEQ	L_vSerializeIPAddress184
;utils.c,174 :: 		strcat( pcTextConvertBuffer, "." );
MOVS	R0, #46
STRB	R0, [SP, #11]
MOVS	R0, #0
STRB	R0, [SP, #12]
ADD	R0, SP, #11
MOV	R4, R0
MOV	R1, R4
LDR	R0, [SP, #16]
BL	_strcat+0
;utils.c,175 :: 		}
L_vSerializeIPAddress184:
;utils.c,167 :: 		for( ucCounter = 0; ucCounter < 4; ucCounter++ ){
LDRB	R0, [SP, #13]
ADDS	R0, R0, #1
STRB	R0, [SP, #13]
;utils.c,176 :: 		}
IT	AL
BAL	L_vSerializeIPAddress181
L_vSerializeIPAddress182:
;utils.c,177 :: 		}
L_end_vSerializeIPAddress:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _vSerializeIPAddress
_DMA2Strm7_interrupt:
;uarthandler.c,89 :: 		void DMA2Strm7_interrupt() iv IVT_INT_DMA2_Stream7 ics ICS_AUTO {
;uarthandler.c,91 :: 		if ( DMA2_HISRbits.FEIF7 ) {
MOVW	R0, #lo_addr(DMA2_HISRbits+0)
MOVT	R0, #hi_addr(DMA2_HISRbits+0)
_LX	[R0, ByteOffset(DMA2_HISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA2Strm7_interrupt185
;uarthandler.c,92 :: 		DMA2_HIFCRbits.CFEIF7 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_HIFCRbits+0)
MOVT	R0, #hi_addr(DMA2_HIFCRbits+0)
_SX	[R0, ByteOffset(DMA2_HIFCRbits+0)]
;uarthandler.c,93 :: 		}
IT	AL
BAL	L_DMA2Strm7_interrupt186
L_DMA2Strm7_interrupt185:
;uarthandler.c,94 :: 		else if ( DMA2_HISRbits.DMEIF7 ) {
MOVW	R0, #lo_addr(DMA2_HISRbits+0)
MOVT	R0, #hi_addr(DMA2_HISRbits+0)
_LX	[R0, ByteOffset(DMA2_HISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA2Strm7_interrupt187
;uarthandler.c,95 :: 		DMA2_HIFCRbits.CDMEIF7 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_HIFCRbits+0)
MOVT	R0, #hi_addr(DMA2_HIFCRbits+0)
_SX	[R0, ByteOffset(DMA2_HIFCRbits+0)]
;uarthandler.c,96 :: 		}
IT	AL
BAL	L_DMA2Strm7_interrupt188
L_DMA2Strm7_interrupt187:
;uarthandler.c,97 :: 		else if ( DMA2_HISRbits.TEIF7 ) {     // TRANSFER ERROR INTERRUPT FLAG
MOVW	R0, #lo_addr(DMA2_HISRbits+0)
MOVT	R0, #hi_addr(DMA2_HISRbits+0)
_LX	[R0, ByteOffset(DMA2_HISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA2Strm7_interrupt189
;uarthandler.c,98 :: 		DMA2_HIFCRbits.CTEIF7 = 1;       // limpia el flag de error
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_HIFCRbits+0)
MOVT	R0, #hi_addr(DMA2_HIFCRbits+0)
_SX	[R0, ByteOffset(DMA2_HIFCRbits+0)]
;uarthandler.c,100 :: 		}
IT	AL
BAL	L_DMA2Strm7_interrupt190
L_DMA2Strm7_interrupt189:
;uarthandler.c,101 :: 		else if ( DMA2_HISRbits.HTIF7 ) {
MOVW	R0, #lo_addr(DMA2_HISRbits+0)
MOVT	R0, #hi_addr(DMA2_HISRbits+0)
_LX	[R0, ByteOffset(DMA2_HISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA2Strm7_interrupt191
;uarthandler.c,102 :: 		DMA2_HIFCRbits.CHTIF7 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_HIFCRbits+0)
MOVT	R0, #hi_addr(DMA2_HIFCRbits+0)
_SX	[R0, ByteOffset(DMA2_HIFCRbits+0)]
;uarthandler.c,103 :: 		}
IT	AL
BAL	L_DMA2Strm7_interrupt192
L_DMA2Strm7_interrupt191:
;uarthandler.c,104 :: 		else if ( DMA2_HISRbits.TCIF7 ) {     // TRANSFER COMPLETE INTERRUPT FLAG = envio el frame completo
MOVW	R0, #lo_addr(DMA2_HISRbits+0)
MOVT	R0, #hi_addr(DMA2_HISRbits+0)
_LX	[R0, ByteOffset(DMA2_HISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA2Strm7_interrupt193
;uarthandler.c,105 :: 		DMA2_HIFCRbits.CTCIF7 = 1;       // limpia TODOS LOS FLAGS DE DMA2 CANAL 2
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_HIFCRbits+0)
MOVT	R0, #hi_addr(DMA2_HIFCRbits+0)
_SX	[R0, ByteOffset(DMA2_HIFCRbits+0)]
;uarthandler.c,106 :: 		DMA2_S7CRbits.EN = 0;            // EXPERIMENTAL PARA CAMBIAR EL VALOR DEL CONTADOR
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_S7CRbits+0)
MOVT	R0, #hi_addr(DMA2_S7CRbits+0)
_SX	[R0, ByteOffset(DMA2_S7CRbits+0)]
;uarthandler.c,108 :: 		}
L_DMA2Strm7_interrupt193:
L_DMA2Strm7_interrupt192:
L_DMA2Strm7_interrupt190:
L_DMA2Strm7_interrupt188:
L_DMA2Strm7_interrupt186:
;uarthandler.c,109 :: 		}
L_end_DMA2Strm7_interrupt:
BX	LR
; end of _DMA2Strm7_interrupt
_vUARTISR:
;uarthandler.c,115 :: 		void vUARTISR() iv IVT_INT_USART1 ics ICS_AUTO{
;uarthandler.c,116 :: 		LED_BLUE =~ LED_BLUE;
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_LX	[R0, ByteOffset(GPIOE_ODRbits+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_SX	[R0, ByteOffset(GPIOE_ODRbits+0)]
;uarthandler.c,118 :: 		if( USART1_SRbits.RXNE ){
MOVW	R0, #lo_addr(USART1_SRbits+0)
MOVT	R0, #hi_addr(USART1_SRbits+0)
_LX	[R0, ByteOffset(USART1_SRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUARTISR194
;uarthandler.c,119 :: 		ucData1 = USART1_DR;
MOVW	R0, #lo_addr(USART1_DR+0)
MOVT	R0, #hi_addr(USART1_DR+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
STRB	R1, [R0, #0]
;uarthandler.c,120 :: 		if ( ucData1 != CHR_CR && ucData1 != CHR_LF && ulUSART1ByteReceived < BUFFER_MAX_USART ) {
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #13
IT	EQ
BEQ	L_vUARTISR197
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	EQ
BEQ	L_vUARTISR197
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R0, [R0, #0]
CMP	R0, #4096
IT	CS
BCS	L_vUARTISR197
L__vUARTISR411:
;uarthandler.c,123 :: 		ucData1 == CHR_s ||
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #83
IT	EQ
BEQ	L__vUARTISR410
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #115
IT	EQ
BEQ	L__vUARTISR410
;uarthandler.c,124 :: 		ucData1 == CHR_U ||
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #85
IT	EQ
BEQ	L__vUARTISR410
;uarthandler.c,125 :: 		ucData1 == CHR_u ) &&
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #117
IT	EQ
BEQ	L__vUARTISR410
IT	AL
BAL	L_vUARTISR202
;uarthandler.c,126 :: 		ulUSART1ByteReceived == 0 ) {
L__vUARTISR410:
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_vUARTISR202
L__vUARTISR409:
;uarthandler.c,127 :: 		ucUSART1RXBuffer[ ulUSART1ByteReceived++ ] = ucData1;
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
STR	R1, [R0, #0]
;uarthandler.c,128 :: 		}
IT	AL
BAL	L_vUARTISR203
L_vUARTISR202:
;uarthandler.c,131 :: 		ucUSART1RXBuffer[ 0 ] == CHR_s ||
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
LDRB	R0, [R0, #0]
CMP	R0, #83
IT	EQ
BEQ	L__vUARTISR408
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
LDRB	R0, [R0, #0]
CMP	R0, #115
IT	EQ
BEQ	L__vUARTISR408
;uarthandler.c,132 :: 		ucUSART1RXBuffer[ 0 ] == CHR_U ||
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
LDRB	R0, [R0, #0]
CMP	R0, #85
IT	EQ
BEQ	L__vUARTISR408
;uarthandler.c,133 :: 		ucUSART1RXBuffer[ 0 ] == CHR_u ) {
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
LDRB	R0, [R0, #0]
CMP	R0, #117
IT	EQ
BEQ	L__vUARTISR408
IT	AL
BAL	L_vUARTISR206
L__vUARTISR408:
;uarthandler.c,134 :: 		ucUSART1RXBuffer[ ulUSART1ByteReceived++ ] = ucData1;
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
STR	R1, [R0, #0]
;uarthandler.c,135 :: 		}
L_vUARTISR206:
L_vUARTISR203:
;uarthandler.c,136 :: 		}
IT	AL
BAL	L_vUARTISR207
L_vUARTISR197:
;uarthandler.c,138 :: 		else if ( ucData1 == CHR_CR ) {
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #13
IT	NE
BNE	L_vUARTISR208
;uarthandler.c,139 :: 		ucUSART1RXBuffer[ ulUSART1ByteReceived++ ] = ucData1;
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
STR	R1, [R0, #0]
;uarthandler.c,140 :: 		}
IT	AL
BAL	L_vUARTISR209
L_vUARTISR208:
;uarthandler.c,142 :: 		else if ( ucData1 == CHR_LF && ucUSART1RXBuffer[ ulUSART1ByteReceived - 1 ] == CHR_CR ) {
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	NE
BNE	L_vUARTISR212
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R0, [R0, #0]
SUBS	R1, R0, #1
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
CMP	R0, #13
IT	NE
BNE	L_vUARTISR212
L__vUARTISR407:
;uarthandler.c,143 :: 		ucUSART1RXBuffer[ ulUSART1ByteReceived++ ] = ucData1;
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
STR	R1, [R0, #0]
;uarthandler.c,144 :: 		fUSART1Buffer = READY_TO_READ;
MOVS	R1, #1
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
STR	R1, [R0, #0]
;uarthandler.c,145 :: 		}
L_vUARTISR212:
L_vUARTISR209:
L_vUARTISR207:
;uarthandler.c,146 :: 		}
L_vUARTISR194:
;uarthandler.c,147 :: 		}
L_end_vUARTISR:
BX	LR
; end of _vUARTISR
_vUSARTStartMEMtoMEMZero:
;uarthandler.c,158 :: 		unsigned char vUSARTStartMEMtoMEMZero ( unsigned long *pcBufferDestination, unsigned long ulSizeInBytes ) {
SUB	SP, SP, #4
;uarthandler.c,160 :: 		while ( DMA2_S4CRbits.EN );
L_vUSARTStartMEMtoMEMZero213:
MOVW	R0, #lo_addr(DMA2_S4CRbits+0)
MOVT	R0, #hi_addr(DMA2_S4CRbits+0)
_LX	[R0, ByteOffset(DMA2_S4CRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUSARTStartMEMtoMEMZero214
IT	AL
BAL	L_vUSARTStartMEMtoMEMZero213
L_vUSARTStartMEMtoMEMZero214:
;uarthandler.c,162 :: 		if ( ulSizeInBytes > 0 ) {                // la transmision anterior termino?
LDR	R0, [SP, #8]
CMP	R0, #0
IT	LS
BLS	L_vUSARTStartMEMtoMEMZero215
;uarthandler.c,163 :: 		DMA2_S4CRbits.EN = 0;                  // Desabilita la recepci?n para poder modificar los par?metros
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_S4CRbits+0)
MOVT	R0, #hi_addr(DMA2_S4CRbits+0)
_SX	[R0, ByteOffset(DMA2_S4CRbits+0)]
;uarthandler.c,164 :: 		while ( DMA2_S4CRbits.EN );            // espera a que se haya desabilitado realmente
L_vUSARTStartMEMtoMEMZero216:
MOVW	R0, #lo_addr(DMA2_S4CRbits+0)
MOVT	R0, #hi_addr(DMA2_S4CRbits+0)
_LX	[R0, ByteOffset(DMA2_S4CRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUSARTStartMEMtoMEMZero217
IT	AL
BAL	L_vUSARTStartMEMtoMEMZero216
L_vUSARTStartMEMtoMEMZero217:
;uarthandler.c,167 :: 		DMA2_S4PAR = ( unsigned long ) &ucUSARTNull;          // Direccion de periferico a rutear
MOVW	R1, #lo_addr(_ucUSARTNull+0)
MOVT	R1, #hi_addr(_ucUSARTNull+0)
MOVW	R0, #lo_addr(DMA2_S4PAR+0)
MOVT	R0, #hi_addr(DMA2_S4PAR+0)
STR	R1, [R0, #0]
;uarthandler.c,168 :: 		DMA2_S4M0AR = ( unsigned long ) pcBufferDestination;  // Direccion de la memoria a rutear
LDR	R1, [SP, #4]
MOVW	R0, #lo_addr(DMA2_S4M0AR+0)
MOVT	R0, #hi_addr(DMA2_S4M0AR+0)
STR	R1, [R0, #0]
;uarthandler.c,170 :: 		DMA2_S4NDTR = ulSizeInBytes;           // Tamagno de datos a manejar (Header + Payload)
LDR	R1, [SP, #8]
MOVW	R0, #lo_addr(DMA2_S4NDTR+0)
MOVT	R0, #hi_addr(DMA2_S4NDTR+0)
STR	R1, [R0, #0]
;uarthandler.c,171 :: 		DMA2_S4CRbits.EN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_S4CRbits+0)
MOVT	R0, #hi_addr(DMA2_S4CRbits+0)
_SX	[R0, ByteOffset(DMA2_S4CRbits+0)]
;uarthandler.c,172 :: 		while ( DMA2_S4CRbits.EN );
L_vUSARTStartMEMtoMEMZero218:
MOVW	R0, #lo_addr(DMA2_S4CRbits+0)
MOVT	R0, #hi_addr(DMA2_S4CRbits+0)
_LX	[R0, ByteOffset(DMA2_S4CRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUSARTStartMEMtoMEMZero219
IT	AL
BAL	L_vUSARTStartMEMtoMEMZero218
L_vUSARTStartMEMtoMEMZero219:
;uarthandler.c,173 :: 		return 1;                              // indica que transmitio
MOVS	R0, #1
IT	AL
BAL	L_end_vUSARTStartMEMtoMEMZero
;uarthandler.c,174 :: 		}
L_vUSARTStartMEMtoMEMZero215:
;uarthandler.c,175 :: 		return 0;                                 // indica que NO transmitio
MOVS	R0, #0
;uarthandler.c,176 :: 		}
L_end_vUSARTStartMEMtoMEMZero:
ADD	SP, SP, #4
BX	LR
; end of _vUSARTStartMEMtoMEMZero
_vUSARTDMAMeToMemZero:
;uarthandler.c,180 :: 		void vUSARTDMAMeToMemZero ( void ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;uarthandler.c,182 :: 		RCC_AHB1ENRbits.DMA2EN = 1;    // Habilita clock para DMA2
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_AHB1ENRbits+0)
MOVT	R0, #hi_addr(RCC_AHB1ENRbits+0)
_SX	[R0, ByteOffset(RCC_AHB1ENRbits+0)]
;uarthandler.c,184 :: 		DMA2_S4CRbits.EN = 0;          // deshabilita DMA SPI4 RX (para poder modificar los parametros)
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_S4CRbits+0)
MOVT	R0, #hi_addr(DMA2_S4CRbits+0)
_SX	[R0, ByteOffset(DMA2_S4CRbits+0)]
;uarthandler.c,185 :: 		while ( DMA2_S4CRbits.EN );    // espera a que se haya desabilitado realmente
L_vUSARTDMAMeToMemZero220:
MOVW	R0, #lo_addr(DMA2_S4CRbits+0)
MOVT	R0, #hi_addr(DMA2_S4CRbits+0)
_LX	[R0, ByteOffset(DMA2_S4CRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUSARTDMAMeToMemZero221
IT	AL
BAL	L_vUSARTDMAMeToMemZero220
L_vUSARTDMAMeToMemZero221:
;uarthandler.c,187 :: 		DMA2_S4CRbits.CHSEL = 4;       // DMA2, Stream4, Canal 3 = vacio...
MOVS	R2, #4
MOVW	R1, #lo_addr(DMA2_S4CRbits+0)
MOVT	R1, #hi_addr(DMA2_S4CRbits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #25, #3
STR	R0, [R1, #0]
;uarthandler.c,188 :: 		DMA2_S4CRbits.PL = 3;          // Prioridad de canal
MOVS	R2, #3
MOVW	R1, #lo_addr(DMA2_S4CRbits+0)
MOVT	R1, #hi_addr(DMA2_S4CRbits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #16, #2
STR	R0, [R1, #0]
;uarthandler.c,189 :: 		DMA2_S4CRbits.MINC = 1;        // avanza en la direccion de la memoria apuntada
MOVS	R2, #1
SXTB	R2, R2
MOVW	R0, #lo_addr(DMA2_S4CRbits+0)
MOVT	R0, #hi_addr(DMA2_S4CRbits+0)
_SX	[R0, ByteOffset(DMA2_S4CRbits+0)]
;uarthandler.c,190 :: 		DMA2_S4CRbits.PINC = 0;        // avanza en la direccion del periferico apuntado
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_S4CRbits+0)
MOVT	R0, #hi_addr(DMA2_S4CRbits+0)
_SX	[R0, ByteOffset(DMA2_S4CRbits+0)]
;uarthandler.c,191 :: 		DIR0_DMA2_S4CR_bit = 0;        // direccion memoria a memoria
MOVW	R0, #lo_addr(DIR0_DMA2_S4CR_bit+0)
MOVT	R0, #hi_addr(DIR0_DMA2_S4CR_bit+0)
_SX	[R0, ByteOffset(DIR0_DMA2_S4CR_bit+0)]
;uarthandler.c,192 :: 		DIR1_DMA2_S4CR_bit = 1;
MOVW	R0, #lo_addr(DIR1_DMA2_S4CR_bit+0)
MOVT	R0, #hi_addr(DIR1_DMA2_S4CR_bit+0)
_SX	[R0, ByteOffset(DIR1_DMA2_S4CR_bit+0)]
;uarthandler.c,194 :: 		DMA2_S4FCRbits.DMDIS = 1;      // disable DirectMode
MOVW	R0, #lo_addr(DMA2_S4FCRbits+0)
MOVT	R0, #hi_addr(DMA2_S4FCRbits+0)
_SX	[R0, ByteOffset(DMA2_S4FCRbits+0)]
;uarthandler.c,196 :: 		DMA2_S4CRbits.TEIE = 1;        // Habilitacion de interrupcion por error en trasmision
MOVW	R0, #lo_addr(DMA2_S4CRbits+0)
MOVT	R0, #hi_addr(DMA2_S4CRbits+0)
_SX	[R0, ByteOffset(DMA2_S4CRbits+0)]
;uarthandler.c,197 :: 		DMA2_S4CRbits.TCIE = 1;        // Interrupcion por transferencia completa
MOVW	R0, #lo_addr(DMA2_S4CRbits+0)
MOVT	R0, #hi_addr(DMA2_S4CRbits+0)
_SX	[R0, ByteOffset(DMA2_S4CRbits+0)]
;uarthandler.c,199 :: 		NVIC_IntEnable( IVT_INT_DMA2_Stream4 );      // habilita el vector de interrupcion para DMA
MOVW	R0, #76
BL	_NVIC_IntEnable+0
;uarthandler.c,201 :: 		}
L_end_vUSARTDMAMeToMemZero:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUSARTDMAMeToMemZero
_vUSARTStartMEMtoMEM:
;uarthandler.c,206 :: 		unsigned char vUSARTStartMEMtoMEM ( unsigned long *pcBufferOrigin, unsigned long *pcBufferDestination, unsigned long ulSizeInBytes ) {
SUB	SP, SP, #4
;uarthandler.c,208 :: 		while ( DMA2_S1CRbits.EN );
L_vUSARTStartMEMtoMEM222:
MOVW	R0, #lo_addr(DMA2_S1CRbits+0)
MOVT	R0, #hi_addr(DMA2_S1CRbits+0)
_LX	[R0, ByteOffset(DMA2_S1CRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUSARTStartMEMtoMEM223
IT	AL
BAL	L_vUSARTStartMEMtoMEM222
L_vUSARTStartMEMtoMEM223:
;uarthandler.c,210 :: 		if ( ulSizeInBytes > 0 ) {                // la transmision anterior termino?
LDR	R0, [SP, #12]
CMP	R0, #0
IT	LS
BLS	L_vUSARTStartMEMtoMEM224
;uarthandler.c,211 :: 		DMA2_S1CRbits.EN = 0;                  // Desabilita la recepci?n para poder modificar los par?metros
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_S1CRbits+0)
MOVT	R0, #hi_addr(DMA2_S1CRbits+0)
_SX	[R0, ByteOffset(DMA2_S1CRbits+0)]
;uarthandler.c,212 :: 		while ( DMA2_S1CRbits.EN );            // espera a que se haya desabilitado realmente
L_vUSARTStartMEMtoMEM225:
MOVW	R0, #lo_addr(DMA2_S1CRbits+0)
MOVT	R0, #hi_addr(DMA2_S1CRbits+0)
_LX	[R0, ByteOffset(DMA2_S1CRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUSARTStartMEMtoMEM226
IT	AL
BAL	L_vUSARTStartMEMtoMEM225
L_vUSARTStartMEMtoMEM226:
;uarthandler.c,215 :: 		DMA2_S1PAR = ( unsigned long ) pcBufferOrigin;        // Direccion de periferico a rutear
LDR	R1, [SP, #4]
MOVW	R0, #lo_addr(DMA2_S1PAR+0)
MOVT	R0, #hi_addr(DMA2_S1PAR+0)
STR	R1, [R0, #0]
;uarthandler.c,216 :: 		DMA2_S1M0AR = ( unsigned long ) pcBufferDestination;  // Direccion de la memoria a rutear
LDR	R1, [SP, #8]
MOVW	R0, #lo_addr(DMA2_S1M0AR+0)
MOVT	R0, #hi_addr(DMA2_S1M0AR+0)
STR	R1, [R0, #0]
;uarthandler.c,218 :: 		DMA2_S1NDTR = ulSizeInBytes;           // Tamagno de datos a manejar (Header + Payload)
LDR	R1, [SP, #12]
MOVW	R0, #lo_addr(DMA2_S1NDTR+0)
MOVT	R0, #hi_addr(DMA2_S1NDTR+0)
STR	R1, [R0, #0]
;uarthandler.c,219 :: 		DMA2_S1CRbits.EN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_S1CRbits+0)
MOVT	R0, #hi_addr(DMA2_S1CRbits+0)
_SX	[R0, ByteOffset(DMA2_S1CRbits+0)]
;uarthandler.c,220 :: 		while ( DMA2_S1CRbits.EN );
L_vUSARTStartMEMtoMEM227:
MOVW	R0, #lo_addr(DMA2_S1CRbits+0)
MOVT	R0, #hi_addr(DMA2_S1CRbits+0)
_LX	[R0, ByteOffset(DMA2_S1CRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUSARTStartMEMtoMEM228
IT	AL
BAL	L_vUSARTStartMEMtoMEM227
L_vUSARTStartMEMtoMEM228:
;uarthandler.c,221 :: 		return 1;                              // indica que transmitio
MOVS	R0, #1
IT	AL
BAL	L_end_vUSARTStartMEMtoMEM
;uarthandler.c,222 :: 		}
L_vUSARTStartMEMtoMEM224:
;uarthandler.c,223 :: 		return 0;                                 // indica que NO transmitio
MOVS	R0, #0
;uarthandler.c,225 :: 		}
L_end_vUSARTStartMEMtoMEM:
ADD	SP, SP, #4
BX	LR
; end of _vUSARTStartMEMtoMEM
_vUSARTDMAMemToMem:
;uarthandler.c,229 :: 		void vUSARTDMAMemToMem ( void ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;uarthandler.c,230 :: 		RCC_AHB1ENRbits.DMA2EN = 1;    // Habilita clock para DMA2
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_AHB1ENRbits+0)
MOVT	R0, #hi_addr(RCC_AHB1ENRbits+0)
_SX	[R0, ByteOffset(RCC_AHB1ENRbits+0)]
;uarthandler.c,232 :: 		DMA2_S1CRbits.EN = 0;          // deshabilita DMA SPI4 RX (para poder modificar los parametros)
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_S1CRbits+0)
MOVT	R0, #hi_addr(DMA2_S1CRbits+0)
_SX	[R0, ByteOffset(DMA2_S1CRbits+0)]
;uarthandler.c,233 :: 		while ( DMA2_S1CRbits.EN );    // espera a que se haya desabilitado realmente
L_vUSARTDMAMemToMem229:
MOVW	R0, #lo_addr(DMA2_S1CRbits+0)
MOVT	R0, #hi_addr(DMA2_S1CRbits+0)
_LX	[R0, ByteOffset(DMA2_S1CRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUSARTDMAMemToMem230
IT	AL
BAL	L_vUSARTDMAMemToMem229
L_vUSARTDMAMemToMem230:
;uarthandler.c,235 :: 		DMA2_S1CRbits.CHSEL = 3;       // DMA2, Stream1, Canal 3 = vacio...
MOVS	R2, #3
MOVW	R1, #lo_addr(DMA2_S1CRbits+0)
MOVT	R1, #hi_addr(DMA2_S1CRbits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #25, #3
STR	R0, [R1, #0]
;uarthandler.c,236 :: 		DMA2_S1CRbits.PL = 3;          // Prioridad de canal
MOVS	R2, #3
MOVW	R1, #lo_addr(DMA2_S1CRbits+0)
MOVT	R1, #hi_addr(DMA2_S1CRbits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #16, #2
STR	R0, [R1, #0]
;uarthandler.c,237 :: 		DMA2_S1CRbits.MINC = 1;        // avanza en la direccion de la memoria apuntada
MOVS	R2, #1
SXTB	R2, R2
MOVW	R0, #lo_addr(DMA2_S1CRbits+0)
MOVT	R0, #hi_addr(DMA2_S1CRbits+0)
_SX	[R0, ByteOffset(DMA2_S1CRbits+0)]
;uarthandler.c,238 :: 		DMA2_S1CRbits.PINC = 1;        // avanza en la direccion del periferico apuntado
MOVW	R0, #lo_addr(DMA2_S1CRbits+0)
MOVT	R0, #hi_addr(DMA2_S1CRbits+0)
_SX	[R0, ByteOffset(DMA2_S1CRbits+0)]
;uarthandler.c,239 :: 		DIR0_DMA2_S1CR_bit = 0;        // direccion memoria a memoria
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(DIR0_DMA2_S1CR_bit+0)
MOVT	R0, #hi_addr(DIR0_DMA2_S1CR_bit+0)
_SX	[R0, ByteOffset(DIR0_DMA2_S1CR_bit+0)]
;uarthandler.c,240 :: 		DIR1_DMA2_S1CR_bit = 1;
MOVW	R0, #lo_addr(DIR1_DMA2_S1CR_bit+0)
MOVT	R0, #hi_addr(DIR1_DMA2_S1CR_bit+0)
_SX	[R0, ByteOffset(DIR1_DMA2_S1CR_bit+0)]
;uarthandler.c,242 :: 		DMA2_S1FCRbits.DMDIS = 1;      // disable DirectMode
MOVW	R0, #lo_addr(DMA2_S1FCRbits+0)
MOVT	R0, #hi_addr(DMA2_S1FCRbits+0)
_SX	[R0, ByteOffset(DMA2_S1FCRbits+0)]
;uarthandler.c,244 :: 		DMA2_S1CRbits.TEIE = 1;        // Habilitacion de interrupcion por error en trasmision
MOVW	R0, #lo_addr(DMA2_S1CRbits+0)
MOVT	R0, #hi_addr(DMA2_S1CRbits+0)
_SX	[R0, ByteOffset(DMA2_S1CRbits+0)]
;uarthandler.c,245 :: 		DMA2_S1CRbits.TCIE = 1;        // Interrupcion por transferencia completa
MOVW	R0, #lo_addr(DMA2_S1CRbits+0)
MOVT	R0, #hi_addr(DMA2_S1CRbits+0)
_SX	[R0, ByteOffset(DMA2_S1CRbits+0)]
;uarthandler.c,247 :: 		NVIC_IntEnable( IVT_INT_DMA2_Stream1 );      // habilita el vector de interrupcion para DMA
MOVW	R0, #73
BL	_NVIC_IntEnable+0
;uarthandler.c,249 :: 		}
L_end_vUSARTDMAMemToMem:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUSARTDMAMemToMem
_vUSART1Start_TX:
;uarthandler.c,255 :: 		unsigned char vUSART1Start_TX ( unsigned long *ucBuffer, unsigned long ulSize ) {
SUB	SP, SP, #4
;uarthandler.c,256 :: 		while ( DMA2_S7CRbits.EN || !USART1_SRbits.TC );
L_vUSART1Start_TX231:
MOVW	R0, #lo_addr(DMA2_S7CRbits+0)
MOVT	R0, #hi_addr(DMA2_S7CRbits+0)
_LX	[R0, ByteOffset(DMA2_S7CRbits+0)]
CMP	R0, #0
IT	NE
BNE	L__vUSART1Start_TX414
MOVW	R0, #lo_addr(USART1_SRbits+0)
MOVT	R0, #hi_addr(USART1_SRbits+0)
_LX	[R0, ByteOffset(USART1_SRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L__vUSART1Start_TX414
IT	AL
BAL	L_vUSART1Start_TX232
L__vUSART1Start_TX414:
IT	AL
BAL	L_vUSART1Start_TX231
L_vUSART1Start_TX232:
;uarthandler.c,258 :: 		if ( USART1_CR1bits.UE && USART1_SRbits.TC && ulSize > 0 ) { // la transmision anterior termino?
MOVW	R0, #lo_addr(USART1_CR1bits+0)
MOVT	R0, #hi_addr(USART1_CR1bits+0)
_LX	[R0, ByteOffset(USART1_CR1bits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUSART1Start_TX237
MOVW	R0, #lo_addr(USART1_SRbits+0)
MOVT	R0, #hi_addr(USART1_SRbits+0)
_LX	[R0, ByteOffset(USART1_SRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUSART1Start_TX237
LDR	R0, [SP, #8]
CMP	R0, #0
IT	LS
BLS	L_vUSART1Start_TX237
L__vUSART1Start_TX413:
;uarthandler.c,259 :: 		DMA2_S7CRbits.EN = 0;                       // Desabilita la recepci?n para poder modificar los par?metros
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_S7CRbits+0)
MOVT	R0, #hi_addr(DMA2_S7CRbits+0)
_SX	[R0, ByteOffset(DMA2_S7CRbits+0)]
;uarthandler.c,260 :: 		while ( DMA2_S7CRbits.EN );                 // espera a que se haya desabilitado realmente
L_vUSART1Start_TX238:
MOVW	R0, #lo_addr(DMA2_S7CRbits+0)
MOVT	R0, #hi_addr(DMA2_S7CRbits+0)
_LX	[R0, ByteOffset(DMA2_S7CRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUSART1Start_TX239
IT	AL
BAL	L_vUSART1Start_TX238
L_vUSART1Start_TX239:
;uarthandler.c,262 :: 		DMA2_S7M0AR = ( unsigned long ) ucBuffer;   // Direcci?n de la memoria a rutear
LDR	R1, [SP, #4]
MOVW	R0, #lo_addr(DMA2_S7M0AR+0)
MOVT	R0, #hi_addr(DMA2_S7M0AR+0)
STR	R1, [R0, #0]
;uarthandler.c,263 :: 		DMA2_S7NDTR = ulSize;                       // Tama?o de datos a manejar
LDR	R1, [SP, #8]
MOVW	R0, #lo_addr(DMA2_S7NDTR+0)
MOVT	R0, #hi_addr(DMA2_S7NDTR+0)
STR	R1, [R0, #0]
;uarthandler.c,264 :: 		DMA2_S7CRbits.EN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_S7CRbits+0)
MOVT	R0, #hi_addr(DMA2_S7CRbits+0)
_SX	[R0, ByteOffset(DMA2_S7CRbits+0)]
;uarthandler.c,265 :: 		while ( DMA2_S7CRbits.EN || !USART1_SRbits.TC );
L_vUSART1Start_TX240:
MOVW	R0, #lo_addr(DMA2_S7CRbits+0)
MOVT	R0, #hi_addr(DMA2_S7CRbits+0)
_LX	[R0, ByteOffset(DMA2_S7CRbits+0)]
CMP	R0, #0
IT	NE
BNE	L__vUSART1Start_TX412
MOVW	R0, #lo_addr(USART1_SRbits+0)
MOVT	R0, #hi_addr(USART1_SRbits+0)
_LX	[R0, ByteOffset(USART1_SRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L__vUSART1Start_TX412
IT	AL
BAL	L_vUSART1Start_TX241
L__vUSART1Start_TX412:
IT	AL
BAL	L_vUSART1Start_TX240
L_vUSART1Start_TX241:
;uarthandler.c,266 :: 		return 1;                                   // indica que transmitio
MOVS	R0, #1
IT	AL
BAL	L_end_vUSART1Start_TX
;uarthandler.c,267 :: 		}
L_vUSART1Start_TX237:
;uarthandler.c,268 :: 		return 0;                                      // indica que NO transmitio
MOVS	R0, #0
;uarthandler.c,270 :: 		}
L_end_vUSART1Start_TX:
ADD	SP, SP, #4
BX	LR
; end of _vUSART1Start_TX
_vInitDMAUSART1_TX:
;uarthandler.c,274 :: 		void vInitDMAUSART1_TX () {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;uarthandler.c,275 :: 		RCC_AHB1ENRbits.DMA2EN = 1;    // Habilita clock para DMA2
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_AHB1ENRbits+0)
MOVT	R0, #hi_addr(RCC_AHB1ENRbits+0)
_SX	[R0, ByteOffset(RCC_AHB1ENRbits+0)]
;uarthandler.c,277 :: 		DMA2_S7CRbits.EN = 0;          // deshabilita DMA USART1 TX (para poder modificar los parametros)
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_S7CRbits+0)
MOVT	R0, #hi_addr(DMA2_S7CRbits+0)
_SX	[R0, ByteOffset(DMA2_S7CRbits+0)]
;uarthandler.c,278 :: 		while ( DMA2_S7CRbits.EN );    // espera a que se haya desabilitado realmente
L_vInitDMAUSART1_TX244:
MOVW	R0, #lo_addr(DMA2_S7CRbits+0)
MOVT	R0, #hi_addr(DMA2_S7CRbits+0)
_LX	[R0, ByteOffset(DMA2_S7CRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vInitDMAUSART1_TX245
IT	AL
BAL	L_vInitDMAUSART1_TX244
L_vInitDMAUSART1_TX245:
;uarthandler.c,281 :: 		DMA2_S7PAR = ( unsigned long ) &USART1_DR;           // Direccion fisica de periferico a rutear
MOVW	R1, #lo_addr(USART1_DR+0)
MOVT	R1, #hi_addr(USART1_DR+0)
MOVW	R0, #lo_addr(DMA2_S7PAR+0)
MOVT	R0, #hi_addr(DMA2_S7PAR+0)
STR	R1, [R0, #0]
;uarthandler.c,283 :: 		DMA2_S7CRbits.CHSEL = 4;       // DMA2, Stream7, Canal 4 = USART1_TX
MOVS	R2, #4
MOVW	R1, #lo_addr(DMA2_S7CRbits+0)
MOVT	R1, #hi_addr(DMA2_S7CRbits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #25, #3
STR	R0, [R1, #0]
;uarthandler.c,284 :: 		DMA2_S7CRbits.PL = 3;          // Prioridad de canal
MOVS	R2, #3
MOVW	R1, #lo_addr(DMA2_S7CRbits+0)
MOVT	R1, #hi_addr(DMA2_S7CRbits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #16, #2
STR	R0, [R1, #0]
;uarthandler.c,285 :: 		DMA2_S7CRbits.MINC = 1;        // avanza en la direccion de la memoria apuntada
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_S7CRbits+0)
MOVT	R0, #hi_addr(DMA2_S7CRbits+0)
_SX	[R0, ByteOffset(DMA2_S7CRbits+0)]
;uarthandler.c,286 :: 		DIR0_DMA2_S7CR_bit = 1;        // direccion memoria a periferico
MOVW	R0, #lo_addr(DIR0_DMA2_S7CR_bit+0)
MOVT	R0, #hi_addr(DIR0_DMA2_S7CR_bit+0)
_SX	[R0, ByteOffset(DIR0_DMA2_S7CR_bit+0)]
;uarthandler.c,287 :: 		DMA2_S7CRbits.TEIE = 1;        // Habilitacion de interrupcion por error en trasmision
MOVW	R0, #lo_addr(DMA2_S7CRbits+0)
MOVT	R0, #hi_addr(DMA2_S7CRbits+0)
_SX	[R0, ByteOffset(DMA2_S7CRbits+0)]
;uarthandler.c,288 :: 		DMA2_S7CRbits.TCIE = 1;        // Interrupcion por transferencia completa
MOVW	R0, #lo_addr(DMA2_S7CRbits+0)
MOVT	R0, #hi_addr(DMA2_S7CRbits+0)
_SX	[R0, ByteOffset(DMA2_S7CRbits+0)]
;uarthandler.c,290 :: 		NVIC_IntEnable( IVT_INT_DMA2_Stream7 );      // habilita el vector de interrupcion para DMA
MOVW	R0, #86
BL	_NVIC_IntEnable+0
;uarthandler.c,292 :: 		}
L_end_vInitDMAUSART1_TX:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vInitDMAUSART1_TX
_vUSARTConfigUSART1:
;uarthandler.c,297 :: 		void vUSARTConfigUSART1 ( unsigned long ulBaudRate ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;uarthandler.c,299 :: 		UART1_Init_Advanced( ulBaudRate, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PB67 );
MOVW	R0, #lo_addr(__GPIO_MODULE_USART1_PB67+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_USART1_PB67+0)
PUSH	(R0)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
LDR	R0, [SP, #8]
BL	_UART1_Init_Advanced+0
ADD	SP, SP, #4
;uarthandler.c,300 :: 		USART1_CR1bits.UE = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(USART1_CR1bits+0)
MOVT	R0, #hi_addr(USART1_CR1bits+0)
_SX	[R0, ByteOffset(USART1_CR1bits+0)]
;uarthandler.c,302 :: 		ulClk = Clock_MHz() * 1000000;         // paso extra para verificacion en depuracion
MOVW	R1, #31232
MOVT	R1, #2563
MOVW	R0, #lo_addr(_ulClk+0)
MOVT	R0, #hi_addr(_ulClk+0)
STR	R1, [R0, #0]
;uarthandler.c,306 :: 		USART1_CR1bits.UE = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(USART1_CR1bits+0)
MOVT	R0, #hi_addr(USART1_CR1bits+0)
_SX	[R0, ByteOffset(USART1_CR1bits+0)]
;uarthandler.c,308 :: 		}
L_end_vUSARTConfigUSART1:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUSARTConfigUSART1
_vUSARTCleanBuffer:
;uarthandler.c,314 :: 		void vUSARTCleanBuffer ( unsigned char *ucBuffer, unsigned int uiCnt ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;uarthandler.c,316 :: 		vUSARTStartMEMtoMEMZero( ucBuffer, uiCnt );
LDRH	R0, [SP, #8]
PUSH	(R0)
LDR	R0, [SP, #8]
PUSH	(R0)
BL	_vUSARTStartMEMtoMEMZero+0
ADD	SP, SP, #8
;uarthandler.c,317 :: 		}
L_end_vUSARTCleanBuffer:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUSARTCleanBuffer
_vUSARTReceivedFromUSART1:
;uarthandler.c,321 :: 		void vUSARTReceivedFromUSART1 ( ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;uarthandler.c,323 :: 		vUSARTCleanBuffer( ucUSARTActiveBuffer1, ulUSARTActiveBuffer1BytesReceived ); // borra todo el buffer
MOVW	R0, #lo_addr(_ulUSARTActiveBuffer1BytesReceived+0)
MOVT	R0, #hi_addr(_ulUSARTActiveBuffer1BytesReceived+0)
LDR	R0, [R0, #0]
PUSH	(R0)
MOVW	R0, #lo_addr(_ucUSARTActiveBuffer1+0)
MOVT	R0, #hi_addr(_ucUSARTActiveBuffer1+0)
PUSH	(R0)
BL	_vUSARTCleanBuffer+0
ADD	SP, SP, #8
;uarthandler.c,325 :: 		vUSARTStartMEMtoMEM( ucUSART1RXBuffer, ucUSARTActiveBuffer1, ulUSART1ByteReceived ); // copia el buffer de entrada
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R0, [R0, #0]
PUSH	(R0)
MOVW	R0, #lo_addr(_ucUSARTActiveBuffer1+0)
MOVT	R0, #hi_addr(_ucUSARTActiveBuffer1+0)
PUSH	(R0)
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
PUSH	(R0)
BL	_vUSARTStartMEMtoMEM+0
ADD	SP, SP, #12
;uarthandler.c,326 :: 		vUSARTCleanBuffer( ucUSART1RXBuffer, ulUSART1ByteReceived );          // lo limpia
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R0, [R0, #0]
PUSH	(R0)
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
PUSH	(R0)
BL	_vUSARTCleanBuffer+0
ADD	SP, SP, #8
;uarthandler.c,327 :: 		ulUSARTActiveBuffer1BytesReceived = ulUSART1ByteReceived;             // le pasa el valor
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ulUSARTActiveBuffer1BytesReceived+0)
MOVT	R0, #hi_addr(_ulUSARTActiveBuffer1BytesReceived+0)
STR	R1, [R0, #0]
;uarthandler.c,328 :: 		ulUSART1ByteReceived = 0;                                             // pone a cero el contador
MOVS	R1, #0
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
STR	R1, [R0, #0]
;uarthandler.c,329 :: 		fUSART1Buffer = CLEAR_TO_WRITE;                                       // indica que esta limpio
MOVS	R1, #0
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
STR	R1, [R0, #0]
;uarthandler.c,330 :: 		vRF4463MainCommandProcessor( ucUSARTActiveBuffer1 );
MOVW	R0, #lo_addr(_ucUSARTActiveBuffer1+0)
MOVT	R0, #hi_addr(_ucUSARTActiveBuffer1+0)
PUSH	(R0)
BL	_vRF4463MainCommandProcessor+0
ADD	SP, SP, #4
;uarthandler.c,331 :: 		}
L_end_vUSARTReceivedFromUSART1:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUSARTReceivedFromUSART1
_vUARTRxMessage:
;uarthandler.c,337 :: 		void vUARTRxMessage(){
SUB	SP, SP, #8
;uarthandler.c,338 :: 		unsigned int usCounter = 0;
MOVW	R0, #0
STRH	R0, [SP, #4]
;uarthandler.c,350 :: 		usUARTMessageLength = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_usUARTMessageLength+0)
MOVT	R0, #hi_addr(_usUARTMessageLength+0)
STRH	R1, [R0, #0]
;uarthandler.c,351 :: 		}
L_end_vUARTRxMessage:
ADD	SP, SP, #8
BX	LR
; end of _vUARTRxMessage
_Timer2_interrupt:
;DriverRF4463PROMain.c,92 :: 		void Timer2_interrupt() iv IVT_INT_TIM2 {
;DriverRF4463PROMain.c,93 :: 		TIM2_SR.UIF = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_SR+0)
MOVT	R0, #hi_addr(TIM2_SR+0)
_SX	[R0, ByteOffset(TIM2_SR+0)]
;DriverRF4463PROMain.c,94 :: 		Flag.rf_reach_timeout = 1; //Enter your code here
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,95 :: 		Flag.reach_1s = 1;
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,96 :: 		}
L_end_Timer2_interrupt:
BX	LR
; end of _Timer2_interrupt
_vRF4463MainApplyChanges:
;DriverRF4463PROMain.c,100 :: 		void vRF4463MainApplyChanges () {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;DriverRF4463PROMain.c,101 :: 		VRF4463SDNReset();
BL	_VRF4463SDNReset+0
;DriverRF4463PROMain.c,102 :: 		vRF4463Init();
BL	_vRF4463Init+0
;DriverRF4463PROMain.c,103 :: 		vRF4463ClearInterrupts();
BL	_vRF4463ClearInterrupts+0
;DriverRF4463PROMain.c,104 :: 		}
L_end_vRF4463MainApplyChanges:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vRF4463MainApplyChanges
_vRF4463MainSetTXString:
;DriverRF4463PROMain.c,107 :: 		void vRF4463MainSetTXString () {
SUB	SP, SP, #4
;DriverRF4463PROMain.c,112 :: 		}
L_end_vRF4463MainSetTXString:
ADD	SP, SP, #4
BX	LR
; end of _vRF4463MainSetTXString
_vRF4463MainCommandProcessor:
;DriverRF4463PROMain.c,116 :: 		void vRF4463MainCommandProcessor ( unsigned char *ucBuffer ) {
SUB	SP, SP, #112
STR	LR, [SP, #0]
;DriverRF4463PROMain.c,117 :: 		unsigned char ucCommand [ 32 ] = { 0x00 };
ADD	R11, SP, #4
ADD	R10, R11, #103
MOVW	R12, #lo_addr(?ICSvRF4463MainCommandProcessor_ucCommand_L0+0)
MOVT	R12, #hi_addr(?ICSvRF4463MainCommandProcessor_ucCommand_L0+0)
BL	___CC2DW+0
;DriverRF4463PROMain.c,118 :: 		unsigned long ulArgument = 0;
;DriverRF4463PROMain.c,119 :: 		unsigned char ucLongArgument[ 64 ] = { 0x00 };     // Espera argumentos de hasta 11 bytes
;DriverRF4463PROMain.c,120 :: 		unsigned char ucCounterBuffer = 0;
;DriverRF4463PROMain.c,121 :: 		unsigned char ucCounterCommand = 0;
;DriverRF4463PROMain.c,122 :: 		unsigned char ucCounterLongArgument = 0;
;DriverRF4463PROMain.c,125 :: 		if ( ucBuffer[ 0 ] > '@' && ucBuffer[ 0 ] <= 'z' ) {
LDR	R0, [SP, #112]
ADDS	R0, R0, #0
LDRB	R0, [R0, #0]
CMP	R0, #64
IT	LS
BLS	L_vRF4463MainCommandProcessor248
LDR	R0, [SP, #112]
ADDS	R0, R0, #0
LDRB	R0, [R0, #0]
CMP	R0, #122
IT	HI
BHI	L_vRF4463MainCommandProcessor248
L__vRF4463MainCommandProcessor430:
;DriverRF4463PROMain.c,127 :: 		while ( ucBuffer[ ucCounterBuffer ] != '|' && ucCounterCommand < 32 ) {      // primer token
L_vRF4463MainCommandProcessor249:
LDRB	R1, [SP, #104]
LDR	R0, [SP, #112]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
CMP	R0, #124
IT	EQ
BEQ	L_vRF4463MainCommandProcessor250
LDRB	R0, [SP, #105]
CMP	R0, #32
IT	CS
BCS	L_vRF4463MainCommandProcessor250
L__vRF4463MainCommandProcessor429:
;DriverRF4463PROMain.c,128 :: 		ucCommand[ ucCounterCommand++ ] = toupper( ucBuffer[ ucCounterBuffer++ ] );
ADD	R1, SP, #4
LDRB	R0, [SP, #105]
ADDS	R0, R1, R0
STR	R0, [SP, #108]
LDRB	R1, [SP, #104]
LDR	R0, [SP, #112]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
UXTB	R4, R0
UXTB	R0, R4
BL	_toupper+0
LDR	R1, [SP, #108]
STRB	R0, [R1, #0]
LDRB	R0, [SP, #105]
ADDS	R0, R0, #1
STRB	R0, [SP, #105]
LDRB	R0, [SP, #104]
ADDS	R0, R0, #1
STRB	R0, [SP, #104]
;DriverRF4463PROMain.c,129 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor249
L_vRF4463MainCommandProcessor250:
;DriverRF4463PROMain.c,131 :: 		ucCounterBuffer++;                                                           // evita el Token
LDRB	R0, [SP, #104]
ADDS	R0, R0, #1
STRB	R0, [SP, #104]
;DriverRF4463PROMain.c,133 :: 		while ( ucBuffer[ ucCounterBuffer ] != CHR_CR && ucCounterLongArgument < 64 ) {   // segundo token
L_vRF4463MainCommandProcessor253:
LDRB	R1, [SP, #104]
LDR	R0, [SP, #112]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
CMP	R0, #13
IT	EQ
BEQ	L_vRF4463MainCommandProcessor254
LDRB	R0, [SP, #106]
CMP	R0, #64
IT	CS
BCS	L_vRF4463MainCommandProcessor254
L__vRF4463MainCommandProcessor428:
;DriverRF4463PROMain.c,134 :: 		ucLongArgument[ ucCounterLongArgument ] = ucBuffer[ ucCounterBuffer ] ;   //  toupper(
ADD	R1, SP, #40
LDRB	R0, [SP, #106]
ADDS	R2, R1, R0
LDRB	R1, [SP, #104]
LDR	R0, [SP, #112]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;DriverRF4463PROMain.c,135 :: 		ucCounterBuffer++;
LDRB	R0, [SP, #104]
ADDS	R0, R0, #1
STRB	R0, [SP, #104]
;DriverRF4463PROMain.c,136 :: 		ucCounterLongArgument++;
LDRB	R0, [SP, #106]
ADDS	R0, R0, #1
STRB	R0, [SP, #106]
;DriverRF4463PROMain.c,137 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor253
L_vRF4463MainCommandProcessor254:
;DriverRF4463PROMain.c,138 :: 		}
L_vRF4463MainCommandProcessor248:
;DriverRF4463PROMain.c,142 :: 		if ( memcmp( CMD_RADIO_POWER_SET, ucCommand, sizeof( CMD_RADIO_POWER_SET ) ) == 0x00 ) {
ADD	R4, SP, #4
MOVS	R2, #10
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_POWER_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_POWER_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor257
;DriverRF4463PROMain.c,143 :: 		ulArgument = StrToShort( ucLongArgument );
ADD	R4, SP, #40
MOV	R0, R4
BL	_StrToShort+0
STR	R0, [SP, #36]
;DriverRF4463PROMain.c,145 :: 		if ( ulArgument > 0 && ulArgument <= 127 ) {
LDR	R0, [SP, #36]
CMP	R0, #0
IT	LS
BLS	L_vRF4463MainCommandProcessor260
LDR	R0, [SP, #36]
CMP	R0, #127
IT	HI
BHI	L_vRF4463MainCommandProcessor260
L__vRF4463MainCommandProcessor427:
;DriverRF4463PROMain.c,146 :: 		ucRF4463Power = ulArgument;
LDR	R1, [SP, #36]
MOVW	R0, #lo_addr(_ucRF4463Power+0)
MOVT	R0, #hi_addr(_ucRF4463Power+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,147 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,148 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,149 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor261
L_vRF4463MainCommandProcessor260:
;DriverRF4463PROMain.c,151 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,152 :: 		}
L_vRF4463MainCommandProcessor261:
;DriverRF4463PROMain.c,153 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor262
L_vRF4463MainCommandProcessor257:
;DriverRF4463PROMain.c,157 :: 		else if ( memcmp( CMD_RADIO_BAND_SET, ucCommand, sizeof( CMD_RADIO_BAND_SET ) ) == 0x00 ) {
ADD	R4, SP, #4
MOVS	R2, #9
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_BAND_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_BAND_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor263
;DriverRF4463PROMain.c,158 :: 		ulArgument = StrToInt( ucLongArgument );
ADD	R4, SP, #40
MOV	R0, R4
BL	_StrToInt+0
STR	R0, [SP, #36]
;DriverRF4463PROMain.c,160 :: 		if ( ulArgument == 433 || ulArgument == 868 || ulArgument == 915 ) {
LDR	R1, [SP, #36]
MOVW	R0, #433
CMP	R1, R0
IT	EQ
BEQ	L__vRF4463MainCommandProcessor426
LDR	R0, [SP, #36]
CMP	R0, #868
IT	EQ
BEQ	L__vRF4463MainCommandProcessor426
LDR	R1, [SP, #36]
MOVW	R0, #915
CMP	R1, R0
IT	EQ
BEQ	L__vRF4463MainCommandProcessor426
IT	AL
BAL	L_vRF4463MainCommandProcessor266
L__vRF4463MainCommandProcessor426:
;DriverRF4463PROMain.c,161 :: 		ucRF4463Freq3 = ucLongArgument[ 0 ] - 48;
ADD	R0, SP, #40
ADDS	R0, R0, #0
LDRB	R0, [R0, #0]
SUBW	R1, R0, #48
MOVW	R0, #lo_addr(_ucRF4463Freq3+0)
MOVT	R0, #hi_addr(_ucRF4463Freq3+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,162 :: 		ucRF4463Freq2 = ucLongArgument[ 1 ] - 48;
ADD	R0, SP, #40
ADDS	R0, R0, #1
LDRB	R0, [R0, #0]
SUBW	R1, R0, #48
MOVW	R0, #lo_addr(_ucRF4463Freq2+0)
MOVT	R0, #hi_addr(_ucRF4463Freq2+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,163 :: 		ucRF4463Freq1 = ucLongArgument[ 2 ] - 48;
ADD	R0, SP, #40
ADDS	R0, R0, #2
LDRB	R0, [R0, #0]
SUBW	R1, R0, #48
MOVW	R0, #lo_addr(_ucRF4463Freq1+0)
MOVT	R0, #hi_addr(_ucRF4463Freq1+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,164 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,165 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,166 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor267
L_vRF4463MainCommandProcessor266:
;DriverRF4463PROMain.c,168 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,169 :: 		}
L_vRF4463MainCommandProcessor267:
;DriverRF4463PROMain.c,170 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor268
L_vRF4463MainCommandProcessor263:
;DriverRF4463PROMain.c,174 :: 		else if ( memcmp( CMD_RADIO_RATE_SET, ucCommand, sizeof( CMD_RADIO_RATE_SET ) ) == 0x00 ) {
ADD	R4, SP, #4
MOVS	R2, #9
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_RATE_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_RATE_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor269
;DriverRF4463PROMain.c,175 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R4, SP, #40
MOV	R0, R4
BL	_StrToLong+0
STR	R0, [SP, #36]
;DriverRF4463PROMain.c,177 :: 		switch ( ulArgument ) {
IT	AL
BAL	L_vRF4463MainCommandProcessor270
;DriverRF4463PROMain.c,178 :: 		case 500      : ucRF4463Rate = dr_500;
L_vRF4463MainCommandProcessor272:
MOVS	R1, #10
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,179 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,180 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,181 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor271
;DriverRF4463PROMain.c,182 :: 		case 1200     : ucRF4463Rate = dr_1p2;
L_vRF4463MainCommandProcessor273:
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,183 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,184 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,185 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor271
;DriverRF4463PROMain.c,186 :: 		case 2400     : ucRF4463Rate = dr_2p4;
L_vRF4463MainCommandProcessor274:
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,187 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,188 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,189 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor271
;DriverRF4463PROMain.c,190 :: 		case 4800     : ucRF4463Rate = dr_4p8;
L_vRF4463MainCommandProcessor275:
MOVS	R1, #2
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,191 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,192 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,193 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor271
;DriverRF4463PROMain.c,194 :: 		case 9600     : ucRF4463Rate = dr_9p6;
L_vRF4463MainCommandProcessor276:
MOVS	R1, #3
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,195 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,196 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,197 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor271
;DriverRF4463PROMain.c,198 :: 		case 19200    : ucRF4463Rate = dr_19p2;
L_vRF4463MainCommandProcessor277:
MOVS	R1, #4
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,199 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,200 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,201 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor271
;DriverRF4463PROMain.c,202 :: 		case 38400    : ucRF4463Rate = dr_38p4;
L_vRF4463MainCommandProcessor278:
MOVS	R1, #5
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,203 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,204 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,205 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor271
;DriverRF4463PROMain.c,206 :: 		case 76800    : ucRF4463Rate = dr_76p8;
L_vRF4463MainCommandProcessor279:
MOVS	R1, #6
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,207 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,208 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,209 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor271
;DriverRF4463PROMain.c,210 :: 		case 115200   : ucRF4463Rate = dr_115p2;
L_vRF4463MainCommandProcessor280:
MOVS	R1, #7
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,211 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,212 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,213 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor271
;DriverRF4463PROMain.c,214 :: 		case 256000   : ucRF4463Rate = dr_256k;
L_vRF4463MainCommandProcessor281:
MOVS	R1, #8
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,215 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,216 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,217 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor271
;DriverRF4463PROMain.c,218 :: 		case 500000   : ucRF4463Rate = dr_500k;
L_vRF4463MainCommandProcessor282:
MOVS	R1, #9
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,219 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,220 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,221 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor271
;DriverRF4463PROMain.c,222 :: 		default       : vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
L_vRF4463MainCommandProcessor283:
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,223 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor271
L_vRF4463MainCommandProcessor270:
LDR	R0, [SP, #36]
CMP	R0, #500
IT	EQ
BEQ	L_vRF4463MainCommandProcessor272
LDR	R0, [SP, #36]
CMP	R0, #1200
IT	EQ
BEQ	L_vRF4463MainCommandProcessor273
LDR	R0, [SP, #36]
CMP	R0, #2400
IT	EQ
BEQ	L_vRF4463MainCommandProcessor274
LDR	R0, [SP, #36]
CMP	R0, #4800
IT	EQ
BEQ	L_vRF4463MainCommandProcessor275
LDR	R0, [SP, #36]
CMP	R0, #9600
IT	EQ
BEQ	L_vRF4463MainCommandProcessor276
LDR	R0, [SP, #36]
CMP	R0, #19200
IT	EQ
BEQ	L_vRF4463MainCommandProcessor277
LDR	R0, [SP, #36]
CMP	R0, #38400
IT	EQ
BEQ	L_vRF4463MainCommandProcessor278
LDR	R0, [SP, #36]
CMP	R0, #76800
IT	EQ
BEQ	L_vRF4463MainCommandProcessor279
LDR	R0, [SP, #36]
CMP	R0, #115200
IT	EQ
BEQ	L_vRF4463MainCommandProcessor280
LDR	R0, [SP, #36]
CMP	R0, #256000
IT	EQ
BEQ	L_vRF4463MainCommandProcessor281
LDR	R1, [SP, #36]
MOVW	R0, #41248
MOVT	R0, #7
CMP	R1, R0
IT	EQ
BEQ	L_vRF4463MainCommandProcessor282
IT	AL
BAL	L_vRF4463MainCommandProcessor283
L_vRF4463MainCommandProcessor271:
;DriverRF4463PROMain.c,224 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor284
L_vRF4463MainCommandProcessor269:
;DriverRF4463PROMain.c,228 :: 		else if ( memcmp( CMD_RADIO_CHANNEL_SET, ucCommand, sizeof( CMD_RADIO_CHANNEL_SET ) ) == 0x00 ) {
ADD	R4, SP, #4
MOVS	R2, #12
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_CHANNEL_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_CHANNEL_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor285
;DriverRF4463PROMain.c,229 :: 		ulArgument = StrToInt( ucLongArgument );
ADD	R4, SP, #40
MOV	R0, R4
BL	_StrToInt+0
STR	R0, [SP, #36]
;DriverRF4463PROMain.c,231 :: 		if ( ulArgument >= 0 && ulArgument <= 50 ) {
LDR	R0, [SP, #36]
CMP	R0, #0
IT	CC
BCC	L_vRF4463MainCommandProcessor288
LDR	R0, [SP, #36]
CMP	R0, #50
IT	HI
BHI	L_vRF4463MainCommandProcessor288
L__vRF4463MainCommandProcessor425:
;DriverRF4463PROMain.c,232 :: 		ucRF4463FreqChannel = ulArgument;    // Se aplica al ejecutar funciones de TX o RX
LDR	R1, [SP, #36]
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,233 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,234 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,235 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor289
L_vRF4463MainCommandProcessor288:
;DriverRF4463PROMain.c,237 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,238 :: 		}
L_vRF4463MainCommandProcessor289:
;DriverRF4463PROMain.c,239 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor290
L_vRF4463MainCommandProcessor285:
;DriverRF4463PROMain.c,243 :: 		else if ( memcmp( CMD_RADIO_BW_SET, ucCommand, sizeof( CMD_RADIO_BW_SET ) ) == 0x00 ) {
ADD	R4, SP, #4
MOVS	R2, #7
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_BW_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_BW_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor291
;DriverRF4463PROMain.c,244 :: 		ulArgument = StrToInt( ucLongArgument );
ADD	R4, SP, #40
MOV	R0, R4
BL	_StrToInt+0
STR	R0, [SP, #36]
;DriverRF4463PROMain.c,246 :: 		if ( ulArgument == 250 || ulArgument == 500 ) {
LDR	R0, [SP, #36]
CMP	R0, #250
IT	EQ
BEQ	L__vRF4463MainCommandProcessor424
LDR	R0, [SP, #36]
CMP	R0, #500
IT	EQ
BEQ	L__vRF4463MainCommandProcessor424
IT	AL
BAL	L_vRF4463MainCommandProcessor294
L__vRF4463MainCommandProcessor424:
;DriverRF4463PROMain.c,247 :: 		ulRF4463Step = ulArgument;
LDR	R1, [SP, #36]
MOVW	R0, #lo_addr(_ulRF4463Step+0)
MOVT	R0, #hi_addr(_ulRF4463Step+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,248 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,249 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,250 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor295
L_vRF4463MainCommandProcessor294:
;DriverRF4463PROMain.c,252 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,253 :: 		}
L_vRF4463MainCommandProcessor295:
;DriverRF4463PROMain.c,254 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor296
L_vRF4463MainCommandProcessor291:
;DriverRF4463PROMain.c,261 :: 		else if ( memcmp( CMD_RADIO_MODE_SET, ucCommand, sizeof( CMD_RADIO_MODE_SET ) ) == 0x00 ) {
ADD	R4, SP, #4
MOVS	R2, #9
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_MODE_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MODE_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor297
;DriverRF4463PROMain.c,263 :: 		ucCounterCommand = 0;
MOVS	R0, #0
STRB	R0, [SP, #105]
;DriverRF4463PROMain.c,265 :: 		while ( ucLongArgument[ ucCounterCommand ] != ucUSARTNull && ucCounterCommand < 32 ) {
L_vRF4463MainCommandProcessor298:
ADD	R1, SP, #40
LDRB	R0, [SP, #105]
ADDS	R0, R1, R0
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucUSARTNull+0)
MOVT	R0, #hi_addr(_ucUSARTNull+0)
LDRB	R0, [R0, #0]
CMP	R1, R0
IT	EQ
BEQ	L_vRF4463MainCommandProcessor299
LDRB	R0, [SP, #105]
CMP	R0, #32
IT	CS
BCS	L_vRF4463MainCommandProcessor299
L__vRF4463MainCommandProcessor423:
;DriverRF4463PROMain.c,266 :: 		ucLongArgument[ ucCounterCommand ] = toupper( ucLongArgument[ ucCounterCommand ] );
ADD	R1, SP, #40
LDRB	R0, [SP, #105]
ADDS	R0, R1, R0
STR	R0, [SP, #108]
ADD	R1, SP, #40
LDRB	R0, [SP, #105]
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
UXTB	R4, R0
UXTB	R0, R4
BL	_toupper+0
LDR	R1, [SP, #108]
STRB	R0, [R1, #0]
;DriverRF4463PROMain.c,267 :: 		ucCounterCommand++;
LDRB	R0, [SP, #105]
ADDS	R0, R0, #1
STRB	R0, [SP, #105]
;DriverRF4463PROMain.c,268 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor298
L_vRF4463MainCommandProcessor299:
;DriverRF4463PROMain.c,271 :: 		if ( memcmp( ARG_RADIO_MODE_STBY, ucLongArgument, sizeof( ARG_RADIO_MODE_STBY ) ) == 0x00 ) {
ADD	R4, SP, #40
MOVS	R2, #5
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_STBY+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_STBY+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor302
;DriverRF4463PROMain.c,272 :: 		ucRF4463Mode = rf_off;
MOVS	R1, #4
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,273 :: 		vUSART1Start_TX( ANS_COMMAND_MODE_STBY, strlen( ANS_COMMAND_MODE_STBY ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_STBY+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_STBY+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_STBY+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_STBY+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,274 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor303
L_vRF4463MainCommandProcessor302:
;DriverRF4463PROMain.c,275 :: 		else if ( memcmp( ARG_RADIO_MODE_TX_CONT, ucLongArgument, sizeof( ARG_RADIO_MODE_TX_CONT ) ) == 0x00 ) {
ADD	R4, SP, #40
MOVS	R2, #8
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_TX_CONT+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_TX_CONT+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor304
;DriverRF4463PROMain.c,276 :: 		ucRF4463Mode = tx_test_mode;
MOVS	R1, #2
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,277 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,278 :: 		vUSART1Start_TX( ANS_COMMAND_MODE_TX_CONT, strlen( ANS_COMMAND_MODE_TX_CONT ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_CONT+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_CONT+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,279 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor305
L_vRF4463MainCommandProcessor304:
;DriverRF4463PROMain.c,280 :: 		else if ( memcmp( ARG_RADIO_MODE_RX_CONT, ucLongArgument, sizeof( ARG_RADIO_MODE_RX_CONT ) ) == 0x00 ) {
ADD	R4, SP, #40
MOVS	R2, #8
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_RX_CONT+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_RX_CONT+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor306
;DriverRF4463PROMain.c,281 :: 		ucRF4463Mode = rx_test_mode;
MOVS	R1, #3
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,282 :: 		vUSART1Start_TX( ANS_COMMAND_MODE_RX_CONT, strlen( ANS_COMMAND_MODE_RX_CONT ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_CONT+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_CONT+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,283 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor307
L_vRF4463MainCommandProcessor306:
;DriverRF4463PROMain.c,284 :: 		else if ( memcmp( ARG_RADIO_MODE_TX_MASTER, ucLongArgument, sizeof( ARG_RADIO_MODE_TX_MASTER ) ) == 0x00 ) {
ADD	R4, SP, #40
MOVS	R2, #10
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_TX_MASTER+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_TX_MASTER+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor308
;DriverRF4463PROMain.c,285 :: 		ucRF4463Mode = master_mode;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,286 :: 		vUSART1Start_TX( ANS_COMMAND_MODE_TX_MASTER, strlen( ANS_COMMAND_MODE_TX_MASTER ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,287 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor309
L_vRF4463MainCommandProcessor308:
;DriverRF4463PROMain.c,288 :: 		else if ( memcmp( ARG_RADIO_MODE_RX_SLAVE, ucLongArgument, sizeof( ARG_RADIO_MODE_RX_SLAVE ) ) == 0x00 ) {
ADD	R4, SP, #40
MOVS	R2, #9
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_RX_SLAVE+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_RX_SLAVE+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor310
;DriverRF4463PROMain.c,289 :: 		ucRF4463Mode = slave_mode;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,290 :: 		vUSART1Start_TX( ANS_COMMAND_MODE_RX_SLAVE, strlen( ANS_COMMAND_MODE_RX_SLAVE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,291 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor311
L_vRF4463MainCommandProcessor310:
;DriverRF4463PROMain.c,293 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,294 :: 		}
L_vRF4463MainCommandProcessor311:
L_vRF4463MainCommandProcessor309:
L_vRF4463MainCommandProcessor307:
L_vRF4463MainCommandProcessor305:
L_vRF4463MainCommandProcessor303:
;DriverRF4463PROMain.c,295 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor312
L_vRF4463MainCommandProcessor297:
;DriverRF4463PROMain.c,300 :: 		else if ( memcmp( CMD_RADIO_PACKET_SEND, ucCommand, sizeof( CMD_RADIO_PACKET_SEND ) ) == 0x00 ) {
ADD	R4, SP, #4
MOVS	R2, #12
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_PACKET_SEND+0)
MOVT	R0, #hi_addr(_CMD_RADIO_PACKET_SEND+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor313
;DriverRF4463PROMain.c,304 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R4, SP, #40
MOV	R0, R4
BL	_StrToLong+0
STR	R0, [SP, #36]
;DriverRF4463PROMain.c,306 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,308 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor314
L_vRF4463MainCommandProcessor313:
;DriverRF4463PROMain.c,313 :: 		else if ( memcmp( CMD_RADIO_MATCH_BYTE_1_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_1_SET ) ) == 0x00 ) {
ADD	R4, SP, #4
MOVS	R2, #12
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_BYTE_1_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_BYTE_1_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor315
;DriverRF4463PROMain.c,314 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R4, SP, #40
MOV	R0, R4
BL	_StrToLong+0
STR	R0, [SP, #36]
;DriverRF4463PROMain.c,315 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
LDR	R0, [SP, #36]
CMP	R0, #0
IT	CC
BCC	L_vRF4463MainCommandProcessor318
LDR	R0, [SP, #36]
CMP	R0, #255
IT	HI
BHI	L_vRF4463MainCommandProcessor318
L__vRF4463MainCommandProcessor422:
;DriverRF4463PROMain.c,316 :: 		ucRF4463ByteMatch1 = ulArgument;
LDR	R1, [SP, #36]
MOVW	R0, #lo_addr(_ucRF4463ByteMatch1+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch1+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,317 :: 		ucRF4463MatchEnabled = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,318 :: 		ucRF4463MatchEnableReg = 0x40;
MOVS	R1, #64
MOVW	R0, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,319 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,320 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,321 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor319
L_vRF4463MainCommandProcessor318:
;DriverRF4463PROMain.c,323 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,324 :: 		}
L_vRF4463MainCommandProcessor319:
;DriverRF4463PROMain.c,325 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor320
L_vRF4463MainCommandProcessor315:
;DriverRF4463PROMain.c,329 :: 		else if ( memcmp( CMD_RADIO_MATCH_BYTE_2_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_2_SET ) ) == 0x00 ) {
ADD	R4, SP, #4
MOVS	R2, #12
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_BYTE_2_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_BYTE_2_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor321
;DriverRF4463PROMain.c,330 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R4, SP, #40
MOV	R0, R4
BL	_StrToLong+0
STR	R0, [SP, #36]
;DriverRF4463PROMain.c,331 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
LDR	R0, [SP, #36]
CMP	R0, #0
IT	CC
BCC	L_vRF4463MainCommandProcessor324
LDR	R0, [SP, #36]
CMP	R0, #255
IT	HI
BHI	L_vRF4463MainCommandProcessor324
L__vRF4463MainCommandProcessor421:
;DriverRF4463PROMain.c,332 :: 		ucRF4463ByteMatch2 = ulArgument;
LDR	R1, [SP, #36]
MOVW	R0, #lo_addr(_ucRF4463ByteMatch2+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch2+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,333 :: 		ucRF4463MatchEnabled = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,334 :: 		ucRF4463MatchEnableReg = 0x40;
MOVS	R1, #64
MOVW	R0, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,335 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,336 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,337 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor325
L_vRF4463MainCommandProcessor324:
;DriverRF4463PROMain.c,339 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,340 :: 		}
L_vRF4463MainCommandProcessor325:
;DriverRF4463PROMain.c,341 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor326
L_vRF4463MainCommandProcessor321:
;DriverRF4463PROMain.c,345 :: 		else if ( memcmp( CMD_RADIO_MATCH_BYTE_3_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_3_SET ) ) == 0x00 ) {
ADD	R4, SP, #4
MOVS	R2, #12
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_BYTE_3_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_BYTE_3_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor327
;DriverRF4463PROMain.c,346 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R4, SP, #40
MOV	R0, R4
BL	_StrToLong+0
STR	R0, [SP, #36]
;DriverRF4463PROMain.c,347 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
LDR	R0, [SP, #36]
CMP	R0, #0
IT	CC
BCC	L_vRF4463MainCommandProcessor330
LDR	R0, [SP, #36]
CMP	R0, #255
IT	HI
BHI	L_vRF4463MainCommandProcessor330
L__vRF4463MainCommandProcessor420:
;DriverRF4463PROMain.c,348 :: 		ucRF4463ByteMatch3 = ulArgument;
LDR	R1, [SP, #36]
MOVW	R0, #lo_addr(_ucRF4463ByteMatch3+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch3+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,349 :: 		ucRF4463MatchEnabled = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,350 :: 		ucRF4463MatchEnableReg = 0x40;
MOVS	R1, #64
MOVW	R0, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,351 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,352 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,353 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor331
L_vRF4463MainCommandProcessor330:
;DriverRF4463PROMain.c,355 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,356 :: 		}
L_vRF4463MainCommandProcessor331:
;DriverRF4463PROMain.c,357 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor332
L_vRF4463MainCommandProcessor327:
;DriverRF4463PROMain.c,361 :: 		else if ( memcmp( CMD_RADIO_MATCH_BYTE_4_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_4_SET ) ) == 0x00 ) {
ADD	R4, SP, #4
MOVS	R2, #12
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_BYTE_4_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_BYTE_4_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor333
;DriverRF4463PROMain.c,362 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R4, SP, #40
MOV	R0, R4
BL	_StrToLong+0
STR	R0, [SP, #36]
;DriverRF4463PROMain.c,363 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
LDR	R0, [SP, #36]
CMP	R0, #0
IT	CC
BCC	L_vRF4463MainCommandProcessor336
LDR	R0, [SP, #36]
CMP	R0, #255
IT	HI
BHI	L_vRF4463MainCommandProcessor336
L__vRF4463MainCommandProcessor419:
;DriverRF4463PROMain.c,364 :: 		ucRF4463ByteMatch4 = ulArgument;
LDR	R1, [SP, #36]
MOVW	R0, #lo_addr(_ucRF4463ByteMatch4+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch4+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,365 :: 		ucRF4463MatchEnabled = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,366 :: 		ucRF4463MatchEnableReg = 0x40;
MOVS	R1, #64
MOVW	R0, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,367 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,368 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,369 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor337
L_vRF4463MainCommandProcessor336:
;DriverRF4463PROMain.c,371 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,372 :: 		}
L_vRF4463MainCommandProcessor337:
;DriverRF4463PROMain.c,373 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor338
L_vRF4463MainCommandProcessor333:
;DriverRF4463PROMain.c,377 :: 		else if ( memcmp( CMD_RADIO_MATCH_MASK_1_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_1_SET ) ) == 0x00 ) {
ADD	R4, SP, #4
MOVS	R2, #11
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_MASK_1_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_MASK_1_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor339
;DriverRF4463PROMain.c,378 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R4, SP, #40
MOV	R0, R4
BL	_StrToLong+0
STR	R0, [SP, #36]
;DriverRF4463PROMain.c,379 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
LDR	R0, [SP, #36]
CMP	R0, #0
IT	CC
BCC	L_vRF4463MainCommandProcessor342
LDR	R0, [SP, #36]
CMP	R0, #255
IT	HI
BHI	L_vRF4463MainCommandProcessor342
L__vRF4463MainCommandProcessor418:
;DriverRF4463PROMain.c,380 :: 		ucRF4463ByteMask1 = ulArgument;
LDR	R1, [SP, #36]
MOVW	R0, #lo_addr(_ucRF4463ByteMask1+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask1+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,381 :: 		ucRF4463MatchEnabled = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,382 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,383 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,384 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor343
L_vRF4463MainCommandProcessor342:
;DriverRF4463PROMain.c,386 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,387 :: 		}
L_vRF4463MainCommandProcessor343:
;DriverRF4463PROMain.c,388 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor344
L_vRF4463MainCommandProcessor339:
;DriverRF4463PROMain.c,392 :: 		else if ( memcmp( CMD_RADIO_MATCH_MASK_2_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_2_SET ) ) == 0x00 ) {
ADD	R4, SP, #4
MOVS	R2, #11
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_MASK_2_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_MASK_2_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor345
;DriverRF4463PROMain.c,393 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R4, SP, #40
MOV	R0, R4
BL	_StrToLong+0
STR	R0, [SP, #36]
;DriverRF4463PROMain.c,394 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
LDR	R0, [SP, #36]
CMP	R0, #0
IT	CC
BCC	L_vRF4463MainCommandProcessor348
LDR	R0, [SP, #36]
CMP	R0, #255
IT	HI
BHI	L_vRF4463MainCommandProcessor348
L__vRF4463MainCommandProcessor417:
;DriverRF4463PROMain.c,395 :: 		ucRF4463ByteMask2 = ulArgument;
LDR	R1, [SP, #36]
MOVW	R0, #lo_addr(_ucRF4463ByteMask2+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask2+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,396 :: 		ucRF4463MatchEnabled = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,397 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,398 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,399 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor349
L_vRF4463MainCommandProcessor348:
;DriverRF4463PROMain.c,401 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,402 :: 		}
L_vRF4463MainCommandProcessor349:
;DriverRF4463PROMain.c,403 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor350
L_vRF4463MainCommandProcessor345:
;DriverRF4463PROMain.c,407 :: 		else if ( memcmp( CMD_RADIO_MATCH_MASK_3_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_3_SET ) ) == 0x00 ) {
ADD	R4, SP, #4
MOVS	R2, #11
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_MASK_3_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_MASK_3_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor351
;DriverRF4463PROMain.c,408 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R4, SP, #40
MOV	R0, R4
BL	_StrToLong+0
STR	R0, [SP, #36]
;DriverRF4463PROMain.c,409 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
LDR	R0, [SP, #36]
CMP	R0, #0
IT	CC
BCC	L_vRF4463MainCommandProcessor354
LDR	R0, [SP, #36]
CMP	R0, #255
IT	HI
BHI	L_vRF4463MainCommandProcessor354
L__vRF4463MainCommandProcessor416:
;DriverRF4463PROMain.c,410 :: 		ucRF4463ByteMask3 = ulArgument;
LDR	R1, [SP, #36]
MOVW	R0, #lo_addr(_ucRF4463ByteMask3+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask3+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,411 :: 		ucRF4463MatchEnabled = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,412 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,413 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,414 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor355
L_vRF4463MainCommandProcessor354:
;DriverRF4463PROMain.c,416 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,417 :: 		}
L_vRF4463MainCommandProcessor355:
;DriverRF4463PROMain.c,418 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor356
L_vRF4463MainCommandProcessor351:
;DriverRF4463PROMain.c,422 :: 		else if ( memcmp( CMD_RADIO_MATCH_MASK_4_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_4_SET ) ) == 0x00 ) {
ADD	R4, SP, #4
MOVS	R2, #11
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_MASK_4_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_MASK_4_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor357
;DriverRF4463PROMain.c,423 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R4, SP, #40
MOV	R0, R4
BL	_StrToLong+0
STR	R0, [SP, #36]
;DriverRF4463PROMain.c,424 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
LDR	R0, [SP, #36]
CMP	R0, #0
IT	CC
BCC	L_vRF4463MainCommandProcessor360
LDR	R0, [SP, #36]
CMP	R0, #255
IT	HI
BHI	L_vRF4463MainCommandProcessor360
L__vRF4463MainCommandProcessor415:
;DriverRF4463PROMain.c,425 :: 		ucRF4463ByteMask4 = ulArgument;
LDR	R1, [SP, #36]
MOVW	R0, #lo_addr(_ucRF4463ByteMask4+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask4+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,426 :: 		ucRF4463MatchEnabled = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,427 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,428 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,429 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor361
L_vRF4463MainCommandProcessor360:
;DriverRF4463PROMain.c,431 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,432 :: 		}
L_vRF4463MainCommandProcessor361:
;DriverRF4463PROMain.c,433 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor362
L_vRF4463MainCommandProcessor357:
;DriverRF4463PROMain.c,437 :: 		else if ( memcmp( CMD_RADIO_MATCH_UNSET, ucCommand, sizeof( CMD_RADIO_MATCH_UNSET ) ) == 0x00 ) {
ADD	R4, SP, #4
MOVS	R2, #12
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_UNSET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_UNSET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor363
;DriverRF4463PROMain.c,439 :: 		ucRF4463MatchEnableReg = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,440 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,441 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,446 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor364
L_vRF4463MainCommandProcessor363:
;DriverRF4463PROMain.c,450 :: 		vUSART1Start_TX( ANS_DEBUG_COMMAND_UNKNOWN, strlen( ANS_DEBUG_COMMAND_UNKNOWN ) );
MOVW	R0, #lo_addr(_ANS_DEBUG_COMMAND_UNKNOWN+0)
MOVT	R0, #hi_addr(_ANS_DEBUG_COMMAND_UNKNOWN+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_DEBUG_COMMAND_UNKNOWN+0)
MOVT	R0, #hi_addr(_ANS_DEBUG_COMMAND_UNKNOWN+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,451 :: 		vUSART1Start_TX( ucBuffer, strlen( ucBuffer ) );  // DEPURACION
LDR	R0, [SP, #112]
BL	_strlen+0
PUSH	(R0)
LDR	R0, [SP, #116]
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,452 :: 		}
L_vRF4463MainCommandProcessor364:
L_vRF4463MainCommandProcessor362:
L_vRF4463MainCommandProcessor356:
L_vRF4463MainCommandProcessor350:
L_vRF4463MainCommandProcessor344:
L_vRF4463MainCommandProcessor338:
L_vRF4463MainCommandProcessor332:
L_vRF4463MainCommandProcessor326:
L_vRF4463MainCommandProcessor320:
L_vRF4463MainCommandProcessor314:
L_vRF4463MainCommandProcessor312:
L_vRF4463MainCommandProcessor296:
L_vRF4463MainCommandProcessor290:
L_vRF4463MainCommandProcessor284:
L_vRF4463MainCommandProcessor268:
L_vRF4463MainCommandProcessor262:
;DriverRF4463PROMain.c,453 :: 		}
L_end_vRF4463MainCommandProcessor:
LDR	LR, [SP, #0]
ADD	SP, SP, #112
BX	LR
; end of _vRF4463MainCommandProcessor
_InitTimer2:
;DriverRF4463PROMain.c,459 :: 		void InitTimer2(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;DriverRF4463PROMain.c,461 :: 		RCC_APB1ENR.TIM2EN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
_SX	[R0, ByteOffset(RCC_APB1ENR+0)]
;DriverRF4463PROMain.c,462 :: 		TIM2_CR1.CEN = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
_SX	[R0, ByteOffset(TIM2_CR1+0)]
;DriverRF4463PROMain.c,463 :: 		TIM2_PSC = 1499;
MOVW	R1, #1499
MOVW	R0, #lo_addr(TIM2_PSC+0)
MOVT	R0, #hi_addr(TIM2_PSC+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,464 :: 		TIM2_ARR = 63839;
MOVW	R1, #63839
MOVW	R0, #lo_addr(TIM2_ARR+0)
MOVT	R0, #hi_addr(TIM2_ARR+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,465 :: 		NVIC_IntEnable( IVT_INT_TIM2 );
MOVW	R0, #44
BL	_NVIC_IntEnable+0
;DriverRF4463PROMain.c,466 :: 		TIM2_DIER.UIE = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
_SX	[R0, ByteOffset(TIM2_DIER+0)]
;DriverRF4463PROMain.c,467 :: 		TIM2_CR1.CEN = 1;
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
_SX	[R0, ByteOffset(TIM2_CR1+0)]
;DriverRF4463PROMain.c,468 :: 		}
L_end_InitTimer2:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _InitTimer2
_main:
;DriverRF4463PROMain.c,472 :: 		void main() {
SUB	SP, SP, #96
;DriverRF4463PROMain.c,476 :: 		Delay_ms( 2000 );                    // delay de depuracion
MOVW	R7, #64510
MOVT	R7, #1708
NOP
NOP
L_main365:
SUBS	R7, R7, #1
BNE	L_main365
NOP
NOP
NOP
;DriverRF4463PROMain.c,480 :: 		GPIO_Digital_Output( &GPIOE_BASE, _GPIO_PINMASK_9 );
MOVW	R1, #512
MOVW	R0, #lo_addr(GPIOE_BASE+0)
MOVT	R0, #hi_addr(GPIOE_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,481 :: 		GPIO_Digital_Output( &GPIOE_BASE, _GPIO_PINMASK_11 );
MOVW	R1, #2048
MOVW	R0, #lo_addr(GPIOE_BASE+0)
MOVT	R0, #hi_addr(GPIOE_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,482 :: 		GPIO_Digital_Output( &GPIOE_BASE, _GPIO_PINMASK_13 );
MOVW	R1, #8192
MOVW	R0, #lo_addr(GPIOE_BASE+0)
MOVT	R0, #hi_addr(GPIOE_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,490 :: 		GPIO_Digital_Input( &GPIOD_BASE, _GPIO_PINMASK_0 );     // nIRQ (Interrupt Request Pin)
MOVW	R1, #1
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Input+0
;DriverRF4463PROMain.c,491 :: 		GPIO_Digital_Output( &GPIOD_BASE, _GPIO_PINMASK_1 );    // SDN  ()
MOVW	R1, #2
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,492 :: 		GPIO_Digital_Output( &GPIOD_BASE, _GPIO_PINMASK_2 );    // nSEL (Chip Select)
MOVW	R1, #4
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,506 :: 		RCC_APB2ENRbits.SYSCFGEN = 1; //Clock Enable
MOVS	R2, #1
SXTB	R2, R2
MOVW	R0, #lo_addr(RCC_APB2ENRbits+0)
MOVT	R0, #hi_addr(RCC_APB2ENRbits+0)
_SX	[R0, ByteOffset(RCC_APB2ENRbits+0)]
;DriverRF4463PROMain.c,507 :: 		SYSCFG_EXTICR1  |= 0x0003;    //Pin Configuration
MOVW	R0, #lo_addr(SYSCFG_EXTICR1+0)
MOVT	R0, #hi_addr(SYSCFG_EXTICR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #3
MOVW	R0, #lo_addr(SYSCFG_EXTICR1+0)
MOVT	R0, #hi_addr(SYSCFG_EXTICR1+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,508 :: 		EXTI_IMR.B0     |= 1;         //Interruption Edge Flag
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
_LX	[R0, ByteOffset(EXTI_IMR+0)]
ORR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
_SX	[R0, ByteOffset(EXTI_IMR+0)]
;DriverRF4463PROMain.c,509 :: 		EXTI_FTSR.B0    |= 1;
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
_LX	[R0, ByteOffset(EXTI_FTSR+0)]
ORR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
_SX	[R0, ByteOffset(EXTI_FTSR+0)]
;DriverRF4463PROMain.c,511 :: 		nSEL = 1;
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;DriverRF4463PROMain.c,513 :: 		LED_RED      = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_SX	[R0, ByteOffset(GPIOE_ODRbits+0)]
;DriverRF4463PROMain.c,514 :: 		LED_GREEN    = 0;
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_SX	[R0, ByteOffset(GPIOE_ODRbits+0)]
;DriverRF4463PROMain.c,515 :: 		LED_BLUE     = 0;
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_SX	[R0, ByteOffset(GPIOE_ODRbits+0)]
;DriverRF4463PROMain.c,517 :: 		Delay_ms( 100 );
MOVW	R7, #29438
MOVT	R7, #85
NOP
NOP
L_main367:
SUBS	R7, R7, #1
BNE	L_main367
NOP
NOP
NOP
;DriverRF4463PROMain.c,519 :: 		LED_RED      = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_SX	[R0, ByteOffset(GPIOE_ODRbits+0)]
;DriverRF4463PROMain.c,520 :: 		LED_GREEN    = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_SX	[R0, ByteOffset(GPIOE_ODRbits+0)]
;DriverRF4463PROMain.c,521 :: 		LED_BLUE     = 0;
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_SX	[R0, ByteOffset(GPIOE_ODRbits+0)]
;DriverRF4463PROMain.c,522 :: 		Delay_ms(300);
MOVW	R7, #22782
MOVT	R7, #256
NOP
NOP
L_main369:
SUBS	R7, R7, #1
BNE	L_main369
NOP
NOP
NOP
;DriverRF4463PROMain.c,523 :: 		InitTimer2();
BL	_InitTimer2+0
;DriverRF4463PROMain.c,527 :: 		vUSARTConfigUSART1( 115200 );  // configura todos las parametros de USART
MOV	R0, #115200
PUSH	(R0)
BL	_vUSARTConfigUSART1+0
ADD	SP, SP, #4
;DriverRF4463PROMain.c,529 :: 		UART1_Write_Text("[ SYS STM32F407VC ] Start System\r\n");
ADD	R11, SP, #6
ADD	R10, R11, #35
MOVW	R12, #lo_addr(?ICS?lstr3_DriverRF4463PROMain+0)
MOVT	R12, #hi_addr(?ICS?lstr3_DriverRF4463PROMain+0)
BL	___CC2DW+0
ADD	R0, SP, #6
MOV	R4, R0
MOV	R0, R4
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,530 :: 		LED_RED      = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_SX	[R0, ByteOffset(GPIOE_ODRbits+0)]
;DriverRF4463PROMain.c,531 :: 		LED_GREEN    = 0;
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_SX	[R0, ByteOffset(GPIOE_ODRbits+0)]
;DriverRF4463PROMain.c,532 :: 		LED_BLUE     = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_SX	[R0, ByteOffset(GPIOE_ODRbits+0)]
;DriverRF4463PROMain.c,533 :: 		vSPI1Init();           // configura todos los parametros de SPI
BL	_vSPI1Init+0
;DriverRF4463PROMain.c,538 :: 		ucRF4463Freq3 = 9;
MOVS	R1, #9
MOVW	R0, #lo_addr(_ucRF4463Freq3+0)
MOVT	R0, #hi_addr(_ucRF4463Freq3+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,539 :: 		ucRF4463Freq2 = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463Freq2+0)
MOVT	R0, #hi_addr(_ucRF4463Freq2+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,540 :: 		ucRF4463Freq1 = 5;
MOVS	R1, #5
MOVW	R0, #lo_addr(_ucRF4463Freq1+0)
MOVT	R0, #hi_addr(_ucRF4463Freq1+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,543 :: 		ucRF4463Power = 127;            // 34
MOVS	R1, #127
MOVW	R0, #lo_addr(_ucRF4463Power+0)
MOVT	R0, #hi_addr(_ucRF4463Power+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,545 :: 		ucRF4463Rate  = dr_1p2;                // BAUDRATE
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,547 :: 		ucRF4463Mode  = master_mode;          // para transmision continua usar: tx_test_mode
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,549 :: 		ucRF4463FreqChannel = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,553 :: 		reset_mode = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_reset_mode+0)
MOVT	R0, #hi_addr(_reset_mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,558 :: 		vRF4463MainSetTXString();    // usada para establecer el encabezdo predeterminado
BL	_vRF4463MainSetTXString+0
;DriverRF4463PROMain.c,559 :: 		VRF4463SDNReset();
BL	_VRF4463SDNReset+0
;DriverRF4463PROMain.c,560 :: 		vRF4463Init();
BL	_vRF4463Init+0
;DriverRF4463PROMain.c,561 :: 		vRF4463ClearInterrupts();
BL	_vRF4463ClearInterrupts+0
;DriverRF4463PROMain.c,562 :: 		vRF4463PartInfo ();          // SOLICITA EL MODELO DEL RADIO
BL	_vRF4463PartInfo+0
;DriverRF4463PROMain.c,564 :: 		LED_GREEN    = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_SX	[R0, ByteOffset(GPIOE_ODRbits+0)]
;DriverRF4463PROMain.c,565 :: 		LED_BLUE     = 0;
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_SX	[R0, ByteOffset(GPIOE_ODRbits+0)]
;DriverRF4463PROMain.c,569 :: 		UART1_Write_Text( "[ SYS STM32F407VC ] RF Radio ready\r\n" );
ADD	R11, SP, #41
ADD	R10, R11, #37
MOVW	R12, #lo_addr(?ICS?lstr4_DriverRF4463PROMain+0)
MOVT	R12, #hi_addr(?ICS?lstr4_DriverRF4463PROMain+0)
BL	___CC2DW+0
ADD	R0, SP, #41
MOV	R4, R0
MOV	R0, R4
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,572 :: 		while ( 1 ) {
L_main371:
;DriverRF4463PROMain.c,575 :: 		if ( fUSART1Buffer == READY_TO_READ ) {
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main373
;DriverRF4463PROMain.c,576 :: 		vUSARTReceivedFromUSART1();
BL	_vUSARTReceivedFromUSART1+0
;DriverRF4463PROMain.c,577 :: 		}
L_main373:
;DriverRF4463PROMain.c,588 :: 		if ( ucRF4463Mode == master_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main374
;DriverRF4463PROMain.c,589 :: 		vRF4463TxData();
BL	_vRF4463TxData+0
;DriverRF4463PROMain.c,590 :: 		}
IT	AL
BAL	L_main375
L_main374:
;DriverRF4463PROMain.c,593 :: 		else if ( ucRF4463Mode == slave_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main376
;DriverRF4463PROMain.c,594 :: 		vRF4463RxInit();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,595 :: 		}
IT	AL
BAL	L_main377
L_main376:
;DriverRF4463PROMain.c,598 :: 		else if ( ucRF4463Mode == rf_off ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_main378
;DriverRF4463PROMain.c,599 :: 		vRF4463RxInit();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,600 :: 		}
L_main378:
L_main377:
L_main375:
;DriverRF4463PROMain.c,603 :: 		if ( ucRF4463Mode == tx_test_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_main379
;DriverRF4463PROMain.c,604 :: 		vRF4463TxCont();
BL	_vRF4463TxCont+0
;DriverRF4463PROMain.c,605 :: 		while ( 1 ) {
L_main380:
;DriverRF4463PROMain.c,607 :: 		if ( fUSART1Buffer == READY_TO_READ ) {
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main382
;DriverRF4463PROMain.c,608 :: 		break;
IT	AL
BAL	L_main381
;DriverRF4463PROMain.c,609 :: 		}
L_main382:
;DriverRF4463PROMain.c,611 :: 		if ( !nIRQ ) {
MOVW	R0, #lo_addr(GPIOD_IDRbits+0)
MOVT	R0, #hi_addr(GPIOD_IDRbits+0)
_LX	[R0, ByteOffset(GPIOD_IDRbits+0)]
CMP	R0, #0
IT	NE
BNE	L_main383
;DriverRF4463PROMain.c,612 :: 		vRF4463TxCont();
BL	_vRF4463TxCont+0
;DriverRF4463PROMain.c,613 :: 		}
L_main383:
;DriverRF4463PROMain.c,614 :: 		}
IT	AL
BAL	L_main380
L_main381:
;DriverRF4463PROMain.c,615 :: 		}
L_main379:
;DriverRF4463PROMain.c,617 :: 		if ( ucRF4463Mode == rx_test_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BNE	L_main384
;DriverRF4463PROMain.c,618 :: 		vRF4463RxInit ();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,619 :: 		while ( 1 ) {
L_main385:
;DriverRF4463PROMain.c,621 :: 		if ( fUSART1Buffer == READY_TO_READ ) {
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main387
;DriverRF4463PROMain.c,622 :: 		break;
IT	AL
BAL	L_main386
;DriverRF4463PROMain.c,623 :: 		}
L_main387:
;DriverRF4463PROMain.c,626 :: 		}
IT	AL
BAL	L_main385
L_main386:
;DriverRF4463PROMain.c,627 :: 		}
L_main384:
;DriverRF4463PROMain.c,629 :: 		if ( reset_mode == 0 ) {
MOVW	R0, #lo_addr(_reset_mode+0)
MOVT	R0, #hi_addr(_reset_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main388
;DriverRF4463PROMain.c,631 :: 		while ( 1 ) {
L_main389:
;DriverRF4463PROMain.c,633 :: 		if ( fUSART1Buffer == READY_TO_READ ) {
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main391
;DriverRF4463PROMain.c,634 :: 		break;
IT	AL
BAL	L_main390
;DriverRF4463PROMain.c,635 :: 		}
L_main391:
;DriverRF4463PROMain.c,637 :: 		if ( Flag.reach_1s ) {
MOVW	R1, #lo_addr(_Flag+0)
MOVT	R1, #hi_addr(_Flag+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main392
;DriverRF4463PROMain.c,638 :: 		Flag.reach_1s = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,639 :: 		if ( ucRF4463Mode == master_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main393
;DriverRF4463PROMain.c,640 :: 		vRF4463TxData();
BL	_vRF4463TxData+0
;DriverRF4463PROMain.c,641 :: 		}
L_main393:
;DriverRF4463PROMain.c,642 :: 		}
L_main392:
;DriverRF4463PROMain.c,645 :: 		if ( !Flag.is_tx ) {
MOVW	R1, #lo_addr(_Flag+0)
MOVT	R1, #hi_addr(_Flag+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_main394
;DriverRF4463PROMain.c,646 :: 		if ( !nIRQ ) {          // !nIRQ
MOVW	R0, #lo_addr(GPIOD_IDRbits+0)
MOVT	R0, #hi_addr(GPIOD_IDRbits+0)
_LX	[R0, ByteOffset(GPIOD_IDRbits+0)]
CMP	R0, #0
IT	NE
BNE	L_main395
;DriverRF4463PROMain.c,647 :: 		vRF4463ClearInterrupts();
BL	_vRF4463ClearInterrupts+0
;DriverRF4463PROMain.c,649 :: 		if ( ( spi_read_buf[ 4 ] & 0x08) == 0 ) { // crc error check
MOVW	R0, #lo_addr(_spi_read_buf+4)
MOVT	R0, #hi_addr(_spi_read_buf+4)
LDRB	R0, [R0, #0]
AND	R0, R0, #8
UXTB	R0, R0
CMP	R0, #0
IT	NE
BNE	L_main396
;DriverRF4463PROMain.c,653 :: 		spi_read_fifo();
BL	_spi_read_fifo+0
;DriverRF4463PROMain.c,654 :: 		vRF4463FifoReset();
BL	_vRF4463FifoReset+0
;DriverRF4463PROMain.c,656 :: 		chksum = 0;
MOVS	R0, #0
STRB	R0, [SP, #5]
;DriverRF4463PROMain.c,657 :: 		for ( i = 4; i < payload_length - 1; i++ )                // Calculation Checksum
MOVS	R0, #4
STRB	R0, [SP, #4]
L_main397:
LDRB	R0, [SP, #4]
CMP	R0, #65
IT	GE
BGE	L_main398
;DriverRF4463PROMain.c,658 :: 		chksum += rx_buf[ i ];
LDRB	R1, [SP, #4]
MOVW	R0, #lo_addr(_rx_buf+0)
MOVT	R0, #hi_addr(_rx_buf+0)
ADDS	R0, R0, R1
LDRB	R1, [R0, #0]
LDRB	R0, [SP, #5]
ADDS	R0, R0, R1
STRB	R0, [SP, #5]
;DriverRF4463PROMain.c,657 :: 		for ( i = 4; i < payload_length - 1; i++ )                // Calculation Checksum
LDRB	R0, [SP, #4]
ADDS	R0, R0, #1
STRB	R0, [SP, #4]
;DriverRF4463PROMain.c,658 :: 		chksum += rx_buf[ i ];
IT	AL
BAL	L_main397
L_main398:
;DriverRF4463PROMain.c,660 :: 		if ( ( chksum == rx_buf[ payload_length - 1 ] )&&( rx_buf[ 4 ] == 0x41 )) {
MOVW	R0, #lo_addr(_rx_buf+65)
MOVT	R0, #hi_addr(_rx_buf+65)
LDRB	R1, [R0, #0]
LDRB	R0, [SP, #5]
CMP	R0, R1
IT	NE
BNE	L_main402
MOVW	R0, #lo_addr(_rx_buf+4)
MOVT	R0, #hi_addr(_rx_buf+4)
LDRB	R0, [R0, #0]
CMP	R0, #65
IT	NE
BNE	L_main402
L__main431:
;DriverRF4463PROMain.c,665 :: 		UART1_Write_Text( rx_buf );
MOVW	R0, #lo_addr(_rx_buf+0)
MOVT	R0, #hi_addr(_rx_buf+0)
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,666 :: 		UART1_Write_Text("\r\n");
MOVS	R0, #13
STRB	R0, [SP, #78]
MOVS	R0, #10
STRB	R0, [SP, #79]
MOVS	R0, #0
STRB	R0, [SP, #80]
ADD	R0, SP, #78
MOV	R4, R0
MOV	R0, R4
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,669 :: 		rx_cnt++;
MOVW	R0, #lo_addr(_rx_cnt+0)
MOVT	R0, #hi_addr(_rx_cnt+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(_rx_cnt+0)
MOVT	R0, #hi_addr(_rx_cnt+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,675 :: 		}
IT	AL
BAL	L_main403
L_main402:
;DriverRF4463PROMain.c,677 :: 		vRF4463RxInit();    // The received data is wrong, you must continue to receive
BL	_vRF4463RxInit+0
L_main403:
;DriverRF4463PROMain.c,678 :: 		}
IT	AL
BAL	L_main404
L_main396:
;DriverRF4463PROMain.c,681 :: 		vUSART1Start_TX("[ CRC ] Fail\r\n", 14 );
MOVS	R0, #14
PUSH	(R0)
ADD	R11, SP, #85
ADD	R10, R11, #15
MOVW	R12, #lo_addr(?ICS?lstr6_DriverRF4463PROMain+0)
MOVT	R12, #hi_addr(?ICS?lstr6_DriverRF4463PROMain+0)
BL	___CC2DW+0
ADD	R0, SP, #85
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,682 :: 		VRF4463SDNReset();
BL	_VRF4463SDNReset+0
;DriverRF4463PROMain.c,683 :: 		vRF4463Init();
BL	_vRF4463Init+0
;DriverRF4463PROMain.c,684 :: 		vRF4463RxInit();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,685 :: 		}
L_main404:
;DriverRF4463PROMain.c,686 :: 		}
L_main395:
;DriverRF4463PROMain.c,687 :: 		}
L_main394:
;DriverRF4463PROMain.c,688 :: 		}
IT	AL
BAL	L_main389
L_main390:
;DriverRF4463PROMain.c,689 :: 		}
L_main388:
;DriverRF4463PROMain.c,690 :: 		}
IT	AL
BAL	L_main371
;DriverRF4463PROMain.c,691 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
