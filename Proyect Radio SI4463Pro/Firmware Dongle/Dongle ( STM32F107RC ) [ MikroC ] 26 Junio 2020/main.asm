_vDongleLoop:
;dongle.c,43 :: 		void vDongleLoop(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;dongle.c,44 :: 		NVIC_IntEnable( IVT_INT_EXTI15_10 );
MOVW	R0, #56
BL	_NVIC_IntEnable+0
;dongle.c,46 :: 		vUARTRxInit();
BL	_vUARTRxInit+0
;dongle.c,49 :: 		UART1_Write_Text( "APP_START\r\n" );
MOVW	R0, #lo_addr(?lstr11_main+0)
MOVT	R0, #hi_addr(?lstr11_main+0)
BL	_UART1_Write_Text+0
;dongle.c,54 :: 		while( 1 ){
L_vDongleLoop0:
;dongle.c,55 :: 		if( ucUARTDataReady == 1 ){
MOVW	R0, #lo_addr(_ucUARTDataReady+0)
MOVT	R0, #hi_addr(_ucUARTDataReady+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_vDongleLoop2
;dongle.c,56 :: 		ucUARTDataReady = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucUARTDataReady+0)
MOVT	R0, #hi_addr(_ucUARTDataReady+0)
STRB	R1, [R0, #0]
;dongle.c,57 :: 		vUARTRxMessage();
BL	_vUARTRxMessage+0
;dongle.c,58 :: 		}
L_vDongleLoop2:
;dongle.c,59 :: 		if( ucRadioEvent == 1 ){
MOVW	R0, #lo_addr(_ucRadioEvent+0)
MOVT	R0, #hi_addr(_ucRadioEvent+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_vDongleLoop3
;dongle.c,60 :: 		ucRadioEvent = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucRadioEvent+0)
MOVT	R0, #hi_addr(_ucRadioEvent+0)
STRB	R1, [R0, #0]
;dongle.c,61 :: 		vRFRxMessage();
BL	_vRFRxMessage+0
;dongle.c,62 :: 		}
L_vDongleLoop3:
;dongle.c,63 :: 		}
IT	AL
BAL	L_vDongleLoop0
;dongle.c,64 :: 		}
L_end_vDongleLoop:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vDongleLoop
_vUARTISR:
;uarthandler.c,64 :: 		void vUARTISR() iv IVT_INT_USART1 ics ICS_AUTO{
;uarthandler.c,65 :: 		LEDBlue = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;uarthandler.c,67 :: 		if( USART1_SRbits.RXNE == 1 && !USART1_SRbits.PE ){
MOVW	R0, #lo_addr(USART1_SRbits+0)
MOVT	R0, #hi_addr(USART1_SRbits+0)
_LX	[R0, ByteOffset(USART1_SRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L__vUARTISR278
MOVW	R0, #lo_addr(USART1_SRbits+0)
MOVT	R0, #hi_addr(USART1_SRbits+0)
_LX	[R0, ByteOffset(USART1_SRbits+0)]
CMP	R0, #0
IT	NE
BNE	L__vUARTISR277
L__vUARTISR276:
;uarthandler.c,68 :: 		ucTempByteUART = USART1_DR;
MOVW	R0, #lo_addr(USART1_DR+0)
MOVT	R0, #hi_addr(USART1_DR+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucTempByteUART+0)
MOVT	R0, #hi_addr(_ucTempByteUART+0)
STRB	R1, [R0, #0]
;uarthandler.c,69 :: 		if( ucTempByteUART == '\n' ){
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	NE
BNE	L_vUARTISR7
;uarthandler.c,70 :: 		pcRxUARTBuffer[ usUARTMessageLength++ ] = ucTempByteUART;
MOVW	R3, #lo_addr(_usUARTMessageLength+0)
MOVT	R3, #hi_addr(_usUARTMessageLength+0)
LDRH	R1, [R3, #0]
MOVW	R0, #lo_addr(main_pcRxUARTBuffer+0)
MOVT	R0, #hi_addr(main_pcRxUARTBuffer+0)
ADDS	R1, R0, R1
MOVW	R2, #lo_addr(_ucTempByteUART+0)
MOVT	R2, #hi_addr(_ucTempByteUART+0)
LDRB	R0, [R2, #0]
STRB	R0, [R1, #0]
MOV	R0, R3
LDRH	R0, [R0, #0]
ADDS	R0, R0, #1
STRH	R0, [R3, #0]
;uarthandler.c,71 :: 		ucUARTDataReady = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucUARTDataReady+0)
MOVT	R0, #hi_addr(_ucUARTDataReady+0)
STRB	R1, [R0, #0]
;uarthandler.c,72 :: 		ucTempByteUART = 0;
MOVS	R0, #0
STRB	R0, [R2, #0]
;uarthandler.c,73 :: 		LEDBlue = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;uarthandler.c,74 :: 		}
IT	AL
BAL	L_vUARTISR8
L_vUARTISR7:
;uarthandler.c,76 :: 		pcRxUARTBuffer[ usUARTMessageLength++ ] = ucTempByteUART;
MOVW	R3, #lo_addr(_usUARTMessageLength+0)
MOVT	R3, #hi_addr(_usUARTMessageLength+0)
LDRH	R1, [R3, #0]
MOVW	R0, #lo_addr(main_pcRxUARTBuffer+0)
MOVT	R0, #hi_addr(main_pcRxUARTBuffer+0)
ADDS	R2, R0, R1
MOVW	R1, #lo_addr(_ucTempByteUART+0)
MOVT	R1, #hi_addr(_ucTempByteUART+0)
LDRB	R0, [R1, #0]
STRB	R0, [R2, #0]
MOV	R0, R3
LDRH	R0, [R0, #0]
ADDS	R0, R0, #1
STRH	R0, [R3, #0]
;uarthandler.c,77 :: 		ucTempByteUART = 0;
MOVS	R0, #0
STRB	R0, [R1, #0]
;uarthandler.c,78 :: 		}
L_vUARTISR8:
;uarthandler.c,67 :: 		if( USART1_SRbits.RXNE == 1 && !USART1_SRbits.PE ){
L__vUARTISR278:
L__vUARTISR277:
;uarthandler.c,80 :: 		if( USART1_SRbits.ORE == 1 ){
MOVW	R0, #lo_addr(USART1_SRbits+0)
MOVT	R0, #hi_addr(USART1_SRbits+0)
_LX	[R0, ByteOffset(USART1_SRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUARTISR9
;uarthandler.c,81 :: 		ucTempByteUART = USART1_SR;
MOVW	R0, #lo_addr(USART1_SR+0)
MOVT	R0, #hi_addr(USART1_SR+0)
LDR	R0, [R0, #0]
MOVW	R1, #lo_addr(_ucTempByteUART+0)
MOVT	R1, #hi_addr(_ucTempByteUART+0)
STRB	R0, [R1, #0]
;uarthandler.c,82 :: 		ucTempByteUART = USART1_DR;
MOVW	R0, #lo_addr(USART1_DR+0)
MOVT	R0, #hi_addr(USART1_DR+0)
LDR	R0, [R0, #0]
STRB	R0, [R1, #0]
;uarthandler.c,83 :: 		}
L_vUARTISR9:
;uarthandler.c,84 :: 		}
L_end_vUARTISR:
BX	LR
; end of _vUARTISR
_vUARTTxInit:
;uarthandler.c,92 :: 		void vUARTTxInit(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;uarthandler.c,93 :: 		UART1_Init_Advanced( 115200, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10 );
MOVW	R0, #lo_addr(__GPIO_MODULE_USART1_PA9_10+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_USART1_PA9_10+0)
PUSH	(R0)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
MOV	R0, #115200
BL	_UART1_Init_Advanced+0
ADD	SP, SP, #4
;uarthandler.c,94 :: 		}
L_end_vUARTTxInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUARTTxInit
_vUARTRxInit:
;uarthandler.c,99 :: 		void vUARTRxInit(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;uarthandler.c,100 :: 		USART1_CR1bits.RE       = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(USART1_CR1bits+0)
MOVT	R0, #hi_addr(USART1_CR1bits+0)
_SX	[R0, ByteOffset(USART1_CR1bits+0)]
;uarthandler.c,101 :: 		USART1_CR1bits.RXNEIE   = 1;
MOVW	R0, #lo_addr(USART1_CR1bits+0)
MOVT	R0, #hi_addr(USART1_CR1bits+0)
_SX	[R0, ByteOffset(USART1_CR1bits+0)]
;uarthandler.c,103 :: 		NVIC_IntEnable( IVT_INT_USART1 );
MOVW	R0, #53
BL	_NVIC_IntEnable+0
;uarthandler.c,104 :: 		}
L_end_vUARTRxInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUARTRxInit
_vUARTRxMessage:
;uarthandler.c,109 :: 		void vUARTRxMessage(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;uarthandler.c,110 :: 		uint16_t usCounter = 0;
;uarthandler.c,117 :: 		STM_LOGV( "[ UART RX ] Packet: %s", pcRxUARTBuffer );
MOVW	R2, #lo_addr(main_pcRxUARTBuffer+0)
MOVT	R2, #hi_addr(main_pcRxUARTBuffer+0)
MOVW	R1, #lo_addr(?lstr_31_main+0)
MOVT	R1, #hi_addr(?lstr_31_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;uarthandler.c,119 :: 		vUARTCommands( pcRxUARTBuffer );
MOVW	R0, #lo_addr(main_pcRxUARTBuffer+0)
MOVT	R0, #hi_addr(main_pcRxUARTBuffer+0)
BL	_vUARTCommands+0
;uarthandler.c,121 :: 		memset( pcRxUARTBuffer, '\0', sizeof( pcRxUARTBuffer ) );
MOVW	R2, #2048
SXTH	R2, R2
MOVS	R1, #0
MOVW	R0, #lo_addr(main_pcRxUARTBuffer+0)
MOVT	R0, #hi_addr(main_pcRxUARTBuffer+0)
BL	_memset+0
;uarthandler.c,122 :: 		usUARTMessageLength = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_usUARTMessageLength+0)
MOVT	R0, #hi_addr(_usUARTMessageLength+0)
STRH	R1, [R0, #0]
;uarthandler.c,123 :: 		}
L_end_vUARTRxMessage:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUARTRxMessage
_vUARTCommands:
;uarthandler.c,128 :: 		void vUARTCommands( uint8_t * pcInBuffer ){
SUB	SP, SP, #68
STR	LR, [SP, #0]
STR	R0, [SP, #60]
;uarthandler.c,129 :: 		uint8_t ucCommandCounter = 0;
;uarthandler.c,130 :: 		uint8_t ucCounter = 0;
;uarthandler.c,131 :: 		uint8_t ucPosition = 0;
;uarthandler.c,136 :: 		uint16_t usTempData = 0;
;uarthandler.c,137 :: 		uint8_t ucDeviceModel = 0;
;uarthandler.c,139 :: 		for( ucCommandCounter = 0; ucCommandCounter < UART_Commands; ucCommandCounter++ ){
MOVS	R1, #0
STRB	R1, [SP, #64]
L_vUARTCommands10:
LDRB	R1, [SP, #64]
CMP	R1, #19
IT	CS
BCS	L_vUARTCommands11
;uarthandler.c,140 :: 		if( strstr( pcInBuffer, pcUARTCommand[ ucCommandCounter ] ) ){
LDRB	R1, [SP, #64]
LSLS	R2, R1, #2
MOVW	R1, #lo_addr(_pcUARTCommand+0)
MOVT	R1, #hi_addr(_pcUARTCommand+0)
ADDS	R1, R1, R2
LDR	R1, [R1, #0]
LDR	R0, [SP, #60]
BL	_strstr+0
CMP	R0, #0
IT	EQ
BEQ	L_vUARTCommands13
;uarthandler.c,141 :: 		switch( ucCommandCounter ){
IT	AL
BAL	L_vUARTCommands14
;uarthandler.c,142 :: 		case UART_CMD_WHO:
L_vUARTCommands16:
;uarthandler.c,143 :: 		UART1_Write_Text( "DONGLE\r\n" );
MOVW	R1, #lo_addr(?lstr32_main+0)
MOVT	R1, #hi_addr(?lstr32_main+0)
MOV	R0, R1
BL	_UART1_Write_Text+0
;uarthandler.c,144 :: 		Sound_Play( 1000, 100 );
MOVS	R1, #100
MOVW	R0, #1000
BL	_Sound_Play+0
;uarthandler.c,145 :: 		Delay_ms( 30 );
MOVW	R7, #32319
MOVT	R7, #5
NOP
NOP
L_vUARTCommands17:
SUBS	R7, R7, #1
BNE	L_vUARTCommands17
NOP
NOP
NOP
;uarthandler.c,146 :: 		Sound_Play( 1000, 100 );
MOVS	R1, #100
MOVW	R0, #1000
BL	_Sound_Play+0
;uarthandler.c,147 :: 		break;
IT	AL
BAL	L_vUARTCommands15
;uarthandler.c,148 :: 		case UART_CMD_SEND:
L_vUARTCommands19:
;uarthandler.c,149 :: 		STM_LOGD( "[ UART ] Send Message\r\n", NULL );
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(?lstr_33_main+0)
MOVT	R2, #hi_addr(?lstr_33_main+0)
MOVW	R1, #lo_addr(_vDebugPrint+0)
MOVT	R1, #hi_addr(_vDebugPrint+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_PrintOut+0
ADD	SP, SP, #12
;uarthandler.c,150 :: 		vRfSettingsHotSwap( CHANNEL_DEFAULT, NETWORK_DEFAULT );
MOVS	R1, #5
MOVS	R0, #5
BL	_vRfSettingsHotSwap+0
;uarthandler.c,151 :: 		memset( pcTempBuffer, '\0', 50 );
ADD	R1, SP, #8
MOVS	R2, #50
SXTH	R2, R2
MOV	R0, R1
MOVS	R1, #0
BL	_memset+0
;uarthandler.c,153 :: 		ucPosition = 5;
; ucPosition start address is: 0 (R0)
MOVS	R0, #5
;uarthandler.c,155 :: 		for( ucCounter = 0; ucCounter < usUARTMessageLength; ucCounter++ ){
; ucCounter start address is: 40 (R10)
MOVW	R10, #0
; ucCounter end address is: 40 (R10)
; ucPosition end address is: 0 (R0)
L_vUARTCommands20:
; ucCounter start address is: 40 (R10)
; ucPosition start address is: 0 (R0)
MOVW	R1, #lo_addr(_usUARTMessageLength+0)
MOVT	R1, #hi_addr(_usUARTMessageLength+0)
LDRH	R1, [R1, #0]
CMP	R10, R1
IT	CS
BCS	L_vUARTCommands21
;uarthandler.c,156 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
LDR	R1, [SP, #60]
ADDS	R1, R1, R0
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands269
LDR	R1, [SP, #60]
ADDS	R1, R1, R0
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands268
IT	AL
BAL	L_vUARTCommands25
; ucPosition end address is: 0 (R0)
L__vUARTCommands269:
L__vUARTCommands268:
;uarthandler.c,157 :: 		break;
IT	AL
BAL	L_vUARTCommands21
;uarthandler.c,158 :: 		}
L_vUARTCommands25:
;uarthandler.c,159 :: 		pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
; ucPosition start address is: 0 (R0)
ADD	R1, SP, #8
ADD	R2, R1, R10, LSL #0
LDR	R1, [SP, #60]
ADDS	R1, R1, R0
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
ADDS	R1, R0, #1
; ucPosition end address is: 0 (R0)
; ucPosition start address is: 8 (R2)
UXTB	R2, R1
;uarthandler.c,155 :: 		for( ucCounter = 0; ucCounter < usUARTMessageLength; ucCounter++ ){
ADD	R1, R10, #1
; ucCounter end address is: 40 (R10)
; ucCounter start address is: 4 (R1)
;uarthandler.c,160 :: 		}
UXTB	R0, R2
; ucPosition end address is: 8 (R2)
; ucCounter end address is: 4 (R1)
UXTB	R10, R1
IT	AL
BAL	L_vUARTCommands20
L_vUARTCommands21:
;uarthandler.c,164 :: 		ucRemoteNode = NODE_BROADCAST;
; ucCounter start address is: 40 (R10)
MOVS	R2, #255
MOVW	R1, #lo_addr(_ucRemoteNode+0)
MOVT	R1, #hi_addr(_ucRemoteNode+0)
STRB	R2, [R1, #0]
;uarthandler.c,165 :: 		ucSenderNode = NODE_FACTORY;
MOVS	R2, #254
MOVW	R1, #lo_addr(_ucSenderNode+0)
MOVT	R1, #hi_addr(_ucSenderNode+0)
STRB	R2, [R1, #0]
;uarthandler.c,166 :: 		ucTableIndex = Table_RF_Test;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucTableIndex+0)
MOVT	R1, #hi_addr(_ucTableIndex+0)
STRB	R2, [R1, #0]
;uarthandler.c,167 :: 		ucCommandIndex = Test_Device_QR;
MOVS	R2, #2
MOVW	R1, #lo_addr(_ucCommandIndex+0)
MOVT	R1, #hi_addr(_ucCommandIndex+0)
STRB	R2, [R1, #0]
;uarthandler.c,169 :: 		vRfTxMessage( pcTempBuffer, ucCounter );
ADD	R1, SP, #8
MOV	R0, R1
; ucCounter end address is: 40 (R10)
UXTB	R1, R10
BL	_vRfTxMessage+0
;uarthandler.c,170 :: 		break;
IT	AL
BAL	L_vUARTCommands15
;uarthandler.c,171 :: 		case UART_CMD_END:
L_vUARTCommands26:
;uarthandler.c,172 :: 		STM_LOGD( "[ UART ] End Factory Stage\r\n", NULL );
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(?lstr_34_main+0)
MOVT	R2, #hi_addr(?lstr_34_main+0)
MOVW	R1, #lo_addr(_vDebugPrint+0)
MOVT	R1, #hi_addr(_vDebugPrint+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_PrintOut+0
ADD	SP, SP, #12
;uarthandler.c,175 :: 		memset( pcSentQR, '\0', 15 );
MOVS	R2, #15
SXTH	R2, R2
MOVS	R1, #0
MOVW	R0, #lo_addr(main_pcSentQR+0)
MOVT	R0, #hi_addr(main_pcSentQR+0)
BL	_memset+0
;uarthandler.c,177 :: 		ucPosition = 6;
; ucPosition start address is: 0 (R0)
MOVS	R0, #6
;uarthandler.c,179 :: 		for( ucCounter = 0; ucCounter < usUARTMessageLength; ucCounter++ ){
; ucCounter start address is: 40 (R10)
MOVW	R10, #0
; ucCounter end address is: 40 (R10)
; ucPosition end address is: 0 (R0)
L_vUARTCommands27:
; ucCounter start address is: 40 (R10)
; ucPosition start address is: 0 (R0)
MOVW	R1, #lo_addr(_usUARTMessageLength+0)
MOVT	R1, #hi_addr(_usUARTMessageLength+0)
LDRH	R1, [R1, #0]
CMP	R10, R1
IT	CS
BCS	L_vUARTCommands28
;uarthandler.c,180 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
LDR	R1, [SP, #60]
ADDS	R1, R1, R0
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands271
LDR	R1, [SP, #60]
ADDS	R1, R1, R0
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands270
IT	AL
BAL	L_vUARTCommands32
; ucPosition end address is: 0 (R0)
L__vUARTCommands271:
L__vUARTCommands270:
;uarthandler.c,181 :: 		break;
IT	AL
BAL	L_vUARTCommands28
;uarthandler.c,182 :: 		}
L_vUARTCommands32:
;uarthandler.c,183 :: 		pcSentQR[ ucCounter ] = pcInBuffer[ ucPosition++ ];
; ucPosition start address is: 0 (R0)
MOVW	R1, #lo_addr(main_pcSentQR+0)
MOVT	R1, #hi_addr(main_pcSentQR+0)
ADD	R2, R1, R10, LSL #0
LDR	R1, [SP, #60]
ADDS	R1, R1, R0
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
ADDS	R2, R0, #1
UXTB	R2, R2
; ucPosition end address is: 0 (R0)
; ucPosition start address is: 8 (R2)
;uarthandler.c,179 :: 		for( ucCounter = 0; ucCounter < usUARTMessageLength; ucCounter++ ){
ADD	R1, R10, #1
UXTB	R1, R1
; ucCounter end address is: 40 (R10)
; ucCounter start address is: 4 (R1)
;uarthandler.c,184 :: 		}
UXTB	R0, R2
; ucPosition end address is: 8 (R2)
; ucCounter end address is: 4 (R1)
UXTB	R10, R1
IT	AL
BAL	L_vUARTCommands27
L_vUARTCommands28:
;uarthandler.c,186 :: 		ucRemoteNode = NODE_BROADCAST;
; ucCounter start address is: 40 (R10)
MOVS	R2, #255
MOVW	R1, #lo_addr(_ucRemoteNode+0)
MOVT	R1, #hi_addr(_ucRemoteNode+0)
STRB	R2, [R1, #0]
;uarthandler.c,187 :: 		ucSenderNode = NODE_FACTORY;
MOVS	R2, #254
MOVW	R1, #lo_addr(_ucSenderNode+0)
MOVT	R1, #hi_addr(_ucSenderNode+0)
STRB	R2, [R1, #0]
;uarthandler.c,188 :: 		ucTableIndex = Table_RF_Test;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucTableIndex+0)
MOVT	R1, #hi_addr(_ucTableIndex+0)
STRB	R2, [R1, #0]
;uarthandler.c,189 :: 		ucCommandIndex = Test_Device_Ok;
MOVS	R2, #3
MOVW	R1, #lo_addr(_ucCommandIndex+0)
MOVT	R1, #hi_addr(_ucCommandIndex+0)
STRB	R2, [R1, #0]
;uarthandler.c,191 :: 		vRfTxMessage( pcSentQR, ucCounter );
UXTB	R1, R10
; ucCounter end address is: 40 (R10)
MOVW	R0, #lo_addr(main_pcSentQR+0)
MOVT	R0, #hi_addr(main_pcSentQR+0)
BL	_vRfTxMessage+0
;uarthandler.c,192 :: 		break;
IT	AL
BAL	L_vUARTCommands15
;uarthandler.c,193 :: 		case UART_CMD_STAGE:
L_vUARTCommands33:
;uarthandler.c,194 :: 		STM_LOGD( "[ UART ] Get Stage\r\n", NULL );
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(?lstr_35_main+0)
MOVT	R2, #hi_addr(?lstr_35_main+0)
MOVW	R1, #lo_addr(_vDebugPrint+0)
MOVT	R1, #hi_addr(_vDebugPrint+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_PrintOut+0
ADD	SP, SP, #12
;uarthandler.c,195 :: 		vRfSettingsHotSwap( CHANNEL_DEFAULT, NETWORK_DEFAULT );
MOVS	R1, #5
MOVS	R0, #5
BL	_vRfSettingsHotSwap+0
;uarthandler.c,197 :: 		ucRemoteNode = NODE_BROADCAST;
MOVS	R2, #255
MOVW	R1, #lo_addr(_ucRemoteNode+0)
MOVT	R1, #hi_addr(_ucRemoteNode+0)
STRB	R2, [R1, #0]
;uarthandler.c,198 :: 		ucSenderNode = NODE_FACTORY;
MOVS	R2, #254
MOVW	R1, #lo_addr(_ucSenderNode+0)
MOVT	R1, #hi_addr(_ucSenderNode+0)
STRB	R2, [R1, #0]
;uarthandler.c,199 :: 		ucTableIndex = Table_RF_Test;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucTableIndex+0)
MOVT	R1, #hi_addr(_ucTableIndex+0)
STRB	R2, [R1, #0]
;uarthandler.c,200 :: 		ucCommandIndex = Test_Device_Stage;
MOVS	R2, #4
MOVW	R1, #lo_addr(_ucCommandIndex+0)
MOVT	R1, #hi_addr(_ucCommandIndex+0)
STRB	R2, [R1, #0]
;uarthandler.c,202 :: 		vRfTxMessage( NULL, NULL );
MOVS	R1, #0
MOVS	R0, #0
BL	_vRfTxMessage+0
;uarthandler.c,203 :: 		break;
IT	AL
BAL	L_vUARTCommands15
;uarthandler.c,204 :: 		case UART_CMD_REBOOT:
L_vUARTCommands34:
;uarthandler.c,205 :: 		STM_LOGD( "[ UART ] Reboot\r\n", NULL );
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
;uarthandler.c,207 :: 		LEDBlue = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
_SX	[R1, ByteOffset(GPIOC_ODR+0)]
;uarthandler.c,208 :: 		LEDGreen = 0;
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
_SX	[R1, ByteOffset(GPIOC_ODR+0)]
;uarthandler.c,209 :: 		LEDRed = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
_SX	[R1, ByteOffset(GPIOC_ODR+0)]
;uarthandler.c,211 :: 		Delay_ms( 1000 );
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_vUARTCommands35:
SUBS	R7, R7, #1
BNE	L_vUARTCommands35
NOP
NOP
NOP
;uarthandler.c,212 :: 		SystemReset();
BL	_SystemReset+0
;uarthandler.c,213 :: 		break;
IT	AL
BAL	L_vUARTCommands15
;uarthandler.c,214 :: 		case UART_CMD_PING:
L_vUARTCommands37:
;uarthandler.c,215 :: 		STM_LOGD( "[ UART ] Ping\r\n", NULL );
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
;uarthandler.c,216 :: 		ucRemoteNode = REMOTE_DEFAULT;
MOVS	R2, #2
MOVW	R1, #lo_addr(_ucRemoteNode+0)
MOVT	R1, #hi_addr(_ucRemoteNode+0)
STRB	R2, [R1, #0]
;uarthandler.c,217 :: 		ucSenderNode = HUB_NODE_DEFAULT;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucSenderNode+0)
MOVT	R1, #hi_addr(_ucSenderNode+0)
STRB	R2, [R1, #0]
;uarthandler.c,218 :: 		ucTableIndex = Table_RF_Test;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucTableIndex+0)
MOVT	R1, #hi_addr(_ucTableIndex+0)
STRB	R2, [R1, #0]
;uarthandler.c,219 :: 		ucCommandIndex = Test_PingDevice;
MOVS	R2, #0
MOVW	R1, #lo_addr(_ucCommandIndex+0)
MOVT	R1, #hi_addr(_ucCommandIndex+0)
STRB	R2, [R1, #0]
;uarthandler.c,221 :: 		vRfTxMessage( NULL, NULL );
MOVS	R1, #0
MOVS	R0, #0
BL	_vRfTxMessage+0
;uarthandler.c,222 :: 		break;
IT	AL
BAL	L_vUARTCommands15
;uarthandler.c,223 :: 		case UART_CMD_TEST:
L_vUARTCommands38:
;uarthandler.c,224 :: 		STM_LOGD( "[ UART ] Test\r\n", NULL );
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
;uarthandler.c,225 :: 		memset( pcTempBuffer, '\0', 50 );
ADD	R1, SP, #8
MOVS	R2, #50
SXTH	R2, R2
MOV	R0, R1
MOVS	R1, #0
BL	_memset+0
;uarthandler.c,227 :: 		ucPosition = 5;
; ucPosition start address is: 24 (R6)
MOVS	R6, #5
;uarthandler.c,229 :: 		for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
; ucCounter start address is: 0 (R0)
MOVS	R0, #0
; ucCounter end address is: 0 (R0)
; ucPosition end address is: 24 (R6)
UXTB	R4, R6
L_vUARTCommands39:
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 16 (R4)
CMP	R0, #12
IT	CS
BCS	L_vUARTCommands40
;uarthandler.c,230 :: 		pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
ADD	R3, SP, #8
ADDS	R2, R3, R0
LDR	R1, [SP, #60]
ADDS	R1, R1, R4
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
ADDS	R1, R4, #1
; ucPosition end address is: 16 (R4)
; ucPosition start address is: 24 (R6)
UXTB	R6, R1
;uarthandler.c,231 :: 		pcTempQR[ ucCounter ] = pcTempBuffer[ ucCounter ];
MOVW	R1, #lo_addr(_pcTempQR+0)
MOVT	R1, #hi_addr(_pcTempQR+0)
ADDS	R2, R1, R0
ADDS	R1, R3, R0
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
;uarthandler.c,229 :: 		for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
ADDS	R1, R0, #1
UXTB	R1, R1
; ucCounter end address is: 0 (R0)
; ucCounter start address is: 4 (R1)
;uarthandler.c,232 :: 		}
UXTB	R4, R6
; ucPosition end address is: 24 (R6)
; ucCounter end address is: 4 (R1)
UXTB	R0, R1
IT	AL
BAL	L_vUARTCommands39
L_vUARTCommands40:
;uarthandler.c,234 :: 		for( ucSearchedModelId = 0; ucSearchedModelId < TotalDevicesModel; ucSearchedModelId++ ){
MOVS	R2, #0
MOVW	R1, #lo_addr(_ucSearchedModelId+0)
MOVT	R1, #hi_addr(_ucSearchedModelId+0)
STRB	R2, [R1, #0]
L_vUARTCommands42:
MOVW	R1, #lo_addr(_ucSearchedModelId+0)
MOVT	R1, #hi_addr(_ucSearchedModelId+0)
LDRB	R1, [R1, #0]
CMP	R1, #5
IT	CS
BCS	L_vUARTCommands43
;uarthandler.c,235 :: 		if( memcmp( pcTempQR, pcModelQRPrefix[ ucSearchedModelId ], 2 ) == 0 ){
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
BNE	L_vUARTCommands45
;uarthandler.c,236 :: 		break;
IT	AL
BAL	L_vUARTCommands43
;uarthandler.c,237 :: 		}
L_vUARTCommands45:
;uarthandler.c,234 :: 		for( ucSearchedModelId = 0; ucSearchedModelId < TotalDevicesModel; ucSearchedModelId++ ){
MOVW	R2, #lo_addr(_ucSearchedModelId+0)
MOVT	R2, #hi_addr(_ucSearchedModelId+0)
LDRB	R1, [R2, #0]
ADDS	R1, R1, #1
STRB	R1, [R2, #0]
;uarthandler.c,238 :: 		}
IT	AL
BAL	L_vUARTCommands42
L_vUARTCommands43:
;uarthandler.c,240 :: 		ucRemoteNode = REMOTE_DEFAULT;
MOVS	R2, #2
MOVW	R1, #lo_addr(_ucRemoteNode+0)
MOVT	R1, #hi_addr(_ucRemoteNode+0)
STRB	R2, [R1, #0]
;uarthandler.c,241 :: 		ucSenderNode = HUB_NODE_DEFAULT;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucSenderNode+0)
MOVT	R1, #hi_addr(_ucSenderNode+0)
STRB	R2, [R1, #0]
;uarthandler.c,242 :: 		ucTableIndex = Table_RF_Setup;
MOVS	R2, #2
MOVW	R1, #lo_addr(_ucTableIndex+0)
MOVT	R1, #hi_addr(_ucTableIndex+0)
STRB	R2, [R1, #0]
;uarthandler.c,243 :: 		ucCommandIndex = Setup_Qr;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucCommandIndex+0)
MOVT	R1, #hi_addr(_ucCommandIndex+0)
STRB	R2, [R1, #0]
;uarthandler.c,245 :: 		vRfTxMessage( pcTempBuffer, strlen( pcTempBuffer ) );
ADD	R1, SP, #8
MOV	R0, R1
BL	_strlen+0
ADD	R1, SP, #8
STR	R1, [SP, #4]
UXTH	R1, R0
LDR	R0, [SP, #4]
BL	_vRfTxMessage+0
;uarthandler.c,246 :: 		break;
IT	AL
BAL	L_vUARTCommands15
;uarthandler.c,247 :: 		case UART_CMD_REMOVE:
L_vUARTCommands46:
;uarthandler.c,248 :: 		STM_LOGD( "[ UART ] Remove\r\n", NULL );
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
;uarthandler.c,250 :: 		memset( pcTempBuffer, '\0', 50 );
ADD	R1, SP, #8
MOVS	R2, #50
SXTH	R2, R2
MOV	R0, R1
MOVS	R1, #0
BL	_memset+0
;uarthandler.c,252 :: 		ucPosition = 7;
; ucPosition start address is: 12 (R3)
MOVS	R3, #7
;uarthandler.c,254 :: 		for( ucCounter = 0; ; ucCounter++ ){
; ucCounter start address is: 0 (R0)
MOVS	R0, #0
; ucPosition end address is: 12 (R3)
; ucCounter end address is: 0 (R0)
L_vUARTCommands47:
;uarthandler.c,255 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 12 (R3)
LDR	R1, [SP, #60]
ADDS	R1, R1, R3
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands273
LDR	R1, [SP, #60]
ADDS	R1, R1, R3
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands272
IT	AL
BAL	L_vUARTCommands52
; ucPosition end address is: 12 (R3)
; ucCounter end address is: 0 (R0)
L__vUARTCommands273:
L__vUARTCommands272:
;uarthandler.c,256 :: 		break;
IT	AL
BAL	L_vUARTCommands48
;uarthandler.c,257 :: 		}
L_vUARTCommands52:
;uarthandler.c,258 :: 		pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 12 (R3)
ADD	R1, SP, #8
ADDS	R2, R1, R0
LDR	R1, [SP, #60]
ADDS	R1, R1, R3
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
ADDS	R2, R3, #1
UXTB	R2, R2
; ucPosition end address is: 12 (R3)
; ucPosition start address is: 8 (R2)
;uarthandler.c,254 :: 		for( ucCounter = 0; ; ucCounter++ ){
ADDS	R1, R0, #1
UXTB	R1, R1
; ucCounter end address is: 0 (R0)
; ucCounter start address is: 4 (R1)
;uarthandler.c,259 :: 		}
UXTB	R3, R2
; ucPosition end address is: 8 (R2)
; ucCounter end address is: 4 (R1)
UXTB	R0, R1
IT	AL
BAL	L_vUARTCommands47
L_vUARTCommands48:
;uarthandler.c,261 :: 		usTempData = atoi( pcTempBuffer );
ADD	R1, SP, #8
MOV	R0, R1
BL	_atoi+0
;uarthandler.c,262 :: 		ucRemoteNode = usTempData;
UXTB	R2, R0
MOVW	R1, #lo_addr(_ucRemoteNode+0)
MOVT	R1, #hi_addr(_ucRemoteNode+0)
STRB	R2, [R1, #0]
;uarthandler.c,263 :: 		ucSenderNode = HUB_NODE_DEFAULT;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucSenderNode+0)
MOVT	R1, #hi_addr(_ucSenderNode+0)
STRB	R2, [R1, #0]
;uarthandler.c,264 :: 		ucTableIndex = Table_RF_Setup;
MOVS	R2, #2
MOVW	R1, #lo_addr(_ucTableIndex+0)
MOVT	R1, #hi_addr(_ucTableIndex+0)
STRB	R2, [R1, #0]
;uarthandler.c,265 :: 		ucCommandIndex = Setup_Delete;
MOVS	R2, #5
MOVW	R1, #lo_addr(_ucCommandIndex+0)
MOVT	R1, #hi_addr(_ucCommandIndex+0)
STRB	R2, [R1, #0]
;uarthandler.c,267 :: 		vRfTxMessage( NULL, NULL );
MOVS	R1, #0
MOVS	R0, #0
BL	_vRfTxMessage+0
;uarthandler.c,268 :: 		break;
IT	AL
BAL	L_vUARTCommands15
;uarthandler.c,269 :: 		case UART_CMD_CHANNEL:
L_vUARTCommands53:
;uarthandler.c,270 :: 		STM_LOGD( "[ UART ] Set Channel\r\n", NULL );
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
;uarthandler.c,271 :: 		memset( pcTempBuffer, '\0', 50 );
ADD	R1, SP, #8
MOVS	R2, #50
SXTH	R2, R2
MOV	R0, R1
MOVS	R1, #0
BL	_memset+0
;uarthandler.c,273 :: 		ucPosition = 8;
; ucPosition start address is: 12 (R3)
MOVS	R3, #8
;uarthandler.c,275 :: 		for( ucCounter = 0; ; ucCounter++ ){
; ucCounter start address is: 0 (R0)
MOVS	R0, #0
; ucPosition end address is: 12 (R3)
; ucCounter end address is: 0 (R0)
L_vUARTCommands54:
;uarthandler.c,276 :: 		if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 12 (R3)
LDR	R1, [SP, #60]
ADDS	R1, R1, R3
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands275
LDR	R1, [SP, #60]
ADDS	R1, R1, R3
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands274
IT	AL
BAL	L_vUARTCommands59
; ucPosition end address is: 12 (R3)
; ucCounter end address is: 0 (R0)
L__vUARTCommands275:
L__vUARTCommands274:
;uarthandler.c,277 :: 		break;
IT	AL
BAL	L_vUARTCommands55
;uarthandler.c,278 :: 		}
L_vUARTCommands59:
;uarthandler.c,279 :: 		pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 12 (R3)
ADD	R1, SP, #8
ADDS	R2, R1, R0
LDR	R1, [SP, #60]
ADDS	R1, R1, R3
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
ADDS	R2, R3, #1
UXTB	R2, R2
; ucPosition end address is: 12 (R3)
; ucPosition start address is: 8 (R2)
;uarthandler.c,275 :: 		for( ucCounter = 0; ; ucCounter++ ){
ADDS	R1, R0, #1
UXTB	R1, R1
; ucCounter end address is: 0 (R0)
; ucCounter start address is: 4 (R1)
;uarthandler.c,280 :: 		}
UXTB	R3, R2
; ucPosition end address is: 8 (R2)
; ucCounter end address is: 4 (R1)
UXTB	R0, R1
IT	AL
BAL	L_vUARTCommands54
L_vUARTCommands55:
;uarthandler.c,282 :: 		ucRf4463EnterStandbyMode();
BL	_ucRf4463EnterStandbyMode+0
;uarthandler.c,284 :: 		usTempData = atoi( pcTempBuffer );
ADD	R1, SP, #8
MOV	R0, R1
BL	_atoi+0
;uarthandler.c,285 :: 		vRfSettingsHotSwap( usTempData, usTempData );
UXTH	R1, R0
UXTB	R0, R0
BL	_vRfSettingsHotSwap+0
;uarthandler.c,286 :: 		break;
IT	AL
BAL	L_vUARTCommands15
;uarthandler.c,287 :: 		case UART_CMD_INFO:
L_vUARTCommands60:
;uarthandler.c,288 :: 		STM_LOGD( "[ UART ] Get Device Info\r\n", NULL );
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
;uarthandler.c,308 :: 		ucRemoteNode    = NODE_BROADCAST;
MOVS	R2, #255
MOVW	R1, #lo_addr(_ucRemoteNode+0)
MOVT	R1, #hi_addr(_ucRemoteNode+0)
STRB	R2, [R1, #0]
;uarthandler.c,309 :: 		ucSenderNode    = HUB_NODE_DEFAULT;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucSenderNode+0)
MOVT	R1, #hi_addr(_ucSenderNode+0)
STRB	R2, [R1, #0]
;uarthandler.c,310 :: 		ucTableIndex    = Table_RF_Test;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucTableIndex+0)
MOVT	R1, #hi_addr(_ucTableIndex+0)
STRB	R2, [R1, #0]
;uarthandler.c,311 :: 		ucCommandIndex  = Test_Device_Info;
MOVS	R2, #8
MOVW	R1, #lo_addr(_ucCommandIndex+0)
MOVT	R1, #hi_addr(_ucCommandIndex+0)
STRB	R2, [R1, #0]
;uarthandler.c,313 :: 		vRfTxMessage( NULL, NULL );
MOVS	R1, #0
MOVS	R0, #0
BL	_vRfTxMessage+0
;uarthandler.c,314 :: 		break;
IT	AL
BAL	L_vUARTCommands15
;uarthandler.c,315 :: 		case UART_CMD_SEARCH:
L_vUARTCommands61:
;uarthandler.c,316 :: 		STM_LOGD( "[ UART ] Search\r\n", NULL );
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
;uarthandler.c,317 :: 		ucRemoteNode    = NODE_FACTORY;
MOVS	R2, #254
MOVW	R1, #lo_addr(_ucRemoteNode+0)
MOVT	R1, #hi_addr(_ucRemoteNode+0)
STRB	R2, [R1, #0]
;uarthandler.c,318 :: 		ucSenderNode    = NODE_FACTORY;
MOVS	R2, #254
MOVW	R1, #lo_addr(_ucSenderNode+0)
MOVT	R1, #hi_addr(_ucSenderNode+0)
STRB	R2, [R1, #0]
;uarthandler.c,319 :: 		ucTableIndex    = Table_RF_Test;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucTableIndex+0)
MOVT	R1, #hi_addr(_ucTableIndex+0)
STRB	R2, [R1, #0]
;uarthandler.c,320 :: 		ucCommandIndex  = Test_Dongle_Search;
MOVS	R2, #200
MOVW	R1, #lo_addr(_ucCommandIndex+0)
MOVT	R1, #hi_addr(_ucCommandIndex+0)
STRB	R2, [R1, #0]
;uarthandler.c,321 :: 		vRfTxMessage( NULL, NULL );
MOVS	R1, #0
MOVS	R0, #0
BL	_vRfTxMessage+0
;uarthandler.c,322 :: 		break;
IT	AL
BAL	L_vUARTCommands15
;uarthandler.c,323 :: 		case UART_CMD_OVERRIDE:
L_vUARTCommands62:
;uarthandler.c,324 :: 		STM_LOGD( "[ UART ] Override\r\n", NULL );
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
;uarthandler.c,325 :: 		case UART_CMD_RESET_FTY:
L_vUARTCommands63:
;uarthandler.c,326 :: 		STM_LOGD( "[ UART ] Reset Factory\r\n", NULL );
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
;uarthandler.c,327 :: 		break;
IT	AL
BAL	L_vUARTCommands15
;uarthandler.c,328 :: 		case UART_CMD_OVERRIDE_SET:
L_vUARTCommands64:
;uarthandler.c,329 :: 		STM_LOGD( "[ UART ] Set Override\r\n", NULL );
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
;uarthandler.c,330 :: 		break;
IT	AL
BAL	L_vUARTCommands15
;uarthandler.c,331 :: 		case UART_CMD_DISCOVER:
L_vUARTCommands65:
;uarthandler.c,332 :: 		STM_LOGD( "[ UART ] Discover\r\n", NULL );
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
;uarthandler.c,333 :: 		ucRemoteNode = NODE_BROADCAST;
MOVS	R2, #255
MOVW	R1, #lo_addr(_ucRemoteNode+0)
MOVT	R1, #hi_addr(_ucRemoteNode+0)
STRB	R2, [R1, #0]
;uarthandler.c,334 :: 		ucSenderNode = NODE_FACTORY;
MOVS	R2, #254
MOVW	R1, #lo_addr(_ucSenderNode+0)
MOVT	R1, #hi_addr(_ucSenderNode+0)
STRB	R2, [R1, #0]
;uarthandler.c,335 :: 		ucTableIndex = Table_RF_Setup;
MOVS	R2, #2
MOVW	R1, #lo_addr(_ucTableIndex+0)
MOVT	R1, #hi_addr(_ucTableIndex+0)
STRB	R2, [R1, #0]
;uarthandler.c,336 :: 		ucCommandIndex = Setup_Hard_Discover;
MOVS	R2, #11
MOVW	R1, #lo_addr(_ucCommandIndex+0)
MOVT	R1, #hi_addr(_ucCommandIndex+0)
STRB	R2, [R1, #0]
;uarthandler.c,338 :: 		vRfTxMessage( NULL, NULL );
MOVS	R1, #0
MOVS	R0, #0
BL	_vRfTxMessage+0
;uarthandler.c,339 :: 		case UART_CMD_FIND:
L_vUARTCommands66:
;uarthandler.c,340 :: 		STM_LOGD( "[ UART ] Find in Channel\r\n", NULL );
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
;uarthandler.c,341 :: 		ucRemoteNode = NODE_BROADCAST;
MOVS	R2, #255
MOVW	R1, #lo_addr(_ucRemoteNode+0)
MOVT	R1, #hi_addr(_ucRemoteNode+0)
STRB	R2, [R1, #0]
;uarthandler.c,342 :: 		ucSenderNode = HUB_NODE_DEFAULT;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucSenderNode+0)
MOVT	R1, #hi_addr(_ucSenderNode+0)
STRB	R2, [R1, #0]
;uarthandler.c,343 :: 		ucTableIndex = Table_RF_Test;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucTableIndex+0)
MOVT	R1, #hi_addr(_ucTableIndex+0)
STRB	R2, [R1, #0]
;uarthandler.c,344 :: 		ucCommandIndex = Test_Device_Channel;
MOVS	R2, #6
MOVW	R1, #lo_addr(_ucCommandIndex+0)
MOVT	R1, #hi_addr(_ucCommandIndex+0)
STRB	R2, [R1, #0]
;uarthandler.c,346 :: 		vRfTxMessage( NULL, NULL );
MOVS	R1, #0
MOVS	R0, #0
BL	_vRfTxMessage+0
;uarthandler.c,347 :: 		break;
IT	AL
BAL	L_vUARTCommands15
;uarthandler.c,350 :: 		}
L_vUARTCommands14:
LDRB	R1, [SP, #64]
CMP	R1, #0
IT	EQ
BEQ	L_vUARTCommands16
LDRB	R1, [SP, #64]
CMP	R1, #1
IT	EQ
BEQ	L_vUARTCommands19
LDRB	R1, [SP, #64]
CMP	R1, #2
IT	EQ
BEQ	L_vUARTCommands26
LDRB	R1, [SP, #64]
CMP	R1, #3
IT	EQ
BEQ	L_vUARTCommands33
LDRB	R1, [SP, #64]
CMP	R1, #4
IT	EQ
BEQ	L_vUARTCommands34
LDRB	R1, [SP, #64]
CMP	R1, #5
IT	EQ
BEQ	L_vUARTCommands37
LDRB	R1, [SP, #64]
CMP	R1, #6
IT	EQ
BEQ	L_vUARTCommands38
LDRB	R1, [SP, #64]
CMP	R1, #7
IT	EQ
BEQ	L_vUARTCommands46
LDRB	R1, [SP, #64]
CMP	R1, #8
IT	EQ
BEQ	L_vUARTCommands53
LDRB	R1, [SP, #64]
CMP	R1, #11
IT	EQ
BEQ	L_vUARTCommands60
LDRB	R1, [SP, #64]
CMP	R1, #13
IT	EQ
BEQ	L_vUARTCommands61
LDRB	R1, [SP, #64]
CMP	R1, #14
IT	EQ
BEQ	L_vUARTCommands62
LDRB	R1, [SP, #64]
CMP	R1, #15
IT	EQ
BEQ	L_vUARTCommands63
LDRB	R1, [SP, #64]
CMP	R1, #16
IT	EQ
BEQ	L_vUARTCommands64
LDRB	R1, [SP, #64]
CMP	R1, #17
IT	EQ
BEQ	L_vUARTCommands65
LDRB	R1, [SP, #64]
CMP	R1, #18
IT	EQ
BEQ	L_vUARTCommands66
L_vUARTCommands15:
;uarthandler.c,351 :: 		}
L_vUARTCommands13:
;uarthandler.c,139 :: 		for( ucCommandCounter = 0; ucCommandCounter < UART_Commands; ucCommandCounter++ ){
LDRB	R1, [SP, #64]
ADDS	R1, R1, #1
STRB	R1, [SP, #64]
;uarthandler.c,352 :: 		}
IT	AL
BAL	L_vUARTCommands10
L_vUARTCommands11:
;uarthandler.c,353 :: 		}
L_end_vUARTCommands:
LDR	LR, [SP, #0]
ADD	SP, SP, #68
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
_vASCIIToHex:
;conversion.c,41 :: 		void vASCIIToHex( uint8_t *pcHexConvertBuffer, uint8_t *pcASCIIConvertBuffer, uint8_t ucConversionLength ){
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
;conversion.c,42 :: 		uint8_t ucASCIICounter = 0;
;conversion.c,44 :: 		for( ucASCIICounter = 0; ucASCIICounter < ucConversionLength; ucASCIICounter++ ){
; ucASCIICounter start address is: 24 (R6)
MOVS	R6, #0
; pcHexConvertBuffer end address is: 0 (R0)
; ucConversionLength end address is: 8 (R2)
; ucASCIICounter end address is: 24 (R6)
STRB	R2, [SP, #0]
MOV	R2, R0
LDRB	R0, [SP, #0]
L_vASCIIToHex67:
; ucASCIICounter start address is: 24 (R6)
; pcHexConvertBuffer start address is: 8 (R2)
; ucConversionLength start address is: 0 (R0)
; pcASCIIConvertBuffer start address is: 4 (R1)
; pcASCIIConvertBuffer end address is: 4 (R1)
; pcHexConvertBuffer start address is: 8 (R2)
; pcHexConvertBuffer end address is: 8 (R2)
CMP	R6, R0
IT	CS
BCS	L_vASCIIToHex68
; pcASCIIConvertBuffer end address is: 4 (R1)
; pcHexConvertBuffer end address is: 8 (R2)
;conversion.c,45 :: 		ucMSBNibble = 0;
; pcHexConvertBuffer start address is: 8 (R2)
; pcASCIIConvertBuffer start address is: 4 (R1)
MOVS	R3, #0
MOVW	R5, #lo_addr(_ucMSBNibble+0)
MOVT	R5, #hi_addr(_ucMSBNibble+0)
STRB	R3, [R5, #0]
;conversion.c,46 :: 		ucLSBNibble = 0;
MOVS	R4, #0
MOVW	R3, #lo_addr(_ucLSBNibble+0)
MOVT	R3, #hi_addr(_ucLSBNibble+0)
STRB	R4, [R3, #0]
;conversion.c,48 :: 		ucMSBNibble = ( pcASCIIConvertBuffer[ ucASCIICounter * 2 ] - 0x30 );
LSLS	R3, R6, #1
SXTH	R3, R3
ADDS	R3, R1, R3
LDRB	R3, [R3, #0]
SUBS	R3, #48
STRB	R3, [R5, #0]
;conversion.c,49 :: 		if( ucMSBNibble > 9 ){
UXTB	R3, R3
CMP	R3, #9
IT	LS
BLS	L_vASCIIToHex70
;conversion.c,50 :: 		ucMSBNibble -= 7;
MOVW	R4, #lo_addr(_ucMSBNibble+0)
MOVT	R4, #hi_addr(_ucMSBNibble+0)
LDRB	R3, [R4, #0]
SUBS	R3, R3, #7
STRB	R3, [R4, #0]
;conversion.c,51 :: 		}
L_vASCIIToHex70:
;conversion.c,53 :: 		ucLSBNibble = ( pcASCIIConvertBuffer[ ( ucASCIICounter * 2 ) + 1 ] - 0x30 );
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
;conversion.c,54 :: 		if( ucLSBNibble > 9 ){
UXTB	R3, R4
CMP	R3, #9
IT	LS
BLS	L_vASCIIToHex71
;conversion.c,55 :: 		ucLSBNibble -= 7;
MOVW	R4, #lo_addr(_ucLSBNibble+0)
MOVT	R4, #hi_addr(_ucLSBNibble+0)
LDRB	R3, [R4, #0]
SUBS	R3, R3, #7
STRB	R3, [R4, #0]
;conversion.c,56 :: 		}
L_vASCIIToHex71:
;conversion.c,58 :: 		pcHexConvertBuffer[ ucASCIICounter ] = ( ( ucMSBNibble << 4 ) | ucLSBNibble );
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
;conversion.c,44 :: 		for( ucASCIICounter = 0; ucASCIICounter < ucConversionLength; ucASCIICounter++ ){
ADDS	R6, R6, #1
UXTB	R6, R6
;conversion.c,59 :: 		}
; ucConversionLength end address is: 0 (R0)
; pcASCIIConvertBuffer end address is: 4 (R1)
; pcHexConvertBuffer end address is: 8 (R2)
; ucASCIICounter end address is: 24 (R6)
IT	AL
BAL	L_vASCIIToHex67
L_vASCIIToHex68:
;conversion.c,60 :: 		}
L_end_vASCIIToHex:
ADD	SP, SP, #4
BX	LR
; end of _vASCIIToHex
_vHexToASCII:
;conversion.c,65 :: 		void vHexToASCII( uint8_t *pcASCIIConvertBuffer, uint8_t *pcHexConvertBuffer, uint8_t ucConversionLength ){
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
;conversion.c,66 :: 		uint8_t ucHexConvCounter = 0;
;conversion.c,68 :: 		for( ucHexConvCounter = 0; ucHexConvCounter < ucConversionLength; ucHexConvCounter++ ){
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
L_vHexToASCII72:
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
BCS	L_vHexToASCII73
; pcHexConvertBuffer end address is: 4 (R1)
; pcASCIIConvertBuffer end address is: 8 (R2)
;conversion.c,69 :: 		pcASCIIConvertBuffer[ ucHexConvCounter * 2 ]            = pcHexChar[ pcHexConvertBuffer[ ucHexConvCounter ] >> 4 ];
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
;conversion.c,70 :: 		pcASCIIConvertBuffer[ ( ucHexConvCounter * 2 ) + 1 ]    = pcHexChar[ ( pcHexConvertBuffer[ ucHexConvCounter ] & 0x0F ) ];
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
;conversion.c,68 :: 		for( ucHexConvCounter = 0; ucHexConvCounter < ucConversionLength; ucHexConvCounter++ ){
ADDS	R6, R6, #1
UXTB	R6, R6
;conversion.c,71 :: 		}
; ucConversionLength end address is: 0 (R0)
; pcHexConvertBuffer end address is: 4 (R1)
; pcASCIIConvertBuffer end address is: 8 (R2)
; ucHexConvCounter end address is: 24 (R6)
IT	AL
BAL	L_vHexToASCII72
L_vHexToASCII73:
;conversion.c,72 :: 		}
L_end_vHexToASCII:
ADD	SP, SP, #4
BX	LR
; end of _vHexToASCII
_vSerializeUUID:
;conversion.c,77 :: 		void vSerializeUUID( uint8_t * pcTextConvertBuffer, uint8_t * pcHexConvertBuffer ){
; pcHexConvertBuffer start address is: 4 (R1)
; pcTextConvertBuffer start address is: 0 (R0)
SUB	SP, SP, #4
; pcHexConvertBuffer end address is: 4 (R1)
; pcTextConvertBuffer end address is: 0 (R0)
; pcTextConvertBuffer start address is: 0 (R0)
; pcHexConvertBuffer start address is: 4 (R1)
;conversion.c,78 :: 		uint8_t ucCounter = 0;
;conversion.c,80 :: 		for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
; ucCounter start address is: 20 (R5)
MOVS	R5, #0
; pcTextConvertBuffer end address is: 0 (R0)
; pcHexConvertBuffer end address is: 4 (R1)
; ucCounter end address is: 20 (R5)
STR	R1, [SP, #0]
MOV	R1, R0
LDR	R0, [SP, #0]
L_vSerializeUUID75:
; ucCounter start address is: 20 (R5)
; pcTextConvertBuffer start address is: 4 (R1)
; pcHexConvertBuffer start address is: 0 (R0)
; pcHexConvertBuffer start address is: 0 (R0)
; pcHexConvertBuffer end address is: 0 (R0)
; pcTextConvertBuffer start address is: 4 (R1)
; pcTextConvertBuffer end address is: 4 (R1)
CMP	R5, #12
IT	CS
BCS	L_vSerializeUUID76
; pcHexConvertBuffer end address is: 0 (R0)
; pcTextConvertBuffer end address is: 4 (R1)
;conversion.c,81 :: 		pcTextConvertBuffer[ ucCounter * 2 ]         = pcHexChar[ pcHexConvertBuffer[ ucCounter ] >> 4 ];
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
;conversion.c,82 :: 		pcTextConvertBuffer[ ( ucCounter * 2 ) + 1 ] = pcHexChar[ pcHexConvertBuffer[ ucCounter ] & 0x0F ];
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
;conversion.c,80 :: 		for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
ADDS	R5, R5, #1
UXTB	R5, R5
;conversion.c,83 :: 		}
; pcHexConvertBuffer end address is: 0 (R0)
; pcTextConvertBuffer end address is: 4 (R1)
; ucCounter end address is: 20 (R5)
IT	AL
BAL	L_vSerializeUUID75
L_vSerializeUUID76:
;conversion.c,84 :: 		}
L_end_vSerializeUUID:
ADD	SP, SP, #4
BX	LR
; end of _vSerializeUUID
_vSerializeMACAddress:
;conversion.c,89 :: 		void vSerializeMACAddress( uint8_t * pcTextConvertBuffer, uint8_t * pcHexConvertBuffer ){
; pcHexConvertBuffer start address is: 4 (R1)
; pcTextConvertBuffer start address is: 0 (R0)
SUB	SP, SP, #16
STR	LR, [SP, #0]
MOV	R7, R0
; pcHexConvertBuffer end address is: 4 (R1)
; pcTextConvertBuffer end address is: 0 (R0)
; pcTextConvertBuffer start address is: 28 (R7)
; pcHexConvertBuffer start address is: 4 (R1)
;conversion.c,90 :: 		uint16_t usCounter = 0;
;conversion.c,93 :: 		vHexToASCII( pcDeviceMAC, pcHexConvertBuffer, 6 );
ADD	R2, SP, #4
MOV	R0, R2
; pcHexConvertBuffer end address is: 4 (R1)
MOVS	R2, #6
BL	_vHexToASCII+0
;conversion.c,95 :: 		for( usCounter = 0; usCounter < 6; usCounter++ ){
; usCounter start address is: 4 (R1)
MOVS	R1, #0
; pcTextConvertBuffer end address is: 28 (R7)
; usCounter end address is: 4 (R1)
MOV	R0, R7
L_vSerializeMACAddress78:
; usCounter start address is: 4 (R1)
; pcTextConvertBuffer start address is: 0 (R0)
CMP	R1, #6
IT	CS
BCS	L_vSerializeMACAddress79
;conversion.c,96 :: 		pcTextConvertBuffer[ usCounter * 3 ]         = pcDeviceMAC[ usCounter * 2 ];
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
;conversion.c,97 :: 		pcTextConvertBuffer[ ( usCounter * 3 ) + 1 ] = pcDeviceMAC[ ( usCounter * 2 ) + 1 ];
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
;conversion.c,98 :: 		if( usCounter != 5 ){
CMP	R1, #5
IT	EQ
BEQ	L_vSerializeMACAddress81
;conversion.c,99 :: 		pcTextConvertBuffer[ ( usCounter * 3 ) + 2 ] = ':';
MOVS	R2, #3
MULS	R2, R1, R2
UXTH	R2, R2
ADDS	R2, R2, #2
UXTH	R2, R2
ADDS	R3, R0, R2
MOVS	R2, #58
STRB	R2, [R3, #0]
;conversion.c,100 :: 		}
L_vSerializeMACAddress81:
;conversion.c,95 :: 		for( usCounter = 0; usCounter < 6; usCounter++ ){
ADDS	R1, R1, #1
UXTH	R1, R1
;conversion.c,101 :: 		}
; usCounter end address is: 4 (R1)
IT	AL
BAL	L_vSerializeMACAddress78
L_vSerializeMACAddress79:
;conversion.c,102 :: 		pcTextConvertBuffer[ 18 ] = '\0';
ADDW	R3, R0, #18
; pcTextConvertBuffer end address is: 0 (R0)
MOVS	R2, #0
STRB	R2, [R3, #0]
;conversion.c,103 :: 		}
L_end_vSerializeMACAddress:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _vSerializeMACAddress
_vSerializeIPAddress:
;conversion.c,108 :: 		void vSerializeIPAddress( uint8_t * pcTextConvertBuffer, uint8_t * pcHexConvertBuffer ){
; pcHexConvertBuffer start address is: 4 (R1)
; pcTextConvertBuffer start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
MOV	R8, R0
MOV	R6, R1
; pcHexConvertBuffer end address is: 4 (R1)
; pcTextConvertBuffer end address is: 0 (R0)
; pcTextConvertBuffer start address is: 32 (R8)
; pcHexConvertBuffer start address is: 24 (R6)
;conversion.c,109 :: 		uint8_t ucCounter = 0;
;conversion.c,112 :: 		memset( pcTextConvertBuffer, '\0', sizeof( pcTextConvertBuffer ) );
MOVS	R2, #4
SXTH	R2, R2
MOVS	R1, #0
MOV	R0, R8
BL	_memset+0
;conversion.c,114 :: 		for( ucCounter = 0; ucCounter < 4; ucCounter++ ){
; ucCounter start address is: 28 (R7)
MOVS	R7, #0
; ucCounter end address is: 28 (R7)
L_vSerializeIPAddress82:
; ucCounter start address is: 28 (R7)
; pcHexConvertBuffer start address is: 24 (R6)
; pcHexConvertBuffer end address is: 24 (R6)
; pcTextConvertBuffer start address is: 32 (R8)
; pcTextConvertBuffer end address is: 32 (R8)
CMP	R7, #4
IT	CS
BCS	L_vSerializeIPAddress83
; pcHexConvertBuffer end address is: 24 (R6)
; pcTextConvertBuffer end address is: 32 (R8)
;conversion.c,116 :: 		ByteToStr( pcHexConvertBuffer[ ucCounter ], pcConvertText );
; pcTextConvertBuffer start address is: 32 (R8)
; pcHexConvertBuffer start address is: 24 (R6)
ADD	R3, SP, #4
ADDS	R2, R6, R7
LDRB	R2, [R2, #0]
MOV	R1, R3
UXTB	R0, R2
BL	_ByteToStr+0
;conversion.c,118 :: 		strcat( pcTextConvertBuffer, Ltrim( pcConvertText ) );
ADD	R2, SP, #4
MOV	R0, R2
BL	_Ltrim+0
MOV	R1, R0
MOV	R0, R8
BL	_strcat+0
;conversion.c,120 :: 		if( ucCounter != 3 ){
CMP	R7, #3
IT	EQ
BEQ	L_vSerializeIPAddress85
;conversion.c,121 :: 		strcat( pcTextConvertBuffer, "." );
MOVW	R2, #lo_addr(?lstr48_main+0)
MOVT	R2, #hi_addr(?lstr48_main+0)
MOV	R1, R2
MOV	R0, R8
BL	_strcat+0
;conversion.c,122 :: 		}
L_vSerializeIPAddress85:
;conversion.c,114 :: 		for( ucCounter = 0; ucCounter < 4; ucCounter++ ){
ADDS	R7, R7, #1
UXTB	R7, R7
;conversion.c,123 :: 		}
; pcHexConvertBuffer end address is: 24 (R6)
; pcTextConvertBuffer end address is: 32 (R8)
; ucCounter end address is: 28 (R7)
IT	AL
BAL	L_vSerializeIPAddress82
L_vSerializeIPAddress83:
;conversion.c,124 :: 		}
L_end_vSerializeIPAddress:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
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
L_vXORRFMessage86:
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
BCS	L_vXORRFMessage87
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
BAL	L_vXORRFMessage86
L_vXORRFMessage87:
;xorcipher.c,56 :: 		}
L_end_vXORRFMessage:
ADD	SP, SP, #4
BX	LR
; end of _vXORRFMessage
_vFlashInit:
;flashhandler.c,41 :: 		void vFlashInit(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;flashhandler.c,43 :: 		_SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI1_PA567 );
MOVW	R2, #lo_addr(__GPIO_MODULE_SPI1_PA567+0)
MOVT	R2, #hi_addr(__GPIO_MODULE_SPI1_PA567+0)
MOVW	R1, #772
;flashhandler.c,42 :: 		SPI1_Init_Advanced( _SPI_FPCLK_DIV2, _SPI_MASTER | _SPI_8_BIT | _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION | _SPI_MSB_FIRST |
MOVS	R0, #0
;flashhandler.c,43 :: 		_SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI1_PA567 );
BL	_SPI1_Init_Advanced+0
;flashhandler.c,45 :: 		GPIO_Digital_Output( &GPIOA_BASE, _GPIO_PINMASK_4 );
MOVW	R1, #16
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
;flashhandler.c,47 :: 		UART1_Write_Text( "[ FLASH ] Start\r\n" );
MOVW	R0, #lo_addr(?lstr49_main+0)
MOVT	R0, #hi_addr(?lstr49_main+0)
BL	_UART1_Write_Text+0
;flashhandler.c,49 :: 		vW25Q128JVInit();
BL	_vW25Q128JVInit+0
;flashhandler.c,50 :: 		vFlashWriteEnable( Select_Flash_1 );
MOVS	R0, #1
BL	_vFlashWriteEnable+0
;flashhandler.c,51 :: 		Delay_ms( 50 );
MOVW	R7, #10175
MOVT	R7, #9
NOP
NOP
L_vFlashInit89:
SUBS	R7, R7, #1
BNE	L_vFlashInit89
NOP
NOP
NOP
;flashhandler.c,52 :: 		vFlashTest();
BL	_vFlashTest+0
;flashhandler.c,53 :: 		}
L_end_vFlashInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vFlashInit
_vFlashTest:
;flashhandler.c,58 :: 		void vFlashTest(){
SUB	SP, SP, #12
STR	LR, [SP, #0]
;flashhandler.c,64 :: 		uint8_t TempData = 0;
;flashhandler.c,65 :: 		uint8_t FlashID = 0;
;flashhandler.c,67 :: 		uint8_t ucTempValue = 0;
;flashhandler.c,68 :: 		uint16_t usFlashCounter = 0;
;flashhandler.c,69 :: 		uint32_t ulFlashAddress = 0;
;flashhandler.c,71 :: 		UART1_Write_Text( "[ FLASH ] Test\r\n" );
MOVW	R0, #lo_addr(?lstr50_main+0)
MOVT	R0, #hi_addr(?lstr50_main+0)
BL	_UART1_Write_Text+0
;flashhandler.c,73 :: 		UART1_Write_Text( "[ FLASH ] Bank 1 ID: " );
MOVW	R0, #lo_addr(?lstr51_main+0)
MOVT	R0, #hi_addr(?lstr51_main+0)
BL	_UART1_Write_Text+0
;flashhandler.c,74 :: 		FlashID = ucFlashReadId( Select_Flash_1 );
MOVS	R0, #1
BL	_ucFlashReadId+0
;flashhandler.c,75 :: 		ByteToStr( FlashID, ucTempText );
ADD	R1, SP, #4
BL	_ByteToStr+0
;flashhandler.c,76 :: 		UART1_Write_Text( ucTempText );
ADD	R0, SP, #4
BL	_UART1_Write_Text+0
;flashhandler.c,77 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;flashhandler.c,78 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;flashhandler.c,84 :: 		UART1_Write_Text( "[ FLASH ] ------------------------------------------ Bank 1 Test Start ------------------------------------------\r\n" );
MOVW	R0, #lo_addr(?lstr52_main+0)
MOVT	R0, #hi_addr(?lstr52_main+0)
BL	_UART1_Write_Text+0
;flashhandler.c,86 :: 		vFlashSectorErase( Select_Flash_1, TEST_BLOCK_ADDRESS );
MOVW	R1, #4096
MOVT	R1, #255
MOVS	R0, #1
BL	_vFlashSectorErase+0
;flashhandler.c,88 :: 		ulFlashAddress = TEST_BLOCK_ADDRESS;
; ulFlashAddress start address is: 20 (R5)
MOVW	R5, #4096
MOVT	R5, #255
;flashhandler.c,89 :: 		for( usFlashCounter = 0; usFlashCounter < 50; usFlashCounter++ ){
; usFlashCounter start address is: 16 (R4)
MOVS	R4, #0
; ulFlashAddress end address is: 20 (R5)
; usFlashCounter end address is: 16 (R4)
L_vFlashTest91:
; usFlashCounter start address is: 16 (R4)
; ulFlashAddress start address is: 20 (R5)
CMP	R4, #50
IT	CS
BCS	L_vFlashTest92
;flashhandler.c,90 :: 		UART1_Write( ucFlashReadByte( Select_Flash_1, ulFlashAddress++ ) );
MOV	R1, R5
MOVS	R0, #1
BL	_ucFlashReadByte+0
BL	_UART1_Write+0
ADDS	R5, R5, #1
;flashhandler.c,89 :: 		for( usFlashCounter = 0; usFlashCounter < 50; usFlashCounter++ ){
ADDS	R4, R4, #1
UXTH	R4, R4
;flashhandler.c,91 :: 		}
; ulFlashAddress end address is: 20 (R5)
; usFlashCounter end address is: 16 (R4)
IT	AL
BAL	L_vFlashTest91
L_vFlashTest92:
;flashhandler.c,92 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;flashhandler.c,93 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;flashhandler.c,95 :: 		ulFlashAddress = TEST_BLOCK_ADDRESS;
; ulFlashAddress start address is: 32 (R8)
MOVW	R8, #4096
MOVT	R8, #255
;flashhandler.c,96 :: 		for( usFlashCounter = 0; usFlashCounter < 40; usFlashCounter++ ){
; usFlashCounter start address is: 28 (R7)
MOVS	R7, #0
; ulFlashAddress end address is: 32 (R8)
; usFlashCounter end address is: 28 (R7)
L_vFlashTest94:
; usFlashCounter start address is: 28 (R7)
; ulFlashAddress start address is: 32 (R8)
CMP	R7, #40
IT	CS
BCS	L_vFlashTest95
;flashhandler.c,97 :: 		vFlashWriteByte( Select_Flash_1, pcStringTest[ usFlashCounter ], ulFlashAddress++ );
MOVW	R0, #lo_addr(vFlashTest_pcStringTest_L0+0)
MOVT	R0, #hi_addr(vFlashTest_pcStringTest_L0+0)
ADDS	R0, R0, R7
LDRB	R0, [R0, #0]
MOV	R2, R8
UXTB	R1, R0
MOVS	R0, #1
BL	_vFlashWriteByte+0
ADD	R8, R8, #1
;flashhandler.c,96 :: 		for( usFlashCounter = 0; usFlashCounter < 40; usFlashCounter++ ){
ADDS	R7, R7, #1
UXTH	R7, R7
;flashhandler.c,98 :: 		}
; ulFlashAddress end address is: 32 (R8)
; usFlashCounter end address is: 28 (R7)
IT	AL
BAL	L_vFlashTest94
L_vFlashTest95:
;flashhandler.c,100 :: 		ulFlashAddress = TEST_BLOCK_ADDRESS;
; ulFlashAddress start address is: 20 (R5)
MOVW	R5, #4096
MOVT	R5, #255
;flashhandler.c,101 :: 		for( usFlashCounter = 0; usFlashCounter < 50; usFlashCounter++ ){
; usFlashCounter start address is: 16 (R4)
MOVS	R4, #0
; ulFlashAddress end address is: 20 (R5)
; usFlashCounter end address is: 16 (R4)
L_vFlashTest97:
; usFlashCounter start address is: 16 (R4)
; ulFlashAddress start address is: 20 (R5)
CMP	R4, #50
IT	CS
BCS	L_vFlashTest98
;flashhandler.c,102 :: 		UART1_Write( ucFlashReadByte( Select_Flash_1, ulFlashAddress++ ) );
MOV	R1, R5
MOVS	R0, #1
BL	_ucFlashReadByte+0
BL	_UART1_Write+0
ADDS	R5, R5, #1
;flashhandler.c,101 :: 		for( usFlashCounter = 0; usFlashCounter < 50; usFlashCounter++ ){
ADDS	R4, R4, #1
UXTH	R4, R4
;flashhandler.c,103 :: 		}
; ulFlashAddress end address is: 20 (R5)
; usFlashCounter end address is: 16 (R4)
IT	AL
BAL	L_vFlashTest97
L_vFlashTest98:
;flashhandler.c,104 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;flashhandler.c,105 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;flashhandler.c,107 :: 		vFlashSectorErase( Select_Flash_1, TEST_BLOCK_ADDRESS );
MOVW	R1, #4096
MOVT	R1, #255
MOVS	R0, #1
BL	_vFlashSectorErase+0
;flashhandler.c,109 :: 		ulFlashAddress = TEST_BLOCK_ADDRESS;
; ulFlashAddress start address is: 20 (R5)
MOVW	R5, #4096
MOVT	R5, #255
;flashhandler.c,110 :: 		for( usFlashCounter = 0; usFlashCounter < 50; usFlashCounter++ ){
; usFlashCounter start address is: 16 (R4)
MOVS	R4, #0
; ulFlashAddress end address is: 20 (R5)
; usFlashCounter end address is: 16 (R4)
L_vFlashTest100:
; usFlashCounter start address is: 16 (R4)
; ulFlashAddress start address is: 20 (R5)
CMP	R4, #50
IT	CS
BCS	L_vFlashTest101
;flashhandler.c,111 :: 		UART1_Write( ucFlashReadByte( Select_Flash_1, ulFlashAddress++ ) );
MOV	R1, R5
MOVS	R0, #1
BL	_ucFlashReadByte+0
BL	_UART1_Write+0
ADDS	R5, R5, #1
;flashhandler.c,110 :: 		for( usFlashCounter = 0; usFlashCounter < 50; usFlashCounter++ ){
ADDS	R4, R4, #1
UXTH	R4, R4
;flashhandler.c,112 :: 		}
; ulFlashAddress end address is: 20 (R5)
; usFlashCounter end address is: 16 (R4)
IT	AL
BAL	L_vFlashTest100
L_vFlashTest101:
;flashhandler.c,113 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;flashhandler.c,114 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;flashhandler.c,116 :: 		ulFlashAddress = TEST_BLOCK_ADDRESS;
; ulFlashAddress start address is: 32 (R8)
MOVW	R8, #4096
MOVT	R8, #255
;flashhandler.c,117 :: 		for( usFlashCounter = 0; usFlashCounter < 40; usFlashCounter++ ){
; usFlashCounter start address is: 28 (R7)
MOVS	R7, #0
; ulFlashAddress end address is: 32 (R8)
; usFlashCounter end address is: 28 (R7)
L_vFlashTest103:
; usFlashCounter start address is: 28 (R7)
; ulFlashAddress start address is: 32 (R8)
CMP	R7, #40
IT	CS
BCS	L_vFlashTest104
;flashhandler.c,118 :: 		vFlashWriteByte( Select_Flash_1, pcCompareTest[ usFlashCounter ], ulFlashAddress++ );
MOVW	R0, #lo_addr(vFlashTest_pcCompareTest_L0+0)
MOVT	R0, #hi_addr(vFlashTest_pcCompareTest_L0+0)
ADDS	R0, R0, R7
LDRB	R0, [R0, #0]
MOV	R2, R8
UXTB	R1, R0
MOVS	R0, #1
BL	_vFlashWriteByte+0
ADD	R8, R8, #1
;flashhandler.c,117 :: 		for( usFlashCounter = 0; usFlashCounter < 40; usFlashCounter++ ){
ADDS	R7, R7, #1
UXTH	R7, R7
;flashhandler.c,119 :: 		}
; ulFlashAddress end address is: 32 (R8)
; usFlashCounter end address is: 28 (R7)
IT	AL
BAL	L_vFlashTest103
L_vFlashTest104:
;flashhandler.c,121 :: 		ulFlashAddress = TEST_BLOCK_ADDRESS;
; ulFlashAddress start address is: 20 (R5)
MOVW	R5, #4096
MOVT	R5, #255
;flashhandler.c,122 :: 		for( usFlashCounter = 0; usFlashCounter < 50; usFlashCounter++ ){
; usFlashCounter start address is: 16 (R4)
MOVS	R4, #0
; ulFlashAddress end address is: 20 (R5)
; usFlashCounter end address is: 16 (R4)
L_vFlashTest106:
; usFlashCounter start address is: 16 (R4)
; ulFlashAddress start address is: 20 (R5)
CMP	R4, #50
IT	CS
BCS	L_vFlashTest107
;flashhandler.c,123 :: 		UART1_Write( ucFlashReadByte( Select_Flash_1, ulFlashAddress++ ) );
MOV	R1, R5
MOVS	R0, #1
BL	_ucFlashReadByte+0
BL	_UART1_Write+0
ADDS	R5, R5, #1
;flashhandler.c,122 :: 		for( usFlashCounter = 0; usFlashCounter < 50; usFlashCounter++ ){
ADDS	R4, R4, #1
UXTH	R4, R4
;flashhandler.c,124 :: 		}
; ulFlashAddress end address is: 20 (R5)
; usFlashCounter end address is: 16 (R4)
IT	AL
BAL	L_vFlashTest106
L_vFlashTest107:
;flashhandler.c,125 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;flashhandler.c,126 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;flashhandler.c,127 :: 		UART1_Write_Text( "[ FLASH ] ------------------------------------------ Bank 1 Test Done ------------------------------------------\r\n" );
MOVW	R0, #lo_addr(?lstr53_main+0)
MOVT	R0, #hi_addr(?lstr53_main+0)
BL	_UART1_Write_Text+0
;flashhandler.c,130 :: 		}
L_end_vFlashTest:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vFlashTest
_vW25Q128JVInit:
;flashw25q128jv.c,43 :: 		void vW25Q128JVInit( ){
SUB	SP, SP, #4
;flashw25q128jv.c,44 :: 		FlashCS = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
_SX	[R0, ByteOffset(GPIOA_ODR+0)]
;flashw25q128jv.c,45 :: 		}
L_end_vW25Q128JVInit:
ADD	SP, SP, #4
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
L_vFlashWriteByte109:
; ucMemorySelected start address is: 16 (R4)
UXTB	R0, R4
BL	_ucFlashIsWriteBusy+0
CMP	R0, #0
IT	EQ
BEQ	L_vFlashWriteByte110
; ucMemorySelected end address is: 16 (R4)
IT	AL
BAL	L_vFlashWriteByte109
L_vFlashWriteByte110:
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
L_ucFlashWriteArray111:
; usBufferCounter start address is: 44 (R11)
; ulFlashAddress start address is: 48 (R12)
; ulMemoryAddress start address is: 40 (R10)
; usBufferLength start address is: 28 (R7)
; pcData start address is: 32 (R8)
; ucMemorySelected start address is: 36 (R9)
CMP	R11, R7
IT	CS
BCS	L_ucFlashWriteArray112
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
BAL	L_ucFlashWriteArray111
L_ucFlashWriteArray112:
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
L_ucFlashWriteArray114:
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
BCS	L_ucFlashWriteArray115
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
BEQ	L_ucFlashWriteArray117
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
L_ucFlashWriteArray117:
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
BAL	L_ucFlashWriteArray114
L_ucFlashWriteArray115:
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
L_vFlashReadArray118:
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
BEQ	L_vFlashReadArray119
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
BAL	L_vFlashReadArray118
L_vFlashReadArray119:
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
L_vFlashChipErase120:
; ucMemorySelected start address is: 16 (R4)
UXTB	R0, R4
BL	_ucFlashIsWriteBusy+0
CMP	R0, #0
IT	EQ
BEQ	L_vFlashChipErase121
; ucMemorySelected end address is: 16 (R4)
IT	AL
BAL	L_vFlashChipErase120
L_vFlashChipErase121:
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
L_vFlashSectorErase122:
; ucMemorySelected start address is: 16 (R4)
UXTB	R0, R4
BL	_ucFlashIsWriteBusy+0
CMP	R0, #0
IT	EQ
BEQ	L_vFlashSectorErase123
; ucMemorySelected end address is: 16 (R4)
IT	AL
BAL	L_vFlashSectorErase122
L_vFlashSectorErase123:
;flashw25q128jv.c,236 :: 		}
L_end_vFlashSectorErase:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vFlashSectorErase
_RFISR:
;rf4463handler.c,38 :: 		void RFISR() iv IVT_INT_EXTI15_10 ics ICS_AUTO{
SUB	SP, SP, #4
STR	LR, [SP, #0]
;rf4463handler.c,39 :: 		if( EXTI_PR.B12 ){
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_LX	[R0, ByteOffset(EXTI_PR+0)]
CMP	R0, #0
IT	EQ
BEQ	L_RFISR124
;rf4463handler.c,40 :: 		EXTI_PR.B12 |= 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_SX	[R0, ByteOffset(EXTI_PR+0)]
;rf4463handler.c,41 :: 		LEDRed = On;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;rf4463handler.c,42 :: 		ucRadioEvent = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRadioEvent+0)
MOVT	R0, #hi_addr(_ucRadioEvent+0)
STRB	R1, [R0, #0]
;rf4463handler.c,43 :: 		ucRf4463ClearInterrupts();
BL	_ucRf4463ClearInterrupts+0
;rf4463handler.c,46 :: 		}
L_RFISR124:
;rf4463handler.c,47 :: 		}
L_end_RFISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _RFISR
_vRadioInit:
;rf4463handler.c,55 :: 		void vRadioInit(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;rf4463handler.c,62 :: 		_SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI2_PB13_14_15 );
MOVW	R2, #lo_addr(__GPIO_MODULE_SPI2_PB13_14_15+0)
MOVT	R2, #hi_addr(__GPIO_MODULE_SPI2_PB13_14_15+0)
MOVW	R1, #772
;rf4463handler.c,61 :: 		SPI2_Init_Advanced( _SPI_FPCLK_DIV16, _SPI_MASTER | _SPI_8_BIT | _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION | _SPI_MSB_FIRST |
MOVS	R0, #3
;rf4463handler.c,62 :: 		_SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI2_PB13_14_15 );
BL	_SPI2_Init_Advanced+0
;rf4463handler.c,67 :: 		GPIO_Digital_Input( &GPIOC_BASE, _GPIO_PINMASK_12 );
MOVW	R1, #4096
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Input+0
;rf4463handler.c,69 :: 		GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_12 );
MOVW	R1, #4096
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;rf4463handler.c,70 :: 		GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_11 );
MOVW	R1, #2048
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;rf4463handler.c,71 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_11 );
MOVW	R1, #2048
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;rf4463handler.c,72 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_10 );
MOVW	R1, #1024
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;rf4463handler.c,76 :: 		vInitRF4463IRQ();
BL	_vInitRF4463IRQ+0
;rf4463handler.c,81 :: 		xRadioParameters.Channel    = CHANNEL_DEFAULT;
MOVS	R1, #5
MOVW	R0, #lo_addr(_xRadioParameters+2)
MOVT	R0, #hi_addr(_xRadioParameters+2)
STRB	R1, [R0, #0]
;rf4463handler.c,82 :: 		xRadioParameters.Network    = NETWORK_DEFAULT;
MOVS	R1, #5
MOVW	R0, #lo_addr(_xRadioParameters+6)
MOVT	R0, #hi_addr(_xRadioParameters+6)
STRH	R1, [R0, #0]
;rf4463handler.c,83 :: 		xRadioParameters.TxPower    = TX_POWER_DEFAULT;
MOVS	R1, #127
MOVW	R0, #lo_addr(_xRadioParameters+3)
MOVT	R0, #hi_addr(_xRadioParameters+3)
STRB	R1, [R0, #0]
;rf4463handler.c,85 :: 		ucInitRF4463Config();
BL	_ucInitRF4463Config+0
;rf4463handler.c,89 :: 		STM_LOGV( "[ RF4463 ] Parameters\r\n", NULL );
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
;rf4463handler.c,90 :: 		STM_LOGV( "[ RF4463 ] Node: %d\r\n",    xRadioParameters.Node );
MOVW	R0, #lo_addr(_xRadioParameters+0)
MOVT	R0, #hi_addr(_xRadioParameters+0)
LDRB	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_55_main+0)
MOVT	R1, #hi_addr(?lstr_55_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,91 :: 		STM_LOGV( "[ RF4463 ] Channel: %d\r\n", xRadioParameters.Channel );
MOVW	R0, #lo_addr(_xRadioParameters+2)
MOVT	R0, #hi_addr(_xRadioParameters+2)
LDRB	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_56_main+0)
MOVT	R1, #hi_addr(?lstr_56_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,92 :: 		STM_LOGV( "[ RF4463 ] Network: %d\r\n", xRadioParameters.Network );
MOVW	R0, #lo_addr(_xRadioParameters+6)
MOVT	R0, #hi_addr(_xRadioParameters+6)
LDRH	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_57_main+0)
MOVT	R1, #hi_addr(?lstr_57_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,93 :: 		STM_LOGV( "[ RF4463 ] Tx Power: %d\r\n", xRadioParameters.TxPower );
MOVW	R0, #lo_addr(_xRadioParameters+3)
MOVT	R0, #hi_addr(_xRadioParameters+3)
LDRB	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_58_main+0)
MOVT	R1, #hi_addr(?lstr_58_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,94 :: 		}
L_end_vRadioInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vRadioInit
_vInitRF4463IRQ:
;rf4463handler.c,99 :: 		void vInitRF4463IRQ(){
SUB	SP, SP, #4
;rf4463handler.c,103 :: 		RCC_APB2ENRbits.AFIOEN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB2ENRbits+0)
MOVT	R0, #hi_addr(RCC_APB2ENRbits+0)
_SX	[R0, ByteOffset(RCC_APB2ENRbits+0)]
;rf4463handler.c,107 :: 		AFIO_EXTICR4  |= 0x0002;
MOVW	R0, #lo_addr(AFIO_EXTICR4+0)
MOVT	R0, #hi_addr(AFIO_EXTICR4+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #2
MOVW	R0, #lo_addr(AFIO_EXTICR4+0)
MOVT	R0, #hi_addr(AFIO_EXTICR4+0)
STR	R1, [R0, #0]
;rf4463handler.c,111 :: 		EXTI_IMR.B12    |= 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
_SX	[R0, ByteOffset(EXTI_IMR+0)]
;rf4463handler.c,112 :: 		EXTI_FTSR.B12   |= 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
_SX	[R0, ByteOffset(EXTI_FTSR+0)]
;rf4463handler.c,113 :: 		}
L_end_vInitRF4463IRQ:
ADD	SP, SP, #4
BX	LR
; end of _vInitRF4463IRQ
_ucInitRF4463Config:
;rf4463handler.c,118 :: 		uint8_t ucInitRF4463Config(){
SUB	SP, SP, #8
STR	LR, [SP, #0]
;rf4463handler.c,119 :: 		uint8_t ucRetriesRf     = 0;
;rf4463handler.c,120 :: 		uint8_t ucIsRFAvailable = NOT_SUCCESS;
;rf4463handler.c,122 :: 		STM_LOGD( "[ RF4463 ] Configure\r\n", NULL );
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_59_main+0)
MOVT	R1, #hi_addr(?lstr_59_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,124 :: 		ucRf4463Init();
BL	_ucRf4463Init+0
;rf4463handler.c,125 :: 		ucRf4463Init();
BL	_ucRf4463Init+0
;rf4463handler.c,127 :: 		STM_LOGV( "[ RF4463 ] Configure Done\r\n", NULL );
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_60_main+0)
MOVT	R1, #hi_addr(?lstr_60_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,129 :: 		for( ucRetriesRf = 0; ucRetriesRf < 5; ucRetriesRf++ ){
; ucRetriesRf start address is: 12 (R3)
MOVS	R3, #0
; ucRetriesRf end address is: 12 (R3)
L_ucInitRF4463Config125:
; ucRetriesRf start address is: 12 (R3)
CMP	R3, #5
IT	CS
BCS	L_ucInitRF4463Config126
;rf4463handler.c,130 :: 		if( ucRf4463DeviceAvailability() == SUCCESS ){
STRB	R3, [SP, #4]
BL	_ucRf4463DeviceAvailability+0
LDRB	R3, [SP, #4]
CMP	R0, #0
IT	NE
BNE	L_ucInitRF4463Config128
; ucRetriesRf end address is: 12 (R3)
;rf4463handler.c,131 :: 		STM_LOGD( "[ RF4463 ] Init Done\r\n", NULL );
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_61_main+0)
MOVT	R1, #hi_addr(?lstr_61_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,132 :: 		break;
IT	AL
BAL	L_ucInitRF4463Config126
;rf4463handler.c,133 :: 		}
L_ucInitRF4463Config128:
;rf4463handler.c,134 :: 		Delay_ms( 10 );
; ucRetriesRf start address is: 12 (R3)
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_ucInitRF4463Config129:
SUBS	R7, R7, #1
BNE	L_ucInitRF4463Config129
NOP
NOP
NOP
;rf4463handler.c,135 :: 		STM_LOGV( "[ RF4463 ] Try: %d\r\n", ucRetriesRf );
UXTB	R2, R3
MOVW	R1, #lo_addr(?lstr_62_main+0)
MOVT	R1, #hi_addr(?lstr_62_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
STRB	R3, [SP, #4]
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
LDRB	R3, [SP, #4]
;rf4463handler.c,129 :: 		for( ucRetriesRf = 0; ucRetriesRf < 5; ucRetriesRf++ ){
ADDS	R3, R3, #1
UXTB	R3, R3
;rf4463handler.c,136 :: 		}
; ucRetriesRf end address is: 12 (R3)
IT	AL
BAL	L_ucInitRF4463Config125
L_ucInitRF4463Config126:
;rf4463handler.c,140 :: 		STM_LOGV( "[ RF4463 ] Wait for Standby\r\n", NULL );
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_63_main+0)
MOVT	R1, #hi_addr(?lstr_63_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,142 :: 		while( ucRf4463EnterStandbyMode() == NOT_SUCCESS );
L_ucInitRF4463Config131:
BL	_ucRf4463EnterStandbyMode+0
CMP	R0, #1
IT	NE
BNE	L_ucInitRF4463Config132
IT	AL
BAL	L_ucInitRF4463Config131
L_ucInitRF4463Config132:
;rf4463handler.c,144 :: 		STM_LOGV( "[ RF4463 ] Standby\r\n", NULL );
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_64_main+0)
MOVT	R1, #hi_addr(?lstr_64_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463handler.c,146 :: 		return SUCCESS;
MOVS	R0, #0
;rf4463handler.c,147 :: 		}
L_end_ucInitRF4463Config:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucInitRF4463Config
_vRFRxMessage:
;rf4463handler.c,152 :: 		void vRFRxMessage(){
SUB	SP, SP, #144
STR	LR, [SP, #0]
;rf4463handler.c,153 :: 		uint16_t usCounter = 0;
;rf4463handler.c,155 :: 		uint8_t ucPosition = 0;
; ucPosition start address is: 36 (R9)
MOVW	R9, #0
;rf4463handler.c,159 :: 		if( ucRF4463TxEvent == 0 ){
MOVW	R0, #lo_addr(_ucRF4463TxEvent+0)
MOVT	R0, #hi_addr(_ucRF4463TxEvent+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_vRFRxMessage133
;rf4463handler.c,160 :: 		memset( pcRxRF4463Buffer, '\0', sizeof( pcRxRF4463Buffer ) );
MOVS	R2, #66
SXTH	R2, R2
MOVS	R1, #0
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+0)
BL	_memset+0
;rf4463handler.c,161 :: 		ucRf4463RxPacket( pcRxRF4463Buffer );
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+0)
BL	_ucRf4463RxPacket+0
;rf4463handler.c,163 :: 		if( pcRxRF4463Buffer[ 0 ] > 0 ){
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	LS
BLS	L_vRFRxMessage134
;rf4463handler.c,166 :: 		UART1_Write_Text( "[ RF4463 Rx ] Packet: " );
MOVW	R0, #lo_addr(?lstr65_main+0)
MOVT	R0, #hi_addr(?lstr65_main+0)
BL	_UART1_Write_Text+0
;rf4463handler.c,167 :: 		for( usCounter = 0; usCounter < pcRxRF4463Buffer[ RfMessageSize ]; usCounter++ ){
; usCounter start address is: 16 (R4)
MOVS	R4, #0
; ucPosition end address is: 36 (R9)
; usCounter end address is: 16 (R4)
UXTB	R8, R9
L_vRFRxMessage135:
; usCounter start address is: 16 (R4)
; ucPosition start address is: 32 (R8)
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+0)
LDRB	R0, [R0, #0]
CMP	R4, R0
IT	CS
BCS	L_vRFRxMessage136
;rf4463handler.c,168 :: 		UART1_Write( pcRxRF4463Buffer[ usCounter ] );
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+0)
ADDS	R0, R0, R4
LDRB	R0, [R0, #0]
BL	_UART1_Write+0
;rf4463handler.c,167 :: 		for( usCounter = 0; usCounter < pcRxRF4463Buffer[ RfMessageSize ]; usCounter++ ){
ADDS	R4, R4, #1
UXTH	R4, R4
;rf4463handler.c,169 :: 		}
; usCounter end address is: 16 (R4)
IT	AL
BAL	L_vRFRxMessage135
L_vRFRxMessage136:
;rf4463handler.c,170 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;rf4463handler.c,171 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;rf4463handler.c,174 :: 		if( pcRxRF4463Buffer[ RfMessageDestination ] == NODE_FACTORY ){
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+1)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+1)
LDRB	R0, [R0, #0]
CMP	R0, #254
IT	NE
BNE	L_vRFRxMessage138
;rf4463handler.c,175 :: 		switch( pcRxRF4463Buffer[ RfMessageTable ] ){
IT	AL
BAL	L_vRFRxMessage139
;rf4463handler.c,176 :: 		case Table_RF_Test:
L_vRFRxMessage141:
;rf4463handler.c,177 :: 		switch( pcRxRF4463Buffer[ RfMessageCommand ] ){
IT	AL
BAL	L_vRFRxMessage142
; ucPosition end address is: 32 (R8)
;rf4463handler.c,178 :: 		case Test_Device_Loop:
L_vRFRxMessage144:
;rf4463handler.c,180 :: 		ucRemoteNode = NODE_BROADCAST;
MOVS	R1, #255
MOVW	R0, #lo_addr(_ucRemoteNode+0)
MOVT	R0, #hi_addr(_ucRemoteNode+0)
STRB	R1, [R0, #0]
;rf4463handler.c,181 :: 		ucSenderNode = NODE_FACTORY;
MOVS	R1, #254
MOVW	R0, #lo_addr(_ucSenderNode+0)
MOVT	R0, #hi_addr(_ucSenderNode+0)
STRB	R1, [R0, #0]
;rf4463handler.c,182 :: 		ucTableIndex = Table_RF_Test;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucTableIndex+0)
MOVT	R0, #hi_addr(_ucTableIndex+0)
STRB	R1, [R0, #0]
;rf4463handler.c,183 :: 		ucCommandIndex = Test_Device_Loop;
MOVS	R1, #5
MOVW	R0, #lo_addr(_ucCommandIndex+0)
MOVT	R0, #hi_addr(_ucCommandIndex+0)
STRB	R1, [R0, #0]
;rf4463handler.c,185 :: 		vRfTxMessage( &pcRxRF4463Buffer[ RfMessageContent ], ( pcRxRF4463Buffer[ RfMessageSize ] - RfMessageHeaderSize ) );
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+0)
LDRB	R0, [R0, #0]
SUBS	R0, R0, #5
UXTH	R1, R0
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+5)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+5)
BL	_vRfTxMessage+0
;rf4463handler.c,187 :: 		break;
IT	AL
BAL	L_vRFRxMessage143
;rf4463handler.c,188 :: 		case Test_Device_QR:
L_vRFRxMessage145:
;rf4463handler.c,189 :: 		UART1_Write_Text( "RCV|" );
MOVW	R0, #lo_addr(?lstr66_main+0)
MOVT	R0, #hi_addr(?lstr66_main+0)
BL	_UART1_Write_Text+0
;rf4463handler.c,190 :: 		for( usCounter = RfMessageContent; usCounter < pcRxRF4463Buffer[ RfMessageSize ]; usCounter++ ){
; usCounter start address is: 16 (R4)
MOVS	R4, #5
; usCounter end address is: 16 (R4)
L_vRFRxMessage146:
; usCounter start address is: 16 (R4)
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+0)
LDRB	R0, [R0, #0]
CMP	R4, R0
IT	CS
BCS	L_vRFRxMessage147
;rf4463handler.c,191 :: 		UART1_Write( pcRxRF4463Buffer[ usCounter ] );
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+0)
ADDS	R0, R0, R4
LDRB	R0, [R0, #0]
BL	_UART1_Write+0
;rf4463handler.c,190 :: 		for( usCounter = RfMessageContent; usCounter < pcRxRF4463Buffer[ RfMessageSize ]; usCounter++ ){
ADDS	R4, R4, #1
UXTH	R4, R4
;rf4463handler.c,192 :: 		}
; usCounter end address is: 16 (R4)
IT	AL
BAL	L_vRFRxMessage146
L_vRFRxMessage147:
;rf4463handler.c,193 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;rf4463handler.c,194 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;rf4463handler.c,195 :: 		break;
IT	AL
BAL	L_vRFRxMessage143
;rf4463handler.c,196 :: 		case Test_Device_Ok:
L_vRFRxMessage149:
;rf4463handler.c,197 :: 		for( usCounter = 0; usCounter < 12; usCounter++ ){
; usCounter start address is: 12 (R3)
MOVS	R3, #0
; usCounter end address is: 12 (R3)
L_vRFRxMessage150:
; usCounter start address is: 12 (R3)
CMP	R3, #12
IT	CS
BCS	L_vRFRxMessage151
;rf4463handler.c,198 :: 		pcReceivedQR[ usCounter ] = pcRxRF4463Buffer[ RfMessageContent + usCounter ];
MOVW	R0, #lo_addr(main_pcReceivedQR+0)
MOVT	R0, #hi_addr(main_pcReceivedQR+0)
ADDS	R2, R0, R3
ADDS	R1, R3, #5
UXTH	R1, R1
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;rf4463handler.c,197 :: 		for( usCounter = 0; usCounter < 12; usCounter++ ){
ADDS	R3, R3, #1
UXTH	R3, R3
;rf4463handler.c,199 :: 		}
; usCounter end address is: 12 (R3)
IT	AL
BAL	L_vRFRxMessage150
L_vRFRxMessage151:
;rf4463handler.c,201 :: 		if( memcmp( pcReceivedQR, pcSentQR, 12 ) == 0 ){
MOVS	R2, #12
SXTH	R2, R2
MOVW	R1, #lo_addr(main_pcSentQR+0)
MOVT	R1, #hi_addr(main_pcSentQR+0)
MOVW	R0, #lo_addr(main_pcReceivedQR+0)
MOVT	R0, #hi_addr(main_pcReceivedQR+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRFRxMessage153
;rf4463handler.c,202 :: 		UART1_Write_Text( "FINISH|" );
MOVW	R0, #lo_addr(?lstr67_main+0)
MOVT	R0, #hi_addr(?lstr67_main+0)
BL	_UART1_Write_Text+0
;rf4463handler.c,203 :: 		for( usCounter = 0; usCounter < 12; usCounter++ ){
; usCounter start address is: 16 (R4)
MOVS	R4, #0
; usCounter end address is: 16 (R4)
L_vRFRxMessage154:
; usCounter start address is: 16 (R4)
CMP	R4, #12
IT	CS
BCS	L_vRFRxMessage155
;rf4463handler.c,204 :: 		UART1_Write( pcReceivedQR[ usCounter ] );
MOVW	R0, #lo_addr(main_pcReceivedQR+0)
MOVT	R0, #hi_addr(main_pcReceivedQR+0)
ADDS	R0, R0, R4
LDRB	R0, [R0, #0]
BL	_UART1_Write+0
;rf4463handler.c,203 :: 		for( usCounter = 0; usCounter < 12; usCounter++ ){
ADDS	R4, R4, #1
UXTH	R4, R4
;rf4463handler.c,205 :: 		}
; usCounter end address is: 16 (R4)
IT	AL
BAL	L_vRFRxMessage154
L_vRFRxMessage155:
;rf4463handler.c,206 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;rf4463handler.c,207 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;rf4463handler.c,208 :: 		}
L_vRFRxMessage153:
;rf4463handler.c,209 :: 		break;
IT	AL
BAL	L_vRFRxMessage143
;rf4463handler.c,210 :: 		case Test_Device_Message:
L_vRFRxMessage157:
;rf4463handler.c,211 :: 		UART1_Write_Text( "RCV|" );
MOVW	R0, #lo_addr(?lstr68_main+0)
MOVT	R0, #hi_addr(?lstr68_main+0)
BL	_UART1_Write_Text+0
;rf4463handler.c,212 :: 		for( usCounter = RfMessageContent; usCounter < pcRxRF4463Buffer[ RfMessageSize ]; usCounter++ ){
; usCounter start address is: 16 (R4)
MOVS	R4, #5
; usCounter end address is: 16 (R4)
L_vRFRxMessage158:
; usCounter start address is: 16 (R4)
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+0)
LDRB	R0, [R0, #0]
CMP	R4, R0
IT	CS
BCS	L_vRFRxMessage159
;rf4463handler.c,213 :: 		UART1_Write( pcRxRF4463Buffer[ usCounter ] );
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+0)
ADDS	R0, R0, R4
LDRB	R0, [R0, #0]
BL	_UART1_Write+0
;rf4463handler.c,212 :: 		for( usCounter = RfMessageContent; usCounter < pcRxRF4463Buffer[ RfMessageSize ]; usCounter++ ){
ADDS	R4, R4, #1
UXTH	R4, R4
;rf4463handler.c,214 :: 		}
; usCounter end address is: 16 (R4)
IT	AL
BAL	L_vRFRxMessage158
L_vRFRxMessage159:
;rf4463handler.c,215 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;rf4463handler.c,216 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;rf4463handler.c,217 :: 		break;
IT	AL
BAL	L_vRFRxMessage143
;rf4463handler.c,218 :: 		case Test_Dongle_Search:
L_vRFRxMessage161:
;rf4463handler.c,220 :: 		if( ucSearchActive == 0 ){
MOVW	R0, #lo_addr(_ucSearchActive+0)
MOVT	R0, #hi_addr(_ucSearchActive+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_vRFRxMessage162
;rf4463handler.c,221 :: 		ucSearchActive = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucSearchActive+0)
MOVT	R0, #hi_addr(_ucSearchActive+0)
STRB	R1, [R0, #0]
;rf4463handler.c,222 :: 		vTimerSearchLed();
BL	_vTimerSearchLed+0
;rf4463handler.c,223 :: 		}
IT	AL
BAL	L_vRFRxMessage163
L_vRFRxMessage162:
;rf4463handler.c,225 :: 		ucSearchActive = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucSearchActive+0)
MOVT	R0, #hi_addr(_ucSearchActive+0)
STRB	R1, [R0, #0]
;rf4463handler.c,226 :: 		vTimerStop( TIMER_SEARCH );
MOVS	R0, #0
BL	_vTimerStop+0
;rf4463handler.c,227 :: 		LEDGreen = On;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;rf4463handler.c,228 :: 		}
L_vRFRxMessage163:
;rf4463handler.c,229 :: 		break;
IT	AL
BAL	L_vRFRxMessage143
;rf4463handler.c,230 :: 		case Test_Device_Info:
L_vRFRxMessage164:
;rf4463handler.c,231 :: 		for( usCounter = 0; usCounter < ( pcRxRF4463Buffer[ RfMessageSize ] - RfMessageHeaderSize ); usCounter++ ){
; ucPosition start address is: 32 (R8)
; usCounter start address is: 36 (R9)
MOVW	R9, #0
; usCounter end address is: 36 (R9)
; ucPosition end address is: 32 (R8)
L_vRFRxMessage165:
; usCounter start address is: 36 (R9)
; ucPosition start address is: 32 (R8)
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+0)
LDRB	R0, [R0, #0]
SUBS	R0, R0, #5
SXTH	R0, R0
CMP	R9, R0
IT	CS
BCS	L_vRFRxMessage166
;rf4463handler.c,232 :: 		pcTempBuffer[ usCounter ] = pcRxRF4463Buffer[ usCounter + RfMessageContent ];
ADD	R0, SP, #8
ADD	R2, R0, R9, LSL #0
ADD	R1, R9, #5
UXTH	R1, R1
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;rf4463handler.c,231 :: 		for( usCounter = 0; usCounter < ( pcRxRF4463Buffer[ RfMessageSize ] - RfMessageHeaderSize ); usCounter++ ){
ADD	R9, R9, #1
UXTH	R9, R9
;rf4463handler.c,233 :: 		}
IT	AL
BAL	L_vRFRxMessage165
L_vRFRxMessage166:
;rf4463handler.c,234 :: 		memset( pcRxRF4463AuxBuffer, '\0', RF_MAX_BUFFER_LENGTH );
MOVS	R2, #66
SXTH	R2, R2
MOVS	R1, #0
MOVW	R0, #lo_addr(_pcRxRF4463AuxBuffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463AuxBuffer+0)
BL	_memset+0
;rf4463handler.c,235 :: 		vXORRFMessage( pcTempBuffer, pcRxRF4463AuxBuffer, usCounter );
ADD	R0, SP, #8
UXTB	R2, R9
; usCounter end address is: 36 (R9)
MOVW	R1, #lo_addr(_pcRxRF4463AuxBuffer+0)
MOVT	R1, #hi_addr(_pcRxRF4463AuxBuffer+0)
BL	_vXORRFMessage+0
;rf4463handler.c,236 :: 		switch( pcRxRF4463AuxBuffer[ ucPosition++ ] ){
UXTB	R1, R8
ADD	R7, R8, #1
UXTB	R7, R7
; ucPosition end address is: 32 (R8)
; ucPosition start address is: 28 (R7)
MOVW	R0, #lo_addr(_pcRxRF4463AuxBuffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463AuxBuffer+0)
ADDS	R0, R0, R1
STR	R0, [SP, #140]
IT	AL
BAL	L_vRFRxMessage168
;rf4463handler.c,237 :: 		case Device_Model_Hub:
L_vRFRxMessage170:
;rf4463handler.c,238 :: 		UART1_Write_Text( "QR: " );
MOVW	R0, #lo_addr(?lstr69_main+0)
MOVT	R0, #hi_addr(?lstr69_main+0)
BL	_UART1_Write_Text+0
;rf4463handler.c,239 :: 		for( usCounter = 0; usCounter < 12; usCounter++ ){
; usCounter start address is: 16 (R4)
MOVS	R4, #0
; ucPosition end address is: 28 (R7)
; usCounter end address is: 16 (R4)
L_vRFRxMessage171:
; usCounter start address is: 16 (R4)
; ucPosition start address is: 28 (R7)
CMP	R4, #12
IT	CS
BCS	L_vRFRxMessage172
;rf4463handler.c,240 :: 		UART1_Write( pcRxRF4463AuxBuffer[ ucPosition++ ] );
MOVW	R0, #lo_addr(_pcRxRF4463AuxBuffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463AuxBuffer+0)
ADDS	R0, R0, R7
LDRB	R0, [R0, #0]
BL	_UART1_Write+0
ADDS	R7, R7, #1
UXTB	R7, R7
;rf4463handler.c,239 :: 		for( usCounter = 0; usCounter < 12; usCounter++ ){
ADDS	R4, R4, #1
UXTH	R4, R4
;rf4463handler.c,241 :: 		}
; usCounter end address is: 16 (R4)
IT	AL
BAL	L_vRFRxMessage171
L_vRFRxMessage172:
;rf4463handler.c,242 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;rf4463handler.c,243 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;rf4463handler.c,245 :: 		for( usCounter = 0; usCounter < 12; usCounter++ ){
; usCounter start address is: 8 (R2)
MOVS	R2, #0
; ucPosition end address is: 28 (R7)
; usCounter end address is: 8 (R2)
L_vRFRxMessage174:
; usCounter start address is: 8 (R2)
; ucPosition start address is: 28 (R7)
CMP	R2, #12
IT	CS
BCS	L_vRFRxMessage175
;rf4463handler.c,246 :: 		pcUIDHex[ usCounter ] = pcRxRF4463AuxBuffer[ ucPosition++ ];
MOVW	R0, #lo_addr(_pcUIDHex+0)
MOVT	R0, #hi_addr(_pcUIDHex+0)
ADDS	R1, R0, R2
MOVW	R0, #lo_addr(_pcRxRF4463AuxBuffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463AuxBuffer+0)
ADDS	R0, R0, R7
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
ADDS	R7, R7, #1
UXTB	R7, R7
;rf4463handler.c,245 :: 		for( usCounter = 0; usCounter < 12; usCounter++ ){
ADDS	R2, R2, #1
UXTH	R2, R2
;rf4463handler.c,247 :: 		}
; usCounter end address is: 8 (R2)
IT	AL
BAL	L_vRFRxMessage174
L_vRFRxMessage175:
;rf4463handler.c,249 :: 		vSerializeUUID( pcUIDText, pcUIDHex );
MOVW	R1, #lo_addr(_pcUIDHex+0)
MOVT	R1, #hi_addr(_pcUIDHex+0)
MOVW	R0, #lo_addr(_pcUIDText+0)
MOVT	R0, #hi_addr(_pcUIDText+0)
BL	_vSerializeUUID+0
;rf4463handler.c,251 :: 		UART1_Write_Text( "UID: " );
MOVW	R0, #lo_addr(?lstr70_main+0)
MOVT	R0, #hi_addr(?lstr70_main+0)
BL	_UART1_Write_Text+0
;rf4463handler.c,252 :: 		UART1_Write_Text( pcUIDText );
MOVW	R0, #lo_addr(_pcUIDText+0)
MOVT	R0, #hi_addr(_pcUIDText+0)
BL	_UART1_Write_Text+0
;rf4463handler.c,253 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;rf4463handler.c,254 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;rf4463handler.c,256 :: 		for( usCounter = 0; usCounter < 6; usCounter++ ){
; usCounter start address is: 8 (R2)
MOVS	R2, #0
; ucPosition end address is: 28 (R7)
; usCounter end address is: 8 (R2)
UXTB	R8, R7
L_vRFRxMessage177:
; usCounter start address is: 8 (R2)
; ucPosition start address is: 32 (R8)
CMP	R2, #6
IT	CS
BCS	L_vRFRxMessage178
;rf4463handler.c,257 :: 		pcMACHex[ usCounter ] = pcRxRF4463AuxBuffer[ ucPosition++ ];
MOVW	R0, #lo_addr(_pcMACHex+0)
MOVT	R0, #hi_addr(_pcMACHex+0)
ADDS	R1, R0, R2
MOVW	R0, #lo_addr(_pcRxRF4463AuxBuffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463AuxBuffer+0)
ADD	R0, R0, R8, LSL #0
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
ADD	R8, R8, #1
UXTB	R8, R8
;rf4463handler.c,256 :: 		for( usCounter = 0; usCounter < 6; usCounter++ ){
ADDS	R2, R2, #1
UXTH	R2, R2
;rf4463handler.c,258 :: 		}
; usCounter end address is: 8 (R2)
IT	AL
BAL	L_vRFRxMessage177
L_vRFRxMessage178:
;rf4463handler.c,259 :: 		vSerializeMACAddress( pcMACText, pcMACHex );
MOVW	R1, #lo_addr(_pcMACHex+0)
MOVT	R1, #hi_addr(_pcMACHex+0)
MOVW	R0, #lo_addr(_pcMACText+0)
MOVT	R0, #hi_addr(_pcMACText+0)
BL	_vSerializeMACAddress+0
;rf4463handler.c,260 :: 		UART1_Write_Text( "MAC: " );
MOVW	R0, #lo_addr(?lstr71_main+0)
MOVT	R0, #hi_addr(?lstr71_main+0)
BL	_UART1_Write_Text+0
;rf4463handler.c,261 :: 		UART1_Write_Text( pcMACText );
MOVW	R0, #lo_addr(_pcMACText+0)
MOVT	R0, #hi_addr(_pcMACText+0)
BL	_UART1_Write_Text+0
;rf4463handler.c,262 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;rf4463handler.c,263 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;rf4463handler.c,265 :: 		for( usCounter = 0; usCounter < 4; usCounter++ ){
; usCounter start address is: 8 (R2)
MOVS	R2, #0
; ucPosition end address is: 32 (R8)
; usCounter end address is: 8 (R2)
UXTB	R3, R8
L_vRFRxMessage180:
; usCounter start address is: 8 (R2)
; ucPosition start address is: 12 (R3)
CMP	R2, #4
IT	CS
BCS	L_vRFRxMessage181
;rf4463handler.c,266 :: 		pcIPHex[ usCounter ] = pcRxRF4463AuxBuffer[ ucPosition++ ];
MOVW	R0, #lo_addr(_pcIPHex+0)
MOVT	R0, #hi_addr(_pcIPHex+0)
ADDS	R1, R0, R2
MOVW	R0, #lo_addr(_pcRxRF4463AuxBuffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463AuxBuffer+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
ADDS	R3, R3, #1
UXTB	R3, R3
;rf4463handler.c,265 :: 		for( usCounter = 0; usCounter < 4; usCounter++ ){
ADDS	R2, R2, #1
UXTH	R2, R2
;rf4463handler.c,267 :: 		}
; usCounter end address is: 8 (R2)
IT	AL
BAL	L_vRFRxMessage180
L_vRFRxMessage181:
;rf4463handler.c,268 :: 		vSerializeIPAddress( pcIPText, pcIPHex );
STRB	R3, [SP, #4]
MOVW	R1, #lo_addr(_pcIPHex+0)
MOVT	R1, #hi_addr(_pcIPHex+0)
MOVW	R0, #lo_addr(_pcIPText+0)
MOVT	R0, #hi_addr(_pcIPText+0)
BL	_vSerializeIPAddress+0
;rf4463handler.c,269 :: 		UART1_Write_Text( "IP: " );
MOVW	R0, #lo_addr(?lstr72_main+0)
MOVT	R0, #hi_addr(?lstr72_main+0)
BL	_UART1_Write_Text+0
;rf4463handler.c,270 :: 		UART1_Write_Text( pcIPText );
MOVW	R0, #lo_addr(_pcIPText+0)
MOVT	R0, #hi_addr(_pcIPText+0)
BL	_UART1_Write_Text+0
;rf4463handler.c,271 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;rf4463handler.c,272 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;rf4463handler.c,274 :: 		memset( pcTempBuffer, '\0', NULL );
ADD	R0, SP, #8
MOVS	R2, #0
SXTH	R2, R2
MOVS	R1, #0
BL	_memset+0
LDRB	R3, [SP, #4]
;rf4463handler.c,275 :: 		sprintf( pcTempBuffer, "Ver: %d.%d.%d\r\n", pcRxRF4463AuxBuffer[ ucPosition++ ], pcRxRF4463AuxBuffer[ ucPosition++ ], pcRxRF4463AuxBuffer[ ucPosition++ ] );
MOVW	R0, #lo_addr(_pcRxRF4463AuxBuffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463AuxBuffer+0)
ADDS	R0, R0, R3
; ucPosition end address is: 12 (R3)
LDRB	R0, [R0, #0]
UXTB	R4, R0
UXTB	R3, R0
UXTB	R2, R0
MOVW	R1, #lo_addr(?lstr_73_main+0)
MOVT	R1, #hi_addr(?lstr_73_main+0)
ADD	R0, SP, #8
PUSH	(R4)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #20
;rf4463handler.c,276 :: 		UART1_Write_Text( pcTempBuffer );
ADD	R0, SP, #8
BL	_UART1_Write_Text+0
;rf4463handler.c,277 :: 		break;
IT	AL
BAL	L_vRFRxMessage169
;rf4463handler.c,278 :: 		case Device_Model_Switch:
L_vRFRxMessage183:
;rf4463handler.c,279 :: 		break;
IT	AL
BAL	L_vRFRxMessage169
;rf4463handler.c,280 :: 		case Device_Model_Dimmer:
L_vRFRxMessage184:
;rf4463handler.c,281 :: 		break;
IT	AL
BAL	L_vRFRxMessage169
;rf4463handler.c,282 :: 		case Device_Model_Outlet:
L_vRFRxMessage185:
;rf4463handler.c,283 :: 		break;
IT	AL
BAL	L_vRFRxMessage169
;rf4463handler.c,284 :: 		}
L_vRFRxMessage168:
; ucPosition start address is: 28 (R7)
LDR	R1, [SP, #140]
LDRB	R0, [R1, #0]
CMP	R0, #1
IT	EQ
BEQ	L_vRFRxMessage170
; ucPosition end address is: 28 (R7)
LDRB	R0, [R1, #0]
CMP	R0, #2
IT	EQ
BEQ	L_vRFRxMessage183
LDRB	R0, [R1, #0]
CMP	R0, #3
IT	EQ
BEQ	L_vRFRxMessage184
LDRB	R0, [R1, #0]
CMP	R0, #4
IT	EQ
BEQ	L_vRFRxMessage185
L_vRFRxMessage169:
;rf4463handler.c,285 :: 		break;
IT	AL
BAL	L_vRFRxMessage143
;rf4463handler.c,286 :: 		}
L_vRFRxMessage142:
; ucPosition start address is: 32 (R8)
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+4)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+4)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	EQ
BEQ	L_vRFRxMessage144
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+4)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+4)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_vRFRxMessage145
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+4)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+4)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_vRFRxMessage149
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+4)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+4)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	EQ
BEQ	L_vRFRxMessage157
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+4)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+4)
LDRB	R0, [R0, #0]
CMP	R0, #200
IT	EQ
BEQ	L_vRFRxMessage161
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+4)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+4)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	EQ
BEQ	L_vRFRxMessage164
; ucPosition end address is: 32 (R8)
L_vRFRxMessage143:
;rf4463handler.c,287 :: 		break;
IT	AL
BAL	L_vRFRxMessage140
;rf4463handler.c,288 :: 		case Table_RF_Setup:
L_vRFRxMessage186:
;rf4463handler.c,289 :: 		switch( pcRxRF4463Buffer[ RfMessageCommand ] ){
IT	AL
BAL	L_vRFRxMessage187
;rf4463handler.c,290 :: 		case Setup_Hard_Discover:
L_vRFRxMessage189:
;rf4463handler.c,291 :: 		memset( pcTempConvBuffer, '\0', RF_MAX_BUFFER_LENGTH );
ADD	R0, SP, #74
MOVS	R2, #66
SXTH	R2, R2
MOVS	R1, #0
BL	_memset+0
;rf4463handler.c,292 :: 		memset( pcTempBuffer, '\0', RF_MAX_BUFFER_LENGTH );
ADD	R0, SP, #8
MOVS	R2, #66
SXTH	R2, R2
MOVS	R1, #0
BL	_memset+0
;rf4463handler.c,293 :: 		for( usCounter = 0; usCounter < 12; usCounter++ ){
; usCounter start address is: 12 (R3)
MOVS	R3, #0
; usCounter end address is: 12 (R3)
L_vRFRxMessage190:
; usCounter start address is: 12 (R3)
CMP	R3, #12
IT	CS
BCS	L_vRFRxMessage191
;rf4463handler.c,294 :: 		pcTempBuffer[ usCounter ] = pcRxRF4463Buffer[ RfMessageContent + usCounter ];
ADD	R0, SP, #8
ADDS	R2, R0, R3
ADDS	R1, R3, #5
UXTH	R1, R1
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;rf4463handler.c,293 :: 		for( usCounter = 0; usCounter < 12; usCounter++ ){
ADDS	R3, R3, #1
UXTH	R3, R3
;rf4463handler.c,295 :: 		}
; usCounter end address is: 12 (R3)
IT	AL
BAL	L_vRFRxMessage190
L_vRFRxMessage191:
;rf4463handler.c,297 :: 		vHexToASCII( pcTempConvBuffer, pcTempBuffer, 12 );
ADD	R1, SP, #8
ADD	R0, SP, #74
MOVS	R2, #12
BL	_vHexToASCII+0
;rf4463handler.c,299 :: 		UART1_Write_Text( "UID: " );
MOVW	R0, #lo_addr(?lstr74_main+0)
MOVT	R0, #hi_addr(?lstr74_main+0)
BL	_UART1_Write_Text+0
;rf4463handler.c,300 :: 		UART1_Write_Text( pcTempConvBuffer );
ADD	R0, SP, #74
BL	_UART1_Write_Text+0
;rf4463handler.c,301 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;rf4463handler.c,302 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;rf4463handler.c,303 :: 		break;
IT	AL
BAL	L_vRFRxMessage188
;rf4463handler.c,304 :: 		}
L_vRFRxMessage187:
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+4)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+4)
LDRB	R0, [R0, #0]
CMP	R0, #11
IT	EQ
BEQ	L_vRFRxMessage189
L_vRFRxMessage188:
;rf4463handler.c,305 :: 		break;
IT	AL
BAL	L_vRFRxMessage140
;rf4463handler.c,306 :: 		}
L_vRFRxMessage139:
; ucPosition start address is: 32 (R8)
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+3)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+3)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_vRFRxMessage141
; ucPosition end address is: 32 (R8)
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+3)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+3)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_vRFRxMessage186
L_vRFRxMessage140:
;rf4463handler.c,307 :: 		}
IT	AL
BAL	L_vRFRxMessage193
L_vRFRxMessage138:
;rf4463handler.c,308 :: 		else if( pcRxRF4463Buffer[ RfMessageDestination ] == HUB_NODE_DEFAULT ){
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+1)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+1)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_vRFRxMessage194
;rf4463handler.c,309 :: 		switch( pcRxRF4463Buffer[ RfMessageTable ] ){
IT	AL
BAL	L_vRFRxMessage195
;rf4463handler.c,310 :: 		case Table_RF_Setup:
L_vRFRxMessage197:
;rf4463handler.c,311 :: 		switch( pcRxRF4463Buffer[ RfMessageCommand ] ){
IT	AL
BAL	L_vRFRxMessage198
;rf4463handler.c,312 :: 		case Setup_Qr:
L_vRFRxMessage200:
;rf4463handler.c,313 :: 		memset( pcTempConvBuffer, '\0', RF_MAX_BUFFER_LENGTH );
ADD	R0, SP, #74
MOVS	R2, #66
SXTH	R2, R2
MOVS	R1, #0
BL	_memset+0
;rf4463handler.c,314 :: 		for( usCounter = 0; usCounter < 12; usCounter++ ){
; usCounter start address is: 12 (R3)
MOVS	R3, #0
; usCounter end address is: 12 (R3)
L_vRFRxMessage201:
; usCounter start address is: 12 (R3)
CMP	R3, #12
IT	CS
BCS	L_vRFRxMessage202
;rf4463handler.c,315 :: 		pcTempBuffer[ usCounter ] = pcRxRF4463Buffer[ RfMessageContent + usCounter ];
ADD	R0, SP, #8
ADDS	R2, R0, R3
ADDS	R1, R3, #5
UXTH	R1, R1
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;rf4463handler.c,314 :: 		for( usCounter = 0; usCounter < 12; usCounter++ ){
ADDS	R3, R3, #1
UXTH	R3, R3
;rf4463handler.c,316 :: 		}
; usCounter end address is: 12 (R3)
IT	AL
BAL	L_vRFRxMessage201
L_vRFRxMessage202:
;rf4463handler.c,317 :: 		vHexToASCII( pcTempConvBuffer, pcTempBuffer, 12 );
ADD	R1, SP, #8
ADD	R0, SP, #74
MOVS	R2, #12
BL	_vHexToASCII+0
;rf4463handler.c,319 :: 		UART1_Write_Text( "UID: " );
MOVW	R0, #lo_addr(?lstr75_main+0)
MOVT	R0, #hi_addr(?lstr75_main+0)
BL	_UART1_Write_Text+0
;rf4463handler.c,320 :: 		UART1_Write_Text( pcTempConvBuffer );
ADD	R0, SP, #74
BL	_UART1_Write_Text+0
;rf4463handler.c,321 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;rf4463handler.c,322 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;rf4463handler.c,324 :: 		memset( pcJSONBuffer, '\0', 512 );
MOVW	R2, #512
SXTH	R2, R2
MOVS	R1, #0
MOVW	R0, #lo_addr(_pcJSONBuffer+0)
MOVT	R0, #hi_addr(_pcJSONBuffer+0)
BL	_memset+0
;rf4463handler.c,325 :: 		sprintf( pcJSONBuffer, "{\"qrCode\":\"%s\",\"location\":1,\"mac\":\"\",\"modelId\":%d,\"uuiddevice\":\"%s\"}\r\n", pcTempQR, ucSearchedModelId, pcTempConvBuffer );
ADD	R4, SP, #74
MOVW	R0, #lo_addr(_ucSearchedModelId+0)
MOVT	R0, #hi_addr(_ucSearchedModelId+0)
LDRB	R3, [R0, #0]
MOVW	R2, #lo_addr(_pcTempQR+0)
MOVT	R2, #hi_addr(_pcTempQR+0)
MOVW	R1, #lo_addr(?lstr_76_main+0)
MOVT	R1, #hi_addr(?lstr_76_main+0)
MOVW	R0, #lo_addr(_pcJSONBuffer+0)
MOVT	R0, #hi_addr(_pcJSONBuffer+0)
PUSH	(R4)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #20
;rf4463handler.c,327 :: 		UART1_Write_Text( pcJSONBuffer );
MOVW	R0, #lo_addr(_pcJSONBuffer+0)
MOVT	R0, #hi_addr(_pcJSONBuffer+0)
BL	_UART1_Write_Text+0
;rf4463handler.c,328 :: 		break;
IT	AL
BAL	L_vRFRxMessage199
;rf4463handler.c,329 :: 		case Setup_Hard_Discover:
L_vRFRxMessage204:
;rf4463handler.c,330 :: 		memset( pcTempConvBuffer, '\0', RF_MAX_BUFFER_LENGTH );
ADD	R0, SP, #74
MOVS	R2, #66
SXTH	R2, R2
MOVS	R1, #0
BL	_memset+0
;rf4463handler.c,331 :: 		memset( pcTempBuffer, '\0', RF_MAX_BUFFER_LENGTH );
ADD	R0, SP, #8
MOVS	R2, #66
SXTH	R2, R2
MOVS	R1, #0
BL	_memset+0
;rf4463handler.c,332 :: 		for( usCounter = 0; usCounter < 12; usCounter++ ){
; usCounter start address is: 12 (R3)
MOVS	R3, #0
; usCounter end address is: 12 (R3)
L_vRFRxMessage205:
; usCounter start address is: 12 (R3)
CMP	R3, #12
IT	CS
BCS	L_vRFRxMessage206
;rf4463handler.c,333 :: 		pcTempBuffer[ usCounter ] = pcRxRF4463Buffer[ RfMessageContent + usCounter ];
ADD	R0, SP, #8
ADDS	R2, R0, R3
ADDS	R1, R3, #5
UXTH	R1, R1
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;rf4463handler.c,332 :: 		for( usCounter = 0; usCounter < 12; usCounter++ ){
ADDS	R3, R3, #1
UXTH	R3, R3
;rf4463handler.c,334 :: 		}
; usCounter end address is: 12 (R3)
IT	AL
BAL	L_vRFRxMessage205
L_vRFRxMessage206:
;rf4463handler.c,336 :: 		vHexToASCII( pcTempConvBuffer, pcTempBuffer, 12 );
ADD	R1, SP, #8
ADD	R0, SP, #74
MOVS	R2, #12
BL	_vHexToASCII+0
;rf4463handler.c,338 :: 		UART1_Write_Text( "UID: " );
MOVW	R0, #lo_addr(?lstr77_main+0)
MOVT	R0, #hi_addr(?lstr77_main+0)
BL	_UART1_Write_Text+0
;rf4463handler.c,339 :: 		UART1_Write_Text( pcTempConvBuffer );
ADD	R0, SP, #74
BL	_UART1_Write_Text+0
;rf4463handler.c,340 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;rf4463handler.c,341 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;rf4463handler.c,342 :: 		break;
IT	AL
BAL	L_vRFRxMessage199
;rf4463handler.c,343 :: 		}
L_vRFRxMessage198:
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+4)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+4)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_vRFRxMessage200
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+4)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+4)
LDRB	R0, [R0, #0]
CMP	R0, #11
IT	EQ
BEQ	L_vRFRxMessage204
L_vRFRxMessage199:
;rf4463handler.c,344 :: 		break;
IT	AL
BAL	L_vRFRxMessage196
;rf4463handler.c,345 :: 		}
L_vRFRxMessage195:
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+3)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+3)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_vRFRxMessage197
L_vRFRxMessage196:
;rf4463handler.c,346 :: 		}
L_vRFRxMessage194:
L_vRFRxMessage193:
;rf4463handler.c,349 :: 		if( pcRxRF4463Buffer[ RfMessageDestination ] == NODE_FACTORY ){
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+1)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+1)
LDRB	R0, [R0, #0]
CMP	R0, #254
IT	NE
BNE	L_vRFRxMessage208
;rf4463handler.c,350 :: 		switch( pcRxRF4463Buffer[ RfMessageTable ] ){
IT	AL
BAL	L_vRFRxMessage209
;rf4463handler.c,351 :: 		case Table_RF_Test:
L_vRFRxMessage211:
;rf4463handler.c,352 :: 		switch( pcRxRF4463Buffer[ RfMessageCommand ] ){
IT	AL
BAL	L_vRFRxMessage212
;rf4463handler.c,354 :: 		case Test_Device_Loop:
L_vRFRxMessage214:
;rf4463handler.c,357 :: 		ucRemoteNode = NODE_BROADCAST;
MOVS	R1, #255
MOVW	R0, #lo_addr(_ucRemoteNode+0)
MOVT	R0, #hi_addr(_ucRemoteNode+0)
STRB	R1, [R0, #0]
;rf4463handler.c,358 :: 		ucSenderNode = NODE_FACTORY;
MOVS	R1, #254
MOVW	R0, #lo_addr(_ucSenderNode+0)
MOVT	R0, #hi_addr(_ucSenderNode+0)
STRB	R1, [R0, #0]
;rf4463handler.c,359 :: 		ucTableIndex = Table_RF_Test;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucTableIndex+0)
MOVT	R0, #hi_addr(_ucTableIndex+0)
STRB	R1, [R0, #0]
;rf4463handler.c,360 :: 		ucCommandIndex = Test_Device_Loop;
MOVS	R1, #5
MOVW	R0, #lo_addr(_ucCommandIndex+0)
MOVT	R0, #hi_addr(_ucCommandIndex+0)
STRB	R1, [R0, #0]
;rf4463handler.c,361 :: 		vRfTxMessage(&pcRxRF4463Buffer[RfMessageContent], (pcRxRF4463Buffer[ RfMessageSize]-RfMessageHeaderSize));
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+0)
LDRB	R0, [R0, #0]
SUBS	R0, R0, #5
UXTH	R1, R0
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+5)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+5)
BL	_vRfTxMessage+0
;rf4463handler.c,363 :: 		break;
IT	AL
BAL	L_vRFRxMessage213
;rf4463handler.c,365 :: 		default :
L_vRFRxMessage215:
;rf4463handler.c,366 :: 		break;
IT	AL
BAL	L_vRFRxMessage213
;rf4463handler.c,367 :: 		}
L_vRFRxMessage212:
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+4)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+4)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	EQ
BEQ	L_vRFRxMessage214
IT	AL
BAL	L_vRFRxMessage215
L_vRFRxMessage213:
;rf4463handler.c,368 :: 		break;
IT	AL
BAL	L_vRFRxMessage210
;rf4463handler.c,369 :: 		}
L_vRFRxMessage209:
MOVW	R0, #lo_addr(_pcRxRF4463Buffer+3)
MOVT	R0, #hi_addr(_pcRxRF4463Buffer+3)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_vRFRxMessage211
L_vRFRxMessage210:
;rf4463handler.c,370 :: 		}
L_vRFRxMessage208:
;rf4463handler.c,371 :: 		}
L_vRFRxMessage134:
;rf4463handler.c,372 :: 		}
IT	AL
BAL	L_vRFRxMessage216
L_vRFRxMessage133:
;rf4463handler.c,374 :: 		ucRF4463TxEvent = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucRF4463TxEvent+0)
MOVT	R0, #hi_addr(_ucRF4463TxEvent+0)
STRB	R1, [R0, #0]
;rf4463handler.c,375 :: 		}
L_vRFRxMessage216:
;rf4463handler.c,377 :: 		LEDRed = Off;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;rf4463handler.c,379 :: 		ucRf4463RxInit();
BL	_ucRf4463RxInit+0
;rf4463handler.c,380 :: 		}
L_end_vRFRxMessage:
LDR	LR, [SP, #0]
ADD	SP, SP, #144
BX	LR
; end of _vRFRxMessage
_vRfTxMessage:
;rf4463handler.c,385 :: 		void vRfTxMessage( uint8_t * pcOutBuffer, uint16_t usLength ){
; usLength start address is: 4 (R1)
; pcOutBuffer start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R6, R0
UXTH	R7, R1
; usLength end address is: 4 (R1)
; pcOutBuffer end address is: 0 (R0)
; pcOutBuffer start address is: 24 (R6)
; usLength start address is: 28 (R7)
;rf4463handler.c,386 :: 		uint16_t usCounter = 0;
;rf4463handler.c,389 :: 		memset( pcTxRF4463Buffer, '\0', sizeof( pcTxRF4463Buffer ) );
MOVS	R2, #66
SXTH	R2, R2
MOVS	R1, #0
MOVW	R0, #lo_addr(main_pcTxRF4463Buffer+0)
MOVT	R0, #hi_addr(main_pcTxRF4463Buffer+0)
BL	_memset+0
;rf4463handler.c,391 :: 		if( usLength + 5 >= RF_MAX_BUFFER_LENGTH ){
ADDS	R2, R7, #5
UXTH	R2, R2
CMP	R2, #66
IT	CC
BCC	L_vRfTxMessage217
; pcOutBuffer end address is: 24 (R6)
; usLength end address is: 28 (R7)
;rf4463handler.c,393 :: 		return;
IT	AL
BAL	L_end_vRfTxMessage
;rf4463handler.c,394 :: 		}
L_vRfTxMessage217:
;rf4463handler.c,411 :: 		pcTxRF4463Buffer[ RfMessageSize ]           = RfMessageHeaderSize + usLength;
; usLength start address is: 28 (R7)
; pcOutBuffer start address is: 24 (R6)
ADDS	R3, R7, #5
MOVW	R2, #lo_addr(main_pcTxRF4463Buffer+0)
MOVT	R2, #hi_addr(main_pcTxRF4463Buffer+0)
STRB	R3, [R2, #0]
;rf4463handler.c,412 :: 		pcTxRF4463Buffer[ RfMessageDestination ]    = ucRemoteNode;
MOVW	R2, #lo_addr(_ucRemoteNode+0)
MOVT	R2, #hi_addr(_ucRemoteNode+0)
LDRB	R3, [R2, #0]
MOVW	R2, #lo_addr(main_pcTxRF4463Buffer+1)
MOVT	R2, #hi_addr(main_pcTxRF4463Buffer+1)
STRB	R3, [R2, #0]
;rf4463handler.c,413 :: 		pcTxRF4463Buffer[ RfMessageSender ]         = ucSenderNode;
MOVW	R2, #lo_addr(_ucSenderNode+0)
MOVT	R2, #hi_addr(_ucSenderNode+0)
LDRB	R3, [R2, #0]
MOVW	R2, #lo_addr(main_pcTxRF4463Buffer+2)
MOVT	R2, #hi_addr(main_pcTxRF4463Buffer+2)
STRB	R3, [R2, #0]
;rf4463handler.c,414 :: 		pcTxRF4463Buffer[ RfMessageTable ]          = ucTableIndex;
MOVW	R2, #lo_addr(_ucTableIndex+0)
MOVT	R2, #hi_addr(_ucTableIndex+0)
LDRB	R3, [R2, #0]
MOVW	R2, #lo_addr(main_pcTxRF4463Buffer+3)
MOVT	R2, #hi_addr(main_pcTxRF4463Buffer+3)
STRB	R3, [R2, #0]
;rf4463handler.c,415 :: 		pcTxRF4463Buffer[ RfMessageCommand ]        = ucCommandIndex;
MOVW	R2, #lo_addr(_ucCommandIndex+0)
MOVT	R2, #hi_addr(_ucCommandIndex+0)
LDRB	R3, [R2, #0]
MOVW	R2, #lo_addr(main_pcTxRF4463Buffer+4)
MOVT	R2, #hi_addr(main_pcTxRF4463Buffer+4)
STRB	R3, [R2, #0]
;rf4463handler.c,417 :: 		if( usLength > 0 ){
CMP	R7, #0
IT	LS
BLS	L_vRfTxMessage218
;rf4463handler.c,418 :: 		for( usCounter = 0; usCounter < usLength; usCounter++ ){
; usCounter start address is: 16 (R4)
MOVS	R4, #0
; pcOutBuffer end address is: 24 (R6)
; usLength end address is: 28 (R7)
; usCounter end address is: 16 (R4)
MOV	R1, R6
UXTH	R0, R7
L_vRfTxMessage219:
; usCounter start address is: 16 (R4)
; pcOutBuffer start address is: 4 (R1)
; usLength start address is: 0 (R0)
; pcOutBuffer start address is: 4 (R1)
; pcOutBuffer end address is: 4 (R1)
CMP	R4, R0
IT	CS
BCS	L_vRfTxMessage220
; pcOutBuffer end address is: 4 (R1)
;rf4463handler.c,419 :: 		pcTxRF4463Buffer[ RfMessageHeaderSize + usCounter ] = pcOutBuffer[ usCounter ];
; pcOutBuffer start address is: 4 (R1)
ADDS	R3, R4, #5
UXTH	R3, R3
MOVW	R2, #lo_addr(main_pcTxRF4463Buffer+0)
MOVT	R2, #hi_addr(main_pcTxRF4463Buffer+0)
ADDS	R3, R2, R3
ADDS	R2, R1, R4
LDRB	R2, [R2, #0]
STRB	R2, [R3, #0]
;rf4463handler.c,418 :: 		for( usCounter = 0; usCounter < usLength; usCounter++ ){
ADDS	R4, R4, #1
UXTH	R4, R4
;rf4463handler.c,420 :: 		}
; usLength end address is: 0 (R0)
; pcOutBuffer end address is: 4 (R1)
; usCounter end address is: 16 (R4)
IT	AL
BAL	L_vRfTxMessage219
L_vRfTxMessage220:
;rf4463handler.c,421 :: 		}
L_vRfTxMessage218:
;rf4463handler.c,424 :: 		UART1_Write_Text( "[ RF4463 TX ] Packet: " );
MOVW	R2, #lo_addr(?lstr78_main+0)
MOVT	R2, #hi_addr(?lstr78_main+0)
MOV	R0, R2
BL	_UART1_Write_Text+0
;rf4463handler.c,425 :: 		for( usCounter = 0; usCounter < pcTxRF4463Buffer[ RfMessageSize ]; usCounter++ ){
; usCounter start address is: 16 (R4)
MOVS	R4, #0
; usCounter end address is: 16 (R4)
L_vRfTxMessage222:
; usCounter start address is: 16 (R4)
MOVW	R2, #lo_addr(main_pcTxRF4463Buffer+0)
MOVT	R2, #hi_addr(main_pcTxRF4463Buffer+0)
LDRB	R2, [R2, #0]
CMP	R4, R2
IT	CS
BCS	L_vRfTxMessage223
;rf4463handler.c,426 :: 		UART1_Write( pcTxRF4463Buffer[ usCounter ] );
MOVW	R2, #lo_addr(main_pcTxRF4463Buffer+0)
MOVT	R2, #hi_addr(main_pcTxRF4463Buffer+0)
ADDS	R2, R2, R4
LDRB	R2, [R2, #0]
UXTH	R0, R2
BL	_UART1_Write+0
;rf4463handler.c,425 :: 		for( usCounter = 0; usCounter < pcTxRF4463Buffer[ RfMessageSize ]; usCounter++ ){
ADDS	R4, R4, #1
UXTH	R4, R4
;rf4463handler.c,427 :: 		}
; usCounter end address is: 16 (R4)
IT	AL
BAL	L_vRfTxMessage222
L_vRfTxMessage223:
;rf4463handler.c,428 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;rf4463handler.c,429 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;rf4463handler.c,432 :: 		ucRf4463TxPacket( pcTxRF4463Buffer, pcTxRF4463Buffer[ RfMessageSize ] );
MOVW	R2, #lo_addr(main_pcTxRF4463Buffer+0)
MOVT	R2, #hi_addr(main_pcTxRF4463Buffer+0)
LDRB	R2, [R2, #0]
UXTB	R1, R2
MOVW	R0, #lo_addr(main_pcTxRF4463Buffer+0)
MOVT	R0, #hi_addr(main_pcTxRF4463Buffer+0)
BL	_ucRf4463TxPacket+0
;rf4463handler.c,434 :: 		ucRf4463RxInit();
BL	_ucRf4463RxInit+0
;rf4463handler.c,435 :: 		}
L_end_vRfTxMessage:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vRfTxMessage
_vRfSettingsHotSwap:
;rf4463handler.c,440 :: 		void vRfSettingsHotSwap( uint8_t ucRfChannel, uint16_t usNetwork ){
; usNetwork start address is: 4 (R1)
; ucRfChannel start address is: 0 (R0)
SUB	SP, SP, #24
STR	LR, [SP, #0]
UXTB	R9, R0
UXTH	R8, R1
; usNetwork end address is: 4 (R1)
; ucRfChannel end address is: 0 (R0)
; ucRfChannel start address is: 36 (R9)
; usNetwork start address is: 32 (R8)
;rf4463handler.c,444 :: 		ucRf4463EnterStandbyMode();
BL	_ucRf4463EnterStandbyMode+0
;rf4463handler.c,445 :: 		xRadioParameters.Channel = ucRfChannel;
MOVW	R2, #lo_addr(_xRadioParameters+2)
MOVT	R2, #hi_addr(_xRadioParameters+2)
STRB	R9, [R2, #0]
; ucRfChannel end address is: 36 (R9)
;rf4463handler.c,446 :: 		xRadioParameters.Network = usNetwork;
MOVW	R5, #lo_addr(_xRadioParameters+6)
MOVT	R5, #hi_addr(_xRadioParameters+6)
STRH	R8, [R5, #0]
;rf4463handler.c,448 :: 		pcBuffer[ 0 ] = ( xRadioParameters.Network >> 8 );
ADD	R4, SP, #4
LSR	R2, R8, #8
; usNetwork end address is: 32 (R8)
STRB	R2, [R4, #0]
;rf4463handler.c,449 :: 		pcBuffer[ 1 ] = xRadioParameters.Network;
ADDS	R3, R4, #1
MOV	R2, R5
LDRH	R2, [R2, #0]
STRB	R2, [R3, #0]
;rf4463handler.c,450 :: 		ucRf4463SetSyncWords( pcBuffer, 2 );
MOVS	R1, #2
MOV	R0, R4
BL	_ucRf4463SetSyncWords+0
;rf4463handler.c,453 :: 		UART1_Write_Text( "[ RF4463 CFG ] Channel: " );
MOVW	R2, #lo_addr(?lstr79_main+0)
MOVT	R2, #hi_addr(?lstr79_main+0)
MOV	R0, R2
BL	_UART1_Write_Text+0
;rf4463handler.c,454 :: 		ByteToStr( xRadioParameters.Channel, pcTemp );
ADD	R3, SP, #9
MOVW	R2, #lo_addr(_xRadioParameters+2)
MOVT	R2, #hi_addr(_xRadioParameters+2)
LDRB	R2, [R2, #0]
MOV	R1, R3
UXTB	R0, R2
BL	_ByteToStr+0
;rf4463handler.c,455 :: 		UART1_Write_Text( pcTemp );
ADD	R2, SP, #9
MOV	R0, R2
BL	_UART1_Write_Text+0
;rf4463handler.c,456 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;rf4463handler.c,457 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;rf4463handler.c,459 :: 		UART1_Write_Text( "[ RF4463 CFG ] Network: " );
MOVW	R2, #lo_addr(?lstr80_main+0)
MOVT	R2, #hi_addr(?lstr80_main+0)
MOV	R0, R2
BL	_UART1_Write_Text+0
;rf4463handler.c,460 :: 		IntToStr( xRadioParameters.Network, pcTemp );
ADD	R3, SP, #9
MOVW	R2, #lo_addr(_xRadioParameters+6)
MOVT	R2, #hi_addr(_xRadioParameters+6)
LDRH	R2, [R2, #0]
MOV	R1, R3
SXTH	R0, R2
BL	_IntToStr+0
;rf4463handler.c,461 :: 		UART1_Write_Text( pcTemp );
ADD	R2, SP, #9
MOV	R0, R2
BL	_UART1_Write_Text+0
;rf4463handler.c,462 :: 		UART1_Write( '\r' );
MOVS	R0, #13
BL	_UART1_Write+0
;rf4463handler.c,463 :: 		UART1_Write( '\n' );
MOVS	R0, #10
BL	_UART1_Write+0
;rf4463handler.c,466 :: 		ucRf4463ClearInterrupts();
BL	_ucRf4463ClearInterrupts+0
;rf4463handler.c,468 :: 		ucRf4463RxInit();
BL	_ucRf4463RxInit+0
;rf4463handler.c,469 :: 		}
L_end_vRfSettingsHotSwap:
LDR	LR, [SP, #0]
ADD	SP, SP, #24
BX	LR
; end of _vRfSettingsHotSwap
_ucRf4463Init:
;rf4463pro.c,38 :: 		uint8_t ucRf4463Init(){
SUB	SP, SP, #24
STR	LR, [SP, #0]
;rf4463pro.c,43 :: 		vRf4463PowerOnReset();
BL	_vRf4463PowerOnReset+0
;rf4463pro.c,45 :: 		vRf4463SetConfiguration( RF4463_CONFIGURATION_DATA, sizeof( RF4463_CONFIGURATION_DATA ) );
MOVW	R1, #969
MOVW	R0, #lo_addr(_RF4463_CONFIGURATION_DATA+0)
MOVT	R0, #hi_addr(_RF4463_CONFIGURATION_DATA+0)
BL	_vRf4463SetConfiguration+0
;rf4463pro.c,51 :: 		pcBuffer[ 0 ] = RF4463_GPIO_NO_CHANGE;
ADD	R2, SP, #4
MOVS	R0, #0
STRB	R0, [R2, #0]
;rf4463pro.c,52 :: 		pcBuffer[ 1 ] = RF4463_GPIO_NO_CHANGE;
ADDS	R1, R2, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;rf4463pro.c,53 :: 		pcBuffer[ 2 ] = RF4463_GPIO_RX_STATE;
ADDS	R1, R2, #2
MOVS	R0, #33
STRB	R0, [R1, #0]
;rf4463pro.c,54 :: 		pcBuffer[ 3 ] = RF4463_GPIO_TX_STATE;
ADDS	R1, R2, #3
MOVS	R0, #32
STRB	R0, [R1, #0]
;rf4463pro.c,55 :: 		pcBuffer[ 4 ] = RF4463_NIRQ_INTERRUPT_SIGNAL;
ADDS	R1, R2, #4
MOVS	R0, #39
STRB	R0, [R1, #0]
;rf4463pro.c,56 :: 		pcBuffer[ 5 ] = RF4463_GPIO_SPI_DATA_OUT;
ADDS	R1, R2, #5
MOVS	R0, #11
STRB	R0, [R1, #0]
;rf4463pro.c,57 :: 		ucRf4463SetCommand( 6, RF4463_CMD_GPIO_PIN_CFG, pcBuffer );
MOVS	R1, #19
MOVS	R0, #6
BL	_ucRf4463SetCommand+0
;rf4463pro.c,58 :: 		memset( pcBuffer, 20, '\0' );
ADD	R0, SP, #4
MOVS	R2, #0
SXTH	R2, R2
MOVS	R1, #20
BL	_memset+0
;rf4463pro.c,63 :: 		pcBuffer[ 0 ] = 98;
ADD	R1, SP, #4
MOVS	R0, #98
STRB	R0, [R1, #0]
;rf4463pro.c,64 :: 		ucRf4463SetProperty( RF4463_PROPERTY_GLOBAL_XO_TUNE, 1, pcBuffer );
MOV	R2, R1
MOVS	R1, #1
MOVS	R0, #0
BL	_ucRf4463SetProperty+0
;rf4463pro.c,65 :: 		memset( pcBuffer, 20, '\0' );
ADD	R0, SP, #4
MOVS	R2, #0
SXTH	R2, R2
MOVS	R1, #20
BL	_memset+0
;rf4463pro.c,70 :: 		pcBuffer[ 0 ] = 0x00;
ADD	R1, SP, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;rf4463pro.c,71 :: 		ucRf4463SetProperty( RF4463_PROPERTY_GLOBAL_CONFIG, 1, pcBuffer );
MOV	R2, R1
MOVS	R1, #1
MOVS	R0, #3
BL	_ucRf4463SetProperty+0
;rf4463pro.c,72 :: 		memset( pcBuffer, 20, '\0' );
ADD	R0, SP, #4
MOVS	R2, #0
SXTH	R2, R2
MOVS	R1, #20
BL	_memset+0
;rf4463pro.c,77 :: 		pcBuffer[ 0 ] = 0x08;
ADD	R2, SP, #4
MOVS	R0, #8
STRB	R0, [R2, #0]
;rf4463pro.c,78 :: 		pcBuffer[ 1 ] = 0x14;
ADDS	R1, R2, #1
MOVS	R0, #20
STRB	R0, [R1, #0]
;rf4463pro.c,79 :: 		pcBuffer[ 2 ] = 0x00;
ADDS	R1, R2, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;rf4463pro.c,80 :: 		pcBuffer[ 3 ] = 0x0F;
ADDS	R1, R2, #3
MOVS	R0, #15
STRB	R0, [R1, #0]
;rf4463pro.c,81 :: 		pcBuffer[ 4 ] = RF4463_PREAMBLE_FIRST_1 | RF4463_PREAMBLE_LENGTH_BYTES | RF4463_PREAMBLE_STANDARD_1010;
ADDS	R1, R2, #4
MOVS	R0, #49
STRB	R0, [R1, #0]
;rf4463pro.c,82 :: 		pcBuffer[ 5 ] = 0x00;
ADDS	R1, R2, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;rf4463pro.c,83 :: 		pcBuffer[ 6 ] = 0x00;
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;rf4463pro.c,84 :: 		pcBuffer[ 7 ] = 0x00;
ADDS	R1, R2, #7
MOVS	R0, #0
STRB	R0, [R1, #0]
;rf4463pro.c,85 :: 		pcBuffer[ 8 ] = 0x00;
ADDW	R1, R2, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;rf4463pro.c,86 :: 		ucRf4463SetProperty( RF4463_PROPERTY_PREAMBLE_TX_LENGTH, 9, pcBuffer );
MOVS	R1, #9
MOVW	R0, #4096
BL	_ucRf4463SetProperty+0
;rf4463pro.c,91 :: 		pcBuffer[ 0 ] = ( xRadioParameters.Network >> 8 );
ADD	R3, SP, #4
MOVW	R2, #lo_addr(_xRadioParameters+6)
MOVT	R2, #hi_addr(_xRadioParameters+6)
LDRH	R0, [R2, #0]
LSRS	R0, R0, #8
STRB	R0, [R3, #0]
;rf4463pro.c,92 :: 		pcBuffer[ 1 ] = ( xRadioParameters.Network );
ADDS	R1, R3, #1
MOV	R0, R2
LDRH	R0, [R0, #0]
STRB	R0, [R1, #0]
;rf4463pro.c,93 :: 		ucRf4463SetSyncWords( pcBuffer, 2 );
MOVS	R1, #2
MOV	R0, R3
BL	_ucRf4463SetSyncWords+0
;rf4463pro.c,98 :: 		pcBuffer[ 0 ] = RF4463_CRC_SEED_ALL_1S | RF4463_CRC_ITU_T;
ADD	R1, SP, #4
MOVS	R0, #129
STRB	R0, [R1, #0]
;rf4463pro.c,99 :: 		ucRf4463SetProperty( RF4463_PROPERTY_PKT_CRC_CONFIG, 1, pcBuffer );
MOV	R2, R1
MOVS	R1, #1
MOVW	R0, #4608
BL	_ucRf4463SetProperty+0
;rf4463pro.c,101 :: 		pcBuffer[ 0 ] = RF4463_CRC_ENDIAN;
ADD	R1, SP, #4
MOVS	R0, #2
STRB	R0, [R1, #0]
;rf4463pro.c,102 :: 		ucRf4463SetProperty( RF4463_PROPERTY_PKT_CONFIG1, 1, pcBuffer );
MOV	R2, R1
MOVS	R1, #1
MOVW	R0, #4614
BL	_ucRf4463SetProperty+0
;rf4463pro.c,104 :: 		pcBuffer[ 0 ] = RF4463_IN_FIFO | RF4463_DST_FIELD_ENUM_2;
ADD	R2, SP, #4
MOVS	R0, #10
STRB	R0, [R2, #0]
;rf4463pro.c,105 :: 		pcBuffer[ 1 ] = RF4463_SRC_FIELD_ENUM_1;
ADDS	R1, R2, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;rf4463pro.c,106 :: 		pcBuffer[ 2 ] = 0x00;
ADDS	R1, R2, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;rf4463pro.c,107 :: 		ucRf4463SetProperty( RF4463_PROPERTY_PKT_LEN, 3, pcBuffer );
MOVS	R1, #3
MOVW	R0, #4616
BL	_ucRf4463SetProperty+0
;rf4463pro.c,112 :: 		pcBuffer[ 0 ] = 0x00;
ADD	R2, SP, #4
MOVS	R0, #0
STRB	R0, [R2, #0]
;rf4463pro.c,113 :: 		pcBuffer[ 1 ] = 0x01;
ADDS	R1, R2, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;rf4463pro.c,114 :: 		pcBuffer[ 2 ] = RF4463_FIELD_CONFIG_PN_START;
ADDS	R1, R2, #2
MOVS	R0, #4
STRB	R0, [R1, #0]
;rf4463pro.c,115 :: 		pcBuffer[ 3 ] = RF4463_FIELD_CONFIG_CRC_START | RF4463_FIELD_CONFIG_SEND_CRC | RF4463_FIELD_CONFIG_CHECK_CRC | RF4463_FIELD_CONFIG_CRC_ENABLE;
ADDS	R1, R2, #3
MOVS	R0, #170
STRB	R0, [R1, #0]
;rf4463pro.c,116 :: 		pcBuffer[ 4 ] = 0x00;
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;rf4463pro.c,117 :: 		pcBuffer[ 5 ] = 50;
ADDS	R1, R2, #5
MOVS	R0, #50
STRB	R0, [R1, #0]
;rf4463pro.c,118 :: 		pcBuffer[ 6 ] = RF4463_FIELD_CONFIG_PN_START;
ADDS	R1, R2, #6
MOVS	R0, #4
STRB	R0, [R1, #0]
;rf4463pro.c,119 :: 		pcBuffer[ 7 ] = RF4463_FIELD_CONFIG_CRC_START | RF4463_FIELD_CONFIG_SEND_CRC | RF4463_FIELD_CONFIG_CHECK_CRC | RF4463_FIELD_CONFIG_CRC_ENABLE;
ADDS	R1, R2, #7
MOVS	R0, #170
STRB	R0, [R1, #0]
;rf4463pro.c,120 :: 		pcBuffer[ 8 ] = 0x00;
ADDW	R1, R2, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;rf4463pro.c,121 :: 		pcBuffer[ 9 ] = 0x00;
ADDW	R1, R2, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;rf4463pro.c,122 :: 		pcBuffer[ 10 ] = 0x00;
ADDW	R1, R2, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;rf4463pro.c,123 :: 		pcBuffer[ 11 ] = 0x00;
ADDW	R1, R2, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;rf4463pro.c,124 :: 		ucRf4463SetProperty( RF4463_PROPERTY_PKT_FIELD_1_LENGTH_12_8, 12, pcBuffer );
MOVS	R1, #12
MOVW	R0, #4621
BL	_ucRf4463SetProperty+0
;rf4463pro.c,126 :: 		pcBuffer[ 0 ] = 0x00;
ADD	R2, SP, #4
MOVS	R0, #0
STRB	R0, [R2, #0]
;rf4463pro.c,127 :: 		pcBuffer[ 1 ] = 0x00;
ADDS	R1, R2, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;rf4463pro.c,128 :: 		pcBuffer[ 2 ] = 0x00;
ADDS	R1, R2, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;rf4463pro.c,129 :: 		pcBuffer[ 3 ] = 0x00;
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;rf4463pro.c,130 :: 		pcBuffer[ 4 ] = 0x00;
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;rf4463pro.c,131 :: 		pcBuffer[ 5 ] = 0x00;
ADDS	R1, R2, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;rf4463pro.c,132 :: 		pcBuffer[ 6 ] = 0x00;
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;rf4463pro.c,133 :: 		pcBuffer[ 7 ] = 0x00;
ADDS	R1, R2, #7
MOVS	R0, #0
STRB	R0, [R1, #0]
;rf4463pro.c,134 :: 		ucRf4463SetProperty( RF4463_PROPERTY_PKT_FIELD_4_LENGTH_12_8, 8, pcBuffer );
MOVS	R1, #8
MOVW	R0, #4633
BL	_ucRf4463SetProperty+0
;rf4463pro.c,139 :: 		pcBuffer[ 0 ] = 0x01;
ADD	R1, SP, #4
MOVS	R0, #1
STRB	R0, [R1, #0]
;rf4463pro.c,140 :: 		ucRf4463SetProperty( RF4463_PROPERTY_MODEM_RSSI_CONTROL, 1, pcBuffer );
MOV	R2, R1
MOVS	R1, #1
MOVW	R0, #8268
BL	_ucRf4463SetProperty+0
;rf4463pro.c,145 :: 		pcBuffer[ 0 ] = 0x01;
ADD	R2, SP, #4
MOVS	R0, #1
STRB	R0, [R2, #0]
;rf4463pro.c,146 :: 		pcBuffer[ 1 ] = 0x38;
ADDS	R1, R2, #1
MOVS	R0, #56
STRB	R0, [R1, #0]
;rf4463pro.c,147 :: 		pcBuffer[ 2 ] = 0x00;
ADDS	R1, R2, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;rf4463pro.c,148 :: 		ucRf4463SetProperty( RF4463_PROPERTY_INT_CTL_ENABLE, 3, pcBuffer );
MOVS	R1, #3
MOVW	R0, #256
BL	_ucRf4463SetProperty+0
;rf4463pro.c,153 :: 		ucRf4463SetTxPower( xRadioParameters.TxPower );
MOVW	R0, #lo_addr(_xRadioParameters+3)
MOVT	R0, #hi_addr(_xRadioParameters+3)
LDRB	R0, [R0, #0]
BL	_ucRf4463SetTxPower+0
;rf4463pro.c,154 :: 		}
L_end_ucRf4463Init:
LDR	LR, [SP, #0]
ADD	SP, SP, #24
BX	LR
; end of _ucRf4463Init
_vRf4463PowerOnReset:
;rf4463pro.c,159 :: 		void vRf4463PowerOnReset(){
SUB	SP, SP, #12
STR	LR, [SP, #0]
;rf4463pro.c,172 :: 		uint8_t pcBuffer[ 7 ] = { RF_POWER_UP };
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
;rf4463pro.c,174 :: 		RF4463nSDN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;rf4463pro.c,175 :: 		Delay_us( 10 );
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_vRf4463PowerOnReset225:
SUBS	R7, R7, #1
BNE	L_vRf4463PowerOnReset225
NOP
NOP
NOP
;rf4463pro.c,176 :: 		RF4463nSDN = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;rf4463pro.c,177 :: 		Delay_ms( 6 );
MOVW	R7, #6463
MOVT	R7, #1
NOP
NOP
L_vRf4463PowerOnReset227:
SUBS	R7, R7, #1
BNE	L_vRf4463PowerOnReset227
NOP
NOP
NOP
;rf4463pro.c,179 :: 		RF4463nSEL = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;rf4463pro.c,180 :: 		vRf4463SPIWriteBuffer( sizeof( pcBuffer ), pcBuffer );
ADD	R0, SP, #4
MOV	R1, R0
MOVS	R0, #7
BL	_vRf4463SPIWriteBuffer+0
;rf4463pro.c,181 :: 		RF4463nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;rf4463pro.c,182 :: 		}
L_end_vRf4463PowerOnReset:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRf4463PowerOnReset
_vRf4463SetConfiguration:
;rf4463pro.c,190 :: 		void vRf4463SetConfiguration( const uint8_t * pcParameters, uint16_t usParametersLength ){
; usParametersLength start address is: 4 (R1)
; pcParameters start address is: 0 (R0)
SUB	SP, SP, #40
STR	LR, [SP, #0]
STRH	R1, [SP, #4]
MOV	R1, R0
LDRH	R0, [SP, #4]
; usParametersLength end address is: 4 (R1)
; pcParameters end address is: 0 (R0)
; pcParameters start address is: 4 (R1)
; usParametersLength start address is: 0 (R0)
;rf4463pro.c,191 :: 		uint8_t ucCommandLength = 0;
;rf4463pro.c,192 :: 		uint8_t ucCommand = 0;
;rf4463pro.c,195 :: 		uint16_t usPosition = 0;
;rf4463pro.c,197 :: 		usParametersLength  = usParametersLength - 1;
SUB	R8, R0, #1
UXTH	R8, R8
; usParametersLength end address is: 0 (R0)
; usParametersLength start address is: 32 (R8)
;rf4463pro.c,198 :: 		ucCommandLength     = pcParameters[ 0 ];
LDRB	R2, [R1, #0]
;rf4463pro.c,199 :: 		usPosition          = ucCommandLength + 1;
ADDS	R0, R2, #1
UXTH	R0, R0
; usPosition start address is: 0 (R0)
; pcParameters end address is: 4 (R1)
; usParametersLength end address is: 32 (R8)
; usPosition end address is: 0 (R0)
MOV	R9, R1
;rf4463pro.c,201 :: 		while( usPosition < usParametersLength ){
L_vRf4463SetConfiguration229:
; usPosition start address is: 0 (R0)
; pcParameters start address is: 36 (R9)
; usParametersLength start address is: 32 (R8)
; pcParameters start address is: 36 (R9)
; pcParameters end address is: 36 (R9)
CMP	R0, R8
IT	CS
BCS	L_vRf4463SetConfiguration230
; pcParameters end address is: 36 (R9)
;rf4463pro.c,202 :: 		ucCommandLength = ( pcParameters[ usPosition++ ] - 1 );
; pcParameters start address is: 36 (R9)
ADD	R2, R9, R0, LSL #0
LDRB	R2, [R2, #0]
SUBS	R4, R2, #1
; ucCommandLength start address is: 40 (R10)
UXTB	R10, R4
ADDS	R3, R0, #1
UXTH	R3, R3
; usPosition end address is: 0 (R0)
;rf4463pro.c,203 :: 		ucCommand = pcParameters[ usPosition++ ];
ADD	R2, R9, R3, LSL #0
LDRB	R2, [R2, #0]
; ucCommand start address is: 24 (R6)
UXTB	R6, R2
ADDS	R2, R3, #1
UXTH	R2, R2
; usPosition start address is: 44 (R11)
UXTH	R11, R2
;rf4463pro.c,204 :: 		memcpy( ( uint8_t * )pcBuffer, pcParameters + usPosition, ucCommandLength );
ADD	R3, R9, R2, LSL #0
ADD	R2, SP, #8
MOV	R1, R3
MOV	R0, R2
UXTB	R2, R4
BL	_memcpy+0
;rf4463pro.c,205 :: 		ucRf4463SetCommand( ucCommandLength, ucCommand, pcBuffer );
ADD	R2, SP, #8
UXTB	R1, R6
; ucCommand end address is: 24 (R6)
UXTB	R0, R10
BL	_ucRf4463SetCommand+0
;rf4463pro.c,206 :: 		usPosition = usPosition + ucCommandLength;
ADD	R2, R11, R10, LSL #0
; ucCommandLength end address is: 40 (R10)
; usPosition end address is: 44 (R11)
; usPosition start address is: 0 (R0)
UXTH	R0, R2
;rf4463pro.c,207 :: 		}
; usParametersLength end address is: 32 (R8)
; pcParameters end address is: 36 (R9)
; usPosition end address is: 0 (R0)
IT	AL
BAL	L_vRf4463SetConfiguration229
L_vRf4463SetConfiguration230:
;rf4463pro.c,208 :: 		}
L_end_vRf4463SetConfiguration:
LDR	LR, [SP, #0]
ADD	SP, SP, #40
BX	LR
; end of _vRf4463SetConfiguration
_ucRf4463SetCommand:
;rf4463pro.c,213 :: 		uint8_t ucRf4463SetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer ){
; pcParametersBuffer start address is: 8 (R2)
; ucCommand start address is: 4 (R1)
; ucLength start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R5, R0
UXTB	R6, R1
MOV	R7, R2
; pcParametersBuffer end address is: 8 (R2)
; ucCommand end address is: 4 (R1)
; ucLength end address is: 0 (R0)
; ucLength start address is: 20 (R5)
; ucCommand start address is: 24 (R6)
; pcParametersBuffer start address is: 28 (R7)
;rf4463pro.c,214 :: 		if( ucRf4463CheckCTS() == NOT_SUCCESS ){
BL	_ucRf4463CheckCTS+0
CMP	R0, #1
IT	NE
BNE	L_ucRf4463SetCommand231
; ucLength end address is: 20 (R5)
; ucCommand end address is: 24 (R6)
; pcParametersBuffer end address is: 28 (R7)
;rf4463pro.c,215 :: 		return NOT_SUCCESS;
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463SetCommand
;rf4463pro.c,216 :: 		}
L_ucRf4463SetCommand231:
;rf4463pro.c,218 :: 		RF4463nSEL = 0;
; pcParametersBuffer start address is: 28 (R7)
; ucCommand start address is: 24 (R6)
; ucLength start address is: 20 (R5)
MOVS	R4, #0
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOB_ODR+0)
MOVT	R3, #hi_addr(GPIOB_ODR+0)
_SX	[R3, ByteOffset(GPIOB_ODR+0)]
;rf4463pro.c,219 :: 		ucRf4463SPIByte( ucCommand );
UXTB	R0, R6
; ucCommand end address is: 24 (R6)
BL	_ucRf4463SPIByte+0
;rf4463pro.c,220 :: 		vRf4463SPIWriteBuffer( ucLength, pcParametersBuffer );
MOV	R1, R7
; pcParametersBuffer end address is: 28 (R7)
UXTB	R0, R5
; ucLength end address is: 20 (R5)
BL	_vRf4463SPIWriteBuffer+0
;rf4463pro.c,221 :: 		RF4463nSEL = 1;
MOVS	R4, #1
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOB_ODR+0)
MOVT	R3, #hi_addr(GPIOB_ODR+0)
_SX	[R3, ByteOffset(GPIOB_ODR+0)]
;rf4463pro.c,223 :: 		return SUCCESS;
MOVS	R0, #0
;rf4463pro.c,224 :: 		}
L_end_ucRf4463SetCommand:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ucRf4463SetCommand
_ucRf4463GetCommand:
;rf4463pro.c,230 :: 		uint8_t ucRf4463GetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer ){
; pcParametersBuffer start address is: 8 (R2)
; ucCommand start address is: 4 (R1)
; ucLength start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R5, R0
UXTB	R6, R1
MOV	R7, R2
; pcParametersBuffer end address is: 8 (R2)
; ucCommand end address is: 4 (R1)
; ucLength end address is: 0 (R0)
; ucLength start address is: 20 (R5)
; ucCommand start address is: 24 (R6)
; pcParametersBuffer start address is: 28 (R7)
;rf4463pro.c,231 :: 		if( ucRf4463CheckCTS() == NOT_SUCCESS ){
BL	_ucRf4463CheckCTS+0
CMP	R0, #1
IT	NE
BNE	L_ucRf4463GetCommand232
; ucLength end address is: 20 (R5)
; ucCommand end address is: 24 (R6)
; pcParametersBuffer end address is: 28 (R7)
;rf4463pro.c,232 :: 		return NOT_SUCCESS;
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463GetCommand
;rf4463pro.c,233 :: 		}
L_ucRf4463GetCommand232:
;rf4463pro.c,235 :: 		RF4463nSEL = 0;
; pcParametersBuffer start address is: 28 (R7)
; ucCommand start address is: 24 (R6)
; ucLength start address is: 20 (R5)
MOVS	R4, #0
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOB_ODR+0)
MOVT	R3, #hi_addr(GPIOB_ODR+0)
_SX	[R3, ByteOffset(GPIOB_ODR+0)]
;rf4463pro.c,236 :: 		ucRf4463SPIByte( ucCommand );
UXTB	R0, R6
; ucCommand end address is: 24 (R6)
BL	_ucRf4463SPIByte+0
;rf4463pro.c,237 :: 		RF4463nSEL = 1;
MOVS	R4, #1
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOB_ODR+0)
MOVT	R3, #hi_addr(GPIOB_ODR+0)
_SX	[R3, ByteOffset(GPIOB_ODR+0)]
;rf4463pro.c,239 :: 		if( ucRf4463CheckCTS() == NOT_SUCCESS ){
BL	_ucRf4463CheckCTS+0
CMP	R0, #1
IT	NE
BNE	L_ucRf4463GetCommand233
; ucLength end address is: 20 (R5)
; pcParametersBuffer end address is: 28 (R7)
;rf4463pro.c,240 :: 		return NOT_SUCCESS;
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463GetCommand
;rf4463pro.c,241 :: 		}
L_ucRf4463GetCommand233:
;rf4463pro.c,243 :: 		RF4463nSEL = 0;
; pcParametersBuffer start address is: 28 (R7)
; ucLength start address is: 20 (R5)
MOVS	R4, #0
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOB_ODR+0)
MOVT	R3, #hi_addr(GPIOB_ODR+0)
_SX	[R3, ByteOffset(GPIOB_ODR+0)]
;rf4463pro.c,244 :: 		ucRf4463SPIByte( RF4463_CMD_READ_BUF );
MOVS	R0, #68
BL	_ucRf4463SPIByte+0
;rf4463pro.c,245 :: 		vRf4463SPIReadBuffer( ucLength, pcParametersBuffer );
MOV	R1, R7
; pcParametersBuffer end address is: 28 (R7)
UXTB	R0, R5
; ucLength end address is: 20 (R5)
BL	_vRf4463SPIReadBuffer+0
;rf4463pro.c,246 :: 		RF4463nSEL = 1;
MOVS	R4, #1
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOB_ODR+0)
MOVT	R3, #hi_addr(GPIOB_ODR+0)
_SX	[R3, ByteOffset(GPIOB_ODR+0)]
;rf4463pro.c,248 :: 		return SUCCESS;
MOVS	R0, #0
;rf4463pro.c,249 :: 		}
L_end_ucRf4463GetCommand:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ucRf4463GetCommand
_ucRf4463SetProperty:
;rf4463pro.c,254 :: 		uint8_t ucRf4463SetProperty( uint16_t usStartProperty, uint8_t ucLength, uint8_t * pcParametersBuffer ){
; pcParametersBuffer start address is: 8 (R2)
; ucLength start address is: 4 (R1)
; usStartProperty start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
UXTH	R6, R0
UXTB	R7, R1
MOV	R8, R2
; pcParametersBuffer end address is: 8 (R2)
; ucLength end address is: 4 (R1)
; usStartProperty end address is: 0 (R0)
; usStartProperty start address is: 24 (R6)
; ucLength start address is: 28 (R7)
; pcParametersBuffer start address is: 32 (R8)
;rf4463pro.c,257 :: 		if( ucRf4463CheckCTS() == NOT_SUCCESS ){
BL	_ucRf4463CheckCTS+0
CMP	R0, #1
IT	NE
BNE	L_ucRf4463SetProperty234
; usStartProperty end address is: 24 (R6)
; ucLength end address is: 28 (R7)
; pcParametersBuffer end address is: 32 (R8)
;rf4463pro.c,258 :: 		return NOT_SUCCESS;
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463SetProperty
;rf4463pro.c,259 :: 		}
L_ucRf4463SetProperty234:
;rf4463pro.c,261 :: 		pcBuffer[ 0 ] = RF4463_CMD_SET_PROPERTY;
; pcParametersBuffer start address is: 32 (R8)
; ucLength start address is: 28 (R7)
; usStartProperty start address is: 24 (R6)
ADD	R5, SP, #4
MOVS	R3, #17
STRB	R3, [R5, #0]
;rf4463pro.c,262 :: 		pcBuffer[ 1 ] = ( usStartProperty >> 8 );
ADDS	R4, R5, #1
LSRS	R3, R6, #8
STRB	R3, [R4, #0]
;rf4463pro.c,263 :: 		pcBuffer[ 2 ] = ucLength;
ADDS	R3, R5, #2
STRB	R7, [R3, #0]
;rf4463pro.c,264 :: 		pcBuffer[ 3 ] = ( usStartProperty & 0xFF );
ADDS	R4, R5, #3
AND	R3, R6, #255
; usStartProperty end address is: 24 (R6)
STRB	R3, [R4, #0]
;rf4463pro.c,266 :: 		RF4463nSEL = 0;
MOVS	R4, #0
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOB_ODR+0)
MOVT	R3, #hi_addr(GPIOB_ODR+0)
_SX	[R3, ByteOffset(GPIOB_ODR+0)]
;rf4463pro.c,267 :: 		vRf4463SPIWriteBuffer( 4, pcBuffer );
MOV	R1, R5
MOVS	R0, #4
BL	_vRf4463SPIWriteBuffer+0
;rf4463pro.c,268 :: 		vRf4463SPIWriteBuffer( ucLength, pcParametersBuffer );
MOV	R1, R8
; pcParametersBuffer end address is: 32 (R8)
UXTB	R0, R7
; ucLength end address is: 28 (R7)
BL	_vRf4463SPIWriteBuffer+0
;rf4463pro.c,269 :: 		RF4463nSEL = 1;
MOVS	R4, #1
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOB_ODR+0)
MOVT	R3, #hi_addr(GPIOB_ODR+0)
_SX	[R3, ByteOffset(GPIOB_ODR+0)]
;rf4463pro.c,271 :: 		return SUCCESS;
MOVS	R0, #0
;rf4463pro.c,272 :: 		}
L_end_ucRf4463SetProperty:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRf4463SetProperty
_ucRf4463GetProperty:
;rf4463pro.c,277 :: 		uint8_t ucRf4463GetProperty( uint16_t usStartProperty, uint8_t ucLength, uint8_t * pcParametersBuffer ){
; pcParametersBuffer start address is: 8 (R2)
; ucLength start address is: 4 (R1)
; usStartProperty start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
UXTH	R6, R0
UXTB	R7, R1
MOV	R8, R2
; pcParametersBuffer end address is: 8 (R2)
; ucLength end address is: 4 (R1)
; usStartProperty end address is: 0 (R0)
; usStartProperty start address is: 24 (R6)
; ucLength start address is: 28 (R7)
; pcParametersBuffer start address is: 32 (R8)
;rf4463pro.c,280 :: 		if( ucRf4463CheckCTS() == NOT_SUCCESS ){
BL	_ucRf4463CheckCTS+0
CMP	R0, #1
IT	NE
BNE	L_ucRf4463GetProperty235
; usStartProperty end address is: 24 (R6)
; ucLength end address is: 28 (R7)
; pcParametersBuffer end address is: 32 (R8)
;rf4463pro.c,281 :: 		return NOT_SUCCESS;
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463GetProperty
;rf4463pro.c,282 :: 		}
L_ucRf4463GetProperty235:
;rf4463pro.c,284 :: 		pcBuffer[ 0 ] = RF4463_CMD_GET_PROPERTY;
; pcParametersBuffer start address is: 32 (R8)
; ucLength start address is: 28 (R7)
; usStartProperty start address is: 24 (R6)
ADD	R5, SP, #4
MOVS	R3, #18
STRB	R3, [R5, #0]
;rf4463pro.c,285 :: 		pcBuffer[ 1 ] = ( usStartProperty >> 8 );
ADDS	R4, R5, #1
LSRS	R3, R6, #8
STRB	R3, [R4, #0]
;rf4463pro.c,286 :: 		pcBuffer[ 2 ] = ucLength;
ADDS	R3, R5, #2
STRB	R7, [R3, #0]
;rf4463pro.c,287 :: 		pcBuffer[ 3 ] = ( usStartProperty & 0xFF );
ADDS	R4, R5, #3
AND	R3, R6, #255
; usStartProperty end address is: 24 (R6)
STRB	R3, [R4, #0]
;rf4463pro.c,289 :: 		RF4463nSEL = 0;
MOVS	R4, #0
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOB_ODR+0)
MOVT	R3, #hi_addr(GPIOB_ODR+0)
_SX	[R3, ByteOffset(GPIOB_ODR+0)]
;rf4463pro.c,290 :: 		vRf4463SPIWriteBuffer( 4, pcBuffer );
MOV	R1, R5
MOVS	R0, #4
BL	_vRf4463SPIWriteBuffer+0
;rf4463pro.c,292 :: 		if( ucRf4463CheckCTS() == NOT_SUCCESS ){
BL	_ucRf4463CheckCTS+0
CMP	R0, #1
IT	NE
BNE	L_ucRf4463GetProperty236
; ucLength end address is: 28 (R7)
; pcParametersBuffer end address is: 32 (R8)
;rf4463pro.c,293 :: 		return NOT_SUCCESS;
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463GetProperty
;rf4463pro.c,294 :: 		}
L_ucRf4463GetProperty236:
;rf4463pro.c,296 :: 		RF4463nSEL = 0;
; pcParametersBuffer start address is: 32 (R8)
; ucLength start address is: 28 (R7)
MOVS	R4, #0
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOB_ODR+0)
MOVT	R3, #hi_addr(GPIOB_ODR+0)
_SX	[R3, ByteOffset(GPIOB_ODR+0)]
;rf4463pro.c,297 :: 		ucRf4463SPIByte( RF4463_CMD_READ_BUF );
MOVS	R0, #68
BL	_ucRf4463SPIByte+0
;rf4463pro.c,298 :: 		vRf4463SPIReadBuffer( ucLength, pcParametersBuffer );
MOV	R1, R8
; pcParametersBuffer end address is: 32 (R8)
UXTB	R0, R7
; ucLength end address is: 28 (R7)
BL	_vRf4463SPIReadBuffer+0
;rf4463pro.c,299 :: 		RF4463nSEL = 1;
MOVS	R4, #1
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOB_ODR+0)
MOVT	R3, #hi_addr(GPIOB_ODR+0)
_SX	[R3, ByteOffset(GPIOB_ODR+0)]
;rf4463pro.c,301 :: 		return SUCCESS;
MOVS	R0, #0
;rf4463pro.c,302 :: 		}
L_end_ucRf4463GetProperty:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRf4463GetProperty
_ucRf4463SetSyncWords:
;rf4463pro.c,307 :: 		uint8_t ucRf4463SetSyncWords( uint8_t * pcSyncWords, uint8_t ucLength ){
; ucLength start address is: 4 (R1)
; pcSyncWords start address is: 0 (R0)
SUB	SP, SP, #16
STR	LR, [SP, #0]
; ucLength end address is: 4 (R1)
; pcSyncWords end address is: 0 (R0)
; pcSyncWords start address is: 0 (R0)
; ucLength start address is: 4 (R1)
;rf4463pro.c,310 :: 		if( ( ucLength == 0 ) || ( ucLength > 3 ) ){
CMP	R1, #0
IT	EQ
BEQ	L__ucRf4463SetSyncWords263
CMP	R1, #3
IT	HI
BHI	L__ucRf4463SetSyncWords262
IT	AL
BAL	L_ucRf4463SetSyncWords239
; pcSyncWords end address is: 0 (R0)
; ucLength end address is: 4 (R1)
L__ucRf4463SetSyncWords263:
L__ucRf4463SetSyncWords262:
;rf4463pro.c,311 :: 		return NOT_SUCCESS;
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463SetSyncWords
;rf4463pro.c,312 :: 		}
L_ucRf4463SetSyncWords239:
;rf4463pro.c,314 :: 		pcBuffer[ 0 ] = ucLength - 1;
; ucLength start address is: 4 (R1)
; pcSyncWords start address is: 0 (R0)
ADD	R3, SP, #8
SUBS	R2, R1, #1
STRB	R2, [R3, #0]
;rf4463pro.c,315 :: 		memcpy( pcBuffer + 1, pcSyncWords, ucLength );
ADDS	R2, R3, #1
STR	R0, [SP, #4]
; ucLength end address is: 4 (R1)
MOV	R0, R2
UXTB	R2, R1
; pcSyncWords end address is: 0 (R0)
LDR	R1, [SP, #4]
BL	_memcpy+0
;rf4463pro.c,316 :: 		return ucRf4463SetProperty( RF4463_PROPERTY_SYNC_CONFIG, sizeof( pcBuffer ), pcBuffer );
ADD	R2, SP, #8
MOVS	R1, #5
MOVW	R0, #4352
BL	_ucRf4463SetProperty+0
;rf4463pro.c,317 :: 		}
L_end_ucRf4463SetSyncWords:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _ucRf4463SetSyncWords
_ucRf4463SetPreambleLength:
;rf4463pro.c,322 :: 		uint8_t ucRf4463SetPreambleLength( uint8_t ucLength ){
SUB	SP, SP, #8
STR	LR, [SP, #0]
STRB	R0, [SP, #4]
;rf4463pro.c,323 :: 		return ucRf4463SetProperty( RF4463_PROPERTY_PREAMBLE_TX_LENGTH, 1, &ucLength );
ADD	R1, SP, #4
MOV	R2, R1
MOVS	R1, #1
MOVW	R0, #4096
BL	_ucRf4463SetProperty+0
;rf4463pro.c,324 :: 		}
L_end_ucRf4463SetPreambleLength:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRf4463SetPreambleLength
_ucRf4463CheckCTS:
;rf4463pro.c,332 :: 		uint8_t ucRf4463CheckCTS(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;rf4463pro.c,333 :: 		uint16_t usTimeoutCounter = 0;
;rf4463pro.c,335 :: 		usTimeoutCounter = RF4463_CTS_TIMEOUT;
; usTimeoutCounter start address is: 8 (R2)
MOVW	R2, #2500
; usTimeoutCounter end address is: 8 (R2)
;rf4463pro.c,337 :: 		while( usTimeoutCounter-- ){
L_ucRf4463CheckCTS240:
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
BEQ	L_ucRf4463CheckCTS241
; usTimeoutCounter end address is: 16 (R4)
;rf4463pro.c,338 :: 		RF4463nSEL = 0;
; usTimeoutCounter start address is: 16 (R4)
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;rf4463pro.c,339 :: 		ucRf4463SPIByte( RF4463_CMD_READ_BUF );
MOVS	R0, #68
BL	_ucRf4463SPIByte+0
;rf4463pro.c,340 :: 		if( ucRf4463SPIByte( RF4463_CMD_READ_BUF ) == RF4463_CTS_REPLY ){
MOVS	R0, #68
BL	_ucRf4463SPIByte+0
CMP	R0, #255
IT	NE
BNE	L_ucRf4463CheckCTS242
; usTimeoutCounter end address is: 16 (R4)
;rf4463pro.c,341 :: 		RF4463nSEL = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;rf4463pro.c,342 :: 		return SUCCESS;
MOVS	R0, #0
IT	AL
BAL	L_end_ucRf4463CheckCTS
;rf4463pro.c,343 :: 		}
L_ucRf4463CheckCTS242:
;rf4463pro.c,344 :: 		RF4463nSEL = 1;
; usTimeoutCounter start address is: 16 (R4)
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;rf4463pro.c,345 :: 		}
UXTH	R2, R4
; usTimeoutCounter end address is: 16 (R4)
IT	AL
BAL	L_ucRf4463CheckCTS240
L_ucRf4463CheckCTS241:
;rf4463pro.c,346 :: 		return NOT_SUCCESS;
MOVS	R0, #1
;rf4463pro.c,347 :: 		}
L_end_ucRf4463CheckCTS:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ucRf4463CheckCTS
_vRf4463RSSI:
;rf4463pro.c,352 :: 		void vRf4463RSSI(){
SUB	SP, SP, #16
STR	LR, [SP, #0]
;rf4463pro.c,385 :: 		ucRf4463GetCommand( 9, RF4463_CMD_GET_MODEM_STATUS , pcRSSI );
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #34
MOVS	R0, #9
BL	_ucRf4463GetCommand+0
;rf4463pro.c,386 :: 		xRSSI = ( ( ( pcRSSI[ 4 ] / 2 ) -64 ) - 60 );
ADD	R0, SP, #4
ADDS	R0, R0, #4
LDRB	R0, [R0, #0]
LSRS	R0, R0, #1
UXTB	R0, R0
SUBS	R0, #64
SXTH	R0, R0
SUBS	R0, #60
;rf4463pro.c,388 :: 		STM_LOGD( "[ RF4463 ] RSSI: %i\r\n", xRSSI );
SXTB	R2, R0
MOVW	R1, #lo_addr(?lstr_81_main+0)
MOVT	R1, #hi_addr(?lstr_81_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,389 :: 		}
L_end_vRf4463RSSI:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _vRf4463RSSI
_ucRf4463DeviceAvailability:
;rf4463pro.c,394 :: 		uint8_t ucRf4463DeviceAvailability(){
SUB	SP, SP, #16
STR	LR, [SP, #0]
;rf4463pro.c,398 :: 		if( ucRf4463GetCommand( 9, RF4463_CMD_PART_INFO, pcBuffer ) == NOT_SUCCESS ){
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #1
MOVS	R0, #9
BL	_ucRf4463GetCommand+0
CMP	R0, #1
IT	NE
BNE	L_ucRf4463DeviceAvailability243
;rf4463pro.c,399 :: 		return NOT_SUCCESS;
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463DeviceAvailability
;rf4463pro.c,400 :: 		}
L_ucRf4463DeviceAvailability243:
;rf4463pro.c,402 :: 		usPartInformation = ( ( pcBuffer[ 2 ] << 8 ) | pcBuffer[ 3 ] );
ADD	R2, SP, #4
ADDS	R0, R2, #2
LDRB	R0, [R0, #0]
LSLS	R1, R0, #8
UXTH	R1, R1
ADDS	R0, R2, #3
LDRB	R0, [R0, #0]
ORRS	R1, R0
UXTH	R1, R1
;rf4463pro.c,404 :: 		if( usPartInformation != 0x4463 ){
MOVW	R0, #17507
CMP	R1, R0
IT	EQ
BEQ	L_ucRf4463DeviceAvailability244
;rf4463pro.c,405 :: 		return NOT_SUCCESS;
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463DeviceAvailability
;rf4463pro.c,406 :: 		}
L_ucRf4463DeviceAvailability244:
;rf4463pro.c,408 :: 		return SUCCESS;
MOVS	R0, #0
;rf4463pro.c,409 :: 		}
L_end_ucRf4463DeviceAvailability:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _ucRf4463DeviceAvailability
_ucRf4463SetGPIOMode:
;rf4463pro.c,417 :: 		uint8_t ucRf4463SetGPIOMode( uint8_t ucGPIO0Mode, uint8_t ucGPIO1Mode ){
; ucGPIO1Mode start address is: 4 (R1)
; ucGPIO0Mode start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
; ucGPIO1Mode end address is: 4 (R1)
; ucGPIO0Mode end address is: 0 (R0)
; ucGPIO0Mode start address is: 0 (R0)
; ucGPIO1Mode start address is: 4 (R1)
;rf4463pro.c,418 :: 		uint8_t pcBuffer[ 6 ] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
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
;rf4463pro.c,420 :: 		pcBuffer[ 0 ] = ucGPIO0Mode;
ADD	R3, SP, #4
STRB	R0, [R3, #0]
; ucGPIO0Mode end address is: 0 (R0)
;rf4463pro.c,421 :: 		pcBuffer[ 1 ] = ucGPIO1Mode;
ADDS	R2, R3, #1
STRB	R1, [R2, #0]
; ucGPIO1Mode end address is: 4 (R1)
;rf4463pro.c,423 :: 		return ucRf4463SetCommand( sizeof( pcBuffer ), RF4463_CMD_GPIO_PIN_CFG, pcBuffer );
MOV	R2, R3
MOVS	R1, #19
MOVS	R0, #6
BL	_ucRf4463SetCommand+0
;rf4463pro.c,424 :: 		}
L_end_ucRf4463SetGPIOMode:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _ucRf4463SetGPIOMode
_vRf4463FIFOReset:
;rf4463pro.c,429 :: 		void vRf4463FIFOReset(){
SUB	SP, SP, #8
STR	LR, [SP, #0]
;rf4463pro.c,430 :: 		uint8_t ucData = 0x03;
MOVS	R0, #3
STRB	R0, [SP, #4]
;rf4463pro.c,432 :: 		ucRf4463SetCommand( sizeof( ucData ), RF4463_CMD_FIFO_INFO, &ucData );
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #21
MOVS	R0, #1
BL	_ucRf4463SetCommand+0
;rf4463pro.c,433 :: 		}
L_end_vRf4463FIFOReset:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vRf4463FIFOReset
_ucRf4463ClearInterrupts:
;rf4463pro.c,438 :: 		uint8_t ucRf4463ClearInterrupts(){
SUB	SP, SP, #8
STR	LR, [SP, #0]
;rf4463pro.c,439 :: 		uint8_t pcBuffer[] = { 0x00, 0x00, 0x00 };
MOVS	R0, #0
STRB	R0, [SP, #4]
MOVS	R0, #0
STRB	R0, [SP, #5]
MOVS	R0, #0
STRB	R0, [SP, #6]
;rf4463pro.c,441 :: 		return ucRf4463SetCommand( sizeof( pcBuffer ), RF4463_CMD_GET_INT_STATUS, pcBuffer );
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #32
MOVS	R0, #3
BL	_ucRf4463SetCommand+0
;rf4463pro.c,442 :: 		}
L_end_ucRf4463ClearInterrupts:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRf4463ClearInterrupts
_ucRf4463EnterStandbyMode:
;rf4463pro.c,447 :: 		uint8_t ucRf4463EnterStandbyMode(){
SUB	SP, SP, #8
STR	LR, [SP, #0]
;rf4463pro.c,448 :: 		uint8_t ucData = 0x01;
MOVS	R0, #1
STRB	R0, [SP, #4]
;rf4463pro.c,450 :: 		return ucRf4463SetCommand( 1, RF4463_CMD_CHANGE_STATE, &ucData );
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #52
MOVS	R0, #1
BL	_ucRf4463SetCommand+0
;rf4463pro.c,451 :: 		}
L_end_ucRf4463EnterStandbyMode:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRf4463EnterStandbyMode
_ucRf4463EnterReadyMode:
;rf4463pro.c,456 :: 		uint8_t ucRf4463EnterReadyMode(){
SUB	SP, SP, #8
STR	LR, [SP, #0]
;rf4463pro.c,457 :: 		uint8_t ucData = 0x03;
MOVS	R0, #3
STRB	R0, [SP, #4]
;rf4463pro.c,459 :: 		return ucRf4463SetCommand( 1, RF4463_CMD_CHANGE_STATE, &ucData );
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #52
MOVS	R0, #1
BL	_ucRf4463SetCommand+0
;rf4463pro.c,460 :: 		}
L_end_ucRf4463EnterReadyMode:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRf4463EnterReadyMode
_ucRf4463WaitnIRQ:
;rf4463pro.c,465 :: 		uint8_t ucRf4463WaitnIRQ(){
SUB	SP, SP, #4
;rf4463pro.c,466 :: 		return RF4463nIRQ;
MOVW	R0, #lo_addr(GPIOC_IDR+0)
MOVT	R0, #hi_addr(GPIOC_IDR+0)
_LX	[R0, ByteOffset(GPIOC_IDR+0)]
;rf4463pro.c,467 :: 		}
L_end_ucRf4463WaitnIRQ:
ADD	SP, SP, #4
BX	LR
; end of _ucRf4463WaitnIRQ
_vRf4463EnterTxMode:
;rf4463pro.c,475 :: 		void vRf4463EnterTxMode(){
SUB	SP, SP, #8
STR	LR, [SP, #0]
;rf4463pro.c,476 :: 		uint8_t pcBuffer[] = { 0x00, 0x30, 0x00, 0x00 };
MOVS	R0, #0
STRB	R0, [SP, #4]
MOVS	R0, #48
STRB	R0, [SP, #5]
MOVS	R0, #0
STRB	R0, [SP, #6]
MOVS	R0, #0
STRB	R0, [SP, #7]
;rf4463pro.c,477 :: 		pcBuffer[ 0 ] = xRadioParameters.Channel;
ADD	R1, SP, #4
MOVW	R0, #lo_addr(_xRadioParameters+2)
MOVT	R0, #hi_addr(_xRadioParameters+2)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;rf4463pro.c,478 :: 		ucRf4463SetCommand( 4, RF4463_CMD_START_TX, pcBuffer );
MOV	R2, R1
MOVS	R1, #49
MOVS	R0, #4
BL	_ucRf4463SetCommand+0
;rf4463pro.c,479 :: 		}
L_end_vRf4463EnterTxMode:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vRf4463EnterTxMode
_ucRf4463SetTxInterrupt:
;rf4463pro.c,484 :: 		uint8_t ucRf4463SetTxInterrupt(){
SUB	SP, SP, #8
STR	LR, [SP, #0]
;rf4463pro.c,485 :: 		uint8_t pcBuffer[ 3 ] = { 0x01, 0x20, 0x00 };
MOVS	R0, #1
STRB	R0, [SP, #4]
MOVS	R0, #32
STRB	R0, [SP, #5]
MOVS	R0, #0
STRB	R0, [SP, #6]
;rf4463pro.c,486 :: 		return ucRf4463SetProperty( RF4463_PROPERTY_INT_CTL_ENABLE, 3, pcBuffer );
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #3
MOVW	R0, #256
BL	_ucRf4463SetProperty+0
;rf4463pro.c,487 :: 		}
L_end_ucRf4463SetTxInterrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRf4463SetTxInterrupt
_ucRf4463SetTxPower:
;rf4463pro.c,492 :: 		uint8_t ucRf4463SetTxPower( uint8_t ucPower ){
; ucPower start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
UXTB	R9, R0
; ucPower end address is: 0 (R0)
; ucPower start address is: 36 (R9)
;rf4463pro.c,493 :: 		uint8_t pcBuffer[] = { 0x08, 0x00, 0x00, 0x3D };
MOVS	R1, #8
STRB	R1, [SP, #4]
MOVS	R1, #0
STRB	R1, [SP, #5]
MOVS	R1, #0
STRB	R1, [SP, #6]
MOVS	R1, #61
STRB	R1, [SP, #7]
;rf4463pro.c,495 :: 		if( ucPower > 127 ){
CMP	R9, #127
IT	LS
BLS	L__ucRf4463SetTxPower279
;rf4463pro.c,496 :: 		STM_LOGE( "[ Rf4463 ] Invalid Power Value: %d\r\n", ucPower );
MOVW	R2, #lo_addr(?lstr_82_main+0)
MOVT	R2, #hi_addr(?lstr_82_main+0)
MOVW	R1, #lo_addr(_vDebugPrint+0)
MOVT	R1, #hi_addr(_vDebugPrint+0)
PUSH	36
; ucPower end address is: 36 (R9)
PUSH	(R2)
PUSH	(R1)
BL	_PrintOut+0
ADD	SP, SP, #12
;rf4463pro.c,497 :: 		ucPower = 127;
; ucPower start address is: 0 (R0)
MOVS	R0, #127
; ucPower end address is: 0 (R0)
;rf4463pro.c,498 :: 		}
IT	AL
BAL	L_ucRf4463SetTxPower245
L__ucRf4463SetTxPower279:
;rf4463pro.c,495 :: 		if( ucPower > 127 ){
UXTB	R0, R9
;rf4463pro.c,498 :: 		}
L_ucRf4463SetTxPower245:
;rf4463pro.c,500 :: 		pcBuffer[ 1 ] = ucPower;
; ucPower start address is: 0 (R0)
ADD	R2, SP, #4
ADDS	R1, R2, #1
STRB	R0, [R1, #0]
; ucPower end address is: 0 (R0)
;rf4463pro.c,502 :: 		return ucRf4463SetProperty( RF4463_PROPERTY_PA_MODE, sizeof( pcBuffer ), pcBuffer );
MOVS	R1, #4
MOVW	R0, #8704
BL	_ucRf4463SetProperty+0
;rf4463pro.c,503 :: 		}
L_end_ucRf4463SetTxPower:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRf4463SetTxPower
_vRf4463WriteTxFIFO:
;rf4463pro.c,509 :: 		void vRf4463WriteTxFIFO( uint8_t * pcWriteBuffer, uint8_t ucLength ){
; pcWriteBuffer start address is: 0 (R0)
SUB	SP, SP, #76
STR	LR, [SP, #0]
MOV	R9, R0
STRB	R1, [SP, #72]
; pcWriteBuffer end address is: 0 (R0)
; pcWriteBuffer start address is: 36 (R9)
;rf4463pro.c,513 :: 		ucRf4463SetProperty( RF4463_PROPERTY_PKT_FIELD_2_LENGTH_7_0, 1, &ucLength );
ADD	R2, SP, #72
MOVS	R1, #1
MOVW	R0, #4626
BL	_ucRf4463SetProperty+0
;rf4463pro.c,515 :: 		pcBuffer[ 0 ] = ucLength;
ADD	R3, SP, #4
LDRB	R2, [SP, #72]
STRB	R2, [R3, #0]
;rf4463pro.c,517 :: 		memcpy( pcBuffer + 1, pcWriteBuffer, ucLength );
ADDS	R2, R3, #1
MOV	R1, R9
MOV	R0, R2
; pcWriteBuffer end address is: 36 (R9)
LDRB	R2, [SP, #72]
BL	_memcpy+0
;rf4463pro.c,519 :: 		ucRf4463SetCommand( ucLength + 1, RF4463_CMD_TX_FIFO_WRITE, pcBuffer );
ADD	R3, SP, #4
LDRB	R2, [SP, #72]
ADDS	R2, R2, #1
MOVS	R1, #102
UXTB	R0, R2
MOV	R2, R3
BL	_ucRf4463SetCommand+0
;rf4463pro.c,520 :: 		}
L_end_vRf4463WriteTxFIFO:
LDR	LR, [SP, #0]
ADD	SP, SP, #76
BX	LR
; end of _vRf4463WriteTxFIFO
_ucRf4463TxPacket:
;rf4463pro.c,525 :: 		uint8_t ucRf4463TxPacket( uint8_t * pcTxBuffer, uint8_t ucTxLength ){
; ucTxLength start address is: 4 (R1)
; pcTxBuffer start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
MOV	R8, R0
UXTB	R9, R1
; ucTxLength end address is: 4 (R1)
; pcTxBuffer end address is: 0 (R0)
; pcTxBuffer start address is: 32 (R8)
; ucTxLength start address is: 36 (R9)
;rf4463pro.c,528 :: 		ucRF4463TxEvent = 0;
MOVS	R3, #0
MOVW	R2, #lo_addr(_ucRF4463TxEvent+0)
MOVT	R2, #hi_addr(_ucRF4463TxEvent+0)
STRB	R3, [R2, #0]
;rf4463pro.c,530 :: 		vRf4463FIFOReset();
BL	_vRf4463FIFOReset+0
;rf4463pro.c,532 :: 		vRf4463WriteTxFIFO( pcTxBuffer, ucTxLength );
UXTB	R1, R9
; ucTxLength end address is: 36 (R9)
MOV	R0, R8
; pcTxBuffer end address is: 32 (R8)
BL	_vRf4463WriteTxFIFO+0
;rf4463pro.c,534 :: 		ucRf4463ClearInterrupts();
BL	_ucRf4463ClearInterrupts+0
;rf4463pro.c,536 :: 		vRf4463EnterTxMode();
BL	_vRf4463EnterTxMode+0
;rf4463pro.c,538 :: 		ucRF4463TxEvent = 1;
MOVS	R3, #1
MOVW	R2, #lo_addr(_ucRF4463TxEvent+0)
MOVT	R2, #hi_addr(_ucRF4463TxEvent+0)
STRB	R3, [R2, #0]
;rf4463pro.c,540 :: 		for( ;; ){
L_ucRf4463TxPacket246:
;rf4463pro.c,541 :: 		if( ucRadioEvent == 1 ){
MOVW	R2, #lo_addr(_ucRadioEvent+0)
MOVT	R2, #hi_addr(_ucRadioEvent+0)
LDRB	R2, [R2, #0]
CMP	R2, #1
IT	NE
BNE	L_ucRf4463TxPacket249
;rf4463pro.c,542 :: 		break;
IT	AL
BAL	L_ucRf4463TxPacket247
;rf4463pro.c,543 :: 		}
L_ucRf4463TxPacket249:
;rf4463pro.c,544 :: 		Delay_us( 1 );
MOVW	R7, #11
MOVT	R7, #0
NOP
NOP
L_ucRf4463TxPacket250:
SUBS	R7, R7, #1
BNE	L_ucRf4463TxPacket250
NOP
NOP
NOP
;rf4463pro.c,545 :: 		}
IT	AL
BAL	L_ucRf4463TxPacket246
L_ucRf4463TxPacket247:
;rf4463pro.c,547 :: 		ucRf4463GetCommand( 3, RF4463_CMD_REQUEST_DEVICE_STATE, pcBuffer );
ADD	R2, SP, #4
MOVS	R1, #51
MOVS	R0, #3
BL	_ucRf4463GetCommand+0
;rf4463pro.c,549 :: 		return SUCCESS;
MOVS	R0, #0
;rf4463pro.c,550 :: 		}
L_end_ucRf4463TxPacket:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRf4463TxPacket
_vRf4463EnterRxMode:
;rf4463pro.c,559 :: 		void vRf4463EnterRxMode(){
SUB	SP, SP, #12
STR	LR, [SP, #0]
;rf4463pro.c,560 :: 		uint8_t pcBuffer[] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x08 };
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
MOVS	R0, #3
STRB	R0, [SP, #9]
MOVS	R0, #8
STRB	R0, [SP, #10]
;rf4463pro.c,561 :: 		pcBuffer[ 0 ] = xRadioParameters.Channel;
ADD	R1, SP, #4
MOVW	R0, #lo_addr(_xRadioParameters+2)
MOVT	R0, #hi_addr(_xRadioParameters+2)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;rf4463pro.c,562 :: 		ucRf4463SetCommand( 7, RF4463_CMD_START_RX, pcBuffer );
MOV	R2, R1
MOVS	R1, #50
MOVS	R0, #7
BL	_ucRf4463SetCommand+0
;rf4463pro.c,563 :: 		}
L_end_vRf4463EnterRxMode:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRf4463EnterRxMode
_ucRf4463SetRxInterrupt:
;rf4463pro.c,568 :: 		uint8_t ucRf4463SetRxInterrupt(){
SUB	SP, SP, #8
STR	LR, [SP, #0]
;rf4463pro.c,569 :: 		uint8_t pcBuffer[ 3 ] = { 0x03, 0x18, 0x00 };
MOVS	R0, #3
STRB	R0, [SP, #4]
MOVS	R0, #24
STRB	R0, [SP, #5]
MOVS	R0, #0
STRB	R0, [SP, #6]
;rf4463pro.c,570 :: 		return ucRf4463SetProperty( RF4463_PROPERTY_INT_CTL_ENABLE, 3, pcBuffer );
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #3
MOVW	R0, #256
BL	_ucRf4463SetProperty+0
;rf4463pro.c,571 :: 		}
L_end_ucRf4463SetRxInterrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRf4463SetRxInterrupt
_ucRf4463RxInit:
;rf4463pro.c,576 :: 		uint8_t ucRf4463RxInit(){
SUB	SP, SP, #8
STR	LR, [SP, #0]
;rf4463pro.c,577 :: 		uint8_t ucLength = 0;
MOVS	R0, #0
STRB	R0, [SP, #4]
;rf4463pro.c,579 :: 		ucLength = 66;
MOVS	R0, #66
STRB	R0, [SP, #4]
;rf4463pro.c,581 :: 		ucRf4463SetProperty( RF4463_PROPERTY_PKT_FIELD_2_LENGTH_7_0, 1, &ucLength );
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #1
MOVW	R0, #4626
BL	_ucRf4463SetProperty+0
;rf4463pro.c,583 :: 		vRf4463FIFOReset();
BL	_vRf4463FIFOReset+0
;rf4463pro.c,587 :: 		vRf4463EnterRxMode();
BL	_vRf4463EnterRxMode+0
;rf4463pro.c,589 :: 		return SUCCESS;
MOVS	R0, #0
;rf4463pro.c,590 :: 		}
L_end_ucRf4463RxInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRf4463RxInit
_ucRf4463RxPacket:
;rf4463pro.c,595 :: 		uint8_t ucRf4463RxPacket( uint8_t * pcRxBuffer ){
; pcRxBuffer start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; pcRxBuffer end address is: 0 (R0)
; pcRxBuffer start address is: 0 (R0)
;rf4463pro.c,596 :: 		uint8_t ucRxLength = 0;
; ucRxLength start address is: 32 (R8)
MOVW	R8, #0
;rf4463pro.c,598 :: 		vRf4463ReadRxFIFO( pcRxBuffer );
; pcRxBuffer end address is: 0 (R0)
BL	_vRf4463ReadRxFIFO+0
;rf4463pro.c,600 :: 		vRf4463FIFOReset();
BL	_vRf4463FIFOReset+0
;rf4463pro.c,602 :: 		return ucRxLength;
UXTB	R0, R8
; ucRxLength end address is: 32 (R8)
;rf4463pro.c,603 :: 		}
L_end_ucRf4463RxPacket:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ucRf4463RxPacket
_vRf4463ReadRxFIFO:
;rf4463pro.c,608 :: 		void vRf4463ReadRxFIFO( uint8_t * pcBuffer ){
; pcBuffer start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
MOV	R7, R0
; pcBuffer end address is: 0 (R0)
; pcBuffer start address is: 28 (R7)
;rf4463pro.c,611 :: 		if( ucRf4463CheckCTS() == NOT_SUCCESS ){
BL	_ucRf4463CheckCTS+0
CMP	R0, #1
IT	NE
BNE	L_vRf4463ReadRxFIFO252
; pcBuffer end address is: 28 (R7)
;rf4463pro.c,612 :: 		return;
IT	AL
BAL	L_end_vRf4463ReadRxFIFO
;rf4463pro.c,613 :: 		}
L_vRf4463ReadRxFIFO252:
;rf4463pro.c,615 :: 		RF4463nSEL = 0;
; pcBuffer start address is: 28 (R7)
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
_SX	[R1, ByteOffset(GPIOB_ODR+0)]
;rf4463pro.c,617 :: 		ucRf4463SPIByte( RF4463_CMD_RX_FIFO_READ );
MOVS	R0, #119
BL	_ucRf4463SPIByte+0
;rf4463pro.c,618 :: 		vRf4463SPIReadBuffer( 1, ( uint8_t * )&pcReadLength );
ADD	R1, SP, #4
MOVS	R0, #1
BL	_vRf4463SPIReadBuffer+0
;rf4463pro.c,619 :: 		vRf4463SPIReadBuffer( 66, pcBuffer );
MOV	R1, R7
; pcBuffer end address is: 28 (R7)
MOVS	R0, #66
BL	_vRf4463SPIReadBuffer+0
;rf4463pro.c,621 :: 		RF4463nSEL = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
_SX	[R1, ByteOffset(GPIOB_ODR+0)]
;rf4463pro.c,623 :: 		return;
;rf4463pro.c,624 :: 		}
L_end_vRf4463ReadRxFIFO:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vRf4463ReadRxFIFO
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
L_vRf4463SPIWriteBuffer253:
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
BEQ	L_vRf4463SPIWriteBuffer254
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
BAL	L_vRf4463SPIWriteBuffer253
L_vRf4463SPIWriteBuffer254:
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
L_vRf4463SPIReadBuffer255:
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
BEQ	L_vRf4463SPIReadBuffer256
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
BAL	L_vRf4463SPIReadBuffer255
L_vRf4463SPIReadBuffer256:
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
BEQ	L_vButtonISR257
;buttonhandler.c,39 :: 		EXTI_PR.B8 |= 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_SX	[R0, ByteOffset(EXTI_PR+0)]
;buttonhandler.c,42 :: 		}
L_vButtonISR257:
;buttonhandler.c,43 :: 		}
L_end_vButtonISR:
BX	LR
; end of _vButtonISR
_vButtonSetup:
;buttonhandler.c,51 :: 		void vButtonSetup(){
SUB	SP, SP, #4
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
;buttonhandler.c,71 :: 		}
L_end_vButtonSetup:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
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
SUB	SP, SP, #4
; ucTimer end address is: 0 (R0)
; ucTimer start address is: 0 (R0)
;timer.c,50 :: 		if( ucTimer == TIMER_SEARCH ){
CMP	R0, #0
IT	NE
BNE	L_vTimerStop258
; ucTimer end address is: 0 (R0)
;timer.c,51 :: 		TIM6_CR1.CEN = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(TIM6_CR1+0)
MOVT	R1, #hi_addr(TIM6_CR1+0)
_SX	[R1, ByteOffset(TIM6_CR1+0)]
;timer.c,52 :: 		}
L_vTimerStop258:
;timer.c,53 :: 		}
L_end_vTimerStop:
ADD	SP, SP, #4
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
SUB	SP, SP, #4
;main.c,67 :: 		Delay_ms( 1000 );
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_main259:
SUBS	R7, R7, #1
BNE	L_main259
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
MOVW	R1, #lo_addr(?lstr_83_main+0)
MOVT	R1, #hi_addr(?lstr_83_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
;main.c,88 :: 		vRadioInit();
BL	_vRadioInit+0
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
;main.c,97 :: 		vDongleLoop();
BL	_vDongleLoop+0
;main.c,98 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
