/*******************************************************************************************************************************************************************************************************
 * File:
 * Author:
 * Editor:
 * Project:
 * Version:
 *
 * Compiler:
 * IDE:
 * Platform:
 * Kernel:
 *
 * Notes:
*******************************************************************************************************************************************************************************************************/
/**********************************************************************************************
 * Prototyping Header
**********************************************************************************************/
#include "UARTHandler.h"
/**********************************************************************************************
 * Defines
**********************************************************************************************/

// Caracteres de control
#define CHR_CR                   0x0D    // ingreso estandar de comandos
#define CHR_LF                   0x0A    // ingreso estandar de comandos
#define CHR_S                    'S'     //
#define CHR_s                    's'     //
#define CHR_G                    'G'     //
#define CHR_g                    'g'     //
#define CHR_U                    'U'     //
#define CHR_u                    'u'     //
#define CHR_SUB                  0x1A    // indicacion de fin de mensaje

#define BUFFER_MAX_GENERAL       4096    // 4096

// Alias
#define Disable_IRQ_USART1   USART1_CR1bits.RXNEIE = 0
#define Enable_IRQ_USART1    USART1_CR1bits.RXNEIE = 1

// Constantes
#define BUFFER_MAX_USART     BUFFER_MAX_GENERAL    // consta de 64 bytes de recepcion hasta el momento
#define READY_TO_READ        1                     // Valores para el flag de estado de los buffers
#define CLEAR_TO_WRITE       0

// Variables alteradas desde Interrupcion
volatile unsigned char  ucUSART1RXBuffer[ BUFFER_MAX_GENERAL ] = { 0x00 };  // buffer de lectura
volatile unsigned long  ulUSART1ByteReceived = 0UL;                         // contador de bytes recibidos
volatile unsigned long  fUSART1Buffer = CLEAR_TO_WRITE;                     // flags del estado de los buffer

// para recibir todo desde USART y analizar
unsigned char ucUSARTActiveBuffer1  [ BUFFER_MAX_GENERAL ] = { 0x00 };
unsigned long ulUSARTActiveBuffer1BytesReceived = 0;

volatile unsigned long ulClk;

unsigned char ucUSARTNull  = 0x00;          // para DMA que limpia memoria

volatile unsigned char  ucData1       = 0;

/**********************************************************************************************
 * Local Variables
**********************************************************************************************/
unsigned char ucUSART1TxBuffer[ UART_MAX_BUFFER_LENGTH ];
unsigned char ucUSART1RxBuffer[ UART_MAX_BUFFER_LENGTH ];

//unsigned char pcTxRF4463AuxBuffer[ RF_MAX_BUFFER_LENGTH ];
//unsigned char pcRxRF4463AuxBuffer[ RF_MAX_BUFFER_LENGTH ];

unsigned int usBufferCounter = 0;
unsigned int usPosition = 0;
unsigned int usUARTMessageLength = 0;

unsigned char ucTempByteUART = 0;

/*********************************************************************
 * UART
*********************************************************************/


/**********************************************************************************************
 * Instances
**********************************************************************************************/
//extern RadioParameters_t xRadioParameters;
/**********************************************************************************************
 * IRQ Handlers
**********************************************************************************************/
// definido por necesidad del compilador ***************************************
// interrupcion que atiende comportamiento de DMA2 ( Stream 0 = MEMtoMEM )
#if defined ( STM32F107RC ) | ( STM32F107VC )
void DMA1Ch1_interrupt() iv IVT_INT_DMA1_Channel1 ics ICS_AUTO {

     if ( DMA1_ISRbits.TEIF1 ) {         // TRANSFER ERROR INTERRUPT FLAG
        DMA1_IFCRbits .CTEIF1 = 1;       // limpia el flag de error
     }
     else if ( DMA1_ISRbits.HTIF1 ) {
          DMA1_IFCRbits.CHTIF1 = 1;
     }
     else if ( DMA1_ISRbits.TCIF1 ) {     // TRANSFER COMPLETE INTERRUPT FLAG = envio el frame completo
          DMA1_IFCRbits.CTCIF1 = 1;       // limpia TODOS LOS FLAGS DE DMA2 CANAL 2
          DMA1_CCR1bits.EN = 0;            // EXPERIMENTAL PARA CAMBIAR EL VALOR DEL CONTADOR
     }
}

