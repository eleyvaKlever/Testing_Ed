/**********************************************************************************************
 * IDE Defined Libraries
**********************************************************************************************/
#include <built_in.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include "radio_config_si4463.h"
#include "rf4463commands.h"

/*********************************************************************
 * RF4463Pro I/O
*********************************************************************/
//#define RF4463nSCK          GPIOB_ODR._GPIO_PIN_13
#define RF4463nSEL          GPIOB_ODR._GPIO_PIN_12
#define RF4463nIRQ          GPIOC_IDR._GPIO_PIN_12
#define RF4463nSDN          GPIOB_ODR._GPIO_PIN_11

#define RF4463GPIO0         GPIOC_IDR._GPIO_PIN_11
#define RF4463GPIO1         GPIOC_ODR._GPIO_PIN_10

#define BUZZER              GPIOB_ODR._GPIO_PIN_7
#define rstMCU              GPIOB_ODR._GPIO_PIN_8

#define LED_RED             GPIOC_ODR._GPIO_PIN_6
#define LED_GREEN           GPIOC_ODR._GPIO_PIN_7
#define LED_BLUE            GPIOC_ODR._GPIO_PIN_8

#define PIN_LEVEL_LOW   0
#define PIN_LEVEL_HIGH  1
#define NOT_SUCCESS     1
#define SUCCESS         0

#define         set_freq3       1
#define         set_freq2       2
#define         set_freq1       3
#define         set_power       4
#define         set_dr          5
#define         set_trmode      6               // set freq offset

#define         master_mode     0
#define         slave_mode      1
//#define               rf_off                  2
#define         tx_test_mode    2
#define         rx_test_mode    3
#define         rf_off          4

#define         tx_normal       0
#define         rx_normal       1
//#define               rf_off                  2
#define         tx_test         2
#define         rx_test         3
#define         rf_off          4

#define payload_length          14    //×Ü¹² header + 10¸ö×Ö½Ú

#define freq_channel            0 

#define step_500K_step1         0x88
#define step_500K_step0         0x89

#define deviation_20K_h         0x00
#define deviation_20K_m         0x05
#define deviation_20K_l         0x76

#define deviation_3K_h          0x00
#define deviation_3K_m          0x00
#define deviation_3K_l          0xd2

#define         dr_1p2                  0
#define         dr_2p4                  1
#define         dr_4p8                  2       
#define         dr_9p6                  3
#define         dr_19p2                 4
#define         dr_38p4                 5
#define         dr_76p8                 6
#define         dr_115p2                7
#define         dr_256k                 8
#define         dr_500k                 9
#define         dr_500                  10

const unsigned char RF_MODEM_MOD_TYPE_12[11][12] =
{
        0x03, 0x00, 0x07, 0x00, 0x12, 0xC0, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x00,                         // 1200
        0x03, 0x00, 0x07, 0x00, 0x25, 0x80, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x00,                         // 2400
        0x03, 0x00, 0x07, 0x00, 0x4B, 0x00, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x00,                         // 4800
        0x03, 0x00, 0x07, 0x00, 0x96, 0x00, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x00,                         // 9600
        0x03, 0x00, 0x07, 0x01, 0x2C, 0x00, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x01,                         // 19200
        0x03, 0x00, 0x07, 0x01, 0x2C, 0x00, 0x08, 0x2D, 0xC6, 0xC0, 0x00, 0x01,                         // 38400
        0x03, 0x00, 0x07, 0x02, 0x58, 0x00, 0x08, 0x2D, 0xC6, 0xC0, 0x00, 0x01,                         // 76800
        0x03, 0x00, 0x07, 0x03, 0x84, 0x00, 0x08, 0x2D, 0xC6, 0xC0, 0x00, 0x01,                         // 115200
        0x03, 0x00, 0x07, 0x27, 0x10, 0x00, 0x01, 0xC9, 0xC3, 0x80, 0x00, 0x01,                         // 256000
        0x03, 0x00, 0x07, 0x4C, 0x4B, 0x40, 0x01, 0xC9, 0xC3, 0x80, 0x00, 0x1b,                         // 500000
        0x03, 0x00, 0x07, 0x00, 0x07, 0xD0, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x00                          // 500
};

const unsigned char RF_MODEM_TX_RAMP_DELAY_8_433[11][8]=
{
        0x01, 0x80, 0x08, 0x03, 0x80, 0x00, 0x70, 0x20,                         // 1200
        0x01, 0x80, 0x08, 0x03, 0x80, 0x00, 0x70, 0x20,                         // 2400
        0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x70, 0x20,                         // 4800
        0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x70, 0x20,                         // 9600
        0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x30, 0x10,                         // 19200
        0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x20, 0x10,                         // 38400
        0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x10, 0x10,                         // 76800
        0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x10, 0x20,                         // 115200
        0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x00, 0x30,                         // 256000
        0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x00, 0x30,                         // 500000
        0x01, 0x80, 0x08, 0x03, 0x80, 0x00, 0x72, 0x21                          // 500
};

const unsigned char RF_MODEM_TX_RAMP_DELAY_8_850[11][8]=
{
// 1200
        0x01, 0x80, 0x08, 0x03, 0xC0, 0x00, 0x32, 0x20,
// 2400
        0x01, 0x80, 0x08, 0x03, 0xC0, 0x00, 0x30, 0x20,
// 4800
        0x01, 0x80, 0x08, 0x03, 0xC0, 0x00, 0x30, 0x20,
// 9600
        0x01, 0x00, 0x08, 0x03, 0xC0, 0x00, 0x30, 0x20,                         // 5k
// 19200
        0x01, 0x00, 0x08, 0x03, 0xC0, 0x00, 0x30, 0x20,                         // 10k
// 38400
        0x01, 0x00, 0x08, 0x03, 0xC0, 0x00, 0x20, 0x10,                         // 10k
// 76800
        0x01, 0x00, 0x08, 0x03, 0xC0, 0x00, 0x10, 0x10,                         // 10k
// 115200
        0x01, 0x00, 0x08, 0x03, 0xC0, 0x00, 0x10, 0x20,                         // 15k
        0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x00, 0x30,                         // 256000
        0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x00, 0x30,                         // 500000
        0x01, 0x80, 0x08, 0x03, 0x80, 0x00, 0x72, 0x21                          // 500
};
const unsigned char RF_MODEM_BCR_OSR_1_9_433[11][9]=
{
        0x03, 0x0D, 0x00, 0xA7, 0xC6, 0x00, 0x54, 0x02, 0xC2,           // 1200
        0x01, 0x87, 0x01, 0x4F, 0x8B, 0x00, 0xA8, 0x02, 0xC2,           // 2400
        0x00, 0xC3, 0x02, 0x9F, 0x17, 0x02, 0x1A, 0x02, 0x00,           // 4800
        0x00, 0x62, 0x05, 0x3E, 0x2D, 0x07, 0xFF, 0x02, 0x00,           // 9600
        0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,           // 19200
        0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,           // 38400
        0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,           // 76800
        0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,           // 115200
        0x00, 0x75, 0x04, 0x5E, 0x7B, 0x05, 0x9a, 0x02, 0x00,           // 256000
        0x00, 0x3C, 0x08, 0x88, 0x89, 0x07, 0xFF, 0x02, 0x00,           // 500000
        0x03, 0xAA, 0x00, 0x8B, 0xCF, 0x00, 0x46, 0x02, 0xC2            // 500
};

