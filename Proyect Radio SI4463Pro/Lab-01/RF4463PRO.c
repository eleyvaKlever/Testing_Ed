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

typedef         unsigned char        U8;
typedef         unsigned int        U16;
typedef         unsigned long        U32;
typedef         char                        S8;
typedef         int                                S16;
typedef         long                        S32;

#define RF4463_CTS_TIMEOUT              2500
#define RF4463_CTS_REPLY                                         0xff

#define NOP                                                     0x00 
#define PART_INFO                       0x01    // 9   ·µ»Ø 4463 
#define FUNC_INFO                       0x10    // 7  Ã»ÓÐÒâÒå
#define SET_PROPERTY                    0x11 
#define GET_PROPERTY                    0x12 
#define GPIO_PIN_CFG                    0x13    // 8
#define GET_ADC_READING                 0x14 
#define FIFO_INFO                       0x15    // 3
#define PACKET_INFO                     0x16    // 3
#define IRCAL                           0x17 
#define PROTOCOL_CFG                    0x18 
#define GET_INT_STATUS                  0x20    // 9
#define GET_PH_STATUS                   0x21    // 3
#define GET_MODEM_STATUS                0x22    // 9
#define GET_CHIP_STATUS                 0x23    // 4
#define START_TX                        0x31 
#define START_RX                        0x32 
#define REQUEST_DEVICE_STAT             0x33    // 3
#define CHANGE_STATE                    0x34 
#define READ_CMD_BUFF                   0x44 
#define FRR_A_READ                      0x50    // 4
#define FRR_B_READ                      0x51 
#define FRR_C_READ                      0x53 
#define FRR_D_READ                      0x57 
#define WRITE_TX_FIFO                   0x66 
#define READ_RX_FIFO                    0x77 
#define START_MFSK                      0x35 
#define RX_HOP                          0x36 

#define payload_length                                  14    //×Ü¹² header + 10¸ö×Ö½Ú

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

#define         NOP_KEY                 7
#define         SET_KEY                 6
#define         UP_KEY                  5
#define         DOWN_KEY                3

#define         set_freq3               1
#define         set_freq2               2
#define         set_freq1               3
#define         set_power               4
#define         set_dr                  5
#define         set_trmode              6               // set freq offset

#define         master_mode     0
#define         slave_mode      1
//#define               rf_off                  2
#define         tx_test_mode    2
#define         rx_test_mode    3
#define         rf_off                  4

#define         tx_normal               0
#define         rx_normal               1
//#define               rf_off                  2
#define         tx_test                 2
#define         rx_test                 3
#define         rf_off                  4

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

 float vMin [7][6] = {                                          // Matriz de Datos de Voltajes Minimos
                        3.00,  3.00,  3.00, 0.00, 0.00, 0.00,   // JIG_PO_OUTLET  OK
                        3.50,  3.00, 11.00, 0.00, 0.00, 0.00,   // JIG_PS_OUTLET  OK
                        3.00,  3.00,  4.00, 0.00, 0.00, 0.00,   // JIG_PD_DIMMER  OK
                        3.40,  3.10, 17.00, 4.80, 0.00, 0.00,   // JIG_PS_DIMMER  OK
                        3.00,  3.00,  4.00, 0.00, 0.00, 0.00,   // JIG_PD_SWITCH  OK
                        3.40,  9.00,  3.00, 0.00, 0.00, 0.00,   // JIG_PS_SWITCH  OK
                        4.00,  3.00,  3.00, 3.00, 3.00, 3.00    // JIG_PC_HUB     OK
                        //TP21   TP20   TP19  TP14  TP11  TP5                  
                        };

const unsigned char RF_MODEM_MOD_TYPE_12[11][12] = {
        0x03, 0x00, 0x07, 0x00, 0x12, 0xC0, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x00,                                // 1200
        0x03, 0x00, 0x07, 0x00, 0x25, 0x80, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x00,                                // 2400
        0x03, 0x00, 0x07, 0x00, 0x4B, 0x00, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x00,                                // 4800
        0x03, 0x00, 0x07, 0x00, 0x96, 0x00, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x00,                                // 9600
        0x03, 0x00, 0x07, 0x01, 0x2C, 0x00, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x01,                                // 19200
        0x03, 0x00, 0x07, 0x01, 0x2C, 0x00, 0x08, 0x2D, 0xC6, 0xC0, 0x00, 0x01,                                // 38400
        0x03, 0x00, 0x07, 0x02, 0x58, 0x00, 0x08, 0x2D, 0xC6, 0xC0, 0x00, 0x01,                                // 76800
        0x03, 0x00, 0x07, 0x03, 0x84, 0x00, 0x08, 0x2D, 0xC6, 0xC0, 0x00, 0x01,                                // 115200
        0x03, 0x00, 0x07, 0x27, 0x10, 0x00, 0x01, 0xC9, 0xC3, 0x80, 0x00, 0x01,                                // 256000
        0x03, 0x00, 0x07, 0x4C, 0x4B, 0x40, 0x01, 0xC9, 0xC3, 0x80, 0x00, 0x1b,                                // 500000
        0x03, 0x00, 0x07, 0x00, 0x07, 0xD0, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x00                                // 500
};

