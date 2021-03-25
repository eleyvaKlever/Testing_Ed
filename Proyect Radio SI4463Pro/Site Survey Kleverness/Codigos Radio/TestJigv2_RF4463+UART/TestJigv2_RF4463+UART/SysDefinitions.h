/*******************************************************************************************************************************************************************************************************
 * Begin of header
*******************************************************************************************************************************************************************************************************/
#ifndef __SYSDEFINITIONS_H__
#define __SYSDEFINITIONS_H__
/******************************************************************************************************************************************************************************************************/
/**********************************************************************************************
 * Core Includes
**********************************************************************************************/
#include "main.h"
/**********************************************************************************************
 * Definitions
**********************************************************************************************/
/*********************************************************************
 * 
*********************************************************************/
#define NULL ( ( void * )0 )
#define GET_UNTIL_HERE      while( 1 );

#define NOT_SUCCESS     1
#define SUCCESS         0
/**********************************************************************************************
 * Structures
**********************************************************************************************/
typedef struct{
    uint8_t Major;  ///<MAJOR version when you make incompatible API changes
    uint8_t Minor;  ///<MINOR version when you add functionality in a backwards compatible manner
    uint8_t Build;  ///<PATCH version when you make backwards compatible bug fixes
} FirmwareVersion_t; ///< Semantic Version Fields
/*********************************************************************
 * Ddebug Level
*********************************************************************/
#define LOG_LEVEL_NONE      0x00
#define LOG_LEVEL_ERROR     0x01
#define LOG_LEVEL_INFO      0x02
#define LOG_LEVEL_DEBUG     0x03
#define LOG_LEVEL_VERBOSE   0x04
/**********************************************************************************************
 * Section
**********************************************************************************************/
/**
 * @__addtogroup
 * @{
 */
/*********************************************************************
 * Variables
*********************************************************************/
/*********************************************************************
 * Definitions
*********************************************************************/
/*********************************************************************
 * Structures
*********************************************************************/
/*********************************************************************
 * Enumerators
*********************************************************************/
/*********************************************************************
 * Functions
*********************************************************************/
/**
 * @}
 */

/**********************************************************************************************
 * Group Definitions
**********************************************************************************************/
/**
 *  @defgroup MODULE_NAME
 * 
 *  @brief
 *  None
 * 
 *  @details
 *  None
*/

/******************************************************************************************************************************************************************************************************/
#endif
/*******************************************************************************************************************************************************************************************************
 * End of File
*******************************************************************************************************************************************************************************************************/