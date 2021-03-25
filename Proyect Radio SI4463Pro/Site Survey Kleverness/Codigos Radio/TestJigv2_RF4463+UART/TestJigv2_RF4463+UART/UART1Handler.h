/*******************************************************************************************************************************************************************************************************
 * Begin of header
*******************************************************************************************************************************************************************************************************/
#ifndef __UART1HANDLER_H__
#define __UART1HANDLER_H__
/******************************************************************************************************************************************************************************************************/
/**********************************************************************************************
 * Core Includes
**********************************************************************************************/
#include "main.h"
/**********************************************
 * File Includes
**********************************************/
/**********************************************
 * Support Libraries
**********************************************/
#include "rf4463handler.h"
/**********************************************************************************************
 * Documentation group assignation/include
**********************************************************************************************/
/**
 * @addtogroup  MODULE_NAME
 * @{
 */
/**********************************************************************************************
 * Definitions
**********************************************************************************************/
#define _KLGPIO_MODULE_USART1_PA9_10     0
#define _KLGPIO_MODULE_USART1_PB67       1

#define MAX_UART1_BUFFER_LENGTH     256
/**********************************************************************************************
 * Structures
**********************************************************************************************/

/**********************************************************************************************
 * Enumerators
**********************************************************************************************/

/**********************************************************************************************
 * Functions
**********************************************************************************************/
/**
 *  @brief Function that returns a result or evaluation with a parameter of fixed value
 *  
 *  @details
 * 
 *  @param[ in ]    
 *  @param[ out ]   
 *  
 *  @return
*/
void vUART1MessageHandler();

/**
 *  @brief Function that returns a result or evaluation with a parameter of fixed value
 *  
 *  @details
 * 
 *  @param[ in ]    
 *  @param[ out ]   
 *  
 *  @return
*/
void vUARTTxInit();

/**
 *  @brief Function that returns a result or evaluation with a parameter of fixed value
 *  
 *  @details
 * 
 *  @param[ in ]    
 *  @param[ out ]   
 *  
 *  @return
*/
void vUARTRxInit();

/**
 *  @brief Function that returns a result or evaluation with a parameter of fixed value
 *  
 *  @details
 * 
 *  @param[ in ]    
 *  @param[ out ]   
 *  
 *  @return
*/
void vUART1_Init_Advanced ( unsigned long ulBaudRate, unsigned int uiDataBits , unsigned int uiParity, unsigned int uiStopBits, unsigned char ucTerminalMap );

/**
 *  @brief Function that returns a result or evaluation with a parameter of fixed value
 *  
 *  @details
 * 
 *  @param[ in ]    
 *  @param[ out ]   
 *  
 *  @return
*/
void vUART1_Write( unsigned char pcByte );

/**
 *  @brief Function that returns a result or evaluation with a parameter of fixed value
 *  
 *  @details
 * 
 *  @param[ in ]    
 *  @param[ out ]   
 *  
 *  @return
*/
void vUART1_Write_Text( unsigned char *pcBuffer );

/**********************************************************************************************
 * Setters and Getters
**********************************************************************************************/
/**
 *  @brief Function that returns a result or evaluation with a parameter of fixed value
 *  
 *  @details
 * 
 *  @param[ in ]    
 *  @param[ out ]   
 *  
 *  @return
*/
uint8_t ucUART1MessageReady();

/**
 *  @brief Function that returns a result or evaluation with a parameter of fixed value
 *  
 *  @details
 * 
 *  @param[ in ]    
 *  @param[ out ]   
 *  
 *  @return
*/
void vUART1ResetIRQFlag();

/**
 *  @brief Function that returns a result or evaluation with a parameter of fixed value
 *  
 *  @details
 * 
 *  @param[ in ]    
 *  @param[ out ]   
 *  
 *  @return
*/
void vUART1ResetRxBuffer();

/******************************************************************************************************************************************************************************************************/
/**
 * @}
 */
#endif
/*******************************************************************************************************************************************************************************************************
 * End of File
*******************************************************************************************************************************************************************************************************/