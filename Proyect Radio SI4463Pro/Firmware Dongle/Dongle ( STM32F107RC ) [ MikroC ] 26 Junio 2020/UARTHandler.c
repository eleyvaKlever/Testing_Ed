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
 * Global Variables
**********************************************************************************************/

/**********************************************************************************************
 * Local Variables
**********************************************************************************************/
uint16_t usBufferCounter = 0;
uint16_t usPosition = 0;
uint16_t usUARTMessageLength = 0;

uint8_t ucTempByteUART = 0;

uint8_t * pcUARTCommand[] = {
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
    "FIND"
};

/**********************************************************************************************
 * Instances
**********************************************************************************************/
extern RadioParameters_t xRadioParameters;
/**********************************************************************************************
 * IRQ Handlers
**********************************************************************************************/
/*********************************************************************
 * 
*********************************************************************/
void vUARTISR() iv IVT_INT_USART1 ics ICS_AUTO{
    LEDBlue = 1;
    
    if( USART1_SRbits.RXNE == 1 && !USART1_SRbits.PE ){
        ucTempByteUART = USART1_DR;
        if( ucTempByteUART == '\n' ){
            pcRxUARTBuffer[ usUARTMessageLength++ ] = ucTempByteUART;
            ucUARTDataReady = 1;
            ucTempByteUART = 0;
            LEDBlue = 0;
        }
        else{
            pcRxUARTBuffer[ usUARTMessageLength++ ] = ucTempByteUART;
            ucTempByteUART = 0;
        }
    }
    if( USART1_SRbits.ORE == 1 ){
        ucTempByteUART = USART1_SR;
        ucTempByteUART = USART1_DR;
    }
}

/**********************************************************************************************
 * Function declaration
**********************************************************************************************/
/*********************************************************************
 * 
*********************************************************************/
void vUARTTxInit(){
    UART1_Init_Advanced( 115200, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10 );
}

/*********************************************************************
 * 
*********************************************************************/
void vUARTRxInit(){
    USART1_CR1bits.RE       = 1;
    USART1_CR1bits.RXNEIE   = 1;

    NVIC_IntEnable( IVT_INT_USART1 );
}

/*********************************************************************
 * 
*********************************************************************/
void vUARTRxMessage(){
    uint16_t usCounter = 0;

    // UART1_Write_Text( "[ UART Rx ] Packet: " );
    // for( usCounter = 0; usCounter < usUARTMessageLength; usCounter++ ){
    //     UART1_Write( pcRxUARTBuffer[ usCounter ] );
    // }

    STM_LOGV( "[ UART RX ] Packet: %s", pcRxUARTBuffer );

    vUARTCommands( pcRxUARTBuffer );

    memset( pcRxUARTBuffer, '\0', sizeof( pcRxUARTBuffer ) );
    usUARTMessageLength = 0;
}