void DMA1Ch2_interrupt() iv IVT_INT_DMA1_Channel2 ics ICS_AUTO {

     if ( DMA1_ISRbits.TEIF2 ) {         // TRANSFER ERROR INTERRUPT FLAG
        DMA1_IFCRbits .CTEIF2 = 1;       // limpia el flag de error
     }
     else if ( DMA1_ISRbits.HTIF2 ) {
          DMA1_IFCRbits.CHTIF2 = 1;
     }
     else if ( DMA1_ISRbits.TCIF2 ) {     // TRANSFER COMPLETE INTERRUPT FLAG = envio el frame completo
          DMA1_IFCRbits.CTCIF2 = 1;       // limpia TODOS LOS FLAGS DE DMA2 CANAL 2
          DMA1_CCR2bits.EN = 0;            // EXPERIMENTAL PARA CAMBIAR EL VALOR DEL CONTADOR
     }
}

// DMA 1 Channel 4 USART1_TX
void DMA1Ch4_interrupt() iv IVT_INT_DMA1_Channel4 ics ICS_AUTO {

     if ( DMA1_ISRbits.TEIF4 ) {         // TRANSFER ERROR INTERRUPT FLAG
        DMA1_IFCRbits .CTEIF4 = 1;       // limpia el flag de error
     }
     else if ( DMA1_ISRbits.HTIF4 ) {
          DMA1_IFCRbits.CHTIF4 = 1;
     }
     else if ( DMA1_ISRbits.TCIF4 ) {     // TRANSFER COMPLETE INTERRUPT FLAG = envio el frame completo
          DMA1_IFCRbits.CTCIF4 = 1;       // limpia TODOS LOS FLAGS DE DMA2 CANAL 2
          DMA1_CCR4bits.EN = 0;            // EXPERIMENTAL PARA CAMBIAR EL VALOR DEL CONTADOR
     }
}
#endif


#ifdef STM32F407VG
// INTERRUPCIONES DMA   -------------------------------------------------------------------------------------
// definido por necesidad del compilador ***************************************
void DMA2Strm1_interrupt() iv IVT_INT_DMA2_Stream1 ics ICS_AUTO {

     if ( DMA2_LISRbits.FEIF1 ) {
        DMA2_LIFCRbits.CFEIF1 = 1;
     }
     else if ( DMA2_LISRbits.DMEIF1 ) {
          DMA2_LIFCRbits.CDMEIF1 = 1;
     }
     else if ( DMA2_LISRbits.TEIF1 ) {     // TRANSFER ERROR INTERRUPT FLAG
          DMA2_LIFCRbits.CTEIF1 = 1;       // limpia el flag de error
     }
     else if ( DMA2_LISRbits.HTIF1 ) {
          DMA2_LIFCRbits.CHTIF1 = 1;
     }
     else if ( DMA2_LISRbits.TCIF1 ) {     // TRANSFER COMPLETE INTERRUPT FLAG = envio el frame completo
          DMA2_LIFCRbits.CTCIF1 = 1;       // limpia TODOS LOS FLAGS DE DMA2 CANAL 2
          DMA2_S1CRbits.EN = 0;            // EXPERIMENTAL PARA CAMBIAR EL VALOR DEL CONTADOR
     }
}


// definido por necesidad del compilador ***************************************
void DMA2Strm4_interrupt() iv IVT_INT_DMA2_Stream4 ics ICS_AUTO {

     if ( DMA2_HISRbits.FEIF4 ) {
        DMA2_HIFCRbits.CFEIF4 = 1;
     }
     else if ( DMA2_HISRbits.DMEIF4 ) {
          DMA2_HIFCRbits.CDMEIF4 = 1;
     }
     else if ( DMA2_HISRbits.TEIF4 ) {     // TRANSFER ERROR INTERRUPT FLAG
          DMA2_HIFCRbits.CTEIF4 = 1;       // limpia el flag de error
     }
     else if ( DMA2_HISRbits.HTIF4 ) {
          DMA2_HIFCRbits.CHTIF4 = 1;
     }
     else if ( DMA2_HISRbits.TCIF4 ) {     // TRANSFER COMPLETE INTERRUPT FLAG = envio el frame completo
          DMA2_HIFCRbits.CTCIF4 = 1;       // limpia TODOS LOS FLAGS DE DMA2 CANAL 2
          DMA2_S4CRbits.EN = 0;            // EXPERIMENTAL PARA CAMBIAR EL VALOR DEL CONTADOR
     }
}


