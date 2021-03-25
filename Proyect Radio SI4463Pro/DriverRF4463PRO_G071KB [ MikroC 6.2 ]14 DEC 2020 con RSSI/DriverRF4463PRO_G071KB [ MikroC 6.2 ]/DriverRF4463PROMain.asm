_Int_SPI2:
;driverspi.c,16 :: 		void Int_SPI2() iv IVT_INT_SPI2 ics ICS_AUTO {
;driverspi.c,18 :: 		if ( SPI2_SRbits.RXNE ) {
MOVW	R0, #lo_addr(SPI2_SRbits+0)
MOVT	R0, #hi_addr(SPI2_SRbits+0)
_LX	[R0, ByteOffset(SPI2_SRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_Int_SPI20
;driverspi.c,19 :: 		ucSPI2ByteReceived = ( unsigned char )SPI2_DR;      // lee el Byte recibido
MOVW	R0, #lo_addr(SPI2_DR+0)
MOVT	R0, #hi_addr(SPI2_DR+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucSPI2ByteReceived+0)
MOVT	R0, #hi_addr(_ucSPI2ByteReceived+0)
STRB	R1, [R0, #0]
;driverspi.c,21 :: 		LED_GREEN = ~LED_GREEN;
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_LX	[R0, ByteOffset(GPIOC_ODRbits+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;driverspi.c,22 :: 		}
L_Int_SPI20:
;driverspi.c,23 :: 		}
L_end_Int_SPI2:
BX	LR
; end of _Int_SPI2
_vSPI2Init:
;driverspi.c,90 :: 		void vSPI2Init ( void ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;driverspi.c,92 :: 		_SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI2_PB13_14_15 );
MOVW	R2, #lo_addr(__GPIO_MODULE_SPI2_PB13_14_15+0)
MOVT	R2, #hi_addr(__GPIO_MODULE_SPI2_PB13_14_15+0)
MOVW	R1, #772
;driverspi.c,91 :: 		SPI2_Init_Advanced( _SPI_FPCLK_DIV8, _SPI_MASTER | _SPI_8_BIT | _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION | _SPI_MSB_FIRST |
MOVS	R0, #2
;driverspi.c,92 :: 		_SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI2_PB13_14_15 );
BL	_SPI2_Init_Advanced+0
;driverspi.c,94 :: 		SPI2_CR2bits.RXNEIE  = 1;       // habilitacion de ISR para RX
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(SPI2_CR2bits+0)
MOVT	R0, #hi_addr(SPI2_CR2bits+0)
_SX	[R0, ByteOffset(SPI2_CR2bits+0)]
;driverspi.c,96 :: 		NVIC_IntEnable( IVT_INT_SPI2 );
MOVW	R0, #52
BL	_NVIC_IntEnable+0
;driverspi.c,97 :: 		}
L_end_vSPI2Init:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vSPI2Init
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
;driverrf4463pro.c,181 :: 		app_command_buf[ 7 ] =  0x00;        // Sync word 1
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
;driverrf4463pro.c,213 :: 		app_command_buf[ 1 ]  = 0x12;       // 0x120d
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,214 :: 		app_command_buf[ 2 ]  = 0x0c;       // Total 12 Parameters
ADDS	R1, R2, #2
MOVS	R0, #12
STRB	R0, [R1, #0]
;driverrf4463pro.c,215 :: 		app_command_buf[ 3 ]  = 0x0d;       // 0x120d
ADDS	R1, R2, #3
MOVS	R0, #13
STRB	R0, [R1, #0]
;driverrf4463pro.c,216 :: 		app_command_buf[ 4 ]  = 0x00;       //  Field 1 length (?4?)
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,217 :: 		app_command_buf[ 5 ]  = payload_length;   //  field 1 length, (? 8?), ?Total14???
ADDS	R1, R2, #5
MOVS	R0, #66
STRB	R0, [R1, #0]
;driverrf4463pro.c,218 :: 		app_command_buf[ 6 ]  = 0x04;       // field 1 Is not 4FSK,manchest, whiting, PN9,
ADDS	R1, R2, #6
MOVS	R0, #4
STRB	R0, [R1, #0]
;driverrf4463pro.c,219 :: 		app_command_buf[ 7 ]  = 0xaa;       // field 1 crc enble, check enbale, There are also launchingCRC,cRC?Seed ?CRC_seed?????
ADDS	R1, R2, #7
MOVS	R0, #170
STRB	R0, [R1, #0]
;driverrf4463pro.c,220 :: 		app_command_buf[ 8 ]  = 0x00;       //  field 2 length(?4?)
ADDW	R1, R2, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,221 :: 		app_command_buf[ 9 ]  = 0x00;           //  field 2 length, (? 8?), length = 0 Means thisfield did not use
ADDW	R1, R2, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,222 :: 		app_command_buf[ 10 ] = 0x00;       // field 2 Is not 4FSK,manchest, whiting, PN9
ADDW	R1, R2, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,223 :: 		app_command_buf[ 11 ] = 0x00;       //  field 2 ?CRCSet up
ADDW	R1, R2, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,224 :: 		app_command_buf[ 12 ] = 0x00;       //  field 3 length, (? 8?), length = 0 Means thisfield did not use
ADDW	R1, R2, #12
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,225 :: 		app_command_buf[ 13 ] = 0x00;           //  field 3 length, (? 8?), length = 0 Means thisfield did not use
ADDW	R1, R2, #13
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,226 :: 		app_command_buf[ 14 ] = 0x00;       //  field 3 Is not 4FSK,manchest, whiting, PN9
ADDW	R1, R2, #14
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,227 :: 		app_command_buf[ 15 ] = 0x00;       //  field 3 ?CRCSet up
ADDW	R1, R2, #15
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,228 :: 		spi_write( 16, app_command_buf );
MOV	R1, R2
MOVS	R0, #16
BL	_spi_write+0
;driverrf4463pro.c,231 :: 		app_command_buf[ 0 ]  = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,232 :: 		app_command_buf[ 1 ]  = 0x12;       // 0x1219
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,233 :: 		app_command_buf[ 2 ]  = 0x08;       // Total 8Parameters
ADDS	R1, R2, #2
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,234 :: 		app_command_buf[ 3 ]  = 0x19;       // 0x1219
ADDS	R1, R2, #3
MOVS	R0, #25
STRB	R0, [R1, #0]
;driverrf4463pro.c,235 :: 		app_command_buf[ 4 ]  = 0x00;       // field4 length(?4?)
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,236 :: 		app_command_buf[ 5 ]  = 0x00;       // field 4 length, (? 8?), length = 0 Means this field did not use
ADDS	R1, R2, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,237 :: 		app_command_buf[ 6 ]  = 0x00;       // field 4 Is not 4FSK,manchest, whiting, PN9
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,238 :: 		app_command_buf[ 7 ]  = 0x00;       // field 4 ?CRCSet up
ADDS	R1, R2, #7
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,239 :: 		app_command_buf[ 8 ]  = 0x00;       // field5 length(?4?)
ADDW	R1, R2, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,240 :: 		app_command_buf[ 9 ]  = 0x00;       // field 5 length, (? 8?), length = 0 Means this field did not use
ADDW	R1, R2, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,241 :: 		app_command_buf[ 10 ] = 0x00;       // field 5 Is not 4FSK,manchest, whiting, PN9
ADDW	R1, R2, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,242 :: 		app_command_buf[ 11 ] = 0x00;       // field 5 ?CRCSet up
ADDW	R1, R2, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,243 :: 		spi_write( 12, app_command_buf );
MOV	R1, R2
MOVS	R0, #12
BL	_spi_write+0
;driverrf4463pro.c,246 :: 		spi_write( 0x10, RF_MODEM_MOD_TYPE_12_data );   // //  2FSK ,  module source = PH fifo, disable manchest, tx, rx Do not flip, deviation Do not flip
MOVW	R1, #lo_addr(_RF_MODEM_MOD_TYPE_12_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_MOD_TYPE_12_data+0)
MOVS	R0, #16
BL	_spi_write+0
;driverrf4463pro.c,249 :: 		app_command_buf[0] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,250 :: 		app_command_buf[1]  = 0x20;    // 0x200c
ADDS	R1, R2, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,251 :: 		app_command_buf[2]  = 0x01;    // Total 1Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,252 :: 		app_command_buf[3]  = 0x0c;   // 0x200c
ADDS	R1, R2, #3
MOVS	R0, #12
STRB	R0, [R1, #0]
;driverrf4463pro.c,254 :: 		if ( ucRF4463Freq3 < 8 ) {
MOVW	R0, #lo_addr(_ucRF4463Freq3+0)
MOVT	R0, #hi_addr(_ucRF4463Freq3+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CS
BCS	L_vRF4463Init61
;driverrf4463pro.c,255 :: 		if ( ucRF4463Rate >= dr_256k ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CC
BCC	L_vRF4463Init62
;driverrf4463pro.c,256 :: 		app_command_buf[ 4 ] = 0x4f;
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #79
STRB	R0, [R1, #0]
;driverrf4463pro.c,257 :: 		}
IT	AL
BAL	L_vRF4463Init63
L_vRF4463Init62:
;driverrf4463pro.c,258 :: 		else if ( ucRF4463Rate >= dr_19p2 ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	CC
BCC	L_vRF4463Init64
;driverrf4463pro.c,259 :: 		app_command_buf[ 4 ]  = 0x5e;
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #94
STRB	R0, [R1, #0]
;driverrf4463pro.c,260 :: 		}
IT	AL
BAL	L_vRF4463Init65
L_vRF4463Init64:
;driverrf4463pro.c,262 :: 		app_command_buf[ 4 ]  = 0xd2;
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #210
STRB	R0, [R1, #0]
;driverrf4463pro.c,263 :: 		}
L_vRF4463Init65:
L_vRF4463Init63:
;driverrf4463pro.c,264 :: 		}
IT	AL
BAL	L_vRF4463Init66
L_vRF4463Init61:
;driverrf4463pro.c,266 :: 		if ( ucRF4463Rate >= dr_115p2 ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	CC
BCC	L_vRF4463Init67
;driverrf4463pro.c,267 :: 		app_command_buf[ 4 ]  = 0x69;        // 15k
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #105
STRB	R0, [R1, #0]
;driverrf4463pro.c,268 :: 		}
IT	AL
BAL	L_vRF4463Init68
L_vRF4463Init67:
;driverrf4463pro.c,269 :: 		else if ( ucRF4463Rate >= dr_19p2 ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	CC
BCC	L_vRF4463Init69
;driverrf4463pro.c,270 :: 		app_command_buf[ 4 ]  = 0x5e;        // 10k
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #94
STRB	R0, [R1, #0]
;driverrf4463pro.c,271 :: 		}
IT	AL
BAL	L_vRF4463Init70
L_vRF4463Init69:
;driverrf4463pro.c,273 :: 		app_command_buf[ 4 ]  = 0x18; // 8k
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #24
STRB	R0, [R1, #0]
;driverrf4463pro.c,274 :: 		}
L_vRF4463Init70:
L_vRF4463Init68:
;driverrf4463pro.c,275 :: 		}
L_vRF4463Init66:
;driverrf4463pro.c,276 :: 		spi_write( 5, app_command_buf );
ADD	R0, SP, #4
MOV	R1, R0
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,279 :: 		spi_write( 0x0C, RF_MODEM_TX_RAMP_DELAY_8_data );            // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
MOVS	R0, #12
BL	_spi_write+0
;driverrf4463pro.c,280 :: 		spi_write( 0x0D, RF_MODEM_BCR_OSR_1_9_data );                // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
MOVS	R0, #13
BL	_spi_write+0
;driverrf4463pro.c,281 :: 		spi_write( 0x0B, RF_MODEM_AFC_GEAR_7_data );                // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_AFC_GEAR_7_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_AFC_GEAR_7_data+0)
MOVS	R0, #11
BL	_spi_write+0
;driverrf4463pro.c,282 :: 		spi_write( 0x05, RF_MODEM_AGC_CONTROL_1_data );                // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_AGC_CONTROL_1_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_AGC_CONTROL_1_data+0)
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,283 :: 		spi_write( 0x0D, RF_MODEM_AGC_WINDOW_SIZE_9_data );        // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
MOVS	R0, #13
BL	_spi_write+0
;driverrf4463pro.c,284 :: 		spi_write( 0x0F, RF_MODEM_OOK_CNT1_11_data );                // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_OOK_CNT1_11_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_OOK_CNT1_11_data+0)
MOVS	R0, #15
BL	_spi_write+0
;driverrf4463pro.c,287 :: 		app_command_buf[ 0 ] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,288 :: 		app_command_buf[ 1 ] = 0x20;    // 0x204e
ADDS	R1, R2, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,289 :: 		app_command_buf[ 2 ] = 0x01;    // Total 1Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,290 :: 		app_command_buf[ 3 ] = 0x4e;   // 0x204e
ADDS	R1, R2, #3
MOVS	R0, #78
STRB	R0, [R1, #0]
;driverrf4463pro.c,292 :: 		if ( ucRF4463Rate == dr_500 ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	NE
BNE	L_vRF4463Init71
;driverrf4463pro.c,293 :: 		app_command_buf[ 4 ] = 0x3a;
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #58
STRB	R0, [R1, #0]
;driverrf4463pro.c,294 :: 		}
IT	AL
BAL	L_vRF4463Init72
L_vRF4463Init71:
;driverrf4463pro.c,296 :: 		app_command_buf[ 4 ] = 0x40;  //  rssi Reading deviation, the difference with the true value
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #64
STRB	R0, [R1, #0]
;driverrf4463pro.c,297 :: 		}
L_vRF4463Init72:
;driverrf4463pro.c,298 :: 		spi_write( 5, app_command_buf );
ADD	R0, SP, #4
MOV	R1, R0
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,301 :: 		spi_write( 0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data );  // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVS	R0, #16
BL	_spi_write+0
;driverrf4463pro.c,302 :: 		spi_write( 0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data );   // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVS	R0, #16
BL	_spi_write+0
;driverrf4463pro.c,303 :: 		spi_write( 0x10, RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data );   // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVS	R0, #16
BL	_spi_write+0
;driverrf4463pro.c,306 :: 		app_command_buf[ 0 ]  = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,307 :: 		app_command_buf[ 1 ]  = 0x22;    // 0x2200
ADDS	R1, R2, #1
MOVS	R0, #34
STRB	R0, [R1, #0]
;driverrf4463pro.c,308 :: 		app_command_buf[ 2 ]  = 0x04;    // Total 4Parameters
ADDS	R1, R2, #2
MOVS	R0, #4
STRB	R0, [R1, #0]
;driverrf4463pro.c,309 :: 		app_command_buf[ 3 ]  = 0x00;   // 0x2200
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,310 :: 		app_command_buf[ 4 ]  = 0x08;  //0x10;   //   PA mode  = default , ??Class E mode,?Is not Switch Current mode  ????????
ADDS	R1, R2, #4
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,312 :: 		if ( ucRF4463Power > 0 || ucRF4463Power < 127 ) {
MOVW	R0, #lo_addr(_ucRF4463Power+0)
MOVT	R0, #hi_addr(_ucRF4463Power+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	HI
BHI	L__vRF4463Init411
MOVW	R0, #lo_addr(_ucRF4463Power+0)
MOVT	R0, #hi_addr(_ucRF4463Power+0)
LDRB	R0, [R0, #0]
CMP	R0, #127
IT	CC
BCC	L__vRF4463Init410
IT	AL
BAL	L_vRF4463Init75
L__vRF4463Init411:
L__vRF4463Init410:
;driverrf4463pro.c,313 :: 		app_command_buf[ 5 ]  = ucRF4463Power;   //  Set to maximum power
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVW	R0, #lo_addr(_ucRF4463Power+0)
MOVT	R0, #hi_addr(_ucRF4463Power+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,314 :: 		}
IT	AL
BAL	L_vRF4463Init76
L_vRF4463Init75:
;driverrf4463pro.c,316 :: 		app_command_buf[ 5 ]  = 127;
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #127
STRB	R0, [R1, #0]
;driverrf4463pro.c,317 :: 		}
L_vRF4463Init76:
;driverrf4463pro.c,319 :: 		app_command_buf[ 6 ] = 0x00; //???????? 0x00;   // CLK duty = 50%, other = Default
ADD	R0, SP, #4
ADDS	R1, R0, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,322 :: 		if ( ( ucRF4463Rate <= dr_115p2 ) ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	HI
BHI	L_vRF4463Init77
;driverrf4463pro.c,323 :: 		app_command_buf[ 7 ]  = 0x3d;  // ???????? 0x5d;   // PA ramp time = default
ADD	R0, SP, #4
ADDS	R1, R0, #7
MOVS	R0, #61
STRB	R0, [R1, #0]
;driverrf4463pro.c,324 :: 		}
IT	AL
BAL	L_vRF4463Init78
L_vRF4463Init77:
;driverrf4463pro.c,326 :: 		app_command_buf[ 7 ]  = 0x5d;
ADD	R0, SP, #4
ADDS	R1, R0, #7
MOVS	R0, #93
STRB	R0, [R1, #0]
;driverrf4463pro.c,327 :: 		}
L_vRF4463Init78:
;driverrf4463pro.c,328 :: 		spi_write( 8, app_command_buf );
ADD	R0, SP, #4
MOV	R1, R0
MOVS	R0, #8
BL	_spi_write+0
;driverrf4463pro.c,332 :: 		spi_write( 0x0B , RF_SYNTH_PFDCP_CPFF_7_data );      // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
MOVT	R1, #hi_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
MOVS	R0, #11
BL	_spi_write+0
;driverrf4463pro.c,335 :: 		if ( ucRF4463MatchEnabled ) {
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463Init79
;driverrf4463pro.c,336 :: 		app_command_buf[ 0 ]  = 0x11;               // SetProperty
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,337 :: 		app_command_buf[ 1 ]  = 0x30;               // 0x30 group
ADDS	R1, R2, #1
MOVS	R0, #48
STRB	R0, [R1, #0]
;driverrf4463pro.c,338 :: 		app_command_buf[ 2 ]  = 0x0c;               // Total 12 Parameters
ADDS	R1, R2, #2
MOVS	R0, #12
STRB	R0, [R1, #0]
;driverrf4463pro.c,339 :: 		app_command_buf[ 3 ]  = 0x00;               // 0x00 Index
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,340 :: 		app_command_buf[ 4 ]  = ucRF4463ByteMatch1; // match 1 Value of
ADDS	R1, R2, #4
MOVW	R0, #lo_addr(_ucRF4463ByteMatch1+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch1+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,341 :: 		app_command_buf[ 5 ]  = ucRF4463ByteMask1;  // match 1 mask
ADDS	R1, R2, #5
MOVW	R0, #lo_addr(_ucRF4463ByteMask1+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask1+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,342 :: 		app_command_buf[ 6 ]  = ucRF4463MatchEnableReg; //  0x40; // enable match 1, match 1 The distance between the value of and the synchronization word, 0 = match
ADDS	R1, R2, #6
MOVW	R0, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnableReg+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,343 :: 		app_command_buf[ 7 ]  = ucRF4463ByteMatch2; // match 2 Value of
ADDS	R1, R2, #7
MOVW	R0, #lo_addr(_ucRF4463ByteMatch2+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch2+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,344 :: 		app_command_buf[ 8 ]  = ucRF4463ByteMask2;  // match 2 mask
ADDW	R1, R2, #8
MOVW	R0, #lo_addr(_ucRF4463ByteMask2+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask2+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,345 :: 		app_command_buf[ 9 ]  = 0x01;               // enable match 2, match 2 The distance between the value of and the synchronization word  , and function
ADDW	R1, R2, #9
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,346 :: 		app_command_buf[ 10 ] = ucRF4463ByteMatch3; // match 3 Value of
ADDW	R1, R2, #10
MOVW	R0, #lo_addr(_ucRF4463ByteMatch3+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch3+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,347 :: 		app_command_buf[ 11 ] = ucRF4463ByteMask3;  // match 3 mask
ADDW	R1, R2, #11
MOVW	R0, #lo_addr(_ucRF4463ByteMask3+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask3+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,348 :: 		app_command_buf[ 12 ] = 0x02;;              // enable match 3, match 3 The distance between the value of and the synchronization word    and function
ADDW	R1, R2, #12
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,349 :: 		app_command_buf[ 13 ] = ucRF4463ByteMatch4; // match 4 Value of
ADDW	R1, R2, #13
MOVW	R0, #lo_addr(_ucRF4463ByteMatch4+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch4+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,350 :: 		app_command_buf[ 14 ] = ucRF4463ByteMask4;  // match 4 mask
ADDW	R1, R2, #14
MOVW	R0, #lo_addr(_ucRF4463ByteMask4+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask4+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,351 :: 		app_command_buf[ 15 ] = 0x03;               // enable match 4, match 4 The distance between the value of and the synchronization word    and function
ADDW	R1, R2, #15
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,352 :: 		spi_write( 16, app_command_buf );
MOV	R1, R2
MOVS	R0, #16
BL	_spi_write+0
;driverrf4463pro.c,354 :: 		if ( ucRF4463MatchEnableReg == 0x00 ) {
MOVW	R0, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnableReg+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_vRF4463Init80
;driverrf4463pro.c,355 :: 		ucRF4463MatchEnabled = 0;                // deshabilita el Match
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R1, [R0, #0]
;driverrf4463pro.c,356 :: 		}
L_vRF4463Init80:
;driverrf4463pro.c,375 :: 		}
L_vRF4463Init79:
;driverrf4463pro.c,378 :: 		rf_init_freq();     // FUNCION DE FRECUENCIA ( REVISAR PARAMETROS )
BL	_rf_init_freq+0
;driverrf4463pro.c,379 :: 		}
L_end_vRF4463Init:
LDR	LR, [SP, #0]
ADD	SP, SP, #24
BX	LR
; end of _vRF4463Init
_vRF4463GPIO_SET:
;driverrf4463pro.c,385 :: 		void vRF4463GPIO_SET( unsigned char ucData ) {
; ucData start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
; ucData end address is: 0 (R0)
; ucData start address is: 0 (R0)
;driverrf4463pro.c,388 :: 		ucAppCommandBuf[0] = 0x13;     // gpio Set up
ADD	R2, SP, #4
MOVS	R1, #19
STRB	R1, [R2, #0]
;driverrf4463pro.c,390 :: 		switch ( ucData ) {
IT	AL
BAL	L_vRF4463GPIO_SET81
; ucData end address is: 0 (R0)
;driverrf4463pro.c,391 :: 		case tx_normal:
L_vRF4463GPIO_SET83:
;driverrf4463pro.c,392 :: 		case rx_normal: ucAppCommandBuf[ 1 ] = 3;                 // GPIO0=1
L_vRF4463GPIO_SET84:
ADD	R3, SP, #4
ADDS	R2, R3, #1
MOVS	R1, #3
STRB	R1, [R2, #0]
;driverrf4463pro.c,393 :: 		ucAppCommandBuf[ 2 ] = 2;                // GPIO1=0
ADDS	R2, R3, #2
MOVS	R1, #2
STRB	R1, [R2, #0]
;driverrf4463pro.c,394 :: 		break;
IT	AL
BAL	L_vRF4463GPIO_SET82
;driverrf4463pro.c,396 :: 		case tx_test:   ucAppCommandBuf[ 1 ] = 3;                 // GPIO0=1
L_vRF4463GPIO_SET85:
ADD	R3, SP, #4
ADDS	R2, R3, #1
MOVS	R1, #3
STRB	R1, [R2, #0]
;driverrf4463pro.c,397 :: 		ucAppCommandBuf[ 2 ] = 3;                // GPIO1=1
ADDS	R2, R3, #2
MOVS	R1, #3
STRB	R1, [R2, #0]
;driverrf4463pro.c,398 :: 		break;
IT	AL
BAL	L_vRF4463GPIO_SET82
;driverrf4463pro.c,400 :: 		case rx_test:   ucAppCommandBuf[ 1 ] = 2;                 // GPIO0=0
L_vRF4463GPIO_SET86:
ADD	R3, SP, #4
ADDS	R2, R3, #1
MOVS	R1, #2
STRB	R1, [R2, #0]
;driverrf4463pro.c,401 :: 		ucAppCommandBuf[ 2 ] = 20;                // GPIO1=RX DATA
ADDS	R2, R3, #2
MOVS	R1, #20
STRB	R1, [R2, #0]
;driverrf4463pro.c,402 :: 		break;
IT	AL
BAL	L_vRF4463GPIO_SET82
;driverrf4463pro.c,404 :: 		case rf_off:    ucAppCommandBuf[ 1 ] = 2;                 // GPIO0=0
L_vRF4463GPIO_SET87:
ADD	R3, SP, #4
ADDS	R2, R3, #1
MOVS	R1, #2
STRB	R1, [R2, #0]
;driverrf4463pro.c,405 :: 		ucAppCommandBuf[ 2 ] = 2;                // GPIO1=0
ADDS	R2, R3, #2
MOVS	R1, #2
STRB	R1, [R2, #0]
;driverrf4463pro.c,406 :: 		break;
IT	AL
BAL	L_vRF4463GPIO_SET82
;driverrf4463pro.c,407 :: 		}
L_vRF4463GPIO_SET81:
; ucData start address is: 0 (R0)
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463GPIO_SET83
CMP	R0, #1
IT	EQ
BEQ	L_vRF4463GPIO_SET84
CMP	R0, #2
IT	EQ
BEQ	L_vRF4463GPIO_SET85
CMP	R0, #3
IT	EQ
BEQ	L_vRF4463GPIO_SET86
CMP	R0, #4
IT	EQ
BEQ	L_vRF4463GPIO_SET87
; ucData end address is: 0 (R0)
L_vRF4463GPIO_SET82:
;driverrf4463pro.c,409 :: 		ucAppCommandBuf[ 3 ]  = 0x21;     //0x20;   //  gpio2, h = tx mode
ADD	R3, SP, #4
ADDS	R2, R3, #3
MOVS	R1, #33
STRB	R1, [R2, #0]
;driverrf4463pro.c,410 :: 		ucAppCommandBuf[ 4 ]  = 0x20;     // 0x14;  //   gpio3
ADDS	R2, R3, #4
MOVS	R1, #32
STRB	R1, [R2, #0]
;driverrf4463pro.c,411 :: 		ucAppCommandBuf[ 5 ]  = 0x27;     // nIRQ
ADDS	R2, R3, #5
MOVS	R1, #39
STRB	R1, [R2, #0]
;driverrf4463pro.c,412 :: 		ucAppCommandBuf[ 6 ]  = 0x0b;     // sdo
ADDS	R2, R3, #6
MOVS	R1, #11
STRB	R1, [R2, #0]
;driverrf4463pro.c,413 :: 		spi_write( 7, ucAppCommandBuf );
MOV	R1, R3
MOVS	R0, #7
BL	_spi_write+0
;driverrf4463pro.c,414 :: 		}
L_end_vRF4463GPIO_SET:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRF4463GPIO_SET
_vRF4463FifoReset:
;driverrf4463pro.c,419 :: 		void vRF4463FifoReset( void ) {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;driverrf4463pro.c,422 :: 		p[ 0 ] = FIFO_INFO;
ADD	R2, SP, #4
MOVS	R0, #21
STRB	R0, [R2, #0]
;driverrf4463pro.c,423 :: 		p[ 1 ] = 0x03;   // reset tx ,rx fifo
ADDS	R1, R2, #1
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,424 :: 		spi_write( 2, p );
MOV	R1, R2
MOVS	R0, #2
BL	_spi_write+0
;driverrf4463pro.c,425 :: 		}
L_end_vRF4463FifoReset:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vRF4463FifoReset
_vRF4463ClearInterrupts:
;driverrf4463pro.c,431 :: 		void vRF4463ClearInterrupts( void ) {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;driverrf4463pro.c,434 :: 		p[ 0 ] = GET_INT_STATUS;
ADD	R2, SP, #4
MOVS	R0, #32
STRB	R0, [R2, #0]
;driverrf4463pro.c,435 :: 		p[ 1 ] = 0;               // clr  PH pending
ADDS	R1, R2, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,436 :: 		p[ 2 ] = 0;               // clr modem_pending
ADDS	R1, R2, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,437 :: 		p[ 3 ] = 0;               // clr chip pending
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,438 :: 		spi_write( 4, p );
MOV	R1, R2
MOVS	R0, #4
BL	_spi_write+0
;driverrf4463pro.c,439 :: 		spi_read( 9, GET_INT_STATUS );
MOVS	R1, #32
MOVS	R0, #9
BL	_spi_read+0
;driverrf4463pro.c,440 :: 		}
L_end_vRF4463ClearInterrupts:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vRF4463ClearInterrupts
_vRF4463PartInfo:
;driverrf4463pro.c,442 :: 		void vRF4463PartInfo( void ) {  // Solicitud totalmente operativa
SUB	SP, SP, #16
STR	LR, [SP, #0]
;driverrf4463pro.c,445 :: 		p[ 0 ] = PART_INFO;
ADD	R1, SP, #4
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,449 :: 		spi_write( 1, p );
MOVS	R0, #1
BL	_spi_write+0
;driverrf4463pro.c,450 :: 		spi_read( 9, PART_INFO );
MOVS	R1, #1
MOVS	R0, #9
BL	_spi_read+0
;driverrf4463pro.c,451 :: 		}
L_end_vRF4463PartInfo:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _vRF4463PartInfo
_vRF4463EnableRxInterrupt:
;driverrf4463pro.c,456 :: 		void vRF4463EnableRxInterrupt( void ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,459 :: 		p[ 0 ] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,460 :: 		p[ 1 ] = 0x01;            // 0x0100
ADDS	R1, R2, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,461 :: 		p[ 2 ] = 0x03;            // 3Parameters
ADDS	R1, R2, #2
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,462 :: 		p[ 3 ] = 0x00;            // 0100
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,463 :: 		p[ 4 ] = 0x03;            // ph, modem int       0x03;
ADDS	R1, R2, #4
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,464 :: 		p[ 5 ] = 0x18;            // 0x10;   // Pack received int
ADDS	R1, R2, #5
MOVS	R0, #24
STRB	R0, [R1, #0]
;driverrf4463pro.c,465 :: 		p[ 6 ] = 0x00;            //preamble int, sync int setting
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,466 :: 		spi_write( 0x07, p );     // enable  packet receive interrupt
MOV	R1, R2
MOVS	R0, #7
BL	_spi_write+0
;driverrf4463pro.c,467 :: 		}
L_end_vRF4463EnableRxInterrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRF4463EnableRxInterrupt
_vRF4463EnableTxInterrupt:
;driverrf4463pro.c,472 :: 		void vRF4463EnableTxInterrupt( void ) {
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
;driverrf4463pro.c,477 :: 		p[ 2 ] = 0x02;            // 2Parameters
ADDS	R1, R2, #2
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,478 :: 		p[ 3 ] = 0x00;            // 0x0100
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,479 :: 		p[ 4 ] = 0x01;            // Ph  int
ADDS	R1, R2, #4
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,480 :: 		p[ 5 ] = 0x20;            //  enable  packet sent interrupt
ADDS	R1, R2, #5
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,481 :: 		spi_write( 0x06, p );     // enable  packet receive interrupt
MOV	R1, R2
MOVS	R0, #6
BL	_spi_write+0
;driverrf4463pro.c,482 :: 		}
L_end_vRF4463EnableTxInterrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRF4463EnableTxInterrupt
_vRF4463RfStandby:
;driverrf4463pro.c,487 :: 		void vRF4463RfStandby( void ) {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;driverrf4463pro.c,490 :: 		p[ 0 ] = CHANGE_STATE ;   // CHANGE_STATE Command
ADD	R2, SP, #4
MOVS	R0, #52
STRB	R0, [R2, #0]
;driverrf4463pro.c,491 :: 		p[ 1 ] = 0x01 ;           // sleep mode
ADDS	R1, R2, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,492 :: 		spi_write( 2, p );
MOV	R1, R2
MOVS	R0, #2
BL	_spi_write+0
;driverrf4463pro.c,493 :: 		}
L_end_vRF4463RfStandby:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vRF4463RfStandby
_vRF4463TxStart:
;driverrf4463pro.c,498 :: 		void vRF4463TxStart( void ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,501 :: 		p[ 0 ] = START_TX ;              // start Command
ADD	R2, SP, #4
MOVS	R0, #49
STRB	R0, [R2, #0]
;driverrf4463pro.c,502 :: 		p[ 1 ] = ucRF4463FreqChannel;    // channel 1 default
ADDS	R1, R2, #1
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,503 :: 		p[ 2 ] = 0x30;                   // Back after launch Readymode, Do not retransmit, launch immediately
ADDS	R1, R2, #2
MOVS	R0, #48
STRB	R0, [R1, #0]
;driverrf4463pro.c,504 :: 		p[ 3 ] = 0;
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,505 :: 		p[ 4 ] = 0;                      // payload_length; // Total to transmit 10 bytes
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,506 :: 		spi_write( 5, p );
MOV	R1, R2
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,507 :: 		}
L_end_vRF4463TxStart:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRF4463TxStart
_vRF4463RxStart:
;driverrf4463pro.c,512 :: 		void vRF4463RxStart( void ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,515 :: 		p[ 0 ] = START_RX ;              // start Command
ADD	R2, SP, #4
MOVS	R0, #50
STRB	R0, [R2, #0]
;driverrf4463pro.c,516 :: 		p[ 1 ] = ucRF4463FreqChannel;    // channel 0
ADDS	R1, R2, #1
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,517 :: 		p[ 2 ] = 0x00;                   // Enter receiving mode immediately
ADDS	R1, R2, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,518 :: 		p[ 3 ] = 0;
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,519 :: 		p[ 4 ] = 0;                      // payload_length; // Total to receive 10 bytes
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,520 :: 		p[ 5 ] = 0;                      // unchanged after preamble timeout
ADDS	R1, R2, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,523 :: 		p[ 6 ] = 0x08;
ADDS	R1, R2, #6
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,524 :: 		p[ 7 ] = 0x08;
ADDS	R1, R2, #7
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,525 :: 		spi_write( 8, p );
MOV	R1, R2
MOVS	R0, #8
BL	_spi_write+0
;driverrf4463pro.c,526 :: 		}
L_end_vRF4463RxStart:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRF4463RxStart
_vRF4463RxStartTest:
;driverrf4463pro.c,531 :: 		void vRF4463RxStartTest( void ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,534 :: 		LED_GREEN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;driverrf4463pro.c,536 :: 		p[ 0 ] = START_RX;        // start Command
ADD	R2, SP, #4
MOVS	R0, #50
STRB	R0, [R2, #0]
;driverrf4463pro.c,537 :: 		p[ 1 ] = ucRF4463FreqChannel;    // channel 0
ADDS	R1, R2, #1
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,538 :: 		p[ 2 ] = 0x00;            // Enter receiving mode immediately
ADDS	R1, R2, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,539 :: 		p[ 3 ] = 0;
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,541 :: 		p[ 4 ] = 0;
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,542 :: 		p[ 5 ] = 0;               // unchanged after preamble timeout
ADDS	R1, R2, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,545 :: 		p[ 6 ] = 0x08;
ADDS	R1, R2, #6
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,546 :: 		p[ 7 ] = 0x08;
ADDS	R1, R2, #7
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,547 :: 		spi_write( 8, p );
MOV	R1, R2
MOVS	R0, #8
BL	_spi_write+0
;driverrf4463pro.c,548 :: 		}
L_end_vRF4463RxStartTest:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRF4463RxStartTest
_vRF4463RxInit:
;driverrf4463pro.c,553 :: 		void vRF4463RxInit( void ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;driverrf4463pro.c,554 :: 		Flag.is_tx = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;driverrf4463pro.c,555 :: 		vRF4463FifoReset();           // fifo_reset();  // Buffer empty
BL	_vRF4463FifoReset+0
;driverrf4463pro.c,556 :: 		vRF4463EnableRxInterrupt();   // enable_rx_interrupt();
BL	_vRF4463EnableRxInterrupt+0
;driverrf4463pro.c,557 :: 		vRF4463ClearInterrupts();      // clr_interrupt();  // Clear interrupt factor
BL	_vRF4463ClearInterrupts+0
;driverrf4463pro.c,559 :: 		if ( ucRF4463Mode == rx_test_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BNE	L_vRF4463RxInit88
;driverrf4463pro.c,560 :: 		vRF4463RxStartTest();      // rx_start_test();
BL	_vRF4463RxStartTest+0
;driverrf4463pro.c,561 :: 		}
IT	AL
BAL	L_vRF4463RxInit89
L_vRF4463RxInit88:
;driverrf4463pro.c,563 :: 		vRF4463RxStart();        // rx_start();    // Enter receiving mode, after receiving data, return to Readymode
BL	_vRF4463RxStart+0
;driverrf4463pro.c,564 :: 		}
L_vRF4463RxInit89:
;driverrf4463pro.c,565 :: 		}
L_end_vRF4463RxInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vRF4463RxInit
_vRF4463TxData:
;driverrf4463pro.c,570 :: 		void vRF4463TxData( void ) {
SUB	SP, SP, #24
STR	LR, [SP, #0]
;driverrf4463pro.c,573 :: 		ucRF4463IRQ = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
STRB	R1, [R0, #0]
;driverrf4463pro.c,575 :: 		Flag.is_tx = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;driverrf4463pro.c,579 :: 		vRF4463FifoReset();            // fifo_reset();  // Buffer empty
BL	_vRF4463FifoReset+0
;driverrf4463pro.c,580 :: 		spi_write_fifo();              // Fill the buffer with data
BL	_spi_write_fifo+0
;driverrf4463pro.c,581 :: 		vRF4463EnableTxInterrupt();    // enable_tx_interrupt();
BL	_vRF4463EnableTxInterrupt+0
;driverrf4463pro.c,582 :: 		vRF4463ClearInterrupts();       // clr_interrupt();  // Clear interrupt factor
BL	_vRF4463ClearInterrupts+0
;driverrf4463pro.c,583 :: 		vRF4463TxStart();              // tx_start();    // Enter launch mode, start launch
BL	_vRF4463TxStart+0
;driverrf4463pro.c,584 :: 		rf_timeout = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_rf_timeout+0)
MOVT	R0, #hi_addr(_rf_timeout+0)
STRH	R1, [R0, #0]
;driverrf4463pro.c,586 :: 		Flag.rf_reach_timeout = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;driverrf4463pro.c,588 :: 		if ( ucRF4463IRQ ) {
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463TxData90
;driverrf4463pro.c,589 :: 		UART1_Write_Text( "[ UART1 ] TX INT\r\n" );
ADD	R11, SP, #4
ADD	R10, R11, #19
MOVW	R12, #lo_addr(?ICS?lstr1_DriverRF4463PROMain+0)
MOVT	R12, #hi_addr(?ICS?lstr1_DriverRF4463PROMain+0)
BL	___CC2DW+0
ADD	R0, SP, #4
BL	_UART1_Write_Text+0
;driverrf4463pro.c,590 :: 		}
L_vRF4463TxData90:
;driverrf4463pro.c,593 :: 		while ( nIRQ ) {     //nIRQ
L_vRF4463TxData91:
MOVW	R0, #lo_addr(GPIOC_IDRbits+0)
MOVT	R0, #hi_addr(GPIOC_IDRbits+0)
_LX	[R0, ByteOffset(GPIOC_IDRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463TxData92
;driverrf4463pro.c,596 :: 		if ( Flag.rf_reach_timeout ) {
MOVW	R1, #lo_addr(_Flag+0)
MOVT	R1, #hi_addr(_Flag+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463TxData93
;driverrf4463pro.c,597 :: 		VRF4463SDNReset();
BL	_VRF4463SDNReset+0
;driverrf4463pro.c,598 :: 		vRF4463Init();        //SI4463_init();  // RF Module initialization
BL	_vRF4463Init+0
;driverrf4463pro.c,599 :: 		break;                // Forced out
IT	AL
BAL	L_vRF4463TxData92
;driverrf4463pro.c,600 :: 		}
L_vRF4463TxData93:
;driverrf4463pro.c,601 :: 		}
IT	AL
BAL	L_vRF4463TxData91
L_vRF4463TxData92:
;driverrf4463pro.c,603 :: 		tx_cnt++;
MOVW	R1, #lo_addr(_tx_cnt+0)
MOVT	R1, #hi_addr(_tx_cnt+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;driverrf4463pro.c,605 :: 		vRF4463RxInit();          // rx_init();                //rf After the transmission is completed, enter the receiving mode
BL	_vRF4463RxInit+0
;driverrf4463pro.c,606 :: 		}
L_end_vRF4463TxData:
LDR	LR, [SP, #0]
ADD	SP, SP, #24
BX	LR
; end of _vRF4463TxData
_vRF4463TxCont:
;driverrf4463pro.c,611 :: 		void vRF4463TxCont( void ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;driverrf4463pro.c,614 :: 		LED_RED = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;driverrf4463pro.c,615 :: 		vRF4463FifoReset();                     //  fifo_reset();  // Buffer empty
BL	_vRF4463FifoReset+0
;driverrf4463pro.c,616 :: 		spi_write_fifo();                       // Fill the buffer with data
BL	_spi_write_fifo+0
;driverrf4463pro.c,617 :: 		vRF4463EnableTxInterrupt();             //  enable_tx_interrupt();
BL	_vRF4463EnableTxInterrupt+0
;driverrf4463pro.c,618 :: 		vRF4463ClearInterrupts();               //  clr_interrupt();  // Clear interrupt factor
BL	_vRF4463ClearInterrupts+0
;driverrf4463pro.c,619 :: 		vRF4463TxStart();                       //  tx_start();    // Enter launch mode, start launch
BL	_vRF4463TxStart+0
;driverrf4463pro.c,620 :: 		rf_timeout = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_rf_timeout+0)
MOVT	R0, #hi_addr(_rf_timeout+0)
STRH	R1, [R0, #0]
;driverrf4463pro.c,621 :: 		Flag.rf_reach_timeout = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;driverrf4463pro.c,623 :: 		ucRF4463IRQ = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
STRB	R1, [R0, #0]
;driverrf4463pro.c,626 :: 		while( nIRQ ) {          //nIRQ ) {
L_vRF4463TxCont94:
MOVW	R0, #lo_addr(GPIOC_IDRbits+0)
MOVT	R0, #hi_addr(GPIOC_IDRbits+0)
_LX	[R0, ByteOffset(GPIOC_IDRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463TxCont95
;driverrf4463pro.c,634 :: 		}
IT	AL
BAL	L_vRF4463TxCont94
L_vRF4463TxCont95:
;driverrf4463pro.c,635 :: 		}
L_end_vRF4463TxCont:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vRF4463TxCont
_rf_init_freq:
;driverrf4463pro.c,640 :: 		void rf_init_freq ( void ) {
SUB	SP, SP, #28
STR	LR, [SP, #0]
;driverrf4463pro.c,646 :: 		ulFrequency = ( ucRF4463Freq3 * 100 ) + ( ucRF4463Freq2 * 10 ) + ucRF4463Freq1;
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
;driverrf4463pro.c,648 :: 		ulFrequency = ( ulFrequency * 10000 );
MOVW	R0, #10000
MUL	R1, R2, R0
MOV	R2, R1
;driverrf4463pro.c,651 :: 		if ( ulFrequency >= 7600000 ) {
MOVW	R0, #63360
MOVT	R0, #115
CMP	R1, R0
IT	CC
BCC	L_rf_init_freq96
;driverrf4463pro.c,652 :: 		ucOUTDIV = 4;
MOVS	R0, #4
STRB	R0, [SP, #4]
;driverrf4463pro.c,653 :: 		ucBAND = 0;
MOVS	R0, #0
STRB	R0, [SP, #6]
;driverrf4463pro.c,654 :: 		ucVCO = 0xFF;
MOVS	R0, #255
STRB	R0, [SP, #5]
;driverrf4463pro.c,655 :: 		}
IT	AL
BAL	L_rf_init_freq97
L_rf_init_freq96:
;driverrf4463pro.c,658 :: 		else if ( ulFrequency >= 5460000 ) {
MOVW	R0, #20512
MOVT	R0, #83
CMP	R2, R0
IT	CC
BCC	L_rf_init_freq98
;driverrf4463pro.c,659 :: 		ucOUTDIV = 6;
MOVS	R0, #6
STRB	R0, [SP, #4]
;driverrf4463pro.c,660 :: 		ucBAND   = 1;
MOVS	R0, #1
STRB	R0, [SP, #6]
;driverrf4463pro.c,661 :: 		ucVCO    = 0xFE;
MOVS	R0, #254
STRB	R0, [SP, #5]
;driverrf4463pro.c,662 :: 		}
IT	AL
BAL	L_rf_init_freq99
L_rf_init_freq98:
;driverrf4463pro.c,665 :: 		else if ( ulFrequency >= 3850000 ) {
MOVW	R0, #48912
MOVT	R0, #58
CMP	R2, R0
IT	CC
BCC	L_rf_init_freq100
;driverrf4463pro.c,666 :: 		ucOUTDIV = 8;
MOVS	R0, #8
STRB	R0, [SP, #4]
;driverrf4463pro.c,667 :: 		ucBAND   = 2;
MOVS	R0, #2
STRB	R0, [SP, #6]
;driverrf4463pro.c,668 :: 		ucVCO    = 0xFE;
MOVS	R0, #254
STRB	R0, [SP, #5]
;driverrf4463pro.c,669 :: 		}
IT	AL
BAL	L_rf_init_freq101
L_rf_init_freq100:
;driverrf4463pro.c,672 :: 		else if ( ulFrequency >= 2730000 ) {
MOVW	R0, #43024
MOVT	R0, #41
CMP	R2, R0
IT	CC
BCC	L_rf_init_freq102
;driverrf4463pro.c,673 :: 		ucOUTDIV = 12;
MOVS	R0, #12
STRB	R0, [SP, #4]
;driverrf4463pro.c,674 :: 		ucBAND   = 3;
MOVS	R0, #3
STRB	R0, [SP, #6]
;driverrf4463pro.c,675 :: 		ucVCO    = 0xFD;
MOVS	R0, #253
STRB	R0, [SP, #5]
;driverrf4463pro.c,676 :: 		}
IT	AL
BAL	L_rf_init_freq103
L_rf_init_freq102:
;driverrf4463pro.c,679 :: 		else if ( ulFrequency >= 1940000 ) {
MOVW	R0, #39456
MOVT	R0, #29
CMP	R2, R0
IT	CC
BCC	L_rf_init_freq104
;driverrf4463pro.c,680 :: 		ucOUTDIV = 16;
MOVS	R0, #16
STRB	R0, [SP, #4]
;driverrf4463pro.c,681 :: 		ucBAND   = 4;
MOVS	R0, #4
STRB	R0, [SP, #6]
;driverrf4463pro.c,682 :: 		ucVCO    = 0xFC;
MOVS	R0, #252
STRB	R0, [SP, #5]
;driverrf4463pro.c,683 :: 		}
IT	AL
BAL	L_rf_init_freq105
L_rf_init_freq104:
;driverrf4463pro.c,687 :: 		ucOUTDIV = 24;
MOVS	R0, #24
STRB	R0, [SP, #4]
;driverrf4463pro.c,688 :: 		ucBAND   = 5;
MOVS	R0, #5
STRB	R0, [SP, #6]
;driverrf4463pro.c,689 :: 		ucVCO    = 0xFA;
MOVS	R0, #250
STRB	R0, [SP, #5]
;driverrf4463pro.c,690 :: 		}
L_rf_init_freq105:
L_rf_init_freq103:
L_rf_init_freq101:
L_rf_init_freq99:
L_rf_init_freq97:
;driverrf4463pro.c,692 :: 		ucDIV = ucOUTDIV / 2;
LDRB	R0, [SP, #4]
LSRS	R0, R0, #1
UXTB	R0, R0
;driverrf4463pro.c,694 :: 		ulData = ( ulFrequency * ucDIV ) / 3;          // ucDIV = 88.5 = 88   //// UCdiv = 2
MUL	R1, R2, R0
; ulFrequency end address is: 8 (R2)
MOVS	R0, #3
UDIV	R2, R1, R0
;driverrf4463pro.c,695 :: 		ucINTE = ( ulData / 100000) - 1;               // ulData = 6 000 000  //// ULdATA = 9 000 000
MOVW	R0, #34464
MOVT	R0, #1
UDIV	R0, R2, R0
SUBS	R0, R0, #1
; ucINTE start address is: 24 (R6)
UXTB	R6, R0
;driverrf4463pro.c,696 :: 		ulFRAC = ( ulData - ( ucINTE + 1 ) * 100000 ) * 16384 / 3125;         // ulFRAC = 15 728 640
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
;driverrf4463pro.c,697 :: 		ulFRAC = ulFRAC + 0x80000;
ADD	R0, R0, #524288
;driverrf4463pro.c,699 :: 		ucFRAC_0 = ulFRAC;
; ucFRAC_0 start address is: 28 (R7)
UXTB	R7, R0
;driverrf4463pro.c,700 :: 		ulFRAC >>= 8;
LSRS	R0, R0, #8
;driverrf4463pro.c,701 :: 		ucFRAC_1 = ulFRAC;
; ucFRAC_1 start address is: 32 (R8)
UXTB	R8, R0
;driverrf4463pro.c,702 :: 		ulFRAC >>= 8;
LSRS	R0, R0, #8
;driverrf4463pro.c,703 :: 		ucFRAC_2 = ulFRAC;
; ucFRAC_2 start address is: 36 (R9)
UXTB	R9, R0
;driverrf4463pro.c,707 :: 		app_command_buf[ 0 ] = 0x11;           // SET property    MODEM_CLKGEN_BAND
ADD	R2, SP, #7
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,708 :: 		app_command_buf[ 1 ] = 0x20;           // Group  // 0x2051
ADDS	R1, R2, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,709 :: 		app_command_buf[ 2 ] = 0x01;           // Num Arguments // Total 1 Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,710 :: 		app_command_buf[ 3 ] = 0x51;           // Number  // 0x2051
ADDS	R1, R2, #3
MOVS	R0, #81
STRB	R0, [R1, #0]
;driverrf4463pro.c,711 :: 		app_command_buf[ 4 ] = 0x08 | ucBAND;  // Argumento  //  high performance mode , clk outpu = osc /4
ADDS	R1, R2, #4
LDRB	R0, [SP, #6]
ORR	R0, R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,712 :: 		spi_write( 5, app_command_buf );
MOV	R1, R2
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,714 :: 		app_command_buf[ 0 ]  = 0x11;
ADD	R2, SP, #7
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,715 :: 		app_command_buf[ 1 ]  = 0x40;    // 0x4000         FREQ_CONTROL_INTE
ADDS	R1, R2, #1
MOVS	R0, #64
STRB	R0, [R1, #0]
;driverrf4463pro.c,716 :: 		app_command_buf[ 2 ]  = 0x08;    // Total 8 Parameters
ADDS	R1, R2, #2
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,717 :: 		app_command_buf[ 3 ]  = 0x00;   // 0x4000
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,718 :: 		app_command_buf[ 4 ]  = ucINTE;   //  default value
ADDS	R0, R2, #4
STRB	R6, [R0, #0]
; ucINTE end address is: 24 (R6)
;driverrf4463pro.c,719 :: 		app_command_buf[ 5 ]  = ucFRAC_2;   //  defaul value
ADDS	R0, R2, #5
STRB	R9, [R0, #0]
; ucFRAC_2 end address is: 36 (R9)
;driverrf4463pro.c,720 :: 		app_command_buf[ 6 ]  = ucFRAC_1;   //  default value
ADDS	R0, R2, #6
STRB	R8, [R0, #0]
; ucFRAC_1 end address is: 32 (R8)
;driverrf4463pro.c,721 :: 		app_command_buf[ 7 ]  = ucFRAC_0;   // frac ,from WDS
ADDS	R0, R2, #7
STRB	R7, [R0, #0]
; ucFRAC_0 end address is: 28 (R7)
;driverrf4463pro.c,724 :: 		if ( ulRF4463Step == 250 ) {
MOVW	R0, #lo_addr(_ulRF4463Step+0)
MOVT	R0, #hi_addr(_ulRF4463Step+0)
LDR	R0, [R0, #0]
CMP	R0, #250
IT	NE
BNE	L_rf_init_freq106
;driverrf4463pro.c,725 :: 		app_command_buf[ 8 ]  = step_250K_step1;   // channel step1  from wds  // al parecer aqu? esta el ancho del canal
ADD	R2, SP, #7
ADDW	R1, R2, #8
MOVS	R0, #34
STRB	R0, [R1, #0]
;driverrf4463pro.c,726 :: 		app_command_buf[ 9 ]  = step_250K_step0;   // channel step0  from wds
ADDW	R1, R2, #9
MOVS	R0, #34
STRB	R0, [R1, #0]
;driverrf4463pro.c,727 :: 		}
IT	AL
BAL	L_rf_init_freq107
L_rf_init_freq106:
;driverrf4463pro.c,728 :: 		else if ( ulRF4463Step == 500 ) {
MOVW	R0, #lo_addr(_ulRF4463Step+0)
MOVT	R0, #hi_addr(_ulRF4463Step+0)
LDR	R0, [R0, #0]
CMP	R0, #500
IT	NE
BNE	L_rf_init_freq108
;driverrf4463pro.c,729 :: 		app_command_buf[ 8 ]  = step_500K_step1;   // channel step1  from wds  // al parecer aqu? esta el ancho del canal
ADD	R2, SP, #7
ADDW	R1, R2, #8
MOVS	R0, #68
STRB	R0, [R1, #0]
;driverrf4463pro.c,730 :: 		app_command_buf[ 9 ]  = step_500K_step0;   // channel step0  from wds
ADDW	R1, R2, #9
MOVS	R0, #68
STRB	R0, [R1, #0]
;driverrf4463pro.c,731 :: 		}
L_rf_init_freq108:
L_rf_init_freq107:
;driverrf4463pro.c,733 :: 		app_command_buf[ 10 ] = 0x20;  //  from wds Without this Values
ADD	R2, SP, #7
ADDW	R1, R2, #10
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,734 :: 		app_command_buf[ 11 ] = ucVCO;    // from wds Without this Values
ADDW	R1, R2, #11
LDRB	R0, [SP, #5]
STRB	R0, [R1, #0]
;driverrf4463pro.c,748 :: 		spi_write( 12, app_command_buf );
MOV	R1, R2
MOVS	R0, #12
BL	_spi_write+0
;driverrf4463pro.c,749 :: 		}
L_end_rf_init_freq:
LDR	LR, [SP, #0]
ADD	SP, SP, #28
BX	LR
; end of _rf_init_freq
_ucRf4463SPIByte:
;driverrf4463pro.c,769 :: 		unsigned char ucRf4463SPIByte( unsigned char ucData ) {
; ucData start address is: 0 (R0)
SUB	SP, SP, #4
; ucData end address is: 0 (R0)
; ucData start address is: 0 (R0)
;driverrf4463pro.c,772 :: 		ucSPI2ByteReceived = 0;
MOVS	R2, #0
MOVW	R1, #lo_addr(_ucSPI2ByteReceived+0)
MOVT	R1, #hi_addr(_ucSPI2ByteReceived+0)
STRB	R2, [R1, #0]
;driverrf4463pro.c,774 :: 		SPI2_DR = ucData;
MOVW	R1, #lo_addr(SPI2_DR+0)
MOVT	R1, #hi_addr(SPI2_DR+0)
STR	R0, [R1, #0]
; ucData end address is: 0 (R0)
;driverrf4463pro.c,778 :: 		while ( SPI2_SRbits.BSY );                // espera a que el buffer este vacio
L_ucRf4463SPIByte109:
MOVW	R1, #lo_addr(SPI2_SRbits+0)
MOVT	R1, #hi_addr(SPI2_SRbits+0)
_LX	[R1, ByteOffset(SPI2_SRbits+0)]
CMP	R1, #0
IT	EQ
BEQ	L_ucRf4463SPIByte110
IT	AL
BAL	L_ucRf4463SPIByte109
L_ucRf4463SPIByte110:
;driverrf4463pro.c,780 :: 		return ( ucSPI2ByteReceived );
MOVW	R1, #lo_addr(_ucSPI2ByteReceived+0)
MOVT	R1, #hi_addr(_ucSPI2ByteReceived+0)
LDRB	R0, [R1, #0]
;driverrf4463pro.c,816 :: 		}
L_end_ucRf4463SPIByte:
ADD	SP, SP, #4
BX	LR
; end of _ucRf4463SPIByte
_spi_write:
;driverrf4463pro.c,821 :: 		void spi_write( unsigned char tx_length, unsigned char *p ) {
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
;driverrf4463pro.c,824 :: 		i = 0;
; i start address is: 0 (R0)
MOVS	R0, #0
; tx_length end address is: 4 (R1)
; p end address is: 8 (R2)
; i end address is: 0 (R0)
UXTB	R5, R1
MOV	R4, R2
;driverrf4463pro.c,825 :: 		while ( i != 0xFF ) {
L_spi_write111:
; i start address is: 0 (R0)
; p start address is: 16 (R4)
; tx_length start address is: 20 (R5)
CMP	R0, #255
IT	EQ
BEQ	L_spi_write112
; i end address is: 0 (R0)
;driverrf4463pro.c,826 :: 		i = check_cts();
BL	_check_cts+0
; i start address is: 0 (R0)
;driverrf4463pro.c,827 :: 		}
; i end address is: 0 (R0)
IT	AL
BAL	L_spi_write111
L_spi_write112:
;driverrf4463pro.c,829 :: 		nSEL = 0;                              // habilita escritura
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,831 :: 		for ( i = 0; i < tx_length; i++ ) {
; i start address is: 0 (R0)
MOVS	R0, #0
; tx_length end address is: 20 (R5)
; i end address is: 0 (R0)
UXTB	R3, R5
UXTB	R5, R0
L_spi_write113:
; i start address is: 20 (R5)
; tx_length start address is: 12 (R3)
; p start address is: 16 (R4)
; p end address is: 16 (R4)
CMP	R5, R3
IT	CS
BCS	L_spi_write114
; p end address is: 16 (R4)
;driverrf4463pro.c,832 :: 		j = *( p + i );
; p start address is: 16 (R4)
ADDS	R2, R4, R5
;driverrf4463pro.c,833 :: 		ucRf4463SPIByte( j );
LDRB	R0, [R2, #0]
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,831 :: 		for ( i = 0; i < tx_length; i++ ) {
ADDS	R5, R5, #1
UXTB	R5, R5
;driverrf4463pro.c,834 :: 		}
; tx_length end address is: 12 (R3)
; p end address is: 16 (R4)
; i end address is: 20 (R5)
IT	AL
BAL	L_spi_write113
L_spi_write114:
;driverrf4463pro.c,836 :: 		nSEL = 1;                              // desabilita escritura
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,837 :: 		}
L_end_spi_write:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _spi_write
_check_cts:
;driverrf4463pro.c,842 :: 		unsigned char check_cts( void ) {           // This Command follows the Command and reads the response
SUB	SP, SP, #4
STR	LR, [SP, #0]
;driverrf4463pro.c,845 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,846 :: 		nSEL = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,847 :: 		ucRf4463SPIByte( 0x44 );
MOVS	R0, #68
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,848 :: 		i = ucRf4463SPIByte( 0 );
MOVS	R0, #0
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,849 :: 		nSEL = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODRbits+0)
MOVT	R1, #hi_addr(GPIOB_ODRbits+0)
_SX	[R1, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,850 :: 		return ( i );
;driverrf4463pro.c,851 :: 		}
L_end_check_cts:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _check_cts
_spi_read:
;driverrf4463pro.c,856 :: 		void spi_read( unsigned char data_length, unsigned char api_command ) {
; api_command start address is: 4 (R1)
; data_length start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
; api_command end address is: 4 (R1)
; data_length end address is: 0 (R0)
; data_length start address is: 0 (R0)
; api_command start address is: 4 (R1)
;driverrf4463pro.c,860 :: 		p[ 0 ] = api_command;
ADD	R2, SP, #4
STRB	R1, [R2, #0]
; api_command end address is: 4 (R1)
;driverrf4463pro.c,861 :: 		i = 0;
; i start address is: 4 (R1)
MOVS	R1, #0
; data_length end address is: 0 (R0)
; i end address is: 4 (R1)
UXTB	R6, R0
UXTB	R0, R1
;driverrf4463pro.c,862 :: 		while ( i != 0xFF ) {
L_spi_read116:
; i start address is: 0 (R0)
; data_length start address is: 24 (R6)
CMP	R0, #255
IT	EQ
BEQ	L_spi_read117
; i end address is: 0 (R0)
;driverrf4463pro.c,863 :: 		i = check_cts();                // Check if you can send Command
BL	_check_cts+0
; i start address is: 0 (R0)
;driverrf4463pro.c,864 :: 		}
; i end address is: 0 (R0)
IT	AL
BAL	L_spi_read116
L_spi_read117:
;driverrf4463pro.c,866 :: 		spi_write( 1, p );    // Send Command
ADD	R2, SP, #4
MOV	R1, R2
MOVS	R0, #1
BL	_spi_write+0
;driverrf4463pro.c,868 :: 		i = 0;
; i start address is: 0 (R0)
MOVS	R0, #0
; data_length end address is: 24 (R6)
; i end address is: 0 (R0)
UXTB	R4, R6
;driverrf4463pro.c,869 :: 		while ( i != 0xFF ) {
L_spi_read118:
; i start address is: 0 (R0)
; data_length start address is: 16 (R4)
CMP	R0, #255
IT	EQ
BEQ	L_spi_read119
; i end address is: 0 (R0)
;driverrf4463pro.c,870 :: 		i = check_cts();        //Check whether the data can be read
BL	_check_cts+0
; i start address is: 0 (R0)
;driverrf4463pro.c,871 :: 		}
; i end address is: 0 (R0)
IT	AL
BAL	L_spi_read118
L_spi_read119:
;driverrf4463pro.c,873 :: 		nSEL = 1;
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,874 :: 		nSEL = 0;
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,875 :: 		ucRf4463SPIByte( 0x44 );
MOVS	R0, #68
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,876 :: 		for ( i = 0; i < data_length; i++ ) {        // Read data
; i start address is: 0 (R0)
MOVS	R0, #0
; data_length end address is: 16 (R4)
; i end address is: 0 (R0)
UXTB	R3, R4
UXTB	R4, R0
L_spi_read120:
; i start address is: 16 (R4)
; data_length start address is: 12 (R3)
CMP	R4, R3
IT	CS
BCS	L_spi_read121
;driverrf4463pro.c,877 :: 		spi_read_buf[ i ] = ucRf4463SPIByte( 0x00 );             // 0x00
MOVW	R2, #lo_addr(_spi_read_buf+0)
MOVT	R2, #hi_addr(_spi_read_buf+0)
ADDS	R2, R2, R4
STR	R2, [SP, #8]
MOVS	R0, #0
BL	_ucRf4463SPIByte+0
LDR	R2, [SP, #8]
STRB	R0, [R2, #0]
;driverrf4463pro.c,878 :: 		Delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_spi_read123:
SUBS	R7, R7, #1
BNE	L_spi_read123
NOP
NOP
NOP
;driverrf4463pro.c,876 :: 		for ( i = 0; i < data_length; i++ ) {        // Read data
ADDS	R4, R4, #1
UXTB	R4, R4
;driverrf4463pro.c,879 :: 		}
; data_length end address is: 12 (R3)
; i end address is: 16 (R4)
IT	AL
BAL	L_spi_read120
L_spi_read121:
;driverrf4463pro.c,880 :: 		nSEL = 1;
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,881 :: 		}
L_end_spi_read:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _spi_read
_spi_fast_read:
;driverrf4463pro.c,886 :: 		void spi_fast_read( unsigned char api_command ) {
; api_command start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
; api_command end address is: 0 (R0)
; api_command start address is: 0 (R0)
;driverrf4463pro.c,889 :: 		p[0] = api_command;
ADD	R1, SP, #4
STRB	R0, [R1, #0]
;driverrf4463pro.c,890 :: 		i = 0;
; i start address is: 4 (R1)
MOVS	R1, #0
; api_command end address is: 0 (R0)
; i end address is: 4 (R1)
UXTB	R3, R0
;driverrf4463pro.c,891 :: 		while ( i != 0xFF ) {
L_spi_fast_read125:
; i start address is: 4 (R1)
; api_command start address is: 12 (R3)
CMP	R1, #255
IT	EQ
BEQ	L_spi_fast_read126
; i end address is: 4 (R1)
;driverrf4463pro.c,892 :: 		i = check_cts();                // Check if you can send Command
BL	_check_cts+0
; i start address is: 4 (R1)
UXTB	R1, R0
;driverrf4463pro.c,893 :: 		}
; i end address is: 4 (R1)
IT	AL
BAL	L_spi_fast_read125
L_spi_fast_read126:
;driverrf4463pro.c,895 :: 		nSEL = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODRbits+0)
MOVT	R1, #hi_addr(GPIOB_ODRbits+0)
_SX	[R1, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,896 :: 		nSEL = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODRbits+0)
MOVT	R1, #hi_addr(GPIOB_ODRbits+0)
_SX	[R1, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,897 :: 		ucRf4463SPIByte( api_command );    // Send Command
UXTB	R0, R3
; api_command end address is: 12 (R3)
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,898 :: 		for ( i = 0; i < 4; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #0
; i end address is: 12 (R3)
L_spi_fast_read127:
; i start address is: 12 (R3)
CMP	R3, #4
IT	CS
BCS	L_spi_fast_read128
;driverrf4463pro.c,899 :: 		spi_read_buf[ i ] = ucRf4463SPIByte( 0xFF );   // Read out all the 4 registers Value of
MOVW	R1, #lo_addr(_spi_read_buf+0)
MOVT	R1, #hi_addr(_spi_read_buf+0)
ADDS	R1, R1, R3
STR	R1, [SP, #8]
MOVS	R0, #255
BL	_ucRf4463SPIByte+0
LDR	R1, [SP, #8]
STRB	R0, [R1, #0]
;driverrf4463pro.c,898 :: 		for ( i = 0; i < 4; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,900 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_spi_fast_read127
L_spi_fast_read128:
;driverrf4463pro.c,901 :: 		nSEL = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODRbits+0)
MOVT	R1, #hi_addr(GPIOB_ODRbits+0)
_SX	[R1, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,902 :: 		}
L_end_spi_fast_read:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _spi_fast_read
_spi_write_fifo:
;driverrf4463pro.c,907 :: 		void spi_write_fifo( void ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;driverrf4463pro.c,910 :: 		i = 0;
; i start address is: 0 (R0)
MOVS	R0, #0
; i end address is: 0 (R0)
;driverrf4463pro.c,911 :: 		while ( i != 0xFF ) {
L_spi_write_fifo130:
; i start address is: 0 (R0)
CMP	R0, #255
IT	EQ
BEQ	L_spi_write_fifo131
; i end address is: 0 (R0)
;driverrf4463pro.c,912 :: 		i = check_cts();                // Check if you can send Command
BL	_check_cts+0
; i start address is: 0 (R0)
;driverrf4463pro.c,913 :: 		}
; i end address is: 0 (R0)
IT	AL
BAL	L_spi_write_fifo130
L_spi_write_fifo131:
;driverrf4463pro.c,915 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,916 :: 		nSEL = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,917 :: 		ucRf4463SPIByte( WRITE_TX_FIFO );
MOVS	R0, #102
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,919 :: 		if ( ucRF4463Mode == tx_test_mode) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_spi_write_fifo132
;driverrf4463pro.c,920 :: 		for ( i = 0; i < payload_length; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #0
; i end address is: 12 (R3)
L_spi_write_fifo133:
; i start address is: 12 (R3)
CMP	R3, #66
IT	CS
BCS	L_spi_write_fifo134
;driverrf4463pro.c,921 :: 		ucRf4463SPIByte( tx_test_aa_data[ i ] );   // Send 10 test data
MOVW	R0, #lo_addr(_tx_test_aa_data+0)
MOVT	R0, #hi_addr(_tx_test_aa_data+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,920 :: 		for ( i = 0; i < payload_length; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,922 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_spi_write_fifo133
L_spi_write_fifo134:
;driverrf4463pro.c,923 :: 		}
IT	AL
BAL	L_spi_write_fifo136
L_spi_write_fifo132:
;driverrf4463pro.c,925 :: 		for ( i = 0; i < payload_length; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #0
; i end address is: 12 (R3)
L_spi_write_fifo137:
; i start address is: 12 (R3)
CMP	R3, #66
IT	CS
BCS	L_spi_write_fifo138
;driverrf4463pro.c,926 :: 		ucRf4463SPIByte( ucRF4463TXdata[ i ] );
MOVW	R0, #lo_addr(_ucRF4463TXdata+0)
MOVT	R0, #hi_addr(_ucRF4463TXdata+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,925 :: 		for ( i = 0; i < payload_length; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,927 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_spi_write_fifo137
L_spi_write_fifo138:
;driverrf4463pro.c,928 :: 		}
L_spi_write_fifo136:
;driverrf4463pro.c,929 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,930 :: 		}
L_end_spi_write_fifo:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _spi_write_fifo
_spi_read_fifo:
;driverrf4463pro.c,935 :: 		void spi_read_fifo( void ) {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;driverrf4463pro.c,938 :: 		i = 0;
; i start address is: 0 (R0)
MOVS	R0, #0
; i end address is: 0 (R0)
;driverrf4463pro.c,939 :: 		while ( i != 0xFF ) {
L_spi_read_fifo140:
; i start address is: 0 (R0)
CMP	R0, #255
IT	EQ
BEQ	L_spi_read_fifo141
; i end address is: 0 (R0)
;driverrf4463pro.c,940 :: 		i = check_cts();                   // Check if you can send Command
BL	_check_cts+0
; i start address is: 0 (R0)
;driverrf4463pro.c,941 :: 		}
; i end address is: 0 (R0)
IT	AL
BAL	L_spi_read_fifo140
L_spi_read_fifo141:
;driverrf4463pro.c,943 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,944 :: 		nSEL = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,945 :: 		ucRf4463SPIByte( READ_RX_FIFO );
MOVS	R0, #119
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,946 :: 		for ( i = 0; i < payload_length; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #0
; i end address is: 12 (R3)
L_spi_read_fifo142:
; i start address is: 12 (R3)
CMP	R3, #66
IT	CS
BCS	L_spi_read_fifo143
;driverrf4463pro.c,947 :: 		rx_buf[ i ] = ucRf4463SPIByte( 0xFF );      // Receive 10 test data
MOVW	R0, #lo_addr(_rx_buf+0)
MOVT	R0, #hi_addr(_rx_buf+0)
ADDS	R0, R0, R3
STR	R0, [SP, #4]
MOVS	R0, #255
BL	_ucRf4463SPIByte+0
LDR	R1, [SP, #4]
STRB	R0, [R1, #0]
;driverrf4463pro.c,946 :: 		for ( i = 0; i < payload_length; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,948 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_spi_read_fifo142
L_spi_read_fifo143:
;driverrf4463pro.c,949 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,950 :: 		}
L_end_spi_read_fifo:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _spi_read_fifo
_VRF4463SDNReset:
;driverrf4463pro.c,955 :: 		void VRF4463SDNReset( void ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;driverrf4463pro.c,958 :: 		SDN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,959 :: 		Delay_ms( 6 );        // RF Module reset  DELAY
MOVW	R7, #6463
MOVT	R7, #1
NOP
NOP
L_VRF4463SDNReset145:
SUBS	R7, R7, #1
BNE	L_VRF4463SDNReset145
NOP
NOP
NOP
;driverrf4463pro.c,960 :: 		SDN = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,961 :: 		Delay_ms( 10 );       // Delay 10ms for RF module to enter working state
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_VRF4463SDNReset147:
SUBS	R7, R7, #1
BNE	L_VRF4463SDNReset147
NOP
NOP
NOP
;driverrf4463pro.c,963 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,964 :: 		nSEL = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,965 :: 		for ( i = 0; i < 7; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #0
; i end address is: 12 (R3)
L_VRF4463SDNReset149:
; i start address is: 12 (R3)
CMP	R3, #7
IT	CS
BCS	L_VRF4463SDNReset150
;driverrf4463pro.c,966 :: 		ucRf4463SPIByte( RF_POWER_UP_data[ i ] );   // send power up Command
MOVW	R0, #lo_addr(_RF_POWER_UP_data+0)
MOVT	R0, #hi_addr(_RF_POWER_UP_data+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,965 :: 		for ( i = 0; i < 7; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,967 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_VRF4463SDNReset149
L_VRF4463SDNReset150:
;driverrf4463pro.c,968 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,971 :: 		}
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
BLS	L_ucASCIIToByte152
;utils.c,47 :: 		ucMSBNibble -= 7;
MOVW	R2, #lo_addr(_ucMSBNibble+0)
MOVT	R2, #hi_addr(_ucMSBNibble+0)
LDRB	R1, [R2, #0]
SUBS	R1, R1, #7
STRB	R1, [R2, #0]
;utils.c,48 :: 		}
L_ucASCIIToByte152:
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
BLS	L_ucASCIIToByte153
;utils.c,52 :: 		ucLSBNibble -= 7;
MOVW	R2, #lo_addr(_ucLSBNibble+0)
MOVT	R2, #hi_addr(_ucLSBNibble+0)
LDRB	R1, [R2, #0]
SUBS	R1, R1, #7
STRB	R1, [R2, #0]
;utils.c,53 :: 		}
L_ucASCIIToByte153:
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
L_vASCIIToHex154:
; ucASCIICounter start address is: 24 (R6)
; pcHexConvertBuffer start address is: 8 (R2)
; ucConversionLength start address is: 0 (R0)
; pcASCIIConvertBuffer start address is: 4 (R1)
; pcASCIIConvertBuffer end address is: 4 (R1)
; pcHexConvertBuffer start address is: 8 (R2)
; pcHexConvertBuffer end address is: 8 (R2)
CMP	R6, R0
IT	CS
BCS	L_vASCIIToHex155
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
BLS	L_vASCIIToHex157
;utils.c,70 :: 		ucMSBNibble -= 7;
MOVW	R4, #lo_addr(_ucMSBNibble+0)
MOVT	R4, #hi_addr(_ucMSBNibble+0)
LDRB	R3, [R4, #0]
SUBS	R3, R3, #7
STRB	R3, [R4, #0]
;utils.c,71 :: 		}
L_vASCIIToHex157:
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
BLS	L_vASCIIToHex158
;utils.c,75 :: 		ucLSBNibble -= 7;
MOVW	R4, #lo_addr(_ucLSBNibble+0)
MOVT	R4, #hi_addr(_ucLSBNibble+0)
LDRB	R3, [R4, #0]
SUBS	R3, R3, #7
STRB	R3, [R4, #0]
;utils.c,76 :: 		}
L_vASCIIToHex158:
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
BAL	L_vASCIIToHex154
L_vASCIIToHex155:
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
L_vHexToASCII159:
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
BCS	L_vHexToASCII160
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
BAL	L_vHexToASCII159
L_vHexToASCII160:
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
L_vBufferSetToZero162:
; usPosition start address is: 16 (R4)
; pcBufferToClean start address is: 4 (R1)
; uslength start address is: 0 (R0)
; pcBufferToClean start address is: 4 (R1)
; pcBufferToClean end address is: 4 (R1)
CMP	R4, R0
IT	CS
BCS	L_vBufferSetToZero163
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
BAL	L_vBufferSetToZero162
L_vBufferSetToZero163:
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
L_vBufferSetTo255165:
; usPosition start address is: 16 (R4)
; pcBufferToClean start address is: 4 (R1)
; uslength start address is: 0 (R0)
; pcBufferToClean start address is: 4 (R1)
; pcBufferToClean end address is: 4 (R1)
CMP	R4, R0
IT	CS
BCS	L_vBufferSetTo255166
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
BAL	L_vBufferSetTo255165
L_vBufferSetTo255166:
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
L_vBufferSetToValue168:
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
BCS	L_vBufferSetToValue169
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
BAL	L_vBufferSetToValue168
L_vBufferSetToValue169:
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
L_vSerializeUUID171:
; ucCounter start address is: 20 (R5)
; pcTextConvertBuffer start address is: 4 (R1)
; pcHexConvertBuffer start address is: 0 (R0)
; pcHexConvertBuffer start address is: 0 (R0)
; pcHexConvertBuffer end address is: 0 (R0)
; pcTextConvertBuffer start address is: 4 (R1)
; pcTextConvertBuffer end address is: 4 (R1)
CMP	R5, #12
IT	CS
BCS	L_vSerializeUUID172
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
BAL	L_vSerializeUUID171
L_vSerializeUUID172:
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
L_vSerializeMACAddress174:
; usCounter start address is: 4 (R1)
; pcTextConvertBuffer start address is: 0 (R0)
CMP	R1, #6
IT	CS
BCS	L_vSerializeMACAddress175
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
BEQ	L_vSerializeMACAddress177
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
L_vSerializeMACAddress177:
;utils.c,148 :: 		for( usCounter = 0; usCounter < 6; usCounter++ ){
ADDS	R1, R1, #1
UXTH	R1, R1
;utils.c,154 :: 		}
; usCounter end address is: 4 (R1)
IT	AL
BAL	L_vSerializeMACAddress174
L_vSerializeMACAddress175:
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
L_vSerializeIPAddress178:
; ucCounter start address is: 28 (R7)
; pcHexConvertBuffer start address is: 24 (R6)
; pcHexConvertBuffer end address is: 24 (R6)
; pcTextConvertBuffer start address is: 32 (R8)
; pcTextConvertBuffer end address is: 32 (R8)
CMP	R7, #4
IT	CS
BCS	L_vSerializeIPAddress179
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
BEQ	L_vSerializeIPAddress181
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
L_vSerializeIPAddress181:
;utils.c,167 :: 		for( ucCounter = 0; ucCounter < 4; ucCounter++ ){
ADDS	R7, R7, #1
UXTB	R7, R7
;utils.c,176 :: 		}
; pcHexConvertBuffer end address is: 24 (R6)
; pcTextConvertBuffer end address is: 32 (R8)
; ucCounter end address is: 28 (R7)
IT	AL
BAL	L_vSerializeIPAddress178
L_vSerializeIPAddress179:
;utils.c,177 :: 		}
L_end_vSerializeIPAddress:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _vSerializeIPAddress
_DMA1Ch1_interrupt:
;uarthandler.c,88 :: 		void DMA1Ch1_interrupt() iv IVT_INT_DMA1_Channel1 ics ICS_AUTO {
;uarthandler.c,90 :: 		if ( DMA1_ISRbits.TEIF1 ) {         // TRANSFER ERROR INTERRUPT FLAG
MOVW	R0, #lo_addr(DMA1_ISRbits+0)
MOVT	R0, #hi_addr(DMA1_ISRbits+0)
_LX	[R0, ByteOffset(DMA1_ISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA1Ch1_interrupt182
;uarthandler.c,91 :: 		DMA1_IFCRbits .CTEIF1 = 1;       // limpia el flag de error
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA1_IFCRbits+0)
MOVT	R0, #hi_addr(DMA1_IFCRbits+0)
_SX	[R0, ByteOffset(DMA1_IFCRbits+0)]
;uarthandler.c,93 :: 		}
IT	AL
BAL	L_DMA1Ch1_interrupt183
L_DMA1Ch1_interrupt182:
;uarthandler.c,94 :: 		else if ( DMA1_ISRbits.HTIF1 ) {
MOVW	R0, #lo_addr(DMA1_ISRbits+0)
MOVT	R0, #hi_addr(DMA1_ISRbits+0)
_LX	[R0, ByteOffset(DMA1_ISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA1Ch1_interrupt184
;uarthandler.c,95 :: 		DMA1_IFCRbits.CHTIF1 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA1_IFCRbits+0)
MOVT	R0, #hi_addr(DMA1_IFCRbits+0)
_SX	[R0, ByteOffset(DMA1_IFCRbits+0)]
;uarthandler.c,96 :: 		}
IT	AL
BAL	L_DMA1Ch1_interrupt185
L_DMA1Ch1_interrupt184:
;uarthandler.c,97 :: 		else if ( DMA1_ISRbits.TCIF1 ) {     // TRANSFER COMPLETE INTERRUPT FLAG = envio el frame completo
MOVW	R0, #lo_addr(DMA1_ISRbits+0)
MOVT	R0, #hi_addr(DMA1_ISRbits+0)
_LX	[R0, ByteOffset(DMA1_ISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA1Ch1_interrupt186
;uarthandler.c,98 :: 		DMA1_IFCRbits.CTCIF1 = 1;       // limpia TODOS LOS FLAGS DE DMA2 CANAL 2
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA1_IFCRbits+0)
MOVT	R0, #hi_addr(DMA1_IFCRbits+0)
_SX	[R0, ByteOffset(DMA1_IFCRbits+0)]
;uarthandler.c,99 :: 		DMA1_CCR1bits.EN = 0;            // EXPERIMENTAL PARA CAMBIAR EL VALOR DEL CONTADOR
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA1_CCR1bits+0)
MOVT	R0, #hi_addr(DMA1_CCR1bits+0)
_SX	[R0, ByteOffset(DMA1_CCR1bits+0)]
;uarthandler.c,101 :: 		}
L_DMA1Ch1_interrupt186:
L_DMA1Ch1_interrupt185:
L_DMA1Ch1_interrupt183:
;uarthandler.c,102 :: 		}
L_end_DMA1Ch1_interrupt:
BX	LR
; end of _DMA1Ch1_interrupt
_DMA1Ch2_interrupt:
;uarthandler.c,104 :: 		void DMA1Ch2_interrupt() iv IVT_INT_DMA1_Channel2 ics ICS_AUTO {
;uarthandler.c,106 :: 		if ( DMA1_ISRbits.TEIF2 ) {         // TRANSFER ERROR INTERRUPT FLAG
MOVW	R0, #lo_addr(DMA1_ISRbits+0)
MOVT	R0, #hi_addr(DMA1_ISRbits+0)
_LX	[R0, ByteOffset(DMA1_ISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA1Ch2_interrupt187
;uarthandler.c,107 :: 		DMA1_IFCRbits .CTEIF2 = 1;       // limpia el flag de error
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA1_IFCRbits+0)
MOVT	R0, #hi_addr(DMA1_IFCRbits+0)
_SX	[R0, ByteOffset(DMA1_IFCRbits+0)]
;uarthandler.c,109 :: 		}
IT	AL
BAL	L_DMA1Ch2_interrupt188
L_DMA1Ch2_interrupt187:
;uarthandler.c,110 :: 		else if ( DMA1_ISRbits.HTIF2 ) {
MOVW	R0, #lo_addr(DMA1_ISRbits+0)
MOVT	R0, #hi_addr(DMA1_ISRbits+0)
_LX	[R0, ByteOffset(DMA1_ISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA1Ch2_interrupt189
;uarthandler.c,111 :: 		DMA1_IFCRbits.CHTIF2 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA1_IFCRbits+0)
MOVT	R0, #hi_addr(DMA1_IFCRbits+0)
_SX	[R0, ByteOffset(DMA1_IFCRbits+0)]
;uarthandler.c,112 :: 		}
IT	AL
BAL	L_DMA1Ch2_interrupt190
L_DMA1Ch2_interrupt189:
;uarthandler.c,113 :: 		else if ( DMA1_ISRbits.TCIF2 ) {     // TRANSFER COMPLETE INTERRUPT FLAG = envio el frame completo
MOVW	R0, #lo_addr(DMA1_ISRbits+0)
MOVT	R0, #hi_addr(DMA1_ISRbits+0)
_LX	[R0, ByteOffset(DMA1_ISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA1Ch2_interrupt191
;uarthandler.c,114 :: 		DMA1_IFCRbits.CTCIF2 = 1;       // limpia TODOS LOS FLAGS DE DMA2 CANAL 2
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA1_IFCRbits+0)
MOVT	R0, #hi_addr(DMA1_IFCRbits+0)
_SX	[R0, ByteOffset(DMA1_IFCRbits+0)]
;uarthandler.c,115 :: 		DMA1_CCR2bits.EN = 0;            // EXPERIMENTAL PARA CAMBIAR EL VALOR DEL CONTADOR
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA1_CCR2bits+0)
MOVT	R0, #hi_addr(DMA1_CCR2bits+0)
_SX	[R0, ByteOffset(DMA1_CCR2bits+0)]
;uarthandler.c,117 :: 		}
L_DMA1Ch2_interrupt191:
L_DMA1Ch2_interrupt190:
L_DMA1Ch2_interrupt188:
;uarthandler.c,118 :: 		}
L_end_DMA1Ch2_interrupt:
BX	LR
; end of _DMA1Ch2_interrupt
_DMA1Ch4_interrupt:
;uarthandler.c,121 :: 		void DMA1Ch4_interrupt() iv IVT_INT_DMA1_Channel4 ics ICS_AUTO {
;uarthandler.c,123 :: 		if ( DMA1_ISRbits.TEIF4 ) {         // TRANSFER ERROR INTERRUPT FLAG
MOVW	R0, #lo_addr(DMA1_ISRbits+0)
MOVT	R0, #hi_addr(DMA1_ISRbits+0)
_LX	[R0, ByteOffset(DMA1_ISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA1Ch4_interrupt192
;uarthandler.c,124 :: 		DMA1_IFCRbits .CTEIF4 = 1;       // limpia el flag de error
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA1_IFCRbits+0)
MOVT	R0, #hi_addr(DMA1_IFCRbits+0)
_SX	[R0, ByteOffset(DMA1_IFCRbits+0)]
;uarthandler.c,126 :: 		}
IT	AL
BAL	L_DMA1Ch4_interrupt193
L_DMA1Ch4_interrupt192:
;uarthandler.c,127 :: 		else if ( DMA1_ISRbits.HTIF4 ) {
MOVW	R0, #lo_addr(DMA1_ISRbits+0)
MOVT	R0, #hi_addr(DMA1_ISRbits+0)
_LX	[R0, ByteOffset(DMA1_ISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA1Ch4_interrupt194
;uarthandler.c,128 :: 		DMA1_IFCRbits.CHTIF4 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA1_IFCRbits+0)
MOVT	R0, #hi_addr(DMA1_IFCRbits+0)
_SX	[R0, ByteOffset(DMA1_IFCRbits+0)]
;uarthandler.c,129 :: 		}
IT	AL
BAL	L_DMA1Ch4_interrupt195
L_DMA1Ch4_interrupt194:
;uarthandler.c,130 :: 		else if ( DMA1_ISRbits.TCIF4 ) {     // TRANSFER COMPLETE INTERRUPT FLAG = envio el frame completo
MOVW	R0, #lo_addr(DMA1_ISRbits+0)
MOVT	R0, #hi_addr(DMA1_ISRbits+0)
_LX	[R0, ByteOffset(DMA1_ISRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_DMA1Ch4_interrupt196
;uarthandler.c,131 :: 		DMA1_IFCRbits.CTCIF4 = 1;       // limpia TODOS LOS FLAGS DE DMA2 CANAL 2
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA1_IFCRbits+0)
MOVT	R0, #hi_addr(DMA1_IFCRbits+0)
_SX	[R0, ByteOffset(DMA1_IFCRbits+0)]
;uarthandler.c,132 :: 		DMA1_CCR4bits.EN = 0;            // EXPERIMENTAL PARA CAMBIAR EL VALOR DEL CONTADOR
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA1_CCR4bits+0)
MOVT	R0, #hi_addr(DMA1_CCR4bits+0)
_SX	[R0, ByteOffset(DMA1_CCR4bits+0)]
;uarthandler.c,134 :: 		}
L_DMA1Ch4_interrupt196:
L_DMA1Ch4_interrupt195:
L_DMA1Ch4_interrupt193:
;uarthandler.c,135 :: 		}
L_end_DMA1Ch4_interrupt:
BX	LR
; end of _DMA1Ch4_interrupt
_vUARTISR:
;uarthandler.c,167 :: 		void vUARTISR() iv IVT_INT_USART1 ics ICS_AUTO{
;uarthandler.c,168 :: 		LED_BLUE =~ LED_BLUE;
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_LX	[R0, ByteOffset(GPIOC_ODRbits+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;uarthandler.c,170 :: 		if( USART1_SRbits.RXNE ){
MOVW	R0, #lo_addr(USART1_SRbits+0)
MOVT	R0, #hi_addr(USART1_SRbits+0)
_LX	[R0, ByteOffset(USART1_SRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUARTISR197
;uarthandler.c,171 :: 		ucData1 = USART1_DR;
MOVW	R0, #lo_addr(USART1_DR+0)
MOVT	R0, #hi_addr(USART1_DR+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
STRB	R1, [R0, #0]
;uarthandler.c,172 :: 		if ( ucData1 != CHR_CR && ucData1 != CHR_LF && ulUSART1ByteReceived < BUFFER_MAX_USART ) {
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #13
IT	EQ
BEQ	L__vUARTISR428
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	EQ
BEQ	L__vUARTISR427
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R0, [R0, #0]
CMP	R0, #4096
IT	CS
BCS	L__vUARTISR426
L__vUARTISR416:
;uarthandler.c,175 :: 		ucData1 == CHR_s ||
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #83
IT	EQ
BEQ	L__vUARTISR420
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #115
IT	EQ
BEQ	L__vUARTISR419
;uarthandler.c,176 :: 		ucData1 == CHR_U ||
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #85
IT	EQ
BEQ	L__vUARTISR418
;uarthandler.c,177 :: 		ucData1 == CHR_u ) &&
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #117
IT	EQ
BEQ	L__vUARTISR417
IT	AL
BAL	L_vUARTISR205
;uarthandler.c,175 :: 		ucData1 == CHR_s ||
L__vUARTISR420:
L__vUARTISR419:
;uarthandler.c,176 :: 		ucData1 == CHR_U ||
L__vUARTISR418:
;uarthandler.c,177 :: 		ucData1 == CHR_u ) &&
L__vUARTISR417:
;uarthandler.c,178 :: 		ulUSART1ByteReceived == 0 ) {
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L__vUARTISR421
L__vUARTISR414:
;uarthandler.c,179 :: 		ucUSART1RXBuffer[ ulUSART1ByteReceived++ ] = ucData1;
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
;uarthandler.c,180 :: 		}
IT	AL
BAL	L_vUARTISR206
L_vUARTISR205:
;uarthandler.c,178 :: 		ulUSART1ByteReceived == 0 ) {
L__vUARTISR421:
;uarthandler.c,183 :: 		ucUSART1RXBuffer[ 0 ] == CHR_s ||
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
LDRB	R0, [R0, #0]
CMP	R0, #83
IT	EQ
BEQ	L__vUARTISR425
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
LDRB	R0, [R0, #0]
CMP	R0, #115
IT	EQ
BEQ	L__vUARTISR424
;uarthandler.c,184 :: 		ucUSART1RXBuffer[ 0 ] == CHR_U ||
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
LDRB	R0, [R0, #0]
CMP	R0, #85
IT	EQ
BEQ	L__vUARTISR423
;uarthandler.c,185 :: 		ucUSART1RXBuffer[ 0 ] == CHR_u ) {
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
LDRB	R0, [R0, #0]
CMP	R0, #117
IT	EQ
BEQ	L__vUARTISR422
IT	AL
BAL	L_vUARTISR209
;uarthandler.c,183 :: 		ucUSART1RXBuffer[ 0 ] == CHR_s ||
L__vUARTISR425:
L__vUARTISR424:
;uarthandler.c,184 :: 		ucUSART1RXBuffer[ 0 ] == CHR_U ||
L__vUARTISR423:
;uarthandler.c,185 :: 		ucUSART1RXBuffer[ 0 ] == CHR_u ) {
L__vUARTISR422:
;uarthandler.c,186 :: 		ucUSART1RXBuffer[ ulUSART1ByteReceived++ ] = ucData1;
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
;uarthandler.c,187 :: 		}
L_vUARTISR209:
L_vUARTISR206:
;uarthandler.c,188 :: 		}
IT	AL
BAL	L_vUARTISR210
;uarthandler.c,172 :: 		if ( ucData1 != CHR_CR && ucData1 != CHR_LF && ulUSART1ByteReceived < BUFFER_MAX_USART ) {
L__vUARTISR428:
L__vUARTISR427:
L__vUARTISR426:
;uarthandler.c,190 :: 		else if ( ucData1 == CHR_CR ) {
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #13
IT	NE
BNE	L_vUARTISR211
;uarthandler.c,191 :: 		ucUSART1RXBuffer[ ulUSART1ByteReceived++ ] = ucData1;
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
;uarthandler.c,192 :: 		}
IT	AL
BAL	L_vUARTISR212
L_vUARTISR211:
;uarthandler.c,194 :: 		else if ( ucData1 == CHR_LF && ucUSART1RXBuffer[ ulUSART1ByteReceived - 1 ] == CHR_CR ) {
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	NE
BNE	L__vUARTISR430
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
BNE	L__vUARTISR429
L__vUARTISR412:
;uarthandler.c,195 :: 		ucUSART1RXBuffer[ ulUSART1ByteReceived++ ] = ucData1;
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
;uarthandler.c,196 :: 		fUSART1Buffer = READY_TO_READ;
MOVS	R1, #1
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
STR	R1, [R0, #0]
;uarthandler.c,194 :: 		else if ( ucData1 == CHR_LF && ucUSART1RXBuffer[ ulUSART1ByteReceived - 1 ] == CHR_CR ) {
L__vUARTISR430:
L__vUARTISR429:
;uarthandler.c,197 :: 		}
L_vUARTISR212:
L_vUARTISR210:
;uarthandler.c,198 :: 		}
L_vUARTISR197:
;uarthandler.c,199 :: 		}
L_end_vUARTISR:
BX	LR
; end of _vUARTISR
_vUSARTStartMEMtoMEMZero:
;uarthandler.c,210 :: 		unsigned char vUSARTStartMEMtoMEMZero ( unsigned long *pcBufferDestination, unsigned long ulSizeInBytes ) {
; ulSizeInBytes start address is: 4 (R1)
; pcBufferDestination start address is: 0 (R0)
SUB	SP, SP, #4
; ulSizeInBytes end address is: 4 (R1)
; pcBufferDestination end address is: 0 (R0)
; pcBufferDestination start address is: 0 (R0)
; ulSizeInBytes start address is: 4 (R1)
; pcBufferDestination end address is: 0 (R0)
; ulSizeInBytes end address is: 4 (R1)
;uarthandler.c,213 :: 		while ( DMA1_CCR1bits.EN );
L_vUSARTStartMEMtoMEMZero216:
; ulSizeInBytes start address is: 4 (R1)
; pcBufferDestination start address is: 0 (R0)
MOVW	R2, #lo_addr(DMA1_CCR1bits+0)
MOVT	R2, #hi_addr(DMA1_CCR1bits+0)
_LX	[R2, ByteOffset(DMA1_CCR1bits+0)]
CMP	R2, #0
IT	EQ
BEQ	L_vUSARTStartMEMtoMEMZero217
IT	AL
BAL	L_vUSARTStartMEMtoMEMZero216
L_vUSARTStartMEMtoMEMZero217:
;uarthandler.c,215 :: 		if ( ulSizeInBytes > 0 ) {                // la transmision anterior termino?
CMP	R1, #0
IT	LS
BLS	L_vUSARTStartMEMtoMEMZero218
;uarthandler.c,216 :: 		DMA1_CCR1bits.EN = 0;                  // Desabilita la recepcion para poder modificar los par?metros
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(DMA1_CCR1bits+0)
MOVT	R2, #hi_addr(DMA1_CCR1bits+0)
_SX	[R2, ByteOffset(DMA1_CCR1bits+0)]
; pcBufferDestination end address is: 0 (R0)
; ulSizeInBytes end address is: 4 (R1)
;uarthandler.c,217 :: 		while ( DMA1_CCR1bits.EN );            // espera a que se haya desabilitado realmente
L_vUSARTStartMEMtoMEMZero219:
; pcBufferDestination start address is: 0 (R0)
; ulSizeInBytes start address is: 4 (R1)
MOVW	R2, #lo_addr(DMA1_CCR1bits+0)
MOVT	R2, #hi_addr(DMA1_CCR1bits+0)
_LX	[R2, ByteOffset(DMA1_CCR1bits+0)]
CMP	R2, #0
IT	EQ
BEQ	L_vUSARTStartMEMtoMEMZero220
IT	AL
BAL	L_vUSARTStartMEMtoMEMZero219
L_vUSARTStartMEMtoMEMZero220:
;uarthandler.c,220 :: 		DMA1_CPAR1 = ( unsigned long ) &ucUSARTNull;         // Direccion de periferico a rutear
MOVW	R3, #lo_addr(_ucUSARTNull+0)
MOVT	R3, #hi_addr(_ucUSARTNull+0)
MOVW	R2, #lo_addr(DMA1_CPAR1+0)
MOVT	R2, #hi_addr(DMA1_CPAR1+0)
STR	R3, [R2, #0]
;uarthandler.c,221 :: 		DMA1_CMAR1 = ( unsigned long ) pcBufferDestination;  // Direccion de la memoria a rutear
MOVW	R2, #lo_addr(DMA1_CMAR1+0)
MOVT	R2, #hi_addr(DMA1_CMAR1+0)
STR	R0, [R2, #0]
; pcBufferDestination end address is: 0 (R0)
;uarthandler.c,223 :: 		DMA1_CNDTR1 = ulSizeInBytes;           // Tamagno de datos a manejar (Header + Payload)
MOVW	R2, #lo_addr(DMA1_CNDTR1+0)
MOVT	R2, #hi_addr(DMA1_CNDTR1+0)
STR	R1, [R2, #0]
; ulSizeInBytes end address is: 4 (R1)
;uarthandler.c,224 :: 		DMA1_CCR1bits.EN = 1;
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(DMA1_CCR1bits+0)
MOVT	R2, #hi_addr(DMA1_CCR1bits+0)
_SX	[R2, ByteOffset(DMA1_CCR1bits+0)]
;uarthandler.c,225 :: 		while ( DMA1_CCR1bits.EN );
L_vUSARTStartMEMtoMEMZero221:
MOVW	R2, #lo_addr(DMA1_CCR1bits+0)
MOVT	R2, #hi_addr(DMA1_CCR1bits+0)
_LX	[R2, ByteOffset(DMA1_CCR1bits+0)]
CMP	R2, #0
IT	EQ
BEQ	L_vUSARTStartMEMtoMEMZero222
IT	AL
BAL	L_vUSARTStartMEMtoMEMZero221
L_vUSARTStartMEMtoMEMZero222:
;uarthandler.c,226 :: 		return 1;                              // indica que transmitio
MOVS	R0, #1
IT	AL
BAL	L_end_vUSARTStartMEMtoMEMZero
;uarthandler.c,227 :: 		}
L_vUSARTStartMEMtoMEMZero218:
;uarthandler.c,228 :: 		return 0;                                 // indica que NO transmitio
MOVS	R0, #0
;uarthandler.c,249 :: 		}
L_end_vUSARTStartMEMtoMEMZero:
ADD	SP, SP, #4
BX	LR
; end of _vUSARTStartMEMtoMEMZero
_vUSARTDMAMeToMemZero:
;uarthandler.c,253 :: 		void vUSARTDMAMeToMemZero ( void ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;uarthandler.c,256 :: 		RCC_AHBENRbits.DMA1EN = 1;    // Habilita clock para DMA1
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_AHBENRbits+0)
MOVT	R0, #hi_addr(RCC_AHBENRbits+0)
_SX	[R0, ByteOffset(RCC_AHBENRbits+0)]
;uarthandler.c,258 :: 		DMA1_CCR1bits.EN = 0;          // deshabilita DMA SPI4 RX (para poder modificar los parametros)
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA1_CCR1bits+0)
MOVT	R0, #hi_addr(DMA1_CCR1bits+0)
_SX	[R0, ByteOffset(DMA1_CCR1bits+0)]
;uarthandler.c,259 :: 		while ( DMA1_CCR1bits.EN );    // espera a que se haya desabilitado realmente
L_vUSARTDMAMeToMemZero223:
MOVW	R0, #lo_addr(DMA1_CCR1bits+0)
MOVT	R0, #hi_addr(DMA1_CCR1bits+0)
_LX	[R0, ByteOffset(DMA1_CCR1bits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUSARTDMAMeToMemZero224
IT	AL
BAL	L_vUSARTDMAMeToMemZero223
L_vUSARTDMAMeToMemZero224:
;uarthandler.c,261 :: 		PL0_bit = 1;                   // Prioridad de canal
MOVS	R2, #1
SXTB	R2, R2
MOVW	R0, #lo_addr(PL0_bit+0)
MOVT	R0, #hi_addr(PL0_bit+0)
_SX	[R0, ByteOffset(PL0_bit+0)]
;uarthandler.c,262 :: 		PL1_bit = 1;
MOVW	R0, #lo_addr(PL1_bit+0)
MOVT	R0, #hi_addr(PL1_bit+0)
_SX	[R0, ByteOffset(PL1_bit+0)]
;uarthandler.c,263 :: 		DMA1_CCR1bits.MINC = 1;        // avanza en la direccion de la memoria apuntada
MOVW	R0, #lo_addr(DMA1_CCR1bits+0)
MOVT	R0, #hi_addr(DMA1_CCR1bits+0)
_SX	[R0, ByteOffset(DMA1_CCR1bits+0)]
;uarthandler.c,264 :: 		DMA1_CCR1bits.PINC = 0;        // no avanza en la direccion del periferico apuntado
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA1_CCR1bits+0)
MOVT	R0, #hi_addr(DMA1_CCR1bits+0)
_SX	[R0, ByteOffset(DMA1_CCR1bits+0)]
;uarthandler.c,265 :: 		DMA1_CCR1bits.DIR_ = 0;        // se lee de la "periferico" a Memoria
MOVW	R0, #lo_addr(DMA1_CCR1bits+0)
MOVT	R0, #hi_addr(DMA1_CCR1bits+0)
_SX	[R0, ByteOffset(DMA1_CCR1bits+0)]
;uarthandler.c,266 :: 		DMA1_CCR1bits.MEM2MEM = 1;     // direccion memoria a memoria
MOVW	R0, #lo_addr(DMA1_CCR1bits+0)
MOVT	R0, #hi_addr(DMA1_CCR1bits+0)
_SX	[R0, ByteOffset(DMA1_CCR1bits+0)]
;uarthandler.c,268 :: 		DMA1_CCR1bits.TEIE = 1;        // Habilitacion de interrupcion por error en trasmision
MOVW	R0, #lo_addr(DMA1_CCR1bits+0)
MOVT	R0, #hi_addr(DMA1_CCR1bits+0)
_SX	[R0, ByteOffset(DMA1_CCR1bits+0)]
;uarthandler.c,269 :: 		DMA1_CCR1bits.TCIE = 1;        // Interrupcion por transferencia completa
MOVW	R0, #lo_addr(DMA1_CCR1bits+0)
MOVT	R0, #hi_addr(DMA1_CCR1bits+0)
_SX	[R0, ByteOffset(DMA1_CCR1bits+0)]
;uarthandler.c,271 :: 		NVIC_IntEnable( IVT_INT_DMA1_Channel1 );      // habilita el vector de interrupcion para DMA
MOVW	R0, #27
BL	_NVIC_IntEnable+0
;uarthandler.c,294 :: 		}
L_end_vUSARTDMAMeToMemZero:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUSARTDMAMeToMemZero
_vUSARTStartMEMtoMEM:
;uarthandler.c,299 :: 		unsigned char vUSARTStartMEMtoMEM ( unsigned long *pcBufferOrigin, unsigned long *pcBufferDestination, unsigned long ulSizeInBytes ) {
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
;uarthandler.c,302 :: 		while ( DMA1_CCR2bits.EN );
L_vUSARTStartMEMtoMEM225:
; ulSizeInBytes start address is: 0 (R0)
; pcBufferDestination start address is: 4 (R1)
; pcBufferOrigin start address is: 8 (R2)
MOVW	R3, #lo_addr(DMA1_CCR2bits+0)
MOVT	R3, #hi_addr(DMA1_CCR2bits+0)
_LX	[R3, ByteOffset(DMA1_CCR2bits+0)]
CMP	R3, #0
IT	EQ
BEQ	L_vUSARTStartMEMtoMEM226
IT	AL
BAL	L_vUSARTStartMEMtoMEM225
L_vUSARTStartMEMtoMEM226:
;uarthandler.c,304 :: 		if ( ulSizeInBytes > 0 ) {                // la transmision anterior termino?
CMP	R0, #0
IT	LS
BLS	L_vUSARTStartMEMtoMEM227
;uarthandler.c,305 :: 		DMA1_CCR2bits.EN = 0;                  // Desabilita la recepci?n para poder modificar los par?metros
MOVS	R4, #0
SXTB	R4, R4
MOVW	R3, #lo_addr(DMA1_CCR2bits+0)
MOVT	R3, #hi_addr(DMA1_CCR2bits+0)
_SX	[R3, ByteOffset(DMA1_CCR2bits+0)]
; ulSizeInBytes end address is: 0 (R0)
; pcBufferOrigin end address is: 8 (R2)
; pcBufferDestination end address is: 4 (R1)
STR	R2, [SP, #0]
MOV	R2, R0
LDR	R0, [SP, #0]
;uarthandler.c,306 :: 		while ( DMA1_CCR2bits.EN );            // espera a que se haya desabilitado realmente
L_vUSARTStartMEMtoMEM228:
; pcBufferOrigin start address is: 0 (R0)
; pcBufferDestination start address is: 4 (R1)
; ulSizeInBytes start address is: 8 (R2)
MOVW	R3, #lo_addr(DMA1_CCR2bits+0)
MOVT	R3, #hi_addr(DMA1_CCR2bits+0)
_LX	[R3, ByteOffset(DMA1_CCR2bits+0)]
CMP	R3, #0
IT	EQ
BEQ	L_vUSARTStartMEMtoMEM229
IT	AL
BAL	L_vUSARTStartMEMtoMEM228
L_vUSARTStartMEMtoMEM229:
;uarthandler.c,309 :: 		DMA1_CPAR2 = ( unsigned long ) pcBufferOrigin;        // Direccion de periferico a rutear
MOVW	R3, #lo_addr(DMA1_CPAR2+0)
MOVT	R3, #hi_addr(DMA1_CPAR2+0)
STR	R0, [R3, #0]
; pcBufferOrigin end address is: 0 (R0)
;uarthandler.c,310 :: 		DMA1_CMAR2 = ( unsigned long ) pcBufferDestination;   // Direccion de la memoria a rutear
MOVW	R3, #lo_addr(DMA1_CMAR2+0)
MOVT	R3, #hi_addr(DMA1_CMAR2+0)
STR	R1, [R3, #0]
; pcBufferDestination end address is: 4 (R1)
;uarthandler.c,312 :: 		DMA1_CNDTR2 = ulSizeInBytes;           // Tamagno de datos a manejar (Header + Payload)
MOVW	R3, #lo_addr(DMA1_CNDTR2+0)
MOVT	R3, #hi_addr(DMA1_CNDTR2+0)
STR	R2, [R3, #0]
; ulSizeInBytes end address is: 8 (R2)
;uarthandler.c,313 :: 		DMA1_CCR2bits.EN = 1;
MOVS	R4, #1
SXTB	R4, R4
MOVW	R3, #lo_addr(DMA1_CCR2bits+0)
MOVT	R3, #hi_addr(DMA1_CCR2bits+0)
_SX	[R3, ByteOffset(DMA1_CCR2bits+0)]
;uarthandler.c,314 :: 		while ( DMA1_CCR2bits.EN );
L_vUSARTStartMEMtoMEM230:
MOVW	R3, #lo_addr(DMA1_CCR2bits+0)
MOVT	R3, #hi_addr(DMA1_CCR2bits+0)
_LX	[R3, ByteOffset(DMA1_CCR2bits+0)]
CMP	R3, #0
IT	EQ
BEQ	L_vUSARTStartMEMtoMEM231
IT	AL
BAL	L_vUSARTStartMEMtoMEM230
L_vUSARTStartMEMtoMEM231:
;uarthandler.c,315 :: 		return 1;                              // indica que transmitio
MOVS	R0, #1
IT	AL
BAL	L_end_vUSARTStartMEMtoMEM
;uarthandler.c,316 :: 		}
L_vUSARTStartMEMtoMEM227:
;uarthandler.c,317 :: 		return 0;                                 // indica que NO transmitio
MOVS	R0, #0
;uarthandler.c,338 :: 		}
L_end_vUSARTStartMEMtoMEM:
ADD	SP, SP, #4
BX	LR
; end of _vUSARTStartMEMtoMEM
_vUSARTDMAMemToMem:
;uarthandler.c,342 :: 		void vUSARTDMAMemToMem ( void ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;uarthandler.c,345 :: 		RCC_AHBENRbits.DMA1EN = 1;    // Habilita clock para DMA1
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_AHBENRbits+0)
MOVT	R0, #hi_addr(RCC_AHBENRbits+0)
_SX	[R0, ByteOffset(RCC_AHBENRbits+0)]
;uarthandler.c,347 :: 		DMA1_CCR2bits.EN = 0;          // deshabilita DMA SPI4 RX (para poder modificar los parametros)
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA1_CCR2bits+0)
MOVT	R0, #hi_addr(DMA1_CCR2bits+0)
_SX	[R0, ByteOffset(DMA1_CCR2bits+0)]
;uarthandler.c,348 :: 		while ( DMA1_CCR2bits.EN );    // espera a que se haya desabilitado realmente
L_vUSARTDMAMemToMem232:
MOVW	R0, #lo_addr(DMA1_CCR2bits+0)
MOVT	R0, #hi_addr(DMA1_CCR2bits+0)
_LX	[R0, ByteOffset(DMA1_CCR2bits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUSARTDMAMemToMem233
IT	AL
BAL	L_vUSARTDMAMemToMem232
L_vUSARTDMAMemToMem233:
;uarthandler.c,350 :: 		PL0_DMA1_CCR2_bit = 1;         // Prioridad de canal
MOVS	R2, #1
SXTB	R2, R2
MOVW	R0, #lo_addr(PL0_DMA1_CCR2_bit+0)
MOVT	R0, #hi_addr(PL0_DMA1_CCR2_bit+0)
_SX	[R0, ByteOffset(PL0_DMA1_CCR2_bit+0)]
;uarthandler.c,351 :: 		PL1_DMA1_CCR2_bit = 1;
MOVW	R0, #lo_addr(PL1_DMA1_CCR2_bit+0)
MOVT	R0, #hi_addr(PL1_DMA1_CCR2_bit+0)
_SX	[R0, ByteOffset(PL1_DMA1_CCR2_bit+0)]
;uarthandler.c,353 :: 		DMA1_CCR2bits.MINC = 1;        // avanza en la direccion de la memoria apuntada
MOVW	R0, #lo_addr(DMA1_CCR2bits+0)
MOVT	R0, #hi_addr(DMA1_CCR2bits+0)
_SX	[R0, ByteOffset(DMA1_CCR2bits+0)]
;uarthandler.c,354 :: 		DMA1_CCR2bits.PINC = 1;        // avanza en la direccion del periferico apuntado
MOVW	R0, #lo_addr(DMA1_CCR2bits+0)
MOVT	R0, #hi_addr(DMA1_CCR2bits+0)
_SX	[R0, ByteOffset(DMA1_CCR2bits+0)]
;uarthandler.c,355 :: 		DMA1_CCR2bits.DIR_ = 0;        // se lee de la "periferico" a Memoria
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA1_CCR2bits+0)
MOVT	R0, #hi_addr(DMA1_CCR2bits+0)
_SX	[R0, ByteOffset(DMA1_CCR2bits+0)]
;uarthandler.c,356 :: 		DMA1_CCR2bits.MEM2MEM = 1;     // direccion memoria a memoria
MOVW	R0, #lo_addr(DMA1_CCR2bits+0)
MOVT	R0, #hi_addr(DMA1_CCR2bits+0)
_SX	[R0, ByteOffset(DMA1_CCR2bits+0)]
;uarthandler.c,358 :: 		DMA1_CCR2bits.TEIE = 1;        // Habilitacion de interrupcion por error en trasmision
MOVW	R0, #lo_addr(DMA1_CCR2bits+0)
MOVT	R0, #hi_addr(DMA1_CCR2bits+0)
_SX	[R0, ByteOffset(DMA1_CCR2bits+0)]
;uarthandler.c,359 :: 		DMA1_CCR2bits.TCIE = 1;        // Interrupcion por transferencia completa
MOVW	R0, #lo_addr(DMA1_CCR2bits+0)
MOVT	R0, #hi_addr(DMA1_CCR2bits+0)
_SX	[R0, ByteOffset(DMA1_CCR2bits+0)]
;uarthandler.c,361 :: 		NVIC_IntEnable( IVT_INT_DMA1_Channel2 );      // habilita el vector de interrupcion para DMA
MOVW	R0, #28
BL	_NVIC_IntEnable+0
;uarthandler.c,384 :: 		}
L_end_vUSARTDMAMemToMem:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUSARTDMAMemToMem
_vUSART1Start_TX:
;uarthandler.c,390 :: 		unsigned char vUSART1Start_TX ( unsigned long *ucBuffer, unsigned long ulSize ) {
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
;uarthandler.c,393 :: 		while ( DMA1_CCR4bits.EN || !USART1_SRbits.TC );
L_vUSART1Start_TX234:
; ucBuffer start address is: 4 (R1)
; ulSize start address is: 0 (R0)
; ulSize start address is: 0 (R0)
; ulSize end address is: 0 (R0)
; ucBuffer start address is: 4 (R1)
; ucBuffer end address is: 4 (R1)
MOVW	R2, #lo_addr(DMA1_CCR4bits+0)
MOVT	R2, #hi_addr(DMA1_CCR4bits+0)
_LX	[R2, ByteOffset(DMA1_CCR4bits+0)]
CMP	R2, #0
IT	NE
BNE	L__vUSART1Start_TX435
; ulSize end address is: 0 (R0)
; ucBuffer end address is: 4 (R1)
; ucBuffer start address is: 4 (R1)
; ulSize start address is: 0 (R0)
MOVW	R2, #lo_addr(USART1_SRbits+0)
MOVT	R2, #hi_addr(USART1_SRbits+0)
_LX	[R2, ByteOffset(USART1_SRbits+0)]
CMP	R2, #0
IT	EQ
BEQ	L__vUSART1Start_TX434
IT	AL
BAL	L_vUSART1Start_TX235
L__vUSART1Start_TX435:
L__vUSART1Start_TX434:
IT	AL
BAL	L_vUSART1Start_TX234
L_vUSART1Start_TX235:
;uarthandler.c,395 :: 		if ( USART1_CR1bits.UE && USART1_SRbits.TC && ulSize > 0 ) { // la transmision anterior termino?
MOVW	R2, #lo_addr(USART1_CR1bits+0)
MOVT	R2, #hi_addr(USART1_CR1bits+0)
_LX	[R2, ByteOffset(USART1_CR1bits+0)]
CMP	R2, #0
IT	EQ
BEQ	L__vUSART1Start_TX440
MOVW	R2, #lo_addr(USART1_SRbits+0)
MOVT	R2, #hi_addr(USART1_SRbits+0)
_LX	[R2, ByteOffset(USART1_SRbits+0)]
CMP	R2, #0
IT	EQ
BEQ	L__vUSART1Start_TX439
CMP	R0, #0
IT	LS
BLS	L__vUSART1Start_TX438
L__vUSART1Start_TX432:
;uarthandler.c,396 :: 		DMA1_CCR4bits.EN = 0;                       // Desabilita la recepci?n para poder modificar los par?metros
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(DMA1_CCR4bits+0)
MOVT	R2, #hi_addr(DMA1_CCR4bits+0)
_SX	[R2, ByteOffset(DMA1_CCR4bits+0)]
; ulSize end address is: 0 (R0)
; ucBuffer end address is: 4 (R1)
STR	R1, [SP, #0]
MOV	R1, R0
LDR	R0, [SP, #0]
;uarthandler.c,397 :: 		while ( DMA1_CCR4bits.EN );                 // espera a que se haya desabilitado realmente
L_vUSART1Start_TX241:
; ucBuffer start address is: 0 (R0)
; ulSize start address is: 4 (R1)
MOVW	R2, #lo_addr(DMA1_CCR4bits+0)
MOVT	R2, #hi_addr(DMA1_CCR4bits+0)
_LX	[R2, ByteOffset(DMA1_CCR4bits+0)]
CMP	R2, #0
IT	EQ
BEQ	L_vUSART1Start_TX242
IT	AL
BAL	L_vUSART1Start_TX241
L_vUSART1Start_TX242:
;uarthandler.c,399 :: 		DMA1_CMAR4 = ( unsigned long ) ucBuffer;   // Direcci?n de la memoria a rutear
MOVW	R2, #lo_addr(DMA1_CMAR4+0)
MOVT	R2, #hi_addr(DMA1_CMAR4+0)
STR	R0, [R2, #0]
; ucBuffer end address is: 0 (R0)
;uarthandler.c,400 :: 		DMA1_CNDTR4 = ulSize;                       // Tama?o de datos a manejar
MOVW	R2, #lo_addr(DMA1_CNDTR4+0)
MOVT	R2, #hi_addr(DMA1_CNDTR4+0)
STR	R1, [R2, #0]
; ulSize end address is: 4 (R1)
;uarthandler.c,401 :: 		DMA1_CCR4bits.EN = 1;
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(DMA1_CCR4bits+0)
MOVT	R2, #hi_addr(DMA1_CCR4bits+0)
_SX	[R2, ByteOffset(DMA1_CCR4bits+0)]
;uarthandler.c,402 :: 		while ( DMA1_CCR4bits.EN || !USART1_SRbits.TC );
L_vUSART1Start_TX243:
MOVW	R2, #lo_addr(DMA1_CCR4bits+0)
MOVT	R2, #hi_addr(DMA1_CCR4bits+0)
_LX	[R2, ByteOffset(DMA1_CCR4bits+0)]
CMP	R2, #0
IT	NE
BNE	L__vUSART1Start_TX437
MOVW	R2, #lo_addr(USART1_SRbits+0)
MOVT	R2, #hi_addr(USART1_SRbits+0)
_LX	[R2, ByteOffset(USART1_SRbits+0)]
CMP	R2, #0
IT	EQ
BEQ	L__vUSART1Start_TX436
IT	AL
BAL	L_vUSART1Start_TX244
L__vUSART1Start_TX437:
L__vUSART1Start_TX436:
IT	AL
BAL	L_vUSART1Start_TX243
L_vUSART1Start_TX244:
;uarthandler.c,403 :: 		return 1;                                   // indica que transmitio
MOVS	R0, #1
IT	AL
BAL	L_end_vUSART1Start_TX
;uarthandler.c,395 :: 		if ( USART1_CR1bits.UE && USART1_SRbits.TC && ulSize > 0 ) { // la transmision anterior termino?
L__vUSART1Start_TX440:
L__vUSART1Start_TX439:
L__vUSART1Start_TX438:
;uarthandler.c,405 :: 		return 0;                                      // indica que NO transmitio
MOVS	R0, #0
;uarthandler.c,423 :: 		}
L_end_vUSART1Start_TX:
ADD	SP, SP, #4
BX	LR
; end of _vUSART1Start_TX
_vInitDMAUSART1_TX:
;uarthandler.c,427 :: 		void vInitDMAUSART1_TX () {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;uarthandler.c,429 :: 		RCC_AHBENRbits.DMA1EN = 1;    // Habilita clock para DMA1
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_AHBENRbits+0)
MOVT	R0, #hi_addr(RCC_AHBENRbits+0)
_SX	[R0, ByteOffset(RCC_AHBENRbits+0)]
;uarthandler.c,431 :: 		DMA1_CCR4bits.EN = 0;          // deshabilita DMA USART1 TX (para poder modificar los parametros)
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(DMA1_CCR4bits+0)
MOVT	R0, #hi_addr(DMA1_CCR4bits+0)
_SX	[R0, ByteOffset(DMA1_CCR4bits+0)]
;uarthandler.c,432 :: 		while ( DMA1_CCR4bits.EN );    // espera a que se haya desabilitado realmente
L_vInitDMAUSART1_TX247:
MOVW	R0, #lo_addr(DMA1_CCR4bits+0)
MOVT	R0, #hi_addr(DMA1_CCR4bits+0)
_LX	[R0, ByteOffset(DMA1_CCR4bits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vInitDMAUSART1_TX248
IT	AL
BAL	L_vInitDMAUSART1_TX247
L_vInitDMAUSART1_TX248:
;uarthandler.c,435 :: 		DMA1_CPAR4 = ( unsigned long ) &USART1_DR;           // Direccion fisica de periferico a rutear
MOVW	R1, #lo_addr(USART1_DR+0)
MOVT	R1, #hi_addr(USART1_DR+0)
MOVW	R0, #lo_addr(DMA1_CPAR4+0)
MOVT	R0, #hi_addr(DMA1_CPAR4+0)
STR	R1, [R0, #0]
;uarthandler.c,437 :: 		PL0_DMA1_CCR4_bit = 1;         // Prioridad de canal
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(PL0_DMA1_CCR4_bit+0)
MOVT	R0, #hi_addr(PL0_DMA1_CCR4_bit+0)
_SX	[R0, ByteOffset(PL0_DMA1_CCR4_bit+0)]
;uarthandler.c,438 :: 		PL1_DMA1_CCR4_bit = 1;
MOVW	R0, #lo_addr(PL1_DMA1_CCR4_bit+0)
MOVT	R0, #hi_addr(PL1_DMA1_CCR4_bit+0)
_SX	[R0, ByteOffset(PL1_DMA1_CCR4_bit+0)]
;uarthandler.c,439 :: 		DMA1_CCR4bits.MINC = 1;        // avanza en la direccion de la memoria apuntada
MOVW	R0, #lo_addr(DMA1_CCR4bits+0)
MOVT	R0, #hi_addr(DMA1_CCR4bits+0)
_SX	[R0, ByteOffset(DMA1_CCR4bits+0)]
;uarthandler.c,440 :: 		DMA1_CCR4bits.DIR_ = 1;        // direccion memoria a periferico
MOVW	R0, #lo_addr(DMA1_CCR4bits+0)
MOVT	R0, #hi_addr(DMA1_CCR4bits+0)
_SX	[R0, ByteOffset(DMA1_CCR4bits+0)]
;uarthandler.c,441 :: 		DMA1_CCR4bits.TEIE = 1;        // Habilitacion de interrupcion por error en trasmision
MOVW	R0, #lo_addr(DMA1_CCR4bits+0)
MOVT	R0, #hi_addr(DMA1_CCR4bits+0)
_SX	[R0, ByteOffset(DMA1_CCR4bits+0)]
;uarthandler.c,442 :: 		DMA1_CCR4bits.TCIE = 1;        // Interrupcion por transferencia completa
MOVW	R0, #lo_addr(DMA1_CCR4bits+0)
MOVT	R0, #hi_addr(DMA1_CCR4bits+0)
_SX	[R0, ByteOffset(DMA1_CCR4bits+0)]
;uarthandler.c,444 :: 		NVIC_IntEnable( IVT_INT_DMA1_Channel4 );      // habilita el vector de interrupcion para DMA
MOVW	R0, #30
BL	_NVIC_IntEnable+0
;uarthandler.c,465 :: 		}
L_end_vInitDMAUSART1_TX:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vInitDMAUSART1_TX
_vUSARTConfigUSART1:
;uarthandler.c,470 :: 		void vUSARTConfigUSART1 ( unsigned long ulBaudRate ) {
; ulBaudRate start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; ulBaudRate end address is: 0 (R0)
; ulBaudRate start address is: 0 (R0)
;uarthandler.c,472 :: 		UART1_Init_Advanced( ulBaudRate, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10 );
MOVW	R1, #lo_addr(__GPIO_MODULE_USART1_PA9_10+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_USART1_PA9_10+0)
PUSH	(R1)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
; ulBaudRate end address is: 0 (R0)
BL	_UART1_Init_Advanced+0
ADD	SP, SP, #4
;uarthandler.c,473 :: 		Enable_IRQ_USART1;                 // habilita interrupcion por RX de USART1
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(USART1_CR1bits+0)
MOVT	R1, #hi_addr(USART1_CR1bits+0)
_SX	[R1, ByteOffset(USART1_CR1bits+0)]
;uarthandler.c,474 :: 		USART1_CR3bits.DMAT = 1;           // habilita transmision mediante DMA
MOVW	R1, #lo_addr(USART1_CR3bits+0)
MOVT	R1, #hi_addr(USART1_CR3bits+0)
_SX	[R1, ByteOffset(USART1_CR3bits+0)]
;uarthandler.c,475 :: 		vInitDMAUSART1_TX();               // se llama como funcion
BL	_vInitDMAUSART1_TX+0
;uarthandler.c,476 :: 		fUSART1Buffer = CLEAR_TO_WRITE;
MOVS	R2, #0
MOVW	R1, #lo_addr(_fUSART1Buffer+0)
MOVT	R1, #hi_addr(_fUSART1Buffer+0)
STR	R2, [R1, #0]
;uarthandler.c,477 :: 		NVIC_IntEnable( IVT_INT_USART1 );  // Habilita vector de interrupcion
MOVW	R0, #53
BL	_NVIC_IntEnable+0
;uarthandler.c,478 :: 		vUSARTDMAMemToMem();               // inicializa el DMA MEMtoMEM 1 ( Buffer a Buffer )
BL	_vUSARTDMAMemToMem+0
;uarthandler.c,479 :: 		vUSARTDMAMeToMemZero();            // inicializa el DMA MEMtoMEM 2 ( Limpiar buffer )
BL	_vUSARTDMAMeToMemZero+0
;uarthandler.c,492 :: 		}
L_end_vUSARTConfigUSART1:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUSARTConfigUSART1
_vUSARTCleanBuffer:
;uarthandler.c,498 :: 		void vUSARTCleanBuffer ( unsigned char *ucBuffer, unsigned int uiCnt ) {
; uiCnt start address is: 4 (R1)
; ucBuffer start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; uiCnt end address is: 4 (R1)
; ucBuffer end address is: 0 (R0)
; ucBuffer start address is: 0 (R0)
; uiCnt start address is: 4 (R1)
;uarthandler.c,500 :: 		vUSARTStartMEMtoMEMZero( ucBuffer, uiCnt );
; uiCnt end address is: 4 (R1)
; ucBuffer end address is: 0 (R0)
BL	_vUSARTStartMEMtoMEMZero+0
;uarthandler.c,501 :: 		}
L_end_vUSARTCleanBuffer:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUSARTCleanBuffer
_vUSARTReceivedFromUSART1:
;uarthandler.c,505 :: 		void vUSARTReceivedFromUSART1 ( ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;uarthandler.c,507 :: 		vUSARTCleanBuffer( ucUSARTActiveBuffer1, ulUSARTActiveBuffer1BytesReceived ); // borra todo el buffer
MOVW	R0, #lo_addr(_ulUSARTActiveBuffer1BytesReceived+0)
MOVT	R0, #hi_addr(_ulUSARTActiveBuffer1BytesReceived+0)
LDR	R0, [R0, #0]
UXTH	R1, R0
MOVW	R0, #lo_addr(_ucUSARTActiveBuffer1+0)
MOVT	R0, #hi_addr(_ucUSARTActiveBuffer1+0)
BL	_vUSARTCleanBuffer+0
;uarthandler.c,509 :: 		vUSARTStartMEMtoMEM( ucUSART1RXBuffer, ucUSARTActiveBuffer1, ulUSART1ByteReceived ); // copia el buffer de entrada
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R0, [R0, #0]
MOV	R2, R0
MOVW	R1, #lo_addr(_ucUSARTActiveBuffer1+0)
MOVT	R1, #hi_addr(_ucUSARTActiveBuffer1+0)
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
BL	_vUSARTStartMEMtoMEM+0
;uarthandler.c,510 :: 		vUSARTCleanBuffer( ucUSART1RXBuffer, ulUSART1ByteReceived );          // lo limpia
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R0, [R0, #0]
UXTH	R1, R0
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
BL	_vUSARTCleanBuffer+0
;uarthandler.c,511 :: 		ulUSARTActiveBuffer1BytesReceived = ulUSART1ByteReceived;             // le pasa el valor
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ulUSARTActiveBuffer1BytesReceived+0)
MOVT	R0, #hi_addr(_ulUSARTActiveBuffer1BytesReceived+0)
STR	R1, [R0, #0]
;uarthandler.c,512 :: 		ulUSART1ByteReceived = 0;                                             // pone a cero el contador
MOVS	R1, #0
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
STR	R1, [R0, #0]
;uarthandler.c,513 :: 		fUSART1Buffer = CLEAR_TO_WRITE;                                       // indica que esta limpio
MOVS	R1, #0
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
STR	R1, [R0, #0]
;uarthandler.c,514 :: 		vRF4463MainCommandProcessor( ucUSARTActiveBuffer1 );
MOVW	R0, #lo_addr(_ucUSARTActiveBuffer1+0)
MOVT	R0, #hi_addr(_ucUSARTActiveBuffer1+0)
BL	_vRF4463MainCommandProcessor+0
;uarthandler.c,515 :: 		}
L_end_vUSARTReceivedFromUSART1:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUSARTReceivedFromUSART1
_vUARTRxMessage:
;uarthandler.c,524 :: 		void vUARTRxMessage(){
SUB	SP, SP, #4
;uarthandler.c,525 :: 		unsigned int usCounter = 0;
;uarthandler.c,537 :: 		usUARTMessageLength = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_usUARTMessageLength+0)
MOVT	R0, #hi_addr(_usUARTMessageLength+0)
STRH	R1, [R0, #0]
;uarthandler.c,538 :: 		}
L_end_vUARTRxMessage:
ADD	SP, SP, #4
BX	LR
; end of _vUARTRxMessage
_Timer2_interrupt:
;DriverRF4463PROMain.c,111 :: 		void Timer2_interrupt() iv IVT_INT_TIM2 {
;DriverRF4463PROMain.c,112 :: 		TIM2_SR.UIF = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_SR+0)
MOVT	R0, #hi_addr(TIM2_SR+0)
_SX	[R0, ByteOffset(TIM2_SR+0)]
;DriverRF4463PROMain.c,113 :: 		Flag.rf_reach_timeout = 1; //Enter your code here
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,114 :: 		Flag.reach_1s = 1;
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,115 :: 		}
L_end_Timer2_interrupt:
BX	LR
; end of _Timer2_interrupt
_vRF4463MainApplyChanges:
;DriverRF4463PROMain.c,119 :: 		void vRF4463MainApplyChanges () {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;DriverRF4463PROMain.c,120 :: 		VRF4463SDNReset();
BL	_VRF4463SDNReset+0
;DriverRF4463PROMain.c,121 :: 		vRF4463Init();
BL	_vRF4463Init+0
;DriverRF4463PROMain.c,122 :: 		vRF4463ClearInterrupts();
BL	_vRF4463ClearInterrupts+0
;DriverRF4463PROMain.c,123 :: 		}
L_end_vRF4463MainApplyChanges:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vRF4463MainApplyChanges
_vRF4463MainSetTXString:
;DriverRF4463PROMain.c,126 :: 		void vRF4463MainSetTXString () {
SUB	SP, SP, #4
;DriverRF4463PROMain.c,131 :: 		}
L_end_vRF4463MainSetTXString:
ADD	SP, SP, #4
BX	LR
; end of _vRF4463MainSetTXString
_vRF4463MainCommandProcessor:
;DriverRF4463PROMain.c,135 :: 		void vRF4463MainCommandProcessor ( unsigned char *ucBuffer ) {
; ucBuffer start address is: 0 (R0)
SUB	SP, SP, #104
STR	LR, [SP, #0]
MOV	R5, R0
; ucBuffer end address is: 0 (R0)
; ucBuffer start address is: 20 (R5)
;DriverRF4463PROMain.c,136 :: 		unsigned char ucCommand [ 32 ] = { 0x00 };
ADD	R11, SP, #4
ADD	R10, R11, #96
MOVW	R12, #lo_addr(?ICSvRF4463MainCommandProcessor_ucCommand_L0+0)
MOVT	R12, #hi_addr(?ICSvRF4463MainCommandProcessor_ucCommand_L0+0)
BL	___CC2DW+0
;DriverRF4463PROMain.c,137 :: 		unsigned long ulArgument = 0;
;DriverRF4463PROMain.c,138 :: 		unsigned char ucLongArgument[ 64 ] = { 0x00 };     // Espera argumentos de hasta 11 bytes
;DriverRF4463PROMain.c,139 :: 		unsigned char ucCounterBuffer = 0;
; ucCounterBuffer start address is: 12 (R3)
MOVS	R3, #0
;DriverRF4463PROMain.c,140 :: 		unsigned char ucCounterCommand = 0;
; ucCounterCommand start address is: 16 (R4)
MOVS	R4, #0
;DriverRF4463PROMain.c,141 :: 		unsigned char ucCounterLongArgument = 0;
; ucCounterLongArgument start address is: 8 (R2)
MOVS	R2, #0
;DriverRF4463PROMain.c,144 :: 		if ( ucBuffer[ 0 ] > '@' && ucBuffer[ 0 ] <= 'z' ) {
LDRB	R1, [R5, #0]
CMP	R1, #64
IT	LS
BLS	L__vRF4463MainCommandProcessor490
LDRB	R1, [R5, #0]
CMP	R1, #122
IT	HI
BHI	L__vRF4463MainCommandProcessor491
L__vRF4463MainCommandProcessor456:
;DriverRF4463PROMain.c,146 :: 		while ( ucBuffer[ ucCounterBuffer ] != '|' && ucCounterCommand < 32 ) {      // primer token
; ucCounterCommand end address is: 16 (R4)
; ucCounterBuffer end address is: 12 (R3)
; ucBuffer end address is: 20 (R5)
L_vRF4463MainCommandProcessor252:
; ucCounterLongArgument end address is: 8 (R2)
; ucCounterLongArgument start address is: 8 (R2)
; ucCounterCommand start address is: 16 (R4)
; ucCounterBuffer start address is: 12 (R3)
; ucBuffer start address is: 20 (R5)
ADDS	R1, R5, R3
LDRB	R1, [R1, #0]
CMP	R1, #124
IT	EQ
BEQ	L__vRF4463MainCommandProcessor458
CMP	R4, #32
IT	CS
BCS	L__vRF4463MainCommandProcessor457
L__vRF4463MainCommandProcessor455:
;DriverRF4463PROMain.c,147 :: 		ucCommand[ ucCounterCommand++ ] = toupper( ucBuffer[ ucCounterBuffer++ ] );
ADD	R1, SP, #4
ADDS	R1, R1, R4
STR	R1, [SP, #100]
ADDS	R1, R5, R3
LDRB	R1, [R1, #0]
UXTB	R0, R1
BL	_toupper+0
LDR	R1, [SP, #100]
STRB	R0, [R1, #0]
ADDS	R4, R4, #1
UXTB	R4, R4
ADDS	R3, R3, #1
UXTB	R3, R3
;DriverRF4463PROMain.c,148 :: 		}
; ucCounterCommand end address is: 16 (R4)
IT	AL
BAL	L_vRF4463MainCommandProcessor252
;DriverRF4463PROMain.c,146 :: 		while ( ucBuffer[ ucCounterBuffer ] != '|' && ucCounterCommand < 32 ) {      // primer token
L__vRF4463MainCommandProcessor458:
L__vRF4463MainCommandProcessor457:
;DriverRF4463PROMain.c,150 :: 		ucCounterBuffer++;                                                           // evita el Token
ADDS	R4, R3, #1
UXTB	R4, R4
; ucCounterBuffer end address is: 12 (R3)
; ucCounterBuffer start address is: 16 (R4)
; ucCounterLongArgument end address is: 8 (R2)
; ucCounterBuffer end address is: 16 (R4)
; ucBuffer end address is: 20 (R5)
UXTB	R3, R2
MOV	R0, R5
;DriverRF4463PROMain.c,152 :: 		while ( ucBuffer[ ucCounterBuffer ] != CHR_CR && ucCounterLongArgument < 64 ) {   // segundo token
L_vRF4463MainCommandProcessor256:
; ucCounterBuffer start address is: 16 (R4)
; ucBuffer start address is: 0 (R0)
; ucCounterLongArgument start address is: 12 (R3)
ADDS	R1, R0, R4
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vRF4463MainCommandProcessor460
CMP	R3, #64
IT	CS
BCS	L__vRF4463MainCommandProcessor459
L__vRF4463MainCommandProcessor454:
;DriverRF4463PROMain.c,153 :: 		ucLongArgument[ ucCounterLongArgument ] = ucBuffer[ ucCounterBuffer ] ;   //  toupper(
ADD	R1, SP, #36
ADDS	R2, R1, R3
ADDS	R1, R0, R4
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
;DriverRF4463PROMain.c,154 :: 		ucCounterBuffer++;
ADDS	R4, R4, #1
UXTB	R4, R4
;DriverRF4463PROMain.c,155 :: 		ucCounterLongArgument++;
ADDS	R3, R3, #1
UXTB	R3, R3
;DriverRF4463PROMain.c,156 :: 		}
; ucCounterBuffer end address is: 16 (R4)
; ucCounterLongArgument end address is: 12 (R3)
IT	AL
BAL	L_vRF4463MainCommandProcessor256
;DriverRF4463PROMain.c,152 :: 		while ( ucBuffer[ ucCounterBuffer ] != CHR_CR && ucCounterLongArgument < 64 ) {   // segundo token
L__vRF4463MainCommandProcessor460:
L__vRF4463MainCommandProcessor459:
;DriverRF4463PROMain.c,144 :: 		if ( ucBuffer[ 0 ] > '@' && ucBuffer[ 0 ] <= 'z' ) {
MOV	R5, R0
IT	AL
BAL	L__vRF4463MainCommandProcessor462
; ucBuffer end address is: 0 (R0)
L__vRF4463MainCommandProcessor490:
L__vRF4463MainCommandProcessor462:
; ucBuffer start address is: 20 (R5)
; ucBuffer end address is: 20 (R5)
IT	AL
BAL	L__vRF4463MainCommandProcessor461
L__vRF4463MainCommandProcessor491:
L__vRF4463MainCommandProcessor461:
;DriverRF4463PROMain.c,161 :: 		if ( memcmp( CMD_RADIO_POWER_SET, ucCommand, sizeof( CMD_RADIO_POWER_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
ADD	R1, SP, #4
MOVS	R2, #10
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_POWER_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_POWER_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor260
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,162 :: 		ulArgument = StrToShort( ucLongArgument );
ADD	R1, SP, #36
MOV	R0, R1
BL	_StrToShort+0
; ulArgument start address is: 0 (R0)
;DriverRF4463PROMain.c,164 :: 		if ( ulArgument > 0 && ulArgument <= 127 ) {
CMP	R0, #0
IT	LS
BLS	L__vRF4463MainCommandProcessor464
CMP	R0, #127
IT	HI
BHI	L__vRF4463MainCommandProcessor463
L__vRF4463MainCommandProcessor453:
;DriverRF4463PROMain.c,165 :: 		ucRF4463Power = ulArgument;
MOVW	R1, #lo_addr(_ucRF4463Power+0)
MOVT	R1, #hi_addr(_ucRF4463Power+0)
STRB	R0, [R1, #0]
; ulArgument end address is: 0 (R0)
;DriverRF4463PROMain.c,166 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,167 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,168 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor264
;DriverRF4463PROMain.c,164 :: 		if ( ulArgument > 0 && ulArgument <= 127 ) {
L__vRF4463MainCommandProcessor464:
L__vRF4463MainCommandProcessor463:
;DriverRF4463PROMain.c,170 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,171 :: 		}
L_vRF4463MainCommandProcessor264:
;DriverRF4463PROMain.c,172 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor265
L_vRF4463MainCommandProcessor260:
;DriverRF4463PROMain.c,176 :: 		else if ( memcmp( CMD_RADIO_BAND_SET, ucCommand, sizeof( CMD_RADIO_BAND_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
ADD	R1, SP, #4
MOVS	R2, #9
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_BAND_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_BAND_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor266
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,177 :: 		ulArgument = StrToInt( ucLongArgument );
ADD	R1, SP, #36
MOV	R0, R1
BL	_StrToInt+0
; ulArgument start address is: 0 (R0)
;DriverRF4463PROMain.c,179 :: 		if ( ulArgument == 433 || ulArgument == 868 || ulArgument == 915 ) {
MOVW	R1, #433
CMP	R0, R1
IT	EQ
BEQ	L__vRF4463MainCommandProcessor467
CMP	R0, #868
IT	EQ
BEQ	L__vRF4463MainCommandProcessor466
MOVW	R1, #915
CMP	R0, R1
IT	EQ
BEQ	L__vRF4463MainCommandProcessor465
; ulArgument end address is: 0 (R0)
IT	AL
BAL	L_vRF4463MainCommandProcessor269
L__vRF4463MainCommandProcessor467:
L__vRF4463MainCommandProcessor466:
L__vRF4463MainCommandProcessor465:
;DriverRF4463PROMain.c,180 :: 		ucRF4463Freq3 = ucLongArgument[ 0 ] - 48;
ADD	R3, SP, #36
LDRB	R1, [R3, #0]
SUBW	R2, R1, #48
MOVW	R1, #lo_addr(_ucRF4463Freq3+0)
MOVT	R1, #hi_addr(_ucRF4463Freq3+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,181 :: 		ucRF4463Freq2 = ucLongArgument[ 1 ] - 48;
ADDS	R1, R3, #1
LDRB	R1, [R1, #0]
SUBW	R2, R1, #48
MOVW	R1, #lo_addr(_ucRF4463Freq2+0)
MOVT	R1, #hi_addr(_ucRF4463Freq2+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,182 :: 		ucRF4463Freq1 = ucLongArgument[ 2 ] - 48;
ADDS	R1, R3, #2
LDRB	R1, [R1, #0]
SUBW	R2, R1, #48
MOVW	R1, #lo_addr(_ucRF4463Freq1+0)
MOVT	R1, #hi_addr(_ucRF4463Freq1+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,183 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,184 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,185 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor270
L_vRF4463MainCommandProcessor269:
;DriverRF4463PROMain.c,187 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,188 :: 		}
L_vRF4463MainCommandProcessor270:
;DriverRF4463PROMain.c,189 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor271
L_vRF4463MainCommandProcessor266:
;DriverRF4463PROMain.c,193 :: 		else if ( memcmp( CMD_RADIO_RATE_SET, ucCommand, sizeof( CMD_RADIO_RATE_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
ADD	R1, SP, #4
MOVS	R2, #9
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_RATE_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_RATE_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor272
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,194 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R1, SP, #36
MOV	R0, R1
BL	_StrToLong+0
; ulArgument start address is: 0 (R0)
;DriverRF4463PROMain.c,196 :: 		switch ( ulArgument ) {
IT	AL
BAL	L_vRF4463MainCommandProcessor273
; ulArgument end address is: 0 (R0)
;DriverRF4463PROMain.c,197 :: 		case 500      : ucRF4463Rate = dr_500;
L_vRF4463MainCommandProcessor275:
MOVS	R2, #10
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,198 :: 		defineTime = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_defineTime+0)
MOVT	R1, #hi_addr(_defineTime+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,199 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,200 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,201 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor274
;DriverRF4463PROMain.c,202 :: 		case 1200     : ucRF4463Rate = dr_1p2;
L_vRF4463MainCommandProcessor276:
MOVS	R2, #0
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,203 :: 		defineTime = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_defineTime+0)
MOVT	R1, #hi_addr(_defineTime+0)
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
BAL	L_vRF4463MainCommandProcessor274
;DriverRF4463PROMain.c,207 :: 		case 2400     : ucRF4463Rate = dr_2p4;
L_vRF4463MainCommandProcessor277:
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,208 :: 		defineTime = 2;
MOVS	R2, #2
MOVW	R1, #lo_addr(_defineTime+0)
MOVT	R1, #hi_addr(_defineTime+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,209 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,210 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,211 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor274
;DriverRF4463PROMain.c,212 :: 		case 4800     : ucRF4463Rate = dr_4p8;
L_vRF4463MainCommandProcessor278:
MOVS	R2, #2
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,213 :: 		defineTime = 3;
MOVS	R2, #3
MOVW	R1, #lo_addr(_defineTime+0)
MOVT	R1, #hi_addr(_defineTime+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,214 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,215 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,216 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor274
;DriverRF4463PROMain.c,217 :: 		case 9600     : ucRF4463Rate = dr_9p6;
L_vRF4463MainCommandProcessor279:
MOVS	R2, #3
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,218 :: 		defineTime = 4;
MOVS	R2, #4
MOVW	R1, #lo_addr(_defineTime+0)
MOVT	R1, #hi_addr(_defineTime+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,219 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,220 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,221 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor274
;DriverRF4463PROMain.c,222 :: 		case 19200    : ucRF4463Rate = dr_19p2;
L_vRF4463MainCommandProcessor280:
MOVS	R2, #4
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,223 :: 		defineTime = 5;
MOVS	R2, #5
MOVW	R1, #lo_addr(_defineTime+0)
MOVT	R1, #hi_addr(_defineTime+0)
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
BAL	L_vRF4463MainCommandProcessor274
;DriverRF4463PROMain.c,227 :: 		case 38400    : ucRF4463Rate = dr_38p4;
L_vRF4463MainCommandProcessor281:
MOVS	R2, #5
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,228 :: 		defineTime = 6;
MOVS	R2, #6
MOVW	R1, #lo_addr(_defineTime+0)
MOVT	R1, #hi_addr(_defineTime+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,229 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,230 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,231 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor274
;DriverRF4463PROMain.c,232 :: 		case 76800    : ucRF4463Rate = dr_76p8;
L_vRF4463MainCommandProcessor282:
MOVS	R2, #6
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,233 :: 		defineTime = 7;
MOVS	R2, #7
MOVW	R1, #lo_addr(_defineTime+0)
MOVT	R1, #hi_addr(_defineTime+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,234 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,235 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,236 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor274
;DriverRF4463PROMain.c,237 :: 		case 115200   : ucRF4463Rate = dr_115p2;
L_vRF4463MainCommandProcessor283:
MOVS	R2, #7
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,238 :: 		defineTime = 8;
MOVS	R2, #8
MOVW	R1, #lo_addr(_defineTime+0)
MOVT	R1, #hi_addr(_defineTime+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,239 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,240 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,241 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor274
;DriverRF4463PROMain.c,242 :: 		case 256000   : ucRF4463Rate = dr_256k;
L_vRF4463MainCommandProcessor284:
MOVS	R2, #8
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,243 :: 		defineTime = 8;
MOVS	R2, #8
MOVW	R1, #lo_addr(_defineTime+0)
MOVT	R1, #hi_addr(_defineTime+0)
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
BAL	L_vRF4463MainCommandProcessor274
;DriverRF4463PROMain.c,247 :: 		case 500000   : ucRF4463Rate = dr_500k;
L_vRF4463MainCommandProcessor285:
MOVS	R2, #9
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,248 :: 		defineTime = 8;
MOVS	R2, #8
MOVW	R1, #lo_addr(_defineTime+0)
MOVT	R1, #hi_addr(_defineTime+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,249 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,250 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,251 :: 		break;
IT	AL
BAL	L_vRF4463MainCommandProcessor274
;DriverRF4463PROMain.c,252 :: 		default       : vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
L_vRF4463MainCommandProcessor286:
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,253 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor274
L_vRF4463MainCommandProcessor273:
; ulArgument start address is: 0 (R0)
CMP	R0, #500
IT	EQ
BEQ	L_vRF4463MainCommandProcessor275
CMP	R0, #1200
IT	EQ
BEQ	L_vRF4463MainCommandProcessor276
CMP	R0, #2400
IT	EQ
BEQ	L_vRF4463MainCommandProcessor277
CMP	R0, #4800
IT	EQ
BEQ	L_vRF4463MainCommandProcessor278
CMP	R0, #9600
IT	EQ
BEQ	L_vRF4463MainCommandProcessor279
CMP	R0, #19200
IT	EQ
BEQ	L_vRF4463MainCommandProcessor280
CMP	R0, #38400
IT	EQ
BEQ	L_vRF4463MainCommandProcessor281
CMP	R0, #76800
IT	EQ
BEQ	L_vRF4463MainCommandProcessor282
CMP	R0, #115200
IT	EQ
BEQ	L_vRF4463MainCommandProcessor283
CMP	R0, #256000
IT	EQ
BEQ	L_vRF4463MainCommandProcessor284
MOVW	R1, #41248
MOVT	R1, #7
CMP	R0, R1
IT	EQ
BEQ	L_vRF4463MainCommandProcessor285
; ulArgument end address is: 0 (R0)
IT	AL
BAL	L_vRF4463MainCommandProcessor286
L_vRF4463MainCommandProcessor274:
;DriverRF4463PROMain.c,254 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor287
L_vRF4463MainCommandProcessor272:
;DriverRF4463PROMain.c,258 :: 		else if ( memcmp( CMD_RADIO_CHANNEL_SET, ucCommand, sizeof( CMD_RADIO_CHANNEL_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
ADD	R1, SP, #4
MOVS	R2, #12
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_CHANNEL_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_CHANNEL_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor288
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,259 :: 		ulArgument = StrToInt( ucLongArgument );
ADD	R1, SP, #36
MOV	R0, R1
BL	_StrToInt+0
; ulArgument start address is: 0 (R0)
;DriverRF4463PROMain.c,261 :: 		if ( ulArgument >= 0 && ulArgument <= 50 ) {
CMP	R0, #0
IT	CC
BCC	L__vRF4463MainCommandProcessor469
CMP	R0, #50
IT	HI
BHI	L__vRF4463MainCommandProcessor468
L__vRF4463MainCommandProcessor451:
;DriverRF4463PROMain.c,262 :: 		ucRF4463FreqChannel = ulArgument;    // Se aplica al ejecutar funciones de TX o RX
MOVW	R1, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R1, #hi_addr(_ucRF4463FreqChannel+0)
STRB	R0, [R1, #0]
; ulArgument end address is: 0 (R0)
;DriverRF4463PROMain.c,263 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,264 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,265 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor292
;DriverRF4463PROMain.c,261 :: 		if ( ulArgument >= 0 && ulArgument <= 50 ) {
L__vRF4463MainCommandProcessor469:
L__vRF4463MainCommandProcessor468:
;DriverRF4463PROMain.c,267 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,268 :: 		}
L_vRF4463MainCommandProcessor292:
;DriverRF4463PROMain.c,269 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor293
L_vRF4463MainCommandProcessor288:
;DriverRF4463PROMain.c,273 :: 		else if ( memcmp( CMD_RADIO_BW_SET, ucCommand, sizeof( CMD_RADIO_BW_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
ADD	R1, SP, #4
MOVS	R2, #7
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_BW_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_BW_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor294
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,274 :: 		ulArgument = StrToInt( ucLongArgument );
ADD	R1, SP, #36
MOV	R0, R1
BL	_StrToInt+0
; ulArgument start address is: 40 (R10)
SXTH	R10, R0
;DriverRF4463PROMain.c,276 :: 		if ( ulArgument == 250 || ulArgument == 500 ) {
CMP	R10, #250
IT	EQ
BEQ	L__vRF4463MainCommandProcessor471
CMP	R10, #500
IT	EQ
BEQ	L__vRF4463MainCommandProcessor470
; ulArgument end address is: 40 (R10)
IT	AL
BAL	L_vRF4463MainCommandProcessor297
L__vRF4463MainCommandProcessor471:
; ulArgument start address is: 40 (R10)
L__vRF4463MainCommandProcessor470:
;DriverRF4463PROMain.c,277 :: 		ulRF4463Step = ulArgument;
MOVW	R1, #lo_addr(_ulRF4463Step+0)
MOVT	R1, #hi_addr(_ulRF4463Step+0)
STR	R10, [R1, #0]
; ulArgument end address is: 40 (R10)
;DriverRF4463PROMain.c,278 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,279 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,280 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor298
L_vRF4463MainCommandProcessor297:
;DriverRF4463PROMain.c,282 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,283 :: 		}
L_vRF4463MainCommandProcessor298:
;DriverRF4463PROMain.c,284 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor299
L_vRF4463MainCommandProcessor294:
;DriverRF4463PROMain.c,291 :: 		else if ( memcmp( CMD_RADIO_MODE_SET, ucCommand, sizeof( CMD_RADIO_MODE_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
ADD	R1, SP, #4
MOVS	R2, #9
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_MODE_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MODE_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor300
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,293 :: 		ucCounterCommand = 0;
; ucCounterCommand start address is: 12 (R3)
MOVS	R3, #0
; ucCounterCommand end address is: 12 (R3)
;DriverRF4463PROMain.c,295 :: 		while ( ucLongArgument[ ucCounterCommand ] != ucUSARTNull && ucCounterCommand < 32 ) {
L_vRF4463MainCommandProcessor301:
; ucCounterCommand start address is: 12 (R3)
ADD	R1, SP, #36
ADDS	R1, R1, R3
LDRB	R2, [R1, #0]
MOVW	R1, #lo_addr(_ucUSARTNull+0)
MOVT	R1, #hi_addr(_ucUSARTNull+0)
LDRB	R1, [R1, #0]
CMP	R2, R1
IT	EQ
BEQ	L__vRF4463MainCommandProcessor473
CMP	R3, #32
IT	CS
BCS	L__vRF4463MainCommandProcessor472
L__vRF4463MainCommandProcessor449:
;DriverRF4463PROMain.c,296 :: 		ucLongArgument[ ucCounterCommand ] = toupper( ucLongArgument[ ucCounterCommand ] );
ADD	R1, SP, #36
ADDS	R1, R1, R3
STR	R1, [SP, #100]
LDRB	R1, [R1, #0]
UXTB	R0, R1
BL	_toupper+0
LDR	R1, [SP, #100]
STRB	R0, [R1, #0]
;DriverRF4463PROMain.c,297 :: 		ucCounterCommand++;
ADDS	R3, R3, #1
UXTB	R3, R3
;DriverRF4463PROMain.c,298 :: 		}
; ucCounterCommand end address is: 12 (R3)
IT	AL
BAL	L_vRF4463MainCommandProcessor301
;DriverRF4463PROMain.c,295 :: 		while ( ucLongArgument[ ucCounterCommand ] != ucUSARTNull && ucCounterCommand < 32 ) {
L__vRF4463MainCommandProcessor473:
L__vRF4463MainCommandProcessor472:
;DriverRF4463PROMain.c,301 :: 		if ( memcmp( ARG_RADIO_MODE_STBY, ucLongArgument, sizeof( ARG_RADIO_MODE_STBY ) ) == 0x00 ) {
ADD	R1, SP, #36
MOVS	R2, #5
SXTH	R2, R2
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_STBY+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_STBY+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor305
;DriverRF4463PROMain.c,302 :: 		ucRF4463Mode = rf_off;
MOVS	R2, #4
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,303 :: 		vUSART1Start_TX( ANS_COMMAND_MODE_STBY, strlen( ANS_COMMAND_MODE_STBY ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_STBY+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_STBY+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_STBY+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_STBY+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,304 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor306
L_vRF4463MainCommandProcessor305:
;DriverRF4463PROMain.c,305 :: 		else if ( memcmp( ARG_RADIO_MODE_TX_CONT, ucLongArgument, sizeof( ARG_RADIO_MODE_TX_CONT ) ) == 0x00 ) {
ADD	R1, SP, #36
MOVS	R2, #8
SXTH	R2, R2
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_TX_CONT+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_TX_CONT+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor307
;DriverRF4463PROMain.c,306 :: 		ucRF4463Mode = tx_test_mode;
MOVS	R2, #2
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,307 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,308 :: 		vUSART1Start_TX( ANS_COMMAND_MODE_TX_CONT, strlen( ANS_COMMAND_MODE_TX_CONT ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_CONT+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_CONT+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,309 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor308
L_vRF4463MainCommandProcessor307:
;DriverRF4463PROMain.c,310 :: 		else if ( memcmp( ARG_RADIO_MODE_RX_CONT, ucLongArgument, sizeof( ARG_RADIO_MODE_RX_CONT ) ) == 0x00 ) {
ADD	R1, SP, #36
MOVS	R2, #8
SXTH	R2, R2
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_RX_CONT+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_RX_CONT+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor309
;DriverRF4463PROMain.c,311 :: 		ucRF4463Mode = rx_test_mode;
MOVS	R2, #3
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,312 :: 		vUSART1Start_TX( ANS_COMMAND_MODE_RX_CONT, strlen( ANS_COMMAND_MODE_RX_CONT ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_CONT+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_CONT+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,313 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor310
L_vRF4463MainCommandProcessor309:
;DriverRF4463PROMain.c,314 :: 		else if ( memcmp( ARG_RADIO_MODE_TX_MASTER, ucLongArgument, sizeof( ARG_RADIO_MODE_TX_MASTER ) ) == 0x00 ) {
ADD	R1, SP, #36
MOVS	R2, #10
SXTH	R2, R2
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_TX_MASTER+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_TX_MASTER+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor311
;DriverRF4463PROMain.c,315 :: 		ucRF4463Mode = master_mode;
MOVS	R2, #0
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,316 :: 		vUSART1Start_TX( ANS_COMMAND_MODE_TX_MASTER, strlen( ANS_COMMAND_MODE_TX_MASTER ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,317 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor312
L_vRF4463MainCommandProcessor311:
;DriverRF4463PROMain.c,318 :: 		else if ( memcmp( ARG_RADIO_MODE_RX_SLAVE, ucLongArgument, sizeof( ARG_RADIO_MODE_RX_SLAVE ) ) == 0x00 ) {
ADD	R1, SP, #36
MOVS	R2, #9
SXTH	R2, R2
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_RX_SLAVE+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_RX_SLAVE+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor313
;DriverRF4463PROMain.c,319 :: 		ucRF4463Mode = slave_mode;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,320 :: 		vUSART1Start_TX( ANS_COMMAND_MODE_RX_SLAVE, strlen( ANS_COMMAND_MODE_RX_SLAVE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,321 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor314
L_vRF4463MainCommandProcessor313:
;DriverRF4463PROMain.c,323 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,324 :: 		}
L_vRF4463MainCommandProcessor314:
L_vRF4463MainCommandProcessor312:
L_vRF4463MainCommandProcessor310:
L_vRF4463MainCommandProcessor308:
L_vRF4463MainCommandProcessor306:
;DriverRF4463PROMain.c,325 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor315
L_vRF4463MainCommandProcessor300:
;DriverRF4463PROMain.c,330 :: 		else if ( memcmp( CMD_RADIO_PACKET_SEND, ucCommand, sizeof( CMD_RADIO_PACKET_SEND ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
ADD	R1, SP, #4
MOVS	R2, #12
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_PACKET_SEND+0)
MOVT	R0, #hi_addr(_CMD_RADIO_PACKET_SEND+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor316
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,334 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R1, SP, #36
MOV	R0, R1
BL	_StrToLong+0
;DriverRF4463PROMain.c,336 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,338 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor317
L_vRF4463MainCommandProcessor316:
;DriverRF4463PROMain.c,343 :: 		else if ( memcmp( CMD_RADIO_MATCH_BYTE_1_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_1_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
ADD	R1, SP, #4
MOVS	R2, #12
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_BYTE_1_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_BYTE_1_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor318
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,344 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R1, SP, #36
MOV	R0, R1
BL	_StrToLong+0
; ulArgument start address is: 8 (R2)
MOV	R2, R0
;DriverRF4463PROMain.c,345 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BCC	L__vRF4463MainCommandProcessor475
CMP	R2, #255
IT	HI
BHI	L__vRF4463MainCommandProcessor474
L__vRF4463MainCommandProcessor448:
;DriverRF4463PROMain.c,346 :: 		ucRF4463ByteMatch1 = ulArgument;
MOVW	R1, #lo_addr(_ucRF4463ByteMatch1+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMatch1+0)
STRB	R2, [R1, #0]
; ulArgument end address is: 8 (R2)
;DriverRF4463PROMain.c,347 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,348 :: 		ucRF4463MatchEnableReg = 0x40;
MOVS	R2, #64
MOVW	R1, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,349 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,350 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,351 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor322
;DriverRF4463PROMain.c,345 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor475:
L__vRF4463MainCommandProcessor474:
;DriverRF4463PROMain.c,353 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,354 :: 		}
L_vRF4463MainCommandProcessor322:
;DriverRF4463PROMain.c,355 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor323
L_vRF4463MainCommandProcessor318:
;DriverRF4463PROMain.c,359 :: 		else if ( memcmp( CMD_RADIO_MATCH_BYTE_2_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_2_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
ADD	R1, SP, #4
MOVS	R2, #12
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_BYTE_2_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_BYTE_2_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor324
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,360 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R1, SP, #36
MOV	R0, R1
BL	_StrToLong+0
; ulArgument start address is: 8 (R2)
MOV	R2, R0
;DriverRF4463PROMain.c,361 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BCC	L__vRF4463MainCommandProcessor477
CMP	R2, #255
IT	HI
BHI	L__vRF4463MainCommandProcessor476
L__vRF4463MainCommandProcessor447:
;DriverRF4463PROMain.c,362 :: 		ucRF4463ByteMatch2 = ulArgument;
MOVW	R1, #lo_addr(_ucRF4463ByteMatch2+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMatch2+0)
STRB	R2, [R1, #0]
; ulArgument end address is: 8 (R2)
;DriverRF4463PROMain.c,363 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,364 :: 		ucRF4463MatchEnableReg = 0x40;
MOVS	R2, #64
MOVW	R1, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,365 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,366 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,367 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor328
;DriverRF4463PROMain.c,361 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor477:
L__vRF4463MainCommandProcessor476:
;DriverRF4463PROMain.c,369 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,370 :: 		}
L_vRF4463MainCommandProcessor328:
;DriverRF4463PROMain.c,371 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor329
L_vRF4463MainCommandProcessor324:
;DriverRF4463PROMain.c,375 :: 		else if ( memcmp( CMD_RADIO_MATCH_BYTE_3_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_3_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
ADD	R1, SP, #4
MOVS	R2, #12
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_BYTE_3_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_BYTE_3_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor330
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,376 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R1, SP, #36
MOV	R0, R1
BL	_StrToLong+0
; ulArgument start address is: 8 (R2)
MOV	R2, R0
;DriverRF4463PROMain.c,377 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BCC	L__vRF4463MainCommandProcessor479
CMP	R2, #255
IT	HI
BHI	L__vRF4463MainCommandProcessor478
L__vRF4463MainCommandProcessor446:
;DriverRF4463PROMain.c,378 :: 		ucRF4463ByteMatch3 = ulArgument;
MOVW	R1, #lo_addr(_ucRF4463ByteMatch3+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMatch3+0)
STRB	R2, [R1, #0]
; ulArgument end address is: 8 (R2)
;DriverRF4463PROMain.c,379 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,380 :: 		ucRF4463MatchEnableReg = 0x40;
MOVS	R2, #64
MOVW	R1, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,381 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,382 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,383 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor334
;DriverRF4463PROMain.c,377 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor479:
L__vRF4463MainCommandProcessor478:
;DriverRF4463PROMain.c,385 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,386 :: 		}
L_vRF4463MainCommandProcessor334:
;DriverRF4463PROMain.c,387 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor335
L_vRF4463MainCommandProcessor330:
;DriverRF4463PROMain.c,391 :: 		else if ( memcmp( CMD_RADIO_MATCH_BYTE_4_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_4_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
ADD	R1, SP, #4
MOVS	R2, #12
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_BYTE_4_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_BYTE_4_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor336
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,392 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R1, SP, #36
MOV	R0, R1
BL	_StrToLong+0
; ulArgument start address is: 8 (R2)
MOV	R2, R0
;DriverRF4463PROMain.c,393 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BCC	L__vRF4463MainCommandProcessor481
CMP	R2, #255
IT	HI
BHI	L__vRF4463MainCommandProcessor480
L__vRF4463MainCommandProcessor445:
;DriverRF4463PROMain.c,394 :: 		ucRF4463ByteMatch4 = ulArgument;
MOVW	R1, #lo_addr(_ucRF4463ByteMatch4+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMatch4+0)
STRB	R2, [R1, #0]
; ulArgument end address is: 8 (R2)
;DriverRF4463PROMain.c,395 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,396 :: 		ucRF4463MatchEnableReg = 0x40;
MOVS	R2, #64
MOVW	R1, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,397 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,398 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,399 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor340
;DriverRF4463PROMain.c,393 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor481:
L__vRF4463MainCommandProcessor480:
;DriverRF4463PROMain.c,401 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,402 :: 		}
L_vRF4463MainCommandProcessor340:
;DriverRF4463PROMain.c,403 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor341
L_vRF4463MainCommandProcessor336:
;DriverRF4463PROMain.c,407 :: 		else if ( memcmp( CMD_RADIO_MATCH_MASK_1_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_1_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
ADD	R1, SP, #4
MOVS	R2, #11
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_MASK_1_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_MASK_1_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor342
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,408 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R1, SP, #36
MOV	R0, R1
BL	_StrToLong+0
; ulArgument start address is: 8 (R2)
MOV	R2, R0
;DriverRF4463PROMain.c,409 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BCC	L__vRF4463MainCommandProcessor483
CMP	R2, #255
IT	HI
BHI	L__vRF4463MainCommandProcessor482
L__vRF4463MainCommandProcessor444:
;DriverRF4463PROMain.c,410 :: 		ucRF4463ByteMask1 = ulArgument;
MOVW	R1, #lo_addr(_ucRF4463ByteMask1+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMask1+0)
STRB	R2, [R1, #0]
; ulArgument end address is: 8 (R2)
;DriverRF4463PROMain.c,411 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,412 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,413 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,414 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor346
;DriverRF4463PROMain.c,409 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor483:
L__vRF4463MainCommandProcessor482:
;DriverRF4463PROMain.c,416 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,417 :: 		}
L_vRF4463MainCommandProcessor346:
;DriverRF4463PROMain.c,418 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor347
L_vRF4463MainCommandProcessor342:
;DriverRF4463PROMain.c,422 :: 		else if ( memcmp( CMD_RADIO_MATCH_MASK_2_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_2_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
ADD	R1, SP, #4
MOVS	R2, #11
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_MASK_2_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_MASK_2_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor348
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,423 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R1, SP, #36
MOV	R0, R1
BL	_StrToLong+0
; ulArgument start address is: 8 (R2)
MOV	R2, R0
;DriverRF4463PROMain.c,424 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BCC	L__vRF4463MainCommandProcessor485
CMP	R2, #255
IT	HI
BHI	L__vRF4463MainCommandProcessor484
L__vRF4463MainCommandProcessor443:
;DriverRF4463PROMain.c,425 :: 		ucRF4463ByteMask2 = ulArgument;
MOVW	R1, #lo_addr(_ucRF4463ByteMask2+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMask2+0)
STRB	R2, [R1, #0]
; ulArgument end address is: 8 (R2)
;DriverRF4463PROMain.c,426 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,427 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,428 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,429 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor352
;DriverRF4463PROMain.c,424 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor485:
L__vRF4463MainCommandProcessor484:
;DriverRF4463PROMain.c,431 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,432 :: 		}
L_vRF4463MainCommandProcessor352:
;DriverRF4463PROMain.c,433 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor353
L_vRF4463MainCommandProcessor348:
;DriverRF4463PROMain.c,437 :: 		else if ( memcmp( CMD_RADIO_MATCH_MASK_3_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_3_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
ADD	R1, SP, #4
MOVS	R2, #11
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_MASK_3_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_MASK_3_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor354
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,438 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R1, SP, #36
MOV	R0, R1
BL	_StrToLong+0
; ulArgument start address is: 8 (R2)
MOV	R2, R0
;DriverRF4463PROMain.c,439 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BCC	L__vRF4463MainCommandProcessor487
CMP	R2, #255
IT	HI
BHI	L__vRF4463MainCommandProcessor486
L__vRF4463MainCommandProcessor442:
;DriverRF4463PROMain.c,440 :: 		ucRF4463ByteMask3 = ulArgument;
MOVW	R1, #lo_addr(_ucRF4463ByteMask3+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMask3+0)
STRB	R2, [R1, #0]
; ulArgument end address is: 8 (R2)
;DriverRF4463PROMain.c,441 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,442 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,443 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,444 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor358
;DriverRF4463PROMain.c,439 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor487:
L__vRF4463MainCommandProcessor486:
;DriverRF4463PROMain.c,446 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,447 :: 		}
L_vRF4463MainCommandProcessor358:
;DriverRF4463PROMain.c,448 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor359
L_vRF4463MainCommandProcessor354:
;DriverRF4463PROMain.c,452 :: 		else if ( memcmp( CMD_RADIO_MATCH_MASK_4_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_4_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
ADD	R1, SP, #4
MOVS	R2, #11
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_MASK_4_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_MASK_4_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor360
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,453 :: 		ulArgument = StrToLong( ucLongArgument );
ADD	R1, SP, #36
MOV	R0, R1
BL	_StrToLong+0
; ulArgument start address is: 8 (R2)
MOV	R2, R0
;DriverRF4463PROMain.c,454 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BCC	L__vRF4463MainCommandProcessor489
CMP	R2, #255
IT	HI
BHI	L__vRF4463MainCommandProcessor488
L__vRF4463MainCommandProcessor441:
;DriverRF4463PROMain.c,455 :: 		ucRF4463ByteMask4 = ulArgument;
MOVW	R1, #lo_addr(_ucRF4463ByteMask4+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMask4+0)
STRB	R2, [R1, #0]
; ulArgument end address is: 8 (R2)
;DriverRF4463PROMain.c,456 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,457 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,458 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,459 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor364
;DriverRF4463PROMain.c,454 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor489:
L__vRF4463MainCommandProcessor488:
;DriverRF4463PROMain.c,461 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,462 :: 		}
L_vRF4463MainCommandProcessor364:
;DriverRF4463PROMain.c,463 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor365
L_vRF4463MainCommandProcessor360:
;DriverRF4463PROMain.c,467 :: 		else if ( memcmp( CMD_RADIO_MATCH_UNSET, ucCommand, sizeof( CMD_RADIO_MATCH_UNSET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
ADD	R1, SP, #4
MOVS	R2, #12
SXTH	R2, R2
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_UNSET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_UNSET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463MainCommandProcessor366
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,469 :: 		ucRF4463MatchEnableReg = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,470 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,471 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,476 :: 		}
IT	AL
BAL	L_vRF4463MainCommandProcessor367
L_vRF4463MainCommandProcessor366:
;DriverRF4463PROMain.c,480 :: 		vUSART1Start_TX( ANS_DEBUG_COMMAND_UNKNOWN, strlen( ANS_DEBUG_COMMAND_UNKNOWN ) );
; ucBuffer start address is: 20 (R5)
MOVW	R0, #lo_addr(_ANS_DEBUG_COMMAND_UNKNOWN+0)
MOVT	R0, #hi_addr(_ANS_DEBUG_COMMAND_UNKNOWN+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_DEBUG_COMMAND_UNKNOWN+0)
MOVT	R0, #hi_addr(_ANS_DEBUG_COMMAND_UNKNOWN+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,481 :: 		vUSART1Start_TX( ucBuffer, strlen( ucBuffer ) );  // DEPURACION
MOV	R0, R5
BL	_strlen+0
SXTH	R1, R0
MOV	R0, R5
; ucBuffer end address is: 20 (R5)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,482 :: 		}
L_vRF4463MainCommandProcessor367:
L_vRF4463MainCommandProcessor365:
L_vRF4463MainCommandProcessor359:
L_vRF4463MainCommandProcessor353:
L_vRF4463MainCommandProcessor347:
L_vRF4463MainCommandProcessor341:
L_vRF4463MainCommandProcessor335:
L_vRF4463MainCommandProcessor329:
L_vRF4463MainCommandProcessor323:
L_vRF4463MainCommandProcessor317:
L_vRF4463MainCommandProcessor315:
L_vRF4463MainCommandProcessor299:
L_vRF4463MainCommandProcessor293:
L_vRF4463MainCommandProcessor287:
L_vRF4463MainCommandProcessor271:
L_vRF4463MainCommandProcessor265:
;DriverRF4463PROMain.c,483 :: 		}
L_end_vRF4463MainCommandProcessor:
LDR	LR, [SP, #0]
ADD	SP, SP, #104
BX	LR
; end of _vRF4463MainCommandProcessor
_InitTimer2:
;DriverRF4463PROMain.c,489 :: 		void InitTimer2(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;DriverRF4463PROMain.c,491 :: 		RCC_APB1ENR.TIM2EN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
_SX	[R0, ByteOffset(RCC_APB1ENR+0)]
;DriverRF4463PROMain.c,492 :: 		TIM2_CR1.CEN = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
_SX	[R0, ByteOffset(TIM2_CR1+0)]
;DriverRF4463PROMain.c,496 :: 		TIM2_PSC = 674;
MOVW	R1, #674
MOVW	R0, #lo_addr(TIM2_PSC+0)
MOVT	R0, #hi_addr(TIM2_PSC+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,497 :: 		TIM2_ARR = 63999;
MOVW	R1, #63999
MOVW	R0, #lo_addr(TIM2_ARR+0)
MOVT	R0, #hi_addr(TIM2_ARR+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,501 :: 		NVIC_IntEnable( IVT_INT_TIM2 );
MOVW	R0, #44
BL	_NVIC_IntEnable+0
;DriverRF4463PROMain.c,502 :: 		TIM2_DIER.UIE = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
_SX	[R0, ByteOffset(TIM2_DIER+0)]
;DriverRF4463PROMain.c,503 :: 		TIM2_CR1.CEN = 1;
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
_SX	[R0, ByteOffset(TIM2_CR1+0)]
;DriverRF4463PROMain.c,515 :: 		}
L_end_InitTimer2:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _InitTimer2
_main:
;DriverRF4463PROMain.c,519 :: 		void main() {
SUB	SP, SP, #112
;DriverRF4463PROMain.c,523 :: 		Delay_ms( 2000 );                    // delay de depuracion
MOVW	R7, #13823
MOVT	R7, #366
NOP
NOP
L_main368:
SUBS	R7, R7, #1
BNE	L_main368
NOP
NOP
NOP
;DriverRF4463PROMain.c,528 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_6 );
MOVW	R1, #64
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,529 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_7 );
MOVW	R1, #128
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,530 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_8 );
MOVW	R1, #256
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,535 :: 		GPIO_Digital_Input( &GPIOC_BASE, _GPIO_PINMASK_12 );          // nIRQ
MOVW	R1, #4096
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Input+0
;DriverRF4463PROMain.c,537 :: 		GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_12 );         // nSEL
MOVW	R1, #4096
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,538 :: 		GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_11 );         // SDN
MOVW	R1, #2048
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,539 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_11 );         // GPIO0
MOVW	R1, #2048
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,540 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_10 );         // GPIO1
MOVW	R1, #1024
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,545 :: 		RCC_APB2ENRbits.AFIOEN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB2ENRbits+0)
MOVT	R0, #hi_addr(RCC_APB2ENRbits+0)
_SX	[R0, ByteOffset(RCC_APB2ENRbits+0)]
;DriverRF4463PROMain.c,549 :: 		AFIO_EXTICR4  |= 0x0002;
MOVW	R0, #lo_addr(AFIO_EXTICR4+0)
MOVT	R0, #hi_addr(AFIO_EXTICR4+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #2
MOVW	R0, #lo_addr(AFIO_EXTICR4+0)
MOVT	R0, #hi_addr(AFIO_EXTICR4+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,553 :: 		EXTI_IMR.B12    |= 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
_SX	[R0, ByteOffset(EXTI_IMR+0)]
;DriverRF4463PROMain.c,554 :: 		EXTI_FTSR.B12   |= 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
_SX	[R0, ByteOffset(EXTI_FTSR+0)]
;DriverRF4463PROMain.c,556 :: 		GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_7 );
MOVW	R1, #128
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,557 :: 		Sound_Init( &GPIOB_ODR, 7 );
MOVS	R1, #7
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
BL	_Sound_Init+0
;DriverRF4463PROMain.c,558 :: 		Sound_Play( 1000, 100 );
MOVS	R1, #100
MOVW	R0, #1000
BL	_Sound_Play+0
;DriverRF4463PROMain.c,678 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;DriverRF4463PROMain.c,680 :: 		LED_RED      = 1;
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,681 :: 		LED_GREEN    = 1;
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,682 :: 		LED_BLUE     = 1;
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,684 :: 		Delay_ms( 100 );
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_main370:
SUBS	R7, R7, #1
BNE	L_main370
NOP
NOP
NOP
;DriverRF4463PROMain.c,686 :: 		LED_RED      = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,687 :: 		LED_GREEN    = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,688 :: 		LED_BLUE     = 0;
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,690 :: 		InitTimer2();
BL	_InitTimer2+0
;DriverRF4463PROMain.c,693 :: 		vUSARTConfigUSART1( 115200 );  // configura todos las parametros de USART
MOV	R0, #115200
BL	_vUSARTConfigUSART1+0
;DriverRF4463PROMain.c,697 :: 		vSPI2Init();           // configura todos los parametros de SPI
BL	_vSPI2Init+0
;DriverRF4463PROMain.c,715 :: 		ucRF4463Freq3 = 9;
MOVS	R1, #9
MOVW	R0, #lo_addr(_ucRF4463Freq3+0)
MOVT	R0, #hi_addr(_ucRF4463Freq3+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,716 :: 		ucRF4463Freq2 = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463Freq2+0)
MOVT	R0, #hi_addr(_ucRF4463Freq2+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,717 :: 		ucRF4463Freq1 = 5;
MOVS	R1, #5
MOVW	R0, #lo_addr(_ucRF4463Freq1+0)
MOVT	R0, #hi_addr(_ucRF4463Freq1+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,720 :: 		ucRF4463Power = 127;            // 34
MOVS	R1, #127
MOVW	R0, #lo_addr(_ucRF4463Power+0)
MOVT	R0, #hi_addr(_ucRF4463Power+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,722 :: 		ucRF4463Rate  = dr_2p4;                // BAUDRATE
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,725 :: 		ucRF4463Mode  = master_mode;          // para transmision continua usar: tx_test_mode
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,727 :: 		ucRF4463FreqChannel = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,731 :: 		reset_mode = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_reset_mode+0)
MOVT	R0, #hi_addr(_reset_mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,736 :: 		vRF4463MainSetTXString();    // usada para establecer el encabezdo predeterminado
BL	_vRF4463MainSetTXString+0
;DriverRF4463PROMain.c,737 :: 		VRF4463SDNReset();
BL	_VRF4463SDNReset+0
;DriverRF4463PROMain.c,738 :: 		vRF4463Init();
BL	_vRF4463Init+0
;DriverRF4463PROMain.c,739 :: 		vRF4463ClearInterrupts();
BL	_vRF4463ClearInterrupts+0
;DriverRF4463PROMain.c,740 :: 		vRF4463PartInfo ();          // SOLICITA EL MODELO DEL RADIO
BL	_vRF4463PartInfo+0
;DriverRF4463PROMain.c,742 :: 		LED_GREEN    = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,743 :: 		LED_BLUE     = 0;
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,748 :: 		vUSART1Start_TX( "[ SYS STM32F ]RF Radio ready\r\n", 30 );   // enviado por DMA
ADD	R11, SP, #6
ADD	R10, R11, #31
MOVW	R12, #lo_addr(?ICS?lstr3_DriverRF4463PROMain+0)
MOVT	R12, #hi_addr(?ICS?lstr3_DriverRF4463PROMain+0)
BL	___CC2DW+0
ADD	R0, SP, #6
MOVS	R1, #30
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,753 :: 		if ( ucRF4463Mode == master_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main372
;DriverRF4463PROMain.c,754 :: 		UART1_Write_Text("[ Mode ] = Master\n\r");
ADD	R11, SP, #37
ADD	R10, R11, #20
MOVW	R12, #lo_addr(?ICS?lstr4_DriverRF4463PROMain+0)
MOVT	R12, #hi_addr(?ICS?lstr4_DriverRF4463PROMain+0)
BL	___CC2DW+0
ADD	R0, SP, #37
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,756 :: 		}
IT	AL
BAL	L_main373
L_main372:
;DriverRF4463PROMain.c,759 :: 		else if ( ucRF4463Mode == slave_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main374
;DriverRF4463PROMain.c,760 :: 		UART1_Write_Text("[ Mode ] = Slave\n\r");
ADD	R11, SP, #57
ADD	R10, R11, #19
MOVW	R12, #lo_addr(?ICS?lstr5_DriverRF4463PROMain+0)
MOVT	R12, #hi_addr(?ICS?lstr5_DriverRF4463PROMain+0)
BL	___CC2DW+0
ADD	R0, SP, #57
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,761 :: 		}
L_main374:
L_main373:
;DriverRF4463PROMain.c,763 :: 		while ( 1 ) {
L_main375:
;DriverRF4463PROMain.c,766 :: 		if ( fUSART1Buffer == READY_TO_READ ) {
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main377
;DriverRF4463PROMain.c,767 :: 		vUSARTReceivedFromUSART1();
BL	_vUSARTReceivedFromUSART1+0
;DriverRF4463PROMain.c,768 :: 		}
L_main377:
;DriverRF4463PROMain.c,779 :: 		if ( ucRF4463Mode == master_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main378
;DriverRF4463PROMain.c,780 :: 		vRF4463TxData();
BL	_vRF4463TxData+0
;DriverRF4463PROMain.c,781 :: 		}
IT	AL
BAL	L_main379
L_main378:
;DriverRF4463PROMain.c,784 :: 		else if ( ucRF4463Mode == slave_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main380
;DriverRF4463PROMain.c,785 :: 		vRF4463RxInit();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,786 :: 		}
IT	AL
BAL	L_main381
L_main380:
;DriverRF4463PROMain.c,789 :: 		else if ( ucRF4463Mode == rf_off ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_main382
;DriverRF4463PROMain.c,790 :: 		vRF4463RxInit();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,791 :: 		}
L_main382:
L_main381:
L_main379:
;DriverRF4463PROMain.c,794 :: 		if ( ucRF4463Mode == tx_test_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_main383
;DriverRF4463PROMain.c,795 :: 		vRF4463TxCont();
BL	_vRF4463TxCont+0
;DriverRF4463PROMain.c,796 :: 		while ( 1 ) {
L_main384:
;DriverRF4463PROMain.c,798 :: 		if ( fUSART1Buffer == READY_TO_READ ) {
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main386
;DriverRF4463PROMain.c,799 :: 		break;
IT	AL
BAL	L_main385
;DriverRF4463PROMain.c,800 :: 		}
L_main386:
;DriverRF4463PROMain.c,802 :: 		if ( !nIRQ ) {
MOVW	R0, #lo_addr(GPIOC_IDRbits+0)
MOVT	R0, #hi_addr(GPIOC_IDRbits+0)
_LX	[R0, ByteOffset(GPIOC_IDRbits+0)]
CMP	R0, #0
IT	NE
BNE	L_main387
;DriverRF4463PROMain.c,803 :: 		vRF4463TxCont();
BL	_vRF4463TxCont+0
;DriverRF4463PROMain.c,804 :: 		}
L_main387:
;DriverRF4463PROMain.c,805 :: 		}
IT	AL
BAL	L_main384
L_main385:
;DriverRF4463PROMain.c,806 :: 		}
L_main383:
;DriverRF4463PROMain.c,808 :: 		if ( ucRF4463Mode == rx_test_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BNE	L_main388
;DriverRF4463PROMain.c,809 :: 		vRF4463RxInit ();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,810 :: 		while ( 1 ) {
L_main389:
;DriverRF4463PROMain.c,812 :: 		if ( fUSART1Buffer == READY_TO_READ ) {
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main391
;DriverRF4463PROMain.c,813 :: 		break;
IT	AL
BAL	L_main390
;DriverRF4463PROMain.c,814 :: 		}
L_main391:
;DriverRF4463PROMain.c,817 :: 		}
IT	AL
BAL	L_main389
L_main390:
;DriverRF4463PROMain.c,818 :: 		}
L_main388:
;DriverRF4463PROMain.c,820 :: 		if ( reset_mode == 0 ) {
MOVW	R0, #lo_addr(_reset_mode+0)
MOVT	R0, #hi_addr(_reset_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main392
;DriverRF4463PROMain.c,822 :: 		while ( 1 ) {
L_main393:
;DriverRF4463PROMain.c,824 :: 		if ( fUSART1Buffer == READY_TO_READ ) {
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main395
;DriverRF4463PROMain.c,825 :: 		break;
IT	AL
BAL	L_main394
;DriverRF4463PROMain.c,826 :: 		}
L_main395:
;DriverRF4463PROMain.c,828 :: 		if ( Flag.reach_1s ) {
MOVW	R1, #lo_addr(_Flag+0)
MOVT	R1, #hi_addr(_Flag+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main396
;DriverRF4463PROMain.c,829 :: 		Flag.reach_1s = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,830 :: 		if ( ucRF4463Mode == master_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main397
;DriverRF4463PROMain.c,831 :: 		vRF4463TxData();
BL	_vRF4463TxData+0
;DriverRF4463PROMain.c,832 :: 		}
L_main397:
;DriverRF4463PROMain.c,833 :: 		}
L_main396:
;DriverRF4463PROMain.c,836 :: 		if ( !Flag.is_tx ) {
MOVW	R1, #lo_addr(_Flag+0)
MOVT	R1, #hi_addr(_Flag+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_main398
;DriverRF4463PROMain.c,837 :: 		if ( !nIRQ ) {          // !nIRQ
MOVW	R0, #lo_addr(GPIOC_IDRbits+0)
MOVT	R0, #hi_addr(GPIOC_IDRbits+0)
_LX	[R0, ByteOffset(GPIOC_IDRbits+0)]
CMP	R0, #0
IT	NE
BNE	L_main399
;DriverRF4463PROMain.c,838 :: 		spi_read(9,0x22);  // aqui hay que leer  el RSSI
MOVS	R1, #34
MOVS	R0, #9
BL	_spi_read+0
;DriverRF4463PROMain.c,839 :: 		iVal = ( float ) spi_read_buf[3];
MOVW	R0, #lo_addr(_spi_read_buf+3)
MOVT	R0, #hi_addr(_spi_read_buf+3)
LDRB	R0, [R0, #0]
BL	__UnsignedIntegralToFloat+0
MOVW	R1, #lo_addr(_iVal+0)
MOVT	R1, #hi_addr(_iVal+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,840 :: 		rssi = ((iVal / 2) - 64) -70;
MOV	R2, #1073741824
BL	__Div_FP+0
MOV	R2, #1115684864
BL	__Sub_FP+0
MOVW	R2, #0
MOVT	R2, #17036
BL	__Sub_FP+0
MOVW	R1, #lo_addr(_rssi+0)
MOVT	R1, #hi_addr(_rssi+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,841 :: 		vRF4463ClearInterrupts();
BL	_vRF4463ClearInterrupts+0
;DriverRF4463PROMain.c,845 :: 		if ( ( spi_read_buf[ 4 ] & 0x08) == 0 ) { // crc error check
MOVW	R0, #lo_addr(_spi_read_buf+4)
MOVT	R0, #hi_addr(_spi_read_buf+4)
LDRB	R0, [R0, #0]
AND	R0, R0, #8
UXTB	R0, R0
CMP	R0, #0
IT	NE
BNE	L_main400
;DriverRF4463PROMain.c,849 :: 		spi_read_fifo();
BL	_spi_read_fifo+0
;DriverRF4463PROMain.c,850 :: 		vRF4463FifoReset();
BL	_vRF4463FifoReset+0
;DriverRF4463PROMain.c,852 :: 		chksum = 0;
MOVS	R0, #0
STRB	R0, [SP, #5]
;DriverRF4463PROMain.c,853 :: 		for ( i = 4; i < payload_length - 1; i++ )                // Calculation Checksum
MOVS	R0, #4
STRB	R0, [SP, #4]
L_main401:
LDRB	R0, [SP, #4]
CMP	R0, #65
IT	GE
BGE	L_main402
;DriverRF4463PROMain.c,854 :: 		chksum += rx_buf[ i ];
LDRB	R1, [SP, #4]
MOVW	R0, #lo_addr(_rx_buf+0)
MOVT	R0, #hi_addr(_rx_buf+0)
ADDS	R0, R0, R1
LDRB	R1, [R0, #0]
LDRB	R0, [SP, #5]
ADDS	R0, R0, R1
STRB	R0, [SP, #5]
;DriverRF4463PROMain.c,853 :: 		for ( i = 4; i < payload_length - 1; i++ )                // Calculation Checksum
LDRB	R0, [SP, #4]
ADDS	R0, R0, #1
STRB	R0, [SP, #4]
;DriverRF4463PROMain.c,854 :: 		chksum += rx_buf[ i ];
IT	AL
BAL	L_main401
L_main402:
;DriverRF4463PROMain.c,856 :: 		if ( ( chksum == rx_buf[ payload_length - 1 ] )&&( rx_buf[ 4 ] == 0x41 )) {
MOVW	R0, #lo_addr(_rx_buf+65)
MOVT	R0, #hi_addr(_rx_buf+65)
LDRB	R1, [R0, #0]
LDRB	R0, [SP, #5]
CMP	R0, R1
IT	NE
BNE	L__main494
MOVW	R0, #lo_addr(_rx_buf+4)
MOVT	R0, #hi_addr(_rx_buf+4)
LDRB	R0, [R0, #0]
CMP	R0, #65
IT	NE
BNE	L__main493
L__main492:
;DriverRF4463PROMain.c,862 :: 		UART1_Write_Text("[ MENSAGGE ] = ");
ADD	R11, SP, #76
ADD	R10, R11, #16
MOVW	R12, #lo_addr(?ICS?lstr6_DriverRF4463PROMain+0)
MOVT	R12, #hi_addr(?ICS?lstr6_DriverRF4463PROMain+0)
BL	___CC2DW+0
ADD	R0, SP, #76
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,863 :: 		vUSART1Start_TX( rx_buf, payload_length );
MOVS	R1, #66
MOVW	R0, #lo_addr(_rx_buf+0)
MOVT	R0, #hi_addr(_rx_buf+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,864 :: 		vUSART1Start_TX("\r\n", 2);
MOVS	R0, #13
STRB	R0, [SP, #92]
MOVS	R0, #10
STRB	R0, [SP, #93]
MOVS	R0, #0
STRB	R0, [SP, #94]
ADD	R0, SP, #92
MOVS	R1, #2
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,871 :: 		LED_GREEN ^= 1;                                        // Data received
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_LX	[R0, ByteOffset(GPIOC_ODRbits+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,872 :: 		rx_cnt++;
MOVW	R1, #lo_addr(_rx_cnt+0)
MOVT	R1, #hi_addr(_rx_cnt+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,873 :: 		getRSSI();
BL	_getRSSI+0
;DriverRF4463PROMain.c,878 :: 		}
IT	AL
BAL	L_main407
;DriverRF4463PROMain.c,856 :: 		if ( ( chksum == rx_buf[ payload_length - 1 ] )&&( rx_buf[ 4 ] == 0x41 )) {
L__main494:
L__main493:
;DriverRF4463PROMain.c,880 :: 		vRF4463RxInit();    // The received data is wrong, you must continue to receive
BL	_vRF4463RxInit+0
L_main407:
;DriverRF4463PROMain.c,881 :: 		}
IT	AL
BAL	L_main408
L_main400:
;DriverRF4463PROMain.c,884 :: 		vUSART1Start_TX("[ CRC ] Fail\r\n", 14 );
ADD	R11, SP, #95
ADD	R10, R11, #15
MOVW	R12, #lo_addr(?ICS?lstr8_DriverRF4463PROMain+0)
MOVT	R12, #hi_addr(?ICS?lstr8_DriverRF4463PROMain+0)
BL	___CC2DW+0
ADD	R0, SP, #95
MOVS	R1, #14
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,885 :: 		VRF4463SDNReset();
BL	_VRF4463SDNReset+0
;DriverRF4463PROMain.c,886 :: 		vRF4463Init();
BL	_vRF4463Init+0
;DriverRF4463PROMain.c,887 :: 		vRF4463RxInit();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,888 :: 		}
L_main408:
;DriverRF4463PROMain.c,889 :: 		}
L_main399:
;DriverRF4463PROMain.c,890 :: 		}
L_main398:
;DriverRF4463PROMain.c,891 :: 		}
IT	AL
BAL	L_main393
L_main394:
;DriverRF4463PROMain.c,892 :: 		}
L_main392:
;DriverRF4463PROMain.c,893 :: 		}
IT	AL
BAL	L_main375
;DriverRF4463PROMain.c,894 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
_getRSSI:
;DriverRF4463PROMain.c,897 :: 		void getRSSI()
SUB	SP, SP, #24
STR	LR, [SP, #0]
;DriverRF4463PROMain.c,899 :: 		ShortToStr(rssi,Value );
MOVW	R0, #lo_addr(_rssi+0)
MOVT	R0, #hi_addr(_rssi+0)
LDR	R0, [R0, #0]
BL	__FloatToSignedIntegral+0
SXTB	R0, R0
MOVW	R1, #lo_addr(_Value+0)
MOVT	R1, #hi_addr(_Value+0)
BL	_ShortToStr+0
;DriverRF4463PROMain.c,900 :: 		UART1_Write_Text("[ RSSI ] = ");
ADD	R11, SP, #4
ADD	R10, R11, #12
MOVW	R12, #lo_addr(?ICS?lstr9_DriverRF4463PROMain+0)
MOVT	R12, #hi_addr(?ICS?lstr9_DriverRF4463PROMain+0)
BL	___CC2DW+0
ADD	R0, SP, #4
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,901 :: 		UART1_Write_Text( Value );
MOVW	R0, #lo_addr(_Value+0)
MOVT	R0, #hi_addr(_Value+0)
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,902 :: 		UART1_Write_Text(" dBm\r\n");
MOVS	R0, #32
STRB	R0, [SP, #16]
MOVS	R0, #100
STRB	R0, [SP, #17]
MOVS	R0, #66
STRB	R0, [SP, #18]
MOVS	R0, #109
STRB	R0, [SP, #19]
MOVS	R0, #13
STRB	R0, [SP, #20]
MOVS	R0, #10
STRB	R0, [SP, #21]
MOVS	R0, #0
STRB	R0, [SP, #22]
ADD	R0, SP, #16
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,903 :: 		}
L_end_getRSSI:
LDR	LR, [SP, #0]
ADD	SP, SP, #24
BX	LR
; end of _getRSSI
