#line 1 "C:/Users/Crow/OneDrive/Escritorio/Proyect Radio SI4463Pro/DriverRF4463PRO_G071KB [ MikroC 6.2 ]4 DIC 2020/DriverRF4463PRO_G071KB [ MikroC 6.2 ]/DriverRF4463PROMain.c"
#line 22 "C:/Users/Crow/OneDrive/Escritorio/Proyect Radio SI4463Pro/DriverRF4463PRO_G071KB [ MikroC 6.2 ]4 DIC 2020/DriverRF4463PRO_G071KB [ MikroC 6.2 ]/DriverRF4463PROMain.c"
void vRF4463MainCommandProcessor ( unsigned char *ucBuffer );
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/stm32defs.h"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/driverspi.c"



volatile unsigned char ucSPI1ByteReceived = 0;
volatile unsigned char ucSPI2ByteReceived = 0;
volatile unsigned char ucSPI3ByteReceived = 0;
#line 49 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/driverspi.c"
 void Int_SPI1() iv IVT_INT_SPI1 ics ICS_AUTO {

 if ( SPI1_SRbits.RXNE ) {
 ucSPI1ByteReceived = ( unsigned char )SPI1_DR;

  GPIOC_ODRbits.ODR6  = ~ GPIOC_ODRbits.ODR6 ;
 }
 }






 void DMACh1_interrupt() iv IVT_INT_DMA_Channel1 ics ICS_AUTO {

 if ( DMA_ISRbits.TEIF3 ) {
 DMA_IFCRbits.CTEIF3 = 1;
 while ( SPI1_SRbits.BSY );
 while ( !SPI1_SRbits.TXE );
 DMA_CCR1bits.EN = 0;
 }

 if ( DMA_ISRbits.TCIF1 ) {
 DMA_IFCRbits.CGIF0 = 1;
 while ( SPI1_SRbits.BSY );
 while ( !SPI1_SRbits.TXE );
 DMA_CCR1bits.EN = 0;
 }

 if ( DMA_ISRbits.GIF0 ) {
 DMA_IFCRbits.CGIF0 = 1;
 while ( SPI1_SRbits.BSY );
 while ( !SPI1_SRbits.TXE );
 DMA_CCR1bits.EN = 0;
 }
 }
#line 115 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/driverspi.c"
char vRF4463SpiBufferTX ( unsigned long *ucBuffer, unsigned long ulSize ) {

 while ( DMA_CCR1bits.EN || !SPI1_SRbits.TXE );

 SPI1_CR1bits.SPE = 1;

 if ( SPI1_CR1bits.SPE && SPI1_SRbits.TXE && ulSize > 0 ) {
 DMA_CCR1bits.EN = 0;
 while ( DMA_CCR1bits.EN );

 DMA_CMAR1 = ( unsigned long ) ucBuffer;
 DMA_CNDTR1 = ulSize;
 DMA_CCR1bits.EN = 1;

 while ( DMA_CNDTR1 > 1 );

 while ( SPI1_SRbits.FTLVL != 0 );

 while ( SPI1_SRbits.BSY );
 while ( !SPI1_SRbits.TXE );

 DMA_CCR1bits.EN = 0;

 return 1;
 }
 return 0;
}

