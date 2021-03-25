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
#include "OTAPrototype.h"
/**********************************************************************************************
 * Global Variables
**********************************************************************************************/
extern uint8_t ucTableIndex;
extern uint8_t ucCommandIndex;

/**********************************************************************************************
 * Local Variables
**********************************************************************************************/
uint16_t usTotalPackets     = 0;
uint16_t usActualPacket     = 0;
uint16_t usPartialPacket    = 0;
uint16_t usFileLength       = 0;

uint16_t usTotalLines       = 0;

uint8_t ucOTAStartACK       = 0;
uint8_t ucOTAWaitACK        = 0;

/**********************************************************************************************
 * Instances
**********************************************************************************************/

/**********************************************************************************************
 * IRQ Handlers
**********************************************************************************************/
/*********************************************************************
 * 
*********************************************************************/
/**********************************************************************************************
 * Function declaration
**********************************************************************************************/
/*********************************************************************
 * 
*********************************************************************/
void vOTAHandler(){
    // if( ucOTAStartACK == 0 ){
    //     if( ucOTAWaitACK == 1 ){
    //         ucOTAStartACK = 1;
    //         UART1_Write_Text( "[ OTA ] Start Transmission\r\n" );
    //     }
    //     else{
    //         ucTableIndex = Table_OTA;
    //         ucCommandIndex = OTA_Start;

    //         ucOTAWaitACK = 1;

    //         vRfTxMessage( NULL, NULL );
    //     }
    // }
    // else{
        if( pcRxRF4463Buffer[ RfMessageTable ] == Table_OTA ){
            if( pcRxRF4463Buffer[ RfMessageCommand ] == OTA_ACK && ucOTAWaitACK == 1 ){
                ucOTAWaitACK = 0;
                UART1_Write_Text( "[ OTA ] Packet Success\r\n" );
            }
            if( pcRxRF4463Buffer[ RfMessageCommand ] == OTA_NACK && ucOTAWaitACK == 1 ){
                ucOTAWaitACK = 0;
                UART1_Write_Text( "[ OTA ] Packet Failed\r\n" );
            }
        }
    // }
}

/*********************************************************************
 * 
*********************************************************************/
void vRfSendFileHeader( const uint8_t * pcRxBuffer ){
    uint16_t usPosition = 1;
    uint16_t usCounter  = 0;

    uint8_t pcTempBuffer[ 66 ];
    uint8_t pcFileLength[ 12 ];
    uint8_t pcFirmwareVersion[ 6 ];
    uint8_t pcFirmwareDate[ 6 ];

    uint8_t pcTempText[ 10 ];

    /*********************************************************************
     * File Length
    *********************************************************************/
    for( usCounter = 0; ; usCounter++ ){
        pcFileLength[ usCounter ] = pcRxBuffer[ usPosition++ ];
        if( pcRxBuffer[ usPosition ] == '|' ){
            usPosition++;
            break;
        }
    }

    usTotalLines = atoi( pcFileLength );
    usPartialPacket = usTotalLines % LINES_PER_PACKET;
    usTotalPackets = usTotalLines / 2;
    
    if( usPartialPacket > 0 ){
        usTotalPackets += 1;
    }

    UART1_Write_Text( "[ OTA ] Total Lines: " );
    IntToStr( usTotalLines, pcTempText );
    UART1_Write_Text( pcTempText );
    UART1_Write( '\r' );
    UART1_Write( '\n' );

    UART1_Write_Text( "[ OTA ] Total Packets: " );
    IntToStr( usTotalPackets, pcTempText );
    UART1_Write_Text( pcTempText );
    UART1_Write( '\r' );
    UART1_Write( '\n' );

    if( usPartialPacket > 0 ){
        UART1_Write_Text( "[ OTA ] Has Partial Packet\r\n" );
    }

    /*********************************************************************
     * Version
    *********************************************************************/
    memset( pcTempBuffer, '\0', 10 );
    for( usCounter = 0; ; usCounter++ ){ 
        pcTempBuffer[ usCounter ] = pcRxBuffer[ usPosition++ ];
        if( pcRxBuffer[ usPosition ] == '|' ){
            usPosition++;
            break;
        }
    }

    UART1_Write_Text( "[ OTA ] Version: " );
    UART1_Write_Text( pcTempBuffer );
    UART1_Write( '\r' );
    UART1_Write( '\n' );

    vASCIIToHex( pcFirmwareVersion, pcTempBuffer, usCounter );
    /*********************************************************************
     * Date
    *********************************************************************/
    memset( pcTempBuffer, '\0', 10 );
    for( usCounter = 0; ; usCounter++ ){ 
        pcTempBuffer[ usCounter ] = pcRxBuffer[ usPosition++ ];
        if( pcRxBuffer[ usPosition ] == '|' ){
            usPosition++;
            break;
        }
    }

    UART1_Write_Text( "[ OTA ] Date: " );
    UART1_Write_Text( pcTempBuffer );
    UART1_Write( '\r' );
    UART1_Write( '\n' );

    vASCIIToHex( pcFirmwareDate, pcTempBuffer, usCounter );

    ucTableIndex = Table_OTA;
    ucCommandIndex = OTA_Header;

    usPosition = 0;

    pcTempBuffer[ usPosition++ ] = ( usTotalLines >> 8 );
    pcTempBuffer[ usPosition++ ] = usTotalLines;
    pcTempBuffer[ usPosition++ ] = ( usTotalPackets >> 8 );
    pcTempBuffer[ usPosition++ ] = usTotalPackets;
    pcTempBuffer[ usPosition++ ] = pcFirmwareVersion[ 0 ];
    pcTempBuffer[ usPosition++ ] = pcFirmwareVersion[ 1 ];
    pcTempBuffer[ usPosition++ ] = pcFirmwareVersion[ 2 ];
    pcTempBuffer[ usPosition++ ] = pcFirmwareDate[ 0 ];
    pcTempBuffer[ usPosition++ ] = pcFirmwareDate[ 1 ];
    pcTempBuffer[ usPosition++ ] = pcFirmwareDate[ 2 ];

    vRfTxMessage( pcTempBuffer, usPosition );
}

