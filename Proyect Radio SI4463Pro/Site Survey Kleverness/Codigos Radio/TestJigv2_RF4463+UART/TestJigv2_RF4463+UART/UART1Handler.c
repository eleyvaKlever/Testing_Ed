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
#include "UART1Handler.h"
/**********************************************************************************************
 * Global Variables
**********************************************************************************************/
/**********************************************************************************************
 * Local Variables
**********************************************************************************************/
static uint8_t ucUART1RxIRQFlag = 0;
uint16_t usUART1RxBufferLength = 0;
uint8_t pcUART1RxBuffer[ 256 ];
/**********************************************************************************************
 * Instances
**********************************************************************************************/
/**********************************************************************************************
 * IRQ Handlers
**********************************************************************************************/
/**
 *  @brief
 * 
 *  @param[ in ]  None
 * 
 *  @return None
 */
void vISR_UART1_Callback() iv IVT_INT_USART1 ics ICS_AUTO{
    uint8_t ucByteRead = 0;
    /*********************************************************************
     * 
    *********************************************************************/
        if( USART1_SRbits.ORE == 1 ){
            STM_LOGE( "[ UART ] Overrun Error\r\n", NULL );
            ucByteRead = ( uint8_t )USART1_DR;
        }
    /*********************************************************************
     * 
    *********************************************************************/
        if( USART1_SRbits.RXNE == 1 ){
            ucByteRead = ( uint8_t )USART1_DR;

            if( ucByteRead != '\n' && usUART1RxBufferLength < MAX_UART1_BUFFER_LENGTH ){
                pcUART1RxBuffer[ usUART1RxBufferLength++ ] = ucByteRead;
            }
            else{
                if( pcUART1RxBuffer[ usUART1RxBufferLength - 1 ] == '\r' ){
                    usUART1RxBufferLength -= 1;
                    pcUART1RxBuffer[ usUART1RxBufferLength ] = 0;
                }
                ucUART1RxIRQFlag = 1;
            }
        }
}

/**********************************************************************************************
 * Function declaration
**********************************************************************************************/
/*********************************************************************
 * 
*********************************************************************/
void vUART1MessageHandler(){
    STM_LOGV( "[ UART ] Message: %s\r\n", pcUART1RxBuffer );
    vRF4463TxMessage( pcUART1RxBuffer, usUART1RxBufferLength, NODE_BROADCAST );
    vUART1ResetRxBuffer();
}

/*********************************************************************
 * 
*********************************************************************/
void vUARTTxInit(){
    vUART1_Init_Advanced( 115200, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, _KLGPIO_MODULE_USART1_PB67 );
}

/*********************************************************************
 * 
*********************************************************************/
void vUARTRxInit(){
    USART1_CR1bits.RE = 1;
    USART1_CR1bits.RXNEIE = 1;

    NVIC_IntEnable( IVT_INT_USART1 );
}

