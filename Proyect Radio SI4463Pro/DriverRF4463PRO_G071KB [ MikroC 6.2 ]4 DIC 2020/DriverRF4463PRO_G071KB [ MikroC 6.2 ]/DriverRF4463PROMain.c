//-----------------------------------------------------------------------------------------------------------
// DEMO RADIO
// 
// DISPOSITIVO: RF4463PRO ( NICERF )
//
// KLEVERNESS, DEPARTAMENTO DE HARDWARE ( DIC 2020 )
//
// Programa para evaluacion pura de radio
// Listo para operar con cualquier micro incluido en la lista de abajo. Para todos la comunicacion de debug
// es mediante USART1 a 921600 8N1
// ** IMPORTANTE: solamente cargar un perfil estandar de mikroe para que funcione.
//
// v0.1 
//      Comunicacion SPI operada mediante software en TX e Interrupcion para RX.
//      Manejo de nIRQ mediante Polling.
// v0.2
//      Preparado para Familia STM32G0x1
//      Se incluyen perfiles de configuracion usados para HSI 2, 8 y 16MHz, deben cargarse por separado.
//      Debe configurarse USART1: 115200 8N1
//      Comunicacion SPI operada mediante DMA en TX e Interrupcion para RX
//-----------------------------------------------------------------------------------------------------------
void vRF4463MainCommandProcessor ( unsigned char *ucBuffer );


#include "STM32Defs.h"                  // definiciones de Hardware para micro especifico
#include "DriverSPI.c"
#include "ConfigRF4463PRO.h"            // configuracion para RF4463PRO
#include "DriverRF4463PROdefs.c"        // Definiciones para RF4463PRO
#include "DriverRF4463PRO.c"            // Libreria para RF4463PRO


// DESCOMENTAR SOLAMENTE 1 PARA USAR
#define STM32F107RC          // DONGLE SENCILLO
//#define STM32F107VC          // EasyMX PRO V7 ( perfil de configuracion incluido en MikroE )
//#define STM32F407VG          // EasyMX PRO V7 ( perfil de configuracion incluido en MikroE )
//#define STM32G071KB            // Circuitos de botonera



#define NULL ( ( void * )0 )
#define _NULL   ( char )0
#define PIN_LEVEL_LOW   0
#define PIN_LEVEL_HIGH  1

#include "utils.c"
#include "UARTHandler.c"
#include "Debug.c"

//void RFISR() iv IVT_INT_EXTI15_10 ics ICS_AUTO{
//    if( EXTI_PR.B12 ){
//        EXTI_PR.B12 |= 1;
//        LED_RED = 1;
//        ucRF4463IRQ = 1;
//        UART1_Write_Text( "RF int\r\n" );
//        //vRF4463ClearInterrupts();
//    }
//}

void Timer2_interrupt() iv IVT_INT_TIM2 {
     TIM2_SR.UIF = 0;
     Flag.rf_reach_timeout = 1; //Enter your code here
     Flag.reach_1s = 1;
}

//===========================================================================================================
// Procesador de comandos desde Buffers de USART
void vRF4463MainCommandProcessor ( unsigned char *ucBuffer ) {

}



//Timer2 Prescaler :1124; Preload = 63999; Actual Interrupt Time = 1
//Place/Copy this part in declaration section
void InitTimer2(){
     #ifndef STM32G071KB
             RCC_APB1ENR.TIM2EN = 1;
             TIM2_CR1.CEN = 0;
             TIM2_PSC = 1124;
             TIM2_ARR = 63999;
             NVIC_IntEnable( IVT_INT_TIM2 );
             TIM2_DIER.UIE = 1;
             TIM2_CR1.CEN = 1;
     #endif
     
     #ifdef STM32G071KB
            RCC_APBENR1bits.TIM2EN = 1;
            TIM2_CR1.CEN = 0;
            TIM2_PSC = 249;
            TIM2_ARR = 63999;
            NVIC_IntEnable( IVT_INT_TIM2 );
            TIM2_DIER.UIE = 1;
            TIM2_CR1.CEN = 1;
     #endif
}



