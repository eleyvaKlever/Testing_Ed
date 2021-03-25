/*******************************************************************************************************************************************************************************************************
 * Begin of header
*******************************************************************************************************************************************************************************************************/
#ifndef __DEBUG_H__
#define __DEBUG_H__
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
#include "UART1Handler.h"
/**********************************************************************************************
 * Definitions
**********************************************************************************************/
#define GET_UNTIL_HERE      while( 1 );

#define TAG_ERROR       "[ E ]"
#define TAG_INFO        "[ I ]"
#define TAG_DEBUG       "[ D ]"
#define TAG_VERBOSE     "[ V ]"

#if LOG_LEVEL > LOG_LEVEL_NONE 
    #define Pointer     vDebugPrint
#else
    #define LOG_INIT()
#endif

#if LOG_LEVEL >= LOG_LEVEL_ERROR
    #define STM_LOGE( xFormat, ... ) PrintOut( Pointer, xFormat, __VA_ARGS__ )
#else
    #define STM_LOGE( ... )
#endif

#if LOG_LEVEL >= LOG_LEVEL_INFO
    #define STM_LOGI( xFormat, ... ) PrintOut( Pointer, xFormat, __VA_ARGS__ )
#else
    #define STM_LOGI( ... )
#endif

#if LOG_LEVEL >= LOG_LEVEL_DEBUG
    #define STM_LOGD( xFormat, ... ) PrintOut( Pointer, xFormat, __VA_ARGS__ )
#else
    #define STM_LOGD( ... )
#endif

#if LOG_LEVEL == LOG_LEVEL_VERBOSE
    #define STM_LOGV( xFormat, ... ) PrintOut( Pointer, xFormat, __VA_ARGS__ )
#else
    #define STM_LOGV( ... )
#endif
/**********************************************************************************************
 * Structures and Enum
**********************************************************************************************/
/**********************************************************************************************
 * Functions
**********************************************************************************************/
#if LOG_LEVEL > LOG_LEVEL_NONE
    void vDebugPrint( uint8_t ucPrintData );
#else
    void vDebugPrint();
#endif

/******************************************************************************************************************************************************************************************************/
#endif
/*******************************************************************************************************************************************************************************************************
 * End of File
*******************************************************************************************************************************************************************************************************/