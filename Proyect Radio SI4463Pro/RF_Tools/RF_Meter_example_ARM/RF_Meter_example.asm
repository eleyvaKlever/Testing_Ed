_system_init:
;RF_Meter_example.c,22 :: 		void system_init()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;RF_Meter_example.c,27 :: 		&_GPIO_MODULE_SPI3_PC10_11_12 );
MOVW	R2, #lo_addr(__GPIO_MODULE_SPI3_PC10_11_12+0)
MOVT	R2, #hi_addr(__GPIO_MODULE_SPI3_PC10_11_12+0)
;RF_Meter_example.c,26 :: 		_SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1,
MOVW	R1, #772
;RF_Meter_example.c,24 :: 		SPI3_Init_Advanced( _SPI_FPCLK_DIV64, _SPI_MASTER | _SPI_8_BIT |
MOVS	R0, #5
;RF_Meter_example.c,27 :: 		&_GPIO_MODULE_SPI3_PC10_11_12 );
BL	_SPI3_Init_Advanced+0
;RF_Meter_example.c,29 :: 		GPIO_Digital_Output( &GPIOD_BASE, _GPIO_PINMASK_13 );
MOVW	R1, #8192
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Output+0
;RF_Meter_example.c,30 :: 		Delay_ms( 500 );
MOVW	R7, #1258
MOVT	R7, #178
NOP
NOP
L_system_init0:
SUBS	R7, R7, #1
BNE	L_system_init0
NOP
NOP
NOP
NOP
;RF_Meter_example.c,32 :: 		track = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_track+0)
MOVT	R0, #hi_addr(_track+0)
STRH	R1, [R0, #0]
;RF_Meter_example.c,33 :: 		last_track = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_last_track+0)
MOVT	R0, #hi_addr(_last_track+0)
STRH	R1, [R0, #0]
;RF_Meter_example.c,34 :: 		}
L_end_system_init:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _system_init
_display_init:
;RF_Meter_example.c,36 :: 		void display_init()
SUB	SP, SP, #76
STR	LR, [SP, #0]
;RF_Meter_example.c,38 :: 		TFT_Init_ILI9341_8bit( 320, 240 );
MOVS	R1, #240
MOVW	R0, #320
BL	_TFT_Init_ILI9341_8bit+0
;RF_Meter_example.c,39 :: 		TFT_BLED = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
_SX	[R0, ByteOffset(GPIOE_ODR+0)]
;RF_Meter_example.c,40 :: 		TFT_Set_Pen( CL_WHITE, 1 );
MOVS	R1, #1
MOVW	R0, #65535
BL	_TFT_Set_Pen+0
;RF_Meter_example.c,41 :: 		TFT_Set_Brush( 1,CL_WHITE,0,0,0,0 );
MOVS	R1, #0
MOVS	R0, #0
PUSH	(R1)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #0
MOVW	R1, #65535
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
;RF_Meter_example.c,42 :: 		TFT_Set_Font( TFT_defaultFont, CL_BLACK, FO_HORIZONTAL );
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;RF_Meter_example.c,43 :: 		TFT_Fill_Screen( CL_WHITE );
MOVW	R0, #65535
BL	_TFT_Fill_Screen+0
;RF_Meter_example.c,44 :: 		TFT_Set_Pen( CL_BLACK, 1 );
MOVS	R1, #1
MOVW	R0, #0
BL	_TFT_Set_Pen+0
;RF_Meter_example.c,45 :: 		TFT_Line(  20,  46, 300,  46 );
MOVS	R3, #46
SXTH	R3, R3
MOVW	R2, #300
SXTH	R2, R2
MOVS	R1, #46
SXTH	R1, R1
MOVS	R0, #20
SXTH	R0, R0
BL	_TFT_Line+0
;RF_Meter_example.c,46 :: 		TFT_Line(  20,  70, 300,  70 );
MOVS	R3, #70
SXTH	R3, R3
MOVW	R2, #300
SXTH	R2, R2
MOVS	R1, #70
SXTH	R1, R1
MOVS	R0, #20
SXTH	R0, R0
BL	_TFT_Line+0
;RF_Meter_example.c,47 :: 		TFT_Line(  20, 196, 300, 196 );;
MOVS	R3, #196
SXTH	R3, R3
MOVW	R2, #300
SXTH	R2, R2
MOVS	R1, #196
SXTH	R1, R1
MOVS	R0, #20
SXTH	R0, R0
BL	_TFT_Line+0
;RF_Meter_example.c,48 :: 		TFT_Line(  20, 220, 300, 220 );
MOVS	R3, #220
SXTH	R3, R3
MOVW	R2, #300
SXTH	R2, R2
MOVS	R1, #220
SXTH	R1, R1
MOVS	R0, #20
SXTH	R0, R0
BL	_TFT_Line+0
;RF_Meter_example.c,49 :: 		TFT_Set_Pen( CL_WHITE, 1 );
MOVS	R1, #1
MOVW	R0, #65535
BL	_TFT_Set_Pen+0
;RF_Meter_example.c,50 :: 		TFT_Set_Font( &HandelGothic_BT21x22_Regular, CL_RED, FO_HORIZONTAL );
MOVS	R2, #0
MOVW	R1, #63488
MOVW	R0, #lo_addr(_HandelGothic_BT21x22_Regular+0)
MOVT	R0, #hi_addr(_HandelGothic_BT21x22_Regular+0)
BL	_TFT_Set_Font+0
;RF_Meter_example.c,51 :: 		TFT_Write_Text( "RF Meter click", 95, 14 );
ADD	R11, SP, #4
ADD	R10, R11, #15
MOVW	R12, #lo_addr(?ICS?lstr1_RF_Meter_example+0)
MOVT	R12, #hi_addr(?ICS?lstr1_RF_Meter_example+0)
BL	___CC2DW+0
ADD	R0, SP, #4
MOVS	R2, #14
MOVS	R1, #95
BL	_TFT_Write_Text+0
;RF_Meter_example.c,52 :: 		TFT_Set_Font( &Tahoma15x16_Bold, CL_BLUE, FO_HORIZONTAL );
MOVS	R2, #0
MOVW	R1, #31
MOVW	R0, #lo_addr(_Tahoma15x16_Bold+0)
MOVT	R0, #hi_addr(_Tahoma15x16_Bold+0)
BL	_TFT_Set_Font+0
;RF_Meter_example.c,53 :: 		TFT_Write_Text( "AD8318", 130, 50 );
MOVS	R0, #65
STRB	R0, [SP, #19]
MOVS	R0, #68
STRB	R0, [SP, #20]
MOVS	R0, #56
STRB	R0, [SP, #21]
MOVS	R0, #51
STRB	R0, [SP, #22]
MOVS	R0, #49
STRB	R0, [SP, #23]
MOVS	R0, #56
STRB	R0, [SP, #24]
MOVS	R0, #0
STRB	R0, [SP, #25]
ADD	R0, SP, #19
MOVS	R2, #50
MOVS	R1, #130
BL	_TFT_Write_Text+0
;RF_Meter_example.c,54 :: 		TFT_Set_Font( &Verdana12x13_Regular, CL_BLACK, FO_HORIZONTAL );
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_Verdana12x13_Regular+0)
MOVT	R0, #hi_addr(_Verdana12x13_Regular+0)
BL	_TFT_Set_Font+0
;RF_Meter_example.c,55 :: 		TFT_Write_Text("Kleverness", 19, 223);
ADD	R11, SP, #26
ADD	R10, R11, #11
MOVW	R12, #lo_addr(?ICS?lstr3_RF_Meter_example+0)
MOVT	R12, #hi_addr(?ICS?lstr3_RF_Meter_example+0)
BL	___CC2DW+0
ADD	R0, SP, #26
MOVS	R2, #223
MOVS	R1, #19
BL	_TFT_Write_Text+0
;RF_Meter_example.c,56 :: 		TFT_Set_Font( &Verdana12x13_Regular, CL_RED, FO_HORIZONTAL );
MOVS	R2, #0
MOVW	R1, #63488
MOVW	R0, #lo_addr(_Verdana12x13_Regular+0)
MOVT	R0, #hi_addr(_Verdana12x13_Regular+0)
BL	_TFT_Set_Font+0
;RF_Meter_example.c,57 :: 		TFT_Write_Text( "www.mikroe.com", 200, 223 );
ADD	R11, SP, #37
ADD	R10, R11, #15
MOVW	R12, #lo_addr(?ICS?lstr4_RF_Meter_example+0)
MOVT	R12, #hi_addr(?ICS?lstr4_RF_Meter_example+0)
BL	___CC2DW+0
ADD	R0, SP, #37
MOVS	R2, #223
MOVS	R1, #200
BL	_TFT_Write_Text+0
;RF_Meter_example.c,58 :: 		TFT_Set_Font( &Tahoma15x16_Bold, CL_BLACK, FO_HORIZONTAL );
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_Tahoma15x16_Bold+0)
MOVT	R0, #hi_addr(_Tahoma15x16_Bold+0)
BL	_TFT_Set_Font+0
;RF_Meter_example.c,59 :: 		TFT_Write_Text( "Signal Strength Meter", 30, 200 );
ADD	R11, SP, #52
ADD	R10, R11, #22
MOVW	R12, #lo_addr(?ICS?lstr5_RF_Meter_example+0)
MOVT	R12, #hi_addr(?ICS?lstr5_RF_Meter_example+0)
BL	___CC2DW+0
ADD	R0, SP, #52
MOVS	R2, #200
MOVS	R1, #30
BL	_TFT_Write_Text+0
;RF_Meter_example.c,60 :: 		TFT_Set_Font( &HandelGothic_BT21x22_Regular, CL_BLACK, FO_HORIZONTAL );
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_HandelGothic_BT21x22_Regular+0)
MOVT	R0, #hi_addr(_HandelGothic_BT21x22_Regular+0)
BL	_TFT_Set_Font+0
;RF_Meter_example.c,61 :: 		TFT_Image( 114, 100, signal_lo_bmp , 2 );
MOVS	R3, #2
MOVW	R2, #lo_addr(_signal_lo_bmp+0)
MOVT	R2, #hi_addr(_signal_lo_bmp+0)
MOVS	R1, #100
MOVS	R0, #114
BL	_TFT_Image+0
;RF_Meter_example.c,62 :: 		}
L_end_display_init:
LDR	LR, [SP, #0]
ADD	SP, SP, #76
BX	LR
; end of _display_init
_main:
;RF_Meter_example.c,64 :: 		void main()
;RF_Meter_example.c,66 :: 		system_init();
BL	_system_init+0
;RF_Meter_example.c,67 :: 		display_init();
BL	_display_init+0
;RF_Meter_example.c,71 :: 		rf_meter_init();
BL	_rf_meter_init+0
;RF_Meter_example.c,72 :: 		Delay_ms( 200 );
MOVW	R7, #13610
MOVT	R7, #71
NOP
NOP
L_main2:
SUBS	R7, R7, #1
BNE	L_main2
NOP
NOP
NOP
NOP
;RF_Meter_example.c,74 :: 		while( 1 )
L_main4:
;RF_Meter_example.c,77 :: 		result = rf_meter_get_signal_strength();
BL	_rf_meter_get_signal_strength+0
MOVW	R1, #lo_addr(_result+0)
MOVT	R1, #hi_addr(_result+0)
STR	R0, [R1, #0]
;RF_Meter_example.c,81 :: 		if ( result < -50.0 )
MOVW	R2, #0
MOVT	R2, #49736
BL	__Compare_FP+0
MOVW	R0, #0
BGE	L__main32
MOVS	R0, #1
L__main32:
CMP	R0, #0
IT	EQ
BEQ	L_main6
;RF_Meter_example.c,82 :: 		track = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_track+0)
MOVT	R0, #hi_addr(_track+0)
STRH	R1, [R0, #0]
IT	AL
BAL	L_main7
L_main6:
;RF_Meter_example.c,83 :: 		else if ( ( result < -35.0 ) && ( result >= -50.0 ) )
MOVW	R0, #lo_addr(_result+0)
MOVT	R0, #hi_addr(_result+0)
LDR	R2, [R0, #0]
MOVW	R0, #0
MOVT	R0, #49676
BL	__Compare_FP+0
MOVW	R0, #0
BLE	L__main33
MOVS	R0, #1
L__main33:
CMP	R0, #0
IT	EQ
BEQ	L__main26
MOVW	R0, #lo_addr(_result+0)
MOVT	R0, #hi_addr(_result+0)
LDR	R2, [R0, #0]
MOVW	R0, #0
MOVT	R0, #49736
BL	__Compare_FP+0
MOVW	R0, #0
BGT	L__main34
MOVS	R0, #1
L__main34:
CMP	R0, #0
IT	EQ
BEQ	L__main25
L__main24:
;RF_Meter_example.c,84 :: 		track = 1;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_track+0)
MOVT	R0, #hi_addr(_track+0)
STRH	R1, [R0, #0]
IT	AL
BAL	L_main11
;RF_Meter_example.c,83 :: 		else if ( ( result < -35.0 ) && ( result >= -50.0 ) )
L__main26:
L__main25:
;RF_Meter_example.c,85 :: 		else if ( ( result < -20.0 ) && ( result >= -35 ) )
MOVW	R0, #lo_addr(_result+0)
MOVT	R0, #hi_addr(_result+0)
LDR	R2, [R0, #0]
MOVW	R0, #0
MOVT	R0, #49568
BL	__Compare_FP+0
MOVW	R0, #0
BLE	L__main35
MOVS	R0, #1
L__main35:
CMP	R0, #0
IT	EQ
BEQ	L__main28
MOVW	R0, #lo_addr(_result+0)
MOVT	R0, #hi_addr(_result+0)
LDR	R2, [R0, #0]
MOVW	R0, #0
MOVT	R0, #49676
BL	__Compare_FP+0
MOVW	R0, #0
BGT	L__main36
MOVS	R0, #1
L__main36:
CMP	R0, #0
IT	EQ
BEQ	L__main27
L__main23:
;RF_Meter_example.c,86 :: 		track = 2;
MOVS	R1, #2
SXTH	R1, R1
MOVW	R0, #lo_addr(_track+0)
MOVT	R0, #hi_addr(_track+0)
STRH	R1, [R0, #0]
IT	AL
BAL	L_main15
;RF_Meter_example.c,85 :: 		else if ( ( result < -20.0 ) && ( result >= -35 ) )
L__main28:
L__main27:
;RF_Meter_example.c,88 :: 		track = 3;
MOVS	R1, #3
SXTH	R1, R1
MOVW	R0, #lo_addr(_track+0)
MOVT	R0, #hi_addr(_track+0)
STRH	R1, [R0, #0]
L_main15:
L_main11:
L_main7:
;RF_Meter_example.c,91 :: 		if ( track != last_track )
MOVW	R0, #lo_addr(_last_track+0)
MOVT	R0, #hi_addr(_last_track+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_track+0)
MOVT	R0, #hi_addr(_track+0)
LDRSH	R0, [R0, #0]
CMP	R0, R1
IT	EQ
BEQ	L_main16
;RF_Meter_example.c,93 :: 		TFT_Rectangle( 112, 98, 196, 166 );
MOVS	R3, #166
SXTH	R3, R3
MOVS	R2, #196
SXTH	R2, R2
MOVS	R1, #98
SXTH	R1, R1
MOVS	R0, #112
SXTH	R0, R0
BL	_TFT_Rectangle+0
;RF_Meter_example.c,95 :: 		switch( track )
IT	AL
BAL	L_main17
;RF_Meter_example.c,97 :: 		case 0 :
L_main19:
;RF_Meter_example.c,98 :: 		TFT_Image( 114, 100, signal_lo_bmp , 2 );
MOVS	R3, #2
MOVW	R2, #lo_addr(_signal_lo_bmp+0)
MOVT	R2, #hi_addr(_signal_lo_bmp+0)
MOVS	R1, #100
MOVS	R0, #114
BL	_TFT_Image+0
;RF_Meter_example.c,99 :: 		break;
IT	AL
BAL	L_main18
;RF_Meter_example.c,100 :: 		case 1 :
L_main20:
;RF_Meter_example.c,101 :: 		TFT_Image( 114, 100, signal_lo_m_bmp , 2 );
MOVS	R3, #2
MOVW	R2, #lo_addr(_signal_lo_m_bmp+0)
MOVT	R2, #hi_addr(_signal_lo_m_bmp+0)
MOVS	R1, #100
MOVS	R0, #114
BL	_TFT_Image+0
;RF_Meter_example.c,102 :: 		break;
IT	AL
BAL	L_main18
;RF_Meter_example.c,103 :: 		case 2 :
L_main21:
;RF_Meter_example.c,104 :: 		TFT_Image( 114, 100, signal_hi_m_bmp , 2 );
MOVS	R3, #2
MOVW	R2, #lo_addr(_signal_hi_m_bmp+0)
MOVT	R2, #hi_addr(_signal_hi_m_bmp+0)
MOVS	R1, #100
MOVS	R0, #114
BL	_TFT_Image+0
;RF_Meter_example.c,105 :: 		break;
IT	AL
BAL	L_main18
;RF_Meter_example.c,106 :: 		case 3 :
L_main22:
;RF_Meter_example.c,107 :: 		TFT_Image( 114, 100, signal_hi_bmp , 2 );
MOVS	R3, #2
MOVW	R2, #lo_addr(_signal_hi_bmp+0)
MOVT	R2, #hi_addr(_signal_hi_bmp+0)
MOVS	R1, #100
MOVS	R0, #114
BL	_TFT_Image+0
;RF_Meter_example.c,108 :: 		break;
IT	AL
BAL	L_main18
;RF_Meter_example.c,109 :: 		}
L_main17:
MOVW	R0, #lo_addr(_track+0)
MOVT	R0, #hi_addr(_track+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main19
MOVW	R0, #lo_addr(_track+0)
MOVT	R0, #hi_addr(_track+0)
LDRSH	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_main20
MOVW	R0, #lo_addr(_track+0)
MOVT	R0, #hi_addr(_track+0)
LDRSH	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_main21
MOVW	R0, #lo_addr(_track+0)
MOVT	R0, #hi_addr(_track+0)
LDRSH	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_main22
L_main18:
;RF_Meter_example.c,111 :: 		last_track = track;
MOVW	R0, #lo_addr(_track+0)
MOVT	R0, #hi_addr(_track+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_last_track+0)
MOVT	R0, #hi_addr(_last_track+0)
STRH	R1, [R0, #0]
;RF_Meter_example.c,112 :: 		}
L_main16:
;RF_Meter_example.c,115 :: 		sprintf( tmp_txt, "%5.1f    dBm", result );
MOVW	R0, #lo_addr(_result+0)
MOVT	R0, #hi_addr(_result+0)
LDR	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_6_RF_Meter_example+0)
MOVT	R1, #hi_addr(?lstr_6_RF_Meter_example+0)
MOVW	R0, #lo_addr(_tmp_txt+0)
MOVT	R0, #hi_addr(_tmp_txt+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;RF_Meter_example.c,116 :: 		TFT_Rectangle( 198, 200, 288, 218 );
MOVS	R3, #218
SXTH	R3, R3
MOVW	R2, #288
SXTH	R2, R2
MOVS	R1, #200
SXTH	R1, R1
MOVS	R0, #198
SXTH	R0, R0
BL	_TFT_Rectangle+0
;RF_Meter_example.c,117 :: 		TFT_Set_Font( &Tahoma15x16_Bold, CL_BLUE, FO_HORIZONTAL );
MOVS	R2, #0
MOVW	R1, #31
MOVW	R0, #lo_addr(_Tahoma15x16_Bold+0)
MOVT	R0, #hi_addr(_Tahoma15x16_Bold+0)
BL	_TFT_Set_Font+0
;RF_Meter_example.c,118 :: 		TFT_Write_Text( tmp_txt, 205, 200 );
MOVS	R2, #200
MOVS	R1, #205
MOVW	R0, #lo_addr(_tmp_txt+0)
MOVT	R0, #hi_addr(_tmp_txt+0)
BL	_TFT_Write_Text+0
;RF_Meter_example.c,120 :: 		}
IT	AL
BAL	L_main4
;RF_Meter_example.c,121 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
