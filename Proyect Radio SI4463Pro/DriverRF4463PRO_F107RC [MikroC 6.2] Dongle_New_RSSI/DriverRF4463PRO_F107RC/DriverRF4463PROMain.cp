#line 1 "C:/Users/Crow/OneDrive/Escritorio/Proyect Radio SI4463Pro/DriverRF4463PRO_F107RC _28_OR_NOV_2020/DriverRF4463PRO_F107RC/DriverRF4463PROMain.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/include/built_in.h"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/stm32f107rcdefs.h"
#line 15 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/stm32f107rcdefs.h"
typedef unsigned char U8;
typedef unsigned int U16;
typedef unsigned long U32;
typedef char S8;
typedef int S16;
typedef long S32;
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/driverspi.c"



volatile unsigned char ucSPI2ByteReceived = 0;
#line 17 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/driverspi.c"
void Int_SPI2() iv IVT_INT_SPI2 ics ICS_AUTO {

 if ( SPI2_SRbits.RXNE ) {
 ucSPI2ByteReceived = ( unsigned char )SPI2_DR;

  GPIOC_ODRbits.ODR7  = ~ GPIOC_ODRbits.ODR7 ;

 }
}






void vSPI2Init ( void ) {
 SPI2_Init_Advanced( _SPI_FPCLK_DIV8, _SPI_MASTER | _SPI_8_BIT | _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION | _SPI_MSB_FIRST |
 _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI2_PB13_14_15 );

 SPI2_CR2bits.RXNEIE = 1;

 NVIC_IntEnable( IVT_INT_SPI2 );
}
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/configrf4463pro.h"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/driverrf4463prodefs.c"
#line 56 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/driverrf4463prodefs.c"
const unsigned char RF_MODEM_MOD_TYPE_12[11][12] = {
 0x03, 0x00, 0x07, 0x00, 0x12, 0xC0, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x00,
 0x03, 0x00, 0x07, 0x00, 0x25, 0x80, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x00,
 0x03, 0x00, 0x07, 0x00, 0x4B, 0x00, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x00,
 0x03, 0x00, 0x07, 0x00, 0x96, 0x00, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x00,
 0x03, 0x00, 0x07, 0x01, 0x2C, 0x00, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x01,
 0x03, 0x00, 0x07, 0x01, 0x2C, 0x00, 0x08, 0x2D, 0xC6, 0xC0, 0x00, 0x01,
 0x03, 0x00, 0x07, 0x02, 0x58, 0x00, 0x08, 0x2D, 0xC6, 0xC0, 0x00, 0x01,
 0x03, 0x00, 0x07, 0x03, 0x84, 0x00, 0x08, 0x2D, 0xC6, 0xC0, 0x00, 0x01,
 0x03, 0x00, 0x07, 0x27, 0x10, 0x00, 0x01, 0xC9, 0xC3, 0x80, 0x00, 0x01,
 0x03, 0x00, 0x07, 0x4C, 0x4B, 0x40, 0x01, 0xC9, 0xC3, 0x80, 0x00, 0x1b,
 0x03, 0x00, 0x07, 0x00, 0x07, 0xD0, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x00
};

const unsigned char RF_MODEM_TX_RAMP_DELAY_8_433[11][8] = {
 0x01, 0x80, 0x08, 0x03, 0x80, 0x00, 0x70, 0x20,
 0x01, 0x80, 0x08, 0x03, 0x80, 0x00, 0x70, 0x20,
 0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x70, 0x20,
 0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x70, 0x20,
 0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x30, 0x10,
 0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x20, 0x10,
 0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x10, 0x10,
 0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x10, 0x20,
 0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x00, 0x30,
 0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x00, 0x30,
 0x01, 0x80, 0x08, 0x03, 0x80, 0x00, 0x72, 0x21
};

const unsigned char RF_MODEM_TX_RAMP_DELAY_8_850[ 11 ][ 8 ] = {
 0x01, 0x80, 0x08, 0x03, 0xC0, 0x00, 0x32, 0x20,
 0x01, 0x80, 0x08, 0x03, 0xC0, 0x00, 0x30, 0x20,
 0x01, 0x80, 0x08, 0x03, 0xC0, 0x00, 0x30, 0x20,

 0x01, 0x00, 0x08, 0x03, 0xC0, 0x00, 0x30, 0x20,

 0x01, 0x00, 0x08, 0x03, 0xC0, 0x00, 0x30, 0x20,

 0x01, 0x00, 0x08, 0x03, 0xC0, 0x00, 0x20, 0x10,

 0x01, 0x00, 0x08, 0x03, 0xC0, 0x00, 0x10, 0x10,

 0x01, 0x00, 0x08, 0x03, 0xC0, 0x00, 0x10, 0x20,
 0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x00, 0x30,
 0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x00, 0x30,
 0x01, 0x80, 0x08, 0x03, 0x80, 0x00, 0x72, 0x21
};

const unsigned char RF_MODEM_BCR_OSR_1_9_433[ 11 ][ 9 ] = {
 0x03, 0x0D, 0x00, 0xA7, 0xC6, 0x00, 0x54, 0x02, 0xC2,
 0x01, 0x87, 0x01, 0x4F, 0x8B, 0x00, 0xA8, 0x02, 0xC2,
 0x00, 0xC3, 0x02, 0x9F, 0x17, 0x02, 0x1A, 0x02, 0x00,
 0x00, 0x62, 0x05, 0x3E, 0x2D, 0x07, 0xFF, 0x02, 0x00,
 0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,
 0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,
 0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,
 0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,
 0x00, 0x75, 0x04, 0x5E, 0x7B, 0x05, 0x9a, 0x02, 0x00,
 0x00, 0x3C, 0x08, 0x88, 0x89, 0x07, 0xFF, 0x02, 0x00,
 0x03, 0xAA, 0x00, 0x8B, 0xCF, 0x00, 0x46, 0x02, 0xC2
};

const unsigned char RF_MODEM_BCR_OSR_1_9_850[ 11 ][ 9 ] = {

 0x03, 0x0D, 0x00, 0xA7, 0xC6, 0x00, 0x54, 0x02, 0xC2,
 0x03, 0x0D, 0x00, 0xA7, 0xC6, 0x00, 0x54, 0x02, 0xC2,
 0x01, 0x87, 0x01, 0x4F, 0x8B, 0x00, 0xA8, 0x02, 0xC2,
 0x00, 0xC3, 0x02, 0x9F, 0x17, 0x01, 0x93, 0x02, 0x00,
 0x00, 0x62, 0x05, 0x3E, 0x2D, 0x05, 0x04, 0x02, 0x00,
 0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,
 0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,
 0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,
 0x00, 0x75, 0x04, 0x5E, 0x7B, 0x05, 0x9a, 0x02, 0x00,
 0x00, 0x3C, 0x08, 0x88, 0x89, 0x07, 0xFF, 0x02, 0x00,
 0x03, 0xAA, 0x00, 0x8B, 0xCF, 0x00, 0x46, 0x02, 0xC2
};

const unsigned char RF_MODEM_AFC_GEAR_7_433[ 11 ][ 7 ] = {
 0x04, 0x36, 0x80, 0x03, 0x30, 0xAF, 0x80,
 0x04, 0x36, 0x80, 0x07, 0x14, 0xDD, 0x80,
 0x00, 0x12, 0x80, 0x2A, 0x04, 0x3A, 0xA0,
 0x00, 0x12, 0x80, 0x54, 0x02, 0x5A, 0xA0,
 0x00, 0x12, 0x80, 0xA8, 0x01, 0x68, 0xE0,
 0x00, 0x12, 0x81, 0x50, 0x01, 0x20, 0xE0,
 0x00, 0x12, 0x82, 0x9F, 0x01, 0x03, 0xE0,
 0x00, 0x23, 0x87, 0xDD, 0x00, 0x77, 0xE0,
 0x00, 0x23, 0x8F, 0xFF, 0x00, 0xc9, 0xE0,
 0x00, 0x23, 0x8F, 0xFF, 0x01, 0x23, 0xE0,
 0x04, 0x36, 0x80, 0x01, 0x50, 0x69, 0x80
};

const unsigned char RF_MODEM_AFC_GEAR_7_850[ 11 ][ 7 ] = {

 0x04, 0x36, 0x80, 0x01, 0x52, 0x30, 0x80,
 0x04, 0x36, 0x80, 0x03, 0x30, 0x7F, 0x80,
 0x04, 0x36, 0x80, 0x07, 0x17, 0x10, 0x80,
 0x00, 0x12, 0x80, 0x2A, 0x04, 0xB1, 0xA0,
 0x00, 0x12, 0x80, 0x54, 0x02, 0x9A, 0xA0,
 0x00, 0x12, 0x80, 0xA8, 0x01, 0x8F, 0xA0,
 0x00, 0x12, 0x81, 0x50, 0x01, 0x1F, 0xA0,
 0x00, 0x23, 0x83, 0xEF, 0x00, 0x84, 0xA0,
 0x00, 0x23, 0x8F, 0xFF, 0x00, 0xc9, 0xE0,
 0x00, 0x23, 0x8F, 0xFF, 0x01, 0x23, 0xE0,
 0x04, 0x36, 0x80, 0x01, 0x50, 0x69, 0x80
};

