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
#include "FlashHandler.h"
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
void vFlashInit(){
    SPI1_Init_Advanced( _SPI_FPCLK_DIV2, _SPI_MASTER | _SPI_8_BIT | _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION | _SPI_MSB_FIRST | 
                        _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI1_PA567 );

    GPIO_Digital_Output( &GPIOA_BASE, _GPIO_PINMASK_4 );

    UART1_Write_Text( "[ FLASH ] Start\r\n" );

    vW25Q128JVInit();
    vFlashWriteEnable( Select_Flash_1 );
    Delay_ms( 50 );
    vFlashTest();
}

/*********************************************************************
 * 
*********************************************************************/
void vFlashTest(){
    const uint8_t pcStringTest[] = "cf23df2207d99a74fbe169e3eba035e633b65d94";
    const uint8_t pcCompareTest[] = "da39a3ee5e6b4b0d3255bfef95601890afd80709";
    uint8_t pcEraseTest[ 40 ];
    
    uint8_t ucTempText[ 7 ];
    uint8_t TempData = 0;
    uint8_t FlashID = 0;

    uint8_t ucTempValue = 0;
    uint16_t usFlashCounter = 0;
    uint32_t ulFlashAddress = 0;

    UART1_Write_Text( "[ FLASH ] Test\r\n" );

    UART1_Write_Text( "[ FLASH ] Bank 1 ID: " );
    FlashID = ucFlashReadId( Select_Flash_1 );
    ByteToStr( FlashID, ucTempText );
    UART1_Write_Text( ucTempText );
    UART1_Write( '\r' );
    UART1_Write( '\n' );

    // UART1_Write_Text( "[ FLASH ] Bank 1 Erase\r\n" );
    // vFlashChipErase( Select_Flash_1 );
    // Delay_ms( 100 );

    UART1_Write_Text( "[ FLASH ] ------------------------------------------ Bank 1 Test Start ------------------------------------------\r\n" );
    // SECTOR ERASE
    vFlashSectorErase( Select_Flash_1, TEST_BLOCK_ADDRESS );
    // READ
    ulFlashAddress = TEST_BLOCK_ADDRESS;
    for( usFlashCounter = 0; usFlashCounter < 50; usFlashCounter++ ){
        UART1_Write( ucFlashReadByte( Select_Flash_1, ulFlashAddress++ ) );
    }
    UART1_Write( '\r' );
    UART1_Write( '\n' );
    // WRITE
    ulFlashAddress = TEST_BLOCK_ADDRESS;
    for( usFlashCounter = 0; usFlashCounter < 40; usFlashCounter++ ){
        vFlashWriteByte( Select_Flash_1, pcStringTest[ usFlashCounter ], ulFlashAddress++ );
    }
    // READ
    ulFlashAddress = TEST_BLOCK_ADDRESS;
    for( usFlashCounter = 0; usFlashCounter < 50; usFlashCounter++ ){
        UART1_Write( ucFlashReadByte( Select_Flash_1, ulFlashAddress++ ) );
    }
    UART1_Write( '\r' );
    UART1_Write( '\n' );
    // SECTOR ERASE
    vFlashSectorErase( Select_Flash_1, TEST_BLOCK_ADDRESS );
    // READ
    ulFlashAddress = TEST_BLOCK_ADDRESS;
    for( usFlashCounter = 0; usFlashCounter < 50; usFlashCounter++ ){
        UART1_Write( ucFlashReadByte( Select_Flash_1, ulFlashAddress++ ) );
    }
    UART1_Write( '\r' );
    UART1_Write( '\n' );
    // WRITE
    ulFlashAddress = TEST_BLOCK_ADDRESS;
    for( usFlashCounter = 0; usFlashCounter < 40; usFlashCounter++ ){
        vFlashWriteByte( Select_Flash_1, pcCompareTest[ usFlashCounter ], ulFlashAddress++ );
    }
    // READ
    ulFlashAddress = TEST_BLOCK_ADDRESS;
    for( usFlashCounter = 0; usFlashCounter < 50; usFlashCounter++ ){
        UART1_Write( ucFlashReadByte( Select_Flash_1, ulFlashAddress++ ) );
    }
    UART1_Write( '\r' );
    UART1_Write( '\n' );
    UART1_Write_Text( "[ FLASH ] ------------------------------------------ Bank 1 Test Done ------------------------------------------\r\n" );

    // while( 1 );
}

/*******************************************************************************************************************************************************************************************************
 * End of File
*******************************************************************************************************************************************************************************************************/