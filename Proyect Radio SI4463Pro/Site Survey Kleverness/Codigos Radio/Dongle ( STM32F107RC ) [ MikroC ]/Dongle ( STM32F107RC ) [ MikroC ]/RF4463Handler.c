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
#include "RF4463Handler.h"
/**********************************************************************************************
 * Global Variables
**********************************************************************************************/

/**********************************************************************************************
 * Local Variables
**********************************************************************************************/
static uint8_t ucRF4463IRQ = 0;

uint8_t ucSourceNode = 0;
uint8_t ucRFTxEventPending  = 0;

uint8_t pcRF4463TxBuffer[ RF_MAX_BUFFER_LENGTH ] = { 0x00 };
uint8_t pcRF4463RxBuffer[ RF_MAX_BUFFER_LENGTH ] = { 0x00 };
/**********************************************************************************************
 * Instances
**********************************************************************************************/
RadioParameters_t xRadioParameters;

/**********************************************************************************************
 * IRQ Handlers
**********************************************************************************************/
/*********************************************************************
 * 
*********************************************************************/
void RFISR() iv IVT_INT_EXTI15_10 ics ICS_AUTO{
    if( EXTI_PR.B12 ){
        EXTI_PR.B12 |= 1;
        LEDRed = On;
        ucRF4463IRQ = 1;
        ucRf4463ClearInterrupts();
    }
}

/**********************************************************************************************
 * Function declaration
**********************************************************************************************/
/*********************************************************************
 * 
*********************************************************************/
void vRF4463MesageHandler(){
    uint16_t usCounter = 0;

    if( ucRFTxEventPending == 0 ){
        // STM_LOGV( "[ RF4463 ] Rx Event\r\n", NULL );
        vBufferSetToZero( pcRF4463RxBuffer, RF_MAX_BUFFER_LENGTH );
        ucRf4463RxPacket( pcRF4463RxBuffer );
        if( pcRF4463RxBuffer[ RF_MESSAGE_SIZE ] > 0 ){
            /*********************************************************************
             * 
            *********************************************************************/
                if( xRF4463GetLastRSSI() <= RSSI_BAD_THRESHOLD ){
                    STM_LOGE( "[ RF4463 ] Message may be broken\r\n", NULL );
                }
            /*********************************************************************
             * 
            *********************************************************************/
                #ifdef ENABLE_DEBUG_RF_PACKET
                    UART1_Write_Text( "[ RF4463 Rx ] Packet: " );            
                    for( usCounter = 0; usCounter < pcRF4463RxBuffer[ RF_MESSAGE_SIZE ]; usCounter++ ){
                        UART1_Write( pcRF4463RxBuffer[ usCounter ] );
                    }
                    UART1_Write( '\r' );
                    UART1_Write( '\n' );
                #endif
            /*********************************************************************
             * 
            *********************************************************************/
                #ifdef FACTORY_DONGLE
                    vRF4463RxFTY();
                #endif
            /*********************************************************************
             * 
            *********************************************************************/
                #ifdef PARSE_RF4463_RX
                    vRF4463RxCommand();
                #endif
        }
    }
    else{
        // STM_LOGV( "[ RF4463 ] Tx Event\r\n", NULL );
        ucRFTxEventPending = 0;
    }

    LEDRed = Off;

    ucRf4463RxInit();
}