void vSPI1Init( void ) {

 RCC_IOPENRbits.IOPAEN = 1;
 GPIOA_MODERbits.MODER5 = 2;
 GPIOA_OTYPERbits.OT5 = 0;
 GPIOA_OSPEEDRbits.OSPEEDR5 = 0;
 GPIOA_PUPDRbits.PUPDR5 = 0;
 GPIOA_AFRLbits.AFSEL5 = 0;

 GPIOA_MODERbits.MODER6 = 2;
 GPIOA_OTYPERbits.OT6 = 0;
 GPIOA_OSPEEDRbits.OSPEEDR6 = 0;
 GPIOA_PUPDRbits.PUPDR6 = 0;
 GPIOA_AFRLbits.AFSEL6 = 0;

 GPIOA_MODERbits.MODER7 = 2;
 GPIOA_OTYPERbits.OT7 = 0;
 GPIOA_OSPEEDRbits.OSPEEDR7 = 0;
 GPIOA_PUPDRbits.PUPDR7 = 0;
 GPIOA_AFRLbits.AFSEL7 = 0;


 RCC_APBENR2bits.SPI1EN = 1;

 SPI1_CR1bits.CPHA = 0;
 SPI1_CR1bits.CPOL = 0;
 SPI1_CR1bits.LSBFIRST = 0;
 SPI1_CR1bits.SSM = 1;
 SPI1_CR1bits.SSI = 1;
 SPI1_CR1bits.MSTR = 1;
 SPI1_CR1bits.CRCNEXT = 0;

 SPI1_CR2bits.FRF = 0;
 SPI1_CR2bits.DS = 7;
 SPI1_CR2bits.SSOE = 0;
 SPI1_CR2bits.NSSP = 1;
 SPI1_CR2bits.FRXTH = 1;
 SPI1_CR2bits.TXDMAEN = 1;



 RCC_AHBENRbits.DMAEN = 1;

 DMA_CCR1bits.EN = 0;
 while ( DMA_CCR1bits.EN );

 PL0_bit = 1;
 PL1_bit = 1;
 DMA_CCR1bits.MINC = 1;
 DMA_CCR1bits.DIR_ = 1;
 DMA_CCR1bits.TEIE = 1;
 DMA_CCR1bits.TCIE = 1;

 DMA_CPAR1 = ( unsigned long ) &SPI1_DR;

 NVIC_IntEnable( IVT_INT_DMA_Channel1 );

 DMAMUX_C0CRbits.DMAREQ_ID = 17;

 SPI1_CR2bits.RXNEIE = 1;

 NVIC_IntEnable( IVT_INT_SPI1 );
}
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/configrf4463pro.h"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/driverrf4463prodefs.c"
#line 52 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/driverrf4463prodefs.c"
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
const unsigned char tx_ph_data[ 14 ] = { 's', 'w', 'w', 'x', 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x6D };

typedef struct
{
 unsigned char reach_1s : 1;
 unsigned char is_tx : 1;
 unsigned char rf_reach_timeout : 1;


 unsigned char flash : 1;
 unsigned char key_valid : 1;

}FlagType;

FlagType Flag;

unsigned int count_1hz, rf_timeout;
unsigned char spi_read_buf[ 20 ];
unsigned char rx_buf[ 25 ];




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
unsigned char rssi;
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
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/driverrf4463pro.c"








static unsigned char ucRF4463IRQ = 0;


unsigned char ucRFTxEventPending = 0;

unsigned char pcRF4463TxBuffer[  64  ] = { 0x00 };
unsigned char pcRF4463RxBuffer[  64  ] = { 0x00 };



void vRF4463Init ( void );
void vRF4463GPIO_SET( unsigned char ucData );


void vRF4463ClearInterrupts ( void );
#line 39 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/driverrf4463pro.c"
void vRF4463ISR() iv IVT_INT_EXTI2_3 ics ICS_AUTO{
 if ( EXTI_FPR1bits.FPIF2 ){
 EXTI_FPR1bits.FPIF2 = 1;


 vRF4463ClearInterrupts();
 ucRF4463IRQ = 1;
 }
}





void vRF4463Init ( void ) {
 unsigned char app_command_buf[ 20 ], i;

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


 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x00;
 app_command_buf[ 2 ] = 0x01;
 app_command_buf[ 3 ] = 0x00;
 app_command_buf[ 4 ] = 98;
 spi_write( 5, app_command_buf );


 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x00;
 app_command_buf[ 2 ] = 0x01;
 app_command_buf[ 3 ] = 0x03;
 app_command_buf[ 4 ] = 0x40;
 spi_write( 5, app_command_buf );



 spi_write( 0x08, RF_FRR_CTL_A_MODE_4_data );


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
 app_command_buf[ 5 ] = 0x2d;
 app_command_buf[ 6 ] = 0xd4;
 }

 app_command_buf[ 7 ] = 0x00;
 app_command_buf[ 8 ] = 0x00;
 spi_write( 9, app_command_buf );


 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x12;
 app_command_buf[ 2 ] = 0x01;
 app_command_buf[ 3 ] = 0x00;
 app_command_buf[ 4 ] = 0x81;
 spi_write( 5, app_command_buf );


 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x12;
 app_command_buf[ 2 ] = 0x01;
 app_command_buf[ 3 ] = 0x06;
 app_command_buf[ 4 ] = 0x02;
 spi_write( 5, app_command_buf );


 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x12;
 app_command_buf[ 2 ] = 0x03;
 app_command_buf[ 3 ] = 0x08;
 app_command_buf[ 4 ] = 0x00;
 app_command_buf[ 5 ] = 0x00;
 app_command_buf[ 6 ] = 0x00;
 spi_write( 7, app_command_buf );


 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x12;
 app_command_buf[ 2 ] = 0x0c;
 app_command_buf[ 3 ] = 0x0d;
 app_command_buf[ 4 ] = 0x00;
 app_command_buf[ 5 ] =  14 ;
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


 spi_write( 0x10, RF_MODEM_MOD_TYPE_12_data );


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


 spi_write( 0x0C, RF_MODEM_TX_RAMP_DELAY_8_data );
 spi_write( 0x0D, RF_MODEM_BCR_OSR_1_9_data );
 spi_write( 0x0B, RF_MODEM_AFC_GEAR_7_data );
 spi_write( 0x05, RF_MODEM_AGC_CONTROL_1_data );
 spi_write( 0x0D, RF_MODEM_AGC_WINDOW_SIZE_9_data );
 spi_write( 0x0F, RF_MODEM_OOK_CNT1_11_data );


 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x20;
 app_command_buf[ 2 ] = 0x01;
 app_command_buf[ 3 ] = 0x4e;

 if ( rate ==  10  ) {
 app_command_buf[ 4 ] = 0x3a;
 }
 else {
 app_command_buf[ 4 ] = 0x40;
 }
 spi_write( 5, app_command_buf );


 spi_write( 0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data );
 spi_write( 0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data );
 spi_write( 0x10, RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data );


 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x22;
 app_command_buf[ 2 ] = 0x04;
 app_command_buf[ 3 ] = 0x00;
 app_command_buf[ 4 ] = 0x08;
