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
/**********************************************
 * Additional Libraries
**********************************************/
/**********************************************************************************************
 * Definitions
**********************************************************************************************/
/**********************************************
 * Buffer Positions
**********************************************/
#define RfMessageHeaderSize     5
/**********************************************/
#define RfMessageSize           0
#define RfMessageDestination    1
#define RfMessageSender         2
#define RfMessageTable          3
#define RfMessageCommand        4
#define RfMessageContent        5
/**********************************************
 * Device Setup Steps
**********************************************/
#define Device_Apply    2
#define Device_Setup    1
#define Device_Remove   0
/**********************************************
 * Values for Database
**********************************************/
#define StateOn         1
#define StateOff        2
#define StateDisable    3
/**********************************************
 * Tables with Commands
**********************************************/
enum{
    Table_RF_Test = 1,
    Table_RF_Setup,
    Table_RF_OTA,
    Table_RF_Global,
    Table_RF_Switch,
    Table_RF_Dimmer,
    Table_RF_Outlet,
    TotalTables
} RFCommandTable;
/**********************************************
 * Test Commands
**********************************************/
enum{
    Test_PingDevice = 0,
    Test_Status,
    Test_Device_QR,
    Test_Device_Ok,
    Test_Device_Stage,
    Test_Device_Loop,
    Test_Device_Channel,     // Added by Jhon | 5th August 2019
    Test_Device_Message,
    Test_Device_Info,
    TestTableSize,
    Test_Dongle_Search = 200     // Reserved for Dongle Purposes
} RFTestTable;
/**********************************************
 * Device Configuration
**********************************************/
enum{
    Setup_Discover = 0,
    Setup_Qr,
    Setup_Configure,
    Setup_Register,
    Setup_Remove,
    Setup_Delete,
    Setup_HardReset,
    /**********************************************
     * Reserved for recovery purposes,
    **********************************************/
    Setup_Override_Enable,
    Setup_Override_Disable,
    Setup_Factory_Reset,
    Setup_Reconfigure,
    Setup_Hard_Discover,
    SetupTableSize
} RFSetupTable;
/**********************************************
 * File Transmission Commands
**********************************************/
enum{
    OTA_RF_Start = 0,
    OTA_RF_StartACK,
    OTA_RF_Header,
    OTA_RF_HeaderACK,
    OTA_RF_Line,
    OTA_RF_LineACK,
    OTA_RF_LineNACK,
    OTA_RF_EOT,
    OTA_RF_EOTACK,
    OTA_RF_Error,
    OTATableSize
} RFOTATable;
/**********************************************
 * Global Commands ( Broadcast Transmission Purposes )
**********************************************/
enum{
    Global_On = 0,
    Global_Off,
    GlobalTableSize
} RF8GlobalTable;
/**********************************************
 * Switch Commands
**********************************************/
enum{
    Switch_On = 0,
    Switch_Off,
    Switch_Via1On,
    Switch_Via1Off,
    Switch_Via2On,
    Switch_Via2Off,
    Switch_Via3On,
    Switch_Via3Off,
    Switch_Set1Gang,
    Switch_Set2Gang,
    Switch_Set3Gang,
    Switch_Sleep,
    Switch_Wake,
    Switch_HapticEnable,
    Switch_HapticDisable,
    Switch_Enable,
    Switch_Disable,
    SwitchTableSize
} RFSwitchTable;
/**********************************************
 * Dimmer Commands
**********************************************/
enum{
    Dimmer_On = 0,
    Dimmer_Off,
    Dimmer_Lvl1,
    Dimmer_Lvl2,
    Dimmer_Lvl3,
    Dimmer_Lvl4,
    Dimmer_Lvl5,
    Dimmer_Enable,
    Dimmer_Disable,
    Dimmer_Sleep,
    Dimmer_Wake,
    DimmerTableSize
} RfDimmerTable;
/**********************************************
 * Outlet Commands
**********************************************/
enum{
    Outlet_On = 0,
    Outlet_Off,
    Outlet_Enable,
    Outlet_Disable,
    Outlet_Sleep,
    Outlet_Wake,
    OutletTableSize
} RFOutletTable;

/**********************************************************************************************
 * Functions
**********************************************************************************************/
void vRadioInit();

void vInitRF4463IRQ();

uint8_t ucInitRF4463Config();

void vRFRxMessage();

void vRfTxMessage( uint8_t * pcOutBuffer, uint16_t usLength );

void vRfSettingsHotSwap( uint8_t ucRfChannel, uint16_t usNetwork );

/******************************************************************************************************************************************************************************************************/
#endif
/*******************************************************************************************************************************************************************************************************
 * End of File
*******************************************************************************************************************************************************************************************************/