const unsigned char RF_MODEM_AGC_WINDOW_SIZE_9_433[ 11 ][ 9 ] = {
 0x11, 0xAB, 0xAB, 0x00, 0x1A, 0x14, 0x00, 0x00, 0x2B,
 0x11, 0x56, 0x56, 0x00, 0x1A, 0xA0, 0x00, 0x00, 0x2A,
 0x11, 0x2B, 0x2B, 0x00, 0x1A, 0x50, 0x00, 0x00, 0x29,
 0x11, 0x15, 0x15, 0x00, 0x1A, 0x28, 0x00, 0x00, 0x28,
 0x11, 0x0E, 0x0E, 0x00, 0x1A, 0x21, 0x55, 0x00, 0x28,
 0x11, 0x0E, 0x0E, 0x00, 0x1A, 0x10, 0xAB, 0x00, 0x28,
 0x11, 0x0E, 0x0E, 0x00, 0x1A, 0x08, 0x55, 0x00, 0x28,
 0x11, 0x0E, 0x0E, 0x00, 0x1A, 0x05, 0x8E, 0x00, 0x28,
 0x22, 0x0D, 0x0D, 0x00, 0x1A, 0x32, 0x00, 0x00, 0x28,
 0x22, 0x07, 0x07, 0x00, 0x1A, 0x19, 0x9a, 0x00, 0x27,
 0x11, 0xCD, 0xCD, 0x00, 0x1A, 0x30, 0x00, 0x00, 0x2B
};

const unsigned char RF_MODEM_AGC_WINDOW_SIZE_9_850[ 11 ][ 9 ] = {

 0x11, 0xAB, 0xAB, 0x00, 0x02, 0xFF, 0xFF, 0x00, 0x2B,
 0x11, 0xAB, 0xAB, 0x00, 0x02, 0xFF, 0xFF, 0x00, 0x2B,
 0x11, 0x56, 0x56, 0x00, 0x02, 0xD5, 0x55, 0x00, 0x2A,
 0x11, 0x2B, 0x2B, 0x00, 0x02, 0x6A, 0xAB, 0x00, 0x29,
 0x11, 0x15, 0x15, 0x00, 0x02, 0x42, 0xAB, 0x00, 0x28,
 0x11, 0x0E, 0x0E, 0x00, 0x02, 0x21, 0x55, 0x00, 0x28,
 0x11, 0x0E, 0x0E, 0x00, 0x02, 0x10, 0xAB, 0x00, 0x28,
 0x11, 0x0E, 0x0E, 0x00, 0x02, 0x10, 0xAB, 0x00, 0x28,
 0x22, 0x0D, 0x0D, 0x00, 0x1A, 0x32, 0x00, 0x00, 0x28,
 0x22, 0x07, 0x07, 0x00, 0x1A, 0x19, 0x9a, 0x00, 0x27,
 0x11, 0xCD, 0xCD, 0x00, 0x1A, 0x30, 0x00, 0x00, 0x2B
};

const unsigned char RF_MODEM_OOK_CNT1_11_433[ 11 ][ 11 ] = {
 0xA4, 0x02, 0xD6, 0x83, 0x00, 0xAD, 0x01, 0x80, 0xFF, 0x0C, 0x00,
 0xA4, 0x02, 0xD6, 0x83, 0x00, 0xAD, 0x01, 0x80, 0xFF, 0x0C, 0x00,
 0xA4, 0x03, 0xD6, 0x03, 0x00, 0xCC, 0x01, 0x80, 0xFF, 0x0C, 0x00,
 0xA4, 0x03, 0xD6, 0x03, 0x00, 0xCC, 0x01, 0x80, 0xFF, 0x0C, 0x00,
 0xA4, 0x03, 0xD6, 0x03, 0x01, 0x00, 0x01, 0x80, 0xFF, 0x0C, 0x00,
 0xA4, 0x03, 0xD6, 0x03, 0x00, 0x80, 0x01, 0x80, 0xFF, 0x0C, 0x00,
 0xA4, 0x03, 0xD6, 0x03, 0x00, 0x40, 0x01, 0x80, 0xFF, 0x0C, 0x00,
 0xA4, 0x03, 0xD6, 0x03, 0x00, 0x2B, 0x01, 0x80, 0xFF, 0x0C, 0x00,
 0xA4, 0x03, 0xD6, 0x03, 0x00, 0xd5, 0x01, 0x80, 0xFF, 0x0C, 0x00,
 0xA4, 0x03, 0xD6, 0x03, 0x00, 0xd5, 0x01, 0x80, 0xFF, 0x0C, 0x00,
 0xA4, 0x02, 0xD6, 0x81, 0x02, 0xB4, 0x01, 0x80, 0xFF, 0x0C, 0x00
};

const unsigned char RF_MODEM_OOK_CNT1_11_850[ 11 ][ 11 ] = {

 0xA4, 0x02, 0xD6, 0x81, 0x03, 0x9B, 0x01, 0x80, 0xFF, 0x0C, 0x02,
 0xA4, 0x02, 0xD6, 0x83, 0x00, 0xE7, 0x01, 0x80, 0xFF, 0x0C, 0x02,
 0xA4, 0x02, 0xD6, 0x83, 0x00, 0xE7, 0x01, 0x80, 0xFF, 0x0C, 0x02,
 0xA4, 0x03, 0xD6, 0x03, 0x01, 0x11, 0x01, 0x80, 0xFF, 0x0C, 0x02,
 0xA4, 0x03, 0xD6, 0x03, 0x01, 0x55, 0x01, 0x80, 0xFF, 0x0C, 0x02,
 0xA4, 0x03, 0xD6, 0x03, 0x01, 0x00, 0x01, 0x80, 0xFF, 0x0C, 0x02,
 0xA4, 0x03, 0xD6, 0x03, 0x00, 0x80, 0x01, 0x80, 0xFF, 0x0C, 0x02,
 0xA4, 0x03, 0xD6, 0x03, 0x00, 0x80, 0x01, 0x80, 0xFF, 0x0C, 0x02,
 0xA4, 0x03, 0xD6, 0x03, 0x00, 0xd5, 0x01, 0x80, 0xFF, 0x0C, 0x02,
 0xA4, 0x03, 0xD6, 0x03, 0x00, 0xd5, 0x01, 0x80, 0xFF, 0x0C, 0x02,
 0xA4, 0x02, 0xD6, 0x81, 0x02, 0xB4, 0x01, 0x80, 0xFF, 0x0C, 0x02
};

const unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433[ 11 ][ 12 ]= {
 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,
 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,
 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1, 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11,
 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,
 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1, 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11,
 0x7E, 0x64, 0x1B, 0xBA, 0x58, 0x0B, 0xDD, 0xCE, 0xD6, 0xE6, 0xF6, 0x00,
 0x5B, 0x47, 0x0F, 0xC0, 0x6D, 0x25, 0xF4, 0xDB, 0xD6, 0xDF, 0xEC, 0xF7,
 0x5B, 0x47, 0x0F, 0xC0, 0x6D, 0x25, 0xF4, 0xDB, 0xD6, 0xDF, 0xEC, 0xF7,
 0x39, 0x2B, 0x00, 0xC3, 0x7F, 0x3F, 0x0C, 0xEC, 0xDC, 0xDC, 0xE3, 0xED,
 0xA2, 0x81, 0x26, 0xAF, 0x3F, 0xEE, 0xC8, 0xC7, 0xDB, 0xF2, 0x02, 0x08,
 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1, 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11
};

const unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850[ 11 ][ 12 ] = {

 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,
 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,
 0xFF, 0xBA, 0x0F, 0x51, 0xCF, 0xA9, 0xC9, 0xFC, 0x1B, 0x1E, 0x0F, 0x01,
 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,
 0xFF, 0xBA, 0x0F, 0x51, 0xCF, 0xA9, 0xC9, 0xFC, 0x1B, 0x1E, 0x0F, 0x01,
 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,
 0x7E, 0x64, 0x1B, 0xBA, 0x58, 0x0B, 0xDD, 0xCE, 0xD6, 0xE6, 0xF6, 0x00,
 0x7E, 0x64, 0x1B, 0xBA, 0x58, 0x0B, 0xDD, 0xCE, 0xD6, 0xE6, 0xF6, 0x00,
 0x39, 0x2B, 0x00, 0xC3, 0x7F, 0x3F, 0x0C, 0xEC, 0xDC, 0xDC, 0xE3, 0xED,
 0xA2, 0x81, 0x26, 0xAF, 0x3F, 0xEE, 0xC8, 0xC7, 0xDB, 0xF2, 0x02, 0x08,
 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1, 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11
};

const unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433[ 11 ][ 12 ] = {
 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,
 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,
 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00, 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1,
 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,
 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00, 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1,
 0x03, 0x03, 0x15, 0xF0, 0x3F, 0x00, 0x7E, 0x64, 0x1B, 0xBA, 0x58, 0x0B,
 0xFE, 0x01, 0x15, 0xF0, 0xFF, 0x03, 0x5B, 0x47, 0x0F, 0xC0, 0x6D, 0x25,
 0xFE, 0x01, 0x15, 0xF0, 0xFF, 0x03, 0x5B, 0x47, 0x0F, 0xC0, 0x6D, 0x25,
 0xF6, 0xFD, 0x15, 0xC0, 0xFF, 0x0F, 0x39, 0x2B, 0x00, 0xC3, 0x7F, 0x3F,
 0x07, 0x03, 0x15, 0xFC, 0x0F, 0x00, 0xA2, 0x81, 0x26, 0xAF, 0x3F, 0xEE,
 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00, 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1
};

const unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850[ 11 ][ 12 ] = {

 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,
 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,
 0xFC, 0xFD, 0x15, 0xFF, 0x00, 0x0F, 0xFF, 0xBA, 0x0F, 0x51, 0xCF, 0xA9,
 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,
 0xFC, 0xFD, 0x15, 0xFF, 0x00, 0x0F, 0xFF, 0xBA, 0x0F, 0x51, 0xCF, 0xA9,
 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,
 0x03, 0x03, 0x15, 0xF0, 0x3F, 0x00, 0x7E, 0x64, 0x1B, 0xBA, 0x58, 0x0B,

 0xF6, 0xFD, 0x15, 0xC0, 0xFF, 0x0F, 0x39, 0x2B, 0x00, 0xC3, 0x7F, 0x3F,
 0x07, 0x03, 0x15, 0xFC, 0x0F, 0x00, 0xA2, 0x81, 0x26, 0xAF, 0x3F, 0xEE,
 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00, 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1
};