const unsigned char RF_MODEM_TX_RAMP_DELAY_8_433[11][8]=
{
        0x01, 0x80, 0x08, 0x03, 0x80, 0x00, 0x70, 0x20,                                // 1200
        0x01, 0x80, 0x08, 0x03, 0x80, 0x00, 0x70, 0x20,                                // 2400
        0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x70, 0x20,                                // 4800
        0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x70, 0x20,                                // 9600
        0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x30, 0x10,                                // 19200
        0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x20, 0x10,                                // 38400
        0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x10, 0x10,                                // 76800
        0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x10, 0x20,                                // 115200
        0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x00, 0x30,                                // 256000
        0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x00, 0x30,                                // 500000
        0x01, 0x80, 0x08, 0x03, 0x80, 0x00, 0x72, 0x21                                // 500
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
        0x01, 0x00, 0x08, 0x03, 0xC0, 0x00, 0x30, 0x20,                                // 5k
// 19200
        0x01, 0x00, 0x08, 0x03, 0xC0, 0x00, 0x30, 0x20,                                // 10k
// 38400
        0x01, 0x00, 0x08, 0x03, 0xC0, 0x00, 0x20, 0x10,                                // 10k
// 76800
        0x01, 0x00, 0x08, 0x03, 0xC0, 0x00, 0x10, 0x10,                                // 10k
// 115200
        0x01, 0x00, 0x08, 0x03, 0xC0, 0x00, 0x10, 0x20,                                // 15k
        0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x00, 0x30,                                // 256000
        0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x00, 0x30,                                // 500000
        0x01, 0x80, 0x08, 0x03, 0x80, 0x00, 0x72, 0x21                                // 500
};
const unsigned char RF_MODEM_BCR_OSR_1_9_433[11][9]=
{
        0x03, 0x0D, 0x00, 0xA7, 0xC6, 0x00, 0x54, 0x02, 0xC2,                // 1200
        0x01, 0x87, 0x01, 0x4F, 0x8B, 0x00, 0xA8, 0x02, 0xC2,                // 2400
        0x00, 0xC3, 0x02, 0x9F, 0x17, 0x02, 0x1A, 0x02, 0x00,                // 4800
        0x00, 0x62, 0x05, 0x3E, 0x2D, 0x07, 0xFF, 0x02, 0x00,                // 9600
        0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,                // 19200
        0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,                // 38400
        0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,                // 76800
        0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,                // 115200
        0x00, 0x75, 0x04, 0x5E, 0x7B, 0x05, 0x9a, 0x02, 0x00,                // 256000
        0x00, 0x3C, 0x08, 0x88, 0x89, 0x07, 0xFF, 0x02, 0x00,                // 500000
        0x03, 0xAA, 0x00, 0x8B, 0xCF, 0x00, 0x46, 0x02, 0xC2                // 500
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
        0x00, 0xC3, 0x02, 0x9F, 0x17, 0x01, 0x93, 0x02, 0x00,                // 5k
// 19200
        0x00, 0x62, 0x05, 0x3E, 0x2D, 0x05, 0x04, 0x02, 0x00,
// 38400
        0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,
// 76800
        0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,
// 115200
        0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,
        0x00, 0x75, 0x04, 0x5E, 0x7B, 0x05, 0x9a, 0x02, 0x00,                // 256000
        0x00, 0x3C, 0x08, 0x88, 0x89, 0x07, 0xFF, 0x02, 0x00,                // 500000
        0x03, 0xAA, 0x00, 0x8B, 0xCF, 0x00, 0x46, 0x02, 0xC2                // 500
};
const unsigned char RF_MODEM_AFC_GEAR_7_433[11][7]=
{
        0x04, 0x36, 0x80, 0x03, 0x30, 0xAF, 0x80,                                // 1200
        0x04, 0x36, 0x80, 0x07, 0x14, 0xDD, 0x80,                                // 2400
        0x00, 0x12, 0x80, 0x2A, 0x04, 0x3A, 0xA0,                                // 4800
        0x00, 0x12, 0x80, 0x54, 0x02, 0x5A, 0xA0,                                // 9600
        0x00, 0x12, 0x80, 0xA8, 0x01, 0x68, 0xE0,                                // 19200
        0x00, 0x12, 0x81, 0x50, 0x01, 0x20, 0xE0,                                // 38400
        0x00, 0x12, 0x82, 0x9F, 0x01, 0x03, 0xE0,                                // 76800
        0x00, 0x23, 0x87, 0xDD, 0x00, 0x77, 0xE0,                                // 115200
        0x00, 0x23, 0x8F, 0xFF, 0x00, 0xc9, 0xE0,                                // 256000
        0x00, 0x23, 0x8F, 0xFF, 0x01, 0x23, 0xE0,                                // 500000
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
        0x00, 0x12, 0x80, 0x2A, 0x04, 0xB1, 0xA0,                                // 5k                        
// 19200
        0x00, 0x12, 0x80, 0x54, 0x02, 0x9A, 0xA0,
// 38400
        0x00, 0x12, 0x80, 0xA8, 0x01, 0x8F, 0xA0,
// 76800
        0x00, 0x12, 0x81, 0x50, 0x01, 0x1F, 0xA0,
// 115200
        0x00, 0x23, 0x83, 0xEF, 0x00, 0x84, 0xA0,
        0x00, 0x23, 0x8F, 0xFF, 0x00, 0xc9, 0xE0,                                // 256000
        0x00, 0x23, 0x8F, 0xFF, 0x01, 0x23, 0xE0,                                // 500000
        0x04, 0x36, 0x80, 0x01, 0x50, 0x69, 0x80                                // 500
};

const unsigned char RF_MODEM_AGC_WINDOW_SIZE_9_433[11][9]=
{
        0x11, 0xAB, 0xAB, 0x00, 0x1A, 0x14, 0x00, 0x00, 0x2B,                // 1200
        0x11, 0x56, 0x56, 0x00, 0x1A, 0xA0, 0x00, 0x00, 0x2A,                // 2400
        0x11, 0x2B, 0x2B, 0x00, 0x1A, 0x50, 0x00, 0x00, 0x29,                // 4800
        0x11, 0x15, 0x15, 0x00, 0x1A, 0x28, 0x00, 0x00, 0x28,                // 9600
        0x11, 0x0E, 0x0E, 0x00, 0x1A, 0x21, 0x55, 0x00, 0x28,                // 19200
        0x11, 0x0E, 0x0E, 0x00, 0x1A, 0x10, 0xAB, 0x00, 0x28,                // 38400
        0x11, 0x0E, 0x0E, 0x00, 0x1A, 0x08, 0x55, 0x00, 0x28,                // 76800
        0x11, 0x0E, 0x0E, 0x00, 0x1A, 0x05, 0x8E, 0x00, 0x28,                // 115200
        0x22, 0x0D, 0x0D, 0x00, 0x1A, 0x32, 0x00, 0x00, 0x28,                // 256000
        0x22, 0x07, 0x07, 0x00, 0x1A, 0x19, 0x9a, 0x00, 0x27,                // 500000
        0x11, 0xCD, 0xCD, 0x00, 0x1A, 0x30, 0x00, 0x00, 0x2B                // 500
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
        0x11, 0x2B, 0x2B, 0x00, 0x02, 0x6A, 0xAB, 0x00, 0x29,                //        5k
// 19200
        0x11, 0x15, 0x15, 0x00, 0x02, 0x42, 0xAB, 0x00, 0x28,
// 38400
        0x11, 0x0E, 0x0E, 0x00, 0x02, 0x21, 0x55, 0x00, 0x28,
// 76800
        0x11, 0x0E, 0x0E, 0x00, 0x02, 0x10, 0xAB, 0x00, 0x28,
// 115200
        0x11, 0x0E, 0x0E, 0x00, 0x02, 0x10, 0xAB, 0x00, 0x28,
        0x22, 0x0D, 0x0D, 0x00, 0x1A, 0x32, 0x00, 0x00, 0x28,                // 256000
        0x22, 0x07, 0x07, 0x00, 0x1A, 0x19, 0x9a, 0x00, 0x27,                // 500000
        0x11, 0xCD, 0xCD, 0x00, 0x1A, 0x30, 0x00, 0x00, 0x2B                // 500
};        

