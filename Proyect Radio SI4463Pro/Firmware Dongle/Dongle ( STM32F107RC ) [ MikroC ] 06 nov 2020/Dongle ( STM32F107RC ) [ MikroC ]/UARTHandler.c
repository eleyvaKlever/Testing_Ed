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
uint8_t pcTxUARTBuffer[ UART_MAX_BUFFER_LENGTH ];
uint8_t pcRxUARTBuffer[ UART_MAX_BUFFER_LENGTH ];

uint8_t pcTxRF4463AuxBuffer[ RF_MAX_BUFFER_LENGTH ];
uint8_t pcRxRF4463AuxBuffer[ RF_MAX_BUFFER_LENGTH ];

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
    "FIND",
    "SEND_UNBLOCK",
    "SETPOWER",
    "RF"
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
    LEDBlue =~ LEDBlue;
    
    if( USART1_SRbits.RXNE == 1 ){
        ucTempByteUART = USART1_DR;
        if( ucTempByteUART == '\n' ){
            pcRxUARTBuffer[ usUARTMessageLength++ ] = ucTempByteUART;
            ucUARTDataReady = 1;
            ucTempByteUART = 0;
            LEDBlue = PIN_LEVEL_LOW;
        }
        else{
            pcRxUARTBuffer[ usUARTMessageLength++ ] = ucTempByteUART;
            ucTempByteUART = 0;
        }
    }
    if( USART1_SRbits.ORE == 1 ){
        STM_LOGE( "[ IRQ ] UART Overrun\r\n", NULL );
        ucTempByteUART = USART1_SR;
        ucTempByteUART = USART1_DR;
        LEDBlue = PIN_LEVEL_LOW;
    }
}

