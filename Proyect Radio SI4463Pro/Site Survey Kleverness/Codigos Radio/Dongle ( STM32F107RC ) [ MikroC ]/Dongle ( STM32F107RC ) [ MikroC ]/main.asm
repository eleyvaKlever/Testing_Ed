_vDongleLoop:
SUB	SP, SP, #4
STR	LR, [SP, #0]
BL	_vUARTRxInit+0
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
L_vDongleLoop0:
MOVW	R0, #lo_addr(_ucUARTDataReady+0)
MOVT	R0, #hi_addr(_ucUARTDataReady+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_vDongleLoop2
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucUARTDataReady+0)
MOVT	R0, #hi_addr(_ucUARTDataReady+0)
STRB	R1, [R0, #0]
BL	_vUARTRxMessage+0
L_vDongleLoop2:
BL	_ucRF4463GetIRQFlag+0
CMP	R0, #1
IT	NE
BNE	L_vDongleLoop3
BL	_vRF4463MesageHandler+0
BL	_vRF4463ResetIRQFlag+0
L_vDongleLoop3:
IT	AL
BAL	L_vDongleLoop0
L_end_vDongleLoop:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vDongleLoop
_vUARTISR:
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_LX	[R0, ByteOffset(GPIOC_ODR+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
MOVW	R0, #lo_addr(USART1_SRbits+0)
MOVT	R0, #hi_addr(USART1_SRbits+0)
_LX	[R0, ByteOffset(USART1_SRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUARTISR4
MOVW	R0, #lo_addr(USART1_DR+0)
MOVT	R0, #hi_addr(USART1_DR+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucTempByteUART+0)
MOVT	R0, #hi_addr(_ucTempByteUART+0)
STRB	R1, [R0, #0]
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	NE
BNE	L_vUARTISR5
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
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucUARTDataReady+0)
MOVT	R0, #hi_addr(_ucUARTDataReady+0)
STRB	R1, [R0, #0]
MOVS	R0, #0
STRB	R0, [R2, #0]
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
IT	AL
BAL	L_vUARTISR6
L_vUARTISR5:
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
MOVS	R0, #0
STRB	R0, [R1, #0]
L_vUARTISR6:
L_vUARTISR4:
MOVW	R0, #lo_addr(USART1_SRbits+0)
MOVT	R0, #hi_addr(USART1_SRbits+0)
_LX	[R0, ByteOffset(USART1_SRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vUARTISR7
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_32_main+0)
MOVT	R1, #hi_addr(?lstr_32_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
MOVW	R0, #lo_addr(USART1_SR+0)
MOVT	R0, #hi_addr(USART1_SR+0)
LDR	R0, [R0, #0]
MOVW	R1, #lo_addr(_ucTempByteUART+0)
MOVT	R1, #hi_addr(_ucTempByteUART+0)
STRB	R0, [R1, #0]
MOVW	R0, #lo_addr(USART1_DR+0)
MOVT	R0, #hi_addr(USART1_DR+0)
LDR	R0, [R0, #0]
STRB	R0, [R1, #0]
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
L_vUARTISR7:
L_end_vUARTISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUARTISR
_vUARTTxInit:
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOVW	R0, #lo_addr(__GPIO_MODULE_USART1_PA9_10+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_USART1_PA9_10+0)
PUSH	(R0)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
MOV	R0, #921600
BL	_UART1_Init_Advanced+0
ADD	SP, SP, #4
L_end_vUARTTxInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUARTTxInit
_vUARTRxInit:
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(USART1_CR1bits+0)
MOVT	R0, #hi_addr(USART1_CR1bits+0)
_SX	[R0, ByteOffset(USART1_CR1bits+0)]
MOVW	R0, #lo_addr(USART1_CR1bits+0)
MOVT	R0, #hi_addr(USART1_CR1bits+0)
_SX	[R0, ByteOffset(USART1_CR1bits+0)]
MOVW	R0, #53
BL	_NVIC_IntEnable+0
L_end_vUARTRxInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUARTRxInit
_vUARTRxMessage:
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOVW	R2, #lo_addr(_pcRxUARTBuffer+0)
MOVT	R2, #hi_addr(_pcRxUARTBuffer+0)
MOVW	R1, #lo_addr(?lstr_33_main+0)
MOVT	R1, #hi_addr(?lstr_33_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
MOVW	R0, #lo_addr(_pcRxUARTBuffer+0)
MOVT	R0, #hi_addr(_pcRxUARTBuffer+0)
BL	_vUARTCommands+0
MOVW	R2, #2048
SXTH	R2, R2
MOVS	R1, #0
MOVW	R0, #lo_addr(_pcRxUARTBuffer+0)
MOVT	R0, #hi_addr(_pcRxUARTBuffer+0)
BL	_memset+0
MOVS	R1, #0
MOVW	R0, #lo_addr(_usUARTMessageLength+0)
MOVT	R0, #hi_addr(_usUARTMessageLength+0)
STRH	R1, [R0, #0]
L_end_vUARTRxMessage:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUARTRxMessage
_vUARTCommands:
SUB	SP, SP, #84
STR	LR, [SP, #0]
STR	R0, [SP, #68]
MOVS	R1, #0
STRB	R1, [SP, #67]
MOVS	R1, #0
STRB	R1, [SP, #72]
L_vUARTCommands8:
LDRB	R1, [SP, #72]
CMP	R1, #20
IT	CS
BCS	L_vUARTCommands9
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
IT	AL
BAL	L_vUARTCommands12
L_vUARTCommands14:
ADD	R11, SP, #58
ADD	R10, R11, #9
MOVW	R12, #lo_addr(?ICS?lstr34_main+0)
MOVT	R12, #hi_addr(?ICS?lstr34_main+0)
BL	___CC2DW+0
ADD	R1, SP, #58
MOV	R0, R1
BL	_UART1_Write_Text+0
MOVS	R1, #100
MOVW	R0, #1000
BL	_Sound_Play+0
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
MOVS	R1, #100
MOVW	R0, #1000
BL	_Sound_Play+0
IT	AL
BAL	L_vUARTCommands13
L_vUARTCommands17:
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
MOVS	R1, #5
MOVS	R0, #5
BL	_vRf4463SetChannels+0
MOVS	R0, #5
BL	_vRf4463SetNetwork+0
ADD	R1, SP, #8
MOVS	R2, #50
SXTH	R2, R2
MOV	R0, R1
MOVS	R1, #0
BL	_memset+0
; ucPosition start address is: 12 (R3)
MOVS	R3, #5
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
LDR	R1, [SP, #68]
ADDS	R1, R1, R3
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands339
LDR	R1, [SP, #68]
ADDS	R1, R1, R3
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands338
IT	AL
BAL	L_vUARTCommands23
; ucPosition end address is: 12 (R3)
L__vUARTCommands339:
L__vUARTCommands338:
IT	AL
BAL	L_vUARTCommands19
L_vUARTCommands23:
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
ADDS	R1, R0, #1
; ucCounter end address is: 0 (R0)
; ucCounter start address is: 4 (R1)
UXTB	R3, R2
; ucPosition end address is: 8 (R2)
; ucCounter end address is: 4 (R1)
UXTB	R0, R1
IT	AL
BAL	L_vUARTCommands18
L_vUARTCommands19:
; ucCounter start address is: 0 (R0)
STRB	R0, [SP, #4]
MOVS	R0, #254
BL	_vRF4463SetNode+0
LDRB	R0, [SP, #4]
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
IT	AL
BAL	L_vUARTCommands13
L_vUARTCommands24:
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
MOVS	R2, #15
SXTH	R2, R2
MOVS	R1, #0
MOVW	R0, #lo_addr(main_pcSentQR+0)
MOVT	R0, #hi_addr(main_pcSentQR+0)
BL	_memset+0
; ucPosition start address is: 12 (R3)
MOVS	R3, #6
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
LDR	R1, [SP, #68]
ADDS	R1, R1, R3
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands341
LDR	R1, [SP, #68]
ADDS	R1, R1, R3
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands340
IT	AL
BAL	L_vUARTCommands30
; ucPosition end address is: 12 (R3)
L__vUARTCommands341:
L__vUARTCommands340:
IT	AL
BAL	L_vUARTCommands26
L_vUARTCommands30:
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
ADDS	R1, R0, #1
UXTB	R1, R1
; ucCounter end address is: 0 (R0)
; ucCounter start address is: 4 (R1)
UXTB	R3, R2
; ucPosition end address is: 8 (R2)
; ucCounter end address is: 4 (R1)
UXTB	R0, R1
IT	AL
BAL	L_vUARTCommands25
L_vUARTCommands26:
; ucCounter start address is: 0 (R0)
STRB	R0, [SP, #4]
MOVS	R0, #254
BL	_vRF4463SetNode+0
LDRB	R0, [SP, #4]
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
IT	AL
BAL	L_vUARTCommands13
L_vUARTCommands31:
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
MOVS	R1, #5
MOVS	R0, #5
BL	_vRf4463SetChannels+0
MOVS	R0, #5
BL	_vRf4463SetNetwork+0
MOVS	R0, #254
BL	_vRF4463SetNode+0
MOVS	R1, #4
PUSH	(R1)
MOVS	R3, #1
MOVS	R2, #255
MOVS	R1, #0
MOVS	R0, #0
BL	_vRF4463TxMessage+0
ADD	SP, SP, #4
IT	AL
BAL	L_vUARTCommands13
L_vUARTCommands32:
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
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
_SX	[R1, ByteOffset(GPIOC_ODR+0)]
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
_SX	[R1, ByteOffset(GPIOC_ODR+0)]
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
_SX	[R1, ByteOffset(GPIOC_ODR+0)]
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
BL	_SystemReset+0
IT	AL
BAL	L_vUARTCommands13
L_vUARTCommands35:
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
MOVS	R0, #1
BL	_vRF4463SetNode+0
MOVS	R1, #0
PUSH	(R1)
MOVS	R3, #1
MOVS	R2, #2
MOVS	R1, #0
MOVS	R0, #0
BL	_vRF4463TxMessage+0
ADD	SP, SP, #4
IT	AL
BAL	L_vUARTCommands13
L_vUARTCommands36:
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
ADD	R1, SP, #8
MOVS	R2, #50
SXTH	R2, R2
MOV	R0, R1
MOVS	R1, #0
BL	_memset+0
; ucPosition start address is: 28 (R7)
MOVS	R7, #5
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
MOVW	R1, #lo_addr(_pcTempQR+0)
MOVT	R1, #hi_addr(_pcTempQR+0)
ADDS	R2, R1, R0
ADDS	R1, R3, R0
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
ADDS	R1, R0, #1
UXTB	R1, R1
; ucCounter end address is: 0 (R0)
; ucCounter start address is: 4 (R1)
UXTB	R4, R7
; ucPosition end address is: 28 (R7)
; ucCounter end address is: 4 (R1)
UXTB	R0, R1
IT	AL
BAL	L_vUARTCommands37
L_vUARTCommands38:
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
IT	AL
BAL	L_vUARTCommands41
L_vUARTCommands43:
MOVW	R2, #lo_addr(_ucSearchedModelId+0)
MOVT	R2, #hi_addr(_ucSearchedModelId+0)
LDRB	R1, [R2, #0]
ADDS	R1, R1, #1
STRB	R1, [R2, #0]
IT	AL
BAL	L_vUARTCommands40
L_vUARTCommands41:
MOVS	R0, #1
BL	_vRF4463SetNode+0
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
IT	AL
BAL	L_vUARTCommands13
L_vUARTCommands44:
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
ADD	R1, SP, #8
MOVS	R2, #50
SXTH	R2, R2
MOV	R0, R1
MOVS	R1, #0
BL	_memset+0
; ucPosition start address is: 28 (R7)
MOVS	R7, #7
; ucCounter start address is: 0 (R0)
MOVS	R0, #0
; ucPosition end address is: 28 (R7)
; ucCounter end address is: 0 (R0)
UXTB	R3, R7
L_vUARTCommands45:
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 12 (R3)
LDR	R1, [SP, #68]
ADDS	R1, R1, R3
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands343
LDR	R1, [SP, #68]
ADDS	R1, R1, R3
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands342
IT	AL
BAL	L_vUARTCommands50
; ucCounter end address is: 0 (R0)
; ucPosition end address is: 12 (R3)
L__vUARTCommands343:
L__vUARTCommands342:
IT	AL
BAL	L_vUARTCommands46
L_vUARTCommands50:
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
ADDS	R1, R0, #1
UXTB	R1, R1
; ucCounter end address is: 0 (R0)
; ucCounter start address is: 4 (R1)
UXTB	R3, R7
; ucPosition end address is: 28 (R7)
; ucCounter end address is: 4 (R1)
UXTB	R0, R1
IT	AL
BAL	L_vUARTCommands45
L_vUARTCommands46:
ADD	R1, SP, #8
MOV	R0, R1
BL	_atoi+0
; usTempData start address is: 8 (R2)
UXTH	R2, R0
MOVS	R0, #1
BL	_vRF4463SetNode+0
MOVS	R1, #5
PUSH	(R1)
MOVS	R3, #2
UXTB	R2, R2
; usTempData end address is: 8 (R2)
MOVS	R1, #0
MOVS	R0, #0
BL	_vRF4463TxMessage+0
ADD	SP, SP, #4
IT	AL
BAL	L_vUARTCommands13
L_vUARTCommands51:
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
ADD	R1, SP, #8
MOVS	R2, #50
SXTH	R2, R2
MOV	R0, R1
MOVS	R1, #0
BL	_memset+0
; ucPosition start address is: 8 (R2)
MOVS	R2, #8
STRB	R2, [SP, #4]
BL	_ucRf4463EnterStandbyMode+0
LDRB	R2, [SP, #4]
; ucCounter start address is: 0 (R0)
MOVS	R0, #0
; ucCounter end address is: 0 (R0)
; ucPosition end address is: 8 (R2)
UXTB	R7, R2
L_vUARTCommands52:
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 28 (R7)
LDR	R1, [SP, #68]
ADDS	R1, R1, R7
LDRB	R1, [R1, #0]
CMP	R1, #44
IT	NE
BNE	L_vUARTCommands55
; ucCounter end address is: 0 (R0)
ADDS	R1, R7, #1
; ucPosition end address is: 28 (R7)
; ucPosition start address is: 0 (R0)
UXTB	R0, R1
UXTB	R8, R0
; ucPosition end address is: 0 (R0)
IT	AL
BAL	L_vUARTCommands53
L_vUARTCommands55:
; ucCounter start address is: 0 (R0)
; ucPosition start address is: 28 (R7)
LDR	R1, [SP, #68]
ADDS	R1, R1, R7
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands345
LDR	R1, [SP, #68]
ADDS	R1, R1, R7
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands344
IT	AL
BAL	L_vUARTCommands58
; ucCounter end address is: 0 (R0)
L__vUARTCommands345:
L__vUARTCommands344:
MOVS	R1, #1
STRB	R1, [SP, #67]
UXTB	R8, R7
IT	AL
BAL	L_vUARTCommands53
L_vUARTCommands58:
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
ADDS	R1, R0, #1
UXTB	R1, R1
; ucCounter end address is: 0 (R0)
; ucCounter start address is: 4 (R1)
UXTB	R7, R2
; ucPosition end address is: 8 (R2)
; ucCounter end address is: 4 (R1)
UXTB	R0, R1
IT	AL
BAL	L_vUARTCommands52
L_vUARTCommands53:
; ucPosition start address is: 32 (R8)
ADD	R1, SP, #8
MOV	R0, R1
BL	_atoi+0
; usTempChannel start address is: 8 (R2)
UXTH	R2, R0
LDRB	R1, [SP, #67]
CMP	R1, #0
IT	NE
BNE	L_vUARTCommands59
; ucCounter start address is: 0 (R0)
MOVS	R0, #0
; ucPosition end address is: 32 (R8)
; usTempChannel end address is: 8 (R2)
; ucCounter end address is: 0 (R0)
UXTB	R3, R8
UXTH	R7, R2
L_vUARTCommands60:
; ucCounter start address is: 0 (R0)
; usTempChannel start address is: 28 (R7)
; ucPosition start address is: 12 (R3)
LDR	R1, [SP, #68]
ADDS	R1, R1, R3
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BEQ	L__vUARTCommands347
LDR	R1, [SP, #68]
ADDS	R1, R1, R3
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BEQ	L__vUARTCommands346
IT	AL
BAL	L_vUARTCommands65
; ucCounter end address is: 0 (R0)
; ucPosition end address is: 12 (R3)
L__vUARTCommands347:
L__vUARTCommands346:
IT	AL
BAL	L_vUARTCommands61
L_vUARTCommands65:
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
ADDS	R1, R0, #1
UXTB	R1, R1
; ucCounter end address is: 0 (R0)
; ucCounter start address is: 4 (R1)
UXTB	R3, R6
; ucPosition end address is: 24 (R6)
; ucCounter end address is: 4 (R1)
UXTB	R0, R1
IT	AL
BAL	L_vUARTCommands60
L_vUARTCommands61:
ADD	R1, SP, #8
MOV	R0, R1
BL	_atoi+0
STRH	R0, [SP, #74]
UXTB	R1, R7
UXTB	R0, R7
; usTempChannel end address is: 28 (R7)
BL	_vRf4463SetChannels+0
LDRH	R0, [SP, #74]
BL	_vRf4463SetNetwork+0
IT	AL
BAL	L_vUARTCommands66
L_vUARTCommands59:
; usTempChannel start address is: 8 (R2)
STRH	R2, [SP, #4]
UXTB	R1, R2
UXTB	R0, R2
BL	_vRf4463SetChannels+0
LDRH	R2, [SP, #4]
UXTH	R0, R2
; usTempChannel end address is: 8 (R2)
BL	_vRf4463SetNetwork+0
L_vUARTCommands66:
BL	_ucRf4463RxInit+0
IT	AL
BAL	L_vUARTCommands13
L_vUARTCommands67:
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
IT	AL
BAL	L_vUARTCommands13
L_vUARTCommands68:
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
MOVS	R0, #254
BL	_vRF4463SetNode+0
MOVS	R1, #200
PUSH	(R1)
MOVS	R3, #1
MOVS	R2, #254
MOVS	R1, #0
MOVS	R0, #0
BL	_vRF4463TxMessage+0
ADD	SP, SP, #4
IT	AL
BAL	L_vUARTCommands13
L_vUARTCommands69:
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
IT	AL
BAL	L_vUARTCommands13
L_vUARTCommands70:
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
IT	AL
BAL	L_vUARTCommands13
L_vUARTCommands71:
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
IT	AL
BAL	L_vUARTCommands13
L_vUARTCommands72:
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
MOVS	R0, #254
BL	_vRF4463SetNode+0
MOVS	R1, #11
PUSH	(R1)
MOVS	R3, #2
MOVS	R2, #255
MOVS	R1, #0
MOVS	R0, #0
BL	_vRF4463TxMessage+0
ADD	SP, SP, #4
L_vUARTCommands73:
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
MOVS	R0, #1
BL	_vRF4463SetNode+0
MOVS	R1, #6
PUSH	(R1)
MOVS	R3, #1
MOVS	R2, #255
MOVS	R1, #0
MOVS	R0, #0
BL	_vRF4463TxMessage+0
ADD	SP, SP, #4
IT	AL
BAL	L_vUARTCommands13
L_vUARTCommands74:
IT	AL
BAL	L_vUARTCommands13
L_vUARTCommands75:
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
IT	AL
BAL	L_vUARTCommands13
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
IT	AL
BAL	L_vUARTCommands75
L_vUARTCommands13:
L_vUARTCommands11:
LDRB	R1, [SP, #72]
ADDS	R1, R1, #1
STRB	R1, [SP, #72]
IT	AL
BAL	L_vUARTCommands8
L_vUARTCommands9:
L_end_vUARTCommands:
LDR	LR, [SP, #0]
ADD	SP, SP, #84
BX	LR
; end of _vUARTCommands
_vDebugInit:
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOVW	R0, #lo_addr(__GPIO_MODULE_USART1_PA9_10+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_USART1_PA9_10+0)
PUSH	(R0)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
MOV	R0, #115200
BL	_UART1_Init_Advanced+0
ADD	SP, SP, #4
L_end_vDebugInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vDebugInit
_vDebugPrint:
; ucPrintData start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; ucPrintData end address is: 0 (R0)
; ucPrintData start address is: 0 (R0)
; ucPrintData end address is: 0 (R0)
BL	_UART1_Write+0
L_end_vDebugPrint:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vDebugPrint
_ucASCIIToByte:
; pcASCIIBuffer start address is: 0 (R0)
SUB	SP, SP, #4
; pcASCIIBuffer end address is: 0 (R0)
; pcASCIIBuffer start address is: 0 (R0)
MOVS	R1, #0
MOVW	R3, #lo_addr(_ucMSBNibble+0)
MOVT	R3, #hi_addr(_ucMSBNibble+0)
STRB	R1, [R3, #0]
MOVS	R2, #0
MOVW	R1, #lo_addr(_ucLSBNibble+0)
MOVT	R1, #hi_addr(_ucLSBNibble+0)
STRB	R2, [R1, #0]
LDRB	R1, [R0, #0]
SUBS	R1, #48
STRB	R1, [R3, #0]
UXTB	R1, R1
CMP	R1, #9
IT	LS
BLS	L_ucASCIIToByte76
MOVW	R2, #lo_addr(_ucMSBNibble+0)
MOVT	R2, #hi_addr(_ucMSBNibble+0)
LDRB	R1, [R2, #0]
SUBS	R1, R1, #7
STRB	R1, [R2, #0]
L_ucASCIIToByte76:
ADDS	R1, R0, #1
; pcASCIIBuffer end address is: 0 (R0)
LDRB	R1, [R1, #0]
SUBW	R2, R1, #48
MOVW	R1, #lo_addr(_ucLSBNibble+0)
MOVT	R1, #hi_addr(_ucLSBNibble+0)
STRB	R2, [R1, #0]
UXTB	R1, R2
CMP	R1, #9
IT	LS
BLS	L_ucASCIIToByte77
MOVW	R2, #lo_addr(_ucLSBNibble+0)
MOVT	R2, #hi_addr(_ucLSBNibble+0)
LDRB	R1, [R2, #0]
SUBS	R1, R1, #7
STRB	R1, [R2, #0]
L_ucASCIIToByte77:
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
L_end_ucASCIIToByte:
ADD	SP, SP, #4
BX	LR
; end of _ucASCIIToByte
_vASCIIToHex:
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
; ucASCIICounter start address is: 24 (R6)
MOVS	R6, #0
; pcHexConvertBuffer end address is: 0 (R0)
; ucConversionLength end address is: 8 (R2)
; ucASCIICounter end address is: 24 (R6)
STRB	R2, [SP, #0]
MOV	R2, R0
LDRB	R0, [SP, #0]
L_vASCIIToHex78:
; ucASCIICounter start address is: 24 (R6)
; pcHexConvertBuffer start address is: 8 (R2)
; ucConversionLength start address is: 0 (R0)
; pcASCIIConvertBuffer start address is: 4 (R1)
; pcASCIIConvertBuffer end address is: 4 (R1)
; pcHexConvertBuffer start address is: 8 (R2)
; pcHexConvertBuffer end address is: 8 (R2)
CMP	R6, R0
IT	CS
BCS	L_vASCIIToHex79
; pcASCIIConvertBuffer end address is: 4 (R1)
; pcHexConvertBuffer end address is: 8 (R2)
; pcHexConvertBuffer start address is: 8 (R2)
; pcASCIIConvertBuffer start address is: 4 (R1)
MOVS	R3, #0
MOVW	R5, #lo_addr(_ucMSBNibble+0)
MOVT	R5, #hi_addr(_ucMSBNibble+0)
STRB	R3, [R5, #0]
MOVS	R4, #0
MOVW	R3, #lo_addr(_ucLSBNibble+0)
MOVT	R3, #hi_addr(_ucLSBNibble+0)
STRB	R4, [R3, #0]
LSLS	R3, R6, #1
SXTH	R3, R3
ADDS	R3, R1, R3
LDRB	R3, [R3, #0]
SUBS	R3, #48
STRB	R3, [R5, #0]
UXTB	R3, R3
CMP	R3, #9
IT	LS
BLS	L_vASCIIToHex81
MOVW	R4, #lo_addr(_ucMSBNibble+0)
MOVT	R4, #hi_addr(_ucMSBNibble+0)
LDRB	R3, [R4, #0]
SUBS	R3, R3, #7
STRB	R3, [R4, #0]
L_vASCIIToHex81:
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
UXTB	R3, R4
CMP	R3, #9
IT	LS
BLS	L_vASCIIToHex82
MOVW	R4, #lo_addr(_ucLSBNibble+0)
MOVT	R4, #hi_addr(_ucLSBNibble+0)
LDRB	R3, [R4, #0]
SUBS	R3, R3, #7
STRB	R3, [R4, #0]
L_vASCIIToHex82:
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
ADDS	R6, R6, #1
UXTB	R6, R6
; ucConversionLength end address is: 0 (R0)
; pcASCIIConvertBuffer end address is: 4 (R1)
; pcHexConvertBuffer end address is: 8 (R2)
; ucASCIICounter end address is: 24 (R6)
IT	AL
BAL	L_vASCIIToHex78
L_vASCIIToHex79:
L_end_vASCIIToHex:
ADD	SP, SP, #4
BX	LR
; end of _vASCIIToHex
_vHexToASCII:
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
L_vHexToASCII83:
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
BCS	L_vHexToASCII84
; pcHexConvertBuffer end address is: 4 (R1)
; pcASCIIConvertBuffer end address is: 8 (R2)
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
ADDS	R6, R6, #1
UXTB	R6, R6
; ucConversionLength end address is: 0 (R0)
; pcHexConvertBuffer end address is: 4 (R1)
; pcASCIIConvertBuffer end address is: 8 (R2)
; ucHexConvCounter end address is: 24 (R6)
IT	AL
BAL	L_vHexToASCII83
L_vHexToASCII84:
L_end_vHexToASCII:
ADD	SP, SP, #4
BX	LR
; end of _vHexToASCII
_vBufferSetToZero:
; uslength start address is: 4 (R1)
; pcBufferToClean start address is: 0 (R0)
SUB	SP, SP, #4
; uslength end address is: 4 (R1)
; pcBufferToClean end address is: 0 (R0)
; pcBufferToClean start address is: 0 (R0)
; uslength start address is: 4 (R1)
; usPosition start address is: 16 (R4)
MOVS	R4, #0
; pcBufferToClean end address is: 0 (R0)
; uslength end address is: 4 (R1)
; usPosition end address is: 16 (R4)
STRH	R1, [SP, #0]
MOV	R1, R0
LDRH	R0, [SP, #0]
L_vBufferSetToZero86:
; usPosition start address is: 16 (R4)
; pcBufferToClean start address is: 4 (R1)
; uslength start address is: 0 (R0)
; pcBufferToClean start address is: 4 (R1)
; pcBufferToClean end address is: 4 (R1)
CMP	R4, R0
IT	CS
BCS	L_vBufferSetToZero87
; pcBufferToClean end address is: 4 (R1)
; pcBufferToClean start address is: 4 (R1)
ADDS	R3, R1, R4
MOVS	R2, #0
STRB	R2, [R3, #0]
ADDS	R4, R4, #1
UXTH	R4, R4
; uslength end address is: 0 (R0)
; pcBufferToClean end address is: 4 (R1)
; usPosition end address is: 16 (R4)
IT	AL
BAL	L_vBufferSetToZero86
L_vBufferSetToZero87:
L_end_vBufferSetToZero:
ADD	SP, SP, #4
BX	LR
; end of _vBufferSetToZero
_vBufferSetTo255:
; uslength start address is: 4 (R1)
; pcBufferToClean start address is: 0 (R0)
SUB	SP, SP, #4
; uslength end address is: 4 (R1)
; pcBufferToClean end address is: 0 (R0)
; pcBufferToClean start address is: 0 (R0)
; uslength start address is: 4 (R1)
; usPosition start address is: 16 (R4)
MOVS	R4, #0
; pcBufferToClean end address is: 0 (R0)
; uslength end address is: 4 (R1)
; usPosition end address is: 16 (R4)
STRH	R1, [SP, #0]
MOV	R1, R0
LDRH	R0, [SP, #0]
L_vBufferSetTo25589:
; usPosition start address is: 16 (R4)
; pcBufferToClean start address is: 4 (R1)
; uslength start address is: 0 (R0)
; pcBufferToClean start address is: 4 (R1)
; pcBufferToClean end address is: 4 (R1)
CMP	R4, R0
IT	CS
BCS	L_vBufferSetTo25590
; pcBufferToClean end address is: 4 (R1)
; pcBufferToClean start address is: 4 (R1)
ADDS	R3, R1, R4
MOVS	R2, #255
STRB	R2, [R3, #0]
ADDS	R4, R4, #1
UXTH	R4, R4
; uslength end address is: 0 (R0)
; pcBufferToClean end address is: 4 (R1)
; usPosition end address is: 16 (R4)
IT	AL
BAL	L_vBufferSetTo25589
L_vBufferSetTo25590:
L_end_vBufferSetTo255:
ADD	SP, SP, #4
BX	LR
; end of _vBufferSetTo255
_vBufferSetToValue:
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
L_vBufferSetToValue92:
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
BCS	L_vBufferSetToValue93
; ucValue end address is: 4 (R1)
; pcBufferToClean end address is: 8 (R2)
; pcBufferToClean start address is: 8 (R2)
; ucValue start address is: 4 (R1)
ADDS	R3, R2, R4
STRB	R1, [R3, #0]
ADDS	R4, R4, #1
UXTH	R4, R4
; uslength end address is: 0 (R0)
; ucValue end address is: 4 (R1)
; pcBufferToClean end address is: 8 (R2)
; usPosition end address is: 16 (R4)
IT	AL
BAL	L_vBufferSetToValue92
L_vBufferSetToValue93:
L_end_vBufferSetToValue:
ADD	SP, SP, #4
BX	LR
; end of _vBufferSetToValue
_vSerializeUUID:
; pcHexConvertBuffer start address is: 4 (R1)
; pcTextConvertBuffer start address is: 0 (R0)
SUB	SP, SP, #4
; pcHexConvertBuffer end address is: 4 (R1)
; pcTextConvertBuffer end address is: 0 (R0)
; pcTextConvertBuffer start address is: 0 (R0)
; pcHexConvertBuffer start address is: 4 (R1)
; ucCounter start address is: 20 (R5)
MOVS	R5, #0
; pcTextConvertBuffer end address is: 0 (R0)
; pcHexConvertBuffer end address is: 4 (R1)
; ucCounter end address is: 20 (R5)
STR	R1, [SP, #0]
MOV	R1, R0
LDR	R0, [SP, #0]
L_vSerializeUUID95:
; ucCounter start address is: 20 (R5)
; pcTextConvertBuffer start address is: 4 (R1)
; pcHexConvertBuffer start address is: 0 (R0)
; pcHexConvertBuffer start address is: 0 (R0)
; pcHexConvertBuffer end address is: 0 (R0)
; pcTextConvertBuffer start address is: 4 (R1)
; pcTextConvertBuffer end address is: 4 (R1)
CMP	R5, #12
IT	CS
BCS	L_vSerializeUUID96
; pcHexConvertBuffer end address is: 0 (R0)
; pcTextConvertBuffer end address is: 4 (R1)
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
ADDS	R5, R5, #1
UXTB	R5, R5
; pcHexConvertBuffer end address is: 0 (R0)
; pcTextConvertBuffer end address is: 4 (R1)
; ucCounter end address is: 20 (R5)
IT	AL
BAL	L_vSerializeUUID95
L_vSerializeUUID96:
L_end_vSerializeUUID:
ADD	SP, SP, #4
BX	LR
; end of _vSerializeUUID
_vSerializeMACAddress:
; pcHexConvertBuffer start address is: 4 (R1)
; pcTextConvertBuffer start address is: 0 (R0)
SUB	SP, SP, #16
STR	LR, [SP, #0]
MOV	R7, R0
; pcHexConvertBuffer end address is: 4 (R1)
; pcTextConvertBuffer end address is: 0 (R0)
; pcTextConvertBuffer start address is: 28 (R7)
; pcHexConvertBuffer start address is: 4 (R1)
ADD	R2, SP, #4
MOV	R0, R2
; pcHexConvertBuffer end address is: 4 (R1)
MOVS	R2, #6
BL	_vHexToASCII+0
; usCounter start address is: 4 (R1)
MOVS	R1, #0
; pcTextConvertBuffer end address is: 28 (R7)
; usCounter end address is: 4 (R1)
MOV	R0, R7
L_vSerializeMACAddress98:
; usCounter start address is: 4 (R1)
; pcTextConvertBuffer start address is: 0 (R0)
CMP	R1, #6
IT	CS
BCS	L_vSerializeMACAddress99
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
CMP	R1, #5
IT	EQ
BEQ	L_vSerializeMACAddress101
MOVS	R2, #3
MULS	R2, R1, R2
UXTH	R2, R2
ADDS	R2, R2, #2
UXTH	R2, R2
ADDS	R3, R0, R2
MOVS	R2, #58
STRB	R2, [R3, #0]
L_vSerializeMACAddress101:
ADDS	R1, R1, #1
UXTH	R1, R1
; usCounter end address is: 4 (R1)
IT	AL
BAL	L_vSerializeMACAddress98
L_vSerializeMACAddress99:
ADDW	R3, R0, #18
; pcTextConvertBuffer end address is: 0 (R0)
MOVS	R2, #0
STRB	R2, [R3, #0]
L_end_vSerializeMACAddress:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _vSerializeMACAddress
_vSerializeIPAddress:
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
MOVS	R2, #4
SXTH	R2, R2
MOVS	R1, #0
MOV	R0, R8
BL	_memset+0
; ucCounter start address is: 28 (R7)
MOVS	R7, #0
; ucCounter end address is: 28 (R7)
L_vSerializeIPAddress102:
; ucCounter start address is: 28 (R7)
; pcHexConvertBuffer start address is: 24 (R6)
; pcHexConvertBuffer end address is: 24 (R6)
; pcTextConvertBuffer start address is: 32 (R8)
; pcTextConvertBuffer end address is: 32 (R8)
CMP	R7, #4
IT	CS
BCS	L_vSerializeIPAddress103
; pcHexConvertBuffer end address is: 24 (R6)
; pcTextConvertBuffer end address is: 32 (R8)
; pcTextConvertBuffer start address is: 32 (R8)
; pcHexConvertBuffer start address is: 24 (R6)
ADD	R3, SP, #4
ADDS	R2, R6, R7
LDRB	R2, [R2, #0]
MOV	R1, R3
UXTB	R0, R2
BL	_ByteToStr+0
ADD	R2, SP, #4
MOV	R0, R2
BL	_Ltrim+0
MOV	R1, R0
MOV	R0, R8
BL	_strcat+0
CMP	R7, #3
IT	EQ
BEQ	L_vSerializeIPAddress105
MOVS	R2, #46
STRB	R2, [SP, #11]
MOVS	R2, #0
STRB	R2, [SP, #12]
ADD	R2, SP, #11
MOV	R1, R2
MOV	R0, R8
BL	_strcat+0
L_vSerializeIPAddress105:
ADDS	R7, R7, #1
UXTB	R7, R7
; pcHexConvertBuffer end address is: 24 (R6)
; pcTextConvertBuffer end address is: 32 (R8)
; ucCounter end address is: 28 (R7)
IT	AL
BAL	L_vSerializeIPAddress102
L_vSerializeIPAddress103:
L_end_vSerializeIPAddress:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _vSerializeIPAddress
_vXORRFMessage:
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
; ucKeyPosition start address is: 28 (R7)
MOVS	R7, #0
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
L_vXORRFMessage106:
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
BCS	L_vXORRFMessage107
; pcXORBuffer end address is: 4 (R1)
; pcBuffer end address is: 8 (R2)
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
ADDS	R6, R6, #1
UXTB	R6, R6
; ucBufferSize end address is: 0 (R0)
; pcXORBuffer end address is: 4 (R1)
; pcBuffer end address is: 8 (R2)
; ucKeyPosition end address is: 28 (R7)
; ucBufferPosition end address is: 24 (R6)
IT	AL
BAL	L_vXORRFMessage106
L_vXORRFMessage107:
L_end_vXORRFMessage:
ADD	SP, SP, #4
BX	LR
; end of _vXORRFMessage
_vW25Q128JVInit:
SUB	SP, SP, #4
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
_SX	[R0, ByteOffset(GPIOA_ODR+0)]
L_end_vW25Q128JVInit:
ADD	SP, SP, #4
BX	LR
; end of _vW25Q128JVInit
_vFlashWriteEnable:
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
_SX	[R1, ByteOffset(GPIOA_ODR+0)]
MOVS	R0, #6
BL	_SPI1_Write+0
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
_SX	[R1, ByteOffset(GPIOA_ODR+0)]
L_end_vFlashWriteEnable:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vFlashWriteEnable
_ucFlashIsWriteBusy:
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
_SX	[R1, ByteOffset(GPIOA_ODR+0)]
MOVS	R0, #5
BL	_SPI1_Write+0
MOVS	R0, #0
BL	_SPI1_Read+0
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
_SX	[R1, ByteOffset(GPIOA_ODR+0)]
UXTB	R1, R0
AND	R1, R1, #1
UXTB	R0, R1
L_end_ucFlashIsWriteBusy:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ucFlashIsWriteBusy
_vFlashWriteByte:
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
UXTB	R0, R5
BL	_vFlashWriteEnable+0
MOVS	R4, #0
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOA_ODR+0)
MOVT	R3, #hi_addr(GPIOA_ODR+0)
_SX	[R3, ByteOffset(GPIOA_ODR+0)]
MOVS	R0, #2
BL	_SPI1_Write+0
ADD	R3, SP, #4
ADDS	R3, R3, #2
LDRB	R3, [R3, #0]
UXTH	R0, R3
BL	_SPI1_Write+0
ADD	R3, SP, #4
ADDS	R3, R3, #1
LDRB	R3, [R3, #0]
UXTH	R0, R3
BL	_SPI1_Write+0
ADD	R3, SP, #4
LDRB	R3, [R3, #0]
UXTH	R0, R3
BL	_SPI1_Write+0
UXTB	R0, R6
; pcData end address is: 24 (R6)
BL	_SPI1_Write+0
MOVS	R4, #1
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOA_ODR+0)
MOVT	R3, #hi_addr(GPIOA_ODR+0)
_SX	[R3, ByteOffset(GPIOA_ODR+0)]
; ucMemorySelected end address is: 20 (R5)
UXTB	R4, R5
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
L_end_vFlashWriteByte:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vFlashWriteByte
_vFlashWriteWord:
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
ADD	R3, SP, #4
ADDS	R3, R3, #1
LDRB	R3, [R3, #0]
MOV	R2, R8
UXTB	R1, R3
UXTB	R0, R7
BL	_vFlashWriteByte+0
ADD	R4, R8, #1
; ulMemoryAddress end address is: 32 (R8)
ADD	R3, SP, #4
LDRB	R3, [R3, #0]
MOV	R2, R4
UXTB	R1, R3
UXTB	R0, R7
; ucMemorySelected end address is: 28 (R7)
BL	_vFlashWriteByte+0
L_end_vFlashWriteWord:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vFlashWriteWord
_ucFlashWriteArray:
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
; ulFlashAddress start address is: 48 (R12)
MOV	R12, R3
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
ADD	R4, R8, R11, LSL #0
LDRB	R4, [R4, #0]
MOV	R2, R12
UXTB	R1, R4
UXTB	R0, R9
BL	_vFlashWriteByte+0
ADD	R12, R12, #1
ADD	R11, R11, #1
UXTH	R11, R11
; ulFlashAddress end address is: 48 (R12)
; usBufferCounter end address is: 44 (R11)
IT	AL
BAL	L_ucFlashWriteArray111
L_ucFlashWriteArray112:
MOVS	R0, #13
BL	_UART1_Write+0
MOVS	R0, #10
BL	_UART1_Write+0
; ulFlashAddress start address is: 0 (R0)
MOV	R0, R10
; ulMemoryAddress end address is: 40 (R10)
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
; pcData start address is: 24 (R6)
; ucMemorySelected start address is: 20 (R5)
MOV	R1, R9
UXTB	R0, R5
BL	_ucFlashReadByte+0
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
MOVS	R0, #0
IT	AL
BAL	L_end_ucFlashWriteArray
L_ucFlashWriteArray117:
; usBufferCounter start address is: 32 (R8)
; ulFlashAddress start address is: 36 (R9)
; usBufferLength start address is: 28 (R7)
; pcData start address is: 24 (R6)
; ucMemorySelected start address is: 20 (R5)
ADD	R9, R9, #1
ADD	R8, R8, #1
UXTH	R8, R8
; ucMemorySelected end address is: 20 (R5)
; pcData end address is: 24 (R6)
; usBufferLength end address is: 28 (R7)
; ulFlashAddress end address is: 36 (R9)
; usBufferCounter end address is: 32 (R8)
IT	AL
BAL	L_ucFlashWriteArray114
L_ucFlashWriteArray115:
MOVS	R0, #13
BL	_UART1_Write+0
MOVS	R0, #10
BL	_UART1_Write+0
MOVS	R0, #1
L_end_ucFlashWriteArray:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ucFlashWriteArray
_ucFlashReadByte:
SUB	SP, SP, #8
STR	LR, [SP, #0]
STR	R1, [SP, #4]
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOA_ODR+0)
MOVT	R2, #hi_addr(GPIOA_ODR+0)
_SX	[R2, ByteOffset(GPIOA_ODR+0)]
MOVS	R0, #3
BL	_SPI1_Write+0
ADD	R2, SP, #4
ADDS	R2, R2, #2
LDRB	R2, [R2, #0]
UXTH	R0, R2
BL	_SPI1_Write+0
ADD	R2, SP, #4
ADDS	R2, R2, #1
LDRB	R2, [R2, #0]
UXTH	R0, R2
BL	_SPI1_Write+0
ADD	R2, SP, #4
LDRB	R2, [R2, #0]
UXTH	R0, R2
BL	_SPI1_Write+0
MOVS	R0, #0
BL	_SPI1_Read+0
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOA_ODR+0)
MOVT	R2, #hi_addr(GPIOA_ODR+0)
_SX	[R2, ByteOffset(GPIOA_ODR+0)]
UXTB	R0, R0
L_end_ucFlashReadByte:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucFlashReadByte
_usFlashReadWord:
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
MOVW	R2, #0
STRH	R2, [SP, #4]
ADD	R2, SP, #4
ADDS	R2, R2, #1
STR	R2, [SP, #8]
MOV	R1, R5
UXTB	R0, R4
BL	_ucFlashReadByte+0
LDR	R2, [SP, #8]
STRB	R0, [R2, #0]
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
LDRH	R0, [SP, #4]
L_end_usFlashReadWord:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _usFlashReadWord
_vFlashReadArray:
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
MOVS	R5, #0
SXTB	R5, R5
MOVW	R4, #lo_addr(GPIOA_ODR+0)
MOVT	R4, #hi_addr(GPIOA_ODR+0)
_SX	[R4, ByteOffset(GPIOA_ODR+0)]
MOVS	R0, #3
BL	_SPI1_Write+0
ADD	R4, SP, #4
ADDS	R4, R4, #2
LDRB	R4, [R4, #0]
UXTH	R0, R4
BL	_SPI1_Write+0
ADD	R4, SP, #4
ADDS	R4, R4, #1
LDRB	R4, [R4, #0]
UXTH	R0, R4
BL	_SPI1_Write+0
ADD	R4, SP, #4
LDRB	R4, [R4, #0]
UXTH	R0, R4
BL	_SPI1_Write+0
; pcReceiverBuffer end address is: 24 (R6)
; usBufferLength end address is: 28 (R7)
UXTH	R0, R7
MOV	R7, R6
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
; usBufferLength start address is: 24 (R6)
MOVS	R0, #0
BL	_SPI1_Read+0
STRB	R0, [R7, #0]
ADDS	R7, R7, #1
; usBufferLength end address is: 24 (R6)
; pcReceiverBuffer end address is: 28 (R7)
UXTH	R0, R6
IT	AL
BAL	L_vFlashReadArray118
L_vFlashReadArray119:
MOVS	R5, #1
SXTB	R5, R5
MOVW	R4, #lo_addr(GPIOA_ODR+0)
MOVT	R4, #hi_addr(GPIOA_ODR+0)
_SX	[R4, ByteOffset(GPIOA_ODR+0)]
L_end_vFlashReadArray:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vFlashReadArray
_ucFlashReadId:
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
_SX	[R1, ByteOffset(GPIOA_ODR+0)]
MOVS	R0, #159
BL	_SPI1_Write+0
MOVS	R0, #0
BL	_SPI1_Read+0
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
_SX	[R1, ByteOffset(GPIOA_ODR+0)]
UXTB	R0, R0
L_end_ucFlashReadId:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ucFlashReadId
_vFlashResetWriteProtection:
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
_SX	[R1, ByteOffset(GPIOA_ODR+0)]
MOVS	R0, #6
BL	_SPI1_Write+0
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
_SX	[R1, ByteOffset(GPIOA_ODR+0)]
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
_SX	[R1, ByteOffset(GPIOA_ODR+0)]
MOVS	R0, #6
BL	_SPI1_Write+0
MOVS	R0, #0
BL	_SPI1_Write+0
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
_SX	[R1, ByteOffset(GPIOA_ODR+0)]
L_end_vFlashResetWriteProtection:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vFlashResetWriteProtection
_vFlashChipErase:
; ucMemorySelected start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R4, R0
; ucMemorySelected end address is: 0 (R0)
; ucMemorySelected start address is: 16 (R4)
UXTB	R0, R4
BL	_vFlashWriteEnable+0
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
_SX	[R1, ByteOffset(GPIOA_ODR+0)]
MOVS	R0, #199
BL	_SPI1_Write+0
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
_SX	[R1, ByteOffset(GPIOA_ODR+0)]
; ucMemorySelected end address is: 16 (R4)
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
L_end_vFlashChipErase:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vFlashChipErase
_vFlashSectorErase:
; ucMemorySelected start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
UXTB	R4, R0
STR	R1, [SP, #4]
; ucMemorySelected end address is: 0 (R0)
; ucMemorySelected start address is: 16 (R4)
UXTB	R0, R4
BL	_vFlashWriteEnable+0
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOA_ODR+0)
MOVT	R2, #hi_addr(GPIOA_ODR+0)
_SX	[R2, ByteOffset(GPIOA_ODR+0)]
MOVS	R0, #216
BL	_SPI1_Write+0
ADD	R2, SP, #4
ADDS	R2, R2, #2
LDRB	R2, [R2, #0]
UXTH	R0, R2
BL	_SPI1_Write+0
ADD	R2, SP, #4
ADDS	R2, R2, #1
LDRB	R2, [R2, #0]
UXTH	R0, R2
BL	_SPI1_Write+0
ADD	R2, SP, #4
LDRB	R2, [R2, #0]
UXTH	R0, R2
BL	_SPI1_Write+0
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOA_ODR+0)
MOVT	R2, #hi_addr(GPIOA_ODR+0)
_SX	[R2, ByteOffset(GPIOA_ODR+0)]
; ucMemorySelected end address is: 16 (R4)
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
L_end_vFlashSectorErase:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vFlashSectorErase
_RFISR:
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_LX	[R0, ByteOffset(EXTI_PR+0)]
CMP	R0, #0
IT	EQ
BEQ	L_RFISR124
MOVS	R1, #1
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_SX	[R0, ByteOffset(EXTI_PR+0)]
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
MOVS	R1, #1
MOVW	R0, #lo_addr(main_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(main_ucRF4463IRQ+0)
STRB	R1, [R0, #0]
BL	_ucRf4463ClearInterrupts+0
L_RFISR124:
L_end_RFISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _RFISR
_vRF4463MesageHandler:
SUB	SP, SP, #28
STR	LR, [SP, #0]
MOVW	R0, #lo_addr(_ucRFTxEventPending+0)
MOVT	R0, #hi_addr(_ucRFTxEventPending+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_vRF4463MesageHandler125
MOVS	R1, #64
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
BL	_vBufferSetToZero+0
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
BL	_ucRf4463RxPacket+0
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	LS
BLS	L_vRF4463MesageHandler126
BL	_xRF4463GetLastRSSI+0
MVN	R1, #99
CMP	R0, R1
IT	GT
BGT	L_vRF4463MesageHandler127
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_52_main+0)
MOVT	R1, #hi_addr(?lstr_52_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
L_vRF4463MesageHandler127:
ADD	R11, SP, #4
ADD	R10, R11, #23
MOVW	R12, #lo_addr(?ICS?lstr53_main+0)
MOVT	R12, #hi_addr(?ICS?lstr53_main+0)
BL	___CC2DW+0
ADD	R0, SP, #4
BL	_UART1_Write_Text+0
; usCounter start address is: 16 (R4)
MOVS	R4, #0
; usCounter end address is: 16 (R4)
L_vRF4463MesageHandler128:
; usCounter start address is: 16 (R4)
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
LDRB	R0, [R0, #0]
CMP	R4, R0
IT	CS
BCS	L_vRF4463MesageHandler129
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
ADDS	R0, R0, R4
LDRB	R0, [R0, #0]
BL	_UART1_Write+0
ADDS	R4, R4, #1
UXTH	R4, R4
; usCounter end address is: 16 (R4)
IT	AL
BAL	L_vRF4463MesageHandler128
L_vRF4463MesageHandler129:
MOVS	R0, #13
BL	_UART1_Write+0
MOVS	R0, #10
BL	_UART1_Write+0
BL	_vRF4463RxCommand+0
L_vRF4463MesageHandler126:
IT	AL
BAL	L_vRF4463MesageHandler131
L_vRF4463MesageHandler125:
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucRFTxEventPending+0)
MOVT	R0, #hi_addr(_ucRFTxEventPending+0)
STRB	R1, [R0, #0]
L_vRF4463MesageHandler131:
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
BL	_ucRf4463RxInit+0
L_end_vRF4463MesageHandler:
LDR	LR, [SP, #0]
ADD	SP, SP, #28
BX	LR
; end of _vRF4463MesageHandler
_vRF4463TxMessage:
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
MOVW	R4, #lo_addr(_ucRFTxEventPending+0)
MOVT	R4, #hi_addr(_ucRFTxEventPending+0)
LDRB	R4, [R4, #0]
CMP	R4, #1
IT	NE
BNE	L_vRF4463TxMessage132
; pcOutBuffer end address is: 24 (R6)
; ucLength end address is: 28 (R7)
; ucRemoteNode end address is: 32 (R8)
; ucTable end address is: 36 (R9)
; ucCommand end address is: 40 (R10)
MOVS	R6, #0
SXTB	R6, R6
MOVW	R5, #lo_addr(?lstr_54_main+0)
MOVT	R5, #hi_addr(?lstr_54_main+0)
MOVW	R4, #lo_addr(_vDebugPrint+0)
MOVT	R4, #hi_addr(_vDebugPrint+0)
PUSH	(R6)
PUSH	(R5)
PUSH	(R4)
BL	_PrintOut+0
ADD	SP, SP, #12
IT	AL
BAL	L_end_vRF4463TxMessage
L_vRF4463TxMessage132:
; ucCommand start address is: 40 (R10)
; ucTable start address is: 36 (R9)
; ucRemoteNode start address is: 32 (R8)
; ucLength start address is: 28 (R7)
; pcOutBuffer start address is: 24 (R6)
MOVS	R1, #64
MOVW	R0, #lo_addr(_pcRF4463TxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463TxBuffer+0)
BL	_vBufferSetToZero+0
ADDS	R4, R7, #5
SXTH	R4, R4
CMP	R4, #64
IT	LT
BLT	L_vRF4463TxMessage133
; pcOutBuffer end address is: 24 (R6)
; ucLength end address is: 28 (R7)
; ucRemoteNode end address is: 32 (R8)
; ucTable end address is: 36 (R9)
; ucCommand end address is: 40 (R10)
MOVS	R6, #0
SXTB	R6, R6
MOVW	R5, #lo_addr(?lstr_55_main+0)
MOVT	R5, #hi_addr(?lstr_55_main+0)
MOVW	R4, #lo_addr(_vDebugPrint+0)
MOVT	R4, #hi_addr(_vDebugPrint+0)
PUSH	(R6)
PUSH	(R5)
PUSH	(R4)
BL	_PrintOut+0
ADD	SP, SP, #12
IT	AL
BAL	L_end_vRF4463TxMessage
L_vRF4463TxMessage133:
; ucCommand start address is: 40 (R10)
; ucTable start address is: 36 (R9)
; ucRemoteNode start address is: 32 (R8)
; ucLength start address is: 28 (R7)
; pcOutBuffer start address is: 24 (R6)
ADDS	R5, R7, #5
MOVW	R4, #lo_addr(_pcRF4463TxBuffer+0)
MOVT	R4, #hi_addr(_pcRF4463TxBuffer+0)
STRB	R5, [R4, #0]
MOVW	R4, #lo_addr(_pcRF4463TxBuffer+1)
MOVT	R4, #hi_addr(_pcRF4463TxBuffer+1)
STRB	R8, [R4, #0]
; ucRemoteNode end address is: 32 (R8)
MOVW	R4, #lo_addr(_ucSourceNode+0)
MOVT	R4, #hi_addr(_ucSourceNode+0)
LDRB	R5, [R4, #0]
MOVW	R4, #lo_addr(_pcRF4463TxBuffer+2)
MOVT	R4, #hi_addr(_pcRF4463TxBuffer+2)
STRB	R5, [R4, #0]
MOVW	R4, #lo_addr(_pcRF4463TxBuffer+3)
MOVT	R4, #hi_addr(_pcRF4463TxBuffer+3)
STRB	R9, [R4, #0]
; ucTable end address is: 36 (R9)
MOVW	R4, #lo_addr(_pcRF4463TxBuffer+4)
MOVT	R4, #hi_addr(_pcRF4463TxBuffer+4)
STRB	R10, [R4, #0]
; ucCommand end address is: 40 (R10)
CMP	R7, #0
IT	LS
BLS	L_vRF4463TxMessage134
; ucCounter start address is: 8 (R2)
MOVS	R2, #0
; pcOutBuffer end address is: 24 (R6)
; ucLength end address is: 28 (R7)
; ucCounter end address is: 8 (R2)
MOV	R1, R6
UXTB	R0, R7
L_vRF4463TxMessage135:
; ucCounter start address is: 8 (R2)
; pcOutBuffer start address is: 4 (R1)
; ucLength start address is: 0 (R0)
; pcOutBuffer start address is: 4 (R1)
; pcOutBuffer end address is: 4 (R1)
CMP	R2, R0
IT	CS
BCS	L_vRF4463TxMessage136
; pcOutBuffer end address is: 4 (R1)
; pcOutBuffer start address is: 4 (R1)
ADDS	R5, R2, #5
SXTH	R5, R5
MOVW	R4, #lo_addr(_pcRF4463TxBuffer+0)
MOVT	R4, #hi_addr(_pcRF4463TxBuffer+0)
ADDS	R5, R4, R5
ADDS	R4, R1, R2
LDRB	R4, [R4, #0]
STRB	R4, [R5, #0]
ADDS	R2, R2, #1
UXTB	R2, R2
; ucLength end address is: 0 (R0)
; pcOutBuffer end address is: 4 (R1)
; ucCounter end address is: 8 (R2)
IT	AL
BAL	L_vRF4463TxMessage135
L_vRF4463TxMessage136:
L_vRF4463TxMessage134:
MOVW	R4, #lo_addr(_pcRF4463TxBuffer+0)
MOVT	R4, #hi_addr(_pcRF4463TxBuffer+0)
LDRB	R4, [R4, #0]
UXTB	R1, R4
MOVW	R0, #lo_addr(_pcRF4463TxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463TxBuffer+0)
BL	_ucRf4463TxPacket+0
MOVS	R5, #1
MOVW	R4, #lo_addr(_ucRFTxEventPending+0)
MOVT	R4, #hi_addr(_ucRFTxEventPending+0)
STRB	R5, [R4, #0]
L_end_vRF4463TxMessage:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vRF4463TxMessage
_vRF4463SetNode:
; ucNode start address is: 0 (R0)
SUB	SP, SP, #4
; ucNode end address is: 0 (R0)
; ucNode start address is: 0 (R0)
MOVW	R1, #lo_addr(_ucSourceNode+0)
MOVT	R1, #hi_addr(_ucSourceNode+0)
STRB	R0, [R1, #0]
; ucNode end address is: 0 (R0)
L_end_vRF4463SetNode:
ADD	SP, SP, #4
BX	LR
; end of _vRF4463SetNode
_ucRF4463Setup:
SUB	SP, SP, #24
STR	LR, [SP, #0]
STRB	R0, [SP, #8]
STRB	R1, [SP, #12]
STRH	R2, [SP, #16]
STRB	R3, [SP, #20]
MOVS	R4, #1
STRB	R4, [SP, #4]
MOVW	R2, #lo_addr(__GPIO_MODULE_SPI2_PB13_14_15+0)
MOVT	R2, #hi_addr(__GPIO_MODULE_SPI2_PB13_14_15+0)
MOVW	R1, #772
MOVS	R0, #2
BL	_SPI2_Init_Advanced+0
MOVW	R1, #4096
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Input+0
MOVW	R1, #4096
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
MOVW	R1, #2048
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
MOVW	R1, #2048
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
MOVW	R1, #1024
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
MOVS	R5, #1
SXTB	R5, R5
MOVW	R4, #lo_addr(RCC_APB2ENRbits+0)
MOVT	R4, #hi_addr(RCC_APB2ENRbits+0)
_SX	[R4, ByteOffset(RCC_APB2ENRbits+0)]
MOVW	R4, #lo_addr(AFIO_EXTICR4+0)
MOVT	R4, #hi_addr(AFIO_EXTICR4+0)
LDR	R4, [R4, #0]
ORR	R5, R4, #2
MOVW	R4, #lo_addr(AFIO_EXTICR4+0)
MOVT	R4, #hi_addr(AFIO_EXTICR4+0)
STR	R5, [R4, #0]
MOVS	R5, #1
MOVW	R4, #lo_addr(EXTI_IMR+0)
MOVT	R4, #hi_addr(EXTI_IMR+0)
_SX	[R4, ByteOffset(EXTI_IMR+0)]
MOVS	R5, #1
MOVW	R4, #lo_addr(EXTI_FTSR+0)
MOVT	R4, #hi_addr(EXTI_FTSR+0)
_SX	[R4, ByteOffset(EXTI_FTSR+0)]
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
MOVW	R6, #lo_addr(?lstr_57_main+0)
MOVT	R6, #hi_addr(?lstr_57_main+0)
MOVW	R5, #lo_addr(_vDebugPrint+0)
MOVT	R5, #hi_addr(_vDebugPrint+0)
LDRB	R4, [SP, #12]
PUSH	(R4)
PUSH	(R6)
PUSH	(R5)
BL	_PrintOut+0
ADD	SP, SP, #12
MOVW	R6, #lo_addr(?lstr_58_main+0)
MOVT	R6, #hi_addr(?lstr_58_main+0)
MOVW	R5, #lo_addr(_vDebugPrint+0)
MOVT	R5, #hi_addr(_vDebugPrint+0)
LDRB	R4, [SP, #8]
PUSH	(R4)
PUSH	(R6)
PUSH	(R5)
BL	_PrintOut+0
ADD	SP, SP, #12
MOVW	R6, #lo_addr(?lstr_59_main+0)
MOVT	R6, #hi_addr(?lstr_59_main+0)
MOVW	R5, #lo_addr(_vDebugPrint+0)
MOVT	R5, #hi_addr(_vDebugPrint+0)
LDRH	R4, [SP, #16]
PUSH	(R4)
PUSH	(R6)
PUSH	(R5)
BL	_PrintOut+0
ADD	SP, SP, #12
MOVW	R6, #lo_addr(?lstr_60_main+0)
MOVT	R6, #hi_addr(?lstr_60_main+0)
MOVW	R5, #lo_addr(_vDebugPrint+0)
MOVT	R5, #hi_addr(_vDebugPrint+0)
LDRB	R4, [SP, #20]
PUSH	(R4)
PUSH	(R6)
PUSH	(R5)
BL	_PrintOut+0
ADD	SP, SP, #12
MOVS	R4, #2
LDRB	R3, [SP, #20]
LDRH	R2, [SP, #16]
LDRB	R1, [SP, #12]
LDRB	R0, [SP, #8]
PUSH	(R4)
BL	_vRf4463Init+0
ADD	SP, SP, #4
MOVS	R4, #0
STRB	R4, [SP, #21]
L_ucRF4463Setup138:
LDRB	R4, [SP, #21]
CMP	R4, #15
IT	CS
BCS	L_ucRF4463Setup139
BL	_ucRf4463DeviceAvailability+0
CMP	R0, #0
IT	NE
BNE	L_ucRF4463Setup141
LDRB	R6, [SP, #21]
MOVW	R5, #lo_addr(?lstr_61_main+0)
MOVT	R5, #hi_addr(?lstr_61_main+0)
MOVW	R4, #lo_addr(_vDebugPrint+0)
MOVT	R4, #hi_addr(_vDebugPrint+0)
PUSH	(R6)
PUSH	(R5)
PUSH	(R4)
BL	_PrintOut+0
ADD	SP, SP, #12
IT	AL
BAL	L_ucRF4463Setup139
L_ucRF4463Setup141:
LDRB	R6, [SP, #21]
MOVW	R5, #lo_addr(?lstr_62_main+0)
MOVT	R5, #hi_addr(?lstr_62_main+0)
MOVW	R4, #lo_addr(_vDebugPrint+0)
MOVT	R4, #hi_addr(_vDebugPrint+0)
PUSH	(R6)
PUSH	(R5)
PUSH	(R4)
BL	_PrintOut+0
ADD	SP, SP, #12
MOVW	R7, #10175
MOVT	R7, #9
NOP
NOP
L_ucRF4463Setup143:
SUBS	R7, R7, #1
BNE	L_ucRF4463Setup143
NOP
NOP
NOP
LDRB	R4, [SP, #21]
ADDS	R4, R4, #1
STRB	R4, [SP, #21]
IT	AL
BAL	L_ucRF4463Setup138
L_ucRF4463Setup139:
LDRB	R4, [SP, #21]
CMP	R4, #15
IT	NE
BNE	L_ucRF4463Setup145
MOVS	R6, #0
SXTB	R6, R6
MOVW	R5, #lo_addr(?lstr_63_main+0)
MOVT	R5, #hi_addr(?lstr_63_main+0)
MOVW	R4, #lo_addr(_vDebugPrint+0)
MOVT	R4, #hi_addr(_vDebugPrint+0)
PUSH	(R6)
PUSH	(R5)
PUSH	(R4)
BL	_PrintOut+0
ADD	SP, SP, #12
L_ucRF4463Setup145:
L_ucRF4463Setup146:
LDRSB	R4, [SP, #4]
CMP	R4, #0
IT	EQ
BEQ	L_ucRF4463Setup147
BL	_ucRf4463EnterStandbyMode+0
STRB	R0, [SP, #4]
IT	AL
BAL	L_ucRF4463Setup146
L_ucRF4463Setup147:
MOVW	R0, #56
BL	_NVIC_IntEnable+0
BL	_ucRf4463ClearInterrupts+0
BL	_ucRf4463RxInit+0
MOVS	R6, #0
SXTB	R6, R6
MOVW	R5, #lo_addr(?lstr_64_main+0)
MOVT	R5, #hi_addr(?lstr_64_main+0)
MOVW	R4, #lo_addr(_vDebugPrint+0)
MOVT	R4, #hi_addr(_vDebugPrint+0)
PUSH	(R6)
PUSH	(R5)
PUSH	(R4)
BL	_PrintOut+0
ADD	SP, SP, #12
L_end_ucRF4463Setup:
LDR	LR, [SP, #0]
ADD	SP, SP, #24
BX	LR
; end of _ucRF4463Setup
_vRF4463RxCommand:
SUB	SP, SP, #60
STR	LR, [SP, #0]
; ucPosition start address is: 12 (R3)
MOVS	R3, #5
ADD	R11, SP, #8
ADD	R10, R11, #51
MOVW	R12, #lo_addr(?ICSvRF4463RxCommand_pcQR_L0+0)
MOVT	R12, #hi_addr(?ICSvRF4463RxCommand_pcQR_L0+0)
BL	___CC2DW+0
IT	AL
BAL	L_vRF4463RxCommand148
; ucPosition end address is: 12 (R3)
L_vRF4463RxCommand150:
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_65_main+0)
MOVT	R1, #hi_addr(?lstr_65_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
IT	AL
BAL	L_vRF4463RxCommand151
L_vRF4463RxCommand153:
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_66_main+0)
MOVT	R1, #hi_addr(?lstr_66_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
IT	AL
BAL	L_vRF4463RxCommand152
L_vRF4463RxCommand154:
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
IT	AL
BAL	L_end_vRF4463RxCommand
L_vRF4463RxCommand151:
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+4)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+4)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_vRF4463RxCommand153
IT	AL
BAL	L_vRF4463RxCommand154
L_vRF4463RxCommand152:
IT	AL
BAL	L_vRF4463RxCommand149
L_vRF4463RxCommand155:
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
IT	AL
BAL	L_vRF4463RxCommand156
L_vRF4463RxCommand158:
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+2)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+2)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_vRF4463RxCommand159
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
; ucCounter start address is: 8 (R2)
MOVS	R2, #0
; ucPosition end address is: 12 (R3)
; ucCounter end address is: 8 (R2)
L_vRF4463RxCommand160:
; ucCounter start address is: 8 (R2)
; ucPosition start address is: 12 (R3)
CMP	R2, #12
IT	CS
BCS	L_vRF4463RxCommand161
ADD	R0, SP, #8
ADDS	R1, R0, R2
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
ADDS	R3, R3, #1
UXTB	R3, R3
ADDS	R2, R2, #1
UXTB	R2, R2
; ucPosition end address is: 12 (R3)
; ucCounter end address is: 8 (R2)
IT	AL
BAL	L_vRF4463RxCommand160
L_vRF4463RxCommand161:
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
IT	AL
BAL	L_vRF4463RxCommand163
L_vRF4463RxCommand159:
; ucPosition start address is: 12 (R3)
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+2)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+2)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_vRF4463RxCommand164
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
; ucCounter start address is: 8 (R2)
MOVS	R2, #0
; ucPosition end address is: 12 (R3)
; ucCounter end address is: 8 (R2)
L_vRF4463RxCommand165:
; ucCounter start address is: 8 (R2)
; ucPosition start address is: 12 (R3)
CMP	R2, #12
IT	CS
BCS	L_vRF4463RxCommand166
ADD	R0, SP, #46
ADDS	R1, R0, R2
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
ADDS	R3, R3, #1
UXTB	R3, R3
ADDS	R2, R2, #1
UXTB	R2, R2
; ucPosition end address is: 12 (R3)
; ucCounter end address is: 8 (R2)
IT	AL
BAL	L_vRF4463RxCommand165
L_vRF4463RxCommand166:
ADD	R1, SP, #46
ADD	R0, SP, #21
MOVS	R2, #12
BL	_vHexToASCII+0
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
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
LDRB	R0, [R0, #0]
CMP	R0, #24
IT	NE
BNE	L_vRF4463RxCommand168
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
IT	AL
BAL	L_vRF4463RxCommand169
L_vRF4463RxCommand168:
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
L_vRF4463RxCommand169:
L_vRF4463RxCommand164:
L_vRF4463RxCommand163:
IT	AL
BAL	L_vRF4463RxCommand157
L_vRF4463RxCommand170:
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
IT	AL
BAL	L_end_vRF4463RxCommand
L_vRF4463RxCommand156:
; ucPosition start address is: 12 (R3)
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+4)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+4)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_vRF4463RxCommand158
; ucPosition end address is: 12 (R3)
IT	AL
BAL	L_vRF4463RxCommand170
L_vRF4463RxCommand157:
IT	AL
BAL	L_vRF4463RxCommand149
L_vRF4463RxCommand171:
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
IT	AL
BAL	L_vRF4463RxCommand172
L_vRF4463RxCommand174:
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
IT	AL
BAL	L_end_vRF4463RxCommand
L_vRF4463RxCommand172:
IT	AL
BAL	L_vRF4463RxCommand174
L_vRF4463RxCommand175:
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
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+2)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+2)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_vRF4463RxCommand176
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_84_main+0)
MOVT	R1, #hi_addr(?lstr_84_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
IT	AL
BAL	L_end_vRF4463RxCommand
L_vRF4463RxCommand176:
IT	AL
BAL	L_vRF4463RxCommand177
L_vRF4463RxCommand179:
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
IT	AL
BAL	L_end_vRF4463RxCommand
L_vRF4463RxCommand177:
IT	AL
BAL	L_vRF4463RxCommand179
L_vRF4463RxCommand180:
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_86_main+0)
MOVT	R1, #hi_addr(?lstr_86_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+2)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+2)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_vRF4463RxCommand181
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
IT	AL
BAL	L_end_vRF4463RxCommand
L_vRF4463RxCommand181:
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
IT	AL
BAL	L_vRF4463RxCommand182
L_vRF4463RxCommand184:
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
IT	AL
BAL	L_end_vRF4463RxCommand
L_vRF4463RxCommand182:
IT	AL
BAL	L_vRF4463RxCommand184
L_vRF4463RxCommand185:
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_90_main+0)
MOVT	R1, #hi_addr(?lstr_90_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+2)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+2)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_vRF4463RxCommand186
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
IT	AL
BAL	L_end_vRF4463RxCommand
L_vRF4463RxCommand186:
IT	AL
BAL	L_vRF4463RxCommand187
L_vRF4463RxCommand189:
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_92_main+0)
MOVT	R1, #hi_addr(?lstr_92_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
IT	AL
BAL	L_end_vRF4463RxCommand
L_vRF4463RxCommand187:
IT	AL
BAL	L_vRF4463RxCommand189
L_vRF4463RxCommand190:
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_93_main+0)
MOVT	R1, #hi_addr(?lstr_93_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+2)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+2)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_vRF4463RxCommand191
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_94_main+0)
MOVT	R1, #hi_addr(?lstr_94_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
IT	AL
BAL	L_end_vRF4463RxCommand
L_vRF4463RxCommand191:
IT	AL
BAL	L_vRF4463RxCommand192
L_vRF4463RxCommand194:
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_95_main+0)
MOVT	R1, #hi_addr(?lstr_95_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
IT	AL
BAL	L_end_vRF4463RxCommand
L_vRF4463RxCommand192:
IT	AL
BAL	L_vRF4463RxCommand194
L_vRF4463RxCommand195:
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_96_main+0)
MOVT	R1, #hi_addr(?lstr_96_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+2)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+2)
LDRB	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_97_main+0)
MOVT	R1, #hi_addr(?lstr_97_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+1)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+1)
LDRB	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_98_main+0)
MOVT	R1, #hi_addr(?lstr_98_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+3)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+3)
LDRB	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_99_main+0)
MOVT	R1, #hi_addr(?lstr_99_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+4)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+4)
LDRB	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_100_main+0)
MOVT	R1, #hi_addr(?lstr_100_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
IT	AL
BAL	L_end_vRF4463RxCommand
L_vRF4463RxCommand148:
; ucPosition start address is: 12 (R3)
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+3)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+3)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_vRF4463RxCommand150
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+3)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+3)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_vRF4463RxCommand155
; ucPosition end address is: 12 (R3)
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+3)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+3)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_vRF4463RxCommand171
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+3)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+3)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	EQ
BEQ	L_vRF4463RxCommand175
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+3)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+3)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	EQ
BEQ	L_vRF4463RxCommand180
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+3)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+3)
LDRB	R0, [R0, #0]
CMP	R0, #6
IT	EQ
BEQ	L_vRF4463RxCommand185
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+3)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+3)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	EQ
BEQ	L_vRF4463RxCommand190
IT	AL
BAL	L_vRF4463RxCommand195
L_vRF4463RxCommand149:
L_end_vRF4463RxCommand:
LDR	LR, [SP, #0]
ADD	SP, SP, #60
BX	LR
; end of _vRF4463RxCommand
_vRF4463RxFTY:
SUBW	SP, SP, #808
STR	LR, [SP, #0]
; ucPosition start address is: 32 (R8)
MOVW	R8, #0
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+1)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+1)
LDRB	R0, [R0, #0]
CMP	R0, #254
IT	NE
BNE	L_vRF4463RxFTY196
IT	AL
BAL	L_vRF4463RxFTY197
L_vRF4463RxFTY199:
IT	AL
BAL	L_vRF4463RxFTY200
; ucPosition end address is: 32 (R8)
L_vRF4463RxFTY202:
MOVS	R0, #254
BL	_vRF4463SetNode+0
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
IT	AL
BAL	L_vRF4463RxFTY201
L_vRF4463RxFTY203:
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
; usCounter start address is: 16 (R4)
MOVS	R4, #5
; usCounter end address is: 16 (R4)
L_vRF4463RxFTY204:
; usCounter start address is: 16 (R4)
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
LDRB	R0, [R0, #0]
CMP	R4, R0
IT	CS
BCS	L_vRF4463RxFTY205
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
ADDS	R0, R0, R4
LDRB	R0, [R0, #0]
BL	_UART1_Write+0
ADDS	R4, R4, #1
UXTH	R4, R4
; usCounter end address is: 16 (R4)
IT	AL
BAL	L_vRF4463RxFTY204
L_vRF4463RxFTY205:
MOVS	R0, #13
BL	_UART1_Write+0
MOVS	R0, #10
BL	_UART1_Write+0
IT	AL
BAL	L_vRF4463RxFTY201
L_vRF4463RxFTY207:
; usCounter start address is: 12 (R3)
MOVS	R3, #0
; usCounter end address is: 12 (R3)
L_vRF4463RxFTY208:
; usCounter start address is: 12 (R3)
CMP	R3, #12
IT	CS
BCS	L_vRF4463RxFTY209
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
ADDS	R3, R3, #1
UXTH	R3, R3
; usCounter end address is: 12 (R3)
IT	AL
BAL	L_vRF4463RxFTY208
L_vRF4463RxFTY209:
MOVS	R2, #12
SXTH	R2, R2
MOVW	R1, #lo_addr(main_pcSentQR+0)
MOVT	R1, #hi_addr(main_pcSentQR+0)
MOVW	R0, #lo_addr(main_pcReceivedQR+0)
MOVT	R0, #hi_addr(main_pcReceivedQR+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BNE	L_vRF4463RxFTY211
ADDW	R11, SP, #749
ADD	R10, R11, #8
MOVW	R12, #lo_addr(?ICS?lstr102_main+0)
MOVT	R12, #hi_addr(?ICS?lstr102_main+0)
BL	___CC2DW+0
ADDW	R0, SP, #749
BL	_UART1_Write_Text+0
; usCounter start address is: 16 (R4)
MOVS	R4, #0
; usCounter end address is: 16 (R4)
L_vRF4463RxFTY212:
; usCounter start address is: 16 (R4)
CMP	R4, #12
IT	CS
BCS	L_vRF4463RxFTY213
MOVW	R0, #lo_addr(main_pcReceivedQR+0)
MOVT	R0, #hi_addr(main_pcReceivedQR+0)
ADDS	R0, R0, R4
LDRB	R0, [R0, #0]
BL	_UART1_Write+0
ADDS	R4, R4, #1
UXTH	R4, R4
; usCounter end address is: 16 (R4)
IT	AL
BAL	L_vRF4463RxFTY212
L_vRF4463RxFTY213:
MOVS	R0, #13
BL	_UART1_Write+0
MOVS	R0, #10
BL	_UART1_Write+0
L_vRF4463RxFTY211:
IT	AL
BAL	L_vRF4463RxFTY201
L_vRF4463RxFTY215:
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
; usCounter start address is: 16 (R4)
MOVS	R4, #5
; usCounter end address is: 16 (R4)
L_vRF4463RxFTY216:
; usCounter start address is: 16 (R4)
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
LDRB	R0, [R0, #0]
CMP	R4, R0
IT	CS
BCS	L_vRF4463RxFTY217
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
ADDS	R0, R0, R4
LDRB	R0, [R0, #0]
BL	_UART1_Write+0
ADDS	R4, R4, #1
UXTH	R4, R4
; usCounter end address is: 16 (R4)
IT	AL
BAL	L_vRF4463RxFTY216
L_vRF4463RxFTY217:
MOVS	R0, #13
BL	_UART1_Write+0
MOVS	R0, #10
BL	_UART1_Write+0
IT	AL
BAL	L_vRF4463RxFTY201
L_vRF4463RxFTY219:
MOVW	R0, #lo_addr(_ucSearchActive+0)
MOVT	R0, #hi_addr(_ucSearchActive+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_vRF4463RxFTY220
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucSearchActive+0)
MOVT	R0, #hi_addr(_ucSearchActive+0)
STRB	R1, [R0, #0]
BL	_vTimerSearchLed+0
IT	AL
BAL	L_vRF4463RxFTY221
L_vRF4463RxFTY220:
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucSearchActive+0)
MOVT	R0, #hi_addr(_ucSearchActive+0)
STRB	R1, [R0, #0]
MOVS	R0, #0
BL	_vTimerStop+0
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
L_vRF4463RxFTY221:
IT	AL
BAL	L_vRF4463RxFTY201
L_vRF4463RxFTY222:
; ucPosition start address is: 32 (R8)
; usCounter start address is: 36 (R9)
MOVW	R9, #0
; usCounter end address is: 36 (R9)
; ucPosition end address is: 32 (R8)
L_vRF4463RxFTY223:
; usCounter start address is: 36 (R9)
; ucPosition start address is: 32 (R8)
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
LDRB	R0, [R0, #0]
SUBS	R0, R0, #5
SXTH	R0, R0
CMP	R9, R0
IT	CS
BCS	L_vRF4463RxFTY224
ADD	R0, SP, #8
ADD	R2, R0, R9, LSL #0
ADD	R1, R9, #5
UXTH	R1, R1
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
ADD	R9, R9, #1
UXTH	R9, R9
IT	AL
BAL	L_vRF4463RxFTY223
L_vRF4463RxFTY224:
MOVS	R2, #64
SXTH	R2, R2
MOVS	R1, #0
MOVW	R0, #lo_addr(_pcRxRF4463AuxBuffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463AuxBuffer+0)
BL	_memset+0
ADD	R0, SP, #8
UXTB	R2, R9
; usCounter end address is: 36 (R9)
MOVW	R1, #lo_addr(_pcRxRF4463AuxBuffer+0)
MOVT	R1, #hi_addr(_pcRxRF4463AuxBuffer+0)
BL	_vXORRFMessage+0
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
BAL	L_vRF4463RxFTY226
L_vRF4463RxFTY228:
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
; usCounter start address is: 16 (R4)
MOVS	R4, #0
; ucPosition end address is: 28 (R7)
; usCounter end address is: 16 (R4)
L_vRF4463RxFTY229:
; usCounter start address is: 16 (R4)
; ucPosition start address is: 28 (R7)
CMP	R4, #12
IT	CS
BCS	L_vRF4463RxFTY230
MOVW	R0, #lo_addr(_pcRxRF4463AuxBuffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463AuxBuffer+0)
ADDS	R0, R0, R7
LDRB	R0, [R0, #0]
BL	_UART1_Write+0
ADDS	R7, R7, #1
UXTB	R7, R7
ADDS	R4, R4, #1
UXTH	R4, R4
; usCounter end address is: 16 (R4)
IT	AL
BAL	L_vRF4463RxFTY229
L_vRF4463RxFTY230:
MOVS	R0, #13
BL	_UART1_Write+0
MOVS	R0, #10
BL	_UART1_Write+0
; usCounter start address is: 8 (R2)
MOVS	R2, #0
; ucPosition end address is: 28 (R7)
; usCounter end address is: 8 (R2)
L_vRF4463RxFTY232:
; usCounter start address is: 8 (R2)
; ucPosition start address is: 28 (R7)
CMP	R2, #12
IT	CS
BCS	L_vRF4463RxFTY233
ADD	R0, SP, #161
ADDS	R1, R0, R2
MOVW	R0, #lo_addr(_pcRxRF4463AuxBuffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463AuxBuffer+0)
ADDS	R0, R0, R7
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
ADDS	R7, R7, #1
UXTB	R7, R7
ADDS	R2, R2, #1
UXTH	R2, R2
; usCounter end address is: 8 (R2)
IT	AL
BAL	L_vRF4463RxFTY232
L_vRF4463RxFTY233:
ADD	R1, SP, #161
ADD	R0, SP, #136
BL	_vSerializeUUID+0
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
ADD	R0, SP, #136
BL	_UART1_Write_Text+0
MOVS	R0, #13
BL	_UART1_Write+0
MOVS	R0, #10
BL	_UART1_Write+0
; usCounter start address is: 8 (R2)
MOVS	R2, #0
; ucPosition end address is: 28 (R7)
; usCounter end address is: 8 (R2)
UXTB	R8, R7
L_vRF4463RxFTY235:
; usCounter start address is: 8 (R2)
; ucPosition start address is: 32 (R8)
CMP	R2, #6
IT	CS
BCS	L_vRF4463RxFTY236
ADD	R0, SP, #194
ADDS	R1, R0, R2
MOVW	R0, #lo_addr(_pcRxRF4463AuxBuffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463AuxBuffer+0)
ADD	R0, R0, R8, LSL #0
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
ADD	R8, R8, #1
UXTB	R8, R8
ADDS	R2, R2, #1
UXTH	R2, R2
; usCounter end address is: 8 (R2)
IT	AL
BAL	L_vRF4463RxFTY235
L_vRF4463RxFTY236:
ADD	R1, SP, #194
ADD	R0, SP, #174
BL	_vSerializeMACAddress+0
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
ADD	R0, SP, #174
BL	_UART1_Write_Text+0
MOVS	R0, #13
BL	_UART1_Write+0
MOVS	R0, #10
BL	_UART1_Write+0
; usCounter start address is: 8 (R2)
MOVS	R2, #0
; ucPosition end address is: 32 (R8)
; usCounter end address is: 8 (R2)
UXTB	R3, R8
L_vRF4463RxFTY238:
; usCounter start address is: 8 (R2)
; ucPosition start address is: 12 (R3)
CMP	R2, #4
IT	CS
BCS	L_vRF4463RxFTY239
ADD	R0, SP, #226
ADDS	R1, R0, R2
MOVW	R0, #lo_addr(_pcRxRF4463AuxBuffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463AuxBuffer+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
ADDS	R3, R3, #1
UXTB	R3, R3
ADDS	R2, R2, #1
UXTH	R2, R2
; usCounter end address is: 8 (R2)
IT	AL
BAL	L_vRF4463RxFTY238
L_vRF4463RxFTY239:
ADD	R1, SP, #226
ADD	R0, SP, #206
STRB	R3, [SP, #4]
BL	_vSerializeIPAddress+0
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
ADD	R0, SP, #206
BL	_UART1_Write_Text+0
MOVS	R0, #13
BL	_UART1_Write+0
MOVS	R0, #10
BL	_UART1_Write+0
ADD	R0, SP, #8
MOVS	R2, #0
SXTH	R2, R2
MOVS	R1, #0
BL	_memset+0
LDRB	R3, [SP, #4]
MOVW	R0, #lo_addr(_pcRxRF4463AuxBuffer+0)
MOVT	R0, #hi_addr(_pcRxRF4463AuxBuffer+0)
ADDS	R0, R0, R3
; ucPosition end address is: 12 (R3)
LDRB	R0, [R0, #0]
UXTB	R4, R0
UXTB	R3, R0
UXTB	R2, R0
MOVW	R1, #lo_addr(?lstr_108_main+0)
MOVT	R1, #hi_addr(?lstr_108_main+0)
ADD	R0, SP, #8
PUSH	(R4)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #20
ADD	R0, SP, #8
BL	_UART1_Write_Text+0
IT	AL
BAL	L_vRF4463RxFTY227
L_vRF4463RxFTY241:
IT	AL
BAL	L_vRF4463RxFTY227
L_vRF4463RxFTY242:
IT	AL
BAL	L_vRF4463RxFTY227
L_vRF4463RxFTY243:
IT	AL
BAL	L_vRF4463RxFTY227
L_vRF4463RxFTY226:
; ucPosition start address is: 28 (R7)
LDR	R1, [SP, #804]
LDRB	R0, [R1, #0]
CMP	R0, #1
IT	EQ
BEQ	L_vRF4463RxFTY228
; ucPosition end address is: 28 (R7)
LDRB	R0, [R1, #0]
CMP	R0, #2
IT	EQ
BEQ	L_vRF4463RxFTY241
LDRB	R0, [R1, #0]
CMP	R0, #3
IT	EQ
BEQ	L_vRF4463RxFTY242
LDRB	R0, [R1, #0]
CMP	R0, #4
IT	EQ
BEQ	L_vRF4463RxFTY243
L_vRF4463RxFTY227:
IT	AL
BAL	L_vRF4463RxFTY201
L_vRF4463RxFTY200:
; ucPosition start address is: 32 (R8)
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+4)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+4)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	EQ
BEQ	L_vRF4463RxFTY202
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+4)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+4)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_vRF4463RxFTY203
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+4)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+4)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_vRF4463RxFTY207
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+4)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+4)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	EQ
BEQ	L_vRF4463RxFTY215
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+4)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+4)
LDRB	R0, [R0, #0]
CMP	R0, #200
IT	EQ
BEQ	L_vRF4463RxFTY219
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+4)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+4)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	EQ
BEQ	L_vRF4463RxFTY222
; ucPosition end address is: 32 (R8)
L_vRF4463RxFTY201:
IT	AL
BAL	L_vRF4463RxFTY198
L_vRF4463RxFTY244:
IT	AL
BAL	L_vRF4463RxFTY245
L_vRF4463RxFTY247:
ADD	R0, SP, #72
MOVS	R2, #64
SXTH	R2, R2
MOVS	R1, #0
BL	_memset+0
ADD	R0, SP, #8
MOVS	R2, #64
SXTH	R2, R2
MOVS	R1, #0
BL	_memset+0
; usCounter start address is: 12 (R3)
MOVS	R3, #0
; usCounter end address is: 12 (R3)
L_vRF4463RxFTY248:
; usCounter start address is: 12 (R3)
CMP	R3, #12
IT	CS
BCS	L_vRF4463RxFTY249
ADD	R0, SP, #8
ADDS	R2, R0, R3
ADDS	R1, R3, #5
UXTH	R1, R1
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
ADDS	R3, R3, #1
UXTH	R3, R3
; usCounter end address is: 12 (R3)
IT	AL
BAL	L_vRF4463RxFTY248
L_vRF4463RxFTY249:
ADD	R1, SP, #8
ADD	R0, SP, #72
MOVS	R2, #12
BL	_vHexToASCII+0
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
ADD	R0, SP, #72
BL	_UART1_Write_Text+0
MOVS	R0, #13
BL	_UART1_Write+0
MOVS	R0, #10
BL	_UART1_Write+0
IT	AL
BAL	L_vRF4463RxFTY246
L_vRF4463RxFTY245:
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+4)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+4)
LDRB	R0, [R0, #0]
CMP	R0, #11
IT	EQ
BEQ	L_vRF4463RxFTY247
L_vRF4463RxFTY246:
IT	AL
BAL	L_vRF4463RxFTY198
L_vRF4463RxFTY197:
; ucPosition start address is: 32 (R8)
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+3)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+3)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_vRF4463RxFTY199
; ucPosition end address is: 32 (R8)
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+3)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+3)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_vRF4463RxFTY244
L_vRF4463RxFTY198:
IT	AL
BAL	L_vRF4463RxFTY251
L_vRF4463RxFTY196:
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+1)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+1)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_vRF4463RxFTY252
IT	AL
BAL	L_vRF4463RxFTY253
L_vRF4463RxFTY255:
IT	AL
BAL	L_vRF4463RxFTY256
L_vRF4463RxFTY258:
ADD	R0, SP, #72
MOVS	R2, #64
SXTH	R2, R2
MOVS	R1, #0
BL	_memset+0
; usCounter start address is: 12 (R3)
MOVS	R3, #0
; usCounter end address is: 12 (R3)
L_vRF4463RxFTY259:
; usCounter start address is: 12 (R3)
CMP	R3, #12
IT	CS
BCS	L_vRF4463RxFTY260
ADD	R0, SP, #8
ADDS	R2, R0, R3
ADDS	R1, R3, #5
UXTH	R1, R1
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
ADDS	R3, R3, #1
UXTH	R3, R3
; usCounter end address is: 12 (R3)
IT	AL
BAL	L_vRF4463RxFTY259
L_vRF4463RxFTY260:
ADD	R1, SP, #8
ADD	R0, SP, #72
MOVS	R2, #12
BL	_vHexToASCII+0
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
ADD	R0, SP, #72
BL	_UART1_Write_Text+0
MOVS	R0, #13
BL	_UART1_Write+0
MOVS	R0, #10
BL	_UART1_Write+0
ADD	R0, SP, #232
MOVW	R2, #512
SXTH	R2, R2
MOVS	R1, #0
BL	_memset+0
ADD	R4, SP, #72
MOVW	R0, #lo_addr(_ucSearchedModelId+0)
MOVT	R0, #hi_addr(_ucSearchedModelId+0)
LDRB	R3, [R0, #0]
MOVW	R2, #lo_addr(_pcTempQR+0)
MOVT	R2, #hi_addr(_pcTempQR+0)
MOVW	R1, #lo_addr(?lstr_111_main+0)
MOVT	R1, #hi_addr(?lstr_111_main+0)
ADD	R0, SP, #232
PUSH	(R4)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #20
ADD	R0, SP, #232
BL	_UART1_Write_Text+0
IT	AL
BAL	L_vRF4463RxFTY257
L_vRF4463RxFTY262:
ADD	R0, SP, #72
MOVS	R2, #64
SXTH	R2, R2
MOVS	R1, #0
BL	_memset+0
ADD	R0, SP, #8
MOVS	R2, #64
SXTH	R2, R2
MOVS	R1, #0
BL	_memset+0
; usCounter start address is: 12 (R3)
MOVS	R3, #0
; usCounter end address is: 12 (R3)
L_vRF4463RxFTY263:
; usCounter start address is: 12 (R3)
CMP	R3, #12
IT	CS
BCS	L_vRF4463RxFTY264
ADD	R0, SP, #8
ADDS	R2, R0, R3
ADDS	R1, R3, #5
UXTH	R1, R1
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
ADDS	R3, R3, #1
UXTH	R3, R3
; usCounter end address is: 12 (R3)
IT	AL
BAL	L_vRF4463RxFTY263
L_vRF4463RxFTY264:
ADD	R1, SP, #8
ADD	R0, SP, #72
MOVS	R2, #12
BL	_vHexToASCII+0
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
ADD	R0, SP, #72
BL	_UART1_Write_Text+0
MOVS	R0, #13
BL	_UART1_Write+0
MOVS	R0, #10
BL	_UART1_Write+0
IT	AL
BAL	L_vRF4463RxFTY257
L_vRF4463RxFTY256:
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+4)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+4)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_vRF4463RxFTY258
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+4)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+4)
LDRB	R0, [R0, #0]
CMP	R0, #11
IT	EQ
BEQ	L_vRF4463RxFTY262
L_vRF4463RxFTY257:
IT	AL
BAL	L_vRF4463RxFTY254
L_vRF4463RxFTY253:
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+3)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+3)
LDRB	R0, [R0, #0]
CMP	R0, #14
IT	EQ
BEQ	L_vRF4463RxFTY255
L_vRF4463RxFTY254:
L_vRF4463RxFTY252:
L_vRF4463RxFTY251:
L_end_vRF4463RxFTY:
LDR	LR, [SP, #0]
ADDW	SP, SP, #808
BX	LR
; end of _vRF4463RxFTY
_ucRF4463GetIRQFlag:
SUB	SP, SP, #4
MOVW	R0, #lo_addr(main_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(main_ucRF4463IRQ+0)
LDRB	R0, [R0, #0]
L_end_ucRF4463GetIRQFlag:
ADD	SP, SP, #4
BX	LR
; end of _ucRF4463GetIRQFlag
_vRF4463ResetIRQFlag:
SUB	SP, SP, #4
MOVS	R1, #0
MOVW	R0, #lo_addr(main_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(main_ucRF4463IRQ+0)
STRB	R1, [R0, #0]
L_end_vRF4463ResetIRQFlag:
ADD	SP, SP, #4
BX	LR
; end of _vRF4463ResetIRQFlag
_vRF4463SetPinSelect:
; ucPinVal start address is: 0 (R0)
SUB	SP, SP, #4
; ucPinVal end address is: 0 (R0)
; ucPinVal start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
_SX	[R1, ByteOffset(GPIOB_ODR+0)]
; ucPinVal end address is: 0 (R0)
L_end_vRF4463SetPinSelect:
ADD	SP, SP, #4
BX	LR
; end of _vRF4463SetPinSelect
_vRF4463SetPinSDN:
; ucPinVal start address is: 0 (R0)
SUB	SP, SP, #4
; ucPinVal end address is: 0 (R0)
; ucPinVal start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
_SX	[R1, ByteOffset(GPIOB_ODR+0)]
; ucPinVal end address is: 0 (R0)
L_end_vRF4463SetPinSDN:
ADD	SP, SP, #4
BX	LR
; end of _vRF4463SetPinSDN
_vRf4463Init:
SUB	SP, SP, #40
STR	LR, [SP, #0]
STRB	R0, [SP, #24]
STRB	R1, [SP, #28]
STRH	R2, [SP, #32]
STRB	R3, [SP, #36]
; ucFrequency start address is: 0 (R0)
LDRB	R0, [SP, #40]
LDRH	R4, [SP, #32]
CMP	R4, #0
IT	NE
BNE	L_vRf4463Init266
; ucFrequency end address is: 0 (R0)
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
IT	AL
BAL	L_end_vRf4463Init
L_vRf4463Init266:
; ucFrequency start address is: 0 (R0)
LDRB	R4, [SP, #24]
CMP	R4, #0
IT	EQ
BEQ	L__vRf4463Init355
LDRB	R4, [SP, #24]
CMP	R4, #25
IT	HI
BHI	L__vRf4463Init354
L__vRf4463Init351:
LDRB	R4, [SP, #28]
CMP	R4, #0
IT	EQ
BEQ	L__vRf4463Init353
LDRB	R4, [SP, #28]
CMP	R4, #25
IT	HI
BHI	L__vRf4463Init352
L__vRf4463Init350:
IT	AL
BAL	L_vRf4463Init273
; ucFrequency end address is: 0 (R0)
L__vRf4463Init355:
L__vRf4463Init354:
L__vRf4463Init353:
L__vRf4463Init352:
MOVS	R6, #0
SXTB	R6, R6
MOVW	R5, #lo_addr(?lstr_114_main+0)
MOVT	R5, #hi_addr(?lstr_114_main+0)
MOVW	R4, #lo_addr(_vDebugPrint+0)
MOVT	R4, #hi_addr(_vDebugPrint+0)
PUSH	(R6)
PUSH	(R5)
PUSH	(R4)
BL	_PrintOut+0
ADD	SP, SP, #12
IT	AL
BAL	L_end_vRf4463Init
L_vRf4463Init273:
; ucFrequency start address is: 0 (R0)
IT	AL
BAL	L_vRf4463Init274
; ucFrequency end address is: 0 (R0)
L_vRf4463Init276:
MOVS	R6, #0
SXTB	R6, R6
MOVW	R5, #lo_addr(?lstr_115_main+0)
MOVT	R5, #hi_addr(?lstr_115_main+0)
MOVW	R4, #lo_addr(_vDebugPrint+0)
MOVT	R4, #hi_addr(_vDebugPrint+0)
PUSH	(R6)
PUSH	(R5)
PUSH	(R4)
BL	_PrintOut+0
ADD	SP, SP, #12
MOVS	R6, #0
SXTB	R6, R6
MOVW	R5, #lo_addr(?lstr_116_main+0)
MOVT	R5, #hi_addr(?lstr_116_main+0)
MOVW	R4, #lo_addr(_vDebugPrint+0)
MOVT	R4, #hi_addr(_vDebugPrint+0)
PUSH	(R6)
PUSH	(R5)
PUSH	(R4)
BL	_PrintOut+0
ADD	SP, SP, #12
IT	AL
BAL	L_vRf4463Init275
L_vRf4463Init277:
MOVS	R6, #0
SXTB	R6, R6
MOVW	R5, #lo_addr(?lstr_117_main+0)
MOVT	R5, #hi_addr(?lstr_117_main+0)
MOVW	R4, #lo_addr(_vDebugPrint+0)
MOVT	R4, #hi_addr(_vDebugPrint+0)
PUSH	(R6)
PUSH	(R5)
PUSH	(R4)
BL	_PrintOut+0
ADD	SP, SP, #12
IT	AL
BAL	L_vRf4463Init275
L_vRf4463Init278:
MOVS	R6, #0
SXTB	R6, R6
MOVW	R5, #lo_addr(?lstr_118_main+0)
MOVT	R5, #hi_addr(?lstr_118_main+0)
MOVW	R4, #lo_addr(_vDebugPrint+0)
MOVT	R4, #hi_addr(_vDebugPrint+0)
PUSH	(R6)
PUSH	(R5)
PUSH	(R4)
BL	_PrintOut+0
ADD	SP, SP, #12
IT	AL
BAL	L_end_vRf4463Init
L_vRf4463Init274:
; ucFrequency start address is: 0 (R0)
CMP	R0, #1
IT	EQ
BEQ	L_vRf4463Init276
CMP	R0, #2
IT	EQ
BEQ	L_vRf4463Init277
; ucFrequency end address is: 0 (R0)
IT	AL
BAL	L_vRf4463Init278
L_vRf4463Init275:
LDRH	R5, [SP, #32]
MOVW	R4, #lo_addr(main_usRfNetwork+0)
MOVT	R4, #hi_addr(main_usRfNetwork+0)
STRB	R5, [R4, #0]
LDRB	R5, [SP, #28]
MOVW	R4, #lo_addr(main_ucRxChannel+0)
MOVT	R4, #hi_addr(main_ucRxChannel+0)
STRB	R5, [R4, #0]
LDRB	R5, [SP, #24]
MOVW	R4, #lo_addr(main_ucTxChannel+0)
MOVT	R4, #hi_addr(main_ucTxChannel+0)
STRB	R5, [R4, #0]
BL	_vRf4463PowerOnReset+0
MOVW	R1, #969
MOVW	R0, #lo_addr(_RF4463_CONFIGURATION_DATA+0)
MOVT	R0, #hi_addr(_RF4463_CONFIGURATION_DATA+0)
BL	_vRf4463SetConfiguration+0
ADD	R6, SP, #4
MOVS	R4, #0
STRB	R4, [R6, #0]
ADDS	R5, R6, #1
MOVS	R4, #0
STRB	R4, [R5, #0]
ADDS	R5, R6, #2
MOVS	R4, #33
STRB	R4, [R5, #0]
ADDS	R5, R6, #3
MOVS	R4, #32
STRB	R4, [R5, #0]
ADDS	R5, R6, #4
MOVS	R4, #39
STRB	R4, [R5, #0]
ADDS	R5, R6, #5
MOVS	R4, #11
STRB	R4, [R5, #0]
MOV	R2, R6
MOVS	R1, #19
MOVS	R0, #6
BL	_ucRf4463SetCommand+0
ADD	R4, SP, #4
MOVS	R1, #20
MOV	R0, R4
BL	_vBufferSetToZero+0
ADD	R5, SP, #4
MOVS	R4, #98
STRB	R4, [R5, #0]
MOV	R2, R5
MOVS	R1, #1
MOVS	R0, #0
BL	_ucRf4463SetProperty+0
ADD	R4, SP, #4
MOVS	R1, #20
MOV	R0, R4
BL	_vBufferSetToZero+0
ADD	R5, SP, #4
MOVS	R4, #0
STRB	R4, [R5, #0]
MOV	R2, R5
MOVS	R1, #1
MOVS	R0, #3
BL	_ucRf4463SetProperty+0
ADD	R4, SP, #4
MOVS	R1, #20
MOV	R0, R4
BL	_vBufferSetToZero+0
ADD	R6, SP, #4
MOVS	R4, #8
STRB	R4, [R6, #0]
ADDS	R5, R6, #1
MOVS	R4, #20
STRB	R4, [R5, #0]
ADDS	R5, R6, #2
MOVS	R4, #0
STRB	R4, [R5, #0]
ADDS	R5, R6, #3
MOVS	R4, #15
STRB	R4, [R5, #0]
ADDS	R5, R6, #4
MOVS	R4, #49
STRB	R4, [R5, #0]
ADDS	R5, R6, #5
MOVS	R4, #0
STRB	R4, [R5, #0]
ADDS	R5, R6, #6
MOVS	R4, #0
STRB	R4, [R5, #0]
ADDS	R5, R6, #7
MOVS	R4, #0
STRB	R4, [R5, #0]
ADDW	R5, R6, #8
MOVS	R4, #0
STRB	R4, [R5, #0]
MOV	R2, R6
MOVS	R1, #9
MOVW	R0, #4096
BL	_ucRf4463SetProperty+0
ADD	R6, SP, #4
LDRH	R4, [SP, #32]
LSRS	R4, R4, #8
STRB	R4, [R6, #0]
ADDS	R5, R6, #1
LDRH	R4, [SP, #32]
STRB	R4, [R5, #0]
MOVS	R1, #2
MOV	R0, R6
BL	_ucRf4463SetSyncWords+0
ADD	R5, SP, #4
MOVS	R4, #129
STRB	R4, [R5, #0]
MOV	R2, R5
MOVS	R1, #1
MOVW	R0, #4608
BL	_ucRf4463SetProperty+0
ADD	R5, SP, #4
MOVS	R4, #2
STRB	R4, [R5, #0]
MOV	R2, R5
MOVS	R1, #1
MOVW	R0, #4614
BL	_ucRf4463SetProperty+0
ADD	R6, SP, #4
MOVS	R4, #10
STRB	R4, [R6, #0]
ADDS	R5, R6, #1
MOVS	R4, #1
STRB	R4, [R5, #0]
ADDS	R5, R6, #2
MOVS	R4, #0
STRB	R4, [R5, #0]
ADDS	R5, R6, #3
MOVS	R4, #32
STRB	R4, [R5, #0]
ADDS	R5, R6, #4
MOVS	R4, #5
STRB	R4, [R5, #0]
MOV	R2, R6
MOVS	R1, #5
MOVW	R0, #4616
BL	_ucRf4463SetProperty+0
ADD	R6, SP, #4
MOVS	R4, #0
STRB	R4, [R6, #0]
ADDS	R5, R6, #1
MOVS	R4, #1
STRB	R4, [R5, #0]
ADDS	R5, R6, #2
MOVS	R4, #4
STRB	R4, [R5, #0]
ADDS	R5, R6, #3
MOVS	R4, #170
STRB	R4, [R5, #0]
ADDS	R5, R6, #4
MOVS	R4, #0
STRB	R4, [R5, #0]
ADDS	R5, R6, #5
MOVS	R4, #50
STRB	R4, [R5, #0]
ADDS	R5, R6, #6
MOVS	R4, #4
STRB	R4, [R5, #0]
ADDS	R5, R6, #7
MOVS	R4, #170
STRB	R4, [R5, #0]
ADDW	R5, R6, #8
MOVS	R4, #0
STRB	R4, [R5, #0]
ADDW	R5, R6, #9
MOVS	R4, #0
STRB	R4, [R5, #0]
ADDW	R5, R6, #10
MOVS	R4, #0
STRB	R4, [R5, #0]
ADDW	R5, R6, #11
MOVS	R4, #0
STRB	R4, [R5, #0]
MOV	R2, R6
MOVS	R1, #12
MOVW	R0, #4621
BL	_ucRf4463SetProperty+0
ADD	R6, SP, #4
MOVS	R4, #0
STRB	R4, [R6, #0]
ADDS	R5, R6, #1
MOVS	R4, #0
STRB	R4, [R5, #0]
ADDS	R5, R6, #2
MOVS	R4, #0
STRB	R4, [R5, #0]
ADDS	R5, R6, #3
MOVS	R4, #0
STRB	R4, [R5, #0]
ADDS	R5, R6, #4
MOVS	R4, #0
STRB	R4, [R5, #0]
ADDS	R5, R6, #5
MOVS	R4, #0
STRB	R4, [R5, #0]
ADDS	R5, R6, #6
MOVS	R4, #0
STRB	R4, [R5, #0]
ADDS	R5, R6, #7
MOVS	R4, #0
STRB	R4, [R5, #0]
MOV	R2, R6
MOVS	R1, #8
MOVW	R0, #4633
BL	_ucRf4463SetProperty+0
ADD	R5, SP, #4
MOVS	R4, #1
STRB	R4, [R5, #0]
MOV	R2, R5
MOVS	R1, #1
MOVW	R0, #8268
BL	_ucRf4463SetProperty+0
ADD	R6, SP, #4
MOVS	R4, #1
STRB	R4, [R6, #0]
ADDS	R5, R6, #1
MOVS	R4, #56
STRB	R4, [R5, #0]
ADDS	R5, R6, #2
MOVS	R4, #0
STRB	R4, [R5, #0]
MOV	R2, R6
MOVS	R1, #3
MOVW	R0, #256
BL	_ucRf4463SetProperty+0
LDRB	R0, [SP, #36]
BL	_ucRf4463SetTxPower+0
L_end_vRf4463Init:
LDR	LR, [SP, #0]
ADD	SP, SP, #40
BX	LR
; end of _vRf4463Init
_vRf4463PowerOnReset:
SUB	SP, SP, #12
STR	LR, [SP, #0]
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
MOVS	R0, #1
BL	_vRF4463SetPinSDN+0
MOVW	R7, #191
MOVT	R7, #0
NOP
NOP
L_vRf4463PowerOnReset279:
SUBS	R7, R7, #1
BNE	L_vRf4463PowerOnReset279
NOP
NOP
NOP
MOVS	R0, #0
BL	_vRF4463SetPinSDN+0
MOVW	R7, #6463
MOVT	R7, #1
NOP
NOP
L_vRf4463PowerOnReset281:
SUBS	R7, R7, #1
BNE	L_vRf4463PowerOnReset281
NOP
NOP
NOP
MOVS	R0, #0
BL	_vRF4463SetPinSelect+0
ADD	R0, SP, #4
MOV	R1, R0
MOVS	R0, #7
BL	_vRf4463SPIWriteBuffer+0
MOVS	R0, #1
BL	_vRF4463SetPinSelect+0
L_end_vRf4463PowerOnReset:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRf4463PowerOnReset
_vRf4463SetChannels:
; ucSetTxChannel start address is: 4 (R1)
; ucSetRxChannel start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
; ucSetTxChannel end address is: 4 (R1)
; ucSetRxChannel end address is: 0 (R0)
; ucSetRxChannel start address is: 0 (R0)
; ucSetTxChannel start address is: 4 (R1)
CMP	R1, #0
IT	EQ
BEQ	L__vRf4463SetChannels329
CMP	R1, #25
IT	HI
BHI	L__vRf4463SetChannels328
L__vRf4463SetChannels325:
CMP	R0, #0
IT	EQ
BEQ	L__vRf4463SetChannels327
CMP	R0, #25
IT	HI
BHI	L__vRf4463SetChannels326
L__vRf4463SetChannels324:
IT	AL
BAL	L_vRf4463SetChannels289
; ucSetRxChannel end address is: 0 (R0)
; ucSetTxChannel end address is: 4 (R1)
L__vRf4463SetChannels329:
L__vRf4463SetChannels328:
L__vRf4463SetChannels327:
L__vRf4463SetChannels326:
MOVS	R4, #0
SXTB	R4, R4
MOVW	R3, #lo_addr(?lstr_119_main+0)
MOVT	R3, #hi_addr(?lstr_119_main+0)
MOVW	R2, #lo_addr(_vDebugPrint+0)
MOVT	R2, #hi_addr(_vDebugPrint+0)
PUSH	(R4)
PUSH	(R3)
PUSH	(R2)
BL	_PrintOut+0
ADD	SP, SP, #12
IT	AL
BAL	L_end_vRf4463SetChannels
L_vRf4463SetChannels289:
; ucSetTxChannel start address is: 4 (R1)
; ucSetRxChannel start address is: 0 (R0)
MOVW	R3, #lo_addr(?lstr_120_main+0)
MOVT	R3, #hi_addr(?lstr_120_main+0)
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
MOVW	R3, #lo_addr(?lstr_121_main+0)
MOVT	R3, #hi_addr(?lstr_121_main+0)
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
MOVW	R2, #lo_addr(main_ucRxChannel+0)
MOVT	R2, #hi_addr(main_ucRxChannel+0)
STRB	R0, [R2, #0]
; ucSetRxChannel end address is: 0 (R0)
MOVW	R2, #lo_addr(main_ucTxChannel+0)
MOVT	R2, #hi_addr(main_ucTxChannel+0)
STRB	R1, [R2, #0]
; ucSetTxChannel end address is: 4 (R1)
L_end_vRf4463SetChannels:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRf4463SetChannels
_vRf4463SetNetwork:
; usNetwork start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
; usNetwork end address is: 0 (R0)
; usNetwork start address is: 0 (R0)
MOVS	R1, #0
STRB	R1, [SP, #8]
MOVS	R1, #0
STRB	R1, [SP, #9]
CMP	R0, #0
IT	NE
BNE	L_vRf4463SetNetwork290
; usNetwork end address is: 0 (R0)
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(?lstr_122_main+0)
MOVT	R2, #hi_addr(?lstr_122_main+0)
MOVW	R1, #lo_addr(_vDebugPrint+0)
MOVT	R1, #hi_addr(_vDebugPrint+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_PrintOut+0
ADD	SP, SP, #12
IT	AL
BAL	L_end_vRf4463SetNetwork
L_vRf4463SetNetwork290:
; usNetwork start address is: 0 (R0)
MOVW	R2, #lo_addr(?lstr_123_main+0)
MOVT	R2, #hi_addr(?lstr_123_main+0)
MOVW	R1, #lo_addr(_vDebugPrint+0)
MOVT	R1, #hi_addr(_vDebugPrint+0)
STRH	R0, [SP, #4]
PUSH	(R0)
PUSH	(R2)
PUSH	(R1)
BL	_PrintOut+0
ADD	SP, SP, #12
LDRH	R0, [SP, #4]
MOVW	R1, #lo_addr(main_usRfNetwork+0)
MOVT	R1, #hi_addr(main_usRfNetwork+0)
STRB	R0, [R1, #0]
ADD	R2, SP, #8
LSRS	R1, R0, #8
STRB	R1, [R2, #0]
ADDS	R1, R2, #1
STRB	R0, [R1, #0]
; usNetwork end address is: 0 (R0)
MOVS	R1, #2
MOV	R0, R2
BL	_ucRf4463SetSyncWords+0
L_end_vRf4463SetNetwork:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRf4463SetNetwork
_vRf4463SetConfiguration:
; pcParameters start address is: 0 (R0)
SUB	SP, SP, #48
STR	LR, [SP, #0]
STRH	R1, [SP, #44]
; pcParameters end address is: 0 (R0)
; pcParameters start address is: 0 (R0)
LDRH	R2, [SP, #44]
SUBS	R2, R2, #1
STRH	R2, [SP, #44]
LDRB	R2, [R0, #0]
ADDS	R6, R2, #1
UXTH	R6, R6
; usPosition start address is: 24 (R6)
; usPosition end address is: 24 (R6)
UXTH	R1, R6
L_vRf4463SetConfiguration291:
; usPosition start address is: 4 (R1)
; pcParameters start address is: 0 (R0)
; pcParameters end address is: 0 (R0)
LDRH	R2, [SP, #44]
CMP	R1, R2
IT	CS
BCS	L_vRf4463SetConfiguration292
; pcParameters end address is: 0 (R0)
; pcParameters start address is: 0 (R0)
ADDS	R2, R0, R1
LDRB	R2, [R2, #0]
SUBS	R4, R2, #1
STRB	R4, [SP, #46]
ADDS	R3, R1, #1
UXTH	R3, R3
; usPosition end address is: 4 (R1)
ADDS	R2, R0, R3
LDRB	R2, [R2, #0]
; ucCommand start address is: 24 (R6)
UXTB	R6, R2
ADDS	R2, R3, #1
UXTH	R2, R2
; usPosition start address is: 4 (R1)
UXTH	R1, R2
ADDS	R3, R0, R2
ADD	R2, SP, #12
STRH	R1, [SP, #4]
STR	R0, [SP, #8]
MOV	R1, R3
MOV	R0, R2
UXTB	R2, R4
BL	_memcpy+0
ADD	R2, SP, #12
UXTB	R1, R6
; ucCommand end address is: 24 (R6)
LDRB	R0, [SP, #46]
BL	_ucRf4463SetCommand+0
LDR	R0, [SP, #8]
LDRH	R1, [SP, #4]
LDRB	R2, [SP, #46]
ADDS	R2, R1, R2
; usPosition end address is: 4 (R1)
; usPosition start address is: 24 (R6)
UXTH	R6, R2
; pcParameters end address is: 0 (R0)
; usPosition end address is: 24 (R6)
UXTH	R1, R6
IT	AL
BAL	L_vRf4463SetConfiguration291
L_vRf4463SetConfiguration292:
L_end_vRf4463SetConfiguration:
LDR	LR, [SP, #0]
ADD	SP, SP, #48
BX	LR
; end of _vRf4463SetConfiguration
_ucRf4463SetCommand:
SUB	SP, SP, #16
STR	LR, [SP, #0]
STRB	R0, [SP, #4]
STRB	R1, [SP, #8]
STR	R2, [SP, #12]
BL	_ucRf4463CheckCTS+0
CMP	R0, #1
IT	NE
BNE	L_ucRf4463SetCommand293
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463SetCommand
L_ucRf4463SetCommand293:
MOVS	R0, #0
BL	_vRF4463SetPinSelect+0
LDRB	R0, [SP, #8]
BL	_ucRf4463SPIByte+0
LDR	R1, [SP, #12]
LDRB	R0, [SP, #4]
BL	_vRf4463SPIWriteBuffer+0
MOVS	R0, #1
BL	_vRF4463SetPinSelect+0
MOVS	R0, #0
L_end_ucRf4463SetCommand:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _ucRf4463SetCommand
_ucRf4463GetCommand:
SUB	SP, SP, #16
STR	LR, [SP, #0]
STRB	R0, [SP, #4]
STRB	R1, [SP, #8]
STR	R2, [SP, #12]
BL	_ucRf4463CheckCTS+0
CMP	R0, #1
IT	NE
BNE	L_ucRf4463GetCommand294
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463GetCommand
L_ucRf4463GetCommand294:
MOVS	R0, #0
BL	_vRF4463SetPinSelect+0
LDRB	R0, [SP, #8]
BL	_ucRf4463SPIByte+0
MOVS	R0, #1
BL	_vRF4463SetPinSelect+0
BL	_ucRf4463CheckCTS+0
CMP	R0, #1
IT	NE
BNE	L_ucRf4463GetCommand295
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463GetCommand
L_ucRf4463GetCommand295:
MOVS	R0, #0
BL	_vRF4463SetPinSelect+0
MOVS	R0, #68
BL	_ucRf4463SPIByte+0
LDR	R1, [SP, #12]
LDRB	R0, [SP, #4]
BL	_vRf4463SPIReadBuffer+0
MOVS	R0, #1
BL	_vRF4463SetPinSelect+0
MOVS	R0, #0
L_end_ucRf4463GetCommand:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _ucRf4463GetCommand
_ucRf4463SetProperty:
; usStartProperty start address is: 0 (R0)
SUB	SP, SP, #20
STR	LR, [SP, #0]
STRB	R1, [SP, #12]
UXTH	R1, R0
STR	R2, [SP, #16]
; usStartProperty end address is: 0 (R0)
; usStartProperty start address is: 4 (R1)
STRH	R1, [SP, #4]
BL	_ucRf4463CheckCTS+0
LDRH	R1, [SP, #4]
CMP	R0, #1
IT	NE
BNE	L_ucRf4463SetProperty296
; usStartProperty end address is: 4 (R1)
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463SetProperty
L_ucRf4463SetProperty296:
; usStartProperty start address is: 4 (R1)
ADD	R5, SP, #8
MOVS	R3, #17
STRB	R3, [R5, #0]
ADDS	R4, R5, #1
LSRS	R3, R1, #8
STRB	R3, [R4, #0]
ADDS	R4, R5, #2
LDRB	R3, [SP, #12]
STRB	R3, [R4, #0]
ADDS	R4, R5, #3
AND	R3, R1, #255
; usStartProperty end address is: 4 (R1)
STRB	R3, [R4, #0]
MOVS	R0, #0
BL	_vRF4463SetPinSelect+0
ADD	R3, SP, #8
MOV	R1, R3
MOVS	R0, #4
BL	_vRf4463SPIWriteBuffer+0
LDR	R1, [SP, #16]
LDRB	R0, [SP, #12]
BL	_vRf4463SPIWriteBuffer+0
MOVS	R0, #1
BL	_vRF4463SetPinSelect+0
MOVS	R0, #0
L_end_ucRf4463SetProperty:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _ucRf4463SetProperty
_ucRf4463GetProperty:
; usStartProperty start address is: 0 (R0)
SUB	SP, SP, #20
STR	LR, [SP, #0]
STRB	R1, [SP, #12]
UXTH	R1, R0
STR	R2, [SP, #16]
; usStartProperty end address is: 0 (R0)
; usStartProperty start address is: 4 (R1)
STRH	R1, [SP, #4]
BL	_ucRf4463CheckCTS+0
LDRH	R1, [SP, #4]
CMP	R0, #1
IT	NE
BNE	L_ucRf4463GetProperty297
; usStartProperty end address is: 4 (R1)
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463GetProperty
L_ucRf4463GetProperty297:
; usStartProperty start address is: 4 (R1)
ADD	R5, SP, #8
MOVS	R3, #18
STRB	R3, [R5, #0]
ADDS	R4, R5, #1
LSRS	R3, R1, #8
STRB	R3, [R4, #0]
ADDS	R4, R5, #2
LDRB	R3, [SP, #12]
STRB	R3, [R4, #0]
ADDS	R4, R5, #3
AND	R3, R1, #255
; usStartProperty end address is: 4 (R1)
STRB	R3, [R4, #0]
MOVS	R0, #0
BL	_vRF4463SetPinSelect+0
ADD	R3, SP, #8
MOV	R1, R3
MOVS	R0, #4
BL	_vRf4463SPIWriteBuffer+0
BL	_ucRf4463CheckCTS+0
CMP	R0, #1
IT	NE
BNE	L_ucRf4463GetProperty298
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463GetProperty
L_ucRf4463GetProperty298:
MOVS	R0, #0
BL	_vRF4463SetPinSelect+0
MOVS	R0, #68
BL	_ucRf4463SPIByte+0
LDR	R1, [SP, #16]
LDRB	R0, [SP, #12]
BL	_vRf4463SPIReadBuffer+0
MOVS	R0, #1
BL	_vRF4463SetPinSelect+0
MOVS	R0, #0
L_end_ucRf4463GetProperty:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _ucRf4463GetProperty
_ucRf4463SetSyncWords:
; ucLength start address is: 4 (R1)
; pcSyncWords start address is: 0 (R0)
SUB	SP, SP, #16
STR	LR, [SP, #0]
; ucLength end address is: 4 (R1)
; pcSyncWords end address is: 0 (R0)
; pcSyncWords start address is: 0 (R0)
; ucLength start address is: 4 (R1)
CMP	R1, #0
IT	EQ
BEQ	L__ucRf4463SetSyncWords332
CMP	R1, #3
IT	HI
BHI	L__ucRf4463SetSyncWords331
IT	AL
BAL	L_ucRf4463SetSyncWords301
; pcSyncWords end address is: 0 (R0)
; ucLength end address is: 4 (R1)
L__ucRf4463SetSyncWords332:
L__ucRf4463SetSyncWords331:
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463SetSyncWords
L_ucRf4463SetSyncWords301:
; ucLength start address is: 4 (R1)
; pcSyncWords start address is: 0 (R0)
ADD	R3, SP, #8
SUBS	R2, R1, #1
STRB	R2, [R3, #0]
ADDS	R2, R3, #1
STR	R0, [SP, #4]
; ucLength end address is: 4 (R1)
MOV	R0, R2
UXTB	R2, R1
; pcSyncWords end address is: 0 (R0)
LDR	R1, [SP, #4]
BL	_memcpy+0
ADD	R2, SP, #8
MOVS	R1, #5
MOVW	R0, #4352
BL	_ucRf4463SetProperty+0
L_end_ucRf4463SetSyncWords:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _ucRf4463SetSyncWords
_ucRf4463SetPreambleLength:
SUB	SP, SP, #8
STR	LR, [SP, #0]
STRB	R0, [SP, #4]
ADD	R1, SP, #4
MOV	R2, R1
MOVS	R1, #1
MOVW	R0, #4096
BL	_ucRf4463SetProperty+0
L_end_ucRf4463SetPreambleLength:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRf4463SetPreambleLength
_ucRf4463CheckCTS:
SUB	SP, SP, #4
STR	LR, [SP, #0]
; usTimeoutCounter start address is: 8 (R2)
MOVW	R2, #2500
; usTimeoutCounter end address is: 8 (R2)
L_ucRf4463CheckCTS302:
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
BEQ	L_ucRf4463CheckCTS303
; usTimeoutCounter end address is: 16 (R4)
; usTimeoutCounter start address is: 16 (R4)
MOVS	R0, #0
BL	_vRF4463SetPinSelect+0
MOVS	R0, #68
BL	_ucRf4463SPIByte+0
MOVS	R0, #68
BL	_ucRf4463SPIByte+0
CMP	R0, #255
IT	NE
BNE	L_ucRf4463CheckCTS304
; usTimeoutCounter end address is: 16 (R4)
MOVS	R0, #1
BL	_vRF4463SetPinSelect+0
MOVS	R0, #0
IT	AL
BAL	L_end_ucRf4463CheckCTS
L_ucRf4463CheckCTS304:
; usTimeoutCounter start address is: 16 (R4)
MOVS	R0, #1
BL	_vRF4463SetPinSelect+0
UXTH	R2, R4
; usTimeoutCounter end address is: 16 (R4)
IT	AL
BAL	L_ucRf4463CheckCTS302
L_ucRf4463CheckCTS303:
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
MOVS	R0, #1
L_end_ucRf4463CheckCTS:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ucRf4463CheckCTS
_vRf4463RSSI:
SUB	SP, SP, #20
STR	LR, [SP, #0]
ADD	R2, SP, #13
MOVS	R0, #32
STRB	R0, [R2, #0]
ADDS	R1, R2, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
ADDS	R1, R2, #2
MOVS	R0, #78
STRB	R0, [R1, #0]
ADDS	R1, R2, #3
MOVS	R0, #64
STRB	R0, [R1, #0]
MOVS	R1, #17
MOVS	R0, #4
BL	_ucRf4463SetCommand+0
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #34
MOVS	R0, #9
BL	_ucRf4463GetCommand+0
ADD	R0, SP, #4
ADDS	R0, R0, #4
LDRB	R0, [R0, #0]
LSRS	R0, R0, #1
UXTB	R0, R0
SUBS	R0, #64
SXTH	R0, R0
SUBW	R1, R0, #60
MOVW	R0, #lo_addr(main_intRFLastRSSI+0)
MOVT	R0, #hi_addr(main_intRFLastRSSI+0)
STRH	R1, [R0, #0]
SXTH	R2, R1
MOVW	R1, #lo_addr(?lstr_125_main+0)
MOVT	R1, #hi_addr(?lstr_125_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
L_end_vRf4463RSSI:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _vRf4463RSSI
_xRF4463GetLastRSSI:
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOVW	R0, #lo_addr(main_intRFLastRSSI+0)
MOVT	R0, #hi_addr(main_intRFLastRSSI+0)
LDRSH	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_126_main+0)
MOVT	R1, #hi_addr(?lstr_126_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
MOVW	R0, #lo_addr(main_intRFLastRSSI+0)
MOVT	R0, #hi_addr(main_intRFLastRSSI+0)
LDRSH	R0, [R0, #0]
L_end_xRF4463GetLastRSSI:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _xRF4463GetLastRSSI
_ucRf4463DeviceAvailability:
SUB	SP, SP, #16
STR	LR, [SP, #0]
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #1
MOVS	R0, #9
BL	_ucRf4463GetCommand+0
CMP	R0, #1
IT	NE
BNE	L_ucRf4463DeviceAvailability305
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463DeviceAvailability
L_ucRf4463DeviceAvailability305:
ADD	R2, SP, #4
ADDS	R0, R2, #2
LDRB	R0, [R0, #0]
LSLS	R1, R0, #8
UXTH	R1, R1
ADDS	R0, R2, #3
LDRB	R0, [R0, #0]
ORRS	R1, R0
UXTH	R1, R1
MOVW	R0, #17507
CMP	R1, R0
IT	EQ
BEQ	L_ucRf4463DeviceAvailability306
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463DeviceAvailability
L_ucRf4463DeviceAvailability306:
MOVS	R0, #0
L_end_ucRf4463DeviceAvailability:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _ucRf4463DeviceAvailability
_ucRf4463SetGPIOMode:
; ucGPIO1Mode start address is: 4 (R1)
; ucGPIO0Mode start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
; ucGPIO1Mode end address is: 4 (R1)
; ucGPIO0Mode end address is: 0 (R0)
; ucGPIO0Mode start address is: 0 (R0)
; ucGPIO1Mode start address is: 4 (R1)
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
ADD	R3, SP, #4
STRB	R0, [R3, #0]
; ucGPIO0Mode end address is: 0 (R0)
ADDS	R2, R3, #1
STRB	R1, [R2, #0]
; ucGPIO1Mode end address is: 4 (R1)
MOV	R2, R3
MOVS	R1, #19
MOVS	R0, #6
BL	_ucRf4463SetCommand+0
L_end_ucRf4463SetGPIOMode:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _ucRf4463SetGPIOMode
_vRf4463FIFOReset:
SUB	SP, SP, #8
STR	LR, [SP, #0]
MOVS	R0, #3
STRB	R0, [SP, #4]
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #21
MOVS	R0, #1
BL	_ucRf4463SetCommand+0
L_end_vRf4463FIFOReset:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vRf4463FIFOReset
_ucRf4463ClearInterrupts:
SUB	SP, SP, #8
STR	LR, [SP, #0]
MOVS	R0, #0
STRB	R0, [SP, #4]
MOVS	R0, #0
STRB	R0, [SP, #5]
MOVS	R0, #0
STRB	R0, [SP, #6]
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #32
MOVS	R0, #3
BL	_ucRf4463SetCommand+0
L_end_ucRf4463ClearInterrupts:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRf4463ClearInterrupts
_ucRf4463EnterStandbyMode:
SUB	SP, SP, #8
STR	LR, [SP, #0]
MOVS	R0, #1
STRB	R0, [SP, #4]
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #52
MOVS	R0, #1
BL	_ucRf4463SetCommand+0
L_end_ucRf4463EnterStandbyMode:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRf4463EnterStandbyMode
_vRf4463EnterTxMode:
SUB	SP, SP, #8
STR	LR, [SP, #0]
MOVS	R0, #0
STRB	R0, [SP, #4]
MOVS	R0, #48
STRB	R0, [SP, #5]
MOVS	R0, #0
STRB	R0, [SP, #6]
MOVS	R0, #0
STRB	R0, [SP, #7]
ADD	R1, SP, #4
MOVW	R0, #lo_addr(main_ucTxChannel+0)
MOVT	R0, #hi_addr(main_ucTxChannel+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
MOV	R2, R1
MOVS	R1, #49
MOVS	R0, #4
BL	_ucRf4463SetCommand+0
L_end_vRf4463EnterTxMode:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vRf4463EnterTxMode
_ucRf4463SetTxInterrupt:
SUB	SP, SP, #8
STR	LR, [SP, #0]
MOVS	R0, #1
STRB	R0, [SP, #4]
MOVS	R0, #32
STRB	R0, [SP, #5]
MOVS	R0, #0
STRB	R0, [SP, #6]
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #3
MOVW	R0, #256
BL	_ucRf4463SetProperty+0
L_end_ucRf4463SetTxInterrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRf4463SetTxInterrupt
_ucRf4463SetTxPower:
; ucPower start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; ucPower end address is: 0 (R0)
; ucPower start address is: 0 (R0)
MOVS	R1, #8
STRB	R1, [SP, #4]
MOVS	R1, #0
STRB	R1, [SP, #5]
MOVS	R1, #0
STRB	R1, [SP, #6]
MOVS	R1, #61
STRB	R1, [SP, #7]
CMP	R0, #127
IT	LS
BLS	L__ucRf4463SetTxPower348
MOVW	R2, #lo_addr(?lstr_127_main+0)
MOVT	R2, #hi_addr(?lstr_127_main+0)
MOVW	R1, #lo_addr(_vDebugPrint+0)
MOVT	R1, #hi_addr(_vDebugPrint+0)
PUSH	(R0)
; ucPower end address is: 0 (R0)
PUSH	(R2)
PUSH	(R1)
BL	_PrintOut+0
ADD	SP, SP, #12
; ucPower start address is: 0 (R0)
MOVS	R0, #127
; ucPower end address is: 0 (R0)
IT	AL
BAL	L_ucRf4463SetTxPower307
L__ucRf4463SetTxPower348:
L_ucRf4463SetTxPower307:
; ucPower start address is: 0 (R0)
ADD	R2, SP, #4
ADDS	R1, R2, #1
STRB	R0, [R1, #0]
; ucPower end address is: 0 (R0)
MOVS	R1, #4
MOVW	R0, #8704
BL	_ucRf4463SetProperty+0
L_end_ucRf4463SetTxPower:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRf4463SetTxPower
_vRf4463WriteTxFIFO:
; pcWriteBuffer start address is: 0 (R0)
SUB	SP, SP, #76
STR	LR, [SP, #0]
STRB	R1, [SP, #72]
; pcWriteBuffer end address is: 0 (R0)
; pcWriteBuffer start address is: 0 (R0)
ADD	R2, SP, #72
STR	R0, [SP, #4]
MOVS	R1, #1
MOVW	R0, #4626
BL	_ucRf4463SetProperty+0
LDR	R0, [SP, #4]
ADD	R3, SP, #8
LDRB	R2, [SP, #72]
STRB	R2, [R3, #0]
ADDS	R2, R3, #1
MOV	R1, R0
MOV	R0, R2
; pcWriteBuffer end address is: 0 (R0)
LDRB	R2, [SP, #72]
BL	_memcpy+0
ADD	R3, SP, #8
LDRB	R2, [SP, #72]
ADDS	R2, R2, #1
MOVS	R1, #102
UXTB	R0, R2
MOV	R2, R3
BL	_ucRf4463SetCommand+0
L_end_vRf4463WriteTxFIFO:
LDR	LR, [SP, #0]
ADD	SP, SP, #76
BX	LR
; end of _vRf4463WriteTxFIFO
_ucRf4463TxPacket:
SUB	SP, SP, #12
STR	LR, [SP, #0]
STR	R0, [SP, #4]
STRB	R1, [SP, #8]
BL	_vRf4463FIFOReset+0
LDRB	R1, [SP, #8]
LDR	R0, [SP, #4]
BL	_vRf4463WriteTxFIFO+0
BL	_vRf4463EnterTxMode+0
MOVS	R0, #0
L_end_ucRf4463TxPacket:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _ucRf4463TxPacket
_ucRf4463TxPacket_Seq:
SUB	SP, SP, #12
STR	LR, [SP, #0]
STR	R0, [SP, #4]
STRB	R1, [SP, #8]
BL	_vRf4463FIFOReset+0
LDRB	R1, [SP, #8]
LDR	R0, [SP, #4]
BL	_vRf4463WriteTxFIFO+0
BL	_ucRf4463ClearInterrupts+0
BL	_vRf4463EnterTxMode+0
L_ucRf4463TxPacket_Seq308:
BL	_ucRF4463GetIRQFlag+0
CMP	R0, #1
IT	NE
BNE	L_ucRf4463TxPacket_Seq311
IT	AL
BAL	L_ucRf4463TxPacket_Seq309
L_ucRf4463TxPacket_Seq311:
IT	AL
BAL	L_ucRf4463TxPacket_Seq308
L_ucRf4463TxPacket_Seq309:
MOVS	R0, #0
L_end_ucRf4463TxPacket_Seq:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _ucRf4463TxPacket_Seq
_vRf4463EnterRxMode:
SUB	SP, SP, #12
STR	LR, [SP, #0]
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
ADD	R1, SP, #4
MOVW	R0, #lo_addr(main_ucRxChannel+0)
MOVT	R0, #hi_addr(main_ucRxChannel+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
MOV	R2, R1
MOVS	R1, #50
MOVS	R0, #7
BL	_ucRf4463SetCommand+0
L_end_vRf4463EnterRxMode:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRf4463EnterRxMode
_ucRf4463SetRxInterrupt:
SUB	SP, SP, #8
STR	LR, [SP, #0]
MOVS	R0, #3
STRB	R0, [SP, #4]
MOVS	R0, #24
STRB	R0, [SP, #5]
MOVS	R0, #0
STRB	R0, [SP, #6]
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #3
MOVW	R0, #256
BL	_ucRf4463SetProperty+0
L_end_ucRf4463SetRxInterrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRf4463SetRxInterrupt
_ucRf4463RxInit:
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOVS	R2, #64
MOVS	R1, #1
MOVW	R0, #4626
BL	_ucRf4463SetProperty+0
BL	_vRf4463FIFOReset+0
BL	_vRf4463EnterRxMode+0
MOVS	R0, #0
L_end_ucRf4463RxInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ucRf4463RxInit
_ucRf4463RxPacket:
; pcRxBuffer start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; pcRxBuffer end address is: 0 (R0)
; pcRxBuffer start address is: 0 (R0)
MOVS	R1, #0
STRB	R1, [SP, #4]
; pcRxBuffer end address is: 0 (R0)
BL	_vRf4463ReadRxFIFO+0
BL	_vRf4463FIFOReset+0
LDRB	R0, [SP, #4]
L_end_ucRf4463RxPacket:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRf4463RxPacket
_vRf4463ReadRxFIFO:
SUB	SP, SP, #12
STR	LR, [SP, #0]
STR	R0, [SP, #8]
BL	_ucRf4463CheckCTS+0
CMP	R0, #1
IT	NE
BNE	L_vRf4463ReadRxFIFO312
IT	AL
BAL	L_end_vRf4463ReadRxFIFO
L_vRf4463ReadRxFIFO312:
MOVS	R0, #0
BL	_vRF4463SetPinSelect+0
MOVS	R0, #119
BL	_ucRf4463SPIByte+0
ADD	R1, SP, #4
MOVS	R0, #1
BL	_vRf4463SPIReadBuffer+0
LDR	R1, [SP, #8]
MOVS	R0, #64
BL	_vRf4463SPIReadBuffer+0
MOVS	R0, #1
BL	_vRF4463SetPinSelect+0
BL	_vRf4463RSSI+0
L_end_vRf4463ReadRxFIFO:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRf4463ReadRxFIFO
_ucRF4463GetModemStatus:
SUB	SP, SP, #8
STR	LR, [SP, #0]
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #34
MOVS	R0, #3
BL	_ucRf4463GetCommand+0
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
ADD	R0, SP, #4
LDRB	R0, [R0, #0]
UXTB	R2, R0
MOVW	R1, #lo_addr(?lstr_129_main+0)
MOVT	R1, #hi_addr(?lstr_129_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
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
ADD	R0, SP, #4
ADDS	R0, R0, #2
LDRB	R0, [R0, #0]
L_end_ucRF4463GetModemStatus:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRF4463GetModemStatus
_ucRF4463GetIntStatus:
SUB	SP, SP, #16
STR	LR, [SP, #0]
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #32
MOVS	R0, #9
BL	_ucRf4463GetCommand+0
ADD	R0, SP, #4
ADDS	R0, #8
LDRB	R0, [R0, #0]
CMP	R0, #48
IT	NE
BNE	L_ucRF4463GetIntStatus313
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_132_main+0)
MOVT	R1, #hi_addr(?lstr_132_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
MOVS	R0, #1
IT	AL
BAL	L_end_ucRF4463GetIntStatus
L_ucRF4463GetIntStatus313:
MOVS	R0, #0
L_end_ucRF4463GetIntStatus:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _ucRF4463GetIntStatus
_ucRF4463CheckIntStatus:
SUB	SP, SP, #16
STR	LR, [SP, #0]
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #32
MOVS	R0, #9
BL	_ucRf4463GetCommand+0
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_133_main+0)
MOVT	R1, #hi_addr(?lstr_133_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
ADD	R0, SP, #4
ADDS	R0, R0, #1
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
ADD	R0, SP, #4
ADDS	R0, R0, #2
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
ADD	R0, SP, #4
ADDS	R0, R0, #3
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
ADD	R0, SP, #4
ADDS	R0, R0, #4
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
ADD	R0, SP, #4
ADDS	R0, R0, #5
LDRB	R0, [R0, #0]
UXTB	R2, R0
MOVW	R1, #lo_addr(?lstr_138_main+0)
MOVT	R1, #hi_addr(?lstr_138_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
ADD	R0, SP, #4
ADDS	R0, R0, #6
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
ADD	R0, SP, #4
ADDS	R0, R0, #7
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
ADD	R0, SP, #4
ADDS	R0, #8
LDRB	R0, [R0, #0]
UXTB	R2, R0
MOVW	R1, #lo_addr(?lstr_141_main+0)
MOVT	R1, #hi_addr(?lstr_141_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
ADD	R0, SP, #4
ADDS	R0, #8
LDRB	R0, [R0, #0]
AND	R0, R0, #32
L_end_ucRF4463CheckIntStatus:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _ucRF4463CheckIntStatus
_vRF4463CheckState:
SUB	SP, SP, #8
STR	LR, [SP, #0]
BL	_ucRf4463CheckCTS+0
CMP	R0, #1
IT	NE
BNE	L_vRF4463CheckState314
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
IT	AL
BAL	L_end_vRF4463CheckState
L_vRF4463CheckState314:
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #51
MOVS	R0, #3
BL	_ucRf4463GetCommand+0
ADD	R0, SP, #4
ADDS	R0, R0, #1
LDRB	R0, [R0, #0]
UXTB	R2, R0
MOVW	R1, #lo_addr(?lstr_143_main+0)
MOVT	R1, #hi_addr(?lstr_143_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
ADD	R0, SP, #4
ADDS	R0, R0, #2
LDRB	R0, [R0, #0]
UXTB	R2, R0
MOVW	R1, #lo_addr(?lstr_144_main+0)
MOVT	R1, #hi_addr(?lstr_144_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
L_end_vRF4463CheckState:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vRF4463CheckState
_vRF4463SetState:
; ucState start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; ucState end address is: 0 (R0)
; ucState start address is: 0 (R0)
ADD	R1, SP, #4
STRB	R0, [R1, #0]
; ucState end address is: 0 (R0)
MOV	R2, R1
MOVS	R1, #52
MOVS	R0, #1
BL	_ucRf4463SetCommand+0
L_end_vRF4463SetState:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vRF4463SetState
_vRf4463SPIWriteBuffer:
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
L_vRf4463SPIWriteBuffer315:
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
BEQ	L_vRf4463SPIWriteBuffer316
; usWriteLength end address is: 16 (R4)
; usWriteLength start address is: 16 (R4)
LDRB	R2, [R5, #0]
UXTB	R0, R2
BL	_ucRf4463SPIByte+0
ADDS	R5, R5, #1
UXTH	R0, R4
; usWriteLength end address is: 16 (R4)
; pcWriteBuffer end address is: 20 (R5)
IT	AL
BAL	L_vRf4463SPIWriteBuffer315
L_vRf4463SPIWriteBuffer316:
L_end_vRf4463SPIWriteBuffer:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vRf4463SPIWriteBuffer
_vRf4463SPIReadBuffer:
; pcReadBuffer start address is: 4 (R1)
; usReadLength start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; pcReadBuffer end address is: 4 (R1)
; usReadLength end address is: 0 (R0)
; usReadLength start address is: 0 (R0)
; pcReadBuffer start address is: 4 (R1)
; ucRxCounter start address is: 20 (R5)
MOVS	R5, #0
; pcReadBuffer end address is: 4 (R1)
; usReadLength end address is: 0 (R0)
; ucRxCounter end address is: 20 (R5)
MOV	R4, R1
L_vRf4463SPIReadBuffer317:
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
BEQ	L_vRf4463SPIReadBuffer318
; pcReadBuffer end address is: 16 (R4)
; usReadLength end address is: 24 (R6)
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
UXTH	R0, R6
; pcReadBuffer end address is: 16 (R4)
; usReadLength end address is: 24 (R6)
; ucRxCounter end address is: 20 (R5)
IT	AL
BAL	L_vRf4463SPIReadBuffer317
L_vRf4463SPIReadBuffer318:
L_end_vRf4463SPIReadBuffer:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vRf4463SPIReadBuffer
_ucRf4463SPIByte:
; pcWriteData start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; pcWriteData end address is: 0 (R0)
; pcWriteData start address is: 0 (R0)
; pcWriteData end address is: 0 (R0)
BL	_SPI2_Read+0
UXTB	R0, R0
L_end_ucRf4463SPIByte:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ucRf4463SPIByte
_vButtonISR:
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_LX	[R0, ByteOffset(EXTI_PR+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vButtonISR319
MOVS	R1, #1
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_SX	[R0, ByteOffset(EXTI_PR+0)]
L_vButtonISR319:
L_end_vButtonISR:
BX	LR
; end of _vButtonISR
_vButtonSetup:
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOVW	R1, #256
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Input+0
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB2ENRbits+0)
MOVT	R0, #hi_addr(RCC_APB2ENRbits+0)
_SX	[R0, ByteOffset(RCC_APB2ENRbits+0)]
MOVW	R0, #lo_addr(AFIO_EXTICR3+0)
MOVT	R0, #hi_addr(AFIO_EXTICR3+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(AFIO_EXTICR3+0)
MOVT	R0, #hi_addr(AFIO_EXTICR3+0)
STR	R1, [R0, #0]
MOVS	R1, #1
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
_SX	[R0, ByteOffset(EXTI_IMR+0)]
MOVS	R1, #1
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
_SX	[R0, ByteOffset(EXTI_FTSR+0)]
MOVW	R0, #39
BL	_NVIC_IntEnable+0
L_end_vButtonSetup:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vButtonSetup
_Timer6_interrupt:
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM6_SR+0)
MOVT	R0, #hi_addr(TIM6_SR+0)
_SX	[R0, ByteOffset(TIM6_SR+0)]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_LX	[R0, ByteOffset(GPIOC_ODR+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
L_end_Timer6_interrupt:
BX	LR
; end of _Timer6_interrupt
_vTimerStop:
; ucTimer start address is: 0 (R0)
SUB	SP, SP, #4
; ucTimer end address is: 0 (R0)
; ucTimer start address is: 0 (R0)
CMP	R0, #0
IT	NE
BNE	L_vTimerStop320
; ucTimer end address is: 0 (R0)
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(TIM6_CR1+0)
MOVT	R1, #hi_addr(TIM6_CR1+0)
_SX	[R1, ByteOffset(TIM6_CR1+0)]
L_vTimerStop320:
L_end_vTimerStop:
ADD	SP, SP, #4
BX	LR
; end of _vTimerStop
_vTimerSearchLed:
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
_SX	[R0, ByteOffset(RCC_APB1ENR+0)]
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM6_CR1+0)
MOVT	R0, #hi_addr(TIM6_CR1+0)
_SX	[R0, ByteOffset(TIM6_CR1+0)]
MOVW	R1, #575
MOVW	R0, #lo_addr(TIM6_PSC+0)
MOVT	R0, #hi_addr(TIM6_PSC+0)
STR	R1, [R0, #0]
MOVW	R1, #62499
MOVW	R0, #lo_addr(TIM6_ARR+0)
MOVT	R0, #hi_addr(TIM6_ARR+0)
STR	R1, [R0, #0]
MOVW	R0, #70
BL	_NVIC_IntEnable+0
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM6_DIER+0)
MOVT	R0, #hi_addr(TIM6_DIER+0)
_SX	[R0, ByteOffset(TIM6_DIER+0)]
MOVW	R0, #lo_addr(TIM6_CR1+0)
MOVT	R0, #hi_addr(TIM6_CR1+0)
_SX	[R0, ByteOffset(TIM6_CR1+0)]
L_end_vTimerSearchLed:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vTimerSearchLed
_main:
SUB	SP, SP, #4
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_main321:
SUBS	R7, R7, #1
BNE	L_main321
NOP
NOP
NOP
MOVW	R1, #64
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
MOVW	R1, #128
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
MOVW	R1, #256
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
MOVW	R1, #128
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
MOVS	R1, #7
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
BL	_Sound_Init+0
MOVS	R1, #100
MOVW	R0, #1000
BL	_Sound_Play+0
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
BL	_vUARTTxInit+0
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_145_main+0)
MOVT	R1, #hi_addr(?lstr_145_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
MOVS	R3, #127
MOVS	R2, #5
MOVS	R1, #5
MOVS	R0, #5
BL	_ucRF4463Setup+0
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
BL	_vDongleLoop+0
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
