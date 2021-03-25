/***********************************************************
*  File name:        define.h
*  Describe:
*  Device:
*  CPU:               STM32F107RC
*  Write by:
*  Version:        1.0
***********************************************************/
#ifndef DEFINE_H
#define DEFINE_H

//======================================================================
#define          LED_GREEN               GPIOE_ODRbits.ODR9      //  PC7
#define          LED_RED                 GPIOE_ODRbits.ODR11      //  PC6
#define          LED_BLUE                GPIOE_ODRbits.ODR13      //  PC8

#define          nIRQ                    GPIOD_IDRbits.IDR0     //  PD10
#define          SDN                     GPIOD_ODRbits.ODR1      //  PC2
#define          nSEL                    GPIOD_ODRbits.ODR2     //  PD13


#define         dr_1p2                   0
#define         dr_2p4                   1
#define         dr_4p8                   2
#define         dr_9p6                   3
#define         dr_19p2                  4
#define         dr_38p4                  5
#define         dr_76p8                  6
#define         dr_115p2                 7
#define         dr_256k                  8
#define         dr_500k                  9
#define         dr_500                   10

//#define         set_freq3                1
//#define         set_freq2                2
//#define         set_freq1                3
//#define         set_power                4
//#define         set_dr                   5
//#define         set_trmode               6                // set freq offset


// MODE
#define         master_mode     0
#define         slave_mode      1
#define         tx_test_mode    2
#define         rx_test_mode    3
#define         rf_off          4


// GPIO_SET
#define         tx_normal       0
#define         rx_normal       1
#define         tx_test         2
#define         rx_test         3
#define         rf_off          4

#endif