/*******************************************************************************************************************************************************************************************************
 * Begin of header
*******************************************************************************************************************************************************************************************************/
#ifndef __FLASHW25Q128JB_H__
#define __FLASHW25Q128JB_H__
/******************************************************************************************************************************************************************************************************/
/**********************************************************************************************
 * Include
**********************************************************************************************/
#include "main.h"
/**********************************************
 * File Libraries
**********************************************/
/**********************************************
 * Additional Libraries
**********************************************/
/**********************************************************************************************
 * Definitions
**********************************************************************************************/
#define _SERIAL_FLASH_CMD_RDID      0x9F    // 25P80
#define _SERIAL_FLASH_CMD_READ      0x03
#define _SERIAL_FLASH_CMD_WRITE     0x02
#define _SERIAL_FLASH_CMD_WREN      0x06
#define _SERIAL_FLASH_CMD_RDSR      0x05
#define _SERIAL_FLASH_CMD_ERASE     0xC7    // 25P80
#define _SERIAL_FLASH_CMD_EWSR      0x06    // 25P80 ver
#define _SERIAL_FLASH_CMD_WRSR      0x01
#define _SERIAL_FLASH_CMD_SER       0xD8    //25P80

#define SECTOR_SIZE 4096

enum{
    Select_Flash_1 = 1,
    Select_Flash_2 = 2,
    Select_Flash
};

/**********************************************************************************************
 * Functions
**********************************************************************************************/
void vW25Q128JVInit();

/**********************************************
 * Write Functions
**********************************************/
void vFlashWriteEnable( uint8_t ucMemorySelected );

uint8_t ucFlashIsWriteBusy( uint8_t ucMemorySelected );

void vFlashWriteByte( uint8_t ucMemorySelected, uint8_t pcData, uint32_t ulMemoryAddress );

void vFlashWriteWord( uint8_t ucMemorySelected, uint16_t pcData, uint32_t ulMemoryAddress );

uint8_t ucFlashWriteArray( uint8_t ucMemorySelected, uint8_t * pcData, uint16_t usBufferLength, const uint32_t ulMemoryAddress );

/**********************************************
 * Read Functions
**********************************************/
uint8_t ucFlashReadByte( uint8_t ucMemorySelected, uint32_t ulMemoryAddress );

uint16_t usFlashReadWord( uint8_t ucMemorySelected, uint32_t ulMemoryAddress );

void vFlashReadArray( uint8_t ucMemorySelected, uint8_t * pcReceiverBuffer, uint16_t usBufferLength, uint32_t ulMemoryAddress );

/**********************************************
 * Chip Functions
**********************************************/
uint8_t ucFlashReadId( uint8_t ucMemorySelected );

void vFlashResetWriteProtection( uint8_t ucMemorySelected );

void vFlashChipErase( uint8_t ucMemorySelected );

void vFlashSectorErase( uint8_t ucMemorySelected, uint32_t ulMemoryAddress );

void vFlashReset( uint8_t ucMemorySelected );

/******************************************************************************************************************************************************************************************************/
#endif
/*******************************************************************************************************************************************************************************************************
 * End of File
*******************************************************************************************************************************************************************************************************/