/*********************************************************************
 * 
*********************************************************************/
void vUART1_Init_Advanced ( unsigned long ulBaudRate, unsigned int uiDataBits , unsigned int uiParity, unsigned int uiStopBits, unsigned char ucTerminalMap ){
    /*********************************************************************
     * Initialize UART 1 clock
    *********************************************************************/
        RCC_APB2ENRbits.USART1EN = 1;
    /*********************************************************************
     * Activate Transmission and Port
     * Do not activate Reception
    *********************************************************************/
        // USART1_CR1bits.RE = 1;
        USART1_CR1bits.TE = 1;
        USART1_CR1bits.UE = 1;
    /*********************************************************************
     * Baud Rate basic implementation @ 115200
    *********************************************************************/
        if( ulBaudRate == 115200 ){
            USART1_BRRbits.DIV_Fraction = 0x09;
            USART1_BRRbits.DIV_Mantissa = 0x02D;
        }
    /*********************************************************************
     * Baud Rate basic implementation @ 921600
    *********************************************************************/
        else if ( ulBaudRate == 921600 ) {
            USART1_BRRbits.DIV_Fraction = 0x0B;
            USART1_BRRbits.DIV_Mantissa = 0x005;
        }
    /*********************************************************************
     * Add Parity and Stop Bits Configuration
    *********************************************************************/
        USART1_CR1 |= uiParity | uiDataBits;
        USART1_CR2 |= uiStopBits;
    /*********************************************************************
     * Configure I/O
    *********************************************************************/
        switch ( ucTerminalMap ) {
            /*********************************************************************
             * Predefined pinout
            *********************************************************************/
                case _KLGPIO_MODULE_USART1_PA9_10: 
                    RCC_AHB1ENRbits.GPIOAEN     = 1;      // GPIOA Enabled
                    GPIOA_MODERbits.MODER10     = 2;      // Altern Function
                    GPIOA_OTYPERbits.OT10       = 0;      // push pull
                    GPIOA_OSPEEDRbits.OSPEEDR10 = 3;      // high Speed
                    GPIOA_PUPDRbits.PUPDR10     = 0;      // no PU or PD
                    GPIOA_AFRHbits.AFRH10       = 7;      // AF7

                    GPIOA_MODERbits.MODER9      = 2;      // Altern Function
                    GPIOA_OTYPERbits.OT9        = 0;      // push pull
                    GPIOA_OSPEEDRbits.OSPEEDR9  = 3;      // high Speed
                    GPIOA_PUPDRbits.PUPDR9      = 0;      // no PU or PD
                    GPIOA_AFRHbits.AFRH9        = 7;      // AF7
                    break;
            /*********************************************************************
             * Hub Debug I/O
            *********************************************************************/            
                case _KLGPIO_MODULE_USART1_PB67:   
                    RCC_AHB1ENRbits.GPIOBEN     = 1;      // GPIOB Enabled
                    GPIOB_MODERbits.MODER6      = 2;      // Altern Function
                    GPIOB_OTYPERbits.OT6        = 0;      // push pull
                    GPIOB_OSPEEDRbits.OSPEEDR6  = 3;      // high Speed
                    GPIOB_PUPDRbits.PUPDR6      = 0;      // no PU or PD
                    GPIOB_AFRLbits.AFRL6        = 7;      // AF7

                    GPIOB_MODERbits.MODER7      = 2;      // Altern Function
                    GPIOB_OTYPERbits.OT7        = 0;      // push pull
                    GPIOB_OSPEEDRbits.OSPEEDR7  = 3;      // high Speed
                    GPIOB_PUPDRbits.PUPDR7      = 0;      // no PU or PD
                    GPIOB_AFRLbits.AFRL7        = 7;      // AF7
                    break;
        }
}

/*********************************************************************
 * Non-blocking function to use when the hardware has not been enabled
*********************************************************************/
void vUART1_Write( unsigned char pcByte ){
    USART1_DR = pcByte;
    if ( USART1_CR1bits.UE ) {
    while ( !USART1_SRbits.TXE );
    }
}

/*********************************************************************
 * Non-blocking function to use when the hardware has not been enabled
*********************************************************************/
void vUART1_Write_Text( unsigned char *pcBuffer ){
    unsigned char ucCounter       = 0;
    unsigned char ucBufferSize    = 0;

    ucBufferSize = strlen( pcBuffer );

    for ( ucCounter = 0; ucCounter < ucBufferSize; ucCounter++ ){
        USART1_DR = pcBuffer[ ucCounter ];
        if ( USART1_CR1bits.UE ) {
        while ( !USART1_SRbits.TXE );
        }
    }
}

/**********************************************************************************************
 * Setters and Getters
**********************************************************************************************/
/*********************************************************************
 * 
*********************************************************************/
uint8_t ucUART1MessageReady(){
    return ucUART1RxIRQFlag;
}

/*********************************************************************
 * 
*********************************************************************/
void vUART1ResetIRQFlag(){
    ucUART1RxIRQFlag = 0;
}

/*********************************************************************
 * 
*********************************************************************/
void vUART1ResetRxBuffer(){
    for( usUART1RxBufferLength = 0; usUART1RxBufferLength < 256; usUART1RxBufferLength++ ){
        pcUART1RxBuffer[ usUART1RxBufferLength ] = 0;
    }
    usUART1RxBufferLength = 0;
}

/*******************************************************************************************************************************************************************************************************
 * End of File
*******************************************************************************************************************************************************************************************************/