const unsigned char RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433[ 11 ][ 12 ] = {
 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,
 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,
 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11, 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00,
 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,
 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11, 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00,
 0xDD, 0xCE, 0xD6, 0xE6, 0xF6, 0x00, 0x03, 0x03, 0x15, 0xF0, 0x3F, 0x00,
 0xF4, 0xDB, 0xD6, 0xDF, 0xEC, 0xF7, 0xFE, 0x01, 0x15, 0xF0, 0xFF, 0x03,
 0xF4, 0xDB, 0xD6, 0xDF, 0xEC, 0xF7, 0xFE, 0x01, 0x15, 0xF0, 0xFF, 0x03,
 0x0C, 0xEC, 0xDC, 0xDC, 0xE3, 0xED, 0xF6, 0xFD, 0x15, 0xC0, 0xFF, 0x0F,
 0xC8, 0xC7, 0xDB, 0xF2, 0x02, 0x08, 0x07, 0x03, 0x15, 0xFC, 0x0F, 0x00,
 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11, 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00
};

const unsigned char RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850[ 11 ][ 12 ] = {

 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,
 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,
 0xC9, 0xFC, 0x1B, 0x1E, 0x0F, 0x01, 0xFC, 0xFD, 0x15, 0xFF, 0x00, 0x0F,
 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,
 0xC9, 0xFC, 0x1B, 0x1E, 0x0F, 0x01, 0xFC, 0xFD, 0x15, 0xFF, 0x00, 0x0F,
 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,
 0xDD, 0xCE, 0xD6, 0xE6, 0xF6, 0x00, 0x03, 0x03, 0x15, 0xF0, 0x3F, 0x00,
 0x03, 0x03, 0x15, 0xF0, 0x3F, 0x00, 0x7E, 0x64, 0x1B, 0xBA, 0x58, 0x0B,
 0x0C, 0xEC, 0xDC, 0xDC, 0xE3, 0xED, 0xF6, 0xFD, 0x15, 0xC0, 0xFF, 0x0F,
 0xC8, 0xC7, 0xDB, 0xF2, 0x02, 0x08, 0x07, 0x03, 0x15, 0xFC, 0x0F, 0x00,
 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11, 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00
};

const unsigned char RF_SYNTH_PFDCP_CPFF_7[ 11 ][ 7 ] = {
 0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,
 0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,
 0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,
 0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,
 0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,
 0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,
 0x34, 0x04, 0x0B, 0x04, 0x07, 0x70, 0x03,
 0x34, 0x04, 0x0B, 0x04, 0x07, 0x70, 0x03,
 0x01, 0x05, 0x0B, 0x05, 0x02, 0x00, 0x03,
 0x01, 0x05, 0x0B, 0x05, 0x02, 0x00, 0x03,
 0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03
};



const unsigned char RF_POWER_UP_data[] = {  0x02, 0x01, 0x00, 0x01, 0xC9, 0xC3, 0x80  };
const unsigned char RF_FRR_CTL_A_MODE_4_data[] = {  0x11, 0x02, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00  };
const unsigned char RF_MODEM_AGC_CONTROL_1_data[] = {  0x11, 0x20, 0x01, 0x35, 0xE2  };

unsigned char RF_MODEM_MOD_TYPE_12_data[ 16 ] = { 0x11, 0x20, 0x0C, 0x00 };
unsigned char RF_MODEM_TX_RAMP_DELAY_8_data[ 12 ] = { 0x11, 0x20, 0x08, 0x18 };
unsigned char RF_MODEM_BCR_OSR_1_9_data[ 13 ] = { 0x11, 0x20, 0x09, 0x22 };
unsigned char RF_MODEM_AFC_GEAR_7_data[ 13 ] = { 0x11, 0x20, 0x07, 0x2C };
unsigned char RF_MODEM_AGC_WINDOW_SIZE_9_data[ 13 ] = { 0x11, 0x20, 0x09, 0x38 };
unsigned char RF_MODEM_OOK_CNT1_11_data[ 15 ] = { 0x11, 0x20, 0x0B, 0x42 };
unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[ 16 ] = { 0x11, 0x21, 0x0C, 0x00 };
unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[ 16 ] = { 0x11, 0x21, 0x0C, 0x0C };
unsigned char RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[ 16 ] = { 0x11, 0x21, 0x0C, 0x18 };
unsigned char RF_SYNTH_PFDCP_CPFF_7_data[ 11 ] = { 0x11, 0x23, 0x07, 0x00 };

const unsigned char tx_test_aa_data[ 14 ] = { 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA };


const unsigned char tx_ph_data[  66  ] = {  0x01 , 0x01 , 0x01 , 0x01 ,'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','A','B','C','D','E','F','G','H',0x11,0xE2 };
typedef struct
{
 unsigned char reach_1s : 1;
 unsigned char is_tx : 1;
 unsigned char rf_reach_timeout : 1;


 unsigned char flash : 1;
 unsigned char key_valid : 1;

}FlagType;

FlagType Flag;

U16 count_1hz, rf_timeout;
unsigned char spi_read_buf[ 20 ];
unsigned char rx_buf[  66  ];




const unsigned char Tab_DispCode[ 17 ] = { 0x77, 0x24, 0x6B, 0x6D, 0x3C, 0x5D, 0x5F, 0x64, 0x7F, 0x7D, 0x7E, 0x1F, 0x53, 0x2F, 0x5B, 0x5A, 0x00};
unsigned char dis_ram[ 28 ] = { 00 };

unsigned char key_value;
unsigned char have_set;
unsigned char set;
unsigned char old_mode;
unsigned char mode;
unsigned char freq3;
unsigned char freq2;
unsigned char freq1;
unsigned char power;

unsigned char rate;

unsigned char cnt_10s;

unsigned long tx_cnt = 0,rx_cnt = 0;
unsigned char reset_mode;

unsigned char reach_15hz = 0,reach_flash = 0,reach_1s = 0;
unsigned char count_15hz,count_flash = 0,count_1s = 0,nirq_cnt = 0;

void spi_read(unsigned char data_length, unsigned char api_command );
void tx_data(void);
void SI4463_init(void);
void sysclk_cfg(void);
void port_init(void);
void timerx_init(void);
void delay_1ms(unsigned int delay_time);
unsigned char spi_byte(unsigned char ucData);
unsigned char check_cts(void);
void spi_write(unsigned char tx_length, unsigned char *p);
void spi_fast_read( unsigned char api_command);
void spi_write_fifo(void);
void spi_read_fifo(void);
void VRF4463SDNReset(void);
void clr_interrupt(void);
void fifo_reset(void);
void enable_tx_interrupt(void);
void enable_rx_interrupt(void);
void tx_start(void);
void rx_start(void);
void rx_init(void);
void tx_const_aa(void);
void rx_start_test(void);


void vRF4463GPIO_SET(unsigned char ucData);
void rf_standby(void);
void rf_init_freq(void);
void option_load(void);
void flash_copy(void);

void time_opt();
unsigned char scan_key(void);
void key_opt(unsigned char key);
void nop_10();

void full_lcd(void);
void clr_lcd(void);
void poweron_dis(void);
void dis_freq(void);
void dis_power(void);
void dis_rssi(void);
void dis_dr(void);
void dis_fd(void);
void dis_bw(void);
void dis_tx(void);
void dis_rx(void);
void dis_sign(void);
void dis_mode(void);

void wr_data(unsigned char addr,unsigned char loop);
void wr_cmd(unsigned int cmd);
void DATA_1(void);
void DATA_0(void);

void delay_10ms(void);
void delay_x10ms(unsigned int dx10ms);
void getRSSI();
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/driverrf4463pro.c"








static unsigned char ucRF4463IRQ = 0;


unsigned char ucRFTxEventPending = 0;

unsigned char pcRF4463TxBuffer[  66  ] = { 0x00 };
unsigned char pcRF4463RxBuffer[  66  ] = { 0x00 };



void vRF4463Init ( void );
void vRF4463GPIO_SET( unsigned char ucData );


void vRF4463ClearInterrupts ( void );




void vRF4463ISR() iv IVT_INT_EXTI15_10 ics ICS_AUTO{
 if( EXTI_PR.B12 ){
 EXTI_PR.B12 |= 1;
  GPIOC_ODRbits.ODR6  = 1;
 ucRF4463IRQ = 1;
 vRF4463ClearInterrupts();
 }
}