const unsigned char RF_MODEM_BCR_OSR_1_9_850[11][9]=
{
// 1200
        0x03, 0x0D, 0x00, 0xA7, 0xC6, 0x00, 0x54, 0x02, 0xC2,
// 2400
        0x03, 0x0D, 0x00, 0xA7, 0xC6, 0x00, 0x54, 0x02, 0xC2,
// 4800
        0x01, 0x87, 0x01, 0x4F, 0x8B, 0x00, 0xA8, 0x02, 0xC2,
// 9600
        0x00, 0xC3, 0x02, 0x9F, 0x17, 0x01, 0x93, 0x02, 0x00,           // 5k
// 19200
        0x00, 0x62, 0x05, 0x3E, 0x2D, 0x05, 0x04, 0x02, 0x00,
// 38400
        0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,
// 76800
        0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,
// 115200
        0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,
        0x00, 0x75, 0x04, 0x5E, 0x7B, 0x05, 0x9a, 0x02, 0x00,           // 256000
        0x00, 0x3C, 0x08, 0x88, 0x89, 0x07, 0xFF, 0x02, 0x00,           // 500000
        0x03, 0xAA, 0x00, 0x8B, 0xCF, 0x00, 0x46, 0x02, 0xC2            // 500
};
const unsigned char RF_MODEM_AFC_GEAR_7_433[11][7]=
{
        0x04, 0x36, 0x80, 0x03, 0x30, 0xAF, 0x80,                               // 1200
        0x04, 0x36, 0x80, 0x07, 0x14, 0xDD, 0x80,                               // 2400
        0x00, 0x12, 0x80, 0x2A, 0x04, 0x3A, 0xA0,                               // 4800
        0x00, 0x12, 0x80, 0x54, 0x02, 0x5A, 0xA0,                               // 9600
        0x00, 0x12, 0x80, 0xA8, 0x01, 0x68, 0xE0,                               // 19200
        0x00, 0x12, 0x81, 0x50, 0x01, 0x20, 0xE0,                               // 38400
        0x00, 0x12, 0x82, 0x9F, 0x01, 0x03, 0xE0,                               // 76800
        0x00, 0x23, 0x87, 0xDD, 0x00, 0x77, 0xE0,                               // 115200
        0x00, 0x23, 0x8F, 0xFF, 0x00, 0xc9, 0xE0,                               // 256000
        0x00, 0x23, 0x8F, 0xFF, 0x01, 0x23, 0xE0,                               // 500000
        0x04, 0x36, 0x80, 0x01, 0x50, 0x69, 0x80                                // 500
};

const unsigned char RF_MODEM_AFC_GEAR_7_850[11][7]=
{
// 1200
        0x04, 0x36, 0x80, 0x01, 0x52, 0x30, 0x80,
// 2400
        0x04, 0x36, 0x80, 0x03, 0x30, 0x7F, 0x80,
// 4800
        0x04, 0x36, 0x80, 0x07, 0x17, 0x10, 0x80,
// 9600
        0x00, 0x12, 0x80, 0x2A, 0x04, 0xB1, 0xA0,                               // 5k                   
// 19200
        0x00, 0x12, 0x80, 0x54, 0x02, 0x9A, 0xA0,
// 38400
        0x00, 0x12, 0x80, 0xA8, 0x01, 0x8F, 0xA0,
// 76800
        0x00, 0x12, 0x81, 0x50, 0x01, 0x1F, 0xA0,
// 115200
        0x00, 0x23, 0x83, 0xEF, 0x00, 0x84, 0xA0,
        0x00, 0x23, 0x8F, 0xFF, 0x00, 0xc9, 0xE0,                               // 256000
        0x00, 0x23, 0x8F, 0xFF, 0x01, 0x23, 0xE0,                               // 500000
        0x04, 0x36, 0x80, 0x01, 0x50, 0x69, 0x80                                // 500
};

const unsigned char RF_MODEM_AGC_WINDOW_SIZE_9_433[11][9]=
{
        0x11, 0xAB, 0xAB, 0x00, 0x1A, 0x14, 0x00, 0x00, 0x2B,           // 1200
        0x11, 0x56, 0x56, 0x00, 0x1A, 0xA0, 0x00, 0x00, 0x2A,           // 2400
        0x11, 0x2B, 0x2B, 0x00, 0x1A, 0x50, 0x00, 0x00, 0x29,           // 4800
        0x11, 0x15, 0x15, 0x00, 0x1A, 0x28, 0x00, 0x00, 0x28,           // 9600
        0x11, 0x0E, 0x0E, 0x00, 0x1A, 0x21, 0x55, 0x00, 0x28,           // 19200
        0x11, 0x0E, 0x0E, 0x00, 0x1A, 0x10, 0xAB, 0x00, 0x28,           // 38400
        0x11, 0x0E, 0x0E, 0x00, 0x1A, 0x08, 0x55, 0x00, 0x28,           // 76800
        0x11, 0x0E, 0x0E, 0x00, 0x1A, 0x05, 0x8E, 0x00, 0x28,           // 115200
        0x22, 0x0D, 0x0D, 0x00, 0x1A, 0x32, 0x00, 0x00, 0x28,           // 256000
        0x22, 0x07, 0x07, 0x00, 0x1A, 0x19, 0x9a, 0x00, 0x27,           // 500000
        0x11, 0xCD, 0xCD, 0x00, 0x1A, 0x30, 0x00, 0x00, 0x2B            // 500
};      

const unsigned char RF_MODEM_AGC_WINDOW_SIZE_9_850[11][9]=
{
// 1200
        0x11, 0xAB, 0xAB, 0x00, 0x02, 0xFF, 0xFF, 0x00, 0x2B,
// 2400
        0x11, 0xAB, 0xAB, 0x00, 0x02, 0xFF, 0xFF, 0x00, 0x2B,
// 4800
        0x11, 0x56, 0x56, 0x00, 0x02, 0xD5, 0x55, 0x00, 0x2A,
// 9600
        0x11, 0x2B, 0x2B, 0x00, 0x02, 0x6A, 0xAB, 0x00, 0x29,           //      5k
// 19200
        0x11, 0x15, 0x15, 0x00, 0x02, 0x42, 0xAB, 0x00, 0x28,
// 38400
        0x11, 0x0E, 0x0E, 0x00, 0x02, 0x21, 0x55, 0x00, 0x28,
// 76800
        0x11, 0x0E, 0x0E, 0x00, 0x02, 0x10, 0xAB, 0x00, 0x28,
// 115200
        0x11, 0x0E, 0x0E, 0x00, 0x02, 0x10, 0xAB, 0x00, 0x28,
        0x22, 0x0D, 0x0D, 0x00, 0x1A, 0x32, 0x00, 0x00, 0x28,           // 256000
        0x22, 0x07, 0x07, 0x00, 0x1A, 0x19, 0x9a, 0x00, 0x27,           // 500000
        0x11, 0xCD, 0xCD, 0x00, 0x1A, 0x30, 0x00, 0x00, 0x2B            // 500
};      

const unsigned char RF_MODEM_OOK_CNT1_11_433[11][11]=
{
        0xA4, 0x02, 0xD6, 0x83, 0x00, 0xAD, 0x01, 0x80, 0xFF, 0x0C, 0x00,               // 1200
        0xA4, 0x02, 0xD6, 0x83, 0x00, 0xAD, 0x01, 0x80, 0xFF, 0x0C, 0x00,               // 2400
        0xA4, 0x03, 0xD6, 0x03, 0x00, 0xCC, 0x01, 0x80, 0xFF, 0x0C, 0x00,               // 4800
        0xA4, 0x03, 0xD6, 0x03, 0x00, 0xCC, 0x01, 0x80, 0xFF, 0x0C, 0x00,               // 9600
        0xA4, 0x03, 0xD6, 0x03, 0x01, 0x00, 0x01, 0x80, 0xFF, 0x0C, 0x00,               // 19200
        0xA4, 0x03, 0xD6, 0x03, 0x00, 0x80, 0x01, 0x80, 0xFF, 0x0C, 0x00,               // 38400
        0xA4, 0x03, 0xD6, 0x03, 0x00, 0x40, 0x01, 0x80, 0xFF, 0x0C, 0x00,               // 76800
        0xA4, 0x03, 0xD6, 0x03, 0x00, 0x2B, 0x01, 0x80, 0xFF, 0x0C, 0x00,               // 115200
        0xA4, 0x03, 0xD6, 0x03, 0x00, 0xd5, 0x01, 0x80, 0xFF, 0x0C, 0x00,               // 256000
        0xA4, 0x03, 0xD6, 0x03, 0x00, 0xd5, 0x01, 0x80, 0xFF, 0x0C, 0x00,               // 500000
        0xA4, 0x02, 0xD6, 0x81, 0x02, 0xB4, 0x01, 0x80, 0xFF, 0x0C, 0x00                // 500
};      

