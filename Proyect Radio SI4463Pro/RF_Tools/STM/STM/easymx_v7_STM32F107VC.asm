easymx_v7_STM32F107VC__getAN_1:
;__em_f107vc_gpio.c,31 :: 		static uint8_t _getAN_1  () 			{ return GPIOA_IDR.B4 ;  }
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
L_end__getAN_1:
BX	LR
; end of easymx_v7_STM32F107VC__getAN_1
easymx_v7_STM32F107VC__getRST_1:
;__em_f107vc_gpio.c,32 :: 		static uint8_t _getRST_1 () 			{ return GPIOC_IDR.B2 ;  }
MOVW	R0, #lo_addr(GPIOC_IDR+0)
MOVT	R0, #hi_addr(GPIOC_IDR+0)
_LX	[R0, ByteOffset(GPIOC_IDR+0)]
L_end__getRST_1:
BX	LR
; end of easymx_v7_STM32F107VC__getRST_1
easymx_v7_STM32F107VC__getCS_1:
;__em_f107vc_gpio.c,33 :: 		static uint8_t _getCS_1  () 			{ return GPIOD_IDR.B13;  }
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
_LX	[R0, ByteOffset(GPIOD_IDR+0)]
L_end__getCS_1:
BX	LR
; end of easymx_v7_STM32F107VC__getCS_1
easymx_v7_STM32F107VC__getSCK_1:
;__em_f107vc_gpio.c,34 :: 		static uint8_t _getSCK_1 () 			{ return GPIOC_IDR.B10;  }
MOVW	R0, #lo_addr(GPIOC_IDR+0)
MOVT	R0, #hi_addr(GPIOC_IDR+0)
_LX	[R0, ByteOffset(GPIOC_IDR+0)]
L_end__getSCK_1:
BX	LR
; end of easymx_v7_STM32F107VC__getSCK_1
easymx_v7_STM32F107VC__getMISO_1:
;__em_f107vc_gpio.c,35 :: 		static uint8_t _getMISO_1() 			{ return GPIOC_IDR.B11;  }
MOVW	R0, #lo_addr(GPIOC_IDR+0)
MOVT	R0, #hi_addr(GPIOC_IDR+0)
_LX	[R0, ByteOffset(GPIOC_IDR+0)]
L_end__getMISO_1:
BX	LR
; end of easymx_v7_STM32F107VC__getMISO_1
easymx_v7_STM32F107VC__getMOSI_1:
;__em_f107vc_gpio.c,36 :: 		static uint8_t _getMOSI_1() 			{ return GPIOC_IDR.B12;  }
MOVW	R0, #lo_addr(GPIOC_IDR+0)
MOVT	R0, #hi_addr(GPIOC_IDR+0)
_LX	[R0, ByteOffset(GPIOC_IDR+0)]
L_end__getMOSI_1:
BX	LR
; end of easymx_v7_STM32F107VC__getMOSI_1
easymx_v7_STM32F107VC__getPWM_1:
;__em_f107vc_gpio.c,37 :: 		static uint8_t _getPWM_1 () 			{ return GPIOA_IDR.B0 ;  }
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
L_end__getPWM_1:
BX	LR
; end of easymx_v7_STM32F107VC__getPWM_1
easymx_v7_STM32F107VC__getINT_1:
;__em_f107vc_gpio.c,38 :: 		static uint8_t _getINT_1 () 			{ return GPIOD_IDR.B10;  }
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
_LX	[R0, ByteOffset(GPIOD_IDR+0)]
L_end__getINT_1:
BX	LR
; end of easymx_v7_STM32F107VC__getINT_1
easymx_v7_STM32F107VC__getRX_1:
;__em_f107vc_gpio.c,39 :: 		static uint8_t _getRX_1  () 			{ return GPIOD_IDR.B9 ;  }
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
_LX	[R0, ByteOffset(GPIOD_IDR+0)]
L_end__getRX_1:
BX	LR
; end of easymx_v7_STM32F107VC__getRX_1
easymx_v7_STM32F107VC__getTX_1:
;__em_f107vc_gpio.c,40 :: 		static uint8_t _getTX_1  () 			{ return GPIOD_IDR.B8 ;  }
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
_LX	[R0, ByteOffset(GPIOD_IDR+0)]
L_end__getTX_1:
BX	LR
; end of easymx_v7_STM32F107VC__getTX_1
easymx_v7_STM32F107VC__getSCL_1:
;__em_f107vc_gpio.c,41 :: 		static uint8_t _getSCL_1 () 			{ return GPIOB_IDR.B6 ;  }
MOVW	R0, #lo_addr(GPIOB_IDR+0)
MOVT	R0, #hi_addr(GPIOB_IDR+0)
_LX	[R0, ByteOffset(GPIOB_IDR+0)]
L_end__getSCL_1:
BX	LR
; end of easymx_v7_STM32F107VC__getSCL_1
easymx_v7_STM32F107VC__getSDA_1:
;__em_f107vc_gpio.c,42 :: 		static uint8_t _getSDA_1 () 			{ return GPIOB_IDR.B7 ;  }
MOVW	R0, #lo_addr(GPIOB_IDR+0)
MOVT	R0, #hi_addr(GPIOB_IDR+0)
_LX	[R0, ByteOffset(GPIOB_IDR+0)]
L_end__getSDA_1:
BX	LR
; end of easymx_v7_STM32F107VC__getSDA_1
easymx_v7_STM32F107VC__setAN_1:
;__em_f107vc_gpio.c,43 :: 		static void _setAN_1  (uint8_t value) 	{ GPIOA_ODR.B4  = value; }
; value start address is: 0 (R0)
; value end address is: 0 (R0)
; value start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
_SX	[R1, ByteOffset(GPIOA_ODR+0)]
; value end address is: 0 (R0)
L_end__setAN_1:
BX	LR
; end of easymx_v7_STM32F107VC__setAN_1
easymx_v7_STM32F107VC__setRST_1:
;__em_f107vc_gpio.c,44 :: 		static void _setRST_1 (uint8_t value) 	{ GPIOC_ODR.B2  = value; }
; value start address is: 0 (R0)
; value end address is: 0 (R0)
; value start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
_SX	[R1, ByteOffset(GPIOC_ODR+0)]
; value end address is: 0 (R0)
L_end__setRST_1:
BX	LR
; end of easymx_v7_STM32F107VC__setRST_1
easymx_v7_STM32F107VC__setCS_1:
;__em_f107vc_gpio.c,45 :: 		static void _setCS_1  (uint8_t value) 	{ GPIOD_ODR.B13 = value; }
; value start address is: 0 (R0)
; value end address is: 0 (R0)
; value start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
_SX	[R1, ByteOffset(GPIOD_ODR+0)]
; value end address is: 0 (R0)
L_end__setCS_1:
BX	LR
; end of easymx_v7_STM32F107VC__setCS_1
easymx_v7_STM32F107VC__setSCK_1:
;__em_f107vc_gpio.c,46 :: 		static void _setSCK_1 (uint8_t value) 	{ GPIOC_ODR.B10 = value; }
; value start address is: 0 (R0)
; value end address is: 0 (R0)
; value start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
_SX	[R1, ByteOffset(GPIOC_ODR+0)]
; value end address is: 0 (R0)
L_end__setSCK_1:
BX	LR
; end of easymx_v7_STM32F107VC__setSCK_1
easymx_v7_STM32F107VC__setMISO_1:
;__em_f107vc_gpio.c,47 :: 		static void _setMISO_1(uint8_t value) 	{ GPIOC_ODR.B11 = value; }
; value start address is: 0 (R0)
; value end address is: 0 (R0)
; value start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
_SX	[R1, ByteOffset(GPIOC_ODR+0)]
; value end address is: 0 (R0)
L_end__setMISO_1:
BX	LR
; end of easymx_v7_STM32F107VC__setMISO_1
easymx_v7_STM32F107VC__setMOSI_1:
;__em_f107vc_gpio.c,48 :: 		static void _setMOSI_1(uint8_t value) 	{ GPIOC_ODR.B12 = value; }
; value start address is: 0 (R0)
; value end address is: 0 (R0)
; value start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
_SX	[R1, ByteOffset(GPIOC_ODR+0)]
; value end address is: 0 (R0)
L_end__setMOSI_1:
BX	LR
; end of easymx_v7_STM32F107VC__setMOSI_1
easymx_v7_STM32F107VC__setPWM_1:
;__em_f107vc_gpio.c,49 :: 		static void _setPWM_1 (uint8_t value) 	{ GPIOA_ODR.B0  = value; }
; value start address is: 0 (R0)
; value end address is: 0 (R0)
; value start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
_SX	[R1, ByteOffset(GPIOA_ODR+0)]
; value end address is: 0 (R0)
L_end__setPWM_1:
BX	LR
; end of easymx_v7_STM32F107VC__setPWM_1
easymx_v7_STM32F107VC__setINT_1:
;__em_f107vc_gpio.c,50 :: 		static void _setINT_1 (uint8_t value) 	{ GPIOD_ODR.B10 = value; }
; value start address is: 0 (R0)
; value end address is: 0 (R0)
; value start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
_SX	[R1, ByteOffset(GPIOD_ODR+0)]
; value end address is: 0 (R0)
L_end__setINT_1:
BX	LR
; end of easymx_v7_STM32F107VC__setINT_1
easymx_v7_STM32F107VC__setRX_1:
;__em_f107vc_gpio.c,51 :: 		static void _setRX_1  (uint8_t value) 	{ GPIOD_ODR.B9  = value; }
; value start address is: 0 (R0)
; value end address is: 0 (R0)
; value start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
_SX	[R1, ByteOffset(GPIOD_ODR+0)]
; value end address is: 0 (R0)
L_end__setRX_1:
BX	LR
; end of easymx_v7_STM32F107VC__setRX_1
easymx_v7_STM32F107VC__setTX_1:
;__em_f107vc_gpio.c,52 :: 		static void _setTX_1  (uint8_t value) 	{ GPIOD_ODR.B8  = value; }
; value start address is: 0 (R0)
; value end address is: 0 (R0)
; value start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
_SX	[R1, ByteOffset(GPIOD_ODR+0)]
; value end address is: 0 (R0)
L_end__setTX_1:
BX	LR
; end of easymx_v7_STM32F107VC__setTX_1
easymx_v7_STM32F107VC__setSCL_1:
;__em_f107vc_gpio.c,53 :: 		static void _setSCL_1 (uint8_t value) 	{ GPIOB_ODR.B6  = value; }
; value start address is: 0 (R0)
; value end address is: 0 (R0)
; value start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
_SX	[R1, ByteOffset(GPIOB_ODR+0)]
; value end address is: 0 (R0)
L_end__setSCL_1:
BX	LR
; end of easymx_v7_STM32F107VC__setSCL_1
easymx_v7_STM32F107VC__setSDA_1:
;__em_f107vc_gpio.c,54 :: 		static void _setSDA_1 (uint8_t value) 	{ GPIOB_ODR.B7  = value; }
; value start address is: 0 (R0)
; value end address is: 0 (R0)
; value start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
_SX	[R1, ByteOffset(GPIOB_ODR+0)]
; value end address is: 0 (R0)
L_end__setSDA_1:
BX	LR
; end of easymx_v7_STM32F107VC__setSDA_1
easymx_v7_STM32F107VC__getAN_2:
;__em_f107vc_gpio.c,56 :: 		static uint8_t _getAN_2  ()             { return GPIOA_IDR.B5 ;  }
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
L_end__getAN_2:
BX	LR
; end of easymx_v7_STM32F107VC__getAN_2
easymx_v7_STM32F107VC__getRST_2:
;__em_f107vc_gpio.c,57 :: 		static uint8_t _getRST_2 ()             { return GPIOC_IDR.B3 ;  }
MOVW	R0, #lo_addr(GPIOC_IDR+0)
MOVT	R0, #hi_addr(GPIOC_IDR+0)
_LX	[R0, ByteOffset(GPIOC_IDR+0)]
L_end__getRST_2:
BX	LR
; end of easymx_v7_STM32F107VC__getRST_2
easymx_v7_STM32F107VC__getCS_2:
;__em_f107vc_gpio.c,58 :: 		static uint8_t _getCS_2  ()             { return GPIOD_IDR.B14;  }
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
_LX	[R0, ByteOffset(GPIOD_IDR+0)]
L_end__getCS_2:
BX	LR
; end of easymx_v7_STM32F107VC__getCS_2
easymx_v7_STM32F107VC__getSCK_2:
;__em_f107vc_gpio.c,59 :: 		static uint8_t _getSCK_2 ()             { return GPIOC_IDR.B10;  }
MOVW	R0, #lo_addr(GPIOC_IDR+0)
MOVT	R0, #hi_addr(GPIOC_IDR+0)
_LX	[R0, ByteOffset(GPIOC_IDR+0)]
L_end__getSCK_2:
BX	LR
; end of easymx_v7_STM32F107VC__getSCK_2
easymx_v7_STM32F107VC__getMISO_2:
;__em_f107vc_gpio.c,60 :: 		static uint8_t _getMISO_2()             { return GPIOC_IDR.B11;  }
MOVW	R0, #lo_addr(GPIOC_IDR+0)
MOVT	R0, #hi_addr(GPIOC_IDR+0)
_LX	[R0, ByteOffset(GPIOC_IDR+0)]
L_end__getMISO_2:
BX	LR
; end of easymx_v7_STM32F107VC__getMISO_2
easymx_v7_STM32F107VC__getMOSI_2:
;__em_f107vc_gpio.c,61 :: 		static uint8_t _getMOSI_2()             { return GPIOC_IDR.B12;  }
MOVW	R0, #lo_addr(GPIOC_IDR+0)
MOVT	R0, #hi_addr(GPIOC_IDR+0)
_LX	[R0, ByteOffset(GPIOC_IDR+0)]
L_end__getMOSI_2:
BX	LR
; end of easymx_v7_STM32F107VC__getMOSI_2
easymx_v7_STM32F107VC__getPWM_2:
;__em_f107vc_gpio.c,62 :: 		static uint8_t _getPWM_2 ()             { return GPIOD_IDR.B12;  }
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
_LX	[R0, ByteOffset(GPIOD_IDR+0)]
L_end__getPWM_2:
BX	LR
; end of easymx_v7_STM32F107VC__getPWM_2
easymx_v7_STM32F107VC__getINT_2:
;__em_f107vc_gpio.c,63 :: 		static uint8_t _getINT_2 ()             { return GPIOD_IDR.B11;  }
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
_LX	[R0, ByteOffset(GPIOD_IDR+0)]
L_end__getINT_2:
BX	LR
; end of easymx_v7_STM32F107VC__getINT_2
easymx_v7_STM32F107VC__getRX_2:
;__em_f107vc_gpio.c,64 :: 		static uint8_t _getRX_2  ()             { return GPIOD_IDR.B6 ;  }
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
_LX	[R0, ByteOffset(GPIOD_IDR+0)]
L_end__getRX_2:
BX	LR
; end of easymx_v7_STM32F107VC__getRX_2
easymx_v7_STM32F107VC__getTX_2:
;__em_f107vc_gpio.c,65 :: 		static uint8_t _getTX_2  ()             { return GPIOD_IDR.B5 ;  }
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
_LX	[R0, ByteOffset(GPIOD_IDR+0)]
L_end__getTX_2:
BX	LR
; end of easymx_v7_STM32F107VC__getTX_2
easymx_v7_STM32F107VC__getSCL_2:
;__em_f107vc_gpio.c,66 :: 		static uint8_t _getSCL_2 ()             { return GPIOB_IDR.B6 ;  }
MOVW	R0, #lo_addr(GPIOB_IDR+0)
MOVT	R0, #hi_addr(GPIOB_IDR+0)
_LX	[R0, ByteOffset(GPIOB_IDR+0)]
L_end__getSCL_2:
BX	LR
; end of easymx_v7_STM32F107VC__getSCL_2
easymx_v7_STM32F107VC__getSDA_2:
;__em_f107vc_gpio.c,67 :: 		static uint8_t _getSDA_2 ()             { return GPIOB_IDR.B7 ;  }
MOVW	R0, #lo_addr(GPIOB_IDR+0)
MOVT	R0, #hi_addr(GPIOB_IDR+0)
_LX	[R0, ByteOffset(GPIOB_IDR+0)]
L_end__getSDA_2:
BX	LR
; end of easymx_v7_STM32F107VC__getSDA_2
easymx_v7_STM32F107VC__setAN_2:
;__em_f107vc_gpio.c,68 :: 		static void _setAN_2  (uint8_t value)   { GPIOA_ODR.B5  = value; }
; value start address is: 0 (R0)
; value end address is: 0 (R0)
; value start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
_SX	[R1, ByteOffset(GPIOA_ODR+0)]
; value end address is: 0 (R0)
L_end__setAN_2:
BX	LR
; end of easymx_v7_STM32F107VC__setAN_2
easymx_v7_STM32F107VC__setRST_2:
;__em_f107vc_gpio.c,69 :: 		static void _setRST_2 (uint8_t value)   { GPIOC_ODR.B3  = value; }
; value start address is: 0 (R0)
; value end address is: 0 (R0)
; value start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
_SX	[R1, ByteOffset(GPIOC_ODR+0)]
; value end address is: 0 (R0)
L_end__setRST_2:
BX	LR
; end of easymx_v7_STM32F107VC__setRST_2
easymx_v7_STM32F107VC__setCS_2:
;__em_f107vc_gpio.c,70 :: 		static void _setCS_2  (uint8_t value)   { GPIOD_ODR.B14 = value; }
; value start address is: 0 (R0)
; value end address is: 0 (R0)
; value start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
_SX	[R1, ByteOffset(GPIOD_ODR+0)]
; value end address is: 0 (R0)
L_end__setCS_2:
BX	LR
; end of easymx_v7_STM32F107VC__setCS_2
easymx_v7_STM32F107VC__setSCK_2:
;__em_f107vc_gpio.c,71 :: 		static void _setSCK_2 (uint8_t value)   { GPIOC_ODR.B10 = value; }
; value start address is: 0 (R0)
; value end address is: 0 (R0)
; value start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
_SX	[R1, ByteOffset(GPIOC_ODR+0)]
; value end address is: 0 (R0)
L_end__setSCK_2:
BX	LR
; end of easymx_v7_STM32F107VC__setSCK_2
easymx_v7_STM32F107VC__setMISO_2:
;__em_f107vc_gpio.c,72 :: 		static void _setMISO_2(uint8_t value)   { GPIOC_ODR.B11 = value; }
; value start address is: 0 (R0)
; value end address is: 0 (R0)
; value start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
_SX	[R1, ByteOffset(GPIOC_ODR+0)]
; value end address is: 0 (R0)
L_end__setMISO_2:
BX	LR
; end of easymx_v7_STM32F107VC__setMISO_2
easymx_v7_STM32F107VC__setMOSI_2:
;__em_f107vc_gpio.c,73 :: 		static void _setMOSI_2(uint8_t value)   { GPIOC_ODR.B12 = value; }
; value start address is: 0 (R0)
; value end address is: 0 (R0)
; value start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
_SX	[R1, ByteOffset(GPIOC_ODR+0)]
; value end address is: 0 (R0)
L_end__setMOSI_2:
BX	LR
; end of easymx_v7_STM32F107VC__setMOSI_2
easymx_v7_STM32F107VC__setPWM_2:
;__em_f107vc_gpio.c,74 :: 		static void _setPWM_2 (uint8_t value)   { GPIOD_ODR.B12 = value; }
; value start address is: 0 (R0)
; value end address is: 0 (R0)
; value start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
_SX	[R1, ByteOffset(GPIOD_ODR+0)]
; value end address is: 0 (R0)
L_end__setPWM_2:
BX	LR
; end of easymx_v7_STM32F107VC__setPWM_2
easymx_v7_STM32F107VC__setINT_2:
;__em_f107vc_gpio.c,75 :: 		static void _setINT_2 (uint8_t value)   { GPIOD_ODR.B11 = value; }
; value start address is: 0 (R0)
; value end address is: 0 (R0)
; value start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
_SX	[R1, ByteOffset(GPIOD_ODR+0)]
; value end address is: 0 (R0)
L_end__setINT_2:
BX	LR
; end of easymx_v7_STM32F107VC__setINT_2
easymx_v7_STM32F107VC__setRX_2:
;__em_f107vc_gpio.c,76 :: 		static void _setRX_2  (uint8_t value)   { GPIOD_ODR.B6  = value; }
; value start address is: 0 (R0)
; value end address is: 0 (R0)
; value start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
_SX	[R1, ByteOffset(GPIOD_ODR+0)]
; value end address is: 0 (R0)
L_end__setRX_2:
BX	LR
; end of easymx_v7_STM32F107VC__setRX_2
easymx_v7_STM32F107VC__setTX_2:
;__em_f107vc_gpio.c,77 :: 		static void _setTX_2  (uint8_t value)   { GPIOD_ODR.B5  = value; }
; value start address is: 0 (R0)
; value end address is: 0 (R0)
; value start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
_SX	[R1, ByteOffset(GPIOD_ODR+0)]
; value end address is: 0 (R0)
L_end__setTX_2:
BX	LR
; end of easymx_v7_STM32F107VC__setTX_2
easymx_v7_STM32F107VC__setSCL_2:
;__em_f107vc_gpio.c,78 :: 		static void _setSCL_2 (uint8_t value)   { GPIOB_ODR.B6  = value; }
; value start address is: 0 (R0)
; value end address is: 0 (R0)
; value start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
_SX	[R1, ByteOffset(GPIOB_ODR+0)]
; value end address is: 0 (R0)
L_end__setSCL_2:
BX	LR
; end of easymx_v7_STM32F107VC__setSCL_2
easymx_v7_STM32F107VC__setSDA_2:
;__em_f107vc_gpio.c,79 :: 		static void _setSDA_2 (uint8_t value)   { GPIOB_ODR.B7  = value; }
; value start address is: 0 (R0)
; value end address is: 0 (R0)
; value start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
_SX	[R1, ByteOffset(GPIOB_ODR+0)]
; value end address is: 0 (R0)
L_end__setSDA_2:
BX	LR
; end of easymx_v7_STM32F107VC__setSDA_2
easymx_v7_STM32F107VC__gpioInit_1:
;__em_f107vc_gpio.c,81 :: 		static T_mikrobus_ret _gpioInit_1(T_mikrobus_pin pin, T_gpio_dir dir)
; dir start address is: 4 (R1)
; pin start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; dir end address is: 4 (R1)
; pin end address is: 0 (R0)
; pin start address is: 0 (R0)
; dir start address is: 4 (R1)
;__em_f107vc_gpio.c,83 :: 		switch( pin )
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_10
; pin end address is: 0 (R0)
;__em_f107vc_gpio.c,85 :: 		case _MIKROBUS_AN_PIN    : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOA_BASE, _GPIO_PINMASK_4 ); else GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_4 ); break;
L_easymx_v7_STM32F107VC__gpioInit_12:
CMP	R1, #1
IT	NE
BNE	L_easymx_v7_STM32F107VC__gpioInit_13
; dir end address is: 4 (R1)
MOVW	R1, #16
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Input+0
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_14
L_easymx_v7_STM32F107VC__gpioInit_13:
MOVW	R1, #16
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
L_easymx_v7_STM32F107VC__gpioInit_14:
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_11
;__em_f107vc_gpio.c,86 :: 		case _MIKROBUS_RST_PIN   : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOC_BASE, _GPIO_PINMASK_2 ); else GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_2 ); break;
L_easymx_v7_STM32F107VC__gpioInit_15:
; dir start address is: 4 (R1)
CMP	R1, #1
IT	NE
BNE	L_easymx_v7_STM32F107VC__gpioInit_16
; dir end address is: 4 (R1)
MOVW	R1, #4
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Input+0
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_17
L_easymx_v7_STM32F107VC__gpioInit_16:
MOVW	R1, #4
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
L_easymx_v7_STM32F107VC__gpioInit_17:
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_11
;__em_f107vc_gpio.c,87 :: 		case _MIKROBUS_CS_PIN    : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOD_BASE, _GPIO_PINMASK_13); else GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_13); break;
L_easymx_v7_STM32F107VC__gpioInit_18:
; dir start address is: 4 (R1)
CMP	R1, #1
IT	NE
BNE	L_easymx_v7_STM32F107VC__gpioInit_19
; dir end address is: 4 (R1)
MOVW	R1, #8192
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Input+0
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_110
L_easymx_v7_STM32F107VC__gpioInit_19:
MOVW	R1, #8192
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Output+0
L_easymx_v7_STM32F107VC__gpioInit_110:
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_11
;__em_f107vc_gpio.c,88 :: 		case _MIKROBUS_SCK_PIN   : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOC_BASE, _GPIO_PINMASK_10); else GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_10); break;
L_easymx_v7_STM32F107VC__gpioInit_111:
; dir start address is: 4 (R1)
CMP	R1, #1
IT	NE
BNE	L_easymx_v7_STM32F107VC__gpioInit_112
; dir end address is: 4 (R1)
MOVW	R1, #1024
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Input+0
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_113
L_easymx_v7_STM32F107VC__gpioInit_112:
MOVW	R1, #1024
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
L_easymx_v7_STM32F107VC__gpioInit_113:
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_11
;__em_f107vc_gpio.c,89 :: 		case _MIKROBUS_MISO_PIN  : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOC_BASE, _GPIO_PINMASK_11); else GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_11); break;
L_easymx_v7_STM32F107VC__gpioInit_114:
; dir start address is: 4 (R1)
CMP	R1, #1
IT	NE
BNE	L_easymx_v7_STM32F107VC__gpioInit_115
; dir end address is: 4 (R1)
MOVW	R1, #2048
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Input+0
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_116
L_easymx_v7_STM32F107VC__gpioInit_115:
MOVW	R1, #2048
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
L_easymx_v7_STM32F107VC__gpioInit_116:
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_11
;__em_f107vc_gpio.c,90 :: 		case _MIKROBUS_MOSI_PIN  : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOC_BASE, _GPIO_PINMASK_12); else GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_12); break;
L_easymx_v7_STM32F107VC__gpioInit_117:
; dir start address is: 4 (R1)
CMP	R1, #1
IT	NE
BNE	L_easymx_v7_STM32F107VC__gpioInit_118
; dir end address is: 4 (R1)
MOVW	R1, #4096
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Input+0
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_119
L_easymx_v7_STM32F107VC__gpioInit_118:
MOVW	R1, #4096
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
L_easymx_v7_STM32F107VC__gpioInit_119:
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_11
;__em_f107vc_gpio.c,91 :: 		case _MIKROBUS_PWM_PIN   : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOA_BASE, _GPIO_PINMASK_0 ); else GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_0 ); break;
L_easymx_v7_STM32F107VC__gpioInit_120:
; dir start address is: 4 (R1)
CMP	R1, #1
IT	NE
BNE	L_easymx_v7_STM32F107VC__gpioInit_121
; dir end address is: 4 (R1)
MOVW	R1, #1
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Input+0
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_122
L_easymx_v7_STM32F107VC__gpioInit_121:
MOVW	R1, #1
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
L_easymx_v7_STM32F107VC__gpioInit_122:
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_11
;__em_f107vc_gpio.c,92 :: 		case _MIKROBUS_INT_PIN   : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOD_BASE, _GPIO_PINMASK_10); else GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_10); break;
L_easymx_v7_STM32F107VC__gpioInit_123:
; dir start address is: 4 (R1)
CMP	R1, #1
IT	NE
BNE	L_easymx_v7_STM32F107VC__gpioInit_124
; dir end address is: 4 (R1)
MOVW	R1, #1024
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Input+0
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_125
L_easymx_v7_STM32F107VC__gpioInit_124:
MOVW	R1, #1024
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Output+0
L_easymx_v7_STM32F107VC__gpioInit_125:
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_11
;__em_f107vc_gpio.c,93 :: 		case _MIKROBUS_RX_PIN    : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOD_BASE, _GPIO_PINMASK_9 ); else GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_9 ); break;
L_easymx_v7_STM32F107VC__gpioInit_126:
; dir start address is: 4 (R1)
CMP	R1, #1
IT	NE
BNE	L_easymx_v7_STM32F107VC__gpioInit_127
; dir end address is: 4 (R1)
MOVW	R1, #512
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Input+0
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_128
L_easymx_v7_STM32F107VC__gpioInit_127:
MOVW	R1, #512
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Output+0
L_easymx_v7_STM32F107VC__gpioInit_128:
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_11
;__em_f107vc_gpio.c,94 :: 		case _MIKROBUS_TX_PIN    : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOD_BASE, _GPIO_PINMASK_8 ); else GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_8 ); break;
L_easymx_v7_STM32F107VC__gpioInit_129:
; dir start address is: 4 (R1)
CMP	R1, #1
IT	NE
BNE	L_easymx_v7_STM32F107VC__gpioInit_130
; dir end address is: 4 (R1)
MOVW	R1, #256
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Input+0
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_131
L_easymx_v7_STM32F107VC__gpioInit_130:
MOVW	R1, #256
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Output+0
L_easymx_v7_STM32F107VC__gpioInit_131:
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_11
;__em_f107vc_gpio.c,95 :: 		case _MIKROBUS_SCL_PIN   : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOB_BASE, _GPIO_PINMASK_6 ); else GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_6 ); break;
L_easymx_v7_STM32F107VC__gpioInit_132:
; dir start address is: 4 (R1)
CMP	R1, #1
IT	NE
BNE	L_easymx_v7_STM32F107VC__gpioInit_133
; dir end address is: 4 (R1)
MOVW	R1, #64
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Input+0
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_134
L_easymx_v7_STM32F107VC__gpioInit_133:
MOVW	R1, #64
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
L_easymx_v7_STM32F107VC__gpioInit_134:
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_11
;__em_f107vc_gpio.c,96 :: 		case _MIKROBUS_SDA_PIN   : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOB_BASE, _GPIO_PINMASK_7 ); else GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_7 ); break;
L_easymx_v7_STM32F107VC__gpioInit_135:
; dir start address is: 4 (R1)
CMP	R1, #1
IT	NE
BNE	L_easymx_v7_STM32F107VC__gpioInit_136
; dir end address is: 4 (R1)
MOVW	R1, #128
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Input+0
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_137
L_easymx_v7_STM32F107VC__gpioInit_136:
MOVW	R1, #128
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
L_easymx_v7_STM32F107VC__gpioInit_137:
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_11
;__em_f107vc_gpio.c,97 :: 		default                  : return _MIKROBUS_ERR_PIN;
L_easymx_v7_STM32F107VC__gpioInit_138:
MOVS	R0, #1
IT	AL
BAL	L_end__gpioInit_1
;__em_f107vc_gpio.c,98 :: 		}
L_easymx_v7_STM32F107VC__gpioInit_10:
; dir start address is: 4 (R1)
; pin start address is: 0 (R0)
CMP	R0, #0
IT	EQ
BEQ	L_easymx_v7_STM32F107VC__gpioInit_12
CMP	R0, #1
IT	EQ
BEQ	L_easymx_v7_STM32F107VC__gpioInit_15
CMP	R0, #2
IT	EQ
BEQ	L_easymx_v7_STM32F107VC__gpioInit_18
CMP	R0, #3
IT	EQ
BEQ	L_easymx_v7_STM32F107VC__gpioInit_111
CMP	R0, #4
IT	EQ
BEQ	L_easymx_v7_STM32F107VC__gpioInit_114
CMP	R0, #5
IT	EQ
BEQ	L_easymx_v7_STM32F107VC__gpioInit_117
CMP	R0, #6
IT	EQ
BEQ	L_easymx_v7_STM32F107VC__gpioInit_120
CMP	R0, #7
IT	EQ
BEQ	L_easymx_v7_STM32F107VC__gpioInit_123
CMP	R0, #8
IT	EQ
BEQ	L_easymx_v7_STM32F107VC__gpioInit_126
CMP	R0, #9
IT	EQ
BEQ	L_easymx_v7_STM32F107VC__gpioInit_129
CMP	R0, #10
IT	EQ
BEQ	L_easymx_v7_STM32F107VC__gpioInit_132
CMP	R0, #11
IT	EQ
BEQ	L_easymx_v7_STM32F107VC__gpioInit_135
; pin end address is: 0 (R0)
; dir end address is: 4 (R1)
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_138
L_easymx_v7_STM32F107VC__gpioInit_11:
;__em_f107vc_gpio.c,99 :: 		return _MIKROBUS_OK;
MOVS	R0, __MIKROBUS_OK
;__em_f107vc_gpio.c,100 :: 		}
L_end__gpioInit_1:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of easymx_v7_STM32F107VC__gpioInit_1
easymx_v7_STM32F107VC__gpioInit_2:
;__em_f107vc_gpio.c,102 :: 		static T_mikrobus_ret _gpioInit_2(T_mikrobus_pin pin, T_gpio_dir dir)
; dir start address is: 4 (R1)
; pin start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; dir end address is: 4 (R1)
; pin end address is: 0 (R0)
; pin start address is: 0 (R0)
; dir start address is: 4 (R1)
;__em_f107vc_gpio.c,104 :: 		switch( pin )
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_239
; pin end address is: 0 (R0)
;__em_f107vc_gpio.c,106 :: 		case _MIKROBUS_AN_PIN    : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOA_BASE, _GPIO_PINMASK_5 ); else GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_5 ); break;
L_easymx_v7_STM32F107VC__gpioInit_241:
CMP	R1, #1
IT	NE
BNE	L_easymx_v7_STM32F107VC__gpioInit_242
; dir end address is: 4 (R1)
MOVW	R1, #32
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Input+0
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_243
L_easymx_v7_STM32F107VC__gpioInit_242:
MOVW	R1, #32
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
L_easymx_v7_STM32F107VC__gpioInit_243:
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_240
;__em_f107vc_gpio.c,107 :: 		case _MIKROBUS_RST_PIN   : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOC_BASE, _GPIO_PINMASK_3 ); else GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_3 ); break;
L_easymx_v7_STM32F107VC__gpioInit_244:
; dir start address is: 4 (R1)
CMP	R1, #1
IT	NE
BNE	L_easymx_v7_STM32F107VC__gpioInit_245
; dir end address is: 4 (R1)
MOVW	R1, #8
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Input+0
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_246
L_easymx_v7_STM32F107VC__gpioInit_245:
MOVW	R1, #8
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
L_easymx_v7_STM32F107VC__gpioInit_246:
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_240
;__em_f107vc_gpio.c,108 :: 		case _MIKROBUS_CS_PIN    : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOD_BASE, _GPIO_PINMASK_14); else GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_14); break;
L_easymx_v7_STM32F107VC__gpioInit_247:
; dir start address is: 4 (R1)
CMP	R1, #1
IT	NE
BNE	L_easymx_v7_STM32F107VC__gpioInit_248
; dir end address is: 4 (R1)
MOVW	R1, #16384
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Input+0
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_249
L_easymx_v7_STM32F107VC__gpioInit_248:
MOVW	R1, #16384
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Output+0
L_easymx_v7_STM32F107VC__gpioInit_249:
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_240
;__em_f107vc_gpio.c,109 :: 		case _MIKROBUS_SCK_PIN   : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOC_BASE, _GPIO_PINMASK_10); else GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_10); break;
L_easymx_v7_STM32F107VC__gpioInit_250:
; dir start address is: 4 (R1)
CMP	R1, #1
IT	NE
BNE	L_easymx_v7_STM32F107VC__gpioInit_251
; dir end address is: 4 (R1)
MOVW	R1, #1024
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Input+0
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_252
L_easymx_v7_STM32F107VC__gpioInit_251:
MOVW	R1, #1024
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
L_easymx_v7_STM32F107VC__gpioInit_252:
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_240
;__em_f107vc_gpio.c,110 :: 		case _MIKROBUS_MISO_PIN  : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOC_BASE, _GPIO_PINMASK_11); else GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_11); break;
L_easymx_v7_STM32F107VC__gpioInit_253:
; dir start address is: 4 (R1)
CMP	R1, #1
IT	NE
BNE	L_easymx_v7_STM32F107VC__gpioInit_254
; dir end address is: 4 (R1)
MOVW	R1, #2048
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Input+0
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_255
L_easymx_v7_STM32F107VC__gpioInit_254:
MOVW	R1, #2048
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
L_easymx_v7_STM32F107VC__gpioInit_255:
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_240
;__em_f107vc_gpio.c,111 :: 		case _MIKROBUS_MOSI_PIN  : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOC_BASE, _GPIO_PINMASK_12); else GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_12); break;
L_easymx_v7_STM32F107VC__gpioInit_256:
; dir start address is: 4 (R1)
CMP	R1, #1
IT	NE
BNE	L_easymx_v7_STM32F107VC__gpioInit_257
; dir end address is: 4 (R1)
MOVW	R1, #4096
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Input+0
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_258
L_easymx_v7_STM32F107VC__gpioInit_257:
MOVW	R1, #4096
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
L_easymx_v7_STM32F107VC__gpioInit_258:
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_240
;__em_f107vc_gpio.c,112 :: 		case _MIKROBUS_PWM_PIN   : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOD_BASE, _GPIO_PINMASK_12); else GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_12); break;
L_easymx_v7_STM32F107VC__gpioInit_259:
; dir start address is: 4 (R1)
CMP	R1, #1
IT	NE
BNE	L_easymx_v7_STM32F107VC__gpioInit_260
; dir end address is: 4 (R1)
MOVW	R1, #4096
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Input+0
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_261
L_easymx_v7_STM32F107VC__gpioInit_260:
MOVW	R1, #4096
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Output+0
L_easymx_v7_STM32F107VC__gpioInit_261:
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_240
;__em_f107vc_gpio.c,113 :: 		case _MIKROBUS_INT_PIN   : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOD_BASE, _GPIO_PINMASK_11); else GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_11); break;
L_easymx_v7_STM32F107VC__gpioInit_262:
; dir start address is: 4 (R1)
CMP	R1, #1
IT	NE
BNE	L_easymx_v7_STM32F107VC__gpioInit_263
; dir end address is: 4 (R1)
MOVW	R1, #2048
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Input+0
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_264
L_easymx_v7_STM32F107VC__gpioInit_263:
MOVW	R1, #2048
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Output+0
L_easymx_v7_STM32F107VC__gpioInit_264:
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_240
;__em_f107vc_gpio.c,114 :: 		case _MIKROBUS_RX_PIN    : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOD_BASE, _GPIO_PINMASK_6 ); else GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_6 ); break;
L_easymx_v7_STM32F107VC__gpioInit_265:
; dir start address is: 4 (R1)
CMP	R1, #1
IT	NE
BNE	L_easymx_v7_STM32F107VC__gpioInit_266
; dir end address is: 4 (R1)
MOVW	R1, #64
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Input+0
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_267
L_easymx_v7_STM32F107VC__gpioInit_266:
MOVW	R1, #64
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Output+0
L_easymx_v7_STM32F107VC__gpioInit_267:
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_240
;__em_f107vc_gpio.c,115 :: 		case _MIKROBUS_TX_PIN    : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOD_BASE, _GPIO_PINMASK_5 ); else GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_5 ); break;
L_easymx_v7_STM32F107VC__gpioInit_268:
; dir start address is: 4 (R1)
CMP	R1, #1
IT	NE
BNE	L_easymx_v7_STM32F107VC__gpioInit_269
; dir end address is: 4 (R1)
MOVW	R1, #32
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Input+0
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_270
L_easymx_v7_STM32F107VC__gpioInit_269:
MOVW	R1, #32
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Output+0
L_easymx_v7_STM32F107VC__gpioInit_270:
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_240
;__em_f107vc_gpio.c,116 :: 		case _MIKROBUS_SCL_PIN   : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOB_BASE, _GPIO_PINMASK_6 ); else GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_6 ); break;
L_easymx_v7_STM32F107VC__gpioInit_271:
; dir start address is: 4 (R1)
CMP	R1, #1
IT	NE
BNE	L_easymx_v7_STM32F107VC__gpioInit_272
; dir end address is: 4 (R1)
MOVW	R1, #64
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Input+0
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_273
L_easymx_v7_STM32F107VC__gpioInit_272:
MOVW	R1, #64
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
L_easymx_v7_STM32F107VC__gpioInit_273:
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_240
;__em_f107vc_gpio.c,117 :: 		case _MIKROBUS_SDA_PIN   : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOB_BASE, _GPIO_PINMASK_7 ); else GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_7 ); break;
L_easymx_v7_STM32F107VC__gpioInit_274:
; dir start address is: 4 (R1)
CMP	R1, #1
IT	NE
BNE	L_easymx_v7_STM32F107VC__gpioInit_275
; dir end address is: 4 (R1)
MOVW	R1, #128
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Input+0
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_276
L_easymx_v7_STM32F107VC__gpioInit_275:
MOVW	R1, #128
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
L_easymx_v7_STM32F107VC__gpioInit_276:
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_240
;__em_f107vc_gpio.c,118 :: 		default                  : return _MIKROBUS_ERR_PIN;
L_easymx_v7_STM32F107VC__gpioInit_277:
MOVS	R0, #1
IT	AL
BAL	L_end__gpioInit_2
;__em_f107vc_gpio.c,119 :: 		}
L_easymx_v7_STM32F107VC__gpioInit_239:
; dir start address is: 4 (R1)
; pin start address is: 0 (R0)
CMP	R0, #0
IT	EQ
BEQ	L_easymx_v7_STM32F107VC__gpioInit_241
CMP	R0, #1
IT	EQ
BEQ	L_easymx_v7_STM32F107VC__gpioInit_244
CMP	R0, #2
IT	EQ
BEQ	L_easymx_v7_STM32F107VC__gpioInit_247
CMP	R0, #3
IT	EQ
BEQ	L_easymx_v7_STM32F107VC__gpioInit_250
CMP	R0, #4
IT	EQ
BEQ	L_easymx_v7_STM32F107VC__gpioInit_253
CMP	R0, #5
IT	EQ
BEQ	L_easymx_v7_STM32F107VC__gpioInit_256
CMP	R0, #6
IT	EQ
BEQ	L_easymx_v7_STM32F107VC__gpioInit_259
CMP	R0, #7
IT	EQ
BEQ	L_easymx_v7_STM32F107VC__gpioInit_262
CMP	R0, #8
IT	EQ
BEQ	L_easymx_v7_STM32F107VC__gpioInit_265
CMP	R0, #9
IT	EQ
BEQ	L_easymx_v7_STM32F107VC__gpioInit_268
CMP	R0, #10
IT	EQ
BEQ	L_easymx_v7_STM32F107VC__gpioInit_271
CMP	R0, #11
IT	EQ
BEQ	L_easymx_v7_STM32F107VC__gpioInit_274
; pin end address is: 0 (R0)
; dir end address is: 4 (R1)
IT	AL
BAL	L_easymx_v7_STM32F107VC__gpioInit_277
L_easymx_v7_STM32F107VC__gpioInit_240:
;__em_f107vc_gpio.c,120 :: 		return _MIKROBUS_OK;
MOVS	R0, __MIKROBUS_OK
;__em_f107vc_gpio.c,121 :: 		}
L_end__gpioInit_2:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of easymx_v7_STM32F107VC__gpioInit_2
easymx_v7_STM32F107VC__spiInit_1:
;__em_f107vc_spi.c,27 :: 		static T_mikrobus_ret _spiInit_1(const uint32_t* cfg)
; cfg start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; cfg end address is: 0 (R0)
; cfg start address is: 0 (R0)
;__em_f107vc_spi.c,29 :: 		SPI3_Init_Advanced( (unsigned char)cfg[0], (long)cfg[1], &_GPIO_MODULE_SPI3_PC10_11_12 );
ADDS	R1, R0, #4
LDR	R2, [R1, #0]
LDR	R1, [R0, #0]
; cfg end address is: 0 (R0)
UXTB	R0, R1
MOV	R1, R2
MOVW	R2, #lo_addr(__GPIO_MODULE_SPI3_PC10_11_12+0)
MOVT	R2, #hi_addr(__GPIO_MODULE_SPI3_PC10_11_12+0)
BL	_SPI3_Init_Advanced+0
;__em_f107vc_spi.c,30 :: 		return _MIKROBUS_OK;
MOVS	R0, __MIKROBUS_OK
;__em_f107vc_spi.c,31 :: 		}
L_end__spiInit_1:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of easymx_v7_STM32F107VC__spiInit_1
easymx_v7_STM32F107VC__spiInit_2:
;__em_f107vc_spi.c,33 :: 		static T_mikrobus_ret _spiInit_2(const uint32_t* cfg)
; cfg start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; cfg end address is: 0 (R0)
; cfg start address is: 0 (R0)
;__em_f107vc_spi.c,35 :: 		SPI3_Init_Advanced( (unsigned char)cfg[0], (long)cfg[1], &_GPIO_MODULE_SPI3_PC10_11_12 );
ADDS	R1, R0, #4
LDR	R2, [R1, #0]
LDR	R1, [R0, #0]
; cfg end address is: 0 (R0)
UXTB	R0, R1
MOV	R1, R2
MOVW	R2, #lo_addr(__GPIO_MODULE_SPI3_PC10_11_12+0)
MOVT	R2, #hi_addr(__GPIO_MODULE_SPI3_PC10_11_12+0)
BL	_SPI3_Init_Advanced+0
;__em_f107vc_spi.c,36 :: 		return _MIKROBUS_OK;
MOVS	R0, __MIKROBUS_OK
;__em_f107vc_spi.c,37 :: 		}
L_end__spiInit_2:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of easymx_v7_STM32F107VC__spiInit_2
easymx_v7_STM32F107VC__log_write:
;__em_f107vc_log.c,17 :: 		static T_mikrobus_ret _log_write(uint8_t *data_)
; data_ start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; data_ end address is: 0 (R0)
; data_ start address is: 0 (R0)
;__em_f107vc_log.c,19 :: 		logger( *data_ );
LDRB	R1, [R0, #0]
; data_ end address is: 0 (R0)
UXTB	R4, R1
UXTH	R0, R4
MOVW	R4, #lo_addr(_logger+0)
MOVT	R4, #hi_addr(_logger+0)
LDR	R4, [R4, #0]
BLX	R4
;__em_f107vc_log.c,20 :: 		return 0;
MOVS	R0, #0
;__em_f107vc_log.c,21 :: 		}
L_end__log_write:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of easymx_v7_STM32F107VC__log_write
easymx_v7_STM32F107VC__log_init1:
;__em_f107vc_log.c,23 :: 		static T_mikrobus_ret _log_init1(uint32_t baud)
; baud start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; baud end address is: 0 (R0)
; baud start address is: 0 (R0)
;__em_f107vc_log.c,25 :: 		UART3_Init_Advanced(baud, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART3_PD89);
MOVW	R1, #lo_addr(__GPIO_MODULE_USART3_PD89+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_USART3_PD89+0)
PUSH	(R1)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
; baud end address is: 0 (R0)
BL	_UART3_Init_Advanced+0
ADD	SP, SP, #4
;__em_f107vc_log.c,26 :: 		logger = UART3_Write;
MOVW	R2, #lo_addr(_UART3_Write+0)
MOVT	R2, #hi_addr(_UART3_Write+0)
MOVW	R1, #lo_addr(_logger+0)
MOVT	R1, #hi_addr(_logger+0)
STR	R2, [R1, #0]
;__em_f107vc_log.c,27 :: 		return 0;
MOVS	R0, #0
;__em_f107vc_log.c,28 :: 		}
L_end__log_init1:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of easymx_v7_STM32F107VC__log_init1
easymx_v7_STM32F107VC__log_init2:
;__em_f107vc_log.c,30 :: 		static T_mikrobus_ret _log_init2(uint32_t baud)
; baud start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; baud end address is: 0 (R0)
; baud start address is: 0 (R0)
;__em_f107vc_log.c,32 :: 		UART2_Init_Advanced(baud, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART2_PD56);
MOVW	R1, #lo_addr(__GPIO_MODULE_USART2_PD56+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_USART2_PD56+0)
PUSH	(R1)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
; baud end address is: 0 (R0)
BL	_UART2_Init_Advanced+0
ADD	SP, SP, #4
;__em_f107vc_log.c,33 :: 		logger = UART2_Write;
MOVW	R2, #lo_addr(_UART2_Write+0)
MOVT	R2, #hi_addr(_UART2_Write+0)
MOVW	R1, #lo_addr(_logger+0)
MOVT	R1, #hi_addr(_logger+0)
STR	R2, [R1, #0]
;__em_f107vc_log.c,34 :: 		return 0;
MOVS	R0, #0
;__em_f107vc_log.c,35 :: 		}
L_end__log_init2:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of easymx_v7_STM32F107VC__log_init2
easymx_v7_STM32F107VC__log_initUartA:
;__em_f107vc_log.c,37 :: 		static T_mikrobus_ret _log_initUartA(uint32_t baud)
; baud start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; baud end address is: 0 (R0)
; baud start address is: 0 (R0)
;__em_f107vc_log.c,39 :: 		UART1_Init_Advanced(baud, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10);
MOVW	R1, #lo_addr(__GPIO_MODULE_USART1_PA9_10+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_USART1_PA9_10+0)
PUSH	(R1)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
; baud end address is: 0 (R0)
BL	_UART1_Init_Advanced+0
ADD	SP, SP, #4
;__em_f107vc_log.c,40 :: 		logger = UART1_Write;
MOVW	R2, #lo_addr(_UART1_Write+0)
MOVT	R2, #hi_addr(_UART1_Write+0)
MOVW	R1, #lo_addr(_logger+0)
MOVT	R1, #hi_addr(_logger+0)
STR	R2, [R1, #0]
;__em_f107vc_log.c,41 :: 		return 0;
MOVS	R0, #0
;__em_f107vc_log.c,42 :: 		}
L_end__log_initUartA:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of easymx_v7_STM32F107VC__log_initUartA
easymx_v7_STM32F107VC__log_initUartB:
;__em_f107vc_log.c,44 :: 		static T_mikrobus_ret _log_initUartB(uint32_t baud)
; baud start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; baud end address is: 0 (R0)
; baud start address is: 0 (R0)
;__em_f107vc_log.c,46 :: 		UART2_Init_Advanced(baud, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART2_PD56);
MOVW	R1, #lo_addr(__GPIO_MODULE_USART2_PD56+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_USART2_PD56+0)
PUSH	(R1)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
; baud end address is: 0 (R0)
BL	_UART2_Init_Advanced+0
ADD	SP, SP, #4
;__em_f107vc_log.c,47 :: 		logger = UART2_Write;
MOVW	R2, #lo_addr(_UART2_Write+0)
MOVT	R2, #hi_addr(_UART2_Write+0)
MOVW	R1, #lo_addr(_logger+0)
MOVT	R1, #hi_addr(_logger+0)
STR	R2, [R1, #0]
;__em_f107vc_log.c,48 :: 		return 0;
MOVS	R0, #0
;__em_f107vc_log.c,49 :: 		}
L_end__log_initUartB:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of easymx_v7_STM32F107VC__log_initUartB
_mikrobus_gpioInit:
;easymx_v7_STM32F107VC.c,162 :: 		T_mikrobus_ret mikrobus_gpioInit(T_mikrobus_soc bus, T_mikrobus_pin pin, T_gpio_dir direction)
; direction start address is: 8 (R2)
; pin start address is: 4 (R1)
; bus start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R9, R1
UXTB	R10, R2
; direction end address is: 8 (R2)
; pin end address is: 4 (R1)
; bus end address is: 0 (R0)
; bus start address is: 0 (R0)
; pin start address is: 36 (R9)
; direction start address is: 40 (R10)
;easymx_v7_STM32F107VC.c,164 :: 		switch( bus )
IT	AL
BAL	L_mikrobus_gpioInit78
; bus end address is: 0 (R0)
;easymx_v7_STM32F107VC.c,167 :: 		case _MIKROBUS1 : return _gpioInit_1(pin, direction);
L_mikrobus_gpioInit80:
UXTB	R1, R10
; direction end address is: 40 (R10)
UXTB	R0, R9
; pin end address is: 36 (R9)
BL	easymx_v7_STM32F107VC__gpioInit_1+0
IT	AL
BAL	L_end_mikrobus_gpioInit
;easymx_v7_STM32F107VC.c,170 :: 		case _MIKROBUS2 : return _gpioInit_2(pin, direction);
L_mikrobus_gpioInit81:
; direction start address is: 40 (R10)
; pin start address is: 36 (R9)
UXTB	R1, R10
; direction end address is: 40 (R10)
UXTB	R0, R9
; pin end address is: 36 (R9)
BL	easymx_v7_STM32F107VC__gpioInit_2+0
IT	AL
BAL	L_end_mikrobus_gpioInit
;easymx_v7_STM32F107VC.c,184 :: 		default : return _MIKROBUS_ERR_BUS;
L_mikrobus_gpioInit82:
MOVS	R0, #1
IT	AL
BAL	L_end_mikrobus_gpioInit
;easymx_v7_STM32F107VC.c,185 :: 		}
L_mikrobus_gpioInit78:
; direction start address is: 40 (R10)
; pin start address is: 36 (R9)
; bus start address is: 0 (R0)
CMP	R0, #0
IT	EQ
BEQ	L_mikrobus_gpioInit80
CMP	R0, #1
IT	EQ
BEQ	L_mikrobus_gpioInit81
; bus end address is: 0 (R0)
; pin end address is: 36 (R9)
; direction end address is: 40 (R10)
IT	AL
BAL	L_mikrobus_gpioInit82
;easymx_v7_STM32F107VC.c,187 :: 		}
L_end_mikrobus_gpioInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _mikrobus_gpioInit
_mikrobus_spiInit:
;easymx_v7_STM32F107VC.c,192 :: 		T_mikrobus_ret mikrobus_spiInit(T_mikrobus_soc bus, const uint32_t *cfg)
; cfg start address is: 4 (R1)
; bus start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R11, R1
; cfg end address is: 4 (R1)
; bus end address is: 0 (R0)
; bus start address is: 0 (R0)
; cfg start address is: 44 (R11)
;easymx_v7_STM32F107VC.c,194 :: 		switch( bus )
IT	AL
BAL	L_mikrobus_spiInit83
; bus end address is: 0 (R0)
;easymx_v7_STM32F107VC.c,197 :: 		case _MIKROBUS1 : return _spiInit_1( cfg );
L_mikrobus_spiInit85:
MOV	R0, R11
; cfg end address is: 44 (R11)
BL	easymx_v7_STM32F107VC__spiInit_1+0
IT	AL
BAL	L_end_mikrobus_spiInit
;easymx_v7_STM32F107VC.c,200 :: 		case _MIKROBUS2 : return _spiInit_2( cfg );
L_mikrobus_spiInit86:
; cfg start address is: 44 (R11)
MOV	R0, R11
; cfg end address is: 44 (R11)
BL	easymx_v7_STM32F107VC__spiInit_2+0
IT	AL
BAL	L_end_mikrobus_spiInit
;easymx_v7_STM32F107VC.c,214 :: 		default : return _MIKROBUS_ERR_BUS;
L_mikrobus_spiInit87:
MOVS	R0, #1
IT	AL
BAL	L_end_mikrobus_spiInit
;easymx_v7_STM32F107VC.c,215 :: 		}
L_mikrobus_spiInit83:
; cfg start address is: 44 (R11)
; bus start address is: 0 (R0)
CMP	R0, #0
IT	EQ
BEQ	L_mikrobus_spiInit85
CMP	R0, #1
IT	EQ
BEQ	L_mikrobus_spiInit86
; bus end address is: 0 (R0)
; cfg end address is: 44 (R11)
IT	AL
BAL	L_mikrobus_spiInit87
;easymx_v7_STM32F107VC.c,217 :: 		}
L_end_mikrobus_spiInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _mikrobus_spiInit
_mikrobus_logInit:
;easymx_v7_STM32F107VC.c,283 :: 		T_mikrobus_ret mikrobus_logInit(T_log_bus port, const uint32_t baud)
; baud start address is: 4 (R1)
; port start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; baud end address is: 4 (R1)
; port end address is: 0 (R0)
; port start address is: 0 (R0)
; baud start address is: 4 (R1)
;easymx_v7_STM32F107VC.c,285 :: 		switch( port )
IT	AL
BAL	L_mikrobus_logInit88
; port end address is: 0 (R0)
;easymx_v7_STM32F107VC.c,288 :: 		case _MIKROBUS1 : return _log_init1( baud );
L_mikrobus_logInit90:
MOV	R0, R1
; baud end address is: 4 (R1)
BL	easymx_v7_STM32F107VC__log_init1+0
IT	AL
BAL	L_end_mikrobus_logInit
;easymx_v7_STM32F107VC.c,291 :: 		case _MIKROBUS2: return _log_init2( baud );
L_mikrobus_logInit91:
; baud start address is: 4 (R1)
MOV	R0, R1
; baud end address is: 4 (R1)
BL	easymx_v7_STM32F107VC__log_init2+0
IT	AL
BAL	L_end_mikrobus_logInit
;easymx_v7_STM32F107VC.c,309 :: 		case _LOG_USBUART_A : return _log_initUartA( baud );
L_mikrobus_logInit92:
; baud start address is: 4 (R1)
MOV	R0, R1
; baud end address is: 4 (R1)
BL	easymx_v7_STM32F107VC__log_initUartA+0
IT	AL
BAL	L_end_mikrobus_logInit
;easymx_v7_STM32F107VC.c,312 :: 		case _LOG_USBUART_B : return _log_initUartB( baud );
L_mikrobus_logInit93:
; baud start address is: 4 (R1)
MOV	R0, R1
; baud end address is: 4 (R1)
BL	easymx_v7_STM32F107VC__log_initUartB+0
IT	AL
BAL	L_end_mikrobus_logInit
;easymx_v7_STM32F107VC.c,314 :: 		default : return _MIKROBUS_ERR_BUS;
L_mikrobus_logInit94:
MOVS	R0, #1
IT	AL
BAL	L_end_mikrobus_logInit
;easymx_v7_STM32F107VC.c,315 :: 		}
L_mikrobus_logInit88:
; baud start address is: 4 (R1)
; port start address is: 0 (R0)
CMP	R0, #0
IT	EQ
BEQ	L_mikrobus_logInit90
CMP	R0, #1
IT	EQ
BEQ	L_mikrobus_logInit91
CMP	R0, #32
IT	EQ
BEQ	L_mikrobus_logInit92
CMP	R0, #48
IT	EQ
BEQ	L_mikrobus_logInit93
; port end address is: 0 (R0)
; baud end address is: 4 (R1)
IT	AL
BAL	L_mikrobus_logInit94
;easymx_v7_STM32F107VC.c,317 :: 		}
L_end_mikrobus_logInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _mikrobus_logInit
_mikrobus_logWrite:
;easymx_v7_STM32F107VC.c,319 :: 		T_mikrobus_ret mikrobus_logWrite(uint8_t* data_, T_log_format format)
; format start address is: 4 (R1)
; data_ start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
MOV	R2, R0
; format end address is: 4 (R1)
; data_ end address is: 0 (R0)
; data_ start address is: 8 (R2)
; format start address is: 4 (R1)
;easymx_v7_STM32F107VC.c,321 :: 		uint8_t *ptr = data_;
; ptr start address is: 0 (R0)
MOV	R0, R2
; data_ end address is: 8 (R2)
;easymx_v7_STM32F107VC.c,322 :: 		uint8_t row = 13;
MOVS	R2, #13
STRB	R2, [SP, #8]
MOVS	R2, #10
STRB	R2, [SP, #9]
;easymx_v7_STM32F107VC.c,323 :: 		uint8_t line = 10;
;easymx_v7_STM32F107VC.c,324 :: 		switch( format )
IT	AL
BAL	L_mikrobus_logWrite95
; format end address is: 4 (R1)
;easymx_v7_STM32F107VC.c,326 :: 		case _LOG_BYTE :
L_mikrobus_logWrite97:
;easymx_v7_STM32F107VC.c,327 :: 		_log_write( ptr );
; ptr end address is: 0 (R0)
BL	easymx_v7_STM32F107VC__log_write+0
;easymx_v7_STM32F107VC.c,328 :: 		break;
IT	AL
BAL	L_mikrobus_logWrite96
;easymx_v7_STM32F107VC.c,329 :: 		case _LOG_TEXT :
L_mikrobus_logWrite98:
;easymx_v7_STM32F107VC.c,330 :: 		while( *ptr )
; ptr start address is: 0 (R0)
L_mikrobus_logWrite99:
; ptr end address is: 0 (R0)
; ptr start address is: 0 (R0)
LDRB	R2, [R0, #0]
CMP	R2, #0
IT	EQ
BEQ	L_mikrobus_logWrite100
;easymx_v7_STM32F107VC.c,332 :: 		_log_write( ptr );
STR	R0, [SP, #4]
BL	easymx_v7_STM32F107VC__log_write+0
LDR	R0, [SP, #4]
;easymx_v7_STM32F107VC.c,333 :: 		ptr++;
ADDS	R0, R0, #1
;easymx_v7_STM32F107VC.c,334 :: 		}
; ptr end address is: 0 (R0)
IT	AL
BAL	L_mikrobus_logWrite99
L_mikrobus_logWrite100:
;easymx_v7_STM32F107VC.c,335 :: 		break;
IT	AL
BAL	L_mikrobus_logWrite96
;easymx_v7_STM32F107VC.c,336 :: 		case _LOG_LINE :
L_mikrobus_logWrite101:
;easymx_v7_STM32F107VC.c,337 :: 		while( *ptr )
; ptr start address is: 0 (R0)
L_mikrobus_logWrite102:
; ptr end address is: 0 (R0)
; ptr start address is: 0 (R0)
LDRB	R2, [R0, #0]
CMP	R2, #0
IT	EQ
BEQ	L_mikrobus_logWrite103
;easymx_v7_STM32F107VC.c,339 :: 		_log_write( ptr );
STR	R0, [SP, #4]
BL	easymx_v7_STM32F107VC__log_write+0
LDR	R0, [SP, #4]
;easymx_v7_STM32F107VC.c,340 :: 		ptr++;
ADDS	R0, R0, #1
;easymx_v7_STM32F107VC.c,341 :: 		}
; ptr end address is: 0 (R0)
IT	AL
BAL	L_mikrobus_logWrite102
L_mikrobus_logWrite103:
;easymx_v7_STM32F107VC.c,342 :: 		_log_write( &row );
ADD	R2, SP, #8
MOV	R0, R2
BL	easymx_v7_STM32F107VC__log_write+0
;easymx_v7_STM32F107VC.c,343 :: 		_log_write( &line );
ADD	R2, SP, #9
MOV	R0, R2
BL	easymx_v7_STM32F107VC__log_write+0
;easymx_v7_STM32F107VC.c,344 :: 		break;
IT	AL
BAL	L_mikrobus_logWrite96
;easymx_v7_STM32F107VC.c,345 :: 		default :
L_mikrobus_logWrite104:
;easymx_v7_STM32F107VC.c,346 :: 		return _MIKROBUS_ERR_LOG;
MOVS	R0, #6
IT	AL
BAL	L_end_mikrobus_logWrite
;easymx_v7_STM32F107VC.c,347 :: 		}
L_mikrobus_logWrite95:
; ptr start address is: 0 (R0)
; format start address is: 4 (R1)
CMP	R1, #0
IT	EQ
BEQ	L_mikrobus_logWrite97
CMP	R1, #1
IT	EQ
BEQ	L_mikrobus_logWrite98
CMP	R1, #2
IT	EQ
BEQ	L_mikrobus_logWrite101
; format end address is: 4 (R1)
; ptr end address is: 0 (R0)
IT	AL
BAL	L_mikrobus_logWrite104
L_mikrobus_logWrite96:
;easymx_v7_STM32F107VC.c,348 :: 		return 0;
MOVS	R0, #0
;easymx_v7_STM32F107VC.c,349 :: 		}
L_end_mikrobus_logWrite:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _mikrobus_logWrite