void vRF4463Init ( void ) {
 unsigned char app_command_buf[ 20 ], i;
 unsigned char cleanBuffer[ 20 ]={0x00};

 for ( i = 4; i < 16; i++ ) {
 RF_MODEM_MOD_TYPE_12_data[ i ] = RF_MODEM_MOD_TYPE_12[ rate ][ i - 4 ];
 }


 if ( freq3 < 8 ) {
 for ( i = 4; i < 12; i++ ) {
 RF_MODEM_TX_RAMP_DELAY_8_data[ i ] = RF_MODEM_TX_RAMP_DELAY_8_433[ rate ][ i - 4 ];
 }
 for ( i = 4; i < 11; i++ ) {
 RF_MODEM_AFC_GEAR_7_data[ i ] = RF_MODEM_AFC_GEAR_7_433[ rate ][ i - 4 ];
 }
 for ( i = 4; i < 15; i++ ) {
 RF_MODEM_OOK_CNT1_11_data[ i ] = RF_MODEM_OOK_CNT1_11_433[ rate ][ i - 4 ];
 }
 for ( i = 4; i < 16; i++ ) {
 RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433[ rate ][ i - 4 ];
 }
 for ( i = 4; i < 16; i++ ) {
 RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433[ rate ][ i - 4 ];
 }
 for ( i = 4; i < 16; i++ ) {
 RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433[ rate ][ i - 4 ];
 }
 for ( i = 4; i < 13; i++ ) {
 RF_MODEM_AGC_WINDOW_SIZE_9_data[ i ] = RF_MODEM_AGC_WINDOW_SIZE_9_433[ rate ][ i - 4 ];
 }
 for ( i = 4; i < 13; i++ ) {
 RF_MODEM_BCR_OSR_1_9_data[ i ] = RF_MODEM_BCR_OSR_1_9_433[ rate ][ i - 4 ];
 }
 }
 else {
 for ( i = 4; i < 12; i++ ) {
 RF_MODEM_TX_RAMP_DELAY_8_data[ i ] = RF_MODEM_TX_RAMP_DELAY_8_850[ rate ][ i - 4 ];
 }
 for ( i = 4; i < 11; i++ ) {
 RF_MODEM_AFC_GEAR_7_data[ i ] = RF_MODEM_AFC_GEAR_7_850[ rate ][ i - 4 ];
 }
 for ( i = 4; i < 15; i++ ) {
 RF_MODEM_OOK_CNT1_11_data[ i ] = RF_MODEM_OOK_CNT1_11_850[ rate ][ i - 4 ];
 }
 for ( i = 4; i < 16; i++ ) {
 RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850[ rate ][ i - 4 ];
 }
 for ( i = 4; i < 16; i++ ) {
 RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850[ rate ][ i - 4 ];
 }
 for ( i = 4; i < 16; i++ ) {
 RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850[ rate ][ i - 4 ];
 }
 for ( i = 4; i < 13; i++ ) {
 RF_MODEM_AGC_WINDOW_SIZE_9_data[ i ] = RF_MODEM_AGC_WINDOW_SIZE_9_850[ rate ][ i - 4 ];
 }
 for ( i = 4; i < 13; i++ ) {
 RF_MODEM_BCR_OSR_1_9_data[ i ] = RF_MODEM_BCR_OSR_1_9_850[ rate ][ i - 4 ];
 }
 }
 for ( i = 4; i < 11; i++ ) {
 RF_SYNTH_PFDCP_CPFF_7_data[ i ] = RF_SYNTH_PFDCP_CPFF_7[ rate ][ i - 4 ];
 }



 vRF4463GPIO_SET( mode );
 strncpy(app_command_buf,cleanBuffer,20);


 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x00;
 app_command_buf[ 2 ] = 0x01;
 app_command_buf[ 3 ] = 0x00;
 app_command_buf[ 4 ] = 98;
 spi_write( 5, app_command_buf );
 strncpy(app_command_buf,cleanBuffer,20);

 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x00;
 app_command_buf[ 2 ] = 0x01;
 app_command_buf[ 3 ] = 0x03;
 app_command_buf[ 4 ] = 0x40;
 spi_write( 5, app_command_buf );

 strncpy(app_command_buf,cleanBuffer,20);

 spi_write( 0x08, RF_FRR_CTL_A_MODE_4_data );
 strncpy(app_command_buf,cleanBuffer,20);

 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x10;
 app_command_buf[ 2 ] = 0x09;
 app_command_buf[ 3 ] = 0x00;

 if ( mode ==  2  ) {
 app_command_buf[ 4 ] = 0xff;
 }
 else {
 app_command_buf[ 4 ] = 0x08;
 }


 app_command_buf[ 5 ] = 0x14;
 app_command_buf[ 6 ] = 0x00;
 app_command_buf[ 7 ] = 0x0f;
 app_command_buf[ 8 ] = 0x31;
 app_command_buf[ 9 ] = 0x0;
 app_command_buf[ 10 ] = 0x00;
 app_command_buf[ 11 ] = 0x00;
 app_command_buf[ 12 ] = 0x00;
 spi_write(13, app_command_buf);
 strncpy(app_command_buf,cleanBuffer,20);


 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x11;
 app_command_buf[ 2 ] = 0x05;
 app_command_buf[ 3 ] = 0x00;
 app_command_buf[ 4 ] = 0x01;

 if ( mode ==  2  ) {
 app_command_buf[ 5 ] = 0x55;
 app_command_buf[ 6 ] = 0x55;
 }
 else {
 app_command_buf[ 5 ] = (  0x2DD4  >> 8 );
 app_command_buf[ 6 ] = (  0x2DD4  );
 }

 app_command_buf[ 7 ] = 0x00;
 app_command_buf[ 8 ] = 0x00;
 spi_write( 9, app_command_buf );
 strncpy(app_command_buf,cleanBuffer,20);


 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x12;
 app_command_buf[ 2 ] = 0x01;
 app_command_buf[ 3 ] = 0x00;
 app_command_buf[ 4 ] = 0x81;
 spi_write( 5, app_command_buf );
 strncpy(app_command_buf,cleanBuffer,20);


 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x12;
 app_command_buf[ 2 ] = 0x01;
 app_command_buf[ 3 ] = 0x06;
 app_command_buf[ 4 ] = 0x02;
 spi_write( 5, app_command_buf );
 strncpy(app_command_buf,cleanBuffer,20);


 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x12;
 app_command_buf[ 2 ] = 0x03;
 app_command_buf[ 3 ] = 0x08;
 app_command_buf[ 4 ] = 0x00;
 app_command_buf[ 5 ] = 0x00;
 app_command_buf[ 6 ] = 0x00;
 spi_write( 7, app_command_buf );
 strncpy(app_command_buf,cleanBuffer,20);


 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x12;
 app_command_buf[ 2 ] = 0x0c;
 app_command_buf[ 3 ] = 0x0d;
 app_command_buf[ 4 ] = 0x00;
 app_command_buf[ 5 ] =  66 ;
 app_command_buf[ 6 ] = 0x04;
 app_command_buf[ 7 ] = 0xaa;
 app_command_buf[ 8 ] = 0x00;
 app_command_buf[ 9 ] = 0x00;
 app_command_buf[ 10 ] = 0x00;
 app_command_buf[ 11 ] = 0x00;
 app_command_buf[ 12 ] = 0x00;
 app_command_buf[ 13 ] = 0x00;
 app_command_buf[ 14 ] = 0x00;
 app_command_buf[ 15 ] = 0x00;
 spi_write( 16, app_command_buf );
 strncpy(app_command_buf,cleanBuffer,20);


 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x12;
 app_command_buf[ 2 ] = 0x08;
 app_command_buf[ 3 ] = 0x19;
 app_command_buf[ 4 ] = 0x00;
 app_command_buf[ 5 ] = 0x00;
 app_command_buf[ 6 ] = 0x00;
 app_command_buf[ 7 ] = 0x00;
 app_command_buf[ 8 ] = 0x00;
 app_command_buf[ 9 ] = 0x00;
 app_command_buf[ 10 ] = 0x00;
 app_command_buf[ 11 ] = 0x00;
 spi_write( 12, app_command_buf );
 strncpy(app_command_buf,cleanBuffer,20);


 spi_write( 0x10, RF_MODEM_MOD_TYPE_12_data );
 strncpy(app_command_buf,cleanBuffer,20);


 app_command_buf[0] = 0x11;
 app_command_buf[1] = 0x20;
 app_command_buf[2] = 0x01;
 app_command_buf[3] = 0x0c;

 if ( freq3 < 8 ) {
 if ( rate >=  8  ) {
 app_command_buf[ 4 ] = 0x4f;
 }
 else if ( rate >=  4  ) {
 app_command_buf[ 4 ] = 0x5e;
 }
 else {
 app_command_buf[ 4 ] = 0xd2;
 }
 }
 else {
 if ( rate >=  7  ) {
 app_command_buf[ 4 ] = 0x69;
 }
 else if ( rate >=  4  ) {
 app_command_buf[ 4 ] = 0x5e;
 }
 else {
 app_command_buf[ 4 ] = 0x18;
 }
 }
 spi_write( 5, app_command_buf );
 strncpy(app_command_buf,cleanBuffer,20);


 spi_write( 0x0C, RF_MODEM_TX_RAMP_DELAY_8_data );
 spi_write( 0x0D, RF_MODEM_BCR_OSR_1_9_data );
 spi_write( 0x0B, RF_MODEM_AFC_GEAR_7_data );
 spi_write( 0x05, RF_MODEM_AGC_CONTROL_1_data );
 spi_write( 0x0D, RF_MODEM_AGC_WINDOW_SIZE_9_data );
 spi_write( 0x0F, RF_MODEM_OOK_CNT1_11_data );


 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x20;
 app_command_buf[ 2 ] = 0x01;
 app_command_buf[ 3 ] = 0x4C;
 app_command_buf[ 4 ] = 0x01;
 spi_write( 5, app_command_buf );

 strncpy(app_command_buf,cleanBuffer,20);
#line 314 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/driverrf4463pro.c"
 spi_write( 0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data );
 spi_write( 0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data );
 spi_write( 0x10, RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data );


 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x22;
 app_command_buf[ 2 ] = 0x04;
 app_command_buf[ 3 ] = 0x00;
 app_command_buf[ 4 ] = 0x08;
#line 350 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/driverrf4463pro.c"
 if ( power > 0 || power < 127 ) {
 app_command_buf[ 5 ] = power;
 }
 else
 {
 app_command_buf[ 5 ] = 127;
 }
 app_command_buf[ 6 ] = 0x00;



 if ( ( rate <=  7  )||( rate ==  10  ) ) {
 app_command_buf[ 7 ] = 0x3d;
 }
 else {
 app_command_buf[ 7 ] = 0x5d;
 }
 spi_write( 8, app_command_buf );

 strncpy(app_command_buf,cleanBuffer,20);

 spi_write( 0x0B , RF_SYNTH_PFDCP_CPFF_7_data );
 strncpy(app_command_buf,cleanBuffer,20);

 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x30;
 app_command_buf[ 2 ] = 0x0c;
 app_command_buf[ 3 ] = 0x00;
 app_command_buf[ 4 ] =  0x01 ;
 app_command_buf[ 5 ] = 0xff;
 app_command_buf[ 6 ] = 0x40;
 app_command_buf[ 7 ] =  0x01 ;
 app_command_buf[ 8 ] = 0xff;
 app_command_buf[ 9 ] = 0x01;
 app_command_buf[ 10 ] =  0x01 ;
 app_command_buf[ 11 ] = 0xff;;
 app_command_buf[ 12 ] = 0x02;;
 app_command_buf[ 13 ] =  0x01 ;
 app_command_buf[ 14 ] = 0xff;
 app_command_buf[ 15 ] = 0x03;
 spi_write( 16, app_command_buf );
 strncpy(app_command_buf,cleanBuffer,20);
 rf_init_freq();
}