// interrupcion que atiende comportamiento de DMA2 ( Stream 7 = USART1_TX )
void DMA2Strm7_interrupt() iv IVT_INT_DMA2_Stream7 ics ICS_AUTO {

     if ( DMA2_HISRbits.FEIF7 ) {
        DMA2_HIFCRbits.CFEIF7 = 1;
     }
     else if ( DMA2_HISRbits.DMEIF7 ) {
          DMA2_HIFCRbits.CDMEIF7 = 1;
     }
     else if ( DMA2_HISRbits.TEIF7 ) {     // TRANSFER ERROR INTERRUPT FLAG
          DMA2_HIFCRbits.CTEIF7 = 1;       // limpia el flag de error
     }
     else if ( DMA2_HISRbits.HTIF7 ) {
          DMA2_HIFCRbits.CHTIF7 = 1;
     }
     else if ( DMA2_HISRbits.TCIF7 ) {     // TRANSFER COMPLETE INTERRUPT FLAG = envio el frame completo
          DMA2_HIFCRbits.CTCIF7 = 1;       // limpia TODOS LOS FLAGS DE DMA2 CANAL 2
          DMA2_S7CRbits.EN = 0;            // EXPERIMENTAL PARA CAMBIAR EL VALOR DEL CONTADOR
     }
}
#endif

/*********************************************************************
 *
*********************************************************************/
void vUARTISR() iv IVT_INT_USART1 ics ICS_AUTO{
    LED_BLUE =~ LED_BLUE;

    //if( USART1_SRbits.RXNE ){
//        ucData1 = USART1_DR;
//        if ( ucData1 != CHR_CR && ucData1 != CHR_LF && ulUSART1ByteReceived < BUFFER_MAX_USART ) {
//           // Espera por encabezado valido
//           if ( ( ucData1 == CHR_S ||
//                  ucData1 == CHR_s ||
//                  ucData1 == CHR_U ||
//                  ucData1 == CHR_u ||
//                  ucData1 == CHR_G ||
//                  ucData1 == CHR_g ) &&
//                ulUSART1ByteReceived == 0 ) {
//              ucUSART1RXBuffer[ ulUSART1ByteReceived++ ] = ucData1;
//           }
//           // Guarda caracteres siempre y cuando el primero de ellos sea valido
//           else if ( ucUSART1RXBuffer[ 0 ] == CHR_S ||
//                     ucUSART1RXBuffer[ 0 ] == CHR_s ||
//                     ucUSART1RXBuffer[ 0 ] == CHR_U ||
//                     ucUSART1RXBuffer[ 0 ] == CHR_u ||
//                     ucUSART1RXBuffer[ 0 ] == CHR_G ||
//                     ucUSART1RXBuffer[ 0 ] == CHR_g ) {
//                ucUSART1RXBuffer[ ulUSART1ByteReceived++ ] = ucData1;
//           }
//        }
//        // si es un caracter de control...
//        else if ( ucData1 == CHR_CR ) {
//             ucUSART1RXBuffer[ ulUSART1ByteReceived++ ] = ucData1;
//        }
//        // si es un segundo caracter de control manda bandera
//        else if ( ucData1 == CHR_LF && ucUSART1RXBuffer[ ulUSART1ByteReceived - 1 ] == CHR_CR ) {
//             ucUSART1RXBuffer[ ulUSART1ByteReceived++ ] = ucData1;
//             fUSART1Buffer = READY_TO_READ;
//        }
//    }
}