const unsigned char RF_MODEM_OOK_CNT1_11_850[11][11]=
{
// 1200
        0xA4, 0x02, 0xD6, 0x81, 0x03, 0x9B, 0x01, 0x80, 0xFF, 0x0C, 0x02,
// 2400
        0xA4, 0x02, 0xD6, 0x83, 0x00, 0xE7, 0x01, 0x80, 0xFF, 0x0C, 0x02,
// 4800
        0xA4, 0x02, 0xD6, 0x83, 0x00, 0xE7, 0x01, 0x80, 0xFF, 0x0C, 0x02,
// 9600
        0xA4, 0x03, 0xD6, 0x03, 0x01, 0x11, 0x01, 0x80, 0xFF, 0x0C, 0x02,
// 19200
        0xA4, 0x03, 0xD6, 0x03, 0x01, 0x55, 0x01, 0x80, 0xFF, 0x0C, 0x02,
// 38400
        0xA4, 0x03, 0xD6, 0x03, 0x01, 0x00, 0x01, 0x80, 0xFF, 0x0C, 0x02,
// 76800
        0xA4, 0x03, 0xD6, 0x03, 0x00, 0x80, 0x01, 0x80, 0xFF, 0x0C, 0x02,
// 115200
        0xA4, 0x03, 0xD6, 0x03, 0x00, 0x80, 0x01, 0x80, 0xFF, 0x0C, 0x02,
        0xA4, 0x03, 0xD6, 0x03, 0x00, 0xd5, 0x01, 0x80, 0xFF, 0x0C, 0x02,               // 256000
        0xA4, 0x03, 0xD6, 0x03, 0x00, 0xd5, 0x01, 0x80, 0xFF, 0x0C, 0x02,               // 500000
        0xA4, 0x02, 0xD6, 0x81, 0x02, 0xB4, 0x01, 0x80, 0xFF, 0x0C, 0x02                // 500
};

const unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433[11][12]=
{
        0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,                 // 1200
        0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,                 // 2400
        0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1, 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11,                 // 4800
        0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,                 // 9600
        0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1, 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11,                 // 19200
        0x7E, 0x64, 0x1B, 0xBA, 0x58, 0x0B, 0xDD, 0xCE, 0xD6, 0xE6, 0xF6, 0x00,                 // 38400
        0x5B, 0x47, 0x0F, 0xC0, 0x6D, 0x25, 0xF4, 0xDB, 0xD6, 0xDF, 0xEC, 0xF7,                 // 76800
        0x5B, 0x47, 0x0F, 0xC0, 0x6D, 0x25, 0xF4, 0xDB, 0xD6, 0xDF, 0xEC, 0xF7,                 // 115200
        0x39, 0x2B, 0x00, 0xC3, 0x7F, 0x3F, 0x0C, 0xEC, 0xDC, 0xDC, 0xE3, 0xED,                 // 256000
        0xA2, 0x81, 0x26, 0xAF, 0x3F, 0xEE, 0xC8, 0xC7, 0xDB, 0xF2, 0x02, 0x08,                 // 500000
        0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1, 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11                  // 500
};      

const unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850[11][12]=
{
// 1200 
        0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,
// 2400
        0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,
// 4800
        0xFF, 0xBA, 0x0F, 0x51, 0xCF, 0xA9, 0xC9, 0xFC, 0x1B, 0x1E, 0x0F, 0x01,
// 9600
        0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,
// 19200
        0xFF, 0xBA, 0x0F, 0x51, 0xCF, 0xA9, 0xC9, 0xFC, 0x1B, 0x1E, 0x0F, 0x01,
// 38400
        0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,
// 76800
        0x7E, 0x64, 0x1B, 0xBA, 0x58, 0x0B, 0xDD, 0xCE, 0xD6, 0xE6, 0xF6, 0x00,
// 115200
        0x7E, 0x64, 0x1B, 0xBA, 0x58, 0x0B, 0xDD, 0xCE, 0xD6, 0xE6, 0xF6, 0x00,
        0x39, 0x2B, 0x00, 0xC3, 0x7F, 0x3F, 0x0C, 0xEC, 0xDC, 0xDC, 0xE3, 0xED,                 // 256000
        0xA2, 0x81, 0x26, 0xAF, 0x3F, 0xEE, 0xC8, 0xC7, 0xDB, 0xF2, 0x02, 0x08,                 // 500000
        0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1, 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11                  // 500
};      

const unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433[11][12]=
{       
        0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,                 // 1200
        0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,                 // 2400
        0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00, 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1,                 // 4800
        0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,                 // 9600
        0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00, 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1,                 // 19200
        0x03, 0x03, 0x15, 0xF0, 0x3F, 0x00, 0x7E, 0x64, 0x1B, 0xBA, 0x58, 0x0B,                 // 38400        
        0xFE, 0x01, 0x15, 0xF0, 0xFF, 0x03, 0x5B, 0x47, 0x0F, 0xC0, 0x6D, 0x25,                 // 76800
        0xFE, 0x01, 0x15, 0xF0, 0xFF, 0x03, 0x5B, 0x47, 0x0F, 0xC0, 0x6D, 0x25,                 // 115200
        0xF6, 0xFD, 0x15, 0xC0, 0xFF, 0x0F, 0x39, 0x2B, 0x00, 0xC3, 0x7F, 0x3F,                 // 256000
        0x07, 0x03, 0x15, 0xFC, 0x0F, 0x00, 0xA2, 0x81, 0x26, 0xAF, 0x3F, 0xEE,                 // 500000
        0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00, 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1                  // 500
};      

const unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850[11][12]=
{       
// 1200
        0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,
// 2400
        0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,
// 4800
        0xFC, 0xFD, 0x15, 0xFF, 0x00, 0x0F, 0xFF, 0xBA, 0x0F, 0x51, 0xCF, 0xA9,
// 9600
        0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,
// 19200
        0xFC, 0xFD, 0x15, 0xFF, 0x00, 0x0F, 0xFF, 0xBA, 0x0F, 0x51, 0xCF, 0xA9,
// 38400
        0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 
// 76800
        0x03, 0x03, 0x15, 0xF0, 0x3F, 0x00, 0x7E, 0x64, 0x1B, 0xBA, 0x58, 0x0B,
// 115200
        0xF6, 0xFD, 0x15, 0xC0, 0xFF, 0x0F, 0x39, 0x2B, 0x00, 0xC3, 0x7F, 0x3F,                 // 256000
        0x07, 0x03, 0x15, 0xFC, 0x0F, 0x00, 0xA2, 0x81, 0x26, 0xAF, 0x3F, 0xEE,                 // 500000
        0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00, 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1                  // 500
};              
const unsigned char RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433[11][12]=
{
        0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,                 // 1200
        0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,                 // 2400
        0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11, 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00,                 // 4800
        0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,                 // 9600
        0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11, 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00,                 // 19200
        0xDD, 0xCE, 0xD6, 0xE6, 0xF6, 0x00, 0x03, 0x03, 0x15, 0xF0, 0x3F, 0x00,                 // 38400
        0xF4, 0xDB, 0xD6, 0xDF, 0xEC, 0xF7, 0xFE, 0x01, 0x15, 0xF0, 0xFF, 0x03,                 // 76800
        0xF4, 0xDB, 0xD6, 0xDF, 0xEC, 0xF7, 0xFE, 0x01, 0x15, 0xF0, 0xFF, 0x03,                 // 115200
        0x0C, 0xEC, 0xDC, 0xDC, 0xE3, 0xED, 0xF6, 0xFD, 0x15, 0xC0, 0xFF, 0x0F,                 // 256000
        0xC8, 0xC7, 0xDB, 0xF2, 0x02, 0x08, 0x07, 0x03, 0x15, 0xFC, 0x0F, 0x00,                 // 500000
        0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11, 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00                  // 500
};

const unsigned char RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850[11][12]=
{
// 1200
        0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,
// 2400
        0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,
// 4800
        0xC9, 0xFC, 0x1B, 0x1E, 0x0F, 0x01, 0xFC, 0xFD, 0x15, 0xFF, 0x00, 0x0F,
// 9600
        0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,
// 19200
        0xC9, 0xFC, 0x1B, 0x1E, 0x0F, 0x01, 0xFC, 0xFD, 0x15, 0xFF, 0x00, 0x0F,
// 38400
        0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,
// 76800
        0xDD, 0xCE, 0xD6, 0xE6, 0xF6, 0x00, 0x03, 0x03, 0x15, 0xF0, 0x3F, 0x00,
// 115200
        0x03, 0x03, 0x15, 0xF0, 0x3F, 0x00, 0x7E, 0x64, 0x1B, 0xBA, 0x58, 0x0B,
        0x0C, 0xEC, 0xDC, 0xDC, 0xE3, 0xED, 0xF6, 0xFD, 0x15, 0xC0, 0xFF, 0x0F,                 // 256000
        0xC8, 0xC7, 0xDB, 0xF2, 0x02, 0x08, 0x07, 0x03, 0x15, 0xFC, 0x0F, 0x00,                 // 500000
        0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11, 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00                  // 500
};

