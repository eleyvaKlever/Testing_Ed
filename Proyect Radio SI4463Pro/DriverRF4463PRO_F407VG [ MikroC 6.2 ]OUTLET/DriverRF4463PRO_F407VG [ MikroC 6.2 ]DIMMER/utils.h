/*******************************************************************************************************************************************************************************************************
 * Begin of header
*******************************************************************************************************************************************************************************************************/
#ifndef __UTILS_H__
#define __UTILS_H__
/******************************************************************************************************************************************************************************************************/
/**********************************************************************************************
 * Core Includes
**********************************************************************************************/
//#include "main.h"
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
unsigned char ucASCIIToByte( unsigned char * pcASCIIBuffer );

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
void vASCIIToHex( unsigned char *pcHexConvertBuffer, unsigned char *pcASCIIConvertBuffer, unsigned char ucConversionLength );

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
void vHexToASCII( unsigned char *pcASCIIConvertBuffer, unsigned char *pcHexConvertBuffer, unsigned char ucConversionLength );

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
void vBufferSetToZero( unsigned char * pcBufferToClean, unsigned int uslength );

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
void vBufferSetTo255( unsigned char * pcBufferToClean, unsigned int uslength );

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
void vBufferSetToValue( unsigned char * pcBufferToClean, unsigned char ucValue, unsigned int uslength );

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
void vSerializeUUID( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer );

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
void vSerializeMACAddress( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer );

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
void vSerializeIPAddress( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer );

/******************************************************************************************************************************************************************************************************/
/**
 * @}
 */
#endif
/*******************************************************************************************************************************************************************************************************
 * End of File
*******************************************************************************************************************************************************************************************************/