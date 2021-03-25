_Int_SPI2:
;driverspi.c,11 :: 		void Int_SPI2() iv IVT_INT_SPI2 ics ICS_AUTO {
PUSH	(R14)
;driverspi.c,13 :: 		if ( SPI2_SRbits.RXNE ) {
MOVW	R0, #lo_addr(SPI2_SRbits+0)
MOVT	R0, #hi_addr(SPI2_SRbits+0)
_LX	[R0, ByteOffset(SPI2_SRbits+0)]
MOVS	R0, #1
ANDS	R0, R1
LSRS	R0, R0, #0
CMP	R0, #0
IT	EQ
BLEQ	L_Int_SPI20
;driverspi.c,14 :: 		ucSPI2ByteReceived = ( unsigned char )SPI2_DR;      // lee el Byte recibido
MOVW	R0, #lo_addr(SPI2_DR+0)
MOVT	R0, #hi_addr(SPI2_DR+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucSPI2ByteReceived+0)
MOVT	R0, #hi_addr(_ucSPI2ByteReceived+0)
STRB	R1, [R0, #0]
;driverspi.c,16 :: 		}
L_Int_SPI20:
;driverspi.c,17 :: 		}
L_end_Int_SPI2:
POP	(R15)
; end of _Int_SPI2
_vSPI2Init:
;driverspi.c,21 :: 		void vSPI2Init ( void ) {
PUSH	(R14)
;driverspi.c,26 :: 		_SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI2_PB13_14_15 );
MOVW	R2, #lo_addr(__GPIO_MODULE_SPI2_PB13_14_15+0)
MOVT	R2, #hi_addr(__GPIO_MODULE_SPI2_PB13_14_15+0)
MOVW	R1, #772
MOVT	R1, #0
;driverspi.c,25 :: 		SPI2_Init_Advanced( _SPI_FPCLK_DIV4, _SPI_MASTER | _SPI_8_BIT | _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION | _SPI_MSB_FIRST |
MOVS	R0, #1
;driverspi.c,26 :: 		_SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI2_PB13_14_15 );
BL	_SPI2_Init_Advanced+0
;driverspi.c,28 :: 		SPI2_CR2bits.RXNEIE  = 1;       // habilitacion de ISR para RX
MOVW	R2, #lo_addr(SPI2_CR2bits+0)
MOVT	R2, #hi_addr(SPI2_CR2bits+0)
_LX	[R2, ByteOffset(SPI2_CR2bits+0)]
MOVS	R1, #64
ORRS	R0, R1
_SX	[R2, ByteOffset(SPI2_CR2bits+0)]
;driverspi.c,30 :: 		NVIC_IntEnable( IVT_INT_SPI2 );
MOVS	R0, #42
BL	_NVIC_IntEnable+0
;driverspi.c,31 :: 		}
L_end_vSPI2Init:
POP	(R15)
; end of _vSPI2Init
_vRF4463ISR:
;driverrf4463pro.c,29 :: 		void vRF4463ISR() iv IVT_INT_EXTI0_1 ics ICS_AUTO{
PUSH	(R14)
;driverrf4463pro.c,30 :: 		if( EXTI_PR.B1 ){
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_LX	[R0, ByteOffset(EXTI_PR+0)]
MOVS	R0, #2
ANDS	R0, R1
LSRS	R0, R0, #1
CMP	R0, #0
IT	EQ
BLEQ	L_vRF4463ISR1
;driverrf4463pro.c,31 :: 		EXTI_PR.B1 |= 1;
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_LX	[R0, ByteOffset(EXTI_PR+0)]
MOVS	R2, #2
ANDS	R2, R0
LSRS	R2, R2, #1
MOVW	R0, #lo_addr(_CMD_RADIO_POWER_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_POWER_SET+0)
LDRB	R1, [R0, #0]
MOVS	R0, BitMask(_CMD_RADIO_POWER_SET+0)
ANDS	R0, R1
LSRS	R0, R0, BitPos(_CMD_RADIO_POWER_SET+0)
MOV	R3, R2
ORRS	R3, R0
MOVW	R2, #lo_addr(EXTI_PR+0)
MOVT	R2, #hi_addr(EXTI_PR+0)
_LX	[R2, ByteOffset(EXTI_PR+0)]
MOVS	R1, #1
ANDS	R1, R3
BEQ	L__vRF4463ISR389
MOVS	R1, #2
ORRS	R0, R1
B	L__vRF4463ISR388
L__vRF4463ISR389:
MOVS	R1, #2
BICS	R0, R1
L__vRF4463ISR388:
_SX	[R2, ByteOffset(EXTI_PR+0)]
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
POP	(R15)
; end of _vRF4463ISR
_vRF4463Init:
;driverrf4463pro.c,41 :: 		void vRF4463Init ( void ) {  // MODE,
PUSH	(R14)
SUB	SP, SP, #24
;driverrf4463pro.c,44 :: 		for ( i = 4; i < 16; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init2:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #16
IT	CS
BLCS	L_vRF4463Init3
;driverrf4463pro.c,45 :: 		RF_MODEM_MOD_TYPE_12_data[ i ] = RF_MODEM_MOD_TYPE_12[ ucRF4463Rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_MOD_TYPE_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_MOD_TYPE_12_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #12
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_MOD_TYPE_12+0)
MOVT	R0, #hi_addr(_RF_MODEM_MOD_TYPE_12+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,44 :: 		for ( i = 4; i < 16; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,46 :: 		}
IT	AL
BLAL	L_vRF4463Init2
L_vRF4463Init3:
;driverrf4463pro.c,49 :: 		if ( ucRF4463Freq3 < 8 ) {
MOVW	R0, #lo_addr(_ucRF4463Freq3+0)
MOVT	R0, #hi_addr(_ucRF4463Freq3+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CS
BLCS	L_vRF4463Init5
;driverrf4463pro.c,50 :: 		for ( i = 4; i < 12; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init6:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #12
IT	CS
BLCS	L_vRF4463Init7
;driverrf4463pro.c,51 :: 		RF_MODEM_TX_RAMP_DELAY_8_data[ i ] = RF_MODEM_TX_RAMP_DELAY_8_433[ ucRF4463Rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #8
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_433+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,50 :: 		for ( i = 4; i < 12; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,52 :: 		}
IT	AL
BLAL	L_vRF4463Init6
L_vRF4463Init7:
;driverrf4463pro.c,53 :: 		for ( i = 4; i < 11; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init9:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #11
IT	CS
BLCS	L_vRF4463Init10
;driverrf4463pro.c,54 :: 		RF_MODEM_AFC_GEAR_7_data[ i ] = RF_MODEM_AFC_GEAR_7_433[ ucRF4463Rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_AFC_GEAR_7_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AFC_GEAR_7_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #7
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_AFC_GEAR_7_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_AFC_GEAR_7_433+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,53 :: 		for ( i = 4; i < 11; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,55 :: 		}
IT	AL
BLAL	L_vRF4463Init9
L_vRF4463Init10:
;driverrf4463pro.c,56 :: 		for ( i = 4; i < 15; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init12:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #15
IT	CS
BLCS	L_vRF4463Init13
;driverrf4463pro.c,57 :: 		RF_MODEM_OOK_CNT1_11_data[ i ] = RF_MODEM_OOK_CNT1_11_433[ ucRF4463Rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_OOK_CNT1_11_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_OOK_CNT1_11_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #11
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_OOK_CNT1_11_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_OOK_CNT1_11_433+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,56 :: 		for ( i = 4; i < 15; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,58 :: 		}
IT	AL
BLAL	L_vRF4463Init12
L_vRF4463Init13:
;driverrf4463pro.c,59 :: 		for ( i = 4; i < 16; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init15:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #16
IT	CS
BLCS	L_vRF4463Init16
;driverrf4463pro.c,60 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433[ ucRF4463Rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #12
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,59 :: 		for ( i = 4; i < 16; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,61 :: 		}
IT	AL
BLAL	L_vRF4463Init15
L_vRF4463Init16:
;driverrf4463pro.c,62 :: 		for ( i = 4; i < 16; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init18:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #16
IT	CS
BLCS	L_vRF4463Init19
;driverrf4463pro.c,63 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433[ ucRF4463Rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #12
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,62 :: 		for ( i = 4; i < 16; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,64 :: 		}
IT	AL
BLAL	L_vRF4463Init18
L_vRF4463Init19:
;driverrf4463pro.c,65 :: 		for ( i = 4; i < 16; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init21:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #16
IT	CS
BLCS	L_vRF4463Init22
;driverrf4463pro.c,66 :: 		RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433[ ucRF4463Rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #12
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,65 :: 		for ( i = 4; i < 16; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,67 :: 		}
IT	AL
BLAL	L_vRF4463Init21
L_vRF4463Init22:
;driverrf4463pro.c,68 :: 		for ( i = 4; i < 13; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init24:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #13
IT	CS
BLCS	L_vRF4463Init25
;driverrf4463pro.c,69 :: 		RF_MODEM_AGC_WINDOW_SIZE_9_data[ i ] = RF_MODEM_AGC_WINDOW_SIZE_9_433[ ucRF4463Rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #9
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_433+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,68 :: 		for ( i = 4; i < 13; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,70 :: 		}
IT	AL
BLAL	L_vRF4463Init24
L_vRF4463Init25:
;driverrf4463pro.c,71 :: 		for ( i = 4; i < 13; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init27:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #13
IT	CS
BLCS	L_vRF4463Init28
;driverrf4463pro.c,72 :: 		RF_MODEM_BCR_OSR_1_9_data[ i ] = RF_MODEM_BCR_OSR_1_9_433[ ucRF4463Rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #9
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_BCR_OSR_1_9_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_BCR_OSR_1_9_433+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,71 :: 		for ( i = 4; i < 13; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,73 :: 		}
IT	AL
BLAL	L_vRF4463Init27
L_vRF4463Init28:
;driverrf4463pro.c,74 :: 		}
IT	AL
BLAL	L_vRF4463Init30
L_vRF4463Init5:
;driverrf4463pro.c,76 :: 		for ( i = 4; i < 12; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init31:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #12
IT	CS
BLCS	L_vRF4463Init32
;driverrf4463pro.c,77 :: 		RF_MODEM_TX_RAMP_DELAY_8_data[ i ] = RF_MODEM_TX_RAMP_DELAY_8_850[ ucRF4463Rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #8
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_850+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,76 :: 		for ( i = 4; i < 12; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,78 :: 		}
IT	AL
BLAL	L_vRF4463Init31
L_vRF4463Init32:
;driverrf4463pro.c,79 :: 		for ( i = 4; i < 11; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init34:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #11
IT	CS
BLCS	L_vRF4463Init35
;driverrf4463pro.c,80 :: 		RF_MODEM_AFC_GEAR_7_data[ i ] = RF_MODEM_AFC_GEAR_7_850[ ucRF4463Rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_AFC_GEAR_7_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AFC_GEAR_7_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #7
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_AFC_GEAR_7_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_AFC_GEAR_7_850+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,79 :: 		for ( i = 4; i < 11; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,81 :: 		}
IT	AL
BLAL	L_vRF4463Init34
L_vRF4463Init35:
;driverrf4463pro.c,82 :: 		for ( i = 4; i < 15; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init37:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #15
IT	CS
BLCS	L_vRF4463Init38
;driverrf4463pro.c,83 :: 		RF_MODEM_OOK_CNT1_11_data[ i ] = RF_MODEM_OOK_CNT1_11_850[ ucRF4463Rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_OOK_CNT1_11_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_OOK_CNT1_11_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #11
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_OOK_CNT1_11_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_OOK_CNT1_11_850+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,82 :: 		for ( i = 4; i < 15; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,84 :: 		}
IT	AL
BLAL	L_vRF4463Init37
L_vRF4463Init38:
;driverrf4463pro.c,85 :: 		for ( i = 4; i < 16; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init40:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #16
IT	CS
BLCS	L_vRF4463Init41
;driverrf4463pro.c,86 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850[ ucRF4463Rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #12
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,85 :: 		for ( i = 4; i < 16; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,87 :: 		}
IT	AL
BLAL	L_vRF4463Init40
L_vRF4463Init41:
;driverrf4463pro.c,88 :: 		for ( i = 4; i < 16; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init43:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #16
IT	CS
BLCS	L_vRF4463Init44
;driverrf4463pro.c,89 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850[ ucRF4463Rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #12
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,88 :: 		for ( i = 4; i < 16; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,90 :: 		}
IT	AL
BLAL	L_vRF4463Init43
L_vRF4463Init44:
;driverrf4463pro.c,91 :: 		for ( i = 4; i < 16; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init46:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #16
IT	CS
BLCS	L_vRF4463Init47
;driverrf4463pro.c,92 :: 		RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850[ ucRF4463Rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #12
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,91 :: 		for ( i = 4; i < 16; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,93 :: 		}
IT	AL
BLAL	L_vRF4463Init46
L_vRF4463Init47:
;driverrf4463pro.c,94 :: 		for ( i = 4; i < 13; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init49:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #13
IT	CS
BLCS	L_vRF4463Init50
;driverrf4463pro.c,95 :: 		RF_MODEM_AGC_WINDOW_SIZE_9_data[ i ] = RF_MODEM_AGC_WINDOW_SIZE_9_850[ ucRF4463Rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #9
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_850+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,94 :: 		for ( i = 4; i < 13; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,96 :: 		}
IT	AL
BLAL	L_vRF4463Init49
L_vRF4463Init50:
;driverrf4463pro.c,97 :: 		for ( i = 4; i < 13; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init52:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #13
IT	CS
BLCS	L_vRF4463Init53
;driverrf4463pro.c,98 :: 		RF_MODEM_BCR_OSR_1_9_data[ i ] = RF_MODEM_BCR_OSR_1_9_850[ ucRF4463Rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #9
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_BCR_OSR_1_9_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_BCR_OSR_1_9_850+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,97 :: 		for ( i = 4; i < 13; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,99 :: 		}
IT	AL
BLAL	L_vRF4463Init52
L_vRF4463Init53:
;driverrf4463pro.c,100 :: 		}
L_vRF4463Init30:
;driverrf4463pro.c,101 :: 		for ( i = 4; i < 11; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init55:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #11
IT	CS
BLCS	L_vRF4463Init56
;driverrf4463pro.c,102 :: 		RF_SYNTH_PFDCP_CPFF_7_data[ i ] = RF_SYNTH_PFDCP_CPFF_7[ ucRF4463Rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
MOVT	R0, #hi_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #7
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_SYNTH_PFDCP_CPFF_7+0)
MOVT	R0, #hi_addr(_RF_SYNTH_PFDCP_CPFF_7+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,101 :: 		for ( i = 4; i < 11; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,103 :: 		}
IT	AL
BLAL	L_vRF4463Init55
L_vRF4463Init56:
;driverrf4463pro.c,107 :: 		vRF4463GPIO_SET( ucRF4463Mode );                              // PARAMETRO CONFIGURABLE
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
PUSH	(R0)
BL	_vRF4463GPIO_SET+0
ADD	SP, SP, #4
;driverrf4463pro.c,110 :: 		app_command_buf[ 0 ] = 0x11;    // SET PROPERTY
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,111 :: 		app_command_buf[ 1 ] = 0x00;    // 0x0000
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,112 :: 		app_command_buf[ 2 ] = 0x01;    // Total 1 Parameters
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,113 :: 		app_command_buf[ 3 ] = 0x00;    // 0x0000
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,114 :: 		app_command_buf[ 4 ] = 98;      // freq  adjustment    ( rango desde 0 - 127 Low cap - High Cap )
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #98
STRB	R0, [R1, #0]
;driverrf4463pro.c,115 :: 		spi_write( 5, app_command_buf );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,118 :: 		app_command_buf[ 0 ] = 0x11;    // SET PROPERTY
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,119 :: 		app_command_buf[ 1 ] = 0x00;    // 0x0003
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,120 :: 		app_command_buf[ 2 ] = 0x01;    // Total 1 Parameters
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,121 :: 		app_command_buf[ 3 ] = 0x03;    // 0x0003
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,122 :: 		app_command_buf[ 4 ] = 0x40;    // tx = rx = 64 byte, ordinary PH,high performance mode  ?????????????????????
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #64
STRB	R0, [R1, #0]
;driverrf4463pro.c,123 :: 		spi_write( 5, app_command_buf );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,127 :: 		spi_write( 0x08, RF_FRR_CTL_A_MODE_4_data );    // disable all fast response register
MOVW	R0, #lo_addr(_RF_FRR_CTL_A_MODE_4_data+0)
MOVT	R0, #hi_addr(_RF_FRR_CTL_A_MODE_4_data+0)
PUSH	(R0)
MOVS	R0, #8
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,130 :: 		app_command_buf[ 0 ] = 0x11;    // SET PROPERTY
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,131 :: 		app_command_buf[ 1 ] = 0x10;    // 0x1000
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #16
STRB	R0, [R1, #0]
;driverrf4463pro.c,132 :: 		app_command_buf[ 2 ] = 0x09;    // Total 9 Parameters
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #9
STRB	R0, [R1, #0]
;driverrf4463pro.c,133 :: 		app_command_buf[ 3 ] = 0x00;    // 0x1000
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,135 :: 		if ( ucRF4463Mode == tx_test_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BLNE	L_vRF4463Init58
;driverrf4463pro.c,136 :: 		app_command_buf[ 4 ] = 0xff;     //  Need to send 255 bytes of Preamble
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #255
STRB	R0, [R1, #0]
;driverrf4463pro.c,137 :: 		}
IT	AL
BLAL	L_vRF4463Init59
L_vRF4463Init58:
;driverrf4463pro.c,139 :: 		app_command_buf[ 4 ] = 0x08;   //  Need to send 8 bytes of Preamble
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,140 :: 		}
L_vRF4463Init59:
;driverrf4463pro.c,143 :: 		app_command_buf[ 5 ]   = 0x14;       // To detect 20 bit sync word,
MOV	R0, SP
ADDS	R1, R0, #5
MOVS	R0, #20
STRB	R0, [R1, #0]
;driverrf4463pro.c,144 :: 		app_command_buf[ 6 ]   = 0x00;       // Non-standard preamble settings, useless
MOV	R0, SP
ADDS	R1, R0, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,145 :: 		app_command_buf[ 7 ]   = 0x0f;       // Time of the preamble Timeout   ????????????????????????????????????????????????????????????
MOV	R0, SP
ADDS	R1, R0, #7
MOVS	R0, #15
STRB	R0, [R1, #0]
;driverrf4463pro.c,146 :: 		app_command_buf[ 8 ]   = 0x31;       // The length of the preamble is   byte Calculation , 1st = 1 NO manchest  Encoding, using standard 1010.??
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #8
MOVS	R0, #49
STRB	R0, [R1, #0]
;driverrf4463pro.c,147 :: 		app_command_buf[ 9 ]   = 0x0;        // Non-standard Preamble Patten 4th byte
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,148 :: 		app_command_buf[ 10 ]  = 0x00;       // Non-standard Preamble Patten 3rd byte
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,149 :: 		app_command_buf[ 11 ]  = 0x00;       // Non-standard Preamble Patten 2nd byte
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,150 :: 		app_command_buf[ 12 ]  = 0x00;       // Non-standard Preamble Patten 1st byte
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #12
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,151 :: 		spi_write(13, app_command_buf);
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #13
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,154 :: 		app_command_buf[ 0 ] = 0x11;         // SET PROPERTY
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,155 :: 		app_command_buf[ 1 ] = 0x11;         // command = 0x1100
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,156 :: 		app_command_buf[ 2 ] = 0x05;         // Total 5 Parameters
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #5
STRB	R0, [R1, #0]
;driverrf4463pro.c,157 :: 		app_command_buf[ 3 ] = 0x00;         // command = 0x1100
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,158 :: 		app_command_buf[ 4 ] = 0x01;         // The synchronization word is defined and sent in the length field, and the synchronization word cannot be wrong,Not 4FSK, not manchest encoding, only 2 bytes
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,160 :: 		if ( ucRF4463Mode == tx_test_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BLNE	L_vRF4463Init60
;driverrf4463pro.c,161 :: 		app_command_buf[ 5 ] = 0x55;      // Sync word 3
MOV	R0, SP
ADDS	R1, R0, #5
MOVS	R0, #85
STRB	R0, [R1, #0]
;driverrf4463pro.c,162 :: 		app_command_buf[ 6 ] = 0x55;      // Sync word 2
MOV	R0, SP
ADDS	R1, R0, #6
MOVS	R0, #85
STRB	R0, [R1, #0]
;driverrf4463pro.c,163 :: 		}
IT	AL
BLAL	L_vRF4463Init61
L_vRF4463Init60:
;driverrf4463pro.c,165 :: 		app_command_buf[ 5 ] = 0x2d;    // Sync word 3
MOV	R0, SP
ADDS	R1, R0, #5
MOVS	R0, #45
STRB	R0, [R1, #0]
;driverrf4463pro.c,166 :: 		app_command_buf[ 6 ] = 0xd4;    // Sync word 2
MOV	R0, SP
ADDS	R1, R0, #6
MOVS	R0, #212
STRB	R0, [R1, #0]
;driverrf4463pro.c,167 :: 		}
L_vRF4463Init61:
;driverrf4463pro.c,169 :: 		app_command_buf[ 7 ] =  0x00;        // Sync word 1
MOV	R0, SP
ADDS	R1, R0, #7
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,170 :: 		app_command_buf[ 8 ] = 0x00;         // Sync word 0
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,171 :: 		spi_write( 9, app_command_buf );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #9
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,174 :: 		app_command_buf[ 0 ] = 0x11;        // SET PROPERTY
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,175 :: 		app_command_buf[ 1 ] = 0x12;        // command = 0x1200
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,176 :: 		app_command_buf[ 2 ] = 0x01;        // Total 1 Parameters
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,177 :: 		app_command_buf[ 3 ] = 0x00;        // command = 0x1200
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,178 :: 		app_command_buf[ 4 ] = 0x85;        // 1?cRC ??,CRC = itu-c, enable crc   ( original 0x81; )
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #133
STRB	R0, [R1, #0]
;driverrf4463pro.c,179 :: 		spi_write( 5, app_command_buf );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,182 :: 		app_command_buf[ 0 ] = 0x11;        // SET PROPERTY
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,183 :: 		app_command_buf[ 1 ] = 0x12;        // command = 0x1206
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,184 :: 		app_command_buf[ 2 ] = 0x01;        // Total 1Parameters
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,185 :: 		app_command_buf[ 3 ] = 0x06;        // command = 0x1206
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #6
STRB	R0, [R1, #0]
;driverrf4463pro.c,186 :: 		app_command_buf[ 4 ] = 0x02;        //  tx = rx = 120d--1220 (tx packet,ph enable, not 4fsk, After receiving a packet of data,RX off,CRC Do not flip ,CRC MSB, data MSB
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,187 :: 		spi_write( 5, app_command_buf );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,190 :: 		app_command_buf[ 0 ] = 0x11;        // SET PROPERTY
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,191 :: 		app_command_buf[ 1 ] = 0x12;        // command = 0x1208
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,192 :: 		app_command_buf[ 2 ] = 0x03;        // Total 3 Parameters
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,193 :: 		app_command_buf[ 3 ] = 0x08;        // command = 0x1208
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,194 :: 		app_command_buf[ 4 ] = 0x00;        // Length Field = LSB,  length Only 1 byte,length Not put In FiFo, fixed packet length mode
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,195 :: 		app_command_buf[ 5 ] = 0x00;        // Used for variable packet length mode, which defines which Field contains length Filed
MOV	R0, SP
ADDS	R1, R0, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,196 :: 		app_command_buf[ 6 ] = 0x00;        // Used for variable packet length mode, adjust the length of variable packet length
MOV	R0, SP
ADDS	R1, R0, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,197 :: 		spi_write( 7, app_command_buf );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #7
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,200 :: 		app_command_buf[ 0 ]  = 0x11;
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,201 :: 		app_command_buf[ 1 ]  = 0x12;       // 0x120d
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,202 :: 		app_command_buf[ 2 ]  = 0x0c;       // Total 12 Parameters
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #12
STRB	R0, [R1, #0]
;driverrf4463pro.c,203 :: 		app_command_buf[ 3 ]  = 0x0d;       // 0x120d
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #13
STRB	R0, [R1, #0]
;driverrf4463pro.c,204 :: 		app_command_buf[ 4 ]  = 0x00;       //  Field 1 length (?4?)
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,205 :: 		app_command_buf[ 5 ]  = payload_length;   //  field 1 length, (? 8?), ?Total14???
MOV	R0, SP
ADDS	R1, R0, #5
MOVS	R0, #66
STRB	R0, [R1, #0]
;driverrf4463pro.c,206 :: 		app_command_buf[ 6 ]  = 0x04;       // field 1 Is not 4FSK,manchest, whiting, PN9,
MOV	R0, SP
ADDS	R1, R0, #6
MOVS	R0, #4
STRB	R0, [R1, #0]
;driverrf4463pro.c,207 :: 		app_command_buf[ 7 ]  = 0xaa;       // field 1 crc enble, check enbale, There are also launchingCRC,cRC?Seed ?CRC_seed?????
MOV	R0, SP
ADDS	R1, R0, #7
MOVS	R0, #170
STRB	R0, [R1, #0]
;driverrf4463pro.c,208 :: 		app_command_buf[ 8 ]  = 0x00;       //  field 2 length(?4?)
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,209 :: 		app_command_buf[ 9 ]  = 0x00;           //  field 2 length, (? 8?), length = 0 Means thisfield did not use
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,210 :: 		app_command_buf[ 10 ] = 0x00;       // field 2 Is not 4FSK,manchest, whiting, PN9
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,211 :: 		app_command_buf[ 11 ] = 0x00;       //  field 2 ?CRCSet up
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,212 :: 		app_command_buf[ 12 ] = 0x00;       //  field 3 length, (? 8?), length = 0 Means thisfield did not use
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #12
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,213 :: 		app_command_buf[ 13 ] = 0x00;           //  field 3 length, (? 8?), length = 0 Means thisfield did not use
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #13
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,214 :: 		app_command_buf[ 14 ] = 0x00;       //  field 3 Is not 4FSK,manchest, whiting, PN9
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #14
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,215 :: 		app_command_buf[ 15 ] = 0x00;       //  field 3 ?CRCSet up
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #15
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,216 :: 		spi_write( 16, app_command_buf );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #16
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,219 :: 		app_command_buf[ 0 ]  = 0x11;
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,220 :: 		app_command_buf[ 1 ]  = 0x12;       // 0x1219
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,221 :: 		app_command_buf[ 2 ]  = 0x08;       // Total 8Parameters
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,222 :: 		app_command_buf[ 3 ]  = 0x19;       // 0x1219
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #25
STRB	R0, [R1, #0]
;driverrf4463pro.c,223 :: 		app_command_buf[ 4 ]  = 0x00;       // field4 length(?4?)
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,224 :: 		app_command_buf[ 5 ]  = 0x00;       // field 4 length, (? 8?), length = 0 Means this field did not use
MOV	R0, SP
ADDS	R1, R0, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,225 :: 		app_command_buf[ 6 ]  = 0x00;       // field 4 Is not 4FSK,manchest, whiting, PN9
MOV	R0, SP
ADDS	R1, R0, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,226 :: 		app_command_buf[ 7 ]  = 0x00;       // field 4 ?CRCSet up
MOV	R0, SP
ADDS	R1, R0, #7
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,227 :: 		app_command_buf[ 8 ]  = 0x00;       // field5 length(?4?)
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,228 :: 		app_command_buf[ 9 ]  = 0x00;       // field 5 length, (? 8?), length = 0 Means this field did not use
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,229 :: 		app_command_buf[ 10 ] = 0x00;       // field 5 Is not 4FSK,manchest, whiting, PN9
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,230 :: 		app_command_buf[ 11 ] = 0x00;       // field 5 ?CRCSet up
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,231 :: 		spi_write( 12, app_command_buf );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #12
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,234 :: 		spi_write( 0x10, RF_MODEM_MOD_TYPE_12_data );   // //  2FSK ,  module source = PH fifo, disable manchest, tx, rx Do not flip, deviation Do not flip
MOVW	R0, #lo_addr(_RF_MODEM_MOD_TYPE_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_MOD_TYPE_12_data+0)
PUSH	(R0)
MOVS	R0, #16
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,237 :: 		app_command_buf[0] = 0x11;
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,238 :: 		app_command_buf[1]  = 0x20;    // 0x200c
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,239 :: 		app_command_buf[2]  = 0x01;    // Total 1Parameters
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,240 :: 		app_command_buf[3]  = 0x0c;   // 0x200c
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #12
STRB	R0, [R1, #0]
;driverrf4463pro.c,242 :: 		if ( ucRF4463Freq3 < 8 ) {
MOVW	R0, #lo_addr(_ucRF4463Freq3+0)
MOVT	R0, #hi_addr(_ucRF4463Freq3+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CS
BLCS	L_vRF4463Init62
;driverrf4463pro.c,243 :: 		if ( ucRF4463Rate >= dr_256k ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CC
BLCC	L_vRF4463Init63
;driverrf4463pro.c,244 :: 		app_command_buf[ 4 ] = 0x4f;
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #79
STRB	R0, [R1, #0]
;driverrf4463pro.c,245 :: 		}
IT	AL
BLAL	L_vRF4463Init64
L_vRF4463Init63:
;driverrf4463pro.c,246 :: 		else if ( ucRF4463Rate >= dr_19p2 ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	CC
BLCC	L_vRF4463Init65
;driverrf4463pro.c,247 :: 		app_command_buf[ 4 ]  = 0x5e;
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #94
STRB	R0, [R1, #0]
;driverrf4463pro.c,248 :: 		}
IT	AL
BLAL	L_vRF4463Init66
L_vRF4463Init65:
;driverrf4463pro.c,250 :: 		app_command_buf[ 4 ]  = 0xd2;
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #210
STRB	R0, [R1, #0]
;driverrf4463pro.c,251 :: 		}
L_vRF4463Init66:
L_vRF4463Init64:
;driverrf4463pro.c,252 :: 		}
IT	AL
BLAL	L_vRF4463Init67
L_vRF4463Init62:
;driverrf4463pro.c,254 :: 		if ( ucRF4463Rate >= dr_115p2 ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	CC
BLCC	L_vRF4463Init68
;driverrf4463pro.c,255 :: 		app_command_buf[ 4 ]  = 0x69;        // 15k
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #105
STRB	R0, [R1, #0]
;driverrf4463pro.c,256 :: 		}
IT	AL
BLAL	L_vRF4463Init69
L_vRF4463Init68:
;driverrf4463pro.c,257 :: 		else if ( ucRF4463Rate >= dr_19p2 ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	CC
BLCC	L_vRF4463Init70
;driverrf4463pro.c,258 :: 		app_command_buf[ 4 ]  = 0x5e;        // 10k
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #94
STRB	R0, [R1, #0]
;driverrf4463pro.c,259 :: 		}
IT	AL
BLAL	L_vRF4463Init71
L_vRF4463Init70:
;driverrf4463pro.c,261 :: 		app_command_buf[ 4 ]  = 0x18; // 8k
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #24
STRB	R0, [R1, #0]
;driverrf4463pro.c,262 :: 		}
L_vRF4463Init71:
L_vRF4463Init69:
;driverrf4463pro.c,263 :: 		}
L_vRF4463Init67:
;driverrf4463pro.c,264 :: 		spi_write( 5, app_command_buf );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,267 :: 		spi_write( 0x0C, RF_MODEM_TX_RAMP_DELAY_8_data );            // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
PUSH	(R0)
MOVS	R0, #12
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,268 :: 		spi_write( 0x0D, RF_MODEM_BCR_OSR_1_9_data );                // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
PUSH	(R0)
MOVS	R0, #13
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,269 :: 		spi_write( 0x0B, RF_MODEM_AFC_GEAR_7_data );                // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_AFC_GEAR_7_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AFC_GEAR_7_data+0)
PUSH	(R0)
MOVS	R0, #11
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,270 :: 		spi_write( 0x05, RF_MODEM_AGC_CONTROL_1_data );                // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_AGC_CONTROL_1_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_CONTROL_1_data+0)
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,271 :: 		spi_write( 0x0D, RF_MODEM_AGC_WINDOW_SIZE_9_data );        // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
PUSH	(R0)
MOVS	R0, #13
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,272 :: 		spi_write( 0x0F, RF_MODEM_OOK_CNT1_11_data );                // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_OOK_CNT1_11_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_OOK_CNT1_11_data+0)
PUSH	(R0)
MOVS	R0, #15
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,275 :: 		app_command_buf[ 0 ] = 0x11;
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,276 :: 		app_command_buf[ 1 ] = 0x20;    // 0x204e
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,277 :: 		app_command_buf[ 2 ] = 0x01;    // Total 1Parameters
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,278 :: 		app_command_buf[ 3 ] = 0x4e;   // 0x204e
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #78
STRB	R0, [R1, #0]
;driverrf4463pro.c,280 :: 		if ( ucRF4463Rate == dr_500 ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	NE
BLNE	L_vRF4463Init72
;driverrf4463pro.c,281 :: 		app_command_buf[ 4 ] = 0x3a;
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #58
STRB	R0, [R1, #0]
;driverrf4463pro.c,282 :: 		}
IT	AL
BLAL	L_vRF4463Init73
L_vRF4463Init72:
;driverrf4463pro.c,284 :: 		app_command_buf[ 4 ] = 0x40;  //  rssi Reading deviation, the difference with the true value
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #64
STRB	R0, [R1, #0]
;driverrf4463pro.c,285 :: 		}
L_vRF4463Init73:
;driverrf4463pro.c,286 :: 		spi_write( 5, app_command_buf );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,289 :: 		spi_write( 0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data );  // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
PUSH	(R0)
MOVS	R0, #16
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,290 :: 		spi_write( 0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data );   // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
PUSH	(R0)
MOVS	R0, #16
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,291 :: 		spi_write( 0x10, RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data );   // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
PUSH	(R0)
MOVS	R0, #16
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,294 :: 		app_command_buf[ 0 ]  = 0x11;
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,295 :: 		app_command_buf[ 1 ]  = 0x22;    // 0x2200
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #34
STRB	R0, [R1, #0]
;driverrf4463pro.c,296 :: 		app_command_buf[ 2 ]  = 0x04;    // Total 4Parameters
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #4
STRB	R0, [R1, #0]
;driverrf4463pro.c,297 :: 		app_command_buf[ 3 ]  = 0x00;   // 0x2200
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,298 :: 		app_command_buf[ 4 ]  = 0x08;  //0x10;   //   PA mode  = default , ??Class E mode,?Is not Switch Current mode  ????????
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,300 :: 		if ( ucRF4463Power > 0 || ucRF4463Power < 127 ) {
MOVW	R0, #lo_addr(_ucRF4463Power+0)
MOVT	R0, #hi_addr(_ucRF4463Power+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	HI
BLHI	L__vRF4463Init362
MOVW	R0, #lo_addr(_ucRF4463Power+0)
MOVT	R0, #hi_addr(_ucRF4463Power+0)
LDRB	R0, [R0, #0]
CMP	R0, #127
IT	CC
BLCC	L__vRF4463Init362
IT	AL
BLAL	L_vRF4463Init76
L__vRF4463Init362:
;driverrf4463pro.c,301 :: 		app_command_buf[ 5 ]  = ucRF4463Power;   //  Set to maximum power
MOV	R0, SP
ADDS	R1, R0, #5
MOVW	R0, #lo_addr(_ucRF4463Power+0)
MOVT	R0, #hi_addr(_ucRF4463Power+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,302 :: 		}
IT	AL
BLAL	L_vRF4463Init77
L_vRF4463Init76:
;driverrf4463pro.c,304 :: 		app_command_buf[ 5 ]  = 127;
MOV	R0, SP
ADDS	R1, R0, #5
MOVS	R0, #127
STRB	R0, [R1, #0]
;driverrf4463pro.c,305 :: 		}
L_vRF4463Init77:
;driverrf4463pro.c,307 :: 		app_command_buf[ 6 ] = 0x00; //???????? 0x00;   // CLK duty = 50%, other = Default
MOV	R0, SP
ADDS	R1, R0, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,309 :: 		if ( ( ucRF4463Rate <= dr_115p2 )||( ucRF4463Rate == dr_500 ) ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	LS
BLLS	L__vRF4463Init361
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	EQ
BLEQ	L__vRF4463Init361
IT	AL
BLAL	L_vRF4463Init80
L__vRF4463Init361:
;driverrf4463pro.c,310 :: 		app_command_buf[ 7 ]  = 0x3d;  // ???????? 0x5d;   // PA ramp time = default
MOV	R0, SP
ADDS	R1, R0, #7
MOVS	R0, #61
STRB	R0, [R1, #0]
;driverrf4463pro.c,311 :: 		}
IT	AL
BLAL	L_vRF4463Init81
L_vRF4463Init80:
;driverrf4463pro.c,313 :: 		app_command_buf[ 7 ]  = 0x5d;
MOV	R0, SP
ADDS	R1, R0, #7
MOVS	R0, #93
STRB	R0, [R1, #0]
;driverrf4463pro.c,314 :: 		}
L_vRF4463Init81:
;driverrf4463pro.c,315 :: 		spi_write( 8, app_command_buf );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #8
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,319 :: 		spi_write( 0x0B , RF_SYNTH_PFDCP_CPFF_7_data );      // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
MOVT	R0, #hi_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
PUSH	(R0)
MOVS	R0, #11
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,322 :: 		if ( ucRF4463MatchEnabled ) {
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L_vRF4463Init82
;driverrf4463pro.c,323 :: 		app_command_buf[ 0 ]  = 0x11;               // SetProperty
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,324 :: 		app_command_buf[ 1 ]  = 0x30;               // 0x30 group
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #48
STRB	R0, [R1, #0]
;driverrf4463pro.c,325 :: 		app_command_buf[ 2 ]  = 0x0c;               // Total 12 Parameters
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #12
STRB	R0, [R1, #0]
;driverrf4463pro.c,326 :: 		app_command_buf[ 3 ]  = 0x00;               // 0x00 Index
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,327 :: 		app_command_buf[ 4 ]  = ucRF4463ByteMatch1; // match 1 Value of
MOV	R0, SP
ADDS	R1, R0, #4
MOVW	R0, #lo_addr(_ucRF4463ByteMatch1+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch1+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,328 :: 		app_command_buf[ 5 ]  = ucRF4463ByteMask1;  // match 1 mask
MOV	R0, SP
ADDS	R1, R0, #5
MOVW	R0, #lo_addr(_ucRF4463ByteMask1+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask1+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,329 :: 		app_command_buf[ 6 ]  = ucRF4463MatchEnableReg; //  0x40; // enable match 1, match 1 The distance between the value of and the synchronization word, 0 = match
MOV	R0, SP
ADDS	R1, R0, #6
MOVW	R0, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnableReg+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,330 :: 		app_command_buf[ 7 ]  = ucRF4463ByteMatch2; // match 2 Value of
MOV	R0, SP
ADDS	R1, R0, #7
MOVW	R0, #lo_addr(_ucRF4463ByteMatch2+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch2+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,331 :: 		app_command_buf[ 8 ]  = ucRF4463ByteMask2;  // match 2 mask
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #8
MOVW	R0, #lo_addr(_ucRF4463ByteMask2+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask2+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,332 :: 		app_command_buf[ 9 ]  = 0x01;               // enable match 2, match 2 The distance between the value of and the synchronization word  , and function
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #9
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,333 :: 		app_command_buf[ 10 ] = ucRF4463ByteMatch3; // match 3 Value of
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #10
MOVW	R0, #lo_addr(_ucRF4463ByteMatch3+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch3+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,334 :: 		app_command_buf[ 11 ] = ucRF4463ByteMask3;  // match 3 mask
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #11
MOVW	R0, #lo_addr(_ucRF4463ByteMask3+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask3+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,335 :: 		app_command_buf[ 12 ] = 0x02;;              // enable match 3, match 3 The distance between the value of and the synchronization word    and function
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #12
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,336 :: 		app_command_buf[ 13 ] = ucRF4463ByteMatch4; // match 4 Value of
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #13
MOVW	R0, #lo_addr(_ucRF4463ByteMatch4+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch4+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,337 :: 		app_command_buf[ 14 ] = ucRF4463ByteMask4;  // match 4 mask
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #14
MOVW	R0, #lo_addr(_ucRF4463ByteMask4+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask4+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,338 :: 		app_command_buf[ 15 ] = 0x03;               // enable match 4, match 4 The distance between the value of and the synchronization word    and function
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #15
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,339 :: 		spi_write( 16, app_command_buf );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #16
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,341 :: 		if ( ucRF4463MatchEnableReg == 0x00 ) {
MOVW	R0, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnableReg+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BLNE	L_vRF4463Init83
;driverrf4463pro.c,342 :: 		ucRF4463MatchEnabled = 0;                // deshabilita el Match
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R1, [R0, #0]
;driverrf4463pro.c,343 :: 		}
L_vRF4463Init83:
;driverrf4463pro.c,362 :: 		}
L_vRF4463Init82:
;driverrf4463pro.c,365 :: 		rf_init_freq();     // FUNCION DE FRECUENCIA ( REVISAR PARAMETROS )
BL	_rf_init_freq+0
;driverrf4463pro.c,366 :: 		}
L_end_vRF4463Init:
ADD	SP, SP, #24
POP	(R15)
; end of _vRF4463Init
_vRF4463GPIO_SET:
;driverrf4463pro.c,372 :: 		void vRF4463GPIO_SET( unsigned char ucData ) {
PUSH	(R14)
SUB	SP, SP, #8
;driverrf4463pro.c,375 :: 		ucAppCommandBuf[0] = 0x13;     // gpio Set up
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #19
STRB	R0, [R1, #0]
;driverrf4463pro.c,377 :: 		switch ( ucData ) {
IT	AL
BLAL	L_vRF4463GPIO_SET84
;driverrf4463pro.c,378 :: 		case tx_normal:
L_vRF4463GPIO_SET86:
;driverrf4463pro.c,379 :: 		case rx_normal: ucAppCommandBuf[ 1 ] = 3;                 // GPIO0=1
L_vRF4463GPIO_SET87:
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,380 :: 		ucAppCommandBuf[ 2 ] = 2;                // GPIO1=0
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,381 :: 		break;
IT	AL
BLAL	L_vRF4463GPIO_SET85
;driverrf4463pro.c,383 :: 		case tx_test:   ucAppCommandBuf[ 1 ] = 3;                 // GPIO0=1
L_vRF4463GPIO_SET88:
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,384 :: 		ucAppCommandBuf[ 2 ] = 3;                // GPIO1=1
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,385 :: 		break;
IT	AL
BLAL	L_vRF4463GPIO_SET85
;driverrf4463pro.c,387 :: 		case rx_test:   ucAppCommandBuf[ 1 ] = 2;                 // GPIO0=0
L_vRF4463GPIO_SET89:
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,388 :: 		ucAppCommandBuf[ 2 ] = 20;                // GPIO1=RX DATA
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #20
STRB	R0, [R1, #0]
;driverrf4463pro.c,389 :: 		break;
IT	AL
BLAL	L_vRF4463GPIO_SET85
;driverrf4463pro.c,391 :: 		case rf_off:    ucAppCommandBuf[ 1 ] = 2;                 // GPIO0=0
L_vRF4463GPIO_SET90:
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,392 :: 		ucAppCommandBuf[ 2 ] = 2;                // GPIO1=0
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,393 :: 		break;
IT	AL
BLAL	L_vRF4463GPIO_SET85
;driverrf4463pro.c,394 :: 		}
L_vRF4463GPIO_SET84:
LDR	R0, [SP, #12]
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BLEQ	L_vRF4463GPIO_SET86
LDR	R0, [SP, #12]
UXTB	R0, R0
CMP	R0, #1
IT	EQ
BLEQ	L_vRF4463GPIO_SET87
LDR	R0, [SP, #12]
UXTB	R0, R0
CMP	R0, #2
IT	EQ
BLEQ	L_vRF4463GPIO_SET88
LDR	R0, [SP, #12]
UXTB	R0, R0
CMP	R0, #3
IT	EQ
BLEQ	L_vRF4463GPIO_SET89
LDR	R0, [SP, #12]
UXTB	R0, R0
CMP	R0, #4
IT	EQ
BLEQ	L_vRF4463GPIO_SET90
L_vRF4463GPIO_SET85:
;driverrf4463pro.c,396 :: 		ucAppCommandBuf[ 3 ]  = 0x21;     //0x20;   //  gpio2, h = tx mode
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #33
STRB	R0, [R1, #0]
;driverrf4463pro.c,397 :: 		ucAppCommandBuf[ 4 ]  = 0x20;     // 0x14;  //   gpio3
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,398 :: 		ucAppCommandBuf[ 5 ]  = 0x27;     // nIRQ
MOV	R0, SP
ADDS	R1, R0, #5
MOVS	R0, #39
STRB	R0, [R1, #0]
;driverrf4463pro.c,399 :: 		ucAppCommandBuf[ 6 ]  = 0x0b;     // sdo
MOV	R0, SP
ADDS	R1, R0, #6
MOVS	R0, #11
STRB	R0, [R1, #0]
;driverrf4463pro.c,400 :: 		spi_write( 7, ucAppCommandBuf );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #7
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,401 :: 		}
L_end_vRF4463GPIO_SET:
ADD	SP, SP, #8
POP	(R15)
; end of _vRF4463GPIO_SET
_vRF4463FifoReset:
;driverrf4463pro.c,406 :: 		void vRF4463FifoReset( void ) {
PUSH	(R14)
SUB	SP, SP, #4
;driverrf4463pro.c,409 :: 		p[ 0 ] = FIFO_INFO;
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #21
STRB	R0, [R1, #0]
;driverrf4463pro.c,410 :: 		p[ 1 ] = 0x03;   // reset tx ,rx fifo
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,411 :: 		spi_write( 2, p );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #2
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,412 :: 		}
L_end_vRF4463FifoReset:
ADD	SP, SP, #4
POP	(R15)
; end of _vRF4463FifoReset
_vRF4463ClearInterrupts:
;driverrf4463pro.c,418 :: 		void vRF4463ClearInterrupts( void ) {
PUSH	(R14)
SUB	SP, SP, #4
;driverrf4463pro.c,421 :: 		p[ 0 ] = GET_INT_STATUS;
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,422 :: 		p[ 1 ] = 0;               // clr  PH pending
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,423 :: 		p[ 2 ] = 0;               // clr modem_pending
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,424 :: 		p[ 3 ] = 0;               // clr chip pending
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,425 :: 		spi_write( 4, p );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #4
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,426 :: 		spi_read( 9, GET_INT_STATUS );
MOVS	R0, #32
PUSH	(R0)
MOVS	R0, #9
PUSH	(R0)
BL	_spi_read+0
ADD	SP, SP, #8
;driverrf4463pro.c,427 :: 		}
L_end_vRF4463ClearInterrupts:
ADD	SP, SP, #4
POP	(R15)
; end of _vRF4463ClearInterrupts
_vRF4463PartInfo:
;driverrf4463pro.c,429 :: 		void vRF4463PartInfo( void ) {  // Solicitud totalmente operativa
PUSH	(R14)
SUB	SP, SP, #12
;driverrf4463pro.c,432 :: 		p[ 0 ] = PART_INFO;
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,436 :: 		spi_write( 1, p );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #1
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,437 :: 		spi_read( 9, PART_INFO );
MOVS	R0, #1
PUSH	(R0)
MOVS	R0, #9
PUSH	(R0)
BL	_spi_read+0
ADD	SP, SP, #8
;driverrf4463pro.c,438 :: 		}
L_end_vRF4463PartInfo:
ADD	SP, SP, #12
POP	(R15)
; end of _vRF4463PartInfo
_vRF4463EnableRxInterrupt:
;driverrf4463pro.c,443 :: 		void vRF4463EnableRxInterrupt( void ) {
PUSH	(R14)
SUB	SP, SP, #8
;driverrf4463pro.c,446 :: 		p[ 0 ] = 0x11;
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,447 :: 		p[ 1 ] = 0x01;            // 0x0100
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,448 :: 		p[ 2 ] = 0x03;            // 3Parameters
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,449 :: 		p[ 3 ] = 0x00;            // 0100
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,450 :: 		p[ 4 ] = 0x03;            // ph, modem int       0x03;
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,451 :: 		p[ 5 ] = 0x18;            // 0x10;   // Pack received int
MOV	R0, SP
ADDS	R1, R0, #5
MOVS	R0, #24
STRB	R0, [R1, #0]
;driverrf4463pro.c,452 :: 		p[ 6 ] = 0x00;            //preamble int, sync int setting
MOV	R0, SP
ADDS	R1, R0, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,453 :: 		spi_write( 0x07, p );     // enable  packet receive interrupt
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #7
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,454 :: 		}
L_end_vRF4463EnableRxInterrupt:
ADD	SP, SP, #8
POP	(R15)
; end of _vRF4463EnableRxInterrupt
_vRF4463EnableTxInterrupt:
;driverrf4463pro.c,459 :: 		void vRF4463EnableTxInterrupt( void ) {
PUSH	(R14)
SUB	SP, SP, #8
;driverrf4463pro.c,462 :: 		p[ 0 ] = 0x11;
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,463 :: 		p[ 1 ] = 0x01;            // 0x0100
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,464 :: 		p[ 2 ] = 0x02;            // 2Parameters
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,465 :: 		p[ 3 ] = 0x00;            // 0x0100
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,466 :: 		p[ 4 ] = 0x01;            // Ph  int
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,467 :: 		p[ 5 ] = 0x20;            //  enable  packet sent interrupt
MOV	R0, SP
ADDS	R1, R0, #5
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,468 :: 		spi_write( 0x06, p );     // enable  packet receive interrupt
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #6
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,469 :: 		}
L_end_vRF4463EnableTxInterrupt:
ADD	SP, SP, #8
POP	(R15)
; end of _vRF4463EnableTxInterrupt
_vRF4463RfStandby:
;driverrf4463pro.c,474 :: 		void vRF4463RfStandby( void ) {
PUSH	(R14)
SUB	SP, SP, #4
;driverrf4463pro.c,477 :: 		p[ 0 ] = CHANGE_STATE ;   // CHANGE_STATE Command
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #52
STRB	R0, [R1, #0]
;driverrf4463pro.c,478 :: 		p[ 1 ] = 0x01 ;           // sleep mode
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,479 :: 		spi_write( 2, p );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #2
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,480 :: 		}
L_end_vRF4463RfStandby:
ADD	SP, SP, #4
POP	(R15)
; end of _vRF4463RfStandby
_vRF4463TxStart:
;driverrf4463pro.c,485 :: 		void vRF4463TxStart( void ) {
PUSH	(R14)
SUB	SP, SP, #8
;driverrf4463pro.c,488 :: 		p[ 0 ] = START_TX ;              // start Command
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #49
STRB	R0, [R1, #0]
;driverrf4463pro.c,489 :: 		p[ 1 ] = ucRF4463FreqChannel;    // channel 1 default
MOV	R0, SP
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,490 :: 		p[ 2 ] = 0x30;                   // Back after launch Readymode, Do not retransmit, launch immediately
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #48
STRB	R0, [R1, #0]
;driverrf4463pro.c,491 :: 		p[ 3 ] = 0;
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,492 :: 		p[ 4 ] = 0;                      // payload_length; // Total to transmit 10 bytes
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,493 :: 		spi_write( 5, p );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,494 :: 		}
L_end_vRF4463TxStart:
ADD	SP, SP, #8
POP	(R15)
; end of _vRF4463TxStart
_vRF4463RxStart:
;driverrf4463pro.c,499 :: 		void vRF4463RxStart( void ) {
PUSH	(R14)
SUB	SP, SP, #8
;driverrf4463pro.c,502 :: 		p[ 0 ] = START_RX ;              // start Command
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #50
STRB	R0, [R1, #0]
;driverrf4463pro.c,503 :: 		p[ 1 ] = ucRF4463FreqChannel;    // channel 0
MOV	R0, SP
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,504 :: 		p[ 2 ] = 0x00;                   // Enter receiving mode immediately
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,505 :: 		p[ 3 ] = 0;
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,506 :: 		p[ 4 ] = 0;                      // payload_length; // Total to receive 10 bytes
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,507 :: 		p[ 5 ] = 0;                      // unchanged after preamble timeout
MOV	R0, SP
ADDS	R1, R0, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,510 :: 		p[ 6 ] = 0x08;
MOV	R0, SP
ADDS	R1, R0, #6
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,511 :: 		p[ 7 ] = 0x08;
MOV	R0, SP
ADDS	R1, R0, #7
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,512 :: 		spi_write( 8, p );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #8
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,513 :: 		}
L_end_vRF4463RxStart:
ADD	SP, SP, #8
POP	(R15)
; end of _vRF4463RxStart
_vRF4463RxStartTest:
;driverrf4463pro.c,518 :: 		void vRF4463RxStartTest( void ) {
PUSH	(R14)
SUB	SP, SP, #8
;driverrf4463pro.c,523 :: 		p[ 0 ] = START_RX;        // start Command
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #50
STRB	R0, [R1, #0]
;driverrf4463pro.c,524 :: 		p[ 1 ] = ucRF4463FreqChannel;    // channel 0
MOV	R0, SP
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,525 :: 		p[ 2 ] = 0x00;            // Enter receiving mode immediately
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,526 :: 		p[ 3 ] = 0;
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,528 :: 		p[ 4 ] = 0;
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,529 :: 		p[ 5 ] = 0;               // unchanged after preamble timeout
MOV	R0, SP
ADDS	R1, R0, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,532 :: 		p[ 6 ] = 0x08;
MOV	R0, SP
ADDS	R1, R0, #6
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,533 :: 		p[ 7 ] = 0x08;
MOV	R0, SP
ADDS	R1, R0, #7
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,534 :: 		spi_write( 8, p );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #8
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,535 :: 		}
L_end_vRF4463RxStartTest:
ADD	SP, SP, #8
POP	(R15)
; end of _vRF4463RxStartTest
_vRF4463RxInit:
;driverrf4463pro.c,540 :: 		void vRF4463RxInit( void ) {
PUSH	(R14)
;driverrf4463pro.c,541 :: 		Flag.is_tx = 0;
MOVW	R2, #lo_addr(_Flag+0)
MOVT	R2, #hi_addr(_Flag+0)
_LX	[R2, ByteOffset(_Flag+0)]
MOVS	R1, #2
BICS	R0, R1
_SX	[R2, ByteOffset(_Flag+0)]
;driverrf4463pro.c,542 :: 		vRF4463FifoReset();           // fifo_reset();  // Buffer empty
BL	_vRF4463FifoReset+0
;driverrf4463pro.c,543 :: 		vRF4463EnableRxInterrupt();   // enable_rx_interrupt();
BL	_vRF4463EnableRxInterrupt+0
;driverrf4463pro.c,544 :: 		vRF4463ClearInterrupts();      // clr_interrupt();  // Clear interrupt factor
BL	_vRF4463ClearInterrupts+0
;driverrf4463pro.c,546 :: 		if ( ucRF4463Mode == rx_test_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BLNE	L_vRF4463RxInit91
;driverrf4463pro.c,547 :: 		vRF4463RxStartTest();      // rx_start_test();
BL	_vRF4463RxStartTest+0
;driverrf4463pro.c,548 :: 		}
IT	AL
BLAL	L_vRF4463RxInit92
L_vRF4463RxInit91:
;driverrf4463pro.c,550 :: 		vRF4463RxStart();        // rx_start();    // Enter receiving mode, after receiving data, return to Readymode
BL	_vRF4463RxStart+0
;driverrf4463pro.c,551 :: 		}
L_vRF4463RxInit92:
;driverrf4463pro.c,552 :: 		}
L_end_vRF4463RxInit:
POP	(R15)
; end of _vRF4463RxInit
_vRF4463TxData:
;driverrf4463pro.c,557 :: 		void vRF4463TxData( void ) {
PUSH	(R14)
SUB	SP, SP, #20
;driverrf4463pro.c,560 :: 		ucRF4463IRQ = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
STRB	R1, [R0, #0]
;driverrf4463pro.c,562 :: 		Flag.is_tx = 1;
MOVW	R2, #lo_addr(_Flag+0)
MOVT	R2, #hi_addr(_Flag+0)
_LX	[R2, ByteOffset(_Flag+0)]
MOVS	R1, #2
ORRS	R0, R1
_SX	[R2, ByteOffset(_Flag+0)]
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
MOVW	R2, #lo_addr(_Flag+0)
MOVT	R2, #hi_addr(_Flag+0)
_LX	[R2, ByteOffset(_Flag+0)]
MOVS	R1, #4
BICS	R0, R1
_SX	[R2, ByteOffset(_Flag+0)]
;driverrf4463pro.c,576 :: 		if ( ucRF4463IRQ ) {
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L_vRF4463TxData93
;driverrf4463pro.c,577 :: 		UART1_Write_Text( "[ UART1 ] TX INT\r\n" );
MOV	R6, SP
MOVS	R5, #19
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr1_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr1_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOV	R0, SP
MOV	R4, R0
MOV	R0, R4
BL	_UART1_Write_Text+0
;driverrf4463pro.c,578 :: 		}
L_vRF4463TxData93:
;driverrf4463pro.c,581 :: 		while ( nIRQ ) {     //nIRQ
L_vRF4463TxData94:
MOVW	R0, #lo_addr(GPIOH_IDR+0)
MOVT	R0, #hi_addr(GPIOH_IDR+0)
_LX	[R0, ByteOffset(GPIOH_IDR+0)]
MOVS	R0, #2
ANDS	R0, R1
LSRS	R0, R0, #1
CMP	R0, #0
IT	EQ
BLEQ	L_vRF4463TxData95
;driverrf4463pro.c,584 :: 		if ( Flag.rf_reach_timeout ) {
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
_LX	[R0, ByteOffset(_Flag+0)]
MOVS	R0, #4
ANDS	R0, R1
LSRS	R0, R0, #2
CMP	R0, #0
IT	EQ
BLEQ	L_vRF4463TxData96
;driverrf4463pro.c,585 :: 		VRF4463SDNReset();
BL	_VRF4463SDNReset+0
;driverrf4463pro.c,586 :: 		vRF4463Init();        //SI4463_init();  // RF Module initialization
BL	_vRF4463Init+0
;driverrf4463pro.c,587 :: 		break;                // Forced out
IT	AL
BLAL	L_vRF4463TxData95
;driverrf4463pro.c,588 :: 		}
L_vRF4463TxData96:
;driverrf4463pro.c,589 :: 		}
IT	AL
BLAL	L_vRF4463TxData94
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
ADD	SP, SP, #20
POP	(R15)
; end of _vRF4463TxData
_vRF4463TxCont:
;driverrf4463pro.c,599 :: 		void vRF4463TxCont( void ) {
PUSH	(R14)
;driverrf4463pro.c,602 :: 		vRF4463FifoReset();                     //  fifo_reset();  // Buffer empty
BL	_vRF4463FifoReset+0
;driverrf4463pro.c,603 :: 		spi_write_fifo();                       // Fill the buffer with data
BL	_spi_write_fifo+0
;driverrf4463pro.c,604 :: 		vRF4463EnableTxInterrupt();             //  enable_tx_interrupt();
BL	_vRF4463EnableTxInterrupt+0
;driverrf4463pro.c,605 :: 		vRF4463ClearInterrupts();               //  clr_interrupt();  // Clear interrupt factor
BL	_vRF4463ClearInterrupts+0
;driverrf4463pro.c,606 :: 		vRF4463TxStart();                       //  tx_start();    // Enter launch mode, start launch
BL	_vRF4463TxStart+0
;driverrf4463pro.c,607 :: 		rf_timeout = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_rf_timeout+0)
MOVT	R0, #hi_addr(_rf_timeout+0)
STRH	R1, [R0, #0]
;driverrf4463pro.c,608 :: 		Flag.rf_reach_timeout = 0;
MOVW	R2, #lo_addr(_Flag+0)
MOVT	R2, #hi_addr(_Flag+0)
_LX	[R2, ByteOffset(_Flag+0)]
MOVS	R1, #4
BICS	R0, R1
_SX	[R2, ByteOffset(_Flag+0)]
;driverrf4463pro.c,610 :: 		ucRF4463IRQ = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
STRB	R1, [R0, #0]
;driverrf4463pro.c,613 :: 		while( nIRQ ) {          //nIRQ ) {
L_vRF4463TxCont97:
MOVW	R0, #lo_addr(GPIOH_IDR+0)
MOVT	R0, #hi_addr(GPIOH_IDR+0)
_LX	[R0, ByteOffset(GPIOH_IDR+0)]
MOVS	R0, #2
ANDS	R0, R1
LSRS	R0, R0, #1
CMP	R0, #0
IT	EQ
BLEQ	L_vRF4463TxCont98
;driverrf4463pro.c,621 :: 		}
IT	AL
BLAL	L_vRF4463TxCont97
L_vRF4463TxCont98:
;driverrf4463pro.c,622 :: 		}
L_end_vRF4463TxCont:
POP	(R15)
; end of _vRF4463TxCont
_rf_init_freq:
;driverrf4463pro.c,627 :: 		void rf_init_freq ( void ) {
PUSH	(R14)
SUB	SP, SP, #64
;driverrf4463pro.c,633 :: 		ulFrequency = ( ucRF4463Freq3 * 100 ) + ( ucRF4463Freq2 * 10 ) + ucRF4463Freq1;
MOVW	R0, #lo_addr(_ucRF4463Freq3+0)
MOVT	R0, #hi_addr(_ucRF4463Freq3+0)
LDRB	R1, [R0, #0]
MOVS	R0, #100
MOV	R3, R0
MULS	R3, R1, R3
SXTH	R3, R3
MOVW	R0, #lo_addr(_ucRF4463Freq2+0)
MOVT	R0, #hi_addr(_ucRF4463Freq2+0)
LDRB	R2, [R0, #0]
MOVS	R1, #10
MOV	R0, R1
MULS	R0, R2, R0
SXTH	R0, R0
ADDS	R1, R3, R0
SXTH	R1, R1
MOVW	R0, #lo_addr(_ucRF4463Freq1+0)
MOVT	R0, #hi_addr(_ucRF4463Freq1+0)
LDRB	R0, [R0, #0]
ADDS	R0, R1, R0
SXTH	R0, R0
STR	R0, [SP, #40]
;driverrf4463pro.c,635 :: 		ulFrequency = ( ulFrequency * 10000 );
LDR	R2, [SP, #40]
MOVW	R1, #10000
MOVT	R1, #0
MOV	R0, R1
MULS	R0, R2, R0
STR	R0, [SP, #40]
;driverrf4463pro.c,638 :: 		if ( ulFrequency >= 7600000 ) {
LDR	R1, [SP, #40]
MOVW	R0, #63360
MOVT	R0, #115
CMP	R1, R0
IT	CC
BLCC	L_rf_init_freq99
;driverrf4463pro.c,639 :: 		ucOUTDIV = 4;
MOVS	R0, #4
STR	R0, [SP, #0]
;driverrf4463pro.c,640 :: 		ucBAND = 0;
MOVS	R0, #0
STR	R0, [SP, #16]
;driverrf4463pro.c,641 :: 		ucVCO = 0xFF;
MOVS	R0, #255
STR	R0, [SP, #8]
;driverrf4463pro.c,642 :: 		}
IT	AL
BLAL	L_rf_init_freq100
L_rf_init_freq99:
;driverrf4463pro.c,645 :: 		else if ( ulFrequency >= 5460000 ) {
LDR	R1, [SP, #40]
MOVW	R0, #20512
MOVT	R0, #83
CMP	R1, R0
IT	CC
BLCC	L_rf_init_freq101
;driverrf4463pro.c,646 :: 		ucOUTDIV = 6;
MOVS	R0, #6
STR	R0, [SP, #0]
;driverrf4463pro.c,647 :: 		ucBAND   = 1;
MOVS	R0, #1
STR	R0, [SP, #16]
;driverrf4463pro.c,648 :: 		ucVCO    = 0xFE;
MOVS	R0, #254
STR	R0, [SP, #8]
;driverrf4463pro.c,649 :: 		}
IT	AL
BLAL	L_rf_init_freq102
L_rf_init_freq101:
;driverrf4463pro.c,652 :: 		else if ( ulFrequency >= 3850000 ) {
LDR	R1, [SP, #40]
MOVW	R0, #48912
MOVT	R0, #58
CMP	R1, R0
IT	CC
BLCC	L_rf_init_freq103
;driverrf4463pro.c,653 :: 		ucOUTDIV = 8;
MOVS	R0, #8
STR	R0, [SP, #0]
;driverrf4463pro.c,654 :: 		ucBAND   = 2;
MOVS	R0, #2
STR	R0, [SP, #16]
;driverrf4463pro.c,655 :: 		ucVCO    = 0xFE;
MOVS	R0, #254
STR	R0, [SP, #8]
;driverrf4463pro.c,656 :: 		}
IT	AL
BLAL	L_rf_init_freq104
L_rf_init_freq103:
;driverrf4463pro.c,659 :: 		else if ( ulFrequency >= 2730000 ) {
LDR	R1, [SP, #40]
MOVW	R0, #43024
MOVT	R0, #41
CMP	R1, R0
IT	CC
BLCC	L_rf_init_freq105
;driverrf4463pro.c,660 :: 		ucOUTDIV = 12;
MOVS	R0, #12
STR	R0, [SP, #0]
;driverrf4463pro.c,661 :: 		ucBAND   = 3;
MOVS	R0, #3
STR	R0, [SP, #16]
;driverrf4463pro.c,662 :: 		ucVCO    = 0xFD;
MOVS	R0, #253
STR	R0, [SP, #8]
;driverrf4463pro.c,663 :: 		}
IT	AL
BLAL	L_rf_init_freq106
L_rf_init_freq105:
;driverrf4463pro.c,666 :: 		else if ( ulFrequency >= 1940000 ) {
LDR	R1, [SP, #40]
MOVW	R0, #39456
MOVT	R0, #29
CMP	R1, R0
IT	CC
BLCC	L_rf_init_freq107
;driverrf4463pro.c,667 :: 		ucOUTDIV = 16;
MOVS	R0, #16
STR	R0, [SP, #0]
;driverrf4463pro.c,668 :: 		ucBAND   = 4;
MOVS	R0, #4
STR	R0, [SP, #16]
;driverrf4463pro.c,669 :: 		ucVCO    = 0xFC;
MOVS	R0, #252
STR	R0, [SP, #8]
;driverrf4463pro.c,670 :: 		}
IT	AL
BLAL	L_rf_init_freq108
L_rf_init_freq107:
;driverrf4463pro.c,674 :: 		ucOUTDIV = 24;
MOVS	R0, #24
STR	R0, [SP, #0]
;driverrf4463pro.c,675 :: 		ucBAND   = 5;
MOVS	R0, #5
STR	R0, [SP, #16]
;driverrf4463pro.c,676 :: 		ucVCO    = 0xFA;
MOVS	R0, #250
STR	R0, [SP, #8]
;driverrf4463pro.c,677 :: 		}
L_rf_init_freq108:
L_rf_init_freq106:
L_rf_init_freq104:
L_rf_init_freq102:
L_rf_init_freq100:
;driverrf4463pro.c,679 :: 		ucDIV = ucOUTDIV / 2;
LDR	R0, [SP, #0]
UXTB	R0, R0
MOVS	R2, #2
BL	__Div_32x32_U+0
STR	R0, [SP, #4]
;driverrf4463pro.c,681 :: 		ulData = ( ulFrequency * ucDIV ) / 3;          // ucDIV = 88.5 = 88   //// UCdiv = 2
LDR	R2, [SP, #4]
UXTB	R2, R2
LDR	R0, [SP, #40]
MOV	R1, R2
MULS	R1, R0, R1
MOVS	R2, #3
MOV	R0, R1
BL	__Div_32x32_U+0
STR	R0, [SP, #36]
;driverrf4463pro.c,682 :: 		ucINTE = ( ulData / 100000) - 1;               // ulData = 6 000 000  //// ULdATA = 9 000 000
LDR	R0, [SP, #36]
MOVW	R2, #34464
MOVT	R2, #1
BL	__Div_32x32_U+0
SUBS	R0, R0, #1
STR	R0, [SP, #12]
;driverrf4463pro.c,683 :: 		ulFRAC = ( ulData - ( ucINTE + 1 ) * 100000 ) * 16384 / 3125;         // ulFRAC = 15 728 640
LDR	R0, [SP, #12]
UXTB	R0, R0
ADDS	R2, R0, #1
SXTH	R2, R2
MOVW	R0, #34464
MOVT	R0, #1
MOV	R1, R0
MULS	R1, R2, R1
LDR	R0, [SP, #36]
SUBS	R2, R0, R1
MOVW	R0, #16384
MOVT	R0, #0
MOV	R1, R0
MULS	R1, R2, R1
MOVW	R2, #3125
MOVT	R2, #0
MOV	R0, R1
BL	__Div_32x32_U+0
STR	R0, [SP, #32]
;driverrf4463pro.c,684 :: 		ulFRAC = ulFRAC + 0x80000;
LDR	R1, [SP, #32]
MOVW	R0, #0
MOVT	R0, #8
ADDS	R0, R1, R0
STR	R0, [SP, #32]
;driverrf4463pro.c,686 :: 		ucFRAC_0 = ulFRAC;
LDR	R0, [SP, #32]
STR	R0, [SP, #28]
;driverrf4463pro.c,687 :: 		ulFRAC >>= 8;
LDR	R0, [SP, #32]
LSRS	R0, R0, #8
STR	R0, [SP, #32]
;driverrf4463pro.c,688 :: 		ucFRAC_1 = ulFRAC;
LDR	R0, [SP, #32]
STR	R0, [SP, #24]
;driverrf4463pro.c,689 :: 		ulFRAC >>= 8;
LDR	R0, [SP, #32]
LSRS	R0, R0, #8
STR	R0, [SP, #32]
;driverrf4463pro.c,690 :: 		ucFRAC_2 = ulFRAC;
LDR	R0, [SP, #32]
STR	R0, [SP, #20]
;driverrf4463pro.c,694 :: 		app_command_buf[ 0 ] = 0x11;           // SET property    MODEM_CLKGEN_BAND
MOVS	R0, #44
ADD	R0, SP, R0
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,695 :: 		app_command_buf[ 1 ] = 0x20;           // Group  // 0x2051
MOVS	R0, #44
ADD	R0, SP, R0
ADDS	R1, R0, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,696 :: 		app_command_buf[ 2 ] = 0x01;           // Num Arguments // Total 1 Parameters
MOVS	R0, #44
ADD	R0, SP, R0
ADDS	R1, R0, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,697 :: 		app_command_buf[ 3 ] = 0x51;           // Number  // 0x2051
MOVS	R0, #44
ADD	R0, SP, R0
ADDS	R1, R0, #3
MOVS	R0, #81
STRB	R0, [R1, #0]
;driverrf4463pro.c,698 :: 		app_command_buf[ 4 ] = 0x08 | ucBAND;  // Argumento  //  high performance mode , clk outpu = osc /4
MOVS	R0, #44
ADD	R0, SP, R0
ADDS	R2, R0, #4
LDR	R1, [SP, #16]
UXTB	R1, R1
MOVS	R0, #8
ORRS	R0, R1
STRB	R0, [R2, #0]
;driverrf4463pro.c,699 :: 		spi_write( 5, app_command_buf );
MOVS	R0, #44
ADD	R0, SP, R0
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,701 :: 		app_command_buf[ 0 ]  = 0x11;
MOVS	R0, #44
ADD	R0, SP, R0
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,702 :: 		app_command_buf[ 1 ]  = 0x40;    // 0x4000         FREQ_CONTROL_INTE
MOVS	R0, #44
ADD	R0, SP, R0
ADDS	R1, R0, #1
MOVS	R0, #64
STRB	R0, [R1, #0]
;driverrf4463pro.c,703 :: 		app_command_buf[ 2 ]  = 0x08;    // Total 8 Parameters
MOVS	R0, #44
ADD	R0, SP, R0
ADDS	R1, R0, #2
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,704 :: 		app_command_buf[ 3 ]  = 0x00;   // 0x4000
MOVS	R0, #44
ADD	R0, SP, R0
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,705 :: 		app_command_buf[ 4 ]  = ucINTE;   //  default value
MOVS	R0, #44
ADD	R0, SP, R0
ADDS	R1, R0, #4
LDR	R0, [SP, #12]
UXTB	R0, R0
STRB	R0, [R1, #0]
;driverrf4463pro.c,706 :: 		app_command_buf[ 5 ]  = ucFRAC_2;   //  defaul value
MOVS	R0, #44
ADD	R0, SP, R0
ADDS	R1, R0, #5
LDR	R0, [SP, #20]
UXTB	R0, R0
STRB	R0, [R1, #0]
;driverrf4463pro.c,707 :: 		app_command_buf[ 6 ]  = ucFRAC_1;   //  default value
MOVS	R0, #44
ADD	R0, SP, R0
ADDS	R1, R0, #6
LDR	R0, [SP, #24]
UXTB	R0, R0
STRB	R0, [R1, #0]
;driverrf4463pro.c,708 :: 		app_command_buf[ 7 ]  = ucFRAC_0;   // frac ,from WDS
MOVS	R0, #44
ADD	R0, SP, R0
ADDS	R1, R0, #7
LDR	R0, [SP, #28]
UXTB	R0, R0
STRB	R0, [R1, #0]
;driverrf4463pro.c,711 :: 		if ( ulRF4463Step == 250 ) {
MOVW	R0, #lo_addr(_ulRF4463Step+0)
MOVT	R0, #hi_addr(_ulRF4463Step+0)
LDR	R0, [R0, #0]
CMP	R0, #250
IT	NE
BLNE	L_rf_init_freq109
;driverrf4463pro.c,712 :: 		app_command_buf[ 8 ]  = step_250K_step1;   // channel step1  from wds  // al parecer aqu? esta el ancho del canal
MOVS	R0, #44
ADD	R0, SP, R0
MOV	R1, R0
ADDS	R1, #8
MOVS	R0, #34
STRB	R0, [R1, #0]
;driverrf4463pro.c,713 :: 		app_command_buf[ 9 ]  = step_250K_step0;   // channel step0  from wds
MOVS	R0, #44
ADD	R0, SP, R0
MOV	R1, R0
ADDS	R1, #9
MOVS	R0, #34
STRB	R0, [R1, #0]
;driverrf4463pro.c,714 :: 		}
IT	AL
BLAL	L_rf_init_freq110
L_rf_init_freq109:
;driverrf4463pro.c,715 :: 		else if ( ulRF4463Step == 500 ) {
MOVW	R0, #lo_addr(_ulRF4463Step+0)
MOVT	R0, #hi_addr(_ulRF4463Step+0)
LDR	R1, [R0, #0]
MOVS	R0, #255
ADDS	R0, #245
CMP	R1, R0
IT	NE
BLNE	L_rf_init_freq111
;driverrf4463pro.c,716 :: 		app_command_buf[ 8 ]  = step_500K_step1;   // channel step1  from wds  // al parecer aqu? esta el ancho del canal
MOVS	R0, #44
ADD	R0, SP, R0
MOV	R1, R0
ADDS	R1, #8
MOVS	R0, #68
STRB	R0, [R1, #0]
;driverrf4463pro.c,717 :: 		app_command_buf[ 9 ]  = step_500K_step0;   // channel step0  from wds
MOVS	R0, #44
ADD	R0, SP, R0
MOV	R1, R0
ADDS	R1, #9
MOVS	R0, #68
STRB	R0, [R1, #0]
;driverrf4463pro.c,718 :: 		}
L_rf_init_freq111:
L_rf_init_freq110:
;driverrf4463pro.c,720 :: 		app_command_buf[ 10 ] = 0x20;  //  from wds Without this Values
MOVS	R0, #44
ADD	R0, SP, R0
MOV	R1, R0
ADDS	R1, #10
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,721 :: 		app_command_buf[ 11 ] = ucVCO;    // from wds Without this Values
MOVS	R0, #44
ADD	R0, SP, R0
MOV	R1, R0
ADDS	R1, #11
LDR	R0, [SP, #8]
UXTB	R0, R0
STRB	R0, [R1, #0]
;driverrf4463pro.c,722 :: 		spi_write( 12, app_command_buf );
MOVS	R0, #44
ADD	R0, SP, R0
PUSH	(R0)
MOVS	R0, #12
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,723 :: 		}
L_end_rf_init_freq:
ADD	SP, SP, #64
POP	(R15)
; end of _rf_init_freq
_ucRf4463SPIByte:
;driverrf4463pro.c,743 :: 		unsigned char ucRf4463SPIByte( unsigned char ucData ) {
PUSH	(R14)
;driverrf4463pro.c,745 :: 		ucSPI2ByteReceived = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucSPI2ByteReceived+0)
MOVT	R0, #hi_addr(_ucSPI2ByteReceived+0)
STRB	R1, [R0, #0]
;driverrf4463pro.c,747 :: 		SPI2_DR = ucData;
LDR	R1, [SP, #4]
UXTB	R1, R1
MOVW	R0, #lo_addr(SPI2_DR+0)
MOVT	R0, #hi_addr(SPI2_DR+0)
STR	R1, [R0, #0]
;driverrf4463pro.c,749 :: 		while ( !SPI2_SRbits.TXE );                // espera a que el buffer este vacio
L_ucRf4463SPIByte112:
MOVW	R0, #lo_addr(SPI2_SRbits+0)
MOVT	R0, #hi_addr(SPI2_SRbits+0)
_LX	[R0, ByteOffset(SPI2_SRbits+0)]
MOVS	R0, #2
ANDS	R0, R1
LSRS	R0, R0, #1
CMP	R0, #0
IT	NE
BLNE	L_ucRf4463SPIByte113
IT	AL
BLAL	L_ucRf4463SPIByte112
L_ucRf4463SPIByte113:
;driverrf4463pro.c,751 :: 		while ( SPI2_SRbits.BSY );                // espera a que el buffer este vacio
L_ucRf4463SPIByte114:
MOVW	R0, #lo_addr(SPI2_SRbits+0)
MOVT	R0, #hi_addr(SPI2_SRbits+0)
_LX	[R0, ByteOffset(SPI2_SRbits+0)]
MOVS	R0, #128
ANDS	R0, R1
LSRS	R0, R0, #7
CMP	R0, #0
IT	EQ
BLEQ	L_ucRf4463SPIByte115
IT	AL
BLAL	L_ucRf4463SPIByte114
L_ucRf4463SPIByte115:
;driverrf4463pro.c,753 :: 		return ( ucSPI2ByteReceived );
MOVW	R0, #lo_addr(_ucSPI2ByteReceived+0)
MOVT	R0, #hi_addr(_ucSPI2ByteReceived+0)
LDRB	R0, [R0, #0]
;driverrf4463pro.c,755 :: 		}
L_end_ucRf4463SPIByte:
POP	(R15)
; end of _ucRf4463SPIByte
_spi_write:
;driverrf4463pro.c,760 :: 		void spi_write( unsigned char tx_length, unsigned char *p ) {
PUSH	(R14)
SUB	SP, SP, #8
;driverrf4463pro.c,763 :: 		i = 0;
MOVS	R0, #0
STR	R0, [SP, #0]
;driverrf4463pro.c,764 :: 		while ( i != 0xFF ) {
L_spi_write116:
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, #255
IT	EQ
BLEQ	L_spi_write117
;driverrf4463pro.c,765 :: 		i = check_cts();
BL	_check_cts+0
STR	R0, [SP, #0]
;driverrf4463pro.c,766 :: 		}
IT	AL
BLAL	L_spi_write116
L_spi_write117:
;driverrf4463pro.c,768 :: 		nSEL = 0;                              // habilita escritura
MOVW	R2, #lo_addr(GPIOB_ODR+0)
MOVT	R2, #hi_addr(GPIOB_ODR+0)
_LX	[R2, ByteOffset(GPIOB_ODR+0)]
MOVS	R1, #1
LSLS	R1, R1, #12
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODR+0)]
;driverrf4463pro.c,770 :: 		for ( i = 0; i < tx_length; i++ ) {
MOVS	R0, #0
STR	R0, [SP, #0]
L_spi_write118:
LDR	R1, [SP, #12]
UXTB	R1, R1
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, R1
IT	CS
BLCS	L_spi_write119
;driverrf4463pro.c,771 :: 		j = *( p + i );
LDR	R1, [SP, #0]
UXTB	R1, R1
LDR	R0, [SP, #16]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STR	R0, [SP, #4]
;driverrf4463pro.c,772 :: 		ucRf4463SPIByte( j );
LDR	R0, [SP, #4]
UXTB	R0, R0
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,770 :: 		for ( i = 0; i < tx_length; i++ ) {
LDR	R0, [SP, #0]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #0]
;driverrf4463pro.c,773 :: 		}
IT	AL
BLAL	L_spi_write118
L_spi_write119:
;driverrf4463pro.c,775 :: 		nSEL = 1;                              // desabilita escritura
MOVW	R2, #lo_addr(GPIOB_ODR+0)
MOVT	R2, #hi_addr(GPIOB_ODR+0)
_LX	[R2, ByteOffset(GPIOB_ODR+0)]
MOVS	R1, #1
LSLS	R1, R1, #12
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODR+0)]
;driverrf4463pro.c,776 :: 		}
L_end_spi_write:
ADD	SP, SP, #8
POP	(R15)
; end of _spi_write
_check_cts:
;driverrf4463pro.c,781 :: 		unsigned char check_cts( void ) {           // This Command follows the Command and reads the response
PUSH	(R14)
SUB	SP, SP, #4
;driverrf4463pro.c,784 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOB_ODR+0)
MOVT	R2, #hi_addr(GPIOB_ODR+0)
_LX	[R2, ByteOffset(GPIOB_ODR+0)]
MOVS	R1, #1
LSLS	R1, R1, #12
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODR+0)]
;driverrf4463pro.c,785 :: 		nSEL = 0;
MOVW	R2, #lo_addr(GPIOB_ODR+0)
MOVT	R2, #hi_addr(GPIOB_ODR+0)
_LX	[R2, ByteOffset(GPIOB_ODR+0)]
MOVS	R1, #1
LSLS	R1, R1, #12
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODR+0)]
;driverrf4463pro.c,786 :: 		ucRf4463SPIByte( 0x44 );
MOVS	R0, #68
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,787 :: 		i = ucRf4463SPIByte( 0 );
MOVS	R0, #0
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
STR	R0, [SP, #0]
;driverrf4463pro.c,788 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOB_ODR+0)
MOVT	R2, #hi_addr(GPIOB_ODR+0)
_LX	[R2, ByteOffset(GPIOB_ODR+0)]
MOVS	R1, #1
LSLS	R1, R1, #12
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODR+0)]
;driverrf4463pro.c,789 :: 		return ( i );
LDR	R0, [SP, #0]
UXTB	R0, R0
;driverrf4463pro.c,790 :: 		}
L_end_check_cts:
ADD	SP, SP, #4
POP	(R15)
; end of _check_cts
_spi_read:
;driverrf4463pro.c,795 :: 		void spi_read( unsigned char data_length, unsigned char api_command ) {
PUSH	(R14)
SUB	SP, SP, #12
;driverrf4463pro.c,799 :: 		p[ 0 ] = api_command;
MOVS	R0, #4
ADD	R0, SP, R0
ADDS	R1, R0, #0
LDR	R0, [SP, #20]
UXTB	R0, R0
STRB	R0, [R1, #0]
;driverrf4463pro.c,800 :: 		i = 0;
MOVS	R0, #0
STR	R0, [SP, #0]
;driverrf4463pro.c,801 :: 		while ( i != 0xFF ) {
L_spi_read121:
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, #255
IT	EQ
BLEQ	L_spi_read122
;driverrf4463pro.c,802 :: 		i = check_cts();                // Check if you can send Command
BL	_check_cts+0
STR	R0, [SP, #0]
;driverrf4463pro.c,803 :: 		}
IT	AL
BLAL	L_spi_read121
L_spi_read122:
;driverrf4463pro.c,805 :: 		spi_write( 1, p );    // Send Command
MOVS	R0, #4
ADD	R0, SP, R0
PUSH	(R0)
MOVS	R0, #1
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,807 :: 		i = 0;
MOVS	R0, #0
STR	R0, [SP, #0]
;driverrf4463pro.c,808 :: 		while ( i != 0xFF ) {
L_spi_read123:
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, #255
IT	EQ
BLEQ	L_spi_read124
;driverrf4463pro.c,809 :: 		i = check_cts();        //Check whether the data can be read
BL	_check_cts+0
STR	R0, [SP, #0]
;driverrf4463pro.c,810 :: 		}
IT	AL
BLAL	L_spi_read123
L_spi_read124:
;driverrf4463pro.c,812 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOB_ODR+0)
MOVT	R2, #hi_addr(GPIOB_ODR+0)
_LX	[R2, ByteOffset(GPIOB_ODR+0)]
MOVS	R1, #1
LSLS	R1, R1, #12
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODR+0)]
;driverrf4463pro.c,813 :: 		nSEL = 0;
MOVW	R2, #lo_addr(GPIOB_ODR+0)
MOVT	R2, #hi_addr(GPIOB_ODR+0)
_LX	[R2, ByteOffset(GPIOB_ODR+0)]
MOVS	R1, #1
LSLS	R1, R1, #12
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODR+0)]
;driverrf4463pro.c,814 :: 		ucRf4463SPIByte( 0x44 );
MOVS	R0, #68
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,815 :: 		for ( i = 0; i < data_length; i++ ) {        // Read data
MOVS	R0, #0
STR	R0, [SP, #0]
L_spi_read125:
LDR	R1, [SP, #16]
UXTB	R1, R1
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, R1
IT	CS
BLCS	L_spi_read126
;driverrf4463pro.c,816 :: 		spi_read_buf[ i ] = ucRf4463SPIByte( 0x00 );             // 0x00
LDR	R1, [SP, #0]
UXTB	R1, R1
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
;driverrf4463pro.c,817 :: 		Delay_ms(1);
LDR	R7, [PC, #5332]
NOP
L_spi_read128:
SUBS	R7, R7, #1
BNE	L_spi_read128
B	#4
	#5332
NOP
;driverrf4463pro.c,815 :: 		for ( i = 0; i < data_length; i++ ) {        // Read data
LDR	R0, [SP, #0]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #0]
;driverrf4463pro.c,818 :: 		}
IT	AL
BLAL	L_spi_read125
L_spi_read126:
;driverrf4463pro.c,819 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOB_ODR+0)
MOVT	R2, #hi_addr(GPIOB_ODR+0)
_LX	[R2, ByteOffset(GPIOB_ODR+0)]
MOVS	R1, #1
LSLS	R1, R1, #12
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODR+0)]
;driverrf4463pro.c,820 :: 		}
L_end_spi_read:
ADD	SP, SP, #12
POP	(R15)
; end of _spi_read
_spi_fast_read:
;driverrf4463pro.c,825 :: 		void spi_fast_read( unsigned char api_command ) {
PUSH	(R14)
SUB	SP, SP, #12
;driverrf4463pro.c,828 :: 		p[0] = api_command;
MOVS	R0, #4
ADD	R0, SP, R0
ADDS	R1, R0, #0
LDR	R0, [SP, #16]
UXTB	R0, R0
STRB	R0, [R1, #0]
;driverrf4463pro.c,829 :: 		i = 0;
MOVS	R0, #0
STR	R0, [SP, #0]
;driverrf4463pro.c,830 :: 		while ( i != 0xFF ) {
L_spi_fast_read130:
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, #255
IT	EQ
BLEQ	L_spi_fast_read131
;driverrf4463pro.c,831 :: 		i = check_cts();                // Check if you can send Command
BL	_check_cts+0
STR	R0, [SP, #0]
;driverrf4463pro.c,832 :: 		}
IT	AL
BLAL	L_spi_fast_read130
L_spi_fast_read131:
;driverrf4463pro.c,834 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOB_ODR+0)
MOVT	R2, #hi_addr(GPIOB_ODR+0)
_LX	[R2, ByteOffset(GPIOB_ODR+0)]
MOVS	R1, #1
LSLS	R1, R1, #12
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODR+0)]
;driverrf4463pro.c,835 :: 		nSEL = 0;
MOVW	R2, #lo_addr(GPIOB_ODR+0)
MOVT	R2, #hi_addr(GPIOB_ODR+0)
_LX	[R2, ByteOffset(GPIOB_ODR+0)]
MOVS	R1, #1
LSLS	R1, R1, #12
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODR+0)]
;driverrf4463pro.c,836 :: 		ucRf4463SPIByte( api_command );    // Send Command
LDR	R0, [SP, #16]
UXTB	R0, R0
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,837 :: 		for ( i = 0; i < 4; i++ ) {
MOVS	R0, #0
STR	R0, [SP, #0]
L_spi_fast_read132:
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, #4
IT	CS
BLCS	L_spi_fast_read133
;driverrf4463pro.c,838 :: 		spi_read_buf[ i ] = ucRf4463SPIByte( 0xFF );   // Read out all the 4 registers Value of
LDR	R1, [SP, #0]
UXTB	R1, R1
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
LDR	R0, [SP, #0]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #0]
;driverrf4463pro.c,839 :: 		}
IT	AL
BLAL	L_spi_fast_read132
L_spi_fast_read133:
;driverrf4463pro.c,840 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOB_ODR+0)
MOVT	R2, #hi_addr(GPIOB_ODR+0)
_LX	[R2, ByteOffset(GPIOB_ODR+0)]
MOVS	R1, #1
LSLS	R1, R1, #12
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODR+0)]
;driverrf4463pro.c,841 :: 		}
L_end_spi_fast_read:
ADD	SP, SP, #12
POP	(R15)
; end of _spi_fast_read
_spi_write_fifo:
;driverrf4463pro.c,846 :: 		void spi_write_fifo( void ) {
PUSH	(R14)
SUB	SP, SP, #4
;driverrf4463pro.c,849 :: 		i = 0;
MOVS	R0, #0
STR	R0, [SP, #0]
;driverrf4463pro.c,850 :: 		while ( i != 0xFF ) {
L_spi_write_fifo135:
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, #255
IT	EQ
BLEQ	L_spi_write_fifo136
;driverrf4463pro.c,851 :: 		i = check_cts();                // Check if you can send Command
BL	_check_cts+0
STR	R0, [SP, #0]
;driverrf4463pro.c,852 :: 		}
IT	AL
BLAL	L_spi_write_fifo135
L_spi_write_fifo136:
;driverrf4463pro.c,854 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOB_ODR+0)
MOVT	R2, #hi_addr(GPIOB_ODR+0)
_LX	[R2, ByteOffset(GPIOB_ODR+0)]
MOVS	R1, #1
LSLS	R1, R1, #12
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODR+0)]
;driverrf4463pro.c,855 :: 		nSEL = 0;
MOVW	R2, #lo_addr(GPIOB_ODR+0)
MOVT	R2, #hi_addr(GPIOB_ODR+0)
_LX	[R2, ByteOffset(GPIOB_ODR+0)]
MOVS	R1, #1
LSLS	R1, R1, #12
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODR+0)]
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
BLNE	L_spi_write_fifo137
;driverrf4463pro.c,859 :: 		for ( i = 0; i < payload_length; i++ ) {
MOVS	R0, #0
STR	R0, [SP, #0]
L_spi_write_fifo138:
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, #66
IT	CS
BLCS	L_spi_write_fifo139
;driverrf4463pro.c,860 :: 		ucRf4463SPIByte( tx_test_aa_data[ i ] );   // Send 10 test data
LDR	R1, [SP, #0]
UXTB	R1, R1
MOVW	R0, #lo_addr(_tx_test_aa_data+0)
MOVT	R0, #hi_addr(_tx_test_aa_data+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,859 :: 		for ( i = 0; i < payload_length; i++ ) {
LDR	R0, [SP, #0]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #0]
;driverrf4463pro.c,861 :: 		}
IT	AL
BLAL	L_spi_write_fifo138
L_spi_write_fifo139:
;driverrf4463pro.c,862 :: 		}
IT	AL
BLAL	L_spi_write_fifo141
L_spi_write_fifo137:
;driverrf4463pro.c,864 :: 		for ( i = 0; i < payload_length; i++ ) {
MOVS	R0, #0
STR	R0, [SP, #0]
L_spi_write_fifo142:
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, #66
IT	CS
BLCS	L_spi_write_fifo143
;driverrf4463pro.c,865 :: 		ucRf4463SPIByte( ucRF4463TXdata[ i ] );
LDR	R1, [SP, #0]
UXTB	R1, R1
MOVW	R0, #lo_addr(_ucRF4463TXdata+0)
MOVT	R0, #hi_addr(_ucRF4463TXdata+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,864 :: 		for ( i = 0; i < payload_length; i++ ) {
LDR	R0, [SP, #0]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #0]
;driverrf4463pro.c,866 :: 		}
IT	AL
BLAL	L_spi_write_fifo142
L_spi_write_fifo143:
;driverrf4463pro.c,867 :: 		}
L_spi_write_fifo141:
;driverrf4463pro.c,868 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOB_ODR+0)
MOVT	R2, #hi_addr(GPIOB_ODR+0)
_LX	[R2, ByteOffset(GPIOB_ODR+0)]
MOVS	R1, #1
LSLS	R1, R1, #12
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODR+0)]
;driverrf4463pro.c,869 :: 		}
L_end_spi_write_fifo:
ADD	SP, SP, #4
POP	(R15)
; end of _spi_write_fifo
_spi_read_fifo:
;driverrf4463pro.c,874 :: 		void spi_read_fifo( void ) {
PUSH	(R14)
SUB	SP, SP, #8
;driverrf4463pro.c,877 :: 		i = 0;
MOVS	R0, #0
STR	R0, [SP, #0]
;driverrf4463pro.c,878 :: 		while ( i != 0xFF ) {
L_spi_read_fifo145:
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, #255
IT	EQ
BLEQ	L_spi_read_fifo146
;driverrf4463pro.c,879 :: 		i = check_cts();                   // Check if you can send Command
BL	_check_cts+0
STR	R0, [SP, #0]
;driverrf4463pro.c,880 :: 		}
IT	AL
BLAL	L_spi_read_fifo145
L_spi_read_fifo146:
;driverrf4463pro.c,882 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOB_ODR+0)
MOVT	R2, #hi_addr(GPIOB_ODR+0)
_LX	[R2, ByteOffset(GPIOB_ODR+0)]
MOVS	R1, #1
LSLS	R1, R1, #12
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODR+0)]
;driverrf4463pro.c,883 :: 		nSEL = 0;
MOVW	R2, #lo_addr(GPIOB_ODR+0)
MOVT	R2, #hi_addr(GPIOB_ODR+0)
_LX	[R2, ByteOffset(GPIOB_ODR+0)]
MOVS	R1, #1
LSLS	R1, R1, #12
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODR+0)]
;driverrf4463pro.c,884 :: 		ucRf4463SPIByte( READ_RX_FIFO );
MOVS	R0, #119
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,885 :: 		for ( i = 0; i < payload_length; i++ ) {
MOVS	R0, #0
STR	R0, [SP, #0]
L_spi_read_fifo147:
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, #66
IT	CS
BLCS	L_spi_read_fifo148
;driverrf4463pro.c,886 :: 		rx_buf[ i ] = ucRf4463SPIByte( 0xFF );      // Receive 10 test data
LDR	R1, [SP, #0]
UXTB	R1, R1
MOVW	R0, #lo_addr(_rx_buf+0)
MOVT	R0, #hi_addr(_rx_buf+0)
ADDS	R0, R0, R1
STR	R0, [SP, #4]
MOVS	R0, #255
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
LDR	R1, [SP, #4]
STRB	R0, [R1, #0]
;driverrf4463pro.c,885 :: 		for ( i = 0; i < payload_length; i++ ) {
LDR	R0, [SP, #0]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #0]
;driverrf4463pro.c,887 :: 		}
IT	AL
BLAL	L_spi_read_fifo147
L_spi_read_fifo148:
;driverrf4463pro.c,888 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOB_ODR+0)
MOVT	R2, #hi_addr(GPIOB_ODR+0)
_LX	[R2, ByteOffset(GPIOB_ODR+0)]
MOVS	R1, #1
LSLS	R1, R1, #12
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODR+0)]
;driverrf4463pro.c,889 :: 		}
L_end_spi_read_fifo:
ADD	SP, SP, #8
POP	(R15)
; end of _spi_read_fifo
_VRF4463SDNReset:
;driverrf4463pro.c,894 :: 		void VRF4463SDNReset( void ) {
PUSH	(R14)
SUB	SP, SP, #4
;driverrf4463pro.c,897 :: 		SDN = 1;
MOVW	R2, #lo_addr(GPIOC_ODR+0)
MOVT	R2, #hi_addr(GPIOC_ODR+0)
_LX	[R2, ByteOffset(GPIOC_ODR+0)]
MOVS	R1, #1
LSLS	R1, R1, #15
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOC_ODR+0)]
;driverrf4463pro.c,898 :: 		Delay_ms( 6 );        // RF Module reset  DELAY
LDR	R7, [PC, #31998]
NOP
L_VRF4463SDNReset150:
SUBS	R7, R7, #1
BNE	L_VRF4463SDNReset150
B	#4
	#31998
NOP
;driverrf4463pro.c,899 :: 		SDN = 0;
MOVW	R2, #lo_addr(GPIOC_ODR+0)
MOVT	R2, #hi_addr(GPIOC_ODR+0)
_LX	[R2, ByteOffset(GPIOC_ODR+0)]
MOVS	R1, #1
LSLS	R1, R1, #15
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOC_ODR+0)]
;driverrf4463pro.c,900 :: 		Delay_ms( 10 );       // Delay 10ms for RF module to enter working state
LDR	R7, [PC, #53332]
NOP
L_VRF4463SDNReset152:
SUBS	R7, R7, #1
BNE	L_VRF4463SDNReset152
B	#4
	#53332
NOP
;driverrf4463pro.c,902 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOB_ODR+0)
MOVT	R2, #hi_addr(GPIOB_ODR+0)
_LX	[R2, ByteOffset(GPIOB_ODR+0)]
MOVS	R1, #1
LSLS	R1, R1, #12
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODR+0)]
;driverrf4463pro.c,903 :: 		nSEL = 0;
MOVW	R2, #lo_addr(GPIOB_ODR+0)
MOVT	R2, #hi_addr(GPIOB_ODR+0)
_LX	[R2, ByteOffset(GPIOB_ODR+0)]
MOVS	R1, #1
LSLS	R1, R1, #12
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODR+0)]
;driverrf4463pro.c,904 :: 		for ( i = 0; i < 7; i++ ) {
MOVS	R0, #0
STR	R0, [SP, #0]
L_VRF4463SDNReset154:
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, #7
IT	CS
BLCS	L_VRF4463SDNReset155
;driverrf4463pro.c,905 :: 		ucRf4463SPIByte( RF_POWER_UP_data[ i ] );   // send power up Command
LDR	R1, [SP, #0]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_POWER_UP_data+0)
MOVT	R0, #hi_addr(_RF_POWER_UP_data+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,904 :: 		for ( i = 0; i < 7; i++ ) {
LDR	R0, [SP, #0]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #0]
;driverrf4463pro.c,906 :: 		}
IT	AL
BLAL	L_VRF4463SDNReset154
L_VRF4463SDNReset155:
;driverrf4463pro.c,907 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOB_ODR+0)
MOVT	R2, #hi_addr(GPIOB_ODR+0)
_LX	[R2, ByteOffset(GPIOB_ODR+0)]
MOVS	R1, #1
LSLS	R1, R1, #12
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODR+0)]
;driverrf4463pro.c,910 :: 		}
L_end_VRF4463SDNReset:
ADD	SP, SP, #4
POP	(R15)
; end of _VRF4463SDNReset
_ucASCIIToByte:
;utils.c,41 :: 		unsigned char ucASCIIToByte( unsigned char * pcASCIIBuffer ){
PUSH	(R14)
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
ADDS	R0, #0
LDRB	R0, [R0, #0]
MOV	R1, R0
SUBS	R1, #48
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,46 :: 		if( ucMSBNibble > 9 ){
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
LDRB	R0, [R0, #0]
CMP	R0, #9
IT	LS
BLLS	L_ucASCIIToByte157
;utils.c,47 :: 		ucMSBNibble -= 7;
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
LDRB	R0, [R0, #0]
SUBS	R1, R0, #7
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,48 :: 		}
L_ucASCIIToByte157:
;utils.c,50 :: 		ucLSBNibble = ( pcASCIIBuffer[ 1 ] - 0x30 );
LDR	R0, [SP, #4]
ADDS	R0, #1
LDRB	R0, [R0, #0]
MOV	R1, R0
SUBS	R1, #48
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,51 :: 		if( ucLSBNibble > 9 ){
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
LDRB	R0, [R0, #0]
CMP	R0, #9
IT	LS
BLLS	L_ucASCIIToByte158
;utils.c,52 :: 		ucLSBNibble -= 7;
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
LDRB	R0, [R0, #0]
SUBS	R1, R0, #7
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,53 :: 		}
L_ucASCIIToByte158:
;utils.c,55 :: 		return ( ucMSBNibble << 4 | ucLSBNibble );
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #4
UXTH	R1, R1
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
LDRB	R0, [R0, #0]
ORRS	R0, R1
UXTB	R0, R0
;utils.c,56 :: 		}
L_end_ucASCIIToByte:
POP	(R15)
; end of _ucASCIIToByte
_vASCIIToHex:
;utils.c,61 :: 		void vASCIIToHex( unsigned char *pcHexConvertBuffer, unsigned char *pcASCIIConvertBuffer, unsigned char ucConversionLength ){
PUSH	(R14)
SUB	SP, SP, #4
;utils.c,62 :: 		unsigned char ucASCIICounter = 0;
MOVS	R0, #0
STR	R0, [SP, #0]
;utils.c,64 :: 		for( ucASCIICounter = 0; ucASCIICounter < ucConversionLength; ucASCIICounter++ ){
MOVS	R0, #0
STR	R0, [SP, #0]
L_vASCIIToHex159:
LDR	R1, [SP, #16]
UXTB	R1, R1
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, R1
IT	CS
BLCS	L_vASCIIToHex160
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
LDR	R2, [SP, #0]
UXTB	R2, R2
MOVS	R0, #2
MOV	R1, R0
MULS	R1, R2, R1
SXTH	R1, R1
LDR	R0, [SP, #12]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
MOV	R1, R0
SUBS	R1, #48
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,69 :: 		if( ucMSBNibble > 9 ){
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
LDRB	R0, [R0, #0]
CMP	R0, #9
IT	LS
BLLS	L_vASCIIToHex162
;utils.c,70 :: 		ucMSBNibble -= 7;
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
LDRB	R0, [R0, #0]
SUBS	R1, R0, #7
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,71 :: 		}
L_vASCIIToHex162:
;utils.c,73 :: 		ucLSBNibble = ( pcASCIIConvertBuffer[ ( ucASCIICounter * 2 ) + 1 ] - 0x30 );
LDR	R2, [SP, #0]
UXTB	R2, R2
MOVS	R1, #2
MOV	R0, R1
MULS	R0, R2, R0
SXTH	R0, R0
ADDS	R1, R0, #1
SXTH	R1, R1
LDR	R0, [SP, #12]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
MOV	R1, R0
SUBS	R1, #48
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,74 :: 		if( ucLSBNibble > 9 ){
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
LDRB	R0, [R0, #0]
CMP	R0, #9
IT	LS
BLLS	L_vASCIIToHex163
;utils.c,75 :: 		ucLSBNibble -= 7;
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
LDRB	R0, [R0, #0]
SUBS	R1, R0, #7
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,76 :: 		}
L_vASCIIToHex163:
;utils.c,78 :: 		pcHexConvertBuffer[ ucASCIICounter ] = ( ( ucMSBNibble << 4 ) | ucLSBNibble );
LDR	R1, [SP, #0]
UXTB	R1, R1
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
ORRS	R0, R1
STRB	R0, [R2, #0]
;utils.c,64 :: 		for( ucASCIICounter = 0; ucASCIICounter < ucConversionLength; ucASCIICounter++ ){
LDR	R0, [SP, #0]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #0]
;utils.c,79 :: 		}
IT	AL
BLAL	L_vASCIIToHex159
L_vASCIIToHex160:
;utils.c,80 :: 		}
L_end_vASCIIToHex:
ADD	SP, SP, #4
POP	(R15)
; end of _vASCIIToHex
_vHexToASCII:
;utils.c,85 :: 		void vHexToASCII( unsigned char *pcASCIIConvertBuffer, unsigned char *pcHexConvertBuffer, unsigned char ucConversionLength ){
PUSH	(R14)
SUB	SP, SP, #4
;utils.c,86 :: 		unsigned char ucHexConvCounter = 0;
MOVS	R0, #0
STR	R0, [SP, #0]
;utils.c,88 :: 		for( ucHexConvCounter = 0; ucHexConvCounter < ucConversionLength; ucHexConvCounter++ ){
MOVS	R0, #0
STR	R0, [SP, #0]
L_vHexToASCII164:
LDR	R1, [SP, #16]
UXTB	R1, R1
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, R1
IT	CS
BLCS	L_vHexToASCII165
;utils.c,89 :: 		pcASCIIConvertBuffer[ ucHexConvCounter * 2 ]            = pcHexChar[ pcHexConvertBuffer[ ucHexConvCounter ] >> 4 ];
LDR	R2, [SP, #0]
UXTB	R2, R2
MOVS	R0, #2
MOV	R1, R0
MULS	R1, R2, R1
SXTH	R1, R1
LDR	R0, [SP, #8]
ADDS	R2, R0, R1
LDR	R1, [SP, #0]
UXTB	R1, R1
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
LDR	R2, [SP, #0]
UXTB	R2, R2
MOVS	R1, #2
MOV	R0, R1
MULS	R0, R2, R0
SXTH	R0, R0
ADDS	R1, R0, #1
SXTH	R1, R1
LDR	R0, [SP, #8]
ADDS	R2, R0, R1
LDR	R1, [SP, #0]
UXTB	R1, R1
LDR	R0, [SP, #12]
ADDS	R0, R0, R1
LDRB	R1, [R0, #0]
MOVS	R0, #15
ANDS	R1, R0
UXTB	R1, R1
MOVW	R0, #lo_addr(_pcHexChar+0)
MOVT	R0, #hi_addr(_pcHexChar+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;utils.c,88 :: 		for( ucHexConvCounter = 0; ucHexConvCounter < ucConversionLength; ucHexConvCounter++ ){
LDR	R0, [SP, #0]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #0]
;utils.c,91 :: 		}
IT	AL
BLAL	L_vHexToASCII164
L_vHexToASCII165:
;utils.c,92 :: 		}
L_end_vHexToASCII:
ADD	SP, SP, #4
POP	(R15)
; end of _vHexToASCII
_vBufferSetToZero:
;utils.c,97 :: 		void vBufferSetToZero( unsigned char * pcBufferToClean, unsigned int uslength ){
PUSH	(R14)
SUB	SP, SP, #4
;utils.c,98 :: 		unsigned int usPosition = 0;
MOV	R6, SP
MOVS	R5, #2
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICSvBufferSetToZero_usPosition_L0+0)
MOVT	R7, #hi_addr(?ICSvBufferSetToZero_usPosition_L0+0)
BL	___CC2DW+0
;utils.c,100 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
MOVS	R0, #0
STR	R0, [SP, #0]
L_vBufferSetToZero167:
LDR	R1, [SP, #12]
UXTH	R1, R1
LDR	R0, [SP, #0]
UXTH	R0, R0
CMP	R0, R1
IT	CS
BLCS	L_vBufferSetToZero168
;utils.c,101 :: 		pcBufferToClean[ usPosition ] = 0x00;
LDR	R1, [SP, #0]
UXTH	R1, R1
LDR	R0, [SP, #8]
ADDS	R1, R0, R1
MOVS	R0, #0
STRB	R0, [R1, #0]
;utils.c,100 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
LDR	R0, [SP, #0]
UXTH	R0, R0
ADDS	R0, #1
STR	R0, [SP, #0]
;utils.c,102 :: 		}
IT	AL
BLAL	L_vBufferSetToZero167
L_vBufferSetToZero168:
;utils.c,103 :: 		}
L_end_vBufferSetToZero:
ADD	SP, SP, #4
POP	(R15)
; end of _vBufferSetToZero
_vBufferSetTo255:
;utils.c,108 :: 		void vBufferSetTo255( unsigned char * pcBufferToClean, unsigned int uslength ){
PUSH	(R14)
SUB	SP, SP, #4
;utils.c,109 :: 		unsigned int usPosition = 0;
MOV	R6, SP
MOVS	R5, #2
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICSvBufferSetTo255_usPosition_L0+0)
MOVT	R7, #hi_addr(?ICSvBufferSetTo255_usPosition_L0+0)
BL	___CC2DW+0
;utils.c,111 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
MOVS	R0, #0
STR	R0, [SP, #0]
L_vBufferSetTo255170:
LDR	R1, [SP, #12]
UXTH	R1, R1
LDR	R0, [SP, #0]
UXTH	R0, R0
CMP	R0, R1
IT	CS
BLCS	L_vBufferSetTo255171
;utils.c,112 :: 		pcBufferToClean[ usPosition ] = 0xFF;
LDR	R1, [SP, #0]
UXTH	R1, R1
LDR	R0, [SP, #8]
ADDS	R1, R0, R1
MOVS	R0, #255
STRB	R0, [R1, #0]
;utils.c,111 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
LDR	R0, [SP, #0]
UXTH	R0, R0
ADDS	R0, #1
STR	R0, [SP, #0]
;utils.c,113 :: 		}
IT	AL
BLAL	L_vBufferSetTo255170
L_vBufferSetTo255171:
;utils.c,114 :: 		}
L_end_vBufferSetTo255:
ADD	SP, SP, #4
POP	(R15)
; end of _vBufferSetTo255
_vBufferSetToValue:
;utils.c,119 :: 		void vBufferSetToValue( unsigned char * pcBufferToClean, unsigned char ucValue, unsigned int uslength ){
PUSH	(R14)
SUB	SP, SP, #4
;utils.c,120 :: 		unsigned int usPosition = 0;
MOV	R6, SP
MOVS	R5, #2
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICSvBufferSetToValue_usPosition_L0+0)
MOVT	R7, #hi_addr(?ICSvBufferSetToValue_usPosition_L0+0)
BL	___CC2DW+0
;utils.c,122 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
MOVS	R0, #0
STR	R0, [SP, #0]
L_vBufferSetToValue173:
LDR	R1, [SP, #16]
UXTH	R1, R1
LDR	R0, [SP, #0]
UXTH	R0, R0
CMP	R0, R1
IT	CS
BLCS	L_vBufferSetToValue174
;utils.c,123 :: 		pcBufferToClean[ usPosition ] = ucValue;
LDR	R1, [SP, #0]
UXTH	R1, R1
LDR	R0, [SP, #8]
ADDS	R1, R0, R1
LDR	R0, [SP, #12]
UXTB	R0, R0
STRB	R0, [R1, #0]
;utils.c,122 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
LDR	R0, [SP, #0]
UXTH	R0, R0
ADDS	R0, #1
STR	R0, [SP, #0]
;utils.c,124 :: 		}
IT	AL
BLAL	L_vBufferSetToValue173
L_vBufferSetToValue174:
;utils.c,125 :: 		}
L_end_vBufferSetToValue:
ADD	SP, SP, #4
POP	(R15)
; end of _vBufferSetToValue
_vSerializeUUID:
;utils.c,130 :: 		void vSerializeUUID( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer ){
PUSH	(R14)
SUB	SP, SP, #4
;utils.c,131 :: 		unsigned char ucCounter = 0;
MOVS	R0, #0
STR	R0, [SP, #0]
;utils.c,133 :: 		for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
MOVS	R0, #0
STR	R0, [SP, #0]
L_vSerializeUUID176:
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, #12
IT	CS
BLCS	L_vSerializeUUID177
;utils.c,134 :: 		pcTextConvertBuffer[ ucCounter * 2 ]         = pcHexChar[ pcHexConvertBuffer[ ucCounter ] >> 4 ];
LDR	R2, [SP, #0]
UXTB	R2, R2
MOVS	R0, #2
MOV	R1, R0
MULS	R1, R2, R1
SXTH	R1, R1
LDR	R0, [SP, #8]
ADDS	R2, R0, R1
LDR	R1, [SP, #0]
UXTB	R1, R1
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
LDR	R2, [SP, #0]
UXTB	R2, R2
MOVS	R1, #2
MOV	R0, R1
MULS	R0, R2, R0
SXTH	R0, R0
ADDS	R1, R0, #1
SXTH	R1, R1
LDR	R0, [SP, #8]
ADDS	R2, R0, R1
LDR	R1, [SP, #0]
UXTB	R1, R1
LDR	R0, [SP, #12]
ADDS	R0, R0, R1
LDRB	R1, [R0, #0]
MOVS	R0, #15
ANDS	R1, R0
UXTB	R1, R1
MOVW	R0, #lo_addr(_pcHexChar+0)
MOVT	R0, #hi_addr(_pcHexChar+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;utils.c,133 :: 		for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
LDR	R0, [SP, #0]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #0]
;utils.c,136 :: 		}
IT	AL
BLAL	L_vSerializeUUID176
L_vSerializeUUID177:
;utils.c,137 :: 		}
L_end_vSerializeUUID:
ADD	SP, SP, #4
POP	(R15)
; end of _vSerializeUUID
_vSerializeMACAddress:
;utils.c,142 :: 		void vSerializeMACAddress( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer ){
PUSH	(R14)
SUB	SP, SP, #16
;utils.c,143 :: 		unsigned int usCounter = 0;
MOVS	R6, #12
ADD	R6, SP, R6
MOVS	R5, #2
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICSvSerializeMACAddress_usCounter_L0+0)
MOVT	R7, #hi_addr(?ICSvSerializeMACAddress_usCounter_L0+0)
BL	___CC2DW+0
;utils.c,146 :: 		vHexToASCII( pcDeviceMAC, pcHexConvertBuffer, 6 );
MOVS	R0, #6
PUSH	(R0)
LDR	R0, [SP, #28]
PUSH	(R0)
MOVS	R0, #8
ADD	R0, SP, R0
PUSH	(R0)
BL	_vHexToASCII+0
ADD	SP, SP, #12
;utils.c,148 :: 		for( usCounter = 0; usCounter < 6; usCounter++ ){
MOVS	R0, #0
STR	R0, [SP, #12]
L_vSerializeMACAddress179:
LDR	R0, [SP, #12]
UXTH	R0, R0
CMP	R0, #6
IT	CS
BLCS	L_vSerializeMACAddress180
;utils.c,149 :: 		pcTextConvertBuffer[ usCounter * 3 ]         = pcDeviceMAC[ usCounter * 2 ];
LDR	R2, [SP, #12]
UXTH	R2, R2
MOVS	R0, #3
MOV	R1, R0
MULS	R1, R2, R1
UXTH	R1, R1
LDR	R0, [SP, #20]
ADDS	R3, R0, R1
LDR	R2, [SP, #12]
UXTH	R2, R2
MOVS	R0, #2
MOV	R1, R0
MULS	R1, R2, R1
UXTH	R1, R1
MOV	R0, SP
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;utils.c,150 :: 		pcTextConvertBuffer[ ( usCounter * 3 ) + 1 ] = pcDeviceMAC[ ( usCounter * 2 ) + 1 ];
LDR	R2, [SP, #12]
UXTH	R2, R2
MOVS	R1, #3
MOV	R0, R1
MULS	R0, R2, R0
UXTH	R0, R0
ADDS	R1, R0, #1
UXTH	R1, R1
LDR	R0, [SP, #20]
ADDS	R3, R0, R1
LDR	R2, [SP, #12]
UXTH	R2, R2
MOVS	R1, #2
MOV	R0, R1
MULS	R0, R2, R0
UXTH	R0, R0
ADDS	R1, R0, #1
UXTH	R1, R1
MOV	R0, SP
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;utils.c,151 :: 		if( usCounter != 5 ){
LDR	R0, [SP, #12]
UXTH	R0, R0
CMP	R0, #5
IT	EQ
BLEQ	L_vSerializeMACAddress182
;utils.c,152 :: 		pcTextConvertBuffer[ ( usCounter * 3 ) + 2 ] = ':';
LDR	R2, [SP, #12]
UXTH	R2, R2
MOVS	R1, #3
MOV	R0, R1
MULS	R0, R2, R0
UXTH	R0, R0
ADDS	R1, R0, #2
UXTH	R1, R1
LDR	R0, [SP, #20]
ADDS	R1, R0, R1
MOVS	R0, #58
STRB	R0, [R1, #0]
;utils.c,153 :: 		}
L_vSerializeMACAddress182:
;utils.c,148 :: 		for( usCounter = 0; usCounter < 6; usCounter++ ){
LDR	R0, [SP, #12]
UXTH	R0, R0
ADDS	R0, #1
STR	R0, [SP, #12]
;utils.c,154 :: 		}
IT	AL
BLAL	L_vSerializeMACAddress179
L_vSerializeMACAddress180:
;utils.c,155 :: 		pcTextConvertBuffer[ 18 ] = '\0';
LDR	R0, [SP, #20]
MOV	R1, R0
ADDS	R1, #18
MOVS	R0, #0
STRB	R0, [R1, #0]
;utils.c,156 :: 		}
L_end_vSerializeMACAddress:
ADD	SP, SP, #16
POP	(R15)
; end of _vSerializeMACAddress
_vSerializeIPAddress:
;utils.c,161 :: 		void vSerializeIPAddress( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer ){
PUSH	(R14)
SUB	SP, SP, #16
;utils.c,162 :: 		unsigned char ucCounter = 0;
MOVS	R0, #0
STR	R0, [SP, #12]
;utils.c,165 :: 		memset( pcTextConvertBuffer, '\0', sizeof( pcTextConvertBuffer ) );
MOVS	R2, #4
MOVS	R1, #0
LDR	R0, [SP, #20]
BL	_memset+0
;utils.c,167 :: 		for( ucCounter = 0; ucCounter < 4; ucCounter++ ){
MOVS	R0, #0
STR	R0, [SP, #12]
L_vSerializeIPAddress183:
LDR	R0, [SP, #12]
UXTB	R0, R0
CMP	R0, #4
IT	CS
BLCS	L_vSerializeIPAddress184
;utils.c,169 :: 		ByteToStr( pcHexConvertBuffer[ ucCounter ], pcConvertText );
MOV	R5, SP
LDR	R1, [SP, #12]
UXTB	R1, R1
LDR	R0, [SP, #24]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
UXTB	R4, R0
MOV	R1, R5
UXTB	R0, R4
BL	_ByteToStr+0
;utils.c,171 :: 		strcat( pcTextConvertBuffer, Ltrim( pcConvertText ) );
MOV	R4, SP
MOV	R0, R4
BL	_Ltrim+0
MOV	R1, R0
LDR	R0, [SP, #20]
BL	_strcat+0
;utils.c,173 :: 		if( ucCounter != 3 ){
LDR	R0, [SP, #12]
UXTB	R0, R0
CMP	R0, #3
IT	EQ
BLEQ	L_vSerializeIPAddress186
;utils.c,174 :: 		strcat( pcTextConvertBuffer, "." );
MOVS	R6, #8
ADD	R6, SP, R6
MOVS	R5, #2
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr2_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr2_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #8
ADD	R0, SP, R0
MOV	R4, R0
MOV	R1, R4
LDR	R0, [SP, #20]
BL	_strcat+0
;utils.c,175 :: 		}
L_vSerializeIPAddress186:
;utils.c,167 :: 		for( ucCounter = 0; ucCounter < 4; ucCounter++ ){
LDR	R0, [SP, #12]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #12]
;utils.c,176 :: 		}
IT	AL
BLAL	L_vSerializeIPAddress183
L_vSerializeIPAddress184:
;utils.c,177 :: 		}
L_end_vSerializeIPAddress:
ADD	SP, SP, #16
POP	(R15)
; end of _vSerializeIPAddress
_vUARTISR:
;uarthandler.c,114 :: 		void vUARTISR() iv IVT_INT_USART1 ics ICS_AUTO{
PUSH	(R14)
;uarthandler.c,116 :: 		if( USART1_ISRbits.RXNE ){
MOVW	R0, #lo_addr(USART1_ISRbits+0)
MOVT	R0, #hi_addr(USART1_ISRbits+0)
_LX	[R0, ByteOffset(USART1_ISRbits+0)]
MOVS	R0, #32
ANDS	R0, R1
LSRS	R0, R0, #5
CMP	R0, #0
IT	EQ
BLEQ	L_vUARTISR187
;uarthandler.c,117 :: 		ucData1 = USART1_RDR;
MOVW	R0, #lo_addr(USART1_RDR+0)
MOVT	R0, #hi_addr(USART1_RDR+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
STRB	R1, [R0, #0]
;uarthandler.c,118 :: 		if ( ucData1 != CHR_CR && ucData1 != CHR_LF && ulUSART1ByteReceived < BUFFER_MAX_USART ) {
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #13
IT	EQ
BLEQ	L_vUARTISR190
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	EQ
BLEQ	L_vUARTISR190
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R1, [R0, #0]
MOVW	R0, #4096
MOVT	R0, #0
CMP	R1, R0
IT	CS
BLCS	L_vUARTISR190
L__vUARTISR367:
;uarthandler.c,121 :: 		ucData1 == CHR_s ||
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #83
IT	EQ
BLEQ	L__vUARTISR366
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #115
IT	EQ
BLEQ	L__vUARTISR366
;uarthandler.c,122 :: 		ucData1 == CHR_U ||
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #85
IT	EQ
BLEQ	L__vUARTISR366
;uarthandler.c,123 :: 		ucData1 == CHR_u ) &&
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #117
IT	EQ
BLEQ	L__vUARTISR366
IT	AL
BLAL	L_vUARTISR195
;uarthandler.c,124 :: 		ulUSART1ByteReceived == 0 ) {
L__vUARTISR366:
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BLNE	L_vUARTISR195
L__vUARTISR365:
;uarthandler.c,125 :: 		ucUSART1RXBuffer[ ulUSART1ByteReceived++ ] = ucData1;
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
;uarthandler.c,126 :: 		}
IT	AL
BLAL	L_vUARTISR196
L_vUARTISR195:
;uarthandler.c,129 :: 		ucUSART1RXBuffer[ 0 ] == CHR_s ||
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
LDRB	R0, [R0, #0]
CMP	R0, #83
IT	EQ
BLEQ	L__vUARTISR364
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
LDRB	R0, [R0, #0]
CMP	R0, #115
IT	EQ
BLEQ	L__vUARTISR364
;uarthandler.c,130 :: 		ucUSART1RXBuffer[ 0 ] == CHR_U ||
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
LDRB	R0, [R0, #0]
CMP	R0, #85
IT	EQ
BLEQ	L__vUARTISR364
;uarthandler.c,131 :: 		ucUSART1RXBuffer[ 0 ] == CHR_u ) {
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
LDRB	R0, [R0, #0]
CMP	R0, #117
IT	EQ
BLEQ	L__vUARTISR364
IT	AL
BLAL	L_vUARTISR199
L__vUARTISR364:
;uarthandler.c,132 :: 		ucUSART1RXBuffer[ ulUSART1ByteReceived++ ] = ucData1;
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
;uarthandler.c,133 :: 		}
L_vUARTISR199:
L_vUARTISR196:
;uarthandler.c,134 :: 		}
IT	AL
BLAL	L_vUARTISR200
L_vUARTISR190:
;uarthandler.c,136 :: 		else if ( ucData1 == CHR_CR ) {
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #13
IT	NE
BLNE	L_vUARTISR201
;uarthandler.c,137 :: 		ucUSART1RXBuffer[ ulUSART1ByteReceived++ ] = ucData1;
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
;uarthandler.c,138 :: 		}
IT	AL
BLAL	L_vUARTISR202
L_vUARTISR201:
;uarthandler.c,140 :: 		else if ( ucData1 == CHR_LF && ucUSART1RXBuffer[ ulUSART1ByteReceived - 1 ] == CHR_CR ) {
MOVW	R0, #lo_addr(_ucData1+0)
MOVT	R0, #hi_addr(_ucData1+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	NE
BLNE	L_vUARTISR205
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
BLNE	L_vUARTISR205
L__vUARTISR363:
;uarthandler.c,141 :: 		ucUSART1RXBuffer[ ulUSART1ByteReceived++ ] = ucData1;
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
;uarthandler.c,142 :: 		fUSART1Buffer = READY_TO_READ;
MOVS	R1, #1
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
STR	R1, [R0, #0]
;uarthandler.c,143 :: 		}
L_vUARTISR205:
L_vUARTISR202:
L_vUARTISR200:
;uarthandler.c,144 :: 		}
L_vUARTISR187:
;uarthandler.c,145 :: 		}
L_end_vUARTISR:
POP	(R15)
; end of _vUARTISR
_vUSARTConfigUSART1:
;uarthandler.c,151 :: 		void vUSARTConfigUSART1 ( unsigned long ulBaudRate ) {
PUSH	(R14)
;uarthandler.c,153 :: 		UART1_Init_Advanced( ulBaudRate, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10 );
MOVW	R0, #lo_addr(__GPIO_MODULE_USART1_PA9_10+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_USART1_PA9_10+0)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #0
MOVS	R1, #0
LDR	R0, [SP, #8]
BL	_UART1_Init_Advanced+0
ADD	SP, SP, #4
;uarthandler.c,154 :: 		USART1_CR1bits.UE = 0;
MOVW	R2, #lo_addr(USART1_CR1bits+0)
MOVT	R2, #hi_addr(USART1_CR1bits+0)
_LX	[R2, ByteOffset(USART1_CR1bits+0)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(USART1_CR1bits+0)]
;uarthandler.c,156 :: 		ulClk = Clock_MHz() * 1000000;         // paso extra para verificacion en depuracion
MOVW	R1, #9216
MOVT	R1, #244
MOVW	R0, #lo_addr(_ulClk+0)
MOVT	R0, #hi_addr(_ulClk+0)
STR	R1, [R0, #0]
;uarthandler.c,160 :: 		USART1_CR1bits.UE = 1;
MOVW	R2, #lo_addr(USART1_CR1bits+0)
MOVT	R2, #hi_addr(USART1_CR1bits+0)
_LX	[R2, ByteOffset(USART1_CR1bits+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(USART1_CR1bits+0)]
;uarthandler.c,162 :: 		}
L_end_vUSARTConfigUSART1:
POP	(R15)
; end of _vUSARTConfigUSART1
_vUARTRxMessage:
;uarthandler.c,170 :: 		void vUARTRxMessage(){
PUSH	(R14)
SUB	SP, SP, #4
;uarthandler.c,171 :: 		unsigned int usCounter = 0;
MOV	R6, SP
MOVS	R5, #2
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICSvUARTRxMessage_usCounter_L0+0)
MOVT	R7, #hi_addr(?ICSvUARTRxMessage_usCounter_L0+0)
BL	___CC2DW+0
;uarthandler.c,183 :: 		usUARTMessageLength = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_usUARTMessageLength+0)
MOVT	R0, #hi_addr(_usUARTMessageLength+0)
STRH	R1, [R0, #0]
;uarthandler.c,184 :: 		}
L_end_vUARTRxMessage:
ADD	SP, SP, #4
POP	(R15)
; end of _vUARTRxMessage
_Timer2_interrupt:
;DriverRF4463PROMain.c,99 :: 		void Timer2_interrupt() iv IVT_INT_TIM2 {
SUB	SP, SP, #4
;DriverRF4463PROMain.c,100 :: 		TIM2_SR.UIF = 0;
MOVW	R2, #lo_addr(TIM2_SR+0)
MOVT	R2, #hi_addr(TIM2_SR+0)
_LX	[R2, ByteOffset(TIM2_SR+0)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(TIM2_SR+0)]
;DriverRF4463PROMain.c,101 :: 		Flag.rf_reach_timeout = 1; //Enter your code here
MOVW	R2, #lo_addr(_Flag+0)
MOVT	R2, #hi_addr(_Flag+0)
_LX	[R2, ByteOffset(_Flag+0)]
MOVS	R1, #4
ORRS	R0, R1
_SX	[R2, ByteOffset(_Flag+0)]
;DriverRF4463PROMain.c,102 :: 		Flag.reach_1s = 1;
MOVW	R2, #lo_addr(_Flag+0)
MOVT	R2, #hi_addr(_Flag+0)
_LX	[R2, ByteOffset(_Flag+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(_Flag+0)]
;DriverRF4463PROMain.c,103 :: 		}
L_end_Timer2_interrupt:
ADD	SP, SP, #4
BX	LR
; end of _Timer2_interrupt
_vRF4463MainApplyChanges:
;DriverRF4463PROMain.c,107 :: 		void vRF4463MainApplyChanges () {
PUSH	(R14)
;DriverRF4463PROMain.c,108 :: 		VRF4463SDNReset();
BL	_VRF4463SDNReset+0
;DriverRF4463PROMain.c,109 :: 		vRF4463Init();
BL	_vRF4463Init+0
;DriverRF4463PROMain.c,110 :: 		vRF4463ClearInterrupts();
BL	_vRF4463ClearInterrupts+0
;DriverRF4463PROMain.c,111 :: 		}
L_end_vRF4463MainApplyChanges:
POP	(R15)
; end of _vRF4463MainApplyChanges
_vRF4463MainSetTXString:
;DriverRF4463PROMain.c,114 :: 		void vRF4463MainSetTXString () {
SUB	SP, SP, #4
;DriverRF4463PROMain.c,119 :: 		}
L_end_vRF4463MainSetTXString:
ADD	SP, SP, #4
BX	LR
; end of _vRF4463MainSetTXString
_vRF4463MainCommandProcessor:
;DriverRF4463PROMain.c,123 :: 		void vRF4463MainCommandProcessor ( unsigned char *ucBuffer ) {
PUSH	(R14)
SUB	SP, SP, #508
SUB	SP, SP, #84
;DriverRF4463PROMain.c,124 :: 		unsigned char ucCommand [ 32 ] = { 0x00 };
MOVS	R6, #255
ADDS	R6, #221
ADD	R6, SP, R6
MOVS	R5, #109
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICSvRF4463MainCommandProcessor_ucCommand_L0+0)
MOVT	R7, #hi_addr(?ICSvRF4463MainCommandProcessor_ucCommand_L0+0)
BL	___CC2DW+0
;DriverRF4463PROMain.c,125 :: 		unsigned long ulArgument = 0;
;DriverRF4463PROMain.c,126 :: 		unsigned char ucLongArgument[ 64 ] = { 0x00 };     // Espera argumentos de hasta 11 bytes
;DriverRF4463PROMain.c,127 :: 		unsigned char ucCounterBuffer = 0;
;DriverRF4463PROMain.c,128 :: 		unsigned char ucCounterCommand = 0;
;DriverRF4463PROMain.c,129 :: 		unsigned char ucCounterLongArgument = 0;
;DriverRF4463PROMain.c,132 :: 		if ( ucBuffer[ 0 ] > '@' && ucBuffer[ 0 ] <= 'z' ) {
LDR	R0, [SP, #596]
ADDS	R0, #0
LDRB	R0, [R0, #0]
CMP	R0, #64
IT	LS
BLLS	L_vRF4463MainCommandProcessor208
LDR	R0, [SP, #596]
ADDS	R0, #0
LDRB	R0, [R0, #0]
CMP	R0, #122
IT	HI
BLHI	L_vRF4463MainCommandProcessor208
L__vRF4463MainCommandProcessor383:
;DriverRF4463PROMain.c,134 :: 		while ( ucBuffer[ ucCounterBuffer ] != '|' && ucCounterCommand < 32 ) {      // primer token
L_vRF4463MainCommandProcessor209:
LDR	R1, [SP, #576]
UXTB	R1, R1
LDR	R0, [SP, #596]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
CMP	R0, #124
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor210
LDR	R0, [SP, #580]
UXTB	R0, R0
CMP	R0, #32
IT	CS
BLCS	L_vRF4463MainCommandProcessor210
L__vRF4463MainCommandProcessor382:
;DriverRF4463PROMain.c,135 :: 		ucCommand[ ucCounterCommand++ ] = toupper( ucBuffer[ ucCounterBuffer++ ] );
MOVS	R1, #255
ADDS	R1, #221
ADD	R1, SP, R1
LDR	R0, [SP, #580]
UXTB	R0, R0
ADDS	R0, R1, R0
STR	R0, [SP, #588]
LDR	R1, [SP, #576]
UXTB	R1, R1
LDR	R0, [SP, #596]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
UXTB	R4, R0
UXTB	R0, R4
BL	_toupper+0
LDR	R1, [SP, #588]
STRB	R0, [R1, #0]
LDR	R0, [SP, #580]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #580]
LDR	R0, [SP, #576]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #576]
;DriverRF4463PROMain.c,136 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor209
L_vRF4463MainCommandProcessor210:
;DriverRF4463PROMain.c,138 :: 		ucCounterBuffer++;                                                           // evita el Token
LDR	R0, [SP, #576]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #576]
;DriverRF4463PROMain.c,140 :: 		while ( ucBuffer[ ucCounterBuffer ] != CHR_CR && ucCounterLongArgument < 64 ) {   // segundo token
L_vRF4463MainCommandProcessor213:
LDR	R1, [SP, #576]
UXTB	R1, R1
LDR	R0, [SP, #596]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
CMP	R0, #13
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor214
LDR	R0, [SP, #584]
UXTB	R0, R0
CMP	R0, #64
IT	CS
BLCS	L_vRF4463MainCommandProcessor214
L__vRF4463MainCommandProcessor381:
;DriverRF4463PROMain.c,141 :: 		ucLongArgument[ ucCounterLongArgument ] = ucBuffer[ ucCounterBuffer ] ;   //  toupper(
MOVW	R1, #512
MOVT	R1, #0
ADD	R1, SP, R1
LDR	R0, [SP, #584]
UXTB	R0, R0
ADDS	R2, R1, R0
LDR	R1, [SP, #576]
UXTB	R1, R1
LDR	R0, [SP, #596]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;DriverRF4463PROMain.c,142 :: 		ucCounterBuffer++;
LDR	R0, [SP, #576]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #576]
;DriverRF4463PROMain.c,143 :: 		ucCounterLongArgument++;
LDR	R0, [SP, #584]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #584]
;DriverRF4463PROMain.c,144 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor213
L_vRF4463MainCommandProcessor214:
;DriverRF4463PROMain.c,145 :: 		}
L_vRF4463MainCommandProcessor208:
;DriverRF4463PROMain.c,149 :: 		if ( memcmp( CMD_RADIO_POWER_SET, ucCommand, sizeof( CMD_RADIO_POWER_SET ) ) == 0x00 ) {
MOVS	R4, #255
ADDS	R4, #221
ADD	R4, SP, R4
MOVS	R2, #10
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_POWER_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_POWER_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor217
;DriverRF4463PROMain.c,150 :: 		ulArgument = StrToShort( ucLongArgument );
MOVW	R4, #512
MOVT	R4, #0
ADD	R4, SP, R4
MOV	R0, R4
BL	_StrToShort+0
STR	R0, [SP, #508]
;DriverRF4463PROMain.c,152 :: 		if ( ulArgument > 0 && ulArgument <= 127 ) {
LDR	R0, [SP, #508]
CMP	R0, #0
IT	LS
BLLS	L_vRF4463MainCommandProcessor220
LDR	R0, [SP, #508]
CMP	R0, #127
IT	HI
BLHI	L_vRF4463MainCommandProcessor220
L__vRF4463MainCommandProcessor380:
;DriverRF4463PROMain.c,153 :: 		ucRF4463Power = ulArgument;
LDR	R1, [SP, #508]
MOVW	R0, #lo_addr(_ucRF4463Power+0)
MOVT	R0, #hi_addr(_ucRF4463Power+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,154 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,156 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor221
L_vRF4463MainCommandProcessor220:
;DriverRF4463PROMain.c,158 :: 		UART1_Write_Text("ANS_COMMAND VALUE OUT OF RANGE");
MOV	R6, SP
MOVS	R5, #31
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr3_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr3_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOV	R0, SP
MOV	R4, R0
MOV	R0, R4
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,160 :: 		}
L_vRF4463MainCommandProcessor221:
;DriverRF4463PROMain.c,161 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor222
L_vRF4463MainCommandProcessor217:
;DriverRF4463PROMain.c,165 :: 		else if ( memcmp( CMD_RADIO_BAND_SET, ucCommand, sizeof( CMD_RADIO_BAND_SET ) ) == 0x00 ) {
MOVS	R4, #255
ADDS	R4, #221
ADD	R4, SP, R4
MOVS	R2, #9
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_BAND_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_BAND_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor223
;DriverRF4463PROMain.c,166 :: 		ulArgument = StrToInt( ucLongArgument );
MOVW	R4, #512
MOVT	R4, #0
ADD	R4, SP, R4
MOV	R0, R4
BL	_StrToInt+0
STR	R0, [SP, #508]
;DriverRF4463PROMain.c,168 :: 		if ( ulArgument == 433 || ulArgument == 868 || ulArgument == 915 ) {
LDR	R1, [SP, #508]
MOVS	R0, #255
ADDS	R0, #178
CMP	R1, R0
IT	EQ
BLEQ	L__vRF4463MainCommandProcessor379
LDR	R1, [SP, #508]
MOVW	R0, #868
MOVT	R0, #0
CMP	R1, R0
IT	EQ
BLEQ	L__vRF4463MainCommandProcessor379
LDR	R1, [SP, #508]
MOVW	R0, #915
MOVT	R0, #0
CMP	R1, R0
IT	EQ
BLEQ	L__vRF4463MainCommandProcessor379
IT	AL
BLAL	L_vRF4463MainCommandProcessor226
L__vRF4463MainCommandProcessor379:
;DriverRF4463PROMain.c,169 :: 		ucRF4463Freq3 = ucLongArgument[ 0 ] - 48;
MOVW	R0, #512
MOVT	R0, #0
ADD	R0, SP, R0
ADDS	R0, #0
LDRB	R0, [R0, #0]
MOV	R1, R0
SUBS	R1, #48
MOVW	R0, #lo_addr(_ucRF4463Freq3+0)
MOVT	R0, #hi_addr(_ucRF4463Freq3+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,170 :: 		ucRF4463Freq2 = ucLongArgument[ 1 ] - 48;
MOVW	R0, #512
MOVT	R0, #0
ADD	R0, SP, R0
ADDS	R0, #1
LDRB	R0, [R0, #0]
MOV	R1, R0
SUBS	R1, #48
MOVW	R0, #lo_addr(_ucRF4463Freq2+0)
MOVT	R0, #hi_addr(_ucRF4463Freq2+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,171 :: 		ucRF4463Freq1 = ucLongArgument[ 2 ] - 48;
MOVW	R0, #512
MOVT	R0, #0
ADD	R0, SP, R0
ADDS	R0, #2
LDRB	R0, [R0, #0]
MOV	R1, R0
SUBS	R1, #48
MOVW	R0, #lo_addr(_ucRF4463Freq1+0)
MOVT	R0, #hi_addr(_ucRF4463Freq1+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,172 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,174 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor227
L_vRF4463MainCommandProcessor226:
;DriverRF4463PROMain.c,176 :: 		UART1_Write_Text("ANS_COMMAND VALUE OUT OF RANGE");
MOVS	R6, #32
ADD	R6, SP, R6
MOVS	R5, #31
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr4_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr4_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #32
ADD	R0, SP, R0
MOV	R4, R0
MOV	R0, R4
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,178 :: 		}
L_vRF4463MainCommandProcessor227:
;DriverRF4463PROMain.c,179 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor228
L_vRF4463MainCommandProcessor223:
;DriverRF4463PROMain.c,183 :: 		else if ( memcmp( CMD_RADIO_RATE_SET, ucCommand, sizeof( CMD_RADIO_RATE_SET ) ) == 0x00 ) {
MOVS	R4, #255
ADDS	R4, #221
ADD	R4, SP, R4
MOVS	R2, #9
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_RATE_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_RATE_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor229
;DriverRF4463PROMain.c,184 :: 		ulArgument = StrToLong( ucLongArgument );
MOVW	R4, #512
MOVT	R4, #0
ADD	R4, SP, R4
MOV	R0, R4
BL	_StrToLong+0
STR	R0, [SP, #508]
;DriverRF4463PROMain.c,186 :: 		switch ( ulArgument ) {
IT	AL
BLAL	L_vRF4463MainCommandProcessor230
;DriverRF4463PROMain.c,187 :: 		case 500      : ucRF4463Rate = dr_500;
L_vRF4463MainCommandProcessor232:
MOVS	R1, #10
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,188 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,190 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor231
;DriverRF4463PROMain.c,191 :: 		case 1200     : ucRF4463Rate = dr_1p2;
L_vRF4463MainCommandProcessor233:
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,192 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,194 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor231
;DriverRF4463PROMain.c,195 :: 		case 2400     : ucRF4463Rate = dr_2p4;
L_vRF4463MainCommandProcessor234:
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,196 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,198 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor231
;DriverRF4463PROMain.c,199 :: 		case 4800     : ucRF4463Rate = dr_4p8;
L_vRF4463MainCommandProcessor235:
MOVS	R1, #2
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,200 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,202 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor231
;DriverRF4463PROMain.c,203 :: 		case 9600     : ucRF4463Rate = dr_9p6;
L_vRF4463MainCommandProcessor236:
MOVS	R1, #3
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,204 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,206 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor231
;DriverRF4463PROMain.c,207 :: 		case 19200    : ucRF4463Rate = dr_19p2;
L_vRF4463MainCommandProcessor237:
MOVS	R1, #4
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,208 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,210 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor231
;DriverRF4463PROMain.c,211 :: 		case 38400    : ucRF4463Rate = dr_38p4;
L_vRF4463MainCommandProcessor238:
MOVS	R1, #5
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,212 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,214 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor231
;DriverRF4463PROMain.c,215 :: 		case 76800    : ucRF4463Rate = dr_76p8;
L_vRF4463MainCommandProcessor239:
MOVS	R1, #6
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,216 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,218 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor231
;DriverRF4463PROMain.c,219 :: 		case 115200   : ucRF4463Rate = dr_115p2;
L_vRF4463MainCommandProcessor240:
MOVS	R1, #7
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,220 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,222 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor231
;DriverRF4463PROMain.c,223 :: 		case 256000   : ucRF4463Rate = dr_256k;
L_vRF4463MainCommandProcessor241:
MOVS	R1, #8
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,224 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,226 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor231
;DriverRF4463PROMain.c,227 :: 		case 500000   : ucRF4463Rate = dr_500k;
L_vRF4463MainCommandProcessor242:
MOVS	R1, #9
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,228 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,230 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor231
;DriverRF4463PROMain.c,231 :: 		default       : UART1_Write_Text("ANS_COMMAND VALUE OUT OF RANGE");
L_vRF4463MainCommandProcessor243:
MOVS	R6, #64
ADD	R6, SP, R6
MOVS	R5, #31
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr5_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr5_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #64
ADD	R0, SP, R0
MOV	R4, R0
MOV	R0, R4
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,233 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor231
L_vRF4463MainCommandProcessor230:
LDR	R1, [SP, #508]
MOVS	R0, #255
ADDS	R0, #245
CMP	R1, R0
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor232
LDR	R1, [SP, #508]
MOVW	R0, #1200
MOVT	R0, #0
CMP	R1, R0
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor233
LDR	R1, [SP, #508]
MOVW	R0, #2400
MOVT	R0, #0
CMP	R1, R0
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor234
LDR	R1, [SP, #508]
MOVW	R0, #4800
MOVT	R0, #0
CMP	R1, R0
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor235
LDR	R1, [SP, #508]
MOVW	R0, #9600
MOVT	R0, #0
CMP	R1, R0
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor236
LDR	R1, [SP, #508]
MOVW	R0, #19200
MOVT	R0, #0
CMP	R1, R0
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor237
LDR	R1, [SP, #508]
MOVW	R0, #38400
MOVT	R0, #0
CMP	R1, R0
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor238
LDR	R1, [SP, #508]
MOVW	R0, #11264
MOVT	R0, #1
CMP	R1, R0
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor239
LDR	R1, [SP, #508]
MOVW	R0, #49664
MOVT	R0, #1
CMP	R1, R0
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor240
LDR	R1, [SP, #508]
MOVW	R0, #59392
MOVT	R0, #3
CMP	R1, R0
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor241
LDR	R1, [SP, #508]
MOVW	R0, #41248
MOVT	R0, #7
CMP	R1, R0
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor242
IT	AL
BLAL	L_vRF4463MainCommandProcessor243
L_vRF4463MainCommandProcessor231:
;DriverRF4463PROMain.c,234 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor244
L_vRF4463MainCommandProcessor229:
;DriverRF4463PROMain.c,238 :: 		else if ( memcmp( CMD_RADIO_CHANNEL_SET, ucCommand, sizeof( CMD_RADIO_CHANNEL_SET ) ) == 0x00 ) {
MOVS	R4, #255
ADDS	R4, #221
ADD	R4, SP, R4
MOVS	R2, #12
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_CHANNEL_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_CHANNEL_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor245
;DriverRF4463PROMain.c,239 :: 		ulArgument = StrToInt( ucLongArgument );
MOVW	R4, #512
MOVT	R4, #0
ADD	R4, SP, R4
MOV	R0, R4
BL	_StrToInt+0
STR	R0, [SP, #508]
;DriverRF4463PROMain.c,241 :: 		if ( ulArgument >= 0 && ulArgument <= 50 ) {
LDR	R0, [SP, #508]
CMP	R0, #0
IT	CC
BLCC	L_vRF4463MainCommandProcessor248
LDR	R0, [SP, #508]
CMP	R0, #50
IT	HI
BLHI	L_vRF4463MainCommandProcessor248
L__vRF4463MainCommandProcessor378:
;DriverRF4463PROMain.c,242 :: 		ucRF4463FreqChannel = ulArgument;    // Se aplica al ejecutar funciones de TX o RX
LDR	R1, [SP, #508]
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,243 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,245 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor249
L_vRF4463MainCommandProcessor248:
;DriverRF4463PROMain.c,248 :: 		}
L_vRF4463MainCommandProcessor249:
;DriverRF4463PROMain.c,249 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor250
L_vRF4463MainCommandProcessor245:
;DriverRF4463PROMain.c,253 :: 		else if ( memcmp( CMD_RADIO_BW_SET, ucCommand, sizeof( CMD_RADIO_BW_SET ) ) == 0x00 ) {
MOVS	R4, #255
ADDS	R4, #221
ADD	R4, SP, R4
MOVS	R2, #7
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_BW_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_BW_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor251
;DriverRF4463PROMain.c,254 :: 		ulArgument = StrToInt( ucLongArgument );
MOVW	R4, #512
MOVT	R4, #0
ADD	R4, SP, R4
MOV	R0, R4
BL	_StrToInt+0
STR	R0, [SP, #508]
;DriverRF4463PROMain.c,256 :: 		if ( ulArgument == 250 || ulArgument == 500 ) {
LDR	R0, [SP, #508]
CMP	R0, #250
IT	EQ
BLEQ	L__vRF4463MainCommandProcessor377
LDR	R1, [SP, #508]
MOVS	R0, #255
ADDS	R0, #245
CMP	R1, R0
IT	EQ
BLEQ	L__vRF4463MainCommandProcessor377
IT	AL
BLAL	L_vRF4463MainCommandProcessor254
L__vRF4463MainCommandProcessor377:
;DriverRF4463PROMain.c,257 :: 		ulRF4463Step = ulArgument;
LDR	R1, [SP, #508]
MOVW	R0, #lo_addr(_ulRF4463Step+0)
MOVT	R0, #hi_addr(_ulRF4463Step+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,258 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,260 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor255
L_vRF4463MainCommandProcessor254:
;DriverRF4463PROMain.c,262 :: 		UART1_Write_Text("ANS_COMMAND VALUE OUT OF RANGE");
MOVS	R6, #96
ADD	R6, SP, R6
MOVS	R5, #31
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr6_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr6_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #96
ADD	R0, SP, R0
MOV	R4, R0
MOV	R0, R4
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,264 :: 		}
L_vRF4463MainCommandProcessor255:
;DriverRF4463PROMain.c,265 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor256
L_vRF4463MainCommandProcessor251:
;DriverRF4463PROMain.c,272 :: 		else if ( memcmp( CMD_RADIO_MODE_SET, ucCommand, sizeof( CMD_RADIO_MODE_SET ) ) == 0x00 ) {
MOVS	R4, #255
ADDS	R4, #221
ADD	R4, SP, R4
MOVS	R2, #9
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_MODE_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MODE_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor257
;DriverRF4463PROMain.c,274 :: 		ucCounterCommand = 0;
MOVS	R0, #0
STR	R0, [SP, #580]
;DriverRF4463PROMain.c,276 :: 		while ( ucLongArgument[ ucCounterCommand ] != ucUSARTNull && ucCounterCommand < 32 ) {
L_vRF4463MainCommandProcessor258:
MOVW	R1, #512
MOVT	R1, #0
ADD	R1, SP, R1
LDR	R0, [SP, #580]
UXTB	R0, R0
ADDS	R0, R1, R0
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucUSARTNull+0)
MOVT	R0, #hi_addr(_ucUSARTNull+0)
LDRB	R0, [R0, #0]
CMP	R1, R0
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor259
LDR	R0, [SP, #580]
UXTB	R0, R0
CMP	R0, #32
IT	CS
BLCS	L_vRF4463MainCommandProcessor259
L__vRF4463MainCommandProcessor376:
;DriverRF4463PROMain.c,277 :: 		ucLongArgument[ ucCounterCommand ] = toupper( ucLongArgument[ ucCounterCommand ] );
MOVW	R1, #512
MOVT	R1, #0
ADD	R1, SP, R1
LDR	R0, [SP, #580]
UXTB	R0, R0
ADDS	R0, R1, R0
STR	R0, [SP, #588]
MOVW	R1, #512
MOVT	R1, #0
ADD	R1, SP, R1
LDR	R0, [SP, #580]
UXTB	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
UXTB	R4, R0
UXTB	R0, R4
BL	_toupper+0
LDR	R1, [SP, #588]
STRB	R0, [R1, #0]
;DriverRF4463PROMain.c,278 :: 		ucCounterCommand++;
LDR	R0, [SP, #580]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #580]
;DriverRF4463PROMain.c,279 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor258
L_vRF4463MainCommandProcessor259:
;DriverRF4463PROMain.c,282 :: 		if ( memcmp( ARG_RADIO_MODE_STBY, ucLongArgument, sizeof( ARG_RADIO_MODE_STBY ) ) == 0x00 ) {
MOVW	R4, #512
MOVT	R4, #0
ADD	R4, SP, R4
MOVS	R2, #5
MOV	R1, R4
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_STBY+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_STBY+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor262
;DriverRF4463PROMain.c,283 :: 		ucRF4463Mode = rf_off;
MOVS	R1, #4
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,285 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor263
L_vRF4463MainCommandProcessor262:
;DriverRF4463PROMain.c,286 :: 		else if ( memcmp( ARG_RADIO_MODE_TX_CONT, ucLongArgument, sizeof( ARG_RADIO_MODE_TX_CONT ) ) == 0x00 ) {
MOVW	R4, #512
MOVT	R4, #0
ADD	R4, SP, R4
MOVS	R2, #8
MOV	R1, R4
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_TX_CONT+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_TX_CONT+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor264
;DriverRF4463PROMain.c,287 :: 		ucRF4463Mode = tx_test_mode;
MOVS	R1, #2
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,288 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,290 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor265
L_vRF4463MainCommandProcessor264:
;DriverRF4463PROMain.c,291 :: 		else if ( memcmp( ARG_RADIO_MODE_RX_CONT, ucLongArgument, sizeof( ARG_RADIO_MODE_RX_CONT ) ) == 0x00 ) {
MOVW	R4, #512
MOVT	R4, #0
ADD	R4, SP, R4
MOVS	R2, #8
MOV	R1, R4
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_RX_CONT+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_RX_CONT+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor266
;DriverRF4463PROMain.c,292 :: 		ucRF4463Mode = rx_test_mode;
MOVS	R1, #3
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,294 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor267
L_vRF4463MainCommandProcessor266:
;DriverRF4463PROMain.c,295 :: 		else if ( memcmp( ARG_RADIO_MODE_TX_MASTER, ucLongArgument, sizeof( ARG_RADIO_MODE_TX_MASTER ) ) == 0x00 ) {
MOVW	R4, #512
MOVT	R4, #0
ADD	R4, SP, R4
MOVS	R2, #10
MOV	R1, R4
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_TX_MASTER+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_TX_MASTER+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor268
;DriverRF4463PROMain.c,296 :: 		ucRF4463Mode = master_mode;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,298 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor269
L_vRF4463MainCommandProcessor268:
;DriverRF4463PROMain.c,299 :: 		else if ( memcmp( ARG_RADIO_MODE_RX_SLAVE, ucLongArgument, sizeof( ARG_RADIO_MODE_RX_SLAVE ) ) == 0x00 ) {
MOVW	R4, #512
MOVT	R4, #0
ADD	R4, SP, R4
MOVS	R2, #9
MOV	R1, R4
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_RX_SLAVE+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_RX_SLAVE+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor270
;DriverRF4463PROMain.c,300 :: 		ucRF4463Mode = slave_mode;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,302 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor271
L_vRF4463MainCommandProcessor270:
;DriverRF4463PROMain.c,304 :: 		UART1_Write_Text("ANS_COMMAND VALUE OUT OF RANGE");
MOVS	R6, #128
ADD	R6, SP, R6
MOVS	R5, #31
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr7_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr7_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #128
ADD	R0, SP, R0
MOV	R4, R0
MOV	R0, R4
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,306 :: 		}
L_vRF4463MainCommandProcessor271:
L_vRF4463MainCommandProcessor269:
L_vRF4463MainCommandProcessor267:
L_vRF4463MainCommandProcessor265:
L_vRF4463MainCommandProcessor263:
;DriverRF4463PROMain.c,307 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor272
L_vRF4463MainCommandProcessor257:
;DriverRF4463PROMain.c,312 :: 		else if ( memcmp( CMD_RADIO_PACKET_SEND, ucCommand, sizeof( CMD_RADIO_PACKET_SEND ) ) == 0x00 ) {
MOVS	R4, #255
ADDS	R4, #221
ADD	R4, SP, R4
MOVS	R2, #12
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_PACKET_SEND+0)
MOVT	R0, #hi_addr(_CMD_RADIO_PACKET_SEND+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor273
;DriverRF4463PROMain.c,316 :: 		ulArgument = StrToLong( ucLongArgument );
MOVW	R4, #512
MOVT	R4, #0
ADD	R4, SP, R4
MOV	R0, R4
BL	_StrToLong+0
STR	R0, [SP, #508]
;DriverRF4463PROMain.c,318 :: 		UART1_Write_Text("ANS_COMMAND VALUE OUT OF RANGE");
MOVS	R6, #160
ADD	R6, SP, R6
MOVS	R5, #31
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr8_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr8_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #160
ADD	R0, SP, R0
MOV	R4, R0
MOV	R0, R4
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,321 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor274
L_vRF4463MainCommandProcessor273:
;DriverRF4463PROMain.c,326 :: 		else if ( memcmp( CMD_RADIO_MATCH_BYTE_1_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_1_SET ) ) == 0x00 ) {
MOVS	R4, #255
ADDS	R4, #221
ADD	R4, SP, R4
MOVS	R2, #12
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_BYTE_1_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_BYTE_1_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor275
;DriverRF4463PROMain.c,327 :: 		ulArgument = StrToLong( ucLongArgument );
MOVW	R4, #512
MOVT	R4, #0
ADD	R4, SP, R4
MOV	R0, R4
BL	_StrToLong+0
STR	R0, [SP, #508]
;DriverRF4463PROMain.c,328 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
LDR	R0, [SP, #508]
CMP	R0, #0
IT	CC
BLCC	L_vRF4463MainCommandProcessor278
LDR	R0, [SP, #508]
CMP	R0, #255
IT	HI
BLHI	L_vRF4463MainCommandProcessor278
L__vRF4463MainCommandProcessor375:
;DriverRF4463PROMain.c,329 :: 		ucRF4463ByteMatch1 = ulArgument;
LDR	R1, [SP, #508]
MOVW	R0, #lo_addr(_ucRF4463ByteMatch1+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch1+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,330 :: 		ucRF4463MatchEnabled = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,331 :: 		ucRF4463MatchEnableReg = 0x40;
MOVS	R1, #64
MOVW	R0, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,332 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,334 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor279
L_vRF4463MainCommandProcessor278:
;DriverRF4463PROMain.c,336 :: 		UART1_Write_Text("ANS_COMMAND VALUE OUT OF RANGE");
MOVS	R6, #192
ADD	R6, SP, R6
MOVS	R5, #31
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr9_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr9_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #192
ADD	R0, SP, R0
MOV	R4, R0
MOV	R0, R4
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,338 :: 		}
L_vRF4463MainCommandProcessor279:
;DriverRF4463PROMain.c,339 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor280
L_vRF4463MainCommandProcessor275:
;DriverRF4463PROMain.c,343 :: 		else if ( memcmp( CMD_RADIO_MATCH_BYTE_2_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_2_SET ) ) == 0x00 ) {
MOVS	R4, #255
ADDS	R4, #221
ADD	R4, SP, R4
MOVS	R2, #12
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_BYTE_2_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_BYTE_2_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor281
;DriverRF4463PROMain.c,344 :: 		ulArgument = StrToLong( ucLongArgument );
MOVW	R4, #512
MOVT	R4, #0
ADD	R4, SP, R4
MOV	R0, R4
BL	_StrToLong+0
STR	R0, [SP, #508]
;DriverRF4463PROMain.c,345 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
LDR	R0, [SP, #508]
CMP	R0, #0
IT	CC
BLCC	L_vRF4463MainCommandProcessor284
LDR	R0, [SP, #508]
CMP	R0, #255
IT	HI
BLHI	L_vRF4463MainCommandProcessor284
L__vRF4463MainCommandProcessor374:
;DriverRF4463PROMain.c,346 :: 		ucRF4463ByteMatch2 = ulArgument;
LDR	R1, [SP, #508]
MOVW	R0, #lo_addr(_ucRF4463ByteMatch2+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch2+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,347 :: 		ucRF4463MatchEnabled = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,348 :: 		ucRF4463MatchEnableReg = 0x40;
MOVS	R1, #64
MOVW	R0, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,349 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,351 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor285
L_vRF4463MainCommandProcessor284:
;DriverRF4463PROMain.c,353 :: 		UART1_Write_Text("ANS_COMMAND VALUE OUT OF RANGE");
MOVS	R6, #224
ADD	R6, SP, R6
MOVS	R5, #31
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr10_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr10_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #224
ADD	R0, SP, R0
MOV	R4, R0
MOV	R0, R4
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,355 :: 		}
L_vRF4463MainCommandProcessor285:
;DriverRF4463PROMain.c,356 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor286
L_vRF4463MainCommandProcessor281:
;DriverRF4463PROMain.c,360 :: 		else if ( memcmp( CMD_RADIO_MATCH_BYTE_3_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_3_SET ) ) == 0x00 ) {
MOVS	R4, #255
ADDS	R4, #221
ADD	R4, SP, R4
MOVS	R2, #12
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_BYTE_3_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_BYTE_3_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor287
;DriverRF4463PROMain.c,361 :: 		ulArgument = StrToLong( ucLongArgument );
MOVW	R4, #512
MOVT	R4, #0
ADD	R4, SP, R4
MOV	R0, R4
BL	_StrToLong+0
STR	R0, [SP, #508]
;DriverRF4463PROMain.c,362 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
LDR	R0, [SP, #508]
CMP	R0, #0
IT	CC
BLCC	L_vRF4463MainCommandProcessor290
LDR	R0, [SP, #508]
CMP	R0, #255
IT	HI
BLHI	L_vRF4463MainCommandProcessor290
L__vRF4463MainCommandProcessor373:
;DriverRF4463PROMain.c,363 :: 		ucRF4463ByteMatch3 = ulArgument;
LDR	R1, [SP, #508]
MOVW	R0, #lo_addr(_ucRF4463ByteMatch3+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch3+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,364 :: 		ucRF4463MatchEnabled = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,365 :: 		ucRF4463MatchEnableReg = 0x40;
MOVS	R1, #64
MOVW	R0, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,366 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,368 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor291
L_vRF4463MainCommandProcessor290:
;DriverRF4463PROMain.c,370 :: 		UART1_Write_Text("ANS_COMMAND VALUE OUT OF RANGE");
MOVS	R6, #255
ADDS	R6, #1
ADD	R6, SP, R6
MOVS	R5, #31
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr11_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr11_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #255
ADDS	R0, #1
ADD	R0, SP, R0
MOV	R4, R0
MOV	R0, R4
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,372 :: 		}
L_vRF4463MainCommandProcessor291:
;DriverRF4463PROMain.c,373 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor292
L_vRF4463MainCommandProcessor287:
;DriverRF4463PROMain.c,377 :: 		else if ( memcmp( CMD_RADIO_MATCH_BYTE_4_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_4_SET ) ) == 0x00 ) {
MOVS	R4, #255
ADDS	R4, #221
ADD	R4, SP, R4
MOVS	R2, #12
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_BYTE_4_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_BYTE_4_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor293
;DriverRF4463PROMain.c,378 :: 		ulArgument = StrToLong( ucLongArgument );
MOVW	R4, #512
MOVT	R4, #0
ADD	R4, SP, R4
MOV	R0, R4
BL	_StrToLong+0
STR	R0, [SP, #508]
;DriverRF4463PROMain.c,379 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
LDR	R0, [SP, #508]
CMP	R0, #0
IT	CC
BLCC	L_vRF4463MainCommandProcessor296
LDR	R0, [SP, #508]
CMP	R0, #255
IT	HI
BLHI	L_vRF4463MainCommandProcessor296
L__vRF4463MainCommandProcessor372:
;DriverRF4463PROMain.c,380 :: 		ucRF4463ByteMatch4 = ulArgument;
LDR	R1, [SP, #508]
MOVW	R0, #lo_addr(_ucRF4463ByteMatch4+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch4+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,381 :: 		ucRF4463MatchEnabled = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,382 :: 		ucRF4463MatchEnableReg = 0x40;
MOVS	R1, #64
MOVW	R0, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,383 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,385 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor297
L_vRF4463MainCommandProcessor296:
;DriverRF4463PROMain.c,387 :: 		UART1_Write_Text("ANS_COMMAND VALUE OUT OF RANGE");
MOVS	R6, #255
ADDS	R6, #33
ADD	R6, SP, R6
MOVS	R5, #31
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr12_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr12_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #255
ADDS	R0, #33
ADD	R0, SP, R0
MOV	R4, R0
MOV	R0, R4
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,389 :: 		}
L_vRF4463MainCommandProcessor297:
;DriverRF4463PROMain.c,390 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor298
L_vRF4463MainCommandProcessor293:
;DriverRF4463PROMain.c,394 :: 		else if ( memcmp( CMD_RADIO_MATCH_MASK_1_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_1_SET ) ) == 0x00 ) {
MOVS	R4, #255
ADDS	R4, #221
ADD	R4, SP, R4
MOVS	R2, #11
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_MASK_1_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_MASK_1_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor299
;DriverRF4463PROMain.c,395 :: 		ulArgument = StrToLong( ucLongArgument );
MOVW	R4, #512
MOVT	R4, #0
ADD	R4, SP, R4
MOV	R0, R4
BL	_StrToLong+0
STR	R0, [SP, #508]
;DriverRF4463PROMain.c,396 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
LDR	R0, [SP, #508]
CMP	R0, #0
IT	CC
BLCC	L_vRF4463MainCommandProcessor302
LDR	R0, [SP, #508]
CMP	R0, #255
IT	HI
BLHI	L_vRF4463MainCommandProcessor302
L__vRF4463MainCommandProcessor371:
;DriverRF4463PROMain.c,397 :: 		ucRF4463ByteMask1 = ulArgument;
LDR	R1, [SP, #508]
MOVW	R0, #lo_addr(_ucRF4463ByteMask1+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask1+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,398 :: 		ucRF4463MatchEnabled = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,399 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,401 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor303
L_vRF4463MainCommandProcessor302:
;DriverRF4463PROMain.c,403 :: 		UART1_Write_Text("ANS_COMMAND VALUE OUT OF RANGE");
MOVS	R6, #255
ADDS	R6, #65
ADD	R6, SP, R6
MOVS	R5, #31
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr13_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr13_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #255
ADDS	R0, #65
ADD	R0, SP, R0
MOV	R4, R0
MOV	R0, R4
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,405 :: 		}
L_vRF4463MainCommandProcessor303:
;DriverRF4463PROMain.c,406 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor304
L_vRF4463MainCommandProcessor299:
;DriverRF4463PROMain.c,410 :: 		else if ( memcmp( CMD_RADIO_MATCH_MASK_2_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_2_SET ) ) == 0x00 ) {
MOVS	R4, #255
ADDS	R4, #221
ADD	R4, SP, R4
MOVS	R2, #11
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_MASK_2_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_MASK_2_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor305
;DriverRF4463PROMain.c,411 :: 		ulArgument = StrToLong( ucLongArgument );
MOVW	R4, #512
MOVT	R4, #0
ADD	R4, SP, R4
MOV	R0, R4
BL	_StrToLong+0
STR	R0, [SP, #508]
;DriverRF4463PROMain.c,412 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
LDR	R0, [SP, #508]
CMP	R0, #0
IT	CC
BLCC	L_vRF4463MainCommandProcessor308
LDR	R0, [SP, #508]
CMP	R0, #255
IT	HI
BLHI	L_vRF4463MainCommandProcessor308
L__vRF4463MainCommandProcessor370:
;DriverRF4463PROMain.c,413 :: 		ucRF4463ByteMask2 = ulArgument;
LDR	R1, [SP, #508]
MOVW	R0, #lo_addr(_ucRF4463ByteMask2+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask2+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,414 :: 		ucRF4463MatchEnabled = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,415 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,417 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor309
L_vRF4463MainCommandProcessor308:
;DriverRF4463PROMain.c,419 :: 		UART1_Write_Text("ANS_COMMAND VALUE OUT OF RANGE");
MOVS	R6, #255
ADDS	R6, #97
ADD	R6, SP, R6
MOVS	R5, #31
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr14_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr14_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #255
ADDS	R0, #97
ADD	R0, SP, R0
MOV	R4, R0
MOV	R0, R4
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,421 :: 		}
L_vRF4463MainCommandProcessor309:
;DriverRF4463PROMain.c,422 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor310
L_vRF4463MainCommandProcessor305:
;DriverRF4463PROMain.c,426 :: 		else if ( memcmp( CMD_RADIO_MATCH_MASK_3_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_3_SET ) ) == 0x00 ) {
MOVS	R4, #255
ADDS	R4, #221
ADD	R4, SP, R4
MOVS	R2, #11
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_MASK_3_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_MASK_3_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor311
;DriverRF4463PROMain.c,427 :: 		ulArgument = StrToLong( ucLongArgument );
MOVW	R4, #512
MOVT	R4, #0
ADD	R4, SP, R4
MOV	R0, R4
BL	_StrToLong+0
STR	R0, [SP, #508]
;DriverRF4463PROMain.c,428 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
LDR	R0, [SP, #508]
CMP	R0, #0
IT	CC
BLCC	L_vRF4463MainCommandProcessor314
LDR	R0, [SP, #508]
CMP	R0, #255
IT	HI
BLHI	L_vRF4463MainCommandProcessor314
L__vRF4463MainCommandProcessor369:
;DriverRF4463PROMain.c,429 :: 		ucRF4463ByteMask3 = ulArgument;
LDR	R1, [SP, #508]
MOVW	R0, #lo_addr(_ucRF4463ByteMask3+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask3+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,430 :: 		ucRF4463MatchEnabled = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,431 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,433 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor315
L_vRF4463MainCommandProcessor314:
;DriverRF4463PROMain.c,435 :: 		UART1_Write_Text("ANS_COMMAND VALUE OUT OF RANGE");
MOVS	R6, #255
ADDS	R6, #129
ADD	R6, SP, R6
MOVS	R5, #31
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr15_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr15_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #255
ADDS	R0, #129
ADD	R0, SP, R0
MOV	R4, R0
MOV	R0, R4
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,437 :: 		}
L_vRF4463MainCommandProcessor315:
;DriverRF4463PROMain.c,438 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor316
L_vRF4463MainCommandProcessor311:
;DriverRF4463PROMain.c,442 :: 		else if ( memcmp( CMD_RADIO_MATCH_MASK_4_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_4_SET ) ) == 0x00 ) {
MOVS	R4, #255
ADDS	R4, #221
ADD	R4, SP, R4
MOVS	R2, #11
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_MASK_4_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_MASK_4_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor317
;DriverRF4463PROMain.c,443 :: 		ulArgument = StrToLong( ucLongArgument );
MOVW	R4, #512
MOVT	R4, #0
ADD	R4, SP, R4
MOV	R0, R4
BL	_StrToLong+0
STR	R0, [SP, #508]
;DriverRF4463PROMain.c,444 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
LDR	R0, [SP, #508]
CMP	R0, #0
IT	CC
BLCC	L_vRF4463MainCommandProcessor320
LDR	R0, [SP, #508]
CMP	R0, #255
IT	HI
BLHI	L_vRF4463MainCommandProcessor320
L__vRF4463MainCommandProcessor368:
;DriverRF4463PROMain.c,445 :: 		ucRF4463ByteMask4 = ulArgument;
LDR	R1, [SP, #508]
MOVW	R0, #lo_addr(_ucRF4463ByteMask4+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask4+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,446 :: 		ucRF4463MatchEnabled = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,447 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,449 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor321
L_vRF4463MainCommandProcessor320:
;DriverRF4463PROMain.c,451 :: 		UART1_Write_Text("ANS_COMMAND VALUE OUT OF RANGE");
MOVS	R6, #255
ADDS	R6, #161
ADD	R6, SP, R6
MOVS	R5, #31
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr16_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr16_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #255
ADDS	R0, #161
ADD	R0, SP, R0
MOV	R4, R0
MOV	R0, R4
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,453 :: 		}
L_vRF4463MainCommandProcessor321:
;DriverRF4463PROMain.c,454 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor322
L_vRF4463MainCommandProcessor317:
;DriverRF4463PROMain.c,458 :: 		else if ( memcmp( CMD_RADIO_MATCH_UNSET, ucCommand, sizeof( CMD_RADIO_MATCH_UNSET ) ) == 0x00 ) {
MOVS	R4, #255
ADDS	R4, #221
ADD	R4, SP, R4
MOVS	R2, #12
MOV	R1, R4
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_UNSET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_UNSET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor323
;DriverRF4463PROMain.c,460 :: 		ucRF4463MatchEnableReg = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,461 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,467 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor324
L_vRF4463MainCommandProcessor323:
;DriverRF4463PROMain.c,471 :: 		UART1_Write_Text("ANS DEBUG COMMAND UNKNOWN");
MOVS	R6, #255
ADDS	R6, #193
ADD	R6, SP, R6
MOVS	R5, #26
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr17_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr17_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #255
ADDS	R0, #193
ADD	R0, SP, R0
MOV	R4, R0
MOV	R0, R4
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,474 :: 		}
L_vRF4463MainCommandProcessor324:
L_vRF4463MainCommandProcessor322:
L_vRF4463MainCommandProcessor316:
L_vRF4463MainCommandProcessor310:
L_vRF4463MainCommandProcessor304:
L_vRF4463MainCommandProcessor298:
L_vRF4463MainCommandProcessor292:
L_vRF4463MainCommandProcessor286:
L_vRF4463MainCommandProcessor280:
L_vRF4463MainCommandProcessor274:
L_vRF4463MainCommandProcessor272:
L_vRF4463MainCommandProcessor256:
L_vRF4463MainCommandProcessor250:
L_vRF4463MainCommandProcessor244:
L_vRF4463MainCommandProcessor228:
L_vRF4463MainCommandProcessor222:
;DriverRF4463PROMain.c,475 :: 		}
L_end_vRF4463MainCommandProcessor:
ADD	SP, SP, #508
ADD	SP, SP, #84
POP	(R15)
; end of _vRF4463MainCommandProcessor
_InitTimer2:
;DriverRF4463PROMain.c,481 :: 		void InitTimer2(){
PUSH	(R14)
;DriverRF4463PROMain.c,482 :: 		RCC_APB1ENR.TIM2EN = 1;
MOVW	R2, #lo_addr(RCC_APB1ENR+0)
MOVT	R2, #hi_addr(RCC_APB1ENR+0)
_LX	[R2, ByteOffset(RCC_APB1ENR+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(RCC_APB1ENR+0)]
;DriverRF4463PROMain.c,483 :: 		TIM2_CR1.CEN = 0;
MOVW	R2, #lo_addr(TIM2_CR1+0)
MOVT	R2, #hi_addr(TIM2_CR1+0)
_LX	[R2, ByteOffset(TIM2_CR1+0)]
MOVS	R1, #32
BICS	R0, R1
_SX	[R2, ByteOffset(TIM2_CR1+0)]
;DriverRF4463PROMain.c,484 :: 		TIM2_PSC = 224;
MOVS	R1, #224
MOVW	R0, #lo_addr(TIM2_PSC+0)
MOVT	R0, #hi_addr(TIM2_PSC+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,485 :: 		TIM2_ARR = 63999;
MOVW	R1, #63999
MOVT	R1, #0
MOVW	R0, #lo_addr(TIM2_ARR+0)
MOVT	R0, #hi_addr(TIM2_ARR+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,486 :: 		NVIC_IntEnable( IVT_INT_TIM2 );
MOVS	R0, #31
BL	_NVIC_IntEnable+0
;DriverRF4463PROMain.c,487 :: 		TIM2_DIER.UIE = 1;
MOVW	R2, #lo_addr(TIM2_DIER+0)
MOVT	R2, #hi_addr(TIM2_DIER+0)
_LX	[R2, ByteOffset(TIM2_DIER+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(TIM2_DIER+0)]
;DriverRF4463PROMain.c,488 :: 		TIM2_CR1bits.CEN = 1;
MOVW	R2, #lo_addr(TIM2_CR1bits+0)
MOVT	R2, #hi_addr(TIM2_CR1bits+0)
_LX	[R2, ByteOffset(TIM2_CR1bits+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(TIM2_CR1bits+0)]
;DriverRF4463PROMain.c,489 :: 		}
L_end_InitTimer2:
POP	(R15)
; end of _InitTimer2
_main:
;DriverRF4463PROMain.c,493 :: 		void main() {
SUB	SP, SP, #120
;DriverRF4463PROMain.c,497 :: 		Delay_ms( 2000 );                    // delay de depuracion
LDR	R7, [PC, #10666665]
NOP
L_main325:
SUBS	R7, R7, #1
BNE	L_main325
B	#4
	#10666665
NOP
;DriverRF4463PROMain.c,505 :: 		GPIO_Digital_Input( &GPIOH_BASE, _GPIO_PINMASK_1 );      //nIRQ
MOVS	R1, #2
MOVW	R0, #lo_addr(GPIOH_BASE+0)
MOVT	R0, #hi_addr(GPIOH_BASE+0)
BL	_GPIO_Digital_Input+0
;DriverRF4463PROMain.c,506 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_15 );     //SDN
MOVW	R1, #32768
MOVT	R1, #0
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,507 :: 		GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_12 );    // nSel
MOVW	R1, #4096
MOVT	R1, #0
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,522 :: 		RCC_APB2ENR.SYSCFGEN = 1;
MOVW	R2, #lo_addr(RCC_APB2ENR+0)
MOVT	R2, #hi_addr(RCC_APB2ENR+0)
_LX	[R2, ByteOffset(RCC_APB2ENR+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(RCC_APB2ENR+0)]
;DriverRF4463PROMain.c,523 :: 		SYSCFG_EXTICR1  = 0x0050;
MOVS	R1, #80
MOVW	R0, #lo_addr(SYSCFG_EXTICR1+0)
MOVT	R0, #hi_addr(SYSCFG_EXTICR1+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,524 :: 		EXTI_IMR.B1     |= 1;
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
_LX	[R0, ByteOffset(EXTI_IMR+0)]
MOVS	R2, #2
ANDS	R2, R0
LSRS	R2, R2, #1
MOVW	R0, #lo_addr(_CMD_RADIO_POWER_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_POWER_SET+0)
LDRB	R1, [R0, #0]
MOVS	R0, BitMask(_CMD_RADIO_POWER_SET+0)
ANDS	R0, R1
LSRS	R0, R0, BitPos(_CMD_RADIO_POWER_SET+0)
MOV	R3, R2
ORRS	R3, R0
MOVW	R2, #lo_addr(EXTI_IMR+0)
MOVT	R2, #hi_addr(EXTI_IMR+0)
_LX	[R2, ByteOffset(EXTI_IMR+0)]
MOVS	R1, #1
ANDS	R1, R3
BEQ	L__main432
MOVS	R1, #2
ORRS	R0, R1
B	L__main431
L__main432:
MOVS	R1, #2
BICS	R0, R1
L__main431:
_SX	[R2, ByteOffset(EXTI_IMR+0)]
;DriverRF4463PROMain.c,525 :: 		EXTI_FTSR.B1    |= 1;
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
_LX	[R0, ByteOffset(EXTI_FTSR+0)]
MOVS	R2, #2
ANDS	R2, R0
LSRS	R2, R2, #1
MOVW	R0, #lo_addr(_CMD_RADIO_POWER_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_POWER_SET+0)
LDRB	R1, [R0, #0]
MOVS	R0, BitMask(_CMD_RADIO_POWER_SET+0)
ANDS	R0, R1
LSRS	R0, R0, BitPos(_CMD_RADIO_POWER_SET+0)
MOV	R3, R2
ORRS	R3, R0
MOVW	R2, #lo_addr(EXTI_FTSR+0)
MOVT	R2, #hi_addr(EXTI_FTSR+0)
_LX	[R2, ByteOffset(EXTI_FTSR+0)]
MOVS	R1, #1
ANDS	R1, R3
BEQ	L__main434
MOVS	R1, #2
ORRS	R0, R1
B	L__main433
L__main434:
MOVS	R1, #2
BICS	R0, R1
L__main433:
_SX	[R2, ByteOffset(EXTI_FTSR+0)]
;DriverRF4463PROMain.c,527 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOB_ODR+0)
MOVT	R2, #hi_addr(GPIOB_ODR+0)
_LX	[R2, ByteOffset(GPIOB_ODR+0)]
MOVS	R1, #1
LSLS	R1, R1, #12
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODR+0)]
;DriverRF4463PROMain.c,532 :: 		InitTimer2();
BL	_InitTimer2+0
;DriverRF4463PROMain.c,533 :: 		NVIC_IntEnable( IVT_INT_EXTI0_1 );
MOVS	R0, #21
BL	_NVIC_IntEnable+0
;DriverRF4463PROMain.c,536 :: 		vUSARTConfigUSART1( 115200 );  // configura todos las parametros de USART
MOVW	R0, #49664
MOVT	R0, #1
PUSH	(R0)
BL	_vUSARTConfigUSART1+0
ADD	SP, SP, #4
;DriverRF4463PROMain.c,538 :: 		UART1_Write_Text("[ SYS STM32L072CB ] Start System\r\n");
MOVS	R6, #8
ADD	R6, SP, R6
MOVS	R5, #35
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr18_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr18_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #8
ADD	R0, SP, R0
MOV	R4, R0
MOV	R0, R4
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,540 :: 		vSPI2Init();           // configura todos los parametros de SPI
BL	_vSPI2Init+0
;DriverRF4463PROMain.c,545 :: 		ucRF4463Freq3 = 9;
MOVS	R1, #9
MOVW	R0, #lo_addr(_ucRF4463Freq3+0)
MOVT	R0, #hi_addr(_ucRF4463Freq3+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,546 :: 		ucRF4463Freq2 = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463Freq2+0)
MOVT	R0, #hi_addr(_ucRF4463Freq2+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,547 :: 		ucRF4463Freq1 = 5;
MOVS	R1, #5
MOVW	R0, #lo_addr(_ucRF4463Freq1+0)
MOVT	R0, #hi_addr(_ucRF4463Freq1+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,550 :: 		ucRF4463Power = 127;            // 34
MOVS	R1, #127
MOVW	R0, #lo_addr(_ucRF4463Power+0)
MOVT	R0, #hi_addr(_ucRF4463Power+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,552 :: 		ucRF4463Rate  = dr_1p2;                // BAUDRATE
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,554 :: 		ucRF4463Mode  = master_mode;          // para transmision continua usar: tx_test_mode
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,556 :: 		ucRF4463FreqChannel = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,560 :: 		reset_mode = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_reset_mode+0)
MOVT	R0, #hi_addr(_reset_mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,565 :: 		vRF4463MainSetTXString();    // usada para establecer el encabezdo predeterminado
BL	_vRF4463MainSetTXString+0
;DriverRF4463PROMain.c,566 :: 		VRF4463SDNReset();
BL	_VRF4463SDNReset+0
;DriverRF4463PROMain.c,567 :: 		vRF4463Init();
BL	_vRF4463Init+0
;DriverRF4463PROMain.c,568 :: 		vRF4463ClearInterrupts();
BL	_vRF4463ClearInterrupts+0
;DriverRF4463PROMain.c,569 :: 		vRF4463PartInfo ();          // SOLICITA EL MODELO DEL RADIO
BL	_vRF4463PartInfo+0
;DriverRF4463PROMain.c,571 :: 		UART1_Write_Text( "[ SYS STM32L072CB ] RF Radio ready\r\n" );
MOVS	R6, #44
ADD	R6, SP, R6
MOVS	R5, #37
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr19_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr19_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #44
ADD	R0, SP, R0
MOV	R4, R0
MOV	R0, R4
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,574 :: 		while ( 1 ) {
L_main327:
;DriverRF4463PROMain.c,577 :: 		if ( fUSART1Buffer == READY_TO_READ ) {
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BLNE	L_main329
;DriverRF4463PROMain.c,579 :: 		}
L_main329:
;DriverRF4463PROMain.c,590 :: 		if ( ucRF4463Mode == master_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BLNE	L_main330
;DriverRF4463PROMain.c,591 :: 		vRF4463TxData();
BL	_vRF4463TxData+0
;DriverRF4463PROMain.c,592 :: 		}
IT	AL
BLAL	L_main331
L_main330:
;DriverRF4463PROMain.c,595 :: 		else if ( ucRF4463Mode == slave_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BLNE	L_main332
;DriverRF4463PROMain.c,596 :: 		vRF4463RxInit();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,597 :: 		}
IT	AL
BLAL	L_main333
L_main332:
;DriverRF4463PROMain.c,600 :: 		else if ( ucRF4463Mode == rf_off ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BLNE	L_main334
;DriverRF4463PROMain.c,601 :: 		vRF4463RxInit();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,602 :: 		}
L_main334:
L_main333:
L_main331:
;DriverRF4463PROMain.c,605 :: 		if ( ucRF4463Mode == tx_test_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BLNE	L_main335
;DriverRF4463PROMain.c,606 :: 		vRF4463TxCont();
BL	_vRF4463TxCont+0
;DriverRF4463PROMain.c,607 :: 		while ( 1 ) {
L_main336:
;DriverRF4463PROMain.c,609 :: 		if ( fUSART1Buffer == READY_TO_READ ) {
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BLNE	L_main338
;DriverRF4463PROMain.c,610 :: 		break;
IT	AL
BLAL	L_main337
;DriverRF4463PROMain.c,611 :: 		}
L_main338:
;DriverRF4463PROMain.c,613 :: 		if ( !nIRQ ) {
MOVW	R0, #lo_addr(GPIOH_IDR+0)
MOVT	R0, #hi_addr(GPIOH_IDR+0)
_LX	[R0, ByteOffset(GPIOH_IDR+0)]
MOVS	R0, #2
ANDS	R0, R1
LSRS	R0, R0, #1
CMP	R0, #0
IT	NE
BLNE	L_main339
;DriverRF4463PROMain.c,614 :: 		vRF4463TxCont();
BL	_vRF4463TxCont+0
;DriverRF4463PROMain.c,615 :: 		}
L_main339:
;DriverRF4463PROMain.c,616 :: 		}
IT	AL
BLAL	L_main336
L_main337:
;DriverRF4463PROMain.c,617 :: 		}
L_main335:
;DriverRF4463PROMain.c,619 :: 		if ( ucRF4463Mode == rx_test_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BLNE	L_main340
;DriverRF4463PROMain.c,620 :: 		vRF4463RxInit ();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,621 :: 		while ( 1 ) {
L_main341:
;DriverRF4463PROMain.c,623 :: 		if ( fUSART1Buffer == READY_TO_READ ) {
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BLNE	L_main343
;DriverRF4463PROMain.c,624 :: 		break;
IT	AL
BLAL	L_main342
;DriverRF4463PROMain.c,625 :: 		}
L_main343:
;DriverRF4463PROMain.c,628 :: 		}
IT	AL
BLAL	L_main341
L_main342:
;DriverRF4463PROMain.c,629 :: 		}
L_main340:
;DriverRF4463PROMain.c,631 :: 		if ( reset_mode == 0 ) {
MOVW	R0, #lo_addr(_reset_mode+0)
MOVT	R0, #hi_addr(_reset_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BLNE	L_main344
;DriverRF4463PROMain.c,633 :: 		while ( 1 ) {
L_main345:
;DriverRF4463PROMain.c,635 :: 		if ( fUSART1Buffer == READY_TO_READ ) {
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BLNE	L_main347
;DriverRF4463PROMain.c,636 :: 		break;
IT	AL
BLAL	L_main346
;DriverRF4463PROMain.c,637 :: 		}
L_main347:
;DriverRF4463PROMain.c,639 :: 		if ( Flag.reach_1s ) {
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
_LX	[R0, ByteOffset(_Flag+0)]
MOVS	R0, #1
ANDS	R0, R1
LSRS	R0, R0, #0
CMP	R0, #0
IT	EQ
BLEQ	L_main348
;DriverRF4463PROMain.c,640 :: 		Flag.reach_1s = 0;
MOVW	R2, #lo_addr(_Flag+0)
MOVT	R2, #hi_addr(_Flag+0)
_LX	[R2, ByteOffset(_Flag+0)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(_Flag+0)]
;DriverRF4463PROMain.c,641 :: 		if ( ucRF4463Mode == master_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BLNE	L_main349
;DriverRF4463PROMain.c,642 :: 		vRF4463TxData();
BL	_vRF4463TxData+0
;DriverRF4463PROMain.c,643 :: 		}
L_main349:
;DriverRF4463PROMain.c,644 :: 		}
L_main348:
;DriverRF4463PROMain.c,647 :: 		if ( !Flag.is_tx ) {
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
_LX	[R0, ByteOffset(_Flag+0)]
MOVS	R0, #2
ANDS	R0, R1
LSRS	R0, R0, #1
CMP	R0, #0
IT	NE
BLNE	L_main350
;DriverRF4463PROMain.c,648 :: 		if ( !nIRQ ) {          // !nIRQ
MOVW	R0, #lo_addr(GPIOH_IDR+0)
MOVT	R0, #hi_addr(GPIOH_IDR+0)
_LX	[R0, ByteOffset(GPIOH_IDR+0)]
MOVS	R0, #2
ANDS	R0, R1
LSRS	R0, R0, #1
CMP	R0, #0
IT	NE
BLNE	L_main351
;DriverRF4463PROMain.c,649 :: 		spi_read(9,0x22);  // aqui hay que leer  el RSSI
MOVS	R0, #34
PUSH	(R0)
MOVS	R0, #9
PUSH	(R0)
BL	_spi_read+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,650 :: 		iVal = ( float ) spi_read_buf[3];
MOVW	R0, #lo_addr(_spi_read_buf+3)
MOVT	R0, #hi_addr(_spi_read_buf+3)
LDRB	R0, [R0, #0]
BL	__UnsignedIntegralToFloat+0
MOV	R1, R0
MOVW	R0, #lo_addr(_iVal+0)
MOVT	R0, #hi_addr(_iVal+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,651 :: 		rssi = ((iVal / 2) - 64) -70;
MOVW	R0, #lo_addr(_iVal+0)
MOVT	R0, #hi_addr(_iVal+0)
LDR	R0, [R0, #0]
MOVW	R2, #0
MOVT	R2, #16384
BL	__Div_FP+0
MOVW	R2, #0
MOVT	R2, #17024
BL	__Sub_FP+0
MOVW	R2, #0
MOVT	R2, #17036
BL	__Sub_FP+0
MOVW	R1, #lo_addr(_rssi+0)
MOVT	R1, #hi_addr(_rssi+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,652 :: 		vRF4463ClearInterrupts();
BL	_vRF4463ClearInterrupts+0
;DriverRF4463PROMain.c,654 :: 		if ( ( spi_read_buf[ 4 ] & 0x08) == 0 ) { // crc error check
MOVW	R0, #lo_addr(_spi_read_buf+4)
MOVT	R0, #hi_addr(_spi_read_buf+4)
LDRB	R1, [R0, #0]
MOVS	R0, #8
ANDS	R0, R1
UXTB	R0, R0
CMP	R0, #0
IT	NE
BLNE	L_main352
;DriverRF4463PROMain.c,658 :: 		spi_read_fifo();
BL	_spi_read_fifo+0
;DriverRF4463PROMain.c,659 :: 		vRF4463FifoReset();
BL	_vRF4463FifoReset+0
;DriverRF4463PROMain.c,661 :: 		chksum = 0;
MOVS	R0, #0
STR	R0, [SP, #4]
;DriverRF4463PROMain.c,662 :: 		for ( i = 4; i < payload_length - 1; i++ )                // Calculation Checksum
MOVS	R0, #4
STR	R0, [SP, #0]
L_main353:
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, #65
IT	GE
BLGE	L_main354
;DriverRF4463PROMain.c,663 :: 		chksum += rx_buf[ i ];
LDR	R1, [SP, #0]
UXTB	R1, R1
MOVW	R0, #lo_addr(_rx_buf+0)
MOVT	R0, #hi_addr(_rx_buf+0)
ADDS	R0, R0, R1
LDRB	R1, [R0, #0]
LDR	R0, [SP, #4]
UXTB	R0, R0
ADDS	R0, R0, R1
STR	R0, [SP, #4]
;DriverRF4463PROMain.c,662 :: 		for ( i = 4; i < payload_length - 1; i++ )                // Calculation Checksum
LDR	R0, [SP, #0]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #0]
;DriverRF4463PROMain.c,663 :: 		chksum += rx_buf[ i ];
IT	AL
BLAL	L_main353
L_main354:
;DriverRF4463PROMain.c,665 :: 		if ( ( chksum == rx_buf[ payload_length - 1 ] )&&( rx_buf[ 4 ] == 0x41 )) {
MOVW	R0, #lo_addr(_rx_buf+65)
MOVT	R0, #hi_addr(_rx_buf+65)
LDRB	R1, [R0, #0]
LDR	R0, [SP, #4]
UXTB	R0, R0
CMP	R0, R1
IT	NE
BLNE	L_main358
MOVW	R0, #lo_addr(_rx_buf+4)
MOVT	R0, #hi_addr(_rx_buf+4)
LDRB	R0, [R0, #0]
CMP	R0, #65
IT	NE
BLNE	L_main358
L__main384:
;DriverRF4463PROMain.c,669 :: 		UART1_Write_Text( "[ Message ] = " );
MOVS	R6, #84
ADD	R6, SP, R6
MOVS	R5, #15
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr20_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr20_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #84
ADD	R0, SP, R0
MOV	R4, R0
MOV	R0, R4
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,670 :: 		UART1_Write_Text( rx_buf );
MOVW	R0, #lo_addr(_rx_buf+0)
MOVT	R0, #hi_addr(_rx_buf+0)
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,671 :: 		UART1_Write_Text("\r\n");
MOVS	R6, #100
ADD	R6, SP, R6
MOVS	R5, #3
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr21_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr21_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #100
ADD	R0, SP, R0
MOV	R4, R0
MOV	R0, R4
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,674 :: 		rx_cnt++;
MOVW	R0, #lo_addr(_rx_cnt+0)
MOVT	R0, #hi_addr(_rx_cnt+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(_rx_cnt+0)
MOVT	R0, #hi_addr(_rx_cnt+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,675 :: 		getRSSI();
BL	_getRSSI+0
;DriverRF4463PROMain.c,680 :: 		}
IT	AL
BLAL	L_main359
L_main358:
;DriverRF4463PROMain.c,682 :: 		vRF4463RxInit();    // The received data is wrong, you must continue to receive
BL	_vRF4463RxInit+0
L_main359:
;DriverRF4463PROMain.c,683 :: 		}
IT	AL
BLAL	L_main360
L_main352:
;DriverRF4463PROMain.c,687 :: 		UART1_Write_Text( "[ CRC ] Fail\r\n" );
MOVS	R6, #104
ADD	R6, SP, R6
MOVS	R5, #15
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr22_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr22_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #104
ADD	R0, SP, R0
MOV	R4, R0
MOV	R0, R4
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,688 :: 		VRF4463SDNReset();
BL	_VRF4463SDNReset+0
;DriverRF4463PROMain.c,689 :: 		vRF4463Init();
BL	_vRF4463Init+0
;DriverRF4463PROMain.c,690 :: 		vRF4463RxInit();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,691 :: 		}
L_main360:
;DriverRF4463PROMain.c,692 :: 		}
L_main351:
;DriverRF4463PROMain.c,693 :: 		}
L_main350:
;DriverRF4463PROMain.c,694 :: 		}
IT	AL
BLAL	L_main345
L_main346:
;DriverRF4463PROMain.c,695 :: 		}
L_main344:
;DriverRF4463PROMain.c,696 :: 		}
IT	AL
BLAL	L_main327
;DriverRF4463PROMain.c,697 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
_getRSSI:
;DriverRF4463PROMain.c,699 :: 		void getRSSI()
PUSH	(R14)
SUB	SP, SP, #20
;DriverRF4463PROMain.c,701 :: 		ShortToStr(rssi,Value );
MOVW	R0, #lo_addr(_rssi+0)
MOVT	R0, #hi_addr(_rssi+0)
LDR	R0, [R0, #0]
BL	__FloatToSignedIntegral+0
SXTB	R0, R0
SXTB	R4, R0
MOVW	R1, #lo_addr(_Value+0)
MOVT	R1, #hi_addr(_Value+0)
SXTB	R0, R4
BL	_ShortToStr+0
;DriverRF4463PROMain.c,702 :: 		UART1_Write_Text("[ RSSI ] = ");
MOV	R6, SP
MOVS	R5, #12
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr23_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr23_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOV	R0, SP
MOV	R4, R0
MOV	R0, R4
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,703 :: 		UART1_Write_Text( Value );
MOVW	R0, #lo_addr(_Value+0)
MOVT	R0, #hi_addr(_Value+0)
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,704 :: 		UART1_Write_Text(" dBm\r\n");
MOVS	R6, #12
ADD	R6, SP, R6
MOVS	R5, #7
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr24_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr24_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #12
ADD	R0, SP, R0
MOV	R4, R0
MOV	R0, R4
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,705 :: 		}
L_end_getRSSI:
ADD	SP, SP, #20
POP	(R15)
; end of _getRSSI
