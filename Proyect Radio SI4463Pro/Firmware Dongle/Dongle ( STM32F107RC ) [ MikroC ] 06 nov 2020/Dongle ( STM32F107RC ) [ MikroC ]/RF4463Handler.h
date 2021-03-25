/*******************************************************************************************************************************************************************************************************
 * Begin of header
*******************************************************************************************************************************************************************************************************/
#ifndef __RF4463HANDLER_H__
#define __RF4463HANDLER_H__
/******************************************************************************************************************************************************************************************************/
/**********************************************************************************************
 * Include
**********************************************************************************************/
#include "main.h"
/**********************************************
 * File Libraries
**********************************************/
#include "rf4463pro.h"
#include "rf4463spi.h"
/**********************************************
 * Additional Libraries
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
#define NODE_DEFAULT            1
#define HUB_NODE                1
#define REMOTE_DEFAULT          2
#define TEST_NODE               2
#define NODE_FACTORY            254
#define NODE_BROADCAST          255

#define RSSI_POOR_THRESHOLD     -80
#define RSSI_BAD_THRESHOLD      -100
#define RSSI_BAD_READ_VALUE     -124

#define RF4463_DEFAULT_TX_POWER       RF_TX_POWER_20dBm

#define RF4463_DEFAULT_CHANNEL      5
#define RF4463_DEFAULT_NETWORK      RF4463_DEFAULT_CHANNEL

#define MIN_RF_CHANNEL          1
#define MAX_RF_CHANNEL          25
#define MAX_RF_NETWORK          sizeof( uint16_t )

#define RF_MESSAGE_HEADER_SIZE    3
#define RF_MESSAGE_SIZE           0
#define RF_MESSAGE_DESTINATION    1
#define RF_MESSAGE_SOURCE         2
/**********************************************
 * Buffer Positions
**********************************************/
#define RF_MESSAGE_HEADER_SIZE     5
/**********************************************/
#define RF_MESSAGE_SIZE           0
#define RF_MESSAGE_DESTINATION    1
#define RF_MESSAGE_SOURCE         2
#define RF_MESSAGE_TABLE          3
#define RF_MESSAGE_COMMAND        4
#define RF_MESSAGE_CONTENT        5
/**********************************************
 * Device Setup Steps
**********************************************/
#define RF_DEVICE_APPLY_CONFIG    2
#define RF_DEVICE_SET_ADOPTION    1
#define RF_DEVICE_REMOVE   0
/**********************************************
 * Values for Database
**********************************************/
#define DB_STATE_ON         1
#define DB_STATE_OFF        2
#define DB_STATE_DISABLED    3
/**********************************************
 * Values for Devices
**********************************************/
#define THREEWAY_NOT_DEFINED     0
#define THREEWAY_MASTER_MODE     1
#define THREEWAY_SLAVE_MODE      2
/**********************************************
 * 
**********************************************/
#define DEVICE_COMMMAND_APPLIED     1
#define DEVICE_COMMMAND_INVALID     2
/**********************************************
 * Status message response
**********************************************/
#define RF_DEVICE_STATUS_ADOPTED                5
#define RF_DEVICE_STATUS_ADOPTION_PENDING       6
#define RF_DEVICE_STATUS_REMOVAL_PENDING        7
#define RF_DEVICE_STATUS_NODE                   8
#define RF_DEVICE_STATUS_HUB_NODE               9
#define RF_DEVICE_STATUS_NETWORK_MSB            10
#define RF_DEVICE_STATUS_NETWORK_LSB            11

#define RF_DEVICE_STATUS_DM_LEVEL_LOAD          12
#define RF_DEVICE_STATUS_DM_LOCK                13
#define RF_DEVICE_STATUS_DM_SLEEP               14

#define RF_DEVICE_STATUS_OT_LOAD                12
#define RF_DEVICE_STATUS_OT_SLEEP               13
#define RF_DEVICE_STATUS_OT_LOCK                14