const unsigned char RF_SYNTH_PFDCP_CPFF_7[11][7]=
{
        0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,                       // 1200
        0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,                       // 2400
        0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,                       // 4800
        0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,                       // 9600
        0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,                       // 19200
        0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,                       // 38400
        0x34, 0x04, 0x0B, 0x04, 0x07, 0x70, 0x03,                       // 76800
        0x34, 0x04, 0x0B, 0x04, 0x07, 0x70, 0x03,                       // 115200
        0x01, 0x05, 0x0B, 0x05, 0x02, 0x00, 0x03,                       // 256000
        0x01, 0x05, 0x0B, 0x05, 0x02, 0x00, 0x03,                       // 500000
        0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03                        // 500
};

unsigned char   key_value;
unsigned char   have_set;
unsigned char   set;            // ÉèÖÃÄ£Ê½
unsigned char   old_mode;
unsigned char   mode;            
unsigned char   freq3;  
unsigned char   freq2;  
unsigned char   freq1;          // ÔØ²¨ÆµÂÊ
unsigned char   power;          // ·¢Éä¹¦ÂÊ
unsigned char   rssi;           // ½ÓÊÜÐÅºÅÇ¿¶È
unsigned char   dataRate;

const unsigned char RF_POWER_UP_data[] =                                        { RF_POWER_UP}; 
const unsigned char RF_FRR_CTL_A_MODE_4_data[] =                        { RF_FRR_CTL_A_MODE_4};
const unsigned char RF_MODEM_AGC_CONTROL_1_data[] =             { RF_MODEM_AGC_CONTROL_1};

unsigned char RF_MODEM_MOD_TYPE_12_data[16]={0x11, 0x20, 0x0C, 0x00};
unsigned char RF_MODEM_TX_RAMP_DELAY_8_data[12]={0x11, 0x20, 0x08, 0x18};
unsigned char RF_MODEM_BCR_OSR_1_9_data[13]={0x11, 0x20, 0x09, 0x22};
unsigned char RF_MODEM_AFC_GEAR_7_data[13]={0x11, 0x20, 0x07, 0x2C};
unsigned char RF_MODEM_AGC_WINDOW_SIZE_9_data[13]={0x11, 0x20, 0x09, 0x38};
unsigned char RF_MODEM_OOK_CNT1_11_data[15]={0x11, 0x20, 0x0B, 0x42};
unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[16]={0x11, 0x21, 0x0C, 0x00};
unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[16]={0x11, 0x21, 0x0C, 0x0C};
unsigned char RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[16]={0x11, 0x21, 0x0C, 0x18};
unsigned char RF_SYNTH_PFDCP_CPFF_7_data[11]={0x11, 0x23, 0x07, 0x00};  

const unsigned char tx_test_aa_data[14] = {0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa};  // Ã¿Ãë·¢ÉäµÄ¹Ì¶¨ÄÚÈÝµÄ²âÊÔÐÅºÅ£¬µÚ10¸öÊý¾ÝÊÇÇ°9¸öÊý¾ÝµÄÐ£ÑéºÍ
const unsigned char tx_ph_data[14] = {'s','w','w','x',0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x6d};  // Ã¿Ãë·¢ÉäµÄ¹Ì¶¨ÄÚÈÝµÄ²âÊÔÐÅºÅ£¬µÚ10¸öÊý¾ÝÊÇÇ°9¸öÊý¾ÝµÄÐ£ÑéºÍ


void portInit();
void rf4463Config();
void vRf4463PowerOnReset();
void rfInit();
void vRf4463SPIWriteBuffer( uint16_t usWriteLength, uint8_t * pcWriteBuffer );
void vRf4463SPIReadBuffer( uint16_t usReadLength, uint8_t * pcReadBuffer );
uint8_t ucRf4463SPIByte( uint8_t pcWriteData );
void vRF4463SetPinSDN( uint8_t ucPinVal );
void vRF4463SetPinSelect( uint8_t ucPinVal );
uint8_t ucRf4463DeviceAvailability();
uint8_t ucRf4463GetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer );
uint8_t ucRf4463CheckCTS();
void GPIO_SET(unsigned char mydata);
void nop_10();
void rf_init_freq(void);
uint8_t ucRf4463SetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer );
void vBufferSetToZero( uint8_t * pcBufferToClean, uint16_t uslength );
float get_battery_voltage();

/*********************************************************************
 * Main
*********************************************************************/
void main()
{

   asm{nop};
   asm{nop};
   asm{nop};
   asm{nop};
   asm{nop};
   
   portInit();
   nop_10();
   UART1_Write_Text("Start Demo System\n\r");
   Sound_Init(&GPIOB_ODR, 7);
   LED_GREEN = 1;
   Sound_Play(3000, 100);
   Delay_ms(100);
   Sound_Play(4000, 100);
   LED_GREEN =0;
   rfInit();
   nop_10();
   rf4463Config();
   nop_10();

}

/*********************************************************************
 * Power Radio and Check Model
*********************************************************************/
void rfInit()
{
   vRf4463PowerOnReset();
   if( ucRf4463DeviceAvailability() == SUCCESS ) 
        {  
           UART1_Write_Text("Radio On!!!\n\r");
        }
   UART1_Write(get_battery_voltage());
}