#line 336 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/driverrf4463pro.c"
 if ( power > 0 || power < 127 ) {
 app_command_buf[ 5 ] = power;
 }
 else {
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



 spi_write( 0x0B , RF_SYNTH_PFDCP_CPFF_7_data );


 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x30;
 app_command_buf[ 2 ] = 0x0c;
 app_command_buf[ 3 ] = 0x00;
 app_command_buf[ 4 ] = 's';
 app_command_buf[ 5 ] = 0xFF;
 app_command_buf[ 6 ] = 0x40;
 app_command_buf[ 7 ] = 'w';
 app_command_buf[ 8 ] = 0xFF;
 app_command_buf[ 9 ] = 0x01;
 app_command_buf[ 10 ] = 'w';
 app_command_buf[ 11 ] = 0xFF;;
 app_command_buf[ 12 ] = 0x02;;
 app_command_buf[ 13 ] = 'x';
 app_command_buf[ 14 ] = 0xFF;
 app_command_buf[ 15 ] = 0x03;
 spi_write( 16, app_command_buf );

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
 p[ 1 ] =  0 ;
 p[ 2 ] = 0x30;
 p[ 3 ] = 0;
 p[ 4 ] = 0;
 spi_write( 5, p );
}




void vRF4463RxStart( void ) {
 unsigned char p[ 8 ];

 p[ 0 ] =  0x32  ;
 p[ 1 ] =  0 ;
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

  GPIOC_ODRbits.ODR6  = 1;

 p[ 0 ] =  0x32 ;
 p[ 1 ] =  0 ;
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
  GPIOC_ODRbits.ODR6  ^= 1;
 Delay_ms( 30 );
  GPIOC_ODRbits.ODR6  ^= 1;
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


 while (  GPIOA_IDRbits.IDR2  ) {


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


 while(  GPIOA_IDRbits.IDR2  ) {







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
#line 737 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/driverrf4463pro.c"
 spi_write( 12, app_command_buf );
}
#line 758 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/driverrf4463pro.c"
unsigned char ucRf4463SPIByte( unsigned char ucData ) {
#line 797 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/driverrf4463pro.c"
 ucSPI1ByteReceived = 0;

 vRF4463SpiBufferTX ( &ucData, 1 );

 while ( SPI1_SRbits.RXNE );





 return ( ucSPI1ByteReceived );

}




void spi_write( unsigned char tx_length, unsigned char *p ) {
 unsigned char i,j;

 i = 0;
 while ( i != 0xFF ) {
 i = check_cts();
 }

  GPIOA_ODRbits.ODR3  = 0;

 for ( i = 0; i < tx_length; i++ ) {
 j = *( p + i );
 ucRf4463SPIByte( j );
 }

  GPIOA_ODRbits.ODR3  = 1;
}




unsigned char check_cts( void ) {
 unsigned char i;

  GPIOA_ODRbits.ODR3  = 1;
  GPIOA_ODRbits.ODR3  = 0;
 ucRf4463SPIByte( 0x44 );
 i = ucRf4463SPIByte( 0 );
  GPIOA_ODRbits.ODR3  = 1;
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

  GPIOA_ODRbits.ODR3  = 1;
  GPIOA_ODRbits.ODR3  = 0;
 ucRf4463SPIByte( 0x44 );
 for ( i = 0; i < data_length; i++ ) {
 spi_read_buf[ i ] = ucRf4463SPIByte( 0x00 );
 }
  GPIOA_ODRbits.ODR3  = 1;
}




void spi_fast_read( unsigned char api_command ) {
 unsigned char i,p[1];

 p[0] = api_command;
 i = 0;
 while ( i != 0xFF ) {
 i = check_cts();
 }

  GPIOA_ODRbits.ODR3  = 1;
  GPIOA_ODRbits.ODR3  = 0;
 ucRf4463SPIByte( api_command );
 for ( i = 0; i < 4; i++ ) {
 spi_read_buf[ i ] = ucRf4463SPIByte( 0xFF );
 }
  GPIOA_ODRbits.ODR3  = 1;
}




void spi_write_fifo( void ) {
 unsigned char i;

 i = 0;
 while ( i != 0xFF ) {
 i = check_cts();
 }

  GPIOA_ODRbits.ODR3  = 1;
  GPIOA_ODRbits.ODR3  = 0;
 ucRf4463SPIByte(  0x66  );

 if ( mode ==  2 ) {
 for ( i = 0; i <  14 ; i++ ) {
 ucRf4463SPIByte( tx_test_aa_data[ i ] );
 }
 }
 else {
 for ( i = 0; i <  14 ; i++ ) {
 ucRf4463SPIByte( tx_ph_data[ i ] );
 }
 }
  GPIOA_ODRbits.ODR3  = 1;
}




void spi_read_fifo( void ) {
 unsigned char i;

 i = 0;
 while ( i != 0xFF ) {
 i = check_cts();
 }

  GPIOA_ODRbits.ODR3  = 1;
  GPIOA_ODRbits.ODR3  = 0;
 ucRf4463SPIByte(  0x77  );
 for ( i = 0; i <  14 ; i++ ) {
 rx_buf[ i ] = ucRf4463SPIByte( 0xFF );
 }
  GPIOA_ODRbits.ODR3  = 1;
}




void VRF4463SDNReset( void ) {
 unsigned char i;

  GPIOB_ODRbits.ODR2  = 1;
 Delay_ms( 6 );
  GPIOB_ODRbits.ODR2  = 0;
 Delay_ms( 10 );

  GPIOA_ODRbits.ODR3  = 1;
  GPIOA_ODRbits.ODR3  = 0;
 for ( i = 0; i < 7; i++ ) {
 ucRf4463SPIByte( RF_POWER_UP_data[ i ] );
 }
  GPIOA_ODRbits.ODR3  = 1;

 Delay_ms( 20 );
}
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/utils.c"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/utils.h"
#line 49 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/utils.h"
unsigned char ucASCIIToByte( unsigned char * pcASCIIBuffer );
#line 61 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/utils.h"
void vASCIIToHex( unsigned char *pcHexConvertBuffer, unsigned char *pcASCIIConvertBuffer, unsigned char ucConversionLength );
#line 73 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/utils.h"
void vHexToASCII( unsigned char *pcASCIIConvertBuffer, unsigned char *pcHexConvertBuffer, unsigned char ucConversionLength );
#line 85 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/utils.h"
void vBufferSetToZero( unsigned char * pcBufferToClean, unsigned int uslength );
#line 97 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/utils.h"
void vBufferSetTo255( unsigned char * pcBufferToClean, unsigned int uslength );
#line 109 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/utils.h"
void vBufferSetToValue( unsigned char * pcBufferToClean, unsigned char ucValue, unsigned int uslength );
#line 121 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/utils.h"
void vSerializeUUID( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer );
#line 133 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/utils.h"
void vSerializeMACAddress( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer );
#line 145 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/utils.h"
void vSerializeIPAddress( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer );
#line 25 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/utils.c"
const unsigned char pcHexChar[16] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};

unsigned char ucMSBNibble = 0;
unsigned char ucLSBNibble = 0;
#line 41 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/utils.c"
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
#line 61 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/utils.c"
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
#line 85 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/utils.c"
void vHexToASCII( unsigned char *pcASCIIConvertBuffer, unsigned char *pcHexConvertBuffer, unsigned char ucConversionLength ){
 unsigned char ucHexConvCounter = 0;

 for( ucHexConvCounter = 0; ucHexConvCounter < ucConversionLength; ucHexConvCounter++ ){
 pcASCIIConvertBuffer[ ucHexConvCounter * 2 ] = pcHexChar[ pcHexConvertBuffer[ ucHexConvCounter ] >> 4 ];
 pcASCIIConvertBuffer[ ( ucHexConvCounter * 2 ) + 1 ] = pcHexChar[ ( pcHexConvertBuffer[ ucHexConvCounter ] & 0x0F ) ];
 }
}
#line 97 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/utils.c"
void vBufferSetToZero( unsigned char * pcBufferToClean, unsigned int uslength ){
 unsigned int usPosition = 0;

 for( usPosition = 0; usPosition < uslength; usPosition++ ){
 pcBufferToClean[ usPosition ] = 0x00;
 }
}
#line 108 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/utils.c"
void vBufferSetTo255( unsigned char * pcBufferToClean, unsigned int uslength ){
 unsigned int usPosition = 0;

 for( usPosition = 0; usPosition < uslength; usPosition++ ){
 pcBufferToClean[ usPosition ] = 0xFF;
 }
}
#line 119 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/utils.c"
void vBufferSetToValue( unsigned char * pcBufferToClean, unsigned char ucValue, unsigned int uslength ){
 unsigned int usPosition = 0;

 for( usPosition = 0; usPosition < uslength; usPosition++ ){
 pcBufferToClean[ usPosition ] = ucValue;
 }
}
#line 130 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/utils.c"
void vSerializeUUID( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer ){
 unsigned char ucCounter = 0;

 for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
 pcTextConvertBuffer[ ucCounter * 2 ] = pcHexChar[ pcHexConvertBuffer[ ucCounter ] >> 4 ];
 pcTextConvertBuffer[ ( ucCounter * 2 ) + 1 ] = pcHexChar[ pcHexConvertBuffer[ ucCounter ] & 0x0F ];
 }
}
#line 142 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/utils.c"
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
#line 161 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/utils.c"
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
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/uarthandler.c"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/uarthandler.h"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/debug.h"
#line 80 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/debug.h"
 void vDebugInit();
 void vDebugPrint();