void main() {
     
     unsigned char  i, j, chksum;
     
     Delay_ms( 2000 );                    // delay de depuracion
     
     #ifdef STM32F107RC // Dongle Sencillo
            // Basic Init
            // LEDS
            GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_6 );
            GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_7 );
            GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_8 );
     
            /*********************************************************************
            * RF4463Pro I/O Setup
            *********************************************************************/
            GPIO_Digital_Input( &GPIOC_BASE, _GPIO_PINMASK_12 );          // nIRQ

            GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_12 );         // nSEL
            GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_11 );         // SDN
            GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_11 );         // GPIO0
            GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_10 );         // GPIO1
     
            /********************************************************
            * Clock Enable
            ********************************************************/
            RCC_APB2ENRbits.AFIOEN = 1;
            /********************************************************
            * Pin Configuration
            ********************************************************/
            AFIO_EXTICR4  |= 0x0002;
            /********************************************************
            * Interruption Edge Flag
            ********************************************************/
            EXTI_IMR.B12    |= 1;
            EXTI_FTSR.B12   |= 1;
            
            GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_7 );
            Sound_Init( &GPIOB_ODR, 7 );
            Sound_Play( 1000, 100 );
     #endif
     
     #ifdef STM32F107VC // Sistema de desarrollo ( MikroBUS 1 )
            // Basic Init
            // LEDS
            GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_6 );
            GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_7 );
            GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_8 );

            /*********************************************************************
            * RF4463Pro I/O Setup ( MikroBUS 1 )
            *********************************************************************/
            GPIO_Digital_Input( &GPIOD_BASE, _GPIO_PINMASK_10 );          // nIRQ

            GPIO_Digital_Output( &GPIOD_BASE, _GPIO_PINMASK_13 );         // nSEL
            GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_2 );          // SDN
            GPIO_Digital_Output( &GPIOA_BASE, _GPIO_PINMASK_4 );          // GPIO0
            GPIO_Digital_Output( &GPIOA_BASE, _GPIO_PINMASK_0 );          // GPIO1

            /********************************************************
            * Clock Enable
            ********************************************************/
            RCC_APB2ENRbits.AFIOEN = 1;
            /********************************************************
            * Pin Configuration
            ********************************************************/
            AFIO_EXTICR4  |= 0x0002;
            /********************************************************
            * Interruption Edge Flag
            ********************************************************/
            EXTI_IMR.B10    |= 1;
            EXTI_FTSR.B10   |= 1;
            
            GPIO_Digital_Output( &GPIOE_BASE, _GPIO_PINMASK_14 );
            Sound_Init( &GPIOE_ODR, 14 );
            Sound_Play( 1000, 100 );
     #endif
     
     #ifdef STM32F407VG // Sistema de desarrollo ( MikroBUS 1 )
            // Basic Init
            // LEDS
            GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_6 );
            GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_7 );
            GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_8 );

            /*********************************************************************
            * RF4463Pro I/O Setup ( MikroBUS 1 )
            *********************************************************************/
            GPIO_Digital_Input( &GPIOD_BASE, _GPIO_PINMASK_10 );          // nIRQ

            GPIO_Digital_Output( &GPIOD_BASE, _GPIO_PINMASK_13 );         // nSEL
            GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_2 );          // SDN
            GPIO_Digital_Output( &GPIOA_BASE, _GPIO_PINMASK_4 );          // GPIO0
            GPIO_Digital_Output( &GPIOA_BASE, _GPIO_PINMASK_0 );          // GPIO1

            /********************************************************
            * Clock Enable
            ********************************************************/
            //RCC_APB2ENRbits.AFIOEN = 1;
            /********************************************************
            * Pin Configuration
            ********************************************************/
            //AFIO_EXTICR4  |= 0x0002;
            /********************************************************
            * Interruption Edge Flag
            ********************************************************/
            EXTI_IMR.B10    |= 1;
            EXTI_FTSR.B10   |= 1;

            GPIO_Digital_Output( &GPIOE_BASE, _GPIO_PINMASK_14 );
            Sound_Init( &GPIOE_ODR, 14 );
            Sound_Play( 1000, 100 );
     #endif
     
     #ifdef STM32G071KB    // Circuitos de sensores y botonera
            // Basic Init
            // LEDS
            GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_6 );  // r   ( Led Rojo de tarjeta de desarrollo )
            //GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_7 );  // g
            //GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_8 );  // b

            // Salida de Regulador para RADIO
            GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_9 );

            // Entradas de seleccion para Software
            GPIO_Digital_Input( &GPIOC_BASE, _GPIO_PINMASK_14 );
            GPIO_Digital_Input( &GPIOC_BASE, _GPIO_PINMASK_15 );

            /*********************************************************************
            * RF4463Pro I/O Setup Cicuitos de Botonera y Sensores
            *********************************************************************/
            GPIO_Digital_Input( &GPIOA_BASE, _GPIO_PINMASK_2 );          // nIRQ

            GPIO_Digital_Output( &GPIOA_BASE, _GPIO_PINMASK_3 );         // nSEL
            GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_2 );         // SDN
            GPIO_Digital_Output( &GPIOA_BASE, _GPIO_PINMASK_11 );        // GPIO0
            GPIO_Digital_Output( &GPIOA_BASE, _GPIO_PINMASK_12 );        // GPIO1

            /********************************************************
            * Clock Enable
            ********************************************************/
            //RCC_APB2ENRbits.AFIOEN = 1;
