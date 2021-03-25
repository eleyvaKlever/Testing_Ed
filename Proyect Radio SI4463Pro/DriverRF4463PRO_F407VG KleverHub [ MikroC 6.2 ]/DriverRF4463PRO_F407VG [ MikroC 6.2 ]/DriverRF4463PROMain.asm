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
;driverspi.c,23 :: 		SPI1_Init_Advanced( _SPI_FPCLK_DIV2, _SPI_MASTER | _SPI_8_BIT | _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION |
MOVS	R0, #0
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
_vRF4463Init:
;driverrf4463pro.c,53 :: 		void vRF4463Init ( void ) {  // MODE,
SUB	SP, SP, #24
STR	LR, [SP, #0]
;driverrf4463pro.c,56 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init1:
; i start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_vRF4463Init2
;driverrf4463pro.c,57 :: 		RF_MODEM_MOD_TYPE_12_data[ i ] = RF_MODEM_MOD_TYPE_12[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_MOD_TYPE_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_MOD_TYPE_12_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
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
;driverrf4463pro.c,56 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,58 :: 		}
; i end address is: 12 (R3)
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
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init5:
; i start address is: 12 (R3)
CMP	R3, #12
IT	CS
BCS	L_vRF4463Init6
;driverrf4463pro.c,63 :: 		RF_MODEM_TX_RAMP_DELAY_8_data[ i ] = RF_MODEM_TX_RAMP_DELAY_8_433[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
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
;driverrf4463pro.c,62 :: 		for ( i = 4; i < 12; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,64 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init5
L_vRF4463Init6:
;driverrf4463pro.c,65 :: 		for ( i = 4; i < 11; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init8:
; i start address is: 12 (R3)
CMP	R3, #11
IT	CS
BCS	L_vRF4463Init9
;driverrf4463pro.c,66 :: 		RF_MODEM_AFC_GEAR_7_data[ i ] = RF_MODEM_AFC_GEAR_7_433[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_AFC_GEAR_7_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AFC_GEAR_7_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
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
;driverrf4463pro.c,65 :: 		for ( i = 4; i < 11; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,67 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init8
L_vRF4463Init9:
;driverrf4463pro.c,68 :: 		for ( i = 4; i < 15; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init11:
; i start address is: 12 (R3)
CMP	R3, #15
IT	CS
BCS	L_vRF4463Init12
;driverrf4463pro.c,69 :: 		RF_MODEM_OOK_CNT1_11_data[ i ] = RF_MODEM_OOK_CNT1_11_433[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_OOK_CNT1_11_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_OOK_CNT1_11_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
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
;driverrf4463pro.c,68 :: 		for ( i = 4; i < 15; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,70 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init11
L_vRF4463Init12:
;driverrf4463pro.c,71 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init14:
; i start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_vRF4463Init15
;driverrf4463pro.c,72 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
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
;driverrf4463pro.c,71 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,73 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init14
L_vRF4463Init15:
;driverrf4463pro.c,74 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init17:
; i start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_vRF4463Init18
;driverrf4463pro.c,75 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
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
;driverrf4463pro.c,74 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,76 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init17
L_vRF4463Init18:
;driverrf4463pro.c,77 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init20:
; i start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_vRF4463Init21
;driverrf4463pro.c,78 :: 		RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
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
;driverrf4463pro.c,77 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,79 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init20
L_vRF4463Init21:
;driverrf4463pro.c,80 :: 		for ( i = 4; i < 13; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init23:
; i start address is: 12 (R3)
CMP	R3, #13
IT	CS
BCS	L_vRF4463Init24
;driverrf4463pro.c,81 :: 		RF_MODEM_AGC_WINDOW_SIZE_9_data[ i ] = RF_MODEM_AGC_WINDOW_SIZE_9_433[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
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
;driverrf4463pro.c,80 :: 		for ( i = 4; i < 13; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,82 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init23
L_vRF4463Init24:
;driverrf4463pro.c,83 :: 		for ( i = 4; i < 13; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init26:
; i start address is: 12 (R3)
CMP	R3, #13
IT	CS
BCS	L_vRF4463Init27
;driverrf4463pro.c,84 :: 		RF_MODEM_BCR_OSR_1_9_data[ i ] = RF_MODEM_BCR_OSR_1_9_433[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
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
;driverrf4463pro.c,83 :: 		for ( i = 4; i < 13; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,85 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init26
L_vRF4463Init27:
;driverrf4463pro.c,86 :: 		}
IT	AL
BAL	L_vRF4463Init29
L_vRF4463Init4:
;driverrf4463pro.c,88 :: 		for ( i = 4; i < 12; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init30:
; i start address is: 12 (R3)
CMP	R3, #12
IT	CS
BCS	L_vRF4463Init31
;driverrf4463pro.c,89 :: 		RF_MODEM_TX_RAMP_DELAY_8_data[ i ] = RF_MODEM_TX_RAMP_DELAY_8_850[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
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
;driverrf4463pro.c,88 :: 		for ( i = 4; i < 12; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,90 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init30
L_vRF4463Init31:
;driverrf4463pro.c,91 :: 		for ( i = 4; i < 11; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init33:
; i start address is: 12 (R3)
CMP	R3, #11
IT	CS
BCS	L_vRF4463Init34
;driverrf4463pro.c,92 :: 		RF_MODEM_AFC_GEAR_7_data[ i ] = RF_MODEM_AFC_GEAR_7_850[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_AFC_GEAR_7_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AFC_GEAR_7_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
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
;driverrf4463pro.c,91 :: 		for ( i = 4; i < 11; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,93 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init33
L_vRF4463Init34:
;driverrf4463pro.c,94 :: 		for ( i = 4; i < 15; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init36:
; i start address is: 12 (R3)
CMP	R3, #15
IT	CS
BCS	L_vRF4463Init37
;driverrf4463pro.c,95 :: 		RF_MODEM_OOK_CNT1_11_data[ i ] = RF_MODEM_OOK_CNT1_11_850[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_OOK_CNT1_11_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_OOK_CNT1_11_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
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
;driverrf4463pro.c,94 :: 		for ( i = 4; i < 15; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,96 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init36
L_vRF4463Init37:
;driverrf4463pro.c,97 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init39:
; i start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_vRF4463Init40
;driverrf4463pro.c,98 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
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
;driverrf4463pro.c,97 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,99 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init39
L_vRF4463Init40:
;driverrf4463pro.c,100 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init42:
; i start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_vRF4463Init43
;driverrf4463pro.c,101 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
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
;driverrf4463pro.c,100 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,102 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init42
L_vRF4463Init43:
;driverrf4463pro.c,103 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init45:
; i start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_vRF4463Init46
;driverrf4463pro.c,104 :: 		RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
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
;driverrf4463pro.c,103 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,105 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init45
L_vRF4463Init46:
;driverrf4463pro.c,106 :: 		for ( i = 4; i < 13; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init48:
; i start address is: 12 (R3)
CMP	R3, #13
IT	CS
BCS	L_vRF4463Init49
;driverrf4463pro.c,107 :: 		RF_MODEM_AGC_WINDOW_SIZE_9_data[ i ] = RF_MODEM_AGC_WINDOW_SIZE_9_850[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
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
;driverrf4463pro.c,106 :: 		for ( i = 4; i < 13; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,108 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init48
L_vRF4463Init49:
;driverrf4463pro.c,109 :: 		for ( i = 4; i < 13; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init51:
; i start address is: 12 (R3)
CMP	R3, #13
IT	CS
BCS	L_vRF4463Init52
;driverrf4463pro.c,110 :: 		RF_MODEM_BCR_OSR_1_9_data[ i ] = RF_MODEM_BCR_OSR_1_9_850[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
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
;driverrf4463pro.c,109 :: 		for ( i = 4; i < 13; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,111 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init51
L_vRF4463Init52:
;driverrf4463pro.c,112 :: 		}
L_vRF4463Init29:
;driverrf4463pro.c,113 :: 		for ( i = 4; i < 11; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init54:
; i start address is: 12 (R3)
CMP	R3, #11
IT	CS
BCS	L_vRF4463Init55
;driverrf4463pro.c,114 :: 		RF_SYNTH_PFDCP_CPFF_7_data[ i ] = RF_SYNTH_PFDCP_CPFF_7[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
MOVT	R0, #hi_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
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
;driverrf4463pro.c,113 :: 		for ( i = 4; i < 11; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,115 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init54
L_vRF4463Init55:
;driverrf4463pro.c,119 :: 		vRF4463GPIO_SET( ucRF4463Mode );                              // PARAMETRO CONFIGURABLE
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
BL	_vRF4463GPIO_SET+0
;driverrf4463pro.c,122 :: 		app_command_buf[ 0 ] = 0x11;    // SET PROPERTY
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,123 :: 		app_command_buf[ 1 ] = 0x00;    // 0x0000
ADDS	R1, R2, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,124 :: 		app_command_buf[ 2 ] = 0x01;    // Total 1 Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,125 :: 		app_command_buf[ 3 ] = 0x00;    // 0x0000
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,126 :: 		app_command_buf[ 4 ] = 98;      // freq  adjustment    ( rango desde 0 - 127 Low cap - High Cap )
ADDS	R1, R2, #4
MOVS	R0, #98
STRB	R0, [R1, #0]
;driverrf4463pro.c,127 :: 		spi_write( 5, app_command_buf );
MOV	R1, R2
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,130 :: 		app_command_buf[ 0 ] = 0x11;    // SET PROPERTY
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,131 :: 		app_command_buf[ 1 ] = 0x00;    // 0x0003
ADDS	R1, R2, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,132 :: 		app_command_buf[ 2 ] = 0x01;    // Total 1 Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,133 :: 		app_command_buf[ 3 ] = 0x03;    // 0x0003
ADDS	R1, R2, #3
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,134 :: 		app_command_buf[ 4 ] = 0x40;    // tx = rx = 64 byte, ordinary PH,high performance mode  ?????????????????????
ADDS	R1, R2, #4
MOVS	R0, #64
STRB	R0, [R1, #0]
;driverrf4463pro.c,135 :: 		spi_write( 5, app_command_buf );
MOV	R1, R2
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,139 :: 		spi_write( 0x08, RF_FRR_CTL_A_MODE_4_data );    // disable all fast response register
MOVW	R1, #lo_addr(_RF_FRR_CTL_A_MODE_4_data+0)
MOVT	R1, #hi_addr(_RF_FRR_CTL_A_MODE_4_data+0)
MOVS	R0, #8
BL	_spi_write+0
;driverrf4463pro.c,142 :: 		app_command_buf[ 0 ] = 0x11;    // SET PROPERTY
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,143 :: 		app_command_buf[ 1 ] = 0x10;    // 0x1000
ADDS	R1, R2, #1
MOVS	R0, #16
STRB	R0, [R1, #0]
;driverrf4463pro.c,144 :: 		app_command_buf[ 2 ] = 0x09;    // Total 9 Parameters
ADDS	R1, R2, #2
MOVS	R0, #9
STRB	R0, [R1, #0]
;driverrf4463pro.c,145 :: 		app_command_buf[ 3 ] = 0x00;    // 0x1000
ADDS	R1, R2, #3
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
ADD	R2, SP, #4
ADDS	R1, R2, #5
MOVS	R0, #20
STRB	R0, [R1, #0]
;driverrf4463pro.c,156 :: 		app_command_buf[ 6 ]   = 0x00;       // Non-standard preamble settings, useless
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,157 :: 		app_command_buf[ 7 ]   = 0x0f;       // Time of the preamble Timeout   ????????????????????????????????????????????????????????????
ADDS	R1, R2, #7
MOVS	R0, #15
STRB	R0, [R1, #0]
;driverrf4463pro.c,158 :: 		app_command_buf[ 8 ]   = 0x31;       // The length of the preamble is   byte Calculation , 1st = 1 NO manchest  Encoding, using standard 1010.??
ADDW	R1, R2, #8
MOVS	R0, #49
STRB	R0, [R1, #0]
;driverrf4463pro.c,159 :: 		app_command_buf[ 9 ]   = 0x0;        // Non-standard Preamble Patten 4th byte
ADDW	R1, R2, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,160 :: 		app_command_buf[ 10 ]  = 0x00;       // Non-standard Preamble Patten 3rd byte
ADDW	R1, R2, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,161 :: 		app_command_buf[ 11 ]  = 0x00;       // Non-standard Preamble Patten 2nd byte
ADDW	R1, R2, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,162 :: 		app_command_buf[ 12 ]  = 0x00;       // Non-standard Preamble Patten 1st byte
ADDW	R1, R2, #12
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,163 :: 		spi_write(13, app_command_buf);
MOV	R1, R2
MOVS	R0, #13
BL	_spi_write+0
;driverrf4463pro.c,166 :: 		app_command_buf[ 0 ] = 0x11;         // SET PROPERTY
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,167 :: 		app_command_buf[ 1 ] = 0x11;         // command = 0x1100
ADDS	R1, R2, #1
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,168 :: 		app_command_buf[ 2 ] = 0x05;         // Total 5 Parameters
ADDS	R1, R2, #2
MOVS	R0, #5
STRB	R0, [R1, #0]
;driverrf4463pro.c,169 :: 		app_command_buf[ 3 ] = 0x00;         // command = 0x1100
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,170 :: 		app_command_buf[ 4 ] = 0x01;         // The synchronization word is defined and sent in the length field, and the synchronization word cannot be wrong,Not 4FSK, not manchest encoding, only 2 bytes
ADDS	R1, R2, #4
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
ADD	R2, SP, #4
ADDS	R1, R2, #5
MOVS	R0, #85
STRB	R0, [R1, #0]
;driverrf4463pro.c,174 :: 		app_command_buf[ 6 ] = 0x55;      // Sync word 2
ADDS	R1, R2, #6
MOVS	R0, #85
STRB	R0, [R1, #0]
;driverrf4463pro.c,175 :: 		}
IT	AL
BAL	L_vRF4463Init60
L_vRF4463Init59:
;driverrf4463pro.c,177 :: 		app_command_buf[ 5 ] = 0x2d;    // Sync word 3
ADD	R2, SP, #4
ADDS	R1, R2, #5
MOVS	R0, #45
STRB	R0, [R1, #0]
;driverrf4463pro.c,178 :: 		app_command_buf[ 6 ] = 0xd4;    // Sync word 2
ADDS	R1, R2, #6
MOVS	R0, #212
STRB	R0, [R1, #0]
;driverrf4463pro.c,179 :: 		}
L_vRF4463Init60:
;driverrf4463pro.c,181 :: 		app_command_buf[ 7 ] = 0x00;         // Sync word 1
ADD	R2, SP, #4
ADDS	R1, R2, #7
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,182 :: 		app_command_buf[ 8 ] = 0x00;         // Sync word 0
ADDW	R1, R2, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,183 :: 		spi_write( 9, app_command_buf );
MOV	R1, R2
MOVS	R0, #9
BL	_spi_write+0
;driverrf4463pro.c,186 :: 		app_command_buf[ 0 ] = 0x11;        // SET PROPERTY
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,187 :: 		app_command_buf[ 1 ] = 0x12;        // command = 0x1200
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,188 :: 		app_command_buf[ 2 ] = 0x01;        // Total 1 Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,189 :: 		app_command_buf[ 3 ] = 0x00;        // command = 0x1200
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,190 :: 		app_command_buf[ 4 ] = 0x85;        // 1?cRC ??,CRC = itu-c, enable crc   ( original 0x81; )
ADDS	R1, R2, #4
MOVS	R0, #133
STRB	R0, [R1, #0]
;driverrf4463pro.c,191 :: 		spi_write( 5, app_command_buf );
MOV	R1, R2
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,194 :: 		app_command_buf[ 0 ] = 0x11;        // SET PROPERTY
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,195 :: 		app_command_buf[ 1 ] = 0x12;        // command = 0x1206
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,196 :: 		app_command_buf[ 2 ] = 0x01;        // Total 1Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,197 :: 		app_command_buf[ 3 ] = 0x06;        // command = 0x1206
ADDS	R1, R2, #3
MOVS	R0, #6
STRB	R0, [R1, #0]
;driverrf4463pro.c,198 :: 		app_command_buf[ 4 ] = 0x02;        //  tx = rx = 120d--1220 (tx packet,ph enable, not 4fsk, After receiving a packet of data,RX off,CRC Do not flip ,CRC MSB, data MSB
ADDS	R1, R2, #4
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,199 :: 		spi_write( 5, app_command_buf );
MOV	R1, R2
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,202 :: 		app_command_buf[ 0 ] = 0x11;        // SET PROPERTY
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,203 :: 		app_command_buf[ 1 ] = 0x12;        // command = 0x1208
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,204 :: 		app_command_buf[ 2 ] = 0x03;        // Total 3 Parameters
ADDS	R1, R2, #2
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,205 :: 		app_command_buf[ 3 ] = 0x08;        // command = 0x1208
ADDS	R1, R2, #3
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,206 :: 		app_command_buf[ 4 ] = 0x00;        // Length Field = LSB,  length Only 1 byte,length Not put In FiFo, fixed packet length mode
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,207 :: 		app_command_buf[ 5 ] = 0x00;        // Used for variable packet length mode, which defines which Field contains length Filed
ADDS	R1, R2, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,208 :: 		app_command_buf[ 6 ] = 0x00;        // Used for variable packet length mode, adjust the length of variable packet length
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,209 :: 		spi_write( 7, app_command_buf );
MOV	R1, R2
MOVS	R0, #7
BL	_spi_write+0
;driverrf4463pro.c,212 :: 		app_command_buf[ 0 ]  = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,213 :: 		app_command_buf[ 1 ]  = 0x12;   // 0x120d
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,214 :: 		app_command_buf[ 2 ]  = 0x0c;   // Total 12 Parameters
ADDS	R1, R2, #2
MOVS	R0, #12
STRB	R0, [R1, #0]
;driverrf4463pro.c,215 :: 		app_command_buf[ 3 ]  = 0x0d;   // 0x120d
ADDS	R1, R2, #3
MOVS	R0, #13
STRB	R0, [R1, #0]
;driverrf4463pro.c,218 :: 		app_command_buf[ 4 ]  = 0x00;   // 0x0D  // Field 1 length (?4?)                             // 0x0D
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,219 :: 		app_command_buf[ 5 ]  = payload_length;  // field 1 length, (? 8?), ?Total14???        // 0x0E
ADDS	R1, R2, #5
MOVS	R0, #66
STRB	R0, [R1, #0]
;driverrf4463pro.c,220 :: 		app_command_buf[ 6 ]  = 0x04;   // 0x0F  // field 1 Is not 4FSK,manchest, whiting, PN9,       // 0x0F
ADDS	R1, R2, #6
MOVS	R0, #4
STRB	R0, [R1, #0]
;driverrf4463pro.c,221 :: 		app_command_buf[ 7 ]  = 0xaa;   // 0x10  // field 1 crc enble, check enbale, There are also launchingCRC,cRC?Seed ?CRC_seed?????
ADDS	R1, R2, #7
MOVS	R0, #170
STRB	R0, [R1, #0]
;driverrf4463pro.c,224 :: 		app_command_buf[ 8 ]  = 0x00;   // 0x11  // field 2 length(?4?)
ADDW	R1, R2, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,225 :: 		app_command_buf[ 9 ]  = 0x00;   // 0x12  // field 2 length, (? 8?), length = 0 Means thisfield did not use
ADDW	R1, R2, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,226 :: 		app_command_buf[ 10 ] = 0x00;   // 0x13  // field 2 Is not 4FSK,manchest, whiting, PN9
ADDW	R1, R2, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,227 :: 		app_command_buf[ 11 ] = 0x00;   // 0x14  // field 2 ?CRCSet up
ADDW	R1, R2, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,230 :: 		app_command_buf[ 12 ] = 0x00;   // 0x15  // field 3 length, (? 8?), length = 0 Means thisfield did not use
ADDW	R1, R2, #12
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,231 :: 		app_command_buf[ 13 ] = 0x00;   // 0x16  // field 3 length, (? 8?), length = 0 Means thisfield did not use
ADDW	R1, R2, #13
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,232 :: 		app_command_buf[ 14 ] = 0x00;   // 0x17  // field 3 Is not 4FSK,manchest, whiting, PN9
ADDW	R1, R2, #14
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,233 :: 		app_command_buf[ 15 ] = 0x00;   // 0x18  // field 3 ?CRCSet up
ADDW	R1, R2, #15
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,234 :: 		spi_write( 16, app_command_buf );
MOV	R1, R2
MOVS	R0, #16
BL	_spi_write+0
;driverrf4463pro.c,237 :: 		app_command_buf[ 0 ]  = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,238 :: 		app_command_buf[ 1 ]  = 0x12;       // 0x1219
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,239 :: 		app_command_buf[ 2 ]  = 0x08;       // Total 8Parameters
ADDS	R1, R2, #2
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,240 :: 		app_command_buf[ 3 ]  = 0x19;       // 0x1219
ADDS	R1, R2, #3
MOVS	R0, #25
STRB	R0, [R1, #0]
;driverrf4463pro.c,241 :: 		app_command_buf[ 4 ]  = 0x00;       // field4 length(?4?)
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,242 :: 		app_command_buf[ 5 ]  = 0x00;       // field 4 length, (? 8?), length = 0 Means this field did not use
ADDS	R1, R2, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,243 :: 		app_command_buf[ 6 ]  = 0x00;       // field 4 Is not 4FSK,manchest, whiting, PN9
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,244 :: 		app_command_buf[ 7 ]  = 0x00;       // field 4 ?CRCSet up
ADDS	R1, R2, #7
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,245 :: 		app_command_buf[ 8 ]  = 0x00;       // field5 length(?4?)
ADDW	R1, R2, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,246 :: 		app_command_buf[ 9 ]  = 0x00;       // field 5 length, (? 8?), length = 0 Means this field did not use
ADDW	R1, R2, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,247 :: 		app_command_buf[ 10 ] = 0x00;       // field 5 Is not 4FSK,manchest, whiting, PN9
ADDW	R1, R2, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,248 :: 		app_command_buf[ 11 ] = 0x00;       // field 5 ?CRCSet up
ADDW	R1, R2, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,249 :: 		spi_write( 12, app_command_buf );
MOV	R1, R2
MOVS	R0, #12
BL	_spi_write+0
;driverrf4463pro.c,252 :: 		spi_write( 0x10, RF_MODEM_MOD_TYPE_12_data );   // //  2FSK ,  module source = PH fifo, disable manchest, tx, rx Do not flip, deviation Do not flip
MOVW	R1, #lo_addr(_RF_MODEM_MOD_TYPE_12_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_MOD_TYPE_12_data+0)
MOVS	R0, #16
BL	_spi_write+0
;driverrf4463pro.c,255 :: 		app_command_buf[0]  = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,256 :: 		app_command_buf[1]  = 0x20;    // 0x200c
ADDS	R1, R2, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,257 :: 		app_command_buf[2]  = 0x01;    // Total 1Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,258 :: 		app_command_buf[3]  = 0x0c;    // 0x200c
ADDS	R1, R2, #3
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
MOV	R1, R0
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,285 :: 		spi_write( 0x0C, RF_MODEM_TX_RAMP_DELAY_8_data );            // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
MOVS	R0, #12
BL	_spi_write+0
;driverrf4463pro.c,286 :: 		spi_write( 0x0D, RF_MODEM_BCR_OSR_1_9_data );                // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
MOVS	R0, #13
BL	_spi_write+0
;driverrf4463pro.c,287 :: 		spi_write( 0x0B, RF_MODEM_AFC_GEAR_7_data );                // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_AFC_GEAR_7_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_AFC_GEAR_7_data+0)
MOVS	R0, #11
BL	_spi_write+0
;driverrf4463pro.c,288 :: 		spi_write( 0x05, RF_MODEM_AGC_CONTROL_1_data );                // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_AGC_CONTROL_1_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_AGC_CONTROL_1_data+0)
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,289 :: 		spi_write( 0x0D, RF_MODEM_AGC_WINDOW_SIZE_9_data );        // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
MOVS	R0, #13
BL	_spi_write+0
;driverrf4463pro.c,290 :: 		spi_write( 0x0F, RF_MODEM_OOK_CNT1_11_data );                // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_OOK_CNT1_11_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_OOK_CNT1_11_data+0)
MOVS	R0, #15
BL	_spi_write+0
;driverrf4463pro.c,293 :: 		app_command_buf[ 0 ] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,294 :: 		app_command_buf[ 1 ] = 0x20;    // 0x204e
ADDS	R1, R2, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,295 :: 		app_command_buf[ 2 ] = 0x01;    // Total 1Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,296 :: 		app_command_buf[ 3 ] = 0x4e;    // 0x204e
ADDS	R1, R2, #3
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
MOV	R1, R0
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,307 :: 		spi_write( 0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data );  // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVS	R0, #16
BL	_spi_write+0
;driverrf4463pro.c,308 :: 		spi_write( 0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data );   // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVS	R0, #16
BL	_spi_write+0
;driverrf4463pro.c,309 :: 		spi_write( 0x10, RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data );   // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVS	R0, #16
BL	_spi_write+0
;driverrf4463pro.c,312 :: 		app_command_buf[ 0 ]  = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,313 :: 		app_command_buf[ 1 ]  = 0x22;    // 0x2200
ADDS	R1, R2, #1
MOVS	R0, #34
STRB	R0, [R1, #0]
;driverrf4463pro.c,314 :: 		app_command_buf[ 2 ]  = 0x04;    // Total 4Parameters
ADDS	R1, R2, #2
MOVS	R0, #4
STRB	R0, [R1, #0]
;driverrf4463pro.c,315 :: 		app_command_buf[ 3 ]  = 0x00;   // 0x2200
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,316 :: 		app_command_buf[ 4 ]  = 0x08;  //0x10;   //   PA mode  = default , ??Class E mode,?Is not Switch Current mode  ????????
ADDS	R1, R2, #4
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,318 :: 		if ( ucRF4463Power > 0 || ucRF4463Power < 127 ) {
MOVW	R0, #lo_addr(_ucRF4463Power+0)
MOVT	R0, #hi_addr(_ucRF4463Power+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	HI
BHI	L__vRF4463Init440
MOVW	R0, #lo_addr(_ucRF4463Power+0)
MOVT	R0, #hi_addr(_ucRF4463Power+0)
LDRB	R0, [R0, #0]
CMP	R0, #127
IT	CC
BCC	L__vRF4463Init439
IT	AL
BAL	L_vRF4463Init75
L__vRF4463Init440:
L__vRF4463Init439:
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
BLS	L__vRF4463Init442
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	EQ
BEQ	L__vRF4463Init441
IT	AL
BAL	L_vRF4463Init79
L__vRF4463Init442:
L__vRF4463Init441:
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
MOV	R1, R0
MOVS	R0, #8
BL	_spi_write+0
;driverrf4463pro.c,337 :: 		spi_write( 0x0B , RF_SYNTH_PFDCP_CPFF_7_data );      // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
MOVT	R1, #hi_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
MOVS	R0, #11
BL	_spi_write+0
;driverrf4463pro.c,340 :: 		if ( ucRF4463MatchEnabled ) {
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463Init81
;driverrf4463pro.c,341 :: 		app_command_buf[ 0 ]  = 0x11;               // SetProperty
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,342 :: 		app_command_buf[ 1 ]  = 0x30;               // 0x30 group
ADDS	R1, R2, #1
MOVS	R0, #48
STRB	R0, [R1, #0]
;driverrf4463pro.c,343 :: 		app_command_buf[ 2 ]  = 0x0c;               // Total 12 Parameters
ADDS	R1, R2, #2
MOVS	R0, #12
STRB	R0, [R1, #0]
;driverrf4463pro.c,344 :: 		app_command_buf[ 3 ]  = 0x00;               // 0x00 Index
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,345 :: 		app_command_buf[ 4 ]  = ucRF4463ByteMatch1; // match 1 Value of
ADDS	R1, R2, #4
MOVW	R0, #lo_addr(_ucRF4463ByteMatch1+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch1+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,346 :: 		app_command_buf[ 5 ]  = ucRF4463ByteMask1;  // match 1 mask
ADDS	R1, R2, #5
MOVW	R0, #lo_addr(_ucRF4463ByteMask1+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask1+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,347 :: 		app_command_buf[ 6 ]  = ucRF4463MatchEnableReg; //  0x40; // enable match 1, match 1 The distance between the value of and the synchronization word, 0 = match
ADDS	R1, R2, #6
MOVW	R0, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnableReg+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,348 :: 		app_command_buf[ 7 ]  = ucRF4463ByteMatch2; // match 2 Value of
ADDS	R1, R2, #7
MOVW	R0, #lo_addr(_ucRF4463ByteMatch2+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch2+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,349 :: 		app_command_buf[ 8 ]  = ucRF4463ByteMask2;  // match 2 mask
ADDW	R1, R2, #8
MOVW	R0, #lo_addr(_ucRF4463ByteMask2+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask2+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,350 :: 		app_command_buf[ 9 ]  = 0x01;               // enable match 2, match 2 The distance between the value of and the synchronization word  , and function
ADDW	R1, R2, #9
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,351 :: 		app_command_buf[ 10 ] = ucRF4463ByteMatch3; // match 3 Value of
ADDW	R1, R2, #10
MOVW	R0, #lo_addr(_ucRF4463ByteMatch3+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch3+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,352 :: 		app_command_buf[ 11 ] = ucRF4463ByteMask3;  // match 3 mask
ADDW	R1, R2, #11
MOVW	R0, #lo_addr(_ucRF4463ByteMask3+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask3+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,353 :: 		app_command_buf[ 12 ] = 0x02;;              // enable match 3, match 3 The distance between the value of and the synchronization word    and function
ADDW	R1, R2, #12
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,354 :: 		app_command_buf[ 13 ] = ucRF4463ByteMatch4; // match 4 Value of
ADDW	R1, R2, #13
MOVW	R0, #lo_addr(_ucRF4463ByteMatch4+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch4+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,355 :: 		app_command_buf[ 14 ] = ucRF4463ByteMask4;  // match 4 mask
ADDW	R1, R2, #14
MOVW	R0, #lo_addr(_ucRF4463ByteMask4+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask4+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,356 :: 		app_command_buf[ 15 ] = 0x03;               // enable match 4, match 4 The distance between the value of and the synchronization word    and function
ADDW	R1, R2, #15
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,357 :: 		spi_write( 16, app_command_buf );
MOV	R1, R2
MOVS	R0, #16
BL	_spi_write+0
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
ADD	SP, SP, #24
BX	LR
; end of _vRF4463Init
_ucRF4463ChecksumGenerator:
;driverrf4463pro.c,388 :: 		char ucRF4463ChecksumGenerator ( unsigned char *ucBuffer, unsigned char ucBufferLenght ) {
; ucBufferLenght start address is: 4 (R1)
; ucBuffer start address is: 0 (R0)
SUB	SP, SP, #4
; ucBufferLenght end address is: 4 (R1)
; ucBuffer end address is: 0 (R0)
; ucBuffer start address is: 0 (R0)
; ucBufferLenght start address is: 4 (R1)
;driverrf4463pro.c,389 :: 		unsigned short ucCounter = 0;
;driverrf4463pro.c,390 :: 		unsigned char ucChecksum = 0;
; ucChecksum start address is: 16 (R4)
MOVS	R4, #0
;driverrf4463pro.c,392 :: 		for ( ucCounter = 0; ucCounter < ucBufferLenght ; ucCounter++ ) {
; ucCounter start address is: 12 (R3)
MOVS	R3, #0
; ucBuffer end address is: 0 (R0)
; ucBufferLenght end address is: 4 (R1)
; ucChecksum end address is: 16 (R4)
; ucCounter end address is: 12 (R3)
STRB	R1, [SP, #0]
MOV	R1, R0
LDRB	R0, [SP, #0]
L_ucRF4463ChecksumGenerator83:
; ucCounter start address is: 12 (R3)
; ucBuffer start address is: 4 (R1)
; ucChecksum start address is: 16 (R4)
; ucBufferLenght start address is: 0 (R0)
; ucBuffer start address is: 4 (R1)
; ucBuffer end address is: 4 (R1)
CMP	R3, R0
IT	CS
BCS	L_ucRF4463ChecksumGenerator84
; ucBuffer end address is: 4 (R1)
;driverrf4463pro.c,393 :: 		ucChecksum += ucBuffer[ ucCounter ];
; ucBuffer start address is: 4 (R1)
ADDS	R2, R1, R3
LDRB	R2, [R2, #0]
ADDS	R2, R4, R2
UXTB	R4, R2
;driverrf4463pro.c,392 :: 		for ( ucCounter = 0; ucCounter < ucBufferLenght ; ucCounter++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,394 :: 		}
; ucBufferLenght end address is: 0 (R0)
; ucBuffer end address is: 4 (R1)
; ucCounter end address is: 12 (R3)
IT	AL
BAL	L_ucRF4463ChecksumGenerator83
L_ucRF4463ChecksumGenerator84:
;driverrf4463pro.c,396 :: 		return ucChecksum;
UXTB	R0, R4
; ucChecksum end address is: 16 (R4)
;driverrf4463pro.c,397 :: 		}
L_end_ucRF4463ChecksumGenerator:
ADD	SP, SP, #4
BX	LR
; end of _ucRF4463ChecksumGenerator
_vRF4463GPIO_SET:
;driverrf4463pro.c,401 :: 		void vRF4463GPIO_SET( unsigned char ucData ) {
; ucData start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
; ucData end address is: 0 (R0)
; ucData start address is: 0 (R0)
;driverrf4463pro.c,404 :: 		ucAppCommandBuf[0] = 0x13;     // gpio Set up
ADD	R2, SP, #4
MOVS	R1, #19
STRB	R1, [R2, #0]
;driverrf4463pro.c,406 :: 		switch ( ucData ) {
IT	AL
BAL	L_vRF4463GPIO_SET86
; ucData end address is: 0 (R0)
;driverrf4463pro.c,407 :: 		case tx_normal:
L_vRF4463GPIO_SET88:
;driverrf4463pro.c,408 :: 		case rx_normal: ucAppCommandBuf[ 1 ] = 3;                 // GPIO0=1
L_vRF4463GPIO_SET89:
ADD	R3, SP, #4
ADDS	R2, R3, #1
MOVS	R1, #3
STRB	R1, [R2, #0]
;driverrf4463pro.c,409 :: 		ucAppCommandBuf[ 2 ] = 2;                // GPIO1=0
ADDS	R2, R3, #2
MOVS	R1, #2
STRB	R1, [R2, #0]
;driverrf4463pro.c,410 :: 		break;
IT	AL
BAL	L_vRF4463GPIO_SET87
;driverrf4463pro.c,412 :: 		case tx_test:   ucAppCommandBuf[ 1 ] = 3;                 // GPIO0=1
L_vRF4463GPIO_SET90:
ADD	R3, SP, #4
ADDS	R2, R3, #1
MOVS	R1, #3
STRB	R1, [R2, #0]
;driverrf4463pro.c,413 :: 		ucAppCommandBuf[ 2 ] = 3;                // GPIO1=1
ADDS	R2, R3, #2
MOVS	R1, #3
STRB	R1, [R2, #0]
;driverrf4463pro.c,414 :: 		break;
IT	AL
BAL	L_vRF4463GPIO_SET87
;driverrf4463pro.c,416 :: 		case rx_test:   ucAppCommandBuf[ 1 ] = 2;                 // GPIO0=0
L_vRF4463GPIO_SET91:
ADD	R3, SP, #4
ADDS	R2, R3, #1
MOVS	R1, #2
STRB	R1, [R2, #0]
;driverrf4463pro.c,417 :: 		ucAppCommandBuf[ 2 ] = 20;                // GPIO1=RX DATA
ADDS	R2, R3, #2
MOVS	R1, #20
STRB	R1, [R2, #0]
;driverrf4463pro.c,418 :: 		break;
IT	AL
BAL	L_vRF4463GPIO_SET87
;driverrf4463pro.c,420 :: 		case rf_off:    ucAppCommandBuf[ 1 ] = 2;                 // GPIO0=0
L_vRF4463GPIO_SET92:
ADD	R3, SP, #4
ADDS	R2, R3, #1
MOVS	R1, #2
STRB	R1, [R2, #0]
;driverrf4463pro.c,421 :: 		ucAppCommandBuf[ 2 ] = 2;                // GPIO1=0
ADDS	R2, R3, #2
MOVS	R1, #2
STRB	R1, [R2, #0]
;driverrf4463pro.c,422 :: 		break;
IT	AL
BAL	L_vRF4463GPIO_SET87
;driverrf4463pro.c,423 :: 		}
L_vRF4463GPIO_SET86:
; ucData start address is: 0 (R0)
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463GPIO_SET88
CMP	R0, #1
IT	EQ
BEQ	L_vRF4463GPIO_SET89
CMP	R0, #2
IT	EQ
BEQ	L_vRF4463GPIO_SET90
CMP	R0, #3
IT	EQ
BEQ	L_vRF4463GPIO_SET91
CMP	R0, #4
IT	EQ
BEQ	L_vRF4463GPIO_SET92
; ucData end address is: 0 (R0)
L_vRF4463GPIO_SET87:
;driverrf4463pro.c,425 :: 		ucAppCommandBuf[ 3 ]  = 0x21;     //0x20;   //  gpio2, h = tx mode
ADD	R3, SP, #4
ADDS	R2, R3, #3
MOVS	R1, #33
STRB	R1, [R2, #0]
;driverrf4463pro.c,426 :: 		ucAppCommandBuf[ 4 ]  = 0x20;     // 0x14;  //   gpio3
ADDS	R2, R3, #4
MOVS	R1, #32
STRB	R1, [R2, #0]
;driverrf4463pro.c,427 :: 		ucAppCommandBuf[ 5 ]  = 0x27;     // nIRQ
ADDS	R2, R3, #5
MOVS	R1, #39
STRB	R1, [R2, #0]
;driverrf4463pro.c,428 :: 		ucAppCommandBuf[ 6 ]  = 0x0b;     // sdo
ADDS	R2, R3, #6
MOVS	R1, #11
STRB	R1, [R2, #0]
;driverrf4463pro.c,429 :: 		spi_write( 7, ucAppCommandBuf );
MOV	R1, R3
MOVS	R0, #7
BL	_spi_write+0
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
ADD	R2, SP, #4
MOVS	R0, #21
STRB	R0, [R2, #0]
;driverrf4463pro.c,439 :: 		p[ 1 ] = 0x03;   // reset tx ,rx fifo
ADDS	R1, R2, #1
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,440 :: 		spi_write( 2, p );
MOV	R1, R2
MOVS	R0, #2
BL	_spi_write+0
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
ADD	R2, SP, #4
MOVS	R0, #32
STRB	R0, [R2, #0]
;driverrf4463pro.c,451 :: 		p[ 1 ] = 0;               // clr  PH pending
ADDS	R1, R2, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,452 :: 		p[ 2 ] = 0;               // clr modem_pending
ADDS	R1, R2, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,453 :: 		p[ 3 ] = 0;               // clr chip pending
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,454 :: 		spi_write( 4, p );
MOV	R1, R2
MOVS	R0, #4
BL	_spi_write+0
;driverrf4463pro.c,455 :: 		spi_read( 9, GET_INT_STATUS );
MOVS	R1, #32
MOVS	R0, #9
BL	_spi_read+0
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
ADD	R1, SP, #4
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,465 :: 		spi_write( 1, p );
MOVS	R0, #1
BL	_spi_write+0
;driverrf4463pro.c,466 :: 		spi_read( 9, PART_INFO );
MOVS	R1, #1
MOVS	R0, #9
BL	_spi_read+0
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
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,476 :: 		p[ 1 ] = 0x01;            // 0x0100
ADDS	R1, R2, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,477 :: 		p[ 2 ] = 0x03;            // 3Parameters
ADDS	R1, R2, #2
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,478 :: 		p[ 3 ] = 0x00;            // 0100
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,479 :: 		p[ 4 ] = 0x03;            // ph, modem int       0x03;
ADDS	R1, R2, #4
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,480 :: 		p[ 5 ] = 0x18;            // 0x10;   // Pack received int
ADDS	R1, R2, #5
MOVS	R0, #24
STRB	R0, [R1, #0]
;driverrf4463pro.c,481 :: 		p[ 6 ] = 0x00;            //preamble int, sync int setting
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,482 :: 		spi_write( 0x07, p );     // enable  packet receive interrupt
MOV	R1, R2
MOVS	R0, #7
BL	_spi_write+0
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
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,492 :: 		p[ 1 ] = 0x01;            // 0x0100
ADDS	R1, R2, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,493 :: 		p[ 2 ] = 0x02;            // 2Parameters
ADDS	R1, R2, #2
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,494 :: 		p[ 3 ] = 0x00;            // 0x0100
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,495 :: 		p[ 4 ] = 0x01;            // Ph  int
ADDS	R1, R2, #4
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,496 :: 		p[ 5 ] = 0x20;            //  enable  packet sent interrupt
ADDS	R1, R2, #5
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,497 :: 		spi_write( 0x06, p );     // enable  packet receive interrupt
MOV	R1, R2
MOVS	R0, #6
BL	_spi_write+0
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
ADD	R2, SP, #4
MOVS	R0, #52
STRB	R0, [R2, #0]
;driverrf4463pro.c,507 :: 		p[ 1 ] = 0x01 ;           // sleep mode
ADDS	R1, R2, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,508 :: 		spi_write( 2, p );
MOV	R1, R2
MOVS	R0, #2
BL	_spi_write+0
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
ADD	R2, SP, #4
MOVS	R0, #49
STRB	R0, [R2, #0]
;driverrf4463pro.c,518 :: 		p[ 1 ] = ucRF4463FreqChannel;    // channel 1 default
ADDS	R1, R2, #1
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,519 :: 		p[ 2 ] = 0x30;                   // Back after launch Readymode, Do not retransmit, launch immediately
ADDS	R1, R2, #2
MOVS	R0, #48
STRB	R0, [R1, #0]
;driverrf4463pro.c,520 :: 		p[ 3 ] = 0;
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,521 :: 		p[ 4 ] = 0;                      // payload_length; // Total to transmit 10 bytes
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,522 :: 		spi_write( 5, p );
MOV	R1, R2
MOVS	R0, #5
BL	_spi_write+0
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
ADD	R2, SP, #4
MOVS	R0, #50
STRB	R0, [R2, #0]
;driverrf4463pro.c,532 :: 		p[ 1 ] = ucRF4463FreqChannel;    // channel 0
ADDS	R1, R2, #1
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,533 :: 		p[ 2 ] = 0x00;                   // Enter receiving mode immediately
ADDS	R1, R2, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,534 :: 		p[ 3 ] = 0;
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,535 :: 		p[ 4 ] = 0;                      // payload_length; // Total to receive 10 bytes
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,536 :: 		p[ 5 ] = 0;                      // unchanged after preamble timeout
ADDS	R1, R2, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,539 :: 		p[ 6 ] = 0x08;
ADDS	R1, R2, #6
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,540 :: 		p[ 7 ] = 0x08;
ADDS	R1, R2, #7
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,541 :: 		spi_write( 8, p );
MOV	R1, R2
MOVS	R0, #8
BL	_spi_write+0
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
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_SX	[R0, ByteOffset(GPIOE_ODRbits+0)]
;driverrf4463pro.c,552 :: 		p[ 0 ] = START_RX;        // start Command
ADD	R2, SP, #4
MOVS	R0, #50
STRB	R0, [R2, #0]
;driverrf4463pro.c,553 :: 		p[ 1 ] = ucRF4463FreqChannel;    // channel 0
ADDS	R1, R2, #1
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,554 :: 		p[ 2 ] = 0x00;            // Enter receiving mode immediately
ADDS	R1, R2, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,555 :: 		p[ 3 ] = 0;
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,557 :: 		p[ 4 ] = 0;
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,558 :: 		p[ 5 ] = 0;               // unchanged after preamble timeout
ADDS	R1, R2, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,561 :: 		p[ 6 ] = 0x08;
ADDS	R1, R2, #6
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,562 :: 		p[ 7 ] = 0x08;
ADDS	R1, R2, #7
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,563 :: 		spi_write( 8, p );
MOV	R1, R2
MOVS	R0, #8
BL	_spi_write+0
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
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_LX	[R0, ByteOffset(GPIOE_ODRbits+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_SX	[R0, ByteOffset(GPIOE_ODRbits+0)]
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
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_LX	[R0, ByteOffset(GPIOE_ODRbits+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_SX	[R0, ByteOffset(GPIOE_ODRbits+0)]
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
MOVW	R1, #lo_addr(_tx_cnt+0)
MOVT	R1, #hi_addr(_tx_cnt+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
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
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_SX	[R0, ByteOffset(GPIOE_ODRbits+0)]
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
SUB	SP, SP, #28
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
ADDS	R2, R2, R0
MOVW	R0, #lo_addr(_ucRF4463Freq1+0)
MOVT	R0, #hi_addr(_ucRF4463Freq1+0)
LDRB	R0, [R0, #0]
ADDS	R2, R2, R0
; ulFrequency start address is: 8 (R2)
SXTH	R2, R2
;driverrf4463pro.c,664 :: 		ulFrequency = ( ulFrequency * 10000 );
MOVW	R0, #10000
MUL	R1, R2, R0
MOV	R2, R1
;driverrf4463pro.c,667 :: 		if ( ulFrequency >= 7600000 ) {
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
STRB	R0, [SP, #6]
;driverrf4463pro.c,670 :: 		ucVCO = 0xFF;
MOVS	R0, #255
STRB	R0, [SP, #5]
;driverrf4463pro.c,671 :: 		}
IT	AL
BAL	L_rf_init_freq104
L_rf_init_freq103:
;driverrf4463pro.c,674 :: 		else if ( ulFrequency >= 5460000 ) {
MOVW	R0, #20512
MOVT	R0, #83
CMP	R2, R0
IT	CC
BCC	L_rf_init_freq105
;driverrf4463pro.c,675 :: 		ucOUTDIV = 6;
MOVS	R0, #6
STRB	R0, [SP, #4]
;driverrf4463pro.c,676 :: 		ucBAND   = 1;
MOVS	R0, #1
STRB	R0, [SP, #6]
;driverrf4463pro.c,677 :: 		ucVCO    = 0xFE;
MOVS	R0, #254
STRB	R0, [SP, #5]
;driverrf4463pro.c,678 :: 		}
IT	AL
BAL	L_rf_init_freq106
L_rf_init_freq105:
;driverrf4463pro.c,681 :: 		else if ( ulFrequency >= 3850000 ) {
MOVW	R0, #48912
MOVT	R0, #58
CMP	R2, R0
IT	CC
BCC	L_rf_init_freq107
;driverrf4463pro.c,682 :: 		ucOUTDIV = 8;
MOVS	R0, #8
STRB	R0, [SP, #4]
;driverrf4463pro.c,683 :: 		ucBAND   = 2;
MOVS	R0, #2
STRB	R0, [SP, #6]
;driverrf4463pro.c,684 :: 		ucVCO    = 0xFE;
MOVS	R0, #254
STRB	R0, [SP, #5]
;driverrf4463pro.c,685 :: 		}
IT	AL
BAL	L_rf_init_freq108
L_rf_init_freq107:
;driverrf4463pro.c,688 :: 		else if ( ulFrequency >= 2730000 ) {
MOVW	R0, #43024
MOVT	R0, #41
CMP	R2, R0
IT	CC
BCC	L_rf_init_freq109
;driverrf4463pro.c,689 :: 		ucOUTDIV = 12;
MOVS	R0, #12
STRB	R0, [SP, #4]
;driverrf4463pro.c,690 :: 		ucBAND   = 3;
MOVS	R0, #3
STRB	R0, [SP, #6]
;driverrf4463pro.c,691 :: 		ucVCO    = 0xFD;
MOVS	R0, #253
STRB	R0, [SP, #5]
;driverrf4463pro.c,692 :: 		}
IT	AL
BAL	L_rf_init_freq110
L_rf_init_freq109:
;driverrf4463pro.c,695 :: 		else if ( ulFrequency >= 1940000 ) {
MOVW	R0, #39456
MOVT	R0, #29
CMP	R2, R0
IT	CC
BCC	L_rf_init_freq111
;driverrf4463pro.c,696 :: 		ucOUTDIV = 16;
MOVS	R0, #16
STRB	R0, [SP, #4]
;driverrf4463pro.c,697 :: 		ucBAND   = 4;
MOVS	R0, #4
STRB	R0, [SP, #6]
;driverrf4463pro.c,698 :: 		ucVCO    = 0xFC;
MOVS	R0, #252
STRB	R0, [SP, #5]
;driverrf4463pro.c,699 :: 		}
IT	AL
BAL	L_rf_init_freq112
L_rf_init_freq111:
;driverrf4463pro.c,703 :: 		ucOUTDIV = 24;
MOVS	R0, #24
STRB	R0, [SP, #4]
;driverrf4463pro.c,704 :: 		ucBAND   = 5;
MOVS	R0, #5
STRB	R0, [SP, #6]
;driverrf4463pro.c,705 :: 		ucVCO    = 0xFA;
MOVS	R0, #250
STRB	R0, [SP, #5]
;driverrf4463pro.c,706 :: 		}
L_rf_init_freq112:
L_rf_init_freq110:
L_rf_init_freq108:
L_rf_init_freq106:
L_rf_init_freq104:
;driverrf4463pro.c,708 :: 		ucDIV = ucOUTDIV / 2;
LDRB	R0, [SP, #4]
LSRS	R0, R0, #1
UXTB	R0, R0
;driverrf4463pro.c,710 :: 		ulData = ( ulFrequency * ucDIV ) / 3;          // ucDIV = 88.5 = 88   //// UCdiv = 2
MUL	R1, R2, R0
; ulFrequency end address is: 8 (R2)
MOVS	R0, #3
UDIV	R2, R1, R0
;driverrf4463pro.c,711 :: 		ucINTE = ( ulData / 100000) - 1;               // ulData = 6 000 000  //// ULdATA = 9 000 000
MOVW	R0, #34464
MOVT	R0, #1
UDIV	R0, R2, R0
SUBS	R0, R0, #1
; ucINTE start address is: 24 (R6)
UXTB	R6, R0
;driverrf4463pro.c,712 :: 		ulFRAC = ( ulData - ( ucINTE + 1 ) * 100000 ) * 16384 / 3125;         // ulFRAC = 15 728 640
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
;driverrf4463pro.c,713 :: 		ulFRAC = ulFRAC + 0x80000;
ADD	R0, R0, #524288
;driverrf4463pro.c,715 :: 		ucFRAC_0 = ulFRAC;
; ucFRAC_0 start address is: 28 (R7)
UXTB	R7, R0
;driverrf4463pro.c,716 :: 		ulFRAC >>= 8;
LSRS	R0, R0, #8
;driverrf4463pro.c,717 :: 		ucFRAC_1 = ulFRAC;
; ucFRAC_1 start address is: 32 (R8)
UXTB	R8, R0
;driverrf4463pro.c,718 :: 		ulFRAC >>= 8;
LSRS	R0, R0, #8
;driverrf4463pro.c,719 :: 		ucFRAC_2 = ulFRAC;
; ucFRAC_2 start address is: 36 (R9)
UXTB	R9, R0
;driverrf4463pro.c,723 :: 		app_command_buf[ 0 ] = 0x11;           // SET property    MODEM_CLKGEN_BAND
ADD	R2, SP, #7
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,724 :: 		app_command_buf[ 1 ] = 0x20;           // Group  // 0x2051
ADDS	R1, R2, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,725 :: 		app_command_buf[ 2 ] = 0x01;           // Num Arguments // Total 1 Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,726 :: 		app_command_buf[ 3 ] = 0x51;           // Number  // 0x2051
ADDS	R1, R2, #3
MOVS	R0, #81
STRB	R0, [R1, #0]
;driverrf4463pro.c,727 :: 		app_command_buf[ 4 ] = 0x08 | ucBAND;  // Argumento  //  high performance mode , clk outpu = osc /4
ADDS	R1, R2, #4
LDRB	R0, [SP, #6]
ORR	R0, R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,728 :: 		spi_write( 5, app_command_buf );
MOV	R1, R2
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,730 :: 		app_command_buf[ 0 ]  = 0x11;
ADD	R2, SP, #7
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,731 :: 		app_command_buf[ 1 ]  = 0x40;    // 0x4000         FREQ_CONTROL_INTE
ADDS	R1, R2, #1
MOVS	R0, #64
STRB	R0, [R1, #0]
;driverrf4463pro.c,732 :: 		app_command_buf[ 2 ]  = 0x08;    // Total 8 Parameters
ADDS	R1, R2, #2
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,733 :: 		app_command_buf[ 3 ]  = 0x00;   // 0x4000
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,734 :: 		app_command_buf[ 4 ]  = ucINTE;   //  default value
ADDS	R0, R2, #4
STRB	R6, [R0, #0]
; ucINTE end address is: 24 (R6)
;driverrf4463pro.c,735 :: 		app_command_buf[ 5 ]  = ucFRAC_2;   //  defaul value
ADDS	R0, R2, #5
STRB	R9, [R0, #0]
; ucFRAC_2 end address is: 36 (R9)
;driverrf4463pro.c,736 :: 		app_command_buf[ 6 ]  = ucFRAC_1;   //  default value
ADDS	R0, R2, #6
STRB	R8, [R0, #0]
; ucFRAC_1 end address is: 32 (R8)
;driverrf4463pro.c,737 :: 		app_command_buf[ 7 ]  = ucFRAC_0;   // frac ,from WDS
ADDS	R0, R2, #7
STRB	R7, [R0, #0]
; ucFRAC_0 end address is: 28 (R7)
;driverrf4463pro.c,740 :: 		if ( ulRF4463Step == 250 ) {
MOVW	R0, #lo_addr(_ulRF4463Step+0)
MOVT	R0, #hi_addr(_ulRF4463Step+0)
LDR	R0, [R0, #0]
CMP	R0, #250
IT	NE
BNE	L_rf_init_freq113
;driverrf4463pro.c,741 :: 		app_command_buf[ 8 ]  = step_250K_step1;   // channel step1  from wds  // al parecer aqu? esta el ancho del canal
ADD	R2, SP, #7
ADDW	R1, R2, #8
MOVS	R0, #34
STRB	R0, [R1, #0]
;driverrf4463pro.c,742 :: 		app_command_buf[ 9 ]  = step_250K_step0;   // channel step0  from wds
ADDW	R1, R2, #9
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
ADD	R2, SP, #7
ADDW	R1, R2, #8
MOVS	R0, #68
STRB	R0, [R1, #0]
;driverrf4463pro.c,746 :: 		app_command_buf[ 9 ]  = step_500K_step0;   // channel step0  from wds
ADDW	R1, R2, #9
MOVS	R0, #68
STRB	R0, [R1, #0]
;driverrf4463pro.c,747 :: 		}
L_rf_init_freq115:
L_rf_init_freq114:
;driverrf4463pro.c,749 :: 		app_command_buf[ 10 ] = 0x20;  //  from wds Without this Values
ADD	R2, SP, #7
ADDW	R1, R2, #10
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,750 :: 		app_command_buf[ 11 ] = ucVCO;    // from wds Without this Values
ADDW	R1, R2, #11
LDRB	R0, [SP, #5]
STRB	R0, [R1, #0]
;driverrf4463pro.c,764 :: 		spi_write( 12, app_command_buf );
MOV	R1, R2
MOVS	R0, #12
BL	_spi_write+0
;driverrf4463pro.c,765 :: 		}
L_end_rf_init_freq:
LDR	LR, [SP, #0]
ADD	SP, SP, #28
BX	LR
; end of _rf_init_freq
_ucRf4463SPIByte:
;driverrf4463pro.c,785 :: 		unsigned char ucRf4463SPIByte( unsigned char ucData ) {
; ucData start address is: 0 (R0)
; ucData end address is: 0 (R0)
; ucData start address is: 0 (R0)
;driverrf4463pro.c,786 :: 		ucSPI1ByteReceived = 0;
MOVS	R2, #0
MOVW	R1, #lo_addr(_ucSPI1ByteReceived+0)
MOVT	R1, #hi_addr(_ucSPI1ByteReceived+0)
STRB	R2, [R1, #0]
;driverrf4463pro.c,788 :: 		SPI1_DR = ucData;
MOVW	R1, #lo_addr(SPI1_DR+0)
MOVT	R1, #hi_addr(SPI1_DR+0)
STR	R0, [R1, #0]
; ucData end address is: 0 (R0)
;driverrf4463pro.c,790 :: 		while ( !SPI1_SRbits.TXE );                // espera a que el buffer este vacio
L_ucRf4463SPIByte116:
MOVW	R1, #lo_addr(SPI1_SRbits+0)
MOVT	R1, #hi_addr(SPI1_SRbits+0)
_LX	[R1, ByteOffset(SPI1_SRbits+0)]
CMP	R1, #0
IT	NE
BNE	L_ucRf4463SPIByte117
IT	AL
BAL	L_ucRf4463SPIByte116
L_ucRf4463SPIByte117:
;driverrf4463pro.c,792 :: 		while ( SPI1_SRbits.BSY );                // espera a que el buffer este vacio
L_ucRf4463SPIByte118:
MOVW	R1, #lo_addr(SPI1_SRbits+0)
MOVT	R1, #hi_addr(SPI1_SRbits+0)
_LX	[R1, ByteOffset(SPI1_SRbits+0)]
CMP	R1, #0
IT	EQ
BEQ	L_ucRf4463SPIByte119
IT	AL
BAL	L_ucRf4463SPIByte118
L_ucRf4463SPIByte119:
;driverrf4463pro.c,794 :: 		return ( ucSPI1ByteReceived );
MOVW	R1, #lo_addr(_ucSPI1ByteReceived+0)
MOVT	R1, #hi_addr(_ucSPI1ByteReceived+0)
LDRB	R0, [R1, #0]
;driverrf4463pro.c,795 :: 		}
L_end_ucRf4463SPIByte:
BX	LR
; end of _ucRf4463SPIByte
_spi_write:
;driverrf4463pro.c,800 :: 		void spi_write( unsigned char tx_length, unsigned char *p ) {
; p start address is: 4 (R1)
; tx_length start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R2, R1
UXTB	R1, R0
; p end address is: 4 (R1)
; tx_length end address is: 0 (R0)
; tx_length start address is: 4 (R1)
; p start address is: 8 (R2)
;driverrf4463pro.c,803 :: 		i = 0;
; i start address is: 0 (R0)
MOVS	R0, #0
; tx_length end address is: 4 (R1)
; p end address is: 8 (R2)
; i end address is: 0 (R0)
UXTB	R5, R1
MOV	R4, R2
;driverrf4463pro.c,804 :: 		while ( i != 0xFF ) {
L_spi_write120:
; i start address is: 0 (R0)
; p start address is: 16 (R4)
; tx_length start address is: 20 (R5)
CMP	R0, #255
IT	EQ
BEQ	L_spi_write121
; i end address is: 0 (R0)
;driverrf4463pro.c,805 :: 		i = check_cts();
BL	_check_cts+0
; i start address is: 0 (R0)
;driverrf4463pro.c,806 :: 		}
; i end address is: 0 (R0)
IT	AL
BAL	L_spi_write120
L_spi_write121:
;driverrf4463pro.c,808 :: 		nSEL = 0;                              // habilita escritura
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOD_ODRbits+0)
MOVT	R2, #hi_addr(GPIOD_ODRbits+0)
_SX	[R2, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,810 :: 		for ( i = 0; i < tx_length; i++ ) {
; i start address is: 0 (R0)
MOVS	R0, #0
; tx_length end address is: 20 (R5)
; i end address is: 0 (R0)
UXTB	R3, R5
UXTB	R5, R0
L_spi_write122:
; i start address is: 20 (R5)
; tx_length start address is: 12 (R3)
; p start address is: 16 (R4)
; p end address is: 16 (R4)
CMP	R5, R3
IT	CS
BCS	L_spi_write123
; p end address is: 16 (R4)
;driverrf4463pro.c,811 :: 		j = *( p + i );
; p start address is: 16 (R4)
ADDS	R2, R4, R5
;driverrf4463pro.c,812 :: 		ucRf4463SPIByte( j );
LDRB	R0, [R2, #0]
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,810 :: 		for ( i = 0; i < tx_length; i++ ) {
ADDS	R5, R5, #1
UXTB	R5, R5
;driverrf4463pro.c,813 :: 		}
; tx_length end address is: 12 (R3)
; p end address is: 16 (R4)
; i end address is: 20 (R5)
IT	AL
BAL	L_spi_write122
L_spi_write123:
;driverrf4463pro.c,815 :: 		nSEL = 1;                              // desabilita escritura
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOD_ODRbits+0)
MOVT	R2, #hi_addr(GPIOD_ODRbits+0)
_SX	[R2, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,816 :: 		}
L_end_spi_write:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _spi_write
_check_cts:
;driverrf4463pro.c,821 :: 		unsigned char check_cts( void ) {           // This Command follows the Command and reads the response
SUB	SP, SP, #4
STR	LR, [SP, #0]
;driverrf4463pro.c,824 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,825 :: 		nSEL = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,826 :: 		ucRf4463SPIByte( 0x44 );
MOVS	R0, #68
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,827 :: 		i = ucRf4463SPIByte( 0 );
MOVS	R0, #0
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,828 :: 		nSEL = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOD_ODRbits+0)
MOVT	R1, #hi_addr(GPIOD_ODRbits+0)
_SX	[R1, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,829 :: 		return ( i );
;driverrf4463pro.c,830 :: 		}
L_end_check_cts:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _check_cts
_spi_read:
;driverrf4463pro.c,835 :: 		void spi_read( unsigned char data_length, unsigned char api_command ) {
; api_command start address is: 4 (R1)
; data_length start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
; api_command end address is: 4 (R1)
; data_length end address is: 0 (R0)
; data_length start address is: 0 (R0)
; api_command start address is: 4 (R1)
;driverrf4463pro.c,839 :: 		p[ 0 ] = api_command;
ADD	R2, SP, #4
STRB	R1, [R2, #0]
; api_command end address is: 4 (R1)
;driverrf4463pro.c,840 :: 		i = 0;
; i start address is: 4 (R1)
MOVS	R1, #0
; data_length end address is: 0 (R0)
; i end address is: 4 (R1)
UXTB	R6, R0
UXTB	R0, R1
;driverrf4463pro.c,841 :: 		while ( i != 0xFF ) {
L_spi_read125:
; i start address is: 0 (R0)
; data_length start address is: 24 (R6)
CMP	R0, #255
IT	EQ
BEQ	L_spi_read126
; i end address is: 0 (R0)
;driverrf4463pro.c,842 :: 		i = check_cts();                // Check if you can send Command
BL	_check_cts+0
; i start address is: 0 (R0)
;driverrf4463pro.c,843 :: 		}
; i end address is: 0 (R0)
IT	AL
BAL	L_spi_read125
L_spi_read126:
;driverrf4463pro.c,845 :: 		spi_write( 1, p );    // Send Command
ADD	R2, SP, #4
MOV	R1, R2
MOVS	R0, #1
BL	_spi_write+0
;driverrf4463pro.c,847 :: 		i = 0;
; i start address is: 0 (R0)
MOVS	R0, #0
; data_length end address is: 24 (R6)
; i end address is: 0 (R0)
UXTB	R4, R6
;driverrf4463pro.c,848 :: 		while ( i != 0xFF ) {
L_spi_read127:
; i start address is: 0 (R0)
; data_length start address is: 16 (R4)
CMP	R0, #255
IT	EQ
BEQ	L_spi_read128
; i end address is: 0 (R0)
;driverrf4463pro.c,849 :: 		i = check_cts();        //Check whether the data can be read
BL	_check_cts+0
; i start address is: 0 (R0)
;driverrf4463pro.c,850 :: 		}
; i end address is: 0 (R0)
IT	AL
BAL	L_spi_read127
L_spi_read128:
;driverrf4463pro.c,852 :: 		nSEL = 1;
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOD_ODRbits+0)
MOVT	R2, #hi_addr(GPIOD_ODRbits+0)
_SX	[R2, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,853 :: 		nSEL = 0;
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOD_ODRbits+0)
MOVT	R2, #hi_addr(GPIOD_ODRbits+0)
_SX	[R2, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,854 :: 		ucRf4463SPIByte( 0x44 );
MOVS	R0, #68
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,855 :: 		for ( i = 0; i < data_length; i++ ) {        // Read data
; i start address is: 0 (R0)
MOVS	R0, #0
; data_length end address is: 16 (R4)
; i end address is: 0 (R0)
UXTB	R3, R4
UXTB	R4, R0
L_spi_read129:
; i start address is: 16 (R4)
; data_length start address is: 12 (R3)
CMP	R4, R3
IT	CS
BCS	L_spi_read130
;driverrf4463pro.c,856 :: 		spi_read_buf[ i ] = ucRf4463SPIByte( 0x00 );             // 0x00
MOVW	R2, #lo_addr(_spi_read_buf+0)
MOVT	R2, #hi_addr(_spi_read_buf+0)
ADDS	R2, R2, R4
STR	R2, [SP, #8]
MOVS	R0, #0
BL	_ucRf4463SPIByte+0
LDR	R2, [SP, #8]
STRB	R0, [R2, #0]
;driverrf4463pro.c,858 :: 		Delay_ms(1);
MOVW	R7, #55998
MOVT	R7, #0
NOP
NOP
L_spi_read132:
SUBS	R7, R7, #1
BNE	L_spi_read132
NOP
NOP
NOP
;driverrf4463pro.c,855 :: 		for ( i = 0; i < data_length; i++ ) {        // Read data
ADDS	R4, R4, #1
UXTB	R4, R4
;driverrf4463pro.c,859 :: 		}
; data_length end address is: 12 (R3)
; i end address is: 16 (R4)
IT	AL
BAL	L_spi_read129
L_spi_read130:
;driverrf4463pro.c,860 :: 		nSEL = 1;
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOD_ODRbits+0)
MOVT	R2, #hi_addr(GPIOD_ODRbits+0)
_SX	[R2, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,861 :: 		}
L_end_spi_read:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _spi_read
_spi_fast_read:
;driverrf4463pro.c,866 :: 		void spi_fast_read( unsigned char api_command ) {
; api_command start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
; api_command end address is: 0 (R0)
; api_command start address is: 0 (R0)
;driverrf4463pro.c,869 :: 		p[0] = api_command;
ADD	R1, SP, #4
STRB	R0, [R1, #0]
;driverrf4463pro.c,870 :: 		i = 0;
; i start address is: 4 (R1)
MOVS	R1, #0
; api_command end address is: 0 (R0)
; i end address is: 4 (R1)
UXTB	R3, R0
;driverrf4463pro.c,871 :: 		while ( i != 0xFF ) {
L_spi_fast_read134:
; i start address is: 4 (R1)
; api_command start address is: 12 (R3)
CMP	R1, #255
IT	EQ
BEQ	L_spi_fast_read135
; i end address is: 4 (R1)
;driverrf4463pro.c,872 :: 		i = check_cts();                // Check if you can send Command
BL	_check_cts+0
; i start address is: 4 (R1)
UXTB	R1, R0
;driverrf4463pro.c,873 :: 		}
; i end address is: 4 (R1)
IT	AL
BAL	L_spi_fast_read134
L_spi_fast_read135:
;driverrf4463pro.c,875 :: 		nSEL = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOD_ODRbits+0)
MOVT	R1, #hi_addr(GPIOD_ODRbits+0)
_SX	[R1, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,876 :: 		nSEL = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOD_ODRbits+0)
MOVT	R1, #hi_addr(GPIOD_ODRbits+0)
_SX	[R1, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,877 :: 		ucRf4463SPIByte( api_command );    // Send Command
UXTB	R0, R3
; api_command end address is: 12 (R3)
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,878 :: 		for ( i = 0; i < 4; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #0
; i end address is: 12 (R3)
L_spi_fast_read136:
; i start address is: 12 (R3)
CMP	R3, #4
IT	CS
BCS	L_spi_fast_read137
;driverrf4463pro.c,879 :: 		spi_read_buf[ i ] = ucRf4463SPIByte( 0xFF );   // Read out all the 4 registers Value of
MOVW	R1, #lo_addr(_spi_read_buf+0)
MOVT	R1, #hi_addr(_spi_read_buf+0)
ADDS	R1, R1, R3
STR	R1, [SP, #8]
MOVS	R0, #255
BL	_ucRf4463SPIByte+0
LDR	R1, [SP, #8]
STRB	R0, [R1, #0]
;driverrf4463pro.c,878 :: 		for ( i = 0; i < 4; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,880 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_spi_fast_read136
L_spi_fast_read137:
;driverrf4463pro.c,881 :: 		nSEL = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOD_ODRbits+0)
MOVT	R1, #hi_addr(GPIOD_ODRbits+0)
_SX	[R1, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,882 :: 		}
L_end_spi_fast_read:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _spi_fast_read
_spi_write_fifo:
;driverrf4463pro.c,887 :: 		void spi_write_fifo( void ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;driverrf4463pro.c,890 :: 		i = 0;
; i start address is: 0 (R0)
MOVS	R0, #0
; i end address is: 0 (R0)
;driverrf4463pro.c,891 :: 		while ( i != 0xFF ) {
L_spi_write_fifo139:
; i start address is: 0 (R0)
CMP	R0, #255
IT	EQ
BEQ	L_spi_write_fifo140
; i end address is: 0 (R0)
;driverrf4463pro.c,892 :: 		i = check_cts();                // Check if you can send Command
BL	_check_cts+0
; i start address is: 0 (R0)
;driverrf4463pro.c,893 :: 		}
; i end address is: 0 (R0)
IT	AL
BAL	L_spi_write_fifo139
L_spi_write_fifo140:
;driverrf4463pro.c,895 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,896 :: 		nSEL = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,897 :: 		ucRf4463SPIByte( WRITE_TX_FIFO );
MOVS	R0, #102
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,899 :: 		if ( ucRF4463Mode == tx_test_mode) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_spi_write_fifo141
;driverrf4463pro.c,900 :: 		for ( i = 0; i < payload_length; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #0
; i end address is: 12 (R3)
L_spi_write_fifo142:
; i start address is: 12 (R3)
CMP	R3, #66
IT	CS
BCS	L_spi_write_fifo143
;driverrf4463pro.c,901 :: 		ucRf4463SPIByte( tx_test_aa_data[ i ] );   // Send 10 test data
MOVW	R0, #lo_addr(_tx_test_aa_data+0)
MOVT	R0, #hi_addr(_tx_test_aa_data+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,900 :: 		for ( i = 0; i < payload_length; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,902 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_spi_write_fifo142
L_spi_write_fifo143:
;driverrf4463pro.c,903 :: 		}
IT	AL
BAL	L_spi_write_fifo145
L_spi_write_fifo141:
;driverrf4463pro.c,905 :: 		for ( i = 0; i < payload_length; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #0
; i end address is: 12 (R3)
L_spi_write_fifo146:
; i start address is: 12 (R3)
CMP	R3, #66
IT	CS
BCS	L_spi_write_fifo147
;driverrf4463pro.c,906 :: 		ucRf4463SPIByte( ucRF4463TXdata[ i ] );
MOVW	R0, #lo_addr(_ucRF4463TXdata+0)
MOVT	R0, #hi_addr(_ucRF4463TXdata+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,905 :: 		for ( i = 0; i < payload_length; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,907 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_spi_write_fifo146
L_spi_write_fifo147:
;driverrf4463pro.c,908 :: 		}
L_spi_write_fifo145:
;driverrf4463pro.c,909 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,910 :: 		}
L_end_spi_write_fifo:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _spi_write_fifo
_spi_read_fifo:
;driverrf4463pro.c,915 :: 		void spi_read_fifo( void ) {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;driverrf4463pro.c,918 :: 		i = 0;
; i start address is: 0 (R0)
MOVS	R0, #0
; i end address is: 0 (R0)
;driverrf4463pro.c,919 :: 		while ( i != 0xFF ) {
L_spi_read_fifo149:
; i start address is: 0 (R0)
CMP	R0, #255
IT	EQ
BEQ	L_spi_read_fifo150
; i end address is: 0 (R0)
;driverrf4463pro.c,920 :: 		i = check_cts();                   // Check if you can send Command
BL	_check_cts+0
; i start address is: 0 (R0)
;driverrf4463pro.c,921 :: 		}
; i end address is: 0 (R0)
IT	AL
BAL	L_spi_read_fifo149
L_spi_read_fifo150:
;driverrf4463pro.c,923 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,924 :: 		nSEL = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,925 :: 		ucRf4463SPIByte( READ_RX_FIFO );
MOVS	R0, #119
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,926 :: 		for ( i = 0; i < payload_length; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #0
; i end address is: 12 (R3)
L_spi_read_fifo151:
; i start address is: 12 (R3)
CMP	R3, #66
IT	CS
BCS	L_spi_read_fifo152
;driverrf4463pro.c,927 :: 		rx_buf[ i ] = ucRf4463SPIByte( 0xFF );      // Receive 10 test data
MOVW	R0, #lo_addr(_rx_buf+0)
MOVT	R0, #hi_addr(_rx_buf+0)
ADDS	R0, R0, R3
STR	R0, [SP, #4]
MOVS	R0, #255
BL	_ucRf4463SPIByte+0
LDR	R1, [SP, #4]
STRB	R0, [R1, #0]
;driverrf4463pro.c,926 :: 		for ( i = 0; i < payload_length; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,928 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_spi_read_fifo151
L_spi_read_fifo152:
;driverrf4463pro.c,929 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,930 :: 		}
L_end_spi_read_fifo:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _spi_read_fifo
_VRF4463SDNReset:
;driverrf4463pro.c,935 :: 		void VRF4463SDNReset( void ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;driverrf4463pro.c,938 :: 		SDN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,939 :: 		Delay_ms( 6 );        // RF Module reset  DELAY
MOVW	R7, #8318
MOVT	R7, #5
NOP
NOP
L_VRF4463SDNReset154:
SUBS	R7, R7, #1
BNE	L_VRF4463SDNReset154
NOP
NOP
NOP
;driverrf4463pro.c,940 :: 		SDN = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,941 :: 		Delay_ms( 10 );       // Delay 10ms for RF module to enter working state
MOVW	R7, #35710
MOVT	R7, #8
NOP
NOP
L_VRF4463SDNReset156:
SUBS	R7, R7, #1
BNE	L_VRF4463SDNReset156
NOP
NOP
NOP
;driverrf4463pro.c,943 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,944 :: 		nSEL = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,945 :: 		for ( i = 0; i < 7; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #0
; i end address is: 12 (R3)
L_VRF4463SDNReset158:
; i start address is: 12 (R3)
CMP	R3, #7
IT	CS
BCS	L_VRF4463SDNReset159
;driverrf4463pro.c,946 :: 		ucRf4463SPIByte( RF_POWER_UP_data[ i ] );   // send power up Command
MOVW	R0, #lo_addr(_RF_POWER_UP_data+0)
MOVT	R0, #hi_addr(_RF_POWER_UP_data+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,945 :: 		for ( i = 0; i < 7; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,947 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_VRF4463SDNReset158
L_VRF4463SDNReset159:
;driverrf4463pro.c,948 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;driverrf4463pro.c,951 :: 		}
L_end_VRF4463SDNReset:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _VRF4463SDNReset
_ucASCIIToByte:
;utils.c,41 :: 		unsigned char ucASCIIToByte( unsigned char * pcASCIIBuffer ){
; pcASCIIBuffer start address is: 0 (R0)
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
BLS	L_ucASCIIToByte161
;utils.c,47 :: 		ucMSBNibble -= 7;
MOVW	R2, #lo_addr(_ucMSBNibble+0)
MOVT	R2, #hi_addr(_ucMSBNibble+0)
LDRB	R1, [R2, #0]
SUBS	R1, R1, #7
STRB	R1, [R2, #0]
;utils.c,48 :: 		}
L_ucASCIIToByte161:
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
BLS	L_ucASCIIToByte162
;utils.c,52 :: 		ucLSBNibble -= 7;
MOVW	R2, #lo_addr(_ucLSBNibble+0)
MOVT	R2, #hi_addr(_ucLSBNibble+0)
LDRB	R1, [R2, #0]
SUBS	R1, R1, #7
STRB	R1, [R2, #0]
;utils.c,53 :: 		}
L_ucASCIIToByte162:
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
L_vASCIIToHex163:
; ucASCIICounter start address is: 24 (R6)
; pcHexConvertBuffer start address is: 8 (R2)
; ucConversionLength start address is: 0 (R0)
; pcASCIIConvertBuffer start address is: 4 (R1)
; pcASCIIConvertBuffer end address is: 4 (R1)
; pcHexConvertBuffer start address is: 8 (R2)
; pcHexConvertBuffer end address is: 8 (R2)
CMP	R6, R0
IT	CS
BCS	L_vASCIIToHex164
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
BLS	L_vASCIIToHex166
;utils.c,70 :: 		ucMSBNibble -= 7;
MOVW	R4, #lo_addr(_ucMSBNibble+0)
MOVT	R4, #hi_addr(_ucMSBNibble+0)
LDRB	R3, [R4, #0]
SUBS	R3, R3, #7
STRB	R3, [R4, #0]
;utils.c,71 :: 		}
L_vASCIIToHex166:
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
BLS	L_vASCIIToHex167
;utils.c,75 :: 		ucLSBNibble -= 7;
MOVW	R4, #lo_addr(_ucLSBNibble+0)
MOVT	R4, #hi_addr(_ucLSBNibble+0)
LDRB	R3, [R4, #0]
SUBS	R3, R3, #7
STRB	R3, [R4, #0]
;utils.c,76 :: 		}
L_vASCIIToHex167:
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
BAL	L_vASCIIToHex163
L_vASCIIToHex164:
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
L_vHexToASCII168:
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
BCS	L_vHexToASCII169
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
BAL	L_vHexToASCII168
L_vHexToASCII169:
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
L_vBufferSetToZero171:
; usPosition start address is: 16 (R4)
; pcBufferToClean start address is: 4 (R1)
; uslength start address is: 0 (R0)
; pcBufferToClean start address is: 4 (R1)
; pcBufferToClean end address is: 4 (R1)
CMP	R4, R0
IT	CS
BCS	L_vBufferSetToZero172
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
BAL	L_vBufferSetToZero171
L_vBufferSetToZero172:
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
L_vBufferSetTo255174:
; usPosition start address is: 16 (R4)
; pcBufferToClean start address is: 4 (R1)
; uslength start address is: 0 (R0)
; pcBufferToClean start address is: 4 (R1)
; pcBufferToClean end address is: 4 (R1)
CMP	R4, R0
IT	CS
BCS	L_vBufferSetTo255175
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
BAL	L_vBufferSetTo255174
L_vBufferSetTo255175:
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
L_vBufferSetToValue177:
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
BCS	L_vBufferSetToValue178
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
BAL	L_vBufferSetToValue177
L_vBufferSetToValue178:
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
L_vSerializeUUID180:
; ucCounter start address is: 20 (R5)
; pcTextConvertBuffer start address is: 4 (R1)
; pcHexConvertBuffer start address is: 0 (R0)
; pcHexConvertBuffer start address is: 0 (R0)
; pcHexConvertBuffer end address is: 0 (R0)
; pcTextConvertBuffer start address is: 4 (R1)
; pcTextConvertBuffer end address is: 4 (R1)
CMP	R5, #12
IT	CS
BCS	L_vSerializeUUID181
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
BAL	L_vSerializeUUID180
L_vSerializeUUID181:
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
L_vSerializeMACAddress183:
; usCounter start address is: 4 (R1)
; pcTextConvertBuffer start address is: 0 (R0)
CMP	R1, #6
IT	CS
BCS	L_vSerializeMACAddress184
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
BEQ	L_vSerializeMACAddress186
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
L_vSerializeMACAddress186:
;utils.c,148 :: 		for( usCounter = 0; usCounter < 6; usCounter++ ){
ADDS	R1, R1, #1
UXTH	R1, R1
;utils.c,154 :: 		}
; usCounter end address is: 4 (R1)
IT	AL
BAL	L_vSerializeMACAddress183
L_vSerializeMACAddress184:
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
L_vSerializeIPAddress187:
; ucCounter start address is: 28 (R7)
; pcHexConvertBuffer start address is: 24 (R6)
; pcHexConvertBuffer end address is: 24 (R6)
; pcTextConvertBuffer start address is: 32 (R8)
; pcTextConvertBuffer end address is: 32 (R8)
CMP	R7, #4
IT	CS
BCS	L_vSerializeIPAddress188
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
BEQ	L_vSerializeIPAddress190
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
L_vSerializeIPAddress190:
;utils.c,167 :: 		for( ucCounter = 0; ucCounter < 4; ucCounter++ ){
ADDS	R7, R7, #1
UXTB	R7, R7
;utils.c,176 :: 		}
; pcHexConvertBuffer end address is: 24 (R6)
; pcTextConvertBuffer end address is: 32 (R8)
; ucCounter end address is: 28 (R7)
IT	AL
BAL	L_vSerializeIPAddress187
L_vSerializeIPAddress188:
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
BEQ	L_DMA2Strm7_interrupt191
;uarthandler.c,92 :: 		DMA2_HIFCRbits.CFEIF7 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_HIFCRbits+0)
MOVT	R0, #hi_addr(DMA2_HIFCRbits+0)
_SX	[R0, ByteOffset(DMA2_HIFCRbits+0)]
;uarthandler.c,93 :: 		}
IT	AL
BAL	L_DMA2Strm7_interrupt192
L_DMA2Strm7_interrupt191:
;uarthandler.c,94 :: 		else if ( DMA2_HISRbits.DMEIF7 ) {
MOVW	R0, #lo_addr(DMA2_HISRbits+0)
MOVT	R0, #hi_addr(DMA2_HISRbits+0)
_LX	[R0, ByteOffset(DMA2_HISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA2Strm7_interrupt193
;uarthandler.c,95 :: 		DMA2_HIFCRbits.CDMEIF7 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_HIFCRbits+0)
MOVT	R0, #hi_addr(DMA2_HIFCRbits+0)
_SX	[R0, ByteOffset(DMA2_HIFCRbits+0)]
;uarthandler.c,96 :: 		}
IT	AL
BAL	L_DMA2Strm7_interrupt194
L_DMA2Strm7_interrupt193:
;uarthandler.c,97 :: 		else if ( DMA2_HISRbits.TEIF7 ) {     // TRANSFER ERROR INTERRUPT FLAG
MOVW	R0, #lo_addr(DMA2_HISRbits+0)
MOVT	R0, #hi_addr(DMA2_HISRbits+0)
_LX	[R0, ByteOffset(DMA2_HISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA2Strm7_interrupt195
;uarthandler.c,98 :: 		DMA2_HIFCRbits.CTEIF7 = 1;       // limpia el flag de error
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_HIFCRbits+0)
MOVT	R0, #hi_addr(DMA2_HIFCRbits+0)
_SX	[R0, ByteOffset(DMA2_HIFCRbits+0)]
;uarthandler.c,100 :: 		}
IT	AL
BAL	L_DMA2Strm7_interrupt196
L_DMA2Strm7_interrupt195:
;uarthandler.c,101 :: 		else if ( DMA2_HISRbits.HTIF7 ) {
MOVW	R0, #lo_addr(DMA2_HISRbits+0)
MOVT	R0, #hi_addr(DMA2_HISRbits+0)
_LX	[R0, ByteOffset(DMA2_HISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA2Strm7_interrupt197
;uarthandler.c,102 :: 		DMA2_HIFCRbits.CHTIF7 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA2_HIFCRbits+0)
MOVT	R0, #hi_addr(DMA2_HIFCRbits+0)
_SX	[R0, ByteOffset(DMA2_HIFCRbits+0)]
;uarthandler.c,103 :: 		}
IT	AL
BAL	L_DMA2Strm7_interrupt198
L_DMA2Strm7_interrupt197:
;uarthandler.c,104 :: 		else if ( DMA2_HISRbits.TCIF7 ) {     // TRANSFER COMPLETE INTERRUPT FLAG = envio el frame completo
MOVW	R0, #lo_addr(DMA2_HISRbits+0)
MOVT	R0, #hi_addr(DMA2_HISRbits+0)
_LX	[R0, ByteOffset(DMA2_HISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA2Strm7_interrupt199
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
L_DMA2Strm7_interrupt199:
L_DMA2Strm7_interrupt198:
L_DMA2Strm7_interrupt196:
L_DMA2Strm7_interrupt194:
L_DMA2Strm7_interrupt192:
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
BEQ	L_vUARTISR200
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
BEQ	L__vUARTISR459
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	EQ
BEQ	L__vUARTISR458
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R0, [R0, #0]
CMP	R0, #4096
IT	CS
BCS	L__vUARTISR457
L__vUARTISR447:
;uarthandler.c,123 :: 		ucData1 == CHR_s ||
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #83
IT	EQ
BEQ	L__vUARTISR451
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #115
IT	EQ
BEQ	L__vUARTISR450
;uarthandler.c,124 :: 		ucData1 == CHR_U ||
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #85
IT	EQ
BEQ	L__vUARTISR449
;uarthandler.c,125 :: 		ucData1 == CHR_u ) &&
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #117
IT	EQ
BEQ	L__vUARTISR448
IT	AL
BAL	L_vUARTISR208
;uarthandler.c,123 :: 		ucData1 == CHR_s ||
L__vUARTISR451:
L__vUARTISR450:
;uarthandler.c,124 :: 		ucData1 == CHR_U ||
L__vUARTISR449:
;uarthandler.c,125 :: 		ucData1 == CHR_u ) &&
L__vUARTISR448:
;uarthandler.c,126 :: 		ulUSART1ByteReceived == 0 ) {
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L__vUARTISR452
L__vUARTISR445:
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
BAL	L_vUARTISR209
L_vUARTISR208:
;uarthandler.c,126 :: 		ulUSART1ByteReceived == 0 ) {
L__vUARTISR452:
;uarthandler.c,131 :: 		ucUSART1RXBuffer[ 0 ] == CHR_s ||
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
LDRB	R0, [R0, #0]
CMP	R0, #83
IT	EQ
BEQ	L__vUARTISR456
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
LDRB	R0, [R0, #0]
CMP	R0, #115
IT	EQ
BEQ	L__vUARTISR455
;uarthandler.c,132 :: 		ucUSART1RXBuffer[ 0 ] == CHR_U ||
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
LDRB	R0, [R0, #0]
CMP	R0, #85
IT	EQ
BEQ	L__vUARTISR454
;uarthandler.c,133 :: 		ucUSART1RXBuffer[ 0 ] == CHR_u ) {
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
LDRB	R0, [R0, #0]
CMP	R0, #117
IT	EQ
BEQ	L__vUARTISR453
IT	AL
BAL	L_vUARTISR212
;uarthandler.c,131 :: 		ucUSART1RXBuffer[ 0 ] == CHR_s ||
L__vUARTISR456:
L__vUARTISR455:
;uarthandler.c,132 :: 		ucUSART1RXBuffer[ 0 ] == CHR_U ||
L__vUARTISR454:
;uarthandler.c,133 :: 		ucUSART1RXBuffer[ 0 ] == CHR_u ) {
L__vUARTISR453:
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
L_vUARTISR212:
L_vUARTISR209:
;uarthandler.c,136 :: 		}
IT	AL
BAL	L_vUARTISR213
;uarthandler.c,120 :: 		if ( ucData1 != CHR_CR && ucData1 != CHR_LF && ulUSART1ByteReceived < BUFFER_MAX_USART ) {
L__vUARTISR459:
L__vUARTISR458:
L__vUARTISR457:
;uarthandler.c,138 :: 		else if ( ucData1 == CHR_CR ) {
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #13
IT	NE
BNE	L_vUARTISR214
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
BAL	L_vUARTISR215
L_vUARTISR214:
;uarthandler.c,142 :: 		else if ( ucData1 == CHR_LF && ucUSART1RXBuffer[ ulUSART1ByteReceived - 1 ] == CHR_CR ) {
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	NE
BNE	L__vUARTISR461
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
BNE	L__vUARTISR460
L__vUARTISR443:
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
;uarthandler.c,142 :: 		else if ( ucData1 == CHR_LF && ucUSART1RXBuffer[ ulUSART1ByteReceived - 1 ] == CHR_CR ) {
L__vUARTISR461:
L__vUARTISR460:
;uarthandler.c,145 :: 		}
L_vUARTISR215:
L_vUARTISR213:
;uarthandler.c,146 :: 		}
L_vUARTISR200:
;uarthandler.c,147 :: 		}
L_end_vUARTISR:
BX	LR
; end of _vUARTISR
_vUSARTStartMEMtoMEMZero:
;uarthandler.c,158 :: 		unsigned char vUSARTStartMEMtoMEMZero ( unsigned long *pcBufferDestination, unsigned long ulSizeInBytes ) {
; ulSizeInBytes start address is: 4 (R1)
; pcBufferDestination start address is: 0 (R0)
; ulSizeInBytes end address is: 4 (R1)
; pcBufferDestination end address is: 0 (R0)
; pcBufferDestination start address is: 0 (R0)
; ulSizeInBytes start address is: 4 (R1)
; pcBufferDestination end address is: 0 (R0)
; ulSizeInBytes end address is: 4 (R1)
;uarthandler.c,160 :: 		while ( DMA2_S4CRbits.EN );
L_vUSARTStartMEMtoMEMZero219:
; ulSizeInBytes start address is: 4 (R1)
; pcBufferDestination start address is: 0 (R0)
MOVW	R2, #lo_addr(DMA2_S4CRbits+0)
MOVT	R2, #hi_addr(DMA2_S4CRbits+0)
_LX	[R2, ByteOffset(DMA2_S4CRbits+0)]
CMP	R2, #0
IT	EQ
BEQ	L_vUSARTStartMEMtoMEMZero220
IT	AL
BAL	L_vUSARTStartMEMtoMEMZero219
L_vUSARTStartMEMtoMEMZero220:
;uarthandler.c,162 :: 		if ( ulSizeInBytes > 0 ) {                // la transmision anterior termino?
CMP	R1, #0
IT	LS
BLS	L_vUSARTStartMEMtoMEMZero221
;uarthandler.c,163 :: 		DMA2_S4CRbits.EN = 0;                  // Desabilita la recepci?n para poder modificar los par?metros
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(DMA2_S4CRbits+0)
MOVT	R2, #hi_addr(DMA2_S4CRbits+0)
_SX	[R2, ByteOffset(DMA2_S4CRbits+0)]
; pcBufferDestination end address is: 0 (R0)
; ulSizeInBytes end address is: 4 (R1)
;uarthandler.c,164 :: 		while ( DMA2_S4CRbits.EN );            // espera a que se haya desabilitado realmente
L_vUSARTStartMEMtoMEMZero222:
; pcBufferDestination start address is: 0 (R0)
; ulSizeInBytes start address is: 4 (R1)
MOVW	R2, #lo_addr(DMA2_S4CRbits+0)
MOVT	R2, #hi_addr(DMA2_S4CRbits+0)
_LX	[R2, ByteOffset(DMA2_S4CRbits+0)]
CMP	R2, #0
IT	EQ
BEQ	L_vUSARTStartMEMtoMEMZero223
IT	AL
BAL	L_vUSARTStartMEMtoMEMZero222
L_vUSARTStartMEMtoMEMZero223:
;uarthandler.c,167 :: 		DMA2_S4PAR = ( unsigned long ) &ucUSARTNull;          // Direccion de periferico a rutear
MOVW	R3, #lo_addr(_ucUSARTNull+0)
MOVT	R3, #hi_addr(_ucUSARTNull+0)
MOVW	R2, #lo_addr(DMA2_S4PAR+0)
MOVT	R2, #hi_addr(DMA2_S4PAR+0)
STR	R3, [R2, #0]
;uarthandler.c,168 :: 		DMA2_S4M0AR = ( unsigned long ) pcBufferDestination;  // Direccion de la memoria a rutear
MOVW	R2, #lo_addr(DMA2_S4M0AR+0)
MOVT	R2, #hi_addr(DMA2_S4M0AR+0)
STR	R0, [R2, #0]
; pcBufferDestination end address is: 0 (R0)
;uarthandler.c,170 :: 		DMA2_S4NDTR = ulSizeInBytes;           // Tamagno de datos a manejar (Header + Payload)
MOVW	R2, #lo_addr(DMA2_S4NDTR+0)
MOVT	R2, #hi_addr(DMA2_S4NDTR+0)
STR	R1, [R2, #0]
; ulSizeInBytes end address is: 4 (R1)
;uarthandler.c,171 :: 		DMA2_S4CRbits.EN = 1;
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(DMA2_S4CRbits+0)
MOVT	R2, #hi_addr(DMA2_S4CRbits+0)
_SX	[R2, ByteOffset(DMA2_S4CRbits+0)]
;uarthandler.c,172 :: 		while ( DMA2_S4CRbits.EN );
L_vUSARTStartMEMtoMEMZero224:
MOVW	R2, #lo_addr(DMA2_S4CRbits+0)
MOVT	R2, #hi_addr(DMA2_S4CRbits+0)
_LX	[R2, ByteOffset(DMA2_S4CRbits+0)]
CMP	R2, #0
IT	EQ
BEQ	L_vUSARTStartMEMtoMEMZero225
IT	AL
BAL	L_vUSARTStartMEMtoMEMZero224
L_vUSARTStartMEMtoMEMZero225:
;uarthandler.c,173 :: 		return 1;                              // indica que transmitio
MOVS	R0, #1
IT	AL
BAL	L_end_vUSARTStartMEMtoMEMZero
;uarthandler.c,174 :: 		}
L_vUSARTStartMEMtoMEMZero221:
;uarthandler.c,175 :: 		return 0;                                 // indica que NO transmitio
MOVS	R0, #0
;uarthandler.c,176 :: 		}
L_end_vUSARTStartMEMtoMEMZero:
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
L_vUSARTDMAMeToMemZero226:
MOVW	R0, #lo_addr(DMA2_S4CRbits+0)
MOVT	R0, #hi_addr(DMA2_S4CRbits+0)
_LX	[R0, ByteOffset(DMA2_S4CRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUSARTDMAMeToMemZero227
IT	AL
BAL	L_vUSARTDMAMeToMemZero226
L_vUSARTDMAMeToMemZero227:
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
; ulSizeInBytes start address is: 8 (R2)
; pcBufferDestination start address is: 4 (R1)
; pcBufferOrigin start address is: 0 (R0)
SUB	SP, SP, #4
; ulSizeInBytes end address is: 8 (R2)
; pcBufferDestination end address is: 4 (R1)
; pcBufferOrigin end address is: 0 (R0)
; pcBufferOrigin start address is: 0 (R0)
; pcBufferDestination start address is: 4 (R1)
; ulSizeInBytes start address is: 8 (R2)
STR	R2, [SP, #0]
; pcBufferOrigin end address is: 0 (R0)
; pcBufferDestination end address is: 4 (R1)
; ulSizeInBytes end address is: 8 (R2)
MOV	R2, R0
LDR	R0, [SP, #0]
;uarthandler.c,208 :: 		while ( DMA2_S1CRbits.EN );
L_vUSARTStartMEMtoMEM228:
; ulSizeInBytes start address is: 0 (R0)
; pcBufferDestination start address is: 4 (R1)
; pcBufferOrigin start address is: 8 (R2)
MOVW	R3, #lo_addr(DMA2_S1CRbits+0)
MOVT	R3, #hi_addr(DMA2_S1CRbits+0)
_LX	[R3, ByteOffset(DMA2_S1CRbits+0)]
CMP	R3, #0
IT	EQ
BEQ	L_vUSARTStartMEMtoMEM229
IT	AL
BAL	L_vUSARTStartMEMtoMEM228
L_vUSARTStartMEMtoMEM229:
;uarthandler.c,210 :: 		if ( ulSizeInBytes > 0 ) {                // la transmision anterior termino?
CMP	R0, #0
IT	LS
BLS	L_vUSARTStartMEMtoMEM230
;uarthandler.c,211 :: 		DMA2_S1CRbits.EN = 0;                  // Desabilita la recepci?n para poder modificar los par?metros
MOVS	R4, #0
SXTB	R4, R4
MOVW	R3, #lo_addr(DMA2_S1CRbits+0)
MOVT	R3, #hi_addr(DMA2_S1CRbits+0)
_SX	[R3, ByteOffset(DMA2_S1CRbits+0)]
; ulSizeInBytes end address is: 0 (R0)
; pcBufferOrigin end address is: 8 (R2)
; pcBufferDestination end address is: 4 (R1)
STR	R2, [SP, #0]
MOV	R2, R0
LDR	R0, [SP, #0]
;uarthandler.c,212 :: 		while ( DMA2_S1CRbits.EN );            // espera a que se haya desabilitado realmente
L_vUSARTStartMEMtoMEM231:
; pcBufferOrigin start address is: 0 (R0)
; pcBufferDestination start address is: 4 (R1)
; ulSizeInBytes start address is: 8 (R2)
MOVW	R3, #lo_addr(DMA2_S1CRbits+0)
MOVT	R3, #hi_addr(DMA2_S1CRbits+0)
_LX	[R3, ByteOffset(DMA2_S1CRbits+0)]
CMP	R3, #0
IT	EQ
BEQ	L_vUSARTStartMEMtoMEM232
IT	AL
BAL	L_vUSARTStartMEMtoMEM231
L_vUSARTStartMEMtoMEM232:
;uarthandler.c,215 :: 		DMA2_S1PAR = ( unsigned long ) pcBufferOrigin;        // Direccion de periferico a rutear
MOVW	R3, #lo_addr(DMA2_S1PAR+0)
MOVT	R3, #hi_addr(DMA2_S1PAR+0)
STR	R0, [R3, #0]
; pcBufferOrigin end address is: 0 (R0)
;uarthandler.c,216 :: 		DMA2_S1M0AR = ( unsigned long ) pcBufferDestination;  // Direccion de la memoria a rutear
MOVW	R3, #lo_addr(DMA2_S1M0AR+0)
MOVT	R3, #hi_addr(DMA2_S1M0AR+0)
STR	R1, [R3, #0]
; pcBufferDestination end address is: 4 (R1)
;uarthandler.c,218 :: 		DMA2_S1NDTR = ulSizeInBytes;           // Tamagno de datos a manejar (Header + Payload)
MOVW	R3, #lo_addr(DMA2_S1NDTR+0)
MOVT	R3, #hi_addr(DMA2_S1NDTR+0)
STR	R2, [R3, #0]
; ulSizeInBytes end address is: 8 (R2)
;uarthandler.c,219 :: 		DMA2_S1CRbits.EN = 1;
MOVS	R4, #1
SXTB	R4, R4
MOVW	R3, #lo_addr(DMA2_S1CRbits+0)
MOVT	R3, #hi_addr(DMA2_S1CRbits+0)
_SX	[R3, ByteOffset(DMA2_S1CRbits+0)]
;uarthandler.c,220 :: 		while ( DMA2_S1CRbits.EN );
L_vUSARTStartMEMtoMEM233:
MOVW	R3, #lo_addr(DMA2_S1CRbits+0)
MOVT	R3, #hi_addr(DMA2_S1CRbits+0)
_LX	[R3, ByteOffset(DMA2_S1CRbits+0)]
CMP	R3, #0
IT	EQ
BEQ	L_vUSARTStartMEMtoMEM234
IT	AL
BAL	L_vUSARTStartMEMtoMEM233
L_vUSARTStartMEMtoMEM234:
;uarthandler.c,221 :: 		return 1;                              // indica que transmitio
MOVS	R0, #1
IT	AL
BAL	L_end_vUSARTStartMEMtoMEM
;uarthandler.c,222 :: 		}
L_vUSARTStartMEMtoMEM230:
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
L_vUSARTDMAMemToMem235:
MOVW	R0, #lo_addr(DMA2_S1CRbits+0)
MOVT	R0, #hi_addr(DMA2_S1CRbits+0)
_LX	[R0, ByteOffset(DMA2_S1CRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUSARTDMAMemToMem236
IT	AL
BAL	L_vUSARTDMAMemToMem235
L_vUSARTDMAMemToMem236:
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
; ulSize start address is: 4 (R1)
; ucBuffer start address is: 0 (R0)
SUB	SP, SP, #4
; ulSize end address is: 4 (R1)
; ucBuffer end address is: 0 (R0)
; ucBuffer start address is: 0 (R0)
; ulSize start address is: 4 (R1)
STR	R1, [SP, #0]
; ucBuffer end address is: 0 (R0)
; ulSize end address is: 4 (R1)
MOV	R1, R0
LDR	R0, [SP, #0]
;uarthandler.c,256 :: 		while ( DMA2_S7CRbits.EN || !USART1_SRbits.TC );
L_vUSART1Start_TX237:
; ucBuffer start address is: 4 (R1)
; ulSize start address is: 0 (R0)
; ulSize start address is: 0 (R0)
; ulSize end address is: 0 (R0)
; ucBuffer start address is: 4 (R1)
; ucBuffer end address is: 4 (R1)
MOVW	R2, #lo_addr(DMA2_S7CRbits+0)
MOVT	R2, #hi_addr(DMA2_S7CRbits+0)
_LX	[R2, ByteOffset(DMA2_S7CRbits+0)]
CMP	R2, #0
IT	NE
BNE	L__vUSART1Start_TX466
; ulSize end address is: 0 (R0)
; ucBuffer end address is: 4 (R1)
; ucBuffer start address is: 4 (R1)
; ulSize start address is: 0 (R0)
MOVW	R2, #lo_addr(USART1_SRbits+0)
MOVT	R2, #hi_addr(USART1_SRbits+0)
_LX	[R2, ByteOffset(USART1_SRbits+0)]
CMP	R2, #0
IT	EQ
BEQ	L__vUSART1Start_TX465
IT	AL
BAL	L_vUSART1Start_TX238
L__vUSART1Start_TX466:
L__vUSART1Start_TX465:
IT	AL
BAL	L_vUSART1Start_TX237
L_vUSART1Start_TX238:
;uarthandler.c,258 :: 		if ( USART1_CR1bits.UE && USART1_SRbits.TC && ulSize > 0 ) { // la transmision anterior termino?
MOVW	R2, #lo_addr(USART1_CR1bits+0)
MOVT	R2, #hi_addr(USART1_CR1bits+0)
_LX	[R2, ByteOffset(USART1_CR1bits+0)]
CMP	R2, #0
IT	EQ
BEQ	L__vUSART1Start_TX471
MOVW	R2, #lo_addr(USART1_SRbits+0)
MOVT	R2, #hi_addr(USART1_SRbits+0)
_LX	[R2, ByteOffset(USART1_SRbits+0)]
CMP	R2, #0
IT	EQ
BEQ	L__vUSART1Start_TX470
CMP	R0, #0
IT	LS
BLS	L__vUSART1Start_TX469
L__vUSART1Start_TX463:
;uarthandler.c,259 :: 		DMA2_S7CRbits.EN = 0;                       // Desabilita la recepci?n para poder modificar los par?metros
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(DMA2_S7CRbits+0)
MOVT	R2, #hi_addr(DMA2_S7CRbits+0)
_SX	[R2, ByteOffset(DMA2_S7CRbits+0)]
; ulSize end address is: 0 (R0)
; ucBuffer end address is: 4 (R1)
STR	R1, [SP, #0]
MOV	R1, R0
LDR	R0, [SP, #0]
;uarthandler.c,260 :: 		while ( DMA2_S7CRbits.EN );                 // espera a que se haya desabilitado realmente
L_vUSART1Start_TX244:
; ucBuffer start address is: 0 (R0)
; ulSize start address is: 4 (R1)
MOVW	R2, #lo_addr(DMA2_S7CRbits+0)
MOVT	R2, #hi_addr(DMA2_S7CRbits+0)
_LX	[R2, ByteOffset(DMA2_S7CRbits+0)]
CMP	R2, #0
IT	EQ
BEQ	L_vUSART1Start_TX245
IT	AL
BAL	L_vUSART1Start_TX244
L_vUSART1Start_TX245:
;uarthandler.c,262 :: 		DMA2_S7M0AR = ( unsigned long ) ucBuffer;   // Direcci?n de la memoria a rutear
MOVW	R2, #lo_addr(DMA2_S7M0AR+0)
MOVT	R2, #hi_addr(DMA2_S7M0AR+0)
STR	R0, [R2, #0]
; ucBuffer end address is: 0 (R0)
;uarthandler.c,263 :: 		DMA2_S7NDTR = ulSize;                       // Tama?o de datos a manejar
MOVW	R2, #lo_addr(DMA2_S7NDTR+0)
MOVT	R2, #hi_addr(DMA2_S7NDTR+0)
STR	R1, [R2, #0]
; ulSize end address is: 4 (R1)
;uarthandler.c,264 :: 		DMA2_S7CRbits.EN = 1;
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(DMA2_S7CRbits+0)
MOVT	R2, #hi_addr(DMA2_S7CRbits+0)
_SX	[R2, ByteOffset(DMA2_S7CRbits+0)]
;uarthandler.c,265 :: 		while ( DMA2_S7CRbits.EN || !USART1_SRbits.TC );
L_vUSART1Start_TX246:
MOVW	R2, #lo_addr(DMA2_S7CRbits+0)
MOVT	R2, #hi_addr(DMA2_S7CRbits+0)
_LX	[R2, ByteOffset(DMA2_S7CRbits+0)]
CMP	R2, #0
IT	NE
BNE	L__vUSART1Start_TX468
MOVW	R2, #lo_addr(USART1_SRbits+0)
MOVT	R2, #hi_addr(USART1_SRbits+0)
_LX	[R2, ByteOffset(USART1_SRbits+0)]
CMP	R2, #0
IT	EQ
BEQ	L__vUSART1Start_TX467
IT	AL
BAL	L_vUSART1Start_TX247
L__vUSART1Start_TX468:
L__vUSART1Start_TX467:
IT	AL
BAL	L_vUSART1Start_TX246
L_vUSART1Start_TX247:
;uarthandler.c,266 :: 		return 1;                                   // indica que transmitio
MOVS	R0, #1
IT	AL
BAL	L_end_vUSART1Start_TX
;uarthandler.c,258 :: 		if ( USART1_CR1bits.UE && USART1_SRbits.TC && ulSize > 0 ) { // la transmision anterior termino?
L__vUSART1Start_TX471:
L__vUSART1Start_TX470:
L__vUSART1Start_TX469:
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
L_vInitDMAUSART1_TX250:
MOVW	R0, #lo_addr(DMA2_S7CRbits+0)
MOVT	R0, #hi_addr(DMA2_S7CRbits+0)
_LX	[R0, ByteOffset(DMA2_S7CRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vInitDMAUSART1_TX251
IT	AL
BAL	L_vInitDMAUSART1_TX250
L_vInitDMAUSART1_TX251:
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
; ulBaudRate start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; ulBaudRate end address is: 0 (R0)
; ulBaudRate start address is: 0 (R0)
;uarthandler.c,299 :: 		UART1_Init_Advanced( ulBaudRate, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PB67 );
MOVW	R1, #lo_addr(__GPIO_MODULE_USART1_PB67+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_USART1_PB67+0)
PUSH	(R1)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
; ulBaudRate end address is: 0 (R0)
BL	_UART1_Init_Advanced+0
ADD	SP, SP, #4
;uarthandler.c,300 :: 		USART1_CR1bits.UE = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(USART1_CR1bits+0)
MOVT	R1, #hi_addr(USART1_CR1bits+0)
_SX	[R1, ByteOffset(USART1_CR1bits+0)]
;uarthandler.c,302 :: 		ulClk = Clock_MHz() * 1000000;         // paso extra para verificacion en depuracion
MOVW	R2, #31232
MOVT	R2, #2563
MOVW	R1, #lo_addr(_ulClk+0)
MOVT	R1, #hi_addr(_ulClk+0)
STR	R2, [R1, #0]
;uarthandler.c,306 :: 		USART1_CR1bits.UE = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(USART1_CR1bits+0)
MOVT	R1, #hi_addr(USART1_CR1bits+0)
_SX	[R1, ByteOffset(USART1_CR1bits+0)]
;uarthandler.c,308 :: 		}
L_end_vUSARTConfigUSART1:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUSARTConfigUSART1
_vUSARTCleanBuffer:
;uarthandler.c,314 :: 		void vUSARTCleanBuffer ( unsigned char *ucBuffer, unsigned int uiCnt ) {
; uiCnt start address is: 4 (R1)
; ucBuffer start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; uiCnt end address is: 4 (R1)
; ucBuffer end address is: 0 (R0)
; ucBuffer start address is: 0 (R0)
; uiCnt start address is: 4 (R1)
;uarthandler.c,316 :: 		vUSARTStartMEMtoMEMZero( ucBuffer, uiCnt );
; uiCnt end address is: 4 (R1)
; ucBuffer end address is: 0 (R0)
BL	_vUSARTStartMEMtoMEMZero+0
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
UXTH	R1, R0
MOVW	R0, #lo_addr(_ucUSARTActiveBuffer1+0)
MOVT	R0, #hi_addr(_ucUSARTActiveBuffer1+0)
BL	_vUSARTCleanBuffer+0
;uarthandler.c,325 :: 		vUSARTStartMEMtoMEM( ucUSART1RXBuffer, ucUSARTActiveBuffer1, ulUSART1ByteReceived ); // copia el buffer de entrada
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R0, [R0, #0]
MOV	R2, R0
MOVW	R1, #lo_addr(_ucUSARTActiveBuffer1+0)
MOVT	R1, #hi_addr(_ucUSARTActiveBuffer1+0)
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
BL	_vUSARTStartMEMtoMEM+0
;uarthandler.c,326 :: 		vUSARTCleanBuffer( ucUSART1RXBuffer, ulUSART1ByteReceived );          // lo limpia
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R0, [R0, #0]
UXTH	R1, R0
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
BL	_vUSARTCleanBuffer+0
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
BL	_vRF4463MainCommandProcessor+0
;uarthandler.c,331 :: 		}
L_end_vUSARTReceivedFromUSART1:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUSARTReceivedFromUSART1
_vUARTRxMessage:
;uarthandler.c,337 :: 		void vUARTRxMessage(){
;uarthandler.c,338 :: 		unsigned int usCounter = 0;
;uarthandler.c,350 :: 		usUARTMessageLength = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_usUARTMessageLength+0)
MOVT	R0, #hi_addr(_usUARTMessageLength+0)
STRH	R1, [R0, #0]
;uarthandler.c,351 :: 		}
L_end_vUARTRxMessage:
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
BX	LR
; end of _vRF4463MainSetTXString
_vRF4463MainCommandProcessor:
;DriverRF4463PROMain.c,137 :: 		void vRF4463MainCommandProcessor ( unsigned char *ucBuffer ) {
; ucBuffer start address is: 0 (R0)
SUB	SP, SP, #192
STR	LR, [SP, #0]
MOV	R5, R0
; ucBuffer end address is: 0 (R0)
; ucBuffer start address is: 20 (R5)
;DriverRF4463PROMain.c,138 :: 		unsigned char ucCommand [ 32 ] = { 0x00 };
ADD	R11, SP, #26
ADD	R10, R11, #96
MOVW	R12, #lo_addr(?ICSvRF4463MainCommandProcessor_ucCommand_L0+0)
MOVT	R12, #hi_addr(?ICSvRF4463MainCommandProcessor_ucCommand_L0+0)
BL	___CC2DW+0
;DriverRF4463PROMain.c,140 :: 		unsigned char ucLongArgument[ 64 ] = { 0x00 };     // Espera argumentos de hasta 11 bytes
;DriverRF4463PROMain.c,141 :: 		unsigned char ucCounterBuffer = 0;
; ucCounterBuffer start address is: 12 (R3)
MOVS	R3, #0
;DriverRF4463PROMain.c,142 :: 		unsigned char ucCounterCommand = 0;
; ucCounterCommand start address is: 16 (R4)
MOVS	R4, #0
;DriverRF4463PROMain.c,143 :: 		unsigned char ucCounterLongArgument = 0;
; ucCounterLongArgument start address is: 24 (R6)
MOVS	R6, #0
;DriverRF4463PROMain.c,145 :: 		unsigned char ucTXT [ 64 ] = { 0x00 };             // string de conversiones temporales
ADD	R11, SP, #122
ADD	R10, R11, #64
MOVW	R12, #lo_addr(?ICSvRF4463MainCommandProcessor_ucTXT_L0+0)
MOVT	R12, #hi_addr(?ICSvRF4463MainCommandProcessor_ucTXT_L0+0)
BL	___CC2DW+0
;DriverRF4463PROMain.c,147 :: 		ulArgument = 0;
MOVS	R2, #0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R2, [R1, #0]
;DriverRF4463PROMain.c,150 :: 		if ( ucBuffer[ 0 ] > '@' && ucBuffer[ 0 ] <= 'z' ) {
LDRB	R1, [R5, #0]
CMP	R1, #64
IT	LS
BLS	L__vRF4463MainCommandProcessor521
LDRB	R1, [R5, #0]
CMP	R1, #122
IT	HI
BHI	L__vRF4463MainCommandProcessor522
L__vRF4463MainCommandProcessor487:
;DriverRF4463PROMain.c,152 :: 		while ( ucBuffer[ ucCounterBuffer ] != '|' && ucCounterCommand < 32 ) {      // primer token
; ucCounterBuffer end address is: 12 (R3)
; ucCounterLongArgument end address is: 24 (R6)
; ucBuffer end address is: 20 (R5)
UXTB	R2, R6
L_vRF4463MainCommandProcessor255:
; ucCounterCommand end address is: 16 (R4)
; ucCounterLongArgument start address is: 8 (R2)
; ucCounterCommand start address is: 16 (R4)
; ucCounterBuffer start address is: 12 (R3)
; ucBuffer start address is: 20 (R5)
ADDS	R1, R5, R3
LDRB	R1, [R1, #0]
CMP	R1, #124
IT	EQ
BEQ	L__vRF4463MainCommandProcessor489
CMP	R4, #32
IT	CS
BCS	L__vRF4463MainCommandProcessor488
L__vRF4463MainCommandProcessor486:
;DriverRF4463PROMain.c,153 :: 		ucCommand[ ucCounterCommand++ ] = toupper( ucBuffer[ ucCounterBuffer++ ] );
ADD	R1, SP, #26
ADDS	R1, R1, R4
STR	R1, [SP, #188]
ADDS	R1, R5, R3
LDRB	R1, [R1, #0]
UXTB	R0, R1
BL	_toupper+0
LDR	R1, [SP, #188]
STRB	R0, [R1, #0]
ADDS	R4, R4, #1
UXTB	R4, R4
ADDS	R3, R3, #1
UXTB	R3, R3
;DriverRF4463PROMain.c,154 :: 		}
; ucCounterCommand end address is: 16 (R4)
IT	AL
BAL	L_vRF4463MainCommandProcessor255
;DriverRF4463PROMain.c,152 :: 		while ( ucBuffer[ ucCounterBuffer ] != '|' && ucCounterCommand < 32 ) {      // primer token
L__vRF4463MainCommandProcessor489:
L__vRF4463MainCommandProcessor488:
;DriverRF4463PROMain.c,156 :: 		ucCounterBuffer++;                                                           // evita el Token
ADDS	R4, R3, #1
UXTB	R4, R4
; ucCounterBuffer end address is: 12 (R3)
; ucCounterBuffer start address is: 16 (R4)
; ucCounterLongArgument end address is: 8 (R2)
; ucCounterBuffer end address is: 16 (R4)
; ucBuffer end address is: 20 (R5)
UXTB	R3, R2
MOV	R0, R5
;DriverRF4463PROMain.c,158 :: 		while ( ucBuffer[ ucCounterBuffer ] != CHR_CR && ucCounterLongArgument < 64 ) {   // segundo token
L_vRF4463MainCommandProcessor259:
; ucCounterBuffer start address is: 16 (R4)
; ucBuffer start address is: 0 (R0)
; ucCounterLongArgument start address is: 12 (R3)
ADDS	R1, R0, R4
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vRF4463MainCommandProcessor491
CMP	R3, #64
IT	CS
BCS	L__vRF4463MainCommandProcessor490
L__vRF4463MainCommandProcessor485:
;DriverRF4463PROMain.c,159 :: 		ucLongArgument[ ucCounterLongArgument ] = ucBuffer[ ucCounterBuffer ] ;   //  toupper(
ADD	R1, SP, #58
ADDS	R2, R1, R3
ADDS	R1, R0, R4
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
;DriverRF4463PROMain.c,160 :: 		ucCounterBuffer++;
ADDS	R4, R4, #1
UXTB	R4, R4
;DriverRF4463PROMain.c,161 :: 		ucCounterLongArgument++;
ADDS	R3, R3, #1
UXTB	R3, R3
;DriverRF4463PROMain.c,162 :: 		}
; ucCounterBuffer end address is: 16 (R4)
IT	AL
BAL	L_vRF4463MainCommandProcessor259
;DriverRF4463PROMain.c,158 :: 		while ( ucBuffer[ ucCounterBuffer ] != CHR_CR && ucCounterLongArgument < 64 ) {   // segundo token
L__vRF4463MainCommandProcessor491:
L__vRF4463MainCommandProcessor490:
;DriverRF4463PROMain.c,150 :: 		if ( ucBuffer[ 0 ] > '@' && ucBuffer[ 0 ] <= 'z' ) {
MOV	R5, R0
; ucCounterLongArgument end address is: 12 (R3)
UXTB	R6, R3
IT	AL
BAL	L__vRF4463MainCommandProcessor493
; ucBuffer end address is: 0 (R0)
L__vRF4463MainCommandProcessor521:
L__vRF4463MainCommandProcessor493:
; ucCounterLongArgument start address is: 24 (R6)
; ucBuffer start address is: 20 (R5)
; ucCounterLongArgument end address is: 24 (R6)
; ucBuffer end address is: 20 (R5)
IT	AL
BAL	L__vRF4463MainCommandProcessor492
L__vRF4463MainCommandProcessor522:
L__vRF4463MainCommandProcessor492:
;DriverRF4463PROMain.c,167 :: 		if ( memcmp( CMD_RADIO_POWER_SET, ucCommand, sizeof( CMD_RADIO_POWER_SET ) ) == 0x00 ) {
; ucCounterLongArgument start address is: 24 (R6)
; ucBuffer start address is: 20 (R5)
ADD	R1, SP, #26
MOVS	R2, #10
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_POWER_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_POWER_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor263
; ucCounterLongArgument end address is: 24 (R6)
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,168 :: 		ulArgument = StrToShort( ucLongArgument );
ADD	R1, SP, #58
MOV	R0, R1
BL	_StrToShort+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,170 :: 		if ( ulArgument > 0 && ulArgument <= 127 ) {
LDR	R1, [R1, #0]
CMP	R1, #0
IT	LS
BLS	L__vRF4463MainCommandProcessor495
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #127
IT	HI
BHI	L__vRF4463MainCommandProcessor494
L__vRF4463MainCommandProcessor484:
;DriverRF4463PROMain.c,171 :: 		ucRF4463Power = ulArgument;
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #lo_addr(_ucRF4463Power+0)
MOVT	R1, #hi_addr(_ucRF4463Power+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,172 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,173 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,174 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor267
;DriverRF4463PROMain.c,170 :: 		if ( ulArgument > 0 && ulArgument <= 127 ) {
L__vRF4463MainCommandProcessor495:
L__vRF4463MainCommandProcessor494:
;DriverRF4463PROMain.c,176 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,177 :: 		}
L_vRF4463MainCommandProcessor267:
;DriverRF4463PROMain.c,178 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor268
L_vRF4463MainCommandProcessor263:
;DriverRF4463PROMain.c,182 :: 		else if ( memcmp( CMD_RADIO_BAND_SET, ucCommand, sizeof( CMD_RADIO_BAND_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
; ucCounterLongArgument start address is: 24 (R6)
ADD	R1, SP, #26
MOVS	R2, #9
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_BAND_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_BAND_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor269
; ucCounterLongArgument end address is: 24 (R6)
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,183 :: 		ulArgument = StrToInt( ucLongArgument );
ADD	R1, SP, #58
MOV	R0, R1
BL	_StrToInt+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,185 :: 		if ( ulArgument == 433 || ulArgument == 868 || ulArgument == 915 ) {
LDR	R2, [R1, #0]
MOVW	R1, #433
CMP	R2, R1
IT	EQ
BEQ	L__vRF4463MainCommandProcessor498
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #868
IT	EQ
BEQ	L__vRF4463MainCommandProcessor497
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #915
CMP	R2, R1
IT	EQ
BEQ	L__vRF4463MainCommandProcessor496
IT	AL
BAL	L_vRF4463MainCommandProcessor272
L__vRF4463MainCommandProcessor498:
L__vRF4463MainCommandProcessor497:
L__vRF4463MainCommandProcessor496:
;DriverRF4463PROMain.c,186 :: 		ucRF4463Freq3 = ucLongArgument[ 0 ] - 48;
ADD	R3, SP, #58
LDRB	R1, [R3, #0]
SUBW	R2, R1, #48
MOVW	R1, #lo_addr(_ucRF4463Freq3+0)
MOVT	R1, #hi_addr(_ucRF4463Freq3+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,187 :: 		ucRF4463Freq2 = ucLongArgument[ 1 ] - 48;
ADDS	R1, R3, #1
LDRB	R1, [R1, #0]
SUBW	R2, R1, #48
MOVW	R1, #lo_addr(_ucRF4463Freq2+0)
MOVT	R1, #hi_addr(_ucRF4463Freq2+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,188 :: 		ucRF4463Freq1 = ucLongArgument[ 2 ] - 48;
ADDS	R1, R3, #2
LDRB	R1, [R1, #0]
SUBW	R2, R1, #48
MOVW	R1, #lo_addr(_ucRF4463Freq1+0)
MOVT	R1, #hi_addr(_ucRF4463Freq1+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,189 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,190 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,191 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor273
L_vRF4463MainCommandProcessor272:
;DriverRF4463PROMain.c,193 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,194 :: 		}
L_vRF4463MainCommandProcessor273:
;DriverRF4463PROMain.c,195 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor274
L_vRF4463MainCommandProcessor269:
;DriverRF4463PROMain.c,199 :: 		else if ( memcmp( CMD_RADIO_RATE_SET, ucCommand, sizeof( CMD_RADIO_RATE_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
; ucCounterLongArgument start address is: 24 (R6)
ADD	R1, SP, #26
MOVS	R2, #9
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_RATE_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_RATE_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor275
; ucCounterLongArgument end address is: 24 (R6)
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,200 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R1, SP, #58
MOV	R0, R1
BL	_StrToLong+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,202 :: 		switch ( ulArgument ) {
IT	AL
BAL	L_vRF4463MainCommandProcessor276
;DriverRF4463PROMain.c,203 :: 		case 500      : ucRF4463Rate = dr_500;
L_vRF4463MainCommandProcessor278:
MOVS	R2, #10
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,204 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,205 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,206 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor277
;DriverRF4463PROMain.c,207 :: 		case 1200     : ucRF4463Rate = dr_1p2;
L_vRF4463MainCommandProcessor279:
MOVS	R2, #0
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,208 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,209 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,210 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor277
;DriverRF4463PROMain.c,211 :: 		case 2400     : ucRF4463Rate = dr_2p4;
L_vRF4463MainCommandProcessor280:
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,212 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,213 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,214 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor277
;DriverRF4463PROMain.c,215 :: 		case 4800     : ucRF4463Rate = dr_4p8;
L_vRF4463MainCommandProcessor281:
MOVS	R2, #2
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,216 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,217 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,218 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor277
;DriverRF4463PROMain.c,219 :: 		case 9600     : ucRF4463Rate = dr_9p6;
L_vRF4463MainCommandProcessor282:
MOVS	R2, #3
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,220 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,221 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,222 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor277
;DriverRF4463PROMain.c,223 :: 		case 19200    : ucRF4463Rate = dr_19p2;
L_vRF4463MainCommandProcessor283:
MOVS	R2, #4
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,224 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,225 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,226 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor277
;DriverRF4463PROMain.c,227 :: 		case 38400    : ucRF4463Rate = dr_38p4;
L_vRF4463MainCommandProcessor284:
MOVS	R2, #5
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,228 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,229 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,230 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor277
;DriverRF4463PROMain.c,231 :: 		case 76800    : ucRF4463Rate = dr_76p8;
L_vRF4463MainCommandProcessor285:
MOVS	R2, #6
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,232 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,233 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,234 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor277
;DriverRF4463PROMain.c,235 :: 		case 115200   : ucRF4463Rate = dr_115p2;
L_vRF4463MainCommandProcessor286:
MOVS	R2, #7
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,236 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,237 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,238 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor277
;DriverRF4463PROMain.c,239 :: 		case 256000   : ucRF4463Rate = dr_256k;
L_vRF4463MainCommandProcessor287:
MOVS	R2, #8
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,240 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,241 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,242 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor277
;DriverRF4463PROMain.c,243 :: 		case 500000   : ucRF4463Rate = dr_500k;
L_vRF4463MainCommandProcessor288:
MOVS	R2, #9
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,244 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,245 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,246 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor277
;DriverRF4463PROMain.c,247 :: 		default       : vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
L_vRF4463MainCommandProcessor289:
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,248 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor277
L_vRF4463MainCommandProcessor276:
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #500
IT	EQ
BEQ	L_vRF4463MainCommandProcessor278
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #1200
IT	EQ
BEQ	L_vRF4463MainCommandProcessor279
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #2400
IT	EQ
BEQ	L_vRF4463MainCommandProcessor280
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #4800
IT	EQ
BEQ	L_vRF4463MainCommandProcessor281
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #9600
IT	EQ
BEQ	L_vRF4463MainCommandProcessor282
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #19200
IT	EQ
BEQ	L_vRF4463MainCommandProcessor283
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #38400
IT	EQ
BEQ	L_vRF4463MainCommandProcessor284
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #76800
IT	EQ
BEQ	L_vRF4463MainCommandProcessor285
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #115200
IT	EQ
BEQ	L_vRF4463MainCommandProcessor286
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #256000
IT	EQ
BEQ	L_vRF4463MainCommandProcessor287
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #41248
MOVT	R1, #7
CMP	R2, R1
IT	EQ
BEQ	L_vRF4463MainCommandProcessor288
IT	AL
BAL	L_vRF4463MainCommandProcessor289
L_vRF4463MainCommandProcessor277:
;DriverRF4463PROMain.c,249 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor290
L_vRF4463MainCommandProcessor275:
;DriverRF4463PROMain.c,253 :: 		else if ( memcmp( CMD_RADIO_CHANNEL_SET, ucCommand, sizeof( CMD_RADIO_CHANNEL_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
; ucCounterLongArgument start address is: 24 (R6)
ADD	R1, SP, #26
MOVS	R2, #12
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_CHANNEL_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_CHANNEL_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor291
; ucCounterLongArgument end address is: 24 (R6)
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,254 :: 		ulArgument = StrToInt( ucLongArgument );
ADD	R1, SP, #58
MOV	R0, R1
BL	_StrToInt+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,256 :: 		if ( ulArgument >= 0 && ulArgument <= 50 ) {
LDR	R1, [R1, #0]
CMP	R1, #0
IT	CC
BCC	L__vRF4463MainCommandProcessor500
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #50
IT	HI
BHI	L__vRF4463MainCommandProcessor499
L__vRF4463MainCommandProcessor482:
;DriverRF4463PROMain.c,257 :: 		ucRF4463FreqChannel = ulArgument;    // Se aplica al ejecutar funciones de TX o RX
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R1, #hi_addr(_ucRF4463FreqChannel+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,258 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,259 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,260 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor295
;DriverRF4463PROMain.c,256 :: 		if ( ulArgument >= 0 && ulArgument <= 50 ) {
L__vRF4463MainCommandProcessor500:
L__vRF4463MainCommandProcessor499:
;DriverRF4463PROMain.c,262 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,263 :: 		}
L_vRF4463MainCommandProcessor295:
;DriverRF4463PROMain.c,264 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor296
L_vRF4463MainCommandProcessor291:
;DriverRF4463PROMain.c,268 :: 		else if ( memcmp( CMD_RADIO_BW_SET, ucCommand, sizeof( CMD_RADIO_BW_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
; ucCounterLongArgument start address is: 24 (R6)
ADD	R1, SP, #26
MOVS	R2, #7
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_BW_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_BW_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor297
; ucCounterLongArgument end address is: 24 (R6)
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,269 :: 		ulArgument = StrToInt( ucLongArgument );
ADD	R1, SP, #58
MOV	R0, R1
BL	_StrToInt+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,271 :: 		if ( ulArgument == 250 || ulArgument == 500 ) {
LDR	R1, [R1, #0]
CMP	R1, #250
IT	EQ
BEQ	L__vRF4463MainCommandProcessor502
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #500
IT	EQ
BEQ	L__vRF4463MainCommandProcessor501
IT	AL
BAL	L_vRF4463MainCommandProcessor300
L__vRF4463MainCommandProcessor502:
L__vRF4463MainCommandProcessor501:
;DriverRF4463PROMain.c,272 :: 		ulRF4463Step = ulArgument;
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #lo_addr(_ulRF4463Step+0)
MOVT	R1, #hi_addr(_ulRF4463Step+0)
STR	R2, [R1, #0]
;DriverRF4463PROMain.c,273 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,274 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,275 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor301
L_vRF4463MainCommandProcessor300:
;DriverRF4463PROMain.c,277 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,278 :: 		}
L_vRF4463MainCommandProcessor301:
;DriverRF4463PROMain.c,279 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor302
L_vRF4463MainCommandProcessor297:
;DriverRF4463PROMain.c,286 :: 		else if ( memcmp( CMD_RADIO_MODE_SET, ucCommand, sizeof( CMD_RADIO_MODE_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
; ucCounterLongArgument start address is: 24 (R6)
ADD	R1, SP, #26
MOVS	R2, #9
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_MODE_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MODE_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor303
; ucCounterLongArgument end address is: 24 (R6)
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,288 :: 		ucCounterCommand = 0;
; ucCounterCommand start address is: 12 (R3)
MOVS	R3, #0
; ucCounterCommand end address is: 12 (R3)
;DriverRF4463PROMain.c,290 :: 		while ( ucLongArgument[ ucCounterCommand ] != ucUSARTNull && ucCounterCommand < 32 ) {
L_vRF4463MainCommandProcessor304:
; ucCounterCommand start address is: 12 (R3)
ADD	R1, SP, #58
ADDS	R1, R1, R3
LDRB	R2, [R1, #0]
MOVW	R1, #lo_addr(_ucUSARTNull+0)
MOVT	R1, #hi_addr(_ucUSARTNull+0)
LDRB	R1, [R1, #0]
CMP	R2, R1
IT	EQ
BEQ	L__vRF4463MainCommandProcessor504
CMP	R3, #32
IT	CS
BCS	L__vRF4463MainCommandProcessor503
L__vRF4463MainCommandProcessor480:
;DriverRF4463PROMain.c,291 :: 		ucLongArgument[ ucCounterCommand ] = toupper( ucLongArgument[ ucCounterCommand ] );
ADD	R1, SP, #58
ADDS	R1, R1, R3
STR	R1, [SP, #188]
LDRB	R1, [R1, #0]
UXTB	R0, R1
BL	_toupper+0
LDR	R1, [SP, #188]
STRB	R0, [R1, #0]
;DriverRF4463PROMain.c,292 :: 		ucCounterCommand++;
ADDS	R3, R3, #1
UXTB	R3, R3
;DriverRF4463PROMain.c,293 :: 		}
; ucCounterCommand end address is: 12 (R3)
IT	AL
BAL	L_vRF4463MainCommandProcessor304
;DriverRF4463PROMain.c,290 :: 		while ( ucLongArgument[ ucCounterCommand ] != ucUSARTNull && ucCounterCommand < 32 ) {
L__vRF4463MainCommandProcessor504:
L__vRF4463MainCommandProcessor503:
;DriverRF4463PROMain.c,296 :: 		if ( memcmp( ARG_RADIO_MODE_STBY, ucLongArgument, sizeof( ARG_RADIO_MODE_STBY ) ) == 0x00 ) {
ADD	R1, SP, #58
MOVS	R2, #5
SXTH	R2, R2
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_STBY+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_STBY+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor308
;DriverRF4463PROMain.c,297 :: 		ucRF4463Mode = rf_off;
MOVS	R2, #4
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,298 :: 		vUSART1Start_TX( ANS_COMMAND_MODE_STBY, strlen( ANS_COMMAND_MODE_STBY ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_STBY+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_STBY+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_STBY+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_STBY+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,299 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor309
L_vRF4463MainCommandProcessor308:
;DriverRF4463PROMain.c,300 :: 		else if ( memcmp( ARG_RADIO_MODE_TX_CONT, ucLongArgument, sizeof( ARG_RADIO_MODE_TX_CONT ) ) == 0x00 ) {
ADD	R1, SP, #58
MOVS	R2, #8
SXTH	R2, R2
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_TX_CONT+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_TX_CONT+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor310
;DriverRF4463PROMain.c,301 :: 		ucRF4463Mode = tx_test_mode;
MOVS	R2, #2
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,302 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,303 :: 		vUSART1Start_TX( ANS_COMMAND_MODE_TX_CONT, strlen( ANS_COMMAND_MODE_TX_CONT ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_CONT+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_CONT+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,304 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor311
L_vRF4463MainCommandProcessor310:
;DriverRF4463PROMain.c,305 :: 		else if ( memcmp( ARG_RADIO_MODE_RX_CONT, ucLongArgument, sizeof( ARG_RADIO_MODE_RX_CONT ) ) == 0x00 ) {
ADD	R1, SP, #58
MOVS	R2, #8
SXTH	R2, R2
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_RX_CONT+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_RX_CONT+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor312
;DriverRF4463PROMain.c,306 :: 		ucRF4463Mode = rx_test_mode;
MOVS	R2, #3
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,307 :: 		vUSART1Start_TX( ANS_COMMAND_MODE_RX_CONT, strlen( ANS_COMMAND_MODE_RX_CONT ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_CONT+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_CONT+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,308 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor313
L_vRF4463MainCommandProcessor312:
;DriverRF4463PROMain.c,309 :: 		else if ( memcmp( ARG_RADIO_MODE_TX_MASTER, ucLongArgument, sizeof( ARG_RADIO_MODE_TX_MASTER ) ) == 0x00 ) {
ADD	R1, SP, #58
MOVS	R2, #10
SXTH	R2, R2
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_TX_MASTER+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_TX_MASTER+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor314
;DriverRF4463PROMain.c,310 :: 		ucRF4463Mode = master_mode;
MOVS	R2, #0
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,311 :: 		vUSART1Start_TX( ANS_COMMAND_MODE_TX_MASTER, strlen( ANS_COMMAND_MODE_TX_MASTER ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,312 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor315
L_vRF4463MainCommandProcessor314:
;DriverRF4463PROMain.c,313 :: 		else if ( memcmp( ARG_RADIO_MODE_RX_SLAVE, ucLongArgument, sizeof( ARG_RADIO_MODE_RX_SLAVE ) ) == 0x00 ) {
ADD	R1, SP, #58
MOVS	R2, #9
SXTH	R2, R2
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_RX_SLAVE+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_RX_SLAVE+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor316
;DriverRF4463PROMain.c,314 :: 		ucRF4463Mode = slave_mode;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,315 :: 		vUSART1Start_TX( ANS_COMMAND_MODE_RX_SLAVE, strlen( ANS_COMMAND_MODE_RX_SLAVE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,316 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor317
L_vRF4463MainCommandProcessor316:
;DriverRF4463PROMain.c,318 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,319 :: 		}
L_vRF4463MainCommandProcessor317:
L_vRF4463MainCommandProcessor315:
L_vRF4463MainCommandProcessor313:
L_vRF4463MainCommandProcessor311:
L_vRF4463MainCommandProcessor309:
;DriverRF4463PROMain.c,320 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor318
L_vRF4463MainCommandProcessor303:
;DriverRF4463PROMain.c,325 :: 		else if ( memcmp( CMD_RADIO_PACKET_SEND, ucCommand, sizeof( CMD_RADIO_PACKET_SEND ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
; ucCounterLongArgument start address is: 24 (R6)
ADD	R1, SP, #26
MOVS	R2, #12
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_PACKET_SEND+0)
MOVT	R0, #hi_addr(_CMD_RADIO_PACKET_SEND+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor319
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,327 :: 		if ( ucRF4463Mode == rf_off ) {
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
LDRB	R1, [R1, #0]
CMP	R1, #4
IT	NE
BNE	L_vRF4463MainCommandProcessor320
;DriverRF4463PROMain.c,328 :: 		vUSARTStartMEMtoMEMZero( ucRF4463TXdata, sizeof( ucRF4463TXdata ));
MOVS	R1, #66
MOVW	R0, #lo_addr(_ucRF4463TXdata+0)
MOVT	R0, #hi_addr(_ucRF4463TXdata+0)
BL	_vUSARTStartMEMtoMEMZero+0
;DriverRF4463PROMain.c,329 :: 		vRF4463MainSetTXString();
BL	_vRF4463MainSetTXString+0
;DriverRF4463PROMain.c,330 :: 		ucLongArgument[ ucCounterLongArgument++ ] = ucRF4463ChecksumGenerator( ucLongArgument, ucCounterLongArgument );
ADD	R2, SP, #58
ADDS	R1, R2, R6
STR	R1, [SP, #188]
UXTB	R1, R6
MOV	R0, R2
BL	_ucRF4463ChecksumGenerator+0
LDR	R1, [SP, #188]
STRB	R0, [R1, #0]
ADDS	R2, R6, #1
UXTB	R2, R2
; ucCounterLongArgument end address is: 24 (R6)
;DriverRF4463PROMain.c,331 :: 		vUSARTStartMEMtoMEM( ucLongArgument, ucRF4463TXdata + 4, ucCounterLongArgument );
ADD	R1, SP, #58
MOV	R0, R1
MOVW	R1, #lo_addr(_ucRF4463TXdata+4)
MOVT	R1, #hi_addr(_ucRF4463TXdata+4)
BL	_vUSARTStartMEMtoMEM+0
;DriverRF4463PROMain.c,333 :: 		ucRF4463SendMessage = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463SendMessage+0)
MOVT	R1, #hi_addr(_ucRF4463SendMessage+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,335 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor321
L_vRF4463MainCommandProcessor320:
;DriverRF4463PROMain.c,337 :: 		vUSART1Start_TX( ANS_COMMAND_WRONG_MODE, strlen( ANS_COMMAND_WRONG_MODE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_WRONG_MODE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_WRONG_MODE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_WRONG_MODE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_WRONG_MODE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,338 :: 		}
L_vRF4463MainCommandProcessor321:
;DriverRF4463PROMain.c,339 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor322
L_vRF4463MainCommandProcessor319:
;DriverRF4463PROMain.c,344 :: 		else if ( memcmp( CMD_RADIO_GET_STATUS, ucCommand, sizeof( CMD_RADIO_GET_STATUS ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
ADD	R1, SP, #26
MOVS	R2, #11
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_GET_STATUS+0)
MOVT	R0, #hi_addr(_CMD_RADIO_GET_STATUS+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor323
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,345 :: 		vUSART1Start_TX( ANS_STATUS_REPORT, strlen( ANS_STATUS_REPORT ) );
MOVW	R0, #lo_addr(_ANS_STATUS_REPORT+0)
MOVT	R0, #hi_addr(_ANS_STATUS_REPORT+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_STATUS_REPORT+0)
MOVT	R0, #hi_addr(_ANS_STATUS_REPORT+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,348 :: 		sprintf( ucTXT, "[ STATUS ] DECIMAL POWER: %d\r\n" , ucRF4463Power );
MOVW	R1, #lo_addr(_ucRF4463Power+0)
MOVT	R1, #hi_addr(_ucRF4463Power+0)
LDRB	R3, [R1, #0]
MOVW	R2, #lo_addr(?lstr_3_DriverRF4463PROMain+0)
MOVT	R2, #hi_addr(?lstr_3_DriverRF4463PROMain+0)
ADD	R1, SP, #122
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_sprintf+0
ADD	SP, SP, #12
;DriverRF4463PROMain.c,349 :: 		vUSART1Start_TX( ucTXT, strlen( ucTXT ) );
ADD	R1, SP, #122
MOV	R0, R1
BL	_strlen+0
ADD	R1, SP, #122
STR	R1, [SP, #4]
SXTH	R1, R0
LDR	R0, [SP, #4]
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,352 :: 		ulArgument = ( ( ucRF4463Freq3 * 100 ) + ( ucRF4463Freq2 * 10 ) + ucRF4463Freq1 ) * 1000UL;
MOVW	R1, #lo_addr(_ucRF4463Freq3+0)
MOVT	R1, #hi_addr(_ucRF4463Freq3+0)
LDRB	R2, [R1, #0]
MOVS	R1, #100
SXTH	R1, R1
MUL	R3, R2, R1
SXTH	R3, R3
MOVW	R1, #lo_addr(_ucRF4463Freq2+0)
MOVT	R1, #hi_addr(_ucRF4463Freq2+0)
LDRB	R2, [R1, #0]
MOVS	R1, #10
SXTH	R1, R1
MULS	R1, R2, R1
SXTH	R1, R1
ADDS	R2, R3, R1
SXTH	R2, R2
MOVW	R1, #lo_addr(_ucRF4463Freq1+0)
MOVT	R1, #hi_addr(_ucRF4463Freq1+0)
LDRB	R1, [R1, #0]
ADDS	R2, R2, R1
SXTH	R2, R2
MOV	R1, #1000
MULS	R2, R1, R2
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R2, [R1, #0]
;DriverRF4463PROMain.c,353 :: 		sprintf( ucTXT, "[ STATUS ] BAND: %lu KHz\r\n" , ulArgument );
MOV	R3, R2
MOVW	R2, #lo_addr(?lstr_4_DriverRF4463PROMain+0)
MOVT	R2, #hi_addr(?lstr_4_DriverRF4463PROMain+0)
ADD	R1, SP, #122
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_sprintf+0
ADD	SP, SP, #12
;DriverRF4463PROMain.c,354 :: 		vUSART1Start_TX( ucTXT, strlen( ucTXT ) );
ADD	R1, SP, #122
MOV	R0, R1
BL	_strlen+0
ADD	R1, SP, #122
STR	R1, [SP, #4]
SXTH	R1, R0
LDR	R0, [SP, #4]
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,357 :: 		switch ( ucRF4463Rate ) {
IT	AL
BAL	L_vRF4463MainCommandProcessor324
;DriverRF4463PROMain.c,358 :: 		case dr_1p2    : ulArgument = 1200;
L_vRF4463MainCommandProcessor326:
MOVW	R2, #1200
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R2, [R1, #0]
;DriverRF4463PROMain.c,359 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor325
;DriverRF4463PROMain.c,360 :: 		case dr_2p4    : ulArgument = 2400;
L_vRF4463MainCommandProcessor327:
MOVW	R2, #2400
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R2, [R1, #0]
;DriverRF4463PROMain.c,361 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor325
;DriverRF4463PROMain.c,362 :: 		case dr_4p8    : ulArgument = 4800;
L_vRF4463MainCommandProcessor328:
MOVW	R2, #4800
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R2, [R1, #0]
;DriverRF4463PROMain.c,363 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor325
;DriverRF4463PROMain.c,364 :: 		case dr_9p6    : ulArgument = 9600;
L_vRF4463MainCommandProcessor329:
MOVW	R2, #9600
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R2, [R1, #0]
;DriverRF4463PROMain.c,365 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor325
;DriverRF4463PROMain.c,366 :: 		case dr_19p2   : ulArgument = 19200;
L_vRF4463MainCommandProcessor330:
MOVW	R2, #19200
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R2, [R1, #0]
;DriverRF4463PROMain.c,367 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor325
;DriverRF4463PROMain.c,368 :: 		case dr_38p4   : ulArgument = 38400;
L_vRF4463MainCommandProcessor331:
MOVW	R2, #38400
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R2, [R1, #0]
;DriverRF4463PROMain.c,369 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor325
;DriverRF4463PROMain.c,370 :: 		case dr_76p8   : ulArgument = 76800;
L_vRF4463MainCommandProcessor332:
MOV	R2, #76800
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R2, [R1, #0]
;DriverRF4463PROMain.c,371 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor325
;DriverRF4463PROMain.c,372 :: 		case dr_115p2  : ulArgument = 115200;
L_vRF4463MainCommandProcessor333:
MOV	R2, #115200
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R2, [R1, #0]
;DriverRF4463PROMain.c,373 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor325
;DriverRF4463PROMain.c,374 :: 		case dr_256k   : ulArgument = 256000;
L_vRF4463MainCommandProcessor334:
MOV	R2, #256000
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R2, [R1, #0]
;DriverRF4463PROMain.c,375 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor325
;DriverRF4463PROMain.c,376 :: 		case dr_500k   : ulArgument = 500000;
L_vRF4463MainCommandProcessor335:
MOVW	R2, #41248
MOVT	R2, #7
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R2, [R1, #0]
;DriverRF4463PROMain.c,377 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor325
;DriverRF4463PROMain.c,378 :: 		case dr_500    : ulArgument = 500;
L_vRF4463MainCommandProcessor336:
MOVW	R2, #500
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R2, [R1, #0]
;DriverRF4463PROMain.c,379 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor325
;DriverRF4463PROMain.c,380 :: 		}
L_vRF4463MainCommandProcessor324:
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R1, #0]
CMP	R1, #0
IT	EQ
BEQ	L_vRF4463MainCommandProcessor326
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R1, #0]
CMP	R1, #1
IT	EQ
BEQ	L_vRF4463MainCommandProcessor327
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R1, #0]
CMP	R1, #2
IT	EQ
BEQ	L_vRF4463MainCommandProcessor328
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R1, #0]
CMP	R1, #3
IT	EQ
BEQ	L_vRF4463MainCommandProcessor329
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R1, #0]
CMP	R1, #4
IT	EQ
BEQ	L_vRF4463MainCommandProcessor330
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R1, #0]
CMP	R1, #5
IT	EQ
BEQ	L_vRF4463MainCommandProcessor331
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R1, #0]
CMP	R1, #6
IT	EQ
BEQ	L_vRF4463MainCommandProcessor332
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R1, #0]
CMP	R1, #7
IT	EQ
BEQ	L_vRF4463MainCommandProcessor333
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R1, #0]
CMP	R1, #8
IT	EQ
BEQ	L_vRF4463MainCommandProcessor334
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R1, #0]
CMP	R1, #9
IT	EQ
BEQ	L_vRF4463MainCommandProcessor335
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L_vRF4463MainCommandProcessor336
L_vRF4463MainCommandProcessor325:
;DriverRF4463PROMain.c,381 :: 		sprintf( ucTXT, "[ STATUS ] DATA RATE: %lu\r\n" , ulArgument );
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R3, [R1, #0]
MOVW	R2, #lo_addr(?lstr_5_DriverRF4463PROMain+0)
MOVT	R2, #hi_addr(?lstr_5_DriverRF4463PROMain+0)
ADD	R1, SP, #122
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_sprintf+0
ADD	SP, SP, #12
;DriverRF4463PROMain.c,382 :: 		vUSART1Start_TX( ucTXT, strlen( ucTXT ) );
ADD	R1, SP, #122
MOV	R0, R1
BL	_strlen+0
ADD	R1, SP, #122
STR	R1, [SP, #4]
SXTH	R1, R0
LDR	R0, [SP, #4]
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,385 :: 		sprintf( ucTXT, "[ STATUS ] CHANNEL: %d\r\n" , ucRF4463FreqChannel );
MOVW	R1, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R1, #hi_addr(_ucRF4463FreqChannel+0)
LDRB	R3, [R1, #0]
MOVW	R2, #lo_addr(?lstr_6_DriverRF4463PROMain+0)
MOVT	R2, #hi_addr(?lstr_6_DriverRF4463PROMain+0)
ADD	R1, SP, #122
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_sprintf+0
ADD	SP, SP, #12
;DriverRF4463PROMain.c,386 :: 		vUSART1Start_TX( ucTXT, strlen( ucTXT ) );
ADD	R1, SP, #122
MOV	R0, R1
BL	_strlen+0
ADD	R1, SP, #122
STR	R1, [SP, #4]
SXTH	R1, R0
LDR	R0, [SP, #4]
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,389 :: 		sprintf( ucTXT, "[ STATUS ] BW: %lu KHz\r\n" , ulRF4463Step );
MOVW	R1, #lo_addr(_ulRF4463Step+0)
MOVT	R1, #hi_addr(_ulRF4463Step+0)
LDR	R3, [R1, #0]
MOVW	R2, #lo_addr(?lstr_7_DriverRF4463PROMain+0)
MOVT	R2, #hi_addr(?lstr_7_DriverRF4463PROMain+0)
ADD	R1, SP, #122
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_sprintf+0
ADD	SP, SP, #12
;DriverRF4463PROMain.c,390 :: 		vUSART1Start_TX( ucTXT, strlen( ucTXT ) );
ADD	R1, SP, #122
MOV	R0, R1
BL	_strlen+0
ADD	R1, SP, #122
STR	R1, [SP, #4]
SXTH	R1, R0
LDR	R0, [SP, #4]
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,394 :: 		vUSART1Start_TX( "[ STATUS ] MODE: ", 17 );
ADD	R11, SP, #8
ADD	R10, R11, #18
MOVW	R12, #lo_addr(?ICS?lstr8_DriverRF4463PROMain+0)
MOVT	R12, #hi_addr(?ICS?lstr8_DriverRF4463PROMain+0)
BL	___CC2DW+0
ADD	R1, SP, #8
MOV	R0, R1
MOVS	R1, #17
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,396 :: 		switch ( ucRF4463Mode ) {
IT	AL
BAL	L_vRF4463MainCommandProcessor337
;DriverRF4463PROMain.c,397 :: 		case rf_off        : vUSART1Start_TX( ANS_COMMAND_MODE_STBY, strlen( ANS_COMMAND_MODE_STBY ) );
L_vRF4463MainCommandProcessor339:
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_STBY+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_STBY+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_STBY+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_STBY+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,398 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor338
;DriverRF4463PROMain.c,399 :: 		case tx_test_mode  : vUSART1Start_TX( ANS_COMMAND_MODE_TX_CONT, strlen( ANS_COMMAND_MODE_TX_CONT ) );
L_vRF4463MainCommandProcessor340:
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_CONT+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_CONT+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,400 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor338
;DriverRF4463PROMain.c,401 :: 		case rx_test_mode  : vUSART1Start_TX( ANS_COMMAND_MODE_RX_CONT, strlen( ANS_COMMAND_MODE_RX_CONT ) );
L_vRF4463MainCommandProcessor341:
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_CONT+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_CONT+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,402 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor338
;DriverRF4463PROMain.c,403 :: 		case master_mode   : vUSART1Start_TX( ANS_COMMAND_MODE_TX_MASTER, strlen( ANS_COMMAND_MODE_TX_MASTER ) );
L_vRF4463MainCommandProcessor342:
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,404 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor338
;DriverRF4463PROMain.c,405 :: 		case slave_mode    : vUSART1Start_TX( ANS_COMMAND_MODE_RX_SLAVE, strlen( ANS_COMMAND_MODE_RX_SLAVE ) );
L_vRF4463MainCommandProcessor343:
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,406 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor338
;DriverRF4463PROMain.c,407 :: 		}
L_vRF4463MainCommandProcessor337:
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
LDRB	R1, [R1, #0]
CMP	R1, #4
IT	EQ
BEQ	L_vRF4463MainCommandProcessor339
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
LDRB	R1, [R1, #0]
CMP	R1, #2
IT	EQ
BEQ	L_vRF4463MainCommandProcessor340
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
LDRB	R1, [R1, #0]
CMP	R1, #3
IT	EQ
BEQ	L_vRF4463MainCommandProcessor341
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
LDRB	R1, [R1, #0]
CMP	R1, #0
IT	EQ
BEQ	L_vRF4463MainCommandProcessor342
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
LDRB	R1, [R1, #0]
CMP	R1, #1
IT	EQ
BEQ	L_vRF4463MainCommandProcessor343
L_vRF4463MainCommandProcessor338:
;DriverRF4463PROMain.c,408 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor344
L_vRF4463MainCommandProcessor323:
;DriverRF4463PROMain.c,412 :: 		else if ( memcmp( CMD_RADIO_MATCH_BYTE_1_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_1_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
ADD	R1, SP, #26
MOVS	R2, #12
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_BYTE_1_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_BYTE_1_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor345
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,413 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R1, SP, #58
MOV	R0, R1
BL	_StrToLong+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,414 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BCC	L__vRF4463MainCommandProcessor506
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #255
IT	HI
BHI	L__vRF4463MainCommandProcessor505
L__vRF4463MainCommandProcessor479:
;DriverRF4463PROMain.c,415 :: 		ucRF4463ByteMatch1 = ulArgument;
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #lo_addr(_ucRF4463ByteMatch1+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMatch1+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,416 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,417 :: 		ucRF4463MatchEnableReg = 0x40;
MOVS	R2, #64
MOVW	R1, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,418 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,419 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,420 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor349
;DriverRF4463PROMain.c,414 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor506:
L__vRF4463MainCommandProcessor505:
;DriverRF4463PROMain.c,422 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,423 :: 		}
L_vRF4463MainCommandProcessor349:
;DriverRF4463PROMain.c,424 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor350
L_vRF4463MainCommandProcessor345:
;DriverRF4463PROMain.c,428 :: 		else if ( memcmp( CMD_RADIO_MATCH_BYTE_2_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_2_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
ADD	R1, SP, #26
MOVS	R2, #12
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_BYTE_2_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_BYTE_2_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor351
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,429 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R1, SP, #58
MOV	R0, R1
BL	_StrToLong+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,430 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BCC	L__vRF4463MainCommandProcessor508
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #255
IT	HI
BHI	L__vRF4463MainCommandProcessor507
L__vRF4463MainCommandProcessor478:
;DriverRF4463PROMain.c,431 :: 		ucRF4463ByteMatch2 = ulArgument;
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #lo_addr(_ucRF4463ByteMatch2+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMatch2+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,432 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,433 :: 		ucRF4463MatchEnableReg = 0x40;
MOVS	R2, #64
MOVW	R1, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,434 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,435 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,436 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor355
;DriverRF4463PROMain.c,430 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor508:
L__vRF4463MainCommandProcessor507:
;DriverRF4463PROMain.c,438 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,439 :: 		}
L_vRF4463MainCommandProcessor355:
;DriverRF4463PROMain.c,440 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor356
L_vRF4463MainCommandProcessor351:
;DriverRF4463PROMain.c,444 :: 		else if ( memcmp( CMD_RADIO_MATCH_BYTE_3_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_3_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
ADD	R1, SP, #26
MOVS	R2, #12
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_BYTE_3_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_BYTE_3_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor357
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,445 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R1, SP, #58
MOV	R0, R1
BL	_StrToLong+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,446 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BCC	L__vRF4463MainCommandProcessor510
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #255
IT	HI
BHI	L__vRF4463MainCommandProcessor509
L__vRF4463MainCommandProcessor477:
;DriverRF4463PROMain.c,447 :: 		ucRF4463ByteMatch3 = ulArgument;
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #lo_addr(_ucRF4463ByteMatch3+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMatch3+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,448 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,449 :: 		ucRF4463MatchEnableReg = 0x40;
MOVS	R2, #64
MOVW	R1, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,450 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,451 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,452 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor361
;DriverRF4463PROMain.c,446 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor510:
L__vRF4463MainCommandProcessor509:
;DriverRF4463PROMain.c,454 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,455 :: 		}
L_vRF4463MainCommandProcessor361:
;DriverRF4463PROMain.c,456 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor362
L_vRF4463MainCommandProcessor357:
;DriverRF4463PROMain.c,460 :: 		else if ( memcmp( CMD_RADIO_MATCH_BYTE_4_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_4_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
ADD	R1, SP, #26
MOVS	R2, #12
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_BYTE_4_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_BYTE_4_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor363
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,461 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R1, SP, #58
MOV	R0, R1
BL	_StrToLong+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,462 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BCC	L__vRF4463MainCommandProcessor512
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #255
IT	HI
BHI	L__vRF4463MainCommandProcessor511
L__vRF4463MainCommandProcessor476:
;DriverRF4463PROMain.c,463 :: 		ucRF4463ByteMatch4 = ulArgument;
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #lo_addr(_ucRF4463ByteMatch4+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMatch4+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,464 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,465 :: 		ucRF4463MatchEnableReg = 0x40;
MOVS	R2, #64
MOVW	R1, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,466 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,467 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,468 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor367
;DriverRF4463PROMain.c,462 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor512:
L__vRF4463MainCommandProcessor511:
;DriverRF4463PROMain.c,470 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,471 :: 		}
L_vRF4463MainCommandProcessor367:
;DriverRF4463PROMain.c,472 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor368
L_vRF4463MainCommandProcessor363:
;DriverRF4463PROMain.c,476 :: 		else if ( memcmp( CMD_RADIO_MATCH_MASK_1_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_1_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
ADD	R1, SP, #26
MOVS	R2, #11
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_MASK_1_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_MASK_1_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor369
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,477 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R1, SP, #58
MOV	R0, R1
BL	_StrToLong+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,478 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BCC	L__vRF4463MainCommandProcessor514
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #255
IT	HI
BHI	L__vRF4463MainCommandProcessor513
L__vRF4463MainCommandProcessor475:
;DriverRF4463PROMain.c,479 :: 		ucRF4463ByteMask1 = ulArgument;
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #lo_addr(_ucRF4463ByteMask1+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMask1+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,480 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,481 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,482 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,483 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor373
;DriverRF4463PROMain.c,478 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor514:
L__vRF4463MainCommandProcessor513:
;DriverRF4463PROMain.c,485 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,486 :: 		}
L_vRF4463MainCommandProcessor373:
;DriverRF4463PROMain.c,487 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor374
L_vRF4463MainCommandProcessor369:
;DriverRF4463PROMain.c,491 :: 		else if ( memcmp( CMD_RADIO_MATCH_MASK_2_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_2_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
ADD	R1, SP, #26
MOVS	R2, #11
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_MASK_2_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_MASK_2_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor375
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,492 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R1, SP, #58
MOV	R0, R1
BL	_StrToLong+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,493 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BCC	L__vRF4463MainCommandProcessor516
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #255
IT	HI
BHI	L__vRF4463MainCommandProcessor515
L__vRF4463MainCommandProcessor474:
;DriverRF4463PROMain.c,494 :: 		ucRF4463ByteMask2 = ulArgument;
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #lo_addr(_ucRF4463ByteMask2+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMask2+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,495 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,496 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,497 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,498 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor379
;DriverRF4463PROMain.c,493 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor516:
L__vRF4463MainCommandProcessor515:
;DriverRF4463PROMain.c,500 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,501 :: 		}
L_vRF4463MainCommandProcessor379:
;DriverRF4463PROMain.c,502 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor380
L_vRF4463MainCommandProcessor375:
;DriverRF4463PROMain.c,506 :: 		else if ( memcmp( CMD_RADIO_MATCH_MASK_3_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_3_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
ADD	R1, SP, #26
MOVS	R2, #11
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_MASK_3_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_MASK_3_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor381
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,507 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R1, SP, #58
MOV	R0, R1
BL	_StrToLong+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,508 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BCC	L__vRF4463MainCommandProcessor518
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #255
IT	HI
BHI	L__vRF4463MainCommandProcessor517
L__vRF4463MainCommandProcessor473:
;DriverRF4463PROMain.c,509 :: 		ucRF4463ByteMask3 = ulArgument;
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #lo_addr(_ucRF4463ByteMask3+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMask3+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,510 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,511 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,512 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,513 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor385
;DriverRF4463PROMain.c,508 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor518:
L__vRF4463MainCommandProcessor517:
;DriverRF4463PROMain.c,515 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,516 :: 		}
L_vRF4463MainCommandProcessor385:
;DriverRF4463PROMain.c,517 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor386
L_vRF4463MainCommandProcessor381:
;DriverRF4463PROMain.c,521 :: 		else if ( memcmp( CMD_RADIO_MATCH_MASK_4_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_4_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
ADD	R1, SP, #26
MOVS	R2, #11
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_MASK_4_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_MASK_4_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor387
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,522 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R1, SP, #58
MOV	R0, R1
BL	_StrToLong+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,523 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BCC	L__vRF4463MainCommandProcessor520
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #255
IT	HI
BHI	L__vRF4463MainCommandProcessor519
L__vRF4463MainCommandProcessor472:
;DriverRF4463PROMain.c,524 :: 		ucRF4463ByteMask4 = ulArgument;
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #lo_addr(_ucRF4463ByteMask4+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMask4+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,525 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,526 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,527 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,528 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor391
;DriverRF4463PROMain.c,523 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor520:
L__vRF4463MainCommandProcessor519:
;DriverRF4463PROMain.c,530 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,531 :: 		}
L_vRF4463MainCommandProcessor391:
;DriverRF4463PROMain.c,532 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor392
L_vRF4463MainCommandProcessor387:
;DriverRF4463PROMain.c,536 :: 		else if ( memcmp( CMD_RADIO_MATCH_UNSET, ucCommand, sizeof( CMD_RADIO_MATCH_UNSET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
ADD	R1, SP, #26
MOVS	R2, #12
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_UNSET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_UNSET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor393
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,538 :: 		ucRF4463MatchEnableReg = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,539 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,540 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,545 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor394
L_vRF4463MainCommandProcessor393:
;DriverRF4463PROMain.c,549 :: 		vUSART1Start_TX( ANS_DEBUG_COMMAND_UNKNOWN, strlen( ANS_DEBUG_COMMAND_UNKNOWN ) );
; ucBuffer start address is: 20 (R5)
MOVW	R0, #lo_addr(_ANS_DEBUG_COMMAND_UNKNOWN+0)
MOVT	R0, #hi_addr(_ANS_DEBUG_COMMAND_UNKNOWN+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_DEBUG_COMMAND_UNKNOWN+0)
MOVT	R0, #hi_addr(_ANS_DEBUG_COMMAND_UNKNOWN+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,550 :: 		vUSART1Start_TX( ucBuffer, strlen( ucBuffer ) );  // DEPURACION
MOV	R0, R5
BL	_strlen+0
SXTH	R1, R0
MOV	R0, R5
; ucBuffer end address is: 20 (R5)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,551 :: 		}
L_vRF4463MainCommandProcessor394:
L_vRF4463MainCommandProcessor392:
L_vRF4463MainCommandProcessor386:
L_vRF4463MainCommandProcessor380:
L_vRF4463MainCommandProcessor374:
L_vRF4463MainCommandProcessor368:
L_vRF4463MainCommandProcessor362:
L_vRF4463MainCommandProcessor356:
L_vRF4463MainCommandProcessor350:
L_vRF4463MainCommandProcessor344:
L_vRF4463MainCommandProcessor322:
L_vRF4463MainCommandProcessor318:
L_vRF4463MainCommandProcessor302:
L_vRF4463MainCommandProcessor296:
L_vRF4463MainCommandProcessor290:
L_vRF4463MainCommandProcessor274:
L_vRF4463MainCommandProcessor268:
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
;DriverRF4463PROMain.c,559 :: 		RCC_APB1ENR.TIM2EN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
_SX	[R0, ByteOffset(RCC_APB1ENR+0)]
;DriverRF4463PROMain.c,560 :: 		TIM2_CR1.CEN = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
_SX	[R0, ByteOffset(TIM2_CR1+0)]
;DriverRF4463PROMain.c,561 :: 		TIM2_PSC = 1124;
MOVW	R1, #1124
MOVW	R0, #lo_addr(TIM2_PSC+0)
MOVT	R0, #hi_addr(TIM2_PSC+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,562 :: 		TIM2_ARR = 63999;
MOVW	R1, #63999
MOVW	R0, #lo_addr(TIM2_ARR+0)
MOVT	R0, #hi_addr(TIM2_ARR+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,563 :: 		NVIC_IntEnable( IVT_INT_TIM2 );
MOVW	R0, #44
BL	_NVIC_IntEnable+0
;DriverRF4463PROMain.c,564 :: 		TIM2_DIER.UIE = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
_SX	[R0, ByteOffset(TIM2_DIER+0)]
;DriverRF4463PROMain.c,565 :: 		TIM2_CR1bits.CEN = 1;
MOVW	R0, #lo_addr(TIM2_CR1bits+0)
MOVT	R0, #hi_addr(TIM2_CR1bits+0)
_SX	[R0, ByteOffset(TIM2_CR1bits+0)]
;DriverRF4463PROMain.c,566 :: 		}
L_end_InitTimer2:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _InitTimer2
_main:
;DriverRF4463PROMain.c,570 :: 		void main() {
SUB	SP, SP, #92
;DriverRF4463PROMain.c,574 :: 		Delay_ms( 2000 );                    // delay de depuracion
MOVW	R7, #64510
MOVT	R7, #1708
NOP
NOP
L_main395:
SUBS	R7, R7, #1
BNE	L_main395
NOP
NOP
NOP
;DriverRF4463PROMain.c,578 :: 		GPIO_Digital_Output( &GPIOE_BASE, _GPIO_PINMASK_9 );
MOVW	R1, #512
MOVW	R0, #lo_addr(GPIOE_BASE+0)
MOVT	R0, #hi_addr(GPIOE_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,579 :: 		GPIO_Digital_Output( &GPIOE_BASE, _GPIO_PINMASK_11 );
MOVW	R1, #2048
MOVW	R0, #lo_addr(GPIOE_BASE+0)
MOVT	R0, #hi_addr(GPIOE_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,580 :: 		GPIO_Digital_Output( &GPIOE_BASE, _GPIO_PINMASK_13 );
MOVW	R1, #8192
MOVW	R0, #lo_addr(GPIOE_BASE+0)
MOVT	R0, #hi_addr(GPIOE_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,588 :: 		GPIO_Digital_Input( &GPIOD_BASE, _GPIO_PINMASK_0 );     // nIRQ (Interrupt Request Pin)
MOVW	R1, #1
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Input+0
;DriverRF4463PROMain.c,589 :: 		GPIO_Digital_Output( &GPIOD_BASE, _GPIO_PINMASK_1 );    // SDN  ()
MOVW	R1, #2
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,590 :: 		GPIO_Digital_Output( &GPIOD_BASE, _GPIO_PINMASK_2 );    // nSEL (Chip Select)
MOVW	R1, #4
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,604 :: 		RCC_APB2ENRbits.SYSCFGEN = 1; //Clock Enable
MOVS	R2, #1
SXTB	R2, R2
MOVW	R0, #lo_addr(RCC_APB2ENRbits+0)
MOVT	R0, #hi_addr(RCC_APB2ENRbits+0)
_SX	[R0, ByteOffset(RCC_APB2ENRbits+0)]
;DriverRF4463PROMain.c,605 :: 		SYSCFG_EXTICR1  |= 0x0003;    //Pin Configuration
MOVW	R0, #lo_addr(SYSCFG_EXTICR1+0)
MOVT	R0, #hi_addr(SYSCFG_EXTICR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #3
MOVW	R0, #lo_addr(SYSCFG_EXTICR1+0)
MOVT	R0, #hi_addr(SYSCFG_EXTICR1+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,606 :: 		EXTI_IMR.B0     |= 1;         //Interruption Edge Flag
MOVS	R1, #1
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
_SX	[R0, ByteOffset(EXTI_IMR+0)]
;DriverRF4463PROMain.c,607 :: 		EXTI_FTSR.B0    |= 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
_SX	[R0, ByteOffset(EXTI_FTSR+0)]
;DriverRF4463PROMain.c,609 :: 		nSEL = 1;
MOVW	R0, #lo_addr(GPIOD_ODRbits+0)
MOVT	R0, #hi_addr(GPIOD_ODRbits+0)
_SX	[R0, ByteOffset(GPIOD_ODRbits+0)]
;DriverRF4463PROMain.c,611 :: 		LED_RED      = 1;
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_SX	[R0, ByteOffset(GPIOE_ODRbits+0)]
;DriverRF4463PROMain.c,612 :: 		LED_GREEN    = 1;
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_SX	[R0, ByteOffset(GPIOE_ODRbits+0)]
;DriverRF4463PROMain.c,613 :: 		LED_BLUE     = 1;
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_SX	[R0, ByteOffset(GPIOE_ODRbits+0)]
;DriverRF4463PROMain.c,615 :: 		Delay_ms( 100 );
MOVW	R7, #29438
MOVT	R7, #85
NOP
NOP
L_main397:
SUBS	R7, R7, #1
BNE	L_main397
NOP
NOP
NOP
;DriverRF4463PROMain.c,617 :: 		LED_RED      = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_SX	[R0, ByteOffset(GPIOE_ODRbits+0)]
;DriverRF4463PROMain.c,618 :: 		LED_GREEN    = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_SX	[R0, ByteOffset(GPIOE_ODRbits+0)]
;DriverRF4463PROMain.c,619 :: 		LED_BLUE     = 0;
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_SX	[R0, ByteOffset(GPIOE_ODRbits+0)]
;DriverRF4463PROMain.c,621 :: 		InitTimer2();
BL	_InitTimer2+0
;DriverRF4463PROMain.c,624 :: 		vUSARTConfigUSART1( 115200 );  // configura todos las parametros de USART
MOV	R0, #115200
BL	_vUSARTConfigUSART1+0
;DriverRF4463PROMain.c,626 :: 		UART1_Write_Text( "[ Start System ] Driver\r\n" );
ADD	R11, SP, #2
ADD	R10, R11, #26
MOVW	R12, #lo_addr(?ICS?lstr9_DriverRF4463PROMain+0)
MOVT	R12, #hi_addr(?ICS?lstr9_DriverRF4463PROMain+0)
BL	___CC2DW+0
ADD	R0, SP, #2
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,627 :: 		vSPI1Init();           // configura todos los parametros de SPI
BL	_vSPI1Init+0
;DriverRF4463PROMain.c,632 :: 		ucRF4463Freq3 = 9;
MOVS	R1, #9
MOVW	R0, #lo_addr(_ucRF4463Freq3+0)
MOVT	R0, #hi_addr(_ucRF4463Freq3+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,633 :: 		ucRF4463Freq2 = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463Freq2+0)
MOVT	R0, #hi_addr(_ucRF4463Freq2+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,634 :: 		ucRF4463Freq1 = 5;
MOVS	R1, #5
MOVW	R0, #lo_addr(_ucRF4463Freq1+0)
MOVT	R0, #hi_addr(_ucRF4463Freq1+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,637 :: 		ucRF4463Power = 127;            // 34
MOVS	R1, #127
MOVW	R0, #lo_addr(_ucRF4463Power+0)
MOVT	R0, #hi_addr(_ucRF4463Power+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,639 :: 		ucRF4463Rate  = dr_1p2;                // BAUDRATE
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,641 :: 		ucRF4463Mode  = master_mode;          // para transmision continua usar: tx_test_mode
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,643 :: 		ucRF4463FreqChannel = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,647 :: 		reset_mode = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_reset_mode+0)
MOVT	R0, #hi_addr(_reset_mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,652 :: 		vRF4463MainSetTXString();    // usada para establecer el encabezdo predeterminado
BL	_vRF4463MainSetTXString+0
;DriverRF4463PROMain.c,653 :: 		VRF4463SDNReset();
BL	_VRF4463SDNReset+0
;DriverRF4463PROMain.c,654 :: 		vRF4463Init();
BL	_vRF4463Init+0
;DriverRF4463PROMain.c,655 :: 		vRF4463ClearInterrupts();
BL	_vRF4463ClearInterrupts+0
;DriverRF4463PROMain.c,656 :: 		vRF4463PartInfo ();          // SOLICITA EL MODELO DEL RADIO
BL	_vRF4463PartInfo+0
;DriverRF4463PROMain.c,658 :: 		LED_GREEN    = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_SX	[R0, ByteOffset(GPIOE_ODRbits+0)]
;DriverRF4463PROMain.c,659 :: 		LED_BLUE     = 0;
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_SX	[R0, ByteOffset(GPIOE_ODRbits+0)]
;DriverRF4463PROMain.c,661 :: 		UART1_Write_Text( "[ SYS STM32F ]RF Radio ready\r\n" );
ADD	R11, SP, #28
ADD	R10, R11, #31
MOVW	R12, #lo_addr(?ICS?lstr10_DriverRF4463PROMain+0)
MOVT	R12, #hi_addr(?ICS?lstr10_DriverRF4463PROMain+0)
BL	___CC2DW+0
ADD	R0, SP, #28
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,663 :: 		while ( 1 ) {
L_main399:
;DriverRF4463PROMain.c,666 :: 		if ( fUSART1Buffer == READY_TO_READ ) {
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main401
;DriverRF4463PROMain.c,667 :: 		vUSARTReceivedFromUSART1();
BL	_vUSARTReceivedFromUSART1+0
;DriverRF4463PROMain.c,668 :: 		}
L_main401:
;DriverRF4463PROMain.c,679 :: 		if ( ucRF4463Mode == master_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main402
;DriverRF4463PROMain.c,680 :: 		vRF4463TxData();
BL	_vRF4463TxData+0
;DriverRF4463PROMain.c,681 :: 		}
IT	AL
BAL	L_main403
L_main402:
;DriverRF4463PROMain.c,684 :: 		else if ( ucRF4463Mode == slave_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main404
;DriverRF4463PROMain.c,685 :: 		vRF4463RxInit();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,686 :: 		}
IT	AL
BAL	L_main405
L_main404:
;DriverRF4463PROMain.c,689 :: 		else if ( ucRF4463Mode == rf_off ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_main406
;DriverRF4463PROMain.c,690 :: 		vRF4463RxInit();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,691 :: 		while ( 1 ) {
L_main407:
;DriverRF4463PROMain.c,693 :: 		if ( fUSART1Buffer == READY_TO_READ ) {
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main409
;DriverRF4463PROMain.c,694 :: 		break;
IT	AL
BAL	L_main408
;DriverRF4463PROMain.c,695 :: 		}
L_main409:
;DriverRF4463PROMain.c,698 :: 		if ( ucRF4463SendMessage == 1 ) {
MOVW	R0, #lo_addr(_ucRF4463SendMessage+0)
MOVT	R0, #hi_addr(_ucRF4463SendMessage+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main410
;DriverRF4463PROMain.c,699 :: 		ucRF4463SendMessage = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucRF4463SendMessage+0)
MOVT	R0, #hi_addr(_ucRF4463SendMessage+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,700 :: 		vRF4463TxData();
BL	_vRF4463TxData+0
;DriverRF4463PROMain.c,701 :: 		}
L_main410:
;DriverRF4463PROMain.c,703 :: 		}
IT	AL
BAL	L_main407
L_main408:
;DriverRF4463PROMain.c,704 :: 		}
L_main406:
L_main405:
L_main403:
;DriverRF4463PROMain.c,707 :: 		if ( ucRF4463Mode == tx_test_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_main411
;DriverRF4463PROMain.c,708 :: 		vRF4463TxCont();
BL	_vRF4463TxCont+0
;DriverRF4463PROMain.c,709 :: 		while ( 1 ) {
L_main412:
;DriverRF4463PROMain.c,711 :: 		if ( fUSART1Buffer == READY_TO_READ ) {
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main414
;DriverRF4463PROMain.c,712 :: 		break;
IT	AL
BAL	L_main413
;DriverRF4463PROMain.c,713 :: 		}
L_main414:
;DriverRF4463PROMain.c,715 :: 		if ( !nIRQ ) {
MOVW	R0, #lo_addr(GPIOD_IDRbits+0)
MOVT	R0, #hi_addr(GPIOD_IDRbits+0)
_LX	[R0, ByteOffset(GPIOD_IDRbits+0)]
CMP	R0, #0
IT	NE
BNE	L_main415
;DriverRF4463PROMain.c,716 :: 		vRF4463TxCont();
BL	_vRF4463TxCont+0
;DriverRF4463PROMain.c,717 :: 		}
L_main415:
;DriverRF4463PROMain.c,718 :: 		}
IT	AL
BAL	L_main412
L_main413:
;DriverRF4463PROMain.c,719 :: 		}
L_main411:
;DriverRF4463PROMain.c,721 :: 		if ( ucRF4463Mode == rx_test_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BNE	L_main416
;DriverRF4463PROMain.c,722 :: 		vRF4463RxInit ();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,723 :: 		while ( 1 ) {
L_main417:
;DriverRF4463PROMain.c,725 :: 		if ( fUSART1Buffer == READY_TO_READ ) {
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main419
;DriverRF4463PROMain.c,726 :: 		break;
IT	AL
BAL	L_main418
;DriverRF4463PROMain.c,727 :: 		}
L_main419:
;DriverRF4463PROMain.c,730 :: 		}
IT	AL
BAL	L_main417
L_main418:
;DriverRF4463PROMain.c,731 :: 		}
L_main416:
;DriverRF4463PROMain.c,733 :: 		if ( reset_mode == 0 ) {
MOVW	R0, #lo_addr(_reset_mode+0)
MOVT	R0, #hi_addr(_reset_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main420
;DriverRF4463PROMain.c,735 :: 		while ( 1 ) {
L_main421:
;DriverRF4463PROMain.c,737 :: 		if ( fUSART1Buffer == READY_TO_READ ) {
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main423
;DriverRF4463PROMain.c,738 :: 		break;
IT	AL
BAL	L_main422
;DriverRF4463PROMain.c,739 :: 		}
L_main423:
;DriverRF4463PROMain.c,741 :: 		if ( Flag.reach_1s ) {
MOVW	R1, #lo_addr(_Flag+0)
MOVT	R1, #hi_addr(_Flag+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main424
;DriverRF4463PROMain.c,742 :: 		Flag.reach_1s = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,743 :: 		if ( ucRF4463Mode == master_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main425
;DriverRF4463PROMain.c,744 :: 		vRF4463TxData();
BL	_vRF4463TxData+0
;DriverRF4463PROMain.c,745 :: 		}
L_main425:
;DriverRF4463PROMain.c,746 :: 		}
L_main424:
;DriverRF4463PROMain.c,749 :: 		if ( !Flag.is_tx ) {
MOVW	R1, #lo_addr(_Flag+0)
MOVT	R1, #hi_addr(_Flag+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_main426
;DriverRF4463PROMain.c,750 :: 		if ( !nIRQ ) {          // !nIRQ
MOVW	R0, #lo_addr(GPIOD_IDRbits+0)
MOVT	R0, #hi_addr(GPIOD_IDRbits+0)
_LX	[R0, ByteOffset(GPIOD_IDRbits+0)]
CMP	R0, #0
IT	NE
BNE	L_main427
;DriverRF4463PROMain.c,751 :: 		vRF4463ClearInterrupts();
BL	_vRF4463ClearInterrupts+0
;DriverRF4463PROMain.c,753 :: 		if ( ( spi_read_buf[ 4 ] & 0x08) == 0 ) { // crc error check
MOVW	R0, #lo_addr(_spi_read_buf+4)
MOVT	R0, #hi_addr(_spi_read_buf+4)
LDRB	R0, [R0, #0]
AND	R0, R0, #8
UXTB	R0, R0
CMP	R0, #0
IT	NE
BNE	L_main428
;DriverRF4463PROMain.c,757 :: 		spi_read_fifo();
BL	_spi_read_fifo+0
;DriverRF4463PROMain.c,758 :: 		vRF4463FifoReset();
BL	_vRF4463FifoReset+0
;DriverRF4463PROMain.c,760 :: 		chksum = 0;
MOVS	R0, #0
STRB	R0, [SP, #1]
;DriverRF4463PROMain.c,761 :: 		for ( i = 4; i < payload_length - 1; i++ )                // Calculation Checksum
MOVS	R0, #4
STRB	R0, [SP, #0]
L_main429:
LDRB	R0, [SP, #0]
CMP	R0, #65
IT	GE
BGE	L_main430
;DriverRF4463PROMain.c,762 :: 		chksum += rx_buf[ i ];
LDRB	R1, [SP, #0]
MOVW	R0, #lo_addr(_rx_buf+0)
MOVT	R0, #hi_addr(_rx_buf+0)
ADDS	R0, R0, R1
LDRB	R1, [R0, #0]
LDRB	R0, [SP, #1]
ADDS	R0, R0, R1
STRB	R0, [SP, #1]
;DriverRF4463PROMain.c,761 :: 		for ( i = 4; i < payload_length - 1; i++ )                // Calculation Checksum
LDRB	R0, [SP, #0]
ADDS	R0, R0, #1
STRB	R0, [SP, #0]
;DriverRF4463PROMain.c,762 :: 		chksum += rx_buf[ i ];
IT	AL
BAL	L_main429
L_main430:
;DriverRF4463PROMain.c,764 :: 		if ( ( chksum == rx_buf[ payload_length - 1 ] )&&( rx_buf[ 4 ] == 0x41 )) {
MOVW	R0, #lo_addr(_rx_buf+65)
MOVT	R0, #hi_addr(_rx_buf+65)
LDRB	R1, [R0, #0]
LDRB	R0, [SP, #1]
CMP	R0, R1
IT	NE
BNE	L__main525
MOVW	R0, #lo_addr(_rx_buf+4)
MOVT	R0, #hi_addr(_rx_buf+4)
LDRB	R0, [R0, #0]
CMP	R0, #65
IT	NE
BNE	L__main524
L__main523:
;DriverRF4463PROMain.c,765 :: 		UART1_Write_Text("[ Message ] =" );
ADD	R11, SP, #59
ADD	R10, R11, #14
MOVW	R12, #lo_addr(?ICS?lstr11_DriverRF4463PROMain+0)
MOVT	R12, #hi_addr(?ICS?lstr11_DriverRF4463PROMain+0)
BL	___CC2DW+0
ADD	R0, SP, #59
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,766 :: 		UART1_Write_Text( rx_buf );
MOVW	R0, #lo_addr(_rx_buf+0)
MOVT	R0, #hi_addr(_rx_buf+0)
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,767 :: 		UART1_Write_Text("\r\n");
MOVS	R0, #13
STRB	R0, [SP, #73]
MOVS	R0, #10
STRB	R0, [SP, #74]
MOVS	R0, #0
STRB	R0, [SP, #75]
ADD	R0, SP, #73
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,769 :: 		LED_GREEN ^= 1;                                        // Data received
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_LX	[R0, ByteOffset(GPIOE_ODRbits+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODRbits+0)
MOVT	R0, #hi_addr(GPIOE_ODRbits+0)
_SX	[R0, ByteOffset(GPIOE_ODRbits+0)]
;DriverRF4463PROMain.c,770 :: 		rx_cnt++;
MOVW	R1, #lo_addr(_rx_cnt+0)
MOVT	R1, #hi_addr(_rx_cnt+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,772 :: 		}
IT	AL
BAL	L_main435
;DriverRF4463PROMain.c,764 :: 		if ( ( chksum == rx_buf[ payload_length - 1 ] )&&( rx_buf[ 4 ] == 0x41 )) {
L__main525:
L__main524:
;DriverRF4463PROMain.c,774 :: 		vRF4463RxInit();    // The received data is wrong, you must continue to receive
BL	_vRF4463RxInit+0
L_main435:
;DriverRF4463PROMain.c,775 :: 		}
IT	AL
BAL	L_main436
L_main428:
;DriverRF4463PROMain.c,778 :: 		UART1_Write_Text("[ CRC ] Fail\r\n" );
ADD	R11, SP, #76
ADD	R10, R11, #15
MOVW	R12, #lo_addr(?ICS?lstr13_DriverRF4463PROMain+0)
MOVT	R12, #hi_addr(?ICS?lstr13_DriverRF4463PROMain+0)
BL	___CC2DW+0
ADD	R0, SP, #76
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,779 :: 		VRF4463SDNReset();
BL	_VRF4463SDNReset+0
;DriverRF4463PROMain.c,780 :: 		vRF4463Init();
BL	_vRF4463Init+0
;DriverRF4463PROMain.c,781 :: 		vRF4463RxInit();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,782 :: 		}
L_main436:
;DriverRF4463PROMain.c,783 :: 		}
L_main427:
;DriverRF4463PROMain.c,784 :: 		}
L_main426:
;DriverRF4463PROMain.c,785 :: 		}
IT	AL
BAL	L_main421
L_main422:
;DriverRF4463PROMain.c,786 :: 		}
L_main420:
;DriverRF4463PROMain.c,787 :: 		}
IT	AL
BAL	L_main399
;DriverRF4463PROMain.c,788 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
