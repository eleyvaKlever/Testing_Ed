_Int_SPI2:
;driverspi.c,17 :: 		void Int_SPI2() iv IVT_INT_SPI2 ics ICS_AUTO {
;driverspi.c,19 :: 		if ( SPI2_SRbits.RXNE ) {
MOVW	R0, #lo_addr(SPI2_SRbits+0)
MOVT	R0, #hi_addr(SPI2_SRbits+0)
_LX	[R0, ByteOffset(SPI2_SRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_Int_SPI20
;driverspi.c,20 :: 		ucSPI2ByteReceived = ( unsigned char )SPI2_DR;      // lee el Byte recibido
MOVW	R0, #lo_addr(SPI2_DR+0)
MOVT	R0, #hi_addr(SPI2_DR+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucSPI2ByteReceived+0)
MOVT	R0, #hi_addr(_ucSPI2ByteReceived+0)
STRB	R1, [R0, #0]
;driverspi.c,22 :: 		LED_GREEN = ~LED_GREEN;
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_LX	[R0, ByteOffset(GPIOC_ODRbits+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;driverspi.c,24 :: 		}
L_Int_SPI20:
;driverspi.c,25 :: 		}
L_end_Int_SPI2:
BX	LR
; end of _Int_SPI2
_vSPI2Init:
;driverspi.c,32 :: 		void vSPI2Init ( void ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;driverspi.c,34 :: 		_SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI2_PB13_14_15 );
MOVW	R2, #lo_addr(__GPIO_MODULE_SPI2_PB13_14_15+0)
MOVT	R2, #hi_addr(__GPIO_MODULE_SPI2_PB13_14_15+0)
MOVW	R1, #772
;driverspi.c,33 :: 		SPI2_Init_Advanced( _SPI_FPCLK_DIV8, _SPI_MASTER | _SPI_8_BIT | _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION | _SPI_MSB_FIRST |
MOVS	R0, #2
;driverspi.c,34 :: 		_SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI2_PB13_14_15 );
BL	_SPI2_Init_Advanced+0
;driverspi.c,36 :: 		SPI2_CR2bits.RXNEIE  = 1;     // habilitacion de ISR para RX
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(SPI2_CR2bits+0)
MOVT	R0, #hi_addr(SPI2_CR2bits+0)
_SX	[R0, ByteOffset(SPI2_CR2bits+0)]
;driverspi.c,38 :: 		NVIC_IntEnable( IVT_INT_SPI2 );
MOVW	R0, #52
BL	_NVIC_IntEnable+0
;driverspi.c,39 :: 		}
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
SUB	SP, SP, #44
STR	LR, [SP, #0]
;driverrf4463pro.c,44 :: 		unsigned char cleanBuffer[ 20 ]={0x00};
ADD	R11, SP, #24
ADD	R10, R11, #20
MOVW	R12, #lo_addr(?ICSvRF4463Init_cleanBuffer_L0+0)
MOVT	R12, #hi_addr(?ICSvRF4463Init_cleanBuffer_L0+0)
BL	___CC2DW+0
;driverrf4463pro.c,46 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init2:
; i start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_vRF4463Init3
;driverrf4463pro.c,47 :: 		RF_MODEM_MOD_TYPE_12_data[ i ] = RF_MODEM_MOD_TYPE_12[ rate ][ i - 4 ];
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
;driverrf4463pro.c,46 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,48 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init2
L_vRF4463Init3:
;driverrf4463pro.c,51 :: 		if ( freq3 < 8 ) {
MOVW	R0, #lo_addr(_freq3+0)
MOVT	R0, #hi_addr(_freq3+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CS
BCS	L_vRF4463Init5
;driverrf4463pro.c,52 :: 		for ( i = 4; i < 12; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init6:
; i start address is: 12 (R3)
CMP	R3, #12
IT	CS
BCS	L_vRF4463Init7
;driverrf4463pro.c,53 :: 		RF_MODEM_TX_RAMP_DELAY_8_data[ i ] = RF_MODEM_TX_RAMP_DELAY_8_433[ rate ][ i - 4 ];
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
;driverrf4463pro.c,52 :: 		for ( i = 4; i < 12; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,54 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init6
L_vRF4463Init7:
;driverrf4463pro.c,55 :: 		for ( i = 4; i < 11; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init9:
; i start address is: 12 (R3)
CMP	R3, #11
IT	CS
BCS	L_vRF4463Init10
;driverrf4463pro.c,56 :: 		RF_MODEM_AFC_GEAR_7_data[ i ] = RF_MODEM_AFC_GEAR_7_433[ rate ][ i - 4 ];
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
;driverrf4463pro.c,55 :: 		for ( i = 4; i < 11; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,57 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init9
L_vRF4463Init10:
;driverrf4463pro.c,58 :: 		for ( i = 4; i < 15; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init12:
; i start address is: 12 (R3)
CMP	R3, #15
IT	CS
BCS	L_vRF4463Init13
;driverrf4463pro.c,59 :: 		RF_MODEM_OOK_CNT1_11_data[ i ] = RF_MODEM_OOK_CNT1_11_433[ rate ][ i - 4 ];
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
;driverrf4463pro.c,58 :: 		for ( i = 4; i < 15; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,60 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init12
L_vRF4463Init13:
;driverrf4463pro.c,61 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init15:
; i start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_vRF4463Init16
;driverrf4463pro.c,62 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433[ rate ][ i - 4 ];
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
;driverrf4463pro.c,61 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,63 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init15
L_vRF4463Init16:
;driverrf4463pro.c,64 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init18:
; i start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_vRF4463Init19
;driverrf4463pro.c,65 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433[ rate ][ i - 4 ];
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
;driverrf4463pro.c,64 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,66 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init18
L_vRF4463Init19:
;driverrf4463pro.c,67 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init21:
; i start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_vRF4463Init22
;driverrf4463pro.c,68 :: 		RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433[ rate ][ i - 4 ];
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
;driverrf4463pro.c,67 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,69 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init21
L_vRF4463Init22:
;driverrf4463pro.c,70 :: 		for ( i = 4; i < 13; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init24:
; i start address is: 12 (R3)
CMP	R3, #13
IT	CS
BCS	L_vRF4463Init25
;driverrf4463pro.c,71 :: 		RF_MODEM_AGC_WINDOW_SIZE_9_data[ i ] = RF_MODEM_AGC_WINDOW_SIZE_9_433[ rate ][ i - 4 ];
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
;driverrf4463pro.c,70 :: 		for ( i = 4; i < 13; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,72 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init24
L_vRF4463Init25:
;driverrf4463pro.c,73 :: 		for ( i = 4; i < 13; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init27:
; i start address is: 12 (R3)
CMP	R3, #13
IT	CS
BCS	L_vRF4463Init28
;driverrf4463pro.c,74 :: 		RF_MODEM_BCR_OSR_1_9_data[ i ] = RF_MODEM_BCR_OSR_1_9_433[ rate ][ i - 4 ];
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
;driverrf4463pro.c,73 :: 		for ( i = 4; i < 13; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,75 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init27
L_vRF4463Init28:
;driverrf4463pro.c,76 :: 		}
IT	AL
BAL	L_vRF4463Init30
L_vRF4463Init5:
;driverrf4463pro.c,78 :: 		for ( i = 4; i < 12; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init31:
; i start address is: 12 (R3)
CMP	R3, #12
IT	CS
BCS	L_vRF4463Init32
;driverrf4463pro.c,79 :: 		RF_MODEM_TX_RAMP_DELAY_8_data[ i ] = RF_MODEM_TX_RAMP_DELAY_8_850[ rate ][ i - 4 ];
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
;driverrf4463pro.c,78 :: 		for ( i = 4; i < 12; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,80 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init31
L_vRF4463Init32:
;driverrf4463pro.c,81 :: 		for ( i = 4; i < 11; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init34:
; i start address is: 12 (R3)
CMP	R3, #11
IT	CS
BCS	L_vRF4463Init35
;driverrf4463pro.c,82 :: 		RF_MODEM_AFC_GEAR_7_data[ i ] = RF_MODEM_AFC_GEAR_7_850[ rate ][ i - 4 ];
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
;driverrf4463pro.c,81 :: 		for ( i = 4; i < 11; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,83 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init34
L_vRF4463Init35:
;driverrf4463pro.c,84 :: 		for ( i = 4; i < 15; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init37:
; i start address is: 12 (R3)
CMP	R3, #15
IT	CS
BCS	L_vRF4463Init38
;driverrf4463pro.c,85 :: 		RF_MODEM_OOK_CNT1_11_data[ i ] = RF_MODEM_OOK_CNT1_11_850[ rate ][ i - 4 ];
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
;driverrf4463pro.c,84 :: 		for ( i = 4; i < 15; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,86 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init37
L_vRF4463Init38:
;driverrf4463pro.c,87 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init40:
; i start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_vRF4463Init41
;driverrf4463pro.c,88 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850[ rate ][ i - 4 ];
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
;driverrf4463pro.c,87 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,89 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init40
L_vRF4463Init41:
;driverrf4463pro.c,90 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init43:
; i start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_vRF4463Init44
;driverrf4463pro.c,91 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850[ rate ][ i - 4 ];
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
;driverrf4463pro.c,90 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,92 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init43
L_vRF4463Init44:
;driverrf4463pro.c,93 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init46:
; i start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_vRF4463Init47
;driverrf4463pro.c,94 :: 		RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850[ rate ][ i - 4 ];
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
;driverrf4463pro.c,93 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,95 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init46
L_vRF4463Init47:
;driverrf4463pro.c,96 :: 		for ( i = 4; i < 13; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init49:
; i start address is: 12 (R3)
CMP	R3, #13
IT	CS
BCS	L_vRF4463Init50
;driverrf4463pro.c,97 :: 		RF_MODEM_AGC_WINDOW_SIZE_9_data[ i ] = RF_MODEM_AGC_WINDOW_SIZE_9_850[ rate ][ i - 4 ];
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
;driverrf4463pro.c,96 :: 		for ( i = 4; i < 13; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,98 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init49
L_vRF4463Init50:
;driverrf4463pro.c,99 :: 		for ( i = 4; i < 13; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init52:
; i start address is: 12 (R3)
CMP	R3, #13
IT	CS
BCS	L_vRF4463Init53
;driverrf4463pro.c,100 :: 		RF_MODEM_BCR_OSR_1_9_data[ i ] = RF_MODEM_BCR_OSR_1_9_850[ rate ][ i - 4 ];
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
;driverrf4463pro.c,99 :: 		for ( i = 4; i < 13; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,101 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init52
L_vRF4463Init53:
;driverrf4463pro.c,102 :: 		}
L_vRF4463Init30:
;driverrf4463pro.c,103 :: 		for ( i = 4; i < 11; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init55:
; i start address is: 12 (R3)
CMP	R3, #11
IT	CS
BCS	L_vRF4463Init56
;driverrf4463pro.c,104 :: 		RF_SYNTH_PFDCP_CPFF_7_data[ i ] = RF_SYNTH_PFDCP_CPFF_7[ rate ][ i - 4 ];
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
;driverrf4463pro.c,103 :: 		for ( i = 4; i < 11; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,105 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_vRF4463Init55
L_vRF4463Init56:
;driverrf4463pro.c,109 :: 		vRF4463GPIO_SET( mode );                              // PARAMETRO CONFIGURABLE
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
BL	_vRF4463GPIO_SET+0
;driverrf4463pro.c,110 :: 		strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
ADD	R1, SP, #24
ADD	R0, SP, #4
MOVS	R2, #20
SXTH	R2, R2
BL	_strncpy+0
;driverrf4463pro.c,113 :: 		app_command_buf[ 0 ] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,114 :: 		app_command_buf[ 1 ] = 0x00;    // 0x0000
ADDS	R1, R2, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,115 :: 		app_command_buf[ 2 ] = 0x01;    // Total 1 Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,116 :: 		app_command_buf[ 3 ] = 0x00;    // 0x0000
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,117 :: 		app_command_buf[ 4 ] = 98;      // freq  adjustment    ( rango desde 0 - 127 Low cap - High Cap )
ADDS	R1, R2, #4
MOVS	R0, #98
STRB	R0, [R1, #0]
;driverrf4463pro.c,118 :: 		spi_write( 5, app_command_buf );
MOV	R1, R2
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,119 :: 		strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
ADD	R1, SP, #24
ADD	R0, SP, #4
MOVS	R2, #20
SXTH	R2, R2
BL	_strncpy+0
;driverrf4463pro.c,121 :: 		app_command_buf[ 0 ] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,122 :: 		app_command_buf[ 1 ] = 0x00;    // 0x0003
ADDS	R1, R2, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,123 :: 		app_command_buf[ 2 ] = 0x01;    // Total 1 Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,124 :: 		app_command_buf[ 3 ] = 0x03;   // 0x0003
ADDS	R1, R2, #3
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,125 :: 		app_command_buf[ 4 ] = 0x40;  // tx = rx = 64 byte, ordinary PH,high performance mode  ?????????????????????
ADDS	R1, R2, #4
MOVS	R0, #64
STRB	R0, [R1, #0]
;driverrf4463pro.c,126 :: 		spi_write( 5, app_command_buf );
MOV	R1, R2
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,128 :: 		strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
ADD	R1, SP, #24
ADD	R0, SP, #4
MOVS	R2, #20
SXTH	R2, R2
BL	_strncpy+0
;driverrf4463pro.c,130 :: 		spi_write( 0x08, RF_FRR_CTL_A_MODE_4_data );    // disable all fast response register
MOVW	R1, #lo_addr(_RF_FRR_CTL_A_MODE_4_data+0)
MOVT	R1, #hi_addr(_RF_FRR_CTL_A_MODE_4_data+0)
MOVS	R0, #8
BL	_spi_write+0
;driverrf4463pro.c,131 :: 		strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
ADD	R1, SP, #24
ADD	R0, SP, #4
MOVS	R2, #20
SXTH	R2, R2
BL	_strncpy+0
;driverrf4463pro.c,133 :: 		app_command_buf[ 0 ] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,134 :: 		app_command_buf[ 1 ] = 0x10;    // 0x1000
ADDS	R1, R2, #1
MOVS	R0, #16
STRB	R0, [R1, #0]
;driverrf4463pro.c,135 :: 		app_command_buf[ 2 ] = 0x09;    // Total 9 Parameters
ADDS	R1, R2, #2
MOVS	R0, #9
STRB	R0, [R1, #0]
;driverrf4463pro.c,136 :: 		app_command_buf[ 3 ] = 0x00;   // 0x1000
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,138 :: 		if ( mode == tx_test_mode ) {
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_vRF4463Init58
;driverrf4463pro.c,139 :: 		app_command_buf[ 4 ] = 0xff;     //  Need to send 255 bytes of Preamble
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #255
STRB	R0, [R1, #0]
;driverrf4463pro.c,140 :: 		}
IT	AL
BAL	L_vRF4463Init59
L_vRF4463Init58:
;driverrf4463pro.c,142 :: 		app_command_buf[ 4 ] = 0x08;   //  Need to send 8 bytes of Preamble
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,143 :: 		}
L_vRF4463Init59:
;driverrf4463pro.c,146 :: 		app_command_buf[ 5 ]   = 0x14;       //To detect 20 bit sync word,
ADD	R2, SP, #4
ADDS	R1, R2, #5
MOVS	R0, #20
STRB	R0, [R1, #0]
;driverrf4463pro.c,147 :: 		app_command_buf[ 6 ]   = 0x00;       // Non-standard preamble settings, useless
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,148 :: 		app_command_buf[ 7 ]   = 0x0f;       // Time of the preamble Timeout   ????????????????????????????????????????????????????????????
ADDS	R1, R2, #7
MOVS	R0, #15
STRB	R0, [R1, #0]
;driverrf4463pro.c,149 :: 		app_command_buf[ 8 ]   = 0x31;       // The length of the preamble is   byte Calculation , 1st = 1 NO manchest  Encoding, using standard 1010.??
ADDW	R1, R2, #8
MOVS	R0, #49
STRB	R0, [R1, #0]
;driverrf4463pro.c,150 :: 		app_command_buf[ 9 ]   = 0x0;        //  Non-standard Preamble Patten 4th byte
ADDW	R1, R2, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,151 :: 		app_command_buf[ 10 ]  = 0x00;       //  Non-standard Preamble Patten 3rd byte
ADDW	R1, R2, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,152 :: 		app_command_buf[ 11 ]  = 0x00;       //  Non-standard Preamble Patten 2nd byte
ADDW	R1, R2, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,153 :: 		app_command_buf[ 12 ]  = 0x00;       //  Non-standard Preamble Patten 1st byte
ADDW	R1, R2, #12
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,154 :: 		spi_write(13, app_command_buf);
MOV	R1, R2
MOVS	R0, #13
BL	_spi_write+0
;driverrf4463pro.c,155 :: 		strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
ADD	R1, SP, #24
ADD	R0, SP, #4
MOVS	R2, #20
SXTH	R2, R2
BL	_strncpy+0
;driverrf4463pro.c,158 :: 		app_command_buf[ 0 ] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,159 :: 		app_command_buf[ 1 ] = 0x11;         // command = 0x1100
ADDS	R1, R2, #1
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,160 :: 		app_command_buf[ 2 ] = 0x05;         // Total 5 Parameters
ADDS	R1, R2, #2
MOVS	R0, #5
STRB	R0, [R1, #0]
;driverrf4463pro.c,161 :: 		app_command_buf[ 3 ] = 0x00;         // command = 0x1100
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,162 :: 		app_command_buf[ 4 ] = 0x01;         // The synchronization word is defined and sent in the length field, and the synchronization word cannot be wrong,Not 4FSK, not manchest encoding, only 2 bytes
ADDS	R1, R2, #4
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,164 :: 		if ( mode == tx_test_mode ) {
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_vRF4463Init60
;driverrf4463pro.c,165 :: 		app_command_buf[ 5 ] = 0x55;      //Sync word 3
ADD	R2, SP, #4
ADDS	R1, R2, #5
MOVS	R0, #85
STRB	R0, [R1, #0]
;driverrf4463pro.c,166 :: 		app_command_buf[ 6 ] = 0x55;      // Sync word 2
ADDS	R1, R2, #6
MOVS	R0, #85
STRB	R0, [R1, #0]
;driverrf4463pro.c,167 :: 		}
IT	AL
BAL	L_vRF4463Init61
L_vRF4463Init60:
;driverrf4463pro.c,169 :: 		app_command_buf[ 5 ] = ( Network >> 8 );    //Sync word 3
ADD	R2, SP, #4
ADDS	R1, R2, #5
MOVS	R0, #45
STRB	R0, [R1, #0]
;driverrf4463pro.c,170 :: 		app_command_buf[ 6 ] = ( Network );         // Sync word 2
ADDS	R1, R2, #6
MOVS	R0, #212
STRB	R0, [R1, #0]
;driverrf4463pro.c,171 :: 		}
L_vRF4463Init61:
;driverrf4463pro.c,173 :: 		app_command_buf[ 7 ] =  0x00;        // Sync word 1
ADD	R2, SP, #4
ADDS	R1, R2, #7
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,174 :: 		app_command_buf[ 8 ] = 0x00;        // Sync word 0
ADDW	R1, R2, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,175 :: 		spi_write( 9, app_command_buf );
MOV	R1, R2
MOVS	R0, #9
BL	_spi_write+0
;driverrf4463pro.c,176 :: 		strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
ADD	R1, SP, #24
ADD	R0, SP, #4
MOVS	R2, #20
SXTH	R2, R2
BL	_strncpy+0
;driverrf4463pro.c,179 :: 		app_command_buf[ 0 ] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,180 :: 		app_command_buf[ 1 ] = 0x12;        // command = 0x1200
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,181 :: 		app_command_buf[ 2 ] = 0x01;        // Total 1 Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,182 :: 		app_command_buf[ 3 ] = 0x00;        // command = 0x1200
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,183 :: 		app_command_buf[ 4 ] = 0x81;        // 1?cRC ??,CRC = itu-c, enable crc
ADDS	R1, R2, #4
MOVS	R0, #129
STRB	R0, [R1, #0]
;driverrf4463pro.c,184 :: 		spi_write( 5, app_command_buf );
MOV	R1, R2
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,185 :: 		strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
ADD	R1, SP, #24
ADD	R0, SP, #4
MOVS	R2, #20
SXTH	R2, R2
BL	_strncpy+0
;driverrf4463pro.c,188 :: 		app_command_buf[ 0 ] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,189 :: 		app_command_buf[ 1 ] = 0x12;        // command = 0x1206
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,190 :: 		app_command_buf[ 2 ] = 0x01;        // Total 1Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,191 :: 		app_command_buf[ 3 ] = 0x06;        // command = 0x1206
ADDS	R1, R2, #3
MOVS	R0, #6
STRB	R0, [R1, #0]
;driverrf4463pro.c,192 :: 		app_command_buf[ 4 ] = 0x02;        //  tx = rx = 120d--1220 (tx packet,ph enable, not 4fsk, After receiving a packet of data,RX off,CRC Do not flip ,CRC MSB, data MSB
ADDS	R1, R2, #4
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,193 :: 		spi_write( 5, app_command_buf );
MOV	R1, R2
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,194 :: 		strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
ADD	R1, SP, #24
ADD	R0, SP, #4
MOVS	R2, #20
SXTH	R2, R2
BL	_strncpy+0
;driverrf4463pro.c,197 :: 		app_command_buf[ 0 ] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,198 :: 		app_command_buf[ 1 ] = 0x12;        // command = 0x1208
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,199 :: 		app_command_buf[ 2 ] = 0x03;        // Total 3 Parameters
ADDS	R1, R2, #2
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,200 :: 		app_command_buf[ 3 ] = 0x08;        // command = 0x1208
ADDS	R1, R2, #3
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,201 :: 		app_command_buf[ 4 ] = 0x00;        // Length Field = LSB,  length Only 1 byte,length Not put In FiFo, fixed packet length mode
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,202 :: 		app_command_buf[ 5 ] = 0x00;        // Used for variable packet length mode, which defines which Field contains length Filed
ADDS	R1, R2, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,203 :: 		app_command_buf[ 6 ] = 0x00;        // Used for variable packet length mode, adjust the length of variable packet length
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,204 :: 		spi_write( 7, app_command_buf );
MOV	R1, R2
MOVS	R0, #7
BL	_spi_write+0
;driverrf4463pro.c,205 :: 		strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
ADD	R1, SP, #24
ADD	R0, SP, #4
MOVS	R2, #20
SXTH	R2, R2
BL	_strncpy+0
;driverrf4463pro.c,208 :: 		app_command_buf[ 0 ]  = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,209 :: 		app_command_buf[ 1 ]  = 0x12;       // 0x120d
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,210 :: 		app_command_buf[ 2 ]  = 0x0c;       // Total 12 Parameters
ADDS	R1, R2, #2
MOVS	R0, #12
STRB	R0, [R1, #0]
;driverrf4463pro.c,211 :: 		app_command_buf[ 3 ]  = 0x0d;       // 0x120d
ADDS	R1, R2, #3
MOVS	R0, #13
STRB	R0, [R1, #0]
;driverrf4463pro.c,212 :: 		app_command_buf[ 4 ]  = 0x00;       //  Field 1 length (?4?)
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,213 :: 		app_command_buf[ 5 ]  = payload_length;   //  field 1 length, (? 8?), ?Total14???
ADDS	R1, R2, #5
MOVS	R0, #66
STRB	R0, [R1, #0]
;driverrf4463pro.c,214 :: 		app_command_buf[ 6 ]  = 0x04;       // field 1 Is not 4FSK,manchest, whiting, PN9,
ADDS	R1, R2, #6
MOVS	R0, #4
STRB	R0, [R1, #0]
;driverrf4463pro.c,215 :: 		app_command_buf[ 7 ]  = 0xaa;       // field 1 crc enble, check enbale, There are also launchingCRC,cRC?Seed ?CRC_seed?????
ADDS	R1, R2, #7
MOVS	R0, #170
STRB	R0, [R1, #0]
;driverrf4463pro.c,216 :: 		app_command_buf[ 8 ]  = 0x00;       //  field 2 length(?4?)
ADDW	R1, R2, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,217 :: 		app_command_buf[ 9 ]  = 0x00;           //  field 2 length, (? 8?), length = 0 Means thisfield did not use
ADDW	R1, R2, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,218 :: 		app_command_buf[ 10 ] = 0x00;       // field 2 Is not 4FSK,manchest, whiting, PN9
ADDW	R1, R2, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,219 :: 		app_command_buf[ 11 ] = 0x00;       //  field 2 ?CRCSet up
ADDW	R1, R2, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,220 :: 		app_command_buf[ 12 ] = 0x00;       //  field 3 length, (? 8?), length = 0 Means thisfield did not use
ADDW	R1, R2, #12
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,221 :: 		app_command_buf[ 13 ] = 0x00;           //  field 3 length, (? 8?), length = 0 Means thisfield did not use
ADDW	R1, R2, #13
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,222 :: 		app_command_buf[ 14 ] = 0x00;       //  field 3 Is not 4FSK,manchest, whiting, PN9
ADDW	R1, R2, #14
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,223 :: 		app_command_buf[ 15 ] = 0x00;       //  field 3 ?CRCSet up
ADDW	R1, R2, #15
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,224 :: 		spi_write( 16, app_command_buf );
MOV	R1, R2
MOVS	R0, #16
BL	_spi_write+0
;driverrf4463pro.c,225 :: 		strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
ADD	R1, SP, #24
ADD	R0, SP, #4
MOVS	R2, #20
SXTH	R2, R2
BL	_strncpy+0
;driverrf4463pro.c,228 :: 		app_command_buf[ 0 ]  = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,229 :: 		app_command_buf[ 1 ]  = 0x12;       // 0x1219
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,230 :: 		app_command_buf[ 2 ]  = 0x08;       // Total 8Parameters
ADDS	R1, R2, #2
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,231 :: 		app_command_buf[ 3 ]  = 0x19;       // 0x1219
ADDS	R1, R2, #3
MOVS	R0, #25
STRB	R0, [R1, #0]
;driverrf4463pro.c,232 :: 		app_command_buf[ 4 ]  = 0x00;       // field4 length(?4?)
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,233 :: 		app_command_buf[ 5 ]  = 0x00;       // field 4 length, (? 8?), length = 0 Means this field did not use
ADDS	R1, R2, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,234 :: 		app_command_buf[ 6 ]  = 0x00;       // field 4 Is not 4FSK,manchest, whiting, PN9
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,235 :: 		app_command_buf[ 7 ]  = 0x00;       // field 4 ?CRCSet up
ADDS	R1, R2, #7
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,236 :: 		app_command_buf[ 8 ]  = 0x00;       // field5 length(?4?)
ADDW	R1, R2, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,237 :: 		app_command_buf[ 9 ]  = 0x00;       // field 5 length, (? 8?), length = 0 Means this field did not use
ADDW	R1, R2, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,238 :: 		app_command_buf[ 10 ] = 0x00;       // field 5 Is not 4FSK,manchest, whiting, PN9
ADDW	R1, R2, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,239 :: 		app_command_buf[ 11 ] = 0x00;       // field 5 ?CRCSet up
ADDW	R1, R2, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,240 :: 		spi_write( 12, app_command_buf );
MOV	R1, R2
MOVS	R0, #12
BL	_spi_write+0
;driverrf4463pro.c,241 :: 		strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
ADD	R1, SP, #24
ADD	R0, SP, #4
MOVS	R2, #20
SXTH	R2, R2
BL	_strncpy+0
;driverrf4463pro.c,244 :: 		spi_write( 0x10, RF_MODEM_MOD_TYPE_12_data );   // //  2FSK ,  module source = PH fifo, disable manchest, tx, rx Do not flip, deviation Do not flip
MOVW	R1, #lo_addr(_RF_MODEM_MOD_TYPE_12_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_MOD_TYPE_12_data+0)
MOVS	R0, #16
BL	_spi_write+0
;driverrf4463pro.c,245 :: 		strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
ADD	R1, SP, #24
ADD	R0, SP, #4
MOVS	R2, #20
SXTH	R2, R2
BL	_strncpy+0
;driverrf4463pro.c,248 :: 		app_command_buf[0] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,249 :: 		app_command_buf[1]  = 0x20;    // 0x200c
ADDS	R1, R2, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,250 :: 		app_command_buf[2]  = 0x01;    // Total 1Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,251 :: 		app_command_buf[3]  = 0x0c;   // 0x200c
ADDS	R1, R2, #3
MOVS	R0, #12
STRB	R0, [R1, #0]
;driverrf4463pro.c,253 :: 		if ( freq3 < 8 ) {
MOVW	R0, #lo_addr(_freq3+0)
MOVT	R0, #hi_addr(_freq3+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CS
BCS	L_vRF4463Init62
;driverrf4463pro.c,254 :: 		if ( rate >= dr_256k ) {
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CC
BCC	L_vRF4463Init63
;driverrf4463pro.c,255 :: 		app_command_buf[ 4 ] = 0x4f;
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #79
STRB	R0, [R1, #0]
;driverrf4463pro.c,256 :: 		}
IT	AL
BAL	L_vRF4463Init64
L_vRF4463Init63:
;driverrf4463pro.c,257 :: 		else if ( rate >= dr_19p2 ) {
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	CC
BCC	L_vRF4463Init65
;driverrf4463pro.c,258 :: 		app_command_buf[ 4 ]  = 0x5e;
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #94
STRB	R0, [R1, #0]
;driverrf4463pro.c,259 :: 		}
IT	AL
BAL	L_vRF4463Init66
L_vRF4463Init65:
;driverrf4463pro.c,261 :: 		app_command_buf[ 4 ]  = 0xd2;
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #210
STRB	R0, [R1, #0]
;driverrf4463pro.c,262 :: 		}
L_vRF4463Init66:
L_vRF4463Init64:
;driverrf4463pro.c,263 :: 		}
IT	AL
BAL	L_vRF4463Init67
L_vRF4463Init62:
;driverrf4463pro.c,265 :: 		if ( rate >= dr_115p2 ) {
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	CC
BCC	L_vRF4463Init68
;driverrf4463pro.c,266 :: 		app_command_buf[ 4 ]  = 0x69;        // 15k
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #105
STRB	R0, [R1, #0]
;driverrf4463pro.c,267 :: 		}
IT	AL
BAL	L_vRF4463Init69
L_vRF4463Init68:
;driverrf4463pro.c,268 :: 		else if ( rate >= dr_19p2 ) {
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	CC
BCC	L_vRF4463Init70
;driverrf4463pro.c,269 :: 		app_command_buf[ 4 ]  = 0x5e;        // 10k
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #94
STRB	R0, [R1, #0]
;driverrf4463pro.c,270 :: 		}
IT	AL
BAL	L_vRF4463Init71
L_vRF4463Init70:
;driverrf4463pro.c,272 :: 		app_command_buf[ 4 ]  = 0x18; // 8k
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #24
STRB	R0, [R1, #0]
;driverrf4463pro.c,273 :: 		}
L_vRF4463Init71:
L_vRF4463Init69:
;driverrf4463pro.c,274 :: 		}
L_vRF4463Init67:
;driverrf4463pro.c,275 :: 		spi_write( 5, app_command_buf );
ADD	R0, SP, #4
MOV	R1, R0
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,276 :: 		strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
ADD	R1, SP, #24
ADD	R0, SP, #4
MOVS	R2, #20
SXTH	R2, R2
BL	_strncpy+0
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
;driverrf4463pro.c,287 :: 		app_command_buf[ 0 ] = 0x11;    // Set Properties
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,288 :: 		app_command_buf[ 1 ] = 0x20;    // Group
ADDS	R1, R2, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,289 :: 		app_command_buf[ 2 ] = 0x01;    // Total 1, Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,290 :: 		app_command_buf[ 3 ] = 0x4C;    // Register 0x4C
ADDS	R1, R2, #3
MOVS	R0, #76
STRB	R0, [R1, #0]
;driverrf4463pro.c,291 :: 		app_command_buf[ 4 ] = 0x01;    // Data
ADDS	R1, R2, #4
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,292 :: 		spi_write( 5, app_command_buf );
MOV	R1, R2
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,294 :: 		strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
ADD	R1, SP, #24
ADD	R0, SP, #4
MOVS	R2, #20
SXTH	R2, R2
BL	_strncpy+0
;driverrf4463pro.c,314 :: 		spi_write( 0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data );  // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVS	R0, #16
BL	_spi_write+0
;driverrf4463pro.c,315 :: 		spi_write( 0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data );   // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVS	R0, #16
BL	_spi_write+0
;driverrf4463pro.c,316 :: 		spi_write( 0x10, RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data );   // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVS	R0, #16
BL	_spi_write+0
;driverrf4463pro.c,319 :: 		app_command_buf[ 0 ]  = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,320 :: 		app_command_buf[ 1 ]  = 0x22;    // 0x2200
ADDS	R1, R2, #1
MOVS	R0, #34
STRB	R0, [R1, #0]
;driverrf4463pro.c,321 :: 		app_command_buf[ 2 ]  = 0x04;    // Total 4Parameters
ADDS	R1, R2, #2
MOVS	R0, #4
STRB	R0, [R1, #0]
;driverrf4463pro.c,322 :: 		app_command_buf[ 3 ]  = 0x00;   // 0x2200
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,323 :: 		app_command_buf[ 4 ]  = 0x08;  //0x10;   //   PA mode  = default , ??Class E mode,?Is not Switch Current mode  ????????
ADDS	R1, R2, #4
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,350 :: 		if ( power > 0 || power < 127 ) {
MOVW	R0, #lo_addr(_power+0)
MOVT	R0, #hi_addr(_power+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	HI
BHI	L__vRF4463Init322
MOVW	R0, #lo_addr(_power+0)
MOVT	R0, #hi_addr(_power+0)
LDRB	R0, [R0, #0]
CMP	R0, #127
IT	CC
BCC	L__vRF4463Init321
IT	AL
BAL	L_vRF4463Init74
L__vRF4463Init322:
L__vRF4463Init321:
;driverrf4463pro.c,351 :: 		app_command_buf[ 5 ]  = power;   //  Set to maximum power
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVW	R0, #lo_addr(_power+0)
MOVT	R0, #hi_addr(_power+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,352 :: 		}
IT	AL
BAL	L_vRF4463Init75
L_vRF4463Init74:
;driverrf4463pro.c,355 :: 		app_command_buf[ 5 ]  = 127;
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #127
STRB	R0, [R1, #0]
;driverrf4463pro.c,356 :: 		}
L_vRF4463Init75:
;driverrf4463pro.c,357 :: 		app_command_buf[ 6 ] = 0x00; //???????? 0x00;   // CLK duty = 50%, other = Default
ADD	R0, SP, #4
ADDS	R1, R0, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,361 :: 		if ( ( rate <= dr_115p2 )||( rate == dr_500 ) ) {
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	LS
BLS	L__vRF4463Init324
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	EQ
BEQ	L__vRF4463Init323
IT	AL
BAL	L_vRF4463Init78
L__vRF4463Init324:
L__vRF4463Init323:
;driverrf4463pro.c,362 :: 		app_command_buf[ 7 ]  = 0x3d;  // ???????? 0x5d;   // PA ramp time = default
ADD	R0, SP, #4
ADDS	R1, R0, #7
MOVS	R0, #61
STRB	R0, [R1, #0]
;driverrf4463pro.c,363 :: 		}
IT	AL
BAL	L_vRF4463Init79
L_vRF4463Init78:
;driverrf4463pro.c,365 :: 		app_command_buf[ 7 ]  = 0x5d;
ADD	R0, SP, #4
ADDS	R1, R0, #7
MOVS	R0, #93
STRB	R0, [R1, #0]
;driverrf4463pro.c,366 :: 		}
L_vRF4463Init79:
;driverrf4463pro.c,367 :: 		spi_write( 8, app_command_buf );
ADD	R0, SP, #4
MOV	R1, R0
MOVS	R0, #8
BL	_spi_write+0
;driverrf4463pro.c,369 :: 		strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
ADD	R1, SP, #24
ADD	R0, SP, #4
MOVS	R2, #20
SXTH	R2, R2
BL	_strncpy+0
;driverrf4463pro.c,371 :: 		spi_write( 0x0B , RF_SYNTH_PFDCP_CPFF_7_data );      // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
MOVT	R1, #hi_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
MOVS	R0, #11
BL	_spi_write+0
;driverrf4463pro.c,372 :: 		strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
ADD	R1, SP, #24
ADD	R0, SP, #4
MOVS	R2, #20
SXTH	R2, R2
BL	_strncpy+0
;driverrf4463pro.c,374 :: 		app_command_buf[ 0 ]  = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,375 :: 		app_command_buf[ 1 ]  = 0x30;    // 0x3000
ADDS	R1, R2, #1
MOVS	R0, #48
STRB	R0, [R1, #0]
;driverrf4463pro.c,376 :: 		app_command_buf[ 2 ]  = 0x0c;    // Total 12 Parameters
ADDS	R1, R2, #2
MOVS	R0, #12
STRB	R0, [R1, #0]
;driverrf4463pro.c,377 :: 		app_command_buf[ 3 ]  = 0x00;    // 0x3000
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,378 :: 		app_command_buf[ 4 ]  = System_Lo;     // 0x00;   //  match 1 Value of
ADDS	R1, R2, #4
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,379 :: 		app_command_buf[ 5 ]  = 0xff;    //  match 1 mask
ADDS	R1, R2, #5
MOVS	R0, #255
STRB	R0, [R1, #0]
;driverrf4463pro.c,380 :: 		app_command_buf[ 6 ]  = 0x40;    // enable match 1, match 1 The distance between the value of and the synchronization word, 0 = match
ADDS	R1, R2, #6
MOVS	R0, #64
STRB	R0, [R1, #0]
;driverrf4463pro.c,381 :: 		app_command_buf[ 7 ]  = System_Hi;     //  match 2 Value of
ADDS	R1, R2, #7
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,382 :: 		app_command_buf[ 8 ]  = 0xff;    //  match 2 mask
ADDW	R1, R2, #8
MOVS	R0, #255
STRB	R0, [R1, #0]
;driverrf4463pro.c,383 :: 		app_command_buf[ 9 ]  = 0x01;    // enable match 2, match 2 The distance between the value of and the synchronization word  , and function
ADDW	R1, R2, #9
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,384 :: 		app_command_buf[ 10 ] = System_Higer;     //     match 3 Value of
ADDW	R1, R2, #10
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,385 :: 		app_command_buf[ 11 ] = 0xff;;   //  match 3 mask
ADDW	R1, R2, #11
MOVS	R0, #255
STRB	R0, [R1, #0]
;driverrf4463pro.c,386 :: 		app_command_buf[ 12 ] = 0x02;;   // enable match 3, match 3 The distance between the value of and the synchronization word    and function
ADDW	R1, R2, #12
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,387 :: 		app_command_buf[ 13 ] = Systema_Higest;     //   match 4 Value of
ADDW	R1, R2, #13
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,388 :: 		app_command_buf[ 14 ] = 0xff;    //   match 4 mask
ADDW	R1, R2, #14
MOVS	R0, #255
STRB	R0, [R1, #0]
;driverrf4463pro.c,389 :: 		app_command_buf[ 15 ] = 0x03;    //  enable match 4, match 4 The distance between the value of and the synchronization word    and function
ADDW	R1, R2, #15
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,390 :: 		spi_write( 16, app_command_buf );
MOV	R1, R2
MOVS	R0, #16
BL	_spi_write+0
;driverrf4463pro.c,391 :: 		strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
ADD	R1, SP, #24
ADD	R0, SP, #4
MOVS	R2, #20
SXTH	R2, R2
BL	_strncpy+0
;driverrf4463pro.c,392 :: 		rf_init_freq();     // FUNCION DE FRECUENCIA ( REVISAR PARAMETROS )
BL	_rf_init_freq+0
;driverrf4463pro.c,393 :: 		}
L_end_vRF4463Init:
LDR	LR, [SP, #0]
ADD	SP, SP, #44
BX	LR
; end of _vRF4463Init
_vRF4463GPIO_SET:
;driverrf4463pro.c,399 :: 		void vRF4463GPIO_SET( unsigned char ucData ) {
; ucData start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
; ucData end address is: 0 (R0)
; ucData start address is: 0 (R0)
;driverrf4463pro.c,402 :: 		ucAppCommandBuf[0] = 0x13;     // gpio Set up
ADD	R2, SP, #4
MOVS	R1, #19
STRB	R1, [R2, #0]
;driverrf4463pro.c,404 :: 		switch ( ucData ) {
IT	AL
BAL	L_vRF4463GPIO_SET80
; ucData end address is: 0 (R0)
;driverrf4463pro.c,405 :: 		case tx_normal:
L_vRF4463GPIO_SET82:
;driverrf4463pro.c,406 :: 		case rx_normal: ucAppCommandBuf[ 1 ] = 3;                 // GPIO0=1
L_vRF4463GPIO_SET83:
ADD	R3, SP, #4
ADDS	R2, R3, #1
MOVS	R1, #3
STRB	R1, [R2, #0]
;driverrf4463pro.c,407 :: 		ucAppCommandBuf[ 2 ] = 2;                // GPIO1=0
ADDS	R2, R3, #2
MOVS	R1, #2
STRB	R1, [R2, #0]
;driverrf4463pro.c,408 :: 		break;
IT	AL
BAL	L_vRF4463GPIO_SET81
;driverrf4463pro.c,410 :: 		case tx_test:   ucAppCommandBuf[ 1 ] = 3;                 // GPIO0=1
L_vRF4463GPIO_SET84:
ADD	R3, SP, #4
ADDS	R2, R3, #1
MOVS	R1, #3
STRB	R1, [R2, #0]
;driverrf4463pro.c,411 :: 		ucAppCommandBuf[ 2 ] = 3;                // GPIO1=1
ADDS	R2, R3, #2
MOVS	R1, #3
STRB	R1, [R2, #0]
;driverrf4463pro.c,412 :: 		break;
IT	AL
BAL	L_vRF4463GPIO_SET81
;driverrf4463pro.c,414 :: 		case rx_test:   ucAppCommandBuf[ 1 ] = 2;                 // GPIO0=0
L_vRF4463GPIO_SET85:
ADD	R3, SP, #4
ADDS	R2, R3, #1
MOVS	R1, #2
STRB	R1, [R2, #0]
;driverrf4463pro.c,415 :: 		ucAppCommandBuf[ 2 ] = 20;                // GPIO1=RX DATA
ADDS	R2, R3, #2
MOVS	R1, #20
STRB	R1, [R2, #0]
;driverrf4463pro.c,416 :: 		break;
IT	AL
BAL	L_vRF4463GPIO_SET81
;driverrf4463pro.c,418 :: 		case rf_off:    ucAppCommandBuf[ 1 ] = 2;                 // GPIO0=0
L_vRF4463GPIO_SET86:
ADD	R3, SP, #4
ADDS	R2, R3, #1
MOVS	R1, #2
STRB	R1, [R2, #0]
;driverrf4463pro.c,419 :: 		ucAppCommandBuf[ 2 ] = 2;                // GPIO1=0
ADDS	R2, R3, #2
MOVS	R1, #2
STRB	R1, [R2, #0]
;driverrf4463pro.c,420 :: 		break;
IT	AL
BAL	L_vRF4463GPIO_SET81
;driverrf4463pro.c,421 :: 		}
L_vRF4463GPIO_SET80:
; ucData start address is: 0 (R0)
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463GPIO_SET82
CMP	R0, #1
IT	EQ
BEQ	L_vRF4463GPIO_SET83
CMP	R0, #2
IT	EQ
BEQ	L_vRF4463GPIO_SET84
CMP	R0, #3
IT	EQ
BEQ	L_vRF4463GPIO_SET85
CMP	R0, #4
IT	EQ
BEQ	L_vRF4463GPIO_SET86
; ucData end address is: 0 (R0)
L_vRF4463GPIO_SET81:
;driverrf4463pro.c,423 :: 		ucAppCommandBuf[ 3 ]  = 0x21;     //0x20;   //  gpio2, h = tx mode
ADD	R3, SP, #4
ADDS	R2, R3, #3
MOVS	R1, #33
STRB	R1, [R2, #0]
;driverrf4463pro.c,424 :: 		ucAppCommandBuf[ 4 ]  = 0x20;     // 0x14;  //   gpio3
ADDS	R2, R3, #4
MOVS	R1, #32
STRB	R1, [R2, #0]
;driverrf4463pro.c,425 :: 		ucAppCommandBuf[ 5 ]  = 0x27;     // nIRQ
ADDS	R2, R3, #5
MOVS	R1, #39
STRB	R1, [R2, #0]
;driverrf4463pro.c,426 :: 		ucAppCommandBuf[ 6 ]  = 0x0b;     // sdo
ADDS	R2, R3, #6
MOVS	R1, #11
STRB	R1, [R2, #0]
;driverrf4463pro.c,427 :: 		spi_write( 7, ucAppCommandBuf );
MOV	R1, R3
MOVS	R0, #7
BL	_spi_write+0
;driverrf4463pro.c,428 :: 		}
L_end_vRF4463GPIO_SET:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRF4463GPIO_SET
_vRF4463FifoReset:
;driverrf4463pro.c,433 :: 		void vRF4463FifoReset( void ) {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;driverrf4463pro.c,436 :: 		p[ 0 ] = FIFO_INFO;
ADD	R2, SP, #4
MOVS	R0, #21
STRB	R0, [R2, #0]
;driverrf4463pro.c,437 :: 		p[ 1 ] = 0x03;   // reset tx ,rx fifo
ADDS	R1, R2, #1
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,438 :: 		spi_write( 2, p );
MOV	R1, R2
MOVS	R0, #2
BL	_spi_write+0
;driverrf4463pro.c,439 :: 		}
L_end_vRF4463FifoReset:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vRF4463FifoReset
_vRF4463ClearInterrupts:
;driverrf4463pro.c,445 :: 		void vRF4463ClearInterrupts( void ) {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;driverrf4463pro.c,448 :: 		p[ 0 ] = GET_INT_STATUS;
ADD	R2, SP, #4
MOVS	R0, #32
STRB	R0, [R2, #0]
;driverrf4463pro.c,449 :: 		p[ 1 ] = 0;               // clr  PH pending
ADDS	R1, R2, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,450 :: 		p[ 2 ] = 0;               // clr modem_pending
ADDS	R1, R2, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,451 :: 		p[ 3 ] = 0;               // clr chip pending
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,452 :: 		spi_write( 4, p );
MOV	R1, R2
MOVS	R0, #4
BL	_spi_write+0
;driverrf4463pro.c,453 :: 		spi_read( 9, GET_INT_STATUS );
MOVS	R1, #32
MOVS	R0, #9
BL	_spi_read+0
;driverrf4463pro.c,454 :: 		}
L_end_vRF4463ClearInterrupts:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vRF4463ClearInterrupts
_vRF4463PartInfo:
;driverrf4463pro.c,456 :: 		void vRF4463PartInfo( void ) {  // Solicitud totalmente operativa
SUB	SP, SP, #16
STR	LR, [SP, #0]
;driverrf4463pro.c,459 :: 		p[ 0 ] = PART_INFO;
ADD	R1, SP, #4
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,463 :: 		spi_write( 1, p );
MOVS	R0, #1
BL	_spi_write+0
;driverrf4463pro.c,464 :: 		spi_read( 9, PART_INFO );
MOVS	R1, #1
MOVS	R0, #9
BL	_spi_read+0
;driverrf4463pro.c,465 :: 		}
L_end_vRF4463PartInfo:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _vRF4463PartInfo
_vRF4463EnableRxInterrupt:
;driverrf4463pro.c,470 :: 		void vRF4463EnableRxInterrupt( void ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,473 :: 		p[ 0 ] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,474 :: 		p[ 1 ] = 0x01;            // 0x0100
ADDS	R1, R2, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,475 :: 		p[ 2 ] = 0x03;            // 3Parameters
ADDS	R1, R2, #2
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,476 :: 		p[ 3 ] = 0x00;            // 0100
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,477 :: 		p[ 4 ] = 0x03;            // ph, modem int       0x03;
ADDS	R1, R2, #4
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,478 :: 		p[ 5 ] = 0x18;            // 0x10;   // Pack received int
ADDS	R1, R2, #5
MOVS	R0, #24
STRB	R0, [R1, #0]
;driverrf4463pro.c,479 :: 		p[ 6 ] = 0x00;            //preamble int, sync int setting
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,480 :: 		spi_write( 0x07, p );     // enable  packet receive interrupt
MOV	R1, R2
MOVS	R0, #7
BL	_spi_write+0
;driverrf4463pro.c,481 :: 		}
L_end_vRF4463EnableRxInterrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRF4463EnableRxInterrupt
_vRF4463EnableTxInterrupt:
;driverrf4463pro.c,486 :: 		void vRF4463EnableTxInterrupt( void ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,489 :: 		p[ 0 ] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,490 :: 		p[ 1 ] = 0x01;            // 0x0100
ADDS	R1, R2, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,491 :: 		p[ 2 ] = 0x02;            // 2Parameters
ADDS	R1, R2, #2
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,492 :: 		p[ 3 ] = 0x00;            // 0x0100
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,493 :: 		p[ 4 ] = 0x01;            // Ph  int
ADDS	R1, R2, #4
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,494 :: 		p[ 5 ] = 0x20;            //  enable  packet sent interrupt
ADDS	R1, R2, #5
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,495 :: 		spi_write( 0x06, p );     // enable  packet receive interrupt
MOV	R1, R2
MOVS	R0, #6
BL	_spi_write+0
;driverrf4463pro.c,496 :: 		}
L_end_vRF4463EnableTxInterrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRF4463EnableTxInterrupt
_vRF4463RfStandby:
;driverrf4463pro.c,501 :: 		void vRF4463RfStandby( void ) {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;driverrf4463pro.c,504 :: 		p[ 0 ] = CHANGE_STATE ;   // CHANGE_STATE Command
ADD	R2, SP, #4
MOVS	R0, #52
STRB	R0, [R2, #0]
;driverrf4463pro.c,505 :: 		p[ 1 ] = 0x01 ;           // sleep mode
ADDS	R1, R2, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,506 :: 		spi_write( 2, p );
MOV	R1, R2
MOVS	R0, #2
BL	_spi_write+0
;driverrf4463pro.c,507 :: 		}
L_end_vRF4463RfStandby:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vRF4463RfStandby
_vRF4463TxStart:
;driverrf4463pro.c,512 :: 		void vRF4463TxStart( void ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,515 :: 		p[ 0 ] = START_TX ;       // start Command
ADD	R2, SP, #4
MOVS	R0, #49
STRB	R0, [R2, #0]
;driverrf4463pro.c,516 :: 		p[ 1 ] = freq_channel;    // channel 0
ADDS	R1, R2, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,517 :: 		p[ 2 ] = 0x30;            // Back after launch Readymode, Do not retransmit, launch immediately
ADDS	R1, R2, #2
MOVS	R0, #48
STRB	R0, [R1, #0]
;driverrf4463pro.c,518 :: 		p[ 3 ] = 0;
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,519 :: 		p[ 4 ] = 0;               //payload_length; // Total to transmit 10 bytes
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,520 :: 		spi_write( 5, p );
MOV	R1, R2
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,521 :: 		}
L_end_vRF4463TxStart:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRF4463TxStart
_vRF4463RxStart:
;driverrf4463pro.c,526 :: 		void vRF4463RxStart( void ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,529 :: 		p[ 0 ] = START_RX ;       // start Command
ADD	R2, SP, #4
MOVS	R0, #50
STRB	R0, [R2, #0]
;driverrf4463pro.c,530 :: 		p[ 1 ] = freq_channel;    // channel 0
ADDS	R1, R2, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,531 :: 		p[ 2 ] = 0x00;            // Enter receiving mode immediately
ADDS	R1, R2, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,532 :: 		p[ 3 ] = 0;
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,533 :: 		p[ 4 ] = 0;               // payload_length; // Total to receive 10 bytes
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,534 :: 		p[ 5 ] = 0;               // unchanged after preamble timeout
ADDS	R1, R2, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,537 :: 		p[ 6 ] = 0x08;
ADDS	R1, R2, #6
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,538 :: 		p[ 7 ] = 0x08;
ADDS	R1, R2, #7
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,539 :: 		spi_write( 8, p );
MOV	R1, R2
MOVS	R0, #8
BL	_spi_write+0
;driverrf4463pro.c,540 :: 		}
L_end_vRF4463RxStart:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRF4463RxStart
_vRF4463RxStartTest:
;driverrf4463pro.c,545 :: 		void vRF4463RxStartTest( void ) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;driverrf4463pro.c,548 :: 		LED_GREEN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;driverrf4463pro.c,550 :: 		p[ 0 ] = START_RX;        // start Command
ADD	R2, SP, #4
MOVS	R0, #50
STRB	R0, [R2, #0]
;driverrf4463pro.c,551 :: 		p[ 1 ] = freq_channel;    // channel 0
ADDS	R1, R2, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,552 :: 		p[ 2 ] = 0x00;            // Enter receiving mode immediately
ADDS	R1, R2, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,553 :: 		p[ 3 ] = 0;
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,555 :: 		p[ 4 ] = 0;
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,556 :: 		p[ 5 ] = 0;               // unchanged after preamble timeout
ADDS	R1, R2, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,559 :: 		p[ 6 ] = 0x08;
ADDS	R1, R2, #6
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,560 :: 		p[ 7 ] = 0x08;
ADDS	R1, R2, #7
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,561 :: 		spi_write( 8, p );
MOV	R1, R2
MOVS	R0, #8
BL	_spi_write+0
;driverrf4463pro.c,562 :: 		}
L_end_vRF4463RxStartTest:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRF4463RxStartTest
_vRF4463RxInit:
;driverrf4463pro.c,567 :: 		void vRF4463RxInit( void ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;driverrf4463pro.c,568 :: 		Flag.is_tx = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;driverrf4463pro.c,569 :: 		vRF4463FifoReset();           // fifo_reset();  // Buffer empty
BL	_vRF4463FifoReset+0
;driverrf4463pro.c,570 :: 		vRF4463EnableRxInterrupt();   // enable_rx_interrupt();
BL	_vRF4463EnableRxInterrupt+0
;driverrf4463pro.c,571 :: 		vRF4463ClearInterrupts();      // clr_interrupt();  // Clear interrupt factor
BL	_vRF4463ClearInterrupts+0
;driverrf4463pro.c,573 :: 		if ( mode == rx_test_mode ) {
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BNE	L_vRF4463RxInit87
;driverrf4463pro.c,574 :: 		vRF4463RxStartTest();      // rx_start_test();
BL	_vRF4463RxStartTest+0
;driverrf4463pro.c,575 :: 		}
IT	AL
BAL	L_vRF4463RxInit88
L_vRF4463RxInit87:
;driverrf4463pro.c,577 :: 		vRF4463RxStart();        // rx_start();    // Enter receiving mode, after receiving data, return to Readymode
BL	_vRF4463RxStart+0
;driverrf4463pro.c,578 :: 		}
L_vRF4463RxInit88:
;driverrf4463pro.c,579 :: 		}
L_end_vRF4463RxInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vRF4463RxInit
_vRF4463TxData:
;driverrf4463pro.c,584 :: 		void vRF4463TxData( void ) {
SUB	SP, SP, #24
STR	LR, [SP, #0]
;driverrf4463pro.c,587 :: 		ucRF4463IRQ = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
STRB	R1, [R0, #0]
;driverrf4463pro.c,589 :: 		Flag.is_tx = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;driverrf4463pro.c,593 :: 		vRF4463FifoReset();            // fifo_reset();  // Buffer empty
BL	_vRF4463FifoReset+0
;driverrf4463pro.c,594 :: 		spi_write_fifo();              // Fill the buffer with data
BL	_spi_write_fifo+0
;driverrf4463pro.c,595 :: 		vRF4463EnableTxInterrupt();    // enable_tx_interrupt();
BL	_vRF4463EnableTxInterrupt+0
;driverrf4463pro.c,596 :: 		vRF4463ClearInterrupts();       // clr_interrupt();  // Clear interrupt factor
BL	_vRF4463ClearInterrupts+0
;driverrf4463pro.c,597 :: 		vRF4463TxStart();              // tx_start();    // Enter launch mode, start launch
BL	_vRF4463TxStart+0
;driverrf4463pro.c,598 :: 		rf_timeout = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_rf_timeout+0)
MOVT	R0, #hi_addr(_rf_timeout+0)
STRH	R1, [R0, #0]
;driverrf4463pro.c,600 :: 		Flag.rf_reach_timeout = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;driverrf4463pro.c,602 :: 		if ( ucRF4463IRQ ) {
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463TxData89
;driverrf4463pro.c,603 :: 		UART1_Write_Text( "[ UART1 ] TX INT\r\n" );
ADD	R11, SP, #4
ADD	R10, R11, #19
MOVW	R12, #lo_addr(?ICS?lstr1_DriverRF4463PROMain+0)
MOVT	R12, #hi_addr(?ICS?lstr1_DriverRF4463PROMain+0)
BL	___CC2DW+0
ADD	R0, SP, #4
BL	_UART1_Write_Text+0
;driverrf4463pro.c,604 :: 		}
L_vRF4463TxData89:
;driverrf4463pro.c,607 :: 		while ( nIRQ ) {     //nIRQ
L_vRF4463TxData90:
MOVW	R0, #lo_addr(GPIOC_IDRbits+0)
MOVT	R0, #hi_addr(GPIOC_IDRbits+0)
_LX	[R0, ByteOffset(GPIOC_IDRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463TxData91
;driverrf4463pro.c,610 :: 		if ( Flag.rf_reach_timeout ) {
MOVW	R1, #lo_addr(_Flag+0)
MOVT	R1, #hi_addr(_Flag+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463TxData92
;driverrf4463pro.c,611 :: 		VRF4463SDNReset();
BL	_VRF4463SDNReset+0
;driverrf4463pro.c,612 :: 		vRF4463Init();        //SI4463_init();  // RF Module initialization
BL	_vRF4463Init+0
;driverrf4463pro.c,613 :: 		break;                // Forced out
IT	AL
BAL	L_vRF4463TxData91
;driverrf4463pro.c,614 :: 		}
L_vRF4463TxData92:
;driverrf4463pro.c,615 :: 		}
IT	AL
BAL	L_vRF4463TxData90
L_vRF4463TxData91:
;driverrf4463pro.c,617 :: 		tx_cnt++;
MOVW	R1, #lo_addr(_tx_cnt+0)
MOVT	R1, #hi_addr(_tx_cnt+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;driverrf4463pro.c,619 :: 		vRF4463RxInit();          // rx_init();                //rf After the transmission is completed, enter the receiving mode
BL	_vRF4463RxInit+0
;driverrf4463pro.c,620 :: 		}
L_end_vRF4463TxData:
LDR	LR, [SP, #0]
ADD	SP, SP, #24
BX	LR
; end of _vRF4463TxData
_vRF4463TxCont:
;driverrf4463pro.c,625 :: 		void vRF4463TxCont( void ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;driverrf4463pro.c,628 :: 		LED_RED = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;driverrf4463pro.c,629 :: 		vRF4463FifoReset();                     //  fifo_reset();  // Buffer empty
BL	_vRF4463FifoReset+0
;driverrf4463pro.c,630 :: 		spi_write_fifo();                       // Fill the buffer with data
BL	_spi_write_fifo+0
;driverrf4463pro.c,631 :: 		vRF4463EnableTxInterrupt();             //  enable_tx_interrupt();
BL	_vRF4463EnableTxInterrupt+0
;driverrf4463pro.c,632 :: 		vRF4463ClearInterrupts();               //  clr_interrupt();  // Clear interrupt factor
BL	_vRF4463ClearInterrupts+0
;driverrf4463pro.c,633 :: 		vRF4463TxStart();                       //  tx_start();    // Enter launch mode, start launch
BL	_vRF4463TxStart+0
;driverrf4463pro.c,634 :: 		rf_timeout = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_rf_timeout+0)
MOVT	R0, #hi_addr(_rf_timeout+0)
STRH	R1, [R0, #0]
;driverrf4463pro.c,635 :: 		Flag.rf_reach_timeout = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;driverrf4463pro.c,637 :: 		ucRF4463IRQ = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
STRB	R1, [R0, #0]
;driverrf4463pro.c,640 :: 		while( nIRQ ) {          //nIRQ ) {
L_vRF4463TxCont93:
MOVW	R0, #lo_addr(GPIOC_IDRbits+0)
MOVT	R0, #hi_addr(GPIOC_IDRbits+0)
_LX	[R0, ByteOffset(GPIOC_IDRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vRF4463TxCont94
;driverrf4463pro.c,648 :: 		}
IT	AL
BAL	L_vRF4463TxCont93
L_vRF4463TxCont94:
;driverrf4463pro.c,649 :: 		}
L_end_vRF4463TxCont:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vRF4463TxCont
_rf_init_freq:
;driverrf4463pro.c,654 :: 		void rf_init_freq ( void ) {
SUB	SP, SP, #28
STR	LR, [SP, #0]
;driverrf4463pro.c,660 :: 		ulFrequency = ( freq3 * 100) + ( freq2 * 10) + freq1;
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
;driverrf4463pro.c,662 :: 		ulFrequency = ( ulFrequency * 10000);          //915.0 MHz??
MOVW	R0, #10000
MUL	R1, R2, R0
MOV	R2, R1
;driverrf4463pro.c,664 :: 		if ( ulFrequency >= 7600000 ) {
MOVW	R0, #63360
MOVT	R0, #115
CMP	R1, R0
IT	CC
BCC	L_rf_init_freq95
;driverrf4463pro.c,665 :: 		ucOUTDIV = 4;
MOVS	R0, #4
STRB	R0, [SP, #4]
;driverrf4463pro.c,666 :: 		ucBAND = 0;
MOVS	R0, #0
STRB	R0, [SP, #6]
;driverrf4463pro.c,667 :: 		ucVCO = 0xFF;
MOVS	R0, #255
STRB	R0, [SP, #5]
;driverrf4463pro.c,668 :: 		}
IT	AL
BAL	L_rf_init_freq96
L_rf_init_freq95:
;driverrf4463pro.c,671 :: 		else if ( ulFrequency >= 5460000 ) {
MOVW	R0, #20512
MOVT	R0, #83
CMP	R2, R0
IT	CC
BCC	L_rf_init_freq97
;driverrf4463pro.c,672 :: 		ucOUTDIV = 6;
MOVS	R0, #6
STRB	R0, [SP, #4]
;driverrf4463pro.c,673 :: 		ucBAND   = 1;
MOVS	R0, #1
STRB	R0, [SP, #6]
;driverrf4463pro.c,674 :: 		ucVCO    = 0xFE;
MOVS	R0, #254
STRB	R0, [SP, #5]
;driverrf4463pro.c,675 :: 		}
IT	AL
BAL	L_rf_init_freq98
L_rf_init_freq97:
;driverrf4463pro.c,678 :: 		else if ( ulFrequency >= 3850000 ) {
MOVW	R0, #48912
MOVT	R0, #58
CMP	R2, R0
IT	CC
BCC	L_rf_init_freq99
;driverrf4463pro.c,679 :: 		ucOUTDIV = 8;
MOVS	R0, #8
STRB	R0, [SP, #4]
;driverrf4463pro.c,680 :: 		ucBAND   = 2;
MOVS	R0, #2
STRB	R0, [SP, #6]
;driverrf4463pro.c,681 :: 		ucVCO    = 0xFE;
MOVS	R0, #254
STRB	R0, [SP, #5]
;driverrf4463pro.c,682 :: 		}
IT	AL
BAL	L_rf_init_freq100
L_rf_init_freq99:
;driverrf4463pro.c,685 :: 		else if ( ulFrequency >= 2730000 ) {
MOVW	R0, #43024
MOVT	R0, #41
CMP	R2, R0
IT	CC
BCC	L_rf_init_freq101
;driverrf4463pro.c,686 :: 		ucOUTDIV = 12;
MOVS	R0, #12
STRB	R0, [SP, #4]
;driverrf4463pro.c,687 :: 		ucBAND   = 3;
MOVS	R0, #3
STRB	R0, [SP, #6]
;driverrf4463pro.c,688 :: 		ucVCO    = 0xFD;
MOVS	R0, #253
STRB	R0, [SP, #5]
;driverrf4463pro.c,689 :: 		}
IT	AL
BAL	L_rf_init_freq102
L_rf_init_freq101:
;driverrf4463pro.c,692 :: 		else if ( ulFrequency >= 1940000 ) {
MOVW	R0, #39456
MOVT	R0, #29
CMP	R2, R0
IT	CC
BCC	L_rf_init_freq103
;driverrf4463pro.c,693 :: 		ucOUTDIV = 16;
MOVS	R0, #16
STRB	R0, [SP, #4]
;driverrf4463pro.c,694 :: 		ucBAND   = 4;
MOVS	R0, #4
STRB	R0, [SP, #6]
;driverrf4463pro.c,695 :: 		ucVCO    = 0xFC;
MOVS	R0, #252
STRB	R0, [SP, #5]
;driverrf4463pro.c,696 :: 		}
IT	AL
BAL	L_rf_init_freq104
L_rf_init_freq103:
;driverrf4463pro.c,700 :: 		ucOUTDIV = 24;
MOVS	R0, #24
STRB	R0, [SP, #4]
;driverrf4463pro.c,701 :: 		ucBAND   = 5;
MOVS	R0, #5
STRB	R0, [SP, #6]
;driverrf4463pro.c,702 :: 		ucVCO    = 0xFA;
MOVS	R0, #250
STRB	R0, [SP, #5]
;driverrf4463pro.c,703 :: 		}
L_rf_init_freq104:
L_rf_init_freq102:
L_rf_init_freq100:
L_rf_init_freq98:
L_rf_init_freq96:
;driverrf4463pro.c,705 :: 		ucDIV = ucOUTDIV / 2;
LDRB	R0, [SP, #4]
LSRS	R0, R0, #1
UXTB	R0, R0
;driverrf4463pro.c,707 :: 		ulData = ( ulFrequency * ucDIV ) / 3;          // ucDIV = 88.5 = 88   //// UCdiv = 2
MUL	R1, R2, R0
; ulFrequency end address is: 8 (R2)
MOVS	R0, #3
UDIV	R2, R1, R0
;driverrf4463pro.c,708 :: 		ucINTE = ( ulData / 100000) - 1;               // ulData = 6 000 000  //// ULdATA = 9 000 000
MOVW	R0, #34464
MOVT	R0, #1
UDIV	R0, R2, R0
SUBS	R0, R0, #1
; ucINTE start address is: 24 (R6)
UXTB	R6, R0
;driverrf4463pro.c,709 :: 		ulFRAC = ( ulData - ( ucINTE + 1 ) * 100000 ) * 16384 / 3125;         // ulFRAC = 15 728 640
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
;driverrf4463pro.c,710 :: 		ulFRAC = ulFRAC + 0x80000;
ADD	R0, R0, #524288
;driverrf4463pro.c,712 :: 		ucFRAC_0 = ulFRAC;
; ucFRAC_0 start address is: 28 (R7)
UXTB	R7, R0
;driverrf4463pro.c,713 :: 		ulFRAC >>= 8;
LSRS	R0, R0, #8
;driverrf4463pro.c,714 :: 		ucFRAC_1 = ulFRAC;
; ucFRAC_1 start address is: 32 (R8)
UXTB	R8, R0
;driverrf4463pro.c,715 :: 		ulFRAC >>= 8;
LSRS	R0, R0, #8
;driverrf4463pro.c,716 :: 		ucFRAC_2 = ulFRAC;
; ucFRAC_2 start address is: 36 (R9)
UXTB	R9, R0
;driverrf4463pro.c,720 :: 		app_command_buf[ 0 ] = 0x11;           // SET property    MODEM_CLKGEN_BAND
ADD	R2, SP, #7
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,721 :: 		app_command_buf[ 1 ] = 0x20;           // Group  // 0x2051
ADDS	R1, R2, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,722 :: 		app_command_buf[ 2 ] = 0x01;           // Num Arguments // Total 1 Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,723 :: 		app_command_buf[ 3 ] = 0x51;           // Number  // 0x2051
ADDS	R1, R2, #3
MOVS	R0, #81
STRB	R0, [R1, #0]
;driverrf4463pro.c,724 :: 		app_command_buf[ 4 ] = 0x08 | ucBAND;  // Argumento  //  high performance mode , clk outpu = osc /4
ADDS	R1, R2, #4
LDRB	R0, [SP, #6]
ORR	R0, R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,725 :: 		spi_write( 5, app_command_buf );
MOV	R1, R2
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,727 :: 		app_command_buf[ 0 ]  = 0x11;
ADD	R2, SP, #7
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,728 :: 		app_command_buf[ 1 ]  = 0x40;    // 0x4000         FREQ_CONTROL_INTE
ADDS	R1, R2, #1
MOVS	R0, #64
STRB	R0, [R1, #0]
;driverrf4463pro.c,729 :: 		app_command_buf[ 2 ]  = 0x08;    // Total 8 Parameters
ADDS	R1, R2, #2
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,730 :: 		app_command_buf[ 3 ]  = 0x00;   // 0x4000
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,731 :: 		app_command_buf[ 4 ]  = ucINTE;   //  default value
ADDS	R0, R2, #4
STRB	R6, [R0, #0]
; ucINTE end address is: 24 (R6)
;driverrf4463pro.c,732 :: 		app_command_buf[ 5 ]  = ucFRAC_2;   //  defaul value
ADDS	R0, R2, #5
STRB	R9, [R0, #0]
; ucFRAC_2 end address is: 36 (R9)
;driverrf4463pro.c,733 :: 		app_command_buf[ 6 ]  = ucFRAC_1;   //  default value
ADDS	R0, R2, #6
STRB	R8, [R0, #0]
; ucFRAC_1 end address is: 32 (R8)
;driverrf4463pro.c,734 :: 		app_command_buf[ 7 ]  = ucFRAC_0;   // frac ,from WDS
ADDS	R0, R2, #7
STRB	R7, [R0, #0]
; ucFRAC_0 end address is: 28 (R7)
;driverrf4463pro.c,735 :: 		app_command_buf[ 8 ]  = step_250K_step1;   // channel step1  from wds  // al parecer aqu� esta el ancho del canal
ADDW	R1, R2, #8
MOVS	R0, #34
STRB	R0, [R1, #0]
;driverrf4463pro.c,736 :: 		app_command_buf[ 9 ]  = step_250K_step0;   // channel step0  from wds
ADDW	R1, R2, #9
MOVS	R0, #34
STRB	R0, [R1, #0]
;driverrf4463pro.c,737 :: 		app_command_buf[ 10 ] = 0x20;  //  from wds Without this Values
ADDW	R1, R2, #10
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,738 :: 		app_command_buf[ 11 ] = ucVCO;    // from wds Without this Values
ADDW	R1, R2, #11
LDRB	R0, [SP, #5]
STRB	R0, [R1, #0]
;driverrf4463pro.c,739 :: 		spi_write( 12, app_command_buf );
MOV	R1, R2
MOVS	R0, #12
BL	_spi_write+0
;driverrf4463pro.c,741 :: 		}
L_end_rf_init_freq:
LDR	LR, [SP, #0]
ADD	SP, SP, #28
BX	LR
; end of _rf_init_freq
_ucRf4463SPIByte:
;driverrf4463pro.c,761 :: 		unsigned char ucRf4463SPIByte( unsigned char ucData ) {
; ucData start address is: 0 (R0)
SUB	SP, SP, #4
; ucData end address is: 0 (R0)
; ucData start address is: 0 (R0)
;driverrf4463pro.c,764 :: 		ucSPI2ByteReceived = 0;
MOVS	R2, #0
MOVW	R1, #lo_addr(_ucSPI2ByteReceived+0)
MOVT	R1, #hi_addr(_ucSPI2ByteReceived+0)
STRB	R2, [R1, #0]
;driverrf4463pro.c,766 :: 		SPI2_DR = ucData;
MOVW	R1, #lo_addr(SPI2_DR+0)
MOVT	R1, #hi_addr(SPI2_DR+0)
STR	R0, [R1, #0]
; ucData end address is: 0 (R0)
;driverrf4463pro.c,774 :: 		while ( !SPI2_SRbits.TXE );                // espera a que el buffer este vacio
L_ucRf4463SPIByte105:
MOVW	R1, #lo_addr(SPI2_SRbits+0)
MOVT	R1, #hi_addr(SPI2_SRbits+0)
_LX	[R1, ByteOffset(SPI2_SRbits+0)]
CMP	R1, #0
IT	NE
BNE	L_ucRf4463SPIByte106
IT	AL
BAL	L_ucRf4463SPIByte105
L_ucRf4463SPIByte106:
;driverrf4463pro.c,776 :: 		while ( SPI2_SRbits.BSY );                // espera a que el buffer este vacio
L_ucRf4463SPIByte107:
MOVW	R1, #lo_addr(SPI2_SRbits+0)
MOVT	R1, #hi_addr(SPI2_SRbits+0)
_LX	[R1, ByteOffset(SPI2_SRbits+0)]
CMP	R1, #0
IT	EQ
BEQ	L_ucRf4463SPIByte108
IT	AL
BAL	L_ucRf4463SPIByte107
L_ucRf4463SPIByte108:
;driverrf4463pro.c,779 :: 		return ( ucSPI2ByteReceived );
MOVW	R1, #lo_addr(_ucSPI2ByteReceived+0)
MOVT	R1, #hi_addr(_ucSPI2ByteReceived+0)
LDRB	R0, [R1, #0]
;driverrf4463pro.c,780 :: 		}
L_end_ucRf4463SPIByte:
ADD	SP, SP, #4
BX	LR
; end of _ucRf4463SPIByte
_spi_write:
;driverrf4463pro.c,785 :: 		void spi_write( unsigned char tx_length, unsigned char *p ) {
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
;driverrf4463pro.c,788 :: 		i = 0;
; i start address is: 0 (R0)
MOVS	R0, #0
; tx_length end address is: 4 (R1)
; p end address is: 8 (R2)
; i end address is: 0 (R0)
UXTB	R5, R1
MOV	R4, R2
;driverrf4463pro.c,789 :: 		while ( i != 0xFF ) {
L_spi_write109:
; i start address is: 0 (R0)
; p start address is: 16 (R4)
; tx_length start address is: 20 (R5)
CMP	R0, #255
IT	EQ
BEQ	L_spi_write110
; i end address is: 0 (R0)
;driverrf4463pro.c,790 :: 		i = check_cts();
BL	_check_cts+0
; i start address is: 0 (R0)
;driverrf4463pro.c,791 :: 		}
; i end address is: 0 (R0)
IT	AL
BAL	L_spi_write109
L_spi_write110:
;driverrf4463pro.c,794 :: 		nSEL = 0;                              // habilita escritura
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,796 :: 		for ( i = 0; i < tx_length; i++ ) {
; i start address is: 0 (R0)
MOVS	R0, #0
; tx_length end address is: 20 (R5)
; i end address is: 0 (R0)
UXTB	R3, R5
UXTB	R5, R0
L_spi_write111:
; i start address is: 20 (R5)
; tx_length start address is: 12 (R3)
; p start address is: 16 (R4)
; p end address is: 16 (R4)
CMP	R5, R3
IT	CS
BCS	L_spi_write112
; p end address is: 16 (R4)
;driverrf4463pro.c,797 :: 		j = *( p + i );
; p start address is: 16 (R4)
ADDS	R2, R4, R5
;driverrf4463pro.c,798 :: 		ucRf4463SPIByte( j );
LDRB	R0, [R2, #0]
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,796 :: 		for ( i = 0; i < tx_length; i++ ) {
ADDS	R5, R5, #1
UXTB	R5, R5
;driverrf4463pro.c,799 :: 		}
; tx_length end address is: 12 (R3)
; p end address is: 16 (R4)
; i end address is: 20 (R5)
IT	AL
BAL	L_spi_write111
L_spi_write112:
;driverrf4463pro.c,801 :: 		nSEL = 1;                              // desabilita escritura
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,802 :: 		}
L_end_spi_write:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _spi_write
_check_cts:
;driverrf4463pro.c,807 :: 		unsigned char check_cts( void ) {           // This Command follows the Command and reads the response
SUB	SP, SP, #4
STR	LR, [SP, #0]
;driverrf4463pro.c,810 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,812 :: 		nSEL = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,813 :: 		ucRf4463SPIByte( 0x44 );
MOVS	R0, #68
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,814 :: 		i = ucRf4463SPIByte( 0 );
MOVS	R0, #0
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,815 :: 		nSEL = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODRbits+0)
MOVT	R1, #hi_addr(GPIOB_ODRbits+0)
_SX	[R1, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,816 :: 		return ( i );
;driverrf4463pro.c,817 :: 		}
L_end_check_cts:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _check_cts
_spi_read:
;driverrf4463pro.c,822 :: 		void spi_read( unsigned char data_length, unsigned char api_command ) {
; api_command start address is: 4 (R1)
; data_length start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
; api_command end address is: 4 (R1)
; data_length end address is: 0 (R0)
; data_length start address is: 0 (R0)
; api_command start address is: 4 (R1)
;driverrf4463pro.c,826 :: 		p[ 0 ] = api_command;
ADD	R2, SP, #4
STRB	R1, [R2, #0]
; api_command end address is: 4 (R1)
;driverrf4463pro.c,827 :: 		i = 0;
; i start address is: 4 (R1)
MOVS	R1, #0
; data_length end address is: 0 (R0)
; i end address is: 4 (R1)
UXTB	R6, R0
UXTB	R0, R1
;driverrf4463pro.c,828 :: 		while ( i != 0xFF ) {
L_spi_read114:
; i start address is: 0 (R0)
; data_length start address is: 24 (R6)
CMP	R0, #255
IT	EQ
BEQ	L_spi_read115
; i end address is: 0 (R0)
;driverrf4463pro.c,829 :: 		i = check_cts();                // Check if you can send Command
BL	_check_cts+0
; i start address is: 0 (R0)
;driverrf4463pro.c,830 :: 		}
; i end address is: 0 (R0)
IT	AL
BAL	L_spi_read114
L_spi_read115:
;driverrf4463pro.c,832 :: 		spi_write( 1, p );    // Send Command
ADD	R2, SP, #4
MOV	R1, R2
MOVS	R0, #1
BL	_spi_write+0
;driverrf4463pro.c,834 :: 		i = 0;
; i start address is: 0 (R0)
MOVS	R0, #0
; data_length end address is: 24 (R6)
; i end address is: 0 (R0)
UXTB	R4, R6
;driverrf4463pro.c,835 :: 		while ( i != 0xFF ) {
L_spi_read116:
; i start address is: 0 (R0)
; data_length start address is: 16 (R4)
CMP	R0, #255
IT	EQ
BEQ	L_spi_read117
; i end address is: 0 (R0)
;driverrf4463pro.c,836 :: 		i = check_cts();        //Check whether the data can be read
BL	_check_cts+0
; i start address is: 0 (R0)
;driverrf4463pro.c,837 :: 		}
; i end address is: 0 (R0)
IT	AL
BAL	L_spi_read116
L_spi_read117:
;driverrf4463pro.c,839 :: 		nSEL = 1;
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,841 :: 		nSEL = 0;
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,842 :: 		ucRf4463SPIByte( 0x44 );
MOVS	R0, #68
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,843 :: 		for ( i = 0; i < data_length; i++ ) {        // Read data
; i start address is: 0 (R0)
MOVS	R0, #0
; data_length end address is: 16 (R4)
; i end address is: 0 (R0)
UXTB	R3, R4
UXTB	R4, R0
L_spi_read118:
; i start address is: 16 (R4)
; data_length start address is: 12 (R3)
CMP	R4, R3
IT	CS
BCS	L_spi_read119
;driverrf4463pro.c,844 :: 		spi_read_buf[ i ] = ucRf4463SPIByte( 0x00 );             // 0x00
MOVW	R2, #lo_addr(_spi_read_buf+0)
MOVT	R2, #hi_addr(_spi_read_buf+0)
ADDS	R2, R2, R4
STR	R2, [SP, #8]
MOVS	R0, #0
BL	_ucRf4463SPIByte+0
LDR	R2, [SP, #8]
STRB	R0, [R2, #0]
;driverrf4463pro.c,845 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_spi_read121:
SUBS	R7, R7, #1
BNE	L_spi_read121
NOP
NOP
NOP
;driverrf4463pro.c,843 :: 		for ( i = 0; i < data_length; i++ ) {        // Read data
ADDS	R4, R4, #1
UXTB	R4, R4
;driverrf4463pro.c,846 :: 		}
; data_length end address is: 12 (R3)
; i end address is: 16 (R4)
IT	AL
BAL	L_spi_read118
L_spi_read119:
;driverrf4463pro.c,847 :: 		nSEL = 1;
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,848 :: 		}
L_end_spi_read:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _spi_read
_spi_fast_read:
;driverrf4463pro.c,853 :: 		void spi_fast_read( unsigned char api_command ) {
; api_command start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
; api_command end address is: 0 (R0)
; api_command start address is: 0 (R0)
;driverrf4463pro.c,856 :: 		p[0] = api_command;
ADD	R1, SP, #4
STRB	R0, [R1, #0]
;driverrf4463pro.c,857 :: 		i = 0;
; i start address is: 4 (R1)
MOVS	R1, #0
; api_command end address is: 0 (R0)
; i end address is: 4 (R1)
UXTB	R3, R0
;driverrf4463pro.c,858 :: 		while ( i != 0xFF ) {
L_spi_fast_read123:
; i start address is: 4 (R1)
; api_command start address is: 12 (R3)
CMP	R1, #255
IT	EQ
BEQ	L_spi_fast_read124
; i end address is: 4 (R1)
;driverrf4463pro.c,859 :: 		i = check_cts();                // Check if you can send Command
BL	_check_cts+0
; i start address is: 4 (R1)
UXTB	R1, R0
;driverrf4463pro.c,860 :: 		}
; i end address is: 4 (R1)
IT	AL
BAL	L_spi_fast_read123
L_spi_fast_read124:
;driverrf4463pro.c,862 :: 		nSEL = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODRbits+0)
MOVT	R1, #hi_addr(GPIOB_ODRbits+0)
_SX	[R1, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,864 :: 		nSEL = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODRbits+0)
MOVT	R1, #hi_addr(GPIOB_ODRbits+0)
_SX	[R1, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,865 :: 		ucRf4463SPIByte( api_command );    // Send Command
UXTB	R0, R3
; api_command end address is: 12 (R3)
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,866 :: 		for ( i = 0; i < 4; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #0
; i end address is: 12 (R3)
L_spi_fast_read125:
; i start address is: 12 (R3)
CMP	R3, #4
IT	CS
BCS	L_spi_fast_read126
;driverrf4463pro.c,867 :: 		spi_read_buf[ i ] = ucRf4463SPIByte( 0xFF );   // Read out all the 4 registers Value of
MOVW	R1, #lo_addr(_spi_read_buf+0)
MOVT	R1, #hi_addr(_spi_read_buf+0)
ADDS	R1, R1, R3
STR	R1, [SP, #8]
MOVS	R0, #255
BL	_ucRf4463SPIByte+0
LDR	R1, [SP, #8]
STRB	R0, [R1, #0]
;driverrf4463pro.c,866 :: 		for ( i = 0; i < 4; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,868 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_spi_fast_read125
L_spi_fast_read126:
;driverrf4463pro.c,869 :: 		nSEL = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODRbits+0)
MOVT	R1, #hi_addr(GPIOB_ODRbits+0)
_SX	[R1, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,870 :: 		}
L_end_spi_fast_read:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _spi_fast_read
_spi_write_fifo:
;driverrf4463pro.c,875 :: 		void spi_write_fifo( void ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;driverrf4463pro.c,878 :: 		i = 0;
; i start address is: 0 (R0)
MOVS	R0, #0
; i end address is: 0 (R0)
;driverrf4463pro.c,879 :: 		while ( i != 0xFF ) {
L_spi_write_fifo128:
; i start address is: 0 (R0)
CMP	R0, #255
IT	EQ
BEQ	L_spi_write_fifo129
; i end address is: 0 (R0)
;driverrf4463pro.c,880 :: 		i = check_cts();                // Check if you can send Command
BL	_check_cts+0
; i start address is: 0 (R0)
;driverrf4463pro.c,881 :: 		}
; i end address is: 0 (R0)
IT	AL
BAL	L_spi_write_fifo128
L_spi_write_fifo129:
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
;driverrf4463pro.c,886 :: 		ucRf4463SPIByte( WRITE_TX_FIFO );
MOVS	R0, #102
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,888 :: 		if ( mode == tx_test_mode) {
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_spi_write_fifo130
;driverrf4463pro.c,889 :: 		for ( i = 0; i < payload_length; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #0
; i end address is: 12 (R3)
L_spi_write_fifo131:
; i start address is: 12 (R3)
CMP	R3, #66
IT	CS
BCS	L_spi_write_fifo132
;driverrf4463pro.c,890 :: 		ucRf4463SPIByte( tx_test_aa_data[ i ] );   // Send 10 test data
MOVW	R0, #lo_addr(_tx_test_aa_data+0)
MOVT	R0, #hi_addr(_tx_test_aa_data+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,889 :: 		for ( i = 0; i < payload_length; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,891 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_spi_write_fifo131
L_spi_write_fifo132:
;driverrf4463pro.c,892 :: 		}
IT	AL
BAL	L_spi_write_fifo134
L_spi_write_fifo130:
;driverrf4463pro.c,894 :: 		for ( i = 0; i < payload_length; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #0
; i end address is: 12 (R3)
L_spi_write_fifo135:
; i start address is: 12 (R3)
CMP	R3, #66
IT	CS
BCS	L_spi_write_fifo136
;driverrf4463pro.c,895 :: 		ucRf4463SPIByte( tx_ph_data[ i ] );
MOVW	R0, #lo_addr(_tx_ph_data+0)
MOVT	R0, #hi_addr(_tx_ph_data+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,894 :: 		for ( i = 0; i < payload_length; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,896 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_spi_write_fifo135
L_spi_write_fifo136:
;driverrf4463pro.c,897 :: 		}
L_spi_write_fifo134:
;driverrf4463pro.c,898 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,899 :: 		}
L_end_spi_write_fifo:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _spi_write_fifo
_spi_read_fifo:
;driverrf4463pro.c,904 :: 		void spi_read_fifo( void ) {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;driverrf4463pro.c,907 :: 		i = 0;
; i start address is: 0 (R0)
MOVS	R0, #0
; i end address is: 0 (R0)
;driverrf4463pro.c,908 :: 		while ( i != 0xFF ) {
L_spi_read_fifo138:
; i start address is: 0 (R0)
CMP	R0, #255
IT	EQ
BEQ	L_spi_read_fifo139
; i end address is: 0 (R0)
;driverrf4463pro.c,909 :: 		i = check_cts();                   // Check if you can send Command
BL	_check_cts+0
; i start address is: 0 (R0)
;driverrf4463pro.c,910 :: 		}
; i end address is: 0 (R0)
IT	AL
BAL	L_spi_read_fifo138
L_spi_read_fifo139:
;driverrf4463pro.c,912 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,914 :: 		nSEL = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,915 :: 		ucRf4463SPIByte( READ_RX_FIFO );
MOVS	R0, #119
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,916 :: 		for ( i = 0; i < payload_length; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #0
; i end address is: 12 (R3)
L_spi_read_fifo140:
; i start address is: 12 (R3)
CMP	R3, #66
IT	CS
BCS	L_spi_read_fifo141
;driverrf4463pro.c,917 :: 		rx_buf[ i ] = ucRf4463SPIByte( 0xFF );      // Receive 10 test data
MOVW	R0, #lo_addr(_rx_buf+0)
MOVT	R0, #hi_addr(_rx_buf+0)
ADDS	R0, R0, R3
STR	R0, [SP, #4]
MOVS	R0, #255
BL	_ucRf4463SPIByte+0
LDR	R1, [SP, #4]
STRB	R0, [R1, #0]
;driverrf4463pro.c,916 :: 		for ( i = 0; i < payload_length; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,918 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_spi_read_fifo140
L_spi_read_fifo141:
;driverrf4463pro.c,919 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,920 :: 		}
L_end_spi_read_fifo:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _spi_read_fifo
_VRF4463SDNReset:
;driverrf4463pro.c,925 :: 		void VRF4463SDNReset( void ) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;driverrf4463pro.c,928 :: 		SDN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,929 :: 		Delay_ms( 6 );        // delay_1ms( 2 );        // RF Module reset  DELAY
MOVW	R7, #6463
MOVT	R7, #1
NOP
NOP
L_VRF4463SDNReset143:
SUBS	R7, R7, #1
BNE	L_VRF4463SDNReset143
NOP
NOP
NOP
;driverrf4463pro.c,930 :: 		SDN = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,931 :: 		Delay_ms( 10 );       // delay_1ms( 10 );        // Delay 10ms for RF module to enter working state
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_VRF4463SDNReset145:
SUBS	R7, R7, #1
BNE	L_VRF4463SDNReset145
NOP
NOP
NOP
;driverrf4463pro.c,933 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,935 :: 		nSEL = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,936 :: 		for ( i = 0; i < 7; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #0
; i end address is: 12 (R3)
L_VRF4463SDNReset147:
; i start address is: 12 (R3)
CMP	R3, #7
IT	CS
BCS	L_VRF4463SDNReset148
;driverrf4463pro.c,937 :: 		ucRf4463SPIByte( RF_POWER_UP_data[ i ] );   // send power up Command
MOVW	R0, #lo_addr(_RF_POWER_UP_data+0)
MOVT	R0, #hi_addr(_RF_POWER_UP_data+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,936 :: 		for ( i = 0; i < 7; i++ ) {
ADDS	R3, R3, #1
UXTB	R3, R3
;driverrf4463pro.c,938 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_VRF4463SDNReset147
L_VRF4463SDNReset148:
;driverrf4463pro.c,939 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,942 :: 		}
L_end_VRF4463SDNReset:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _VRF4463SDNReset
_vRf4463RSSI:
;driverrf4463pro.c,947 :: 		void vRf4463RSSI(){
SUB	SP, SP, #40
STR	LR, [SP, #0]
;driverrf4463pro.c,950 :: 		U8 pcRSSI[ 9 ] = {0}; // 9
ADD	R11, SP, #26
ADD	R10, R11, #13
MOVW	R12, #lo_addr(?ICSvRf4463RSSI_pcRSSI_L0+0)
MOVT	R12, #hi_addr(?ICSvRf4463RSSI_pcRSSI_L0+0)
BL	___CC2DW+0
;driverrf4463pro.c,951 :: 		U8 pcBuffer[ 4 ] = {0};
;driverrf4463pro.c,983 :: 		pcBuffer[ 0 ] = 0x11;
ADD	R2, SP, #35
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,984 :: 		pcBuffer[ 1 ] = 0x20;
ADDS	R1, R2, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,985 :: 		pcBuffer[ 2 ] = 0x01;
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,986 :: 		pcBuffer[ 3 ] = 0x4E;
ADDS	R1, R2, #3
MOVS	R0, #78
STRB	R0, [R1, #0]
;driverrf4463pro.c,987 :: 		pcBuffer[ 4 ] = 0x40;
ADDS	R1, R2, #4
MOVS	R0, #64
STRB	R0, [R1, #0]
;driverrf4463pro.c,988 :: 		spi_write( 5, pcBuffer );
MOV	R1, R2
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,992 :: 		pcBuffer[ 0 ] = 0x12; // ox12
ADD	R2, SP, #35
MOVS	R0, #18
STRB	R0, [R2, #0]
;driverrf4463pro.c,993 :: 		pcBuffer[ 1 ] = 0x22;
ADDS	R1, R2, #1
MOVS	R0, #34
STRB	R0, [R1, #0]
;driverrf4463pro.c,994 :: 		pcBuffer[ 2 ] = 0x4E;
ADDS	R1, R2, #2
MOVS	R0, #78
STRB	R0, [R1, #0]
;driverrf4463pro.c,995 :: 		spi_write( 3, pcBuffer );
MOV	R1, R2
MOVS	R0, #3
BL	_spi_write+0
;driverrf4463pro.c,996 :: 		spi_read( 9, pcRSSI );
ADD	R0, SP, #26
UXTB	R1, R0
MOVS	R0, #9
BL	_spi_read+0
;driverrf4463pro.c,999 :: 		rssi = ((pcRSSI[4] / 2) -64) -70;
ADD	R0, SP, #26
ADDS	R0, R0, #4
LDRB	R0, [R0, #0]
LSRS	R0, R0, #1
UXTB	R0, R0
SUBS	R0, #64
SXTH	R0, R0
SUBS	R0, #70
; rssi start address is: 28 (R7)
UXTB	R7, R0
;driverrf4463pro.c,1000 :: 		UART1_Write_Text("\r\n");
MOVS	R0, #13
STRB	R0, [SP, #4]
MOVS	R0, #10
STRB	R0, [SP, #5]
MOVS	R0, #0
STRB	R0, [SP, #6]
ADD	R0, SP, #4
BL	_UART1_Write_Text+0
;driverrf4463pro.c,1001 :: 		ShortToStr(rssi, pcRSSI);
ADD	R0, SP, #26
MOV	R1, R0
SXTB	R0, R7
; rssi end address is: 28 (R7)
BL	_ShortToStr+0
;driverrf4463pro.c,1002 :: 		UART1_Write_Text("[ RSSI ] = ");
ADD	R11, SP, #7
ADD	R10, R11, #12
MOVW	R12, #lo_addr(?ICS?lstr3_DriverRF4463PROMain+0)
MOVT	R12, #hi_addr(?ICS?lstr3_DriverRF4463PROMain+0)
BL	___CC2DW+0
ADD	R0, SP, #7
BL	_UART1_Write_Text+0
;driverrf4463pro.c,1003 :: 		UART1_Write_Text(pcRSSI);
ADD	R0, SP, #26
BL	_UART1_Write_Text+0
;driverrf4463pro.c,1004 :: 		UART1_Write_Text(" dBm\r\n");
MOVS	R0, #32
STRB	R0, [SP, #19]
MOVS	R0, #100
STRB	R0, [SP, #20]
MOVS	R0, #66
STRB	R0, [SP, #21]
MOVS	R0, #109
STRB	R0, [SP, #22]
MOVS	R0, #13
STRB	R0, [SP, #23]
MOVS	R0, #10
STRB	R0, [SP, #24]
MOVS	R0, #0
STRB	R0, [SP, #25]
ADD	R0, SP, #19
BL	_UART1_Write_Text+0
;driverrf4463pro.c,1005 :: 		}
L_end_vRf4463RSSI:
LDR	LR, [SP, #0]
ADD	SP, SP, #40
BX	LR
; end of _vRf4463RSSI
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
BLS	L_ucASCIIToByte150
;utils.c,47 :: 		ucMSBNibble -= 7;
MOVW	R2, #lo_addr(_ucMSBNibble+0)
MOVT	R2, #hi_addr(_ucMSBNibble+0)
LDRB	R1, [R2, #0]
SUBS	R1, R1, #7
STRB	R1, [R2, #0]
;utils.c,48 :: 		}
L_ucASCIIToByte150:
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
BLS	L_ucASCIIToByte151
;utils.c,52 :: 		ucLSBNibble -= 7;
MOVW	R2, #lo_addr(_ucLSBNibble+0)
MOVT	R2, #hi_addr(_ucLSBNibble+0)
LDRB	R1, [R2, #0]
SUBS	R1, R1, #7
STRB	R1, [R2, #0]
;utils.c,53 :: 		}
L_ucASCIIToByte151:
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
L_vASCIIToHex152:
; ucASCIICounter start address is: 24 (R6)
; pcHexConvertBuffer start address is: 8 (R2)
; ucConversionLength start address is: 0 (R0)
; pcASCIIConvertBuffer start address is: 4 (R1)
; pcASCIIConvertBuffer end address is: 4 (R1)
; pcHexConvertBuffer start address is: 8 (R2)
; pcHexConvertBuffer end address is: 8 (R2)
CMP	R6, R0
IT	CS
BCS	L_vASCIIToHex153
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
BLS	L_vASCIIToHex155
;utils.c,70 :: 		ucMSBNibble -= 7;
MOVW	R4, #lo_addr(_ucMSBNibble+0)
MOVT	R4, #hi_addr(_ucMSBNibble+0)
LDRB	R3, [R4, #0]
SUBS	R3, R3, #7
STRB	R3, [R4, #0]
;utils.c,71 :: 		}
L_vASCIIToHex155:
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
BLS	L_vASCIIToHex156
;utils.c,75 :: 		ucLSBNibble -= 7;
MOVW	R4, #lo_addr(_ucLSBNibble+0)
MOVT	R4, #hi_addr(_ucLSBNibble+0)
LDRB	R3, [R4, #0]
SUBS	R3, R3, #7
STRB	R3, [R4, #0]
;utils.c,76 :: 		}
L_vASCIIToHex156:
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
BAL	L_vASCIIToHex152
L_vASCIIToHex153:
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
L_vHexToASCII157:
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
BCS	L_vHexToASCII158
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
BAL	L_vHexToASCII157
L_vHexToASCII158:
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
L_vBufferSetToZero160:
; usPosition start address is: 16 (R4)
; pcBufferToClean start address is: 4 (R1)
; uslength start address is: 0 (R0)
; pcBufferToClean start address is: 4 (R1)
; pcBufferToClean end address is: 4 (R1)
CMP	R4, R0
IT	CS
BCS	L_vBufferSetToZero161
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
BAL	L_vBufferSetToZero160
L_vBufferSetToZero161:
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
L_vBufferSetTo255163:
; usPosition start address is: 16 (R4)
; pcBufferToClean start address is: 4 (R1)
; uslength start address is: 0 (R0)
; pcBufferToClean start address is: 4 (R1)
; pcBufferToClean end address is: 4 (R1)
CMP	R4, R0
IT	CS
BCS	L_vBufferSetTo255164
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
BAL	L_vBufferSetTo255163
L_vBufferSetTo255164:
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
L_vBufferSetToValue166:
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
BCS	L_vBufferSetToValue167
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
BAL	L_vBufferSetToValue166
L_vBufferSetToValue167:
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
L_vSerializeUUID169:
; ucCounter start address is: 20 (R5)
; pcTextConvertBuffer start address is: 4 (R1)
; pcHexConvertBuffer start address is: 0 (R0)
; pcHexConvertBuffer start address is: 0 (R0)
; pcHexConvertBuffer end address is: 0 (R0)
; pcTextConvertBuffer start address is: 4 (R1)
; pcTextConvertBuffer end address is: 4 (R1)
CMP	R5, #12
IT	CS
BCS	L_vSerializeUUID170
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
BAL	L_vSerializeUUID169
L_vSerializeUUID170:
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
L_vSerializeMACAddress172:
; usCounter start address is: 4 (R1)
; pcTextConvertBuffer start address is: 0 (R0)
CMP	R1, #6
IT	CS
BCS	L_vSerializeMACAddress173
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
BEQ	L_vSerializeMACAddress175
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
L_vSerializeMACAddress175:
;utils.c,148 :: 		for( usCounter = 0; usCounter < 6; usCounter++ ){
ADDS	R1, R1, #1
UXTH	R1, R1
;utils.c,154 :: 		}
; usCounter end address is: 4 (R1)
IT	AL
BAL	L_vSerializeMACAddress172
L_vSerializeMACAddress173:
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
L_vSerializeIPAddress176:
; ucCounter start address is: 28 (R7)
; pcHexConvertBuffer start address is: 24 (R6)
; pcHexConvertBuffer end address is: 24 (R6)
; pcTextConvertBuffer start address is: 32 (R8)
; pcTextConvertBuffer end address is: 32 (R8)
CMP	R7, #4
IT	CS
BCS	L_vSerializeIPAddress177
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
BEQ	L_vSerializeIPAddress179
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
L_vSerializeIPAddress179:
;utils.c,167 :: 		for( ucCounter = 0; ucCounter < 4; ucCounter++ ){
ADDS	R7, R7, #1
UXTB	R7, R7
;utils.c,176 :: 		}
; pcHexConvertBuffer end address is: 24 (R6)
; pcTextConvertBuffer end address is: 32 (R8)
; ucCounter end address is: 28 (R7)
IT	AL
BAL	L_vSerializeIPAddress176
L_vSerializeIPAddress177:
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
BEQ	L_vUARTISR180
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
BNE	L_vUARTISR181
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
BAL	L_vUARTISR182
L_vUARTISR181:
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
L_vUARTISR182:
;uarthandler.c,93 :: 		}
L_vUARTISR180:
;uarthandler.c,94 :: 		if( USART1_SRbits.ORE == 1 ){
MOVW	R0, #lo_addr(USART1_SRbits+0)
MOVT	R0, #hi_addr(USART1_SRbits+0)
_LX	[R0, ByteOffset(USART1_SRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUARTISR183
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
L_vUARTISR183:
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
SUB	SP, SP, #84
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
STRB	R1, [SP, #81]
;uarthandler.c,159 :: 		unsigned int usTempNode = 0;
;uarthandler.c,160 :: 		unsigned int usTempDestination = 0;
;uarthandler.c,161 :: 		unsigned int usTempTable = 0;
;uarthandler.c,162 :: 		unsigned int usTempCommand = 0;
;uarthandler.c,163 :: 		unsigned char ucTempBufferLength = 0;
;uarthandler.c,165 :: 		for( ucCommandCounter = 0; ucCommandCounter < UART_Commands; ucCommandCounter++ ){
MOVS	R1, #0
STRB	R1, [SP, #82]
; pcInBuffer end address is: 0 (R0)
MOV	R7, R0
L_vUARTCommands184:
; pcInBuffer start address is: 28 (R7)
LDRB	R1, [SP, #82]
CMP	R1, #22
IT	CS
BCS	L_vUARTCommands185
;uarthandler.c,166 :: 		if( strstr( pcInBuffer, pcUARTCommand[ ucCommandCounter ] ) ){
LDRB	R1, [SP, #82]
LSLS	R2, R1, #2
MOVW	R1, #lo_addr(_pcUARTCommand+0)
MOVT	R1, #hi_addr(_pcUARTCommand+0)
ADDS	R1, R1, R2
LDR	R1, [R1, #0]
MOV	R0, R7
BL	_strstr+0
CMP	R0, #0
IT	EQ
BEQ	L__vUARTCommands359
;uarthandler.c,167 :: 		switch( ucCommandCounter ){
IT	AL
BAL	L_vUARTCommands188
;uarthandler.c,168 :: 		case UART_CMD_WHO:
L_vUARTCommands190:
;uarthandler.c,169 :: 		UART1_Write_Text( "DONGLE\r\n" );
ADD	R11, SP, #72
ADD	R10, R11, #9
MOVW	R12, #lo_addr(?ICS?lstr28_DriverRF4463PROMain+0)
MOVT	R12, #hi_addr(?ICS?lstr28_DriverRF4463PROMain+0)
BL	___CC2DW+0
ADD	R1, SP, #72
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
L_vUARTCommands191:
SUBS	R7, R7, #1
BNE	L_vUARTCommands191
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
BAL	L_vUARTCommands189
;uarthandler.c,174 :: 		case UART_CMD_SEND:
L_vUARTCommands193:
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
L_vUARTCommands194:
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 12 (R3)
; pcInBuffer start address is: 16 (R4)
MOVW	R1, #lo_addr(_usUARTMessageLength+0)
MOVT	R1, #hi_addr(_usUARTMessageLength+0)
LDRH	R1, [R1, #0]
CMP	R0, R1
IT	CS
BCS	L_vUARTCommands195
;uarthandler.c,182 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
ADDS	R1, R4, R3
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands337
ADDS	R1, R4, R3
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands336
IT	AL
BAL	L_vUARTCommands199
; ucCounter end address is: 0 (R0)
; ucPosition end address is: 12 (R3)
L__vUARTCommands337:
L__vUARTCommands336:
;uarthandler.c,183 :: 		break;
IT	AL
BAL	L_vUARTCommands195
;uarthandler.c,184 :: 		}
L_vUARTCommands199:
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
BAL	L_vUARTCommands194
L_vUARTCommands195:
;uarthandler.c,189 :: 		break;
MOV	R3, R4
; pcInBuffer end address is: 16 (R4)
IT	AL
BAL	L_vUARTCommands189
;uarthandler.c,190 :: 		case UART_CMD_END:
L_vUARTCommands200:
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
L_vUARTCommands201:
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 8 (R2)
; ucPosition end address is: 8 (R2)
; pcInBuffer start address is: 12 (R3)
MOVW	R1, #lo_addr(_usUARTMessageLength+0)
MOVT	R1, #hi_addr(_usUARTMessageLength+0)
LDRH	R1, [R1, #0]
CMP	R0, R1
IT	CS
BCS	L_vUARTCommands202
; ucPosition end address is: 8 (R2)
;uarthandler.c,199 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
; ucPosition start address is: 8 (R2)
ADDS	R1, R3, R2
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands339
ADDS	R1, R3, R2
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands338
IT	AL
BAL	L_vUARTCommands206
; ucCounter end address is: 0 (R0)
; ucPosition end address is: 8 (R2)
L__vUARTCommands339:
L__vUARTCommands338:
;uarthandler.c,200 :: 		break;
IT	AL
BAL	L_vUARTCommands202
;uarthandler.c,201 :: 		}
L_vUARTCommands206:
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
BAL	L_vUARTCommands201
L_vUARTCommands202:
;uarthandler.c,207 :: 		break;
; pcInBuffer end address is: 12 (R3)
IT	AL
BAL	L_vUARTCommands189
;uarthandler.c,208 :: 		case UART_CMD_STAGE:
L_vUARTCommands207:
;uarthandler.c,216 :: 		break;
; pcInBuffer start address is: 28 (R7)
MOV	R3, R7
IT	AL
BAL	L_vUARTCommands189
;uarthandler.c,217 :: 		case UART_CMD_REBOOT:
L_vUARTCommands208:
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
L_vUARTCommands209:
SUBS	R7, R7, #1
BNE	L_vUARTCommands209
NOP
NOP
NOP
LDR	R7, [SP, #4]
;uarthandler.c,225 :: 		SystemReset();
BL	_SystemReset+0
;uarthandler.c,226 :: 		break;
MOV	R3, R7
IT	AL
BAL	L_vUARTCommands189
;uarthandler.c,227 :: 		case UART_CMD_PING:
L_vUARTCommands211:
;uarthandler.c,231 :: 		break;
MOV	R3, R7
IT	AL
BAL	L_vUARTCommands189
;uarthandler.c,232 :: 		case UART_CMD_TEST:
L_vUARTCommands212:
;uarthandler.c,234 :: 		memset( pcTempBuffer, '\0', 64 );
ADD	R1, SP, #8
MOVS	R2, #64
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
L_vUARTCommands213:
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 12 (R3)
; pcInBuffer start address is: 16 (R4)
CMP	R0, #12
IT	CS
BCS	L_vUARTCommands214
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
BAL	L_vUARTCommands213
L_vUARTCommands214:
;uarthandler.c,251 :: 		break;
MOV	R3, R4
; pcInBuffer end address is: 16 (R4)
IT	AL
BAL	L_vUARTCommands189
;uarthandler.c,252 :: 		case UART_CMD_REMOVE:
L_vUARTCommands216:
;uarthandler.c,255 :: 		memset( pcTempBuffer, '\0', 64 );
; pcInBuffer start address is: 28 (R7)
ADD	R1, SP, #8
MOVS	R2, #64
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
L_vUARTCommands217:
;uarthandler.c,260 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 12 (R3)
; pcInBuffer start address is: 36 (R9)
ADD	R1, R9, R3, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands341
ADD	R1, R9, R3, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands340
IT	AL
BAL	L_vUARTCommands222
; ucCounter end address is: 0 (R0)
; ucPosition end address is: 12 (R3)
L__vUARTCommands341:
L__vUARTCommands340:
;uarthandler.c,261 :: 		break;
IT	AL
BAL	L_vUARTCommands218
;uarthandler.c,262 :: 		}
L_vUARTCommands222:
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
BAL	L_vUARTCommands217
L_vUARTCommands218:
;uarthandler.c,266 :: 		usTempData = atoi( pcTempBuffer );
ADD	R1, SP, #8
MOV	R0, R1
BL	_atoi+0
;uarthandler.c,269 :: 		break;
MOV	R3, R9
; pcInBuffer end address is: 36 (R9)
IT	AL
BAL	L_vUARTCommands189
;uarthandler.c,270 :: 		case UART_CMD_CHANNEL:
L_vUARTCommands223:
;uarthandler.c,272 :: 		memset( pcTempBuffer, '\0', 64 );
; pcInBuffer start address is: 28 (R7)
ADD	R1, SP, #8
MOVS	R2, #64
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
L_vUARTCommands224:
;uarthandler.c,279 :: 		if( pcInBuffer[ ucPosition ] == ',' ){
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 40 (R10)
; pcInBuffer start address is: 36 (R9)
ADD	R1, R9, R10, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #44
IT	NE
BNE	L_vUARTCommands227
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
BAL	L_vUARTCommands225
;uarthandler.c,282 :: 		}
L_vUARTCommands227:
;uarthandler.c,283 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 40 (R10)
ADD	R1, R9, R10, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands343
ADD	R1, R9, R10, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands342
IT	AL
BAL	L_vUARTCommands230
; ucCounter end address is: 0 (R0)
L__vUARTCommands343:
L__vUARTCommands342:
;uarthandler.c,284 :: 		ucIgnoreNetwork = 1;
MOVS	R1, #1
STRB	R1, [SP, #81]
;uarthandler.c,285 :: 		break;
UXTB	R7, R10
IT	AL
BAL	L_vUARTCommands225
;uarthandler.c,286 :: 		}
L_vUARTCommands230:
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
BAL	L_vUARTCommands224
L_vUARTCommands225:
;uarthandler.c,290 :: 		usTempChannel = atoi( pcTempBuffer );
; ucPosition start address is: 28 (R7)
ADD	R1, SP, #8
MOV	R0, R1
BL	_atoi+0
;uarthandler.c,292 :: 		if( ucIgnoreNetwork == 0 ){
LDRB	R1, [SP, #81]
CMP	R1, #0
IT	NE
BNE	L_vUARTCommands231
;uarthandler.c,293 :: 		for( ucCounter = 0; ; ucCounter++ ){
; ucCounter start address is: 0 (R0)
MOVS	R0, #0
; ucPosition end address is: 28 (R7)
; pcInBuffer end address is: 36 (R9)
; ucCounter end address is: 0 (R0)
UXTB	R3, R7
MOV	R7, R9
L_vUARTCommands232:
;uarthandler.c,294 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 12 (R3)
; pcInBuffer start address is: 28 (R7)
ADDS	R1, R7, R3
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands345
ADDS	R1, R7, R3
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands344
IT	AL
BAL	L_vUARTCommands237
; ucCounter end address is: 0 (R0)
; ucPosition end address is: 12 (R3)
L__vUARTCommands345:
L__vUARTCommands344:
;uarthandler.c,295 :: 		break;
IT	AL
BAL	L_vUARTCommands233
;uarthandler.c,296 :: 		}
L_vUARTCommands237:
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
BAL	L_vUARTCommands232
L_vUARTCommands233:
;uarthandler.c,299 :: 		usTempNetwork = atoi( pcTempBuffer );
ADD	R1, SP, #8
MOV	R0, R1
BL	_atoi+0
;uarthandler.c,303 :: 		}
MOV	R3, R7
; pcInBuffer end address is: 28 (R7)
IT	AL
BAL	L_vUARTCommands238
L_vUARTCommands231:
;uarthandler.c,307 :: 		}
; pcInBuffer start address is: 36 (R9)
MOV	R3, R9
L_vUARTCommands238:
; pcInBuffer end address is: 36 (R9)
;uarthandler.c,309 :: 		break;
; pcInBuffer start address is: 12 (R3)
; pcInBuffer end address is: 12 (R3)
IT	AL
BAL	L_vUARTCommands189
;uarthandler.c,310 :: 		case UART_CMD_INFO:
L_vUARTCommands239:
;uarthandler.c,337 :: 		break;
; pcInBuffer start address is: 28 (R7)
MOV	R3, R7
IT	AL
BAL	L_vUARTCommands189
;uarthandler.c,338 :: 		case UART_CMD_SEARCH:
L_vUARTCommands240:
;uarthandler.c,342 :: 		break;
MOV	R3, R7
IT	AL
BAL	L_vUARTCommands189
;uarthandler.c,343 :: 		case UART_CMD_OVERRIDE:
L_vUARTCommands241:
;uarthandler.c,345 :: 		break;
MOV	R3, R7
IT	AL
BAL	L_vUARTCommands189
;uarthandler.c,346 :: 		case UART_CMD_RESET_FTY:
L_vUARTCommands242:
;uarthandler.c,348 :: 		break;
MOV	R3, R7
IT	AL
BAL	L_vUARTCommands189
;uarthandler.c,349 :: 		case UART_CMD_OVERRIDE_SET:
L_vUARTCommands243:
;uarthandler.c,351 :: 		break;
MOV	R3, R7
IT	AL
BAL	L_vUARTCommands189
;uarthandler.c,352 :: 		case UART_CMD_DISCOVER:
L_vUARTCommands244:
;uarthandler.c,356 :: 		case UART_CMD_FIND:
L_vUARTCommands245:
;uarthandler.c,360 :: 		break;
MOV	R3, R7
IT	AL
BAL	L_vUARTCommands189
;uarthandler.c,361 :: 		case UART_CMD_UNBLOCK:
L_vUARTCommands246:
;uarthandler.c,362 :: 		break;
MOV	R3, R7
IT	AL
BAL	L_vUARTCommands189
;uarthandler.c,363 :: 		case UART_CMD_SET_TX_POWER:
L_vUARTCommands247:
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
L_vUARTCommands248:
;uarthandler.c,368 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 12 (R3)
; pcInBuffer start address is: 36 (R9)
ADD	R1, R9, R3, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands347
ADD	R1, R9, R3, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands346
IT	AL
BAL	L_vUARTCommands253
; ucCounter end address is: 0 (R0)
; ucPosition end address is: 12 (R3)
L__vUARTCommands347:
L__vUARTCommands346:
;uarthandler.c,369 :: 		break;
IT	AL
BAL	L_vUARTCommands249
;uarthandler.c,370 :: 		}
L_vUARTCommands253:
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
BAL	L_vUARTCommands248
L_vUARTCommands249:
;uarthandler.c,373 :: 		usTempData = atoi( pcTempBuffer );
ADD	R1, SP, #8
MOV	R0, R1
BL	_atoi+0
;uarthandler.c,375 :: 		break;
MOV	R3, R9
; pcInBuffer end address is: 36 (R9)
IT	AL
BAL	L_vUARTCommands189
;uarthandler.c,376 :: 		case UART_CMD_SEND_RF_MESSAGE:
L_vUARTCommands254:
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
L_vUARTCommands255:
;uarthandler.c,385 :: 		if( pcInBuffer[ ucPosition ] == '|' ){
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 12 (R3)
; pcInBuffer start address is: 36 (R9)
ADD	R1, R9, R3, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #124
IT	NE
BNE	L_vUARTCommands258
; ucCounter end address is: 0 (R0)
;uarthandler.c,386 :: 		ucPosition++;
ADDS	R7, R3, #1
UXTB	R7, R7
; ucPosition end address is: 12 (R3)
; ucPosition start address is: 28 (R7)
;uarthandler.c,387 :: 		break;
IT	AL
BAL	L_vUARTCommands256
; ucPosition end address is: 28 (R7)
;uarthandler.c,388 :: 		}
L_vUARTCommands258:
;uarthandler.c,389 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
; ucPosition start address is: 12 (R3)
; ucCounter start address is: 0 (R0)
ADD	R1, R9, R3, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands349
ADD	R1, R9, R3, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands348
IT	AL
BAL	L_vUARTCommands261
; pcInBuffer end address is: 36 (R9)
; ucCounter end address is: 0 (R0)
; ucPosition end address is: 12 (R3)
L__vUARTCommands349:
L__vUARTCommands348:
;uarthandler.c,391 :: 		return;
IT	AL
BAL	L_end_vUARTCommands
;uarthandler.c,392 :: 		}
L_vUARTCommands261:
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
BAL	L_vUARTCommands255
L_vUARTCommands256:
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
L_vUARTCommands262:
;uarthandler.c,402 :: 		if( pcInBuffer[ ucPosition ] == '|' ){
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 12 (R3)
; pcInBuffer start address is: 36 (R9)
ADD	R1, R9, R3, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #124
IT	NE
BNE	L_vUARTCommands265
; ucCounter end address is: 0 (R0)
;uarthandler.c,403 :: 		ucPosition++;
ADDS	R7, R3, #1
UXTB	R7, R7
; ucPosition end address is: 12 (R3)
; ucPosition start address is: 28 (R7)
;uarthandler.c,404 :: 		break;
IT	AL
BAL	L_vUARTCommands263
; ucPosition end address is: 28 (R7)
;uarthandler.c,405 :: 		}
L_vUARTCommands265:
;uarthandler.c,406 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
; ucPosition start address is: 12 (R3)
; ucCounter start address is: 0 (R0)
ADD	R1, R9, R3, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands351
ADD	R1, R9, R3, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands350
IT	AL
BAL	L_vUARTCommands268
; pcInBuffer end address is: 36 (R9)
; ucCounter end address is: 0 (R0)
; ucPosition end address is: 12 (R3)
L__vUARTCommands351:
L__vUARTCommands350:
;uarthandler.c,408 :: 		return;
IT	AL
BAL	L_end_vUARTCommands
;uarthandler.c,409 :: 		}
L_vUARTCommands268:
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
BAL	L_vUARTCommands262
L_vUARTCommands263:
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
L_vUARTCommands269:
;uarthandler.c,419 :: 		if( pcInBuffer[ ucPosition ] == '|' ){
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 12 (R3)
; pcInBuffer start address is: 36 (R9)
ADD	R1, R9, R3, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #124
IT	NE
BNE	L_vUARTCommands272
; ucCounter end address is: 0 (R0)
;uarthandler.c,420 :: 		ucPosition++;
ADD	R10, R3, #1
UXTB	R10, R10
; ucPosition end address is: 12 (R3)
; ucPosition start address is: 40 (R10)
;uarthandler.c,421 :: 		break;
IT	AL
BAL	L_vUARTCommands270
; ucPosition end address is: 40 (R10)
;uarthandler.c,422 :: 		}
L_vUARTCommands272:
;uarthandler.c,423 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
; ucPosition start address is: 12 (R3)
; ucCounter start address is: 0 (R0)
ADD	R1, R9, R3, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands353
ADD	R1, R9, R3, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands352
IT	AL
BAL	L_vUARTCommands275
; pcInBuffer end address is: 36 (R9)
; ucCounter end address is: 0 (R0)
; ucPosition end address is: 12 (R3)
L__vUARTCommands353:
L__vUARTCommands352:
;uarthandler.c,425 :: 		return;
IT	AL
BAL	L_end_vUARTCommands
;uarthandler.c,426 :: 		}
L_vUARTCommands275:
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
BAL	L_vUARTCommands269
L_vUARTCommands270:
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
L_vUARTCommands276:
;uarthandler.c,436 :: 		if( pcInBuffer[ ucPosition ] == '|' ){
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 40 (R10)
; pcInBuffer start address is: 36 (R9)
ADD	R1, R9, R10, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #124
IT	NE
BNE	L_vUARTCommands279
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
BAL	L_vUARTCommands277
;uarthandler.c,439 :: 		}
L_vUARTCommands279:
;uarthandler.c,440 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 40 (R10)
ADD	R1, R9, R10, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands355
ADD	R1, R9, R10, LSL #0
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands354
IT	AL
BAL	L_vUARTCommands282
; ucCounter end address is: 0 (R0)
L__vUARTCommands355:
L__vUARTCommands354:
;uarthandler.c,442 :: 		break;
UXTB	R7, R10
IT	AL
BAL	L_vUARTCommands277
;uarthandler.c,443 :: 		}
L_vUARTCommands282:
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
BAL	L_vUARTCommands276
L_vUARTCommands277:
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
L_vUARTCommands283:
;uarthandler.c,453 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' || pcInBuffer[ ucPosition ] == '\0' ){
; ucTempBufferLength start address is: 0 (R0)
; ucPosition start address is: 12 (R3)
; pcInBuffer start address is: 16 (R4)
ADDS	R1, R4, R3
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands358
ADDS	R1, R4, R3
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands357
ADDS	R1, R4, R3
LDRB	R1, [R1, #0]
CMP	R1, #0
IT	EQ
BEQ	L__vUARTCommands356
IT	AL
BAL	L_vUARTCommands288
; ucTempBufferLength end address is: 0 (R0)
; ucPosition end address is: 12 (R3)
L__vUARTCommands358:
L__vUARTCommands357:
L__vUARTCommands356:
;uarthandler.c,455 :: 		break;
IT	AL
BAL	L_vUARTCommands284
;uarthandler.c,456 :: 		}
L_vUARTCommands288:
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
BAL	L_vUARTCommands283
L_vUARTCommands284:
;uarthandler.c,464 :: 		break;
MOV	R3, R4
; pcInBuffer end address is: 16 (R4)
IT	AL
BAL	L_vUARTCommands189
;uarthandler.c,465 :: 		default:
L_vUARTCommands289:
;uarthandler.c,467 :: 		break;
; pcInBuffer start address is: 28 (R7)
MOV	R3, R7
IT	AL
BAL	L_vUARTCommands189
;uarthandler.c,468 :: 		}
L_vUARTCommands188:
LDRB	R1, [SP, #82]
CMP	R1, #0
IT	EQ
BEQ	L_vUARTCommands190
LDRB	R1, [SP, #82]
CMP	R1, #1
IT	EQ
BEQ	L_vUARTCommands193
LDRB	R1, [SP, #82]
CMP	R1, #2
IT	EQ
BEQ	L_vUARTCommands200
LDRB	R1, [SP, #82]
CMP	R1, #3
IT	EQ
BEQ	L_vUARTCommands207
LDRB	R1, [SP, #82]
CMP	R1, #4
IT	EQ
BEQ	L_vUARTCommands208
LDRB	R1, [SP, #82]
CMP	R1, #5
IT	EQ
BEQ	L_vUARTCommands211
LDRB	R1, [SP, #82]
CMP	R1, #6
IT	EQ
BEQ	L_vUARTCommands212
LDRB	R1, [SP, #82]
CMP	R1, #7
IT	EQ
BEQ	L_vUARTCommands216
LDRB	R1, [SP, #82]
CMP	R1, #8
IT	EQ
BEQ	L_vUARTCommands223
LDRB	R1, [SP, #82]
CMP	R1, #11
IT	EQ
BEQ	L_vUARTCommands239
LDRB	R1, [SP, #82]
CMP	R1, #13
IT	EQ
BEQ	L_vUARTCommands240
LDRB	R1, [SP, #82]
CMP	R1, #14
IT	EQ
BEQ	L_vUARTCommands241
LDRB	R1, [SP, #82]
CMP	R1, #15
IT	EQ
BEQ	L_vUARTCommands242
LDRB	R1, [SP, #82]
CMP	R1, #16
IT	EQ
BEQ	L_vUARTCommands243
LDRB	R1, [SP, #82]
CMP	R1, #17
IT	EQ
BEQ	L_vUARTCommands244
LDRB	R1, [SP, #82]
CMP	R1, #18
IT	EQ
BEQ	L_vUARTCommands245
LDRB	R1, [SP, #82]
CMP	R1, #19
IT	EQ
BEQ	L_vUARTCommands246
LDRB	R1, [SP, #82]
CMP	R1, #20
IT	EQ
BEQ	L_vUARTCommands247
LDRB	R1, [SP, #82]
CMP	R1, #21
IT	EQ
BEQ	L_vUARTCommands254
IT	AL
BAL	L_vUARTCommands289
; pcInBuffer end address is: 28 (R7)
L_vUARTCommands189:
;uarthandler.c,469 :: 		}
; pcInBuffer start address is: 12 (R3)
; pcInBuffer end address is: 12 (R3)
IT	AL
BAL	L_vUARTCommands187
L__vUARTCommands359:
;uarthandler.c,166 :: 		if( strstr( pcInBuffer, pcUARTCommand[ ucCommandCounter ] ) ){
MOV	R3, R7
;uarthandler.c,469 :: 		}
L_vUARTCommands187:
;uarthandler.c,165 :: 		for( ucCommandCounter = 0; ucCommandCounter < UART_Commands; ucCommandCounter++ ){
; pcInBuffer start address is: 12 (R3)
LDRB	R1, [SP, #82]
ADDS	R1, R1, #1
STRB	R1, [SP, #82]
;uarthandler.c,470 :: 		}
MOV	R7, R3
; pcInBuffer end address is: 12 (R3)
IT	AL
BAL	L_vUARTCommands184
L_vUARTCommands185:
;uarthandler.c,471 :: 		}
L_end_vUARTCommands:
LDR	LR, [SP, #0]
ADD	SP, SP, #84
BX	LR
; end of _vUARTCommands
_RFISR:
;DriverRF4463PROMain.c,24 :: 		void RFISR() iv IVT_INT_EXTI15_10 ics ICS_AUTO{
SUB	SP, SP, #16
STR	LR, [SP, #0]
;DriverRF4463PROMain.c,25 :: 		if( EXTI_PR.B12 ){
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_LX	[R0, ByteOffset(EXTI_PR+0)]
CMP	R0, #0
IT	EQ
BEQ	L_RFISR290
;DriverRF4463PROMain.c,26 :: 		EXTI_PR.B12 |= 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_SX	[R0, ByteOffset(EXTI_PR+0)]
;DriverRF4463PROMain.c,27 :: 		LED_RED = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,28 :: 		ucRF4463IRQ = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,29 :: 		UART1_Write_Text( "RF int\r\n" );
ADD	R11, SP, #4
ADD	R10, R11, #9
MOVW	R12, #lo_addr(?ICS?lstr29_DriverRF4463PROMain+0)
MOVT	R12, #hi_addr(?ICS?lstr29_DriverRF4463PROMain+0)
BL	___CC2DW+0
ADD	R0, SP, #4
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,31 :: 		}
L_RFISR290:
;DriverRF4463PROMain.c,32 :: 		}
L_end_RFISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _RFISR
_Timer2_interrupt:
;DriverRF4463PROMain.c,34 :: 		void Timer2_interrupt() iv IVT_INT_TIM2 {
;DriverRF4463PROMain.c,35 :: 		TIM2_SR.UIF = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_SR+0)
MOVT	R0, #hi_addr(TIM2_SR+0)
_SX	[R0, ByteOffset(TIM2_SR+0)]
;DriverRF4463PROMain.c,36 :: 		Flag.rf_reach_timeout = 1; //Enter your code here
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,37 :: 		Flag.reach_1s = 1;
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,38 :: 		}
L_end_Timer2_interrupt:
BX	LR
; end of _Timer2_interrupt
_vRF4463MainCommandProcessor:
;DriverRF4463PROMain.c,41 :: 		void vRF4463MainCommandProcessor ( ) {
SUB	SP, SP, #4
;DriverRF4463PROMain.c,43 :: 		}
L_end_vRF4463MainCommandProcessor:
ADD	SP, SP, #4
BX	LR
; end of _vRF4463MainCommandProcessor
_InitTimer2:
;DriverRF4463PROMain.c,49 :: 		void InitTimer2(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;DriverRF4463PROMain.c,51 :: 		RCC_APB1ENR.TIM2EN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
_SX	[R0, ByteOffset(RCC_APB1ENR+0)]
;DriverRF4463PROMain.c,52 :: 		TIM2_CR1.CEN = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
_SX	[R0, ByteOffset(TIM2_CR1+0)]
;DriverRF4463PROMain.c,53 :: 		TIM2_PSC = 449;
MOVW	R1, #449
MOVW	R0, #lo_addr(TIM2_PSC+0)
MOVT	R0, #hi_addr(TIM2_PSC+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,54 :: 		TIM2_ARR = 63999;
MOVW	R1, #63999
MOVW	R0, #lo_addr(TIM2_ARR+0)
MOVT	R0, #hi_addr(TIM2_ARR+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,115 :: 		NVIC_IntEnable(IVT_INT_TIM2);
MOVW	R0, #44
BL	_NVIC_IntEnable+0
;DriverRF4463PROMain.c,116 :: 		TIM2_DIER.UIE = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
_SX	[R0, ByteOffset(TIM2_DIER+0)]
;DriverRF4463PROMain.c,117 :: 		TIM2_CR1.CEN = 1;
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
_SX	[R0, ByteOffset(TIM2_CR1+0)]
;DriverRF4463PROMain.c,118 :: 		}
L_end_InitTimer2:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _InitTimer2
_main:
;DriverRF4463PROMain.c,122 :: 		void main() {
SUB	SP, SP, #56
;DriverRF4463PROMain.c,128 :: 		Delay_ms( 2000 );                    // delay de depuracion
MOVW	R7, #13823
MOVT	R7, #366
NOP
NOP
L_main291:
SUBS	R7, R7, #1
BNE	L_main291
NOP
NOP
NOP
;DriverRF4463PROMain.c,132 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_6 );
MOVW	R1, #64
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,133 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_7 );
MOVW	R1, #128
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,134 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_8 );
MOVW	R1, #256
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,140 :: 		GPIO_Digital_Input( &GPIOC_BASE, _GPIO_PINMASK_12 );
MOVW	R1, #4096
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Input+0
;DriverRF4463PROMain.c,142 :: 		GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_12 );
MOVW	R1, #4096
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,143 :: 		GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_11 );
MOVW	R1, #2048
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,144 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_11 );
MOVW	R1, #2048
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,145 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_10 );
MOVW	R1, #1024
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,150 :: 		RCC_APB2ENRbits.AFIOEN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB2ENRbits+0)
MOVT	R0, #hi_addr(RCC_APB2ENRbits+0)
_SX	[R0, ByteOffset(RCC_APB2ENRbits+0)]
;DriverRF4463PROMain.c,154 :: 		AFIO_EXTICR4  |= 0x0002;
MOVW	R0, #lo_addr(AFIO_EXTICR4+0)
MOVT	R0, #hi_addr(AFIO_EXTICR4+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #2
MOVW	R0, #lo_addr(AFIO_EXTICR4+0)
MOVT	R0, #hi_addr(AFIO_EXTICR4+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,158 :: 		EXTI_IMR.B12    |= 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
_SX	[R0, ByteOffset(EXTI_IMR+0)]
;DriverRF4463PROMain.c,159 :: 		EXTI_FTSR.B12   |= 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
_SX	[R0, ByteOffset(EXTI_FTSR+0)]
;DriverRF4463PROMain.c,161 :: 		GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_7 );
MOVW	R1, #128
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,162 :: 		Sound_Init( &GPIOB_ODR, 7 );
MOVS	R1, #7
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
BL	_Sound_Init+0
;DriverRF4463PROMain.c,163 :: 		Sound_Play( 1000, 100 );
MOVS	R1, #100
MOVW	R0, #1000
BL	_Sound_Play+0
;DriverRF4463PROMain.c,165 :: 		nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_SX	[R0, ByteOffset(GPIOB_ODRbits+0)]
;DriverRF4463PROMain.c,167 :: 		LED_RED      = 1;
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,168 :: 		LED_GREEN    = 1;
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,169 :: 		LED_BLUE     = 1;
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,171 :: 		Delay_ms( 100 );
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_main293:
SUBS	R7, R7, #1
BNE	L_main293
NOP
NOP
NOP
;DriverRF4463PROMain.c,173 :: 		LED_RED      = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,174 :: 		LED_GREEN    = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,175 :: 		LED_BLUE     = 0;
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,177 :: 		InitTimer2();
BL	_InitTimer2+0
;DriverRF4463PROMain.c,180 :: 		vUARTTxInit();                // configura todos las parametros de USART
BL	_vUARTTxInit+0
;DriverRF4463PROMain.c,181 :: 		vSPI2Init();                  // configura todos los parametros de SPI
BL	_vSPI2Init+0
;DriverRF4463PROMain.c,186 :: 		freq3 = 9;
MOVS	R1, #9
MOVW	R0, #lo_addr(_freq3+0)
MOVT	R0, #hi_addr(_freq3+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,187 :: 		freq2 = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_freq2+0)
MOVT	R0, #hi_addr(_freq2+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,188 :: 		freq1 = 5;
MOVS	R1, #5
MOVW	R0, #lo_addr(_freq1+0)
MOVT	R0, #hi_addr(_freq1+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,191 :: 		power = 127;
MOVS	R1, #127
MOVW	R0, #lo_addr(_power+0)
MOVT	R0, #hi_addr(_power+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,193 :: 		rate  = dr_4p8;
MOVS	R1, #2
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,195 :: 		mode  = slave_mode;          // para transmision continua usar: tx_test_mode
MOVS	R1, #1
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,197 :: 		reset_mode = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_reset_mode+0)
MOVT	R0, #hi_addr(_reset_mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,201 :: 		VRF4463SDNReset();
BL	_VRF4463SDNReset+0
;DriverRF4463PROMain.c,202 :: 		vRF4463Init();
BL	_vRF4463Init+0
;DriverRF4463PROMain.c,203 :: 		vRF4463ClearInterrupts();
BL	_vRF4463ClearInterrupts+0
;DriverRF4463PROMain.c,204 :: 		vRF4463PartInfo ();
BL	_vRF4463PartInfo+0
;DriverRF4463PROMain.c,206 :: 		LED_GREEN    = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,207 :: 		LED_BLUE     = 0;
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,209 :: 		UART1_Write_Text( "RF Radio ready" );
ADD	R11, SP, #5
ADD	R10, R11, #15
MOVW	R12, #lo_addr(?ICS?lstr30_DriverRF4463PROMain+0)
MOVT	R12, #hi_addr(?ICS?lstr30_DriverRF4463PROMain+0)
BL	___CC2DW+0
ADD	R0, SP, #5
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,211 :: 		while ( 1 ) {
L_main295:
;DriverRF4463PROMain.c,213 :: 		if ( ucRF4463IRQ ) {
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main297
;DriverRF4463PROMain.c,214 :: 		ucRF4463IRQ = 0;       // limpia bandera
MOVS	R1, #0
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,215 :: 		spi_read_fifo();       // Read RX FIFO
BL	_spi_read_fifo+0
;DriverRF4463PROMain.c,216 :: 		vRF4463FifoReset();    // FIFO RESET
BL	_vRF4463FifoReset+0
;DriverRF4463PROMain.c,217 :: 		UART1_Write_Text( spi_read_buf );
MOVW	R0, #lo_addr(_spi_read_buf+0)
MOVT	R0, #hi_addr(_spi_read_buf+0)
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,218 :: 		}
L_main297:
;DriverRF4463PROMain.c,221 :: 		if ( mode == master_mode ) {
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main298
;DriverRF4463PROMain.c,222 :: 		vRF4463TxData();
BL	_vRF4463TxData+0
;DriverRF4463PROMain.c,223 :: 		}
IT	AL
BAL	L_main299
L_main298:
;DriverRF4463PROMain.c,225 :: 		else if ( mode == slave_mode ) {
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main300
;DriverRF4463PROMain.c,226 :: 		vRF4463RxInit();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,227 :: 		}
L_main300:
L_main299:
;DriverRF4463PROMain.c,229 :: 		if ( mode == tx_test_mode ) {
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_main301
;DriverRF4463PROMain.c,230 :: 		vRF4463TxCont();
BL	_vRF4463TxCont+0
;DriverRF4463PROMain.c,231 :: 		while ( 1 ) {
L_main302:
;DriverRF4463PROMain.c,232 :: 		if ( !nIRQ ) {
MOVW	R0, #lo_addr(GPIOC_IDRbits+0)
MOVT	R0, #hi_addr(GPIOC_IDRbits+0)
_LX	[R0, ByteOffset(GPIOC_IDRbits+0)]
CMP	R0, #0
IT	NE
BNE	L_main304
;DriverRF4463PROMain.c,233 :: 		vRF4463TxCont();
BL	_vRF4463TxCont+0
;DriverRF4463PROMain.c,234 :: 		}
L_main304:
;DriverRF4463PROMain.c,235 :: 		}
IT	AL
BAL	L_main302
;DriverRF4463PROMain.c,236 :: 		}
L_main301:
;DriverRF4463PROMain.c,238 :: 		if ( mode == rx_test_mode ) {
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BNE	L_main305
;DriverRF4463PROMain.c,239 :: 		vRF4463RxInit ();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,240 :: 		while ( 1 ) {
L_main306:
;DriverRF4463PROMain.c,242 :: 		}
IT	AL
BAL	L_main306
;DriverRF4463PROMain.c,243 :: 		}
L_main305:
;DriverRF4463PROMain.c,245 :: 		if ( reset_mode == 0 ) {
MOVW	R0, #lo_addr(_reset_mode+0)
MOVT	R0, #hi_addr(_reset_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main308
;DriverRF4463PROMain.c,247 :: 		while ( 1 ) {
L_main309:
;DriverRF4463PROMain.c,249 :: 		if ( Flag.reach_1s ) {
MOVW	R1, #lo_addr(_Flag+0)
MOVT	R1, #hi_addr(_Flag+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main311
;DriverRF4463PROMain.c,250 :: 		Flag.reach_1s = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,251 :: 		if ( mode == master_mode ) {
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main312
;DriverRF4463PROMain.c,252 :: 		vRF4463TxData();
BL	_vRF4463TxData+0
;DriverRF4463PROMain.c,253 :: 		}
L_main312:
;DriverRF4463PROMain.c,255 :: 		}
L_main311:
;DriverRF4463PROMain.c,259 :: 		if ( !nIRQ ) {          // !nIRQ
MOVW	R0, #lo_addr(GPIOC_IDRbits+0)
MOVT	R0, #hi_addr(GPIOC_IDRbits+0)
_LX	[R0, ByteOffset(GPIOC_IDRbits+0)]
CMP	R0, #0
IT	NE
BNE	L_main313
;DriverRF4463PROMain.c,260 :: 		spi_read(9,0x22);  // aqui hay que leer  el RSSI
MOVS	R1, #34
MOVS	R0, #9
BL	_spi_read+0
;DriverRF4463PROMain.c,261 :: 		iVal = ( float ) spi_read_buf[3];
MOVW	R0, #lo_addr(_spi_read_buf+3)
MOVT	R0, #hi_addr(_spi_read_buf+3)
LDRB	R0, [R0, #0]
BL	__UnsignedIntegralToFloat+0
;DriverRF4463PROMain.c,262 :: 		rssi = ((iVal / 2) - 64) -70;
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
;DriverRF4463PROMain.c,263 :: 		vRF4463ClearInterrupts();
BL	_vRF4463ClearInterrupts+0
;DriverRF4463PROMain.c,264 :: 		if ( ( spi_read_buf[ 4 ] & 0x08) == 0 ) { // crc error check
MOVW	R0, #lo_addr(_spi_read_buf+4)
MOVT	R0, #hi_addr(_spi_read_buf+4)
LDRB	R0, [R0, #0]
AND	R0, R0, #8
UXTB	R0, R0
CMP	R0, #0
IT	NE
BNE	L_main314
;DriverRF4463PROMain.c,265 :: 		spi_read_fifo();
BL	_spi_read_fifo+0
;DriverRF4463PROMain.c,266 :: 		vRF4463FifoReset();
BL	_vRF4463FifoReset+0
;DriverRF4463PROMain.c,269 :: 		for ( i = 4; i < payload_length - 1; i++ )                // Calculation Checksum
MOVS	R0, #4
STRB	R0, [SP, #4]
L_main315:
LDRB	R0, [SP, #4]
CMP	R0, #65
IT	GE
BGE	L_main316
LDRB	R0, [SP, #4]
ADDS	R0, R0, #1
STRB	R0, [SP, #4]
;DriverRF4463PROMain.c,270 :: 		chksum += rx_buf[ i ];
IT	AL
BAL	L_main315
L_main316:
;DriverRF4463PROMain.c,273 :: 		UART1_Write_Text("[ MENSAGGE ] = ");
ADD	R11, SP, #20
ADD	R10, R11, #16
MOVW	R12, #lo_addr(?ICS?lstr31_DriverRF4463PROMain+0)
MOVT	R12, #hi_addr(?ICS?lstr31_DriverRF4463PROMain+0)
BL	___CC2DW+0
ADD	R0, SP, #20
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,274 :: 		UART1_Write_Text( rx_buf );
MOVW	R0, #lo_addr(_rx_buf+0)
MOVT	R0, #hi_addr(_rx_buf+0)
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,275 :: 		UART1_Write_Text("\r\n");
MOVS	R0, #13
STRB	R0, [SP, #36]
MOVS	R0, #10
STRB	R0, [SP, #37]
MOVS	R0, #0
STRB	R0, [SP, #38]
ADD	R0, SP, #36
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,276 :: 		LED_GREEN ^= 1;                                        // Data received
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_LX	[R0, ByteOffset(GPIOC_ODRbits+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_SX	[R0, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,277 :: 		rx_cnt++;
MOVW	R1, #lo_addr(_rx_cnt+0)
MOVT	R1, #hi_addr(_rx_cnt+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,278 :: 		getRSSI();
BL	_getRSSI+0
;DriverRF4463PROMain.c,281 :: 		vRF4463RxInit();    // The received data is wrong, you must continue to receive
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,282 :: 		}
IT	AL
BAL	L_main318
L_main314:
;DriverRF4463PROMain.c,285 :: 		UART1_Write_Text("[ CRC ] Fail\r\n" );
ADD	R11, SP, #39
ADD	R10, R11, #15
MOVW	R12, #lo_addr(?ICS?lstr33_DriverRF4463PROMain+0)
MOVT	R12, #hi_addr(?ICS?lstr33_DriverRF4463PROMain+0)
BL	___CC2DW+0
ADD	R0, SP, #39
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,286 :: 		VRF4463SDNReset();
BL	_VRF4463SDNReset+0
;DriverRF4463PROMain.c,287 :: 		vRF4463Init();
BL	_vRF4463Init+0
;DriverRF4463PROMain.c,288 :: 		vRF4463RxInit();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,289 :: 		}
L_main318:
;DriverRF4463PROMain.c,290 :: 		}
L_main313:
;DriverRF4463PROMain.c,292 :: 		}
IT	AL
BAL	L_main309
;DriverRF4463PROMain.c,293 :: 		}
L_main308:
;DriverRF4463PROMain.c,294 :: 		}
IT	AL
BAL	L_main295
;DriverRF4463PROMain.c,295 :: 		}void getRSSI()
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
_getRSSI:
SUB	SP, SP, #24
STR	LR, [SP, #0]
;DriverRF4463PROMain.c,297 :: 		ShortToStr(rssi,Value );
MOVW	R0, #lo_addr(_rssi+0)
MOVT	R0, #hi_addr(_rssi+0)
LDR	R0, [R0, #0]
BL	__FloatToSignedIntegral+0
SXTB	R0, R0
MOVW	R1, #lo_addr(_Value+0)
MOVT	R1, #hi_addr(_Value+0)
BL	_ShortToStr+0
;DriverRF4463PROMain.c,298 :: 		UART1_Write_Text("[ RSSI ] = ");
ADD	R11, SP, #4
ADD	R10, R11, #12
MOVW	R12, #lo_addr(?ICS?lstr34_DriverRF4463PROMain+0)
MOVT	R12, #hi_addr(?ICS?lstr34_DriverRF4463PROMain+0)
BL	___CC2DW+0
ADD	R0, SP, #4
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,299 :: 		UART1_Write_Text( Value );
MOVW	R0, #lo_addr(_Value+0)
MOVT	R0, #hi_addr(_Value+0)
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,300 :: 		UART1_Write_Text(" dBm\r\n");
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
;DriverRF4463PROMain.c,301 :: 		}
L_end_getRSSI:
LDR	LR, [SP, #0]
ADD	SP, SP, #24
BX	LR
; end of _getRSSI