void vRF4463GPIO_SET( unsigned char ucData ) {
 unsigned char ucAppCommandBuf[ 7 ];

 ucAppCommandBuf[0] = 0x13;

 switch ( ucData ) {
 case  0 :
 case  1 : ucAppCommandBuf[ 1 ] = 3;
 ucAppCommandBuf[ 2 ] = 2;
 break;

 case  2 : ucAppCommandBuf[ 1 ] = 3;
 ucAppCommandBuf[ 2 ] = 3;
 break;

 case  3 : ucAppCommandBuf[ 1 ] = 2;
 ucAppCommandBuf[ 2 ] = 20;
 break;

 case  4 : ucAppCommandBuf[ 1 ] = 2;
 ucAppCommandBuf[ 2 ] = 2;
 break;
 }

 ucAppCommandBuf[ 3 ] = 0x21;
 ucAppCommandBuf[ 4 ] = 0x20;
 ucAppCommandBuf[ 5 ] = 0x27;
 ucAppCommandBuf[ 6 ] = 0x0b;
 spi_write( 7, ucAppCommandBuf );
}




void vRF4463FifoReset( void ) {
 unsigned char p[2];

 p[ 0 ] =  0x15 ;
 p[ 1 ] = 0x03;
 spi_write( 2, p );
}





void vRF4463ClearInterrupts( void ) {
 unsigned char p[ 4 ];

 p[ 0 ] =  0x20 ;
 p[ 1 ] = 0;
 p[ 2 ] = 0;
 p[ 3 ] = 0;
 spi_write( 4, p );
 spi_read( 9,  0x20  );
}

 void vRF4463PartInfo( void ) {
 unsigned char p[ 9 ];

 p[ 0 ] =  0x01 ;



 spi_write( 1, p );
 spi_read( 9,  0x01  );
 }




void vRF4463EnableRxInterrupt( void ) {
 unsigned char p[ 7 ];

 p[ 0 ] = 0x11;
 p[ 1 ] = 0x01;
 p[ 2 ] = 0x03;
 p[ 3 ] = 0x00;
 p[ 4 ] = 0x03;
 p[ 5 ] = 0x18;
 p[ 6 ] = 0x00;
 spi_write( 0x07, p );
}




void vRF4463EnableTxInterrupt( void ) {
 unsigned char p[ 6 ];

 p[ 0 ] = 0x11;
 p[ 1 ] = 0x01;
 p[ 2 ] = 0x02;
 p[ 3 ] = 0x00;
 p[ 4 ] = 0x01;
 p[ 5 ] = 0x20;
 spi_write( 0x06, p );
}




void vRF4463RfStandby( void ) {
 unsigned char p[ 2 ];

 p[ 0 ] =  0x34  ;
 p[ 1 ] = 0x01 ;
 spi_write( 2, p );
}




void vRF4463TxStart( void ) {
 unsigned char p[ 5 ];

 p[ 0 ] =  0x31  ;
 p[ 1 ] =  1 ;
 p[ 2 ] = 0x30;
 p[ 3 ] = 0;
 p[ 4 ] = 0;
 spi_write( 5, p );
}




void vRF4463RxStart( void ) {
 unsigned char p[ 8 ];

 p[ 0 ] =  0x32  ;
 p[ 1 ] =  1 ;
 p[ 2 ] = 0x00;
 p[ 3 ] = 0;
 p[ 4 ] = 0;
 p[ 5 ] = 0;


 p[ 6 ] = 0x08;
 p[ 7 ] = 0x08;
 spi_write( 8, p );
}




void vRF4463RxStartTest( void ) {
 unsigned char p[ 8 ];

  GPIOC_ODRbits.ODR7  = 1;

 p[ 0 ] =  0x32 ;
 p[ 1 ] =  1 ;
 p[ 2 ] = 0x00;
 p[ 3 ] = 0;

 p[ 4 ] = 0;
 p[ 5 ] = 0;


 p[ 6 ] = 0x08;
 p[ 7 ] = 0x08;
 spi_write( 8, p );
}




void vRF4463RxInit( void ) {
 Flag.is_tx = 0;
 vRF4463FifoReset();
 vRF4463EnableRxInterrupt();
 vRF4463ClearInterrupts();

 if ( mode ==  3  ) {
 vRF4463RxStartTest();
 }
 else {
 vRF4463RxStart();
 }
}




void vRF4463TxData( void ) {
 unsigned char i;

 ucRF4463IRQ = 0;

 Flag.is_tx = 1;



 vRF4463FifoReset();
 spi_write_fifo();
 vRF4463EnableTxInterrupt();
 vRF4463ClearInterrupts();
 vRF4463TxStart();
 rf_timeout = 0;

 Flag.rf_reach_timeout = 0;

 if ( ucRF4463IRQ ) {
 UART1_Write_Text( "[ UART1 ] TX INT\r\n" );
 }


 while (  GPIOC_IDRbits.IDR12  ) {


 if ( Flag.rf_reach_timeout ) {
 VRF4463SDNReset();
 vRF4463Init();
 break;
 }
 }

 tx_cnt++;

 vRF4463RxInit();
}




void vRF4463TxCont( void ) {
 unsigned char i;

  GPIOC_ODRbits.ODR6  = 1;
 vRF4463FifoReset();
 spi_write_fifo();
 vRF4463EnableTxInterrupt();
 vRF4463ClearInterrupts();
 vRF4463TxStart();
 rf_timeout = 0;
 Flag.rf_reach_timeout = 0;

 ucRF4463IRQ = 0;


 while(  GPIOC_IDRbits.IDR12  ) {







 }
}




void rf_init_freq ( void ) {
 unsigned char ucOUTDIV, ucDIV, ucVCO, ucINTE, ucBAND;
 unsigned char ucFD_2, ucFD_1, ucFD_0, ucFRAC_2, ucFRAC_1, ucFRAC_0;
 unsigned long ulFRAC, ulData, ulFrequency;
 unsigned char app_command_buf[ 20 ];

 ulFrequency = ( freq3 * 100) + ( freq2 * 10) + freq1;

 ulFrequency = ( ulFrequency * 10000);

 if ( ulFrequency >= 7600000 ) {
 ucOUTDIV = 4;
 ucBAND = 0;
 ucVCO = 0xFF;
 }


 else if ( ulFrequency >= 5460000 ) {
 ucOUTDIV = 6;
 ucBAND = 1;
 ucVCO = 0xFE;
 }


 else if ( ulFrequency >= 3850000 ) {
 ucOUTDIV = 8;
 ucBAND = 2;
 ucVCO = 0xFE;
 }


 else if ( ulFrequency >= 2730000 ) {
 ucOUTDIV = 12;
 ucBAND = 3;
 ucVCO = 0xFD;
 }


 else if ( ulFrequency >= 1940000 ) {
 ucOUTDIV = 16;
 ucBAND = 4;
 ucVCO = 0xFC;
 }


 else {
 ucOUTDIV = 24;
 ucBAND = 5;
 ucVCO = 0xFA;
 }

 ucDIV = ucOUTDIV / 2;

 ulData = ( ulFrequency * ucDIV ) / 3;
 ucINTE = ( ulData / 100000) - 1;
 ulFRAC = ( ulData - ( ucINTE + 1 ) * 100000 ) * 16384 / 3125;
 ulFRAC = ulFRAC + 0x80000;

 ucFRAC_0 = ulFRAC;
 ulFRAC >>= 8;
 ucFRAC_1 = ulFRAC;
 ulFRAC >>= 8;
 ucFRAC_2 = ulFRAC;



 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x20;
 app_command_buf[ 2 ] = 0x01;
 app_command_buf[ 3 ] = 0x51;
 app_command_buf[ 4 ] = 0x08 | ucBAND;
 spi_write( 5, app_command_buf );

 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x40;
 app_command_buf[ 2 ] = 0x08;
 app_command_buf[ 3 ] = 0x00;
 app_command_buf[ 4 ] = ucINTE;
 app_command_buf[ 5 ] = ucFRAC_2;
 app_command_buf[ 6 ] = ucFRAC_1;
 app_command_buf[ 7 ] = ucFRAC_0;
 app_command_buf[ 8 ] =  0x22 ;
 app_command_buf[ 9 ] =  0x22 ;
 app_command_buf[ 10 ] = 0x20;
 app_command_buf[ 11 ] = ucVCO;
 spi_write( 12, app_command_buf );

}
#line 761 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/driverrf4463pro.c"
unsigned char ucRf4463SPIByte( unsigned char ucData ) {


 ucSPI2ByteReceived = 0;

 SPI2_DR = ucData;







 while ( !SPI2_SRbits.TXE );

 while ( SPI2_SRbits.BSY );


 return ( ucSPI2ByteReceived );
}




