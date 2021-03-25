// SPI para SMT32F107RC

// variables de driver
volatile unsigned char ucSPI1ByteReceived = 0;              //
volatile unsigned char ucSPI2ByteReceived = 0;              //
volatile unsigned char ucSPI3ByteReceived = 0;              //

// Constantes

// Funciones


// Interrupciones
// Interrupcion SPI ( RX )
       void Int_SPI1() iv IVT_INT_SPI1 ics ICS_AUTO {

            if ( SPI1_SRbits.RXNE ) {
               ucSPI1ByteReceived = ( unsigned char )SPI1_DR;      // lee el Byte recibido
               //UART1_Write( ucSPI1ByteReceived );               // DEPURACION
               LED_GREEN = ~LED_GREEN;
            }
       }

// Interrupcion DMA ( TX )
// definido por necesidad del compilador ***************************************
// interrupcion que atiende comportamiento de DMA ( Ch1 SPI_TX )

      void DMACh1_interrupt() iv IVT_INT_DMA_Channel1 ics ICS_AUTO {

           if ( DMA_ISRbits.TEIF3 ) {
              DMA_IFCRbits.CTEIF3 = 1;
              while ( SPI1_SRbits.BSY );
              while ( !SPI1_SRbits.TXE );
              DMA_CCR1bits.EN = 0;
           }

           if ( DMA_ISRbits.TCIF1 ) {     // TRANSFER COMPLETE INTERRUPT FLAG = envio el frame completo
                DMA_IFCRbits.CGIF0 = 1;        // limpia TODOS LOS FLAGS DE DMA
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


// Funcion de envio mediante DMA para SPI
// ej.: vRF4463SpiBufferTX( ucBufferTest, sizeof( ucBufferTest ) );
char vRF4463SpiBufferTX ( unsigned long *ucBuffer, unsigned long ulSize ) {

     while ( DMA_CCR1bits.EN || !SPI1_SRbits.TXE );

     SPI1_CR1bits.SPE = 1;                         // habilita el periferico

     if ( SPI1_CR1bits.SPE && SPI1_SRbits.TXE && ulSize > 0 ) { // la transmision anterior termino?
        DMA_CCR1bits.EN = 0;                       // Desabilita la recepcion para poder modificar los par?metros
        while ( DMA_CCR1bits.EN );                 // espera a que se haya desabilitado realmente

        DMA_CMAR1 = ( unsigned long ) ucBuffer;    // Direccion de la memoria a rutear
        DMA_CNDTR1 = ulSize;                       // Tamagno de datos a manejar
        DMA_CCR1bits.EN = 1;

        while ( DMA_CNDTR1 > 1 );                  // esperando el fin de la transmision

        while ( SPI1_SRbits.FTLVL != 0 );          // SPI1_SRbits.FTLVL != 0

        while ( SPI1_SRbits.BSY );
        while ( !SPI1_SRbits.TXE );

        DMA_CCR1bits.EN = 0;                       // DEPURACION

        return 1;
     }
     return 0;
}

void vSPI1Init( void ) {
     // Configuracion GPIO
        RCC_IOPENRbits.IOPAEN       = 1;      // GPIOA Enabled
        GPIOA_MODERbits.MODER5      = 2;      // Altern Function
        GPIOA_OTYPERbits.OT5        = 0;      // push pull
        GPIOA_OSPEEDRbits.OSPEEDR5  = 0;      // high Speed
        GPIOA_PUPDRbits.PUPDR5      = 0;      // no PU or PD
        GPIOA_AFRLbits.AFSEL5       = 0;      // AF0

        GPIOA_MODERbits.MODER6      = 2;      // Altern Function
        GPIOA_OTYPERbits.OT6        = 0;      // push pull
        GPIOA_OSPEEDRbits.OSPEEDR6  = 0;      // high Speed
        GPIOA_PUPDRbits.PUPDR6      = 0;      // no PU or PD
        GPIOA_AFRLbits.AFSEL6       = 0;      // AF0

        GPIOA_MODERbits.MODER7      = 2;      // Altern Function
        GPIOA_OTYPERbits.OT7        = 0;      // push pull
        GPIOA_OSPEEDRbits.OSPEEDR7  = 0;      // high Speed
        GPIOA_PUPDRbits.PUPDR7      = 0;      // no PU or PD
        GPIOA_AFRLbits.AFSEL7       = 0;      // AF0

        // Configuracion SPI
        RCC_APBENR2bits.SPI1EN      = 1;
        //SPI1_CR1bits.BR             = 2;      // FpclK / 8
        SPI1_CR1bits.CPHA           = 0;      // 1 if TI enabled
        SPI1_CR1bits.CPOL           = 0;
        SPI1_CR1bits.LSBFIRST       = 0;
        SPI1_CR1bits.SSM            = 1;
        SPI1_CR1bits.SSI            = 1;
        SPI1_CR1bits.MSTR           = 1;
        SPI1_CR1bits.CRCNEXT        = 0;

        SPI1_CR2bits.FRF            = 0;
        SPI1_CR2bits.DS             = 7;      // 8 bits empaquetado
        SPI1_CR2bits.SSOE           = 0;
        SPI1_CR2bits.NSSP           = 1;
        SPI1_CR2bits.FRXTH          = 1;
        SPI1_CR2bits.TXDMAEN        = 1;
        //SPI1_CR2bits.LDMA_TX        = 1;      // prueba

        // Configuracion DMA TX
        RCC_AHBENRbits.DMAEN        = 1;

        DMA_CCR1bits.EN = 0;
        while ( DMA_CCR1bits.EN );

        PL0_bit = 1;
        PL1_bit = 1;
        DMA_CCR1bits.MINC           = 1;      // Mem increment
        DMA_CCR1bits.DIR_           = 1;      // Read from Memory
        DMA_CCR1bits.TEIE           = 1;      // Transfer Error Int
        DMA_CCR1bits.TCIE           = 1;      // Transfer Complete Int

        DMA_CPAR1 = ( unsigned long ) &SPI1_DR;    // periferico ruteado

        NVIC_IntEnable( IVT_INT_DMA_Channel1 );    // habilitacion de interrupcion

        DMAMUX_C0CRbits.DMAREQ_ID = 17;            // TX_SPI1

        SPI1_CR2bits.RXNEIE = 1;                   // habilita interrupcion de recepcion SPI

        NVIC_IntEnable( IVT_INT_SPI1 );
}