/**********************************************************************************************
 * Function declaration
**********************************************************************************************/
/*********************************************************************
 *
*********************************************************************/
//=============================================================================================================
// Funcion para enviar un determinado buffer por DMA
// ej.: vUSARTStartMEMtoMEM( ucBufferDest, sizeof( ucBufferOrig ) );
unsigned char vUSARTStartMEMtoMEMZero ( unsigned long *pcBufferDestination, unsigned long ulSizeInBytes ) {

     #if defined STM32F107RC | STM32F107VC
            while ( DMA1_CCR1bits.EN );

            if ( ulSizeInBytes > 0 ) {                // la transmision anterior termino?
               DMA1_CCR1bits.EN = 0;                  // Desabilita la recepcion para poder modificar los par?metros
               while ( DMA1_CCR1bits.EN );            // espera a que se haya desabilitado realmente

               // MEMtoMEM
               DMA1_CPAR1 = ( unsigned long ) &ucUSARTNull;         // Direccion de periferico a rutear
               DMA1_CMAR1 = ( unsigned long ) pcBufferDestination;  // Direccion de la memoria a rutear

               DMA1_CNDTR1 = ulSizeInBytes;           // Tamagno de datos a manejar (Header + Payload)
               DMA1_CCR1bits.EN = 1;
               while ( DMA1_CCR1bits.EN );
               return 1;                              // indica que transmitio
            }
            return 0;                                 // indica que NO transmitio
     #endif

     #ifdef STM32F407VG
            while ( DMA2_S4CRbits.EN );

            if ( ulSizeInBytes > 0 ) {                // la transmision anterior termino?
               DMA2_S4CRbits.EN = 0;                  // Desabilita la recepci?n para poder modificar los par?metros
               while ( DMA2_S4CRbits.EN );            // espera a que se haya desabilitado realmente

               // MEMtoMEM
               DMA2_S4PAR = ( unsigned long ) &ucUSARTNull;          // Direccion de periferico a rutear
               DMA2_S4M0AR = ( unsigned long ) pcBufferDestination;  // Direccion de la memoria a rutear

               DMA2_S4NDTR = ulSizeInBytes;           // Tamagno de datos a manejar (Header + Payload)
               DMA2_S4CRbits.EN = 1;
               while ( DMA2_S4CRbits.EN );
               return 1;                              // indica que transmitio
            }
            return 0;                                 // indica que NO transmitio
     #endif
}

//===========================================================================================================
// Usado para LIMPIAR buffers de RAM por hardware
void vUSARTDMAMeToMemZero ( void ) {

     #if defined STM32F107RC | STM32F107VC
            RCC_AHBENRbits.DMA1EN = 1;    // Habilita clock para DMA1

            DMA1_CCR1bits.EN = 0;          // deshabilita DMA SPI4 RX (para poder modificar los parametros)
            while ( DMA1_CCR1bits.EN );    // espera a que se haya desabilitado realmente

            PL0_bit = 1;                   // Prioridad de canal
            PL1_bit = 1;
            DMA1_CCR1bits.MINC = 1;        // avanza en la direccion de la memoria apuntada
            DMA1_CCR1bits.PINC = 0;        // no avanza en la direccion del periferico apuntado
            DMA1_CCR1bits.DIR_ = 0;        // se lee de la "periferico" a Memoria
            DMA1_CCR1bits.MEM2MEM = 1;     // direccion memoria a memoria

            DMA1_CCR1bits.TEIE = 1;        // Habilitacion de interrupcion por error en trasmision
            DMA1_CCR1bits.TCIE = 1;        // Interrupcion por transferencia completa

            NVIC_IntEnable( IVT_INT_DMA1_Channel1 );      // habilita el vector de interrupcion para DMA
     #endif

     #ifdef STM32F407VG
            RCC_AHB1ENRbits.DMA2EN = 1;    // Habilita clock para DMA2

            DMA2_S4CRbits.EN = 0;          // deshabilita DMA SPI4 RX (para poder modificar los parametros)
            while ( DMA2_S4CRbits.EN );    // espera a que se haya desabilitado realmente

            DMA2_S4CRbits.CHSEL = 4;       // DMA2, Stream4, Canal 3 = vacio...
            DMA2_S4CRbits.PL = 3;          // Prioridad de canal
            DMA2_S4CRbits.MINC = 1;        // avanza en la direccion de la memoria apuntada
            DMA2_S4CRbits.PINC = 0;        // avanza en la direccion del periferico apuntado
            DIR0_DMA2_S4CR_bit = 0;        // direccion memoria a memoria
            DIR1_DMA2_S4CR_bit = 1;

            DMA2_S4FCRbits.DMDIS = 1;      // disable DirectMode

            DMA2_S4CRbits.TEIE = 1;        // Habilitacion de interrupcion por error en trasmision
            DMA2_S4CRbits.TCIE = 1;        // Interrupcion por transferencia completa

            NVIC_IntEnable( IVT_INT_DMA2_Stream4 );      // habilita el vector de interrupcion para DMA
     #endif
}