void spi_write( unsigned char tx_length, unsigned char *p ) {
 unsigned char i,j;

 i = 0;
 while ( i != 0xFF ) {
 i = check_cts();
 }


  GPIOB_ODRbits.ODR12  = 0;

 for ( i = 0; i < tx_length; i++ ) {
 j = *( p + i );
 ucRf4463SPIByte( j );
 }

  GPIOB_ODRbits.ODR12  = 1;
}




unsigned char check_cts( void ) {
 unsigned char i;

  GPIOB_ODRbits.ODR12  = 1;

  GPIOB_ODRbits.ODR12  = 0;
 ucRf4463SPIByte( 0x44 );
 i = ucRf4463SPIByte( 0 );
  GPIOB_ODRbits.ODR12  = 1;
 return ( i );
}




void spi_read( unsigned char data_length, unsigned char api_command ) {
 unsigned char i;
 unsigned char p[ 1 ];

 p[ 0 ] = api_command;
 i = 0;
 while ( i != 0xFF ) {
 i = check_cts();
 }

 spi_write( 1, p );

 i = 0;
 while ( i != 0xFF ) {
 i = check_cts();
 }

  GPIOB_ODRbits.ODR12  = 1;

  GPIOB_ODRbits.ODR12  = 0;
 ucRf4463SPIByte( 0x44 );
 for ( i = 0; i < data_length; i++ ) {
 spi_read_buf[ i ] = ucRf4463SPIByte( 0x00 );
 Delay_ms(10);
 }
  GPIOB_ODRbits.ODR12  = 1;
}




void spi_fast_read( unsigned char api_command ) {
 unsigned char i,p[1];

 p[0] = api_command;
 i = 0;
 while ( i != 0xFF ) {
 i = check_cts();
 }

  GPIOB_ODRbits.ODR12  = 1;

  GPIOB_ODRbits.ODR12  = 0;
 ucRf4463SPIByte( api_command );
 for ( i = 0; i < 4; i++ ) {
 spi_read_buf[ i ] = ucRf4463SPIByte( 0xFF );
 }
  GPIOB_ODRbits.ODR12  = 1;
}




void spi_write_fifo( void ) {
 unsigned char i;

 i = 0;
 while ( i != 0xFF ) {
 i = check_cts();
 }

  GPIOB_ODRbits.ODR12  = 1;

  GPIOB_ODRbits.ODR12  = 0;
 ucRf4463SPIByte(  0x66  );

 if ( mode ==  2 ) {
 for ( i = 0; i <  66 ; i++ ) {
 ucRf4463SPIByte( tx_test_aa_data[ i ] );
 }
 }
 else {
 for ( i = 0; i <  66 ; i++ ) {
 ucRf4463SPIByte( tx_ph_data[ i ] );
 }
 }
  GPIOB_ODRbits.ODR12  = 1;
}




void spi_read_fifo( void ) {
 unsigned char i;

 i = 0;
 while ( i != 0xFF ) {
 i = check_cts();
 }

  GPIOB_ODRbits.ODR12  = 1;

  GPIOB_ODRbits.ODR12  = 0;
 ucRf4463SPIByte(  0x77  );
 for ( i = 0; i <  66 ; i++ ) {
 rx_buf[ i ] = ucRf4463SPIByte( 0xFF );
 }
  GPIOB_ODRbits.ODR12  = 1;
}




void VRF4463SDNReset( void ) {
 unsigned char i;

  GPIOB_ODRbits.ODR11  = 1;
 Delay_ms( 6 );
  GPIOB_ODRbits.ODR11  = 0;
 Delay_ms( 10 );

  GPIOB_ODRbits.ODR12  = 1;

  GPIOB_ODRbits.ODR12  = 0;
 for ( i = 0; i < 7; i++ ) {
 ucRf4463SPIByte( RF_POWER_UP_data[ i ] );
 }
  GPIOB_ODRbits.ODR12  = 1;


}




void vRf4463RSSI(){
 int intRSSI;
 unsigned char rssi;
 U8 pcRSSI[ 9 ] = {0};
 U8 pcBuffer[ 4 ] = {0};
 static U16 intRFLastRSSI = 0;
#line 983 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/driverrf4463pro.c"
 pcBuffer[ 0 ] = 0x11;
 pcBuffer[ 1 ] = 0x20;
 pcBuffer[ 2 ] = 0x01;
 pcBuffer[ 3 ] = 0x4E;
 pcBuffer[ 4 ] = 0x40;
 spi_write( 5, pcBuffer );



 pcBuffer[ 0 ] = 0x12;
 pcBuffer[ 1 ] = 0x22;
 pcBuffer[ 2 ] = 0x4E;
 spi_write( 3, pcBuffer );
 spi_read( 9, pcRSSI );


 rssi = ((pcRSSI[4] / 2) -64) -70;
 UART1_Write_Text("\r\n");
 ShortToStr(rssi, pcRSSI);
 UART1_Write_Text("[ RSSI ] = ");
 UART1_Write_Text(pcRSSI);
 UART1_Write_Text(" dBm\r\n");
}
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/utils.c"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/utils.h"
#line 49 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/utils.h"
unsigned char ucASCIIToByte( unsigned char * pcASCIIBuffer );
#line 61 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/utils.h"
void vASCIIToHex( unsigned char *pcHexConvertBuffer, unsigned char *pcASCIIConvertBuffer, unsigned char ucConversionLength );
#line 73 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/utils.h"
void vHexToASCII( unsigned char *pcASCIIConvertBuffer, unsigned char *pcHexConvertBuffer, unsigned char ucConversionLength );
#line 85 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/utils.h"
void vBufferSetToZero( unsigned char * pcBufferToClean, unsigned int uslength );
#line 97 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/utils.h"
void vBufferSetTo255( unsigned char * pcBufferToClean, unsigned int uslength );
#line 109 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/utils.h"
void vBufferSetToValue( unsigned char * pcBufferToClean, unsigned char ucValue, unsigned int uslength );
#line 121 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/utils.h"
void vSerializeUUID( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer );
#line 133 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/utils.h"
void vSerializeMACAddress( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer );
#line 145 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/utils.h"
void vSerializeIPAddress( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer );
#line 25 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/utils.c"
const unsigned char pcHexChar[16] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};

unsigned char ucMSBNibble = 0;
unsigned char ucLSBNibble = 0;
#line 41 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/utils.c"
unsigned char ucASCIIToByte( unsigned char * pcASCIIBuffer ){
 ucMSBNibble = 0;
 ucLSBNibble = 0;

 ucMSBNibble = ( pcASCIIBuffer[ 0 ] - 0x30 );
 if( ucMSBNibble > 9 ){
 ucMSBNibble -= 7;
 }

 ucLSBNibble = ( pcASCIIBuffer[ 1 ] - 0x30 );
 if( ucLSBNibble > 9 ){
 ucLSBNibble -= 7;
 }

 return ( ucMSBNibble << 4 | ucLSBNibble );
}
#line 61 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/utils.c"
void vASCIIToHex( unsigned char *pcHexConvertBuffer, unsigned char *pcASCIIConvertBuffer, unsigned char ucConversionLength ){
 unsigned char ucASCIICounter = 0;

 for( ucASCIICounter = 0; ucASCIICounter < ucConversionLength; ucASCIICounter++ ){
 ucMSBNibble = 0;
 ucLSBNibble = 0;

 ucMSBNibble = ( pcASCIIConvertBuffer[ ucASCIICounter * 2 ] - 0x30 );
 if( ucMSBNibble > 9 ){
 ucMSBNibble -= 7;
 }

 ucLSBNibble = ( pcASCIIConvertBuffer[ ( ucASCIICounter * 2 ) + 1 ] - 0x30 );
 if( ucLSBNibble > 9 ){
 ucLSBNibble -= 7;
 }

 pcHexConvertBuffer[ ucASCIICounter ] = ( ( ucMSBNibble << 4 ) | ucLSBNibble );
 }
}
#line 85 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/utils.c"
void vHexToASCII( unsigned char *pcASCIIConvertBuffer, unsigned char *pcHexConvertBuffer, unsigned char ucConversionLength ){
 unsigned char ucHexConvCounter = 0;

 for( ucHexConvCounter = 0; ucHexConvCounter < ucConversionLength; ucHexConvCounter++ ){
 pcASCIIConvertBuffer[ ucHexConvCounter * 2 ] = pcHexChar[ pcHexConvertBuffer[ ucHexConvCounter ] >> 4 ];
 pcASCIIConvertBuffer[ ( ucHexConvCounter * 2 ) + 1 ] = pcHexChar[ ( pcHexConvertBuffer[ ucHexConvCounter ] & 0x0F ) ];
 }
}
#line 97 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/utils.c"
void vBufferSetToZero( unsigned char * pcBufferToClean, unsigned int uslength ){
 unsigned int usPosition = 0;

 for( usPosition = 0; usPosition < uslength; usPosition++ ){
 pcBufferToClean[ usPosition ] = 0x00;
 }
}
#line 108 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/utils.c"
void vBufferSetTo255( unsigned char * pcBufferToClean, unsigned int uslength ){
 unsigned int usPosition = 0;

 for( usPosition = 0; usPosition < uslength; usPosition++ ){
 pcBufferToClean[ usPosition ] = 0xFF;
 }
}
#line 119 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/utils.c"
void vBufferSetToValue( unsigned char * pcBufferToClean, unsigned char ucValue, unsigned int uslength ){
 unsigned int usPosition = 0;

 for( usPosition = 0; usPosition < uslength; usPosition++ ){
 pcBufferToClean[ usPosition ] = ucValue;
 }
}
#line 130 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/utils.c"
void vSerializeUUID( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer ){
 unsigned char ucCounter = 0;

 for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
 pcTextConvertBuffer[ ucCounter * 2 ] = pcHexChar[ pcHexConvertBuffer[ ucCounter ] >> 4 ];
 pcTextConvertBuffer[ ( ucCounter * 2 ) + 1 ] = pcHexChar[ pcHexConvertBuffer[ ucCounter ] & 0x0F ];
 }
}
#line 142 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/utils.c"
void vSerializeMACAddress( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer ){
 unsigned int usCounter = 0;
 unsigned char pcDeviceMAC[ 12 ];

 vHexToASCII( pcDeviceMAC, pcHexConvertBuffer, 6 );

 for( usCounter = 0; usCounter < 6; usCounter++ ){
 pcTextConvertBuffer[ usCounter * 3 ] = pcDeviceMAC[ usCounter * 2 ];
 pcTextConvertBuffer[ ( usCounter * 3 ) + 1 ] = pcDeviceMAC[ ( usCounter * 2 ) + 1 ];
 if( usCounter != 5 ){
 pcTextConvertBuffer[ ( usCounter * 3 ) + 2 ] = ':';
 }
 }
 pcTextConvertBuffer[ 18 ] = '\0';
}
#line 161 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/utils.c"
void vSerializeIPAddress( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer ){
 unsigned char ucCounter = 0;
 unsigned char pcConvertText[ 7 ];

 memset( pcTextConvertBuffer, '\0', sizeof( pcTextConvertBuffer ) );

 for( ucCounter = 0; ucCounter < 4; ucCounter++ ){

 ByteToStr( pcHexConvertBuffer[ ucCounter ], pcConvertText );

 strcat( pcTextConvertBuffer, Ltrim( pcConvertText ) );

 if( ucCounter != 3 ){
 strcat( pcTextConvertBuffer, "." );
 }
 }
}
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/uarthandler.c"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/uarthandler.h"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/debug.h"
#line 80 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/debug.h"
 void vDebugInit();
 void vDebugPrint();