/*********************************************************************
 * Radio Config
*********************************************************************/
void rf4463Config()
{

uint8_t pcBuffer[20];
uint8_t allocatCounter;
        
        for( allocatCounter = 4; allocatCounter < 16; allocatCounter++ ) RF_MODEM_MOD_TYPE_12_data[allocatCounter] = RF_MODEM_MOD_TYPE_12[dataRate][allocatCounter - 4];

        if(freq3<8)
            {
                for( allocatCounter = 4; allocatCounter < 12; allocatCounter++ ) RF_MODEM_TX_RAMP_DELAY_8_data[allocatCounter] = RF_MODEM_TX_RAMP_DELAY_8_433[dataRate][allocatCounter - 4];      
                for( allocatCounter = 4; allocatCounter < 15; allocatCounter++ ) RF_MODEM_OOK_CNT1_11_data[allocatCounter] = RF_MODEM_OOK_CNT1_11_433[dataRate][allocatCounter - 4];
                for( allocatCounter = 4; allocatCounter < 16; allocatCounter++ ) RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[allocatCounter] = RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433[dataRate][allocatCounter - 4];
                for( allocatCounter = 4; allocatCounter < 16; allocatCounter++ ) RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[allocatCounter] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433[dataRate][allocatCounter - 4];
                for( allocatCounter = 4; allocatCounter < 16; allocatCounter++ ) RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[allocatCounter] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433[dataRate][allocatCounter - 4];     
                for( allocatCounter = 4; allocatCounter < 13; allocatCounter++ ) RF_MODEM_AGC_WINDOW_SIZE_9_data[allocatCounter] = RF_MODEM_AGC_WINDOW_SIZE_9_433[dataRate][allocatCounter - 4];
                for( allocatCounter = 4; allocatCounter < 13; allocatCounter++ ) RF_MODEM_BCR_OSR_1_9_data[allocatCounter] = RF_MODEM_BCR_OSR_1_9_433[dataRate][allocatCounter - 4];     
            }
        else
        {
                for( allocatCounter = 4; allocatCounter < 12; allocatCounter++ ) RF_MODEM_TX_RAMP_DELAY_8_data[allocatCounter] = RF_MODEM_TX_RAMP_DELAY_8_850[dataRate][allocatCounter - 4];
                for( allocatCounter = 4; allocatCounter < 11; allocatCounter++ ) RF_MODEM_AFC_GEAR_7_data[allocatCounter] = RF_MODEM_AFC_GEAR_7_850[dataRate][allocatCounter - 4];
                for( allocatCounter = 4; allocatCounter < 15; allocatCounter++ ) RF_MODEM_OOK_CNT1_11_data[allocatCounter] = RF_MODEM_OOK_CNT1_11_850[dataRate][allocatCounter - 4];
                for( allocatCounter = 4; allocatCounter < 16; allocatCounter++ ) RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[allocatCounter] = RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850[dataRate][allocatCounter - 4];
                for( allocatCounter = 4; allocatCounter < 16; allocatCounter++ ) RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[allocatCounter] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850[dataRate][allocatCounter - 4];
                for( allocatCounter = 4; allocatCounter < 16; allocatCounter++ ) RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[allocatCounter] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850[dataRate][allocatCounter - 4];     
                for( allocatCounter = 4; allocatCounter < 13; allocatCounter++ ) RF_MODEM_AGC_WINDOW_SIZE_9_data[allocatCounter] = RF_MODEM_AGC_WINDOW_SIZE_9_850[dataRate][allocatCounter - 4]; 
                for( allocatCounter = 4; allocatCounter < 13; allocatCounter++ ) RF_MODEM_BCR_OSR_1_9_data[allocatCounter] = RF_MODEM_BCR_OSR_1_9_850[dataRate][allocatCounter - 4];     
        }               
        for(allocatCounter = 4; allocatCounter < 11; allocatCounter++ ) RF_SYNTH_PFDCP_CPFF_7_data[allocatCounter] = RF_SYNTH_PFDCP_CPFF_7[dataRate][allocatCounter - 4];

        GPIO_SET(mode);

        //spi_write(0x05, RF_GLOBAL_XO_TUNE_1_data);   //  ÆµÂÊµ÷Õû
        pcBuffer[0]  = 0x11;  
        pcBuffer[1]  = 0x00;    // 0x0000 
        pcBuffer[2]  = 0x01;    // ¹² 1¸ö²ÎÊý
        pcBuffer[3]  = 0x00;   // 0x0000
        pcBuffer[4]  = 98;  // freq  adjustment
        ucRf4463SetCommand( 5 , RF4463_PROPERTY_GLOBAL_XO_TUNE , pcBuffer );
        vBufferSetToZero( pcBuffer, 20 );

        //uint8_t ucRf4463SetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer ){
        //spi_write(5, pcBuffer);

        // //spi_write(0x05, RF_GLOBAL_CONFIG_1_data);  //  *******************************************************
        pcBuffer[0]  = 0x11;  
        pcBuffer[1]  = 0x00;    // 0x0003 
        pcBuffer[2]  = 0x01;    // ¹² 1¸ö²ÎÊý
        pcBuffer[3]  = 0x03;   // 0x0003
        pcBuffer[4]  = 0x40;  // tx = rx = 64 byte, ÆÕÍ¨ PH£¬high performance mode  ????????????????????? 
        ucRf4463SetCommand( 5 , RF4463_PROPERTY_GLOBAL_CLK_CFG , pcBuffer );
        vBufferSetToZero( pcBuffer, 20 );
        //spi_write(5, pcBuffer); 
    
    // *****************************************************************************    
    //spi_write(0x08, RF_FRR_CTL_A_MODE_4_data);    // disable all fast response register
     
    // //spi_write(0x0D, RF_PREAMBLE_TX_LENGTH_9_data); Ç°µ¼ÂëÉèÖÃ*********************************************   
        pcBuffer[0]  = 0x11;  
        pcBuffer[1]  = 0x10;    // 0x1000 
        pcBuffer[2]  = 0x09;    // ¹² 9¸ö²ÎÊý
        pcBuffer[3]  = 0x00;   // 0x1000
        
        if(mode == tx_test_mode)
        {
                pcBuffer[4]  = 0xff;   //  ÐèÒª·¢ËÍ255¸ö×Ö½ÚµÄPreamble
        }
        else
        {
                pcBuffer[4]  = 0x08;   //  ÐèÒª·¢ËÍ8¸ö×Ö½ÚµÄPreamble
        }       
        
        //app_command_buf[4]  = 0x08;   //  ÐèÒª·¢ËÍ8¸ö×Ö½ÚµÄPreamble
        pcBuffer[5]   = 0x14;   //Òª¼ì²â20 bit Í¬²½×Ö£¬
        pcBuffer[6]   = 0x00;   // ·Ç±ê×¼µÄpreamble Éè¶¨£¬Ã»ÓÐÓÃ
        pcBuffer[7]   = 0x0f;   // Ç°µ¼ÂëTimeoutµÄÊ±¼ä   ????????????????????????????????????????????????????????????
        pcBuffer[8]   = 0x31;  // Ç°µ¼ÂëµÄ³¤¶ÈÒÔ byte ¼ÆËã£¬ 1st = 1£¬Ã»ÓÐmanchest  ±àÂë£¬Ê¹ÓÃ±ê×¼µÄ 1010.¡£¡£
        pcBuffer[9]   = 0x0;     //  ·Ç±ê×¼µÄPreambleµÄ Patten 4th byte
        pcBuffer[10]  = 0x00;   //  ·Ç±ê×¼µÄPreambleµÄ Patten 3rd byte
        pcBuffer[11]  = 0x00;  //  ·Ç±ê×¼µÄPreambleµÄ Patten 2nd byte
        pcBuffer[12]  = 0x00;  //  ·Ç±ê×¼µÄPreambleµÄ Patten 1st byte
        ucRf4463SetCommand( 13 , RF4463_PROPERTY_PREAMBLE_TX_LENGTH , pcBuffer );
        vBufferSetToZero( pcBuffer, 20 );
        
        //spi_write(13, pcBuffer);  //     
        
        //  RF_SYNC_CONFIG_5_data,  Í¬²½×ÖµÄÉèÖÃ *********************************************
        pcBuffer[0]  = 0x11;  
        pcBuffer[1]  = 0x11;    // command = 0x1100
        pcBuffer[2]  = 0x05;    // ¹² 5¸ö²ÎÊý
        pcBuffer[3]  = 0x00;   // command = 0x1100
        pcBuffer[4]  = 0x01;   //  Í¬²½×ÖÔÚ length field ¶¨Òå²¢·¢ËÍ£¬Í¬²½×Ö²»ÄÜÓÐ´í£¬²»ÊÇ 4FSK£¬ ²»ÊÇmanchest ±àÂë£¬Ö»ÓÐ 2¸ö×Ö½Ú
        
        if(mode == tx_test_mode)
        {
                pcBuffer[5]  = 0x55;   //Í¬²½×Ö 3
                pcBuffer[6]  = 0x55;   // Í¬²½×Ö2 
        }       
        else
        {
                pcBuffer[5]  = 0x2d;   //Í¬²½×Ö 3
                pcBuffer[6]  = 0xd4;   // Í¬²½×Ö2 
        }
        
        pcBuffer[7]  = 0x00;   // Í¬²½×Ö1
        pcBuffer[8]  = 0x00;  // Í¬²½×Ö 0
    //spi_write(9, pcBuffer);  //
        
        //  packet crc ÉèÖÃ *******************************************************************        
        pcBuffer[0]  = 0x11;  
        pcBuffer[1]  = 0x12;    // command = 0x1200
        pcBuffer[2]  = 0x01;    // ¹² 1¸ö²ÎÊý
        pcBuffer[3]  = 0x00;   // command = 0x1200
        pcBuffer[4]  = 0x81; //   1ÊÇcRC ÖÖ×Ó£¬CRC = itu-c, enable crc
    //spi_write(5, pcBuffer);  
        
        // packet   gernale configuration        
        pcBuffer[0]  = 0x11;  
        pcBuffer[1]  = 0x12;    // command = 0x1206
        pcBuffer[2]  = 0x01;    // ¹² 1¸ö²ÎÊý
        pcBuffer[3]  = 0x06;   // command = 0x1206
        pcBuffer[4]  = 0x02;   //  tx = rx = 120d--1220 (tx packet£¬ph enable, not 4fsk, ÊÕµ½Ò»°üÊý¾Ýºó£¬RX off,CRC ²»·­×ª £¬CRC MSB£¬ data MSB
    //spi_write(5, pcBuffer);  
        
        // //spi_write(0x07, RF_PKT_LEN_3_data);   //  ¹Ì¶¨³¤¶È£¬³¤¶ÈÒ»¸ö×Ö½Ú£¬³¤¶ÈÐÅÏ¢Ã»ÓÐÔÚPayloadÀïÃæ
    pcBuffer[0]  = 0x11;  
        pcBuffer[1]  = 0x12;    // command = 0x1208
        pcBuffer[2]  = 0x03;    // ¹² 3¸ö²ÎÊý
        pcBuffer[3]  = 0x08;   // command = 0x1208
        pcBuffer[4]  = 0x00;   //  Length Field = LSB,  length Ö»ÓÐ1¸ö×Ö½Ú£¬length ²»·ÅÔÚ FiFoÀïÃæ£¬¹Ì¶¨°ü³¤Ä£Ê½
        pcBuffer[5]  = 0x00;   //ÓÃÓÚ¿É±ä°ü³¤Ä£Ê½£¬¶¨ÒåÄÄ¸ö Field °üº¬ÁË length Filed
        pcBuffer[6]  = 0x00;   // ÓÃÓÚ¿É±ä°ü³¤Ä£Ê½£¬µ÷Õû¿É±ä°ü³¤µÄ length
    //spi_write(7, pcBuffer); 
    
        
        // length Field 1 -- 4 µÄÉèÖÃ 
        pcBuffer[0]   = 0x11;  
        pcBuffer[1]   = 0x12;    // 0x120d 
        pcBuffer[2]   = 0x0c;    // ¹² 12¸ö²ÎÊý
        pcBuffer[3]   = 0x0d;   // 0x120d
        pcBuffer[4]   = 0x00;   //  Field 1 µÄ³¤¶È £¨¸ß4Î»£©
        pcBuffer[5]   = payload_length;   //  field 1 µÄ³¤¶È£¬ £¨µÍ 8Î»), ×Ü¹²14¸ö×Ö½Ú
        pcBuffer[6]   = 0x04;   // field 1 ²»ÊÇ 4FSK£¬manchest, whiting, PN9,   
        pcBuffer[7]   = 0xaa;   // field 1 crc enble, check enbale, ·¢ÉäÒ²ÓÐCRC£¬cRCµÄSeed ºÍCRC_seedÀïÃæµÄÒ»Ñù  
        pcBuffer[8]   = 0x00;  //  field2 µÄ³¤¶È£¨¸ß4Î»£©
        pcBuffer[9]   = 0x00;    //  field 2 µÄ³¤¶È£¬ £¨µÍ 8Î»)£¬ ³¤¶È = 0 ±íÊ¾Õâ¸öfield Ã»ÓÐÊ¹ÓÃ
        pcBuffer[10]  = 0x00;   // field 2 ²»ÊÇ 4FSK£¬manchest, whiting, PN9
        pcBuffer[11]  = 0x00;  //  field 2 µÄCRCÉèÖÃ
        pcBuffer[12]  = 0x00;  //  field 3 µÄ³¤¶È£¬ £¨µÍ 8Î»)£¬ ³¤¶È = 0 ±íÊ¾Õâ¸öfield Ã»ÓÐÊ¹ÓÃ
        pcBuffer[13]  = 0x00;    //  field 3 µÄ³¤¶È£¬ £¨µÍ 8Î»)£¬ ³¤¶È = 0 ±íÊ¾Õâ¸öfield Ã»ÓÐÊ¹ÓÃ
        pcBuffer[14]  = 0x00;   //  field 3 ²»ÊÇ 4FSK£¬manchest, whiting, PN9
        pcBuffer[15]  = 0x00;  //  field 3 µÄCRCÉèÖÃ
        //spi_write(16, pcBuffer);  // 
  
    // //spi_write(0x0C, RF_PKT_FIELD_4_LENGTH_12_8_8_data);  **************************************
        pcBuffer[0]   = 0x11;  
        pcBuffer[1]   = 0x12;    // 0x1219 
        pcBuffer[2]   = 0x08;    // ¹² 8¸ö²ÎÊý
        pcBuffer[3]   = 0x19;   // 0x1219
        pcBuffer[4]   = 0x00;   //  field4 µÄ³¤¶È£¨¸ß4Î»£©
        pcBuffer[5]   = 0x00;   //  field 4 µÄ³¤¶È£¬ £¨µÍ 8Î»)£¬ ³¤¶È = 0 ±íÊ¾Õâ¸öfield Ã»ÓÐÊ¹ÓÃ
        pcBuffer[6]   = 0x00;   //   field 4 ²»ÊÇ 4FSK£¬manchest, whiting, PN9
        pcBuffer[7]   = 0x00;   // field 4 µÄCRCÉèÖÃ
        pcBuffer[8]   = 0x00;  //  field5 µÄ³¤¶È£¨¸ß4Î»£©
        pcBuffer[9]   = 0x00;    //   field 5 µÄ³¤¶È£¬ £¨µÍ 8Î»)£¬ ³¤¶È = 0 ±íÊ¾Õâ¸öfield Ã»ÓÐÊ¹ÓÃ
        pcBuffer[10]  = 0x00;   //  field 5 ²»ÊÇ 4FSK£¬manchest, whiting, PN9
        pcBuffer[11]  = 0x00;   // field 5 µÄCRCÉèÖÃ
    //spi_write(12, pcBuffer);  //
    
    // ********************************************************************************
    //spi_write(0x10, RF_MODEM_MOD_TYPE_12_data);   // //  2FSK ,  module source = PH fifo, disable manchest, tx, rx ²»·­×ª£¬ deviation ²»·­×ª
        
        ////spi_write(0x05, RF_MODEM_FREQ_DEV_0_1_data); **************************************
        pcBuffer[0] = 0x11;  
        pcBuffer[1]  = 0x20;    // 0x200c                                                         
        pcBuffer[2]  = 0x01;    // ¹² 1¸ö²ÎÊý                                                     
        pcBuffer[3]  = 0x0c;   // 0x200c                                                          
        //app_command_buf[4]  = 0x4f; // frequency deviation µÄBit 0--7, ¸ù¾ÝWDS²úÉú
        if(freq3<8)
        {
                if(dataRate>=dr_256k)
                        pcBuffer[4]  = 0x4f;
                else if(dataRate>=dr_19p2)
                        pcBuffer[4]  = 0x5e;
                else
                    pcBuffer[4]  = 0xd2;   
        }
        else
        {
                if(dataRate>=dr_115p2)
                        pcBuffer[4]  = 0x69;     // 15k
                else if(dataRate>=dr_19p2)
                        pcBuffer[4]  = 0x5e;     // 10k
                else
                    pcBuffer[4]  = 0x18; // 8k
        }         
    //spi_write(5, pcBuffer);  
        
    // ********************************************************************************    
    //spi_write(0x0C, RF_MODEM_TX_RAMP_DELAY_8_data);     // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
    //spi_write(0x0D, RF_MODEM_BCR_OSR_1_9_data);                 // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
    //spi_write(0x0B, RF_MODEM_AFC_GEAR_7_data);                  // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
    //spi_write(0x05, RF_MODEM_AGC_CONTROL_1_data);               // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
    //spi_write(0x0D, RF_MODEM_AGC_WINDOW_SIZE_9_data);   // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
    //spi_write(0x0F, RF_MODEM_OOK_CNT1_11_data);                 // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª   
    
        // //spi_write(0x05, RF_MODEM_RSSI_COMP_1_data);  **************************************************
        pcBuffer[0] = 0x11;  
        pcBuffer[1] = 0x20;    // 0x204e                                                         
        pcBuffer[2] = 0x01;    // ¹² 1¸ö²ÎÊý                                                     
        pcBuffer[3] = 0x4e;   // 0x204e 
        if(dataRate==dr_500)
                pcBuffer[4]  = 0x3a; 
        else                                                         
                pcBuffer[4]  = 0x40;  //  rssi ¶ÁÊýÆ«²î£¬ÓëÕæÊµÖµµÄ²îÖµ
    //spi_write(5, pcBuffer);
                     
    // ********************************************************************************    
    //spi_write(0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data);  // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
    //spi_write(0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data);   // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
    //spi_write(0x10, RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data);   // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª        
        
        // RF_PA **************************************************************************
        pcBuffer[0] = 0x11;  
        pcBuffer[1]  = 0x22;    // 0x2200                                                         
        pcBuffer[2]  = 0x04;    // ¹² 4¸ö²ÎÊý                                                     
        pcBuffer[3]  = 0x00;   // 0x2200                                                          
        pcBuffer[4]  = 0x08;  //0x10;   //   PA mode  = default , Ê¹ÓÃClass E Ä£Ê½£¬¶ø²»ÊÇ Switch Current Ä£Ê½  ????????
        if(power==7)    
                pcBuffer[5]  = 127;   //  ÉèÖÃÎª×î´ó¹¦ÂÊ
        else if(power==6)
                pcBuffer[5]  = 50;
        else if(power==5)
                pcBuffer[5]  = 30;
        else if(power==4)
                pcBuffer[5]  = 20;
        else if(power==3)
                pcBuffer[5]  = 15;
        else if(power==2)
                pcBuffer[5]  = 10;
        else if(power==1)
                pcBuffer[5]  = 7;                                        
        else    
                pcBuffer[5]  = 4;                
        pcBuffer[6]  =0x00; //???????? 0x00;   // CLK duty = 50%£¬ ÆäËû = Default
        if((dataRate<=dr_115p2)||(dataRate==dr_500))
                pcBuffer[7]  = 0x3d;  // ???????? 0x5d;   // PA ramp time = default 
    else
        pcBuffer[7]  = 0x5d;    
    //spi_write(8, pcBuffer);        
    
    // ********************************************************************************     
        //spi_write(0x0B, RF_SYNTH_PFDCP_CPFF_7_data);      // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
        
        // header match ******************************************************************
        pcBuffer[0] = 0x11;  
        pcBuffer[1]  = 0x30;    // 0x3000                                                         
        pcBuffer[2]  = 0x0c;    // ¹² 12¸ö²ÎÊý                                                     
        pcBuffer[3]  = 0x00;   // 0x3000                                                          
        pcBuffer[4]  = 's';    //0x00;   //  match 1 µÄÖµ
        pcBuffer[5]  = 0xff;   //  match 1 mask
        pcBuffer[6]  = 0x40;   // eable match 1, match 1µÄÖµÓëÍ¬²½×ÖµÄÏà¾àµÄ¾àÀë, 0 = match 
        pcBuffer[7]  = 'w';    //  match 2 µÄÖµ                                        
        pcBuffer[8]  = 0xff;   //  match 2 mask                                        
        pcBuffer[9]  = 0x01;   // enable match 2, match 2µÄÖµÓëÍ¬²½×ÖµÄÏà¾àµÄ¾àÀë  , and function   
        pcBuffer[10] = 'w';   //     match 3 µÄÖµ                                        
        pcBuffer[11]  =0xff;;    //  match 3 mask                                        
        pcBuffer[12]  =0x02;;    // enable match 3, match 3µÄÖµÓëÍ¬²½×ÖµÄÏà¾àµÄ¾àÀë    and function 
        pcBuffer[13]  = 'x';    //   match 4 µÄÖµ                                        
        pcBuffer[14]  = 0xff;   //   match 4 mask                                        
        pcBuffer[15]  = 0x03;   //  enable match 4, match 4µÄÖµÓëÍ¬²½×ÖµÄÏà¾àµÄ¾àÀë    and function 
        //spi_write(16, pcBuffer); 
        
        rf_init_freq();
}

