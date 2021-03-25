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
#include "rf4463handler.h"
/**********************************************************************************************
 * Global Variables
**********************************************************************************************/
/**********************************************************************************************
 * Local Variables
**********************************************************************************************/
static uint8_t ucRF4463IRQ = 0;

uint8_t ucRFTxEventPending  = 0;
uint8_t ucRf4463IRQEvent    = 0;

uint8_t pcRF4463TxBuffer[ RF_MAX_BUFFER_LENGTH ] = { 0x00 };
uint8_t pcRF4463RxBuffer[ RF_MAX_BUFFER_LENGTH ] = { 0x00 };
/**********************************************************************************************
 * Instances
**********************************************************************************************/
/**********************************************************************************************
 * IRQ Handlers
**********************************************************************************************/
/*!
 *  @brief
 * 
 *  @details
 * 
 *  @param  None
 *  @return None
 */
void vISR_EXTI0_Callback() iv IVT_INT_EXTI0 ics ICS_AUTO{
    if( EXTI_PR.B0 == 1 ){
        // STM_LOGV( "[ IRQ ] RF\r\n", NULL );
        EXTI_PR.B0 = 1;
        ucRf4463ClearInterrupts();
        ucRF4463IRQ = 1;
    }
}

/**********************************************************************************************
 * Function declaration
**********************************************************************************************/
/*********************************************************************
 * 
*********************************************************************/
void vRF4463MesageHandler(){
    uint8_t usRxCounter = 0;

    if( ucRFTxEventPending == 0 ){
        // STM_LOGV( "[ RF4463 ] Rx Event\r\n", NULL );
        ucRf4463RxPacket( pcRF4463RxBuffer );
        if( pcRF4463RxBuffer[ RF_MESSAGE_SIZE ] > 0 ){
            #ifdef DEBUG_RF_PACKET
                vUART1_Write_Text( "[ RF4463 Rx ] Packet: " );
                for( usRxCounter = 0; usRxCounter < pcRF4463RxBuffer[ 0 ]; usRxCounter++ ){
                    vUART1_Write( pcRF4463RxBuffer[ usRxCounter ] );
                }
                vUART1_Write( '\r' );
                vUART1_Write( '\n' );
            #endif
        }
    }
    else{
        // STM_LOGV( "[ RF4463 ] Tx Event\r\n", NULL );
        ucRFTxEventPending = 0;
    }
                                                                                                                                                         
    ucRf4463RxInit();
}

/*********************************************************************
 * 
*********************************************************************/
void vRF4463TxMessage( uint8_t * pcOutBuffer, uint8_t ucLength, uint8_t ucRemoteNode ){
    uint8_t ucCounter = 0;
    uint8_t pcTemp[ 7 ];
    /*********************************************************************
     * Check if radio is not used by a pre-existent transmission
    *********************************************************************/
        if( ucRFTxEventPending == 1 ){
            STM_LOGE( "[ RF4463 ] HW in use\r\n", NULL );
            return;
        }
    /*********************************************************************
     * This field can change due to intercommunication from Hub in a 
     * later development
    *********************************************************************/
        vBufferSetToZero( pcRF4463TxBuffer, RF_MAX_BUFFER_LENGTH );
    /*********************************************************************
     * Check if length is lees than the maximum allowed by the Radio
    *********************************************************************/
        if( ( ucLength + RF_MESSAGE_HEADER_SIZE ) >= RF_MAX_BUFFER_LENGTH ){
            STM_LOGE( "[ RF4463 ] Buffer Out of Size\r\n", NULL );
            return;
        }
    /*********************************************************************
     * Insert fields values to header
    *********************************************************************/
        pcRF4463TxBuffer[ RF_MESSAGE_SIZE ]           = RF_MESSAGE_HEADER_SIZE + ucLength;
        pcRF4463TxBuffer[ RF_MESSAGE_DESTINATION ]    = ucRemoteNode;
        pcRF4463TxBuffer[ RF_MESSAGE_SOURCE ]         = NODE_DEFAULT;
    /*********************************************************************
     * Insert additional information to packet
    *********************************************************************/
        if( ucLength > 0 ){
            for( ucCounter = 0; ucCounter < ucLength; ucCounter++ ){
                pcRF4463TxBuffer[ RF_MESSAGE_HEADER_SIZE + ucCounter ] = pcOutBuffer[ ucCounter ];
            }
        }
    /*********************************************************************
     * 
    *********************************************************************/
        #if defined( DEBUG_RF_PACKET )
            vUART1_Write_Text( "[ RF4463 Tx ] Packet: " );
            for( ucCounter = 0; ucCounter < pcRF4463TxBuffer[ RF_MESSAGE_SIZE ]; ucCounter++ ){
                vUART1_Write( pcRF4463TxBuffer[ ucCounter ] );
            }
            vUART1_Write( '\r' );
            vUART1_Write( '\n' );
        #endif
    /*********************************************************************
     * Send message via RF4463
    *********************************************************************/
        ucRf4463TxPacket( pcRF4463TxBuffer, pcRF4463TxBuffer[ RF_MESSAGE_SIZE ] );
        ucRFTxEventPending = 1;
}

