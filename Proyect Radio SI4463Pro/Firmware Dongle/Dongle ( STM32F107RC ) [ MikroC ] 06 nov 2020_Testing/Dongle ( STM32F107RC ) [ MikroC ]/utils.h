/*******************************************************************************************************************************************************************************************************
 * Begin of header
*******************************************************************************************************************************************************************************************************/
#ifndef __UTILS_H__
#define __UTILS_H__
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
uint8_t ucASCIIToByte( uint8_t * pcASCIIBuffer );

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
void vASCIIToHex( uint8_t *pcHexConvertBuffer, uint8_t *pcASCIIConvertBuffer, uint8_t ucConversionLength );

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
void vHexToASCII( uint8_t *pcASCIIConvertBuffer, uint8_t *pcHexConvertBuffer, uint8_t ucConversionLength );

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
void vBufferSetToZero( uint8_t * pcBufferToClean, uint16_t uslength );

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
void vBufferSetTo255( uint8_t * pcBufferToClean, uint16_t uslength );

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
void vBufferSetToValue( uint8_t * pcBufferToClean, uint8_t ucValue, uint16_t uslength );

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
void vSerializeUUID( uint8_t * pcTextConvertBuffer, uint8_t * pcHexConvertBuffer );

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
void vSerializeMACAddress( uint8_t * pcTextConvertBuffer, uint8_t * pcHexConvertBuffer );

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
void vSerializeIPAddress( uint8_t * pcTextConvertBuffer, uint8_t * pcHexConvertBuffer );

/******************************************************************************************************************************************************************************************************/
/**
 * @}
 */
#endif
/*******************************************************************************************************************************************************************************************************
 * End of File
*******************************************************************************************************************************************************************************************************/