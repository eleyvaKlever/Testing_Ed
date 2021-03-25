/**************************************************************************************************
* Hardware 
**************************************************************************************************/
#ifndef Hardware_H
#define Hardware_H

sbit CS_Serial_Flash_bit                  at GPIOA_ODR.B4;                                         //Aqui defino el Pin NSS del SPI 1 para la Memoria
sbit CS_Radio_Select_bit                  at GPIOB_ODR.B12;                                        //Aqui defino el Pin NSS del SPI 2 para el Radio
sbit Pin_Reset_Tactil                     at GPIOC_ODR.B14;                                        //Aqui defino el Pin NSS del SPI para la Memoria
sbit Pin_Reset                            at GPIOC_ODR.B15;                                        //Aqui defino el Pin NSS del SPI para la Memoria
#define Pin_Reset_Tactil                  GPIOC_ODR._GPIO_PIN_14                                   // Pin de reser Tactil
#define Pin_Reset                         GPIOC_ODR._GPIO_PIN_15                                   //Aqui defino el Pin Reset para el STM32 forzado
#define Led1                              GPIOA_ODR._GPIO_PIN_0                                    //Salida de Activacion de LED1
#define Led2                              GPIOA_ODR._GPIO_PIN_1                                    //Salida de Activacion de LED2
#define Led3                              GPIOA_ODR._GPIO_PIN_2                                    //Salida de Activacion de LED3
#define Led4                              GPIOC_ODR._GPIO_PIN_13                                   //Salida de Activacion de LED4
#define Led5                              GPIOB_ODR._GPIO_PIN_5                                    //Salida de Activacion de LED5
#define Led6                              GPIOA_ODR._GPIO_PIN_12                                   //Salida de Activacion de LED6
#define Reley1                            GPIOB_ODR._GPIO_PIN_2                                    //Salida de Activacion de Reley 1
#define Reley2                            GPIOB_ODR._GPIO_PIN_10                                   //Salida de Activacion de Reley 2
#define Reley3                            GPIOB_ODR._GPIO_PIN_11                                   //Salida de Activacion de Reley 3
#define Pin_Sound                         GPIOB_ODR._GPIO_PIN_8                                    //Salida de Activacion de Sonido

void Hardware_Init(void)
{
GPIO_Config(&GPIOA_BASE, _GPIO_PINMASK_4, _GPIO_CFG_DIGITAL_OUTPUT);        // CS/NSS Serial Flash pin
GPIO_Config(&GPIOB_BASE, _GPIO_PINMASK_12, _GPIO_CFG_DIGITAL_OUTPUT);       // CS/NSS Radio pin

GPIO_Config(&GPIOC_BASE, _GPIO_PINMASK_14, _GPIO_CFG_DIGITAL_OUTPUT);       // Pin Reset Tactil
GPIO_Config(&GPIOC_BASE, _GPIO_PINMASK_15, _GPIO_CFG_DIGITAL_OUTPUT);       // Pin Reset MCU
GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_0);                          // LED_1
GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_1);                          // LED_2
GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_2);                          // LED_3
GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_12);                         // LED_4
GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_14);                         // LED_5
GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_15);                         // LED_6
GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_2);                          // Relay_1
GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_10);                         // Relay_2
GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_11);                         // Relay_3
GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_8);                          // Sound Buzzer

GPIO_Digital_Input(&GPIOB_BASE,  _GPIO_PINMASK_9);                          // B5 Interrupcíon Tactil
GPIOA_ODR.B0  = 0;
GPIOA_ODR.B1  = 0;
GPIOA_ODR.B3  = 0;
GPIOC_ODR.B14 = 0;
GPIOC_ODR.B15 = 0;

Sound_Init(&GPIOB_ODR, 8);                                                 // Salida de Audio Haptica

/**************************************************************************************************
* Inicializacion de puertos
**************************************************************************************************/
  GPIOA_ODR._GPIO_PIN_4 = 0;
  UART1_Init_Advanced(115200, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10);     // Uart para probar datos
  I2C1_Init_Advanced(400000, &_GPIO_MODULE_I2C1_PB67);                                    // I2C para Tactil
  SPI1_Init_Advanced(_SPI_FPCLK_DIV32, _SPI_MASTER  | _SPI_8_BIT |                        // SPI1 para Memoria Flash
                     _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION |
                     _SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1,
                     &_GPIO_MODULE_SPI1_PA567);

  ADC_Set_Input_Channel(_ADC_CHANNEL_8);                     // Choose ADC channel
  ADC1_Init();  
                                               // Init
  SPI2_Init_Advanced(_SPI_FPCLK_DIV32, _SPI_MASTER | _SPI_8_BIT |
                     _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION |
                     _SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1,
                     &_GPIO_MODULE_SPI2_PB13_14_15);
 
/**************************************************************************************************/
}

#endif