#define RF_DEVICE_STATUS_SW_DETECTED_LOADS      12
#define RF_DEVICE_STATUS_SW_DEFINED_LOADS       13
#define RF_DEVICE_STATUS_SW_HAS_GANG_1          14
#define RF_DEVICE_STATUS_SW_HAS_GANG_2          15
#define RF_DEVICE_STATUS_SW_HAS_GANG_3          16
#define RF_DEVICE_STATUS_SW_LOAD1               17
#define RF_DEVICE_STATUS_SW_LOAD2               18
#define RF_DEVICE_STATUS_SW_LOAD3               19
/**********************************************
 * Adoption request settings posisitions
**********************************************/
#define RF_CONFIG_POSITION_UID_START        5
#define RF_CONFIG_POSITION_NODE             17
#define RF_CONFIG_POSITION_HUB_NODE         18
#define RF_CONFIG_POSITION_CHANNEL          19
#define RF_CONFIG_POSITION_TX_POWER         20
#define RF_CONFIG_POSITION_NETWORK_MSB      21
#define RF_CONFIG_POSITION_NETWORK_LSB      22
#define RF_CONFIG_POSITION_BAUDRATE         23
/**********************************************
 * Find by QR response positions
**********************************************/
#define RF_CONFIG_DEVICE_SWITCH_MESSAGE_SIZE    24

#define RF_CONFIG_DEVICE_POSITION_UID_START         5
#define RF_CONFIG_DEVICE_POSITION_LOADS             17

#define RF_CONFIG_DEVICE_LOAD_STATUS                18
#define RF_CONFIG_DEVICE_POSITION_VERSION_MAJOR     19
#define RF_CONFIG_DEVICE_POSITION_VERSION_MINOR     20
#define RF_CONFIG_DEVICE_POSITION_VERSION_BUILD     21

#define RF_CONFIG_DEVICE_POSITION_SWITCH_LOAD1             18
#define RF_CONFIG_DEVICE_POSITION_SWITCH_LOAD2             19
#define RF_CONFIG_DEVICE_POSITION_SWITCH_LOAD3             20
#define RF_CONFIG_DEVICE_POSITION_SWITCH_VERSION_MAJOR     21
#define RF_CONFIG_DEVICE_POSITION_SWITCH_VERSION_MINOR     22
#define RF_CONFIG_DEVICE_POSITION_SWITCH_VERSION_BUILD     23
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
 * Tables with Commands
**********************************************************************************************/
enum RFCommandTables{
    TABLE_RF_TEST = 1,
    TABLE_RF_SETUP,
    TABLE_RF_OTA,
    TABLE_RF_GLOBAL,
    TABLE_RF_SWITCH,
    TABLE_RF_DIMMER,
    TABLE_RF_OUTLET,
    RF_TABLES
};

/**********************************************
 * Test Commands
**********************************************/
enum RFTestCommands{
    RF_TEST_DEVICE_PING = 0,
    RF_TEST_STATUS,
    /**********************************************
     * Reserved for factory purposes
    **********************************************/
    RF_TEST_QR,
    RF_TEST_OK,
    RF_TEST_STAGE,
    RF_TEST_LOOP,
    /**********************************************
     * 
    **********************************************/
    RF_TEST_CHANNEL,
    /**********************************************
     * 
    **********************************************/
    RF_TEST_MESSAGE,
    /**********************************************
     * 
    **********************************************/
    RF_TEST_INFO,
    RF_TEST_TABLE
};

#define RF_TEST_DONGLE_SEARCH 200     // Reserved for Dongle Purposes

/**********************************************
 * Device Configuration
**********************************************/
enum RFConfigurationCommands{
    RF_SETUP_DISCOVER = 0,
    RF_SETUP_FIND_BY_QR,
    RF_SETUP_SEND_CONFIG,
    RF_SETUP_REGISTER,
    RF_SETUP_PREPARE_REMOVAL,
    RF_SETUP_REMOVE,
    RF_SETUP_HARD_RESET_REQUEST,
    /**********************************************
     * Reserved for recovery purposes
    **********************************************/
    RF_SETUP_OVERRIDE_ENABLE,
    RF_SETUP_OVERRIDE_DISABLE,
    RF_SETUP_FTY_RESTORE,
    RF_SETUP_FTY_RECONFIGURE,
    RF_SETUP_FTY_DISCOVER,
    /**********************************************
     * 
    **********************************************/
    RF_SETUP_SET_MASTER,
    RF_SETUP_SET_SLAVE,
    RF_SETUP_TABLE
};

