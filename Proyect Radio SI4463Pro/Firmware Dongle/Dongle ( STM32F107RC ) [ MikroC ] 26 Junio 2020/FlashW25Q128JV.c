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
#include "FlashW25Q128JV.h"
/**********************************************************************************************
 * Global Variables
**********************************************************************************************/

/**********************************************************************************************
 * Local Variables
**********************************************************************************************/

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
void vW25Q128JVInit( ){
    FlashCS = 1;
}

/*********************************************************************
 * 
*********************************************************************/
void vFlashWriteEnable( uint8_t ucMemorySelected ){
    FlashCS = 0;
    SPI1_Write( _SERIAL_FLASH_CMD_WREN );
    FlashCS = 1;
}

/*********************************************************************
 * 
*********************************************************************/
uint8_t ucFlashIsWriteBusy( uint8_t ucMemorySelected ){
    uint8_t ucTemp = 0;

    FlashCS = 0;
    SPI1_Write( _SERIAL_FLASH_CMD_RDSR );
    ucTemp = SPI1_Read( 0 );
    FlashCS = 1;

    return ( ucTemp & 0x01 );
}

/*********************************************************************
 * 
*********************************************************************/
void vFlashWriteByte( uint8_t ucMemorySelected, uint8_t pcData, uint32_t ulMemoryAddress ){
    vFlashWriteEnable( ucMemorySelected );

    FlashCS = 0;
    SPI1_Write( _SERIAL_FLASH_CMD_WRITE );
    SPI1_Write( Higher( ulMemoryAddress ) );
    SPI1_Write( Hi( ulMemoryAddress ) );
    SPI1_Write( Lo( ulMemoryAddress ) );
    SPI1_Write( pcData );
    FlashCS = 1;

    while( ucFlashIsWriteBusy( ucMemorySelected ) );
}

/*********************************************************************
 * 
*********************************************************************/
void vFlashWriteWord( uint8_t ucMemorySelected, uint16_t pcData, uint32_t ulMemoryAddress ){
    vFlashWriteByte( ucMemorySelected, Hi( pcData ), ulMemoryAddress );
    vFlashWriteByte( ucMemorySelected, Lo( pcData ), ulMemoryAddress + 1 );
}

/*********************************************************************
 * 
*********************************************************************/
uint8_t ucFlashWriteArray( uint8_t ucMemorySelected, uint8_t * pcData, uint16_t usBufferLength, const uint32_t ulMemoryAddress ){
    uint32_t ulFlashAddress = 0;
    uint16_t usBufferCounter = 0;
    uint8_t ucTempValue = 0;

    ulFlashAddress = ulMemoryAddress;

    for( usBufferCounter = 0; usBufferCounter < usBufferLength; usBufferCounter++ ){
        vFlashWriteByte( ucMemorySelected, pcData[ usBufferCounter ], ulFlashAddress );
        ulFlashAddress++;
    }
    UART1_Write( '\r' );
    UART1_Write( '\n' );

    ulFlashAddress = ulMemoryAddress;

    for( usBufferCounter = 0; usBufferCounter < usBufferLength; usBufferCounter++ ){
        ucTempValue = 0;
        ucTempValue = ucFlashReadByte( ucMemorySelected, ulFlashAddress );
        if( pcData[ usBufferCounter ] != ucTempValue ){
            return 0;
        }
        ulFlashAddress++;
    }
    UART1_Write( '\r' );
    UART1_Write( '\n' );

    return 1;
}

/*********************************************************************
 * 
*********************************************************************/
uint8_t ucFlashReadByte( uint8_t ucMemorySelected, uint32_t ulMemoryAddress ){
    uint8_t ucTemp = 0;

    FlashCS = 0;
    SPI1_Write( _SERIAL_FLASH_CMD_READ );
    SPI1_Write( Higher( ulMemoryAddress ) );
    SPI1_Write( Hi( ulMemoryAddress ) );
    SPI1_Write( Lo( ulMemoryAddress ) );
    ucTemp = SPI1_Read( 0 );
    FlashCS = 1;

    return ucTemp;
}

/*********************************************************************
 * 
*********************************************************************/
uint16_t usFlashReadWord( uint8_t ucMemorySelected, uint32_t ulMemoryAddress ){
    uint16_t usTemp = 0;

    Hi( usTemp ) = ucFlashReadByte( ucMemorySelected, ulMemoryAddress );
    Lo( usTemp ) = ucFlashReadByte( ucMemorySelected, ulMemoryAddress + 1 );
    
    return usTemp;
}

/*********************************************************************
 * 
*********************************************************************/
void vFlashReadArray( uint8_t ucMemorySelected, uint8_t * pcReceiverBuffer, uint16_t usBufferLength, uint32_t ulMemoryAddress ){
    FlashCS = 0;

    SPI1_Write( _SERIAL_FLASH_CMD_READ );
    SPI1_Write( Higher( ulMemoryAddress ) );
    SPI1_Write( Hi( ulMemoryAddress ) );
    SPI1_Write( Lo( ulMemoryAddress ) );

    while( usBufferLength-- ){
        *pcReceiverBuffer++ = SPI1_Read( 0 );
    }

    FlashCS = 1;
}

/*********************************************************************
 * 
*********************************************************************/
uint8_t ucFlashReadId( uint8_t ucMemorySelected ){
    uint8_t ucTemp = 0;

    FlashCS = 0;

    SPI1_Write( _SERIAL_FLASH_CMD_RDID );
    ucTemp = SPI1_Read( 0 );
    
    FlashCS = 1;

    return ucTemp;
}

/*********************************************************************
 * 
*********************************************************************/
void vFlashResetWriteProtection( uint8_t ucMemorySelected ){
    FlashCS = 0;
    SPI1_Write( _SERIAL_FLASH_CMD_EWSR );
    FlashCS = 1;

    FlashCS = 0;
    SPI1_Write( _SERIAL_FLASH_CMD_EWSR );
    SPI1_Write( 0 );
    FlashCS = 1;
}

/*********************************************************************
 * 
*********************************************************************/
void vFlashChipErase( uint8_t ucMemorySelected ){
    
    vFlashWriteEnable( ucMemorySelected );

    FlashCS = 0;
    SPI1_Write( _SERIAL_FLASH_CMD_ERASE );
    FlashCS = 1;

    while( ucFlashIsWriteBusy( ucMemorySelected ) );
}

/*********************************************************************
 * 
*********************************************************************/
void vFlashSectorErase( uint8_t ucMemorySelected, uint32_t ulMemoryAddress ){
    
    vFlashWriteEnable( ucMemorySelected );

    FlashCS = 0;

    SPI1_Write( _SERIAL_FLASH_CMD_SER );
    SPI1_Write( Higher( ulMemoryAddress ) );
    SPI1_Write( Hi( ulMemoryAddress ) );
    SPI1_Write( Lo( ulMemoryAddress ) );

    FlashCS = 1;

    while( ucFlashIsWriteBusy( ucMemorySelected ) );
}

/*********************************************************************
 * 
*********************************************************************/

/*******************************************************************************************************************************************************************************************************
 * End of File
*******************************************************************************************************************************************************************************************************/