/*********************************************************************
 * Port Init
*********************************************************************/
void portInit()
{
SPI2_Init_Advanced( _SPI_FPCLK_DIV8, _SPI_MASTER | _SPI_8_BIT | _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION | _SPI_MSB_FIRST | 
                    _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI2_PB13_14_15 );

UART1_Init_Advanced( 115200, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10 );
/*********************************************************************
 * RF4463Pro I/O Setup
*********************************************************************/
// GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_13 );  // RF4463SCLK
// GPIO_Digital_Input( &GPIOB_BASE, _GPIO_PINMASK_15 );   // RF4463SDI
// GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_14 );  // RF4463SDO
GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_12 );  // RF4463nSEL
GPIO_Digital_Input( &GPIOC_BASE, _GPIO_PINMASK_12 );   // RF4463nIRQ
GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_11 );  // RF4463nSDN

GPIO_Digital_Input( &GPIOC_BASE, _GPIO_PINMASK_11 );   // RF4463GPIO0
GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_10 );  // RF4463GPIO1

GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_7 );   // Buzzer
GPIO_Digital_Input( &GPIOB_BASE, _GPIO_PINMASK_8 );    // Boton

GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_6 );   // LED_RED
GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_7 );   // LED_GREEN
GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_8 );   // LED_BLUE
/*********************************************************************
 * 
*********************************************************************/

}
/********************************************************************* 
 * FUNCTION:
 * INPUT:
 * OUTPUT: 
 * DESCRIPTION:
*********************************************************************/
void vRf4463PowerOnReset(){
    /*
    Después de encender la alimentación, debemos configurar el pin SDN para 10uS 
    de alto. Luego, debe dar un retraso máximo de 6 ms para realizar el procedimiento 
    interno para POR (reinicio de encendido) . 
    Entonces podemos enviar datos de configuración con Power Up a la vanguardia. 
    Esperamos CTS después de cada comando enviado . 
    De la figura anterior, se puede ver que en cada etapa de inicialización podemos 
    usar la comprobación del estado en los pines GPIO1 y nIRQ , 
    pero es un esfuerzo innecesario. 
    Todo el proceso de configuración desde el encendido hasta el modo de espera 
    completo dura 15 ms .
    */
    uint8_t pcBuffer[ 7 ] = { RF_POWER_UP };

    vRF4463SetPinSDN( PIN_LEVEL_HIGH );
    Delay_us( 16 );
    vRF4463SetPinSDN( PIN_LEVEL_LOW );

    Delay_ms( 6 );

    vRF4463SetPinSelect( PIN_LEVEL_LOW );
    vRf4463SPIWriteBuffer( sizeof( pcBuffer ), pcBuffer );
    vRF4463SetPinSelect( PIN_LEVEL_HIGH );
    UART1_Write_Text("Power On Reset Apply\n\r");
}
/********************************************************************* 
 * FUNCTION:
 * INPUT:
 * OUTPUT: 
 * DESCRIPTION:
*********************************************************************/
void vRf4463SPIWriteBuffer( uint16_t usWriteLength, uint8_t * pcWriteBuffer ){
    /*************************************************************************************************
     * Native SPI Driver ( Communication with RF4463 )
    *************************************************************************************************/
    while( usWriteLength-- ){
        ucRf4463SPIByte( *pcWriteBuffer++ );
    }
}

