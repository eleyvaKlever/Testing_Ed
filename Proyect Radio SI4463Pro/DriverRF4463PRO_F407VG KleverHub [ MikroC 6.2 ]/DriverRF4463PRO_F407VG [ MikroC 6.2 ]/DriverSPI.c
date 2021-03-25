// SPI para SMT32F107RC

unsigned int uiSPIStatus = 0;

// variables de driver
volatile unsigned char ucSPI1ByteReceived = 0;              //
volatile unsigned char ucSPI2ByteReceived = 0;              //
volatile unsigned char ucSPI3ByteReceived = 0;              //

// Funciones
 void Int_SPI1() iv IVT_INT_SPI1 ics ICS_AUTO {

      if ( SPI1_SRbits.RXNE ) {
         ucSPI1ByteReceived = ( unsigned char )SPI1_DR;      // lee el Byte recibido
         //UART1_Write( ucSPI3ByteReceived );               // DEPURACION
         //LED_GREEN = ~LED_GREEN;
      }
 }



void vSPI1Init ( void ) {
    SPI1_Init_Advanced( _SPI_FPCLK_DIV2, _SPI_MASTER | _SPI_8_BIT | _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION |
                        _SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI1_PB345 );

    SPI1_CR2bits.RXNEIE  = 1;       // habilitacion de ISR para RX
    //SPI2_CR2bits.TXDMAEN = 1;     // habilitacion de DMA para TX
    NVIC_IntEnable( IVT_INT_SPI1 );
}