/*********************************************************************
 * 
*********************************************************************/
uint8_t ucRF4463Setup( uint8_t ucRxChannel, uint8_t ucTxChannel, uint16_t usNetwork, uint8_t ucTxPower ){
    uint8_t ucRetries = 0;
    uint8_t ucIsRFAvailable = NOT_SUCCESS;
    /********************************************************
     * RF4463 SPI Port Init
    ********************************************************/
        SPI1_Init_Advanced( _SPI_FPCLK_DIV8, _SPI_MASTER | _SPI_8_BIT | _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION | 
                            _SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI1_PB345 );
    /********************************************************
     * RF4463 I/O
    ********************************************************/
        GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_8 ); // GPIO 0
        GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_9 ); // GPIO 1
        GPIO_Digital_Output( &GPIOD_BASE, _GPIO_PINMASK_1 ); // Shutdown Pin
        GPIO_Digital_Output( &GPIOD_BASE, _GPIO_PINMASK_2 ); // nSEL (Chip Select)

        GPIO_Digital_Input( &GPIOD_BASE, _GPIO_PINMASK_0 ); // nIRQ (Interrupt Request Pin)
    /********************************************************
     * IRQ Setup
    ********************************************************/
        /********************************************************
         * Clock Enable
        ********************************************************/
            RCC_APB2ENRbits.SYSCFGEN = 1;
        /********************************************************
         * Pin Configuration
        ********************************************************/
            SYSCFG_EXTICR1  |= 0x0003;
        /********************************************************
         * Interruption Edge Flag
        ********************************************************/
            EXTI_IMR.B0     |= 1;
            EXTI_FTSR.B0    |= 1;
    /********************************************************
     * Send Confiduration to RF4463
    ********************************************************/
        STM_LOGI( "[ RF4463 ] Tx Channel: %d\r\n", ucTxChannel );
        STM_LOGI( "[ RF4463 ] Rx Channel: %d\r\n", ucRxChannel );
        STM_LOGI( "[ RF4463 ] Network: %d\r\n", usNetwork );
        STM_LOGI( "[ RF4463 ] Tx Power: %d\r\n", ucTxPower );
        vRf4463Init( ucRxChannel, ucTxChannel, usNetwork, ucTxPower );
    /********************************************************
     * Check for availability of RF4463
     * TODO: check the configurations have been done and applied
    ********************************************************/
        for( ucRetries = 0; ucRetries < 15; ucRetries++ ){
            if( ucRf4463DeviceAvailability() == SUCCESS ){
                STM_LOGD( "[ RF4663 ] Setup Try: %d Success\r\n", ucRetries );  
                break;
            }
            else{
                STM_LOGE( "[ RF4463 ] Setup Try %d Failed\r\n", ucRetries );
                Delay_ms( 50 );
            }
        }
    /********************************************************
     * Evaluate if the RF4463 has responed
    ********************************************************/
        if( ucRetries == 15 ){
            STM_LOGE( "[ RF4463 ] Setup Retries Excedded\r\n", NULL );
            return NOT_SUCCESS;
        }
    /********************************************************
     * TODO: Insert timeout
    ********************************************************/
        while( ucIsRFAvailable ){
            ucIsRFAvailable = ucRf4463EnterStandbyMode();
        }
    /********************************************************
     * 
    ********************************************************/
        NVIC_IntEnable( IVT_INT_EXTI0 );
        ucRf4463ClearInterrupts();
        ucRf4463RxInit();
        STM_LOGD( "[ RF4463 ] Ready\r\n", NULL );
        return SUCCESS;
}

/**********************************************************************************************
 * Setters and Getters
**********************************************************************************************/
/*********************************************************************
 * 
*********************************************************************/
uint8_t ucRF4463GetIRQFlag(){
    return ucRF4463IRQ;
}

/*********************************************************************
 * 
*********************************************************************/
void vRF4463ResetIRQFlag(){
    ucRF4463IRQ = 0;
}

/*******************************************************************************************************************************************************************************************************
 * End of File
*******************************************************************************************************************************************************************************************************/