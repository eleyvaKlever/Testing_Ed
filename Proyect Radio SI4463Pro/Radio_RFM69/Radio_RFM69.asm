_Hardware_Init:
;hardware.h,24 :: 		void Hardware_Init(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;hardware.h,26 :: 		GPIO_Config(&GPIOA_BASE, _GPIO_PINMASK_4, _GPIO_CFG_DIGITAL_OUTPUT);        // CS/NSS Serial Flash pin
MOVW	R2, #20
MOVT	R2, #8
MOVW	R1, #16
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Config+0
;hardware.h,27 :: 		GPIO_Config(&GPIOB_BASE, _GPIO_PINMASK_12, _GPIO_CFG_DIGITAL_OUTPUT);       // CS/NSS Radio pin
MOVW	R2, #20
MOVT	R2, #8
MOVW	R1, #4096
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Config+0
;hardware.h,29 :: 		GPIO_Config(&GPIOC_BASE, _GPIO_PINMASK_14, _GPIO_CFG_DIGITAL_OUTPUT);       // Pin Reset Tactil
MOVW	R2, #20
MOVT	R2, #8
MOVW	R1, #16384
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Config+0
;hardware.h,30 :: 		GPIO_Config(&GPIOC_BASE, _GPIO_PINMASK_15, _GPIO_CFG_DIGITAL_OUTPUT);       // Pin Reset MCU
MOVW	R2, #20
MOVT	R2, #8
MOVW	R1, #32768
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Config+0
;hardware.h,31 :: 		GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_0);                          // LED_1
MOVW	R1, #1
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
;hardware.h,32 :: 		GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_1);                          // LED_2
MOVW	R1, #2
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
;hardware.h,33 :: 		GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_2);                          // LED_3
MOVW	R1, #4
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
;hardware.h,34 :: 		GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_12);                         // LED_4
MOVW	R1, #4096
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
;hardware.h,35 :: 		GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_14);                         // LED_5
MOVW	R1, #16384
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
;hardware.h,36 :: 		GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_15);                         // LED_6
MOVW	R1, #32768
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
;hardware.h,37 :: 		GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_2);                          // Relay_1
MOVW	R1, #4
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;hardware.h,38 :: 		GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_10);                         // Relay_2
MOVW	R1, #1024
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;hardware.h,39 :: 		GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_11);                         // Relay_3
MOVW	R1, #2048
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;hardware.h,40 :: 		GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_8);                          // Sound Buzzer
MOVW	R1, #256
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;hardware.h,42 :: 		GPIO_Digital_Input(&GPIOB_BASE,  _GPIO_PINMASK_9);                          // B5 InterrupcÃ­on Tactil
MOVW	R1, #512
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Input+0
;hardware.h,43 :: 		GPIOA_ODR.B0  = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;hardware.h,44 :: 		GPIOA_ODR.B1  = 0;
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;hardware.h,45 :: 		GPIOA_ODR.B3  = 0;
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;hardware.h,46 :: 		GPIOC_ODR.B14 = 0;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;hardware.h,47 :: 		GPIOC_ODR.B15 = 0;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;hardware.h,49 :: 		Sound_Init(&GPIOB_ODR, 8);                                                 // Salida de Audio Haptica
MOVS	R1, #8
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
BL	_Sound_Init+0
;hardware.h,54 :: 		GPIOA_ODR._GPIO_PIN_4 = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;hardware.h,55 :: 		UART1_Init_Advanced(115200, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10);     // Uart para probar datos
MOVW	R0, #lo_addr(__GPIO_MODULE_USART1_PA9_10+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_USART1_PA9_10+0)
PUSH	(R0)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
MOV	R0, #115200
BL	_UART1_Init_Advanced+0
ADD	SP, SP, #4
;hardware.h,56 :: 		I2C1_Init_Advanced(400000, &_GPIO_MODULE_I2C1_PB67);                                    // I2C para Tactil
MOVW	R1, #lo_addr(__GPIO_MODULE_I2C1_PB67+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_I2C1_PB67+0)
MOVW	R0, #6784
MOVT	R0, #6
BL	_I2C1_Init_Advanced+0
;hardware.h,60 :: 		&_GPIO_MODULE_SPI1_PA567);
MOVW	R2, #lo_addr(__GPIO_MODULE_SPI1_PA567+0)
MOVT	R2, #hi_addr(__GPIO_MODULE_SPI1_PA567+0)
;hardware.h,59 :: 		_SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1,
MOVW	R1, #772
;hardware.h,57 :: 		SPI1_Init_Advanced(_SPI_FPCLK_DIV32, _SPI_MASTER  | _SPI_8_BIT |                        // SPI1 para Memoria Flash
MOVS	R0, #4
;hardware.h,60 :: 		&_GPIO_MODULE_SPI1_PA567);
BL	_SPI1_Init_Advanced+0
;hardware.h,62 :: 		ADC_Set_Input_Channel(_ADC_CHANNEL_8);                     // Choose ADC channel
MOVW	R0, #256
BL	_ADC_Set_Input_Channel+0
;hardware.h,63 :: 		ADC1_Init();
BL	_ADC1_Init+0
;hardware.h,68 :: 		&_GPIO_MODULE_SPI2_PB13_14_15);
MOVW	R2, #lo_addr(__GPIO_MODULE_SPI2_PB13_14_15+0)
MOVT	R2, #hi_addr(__GPIO_MODULE_SPI2_PB13_14_15+0)
;hardware.h,67 :: 		_SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1,
MOVW	R1, #772
;hardware.h,65 :: 		SPI2_Init_Advanced(_SPI_FPCLK_DIV32, _SPI_MASTER | _SPI_8_BIT |
MOVS	R0, #4
;hardware.h,68 :: 		&_GPIO_MODULE_SPI2_PB13_14_15);
BL	_SPI2_Init_Advanced+0
;hardware.h,71 :: 		}
L_end_Hardware_Init:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Hardware_Init
_SPIReadByte:
;rfm69_driver.c,9 :: 		unsigned char SPIReadByte(unsigned long WrPara)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;rfm69_driver.c,13 :: 		wAddr = WrPara >> 8 & 0xff;                               // Extraigo la Dirección de escritura de 1 Byte
LDR	R0, [SP, #4]
LSRS	R0, R0, #8
AND	R4, R0, #255
;rfm69_driver.c,16 :: 		CS_Radio_Select_bit = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;rfm69_driver.c,18 :: 		SPI2_Write(wAddr);
UXTH	R0, R4
BL	_SPI2_Write+0
;rfm69_driver.c,19 :: 		temp = SPI2_Read(0);
MOVS	R0, #0
BL	_SPI2_Read+0
;rfm69_driver.c,20 :: 		CS_Radio_Select_bit = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
STR	R2, [R1, #0]
;rfm69_driver.c,21 :: 		return temp;
UXTB	R0, R0
;rfm69_driver.c,22 :: 		}
L_end_SPIReadByte:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _SPIReadByte
_SPIWriteByte:
;rfm69_driver.c,28 :: 		void SPIWriteByte(unsigned int WrPara, int SPIPort)
SUB	SP, SP, #8
STR	LR, [SP, #0]
;rfm69_driver.c,31 :: 		WrPara |= 0x8000;                                          // Agrego el bit en 1 en el byte alto para escribir via SPI
LDRH	R0, [SP, #8]
ORR	R1, R0, #32768
UXTH	R1, R1
STRH	R1, [SP, #8]
;rfm69_driver.c,32 :: 		wAddr = WrPara >> 8 & 0xff;                                // Extraigo la Dirección de escritura de 1 Byte
LSRS	R0, R1, #8
UXTH	R0, R0
AND	R0, R0, #255
STRH	R0, [SP, #4]
;rfm69_driver.c,33 :: 		wData = WrPara & 0xff;                                     // Extraigo el Valor que escribiré
AND	R0, R1, #255
STRH	R0, [SP, #6]
;rfm69_driver.c,34 :: 		if( SPIPort == 2)                                                        // Si esta definido el SPI2 por el configuro el radio
LDRSH	R0, [SP, #12]
CMP	R0, #2
IT	NE
BNE	L_SPIWriteByte0
;rfm69_driver.c,36 :: 		CS_Radio_Select_bit = 0;                  		// Selecciono el periferico para usarlo
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;rfm69_driver.c,37 :: 		SPI2_Write(wAddr);                        		// Escibo la dirección donde quiero afectar el registro
LDRH	R0, [SP, #4]
BL	_SPI2_Write+0
;rfm69_driver.c,38 :: 		SPI2_Write(wData);                        		// Escribo el dato en la direccion que seleccione
LDRH	R0, [SP, #6]
BL	_SPI2_Write+0
;rfm69_driver.c,39 :: 		CS_Radio_Select_bit = 1;                  		// Deselecciono el periferico
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;rfm69_driver.c,41 :: 		}
L_SPIWriteByte0:
;rfm69_driver.c,43 :: 		}
L_end_SPIWriteByte:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _SPIWriteByte
_RFM69_Config:
;rfm69_driver.c,51 :: 		void RFM69_Config(void)
SUB	SP, SP, #8
STR	LR, [SP, #0]
;rfm69_driver.c,53 :: 		char i=0;
MOVS	R0, #0
STRB	R0, [SP, #4]
;rfm69_driver.c,54 :: 		for(i=0;i<3;i++)
MOVS	R0, #0
STRB	R0, [SP, #4]
L_RFM69_Config1:
LDRB	R0, [SP, #4]
CMP	R0, #3
IT	CS
BCS	L_RFM69_Config2
;rfm69_driver.c,56 :: 		SPIWriteByte(RF69FreqTbl[FreqSel][i],2);
MOVS	R0, #2
SXTH	R0, R0
PUSH	(R0)
MOVW	R0, #lo_addr(_FreqSel+0)
MOVT	R0, #hi_addr(_FreqSel+0)
LDRB	R1, [R0, #0]
MOVS	R0, #3
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF69FreqTbl+0)
MOVT	R0, #hi_addr(_RF69FreqTbl+0)
ADDS	R1, R0, R1
LDRB	R0, [SP, #8]
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
PUSH	(R0)
BL	_SPIWriteByte+0
ADD	SP, SP, #8
;rfm69_driver.c,54 :: 		for(i=0;i<3;i++)
LDRB	R0, [SP, #4]
ADDS	R0, R0, #1
STRB	R0, [SP, #4]
;rfm69_driver.c,57 :: 		}
IT	AL
BAL	L_RFM69_Config1
L_RFM69_Config2:
;rfm69_driver.c,58 :: 		i=0;
MOVS	R0, #0
STRB	R0, [SP, #4]
;rfm69_driver.c,59 :: 		for(i=0;i<21;i++)
MOVS	R0, #0
STRB	R0, [SP, #4]
L_RFM69_Config4:
LDRB	R0, [SP, #4]
CMP	R0, #21
IT	CS
BCS	L_RFM69_Config5
;rfm69_driver.c,61 :: 		SPIWriteByte(RF69ConfigTbl[i],2);
MOVS	R0, #2
SXTH	R0, R0
PUSH	(R0)
LDRB	R1, [SP, #8]
MOVW	R0, #lo_addr(_RF69ConfigTbl+0)
MOVT	R0, #hi_addr(_RF69ConfigTbl+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
PUSH	(R0)
BL	_SPIWriteByte+0
ADD	SP, SP, #8
;rfm69_driver.c,59 :: 		for(i=0;i<21;i++)
LDRB	R0, [SP, #4]
ADDS	R0, R0, #1
STRB	R0, [SP, #4]
;rfm69_driver.c,62 :: 		}
IT	AL
BAL	L_RFM69_Config4
L_RFM69_Config5:
;rfm69_driver.c,63 :: 		i=0;
MOVS	R0, #0
STRB	R0, [SP, #4]
;rfm69_driver.c,75 :: 		}
L_end_RFM69_Config:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _RFM69_Config
_Get_temperature_value:
;rfm69_driver.c,81 :: 		int Get_temperature_value(unsigned char addr)
SUB	SP, SP, #8
STR	LR, [SP, #0]
;rfm69_driver.c,83 :: 		char COURSE_TEMP_COEF = -90;
MVN	R0, #89
STRB	R0, [SP, #4]
;rfm69_driver.c,84 :: 		unsigned char REG_TEMP1 = 0x4E;
;rfm69_driver.c,85 :: 		unsigned char REG_TEMP2 = 0x4F;
;rfm69_driver.c,89 :: 		RFM69_Config();
BL	_RFM69_Config+0
;rfm69_driver.c,90 :: 		SPIWriteByte(0x4E08,2);
MOVS	R0, #2
SXTH	R0, R0
PUSH	(R0)
MOVW	R0, #19976
PUSH	(R0)
BL	_SPIWriteByte+0
ADD	SP, SP, #8
;rfm69_driver.c,91 :: 		SPIWriteByte(0x4F00,2);
MOVS	R0, #2
SXTH	R0, R0
PUSH	(R0)
MOVW	R0, #20224
PUSH	(R0)
BL	_SPIWriteByte+0
ADD	SP, SP, #8
;rfm69_driver.c,92 :: 		delay_ms(2); //for(SysTime=0;SysTime<10;);
MOVW	R7, #23999
MOVT	R7, #0
NOP
NOP
L_Get_temperature_value7:
SUBS	R7, R7, #1
BNE	L_Get_temperature_value7
NOP
NOP
NOP
;rfm69_driver.c,93 :: 		temp = (((SPIReadByte(addr)) * -1) + COURSE_TEMP_COEF) -31;
LDRB	R0, [SP, #8]
PUSH	(R0)
BL	_SPIReadByte+0
ADD	SP, SP, #4
MOVW	R1, #65535
SXTH	R1, R1
MULS	R1, R0, R1
SXTH	R1, R1
LDRB	R0, [SP, #4]
ADDS	R0, R1, R0
SXTH	R0, R0
SUBS	R0, #31
;rfm69_driver.c,95 :: 		return(temp);
UXTB	R0, R0
;rfm69_driver.c,96 :: 		}
L_end_Get_temperature_value:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _Get_temperature_value
_main:
;Radio_RFM69.c,6 :: 		void main() {
;Radio_RFM69.c,7 :: 		Hardware_Init();                               // Mando llamar a la funcion de inicio de hardware a emplear.
BL	_Hardware_Init+0
;Radio_RFM69.c,9 :: 		TypeID = 0x69;
MOVS	R1, #105
MOVW	R0, #lo_addr(_TypeID+0)
MOVT	R0, #hi_addr(_TypeID+0)
STRB	R1, [R0, #0]
;Radio_RFM69.c,10 :: 		FreqSel = 2;                      //433 Mhz
MOVS	R1, #2
MOVW	R0, #lo_addr(_FreqSel+0)
MOVT	R0, #hi_addr(_FreqSel+0)
STRB	R1, [R0, #0]
;Radio_RFM69.c,11 :: 		set_frame = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_set_frame+0)
MOVT	R0, #hi_addr(_set_frame+0)
STR	R1, [R0, #0]
;Radio_RFM69.c,12 :: 		rfm_br = 24;
MOVS	R1, #24
MOVW	R0, #lo_addr(_rfm_br+0)
MOVT	R0, #hi_addr(_rfm_br+0)
STRB	R1, [R0, #0]
;Radio_RFM69.c,13 :: 		rfm_pwr = 13;
MOVS	R1, #13
MOVW	R0, #lo_addr(_rfm_pwr+0)
MOVT	R0, #hi_addr(_rfm_pwr+0)
STRB	R1, [R0, #0]
;Radio_RFM69.c,14 :: 		rfm_fdev = 350;
MOVW	R1, #350
MOVW	R0, #lo_addr(_rfm_fdev+0)
MOVT	R0, #hi_addr(_rfm_fdev+0)
STRH	R1, [R0, #0]
;Radio_RFM69.c,15 :: 		RFM69_Config();
BL	_RFM69_Config+0
;Radio_RFM69.c,16 :: 		UART1_Write(Get_temperature_value(0x4F));
MOVS	R0, #79
PUSH	(R0)
BL	_Get_temperature_value+0
ADD	SP, SP, #4
UXTH	R0, R0
BL	_UART1_Write+0
;Radio_RFM69.c,21 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
