/***********************************************************
*  File name:        define.h
*  Describe:
*  Device:
*  CPU:                R5F211B4
*  Write by:
*  Version:        1.0
***********************************************************/
#ifndef DEFINE_H
#define DEFINE_H

//#include "sfr_r81b.h"
//======================================================================

typedef         unsigned char        U8;
typedef         unsigned int        U16;
typedef         unsigned long       U32;
typedef         char                 S8;
typedef         int                 S16;
typedef         long                S32;

#define          WR                 p3_3
#define          DATA               p3_4
#define          CS                 p3_5
#define          SDI                p3_7
#define          key_set            p1_0
#define          key_up             p1_1
#define          key_down           p1_2
#define          nSEL               GPIOB_ODRbits.ODR12     //  PB12 //  p1_3
#define          LED_GREEN          GPIOC_ODRbits.ODR7      //  PC7  //       p1_4
#define          LED_RED            GPIOC_ODRbits.ODR6      //  PC6  //       p1_5
#define          LED_BLUE           GPIOC_ODRbits.ODR8      //  PC8
//#define          SCK              p1_6       // no se hace por software, puede comentarse
#define          nIRQ               GPIOC_IDRbits.IDR12     //  PC12 //   p1_7
#define          GPIO1_TEST         p4_2
#define          SDN                GPIOB_ODRbits.ODR11     //  PB11   p4_5
//#define          SDO                        p4_6
//#define                         p4_7

#define         dr_1p2             0
#define         dr_2p4             1
#define         dr_4p8             2
#define         dr_9p6             3
#define         dr_19p2            4
#define         dr_38p4            5
#define         dr_76p8            6
#define         dr_115p2           7
#define         dr_256k            8
#define         dr_500k            9
#define         dr_500             10

#define           NOP_KEY                        7
#define                SET_KEY                        6
#define                UP_KEY                        5
#define                DOWN_KEY                3

#define         set_freq3                1
#define         set_freq2                2
#define         set_freq1                3
#define                set_power                4
#define         set_dr                        5
#define         set_trmode                6                // set freq offset


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


//#define         EI();                asm("FSET I");
//#define         DI();                asm("FCLR I");

#endif