/********************************************************************* 
 * FUNCTION:
 * INPUT:
 * OUTPUT: 
 * DESCRIPTION:
*********************************************************************/
void vRf4463SPIReadBuffer( uint16_t usReadLength, uint8_t * pcReadBuffer ){
    uint8_t ucRxCounter = 0;
    /*************************************************************************************************
     * Native SPI Driver ( Communicati|on with RF4463 )
    *************************************************************************************************/
    while( usReadLength-- ){
        pcReadBuffer[ ucRxCounter++ ] = ucRf4463SPIByte( 0 );
    }
}

/********************************************************************* 
 * FUNCTION:
 * INPUT:
 * OUTPUT: 
 * DESCRIPTION:
*********************************************************************/
uint8_t ucRf4463SPIByte( uint8_t pcWriteData ){
    return SPI2_Read( pcWriteData );
}

/********************************************************************* 
 * FUNCTION:
 * INPUT:
 * OUTPUT: 
 * DESCRIPTION:
*********************************************************************/
void vRF4463SetPinSDN( uint8_t ucPinVal ){
    RF4463nSDN = ucPinVal;
}

/********************************************************************* 
 * FUNCTION:
 * INPUT:
 * OUTPUT: 
 * DESCRIPTION:
*********************************************************************/
void vRF4463SetPinSelect( uint8_t ucPinVal ){
    RF4463nSEL = ucPinVal;
}

/********************************************************************* 
 * FUNCTION:
 * INPUT:
 * OUTPUT: 
 * DESCRIPTION:
*********************************************************************/
uint8_t ucRf4463DeviceAvailability(){
   /*
        PART_INFO Reply Stream
        Index   Name    7       6       5       4       3       2       1       0
        0x00    CTS     CTS
        0x01    CHIPREV CHIPREV
        0x02    PART    PART[15:8]
        0x03    PART[7:0]
        0x04    PBUILD  PBUILD
        0x05    ID      ID[15:8]
        0x06    ID[7:0]
        0x07    CUSTOMER        CUSTOMER
        0x08    ROMID   ROMID

        Respuesta : 0xFF, 0x22, 0x44, 0x63, 0x00, 0x86, 0x00, 0x00, 0x06
   */
    uint8_t pcBuffer[ 9 ];
    uint8_t pcTempBuffer[20];
    static uint16_t usPartInformation = 0;

    if( ucRf4463GetCommand( 9, RF4463_CMD_PART_INFO, pcBuffer ) == NOT_SUCCESS ){
        UART1_Write_Text("Not Found Radio Data\n\r");
        return NOT_SUCCESS;
    }

    //UART1_Write_Text("---------------[ Part Info ]----------------\n\r");
    // UART1_Write_Text("CTS Answer    : ");
    // if( pcBuffer[0] == 0xFF) UART1_Write_Text(" Ok\n\r");
    // UART1_Write_Text("Chip Revision : ");
    // if( pcBuffer[1] == 0x22) UART1_Write_Text(" Ok\n\r");
    // UART1_Write_Text("Part Number   : ");
    // if( pcBuffer[2] == 0x44 && pcBuffer[3] == 0x63) UART1_Write_Text(" SI4463\n\r");
    // UART1_Write_Text("Part Build    : ");
    // if( pcBuffer[4] == 0x00 ) UART1_Write_Text(" 0\n\r");
    // UART1_Write_Text("Part Build    : ");
    // if( pcBuffer[4] == 0x00 ) UART1_Write_Text(" 0\n\r");


    // sprintf( pcTempBuffer, "Radio Data: %d.%d.%d.%d.%d.%d.%d.%d\r\n",pcBuffer[0],pcBuffer[1],pcBuffer[2],pcBuffer[3],pcBuffer[4],pcBuffer[5],pcBuffer[6],pcBuffer[7],pcBuffer[8]  );
    // UART1_Write_Text( pcTempBuffer );
    // UART1_Write_Text("\n\r");
    usPartInformation = ( ( pcBuffer[ 2 ] << 8 ) | pcBuffer[ 3 ] );

    if( usPartInformation != 0x4463 ){
        return NOT_SUCCESS;
    }

    return SUCCESS;
}

