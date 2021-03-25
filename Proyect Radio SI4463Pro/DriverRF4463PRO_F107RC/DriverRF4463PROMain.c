#include "STM32F107RCDefs.h"            // definiciones de Hardware para micro especifico
#include "DriverSPI.c"
#include "ConfigRF4463PRO.h"            // configuracion para RF4463PRO
#include "DriverRF4463PROdefs.c"        // Definiciones para RF4463PRO
#include "DriverRF4463PRO.c"            // Libreria para RF4463PRO

#define NULL ( ( void * )0 )
#define _NULL   ( char )0
#define PIN_LEVEL_LOW   0
#define PIN_LEVEL_HIGH  1

#include "utils.c"
#include "UARTHandler.c"
#include "Debug.c"

void Timer2_interrupt() iv IVT_INT_TIM2 {
     TIM2_SR.UIF = 0;
     Flag.rf_reach_timeout = 1; //Enter your code here
}


void vRF4463MainCommandProcessor ( ) {

}



//Timer2 Prescaler :1124; Preload = 63999; Actual Interrupt Time = 1
//Place/Copy this part in declaration section
void InitTimer2(){
     RCC_APB1ENR.TIM2EN = 1;
     TIM2_CR1.CEN = 0;
     TIM2_PSC = 1124;
     TIM2_ARR = 63999;
     NVIC_IntEnable(IVT_INT_TIM2);
     TIM2_DIER.UIE = 1;
     TIM2_CR1.CEN = 1;
}



void main() {
     
     Delay_ms( 2000 );                    // delay de depuracion
     
     // Basic Init
     // LEDS
     GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_6 );
     GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_7 );
     GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_8 );
     
     GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_7 );
     Sound_Init( &GPIOB_ODR, 7 );
     Sound_Play( 1000, 100 );
     
     LED_RED      = 1;
     LED_GREEN    = 1;
     LED_BLUE     = 1;
     
     Delay_ms( 100 );
     
     LED_RED      = 0;
     LED_GREEN    = 1;
     LED_BLUE     = 0;
     
     InitTimer2();
     
     // Init driver ( MCU Specific )
     vUARTTxInit();                // configura todos las parametros de USART
     vSPI2Init();                  // configura todos los parametros de SPI
     
     // ESTABLECE PARAMETROS DEFAULT POR COMPILACION
     
     // rangos de 0 a 9
     freq3 = 9;
     freq2 = 1;
     freq1 = 5;
     
     // rangos de 0 a 7
     power = 7;
     
     rate  = dr_1p2;
     
     mode  = master_mode;          // para
     
     // Init Device
     //ucRF4463Setup( RF4463_DEFAULT_CHANNEL, RF4463_DEFAULT_CHANNEL, RF4463_DEFAULT_NETWORK, RF4463_DEFAULT_TX_POWER );
     VRF4463SDNReset();
     vRF4463Init();
     
     //ucRf4463DeviceAvailability();
     
     LED_GREEN    = 0;
     LED_BLUE     = 1;
     
     while ( 1 ) {
           // Espera comando para realizar cierta accion

           if ( mode == master_mode ) {
              vRF4463TxData();
           }
           else if ( mode == slave_mode ) {
              vRF4463RxStart();
           }
           //Delay_ms( 500 );
     }
}