#line 1 "C:/Users/EdCrue/Desktop/Radio_RFM69/Radio_RFM69.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/include/built_in.h"
#line 1 "c:/users/edcrue/desktop/radio_rfm69/hardware.h"
#line 7 "c:/users/edcrue/desktop/radio_rfm69/hardware.h"
sbit CS_Serial_Flash_bit at GPIOA_ODR.B4;
sbit CS_Radio_Select_bit at GPIOB_ODR.B12;
sbit Pin_Reset_Tactil at GPIOC_ODR.B14;
sbit Pin_Reset at GPIOC_ODR.B15;
#line 24 "c:/users/edcrue/desktop/radio_rfm69/hardware.h"
void Hardware_Init(void)
{
GPIO_Config(&GPIOA_BASE, _GPIO_PINMASK_4, _GPIO_CFG_DIGITAL_OUTPUT);
GPIO_Config(&GPIOB_BASE, _GPIO_PINMASK_12, _GPIO_CFG_DIGITAL_OUTPUT);

GPIO_Config(&GPIOC_BASE, _GPIO_PINMASK_14, _GPIO_CFG_DIGITAL_OUTPUT);
GPIO_Config(&GPIOC_BASE, _GPIO_PINMASK_15, _GPIO_CFG_DIGITAL_OUTPUT);
GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_0);
GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_1);
GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_2);
GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_12);
GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_14);
GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_15);
GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_2);
GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_10);
GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_11);
GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_8);

GPIO_Digital_Input(&GPIOB_BASE, _GPIO_PINMASK_9);
GPIOA_ODR.B0 = 0;
GPIOA_ODR.B1 = 0;
GPIOA_ODR.B3 = 0;
GPIOC_ODR.B14 = 0;
GPIOC_ODR.B15 = 0;

Sound_Init(&GPIOB_ODR, 8);
#line 54 "c:/users/edcrue/desktop/radio_rfm69/hardware.h"
 GPIOA_ODR._GPIO_PIN_4 = 0;
 UART1_Init_Advanced(115200, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10);
 I2C1_Init_Advanced(400000, &_GPIO_MODULE_I2C1_PB67);
 SPI1_Init_Advanced(_SPI_FPCLK_DIV32, _SPI_MASTER | _SPI_8_BIT |
 _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION |
 _SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1,
 &_GPIO_MODULE_SPI1_PA567);

 ADC_Set_Input_Channel(_ADC_CHANNEL_8);
 ADC1_Init();

 SPI2_Init_Advanced(_SPI_FPCLK_DIV32, _SPI_MASTER | _SPI_8_BIT |
 _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION |
 _SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1,
 &_GPIO_MODULE_SPI2_PB13_14_15);


}
#line 1 "c:/users/edcrue/desktop/radio_rfm69/global_defs.h"



unsigned char TypeID;
unsigned char FreqSel;
bit set_frame;
unsigned char rfm_br;
unsigned char rfm_pwr;
unsigned int rfm_fdev;
unsigned char systime;
#line 1 "c:/users/edcrue/desktop/radio_rfm69/rfm69_driver.c"
#line 1 "c:/users/edcrue/desktop/radio_rfm69/rfm69_driver.h"









const unsigned short RF69FreqTbl[5][3] = {
 {0x0000, 0x0000, 0x0000},
 {0x074e, 0x08c0, 0x0900},
 {0x076c, 0x0880, 0x0900},
 {0x07d9, 0x0800, 0x0900},
 {0x07e4, 0x08c0, 0x0900},
 };

const unsigned short RF69ConfigTbl[21] = {

 0x0200,

 0x0502,
 0x0641,


 0x0334,
 0x0410,


 0x130F,
 0x1888,

 0x1949,

 0x2687,

 0x2C00,
 0x2D02,
 0x2E90,
 0x2FAA,
 0x302D,
 0x31D4,

 0x3700,
 0x3815,

 0x3C95,

 0x581B,

 0x6F30,

 0x0104
 };

const unsigned short RF69RxTable[5] = {
 0x119F,
 0x2544,
 0x5A55,
 0x5C70,
 0x0110
 };

const unsigned short RFM69TxTable[5] = {
 0x2504,
 0x119F,
 0x5A55,
 0x5C70,
 0x010C,
 };
const unsigned short RFM69ListenTable[6] = {
 0x0DE4,
 0x0E0A,
 0x0F0A,
 0x2A10,
 0x2B10,
 0x29A0

 };

const unsigned char RFM69Data[] = {"HopeRF RFM COBRFM69-S"};

unsigned char SPIReadByte(unsigned long address);
void SPIWriteByte(unsigned int WrPara, int SPIPort);
void RFM69_Config(void);
char Get_temperature_value(char addr);
#line 9 "c:/users/edcrue/desktop/radio_rfm69/rfm69_driver.c"
unsigned char SPIReadByte(unsigned long WrPara)
{
unsigned int wAddr, wData;
unsigned char temp;
 wAddr = WrPara >> 8 & 0xff;
 wData = WrPara & 0xff;

 CS_Radio_Select_bit = 0;

 SPI2_Write(wAddr);
 temp = SPI2_Read(0);
 CS_Radio_Select_bit = 1;
 return temp;
}
#line 28 "c:/users/edcrue/desktop/radio_rfm69/rfm69_driver.c"
void SPIWriteByte(unsigned int WrPara, int SPIPort)
{
 unsigned int wAddr, wData;
 WrPara |= 0x8000;
 wAddr = WrPara >> 8 & 0xff;
 wData = WrPara & 0xff;
 if( SPIPort == 2)
 {
 CS_Radio_Select_bit = 0;
 SPI2_Write(wAddr);
 SPI2_Write(wData);
 CS_Radio_Select_bit = 1;

 }

}
#line 51 "c:/users/edcrue/desktop/radio_rfm69/rfm69_driver.c"
void RFM69_Config(void)
{
 char i=0;
 for(i=0;i<3;i++)
 {
 SPIWriteByte(RF69FreqTbl[FreqSel][i],2);
 }
 i=0;
 for(i=0;i<21;i++)
 {
 SPIWriteByte(RF69ConfigTbl[i],2);
 }
i=0;
#line 75 "c:/users/edcrue/desktop/radio_rfm69/rfm69_driver.c"
}
#line 81 "c:/users/edcrue/desktop/radio_rfm69/rfm69_driver.c"
int Get_temperature_value(unsigned char addr)
{
 char COURSE_TEMP_COEF = -90;
 unsigned char REG_TEMP1 = 0x4E;
 unsigned char REG_TEMP2 = 0x4F;


 char temp;
 RFM69_Config();
 SPIWriteByte(0x4E08,2);
 SPIWriteByte(0x4F00,2);
 delay_ms(2);
 temp = (((SPIReadByte(addr)) * -1) + COURSE_TEMP_COEF) -31;

 return(temp);
}
#line 6 "C:/Users/EdCrue/Desktop/Radio_RFM69/Radio_RFM69.c"
void main() {
Hardware_Init();

 TypeID = 0x69;
 FreqSel = 2;
 set_frame = 0;
 rfm_br = 24;
 rfm_pwr = 13;
 rfm_fdev = 350;
 RFM69_Config();
 UART1_Write(Get_temperature_value(0x4F));




}
