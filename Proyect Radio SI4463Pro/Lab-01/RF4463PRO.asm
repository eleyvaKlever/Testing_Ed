_main:
;RF4463PRO.c,540 :: 		void main() {
;RF4463PRO.c,543 :: 		_SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI2_PB13_14_15 );
MOVW	R2, #lo_addr(__GPIO_MODULE_SPI2_PB13_14_15+0)
MOVT	R2, #hi_addr(__GPIO_MODULE_SPI2_PB13_14_15+0)
MOVW	R1, #772
;RF4463PRO.c,542 :: 		SPI2_Init_Advanced( _SPI_FPCLK_DIV8, _SPI_MASTER | _SPI_8_BIT | _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION | _SPI_MSB_FIRST |
MOVS	R0, #2
;RF4463PRO.c,543 :: 		_SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI2_PB13_14_15 );
BL	_SPI2_Init_Advanced+0
;RF4463PRO.c,545 :: 		UART1_Init_Advanced( 115200, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10 );
MOVW	R0, #lo_addr(__GPIO_MODULE_USART1_PA9_10+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_USART1_PA9_10+0)
PUSH	(R0)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
MOV	R0, #115200
BL	_UART1_Init_Advanced+0
ADD	SP, SP, #4
;RF4463PRO.c,552 :: 		GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_12 );  // RF4463nSEL
MOVW	R1, #4096
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;RF4463PRO.c,553 :: 		GPIO_Digital_Input( &GPIOC_BASE, _GPIO_PINMASK_12 );   // RF4463nIRQ
MOVW	R1, #4096
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Input+0
;RF4463PRO.c,554 :: 		GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_11 );  // RF4463nSDN
MOVW	R1, #2048
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;RF4463PRO.c,556 :: 		GPIO_Digital_Input( &GPIOC_BASE, _GPIO_PINMASK_11 );   // RF4463GPIO0
MOVW	R1, #2048
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Input+0
;RF4463PRO.c,557 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_10 );  // RF4463GPIO1
MOVW	R1, #1024
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;RF4463PRO.c,559 :: 		GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_7 );   // Buzzer
MOVW	R1, #128
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;RF4463PRO.c,560 :: 		GPIO_Digital_Input( &GPIOB_BASE, _GPIO_PINMASK_8 );    // Boton
MOVW	R1, #256
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Input+0
;RF4463PRO.c,562 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_6 );   // LED_RED
MOVW	R1, #64
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;RF4463PRO.c,563 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_7 );   // LED_GREEN
MOVW	R1, #128
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;RF4463PRO.c,564 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_8 );   // LED_BLUE
MOVW	R1, #256
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;RF4463PRO.c,569 :: 		mode = master_mode;   // working mode setting
MOVS	R1, #0
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
STRB	R1, [R0, #0]
;RF4463PRO.c,572 :: 		Sound_Init(&GPIOB_ODR, 7);
MOVS	R1, #7
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
BL	_Sound_Init+0
;RF4463PRO.c,573 :: 		LED_GREEN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;RF4463PRO.c,574 :: 		Sound_Play(3000, 100);
MOVS	R1, #100
MOVW	R0, #3000
BL	_Sound_Play+0
;RF4463PRO.c,575 :: 		Delay_ms(100);
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
;RF4463PRO.c,576 :: 		Sound_Play(4000, 100);
MOVS	R1, #100
MOVW	R0, #4000
BL	_Sound_Play+0
;RF4463PRO.c,577 :: 		LED_GREEN =0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;RF4463PRO.c,580 :: 		sdn_reset();
BL	_sdn_reset+0
;RF4463PRO.c,582 :: 		SI4463_init();
BL	_SI4463_init+0
;RF4463PRO.c,589 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
_sdn_reset:
;RF4463PRO.c,592 :: 		void sdn_reset(void)
SUB	SP, SP, #12
STR	LR, [SP, #0]
;RF4463PRO.c,620 :: 		uint8_t pcBuffer[ 7 ] = { RF_POWER_UP };
MOVS	R0, #2
STRB	R0, [SP, #4]
MOVS	R0, #1
STRB	R0, [SP, #5]
MOVS	R0, #0
STRB	R0, [SP, #6]
MOVS	R0, #1
STRB	R0, [SP, #7]
MOVS	R0, #201
STRB	R0, [SP, #8]
MOVS	R0, #195
STRB	R0, [SP, #9]
MOVS	R0, #128
STRB	R0, [SP, #10]
;RF4463PRO.c,634 :: 		RF4463nSDN = 0x01;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;RF4463PRO.c,635 :: 		Delay_us( 16 );
MOVW	R7, #191
MOVT	R7, #0
NOP
NOP
L_sdn_reset2:
SUBS	R7, R7, #1
BNE	L_sdn_reset2
NOP
NOP
NOP
;RF4463PRO.c,636 :: 		RF4463nSDN = 0x00 ;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;RF4463PRO.c,638 :: 		Delay_ms( 6 );
MOVW	R7, #6463
MOVT	R7, #1
NOP
NOP
L_sdn_reset4:
SUBS	R7, R7, #1
BNE	L_sdn_reset4
NOP
NOP
NOP
;RF4463PRO.c,640 :: 		RF4463nSEL = 0x00 ;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;RF4463PRO.c,641 :: 		vRf4463SPIWriteBuffer( sizeof( pcBuffer ), pcBuffer );
ADD	R0, SP, #4
MOV	R1, R0
MOVS	R0, #7
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,642 :: 		RF4463nSEL= 0x01 ;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;RF4463PRO.c,646 :: 		}
L_end_sdn_reset:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _sdn_reset
_SI4463_init:
;RF4463PRO.c,649 :: 		void SI4463_init(void)
SUB	SP, SP, #44
STR	LR, [SP, #0]
;RF4463PRO.c,656 :: 		for(i=4;i<16;i++)
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_SI4463_init6:
; i start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_SI4463_init7
;RF4463PRO.c,657 :: 		RF_MODEM_MOD_TYPE_12_data[i] = RF_MODEM_MOD_TYPE_12[rate][i-4];
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
;RF4463PRO.c,656 :: 		for(i=4;i<16;i++)
ADDS	R3, R3, #1
UXTB	R3, R3
;RF4463PRO.c,657 :: 		RF_MODEM_MOD_TYPE_12_data[i] = RF_MODEM_MOD_TYPE_12[rate][i-4];
; i end address is: 12 (R3)
IT	AL
BAL	L_SI4463_init6
L_SI4463_init7:
;RF4463PRO.c,658 :: 		if(freq3<8)
MOVW	R0, #lo_addr(_freq3+0)
MOVT	R0, #hi_addr(_freq3+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CS
BCS	L_SI4463_init9
;RF4463PRO.c,660 :: 		for(i=4;i<12;i++)
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_SI4463_init10:
; i start address is: 12 (R3)
CMP	R3, #12
IT	CS
BCS	L_SI4463_init11
;RF4463PRO.c,661 :: 		RF_MODEM_TX_RAMP_DELAY_8_data[i] = RF_MODEM_TX_RAMP_DELAY_8_433[rate][i-4];
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
;RF4463PRO.c,660 :: 		for(i=4;i<12;i++)
ADDS	R3, R3, #1
UXTB	R3, R3
;RF4463PRO.c,661 :: 		RF_MODEM_TX_RAMP_DELAY_8_data[i] = RF_MODEM_TX_RAMP_DELAY_8_433[rate][i-4];
; i end address is: 12 (R3)
IT	AL
BAL	L_SI4463_init10
L_SI4463_init11:
;RF4463PRO.c,662 :: 		for(i=4;i<11;i++)
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_SI4463_init13:
; i start address is: 12 (R3)
CMP	R3, #11
IT	CS
BCS	L_SI4463_init14
;RF4463PRO.c,663 :: 		RF_MODEM_AFC_GEAR_7_data[i] = RF_MODEM_AFC_GEAR_7_433[rate][i-4];
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
;RF4463PRO.c,662 :: 		for(i=4;i<11;i++)
ADDS	R3, R3, #1
UXTB	R3, R3
;RF4463PRO.c,663 :: 		RF_MODEM_AFC_GEAR_7_data[i] = RF_MODEM_AFC_GEAR_7_433[rate][i-4];
; i end address is: 12 (R3)
IT	AL
BAL	L_SI4463_init13
L_SI4463_init14:
;RF4463PRO.c,664 :: 		for(i=4;i<15;i++)
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_SI4463_init16:
; i start address is: 12 (R3)
CMP	R3, #15
IT	CS
BCS	L_SI4463_init17
;RF4463PRO.c,665 :: 		RF_MODEM_OOK_CNT1_11_data[i] =RF_MODEM_OOK_CNT1_11_433[rate][i-4];
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
;RF4463PRO.c,664 :: 		for(i=4;i<15;i++)
ADDS	R3, R3, #1
UXTB	R3, R3
;RF4463PRO.c,665 :: 		RF_MODEM_OOK_CNT1_11_data[i] =RF_MODEM_OOK_CNT1_11_433[rate][i-4];
; i end address is: 12 (R3)
IT	AL
BAL	L_SI4463_init16
L_SI4463_init17:
;RF4463PRO.c,666 :: 		for(i=4;i<16;i++)
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_SI4463_init19:
; i start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_SI4463_init20
;RF4463PRO.c,667 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[i] =RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433[rate][i-4];
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
;RF4463PRO.c,666 :: 		for(i=4;i<16;i++)
ADDS	R3, R3, #1
UXTB	R3, R3
;RF4463PRO.c,667 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[i] =RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433[rate][i-4];
; i end address is: 12 (R3)
IT	AL
BAL	L_SI4463_init19
L_SI4463_init20:
;RF4463PRO.c,668 :: 		for(i=4;i<16;i++)
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_SI4463_init22:
; i start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_SI4463_init23
;RF4463PRO.c,669 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[i] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433[rate][i-4];
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
;RF4463PRO.c,668 :: 		for(i=4;i<16;i++)
ADDS	R3, R3, #1
UXTB	R3, R3
;RF4463PRO.c,669 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[i] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433[rate][i-4];
; i end address is: 12 (R3)
IT	AL
BAL	L_SI4463_init22
L_SI4463_init23:
;RF4463PRO.c,670 :: 		for(i=4;i<16;i++)
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_SI4463_init25:
; i start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_SI4463_init26
;RF4463PRO.c,671 :: 		RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[i] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433[rate][i-4];
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
;RF4463PRO.c,670 :: 		for(i=4;i<16;i++)
ADDS	R3, R3, #1
UXTB	R3, R3
;RF4463PRO.c,671 :: 		RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[i] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433[rate][i-4];
; i end address is: 12 (R3)
IT	AL
BAL	L_SI4463_init25
L_SI4463_init26:
;RF4463PRO.c,672 :: 		for(i=4;i<13;i++)
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_SI4463_init28:
; i start address is: 12 (R3)
CMP	R3, #13
IT	CS
BCS	L_SI4463_init29
;RF4463PRO.c,673 :: 		RF_MODEM_AGC_WINDOW_SIZE_9_data[i] = RF_MODEM_AGC_WINDOW_SIZE_9_433[rate][i-4];
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
;RF4463PRO.c,672 :: 		for(i=4;i<13;i++)
ADDS	R3, R3, #1
UXTB	R3, R3
;RF4463PRO.c,673 :: 		RF_MODEM_AGC_WINDOW_SIZE_9_data[i] = RF_MODEM_AGC_WINDOW_SIZE_9_433[rate][i-4];
; i end address is: 12 (R3)
IT	AL
BAL	L_SI4463_init28
L_SI4463_init29:
;RF4463PRO.c,674 :: 		for(i=4;i<13;i++)
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_SI4463_init31:
; i start address is: 12 (R3)
CMP	R3, #13
IT	CS
BCS	L_SI4463_init32
;RF4463PRO.c,675 :: 		RF_MODEM_BCR_OSR_1_9_data[i] = RF_MODEM_BCR_OSR_1_9_433[rate][i-4];
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
;RF4463PRO.c,674 :: 		for(i=4;i<13;i++)
ADDS	R3, R3, #1
UXTB	R3, R3
;RF4463PRO.c,675 :: 		RF_MODEM_BCR_OSR_1_9_data[i] = RF_MODEM_BCR_OSR_1_9_433[rate][i-4];
; i end address is: 12 (R3)
IT	AL
BAL	L_SI4463_init31
L_SI4463_init32:
;RF4463PRO.c,676 :: 		}
IT	AL
BAL	L_SI4463_init34
L_SI4463_init9:
;RF4463PRO.c,679 :: 		for(i=4;i<12;i++)
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_SI4463_init35:
; i start address is: 12 (R3)
CMP	R3, #12
IT	CS
BCS	L_SI4463_init36
;RF4463PRO.c,680 :: 		RF_MODEM_TX_RAMP_DELAY_8_data[i] = RF_MODEM_TX_RAMP_DELAY_8_850[rate][i-4];
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
;RF4463PRO.c,679 :: 		for(i=4;i<12;i++)
ADDS	R3, R3, #1
UXTB	R3, R3
;RF4463PRO.c,680 :: 		RF_MODEM_TX_RAMP_DELAY_8_data[i] = RF_MODEM_TX_RAMP_DELAY_8_850[rate][i-4];
; i end address is: 12 (R3)
IT	AL
BAL	L_SI4463_init35
L_SI4463_init36:
;RF4463PRO.c,681 :: 		for(i=4;i<11;i++)
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_SI4463_init38:
; i start address is: 12 (R3)
CMP	R3, #11
IT	CS
BCS	L_SI4463_init39
;RF4463PRO.c,682 :: 		RF_MODEM_AFC_GEAR_7_data[i] = RF_MODEM_AFC_GEAR_7_850[rate][i-4];
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
;RF4463PRO.c,681 :: 		for(i=4;i<11;i++)
ADDS	R3, R3, #1
UXTB	R3, R3
;RF4463PRO.c,682 :: 		RF_MODEM_AFC_GEAR_7_data[i] = RF_MODEM_AFC_GEAR_7_850[rate][i-4];
; i end address is: 12 (R3)
IT	AL
BAL	L_SI4463_init38
L_SI4463_init39:
;RF4463PRO.c,683 :: 		for(i=4;i<15;i++)
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_SI4463_init41:
; i start address is: 12 (R3)
CMP	R3, #15
IT	CS
BCS	L_SI4463_init42
;RF4463PRO.c,684 :: 		RF_MODEM_OOK_CNT1_11_data[i] =RF_MODEM_OOK_CNT1_11_850[rate][i-4];
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
;RF4463PRO.c,683 :: 		for(i=4;i<15;i++)
ADDS	R3, R3, #1
UXTB	R3, R3
;RF4463PRO.c,684 :: 		RF_MODEM_OOK_CNT1_11_data[i] =RF_MODEM_OOK_CNT1_11_850[rate][i-4];
; i end address is: 12 (R3)
IT	AL
BAL	L_SI4463_init41
L_SI4463_init42:
;RF4463PRO.c,685 :: 		for(i=4;i<16;i++)
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_SI4463_init44:
; i start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_SI4463_init45
;RF4463PRO.c,686 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[i] =RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850[rate][i-4];
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
;RF4463PRO.c,685 :: 		for(i=4;i<16;i++)
ADDS	R3, R3, #1
UXTB	R3, R3
;RF4463PRO.c,686 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[i] =RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850[rate][i-4];
; i end address is: 12 (R3)
IT	AL
BAL	L_SI4463_init44
L_SI4463_init45:
;RF4463PRO.c,687 :: 		for(i=4;i<16;i++)
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_SI4463_init47:
; i start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_SI4463_init48
;RF4463PRO.c,688 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[i] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850[rate][i-4];
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
;RF4463PRO.c,687 :: 		for(i=4;i<16;i++)
ADDS	R3, R3, #1
UXTB	R3, R3
;RF4463PRO.c,688 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[i] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850[rate][i-4];
; i end address is: 12 (R3)
IT	AL
BAL	L_SI4463_init47
L_SI4463_init48:
;RF4463PRO.c,689 :: 		for(i=4;i<16;i++)
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_SI4463_init50:
; i start address is: 12 (R3)
CMP	R3, #16
IT	CS
BCS	L_SI4463_init51
;RF4463PRO.c,690 :: 		RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[i] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850[rate][i-4];
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
;RF4463PRO.c,689 :: 		for(i=4;i<16;i++)
ADDS	R3, R3, #1
UXTB	R3, R3
;RF4463PRO.c,690 :: 		RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[i] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850[rate][i-4];
; i end address is: 12 (R3)
IT	AL
BAL	L_SI4463_init50
L_SI4463_init51:
;RF4463PRO.c,691 :: 		for(i=4;i<13;i++)
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_SI4463_init53:
; i start address is: 12 (R3)
CMP	R3, #13
IT	CS
BCS	L_SI4463_init54
;RF4463PRO.c,692 :: 		RF_MODEM_AGC_WINDOW_SIZE_9_data[i] = RF_MODEM_AGC_WINDOW_SIZE_9_850[rate][i-4];
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
;RF4463PRO.c,691 :: 		for(i=4;i<13;i++)
ADDS	R3, R3, #1
UXTB	R3, R3
;RF4463PRO.c,692 :: 		RF_MODEM_AGC_WINDOW_SIZE_9_data[i] = RF_MODEM_AGC_WINDOW_SIZE_9_850[rate][i-4];
; i end address is: 12 (R3)
IT	AL
BAL	L_SI4463_init53
L_SI4463_init54:
;RF4463PRO.c,693 :: 		for(i=4;i<13;i++)
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_SI4463_init56:
; i start address is: 12 (R3)
CMP	R3, #13
IT	CS
BCS	L_SI4463_init57
;RF4463PRO.c,694 :: 		RF_MODEM_BCR_OSR_1_9_data[i] = RF_MODEM_BCR_OSR_1_9_850[rate][i-4];
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
;RF4463PRO.c,693 :: 		for(i=4;i<13;i++)
ADDS	R3, R3, #1
UXTB	R3, R3
;RF4463PRO.c,694 :: 		RF_MODEM_BCR_OSR_1_9_data[i] = RF_MODEM_BCR_OSR_1_9_850[rate][i-4];
; i end address is: 12 (R3)
IT	AL
BAL	L_SI4463_init56
L_SI4463_init57:
;RF4463PRO.c,695 :: 		}
L_SI4463_init34:
;RF4463PRO.c,696 :: 		for(i=4;i<11;i++)
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_SI4463_init59:
; i start address is: 12 (R3)
CMP	R3, #11
IT	CS
BCS	L_SI4463_init60
;RF4463PRO.c,697 :: 		RF_SYNTH_PFDCP_CPFF_7_data[i] = RF_SYNTH_PFDCP_CPFF_7[rate][i-4];
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
;RF4463PRO.c,696 :: 		for(i=4;i<11;i++)
ADDS	R3, R3, #1
UXTB	R3, R3
;RF4463PRO.c,697 :: 		RF_SYNTH_PFDCP_CPFF_7_data[i] = RF_SYNTH_PFDCP_CPFF_7[rate][i-4];
; i end address is: 12 (R3)
IT	AL
BAL	L_SI4463_init59
L_SI4463_init60:
;RF4463PRO.c,699 :: 		GPIO_SET(mode);
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
BL	_GPIO_SET+0
;RF4463PRO.c,702 :: 		app_command_buf[0]  = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;RF4463PRO.c,703 :: 		app_command_buf[1]  = 0x00;    // 0x0000
ADDS	R1, R2, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,704 :: 		app_command_buf[2]  = 0x01;    // ¹² 1¸ö²ÎÊý
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;RF4463PRO.c,705 :: 		app_command_buf[3]  = 0x00;   // 0x0000
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,706 :: 		app_command_buf[4]  = 98;  // freq  adjustment
ADDS	R1, R2, #4
MOVS	R0, #98
STRB	R0, [R1, #0]
;RF4463PRO.c,707 :: 		vRf4463SPIWriteBuffer(5, app_command_buf);
MOV	R1, R2
MOVS	R0, #5
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,708 :: 		vBufferSetToZero( app_command_buf, 20 );
ADD	R0, SP, #4
MOVS	R1, #20
BL	_vBufferSetToZero+0
;RF4463PRO.c,710 :: 		UART1_Write_Text("Paret Info : ");
ADD	R11, SP, #24
ADD	R10, R11, #14
MOVW	R12, #lo_addr(?ICS?lstr1_RF4463PRO+0)
MOVT	R12, #hi_addr(?ICS?lstr1_RF4463PRO+0)
BL	___CC2DW+0
ADD	R0, SP, #24
BL	_UART1_Write_Text+0
;RF4463PRO.c,711 :: 		ucRf4463GetCommand( 8, 0x01, app_command_buf );
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #1
MOVS	R0, #8
BL	_ucRf4463GetCommand+0
;RF4463PRO.c,712 :: 		UART1_Write_Text("\n\r");
MOVS	R0, #10
STRB	R0, [SP, #38]
MOVS	R0, #13
STRB	R0, [SP, #39]
MOVS	R0, #0
STRB	R0, [SP, #40]
ADD	R0, SP, #38
BL	_UART1_Write_Text+0
;RF4463PRO.c,715 :: 		app_command_buf[0]  = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;RF4463PRO.c,716 :: 		app_command_buf[1]  = 0x00;    // 0x0003
ADDS	R1, R2, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,717 :: 		app_command_buf[2]  = 0x01;    // ¹² 1¸ö²ÎÊý
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;RF4463PRO.c,718 :: 		app_command_buf[3]  = 0x03;   // 0x0003
ADDS	R1, R2, #3
MOVS	R0, #3
STRB	R0, [R1, #0]
;RF4463PRO.c,719 :: 		app_command_buf[4]  = 0x40;  // tx = rx = 64 byte, ÆÕÍ¨ PH£¬high performance mode  ?????????????????????
ADDS	R1, R2, #4
MOVS	R0, #64
STRB	R0, [R1, #0]
;RF4463PRO.c,720 :: 		vRf4463SPIWriteBuffer(5, app_command_buf);
MOV	R1, R2
MOVS	R0, #5
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,721 :: 		vBufferSetToZero( app_command_buf, 20 );
ADD	R0, SP, #4
MOVS	R1, #20
BL	_vBufferSetToZero+0
;RF4463PRO.c,724 :: 		vRf4463SPIWriteBuffer(0x08, RF_FRR_CTL_A_MODE_4_data);    // disable all fast response register
MOVW	R1, #lo_addr(_RF_FRR_CTL_A_MODE_4_data+0)
MOVT	R1, #hi_addr(_RF_FRR_CTL_A_MODE_4_data+0)
MOVS	R0, #8
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,727 :: 		app_command_buf[0]  = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;RF4463PRO.c,728 :: 		app_command_buf[1]  = 0x10;    // 0x1000
ADDS	R1, R2, #1
MOVS	R0, #16
STRB	R0, [R1, #0]
;RF4463PRO.c,729 :: 		app_command_buf[2]  = 0x09;    // ¹² 9¸ö²ÎÊý
ADDS	R1, R2, #2
MOVS	R0, #9
STRB	R0, [R1, #0]
;RF4463PRO.c,730 :: 		app_command_buf[3]  = 0x00;   // 0x1000
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,732 :: 		if(mode == tx_test_mode)
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_SI4463_init62
;RF4463PRO.c,734 :: 		app_command_buf[4]  = 0xff;   //  ÐèÒª·¢ËÍ255¸ö×Ö½ÚµÄPreamble
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #255
STRB	R0, [R1, #0]
;RF4463PRO.c,735 :: 		}
IT	AL
BAL	L_SI4463_init63
L_SI4463_init62:
;RF4463PRO.c,738 :: 		app_command_buf[4]  = 0x08;   //  ÐèÒª·¢ËÍ8¸ö×Ö½ÚµÄPreamble
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #8
STRB	R0, [R1, #0]
;RF4463PRO.c,739 :: 		}
L_SI4463_init63:
;RF4463PRO.c,742 :: 		app_command_buf[5]   = 0x14;   //Òª¼ì²â20 bit Í¬²½×Ö£¬
ADD	R2, SP, #4
ADDS	R1, R2, #5
MOVS	R0, #20
STRB	R0, [R1, #0]
;RF4463PRO.c,743 :: 		app_command_buf[6]   = 0x00;   // ·Ç±ê×¼µÄpreamble Éè¶¨£¬Ã»ÓÐÓÃ
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,744 :: 		app_command_buf[7]   = 0x0f;   // Ç°µ¼ÂëTimeoutµÄÊ±¼ä   ????????????????????????????????????????????????????????????
ADDS	R1, R2, #7
MOVS	R0, #15
STRB	R0, [R1, #0]
;RF4463PRO.c,745 :: 		app_command_buf[8]   = 0x31;  // Ç°µ¼ÂëµÄ³¤¶ÈÒÔ byte ¼ÆËã£¬ 1st = 1£¬Ã»ÓÐmanchest  ±àÂë£¬Ê¹ÓÃ±ê×¼µÄ 1010.¡£¡£
ADDW	R1, R2, #8
MOVS	R0, #49
STRB	R0, [R1, #0]
;RF4463PRO.c,746 :: 		app_command_buf[9]   = 0x0;     //  ·Ç±ê×¼µÄPreambleµÄ Patten 4th byte
ADDW	R1, R2, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,747 :: 		app_command_buf[10]  = 0x00;   //  ·Ç±ê×¼µÄPreambleµÄ Patten 3rd byte
ADDW	R1, R2, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,748 :: 		app_command_buf[11]  = 0x00;  //  ·Ç±ê×¼µÄPreambleµÄ Patten 2nd byte
ADDW	R1, R2, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,749 :: 		app_command_buf[12]  = 0x00;  //  ·Ç±ê×¼µÄPreambleµÄ Patten 1st byte
ADDW	R1, R2, #12
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,750 :: 		vRf4463SPIWriteBuffer(13, app_command_buf);  //
MOV	R1, R2
MOVS	R0, #13
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,751 :: 		vBufferSetToZero( app_command_buf, 20 );
ADD	R0, SP, #4
MOVS	R1, #20
BL	_vBufferSetToZero+0
;RF4463PRO.c,754 :: 		app_command_buf[0]  = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;RF4463PRO.c,755 :: 		app_command_buf[1]  = 0x11;    // command = 0x1100
ADDS	R1, R2, #1
MOVS	R0, #17
STRB	R0, [R1, #0]
;RF4463PRO.c,756 :: 		app_command_buf[2]  = 0x05;    // ¹² 5¸ö²ÎÊý
ADDS	R1, R2, #2
MOVS	R0, #5
STRB	R0, [R1, #0]
;RF4463PRO.c,757 :: 		app_command_buf[3]  = 0x00;   // command = 0x1100
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,758 :: 		app_command_buf[4]  = 0x01;   //  Í¬²½×ÖÔÚ length field ¶¨Òå²¢·¢ËÍ£¬Í¬²½×Ö²»ÄÜÓÐ´í£¬²»ÊÇ 4FSK£¬ ²»ÊÇmanchest ±àÂë£¬Ö»ÓÐ 2¸ö×Ö½Ú
ADDS	R1, R2, #4
MOVS	R0, #1
STRB	R0, [R1, #0]
;RF4463PRO.c,760 :: 		if(mode == tx_test_mode)
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_SI4463_init64
;RF4463PRO.c,762 :: 		app_command_buf[5]  = 0x55;   //Í¬²½×Ö 3
ADD	R2, SP, #4
ADDS	R1, R2, #5
MOVS	R0, #85
STRB	R0, [R1, #0]
;RF4463PRO.c,763 :: 		app_command_buf[6]  = 0x55;   // Í¬²½×Ö2
ADDS	R1, R2, #6
MOVS	R0, #85
STRB	R0, [R1, #0]
;RF4463PRO.c,764 :: 		}
IT	AL
BAL	L_SI4463_init65
L_SI4463_init64:
;RF4463PRO.c,767 :: 		app_command_buf[5]  = 0x2d;   //Í¬²½×Ö 3
ADD	R2, SP, #4
ADDS	R1, R2, #5
MOVS	R0, #45
STRB	R0, [R1, #0]
;RF4463PRO.c,768 :: 		app_command_buf[6]  = 0xd4;   // Í¬²½×Ö2
ADDS	R1, R2, #6
MOVS	R0, #212
STRB	R0, [R1, #0]
;RF4463PRO.c,769 :: 		}
L_SI4463_init65:
;RF4463PRO.c,771 :: 		app_command_buf[7]  = 0x00;   // Í¬²½×Ö1
ADD	R2, SP, #4
ADDS	R1, R2, #7
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,772 :: 		app_command_buf[8]  = 0x00;  // Í¬²½×Ö 0
ADDW	R1, R2, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,773 :: 		vRf4463SPIWriteBuffer(9, app_command_buf);  //
MOV	R1, R2
MOVS	R0, #9
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,774 :: 		vBufferSetToZero( app_command_buf, 20 );
ADD	R0, SP, #4
MOVS	R1, #20
BL	_vBufferSetToZero+0
;RF4463PRO.c,777 :: 		app_command_buf[0]  = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;RF4463PRO.c,778 :: 		app_command_buf[1]  = 0x12;    // command = 0x1200
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;RF4463PRO.c,779 :: 		app_command_buf[2]  = 0x01;    // ¹² 1¸ö²ÎÊý
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;RF4463PRO.c,780 :: 		app_command_buf[3]  = 0x00;   // command = 0x1200
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,781 :: 		app_command_buf[4]  = 0x81; //   1ÊÇcRC ÖÖ×Ó£¬CRC = itu-c, enable crc
ADDS	R1, R2, #4
MOVS	R0, #129
STRB	R0, [R1, #0]
;RF4463PRO.c,782 :: 		vRf4463SPIWriteBuffer(5, app_command_buf);
MOV	R1, R2
MOVS	R0, #5
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,783 :: 		vBufferSetToZero( app_command_buf, 20 );
ADD	R0, SP, #4
MOVS	R1, #20
BL	_vBufferSetToZero+0
;RF4463PRO.c,786 :: 		app_command_buf[0]  = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;RF4463PRO.c,787 :: 		app_command_buf[1]  = 0x12;    // command = 0x1206
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;RF4463PRO.c,788 :: 		app_command_buf[2]  = 0x01;    // ¹² 1¸ö²ÎÊý
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;RF4463PRO.c,789 :: 		app_command_buf[3]  = 0x06;   // command = 0x1206
ADDS	R1, R2, #3
MOVS	R0, #6
STRB	R0, [R1, #0]
;RF4463PRO.c,790 :: 		app_command_buf[4]  = 0x02;   //  tx = rx = 120d--1220 (tx packet£¬ph enable, not 4fsk, ÊÕµ½Ò»°üÊý¾Ýºó£¬RX off,CRC ²»·­×ª £¬CRC MSB£¬ data MSB
ADDS	R1, R2, #4
MOVS	R0, #2
STRB	R0, [R1, #0]
;RF4463PRO.c,791 :: 		vRf4463SPIWriteBuffer(5, app_command_buf);
MOV	R1, R2
MOVS	R0, #5
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,792 :: 		vBufferSetToZero( app_command_buf, 20 );
ADD	R0, SP, #4
MOVS	R1, #20
BL	_vBufferSetToZero+0
;RF4463PRO.c,795 :: 		app_command_buf[0]  = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;RF4463PRO.c,796 :: 		app_command_buf[1]  = 0x12;    // command = 0x1208
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;RF4463PRO.c,797 :: 		app_command_buf[2]  = 0x03;    // ¹² 3¸ö²ÎÊý
ADDS	R1, R2, #2
MOVS	R0, #3
STRB	R0, [R1, #0]
;RF4463PRO.c,798 :: 		app_command_buf[3]  = 0x08;   // command = 0x1208
ADDS	R1, R2, #3
MOVS	R0, #8
STRB	R0, [R1, #0]
;RF4463PRO.c,799 :: 		app_command_buf[4]  = 0x00;   //  Length Field = LSB,  length Ö»ÓÐ1¸ö×Ö½Ú£¬length ²»·ÅÔÚ FiFoÀïÃæ£¬¹Ì¶¨°ü³¤Ä£Ê½
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,800 :: 		app_command_buf[5]  = 0x00;   //ÓÃÓÚ¿É±ä°ü³¤Ä£Ê½£¬¶¨ÒåÄÄ¸ö Field °üº¬ÁË length Filed
ADDS	R1, R2, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,801 :: 		app_command_buf[6]  = 0x00;   // ÓÃÓÚ¿É±ä°ü³¤Ä£Ê½£¬µ÷Õû¿É±ä°ü³¤µÄ length
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,802 :: 		vRf4463SPIWriteBuffer(7, app_command_buf);
MOV	R1, R2
MOVS	R0, #7
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,803 :: 		vBufferSetToZero( app_command_buf, 20 );
ADD	R0, SP, #4
MOVS	R1, #20
BL	_vBufferSetToZero+0
;RF4463PRO.c,806 :: 		app_command_buf[0]   = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;RF4463PRO.c,807 :: 		app_command_buf[1]   = 0x12;    // 0x120d
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;RF4463PRO.c,808 :: 		app_command_buf[2]   = 0x0c;    // ¹² 12¸ö²ÎÊý
ADDS	R1, R2, #2
MOVS	R0, #12
STRB	R0, [R1, #0]
;RF4463PRO.c,809 :: 		app_command_buf[3]   = 0x0d;   // 0x120d
ADDS	R1, R2, #3
MOVS	R0, #13
STRB	R0, [R1, #0]
;RF4463PRO.c,810 :: 		app_command_buf[4]   = 0x00;   //  Field 1 µÄ³¤¶È £¨¸ß4Î»£©
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,811 :: 		app_command_buf[5]   = payload_length;   //  field 1 µÄ³¤¶È£¬ £¨µÍ 8Î»), ×Ü¹²14¸ö×Ö½Ú
ADDS	R1, R2, #5
MOVS	R0, #14
STRB	R0, [R1, #0]
;RF4463PRO.c,812 :: 		app_command_buf[6]   = 0x04;   // field 1 ²»ÊÇ 4FSK£¬manchest, whiting, PN9,
ADDS	R1, R2, #6
MOVS	R0, #4
STRB	R0, [R1, #0]
;RF4463PRO.c,813 :: 		app_command_buf[7]   = 0xaa;   // field 1 crc enble, check enbale, ·¢ÉäÒ²ÓÐCRC£¬cRCµÄSeed ºÍCRC_seedÀïÃæµÄÒ»Ñù
ADDS	R1, R2, #7
MOVS	R0, #170
STRB	R0, [R1, #0]
;RF4463PRO.c,814 :: 		app_command_buf[8]   = 0x00;  //  field2 µÄ³¤¶È£¨¸ß4Î»£©
ADDW	R1, R2, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,815 :: 		app_command_buf[9]   = 0x00;    //  field 2 µÄ³¤¶È£¬ £¨µÍ 8Î»)£¬ ³¤¶È = 0 ±íÊ¾Õâ¸öfield Ã»ÓÐÊ¹ÓÃ
ADDW	R1, R2, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,816 :: 		app_command_buf[10]  = 0x00;   // field 2 ²»ÊÇ 4FSK£¬manchest, whiting, PN9
ADDW	R1, R2, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,817 :: 		app_command_buf[11]  = 0x00;  //  field 2 µÄCRCÉèÖÃ
ADDW	R1, R2, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,818 :: 		app_command_buf[12]  = 0x00;  //  field 3 µÄ³¤¶È£¬ £¨µÍ 8Î»)£¬ ³¤¶È = 0 ±íÊ¾Õâ¸öfield Ã»ÓÐÊ¹ÓÃ
ADDW	R1, R2, #12
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,819 :: 		app_command_buf[13]  = 0x00;    //  field 3 µÄ³¤¶È£¬ £¨µÍ 8Î»)£¬ ³¤¶È = 0 ±íÊ¾Õâ¸öfield Ã»ÓÐÊ¹ÓÃ
ADDW	R1, R2, #13
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,820 :: 		app_command_buf[14]  = 0x00;   //  field 3 ²»ÊÇ 4FSK£¬manchest, whiting, PN9
ADDW	R1, R2, #14
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,821 :: 		app_command_buf[15]  = 0x00;  //  field 3 µÄCRCÉèÖÃ
ADDW	R1, R2, #15
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,822 :: 		vRf4463SPIWriteBuffer(16, app_command_buf);  //
MOV	R1, R2
MOVS	R0, #16
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,823 :: 		vBufferSetToZero( app_command_buf, 20 );
ADD	R0, SP, #4
MOVS	R1, #20
BL	_vBufferSetToZero+0
;RF4463PRO.c,826 :: 		app_command_buf[0]   = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;RF4463PRO.c,827 :: 		app_command_buf[1]   = 0x12;    // 0x1219
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;RF4463PRO.c,828 :: 		app_command_buf[2]   = 0x08;    // ¹² 8¸ö²ÎÊý
ADDS	R1, R2, #2
MOVS	R0, #8
STRB	R0, [R1, #0]
;RF4463PRO.c,829 :: 		app_command_buf[3]   = 0x19;   // 0x1219
ADDS	R1, R2, #3
MOVS	R0, #25
STRB	R0, [R1, #0]
;RF4463PRO.c,830 :: 		app_command_buf[4]   = 0x00;   //  field4 µÄ³¤¶È£¨¸ß4Î»£©
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,831 :: 		app_command_buf[5]   = 0x00;   //  field 4 µÄ³¤¶È£¬ £¨µÍ 8Î»)£¬ ³¤¶È = 0 ±íÊ¾Õâ¸öfield Ã»ÓÐÊ¹ÓÃ
ADDS	R1, R2, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,832 :: 		app_command_buf[6]   = 0x00;   //   field 4 ²»ÊÇ 4FSK£¬manchest, whiting, PN9
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,833 :: 		app_command_buf[7]   = 0x00;   // field 4 µÄCRCÉèÖÃ
ADDS	R1, R2, #7
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,834 :: 		app_command_buf[8]   = 0x00;  //  field5 µÄ³¤¶È£¨¸ß4Î»£©
ADDW	R1, R2, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,835 :: 		app_command_buf[9]   = 0x00;    //   field 5 µÄ³¤¶È£¬ £¨µÍ 8Î»)£¬ ³¤¶È = 0 ±íÊ¾Õâ¸öfield Ã»ÓÐÊ¹ÓÃ
ADDW	R1, R2, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,836 :: 		app_command_buf[10]  = 0x00;   //  field 5 ²»ÊÇ 4FSK£¬manchest, whiting, PN9
ADDW	R1, R2, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,837 :: 		app_command_buf[11]  = 0x00;   // field 5 µÄCRCÉèÖÃ
ADDW	R1, R2, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,838 :: 		vRf4463SPIWriteBuffer(12, app_command_buf);  //
MOV	R1, R2
MOVS	R0, #12
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,839 :: 		vBufferSetToZero( app_command_buf, 20 );
ADD	R0, SP, #4
MOVS	R1, #20
BL	_vBufferSetToZero+0
;RF4463PRO.c,842 :: 		vRf4463SPIWriteBuffer(0x10, RF_MODEM_MOD_TYPE_12_data);   // //  2FSK ,  module source = PH fifo, disable manchest, tx, rx ²»·­×ª£¬ deviation ²»·­×ª
MOVW	R1, #lo_addr(_RF_MODEM_MOD_TYPE_12_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_MOD_TYPE_12_data+0)
MOVS	R0, #16
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,845 :: 		app_command_buf[0] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;RF4463PRO.c,846 :: 		app_command_buf[1]  = 0x20;    // 0x200c
ADDS	R1, R2, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;RF4463PRO.c,847 :: 		app_command_buf[2]  = 0x01;    // ¹² 1¸ö²ÎÊý
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;RF4463PRO.c,848 :: 		app_command_buf[3]  = 0x0c;   // 0x200c
ADDS	R1, R2, #3
MOVS	R0, #12
STRB	R0, [R1, #0]
;RF4463PRO.c,850 :: 		if(freq3<8)
MOVW	R0, #lo_addr(_freq3+0)
MOVT	R0, #hi_addr(_freq3+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CS
BCS	L_SI4463_init66
;RF4463PRO.c,852 :: 		if(rate>=dr_256k)
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CC
BCC	L_SI4463_init67
;RF4463PRO.c,853 :: 		app_command_buf[4]  = 0x4f;
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #79
STRB	R0, [R1, #0]
IT	AL
BAL	L_SI4463_init68
L_SI4463_init67:
;RF4463PRO.c,854 :: 		else if(rate>=dr_19p2)
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	CC
BCC	L_SI4463_init69
;RF4463PRO.c,855 :: 		app_command_buf[4]  = 0x5e;
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #94
STRB	R0, [R1, #0]
IT	AL
BAL	L_SI4463_init70
L_SI4463_init69:
;RF4463PRO.c,857 :: 		app_command_buf[4]  = 0xd2;
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #210
STRB	R0, [R1, #0]
L_SI4463_init70:
L_SI4463_init68:
;RF4463PRO.c,858 :: 		}
IT	AL
BAL	L_SI4463_init71
L_SI4463_init66:
;RF4463PRO.c,861 :: 		if(rate>=dr_115p2)
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	CC
BCC	L_SI4463_init72
;RF4463PRO.c,862 :: 		app_command_buf[4]  = 0x69;     // 15k
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #105
STRB	R0, [R1, #0]
IT	AL
BAL	L_SI4463_init73
L_SI4463_init72:
;RF4463PRO.c,863 :: 		else if(rate>=dr_19p2)
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	CC
BCC	L_SI4463_init74
;RF4463PRO.c,864 :: 		app_command_buf[4]  = 0x5e;     // 10k
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #94
STRB	R0, [R1, #0]
IT	AL
BAL	L_SI4463_init75
L_SI4463_init74:
;RF4463PRO.c,866 :: 		app_command_buf[4]  = 0x18; // 8k
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #24
STRB	R0, [R1, #0]
L_SI4463_init75:
L_SI4463_init73:
;RF4463PRO.c,867 :: 		}
L_SI4463_init71:
;RF4463PRO.c,868 :: 		vRf4463SPIWriteBuffer(5, app_command_buf);
ADD	R0, SP, #4
MOV	R1, R0
MOVS	R0, #5
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,869 :: 		vBufferSetToZero( app_command_buf, 20 );
ADD	R0, SP, #4
MOVS	R1, #20
BL	_vBufferSetToZero+0
;RF4463PRO.c,872 :: 		vRf4463SPIWriteBuffer(0x0C, RF_MODEM_TX_RAMP_DELAY_8_data);     // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
MOVW	R1, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
MOVS	R0, #12
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,873 :: 		vRf4463SPIWriteBuffer(0x0D, RF_MODEM_BCR_OSR_1_9_data);                 // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
MOVW	R1, #lo_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
MOVS	R0, #13
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,874 :: 		vRf4463SPIWriteBuffer(0x0B, RF_MODEM_AFC_GEAR_7_data);                  // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
MOVW	R1, #lo_addr(_RF_MODEM_AFC_GEAR_7_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_AFC_GEAR_7_data+0)
MOVS	R0, #11
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,875 :: 		vRf4463SPIWriteBuffer(0x05, RF_MODEM_AGC_CONTROL_1_data);               // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
MOVW	R1, #lo_addr(_RF_MODEM_AGC_CONTROL_1_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_AGC_CONTROL_1_data+0)
MOVS	R0, #5
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,876 :: 		vRf4463SPIWriteBuffer(0x0D, RF_MODEM_AGC_WINDOW_SIZE_9_data);   // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
MOVW	R1, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
MOVS	R0, #13
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,877 :: 		vRf4463SPIWriteBuffer(0x0F, RF_MODEM_OOK_CNT1_11_data);                 // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
MOVW	R1, #lo_addr(_RF_MODEM_OOK_CNT1_11_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_OOK_CNT1_11_data+0)
MOVS	R0, #15
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,880 :: 		app_command_buf[0] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;RF4463PRO.c,881 :: 		app_command_buf[1] = 0x20;    // 0x204e
ADDS	R1, R2, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;RF4463PRO.c,882 :: 		app_command_buf[2] = 0x01;    // ¹² 1¸ö²ÎÊý
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;RF4463PRO.c,883 :: 		app_command_buf[3] = 0x4e;   // 0x204e
ADDS	R1, R2, #3
MOVS	R0, #78
STRB	R0, [R1, #0]
;RF4463PRO.c,884 :: 		if(rate==dr_500)
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	NE
BNE	L_SI4463_init76
;RF4463PRO.c,885 :: 		app_command_buf[4]  = 0x3a;
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #58
STRB	R0, [R1, #0]
IT	AL
BAL	L_SI4463_init77
L_SI4463_init76:
;RF4463PRO.c,887 :: 		app_command_buf[4]  = 0x40;  //  rssi ¶ÁÊýÆ«²î£¬ÓëÕæÊµÖµµÄ²îÖµ
ADD	R0, SP, #4
ADDS	R1, R0, #4
MOVS	R0, #64
STRB	R0, [R1, #0]
L_SI4463_init77:
;RF4463PRO.c,888 :: 		vRf4463SPIWriteBuffer(5, app_command_buf);
ADD	R0, SP, #4
MOV	R1, R0
MOVS	R0, #5
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,889 :: 		vBufferSetToZero( app_command_buf, 20 );
ADD	R0, SP, #4
MOVS	R1, #20
BL	_vBufferSetToZero+0
;RF4463PRO.c,892 :: 		vRf4463SPIWriteBuffer(0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data);  // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
MOVW	R1, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVS	R0, #16
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,893 :: 		vRf4463SPIWriteBuffer(0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data);   // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
MOVW	R1, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVS	R0, #16
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,894 :: 		vRf4463SPIWriteBuffer(0x10, RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data);   // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
MOVW	R1, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVS	R0, #16
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,897 :: 		app_command_buf[0] = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;RF4463PRO.c,898 :: 		app_command_buf[1]  = 0x22;    // 0x2200
ADDS	R1, R2, #1
MOVS	R0, #34
STRB	R0, [R1, #0]
;RF4463PRO.c,899 :: 		app_command_buf[2]  = 0x04;    // ¹² 4¸ö²ÎÊý
ADDS	R1, R2, #2
MOVS	R0, #4
STRB	R0, [R1, #0]
;RF4463PRO.c,900 :: 		app_command_buf[3]  = 0x00;   // 0x2200
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,901 :: 		app_command_buf[4]  = 0x08;  //0x10;   //   PA mode  = default , Ê¹ÓÃClass E Ä£Ê½£¬¶ø²»ÊÇ Switch Current Ä£Ê½  ????????
ADDS	R1, R2, #4
MOVS	R0, #8
STRB	R0, [R1, #0]
;RF4463PRO.c,902 :: 		if(power==7)
MOVW	R0, #lo_addr(_power+0)
MOVT	R0, #hi_addr(_power+0)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	NE
BNE	L_SI4463_init78
;RF4463PRO.c,903 :: 		app_command_buf[5]  = 127;   //  ÉèÖÃÎª×î´ó¹¦ÂÊ
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #127
STRB	R0, [R1, #0]
IT	AL
BAL	L_SI4463_init79
L_SI4463_init78:
;RF4463PRO.c,904 :: 		else if(power==6)
MOVW	R0, #lo_addr(_power+0)
MOVT	R0, #hi_addr(_power+0)
LDRB	R0, [R0, #0]
CMP	R0, #6
IT	NE
BNE	L_SI4463_init80
;RF4463PRO.c,905 :: 		app_command_buf[5]  = 50;
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #50
STRB	R0, [R1, #0]
IT	AL
BAL	L_SI4463_init81
L_SI4463_init80:
;RF4463PRO.c,906 :: 		else if(power==5)
MOVW	R0, #lo_addr(_power+0)
MOVT	R0, #hi_addr(_power+0)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_SI4463_init82
;RF4463PRO.c,907 :: 		app_command_buf[5]  = 30;
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #30
STRB	R0, [R1, #0]
IT	AL
BAL	L_SI4463_init83
L_SI4463_init82:
;RF4463PRO.c,908 :: 		else if(power==4)
MOVW	R0, #lo_addr(_power+0)
MOVT	R0, #hi_addr(_power+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_SI4463_init84
;RF4463PRO.c,909 :: 		app_command_buf[5]  = 20;
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #20
STRB	R0, [R1, #0]
IT	AL
BAL	L_SI4463_init85
L_SI4463_init84:
;RF4463PRO.c,910 :: 		else if(power==3)
MOVW	R0, #lo_addr(_power+0)
MOVT	R0, #hi_addr(_power+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BNE	L_SI4463_init86
;RF4463PRO.c,911 :: 		app_command_buf[5]  = 15;
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #15
STRB	R0, [R1, #0]
IT	AL
BAL	L_SI4463_init87
L_SI4463_init86:
;RF4463PRO.c,912 :: 		else if(power==2)
MOVW	R0, #lo_addr(_power+0)
MOVT	R0, #hi_addr(_power+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_SI4463_init88
;RF4463PRO.c,913 :: 		app_command_buf[5]  = 10;
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #10
STRB	R0, [R1, #0]
IT	AL
BAL	L_SI4463_init89
L_SI4463_init88:
;RF4463PRO.c,914 :: 		else if(power==1)
MOVW	R0, #lo_addr(_power+0)
MOVT	R0, #hi_addr(_power+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_SI4463_init90
;RF4463PRO.c,915 :: 		app_command_buf[5]  = 7;
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #7
STRB	R0, [R1, #0]
IT	AL
BAL	L_SI4463_init91
L_SI4463_init90:
;RF4463PRO.c,917 :: 		app_command_buf[5]  = 4;
ADD	R0, SP, #4
ADDS	R1, R0, #5
MOVS	R0, #4
STRB	R0, [R1, #0]
L_SI4463_init91:
L_SI4463_init89:
L_SI4463_init87:
L_SI4463_init85:
L_SI4463_init83:
L_SI4463_init81:
L_SI4463_init79:
;RF4463PRO.c,918 :: 		app_command_buf[6]  =0x00; //???????? 0x00;   // CLK duty = 50%£¬ ÆäËû = Default
ADD	R0, SP, #4
ADDS	R1, R0, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,919 :: 		if((rate<=dr_115p2)||(rate==dr_500))
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	LS
BLS	L__SI4463_init135
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	EQ
BEQ	L__SI4463_init134
IT	AL
BAL	L_SI4463_init94
L__SI4463_init135:
L__SI4463_init134:
;RF4463PRO.c,920 :: 		app_command_buf[7]  = 0x3d;  // ???????? 0x5d;   // PA ramp time = default
ADD	R0, SP, #4
ADDS	R1, R0, #7
MOVS	R0, #61
STRB	R0, [R1, #0]
IT	AL
BAL	L_SI4463_init95
L_SI4463_init94:
;RF4463PRO.c,922 :: 		app_command_buf[7]  = 0x5d;
ADD	R0, SP, #4
ADDS	R1, R0, #7
MOVS	R0, #93
STRB	R0, [R1, #0]
L_SI4463_init95:
;RF4463PRO.c,923 :: 		vRf4463SPIWriteBuffer(8, app_command_buf);
ADD	R0, SP, #4
MOV	R1, R0
MOVS	R0, #8
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,924 :: 		vBufferSetToZero( app_command_buf, 20 );
ADD	R0, SP, #4
MOVS	R1, #20
BL	_vBufferSetToZero+0
;RF4463PRO.c,927 :: 		vRf4463SPIWriteBuffer(0x0B, RF_SYNTH_PFDCP_CPFF_7_data);      // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
MOVW	R1, #lo_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
MOVT	R1, #hi_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
MOVS	R0, #11
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,930 :: 		app_command_buf[0]   = 0x11;
ADD	R2, SP, #4
MOVS	R0, #17
STRB	R0, [R2, #0]
;RF4463PRO.c,931 :: 		app_command_buf[1]   = 0x30;    // 0x3000
ADDS	R1, R2, #1
MOVS	R0, #48
STRB	R0, [R1, #0]
;RF4463PRO.c,932 :: 		app_command_buf[2]   = 0x0c;    // ¹² 12¸ö²ÎÊý
ADDS	R1, R2, #2
MOVS	R0, #12
STRB	R0, [R1, #0]
;RF4463PRO.c,933 :: 		app_command_buf[3]   = 0x00;   // 0x3000
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,934 :: 		app_command_buf[4]   = 's';    //0x00;   //  match 1 µÄÖµ
ADDS	R1, R2, #4
MOVS	R0, #115
STRB	R0, [R1, #0]
;RF4463PRO.c,935 :: 		app_command_buf[5]   = 0xff;   //  match 1 mask
ADDS	R1, R2, #5
MOVS	R0, #255
STRB	R0, [R1, #0]
;RF4463PRO.c,936 :: 		app_command_buf[6]   = 0x40;   // eable match 1, match 1µÄÖµÓëÍ¬²½×ÖµÄÏà¾àµÄ¾àÀë, 0 = match
ADDS	R1, R2, #6
MOVS	R0, #64
STRB	R0, [R1, #0]
;RF4463PRO.c,937 :: 		app_command_buf[7]   = 'w';    //  match 2 µÄÖµ
ADDS	R1, R2, #7
MOVS	R0, #119
STRB	R0, [R1, #0]
;RF4463PRO.c,938 :: 		app_command_buf[8]   = 0xff;   //  match 2 mask
ADDW	R1, R2, #8
MOVS	R0, #255
STRB	R0, [R1, #0]
;RF4463PRO.c,939 :: 		app_command_buf[9]   = 0x01;   // enable match 2, match 2µÄÖµÓëÍ¬²½×ÖµÄÏà¾àµÄ¾àÀë  , and function
ADDW	R1, R2, #9
MOVS	R0, #1
STRB	R0, [R1, #0]
;RF4463PRO.c,940 :: 		app_command_buf[10]  = 'w';   //     match 3 µÄÖµ
ADDW	R1, R2, #10
MOVS	R0, #119
STRB	R0, [R1, #0]
;RF4463PRO.c,941 :: 		app_command_buf[11]  = 0xff;    //  match 3 mask
ADDW	R1, R2, #11
MOVS	R0, #255
STRB	R0, [R1, #0]
;RF4463PRO.c,942 :: 		app_command_buf[12]  = 0x02;    // enable match 3, match 3µÄÖµÓëÍ¬²½×ÖµÄÏà¾àµÄ¾àÀë    and function
ADDW	R1, R2, #12
MOVS	R0, #2
STRB	R0, [R1, #0]
;RF4463PRO.c,943 :: 		app_command_buf[13]  = 'x';    //   match 4 µÄÖµ
ADDW	R1, R2, #13
MOVS	R0, #120
STRB	R0, [R1, #0]
;RF4463PRO.c,944 :: 		app_command_buf[14]  = 0xff;   //   match 4 mask
ADDW	R1, R2, #14
MOVS	R0, #255
STRB	R0, [R1, #0]
;RF4463PRO.c,945 :: 		app_command_buf[15]  = 0x03;   //  enable match 4, match 4µÄÖµÓëÍ¬²½×ÖµÄÏà¾àµÄ¾àÀë    and function
ADDW	R1, R2, #15
MOVS	R0, #3
STRB	R0, [R1, #0]
;RF4463PRO.c,946 :: 		vRf4463SPIWriteBuffer(16, app_command_buf);
MOV	R1, R2
MOVS	R0, #16
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,947 :: 		vBufferSetToZero( app_command_buf, 20 );
ADD	R0, SP, #4
MOVS	R1, #20
BL	_vBufferSetToZero+0
;RF4463PRO.c,949 :: 		rf_init_freq();
BL	_rf_init_freq+0
;RF4463PRO.c,952 :: 		}
L_end_SI4463_init:
LDR	LR, [SP, #0]
ADD	SP, SP, #44
BX	LR
; end of _SI4463_init
_rf_init_freq:
;RF4463PRO.c,954 :: 		void rf_init_freq(void)
SUB	SP, SP, #28
STR	LR, [SP, #0]
;RF4463PRO.c,963 :: 		frequency = (freq3 * 100) + (freq2 * 10) + freq1;
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
;RF4463PRO.c,964 :: 		frequency = (frequency * 10000) + 5000;
MOVW	R0, #10000
MUL	R1, R2, R0
; frequency end address is: 8 (R2)
MOVW	R0, #5000
ADDS	R1, R1, R0
; frequency start address is: 8 (R2)
MOV	R2, R1
;RF4463PRO.c,966 :: 		if(frequency>=7600000)                                  // 760~1050
MOVW	R0, #63360
MOVT	R0, #115
CMP	R1, R0
IT	CC
BCC	L_rf_init_freq96
;RF4463PRO.c,968 :: 		OUTDIV = 4;
MOVS	R0, #4
STRB	R0, [SP, #4]
;RF4463PRO.c,969 :: 		BAND = 0;
MOVS	R0, #0
STRB	R0, [SP, #6]
;RF4463PRO.c,970 :: 		VCO = 0xff;
MOVS	R0, #255
STRB	R0, [SP, #5]
;RF4463PRO.c,971 :: 		}
IT	AL
BAL	L_rf_init_freq97
L_rf_init_freq96:
;RF4463PRO.c,972 :: 		else if(frequency>=5460000)                             // 546~759.9
MOVW	R0, #20512
MOVT	R0, #83
CMP	R2, R0
IT	CC
BCC	L_rf_init_freq98
;RF4463PRO.c,974 :: 		OUTDIV = 6;
MOVS	R0, #6
STRB	R0, [SP, #4]
;RF4463PRO.c,975 :: 		BAND = 1;
MOVS	R0, #1
STRB	R0, [SP, #6]
;RF4463PRO.c,976 :: 		VCO = 0xfe;
MOVS	R0, #254
STRB	R0, [SP, #5]
;RF4463PRO.c,977 :: 		}
IT	AL
BAL	L_rf_init_freq99
L_rf_init_freq98:
;RF4463PRO.c,978 :: 		else if(frequency>=3850000)                             // 385~545.9
MOVW	R0, #48912
MOVT	R0, #58
CMP	R2, R0
IT	CC
BCC	L_rf_init_freq100
;RF4463PRO.c,980 :: 		OUTDIV = 8;
MOVS	R0, #8
STRB	R0, [SP, #4]
;RF4463PRO.c,981 :: 		BAND = 2;
MOVS	R0, #2
STRB	R0, [SP, #6]
;RF4463PRO.c,982 :: 		VCO = 0xfe;
MOVS	R0, #254
STRB	R0, [SP, #5]
;RF4463PRO.c,983 :: 		}
IT	AL
BAL	L_rf_init_freq101
L_rf_init_freq100:
;RF4463PRO.c,984 :: 		else if(frequency>=2730000)                             // 273~384.9
MOVW	R0, #43024
MOVT	R0, #41
CMP	R2, R0
IT	CC
BCC	L_rf_init_freq102
;RF4463PRO.c,986 :: 		OUTDIV = 12;
MOVS	R0, #12
STRB	R0, [SP, #4]
;RF4463PRO.c,987 :: 		BAND = 3;
MOVS	R0, #3
STRB	R0, [SP, #6]
;RF4463PRO.c,988 :: 		VCO = 0xfd;
MOVS	R0, #253
STRB	R0, [SP, #5]
;RF4463PRO.c,989 :: 		}
IT	AL
BAL	L_rf_init_freq103
L_rf_init_freq102:
;RF4463PRO.c,990 :: 		else if(frequency>=1940000)                             // 194~272.9
MOVW	R0, #39456
MOVT	R0, #29
CMP	R2, R0
IT	CC
BCC	L_rf_init_freq104
;RF4463PRO.c,992 :: 		OUTDIV = 16;
MOVS	R0, #16
STRB	R0, [SP, #4]
;RF4463PRO.c,993 :: 		BAND = 4;
MOVS	R0, #4
STRB	R0, [SP, #6]
;RF4463PRO.c,994 :: 		VCO = 0xfc;
MOVS	R0, #252
STRB	R0, [SP, #5]
;RF4463PRO.c,995 :: 		}
IT	AL
BAL	L_rf_init_freq105
L_rf_init_freq104:
;RF4463PRO.c,998 :: 		OUTDIV = 24;
MOVS	R0, #24
STRB	R0, [SP, #4]
;RF4463PRO.c,999 :: 		BAND = 5;
MOVS	R0, #5
STRB	R0, [SP, #6]
;RF4463PRO.c,1000 :: 		VCO = 0xfa;
MOVS	R0, #250
STRB	R0, [SP, #5]
;RF4463PRO.c,1001 :: 		}
L_rf_init_freq105:
L_rf_init_freq103:
L_rf_init_freq101:
L_rf_init_freq99:
L_rf_init_freq97:
;RF4463PRO.c,1003 :: 		DIV = OUTDIV/2;
LDRB	R0, [SP, #4]
LSRS	R0, R0, #1
UXTB	R0, R0
;RF4463PRO.c,1005 :: 		mydata = (frequency*DIV)/3;
MUL	R1, R2, R0
; frequency end address is: 8 (R2)
MOVS	R0, #3
UDIV	R2, R1, R0
;RF4463PRO.c,1006 :: 		INTE = (mydata/100000)-1;
MOVW	R0, #34464
MOVT	R0, #1
UDIV	R0, R2, R0
SUBS	R0, R0, #1
; INTE start address is: 28 (R7)
UXTB	R7, R0
;RF4463PRO.c,1007 :: 		FRAC = (mydata-(INTE+1)*100000)*16384/3125;
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
;RF4463PRO.c,1008 :: 		FRAC = FRAC+0x80000;
ADD	R0, R0, #524288
;RF4463PRO.c,1010 :: 		FRAC_0 = FRAC;
; FRAC_0 start address is: 32 (R8)
UXTB	R8, R0
;RF4463PRO.c,1011 :: 		FRAC>>=8;
LSRS	R0, R0, #8
;RF4463PRO.c,1012 :: 		FRAC_1 = FRAC;
; FRAC_1 start address is: 36 (R9)
UXTB	R9, R0
;RF4463PRO.c,1013 :: 		FRAC>>=8;
LSRS	R0, R0, #8
;RF4463PRO.c,1014 :: 		FRAC_2 = FRAC;
; FRAC_2 start address is: 40 (R10)
UXTB	R10, R0
;RF4463PRO.c,1018 :: 		app_command_buf[0] = 0x11;
ADD	R2, SP, #7
MOVS	R0, #17
STRB	R0, [R2, #0]
;RF4463PRO.c,1019 :: 		app_command_buf[1]  = 0x20;    // 0x2051
ADDS	R1, R2, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;RF4463PRO.c,1020 :: 		app_command_buf[2]  = 0x01;    // ¹² 1¸ö²ÎÊý
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;RF4463PRO.c,1021 :: 		app_command_buf[3]  = 0x51;   // 0x2051
ADDS	R1, R2, #3
MOVS	R0, #81
STRB	R0, [R1, #0]
;RF4463PRO.c,1022 :: 		app_command_buf[4]  = 0x08|BAND;  //  high performance mode , clk outpu = osc /4
ADDS	R1, R2, #4
LDRB	R0, [SP, #6]
ORR	R0, R0, #8
STRB	R0, [R1, #0]
;RF4463PRO.c,1023 :: 		vRf4463SPIWriteBuffer(5, app_command_buf);
MOV	R1, R2
MOVS	R0, #5
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,1024 :: 		vBufferSetToZero( app_command_buf, 20 );
ADD	R0, SP, #7
MOVS	R1, #20
BL	_vBufferSetToZero+0
;RF4463PRO.c,1033 :: 		app_command_buf[0] = 0x11;
ADD	R2, SP, #7
MOVS	R0, #17
STRB	R0, [R2, #0]
;RF4463PRO.c,1034 :: 		app_command_buf[1]  = 0x40;    // 0x4000
ADDS	R1, R2, #1
MOVS	R0, #64
STRB	R0, [R1, #0]
;RF4463PRO.c,1035 :: 		app_command_buf[2]  = 0x08;    // ¹² 8¸ö²ÎÊý
ADDS	R1, R2, #2
MOVS	R0, #8
STRB	R0, [R1, #0]
;RF4463PRO.c,1036 :: 		app_command_buf[3]  = 0x00;   // 0x4000
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;RF4463PRO.c,1037 :: 		app_command_buf[4]  = INTE;   //  default value
ADDS	R0, R2, #4
STRB	R7, [R0, #0]
; INTE end address is: 28 (R7)
;RF4463PRO.c,1038 :: 		app_command_buf[5]  = FRAC_2;   //  defaul value
ADDS	R0, R2, #5
STRB	R10, [R0, #0]
; FRAC_2 end address is: 40 (R10)
;RF4463PRO.c,1039 :: 		app_command_buf[6]  = FRAC_1;   //  default value
ADDS	R0, R2, #6
STRB	R9, [R0, #0]
; FRAC_1 end address is: 36 (R9)
;RF4463PRO.c,1040 :: 		app_command_buf[7]  = FRAC_0;   // frac ,from WDS
ADDS	R0, R2, #7
STRB	R8, [R0, #0]
; FRAC_0 end address is: 32 (R8)
;RF4463PRO.c,1041 :: 		app_command_buf[8]  = step_500K_step1;   // channel step1  from wds
ADDW	R1, R2, #8
MOVS	R0, #136
STRB	R0, [R1, #0]
;RF4463PRO.c,1042 :: 		app_command_buf[9]  = step_500K_step0;   // channel step0  from wds
ADDW	R1, R2, #9
MOVS	R0, #137
STRB	R0, [R1, #0]
;RF4463PRO.c,1043 :: 		app_command_buf[10] = 0x20;  //  from wds Ã»ÓÐÕâ¸öÖµ
ADDW	R1, R2, #10
MOVS	R0, #32
STRB	R0, [R1, #0]
;RF4463PRO.c,1044 :: 		app_command_buf[11]  = VCO;    // from wds Ã»ÓÐÕâ¸öÖµ
ADDW	R1, R2, #11
LDRB	R0, [SP, #5]
STRB	R0, [R1, #0]
;RF4463PRO.c,1045 :: 		vRf4463SPIWriteBuffer(12, app_command_buf);
MOV	R1, R2
MOVS	R0, #12
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,1046 :: 		vBufferSetToZero( app_command_buf, 20 );
ADD	R0, SP, #7
MOVS	R1, #20
BL	_vBufferSetToZero+0
;RF4463PRO.c,1047 :: 		}
L_end_rf_init_freq:
LDR	LR, [SP, #0]
ADD	SP, SP, #28
BX	LR
; end of _rf_init_freq
_vRf4463SPIWriteBuffer:
;RF4463PRO.c,1049 :: 		void vRf4463SPIWriteBuffer( uint16_t usWriteLength, uint8_t * pcWriteBuffer ){
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
MOV	R6, R1
;RF4463PRO.c,1053 :: 		while( usWriteLength-- ){
L_vRf4463SPIWriteBuffer106:
; pcWriteBuffer start address is: 24 (R6)
; usWriteLength start address is: 20 (R5)
; usWriteLength start address is: 0 (R0)
UXTH	R3, R0
SUBS	R2, R0, #1
; usWriteLength end address is: 0 (R0)
; usWriteLength start address is: 20 (R5)
UXTH	R5, R2
; usWriteLength end address is: 20 (R5)
CMP	R3, #0
IT	EQ
BEQ	L_vRf4463SPIWriteBuffer107
; usWriteLength end address is: 20 (R5)
;RF4463PRO.c,1054 :: 		SPIWriteByte( *pcWriteBuffer++ );
; usWriteLength start address is: 20 (R5)
LDRB	R2, [R6, #0]
UXTH	R0, R2
BL	_SPIWriteByte+0
ADDS	R6, R6, #1
;RF4463PRO.c,1055 :: 		}
UXTH	R0, R5
; usWriteLength end address is: 20 (R5)
; pcWriteBuffer end address is: 24 (R6)
IT	AL
BAL	L_vRf4463SPIWriteBuffer106
L_vRf4463SPIWriteBuffer107:
;RF4463PRO.c,1056 :: 		}
L_end_vRf4463SPIWriteBuffer:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vRf4463SPIWriteBuffer
_vRf4463SPIReadBuffer:
;RF4463PRO.c,1064 :: 		void vRf4463SPIReadBuffer( uint16_t usReadLength, uint8_t * pcReadBuffer ){
; pcReadBuffer start address is: 4 (R1)
; usReadLength start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; pcReadBuffer end address is: 4 (R1)
; usReadLength end address is: 0 (R0)
; usReadLength start address is: 0 (R0)
; pcReadBuffer start address is: 4 (R1)
;RF4463PRO.c,1065 :: 		uint8_t ucRxCounter = 0;
; ucRxCounter start address is: 20 (R5)
MOVS	R5, #0
;RF4463PRO.c,1066 :: 		uint8_t display = 0;
; pcReadBuffer end address is: 4 (R1)
; usReadLength end address is: 0 (R0)
; ucRxCounter end address is: 20 (R5)
MOV	R4, R1
;RF4463PRO.c,1067 :: 		while( usReadLength-- ){
L_vRf4463SPIReadBuffer108:
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
BEQ	L_vRf4463SPIReadBuffer109
; pcReadBuffer end address is: 16 (R4)
; usReadLength end address is: 24 (R6)
;RF4463PRO.c,1068 :: 		pcReadBuffer[ ucRxCounter++ ] = SPIReadByte( 0 );
; usReadLength start address is: 24 (R6)
; pcReadBuffer start address is: 16 (R4)
ADDS	R2, R4, R5
STR	R2, [SP, #4]
MOVS	R0, #0
BL	_SPIReadByte+0
LDR	R2, [SP, #4]
STRB	R0, [R2, #0]
ADDS	R5, R5, #1
UXTB	R5, R5
;RF4463PRO.c,1069 :: 		}
UXTH	R0, R6
; pcReadBuffer end address is: 16 (R4)
; usReadLength end address is: 24 (R6)
; ucRxCounter end address is: 20 (R5)
IT	AL
BAL	L_vRf4463SPIReadBuffer108
L_vRf4463SPIReadBuffer109:
;RF4463PRO.c,1070 :: 		}
L_end_vRf4463SPIReadBuffer:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vRf4463SPIReadBuffer
_SPIReadByte:
;RF4463PRO.c,1078 :: 		unsigned char SPIReadByte(unsigned long WrPara)
; WrPara start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; WrPara end address is: 0 (R0)
; WrPara start address is: 0 (R0)
;RF4463PRO.c,1082 :: 		wAddr = WrPara >> 8 & 0xff;                               // Extraigo la Dirección de escritura de 1 Byte
LSRS	R1, R0, #8
; WrPara end address is: 0 (R0)
AND	R3, R1, #255
;RF4463PRO.c,1085 :: 		RF4463nSEL = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
_SX	[R1, ByteOffset(GPIOB_ODR+0)]
;RF4463PRO.c,1087 :: 		SPI2_Write(wAddr);
UXTH	R0, R3
BL	_SPI2_Write+0
;RF4463PRO.c,1088 :: 		temp = SPI2_Read(0);
MOVS	R0, #0
BL	_SPI2_Read+0
;RF4463PRO.c,1089 :: 		RF4463nSEL = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
_SX	[R1, ByteOffset(GPIOB_ODR+0)]
;RF4463PRO.c,1090 :: 		return temp;
UXTB	R0, R0
;RF4463PRO.c,1091 :: 		}
L_end_SPIReadByte:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _SPIReadByte
_SPIWriteByte:
;RF4463PRO.c,1097 :: 		void SPIWriteByte(unsigned int WrPara)
; WrPara start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; WrPara end address is: 0 (R0)
; WrPara start address is: 0 (R0)
;RF4463PRO.c,1100 :: 		WrPara |= 0x8000;                                          // Agrego el bit en 1 en el byte alto para escribir via SPI
ORR	R2, R0, #32768
UXTH	R2, R2
; WrPara end address is: 0 (R0)
;RF4463PRO.c,1101 :: 		wAddr = WrPara >> 8 & 0xff;                                // Extraigo la Dirección de escritura de 1 Byte
LSRS	R1, R2, #8
UXTH	R1, R1
AND	R3, R1, #255
;RF4463PRO.c,1102 :: 		wData = WrPara & 0xff;                                     // Extraigo el Valor que escribiré
AND	R1, R2, #255
; wData start address is: 16 (R4)
UXTH	R4, R1
;RF4463PRO.c,1104 :: 		RF4463nSEL = 0;                              // Selecciono el periferico para usarlo
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
_SX	[R1, ByteOffset(GPIOB_ODR+0)]
;RF4463PRO.c,1105 :: 		SPI2_Write(wAddr);                                    // Escibo la dirección donde quiero afectar el registro
UXTH	R0, R3
BL	_SPI2_Write+0
;RF4463PRO.c,1106 :: 		SPI2_Write(wData);                                    // Escribo el dato en la direccion que seleccione
UXTH	R0, R4
; wData end address is: 16 (R4)
BL	_SPI2_Write+0
;RF4463PRO.c,1107 :: 		RF4463nSEL = 1;                              // Deselecciono el periferico
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
_SX	[R1, ByteOffset(GPIOB_ODR+0)]
;RF4463PRO.c,1112 :: 		}
L_end_SPIWriteByte:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _SPIWriteByte
_ucRf4463CheckCTS:
;RF4463PRO.c,1122 :: 		uint8_t ucRf4463CheckCTS(){
SUB	SP, SP, #28
STR	LR, [SP, #0]
;RF4463PRO.c,1123 :: 		uint16_t usTimeoutCounter = 0;
;RF4463PRO.c,1125 :: 		usTimeoutCounter = RF4463_CTS_TIMEOUT;
; usTimeoutCounter start address is: 8 (R2)
MOVW	R2, #2500
; usTimeoutCounter end address is: 8 (R2)
;RF4463PRO.c,1128 :: 		while( usTimeoutCounter-- ){
L_ucRf4463CheckCTS110:
; usTimeoutCounter start address is: 20 (R5)
; usTimeoutCounter start address is: 8 (R2)
UXTH	R1, R2
SUBS	R0, R2, #1
; usTimeoutCounter end address is: 8 (R2)
; usTimeoutCounter start address is: 20 (R5)
UXTH	R5, R0
; usTimeoutCounter end address is: 20 (R5)
CMP	R1, #0
IT	EQ
BEQ	L_ucRf4463CheckCTS111
; usTimeoutCounter end address is: 20 (R5)
;RF4463PRO.c,1129 :: 		RF4463nSEL = 0x00;
; usTimeoutCounter start address is: 20 (R5)
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;RF4463PRO.c,1130 :: 		SPIWriteByte( READ_CMD_BUFF );
MOVS	R0, #68
BL	_SPIWriteByte+0
;RF4463PRO.c,1135 :: 		if( SPIReadByte( READ_CMD_BUFF ) == RF4463_CTS_REPLY )
MOVS	R0, #68
BL	_SPIReadByte+0
CMP	R0, #255
IT	NE
BNE	L_ucRf4463CheckCTS112
; usTimeoutCounter end address is: 20 (R5)
;RF4463PRO.c,1138 :: 		RF4463nSEL= 0x01;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;RF4463PRO.c,1139 :: 		return 1;
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463CheckCTS
;RF4463PRO.c,1140 :: 		}
L_ucRf4463CheckCTS112:
;RF4463PRO.c,1142 :: 		RF4463nSEL=0x01;
; usTimeoutCounter start address is: 20 (R5)
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;RF4463PRO.c,1143 :: 		}
UXTH	R2, R5
; usTimeoutCounter end address is: 20 (R5)
IT	AL
BAL	L_ucRf4463CheckCTS110
L_ucRf4463CheckCTS111:
;RF4463PRO.c,1144 :: 		UART1_Write_Text( "[ RF4463 ] CTS failed\r\n" );
ADD	R11, SP, #4
ADD	R10, R11, #24
MOVW	R12, #lo_addr(?ICS?lstr3_RF4463PRO+0)
MOVT	R12, #hi_addr(?ICS?lstr3_RF4463PRO+0)
BL	___CC2DW+0
ADD	R0, SP, #4
BL	_UART1_Write_Text+0
;RF4463PRO.c,1145 :: 		return 0;
MOVS	R0, #0
;RF4463PRO.c,1146 :: 		}
L_end_ucRf4463CheckCTS:
LDR	LR, [SP, #0]
ADD	SP, SP, #28
BX	LR
; end of _ucRf4463CheckCTS
_hex2int:
;RF4463PRO.c,1148 :: 		unsigned long hex2int(char *a, unsigned int len)
; len start address is: 4 (R1)
; a start address is: 0 (R0)
SUB	SP, SP, #4
; len end address is: 4 (R1)
; a end address is: 0 (R0)
; a start address is: 0 (R0)
; len start address is: 4 (R1)
;RF4463PRO.c,1151 :: 		unsigned long val = 0;
; val start address is: 24 (R6)
MOV	R6, #0
;RF4463PRO.c,1153 :: 		for(i=0;i<len;i++)
; i start address is: 20 (R5)
MOVS	R5, #0
SXTH	R5, R5
; a end address is: 0 (R0)
; len end address is: 4 (R1)
; val end address is: 24 (R6)
; i end address is: 20 (R5)
STRH	R1, [SP, #0]
MOV	R1, R0
LDRH	R0, [SP, #0]
L_hex2int113:
; i start address is: 20 (R5)
; a start address is: 4 (R1)
; val start address is: 24 (R6)
; len start address is: 0 (R0)
; a start address is: 4 (R1)
; a end address is: 4 (R1)
CMP	R5, R0
IT	CS
BCS	L_hex2int114
; a end address is: 4 (R1)
;RF4463PRO.c,1154 :: 		if(a[i] <= 57)
; a start address is: 4 (R1)
ADDS	R2, R1, R5
LDRB	R2, [R2, #0]
CMP	R2, #57
IT	HI
BHI	L_hex2int116
;RF4463PRO.c,1155 :: 		val += (a[i]-48)*(1<<(4*(len-1-i)));
ADDS	R2, R1, R5
LDRB	R2, [R2, #0]
SUBW	R4, R2, #48
SXTH	R4, R4
SUBS	R2, R0, #1
UXTH	R2, R2
SUB	R2, R2, R5
UXTH	R2, R2
LSLS	R3, R2, #2
UXTH	R3, R3
MOVS	R2, #1
SXTH	R2, R2
LSLS	R2, R3
SXTH	R2, R2
MULS	R2, R4, R2
SXTH	R2, R2
ADDS	R6, R6, R2
IT	AL
BAL	L_hex2int117
L_hex2int116:
;RF4463PRO.c,1157 :: 		val += (a[i]-55)*(1<<(4*(len-1-i)));
ADDS	R2, R1, R5
LDRB	R2, [R2, #0]
SUBW	R4, R2, #55
SXTH	R4, R4
SUBS	R2, R0, #1
UXTH	R2, R2
SUB	R2, R2, R5
UXTH	R2, R2
LSLS	R3, R2, #2
UXTH	R3, R3
MOVS	R2, #1
SXTH	R2, R2
LSLS	R2, R3
SXTH	R2, R2
MULS	R2, R4, R2
SXTH	R2, R2
ADDS	R2, R6, R2
; val end address is: 24 (R6)
; val start address is: 12 (R3)
MOV	R3, R2
; val end address is: 12 (R3)
MOV	R6, R3
L_hex2int117:
;RF4463PRO.c,1153 :: 		for(i=0;i<len;i++)
; val start address is: 24 (R6)
ADDS	R5, R5, #1
SXTH	R5, R5
;RF4463PRO.c,1157 :: 		val += (a[i]-55)*(1<<(4*(len-1-i)));
; len end address is: 0 (R0)
; a end address is: 4 (R1)
; i end address is: 20 (R5)
IT	AL
BAL	L_hex2int113
L_hex2int114:
;RF4463PRO.c,1159 :: 		return val;
MOV	R0, R6
; val end address is: 24 (R6)
;RF4463PRO.c,1160 :: 		}
L_end_hex2int:
ADD	SP, SP, #4
BX	LR
; end of _hex2int
_ucRf4463GetProperty:
;RF4463PRO.c,1162 :: 		uint8_t ucRf4463GetProperty( uint16_t usStartProperty, uint8_t ucLength, uint8_t * pcParametersBuffer ){
; ucLength start address is: 4 (R1)
; usStartProperty start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
UXTH	R7, R0
UXTB	R8, R1
STR	R2, [SP, #8]
; ucLength end address is: 4 (R1)
; usStartProperty end address is: 0 (R0)
; usStartProperty start address is: 28 (R7)
; ucLength start address is: 32 (R8)
;RF4463PRO.c,1165 :: 		if( ucRf4463CheckCTS() == 0 ){
BL	_ucRf4463CheckCTS+0
CMP	R0, #0
IT	NE
BNE	L_ucRf4463GetProperty118
; usStartProperty end address is: 28 (R7)
; ucLength end address is: 32 (R8)
;RF4463PRO.c,1166 :: 		return 0;
MOVS	R0, #0
IT	AL
BAL	L_end_ucRf4463GetProperty
;RF4463PRO.c,1167 :: 		}
L_ucRf4463GetProperty118:
;RF4463PRO.c,1169 :: 		pcBuffer[ 0 ] = GET_PROPERTY;
; ucLength start address is: 32 (R8)
; usStartProperty start address is: 28 (R7)
ADD	R5, SP, #4
MOVS	R3, #18
STRB	R3, [R5, #0]
;RF4463PRO.c,1170 :: 		pcBuffer[ 1 ] = ( usStartProperty >> 8 );
ADDS	R4, R5, #1
LSRS	R3, R7, #8
STRB	R3, [R4, #0]
;RF4463PRO.c,1171 :: 		pcBuffer[ 2 ] = ucLength;
ADDS	R3, R5, #2
STRB	R8, [R3, #0]
;RF4463PRO.c,1172 :: 		pcBuffer[ 3 ] = ( usStartProperty & 0xFF );
ADDS	R4, R5, #3
AND	R3, R7, #255
; usStartProperty end address is: 28 (R7)
STRB	R3, [R4, #0]
;RF4463PRO.c,1174 :: 		RF4463nSEL = 0;
MOVS	R4, #0
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOB_ODR+0)
MOVT	R3, #hi_addr(GPIOB_ODR+0)
_SX	[R3, ByteOffset(GPIOB_ODR+0)]
;RF4463PRO.c,1175 :: 		vRf4463SPIWriteBuffer( 4, pcBuffer );
MOV	R1, R5
MOVS	R0, #4
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,1177 :: 		if( ucRf4463CheckCTS() == 0 ){
BL	_ucRf4463CheckCTS+0
CMP	R0, #0
IT	NE
BNE	L_ucRf4463GetProperty119
; ucLength end address is: 32 (R8)
;RF4463PRO.c,1178 :: 		return 0;
MOVS	R0, #0
IT	AL
BAL	L_end_ucRf4463GetProperty
;RF4463PRO.c,1179 :: 		}
L_ucRf4463GetProperty119:
;RF4463PRO.c,1181 :: 		RF4463nSEL= 0;
; ucLength start address is: 32 (R8)
MOVS	R4, #0
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOB_ODR+0)
MOVT	R3, #hi_addr(GPIOB_ODR+0)
_SX	[R3, ByteOffset(GPIOB_ODR+0)]
;RF4463PRO.c,1182 :: 		SPIReadByte( READ_CMD_BUFF );
MOVS	R0, #68
BL	_SPIReadByte+0
;RF4463PRO.c,1184 :: 		vRf4463SPIReadBuffer( ucLength, pcParametersBuffer );
LDR	R1, [SP, #8]
UXTB	R0, R8
; ucLength end address is: 32 (R8)
BL	_vRf4463SPIReadBuffer+0
;RF4463PRO.c,1185 :: 		RF4463nSEL = 1;
MOVS	R4, #1
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOB_ODR+0)
MOVT	R3, #hi_addr(GPIOB_ODR+0)
_SX	[R3, ByteOffset(GPIOB_ODR+0)]
;RF4463PRO.c,1187 :: 		return 1;
MOVS	R0, #1
;RF4463PRO.c,1188 :: 		}
L_end_ucRf4463GetProperty:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _ucRf4463GetProperty
_ucRf4463GetCommand:
;RF4463PRO.c,1192 :: 		uint8_t ucRf4463GetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer ){
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
;RF4463PRO.c,1193 :: 		if( ucRf4463CheckCTS() == 0 ){
BL	_ucRf4463CheckCTS+0
CMP	R0, #0
IT	NE
BNE	L_ucRf4463GetCommand120
; ucLength end address is: 28 (R7)
; ucCommand end address is: 32 (R8)
;RF4463PRO.c,1194 :: 		return 0;
MOVS	R0, #0
IT	AL
BAL	L_end_ucRf4463GetCommand
;RF4463PRO.c,1195 :: 		}
L_ucRf4463GetCommand120:
;RF4463PRO.c,1197 :: 		RF4463nSEL= 0;
; ucCommand start address is: 32 (R8)
; ucLength start address is: 28 (R7)
MOVS	R4, #0
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOB_ODR+0)
MOVT	R3, #hi_addr(GPIOB_ODR+0)
_SX	[R3, ByteOffset(GPIOB_ODR+0)]
;RF4463PRO.c,1198 :: 		SPIWriteByte( ucCommand );
UXTB	R0, R8
; ucCommand end address is: 32 (R8)
BL	_SPIWriteByte+0
;RF4463PRO.c,1199 :: 		RF4463nSEL= 1;
MOVS	R4, #1
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOB_ODR+0)
MOVT	R3, #hi_addr(GPIOB_ODR+0)
_SX	[R3, ByteOffset(GPIOB_ODR+0)]
;RF4463PRO.c,1201 :: 		if( ucRf4463CheckCTS() == 0 ){
BL	_ucRf4463CheckCTS+0
CMP	R0, #0
IT	NE
BNE	L_ucRf4463GetCommand121
; ucLength end address is: 28 (R7)
;RF4463PRO.c,1202 :: 		return 0;
MOVS	R0, #0
IT	AL
BAL	L_end_ucRf4463GetCommand
;RF4463PRO.c,1203 :: 		}
L_ucRf4463GetCommand121:
;RF4463PRO.c,1205 :: 		RF4463nSEL= 0;
; ucLength start address is: 28 (R7)
MOVS	R4, #0
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOB_ODR+0)
MOVT	R3, #hi_addr(GPIOB_ODR+0)
_SX	[R3, ByteOffset(GPIOB_ODR+0)]
;RF4463PRO.c,1206 :: 		SPIWriteByte( READ_CMD_BUFF );
MOVS	R0, #68
BL	_SPIWriteByte+0
;RF4463PRO.c,1207 :: 		vRf4463SPIReadBuffer( ucLength, pcParametersBuffer );
LDR	R1, [SP, #4]
UXTB	R0, R7
; ucLength end address is: 28 (R7)
BL	_vRf4463SPIReadBuffer+0
;RF4463PRO.c,1208 :: 		RF4463nSEL= 1;
MOVS	R4, #1
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOB_ODR+0)
MOVT	R3, #hi_addr(GPIOB_ODR+0)
_SX	[R3, ByteOffset(GPIOB_ODR+0)]
;RF4463PRO.c,1209 :: 		UART1_Write_Text(pcParametersBuffer);
LDR	R0, [SP, #4]
BL	_UART1_Write_Text+0
;RF4463PRO.c,1210 :: 		return 1;
MOVS	R0, #1
;RF4463PRO.c,1211 :: 		}
L_end_ucRf4463GetCommand:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRf4463GetCommand
_ucRf4463SetCommand:
;RF4463PRO.c,1213 :: 		uint8_t ucRf4463SetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer ){
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
;RF4463PRO.c,1214 :: 		if( ucRf4463CheckCTS() == 0 ){
BL	_ucRf4463CheckCTS+0
CMP	R0, #0
IT	NE
BNE	L_ucRf4463SetCommand122
; ucLength end address is: 28 (R7)
; ucCommand end address is: 32 (R8)
;RF4463PRO.c,1215 :: 		return 1;
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463SetCommand
;RF4463PRO.c,1216 :: 		}
L_ucRf4463SetCommand122:
;RF4463PRO.c,1218 :: 		RF4463nSEL = 0;
; ucCommand start address is: 32 (R8)
; ucLength start address is: 28 (R7)
MOVS	R4, #0
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOB_ODR+0)
MOVT	R3, #hi_addr(GPIOB_ODR+0)
_SX	[R3, ByteOffset(GPIOB_ODR+0)]
;RF4463PRO.c,1219 :: 		SPIWriteByte( ucCommand );
UXTB	R0, R8
; ucCommand end address is: 32 (R8)
BL	_SPIWriteByte+0
;RF4463PRO.c,1220 :: 		vRf4463SPIWriteBuffer( ucLength, pcParametersBuffer );
LDR	R1, [SP, #4]
UXTB	R0, R7
; ucLength end address is: 28 (R7)
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,1221 :: 		RF4463nSEL = 1;
MOVS	R4, #1
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOB_ODR+0)
MOVT	R3, #hi_addr(GPIOB_ODR+0)
_SX	[R3, ByteOffset(GPIOB_ODR+0)]
;RF4463PRO.c,1223 :: 		return 1;
MOVS	R0, #1
;RF4463PRO.c,1224 :: 		}
L_end_ucRf4463SetCommand:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRf4463SetCommand
_vBufferSetToZero:
;RF4463PRO.c,1226 :: 		void vBufferSetToZero( uint8_t * pcBufferToClean, uint16_t uslength ){
; uslength start address is: 4 (R1)
; pcBufferToClean start address is: 0 (R0)
SUB	SP, SP, #4
; uslength end address is: 4 (R1)
; pcBufferToClean end address is: 0 (R0)
; pcBufferToClean start address is: 0 (R0)
; uslength start address is: 4 (R1)
;RF4463PRO.c,1227 :: 		uint16_t usPosition = 0;
;RF4463PRO.c,1229 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
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
;RF4463PRO.c,1230 :: 		pcBufferToClean[ usPosition ] = 0x00;
; pcBufferToClean start address is: 4 (R1)
ADDS	R3, R1, R4
MOVS	R2, #0
STRB	R2, [R3, #0]
;RF4463PRO.c,1229 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
ADDS	R4, R4, #1
UXTH	R4, R4
;RF4463PRO.c,1231 :: 		}
; uslength end address is: 0 (R0)
; pcBufferToClean end address is: 4 (R1)
; usPosition end address is: 16 (R4)
IT	AL
BAL	L_vBufferSetToZero123
L_vBufferSetToZero124:
;RF4463PRO.c,1232 :: 		}
L_end_vBufferSetToZero:
ADD	SP, SP, #4
BX	LR
; end of _vBufferSetToZero
_GPIO_SET:
;RF4463PRO.c,1235 :: 		void GPIO_SET(unsigned char mydata)
; mydata start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
; mydata end address is: 0 (R0)
; mydata start address is: 0 (R0)
;RF4463PRO.c,1239 :: 		app_command_buf[0] = 0x13;     // gpio ÉèÖÃ
ADD	R2, SP, #4
MOVS	R1, #19
STRB	R1, [R2, #0]
;RF4463PRO.c,1241 :: 		switch(mydata)
IT	AL
BAL	L_GPIO_SET126
; mydata end address is: 0 (R0)
;RF4463PRO.c,1243 :: 		case tx_normal:
L_GPIO_SET128:
;RF4463PRO.c,1244 :: 		case rx_normal:
L_GPIO_SET129:
;RF4463PRO.c,1245 :: 		app_command_buf[1]  = 3;                // GPIO0=1
ADD	R3, SP, #4
ADDS	R2, R3, #1
MOVS	R1, #3
STRB	R1, [R2, #0]
;RF4463PRO.c,1246 :: 		app_command_buf[2]  = 2;                // GPIO1=0
ADDS	R2, R3, #2
MOVS	R1, #2
STRB	R1, [R2, #0]
;RF4463PRO.c,1247 :: 		break;
IT	AL
BAL	L_GPIO_SET127
;RF4463PRO.c,1249 :: 		case tx_test:
L_GPIO_SET130:
;RF4463PRO.c,1250 :: 		app_command_buf[1]  = 3;                // GPIO0=1
ADD	R3, SP, #4
ADDS	R2, R3, #1
MOVS	R1, #3
STRB	R1, [R2, #0]
;RF4463PRO.c,1251 :: 		app_command_buf[2]  = 3;                // GPIO1=1
ADDS	R2, R3, #2
MOVS	R1, #3
STRB	R1, [R2, #0]
;RF4463PRO.c,1252 :: 		break;
IT	AL
BAL	L_GPIO_SET127
;RF4463PRO.c,1254 :: 		case rx_test:
L_GPIO_SET131:
;RF4463PRO.c,1255 :: 		app_command_buf[1]  = 2;                // GPIO0=0
ADD	R3, SP, #4
ADDS	R2, R3, #1
MOVS	R1, #2
STRB	R1, [R2, #0]
;RF4463PRO.c,1256 :: 		app_command_buf[2]  = 20;               // GPIO1=RX DATA
ADDS	R2, R3, #2
MOVS	R1, #20
STRB	R1, [R2, #0]
;RF4463PRO.c,1257 :: 		break;
IT	AL
BAL	L_GPIO_SET127
;RF4463PRO.c,1259 :: 		case rf_off:
L_GPIO_SET132:
;RF4463PRO.c,1260 :: 		app_command_buf[1]  = 2;                // GPIO0=0
ADD	R3, SP, #4
ADDS	R2, R3, #1
MOVS	R1, #2
STRB	R1, [R2, #0]
;RF4463PRO.c,1261 :: 		app_command_buf[2]  = 2;                // GPIO1=0
ADDS	R2, R3, #2
MOVS	R1, #2
STRB	R1, [R2, #0]
;RF4463PRO.c,1262 :: 		break;
IT	AL
BAL	L_GPIO_SET127
;RF4463PRO.c,1263 :: 		}
L_GPIO_SET126:
; mydata start address is: 0 (R0)
CMP	R0, #0
IT	EQ
BEQ	L_GPIO_SET128
CMP	R0, #1
IT	EQ
BEQ	L_GPIO_SET129
CMP	R0, #2
IT	EQ
BEQ	L_GPIO_SET130
CMP	R0, #3
IT	EQ
BEQ	L_GPIO_SET131
CMP	R0, #4
IT	EQ
BEQ	L_GPIO_SET132
; mydata end address is: 0 (R0)
L_GPIO_SET127:
;RF4463PRO.c,1265 :: 		app_command_buf[3]  = 0x21;  //0x20;   //  gpio2, h = tx mode
ADD	R3, SP, #4
ADDS	R2, R3, #3
MOVS	R1, #33
STRB	R1, [R2, #0]
;RF4463PRO.c,1266 :: 		app_command_buf[4]  = 0x20; // 0x14;  //   gpio3
ADDS	R2, R3, #4
MOVS	R1, #32
STRB	R1, [R2, #0]
;RF4463PRO.c,1267 :: 		app_command_buf[5]  = 0x27;   // nIRQ
ADDS	R2, R3, #5
MOVS	R1, #39
STRB	R1, [R2, #0]
;RF4463PRO.c,1268 :: 		app_command_buf[6]  = 0x0b;  // sdo
ADDS	R2, R3, #6
MOVS	R1, #11
STRB	R1, [R2, #0]
;RF4463PRO.c,1269 :: 		vRf4463SPIWriteBuffer(7, app_command_buf);
MOV	R1, R3
MOVS	R0, #7
BL	_vRf4463SPIWriteBuffer+0
;RF4463PRO.c,1270 :: 		}
L_end_GPIO_SET:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _GPIO_SET
