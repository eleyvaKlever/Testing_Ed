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
#include "Debug.h"
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
 * Semaphore Handlers
**********************************************************************************************/

/**********************************************************************************************
 * Task Handlers
**********************************************************************************************/
/*********************************************************************
 * Local Tasks
*********************************************************************/

/*********************************************************************
 * Global Tasks
*********************************************************************/

/**********************************************************************************************
 * Timer Handlers
**********************************************************************************************/

/**********************************************************************************************
 * IRQ Handlers
**********************************************************************************************/
/*********************************************************************
 * 
********************************************************************/

/**********************************************************************************************
 * Task declaration
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
#if LOG_LEVEL > LOG_LEVEL_NONE
    void vDebugPrint( uint8_t ucPrintData ){
        vUART1_Write( ucPrintData );
    }
#else
    void vDebugPrint();
#endif

/*******************************************************************************************************************************************************************************************************
 * End of File
*******************************************************************************************************************************************************************************************************/