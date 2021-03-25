/*******************************************************************************************************************************************************************************************************
 * Header declaration
 * Define to prevent recursive inclusion
*******************************************************************************************************************************************************************************************************/
#ifndef __MAIN_H__
#define __MAIN_H__
/******************************************************************************************************************************************************************************************************/
/**********************************************************************************************
 * IDE Defined Libraries
**********************************************************************************************/
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <built_in.h>

/**********************************************************************************************
 * Hardware Predefined Libraries
**********************************************************************************************/

/**********************************************************************************************
 * Definitions Headers
**********************************************************************************************/

/**********************************************************************************************
 * I/O Names and Definitions
**********************************************************************************************/

/**********************************************************************************************
 * Definitions
**********************************************************************************************/
#define MAX_UART_BUFFER_SIZE     64

#define UART_CMD_DELAY          Delay_ms( 300 );

/**********************************************************************************************
 * Enums
**********************************************************************************************/
enum{
    JIG_TYPE_OUTLET_CONTROL,
    JIG_TYPE_OUTLET_SUPPLY,
    JIG_TYPE_DIMMER_PAD,
    JIG_TYPE_DIMMER_SUPPLY,
    JIG_TYPE_SWITCH_PAD,
    JIG_TYPE_SWITCH_SUPPLY,
    JIG_TYPE_HUB,   
    JIG_TYPE_TOTAL
} JigTypeAnswer;

enum{
    HARDWARE_TYPE_OUTLET_CONTROL,
    HARDWARE_TYPE_OUTLET_SUPPLY,
    HARDWARE_TYPE_DIMMER_PAD,
    HARDWARE_TYPE_DIMMER_SUPPLY,
    HARDWARE_TYPE_SWITCH_PAD,
    HARDWARE_TYPE_SWITCH_SUPPLY,
    HARDWARE_TYPE_HUB,
    HARDWARE_TYPE_TOTAL
} HardwareTypeAnswer;

enum{
    UART_SW_CMD_WHO,
    UART_SW_CMD_INTERFACE,
    UART_SW_CMD_RESTART_DEVICE,
    UART_SW_CMD_BUZZER,
    UART_SW_CMD_REBOOT_JIG,
    UART_SW_CMD_ESP32_PROG_EN,
    UART_SW_CMD_ESP32_PROG_DIS,
    UART_SW_CMD_ADC,
    UART_SW_CMD_SET_STATION,
    UART_SW_CMD_GET_STATION,
    UART_SW_CMD_DIMMER_SUPPLY_ON,
    UART_SW_CMD_DIMMER_SUPPLY_OFF,
    UART_SW_CMD_TEST,
    UART_SW_CMD_GET_RANDOM,
    UART_SW_CMD_LED_PASS,
    UART_SW_CMD_LED_FAIL,
    UART_SW_CMD_LED_OFF,
    UART_SW_CMD_SOUND_FAIL,
    UART_SW_CMD_SOUND_PASS,
    UART_SW_CMD_GET_HARDWARE_ERROR,
    UART_SW_CMD_SET_START,
    UART_SW_CMD_GET_VERSION,
    UART_SW_CMD_GET_POINT,
    UART_SW_CMD_FLOW,
    UART_SW_CMD_TOTAL
} UARTSoftwareCommands;

enum{
    UART_HW_CMD_BOOT_START,
    UART_HW_CMD_BOOT_DONE,
    UART_HW_CMD_FTY_A,
    UART_HW_CMD_SET_STATION,
    UART_HW_CMD_LOOP,
    UART_HW_CMD_FTY_B,
    UART_HW_CMD_DIMMER_START,
    UART_HW_CMD_DIMMER_DONE,
    UART_HW_CMD_APP_START,
    UART_HW_CMD_ERROR_HUB_EEPROM,
    UART_HW_CMD_ERROR_HUB_FLASH,
    UART_HW_CMD_ERROR_HUB_RW_FLASH_1,
    UART_HW_CMD_ERROR_HUB_RW_FLASH_2,
    UART_HW_CMD_ERROR_HUB_ESP32,
    UART_HW_CMD_ERROR_HUB_RF4463,
    UART_HW_CMD_ERROR_HUB_LAN8720,
    UART_HW_CMD_FTY_C,
    UART_HW_CMD_TOTAL
} UARTHardwareCommands;

enum{
    DEVICE_STAGE_NONE = 0,
    DEVICE_STAGE_A,
    DEVICE_STAGE_B,
    DEVICE_STAGE_C,
    DEVICE_STAGE_TOTAL
} UARTStage;

/******************************************************************************************************************************************************************************************************/
#endif
/*******************************************************************************************************************************************************************************************************
 * End of File
*******************************************************************************************************************************************************************************************************/