//=============================================================================================================
// Funcion para enviar un determinado buffer por DMA. Revisar el tama?o del buffer destino para evitar errores
// de memoria y posibles HardFault
// ej.: vUSARTStartMEMtoMEM( ucBufferOrig, ucBufferTestDest, sizeof( ucBufferOrig ) );
unsigned char vUSARTStartMEMtoMEM ( unsigned long *pcBufferOrigin, unsigned long *pcBufferDestination, unsigned long ulSizeInBytes ) {

     #if defined STM32F107RC | STM32F107VC
            while ( DMA1_CCR2bits.EN );

            if ( ulSizeInBytes > 0 ) {                // la transmision anterior termino?
               DMA1_CCR2bits.EN = 0;                  // Desabilita la recepci?n para poder modificar los par?metros
               while ( DMA1_CCR2bits.EN );            // espera a que se haya desabilitado realmente

               // MEMtoMEM
               DMA1_CPAR2 = ( unsigned long ) pcBufferOrigin;        // Direccion de periferico a rutear
               DMA1_CMAR2 = ( unsigned long ) pcBufferDestination;   // Direccion de la memoria a rutear

               DMA1_CNDTR2 = ulSizeInBytes;           // Tamagno de datos a manejar (Header + Payload)
               DMA1_CCR2bits.EN = 1;
               while ( DMA1_CCR2bits.EN );
               return 1;                              // indica que transmitio
            }
            return 0;                                 // indica que NO transmitio
     #endif

     #ifdef STM32F407VG
            while ( DMA2_S1CRbits.EN );

            if ( ulSizeInBytes > 0 ) {                // la transmision anterior termino?
               DMA2_S1CRbits.EN = 0;                  // Desabilita la recepci?n para poder modificar los par?metros
               while ( DMA2_S1CRbits.EN );            // espera a que se haya desabilitado realmente

               // MEMtoMEM
               DMA2_S1PAR = ( unsigned long ) pcBufferOrigin;        // Direccion de periferico a rutear
               DMA2_S1M0AR = ( unsigned long ) pcBufferDestination;  // Direccion de la memoria a rutear

               DMA2_S1NDTR = ulSizeInBytes;           // Tamagno de datos a manejar (Header + Payload)
               DMA2_S1CRbits.EN = 1;
               while ( DMA2_S1CRbits.EN );
               return 1;                              // indica que transmitio
            }
            return 0;                                 // indica que NO transmitio
     #endif
}

//===========================================================================================================
// Usado para COPIAR buffers de RAM por hardware
void vUSARTDMAMemToMem ( void ) {

     #if defined STM32F107RC | STM32F107VC
            RCC_AHBENRbits.DMA1EN = 1;    // Habilita clock para DMA1

            DMA1_CCR2bits.EN = 0;          // deshabilita DMA SPI4 RX (para poder modificar los parametros)
            while ( DMA1_CCR2bits.EN );    // espera a que se haya desabilitado realmente

            PL0_DMA1_CCR2_bit = 1;         // Prioridad de canal
            PL1_DMA1_CCR2_bit = 1;
            //DMA1_CCR2bits.PL = 3;          // Prioridad de canal
            DMA1_CCR2bits.MINC = 1;        // avanza en la direccion de la memoria apuntada
            DMA1_CCR2bits.PINC = 1;        // avanza en la direccion del periferico apuntado
            DMA1_CCR2bits.DIR_ = 0;        // se lee de la "periferico" a Memoria
            DMA1_CCR2bits.MEM2MEM = 1;     // direccion memoria a memoria

            DMA1_CCR2bits.TEIE = 1;        // Habilitacion de interrupcion por error en trasmision
            DMA1_CCR2bits.TCIE = 1;        // Interrupcion por transferencia completa

            NVIC_IntEnable( IVT_INT_DMA1_Channel2 );      // habilita el vector de interrupcion para DMA
     #endif

     #ifdef STM32F407VG
            RCC_AHB1ENRbits.DMA2EN = 1;    // Habilita clock para DMA2

            DMA2_S1CRbits.EN = 0;          // deshabilita DMA SPI4 RX (para poder modificar los parametros)
            while ( DMA2_S1CRbits.EN );    // espera a que se haya desabilitado realmente

            DMA2_S1CRbits.CHSEL = 3;       // DMA2, Stream1, Canal 3 = vacio...
            DMA2_S1CRbits.PL = 3;          // Prioridad de canal
            DMA2_S1CRbits.MINC = 1;        // avanza en la direccion de la memoria apuntada
            DMA2_S1CRbits.PINC = 1;        // avanza en la direccion del periferico apuntado
            DIR0_DMA2_S1CR_bit = 0;        // direccion memoria a memoria
            DIR1_DMA2_S1CR_bit = 1;

            DMA2_S1FCRbits.DMDIS = 1;      // disable DirectMode

            DMA2_S1CRbits.TEIE = 1;        // Habilitacion de interrupcion por error en trasmision
            DMA2_S1CRbits.TCIE = 1;        // Interrupcion por transferencia completa

            NVIC_IntEnable( IVT_INT_DMA2_Stream1 );      // habilita el vector de interrupcion para DMA
     #endif
}


