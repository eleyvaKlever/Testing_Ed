_Int_SPI3:
;driverspi.c,43 :: 		void Int_SPI3() iv IVT_INT_SPI3 ics ICS_AUTO {
;driverspi.c,45 :: 		if ( SPI3_SRbits.RXNE ) {
MOVW	R0, #lo_addr(SPI3_SRbits+0)
MOVT	R0, #hi_addr(SPI3_SRbits+0)
_LX	[R0, ByteOffset(SPI3_SRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_Int_SPI30
;driverspi.c,46 :: 		ucSPI3ByteReceived = ( unsigned char )SPI3_DR;      // lee el Byte recibido
MOVW	R0, #lo_addr(SPI3_DR+0)
MOVT	R0, #hi_addr(SPI3_DR+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucSPI3ByteReceived+0)
MOVT	R0, #hi_addr(_ucSPI3ByteReceived+0)
STRB	R1, [R0, #0]
;driverspi.c,48 :: 		LED_GREEN = ~LED_GREEN;
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_LX	[R0, ByteOffset(GPIOC_ODRbits+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;driverspi.c,49 :: 		}
L_Int_SPI30:
;driverspi.c,50 :: 		}
L_end_Int_SPI3:
BX	LR
; end of _Int_SPI3
_vSPI3Init:
;driverspi.c,107 :: 		void vSPI3Init ( void ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;driverspi.c,109 :: 		_SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI3_PC10_11_12 );
MOVW	R2, #lo_addr(__GPIO_MODULE_SPI3_PC10_11_12+0)
MOVT	R2, #hi_addr(__GPIO_MODULE_SPI3_PC10_11_12+0)
MOVW	R1, #772
;driverspi.c,108 :: 		SPI3_Init_Advanced( _SPI_FPCLK_DIV16, _SPI_MASTER | _SPI_8_BIT | _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION | _SPI_MSB_FIRST |
MOVS	R0, #3
;driverspi.c,109 :: 		_SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI3_PC10_11_12 );
BL	_SPI3_Init_Advanced+0
;driverspi.c,111 :: 		SPI3_CR2bits.RXNEIE  = 1;       // habilitacion de ISR para RX
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(SPI3_CR2bits+0)
MOVT	R0, #hi_addr(SPI3_CR2bits+0)
_SX	[R0, ByteOffset(SPI3_CR2bits+0)]
;driverspi.c,113 :: 		NVIC_IntEnable( IVT_INT_SPI3 );
MOVW	R0, #67
BL	_NVIC_IntEnable+0
;driverspi.c,114 :: 		}
L_end_vSPI3Init:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vSPI3Init
_vRF4463Init:
;driverrf4463pro.c,53 :: 		void vRF4463Init ( void ) {  // MODE,
SUB	SP, SP, #28
STR	LR, [SP, #0]
;driverrf4463pro.c,56 :: 		for ( i = 4; i < 16; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init1:
LDRB	R0, [SP, #24]
CMP	R0, #16
IT	CS
BCS	L_vRF4463Init2
;driverrf4463pro.c,57 :: 		RF_MODEM_MOD_TYPE_12_data[ i ] = RF_MODEM_MOD_TYPE_12[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,56 :: 		for ( i = 4; i < 16; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,58 :: 		}
IT	AL
BAL	L_vRF4463Init1
L_vRF4463Init2:
;driverrf4463pro.c,61 :: 		if ( ucRF4463Freq3 < 8 ) {
MOVW	R0, #lo_addr(_ucRF4463Freq3+0)
MOVT	R0, #hi_addr(_ucRF4463Freq3+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CS
BCS	L_vRF4463Init4
;driverrf4463pro.c,62 :: 		for ( i = 4; i < 12; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init5:
LDRB	R0, [SP, #24]
CMP	R0, #12
IT	CS
BCS	L_vRF4463Init6
;driverrf4463pro.c,63 :: 		RF_MODEM_TX_RAMP_DELAY_8_data[ i ] = RF_MODEM_TX_RAMP_DELAY_8_433[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,62 :: 		for ( i = 4; i < 12; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,64 :: 		}
IT	AL
BAL	L_vRF4463Init5
L_vRF4463Init6:
;driverrf4463pro.c,65 :: 		for ( i = 4; i < 11; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init8:
LDRB	R0, [SP, #24]
CMP	R0, #11
IT	CS
BCS	L_vRF4463Init9
;driverrf4463pro.c,66 :: 		RF_MODEM_AFC_GEAR_7_data[ i ] = RF_MODEM_AFC_GEAR_7_433[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,65 :: 		for ( i = 4; i < 11; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,67 :: 		}
IT	AL
BAL	L_vRF4463Init8
L_vRF4463Init9:
;driverrf4463pro.c,68 :: 		for ( i = 4; i < 15; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init11:
LDRB	R0, [SP, #24]
CMP	R0, #15
IT	CS
BCS	L_vRF4463Init12
;driverrf4463pro.c,69 :: 		RF_MODEM_OOK_CNT1_11_data[ i ] = RF_MODEM_OOK_CNT1_11_433[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,68 :: 		for ( i = 4; i < 15; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,70 :: 		}
IT	AL
BAL	L_vRF4463Init11
L_vRF4463Init12:
;driverrf4463pro.c,71 :: 		for ( i = 4; i < 16; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init14:
LDRB	R0, [SP, #24]
CMP	R0, #16
IT	CS
BCS	L_vRF4463Init15
;driverrf4463pro.c,72 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,71 :: 		for ( i = 4; i < 16; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,73 :: 		}
IT	AL
BAL	L_vRF4463Init14
L_vRF4463Init15:
;driverrf4463pro.c,74 :: 		for ( i = 4; i < 16; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init17:
LDRB	R0, [SP, #24]
CMP	R0, #16
IT	CS
BCS	L_vRF4463Init18
;driverrf4463pro.c,75 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,74 :: 		for ( i = 4; i < 16; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,76 :: 		}
IT	AL
BAL	L_vRF4463Init17
L_vRF4463Init18:
;driverrf4463pro.c,77 :: 		for ( i = 4; i < 16; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init20:
LDRB	R0, [SP, #24]
CMP	R0, #16
IT	CS
BCS	L_vRF4463Init21
;driverrf4463pro.c,78 :: 		RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,77 :: 		for ( i = 4; i < 16; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,79 :: 		}
IT	AL
BAL	L_vRF4463Init20
L_vRF4463Init21:
;driverrf4463pro.c,80 :: 		for ( i = 4; i < 13; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init23:
LDRB	R0, [SP, #24]
CMP	R0, #13
IT	CS
BCS	L_vRF4463Init24
;driverrf4463pro.c,81 :: 		RF_MODEM_AGC_WINDOW_SIZE_9_data[ i ] = RF_MODEM_AGC_WINDOW_SIZE_9_433[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,80 :: 		for ( i = 4; i < 13; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,82 :: 		}
IT	AL
BAL	L_vRF4463Init23
L_vRF4463Init24:
;driverrf4463pro.c,83 :: 		for ( i = 4; i < 13; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init26:
LDRB	R0, [SP, #24]
CMP	R0, #13
IT	CS
BCS	L_vRF4463Init27
;driverrf4463pro.c,84 :: 		RF_MODEM_BCR_OSR_1_9_data[ i ] = RF_MODEM_BCR_OSR_1_9_433[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,83 :: 		for ( i = 4; i < 13; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,85 :: 		}
IT	AL
BAL	L_vRF4463Init26
L_vRF4463Init27:
;driverrf4463pro.c,86 :: 		}
IT	AL
BAL	L_vRF4463Init29
L_vRF4463Init4:
;driverrf4463pro.c,88 :: 		for ( i = 4; i < 12; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init30:
LDRB	R0, [SP, #24]
CMP	R0, #12
IT	CS
BCS	L_vRF4463Init31
;driverrf4463pro.c,89 :: 		RF_MODEM_TX_RAMP_DELAY_8_data[ i ] = RF_MODEM_TX_RAMP_DELAY_8_850[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,88 :: 		for ( i = 4; i < 12; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,90 :: 		}
IT	AL
BAL	L_vRF4463Init30
L_vRF4463Init31:
;driverrf4463pro.c,91 :: 		for ( i = 4; i < 11; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init33:
LDRB	R0, [SP, #24]
CMP	R0, #11
IT	CS
BCS	L_vRF4463Init34
;driverrf4463pro.c,92 :: 		RF_MODEM_AFC_GEAR_7_data[ i ] = RF_MODEM_AFC_GEAR_7_850[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,91 :: 		for ( i = 4; i < 11; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,93 :: 		}
IT	AL
BAL	L_vRF4463Init33
L_vRF4463Init34:
;driverrf4463pro.c,94 :: 		for ( i = 4; i < 15; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init36:
LDRB	R0, [SP, #24]
CMP	R0, #15
IT	CS
BCS	L_vRF4463Init37
;driverrf4463pro.c,95 :: 		RF_MODEM_OOK_CNT1_11_data[ i ] = RF_MODEM_OOK_CNT1_11_850[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,94 :: 		for ( i = 4; i < 15; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,96 :: 		}
IT	AL
BAL	L_vRF4463Init36
L_vRF4463Init37:
;driverrf4463pro.c,97 :: 		for ( i = 4; i < 16; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init39:
LDRB	R0, [SP, #24]
CMP	R0, #16
IT	CS
BCS	L_vRF4463Init40
;driverrf4463pro.c,98 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,97 :: 		for ( i = 4; i < 16; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,99 :: 		}
IT	AL
BAL	L_vRF4463Init39
L_vRF4463Init40:
;driverrf4463pro.c,100 :: 		for ( i = 4; i < 16; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init42:
LDRB	R0, [SP, #24]
CMP	R0, #16
IT	CS
BCS	L_vRF4463Init43
;driverrf4463pro.c,101 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,100 :: 		for ( i = 4; i < 16; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,102 :: 		}
IT	AL
BAL	L_vRF4463Init42
L_vRF4463Init43:
;driverrf4463pro.c,103 :: 		for ( i = 4; i < 16; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init45:
LDRB	R0, [SP, #24]
CMP	R0, #16
IT	CS
BCS	L_vRF4463Init46
;driverrf4463pro.c,104 :: 		RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,103 :: 		for ( i = 4; i < 16; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,105 :: 		}
IT	AL
BAL	L_vRF4463Init45
L_vRF4463Init46:
;driverrf4463pro.c,106 :: 		for ( i = 4; i < 13; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init48:
LDRB	R0, [SP, #24]
CMP	R0, #13
IT	CS
BCS	L_vRF4463Init49
;driverrf4463pro.c,107 :: 		RF_MODEM_AGC_WINDOW_SIZE_9_data[ i ] = RF_MODEM_AGC_WINDOW_SIZE_9_850[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,106 :: 		for ( i = 4; i < 13; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,108 :: 		}
IT	AL
BAL	L_vRF4463Init48
L_vRF4463Init49:
;driverrf4463pro.c,109 :: 		for ( i = 4; i < 13; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init51:
LDRB	R0, [SP, #24]
CMP	R0, #13
IT	CS
BCS	L_vRF4463Init52
;driverrf4463pro.c,110 :: 		RF_MODEM_BCR_OSR_1_9_data[ i ] = RF_MODEM_BCR_OSR_1_9_850[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,109 :: 		for ( i = 4; i < 13; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,111 :: 		}
IT	AL
BAL	L_vRF4463Init51
L_vRF4463Init52:
;driverrf4463pro.c,112 :: 		}
L_vRF4463Init29:
;driverrf4463pro.c,113 :: 		for ( i = 4; i < 11; i++ ) {
MOVS	R0, #4
STRB	R0, [SP, #24]
L_vRF4463Init54:
LDRB	R0, [SP, #24]
CMP	R0, #11
IT	CS
BCS	L_vRF4463Init55
;driverrf4463pro.c,114 :: 		RF_SYNTH_PFDCP_CPFF_7_data[ i ] = RF_SYNTH_PFDCP_CPFF_7[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,113 :: 		for ( i = 4; i < 11; i++ ) {
LDRB	R0, [SP, #24]
ADDS	R0, R0, #1
STRB	R0, [SP, #24]
;driverrf4463pro.c,115 :: 		}
IT	AL
BAL	L_vRF4463Init54
L_vRF4463Init55:
;driverrf4463pro.c,119 :: 		vRF4463GPIO_SET( ucRF4463Mode );                              // PARAMETRO CONFIGURABLE
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
PUSH	(R0)
BL	_vRF4463GPIO_SET+0
ADD	SP, SP, #4
;driverrf4463pro.c,122 :: 		app_command_buf[ 0 ] = 0x11;    // SET PROPERTY
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,123 :: 		app_command_buf[ 1 ] = 0x00;    // 0x0000
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,124 :: 		app_command_buf[ 2 ] = 0x01;    // Total 1 Parameters
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,125 :: 		app_command_buf[ 3 ] = 0x00;    // 0x0000
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,126 :: 		app_command_buf[ 4 ] = 98;      // freq  adjustment    ( rango desde 0 - 127 Low cap - High Cap )
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #98
STRB	R0, [R1, #0]
;driverrf4463pro.c,127 :: 		spi_write( 5, app_command_buf );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,130 :: 		app_command_buf[ 0 ] = 0x11;    // SET PROPERTY
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,131 :: 		app_command_buf[ 1 ] = 0x00;    // 0x0003
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,132 :: 		app_command_buf[ 2 ] = 0x01;    // Total 1 Parameters
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,133 :: 		app_command_buf[ 3 ] = 0x03;    // 0x0003
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,134 :: 		app_command_buf[ 4 ] = 0x40;    // tx = rx = 64 byte, ordinary PH,high performance mode  ?????????????????????
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #64
STRB	R0, [R1, #0]
;driverrf4463pro.c,135 :: 		spi_write( 5, app_command_buf );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,139 :: 		spi_write( 0x08, RF_FRR_CTL_A_MODE_4_data );    // disable all fast response register
MOVW	R0, #lo_addr(_RF_FRR_CTL_A_MODE_4_data+0)
MOVT	R0, #hi_addr(_RF_FRR_CTL_A_MODE_4_data+0)
PUSH	(R0)
MOVS	R0, #8
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,142 :: 		app_command_buf[ 0 ] = 0x11;    // SET PROPERTY
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,143 :: 		app_command_buf[ 1 ] = 0x10;    // 0x1000
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #16
STRB	R0, [R1, #0]
;driverrf4463pro.c,144 :: 		app_command_buf[ 2 ] = 0x09;    // Total 9 Parameters
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #9
STRB	R0, [R1, #0]
;driverrf4463pro.c,145 :: 		app_command_buf[ 3 ] = 0x00;    // 0x1000
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,147 :: 		if ( ucRF4463Mode == tx_test_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_vRF4463Init57
;driverrf4463pro.c,148 :: 		app_command_buf[ 4 ] = 0xff;     //  Need to send 255 bytes of Preamble
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #255
STRB	R0, [R1, #0]
;driverrf4463pro.c,149 :: 		}
IT	AL
BAL	L_vRF4463Init58
L_vRF4463Init57:
;driverrf4463pro.c,151 :: 		app_command_buf[ 4 ] = 0x08;   //  Need to send 8 bytes of Preamble
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,152 :: 		}
L_vRF4463Init58:
;driverrf4463pro.c,155 :: 		app_command_buf[ 5 ]   = 0x14;       // To detect 20 bit sync word,
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #20
STRB	R0, [R1, #0]
;driverrf4463pro.c,156 :: 		app_command_buf[ 6 ]   = 0x00;       // Non-standard preamble settings, useless
ADD	R0, SP, #4
ADDS	R1, R0, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,157 :: 		app_command_buf[ 7 ]   = 0x0f;       // Time of the preamble Timeout   ????????????????????????????????????????????????????????????
ADD	R0, SP, #4
ADDS	R1, R0, #7
MOVS	R0, #15
STRB	R0, [R1, #0]
;driverrf4463pro.c,158 :: 		app_command_buf[ 8 ]   = 0x31;       // The length of the preamble is   byte Calculation , 1st = 1 NO manchest  Encoding, using standard 1010.??
ADD	R0, SP, #4
ADDW	R1, R0, #8
MOVS	R0, #49
STRB	R0, [R1, #0]
;driverrf4463pro.c,159 :: 		app_command_buf[ 9 ]   = 0x0;        // Non-standard Preamble Patten 4th byte
ADD	R0, SP, #4
ADDW	R1, R0, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,160 :: 		app_command_buf[ 10 ]  = 0x00;       // Non-standard Preamble Patten 3rd byte
ADD	R0, SP, #4
ADDW	R1, R0, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,161 :: 		app_command_buf[ 11 ]  = 0x00;       // Non-standard Preamble Patten 2nd byte
ADD	R0, SP, #4
ADDW	R1, R0, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,162 :: 		app_command_buf[ 12 ]  = 0x00;       // Non-standard Preamble Patten 1st byte
ADD	R0, SP, #4
ADDW	R1, R0, #12
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,163 :: 		spi_write(13, app_command_buf);
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #13
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,166 :: 		app_command_buf[ 0 ] = 0x11;         // SET PROPERTY
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,167 :: 		app_command_buf[ 1 ] = 0x11;         // command = 0x1100
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,168 :: 		app_command_buf[ 2 ] = 0x05;         // Total 5 Parameters
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #5
STRB	R0, [R1, #0]
;driverrf4463pro.c,169 :: 		app_command_buf[ 3 ] = 0x00;         // command = 0x1100
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,170 :: 		app_command_buf[ 4 ] = 0x01;         // The synchronization word is defined and sent in the length field, and the synchronization word cannot be wrong,Not 4FSK, not manchest encoding, only 2 bytes
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,172 :: 		if ( ucRF4463Mode == tx_test_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_vRF4463Init59
;driverrf4463pro.c,173 :: 		app_command_buf[ 5 ] = 0x55;      // Sync word 3
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #85
STRB	R0, [R1, #0]
;driverrf4463pro.c,174 :: 		app_command_buf[ 6 ] = 0x55;      // Sync word 2
ADD	R0, SP, #4
ADDS	R1, R0, #6
MOVS	R0, #85
STRB	R0, [R1, #0]
;driverrf4463pro.c,175 :: 		}
IT	AL
BAL	L_vRF4463Init60
L_vRF4463Init59:
;driverrf4463pro.c,177 :: 		app_command_buf[ 5 ] = 0x2d;    // Sync word 3
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #45
STRB	R0, [R1, #0]
;driverrf4463pro.c,178 :: 		app_command_buf[ 6 ] = 0xd4;    // Sync word 2
ADD	R0, SP, #4
ADDS	R1, R0, #6
MOVS	R0, #212
STRB	R0, [R1, #0]
;driverrf4463pro.c,179 :: 		}
L_vRF4463Init60:
;driverrf4463pro.c,181 :: 		app_command_buf[ 7 ] = 0x00;         // Sync word 1
ADD	R0, SP, #4
ADDS	R1, R0, #7
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,182 :: 		app_command_buf[ 8 ] = 0x00;         // Sync word 0
ADD	R0, SP, #4
ADDW	R1, R0, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,183 :: 		spi_write( 9, app_command_buf );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #9
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,186 :: 		app_command_buf[ 0 ] = 0x11;        // SET PROPERTY
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,187 :: 		app_command_buf[ 1 ] = 0x12;        // command = 0x1200
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,188 :: 		app_command_buf[ 2 ] = 0x01;        // Total 1 Parameters
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,189 :: 		app_command_buf[ 3 ] = 0x00;        // command = 0x1200
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,190 :: 		app_command_buf[ 4 ] = 0x85;        // 1?cRC ??,CRC = itu-c, enable crc   ( original 0x81; )
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #133
STRB	R0, [R1, #0]
;driverrf4463pro.c,191 :: 		spi_write( 5, app_command_buf );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,194 :: 		app_command_buf[ 0 ] = 0x11;        // SET PROPERTY
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,195 :: 		app_command_buf[ 1 ] = 0x12;        // command = 0x1206
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,196 :: 		app_command_buf[ 2 ] = 0x01;        // Total 1Parameters
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,197 :: 		app_command_buf[ 3 ] = 0x06;        // command = 0x1206
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #6
STRB	R0, [R1, #0]
;driverrf4463pro.c,198 :: 		app_command_buf[ 4 ] = 0x02;        //  tx = rx = 120d--1220 (tx packet,ph enable, not 4fsk, After receiving a packet of data,RX off,CRC Do not flip ,CRC MSB, data MSB
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,199 :: 		spi_write( 5, app_command_buf );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,202 :: 		app_command_buf[ 0 ] = 0x11;        // SET PROPERTY
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,203 :: 		app_command_buf[ 1 ] = 0x12;        // command = 0x1208
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,204 :: 		app_command_buf[ 2 ] = 0x03;        // Total 3 Parameters
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,205 :: 		app_command_buf[ 3 ] = 0x08;        // command = 0x1208
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,206 :: 		app_command_buf[ 4 ] = 0x00;        // Length Field = LSB,  length Only 1 byte,length Not put In FiFo, fixed packet length mode
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,207 :: 		app_command_buf[ 5 ] = 0x00;        // Used for variable packet length mode, which defines which Field contains length Filed
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,208 :: 		app_command_buf[ 6 ] = 0x00;        // Used for variable packet length mode, adjust the length of variable packet length
ADD	R0, SP, #4
ADDS	R1, R0, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,209 :: 		spi_write( 7, app_command_buf );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #7
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,212 :: 		app_command_buf[ 0 ]  = 0x11;
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,213 :: 		app_command_buf[ 1 ]  = 0x12;   // 0x120d
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,214 :: 		app_command_buf[ 2 ]  = 0x0c;   // Total 12 Parameters
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #12
STRB	R0, [R1, #0]
;driverrf4463pro.c,215 :: 		app_command_buf[ 3 ]  = 0x0d;   // 0x120d
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #13
STRB	R0, [R1, #0]
;driverrf4463pro.c,218 :: 		app_command_buf[ 4 ]  = 0x00;   // 0x0D  // Field 1 length (?4?)                             // 0x0D
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,219 :: 		app_command_buf[ 5 ]  = payload_length;  // field 1 length, (? 8?), ?Total14???        // 0x0E
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #66
STRB	R0, [R1, #0]
;driverrf4463pro.c,220 :: 		app_command_buf[ 6 ]  = 0x04;   // 0x0F  // field 1 Is not 4FSK,manchest, whiting, PN9,       // 0x0F
ADD	R0, SP, #4
ADDS	R1, R0, #6
MOVS	R0, #4
STRB	R0, [R1, #0]
;driverrf4463pro.c,221 :: 		app_command_buf[ 7 ]  = 0xaa;   // 0x10  // field 1 crc enble, check enbale, There are also launchingCRC,cRC?Seed ?CRC_seed?????
ADD	R0, SP, #4
ADDS	R1, R0, #7
MOVS	R0, #170
STRB	R0, [R1, #0]
;driverrf4463pro.c,224 :: 		app_command_buf[ 8 ]  = 0x00;   // 0x11  // field 2 length(?4?)
ADD	R0, SP, #4
ADDW	R1, R0, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,225 :: 		app_command_buf[ 9 ]  = 0x00;   // 0x12  // field 2 length, (? 8?), length = 0 Means thisfield did not use
ADD	R0, SP, #4
ADDW	R1, R0, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,226 :: 		app_command_buf[ 10 ] = 0x00;   // 0x13  // field 2 Is not 4FSK,manchest, whiting, PN9
ADD	R0, SP, #4
ADDW	R1, R0, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,227 :: 		app_command_buf[ 11 ] = 0x00;   // 0x14  // field 2 ?CRCSet up
ADD	R0, SP, #4
ADDW	R1, R0, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,230 :: 		app_command_buf[ 12 ] = 0x00;   // 0x15  // field 3 length, (? 8?), length = 0 Means thisfield did not use
ADD	R0, SP, #4
ADDW	R1, R0, #12
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,231 :: 		app_command_buf[ 13 ] = 0x00;   // 0x16  // field 3 length, (? 8?), length = 0 Means thisfield did not use
ADD	R0, SP, #4
ADDW	R1, R0, #13
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,232 :: 		app_command_buf[ 14 ] = 0x00;   // 0x17  // field 3 Is not 4FSK,manchest, whiting, PN9
ADD	R0, SP, #4
ADDW	R1, R0, #14
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,233 :: 		app_command_buf[ 15 ] = 0x00;   // 0x18  // field 3 ?CRCSet up
ADD	R0, SP, #4
ADDW	R1, R0, #15
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,234 :: 		spi_write( 16, app_command_buf );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #16
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,237 :: 		app_command_buf[ 0 ]  = 0x11;
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,238 :: 		app_command_buf[ 1 ]  = 0x12;       // 0x1219
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,239 :: 		app_command_buf[ 2 ]  = 0x08;       // Total 8Parameters
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,240 :: 		app_command_buf[ 3 ]  = 0x19;       // 0x1219
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #25
STRB	R0, [R1, #0]
;driverrf4463pro.c,241 :: 		app_command_buf[ 4 ]  = 0x00;       // field4 length(?4?)
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,242 :: 		app_command_buf[ 5 ]  = 0x00;       // field 4 length, (? 8?), length = 0 Means this field did not use
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,243 :: 		app_command_buf[ 6 ]  = 0x00;       // field 4 Is not 4FSK,manchest, whiting, PN9
ADD	R0, SP, #4
ADDS	R1, R0, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,244 :: 		app_command_buf[ 7 ]  = 0x00;       // field 4 ?CRCSet up
ADD	R0, SP, #4
ADDS	R1, R0, #7
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,245 :: 		app_command_buf[ 8 ]  = 0x00;       // field5 length(?4?)
ADD	R0, SP, #4
ADDW	R1, R0, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,246 :: 		app_command_buf[ 9 ]  = 0x00;       // field 5 length, (? 8?), length = 0 Means this field did not use
ADD	R0, SP, #4
ADDW	R1, R0, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,247 :: 		app_command_buf[ 10 ] = 0x00;       // field 5 Is not 4FSK,manchest, whiting, PN9
ADD	R0, SP, #4
ADDW	R1, R0, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,248 :: 		app_command_buf[ 11 ] = 0x00;       // field 5 ?CRCSet up
ADD	R0, SP, #4
ADDW	R1, R0, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,249 :: 		spi_write( 12, app_command_buf );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #12
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,252 :: 		spi_write( 0x10, RF_MODEM_MOD_TYPE_12_data );   // //  2FSK ,  module source = PH fifo, disable manchest, tx, rx Do not flip, deviation Do not flip
MOVW	R0, #lo_addr(_RF_MODEM_MOD_TYPE_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_MOD_TYPE_12_data+0)
PUSH	(R0)
MOVS	R0, #16
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,255 :: 		app_command_buf[0]  = 0x11;
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,256 :: 		app_command_buf[1]  = 0x20;    // 0x200c
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,257 :: 		app_command_buf[2]  = 0x01;    // Total 1Parameters
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,258 :: 		app_command_buf[3]  = 0x0c;    // 0x200c
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #12
STRB	R0, [R1, #0]
;driverrf4463pro.c,260 :: 		if ( ucRF4463Freq3 < 8 ) {
MOVW	R0, #lo_addr(_ucRF4463Freq3+0)
MOVT	R0, #hi_addr(_ucRF4463Freq3+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CS
BCS	L_vRF4463Init61
;driverrf4463pro.c,261 :: 		if ( ucRF4463Rate >= dr_256k ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CC
BCC	L_vRF4463Init62
;driverrf4463pro.c,262 :: 		app_command_buf[ 4 ] = 0x4f;
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #79
STRB	R0, [R1, #0]
;driverrf4463pro.c,263 :: 		}
IT	AL
BAL	L_vRF4463Init63
L_vRF4463Init62:
;driverrf4463pro.c,264 :: 		else if ( ucRF4463Rate >= dr_19p2 ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	CC
BCC	L_vRF4463Init64
;driverrf4463pro.c,265 :: 		app_command_buf[ 4 ]  = 0x5e;
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #94
STRB	R0, [R1, #0]
;driverrf4463pro.c,266 :: 		}
IT	AL
BAL	L_vRF4463Init65
L_vRF4463Init64:
;driverrf4463pro.c,268 :: 		app_command_buf[ 4 ]  = 0xd2;
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #210
STRB	R0, [R1, #0]
;driverrf4463pro.c,269 :: 		}
L_vRF4463Init65:
L_vRF4463Init63:
;driverrf4463pro.c,270 :: 		}
IT	AL
BAL	L_vRF4463Init66
L_vRF4463Init61:
;driverrf4463pro.c,272 :: 		if ( ucRF4463Rate >= dr_115p2 ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	CC
BCC	L_vRF4463Init67
;driverrf4463pro.c,273 :: 		app_command_buf[ 4 ]  = 0x69;        // 15k
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #105
STRB	R0, [R1, #0]
;driverrf4463pro.c,274 :: 		}
IT	AL
BAL	L_vRF4463Init68
L_vRF4463Init67:
;driverrf4463pro.c,275 :: 		else if ( ucRF4463Rate >= dr_19p2 ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	CC
BCC	L_vRF4463Init69
;driverrf4463pro.c,276 :: 		app_command_buf[ 4 ]  = 0x5e;        // 10k
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #94
STRB	R0, [R1, #0]
;driverrf4463pro.c,277 :: 		}
IT	AL
BAL	L_vRF4463Init70
L_vRF4463Init69:
;driverrf4463pro.c,279 :: 		app_command_buf[ 4 ]  = 0x18; // 8k
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #24
STRB	R0, [R1, #0]
;driverrf4463pro.c,280 :: 		}
L_vRF4463Init70:
L_vRF4463Init68:
;driverrf4463pro.c,281 :: 		}
L_vRF4463Init66:
;driverrf4463pro.c,282 :: 		spi_write( 5, app_command_buf );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,285 :: 		spi_write( 0x0C, RF_MODEM_TX_RAMP_DELAY_8_data );            // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
PUSH	(R0)
MOVS	R0, #12
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,286 :: 		spi_write( 0x0D, RF_MODEM_BCR_OSR_1_9_data );                // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
PUSH	(R0)
MOVS	R0, #13
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,287 :: 		spi_write( 0x0B, RF_MODEM_AFC_GEAR_7_data );                // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_AFC_GEAR_7_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AFC_GEAR_7_data+0)
PUSH	(R0)
MOVS	R0, #11
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,288 :: 		spi_write( 0x05, RF_MODEM_AGC_CONTROL_1_data );                // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_AGC_CONTROL_1_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_CONTROL_1_data+0)
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,289 :: 		spi_write( 0x0D, RF_MODEM_AGC_WINDOW_SIZE_9_data );        // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
PUSH	(R0)
MOVS	R0, #13
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,290 :: 		spi_write( 0x0F, RF_MODEM_OOK_CNT1_11_data );                // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_OOK_CNT1_11_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_OOK_CNT1_11_data+0)
PUSH	(R0)
MOVS	R0, #15
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,293 :: 		app_command_buf[ 0 ] = 0x11;
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,294 :: 		app_command_buf[ 1 ] = 0x20;    // 0x204e
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,295 :: 		app_command_buf[ 2 ] = 0x01;    // Total 1Parameters
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,296 :: 		app_command_buf[ 3 ] = 0x4e;    // 0x204e
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #78
STRB	R0, [R1, #0]
;driverrf4463pro.c,298 :: 		if ( ucRF4463Rate == dr_500 ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	NE
BNE	L_vRF4463Init71
;driverrf4463pro.c,299 :: 		app_command_buf[ 4 ] = 0x3a;
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #58
STRB	R0, [R1, #0]
;driverrf4463pro.c,300 :: 		}
IT	AL
BAL	L_vRF4463Init72
L_vRF4463Init71:
;driverrf4463pro.c,302 :: 		app_command_buf[ 4 ] = 0x40;  //  rssi Reading deviation, the difference with the true value
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #64
STRB	R0, [R1, #0]
;driverrf4463pro.c,303 :: 		}
L_vRF4463Init72:
;driverrf4463pro.c,304 :: 		spi_write( 5, app_command_buf );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,307 :: 		spi_write( 0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data );  // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
PUSH	(R0)
MOVS	R0, #16
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,308 :: 		spi_write( 0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data );   // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
PUSH	(R0)
MOVS	R0, #16
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,309 :: 		spi_write( 0x10, RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data );   // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
PUSH	(R0)
MOVS	R0, #16
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,312 :: 		app_command_buf[ 0 ]  = 0x11;
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,313 :: 		app_command_buf[ 1 ]  = 0x22;    // 0x2200
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #34
STRB	R0, [R1, #0]
;driverrf4463pro.c,314 :: 		app_command_buf[ 2 ]  = 0x04;    // Total 4Parameters
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #4
STRB	R0, [R1, #0]
;driverrf4463pro.c,315 :: 		app_command_buf[ 3 ]  = 0x00;   // 0x2200
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,316 :: 		app_command_buf[ 4 ]  = 0x08;  //0x10;   //   PA mode  = default , ??Class E mode,?Is not Switch Current mode  ????????
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,318 :: 		if ( ucRF4463Power > 0 || ucRF4463Power < 127 ) {
MOVW	R0, #lo_addr(_ucRF4463Power+0)
MOVT	R0, #hi_addr(_ucRF4463Power+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	HI
BHI	L__vRF4463Init456
MOVW	R0, #lo_addr(_ucRF4463Power+0)
MOVT	R0, #hi_addr(_ucRF4463Power+0)
LDRB	R0, [R0, #0]
CMP	R0, #127
IT	CC
BCC	L__vRF4463Init456
IT	AL
BAL	L_vRF4463Init75
L__vRF4463Init456:
;driverrf4463pro.c,319 :: 		app_command_buf[ 5 ]  = ucRF4463Power;   //  Set to maximum power
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVW	R0, #lo_addr(_ucRF4463Power+0)
MOVT	R0, #hi_addr(_ucRF4463Power+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,320 :: 		}
IT	AL
BAL	L_vRF4463Init76
L_vRF4463Init75:
;driverrf4463pro.c,322 :: 		app_command_buf[ 5 ]  = 127;
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #127
STRB	R0, [R1, #0]
;driverrf4463pro.c,323 :: 		}
L_vRF4463Init76:
;driverrf4463pro.c,325 :: 		app_command_buf[ 6 ] = 0x00; //???????? 0x00;   // CLK duty = 50%, other = Default
ADD	R0, SP, #4
ADDS	R1, R0, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,327 :: 		if ( ( ucRF4463Rate <= dr_115p2 )||( ucRF4463Rate == dr_500 ) ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	LS
BLS	L__vRF4463Init455
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	EQ
BEQ	L__vRF4463Init455
IT	AL
BAL	L_vRF4463Init79
L__vRF4463Init455:
;driverrf4463pro.c,328 :: 		app_command_buf[ 7 ]  = 0x3d;  // ???????? 0x5d;   // PA ramp time = default
ADD	R0, SP, #4
ADDS	R1, R0, #7
MOVS	R0, #61
STRB	R0, [R1, #0]
;driverrf4463pro.c,329 :: 		}
IT	AL
BAL	L_vRF4463Init80
L_vRF4463Init79:
;driverrf4463pro.c,331 :: 		app_command_buf[ 7 ]  = 0x5d;
ADD	R0, SP, #4
ADDS	R1, R0, #7
MOVS	R0, #93
STRB	R0, [R1, #0]
;driverrf4463pro.c,332 :: 		}
L_vRF4463Init80:
;driverrf4463pro.c,333 :: 		spi_write( 8, app_command_buf );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #8
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,337 :: 		spi_write( 0x0B , RF_SYNTH_PFDCP_CPFF_7_data );      // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
MOVT	R0, #hi_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
PUSH	(R0)
MOVS	R0, #11
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,340 :: 		if ( ucRF4463MatchEnabled ) {
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463Init81
;driverrf4463pro.c,341 :: 		app_command_buf[ 0 ]  = 0x11;               // SetProperty
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,342 :: 		app_command_buf[ 1 ]  = 0x30;               // 0x30 group
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #48
STRB	R0, [R1, #0]
;driverrf4463pro.c,343 :: 		app_command_buf[ 2 ]  = 0x0c;               // Total 12 Parameters
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #12
STRB	R0, [R1, #0]
;driverrf4463pro.c,344 :: 		app_command_buf[ 3 ]  = 0x00;               // 0x00 Index
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,345 :: 		app_command_buf[ 4 ]  = ucRF4463ByteMatch1; // match 1 Value of
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVW	R0, #lo_addr(_ucRF4463ByteMatch1+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch1+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,346 :: 		app_command_buf[ 5 ]  = ucRF4463ByteMask1;  // match 1 mask
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVW	R0, #lo_addr(_ucRF4463ByteMask1+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask1+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,347 :: 		app_command_buf[ 6 ]  = ucRF4463MatchEnableReg; //  0x40; // enable match 1, match 1 The distance between the value of and the synchronization word, 0 = match
ADD	R0, SP, #4
ADDS	R1, R0, #6
MOVW	R0, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnableReg+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,348 :: 		app_command_buf[ 7 ]  = ucRF4463ByteMatch2; // match 2 Value of
ADD	R0, SP, #4
ADDS	R1, R0, #7
MOVW	R0, #lo_addr(_ucRF4463ByteMatch2+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch2+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,349 :: 		app_command_buf[ 8 ]  = ucRF4463ByteMask2;  // match 2 mask
ADD	R0, SP, #4
ADDW	R1, R0, #8
MOVW	R0, #lo_addr(_ucRF4463ByteMask2+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask2+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,350 :: 		app_command_buf[ 9 ]  = 0x01;               // enable match 2, match 2 The distance between the value of and the synchronization word  , and function
ADD	R0, SP, #4
ADDW	R1, R0, #9
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,351 :: 		app_command_buf[ 10 ] = ucRF4463ByteMatch3; // match 3 Value of
ADD	R0, SP, #4
ADDW	R1, R0, #10
MOVW	R0, #lo_addr(_ucRF4463ByteMatch3+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch3+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,352 :: 		app_command_buf[ 11 ] = ucRF4463ByteMask3;  // match 3 mask
ADD	R0, SP, #4
ADDW	R1, R0, #11
MOVW	R0, #lo_addr(_ucRF4463ByteMask3+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask3+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,353 :: 		app_command_buf[ 12 ] = 0x02;;              // enable match 3, match 3 The distance between the value of and the synchronization word    and function
ADD	R0, SP, #4
ADDW	R1, R0, #12
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,354 :: 		app_command_buf[ 13 ] = ucRF4463ByteMatch4; // match 4 Value of
ADD	R0, SP, #4
ADDW	R1, R0, #13
MOVW	R0, #lo_addr(_ucRF4463ByteMatch4+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch4+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,355 :: 		app_command_buf[ 14 ] = ucRF4463ByteMask4;  // match 4 mask
ADD	R0, SP, #4
ADDW	R1, R0, #14
MOVW	R0, #lo_addr(_ucRF4463ByteMask4+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask4+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,356 :: 		app_command_buf[ 15 ] = 0x03;               // enable match 4, match 4 The distance between the value of and the synchronization word    and function
ADD	R0, SP, #4
ADDW	R1, R0, #15
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,357 :: 		spi_write( 16, app_command_buf );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #16
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,359 :: 		if ( ucRF4463MatchEnableReg == 0x00 ) {
MOVW	R0, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnableReg+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_vRF4463Init82
;driverrf4463pro.c,360 :: 		ucRF4463MatchEnabled = 0;                // deshabilita el Match
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R1, [R0, #0]
;driverrf4463pro.c,361 :: 		}
L_vRF4463Init82:
;driverrf4463pro.c,380 :: 		}
L_vRF4463Init81:
;driverrf4463pro.c,383 :: 		rf_init_freq();     // FUNCION DE FRECUENCIA ( REVISAR PARAMETROS )
BL	_rf_init_freq+0
;driverrf4463pro.c,384 :: 		}
L_end_vRF4463Init:
LDR	LR, [SP, #0]
ADD	SP, SP, #28
BX	LR
; end of _vRF4463Init
_ucRF4463ChecksumGenerator:
;driverrf4463pro.c,388 :: 		char ucRF4463ChecksumGenerator ( unsigned char *ucBuffer, unsigned char ucBufferLenght ) {
SUB	SP, SP, #8
;driverrf4463pro.c,389 :: 		unsigned short ucCounter = 0;
MOVS	R0, #0
STRB	R0, [SP, #4]
MOVS	R0, #0
STRB	R0, [SP, #5]
;driverrf4463pro.c,390 :: 		unsigned char ucChecksum = 0;
;driverrf4463pro.c,392 :: 		for ( ucCounter = 0; ucCounter < ucBufferLenght ; ucCounter++ ) {
MOVS	R0, #0
STRB	R0, [SP, #4]
L_ucRF4463ChecksumGenerator83:
LDRB	R1, [SP, #12]
LDRB	R0, [SP, #4]
CMP	R0, R1
IT	CS
BCS	L_ucRF4463ChecksumGenerator84
;driverrf4463pro.c,393 :: 		ucChecksum += ucBuffer[ ucCounter ];
LDRB	R1, [SP, #4]
LDR	R0, [SP, #8]
ADDS	R0, R0, R1
LDRB	R1, [R0, #0]
LDRB	R0, [SP, #5]
ADDS	R0, R0, R1
STRB	R0, [SP, #5]
;driverrf4463pro.c,392 :: 		for ( ucCounter = 0; ucCounter < ucBufferLenght ; ucCounter++ ) {
LDRB	R0, [SP, #4]
ADDS	R0, R0, #1
STRB	R0, [SP, #4]
;driverrf4463pro.c,394 :: 		}
IT	AL
BAL	L_ucRF4463ChecksumGenerator83
L_ucRF4463ChecksumGenerator84:
;driverrf4463pro.c,396 :: 		return ucChecksum;
LDRB	R0, [SP, #5]
;driverrf4463pro.c,397 :: 		}
L_end_ucRF4463ChecksumGenerator:
ADD	SP, SP, #8
BX	LR
; end of _ucRF4463ChecksumGenerator
_vRF4463GPIO_SET:
;driverrf4463pro.c,401 :: 		void vRF4463GPIO_SET( unsigned char ucData ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,404 :: 		ucAppCommandBuf[0] = 0x13;     // gpio Set up
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #19
STRB	R0, [R1, #0]
;driverrf4463pro.c,406 :: 		switch ( ucData ) {
IT	AL
BAL	L_vRF4463GPIO_SET86
;driverrf4463pro.c,407 :: 		case tx_normal:
L_vRF4463GPIO_SET88:
;driverrf4463pro.c,408 :: 		case rx_normal: ucAppCommandBuf[ 1 ] = 3;                 // GPIO0=1
L_vRF4463GPIO_SET89:
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,409 :: 		ucAppCommandBuf[ 2 ] = 2;                // GPIO1=0
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,410 :: 		break;
IT	AL
BAL	L_vRF4463GPIO_SET87
;driverrf4463pro.c,412 :: 		case tx_test:   ucAppCommandBuf[ 1 ] = 3;                 // GPIO0=1
L_vRF4463GPIO_SET90:
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,413 :: 		ucAppCommandBuf[ 2 ] = 3;                // GPIO1=1
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,414 :: 		break;
IT	AL
BAL	L_vRF4463GPIO_SET87
;driverrf4463pro.c,416 :: 		case rx_test:   ucAppCommandBuf[ 1 ] = 2;                 // GPIO0=0
L_vRF4463GPIO_SET91:
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,417 :: 		ucAppCommandBuf[ 2 ] = 20;                // GPIO1=RX DATA
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #20
STRB	R0, [R1, #0]
;driverrf4463pro.c,418 :: 		break;
IT	AL
BAL	L_vRF4463GPIO_SET87
;driverrf4463pro.c,420 :: 		case rf_off:    ucAppCommandBuf[ 1 ] = 2;                 // GPIO0=0
L_vRF4463GPIO_SET92:
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,421 :: 		ucAppCommandBuf[ 2 ] = 2;                // GPIO1=0
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,422 :: 		break;
IT	AL
BAL	L_vRF4463GPIO_SET87
;driverrf4463pro.c,423 :: 		}
L_vRF4463GPIO_SET86:
LDRB	R0, [SP, #12]
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463GPIO_SET88
LDRB	R0, [SP, #12]
CMP	R0, #1
IT	EQ
BEQ	L_vRF4463GPIO_SET89
LDRB	R0, [SP, #12]
CMP	R0, #2
IT	EQ
BEQ	L_vRF4463GPIO_SET90
LDRB	R0, [SP, #12]
CMP	R0, #3
IT	EQ
BEQ	L_vRF4463GPIO_SET91
LDRB	R0, [SP, #12]
CMP	R0, #4
IT	EQ
BEQ	L_vRF4463GPIO_SET92
L_vRF4463GPIO_SET87:
;driverrf4463pro.c,425 :: 		ucAppCommandBuf[ 3 ]  = 0x21;     //0x20;   //  gpio2, h = tx mode
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #33
STRB	R0, [R1, #0]
;driverrf4463pro.c,426 :: 		ucAppCommandBuf[ 4 ]  = 0x20;     // 0x14;  //   gpio3
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,427 :: 		ucAppCommandBuf[ 5 ]  = 0x27;     // nIRQ
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #39
STRB	R0, [R1, #0]
;driverrf4463pro.c,428 :: 		ucAppCommandBuf[ 6 ]  = 0x0b;     // sdo
ADD	R0, SP, #4
ADDS	R1, R0, #6
MOVS	R0, #11
STRB	R0, [R1, #0]
;driverrf4463pro.c,429 :: 		spi_write( 7, ucAppCommandBuf );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #7
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,430 :: 		}
L_end_vRF4463GPIO_SET:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRF4463GPIO_SET
_vRF4463FifoReset:
;driverrf4463pro.c,435 :: 		void vRF4463FifoReset( void ) {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;driverrf4463pro.c,438 :: 		p[ 0 ] = FIFO_INFO;
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #21
STRB	R0, [R1, #0]
;driverrf4463pro.c,439 :: 		p[ 1 ] = 0x03;   // reset tx ,rx fifo
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,440 :: 		spi_write( 2, p );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #2
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,441 :: 		}
L_end_vRF4463FifoReset:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vRF4463FifoReset
_vRF4463ClearInterrupts:
;driverrf4463pro.c,447 :: 		void vRF4463ClearInterrupts( void ) {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;driverrf4463pro.c,450 :: 		p[ 0 ] = GET_INT_STATUS;
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,451 :: 		p[ 1 ] = 0;               // clr  PH pending
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,452 :: 		p[ 2 ] = 0;               // clr modem_pending
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,453 :: 		p[ 3 ] = 0;               // clr chip pending
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,454 :: 		spi_write( 4, p );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #4
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,455 :: 		spi_read( 9, GET_INT_STATUS );
MOVS	R0, #32
PUSH	(R0)
MOVS	R0, #9
PUSH	(R0)
BL	_spi_read+0
ADD	SP, SP, #8
;driverrf4463pro.c,456 :: 		}
L_end_vRF4463ClearInterrupts:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vRF4463ClearInterrupts
_vRF4463PartInfo:
;driverrf4463pro.c,458 :: 		void vRF4463PartInfo( void ) {  // Solicitud totalmente operativa
SUB	SP, SP, #16
STR	LR, [SP, #0]
;driverrf4463pro.c,461 :: 		p[ 0 ] = PART_INFO;
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,465 :: 		spi_write( 1, p );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #1
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,466 :: 		spi_read( 9, PART_INFO );
MOVS	R0, #1
PUSH	(R0)
MOVS	R0, #9
PUSH	(R0)
BL	_spi_read+0
ADD	SP, SP, #8
;driverrf4463pro.c,467 :: 		}
L_end_vRF4463PartInfo:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _vRF4463PartInfo
_vRF4463EnableRxInterrupt:
;driverrf4463pro.c,472 :: 		void vRF4463EnableRxInterrupt( void ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,475 :: 		p[ 0 ] = 0x11;
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,476 :: 		p[ 1 ] = 0x01;            // 0x0100
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,477 :: 		p[ 2 ] = 0x03;            // 3Parameters
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,478 :: 		p[ 3 ] = 0x00;            // 0100
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,479 :: 		p[ 4 ] = 0x03;            // ph, modem int       0x03;
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,480 :: 		p[ 5 ] = 0x18;            // 0x10;   // Pack received int
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #24
STRB	R0, [R1, #0]
;driverrf4463pro.c,481 :: 		p[ 6 ] = 0x00;            //preamble int, sync int setting
ADD	R0, SP, #4
ADDS	R1, R0, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,482 :: 		spi_write( 0x07, p );     // enable  packet receive interrupt
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #7
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,483 :: 		}
L_end_vRF4463EnableRxInterrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRF4463EnableRxInterrupt
_vRF4463EnableTxInterrupt:
;driverrf4463pro.c,488 :: 		void vRF4463EnableTxInterrupt( void ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,491 :: 		p[ 0 ] = 0x11;
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,492 :: 		p[ 1 ] = 0x01;            // 0x0100
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,493 :: 		p[ 2 ] = 0x02;            // 2Parameters
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,494 :: 		p[ 3 ] = 0x00;            // 0x0100
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,495 :: 		p[ 4 ] = 0x01;            // Ph  int
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,496 :: 		p[ 5 ] = 0x20;            //  enable  packet sent interrupt
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,497 :: 		spi_write( 0x06, p );     // enable  packet receive interrupt
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #6
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,498 :: 		}
L_end_vRF4463EnableTxInterrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRF4463EnableTxInterrupt
_vRF4463RfStandby:
;driverrf4463pro.c,503 :: 		void vRF4463RfStandby( void ) {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;driverrf4463pro.c,506 :: 		p[ 0 ] = CHANGE_STATE ;   // CHANGE_STATE Command
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #52
STRB	R0, [R1, #0]
;driverrf4463pro.c,507 :: 		p[ 1 ] = 0x01 ;           // sleep mode
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,508 :: 		spi_write( 2, p );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #2
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,509 :: 		}
L_end_vRF4463RfStandby:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vRF4463RfStandby
_vRF4463TxStart:
;driverrf4463pro.c,514 :: 		void vRF4463TxStart( void ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,517 :: 		p[ 0 ] = START_TX ;              // start Command
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #49
STRB	R0, [R1, #0]
;driverrf4463pro.c,518 :: 		p[ 1 ] = ucRF4463FreqChannel;    // channel 1 default
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,519 :: 		p[ 2 ] = 0x30;                   // Back after launch Readymode, Do not retransmit, launch immediately
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #48
STRB	R0, [R1, #0]
;driverrf4463pro.c,520 :: 		p[ 3 ] = 0;
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,521 :: 		p[ 4 ] = 0;                      // payload_length; // Total to transmit 10 bytes
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,522 :: 		spi_write( 5, p );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,523 :: 		}
L_end_vRF4463TxStart:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRF4463TxStart
_vRF4463RxStart:
;driverrf4463pro.c,528 :: 		void vRF4463RxStart( void ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,531 :: 		p[ 0 ] = START_RX ;              // start Command
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #50
STRB	R0, [R1, #0]
;driverrf4463pro.c,532 :: 		p[ 1 ] = ucRF4463FreqChannel;    // channel 0
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,533 :: 		p[ 2 ] = 0x00;                   // Enter receiving mode immediately
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,534 :: 		p[ 3 ] = 0;
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,535 :: 		p[ 4 ] = 0;                      // payload_length; // Total to receive 10 bytes
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,536 :: 		p[ 5 ] = 0;                      // unchanged after preamble timeout
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,539 :: 		p[ 6 ] = 0x08;
ADD	R0, SP, #4
ADDS	R1, R0, #6
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,540 :: 		p[ 7 ] = 0x08;
ADD	R0, SP, #4
ADDS	R1, R0, #7
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,541 :: 		spi_write( 8, p );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #8
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,542 :: 		}
L_end_vRF4463RxStart:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRF4463RxStart
_vRF4463RxStartTest:
;driverrf4463pro.c,547 :: 		void vRF4463RxStartTest( void ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,550 :: 		LED_GREEN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;driverrf4463pro.c,552 :: 		p[ 0 ] = START_RX;        // start Command
ADD	R0, SP, #4
ADDS	R1, R0, #0
MOVS	R0, #50
STRB	R0, [R1, #0]
;driverrf4463pro.c,553 :: 		p[ 1 ] = ucRF4463FreqChannel;    // channel 0
ADD	R0, SP, #4
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,554 :: 		p[ 2 ] = 0x00;            // Enter receiving mode immediately
ADD	R0, SP, #4
ADDS	R1, R0, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,555 :: 		p[ 3 ] = 0;
ADD	R0, SP, #4
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,557 :: 		p[ 4 ] = 0;
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,558 :: 		p[ 5 ] = 0;               // unchanged after preamble timeout
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,561 :: 		p[ 6 ] = 0x08;
ADD	R0, SP, #4
ADDS	R1, R0, #6
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,562 :: 		p[ 7 ] = 0x08;
ADD	R0, SP, #4
ADDS	R1, R0, #7
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,563 :: 		spi_write( 8, p );
ADD	R0, SP, #4
PUSH	(R0)
MOVS	R0, #8
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,564 :: 		}
L_end_vRF4463RxStartTest:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRF4463RxStartTest
_vRF4463RxInit:
;driverrf4463pro.c,569 :: 		void vRF4463RxInit( void ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;driverrf4463pro.c,570 :: 		Flag.is_tx = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;driverrf4463pro.c,571 :: 		vRF4463FifoReset();           // fifo_reset();  // Buffer empty
BL	_vRF4463FifoReset+0
;driverrf4463pro.c,572 :: 		vRF4463EnableRxInterrupt();   // enable_rx_interrupt();
BL	_vRF4463EnableRxInterrupt+0
;driverrf4463pro.c,573 :: 		vRF4463ClearInterrupts();      // clr_interrupt();  // Clear interrupt factor
BL	_vRF4463ClearInterrupts+0
;driverrf4463pro.c,575 :: 		if ( ucRF4463Mode == rx_test_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BNE	L_vRF4463RxInit93
;driverrf4463pro.c,576 :: 		vRF4463RxStartTest();      // rx_start_test();
BL	_vRF4463RxStartTest+0
;driverrf4463pro.c,577 :: 		}
IT	AL
BAL	L_vRF4463RxInit94
L_vRF4463RxInit93:
;driverrf4463pro.c,579 :: 		vRF4463RxStart();        // rx_start();    // Enter receiving mode, after receiving data, return to Readymode
BL	_vRF4463RxStart+0
;driverrf4463pro.c,580 :: 		}
L_vRF4463RxInit94:
;driverrf4463pro.c,581 :: 		}
L_end_vRF4463RxInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vRF4463RxInit
_vRF4463TxData:
;driverrf4463pro.c,586 :: 		void vRF4463TxData( void ) {
SUB	SP, SP, #24
STR	LR, [SP, #0]
;driverrf4463pro.c,589 :: 		ucRF4463IRQ = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
STRB	R1, [R0, #0]
;driverrf4463pro.c,591 :: 		Flag.is_tx = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;driverrf4463pro.c,592 :: 		LED_RED ^= 1;
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_LX	[R0, ByteOffset(GPIOC_ODRbits+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;driverrf4463pro.c,593 :: 		Delay_ms( 30 );
MOVW	R7, #41598
MOVT	R7, #25
NOP
NOP
L_vRF4463TxData95:
SUBS	R7, R7, #1
BNE	L_vRF4463TxData95
NOP
NOP
NOP
;driverrf4463pro.c,594 :: 		LED_RED ^= 1;
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_LX	[R0, ByteOffset(GPIOC_ODRbits+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;driverrf4463pro.c,595 :: 		vRF4463FifoReset();            // fifo_reset();  // Buffer empty
BL	_vRF4463FifoReset+0
;driverrf4463pro.c,596 :: 		spi_write_fifo();              // Fill the buffer with data
BL	_spi_write_fifo+0
;driverrf4463pro.c,597 :: 		vRF4463EnableTxInterrupt();    // enable_tx_interrupt();
BL	_vRF4463EnableTxInterrupt+0
;driverrf4463pro.c,598 :: 		vRF4463ClearInterrupts();       // clr_interrupt();  // Clear interrupt factor
BL	_vRF4463ClearInterrupts+0
;driverrf4463pro.c,599 :: 		vRF4463TxStart();              // tx_start();    // Enter launch mode, start launch
BL	_vRF4463TxStart+0
;driverrf4463pro.c,600 :: 		rf_timeout = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_rf_timeout+0)
MOVT	R0, #hi_addr(_rf_timeout+0)
STRH	R1, [R0, #0]
;driverrf4463pro.c,602 :: 		Flag.rf_reach_timeout = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;driverrf4463pro.c,604 :: 		if ( ucRF4463IRQ ) {
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463TxData97
;driverrf4463pro.c,605 :: 		UART1_Write_Text( "[ UART1 ] TX INT\r\n" );
ADD	R11, SP, #4
ADD	R10, R11, #19
MOVW	R12, #lo_addr(?ICS?lstr1_DriverRF4463PROMain+0)
MOVT	R12, #hi_addr(?ICS?lstr1_DriverRF4463PROMain+0)
BL	___CC2DW+0
ADD	R0, SP, #4
MOV	R4, R0
MOV	R0, R4
BL	_UART1_Write_Text+0
;driverrf4463pro.c,606 :: 		}
L_vRF4463TxData97:
;driverrf4463pro.c,609 :: 		while ( nIRQ ) {     //nIRQ
L_vRF4463TxData98:
MOVW	R0, #lo_addr(GPIOD_IDRbits+0)
MOVT	R0, #hi_addr(GPIOD_IDRbits+0)
_LX	[R0, ByteOffset(GPIOD_IDRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463TxData99
;driverrf4463pro.c,612 :: 		if ( Flag.rf_reach_timeout ) {
MOVW	R1, #lo_addr(_Flag+0)
MOVT	R1, #hi_addr(_Flag+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463TxData100
;driverrf4463pro.c,613 :: 		VRF4463SDNReset();
BL	_VRF4463SDNReset+0
;driverrf4463pro.c,614 :: 		vRF4463Init();        //SI4463_init();  // RF Module initialization
BL	_vRF4463Init+0
;driverrf4463pro.c,615 :: 		break;                // Forced out
IT	AL
BAL	L_vRF4463TxData99
;driverrf4463pro.c,616 :: 		}
L_vRF4463TxData100:
;driverrf4463pro.c,617 :: 		}
IT	AL
BAL	L_vRF4463TxData98
L_vRF4463TxData99:
;driverrf4463pro.c,619 :: 		tx_cnt++;
MOVW	R0, #lo_addr(_tx_cnt+0)
MOVT	R0, #hi_addr(_tx_cnt+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(_tx_cnt+0)
MOVT	R0, #hi_addr(_tx_cnt+0)
STR	R1, [R0, #0]
;driverrf4463pro.c,621 :: 		vRF4463RxInit();          // rx_init();                //rf After the transmission is completed, enter the receiving mode
BL	_vRF4463RxInit+0
;driverrf4463pro.c,622 :: 		}
L_end_vRF4463TxData:
LDR	LR, [SP, #0]
ADD	SP, SP, #24
BX	LR
; end of _vRF4463TxData
_vRF4463TxCont:
;driverrf4463pro.c,627 :: 		void vRF4463TxCont( void ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;driverrf4463pro.c,630 :: 		LED_RED = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;driverrf4463pro.c,631 :: 		vRF4463FifoReset();                     //  fifo_reset();  // Buffer empty
BL	_vRF4463FifoReset+0
;driverrf4463pro.c,632 :: 		spi_write_fifo();                       // Fill the buffer with data
BL	_spi_write_fifo+0
;driverrf4463pro.c,633 :: 		vRF4463EnableTxInterrupt();             //  enable_tx_interrupt();
BL	_vRF4463EnableTxInterrupt+0
;driverrf4463pro.c,634 :: 		vRF4463ClearInterrupts();               //  clr_interrupt();  // Clear interrupt factor
BL	_vRF4463ClearInterrupts+0
;driverrf4463pro.c,635 :: 		vRF4463TxStart();                       //  tx_start();    // Enter launch mode, start launch
BL	_vRF4463TxStart+0
;driverrf4463pro.c,636 :: 		rf_timeout = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_rf_timeout+0)
MOVT	R0, #hi_addr(_rf_timeout+0)
STRH	R1, [R0, #0]
;driverrf4463pro.c,637 :: 		Flag.rf_reach_timeout = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;driverrf4463pro.c,639 :: 		ucRF4463IRQ = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
STRB	R1, [R0, #0]
;driverrf4463pro.c,642 :: 		while( nIRQ ) {          //nIRQ ) {
L_vRF4463TxCont101:
MOVW	R0, #lo_addr(GPIOD_IDRbits+0)
MOVT	R0, #hi_addr(GPIOD_IDRbits+0)
_LX	[R0, ByteOffset(GPIOD_IDRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463TxCont102
;driverrf4463pro.c,650 :: 		}
IT	AL
BAL	L_vRF4463TxCont101
L_vRF4463TxCont102:
;driverrf4463pro.c,651 :: 		}
L_end_vRF4463TxCont:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vRF4463TxCont
_rf_init_freq:
;driverrf4463pro.c,656 :: 		void rf_init_freq ( void ) {
SUB	SP, SP, #44
STR	LR, [SP, #0]
;driverrf4463pro.c,662 :: 		ulFrequency = ( ucRF4463Freq3 * 100 ) + ( ucRF4463Freq2 * 10 ) + ucRF4463Freq1;
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
;driverrf4463pro.c,664 :: 		ulFrequency = ( ulFrequency * 10000 );
LDR	R1, [SP, #20]
MOVW	R0, #10000
MULS	R0, R1, R0
STR	R0, [SP, #20]
;driverrf4463pro.c,667 :: 		if ( ulFrequency >= 7600000 ) {
LDR	R1, [SP, #20]
MOVW	R0, #63360
MOVT	R0, #115
CMP	R1, R0
IT	CC
BCC	L_rf_init_freq103
;driverrf4463pro.c,668 :: 		ucOUTDIV = 4;
MOVS	R0, #4
STRB	R0, [SP, #4]
;driverrf4463pro.c,669 :: 		ucBAND = 0;
MOVS	R0, #0
STRB	R0, [SP, #8]
;driverrf4463pro.c,670 :: 		ucVCO = 0xFF;
MOVS	R0, #255
STRB	R0, [SP, #6]
;driverrf4463pro.c,671 :: 		}
IT	AL
BAL	L_rf_init_freq104
L_rf_init_freq103:
;driverrf4463pro.c,674 :: 		else if ( ulFrequency >= 5460000 ) {
LDR	R1, [SP, #20]
MOVW	R0, #20512
MOVT	R0, #83
CMP	R1, R0
IT	CC
BCC	L_rf_init_freq105
;driverrf4463pro.c,675 :: 		ucOUTDIV = 6;
MOVS	R0, #6
STRB	R0, [SP, #4]
;driverrf4463pro.c,676 :: 		ucBAND   = 1;
MOVS	R0, #1
STRB	R0, [SP, #8]
;driverrf4463pro.c,677 :: 		ucVCO    = 0xFE;
MOVS	R0, #254
STRB	R0, [SP, #6]
;driverrf4463pro.c,678 :: 		}
IT	AL
BAL	L_rf_init_freq106
L_rf_init_freq105:
;driverrf4463pro.c,681 :: 		else if ( ulFrequency >= 3850000 ) {
LDR	R1, [SP, #20]
MOVW	R0, #48912
MOVT	R0, #58
CMP	R1, R0
IT	CC
BCC	L_rf_init_freq107
;driverrf4463pro.c,682 :: 		ucOUTDIV = 8;
MOVS	R0, #8
STRB	R0, [SP, #4]
;driverrf4463pro.c,683 :: 		ucBAND   = 2;
MOVS	R0, #2
STRB	R0, [SP, #8]
;driverrf4463pro.c,684 :: 		ucVCO    = 0xFE;
MOVS	R0, #254
STRB	R0, [SP, #6]
;driverrf4463pro.c,685 :: 		}
IT	AL
BAL	L_rf_init_freq108
L_rf_init_freq107:
;driverrf4463pro.c,688 :: 		else if ( ulFrequency >= 2730000 ) {
LDR	R1, [SP, #20]
MOVW	R0, #43024
MOVT	R0, #41
CMP	R1, R0
IT	CC
BCC	L_rf_init_freq109
;driverrf4463pro.c,689 :: 		ucOUTDIV = 12;
MOVS	R0, #12
STRB	R0, [SP, #4]
;driverrf4463pro.c,690 :: 		ucBAND   = 3;
MOVS	R0, #3
STRB	R0, [SP, #8]
;driverrf4463pro.c,691 :: 		ucVCO    = 0xFD;
MOVS	R0, #253
STRB	R0, [SP, #6]
;driverrf4463pro.c,692 :: 		}
IT	AL
BAL	L_rf_init_freq110
L_rf_init_freq109:
;driverrf4463pro.c,695 :: 		else if ( ulFrequency >= 1940000 ) {
LDR	R1, [SP, #20]
MOVW	R0, #39456
MOVT	R0, #29
CMP	R1, R0
IT	CC
BCC	L_rf_init_freq111
;driverrf4463pro.c,696 :: 		ucOUTDIV = 16;
MOVS	R0, #16
STRB	R0, [SP, #4]
;driverrf4463pro.c,697 :: 		ucBAND   = 4;
MOVS	R0, #4
STRB	R0, [SP, #8]
;driverrf4463pro.c,698 :: 		ucVCO    = 0xFC;
MOVS	R0, #252
STRB	R0, [SP, #6]
;driverrf4463pro.c,699 :: 		}
IT	AL
BAL	L_rf_init_freq112
L_rf_init_freq111:
;driverrf4463pro.c,703 :: 		ucOUTDIV = 24;
MOVS	R0, #24
STRB	R0, [SP, #4]
;driverrf4463pro.c,704 :: 		ucBAND   = 5;
MOVS	R0, #5
STRB	R0, [SP, #8]
;driverrf4463pro.c,705 :: 		ucVCO    = 0xFA;
MOVS	R0, #250
STRB	R0, [SP, #6]
;driverrf4463pro.c,706 :: 		}
L_rf_init_freq112:
L_rf_init_freq110:
L_rf_init_freq108:
L_rf_init_freq106:
L_rf_init_freq104:
;driverrf4463pro.c,708 :: 		ucDIV = ucOUTDIV / 2;
LDRB	R1, [SP, #4]
MOVS	R0, #2
UDIV	R0, R1, R0
STRB	R0, [SP, #5]
;driverrf4463pro.c,710 :: 		ulData = ( ulFrequency * ucDIV ) / 3;          // ucDIV = 88.5 = 88   //// UCdiv = 2
LDRB	R1, [SP, #5]
LDR	R0, [SP, #20]
MULS	R1, R0, R1
MOVS	R0, #3
UDIV	R0, R1, R0
STR	R0, [SP, #16]
;driverrf4463pro.c,711 :: 		ucINTE = ( ulData / 100000) - 1;               // ulData = 6 000 000  //// ULdATA = 9 000 000
LDR	R1, [SP, #16]
MOVW	R0, #34464
MOVT	R0, #1
UDIV	R0, R1, R0
SUBS	R0, R0, #1
STRB	R0, [SP, #7]
;driverrf4463pro.c,712 :: 		ulFRAC = ( ulData - ( ucINTE + 1 ) * 100000 ) * 16384 / 3125;         // ulFRAC = 15 728 640
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
;driverrf4463pro.c,713 :: 		ulFRAC = ulFRAC + 0x80000;
LDR	R0, [SP, #12]
ADD	R0, R0, #524288
STR	R0, [SP, #12]
;driverrf4463pro.c,715 :: 		ucFRAC_0 = ulFRAC;
LDR	R0, [SP, #12]
STRB	R0, [SP, #11]
;driverrf4463pro.c,716 :: 		ulFRAC >>= 8;
LDR	R0, [SP, #12]
LSRS	R0, R0, #8
STR	R0, [SP, #12]
;driverrf4463pro.c,717 :: 		ucFRAC_1 = ulFRAC;
LDR	R0, [SP, #12]
STRB	R0, [SP, #10]
;driverrf4463pro.c,718 :: 		ulFRAC >>= 8;
LDR	R0, [SP, #12]
LSRS	R0, R0, #8
STR	R0, [SP, #12]
;driverrf4463pro.c,719 :: 		ucFRAC_2 = ulFRAC;
LDR	R0, [SP, #12]
STRB	R0, [SP, #9]
;driverrf4463pro.c,723 :: 		app_command_buf[ 0 ] = 0x11;           // SET property    MODEM_CLKGEN_BAND
ADD	R0, SP, #24
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,724 :: 		app_command_buf[ 1 ] = 0x20;           // Group  // 0x2051
ADD	R0, SP, #24
ADDS	R1, R0, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,725 :: 		app_command_buf[ 2 ] = 0x01;           // Num Arguments // Total 1 Parameters
ADD	R0, SP, #24
ADDS	R1, R0, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,726 :: 		app_command_buf[ 3 ] = 0x51;           // Number  // 0x2051
ADD	R0, SP, #24
ADDS	R1, R0, #3
MOVS	R0, #81
STRB	R0, [R1, #0]
;driverrf4463pro.c,727 :: 		app_command_buf[ 4 ] = 0x08 | ucBAND;  // Argumento  //  high performance mode , clk outpu = osc /4
ADD	R0, SP, #24
ADDS	R1, R0, #4
LDRB	R0, [SP, #8]
ORR	R0, R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,728 :: 		spi_write( 5, app_command_buf );
ADD	R0, SP, #24
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,730 :: 		app_command_buf[ 0 ]  = 0x11;
ADD	R0, SP, #24
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,731 :: 		app_command_buf[ 1 ]  = 0x40;    // 0x4000         FREQ_CONTROL_INTE
ADD	R0, SP, #24
ADDS	R1, R0, #1
MOVS	R0, #64
STRB	R0, [R1, #0]
;driverrf4463pro.c,732 :: 		app_command_buf[ 2 ]  = 0x08;    // Total 8 Parameters
ADD	R0, SP, #24
ADDS	R1, R0, #2
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,733 :: 		app_command_buf[ 3 ]  = 0x00;   // 0x4000
ADD	R0, SP, #24
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,734 :: 		app_command_buf[ 4 ]  = ucINTE;   //  default value
ADD	R0, SP, #24
ADDS	R1, R0, #4
LDRB	R0, [SP, #7]
STRB	R0, [R1, #0]
;driverrf4463pro.c,735 :: 		app_command_buf[ 5 ]  = ucFRAC_2;   //  defaul value
ADD	R0, SP, #24
ADDS	R1, R0, #5
LDRB	R0, [SP, #9]
STRB	R0, [R1, #0]
;driverrf4463pro.c,736 :: 		app_command_buf[ 6 ]  = ucFRAC_1;   //  default value
ADD	R0, SP, #24
ADDS	R1, R0, #6
LDRB	R0, [SP, #10]
STRB	R0, [R1, #0]
;driverrf4463pro.c,737 :: 		app_command_buf[ 7 ]  = ucFRAC_0;   // frac ,from WDS
ADD	R0, SP, #24
ADDS	R1, R0, #7
LDRB	R0, [SP, #11]
STRB	R0, [R1, #0]
;driverrf4463pro.c,740 :: 		if ( ulRF4463Step == 250 ) {
MOVW	R0, #lo_addr(_ulRF4463Step+0)
MOVT	R0, #hi_addr(_ulRF4463Step+0)
LDR	R0, [R0, #0]
CMP	R0, #250
IT	NE
BNE	L_rf_init_freq113
;driverrf4463pro.c,741 :: 		app_command_buf[ 8 ]  = step_250K_step1;   // channel step1  from wds  // al parecer aqu? esta el ancho del canal
ADD	R0, SP, #24
ADDW	R1, R0, #8
MOVS	R0, #34
STRB	R0, [R1, #0]
;driverrf4463pro.c,742 :: 		app_command_buf[ 9 ]  = step_250K_step0;   // channel step0  from wds
ADD	R0, SP, #24
ADDW	R1, R0, #9
MOVS	R0, #34
STRB	R0, [R1, #0]
;driverrf4463pro.c,743 :: 		}
IT	AL
BAL	L_rf_init_freq114
L_rf_init_freq113:
;driverrf4463pro.c,744 :: 		else if ( ulRF4463Step == 500 ) {
MOVW	R0, #lo_addr(_ulRF4463Step+0)
MOVT	R0, #hi_addr(_ulRF4463Step+0)
LDR	R0, [R0, #0]
CMP	R0, #500
IT	NE
BNE	L_rf_init_freq115
;driverrf4463pro.c,745 :: 		app_command_buf[ 8 ]  = step_500K_step1;   // channel step1  from wds  // al parecer aqu? esta el ancho del canal
ADD	R0, SP, #24
ADDW	R1, R0, #8
MOVS	R0, #68
STRB	R0, [R1, #0]
;driverrf4463pro.c,746 :: 		app_command_buf[ 9 ]  = step_500K_step0;   // channel step0  from wds
ADD	R0, SP, #24
ADDW	R1, R0, #9
MOVS	R0, #68
STRB	R0, [R1, #0]
;driverrf4463pro.c,747 :: 		}
L_rf_init_freq115:
L_rf_init_freq114:
;driverrf4463pro.c,749 :: 		app_command_buf[ 10 ] = 0x20;  //  from wds Without this Values
ADD	R0, SP, #24
ADDW	R1, R0, #10
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,750 :: 		app_command_buf[ 11 ] = ucVCO;    // from wds Without this Values
ADD	R0, SP, #24
ADDW	R1, R0, #11
LDRB	R0, [SP, #6]
STRB	R0, [R1, #0]
;driverrf4463pro.c,764 :: 		spi_write( 12, app_command_buf );
ADD	R0, SP, #24
PUSH	(R0)
MOVS	R0, #12
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,765 :: 		}
L_end_rf_init_freq:
LDR	LR, [SP, #0]
ADD	SP, SP, #44
BX	LR
; end of _rf_init_freq
_ucRf4463SPIByte:
;driverrf4463pro.c,785 :: 		unsigned char ucRf4463SPIByte( unsigned char ucData ) {
SUB	SP, SP, #4
;driverrf4463pro.c,812 :: 		ucSPI3ByteReceived = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucSPI3ByteReceived+0)
MOVT	R0, #hi_addr(_ucSPI3ByteReceived+0)
STRB	R1, [R0, #0]
;driverrf4463pro.c,814 :: 		SPI3_DR = ucData;
LDRB	R1, [SP, #4]
MOVW	R0, #lo_addr(SPI3_DR+0)
MOVT	R0, #hi_addr(SPI3_DR+0)
STR	R1, [R0, #0]
;driverrf4463pro.c,816 :: 		while ( !SPI3_SRbits.TXE );                // espera a que el buffer este vacio
L_ucRf4463SPIByte116:
MOVW	R0, #lo_addr(SPI3_SRbits+0)
MOVT	R0, #hi_addr(SPI3_SRbits+0)
_LX	[R0, ByteOffset(SPI3_SRbits+0)]
CMP	R0, #0
IT	NE
BNE	L_ucRf4463SPIByte117
IT	AL
BAL	L_ucRf4463SPIByte116
L_ucRf4463SPIByte117:
;driverrf4463pro.c,818 :: 		while ( SPI3_SRbits.BSY );                // espera a que el buffer este vacio
L_ucRf4463SPIByte118:
MOVW	R0, #lo_addr(SPI3_SRbits+0)
MOVT	R0, #hi_addr(SPI3_SRbits+0)
_LX	[R0, ByteOffset(SPI3_SRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_ucRf4463SPIByte119
IT	AL
BAL	L_ucRf4463SPIByte118
L_ucRf4463SPIByte119:
;driverrf4463pro.c,820 :: 		return ( ucSPI3ByteReceived );
MOVW	R0, #lo_addr(_ucSPI3ByteReceived+0)
MOVT	R0, #hi_addr(_ucSPI3ByteReceived+0)
LDRB	R0, [R0, #0]
;driverrf4463pro.c,832 :: 		}
L_end_ucRf4463SPIByte:
ADD	SP, SP, #4
BX	LR
; end of _ucRf4463SPIByte
_spi_write:
;driverrf4463pro.c,837 :: 		void spi_write( unsigned char tx_length, unsigned char *p ) {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;driverrf4463pro.c,840 :: 		i = 0;
MOVS	R0, #0
STRB	R0, [SP, #4]
;driverrf4463pro.c,841 :: 		while ( i != 0xFF ) {
L_spi_write120:
LDRB	R0, [SP, #4]
CMP	R0, #255
IT	EQ
BEQ	L_spi_write121
;driverrf4463pro.c,842 :: 		i = check_cts();
BL	_check_cts+0
STRB	R0, [SP, #4]
;driverrf4463pro.c,843 :: 		}
IT	AL
BAL	L_spi_write120
L_spi_write121:
;driverrf4463pro.c,845 :: 		nSEL = 0;                              // habilita escritura
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,847 :: 		for ( i = 0; i < tx_length; i++ ) {
MOVS	R0, #0
STRB	R0, [SP, #4]
L_spi_write122:
LDRB	R1, [SP, #8]
LDRB	R0, [SP, #4]
CMP	R0, R1
IT	CS
BCS	L_spi_write123
;driverrf4463pro.c,848 :: 		j = *( p + i );
LDRB	R1, [SP, #4]
LDR	R0, [SP, #12]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [SP, #5]
;driverrf4463pro.c,849 :: 		ucRf4463SPIByte( j );
LDRB	R0, [SP, #5]
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,847 :: 		for ( i = 0; i < tx_length; i++ ) {
LDRB	R0, [SP, #4]
ADDS	R0, R0, #1
STRB	R0, [SP, #4]
;driverrf4463pro.c,850 :: 		}
IT	AL
BAL	L_spi_write122
L_spi_write123:
;driverrf4463pro.c,852 :: 		nSEL = 1;                              // desabilita escritura
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,853 :: 		}
L_end_spi_write:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _spi_write
_check_cts:
;driverrf4463pro.c,858 :: 		unsigned char check_cts( void ) {           // This Command follows the Command and reads the response
SUB	SP, SP, #8
STR	LR, [SP, #0]
;driverrf4463pro.c,861 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,862 :: 		nSEL = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,863 :: 		ucRf4463SPIByte( 0x44 );
MOVS	R0, #68
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,864 :: 		i = ucRf4463SPIByte( 0 );
MOVS	R0, #0
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
STRB	R0, [SP, #4]
;driverrf4463pro.c,865 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,866 :: 		return ( i );
LDRB	R0, [SP, #4]
;driverrf4463pro.c,867 :: 		}
L_end_check_cts:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _check_cts
_spi_read:
;driverrf4463pro.c,872 :: 		void spi_read( unsigned char data_length, unsigned char api_command ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,876 :: 		p[ 0 ] = api_command;
ADD	R0, SP, #5
ADDS	R1, R0, #0
LDRB	R0, [SP, #16]
STRB	R0, [R1, #0]
;driverrf4463pro.c,877 :: 		i = 0;
MOVS	R0, #0
STRB	R0, [SP, #4]
;driverrf4463pro.c,878 :: 		while ( i != 0xFF ) {
L_spi_read125:
LDRB	R0, [SP, #4]
CMP	R0, #255
IT	EQ
BEQ	L_spi_read126
;driverrf4463pro.c,879 :: 		i = check_cts();                // Check if you can send Command
BL	_check_cts+0
STRB	R0, [SP, #4]
;driverrf4463pro.c,880 :: 		}
IT	AL
BAL	L_spi_read125
L_spi_read126:
;driverrf4463pro.c,882 :: 		spi_write( 1, p );    // Send Command
ADD	R0, SP, #5
PUSH	(R0)
MOVS	R0, #1
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,884 :: 		i = 0;
MOVS	R0, #0
STRB	R0, [SP, #4]
;driverrf4463pro.c,885 :: 		while ( i != 0xFF ) {
L_spi_read127:
LDRB	R0, [SP, #4]
CMP	R0, #255
IT	EQ
BEQ	L_spi_read128
;driverrf4463pro.c,886 :: 		i = check_cts();        //Check whether the data can be read
BL	_check_cts+0
STRB	R0, [SP, #4]
;driverrf4463pro.c,887 :: 		}
IT	AL
BAL	L_spi_read127
L_spi_read128:
;driverrf4463pro.c,889 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,890 :: 		nSEL = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,891 :: 		ucRf4463SPIByte( 0x44 );
MOVS	R0, #68
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,892 :: 		for ( i = 0; i < data_length; i++ ) {        // Read data
MOVS	R0, #0
STRB	R0, [SP, #4]
L_spi_read129:
LDRB	R1, [SP, #12]
LDRB	R0, [SP, #4]
CMP	R0, R1
IT	CS
BCS	L_spi_read130
;driverrf4463pro.c,893 :: 		spi_read_buf[ i ] = ucRf4463SPIByte( 0x00 );             // 0x00
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
;driverrf4463pro.c,892 :: 		for ( i = 0; i < data_length; i++ ) {        // Read data
LDRB	R0, [SP, #4]
ADDS	R0, R0, #1
STRB	R0, [SP, #4]
;driverrf4463pro.c,894 :: 		}
IT	AL
BAL	L_spi_read129
L_spi_read130:
;driverrf4463pro.c,895 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,896 :: 		}
L_end_spi_read:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _spi_read
_spi_fast_read:
;driverrf4463pro.c,901 :: 		void spi_fast_read( unsigned char api_command ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,904 :: 		p[0] = api_command;
ADD	R0, SP, #5
ADDS	R1, R0, #0
LDRB	R0, [SP, #12]
STRB	R0, [R1, #0]
;driverrf4463pro.c,905 :: 		i = 0;
MOVS	R0, #0
STRB	R0, [SP, #4]
;driverrf4463pro.c,906 :: 		while ( i != 0xFF ) {
L_spi_fast_read132:
LDRB	R0, [SP, #4]
CMP	R0, #255
IT	EQ
BEQ	L_spi_fast_read133
;driverrf4463pro.c,907 :: 		i = check_cts();                // Check if you can send Command
BL	_check_cts+0
STRB	R0, [SP, #4]
;driverrf4463pro.c,908 :: 		}
IT	AL
BAL	L_spi_fast_read132
L_spi_fast_read133:
;driverrf4463pro.c,910 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,911 :: 		nSEL = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,912 :: 		ucRf4463SPIByte( api_command );    // Send Command
LDRB	R0, [SP, #12]
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,913 :: 		for ( i = 0; i < 4; i++ ) {
MOVS	R0, #0
STRB	R0, [SP, #4]
L_spi_fast_read134:
LDRB	R0, [SP, #4]
CMP	R0, #4
IT	CS
BCS	L_spi_fast_read135
;driverrf4463pro.c,914 :: 		spi_read_buf[ i ] = ucRf4463SPIByte( 0xFF );   // Read out all the 4 registers Value of
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
;driverrf4463pro.c,913 :: 		for ( i = 0; i < 4; i++ ) {
LDRB	R0, [SP, #4]
ADDS	R0, R0, #1
STRB	R0, [SP, #4]
;driverrf4463pro.c,915 :: 		}
IT	AL
BAL	L_spi_fast_read134
L_spi_fast_read135:
;driverrf4463pro.c,916 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,917 :: 		}
L_end_spi_fast_read:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _spi_fast_read
_spi_write_fifo:
;driverrf4463pro.c,922 :: 		void spi_write_fifo( void ) {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;driverrf4463pro.c,925 :: 		i = 0;
MOVS	R0, #0
STRB	R0, [SP, #4]
;driverrf4463pro.c,926 :: 		while ( i != 0xFF ) {
L_spi_write_fifo137:
LDRB	R0, [SP, #4]
CMP	R0, #255
IT	EQ
BEQ	L_spi_write_fifo138
;driverrf4463pro.c,927 :: 		i = check_cts();                // Check if you can send Command
BL	_check_cts+0
STRB	R0, [SP, #4]
;driverrf4463pro.c,928 :: 		}
IT	AL
BAL	L_spi_write_fifo137
L_spi_write_fifo138:
;driverrf4463pro.c,930 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,931 :: 		nSEL = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,932 :: 		ucRf4463SPIByte( WRITE_TX_FIFO );
MOVS	R0, #102
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,934 :: 		if ( ucRF4463Mode == tx_test_mode) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_spi_write_fifo139
;driverrf4463pro.c,935 :: 		for ( i = 0; i < payload_length; i++ ) {
MOVS	R0, #0
STRB	R0, [SP, #4]
L_spi_write_fifo140:
LDRB	R0, [SP, #4]
CMP	R0, #66
IT	CS
BCS	L_spi_write_fifo141
;driverrf4463pro.c,936 :: 		ucRf4463SPIByte( tx_test_aa_data[ i ] );   // Send 10 test data
LDRB	R1, [SP, #4]
MOVW	R0, #lo_addr(_tx_test_aa_data+0)
MOVT	R0, #hi_addr(_tx_test_aa_data+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,935 :: 		for ( i = 0; i < payload_length; i++ ) {
LDRB	R0, [SP, #4]
ADDS	R0, R0, #1
STRB	R0, [SP, #4]
;driverrf4463pro.c,937 :: 		}
IT	AL
BAL	L_spi_write_fifo140
L_spi_write_fifo141:
;driverrf4463pro.c,938 :: 		}
IT	AL
BAL	L_spi_write_fifo143
L_spi_write_fifo139:
;driverrf4463pro.c,940 :: 		for ( i = 0; i < payload_length; i++ ) {
MOVS	R0, #0
STRB	R0, [SP, #4]
L_spi_write_fifo144:
LDRB	R0, [SP, #4]
CMP	R0, #66
IT	CS
BCS	L_spi_write_fifo145
;driverrf4463pro.c,941 :: 		ucRf4463SPIByte( ucRF4463TXdata[ i ] );
LDRB	R1, [SP, #4]
MOVW	R0, #lo_addr(_ucRF4463TXdata+0)
MOVT	R0, #hi_addr(_ucRF4463TXdata+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,940 :: 		for ( i = 0; i < payload_length; i++ ) {
LDRB	R0, [SP, #4]
ADDS	R0, R0, #1
STRB	R0, [SP, #4]
;driverrf4463pro.c,942 :: 		}
IT	AL
BAL	L_spi_write_fifo144
L_spi_write_fifo145:
;driverrf4463pro.c,943 :: 		}
L_spi_write_fifo143:
;driverrf4463pro.c,944 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,945 :: 		}
L_end_spi_write_fifo:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _spi_write_fifo
_spi_read_fifo:
;driverrf4463pro.c,950 :: 		void spi_read_fifo( void ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,953 :: 		i = 0;
MOVS	R0, #0
STRB	R0, [SP, #4]
;driverrf4463pro.c,954 :: 		while ( i != 0xFF ) {
L_spi_read_fifo147:
LDRB	R0, [SP, #4]
CMP	R0, #255
IT	EQ
BEQ	L_spi_read_fifo148
;driverrf4463pro.c,955 :: 		i = check_cts();                   // Check if you can send Command
BL	_check_cts+0
STRB	R0, [SP, #4]
;driverrf4463pro.c,956 :: 		}
IT	AL
BAL	L_spi_read_fifo147
L_spi_read_fifo148:
;driverrf4463pro.c,958 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,959 :: 		nSEL = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,960 :: 		ucRf4463SPIByte( READ_RX_FIFO );
MOVS	R0, #119
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,961 :: 		for ( i = 0; i < payload_length; i++ ) {
MOVS	R0, #0
STRB	R0, [SP, #4]
L_spi_read_fifo149:
LDRB	R0, [SP, #4]
CMP	R0, #66
IT	CS
BCS	L_spi_read_fifo150
;driverrf4463pro.c,962 :: 		rx_buf[ i ] = ucRf4463SPIByte( 0xFF );      // Receive 10 test data
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
;driverrf4463pro.c,961 :: 		for ( i = 0; i < payload_length; i++ ) {
LDRB	R0, [SP, #4]
ADDS	R0, R0, #1
STRB	R0, [SP, #4]
;driverrf4463pro.c,963 :: 		}
IT	AL
BAL	L_spi_read_fifo149
L_spi_read_fifo150:
;driverrf4463pro.c,964 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,965 :: 		}
L_end_spi_read_fifo:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _spi_read_fifo
_VRF4463SDNReset:
;driverrf4463pro.c,970 :: 		void VRF4463SDNReset( void ) {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;driverrf4463pro.c,973 :: 		SDN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;driverrf4463pro.c,974 :: 		Delay_ms( 6 );        // RF Module reset  DELAY
MOVW	R7, #8318
MOVT	R7, #5
NOP
NOP
L_VRF4463SDNReset152:
SUBS	R7, R7, #1
BNE	L_VRF4463SDNReset152
NOP
NOP
NOP
;driverrf4463pro.c,975 :: 		SDN = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;driverrf4463pro.c,976 :: 		Delay_ms( 10 );       // Delay 10ms for RF module to enter working state
MOVW	R7, #35710
MOVT	R7, #8
NOP
NOP
L_VRF4463SDNReset154:
SUBS	R7, R7, #1
BNE	L_VRF4463SDNReset154
NOP
NOP
NOP
;driverrf4463pro.c,978 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,979 :: 		nSEL = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,980 :: 		for ( i = 0; i < 7; i++ ) {
MOVS	R0, #0
STRB	R0, [SP, #4]
L_VRF4463SDNReset156:
LDRB	R0, [SP, #4]
CMP	R0, #7
IT	CS
BCS	L_VRF4463SDNReset157
;driverrf4463pro.c,981 :: 		ucRf4463SPIByte( RF_POWER_UP_data[ i ] );   // send power up Command
LDRB	R1, [SP, #4]
MOVW	R0, #lo_addr(_RF_POWER_UP_data+0)
MOVT	R0, #hi_addr(_RF_POWER_UP_data+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,980 :: 		for ( i = 0; i < 7; i++ ) {
LDRB	R0, [SP, #4]
ADDS	R0, R0, #1
STRB	R0, [SP, #4]
;driverrf4463pro.c,982 :: 		}
IT	AL
BAL	L_VRF4463SDNReset156
L_VRF4463SDNReset157:
;driverrf4463pro.c,983 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,985 :: 		Delay_ms( 20 );       // Delay 20ms RF module enters working state, but CTS still needs to be judged later, this delay can be removed
MOVW	R7, #5886
MOVT	R7, #17
NOP
NOP
L_VRF4463SDNReset159:
SUBS	R7, R7, #1
BNE	L_VRF4463SDNReset159
NOP
NOP
NOP
;driverrf4463pro.c,986 :: 		}
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
BLS	L_ucASCIIToByte161
;utils.c,47 :: 		ucMSBNibble -= 7;
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
LDRB	R0, [R0, #0]
SUBS	R1, R0, #7
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,48 :: 		}
L_ucASCIIToByte161:
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
BLS	L_ucASCIIToByte162
;utils.c,52 :: 		ucLSBNibble -= 7;
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
LDRB	R0, [R0, #0]
SUBS	R1, R0, #7
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,53 :: 		}
L_ucASCIIToByte162:
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
L_vASCIIToHex163:
LDRB	R1, [SP, #16]
LDRB	R0, [SP, #4]
CMP	R0, R1
IT	CS
BCS	L_vASCIIToHex164
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
BLS	L_vASCIIToHex166
;utils.c,70 :: 		ucMSBNibble -= 7;
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
LDRB	R0, [R0, #0]
SUBS	R1, R0, #7
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,71 :: 		}
L_vASCIIToHex166:
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
BLS	L_vASCIIToHex167
;utils.c,75 :: 		ucLSBNibble -= 7;
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
LDRB	R0, [R0, #0]
SUBS	R1, R0, #7
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,76 :: 		}
L_vASCIIToHex167:
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
BAL	L_vASCIIToHex163
L_vASCIIToHex164:
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
L_vHexToASCII168:
LDRB	R1, [SP, #16]
LDRB	R0, [SP, #4]
CMP	R0, R1
IT	CS
BCS	L_vHexToASCII169
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
BAL	L_vHexToASCII168
L_vHexToASCII169:
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
L_vBufferSetToZero171:
LDRH	R1, [SP, #12]
LDRH	R0, [SP, #4]
CMP	R0, R1
IT	CS
BCS	L_vBufferSetToZero172
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
BAL	L_vBufferSetToZero171
L_vBufferSetToZero172:
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
L_vBufferSetTo255174:
LDRH	R1, [SP, #12]
LDRH	R0, [SP, #4]
CMP	R0, R1
IT	CS
BCS	L_vBufferSetTo255175
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
BAL	L_vBufferSetTo255174
L_vBufferSetTo255175:
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
L_vBufferSetToValue177:
LDRH	R1, [SP, #16]
LDRH	R0, [SP, #4]
CMP	R0, R1
IT	CS
BCS	L_vBufferSetToValue178
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
BAL	L_vBufferSetToValue177
L_vBufferSetToValue178:
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
L_vSerializeUUID180:
LDRB	R0, [SP, #4]
CMP	R0, #12
IT	CS
BCS	L_vSerializeUUID181
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
BAL	L_vSerializeUUID180
L_vSerializeUUID181:
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
L_vSerializeMACAddress183:
LDRH	R0, [SP, #16]
CMP	R0, #6
IT	CS
BCS	L_vSerializeMACAddress184
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
BEQ	L_vSerializeMACAddress186
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
L_vSerializeMACAddress186:
;utils.c,148 :: 		for( usCounter = 0; usCounter < 6; usCounter++ ){
LDRH	R0, [SP, #16]
ADDS	R0, R0, #1
STRH	R0, [SP, #16]
;utils.c,154 :: 		}
IT	AL
BAL	L_vSerializeMACAddress183
L_vSerializeMACAddress184:
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
L_vSerializeIPAddress187:
LDRB	R0, [SP, #13]
CMP	R0, #4
IT	CS
BCS	L_vSerializeIPAddress188
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
BEQ	L_vSerializeIPAddress190
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
L_vSerializeIPAddress190:
;utils.c,167 :: 		for( ucCounter = 0; ucCounter < 4; ucCounter++ ){
LDRB	R0, [SP, #13]
ADDS	R0, R0, #1
STRB	R0, [SP, #13]
;utils.c,176 :: 		}
IT	AL
BAL	L_vSerializeIPAddress187
L_vSerializeIPAddress188:
;utils.c,177 :: 		}
L_end_vSerializeIPAddress:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _vSerializeIPAddress
_DMA2Strm1_interrupt:
;uarthandler.c,144 :: 		void DMA2Strm1_interrupt() iv IVT_INT_DMA2_Stream1 ics ICS_AUTO {
;uarthandler.c,146 :: 		if ( DMA2_LISRbits.FEIF1 ) {
MOVW	R0, #lo_addr(DMA2_LISRbits+0)
MOVT	R0, #hi_addr(DMA2_LISRbits+0)
_LX	[R0, ByteOffset(DMA2_LISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA2Strm1_interrupt191
;uarthandler.c,147 :: 		DMA2_LIFCRbits.CFEIF1 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_LIFCRbits+0)
MOVT	R0, #hi_addr(DMA2_LIFCRbits+0)
_SX	[R0, ByteOffset(DMA2_LIFCRbits+0)]
;uarthandler.c,148 :: 		}
IT	AL
BAL	L_DMA2Strm1_interrupt192
L_DMA2Strm1_interrupt191:
;uarthandler.c,149 :: 		else if ( DMA2_LISRbits.DMEIF1 ) {
MOVW	R0, #lo_addr(DMA2_LISRbits+0)
MOVT	R0, #hi_addr(DMA2_LISRbits+0)
_LX	[R0, ByteOffset(DMA2_LISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA2Strm1_interrupt193
;uarthandler.c,150 :: 		DMA2_LIFCRbits.CDMEIF1 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_LIFCRbits+0)
MOVT	R0, #hi_addr(DMA2_LIFCRbits+0)
_SX	[R0, ByteOffset(DMA2_LIFCRbits+0)]
;uarthandler.c,151 :: 		}
IT	AL
BAL	L_DMA2Strm1_interrupt194
L_DMA2Strm1_interrupt193:
;uarthandler.c,152 :: 		else if ( DMA2_LISRbits.TEIF1 ) {     // TRANSFER ERROR INTERRUPT FLAG
MOVW	R0, #lo_addr(DMA2_LISRbits+0)
MOVT	R0, #hi_addr(DMA2_LISRbits+0)
_LX	[R0, ByteOffset(DMA2_LISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA2Strm1_interrupt195
;uarthandler.c,153 :: 		DMA2_LIFCRbits.CTEIF1 = 1;       // limpia el flag de error
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_LIFCRbits+0)
MOVT	R0, #hi_addr(DMA2_LIFCRbits+0)
_SX	[R0, ByteOffset(DMA2_LIFCRbits+0)]
;uarthandler.c,155 :: 		}
IT	AL
BAL	L_DMA2Strm1_interrupt196
L_DMA2Strm1_interrupt195:
;uarthandler.c,156 :: 		else if ( DMA2_LISRbits.HTIF1 ) {
MOVW	R0, #lo_addr(DMA2_LISRbits+0)
MOVT	R0, #hi_addr(DMA2_LISRbits+0)
_LX	[R0, ByteOffset(DMA2_LISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA2Strm1_interrupt197
;uarthandler.c,157 :: 		DMA2_LIFCRbits.CHTIF1 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_LIFCRbits+0)
MOVT	R0, #hi_addr(DMA2_LIFCRbits+0)
_SX	[R0, ByteOffset(DMA2_LIFCRbits+0)]
;uarthandler.c,158 :: 		}
IT	AL
BAL	L_DMA2Strm1_interrupt198
L_DMA2Strm1_interrupt197:
;uarthandler.c,159 :: 		else if ( DMA2_LISRbits.TCIF1 ) {     // TRANSFER COMPLETE INTERRUPT FLAG = envio el frame completo
MOVW	R0, #lo_addr(DMA2_LISRbits+0)
MOVT	R0, #hi_addr(DMA2_LISRbits+0)
_LX	[R0, ByteOffset(DMA2_LISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA2Strm1_interrupt199
;uarthandler.c,160 :: 		DMA2_LIFCRbits.CTCIF1 = 1;       // limpia TODOS LOS FLAGS DE DMA2 CANAL 2
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_LIFCRbits+0)
MOVT	R0, #hi_addr(DMA2_LIFCRbits+0)
_SX	[R0, ByteOffset(DMA2_LIFCRbits+0)]
;uarthandler.c,161 :: 		DMA2_S1CRbits.EN = 0;            // EXPERIMENTAL PARA CAMBIAR EL VALOR DEL CONTADOR
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_S1CRbits+0)
MOVT	R0, #hi_addr(DMA2_S1CRbits+0)
_SX	[R0, ByteOffset(DMA2_S1CRbits+0)]
;uarthandler.c,163 :: 		}
L_DMA2Strm1_interrupt199:
L_DMA2Strm1_interrupt198:
L_DMA2Strm1_interrupt196:
L_DMA2Strm1_interrupt194:
L_DMA2Strm1_interrupt192:
;uarthandler.c,164 :: 		}
L_end_DMA2Strm1_interrupt:
BX	LR
; end of _DMA2Strm1_interrupt
_DMA2Strm4_interrupt:
;uarthandler.c,168 :: 		void DMA2Strm4_interrupt() iv IVT_INT_DMA2_Stream4 ics ICS_AUTO {
;uarthandler.c,170 :: 		if ( DMA2_HISRbits.FEIF4 ) {
MOVW	R0, #lo_addr(DMA2_HISRbits+0)
MOVT	R0, #hi_addr(DMA2_HISRbits+0)
_LX	[R0, ByteOffset(DMA2_HISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA2Strm4_interrupt200
;uarthandler.c,171 :: 		DMA2_HIFCRbits.CFEIF4 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_HIFCRbits+0)
MOVT	R0, #hi_addr(DMA2_HIFCRbits+0)
_SX	[R0, ByteOffset(DMA2_HIFCRbits+0)]
;uarthandler.c,172 :: 		}
IT	AL
BAL	L_DMA2Strm4_interrupt201
L_DMA2Strm4_interrupt200:
;uarthandler.c,173 :: 		else if ( DMA2_HISRbits.DMEIF4 ) {
MOVW	R0, #lo_addr(DMA2_HISRbits+0)
MOVT	R0, #hi_addr(DMA2_HISRbits+0)
_LX	[R0, ByteOffset(DMA2_HISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA2Strm4_interrupt202
;uarthandler.c,174 :: 		DMA2_HIFCRbits.CDMEIF4 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_HIFCRbits+0)
MOVT	R0, #hi_addr(DMA2_HIFCRbits+0)
_SX	[R0, ByteOffset(DMA2_HIFCRbits+0)]
;uarthandler.c,175 :: 		}
IT	AL
BAL	L_DMA2Strm4_interrupt203
L_DMA2Strm4_interrupt202:
;uarthandler.c,176 :: 		else if ( DMA2_HISRbits.TEIF4 ) {     // TRANSFER ERROR INTERRUPT FLAG
MOVW	R0, #lo_addr(DMA2_HISRbits+0)
MOVT	R0, #hi_addr(DMA2_HISRbits+0)
_LX	[R0, ByteOffset(DMA2_HISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA2Strm4_interrupt204
;uarthandler.c,177 :: 		DMA2_HIFCRbits.CTEIF4 = 1;       // limpia el flag de error
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_HIFCRbits+0)
MOVT	R0, #hi_addr(DMA2_HIFCRbits+0)
_SX	[R0, ByteOffset(DMA2_HIFCRbits+0)]
;uarthandler.c,179 :: 		}
IT	AL
BAL	L_DMA2Strm4_interrupt205
L_DMA2Strm4_interrupt204:
;uarthandler.c,180 :: 		else if ( DMA2_HISRbits.HTIF4 ) {
MOVW	R0, #lo_addr(DMA2_HISRbits+0)
MOVT	R0, #hi_addr(DMA2_HISRbits+0)
_LX	[R0, ByteOffset(DMA2_HISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA2Strm4_interrupt206
;uarthandler.c,181 :: 		DMA2_HIFCRbits.CHTIF4 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_HIFCRbits+0)
MOVT	R0, #hi_addr(DMA2_HIFCRbits+0)
_SX	[R0, ByteOffset(DMA2_HIFCRbits+0)]
;uarthandler.c,182 :: 		}
IT	AL
BAL	L_DMA2Strm4_interrupt207
L_DMA2Strm4_interrupt206:
;uarthandler.c,183 :: 		else if ( DMA2_HISRbits.TCIF4 ) {     // TRANSFER COMPLETE INTERRUPT FLAG = envio el frame completo
MOVW	R0, #lo_addr(DMA2_HISRbits+0)
MOVT	R0, #hi_addr(DMA2_HISRbits+0)
_LX	[R0, ByteOffset(DMA2_HISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA2Strm4_interrupt208
;uarthandler.c,184 :: 		DMA2_HIFCRbits.CTCIF4 = 1;       // limpia TODOS LOS FLAGS DE DMA2 CANAL 2
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_HIFCRbits+0)
MOVT	R0, #hi_addr(DMA2_HIFCRbits+0)
_SX	[R0, ByteOffset(DMA2_HIFCRbits+0)]
;uarthandler.c,185 :: 		DMA2_S4CRbits.EN = 0;            // EXPERIMENTAL PARA CAMBIAR EL VALOR DEL CONTADOR
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_S4CRbits+0)
MOVT	R0, #hi_addr(DMA2_S4CRbits+0)
_SX	[R0, ByteOffset(DMA2_S4CRbits+0)]
;uarthandler.c,187 :: 		}
L_DMA2Strm4_interrupt208:
L_DMA2Strm4_interrupt207:
L_DMA2Strm4_interrupt205:
L_DMA2Strm4_interrupt203:
L_DMA2Strm4_interrupt201:
;uarthandler.c,188 :: 		}
L_end_DMA2Strm4_interrupt:
BX	LR
; end of _DMA2Strm4_interrupt
_DMA2Strm7_interrupt:
;uarthandler.c,192 :: 		void DMA2Strm7_interrupt() iv IVT_INT_DMA2_Stream7 ics ICS_AUTO {
;uarthandler.c,194 :: 		if ( DMA2_HISRbits.FEIF7 ) {
MOVW	R0, #lo_addr(DMA2_HISRbits+0)
MOVT	R0, #hi_addr(DMA2_HISRbits+0)
_LX	[R0, ByteOffset(DMA2_HISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA2Strm7_interrupt209
;uarthandler.c,195 :: 		DMA2_HIFCRbits.CFEIF7 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_HIFCRbits+0)
MOVT	R0, #hi_addr(DMA2_HIFCRbits+0)
_SX	[R0, ByteOffset(DMA2_HIFCRbits+0)]
;uarthandler.c,196 :: 		}
IT	AL
BAL	L_DMA2Strm7_interrupt210
L_DMA2Strm7_interrupt209:
;uarthandler.c,197 :: 		else if ( DMA2_HISRbits.DMEIF7 ) {
MOVW	R0, #lo_addr(DMA2_HISRbits+0)
MOVT	R0, #hi_addr(DMA2_HISRbits+0)
_LX	[R0, ByteOffset(DMA2_HISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA2Strm7_interrupt211
;uarthandler.c,198 :: 		DMA2_HIFCRbits.CDMEIF7 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_HIFCRbits+0)
MOVT	R0, #hi_addr(DMA2_HIFCRbits+0)
_SX	[R0, ByteOffset(DMA2_HIFCRbits+0)]
;uarthandler.c,199 :: 		}
IT	AL
BAL	L_DMA2Strm7_interrupt212
L_DMA2Strm7_interrupt211:
;uarthandler.c,200 :: 		else if ( DMA2_HISRbits.TEIF7 ) {     // TRANSFER ERROR INTERRUPT FLAG
MOVW	R0, #lo_addr(DMA2_HISRbits+0)
MOVT	R0, #hi_addr(DMA2_HISRbits+0)
_LX	[R0, ByteOffset(DMA2_HISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA2Strm7_interrupt213
;uarthandler.c,201 :: 		DMA2_HIFCRbits.CTEIF7 = 1;       // limpia el flag de error
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_HIFCRbits+0)
MOVT	R0, #hi_addr(DMA2_HIFCRbits+0)
_SX	[R0, ByteOffset(DMA2_HIFCRbits+0)]
;uarthandler.c,203 :: 		}
IT	AL
BAL	L_DMA2Strm7_interrupt214
L_DMA2Strm7_interrupt213:
;uarthandler.c,204 :: 		else if ( DMA2_HISRbits.HTIF7 ) {
MOVW	R0, #lo_addr(DMA2_HISRbits+0)
MOVT	R0, #hi_addr(DMA2_HISRbits+0)
_LX	[R0, ByteOffset(DMA2_HISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA2Strm7_interrupt215
;uarthandler.c,205 :: 		DMA2_HIFCRbits.CHTIF7 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_HIFCRbits+0)
MOVT	R0, #hi_addr(DMA2_HIFCRbits+0)
_SX	[R0, ByteOffset(DMA2_HIFCRbits+0)]
;uarthandler.c,206 :: 		}
IT	AL
BAL	L_DMA2Strm7_interrupt216
L_DMA2Strm7_interrupt215:
;uarthandler.c,207 :: 		else if ( DMA2_HISRbits.TCIF7 ) {     // TRANSFER COMPLETE INTERRUPT FLAG = envio el frame completo
MOVW	R0, #lo_addr(DMA2_HISRbits+0)
MOVT	R0, #hi_addr(DMA2_HISRbits+0)
_LX	[R0, ByteOffset(DMA2_HISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA2Strm7_interrupt217
;uarthandler.c,208 :: 		DMA2_HIFCRbits.CTCIF7 = 1;       // limpia TODOS LOS FLAGS DE DMA2 CANAL 2
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_HIFCRbits+0)
MOVT	R0, #hi_addr(DMA2_HIFCRbits+0)
_SX	[R0, ByteOffset(DMA2_HIFCRbits+0)]
;uarthandler.c,209 :: 		DMA2_S7CRbits.EN = 0;            // EXPERIMENTAL PARA CAMBIAR EL VALOR DEL CONTADOR
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_S7CRbits+0)
MOVT	R0, #hi_addr(DMA2_S7CRbits+0)
_SX	[R0, ByteOffset(DMA2_S7CRbits+0)]
;uarthandler.c,211 :: 		}
L_DMA2Strm7_interrupt217:
L_DMA2Strm7_interrupt216:
L_DMA2Strm7_interrupt214:
L_DMA2Strm7_interrupt212:
L_DMA2Strm7_interrupt210:
;uarthandler.c,212 :: 		}
L_end_DMA2Strm7_interrupt:
BX	LR
; end of _DMA2Strm7_interrupt
_vUARTISR:
;uarthandler.c,218 :: 		void vUARTISR() iv IVT_INT_USART1 ics ICS_AUTO{
;uarthandler.c,219 :: 		LED_BLUE =~ LED_BLUE;
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_LX	[R0, ByteOffset(GPIOC_ODRbits+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;uarthandler.c,221 :: 		if( USART1_SRbits.RXNE ){
MOVW	R0, #lo_addr(USART1_SRbits+0)
MOVT	R0, #hi_addr(USART1_SRbits+0)
_LX	[R0, ByteOffset(USART1_SRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUARTISR218
;uarthandler.c,222 :: 		ucData1 = USART1_DR;
MOVW	R0, #lo_addr(USART1_DR+0)
MOVT	R0, #hi_addr(USART1_DR+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
STRB	R1, [R0, #0]
;uarthandler.c,223 :: 		if ( ucData1 != CHR_CR && ucData1 != CHR_LF && ulUSART1ByteReceived < BUFFER_MAX_USART ) {
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #13
IT	EQ
BEQ	L_vUARTISR221
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	EQ
BEQ	L_vUARTISR221
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R0, [R0, #0]
CMP	R0, #4096
IT	CS
BCS	L_vUARTISR221
L__vUARTISR461:
;uarthandler.c,226 :: 		ucData1 == CHR_s ||
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #83
IT	EQ
BEQ	L__vUARTISR460
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #115
IT	EQ
BEQ	L__vUARTISR460
;uarthandler.c,227 :: 		ucData1 == CHR_U ||
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #85
IT	EQ
BEQ	L__vUARTISR460
;uarthandler.c,228 :: 		ucData1 == CHR_u ||
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #117
IT	EQ
BEQ	L__vUARTISR460
;uarthandler.c,229 :: 		ucData1 == CHR_G ||
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #71
IT	EQ
BEQ	L__vUARTISR460
;uarthandler.c,230 :: 		ucData1 == CHR_g ) &&
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #103
IT	EQ
BEQ	L__vUARTISR460
IT	AL
BAL	L_vUARTISR226
;uarthandler.c,231 :: 		ulUSART1ByteReceived == 0 ) {
L__vUARTISR460:
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_vUARTISR226
L__vUARTISR459:
;uarthandler.c,232 :: 		ucUSART1RXBuffer[ ulUSART1ByteReceived++ ] = ucData1;
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
;uarthandler.c,233 :: 		}
IT	AL
BAL	L_vUARTISR227
L_vUARTISR226:
;uarthandler.c,236 :: 		ucUSART1RXBuffer[ 0 ] == CHR_s ||
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
LDRB	R0, [R0, #0]
CMP	R0, #83
IT	EQ
BEQ	L__vUARTISR458
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
LDRB	R0, [R0, #0]
CMP	R0, #115
IT	EQ
BEQ	L__vUARTISR458
;uarthandler.c,237 :: 		ucUSART1RXBuffer[ 0 ] == CHR_U ||
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
LDRB	R0, [R0, #0]
CMP	R0, #85
IT	EQ
BEQ	L__vUARTISR458
;uarthandler.c,238 :: 		ucUSART1RXBuffer[ 0 ] == CHR_u ||
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
LDRB	R0, [R0, #0]
CMP	R0, #117
IT	EQ
BEQ	L__vUARTISR458
;uarthandler.c,239 :: 		ucUSART1RXBuffer[ 0 ] == CHR_G ||
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
LDRB	R0, [R0, #0]
CMP	R0, #71
IT	EQ
BEQ	L__vUARTISR458
;uarthandler.c,240 :: 		ucUSART1RXBuffer[ 0 ] == CHR_g ) {
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
LDRB	R0, [R0, #0]
CMP	R0, #103
IT	EQ
BEQ	L__vUARTISR458
IT	AL
BAL	L_vUARTISR230
L__vUARTISR458:
;uarthandler.c,241 :: 		ucUSART1RXBuffer[ ulUSART1ByteReceived++ ] = ucData1;
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
;uarthandler.c,242 :: 		}
L_vUARTISR230:
L_vUARTISR227:
;uarthandler.c,243 :: 		}
IT	AL
BAL	L_vUARTISR231
L_vUARTISR221:
;uarthandler.c,245 :: 		else if ( ucData1 == CHR_CR ) {
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #13
IT	NE
BNE	L_vUARTISR232
;uarthandler.c,246 :: 		ucUSART1RXBuffer[ ulUSART1ByteReceived++ ] = ucData1;
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
;uarthandler.c,247 :: 		}
IT	AL
BAL	L_vUARTISR233
L_vUARTISR232:
;uarthandler.c,249 :: 		else if ( ucData1 == CHR_LF && ucUSART1RXBuffer[ ulUSART1ByteReceived - 1 ] == CHR_CR ) {
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	NE
BNE	L_vUARTISR236
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
BNE	L_vUARTISR236
L__vUARTISR457:
;uarthandler.c,250 :: 		ucUSART1RXBuffer[ ulUSART1ByteReceived++ ] = ucData1;
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
;uarthandler.c,251 :: 		fUSART1Buffer = READY_TO_READ;
MOVS	R1, #1
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
STR	R1, [R0, #0]
;uarthandler.c,252 :: 		}
L_vUARTISR236:
L_vUARTISR233:
L_vUARTISR231:
;uarthandler.c,253 :: 		}
L_vUARTISR218:
;uarthandler.c,254 :: 		}
L_end_vUARTISR:
BX	LR
; end of _vUARTISR
_vUSARTStartMEMtoMEMZero:
;uarthandler.c,265 :: 		unsigned char vUSARTStartMEMtoMEMZero ( unsigned long *pcBufferDestination, unsigned long ulSizeInBytes ) {
SUB	SP, SP, #4
;uarthandler.c,287 :: 		while ( DMA2_S4CRbits.EN );
L_vUSARTStartMEMtoMEMZero237:
MOVW	R0, #lo_addr(DMA2_S4CRbits+0)
MOVT	R0, #hi_addr(DMA2_S4CRbits+0)
_LX	[R0, ByteOffset(DMA2_S4CRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUSARTStartMEMtoMEMZero238
IT	AL
BAL	L_vUSARTStartMEMtoMEMZero237
L_vUSARTStartMEMtoMEMZero238:
;uarthandler.c,289 :: 		if ( ulSizeInBytes > 0 ) {                // la transmision anterior termino?
LDR	R0, [SP, #8]
CMP	R0, #0
IT	LS
BLS	L_vUSARTStartMEMtoMEMZero239
;uarthandler.c,290 :: 		DMA2_S4CRbits.EN = 0;                  // Desabilita la recepci?n para poder modificar los par?metros
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_S4CRbits+0)
MOVT	R0, #hi_addr(DMA2_S4CRbits+0)
_SX	[R0, ByteOffset(DMA2_S4CRbits+0)]
;uarthandler.c,291 :: 		while ( DMA2_S4CRbits.EN );            // espera a que se haya desabilitado realmente
L_vUSARTStartMEMtoMEMZero240:
MOVW	R0, #lo_addr(DMA2_S4CRbits+0)
MOVT	R0, #hi_addr(DMA2_S4CRbits+0)
_LX	[R0, ByteOffset(DMA2_S4CRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUSARTStartMEMtoMEMZero241
IT	AL
BAL	L_vUSARTStartMEMtoMEMZero240
L_vUSARTStartMEMtoMEMZero241:
;uarthandler.c,294 :: 		DMA2_S4PAR = ( unsigned long ) &ucUSARTNull;          // Direccion de periferico a rutear
MOVW	R1, #lo_addr(_ucUSARTNull+0)
MOVT	R1, #hi_addr(_ucUSARTNull+0)
MOVW	R0, #lo_addr(DMA2_S4PAR+0)
MOVT	R0, #hi_addr(DMA2_S4PAR+0)
STR	R1, [R0, #0]
;uarthandler.c,295 :: 		DMA2_S4M0AR = ( unsigned long ) pcBufferDestination;  // Direccion de la memoria a rutear
LDR	R1, [SP, #4]
MOVW	R0, #lo_addr(DMA2_S4M0AR+0)
MOVT	R0, #hi_addr(DMA2_S4M0AR+0)
STR	R1, [R0, #0]
;uarthandler.c,297 :: 		DMA2_S4NDTR = ulSizeInBytes;           // Tamagno de datos a manejar (Header + Payload)
LDR	R1, [SP, #8]
MOVW	R0, #lo_addr(DMA2_S4NDTR+0)
MOVT	R0, #hi_addr(DMA2_S4NDTR+0)
STR	R1, [R0, #0]
;uarthandler.c,298 :: 		DMA2_S4CRbits.EN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_S4CRbits+0)
MOVT	R0, #hi_addr(DMA2_S4CRbits+0)
_SX	[R0, ByteOffset(DMA2_S4CRbits+0)]
;uarthandler.c,299 :: 		while ( DMA2_S4CRbits.EN );
L_vUSARTStartMEMtoMEMZero242:
MOVW	R0, #lo_addr(DMA2_S4CRbits+0)
MOVT	R0, #hi_addr(DMA2_S4CRbits+0)
_LX	[R0, ByteOffset(DMA2_S4CRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUSARTStartMEMtoMEMZero243
IT	AL
BAL	L_vUSARTStartMEMtoMEMZero242
L_vUSARTStartMEMtoMEMZero243:
;uarthandler.c,300 :: 		return 1;                              // indica que transmitio
MOVS	R0, #1
IT	AL
BAL	L_end_vUSARTStartMEMtoMEMZero
;uarthandler.c,301 :: 		}
L_vUSARTStartMEMtoMEMZero239:
;uarthandler.c,302 :: 		return 0;                                 // indica que NO transmitio
MOVS	R0, #0
;uarthandler.c,304 :: 		}
L_end_vUSARTStartMEMtoMEMZero:
ADD	SP, SP, #4
BX	LR
; end of _vUSARTStartMEMtoMEMZero
_vUSARTDMAMeToMemZero:
;uarthandler.c,308 :: 		void vUSARTDMAMeToMemZero ( void ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;uarthandler.c,330 :: 		RCC_AHB1ENRbits.DMA2EN = 1;    // Habilita clock para DMA2
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_AHB1ENRbits+0)
MOVT	R0, #hi_addr(RCC_AHB1ENRbits+0)
_SX	[R0, ByteOffset(RCC_AHB1ENRbits+0)]
;uarthandler.c,332 :: 		DMA2_S4CRbits.EN = 0;          // deshabilita DMA SPI4 RX (para poder modificar los parametros)
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_S4CRbits+0)
MOVT	R0, #hi_addr(DMA2_S4CRbits+0)
_SX	[R0, ByteOffset(DMA2_S4CRbits+0)]
;uarthandler.c,333 :: 		while ( DMA2_S4CRbits.EN );    // espera a que se haya desabilitado realmente
L_vUSARTDMAMeToMemZero244:
MOVW	R0, #lo_addr(DMA2_S4CRbits+0)
MOVT	R0, #hi_addr(DMA2_S4CRbits+0)
_LX	[R0, ByteOffset(DMA2_S4CRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUSARTDMAMeToMemZero245
IT	AL
BAL	L_vUSARTDMAMeToMemZero244
L_vUSARTDMAMeToMemZero245:
;uarthandler.c,335 :: 		DMA2_S4CRbits.CHSEL = 4;       // DMA2, Stream4, Canal 3 = vacio...
MOVS	R2, #4
MOVW	R1, #lo_addr(DMA2_S4CRbits+0)
MOVT	R1, #hi_addr(DMA2_S4CRbits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #25, #3
STR	R0, [R1, #0]
;uarthandler.c,336 :: 		DMA2_S4CRbits.PL = 3;          // Prioridad de canal
MOVS	R2, #3
MOVW	R1, #lo_addr(DMA2_S4CRbits+0)
MOVT	R1, #hi_addr(DMA2_S4CRbits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #16, #2
STR	R0, [R1, #0]
;uarthandler.c,337 :: 		DMA2_S4CRbits.MINC = 1;        // avanza en la direccion de la memoria apuntada
MOVS	R2, #1
SXTB	R2, R2
MOVW	R0, #lo_addr(DMA2_S4CRbits+0)
MOVT	R0, #hi_addr(DMA2_S4CRbits+0)
_SX	[R0, ByteOffset(DMA2_S4CRbits+0)]
;uarthandler.c,338 :: 		DMA2_S4CRbits.PINC = 0;        // avanza en la direccion del periferico apuntado
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_S4CRbits+0)
MOVT	R0, #hi_addr(DMA2_S4CRbits+0)
_SX	[R0, ByteOffset(DMA2_S4CRbits+0)]
;uarthandler.c,339 :: 		DIR0_DMA2_S4CR_bit = 0;        // direccion memoria a memoria
MOVW	R0, #lo_addr(DIR0_DMA2_S4CR_bit+0)
MOVT	R0, #hi_addr(DIR0_DMA2_S4CR_bit+0)
_SX	[R0, ByteOffset(DIR0_DMA2_S4CR_bit+0)]
;uarthandler.c,340 :: 		DIR1_DMA2_S4CR_bit = 1;
MOVW	R0, #lo_addr(DIR1_DMA2_S4CR_bit+0)
MOVT	R0, #hi_addr(DIR1_DMA2_S4CR_bit+0)
_SX	[R0, ByteOffset(DIR1_DMA2_S4CR_bit+0)]
;uarthandler.c,342 :: 		DMA2_S4FCRbits.DMDIS = 1;      // disable DirectMode
MOVW	R0, #lo_addr(DMA2_S4FCRbits+0)
MOVT	R0, #hi_addr(DMA2_S4FCRbits+0)
_SX	[R0, ByteOffset(DMA2_S4FCRbits+0)]
;uarthandler.c,344 :: 		DMA2_S4CRbits.TEIE = 1;        // Habilitacion de interrupcion por error en trasmision
MOVW	R0, #lo_addr(DMA2_S4CRbits+0)
MOVT	R0, #hi_addr(DMA2_S4CRbits+0)
_SX	[R0, ByteOffset(DMA2_S4CRbits+0)]
;uarthandler.c,345 :: 		DMA2_S4CRbits.TCIE = 1;        // Interrupcion por transferencia completa
MOVW	R0, #lo_addr(DMA2_S4CRbits+0)
MOVT	R0, #hi_addr(DMA2_S4CRbits+0)
_SX	[R0, ByteOffset(DMA2_S4CRbits+0)]
;uarthandler.c,347 :: 		NVIC_IntEnable( IVT_INT_DMA2_Stream4 );      // habilita el vector de interrupcion para DMA
MOVW	R0, #76
BL	_NVIC_IntEnable+0
;uarthandler.c,349 :: 		}
L_end_vUSARTDMAMeToMemZero:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUSARTDMAMeToMemZero
_vUSARTStartMEMtoMEM:
;uarthandler.c,354 :: 		unsigned char vUSARTStartMEMtoMEM ( unsigned long *pcBufferOrigin, unsigned long *pcBufferDestination, unsigned long ulSizeInBytes ) {
SUB	SP, SP, #4
;uarthandler.c,376 :: 		while ( DMA2_S1CRbits.EN );
L_vUSARTStartMEMtoMEM246:
MOVW	R0, #lo_addr(DMA2_S1CRbits+0)
MOVT	R0, #hi_addr(DMA2_S1CRbits+0)
_LX	[R0, ByteOffset(DMA2_S1CRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUSARTStartMEMtoMEM247
IT	AL
BAL	L_vUSARTStartMEMtoMEM246
L_vUSARTStartMEMtoMEM247:
;uarthandler.c,378 :: 		if ( ulSizeInBytes > 0 ) {                // la transmision anterior termino?
LDR	R0, [SP, #12]
CMP	R0, #0
IT	LS
BLS	L_vUSARTStartMEMtoMEM248
;uarthandler.c,379 :: 		DMA2_S1CRbits.EN = 0;                  // Desabilita la recepci?n para poder modificar los par?metros
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_S1CRbits+0)
MOVT	R0, #hi_addr(DMA2_S1CRbits+0)
_SX	[R0, ByteOffset(DMA2_S1CRbits+0)]
;uarthandler.c,380 :: 		while ( DMA2_S1CRbits.EN );            // espera a que se haya desabilitado realmente
L_vUSARTStartMEMtoMEM249:
MOVW	R0, #lo_addr(DMA2_S1CRbits+0)
MOVT	R0, #hi_addr(DMA2_S1CRbits+0)
_LX	[R0, ByteOffset(DMA2_S1CRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUSARTStartMEMtoMEM250
IT	AL
BAL	L_vUSARTStartMEMtoMEM249
L_vUSARTStartMEMtoMEM250:
;uarthandler.c,383 :: 		DMA2_S1PAR = ( unsigned long ) pcBufferOrigin;        // Direccion de periferico a rutear
LDR	R1, [SP, #4]
MOVW	R0, #lo_addr(DMA2_S1PAR+0)
MOVT	R0, #hi_addr(DMA2_S1PAR+0)
STR	R1, [R0, #0]
;uarthandler.c,384 :: 		DMA2_S1M0AR = ( unsigned long ) pcBufferDestination;  // Direccion de la memoria a rutear
LDR	R1, [SP, #8]
MOVW	R0, #lo_addr(DMA2_S1M0AR+0)
MOVT	R0, #hi_addr(DMA2_S1M0AR+0)
STR	R1, [R0, #0]
;uarthandler.c,386 :: 		DMA2_S1NDTR = ulSizeInBytes;           // Tamagno de datos a manejar (Header + Payload)
LDR	R1, [SP, #12]
MOVW	R0, #lo_addr(DMA2_S1NDTR+0)
MOVT	R0, #hi_addr(DMA2_S1NDTR+0)
STR	R1, [R0, #0]
;uarthandler.c,387 :: 		DMA2_S1CRbits.EN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_S1CRbits+0)
MOVT	R0, #hi_addr(DMA2_S1CRbits+0)
_SX	[R0, ByteOffset(DMA2_S1CRbits+0)]
;uarthandler.c,388 :: 		while ( DMA2_S1CRbits.EN );
L_vUSARTStartMEMtoMEM251:
MOVW	R0, #lo_addr(DMA2_S1CRbits+0)
MOVT	R0, #hi_addr(DMA2_S1CRbits+0)
_LX	[R0, ByteOffset(DMA2_S1CRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUSARTStartMEMtoMEM252
IT	AL
BAL	L_vUSARTStartMEMtoMEM251
L_vUSARTStartMEMtoMEM252:
;uarthandler.c,389 :: 		return 1;                              // indica que transmitio
MOVS	R0, #1
IT	AL
BAL	L_end_vUSARTStartMEMtoMEM
;uarthandler.c,390 :: 		}
L_vUSARTStartMEMtoMEM248:
;uarthandler.c,391 :: 		return 0;                                 // indica que NO transmitio
MOVS	R0, #0
;uarthandler.c,393 :: 		}
L_end_vUSARTStartMEMtoMEM:
ADD	SP, SP, #4
BX	LR
; end of _vUSARTStartMEMtoMEM
_vUSARTDMAMemToMem:
;uarthandler.c,397 :: 		void vUSARTDMAMemToMem ( void ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;uarthandler.c,420 :: 		RCC_AHB1ENRbits.DMA2EN = 1;    // Habilita clock para DMA2
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_AHB1ENRbits+0)
MOVT	R0, #hi_addr(RCC_AHB1ENRbits+0)
_SX	[R0, ByteOffset(RCC_AHB1ENRbits+0)]
;uarthandler.c,422 :: 		DMA2_S1CRbits.EN = 0;          // deshabilita DMA SPI4 RX (para poder modificar los parametros)
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_S1CRbits+0)
MOVT	R0, #hi_addr(DMA2_S1CRbits+0)
_SX	[R0, ByteOffset(DMA2_S1CRbits+0)]
;uarthandler.c,423 :: 		while ( DMA2_S1CRbits.EN );    // espera a que se haya desabilitado realmente
L_vUSARTDMAMemToMem253:
MOVW	R0, #lo_addr(DMA2_S1CRbits+0)
MOVT	R0, #hi_addr(DMA2_S1CRbits+0)
_LX	[R0, ByteOffset(DMA2_S1CRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUSARTDMAMemToMem254
IT	AL
BAL	L_vUSARTDMAMemToMem253
L_vUSARTDMAMemToMem254:
;uarthandler.c,425 :: 		DMA2_S1CRbits.CHSEL = 3;       // DMA2, Stream1, Canal 3 = vacio...
MOVS	R2, #3
MOVW	R1, #lo_addr(DMA2_S1CRbits+0)
MOVT	R1, #hi_addr(DMA2_S1CRbits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #25, #3
STR	R0, [R1, #0]
;uarthandler.c,426 :: 		DMA2_S1CRbits.PL = 3;          // Prioridad de canal
MOVS	R2, #3
MOVW	R1, #lo_addr(DMA2_S1CRbits+0)
MOVT	R1, #hi_addr(DMA2_S1CRbits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #16, #2
STR	R0, [R1, #0]
;uarthandler.c,427 :: 		DMA2_S1CRbits.MINC = 1;        // avanza en la direccion de la memoria apuntada
MOVS	R2, #1
SXTB	R2, R2
MOVW	R0, #lo_addr(DMA2_S1CRbits+0)
MOVT	R0, #hi_addr(DMA2_S1CRbits+0)
_SX	[R0, ByteOffset(DMA2_S1CRbits+0)]
;uarthandler.c,428 :: 		DMA2_S1CRbits.PINC = 1;        // avanza en la direccion del periferico apuntado
MOVW	R0, #lo_addr(DMA2_S1CRbits+0)
MOVT	R0, #hi_addr(DMA2_S1CRbits+0)
_SX	[R0, ByteOffset(DMA2_S1CRbits+0)]
;uarthandler.c,429 :: 		DIR0_DMA2_S1CR_bit = 0;        // direccion memoria a memoria
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(DIR0_DMA2_S1CR_bit+0)
MOVT	R0, #hi_addr(DIR0_DMA2_S1CR_bit+0)
_SX	[R0, ByteOffset(DIR0_DMA2_S1CR_bit+0)]
;uarthandler.c,430 :: 		DIR1_DMA2_S1CR_bit = 1;
MOVW	R0, #lo_addr(DIR1_DMA2_S1CR_bit+0)
MOVT	R0, #hi_addr(DIR1_DMA2_S1CR_bit+0)
_SX	[R0, ByteOffset(DIR1_DMA2_S1CR_bit+0)]
;uarthandler.c,432 :: 		DMA2_S1FCRbits.DMDIS = 1;      // disable DirectMode
MOVW	R0, #lo_addr(DMA2_S1FCRbits+0)
MOVT	R0, #hi_addr(DMA2_S1FCRbits+0)
_SX	[R0, ByteOffset(DMA2_S1FCRbits+0)]
;uarthandler.c,434 :: 		DMA2_S1CRbits.TEIE = 1;        // Habilitacion de interrupcion por error en trasmision
MOVW	R0, #lo_addr(DMA2_S1CRbits+0)
MOVT	R0, #hi_addr(DMA2_S1CRbits+0)
_SX	[R0, ByteOffset(DMA2_S1CRbits+0)]
;uarthandler.c,435 :: 		DMA2_S1CRbits.TCIE = 1;        // Interrupcion por transferencia completa
MOVW	R0, #lo_addr(DMA2_S1CRbits+0)
MOVT	R0, #hi_addr(DMA2_S1CRbits+0)
_SX	[R0, ByteOffset(DMA2_S1CRbits+0)]
;uarthandler.c,437 :: 		NVIC_IntEnable( IVT_INT_DMA2_Stream1 );      // habilita el vector de interrupcion para DMA
MOVW	R0, #73
BL	_NVIC_IntEnable+0
;uarthandler.c,439 :: 		}
L_end_vUSARTDMAMemToMem:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUSARTDMAMemToMem
_vUSART1Start_TX:
;uarthandler.c,445 :: 		unsigned char vUSART1Start_TX ( unsigned long *ucBuffer, unsigned long ulSize ) {
SUB	SP, SP, #4
;uarthandler.c,464 :: 		while ( DMA2_S7CRbits.EN || !USART1_SRbits.TC );
L_vUSART1Start_TX255:
MOVW	R0, #lo_addr(DMA2_S7CRbits+0)
MOVT	R0, #hi_addr(DMA2_S7CRbits+0)
_LX	[R0, ByteOffset(DMA2_S7CRbits+0)]
CMP	R0, #0
IT	NE
BNE	L__vUSART1Start_TX464
MOVW	R0, #lo_addr(USART1_SRbits+0)
MOVT	R0, #hi_addr(USART1_SRbits+0)
_LX	[R0, ByteOffset(USART1_SRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L__vUSART1Start_TX464
IT	AL
BAL	L_vUSART1Start_TX256
L__vUSART1Start_TX464:
IT	AL
BAL	L_vUSART1Start_TX255
L_vUSART1Start_TX256:
;uarthandler.c,466 :: 		if ( USART1_CR1bits.UE && USART1_SRbits.TC && ulSize > 0 ) { // la transmision anterior termino?
MOVW	R0, #lo_addr(USART1_CR1bits+0)
MOVT	R0, #hi_addr(USART1_CR1bits+0)
_LX	[R0, ByteOffset(USART1_CR1bits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUSART1Start_TX261
MOVW	R0, #lo_addr(USART1_SRbits+0)
MOVT	R0, #hi_addr(USART1_SRbits+0)
_LX	[R0, ByteOffset(USART1_SRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUSART1Start_TX261
LDR	R0, [SP, #8]
CMP	R0, #0
IT	LS
BLS	L_vUSART1Start_TX261
L__vUSART1Start_TX463:
;uarthandler.c,467 :: 		DMA2_S7CRbits.EN = 0;                       // Desabilita la recepci?n para poder modificar los par?metros
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_S7CRbits+0)
MOVT	R0, #hi_addr(DMA2_S7CRbits+0)
_SX	[R0, ByteOffset(DMA2_S7CRbits+0)]
;uarthandler.c,468 :: 		while ( DMA2_S7CRbits.EN );                 // espera a que se haya desabilitado realmente
L_vUSART1Start_TX262:
MOVW	R0, #lo_addr(DMA2_S7CRbits+0)
MOVT	R0, #hi_addr(DMA2_S7CRbits+0)
_LX	[R0, ByteOffset(DMA2_S7CRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUSART1Start_TX263
IT	AL
BAL	L_vUSART1Start_TX262
L_vUSART1Start_TX263:
;uarthandler.c,470 :: 		DMA2_S7M0AR = ( unsigned long ) ucBuffer;   // Direcci?n de la memoria a rutear
LDR	R1, [SP, #4]
MOVW	R0, #lo_addr(DMA2_S7M0AR+0)
MOVT	R0, #hi_addr(DMA2_S7M0AR+0)
STR	R1, [R0, #0]
;uarthandler.c,471 :: 		DMA2_S7NDTR = ulSize;                       // Tama?o de datos a manejar
LDR	R1, [SP, #8]
MOVW	R0, #lo_addr(DMA2_S7NDTR+0)
MOVT	R0, #hi_addr(DMA2_S7NDTR+0)
STR	R1, [R0, #0]
;uarthandler.c,472 :: 		DMA2_S7CRbits.EN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_S7CRbits+0)
MOVT	R0, #hi_addr(DMA2_S7CRbits+0)
_SX	[R0, ByteOffset(DMA2_S7CRbits+0)]
;uarthandler.c,473 :: 		while ( DMA2_S7CRbits.EN || !USART1_SRbits.TC );
L_vUSART1Start_TX264:
MOVW	R0, #lo_addr(DMA2_S7CRbits+0)
MOVT	R0, #hi_addr(DMA2_S7CRbits+0)
_LX	[R0, ByteOffset(DMA2_S7CRbits+0)]
CMP	R0, #0
IT	NE
BNE	L__vUSART1Start_TX462
MOVW	R0, #lo_addr(USART1_SRbits+0)
MOVT	R0, #hi_addr(USART1_SRbits+0)
_LX	[R0, ByteOffset(USART1_SRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L__vUSART1Start_TX462
IT	AL
BAL	L_vUSART1Start_TX265
L__vUSART1Start_TX462:
IT	AL
BAL	L_vUSART1Start_TX264
L_vUSART1Start_TX265:
;uarthandler.c,474 :: 		return 1;                                   // indica que transmitio
MOVS	R0, #1
IT	AL
BAL	L_end_vUSART1Start_TX
;uarthandler.c,475 :: 		}
L_vUSART1Start_TX261:
;uarthandler.c,476 :: 		return 0;                                      // indica que NO transmitio
MOVS	R0, #0
;uarthandler.c,478 :: 		}
L_end_vUSART1Start_TX:
ADD	SP, SP, #4
BX	LR
; end of _vUSART1Start_TX
_vInitDMAUSART1_TX:
;uarthandler.c,482 :: 		void vInitDMAUSART1_TX () {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;uarthandler.c,503 :: 		RCC_AHB1ENRbits.DMA2EN = 1;    // Habilita clock para DMA2
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_AHB1ENRbits+0)
MOVT	R0, #hi_addr(RCC_AHB1ENRbits+0)
_SX	[R0, ByteOffset(RCC_AHB1ENRbits+0)]
;uarthandler.c,505 :: 		DMA2_S7CRbits.EN = 0;          // deshabilita DMA USART1 TX (para poder modificar los parametros)
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_S7CRbits+0)
MOVT	R0, #hi_addr(DMA2_S7CRbits+0)
_SX	[R0, ByteOffset(DMA2_S7CRbits+0)]
;uarthandler.c,506 :: 		while ( DMA2_S7CRbits.EN );    // espera a que se haya desabilitado realmente
L_vInitDMAUSART1_TX268:
MOVW	R0, #lo_addr(DMA2_S7CRbits+0)
MOVT	R0, #hi_addr(DMA2_S7CRbits+0)
_LX	[R0, ByteOffset(DMA2_S7CRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vInitDMAUSART1_TX269
IT	AL
BAL	L_vInitDMAUSART1_TX268
L_vInitDMAUSART1_TX269:
;uarthandler.c,509 :: 		DMA2_S7PAR = ( unsigned long ) &USART1_DR;           // Direccion fisica de periferico a rutear
MOVW	R1, #lo_addr(USART1_DR+0)
MOVT	R1, #hi_addr(USART1_DR+0)
MOVW	R0, #lo_addr(DMA2_S7PAR+0)
MOVT	R0, #hi_addr(DMA2_S7PAR+0)
STR	R1, [R0, #0]
;uarthandler.c,511 :: 		DMA2_S7CRbits.CHSEL = 4;       // DMA2, Stream7, Canal 4 = USART1_TX
MOVS	R2, #4
MOVW	R1, #lo_addr(DMA2_S7CRbits+0)
MOVT	R1, #hi_addr(DMA2_S7CRbits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #25, #3
STR	R0, [R1, #0]
;uarthandler.c,512 :: 		DMA2_S7CRbits.PL = 3;          // Prioridad de canal
MOVS	R2, #3
MOVW	R1, #lo_addr(DMA2_S7CRbits+0)
MOVT	R1, #hi_addr(DMA2_S7CRbits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #16, #2
STR	R0, [R1, #0]
;uarthandler.c,513 :: 		DMA2_S7CRbits.MINC = 1;        // avanza en la direccion de la memoria apuntada
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_S7CRbits+0)
MOVT	R0, #hi_addr(DMA2_S7CRbits+0)
_SX	[R0, ByteOffset(DMA2_S7CRbits+0)]
;uarthandler.c,514 :: 		DIR0_DMA2_S7CR_bit = 1;        // direccion memoria a periferico
MOVW	R0, #lo_addr(DIR0_DMA2_S7CR_bit+0)
MOVT	R0, #hi_addr(DIR0_DMA2_S7CR_bit+0)
_SX	[R0, ByteOffset(DIR0_DMA2_S7CR_bit+0)]
;uarthandler.c,515 :: 		DMA2_S7CRbits.TEIE = 1;        // Habilitacion de interrupcion por error en trasmision
MOVW	R0, #lo_addr(DMA2_S7CRbits+0)
MOVT	R0, #hi_addr(DMA2_S7CRbits+0)
_SX	[R0, ByteOffset(DMA2_S7CRbits+0)]
;uarthandler.c,516 :: 		DMA2_S7CRbits.TCIE = 1;        // Interrupcion por transferencia completa
MOVW	R0, #lo_addr(DMA2_S7CRbits+0)
MOVT	R0, #hi_addr(DMA2_S7CRbits+0)
_SX	[R0, ByteOffset(DMA2_S7CRbits+0)]
;uarthandler.c,518 :: 		NVIC_IntEnable( IVT_INT_DMA2_Stream7 );      // habilita el vector de interrupcion para DMA
MOVW	R0, #86
BL	_NVIC_IntEnable+0
;uarthandler.c,520 :: 		}
L_end_vInitDMAUSART1_TX:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vInitDMAUSART1_TX
_vUSARTConfigUSART1:
;uarthandler.c,525 :: 		void vUSARTConfigUSART1 ( unsigned long ulBaudRate ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;uarthandler.c,527 :: 		UART1_Init_Advanced( ulBaudRate, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10 );
MOVW	R0, #lo_addr(__GPIO_MODULE_USART1_PA9_10+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_USART1_PA9_10+0)
PUSH	(R0)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
LDR	R0, [SP, #8]
BL	_UART1_Init_Advanced+0
ADD	SP, SP, #4
;uarthandler.c,528 :: 		Enable_IRQ_USART1;                 // habilita interrupcion por RX de USART1
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(USART1_CR1bits+0)
MOVT	R0, #hi_addr(USART1_CR1bits+0)
_SX	[R0, ByteOffset(USART1_CR1bits+0)]
;uarthandler.c,529 :: 		USART1_CR3bits.DMAT = 1;           // habilita transmision mediante DMA
MOVW	R0, #lo_addr(USART1_CR3bits+0)
MOVT	R0, #hi_addr(USART1_CR3bits+0)
_SX	[R0, ByteOffset(USART1_CR3bits+0)]
;uarthandler.c,530 :: 		vInitDMAUSART1_TX();               // se llama como funcion
BL	_vInitDMAUSART1_TX+0
;uarthandler.c,531 :: 		fUSART1Buffer = CLEAR_TO_WRITE;
MOVS	R1, #0
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
STR	R1, [R0, #0]
;uarthandler.c,532 :: 		NVIC_IntEnable( IVT_INT_USART1 );  // Habilita vector de interrupcion
MOVW	R0, #53
BL	_NVIC_IntEnable+0
;uarthandler.c,533 :: 		vUSARTDMAMemToMem();               // inicializa el DMA MEMtoMEM 1 ( Buffer a Buffer )
BL	_vUSARTDMAMemToMem+0
;uarthandler.c,534 :: 		vUSARTDMAMeToMemZero();            // inicializa el DMA MEMtoMEM 2 ( Limpiar buffer )
BL	_vUSARTDMAMeToMemZero+0
;uarthandler.c,547 :: 		}
L_end_vUSARTConfigUSART1:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUSARTConfigUSART1
_vUSARTCleanBuffer:
;uarthandler.c,553 :: 		void vUSARTCleanBuffer ( unsigned char *ucBuffer, unsigned int uiCnt ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;uarthandler.c,555 :: 		vUSARTStartMEMtoMEMZero( ucBuffer, uiCnt );
LDRH	R0, [SP, #8]
PUSH	(R0)
LDR	R0, [SP, #8]
PUSH	(R0)
BL	_vUSARTStartMEMtoMEMZero+0
ADD	SP, SP, #8
;uarthandler.c,556 :: 		}
L_end_vUSARTCleanBuffer:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUSARTCleanBuffer
_vUSARTReceivedFromUSART1:
;uarthandler.c,560 :: 		void vUSARTReceivedFromUSART1 ( ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;uarthandler.c,562 :: 		vUSARTCleanBuffer( ucUSARTActiveBuffer1, ulUSARTActiveBuffer1BytesReceived ); // borra todo el buffer
MOVW	R0, #lo_addr(_ulUSARTActiveBuffer1BytesReceived+0)
MOVT	R0, #hi_addr(_ulUSARTActiveBuffer1BytesReceived+0)
LDR	R0, [R0, #0]
PUSH	(R0)
MOVW	R0, #lo_addr(_ucUSARTActiveBuffer1+0)
MOVT	R0, #hi_addr(_ucUSARTActiveBuffer1+0)
PUSH	(R0)
BL	_vUSARTCleanBuffer+0
ADD	SP, SP, #8
;uarthandler.c,564 :: 		vUSARTStartMEMtoMEM( ucUSART1RXBuffer, ucUSARTActiveBuffer1, ulUSART1ByteReceived ); // copia el buffer de entrada
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
;uarthandler.c,565 :: 		vUSARTCleanBuffer( ucUSART1RXBuffer, ulUSART1ByteReceived );          // lo limpia
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R0, [R0, #0]
PUSH	(R0)
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
PUSH	(R0)
BL	_vUSARTCleanBuffer+0
ADD	SP, SP, #8
;uarthandler.c,566 :: 		ulUSARTActiveBuffer1BytesReceived = ulUSART1ByteReceived;             // le pasa el valor
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ulUSARTActiveBuffer1BytesReceived+0)
MOVT	R0, #hi_addr(_ulUSARTActiveBuffer1BytesReceived+0)
STR	R1, [R0, #0]
;uarthandler.c,567 :: 		ulUSART1ByteReceived = 0;                                             // pone a cero el contador
MOVS	R1, #0
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
STR	R1, [R0, #0]
;uarthandler.c,568 :: 		fUSART1Buffer = CLEAR_TO_WRITE;                                       // indica que esta limpio
MOVS	R1, #0
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
STR	R1, [R0, #0]
;uarthandler.c,569 :: 		vRF4463MainCommandProcessor( ucUSARTActiveBuffer1 );
MOVW	R0, #lo_addr(_ucUSARTActiveBuffer1+0)
MOVT	R0, #hi_addr(_ucUSARTActiveBuffer1+0)
PUSH	(R0)
BL	_vRF4463MainCommandProcessor+0
ADD	SP, SP, #4
;uarthandler.c,570 :: 		}
L_end_vUSARTReceivedFromUSART1:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUSARTReceivedFromUSART1
_vUARTRxMessage:
;uarthandler.c,579 :: 		void vUARTRxMessage(){
SUB	SP, SP, #8
;uarthandler.c,580 :: 		unsigned int usCounter = 0;
MOVW	R0, #0
STRH	R0, [SP, #4]
;uarthandler.c,592 :: 		usUARTMessageLength = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_usUARTMessageLength+0)
MOVT	R0, #hi_addr(_usUARTMessageLength+0)
STRH	R1, [R0, #0]
;uarthandler.c,593 :: 		}
L_end_vUARTRxMessage:
ADD	SP, SP, #8
BX	LR
; end of _vUARTRxMessage
_Timer2_interrupt:
;DriverRF4463PROMain.c,113 :: 		void Timer2_interrupt() iv IVT_INT_TIM2 {
;DriverRF4463PROMain.c,114 :: 		TIM2_SR.UIF = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_SR+0)
MOVT	R0, #hi_addr(TIM2_SR+0)
_SX	[R0, ByteOffset(TIM2_SR+0)]
;DriverRF4463PROMain.c,115 :: 		Flag.rf_reach_timeout = 1; //Enter your code here
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,116 :: 		Flag.reach_1s = 1;
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,117 :: 		}
L_end_Timer2_interrupt:
BX	LR
; end of _Timer2_interrupt
_vRF4463MainApplyChanges:
;DriverRF4463PROMain.c,121 :: 		void vRF4463MainApplyChanges () {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;DriverRF4463PROMain.c,122 :: 		VRF4463SDNReset();
BL	_VRF4463SDNReset+0
;DriverRF4463PROMain.c,123 :: 		vRF4463Init();
BL	_vRF4463Init+0
;DriverRF4463PROMain.c,124 :: 		vRF4463ClearInterrupts();
BL	_vRF4463ClearInterrupts+0
;DriverRF4463PROMain.c,125 :: 		}
L_end_vRF4463MainApplyChanges:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vRF4463MainApplyChanges
_vRF4463MainSetTXString:
;DriverRF4463PROMain.c,128 :: 		void vRF4463MainSetTXString () {
SUB	SP, SP, #4
;DriverRF4463PROMain.c,129 :: 		ucRF4463TXdata[ 0 ] = ucRF4463ByteMatch1;
MOVW	R0, #lo_addr(_ucRF4463ByteMatch1+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch1+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucRF4463TXdata+0)
MOVT	R0, #hi_addr(_ucRF4463TXdata+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,130 :: 		ucRF4463TXdata[ 1 ] = ucRF4463ByteMatch2;
MOVW	R0, #lo_addr(_ucRF4463ByteMatch2+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch2+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucRF4463TXdata+1)
MOVT	R0, #hi_addr(_ucRF4463TXdata+1)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,131 :: 		ucRF4463TXdata[ 2 ] = ucRF4463ByteMatch3;
MOVW	R0, #lo_addr(_ucRF4463ByteMatch3+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch3+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucRF4463TXdata+2)
MOVT	R0, #hi_addr(_ucRF4463TXdata+2)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,132 :: 		ucRF4463TXdata[ 3 ] = ucRF4463ByteMatch4;
MOVW	R0, #lo_addr(_ucRF4463ByteMatch4+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch4+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucRF4463TXdata+3)
MOVT	R0, #hi_addr(_ucRF4463TXdata+3)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,133 :: 		}
L_end_vRF4463MainSetTXString:
ADD	SP, SP, #4
BX	LR
; end of _vRF4463MainSetTXString
_vRF4463MainCommandProcessor:
;DriverRF4463PROMain.c,137 :: 		void vRF4463MainCommandProcessor ( unsigned char *ucBuffer ) {
SUB	SP, SP, #192
STR	LR, [SP, #0]
;DriverRF4463PROMain.c,138 :: 		unsigned char ucCommand [ 32 ] = { 0x00 };
ADD	R11, SP, #22
ADD	R10, R11, #163
MOVW	R12, #lo_addr(?ICSvRF4463MainCommandProcessor_ucCommand_L0+0)
MOVT	R12, #hi_addr(?ICSvRF4463MainCommandProcessor_ucCommand_L0+0)
BL	___CC2DW+0
;DriverRF4463PROMain.c,140 :: 		unsigned char ucLongArgument[ 64 ] = { 0x00 };     // Espera argumentos de hasta 11 bytes
;DriverRF4463PROMain.c,141 :: 		unsigned char ucCounterBuffer = 0;
;DriverRF4463PROMain.c,142 :: 		unsigned char ucCounterCommand = 0;
;DriverRF4463PROMain.c,143 :: 		unsigned char ucCounterLongArgument = 0;
;DriverRF4463PROMain.c,145 :: 		unsigned char ucTXT [ 64 ] = { 0x00 };             // string de conversiones temporales
;DriverRF4463PROMain.c,147 :: 		ulArgument = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,150 :: 		if ( ucBuffer[ 0 ] > '@' && ucBuffer[ 0 ] <= 'z' ) {
LDR	R0, [SP, #192]
ADDS	R0, R0, #0
LDRB	R0, [R0, #0]
CMP	R0, #64
IT	LS
BLS	L_vRF4463MainCommandProcessor272
LDR	R0, [SP, #192]
ADDS	R0, R0, #0
LDRB	R0, [R0, #0]
CMP	R0, #122
IT	HI
BHI	L_vRF4463MainCommandProcessor272
L__vRF4463MainCommandProcessor480:
;DriverRF4463PROMain.c,152 :: 		while ( ucBuffer[ ucCounterBuffer ] != '|' && ucCounterCommand < 32 ) {      // primer token
L_vRF4463MainCommandProcessor273:
LDRB	R1, [SP, #118]
LDR	R0, [SP, #192]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
CMP	R0, #124
IT	EQ
BEQ	L_vRF4463MainCommandProcessor274
LDRB	R0, [SP, #119]
CMP	R0, #32
IT	CS
BCS	L_vRF4463MainCommandProcessor274
L__vRF4463MainCommandProcessor479:
;DriverRF4463PROMain.c,153 :: 		ucCommand[ ucCounterCommand++ ] = toupper( ucBuffer[ ucCounterBuffer++ ] );
ADD	R1, SP, #22
LDRB	R0, [SP, #119]
ADDS	R0, R1, R0
STR	R0, [SP, #188]
LDRB	R1, [SP, #118]
LDR	R0, [SP, #192]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
UXTB	R4, R0
UXTB	R0, R4
BL	_toupper+0
LDR	R1, [SP, #188]
STRB	R0, [R1, #0]
LDRB	R0, [SP, #119]
ADDS	R0, R0, #1
STRB	R0, [SP, #119]
LDRB	R0, [SP, #118]
ADDS	R0, R0, #1
STRB	R0, [SP, #118]
;DriverRF4463PROMain.c,154 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor273
L_vRF4463MainCommandProcessor274:
;DriverRF4463PROMain.c,156 :: 		ucCounterBuffer++;                                                           // evita el Token
LDRB	R0, [SP, #118]
ADDS	R0, R0, #1
STRB	R0, [SP, #118]
;DriverRF4463PROMain.c,158 :: 		while ( ucBuffer[ ucCounterBuffer ] != CHR_CR && ucCounterLongArgument < 64 ) {   // segundo token
L_vRF4463MainCommandProcessor277:
LDRB	R1, [SP, #118]
LDR	R0, [SP, #192]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
CMP	R0, #13
IT	EQ
BEQ	L_vRF4463MainCommandProcessor278
LDRB	R0, [SP, #120]
CMP	R0, #64
IT	CS
BCS	L_vRF4463MainCommandProcessor278
L__vRF4463MainCommandProcessor478:
;DriverRF4463PROMain.c,159 :: 		ucLongArgument[ ucCounterLongArgument ] = ucBuffer[ ucCounterBuffer ] ;   //  toupper(
ADD	R1, SP, #54
LDRB	R0, [SP, #120]
ADDS	R2, R1, R0
LDRB	R1, [SP, #118]
LDR	R0, [SP, #192]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;DriverRF4463PROMain.c,160 :: 		ucCounterBuffer++;
LDRB	R0, [SP, #118]
ADDS	R0, R0, #1
STRB	R0, [SP, #118]
;DriverRF4463PROMain.c,161 :: 		ucCounterLongArgument++;
LDRB	R0, [SP, #120]
ADDS	R0, R0, #1
STRB	R0, [SP, #120]
;DriverRF4463PROMain.c,162 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor277
L_vRF4463MainCommandProcessor278:
;DriverRF4463PROMain.c,163 :: 		}
L_vRF4463MainCommandProcessor272:
;DriverRF4463PROMain.c,167 :: 		if ( memcmp( CMD_RADIO_POWER_SET, ucCommand, sizeof( CMD_RADIO_POWER_SET ) ) == 0x00 ) {
ADD	R4, SP, #22
MOVS	R2, #10
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_POWER_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_POWER_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor281
;DriverRF4463PROMain.c,168 :: 		ulArgument = StrToShort( ucLongArgument );
ADD	R4, SP, #54
MOV	R0, R4
BL	_StrToShort+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,170 :: 		if ( ulArgument > 0 && ulArgument <= 127 ) {
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	LS
BLS	L_vRF4463MainCommandProcessor284
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #127
IT	HI
BHI	L_vRF4463MainCommandProcessor284
L__vRF4463MainCommandProcessor477:
;DriverRF4463PROMain.c,171 :: 		ucRF4463Power = ulArgument;
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucRF4463Power+0)
MOVT	R0, #hi_addr(_ucRF4463Power+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,172 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,173 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,174 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor285
L_vRF4463MainCommandProcessor284:
;DriverRF4463PROMain.c,176 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,177 :: 		}
L_vRF4463MainCommandProcessor285:
;DriverRF4463PROMain.c,178 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor286
L_vRF4463MainCommandProcessor281:
;DriverRF4463PROMain.c,182 :: 		else if ( memcmp( CMD_RADIO_BAND_SET, ucCommand, sizeof( CMD_RADIO_BAND_SET ) ) == 0x00 ) {
ADD	R4, SP, #22
MOVS	R2, #9
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_BAND_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_BAND_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor287
;DriverRF4463PROMain.c,183 :: 		ulArgument = StrToInt( ucLongArgument );
ADD	R4, SP, #54
MOV	R0, R4
BL	_StrToInt+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,185 :: 		if ( ulArgument == 433 || ulArgument == 868 || ulArgument == 915 ) {
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R0, #0]
MOVW	R0, #433
CMP	R1, R0
IT	EQ
BEQ	L__vRF4463MainCommandProcessor476
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #868
IT	EQ
BEQ	L__vRF4463MainCommandProcessor476
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R0, #0]
MOVW	R0, #915
CMP	R1, R0
IT	EQ
BEQ	L__vRF4463MainCommandProcessor476
IT	AL
BAL	L_vRF4463MainCommandProcessor290
L__vRF4463MainCommandProcessor476:
;DriverRF4463PROMain.c,186 :: 		ucRF4463Freq3 = ucLongArgument[ 0 ] - 48;
ADD	R0, SP, #54
ADDS	R0, R0, #0
LDRB	R0, [R0, #0]
SUBW	R1, R0, #48
MOVW	R0, #lo_addr(_ucRF4463Freq3+0)
MOVT	R0, #hi_addr(_ucRF4463Freq3+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,187 :: 		ucRF4463Freq2 = ucLongArgument[ 1 ] - 48;
ADD	R0, SP, #54
ADDS	R0, R0, #1
LDRB	R0, [R0, #0]
SUBW	R1, R0, #48
MOVW	R0, #lo_addr(_ucRF4463Freq2+0)
MOVT	R0, #hi_addr(_ucRF4463Freq2+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,188 :: 		ucRF4463Freq1 = ucLongArgument[ 2 ] - 48;
ADD	R0, SP, #54
ADDS	R0, R0, #2
LDRB	R0, [R0, #0]
SUBW	R1, R0, #48
MOVW	R0, #lo_addr(_ucRF4463Freq1+0)
MOVT	R0, #hi_addr(_ucRF4463Freq1+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,189 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,190 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,191 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor291
L_vRF4463MainCommandProcessor290:
;DriverRF4463PROMain.c,193 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,194 :: 		}
L_vRF4463MainCommandProcessor291:
;DriverRF4463PROMain.c,195 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor292
L_vRF4463MainCommandProcessor287:
;DriverRF4463PROMain.c,199 :: 		else if ( memcmp( CMD_RADIO_RATE_SET, ucCommand, sizeof( CMD_RADIO_RATE_SET ) ) == 0x00 ) {
ADD	R4, SP, #22
MOVS	R2, #9
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_RATE_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_RATE_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor293
;DriverRF4463PROMain.c,200 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R4, SP, #54
MOV	R0, R4
BL	_StrToLong+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,202 :: 		switch ( ulArgument ) {
IT	AL
BAL	L_vRF4463MainCommandProcessor294
;DriverRF4463PROMain.c,203 :: 		case 500      : ucRF4463Rate = dr_500;
L_vRF4463MainCommandProcessor296:
MOVS	R1, #10
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,204 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,205 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,206 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor295
;DriverRF4463PROMain.c,207 :: 		case 1200     : ucRF4463Rate = dr_1p2;
L_vRF4463MainCommandProcessor297:
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,208 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,209 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,210 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor295
;DriverRF4463PROMain.c,211 :: 		case 2400     : ucRF4463Rate = dr_2p4;
L_vRF4463MainCommandProcessor298:
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,212 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,213 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,214 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor295
;DriverRF4463PROMain.c,215 :: 		case 4800     : ucRF4463Rate = dr_4p8;
L_vRF4463MainCommandProcessor299:
MOVS	R1, #2
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,216 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,217 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,218 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor295
;DriverRF4463PROMain.c,219 :: 		case 9600     : ucRF4463Rate = dr_9p6;
L_vRF4463MainCommandProcessor300:
MOVS	R1, #3
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,220 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,221 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,222 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor295
;DriverRF4463PROMain.c,223 :: 		case 19200    : ucRF4463Rate = dr_19p2;
L_vRF4463MainCommandProcessor301:
MOVS	R1, #4
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,224 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,225 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,226 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor295
;DriverRF4463PROMain.c,227 :: 		case 38400    : ucRF4463Rate = dr_38p4;
L_vRF4463MainCommandProcessor302:
MOVS	R1, #5
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,228 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,229 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,230 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor295
;DriverRF4463PROMain.c,231 :: 		case 76800    : ucRF4463Rate = dr_76p8;
L_vRF4463MainCommandProcessor303:
MOVS	R1, #6
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,232 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,233 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,234 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor295
;DriverRF4463PROMain.c,235 :: 		case 115200   : ucRF4463Rate = dr_115p2;
L_vRF4463MainCommandProcessor304:
MOVS	R1, #7
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,236 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,237 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,238 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor295
;DriverRF4463PROMain.c,239 :: 		case 256000   : ucRF4463Rate = dr_256k;
L_vRF4463MainCommandProcessor305:
MOVS	R1, #8
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,240 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,241 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,242 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor295
;DriverRF4463PROMain.c,243 :: 		case 500000   : ucRF4463Rate = dr_500k;
L_vRF4463MainCommandProcessor306:
MOVS	R1, #9
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,244 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,245 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,246 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor295
;DriverRF4463PROMain.c,247 :: 		default       : vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
L_vRF4463MainCommandProcessor307:
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,248 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor295
L_vRF4463MainCommandProcessor294:
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #500
IT	EQ
BEQ	L_vRF4463MainCommandProcessor296
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #1200
IT	EQ
BEQ	L_vRF4463MainCommandProcessor297
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #2400
IT	EQ
BEQ	L_vRF4463MainCommandProcessor298
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #4800
IT	EQ
BEQ	L_vRF4463MainCommandProcessor299
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #9600
IT	EQ
BEQ	L_vRF4463MainCommandProcessor300
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #19200
IT	EQ
BEQ	L_vRF4463MainCommandProcessor301
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #38400
IT	EQ
BEQ	L_vRF4463MainCommandProcessor302
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #76800
IT	EQ
BEQ	L_vRF4463MainCommandProcessor303
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #115200
IT	EQ
BEQ	L_vRF4463MainCommandProcessor304
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #256000
IT	EQ
BEQ	L_vRF4463MainCommandProcessor305
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R0, #0]
MOVW	R0, #41248
MOVT	R0, #7
CMP	R1, R0
IT	EQ
BEQ	L_vRF4463MainCommandProcessor306
IT	AL
BAL	L_vRF4463MainCommandProcessor307
L_vRF4463MainCommandProcessor295:
;DriverRF4463PROMain.c,249 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor308
L_vRF4463MainCommandProcessor293:
;DriverRF4463PROMain.c,253 :: 		else if ( memcmp( CMD_RADIO_CHANNEL_SET, ucCommand, sizeof( CMD_RADIO_CHANNEL_SET ) ) == 0x00 ) {
ADD	R4, SP, #22
MOVS	R2, #12
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_CHANNEL_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_CHANNEL_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor309
;DriverRF4463PROMain.c,254 :: 		ulArgument = StrToInt( ucLongArgument );
ADD	R4, SP, #54
MOV	R0, R4
BL	_StrToInt+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,256 :: 		if ( ulArgument >= 0 && ulArgument <= 50 ) {
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	CC
BCC	L_vRF4463MainCommandProcessor312
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #50
IT	HI
BHI	L_vRF4463MainCommandProcessor312
L__vRF4463MainCommandProcessor475:
;DriverRF4463PROMain.c,257 :: 		ucRF4463FreqChannel = ulArgument;    // Se aplica al ejecutar funciones de TX o RX
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,258 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,259 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,260 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor313
L_vRF4463MainCommandProcessor312:
;DriverRF4463PROMain.c,262 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,263 :: 		}
L_vRF4463MainCommandProcessor313:
;DriverRF4463PROMain.c,264 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor314
L_vRF4463MainCommandProcessor309:
;DriverRF4463PROMain.c,268 :: 		else if ( memcmp( CMD_RADIO_BW_SET, ucCommand, sizeof( CMD_RADIO_BW_SET ) ) == 0x00 ) {
ADD	R4, SP, #22
MOVS	R2, #7
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_BW_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_BW_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor315
;DriverRF4463PROMain.c,269 :: 		ulArgument = StrToInt( ucLongArgument );
ADD	R4, SP, #54
MOV	R0, R4
BL	_StrToInt+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,271 :: 		if ( ulArgument == 250 || ulArgument == 500 ) {
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #250
IT	EQ
BEQ	L__vRF4463MainCommandProcessor474
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #500
IT	EQ
BEQ	L__vRF4463MainCommandProcessor474
IT	AL
BAL	L_vRF4463MainCommandProcessor318
L__vRF4463MainCommandProcessor474:
;DriverRF4463PROMain.c,272 :: 		ulRF4463Step = ulArgument;
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ulRF4463Step+0)
MOVT	R0, #hi_addr(_ulRF4463Step+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,273 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,274 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,275 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor319
L_vRF4463MainCommandProcessor318:
;DriverRF4463PROMain.c,277 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,278 :: 		}
L_vRF4463MainCommandProcessor319:
;DriverRF4463PROMain.c,279 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor320
L_vRF4463MainCommandProcessor315:
;DriverRF4463PROMain.c,286 :: 		else if ( memcmp( CMD_RADIO_MODE_SET, ucCommand, sizeof( CMD_RADIO_MODE_SET ) ) == 0x00 ) {
ADD	R4, SP, #22
MOVS	R2, #9
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_MODE_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MODE_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor321
;DriverRF4463PROMain.c,288 :: 		ucCounterCommand = 0;
MOVS	R0, #0
STRB	R0, [SP, #119]
;DriverRF4463PROMain.c,290 :: 		while ( ucLongArgument[ ucCounterCommand ] != ucUSARTNull && ucCounterCommand < 32 ) {
L_vRF4463MainCommandProcessor322:
ADD	R1, SP, #54
LDRB	R0, [SP, #119]
ADDS	R0, R1, R0
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucUSARTNull+0)
MOVT	R0, #hi_addr(_ucUSARTNull+0)
LDRB	R0, [R0, #0]
CMP	R1, R0
IT	EQ
BEQ	L_vRF4463MainCommandProcessor323
LDRB	R0, [SP, #119]
CMP	R0, #32
IT	CS
BCS	L_vRF4463MainCommandProcessor323
L__vRF4463MainCommandProcessor473:
;DriverRF4463PROMain.c,291 :: 		ucLongArgument[ ucCounterCommand ] = toupper( ucLongArgument[ ucCounterCommand ] );
ADD	R1, SP, #54
LDRB	R0, [SP, #119]
ADDS	R0, R1, R0
STR	R0, [SP, #188]
ADD	R1, SP, #54
LDRB	R0, [SP, #119]
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
UXTB	R4, R0
UXTB	R0, R4
BL	_toupper+0
LDR	R1, [SP, #188]
STRB	R0, [R1, #0]
;DriverRF4463PROMain.c,292 :: 		ucCounterCommand++;
LDRB	R0, [SP, #119]
ADDS	R0, R0, #1
STRB	R0, [SP, #119]
;DriverRF4463PROMain.c,293 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor322
L_vRF4463MainCommandProcessor323:
;DriverRF4463PROMain.c,296 :: 		if ( memcmp( ARG_RADIO_MODE_STBY, ucLongArgument, sizeof( ARG_RADIO_MODE_STBY ) ) == 0x00 ) {
ADD	R4, SP, #54
MOVS	R2, #5
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_STBY+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_STBY+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor326
;DriverRF4463PROMain.c,297 :: 		ucRF4463Mode = rf_off;
MOVS	R1, #4
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,298 :: 		vUSART1Start_TX( ANS_COMMAND_MODE_STBY, strlen( ANS_COMMAND_MODE_STBY ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_STBY+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_STBY+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_STBY+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_STBY+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,299 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor327
L_vRF4463MainCommandProcessor326:
;DriverRF4463PROMain.c,300 :: 		else if ( memcmp( ARG_RADIO_MODE_TX_CONT, ucLongArgument, sizeof( ARG_RADIO_MODE_TX_CONT ) ) == 0x00 ) {
ADD	R4, SP, #54
MOVS	R2, #8
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_TX_CONT+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_TX_CONT+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor328
;DriverRF4463PROMain.c,301 :: 		ucRF4463Mode = tx_test_mode;
MOVS	R1, #2
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,302 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,303 :: 		vUSART1Start_TX( ANS_COMMAND_MODE_TX_CONT, strlen( ANS_COMMAND_MODE_TX_CONT ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_CONT+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_CONT+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,304 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor329
L_vRF4463MainCommandProcessor328:
;DriverRF4463PROMain.c,305 :: 		else if ( memcmp( ARG_RADIO_MODE_RX_CONT, ucLongArgument, sizeof( ARG_RADIO_MODE_RX_CONT ) ) == 0x00 ) {
ADD	R4, SP, #54
MOVS	R2, #8
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_RX_CONT+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_RX_CONT+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor330
;DriverRF4463PROMain.c,306 :: 		ucRF4463Mode = rx_test_mode;
MOVS	R1, #3
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,307 :: 		vUSART1Start_TX( ANS_COMMAND_MODE_RX_CONT, strlen( ANS_COMMAND_MODE_RX_CONT ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_CONT+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_CONT+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,308 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor331
L_vRF4463MainCommandProcessor330:
;DriverRF4463PROMain.c,309 :: 		else if ( memcmp( ARG_RADIO_MODE_TX_MASTER, ucLongArgument, sizeof( ARG_RADIO_MODE_TX_MASTER ) ) == 0x00 ) {
ADD	R4, SP, #54
MOVS	R2, #10
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_TX_MASTER+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_TX_MASTER+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor332
;DriverRF4463PROMain.c,310 :: 		ucRF4463Mode = master_mode;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,311 :: 		vUSART1Start_TX( ANS_COMMAND_MODE_TX_MASTER, strlen( ANS_COMMAND_MODE_TX_MASTER ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,312 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor333
L_vRF4463MainCommandProcessor332:
;DriverRF4463PROMain.c,313 :: 		else if ( memcmp( ARG_RADIO_MODE_RX_SLAVE, ucLongArgument, sizeof( ARG_RADIO_MODE_RX_SLAVE ) ) == 0x00 ) {
ADD	R4, SP, #54
MOVS	R2, #9
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_RX_SLAVE+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_RX_SLAVE+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor334
;DriverRF4463PROMain.c,314 :: 		ucRF4463Mode = slave_mode;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,315 :: 		vUSART1Start_TX( ANS_COMMAND_MODE_RX_SLAVE, strlen( ANS_COMMAND_MODE_RX_SLAVE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,316 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor335
L_vRF4463MainCommandProcessor334:
;DriverRF4463PROMain.c,318 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,319 :: 		}
L_vRF4463MainCommandProcessor335:
L_vRF4463MainCommandProcessor333:
L_vRF4463MainCommandProcessor331:
L_vRF4463MainCommandProcessor329:
L_vRF4463MainCommandProcessor327:
;DriverRF4463PROMain.c,320 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor336
L_vRF4463MainCommandProcessor321:
;DriverRF4463PROMain.c,325 :: 		else if ( memcmp( CMD_RADIO_PACKET_SEND, ucCommand, sizeof( CMD_RADIO_PACKET_SEND ) ) == 0x00 ) {
ADD	R4, SP, #22
MOVS	R2, #12
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_PACKET_SEND+0)
MOVT	R0, #hi_addr(_CMD_RADIO_PACKET_SEND+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor337
;DriverRF4463PROMain.c,327 :: 		if ( ucRF4463Mode == rf_off ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_vRF4463MainCommandProcessor338
;DriverRF4463PROMain.c,328 :: 		vUSARTStartMEMtoMEMZero( ucRF4463TXdata, sizeof( ucRF4463TXdata ));
MOVS	R0, #66
PUSH	(R0)
MOVW	R0, #lo_addr(_ucRF4463TXdata+0)
MOVT	R0, #hi_addr(_ucRF4463TXdata+0)
PUSH	(R0)
BL	_vUSARTStartMEMtoMEMZero+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,329 :: 		vRF4463MainSetTXString();
BL	_vRF4463MainSetTXString+0
;DriverRF4463PROMain.c,330 :: 		ucLongArgument[ ucCounterLongArgument++ ] = ucRF4463ChecksumGenerator( ucLongArgument, ucCounterLongArgument );
ADD	R1, SP, #54
LDRB	R0, [SP, #120]
ADDS	R0, R1, R0
STR	R0, [SP, #188]
LDRB	R0, [SP, #120]
PUSH	(R0)
ADD	R0, SP, #58
PUSH	(R0)
BL	_ucRF4463ChecksumGenerator+0
ADD	SP, SP, #8
LDR	R1, [SP, #188]
STRB	R0, [R1, #0]
LDRB	R0, [SP, #120]
ADDS	R0, R0, #1
STRB	R0, [SP, #120]
;DriverRF4463PROMain.c,331 :: 		vUSARTStartMEMtoMEM( ucLongArgument, ucRF4463TXdata + 4, ucCounterLongArgument );
LDRB	R0, [SP, #120]
PUSH	(R0)
MOVW	R0, #lo_addr(_ucRF4463TXdata+4)
MOVT	R0, #hi_addr(_ucRF4463TXdata+4)
PUSH	(R0)
ADD	R0, SP, #62
PUSH	(R0)
BL	_vUSARTStartMEMtoMEM+0
ADD	SP, SP, #12
;DriverRF4463PROMain.c,333 :: 		ucRF4463SendMessage = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463SendMessage+0)
MOVT	R0, #hi_addr(_ucRF4463SendMessage+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,335 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor339
L_vRF4463MainCommandProcessor338:
;DriverRF4463PROMain.c,337 :: 		vUSART1Start_TX( ANS_COMMAND_WRONG_MODE, strlen( ANS_COMMAND_WRONG_MODE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_WRONG_MODE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_WRONG_MODE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_WRONG_MODE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_WRONG_MODE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,338 :: 		}
L_vRF4463MainCommandProcessor339:
;DriverRF4463PROMain.c,339 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor340
L_vRF4463MainCommandProcessor337:
;DriverRF4463PROMain.c,344 :: 		else if ( memcmp( CMD_RADIO_GET_STATUS, ucCommand, sizeof( CMD_RADIO_GET_STATUS ) ) == 0x00 ) {
ADD	R4, SP, #22
MOVS	R2, #11
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_GET_STATUS+0)
MOVT	R0, #hi_addr(_CMD_RADIO_GET_STATUS+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor341
;DriverRF4463PROMain.c,345 :: 		vUSART1Start_TX( ANS_STATUS_REPORT, strlen( ANS_STATUS_REPORT ) );
MOVW	R0, #lo_addr(_ANS_STATUS_REPORT+0)
MOVT	R0, #hi_addr(_ANS_STATUS_REPORT+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_STATUS_REPORT+0)
MOVT	R0, #hi_addr(_ANS_STATUS_REPORT+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,348 :: 		sprintf( ucTXT, "[ STATUS ] DECIMAL POWER: %d\r\n" , ucRF4463Power );
MOVW	R0, #lo_addr(_ucRF4463Power+0)
MOVT	R0, #hi_addr(_ucRF4463Power+0)
LDRB	R0, [R0, #0]
PUSH	(R0)
MOVW	R0, #lo_addr(?lstr_3_DriverRF4463PROMain+0)
MOVT	R0, #hi_addr(?lstr_3_DriverRF4463PROMain+0)
PUSH	(R0)
ADD	R0, SP, #129
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;DriverRF4463PROMain.c,349 :: 		vUSART1Start_TX( ucTXT, strlen( ucTXT ) );
ADD	R4, SP, #121
MOV	R0, R4
BL	_strlen+0
PUSH	(R0)
ADD	R0, SP, #125
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,352 :: 		ulArgument = ( ( ucRF4463Freq3 * 100 ) + ( ucRF4463Freq2 * 10 ) + ucRF4463Freq1 ) * 1000UL;
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
ADDS	R1, R1, R0
SXTH	R1, R1
MOV	R0, #1000
MULS	R1, R0, R1
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,353 :: 		sprintf( ucTXT, "[ STATUS ] BAND: %lu KHz\r\n" , ulArgument );
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
PUSH	(R0)
MOVW	R0, #lo_addr(?lstr_4_DriverRF4463PROMain+0)
MOVT	R0, #hi_addr(?lstr_4_DriverRF4463PROMain+0)
PUSH	(R0)
ADD	R0, SP, #129
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;DriverRF4463PROMain.c,354 :: 		vUSART1Start_TX( ucTXT, strlen( ucTXT ) );
ADD	R4, SP, #121
MOV	R0, R4
BL	_strlen+0
PUSH	(R0)
ADD	R0, SP, #125
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,357 :: 		switch ( ucRF4463Rate ) {
IT	AL
BAL	L_vRF4463MainCommandProcessor342
;DriverRF4463PROMain.c,358 :: 		case dr_1p2    : ulArgument = 1200;
L_vRF4463MainCommandProcessor344:
MOVW	R1, #1200
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,359 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor343
;DriverRF4463PROMain.c,360 :: 		case dr_2p4    : ulArgument = 2400;
L_vRF4463MainCommandProcessor345:
MOVW	R1, #2400
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,361 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor343
;DriverRF4463PROMain.c,362 :: 		case dr_4p8    : ulArgument = 4800;
L_vRF4463MainCommandProcessor346:
MOVW	R1, #4800
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,363 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor343
;DriverRF4463PROMain.c,364 :: 		case dr_9p6    : ulArgument = 9600;
L_vRF4463MainCommandProcessor347:
MOVW	R1, #9600
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,365 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor343
;DriverRF4463PROMain.c,366 :: 		case dr_19p2   : ulArgument = 19200;
L_vRF4463MainCommandProcessor348:
MOVW	R1, #19200
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,367 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor343
;DriverRF4463PROMain.c,368 :: 		case dr_38p4   : ulArgument = 38400;
L_vRF4463MainCommandProcessor349:
MOVW	R1, #38400
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,369 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor343
;DriverRF4463PROMain.c,370 :: 		case dr_76p8   : ulArgument = 76800;
L_vRF4463MainCommandProcessor350:
MOV	R1, #76800
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,371 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor343
;DriverRF4463PROMain.c,372 :: 		case dr_115p2  : ulArgument = 115200;
L_vRF4463MainCommandProcessor351:
MOV	R1, #115200
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,373 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor343
;DriverRF4463PROMain.c,374 :: 		case dr_256k   : ulArgument = 256000;
L_vRF4463MainCommandProcessor352:
MOV	R1, #256000
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,375 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor343
;DriverRF4463PROMain.c,376 :: 		case dr_500k   : ulArgument = 500000;
L_vRF4463MainCommandProcessor353:
MOVW	R1, #41248
MOVT	R1, #7
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,377 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor343
;DriverRF4463PROMain.c,378 :: 		case dr_500    : ulArgument = 500;
L_vRF4463MainCommandProcessor354:
MOVW	R1, #500
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,379 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor343
;DriverRF4463PROMain.c,380 :: 		}
L_vRF4463MainCommandProcessor342:
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463MainCommandProcessor344
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_vRF4463MainCommandProcessor345
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_vRF4463MainCommandProcessor346
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_vRF4463MainCommandProcessor347
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	EQ
BEQ	L_vRF4463MainCommandProcessor348
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	EQ
BEQ	L_vRF4463MainCommandProcessor349
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #6
IT	EQ
BEQ	L_vRF4463MainCommandProcessor350
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	EQ
BEQ	L_vRF4463MainCommandProcessor351
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	EQ
BEQ	L_vRF4463MainCommandProcessor352
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #9
IT	EQ
BEQ	L_vRF4463MainCommandProcessor353
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	EQ
BEQ	L_vRF4463MainCommandProcessor354
L_vRF4463MainCommandProcessor343:
;DriverRF4463PROMain.c,381 :: 		sprintf( ucTXT, "[ STATUS ] DATA RATE: %lu\r\n" , ulArgument );
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
PUSH	(R0)
MOVW	R0, #lo_addr(?lstr_5_DriverRF4463PROMain+0)
MOVT	R0, #hi_addr(?lstr_5_DriverRF4463PROMain+0)
PUSH	(R0)
ADD	R0, SP, #129
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;DriverRF4463PROMain.c,382 :: 		vUSART1Start_TX( ucTXT, strlen( ucTXT ) );
ADD	R4, SP, #121
MOV	R0, R4
BL	_strlen+0
PUSH	(R0)
ADD	R0, SP, #125
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,385 :: 		sprintf( ucTXT, "[ STATUS ] CHANNEL: %d\r\n" , ucRF4463FreqChannel );
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
LDRB	R0, [R0, #0]
PUSH	(R0)
MOVW	R0, #lo_addr(?lstr_6_DriverRF4463PROMain+0)
MOVT	R0, #hi_addr(?lstr_6_DriverRF4463PROMain+0)
PUSH	(R0)
ADD	R0, SP, #129
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;DriverRF4463PROMain.c,386 :: 		vUSART1Start_TX( ucTXT, strlen( ucTXT ) );
ADD	R4, SP, #121
MOV	R0, R4
BL	_strlen+0
PUSH	(R0)
ADD	R0, SP, #125
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,389 :: 		sprintf( ucTXT, "[ STATUS ] BW: %lu KHz\r\n" , ulRF4463Step );
MOVW	R0, #lo_addr(_ulRF4463Step+0)
MOVT	R0, #hi_addr(_ulRF4463Step+0)
LDR	R0, [R0, #0]
PUSH	(R0)
MOVW	R0, #lo_addr(?lstr_7_DriverRF4463PROMain+0)
MOVT	R0, #hi_addr(?lstr_7_DriverRF4463PROMain+0)
PUSH	(R0)
ADD	R0, SP, #129
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;DriverRF4463PROMain.c,390 :: 		vUSART1Start_TX( ucTXT, strlen( ucTXT ) );
ADD	R4, SP, #121
MOV	R0, R4
BL	_strlen+0
PUSH	(R0)
ADD	R0, SP, #125
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,394 :: 		vUSART1Start_TX( "[ STATUS ] MODE: ", 17 );
MOVS	R0, #17
PUSH	(R0)
ADD	R11, SP, #8
ADD	R10, R11, #18
MOVW	R12, #lo_addr(?ICS?lstr8_DriverRF4463PROMain+0)
MOVT	R12, #hi_addr(?ICS?lstr8_DriverRF4463PROMain+0)
BL	___CC2DW+0
ADD	R0, SP, #8
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,396 :: 		switch ( ucRF4463Mode ) {
IT	AL
BAL	L_vRF4463MainCommandProcessor355
;DriverRF4463PROMain.c,397 :: 		case rf_off        : vUSART1Start_TX( ANS_COMMAND_MODE_STBY, strlen( ANS_COMMAND_MODE_STBY ) );
L_vRF4463MainCommandProcessor357:
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_STBY+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_STBY+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_STBY+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_STBY+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,398 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor356
;DriverRF4463PROMain.c,399 :: 		case tx_test_mode  : vUSART1Start_TX( ANS_COMMAND_MODE_TX_CONT, strlen( ANS_COMMAND_MODE_TX_CONT ) );
L_vRF4463MainCommandProcessor358:
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_CONT+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_CONT+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,400 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor356
;DriverRF4463PROMain.c,401 :: 		case rx_test_mode  : vUSART1Start_TX( ANS_COMMAND_MODE_RX_CONT, strlen( ANS_COMMAND_MODE_RX_CONT ) );
L_vRF4463MainCommandProcessor359:
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_CONT+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_CONT+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,402 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor356
;DriverRF4463PROMain.c,403 :: 		case master_mode   : vUSART1Start_TX( ANS_COMMAND_MODE_TX_MASTER, strlen( ANS_COMMAND_MODE_TX_MASTER ) );
L_vRF4463MainCommandProcessor360:
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,404 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor356
;DriverRF4463PROMain.c,405 :: 		case slave_mode    : vUSART1Start_TX( ANS_COMMAND_MODE_RX_SLAVE, strlen( ANS_COMMAND_MODE_RX_SLAVE ) );
L_vRF4463MainCommandProcessor361:
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,406 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor356
;DriverRF4463PROMain.c,407 :: 		}
L_vRF4463MainCommandProcessor355:
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	EQ
BEQ	L_vRF4463MainCommandProcessor357
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_vRF4463MainCommandProcessor358
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_vRF4463MainCommandProcessor359
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463MainCommandProcessor360
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_vRF4463MainCommandProcessor361
L_vRF4463MainCommandProcessor356:
;DriverRF4463PROMain.c,408 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor362
L_vRF4463MainCommandProcessor341:
;DriverRF4463PROMain.c,412 :: 		else if ( memcmp( CMD_RADIO_MATCH_BYTE_1_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_1_SET ) ) == 0x00 ) {
ADD	R4, SP, #22
MOVS	R2, #12
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_BYTE_1_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_BYTE_1_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor363
;DriverRF4463PROMain.c,413 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R4, SP, #54
MOV	R0, R4
BL	_StrToLong+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,414 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	CC
BCC	L_vRF4463MainCommandProcessor366
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #255
IT	HI
BHI	L_vRF4463MainCommandProcessor366
L__vRF4463MainCommandProcessor472:
;DriverRF4463PROMain.c,415 :: 		ucRF4463ByteMatch1 = ulArgument;
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucRF4463ByteMatch1+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch1+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,416 :: 		ucRF4463MatchEnabled = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,417 :: 		ucRF4463MatchEnableReg = 0x40;
MOVS	R1, #64
MOVW	R0, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,418 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,419 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,420 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor367
L_vRF4463MainCommandProcessor366:
;DriverRF4463PROMain.c,422 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,423 :: 		}
L_vRF4463MainCommandProcessor367:
;DriverRF4463PROMain.c,424 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor368
L_vRF4463MainCommandProcessor363:
;DriverRF4463PROMain.c,428 :: 		else if ( memcmp( CMD_RADIO_MATCH_BYTE_2_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_2_SET ) ) == 0x00 ) {
ADD	R4, SP, #22
MOVS	R2, #12
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_BYTE_2_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_BYTE_2_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor369
;DriverRF4463PROMain.c,429 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R4, SP, #54
MOV	R0, R4
BL	_StrToLong+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,430 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	CC
BCC	L_vRF4463MainCommandProcessor372
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #255
IT	HI
BHI	L_vRF4463MainCommandProcessor372
L__vRF4463MainCommandProcessor471:
;DriverRF4463PROMain.c,431 :: 		ucRF4463ByteMatch2 = ulArgument;
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucRF4463ByteMatch2+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch2+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,432 :: 		ucRF4463MatchEnabled = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,433 :: 		ucRF4463MatchEnableReg = 0x40;
MOVS	R1, #64
MOVW	R0, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,434 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,435 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,436 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor373
L_vRF4463MainCommandProcessor372:
;DriverRF4463PROMain.c,438 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,439 :: 		}
L_vRF4463MainCommandProcessor373:
;DriverRF4463PROMain.c,440 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor374
L_vRF4463MainCommandProcessor369:
;DriverRF4463PROMain.c,444 :: 		else if ( memcmp( CMD_RADIO_MATCH_BYTE_3_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_3_SET ) ) == 0x00 ) {
ADD	R4, SP, #22
MOVS	R2, #12
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_BYTE_3_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_BYTE_3_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor375
;DriverRF4463PROMain.c,445 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R4, SP, #54
MOV	R0, R4
BL	_StrToLong+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,446 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	CC
BCC	L_vRF4463MainCommandProcessor378
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #255
IT	HI
BHI	L_vRF4463MainCommandProcessor378
L__vRF4463MainCommandProcessor470:
;DriverRF4463PROMain.c,447 :: 		ucRF4463ByteMatch3 = ulArgument;
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucRF4463ByteMatch3+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch3+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,448 :: 		ucRF4463MatchEnabled = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,449 :: 		ucRF4463MatchEnableReg = 0x40;
MOVS	R1, #64
MOVW	R0, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,450 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,451 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,452 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor379
L_vRF4463MainCommandProcessor378:
;DriverRF4463PROMain.c,454 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,455 :: 		}
L_vRF4463MainCommandProcessor379:
;DriverRF4463PROMain.c,456 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor380
L_vRF4463MainCommandProcessor375:
;DriverRF4463PROMain.c,460 :: 		else if ( memcmp( CMD_RADIO_MATCH_BYTE_4_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_4_SET ) ) == 0x00 ) {
ADD	R4, SP, #22
MOVS	R2, #12
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_BYTE_4_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_BYTE_4_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor381
;DriverRF4463PROMain.c,461 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R4, SP, #54
MOV	R0, R4
BL	_StrToLong+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,462 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	CC
BCC	L_vRF4463MainCommandProcessor384
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #255
IT	HI
BHI	L_vRF4463MainCommandProcessor384
L__vRF4463MainCommandProcessor469:
;DriverRF4463PROMain.c,463 :: 		ucRF4463ByteMatch4 = ulArgument;
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucRF4463ByteMatch4+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch4+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,464 :: 		ucRF4463MatchEnabled = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,465 :: 		ucRF4463MatchEnableReg = 0x40;
MOVS	R1, #64
MOVW	R0, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,466 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,467 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,468 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor385
L_vRF4463MainCommandProcessor384:
;DriverRF4463PROMain.c,470 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,471 :: 		}
L_vRF4463MainCommandProcessor385:
;DriverRF4463PROMain.c,472 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor386
L_vRF4463MainCommandProcessor381:
;DriverRF4463PROMain.c,476 :: 		else if ( memcmp( CMD_RADIO_MATCH_MASK_1_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_1_SET ) ) == 0x00 ) {
ADD	R4, SP, #22
MOVS	R2, #11
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_MASK_1_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_MASK_1_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor387
;DriverRF4463PROMain.c,477 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R4, SP, #54
MOV	R0, R4
BL	_StrToLong+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,478 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	CC
BCC	L_vRF4463MainCommandProcessor390
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #255
IT	HI
BHI	L_vRF4463MainCommandProcessor390
L__vRF4463MainCommandProcessor468:
;DriverRF4463PROMain.c,479 :: 		ucRF4463ByteMask1 = ulArgument;
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucRF4463ByteMask1+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask1+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,480 :: 		ucRF4463MatchEnabled = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,481 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,482 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,483 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor391
L_vRF4463MainCommandProcessor390:
;DriverRF4463PROMain.c,485 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,486 :: 		}
L_vRF4463MainCommandProcessor391:
;DriverRF4463PROMain.c,487 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor392
L_vRF4463MainCommandProcessor387:
;DriverRF4463PROMain.c,491 :: 		else if ( memcmp( CMD_RADIO_MATCH_MASK_2_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_2_SET ) ) == 0x00 ) {
ADD	R4, SP, #22
MOVS	R2, #11
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_MASK_2_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_MASK_2_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor393
;DriverRF4463PROMain.c,492 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R4, SP, #54
MOV	R0, R4
BL	_StrToLong+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,493 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	CC
BCC	L_vRF4463MainCommandProcessor396
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #255
IT	HI
BHI	L_vRF4463MainCommandProcessor396
L__vRF4463MainCommandProcessor467:
;DriverRF4463PROMain.c,494 :: 		ucRF4463ByteMask2 = ulArgument;
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucRF4463ByteMask2+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask2+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,495 :: 		ucRF4463MatchEnabled = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,496 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,497 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,498 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor397
L_vRF4463MainCommandProcessor396:
;DriverRF4463PROMain.c,500 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,501 :: 		}
L_vRF4463MainCommandProcessor397:
;DriverRF4463PROMain.c,502 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor398
L_vRF4463MainCommandProcessor393:
;DriverRF4463PROMain.c,506 :: 		else if ( memcmp( CMD_RADIO_MATCH_MASK_3_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_3_SET ) ) == 0x00 ) {
ADD	R4, SP, #22
MOVS	R2, #11
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_MASK_3_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_MASK_3_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor399
;DriverRF4463PROMain.c,507 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R4, SP, #54
MOV	R0, R4
BL	_StrToLong+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,508 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	CC
BCC	L_vRF4463MainCommandProcessor402
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #255
IT	HI
BHI	L_vRF4463MainCommandProcessor402
L__vRF4463MainCommandProcessor466:
;DriverRF4463PROMain.c,509 :: 		ucRF4463ByteMask3 = ulArgument;
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucRF4463ByteMask3+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask3+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,510 :: 		ucRF4463MatchEnabled = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,511 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,512 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,513 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor403
L_vRF4463MainCommandProcessor402:
;DriverRF4463PROMain.c,515 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,516 :: 		}
L_vRF4463MainCommandProcessor403:
;DriverRF4463PROMain.c,517 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor404
L_vRF4463MainCommandProcessor399:
;DriverRF4463PROMain.c,521 :: 		else if ( memcmp( CMD_RADIO_MATCH_MASK_4_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_4_SET ) ) == 0x00 ) {
ADD	R4, SP, #22
MOVS	R2, #11
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_MASK_4_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_MASK_4_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor405
;DriverRF4463PROMain.c,522 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R4, SP, #54
MOV	R0, R4
BL	_StrToLong+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,523 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	CC
BCC	L_vRF4463MainCommandProcessor408
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R0, [R0, #0]
CMP	R0, #255
IT	HI
BHI	L_vRF4463MainCommandProcessor408
L__vRF4463MainCommandProcessor465:
;DriverRF4463PROMain.c,524 :: 		ucRF4463ByteMask4 = ulArgument;
MOVW	R0, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R0, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucRF4463ByteMask4+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask4+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,525 :: 		ucRF4463MatchEnabled = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,526 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,527 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,528 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor409
L_vRF4463MainCommandProcessor408:
;DriverRF4463PROMain.c,530 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,531 :: 		}
L_vRF4463MainCommandProcessor409:
;DriverRF4463PROMain.c,532 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor410
L_vRF4463MainCommandProcessor405:
;DriverRF4463PROMain.c,536 :: 		else if ( memcmp( CMD_RADIO_MATCH_UNSET, ucCommand, sizeof( CMD_RADIO_MATCH_UNSET ) ) == 0x00 ) {
ADD	R4, SP, #22
MOVS	R2, #12
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_UNSET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_UNSET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor411
;DriverRF4463PROMain.c,538 :: 		ucRF4463MatchEnableReg = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,539 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,540 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,545 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor412
L_vRF4463MainCommandProcessor411:
;DriverRF4463PROMain.c,549 :: 		vUSART1Start_TX( ANS_DEBUG_COMMAND_UNKNOWN, strlen( ANS_DEBUG_COMMAND_UNKNOWN ) );
MOVW	R0, #lo_addr(_ANS_DEBUG_COMMAND_UNKNOWN+0)
MOVT	R0, #hi_addr(_ANS_DEBUG_COMMAND_UNKNOWN+0)
BL	_strlen+0
PUSH	(R0)
MOVW	R0, #lo_addr(_ANS_DEBUG_COMMAND_UNKNOWN+0)
MOVT	R0, #hi_addr(_ANS_DEBUG_COMMAND_UNKNOWN+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,550 :: 		vUSART1Start_TX( ucBuffer, strlen( ucBuffer ) );  // DEPURACION
LDR	R0, [SP, #192]
BL	_strlen+0
PUSH	(R0)
LDR	R0, [SP, #196]
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,551 :: 		}
L_vRF4463MainCommandProcessor412:
L_vRF4463MainCommandProcessor410:
L_vRF4463MainCommandProcessor404:
L_vRF4463MainCommandProcessor398:
L_vRF4463MainCommandProcessor392:
L_vRF4463MainCommandProcessor386:
L_vRF4463MainCommandProcessor380:
L_vRF4463MainCommandProcessor374:
L_vRF4463MainCommandProcessor368:
L_vRF4463MainCommandProcessor362:
L_vRF4463MainCommandProcessor340:
L_vRF4463MainCommandProcessor336:
L_vRF4463MainCommandProcessor320:
L_vRF4463MainCommandProcessor314:
L_vRF4463MainCommandProcessor308:
L_vRF4463MainCommandProcessor292:
L_vRF4463MainCommandProcessor286:
;DriverRF4463PROMain.c,552 :: 		}
L_end_vRF4463MainCommandProcessor:
LDR	LR, [SP, #0]
ADD	SP, SP, #192
BX	LR
; end of _vRF4463MainCommandProcessor
_InitTimer2:
;DriverRF4463PROMain.c,558 :: 		void InitTimer2(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;DriverRF4463PROMain.c,560 :: 		RCC_APB1ENR.TIM2EN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
_SX	[R0, ByteOffset(RCC_APB1ENR+0)]
;DriverRF4463PROMain.c,561 :: 		TIM2_CR1.CEN = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
_SX	[R0, ByteOffset(TIM2_CR1+0)]
;DriverRF4463PROMain.c,562 :: 		TIM2_PSC = 1124;
MOVW	R1, #1124
MOVW	R0, #lo_addr(TIM2_PSC+0)
MOVT	R0, #hi_addr(TIM2_PSC+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,563 :: 		TIM2_ARR = 63999;
MOVW	R1, #63999
MOVW	R0, #lo_addr(TIM2_ARR+0)
MOVT	R0, #hi_addr(TIM2_ARR+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,564 :: 		NVIC_IntEnable( IVT_INT_TIM2 );
MOVW	R0, #44
BL	_NVIC_IntEnable+0
;DriverRF4463PROMain.c,565 :: 		TIM2_DIER.UIE = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
_SX	[R0, ByteOffset(TIM2_DIER+0)]
;DriverRF4463PROMain.c,566 :: 		TIM2_CR1.CEN = 1;
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
_SX	[R0, ByteOffset(TIM2_CR1+0)]
;DriverRF4463PROMain.c,578 :: 		}
L_end_InitTimer2:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _InitTimer2
_main:
;DriverRF4463PROMain.c,582 :: 		void main() {
SUB	SP, SP, #56
;DriverRF4463PROMain.c,586 :: 		Delay_ms( 2000 );                    // delay de depuracion
MOVW	R7, #64510
MOVT	R7, #1708
NOP
NOP
L_main413:
SUBS	R7, R7, #1
BNE	L_main413
NOP
NOP
NOP
;DriverRF4463PROMain.c,663 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_6 );
MOVW	R1, #64
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,664 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_7 );
MOVW	R1, #128
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,665 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_8 );
MOVW	R1, #256
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,670 :: 		GPIO_Digital_Input( &GPIOD_BASE, _GPIO_PINMASK_10 );          // nIRQ
MOVW	R1, #1024
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Input+0
;DriverRF4463PROMain.c,672 :: 		GPIO_Digital_Output( &GPIOD_BASE, _GPIO_PINMASK_13 );         // nSEL
MOVW	R1, #8192
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,673 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_2 );          // SDN
MOVW	R1, #4
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,688 :: 		EXTI_IMR.B10    |= 1;
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
_LX	[R0, ByteOffset(EXTI_IMR+0)]
ORR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
_SX	[R0, ByteOffset(EXTI_IMR+0)]
;DriverRF4463PROMain.c,689 :: 		EXTI_FTSR.B10   |= 1;
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
_LX	[R0, ByteOffset(EXTI_FTSR+0)]
ORR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
_SX	[R0, ByteOffset(EXTI_FTSR+0)]
;DriverRF4463PROMain.c,691 :: 		GPIO_Digital_Output( &GPIOE_BASE, _GPIO_PINMASK_14 );
MOVW	R1, #16384
MOVW	R0, #lo_addr(GPIOE_BASE+0)
MOVT	R0, #hi_addr(GPIOE_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,741 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;DriverRF4463PROMain.c,743 :: 		LED_RED      = 1;
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,744 :: 		LED_GREEN    = 1;
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,745 :: 		LED_BLUE     = 1;
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,747 :: 		Delay_ms( 100 );
MOVW	R7, #29438
MOVT	R7, #85
NOP
NOP
L_main415:
SUBS	R7, R7, #1
BNE	L_main415
NOP
NOP
NOP
;DriverRF4463PROMain.c,749 :: 		LED_RED      = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,750 :: 		LED_GREEN    = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,751 :: 		LED_BLUE     = 0;
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,753 :: 		InitTimer2();
BL	_InitTimer2+0
;DriverRF4463PROMain.c,756 :: 		vUSARTConfigUSART1( 115200 );  // configura todos las parametros de USART
MOV	R0, #115200
PUSH	(R0)
BL	_vUSARTConfigUSART1+0
ADD	SP, SP, #4
;DriverRF4463PROMain.c,768 :: 		vSPI3Init();           // configura todos los parametros de SPI
BL	_vSPI3Init+0
;DriverRF4463PROMain.c,778 :: 		ucRF4463Freq3 = 9;
MOVS	R1, #9
MOVW	R0, #lo_addr(_ucRF4463Freq3+0)
MOVT	R0, #hi_addr(_ucRF4463Freq3+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,779 :: 		ucRF4463Freq2 = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463Freq2+0)
MOVT	R0, #hi_addr(_ucRF4463Freq2+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,780 :: 		ucRF4463Freq1 = 5;
MOVS	R1, #5
MOVW	R0, #lo_addr(_ucRF4463Freq1+0)
MOVT	R0, #hi_addr(_ucRF4463Freq1+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,783 :: 		ucRF4463Power = 127;            // 34
MOVS	R1, #127
MOVW	R0, #lo_addr(_ucRF4463Power+0)
MOVT	R0, #hi_addr(_ucRF4463Power+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,785 :: 		ucRF4463Rate  = dr_1p2;                // BAUDRATE
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,787 :: 		ucRF4463Mode  = master_mode;          // para transmision continua usar: tx_test_mode
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,789 :: 		ucRF4463FreqChannel = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,793 :: 		reset_mode = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_reset_mode+0)
MOVT	R0, #hi_addr(_reset_mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,798 :: 		vRF4463MainSetTXString();    // usada para establecer el encabezdo predeterminado
BL	_vRF4463MainSetTXString+0
;DriverRF4463PROMain.c,799 :: 		VRF4463SDNReset();
BL	_VRF4463SDNReset+0
;DriverRF4463PROMain.c,800 :: 		vRF4463Init();
BL	_vRF4463Init+0
;DriverRF4463PROMain.c,801 :: 		vRF4463ClearInterrupts();
BL	_vRF4463ClearInterrupts+0
;DriverRF4463PROMain.c,802 :: 		vRF4463PartInfo ();          // SOLICITA EL MODELO DEL RADIO
BL	_vRF4463PartInfo+0
;DriverRF4463PROMain.c,804 :: 		LED_GREEN    = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,805 :: 		LED_BLUE     = 0;
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,810 :: 		vUSART1Start_TX( "[ SYS STM32F ]RF Radio ready\r\n", 30 );   // enviado por DMA
MOVS	R0, #30
PUSH	(R0)
ADD	R11, SP, #10
ADD	R10, R11, #31
MOVW	R12, #lo_addr(?ICS?lstr9_DriverRF4463PROMain+0)
MOVT	R12, #hi_addr(?ICS?lstr9_DriverRF4463PROMain+0)
BL	___CC2DW+0
ADD	R0, SP, #10
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,815 :: 		while ( 1 ) {
L_main417:
;DriverRF4463PROMain.c,818 :: 		if ( fUSART1Buffer == READY_TO_READ ) {
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main419
;DriverRF4463PROMain.c,819 :: 		vUSARTReceivedFromUSART1();
BL	_vUSARTReceivedFromUSART1+0
;DriverRF4463PROMain.c,820 :: 		}
L_main419:
;DriverRF4463PROMain.c,831 :: 		if ( ucRF4463Mode == master_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main420
;DriverRF4463PROMain.c,832 :: 		vRF4463TxData();
BL	_vRF4463TxData+0
;DriverRF4463PROMain.c,833 :: 		}
IT	AL
BAL	L_main421
L_main420:
;DriverRF4463PROMain.c,836 :: 		else if ( ucRF4463Mode == slave_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main422
;DriverRF4463PROMain.c,837 :: 		vRF4463RxInit();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,838 :: 		}
IT	AL
BAL	L_main423
L_main422:
;DriverRF4463PROMain.c,841 :: 		else if ( ucRF4463Mode == rf_off ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_main424
;DriverRF4463PROMain.c,842 :: 		vRF4463RxInit();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,843 :: 		while ( 1 ) {
L_main425:
;DriverRF4463PROMain.c,845 :: 		if ( fUSART1Buffer == READY_TO_READ ) {
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main427
;DriverRF4463PROMain.c,846 :: 		break;
IT	AL
BAL	L_main426
;DriverRF4463PROMain.c,847 :: 		}
L_main427:
;DriverRF4463PROMain.c,850 :: 		if ( ucRF4463SendMessage == 1 ) {
MOVW	R0, #lo_addr(_ucRF4463SendMessage+0)
MOVT	R0, #hi_addr(_ucRF4463SendMessage+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main428
;DriverRF4463PROMain.c,851 :: 		ucRF4463SendMessage = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucRF4463SendMessage+0)
MOVT	R0, #hi_addr(_ucRF4463SendMessage+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,852 :: 		vRF4463TxData();
BL	_vRF4463TxData+0
;DriverRF4463PROMain.c,853 :: 		}
L_main428:
;DriverRF4463PROMain.c,855 :: 		}
IT	AL
BAL	L_main425
L_main426:
;DriverRF4463PROMain.c,856 :: 		}
L_main424:
L_main423:
L_main421:
;DriverRF4463PROMain.c,859 :: 		if ( ucRF4463Mode == tx_test_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_main429
;DriverRF4463PROMain.c,860 :: 		vRF4463TxCont();
BL	_vRF4463TxCont+0
;DriverRF4463PROMain.c,861 :: 		while ( 1 ) {
L_main430:
;DriverRF4463PROMain.c,863 :: 		if ( fUSART1Buffer == READY_TO_READ ) {
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main432
;DriverRF4463PROMain.c,864 :: 		break;
IT	AL
BAL	L_main431
;DriverRF4463PROMain.c,865 :: 		}
L_main432:
;DriverRF4463PROMain.c,867 :: 		if ( !nIRQ ) {
MOVW	R0, #lo_addr(GPIOD_IDRbits+0)
MOVT	R0, #hi_addr(GPIOD_IDRbits+0)
_LX	[R0, ByteOffset(GPIOD_IDRbits+0)]
CMP	R0, #0
IT	NE
BNE	L_main433
;DriverRF4463PROMain.c,868 :: 		vRF4463TxCont();
BL	_vRF4463TxCont+0
;DriverRF4463PROMain.c,869 :: 		}
L_main433:
;DriverRF4463PROMain.c,870 :: 		}
IT	AL
BAL	L_main430
L_main431:
;DriverRF4463PROMain.c,871 :: 		}
L_main429:
;DriverRF4463PROMain.c,873 :: 		if ( ucRF4463Mode == rx_test_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BNE	L_main434
;DriverRF4463PROMain.c,874 :: 		vRF4463RxInit ();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,875 :: 		while ( 1 ) {
L_main435:
;DriverRF4463PROMain.c,877 :: 		if ( fUSART1Buffer == READY_TO_READ ) {
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main437
;DriverRF4463PROMain.c,878 :: 		break;
IT	AL
BAL	L_main436
;DriverRF4463PROMain.c,879 :: 		}
L_main437:
;DriverRF4463PROMain.c,882 :: 		}
IT	AL
BAL	L_main435
L_main436:
;DriverRF4463PROMain.c,883 :: 		}
L_main434:
;DriverRF4463PROMain.c,885 :: 		if ( reset_mode == 0 ) {
MOVW	R0, #lo_addr(_reset_mode+0)
MOVT	R0, #hi_addr(_reset_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main438
;DriverRF4463PROMain.c,887 :: 		while ( 1 ) {
L_main439:
;DriverRF4463PROMain.c,889 :: 		if ( fUSART1Buffer == READY_TO_READ ) {
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main441
;DriverRF4463PROMain.c,890 :: 		break;
IT	AL
BAL	L_main440
;DriverRF4463PROMain.c,891 :: 		}
L_main441:
;DriverRF4463PROMain.c,893 :: 		if ( Flag.reach_1s ) {
MOVW	R1, #lo_addr(_Flag+0)
MOVT	R1, #hi_addr(_Flag+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main442
;DriverRF4463PROMain.c,894 :: 		Flag.reach_1s = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,895 :: 		if ( ucRF4463Mode == master_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main443
;DriverRF4463PROMain.c,896 :: 		vRF4463TxData();
BL	_vRF4463TxData+0
;DriverRF4463PROMain.c,897 :: 		}
L_main443:
;DriverRF4463PROMain.c,898 :: 		}
L_main442:
;DriverRF4463PROMain.c,901 :: 		if ( !Flag.is_tx ) {
MOVW	R1, #lo_addr(_Flag+0)
MOVT	R1, #hi_addr(_Flag+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_main444
;DriverRF4463PROMain.c,902 :: 		if ( !nIRQ ) {          // !nIRQ
MOVW	R0, #lo_addr(GPIOD_IDRbits+0)
MOVT	R0, #hi_addr(GPIOD_IDRbits+0)
_LX	[R0, ByteOffset(GPIOD_IDRbits+0)]
CMP	R0, #0
IT	NE
BNE	L_main445
;DriverRF4463PROMain.c,903 :: 		vRF4463ClearInterrupts();
BL	_vRF4463ClearInterrupts+0
;DriverRF4463PROMain.c,905 :: 		if ( ( spi_read_buf[ 4 ] & 0x08) == 0 ) { // crc error check
MOVW	R0, #lo_addr(_spi_read_buf+4)
MOVT	R0, #hi_addr(_spi_read_buf+4)
LDRB	R0, [R0, #0]
AND	R0, R0, #8
UXTB	R0, R0
CMP	R0, #0
IT	NE
BNE	L_main446
;DriverRF4463PROMain.c,909 :: 		spi_read_fifo();
BL	_spi_read_fifo+0
;DriverRF4463PROMain.c,910 :: 		vRF4463FifoReset();
BL	_vRF4463FifoReset+0
;DriverRF4463PROMain.c,912 :: 		chksum = 0;
MOVS	R0, #0
STRB	R0, [SP, #5]
;DriverRF4463PROMain.c,913 :: 		for ( i = 4; i < payload_length - 1; i++ )                // Calculation Checksum
MOVS	R0, #4
STRB	R0, [SP, #4]
L_main447:
LDRB	R0, [SP, #4]
CMP	R0, #65
IT	GE
BGE	L_main448
;DriverRF4463PROMain.c,914 :: 		chksum += rx_buf[ i ];
LDRB	R1, [SP, #4]
MOVW	R0, #lo_addr(_rx_buf+0)
MOVT	R0, #hi_addr(_rx_buf+0)
ADDS	R0, R0, R1
LDRB	R1, [R0, #0]
LDRB	R0, [SP, #5]
ADDS	R0, R0, R1
STRB	R0, [SP, #5]
;DriverRF4463PROMain.c,913 :: 		for ( i = 4; i < payload_length - 1; i++ )                // Calculation Checksum
LDRB	R0, [SP, #4]
ADDS	R0, R0, #1
STRB	R0, [SP, #4]
;DriverRF4463PROMain.c,914 :: 		chksum += rx_buf[ i ];
IT	AL
BAL	L_main447
L_main448:
;DriverRF4463PROMain.c,916 :: 		if ( ( chksum == rx_buf[ payload_length - 1 ] )&&( rx_buf[ 4 ] == 0x41 )) {
MOVW	R0, #lo_addr(_rx_buf+65)
MOVT	R0, #hi_addr(_rx_buf+65)
LDRB	R1, [R0, #0]
LDRB	R0, [SP, #5]
CMP	R0, R1
IT	NE
BNE	L_main452
MOVW	R0, #lo_addr(_rx_buf+4)
MOVT	R0, #hi_addr(_rx_buf+4)
LDRB	R0, [R0, #0]
CMP	R0, #65
IT	NE
BNE	L_main452
L__main481:
;DriverRF4463PROMain.c,922 :: 		vUSART1Start_TX( rx_buf, payload_length );
MOVS	R0, #66
PUSH	(R0)
MOVW	R0, #lo_addr(_rx_buf+0)
MOVT	R0, #hi_addr(_rx_buf+0)
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,923 :: 		vUSART1Start_TX("\r\n", 2);
MOVS	R0, #2
PUSH	(R0)
MOVS	R0, #13
STRB	R0, [SP, #41]
MOVS	R0, #10
STRB	R0, [SP, #42]
MOVS	R0, #0
STRB	R0, [SP, #43]
ADD	R0, SP, #41
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,929 :: 		LED_GREEN ^= 1;                                        // Data received
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_LX	[R0, ByteOffset(GPIOC_ODRbits+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,930 :: 		rx_cnt++;
MOVW	R0, #lo_addr(_rx_cnt+0)
MOVT	R0, #hi_addr(_rx_cnt+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(_rx_cnt+0)
MOVT	R0, #hi_addr(_rx_cnt+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,936 :: 		}
IT	AL
BAL	L_main453
L_main452:
;DriverRF4463PROMain.c,938 :: 		vRF4463RxInit();    // The received data is wrong, you must continue to receive
BL	_vRF4463RxInit+0
L_main453:
;DriverRF4463PROMain.c,939 :: 		}
IT	AL
BAL	L_main454
L_main446:
;DriverRF4463PROMain.c,942 :: 		vUSART1Start_TX("[ CRC ] Fail\r\n", 14 );
MOVS	R0, #14
PUSH	(R0)
ADD	R11, SP, #44
ADD	R10, R11, #15
MOVW	R12, #lo_addr(?ICS?lstr11_DriverRF4463PROMain+0)
MOVT	R12, #hi_addr(?ICS?lstr11_DriverRF4463PROMain+0)
BL	___CC2DW+0
ADD	R0, SP, #44
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,943 :: 		VRF4463SDNReset();
BL	_VRF4463SDNReset+0
;DriverRF4463PROMain.c,944 :: 		vRF4463Init();
BL	_vRF4463Init+0
;DriverRF4463PROMain.c,945 :: 		vRF4463RxInit();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,946 :: 		}
L_main454:
;DriverRF4463PROMain.c,947 :: 		}
L_main445:
;DriverRF4463PROMain.c,948 :: 		}
L_main444:
;DriverRF4463PROMain.c,949 :: 		}
IT	AL
BAL	L_main439
L_main440:
;DriverRF4463PROMain.c,950 :: 		}
L_main438:
;DriverRF4463PROMain.c,951 :: 		}
IT	AL
BAL	L_main417
;DriverRF4463PROMain.c,952 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