const unsigned char RF_MODEM_OOK_CNT1_11_433[11][11]=
{
        0xA4, 0x02, 0xD6, 0x83, 0x00, 0xAD, 0x01, 0x80, 0xFF, 0x0C, 0x00,                // 1200
        0xA4, 0x02, 0xD6, 0x83, 0x00, 0xAD, 0x01, 0x80, 0xFF, 0x0C, 0x00,                // 2400
        0xA4, 0x03, 0xD6, 0x03, 0x00, 0xCC, 0x01, 0x80, 0xFF, 0x0C, 0x00,                // 4800
        0xA4, 0x03, 0xD6, 0x03, 0x00, 0xCC, 0x01, 0x80, 0xFF, 0x0C, 0x00,                // 9600
        0xA4, 0x03, 0xD6, 0x03, 0x01, 0x00, 0x01, 0x80, 0xFF, 0x0C, 0x00,                // 19200
        0xA4, 0x03, 0xD6, 0x03, 0x00, 0x80, 0x01, 0x80, 0xFF, 0x0C, 0x00,                // 38400
        0xA4, 0x03, 0xD6, 0x03, 0x00, 0x40, 0x01, 0x80, 0xFF, 0x0C, 0x00,                // 76800
        0xA4, 0x03, 0xD6, 0x03, 0x00, 0x2B, 0x01, 0x80, 0xFF, 0x0C, 0x00,                // 115200
        0xA4, 0x03, 0xD6, 0x03, 0x00, 0xd5, 0x01, 0x80, 0xFF, 0x0C, 0x00,                // 256000
        0xA4, 0x03, 0xD6, 0x03, 0x00, 0xd5, 0x01, 0x80, 0xFF, 0x0C, 0x00,                // 500000
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
        0xA4, 0x03, 0xD6, 0x03, 0x00, 0xd5, 0x01, 0x80, 0xFF, 0x0C, 0x02,                // 256000
        0xA4, 0x03, 0xD6, 0x03, 0x00, 0xd5, 0x01, 0x80, 0xFF, 0x0C, 0x02,                // 500000
        0xA4, 0x02, 0xD6, 0x81, 0x02, 0xB4, 0x01, 0x80, 0xFF, 0x0C, 0x02                // 500
};

const unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433[11][12]=
{
        0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,                        // 1200
        0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,                        // 2400
        0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1, 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11,                        // 4800
        0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,                        // 9600
        0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1, 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11,                        // 19200
        0x7E, 0x64, 0x1B, 0xBA, 0x58, 0x0B, 0xDD, 0xCE, 0xD6, 0xE6, 0xF6, 0x00,                        // 38400
        0x5B, 0x47, 0x0F, 0xC0, 0x6D, 0x25, 0xF4, 0xDB, 0xD6, 0xDF, 0xEC, 0xF7,                        // 76800
        0x5B, 0x47, 0x0F, 0xC0, 0x6D, 0x25, 0xF4, 0xDB, 0xD6, 0xDF, 0xEC, 0xF7,                        // 115200
        0x39, 0x2B, 0x00, 0xC3, 0x7F, 0x3F, 0x0C, 0xEC, 0xDC, 0xDC, 0xE3, 0xED,                        // 256000
        0xA2, 0x81, 0x26, 0xAF, 0x3F, 0xEE, 0xC8, 0xC7, 0xDB, 0xF2, 0x02, 0x08,                        // 500000
        0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1, 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11                        // 500
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
        0x39, 0x2B, 0x00, 0xC3, 0x7F, 0x3F, 0x0C, 0xEC, 0xDC, 0xDC, 0xE3, 0xED,                        // 256000
        0xA2, 0x81, 0x26, 0xAF, 0x3F, 0xEE, 0xC8, 0xC7, 0xDB, 0xF2, 0x02, 0x08,                        // 500000
        0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1, 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11                        // 500
};        

const unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433[11][12]=
{        
        0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,                        // 1200
        0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,                        // 2400
        0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00, 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1,                        // 4800
        0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,                        // 9600
        0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00, 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1,                        // 19200
        0x03, 0x03, 0x15, 0xF0, 0x3F, 0x00, 0x7E, 0x64, 0x1B, 0xBA, 0x58, 0x0B,                        // 38400        
        0xFE, 0x01, 0x15, 0xF0, 0xFF, 0x03, 0x5B, 0x47, 0x0F, 0xC0, 0x6D, 0x25,                        // 76800
        0xFE, 0x01, 0x15, 0xF0, 0xFF, 0x03, 0x5B, 0x47, 0x0F, 0xC0, 0x6D, 0x25,                        // 115200
        0xF6, 0xFD, 0x15, 0xC0, 0xFF, 0x0F, 0x39, 0x2B, 0x00, 0xC3, 0x7F, 0x3F,                        // 256000
        0x07, 0x03, 0x15, 0xFC, 0x0F, 0x00, 0xA2, 0x81, 0x26, 0xAF, 0x3F, 0xEE,                        // 500000
        0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00, 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1                        // 500
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
        0xF6, 0xFD, 0x15, 0xC0, 0xFF, 0x0F, 0x39, 0x2B, 0x00, 0xC3, 0x7F, 0x3F,                        // 256000
        0x07, 0x03, 0x15, 0xFC, 0x0F, 0x00, 0xA2, 0x81, 0x26, 0xAF, 0x3F, 0xEE,                        // 500000
        0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00, 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1                        // 500
};                
const unsigned char RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433[11][12]=
{
        0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,                        // 1200
        0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,                        // 2400
        0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11, 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00,                        // 4800
        0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,                        // 9600
        0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11, 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00,                        // 19200
        0xDD, 0xCE, 0xD6, 0xE6, 0xF6, 0x00, 0x03, 0x03, 0x15, 0xF0, 0x3F, 0x00,                        // 38400
        0xF4, 0xDB, 0xD6, 0xDF, 0xEC, 0xF7, 0xFE, 0x01, 0x15, 0xF0, 0xFF, 0x03,                        // 76800
        0xF4, 0xDB, 0xD6, 0xDF, 0xEC, 0xF7, 0xFE, 0x01, 0x15, 0xF0, 0xFF, 0x03,                        // 115200
        0x0C, 0xEC, 0xDC, 0xDC, 0xE3, 0xED, 0xF6, 0xFD, 0x15, 0xC0, 0xFF, 0x0F,                        // 256000
        0xC8, 0xC7, 0xDB, 0xF2, 0x02, 0x08, 0x07, 0x03, 0x15, 0xFC, 0x0F, 0x00,                        // 500000
        0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11, 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00                        // 500
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
        0x0C, 0xEC, 0xDC, 0xDC, 0xE3, 0xED, 0xF6, 0xFD, 0x15, 0xC0, 0xFF, 0x0F,                        // 256000
        0xC8, 0xC7, 0xDB, 0xF2, 0x02, 0x08, 0x07, 0x03, 0x15, 0xFC, 0x0F, 0x00,                        // 500000
        0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11, 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00                        // 500
};

const unsigned char RF_SYNTH_PFDCP_CPFF_7[11][7]=
{
        0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,                        // 1200
        0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,                        // 2400
        0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,                        // 4800
        0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,                        // 9600
        0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,                        // 19200
        0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,                        // 38400
        0x34, 0x04, 0x0B, 0x04, 0x07, 0x70, 0x03,                        // 76800
        0x34, 0x04, 0x0B, 0x04, 0x07, 0x70, 0x03,                        // 115200
        0x01, 0x05, 0x0B, 0x05, 0x02, 0x00, 0x03,                        // 256000
        0x01, 0x05, 0x0B, 0x05, 0x02, 0x00, 0x03,                        // 500000
        0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03                         // 500
};        

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

const unsigned char Tab_DispCode[17]={0x77,0x24,0x6b,0x6d,0x3c,0x5d,0x5f,0x64,0x7f,0x7d,0x7e,0x1f,0x53,0x2f,0x5b,0x5a,0x00};

