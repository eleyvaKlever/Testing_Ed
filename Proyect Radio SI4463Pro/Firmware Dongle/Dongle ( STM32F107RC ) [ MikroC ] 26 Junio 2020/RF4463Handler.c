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
        ucRadioEvent = 1;
        ucRf4463ClearInterrupts();
        // UART1_Write( '\r' );
        // UART1_Write( '\n' );
    }
}

/**********************************************************************************************
 * Function declaration
**********************************************************************************************/
/*********************************************************************
 * 
*********************************************************************/
void vRadioInit(){
    uint8_t ucTempText[ 20 ];

    /*********************************************************************
     * RF4463Pro Bus Init
    *********************************************************************/
    SPI2_Init_Advanced( _SPI_FPCLK_DIV16, _SPI_MASTER | _SPI_8_BIT | _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION | _SPI_MSB_FIRST | 
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
    vInitRF4463IRQ();
    /********************************************************
     * RF4463 Initial Configuration
    ********************************************************/
    // xRadioParameters.Node       = NODE_DEFAULT;
    xRadioParameters.Channel    = CHANNEL_DEFAULT;
    xRadioParameters.Network    = NETWORK_DEFAULT;
    xRadioParameters.TxPower    = TX_POWER_DEFAULT;

    ucInitRF4463Config();
    /**********************************************************************************************
     * 
    **********************************************************************************************/
    STM_LOGV( "[ RF4463 ] Parameters\r\n", NULL );
    STM_LOGV( "[ RF4463 ] Node: %d\r\n",    xRadioParameters.Node );
    STM_LOGV( "[ RF4463 ] Channel: %d\r\n", xRadioParameters.Channel );
    STM_LOGV( "[ RF4463 ] Network: %d\r\n", xRadioParameters.Network );
    STM_LOGV( "[ RF4463 ] Tx Power: %d\r\n", xRadioParameters.TxPower );
}

/*********************************************************************
 * Rf4463 IRQ Configuration Bits
*********************************************************************/
void vInitRF4463IRQ(){
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
}

/*********************************************************************
 * RF4463 Init Configuration
*********************************************************************/
uint8_t ucInitRF4463Config(){
    uint8_t ucRetriesRf     = 0;
    uint8_t ucIsRFAvailable = NOT_SUCCESS;
    
    STM_LOGD( "[ RF4463 ] Configure\r\n", NULL );

    ucRf4463Init();
    ucRf4463Init();

    STM_LOGV( "[ RF4463 ] Configure Done\r\n", NULL );

    for( ucRetriesRf = 0; ucRetriesRf < 5; ucRetriesRf++ ){
        if( ucRf4463DeviceAvailability() == SUCCESS ){
            STM_LOGD( "[ RF4463 ] Init Done\r\n", NULL );
            break;
        }
        Delay_ms( 10 );
        STM_LOGV( "[ RF4463 ] Try: %d\r\n", ucRetriesRf );
    }
    /********************************************************
	 * Verify if RF4463 setup was done correctly
	********************************************************/
    STM_LOGV( "[ RF4463 ] Wait for Standby\r\n", NULL );

    while( ucRf4463EnterStandbyMode() == NOT_SUCCESS );

    STM_LOGV( "[ RF4463 ] Standby\r\n", NULL );

    return SUCCESS;
}

/**********************************************************************************************
 * Reception Function
**********************************************************************************************/
void vRFRxMessage(){
    uint16_t usCounter = 0;

    uint8_t ucPosition = 0;
    uint8_t pcTempBuffer[ RF_MAX_BUFFER_LENGTH ];
    uint8_t pcTempConvBuffer[ RF_MAX_BUFFER_LENGTH ];

    if( ucRF4463TxEvent == 0 ){
        memset( pcRxRF4463Buffer, '\0', sizeof( pcRxRF4463Buffer ) );
        ucRf4463RxPacket( pcRxRF4463Buffer );

        if( pcRxRF4463Buffer[ 0 ] > 0 ){
            
            #ifdef ENABLE_DEBUG_RF_PACKET
                UART1_Write_Text( "[ RF4463 Rx ] Packet: " );            
                for( usCounter = 0; usCounter < pcRxRF4463Buffer[ RfMessageSize ]; usCounter++ ){
                    UART1_Write( pcRxRF4463Buffer[ usCounter ] );
                }
                UART1_Write( '\r' );
                UART1_Write( '\n' );
            #endif
            #ifdef FACTORY_DONGLE
                if( pcRxRF4463Buffer[ RfMessageDestination ] == NODE_FACTORY ){
                    switch( pcRxRF4463Buffer[ RfMessageTable ] ){
                        case Table_RF_Test:
                            switch( pcRxRF4463Buffer[ RfMessageCommand ] ){
                                case Test_Device_Loop: 
                                    // se agregan caracter null
                                    ucRemoteNode = NODE_BROADCAST;
                                    ucSenderNode = NODE_FACTORY;
                                    ucTableIndex = Table_RF_Test;
                                    ucCommandIndex = Test_Device_Loop;

                                    vRfTxMessage( &pcRxRF4463Buffer[ RfMessageContent ], ( pcRxRF4463Buffer[ RfMessageSize ] - RfMessageHeaderSize ) );

                                    break;
                                case Test_Device_QR:
                                    UART1_Write_Text( "RCV|" );
                                    for( usCounter = RfMessageContent; usCounter < pcRxRF4463Buffer[ RfMessageSize ]; usCounter++ ){
                                        UART1_Write( pcRxRF4463Buffer[ usCounter ] );
                                    }
                                    UART1_Write( '\r' );
                                    UART1_Write( '\n' );
                                    break;    
                                case Test_Device_Ok:
                                    for( usCounter = 0; usCounter < 12; usCounter++ ){
                                        pcReceivedQR[ usCounter ] = pcRxRF4463Buffer[ RfMessageContent + usCounter ];
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
                                case Test_Device_Message:
                                    UART1_Write_Text( "RCV|" );
                                    for( usCounter = RfMessageContent; usCounter < pcRxRF4463Buffer[ RfMessageSize ]; usCounter++ ){
                                        UART1_Write( pcRxRF4463Buffer[ usCounter ] );
                                    }
                                    UART1_Write( '\r' );
                                    UART1_Write( '\n' );
                                    break;
                                case Test_Dongle_Search:
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
                                case Test_Device_Info:
                                    for( usCounter = 0; usCounter < ( pcRxRF4463Buffer[ RfMessageSize ] - RfMessageHeaderSize ); usCounter++ ){
                                        pcTempBuffer[ usCounter ] = pcRxRF4463Buffer[ usCounter + RfMessageContent ];
                                    }
                                    memset( pcRxRF4463AuxBuffer, '\0', RF_MAX_BUFFER_LENGTH );
                                    vXORRFMessage( pcTempBuffer, pcRxRF4463AuxBuffer, usCounter );
                                    switch( pcRxRF4463AuxBuffer[ ucPosition++ ] ){
                                        case Device_Model_Hub:
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
                                        case Device_Model_Switch:
                                            break;
                                        case Device_Model_Dimmer:
                                            break;
                                        case Device_Model_Outlet:
                                            break;
                                    }
                                    break;
                            }
                            break;
                        case Table_RF_Setup:
                            switch( pcRxRF4463Buffer[ RfMessageCommand ] ){
                                case Setup_Hard_Discover:
                                    memset( pcTempConvBuffer, '\0', RF_MAX_BUFFER_LENGTH );
                                    memset( pcTempBuffer, '\0', RF_MAX_BUFFER_LENGTH );
                                    for( usCounter = 0; usCounter < 12; usCounter++ ){
                                        pcTempBuffer[ usCounter ] = pcRxRF4463Buffer[ RfMessageContent + usCounter ];
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
                else if( pcRxRF4463Buffer[ RfMessageDestination ] == HUB_NODE_DEFAULT ){
                    switch( pcRxRF4463Buffer[ RfMessageTable ] ){
                        case Table_RF_Setup:
                            switch( pcRxRF4463Buffer[ RfMessageCommand ] ){
                                case Setup_Qr:
                                    memset( pcTempConvBuffer, '\0', RF_MAX_BUFFER_LENGTH );
                                    for( usCounter = 0; usCounter < 12; usCounter++ ){
                                        pcTempBuffer[ usCounter ] = pcRxRF4463Buffer[ RfMessageContent + usCounter ];
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
                                case Setup_Hard_Discover:
                                    memset( pcTempConvBuffer, '\0', RF_MAX_BUFFER_LENGTH );
                                    memset( pcTempBuffer, '\0', RF_MAX_BUFFER_LENGTH );
                                    for( usCounter = 0; usCounter < 12; usCounter++ ){
                                        pcTempBuffer[ usCounter ] = pcRxRF4463Buffer[ RfMessageContent + usCounter ];
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
            #endif

            if( pcRxRF4463Buffer[ RfMessageDestination ] == NODE_FACTORY ){
                switch( pcRxRF4463Buffer[ RfMessageTable ] ){
                    case Table_RF_Test:
                        switch( pcRxRF4463Buffer[ RfMessageCommand ] ){

                            case Test_Device_Loop: 
                                // se agregan caracter null

                                ucRemoteNode = NODE_BROADCAST;
                                ucSenderNode = NODE_FACTORY;
                                ucTableIndex = Table_RF_Test;
                                ucCommandIndex = Test_Device_Loop;
                                vRfTxMessage(&pcRxRF4463Buffer[RfMessageContent], (pcRxRF4463Buffer[ RfMessageSize]-RfMessageHeaderSize));
                                
                                break;

                            default :
                                break;
                        }
                        break;
                }
            }
        }
    }
    else{
        ucRF4463TxEvent = 0;
    }

    LEDRed = Off;

    ucRf4463RxInit();
}

/**********************************************************************************************
 * Transmission Function
**********************************************************************************************/
void vRfTxMessage( uint8_t * pcOutBuffer, uint16_t usLength ){
    uint16_t usCounter = 0;
    uint8_t pcTemp[ 10 ];

    memset( pcTxRF4463Buffer, '\0', sizeof( pcTxRF4463Buffer ) );

    if( usLength + 5 >= RF_MAX_BUFFER_LENGTH ){
        // UART1_Write_Text( "Buffer Out of Size\r\n" );
        return;
    }

    // if( usLength > 0 ){
    //     UART1_Write_Text( "[ RF4463 TX ] Buffer Size: " );
    //     ByteToStr( usLength, pcTemp );
    //     UART1_Write_Text( pcTemp );
    //     UART1_Write( '\r' );
    //     UART1_Write( '\n' );

    //     UART1_Write_Text( "[ RF4463 TX ] Buffer: " );
    //     for( usCounter = 0; usCounter < usLength; usCounter++ ){
    //         UART1_Write( pcOutBuffer[ usCounter ] );
    //     }
    //     UART1_Write( '\r' );
    //     UART1_Write( '\n' );
    // }

    pcTxRF4463Buffer[ RfMessageSize ]           = RfMessageHeaderSize + usLength;
    pcTxRF4463Buffer[ RfMessageDestination ]    = ucRemoteNode;
    pcTxRF4463Buffer[ RfMessageSender ]         = ucSenderNode;
    pcTxRF4463Buffer[ RfMessageTable ]          = ucTableIndex;
    pcTxRF4463Buffer[ RfMessageCommand ]        = ucCommandIndex;

    if( usLength > 0 ){
        for( usCounter = 0; usCounter < usLength; usCounter++ ){
            pcTxRF4463Buffer[ RfMessageHeaderSize + usCounter ] = pcOutBuffer[ usCounter ];
        }
    }

    #ifdef ENABLE_DEBUG_RF_PACKET
        UART1_Write_Text( "[ RF4463 TX ] Packet: " );
        for( usCounter = 0; usCounter < pcTxRF4463Buffer[ RfMessageSize ]; usCounter++ ){
            UART1_Write( pcTxRF4463Buffer[ usCounter ] );
        }
        UART1_Write( '\r' );
        UART1_Write( '\n' );
    #endif

    ucRf4463TxPacket( pcTxRF4463Buffer, pcTxRF4463Buffer[ RfMessageSize ] );

    ucRf4463RxInit();
}

/**********************************************************************************************
 * 
**********************************************************************************************/
void vRfSettingsHotSwap( uint8_t ucRfChannel, uint16_t usNetwork ){
    uint8_t pcBuffer[ 5 ];
    uint8_t pcTemp[ 15 ];

    ucRf4463EnterStandbyMode();
    xRadioParameters.Channel = ucRfChannel;
    xRadioParameters.Network = usNetwork;

    pcBuffer[ 0 ] = ( xRadioParameters.Network >> 8 );
    pcBuffer[ 1 ] = xRadioParameters.Network;
    ucRf4463SetSyncWords( pcBuffer, 2 );

    #ifdef ENABLE_DEBUG_RF_PACKET
        UART1_Write_Text( "[ RF4463 CFG ] Channel: " );
        ByteToStr( xRadioParameters.Channel, pcTemp );
        UART1_Write_Text( pcTemp );
        UART1_Write( '\r' );
        UART1_Write( '\n' );

        UART1_Write_Text( "[ RF4463 CFG ] Network: " );
        IntToStr( xRadioParameters.Network, pcTemp );      
        UART1_Write_Text( pcTemp );
        UART1_Write( '\r' );
        UART1_Write( '\n' );
    #endif

    ucRf4463ClearInterrupts();

    ucRf4463RxInit();
}

/*******************************************************************************************************************************************************************************************************
 * End of File
*******************************************************************************************************************************************************************************************************/