#line 25 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/uarthandler.h"
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
#line 54 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/uarthandler.h"
void vUARTTxInit();

void vUARTRxInit();

void vUARTRxMessage();

void vUARTCommands( unsigned char * pcInBuffer );
#line 41 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/uarthandler.c"
volatile unsigned char ucUSART1RXBuffer[  4096  ] = { 0x00 };
volatile unsigned long ulUSART1ByteReceived = 0UL;
volatile unsigned long fUSART1Buffer =  0 ;


unsigned char ucUSARTActiveBuffer1 [  4096  ] = { 0x00 };
unsigned long ulUSARTActiveBuffer1BytesReceived = 0;

volatile unsigned long ulClk;

unsigned char ucUSARTNull = 0x00;
#line 56 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/uarthandler.c"
unsigned char ucUSART1TxBuffer[  2048  ];
unsigned char ucUSART1RxBuffer[  2048  ];




unsigned int usBufferCounter = 0;
unsigned int usPosition = 0;
unsigned int usUARTMessageLength = 0;

unsigned char ucTempByteUART = 0;
#line 83 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/uarthandler.c"
void DMA1Ch1_interrupt() iv IVT_INT_DMA1_Channel1 ics ICS_AUTO {

 if ( DMA1_ISRbits.TEIF1 ) {
 DMA1_IFCRbits .CTEIF1 = 1;

 }
 else if ( DMA1_ISRbits.HTIF1 ) {
 DMA1_IFCRbits.CHTIF1 = 1;
 }
 else if ( DMA1_ISRbits.TCIF1 ) {
 DMA1_IFCRbits.CTCIF1 = 1;
 DMA1_CCR1bits.EN = 0;

 }
}