//            /********************************************************
//            * Pin Configuration
//            ********************************************************/
//            AFIO_EXTICR4  |= 0x0002;
//            /********************************************************
//            * Interruption Edge Flag
//            ********************************************************/
//            EXTI_IMR.B10    |= 1;
//            EXTI_FTSR.B10   |= 1;
            
            RCC_APBENR2bits.SYSCFGEN = 1;

            SYSCFG_VREFBUF_CFGR1bits.UCPD1_STROBE = 1;
     #endif
     
     nSEL = 1;
     
     LED_RED      = 1;
     LED_GREEN    = 1;
     LED_BLUE     = 1;
     
     Delay_ms( 100 );
     
     LED_RED      = 0;
     LED_GREEN    = 1;
     LED_BLUE     = 0;
     
     InitTimer2();
     
     // Init driver ( MCU Specific )
     vUSARTConfigUSART1( 115200 );  // configura todos las parametros de USART
     //vUARTRxInit();
     
     #ifdef STM32F107RC
            vSPI2Init();           // configura todos los parametros de SPI
     #endif
     
     #ifdef STM32F107VC
            vSPI3Init();           // configura todos los parametros de SPI
     #endif
     
     #ifdef STM32F407VG
            vSPI3Init();           // configura todos los parametros de SPI
     #endif
     
     #ifdef STM32G071KB
            vSPI1Init();           // configura todos los parametros de SPI
     #endif
     
     // ESTABLECE PARAMETROS DEFAULT POR COMPILACION---------------------------------------------------------
     
     // FRECUENCIA BASE PREDETERMINADA ( 0 A 9 )
     freq3 = 9;
     freq2 = 1;
     freq1 = 5;
     
     // POTENCIA DE TRANSMISION ( rangos de 0 a 127 )
     power = 1;
     
     rate  = dr_1p2;                // BAUDRATE
     
     mode  = slave_mode;          // para transmision continua usar: tx_test_mode
     
     // ESTABLECE PARAMETROS DEFAULT POR COMPILACION---------------------------------------------------------
     
     reset_mode = 0;
     
     // Init Device
     //ucRF4463Setup( RF4463_DEFAULT_CHANNEL, RF4463_DEFAULT_CHANNEL, RF4463_DEFAULT_NETWORK, RF4463_DEFAULT_TX_POWER );
     VRF4463SDNReset();
     vRF4463Init();
     vRF4463ClearInterrupts();
     vRF4463PartInfo ();          // SOLICITA EL MODELO DEL RADIO
     
     LED_GREEN    = 0;
     LED_BLUE     = 0;
     
     //UART1_Write_Text( "RF Radio ready" );
     
     #ifndef STM32G071KB
             vUSART1Start_TX( "[ SYS STM32F ]RF Radio ready\r\n", 23 );   // enviado por DMA
     #elif defined STM32G071KB
             UART1_Write_Text( "[ SYS STM32G ]RF Radio ready\r\n" );
     #endif
     
     while ( 1 ) {
     
           // ESPERA INTERRUPCION POR USART
           //if (  ) {
//
//           }
     
           // Espera comando para realizar cierta accion
           if ( ucRF4463IRQ ) {
              ucRF4463IRQ = 0;       // limpia bandera
              spi_read_fifo();       // Read RX FIFO
              vRF4463FifoReset();    // FIFO RESET
              UART1_Write_Text( spi_read_buf );
           }

           // MODO MAESTRO
           if ( mode == master_mode ) {
              vRF4463TxData();
           }
           
           // MODO ESCLAVO
           else if ( mode == slave_mode ) {
                vRF4463RxInit();
           }
           
           // MODO DE TRANSMISION CONTINUA
           if ( mode == tx_test_mode ) {
              vRF4463TxCont();
              while ( 1 ) {
                    if ( !nIRQ ) {
                       vRF4463TxCont();
                    }
              }
           }
           
           if ( mode == rx_test_mode ) {
              vRF4463RxInit ();
              while ( 1 ) {
                    //spi_read_fifo();           // Lee ceros
              }
           }
           
           if ( reset_mode == 0 ) {
              
              while ( 1 ) {
                    
                    if ( Flag.reach_1s ) {
                       Flag.reach_1s = 0;
                       if ( mode == master_mode ) {
                          vRF4463TxData();
                       }
                    }
                    
                    // recibiendo optimo !!
                    if ( !Flag.is_tx ) {
                       if ( !nIRQ ) {          // !nIRQ
                          vRF4463ClearInterrupts();
                          
                          if ( ( spi_read_buf[ 4 ] & 0x08) == 0 ) { // crc error check
                          
                             spi_read_fifo();
                             vRF4463FifoReset();
                          
                             chksum = 0;
                             for ( i = 4; i < payload_length - 1; i++ )                // Calculation Checksum
                                 chksum += rx_buf[ i ];

                             if ( ( chksum == rx_buf[ payload_length - 1 ] )&&( rx_buf[ 4 ] == 0x41 )) {
                             
                                //UART1_Write_Text( rx_buf );
                                //UART1_Write_Text("\r\n");
                                
                                #ifndef STM32G071KB
                                        vUSART1Start_TX( rx_buf, payload_length );
                                        vUSART1Start_TX("\r\n", 2);
                                #elif defined STM32G071KB
                                        UART1_Write_Text( rx_buf );
                                        UART1_Write_Text("\r\n");
                                #endif
                              
                              
                              
                                LED_GREEN ^= 1;                                        // Data received
                                rx_cnt++;

                                //if ( ( mode == slave_mode )&& ( set == 0 ) ) {
                                //   delay_1ms(100);
                                //   tx_data();
                                //}
                             }
                             else
                                 vRF4463RxInit();    // The received data is wrong, you must continue to receive
                          }
                          else {
                               //UART1_Write_Text("[ CRC ] Fail\r\n");
                               vUSART1Start_TX("[ CRC ] Fail\r\n", 14 );
                               VRF4463SDNReset();
                               vRF4463Init();
                               vRF4463RxInit();
                          }
                       }
                    }
              }
           }
     }
}