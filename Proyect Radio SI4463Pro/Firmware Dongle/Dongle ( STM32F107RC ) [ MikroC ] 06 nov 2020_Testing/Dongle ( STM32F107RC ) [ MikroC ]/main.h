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
#include <built_in.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

#include "SysDefinitions.h"
#include "utils.h"
/**********************************************************************************************
 * I/O Names and Definitions
**********************************************************************************************/
/*********************************************************************
 * FLASH I/O
*********************************************************************/
#define FlashCS             GPIOA_ODR._GPIO_PIN_4
/*********************************************************************
 * Buzzer Pin
*********************************************************************/
#define BuzzerOut           GPIOB_ODR._GPIO_PIN_7
/*********************************************************************
 * RF4463Pro I/O
*********************************************************************/
#define RF4463nIRQ          GPIOC_IDR._GPIO_PIN_12

#define RF4463nSEL          GPIOB_ODR._GPIO_PIN_12
#define RF4463nSDN          GPIOB_ODR._GPIO_PIN_11
#define RF4463GPIO0         GPIOC_ODR._GPIO_PIN_11
#define RF4463GPIO1         GPIOC_ODR._GPIO_PIN_10
/*********************************************************************
 * Button Pin
*********************************************************************/
#define ButtonIRQ           GPIOB_IDR._GPIO_PIN_8
/*********************************************************************
 * LED Pin
*********************************************************************/
#define LEDRed              GPIOC_ODR._GPIO_PIN_6
#define LEDGreen            GPIOC_ODR._GPIO_PIN_7
#define LEDBlue             GPIOC_ODR._GPIO_PIN_8
/**********************************************************************************************
 * Definitions
**********************************************************************************************/
// #define SET_BAUDRATE_1000
#define SET_BAUDRATE_2400
// #define SET_BAUDRATE_4800
// #define SET_BAUDRATE_10000
/**********************************************************************************************
 * 
**********************************************************************************************/
#define ENABLE_DEBUG_RF_PACKET
// #define FACTORY_DONGLE
// #define PARSE_RF4463_RX
// #define RF4463_MESSAGE_IGNORE_HUB
/**********************************************************************************************
 * 
**********************************************************************************************/
/*********************************************************************
 * 
*********************************************************************/
#define LOG_LEVEL_NONE      0x00
#define LOG_LEVEL_ERROR     0x01
#define LOG_LEVEL_INFO      0x02
#define LOG_LEVEL_DEBUG     0x03
#define LOG_LEVEL_VERBOSE   0x04

// #define LOG_LEVEL   LOG_LEVEL_NONE
#define LOG_LEVEL   LOG_LEVEL_VERBOSE
/******************************************************************************************************************************************************************************************************/
#endif
/*******************************************************************************************************************************************************************************************************
 * End of File
*******************************************************************************************************************************************************************************************************/
 