/*********************************************************************
 * Transmission Function
*********************************************************************/
void vRF4463TxMessage( uint8_t * pcOutBuffer, uint8_t ucLength, uint8_t ucRemoteNode, uint8_t ucTable, uint8_t ucCommand ){
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
        pcRF4463TxBuffer[ RF_MESSAGE_SIZE ]             = RF_MESSAGE_HEADER_SIZE + ucLength;
        pcRF4463TxBuffer[ RF_MESSAGE_DESTINATION ]      = ucRemoteNode;
        pcRF4463TxBuffer[ RF_MESSAGE_SOURCE ]           = ucSourceNode;
        pcRF4463TxBuffer[ RF_MESSAGE_TABLE ]            = ucTable;
        pcRF4463TxBuffer[ RF_MESSAGE_COMMAND ]          = ucCommand;
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
void vRF4463SetNode( uint8_t ucNode ){
    ucSourceNode = ucNode;
}

/*********************************************************************
 * 
*********************************************************************/
uint8_t ucRF4463Setup( uint8_t ucRxChannel, uint8_t ucTxChannel, uint16_t usNetwork, uint8_t ucTxPower ){
    uint8_t ucRetries = 0;
    int8_t ucIsRFAvailable = NOT_SUCCESS;
    /*********************************************************************
     * RF4463Pro Bus Init
    *********************************************************************/
    SPI2_Init_Advanced( _SPI_FPCLK_DIV8, _SPI_MASTER | _SPI_8_BIT | _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION | _SPI_MSB_FIRST | 
                        _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI2_PB13_14_15 );

    /*********************************************************************
     * RF4463Pro I/O Setup
    *********************************************************************/
    GPIO_Digital_Input( &GPIOC_BASE, _GPIO_PINMASK_12 );

    GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_12 );
    GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_11 );
    GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_11 );
    GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_10 );
    /********************************************************
     * Config Bits for IRQ pin
    ********************************************************/
        /********************************************************
         * Clock Enable
        ********************************************************/
            RCC_APB2ENRbits.AFIOEN = 1;
        /********************************************************
         * Pin Configuration
        ********************************************************/
            AFIO_EXTICR4  |= 0x0002;
        /********************************************************
         * Interruption Edge Flag
        ********************************************************/
            EXTI_IMR.B12    |= 1;
            EXTI_FTSR.B12   |= 1;
    /**********************************************************************************************
     * 
    **********************************************************************************************/
        STM_LOGV( "[ RF4463 ] Parameters\r\n", NULL );
        STM_LOGI( "[ RF4463 ] Tx Channel: %d\r\n", ucTxChannel );
        STM_LOGI( "[ RF4463 ] Rx Channel: %d\r\n", ucRxChannel );
        STM_LOGI( "[ RF4463 ] Network: %d\r\n", usNetwork );
        STM_LOGI( "[ RF4463 ] Tx Power: %d\r\n", ucTxPower );
    /********************************************************
     * RF4463 Initial Configuration
    ********************************************************/
        vRf4463Init( ucRxChannel, ucTxChannel, usNetwork, ucTxPower, RF4463_FREQUENCY_915MHz );
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
            // return NOT_SUCCESS;
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
        NVIC_IntEnable( IVT_INT_EXTI15_10 );
        ucRf4463ClearInterrupts();
        ucRf4463RxInit();
        STM_LOGD( "[ RF4463 ] Ready\r\n", NULL );
}