/**********************************************
 * File Transmission Commands
**********************************************/
enum RFFOTACommands{
    RF_FOTA_START = 0,
    RF_FOTA_START_ACK,
    RF_FOTA_HEADER,
    RF_FOTA_HEADER_ACK,
    RF_FOTA_LINE,
    RF_FOTA_LINE_ACK,
    RF_FOTA_LINE_NACK,
    RF_FOTA_EOT,
    RF_FOTA_EOT_ACK,
    RF_FOTA_ERROR,
    RF_FOTA_DONE,
    RF_FOTA_TABLE
};

/**********************************************
 * Global Commands ( Broadcast Transmission Purposes )
**********************************************/
enum RFGlobalCommands{
    RF_GLOBAL_ON = 0,
    RF_GLOBAL_OFF,
    GlobalTableSize
};

/**********************************************
 * Switch Commands
**********************************************/
enum RFSwitchCommands{
    RF_SWITCH_ON = 0,
    RF_SWITCH_OFF,
    RF_SWITCH_VIA1_ON,
    RF_SWITCH_VIA1_OFF,
    RF_SWITCH_VIA2_ON,
    RF_SWITCH_VIA2_OFF,
    RF_SWITCH_VIA3_ON,
    RF_SWITCH_VIA3_OFF,
    RF_SWITCH_SET_1_GANG,
    RF_SWITCH_SET_2_GANG,
    RF_SWITCH_SET_3_GANG,
    RF_SWITCH_SLEEP,
    RF_SWITCH_WAKE,
    RF_SWITCH_HAPTIC_ENABLE,
    RF_SWITCH_HAPTIC_DISABLE,
    RF_SWITCH_TOUCH_ENABLE,
    RF_SWITCH_TOUCH_DISABLE,
    RF_SWITCH_GET_CONSUMPTION,
    RF_SWITCH_TABLE
};

/**********************************************
 * Dimmer Commands
**********************************************/
enum RFDimmerCommands{
    RF_DIMMER_ON = 0,
    RF_DIMMER_OFF,
    RF_DIMMER_LEVEL_1,
    RF_DIMMER_LEVEL_2,
    RF_DIMMER_LEVEL_3,
    RF_DIMMER_LEVEL_4,
    RF_DIMMER_LEVEL_5,
    RF_DIMMER_GET_ACK,
    RF_DIMMER_TOUCH_ENABLE,
    RF_DIMMER_TOUCH_DISABLE,
    RF_DIMMER_SLEEP,
    RF_DIMMER_WAKE,
    RF_DIMMER_RECALIBRATE_SUPPLY,
    RF_DIMMER_IS_ONLINE,
    RF_DIMMER_GET_CONSUMPTION,
    RF_DIMMER_CALIBRATE_OFFSET,
    RF_DIMMER_SET_OFFSET,
    RF_DIMMER_TABLE
};

/**********************************************
 * Outlet Commands
**********************************************/
enum RFOutletCommands{
    RF_OUTLET_ON = 0,
    RF_OUTLET_OFF,
    RF_OUTLET_BUTTON_ENABLE,
    RF_OUTLET_BUTTON_DISABLE,
    RF_OUTLET_SLEEP,
    RF_OUTLET_WAKE,
    RF_OUTLET_GET_CONSUMPTION,
    RF_OUTLET_TABLE
};

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
void vRF4463TxMessage( uint8_t * pcOutBuffer, uint8_t ucLength, uint8_t ucRemoteNode, uint8_t ucTable, uint8_t ucCommand );

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
void vRF4463SetNode( uint8_t ucNode );
/**********************************************************************************************
 * 
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
void vRF4463RxCommand();

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
void vRF4463RxFTY();

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
uint8_t ucRF4463GetActiveId();

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
void vRF4463SetActive( uint8_t ucSelectRadio );

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
void vRF4463SetPinSelect( uint8_t ucPinVal );

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
void vRF4463SetPinSDN( uint8_t ucPinVal );

/**
 * @}
 */
/******************************************************************************************************************************************************************************************************/
#endif
/*******************************************************************************************************************************************************************************************************
 * End of File
*******************************************************************************************************************************************************************************************************/