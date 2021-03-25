_vDebugPrint:
; ucPrintData start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; ucPrintData end address is: 0 (R0)
; ucPrintData start address is: 0 (R0)
; ucPrintData end address is: 0 (R0)
BL	_vUART1_Write+0
L_end_vDebugPrint:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vDebugPrint
_vISR_EXTI0_Callback:
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_LX	[R0, ByteOffset(EXTI_PR+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vISR_EXTI0_Callback0
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_SX	[R0, ByteOffset(EXTI_PR+0)]
BL	_ucRf4463ClearInterrupts+0
MOVS	R1, #1
MOVW	R0, #lo_addr(main_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(main_ucRF4463IRQ+0)
STRB	R1, [R0, #0]
L_vISR_EXTI0_Callback0:
L_end_vISR_EXTI0_Callback:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vISR_EXTI0_Callback
_vRF4463MesageHandler:
SUB	SP, SP, #28
STR	LR, [SP, #0]
MOVW	R0, #lo_addr(_ucRFTxEventPending+0)
MOVT	R0, #hi_addr(_ucRFTxEventPending+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_vRF4463MesageHandler1
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
BL	_ucRf4463RxPacket+0
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	LS
BLS	L_vRF4463MesageHandler2
ADD	R11, SP, #4
ADD	R10, R11, #23
MOVW	R12, #lo_addr(?ICS?lstr1_main+0)
MOVT	R12, #hi_addr(?ICS?lstr1_main+0)
BL	___CC2DW+0
ADD	R0, SP, #4
BL	_vUART1_Write_Text+0
; usRxCounter start address is: 8 (R2)
MOVS	R2, #0
; usRxCounter end address is: 8 (R2)
L_vRF4463MesageHandler3:
; usRxCounter start address is: 8 (R2)
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
LDRB	R0, [R0, #0]
CMP	R2, R0
IT	CS
BCS	L_vRF4463MesageHandler4
MOVW	R0, #lo_addr(_pcRF4463RxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463RxBuffer+0)
ADDS	R0, R0, R2
LDRB	R0, [R0, #0]
BL	_vUART1_Write+0
ADDS	R2, R2, #1
UXTB	R2, R2
; usRxCounter end address is: 8 (R2)
IT	AL
BAL	L_vRF4463MesageHandler3
L_vRF4463MesageHandler4:
MOVS	R0, #13
BL	_vUART1_Write+0
MOVS	R0, #10
BL	_vUART1_Write+0
L_vRF4463MesageHandler2:
IT	AL
BAL	L_vRF4463MesageHandler6
L_vRF4463MesageHandler1:
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucRFTxEventPending+0)
MOVT	R0, #hi_addr(_ucRFTxEventPending+0)
STRB	R1, [R0, #0]
L_vRF4463MesageHandler6:
BL	_ucRf4463RxInit+0
L_end_vRF4463MesageHandler:
LDR	LR, [SP, #0]
ADD	SP, SP, #28
BX	LR
; end of _vRF4463MesageHandler
_vRF4463TxMessage:
; ucRemoteNode start address is: 8 (R2)
; ucLength start address is: 4 (R1)
; pcOutBuffer start address is: 0 (R0)
SUB	SP, SP, #28
STR	LR, [SP, #0]
MOV	R5, R0
UXTB	R6, R1
UXTB	R7, R2
; ucRemoteNode end address is: 8 (R2)
; ucLength end address is: 4 (R1)
; pcOutBuffer end address is: 0 (R0)
; pcOutBuffer start address is: 20 (R5)
; ucLength start address is: 24 (R6)
; ucRemoteNode start address is: 28 (R7)
MOVW	R3, #lo_addr(_ucRFTxEventPending+0)
MOVT	R3, #hi_addr(_ucRFTxEventPending+0)
LDRB	R3, [R3, #0]
CMP	R3, #1
IT	NE
BNE	L_vRF4463TxMessage7
; pcOutBuffer end address is: 20 (R5)
; ucLength end address is: 24 (R6)
; ucRemoteNode end address is: 28 (R7)
MOVS	R5, #0
SXTB	R5, R5
MOVW	R4, #lo_addr(?lstr_2_main+0)
MOVT	R4, #hi_addr(?lstr_2_main+0)
MOVW	R3, #lo_addr(_vDebugPrint+0)
MOVT	R3, #hi_addr(_vDebugPrint+0)
PUSH	(R5)
PUSH	(R4)
PUSH	(R3)
BL	_PrintOut+0
ADD	SP, SP, #12
IT	AL
BAL	L_end_vRF4463TxMessage
L_vRF4463TxMessage7:
; ucRemoteNode start address is: 28 (R7)
; ucLength start address is: 24 (R6)
; pcOutBuffer start address is: 20 (R5)
MOVS	R1, #64
MOVW	R0, #lo_addr(_pcRF4463TxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463TxBuffer+0)
BL	_vBufferSetToZero+0
ADDS	R3, R6, #3
SXTH	R3, R3
CMP	R3, #64
IT	LT
BLT	L_vRF4463TxMessage8
; pcOutBuffer end address is: 20 (R5)
; ucLength end address is: 24 (R6)
; ucRemoteNode end address is: 28 (R7)
MOVS	R5, #0
SXTB	R5, R5
MOVW	R4, #lo_addr(?lstr_3_main+0)
MOVT	R4, #hi_addr(?lstr_3_main+0)
MOVW	R3, #lo_addr(_vDebugPrint+0)
MOVT	R3, #hi_addr(_vDebugPrint+0)
PUSH	(R5)
PUSH	(R4)
PUSH	(R3)
BL	_PrintOut+0
ADD	SP, SP, #12
IT	AL
BAL	L_end_vRF4463TxMessage
L_vRF4463TxMessage8:
; ucRemoteNode start address is: 28 (R7)
; ucLength start address is: 24 (R6)
; pcOutBuffer start address is: 20 (R5)
ADDS	R4, R6, #3
MOVW	R3, #lo_addr(_pcRF4463TxBuffer+0)
MOVT	R3, #hi_addr(_pcRF4463TxBuffer+0)
STRB	R4, [R3, #0]
MOVW	R3, #lo_addr(_pcRF4463TxBuffer+1)
MOVT	R3, #hi_addr(_pcRF4463TxBuffer+1)
STRB	R7, [R3, #0]
; ucRemoteNode end address is: 28 (R7)
MOVS	R4, #1
MOVW	R3, #lo_addr(_pcRF4463TxBuffer+2)
MOVT	R3, #hi_addr(_pcRF4463TxBuffer+2)
STRB	R4, [R3, #0]
CMP	R6, #0
IT	LS
BLS	L_vRF4463TxMessage9
; ucCounter start address is: 8 (R2)
MOVS	R2, #0
; pcOutBuffer end address is: 20 (R5)
; ucLength end address is: 24 (R6)
; ucCounter end address is: 8 (R2)
MOV	R1, R5
UXTB	R0, R6
L_vRF4463TxMessage10:
; ucCounter start address is: 8 (R2)
; pcOutBuffer start address is: 4 (R1)
; ucLength start address is: 0 (R0)
; pcOutBuffer start address is: 4 (R1)
; pcOutBuffer end address is: 4 (R1)
CMP	R2, R0
IT	CS
BCS	L_vRF4463TxMessage11
; pcOutBuffer end address is: 4 (R1)
; pcOutBuffer start address is: 4 (R1)
ADDS	R4, R2, #3
SXTH	R4, R4
MOVW	R3, #lo_addr(_pcRF4463TxBuffer+0)
MOVT	R3, #hi_addr(_pcRF4463TxBuffer+0)
ADDS	R4, R3, R4
ADDS	R3, R1, R2
LDRB	R3, [R3, #0]
STRB	R3, [R4, #0]
ADDS	R2, R2, #1
UXTB	R2, R2
; ucLength end address is: 0 (R0)
; pcOutBuffer end address is: 4 (R1)
; ucCounter end address is: 8 (R2)
IT	AL
BAL	L_vRF4463TxMessage10
L_vRF4463TxMessage11:
L_vRF4463TxMessage9:
ADD	R11, SP, #4
ADD	R10, R11, #23
MOVW	R12, #lo_addr(?ICS?lstr4_main+0)
MOVT	R12, #hi_addr(?ICS?lstr4_main+0)
BL	___CC2DW+0
ADD	R3, SP, #4
MOV	R0, R3
BL	_vUART1_Write_Text+0
; ucCounter start address is: 8 (R2)
MOVS	R2, #0
; ucCounter end address is: 8 (R2)
L_vRF4463TxMessage13:
; ucCounter start address is: 8 (R2)
MOVW	R3, #lo_addr(_pcRF4463TxBuffer+0)
MOVT	R3, #hi_addr(_pcRF4463TxBuffer+0)
LDRB	R3, [R3, #0]
CMP	R2, R3
IT	CS
BCS	L_vRF4463TxMessage14
MOVW	R3, #lo_addr(_pcRF4463TxBuffer+0)
MOVT	R3, #hi_addr(_pcRF4463TxBuffer+0)
ADDS	R3, R3, R2
LDRB	R3, [R3, #0]
UXTB	R0, R3
BL	_vUART1_Write+0
ADDS	R2, R2, #1
UXTB	R2, R2
; ucCounter end address is: 8 (R2)
IT	AL
BAL	L_vRF4463TxMessage13
L_vRF4463TxMessage14:
MOVS	R0, #13
BL	_vUART1_Write+0
MOVS	R0, #10
BL	_vUART1_Write+0
MOVW	R3, #lo_addr(_pcRF4463TxBuffer+0)
MOVT	R3, #hi_addr(_pcRF4463TxBuffer+0)
LDRB	R3, [R3, #0]
UXTB	R1, R3
MOVW	R0, #lo_addr(_pcRF4463TxBuffer+0)
MOVT	R0, #hi_addr(_pcRF4463TxBuffer+0)
BL	_ucRf4463TxPacket+0
MOVS	R4, #1
MOVW	R3, #lo_addr(_ucRFTxEventPending+0)
MOVT	R3, #hi_addr(_ucRFTxEventPending+0)
STRB	R4, [R3, #0]
L_end_vRF4463TxMessage:
LDR	LR, [SP, #0]
ADD	SP, SP, #28
BX	LR
; end of _vRF4463TxMessage
_ucRF4463Setup:
SUB	SP, SP, #24
STR	LR, [SP, #0]
STRB	R0, [SP, #8]
STRB	R1, [SP, #12]
STRH	R2, [SP, #16]
STRB	R3, [SP, #20]
MOVS	R4, #1
STRB	R4, [SP, #4]
MOVW	R2, #lo_addr(__GPIO_MODULE_SPI1_PB345+0)
MOVT	R2, #hi_addr(__GPIO_MODULE_SPI1_PB345+0)
MOVW	R1, #772
MOVS	R0, #2
BL	_SPI1_Init_Advanced+0
MOVW	R1, #256
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
MOVW	R1, #512
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
MOVW	R1, #2
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Output+0
MOVW	R1, #4
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Output+0
MOVW	R1, #1
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Input+0
MOVS	R5, #1
SXTB	R5, R5
MOVW	R4, #lo_addr(RCC_APB2ENRbits+0)
MOVT	R4, #hi_addr(RCC_APB2ENRbits+0)
_SX	[R4, ByteOffset(RCC_APB2ENRbits+0)]
MOVW	R4, #lo_addr(SYSCFG_EXTICR1+0)
MOVT	R4, #hi_addr(SYSCFG_EXTICR1+0)
LDR	R4, [R4, #0]
ORR	R5, R4, #3
MOVW	R4, #lo_addr(SYSCFG_EXTICR1+0)
MOVT	R4, #hi_addr(SYSCFG_EXTICR1+0)
STR	R5, [R4, #0]
MOVS	R5, #1
MOVW	R4, #lo_addr(EXTI_IMR+0)
MOVT	R4, #hi_addr(EXTI_IMR+0)
_SX	[R4, ByteOffset(EXTI_IMR+0)]
MOVS	R5, #1
MOVW	R4, #lo_addr(EXTI_FTSR+0)
MOVT	R4, #hi_addr(EXTI_FTSR+0)
_SX	[R4, ByteOffset(EXTI_FTSR+0)]
MOVW	R6, #lo_addr(?lstr_5_main+0)
MOVT	R6, #hi_addr(?lstr_5_main+0)
MOVW	R5, #lo_addr(_vDebugPrint+0)
MOVT	R5, #hi_addr(_vDebugPrint+0)
LDRB	R4, [SP, #12]
PUSH	(R4)
PUSH	(R6)
PUSH	(R5)
BL	_PrintOut+0
ADD	SP, SP, #12
MOVW	R6, #lo_addr(?lstr_6_main+0)
MOVT	R6, #hi_addr(?lstr_6_main+0)
MOVW	R5, #lo_addr(_vDebugPrint+0)
MOVT	R5, #hi_addr(_vDebugPrint+0)
LDRB	R4, [SP, #8]
PUSH	(R4)
PUSH	(R6)
PUSH	(R5)
BL	_PrintOut+0
ADD	SP, SP, #12
MOVW	R6, #lo_addr(?lstr_7_main+0)
MOVT	R6, #hi_addr(?lstr_7_main+0)
MOVW	R5, #lo_addr(_vDebugPrint+0)
MOVT	R5, #hi_addr(_vDebugPrint+0)
LDRH	R4, [SP, #16]
PUSH	(R4)
PUSH	(R6)
PUSH	(R5)
BL	_PrintOut+0
ADD	SP, SP, #12
MOVW	R6, #lo_addr(?lstr_8_main+0)
MOVT	R6, #hi_addr(?lstr_8_main+0)
MOVW	R5, #lo_addr(_vDebugPrint+0)
MOVT	R5, #hi_addr(_vDebugPrint+0)
LDRB	R4, [SP, #20]
PUSH	(R4)
PUSH	(R6)
PUSH	(R5)
BL	_PrintOut+0
ADD	SP, SP, #12
LDRB	R3, [SP, #20]
LDRH	R2, [SP, #16]
LDRB	R1, [SP, #12]
LDRB	R0, [SP, #8]
BL	_vRf4463Init+0
MOVS	R4, #0
STRB	R4, [SP, #21]
L_ucRF4463Setup16:
LDRB	R4, [SP, #21]
CMP	R4, #15
IT	CS
BCS	L_ucRF4463Setup17
BL	_ucRf4463DeviceAvailability+0
CMP	R0, #0
IT	NE
BNE	L_ucRF4463Setup19
LDRB	R6, [SP, #21]
MOVW	R5, #lo_addr(?lstr_9_main+0)
MOVT	R5, #hi_addr(?lstr_9_main+0)
MOVW	R4, #lo_addr(_vDebugPrint+0)
MOVT	R4, #hi_addr(_vDebugPrint+0)
PUSH	(R6)
PUSH	(R5)
PUSH	(R4)
BL	_PrintOut+0
ADD	SP, SP, #12
IT	AL
BAL	L_ucRF4463Setup17
L_ucRF4463Setup19:
LDRB	R6, [SP, #21]
MOVW	R5, #lo_addr(?lstr_10_main+0)
MOVT	R5, #hi_addr(?lstr_10_main+0)
MOVW	R4, #lo_addr(_vDebugPrint+0)
MOVT	R4, #hi_addr(_vDebugPrint+0)
PUSH	(R6)
PUSH	(R5)
PUSH	(R4)
BL	_PrintOut+0
ADD	SP, SP, #12
MOVW	R7, #47486
MOVT	R7, #42
NOP
NOP
L_ucRF4463Setup21:
SUBS	R7, R7, #1
BNE	L_ucRF4463Setup21
NOP
NOP
NOP
LDRB	R4, [SP, #21]
ADDS	R4, R4, #1
STRB	R4, [SP, #21]
IT	AL
BAL	L_ucRF4463Setup16
L_ucRF4463Setup17:
LDRB	R4, [SP, #21]
CMP	R4, #15
IT	NE
BNE	L_ucRF4463Setup23
MOVS	R6, #0
SXTB	R6, R6
MOVW	R5, #lo_addr(?lstr_11_main+0)
MOVT	R5, #hi_addr(?lstr_11_main+0)
MOVW	R4, #lo_addr(_vDebugPrint+0)
MOVT	R4, #hi_addr(_vDebugPrint+0)
PUSH	(R6)
PUSH	(R5)
PUSH	(R4)
BL	_PrintOut+0
ADD	SP, SP, #12
MOVS	R0, #1
IT	AL
BAL	L_end_ucRF4463Setup
L_ucRF4463Setup23:
L_ucRF4463Setup24:
LDRB	R4, [SP, #4]
CMP	R4, #0
IT	EQ
BEQ	L_ucRF4463Setup25
BL	_ucRf4463EnterStandbyMode+0
STRB	R0, [SP, #4]
IT	AL
BAL	L_ucRF4463Setup24
L_ucRF4463Setup25:
MOVW	R0, #22
BL	_NVIC_IntEnable+0
BL	_ucRf4463ClearInterrupts+0
BL	_ucRf4463RxInit+0
MOVS	R6, #0
SXTB	R6, R6
MOVW	R5, #lo_addr(?lstr_12_main+0)
MOVT	R5, #hi_addr(?lstr_12_main+0)
MOVW	R4, #lo_addr(_vDebugPrint+0)
MOVT	R4, #hi_addr(_vDebugPrint+0)
PUSH	(R6)
PUSH	(R5)
PUSH	(R4)
BL	_PrintOut+0
ADD	SP, SP, #12
MOVS	R0, #0
L_end_ucRF4463Setup:
LDR	LR, [SP, #0]
ADD	SP, SP, #24
BX	LR
; end of _ucRF4463Setup
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
_vRf4463Init:
; usNetwork start address is: 8 (R2)
; ucSetRxChannel start address is: 4 (R1)
; ucSetTxChannel start address is: 0 (R0)
SUB	SP, SP, #28
STR	LR, [SP, #0]
UXTH	R12, R2
STRB	R3, [SP, #24]
; usNetwork end address is: 8 (R2)
; ucSetRxChannel end address is: 4 (R1)
; ucSetTxChannel end address is: 0 (R0)
; ucSetTxChannel start address is: 0 (R0)
; ucSetRxChannel start address is: 4 (R1)
; usNetwork start address is: 48 (R12)
CMP	R12, #0
IT	NE
BNE	L_vRf4463Init26
; ucSetTxChannel end address is: 0 (R0)
; ucSetRxChannel end address is: 4 (R1)
; usNetwork end address is: 48 (R12)
MOVS	R6, #0
SXTB	R6, R6
MOVW	R5, #lo_addr(?lstr_13_main+0)
MOVT	R5, #hi_addr(?lstr_13_main+0)
MOVW	R4, #lo_addr(_vDebugPrint+0)
MOVT	R4, #hi_addr(_vDebugPrint+0)
PUSH	(R6)
PUSH	(R5)
PUSH	(R4)
BL	_PrintOut+0
ADD	SP, SP, #12
IT	AL
BAL	L_end_vRf4463Init
L_vRf4463Init26:
; usNetwork start address is: 48 (R12)
; ucSetRxChannel start address is: 4 (R1)
; ucSetTxChannel start address is: 0 (R0)
CMP	R0, #0
IT	EQ
BEQ	L__vRf4463Init135
CMP	R0, #25
IT	HI
BHI	L__vRf4463Init134
L__vRf4463Init131:
CMP	R1, #0
IT	EQ
BEQ	L__vRf4463Init133
CMP	R1, #25
IT	HI
BHI	L__vRf4463Init132
L__vRf4463Init130:
IT	AL
BAL	L_vRf4463Init33
; ucSetTxChannel end address is: 0 (R0)
; ucSetRxChannel end address is: 4 (R1)
; usNetwork end address is: 48 (R12)
L__vRf4463Init135:
L__vRf4463Init134:
L__vRf4463Init133:
L__vRf4463Init132:
MOVS	R6, #0
SXTB	R6, R6
MOVW	R5, #lo_addr(?lstr_14_main+0)
MOVT	R5, #hi_addr(?lstr_14_main+0)
MOVW	R4, #lo_addr(_vDebugPrint+0)
MOVT	R4, #hi_addr(_vDebugPrint+0)
PUSH	(R6)
PUSH	(R5)
PUSH	(R4)
BL	_PrintOut+0
ADD	SP, SP, #12
IT	AL
BAL	L_end_vRf4463Init
L_vRf4463Init33:
; usNetwork start address is: 48 (R12)
; ucSetRxChannel start address is: 4 (R1)
; ucSetTxChannel start address is: 0 (R0)
MOVW	R4, #lo_addr(main_ucRfNetwork+0)
MOVT	R4, #hi_addr(main_ucRfNetwork+0)
STRB	R12, [R4, #0]
MOVW	R4, #lo_addr(main_ucRxChannel+0)
MOVT	R4, #hi_addr(main_ucRxChannel+0)
STRB	R1, [R4, #0]
; ucSetRxChannel end address is: 4 (R1)
MOVW	R4, #lo_addr(main_ucTxChannel+0)
MOVT	R4, #hi_addr(main_ucTxChannel+0)
STRB	R0, [R4, #0]
; ucSetTxChannel end address is: 0 (R0)
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
ADD	R5, SP, #4
LSR	R4, R12, #8
STRB	R4, [R5, #0]
ADDS	R4, R5, #1
STRB	R12, [R4, #0]
; usNetwork end address is: 48 (R12)
MOVS	R1, #2
MOV	R0, R5
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
LDRB	R0, [SP, #24]
BL	_ucRf4463SetTxPower+0
L_end_vRf4463Init:
LDR	LR, [SP, #0]
ADD	SP, SP, #28
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
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
_SX	[R0, ByteOffset(GPIOD_ODR+0)]
MOVW	R7, #558
MOVT	R7, #0
NOP
NOP
L_vRf4463PowerOnReset34:
SUBS	R7, R7, #1
BNE	L_vRf4463PowerOnReset34
NOP
NOP
NOP
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
_SX	[R0, ByteOffset(GPIOD_ODR+0)]
MOVW	R7, #8318
MOVT	R7, #5
NOP
NOP
L_vRf4463PowerOnReset36:
SUBS	R7, R7, #1
BNE	L_vRf4463PowerOnReset36
NOP
NOP
NOP
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
_SX	[R0, ByteOffset(GPIOD_ODR+0)]
ADD	R0, SP, #4
MOV	R1, R0
MOVS	R0, #7
BL	_vRf4463SPIWriteBuffer+0
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
_SX	[R0, ByteOffset(GPIOD_ODR+0)]
L_end_vRf4463PowerOnReset:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRf4463PowerOnReset
_vRf4463SetChannels:
; ucSetTxChannel start address is: 4 (R1)
; ucSetRxChannel start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; ucSetTxChannel end address is: 4 (R1)
; ucSetRxChannel end address is: 0 (R0)
; ucSetRxChannel start address is: 0 (R0)
; ucSetTxChannel start address is: 4 (R1)
CMP	R1, #0
IT	EQ
BEQ	L__vRf4463SetChannels142
CMP	R1, #25
IT	HI
BHI	L__vRf4463SetChannels141
L__vRf4463SetChannels138:
CMP	R0, #0
IT	EQ
BEQ	L__vRf4463SetChannels140
CMP	R0, #25
IT	HI
BHI	L__vRf4463SetChannels139
L__vRf4463SetChannels137:
IT	AL
BAL	L_vRf4463SetChannels44
; ucSetRxChannel end address is: 0 (R0)
; ucSetTxChannel end address is: 4 (R1)
L__vRf4463SetChannels142:
L__vRf4463SetChannels141:
L__vRf4463SetChannels140:
L__vRf4463SetChannels139:
MOVS	R4, #0
SXTB	R4, R4
MOVW	R3, #lo_addr(?lstr_15_main+0)
MOVT	R3, #hi_addr(?lstr_15_main+0)
MOVW	R2, #lo_addr(_vDebugPrint+0)
MOVT	R2, #hi_addr(_vDebugPrint+0)
PUSH	(R4)
PUSH	(R3)
PUSH	(R2)
BL	_PrintOut+0
ADD	SP, SP, #12
IT	AL
BAL	L_end_vRf4463SetChannels
L_vRf4463SetChannels44:
; ucSetTxChannel start address is: 4 (R1)
; ucSetRxChannel start address is: 0 (R0)
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
ADD	SP, SP, #4
BX	LR
; end of _vRf4463SetChannels
_vRf4463SetNetwork:
; usNetwork start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; usNetwork end address is: 0 (R0)
; usNetwork start address is: 0 (R0)
CMP	R0, #0
IT	NE
BNE	L_vRf4463SetNetwork45
; usNetwork end address is: 0 (R0)
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(?lstr_16_main+0)
MOVT	R2, #hi_addr(?lstr_16_main+0)
MOVW	R1, #lo_addr(_vDebugPrint+0)
MOVT	R1, #hi_addr(_vDebugPrint+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_PrintOut+0
ADD	SP, SP, #12
IT	AL
BAL	L_end_vRf4463SetNetwork
L_vRf4463SetNetwork45:
; usNetwork start address is: 0 (R0)
MOVW	R1, #lo_addr(main_ucRfNetwork+0)
MOVT	R1, #hi_addr(main_ucRfNetwork+0)
STRB	R0, [R1, #0]
; usNetwork end address is: 0 (R0)
L_end_vRf4463SetNetwork:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vRf4463SetNetwork
_vRf4463SetConfiguration:
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
SUB	R8, R0, #1
UXTH	R8, R8
; usParametersLength end address is: 0 (R0)
; usParametersLength start address is: 32 (R8)
LDRB	R2, [R1, #0]
ADDS	R0, R2, #1
UXTH	R0, R0
; usPosition start address is: 0 (R0)
; pcParameters end address is: 4 (R1)
; usParametersLength end address is: 32 (R8)
; usPosition end address is: 0 (R0)
MOV	R9, R1
L_vRf4463SetConfiguration46:
; usPosition start address is: 0 (R0)
; pcParameters start address is: 36 (R9)
; usParametersLength start address is: 32 (R8)
; pcParameters start address is: 36 (R9)
; pcParameters end address is: 36 (R9)
CMP	R0, R8
IT	CS
BCS	L_vRf4463SetConfiguration47
; pcParameters end address is: 36 (R9)
; pcParameters start address is: 36 (R9)
ADD	R2, R9, R0, LSL #0
LDRB	R2, [R2, #0]
SUBS	R4, R2, #1
; ucCommandLength start address is: 40 (R10)
UXTB	R10, R4
ADDS	R3, R0, #1
UXTH	R3, R3
; usPosition end address is: 0 (R0)
ADD	R2, R9, R3, LSL #0
LDRB	R2, [R2, #0]
; ucCommand start address is: 24 (R6)
UXTB	R6, R2
ADDS	R2, R3, #1
UXTH	R2, R2
; usPosition start address is: 44 (R11)
UXTH	R11, R2
ADD	R3, R9, R2, LSL #0
ADD	R2, SP, #8
MOV	R1, R3
MOV	R0, R2
UXTB	R2, R4
BL	_memcpy+0
ADD	R2, SP, #8
UXTB	R1, R6
; ucCommand end address is: 24 (R6)
UXTB	R0, R10
BL	_ucRf4463SetCommand+0
ADD	R2, R11, R10, LSL #0
; ucCommandLength end address is: 40 (R10)
; usPosition end address is: 44 (R11)
; usPosition start address is: 0 (R0)
UXTH	R0, R2
; usParametersLength end address is: 32 (R8)
; pcParameters end address is: 36 (R9)
; usPosition end address is: 0 (R0)
IT	AL
BAL	L_vRf4463SetConfiguration46
L_vRf4463SetConfiguration47:
L_end_vRf4463SetConfiguration:
LDR	LR, [SP, #0]
ADD	SP, SP, #40
BX	LR
; end of _vRf4463SetConfiguration
_ucRf4463SetCommand:
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
BL	_ucRf4463CheckCTS+0
CMP	R0, #1
IT	NE
BNE	L_ucRf4463SetCommand48
; ucLength end address is: 20 (R5)
; ucCommand end address is: 24 (R6)
; pcParametersBuffer end address is: 28 (R7)
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463SetCommand
L_ucRf4463SetCommand48:
; pcParametersBuffer start address is: 28 (R7)
; ucCommand start address is: 24 (R6)
; ucLength start address is: 20 (R5)
MOVS	R4, #0
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOD_ODR+0)
MOVT	R3, #hi_addr(GPIOD_ODR+0)
_SX	[R3, ByteOffset(GPIOD_ODR+0)]
UXTB	R0, R6
; ucCommand end address is: 24 (R6)
BL	_ucRf4463SPIByte+0
MOV	R1, R7
; pcParametersBuffer end address is: 28 (R7)
UXTB	R0, R5
; ucLength end address is: 20 (R5)
BL	_vRf4463SPIWriteBuffer+0
MOVS	R4, #1
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOD_ODR+0)
MOVT	R3, #hi_addr(GPIOD_ODR+0)
_SX	[R3, ByteOffset(GPIOD_ODR+0)]
MOVS	R0, #0
L_end_ucRf4463SetCommand:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ucRf4463SetCommand
_ucRf4463GetCommand:
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
BL	_ucRf4463CheckCTS+0
CMP	R0, #1
IT	NE
BNE	L_ucRf4463GetCommand49
; ucLength end address is: 20 (R5)
; ucCommand end address is: 24 (R6)
; pcParametersBuffer end address is: 28 (R7)
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463GetCommand
L_ucRf4463GetCommand49:
; pcParametersBuffer start address is: 28 (R7)
; ucCommand start address is: 24 (R6)
; ucLength start address is: 20 (R5)
MOVS	R4, #0
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOD_ODR+0)
MOVT	R3, #hi_addr(GPIOD_ODR+0)
_SX	[R3, ByteOffset(GPIOD_ODR+0)]
UXTB	R0, R6
; ucCommand end address is: 24 (R6)
BL	_ucRf4463SPIByte+0
MOVS	R4, #1
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOD_ODR+0)
MOVT	R3, #hi_addr(GPIOD_ODR+0)
_SX	[R3, ByteOffset(GPIOD_ODR+0)]
BL	_ucRf4463CheckCTS+0
CMP	R0, #1
IT	NE
BNE	L_ucRf4463GetCommand50
; ucLength end address is: 20 (R5)
; pcParametersBuffer end address is: 28 (R7)
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463GetCommand
L_ucRf4463GetCommand50:
; pcParametersBuffer start address is: 28 (R7)
; ucLength start address is: 20 (R5)
MOVS	R4, #0
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOD_ODR+0)
MOVT	R3, #hi_addr(GPIOD_ODR+0)
_SX	[R3, ByteOffset(GPIOD_ODR+0)]
MOVS	R0, #68
BL	_ucRf4463SPIByte+0
MOV	R1, R7
; pcParametersBuffer end address is: 28 (R7)
UXTB	R0, R5
; ucLength end address is: 20 (R5)
BL	_vRf4463SPIReadBuffer+0
MOVS	R4, #1
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOD_ODR+0)
MOVT	R3, #hi_addr(GPIOD_ODR+0)
_SX	[R3, ByteOffset(GPIOD_ODR+0)]
MOVS	R0, #0
L_end_ucRf4463GetCommand:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ucRf4463GetCommand
_ucRf4463SetProperty:
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
BL	_ucRf4463CheckCTS+0
CMP	R0, #1
IT	NE
BNE	L_ucRf4463SetProperty51
; usStartProperty end address is: 24 (R6)
; ucLength end address is: 28 (R7)
; pcParametersBuffer end address is: 32 (R8)
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463SetProperty
L_ucRf4463SetProperty51:
; pcParametersBuffer start address is: 32 (R8)
; ucLength start address is: 28 (R7)
; usStartProperty start address is: 24 (R6)
ADD	R5, SP, #4
MOVS	R3, #17
STRB	R3, [R5, #0]
ADDS	R4, R5, #1
LSRS	R3, R6, #8
STRB	R3, [R4, #0]
ADDS	R3, R5, #2
STRB	R7, [R3, #0]
ADDS	R4, R5, #3
AND	R3, R6, #255
; usStartProperty end address is: 24 (R6)
STRB	R3, [R4, #0]
MOVS	R4, #0
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOD_ODR+0)
MOVT	R3, #hi_addr(GPIOD_ODR+0)
_SX	[R3, ByteOffset(GPIOD_ODR+0)]
MOV	R1, R5
MOVS	R0, #4
BL	_vRf4463SPIWriteBuffer+0
MOV	R1, R8
; pcParametersBuffer end address is: 32 (R8)
UXTB	R0, R7
; ucLength end address is: 28 (R7)
BL	_vRf4463SPIWriteBuffer+0
MOVS	R4, #1
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOD_ODR+0)
MOVT	R3, #hi_addr(GPIOD_ODR+0)
_SX	[R3, ByteOffset(GPIOD_ODR+0)]
MOVS	R0, #0
L_end_ucRf4463SetProperty:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ucRf4463SetProperty
_ucRf4463GetProperty:
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
BL	_ucRf4463CheckCTS+0
CMP	R0, #1
IT	NE
BNE	L_ucRf4463GetProperty52
; usStartProperty end address is: 24 (R6)
; ucLength end address is: 28 (R7)
; pcParametersBuffer end address is: 32 (R8)
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463GetProperty
L_ucRf4463GetProperty52:
; pcParametersBuffer start address is: 32 (R8)
; ucLength start address is: 28 (R7)
; usStartProperty start address is: 24 (R6)
ADD	R5, SP, #4
MOVS	R3, #18
STRB	R3, [R5, #0]
ADDS	R4, R5, #1
LSRS	R3, R6, #8
STRB	R3, [R4, #0]
ADDS	R3, R5, #2
STRB	R7, [R3, #0]
ADDS	R4, R5, #3
AND	R3, R6, #255
; usStartProperty end address is: 24 (R6)
STRB	R3, [R4, #0]
MOVS	R4, #0
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOD_ODR+0)
MOVT	R3, #hi_addr(GPIOD_ODR+0)
_SX	[R3, ByteOffset(GPIOD_ODR+0)]
MOV	R1, R5
MOVS	R0, #4
BL	_vRf4463SPIWriteBuffer+0
BL	_ucRf4463CheckCTS+0
CMP	R0, #1
IT	NE
BNE	L_ucRf4463GetProperty53
; ucLength end address is: 28 (R7)
; pcParametersBuffer end address is: 32 (R8)
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463GetProperty
L_ucRf4463GetProperty53:
; pcParametersBuffer start address is: 32 (R8)
; ucLength start address is: 28 (R7)
MOVS	R4, #0
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOD_ODR+0)
MOVT	R3, #hi_addr(GPIOD_ODR+0)
_SX	[R3, ByteOffset(GPIOD_ODR+0)]
MOVS	R0, #68
BL	_ucRf4463SPIByte+0
MOV	R1, R8
; pcParametersBuffer end address is: 32 (R8)
UXTB	R0, R7
; ucLength end address is: 28 (R7)
BL	_vRf4463SPIReadBuffer+0
MOVS	R4, #1
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOD_ODR+0)
MOVT	R3, #hi_addr(GPIOD_ODR+0)
_SX	[R3, ByteOffset(GPIOD_ODR+0)]
MOVS	R0, #0
L_end_ucRf4463GetProperty:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
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
BEQ	L__ucRf4463SetSyncWords127
CMP	R1, #3
IT	HI
BHI	L__ucRf4463SetSyncWords126
IT	AL
BAL	L_ucRf4463SetSyncWords56
; pcSyncWords end address is: 0 (R0)
; ucLength end address is: 4 (R1)
L__ucRf4463SetSyncWords127:
L__ucRf4463SetSyncWords126:
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463SetSyncWords
L_ucRf4463SetSyncWords56:
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
L_ucRf4463CheckCTS57:
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
BEQ	L_ucRf4463CheckCTS58
; usTimeoutCounter end address is: 16 (R4)
; usTimeoutCounter start address is: 16 (R4)
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
_SX	[R0, ByteOffset(GPIOD_ODR+0)]
MOVS	R0, #68
BL	_ucRf4463SPIByte+0
MOVS	R0, #68
BL	_ucRf4463SPIByte+0
CMP	R0, #255
IT	NE
BNE	L_ucRf4463CheckCTS59
; usTimeoutCounter end address is: 16 (R4)
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
_SX	[R0, ByteOffset(GPIOD_ODR+0)]
MOVS	R0, #0
IT	AL
BAL	L_end_ucRf4463CheckCTS
L_ucRf4463CheckCTS59:
; usTimeoutCounter start address is: 16 (R4)
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
_SX	[R0, ByteOffset(GPIOD_ODR+0)]
UXTH	R2, R4
; usTimeoutCounter end address is: 16 (R4)
IT	AL
BAL	L_ucRf4463CheckCTS57
L_ucRf4463CheckCTS58:
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
MOVW	R1, #lo_addr(?lstr_17_main+0)
MOVT	R1, #hi_addr(?lstr_17_main+0)
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
_intRF4463GetLastRSSI:
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOVW	R0, #lo_addr(main_intRFLastRSSI+0)
MOVT	R0, #hi_addr(main_intRFLastRSSI+0)
LDRSH	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_18_main+0)
MOVT	R1, #hi_addr(?lstr_18_main+0)
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
L_end_intRF4463GetLastRSSI:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _intRF4463GetLastRSSI
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
BNE	L_ucRf4463DeviceAvailability60
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463DeviceAvailability
L_ucRf4463DeviceAvailability60:
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
BEQ	L_ucRf4463DeviceAvailability61
MOVS	R0, #1
IT	AL
BAL	L_end_ucRf4463DeviceAvailability
L_ucRf4463DeviceAvailability61:
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
UXTB	R9, R0
; ucPower end address is: 0 (R0)
; ucPower start address is: 36 (R9)
MOVS	R1, #8
STRB	R1, [SP, #4]
MOVS	R1, #0
STRB	R1, [SP, #5]
MOVS	R1, #0
STRB	R1, [SP, #6]
MOVS	R1, #61
STRB	R1, [SP, #7]
CMP	R9, #127
IT	LS
BLS	L__ucRf4463SetTxPower128
MOVW	R2, #lo_addr(?lstr_19_main+0)
MOVT	R2, #hi_addr(?lstr_19_main+0)
MOVW	R1, #lo_addr(_vDebugPrint+0)
MOVT	R1, #hi_addr(_vDebugPrint+0)
PUSH	36
; ucPower end address is: 36 (R9)
PUSH	(R2)
PUSH	(R1)
BL	_PrintOut+0
ADD	SP, SP, #12
; ucPower start address is: 0 (R0)
MOVS	R0, #127
; ucPower end address is: 0 (R0)
IT	AL
BAL	L_ucRf4463SetTxPower62
L__ucRf4463SetTxPower128:
UXTB	R0, R9
L_ucRf4463SetTxPower62:
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
SUB	SP, SP, #72
STR	LR, [SP, #0]
MOV	R9, R0
STRB	R1, [SP, #68]
; pcWriteBuffer end address is: 0 (R0)
; pcWriteBuffer start address is: 36 (R9)
ADD	R2, SP, #68
MOVS	R1, #1
MOVW	R0, #4626
BL	_ucRf4463SetProperty+0
ADD	R3, SP, #4
LDRB	R2, [SP, #68]
STRB	R2, [R3, #0]
ADDS	R2, R3, #1
MOV	R1, R9
MOV	R0, R2
; pcWriteBuffer end address is: 36 (R9)
LDRB	R2, [SP, #68]
BL	_memcpy+0
ADD	R3, SP, #4
LDRB	R2, [SP, #68]
ADDS	R2, R2, #1
MOVS	R1, #102
UXTB	R0, R2
MOV	R2, R3
BL	_ucRf4463SetCommand+0
L_end_vRf4463WriteTxFIFO:
LDR	LR, [SP, #0]
ADD	SP, SP, #72
BX	LR
; end of _vRf4463WriteTxFIFO
_ucRf4463TxPacket:
; ucTxLength start address is: 4 (R1)
; pcTxBuffer start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R8, R0
UXTB	R9, R1
; ucTxLength end address is: 4 (R1)
; pcTxBuffer end address is: 0 (R0)
; pcTxBuffer start address is: 32 (R8)
; ucTxLength start address is: 36 (R9)
BL	_vRf4463FIFOReset+0
UXTB	R1, R9
; ucTxLength end address is: 36 (R9)
MOV	R0, R8
; pcTxBuffer end address is: 32 (R8)
BL	_vRf4463WriteTxFIFO+0
BL	_vRf4463EnterTxMode+0
MOVS	R0, #0
L_end_ucRf4463TxPacket:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ucRf4463TxPacket
_ucRf4463TxPacket_Seq:
; ucTxLength start address is: 4 (R1)
; pcTxBuffer start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R8, R0
UXTB	R9, R1
; ucTxLength end address is: 4 (R1)
; pcTxBuffer end address is: 0 (R0)
; pcTxBuffer start address is: 32 (R8)
; ucTxLength start address is: 36 (R9)
BL	_vRf4463FIFOReset+0
UXTB	R1, R9
; ucTxLength end address is: 36 (R9)
MOV	R0, R8
; pcTxBuffer end address is: 32 (R8)
BL	_vRf4463WriteTxFIFO+0
BL	_ucRf4463ClearInterrupts+0
BL	_vRf4463EnterTxMode+0
L_ucRf4463TxPacket_Seq63:
BL	_ucRF4463GetIRQFlag+0
CMP	R0, #1
IT	NE
BNE	L_ucRf4463TxPacket_Seq66
IT	AL
BAL	L_ucRf4463TxPacket_Seq64
L_ucRf4463TxPacket_Seq66:
IT	AL
BAL	L_ucRf4463TxPacket_Seq63
L_ucRf4463TxPacket_Seq64:
MOVS	R0, #0
L_end_ucRf4463TxPacket_Seq:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
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
; ucCounter start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
STR	R0, [SP, #8]
; ucCounter end address is: 0 (R0)
; ucCounter start address is: 0 (R0)
MOVS	R0, #0
; ucCounter end address is: 0 (R0)
L_vRf4463ReadRxFIFO67:
; ucCounter start address is: 0 (R0)
CMP	R0, #64
IT	CS
BCS	L_vRf4463ReadRxFIFO68
LDR	R1, [SP, #8]
ADDS	R2, R1, R0
MOVS	R1, #0
STRB	R1, [R2, #0]
ADDS	R1, R0, #1
; ucCounter end address is: 0 (R0)
; ucCounter start address is: 4 (R1)
UXTB	R0, R1
; ucCounter end address is: 4 (R1)
IT	AL
BAL	L_vRf4463ReadRxFIFO67
L_vRf4463ReadRxFIFO68:
BL	_ucRf4463CheckCTS+0
CMP	R0, #1
IT	NE
BNE	L_vRf4463ReadRxFIFO70
IT	AL
BAL	L_end_vRf4463ReadRxFIFO
L_vRf4463ReadRxFIFO70:
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
_SX	[R1, ByteOffset(GPIOD_ODR+0)]
MOVS	R0, #119
BL	_ucRf4463SPIByte+0
ADD	R1, SP, #4
MOVS	R0, #1
BL	_vRf4463SPIReadBuffer+0
LDR	R1, [SP, #8]
MOVS	R0, #64
BL	_vRf4463SPIReadBuffer+0
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
_SX	[R1, ByteOffset(GPIOD_ODR+0)]
BL	_vRf4463RSSI+0
L_end_vRf4463ReadRxFIFO:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vRf4463ReadRxFIFO
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
L_vRf4463SPIWriteBuffer71:
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
BEQ	L_vRf4463SPIWriteBuffer72
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
BAL	L_vRf4463SPIWriteBuffer71
L_vRf4463SPIWriteBuffer72:
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
L_vRf4463SPIReadBuffer73:
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
BEQ	L_vRf4463SPIReadBuffer74
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
BAL	L_vRf4463SPIReadBuffer73
L_vRf4463SPIReadBuffer74:
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
BL	_SPI1_Read+0
UXTB	R0, R0
L_end_ucRf4463SPIByte:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ucRf4463SPIByte
_vISR_UART1_Callback:
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOVW	R0, #lo_addr(USART1_SRbits+0)
MOVT	R0, #hi_addr(USART1_SRbits+0)
_LX	[R0, ByteOffset(USART1_SRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vISR_UART1_Callback75
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_20_main+0)
MOVT	R1, #hi_addr(?lstr_20_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
L_vISR_UART1_Callback75:
MOVW	R0, #lo_addr(USART1_SRbits+0)
MOVT	R0, #hi_addr(USART1_SRbits+0)
_LX	[R0, ByteOffset(USART1_SRbits+0)]
CMP	R0, #0
IT	EQ
BEQ	L_vISR_UART1_Callback76
MOVW	R0, #lo_addr(USART1_DR+0)
MOVT	R0, #hi_addr(USART1_DR+0)
LDR	R0, [R0, #0]
; ucByteRead start address is: 12 (R3)
UXTB	R3, R0
CMP	R0, #10
IT	EQ
BEQ	L__vISR_UART1_Callback145
MOVW	R0, #lo_addr(_usUART1RxBufferLength+0)
MOVT	R0, #hi_addr(_usUART1RxBufferLength+0)
LDRH	R0, [R0, #0]
CMP	R0, #256
IT	CS
BCS	L__vISR_UART1_Callback144
L__vISR_UART1_Callback143:
MOVW	R2, #lo_addr(_usUART1RxBufferLength+0)
MOVT	R2, #hi_addr(_usUART1RxBufferLength+0)
LDRH	R1, [R2, #0]
MOVW	R0, #lo_addr(_pcUART1RxBuffer+0)
MOVT	R0, #hi_addr(_pcUART1RxBuffer+0)
ADDS	R0, R0, R1
STRB	R3, [R0, #0]
; ucByteRead end address is: 12 (R3)
MOV	R0, R2
LDRH	R0, [R0, #0]
ADDS	R0, R0, #1
STRH	R0, [R2, #0]
IT	AL
BAL	L_vISR_UART1_Callback80
L__vISR_UART1_Callback145:
L__vISR_UART1_Callback144:
MOVW	R0, #lo_addr(_usUART1RxBufferLength+0)
MOVT	R0, #hi_addr(_usUART1RxBufferLength+0)
LDRH	R0, [R0, #0]
SUBS	R1, R0, #1
UXTH	R1, R1
MOVW	R0, #lo_addr(_pcUART1RxBuffer+0)
MOVT	R0, #hi_addr(_pcUART1RxBuffer+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
CMP	R0, #13
IT	NE
BNE	L_vISR_UART1_Callback81
MOVW	R2, #lo_addr(_usUART1RxBufferLength+0)
MOVT	R2, #hi_addr(_usUART1RxBufferLength+0)
LDRH	R0, [R2, #0]
SUBS	R1, R0, #1
UXTH	R1, R1
STRH	R1, [R2, #0]
MOVW	R0, #lo_addr(_pcUART1RxBuffer+0)
MOVT	R0, #hi_addr(_pcUART1RxBuffer+0)
ADDS	R1, R0, R1
MOVS	R0, #0
STRB	R0, [R1, #0]
L_vISR_UART1_Callback81:
MOVS	R1, #1
MOVW	R0, #lo_addr(main_ucUART1RxIRQFlag+0)
MOVT	R0, #hi_addr(main_ucUART1RxIRQFlag+0)
STRB	R1, [R0, #0]
L_vISR_UART1_Callback80:
L_vISR_UART1_Callback76:
L_end_vISR_UART1_Callback:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vISR_UART1_Callback
_vUART1MessageHandler:
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOVW	R2, #lo_addr(_pcUART1RxBuffer+0)
MOVT	R2, #hi_addr(_pcUART1RxBuffer+0)
MOVW	R1, #lo_addr(?lstr_21_main+0)
MOVT	R1, #hi_addr(?lstr_21_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
MOVW	R0, #lo_addr(_usUART1RxBufferLength+0)
MOVT	R0, #hi_addr(_usUART1RxBufferLength+0)
LDRH	R0, [R0, #0]
MOVS	R2, #255
UXTB	R1, R0
MOVW	R0, #lo_addr(_pcUART1RxBuffer+0)
MOVT	R0, #hi_addr(_pcUART1RxBuffer+0)
BL	_vRF4463TxMessage+0
BL	_vUART1ResetRxBuffer+0
L_end_vUART1MessageHandler:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUART1MessageHandler
_vUARTTxInit:
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOVS	R0, #1
PUSH	(R0)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
MOV	R0, #115200
BL	_vUART1_Init_Advanced+0
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
_vUART1_Init_Advanced:
; uiStopBits start address is: 12 (R3)
; uiParity start address is: 8 (R2)
; uiDataBits start address is: 4 (R1)
; ulBaudRate start address is: 0 (R0)
SUB	SP, SP, #4
MOV	R6, R0
; uiStopBits end address is: 12 (R3)
; uiParity end address is: 8 (R2)
; uiDataBits end address is: 4 (R1)
; ulBaudRate end address is: 0 (R0)
; ulBaudRate start address is: 24 (R6)
; uiDataBits start address is: 4 (R1)
; uiParity start address is: 8 (R2)
; uiStopBits start address is: 12 (R3)
; ucTerminalMap start address is: 0 (R0)
LDRB	R0, [SP, #4]
MOVS	R5, #1
SXTB	R5, R5
MOVW	R4, #lo_addr(RCC_APB2ENRbits+0)
MOVT	R4, #hi_addr(RCC_APB2ENRbits+0)
_SX	[R4, ByteOffset(RCC_APB2ENRbits+0)]
MOVW	R4, #lo_addr(USART1_CR1bits+0)
MOVT	R4, #hi_addr(USART1_CR1bits+0)
_SX	[R4, ByteOffset(USART1_CR1bits+0)]
MOVW	R4, #lo_addr(USART1_CR1bits+0)
MOVT	R4, #hi_addr(USART1_CR1bits+0)
_SX	[R4, ByteOffset(USART1_CR1bits+0)]
CMP	R6, #115200
IT	NE
BNE	L_vUART1_Init_Advanced82
; ulBaudRate end address is: 24 (R6)
MOVS	R6, #9
MOVW	R5, #lo_addr(USART1_BRRbits+0)
MOVT	R5, #hi_addr(USART1_BRRbits+0)
LDRB	R4, [R5, #0]
BFI	R4, R6, #0, #4
STRB	R4, [R5, #0]
MOVS	R6, #45
MOVW	R5, #lo_addr(USART1_BRRbits+0)
MOVT	R5, #hi_addr(USART1_BRRbits+0)
LDRH	R4, [R5, #0]
BFI	R4, R6, #4, #12
STRH	R4, [R5, #0]
IT	AL
BAL	L_vUART1_Init_Advanced83
L_vUART1_Init_Advanced82:
; ulBaudRate start address is: 24 (R6)
CMP	R6, #921600
IT	NE
BNE	L_vUART1_Init_Advanced84
; ulBaudRate end address is: 24 (R6)
MOVS	R6, #11
MOVW	R5, #lo_addr(USART1_BRRbits+0)
MOVT	R5, #hi_addr(USART1_BRRbits+0)
LDRB	R4, [R5, #0]
BFI	R4, R6, #0, #4
STRB	R4, [R5, #0]
MOVS	R6, #5
MOVW	R5, #lo_addr(USART1_BRRbits+0)
MOVT	R5, #hi_addr(USART1_BRRbits+0)
LDRH	R4, [R5, #0]
BFI	R4, R6, #4, #12
STRH	R4, [R5, #0]
L_vUART1_Init_Advanced84:
L_vUART1_Init_Advanced83:
ORR	R5, R2, R1, LSL #0
UXTH	R5, R5
; uiDataBits end address is: 4 (R1)
; uiParity end address is: 8 (R2)
MOVW	R4, #lo_addr(USART1_CR1+0)
MOVT	R4, #hi_addr(USART1_CR1+0)
LDR	R4, [R4, #0]
ORR	R5, R4, R5, LSL #0
MOVW	R4, #lo_addr(USART1_CR1+0)
MOVT	R4, #hi_addr(USART1_CR1+0)
STR	R5, [R4, #0]
MOVW	R4, #lo_addr(USART1_CR2+0)
MOVT	R4, #hi_addr(USART1_CR2+0)
LDR	R4, [R4, #0]
ORR	R5, R4, R3, LSL #0
; uiStopBits end address is: 12 (R3)
MOVW	R4, #lo_addr(USART1_CR2+0)
MOVT	R4, #hi_addr(USART1_CR2+0)
STR	R5, [R4, #0]
IT	AL
BAL	L_vUART1_Init_Advanced85
; ucTerminalMap end address is: 0 (R0)
L_vUART1_Init_Advanced87:
MOVS	R5, #1
SXTB	R5, R5
MOVW	R4, #lo_addr(RCC_AHB1ENRbits+0)
MOVT	R4, #hi_addr(RCC_AHB1ENRbits+0)
_SX	[R4, ByteOffset(RCC_AHB1ENRbits+0)]
MOVS	R6, #2
MOVW	R5, #lo_addr(GPIOA_MODERbits+0)
MOVT	R5, #hi_addr(GPIOA_MODERbits+0)
LDR	R4, [R5, #0]
BFI	R4, R6, #20, #2
STR	R4, [R5, #0]
MOVS	R7, #0
SXTB	R7, R7
MOVW	R4, #lo_addr(GPIOA_OTYPERbits+0)
MOVT	R4, #hi_addr(GPIOA_OTYPERbits+0)
_SX	[R4, ByteOffset(GPIOA_OTYPERbits+0)]
MOVS	R6, #3
MOVW	R5, #lo_addr(GPIOA_OSPEEDRbits+0)
MOVT	R5, #hi_addr(GPIOA_OSPEEDRbits+0)
LDR	R4, [R5, #0]
BFI	R4, R6, #20, #2
STR	R4, [R5, #0]
MOVS	R6, #0
MOVW	R5, #lo_addr(GPIOA_PUPDRbits+0)
MOVT	R5, #hi_addr(GPIOA_PUPDRbits+0)
LDR	R4, [R5, #0]
BFI	R4, R6, #20, #2
STR	R4, [R5, #0]
MOVS	R6, #7
MOVW	R5, #lo_addr(GPIOA_AFRHbits+0)
MOVT	R5, #hi_addr(GPIOA_AFRHbits+0)
LDRH	R4, [R5, #0]
BFI	R4, R6, #8, #4
STRH	R4, [R5, #0]
MOVS	R6, #2
MOVW	R5, #lo_addr(GPIOA_MODERbits+0)
MOVT	R5, #hi_addr(GPIOA_MODERbits+0)
LDR	R4, [R5, #0]
BFI	R4, R6, #18, #2
STR	R4, [R5, #0]
MOVW	R4, #lo_addr(GPIOA_OTYPERbits+0)
MOVT	R4, #hi_addr(GPIOA_OTYPERbits+0)
_SX	[R4, ByteOffset(GPIOA_OTYPERbits+0)]
MOVS	R6, #3
MOVW	R5, #lo_addr(GPIOA_OSPEEDRbits+0)
MOVT	R5, #hi_addr(GPIOA_OSPEEDRbits+0)
LDR	R4, [R5, #0]
BFI	R4, R6, #18, #2
STR	R4, [R5, #0]
MOVS	R6, #0
MOVW	R5, #lo_addr(GPIOA_PUPDRbits+0)
MOVT	R5, #hi_addr(GPIOA_PUPDRbits+0)
LDR	R4, [R5, #0]
BFI	R4, R6, #18, #2
STR	R4, [R5, #0]
MOVS	R6, #7
MOVW	R5, #lo_addr(GPIOA_AFRHbits+0)
MOVT	R5, #hi_addr(GPIOA_AFRHbits+0)
LDRB	R4, [R5, #0]
BFI	R4, R6, #4, #4
STRB	R4, [R5, #0]
IT	AL
BAL	L_vUART1_Init_Advanced86
L_vUART1_Init_Advanced88:
MOVS	R5, #1
SXTB	R5, R5
MOVW	R4, #lo_addr(RCC_AHB1ENRbits+0)
MOVT	R4, #hi_addr(RCC_AHB1ENRbits+0)
_SX	[R4, ByteOffset(RCC_AHB1ENRbits+0)]
MOVS	R6, #2
MOVW	R5, #lo_addr(GPIOB_MODERbits+0)
MOVT	R5, #hi_addr(GPIOB_MODERbits+0)
LDRH	R4, [R5, #0]
BFI	R4, R6, #12, #2
STRH	R4, [R5, #0]
MOVS	R7, #0
SXTB	R7, R7
MOVW	R4, #lo_addr(GPIOB_OTYPERbits+0)
MOVT	R4, #hi_addr(GPIOB_OTYPERbits+0)
_SX	[R4, ByteOffset(GPIOB_OTYPERbits+0)]
MOVS	R6, #3
MOVW	R5, #lo_addr(GPIOB_OSPEEDRbits+0)
MOVT	R5, #hi_addr(GPIOB_OSPEEDRbits+0)
LDRH	R4, [R5, #0]
BFI	R4, R6, #12, #2
STRH	R4, [R5, #0]
MOVS	R6, #0
MOVW	R5, #lo_addr(GPIOB_PUPDRbits+0)
MOVT	R5, #hi_addr(GPIOB_PUPDRbits+0)
LDRH	R4, [R5, #0]
BFI	R4, R6, #12, #2
STRH	R4, [R5, #0]
MOVS	R6, #7
MOVW	R5, #lo_addr(GPIOB_AFRLbits+0)
MOVT	R5, #hi_addr(GPIOB_AFRLbits+0)
LDR	R4, [R5, #0]
BFI	R4, R6, #24, #4
STR	R4, [R5, #0]
MOVS	R6, #2
MOVW	R5, #lo_addr(GPIOB_MODERbits+0)
MOVT	R5, #hi_addr(GPIOB_MODERbits+0)
LDRH	R4, [R5, #0]
BFI	R4, R6, #14, #2
STRH	R4, [R5, #0]
MOVW	R4, #lo_addr(GPIOB_OTYPERbits+0)
MOVT	R4, #hi_addr(GPIOB_OTYPERbits+0)
_SX	[R4, ByteOffset(GPIOB_OTYPERbits+0)]
MOVS	R6, #3
MOVW	R5, #lo_addr(GPIOB_OSPEEDRbits+0)
MOVT	R5, #hi_addr(GPIOB_OSPEEDRbits+0)
LDRH	R4, [R5, #0]
BFI	R4, R6, #14, #2
STRH	R4, [R5, #0]
MOVS	R6, #0
MOVW	R5, #lo_addr(GPIOB_PUPDRbits+0)
MOVT	R5, #hi_addr(GPIOB_PUPDRbits+0)
LDRH	R4, [R5, #0]
BFI	R4, R6, #14, #2
STRH	R4, [R5, #0]
MOVS	R6, #7
MOVW	R5, #lo_addr(GPIOB_AFRLbits+0)
MOVT	R5, #hi_addr(GPIOB_AFRLbits+0)
LDR	R4, [R5, #0]
BFI	R4, R6, #28, #4
STR	R4, [R5, #0]
IT	AL
BAL	L_vUART1_Init_Advanced86
L_vUART1_Init_Advanced85:
; ucTerminalMap start address is: 0 (R0)
CMP	R0, #0
IT	EQ
BEQ	L_vUART1_Init_Advanced87
CMP	R0, #1
IT	EQ
BEQ	L_vUART1_Init_Advanced88
; ucTerminalMap end address is: 0 (R0)
L_vUART1_Init_Advanced86:
L_end_vUART1_Init_Advanced:
ADD	SP, SP, #4
BX	LR
; end of _vUART1_Init_Advanced
_vUART1_Write:
; pcByte start address is: 0 (R0)
SUB	SP, SP, #4
; pcByte end address is: 0 (R0)
; pcByte start address is: 0 (R0)
MOVW	R1, #lo_addr(USART1_DR+0)
MOVT	R1, #hi_addr(USART1_DR+0)
STR	R0, [R1, #0]
; pcByte end address is: 0 (R0)
MOVW	R1, #lo_addr(USART1_CR1bits+0)
MOVT	R1, #hi_addr(USART1_CR1bits+0)
_LX	[R1, ByteOffset(USART1_CR1bits+0)]
CMP	R1, #0
IT	EQ
BEQ	L_vUART1_Write89
L_vUART1_Write90:
MOVW	R1, #lo_addr(USART1_SRbits+0)
MOVT	R1, #hi_addr(USART1_SRbits+0)
_LX	[R1, ByteOffset(USART1_SRbits+0)]
CMP	R1, #0
IT	NE
BNE	L_vUART1_Write91
IT	AL
BAL	L_vUART1_Write90
L_vUART1_Write91:
L_vUART1_Write89:
L_end_vUART1_Write:
ADD	SP, SP, #4
BX	LR
; end of _vUART1_Write
_vUART1_Write_Text:
; pcBuffer start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R4, R0
; pcBuffer end address is: 0 (R0)
; pcBuffer start address is: 16 (R4)
MOV	R0, R4
BL	_strlen+0
; ucBufferSize start address is: 12 (R3)
UXTB	R3, R0
; ucCounter start address is: 0 (R0)
MOVS	R0, #0
; pcBuffer end address is: 16 (R4)
; ucBufferSize end address is: 12 (R3)
; ucCounter end address is: 0 (R0)
L_vUART1_Write_Text92:
; ucCounter start address is: 0 (R0)
; ucBufferSize start address is: 12 (R3)
; pcBuffer start address is: 16 (R4)
CMP	R0, R3
IT	CS
BCS	L_vUART1_Write_Text93
ADDS	R1, R4, R0
LDRB	R2, [R1, #0]
MOVW	R1, #lo_addr(USART1_DR+0)
MOVT	R1, #hi_addr(USART1_DR+0)
STR	R2, [R1, #0]
MOVW	R1, #lo_addr(USART1_CR1bits+0)
MOVT	R1, #hi_addr(USART1_CR1bits+0)
_LX	[R1, ByteOffset(USART1_CR1bits+0)]
CMP	R1, #0
IT	EQ
BEQ	L__vUART1_Write_Text124
; pcBuffer end address is: 16 (R4)
; ucBufferSize end address is: 12 (R3)
; ucCounter end address is: 0 (R0)
MOV	R2, R4
L_vUART1_Write_Text96:
; pcBuffer start address is: 8 (R2)
; ucBufferSize start address is: 12 (R3)
; ucCounter start address is: 0 (R0)
MOVW	R1, #lo_addr(USART1_SRbits+0)
MOVT	R1, #hi_addr(USART1_SRbits+0)
_LX	[R1, ByteOffset(USART1_SRbits+0)]
CMP	R1, #0
IT	NE
BNE	L_vUART1_Write_Text97
IT	AL
BAL	L_vUART1_Write_Text96
L_vUART1_Write_Text97:
; ucBufferSize end address is: 12 (R3)
; ucCounter end address is: 0 (R0)
MOV	R4, R2
IT	AL
BAL	L_vUART1_Write_Text95
; pcBuffer end address is: 8 (R2)
L__vUART1_Write_Text124:
L_vUART1_Write_Text95:
; pcBuffer start address is: 16 (R4)
; ucBufferSize start address is: 12 (R3)
; ucCounter start address is: 0 (R0)
ADDS	R0, R0, #1
UXTB	R0, R0
; pcBuffer end address is: 16 (R4)
; ucBufferSize end address is: 12 (R3)
; ucCounter end address is: 0 (R0)
IT	AL
BAL	L_vUART1_Write_Text92
L_vUART1_Write_Text93:
L_end_vUART1_Write_Text:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vUART1_Write_Text
_ucUART1MessageReady:
SUB	SP, SP, #4
MOVW	R0, #lo_addr(main_ucUART1RxIRQFlag+0)
MOVT	R0, #hi_addr(main_ucUART1RxIRQFlag+0)
LDRB	R0, [R0, #0]
L_end_ucUART1MessageReady:
ADD	SP, SP, #4
BX	LR
; end of _ucUART1MessageReady
_vUART1ResetIRQFlag:
SUB	SP, SP, #4
MOVS	R1, #0
MOVW	R0, #lo_addr(main_ucUART1RxIRQFlag+0)
MOVT	R0, #hi_addr(main_ucUART1RxIRQFlag+0)
STRB	R1, [R0, #0]
L_end_vUART1ResetIRQFlag:
ADD	SP, SP, #4
BX	LR
; end of _vUART1ResetIRQFlag
_vUART1ResetRxBuffer:
SUB	SP, SP, #4
MOVS	R1, #0
MOVW	R0, #lo_addr(_usUART1RxBufferLength+0)
MOVT	R0, #hi_addr(_usUART1RxBufferLength+0)
STRH	R1, [R0, #0]
L_vUART1ResetRxBuffer98:
MOVW	R0, #lo_addr(_usUART1RxBufferLength+0)
MOVT	R0, #hi_addr(_usUART1RxBufferLength+0)
LDRH	R0, [R0, #0]
CMP	R0, #256
IT	CS
BCS	L_vUART1ResetRxBuffer99
MOVW	R2, #lo_addr(_usUART1RxBufferLength+0)
MOVT	R2, #hi_addr(_usUART1RxBufferLength+0)
LDRH	R1, [R2, #0]
MOVW	R0, #lo_addr(_pcUART1RxBuffer+0)
MOVT	R0, #hi_addr(_pcUART1RxBuffer+0)
ADDS	R1, R0, R1
MOVS	R0, #0
STRB	R0, [R1, #0]
MOV	R0, R2
LDRH	R0, [R0, #0]
ADDS	R0, R0, #1
STRH	R0, [R2, #0]
IT	AL
BAL	L_vUART1ResetRxBuffer98
L_vUART1ResetRxBuffer99:
MOVS	R1, #0
MOVW	R0, #lo_addr(_usUART1RxBufferLength+0)
MOVT	R0, #hi_addr(_usUART1RxBufferLength+0)
STRH	R1, [R0, #0]
L_end_vUART1ResetRxBuffer:
ADD	SP, SP, #4
BX	LR
; end of _vUART1ResetRxBuffer
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
BLS	L_ucASCIIToByte101
MOVW	R2, #lo_addr(_ucMSBNibble+0)
MOVT	R2, #hi_addr(_ucMSBNibble+0)
LDRB	R1, [R2, #0]
SUBS	R1, R1, #7
STRB	R1, [R2, #0]
L_ucASCIIToByte101:
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
BLS	L_ucASCIIToByte102
MOVW	R2, #lo_addr(_ucLSBNibble+0)
MOVT	R2, #hi_addr(_ucLSBNibble+0)
LDRB	R1, [R2, #0]
SUBS	R1, R1, #7
STRB	R1, [R2, #0]
L_ucASCIIToByte102:
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
L_vASCIIToHex103:
; ucASCIICounter start address is: 24 (R6)
; pcHexConvertBuffer start address is: 8 (R2)
; ucConversionLength start address is: 0 (R0)
; pcASCIIConvertBuffer start address is: 4 (R1)
; pcASCIIConvertBuffer end address is: 4 (R1)
; pcHexConvertBuffer start address is: 8 (R2)
; pcHexConvertBuffer end address is: 8 (R2)
CMP	R6, R0
IT	CS
BCS	L_vASCIIToHex104
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
BLS	L_vASCIIToHex106
MOVW	R4, #lo_addr(_ucMSBNibble+0)
MOVT	R4, #hi_addr(_ucMSBNibble+0)
LDRB	R3, [R4, #0]
SUBS	R3, R3, #7
STRB	R3, [R4, #0]
L_vASCIIToHex106:
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
BLS	L_vASCIIToHex107
MOVW	R4, #lo_addr(_ucLSBNibble+0)
MOVT	R4, #hi_addr(_ucLSBNibble+0)
LDRB	R3, [R4, #0]
SUBS	R3, R3, #7
STRB	R3, [R4, #0]
L_vASCIIToHex107:
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
BAL	L_vASCIIToHex103
L_vASCIIToHex104:
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
L_vHexToASCII108:
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
BCS	L_vHexToASCII109
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
BAL	L_vHexToASCII108
L_vHexToASCII109:
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
L_vBufferSetToZero111:
; usPosition start address is: 16 (R4)
; pcBufferToClean start address is: 4 (R1)
; uslength start address is: 0 (R0)
; pcBufferToClean start address is: 4 (R1)
; pcBufferToClean end address is: 4 (R1)
CMP	R4, R0
IT	CS
BCS	L_vBufferSetToZero112
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
BAL	L_vBufferSetToZero111
L_vBufferSetToZero112:
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
L_vBufferSetTo255114:
; usPosition start address is: 16 (R4)
; pcBufferToClean start address is: 4 (R1)
; uslength start address is: 0 (R0)
; pcBufferToClean start address is: 4 (R1)
; pcBufferToClean end address is: 4 (R1)
CMP	R4, R0
IT	CS
BCS	L_vBufferSetTo255115
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
BAL	L_vBufferSetTo255114
L_vBufferSetTo255115:
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
L_vBufferSetToValue117:
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
BCS	L_vBufferSetToValue118
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
BAL	L_vBufferSetToValue117
L_vBufferSetToValue118:
L_end_vBufferSetToValue:
ADD	SP, SP, #4
BX	LR
; end of _vBufferSetToValue
_main:
SUB	SP, SP, #4
BL	_vUARTTxInit+0
BL	_vUARTRxInit+0
MOVS	R3, #127
MOVS	R2, #5
MOVS	R1, #5
MOVS	R0, #5
BL	_ucRF4463Setup+0
BL	_vUART1ResetRxBuffer+0
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(?lstr_22_main+0)
MOVT	R1, #hi_addr(?lstr_22_main+0)
MOVW	R0, #lo_addr(_vDebugPrint+0)
MOVT	R0, #hi_addr(_vDebugPrint+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_PrintOut+0
ADD	SP, SP, #12
L_main120:
BL	_ucRF4463GetIRQFlag+0
CMP	R0, #1
IT	NE
BNE	L_main122
BL	_vRF4463MesageHandler+0
BL	_vRF4463ResetIRQFlag+0
L_main122:
BL	_ucUART1MessageReady+0
CMP	R0, #1
IT	NE
BNE	L_main123
BL	_vUART1MessageHandler+0
BL	_vUART1ResetIRQFlag+0
L_main123:
IT	AL
BAL	L_main120
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
