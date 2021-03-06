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
#include "SysDefinitions.h"
/**********************************************************************************************
 * Definitions and Enums
**********************************************************************************************/
#define DEVICE_MODEL_ID         DEVICE_MODEL_ID_DONGLE
#define DEVICE_COMPONENT_ID     DEVICE_COMPONENT_ID_DONGLE
/**********************************************************************************************
 * Definitions
**********************************************************************************************/
/**********************************************************************************************
 * 
**********************************************************************************************/
const uint8_t pcOverrideKey[ DEVICE_MODEL_ID_TOTAL ][ RF_OVERRIDE_KEY_SIZE ] = {
    /*********************************************************************
     * Dongle Key
    *********************************************************************/
    {
        0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
        0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
    },
    /*********************************************************************
     * Hub Key
    *********************************************************************/
    {
        0x7B, 0x32, 0x53, 0x64, 0x54, 0x65, 0x71, 0x69, 0x36, 0x28, 0x4C, 0x5A, 0x40, 0x51, 0x54, 0x5D,
        0x68, 0x26, 0x47, 0x36, 0x57, 0x5D, 0x4F, 0x35, 0x4C, 0x47, 0x43, 0x59, 0x56, 0x40, 0x7A, 0x7B
    },
    /*********************************************************************
     * Switch Key
    *********************************************************************/
    {
        0xDA, 0xE5, 0xA0, 0x27, 0x6F, 0x0B, 0xF4, 0xDD, 0x02, 0x4F, 0x8E, 0x5B, 0xAD, 0x93, 0x25, 0x1B, 
        0xDA, 0x1D, 0xEF, 0x31, 0xA1, 0x40, 0x96, 0xBA, 0x71, 0x00, 0x1C, 0xA5, 0xB5, 0x85, 0x6E, 0xFE
    },
    /*********************************************************************
     * Dimmer Key
    *********************************************************************/
    {
        0x2A, 0x1F, 0xD2, 0xBE, 0xC6, 0x5B, 0xEA, 0xD7, 0x3D, 0xD4, 0xE6, 0x79, 0xE3, 0x32, 0x2A, 0x53, 
        0x48, 0xF6, 0x72, 0xB7, 0x67, 0x1B, 0x56, 0x7C, 0xF4, 0xD6, 0x48, 0xC7, 0x8C, 0x48, 0x59, 0x2D
    },
    /*********************************************************************
     * Outlet Key
    *********************************************************************/
    {
        0x05, 0x53, 0x1D, 0xC0, 0x13, 0x31, 0x95, 0x7C, 0xDF, 0xB3, 0x72, 0x82, 0x53, 0x32, 0xFE, 0x05, 
        0x04, 0xFE, 0xC9, 0x81, 0xC3, 0x50, 0x7D, 0xF9, 0x30, 0x81, 0xF6, 0x9A, 0x38, 0xF2, 0x2A, 0x14
    }
};
/**********************************************************************************************
 * Configuration Variables
**********************************************************************************************/
/*********************************************************************
 * RF4463 Pro
*********************************************************************/
const uint8_t * pcModelPrefix[] = {
    "DO",
    "KH",
    "KS",
    "KD",
    "KO"
};

// uint8_t ucRemoteNode = 0;
// uint8_t ucSenderNode = 0;
// uint8_t ucTableIndex = 0;
// uint8_t ucCommandIndex = 0;
/*********************************************************************
 * Miscellaneous
*********************************************************************/
static uint8_t pcSentQR[ 15 ];
static uint8_t pcReceivedQR[ 15 ];
/*********************************************************************
 * Auxiliar
*********************************************************************/
uint8_t pcTempQR[ 15 ];
uint8_t ucSearchedModelId = 0;
/**********************************************************************************************
 * Flags
**********************************************************************************************/
/*********************************************************************
 * UART
*********************************************************************/
uint8_t ucUARTDataReady = 0;
/*********************************************************************
 * RF4463 Pro
*********************************************************************/
uint8_t ucRF4463TxEvent = 0;
uint8_t ucRadioEvent    = 0;
/*********************************************************************
 * Timer
*********************************************************************/
uint8_t ucSearchActive  = 0;
/**********************************************************************************************
 * Segment
**********************************************************************************************/
/*********************************************************************
 * Sub Segment
*********************************************************************/
const uint8_t * pcModelQRPrefix[] = {
    "DO",
    "KH",
    "KS",
    "KD",
    "KO"
};
/*******************************************************************************************************************************************************************************************************
 * End of File
*******************************************************************************************************************************************************************************************************/