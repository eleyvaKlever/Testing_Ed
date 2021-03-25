// SPI para SMT32F107RC

// variables de driver
volatile unsigned char ucSPI2ByteReceived = 0;              //

// Constantes

// Funciones


// Interrupciones
// Interrupcion SPI ( RX )




void Int_SPI2() iv IVT_INT_SPI2 ics ICS_AUTO {

     if ( SPI2_SRbits.RXNE ) {
        ucSPI2ByteReceived = ( unsigned char )SPI2_DR;      // lee el Byte recibido
        //UART1_Write( ucSPI2ByteReceived );               // DEPURACION
        LED_GREEN = ~LED_GREEN;
        // ucSPI1LastStatus = SPI1_SRbits.RXNE;
     }
}

// Interrupcion DMA ( TX )



// Funcion de inicializacion
void vSPI2Init ( void ) {
     SPI2_Init_Advanced( _SPI_FPCLK_DIV8, _SPI_MASTER | _SPI_8_BIT | _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION | _SPI_MSB_FIRST |
                        _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI2_PB13_14_15 );
                        
     SPI2_CR2bits.RXNEIE  = 1;     // habilitacion de ISR para RX
     //SPI2_CR2bits.TXDMAEN = 1;     // habilitacion de DMA para TX
     NVIC_IntEnable( IVT_INT_SPI2 );
}