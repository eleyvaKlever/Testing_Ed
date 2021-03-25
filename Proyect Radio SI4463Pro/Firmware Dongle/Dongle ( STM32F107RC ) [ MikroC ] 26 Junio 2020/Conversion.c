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
#include "Conversion.h"
/**********************************************************************************************
 * Global Variables
**********************************************************************************************/

/**********************************************************************************************
 * Local Variables
**********************************************************************************************/
const uint8_t pcHexChar[16] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};

uint8_t ucMSBNibble = 0;
uint8_t ucLSBNibble = 0;

/**********************************************************************************************
 * Instances
**********************************************************************************************/

/**********************************************************************************************
 * Function declaration
**********************************************************************************************/
/*********************************************************************
 * 
*********************************************************************/
void vASCIIToHex( uint8_t *pcHexConvertBuffer, uint8_t *pcASCIIConvertBuffer, uint8_t ucConversionLength ){
    uint8_t ucASCIICounter = 0;

    for( ucASCIICounter = 0; ucASCIICounter < ucConversionLength; ucASCIICounter++ ){
        ucMSBNibble = 0;
        ucLSBNibble = 0;

        ucMSBNibble = ( pcASCIIConvertBuffer[ ucASCIICounter * 2 ] - 0x30 );
        if( ucMSBNibble > 9 ){
            ucMSBNibble -= 7;
        }

        ucLSBNibble = ( pcASCIIConvertBuffer[ ( ucASCIICounter * 2 ) + 1 ] - 0x30 );
        if( ucLSBNibble > 9 ){
            ucLSBNibble -= 7;
        }
        
        pcHexConvertBuffer[ ucASCIICounter ] = ( ( ucMSBNibble << 4 ) | ucLSBNibble );
    }
}

/*********************************************************************
 * 
*********************************************************************/
void vHexToASCII( uint8_t *pcASCIIConvertBuffer, uint8_t *pcHexConvertBuffer, uint8_t ucConversionLength ){
    uint8_t ucHexConvCounter = 0;

    for( ucHexConvCounter = 0; ucHexConvCounter < ucConversionLength; ucHexConvCounter++ ){
        pcASCIIConvertBuffer[ ucHexConvCounter * 2 ]            = pcHexChar[ pcHexConvertBuffer[ ucHexConvCounter ] >> 4 ];
        pcASCIIConvertBuffer[ ( ucHexConvCounter * 2 ) + 1 ]    = pcHexChar[ ( pcHexConvertBuffer[ ucHexConvCounter ] & 0x0F ) ];
    }
}

/*********************************************************************
 * 
*********************************************************************/
void vSerializeUUID( uint8_t * pcTextConvertBuffer, uint8_t * pcHexConvertBuffer ){
    uint8_t ucCounter = 0;
    
    for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
        pcTextConvertBuffer[ ucCounter * 2 ]         = pcHexChar[ pcHexConvertBuffer[ ucCounter ] >> 4 ];
        pcTextConvertBuffer[ ( ucCounter * 2 ) + 1 ] = pcHexChar[ pcHexConvertBuffer[ ucCounter ] & 0x0F ];
    }
}

/*********************************************************************
 * 
*********************************************************************/
void vSerializeMACAddress( uint8_t * pcTextConvertBuffer, uint8_t * pcHexConvertBuffer ){
    uint16_t usCounter = 0;
    uint8_t pcDeviceMAC[ 12 ];

    vHexToASCII( pcDeviceMAC, pcHexConvertBuffer, 6 );

    for( usCounter = 0; usCounter < 6; usCounter++ ){
        pcTextConvertBuffer[ usCounter * 3 ]         = pcDeviceMAC[ usCounter * 2 ];
        pcTextConvertBuffer[ ( usCounter * 3 ) + 1 ] = pcDeviceMAC[ ( usCounter * 2 ) + 1 ];
        if( usCounter != 5 ){
            pcTextConvertBuffer[ ( usCounter * 3 ) + 2 ] = ':';
        }
    }
    pcTextConvertBuffer[ 18 ] = '\0';
}

/*********************************************************************
 * 
*********************************************************************/
void vSerializeIPAddress( uint8_t * pcTextConvertBuffer, uint8_t * pcHexConvertBuffer ){
    uint8_t ucCounter = 0;
    uint8_t pcConvertText[ 7 ];

    memset( pcTextConvertBuffer, '\0', sizeof( pcTextConvertBuffer ) );

    for( ucCounter = 0; ucCounter < 4; ucCounter++ ){

        ByteToStr( pcHexConvertBuffer[ ucCounter ], pcConvertText );
        
        strcat( pcTextConvertBuffer, Ltrim( pcConvertText ) );

        if( ucCounter != 3 ){
            strcat( pcTextConvertBuffer, "." );
        }
    }
}


/*******************************************************************************************************************************************************************************************************
 * End of File
*******************************************************************************************************************************************************************************************************/