/**********************************************************************************************
 * 
**********************************************************************************************/
/*********************************************************************
 * 
*********************************************************************/
void vRF4463RxCommand(){
    uint8_t ucCounter = 0;
    uint8_t ucPosition = RF_MESSAGE_CONTENT;

    uint8_t pcTempBuffer[ RF_MAX_BUFFER_LENGTH ] = { 0x00 };

    uint8_t pcQR[ 13 ]      = { 0x00 };
    uint8_t pcUIDText[ 25 ] = { 0x00 };
    uint8_t pcUIDHex[ 13 ]  = { 0x00 };
    /*********************************************************************
     * 
    *********************************************************************/
        switch( pcRF4463RxBuffer[ RF_MESSAGE_TABLE ] ){
            /*********************************************************************
             * 
            *********************************************************************/
                case TABLE_RF_TEST:
                    STM_LOGI( "[ RF4463 ] Test Table\r\n", NULL );
                    switch( pcRF4463RxBuffer[ RF_MESSAGE_COMMAND ] ){
                        case RF_TEST_STATUS:
                            STM_LOGI( "[ RF4463 ] Status Command\r\n", NULL );
                            break;
                        default:
                            STM_LOGE( "[ RF4463 ] Unhandled command\r\n", NULL );
                            return;
                    }
                    break;
            /*********************************************************************
             * 
            *********************************************************************/
                case TABLE_RF_SETUP:
                    STM_LOGI( "[ RF4463 ] Setup Table\r\n", NULL );
                    switch( pcRF4463RxBuffer[ RF_MESSAGE_COMMAND ] ){
                        case RF_SETUP_FIND_BY_QR:
                            if( pcRF4463RxBuffer[ RF_MESSAGE_SOURCE ] == HUB_NODE ){
                                STM_LOGI( "[ RF4463 ] Hub Request\r\n", NULL );
                                for( ucCounter = 0; ucCounter < DEVICE_QR_FIELD_LENGTH; ucCounter++ ){
                                    pcQR[ ucCounter ] = pcRF4463RxBuffer[ ucPosition++ ];
                                }
                                STM_LOGV( "[ RF4463 ] Request QR: %s\r\n", pcQR );
                            }
                            else if( pcRF4463RxBuffer[ RF_MESSAGE_SOURCE ] == REMOTE_DEFAULT ){
                                STM_LOGI( "[ RF4463 ] Device Response\r\n", NULL );
                                for( ucCounter = 0; ucCounter < DEVICE_ID_HEX_FIELD_LENGTH; ucCounter++ ){
                                    pcUIDHex[ ucCounter ] = pcRF4463RxBuffer[ ucPosition++ ];
                                }
                                vHexToASCII( pcUIDText, pcUIDHex, DEVICE_ID_HEX_FIELD_LENGTH );
                                STM_LOGV( "[ RF4463 ] UID: %s\r\n", pcUIDText );
                                if( pcRF4463RxBuffer[ RF_MESSAGE_SIZE ] == RF_CONFIG_DEVICE_SWITCH_MESSAGE_SIZE ){
                                    STM_LOGV( "[ RF4463 ] Detected Loads: %d\r\n", pcRF4463RxBuffer[ RF_CONFIG_DEVICE_POSITION_LOADS ] );
                                    STM_LOGV( "[ RF4463 ] Load 1: %d\r\n", pcRF4463RxBuffer[ RF_CONFIG_DEVICE_POSITION_SWITCH_LOAD1 ] );
                                    STM_LOGV( "[ RF4463 ] Load 2: %d\r\n", pcRF4463RxBuffer[ RF_CONFIG_DEVICE_POSITION_SWITCH_LOAD2 ] );
                                    STM_LOGV( "[ RF4463 ] Load 3: %d\r\n", pcRF4463RxBuffer[ RF_CONFIG_DEVICE_POSITION_SWITCH_LOAD3 ] );
                                    STM_LOGV( "[ RF4463 ] Version: %d.%d.%d\r\n", pcRF4463RxBuffer[ RF_CONFIG_DEVICE_POSITION_SWITCH_VERSION_MAJOR ], pcRF4463RxBuffer[ RF_CONFIG_DEVICE_POSITION_SWITCH_VERSION_MINOR ], pcRF4463RxBuffer[ RF_CONFIG_DEVICE_POSITION_SWITCH_VERSION_BUILD ] );
                                }
                                else{
                                    STM_LOGV( "[ RF4463 ] Load Status: %d\r\n", pcRF4463RxBuffer[ RF_CONFIG_DEVICE_LOAD_STATUS ] );
                                    STM_LOGV( "[ RF4463 ] Version: %d.%d.%d\r\n", pcRF4463RxBuffer[ RF_CONFIG_DEVICE_POSITION_VERSION_MAJOR ], pcRF4463RxBuffer[ RF_CONFIG_DEVICE_POSITION_VERSION_MINOR ], pcRF4463RxBuffer[ RF_CONFIG_DEVICE_POSITION_VERSION_BUILD ] );
                                }
                            }
                            break;
                        default:
                            STM_LOGE( "[ RF4463 ] Unhandled command\r\n", NULL );
                            return;
                    }
                    break;
            /*********************************************************************
             * 
            *********************************************************************/
                case TABLE_RF_OTA:
                    STM_LOGI( "[ RF4463 ] OTA Table\r\n", NULL );
                    switch( pcRF4463RxBuffer[ RF_MESSAGE_COMMAND ] ){
                        default:
                            STM_LOGE( "[ RF4463 ] Unhandled command\r\n", NULL );
                            return;
                    }
                    break;
            /*********************************************************************
             * 
            *********************************************************************/
                case TABLE_RF_GLOBAL:
                    STM_LOGI( "[ RF4463 ] Global Table\r\n", NULL );
                    /*********************************************************************
                     * 
                    *********************************************************************/
                        #ifdef RF4463_MESSAGE_IGNORE_HUB
                            if( pcRF4463RxBuffer[ RF_MESSAGE_SOURCE ] == HUB_NODE ){
                                STM_LOGE( "[ RF4463 ] Hub node request\r\n", NULL );
                                return;
                            }
                        #endif
                    /*********************************************************************
                     * 
                    *********************************************************************/
                        switch( pcRF4463RxBuffer[ RF_MESSAGE_COMMAND ] ){
                            default:
                                STM_LOGE( "[ RF4463 ] Unhandled command\r\n", NULL );
                                return;
                        }
                    break;
            /*********************************************************************
             * 
            *********************************************************************/
                case TABLE_RF_SWITCH:
                    STM_LOGI( "[ RF4463 ] Switch Table\r\n", NULL );
                    /*********************************************************************
                     * 
                    *********************************************************************/
                        #ifdef RF4463_MESSAGE_IGNORE_HUB
                            if( pcRF4463RxBuffer[ RF_MESSAGE_SOURCE ] == HUB_NODE ){
                                STM_LOGE( "[ RF4463 ] Hub node request\r\n", NULL );
                                return;
                            }
                        #endif
                    /*********************************************************************
                     * 
                    *********************************************************************/
                        STM_LOGI( "[ RF4463 ] Node: %d\r\n", pcRF4463RxBuffer[ RF_MESSAGE_SOURCE ] );
                        switch( pcRF4463RxBuffer[ RF_MESSAGE_COMMAND ] ){
                            default:
                                STM_LOGE( "[ RF4463 ] Unhandled command\r\n", NULL );
                                return;
                        }
                    break;
            /*********************************************************************
             * 
            *********************************************************************/
                case TABLE_RF_DIMMER:
                    STM_LOGI( "[ RF4463 ] Dimmer Table\r\n", NULL );
                    /*********************************************************************
                     * 
                    *********************************************************************/
                        #ifdef RF4463_MESSAGE_IGNORE_HUB
                            if( pcRF4463RxBuffer[ RF_MESSAGE_SOURCE ] == HUB_NODE ){
                                STM_LOGE( "[ RF4463 ] Hub node request\r\n", NULL );
                                return;
                            }
                        #endif
                    /*********************************************************************
                     * 
                    *********************************************************************/
                        switch( pcRF4463RxBuffer[ RF_MESSAGE_COMMAND ] ){
                            default:
                                STM_LOGE( "[ RF4463 ] Unhandled command\r\n", NULL );
                                return;
                        }
                    break;
            /*********************************************************************
             * 
            *********************************************************************/
                case TABLE_RF_OUTLET:
                    STM_LOGI( "[ RF4463 ] Outlet Table\r\n", NULL );
                    /*********************************************************************
                     * 
                    *********************************************************************/
                        #ifdef RF4463_MESSAGE_IGNORE_HUB
                            if( pcRF4463RxBuffer[ RF_MESSAGE_SOURCE ] == HUB_NODE ){
                                STM_LOGE( "[ RF4463 ] Hub node request\r\n", NULL );
                                return;
                            }
                        #endif  
                    /*********************************************************************
                     * 
                    *********************************************************************/
                        switch( pcRF4463RxBuffer[ RF_MESSAGE_COMMAND ] ){
                            default:
                                STM_LOGE( "[ RF4463 ] Unhandled command\r\n", NULL );
                                return;
                        }
                    break;
            /*********************************************************************
             * 
            *********************************************************************/
                default:
                    STM_LOGE( "[ RF4463 ] Unhandled table\r\n", NULL );
                    STM_LOGV( "[ RF4463 ] Source node:%d\r\n", pcRF4463RxBuffer[ RF_MESSAGE_SOURCE ] );
                    STM_LOGV( "[ RF4463 ] Destination node:%d\r\n", pcRF4463RxBuffer[ RF_MESSAGE_DESTINATION ] );
                    STM_LOGV( "[ RF4463 ] Table: %d\r\n", pcRF4463RxBuffer[ RF_MESSAGE_TABLE ] );
                    STM_LOGV( "[ RF4463 ] Command: %d\r\n", pcRF4463RxBuffer[ RF_MESSAGE_COMMAND ] );
                    return;
        }
}