#line 25 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/uarthandler.h"
enum{
 UART_CMD_WHO = 0,
 UART_CMD_SEND,
 UART_CMD_END,
 UART_CMD_STAGE,
 UART_CMD_REBOOT,
 UART_CMD_PING,
 UART_CMD_TEST,
 UART_CMD_REMOVE,
 UART_CMD_CHANNEL,
 UART_CMD_GET,
 UART_CMD_STATUS,
 UART_CMD_INFO,
 UART_CMD_DEVICE_INFO,
 UART_CMD_SEARCH,
 UART_CMD_OVERRIDE,
 UART_CMD_RESET_FTY,
 UART_CMD_OVERRIDE_SET,
 UART_CMD_DISCOVER,
 UART_CMD_FIND,
 UART_CMD_UNBLOCK,
 UART_CMD_SET_TX_POWER,
 UART_CMD_SEND_RF_MESSAGE,
 UART_Commands
} UARTCommandsTable;
#line 54 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/uarthandler.h"
void vUARTTxInit();

void vUARTRxInit();

void vUARTRxMessage();

void vUARTCommands( unsigned char * pcInBuffer );
#line 26 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/uarthandler.c"
unsigned char pcTxUARTBuffer[  2048  ];
unsigned char pcRxUARTBuffer[  2048  ];

unsigned char pcTxRF4463AuxBuffer[  66  ];
unsigned char pcRxRF4463AuxBuffer[  66  ];

unsigned int usBufferCounter = 0;
unsigned int usPosition = 0;
unsigned int usUARTMessageLength = 0;

unsigned char ucTempByteUART = 0;
#line 41 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/uarthandler.c"
unsigned char ucUARTDataReady = 0;

unsigned char * pcUARTCommand[] = {
 "IFACE",
 "SEND",
 "CLOSE",
 "GET_STAGE",
 "REINIT",
 "PING",
 "TEST",
 "REMOVE",
 "CHANNEL",
 "GET_CHANNEL",
 "STATUS",
 "INFO",
 "DEVICEINFO",
 "SEARCH",
 "OVERRIDE",
 "RESET_FTY",
 "SET_FTY",
 "DISCOVER",
 "FIND",
 "SEND_UNBLOCK",
 "SETPOWER",
 "RF"
};
#line 78 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/uarthandler.c"
void vUARTISR() iv IVT_INT_USART1 ics ICS_AUTO{
  GPIOC_ODRbits.ODR8  =~  GPIOC_ODRbits.ODR8 ;

 if( USART1_SRbits.RXNE == 1 ){
 ucTempByteUART = USART1_DR;
 if( ucTempByteUART == '\n' ){
 pcRxUARTBuffer[ usUARTMessageLength++ ] = ucTempByteUART;
 ucUARTDataReady = 1;
 ucTempByteUART = 0;
  GPIOC_ODRbits.ODR8  =  0 ;
 }
 else{
 pcRxUARTBuffer[ usUARTMessageLength++ ] = ucTempByteUART;
 ucTempByteUART = 0;
 }
 }
 if( USART1_SRbits.ORE == 1 ){
  ;
 ucTempByteUART = USART1_SR;
 ucTempByteUART = USART1_DR;
  GPIOC_ODRbits.ODR8  =  0 ;
 }
}
#line 108 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/uarthandler.c"
void vUARTTxInit(){
 UART1_Init_Advanced( 921600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10 );
}
#line 115 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/uarthandler.c"
void vUARTRxInit(){
 USART1_CR1bits.RE = 1;
 USART1_CR1bits.RXNEIE = 1;

 NVIC_IntEnable( IVT_INT_USART1 );
}
#line 125 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/uarthandler.c"
void vUARTRxMessage(){
 unsigned int usCounter = 0;






  ;

 vUARTCommands( pcRxUARTBuffer );

 memset( pcRxUARTBuffer, '\0', sizeof( pcRxUARTBuffer ) );
 usUARTMessageLength = 0;
}
#line 144 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/uarthandler.c"
void vUARTCommands( unsigned char * pcInBuffer ){
 unsigned char ucCommandCounter = 0;
 unsigned char ucCounter = 0;
 unsigned char ucPosition = 0;
 unsigned char pcTempBuffer[ 64 ];

 unsigned char pcTempTxBuffer[  66  ];

 unsigned int usTempData = 0;
 unsigned char ucDeviceModel = 0;

 unsigned int usTempChannel = 0;
 unsigned int usTempNetwork = 0;
 unsigned char ucIgnoreNetwork = 0;

 unsigned int usTempNode = 0;
 unsigned int usTempDestination = 0;
 unsigned int usTempTable = 0;
 unsigned int usTempCommand = 0;
 unsigned char ucTempBufferLength = 0;

 for( ucCommandCounter = 0; ucCommandCounter < UART_Commands; ucCommandCounter++ ){
 if( strstr( pcInBuffer, pcUARTCommand[ ucCommandCounter ] ) ){
 switch( ucCommandCounter ){
 case UART_CMD_WHO:
 UART1_Write_Text( "DONGLE\r\n" );
 Sound_Play( 1000, 100 );
 Delay_ms( 30 );
 Sound_Play( 1000, 100 );
 break;
 case UART_CMD_SEND:
  ;


 memset( pcTempBuffer, '\0', 50 );

 ucPosition = 5;
 for( ucCounter = 0; ucCounter < usUARTMessageLength; ucCounter++ ){
 if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
 break;
 }
 pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
 }


 break;
 case UART_CMD_END:
  ;




 ucPosition = 6;

 for( ucCounter = 0; ucCounter < usUARTMessageLength; ucCounter++ ){
 if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
 break;
 }

 }



 break;
 case UART_CMD_STAGE:
  ;






 break;
 case UART_CMD_REBOOT:
  ;

  GPIOC_ODRbits.ODR8  = 0;
  GPIOC_ODRbits.ODR7  = 0;
  GPIOC_ODRbits.ODR6  = 1;

 Delay_ms( 1000 );
 SystemReset();
 break;
 case UART_CMD_PING:
  ;


 break;
 case UART_CMD_TEST:
  ;
 memset( pcTempBuffer, '\0', 64 );

 ucPosition = 5;

 for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
 pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];

 }









 break;
 case UART_CMD_REMOVE:
  ;

 memset( pcTempBuffer, '\0', 64 );

 ucPosition = 7;

 for( ucCounter = 0; ; ucCounter++ ){
 if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
 break;
 }
 pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
 }

 usTempData = atoi( pcTempBuffer );


 break;
 case UART_CMD_CHANNEL:
  ;
 memset( pcTempBuffer, '\0', 64 );

 ucPosition = 8;



 for( ucCounter = 0; ; ucCounter++ ){
 if( pcInBuffer[ ucPosition ] == ',' ){
 ucPosition++;
 break;
 }
 if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
 ucIgnoreNetwork = 1;
 break;
 }
 pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
 }

 usTempChannel = atoi( pcTempBuffer );

 if( ucIgnoreNetwork == 0 ){
 for( ucCounter = 0; ; ucCounter++ ){
 if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
 break;
 }
 pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
 }
 usTempNetwork = atoi( pcTempBuffer );



 }
 else{


 }

 break;
 case UART_CMD_INFO:
  ;