void DMA1Ch4_interrupt() iv IVT_INT_DMA1_Channel4 ics ICS_AUTO {

 if ( DMA1_ISRbits.TEIF4 ) {
 DMA1_IFCRbits .CTEIF4 = 1;

 }
 else if ( DMA1_ISRbits.HTIF4 ) {
 DMA1_IFCRbits.CHTIF4 = 1;
 }
 else if ( DMA1_ISRbits.TCIF4 ) {
 DMA1_IFCRbits.CTCIF4 = 1;
 DMA1_CCR4bits.EN = 0;

 }
}
#line 146 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/uarthandler.c"
void vUARTISR() iv IVT_INT_USART1 ics ICS_AUTO{
  GPIOC_ODRbits.ODR8  =~  GPIOC_ODRbits.ODR8 ;








}
#line 167 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/uarthandler.c"
unsigned char vUSARTStartMEMtoMEMZero ( unsigned long *pcBufferDestination, unsigned long ulSizeInBytes ) {


 while ( DMA1_CCR1bits.EN );

 if ( ulSizeInBytes > 0 ) {
 DMA1_CCR1bits.EN = 0;
 while ( DMA1_CCR1bits.EN );


 DMA1_CPAR4 = ( unsigned long ) &ucUSARTNull;
 DMA1_CMAR4 = ( unsigned long ) pcBufferDestination;

 DMA1_CNDTR4 = ulSizeInBytes;
 DMA1_CCR1bits.EN = 1;
 while ( DMA1_CCR1bits.EN );
 return 1;
 }
 return 0;
#line 206 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/uarthandler.c"
}