typedef struct 
{
        unsigned char reach_1s                          : 1;    
        unsigned char is_tx                                     : 1;
        unsigned char rf_reach_timeout          : 1;
        
// add joyce    
        unsigned char flash                                     : 1;
        unsigned char key_valid                         : 1;            
        
}FlagType;

FlagType        Flag;

U16 count_1hz, rf_timeout;
U8  spi_read_buf[20];    
U8  rx_buf[25];

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
unsigned char   rate;           // ËÙÂÊ

unsigned char   cnt_10s;

unsigned long   tx_cnt = 0,rx_cnt = 0; //ÊÕ·¢´ÎÊý
unsigned char   reset_mode;

unsigned char   reach_15hz = 0,reach_flash = 0,reach_1s = 0;
unsigned char   count_15hz,count_flash = 0,count_1s = 0,nirq_cnt = 0;

void sdn_reset(void);
void SI4463_init(void);
void rf_init_freq(void);
void vRf4463SPIWriteBuffer( uint16_t usWriteLength, uint8_t * pcWriteBuffer );
void vRf4463SPIReadBuffer( uint16_t usReadLength, uint8_t * pcReadBuffer );
uint8_t ucRf4463SPIByte( uint8_t pcWriteData );
uint8_t ucRf4463CheckCTS();
unsigned long hex2int(char *a, unsigned int len);
void vRf4463SPIWriteBuffer( uint16_t usWriteLength, uint8_t * pcWriteBuffer );
uint8_t ucRf4463GetProperty( uint16_t usStartProperty, uint8_t ucLength, uint8_t * pcParametersBuffer );
uint8_t ucRf4463SetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer );
uint8_t ucRf4463GetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer );

unsigned char SPIReadByte(unsigned long WrPara);
void SPIWriteByte(unsigned int WrPara);    

void vBufferSetToZero( uint8_t * pcBufferToClean, uint16_t uslength );

void GPIO_SET(unsigned char mydata);

void main() {

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

mode = master_mode;   // working mode setting
        //mode = slave_mode;

Sound_Init(&GPIOB_ODR, 7);
LED_GREEN = 1;
Sound_Play(3000, 100);
Delay_ms(100);
Sound_Play(4000, 100);
LED_GREEN =0;

//UART1_Write_Text("Start SDN Reset\n\r");
sdn_reset();

SI4463_init();






}


void sdn_reset(void)
{        
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

    Flujo de argumentos de POWER_UP
    Índice  Nombre  7   6   5   4   3   2   1   0
    0x00    CMD 0x02
    0x01    OPCIONES DE ARRANQUE    PARCHE  0   FUNC
    0x02    XTAL_OPTIONS    0   0   0   0   0   0   0   TCXO
    0x03    XO_FREQ XO_FREQ [31:24]
    0x04    XO_FREQ [23:16]
    0x05    XO_FREQ [15: 8]
    0x06    XO_FREQ [7: 0]

    #define RF_POWER_UP 0x02, 0x01, 0x00, 0x01, 0xC9, 0xC3, 0x80

    */

    uint8_t pcBuffer[ 7 ] = { RF_POWER_UP };
    uint8_t *charBuffer; 
    //uint8_t pcBuffer[ 7 ] = { 0x02, 0x01, 0x00, 0x01, 0xC9, 0xC3, 0x80 };

    //uint32_t frecTx = 915000000;

    // pcBuffer[0] = 0x02;        // Comando
    // pcBuffer[1] = 0x01;        // 0X00 No Parche , 0x01 con Parche
    // pcBuffer[2] = 0x00;        // XTAL    0x00   La señal de referencia se deriva del oscilador de cristal interno, TCXO  0x01 La señal de referencia se deriva de un TCXO externo.
    // pcBuffer[3] = (frecTx >> 24);
    // pcBuffer[4] = (frecTx >> 16);
    // pcBuffer[5] = (frecTx >> 8);
    // pcBuffer[6] = (frecTx);

    RF4463nSDN = 0x01;
    Delay_us( 16 );
    RF4463nSDN = 0x00 ;

    Delay_ms( 6 );

    RF4463nSEL = 0x00 ;
    vRf4463SPIWriteBuffer( sizeof( pcBuffer ), pcBuffer );
    RF4463nSEL= 0x01 ;

    //UART1_Write_Text("Power Up Finished\n\r");

}


