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
const uint8_t pcHexChar[16] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};

uint8_t ucMSBNibble = 0;
uint8_t ucLSBNibble = 0;
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
uint8_t ucASCIIToByte( uint8_t * pcASCIIBuffer ){
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
void vBufferSetToZero( uint8_t * pcBufferToClean, uint16_t uslength ){
    uint16_t usPosition = 0;

    for( usPosition = 0; usPosition < uslength; usPosition++ ){
        pcBufferToClean[ usPosition ] = 0x00;
    }
}

/*********************************************************************
 * 
*********************************************************************/
void vBufferSetTo255( uint8_t * pcBufferToClean, uint16_t uslength ){
    uint16_t usPosition = 0;

    for( usPosition = 0; usPosition < uslength; usPosition++ ){
        pcBufferToClean[ usPosition ] = 0xFF;
    }
}

/*********************************************************************
 * 
*********************************************************************/
void vBufferSetToValue( uint8_t * pcBufferToClean, uint8_t ucValue, uint16_t uslength ){
    uint16_t usPosition = 0;

    for( usPosition = 0; usPosition < uslength; usPosition++ ){
        pcBufferToClean[ usPosition ] = ucValue;
    }
}

/*******************************************************************************************************************************************************************************************************
 * End of File
*******************************************************************************************************************************************************************************************************/