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
#include "utils.h"
/**********************************************************************************************
 * Global Variables
**********************************************************************************************/
/**********************************************************************************************
 * Local Variables
**********************************************************************************************/
const unsigned char pcHexChar[16] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};

unsigned char ucMSBNibble = 0;
unsigned char ucLSBNibble = 0;
/**********************************************************************************************
 * Instances
**********************************************************************************************/
/**********************************************************************************************
 * IRQ Handlers
**********************************************************************************************/
/**********************************************************************************************
 * Function declaration
**********************************************************************************************/
/*********************************************************************
 * 
*********************************************************************/
unsigned char ucASCIIToByte( unsigned char * pcASCIIBuffer ){
    ucMSBNibble = 0;
    ucLSBNibble = 0;

    ucMSBNibble = ( pcASCIIBuffer[ 0 ] - 0x30 );
    if( ucMSBNibble > 9 ){
        ucMSBNibble -= 7;
    }

    ucLSBNibble = ( pcASCIIBuffer[ 1 ] - 0x30 );
    if( ucLSBNibble > 9 ){
        ucLSBNibble -= 7;
    }

    return ( ucMSBNibble << 4 | ucLSBNibble );
}

/*********************************************************************
 * 
*********************************************************************/
void vASCIIToHex( unsigned char *pcHexConvertBuffer, unsigned char *pcASCIIConvertBuffer, unsigned char ucConversionLength ){
    unsigned char ucASCIICounter = 0;

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
void vHexToASCII( unsigned char *pcASCIIConvertBuffer, unsigned char *pcHexConvertBuffer, unsigned char ucConversionLength ){
    unsigned char ucHexConvCounter = 0;

    for( ucHexConvCounter = 0; ucHexConvCounter < ucConversionLength; ucHexConvCounter++ ){
        pcASCIIConvertBuffer[ ucHexConvCounter * 2 ]            = pcHexChar[ pcHexConvertBuffer[ ucHexConvCounter ] >> 4 ];
        pcASCIIConvertBuffer[ ( ucHexConvCounter * 2 ) + 1 ]    = pcHexChar[ ( pcHexConvertBuffer[ ucHexConvCounter ] & 0x0F ) ];
    }
}

/*********************************************************************
 * 
*********************************************************************/
void vBufferSetToZero( unsigned char * pcBufferToClean, unsigned int uslength ){
    unsigned int usPosition = 0;

    for( usPosition = 0; usPosition < uslength; usPosition++ ){
        pcBufferToClean[ usPosition ] = 0x00;
    }
}

/*********************************************************************
 * 
*********************************************************************/
void vBufferSetTo255( unsigned char * pcBufferToClean, unsigned int uslength ){
    unsigned int usPosition = 0;

    for( usPosition = 0; usPosition < uslength; usPosition++ ){
        pcBufferToClean[ usPosition ] = 0xFF;
    }
}

/*********************************************************************
 * 
*********************************************************************/
void vBufferSetToValue( unsigned char * pcBufferToClean, unsigned char ucValue, unsigned int uslength ){
    unsigned int usPosition = 0;

    for( usPosition = 0; usPosition < uslength; usPosition++ ){
        pcBufferToClean[ usPosition ] = ucValue;
    }
}

/*********************************************************************
 * 
*********************************************************************/
void vSerializeUUID( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer ){
    unsigned char ucCounter = 0;
    
    for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
        pcTextConvertBuffer[ ucCounter * 2 ]         = pcHexChar[ pcHexConvertBuffer[ ucCounter ] >> 4 ];
        pcTextConvertBuffer[ ( ucCounter * 2 ) + 1 ] = pcHexChar[ pcHexConvertBuffer[ ucCounter ] & 0x0F ];
    }
}

/*********************************************************************
 * 
*********************************************************************/
void vSerializeMACAddress( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer ){
    unsigned int usCounter = 0;
    unsigned char pcDeviceMAC[ 12 ];

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
void vSerializeIPAddress( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer ){
    unsigned char ucCounter = 0;
    unsigned char pcConvertText[ 7 ];

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