//=============================================================================================================
// Funcion para enviar un determinado buffer por DMA
// ej.: vUSART1Start_TX( ucBufferTest, sizeof( ucBufferTest ) );
unsigned char vUSART1Start_TX ( unsigned long *ucBuffer, unsigned long ulSize ) {

     #if defined STM32F107RC | STM32F107VC
            while ( DMA1_CCR4bits.EN || !USART1_SRbits.TC );

            if ( USART1_CR1bits.UE && USART1_SRbits.TC && ulSize > 0 ) { // la transmision anterior termino?
               DMA1_CCR4bits.EN = 0;                       // Desabilita la recepcion para poder modificar los parametros
               while ( DMA1_CCR4bits.EN );                 // espera a que se haya desabilitado realmente

               DMA1_CMAR4 = ( unsigned long ) ucBuffer;   // Direccion de la memoria a rutear
               DMA1_CNDTR4 = ulSize;                       // Tamano de datos a manejar
               DMA1_CCR4bits.EN = 1;
               while ( DMA1_CCR4bits.EN || !USART1_SRbits.TC );
               return 1;                                   // indica que transmitio
            }
            return 0;                                      // indica que NO transmitio
     #endif

     #ifdef STM32F407VG
            while ( DMA2_S7CRbits.EN || !USART1_SRbits.TC );

            if ( USART1_CR1bits.UE && USART1_SRbits.TC && ulSize > 0 ) { // la transmision anterior termino?
               DMA2_S7CRbits.EN = 0;                       // Desabilita la recepcion para poder modificar los parametros
               while ( DMA2_S7CRbits.EN );                 // espera a que se haya desabilitado realmente

               DMA2_S7M0AR = ( unsigned long ) ucBuffer;   // Direccion de la memoria a rutear
               DMA2_S7NDTR = ulSize;                       // Tamano de datos a manejar
               DMA2_S7CRbits.EN = 1;
               while ( DMA2_S7CRbits.EN || !USART1_SRbits.TC );
               return 1;                                   // indica que transmitio
            }
            return 0;                                      // indica que NO transmitio
     #endif
}