void SI4463_init(void)
{        
        U8 app_command_buf[20];
        U8 i;
        
        //UART1_Write_Text("Start Config Radio\n\r");

        for(i=4;i<16;i++) 
                RF_MODEM_MOD_TYPE_12_data[i] = RF_MODEM_MOD_TYPE_12[rate][i-4];
        if(freq3<8)
        {
                for(i=4;i<12;i++)       
                        RF_MODEM_TX_RAMP_DELAY_8_data[i] = RF_MODEM_TX_RAMP_DELAY_8_433[rate][i-4];
                for(i=4;i<11;i++)
                        RF_MODEM_AFC_GEAR_7_data[i] = RF_MODEM_AFC_GEAR_7_433[rate][i-4];       
                for(i=4;i<15;i++)
                        RF_MODEM_OOK_CNT1_11_data[i] =RF_MODEM_OOK_CNT1_11_433[rate][i-4];
                for(i=4;i<16;i++)
                        RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[i] =RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433[rate][i-4];
                for(i=4;i<16;i++)
                        RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[i] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433[rate][i-4];
                for(i=4;i<16;i++)
                        RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[i] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433[rate][i-4];     
                for(i=4;i<13;i++)
                        RF_MODEM_AGC_WINDOW_SIZE_9_data[i] = RF_MODEM_AGC_WINDOW_SIZE_9_433[rate][i-4];
                for(i=4;i<13;i++)       
                        RF_MODEM_BCR_OSR_1_9_data[i] = RF_MODEM_BCR_OSR_1_9_433[rate][i-4];     
        }
        else
        {
                for(i=4;i<12;i++)       
                        RF_MODEM_TX_RAMP_DELAY_8_data[i] = RF_MODEM_TX_RAMP_DELAY_8_850[rate][i-4];
                for(i=4;i<11;i++)
                        RF_MODEM_AFC_GEAR_7_data[i] = RF_MODEM_AFC_GEAR_7_850[rate][i-4];               
                for(i=4;i<15;i++)
                        RF_MODEM_OOK_CNT1_11_data[i] =RF_MODEM_OOK_CNT1_11_850[rate][i-4];
                for(i=4;i<16;i++)
                        RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[i] =RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850[rate][i-4];
                for(i=4;i<16;i++)
                        RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[i] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850[rate][i-4];
                for(i=4;i<16;i++)
                        RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[i] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850[rate][i-4];     
                for(i=4;i<13;i++)
                        RF_MODEM_AGC_WINDOW_SIZE_9_data[i] = RF_MODEM_AGC_WINDOW_SIZE_9_850[rate][i-4]; 
                for(i=4;i<13;i++)       
                        RF_MODEM_BCR_OSR_1_9_data[i] = RF_MODEM_BCR_OSR_1_9_850[rate][i-4];     
        }               
        for(i=4;i<11;i++)
                RF_SYNTH_PFDCP_CPFF_7_data[i] = RF_SYNTH_PFDCP_CPFF_7[rate][i-4];

         GPIO_SET(mode);

// spi_write(0x05, RF_GLOBAL_XO_TUNE_1_data);   //  ÆµÂÊµ÷Õû
        app_command_buf[0]  = 0x11;  
        app_command_buf[1]  = 0x00;    // 0x0000 
        app_command_buf[2]  = 0x01;    // ¹² 1¸ö²ÎÊý
        app_command_buf[3]  = 0x00;   // 0x0000
        app_command_buf[4]  = 98;  // freq  adjustment
        vRf4463SPIWriteBuffer(5, app_command_buf);
        vBufferSetToZero( app_command_buf, 20 );
        
        UART1_Write_Text("Paret Info : ");
        ucRf4463GetCommand( 9, 0x01, app_command_buf );
        UART1_Write_Text("\n\r");
        
        // spi_write(0x05, RF_GLOBAL_CONFIG_1_data);  //  *******************************************************
        app_command_buf[0]  = 0x11;  
        app_command_buf[1]  = 0x00;    // 0x0003 
        app_command_buf[2]  = 0x01;    // ¹² 1¸ö²ÎÊý
        app_command_buf[3]  = 0x03;   // 0x0003
        app_command_buf[4]  = 0x40;  // tx = rx = 64 byte, ÆÕÍ¨ PH£¬high performance mode  ????????????????????? 
        vRf4463SPIWriteBuffer(5, app_command_buf); 
        vBufferSetToZero( app_command_buf, 20 );
    
    // *****************************************************************************    
        vRf4463SPIWriteBuffer(0x08, RF_FRR_CTL_A_MODE_4_data);    // disable all fast response register
     
    // spi_write(0x0D, RF_PREAMBLE_TX_LENGTH_9_data); Ç°µ¼ÂëÉèÖÃ*********************************************   
        app_command_buf[0]  = 0x11;  
        app_command_buf[1]  = 0x10;    // 0x1000 
        app_command_buf[2]  = 0x09;    // ¹² 9¸ö²ÎÊý
        app_command_buf[3]  = 0x00;   // 0x1000
        
        if(mode == tx_test_mode)
        {
                app_command_buf[4]  = 0xff;   //  ÐèÒª·¢ËÍ255¸ö×Ö½ÚµÄPreamble
        }
        else
        {
                app_command_buf[4]  = 0x08;   //  ÐèÒª·¢ËÍ8¸ö×Ö½ÚµÄPreamble
        }       
        
        //app_command_buf[4]  = 0x08;   //  ÐèÒª·¢ËÍ8¸ö×Ö½ÚµÄPreamble
        app_command_buf[5]   = 0x14;   //Òª¼ì²â20 bit Í¬²½×Ö£¬
        app_command_buf[6]   = 0x00;   // ·Ç±ê×¼µÄpreamble Éè¶¨£¬Ã»ÓÐÓÃ
        app_command_buf[7]   = 0x0f;   // Ç°µ¼ÂëTimeoutµÄÊ±¼ä   ????????????????????????????????????????????????????????????
        app_command_buf[8]   = 0x31;  // Ç°µ¼ÂëµÄ³¤¶ÈÒÔ byte ¼ÆËã£¬ 1st = 1£¬Ã»ÓÐmanchest  ±àÂë£¬Ê¹ÓÃ±ê×¼µÄ 1010.¡£¡£
        app_command_buf[9]   = 0x0;     //  ·Ç±ê×¼µÄPreambleµÄ Patten 4th byte
        app_command_buf[10]  = 0x00;   //  ·Ç±ê×¼µÄPreambleµÄ Patten 3rd byte
        app_command_buf[11]  = 0x00;  //  ·Ç±ê×¼µÄPreambleµÄ Patten 2nd byte
        app_command_buf[12]  = 0x00;  //  ·Ç±ê×¼µÄPreambleµÄ Patten 1st byte
        vRf4463SPIWriteBuffer(13, app_command_buf);  //     
        vBufferSetToZero( app_command_buf, 20 );

        //  RF_SYNC_CONFIG_5_data,  Í¬²½×ÖµÄÉèÖÃ *********************************************
        app_command_buf[0]  = 0x11;  
        app_command_buf[1]  = 0x11;    // command = 0x1100
        app_command_buf[2]  = 0x05;    // ¹² 5¸ö²ÎÊý
        app_command_buf[3]  = 0x00;   // command = 0x1100
        app_command_buf[4]  = 0x01;   //  Í¬²½×ÖÔÚ length field ¶¨Òå²¢·¢ËÍ£¬Í¬²½×Ö²»ÄÜÓÐ´í£¬²»ÊÇ 4FSK£¬ ²»ÊÇmanchest ±àÂë£¬Ö»ÓÐ 2¸ö×Ö½Ú
        
        if(mode == tx_test_mode)
        {
                app_command_buf[5]  = 0x55;   //Í¬²½×Ö 3
                app_command_buf[6]  = 0x55;   // Í¬²½×Ö2 
        }       
        else
        {
                app_command_buf[5]  = 0x2d;   //Í¬²½×Ö 3
                app_command_buf[6]  = 0xd4;   // Í¬²½×Ö2 
        }
        
        app_command_buf[7]  = 0x00;   // Í¬²½×Ö1
        app_command_buf[8]  = 0x00;  // Í¬²½×Ö 0
        vRf4463SPIWriteBuffer(9, app_command_buf);  //
        vBufferSetToZero( app_command_buf, 20 );

        //  packet crc ÉèÖÃ *******************************************************************        
        app_command_buf[0]  = 0x11;  
        app_command_buf[1]  = 0x12;    // command = 0x1200
        app_command_buf[2]  = 0x01;    // ¹² 1¸ö²ÎÊý
        app_command_buf[3]  = 0x00;   // command = 0x1200
        app_command_buf[4]  = 0x81; //   1ÊÇcRC ÖÖ×Ó£¬CRC = itu-c, enable crc
        vRf4463SPIWriteBuffer(5, app_command_buf);  
        vBufferSetToZero( app_command_buf, 20 );

        // packet   gernale configuration        
        app_command_buf[0]  = 0x11;  
        app_command_buf[1]  = 0x12;    // command = 0x1206
        app_command_buf[2]  = 0x01;    // ¹² 1¸ö²ÎÊý
        app_command_buf[3]  = 0x06;   // command = 0x1206
        app_command_buf[4]  = 0x02;   //  tx = rx = 120d--1220 (tx packet£¬ph enable, not 4fsk, ÊÕµ½Ò»°üÊý¾Ýºó£¬RX off,CRC ²»·­×ª £¬CRC MSB£¬ data MSB
        vRf4463SPIWriteBuffer(5, app_command_buf);  
        vBufferSetToZero( app_command_buf, 20 );

        // spi_write(0x07, RF_PKT_LEN_3_data);   //  ¹Ì¶¨³¤¶È£¬³¤¶ÈÒ»¸ö×Ö½Ú£¬³¤¶ÈÐÅÏ¢Ã»ÓÐÔÚPayloadÀïÃæ
        app_command_buf[0]  = 0x11;  
        app_command_buf[1]  = 0x12;    // command = 0x1208
        app_command_buf[2]  = 0x03;    // ¹² 3¸ö²ÎÊý
        app_command_buf[3]  = 0x08;   // command = 0x1208
        app_command_buf[4]  = 0x00;   //  Length Field = LSB,  length Ö»ÓÐ1¸ö×Ö½Ú£¬length ²»·ÅÔÚ FiFoÀïÃæ£¬¹Ì¶¨°ü³¤Ä£Ê½
        app_command_buf[5]  = 0x00;   //ÓÃÓÚ¿É±ä°ü³¤Ä£Ê½£¬¶¨ÒåÄÄ¸ö Field °üº¬ÁË length Filed
        app_command_buf[6]  = 0x00;   // ÓÃÓÚ¿É±ä°ü³¤Ä£Ê½£¬µ÷Õû¿É±ä°ü³¤µÄ length
        vRf4463SPIWriteBuffer(7, app_command_buf); 
        vBufferSetToZero( app_command_buf, 20 );
        
        // length Field 1 -- 4 µÄÉèÖÃ 
        app_command_buf[0]   = 0x11;  
        app_command_buf[1]   = 0x12;    // 0x120d 
        app_command_buf[2]   = 0x0c;    // ¹² 12¸ö²ÎÊý
        app_command_buf[3]   = 0x0d;   // 0x120d
        app_command_buf[4]   = 0x00;   //  Field 1 µÄ³¤¶È £¨¸ß4Î»£©
        app_command_buf[5]   = payload_length;   //  field 1 µÄ³¤¶È£¬ £¨µÍ 8Î»), ×Ü¹²14¸ö×Ö½Ú
        app_command_buf[6]   = 0x04;   // field 1 ²»ÊÇ 4FSK£¬manchest, whiting, PN9,   
        app_command_buf[7]   = 0xaa;   // field 1 crc enble, check enbale, ·¢ÉäÒ²ÓÐCRC£¬cRCµÄSeed ºÍCRC_seedÀïÃæµÄÒ»Ñù  
        app_command_buf[8]   = 0x00;  //  field2 µÄ³¤¶È£¨¸ß4Î»£©
        app_command_buf[9]   = 0x00;    //  field 2 µÄ³¤¶È£¬ £¨µÍ 8Î»)£¬ ³¤¶È = 0 ±íÊ¾Õâ¸öfield Ã»ÓÐÊ¹ÓÃ
        app_command_buf[10]  = 0x00;   // field 2 ²»ÊÇ 4FSK£¬manchest, whiting, PN9
        app_command_buf[11]  = 0x00;  //  field 2 µÄCRCÉèÖÃ
        app_command_buf[12]  = 0x00;  //  field 3 µÄ³¤¶È£¬ £¨µÍ 8Î»)£¬ ³¤¶È = 0 ±íÊ¾Õâ¸öfield Ã»ÓÐÊ¹ÓÃ
        app_command_buf[13]  = 0x00;    //  field 3 µÄ³¤¶È£¬ £¨µÍ 8Î»)£¬ ³¤¶È = 0 ±íÊ¾Õâ¸öfield Ã»ÓÐÊ¹ÓÃ
        app_command_buf[14]  = 0x00;   //  field 3 ²»ÊÇ 4FSK£¬manchest, whiting, PN9
        app_command_buf[15]  = 0x00;  //  field 3 µÄCRCÉèÖÃ
        vRf4463SPIWriteBuffer(16, app_command_buf);  // 
        vBufferSetToZero( app_command_buf, 20 );

    // spi_write(0x0C, RF_PKT_FIELD_4_LENGTH_12_8_8_data);  **************************************
        app_command_buf[0]   = 0x11;  
        app_command_buf[1]   = 0x12;    // 0x1219 
        app_command_buf[2]   = 0x08;    // ¹² 8¸ö²ÎÊý
        app_command_buf[3]   = 0x19;   // 0x1219
        app_command_buf[4]   = 0x00;   //  field4 µÄ³¤¶È£¨¸ß4Î»£©
        app_command_buf[5]   = 0x00;   //  field 4 µÄ³¤¶È£¬ £¨µÍ 8Î»)£¬ ³¤¶È = 0 ±íÊ¾Õâ¸öfield Ã»ÓÐÊ¹ÓÃ
        app_command_buf[6]   = 0x00;   //   field 4 ²»ÊÇ 4FSK£¬manchest, whiting, PN9
        app_command_buf[7]   = 0x00;   // field 4 µÄCRCÉèÖÃ
        app_command_buf[8]   = 0x00;  //  field5 µÄ³¤¶È£¨¸ß4Î»£©
        app_command_buf[9]   = 0x00;    //   field 5 µÄ³¤¶È£¬ £¨µÍ 8Î»)£¬ ³¤¶È = 0 ±íÊ¾Õâ¸öfield Ã»ÓÐÊ¹ÓÃ
        app_command_buf[10]  = 0x00;   //  field 5 ²»ÊÇ 4FSK£¬manchest, whiting, PN9
        app_command_buf[11]  = 0x00;   // field 5 µÄCRCÉèÖÃ
        vRf4463SPIWriteBuffer(12, app_command_buf);  //
        vBufferSetToZero( app_command_buf, 20 );

    // ********************************************************************************
        vRf4463SPIWriteBuffer(0x10, RF_MODEM_MOD_TYPE_12_data);   // //  2FSK ,  module source = PH fifo, disable manchest, tx, rx ²»·­×ª£¬ deviation ²»·­×ª
        
        //spi_write(0x05, RF_MODEM_FREQ_DEV_0_1_data); **************************************
        app_command_buf[0] = 0x11;  
        app_command_buf[1]  = 0x20;    // 0x200c                                                         
        app_command_buf[2]  = 0x01;    // ¹² 1¸ö²ÎÊý                                                     
        app_command_buf[3]  = 0x0c;   // 0x200c                                                          
        //app_command_buf[4]  = 0x4f; // frequency deviation µÄBit 0--7, ¸ù¾ÝWDS²úÉú
        if(freq3<8)
        {
                if(rate>=dr_256k)
                        app_command_buf[4]  = 0x4f;
                else if(rate>=dr_19p2)
                        app_command_buf[4]  = 0x5e;
                else
                    app_command_buf[4]  = 0xd2;   
        }
        else
        {
                if(rate>=dr_115p2)
                        app_command_buf[4]  = 0x69;     // 15k
                else if(rate>=dr_19p2)
                        app_command_buf[4]  = 0x5e;     // 10k
                else
                    app_command_buf[4]  = 0x18; // 8k
        }         
    vRf4463SPIWriteBuffer(5, app_command_buf);  
    vBufferSetToZero( app_command_buf, 20 );

    // ********************************************************************************    
    vRf4463SPIWriteBuffer(0x0C, RF_MODEM_TX_RAMP_DELAY_8_data);     // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
    vRf4463SPIWriteBuffer(0x0D, RF_MODEM_BCR_OSR_1_9_data);                 // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
    vRf4463SPIWriteBuffer(0x0B, RF_MODEM_AFC_GEAR_7_data);                  // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
    vRf4463SPIWriteBuffer(0x05, RF_MODEM_AGC_CONTROL_1_data);               // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
    vRf4463SPIWriteBuffer(0x0D, RF_MODEM_AGC_WINDOW_SIZE_9_data);   // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
    vRf4463SPIWriteBuffer(0x0F, RF_MODEM_OOK_CNT1_11_data);                 // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª   
    
        // spi_write(0x05, RF_MODEM_RSSI_COMP_1_data);  **************************************************
        app_command_buf[0] = 0x11;  
        app_command_buf[1] = 0x20;    // 0x204e                                                         
        app_command_buf[2] = 0x01;    // ¹² 1¸ö²ÎÊý                                                     
        app_command_buf[3] = 0x4e;   // 0x204e 
        if(rate==dr_500)
                app_command_buf[4]  = 0x3a; 
        else                                                         
                app_command_buf[4]  = 0x40;  //  rssi ¶ÁÊýÆ«²î£¬ÓëÕæÊµÖµµÄ²îÖµ
    vRf4463SPIWriteBuffer(5, app_command_buf);
    vBufferSetToZero( app_command_buf, 20 );

    // ********************************************************************************    
    vRf4463SPIWriteBuffer(0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data);  // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
    vRf4463SPIWriteBuffer(0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data);   // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
    vRf4463SPIWriteBuffer(0x10, RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data);   // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª        
        
        // RF_PA **************************************************************************
        app_command_buf[0] = 0x11;  
        app_command_buf[1]  = 0x22;    // 0x2200                                                         
        app_command_buf[2]  = 0x04;    // ¹² 4¸ö²ÎÊý                                                     
        app_command_buf[3]  = 0x00;   // 0x2200                                                          
        app_command_buf[4]  = 0x08;  //0x10;   //   PA mode  = default , Ê¹ÓÃClass E Ä£Ê½£¬¶ø²»ÊÇ Switch Current Ä£Ê½  ????????
        if(power==7)    
                app_command_buf[5]  = 127;   //  ÉèÖÃÎª×î´ó¹¦ÂÊ
        else if(power==6)
                app_command_buf[5]  = 50;
        else if(power==5)
                app_command_buf[5]  = 30;
        else if(power==4)
                app_command_buf[5]  = 20;
        else if(power==3)
                app_command_buf[5]  = 15;
        else if(power==2)
                app_command_buf[5]  = 10;
        else if(power==1)
                app_command_buf[5]  = 7;                                        
        else    
                app_command_buf[5]  = 4;                
        app_command_buf[6]  =0x00; //???????? 0x00;   // CLK duty = 50%£¬ ÆäËû = Default
        if((rate<=dr_115p2)||(rate==dr_500))
                app_command_buf[7]  = 0x3d;  // ???????? 0x5d;   // PA ramp time = default 
    else
        app_command_buf[7]  = 0x5d;    
     vRf4463SPIWriteBuffer(8, app_command_buf);        
     vBufferSetToZero( app_command_buf, 20 );

    // ********************************************************************************     
        vRf4463SPIWriteBuffer(0x0B, RF_SYNTH_PFDCP_CPFF_7_data);      // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
        
        // header match ******************************************************************
        app_command_buf[0]   = 0x11;  
        app_command_buf[1]   = 0x30;    // 0x3000                                                         
        app_command_buf[2]   = 0x0c;    // ¹² 12¸ö²ÎÊý                                                     
        app_command_buf[3]   = 0x00;   // 0x3000                                                          
        app_command_buf[4]   = 's';    //0x00;   //  match 1 µÄÖµ
        app_command_buf[5]   = 0xff;   //  match 1 mask
        app_command_buf[6]   = 0x40;   // eable match 1, match 1µÄÖµÓëÍ¬²½×ÖµÄÏà¾àµÄ¾àÀë, 0 = match 
        app_command_buf[7]   = 'w';    //  match 2 µÄÖµ                                        
        app_command_buf[8]   = 0xff;   //  match 2 mask                                        
        app_command_buf[9]   = 0x01;   // enable match 2, match 2µÄÖµÓëÍ¬²½×ÖµÄÏà¾àµÄ¾àÀë  , and function   
        app_command_buf[10]  = 'w';   //     match 3 µÄÖµ                                        
        app_command_buf[11]  = 0xff;    //  match 3 mask                                        
        app_command_buf[12]  = 0x02;    // enable match 3, match 3µÄÖµÓëÍ¬²½×ÖµÄÏà¾àµÄ¾àÀë    and function 
        app_command_buf[13]  = 'x';    //   match 4 µÄÖµ                                        
        app_command_buf[14]  = 0xff;   //   match 4 mask                                        
        app_command_buf[15]  = 0x03;   //  enable match 4, match 4µÄÖµÓëÍ¬²½×ÖµÄÏà¾àµÄ¾àÀë    and function 
        vRf4463SPIWriteBuffer(16, app_command_buf); 
        vBufferSetToZero( app_command_buf, 20 );

        rf_init_freq();

        //UART1_Write_Text("Finish Config Radio\n\r");
}