void vUSARTDMAMeToMemZero ( void ) {


 RCC_AHBENRbits.DMA1EN = 1;

 DMA1_CCR1bits.EN = 0;
 while ( DMA1_CCR1bits.EN );

 PL0_bit = 1;
 PL1_bit = 1;

 DMA1_CCR1bits.MINC = 1;
 DMA1_CCR1bits.PINC = 0;
 DMA1_CCR1bits.DIR_ = 1;
 DMA1_CCR1bits.MEM2MEM = 1;

 DMA1_CCR1bits.TEIE = 1;
 DMA1_CCR1bits.TCIE = 1;

 NVIC_IntEnable( IVT_INT_DMA1_Channel1 );
#line 252 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/uarthandler.c"
}




unsigned char vUSARTStartMEMtoMEM ( unsigned long *pcBufferOrigin, unsigned long *pcBufferDestination, unsigned long ulSizeInBytes ) {


 while ( DMA1_CCR2bits.EN );

 if ( ulSizeInBytes > 0 ) {
 DMA1_CCR2bits.EN = 0;
 while ( DMA1_CCR2bits.EN );


 DMA1_CPAR2 = ( unsigned long ) pcBufferOrigin;
 DMA1_CMAR2 = ( unsigned long ) pcBufferDestination;

 DMA1_CNDTR2 = ulSizeInBytes;
 DMA1_CCR2bits.EN = 1;
 while ( DMA1_CCR2bits.EN );
 return 1;
 }
 return 0;
#line 296 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/uarthandler.c"
}



void vUSARTDMAMemToMem ( void ) {


 RCC_AHBENRbits.DMA1EN = 1;

 DMA1_CCR2bits.EN = 0;
 while ( DMA1_CCR2bits.EN );

 PL0_DMA1_CCR2_bit = 1;
 PL1_DMA1_CCR2_bit = 1;

 DMA1_CCR2bits.MINC = 1;
 DMA1_CCR2bits.PINC = 0;
 DMA1_CCR2bits.DIR_ = 1;
 DMA1_CCR2bits.MEM2MEM = 1;

 DMA1_CCR2bits.TEIE = 1;
 DMA1_CCR2bits.TCIE = 1;

 NVIC_IntEnable( IVT_INT_DMA1_Channel2 );
#line 342 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/uarthandler.c"
}





unsigned char vUSART1Start_TX ( unsigned long *ucBuffer, unsigned long ulSize ) {


 while ( DMA1_CCR4bits.EN || !USART1_SRbits.TC );

 if ( USART1_CR1bits.UE && USART1_SRbits.TC && ulSize > 0 ) {
 DMA1_CCR4bits.EN = 0;
 while ( DMA1_CCR4bits.EN );

 DMA1_CMAR4 = ( unsigned long ) ucBuffer;
 DMA1_CNDTR4 = ulSize;
 DMA1_CCR4bits.EN = 1;
 while ( DMA1_CCR4bits.EN || !USART1_SRbits.TC );
 return 1;
 }
 return 0;
#line 381 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/uarthandler.c"
}



void vInitDMAUSART1_TX () {

 RCC_AHBENRbits.DMA1EN = 1;

 DMA1_CCR4bits.EN = 0;
 while ( DMA1_CCR4bits.EN );


 DMA1_CPAR4 = ( unsigned long ) &USART1_DR;

 PL0_DMA1_CCR4_bit = 1;
 PL1_DMA1_CCR4_bit = 1;
 DMA1_CCR4bits.MINC = 1;
 DMA1_CCR4bits.DIR_ = 1;
 DMA1_CCR4bits.TEIE = 1;
 DMA1_CCR4bits.TCIE = 1;

 NVIC_IntEnable( IVT_INT_DMA1_Channel4 );
#line 423 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/uarthandler.c"
}