//=============================================================================================================
// configuracion para trasmitir por DMA (se busca evitar que la trasmision no continue haciendolo por software)
void vInitDMAUSART1_TX () {
     #if defined STM32F107RC | STM32F107VC
            RCC_AHBENRbits.DMA1EN = 1;    // Habilita clock para DMA1

            DMA1_CCR4bits.EN = 0;          // deshabilita DMA USART1 TX (para poder modificar los parametros)
            while ( DMA1_CCR4bits.EN );    // espera a que se haya desabilitado realmente

            // USART1_TX
            DMA1_CPAR4 = ( unsigned long ) &USART1_DR;           // Direccion fisica de periferico a rutear

            PL0_DMA1_CCR4_bit = 1;         // Prioridad de canal
            PL1_DMA1_CCR4_bit = 1;
            DMA1_CCR4bits.MINC = 1;        // avanza en la direccion de la memoria apuntada
            DMA1_CCR4bits.DIR_ = 1;        // direccion memoria a periferico
            DMA1_CCR4bits.TEIE = 1;        // Habilitacion de interrupcion por error en trasmision
            DMA1_CCR4bits.TCIE = 1;        // Interrupcion por transferencia completa

            NVIC_IntEnable( IVT_INT_DMA1_Channel4 );      // habilita el vector de interrupcion para DMA
     #endif

     #ifdef STM32F407VG
            RCC_AHB1ENRbits.DMA2EN = 1;    // Habilita clock para DMA2

            DMA2_S7CRbits.EN = 0;          // deshabilita DMA USART1 TX (para poder modificar los parametros)
            while ( DMA2_S7CRbits.EN );    // espera a que se haya desabilitado realmente

            // USART1_TX
            DMA2_S7PAR = ( unsigned long ) &USART1_DR;           // Direccion fisica de periferico a rutear

            DMA2_S7CRbits.CHSEL = 4;       // DMA2, Stream7, Canal 4 = USART1_TX
            DMA2_S7CRbits.PL = 3;          // Prioridad de canal
            DMA2_S7CRbits.MINC = 1;        // avanza en la direccion de la memoria apuntada
            DIR0_DMA2_S7CR_bit = 1;        // direccion memoria a periferico
            DMA2_S7CRbits.TEIE = 1;        // Habilitacion de interrupcion por error en trasmision
            DMA2_S7CRbits.TCIE = 1;        // Interrupcion por transferencia completa

            NVIC_IntEnable( IVT_INT_DMA2_Stream7 );      // habilita el vector de interrupcion para DMA
     #endif
}

//===========================================================================================================
// Funciones de configuracion:
// Para depuracion / PC comm
void vUSARTConfigUSART1 ( unsigned long ulBaudRate ) {
     #ifndef STM32G071KB
             UART1_Init_Advanced( ulBaudRate, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10 );
             Enable_IRQ_USART1;                 // habilita interrupcion por RX de USART1
             USART1_CR3bits.DMAT = 1;           // habilita transmision mediante DMA
             vInitDMAUSART1_TX();               // se llama como funcion
             fUSART1Buffer = CLEAR_TO_WRITE;
             NVIC_IntEnable( IVT_INT_USART1 );  // Habilita vector de interrupcion
             vUSARTDMAMemToMem();               // inicializa el DMA MEMtoMEM 1 ( Buffer a Buffer )
             vUSARTDMAMeToMemZero();            // inicializa el DMA MEMtoMEM 2 ( Limpiar buffer )
     #endif

     // Tratamiento especial para familia G. DMA no implementado.
     #ifdef STM32G071KB
            UART1_Init_Advanced( ulBaudRate, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10 );
            USART1_CR1bits.UE = 0;

            ulClk = Clock_MHz() * 1000000;         // paso extra para verificacion en depuracion

            USART1_BRR = ( ulClk ) / ulBaudRate;

            USART1_CR1bits.UE = 1;
     #endif
}


//===========================================================================================================
// Limpia el buffer indicado completamente cuando se solicita
// hay que limpiar el contador de caracteres por separado.
// Por limitaci?n de DMA, solamente pueden borrarse hasta 65536 bytes
void vUSARTCleanBuffer ( unsigned char *ucBuffer, unsigned int uiCnt ) {
     //memset( ucBuffer, 0x00, uiCnt );
     vUSARTStartMEMtoMEMZero( ucBuffer, uiCnt );
}

// Tarea sincronizada con interrupcion para enviar al procesador de comandos
// Esta funcion pasa los datos de buffer de recepcion del USART1
void vUSARTReceivedFromUSART1 ( ) {

     vUSARTCleanBuffer( ucUSARTActiveBuffer1, ulUSARTActiveBuffer1BytesReceived ); // borra todo el buffer
     vUSARTStartMEMtoMEM( ucUSART1RXBuffer, ucUSARTActiveBuffer1, ulUSART1ByteReceived ); // copia el buffer de entrada
     vUSARTCleanBuffer( ucUSART1RXBuffer, ulUSART1ByteReceived );          // lo limpia
     ulUSARTActiveBuffer1BytesReceived = ulUSART1ByteReceived;             // le pasa el valor
     ulUSART1ByteReceived = 0;                                             // pone a cero el contador
     fUSART1Buffer = CLEAR_TO_WRITE;                                       // indica que esta limpio
     vRF4463MainCommandProcessor( ucUSARTActiveBuffer1 );
}


/*******************************************************************************************************************************************************************************************************
 * End of File
*******************************************************************************************************************************************************************************************************/