void rf_init_freq(void)
{       
        unsigned char OUTDIV,DIV,VCO,INTE,BAND;
        unsigned char FD_2,FD_1,FD_0,FRAC_2,FRAC_1,FRAC_0;
        unsigned long FRAC,mydata,frequency;
        U8 app_command_buf[20];
        
        //UART1_Write_Text("Start Config frequency\n\r");

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
        
        mydata = (frequency*DIV)/3;
        INTE = (mydata/100000)-1;
        FRAC = (mydata-(INTE+1)*100000)*16384/3125;
        FRAC = FRAC+0x80000;
        
        FRAC_0 = FRAC;
        FRAC>>=8;
        FRAC_1 = FRAC;
        FRAC>>=8;
        FRAC_2 = FRAC;
        
        // send freq cmd        
        
        app_command_buf[0] = 0x11;  
        app_command_buf[1]  = 0x20;    // 0x2051                                                         
        app_command_buf[2]  = 0x01;    // ¹² 1¸ö²ÎÊý                                                     
        app_command_buf[3]  = 0x51;   // 0x2051                                                          
        app_command_buf[4]  = 0x08|BAND;  //  high performance mode , clk outpu = osc /4
        vRf4463SPIWriteBuffer(5, app_command_buf); 
        vBufferSetToZero( app_command_buf, 20 );

        // UART1_Write_Text("Buffer frequency\n\r");
        // UART1_Write(app_command_buf[0]);
        // UART1_Write(app_command_buf[1]);
        // UART1_Write(app_command_buf[2]);
        // UART1_Write(app_command_buf[3]);
        // UART1_Write(app_command_buf[4]);

        app_command_buf[0] = 0x11;  
        app_command_buf[1]  = 0x40;    // 0x4000                                                         
        app_command_buf[2]  = 0x08;    // ¹² 8¸ö²ÎÊý                                                     
        app_command_buf[3]  = 0x00;   // 0x4000                                                          
        app_command_buf[4]  = INTE;   //  default value 
        app_command_buf[5]  = FRAC_2;   //  defaul value 
        app_command_buf[6]  = FRAC_1;   //  default value 
        app_command_buf[7]  = FRAC_0;   // frac ,from WDS
        app_command_buf[8]  = step_500K_step1;   // channel step1  from wds 
        app_command_buf[9]  = step_500K_step0;   // channel step0  from wds 
        app_command_buf[10] = 0x20;  //  from wds Ã»ÓÐÕâ¸öÖµ   
        app_command_buf[11]  = VCO;    // from wds Ã»ÓÐÕâ¸öÖµ 
        vRf4463SPIWriteBuffer(12, app_command_buf); 
        vBufferSetToZero( app_command_buf, 20 );
} 
 
