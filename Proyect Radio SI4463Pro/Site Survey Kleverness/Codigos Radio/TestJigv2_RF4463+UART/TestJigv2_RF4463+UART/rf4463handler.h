/*******************************************************************************************************************************************************************************************************
 * Begin of header
*******************************************************************************************************************************************************************************************************/
#ifndef __RF4463HANDLER_H__
#define __RF4463HANDLER_H__
/******************************************************************************************************************************************************************************************************/
/**********************************************************************************************
 * Core Includes
**********************************************************************************************/
#include "main.h"
/**********************************************
 * File Includes
**********************************************/
#include "rf4463pro.h"
#include "rf4463spi.h"
/**********************************************
 * Support Libraries
**********************************************/
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
#define RF4463_DEFAULT_TX_POWER       RF_TX_POWER_20dBm

#define REMOTE_DEFAULT          2
#define NODE_BROADCAST          255
#define NODE_DEFAULT            1

#define RF4463_DEFAULT_CHANNEL      5
#define RF4463_DEFAULT_NETWORK      RF4463_DEFAULT_CHANNEL

#define MIN_RF_CHANNEL          1
#define MAX_RF_CHANNEL          25
#define MAX_RF_NETWORK          sizeof( uint16_t )


#define RF_MESSAGE_HEADER_SIZE    3
#define RF_MESSAGE_SIZE           0
#define RF_MESSAGE_DESTINATION    1
#define RF_MESSAGE_SOURCE         2
/**********************************************************************************************
 * Structures
**********************************************************************************************/
typedef struct{
    uint8_t Node;
    uint8_t Channel;
    uint8_t BaudRate;
    uint8_t TxPower;
    uint16_t Network;
} RadioParameters_t;
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
void vRF4463MesageHandler();

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
void vRF4463TxMessage( uint8_t * pcOutBuffer, uint8_t ucLength, uint8_t ucRemoteNode );

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
uint8_t ucRF4463Setup( uint8_t ucRxChannel, uint8_t ucTxChannel, uint16_t usNetwork, uint8_t ucTxPower );

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
uint8_t ucRF4463GetIRQFlag();

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
void vRF4463ResetIRQFlag();

/******************************************************************************************************************************************************************************************************/
/**
 * @}
 */
#endif
/*******************************************************************************************************************************************************************************************************
 * End of File
*******************************************************************************************************************************************************************************************************/