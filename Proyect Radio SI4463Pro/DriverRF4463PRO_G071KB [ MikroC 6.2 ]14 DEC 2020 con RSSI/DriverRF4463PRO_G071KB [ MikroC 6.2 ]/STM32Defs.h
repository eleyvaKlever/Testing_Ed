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

#ifdef STM32F107RC
       #define          nSEL                    GPIOB_ODRbits.ODR12     //  PB12
       #define          LED_GREEN               GPIOC_ODRbits.ODR7      //  PC7
       #define          LED_RED                 GPIOC_ODRbits.ODR6      //  PC6
       #define          LED_BLUE                GPIOC_ODRbits.ODR8      //  PC8
       #define          nIRQ                    GPIOC_IDRbits.IDR12     //  PC12
       #define          SDN                     GPIOB_ODRbits.ODR11     //  PB11
#endif

#ifdef STM32F107VC
       #define          nSEL                    GPIOD_ODRbits.ODR13     //  PD13
       #define          LED_GREEN               GPIOC_ODRbits.ODR7      //  PC7
       #define          LED_RED                 GPIOC_ODRbits.ODR6      //  PC6
       #define          LED_BLUE                GPIOC_ODRbits.ODR8      //  PC8
       #define          nIRQ                    GPIOD_IDRbits.IDR10     //  PD10
       #define          SDN                     GPIOC_ODRbits.ODR2      //  PC2
#endif

#ifdef STM32F407VG
       #define          nSEL                    GPIOD_ODRbits.ODR13     //  PD13
       #define          LED_GREEN               GPIOC_ODRbits.ODR7      //  PC7
       #define          LED_RED                 GPIOC_ODRbits.ODR6      //  PC6
       #define          LED_BLUE                GPIOC_ODRbits.ODR8      //  PC8
       #define          nIRQ                    GPIOD_IDRbits.IDR10     //  PD10
       #define          SDN                     GPIOC_ODRbits.ODR2      //  PC2
#endif

#ifdef STM32G071KB
       #define          nSEL                    GPIOA_ODRbits.ODR3      //  PA3
       #define          LED_GREEN               GPIOC_ODRbits.ODR6      //  PC6
       #define          LED_RED                 GPIOC_ODRbits.ODR6      //  PC6
       #define          LED_BLUE                GPIOC_ODRbits.ODR8      //  PC8
       #define          nIRQ                    GPIOA_IDRbits.IDR2      //  PA2
       #define          SDN                     GPIOB_ODRbits.ODR2      //  PB2
#endif

#ifdef STM32L072CB
       #define          nSEL                    GPIOB_ODRbits.ODR12      //  PA3
       #define          Level1Led               GPIOA_ODR._GPIO_PIN_7
       #define          Level2Led               GPIOA_ODR._GPIO_PIN_6
       #define          Level3Led               GPIOA_ODR._GPIO_PIN_5
       #define          Level4Led               GPIOA_ODR._GPIO_PIN_4
       #define          Level5Led               GPIOA_ODR._GPIO_PIN_3
       #define          Level6Led               GPIOA_ODR._GPIO_PIN_2
       #define          Level7Led               GPIOA_ODR._GPIO_PIN_1 
       #define          nIRQ                    GPIOD_IDRbits.IDR0      //  PA2
       #define          SDN                     GPIOD_ODRbits.ODR1      //  PB2
#endif

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