/**********************************************************************************************
 * Function declaration
**********************************************************************************************/
/*********************************************************************
 * 
*********************************************************************/
void vUARTTxInit(){
    UART1_Init_Advanced( 921600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10 );
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

    uint16_t usTempChannel = 0;
    uint16_t usTempNetwork = 0;
    uint8_t ucIgnoreNetwork = 0;

    uint16_t usTempNode = 0;
    uint16_t usTempDestination = 0;
    uint16_t usTempTable = 0;
    uint16_t usTempCommand = 0;
    uint8_t ucTempBufferLength = 0;

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
                    // vRf4463SetChannels( RF4463_DEFAULT_CHANNEL, RF4463_DEFAULT_CHANNEL );
                    // vRf4463SetNetwork( RF4463_DEFAULT_NETWORK );
                    memset( pcTempBuffer, '\0', 50 );
                    
                    ucPosition = 5;
                    for( ucCounter = 0; ucCounter < usUARTMessageLength; ucCounter++ ){
                        if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
                            break;
                        }
                        pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
                    }
                    vRF4463SetNode( NODE_FACTORY );
                    vRF4463TxMessage( pcTempBuffer, ucCounter, NODE_BROADCAST, TABLE_RF_TEST, RF_TEST_QR );
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

                    vRF4463SetNode( NODE_FACTORY );
                    vRF4463TxMessage( pcSentQR, ucCounter, NODE_BROADCAST, TABLE_RF_TEST, RF_TEST_OK );
                    break;
                case UART_CMD_STAGE:
                    STM_LOGD( "[ UART ] Get Stage\r\n", NULL );

                    vRf4463SetChannels( RF4463_DEFAULT_CHANNEL, RF4463_DEFAULT_CHANNEL );
                    vRf4463SetNetwork( RF4463_DEFAULT_NETWORK );
                    vRF4463SetNode( NODE_FACTORY );

                    vRF4463TxMessage( NULL, NULL, NODE_BROADCAST, TABLE_RF_TEST, RF_TEST_STAGE );
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
                    vRF4463SetNode( HUB_NODE );
                    vRF4463TxMessage( NULL, NULL, REMOTE_DEFAULT, TABLE_RF_TEST, RF_TEST_DEVICE_PING );
                    break;
                case UART_CMD_TEST:
                    STM_LOGD( "[ UART ] Test\r\n", NULL );
                    memset( pcTempBuffer, '\0', 50 );

                    ucPosition = 5;

                    for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
                        pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
                        pcTempQR[ ucCounter ] = pcTempBuffer[ ucCounter ];
                    }

                    for( ucSearchedModelId = 0; ucSearchedModelId < DEVICE_MODEL_ID_TOTAL; ucSearchedModelId++ ){
                        if( memcmp( pcTempQR, pcModelQRPrefix[ ucSearchedModelId ], 2 ) == 0 ){
                            break;
                        }
                    }

                    vRF4463SetNode( HUB_NODE );
                    vRF4463TxMessage( pcTempBuffer, strlen( pcTempBuffer ), REMOTE_DEFAULT, TABLE_RF_SETUP, RF_SETUP_FIND_BY_QR );
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
                    vRF4463SetNode( HUB_NODE );
                    vRF4463TxMessage( NULL, NULL, usTempData, TABLE_RF_SETUP, RF_SETUP_REMOVE );
                    break;
                case UART_CMD_CHANNEL:
                    STM_LOGD( "[ UART ] Set Channel\r\n", NULL );
                    memset( pcTempBuffer, '\0', 50 );

                    ucPosition = 8;

                    ucRf4463EnterStandbyMode();

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

                        vRf4463SetChannels( usTempChannel, usTempChannel );
                        vRf4463SetNetwork( usTempNetwork );
                    }
                    else{
                        vRf4463SetChannels( usTempChannel, usTempChannel );
                        vRf4463SetNetwork( usTempChannel );
                    }
                    ucRf4463RxInit();
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

                    // ucRemoteNode    = NODE_BROADCAST;
                    // ucSenderNode    = HUB_NODE_DEFAULT;
                    // ucTableIndex    = Table_RF_Test;
                    // ucCommandIndex  = Test_Device_Info;
                    // vRF4463TxMessage( pcTxRF4463AuxBuffer   , 12 );
                    // vRF4463TxMessage( NULL, NULL );
                    break;
                case UART_CMD_SEARCH:
                    STM_LOGD( "[ UART ] Search\r\n", NULL );
                    vRF4463SetNode( NODE_FACTORY );
                    vRF4463TxMessage( NULL, NULL, NODE_FACTORY, TABLE_RF_TEST, RF_TEST_DONGLE_SEARCH ); 
                    break;
                case UART_CMD_OVERRIDE:
                    STM_LOGD( "[ UART ] Override\r\n", NULL );
                    break;
                case UART_CMD_RESET_FTY:
                    STM_LOGD( "[ UART ] Reset Factory\r\n", NULL );
                    break;
                case UART_CMD_OVERRIDE_SET:
                    STM_LOGD( "[ UART ] Set Override\r\n", NULL );
                    break;
                case UART_CMD_DISCOVER:
                    STM_LOGD( "[ UART ] Discover\r\n", NULL );
                    vRF4463SetNode( NODE_FACTORY );
                    vRF4463TxMessage( NULL, NULL, NODE_BROADCAST, TABLE_RF_SETUP, RF_SETUP_FTY_DISCOVER );
                case UART_CMD_FIND:
                    STM_LOGD( "[ UART ] Find in Channel\r\n", NULL );
                    vRF4463SetNode( HUB_NODE );
                    vRF4463TxMessage( NULL, NULL, NODE_BROADCAST, TABLE_RF_TEST, RF_TEST_CHANNEL );
                    break;
                case UART_CMD_UNBLOCK:
                    break;
                case UART_CMD_SET_TX_POWER:
                    STM_LOGI( "[ UART ] Set Tx Power\r\n", NULL );
                    memset( pcTempBuffer, '\0', 20 );
                    ucPosition = 9;
                    for( ucCounter = 0; ; ucCounter++ ){
                        if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
                            break;
                        }
                        pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
                    }
                    usTempData = atoi( pcTempBuffer );
                    ucRf4463SetTxPower( usTempData );
                    break;
                case UART_CMD_SEND_RF_MESSAGE:
                    STM_LOGI( "[ UART ] Send RF Message\r\n", NULL );
                    ucPosition = strlen( pcUARTCommand[ UART_CMD_SEND_RF_MESSAGE ] ) + 1;
                    STM_LOGI( "[ UART ] Position: %d\r\n", ucPosition );
                    /*********************************************************************
                     * Get destination node 
                    *********************************************************************/
                        vBufferSetToZero( pcTempBuffer, 50 );
                        for( ucCounter = 0; ; ucCounter++ ){
                            if( pcInBuffer[ ucPosition ] == '|' ){
                                ucPosition++;
                                break;
                            }
                            if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
                                STM_LOGE( "[ UART:%ld ] Invalid parameters\r\n", __LINE__ );
                                return;
                            }
                            pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
                        }
                        usTempDestination = atoi( pcTempBuffer );
                        STM_LOGV( "[ UART ] RF Node: %d\r\n", usTempDestination );
                    /*********************************************************************
                     * Get destination node 
                    *********************************************************************/
                        vBufferSetToZero( pcTempBuffer, 50 );
                        for( ucCounter = 0; ; ucCounter++ ){
                            if( pcInBuffer[ ucPosition ] == '|' ){
                                ucPosition++;
                                break;
                            }
                            if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
                                STM_LOGE( "[ UART:%ld ] Invalid parameters\r\n", __LINE__ );
                                return;
                            }
                            pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
                        }
                        usTempNode = atoi( pcTempBuffer );
                        STM_LOGV( "[ UART ] RF Node: %d\r\n", usTempNode );
                    /*********************************************************************
                     * Get table
                    *********************************************************************/
                        vBufferSetToZero( pcTempBuffer, 50 );
                        for( ucCounter = 0; ; ucCounter++ ){
                            if( pcInBuffer[ ucPosition ] == '|' ){
                                ucPosition++;
                                break;
                            }
                            if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
                                STM_LOGE( "[ UART:%ld ] Invalid parameters\r\n", __LINE__ );
                                return;
                            }
                            pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
                        }
                        usTempTable = atoi( pcTempBuffer );
                        STM_LOGV( "[ UART ] RF Table: %d\r\n", usTempTable );
                    /*********************************************************************
                     * Get command
                    *********************************************************************/
                        vBufferSetToZero( pcTempBuffer, 50 );
                        for( ucCounter = 0; ; ucCounter++ ){
                            if( pcInBuffer[ ucPosition ] == '|' ){
                                ucPosition++;   
                                break;
                            }
                            if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
                                STM_LOGV( "[ UART ] Found end of command\r\n", NULL );
                                break;
                            }
                            pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
                        }
                        usTempCommand = atoi( pcTempBuffer );
                        STM_LOGV( "[ UART ] RF Command: %d\r\n", usTempCommand );
                    /*********************************************************************
                     * Get Buffer
                    *********************************************************************/
                        vBufferSetToZero( pcTempBuffer, 50 );
                        for( ucTempBufferLength = 0; ; ucTempBufferLength++ ){
                            if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' || pcInBuffer[ ucPosition ] == '\0' ){
                                STM_LOGE( "[ UART ] No buffer to send\r\n", NULL );
                                break;
                            }
                            pcTempBuffer[ ucTempBufferLength ] = pcInBuffer[ ucPosition++ ];
                        }
                    /*********************************************************************
                     * 
                    *********************************************************************/
                        vRF4463SetNode( usTempNode );
                        vRF4463TxMessage( pcTempBuffer, ucTempBufferLength, usTempDestination, usTempTable, usTempCommand );
                    break;
                default:
                    STM_LOGE( "Invalid Command\r\n", NULL );
                    break;
            }
        }
    }
}

/*******************************************************************************************************************************************************************************************************
 * End of File
*******************************************************************************************************************************************************************************************************/ 