void vRf4463SPIWriteBuffer( uint16_t usWriteLength, uint8_t * pcWriteBuffer ){
    /*************************************************************************************************
     * Native SPI Driver ( Communication with RF4463 )
    *************************************************************************************************/
    while( usWriteLength-- ){
        SPIWriteByte( *pcWriteBuffer++ );
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
    uint8_t display = 0;
    while( usReadLength-- ){
        pcReadBuffer[ ucRxCounter++ ] = SPIReadByte( 0 );
    }
}

/**************************************************************************************************
* Function Radio_ReadByte()
* -------------------------------------------------------------------------------------------------
* Overview: Function that reads the byte from the address
 
**************************************************************************************************/
unsigned char SPIReadByte(unsigned long WrPara)
{
unsigned int wAddr, wData;
unsigned char temp;
 wAddr = WrPara >> 8 & 0xff;                               // Extraigo la Dirección de escritura de 1 Byte
 wData = WrPara & 0xff;                                    // Extraigo el Valor que escribiré
 
 RF4463nSEL = 0;

  SPI2_Write(wAddr);
  temp = SPI2_Read(0);
  RF4463nSEL = 1;
  return temp;
}

/******************************************************************************
**Name£º    Radio Write Byte()
 
******************************************************************************/
void SPIWriteByte(unsigned int WrPara)                                                                
{                                                       
 unsigned int wAddr, wData;
 WrPara |= 0x8000;                                          // Agrego el bit en 1 en el byte alto para escribir via SPI 
 wAddr = WrPara >> 8 & 0xff;                                // Extraigo la Dirección de escritura de 1 Byte
 wData = WrPara & 0xff;                                     // Extraigo el Valor que escribiré

 RF4463nSEL = 0;                              // Selecciono el periferico para usarlo
 SPI2_Write(wAddr);                                    // Escibo la dirección donde quiero afectar el registro
 SPI2_Write(wData);                                    // Escribo el dato en la direccion que seleccione
 RF4463nSEL = 1;                              // Deselecciono el periferico
 
 //UART1_Write(wData);


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
    //UART1_Write_Text( "[ RF4463 ] CTS\r\n");
    
    while( usTimeoutCounter-- ){
        RF4463nSEL = 0x00;
        SPIWriteByte( READ_CMD_BUFF );
        // UART1_Write_Text("Command : ");
        // UART1_Write(READ_CMD_BUFF);
        // UART1_Write_Text("\n\r");

        if( SPIReadByte( READ_CMD_BUFF ) == RF4463_CTS_REPLY )
           {
             //UART1_Write_Text( "[ RF4463 ] CTS Retry\r\n" );
             RF4463nSEL= 0x01;
             return 1;
           }

        RF4463nSEL=0x01;
    }
    UART1_Write_Text( "[ RF4463 ] CTS failed\r\n" );
    return 0;
}

unsigned long hex2int(char *a, unsigned int len)
{
    int i;
    unsigned long val = 0;

    for(i=0;i<len;i++)
       if(a[i] <= 57)
        val += (a[i]-48)*(1<<(4*(len-1-i)));
       else
        val += (a[i]-55)*(1<<(4*(len-1-i)));

    return val;
}
 
uint8_t ucRf4463GetProperty( uint16_t usStartProperty, uint8_t ucLength, uint8_t * pcParametersBuffer ){
    uint8_t pcBuffer[ 4 ];

    if( ucRf4463CheckCTS() == 0 ){
        return 0;
    }

    pcBuffer[ 0 ] = GET_PROPERTY;
    pcBuffer[ 1 ] = ( usStartProperty >> 8 );
    pcBuffer[ 2 ] = ucLength;
    pcBuffer[ 3 ] = ( usStartProperty & 0xFF );

    RF4463nSEL = 0;
    vRf4463SPIWriteBuffer( 4, pcBuffer );

    if( ucRf4463CheckCTS() == 0 ){
        return 0;
    }
    
    RF4463nSEL= 0;
    SPIReadByte( READ_CMD_BUFF );

    vRf4463SPIReadBuffer( ucLength, pcParametersBuffer );
    RF4463nSEL = 1;

    return 1;
}



uint8_t ucRf4463GetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer ){
    if( ucRf4463CheckCTS() == 0 ){
        return 0;
    }

    RF4463nSEL= 0;
    SPIWriteByte( ucCommand );
    RF4463nSEL= 1;

    if( ucRf4463CheckCTS() == 0 ){
        return 0;
    }

    RF4463nSEL= 0;
    SPIWriteByte( READ_CMD_BUFF );
    vRf4463SPIReadBuffer( ucLength, pcParametersBuffer );
    RF4463nSEL= 1;
    UART1_Write_Text(pcParametersBuffer);
    return 1;
}