/*********************************************************************
 * 
*********************************************************************/
void vRF4463RxFTY(){
    /*********************************************************************
     * 
    *********************************************************************/
        uint16_t usCounter = 0;
        uint8_t ucPosition = 0;
        uint8_t pcTempBuffer[ RF_MAX_BUFFER_LENGTH ];
        uint8_t pcTempConvBuffer[ RF_MAX_BUFFER_LENGTH ];
    /*********************************************************************
     * 
    *********************************************************************/
        uint8_t pcUIDText[ 25 ];
        uint8_t pcUIDHex[ 13 ];
        uint8_t pcMACText[ 20 ];
        uint8_t pcMACHex[ 12 ];
        uint8_t pcIPText[ 20 ];
        uint8_t pcIPHex[ 6 ];
        uint8_t pcJSONBuffer[ 512 ];
    /*********************************************************************
     * 
    *********************************************************************/
        if( pcRF4463RxBuffer[ RF_MESSAGE_DESTINATION ] == NODE_FACTORY ){
            switch( pcRF4463RxBuffer[ RF_MESSAGE_TABLE ] ){
                case TABLE_RF_TEST:
                    switch( pcRF4463RxBuffer[ RF_MESSAGE_COMMAND ] ){
                        case RF_TEST_LOOP: 
                            // se agregan caracter null
                            vRF4463SetNode( NODE_FACTORY );
                            vRF4463TxMessage( &pcRF4463RxBuffer[ RF_MESSAGE_CONTENT ], ( pcRF4463RxBuffer[ RF_MESSAGE_SIZE ] - RF_MESSAGE_HEADER_SIZE ), NODE_BROADCAST, TABLE_RF_TEST, RF_TEST_LOOP );
                            break;
                        case RF_TEST_QR:
                            UART1_Write_Text( "RCV|" );
                            for( usCounter = RF_MESSAGE_CONTENT; usCounter < pcRF4463RxBuffer[ RF_MESSAGE_SIZE ]; usCounter++ ){
                                UART1_Write( pcRF4463RxBuffer[ usCounter ] );
                            }
                            UART1_Write( '\r' );
                            UART1_Write( '\n' );
                            break;    
                        case RF_TEST_OK:
                            for( usCounter = 0; usCounter < 12; usCounter++ ){
                                pcReceivedQR[ usCounter ] = pcRF4463RxBuffer[ RF_MESSAGE_CONTENT + usCounter ];
                            }

                            if( memcmp( pcReceivedQR, pcSentQR, 12 ) == 0 ){
                                UART1_Write_Text( "FINISH|" );
                                for( usCounter = 0; usCounter < 12; usCounter++ ){
                                    UART1_Write( pcReceivedQR[ usCounter ] );
                                }
                                UART1_Write( '\r' );
                                UART1_Write( '\n' );
                            }
                            break;
                        case RF_TEST_MESSAGE:
                            UART1_Write_Text( "RCV|" );
                            for( usCounter = RF_MESSAGE_CONTENT; usCounter < pcRF4463RxBuffer[ RF_MESSAGE_SIZE ]; usCounter++ ){
                                UART1_Write( pcRF4463RxBuffer[ usCounter ] );
                            }
                            UART1_Write( '\r' );
                            UART1_Write( '\n' );
                            break;
                        case RF_TEST_DONGLE_SEARCH:
                            // UART1_Write_Text( "Search This Station\r\n" );
                            if( ucSearchActive == 0 ){
                                ucSearchActive = 1;
                                vTimerSearchLed();
                            }
                            else{
                                ucSearchActive = 0;
                                vTimerStop( TIMER_SEARCH );
                                LEDGreen = On;
                            }
                            break;
                        case RF_TEST_INFO:
                            for( usCounter = 0; usCounter < ( pcRF4463RxBuffer[ RF_MESSAGE_SIZE ] - RF_MESSAGE_HEADER_SIZE ); usCounter++ ){
                                pcTempBuffer[ usCounter ] = pcRF4463RxBuffer[ usCounter + RF_MESSAGE_CONTENT ];
                            }
                            memset( pcRxRF4463AuxBuffer, '\0', RF_MAX_BUFFER_LENGTH );
                            vXORRFMessage( pcTempBuffer, pcRxRF4463AuxBuffer, usCounter );
                            switch( pcRxRF4463AuxBuffer[ ucPosition++ ] ){
                                case DEVICE_MODEL_ID_HUB:
                                    UART1_Write_Text( "QR: " );
                                    for( usCounter = 0; usCounter < 12; usCounter++ ){
                                        UART1_Write( pcRxRF4463AuxBuffer[ ucPosition++ ] );
                                    }
                                    UART1_Write( '\r' );
                                    UART1_Write( '\n' );

                                    for( usCounter = 0; usCounter < 12; usCounter++ ){
                                        pcUIDHex[ usCounter ] = pcRxRF4463AuxBuffer[ ucPosition++ ];
                                    }

                                    vSerializeUUID( pcUIDText, pcUIDHex );

                                    UART1_Write_Text( "UID: " );
                                    UART1_Write_Text( pcUIDText );
                                    UART1_Write( '\r' );
                                    UART1_Write( '\n' );

                                    for( usCounter = 0; usCounter < 6; usCounter++ ){
                                        pcMACHex[ usCounter ] = pcRxRF4463AuxBuffer[ ucPosition++ ];
                                    }
                                    vSerializeMACAddress( pcMACText, pcMACHex );
                                    UART1_Write_Text( "MAC: " );
                                    UART1_Write_Text( pcMACText );
                                    UART1_Write( '\r' );
                                    UART1_Write( '\n' );

                                    for( usCounter = 0; usCounter < 4; usCounter++ ){
                                        pcIPHex[ usCounter ] = pcRxRF4463AuxBuffer[ ucPosition++ ];
                                    }
                                    vSerializeIPAddress( pcIPText, pcIPHex );
                                    UART1_Write_Text( "IP: " );
                                    UART1_Write_Text( pcIPText );
                                    UART1_Write( '\r' );
                                    UART1_Write( '\n' );
                                    
                                    memset( pcTempBuffer, '\0', NULL );
                                    sprintf( pcTempBuffer, "Ver: %d.%d.%d\r\n", pcRxRF4463AuxBuffer[ ucPosition++ ], pcRxRF4463AuxBuffer[ ucPosition++ ], pcRxRF4463AuxBuffer[ ucPosition++ ] );
                                    UART1_Write_Text( pcTempBuffer );
                                    break;
                                case DEVICE_MODEL_ID_SWITCH:
                                    break;
                                case DEVICE_MODEL_ID_DIMMER:
                                    break;
                                case DEVICE_MODEL_ID_OUTLET:
                                    break;
                            }
                            break;
                    }
                    break;
                case TABLE_RF_SETUP:
                    switch( pcRF4463RxBuffer[ RF_MESSAGE_COMMAND ] ){
                        case RF_SETUP_FTY_DISCOVER:
                            memset( pcTempConvBuffer, '\0', RF_MAX_BUFFER_LENGTH );
                            memset( pcTempBuffer, '\0', RF_MAX_BUFFER_LENGTH );
                            for( usCounter = 0; usCounter < 12; usCounter++ ){
                                pcTempBuffer[ usCounter ] = pcRF4463RxBuffer[ RF_MESSAGE_CONTENT + usCounter ];
                            }

                            vHexToASCII( pcTempConvBuffer, pcTempBuffer, 12 );

                            UART1_Write_Text( "UID: " );
                            UART1_Write_Text( pcTempConvBuffer );
                            UART1_Write( '\r' );
                            UART1_Write( '\n' );
                            break;
                    }
                    break;
            }
        }
    /*********************************************************************
     * 
    *********************************************************************/
        else if( pcRF4463RxBuffer[ RF_MESSAGE_DESTINATION ] == HUB_NODE ){
            switch( pcRF4463RxBuffer[ RF_MESSAGE_TABLE ] ){
                case RF_SETUP_TABLE:
                    switch( pcRF4463RxBuffer[ RF_MESSAGE_COMMAND ] ){
                        case RF_SETUP_FIND_BY_QR:
                            memset( pcTempConvBuffer, '\0', RF_MAX_BUFFER_LENGTH );
                            for( usCounter = 0; usCounter < 12; usCounter++ ){
                                pcTempBuffer[ usCounter ] = pcRF4463RxBuffer[ RF_MESSAGE_CONTENT + usCounter ];
                            }
                            vHexToASCII( pcTempConvBuffer, pcTempBuffer, 12 );

                            UART1_Write_Text( "UID: " );
                            UART1_Write_Text( pcTempConvBuffer );
                            UART1_Write( '\r' );
                            UART1_Write( '\n' );

                            memset( pcJSONBuffer, '\0', 512 );
                            sprintf( pcJSONBuffer, "{\"qrCode\":\"%s\",\"location\":1,\"mac\":\"\",\"modelId\":%d,\"uuiddevice\":\"%s\"}\r\n", pcTempQR, ucSearchedModelId, pcTempConvBuffer );

                            UART1_Write_Text( pcJSONBuffer );
                            break;
                        case RF_SETUP_FTY_DISCOVER:
                            memset( pcTempConvBuffer, '\0', RF_MAX_BUFFER_LENGTH );
                            memset( pcTempBuffer, '\0', RF_MAX_BUFFER_LENGTH );
                            for( usCounter = 0; usCounter < 12; usCounter++ ){
                                pcTempBuffer[ usCounter ] = pcRF4463RxBuffer[ RF_MESSAGE_CONTENT + usCounter ];
                            }

                            vHexToASCII( pcTempConvBuffer, pcTempBuffer, 12 );

                            UART1_Write_Text( "UID: " );
                            UART1_Write_Text( pcTempConvBuffer );
                            UART1_Write( '\r' );
                            UART1_Write( '\n' );
                            break;
                    }
                    break;
            }
        }
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

/*********************************************************************
 * 
*********************************************************************/
void vRF4463SetPinSelect( uint8_t ucPinVal ){
    RF4463nSEL = ucPinVal;
}

/*********************************************************************
 * 
*********************************************************************/
void vRF4463SetPinSDN( uint8_t ucPinVal ){
    RF4463nSDN = ucPinVal;
}

/*******************************************************************************************************************************************************************************************************
 * End of File
*******************************************************************************************************************************************************************************************************/