void vUSARTConfigUSART1 ( unsigned long ulBaudRate ) {
#line 441 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/uarthandler.c"
 UART1_Init_Advanced( ulBaudRate, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10 );
 USART1_CR1bits.UE = 0;

 ulClk = Clock_MHz() * 1000000;

 USART1_BRR = ( ulClk ) / ulBaudRate;

 USART1_CR1bits.UE = 1;

}





void vUSARTCleanBuffer ( unsigned char *ucBuffer, unsigned int uiCnt ) {

 vUSARTStartMEMtoMEMZero( ucBuffer, uiCnt );
}



void vUSARTReceivedFromUSART1 ( ) {

 vUSARTCleanBuffer( ucUSARTActiveBuffer1, ulUSARTActiveBuffer1BytesReceived );

 vUSARTStartMEMtoMEM( ucUSART1RXBuffer, ucUSARTActiveBuffer1, ulUSART1ByteReceived );
 vUSARTCleanBuffer( ucUSART1RXBuffer, ulUSART1ByteReceived );
 ulUSARTActiveBuffer1BytesReceived = ulUSART1ByteReceived;
 ulUSART1ByteReceived = 0;
 fUSART1Buffer =  0 ;
 vRF4463MainCommandProcessor( ucUSARTActiveBuffer1 );
}
#line 482 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/uarthandler.c"
void vUARTRxMessage(){
 unsigned int usCounter = 0;






  ;




 usUARTMessageLength = 0;
}
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/debug.c"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/debug.h"
#line 83 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/debug.c"
 void vDebugInit();
#line 93 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/driverrf4463pro_g071kb [ mikroc 6.2 ]4 dic 2020/driverrf4463pro_g071kb [ mikroc 6.2 ]/debug.c"
 void vDebugPrint();
#line 59 "C:/Users/Crow/OneDrive/Escritorio/Proyect Radio SI4463Pro/DriverRF4463PRO_G071KB [ MikroC 6.2 ]4 DIC 2020/DriverRF4463PRO_G071KB [ MikroC 6.2 ]/DriverRF4463PROMain.c"
void Timer2_interrupt() iv IVT_INT_TIM2 {
 TIM2_SR.UIF = 0;
 Flag.rf_reach_timeout = 1;
 Flag.reach_1s = 1;
}



void vRF4463MainCommandProcessor ( unsigned char *ucBuffer ) {

}





void InitTimer2(){
#line 87 "C:/Users/Crow/OneDrive/Escritorio/Proyect Radio SI4463Pro/DriverRF4463PRO_G071KB [ MikroC 6.2 ]4 DIC 2020/DriverRF4463PRO_G071KB [ MikroC 6.2 ]/DriverRF4463PROMain.c"
 RCC_APBENR1bits.TIM2EN = 1;
 TIM2_CR1.CEN = 0;
 TIM2_PSC = 249;
 TIM2_ARR = 63999;
 NVIC_IntEnable( IVT_INT_TIM2 );
 TIM2_DIER.UIE = 1;
 TIM2_CR1.CEN = 1;

}



void main() {

 unsigned char i, j, chksum;

 Delay_ms( 2000 );




 GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_6 );
 GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_7 );
 GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_8 );
#line 115 "C:/Users/Crow/OneDrive/Escritorio/Proyect Radio SI4463Pro/DriverRF4463PRO_G071KB [ MikroC 6.2 ]4 DIC 2020/DriverRF4463PRO_G071KB [ MikroC 6.2 ]/DriverRF4463PROMain.c"
 GPIO_Digital_Input( &GPIOC_BASE, _GPIO_PINMASK_12 );

 GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_12 );
 GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_11 );
 GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_11 );
 GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_10 );
#line 125 "C:/Users/Crow/OneDrive/Escritorio/Proyect Radio SI4463Pro/DriverRF4463PRO_G071KB [ MikroC 6.2 ]4 DIC 2020/DriverRF4463PRO_G071KB [ MikroC 6.2 ]/DriverRF4463PROMain.c"
 RCC_APB2ENRbits.AFIOEN = 1;
#line 129 "C:/Users/Crow/OneDrive/Escritorio/Proyect Radio SI4463Pro/DriverRF4463PRO_G071KB [ MikroC 6.2 ]4 DIC 2020/DriverRF4463PRO_G071KB [ MikroC 6.2 ]/DriverRF4463PROMain.c"
 AFIO_EXTICR4 |= 0x0002;