uint8_t ucRf4463SetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer ){
    if( ucRf4463CheckCTS() == 0 ){
        return 1;
    }

    RF4463nSEL = 0;
    SPIWriteByte( ucCommand );
    vRf4463SPIWriteBuffer( ucLength, pcParametersBuffer );
    RF4463nSEL = 1;
    
    return 1;
}

void vBufferSetToZero( uint8_t * pcBufferToClean, uint16_t uslength ){
    uint16_t usPosition = 0;

    for( usPosition = 0; usPosition < uslength; usPosition++ ){
        pcBufferToClean[ usPosition ] = 0x00;
    }
}


void GPIO_SET(unsigned char mydata)
{
        U8 app_command_buf[7];
        
        app_command_buf[0] = 0x13;     // gpio ÉèÖÃ
        
        switch(mydata)
        {
                case tx_normal:
                case rx_normal:
                        app_command_buf[1]  = 3;                // GPIO0=1
                        app_command_buf[2]  = 2;                // GPIO1=0
                break;
                
                case tx_test:
                        app_command_buf[1]  = 3;                // GPIO0=1
                        app_command_buf[2]  = 3;                // GPIO1=1
                break;
                
                case rx_test:
                        app_command_buf[1]  = 2;                // GPIO0=0
                        app_command_buf[2]  = 20;               // GPIO1=RX DATA
                break;
                
                case rf_off:
                        app_command_buf[1]  = 2;                // GPIO0=0
                        app_command_buf[2]  = 2;                // GPIO1=0
                break;                   
        }
        
        app_command_buf[3]  = 0x21;  //0x20;   //  gpio2, h = tx mode
        app_command_buf[4]  = 0x20; // 0x14;  //   gpio3 
        app_command_buf[5]  = 0x27;   // nIRQ
        app_command_buf[6]  = 0x0b;  // sdo
        vRf4463SPIWriteBuffer(7, app_command_buf);  
}