#line 337 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/uarthandler.c"
 break;
 case UART_CMD_SEARCH:
  ;


 break;
 case UART_CMD_OVERRIDE:
  ;
 break;
 case UART_CMD_RESET_FTY:
  ;
 break;
 case UART_CMD_OVERRIDE_SET:
  ;
 break;
 case UART_CMD_DISCOVER:
  ;


 case UART_CMD_FIND:
  ;


 break;
 case UART_CMD_UNBLOCK:
 break;
 case UART_CMD_SET_TX_POWER:
  ;
 memset( pcTempBuffer, '\0', 20 );
 ucPosition = 9;
 for( ucCounter = 0; ; ucCounter++ ){
 if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
 break;
 }
 pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
 }
 usTempData = atoi( pcTempBuffer );

 break;
 case UART_CMD_SEND_RF_MESSAGE:
  ;
 ucPosition = strlen( pcUARTCommand[ UART_CMD_SEND_RF_MESSAGE ] ) + 1;
  ;
#line 383 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/uarthandler.c"
 vBufferSetToZero( pcTempBuffer, 50 );
 for( ucCounter = 0; ; ucCounter++ ){
 if( pcInBuffer[ ucPosition ] == '|' ){
 ucPosition++;
 break;
 }
 if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
  ;
 return;
 }
 pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
 }
 usTempDestination = atoi( pcTempBuffer );
  ;
#line 400 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/uarthandler.c"
 vBufferSetToZero( pcTempBuffer, 50 );
 for( ucCounter = 0; ; ucCounter++ ){
 if( pcInBuffer[ ucPosition ] == '|' ){
 ucPosition++;
 break;
 }
 if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
  ;
 return;
 }
 pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
 }
 usTempNode = atoi( pcTempBuffer );
  ;
#line 417 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/uarthandler.c"
 vBufferSetToZero( pcTempBuffer, 50 );
 for( ucCounter = 0; ; ucCounter++ ){
 if( pcInBuffer[ ucPosition ] == '|' ){
 ucPosition++;
 break;
 }
 if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
  ;
 return;
 }
 pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
 }
 usTempTable = atoi( pcTempBuffer );
  ;
#line 434 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/uarthandler.c"
 vBufferSetToZero( pcTempBuffer, 50 );
 for( ucCounter = 0; ; ucCounter++ ){
 if( pcInBuffer[ ucPosition ] == '|' ){
 ucPosition++;
 break;
 }
 if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
  ;
 break;
 }
 pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
 }
 usTempCommand = atoi( pcTempBuffer );
  ;
#line 451 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/uarthandler.c"
 vBufferSetToZero( pcTempBuffer, 50 );
 for( ucTempBufferLength = 0; ; ucTempBufferLength++ ){
 if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' || pcInBuffer[ ucPosition ] == '\0' ){
  ;
 break;
 }
 pcTempBuffer[ ucTempBufferLength ] = pcInBuffer[ ucPosition++ ];
 }
#line 464 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/uarthandler.c"
 break;
 default:
  ;
 break;
 }
 }
 }
}
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/debug.c"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/debug.h"
#line 83 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/debug.c"
 void vDebugInit();
#line 93 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_f107rc _28_or_nov_2020/driverrf4463pro_f107rc/debug.c"
 void vDebugPrint();
#line 17 "C:/Users/Crow/OneDrive/Escritorio/Proyect Radio SI4463Pro/DriverRF4463PRO_F107RC _28_OR_NOV_2020/DriverRF4463PRO_F107RC/DriverRF4463PROMain.c"
int intRSSI;
float rssi;
char pcRSSI[ 9 ] = {0};
char pcBuffer[ 5 ] = {0};
char Value[4];
float iVal;

void RFISR() iv IVT_INT_EXTI15_10 ics ICS_AUTO{
 if( EXTI_PR.B12 ){
 EXTI_PR.B12 |= 1;
  GPIOC_ODRbits.ODR6  = 1;
 ucRF4463IRQ = 1;
 UART1_Write_Text( "RF int\r\n" );

 }
}

void Timer2_interrupt() iv IVT_INT_TIM2 {
 TIM2_SR.UIF = 0;
 Flag.rf_reach_timeout = 1;
 Flag.reach_1s = 1;
}


void vRF4463MainCommandProcessor ( ) {

}





void InitTimer2(){

 RCC_APB1ENR.TIM2EN = 1;
 TIM2_CR1.CEN = 0;
 TIM2_PSC = 449;
 TIM2_ARR = 63999;
#line 115 "C:/Users/Crow/OneDrive/Escritorio/Proyect Radio SI4463Pro/DriverRF4463PRO_F107RC _28_OR_NOV_2020/DriverRF4463PRO_F107RC/DriverRF4463PROMain.c"
 NVIC_IntEnable(IVT_INT_TIM2);
 TIM2_DIER.UIE = 1;
 TIM2_CR1.CEN = 1;
}



void main() {

 unsigned char i, j;
 int chksum, chechsumLo, chechsumHi;
 float iVal;

 Delay_ms( 2000 );



 GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_6 );
 GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_7 );
 GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_8 );
#line 140 "C:/Users/Crow/OneDrive/Escritorio/Proyect Radio SI4463Pro/DriverRF4463PRO_F107RC _28_OR_NOV_2020/DriverRF4463PRO_F107RC/DriverRF4463PROMain.c"
 GPIO_Digital_Input( &GPIOC_BASE, _GPIO_PINMASK_12 );

 GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_12 );
 GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_11 );
 GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_11 );
 GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_10 );
#line 150 "C:/Users/Crow/OneDrive/Escritorio/Proyect Radio SI4463Pro/DriverRF4463PRO_F107RC _28_OR_NOV_2020/DriverRF4463PRO_F107RC/DriverRF4463PROMain.c"
 RCC_APB2ENRbits.AFIOEN = 1;
#line 154 "C:/Users/Crow/OneDrive/Escritorio/Proyect Radio SI4463Pro/DriverRF4463PRO_F107RC _28_OR_NOV_2020/DriverRF4463PRO_F107RC/DriverRF4463PROMain.c"
 AFIO_EXTICR4 |= 0x0002;
#line 158 "C:/Users/Crow/OneDrive/Escritorio/Proyect Radio SI4463Pro/DriverRF4463PRO_F107RC _28_OR_NOV_2020/DriverRF4463PRO_F107RC/DriverRF4463PROMain.c"
 EXTI_IMR.B12 |= 1;
 EXTI_FTSR.B12 |= 1;

 GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_7 );
 Sound_Init( &GPIOB_ODR, 7 );
 Sound_Play( 1000, 100 );

  GPIOB_ODRbits.ODR12  = 1;

  GPIOC_ODRbits.ODR6  = 1;
  GPIOC_ODRbits.ODR7  = 1;
  GPIOC_ODRbits.ODR8  = 1;

 Delay_ms( 100 );

  GPIOC_ODRbits.ODR6  = 0;
  GPIOC_ODRbits.ODR7  = 1;
  GPIOC_ODRbits.ODR8  = 0;

 InitTimer2();


 vUARTTxInit();
 vSPI2Init();




 freq3 = 9;
 freq2 = 1;
 freq1 = 5;


 power = 127;

 rate =  2 ;

 mode =  1 ;

 reset_mode = 0;



 VRF4463SDNReset();
 vRF4463Init();
 vRF4463ClearInterrupts();
 vRF4463PartInfo ();

  GPIOC_ODRbits.ODR7  = 0;
  GPIOC_ODRbits.ODR8  = 0;

 UART1_Write_Text( "RF Radio ready" );

 while ( 1 ) {

 if ( ucRF4463IRQ ) {
 ucRF4463IRQ = 0;
 spi_read_fifo();
 vRF4463FifoReset();
 UART1_Write_Text( spi_read_buf );
 }


 if ( mode ==  0  ) {
 vRF4463TxData();
 }

 else if ( mode ==  1  ) {
 vRF4463RxInit();
 }

 if ( mode ==  2  ) {
 vRF4463TxCont();
 while ( 1 ) {
 if ( ! GPIOC_IDRbits.IDR12  ) {
 vRF4463TxCont();
 }
 }
 }

 if ( mode ==  3  ) {
 vRF4463RxInit ();
 while ( 1 ) {

 }
 }

 if ( reset_mode == 0 ) {

 while ( 1 ) {

 if ( Flag.reach_1s ) {
 Flag.reach_1s = 0;
 if ( mode ==  0  ) {
 vRF4463TxData();
 }

 }


 {
 if ( ! GPIOC_IDRbits.IDR12  ) {
 spi_read(9,0x22);
 iVal = ( float ) spi_read_buf[3];
 rssi = ((iVal / 2) - 64) -70;
 vRF4463ClearInterrupts();
 if ( ( spi_read_buf[ 4 ] & 0x08) == 0 ) {
 spi_read_fifo();
 vRF4463FifoReset();

 chksum = 0;
 for ( i = 4; i <  66  - 1; i++ )
 chksum += rx_buf[ i ];


 UART1_Write_Text("[ MENSAGGE ] = ");
 UART1_Write_Text( rx_buf );
 UART1_Write_Text("\r\n");
  GPIOC_ODRbits.ODR7  ^= 1;
 rx_cnt++;
 getRSSI();


 vRF4463RxInit();
 }
 else {

 UART1_Write_Text("[ CRC ] Fail\r\n" );
 VRF4463SDNReset();
 vRF4463Init();
 vRF4463RxInit();
 }
 }
 }
 }
 }
 }
}void getRSSI()
{
 ShortToStr(rssi,Value );
 UART1_Write_Text("[ RSSI ] = ");
 UART1_Write_Text( Value );
 UART1_Write_Text(" dBm\r\n");
}