/*********************************************************************
 * 
*********************************************************************/
void vUARTCommands( uint8_t * pcInBuffer ){
    uint8_t ucCommandCounter = 0;
    uint8_t ucCounter = 0;
    uint8_t ucPosition = 0;
    uint8_t pcTempBuffer[ 50 ];

    uint8_t pcTempTxBuffer[ RF_MAX_BUFFER_LENGTH ];

    uint16_t usTempData = 0;
    uint8_t ucDeviceModel = 0;

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
                    STM_LOGD( "[ UART ] Send Message\r\n", NULL );
                    vRfSettingsHotSwap( CHANNEL_DEFAULT, NETWORK_DEFAULT );
                    memset( pcTempBuffer, '\0', 50 );

                    ucPosition = 5;

                    for( ucCounter = 0; ucCounter < usUARTMessageLength; ucCounter++ ){
                        if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
                            break;
                        }
                        pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
                    }

                    // UART1_Write_Text( pcTempBuffer );

                    ucRemoteNode = NODE_BROADCAST;
                    ucSenderNode = NODE_FACTORY;
                    ucTableIndex = Table_RF_Test;
                    ucCommandIndex = Test_Device_QR;

                    vRfTxMessage( pcTempBuffer, ucCounter );
                    break;
                case UART_CMD_END:
                    STM_LOGD( "[ UART ] End Factory Stage\r\n", NULL );
                    // vRfSettingsHotSwap( CHANNEL_DEFAULT, NETWORK_DEFAULT );

                    memset( pcSentQR, '\0', 15 );

                    ucPosition = 6;

                    for( ucCounter = 0; ucCounter < usUARTMessageLength; ucCounter++ ){
                        if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
                            break;
                        }
                        pcSentQR[ ucCounter ] = pcInBuffer[ ucPosition++ ];
                    }

                    ucRemoteNode = NODE_BROADCAST;
                    ucSenderNode = NODE_FACTORY;
                    ucTableIndex = Table_RF_Test;
                    ucCommandIndex = Test_Device_Ok;

                    vRfTxMessage( pcSentQR, ucCounter );
                    break;
                case UART_CMD_STAGE:
                    STM_LOGD( "[ UART ] Get Stage\r\n", NULL );
                    vRfSettingsHotSwap( CHANNEL_DEFAULT, NETWORK_DEFAULT );

                    ucRemoteNode = NODE_BROADCAST;
                    ucSenderNode = NODE_FACTORY;
                    ucTableIndex = Table_RF_Test;
                    ucCommandIndex = Test_Device_Stage;

                    vRfTxMessage( NULL, NULL );
                    break;
                case UART_CMD_REBOOT:
                    STM_LOGD( "[ UART ] Reboot\r\n", NULL );

                    LEDBlue = 0;
                    LEDGreen = 0;
                    LEDRed = 1;

                    Delay_ms( 1000 );
                    SystemReset();
                    break;
                case UART_CMD_PING:
                    STM_LOGD( "[ UART ] Ping\r\n", NULL );
                    ucRemoteNode = REMOTE_DEFAULT;
                    ucSenderNode = HUB_NODE_DEFAULT;
                    ucTableIndex = Table_RF_Test;
                    ucCommandIndex = Test_PingDevice;

                    vRfTxMessage( NULL, NULL );
                    break;
                case UART_CMD_TEST:
                    STM_LOGD( "[ UART ] Test\r\n", NULL );
                    memset( pcTempBuffer, '\0', 50 );

                    ucPosition = 5;

                    for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
                        pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
                        pcTempQR[ ucCounter ] = pcTempBuffer[ ucCounter ];
                    }

                    for( ucSearchedModelId = 0; ucSearchedModelId < TotalDevicesModel; ucSearchedModelId++ ){
                        if( memcmp( pcTempQR, pcModelQRPrefix[ ucSearchedModelId ], 2 ) == 0 ){
                            break;
                        }
                    }

                    ucRemoteNode = REMOTE_DEFAULT;
                    ucSenderNode = HUB_NODE_DEFAULT;
                    ucTableIndex = Table_RF_Setup;
                    ucCommandIndex = Setup_Qr;

                    vRfTxMessage( pcTempBuffer, strlen( pcTempBuffer ) );
                    break;
                case UART_CMD_REMOVE:
                    STM_LOGD( "[ UART ] Remove\r\n", NULL );

                    memset( pcTempBuffer, '\0', 50 );

                    ucPosition = 7;

                    for( ucCounter = 0; ; ucCounter++ ){
                        if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
                            break;
                        }
                        pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
                    }

                    usTempData = atoi( pcTempBuffer );
                    ucRemoteNode = usTempData;
                    ucSenderNode = HUB_NODE_DEFAULT;
                    ucTableIndex = Table_RF_Setup;
                    ucCommandIndex = Setup_Delete;

                    vRfTxMessage( NULL, NULL );
                    break;
                case UART_CMD_CHANNEL:
                    STM_LOGD( "[ UART ] Set Channel\r\n", NULL );
                    memset( pcTempBuffer, '\0', 50 );

                    ucPosition = 8;

                    for( ucCounter = 0; ; ucCounter++ ){
                        if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
                            break;
                        }
                        pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
                    }

                    ucRf4463EnterStandbyMode();

                    usTempData = atoi( pcTempBuffer );
                    vRfSettingsHotSwap( usTempData, usTempData );
                    break;
                case UART_CMD_INFO:
                    STM_LOGD( "[ UART ] Get Device Info\r\n", NULL );
                    // memset( pcTempBuffer, '\0', 50 );
                    // ucPosition = 5;
                    // for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
                    //     pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
                    //     if( pcInBuffer[ ucPosition ] == '|' || pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
                    //         break;
                    //     }
                    // }

                    // UART1_Write_Text( pcTempBuffer );
                    // UART1_Write( '\r' );
                    // UART1_Write( '\n' );

                    // vXORRFMessage( pcTempBuffer, pcTxRF4463AuxBuffer, 12 );

                    // UART1_Write_Text( pcTxRF4463AuxBuffer );
                    // UART1_Write( '\r' );
                    // UART1_Write( '\n' );

                    ucRemoteNode    = NODE_BROADCAST;
                    ucSenderNode    = HUB_NODE_DEFAULT;
                    ucTableIndex    = Table_RF_Test;
                    ucCommandIndex  = Test_Device_Info;
                    // vRfTxMessage( pcTxRF4463AuxBuffer   , 12 );
                    vRfTxMessage( NULL, NULL );
                    break;
                case UART_CMD_SEARCH:
                    STM_LOGD( "[ UART ] Search\r\n", NULL );
                    ucRemoteNode    = NODE_FACTORY;
                    ucSenderNode    = NODE_FACTORY;
                    ucTableIndex    = Table_RF_Test;
                    ucCommandIndex  = Test_Dongle_Search;
                    vRfTxMessage( NULL, NULL );
                    break;
                case UART_CMD_OVERRIDE:
                    STM_LOGD( "[ UART ] Override\r\n", NULL );
                case UART_CMD_RESET_FTY:
                    STM_LOGD( "[ UART ] Reset Factory\r\n", NULL );
                    break;
                case UART_CMD_OVERRIDE_SET:
                    STM_LOGD( "[ UART ] Set Override\r\n", NULL );
                    break;
                case UART_CMD_DISCOVER:
                    STM_LOGD( "[ UART ] Discover\r\n", NULL );
                    ucRemoteNode = NODE_BROADCAST;
                    ucSenderNode = NODE_FACTORY;
                    ucTableIndex = Table_RF_Setup;
                    ucCommandIndex = Setup_Hard_Discover;

                    vRfTxMessage( NULL, NULL );
                case UART_CMD_FIND:
                    STM_LOGD( "[ UART ] Find in Channel\r\n", NULL );
                    ucRemoteNode = NODE_BROADCAST;
                    ucSenderNode = HUB_NODE_DEFAULT;
                    ucTableIndex = Table_RF_Test;
                    ucCommandIndex = Test_Device_Channel;

                    vRfTxMessage( NULL, NULL );
                    break;
                // default:
                //     UART1_Write_Text( "Invalid Command\r\n" );
            }
        }
    }
}

/*******************************************************************************************************************************************************************************************************
 * End of File
*******************************************************************************************************************************************************************************************************/ 