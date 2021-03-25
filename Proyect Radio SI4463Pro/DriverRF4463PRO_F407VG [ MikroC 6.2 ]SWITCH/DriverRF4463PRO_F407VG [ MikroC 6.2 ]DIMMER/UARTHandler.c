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
/*
void DMA2Strm7_interrupt() iv IVT_INT_DMA2_Stream7 ics ICS_AUTO {

     if ( DMA2_HISRbits.FEIF7 ) {
        DMA2_HIFCRbits.CFEIF7 = 1;
     }
     else if ( DMA2_HISRbits.DMEIF7 ) {
          DMA2_HIFCRbits.CDMEIF7 = 1;
     }
     else if ( DMA2_HISRbits.TEIF7 ) {     // TRANSFER ERROR INTERRUPT FLAG
          DMA2_HIFCRbits.CTEIF7 = 1;       // limpia el flag de error
          //flag_TX_Error = 1;             // indica que hubo error al transmitir
     }
     else if ( DMA2_HISRbits.HTIF7 ) {
          DMA2_HIFCRbits.CHTIF7 = 1;
     }
     else if ( DMA2_HISRbits.TCIF7 ) {     // TRANSFER COMPLETE INTERRUPT FLAG = envio el frame completo
          DMA2_HIFCRbits.CTCIF7 = 1;       // limpia TODOS LOS FLAGS DE DMA2 CANAL 2
          DMA2_S7CRbits.EN = 0;            // EXPERIMENTAL PARA CAMBIAR EL VALOR DEL CONTADOR
          //flag_TX_Completada  = 1;       // indica que termino de transmitir
     }
}
*/

/*********************************************************************
 * 
*********************************************************************/
void vUARTISR() iv IVT_INT_USART1 ics ICS_AUTO{

    if( USART1_ISRbits.RXNE ){
        ucData1 = USART1_RDR;
        if ( ucData1 != CHR_CR && ucData1 != CHR_LF && ulUSART1ByteReceived < BUFFER_MAX_USART ) {
           // Espera por encabezado valido
           if ( ( ucData1 == CHR_S ||
                  ucData1 == CHR_s ||
                  ucData1 == CHR_U ||
                  ucData1 == CHR_u ) &&
                ulUSART1ByteReceived == 0 ) {
              ucUSART1RXBuffer[ ulUSART1ByteReceived++ ] = ucData1;
           }
           // Guarda caracteres siempre y cuando el primero de ellos sea valido
           else if ( ucUSART1RXBuffer[ 0 ] == CHR_S ||
                     ucUSART1RXBuffer[ 0 ] == CHR_s ||
                     ucUSART1RXBuffer[ 0 ] == CHR_U ||
                     ucUSART1RXBuffer[ 0 ] == CHR_u ) {
                ucUSART1RXBuffer[ ulUSART1ByteReceived++ ] = ucData1;
           }
        }
        // si es un caracter de control...
        else if ( ucData1 == CHR_CR ) {
             ucUSART1RXBuffer[ ulUSART1ByteReceived++ ] = ucData1;
        }
        // si es un segundo caracter de control manda bandera
        else if ( ucData1 == CHR_LF && ucUSART1RXBuffer[ ulUSART1ByteReceived - 1 ] == CHR_CR ) {
             ucUSART1RXBuffer[ ulUSART1ByteReceived++ ] = ucData1;
             fUSART1Buffer = READY_TO_READ;
        }
    }
}


//===========================================================================================================
// Funciones de configuracion:
// Para depuracion / PC comm
void vUSARTConfigUSART1 ( unsigned long ulBaudRate ) {

UART1_Init_Advanced( ulBaudRate, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10 );
USART1_CR1bits.UE = 0;

ulClk = Clock_MHz() * 1000000;         // paso extra para verificacion en depuracion
/*
USART1_BRR = ( ulClk ) / ulBaudRate;
                      */
USART1_CR1bits.UE = 1;

}




/*********************************************************************
 * 
*********************************************************************/
void vUARTRxMessage(){
    unsigned int usCounter = 0;

    // UART1_Write_Text( "[ UART Rx ] Packet: " );
    // for( usCounter = 0; usCounter < usUARTMessageLength; usCounter++ ){
    //     UART1_Write( pcRxUARTBuffer[ usCounter ] );
    // }

    STM_LOGV( "[ UART RX ] Packet: %s", pcRxUARTBuffer );

    //vUARTCommands( pcRxUARTBuffer );

    //memset( pcRxUARTBuffer, '\0', sizeof( pcRxUARTBuffer ) );
    usUARTMessageLength = 0;
}


/*******************************************************************************************************************************************************************************************************
 * End of File
*******************************************************************************************************************************************************************************************************/ 