#line 133 "C:/Users/Crow/OneDrive/Escritorio/Proyect Radio SI4463Pro/DriverRF4463PRO_G071KB [ MikroC 6.2 ]4 DIC 2020/DriverRF4463PRO_G071KB [ MikroC 6.2 ]/DriverRF4463PROMain.c"
 EXTI_IMR.B12 |= 1;
 EXTI_FTSR.B12 |= 1;

 GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_7 );
 Sound_Init( &GPIOB_ODR, 7 );
 Sound_Play( 1000, 100 );
#line 216 "C:/Users/Crow/OneDrive/Escritorio/Proyect Radio SI4463Pro/DriverRF4463PRO_G071KB [ MikroC 6.2 ]4 DIC 2020/DriverRF4463PRO_G071KB [ MikroC 6.2 ]/DriverRF4463PROMain.c"
 GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_6 );




 GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_9 );


 GPIO_Digital_Input( &GPIOC_BASE, _GPIO_PINMASK_14 );
 GPIO_Digital_Input( &GPIOC_BASE, _GPIO_PINMASK_15 );
#line 230 "C:/Users/Crow/OneDrive/Escritorio/Proyect Radio SI4463Pro/DriverRF4463PRO_G071KB [ MikroC 6.2 ]4 DIC 2020/DriverRF4463PRO_G071KB [ MikroC 6.2 ]/DriverRF4463PROMain.c"
 GPIO_Digital_Input( &GPIOA_BASE, _GPIO_PINMASK_2 );

 GPIO_Digital_Output( &GPIOA_BASE, _GPIO_PINMASK_3 );
 GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_2 );
 GPIO_Digital_Output( &GPIOA_BASE, _GPIO_PINMASK_11 );
 GPIO_Digital_Output( &GPIOA_BASE, _GPIO_PINMASK_12 );
#line 251 "C:/Users/Crow/OneDrive/Escritorio/Proyect Radio SI4463Pro/DriverRF4463PRO_G071KB [ MikroC 6.2 ]4 DIC 2020/DriverRF4463PRO_G071KB [ MikroC 6.2 ]/DriverRF4463PROMain.c"
 RCC_APBENR2bits.SYSCFGEN = 1;

 SYSCFG_VREFBUF_CFGR1bits.UCPD1_STROBE = 1;


  GPIOA_ODRbits.ODR3  = 1;

  GPIOC_ODRbits.ODR6  = 1;
  GPIOC_ODRbits.ODR6  = 1;
  GPIOC_ODRbits.ODR8  = 1;

 Delay_ms( 100 );

  GPIOC_ODRbits.ODR6  = 0;
  GPIOC_ODRbits.ODR6  = 1;
  GPIOC_ODRbits.ODR8  = 0;

 InitTimer2();


 vUSARTConfigUSART1( 115200 );



 vSPI2Init();
#line 287 "C:/Users/Crow/OneDrive/Escritorio/Proyect Radio SI4463Pro/DriverRF4463PRO_G071KB [ MikroC 6.2 ]4 DIC 2020/DriverRF4463PRO_G071KB [ MikroC 6.2 ]/DriverRF4463PROMain.c"
 vSPI1Init();





 freq3 = 9;
 freq2 = 1;
 freq1 = 5;


 power = 1;

 rate =  0 ;

 mode =  1 ;



 reset_mode = 0;



 VRF4463SDNReset();
 vRF4463Init();
 vRF4463ClearInterrupts();
 vRF4463PartInfo ();

  GPIOC_ODRbits.ODR6  = 0;
  GPIOC_ODRbits.ODR8  = 0;






 UART1_Write_Text( "[ SYS STM32G ]RF Radio ready\r\n" );


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
 if ( ! GPIOA_IDRbits.IDR2  ) {
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


 if ( !Flag.is_tx ) {
 if ( ! GPIOA_IDRbits.IDR2  ) {
 vRF4463ClearInterrupts();

 if ( ( spi_read_buf[ 4 ] & 0x08) == 0 ) {

 spi_read_fifo();
 vRF4463FifoReset();

 chksum = 0;
 for ( i = 4; i <  14  - 1; i++ )
 chksum += rx_buf[ i ];

 if ( ( chksum == rx_buf[  14  - 1 ] )&&( rx_buf[ 4 ] == 0x41 )) {








 UART1_Write_Text( rx_buf );
 UART1_Write_Text("\r\n");




  GPIOC_ODRbits.ODR6  ^= 1;
 rx_cnt++;





 }
 else
 vRF4463RxInit();
 }
 else {

 vUSART1Start_TX("[ CRC ] Fail\r\n", 14 );
 VRF4463SDNReset();
 vRF4463Init();
 vRF4463RxInit();
 }
 }
 }
 }
 }
 }
}