/********************************************************************* 
 * FUNCTION:
 * INPUT:
 * OUTPUT: 
 * DESCRIPTION:
*********************************************************************/
uint8_t ucRf4463GetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer ){
    if( ucRf4463CheckCTS() == NOT_SUCCESS ){
        return NOT_SUCCESS;
    }

    vRF4463SetPinSelect( PIN_LEVEL_LOW );
    ucRf4463SPIByte( ucCommand );
    vRF4463SetPinSelect( PIN_LEVEL_HIGH );

    if( ucRf4463CheckCTS() == NOT_SUCCESS ){
        return NOT_SUCCESS;
    }

    vRF4463SetPinSelect( PIN_LEVEL_LOW );
    ucRf4463SPIByte( RF4463_CMD_READ_BUF );
    vRf4463SPIReadBuffer( ucLength, pcParametersBuffer );
    vRF4463SetPinSelect( PIN_LEVEL_HIGH );

    return SUCCESS;
}

/********************************************************************* 
 * FUNCTION:
 * INPUT:
 * OUTPUT: 
 * DESCRIPTION:
*********************************************************************/
uint8_t ucRf4463CheckCTS(){
    uint16_t usTimeoutCounter = 0;

    usTimeoutCounter = RF4463_CTS_TIMEOUT;
    // STM_LOGE( "[ RF4463 ] CTS\r\n", NULL );
    
    while( usTimeoutCounter-- ){
        vRF4463SetPinSelect( PIN_LEVEL_LOW );
        ucRf4463SPIByte( RF4463_CMD_READ_BUF );
        if( ucRf4463SPIByte( RF4463_CMD_READ_BUF ) == RF4463_CTS_REPLY ){
            // STM_LOGV( "[ RF4463 ] CTS left tries: %d\r\n", usTimeoutCounter );
            vRF4463SetPinSelect( PIN_LEVEL_HIGH );
            return SUCCESS;
        }
        vRF4463SetPinSelect( PIN_LEVEL_HIGH );
    }
    UART1_Write_Text( "[ RF4463 ] CTS failed\r\n" );
    return NOT_SUCCESS;
}

void GPIO_SET(unsigned char mydata)
{
        uint8_t pcBuffer[7];
        
        pcBuffer[0] = 0x13;     // gpio ÉèÖÃ
        
        switch(mydata)
        {
                case tx_normal:
                case rx_normal:
                        pcBuffer[1]  = 3;                // GPIO0=1
                        pcBuffer[2]  = 2;                // GPIO1=0
                break;
                
                case tx_test:
                        pcBuffer[1]  = 3;                // GPIO0=1
                        pcBuffer[2]  = 3;                // GPIO1=1
                break;
                
                case rx_test:
                        pcBuffer[1]  = 2;                // GPIO0=0
                        pcBuffer[2]  = 20;               // GPIO1=RX DATA
                break;
                
                case rf_off:
                        pcBuffer[1]  = 2;                // GPIO0=0
                        pcBuffer[2]  = 2;                // GPIO1=0
                break;                   
        }
        
        pcBuffer[3]  = 0x21;  //0x20;   //  gpio2, h = tx mode
        pcBuffer[4]  = 0x20; // 0x14;  //   gpio3 
        pcBuffer[5]  = 0x27;   // nIRQ
        pcBuffer[6]  = 0x0b;  // sdo
        ////spi_write(7, pcBuffer);
}

void nop_10()
{
        asm{nop}; 
        asm{nop};
        asm{nop};
        asm{nop};
        asm{nop};
        asm{nop};
        asm{nop};
        asm{nop};
        asm{nop};
        asm{nop};    
        
}

void rf_init_freq(void)
{       
        unsigned char OUTDIV,DIV,VCO,INTE,BAND;
        unsigned char FD_2,FD_1,FD_0,FRAC_2,FRAC_1,FRAC_0;
        unsigned long FRAC,newData,frequency;
        uint8_t pcBuffer[20];
        
        frequency = (freq3 * 100) + (freq2 * 10) + freq1;
        frequency = (frequency * 10000) + 5000;
        
        if(frequency>=7600000)                                  // 760~1050
        {
                OUTDIV = 4;
                BAND = 0;
                VCO = 0xff;     
        }       
        else if(frequency>=5460000)                             // 546~759.9
        {
                OUTDIV = 6;
                BAND = 1;
                VCO = 0xfe;     
        }
        else if(frequency>=3850000)                             // 385~545.9
        {
                OUTDIV = 8;
                BAND = 2;
                VCO = 0xfe;     
        }
        else if(frequency>=2730000)                             // 273~384.9
        {
                OUTDIV = 12;
                BAND = 3;
                VCO = 0xfd;     
        }
        else if(frequency>=1940000)                             // 194~272.9
        {
                OUTDIV = 16;
                BAND = 4;
                VCO = 0xfc;     
        }
        else                                                                    // 142~193.9
        {
                OUTDIV = 24;
                BAND = 5;
                VCO = 0xfa;
        }
        
        DIV = OUTDIV/2;
        
        newData = (frequency*DIV)/3;
        INTE = (newData/100000)-1;
        FRAC = (newData-(INTE+1)*100000)*16384/3125;
        FRAC = FRAC+0x80000;
        
        FRAC_0 = FRAC;
        FRAC>>=8;
        FRAC_1 = FRAC;
        FRAC>>=8;
        FRAC_2 = FRAC;
        
        // send freq cmd        
        
        pcBuffer[0] = 0x11;
        pcBuffer[1]  = 0x20;    // 0x2051
        pcBuffer[2]  = 0x01;    // ¹² 1¸ö²ÎÊý
        pcBuffer[3]  = 0x51;   // 0x2051
        pcBuffer[4]  = 0x08|BAND;  //  high performance mode , clk outpu = osc /4
        //spi_write(5, pcBuffer);
        
        pcBuffer[0]   = 0x11;
        pcBuffer[1]   = 0x40;    // 0x4000
        pcBuffer[2]   = 0x08;    // ¹² 8¸ö²ÎÊý
        pcBuffer[3]   = 0x00;   // 0x4000
        pcBuffer[4]   = INTE;   //  default value
        pcBuffer[5]   = FRAC_2;   //  defaul value
        pcBuffer[6]   = FRAC_1;   //  default value
        pcBuffer[7]   = FRAC_0;   // frac ,from WDS
        pcBuffer[8]   = step_500K_step1;   // channel step1  from wds
        pcBuffer[9]   = step_500K_step0;   // channel step0  from wds
        pcBuffer[10]  = 0x20;  //  from wds Ã»ÓÐÕâ¸öÖµ
        pcBuffer[11]  = VCO;    // from wds Ã»ÓÐÕâ¸öÖµ
    //spi_write(12, pcBuffer);
} 

/*********************************************************************
 *  Set Command
*********************************************************************/
uint8_t ucRf4463SetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer ){
    if( ucRf4463CheckCTS() == NOT_SUCCESS ){
        return NOT_SUCCESS;
    }

    vRF4463SetPinSelect( PIN_LEVEL_LOW );
    ucRf4463SPIByte( ucCommand );
    vRf4463SPIWriteBuffer( ucLength, pcParametersBuffer );
    vRF4463SetPinSelect( PIN_LEVEL_HIGH );
    
    return SUCCESS;
}

/*********************************************************************
 * 
*********************************************************************/
void vBufferSetToZero( uint8_t * pcBufferToClean, uint16_t uslength ){
    uint16_t usPosition = 0;

    for( usPosition = 0; usPosition < uslength; usPosition++ ){
        pcBufferToClean[ usPosition ] = 0x00;
    }
}

float get_battery_voltage()
{
    uint8_t write_buf[] = { 0x08 };
    uint8_t read_buf[8];
    uint16_t battery_adc;
    // Takes nearly 4ms
    ucRf4463SetCommand( 8, RF4463_CMD_GET_ADC_READING, read_buf );
    battery_adc = (read_buf[2] << 8) | read_buf[3];
    return 3.0 * battery_adc / 1280;
}