/*********************************************************************
 * 
*********************************************************************/
void vRfSendFileLine( const uint8_t * pcRxBuffer ){
    uint16_t usCounter = 0;
    uint16_t usPosition = 1;
    uint16_t usPacketID = 0;

    uint8_t pcPacketID[ 3 ];
    uint8_t pcTempBuffer[ 256 ];
    uint8_t pcTempHexBuffer[ 66 ];
    uint32_t ulChecksum = 0;
    uint8_t ucChecksumByte = 0;

    uint8_t pcTempText[ 10 ];

    UART1_Write_Text( "[ OTA ] Send Line\r\n" );

    memset( pcPacketID, '\0', 3 );
    memset( pcTempBuffer, '\0', sizeof( pcTempBuffer ) );

    for( usCounter = 0; ; usCounter++ ){
        pcPacketID[ usCounter ] = pcRxBuffer[ usPosition++ ];
        if( pcRxBuffer[ usPosition ] == '|' ){
            usPosition++;
            break;
        }
    }

    usPacketID = atoi( pcPacketID );

    for( usCounter = 0; ; usCounter++ ){
        pcTempBuffer[ usCounter ] = pcRxBuffer[ usPosition++ ];
        if( pcRxBuffer[ usPosition ] == '|' ){
            usPosition++;
            break;
        }
    }

    vASCIIToHex( pcTempHexBuffer, pcTempBuffer, usCounter );

    /******************************************************************
     * CHECKSUM OF DATA
    ******************************************************************/
    for( usCounter = 0; usCounter < DATA_PER_PACKET; usCounter++){
        ulChecksum += pcTempHexBuffer[ usCounter ];
    }
    ucChecksumByte = ( ( ~ulChecksum ) + 1 );
    pcTempHexBuffer[ DATA_PER_PACKET ] = ucChecksumByte;

    /******************************************************************
     * Construction of FInal Buffer
    ******************************************************************/
    memset( pcTempBuffer, '\0', sizeof( pcTempBuffer ) );
    usPosition = 0;
    pcTempBuffer[ usPosition++ ] = ( usPacketID >> 8 );
    pcTempBuffer[ usPosition++ ] = usPacketID;
    for( usCounter = 0; usCounter < BYTES_PER_PACKET; usCounter++ ){
        pcTempBuffer[ usPosition++ ] = pcTempHexBuffer[ usCounter ];
    }

    /******************************************************************
     * Print Data
    ******************************************************************/
    // UART1_Write_Text( "[ OTA ] Packet ID: " );
    // UART1_Write_Text( pcPacketID );
    // UART1_Write( '\r' );
    // UART1_Write( '\n' );

    // UART1_Write_Text( "[ OTA ] Line: " );
    // for( usCounter = 0; usCounter < PACKET_SIZE; usCounter++ ){
    //     UART1_Write( pcTempBuffer[ usCounter ] );
    // }
    // UART1_Write( '\r' );
    // UART1_Write( '\n' );

    // UART1_Write_Text( "[ OTA ] Hex: " );
    // for( usCounter = 0; usCounter < BYTES_PER_PACKET; usCounter++ ){
    //     UART1_Write( pcTempHexBuffer[ usCounter ] );
    // }
    // UART1_Write( '\r' );
    // UART1_Write( '\n' );

    // UART1_Write_Text( "[ OTA ] Checksum Byte: " );
    // ByteToStr( ucChecksumByte, pcTempText );
    // UART1_Write_Text( pcTempText );
    // UART1_Write( '\r' );
    // UART1_Write( '\n' );

    // UART1_Write_Text( "[ OTA ] Send Checksum Byte: " );
    // UART1_Write( pcTempHexBuffer[ BYTES_PER_PACKET ] );
    // UART1_Write( '\r' );
    // UART1_Write( '\n' );

    // UART1_Write_Text( "[ OTA ] Calculated Checksum Byte: " );
    // UART1_Write( ucChecksumByte );
    // UART1_Write( '\r' );
    // UART1_Write( '\n' );

    /******************************************************************
     * Print Data
    ******************************************************************/
    ucTableIndex = Table_OTA;
    ucCommandIndex = OTA_Packet;

    ucOTAWaitACK = 1;

    vRfTxMessage( pcTempBuffer, PACKET_SIZE );
}

/*********************************************************************
 * 
*********************************************************************/
void vRfSendFileEnd(){
    ucTableIndex = Table_OTA;
    ucCommandIndex = OTA_EOT;

    vRfTxMessage( NULL, NULL );
}

/*********************************************************************
 * 
*********************************************************************/

/*******************************************************************************************************************************************************************************************************
 * End of File
*******************************************************************************************************************************************************************************************************/