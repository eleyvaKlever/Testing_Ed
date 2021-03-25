/**************************************************************************************************************************************************
 * BEGIN OF FILE

 * FILE: file.c
 * DATE:
 * VERSION:

 * AUTHOR: 

 * DESCRIPTION: 
**************************************************************************************************************************************************/

/**************************************************************************************************
 * PROTOTYPING HEADER
**************************************************************************************************/
#include "rf4463spi.h"

/**************************************************************************************************
 * GLOBAL VARIABLES
**************************************************************************************************/

/**************************************************************************************************
 * LOCAL VARIABLES
**************************************************************************************************/

/**************************************************************************************************
 * PROGRAM
**************************************************************************************************/
/********************************************************************* 
 * FUNCTION:
 * INPUT:
 * OUTPUT: 
 * DESCRIPTION:
*********************************************************************/
void vRf4463SPIWriteBuffer( uint16_t usWriteLength, uint8_t * pcWriteBuffer ){
    /*************************************************************************************************
     * Native SPI Driver ( Communication with RF4463 )
    *************************************************************************************************/
    while( usWriteLength-- ){
        ucRf4463SPIByte( *pcWriteBuffer++ );
    }
}

/********************************************************************* 
 * FUNCTION:
 * INPUT:
 * OUTPUT: 
 * DESCRIPTION:
*********************************************************************/
void vRf4463SPIReadBuffer( uint16_t usReadLength, uint8_t * pcReadBuffer ){
    uint8_t ucRxCounter = 0;
    /*************************************************************************************************
     * Native SPI Driver ( Communication with RF4463 )
    *************************************************************************************************/
    while( usReadLength-- ){
        pcReadBuffer[ ucRxCounter++ ] = ucRf4463SPIByte( 0 );
    }
}

/********************************************************************* 
 * FUNCTION:
 * INPUT:
 * OUTPUT: 
 * DESCRIPTION:
*********************************************************************/
uint8_t ucRf4463SPIByte( uint8_t pcWriteData ){
    return SPI1_Read( pcWriteData );
}

/**************************************************************************************************************************************************
 * END OF FILE
**************************************************************************************************************************************************/