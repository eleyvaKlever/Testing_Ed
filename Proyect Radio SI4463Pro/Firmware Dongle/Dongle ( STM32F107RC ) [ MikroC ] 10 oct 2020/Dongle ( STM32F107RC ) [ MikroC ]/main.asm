_vDongleLoop:
;dongle.c,43 :: 		void vDongleLoop(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;dongle.c,44 :: 		vUARTRxInit();
BL	_vUARTRxInit+0
;dongle.c,49 :: 		STM_LOGI( "[ APP ] Start\r\n", NULL );
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_11_main+0)
MOVT	R1, #hi_addr(?lstr_11_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;dongle.c,52 :: 		while( 1 ){
L_vDongleLoop0:
;dongle.c,53 :: 		if( ucUARTDataReady == 1 ){
MOVW	R0, #lo_addr(_ucUARTDataReady+0)
MOVT	R0, #hi_addr(_ucUARTDataReady+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_vDongleLoop2
;dongle.c,54 :: 		ucUARTDataReady = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucUARTDataReady+0)
MOVT	R0, #hi_addr(_ucUARTDataReady+0)
STRB	R1, [R0, #0]
;dongle.c,55 :: 		vUARTRxMessage();
BL	_vUARTRxMessage+0
;dongle.c,56 :: 		}
L_vDongleLoop2:
;dongle.c,57 :: 		if( ucRF4463GetIRQFlag() == 1 ){
BL	_ucRF4463GetIRQFlag+0
CMP	R0, #1
IT	NE
BNE	L_vDongleLoop3
;dongle.c,59 :: 		vRF4463MesageHandler();
BL	_vRF4463MesageHandler+0
;dongle.c,60 :: 		vRF4463ResetIRQFlag();
BL	_vRF4463ResetIRQFlag+0
;dongle.c,61 :: 		}
L_vDongleLoop3:
;dongle.c,62 :: 		}
IT	AL
BAL	L_vDongleLoop0
;dongle.c,63 :: 		}
L_end_vDongleLoop:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vDongleLoop
_vUARTISR:
;uarthandler.c,72 :: 		void vUARTISR() iv IVT_INT_USART1 ics ICS_AUTO{
SUB	SP, SP, #4
STR	LR, [SP, #0]
;uarthandler.c,73 :: 		LEDBlue =~ LEDBlue;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_LX	[R0, ByteOffset(GPIOC_ODR+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;uarthandler.c,75 :: 		if( USART1_SRbits.RXNE == 1 ){
MOVW	R0, #lo_addr(USART1_SRbits+0)
MOVT	R0, #hi_addr(USART1_SRbits+0)
_LX	[R0, ByteOffset(USART1_SRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUARTISR4
;uarthandler.c,76 :: 		ucTempByteUART = USART1_DR;
MOVW	R0, #lo_addr(USART1_DR+0)
MOVT	R0, #hi_addr(USART1_DR+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucTempByteUART+0)
MOVT	R0, #hi_addr(_ucTempByteUART+0)
STRB	R1, [R0, #0]
;uarthandler.c,77 :: 		if( ucTempByteUART == '\n' ){
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	NE
BNE	L_vUARTISR5
;uarthandler.c,78 :: 		pcRxUARTBuffer[ usUARTMessageLength++ ] = ucTempByteUART;
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
;uarthandler.c,79 :: 		ucUARTDataReady = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucUARTDataReady+0)
MOVT	R0, #hi_addr(_ucUARTDataReady+0)
STRB	R1, [R0, #0]
;uarthandler.c,80 :: 		ucTempByteUART = 0;
MOVS	R0, #0
STRB	R0, [R2, #0]
;uarthandler.c,81 :: 		LEDBlue = PIN_LEVEL_LOW;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;uarthandler.c,82 :: 		}
IT	AL
BAL	L_vUARTISR6
L_vUARTISR5:
;uarthandler.c,84 :: 		pcRxUARTBuffer[ usUARTMessageLength++ ] = ucTempByteUART;
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
;uarthandler.c,85 :: 		ucTempByteUART = 0;
MOVS	R0, #0
STRB	R0, [R1, #0]
;uarthandler.c,86 :: 		}
L_vUARTISR6:
;uarthandler.c,87 :: 		}
L_vUARTISR4:
;uarthandler.c,88 :: 		if( USART1_SRbits.ORE == 1 ){
MOVW	R0, #lo_addr(USART1_SRbits+0)
MOVT	R0, #hi_addr(USART1_SRbits+0)
_LX	[R0, ByteOffset(USART1_SRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUARTISR7
;uarthandler.c,89 :: 		STM_LOGE( "[ IRQ ] UART Overrun\r\n", NULL );
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_33_main+0)
MOVT	R1, #hi_addr(?lstr_33_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;uarthandler.c,90 :: 		ucTempByteUART = USART1_SR;
MOVW	R0, #lo_addr(USART1_SR+0)
MOVT	R0, #hi_addr(USART1_SR+0)
LDR	R0, [R0, #0]
MOVW	R1, #lo_addr(_ucTempByteUART+0)
MOVT	R1, #hi_addr(_ucTempByteUART+0)
STRB	R0, [R1, #0]
;uarthandler.c,91 :: 		ucTempByteUART = USART1_DR;
MOVW	R0, #lo_addr(USART1_DR+0)
MOVT	R0, #hi_addr(USART1_DR+0)
LDR	R0, [R0, #0]
STRB	R0, [R1, #0]
;uarthandler.c,92 :: 		LEDBlue = PIN_LEVEL_LOW;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;uarthandler.c,93 :: 		}
L_vUARTISR7:
;uarthandler.c,94 :: 		}
L_end_vUARTISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUARTISR
_vUARTTxInit:
;uarthandler.c,102 :: 		void vUARTTxInit(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;uarthandler.c,103 :: 		UART1_Init_Advanced( 921600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10 );
MOVW	R0, #lo_addr(__GPIO_MODULE_USART1_PA9_10+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_USART1_PA9_10+0)
PUSH	(R0)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
MOV	R0, #921600
BL	_UART1_Init_Advanced+0
ADD	SP, SP, #4
;uarthandler.c,104 :: 		}
L_end_vUARTTxInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUARTTxInit
_vUARTRxInit:
;uarthandler.c,109 :: 		void vUARTRxInit(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;uarthandler.c,110 :: 		USART1_CR1bits.RE       = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(USART1_CR1bits+0)
MOVT	R0, #hi_addr(USART1_CR1bits+0)
_SX	[R0, ByteOffset(USART1_CR1bits+0)]
;uarthandler.c,111 :: 		USART1_CR1bits.RXNEIE   = 1;
MOVW	R0, #lo_addr(USART1_CR1bits+0)
MOVT	R0, #hi_addr(USART1_CR1bits+0)
_SX	[R0, ByteOffset(USART1_CR1bits+0)]
;uarthandler.c,113 :: 		NVIC_IntEnable( IVT_INT_USART1 );
MOVW	R0, #53
BL	_NVIC_IntEnable+0
;uarthandler.c,114 :: 		}
L_end_vUARTRxInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUARTRxInit
_vUARTRxMessage:
;uarthandler.c,119 :: 		void vUARTRxMessage(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;uarthandler.c,120 :: 		uint16_t usCounter = 0;
;uarthandler.c,127 :: 		STM_LOGV( "[ UART RX ] Packet: %s", pcRxUARTBuffer );
MOVW	R2, #lo_addr(_pcRxUARTBuffer+0)
MOVT	R2, #hi_addr(_pcRxUARTBuffer+0)
MOVW	R1, #lo_addr(?lstr_34_main+0)
MOVT	R1, #hi_addr(?lstr_34_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;uarthandler.c,129 :: 		vUARTCommands( pcRxUARTBuffer );
MOVW	R0, #lo_addr(_pcRxUARTBuffer+0)
MOVT	R0, #hi_addr(_pcRxUARTBuffer+0)
BL	_vUARTCommands+0
;uarthandler.c,131 :: 		memset( pcRxUARTBuffer, '\0', sizeof( pcRxUARTBuffer ) );
MOVW	R2, #2048
SXTH	R2, R2
MOVS	R1, #0
MOVW	R0, #lo_addr(_pcRxUARTBuffer+0)
MOVT	R0, #hi_addr(_pcRxUARTBuffer+0)
BL	_memset+0
;uarthandler.c,132 :: 		usUARTMessageLength = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_usUARTMessageLength+0)
MOVT	R0, #hi_addr(_usUARTMessageLength+0)
STRH	R1, [R0, #0]
;uarthandler.c,133 :: 		}
L_end_vUARTRxMessage:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUARTRxMessage
_vUARTCommands:
;uarthandler.c,138 :: 		void vUARTCommands( uint8_t * pcInBuffer ){
SUB	SP, SP, #84
STR	LR, [SP, #0]
STR	R0, [SP, #68]
;uarthandler.c,139 :: 		uint8_t ucCommandCounter = 0;
;uarthandler.c,140 :: 		uint8_t ucCounter = 0;
;uarthandler.c,141 :: 		uint8_t ucPosition = 0;
;uarthandler.c,146 :: 		uint16_t usTempData = 0;
;uarthandler.c,147 :: 		uint8_t ucDeviceModel = 0;
;uarthandler.c,149 :: 		uint16_t usTempChannel = 0;
;uarthandler.c,150 :: 		uint16_t usTempNetwork = 0;
;uarthandler.c,151 :: 		uint8_t ucIgnoreNetwork = 0;
MOVS	R1, #0
STRB	R1, [SP, #67]
;uarthandler.c,153 :: 		for( ucCommandCounter = 0; ucCommandCounter < UART_Commands; ucCommandCounter++ ){
MOVS	R1, #0
STRB	R1, [SP, #72]
L_vUARTCommands8:
LDRB	R1, [SP, #72]
CMP	R1, #21
IT	CS
BCS	L_vUARTCommands9
;uarthandler.c,154 :: 		if( strstr( pcInBuffer, pcUARTCommand[ ucCommandCounter ] ) ){
LDRB	R1, [SP, #72]
LSLS	R2, R1, #2
MOVW	R1, #lo_addr(_pcUARTCommand+0)
MOVT	R1, #hi_addr(_pcUARTCommand+0)
ADDS	R1, R1, R2
LDR	R1, [R1, #0]
LDR	R0, [SP, #68]
BL	_strstr+0
CMP	R0, #0
IT	EQ
BEQ	L_vUARTCommands11
;uarthandler.c,155 :: 		switch( ucCommandCounter ){
IT	AL
BAL	L_vUARTCommands12
;uarthandler.c,156 :: 		case UART_CMD_WHO:
L_vUARTCommands14:
;uarthandler.c,157 :: 		UART1_Write_Text( "DONGLE\r\n" );
ADD	R11, SP, #58
ADD	R10, R11, #9
MOVW	R12, #lo_addr(?ICS?lstr35_main+0)
MOVT	R12, #hi_addr(?ICS?lstr35_main+0)
BL	___CC2DW+0
ADD	R1, SP, #58
MOV	R0, R1
BL	_UART1_Write_Text+0
;uarthandler.c,158 :: 		Sound_Play( 1000, 100 );
MOVS	R1, #100
MOVW	R0, #1000
BL	_Sound_Play+0
;uarthandler.c,159 :: 		Delay_ms( 30 );
MOVW	R7, #32319
MOVT	R7, #5
NOP
NOP
L_vUARTCommands15:
SUBS	R7, R7, #1
BNE	L_vUARTCommands15
NOP
NOP
NOP
;uarthandler.c,160 :: 		Sound_Play( 1000, 100 );
MOVS	R1, #100
MOVW	R0, #1000
BL	_Sound_Play+0
;uarthandler.c,161 :: 		break;
IT	AL
BAL	L_vUARTCommands13
;uarthandler.c,162 :: 		case UART_CMD_SEND:
L_vUARTCommands17:
;uarthandler.c,163 :: 		STM_LOGD( "[ UART ] Send Message\r\n", NULL );
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(?lstr_36_main+0)
MOVT	R2, #hi_addr(?lstr_36_main+0)
MOVW	R1, #lo_addr(_vDebugPrint+0)
MOVT	R1, #hi_addr(_vDebugPrint+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_PrintOut+0
ADD	SP, SP, #12
;uarthandler.c,166 :: 		memset( pcTempBuffer, '\0', 50 );
ADD	R1, SP, #8
MOVS	R2, #50
SXTH	R2, R2
MOV	R0, R1
MOVS	R1, #0
BL	_memset+0
;uarthandler.c,168 :: 		ucPosition = 5;
; ucPosition start address is: 12 (R3)
MOVS	R3, #5
;uarthandler.c,169 :: 		for( ucCounter = 0; ucCounter < usUARTMessageLength; ucCounter++ ){
; ucCounter start address is: 0 (R0)
MOVS	R0, #0
; ucCounter end address is: 0 (R0)
; ucPosition end address is: 12 (R3)
L_vUARTCommands18:
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 12 (R3)
MOVW	R1, #lo_addr(_usUARTMessageLength+0)
MOVT	R1, #hi_addr(_usUARTMessageLength+0)
LDRH	R1, [R1, #0]
CMP	R0, R1
IT	CS
BCS	L_vUARTCommands19
;uarthandler.c,170 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
LDR	R1, [SP, #68]
ADDS	R1, R1, R3
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands332
LDR	R1, [SP, #68]
ADDS	R1, R1, R3
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands331
IT	AL
BAL	L_vUARTCommands23
; ucPosition end address is: 12 (R3)
L__vUARTCommands332:
L__vUARTCommands331:
;uarthandler.c,171 :: 		break;
IT	AL
BAL	L_vUARTCommands19
;uarthandler.c,172 :: 		}
L_vUARTCommands23:
;uarthandler.c,173 :: 		pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
; ucPosition start address is: 12 (R3)
ADD	R1, SP, #8
ADDS	R2, R1, R0
LDR	R1, [SP, #68]
ADDS	R1, R1, R3
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
ADDS	R1, R3, #1
; ucPosition end address is: 12 (R3)
; ucPosition start address is: 8 (R2)
UXTB	R2, R1
;uarthandler.c,169 :: 		for( ucCounter = 0; ucCounter < usUARTMessageLength; ucCounter++ ){
ADDS	R1, R0, #1
; ucCounter end address is: 0 (R0)
; ucCounter start address is: 4 (R1)
;uarthandler.c,174 :: 		}
UXTB	R3, R2
; ucPosition end address is: 8 (R2)
; ucCounter end address is: 4 (R1)
UXTB	R0, R1
IT	AL
BAL	L_vUARTCommands18
L_vUARTCommands19:
;uarthandler.c,175 :: 		vRF4463SetNode( NODE_FACTORY );
; ucCounter start address is: 0 (R0)
STRB	R0, [SP, #4]
MOVS	R0, #254
BL	_vRF4463SetNode+0
LDRB	R0, [SP, #4]
;uarthandler.c,176 :: 		vRF4463TxMessage( pcTempBuffer, ucCounter, NODE_BROADCAST, TABLE_RF_TEST, RF_TEST_QR );
MOVS	R2, #2
ADD	R1, SP, #8
PUSH	(R2)
STR	R1, [SP, #8]
MOVS	R3, #1
MOVS	R2, #255
UXTB	R1, R0
; ucCounter end address is: 0 (R0)
LDR	R0, [SP, #8]
BL	_vRF4463TxMessage+0
ADD	SP, SP, #4
;uarthandler.c,177 :: 		break;
IT	AL
BAL	L_vUARTCommands13
;uarthandler.c,178 :: 		case UART_CMD_END:
L_vUARTCommands24:
;uarthandler.c,179 :: 		STM_LOGD( "[ UART ] End Factory Stage\r\n", NULL );
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(?lstr_37_main+0)
MOVT	R2, #hi_addr(?lstr_37_main+0)
MOVW	R1, #lo_addr(_vDebugPrint+0)
MOVT	R1, #hi_addr(_vDebugPrint+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_PrintOut+0
ADD	SP, SP, #12
;uarthandler.c,182 :: 		memset( pcSentQR, '\0', 15 );
MOVS	R2, #15
SXTH	R2, R2
MOVS	R1, #0
MOVW	R0, #lo_addr(main_pcSentQR+0)
MOVT	R0, #hi_addr(main_pcSentQR+0)
BL	_memset+0
;uarthandler.c,184 :: 		ucPosition = 6;
; ucPosition start address is: 12 (R3)
MOVS	R3, #6
;uarthandler.c,186 :: 		for( ucCounter = 0; ucCounter < usUARTMessageLength; ucCounter++ ){
; ucCounter start address is: 0 (R0)
MOVS	R0, #0
; ucCounter end address is: 0 (R0)
; ucPosition end address is: 12 (R3)
L_vUARTCommands25:
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 12 (R3)
MOVW	R1, #lo_addr(_usUARTMessageLength+0)
MOVT	R1, #hi_addr(_usUARTMessageLength+0)
LDRH	R1, [R1, #0]
CMP	R0, R1
IT	CS
BCS	L_vUARTCommands26
;uarthandler.c,187 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
LDR	R1, [SP, #68]
ADDS	R1, R1, R3
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands334
LDR	R1, [SP, #68]
ADDS	R1, R1, R3
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands333
IT	AL
BAL	L_vUARTCommands30
; ucPosition end address is: 12 (R3)
L__vUARTCommands334:
L__vUARTCommands333:
;uarthandler.c,188 :: 		break;
IT	AL
BAL	L_vUARTCommands26
;uarthandler.c,189 :: 		}
L_vUARTCommands30:
;uarthandler.c,190 :: 		pcSentQR[ ucCounter ] = pcInBuffer[ ucPosition++ ];
; ucPosition start address is: 12 (R3)
MOVW	R1, #lo_addr(main_pcSentQR+0)
MOVT	R1, #hi_addr(main_pcSentQR+0)
ADDS	R2, R1, R0
LDR	R1, [SP, #68]
ADDS	R1, R1, R3
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
ADDS	R2, R3, #1
UXTB	R2, R2
; ucPosition end address is: 12 (R3)
; ucPosition start address is: 8 (R2)
;uarthandler.c,186 :: 		for( ucCounter = 0; ucCounter < usUARTMessageLength; ucCounter++ ){
ADDS	R1, R0, #1
UXTB	R1, R1
; ucCounter end address is: 0 (R0)
; ucCounter start address is: 4 (R1)
;uarthandler.c,191 :: 		}
UXTB	R3, R2
; ucPosition end address is: 8 (R2)
; ucCounter end address is: 4 (R1)
UXTB	R0, R1
IT	AL
BAL	L_vUARTCommands25
L_vUARTCommands26:
;uarthandler.c,193 :: 		vRF4463SetNode( NODE_FACTORY );
; ucCounter start address is: 0 (R0)
STRB	R0, [SP, #4]
MOVS	R0, #254
BL	_vRF4463SetNode+0
LDRB	R0, [SP, #4]
;uarthandler.c,194 :: 		vRF4463TxMessage( pcSentQR, ucCounter, NODE_BROADCAST, TABLE_RF_TEST, RF_TEST_OK );
MOVS	R1, #3
PUSH	(R1)
MOVS	R3, #1
MOVS	R2, #255
UXTB	R1, R0
; ucCounter end address is: 0 (R0)
MOVW	R0, #lo_addr(main_pcSentQR+0)
MOVT	R0, #hi_addr(main_pcSentQR+0)
BL	_vRF4463TxMessage+0
ADD	SP, SP, #4
;uarthandler.c,195 :: 		break;
IT	AL
BAL	L_vUARTCommands13
;uarthandler.c,196 :: 		case UART_CMD_STAGE:
L_vUARTCommands31:
;uarthandler.c,197 :: 		STM_LOGD( "[ UART ] Get Stage\r\n", NULL );
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(?lstr_38_main+0)
MOVT	R2, #hi_addr(?lstr_38_main+0)
MOVW	R1, #lo_addr(_vDebugPrint+0)
MOVT	R1, #hi_addr(_vDebugPrint+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_PrintOut+0
ADD	SP, SP, #12
;uarthandler.c,199 :: 		vRf4463SetChannels( RF4463_DEFAULT_CHANNEL, RF4463_DEFAULT_CHANNEL );
MOVS	R1, #0
MOVS	R0, #0
BL	_vRf4463SetChannels+0
;uarthandler.c,200 :: 		vRf4463SetNetwork( RF4463_DEFAULT_NETWORK );
MOVS	R0, #1
BL	_vRf4463SetNetwork+0
;uarthandler.c,201 :: 		vRF4463SetNode( NODE_FACTORY );
MOVS	R0, #254
BL	_vRF4463SetNode+0
;uarthandler.c,203 :: 		vRF4463TxMessage( NULL, NULL, NODE_BROADCAST, TABLE_RF_TEST, RF_TEST_STAGE );
MOVS	R1, #4
PUSH	(R1)
MOVS	R3, #1
MOVS	R2, #255
MOVS	R1, #0
MOVS	R0, #0
BL	_vRF4463TxMessage+0
ADD	SP, SP, #4
;uarthandler.c,204 :: 		break;
IT	AL
BAL	L_vUARTCommands13
;uarthandler.c,205 :: 		case UART_CMD_REBOOT:
L_vUARTCommands32:
;uarthandler.c,206 :: 		STM_LOGD( "[ UART ] Reboot\r\n", NULL );
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(?lstr_39_main+0)
MOVT	R2, #hi_addr(?lstr_39_main+0)
MOVW	R1, #lo_addr(_vDebugPrint+0)
MOVT	R1, #hi_addr(_vDebugPrint+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_PrintOut+0
ADD	SP, SP, #12
;uarthandler.c,208 :: 		LEDBlue = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
_SX	[R1, ByteOffset(GPIOC_ODR+0)]
;uarthandler.c,209 :: 		LEDGreen = 0;
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
_SX	[R1, ByteOffset(GPIOC_ODR+0)]
;uarthandler.c,210 :: 		LEDRed = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
_SX	[R1, ByteOffset(GPIOC_ODR+0)]
;uarthandler.c,212 :: 		Delay_ms( 1000 );
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_vUARTCommands33:
SUBS	R7, R7, #1
BNE	L_vUARTCommands33
NOP
NOP
NOP
;uarthandler.c,213 :: 		SystemReset();
BL	_SystemReset+0
;uarthandler.c,214 :: 		break;
IT	AL
BAL	L_vUARTCommands13
;uarthandler.c,215 :: 		case UART_CMD_PING:
L_vUARTCommands35:
;uarthandler.c,216 :: 		STM_LOGD( "[ UART ] Ping\r\n", NULL );
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(?lstr_40_main+0)
MOVT	R2, #hi_addr(?lstr_40_main+0)
MOVW	R1, #lo_addr(_vDebugPrint+0)
MOVT	R1, #hi_addr(_vDebugPrint+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_PrintOut+0
ADD	SP, SP, #12
;uarthandler.c,217 :: 		vRF4463SetNode( HUB_NODE );
MOVS	R0, #1
BL	_vRF4463SetNode+0
;uarthandler.c,218 :: 		vRF4463TxMessage( NULL, NULL, REMOTE_DEFAULT, TABLE_RF_TEST, RF_TEST_DEVICE_PING );
MOVS	R1, #0
PUSH	(R1)
MOVS	R3, #1
MOVS	R2, #2
MOVS	R1, #0
MOVS	R0, #0
BL	_vRF4463TxMessage+0
ADD	SP, SP, #4
;uarthandler.c,219 :: 		break;
IT	AL
BAL	L_vUARTCommands13
;uarthandler.c,220 :: 		case UART_CMD_TEST:
L_vUARTCommands36:
;uarthandler.c,221 :: 		STM_LOGD( "[ UART ] Test\r\n", NULL );
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(?lstr_41_main+0)
MOVT	R2, #hi_addr(?lstr_41_main+0)
MOVW	R1, #lo_addr(_vDebugPrint+0)
MOVT	R1, #hi_addr(_vDebugPrint+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_PrintOut+0
ADD	SP, SP, #12
;uarthandler.c,222 :: 		memset( pcTempBuffer, '\0', 50 );
ADD	R1, SP, #8
MOVS	R2, #50
SXTH	R2, R2
MOV	R0, R1
MOVS	R1, #0
BL	_memset+0
;uarthandler.c,224 :: 		ucPosition = 5;
; ucPosition start address is: 28 (R7)
MOVS	R7, #5
;uarthandler.c,226 :: 		for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
; ucCounter start address is: 0 (R0)
MOVS	R0, #0
; ucPosition end address is: 28 (R7)
; ucCounter end address is: 0 (R0)
UXTB	R4, R7
L_vUARTCommands37:
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 16 (R4)
CMP	R0, #12
IT	CS
BCS	L_vUARTCommands38
;uarthandler.c,227 :: 		pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
ADD	R3, SP, #8
ADDS	R2, R3, R0
LDR	R1, [SP, #68]
ADDS	R1, R1, R4
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
ADDS	R1, R4, #1
; ucPosition end address is: 16 (R4)
; ucPosition start address is: 28 (R7)
UXTB	R7, R1
;uarthandler.c,228 :: 		pcTempQR[ ucCounter ] = pcTempBuffer[ ucCounter ];
MOVW	R1, #lo_addr(_pcTempQR+0)
MOVT	R1, #hi_addr(_pcTempQR+0)
ADDS	R2, R1, R0
ADDS	R1, R3, R0
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
;uarthandler.c,226 :: 		for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
ADDS	R1, R0, #1
UXTB	R1, R1
; ucCounter end address is: 0 (R0)
; ucCounter start address is: 4 (R1)
;uarthandler.c,229 :: 		}
UXTB	R4, R7
; ucPosition end address is: 28 (R7)
; ucCounter end address is: 4 (R1)
UXTB	R0, R1
IT	AL
BAL	L_vUARTCommands37
L_vUARTCommands38:
;uarthandler.c,231 :: 		for( ucSearchedModelId = 0; ucSearchedModelId < DEVICE_MODEL_ID_TOTAL; ucSearchedModelId++ ){
MOVS	R2, #0
MOVW	R1, #lo_addr(_ucSearchedModelId+0)
MOVT	R1, #hi_addr(_ucSearchedModelId+0)
STRB	R2, [R1, #0]
L_vUARTCommands40:
MOVW	R1, #lo_addr(_ucSearchedModelId+0)
MOVT	R1, #hi_addr(_ucSearchedModelId+0)
LDRB	R1, [R1, #0]
CMP	R1, #5
IT	CS
BCS	L_vUARTCommands41
;uarthandler.c,232 :: 		if( memcmp( pcTempQR, pcModelQRPrefix[ ucSearchedModelId ], 2 ) == 0 ){
MOVW	R1, #lo_addr(_ucSearchedModelId+0)
MOVT	R1, #hi_addr(_ucSearchedModelId+0)
LDRB	R1, [R1, #0]
LSLS	R2, R1, #2
MOVW	R1, #lo_addr(_pcModelQRPrefix+0)
MOVT	R1, #hi_addr(_pcModelQRPrefix+0)
ADDS	R1, R1, R2
LDR	R1, [R1, #0]
MOVS	R2, #2
SXTH	R2, R2
MOVW	R0, #lo_addr(_pcTempQR+0)
MOVT	R0, #hi_addr(_pcTempQR+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vUARTCommands43
;uarthandler.c,233 :: 		break;
IT	AL
BAL	L_vUARTCommands41
;uarthandler.c,234 :: 		}
L_vUARTCommands43:
;uarthandler.c,231 :: 		for( ucSearchedModelId = 0; ucSearchedModelId < DEVICE_MODEL_ID_TOTAL; ucSearchedModelId++ ){
MOVW	R2, #lo_addr(_ucSearchedModelId+0)
MOVT	R2, #hi_addr(_ucSearchedModelId+0)
LDRB	R1, [R2, #0]
ADDS	R1, R1, #1
STRB	R1, [R2, #0]
;uarthandler.c,235 :: 		}
IT	AL
BAL	L_vUARTCommands40
L_vUARTCommands41:
;uarthandler.c,237 :: 		vRF4463SetNode( HUB_NODE );
MOVS	R0, #1
BL	_vRF4463SetNode+0
;uarthandler.c,238 :: 		vRF4463TxMessage( pcTempBuffer, strlen( pcTempBuffer ), REMOTE_DEFAULT, TABLE_RF_SETUP, RF_SETUP_FIND_BY_QR );
MOVS	R1, #1
STRB	R1, [SP, #80]
ADD	R1, SP, #8
MOV	R0, R1
BL	_strlen+0
ADD	R2, SP, #8
LDRB	R1, [SP, #80]
PUSH	(R1)
MOVS	R3, #2
UXTB	R1, R0
MOV	R0, R2
MOVS	R2, #2
BL	_vRF4463TxMessage+0
ADD	SP, SP, #4
;uarthandler.c,239 :: 		break;
IT	AL
BAL	L_vUARTCommands13
;uarthandler.c,240 :: 		case UART_CMD_REMOVE:
L_vUARTCommands44:
;uarthandler.c,241 :: 		STM_LOGD( "[ UART ] Remove\r\n", NULL );
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(?lstr_42_main+0)
MOVT	R2, #hi_addr(?lstr_42_main+0)
MOVW	R1, #lo_addr(_vDebugPrint+0)
MOVT	R1, #hi_addr(_vDebugPrint+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_PrintOut+0
ADD	SP, SP, #12
;uarthandler.c,243 :: 		memset( pcTempBuffer, '\0', 50 );
ADD	R1, SP, #8
MOVS	R2, #50
SXTH	R2, R2
MOV	R0, R1
MOVS	R1, #0
BL	_memset+0
;uarthandler.c,245 :: 		ucPosition = 7;
; ucPosition start address is: 28 (R7)
MOVS	R7, #7
;uarthandler.c,247 :: 		for( ucCounter = 0; ; ucCounter++ ){
; ucCounter start address is: 0 (R0)
MOVS	R0, #0
; ucPosition end address is: 28 (R7)
; ucCounter end address is: 0 (R0)
UXTB	R3, R7
L_vUARTCommands45:
;uarthandler.c,248 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 12 (R3)
LDR	R1, [SP, #68]
ADDS	R1, R1, R3
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands336
LDR	R1, [SP, #68]
ADDS	R1, R1, R3
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands335
IT	AL
BAL	L_vUARTCommands50
; ucCounter end address is: 0 (R0)
; ucPosition end address is: 12 (R3)
L__vUARTCommands336:
L__vUARTCommands335:
;uarthandler.c,249 :: 		break;
IT	AL
BAL	L_vUARTCommands46
;uarthandler.c,250 :: 		}
L_vUARTCommands50:
;uarthandler.c,251 :: 		pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
; ucPosition start address is: 12 (R3)
; ucCounter start address is: 0 (R0)
ADD	R1, SP, #8
ADDS	R2, R1, R0
LDR	R1, [SP, #68]
ADDS	R1, R1, R3
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
ADDS	R7, R3, #1
UXTB	R7, R7
; ucPosition end address is: 12 (R3)
; ucPosition start address is: 28 (R7)
;uarthandler.c,247 :: 		for( ucCounter = 0; ; ucCounter++ ){
ADDS	R1, R0, #1
UXTB	R1, R1
; ucCounter end address is: 0 (R0)
; ucCounter start address is: 4 (R1)
;uarthandler.c,252 :: 		}
UXTB	R3, R7
; ucPosition end address is: 28 (R7)
; ucCounter end address is: 4 (R1)
UXTB	R0, R1
IT	AL
BAL	L_vUARTCommands45
L_vUARTCommands46:
;uarthandler.c,254 :: 		usTempData = atoi( pcTempBuffer );
ADD	R1, SP, #8
MOV	R0, R1
BL	_atoi+0
; usTempData start address is: 8 (R2)
UXTH	R2, R0
;uarthandler.c,255 :: 		vRF4463SetNode( HUB_NODE );
MOVS	R0, #1
BL	_vRF4463SetNode+0
;uarthandler.c,256 :: 		vRF4463TxMessage( NULL, NULL, usTempData, TABLE_RF_SETUP, RF_SETUP_REMOVE );
MOVS	R1, #5
PUSH	(R1)
MOVS	R3, #2
UXTB	R2, R2
; usTempData end address is: 8 (R2)
MOVS	R1, #0
MOVS	R0, #0
BL	_vRF4463TxMessage+0
ADD	SP, SP, #4
;uarthandler.c,257 :: 		break;
IT	AL
BAL	L_vUARTCommands13
;uarthandler.c,258 :: 		case UART_CMD_CHANNEL:
L_vUARTCommands51:
;uarthandler.c,259 :: 		STM_LOGD( "[ UART ] Set Channel\r\n", NULL );
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(?lstr_43_main+0)
MOVT	R2, #hi_addr(?lstr_43_main+0)
MOVW	R1, #lo_addr(_vDebugPrint+0)
MOVT	R1, #hi_addr(_vDebugPrint+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_PrintOut+0
ADD	SP, SP, #12
;uarthandler.c,260 :: 		memset( pcTempBuffer, '\0', 50 );
ADD	R1, SP, #8
MOVS	R2, #50
SXTH	R2, R2
MOV	R0, R1
MOVS	R1, #0
BL	_memset+0
;uarthandler.c,262 :: 		ucPosition = 8;
; ucPosition start address is: 8 (R2)
MOVS	R2, #8
;uarthandler.c,264 :: 		ucRf4463EnterStandbyMode();
STRB	R2, [SP, #4]
BL	_ucRf4463EnterStandbyMode+0
LDRB	R2, [SP, #4]
;uarthandler.c,266 :: 		for( ucCounter = 0; ; ucCounter++ ){
; ucCounter start address is: 0 (R0)
MOVS	R0, #0
; ucCounter end address is: 0 (R0)
; ucPosition end address is: 8 (R2)
UXTB	R7, R2
L_vUARTCommands52:
;uarthandler.c,267 :: 		if( pcInBuffer[ ucPosition ] == ',' ){
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 28 (R7)
LDR	R1, [SP, #68]
ADDS	R1, R1, R7
LDRB	R1, [R1, #0]
CMP	R1, #44
IT	NE
BNE	L_vUARTCommands55
; ucCounter end address is: 0 (R0)
;uarthandler.c,268 :: 		ucPosition++;
ADDS	R1, R7, #1
; ucPosition end address is: 28 (R7)
; ucPosition start address is: 0 (R0)
UXTB	R0, R1
;uarthandler.c,269 :: 		break;
UXTB	R8, R0
; ucPosition end address is: 0 (R0)
IT	AL
BAL	L_vUARTCommands53
;uarthandler.c,270 :: 		}
L_vUARTCommands55:
;uarthandler.c,271 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 28 (R7)
LDR	R1, [SP, #68]
ADDS	R1, R1, R7
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands338
LDR	R1, [SP, #68]
ADDS	R1, R1, R7
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands337
IT	AL
BAL	L_vUARTCommands58
; ucCounter end address is: 0 (R0)
L__vUARTCommands338:
L__vUARTCommands337:
;uarthandler.c,272 :: 		ucIgnoreNetwork = 1;
MOVS	R1, #1
STRB	R1, [SP, #67]
;uarthandler.c,273 :: 		break;
UXTB	R8, R7
IT	AL
BAL	L_vUARTCommands53
;uarthandler.c,274 :: 		}
L_vUARTCommands58:
;uarthandler.c,275 :: 		pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
; ucCounter start address is: 0 (R0)
ADD	R1, SP, #8
ADDS	R2, R1, R0
LDR	R1, [SP, #68]
ADDS	R1, R1, R7
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
ADDS	R2, R7, #1
UXTB	R2, R2
; ucPosition end address is: 28 (R7)
; ucPosition start address is: 8 (R2)
;uarthandler.c,266 :: 		for( ucCounter = 0; ; ucCounter++ ){
ADDS	R1, R0, #1
UXTB	R1, R1
; ucCounter end address is: 0 (R0)
; ucCounter start address is: 4 (R1)
;uarthandler.c,276 :: 		}
UXTB	R7, R2
; ucPosition end address is: 8 (R2)
; ucCounter end address is: 4 (R1)
UXTB	R0, R1
IT	AL
BAL	L_vUARTCommands52
L_vUARTCommands53:
;uarthandler.c,278 :: 		usTempChannel = atoi( pcTempBuffer );
; ucPosition start address is: 32 (R8)
ADD	R1, SP, #8
MOV	R0, R1
BL	_atoi+0
; usTempChannel start address is: 8 (R2)
UXTH	R2, R0
;uarthandler.c,280 :: 		if( ucIgnoreNetwork == 0 ){
LDRB	R1, [SP, #67]
CMP	R1, #0
IT	NE
BNE	L_vUARTCommands59
;uarthandler.c,281 :: 		for( ucCounter = 0; ; ucCounter++ ){
; ucCounter start address is: 0 (R0)
MOVS	R0, #0
; ucPosition end address is: 32 (R8)
; usTempChannel end address is: 8 (R2)
; ucCounter end address is: 0 (R0)
UXTB	R3, R8
UXTH	R7, R2
L_vUARTCommands60:
;uarthandler.c,282 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
; ucCounter start address is: 0 (R0)
; usTempChannel start address is: 28 (R7)
; ucPosition start address is: 12 (R3)
LDR	R1, [SP, #68]
ADDS	R1, R1, R3
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands340
LDR	R1, [SP, #68]
ADDS	R1, R1, R3
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands339
IT	AL
BAL	L_vUARTCommands65
; ucCounter end address is: 0 (R0)
; ucPosition end address is: 12 (R3)
L__vUARTCommands340:
L__vUARTCommands339:
;uarthandler.c,283 :: 		break;
IT	AL
BAL	L_vUARTCommands61
;uarthandler.c,284 :: 		}
L_vUARTCommands65:
;uarthandler.c,285 :: 		pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
; ucPosition start address is: 12 (R3)
; ucCounter start address is: 0 (R0)
ADD	R1, SP, #8
ADDS	R2, R1, R0
LDR	R1, [SP, #68]
ADDS	R1, R1, R3
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
ADDS	R1, R3, #1
; ucPosition end address is: 12 (R3)
; ucPosition start address is: 24 (R6)
UXTB	R6, R1
;uarthandler.c,281 :: 		for( ucCounter = 0; ; ucCounter++ ){
ADDS	R1, R0, #1
UXTB	R1, R1
; ucCounter end address is: 0 (R0)
; ucCounter start address is: 4 (R1)
;uarthandler.c,286 :: 		}
UXTB	R3, R6
; ucPosition end address is: 24 (R6)
; ucCounter end address is: 4 (R1)
UXTB	R0, R1
IT	AL
BAL	L_vUARTCommands60
L_vUARTCommands61:
;uarthandler.c,287 :: 		usTempNetwork = atoi( pcTempBuffer );
ADD	R1, SP, #8
MOV	R0, R1
BL	_atoi+0
STRH	R0, [SP, #74]
;uarthandler.c,289 :: 		vRf4463SetChannels( usTempChannel, usTempChannel );
UXTB	R1, R7
UXTB	R0, R7
; usTempChannel end address is: 28 (R7)
BL	_vRf4463SetChannels+0
;uarthandler.c,290 :: 		vRf4463SetNetwork( usTempNetwork );
LDRH	R0, [SP, #74]
BL	_vRf4463SetNetwork+0
;uarthandler.c,291 :: 		}
IT	AL
BAL	L_vUARTCommands66
L_vUARTCommands59:
;uarthandler.c,293 :: 		vRf4463SetChannels( usTempChannel, usTempChannel );
; usTempChannel start address is: 8 (R2)
STRH	R2, [SP, #4]
UXTB	R1, R2
UXTB	R0, R2
BL	_vRf4463SetChannels+0
LDRH	R2, [SP, #4]
;uarthandler.c,294 :: 		vRf4463SetNetwork( usTempChannel );
UXTH	R0, R2
; usTempChannel end address is: 8 (R2)
BL	_vRf4463SetNetwork+0
;uarthandler.c,295 :: 		}
L_vUARTCommands66:
;uarthandler.c,296 :: 		ucRf4463RxInit();
BL	_ucRf4463RxInit+0
;uarthandler.c,297 :: 		break;
IT	AL
BAL	L_vUARTCommands13
;uarthandler.c,298 :: 		case UART_CMD_INFO:
L_vUARTCommands67:
;uarthandler.c,299 :: 		STM_LOGD( "[ UART ] Get Device Info\r\n", NULL );
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(?lstr_44_main+0)
MOVT	R2, #hi_addr(?lstr_44_main+0)
MOVW	R1, #lo_addr(_vDebugPrint+0)
MOVT	R1, #hi_addr(_vDebugPrint+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_PrintOut+0
ADD	SP, SP, #12
;uarthandler.c,325 :: 		break;
IT	AL
BAL	L_vUARTCommands13
;uarthandler.c,326 :: 		case UART_CMD_SEARCH:
L_vUARTCommands68:
;uarthandler.c,327 :: 		STM_LOGD( "[ UART ] Search\r\n", NULL );
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(?lstr_45_main+0)
MOVT	R2, #hi_addr(?lstr_45_main+0)
MOVW	R1, #lo_addr(_vDebugPrint+0)
MOVT	R1, #hi_addr(_vDebugPrint+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_PrintOut+0
ADD	SP, SP, #12
;uarthandler.c,328 :: 		vRF4463SetNode( NODE_FACTORY );
MOVS	R0, #254
BL	_vRF4463SetNode+0
;uarthandler.c,329 :: 		vRF4463TxMessage( NULL, NULL, NODE_FACTORY, TABLE_RF_TEST, RF_TEST_DONGLE_SEARCH );
MOVS	R1, #200
PUSH	(R1)
MOVS	R3, #1
MOVS	R2, #254
MOVS	R1, #0
MOVS	R0, #0
BL	_vRF4463TxMessage+0
ADD	SP, SP, #4
;uarthandler.c,330 :: 		break;
IT	AL
BAL	L_vUARTCommands13
;uarthandler.c,331 :: 		case UART_CMD_OVERRIDE:
L_vUARTCommands69:
;uarthandler.c,332 :: 		STM_LOGD( "[ UART ] Override\r\n", NULL );
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(?lstr_46_main+0)
MOVT	R2, #hi_addr(?lstr_46_main+0)
MOVW	R1, #lo_addr(_vDebugPrint+0)
MOVT	R1, #hi_addr(_vDebugPrint+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_PrintOut+0
ADD	SP, SP, #12
;uarthandler.c,333 :: 		break;
IT	AL
BAL	L_vUARTCommands13
;uarthandler.c,334 :: 		case UART_CMD_RESET_FTY:
L_vUARTCommands70:
;uarthandler.c,335 :: 		STM_LOGD( "[ UART ] Reset Factory\r\n", NULL );
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(?lstr_47_main+0)
MOVT	R2, #hi_addr(?lstr_47_main+0)
MOVW	R1, #lo_addr(_vDebugPrint+0)
MOVT	R1, #hi_addr(_vDebugPrint+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_PrintOut+0
ADD	SP, SP, #12
;uarthandler.c,336 :: 		break;
IT	AL
BAL	L_vUARTCommands13
;uarthandler.c,337 :: 		case UART_CMD_OVERRIDE_SET:
L_vUARTCommands71:
;uarthandler.c,338 :: 		STM_LOGD( "[ UART ] Set Override\r\n", NULL );
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(?lstr_48_main+0)
MOVT	R2, #hi_addr(?lstr_48_main+0)
MOVW	R1, #lo_addr(_vDebugPrint+0)
MOVT	R1, #hi_addr(_vDebugPrint+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_PrintOut+0
ADD	SP, SP, #12
;uarthandler.c,339 :: 		break;
IT	AL
BAL	L_vUARTCommands13
;uarthandler.c,340 :: 		case UART_CMD_DISCOVER:
L_vUARTCommands72:
;uarthandler.c,341 :: 		STM_LOGD( "[ UART ] Discover\r\n", NULL );
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(?lstr_49_main+0)
MOVT	R2, #hi_addr(?lstr_49_main+0)
MOVW	R1, #lo_addr(_vDebugPrint+0)
MOVT	R1, #hi_addr(_vDebugPrint+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_PrintOut+0
ADD	SP, SP, #12
;uarthandler.c,342 :: 		vRF4463SetNode( NODE_FACTORY );
MOVS	R0, #254
BL	_vRF4463SetNode+0
;uarthandler.c,343 :: 		vRF4463TxMessage( NULL, NULL, NODE_BROADCAST, TABLE_RF_SETUP, RF_SETUP_FTY_DISCOVER );
MOVS	R1, #11
PUSH	(R1)
MOVS	R3, #2
MOVS	R2, #255
MOVS	R1, #0
MOVS	R0, #0
BL	_vRF4463TxMessage+0
ADD	SP, SP, #4
;uarthandler.c,344 :: 		case UART_CMD_FIND:
L_vUARTCommands73:
;uarthandler.c,345 :: 		STM_LOGD( "[ UART ] Find in Channel\r\n", NULL );
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(?lstr_50_main+0)
MOVT	R2, #hi_addr(?lstr_50_main+0)
MOVW	R1, #lo_addr(_vDebugPrint+0)
MOVT	R1, #hi_addr(_vDebugPrint+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_PrintOut+0
ADD	SP, SP, #12
;uarthandler.c,346 :: 		vRF4463SetNode( HUB_NODE );
MOVS	R0, #1
BL	_vRF4463SetNode+0
;uarthandler.c,347 :: 		vRF4463TxMessage( NULL, NULL, NODE_BROADCAST, TABLE_RF_TEST, RF_TEST_CHANNEL );
MOVS	R1, #6
PUSH	(R1)
MOVS	R3, #1
MOVS	R2, #255
MOVS	R1, #0
MOVS	R0, #0
BL	_vRF4463TxMessage+0
ADD	SP, SP, #4
;uarthandler.c,348 :: 		break;
IT	AL
BAL	L_vUARTCommands13
;uarthandler.c,349 :: 		case UART_CMD_UNBLOCK:
L_vUARTCommands74:
;uarthandler.c,350 :: 		break;
IT	AL
BAL	L_vUARTCommands13
;uarthandler.c,351 :: 		case UART_CMD_SET_TX_POWER:
L_vUARTCommands75:
;uarthandler.c,352 :: 		STM_LOGI( "[ UART ] Set Tx Power\r\n", NULL );
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(?lstr_51_main+0)
MOVT	R2, #hi_addr(?lstr_51_main+0)
MOVW	R1, #lo_addr(_vDebugPrint+0)
MOVT	R1, #hi_addr(_vDebugPrint+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_PrintOut+0
ADD	SP, SP, #12
;uarthandler.c,353 :: 		memset( pcTempBuffer, '\0', 20 );
ADD	R1, SP, #8
MOVS	R2, #20
SXTH	R2, R2
MOV	R0, R1
MOVS	R1, #0
BL	_memset+0
;uarthandler.c,354 :: 		ucPosition = 9;
; ucPosition start address is: 12 (R3)
MOVS	R3, #9
;uarthandler.c,355 :: 		for( ucCounter = 0; ; ucCounter++ ){
; ucCounter start address is: 0 (R0)
MOVS	R0, #0
; ucCounter end address is: 0 (R0)
; ucPosition end address is: 12 (R3)
L_vUARTCommands76:
;uarthandler.c,356 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 12 (R3)
LDR	R1, [SP, #68]
ADDS	R1, R1, R3
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands342
LDR	R1, [SP, #68]
ADDS	R1, R1, R3
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands341
IT	AL
BAL	L_vUARTCommands81
; ucCounter end address is: 0 (R0)
; ucPosition end address is: 12 (R3)
L__vUARTCommands342:
L__vUARTCommands341:
;uarthandler.c,357 :: 		break;
IT	AL
BAL	L_vUARTCommands77
;uarthandler.c,358 :: 		}
L_vUARTCommands81:
;uarthandler.c,359 :: 		pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
; ucPosition start address is: 12 (R3)
; ucCounter start address is: 0 (R0)
ADD	R1, SP, #8
ADDS	R2, R1, R0
LDR	R1, [SP, #68]
ADDS	R1, R1, R3
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
ADDS	R2, R3, #1
UXTB	R2, R2
; ucPosition end address is: 12 (R3)
; ucPosition start address is: 8 (R2)
;uarthandler.c,355 :: 		for( ucCounter = 0; ; ucCounter++ ){
ADDS	R1, R0, #1
UXTB	R1, R1
; ucCounter end address is: 0 (R0)
; ucCounter start address is: 4 (R1)
;uarthandler.c,360 :: 		}
UXTB	R3, R2
; ucPosition end address is: 8 (R2)
; ucCounter end address is: 4 (R1)
UXTB	R0, R1
IT	AL
BAL	L_vUARTCommands76
L_vUARTCommands77:
;uarthandler.c,361 :: 		usTempData = atoi( pcTempBuffer );
ADD	R1, SP, #8
MOV	R0, R1
BL	_atoi+0
;uarthandler.c,362 :: 		ucRf4463SetTxPower( usTempData );
UXTB	R0, R0
BL	_ucRf4463SetTxPower+0
;uarthandler.c,363 :: 		break;
IT	AL
BAL	L_vUARTCommands13
;uarthandler.c,364 :: 		default:
L_vUARTCommands82:
;uarthandler.c,365 :: 		STM_LOGE( "Invalid Command\r\n", NULL );
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(?lstr_52_main+0)
MOVT	R2, #hi_addr(?lstr_52_main+0)
MOVW	R1, #lo_addr(_vDebugPrint+0)
MOVT	R1, #hi_addr(_vDebugPrint+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_PrintOut+0
ADD	SP, SP, #12
;uarthandler.c,366 :: 		break;
IT	AL
BAL	L_vUARTCommands13
;uarthandler.c,367 :: 		}
L_vUARTCommands12:
LDRB	R1, [SP, #72]
CMP	R1, #0
IT	EQ
BEQ	L_vUARTCommands14
LDRB	R1, [SP, #72]
CMP	R1, #1
IT	EQ
BEQ	L_vUARTCommands17
LDRB	R1, [SP, #72]
CMP	R1, #2
IT	EQ
BEQ	L_vUARTCommands24
LDRB	R1, [SP, #72]
CMP	R1, #3
IT	EQ
BEQ	L_vUARTCommands31
LDRB	R1, [SP, #72]
CMP	R1, #4
IT	EQ
BEQ	L_vUARTCommands32
LDRB	R1, [SP, #72]
CMP	R1, #5
IT	EQ
BEQ	L_vUARTCommands35
LDRB	R1, [SP, #72]
CMP	R1, #6
IT	EQ
BEQ	L_vUARTCommands36
LDRB	R1, [SP, #72]
CMP	R1, #7
IT	EQ
BEQ	L_vUARTCommands44
LDRB	R1, [SP, #72]
CMP	R1, #8
IT	EQ
BEQ	L_vUARTCommands51
LDRB	R1, [SP, #72]
CMP	R1, #11
IT	EQ
BEQ	L_vUARTCommands67
LDRB	R1, [SP, #72]
CMP	R1, #13
IT	EQ
BEQ	L_vUARTCommands68
LDRB	R1, [SP, #72]
CMP	R1, #14
IT	EQ
BEQ	L_vUARTCommands69
LDRB	R1, [SP, #72]
CMP	R1, #15
IT	EQ
BEQ	L_vUARTCommands70
LDRB	R1, [SP, #72]
CMP	R1, #16
IT	EQ
BEQ	L_vUARTCommands71
LDRB	R1, [SP, #72]
CMP	R1, #17
IT	EQ
BEQ	L_vUARTCommands72
LDRB	R1, [SP, #72]
CMP	R1, #18
IT	EQ
BEQ	L_vUARTCommands73
LDRB	R1, [SP, #72]
CMP	R1, #19
IT	EQ
BEQ	L_vUARTCommands74
LDRB	R1, [SP, #72]
CMP	R1, #20
IT	EQ
BEQ	L_vUARTCommands75
IT	AL
BAL	L_vUARTCommands82
L_vUARTCommands13:
;uarthandler.c,368 :: 		}
L_vUARTCommands11:
;uarthandler.c,153 :: 		for( ucCommandCounter = 0; ucCommandCounter < UART_Commands; ucCommandCounter++ ){
LDRB	R1, [SP, #72]
ADDS	R1, R1, #1
STRB	R1, [SP, #72]
;uarthandler.c,369 :: 		}
IT	AL
BAL	L_vUARTCommands8
L_vUARTCommands9:
;uarthandler.c,370 :: 		}
L_end_vUARTCommands:
LDR	LR, [SP, #0]
ADD	SP, SP, #84
BX	LR
; end of _vUARTCommands
_vDebugInit:
;debug.c,79 :: 		void vDebugInit(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;debug.c,80 :: 		UART1_Init_Advanced( 115200, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10 );
MOVW	R0, #lo_addr(__GPIO_MODULE_USART1_PA9_10+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_USART1_PA9_10+0)
PUSH	(R0)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
MOV	R0, #115200
BL	_UART1_Init_Advanced+0
ADD	SP, SP, #4
;debug.c,81 :: 		}
L_end_vDebugInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vDebugInit
_vDebugPrint:
;debug.c,89 :: 		void vDebugPrint( uint8_t ucPrintData ){
; ucPrintData start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; ucPrintData end address is: 0 (R0)
; ucPrintData start address is: 0 (R0)
;debug.c,90 :: 		UART1_Write( ucPrintData );
; ucPrintData end address is: 0 (R0)
BL	_UART1_Write+0
;debug.c,91 :: 		}
L_end_vDebugPrint:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vDebugPrint
_ucASCIIToByte:
;utils.c,41 :: 		uint8_t ucASCIIToByte( uint8_t * pcASCIIBuffer ){
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
BLS	L_ucASCIIToByte83
;utils.c,47 :: 		ucMSBNibble -= 7;
MOVW	R2, #lo_addr(_ucMSBNibble+0)
MOVT	R2, #hi_addr(_ucMSBNibble+0)
LDRB	R1, [R2, #0]
SUBS	R1, R1, #7
STRB	R1, [R2, #0]
;utils.c,48 :: 		}
L_ucASCIIToByte83:
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
BLS	L_ucASCIIToByte84
;utils.c,52 :: 		ucLSBNibble -= 7;
MOVW	R2, #lo_addr(_ucLSBNibble+0)
MOVT	R2, #hi_addr(_ucLSBNibble+0)
LDRB	R1, [R2, #0]
SUBS	R1, R1, #7
STRB	R1, [R2, #0]
;utils.c,53 :: 		}
L_ucASCIIToByte84:
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
;utils.c,61 :: 		void vASCIIToHex( uint8_t *pcHexConvertBuffer, uint8_t *pcASCIIConvertBuffer, uint8_t ucConversionLength ){
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
;utils.c,62 :: 		uint8_t ucASCIICounter = 0;
;utils.c,64 :: 		for( ucASCIICounter = 0; ucASCIICounter < ucConversionLength; ucASCIICounter++ ){
; ucASCIICounter start address is: 24 (R6)
MOVS	R6, #0
; pcHexConvertBuffer end address is: 0 (R0)
; ucConversionLength end address is: 8 (R2)
; ucASCIICounter end address is: 24 (R6)
STRB	R2, [SP, #0]
MOV	R2, R0
LDRB	R0, [SP, #0]
L_vASCIIToHex85:
; ucASCIICounter start address is: 24 (R6)
; pcHexConvertBuffer start address is: 8 (R2)
; ucConversionLength start address is: 0 (R0)
; pcASCIIConvertBuffer start address is: 4 (R1)
; pcASCIIConvertBuffer end address is: 4 (R1)
; pcHexConvertBuffer start address is: 8 (R2)
; pcHexConvertBuffer end address is: 8 (R2)
CMP	R6, R0
IT	CS
BCS	L_vASCIIToHex86
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
BLS	L_vASCIIToHex88
;utils.c,70 :: 		ucMSBNibble -= 7;
MOVW	R4, #lo_addr(_ucMSBNibble+0)
MOVT	R4, #hi_addr(_ucMSBNibble+0)
LDRB	R3, [R4, #0]
SUBS	R3, R3, #7
STRB	R3, [R4, #0]
;utils.c,71 :: 		}
L_vASCIIToHex88:
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
BLS	L_vASCIIToHex89
;utils.c,75 :: 		ucLSBNibble -= 7;
MOVW	R4, #lo_addr(_ucLSBNibble+0)
MOVT	R4, #hi_addr(_ucLSBNibble+0)
LDRB	R3, [R4, #0]
SUBS	R3, R3, #7
STRB	R3, [R4, #0]
;utils.c,76 :: 		}
L_vASCIIToHex89:
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
BAL	L_vASCIIToHex85
L_vASCIIToHex86:
;utils.c,80 :: 		}
L_end_vASCIIToHex:
ADD	SP, SP, #4
BX	LR
; end of _vASCIIToHex
_vHexToASCII:
;utils.c,85 :: 		void vHexToASCII( uint8_t *pcASCIIConvertBuffer, uint8_t *pcHexConvertBuffer, uint8_t ucConversionLength ){
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
;utils.c,86 :: 		uint8_t ucHexConvCounter = 0;
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
L_vHexToASCII90:
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
BCS	L_vHexToASCII91
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
BAL	L_vHexToASCII90
L_vHexToASCII91:
;utils.c,92 :: 		}
L_end_vHexToASCII:
ADD	SP, SP, #4
BX	LR
; end of _vHexToASCII
_vBufferSetToZero:
;utils.c,97 :: 		void vBufferSetToZero( uint8_t * pcBufferToClean, uint16_t uslength ){
; uslength start address is: 4 (R1)
; pcBufferToClean start address is: 0 (R0)
SUB	SP, SP, #4
; uslength end address is: 4 (R1)
; pcBufferToClean end address is: 0 (R0)
; pcBufferToClean start address is: 0 (R0)
; uslength start address is: 4 (R1)
;utils.c,98 :: 		uint16_t usPosition = 0;
;utils.c,100 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
; usPosition start address is: 16 (R4)
MOVS	R4, #0
; pcBufferToClean end address is: 0 (R0)
; uslength end address is: 4 (R1)
; usPosition end address is: 16 (R4)
STRH	R1, [SP, #0]
MOV	R1, R0
LDRH	R0, [SP, #0]
L_vBufferSetToZero93:
; usPosition start address is: 16 (R4)
; pcBufferToClean start address is: 4 (R1)
; uslength start address is: 0 (R0)
; pcBufferToClean start address is: 4 (R1)
; pcBufferToClean end address is: 4 (R1)
CMP	R4, R0
IT	CS
BCS	L_vBufferSetToZero94
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
BAL	L_vBufferSetToZero93
L_vBufferSetToZero94:
;utils.c,103 :: 		}
L_end_vBufferSetToZero:
ADD	SP, SP, #4
BX	LR
; end of _vBufferSetToZero
_vBufferSetTo255:
;utils.c,108 :: 		void vBufferSetTo255( uint8_t * pcBufferToClean, uint16_t uslength ){
; uslength start address is: 4 (R1)
; pcBufferToClean start address is: 0 (R0)
SUB	SP, SP, #4
; uslength end address is: 4 (R1)
; pcBufferToClean end address is: 0 (R0)
; pcBufferToClean start address is: 0 (R0)
; uslength start address is: 4 (R1)
;utils.c,109 :: 		uint16_t usPosition = 0;
;utils.c,111 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
; usPosition start address is: 16 (R4)
MOVS	R4, #0
; pcBufferToClean end address is: 0 (R0)
; uslength end address is: 4 (R1)
; usPosition end address is: 16 (R4)
STRH	R1, [SP, #0]
MOV	R1, R0
LDRH	R0, [SP, #0]
L_vBufferSetTo25596:
; usPosition start address is: 16 (R4)
; pcBufferToClean start address is: 4 (R1)
; uslength start address is: 0 (R0)
; pcBufferToClean start address is: 4 (R1)
; pcBufferToClean end address is: 4 (R1)
CMP	R4, R0
IT	CS
BCS	L_vBufferSetTo25597
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
BAL	L_vBufferSetTo25596
L_vBufferSetTo25597:
;utils.c,114 :: 		}
L_end_vBufferSetTo255:
ADD	SP, SP, #4
BX	LR
; end of _vBufferSetTo255
_vBufferSetToValue:
;utils.c,119 :: 		void vBufferSetToValue( uint8_t * pcBufferToClean, uint8_t ucValue, uint16_t uslength ){
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
;utils.c,120 :: 		uint16_t usPosition = 0;
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
L_vBufferSetToValue99:
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
BCS	L_vBufferSetToValue100
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
BAL	L_vBufferSetToValue99
L_vBufferSetToValue100:
;utils.c,125 :: 		}
L_end_vBufferSetToValue:
ADD	SP, SP, #4
BX	LR
; end of _vBufferSetToValue
_vSerializeUUID:
;utils.c,130 :: 		void vSerializeUUID( uint8_t * pcTextConvertBuffer, uint8_t * pcHexConvertBuffer ){
; pcHexConvertBuffer start address is: 4 (R1)
; pcTextConvertBuffer start address is: 0 (R0)
SUB	SP, SP, #4
; pcHexConvertBuffer end address is: 4 (R1)
; pcTextConvertBuffer end address is: 0 (R0)
; pcTextConvertBuffer start address is: 0 (R0)
; pcHexConvertBuffer start address is: 4 (R1)
;utils.c,131 :: 		uint8_t ucCounter = 0;
;utils.c,133 :: 		for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
; ucCounter start address is: 20 (R5)
MOVS	R5, #0
; pcTextConvertBuffer end address is: 0 (R0)
; pcHexConvertBuffer end address is: 4 (R1)
; ucCounter end address is: 20 (R5)
STR	R1, [SP, #0]
MOV	R1, R0
LDR	R0, [SP, #0]
L_vSerializeUUID102:
; ucCounter start address is: 20 (R5)
; pcTextConvertBuffer start address is: 4 (R1)
; pcHexConvertBuffer start address is: 0 (R0)
; pcHexConvertBuffer start address is: 0 (R0)
; pcHexConvertBuffer end address is: 0 (R0)
; pcTextConvertBuffer start address is: 4 (R1)
; pcTextConvertBuffer end address is: 4 (R1)
CMP	R5, #12
IT	CS
BCS	L_vSerializeUUID103
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
BAL	L_vSerializeUUID102
L_vSerializeUUID103:
;utils.c,137 :: 		}
L_end_vSerializeUUID:
ADD	SP, SP, #4
BX	LR
; end of _vSerializeUUID
_vSerializeMACAddress:
;utils.c,142 :: 		void vSerializeMACAddress( uint8_t * pcTextConvertBuffer, uint8_t * pcHexConvertBuffer ){
; pcHexConvertBuffer start address is: 4 (R1)
; pcTextConvertBuffer start address is: 0 (R0)
SUB	SP, SP, #16
STR	LR, [SP, #0]
MOV	R7, R0
; pcHexConvertBuffer end address is: 4 (R1)
; pcTextConvertBuffer end address is: 0 (R0)
; pcTextConvertBuffer start address is: 28 (R7)
; pcHexConvertBuffer start address is: 4 (R1)
;utils.c,143 :: 		uint16_t usCounter = 0;
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
L_vSerializeMACAddress105:
; usCounter start address is: 4 (R1)
; pcTextConvertBuffer start address is: 0 (R0)
CMP	R1, #6
IT	CS
BCS	L_vSerializeMACAddress106
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
BEQ	L_vSerializeMACAddress108
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
L_vSerializeMACAddress108:
;utils.c,148 :: 		for( usCounter = 0; usCounter < 6; usCounter++ ){
ADDS	R1, R1, #1
UXTH	R1, R1
;utils.c,154 :: 		}
; usCounter end address is: 4 (R1)
IT	AL
BAL	L_vSerializeMACAddress105
L_vSerializeMACAddress106:
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
;utils.c,161 :: 		void vSerializeIPAddress( uint8_t * pcTextConvertBuffer, uint8_t * pcHexConvertBuffer ){
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
;utils.c,162 :: 		uint8_t ucCounter = 0;
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
L_vSerializeIPAddress109:
; ucCounter start address is: 28 (R7)
; pcHexConvertBuffer start address is: 24 (R6)
; pcHexConvertBuffer end address is: 24 (R6)
; pcTextConvertBuffer start address is: 32 (R8)
; pcTextConvertBuffer end address is: 32 (R8)
CMP	R7, #4
IT	CS
BCS	L_vSerializeIPAddress110
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
BEQ	L_vSerializeIPAddress112
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
L_vSerializeIPAddress112:
;utils.c,167 :: 		for( ucCounter = 0; ucCounter < 4; ucCounter++ ){
ADDS	R7, R7, #1
UXTB	R7, R7
;utils.c,176 :: 		}
; pcHexConvertBuffer end address is: 24 (R6)
; pcTextConvertBuffer end address is: 32 (R8)
; ucCounter end address is: 28 (R7)
IT	AL
BAL	L_vSerializeIPAddress109
L_vSerializeIPAddress110:
;utils.c,177 :: 		}
L_end_vSerializeIPAddress:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _vSerializeIPAddress
_vXORRFMessage:
;xorcipher.c,49 :: 		void vXORRFMessage( uint8_t * pcBuffer, uint8_t * pcXORBuffer, uint8_t ucBufferSize ){
; ucBufferSize start address is: 8 (R2)
; pcXORBuffer start address is: 4 (R1)
; pcBuffer start address is: 0 (R0)
SUB	SP, SP, #4
UXTB	R3, R2
MOV	R2, R1
MOV	R1, R0
; ucBufferSize end address is: 8 (R2)
; pcXORBuffer end address is: 4 (R1)
; pcBuffer end address is: 0 (R0)
; pcBuffer start address is: 4 (R1)
; pcXORBuffer start address is: 8 (R2)
; ucBufferSize start address is: 12 (R3)
;xorcipher.c,50 :: 		uint8_t ucKeyPosition = 0;
; ucKeyPosition start address is: 28 (R7)
MOVS	R7, #0
;xorcipher.c,51 :: 		uint8_t ucBufferPosition = 0;
;xorcipher.c,53 :: 		for( ucBufferPosition = 0; ucBufferPosition < ucBufferSize; ucBufferPosition++ ){
; ucBufferPosition start address is: 0 (R0)
MOVS	R0, #0
; pcBuffer end address is: 4 (R1)
; pcXORBuffer end address is: 8 (R2)
; ucBufferSize end address is: 12 (R3)
; ucBufferPosition end address is: 0 (R0)
; ucKeyPosition end address is: 28 (R7)
STR	R2, [SP, #0]
MOV	R2, R1
UXTB	R6, R0
UXTB	R0, R3
LDR	R1, [SP, #0]
L_vXORRFMessage113:
; ucBufferPosition start address is: 24 (R6)
; pcBuffer start address is: 8 (R2)
; pcXORBuffer start address is: 4 (R1)
; ucKeyPosition start address is: 28 (R7)
; ucBufferSize start address is: 0 (R0)
; pcXORBuffer start address is: 4 (R1)
; pcXORBuffer end address is: 4 (R1)
; pcBuffer start address is: 8 (R2)
; pcBuffer end address is: 8 (R2)
CMP	R6, R0
IT	CS
BCS	L_vXORRFMessage114
; pcXORBuffer end address is: 4 (R1)
; pcBuffer end address is: 8 (R2)
;xorcipher.c,54 :: 		pcXORBuffer[ ucBufferPosition ] = pcBuffer[ ucBufferPosition ] ^ pcXORRFKey[ ucKeyPosition++ ];
; pcBuffer start address is: 8 (R2)
; pcXORBuffer start address is: 4 (R1)
ADDS	R5, R1, R6
ADDS	R3, R2, R6
LDRB	R4, [R3, #0]
MOVW	R3, #lo_addr(_pcXORRFKey+0)
MOVT	R3, #hi_addr(_pcXORRFKey+0)
ADDS	R3, R3, R7
LDRB	R3, [R3, #0]
EOR	R3, R4, R3, LSL #0
STRB	R3, [R5, #0]
ADDS	R7, R7, #1
UXTB	R7, R7
;xorcipher.c,53 :: 		for( ucBufferPosition = 0; ucBufferPosition < ucBufferSize; ucBufferPosition++ ){
ADDS	R6, R6, #1
UXTB	R6, R6
;xorcipher.c,55 :: 		}
; ucBufferSize end address is: 0 (R0)
; pcXORBuffer end address is: 4 (R1)
; pcBuffer end address is: 8 (R2)
; ucKeyPosition end address is: 28 (R7)
; ucBufferPosition end address is: 24 (R6)
IT	AL
BAL	L_vXORRFMessage113
L_vXORRFMessage114:
;xorcipher.c,56 :: 		}
L_end_vXORRFMessage:
ADD	SP, SP, #4
BX	LR
; end of _vXORRFMessage
_vW25Q128JVInit:
;flashw25q128jv.c,43 :: 		void vW25Q128JVInit( ){
;flashw25q128jv.c,44 :: 		FlashCS = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
_SX	[R0, ByteOffset(GPIOA_ODR+0)]
;flashw25q128jv.c,45 :: 		}
L_end_vW25Q128JVInit:
BX	LR
; end of _vW25Q128JVInit
_vFlashWriteEnable:
;flashw25q128jv.c,50 :: 		void vFlashWriteEnable( uint8_t ucMemorySelected ){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;flashw25q128jv.c,51 :: 		FlashCS = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
_SX	[R1, ByteOffset(GPIOA_ODR+0)]
;flashw25q128jv.c,52 :: 		SPI1_Write( _SERIAL_FLASH_CMD_WREN );
MOVS	R0, #6
BL	_SPI1_Write+0
;flashw25q128jv.c,53 :: 		FlashCS = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
_SX	[R1, ByteOffset(GPIOA_ODR+0)]
;flashw25q128jv.c,54 :: 		}
L_end_vFlashWriteEnable:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vFlashWriteEnable
_ucFlashIsWriteBusy:
;flashw25q128jv.c,59 :: 		uint8_t ucFlashIsWriteBusy( uint8_t ucMemorySelected ){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;flashw25q128jv.c,60 :: 		uint8_t ucTemp = 0;
;flashw25q128jv.c,62 :: 		FlashCS = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
_SX	[R1, ByteOffset(GPIOA_ODR+0)]
;flashw25q128jv.c,63 :: 		SPI1_Write( _SERIAL_FLASH_CMD_RDSR );
MOVS	R0, #5
BL	_SPI1_Write+0
;flashw25q128jv.c,64 :: 		ucTemp = SPI1_Read( 0 );
MOVS	R0, #0
BL	_SPI1_Read+0
;flashw25q128jv.c,65 :: 		FlashCS = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
_SX	[R1, ByteOffset(GPIOA_ODR+0)]
;flashw25q128jv.c,67 :: 		return ( ucTemp & 0x01 );
UXTB	R1, R0
AND	R1, R1, #1
UXTB	R0, R1
;flashw25q128jv.c,68 :: 		}
L_end_ucFlashIsWriteBusy:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ucFlashIsWriteBusy
_vFlashWriteByte:
;flashw25q128jv.c,73 :: 		void vFlashWriteByte( uint8_t ucMemorySelected, uint8_t pcData, uint32_t ulMemoryAddress ){
; pcData start address is: 4 (R1)
; ucMemorySelected start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
UXTB	R5, R0
UXTB	R6, R1
STR	R2, [SP, #4]
; pcData end address is: 4 (R1)
; ucMemorySelected end address is: 0 (R0)
; ucMemorySelected start address is: 20 (R5)
; pcData start address is: 24 (R6)
;flashw25q128jv.c,74 :: 		vFlashWriteEnable( ucMemorySelected );
UXTB	R0, R5
BL	_vFlashWriteEnable+0
;flashw25q128jv.c,76 :: 		FlashCS = 0;
MOVS	R4, #0
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOA_ODR+0)
MOVT	R3, #hi_addr(GPIOA_ODR+0)
_SX	[R3, ByteOffset(GPIOA_ODR+0)]
;flashw25q128jv.c,77 :: 		SPI1_Write( _SERIAL_FLASH_CMD_WRITE );
MOVS	R0, #2
BL	_SPI1_Write+0
;flashw25q128jv.c,78 :: 		SPI1_Write( Higher( ulMemoryAddress ) );
ADD	R3, SP, #4
ADDS	R3, R3, #2
LDRB	R3, [R3, #0]
UXTH	R0, R3
BL	_SPI1_Write+0
;flashw25q128jv.c,79 :: 		SPI1_Write( Hi( ulMemoryAddress ) );
ADD	R3, SP, #4
ADDS	R3, R3, #1
LDRB	R3, [R3, #0]
UXTH	R0, R3
BL	_SPI1_Write+0
;flashw25q128jv.c,80 :: 		SPI1_Write( Lo( ulMemoryAddress ) );
ADD	R3, SP, #4
LDRB	R3, [R3, #0]
UXTH	R0, R3
BL	_SPI1_Write+0
;flashw25q128jv.c,81 :: 		SPI1_Write( pcData );
UXTB	R0, R6
; pcData end address is: 24 (R6)
BL	_SPI1_Write+0
;flashw25q128jv.c,82 :: 		FlashCS = 1;
MOVS	R4, #1
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOA_ODR+0)
MOVT	R3, #hi_addr(GPIOA_ODR+0)
_SX	[R3, ByteOffset(GPIOA_ODR+0)]
; ucMemorySelected end address is: 20 (R5)
UXTB	R4, R5
;flashw25q128jv.c,84 :: 		while( ucFlashIsWriteBusy( ucMemorySelected ) );
L_vFlashWriteByte116:
; ucMemorySelected start address is: 16 (R4)
UXTB	R0, R4
BL	_ucFlashIsWriteBusy+0
CMP	R0, #0
IT	EQ
BEQ	L_vFlashWriteByte117
; ucMemorySelected end address is: 16 (R4)
IT	AL
BAL	L_vFlashWriteByte116
L_vFlashWriteByte117:
;flashw25q128jv.c,85 :: 		}
L_end_vFlashWriteByte:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vFlashWriteByte
_vFlashWriteWord:
;flashw25q128jv.c,90 :: 		void vFlashWriteWord( uint8_t ucMemorySelected, uint16_t pcData, uint32_t ulMemoryAddress ){
; ulMemoryAddress start address is: 8 (R2)
; ucMemorySelected start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
UXTB	R7, R0
STRH	R1, [SP, #4]
MOV	R8, R2
; ulMemoryAddress end address is: 8 (R2)
; ucMemorySelected end address is: 0 (R0)
; ucMemorySelected start address is: 28 (R7)
; ulMemoryAddress start address is: 32 (R8)
;flashw25q128jv.c,91 :: 		vFlashWriteByte( ucMemorySelected, Hi( pcData ), ulMemoryAddress );
ADD	R3, SP, #4
ADDS	R3, R3, #1
LDRB	R3, [R3, #0]
MOV	R2, R8
UXTB	R1, R3
UXTB	R0, R7
BL	_vFlashWriteByte+0
;flashw25q128jv.c,92 :: 		vFlashWriteByte( ucMemorySelected, Lo( pcData ), ulMemoryAddress + 1 );
ADD	R4, R8, #1
; ulMemoryAddress end address is: 32 (R8)
ADD	R3, SP, #4
LDRB	R3, [R3, #0]
MOV	R2, R4
UXTB	R1, R3
UXTB	R0, R7
; ucMemorySelected end address is: 28 (R7)
BL	_vFlashWriteByte+0
;flashw25q128jv.c,93 :: 		}
L_end_vFlashWriteWord:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vFlashWriteWord
_ucFlashWriteArray:
;flashw25q128jv.c,98 :: 		uint8_t ucFlashWriteArray( uint8_t ucMemorySelected, uint8_t * pcData, uint16_t usBufferLength, const uint32_t ulMemoryAddress ){
; ulMemoryAddress start address is: 12 (R3)
; usBufferLength start address is: 8 (R2)
; pcData start address is: 4 (R1)
; ucMemorySelected start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; ulMemoryAddress end address is: 12 (R3)
; usBufferLength end address is: 8 (R2)
; pcData end address is: 4 (R1)
; ucMemorySelected end address is: 0 (R0)
; ucMemorySelected start address is: 0 (R0)
; pcData start address is: 4 (R1)
; usBufferLength start address is: 8 (R2)
; ulMemoryAddress start address is: 12 (R3)
;flashw25q128jv.c,99 :: 		uint32_t ulFlashAddress = 0;
;flashw25q128jv.c,100 :: 		uint16_t usBufferCounter = 0;
;flashw25q128jv.c,101 :: 		uint8_t ucTempValue = 0;
;flashw25q128jv.c,103 :: 		ulFlashAddress = ulMemoryAddress;
; ulFlashAddress start address is: 48 (R12)
MOV	R12, R3
;flashw25q128jv.c,105 :: 		for( usBufferCounter = 0; usBufferCounter < usBufferLength; usBufferCounter++ ){
; usBufferCounter start address is: 44 (R11)
MOVW	R11, #0
; ucMemorySelected end address is: 0 (R0)
; pcData end address is: 4 (R1)
; usBufferLength end address is: 8 (R2)
; ulMemoryAddress end address is: 12 (R3)
; ulFlashAddress end address is: 48 (R12)
; usBufferCounter end address is: 44 (R11)
UXTB	R9, R0
MOV	R8, R1
UXTH	R7, R2
MOV	R10, R3
L_ucFlashWriteArray118:
; usBufferCounter start address is: 44 (R11)
; ulFlashAddress start address is: 48 (R12)
; ulMemoryAddress start address is: 40 (R10)
; usBufferLength start address is: 28 (R7)
; pcData start address is: 32 (R8)
; ucMemorySelected start address is: 36 (R9)
CMP	R11, R7
IT	CS
BCS	L_ucFlashWriteArray119
;flashw25q128jv.c,106 :: 		vFlashWriteByte( ucMemorySelected, pcData[ usBufferCounter ], ulFlashAddress );
ADD	R4, R8, R11, LSL #0
LDRB	R4, [R4, #0]
MOV	R2, R12
UXTB	R1, R4
UXTB	R0, R9
BL	_vFlashWriteByte+0
;flashw25q128jv.c,107 :: 		ulFlashAddress++;
ADD	R12, R12, #1
;flashw25q128jv.c,105 :: 		for( usBufferCounter = 0; usBufferCounter < usBufferLength; usBufferCounter++ ){
ADD	R11, R11, #1
UXTH	R11, R11
;flashw25q128jv.c,108 :: 		}
; ulFlashAddress end address is: 48 (R12)
; usBufferCounter end address is: 44 (R11)
IT	AL
BAL	L_ucFlashWriteArray118
L_ucFlashWriteArray119:
;flashw25q128jv.c,109 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;flashw25q128jv.c,110 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;flashw25q128jv.c,112 :: 		ulFlashAddress = ulMemoryAddress;
; ulFlashAddress start address is: 0 (R0)
MOV	R0, R10
; ulMemoryAddress end address is: 40 (R10)
;flashw25q128jv.c,114 :: 		for( usBufferCounter = 0; usBufferCounter < usBufferLength; usBufferCounter++ ){
; usBufferCounter start address is: 4 (R1)
MOVS	R1, #0
; pcData end address is: 32 (R8)
; ucMemorySelected end address is: 36 (R9)
; ulFlashAddress end address is: 0 (R0)
; usBufferCounter end address is: 4 (R1)
; usBufferLength end address is: 28 (R7)
MOV	R6, R8
UXTH	R8, R1
UXTB	R5, R9
MOV	R9, R0
L_ucFlashWriteArray121:
; usBufferCounter start address is: 32 (R8)
; pcData start address is: 24 (R6)
; ucMemorySelected start address is: 20 (R5)
; ulFlashAddress start address is: 36 (R9)
; ucMemorySelected start address is: 20 (R5)
; ucMemorySelected end address is: 20 (R5)
; pcData start address is: 24 (R6)
; pcData end address is: 24 (R6)
; usBufferLength start address is: 28 (R7)
CMP	R8, R7
IT	CS
BCS	L_ucFlashWriteArray122
; ucMemorySelected end address is: 20 (R5)
; pcData end address is: 24 (R6)
;flashw25q128jv.c,116 :: 		ucTempValue = ucFlashReadByte( ucMemorySelected, ulFlashAddress );
; pcData start address is: 24 (R6)
; ucMemorySelected start address is: 20 (R5)
MOV	R1, R9
UXTB	R0, R5
BL	_ucFlashReadByte+0
;flashw25q128jv.c,117 :: 		if( pcData[ usBufferCounter ] != ucTempValue ){
ADD	R4, R6, R8, LSL #0
LDRB	R4, [R4, #0]
CMP	R4, R0
IT	EQ
BEQ	L_ucFlashWriteArray124
; ucMemorySelected end address is: 20 (R5)
; pcData end address is: 24 (R6)
; usBufferLength end address is: 28 (R7)
; ulFlashAddress end address is: 36 (R9)
; usBufferCounter end address is: 32 (R8)
;flashw25q128jv.c,118 :: 		return 0;
MOVS	R0, #0
IT	AL
BAL	L_end_ucFlashWriteArray
;flashw25q128jv.c,119 :: 		}
L_ucFlashWriteArray124:
;flashw25q128jv.c,120 :: 		ulFlashAddress++;
; usBufferCounter start address is: 32 (R8)
; ulFlashAddress start address is: 36 (R9)
; usBufferLength start address is: 28 (R7)
; pcData start address is: 24 (R6)
; ucMemorySelected start address is: 20 (R5)
ADD	R9, R9, #1
;flashw25q128jv.c,114 :: 		for( usBufferCounter = 0; usBufferCounter < usBufferLength; usBufferCounter++ ){
ADD	R8, R8, #1
UXTH	R8, R8
;flashw25q128jv.c,121 :: 		}
; ucMemorySelected end address is: 20 (R5)
; pcData end address is: 24 (R6)
; usBufferLength end address is: 28 (R7)
; ulFlashAddress end address is: 36 (R9)
; usBufferCounter end address is: 32 (R8)
IT	AL
BAL	L_ucFlashWriteArray121
L_ucFlashWriteArray122:
;flashw25q128jv.c,122 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;flashw25q128jv.c,123 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;flashw25q128jv.c,125 :: 		return 1;
MOVS	R0, #1
;flashw25q128jv.c,126 :: 		}
L_end_ucFlashWriteArray:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ucFlashWriteArray
_ucFlashReadByte:
;flashw25q128jv.c,131 :: 		uint8_t ucFlashReadByte( uint8_t ucMemorySelected, uint32_t ulMemoryAddress ){
SUB	SP, SP, #8
STR	LR, [SP, #0]
STR	R1, [SP, #4]
;flashw25q128jv.c,132 :: 		uint8_t ucTemp = 0;
;flashw25q128jv.c,134 :: 		FlashCS = 0;
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOA_ODR+0)
MOVT	R2, #hi_addr(GPIOA_ODR+0)
_SX	[R2, ByteOffset(GPIOA_ODR+0)]
;flashw25q128jv.c,135 :: 		SPI1_Write( _SERIAL_FLASH_CMD_READ );
MOVS	R0, #3
BL	_SPI1_Write+0
;flashw25q128jv.c,136 :: 		SPI1_Write( Higher( ulMemoryAddress ) );
ADD	R2, SP, #4
ADDS	R2, R2, #2
LDRB	R2, [R2, #0]
UXTH	R0, R2
BL	_SPI1_Write+0
;flashw25q128jv.c,137 :: 		SPI1_Write( Hi( ulMemoryAddress ) );
ADD	R2, SP, #4
ADDS	R2, R2, #1
LDRB	R2, [R2, #0]
UXTH	R0, R2
BL	_SPI1_Write+0
;flashw25q128jv.c,138 :: 		SPI1_Write( Lo( ulMemoryAddress ) );
ADD	R2, SP, #4
LDRB	R2, [R2, #0]
UXTH	R0, R2
BL	_SPI1_Write+0
;flashw25q128jv.c,139 :: 		ucTemp = SPI1_Read( 0 );
MOVS	R0, #0
BL	_SPI1_Read+0
;flashw25q128jv.c,140 :: 		FlashCS = 1;
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOA_ODR+0)
MOVT	R2, #hi_addr(GPIOA_ODR+0)
_SX	[R2, ByteOffset(GPIOA_ODR+0)]
;flashw25q128jv.c,142 :: 		return ucTemp;
UXTB	R0, R0
;flashw25q128jv.c,143 :: 		}
L_end_ucFlashReadByte:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucFlashReadByte
_usFlashReadWord:
;flashw25q128jv.c,148 :: 		uint16_t usFlashReadWord( uint8_t ucMemorySelected, uint32_t ulMemoryAddress ){
; ulMemoryAddress start address is: 4 (R1)
; ucMemorySelected start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
UXTB	R4, R0
MOV	R5, R1
; ulMemoryAddress end address is: 4 (R1)
; ucMemorySelected end address is: 0 (R0)
; ucMemorySelected start address is: 16 (R4)
; ulMemoryAddress start address is: 20 (R5)
;flashw25q128jv.c,149 :: 		uint16_t usTemp = 0;
MOVW	R2, #0
STRH	R2, [SP, #4]
;flashw25q128jv.c,151 :: 		Hi( usTemp ) = ucFlashReadByte( ucMemorySelected, ulMemoryAddress );
ADD	R2, SP, #4
ADDS	R2, R2, #1
STR	R2, [SP, #8]
MOV	R1, R5
UXTB	R0, R4
BL	_ucFlashReadByte+0
LDR	R2, [SP, #8]
STRB	R0, [R2, #0]
;flashw25q128jv.c,152 :: 		Lo( usTemp ) = ucFlashReadByte( ucMemorySelected, ulMemoryAddress + 1 );
ADD	R2, SP, #4
STR	R2, [SP, #8]
ADDS	R2, R5, #1
; ulMemoryAddress end address is: 20 (R5)
MOV	R1, R2
UXTB	R0, R4
; ucMemorySelected end address is: 16 (R4)
BL	_ucFlashReadByte+0
LDR	R2, [SP, #8]
STRB	R0, [R2, #0]
;flashw25q128jv.c,154 :: 		return usTemp;
LDRH	R0, [SP, #4]
;flashw25q128jv.c,155 :: 		}
L_end_usFlashReadWord:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _usFlashReadWord
_vFlashReadArray:
;flashw25q128jv.c,160 :: 		void vFlashReadArray( uint8_t ucMemorySelected, uint8_t * pcReceiverBuffer, uint16_t usBufferLength, uint32_t ulMemoryAddress ){
; usBufferLength start address is: 8 (R2)
; pcReceiverBuffer start address is: 4 (R1)
SUB	SP, SP, #8
STR	LR, [SP, #0]
MOV	R6, R1
UXTH	R7, R2
STR	R3, [SP, #4]
; usBufferLength end address is: 8 (R2)
; pcReceiverBuffer end address is: 4 (R1)
; pcReceiverBuffer start address is: 24 (R6)
; usBufferLength start address is: 28 (R7)
;flashw25q128jv.c,161 :: 		FlashCS = 0;
MOVS	R5, #0
SXTB	R5, R5
MOVW	R4, #lo_addr(GPIOA_ODR+0)
MOVT	R4, #hi_addr(GPIOA_ODR+0)
_SX	[R4, ByteOffset(GPIOA_ODR+0)]
;flashw25q128jv.c,163 :: 		SPI1_Write( _SERIAL_FLASH_CMD_READ );
MOVS	R0, #3
BL	_SPI1_Write+0
;flashw25q128jv.c,164 :: 		SPI1_Write( Higher( ulMemoryAddress ) );
ADD	R4, SP, #4
ADDS	R4, R4, #2
LDRB	R4, [R4, #0]
UXTH	R0, R4
BL	_SPI1_Write+0
;flashw25q128jv.c,165 :: 		SPI1_Write( Hi( ulMemoryAddress ) );
ADD	R4, SP, #4
ADDS	R4, R4, #1
LDRB	R4, [R4, #0]
UXTH	R0, R4
BL	_SPI1_Write+0
;flashw25q128jv.c,166 :: 		SPI1_Write( Lo( ulMemoryAddress ) );
ADD	R4, SP, #4
LDRB	R4, [R4, #0]
UXTH	R0, R4
BL	_SPI1_Write+0
; pcReceiverBuffer end address is: 24 (R6)
; usBufferLength end address is: 28 (R7)
UXTH	R0, R7
MOV	R7, R6
;flashw25q128jv.c,168 :: 		while( usBufferLength-- ){
L_vFlashReadArray125:
; usBufferLength start address is: 24 (R6)
; usBufferLength start address is: 0 (R0)
; pcReceiverBuffer start address is: 28 (R7)
UXTH	R5, R0
SUBS	R4, R0, #1
; usBufferLength end address is: 0 (R0)
; usBufferLength start address is: 24 (R6)
UXTH	R6, R4
; usBufferLength end address is: 24 (R6)
CMP	R5, #0
IT	EQ
BEQ	L_vFlashReadArray126
; usBufferLength end address is: 24 (R6)
;flashw25q128jv.c,169 :: 		*pcReceiverBuffer++ = SPI1_Read( 0 );
; usBufferLength start address is: 24 (R6)
MOVS	R0, #0
BL	_SPI1_Read+0
STRB	R0, [R7, #0]
ADDS	R7, R7, #1
;flashw25q128jv.c,170 :: 		}
; usBufferLength end address is: 24 (R6)
; pcReceiverBuffer end address is: 28 (R7)
UXTH	R0, R6
IT	AL
BAL	L_vFlashReadArray125
L_vFlashReadArray126:
;flashw25q128jv.c,172 :: 		FlashCS = 1;
MOVS	R5, #1
SXTB	R5, R5
MOVW	R4, #lo_addr(GPIOA_ODR+0)
MOVT	R4, #hi_addr(GPIOA_ODR+0)
_SX	[R4, ByteOffset(GPIOA_ODR+0)]
;flashw25q128jv.c,173 :: 		}
L_end_vFlashReadArray:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vFlashReadArray
_ucFlashReadId:
;flashw25q128jv.c,178 :: 		uint8_t ucFlashReadId( uint8_t ucMemorySelected ){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;flashw25q128jv.c,179 :: 		uint8_t ucTemp = 0;
;flashw25q128jv.c,181 :: 		FlashCS = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
_SX	[R1, ByteOffset(GPIOA_ODR+0)]
;flashw25q128jv.c,183 :: 		SPI1_Write( _SERIAL_FLASH_CMD_RDID );
MOVS	R0, #159
BL	_SPI1_Write+0
;flashw25q128jv.c,184 :: 		ucTemp = SPI1_Read( 0 );
MOVS	R0, #0
BL	_SPI1_Read+0
;flashw25q128jv.c,186 :: 		FlashCS = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
_SX	[R1, ByteOffset(GPIOA_ODR+0)]
;flashw25q128jv.c,188 :: 		return ucTemp;
UXTB	R0, R0
;flashw25q128jv.c,189 :: 		}
L_end_ucFlashReadId:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ucFlashReadId
_vFlashResetWriteProtection:
;flashw25q128jv.c,194 :: 		void vFlashResetWriteProtection( uint8_t ucMemorySelected ){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;flashw25q128jv.c,195 :: 		FlashCS = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
_SX	[R1, ByteOffset(GPIOA_ODR+0)]
;flashw25q128jv.c,196 :: 		SPI1_Write( _SERIAL_FLASH_CMD_EWSR );
MOVS	R0, #6
BL	_SPI1_Write+0
;flashw25q128jv.c,197 :: 		FlashCS = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
_SX	[R1, ByteOffset(GPIOA_ODR+0)]
;flashw25q128jv.c,199 :: 		FlashCS = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
_SX	[R1, ByteOffset(GPIOA_ODR+0)]
;flashw25q128jv.c,200 :: 		SPI1_Write( _SERIAL_FLASH_CMD_EWSR );
MOVS	R0, #6
BL	_SPI1_Write+0
;flashw25q128jv.c,201 :: 		SPI1_Write( 0 );
MOVS	R0, #0
BL	_SPI1_Write+0
;flashw25q128jv.c,202 :: 		FlashCS = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
_SX	[R1, ByteOffset(GPIOA_ODR+0)]
;flashw25q128jv.c,203 :: 		}
L_end_vFlashResetWriteProtection:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vFlashResetWriteProtection
_vFlashChipErase:
;flashw25q128jv.c,208 :: 		void vFlashChipErase( uint8_t ucMemorySelected ){
; ucMemorySelected start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R4, R0
; ucMemorySelected end address is: 0 (R0)
; ucMemorySelected start address is: 16 (R4)
;flashw25q128jv.c,210 :: 		vFlashWriteEnable( ucMemorySelected );
UXTB	R0, R4
BL	_vFlashWriteEnable+0
;flashw25q128jv.c,212 :: 		FlashCS = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
_SX	[R1, ByteOffset(GPIOA_ODR+0)]
;flashw25q128jv.c,213 :: 		SPI1_Write( _SERIAL_FLASH_CMD_ERASE );
MOVS	R0, #199
BL	_SPI1_Write+0
;flashw25q128jv.c,214 :: 		FlashCS = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
_SX	[R1, ByteOffset(GPIOA_ODR+0)]
; ucMemorySelected end address is: 16 (R4)
;flashw25q128jv.c,216 :: 		while( ucFlashIsWriteBusy( ucMemorySelected ) );
L_vFlashChipErase127:
; ucMemorySelected start address is: 16 (R4)
UXTB	R0, R4
BL	_ucFlashIsWriteBusy+0
CMP	R0, #0
IT	EQ
BEQ	L_vFlashChipErase128
; ucMemorySelected end address is: 16 (R4)
IT	AL
BAL	L_vFlashChipErase127
L_vFlashChipErase128:
;flashw25q128jv.c,217 :: 		}
L_end_vFlashChipErase:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vFlashChipErase
_vFlashSectorErase:
;flashw25q128jv.c,222 :: 		void vFlashSectorErase( uint8_t ucMemorySelected, uint32_t ulMemoryAddress ){
; ucMemorySelected start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
UXTB	R4, R0
STR	R1, [SP, #4]
; ucMemorySelected end address is: 0 (R0)
; ucMemorySelected start address is: 16 (R4)
;flashw25q128jv.c,224 :: 		vFlashWriteEnable( ucMemorySelected );
UXTB	R0, R4
BL	_vFlashWriteEnable+0
;flashw25q128jv.c,226 :: 		FlashCS = 0;
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOA_ODR+0)
MOVT	R2, #hi_addr(GPIOA_ODR+0)
_SX	[R2, ByteOffset(GPIOA_ODR+0)]
;flashw25q128jv.c,228 :: 		SPI1_Write( _SERIAL_FLASH_CMD_SER );
MOVS	R0, #216
BL	_SPI1_Write+0
;flashw25q128jv.c,229 :: 		SPI1_Write( Higher( ulMemoryAddress ) );
ADD	R2, SP, #4
ADDS	R2, R2, #2
LDRB	R2, [R2, #0]
UXTH	R0, R2
BL	_SPI1_Write+0
;flashw25q128jv.c,230 :: 		SPI1_Write( Hi( ulMemoryAddress ) );
ADD	R2, SP, #4
ADDS	R2, R2, #1
LDRB	R2, [R2, #0]
UXTH	R0, R2
BL	_SPI1_Write+0
;flashw25q128jv.c,231 :: 		SPI1_Write( Lo( ulMemoryAddress ) );
ADD	R2, SP, #4
LDRB	R2, [R2, #0]
UXTH	R0, R2
BL	_SPI1_Write+0
;flashw25q128jv.c,233 :: 		FlashCS = 1;
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOA_ODR+0)
MOVT	R2, #hi_addr(GPIOA_ODR+0)
_SX	[R2, ByteOffset(GPIOA_ODR+0)]
; ucMemorySelected end address is: 16 (R4)
;flashw25q128jv.c,235 :: 		while( ucFlashIsWriteBusy( ucMemorySelected ) );
L_vFlashSectorErase129:
; ucMemorySelected start address is: 16 (R4)
UXTB	R0, R4
BL	_ucFlashIsWriteBusy+0
CMP	R0, #0
IT	EQ
BEQ	L_vFlashSectorErase130
; ucMemorySelected end address is: 16 (R4)
IT	AL
BAL	L_vFlashSectorErase129
L_vFlashSectorErase130:
;flashw25q128jv.c,236 :: 		}
L_end_vFlashSectorErase:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vFlashSectorErase
_RFISR:
;rf4463handler.c,44 :: 		void RFISR() iv IVT_INT_EXTI15_10 ics ICS_AUTO{
SUB	SP, SP, #4
STR	LR, [SP, #0]
;rf4463handler.c,45 :: 		if( EXTI_PR.B12 ){
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_LX	[R0, ByteOffset(EXTI_PR+0)]
CMP	R0, #0
IT	EQ
BEQ	L_RFISR131
;rf4463handler.c,46 :: 		EXTI_PR.B12 |= 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_SX	[R0, ByteOffset(EXTI_PR+0)]
;rf4463handler.c,47 :: 		LEDRed = On;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;rf4463handler.c,48 :: 		ucRF4463IRQ = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(main_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(main_ucRF4463IRQ+0)
STRB	R1, [R0, #0]
;rf4463handler.c,49 :: 		ucRf4463ClearInterrupts();
BL	_ucRf4463ClearInterrupts+0
;rf4463handler.c,50 :: 		}
L_RFISR131:
;rf4463handler.c,51 :: 		}
L_end_RFISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _RFISR
_vRF4463MesageHandler:
;rf4463handler.c,59 :: 		void vRF4463MesageHandler(){
SUB	SP, SP, #28
STR	LR, [SP, #0]
;rf4463handler.c,60 :: 		uint16_t usCounter = 0;
;rf4463handler.c,62 :: 		if( ucRFTxEventPending == 0 ){
MOVW	R0, #lo_addr(_ucRFTxEventPending+0)
MOVT	R0, #hi_addr(_ucRFTxEventPending+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_vRF4463MesageHandler132
;rf4463handler.c,64 :: 		vBufferSetToZero( pcRF4463RxBuffer, RF_MAX_BUFFER_LENGTH );
MOVS	R1, #64
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
BL	_vBufferSetToZero+0
;rf4463handler.c,65 :: 		ucRf4463RxPacket( pcRF4463RxBuffer );
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
BL	_ucRf4463RxPacket+0
;rf4463handler.c,66 :: 		if( pcRF4463RxBuffer[ RF_MESSAGE_SIZE ] > 0 ){
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	LS
BLS	L_vRF4463MesageHandler133
;rf4463handler.c,70 :: 		if( xRF4463GetLastRSSI() <= RSSI_BAD_THRESHOLD ){
BL	_xRF4463GetLastRSSI+0
MVN	R1, #99
CMP	R0, R1
IT	GT
BGT	L_vRF4463MesageHandler134
;rf4463handler.c,71 :: 		STM_LOGE( "[ RF4463 ] Message may be broken\r\n", NULL );
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_54_main+0)
MOVT	R1, #hi_addr(?lstr_54_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,72 :: 		}
L_vRF4463MesageHandler134:
;rf4463handler.c,77 :: 		UART1_Write_Text( "[ RF4463 Rx ] Packet: " );
ADD	R11, SP, #4
ADD	R10, R11, #23
MOVW	R12, #lo_addr(?ICS?lstr55_main+0)
MOVT	R12, #hi_addr(?ICS?lstr55_main+0)
BL	___CC2DW+0
ADD	R0, SP, #4
BL	_UART1_Write_Text+0
;rf4463handler.c,78 :: 		for( usCounter = 0; usCounter < pcRF4463RxBuffer[ RF_MESSAGE_SIZE ]; usCounter++ ){
; usCounter start address is: 16 (R4)
MOVS	R4, #0
; usCounter end address is: 16 (R4)
L_vRF4463MesageHandler135:
; usCounter start address is: 16 (R4)
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
LDRB	R0, [R0, #0]
CMP	R4, R0
IT	CS
BCS	L_vRF4463MesageHandler136
;rf4463handler.c,79 :: 		UART1_Write( pcRF4463RxBuffer[ usCounter ] );
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
ADDS	R0, R0, R4
LDRB	R0, [R0, #0]
BL	_UART1_Write+0
;rf4463handler.c,78 :: 		for( usCounter = 0; usCounter < pcRF4463RxBuffer[ RF_MESSAGE_SIZE ]; usCounter++ ){
ADDS	R4, R4, #1
UXTH	R4, R4
;rf4463handler.c,80 :: 		}
; usCounter end address is: 16 (R4)
IT	AL
BAL	L_vRF4463MesageHandler135
L_vRF4463MesageHandler136:
;rf4463handler.c,81 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;rf4463handler.c,82 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;rf4463handler.c,96 :: 		}
L_vRF4463MesageHandler133:
;rf4463handler.c,97 :: 		}
IT	AL
BAL	L_vRF4463MesageHandler138
L_vRF4463MesageHandler132:
;rf4463handler.c,100 :: 		ucRFTxEventPending = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucRFTxEventPending+0)
MOVT	R0, #hi_addr(_ucRFTxEventPending+0)
STRB	R1, [R0, #0]
;rf4463handler.c,101 :: 		}
L_vRF4463MesageHandler138:
;rf4463handler.c,103 :: 		LEDRed = Off;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;rf4463handler.c,105 :: 		ucRf4463RxInit();
BL	_ucRf4463RxInit+0
;rf4463handler.c,106 :: 		}
L_end_vRF4463MesageHandler:
LDR	LR, [SP, #0]
ADD	SP, SP, #28
BX	LR
; end of _vRF4463MesageHandler
_vRF4463TxMessage:
;rf4463handler.c,111 :: 		void vRF4463TxMessage( uint8_t * pcOutBuffer, uint8_t ucLength, uint8_t ucRemoteNode, uint8_t ucTable, uint8_t ucCommand ){
; ucTable start address is: 12 (R3)
; ucRemoteNode start address is: 8 (R2)
; ucLength start address is: 4 (R1)
; pcOutBuffer start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R6, R0
UXTB	R7, R1
UXTB	R8, R2
UXTB	R9, R3
; ucTable end address is: 12 (R3)
; ucRemoteNode end address is: 8 (R2)
; ucLength end address is: 4 (R1)
; pcOutBuffer end address is: 0 (R0)
; pcOutBuffer start address is: 24 (R6)
; ucLength start address is: 28 (R7)
; ucRemoteNode start address is: 32 (R8)
; ucTable start address is: 36 (R9)
; ucCommand start address is: 40 (R10)
LDRB	R10, [SP, #4]
;rf4463handler.c,112 :: 		uint8_t ucCounter = 0;
;rf4463handler.c,117 :: 		if( ucRFTxEventPending == 1 ){
MOVW	R4, #lo_addr(_ucRFTxEventPending+0)
MOVT	R4, #hi_addr(_ucRFTxEventPending+0)
LDRB	R4, [R4, #0]
CMP	R4, #1
IT	NE
BNE	L_vRF4463TxMessage139
; pcOutBuffer end address is: 24 (R6)
; ucLength end address is: 28 (R7)
; ucRemoteNode end address is: 32 (R8)
; ucTable end address is: 36 (R9)
; ucCommand end address is: 40 (R10)
;rf4463handler.c,118 :: 		STM_LOGE( "[ RF4463 ] HW in use\r\n", NULL );
MOVS	R6, #0
SXTB	R6, R6
MOVW	R5, #lo_addr(?lstr_56_main+0)
MOVT	R5, #hi_addr(?lstr_56_main+0)
MOVW	R4, #lo_addr(_vDebugPrint+0)
MOVT	R4, #hi_addr(_vDebugPrint+0)
PUSH	(R6)
PUSH	(R5)
PUSH	(R4)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,119 :: 		return;
IT	AL
BAL	L_end_vRF4463TxMessage
;rf4463handler.c,120 :: 		}
L_vRF4463TxMessage139:
;rf4463handler.c,125 :: 		vBufferSetToZero( pcRF4463TxBuffer, RF_MAX_BUFFER_LENGTH );
; ucCommand start address is: 40 (R10)
; ucTable start address is: 36 (R9)
; ucRemoteNode start address is: 32 (R8)
; ucLength start address is: 28 (R7)
; pcOutBuffer start address is: 24 (R6)
MOVS	R1, #64
MOVW	R0, #lo_addr(_pcRF4463TxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463TxBuffer+0)
BL	_vBufferSetToZero+0
;rf4463handler.c,129 :: 		if( ( ucLength + RF_MESSAGE_HEADER_SIZE ) >= RF_MAX_BUFFER_LENGTH ){
ADDS	R4, R7, #5
SXTH	R4, R4
CMP	R4, #64
IT	LT
BLT	L_vRF4463TxMessage140
; pcOutBuffer end address is: 24 (R6)
; ucLength end address is: 28 (R7)
; ucRemoteNode end address is: 32 (R8)
; ucTable end address is: 36 (R9)
; ucCommand end address is: 40 (R10)
;rf4463handler.c,130 :: 		STM_LOGE( "[ RF4463 ] Buffer Out of Size\r\n", NULL );
MOVS	R6, #0
SXTB	R6, R6
MOVW	R5, #lo_addr(?lstr_57_main+0)
MOVT	R5, #hi_addr(?lstr_57_main+0)
MOVW	R4, #lo_addr(_vDebugPrint+0)
MOVT	R4, #hi_addr(_vDebugPrint+0)
PUSH	(R6)
PUSH	(R5)
PUSH	(R4)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,131 :: 		return;
IT	AL
BAL	L_end_vRF4463TxMessage
;rf4463handler.c,132 :: 		}
L_vRF4463TxMessage140:
;rf4463handler.c,136 :: 		pcRF4463TxBuffer[ RF_MESSAGE_SIZE ]             = RF_MESSAGE_HEADER_SIZE + ucLength;
; ucCommand start address is: 40 (R10)
; ucTable start address is: 36 (R9)
; ucRemoteNode start address is: 32 (R8)
; ucLength start address is: 28 (R7)
; pcOutBuffer start address is: 24 (R6)
ADDS	R5, R7, #5
MOVW	R4, #lo_addr(_pcRF4463TxBuffer+0)
MOVT	R4, #hi_addr(_pcRF4463TxBuffer+0)
STRB	R5, [R4, #0]
;rf4463handler.c,137 :: 		pcRF4463TxBuffer[ RF_MESSAGE_DESTINATION ]      = ucRemoteNode;
MOVW	R4, #lo_addr(_pcRF4463TxBuffer+1)
MOVT	R4, #hi_addr(_pcRF4463TxBuffer+1)
STRB	R8, [R4, #0]
; ucRemoteNode end address is: 32 (R8)
;rf4463handler.c,138 :: 		pcRF4463TxBuffer[ RF_MESSAGE_SOURCE ]           = ucSourceNode;
MOVW	R4, #lo_addr(_ucSourceNode+0)
MOVT	R4, #hi_addr(_ucSourceNode+0)
LDRB	R5, [R4, #0]
MOVW	R4, #lo_addr(_pcRF4463TxBuffer+2)
MOVT	R4, #hi_addr(_pcRF4463TxBuffer+2)
STRB	R5, [R4, #0]
;rf4463handler.c,139 :: 		pcRF4463TxBuffer[ RF_MESSAGE_TABLE ]            = ucTable;
MOVW	R4, #lo_addr(_pcRF4463TxBuffer+3)
MOVT	R4, #hi_addr(_pcRF4463TxBuffer+3)
STRB	R9, [R4, #0]
; ucTable end address is: 36 (R9)
;rf4463handler.c,140 :: 		pcRF4463TxBuffer[ RF_MESSAGE_COMMAND ]          = ucCommand;
MOVW	R4, #lo_addr(_pcRF4463TxBuffer+4)
MOVT	R4, #hi_addr(_pcRF4463TxBuffer+4)
STRB	R10, [R4, #0]
; ucCommand end address is: 40 (R10)
;rf4463handler.c,144 :: 		if( ucLength > 0 ){
CMP	R7, #0
IT	LS
BLS	L_vRF4463TxMessage141
;rf4463handler.c,145 :: 		for( ucCounter = 0; ucCounter < ucLength; ucCounter++ ){
; ucCounter start address is: 8 (R2)
MOVS	R2, #0
; pcOutBuffer end address is: 24 (R6)
; ucLength end address is: 28 (R7)
; ucCounter end address is: 8 (R2)
MOV	R1, R6
UXTB	R0, R7
L_vRF4463TxMessage142:
; ucCounter start address is: 8 (R2)
; pcOutBuffer start address is: 4 (R1)
; ucLength start address is: 0 (R0)
; pcOutBuffer start address is: 4 (R1)
; pcOutBuffer end address is: 4 (R1)
CMP	R2, R0
IT	CS
BCS	L_vRF4463TxMessage143
; pcOutBuffer end address is: 4 (R1)
;rf4463handler.c,146 :: 		pcRF4463TxBuffer[ RF_MESSAGE_HEADER_SIZE + ucCounter ] = pcOutBuffer[ ucCounter ];
; pcOutBuffer start address is: 4 (R1)
ADDS	R5, R2, #5
SXTH	R5, R5
MOVW	R4, #lo_addr(_pcRF4463TxBuffer+0)
MOVT	R4, #hi_addr(_pcRF4463TxBuffer+0)
ADDS	R5, R4, R5
ADDS	R4, R1, R2
LDRB	R4, [R4, #0]
STRB	R4, [R5, #0]
;rf4463handler.c,145 :: 		for( ucCounter = 0; ucCounter < ucLength; ucCounter++ ){
ADDS	R2, R2, #1
UXTB	R2, R2
;rf4463handler.c,147 :: 		}
; ucLength end address is: 0 (R0)
; pcOutBuffer end address is: 4 (R1)
; ucCounter end address is: 8 (R2)
IT	AL
BAL	L_vRF4463TxMessage142
L_vRF4463TxMessage143:
;rf4463handler.c,148 :: 		}
L_vRF4463TxMessage141:
;rf4463handler.c,163 :: 		ucRf4463TxPacket( pcRF4463TxBuffer, pcRF4463TxBuffer[ RF_MESSAGE_SIZE ] );
MOVW	R4, #lo_addr(_pcRF4463TxBuffer+0)
MOVT	R4, #hi_addr(_pcRF4463TxBuffer+0)
LDRB	R4, [R4, #0]
UXTB	R1, R4
MOVW	R0, #lo_addr(_pcRF4463TxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463TxBuffer+0)
BL	_ucRf4463TxPacket+0
;rf4463handler.c,164 :: 		ucRFTxEventPending = 1;
MOVS	R5, #1
MOVW	R4, #lo_addr(_ucRFTxEventPending+0)
MOVT	R4, #hi_addr(_ucRFTxEventPending+0)
STRB	R5, [R4, #0]
;rf4463handler.c,165 :: 		}
L_end_vRF4463TxMessage:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vRF4463TxMessage
_vRF4463SetNode:
;rf4463handler.c,170 :: 		void vRF4463SetNode( uint8_t ucNode ){
; ucNode start address is: 0 (R0)
; ucNode end address is: 0 (R0)
; ucNode start address is: 0 (R0)
;rf4463handler.c,171 :: 		ucSourceNode = ucNode;
MOVW	R1, #lo_addr(_ucSourceNode+0)
MOVT	R1, #hi_addr(_ucSourceNode+0)
STRB	R0, [R1, #0]
; ucNode end address is: 0 (R0)
;rf4463handler.c,172 :: 		}
L_end_vRF4463SetNode:
BX	LR
; end of _vRF4463SetNode
_ucRF4463Setup:
;rf4463handler.c,177 :: 		uint8_t ucRF4463Setup( uint8_t ucRxChannel, uint8_t ucTxChannel, uint16_t usNetwork, uint8_t ucTxPower ){
SUB	SP, SP, #24
STR	LR, [SP, #0]
STRB	R0, [SP, #8]
STRB	R1, [SP, #12]
STRH	R2, [SP, #16]
STRB	R3, [SP, #20]
;rf4463handler.c,178 :: 		uint8_t ucRetries = 0;
;rf4463handler.c,179 :: 		int8_t ucIsRFAvailable = NOT_SUCCESS;
MOVS	R4, #1
STRB	R4, [SP, #4]
;rf4463handler.c,184 :: 		_SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI2_PB13_14_15 );
MOVW	R2, #lo_addr(__GPIO_MODULE_SPI2_PB13_14_15+0)
MOVT	R2, #hi_addr(__GPIO_MODULE_SPI2_PB13_14_15+0)
MOVW	R1, #772
;rf4463handler.c,183 :: 		SPI2_Init_Advanced( _SPI_FPCLK_DIV8, _SPI_MASTER | _SPI_8_BIT | _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION | _SPI_MSB_FIRST |
MOVS	R0, #2
;rf4463handler.c,184 :: 		_SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI2_PB13_14_15 );
BL	_SPI2_Init_Advanced+0
;rf4463handler.c,189 :: 		GPIO_Digital_Input( &GPIOC_BASE, _GPIO_PINMASK_12 );
MOVW	R1, #4096
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Input+0
;rf4463handler.c,191 :: 		GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_12 );
MOVW	R1, #4096
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;rf4463handler.c,192 :: 		GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_11 );
MOVW	R1, #2048
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;rf4463handler.c,193 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_11 );
MOVW	R1, #2048
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;rf4463handler.c,194 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_10 );
MOVW	R1, #1024
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;rf4463handler.c,201 :: 		RCC_APB2ENRbits.AFIOEN = 1;
MOVS	R5, #1
SXTB	R5, R5
MOVW	R4, #lo_addr(RCC_APB2ENRbits+0)
MOVT	R4, #hi_addr(RCC_APB2ENRbits+0)
_SX	[R4, ByteOffset(RCC_APB2ENRbits+0)]
;rf4463handler.c,205 :: 		AFIO_EXTICR4  |= 0x0002;
MOVW	R4, #lo_addr(AFIO_EXTICR4+0)
MOVT	R4, #hi_addr(AFIO_EXTICR4+0)
LDR	R4, [R4, #0]
ORR	R5, R4, #2
MOVW	R4, #lo_addr(AFIO_EXTICR4+0)
MOVT	R4, #hi_addr(AFIO_EXTICR4+0)
STR	R5, [R4, #0]
;rf4463handler.c,209 :: 		EXTI_IMR.B12    |= 1;
MOVS	R5, #1
MOVW	R4, #lo_addr(EXTI_IMR+0)
MOVT	R4, #hi_addr(EXTI_IMR+0)
_SX	[R4, ByteOffset(EXTI_IMR+0)]
;rf4463handler.c,210 :: 		EXTI_FTSR.B12   |= 1;
MOVS	R5, #1
MOVW	R4, #lo_addr(EXTI_FTSR+0)
MOVT	R4, #hi_addr(EXTI_FTSR+0)
_SX	[R4, ByteOffset(EXTI_FTSR+0)]
;rf4463handler.c,214 :: 		STM_LOGV( "[ RF4463 ] Parameters\r\n", NULL );
MOVS	R6, #0
SXTB	R6, R6
MOVW	R5, #lo_addr(?lstr_58_main+0)
MOVT	R5, #hi_addr(?lstr_58_main+0)
MOVW	R4, #lo_addr(_vDebugPrint+0)
MOVT	R4, #hi_addr(_vDebugPrint+0)
PUSH	(R6)
PUSH	(R5)
PUSH	(R4)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,215 :: 		STM_LOGI( "[ RF4463 ] Tx Channel: %d\r\n", ucTxChannel );
MOVW	R6, #lo_addr(?lstr_59_main+0)
MOVT	R6, #hi_addr(?lstr_59_main+0)
MOVW	R5, #lo_addr(_vDebugPrint+0)
MOVT	R5, #hi_addr(_vDebugPrint+0)
LDRB	R4, [SP, #12]
PUSH	(R4)
PUSH	(R6)
PUSH	(R5)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,216 :: 		STM_LOGI( "[ RF4463 ] Rx Channel: %d\r\n", ucRxChannel );
MOVW	R6, #lo_addr(?lstr_60_main+0)
MOVT	R6, #hi_addr(?lstr_60_main+0)
MOVW	R5, #lo_addr(_vDebugPrint+0)
MOVT	R5, #hi_addr(_vDebugPrint+0)
LDRB	R4, [SP, #8]
PUSH	(R4)
PUSH	(R6)
PUSH	(R5)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,217 :: 		STM_LOGI( "[ RF4463 ] Network: %d\r\n", usNetwork );
MOVW	R6, #lo_addr(?lstr_61_main+0)
MOVT	R6, #hi_addr(?lstr_61_main+0)
MOVW	R5, #lo_addr(_vDebugPrint+0)
MOVT	R5, #hi_addr(_vDebugPrint+0)
LDRH	R4, [SP, #16]
PUSH	(R4)
PUSH	(R6)
PUSH	(R5)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,218 :: 		STM_LOGI( "[ RF4463 ] Tx Power: %d\r\n", ucTxPower );
MOVW	R6, #lo_addr(?lstr_62_main+0)
MOVT	R6, #hi_addr(?lstr_62_main+0)
MOVW	R5, #lo_addr(_vDebugPrint+0)
MOVT	R5, #hi_addr(_vDebugPrint+0)
LDRB	R4, [SP, #20]
PUSH	(R4)
PUSH	(R6)
PUSH	(R5)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,222 :: 		vRf4463Init( ucRxChannel, ucTxChannel, usNetwork, ucTxPower, RF4463_FREQUENCY_915MHz );
MOVS	R4, #2
LDRB	R3, [SP, #20]
LDRH	R2, [SP, #16]
LDRB	R1, [SP, #12]
LDRB	R0, [SP, #8]
PUSH	(R4)
BL	_vRf4463Init+0
ADD	SP, SP, #4
;rf4463handler.c,227 :: 		for( ucRetries = 0; ucRetries < 15; ucRetries++ ){
MOVS	R4, #0
STRB	R4, [SP, #21]
L_ucRF4463Setup145:
LDRB	R4, [SP, #21]
CMP	R4, #15
IT	CS
BCS	L_ucRF4463Setup146
;rf4463handler.c,228 :: 		if( ucRf4463DeviceAvailability() == SUCCESS ){
BL	_ucRf4463DeviceAvailability+0
CMP	R0, #0
IT	NE
BNE	L_ucRF4463Setup148
;rf4463handler.c,229 :: 		STM_LOGD( "[ RF4663 ] Setup Try: %d Success\r\n", ucRetries );
LDRB	R6, [SP, #21]
MOVW	R5, #lo_addr(?lstr_63_main+0)
MOVT	R5, #hi_addr(?lstr_63_main+0)
MOVW	R4, #lo_addr(_vDebugPrint+0)
MOVT	R4, #hi_addr(_vDebugPrint+0)
PUSH	(R6)
PUSH	(R5)
PUSH	(R4)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,230 :: 		break;
IT	AL
BAL	L_ucRF4463Setup146
;rf4463handler.c,231 :: 		}
L_ucRF4463Setup148:
;rf4463handler.c,233 :: 		STM_LOGE( "[ RF4463 ] Setup Try %d Failed\r\n", ucRetries );
LDRB	R6, [SP, #21]
MOVW	R5, #lo_addr(?lstr_64_main+0)
MOVT	R5, #hi_addr(?lstr_64_main+0)
MOVW	R4, #lo_addr(_vDebugPrint+0)
MOVT	R4, #hi_addr(_vDebugPrint+0)
PUSH	(R6)
PUSH	(R5)
PUSH	(R4)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,234 :: 		Delay_ms( 50 );
MOVW	R7, #10175
MOVT	R7, #9
NOP
NOP
L_ucRF4463Setup150:
SUBS	R7, R7, #1
BNE	L_ucRF4463Setup150
NOP
NOP
NOP
;rf4463handler.c,227 :: 		for( ucRetries = 0; ucRetries < 15; ucRetries++ ){
LDRB	R4, [SP, #21]
ADDS	R4, R4, #1
STRB	R4, [SP, #21]
;rf4463handler.c,236 :: 		}
IT	AL
BAL	L_ucRF4463Setup145
L_ucRF4463Setup146:
;rf4463handler.c,240 :: 		if( ucRetries == 15 ){
LDRB	R4, [SP, #21]
CMP	R4, #15
IT	NE
BNE	L_ucRF4463Setup152
;rf4463handler.c,241 :: 		STM_LOGE( "[ RF4463 ] Setup Retries Excedded\r\n", NULL );
MOVS	R6, #0
SXTB	R6, R6
MOVW	R5, #lo_addr(?lstr_65_main+0)
MOVT	R5, #hi_addr(?lstr_65_main+0)
MOVW	R4, #lo_addr(_vDebugPrint+0)
MOVT	R4, #hi_addr(_vDebugPrint+0)
PUSH	(R6)
PUSH	(R5)
PUSH	(R4)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,243 :: 		}
L_ucRF4463Setup152:
;rf4463handler.c,247 :: 		while( ucIsRFAvailable ){
L_ucRF4463Setup153:
LDRSB	R4, [SP, #4]
CMP	R4, #0
IT	EQ
BEQ	L_ucRF4463Setup154
;rf4463handler.c,248 :: 		ucIsRFAvailable = ucRf4463EnterStandbyMode();
BL	_ucRf4463EnterStandbyMode+0
STRB	R0, [SP, #4]
;rf4463handler.c,249 :: 		}
IT	AL
BAL	L_ucRF4463Setup153
L_ucRF4463Setup154:
;rf4463handler.c,253 :: 		NVIC_IntEnable( IVT_INT_EXTI15_10 );
MOVW	R0, #56
BL	_NVIC_IntEnable+0
;rf4463handler.c,254 :: 		ucRf4463ClearInterrupts();
BL	_ucRf4463ClearInterrupts+0
;rf4463handler.c,255 :: 		ucRf4463RxInit();
BL	_ucRf4463RxInit+0
;rf4463handler.c,256 :: 		STM_LOGD( "[ RF4463 ] Ready\r\n", NULL );
MOVS	R6, #0
SXTB	R6, R6
MOVW	R5, #lo_addr(?lstr_66_main+0)
MOVT	R5, #hi_addr(?lstr_66_main+0)
MOVW	R4, #lo_addr(_vDebugPrint+0)
MOVT	R4, #hi_addr(_vDebugPrint+0)
PUSH	(R6)
PUSH	(R5)
PUSH	(R4)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,257 :: 		}
L_end_ucRF4463Setup:
LDR	LR, [SP, #0]
ADD	SP, SP, #24
BX	LR
; end of _ucRF4463Setup
_vRF4463RxCommand:
;rf4463handler.c,265 :: 		void vRF4463RxCommand(){
SUB	SP, SP, #60
STR	LR, [SP, #0]
;rf4463handler.c,266 :: 		uint8_t ucCounter = 0;
;rf4463handler.c,267 :: 		uint8_t ucPosition = RF_MESSAGE_CONTENT;
; ucPosition start address is: 12 (R3)
MOVS	R3, #5
;rf4463handler.c,269 :: 		uint8_t pcTempBuffer[ RF_MAX_BUFFER_LENGTH ] = { 0x00 };
;rf4463handler.c,271 :: 		uint8_t pcQR[ 13 ]      = { 0x00 };
ADD	R11, SP, #8
ADD	R10, R11, #51
MOVW	R12, #lo_addr(?ICSvRF4463RxCommand_pcQR_L0+0)
MOVT	R12, #hi_addr(?ICSvRF4463RxCommand_pcQR_L0+0)
BL	___CC2DW+0
;rf4463handler.c,272 :: 		uint8_t pcUIDText[ 25 ] = { 0x00 };
;rf4463handler.c,273 :: 		uint8_t pcUIDHex[ 13 ]  = { 0x00 };
;rf4463handler.c,277 :: 		switch( pcRF4463RxBuffer[ RF_MESSAGE_TABLE ] ){
IT	AL
BAL	L_vRF4463RxCommand155
; ucPosition end address is: 12 (R3)
;rf4463handler.c,281 :: 		case TABLE_RF_TEST:
L_vRF4463RxCommand157:
;rf4463handler.c,282 :: 		STM_LOGI( "[ RF4463 ] Test Table\r\n", NULL );
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_67_main+0)
MOVT	R1, #hi_addr(?lstr_67_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,291 :: 		break;
IT	AL
BAL	L_vRF4463RxCommand156
;rf4463handler.c,295 :: 		case TABLE_RF_SETUP:
L_vRF4463RxCommand158:
;rf4463handler.c,296 :: 		STM_LOGI( "[ RF4463 ] Setup Table\r\n", NULL );
; ucPosition start address is: 12 (R3)
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_68_main+0)
MOVT	R1, #hi_addr(?lstr_68_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
STRB	R3, [SP, #4]
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
LDRB	R3, [SP, #4]
;rf4463handler.c,297 :: 		switch( pcRF4463RxBuffer[ RF_MESSAGE_COMMAND ] ){
IT	AL
BAL	L_vRF4463RxCommand159
;rf4463handler.c,298 :: 		case RF_SETUP_FIND_BY_QR:
L_vRF4463RxCommand161:
;rf4463handler.c,299 :: 		if( pcRF4463RxBuffer[ RF_MESSAGE_SOURCE ] == HUB_NODE ){
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+2)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+2)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_vRF4463RxCommand162
;rf4463handler.c,300 :: 		STM_LOGI( "[ RF4463 ] Hub Request\r\n", NULL );
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_69_main+0)
MOVT	R1, #hi_addr(?lstr_69_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
STRB	R3, [SP, #4]
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
LDRB	R3, [SP, #4]
;rf4463handler.c,301 :: 		for( ucCounter = 0; ucCounter < DEVICE_QR_FIELD_LENGTH; ucCounter++ ){
; ucCounter start address is: 8 (R2)
MOVS	R2, #0
; ucPosition end address is: 12 (R3)
; ucCounter end address is: 8 (R2)
L_vRF4463RxCommand163:
; ucCounter start address is: 8 (R2)
; ucPosition start address is: 12 (R3)
CMP	R2, #12
IT	CS
BCS	L_vRF4463RxCommand164
;rf4463handler.c,302 :: 		pcQR[ ucCounter ] = pcRF4463RxBuffer[ ucPosition++ ];
ADD	R0, SP, #8
ADDS	R1, R0, R2
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
ADDS	R3, R3, #1
UXTB	R3, R3
;rf4463handler.c,301 :: 		for( ucCounter = 0; ucCounter < DEVICE_QR_FIELD_LENGTH; ucCounter++ ){
ADDS	R2, R2, #1
UXTB	R2, R2
;rf4463handler.c,303 :: 		}
; ucPosition end address is: 12 (R3)
; ucCounter end address is: 8 (R2)
IT	AL
BAL	L_vRF4463RxCommand163
L_vRF4463RxCommand164:
;rf4463handler.c,304 :: 		STM_LOGV( "[ RF4463 ] Request QR: %s\r\n", pcQR );
ADD	R2, SP, #8
MOVW	R1, #lo_addr(?lstr_70_main+0)
MOVT	R1, #hi_addr(?lstr_70_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,305 :: 		}
IT	AL
BAL	L_vRF4463RxCommand166
L_vRF4463RxCommand162:
;rf4463handler.c,306 :: 		else if( pcRF4463RxBuffer[ RF_MESSAGE_SOURCE ] == REMOTE_DEFAULT ){
; ucPosition start address is: 12 (R3)
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+2)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+2)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_vRF4463RxCommand167
;rf4463handler.c,307 :: 		STM_LOGI( "[ RF4463 ] Device Response\r\n", NULL );
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_71_main+0)
MOVT	R1, #hi_addr(?lstr_71_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
STRB	R3, [SP, #4]
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
LDRB	R3, [SP, #4]
;rf4463handler.c,308 :: 		for( ucCounter = 0; ucCounter < DEVICE_ID_HEX_FIELD_LENGTH; ucCounter++ ){
; ucCounter start address is: 8 (R2)
MOVS	R2, #0
; ucPosition end address is: 12 (R3)
; ucCounter end address is: 8 (R2)
L_vRF4463RxCommand168:
; ucCounter start address is: 8 (R2)
; ucPosition start address is: 12 (R3)
CMP	R2, #12
IT	CS
BCS	L_vRF4463RxCommand169
;rf4463handler.c,309 :: 		pcUIDHex[ ucCounter ] = pcRF4463RxBuffer[ ucPosition++ ];
ADD	R0, SP, #46
ADDS	R1, R0, R2
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
ADDS	R3, R3, #1
UXTB	R3, R3
;rf4463handler.c,308 :: 		for( ucCounter = 0; ucCounter < DEVICE_ID_HEX_FIELD_LENGTH; ucCounter++ ){
ADDS	R2, R2, #1
UXTB	R2, R2
;rf4463handler.c,310 :: 		}
; ucPosition end address is: 12 (R3)
; ucCounter end address is: 8 (R2)
IT	AL
BAL	L_vRF4463RxCommand168
L_vRF4463RxCommand169:
;rf4463handler.c,311 :: 		vHexToASCII( pcUIDText, pcUIDHex, DEVICE_ID_HEX_FIELD_LENGTH );
ADD	R1, SP, #46
ADD	R0, SP, #21
MOVS	R2, #12
BL	_vHexToASCII+0
;rf4463handler.c,312 :: 		STM_LOGV( "[ RF4463 ] UID: %s\r\n", pcUIDText );
ADD	R2, SP, #21
MOVW	R1, #lo_addr(?lstr_72_main+0)
MOVT	R1, #hi_addr(?lstr_72_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,313 :: 		if( pcRF4463RxBuffer[ RF_MESSAGE_SIZE ] == RF_CONFIG_DEVICE_SWITCH_MESSAGE_SIZE ){
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
LDRB	R0, [R0, #0]
CMP	R0, #24
IT	NE
BNE	L_vRF4463RxCommand171
;rf4463handler.c,314 :: 		STM_LOGV( "[ RF4463 ] Detected Loads: %d\r\n", pcRF4463RxBuffer[ RF_CONFIG_DEVICE_POSITION_LOADS ] );
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+17)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+17)
LDRB	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_73_main+0)
MOVT	R1, #hi_addr(?lstr_73_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,315 :: 		STM_LOGV( "[ RF4463 ] Load 1: %d\r\n", pcRF4463RxBuffer[ RF_CONFIG_DEVICE_POSITION_SWITCH_LOAD1 ] );
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+18)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+18)
LDRB	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_74_main+0)
MOVT	R1, #hi_addr(?lstr_74_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,316 :: 		STM_LOGV( "[ RF4463 ] Load 2: %d\r\n", pcRF4463RxBuffer[ RF_CONFIG_DEVICE_POSITION_SWITCH_LOAD2 ] );
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+19)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+19)
LDRB	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_75_main+0)
MOVT	R1, #hi_addr(?lstr_75_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,317 :: 		STM_LOGV( "[ RF4463 ] Load 3: %d\r\n", pcRF4463RxBuffer[ RF_CONFIG_DEVICE_POSITION_SWITCH_LOAD3 ] );
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+20)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+20)
LDRB	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_76_main+0)
MOVT	R1, #hi_addr(?lstr_76_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,318 :: 		STM_LOGV( "[ RF4463 ] Version: %d.%d.%d\r\n", pcRF4463RxBuffer[ RF_CONFIG_DEVICE_POSITION_SWITCH_VERSION_MAJOR ], pcRF4463RxBuffer[ RF_CONFIG_DEVICE_POSITION_SWITCH_VERSION_MINOR ], pcRF4463RxBuffer[ RF_CONFIG_DEVICE_POSITION_SWITCH_VERSION_BUILD ] );
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+23)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+23)
LDRB	R4, [R0, #0]
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+22)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+22)
LDRB	R3, [R0, #0]
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+21)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+21)
LDRB	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_77_main+0)
MOVT	R1, #hi_addr(?lstr_77_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R4)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #20
;rf4463handler.c,319 :: 		}
IT	AL
BAL	L_vRF4463RxCommand172
L_vRF4463RxCommand171:
;rf4463handler.c,321 :: 		STM_LOGV( "[ RF4463 ] Load Status: %d\r\n", pcRF4463RxBuffer[ RF_CONFIG_DEVICE_LOAD_STATUS ] );
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+18)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+18)
LDRB	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_78_main+0)
MOVT	R1, #hi_addr(?lstr_78_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,322 :: 		STM_LOGV( "[ RF4463 ] Version: %d.%d.%d\r\n", pcRF4463RxBuffer[ RF_CONFIG_DEVICE_POSITION_VERSION_MAJOR ], pcRF4463RxBuffer[ RF_CONFIG_DEVICE_POSITION_VERSION_MINOR ], pcRF4463RxBuffer[ RF_CONFIG_DEVICE_POSITION_VERSION_BUILD ] );
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+21)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+21)
LDRB	R4, [R0, #0]
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+20)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+20)
LDRB	R3, [R0, #0]
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+19)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+19)
LDRB	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_79_main+0)
MOVT	R1, #hi_addr(?lstr_79_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R4)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #20
;rf4463handler.c,323 :: 		}
L_vRF4463RxCommand172:
;rf4463handler.c,324 :: 		}
L_vRF4463RxCommand167:
L_vRF4463RxCommand166:
;rf4463handler.c,325 :: 		break;
IT	AL
BAL	L_vRF4463RxCommand160
;rf4463handler.c,326 :: 		default:
L_vRF4463RxCommand173:
;rf4463handler.c,327 :: 		STM_LOGE( "[ RF4463 ] Unhandled command\r\n", NULL );
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_80_main+0)
MOVT	R1, #hi_addr(?lstr_80_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,328 :: 		return;
IT	AL
BAL	L_end_vRF4463RxCommand
;rf4463handler.c,329 :: 		}
L_vRF4463RxCommand159:
; ucPosition start address is: 12 (R3)
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+4)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+4)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_vRF4463RxCommand161
; ucPosition end address is: 12 (R3)
IT	AL
BAL	L_vRF4463RxCommand173
L_vRF4463RxCommand160:
;rf4463handler.c,330 :: 		break;
IT	AL
BAL	L_vRF4463RxCommand156
;rf4463handler.c,334 :: 		case TABLE_RF_OTA:
L_vRF4463RxCommand174:
;rf4463handler.c,335 :: 		STM_LOGI( "[ RF4463 ] OTA Table\r\n", NULL );
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_81_main+0)
MOVT	R1, #hi_addr(?lstr_81_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,336 :: 		switch( pcRF4463RxBuffer[ RF_MESSAGE_COMMAND ] ){
IT	AL
BAL	L_vRF4463RxCommand175
;rf4463handler.c,337 :: 		default:
L_vRF4463RxCommand177:
;rf4463handler.c,338 :: 		STM_LOGE( "[ RF4463 ] Unhandled command\r\n", NULL );
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_82_main+0)
MOVT	R1, #hi_addr(?lstr_82_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,339 :: 		return;
IT	AL
BAL	L_end_vRF4463RxCommand
;rf4463handler.c,340 :: 		}
L_vRF4463RxCommand175:
IT	AL
BAL	L_vRF4463RxCommand177
L_vRF4463RxCommand176:
;rf4463handler.c,341 :: 		break;
IT	AL
BAL	L_vRF4463RxCommand176
;rf4463handler.c,345 :: 		case TABLE_RF_GLOBAL:
L_vRF4463RxCommand178:
;rf4463handler.c,346 :: 		STM_LOGI( "[ RF4463 ] Global Table\r\n", NULL );
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_83_main+0)
MOVT	R1, #hi_addr(?lstr_83_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,359 :: 		STM_LOGI( "[ RF4463 ] Node: %d\r\n", pcRF4463RxBuffer[ RF_MESSAGE_SOURCE ] );
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+2)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+2)
LDRB	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_84_main+0)
MOVT	R1, #hi_addr(?lstr_84_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,365 :: 		break;
IT	AL
BAL	L_vRF4463RxCommand176
;rf4463handler.c,369 :: 		case TABLE_RF_SWITCH:
L_vRF4463RxCommand179:
;rf4463handler.c,370 :: 		STM_LOGI( "[ RF4463 ] Switch Table\r\n", NULL );
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_85_main+0)
MOVT	R1, #hi_addr(?lstr_85_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,383 :: 		STM_LOGI( "[ RF4463 ] Node: %d\r\n", pcRF4463RxBuffer[ RF_MESSAGE_SOURCE ] );
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+2)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+2)
LDRB	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_86_main+0)
MOVT	R1, #hi_addr(?lstr_86_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,389 :: 		break;
IT	AL
BAL	L_vRF4463RxCommand176
;rf4463handler.c,393 :: 		case TABLE_RF_DIMMER:
L_vRF4463RxCommand180:
;rf4463handler.c,394 :: 		STM_LOGI( "[ RF4463 ] Dimmer Table\r\n", NULL );
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_87_main+0)
MOVT	R1, #hi_addr(?lstr_87_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,407 :: 		STM_LOGI( "[ RF4463 ] Node: %d\r\n", pcRF4463RxBuffer[ RF_MESSAGE_SOURCE ] );
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+2)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+2)
LDRB	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_88_main+0)
MOVT	R1, #hi_addr(?lstr_88_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,413 :: 		break;
IT	AL
BAL	L_vRF4463RxCommand176
;rf4463handler.c,417 :: 		case TABLE_RF_OUTLET:
L_vRF4463RxCommand181:
;rf4463handler.c,418 :: 		STM_LOGI( "[ RF4463 ] Outlet Table\r\n", NULL );
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_89_main+0)
MOVT	R1, #hi_addr(?lstr_89_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,431 :: 		STM_LOGI( "[ RF4463 ] Node: %d\r\n", pcRF4463RxBuffer[ RF_MESSAGE_SOURCE ] );
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+2)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+2)
LDRB	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_90_main+0)
MOVT	R1, #hi_addr(?lstr_90_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,437 :: 		break;
IT	AL
BAL	L_vRF4463RxCommand176
;rf4463handler.c,441 :: 		default:
L_vRF4463RxCommand182:
;rf4463handler.c,442 :: 		STM_LOGE( "[ RF4463 ] Unhandled table\r\n", NULL );
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_91_main+0)
MOVT	R1, #hi_addr(?lstr_91_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,443 :: 		STM_LOGV( "[ RF4463 ] Source node:%d\r\n", pcRF4463RxBuffer[ RF_MESSAGE_SOURCE ] );
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+2)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+2)
LDRB	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_92_main+0)
MOVT	R1, #hi_addr(?lstr_92_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,444 :: 		STM_LOGV( "[ RF4463 ] Destination node:%d\r\n", pcRF4463RxBuffer[ RF_MESSAGE_DESTINATION ] );
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+1)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+1)
LDRB	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_93_main+0)
MOVT	R1, #hi_addr(?lstr_93_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,445 :: 		STM_LOGV( "[ RF4463 ] Table: %d\r\n", pcRF4463RxBuffer[ RF_MESSAGE_TABLE ] );
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+3)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+3)
LDRB	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_94_main+0)
MOVT	R1, #hi_addr(?lstr_94_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,446 :: 		STM_LOGV( "[ RF4463 ] Command: %d\r\n", pcRF4463RxBuffer[ RF_MESSAGE_COMMAND ] );
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+4)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+4)
LDRB	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_95_main+0)
MOVT	R1, #hi_addr(?lstr_95_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,447 :: 		return;
IT	AL
BAL	L_end_vRF4463RxCommand
;rf4463handler.c,448 :: 		}
L_vRF4463RxCommand155:
; ucPosition start address is: 12 (R3)
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+3)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+3)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_vRF4463RxCommand157
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+3)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+3)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_vRF4463RxCommand158
; ucPosition end address is: 12 (R3)
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+3)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+3)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_vRF4463RxCommand174
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+3)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+3)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	EQ
BEQ	L_vRF4463RxCommand178
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+3)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+3)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	EQ
BEQ	L_vRF4463RxCommand179
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+3)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+3)
LDRB	R0, [R0, #0]
CMP	R0, #6
IT	EQ
BEQ	L_vRF4463RxCommand180
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+3)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+3)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	EQ
BEQ	L_vRF4463RxCommand181
IT	AL
BAL	L_vRF4463RxCommand182
L_vRF4463RxCommand156:
;rf4463handler.c,449 :: 		}
L_end_vRF4463RxCommand:
LDR	LR, [SP, #0]
ADD	SP, SP, #60
BX	LR
; end of _vRF4463RxCommand
_vRF4463RxFTY:
;rf4463handler.c,454 :: 		void vRF4463RxFTY(){
SUBW	SP, SP, #808
STR	LR, [SP, #0]
;rf4463handler.c,458 :: 		uint16_t usCounter = 0;
;rf4463handler.c,459 :: 		uint8_t ucPosition = 0;
; ucPosition start address is: 32 (R8)
MOVW	R8, #0
;rf4463handler.c,475 :: 		if( pcRF4463RxBuffer[ RF_MESSAGE_DESTINATION ] == NODE_FACTORY ){
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+1)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+1)
LDRB	R0, [R0, #0]
CMP	R0, #254
IT	NE
BNE	L_vRF4463RxFTY183
;rf4463handler.c,476 :: 		switch( pcRF4463RxBuffer[ RF_MESSAGE_TABLE ] ){
IT	AL
BAL	L_vRF4463RxFTY184
;rf4463handler.c,477 :: 		case TABLE_RF_TEST:
L_vRF4463RxFTY186:
;rf4463handler.c,478 :: 		switch( pcRF4463RxBuffer[ RF_MESSAGE_COMMAND ] ){
IT	AL
BAL	L_vRF4463RxFTY187
; ucPosition end address is: 32 (R8)
;rf4463handler.c,479 :: 		case RF_TEST_LOOP:
L_vRF4463RxFTY189:
;rf4463handler.c,481 :: 		vRF4463SetNode( NODE_FACTORY );
MOVS	R0, #254
BL	_vRF4463SetNode+0
;rf4463handler.c,482 :: 		vRF4463TxMessage( &pcRF4463RxBuffer[ RF_MESSAGE_CONTENT ], ( pcRF4463RxBuffer[ RF_MESSAGE_SIZE ] - RF_MESSAGE_HEADER_SIZE ), NODE_BROADCAST, TABLE_RF_TEST, RF_TEST_LOOP );
MOVS	R1, #5
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
LDRB	R0, [R0, #0]
SUBS	R0, R0, #5
PUSH	(R1)
MOVS	R3, #1
MOVS	R2, #255
UXTB	R1, R0
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+5)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+5)
BL	_vRF4463TxMessage+0
ADD	SP, SP, #4
;rf4463handler.c,483 :: 		break;
IT	AL
BAL	L_vRF4463RxFTY188
;rf4463handler.c,484 :: 		case RF_TEST_QR:
L_vRF4463RxFTY190:
;rf4463handler.c,485 :: 		UART1_Write_Text( "RCV|" );
MOVS	R0, #82
STRB	R0, [SP, #744]
MOVS	R0, #67
STRB	R0, [SP, #745]
MOVS	R0, #86
STRB	R0, [SP, #746]
MOVS	R0, #124
STRB	R0, [SP, #747]
MOVS	R0, #0
STRB	R0, [SP, #748]
ADD	R0, SP, #744
BL	_UART1_Write_Text+0
;rf4463handler.c,486 :: 		for( usCounter = RF_MESSAGE_CONTENT; usCounter < pcRF4463RxBuffer[ RF_MESSAGE_SIZE ]; usCounter++ ){
; usCounter start address is: 16 (R4)
MOVS	R4, #5
; usCounter end address is: 16 (R4)
L_vRF4463RxFTY191:
; usCounter start address is: 16 (R4)
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
LDRB	R0, [R0, #0]
CMP	R4, R0
IT	CS
BCS	L_vRF4463RxFTY192
;rf4463handler.c,487 :: 		UART1_Write( pcRF4463RxBuffer[ usCounter ] );
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
ADDS	R0, R0, R4
LDRB	R0, [R0, #0]
BL	_UART1_Write+0
;rf4463handler.c,486 :: 		for( usCounter = RF_MESSAGE_CONTENT; usCounter < pcRF4463RxBuffer[ RF_MESSAGE_SIZE ]; usCounter++ ){
ADDS	R4, R4, #1
UXTH	R4, R4
;rf4463handler.c,488 :: 		}
; usCounter end address is: 16 (R4)
IT	AL
BAL	L_vRF4463RxFTY191
L_vRF4463RxFTY192:
;rf4463handler.c,489 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;rf4463handler.c,490 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;rf4463handler.c,491 :: 		break;
IT	AL
BAL	L_vRF4463RxFTY188
;rf4463handler.c,492 :: 		case RF_TEST_OK:
L_vRF4463RxFTY194:
;rf4463handler.c,493 :: 		for( usCounter = 0; usCounter < 12; usCounter++ ){
; usCounter start address is: 12 (R3)
MOVS	R3, #0
; usCounter end address is: 12 (R3)
L_vRF4463RxFTY195:
; usCounter start address is: 12 (R3)
CMP	R3, #12
IT	CS
BCS	L_vRF4463RxFTY196
;rf4463handler.c,494 :: 		pcReceivedQR[ usCounter ] = pcRF4463RxBuffer[ RF_MESSAGE_CONTENT + usCounter ];
MOVW	R0, #lo_addr(main_pcReceivedQR+0)
MOVT	R0, #hi_addr(main_pcReceivedQR+0)
ADDS	R2, R0, R3
ADDS	R1, R3, #5
UXTH	R1, R1
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;rf4463handler.c,493 :: 		for( usCounter = 0; usCounter < 12; usCounter++ ){
ADDS	R3, R3, #1
UXTH	R3, R3
;rf4463handler.c,495 :: 		}
; usCounter end address is: 12 (R3)
IT	AL
BAL	L_vRF4463RxFTY195
L_vRF4463RxFTY196:
;rf4463handler.c,497 :: 		if( memcmp( pcReceivedQR, pcSentQR, 12 ) == 0 ){
MOVS	R2, #12
SXTH	R2, R2
MOVW	R1, #lo_addr(main_pcSentQR+0)
MOVT	R1, #hi_addr(main_pcSentQR+0)
MOVW	R0, #lo_addr(main_pcReceivedQR+0)
MOVT	R0, #hi_addr(main_pcReceivedQR+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463RxFTY198
;rf4463handler.c,498 :: 		UART1_Write_Text( "FINISH|" );
ADDW	R11, SP, #749
ADD	R10, R11, #8
MOVW	R12, #lo_addr(?ICS?lstr97_main+0)
MOVT	R12, #hi_addr(?ICS?lstr97_main+0)
BL	___CC2DW+0
ADDW	R0, SP, #749
BL	_UART1_Write_Text+0
;rf4463handler.c,499 :: 		for( usCounter = 0; usCounter < 12; usCounter++ ){
; usCounter start address is: 16 (R4)
MOVS	R4, #0
; usCounter end address is: 16 (R4)
L_vRF4463RxFTY199:
; usCounter start address is: 16 (R4)
CMP	R4, #12
IT	CS
BCS	L_vRF4463RxFTY200
;rf4463handler.c,500 :: 		UART1_Write( pcReceivedQR[ usCounter ] );
MOVW	R0, #lo_addr(main_pcReceivedQR+0)
MOVT	R0, #hi_addr(main_pcReceivedQR+0)
ADDS	R0, R0, R4
LDRB	R0, [R0, #0]
BL	_UART1_Write+0
;rf4463handler.c,499 :: 		for( usCounter = 0; usCounter < 12; usCounter++ ){
ADDS	R4, R4, #1
UXTH	R4, R4
;rf4463handler.c,501 :: 		}
; usCounter end address is: 16 (R4)
IT	AL
BAL	L_vRF4463RxFTY199
L_vRF4463RxFTY200:
;rf4463handler.c,502 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;rf4463handler.c,503 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;rf4463handler.c,504 :: 		}
L_vRF4463RxFTY198:
;rf4463handler.c,505 :: 		break;
IT	AL
BAL	L_vRF4463RxFTY188
;rf4463handler.c,506 :: 		case RF_TEST_MESSAGE:
L_vRF4463RxFTY202:
;rf4463handler.c,507 :: 		UART1_Write_Text( "RCV|" );
MOVS	R0, #82
STRB	R0, [SP, #757]
MOVS	R0, #67
STRB	R0, [SP, #758]
MOVS	R0, #86
STRB	R0, [SP, #759]
MOVS	R0, #124
STRB	R0, [SP, #760]
MOVS	R0, #0
STRB	R0, [SP, #761]
ADDW	R0, SP, #757
BL	_UART1_Write_Text+0
;rf4463handler.c,508 :: 		for( usCounter = RF_MESSAGE_CONTENT; usCounter < pcRF4463RxBuffer[ RF_MESSAGE_SIZE ]; usCounter++ ){
; usCounter start address is: 16 (R4)
MOVS	R4, #5
; usCounter end address is: 16 (R4)
L_vRF4463RxFTY203:
; usCounter start address is: 16 (R4)
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
LDRB	R0, [R0, #0]
CMP	R4, R0
IT	CS
BCS	L_vRF4463RxFTY204
;rf4463handler.c,509 :: 		UART1_Write( pcRF4463RxBuffer[ usCounter ] );
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
ADDS	R0, R0, R4
LDRB	R0, [R0, #0]
BL	_UART1_Write+0
;rf4463handler.c,508 :: 		for( usCounter = RF_MESSAGE_CONTENT; usCounter < pcRF4463RxBuffer[ RF_MESSAGE_SIZE ]; usCounter++ ){
ADDS	R4, R4, #1
UXTH	R4, R4
;rf4463handler.c,510 :: 		}
; usCounter end address is: 16 (R4)
IT	AL
BAL	L_vRF4463RxFTY203
L_vRF4463RxFTY204:
;rf4463handler.c,511 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;rf4463handler.c,512 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;rf4463handler.c,513 :: 		break;
IT	AL
BAL	L_vRF4463RxFTY188
;rf4463handler.c,514 :: 		case RF_TEST_DONGLE_SEARCH:
L_vRF4463RxFTY206:
;rf4463handler.c,516 :: 		if( ucSearchActive == 0 ){
MOVW	R0, #lo_addr(_ucSearchActive+0)
MOVT	R0, #hi_addr(_ucSearchActive+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_vRF4463RxFTY207
;rf4463handler.c,517 :: 		ucSearchActive = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucSearchActive+0)
MOVT	R0, #hi_addr(_ucSearchActive+0)
STRB	R1, [R0, #0]
;rf4463handler.c,518 :: 		vTimerSearchLed();
BL	_vTimerSearchLed+0
;rf4463handler.c,519 :: 		}
IT	AL
BAL	L_vRF4463RxFTY208
L_vRF4463RxFTY207:
;rf4463handler.c,521 :: 		ucSearchActive = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucSearchActive+0)
MOVT	R0, #hi_addr(_ucSearchActive+0)
STRB	R1, [R0, #0]
;rf4463handler.c,522 :: 		vTimerStop( TIMER_SEARCH );
MOVS	R0, #0
BL	_vTimerStop+0
;rf4463handler.c,523 :: 		LEDGreen = On;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;rf4463handler.c,524 :: 		}
L_vRF4463RxFTY208:
;rf4463handler.c,525 :: 		break;
IT	AL
BAL	L_vRF4463RxFTY188
;rf4463handler.c,526 :: 		case RF_TEST_INFO:
L_vRF4463RxFTY209:
;rf4463handler.c,527 :: 		for( usCounter = 0; usCounter < ( pcRF4463RxBuffer[ RF_MESSAGE_SIZE ] - RF_MESSAGE_HEADER_SIZE ); usCounter++ ){
; ucPosition start address is: 32 (R8)
; usCounter start address is: 36 (R9)
MOVW	R9, #0
; usCounter end address is: 36 (R9)
; ucPosition end address is: 32 (R8)
L_vRF4463RxFTY210:
; usCounter start address is: 36 (R9)
; ucPosition start address is: 32 (R8)
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
LDRB	R0, [R0, #0]
SUBS	R0, R0, #5
SXTH	R0, R0
CMP	R9, R0
IT	CS
BCS	L_vRF4463RxFTY211
;rf4463handler.c,528 :: 		pcTempBuffer[ usCounter ] = pcRF4463RxBuffer[ usCounter + RF_MESSAGE_CONTENT ];
ADD	R0, SP, #8
ADD	R2, R0, R9, LSL #0
ADD	R1, R9, #5
UXTH	R1, R1
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;rf4463handler.c,527 :: 		for( usCounter = 0; usCounter < ( pcRF4463RxBuffer[ RF_MESSAGE_SIZE ] - RF_MESSAGE_HEADER_SIZE ); usCounter++ ){
ADD	R9, R9, #1
UXTH	R9, R9
;rf4463handler.c,529 :: 		}
IT	AL
BAL	L_vRF4463RxFTY210
L_vRF4463RxFTY211:
;rf4463handler.c,530 :: 		memset( pcRxRF4463AuxBuffer, '\0', RF_MAX_BUFFER_LENGTH );
MOVS	R2, #64
SXTH	R2, R2
MOVS	R1, #0
MOVW	R0, #lo_addr(_pcRxRF4463AuxBuffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463AuxBuffer+0)
BL	_memset+0
;rf4463handler.c,531 :: 		vXORRFMessage( pcTempBuffer, pcRxRF4463AuxBuffer, usCounter );
ADD	R0, SP, #8
UXTB	R2, R9
; usCounter end address is: 36 (R9)
MOVW	R1, #lo_addr(_pcRxRF4463AuxBuffer+0)
MOVT	R1, #hi_addr(_pcRxRF4463AuxBuffer+0)
BL	_vXORRFMessage+0
;rf4463handler.c,532 :: 		switch( pcRxRF4463AuxBuffer[ ucPosition++ ] ){
UXTB	R1, R8
ADD	R7, R8, #1
UXTB	R7, R7
; ucPosition end address is: 32 (R8)
; ucPosition start address is: 28 (R7)
MOVW	R0, #lo_addr(_pcRxRF4463AuxBuffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463AuxBuffer+0)
ADDS	R0, R0, R1
STR	R0, [SP, #804]
IT	AL
BAL	L_vRF4463RxFTY213
;rf4463handler.c,533 :: 		case DEVICE_MODEL_ID_HUB:
L_vRF4463RxFTY215:
;rf4463handler.c,534 :: 		UART1_Write_Text( "QR: " );
MOVS	R0, #81
STRB	R0, [SP, #762]
MOVS	R0, #82
STRB	R0, [SP, #763]
MOVS	R0, #58
STRB	R0, [SP, #764]
MOVS	R0, #32
STRB	R0, [SP, #765]
MOVS	R0, #0
STRB	R0, [SP, #766]
ADDW	R0, SP, #762
BL	_UART1_Write_Text+0
;rf4463handler.c,535 :: 		for( usCounter = 0; usCounter < 12; usCounter++ ){
; usCounter start address is: 16 (R4)
MOVS	R4, #0
; ucPosition end address is: 28 (R7)
; usCounter end address is: 16 (R4)
L_vRF4463RxFTY216:
; usCounter start address is: 16 (R4)
; ucPosition start address is: 28 (R7)
CMP	R4, #12
IT	CS
BCS	L_vRF4463RxFTY217
;rf4463handler.c,536 :: 		UART1_Write( pcRxRF4463AuxBuffer[ ucPosition++ ] );
MOVW	R0, #lo_addr(_pcRxRF4463AuxBuffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463AuxBuffer+0)
ADDS	R0, R0, R7
LDRB	R0, [R0, #0]
BL	_UART1_Write+0
ADDS	R7, R7, #1
UXTB	R7, R7
;rf4463handler.c,535 :: 		for( usCounter = 0; usCounter < 12; usCounter++ ){
ADDS	R4, R4, #1
UXTH	R4, R4
;rf4463handler.c,537 :: 		}
; usCounter end address is: 16 (R4)
IT	AL
BAL	L_vRF4463RxFTY216
L_vRF4463RxFTY217:
;rf4463handler.c,538 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;rf4463handler.c,539 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;rf4463handler.c,541 :: 		for( usCounter = 0; usCounter < 12; usCounter++ ){
; usCounter start address is: 8 (R2)
MOVS	R2, #0
; ucPosition end address is: 28 (R7)
; usCounter end address is: 8 (R2)
L_vRF4463RxFTY219:
; usCounter start address is: 8 (R2)
; ucPosition start address is: 28 (R7)
CMP	R2, #12
IT	CS
BCS	L_vRF4463RxFTY220
;rf4463handler.c,542 :: 		pcUIDHex[ usCounter ] = pcRxRF4463AuxBuffer[ ucPosition++ ];
ADD	R0, SP, #161
ADDS	R1, R0, R2
MOVW	R0, #lo_addr(_pcRxRF4463AuxBuffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463AuxBuffer+0)
ADDS	R0, R0, R7
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
ADDS	R7, R7, #1
UXTB	R7, R7
;rf4463handler.c,541 :: 		for( usCounter = 0; usCounter < 12; usCounter++ ){
ADDS	R2, R2, #1
UXTH	R2, R2
;rf4463handler.c,543 :: 		}
; usCounter end address is: 8 (R2)
IT	AL
BAL	L_vRF4463RxFTY219
L_vRF4463RxFTY220:
;rf4463handler.c,545 :: 		vSerializeUUID( pcUIDText, pcUIDHex );
ADD	R1, SP, #161
ADD	R0, SP, #136
BL	_vSerializeUUID+0
;rf4463handler.c,547 :: 		UART1_Write_Text( "UID: " );
MOVS	R0, #85
STRB	R0, [SP, #767]
MOVS	R0, #73
STRB	R0, [SP, #768]
MOVS	R0, #68
STRB	R0, [SP, #769]
MOVS	R0, #58
STRB	R0, [SP, #770]
MOVS	R0, #32
STRB	R0, [SP, #771]
MOVS	R0, #0
STRB	R0, [SP, #772]
ADDW	R0, SP, #767
BL	_UART1_Write_Text+0
;rf4463handler.c,548 :: 		UART1_Write_Text( pcUIDText );
ADD	R0, SP, #136
BL	_UART1_Write_Text+0
;rf4463handler.c,549 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;rf4463handler.c,550 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;rf4463handler.c,552 :: 		for( usCounter = 0; usCounter < 6; usCounter++ ){
; usCounter start address is: 8 (R2)
MOVS	R2, #0
; ucPosition end address is: 28 (R7)
; usCounter end address is: 8 (R2)
UXTB	R8, R7
L_vRF4463RxFTY222:
; usCounter start address is: 8 (R2)
; ucPosition start address is: 32 (R8)
CMP	R2, #6
IT	CS
BCS	L_vRF4463RxFTY223
;rf4463handler.c,553 :: 		pcMACHex[ usCounter ] = pcRxRF4463AuxBuffer[ ucPosition++ ];
ADD	R0, SP, #194
ADDS	R1, R0, R2
MOVW	R0, #lo_addr(_pcRxRF4463AuxBuffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463AuxBuffer+0)
ADD	R0, R0, R8, LSL #0
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
ADD	R8, R8, #1
UXTB	R8, R8
;rf4463handler.c,552 :: 		for( usCounter = 0; usCounter < 6; usCounter++ ){
ADDS	R2, R2, #1
UXTH	R2, R2
;rf4463handler.c,554 :: 		}
; usCounter end address is: 8 (R2)
IT	AL
BAL	L_vRF4463RxFTY222
L_vRF4463RxFTY223:
;rf4463handler.c,555 :: 		vSerializeMACAddress( pcMACText, pcMACHex );
ADD	R1, SP, #194
ADD	R0, SP, #174
BL	_vSerializeMACAddress+0
;rf4463handler.c,556 :: 		UART1_Write_Text( "MAC: " );
MOVS	R0, #77
STRB	R0, [SP, #773]
MOVS	R0, #65
STRB	R0, [SP, #774]
MOVS	R0, #67
STRB	R0, [SP, #775]
MOVS	R0, #58
STRB	R0, [SP, #776]
MOVS	R0, #32
STRB	R0, [SP, #777]
MOVS	R0, #0
STRB	R0, [SP, #778]
ADDW	R0, SP, #773
BL	_UART1_Write_Text+0
;rf4463handler.c,557 :: 		UART1_Write_Text( pcMACText );
ADD	R0, SP, #174
BL	_UART1_Write_Text+0
;rf4463handler.c,558 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;rf4463handler.c,559 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;rf4463handler.c,561 :: 		for( usCounter = 0; usCounter < 4; usCounter++ ){
; usCounter start address is: 8 (R2)
MOVS	R2, #0
; ucPosition end address is: 32 (R8)
; usCounter end address is: 8 (R2)
UXTB	R3, R8
L_vRF4463RxFTY225:
; usCounter start address is: 8 (R2)
; ucPosition start address is: 12 (R3)
CMP	R2, #4
IT	CS
BCS	L_vRF4463RxFTY226
;rf4463handler.c,562 :: 		pcIPHex[ usCounter ] = pcRxRF4463AuxBuffer[ ucPosition++ ];
ADD	R0, SP, #226
ADDS	R1, R0, R2
MOVW	R0, #lo_addr(_pcRxRF4463AuxBuffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463AuxBuffer+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
ADDS	R3, R3, #1
UXTB	R3, R3
;rf4463handler.c,561 :: 		for( usCounter = 0; usCounter < 4; usCounter++ ){
ADDS	R2, R2, #1
UXTH	R2, R2
;rf4463handler.c,563 :: 		}
; usCounter end address is: 8 (R2)
IT	AL
BAL	L_vRF4463RxFTY225
L_vRF4463RxFTY226:
;rf4463handler.c,564 :: 		vSerializeIPAddress( pcIPText, pcIPHex );
ADD	R1, SP, #226
ADD	R0, SP, #206
STRB	R3, [SP, #4]
BL	_vSerializeIPAddress+0
;rf4463handler.c,565 :: 		UART1_Write_Text( "IP: " );
MOVS	R0, #73
STRB	R0, [SP, #779]
MOVS	R0, #80
STRB	R0, [SP, #780]
MOVS	R0, #58
STRB	R0, [SP, #781]
MOVS	R0, #32
STRB	R0, [SP, #782]
MOVS	R0, #0
STRB	R0, [SP, #783]
ADDW	R0, SP, #779
BL	_UART1_Write_Text+0
;rf4463handler.c,566 :: 		UART1_Write_Text( pcIPText );
ADD	R0, SP, #206
BL	_UART1_Write_Text+0
;rf4463handler.c,567 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;rf4463handler.c,568 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;rf4463handler.c,570 :: 		memset( pcTempBuffer, '\0', NULL );
ADD	R0, SP, #8
MOVS	R2, #0
SXTH	R2, R2
MOVS	R1, #0
BL	_memset+0
LDRB	R3, [SP, #4]
;rf4463handler.c,571 :: 		sprintf( pcTempBuffer, "Ver: %d.%d.%d\r\n", pcRxRF4463AuxBuffer[ ucPosition++ ], pcRxRF4463AuxBuffer[ ucPosition++ ], pcRxRF4463AuxBuffer[ ucPosition++ ] );
MOVW	R0, #lo_addr(_pcRxRF4463AuxBuffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463AuxBuffer+0)
ADDS	R0, R0, R3
; ucPosition end address is: 12 (R3)
LDRB	R0, [R0, #0]
UXTB	R4, R0
UXTB	R3, R0
UXTB	R2, R0
MOVW	R1, #lo_addr(?lstr_103_main+0)
MOVT	R1, #hi_addr(?lstr_103_main+0)
ADD	R0, SP, #8
PUSH	(R4)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #20
;rf4463handler.c,572 :: 		UART1_Write_Text( pcTempBuffer );
ADD	R0, SP, #8
BL	_UART1_Write_Text+0
;rf4463handler.c,573 :: 		break;
IT	AL
BAL	L_vRF4463RxFTY214
;rf4463handler.c,574 :: 		case DEVICE_MODEL_ID_SWITCH:
L_vRF4463RxFTY228:
;rf4463handler.c,575 :: 		break;
IT	AL
BAL	L_vRF4463RxFTY214
;rf4463handler.c,576 :: 		case DEVICE_MODEL_ID_DIMMER:
L_vRF4463RxFTY229:
;rf4463handler.c,577 :: 		break;
IT	AL
BAL	L_vRF4463RxFTY214
;rf4463handler.c,578 :: 		case DEVICE_MODEL_ID_OUTLET:
L_vRF4463RxFTY230:
;rf4463handler.c,579 :: 		break;
IT	AL
BAL	L_vRF4463RxFTY214
;rf4463handler.c,580 :: 		}
L_vRF4463RxFTY213:
; ucPosition start address is: 28 (R7)
LDR	R1, [SP, #804]
LDRB	R0, [R1, #0]
CMP	R0, #1
IT	EQ
BEQ	L_vRF4463RxFTY215
; ucPosition end address is: 28 (R7)
LDRB	R0, [R1, #0]
CMP	R0, #2
IT	EQ
BEQ	L_vRF4463RxFTY228
LDRB	R0, [R1, #0]
CMP	R0, #3
IT	EQ
BEQ	L_vRF4463RxFTY229
LDRB	R0, [R1, #0]
CMP	R0, #4
IT	EQ
BEQ	L_vRF4463RxFTY230
L_vRF4463RxFTY214:
;rf4463handler.c,581 :: 		break;
IT	AL
BAL	L_vRF4463RxFTY188
;rf4463handler.c,582 :: 		}
L_vRF4463RxFTY187:
; ucPosition start address is: 32 (R8)
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+4)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+4)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	EQ
BEQ	L_vRF4463RxFTY189
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+4)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+4)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_vRF4463RxFTY190
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+4)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+4)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_vRF4463RxFTY194
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+4)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+4)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	EQ
BEQ	L_vRF4463RxFTY202
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+4)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+4)
LDRB	R0, [R0, #0]
CMP	R0, #200
IT	EQ
BEQ	L_vRF4463RxFTY206
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+4)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+4)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	EQ
BEQ	L_vRF4463RxFTY209
; ucPosition end address is: 32 (R8)
L_vRF4463RxFTY188:
;rf4463handler.c,583 :: 		break;
IT	AL
BAL	L_vRF4463RxFTY185
;rf4463handler.c,584 :: 		case TABLE_RF_SETUP:
L_vRF4463RxFTY231:
;rf4463handler.c,585 :: 		switch( pcRF4463RxBuffer[ RF_MESSAGE_COMMAND ] ){
IT	AL
BAL	L_vRF4463RxFTY232
;rf4463handler.c,586 :: 		case RF_SETUP_FTY_DISCOVER:
L_vRF4463RxFTY234:
;rf4463handler.c,587 :: 		memset( pcTempConvBuffer, '\0', RF_MAX_BUFFER_LENGTH );
ADD	R0, SP, #72
MOVS	R2, #64
SXTH	R2, R2
MOVS	R1, #0
BL	_memset+0
;rf4463handler.c,588 :: 		memset( pcTempBuffer, '\0', RF_MAX_BUFFER_LENGTH );
ADD	R0, SP, #8
MOVS	R2, #64
SXTH	R2, R2
MOVS	R1, #0
BL	_memset+0
;rf4463handler.c,589 :: 		for( usCounter = 0; usCounter < 12; usCounter++ ){
; usCounter start address is: 12 (R3)
MOVS	R3, #0
; usCounter end address is: 12 (R3)
L_vRF4463RxFTY235:
; usCounter start address is: 12 (R3)
CMP	R3, #12
IT	CS
BCS	L_vRF4463RxFTY236
;rf4463handler.c,590 :: 		pcTempBuffer[ usCounter ] = pcRF4463RxBuffer[ RF_MESSAGE_CONTENT + usCounter ];
ADD	R0, SP, #8
ADDS	R2, R0, R3
ADDS	R1, R3, #5
UXTH	R1, R1
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;rf4463handler.c,589 :: 		for( usCounter = 0; usCounter < 12; usCounter++ ){
ADDS	R3, R3, #1
UXTH	R3, R3
;rf4463handler.c,591 :: 		}
; usCounter end address is: 12 (R3)
IT	AL
BAL	L_vRF4463RxFTY235
L_vRF4463RxFTY236:
;rf4463handler.c,593 :: 		vHexToASCII( pcTempConvBuffer, pcTempBuffer, 12 );
ADD	R1, SP, #8
ADD	R0, SP, #72
MOVS	R2, #12
BL	_vHexToASCII+0
;rf4463handler.c,595 :: 		UART1_Write_Text( "UID: " );
MOVS	R0, #85
STRB	R0, [SP, #784]
MOVS	R0, #73
STRB	R0, [SP, #785]
MOVS	R0, #68
STRB	R0, [SP, #786]
MOVS	R0, #58
STRB	R0, [SP, #787]
MOVS	R0, #32
STRB	R0, [SP, #788]
MOVS	R0, #0
STRB	R0, [SP, #789]
ADD	R0, SP, #784
BL	_UART1_Write_Text+0
;rf4463handler.c,596 :: 		UART1_Write_Text( pcTempConvBuffer );
ADD	R0, SP, #72
BL	_UART1_Write_Text+0
;rf4463handler.c,597 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;rf4463handler.c,598 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;rf4463handler.c,599 :: 		break;
IT	AL
BAL	L_vRF4463RxFTY233
;rf4463handler.c,600 :: 		}
L_vRF4463RxFTY232:
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+4)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+4)
LDRB	R0, [R0, #0]
CMP	R0, #11
IT	EQ
BEQ	L_vRF4463RxFTY234
L_vRF4463RxFTY233:
;rf4463handler.c,601 :: 		break;
IT	AL
BAL	L_vRF4463RxFTY185
;rf4463handler.c,602 :: 		}
L_vRF4463RxFTY184:
; ucPosition start address is: 32 (R8)
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+3)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+3)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_vRF4463RxFTY186
; ucPosition end address is: 32 (R8)
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+3)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+3)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_vRF4463RxFTY231
L_vRF4463RxFTY185:
;rf4463handler.c,603 :: 		}
IT	AL
BAL	L_vRF4463RxFTY238
L_vRF4463RxFTY183:
;rf4463handler.c,607 :: 		else if( pcRF4463RxBuffer[ RF_MESSAGE_DESTINATION ] == HUB_NODE ){
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+1)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+1)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_vRF4463RxFTY239
;rf4463handler.c,608 :: 		switch( pcRF4463RxBuffer[ RF_MESSAGE_TABLE ] ){
IT	AL
BAL	L_vRF4463RxFTY240
;rf4463handler.c,609 :: 		case RF_SETUP_TABLE:
L_vRF4463RxFTY242:
;rf4463handler.c,610 :: 		switch( pcRF4463RxBuffer[ RF_MESSAGE_COMMAND ] ){
IT	AL
BAL	L_vRF4463RxFTY243
;rf4463handler.c,611 :: 		case RF_SETUP_FIND_BY_QR:
L_vRF4463RxFTY245:
;rf4463handler.c,612 :: 		memset( pcTempConvBuffer, '\0', RF_MAX_BUFFER_LENGTH );
ADD	R0, SP, #72
MOVS	R2, #64
SXTH	R2, R2
MOVS	R1, #0
BL	_memset+0
;rf4463handler.c,613 :: 		for( usCounter = 0; usCounter < 12; usCounter++ ){
; usCounter start address is: 12 (R3)
MOVS	R3, #0
; usCounter end address is: 12 (R3)
L_vRF4463RxFTY246:
; usCounter start address is: 12 (R3)
CMP	R3, #12
IT	CS
BCS	L_vRF4463RxFTY247
;rf4463handler.c,614 :: 		pcTempBuffer[ usCounter ] = pcRF4463RxBuffer[ RF_MESSAGE_CONTENT + usCounter ];
ADD	R0, SP, #8
ADDS	R2, R0, R3
ADDS	R1, R3, #5
UXTH	R1, R1
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;rf4463handler.c,613 :: 		for( usCounter = 0; usCounter < 12; usCounter++ ){
ADDS	R3, R3, #1
UXTH	R3, R3
;rf4463handler.c,615 :: 		}
; usCounter end address is: 12 (R3)
IT	AL
BAL	L_vRF4463RxFTY246
L_vRF4463RxFTY247:
;rf4463handler.c,616 :: 		vHexToASCII( pcTempConvBuffer, pcTempBuffer, 12 );
ADD	R1, SP, #8
ADD	R0, SP, #72
MOVS	R2, #12
BL	_vHexToASCII+0
;rf4463handler.c,618 :: 		UART1_Write_Text( "UID: " );
MOVS	R0, #85
STRB	R0, [SP, #790]
MOVS	R0, #73
STRB	R0, [SP, #791]
MOVS	R0, #68
STRB	R0, [SP, #792]
MOVS	R0, #58
STRB	R0, [SP, #793]
MOVS	R0, #32
STRB	R0, [SP, #794]
MOVS	R0, #0
STRB	R0, [SP, #795]
ADDW	R0, SP, #790
BL	_UART1_Write_Text+0
;rf4463handler.c,619 :: 		UART1_Write_Text( pcTempConvBuffer );
ADD	R0, SP, #72
BL	_UART1_Write_Text+0
;rf4463handler.c,620 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;rf4463handler.c,621 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;rf4463handler.c,623 :: 		memset( pcJSONBuffer, '\0', 512 );
ADD	R0, SP, #232
MOVW	R2, #512
SXTH	R2, R2
MOVS	R1, #0
BL	_memset+0
;rf4463handler.c,624 :: 		sprintf( pcJSONBuffer, "{\"qrCode\":\"%s\",\"location\":1,\"mac\":\"\",\"modelId\":%d,\"uuiddevice\":\"%s\"}\r\n", pcTempQR, ucSearchedModelId, pcTempConvBuffer );
ADD	R4, SP, #72
MOVW	R0, #lo_addr(_ucSearchedModelId+0)
MOVT	R0, #hi_addr(_ucSearchedModelId+0)
LDRB	R3, [R0, #0]
MOVW	R2, #lo_addr(_pcTempQR+0)
MOVT	R2, #hi_addr(_pcTempQR+0)
MOVW	R1, #lo_addr(?lstr_106_main+0)
MOVT	R1, #hi_addr(?lstr_106_main+0)
ADD	R0, SP, #232
PUSH	(R4)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #20
;rf4463handler.c,626 :: 		UART1_Write_Text( pcJSONBuffer );
ADD	R0, SP, #232
BL	_UART1_Write_Text+0
;rf4463handler.c,627 :: 		break;
IT	AL
BAL	L_vRF4463RxFTY244
;rf4463handler.c,628 :: 		case RF_SETUP_FTY_DISCOVER:
L_vRF4463RxFTY249:
;rf4463handler.c,629 :: 		memset( pcTempConvBuffer, '\0', RF_MAX_BUFFER_LENGTH );
ADD	R0, SP, #72
MOVS	R2, #64
SXTH	R2, R2
MOVS	R1, #0
BL	_memset+0
;rf4463handler.c,630 :: 		memset( pcTempBuffer, '\0', RF_MAX_BUFFER_LENGTH );
ADD	R0, SP, #8
MOVS	R2, #64
SXTH	R2, R2
MOVS	R1, #0
BL	_memset+0
;rf4463handler.c,631 :: 		for( usCounter = 0; usCounter < 12; usCounter++ ){
; usCounter start address is: 12 (R3)
MOVS	R3, #0
; usCounter end address is: 12 (R3)
L_vRF4463RxFTY250:
; usCounter start address is: 12 (R3)
CMP	R3, #12
IT	CS
BCS	L_vRF4463RxFTY251
;rf4463handler.c,632 :: 		pcTempBuffer[ usCounter ] = pcRF4463RxBuffer[ RF_MESSAGE_CONTENT + usCounter ];
ADD	R0, SP, #8
ADDS	R2, R0, R3
ADDS	R1, R3, #5
UXTH	R1, R1
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;rf4463handler.c,631 :: 		for( usCounter = 0; usCounter < 12; usCounter++ ){
ADDS	R3, R3, #1
UXTH	R3, R3
;rf4463handler.c,633 :: 		}
; usCounter end address is: 12 (R3)
IT	AL
BAL	L_vRF4463RxFTY250
L_vRF4463RxFTY251:
;rf4463handler.c,635 :: 		vHexToASCII( pcTempConvBuffer, pcTempBuffer, 12 );
ADD	R1, SP, #8
ADD	R0, SP, #72
MOVS	R2, #12
BL	_vHexToASCII+0
;rf4463handler.c,637 :: 		UART1_Write_Text( "UID: " );
MOVS	R0, #85
STRB	R0, [SP, #796]
MOVS	R0, #73
STRB	R0, [SP, #797]
MOVS	R0, #68
STRB	R0, [SP, #798]
MOVS	R0, #58
STRB	R0, [SP, #799]
MOVS	R0, #32
STRB	R0, [SP, #800]
MOVS	R0, #0
STRB	R0, [SP, #801]
ADD	R0, SP, #796
BL	_UART1_Write_Text+0
;rf4463handler.c,638 :: 		UART1_Write_Text( pcTempConvBuffer );
ADD	R0, SP, #72
BL	_UART1_Write_Text+0
;rf4463handler.c,639 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;rf4463handler.c,640 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;rf4463handler.c,641 :: 		break;
IT	AL
BAL	L_vRF4463RxFTY244
;rf4463handler.c,642 :: 		}
L_vRF4463RxFTY243:
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+4)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+4)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_vRF4463RxFTY245
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+4)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+4)
LDRB	R0, [R0, #0]
CMP	R0, #11
IT	EQ
BEQ	L_vRF4463RxFTY249
L_vRF4463RxFTY244:
;rf4463handler.c,643 :: 		break;
IT	AL
BAL	L_vRF4463RxFTY241
;rf4463handler.c,644 :: 		}
L_vRF4463RxFTY240:
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+3)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+3)
LDRB	R0, [R0, #0]
CMP	R0, #14
IT	EQ
BEQ	L_vRF4463RxFTY242
L_vRF4463RxFTY241:
;rf4463handler.c,645 :: 		}
L_vRF4463RxFTY239:
L_vRF4463RxFTY238:
;rf4463handler.c,646 :: 		}
L_end_vRF4463RxFTY:
LDR	LR, [SP, #0]
ADDW	SP, SP, #808
BX	LR
; end of _vRF4463RxFTY
_ucRF4463GetIRQFlag:
;rf4463handler.c,654 :: 		uint8_t ucRF4463GetIRQFlag(){
;rf4463handler.c,655 :: 		return ucRF4463IRQ;
MOVW	R0, #lo_addr(main_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(main_ucRF4463IRQ+0)
LDRB	R0, [R0, #0]
;rf4463handler.c,656 :: 		}
L_end_ucRF4463GetIRQFlag:
BX	LR
; end of _ucRF4463GetIRQFlag
_vRF4463ResetIRQFlag:
;rf4463handler.c,661 :: 		void vRF4463ResetIRQFlag(){
;rf4463handler.c,662 :: 		ucRF4463IRQ = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(main_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(main_ucRF4463IRQ+0)
STRB	R1, [R0, #0]
;rf4463handler.c,663 :: 		}
L_end_vRF4463ResetIRQFlag:
BX	LR
; end of _vRF4463ResetIRQFlag
_vRF4463SetPinSelect:
;rf4463handler.c,668 :: 		void vRF4463SetPinSelect( uint8_t ucPinVal ){
; ucPinVal start address is: 0 (R0)
; ucPinVal end address is: 0 (R0)
; ucPinVal start address is: 0 (R0)
;rf4463handler.c,669 :: 		RF4463nSEL = ucPinVal;
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
_SX	[R1, ByteOffset(GPIOB_ODR+0)]
; ucPinVal end address is: 0 (R0)
;rf4463handler.c,670 :: 		}
L_end_vRF4463SetPinSelect:
BX	LR
; end of _vRF4463SetPinSelect
_vRF4463SetPinSDN:
;rf4463handler.c,675 :: 		void vRF4463SetPinSDN( uint8_t ucPinVal ){
; ucPinVal start address is: 0 (R0)
; ucPinVal end address is: 0 (R0)
; ucPinVal start address is: 0 (R0)
;rf4463handler.c,676 :: 		RF4463nSDN = ucPinVal;
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
_SX	[R1, ByteOffset(GPIOB_ODR+0)]
; ucPinVal end address is: 0 (R0)
;rf4463handler.c,677 :: 		}
L_end_vRF4463SetPinSDN:
BX	LR
; end of _vRF4463SetPinSDN
_vRf4463Init:
;rf4463pro.c,57 :: 		void vRf4463Init( uint8_t ucSetTxChannel, uint8_t ucSetRxChannel, uint16_t usNetwork, uint8_t ucTxPower, uint8_t ucFrequency ){
SUB	SP, SP, #40
STR	LR, [SP, #0]
STRB	R0, [SP, #24]
STRB	R1, [SP, #28]
STRH	R2, [SP, #32]
STRB	R3, [SP, #36]
; ucFrequency start address is: 0 (R0)
LDRB	R0, [SP, #40]
;rf4463pro.c,62 :: 		if( usNetwork == 0 ){
LDRH	R4, [SP, #32]
CMP	R4, #0
IT	NE
BNE	L_vRf4463Init253
; ucFrequency end address is: 0 (R0)
;rf4463pro.c,63 :: 		STM_LOGE( "[ RF4463 ] Invalid Network\r\n", NULL );
MOVS	R6, #0
SXTB	R6, R6
MOVW	R5, #lo_addr(?lstr_108_main+0)
MOVT	R5, #hi_addr(?lstr_108_main+0)
MOVW	R4, #lo_addr(_vDebugPrint+0)
MOVT	R4, #hi_addr(_vDebugPrint+0)
PUSH	(R6)
PUSH	(R5)
PUSH	(R4)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,64 :: 		return;
IT	AL
BAL	L_end_vRf4463Init
;rf4463pro.c,65 :: 		}
L_vRf4463Init253:
;rf4463pro.c,66 :: 		if( ( ucSetTxChannel == 0 || ucSetTxChannel > MAX_RF_CHANNEL ) || ( ucSetRxChannel == 0 || ucSetRxChannel > MAX_RF_CHANNEL ) ){
; ucFrequency start address is: 0 (R0)
LDRB	R4, [SP, #24]
CMP	R4, #0
IT	EQ
BEQ	L__vRf4463Init349
LDRB	R4, [SP, #24]
CMP	R4, #50
IT	HI
BHI	L__vRf4463Init348
L__vRf4463Init345:
LDRB	R4, [SP, #28]
CMP	R4, #0
IT	EQ
BEQ	L__vRf4463Init347
LDRB	R4, [SP, #28]
CMP	R4, #50
IT	HI
BHI	L__vRf4463Init346
L__vRf4463Init344:
IT	AL
BAL	L_vRf4463Init260
; ucFrequency end address is: 0 (R0)
L__vRf4463Init349:
L__vRf4463Init348:
L__vRf4463Init347:
L__vRf4463Init346:
;rf4463pro.c,67 :: 		STM_LOGE( "[ RF4463 ] Invalid Channel\r\n", NULL );
MOVS	R6, #0
SXTB	R6, R6
MOVW	R5, #lo_addr(?lstr_109_main+0)
MOVT	R5, #hi_addr(?lstr_109_main+0)
MOVW	R4, #lo_addr(_vDebugPrint+0)
MOVT	R4, #hi_addr(_vDebugPrint+0)
PUSH	(R6)
PUSH	(R5)
PUSH	(R4)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,68 :: 		return;
IT	AL
BAL	L_end_vRf4463Init
;rf4463pro.c,69 :: 		}
L_vRf4463Init260:
;rf4463pro.c,71 :: 		switch( ucFrequency ){
; ucFrequency start address is: 0 (R0)
IT	AL
BAL	L_vRf4463Init261
; ucFrequency end address is: 0 (R0)
;rf4463pro.c,72 :: 		case RF4463_FREQUENCY_868MHz:
L_vRf4463Init263:
;rf4463pro.c,73 :: 		STM_LOGI( "[ RF4463 ] 868MHz Selected\r\n", NULL );
MOVS	R6, #0
SXTB	R6, R6
MOVW	R5, #lo_addr(?lstr_110_main+0)
MOVT	R5, #hi_addr(?lstr_110_main+0)
MOVW	R4, #lo_addr(_vDebugPrint+0)
MOVT	R4, #hi_addr(_vDebugPrint+0)
PUSH	(R6)
PUSH	(R5)
PUSH	(R4)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,74 :: 		STM_LOGE( "[ RF4463 ] 868MHz Parameters not available\r\n", NULL );
MOVS	R6, #0
SXTB	R6, R6
MOVW	R5, #lo_addr(?lstr_111_main+0)
MOVT	R5, #hi_addr(?lstr_111_main+0)
MOVW	R4, #lo_addr(_vDebugPrint+0)
MOVT	R4, #hi_addr(_vDebugPrint+0)
PUSH	(R6)
PUSH	(R5)
PUSH	(R4)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,75 :: 		break;
IT	AL
BAL	L_vRf4463Init262
;rf4463pro.c,76 :: 		case RF4463_FREQUENCY_915MHz:
L_vRf4463Init264:
;rf4463pro.c,77 :: 		STM_LOGI( "[ RF4463 ] 915MHz Selected\r\n", NULL );
MOVS	R6, #0
SXTB	R6, R6
MOVW	R5, #lo_addr(?lstr_112_main+0)
MOVT	R5, #hi_addr(?lstr_112_main+0)
MOVW	R4, #lo_addr(_vDebugPrint+0)
MOVT	R4, #hi_addr(_vDebugPrint+0)
PUSH	(R6)
PUSH	(R5)
PUSH	(R4)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,78 :: 		break;
IT	AL
BAL	L_vRf4463Init262
;rf4463pro.c,79 :: 		default:
L_vRf4463Init265:
;rf4463pro.c,80 :: 		STM_LOGE( "[ RF4463 ] Invalid frequency\r\n", NULL );
MOVS	R6, #0
SXTB	R6, R6
MOVW	R5, #lo_addr(?lstr_113_main+0)
MOVT	R5, #hi_addr(?lstr_113_main+0)
MOVW	R4, #lo_addr(_vDebugPrint+0)
MOVT	R4, #hi_addr(_vDebugPrint+0)
PUSH	(R6)
PUSH	(R5)
PUSH	(R4)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,81 :: 		return;
IT	AL
BAL	L_end_vRf4463Init
;rf4463pro.c,82 :: 		}
L_vRf4463Init261:
; ucFrequency start address is: 0 (R0)
CMP	R0, #1
IT	EQ
BEQ	L_vRf4463Init263
CMP	R0, #2
IT	EQ
BEQ	L_vRf4463Init264
; ucFrequency end address is: 0 (R0)
IT	AL
BAL	L_vRf4463Init265
L_vRf4463Init262:
;rf4463pro.c,84 :: 		usRfNetwork = usNetwork;
LDRH	R5, [SP, #32]
MOVW	R4, #lo_addr(main_usRfNetwork+0)
MOVT	R4, #hi_addr(main_usRfNetwork+0)
STRB	R5, [R4, #0]
;rf4463pro.c,85 :: 		ucRxChannel = ucSetRxChannel;
LDRB	R5, [SP, #28]
MOVW	R4, #lo_addr(main_ucRxChannel+0)
MOVT	R4, #hi_addr(main_ucRxChannel+0)
STRB	R5, [R4, #0]
;rf4463pro.c,86 :: 		ucTxChannel = ucSetTxChannel;
LDRB	R5, [SP, #24]
MOVW	R4, #lo_addr(main_ucTxChannel+0)
MOVT	R4, #hi_addr(main_ucTxChannel+0)
STRB	R5, [R4, #0]
;rf4463pro.c,90 :: 		vRf4463PowerOnReset();
BL	_vRf4463PowerOnReset+0
;rf4463pro.c,91 :: 		vRf4463SetConfiguration( RF4463_CONFIGURATION_DATA, sizeof( RF4463_CONFIGURATION_DATA ) );
MOVW	R1, #972
MOVW	R0, #lo_addr(_RF4463_CONFIGURATION_DATA+0)
MOVT	R0, #hi_addr(_RF4463_CONFIGURATION_DATA+0)
BL	_vRf4463SetConfiguration+0
;rf4463pro.c,96 :: 		pcBuffer[ 0 ] = RF4463_GPIO_NO_CHANGE;
ADD	R6, SP, #4
MOVS	R4, #0
STRB	R4, [R6, #0]
;rf4463pro.c,97 :: 		pcBuffer[ 1 ] = RF4463_GPIO_NO_CHANGE;
ADDS	R5, R6, #1
MOVS	R4, #0
STRB	R4, [R5, #0]
;rf4463pro.c,98 :: 		pcBuffer[ 2 ] = RF4463_GPIO_RX_STATE;
ADDS	R5, R6, #2
MOVS	R4, #33
STRB	R4, [R5, #0]
;rf4463pro.c,99 :: 		pcBuffer[ 3 ] = RF4463_GPIO_TX_STATE;
ADDS	R5, R6, #3
MOVS	R4, #32
STRB	R4, [R5, #0]
;rf4463pro.c,100 :: 		pcBuffer[ 4 ] = RF4463_NIRQ_INTERRUPT_SIGNAL;
ADDS	R5, R6, #4
MOVS	R4, #39
STRB	R4, [R5, #0]
;rf4463pro.c,101 :: 		pcBuffer[ 5 ] = RF4463_GPIO_SPI_DATA_OUT;
ADDS	R5, R6, #5
MOVS	R4, #11
STRB	R4, [R5, #0]
;rf4463pro.c,102 :: 		ucRf4463SetCommand( 6, RF4463_CMD_GPIO_PIN_CFG, pcBuffer );  // CAMBIE PROPIEDADES POR COMANDO
MOV	R2, R6
MOVS	R1, #19
MOVS	R0, #6
BL	_ucRf4463SetCommand+0
;rf4463pro.c,103 :: 		vBufferSetToZero( pcBuffer, 20 );
ADD	R4, SP, #4
MOVS	R1, #20
MOV	R0, R4
BL	_vBufferSetToZero+0
;rf4463pro.c,111 :: 		pcBuffer[0]  = 0x00;
ADD	R6, SP, #4
MOVS	R4, #0
STRB	R4, [R6, #0]
;rf4463pro.c,112 :: 		pcBuffer[1]  = 0x01;
ADDS	R5, R6, #1
MOVS	R4, #1
STRB	R4, [R5, #0]
;rf4463pro.c,113 :: 		pcBuffer[2]  = 0x00;
ADDS	R5, R6, #2
MOVS	R4, #0
STRB	R4, [R5, #0]
;rf4463pro.c,114 :: 		pcBuffer[3]  = 98;           // freq  adjustment
ADDS	R5, R6, #3
MOVS	R4, #98
STRB	R4, [R5, #0]
;rf4463pro.c,116 :: 		ucRf4463SetCommand( RF4463_PROPERTY_GLOBAL_XO_TUNE, 4, pcBuffer );
MOV	R2, R6
MOVS	R1, #4
MOVS	R0, #0
BL	_ucRf4463SetCommand+0
;rf4463pro.c,117 :: 		vBufferSetToZero( pcBuffer, 20 );
ADD	R4, SP, #4
MOVS	R1, #20
MOV	R0, R4
BL	_vBufferSetToZero+0
;rf4463pro.c,123 :: 		pcBuffer[0]  = 0x11;
ADD	R6, SP, #4
MOVS	R4, #17
STRB	R4, [R6, #0]
;rf4463pro.c,124 :: 		pcBuffer[1]  = 0x00;
ADDS	R5, R6, #1
MOVS	R4, #0
STRB	R4, [R5, #0]
;rf4463pro.c,125 :: 		pcBuffer[2]  = 0x01;
ADDS	R5, R6, #2
MOVS	R4, #1
STRB	R4, [R5, #0]
;rf4463pro.c,126 :: 		pcBuffer[3]  = 0x03;
ADDS	R5, R6, #3
MOVS	R4, #3
STRB	R4, [R5, #0]
;rf4463pro.c,127 :: 		pcBuffer[4]  = 0x40;         // tx = rx = 64 byte,PH,high performance mode
ADDS	R5, R6, #4
MOVS	R4, #64
STRB	R4, [R5, #0]
;rf4463pro.c,129 :: 		ucRf4463SetCommand( RF4463_PROPERTY_GLOBAL_CONFIG, 5, pcBuffer );  // CAMBIE PROPIEDADES POR COMANDO
MOV	R2, R6
MOVS	R1, #5
MOVS	R0, #3
BL	_ucRf4463SetCommand+0
;rf4463pro.c,130 :: 		vBufferSetToZero( pcBuffer, 20 );      // antes 20 dec
ADD	R4, SP, #4
MOVS	R1, #20
MOV	R0, R4
BL	_vBufferSetToZero+0
;rf4463pro.c,136 :: 		ucRf4463SetProperty( RF4463_PROPERTY_FRR_CTL_A_MODE, 8, pcBuffer );
ADD	R4, SP, #4
MOV	R2, R4
MOVS	R1, #8
MOVW	R0, #512
BL	_ucRf4463SetProperty+0
;rf4463pro.c,137 :: 		vBufferSetToZero( pcBuffer, 20 );      // antes 20 dec
ADD	R4, SP, #4
MOVS	R1, #20
MOV	R0, R4
BL	_vBufferSetToZero+0
;rf4463pro.c,152 :: 		pcBuffer[0] = 0x11;
ADD	R6, SP, #4
MOVS	R4, #17
STRB	R4, [R6, #0]
;rf4463pro.c,153 :: 		pcBuffer[1]  = 0x10;
ADDS	R5, R6, #1
MOVS	R4, #16
STRB	R4, [R5, #0]
;rf4463pro.c,154 :: 		pcBuffer[2]  = 0x09;
ADDS	R5, R6, #2
MOVS	R4, #9
STRB	R4, [R5, #0]
;rf4463pro.c,155 :: 		pcBuffer[3]  = 0x00;
ADDS	R5, R6, #3
MOVS	R4, #0
STRB	R4, [R5, #0]
;rf4463pro.c,156 :: 		pcBuffer[4]  = 0x08;                         //  8 bytes Preamble
ADDS	R5, R6, #4
MOVS	R4, #8
STRB	R4, [R5, #0]
;rf4463pro.c,157 :: 		pcBuffer[5]  = 0x14;                         //  detect 20 bits
ADDS	R5, R6, #5
MOVS	R4, #20
STRB	R4, [R5, #0]
;rf4463pro.c,158 :: 		pcBuffer[6]  = 0x00;
ADDS	R5, R6, #6
MOVS	R4, #0
STRB	R4, [R5, #0]
;rf4463pro.c,159 :: 		pcBuffer[7]  = 0x0f;
ADDS	R5, R6, #7
MOVS	R4, #15
STRB	R4, [R5, #0]
;rf4463pro.c,160 :: 		pcBuffer[8]  = 0x31;                         //  no manchest.1010.¡£¡£
ADDW	R5, R6, #8
MOVS	R4, #49
STRB	R4, [R5, #0]
;rf4463pro.c,161 :: 		pcBuffer[9]  = 0x00;
ADDW	R5, R6, #9
MOVS	R4, #0
STRB	R4, [R5, #0]
;rf4463pro.c,162 :: 		pcBuffer[10]  = 0x00;
ADDW	R5, R6, #10
MOVS	R4, #0
STRB	R4, [R5, #0]
;rf4463pro.c,163 :: 		pcBuffer[11]  = 0x00;
ADDW	R5, R6, #11
MOVS	R4, #0
STRB	R4, [R5, #0]
;rf4463pro.c,164 :: 		pcBuffer[12]  = 0x00;
ADDW	R5, R6, #12
MOVS	R4, #0
STRB	R4, [R5, #0]
;rf4463pro.c,167 :: 		ucRf4463SetCommand( RF4463_PROPERTY_PREAMBLE_TX_LENGTH, 13, pcBuffer ); // CAMBIE PROPIEDADES POR COMANDO
MOV	R2, R6
MOVS	R1, #13
MOVS	R0, #0
BL	_ucRf4463SetCommand+0
;rf4463pro.c,178 :: 		pcBuffer[0]  = 0x11;
ADD	R6, SP, #4
MOVS	R4, #17
STRB	R4, [R6, #0]
;rf4463pro.c,179 :: 		pcBuffer[1]  = 0x11;
ADDS	R5, R6, #1
MOVS	R4, #17
STRB	R4, [R5, #0]
;rf4463pro.c,180 :: 		pcBuffer[2]  = 0x05;
ADDS	R5, R6, #2
MOVS	R4, #5
STRB	R4, [R5, #0]
;rf4463pro.c,181 :: 		pcBuffer[3]  = 0x00;
ADDS	R5, R6, #3
MOVS	R4, #0
STRB	R4, [R5, #0]
;rf4463pro.c,182 :: 		pcBuffer[4]  = 0x01;                         // no manchest , 2 bytes
ADDS	R5, R6, #4
MOVS	R4, #1
STRB	R4, [R5, #0]
;rf4463pro.c,183 :: 		pcBuffer[5]  = ( usNetwork >> 8 );           // sync byte3
ADDS	R5, R6, #5
LDRH	R4, [SP, #32]
LSRS	R4, R4, #8
STRB	R4, [R5, #0]
;rf4463pro.c,184 :: 		pcBuffer[6]  = ( usNetwork );                // sync byte2
ADDS	R5, R6, #6
LDRH	R4, [SP, #32]
STRB	R4, [R5, #0]
;rf4463pro.c,185 :: 		pcBuffer[7]  = 0x00;                         // sync byte1
ADDS	R5, R6, #7
MOVS	R4, #0
STRB	R4, [R5, #0]
;rf4463pro.c,186 :: 		pcBuffer[8]  = 0x00;                         // sync byte0
ADDW	R5, R6, #8
MOVS	R4, #0
STRB	R4, [R5, #0]
;rf4463pro.c,187 :: 		ucRf4463SetProperty( RF_SYNC_CONFIG_6_data, 9, pcBuffer);
MOV	R2, R6
MOVS	R1, #9
MOVW	R0, #lo_addr(_RF_SYNC_CONFIG_6_data+0)
BL	_ucRf4463SetProperty+0
;rf4463pro.c,191 :: 		pcBuffer[ 0 ] = RF4463_CRC_SEED_ALL_1S | RF4463_CRC_ITU_T;
ADD	R5, SP, #4
MOVS	R4, #129
STRB	R4, [R5, #0]
;rf4463pro.c,192 :: 		ucRf4463SetProperty( RF4463_PROPERTY_PKT_CRC_CONFIG, 1, pcBuffer );
MOV	R2, R5
MOVS	R1, #1
MOVW	R0, #4608
BL	_ucRf4463SetProperty+0
;rf4463pro.c,194 :: 		pcBuffer[ 0 ] = RF4463_CRC_ENDIAN;
ADD	R5, SP, #4
MOVS	R4, #2
STRB	R4, [R5, #0]
;rf4463pro.c,195 :: 		ucRf4463SetProperty( RF4463_PROPERTY_PKT_CONFIG1, 1, pcBuffer );
MOV	R2, R5
MOVS	R1, #1
MOVW	R0, #4614
BL	_ucRf4463SetProperty+0
;rf4463pro.c,197 :: 		pcBuffer[ 0 ] = RF4463_IN_FIFO | RF4463_DST_FIELD_ENUM_2;
ADD	R6, SP, #4
MOVS	R4, #10
STRB	R4, [R6, #0]
;rf4463pro.c,198 :: 		pcBuffer[ 1 ] = RF4463_SRC_FIELD_ENUM_1;
ADDS	R5, R6, #1
MOVS	R4, #1
STRB	R4, [R5, #0]
;rf4463pro.c,199 :: 		pcBuffer[ 2 ] = 0x00;
ADDS	R5, R6, #2
MOVS	R4, #0
STRB	R4, [R5, #0]
;rf4463pro.c,200 :: 		pcBuffer[ 3 ] = 0x20;
ADDS	R5, R6, #3
MOVS	R4, #32
STRB	R4, [R5, #0]
;rf4463pro.c,201 :: 		pcBuffer[ 4 ] = 0x81; // 0X05    CHECAR ANTES ESTE VALOR
ADDS	R5, R6, #4
MOVS	R4, #129
STRB	R4, [R5, #0]
;rf4463pro.c,202 :: 		ucRf4463SetProperty( RF4463_PROPERTY_PKT_LEN, 5, pcBuffer );
MOV	R2, R6
MOVS	R1, #5
MOVW	R0, #4616
BL	_ucRf4463SetProperty+0
;rf4463pro.c,214 :: 		pcBuffer[ 0 ] = 0x00;
ADD	R6, SP, #4
MOVS	R4, #0
STRB	R4, [R6, #0]
;rf4463pro.c,215 :: 		pcBuffer[ 1 ] = 0x01;
ADDS	R5, R6, #1
MOVS	R4, #1
STRB	R4, [R5, #0]
;rf4463pro.c,216 :: 		pcBuffer[ 2 ] = RF4463_FIELD_CONFIG_PN_START;
ADDS	R5, R6, #2
MOVS	R4, #4
STRB	R4, [R5, #0]
;rf4463pro.c,217 :: 		pcBuffer[ 3 ] = RF4463_FIELD_CONFIG_CRC_START | RF4463_FIELD_CONFIG_SEND_CRC | RF4463_FIELD_CONFIG_CHECK_CRC | RF4463_FIELD_CONFIG_CRC_ENABLE;
ADDS	R5, R6, #3
MOVS	R4, #170
STRB	R4, [R5, #0]
;rf4463pro.c,218 :: 		pcBuffer[ 4 ] = 0x00;
ADDS	R5, R6, #4
MOVS	R4, #0
STRB	R4, [R5, #0]
;rf4463pro.c,219 :: 		pcBuffer[ 5 ] = 50;
ADDS	R5, R6, #5
MOVS	R4, #50
STRB	R4, [R5, #0]
;rf4463pro.c,220 :: 		pcBuffer[ 6 ] = RF4463_FIELD_CONFIG_PN_START;
ADDS	R5, R6, #6
MOVS	R4, #4
STRB	R4, [R5, #0]
;rf4463pro.c,221 :: 		pcBuffer[ 7 ] = RF4463_FIELD_CONFIG_CRC_START | RF4463_FIELD_CONFIG_SEND_CRC | RF4463_FIELD_CONFIG_CHECK_CRC | RF4463_FIELD_CONFIG_CRC_ENABLE;
ADDS	R5, R6, #7
MOVS	R4, #170
STRB	R4, [R5, #0]
;rf4463pro.c,222 :: 		pcBuffer[ 8 ] = 0x00;
ADDW	R5, R6, #8
MOVS	R4, #0
STRB	R4, [R5, #0]
;rf4463pro.c,223 :: 		pcBuffer[ 9 ] = 0x00;
ADDW	R5, R6, #9
MOVS	R4, #0
STRB	R4, [R5, #0]
;rf4463pro.c,224 :: 		pcBuffer[ 10 ] = 0x00;
ADDW	R5, R6, #10
MOVS	R4, #0
STRB	R4, [R5, #0]
;rf4463pro.c,225 :: 		pcBuffer[ 11 ] = 0x00;
ADDW	R5, R6, #11
MOVS	R4, #0
STRB	R4, [R5, #0]
;rf4463pro.c,226 :: 		ucRf4463SetProperty( RF4463_PROPERTY_PKT_FIELD_1_LENGTH_12_8, 12, pcBuffer );
MOV	R2, R6
MOVS	R1, #12
MOVW	R0, #4621
BL	_ucRf4463SetProperty+0
;rf4463pro.c,228 :: 		pcBuffer[ 0 ] = 0x00;
ADD	R6, SP, #4
MOVS	R4, #0
STRB	R4, [R6, #0]
;rf4463pro.c,229 :: 		pcBuffer[ 1 ] = 0x00;
ADDS	R5, R6, #1
MOVS	R4, #0
STRB	R4, [R5, #0]
;rf4463pro.c,230 :: 		pcBuffer[ 2 ] = 0x00;
ADDS	R5, R6, #2
MOVS	R4, #0
STRB	R4, [R5, #0]
;rf4463pro.c,231 :: 		pcBuffer[ 3 ] = 0x00;
ADDS	R5, R6, #3
MOVS	R4, #0
STRB	R4, [R5, #0]
;rf4463pro.c,232 :: 		pcBuffer[ 4 ] = 0x00;
ADDS	R5, R6, #4
MOVS	R4, #0
STRB	R4, [R5, #0]
;rf4463pro.c,233 :: 		pcBuffer[ 5 ] = 0x00;
ADDS	R5, R6, #5
MOVS	R4, #0
STRB	R4, [R5, #0]
;rf4463pro.c,234 :: 		pcBuffer[ 6 ] = 0x00;
ADDS	R5, R6, #6
MOVS	R4, #0
STRB	R4, [R5, #0]
;rf4463pro.c,235 :: 		pcBuffer[ 7 ] = 0x00;
ADDS	R5, R6, #7
MOVS	R4, #0
STRB	R4, [R5, #0]
;rf4463pro.c,236 :: 		ucRf4463SetProperty( RF4463_PROPERTY_PKT_FIELD_4_LENGTH_12_8, 8, pcBuffer );
MOV	R2, R6
MOVS	R1, #8
MOVW	R0, #4633
BL	_ucRf4463SetProperty+0
;rf4463pro.c,241 :: 		pcBuffer[ 0 ] = 0x01;
ADD	R5, SP, #4
MOVS	R4, #1
STRB	R4, [R5, #0]
;rf4463pro.c,242 :: 		ucRf4463SetProperty( RF4463_PROPERTY_MODEM_RSSI_CONTROL, 1, pcBuffer );
MOV	R2, R5
MOVS	R1, #1
MOVW	R0, #8268
BL	_ucRf4463SetProperty+0
;rf4463pro.c,247 :: 		pcBuffer[ 0 ] = 0x01;
ADD	R6, SP, #4
MOVS	R4, #1
STRB	R4, [R6, #0]
;rf4463pro.c,248 :: 		pcBuffer[ 1 ] = 0x38;
ADDS	R5, R6, #1
MOVS	R4, #56
STRB	R4, [R5, #0]
;rf4463pro.c,249 :: 		pcBuffer[ 2 ] = 0x00;
ADDS	R5, R6, #2
MOVS	R4, #0
STRB	R4, [R5, #0]
;rf4463pro.c,250 :: 		ucRf4463SetProperty( RF4463_PROPERTY_INT_CTL_ENABLE, 3, pcBuffer );
MOV	R2, R6
MOVS	R1, #3
MOVW	R0, #256
BL	_ucRf4463SetProperty+0
;rf4463pro.c,255 :: 		ucRf4463SetTxPower( ucTxPower );
LDRB	R0, [SP, #36]
BL	_ucRf4463SetTxPower+0
;rf4463pro.c,256 :: 		}
L_end_vRf4463Init:
LDR	LR, [SP, #0]
ADD	SP, SP, #40
BX	LR
; end of _vRf4463Init
_vRf4463PowerOnReset:
;rf4463pro.c,261 :: 		void vRf4463PowerOnReset(){
SUB	SP, SP, #12
STR	LR, [SP, #0]
;rf4463pro.c,286 :: 		uint8_t pcBuffer[ 7 ] = { RF_POWER_UP };
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
;rf4463pro.c,297 :: 		vRF4463SetPinSDN( PIN_LEVEL_HIGH );
MOVS	R0, #1
BL	_vRF4463SetPinSDN+0
;rf4463pro.c,298 :: 		Delay_us( 16 );
MOVW	R7, #191
MOVT	R7, #0
NOP
NOP
L_vRf4463PowerOnReset266:
SUBS	R7, R7, #1
BNE	L_vRf4463PowerOnReset266
NOP
NOP
NOP
;rf4463pro.c,299 :: 		vRF4463SetPinSDN( PIN_LEVEL_LOW );
MOVS	R0, #0
BL	_vRF4463SetPinSDN+0
;rf4463pro.c,301 :: 		Delay_ms( 6 );
MOVW	R7, #6463
MOVT	R7, #1
NOP
NOP
L_vRf4463PowerOnReset268:
SUBS	R7, R7, #1
BNE	L_vRf4463PowerOnReset268
NOP
NOP
NOP
;rf4463pro.c,303 :: 		vRF4463SetPinSelect( PIN_LEVEL_LOW );
MOVS	R0, #0
BL	_vRF4463SetPinSelect+0
;rf4463pro.c,304 :: 		vRf4463SPIWriteBuffer( sizeof( pcBuffer ), pcBuffer );
ADD	R0, SP, #4
MOV	R1, R0
MOVS	R0, #7
BL	_vRf4463SPIWriteBuffer+0
;rf4463pro.c,305 :: 		vRF4463SetPinSelect( PIN_LEVEL_HIGH );
MOVS	R0, #1
BL	_vRF4463SetPinSelect+0
;rf4463pro.c,306 :: 		}
L_end_vRf4463PowerOnReset:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRf4463PowerOnReset
_vRf4463SetChannels:
;rf4463pro.c,311 :: 		void vRf4463SetChannels( uint8_t ucSetRxChannel, uint8_t ucSetTxChannel ){
; ucSetTxChannel start address is: 4 (R1)
; ucSetRxChannel start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
; ucSetTxChannel end address is: 4 (R1)
; ucSetRxChannel end address is: 0 (R0)
; ucSetRxChannel start address is: 0 (R0)
; ucSetTxChannel start address is: 4 (R1)
;rf4463pro.c,315 :: 		if( ( ucSetTxChannel == 0 || ucSetTxChannel > MAX_RF_CHANNEL ) || ( ucSetRxChannel == 0 || ucSetRxChannel > MAX_RF_CHANNEL ) ){
CMP	R1, #0
IT	EQ
BEQ	L__vRf4463SetChannels320
CMP	R1, #50
IT	HI
BHI	L__vRf4463SetChannels319
L__vRf4463SetChannels316:
CMP	R0, #0
IT	EQ
BEQ	L__vRf4463SetChannels318
CMP	R0, #50
IT	HI
BHI	L__vRf4463SetChannels317
L__vRf4463SetChannels315:
IT	AL
BAL	L_vRf4463SetChannels276
; ucSetRxChannel end address is: 0 (R0)
; ucSetTxChannel end address is: 4 (R1)
L__vRf4463SetChannels320:
L__vRf4463SetChannels319:
L__vRf4463SetChannels318:
L__vRf4463SetChannels317:
;rf4463pro.c,316 :: 		STM_LOGE( "[ RF4463 ] Invalid Channel\r\n", NULL );
MOVS	R4, #0
SXTB	R4, R4
MOVW	R3, #lo_addr(?lstr_114_main+0)
MOVT	R3, #hi_addr(?lstr_114_main+0)
MOVW	R2, #lo_addr(_vDebugPrint+0)
MOVT	R2, #hi_addr(_vDebugPrint+0)
PUSH	(R4)
PUSH	(R3)
PUSH	(R2)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,317 :: 		return;
IT	AL
BAL	L_end_vRf4463SetChannels
;rf4463pro.c,318 :: 		}
L_vRf4463SetChannels276:
;rf4463pro.c,320 :: 		STM_LOGV( "[ RF4463 ] Rx Channel: %d\r\n", ucSetRxChannel );
; ucSetTxChannel start address is: 4 (R1)
; ucSetRxChannel start address is: 0 (R0)
MOVW	R3, #lo_addr(?lstr_115_main+0)
MOVT	R3, #hi_addr(?lstr_115_main+0)
MOVW	R2, #lo_addr(_vDebugPrint+0)
MOVT	R2, #hi_addr(_vDebugPrint+0)
STRB	R1, [SP, #4]
STRB	R0, [SP, #8]
PUSH	(R0)
PUSH	(R3)
PUSH	(R2)
BL	_PrintOut+0
ADD	SP, SP, #12
LDRB	R0, [SP, #8]
LDRB	R1, [SP, #4]
;rf4463pro.c,321 :: 		STM_LOGV( "[ RF4463 ] Tx Channel: %d\r\n", ucSetTxChannel );
MOVW	R3, #lo_addr(?lstr_116_main+0)
MOVT	R3, #hi_addr(?lstr_116_main+0)
MOVW	R2, #lo_addr(_vDebugPrint+0)
MOVT	R2, #hi_addr(_vDebugPrint+0)
STRB	R1, [SP, #4]
STRB	R0, [SP, #8]
PUSH	(R1)
PUSH	(R3)
PUSH	(R2)
BL	_PrintOut+0
ADD	SP, SP, #12
LDRB	R0, [SP, #8]
LDRB	R1, [SP, #4]
;rf4463pro.c,322 :: 		ucRxChannel = ucSetRxChannel;
MOVW	R2, #lo_addr(main_ucRxChannel+0)
MOVT	R2, #hi_addr(main_ucRxChannel+0)
STRB	R0, [R2, #0]
; ucSetRxChannel end address is: 0 (R0)
;rf4463pro.c,323 :: 		ucTxChannel = ucSetTxChannel;
MOVW	R2, #lo_addr(main_ucTxChannel+0)
MOVT	R2, #hi_addr(main_ucTxChannel+0)
STRB	R1, [R2, #0]
; ucSetTxChannel end address is: 4 (R1)
;rf4463pro.c,324 :: 		}
L_end_vRf4463SetChannels:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRf4463SetChannels
_vRf4463SetNetwork:
;rf4463pro.c,329 :: 		void vRf4463SetNetwork( uint16_t usNetwork ){
; usNetwork start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
; usNetwork end address is: 0 (R0)
; usNetwork start address is: 0 (R0)
;rf4463pro.c,330 :: 		uint8_t pcBuffer[ 2 ] = { 0x00 };
MOVS	R1, #0
STRB	R1, [SP, #8]
MOVS	R1, #0
STRB	R1, [SP, #9]
;rf4463pro.c,331 :: 		if( usNetwork == 0 ){
CMP	R0, #0
IT	NE
BNE	L_vRf4463SetNetwork277
; usNetwork end address is: 0 (R0)
;rf4463pro.c,332 :: 		STM_LOGE( "[ RF4463 ] Invalid Network\r\n", NULL );
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(?lstr_117_main+0)
MOVT	R2, #hi_addr(?lstr_117_main+0)
MOVW	R1, #lo_addr(_vDebugPrint+0)
MOVT	R1, #hi_addr(_vDebugPrint+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,333 :: 		return;
IT	AL
BAL	L_end_vRf4463SetNetwork
;rf4463pro.c,334 :: 		}
L_vRf4463SetNetwork277:
;rf4463pro.c,335 :: 		STM_LOGV( "[ RF4463 ] Network: %d\r\n", usNetwork );
; usNetwork start address is: 0 (R0)
MOVW	R2, #lo_addr(?lstr_118_main+0)
MOVT	R2, #hi_addr(?lstr_118_main+0)
MOVW	R1, #lo_addr(_vDebugPrint+0)
MOVT	R1, #hi_addr(_vDebugPrint+0)
STRH	R0, [SP, #4]
PUSH	(R0)
PUSH	(R2)
PUSH	(R1)
BL	_PrintOut+0
ADD	SP, SP, #12
LDRH	R0, [SP, #4]
;rf4463pro.c,336 :: 		usRfNetwork = usNetwork;
MOVW	R1, #lo_addr(main_usRfNetwork+0)
MOVT	R1, #hi_addr(main_usRfNetwork+0)
STRB	R0, [R1, #0]
;rf4463pro.c,338 :: 		pcBuffer[ 0 ] = ( usNetwork >> 8 );
ADD	R2, SP, #8
LSRS	R1, R0, #8
STRB	R1, [R2, #0]
;rf4463pro.c,339 :: 		pcBuffer[ 1 ] = ( usNetwork );
ADDS	R1, R2, #1
STRB	R0, [R1, #0]
; usNetwork end address is: 0 (R0)
;rf4463pro.c,340 :: 		ucRf4463SetSyncWords( pcBuffer, 2 );
MOVS	R1, #2
MOV	R0, R2
BL	_ucRf4463SetSyncWords+0
;rf4463pro.c,341 :: 		}
L_end_vRf4463SetNetwork:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRf4463SetNetwork
_vRf4463SetConfiguration:
;rf4463pro.c,349 :: 		void vRf4463SetConfiguration( const uint8_t * pcParameters, uint16_t usParametersLength ){
; pcParameters start address is: 0 (R0)
SUB	SP, SP, #48
STR	LR, [SP, #0]
STRH	R1, [SP, #44]
; pcParameters end address is: 0 (R0)
; pcParameters start address is: 0 (R0)
;rf4463pro.c,350 :: 		uint8_t ucCommandLength = 0;
;rf4463pro.c,351 :: 		uint8_t ucCommand = 0;
;rf4463pro.c,354 :: 		uint16_t usPosition = 0;
;rf4463pro.c,356 :: 		usParametersLength  = usParametersLength - 1;
LDRH	R2, [SP, #44]
SUBS	R2, R2, #1
STRH	R2, [SP, #44]
;rf4463pro.c,357 :: 		ucCommandLength     = pcParameters[ 0 ];
LDRB	R2, [R0, #0]
;rf4463pro.c,358 :: 		usPosition          = ucCommandLength + 1;
ADDS	R6, R2, #1
UXTH	R6, R6
; usPosition start address is: 24 (R6)
; usPosition end address is: 24 (R6)
UXTH	R1, R6
;rf4463pro.c,360 :: 		while( usPosition < usParametersLength ){
L_vRf4463SetConfiguration278:
; usPosition start address is: 4 (R1)
; pcParameters start address is: 0 (R0)
; pcParameters end address is: 0 (R0)
LDRH	R2, [SP, #44]
CMP	R1, R2
IT	CS
BCS	L_vRf4463SetConfiguration279
; pcParameters end address is: 0 (R0)
;rf4463pro.c,361 :: 		ucCommandLength = ( pcParameters[ usPosition++ ] - 1 );
; pcParameters start address is: 0 (R0)
ADDS	R2, R0, R1
LDRB	R2, [R2, #0]
SUBS	R4, R2, #1
STRB	R4, [SP, #46]
ADDS	R3, R1, #1
UXTH	R3, R3
; usPosition end address is: 4 (R1)
;rf4463pro.c,362 :: 		ucCommand = pcParameters[ usPosition++ ];
ADDS	R2, R0, R3
LDRB	R2, [R2, #0]
; ucCommand start address is: 24 (R6)
UXTB	R6, R2
ADDS	R2, R3, #1
UXTH	R2, R2
; usPosition start address is: 4 (R1)
UXTH	R1, R2
;rf4463pro.c,363 :: 		memcpy( ( uint8_t * )pcBuffer, pcParameters + usPosition, ucCommandLength );
ADDS	R3, R0, R2
ADD	R2, SP, #12
STRH	R1, [SP, #4]
STR	R0, [SP, #8]
MOV	R1, R3
MOV	R0, R2
UXTB	R2, R4
BL	_memcpy+0
;rf4463pro.c,364 :: 		ucRf4463SetCommand( ucCommandLength, ucCommand, pcBuffer );
ADD	R2, SP, #12
UXTB	R1, R6
; ucCommand end address is: 24 (R6)
LDRB	R0, [SP, #46]
BL	_ucRf4463SetCommand+0
LDR	R0, [SP, #8]
LDRH	R1, [SP, #4]
;rf4463pro.c,365 :: 		usPosition = usPosition + ucCommandLength;
LDRB	R2, [SP, #46]
ADDS	R2, R1, R2
; usPosition end address is: 4 (R1)
; usPosition start address is: 24 (R6)
UXTH	R6, R2
;rf4463pro.c,366 :: 		}
; pcParameters end address is: 0 (R0)
; usPosition end address is: 24 (R6)
UXTH	R1, R6
IT	AL
BAL	L_vRf4463SetConfiguration278
L_vRf4463SetConfiguration279:
;rf4463pro.c,367 :: 		}
L_end_vRf4463SetConfiguration:
LDR	LR, [SP, #0]
ADD	SP, SP, #48
BX	LR
; end of _vRf4463SetConfiguration
_ucRf4463SetCommand:
;rf4463pro.c,372 :: 		uint8_t ucRf4463SetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer ){
SUB	SP, SP, #16
STR	LR, [SP, #0]
STRB	R0, [SP, #4]
STRB	R1, [SP, #8]
STR	R2, [SP, #12]
;rf4463pro.c,373 :: 		if( ucRf4463CheckCTS() == NOT_SUCCESS ){
BL	_ucRf4463CheckCTS+0
CMP	R0, #1
IT	NE
BNE	L_ucRf4463SetCommand280
;rf4463pro.c,374 :: 		return NOT_SUCCESS;
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463SetCommand
;rf4463pro.c,375 :: 		}
L_ucRf4463SetCommand280:
;rf4463pro.c,377 :: 		vRF4463SetPinSelect( PIN_LEVEL_LOW );
MOVS	R0, #0
BL	_vRF4463SetPinSelect+0
;rf4463pro.c,378 :: 		ucRf4463SPIByte( ucCommand );
LDRB	R0, [SP, #8]
BL	_ucRf4463SPIByte+0
;rf4463pro.c,379 :: 		vRf4463SPIWriteBuffer( ucLength, pcParametersBuffer );
LDR	R1, [SP, #12]
LDRB	R0, [SP, #4]
BL	_vRf4463SPIWriteBuffer+0
;rf4463pro.c,380 :: 		vRF4463SetPinSelect( PIN_LEVEL_HIGH );
MOVS	R0, #1
BL	_vRF4463SetPinSelect+0
;rf4463pro.c,382 :: 		return SUCCESS;
MOVS	R0, #0
;rf4463pro.c,383 :: 		}
L_end_ucRf4463SetCommand:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _ucRf4463SetCommand
_ucRf4463GetCommand:
;rf4463pro.c,388 :: 		uint8_t ucRf4463GetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer ){
SUB	SP, SP, #16
STR	LR, [SP, #0]
STRB	R0, [SP, #4]
STRB	R1, [SP, #8]
STR	R2, [SP, #12]
;rf4463pro.c,389 :: 		if( ucRf4463CheckCTS() == NOT_SUCCESS ){
BL	_ucRf4463CheckCTS+0
CMP	R0, #1
IT	NE
BNE	L_ucRf4463GetCommand281
;rf4463pro.c,390 :: 		return NOT_SUCCESS;
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463GetCommand
;rf4463pro.c,391 :: 		}
L_ucRf4463GetCommand281:
;rf4463pro.c,393 :: 		vRF4463SetPinSelect( PIN_LEVEL_LOW );
MOVS	R0, #0
BL	_vRF4463SetPinSelect+0
;rf4463pro.c,394 :: 		ucRf4463SPIByte( ucCommand );
LDRB	R0, [SP, #8]
BL	_ucRf4463SPIByte+0
;rf4463pro.c,395 :: 		vRF4463SetPinSelect( PIN_LEVEL_HIGH );
MOVS	R0, #1
BL	_vRF4463SetPinSelect+0
;rf4463pro.c,397 :: 		if( ucRf4463CheckCTS() == NOT_SUCCESS ){
BL	_ucRf4463CheckCTS+0
CMP	R0, #1
IT	NE
BNE	L_ucRf4463GetCommand282
;rf4463pro.c,398 :: 		return NOT_SUCCESS;
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463GetCommand
;rf4463pro.c,399 :: 		}
L_ucRf4463GetCommand282:
;rf4463pro.c,401 :: 		vRF4463SetPinSelect( PIN_LEVEL_LOW );
MOVS	R0, #0
BL	_vRF4463SetPinSelect+0
;rf4463pro.c,402 :: 		ucRf4463SPIByte( RF4463_CMD_READ_BUF );
MOVS	R0, #68
BL	_ucRf4463SPIByte+0
;rf4463pro.c,403 :: 		vRf4463SPIReadBuffer( ucLength, pcParametersBuffer );
LDR	R1, [SP, #12]
LDRB	R0, [SP, #4]
BL	_vRf4463SPIReadBuffer+0
;rf4463pro.c,404 :: 		vRF4463SetPinSelect( PIN_LEVEL_HIGH );
MOVS	R0, #1
BL	_vRF4463SetPinSelect+0
;rf4463pro.c,406 :: 		return SUCCESS;
MOVS	R0, #0
;rf4463pro.c,407 :: 		}
L_end_ucRf4463GetCommand:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _ucRf4463GetCommand
_ucRf4463SetProperty:
;rf4463pro.c,412 :: 		uint8_t ucRf4463SetProperty( uint16_t usStartProperty, uint8_t ucLength, uint8_t * pcParametersBuffer ){
; usStartProperty start address is: 0 (R0)
SUB	SP, SP, #20
STR	LR, [SP, #0]
STRB	R1, [SP, #12]
UXTH	R1, R0
STR	R2, [SP, #16]
; usStartProperty end address is: 0 (R0)
; usStartProperty start address is: 4 (R1)
;rf4463pro.c,415 :: 		if( ucRf4463CheckCTS() == NOT_SUCCESS ){
STRH	R1, [SP, #4]
BL	_ucRf4463CheckCTS+0
LDRH	R1, [SP, #4]
CMP	R0, #1
IT	NE
BNE	L_ucRf4463SetProperty283
; usStartProperty end address is: 4 (R1)
;rf4463pro.c,416 :: 		return NOT_SUCCESS;
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463SetProperty
;rf4463pro.c,417 :: 		}
L_ucRf4463SetProperty283:
;rf4463pro.c,419 :: 		pcBuffer[ 0 ] = RF4463_CMD_SET_PROPERTY;
; usStartProperty start address is: 4 (R1)
ADD	R5, SP, #8
MOVS	R3, #17
STRB	R3, [R5, #0]
;rf4463pro.c,420 :: 		pcBuffer[ 1 ] = ( usStartProperty >> 8 );
ADDS	R4, R5, #1
LSRS	R3, R1, #8
STRB	R3, [R4, #0]
;rf4463pro.c,421 :: 		pcBuffer[ 2 ] = ucLength;
ADDS	R4, R5, #2
LDRB	R3, [SP, #12]
STRB	R3, [R4, #0]
;rf4463pro.c,422 :: 		pcBuffer[ 3 ] = ( usStartProperty & 0xFF );
ADDS	R4, R5, #3
AND	R3, R1, #255
; usStartProperty end address is: 4 (R1)
STRB	R3, [R4, #0]
;rf4463pro.c,424 :: 		vRF4463SetPinSelect( PIN_LEVEL_LOW );
MOVS	R0, #0
BL	_vRF4463SetPinSelect+0
;rf4463pro.c,425 :: 		vRf4463SPIWriteBuffer( 4, pcBuffer );
ADD	R3, SP, #8
MOV	R1, R3
MOVS	R0, #4
BL	_vRf4463SPIWriteBuffer+0
;rf4463pro.c,426 :: 		vRf4463SPIWriteBuffer( ucLength, pcParametersBuffer );
LDR	R1, [SP, #16]
LDRB	R0, [SP, #12]
BL	_vRf4463SPIWriteBuffer+0
;rf4463pro.c,427 :: 		vRF4463SetPinSelect( PIN_LEVEL_HIGH );
MOVS	R0, #1
BL	_vRF4463SetPinSelect+0
;rf4463pro.c,429 :: 		return SUCCESS;
MOVS	R0, #0
;rf4463pro.c,430 :: 		}
L_end_ucRf4463SetProperty:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _ucRf4463SetProperty
_ucRf4463GetProperty:
;rf4463pro.c,435 :: 		uint8_t ucRf4463GetProperty( uint16_t usStartProperty, uint8_t ucLength, uint8_t * pcParametersBuffer ){
; usStartProperty start address is: 0 (R0)
SUB	SP, SP, #20
STR	LR, [SP, #0]
STRB	R1, [SP, #12]
UXTH	R1, R0
STR	R2, [SP, #16]
; usStartProperty end address is: 0 (R0)
; usStartProperty start address is: 4 (R1)
;rf4463pro.c,438 :: 		if( ucRf4463CheckCTS() == NOT_SUCCESS ){
STRH	R1, [SP, #4]
BL	_ucRf4463CheckCTS+0
LDRH	R1, [SP, #4]
CMP	R0, #1
IT	NE
BNE	L_ucRf4463GetProperty284
; usStartProperty end address is: 4 (R1)
;rf4463pro.c,439 :: 		return NOT_SUCCESS;
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463GetProperty
;rf4463pro.c,440 :: 		}
L_ucRf4463GetProperty284:
;rf4463pro.c,442 :: 		pcBuffer[ 0 ] = RF4463_CMD_GET_PROPERTY;
; usStartProperty start address is: 4 (R1)
ADD	R5, SP, #8
MOVS	R3, #18
STRB	R3, [R5, #0]
;rf4463pro.c,443 :: 		pcBuffer[ 1 ] = ( usStartProperty >> 8 );
ADDS	R4, R5, #1
LSRS	R3, R1, #8
STRB	R3, [R4, #0]
;rf4463pro.c,444 :: 		pcBuffer[ 2 ] = ucLength;
ADDS	R4, R5, #2
LDRB	R3, [SP, #12]
STRB	R3, [R4, #0]
;rf4463pro.c,445 :: 		pcBuffer[ 3 ] = ( usStartProperty & 0xFF );
ADDS	R4, R5, #3
AND	R3, R1, #255
; usStartProperty end address is: 4 (R1)
STRB	R3, [R4, #0]
;rf4463pro.c,447 :: 		vRF4463SetPinSelect( PIN_LEVEL_LOW );
MOVS	R0, #0
BL	_vRF4463SetPinSelect+0
;rf4463pro.c,448 :: 		vRf4463SPIWriteBuffer( 4, pcBuffer );
ADD	R3, SP, #8
MOV	R1, R3
MOVS	R0, #4
BL	_vRf4463SPIWriteBuffer+0
;rf4463pro.c,450 :: 		if( ucRf4463CheckCTS() == NOT_SUCCESS ){
BL	_ucRf4463CheckCTS+0
CMP	R0, #1
IT	NE
BNE	L_ucRf4463GetProperty285
;rf4463pro.c,451 :: 		return NOT_SUCCESS;
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463GetProperty
;rf4463pro.c,452 :: 		}
L_ucRf4463GetProperty285:
;rf4463pro.c,454 :: 		vRF4463SetPinSelect( PIN_LEVEL_LOW );
MOVS	R0, #0
BL	_vRF4463SetPinSelect+0
;rf4463pro.c,455 :: 		ucRf4463SPIByte( RF4463_CMD_READ_BUF );
MOVS	R0, #68
BL	_ucRf4463SPIByte+0
;rf4463pro.c,456 :: 		vRf4463SPIReadBuffer( ucLength, pcParametersBuffer );
LDR	R1, [SP, #16]
LDRB	R0, [SP, #12]
BL	_vRf4463SPIReadBuffer+0
;rf4463pro.c,457 :: 		vRF4463SetPinSelect( PIN_LEVEL_HIGH );
MOVS	R0, #1
BL	_vRF4463SetPinSelect+0
;rf4463pro.c,459 :: 		return SUCCESS;
MOVS	R0, #0
;rf4463pro.c,460 :: 		}
L_end_ucRf4463GetProperty:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _ucRf4463GetProperty
_ucRf4463SetSyncWords:
;rf4463pro.c,465 :: 		uint8_t ucRf4463SetSyncWords( uint8_t * pcSyncWords, uint8_t ucLength ){
; ucLength start address is: 4 (R1)
; pcSyncWords start address is: 0 (R0)
SUB	SP, SP, #16
STR	LR, [SP, #0]
; ucLength end address is: 4 (R1)
; pcSyncWords end address is: 0 (R0)
; pcSyncWords start address is: 0 (R0)
; ucLength start address is: 4 (R1)
;rf4463pro.c,468 :: 		if( ( ucLength == 0 ) || ( ucLength > 3 ) ){
CMP	R1, #0
IT	EQ
BEQ	L__ucRf4463SetSyncWords323
CMP	R1, #3
IT	HI
BHI	L__ucRf4463SetSyncWords322
IT	AL
BAL	L_ucRf4463SetSyncWords288
; pcSyncWords end address is: 0 (R0)
; ucLength end address is: 4 (R1)
L__ucRf4463SetSyncWords323:
L__ucRf4463SetSyncWords322:
;rf4463pro.c,469 :: 		return NOT_SUCCESS;
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463SetSyncWords
;rf4463pro.c,470 :: 		}
L_ucRf4463SetSyncWords288:
;rf4463pro.c,472 :: 		pcBuffer[ 0 ] = ucLength - 1;
; ucLength start address is: 4 (R1)
; pcSyncWords start address is: 0 (R0)
ADD	R3, SP, #8
SUBS	R2, R1, #1
STRB	R2, [R3, #0]
;rf4463pro.c,473 :: 		memcpy( pcBuffer + 1, pcSyncWords, ucLength );
ADDS	R2, R3, #1
STR	R0, [SP, #4]
; ucLength end address is: 4 (R1)
MOV	R0, R2
UXTB	R2, R1
; pcSyncWords end address is: 0 (R0)
LDR	R1, [SP, #4]
BL	_memcpy+0
;rf4463pro.c,474 :: 		return ucRf4463SetProperty( RF4463_PROPERTY_SYNC_CONFIG, sizeof( pcBuffer ), pcBuffer );
ADD	R2, SP, #8
MOVS	R1, #5
MOVW	R0, #4352
BL	_ucRf4463SetProperty+0
;rf4463pro.c,475 :: 		}
L_end_ucRf4463SetSyncWords:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _ucRf4463SetSyncWords
_ucRf4463SetPreambleLength:
;rf4463pro.c,480 :: 		uint8_t ucRf4463SetPreambleLength( uint8_t ucLength ){
SUB	SP, SP, #8
STR	LR, [SP, #0]
STRB	R0, [SP, #4]
;rf4463pro.c,481 :: 		return ucRf4463SetProperty( RF4463_PROPERTY_PREAMBLE_TX_LENGTH, 1, &ucLength );
ADD	R1, SP, #4
MOV	R2, R1
MOVS	R1, #1
MOVW	R0, #4096
BL	_ucRf4463SetProperty+0
;rf4463pro.c,482 :: 		}
L_end_ucRf4463SetPreambleLength:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRf4463SetPreambleLength
_ucRf4463CheckCTS:
;rf4463pro.c,490 :: 		uint8_t ucRf4463CheckCTS(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;rf4463pro.c,491 :: 		uint16_t usTimeoutCounter = 0;
;rf4463pro.c,493 :: 		usTimeoutCounter = RF4463_CTS_TIMEOUT;
; usTimeoutCounter start address is: 8 (R2)
MOVW	R2, #2500
; usTimeoutCounter end address is: 8 (R2)
;rf4463pro.c,496 :: 		while( usTimeoutCounter-- ){
L_ucRf4463CheckCTS289:
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
BEQ	L_ucRf4463CheckCTS290
; usTimeoutCounter end address is: 16 (R4)
;rf4463pro.c,497 :: 		vRF4463SetPinSelect( PIN_LEVEL_LOW );
; usTimeoutCounter start address is: 16 (R4)
MOVS	R0, #0
BL	_vRF4463SetPinSelect+0
;rf4463pro.c,498 :: 		ucRf4463SPIByte( RF4463_CMD_READ_BUF );
MOVS	R0, #68
BL	_ucRf4463SPIByte+0
;rf4463pro.c,499 :: 		if( ucRf4463SPIByte( RF4463_CMD_READ_BUF ) == RF4463_CTS_REPLY ){
MOVS	R0, #68
BL	_ucRf4463SPIByte+0
CMP	R0, #255
IT	NE
BNE	L_ucRf4463CheckCTS291
; usTimeoutCounter end address is: 16 (R4)
;rf4463pro.c,501 :: 		vRF4463SetPinSelect( PIN_LEVEL_HIGH );
MOVS	R0, #1
BL	_vRF4463SetPinSelect+0
;rf4463pro.c,502 :: 		return SUCCESS;
MOVS	R0, #0
IT	AL
BAL	L_end_ucRf4463CheckCTS
;rf4463pro.c,503 :: 		}
L_ucRf4463CheckCTS291:
;rf4463pro.c,504 :: 		vRF4463SetPinSelect( PIN_LEVEL_HIGH );
; usTimeoutCounter start address is: 16 (R4)
MOVS	R0, #1
BL	_vRF4463SetPinSelect+0
;rf4463pro.c,505 :: 		}
UXTH	R2, R4
; usTimeoutCounter end address is: 16 (R4)
IT	AL
BAL	L_ucRf4463CheckCTS289
L_ucRf4463CheckCTS290:
;rf4463pro.c,506 :: 		STM_LOGE( "[ RF4463 ] CTS failed\r\n", NULL );
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_119_main+0)
MOVT	R1, #hi_addr(?lstr_119_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,507 :: 		return NOT_SUCCESS;
MOVS	R0, #1
;rf4463pro.c,508 :: 		}
L_end_ucRf4463CheckCTS:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ucRf4463CheckCTS
_vRf4463RSSI:
;rf4463pro.c,513 :: 		void vRf4463RSSI(){
SUB	SP, SP, #20
STR	LR, [SP, #0]
;rf4463pro.c,547 :: 		pcBuffer[ 0 ] = 0x20;
ADD	R2, SP, #13
MOVS	R0, #32
STRB	R0, [R2, #0]
;rf4463pro.c,548 :: 		pcBuffer[ 1 ] = 0x01;
ADDS	R1, R2, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;rf4463pro.c,549 :: 		pcBuffer[ 2 ] = 0x4E;
ADDS	R1, R2, #2
MOVS	R0, #78
STRB	R0, [R1, #0]
;rf4463pro.c,550 :: 		pcBuffer[ 3 ] = 0x40;
ADDS	R1, R2, #3
MOVS	R0, #64
STRB	R0, [R1, #0]
;rf4463pro.c,551 :: 		ucRf4463SetCommand( 4, RF4463_CMD_SET_PROPERTY, pcBuffer );
MOVS	R1, #17
MOVS	R0, #4
BL	_ucRf4463SetCommand+0
;rf4463pro.c,552 :: 		ucRf4463GetCommand( 9, RF4463_CMD_GET_MODEM_STATUS , pcRSSI );
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #34
MOVS	R0, #9
BL	_ucRf4463GetCommand+0
;rf4463pro.c,553 :: 		intRSSI = ( ( ( pcRSSI[ 4 ] / 2 ) -64 ) - 60 );
ADD	R0, SP, #4
ADDS	R0, R0, #4
LDRB	R0, [R0, #0]
LSRS	R0, R0, #1
UXTB	R0, R0
SUBS	R0, #64
SXTH	R0, R0
SUBW	R1, R0, #60
;rf4463pro.c,554 :: 		intRFLastRSSI = intRSSI;
MOVW	R0, #lo_addr(main_intRFLastRSSI+0)
MOVT	R0, #hi_addr(main_intRFLastRSSI+0)
STRH	R1, [R0, #0]
;rf4463pro.c,556 :: 		STM_LOGD( "[ RF4463 ] RSSI: %i\r\n", intRSSI );
SXTH	R2, R1
MOVW	R1, #lo_addr(?lstr_120_main+0)
MOVT	R1, #hi_addr(?lstr_120_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,557 :: 		}
L_end_vRf4463RSSI:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _vRf4463RSSI
_xRF4463GetLastRSSI:
;rf4463pro.c,562 :: 		int16_t xRF4463GetLastRSSI(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;rf4463pro.c,563 :: 		STM_LOGV( "[ RF4463 ] Last Measured RSSI: %i\r\n", intRFLastRSSI );
MOVW	R0, #lo_addr(main_intRFLastRSSI+0)
MOVT	R0, #hi_addr(main_intRFLastRSSI+0)
LDRSH	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_121_main+0)
MOVT	R1, #hi_addr(?lstr_121_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,564 :: 		return intRFLastRSSI;
MOVW	R0, #lo_addr(main_intRFLastRSSI+0)
MOVT	R0, #hi_addr(main_intRFLastRSSI+0)
LDRSH	R0, [R0, #0]
;rf4463pro.c,565 :: 		}
L_end_xRF4463GetLastRSSI:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _xRF4463GetLastRSSI
_ucRf4463DeviceAvailability:
;rf4463pro.c,571 :: 		uint8_t ucRf4463DeviceAvailability(){
SUB	SP, SP, #16
STR	LR, [SP, #0]
;rf4463pro.c,575 :: 		if( ucRf4463GetCommand( 9, RF4463_CMD_PART_INFO, pcBuffer ) == NOT_SUCCESS ){
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #1
MOVS	R0, #9
BL	_ucRf4463GetCommand+0
CMP	R0, #1
IT	NE
BNE	L_ucRf4463DeviceAvailability292
;rf4463pro.c,576 :: 		return NOT_SUCCESS;
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463DeviceAvailability
;rf4463pro.c,577 :: 		}
L_ucRf4463DeviceAvailability292:
;rf4463pro.c,579 :: 		usPartInformation = ( ( pcBuffer[ 2 ] << 8 ) | pcBuffer[ 3 ] );
ADD	R2, SP, #4
ADDS	R0, R2, #2
LDRB	R0, [R0, #0]
LSLS	R1, R0, #8
UXTH	R1, R1
ADDS	R0, R2, #3
LDRB	R0, [R0, #0]
ORRS	R1, R0
UXTH	R1, R1
;rf4463pro.c,581 :: 		if( usPartInformation != 0x4463 ){
MOVW	R0, #17507
CMP	R1, R0
IT	EQ
BEQ	L_ucRf4463DeviceAvailability293
;rf4463pro.c,582 :: 		return NOT_SUCCESS;
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463DeviceAvailability
;rf4463pro.c,583 :: 		}
L_ucRf4463DeviceAvailability293:
;rf4463pro.c,585 :: 		return SUCCESS;
MOVS	R0, #0
;rf4463pro.c,586 :: 		}
L_end_ucRf4463DeviceAvailability:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _ucRf4463DeviceAvailability
_ucRf4463SetGPIOMode:
;rf4463pro.c,594 :: 		uint8_t ucRf4463SetGPIOMode( uint8_t ucGPIO0Mode, uint8_t ucGPIO1Mode ){
; ucGPIO1Mode start address is: 4 (R1)
; ucGPIO0Mode start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
; ucGPIO1Mode end address is: 4 (R1)
; ucGPIO0Mode end address is: 0 (R0)
; ucGPIO0Mode start address is: 0 (R0)
; ucGPIO1Mode start address is: 4 (R1)
;rf4463pro.c,595 :: 		uint8_t pcBuffer[ 6 ] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
MOVS	R2, #0
STRB	R2, [SP, #4]
MOVS	R2, #0
STRB	R2, [SP, #5]
MOVS	R2, #0
STRB	R2, [SP, #6]
MOVS	R2, #0
STRB	R2, [SP, #7]
MOVS	R2, #0
STRB	R2, [SP, #8]
MOVS	R2, #0
STRB	R2, [SP, #9]
;rf4463pro.c,597 :: 		pcBuffer[ 0 ] = ucGPIO0Mode;
ADD	R3, SP, #4
STRB	R0, [R3, #0]
; ucGPIO0Mode end address is: 0 (R0)
;rf4463pro.c,598 :: 		pcBuffer[ 1 ] = ucGPIO1Mode;
ADDS	R2, R3, #1
STRB	R1, [R2, #0]
; ucGPIO1Mode end address is: 4 (R1)
;rf4463pro.c,600 :: 		return ucRf4463SetCommand( sizeof( pcBuffer ), RF4463_CMD_GPIO_PIN_CFG, pcBuffer );
MOV	R2, R3
MOVS	R1, #19
MOVS	R0, #6
BL	_ucRf4463SetCommand+0
;rf4463pro.c,601 :: 		}
L_end_ucRf4463SetGPIOMode:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _ucRf4463SetGPIOMode
_vRf4463FIFOReset:
;rf4463pro.c,606 :: 		void vRf4463FIFOReset(){
SUB	SP, SP, #8
STR	LR, [SP, #0]
;rf4463pro.c,607 :: 		uint8_t ucData = 0x03;
MOVS	R0, #3
STRB	R0, [SP, #4]
;rf4463pro.c,609 :: 		ucRf4463SetCommand( sizeof( ucData ), RF4463_CMD_FIFO_INFO, &ucData );
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #21
MOVS	R0, #1
BL	_ucRf4463SetCommand+0
;rf4463pro.c,610 :: 		}
L_end_vRf4463FIFOReset:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vRf4463FIFOReset
_ucRf4463ClearInterrupts:
;rf4463pro.c,615 :: 		uint8_t ucRf4463ClearInterrupts(){
SUB	SP, SP, #8
STR	LR, [SP, #0]
;rf4463pro.c,616 :: 		uint8_t pcBuffer[] = { 0x00, 0x00, 0x00 };
MOVS	R0, #0
STRB	R0, [SP, #4]
MOVS	R0, #0
STRB	R0, [SP, #5]
MOVS	R0, #0
STRB	R0, [SP, #6]
;rf4463pro.c,618 :: 		return ucRf4463SetCommand( sizeof( pcBuffer ), RF4463_CMD_GET_INT_STATUS, pcBuffer );
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #32
MOVS	R0, #3
BL	_ucRf4463SetCommand+0
;rf4463pro.c,619 :: 		}
L_end_ucRf4463ClearInterrupts:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRf4463ClearInterrupts
_ucRf4463EnterStandbyMode:
;rf4463pro.c,624 :: 		uint8_t ucRf4463EnterStandbyMode(){
SUB	SP, SP, #8
STR	LR, [SP, #0]
;rf4463pro.c,625 :: 		uint8_t ucData = 0x01;
MOVS	R0, #1
STRB	R0, [SP, #4]
;rf4463pro.c,627 :: 		return ucRf4463SetCommand( 1, RF4463_CMD_CHANGE_STATE, &ucData );
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #52
MOVS	R0, #1
BL	_ucRf4463SetCommand+0
;rf4463pro.c,628 :: 		}
L_end_ucRf4463EnterStandbyMode:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRf4463EnterStandbyMode
_vRf4463SetFrecc:
;rf4463pro.c,633 :: 		uint8_t vRf4463SetFrecc(float foCentral)
; foCentral start address is: 0 (R0)
SUB	SP, SP, #16
STR	LR, [SP, #0]
MOV	R8, R0
; foCentral end address is: 0 (R0)
; foCentral start address is: 32 (R8)
;rf4463pro.c,648 :: 		if (foCentral <= 1050.0 && foCentral >= 850.0)
MOVW	R0, #16384
MOVT	R0, #17539
MOV	R2, R8
BL	__Compare_FP+0
MOVW	R0, #0
BLT	L__vRf4463SetFrecc415
MOVS	R0, #1
L__vRf4463SetFrecc415:
CMP	R0, #0
IT	EQ
BEQ	L__vRf4463SetFrecc352
MOVW	R0, #32768
MOVT	R0, #17492
MOV	R2, R8
BL	__Compare_FP+0
MOVW	R0, #0
BGT	L__vRf4463SetFrecc416
MOVS	R0, #1
L__vRf4463SetFrecc416:
CMP	R0, #0
IT	EQ
BEQ	L__vRf4463SetFrecc351
L__vRf4463SetFrecc350:
;rf4463pro.c,650 :: 		outdiv = 4, band = 0;
; outdiv start address is: 0 (R0)
MOVS	R0, #4
;rf4463pro.c,651 :: 		}
IT	AL
BAL	L_vRf4463SetFrecc297
; foCentral end address is: 32 (R8)
; outdiv end address is: 0 (R0)
;rf4463pro.c,648 :: 		if (foCentral <= 1050.0 && foCentral >= 850.0)
L__vRf4463SetFrecc352:
L__vRf4463SetFrecc351:
;rf4463pro.c,654 :: 		return 0;
MOVS	R0, #0
IT	AL
BAL	L_end_vRf4463SetFrecc
;rf4463pro.c,655 :: 		}
L_vRf4463SetFrecc297:
;rf4463pro.c,660 :: 		f_pfd = 2 * xtal_frequency / outdiv;
; outdiv start address is: 0 (R0)
; foCentral start address is: 32 (R8)
MOVW	R1, #34560
MOVT	R1, #915
UDIV	R1, R1, R0
; outdiv end address is: 0 (R0)
; f_pfd start address is: 40 (R10)
MOV	R10, R1
;rf4463pro.c,661 :: 		n = ((unsigned int)(foCentral / f_pfd)) - 1;
MOV	R0, R1
BL	__UnsignedIntegralToFloat+0
STR	R0, [SP, #12]
STR	R1, [SP, #4]
LDR	R1, [SP, #12]
MOV	R2, R1
MOV	R0, R8
BL	__Div_FP+0
LDR	R1, [SP, #4]
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
SUBS	R1, R0, #1
; n start address is: 36 (R9)
UXTH	R9, R1
;rf4463pro.c,662 :: 		ratio = foCentral / (float)f_pfd;
MOV	R0, R10
BL	__UnsignedIntegralToFloat+0
; f_pfd end address is: 40 (R10)
STR	R0, [SP, #12]
STR	R1, [SP, #4]
LDR	R1, [SP, #12]
MOV	R2, R1
MOV	R0, R8
BL	__Div_FP+0
; foCentral end address is: 32 (R8)
LDR	R1, [SP, #4]
; ratio start address is: 12 (R3)
MOV	R3, R0
;rf4463pro.c,663 :: 		rest  = ratio - (float)n;
UXTH	R0, R9
BL	__UnsignedIntegralToFloat+0
STR	R0, [SP, #12]
STR	R1, [SP, #4]
LDR	R1, [SP, #12]
MOV	R0, R3
MOV	R2, R1
BL	__Sub_FP+0
; ratio end address is: 12 (R3)
LDR	R1, [SP, #4]
;rf4463pro.c,664 :: 		m = (unsigned long)(rest * 524288UL);
MOV	R2, #1224736768
BL	__Mul_FP+0
BL	__FloatToUnsignedIntegral+0
;rf4463pro.c,665 :: 		m2 = m / 0x10000;
LSRS	R1, R0, #16
; m2 start address is: 16 (R4)
UXTH	R4, R1
;rf4463pro.c,666 :: 		m1 = (m - m2 * 0x10000) / 0x100;
UXTH	R1, R1
LSLS	R2, R1, #16
SUB	R1, R0, R2
LSRS	R3, R1, #8
; m1 start address is: 20 (R5)
UXTH	R5, R3
;rf4463pro.c,667 :: 		m0 = (m - m2 * 0x10000 - m1 * 0x100);
UXTH	R1, R2
SUB	R2, R0, R1
UXTH	R1, R3
LSLS	R1, R1, #8
UXTH	R1, R1
SUB	R1, R2, R1
; m0 start address is: 0 (R0)
UXTH	R0, R1
;rf4463pro.c,670 :: 		freq_control[0] = n;
ADD	R2, SP, #8
STRB	R9, [R2, #0]
; n end address is: 36 (R9)
;rf4463pro.c,671 :: 		freq_control[1] = m2;
ADDS	R1, R2, #1
STRB	R4, [R1, #0]
; m2 end address is: 16 (R4)
;rf4463pro.c,672 :: 		freq_control[2] = m1;
ADDS	R1, R2, #2
STRB	R5, [R1, #0]
; m1 end address is: 20 (R5)
;rf4463pro.c,673 :: 		freq_control[3] = m0;
ADDS	R1, R2, #3
STRB	R0, [R1, #0]
; m0 end address is: 0 (R0)
;rf4463pro.c,678 :: 		}
L_end_vRf4463SetFrecc:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _vRf4463SetFrecc
_vRf4463EnterTxMode:
;rf4463pro.c,683 :: 		void vRf4463EnterTxMode(){
SUB	SP, SP, #12
STR	LR, [SP, #0]
;rf4463pro.c,698 :: 		uint8_t pcBuffer[] = { 0x00, 0x30, 0x00, 0x00, 0x00, 0x00, 0x01 };
MOVS	R0, #0
STRB	R0, [SP, #4]
MOVS	R0, #48
STRB	R0, [SP, #5]
MOVS	R0, #0
STRB	R0, [SP, #6]
MOVS	R0, #0
STRB	R0, [SP, #7]
MOVS	R0, #0
STRB	R0, [SP, #8]
MOVS	R0, #0
STRB	R0, [SP, #9]
MOVS	R0, #1
STRB	R0, [SP, #10]
;rf4463pro.c,699 :: 		pcBuffer[ 0 ] = ucTxChannel;
ADD	R1, SP, #4
MOVW	R0, #lo_addr(main_ucTxChannel+0)
MOVT	R0, #hi_addr(main_ucTxChannel+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;rf4463pro.c,700 :: 		ucRf4463SetCommand( 7, RF4463_CMD_START_TX, pcBuffer );
MOV	R2, R1
MOVS	R1, #49
MOVS	R0, #7
BL	_ucRf4463SetCommand+0
;rf4463pro.c,702 :: 		}
L_end_vRf4463EnterTxMode:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRf4463EnterTxMode
_ucRf4463SetTxInterrupt:
;rf4463pro.c,707 :: 		uint8_t ucRf4463SetTxInterrupt(){
SUB	SP, SP, #8
STR	LR, [SP, #0]
;rf4463pro.c,708 :: 		uint8_t pcBuffer[ 3 ] = { 0x01, 0x20, 0x00 };
MOVS	R0, #1
STRB	R0, [SP, #4]
MOVS	R0, #32
STRB	R0, [SP, #5]
MOVS	R0, #0
STRB	R0, [SP, #6]
;rf4463pro.c,709 :: 		return ucRf4463SetProperty( RF4463_PROPERTY_INT_CTL_ENABLE, 3, pcBuffer );
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #3
MOVW	R0, #256
BL	_ucRf4463SetProperty+0
;rf4463pro.c,710 :: 		}
L_end_ucRf4463SetTxInterrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRf4463SetTxInterrupt
_ucRf4463SetTxPower:
;rf4463pro.c,715 :: 		uint8_t ucRf4463SetTxPower( uint8_t ucPower ){
; ucPower start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; ucPower end address is: 0 (R0)
; ucPower start address is: 0 (R0)
;rf4463pro.c,717 :: 		uint8_t pcBuffer[] = { 0x08, 0x7F, 0x00, 0x5D };  // 0X3D
MOVS	R1, #8
STRB	R1, [SP, #4]
MOVS	R1, #127
STRB	R1, [SP, #5]
MOVS	R1, #0
STRB	R1, [SP, #6]
MOVS	R1, #93
STRB	R1, [SP, #7]
;rf4463pro.c,719 :: 		if( ucPower > 127 ){
CMP	R0, #127
IT	LS
BLS	L__ucRf4463SetTxPower324
;rf4463pro.c,720 :: 		STM_LOGE( "[ RF4463 ] Invalid Power Value: %d\r\n", ucPower );
MOVW	R2, #lo_addr(?lstr_122_main+0)
MOVT	R2, #hi_addr(?lstr_122_main+0)
MOVW	R1, #lo_addr(_vDebugPrint+0)
MOVT	R1, #hi_addr(_vDebugPrint+0)
PUSH	(R0)
; ucPower end address is: 0 (R0)
PUSH	(R2)
PUSH	(R1)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,721 :: 		ucPower = 127;
; ucPower start address is: 0 (R0)
MOVS	R0, #127
; ucPower end address is: 0 (R0)
;rf4463pro.c,722 :: 		}
IT	AL
BAL	L_ucRf4463SetTxPower298
L__ucRf4463SetTxPower324:
;rf4463pro.c,719 :: 		if( ucPower > 127 ){
;rf4463pro.c,722 :: 		}
L_ucRf4463SetTxPower298:
;rf4463pro.c,724 :: 		pcBuffer[ 1 ] = ucPower;
; ucPower start address is: 0 (R0)
ADD	R1, SP, #4
ADDS	R1, R1, #1
STRB	R0, [R1, #0]
;rf4463pro.c,725 :: 		STM_LOGV( "[ RF4463 ] Set Tx Power to: %d\r\n", ucPower );
MOVW	R2, #lo_addr(?lstr_123_main+0)
MOVT	R2, #hi_addr(?lstr_123_main+0)
MOVW	R1, #lo_addr(_vDebugPrint+0)
MOVT	R1, #hi_addr(_vDebugPrint+0)
PUSH	(R0)
; ucPower end address is: 0 (R0)
PUSH	(R2)
PUSH	(R1)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,726 :: 		return ucRf4463SetProperty( RF4463_PROPERTY_PA_MODE, sizeof( pcBuffer ), pcBuffer );
ADD	R1, SP, #4
MOV	R2, R1
MOVS	R1, #4
MOVW	R0, #8704
BL	_ucRf4463SetProperty+0
;rf4463pro.c,727 :: 		}
L_end_ucRf4463SetTxPower:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRf4463SetTxPower
_vRf4463WriteTxFIFO:
;rf4463pro.c,732 :: 		void vRf4463WriteTxFIFO( uint8_t * pcWriteBuffer, uint8_t ucLength ){
; pcWriteBuffer start address is: 0 (R0)
SUB	SP, SP, #76
STR	LR, [SP, #0]
STRB	R1, [SP, #72]
; pcWriteBuffer end address is: 0 (R0)
; pcWriteBuffer start address is: 0 (R0)
;rf4463pro.c,737 :: 		ucRf4463SetProperty( RF4463_PROPERTY_PKT_FIELD_2_LENGTH_7_0, 1, &ucLength );
ADD	R2, SP, #72
STR	R0, [SP, #4]
MOVS	R1, #1
MOVW	R0, #4626
BL	_ucRf4463SetProperty+0
LDR	R0, [SP, #4]
;rf4463pro.c,739 :: 		pcBuffer[ 0 ] = ucLength;
ADD	R3, SP, #8
LDRB	R2, [SP, #72]
STRB	R2, [R3, #0]
;rf4463pro.c,741 :: 		memcpy( pcBuffer + 1, pcWriteBuffer, ucLength );
ADDS	R2, R3, #1
MOV	R1, R0
MOV	R0, R2
; pcWriteBuffer end address is: 0 (R0)
LDRB	R2, [SP, #72]
BL	_memcpy+0
;rf4463pro.c,743 :: 		ucRf4463SetCommand( ucLength + 1, RF4463_CMD_TX_FIFO_WRITE, pcBuffer );
ADD	R3, SP, #8
LDRB	R2, [SP, #72]
ADDS	R2, R2, #1
MOVS	R1, #102
UXTB	R0, R2
MOV	R2, R3
BL	_ucRf4463SetCommand+0
;rf4463pro.c,744 :: 		}
L_end_vRf4463WriteTxFIFO:
LDR	LR, [SP, #0]
ADD	SP, SP, #76
BX	LR
; end of _vRf4463WriteTxFIFO
_ucRf4463TxPacket:
;rf4463pro.c,749 :: 		uint8_t ucRf4463TxPacket( uint8_t * pcTxBuffer, uint8_t ucTxLength ){
SUB	SP, SP, #12
STR	LR, [SP, #0]
STR	R0, [SP, #4]
STRB	R1, [SP, #8]
;rf4463pro.c,751 :: 		vRf4463FIFOReset();
BL	_vRf4463FIFOReset+0
;rf4463pro.c,753 :: 		vRf4463WriteTxFIFO( pcTxBuffer, ucTxLength );
LDRB	R1, [SP, #8]
LDR	R0, [SP, #4]
BL	_vRf4463WriteTxFIFO+0
;rf4463pro.c,755 :: 		vRf4463EnterTxMode();
BL	_vRf4463EnterTxMode+0
;rf4463pro.c,757 :: 		return SUCCESS;
MOVS	R0, #0
;rf4463pro.c,758 :: 		}
L_end_ucRf4463TxPacket:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _ucRf4463TxPacket
_ucRf4463TxPacket_Seq:
;rf4463pro.c,763 :: 		uint8_t ucRf4463TxPacket_Seq( uint8_t * pcTxBuffer, uint8_t ucTxLength ){
SUB	SP, SP, #12
STR	LR, [SP, #0]
STR	R0, [SP, #4]
STRB	R1, [SP, #8]
;rf4463pro.c,765 :: 		uint8_t ucCounter = 0;
;rf4463pro.c,767 :: 		vRf4463FIFOReset();
BL	_vRf4463FIFOReset+0
;rf4463pro.c,768 :: 		vRf4463WriteTxFIFO( pcTxBuffer, ucTxLength );
LDRB	R1, [SP, #8]
LDR	R0, [SP, #4]
BL	_vRf4463WriteTxFIFO+0
;rf4463pro.c,769 :: 		ucRf4463ClearInterrupts();
BL	_ucRf4463ClearInterrupts+0
;rf4463pro.c,770 :: 		vRf4463EnterTxMode();
BL	_vRf4463EnterTxMode+0
;rf4463pro.c,772 :: 		for( ;; ){
L_ucRf4463TxPacket_Seq299:
;rf4463pro.c,773 :: 		if( ucRF4463GetIRQFlag() == 1 ){
BL	_ucRF4463GetIRQFlag+0
CMP	R0, #1
IT	NE
BNE	L_ucRf4463TxPacket_Seq302
;rf4463pro.c,774 :: 		break;
IT	AL
BAL	L_ucRf4463TxPacket_Seq300
;rf4463pro.c,775 :: 		}
L_ucRf4463TxPacket_Seq302:
;rf4463pro.c,776 :: 		}
IT	AL
BAL	L_ucRf4463TxPacket_Seq299
L_ucRf4463TxPacket_Seq300:
;rf4463pro.c,778 :: 		return SUCCESS;
MOVS	R0, #0
;rf4463pro.c,779 :: 		}
L_end_ucRf4463TxPacket_Seq:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _ucRf4463TxPacket_Seq
_vRf4463EnterRxMode:
;rf4463pro.c,787 :: 		void vRf4463EnterRxMode(){
SUB	SP, SP, #12
STR	LR, [SP, #0]
;rf4463pro.c,789 :: 		uint8_t pcBuffer[7] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
MOVS	R0, #0
STRB	R0, [SP, #4]
MOVS	R0, #0
STRB	R0, [SP, #5]
MOVS	R0, #0
STRB	R0, [SP, #6]
MOVS	R0, #0
STRB	R0, [SP, #7]
MOVS	R0, #0
STRB	R0, [SP, #8]
MOVS	R0, #0
STRB	R0, [SP, #9]
MOVS	R0, #0
STRB	R0, [SP, #10]
;rf4463pro.c,790 :: 		pcBuffer[ 0 ] = ucRxChannel;
ADD	R1, SP, #4
MOVW	R0, #lo_addr(main_ucRxChannel+0)
MOVT	R0, #hi_addr(main_ucRxChannel+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;rf4463pro.c,802 :: 		ucRf4463SetCommand( 7, RF4463_CMD_START_RX, pcBuffer );
MOV	R2, R1
MOVS	R1, #50
MOVS	R0, #7
BL	_ucRf4463SetCommand+0
;rf4463pro.c,803 :: 		}
L_end_vRf4463EnterRxMode:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRf4463EnterRxMode
_ucRf4463SetRxInterrupt:
;rf4463pro.c,808 :: 		uint8_t ucRf4463SetRxInterrupt(){
SUB	SP, SP, #8
STR	LR, [SP, #0]
;rf4463pro.c,809 :: 		uint8_t pcBuffer[ 3 ] = { 0x03, 0x18, 0x00 };
MOVS	R0, #3
STRB	R0, [SP, #4]
MOVS	R0, #24
STRB	R0, [SP, #5]
MOVS	R0, #0
STRB	R0, [SP, #6]
;rf4463pro.c,810 :: 		return ucRf4463SetProperty( RF4463_PROPERTY_INT_CTL_ENABLE, 3, pcBuffer );
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #3
MOVW	R0, #256
BL	_ucRf4463SetProperty+0
;rf4463pro.c,811 :: 		}
L_end_ucRf4463SetRxInterrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRf4463SetRxInterrupt
_ucRf4463RxInit:
;rf4463pro.c,816 :: 		uint8_t ucRf4463RxInit(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;rf4463pro.c,817 :: 		ucRf4463SetProperty( RF4463_PROPERTY_PKT_FIELD_2_LENGTH_7_0, 1, RF_MAX_BUFFER_LENGTH );
MOVS	R2, #64
MOVS	R1, #1
MOVW	R0, #4626
BL	_ucRf4463SetProperty+0
;rf4463pro.c,819 :: 		vRf4463FIFOReset();
BL	_vRf4463FIFOReset+0
;rf4463pro.c,821 :: 		vRf4463EnterRxMode();
BL	_vRf4463EnterRxMode+0
;rf4463pro.c,823 :: 		return SUCCESS;
MOVS	R0, #0
;rf4463pro.c,824 :: 		}
L_end_ucRf4463RxInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ucRf4463RxInit
_ucRf4463RxPacket:
;rf4463pro.c,829 :: 		uint8_t ucRf4463RxPacket( uint8_t * pcRxBuffer ){
; pcRxBuffer start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; pcRxBuffer end address is: 0 (R0)
; pcRxBuffer start address is: 0 (R0)
;rf4463pro.c,830 :: 		uint8_t ucRxLength = 0;
MOVS	R1, #0
STRB	R1, [SP, #4]
;rf4463pro.c,832 :: 		vRf4463ReadRxFIFO( pcRxBuffer );
; pcRxBuffer end address is: 0 (R0)
BL	_vRf4463ReadRxFIFO+0
;rf4463pro.c,834 :: 		vRf4463FIFOReset();
BL	_vRf4463FIFOReset+0
;rf4463pro.c,836 :: 		return ucRxLength;
LDRB	R0, [SP, #4]
;rf4463pro.c,837 :: 		}
L_end_ucRf4463RxPacket:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRf4463RxPacket
_vRf4463ReadRxFIFO:
;rf4463pro.c,842 :: 		void vRf4463ReadRxFIFO( uint8_t * pcBuffer ){
SUB	SP, SP, #12
STR	LR, [SP, #0]
STR	R0, [SP, #8]
;rf4463pro.c,845 :: 		if( ucRf4463CheckCTS() == NOT_SUCCESS ){
BL	_ucRf4463CheckCTS+0
CMP	R0, #1
IT	NE
BNE	L_vRf4463ReadRxFIFO303
;rf4463pro.c,846 :: 		return;
IT	AL
BAL	L_end_vRf4463ReadRxFIFO
;rf4463pro.c,847 :: 		}
L_vRf4463ReadRxFIFO303:
;rf4463pro.c,849 :: 		vRF4463SetPinSelect( PIN_LEVEL_LOW );
MOVS	R0, #0
BL	_vRF4463SetPinSelect+0
;rf4463pro.c,851 :: 		ucRf4463SPIByte( RF4463_CMD_RX_FIFO_READ );
MOVS	R0, #119
BL	_ucRf4463SPIByte+0
;rf4463pro.c,852 :: 		vRf4463SPIReadBuffer( 1, &pcReadLength );
ADD	R1, SP, #4
MOVS	R0, #1
BL	_vRf4463SPIReadBuffer+0
;rf4463pro.c,854 :: 		vRf4463SPIReadBuffer( RF_MAX_BUFFER_LENGTH, pcBuffer );
LDR	R1, [SP, #8]
MOVS	R0, #64
BL	_vRf4463SPIReadBuffer+0
;rf4463pro.c,856 :: 		vRF4463SetPinSelect( PIN_LEVEL_HIGH );
MOVS	R0, #1
BL	_vRF4463SetPinSelect+0
;rf4463pro.c,859 :: 		vRf4463RSSI();
BL	_vRf4463RSSI+0
;rf4463pro.c,862 :: 		return;
;rf4463pro.c,863 :: 		}
L_end_vRf4463ReadRxFIFO:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRf4463ReadRxFIFO
_ucRF4463GetModemStatus:
;rf4463pro.c,871 :: 		uint8_t ucRF4463GetModemStatus(){
SUB	SP, SP, #8
STR	LR, [SP, #0]
;rf4463pro.c,874 :: 		ucRf4463GetCommand( 3, RF4463_CMD_GET_MODEM_STATUS, pcData );
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #34
MOVS	R0, #3
BL	_ucRf4463GetCommand+0
;rf4463pro.c,876 :: 		STM_LOGV( "[ RF4463 ] Modem Status\r\n", NULL );
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_124_main+0)
MOVT	R1, #hi_addr(?lstr_124_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,877 :: 		STM_LOGV( "[ ] CTS:          0x%X\r\n", pcData[ 0 ] );
ADD	R0, SP, #4
LDRB	R0, [R0, #0]
UXTB	R2, R0
MOVW	R1, #lo_addr(?lstr_125_main+0)
MOVT	R1, #hi_addr(?lstr_125_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,878 :: 		STM_LOGV( "[ ] MODEM_PEND:   0x%X\r\n", pcData[ 1 ] );
ADD	R0, SP, #4
ADDS	R0, R0, #1
LDRB	R0, [R0, #0]
UXTB	R2, R0
MOVW	R1, #lo_addr(?lstr_126_main+0)
MOVT	R1, #hi_addr(?lstr_126_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,879 :: 		STM_LOGV( "[ ] MODEM_STATUS: 0x%X\r\n", pcData[ 2 ] );
ADD	R0, SP, #4
ADDS	R0, R0, #2
LDRB	R0, [R0, #0]
UXTB	R2, R0
MOVW	R1, #lo_addr(?lstr_127_main+0)
MOVT	R1, #hi_addr(?lstr_127_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,881 :: 		return pcData[ 2 ];
ADD	R0, SP, #4
ADDS	R0, R0, #2
LDRB	R0, [R0, #0]
;rf4463pro.c,882 :: 		}
L_end_ucRF4463GetModemStatus:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRF4463GetModemStatus
_ucRF4463GetIntStatus:
;rf4463pro.c,887 :: 		uint8_t ucRF4463GetIntStatus(){
SUB	SP, SP, #16
STR	LR, [SP, #0]
;rf4463pro.c,890 :: 		ucRf4463GetCommand( 9, RF4463_CMD_GET_INT_STATUS , pcData );
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #32
MOVS	R0, #9
BL	_ucRf4463GetCommand+0
;rf4463pro.c,892 :: 		if( pcData[ GET_INT_STATUS_REPLY_INDEX_CHIP_STATUS ] == ( GET_INT_STATUS_REPLY_CHIP_STATUS_FIFO_UNDERFLOW_OVERFLOW_ERROR | GET_INT_STATUS_REPLY_CHIP_STATUS_STATE_CHANGE ) ){
ADD	R0, SP, #4
ADDS	R0, #8
LDRB	R0, [R0, #0]
CMP	R0, #48
IT	NE
BNE	L_ucRF4463GetIntStatus304
;rf4463pro.c,893 :: 		STM_LOGI( "[ RF4463 ] Underflow Overflow flag is active\r\n", NULL );
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_128_main+0)
MOVT	R1, #hi_addr(?lstr_128_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,904 :: 		return 1;
MOVS	R0, #1
IT	AL
BAL	L_end_ucRF4463GetIntStatus
;rf4463pro.c,905 :: 		}
L_ucRF4463GetIntStatus304:
;rf4463pro.c,906 :: 		return 0;
MOVS	R0, #0
;rf4463pro.c,907 :: 		}
L_end_ucRF4463GetIntStatus:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _ucRF4463GetIntStatus
_ucRF4463CheckIntStatus:
;rf4463pro.c,912 :: 		uint8_t ucRF4463CheckIntStatus(){
SUB	SP, SP, #16
STR	LR, [SP, #0]
;rf4463pro.c,915 :: 		ucRf4463GetCommand( 9, RF4463_CMD_GET_INT_STATUS , pcData );
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #32
MOVS	R0, #9
BL	_ucRf4463GetCommand+0
;rf4463pro.c,917 :: 		STM_LOGV( "[ RF4463 ] Get Interrupt Flags Status\r\n", NULL );
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_129_main+0)
MOVT	R1, #hi_addr(?lstr_129_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,919 :: 		STM_LOGV( "[ RF4463 INT_STATUS ] INT_PEND:     0x%02x\r\n", pcData[ GET_INT_STATUS_REPLY_INDEX_INT_PEND ] );
ADD	R0, SP, #4
ADDS	R0, R0, #1
LDRB	R0, [R0, #0]
UXTB	R2, R0
MOVW	R1, #lo_addr(?lstr_130_main+0)
MOVT	R1, #hi_addr(?lstr_130_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,920 :: 		STM_LOGV( "[ RF4463 INT_STATUS ] INT_STATUS:   0x%02x\r\n", pcData[ GET_INT_STATUS_REPLY_INDEX_INT_STATUS ] );
ADD	R0, SP, #4
ADDS	R0, R0, #2
LDRB	R0, [R0, #0]
UXTB	R2, R0
MOVW	R1, #lo_addr(?lstr_131_main+0)
MOVT	R1, #hi_addr(?lstr_131_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,921 :: 		STM_LOGV( "[ RF4463 INT_STATUS ] PH_PEND:      0x%02x\r\n", pcData[ GET_INT_STATUS_REPLY_INDEX_PH_PEND ] );
ADD	R0, SP, #4
ADDS	R0, R0, #3
LDRB	R0, [R0, #0]
UXTB	R2, R0
MOVW	R1, #lo_addr(?lstr_132_main+0)
MOVT	R1, #hi_addr(?lstr_132_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,922 :: 		STM_LOGV( "[ RF4463 INT_STATUS ] PH_STATUS:    0x%02x\r\n", pcData[ GET_INT_STATUS_REPLY_INDEX_PH_STATUS ] );
ADD	R0, SP, #4
ADDS	R0, R0, #4
LDRB	R0, [R0, #0]
UXTB	R2, R0
MOVW	R1, #lo_addr(?lstr_133_main+0)
MOVT	R1, #hi_addr(?lstr_133_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,923 :: 		STM_LOGV( "[ RF4463 INT_STATUS ] MODEM_PEND:   0x%02x\r\n", pcData[ GET_INT_STATUS_REPLY_INDEX_MODEM_PEND ] );
ADD	R0, SP, #4
ADDS	R0, R0, #5
LDRB	R0, [R0, #0]
UXTB	R2, R0
MOVW	R1, #lo_addr(?lstr_134_main+0)
MOVT	R1, #hi_addr(?lstr_134_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,924 :: 		STM_LOGV( "[ RF4463 INT_STATUS ] MODEM_STATUS: 0x%02x\r\n", pcData[ GET_INT_STATUS_REPLY_INDEX_MODEM_STATUS ] );
ADD	R0, SP, #4
ADDS	R0, R0, #6
LDRB	R0, [R0, #0]
UXTB	R2, R0
MOVW	R1, #lo_addr(?lstr_135_main+0)
MOVT	R1, #hi_addr(?lstr_135_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,925 :: 		STM_LOGV( "[ RF4463 INT_STATUS ] CHIP_PEND:    0x%02x\r\n", pcData[ GET_INT_STATUS_REPLY_INDEX_CHIP_PEND ] );
ADD	R0, SP, #4
ADDS	R0, R0, #7
LDRB	R0, [R0, #0]
UXTB	R2, R0
MOVW	R1, #lo_addr(?lstr_136_main+0)
MOVT	R1, #hi_addr(?lstr_136_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,926 :: 		STM_LOGV( "[ RF4463 INT_STATUS ] CHIP_STATUS:  0x%02x\r\n", pcData[ GET_INT_STATUS_REPLY_INDEX_CHIP_STATUS ] );
ADD	R0, SP, #4
ADDS	R0, #8
LDRB	R0, [R0, #0]
UXTB	R2, R0
MOVW	R1, #lo_addr(?lstr_137_main+0)
MOVT	R1, #hi_addr(?lstr_137_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,928 :: 		return ( pcData[ GET_INT_STATUS_REPLY_INDEX_CHIP_STATUS ] & GET_INT_STATUS_REPLY_CHIP_STATUS_FIFO_UNDERFLOW_OVERFLOW_ERROR );
ADD	R0, SP, #4
ADDS	R0, #8
LDRB	R0, [R0, #0]
AND	R0, R0, #32
;rf4463pro.c,929 :: 		}
L_end_ucRF4463CheckIntStatus:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _ucRF4463CheckIntStatus
_vRF4463CheckState:
;rf4463pro.c,934 :: 		void vRF4463CheckState(){
SUB	SP, SP, #8
STR	LR, [SP, #0]
;rf4463pro.c,937 :: 		if( ucRf4463CheckCTS() == NOT_SUCCESS ){
BL	_ucRf4463CheckCTS+0
CMP	R0, #1
IT	NE
BNE	L_vRF4463CheckState305
;rf4463pro.c,938 :: 		STM_LOGE( "[ RF4463 ] Failed CTS\r\n", NULL );
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_138_main+0)
MOVT	R1, #hi_addr(?lstr_138_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,939 :: 		return;
IT	AL
BAL	L_end_vRF4463CheckState
;rf4463pro.c,940 :: 		}
L_vRF4463CheckState305:
;rf4463pro.c,942 :: 		ucRf4463GetCommand( 3, RF4463_CMD_REQUEST_DEVICE_STATE, pcData );
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #51
MOVS	R0, #3
BL	_ucRf4463GetCommand+0
;rf4463pro.c,944 :: 		STM_LOGV( "[ RF4463 ] Main State: 0x%02X\r\n", pcData[ 1 ] );
ADD	R0, SP, #4
ADDS	R0, R0, #1
LDRB	R0, [R0, #0]
UXTB	R2, R0
MOVW	R1, #lo_addr(?lstr_139_main+0)
MOVT	R1, #hi_addr(?lstr_139_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,945 :: 		STM_LOGV( "[ RF4463 ] Current Channel: 0x%02X\r\n", pcData[ 2 ] );
ADD	R0, SP, #4
ADDS	R0, R0, #2
LDRB	R0, [R0, #0]
UXTB	R2, R0
MOVW	R1, #lo_addr(?lstr_140_main+0)
MOVT	R1, #hi_addr(?lstr_140_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,946 :: 		}
L_end_vRF4463CheckState:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vRF4463CheckState
_vRF4463SetState:
;rf4463pro.c,951 :: 		void vRF4463SetState( uint8_t ucState ){
; ucState start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; ucState end address is: 0 (R0)
; ucState start address is: 0 (R0)
;rf4463pro.c,954 :: 		pcData[ 0 ] = ucState;
ADD	R1, SP, #4
STRB	R0, [R1, #0]
; ucState end address is: 0 (R0)
;rf4463pro.c,956 :: 		ucRf4463SetCommand( 1, RF4463_CMD_CHANGE_STATE, pcData );
MOV	R2, R1
MOVS	R1, #52
MOVS	R0, #1
BL	_ucRf4463SetCommand+0
;rf4463pro.c,957 :: 		}
L_end_vRF4463SetState:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vRF4463SetState
_vRf4463SPIWriteBuffer:
;rf4463spi.c,35 :: 		void vRf4463SPIWriteBuffer( uint16_t usWriteLength, uint8_t * pcWriteBuffer ){
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
;rf4463spi.c,39 :: 		while( usWriteLength-- ){
L_vRf4463SPIWriteBuffer306:
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
BEQ	L_vRf4463SPIWriteBuffer307
; usWriteLength end address is: 16 (R4)
;rf4463spi.c,40 :: 		ucRf4463SPIByte( *pcWriteBuffer++ );
; usWriteLength start address is: 16 (R4)
LDRB	R2, [R5, #0]
UXTB	R0, R2
BL	_ucRf4463SPIByte+0
ADDS	R5, R5, #1
;rf4463spi.c,41 :: 		}
UXTH	R0, R4
; usWriteLength end address is: 16 (R4)
; pcWriteBuffer end address is: 20 (R5)
IT	AL
BAL	L_vRf4463SPIWriteBuffer306
L_vRf4463SPIWriteBuffer307:
;rf4463spi.c,42 :: 		}
L_end_vRf4463SPIWriteBuffer:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vRf4463SPIWriteBuffer
_vRf4463SPIReadBuffer:
;rf4463spi.c,50 :: 		void vRf4463SPIReadBuffer( uint16_t usReadLength, uint8_t * pcReadBuffer ){
; pcReadBuffer start address is: 4 (R1)
; usReadLength start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; pcReadBuffer end address is: 4 (R1)
; usReadLength end address is: 0 (R0)
; usReadLength start address is: 0 (R0)
; pcReadBuffer start address is: 4 (R1)
;rf4463spi.c,51 :: 		uint8_t ucRxCounter = 0;
; ucRxCounter start address is: 20 (R5)
MOVS	R5, #0
; pcReadBuffer end address is: 4 (R1)
; usReadLength end address is: 0 (R0)
; ucRxCounter end address is: 20 (R5)
MOV	R4, R1
;rf4463spi.c,55 :: 		while( usReadLength-- ){
L_vRf4463SPIReadBuffer308:
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
BEQ	L_vRf4463SPIReadBuffer309
; pcReadBuffer end address is: 16 (R4)
; usReadLength end address is: 24 (R6)
;rf4463spi.c,56 :: 		pcReadBuffer[ ucRxCounter++ ] = ucRf4463SPIByte( 0 );
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
;rf4463spi.c,57 :: 		}
UXTH	R0, R6
; pcReadBuffer end address is: 16 (R4)
; usReadLength end address is: 24 (R6)
; ucRxCounter end address is: 20 (R5)
IT	AL
BAL	L_vRf4463SPIReadBuffer308
L_vRf4463SPIReadBuffer309:
;rf4463spi.c,58 :: 		}
L_end_vRf4463SPIReadBuffer:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vRf4463SPIReadBuffer
_ucRf4463SPIByte:
;rf4463spi.c,66 :: 		uint8_t ucRf4463SPIByte( uint8_t pcWriteData ){
; pcWriteData start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; pcWriteData end address is: 0 (R0)
; pcWriteData start address is: 0 (R0)
;rf4463spi.c,67 :: 		return SPI2_Read( pcWriteData );
; pcWriteData end address is: 0 (R0)
BL	_SPI2_Read+0
UXTB	R0, R0
;rf4463spi.c,68 :: 		}
L_end_ucRf4463SPIByte:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ucRf4463SPIByte
_vButtonISR:
;buttonhandler.c,37 :: 		void vButtonISR() iv IVT_INT_EXTI9_5 ics ICS_AUTO{
;buttonhandler.c,38 :: 		if( EXTI_PR.B8 ){
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_LX	[R0, ByteOffset(EXTI_PR+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vButtonISR310
;buttonhandler.c,39 :: 		EXTI_PR.B8 |= 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_SX	[R0, ByteOffset(EXTI_PR+0)]
;buttonhandler.c,42 :: 		}
L_vButtonISR310:
;buttonhandler.c,43 :: 		}
L_end_vButtonISR:
BX	LR
; end of _vButtonISR
_vButtonSetup:
;buttonhandler.c,51 :: 		void vButtonSetup(){
SUB	SP, SP, #28
STR	LR, [SP, #0]
;buttonhandler.c,52 :: 		GPIO_Digital_Input( &GPIOB_BASE, _GPIO_PINMASK_8 );
MOVW	R1, #256
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Input+0
;buttonhandler.c,57 :: 		RCC_APB2ENRbits.AFIOEN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB2ENRbits+0)
MOVT	R0, #hi_addr(RCC_APB2ENRbits+0)
_SX	[R0, ByteOffset(RCC_APB2ENRbits+0)]
;buttonhandler.c,61 :: 		AFIO_EXTICR3    |= 0x0001;
MOVW	R0, #lo_addr(AFIO_EXTICR3+0)
MOVT	R0, #hi_addr(AFIO_EXTICR3+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(AFIO_EXTICR3+0)
MOVT	R0, #hi_addr(AFIO_EXTICR3+0)
STR	R1, [R0, #0]
;buttonhandler.c,65 :: 		EXTI_IMR.B8     |= 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
_SX	[R0, ByteOffset(EXTI_IMR+0)]
;buttonhandler.c,66 :: 		EXTI_FTSR.B8    |= 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
_SX	[R0, ByteOffset(EXTI_FTSR+0)]
;buttonhandler.c,68 :: 		NVIC_IntEnable( IVT_INT_EXTI9_5 );
MOVW	R0, #39
BL	_NVIC_IntEnable+0
;buttonhandler.c,70 :: 		UART1_Write_Text( "[ SETUP ] Button Done\r\n" );
ADD	R11, SP, #4
ADD	R10, R11, #24
MOVW	R12, #lo_addr(?ICS?lstr141_main+0)
MOVT	R12, #hi_addr(?ICS?lstr141_main+0)
BL	___CC2DW+0
ADD	R0, SP, #4
BL	_UART1_Write_Text+0
;buttonhandler.c,71 :: 		}
L_end_vButtonSetup:
LDR	LR, [SP, #0]
ADD	SP, SP, #28
BX	LR
; end of _vButtonSetup
_Timer6_interrupt:
;timer.c,37 :: 		void Timer6_interrupt() iv IVT_INT_TIM6 {
;timer.c,38 :: 		TIM6_SR.UIF = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM6_SR+0)
MOVT	R0, #hi_addr(TIM6_SR+0)
_SX	[R0, ByteOffset(TIM6_SR+0)]
;timer.c,40 :: 		LEDGreen = ~LEDGreen;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_LX	[R0, ByteOffset(GPIOC_ODR+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;timer.c,41 :: 		}
L_end_Timer6_interrupt:
BX	LR
; end of _Timer6_interrupt
_vTimerStop:
;timer.c,49 :: 		void vTimerStop( uint8_t ucTimer ){
; ucTimer start address is: 0 (R0)
; ucTimer end address is: 0 (R0)
; ucTimer start address is: 0 (R0)
;timer.c,50 :: 		if( ucTimer == TIMER_SEARCH ){
CMP	R0, #0
IT	NE
BNE	L_vTimerStop311
; ucTimer end address is: 0 (R0)
;timer.c,51 :: 		TIM6_CR1.CEN = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(TIM6_CR1+0)
MOVT	R1, #hi_addr(TIM6_CR1+0)
_SX	[R1, ByteOffset(TIM6_CR1+0)]
;timer.c,52 :: 		}
L_vTimerStop311:
;timer.c,53 :: 		}
L_end_vTimerStop:
BX	LR
; end of _vTimerStop
_vTimerSearchLed:
;timer.c,58 :: 		void vTimerSearchLed(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;timer.c,59 :: 		RCC_APB1ENR.TIM6EN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
_SX	[R0, ByteOffset(RCC_APB1ENR+0)]
;timer.c,60 :: 		TIM6_CR1.CEN = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM6_CR1+0)
MOVT	R0, #hi_addr(TIM6_CR1+0)
_SX	[R0, ByteOffset(TIM6_CR1+0)]
;timer.c,61 :: 		TIM6_PSC = 575;
MOVW	R1, #575
MOVW	R0, #lo_addr(TIM6_PSC+0)
MOVT	R0, #hi_addr(TIM6_PSC+0)
STR	R1, [R0, #0]
;timer.c,62 :: 		TIM6_ARR = 62499;
MOVW	R1, #62499
MOVW	R0, #lo_addr(TIM6_ARR+0)
MOVT	R0, #hi_addr(TIM6_ARR+0)
STR	R1, [R0, #0]
;timer.c,63 :: 		NVIC_IntEnable(IVT_INT_TIM6);
MOVW	R0, #70
BL	_NVIC_IntEnable+0
;timer.c,64 :: 		TIM6_DIER.UIE = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM6_DIER+0)
MOVT	R0, #hi_addr(TIM6_DIER+0)
_SX	[R0, ByteOffset(TIM6_DIER+0)]
;timer.c,65 :: 		TIM6_CR1.CEN = 1;
MOVW	R0, #lo_addr(TIM6_CR1+0)
MOVT	R0, #hi_addr(TIM6_CR1+0)
_SX	[R0, ByteOffset(TIM6_CR1+0)]
;timer.c,66 :: 		}
L_end_vTimerSearchLed:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vTimerSearchLed
_main:
;main.c,66 :: 		void main(){
;main.c,67 :: 		Delay_ms( 1000 );
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_main312:
SUBS	R7, R7, #1
BNE	L_main312
NOP
NOP
NOP
;main.c,71 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_6 );
MOVW	R1, #64
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;main.c,72 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_7 );
MOVW	R1, #128
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;main.c,73 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_8 );
MOVW	R1, #256
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;main.c,75 :: 		GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_7 );
MOVW	R1, #128
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;main.c,76 :: 		Sound_Init( &GPIOB_ODR, 7 );
MOVS	R1, #7
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
BL	_Sound_Init+0
;main.c,77 :: 		Sound_Play( 1000, 100 );
MOVS	R1, #100
MOVW	R0, #1000
BL	_Sound_Play+0
;main.c,79 :: 		LEDRed      = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;main.c,80 :: 		LEDGreen    = 1;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;main.c,81 :: 		LEDBlue     = 1;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;main.c,83 :: 		vUARTTxInit();
BL	_vUARTTxInit+0
;main.c,84 :: 		STM_LOGE( "TEST\r\n", NULL );
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_142_main+0)
MOVT	R1, #hi_addr(?lstr_142_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;main.c,88 :: 		ucRF4463Setup( RF4463_DEFAULT_CHANNEL, RF4463_DEFAULT_CHANNEL, RF4463_DEFAULT_NETWORK, RF4463_DEFAULT_TX_POWER );
MOVS	R3, #127
MOVS	R2, #1
MOVS	R1, #0
MOVS	R0, #0
BL	_ucRF4463Setup+0
;main.c,92 :: 		LEDRed      = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;main.c,93 :: 		LEDBlue     = 0;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;main.c,94 :: 		LEDGreen    = 0;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;main.c,98 :: 		vDongleLoop();
BL	_vDongleLoop+0
;main.c,99 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
