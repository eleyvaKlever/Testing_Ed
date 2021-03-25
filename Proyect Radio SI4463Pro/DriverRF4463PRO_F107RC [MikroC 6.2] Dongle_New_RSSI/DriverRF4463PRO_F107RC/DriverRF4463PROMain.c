#include "built_in.h"
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

int intRSSI;
float rssi;
char pcRSSI[ 9 ] = {0}; // 9
char pcBuffer[ 5 ] = {0};
char Value[4];
float iVal;
    
void RFISR() iv IVT_INT_EXTI15_10 ics ICS_AUTO{
    if( EXTI_PR.B12 ){
        EXTI_PR.B12 |= 1;
        LED_RED = 1;
        ucRF4463IRQ = 1;
        UART1_Write_Text( "RF int\r\n" );
        //vRF4463ClearInterrupts();
    }
}

void Timer2_interrupt() iv IVT_INT_TIM2 {
     TIM2_SR.UIF = 0;
     Flag.rf_reach_timeout = 1; //Enter your code here
     Flag.reach_1s = 1;
}


void vRF4463MainCommandProcessor ( ) {

}



//Timer2 Prescaler :1124; Preload = 63999; Actual Interrupt Time = 1
//Place/Copy this part in declaration section
void InitTimer2(){

     RCC_APB1ENR.TIM2EN = 1;
     TIM2_CR1.CEN = 0;
  TIM2_PSC = 449;
  TIM2_ARR = 63999;


/*
     if( Opcion == 1 )    // 1_p_ 500 baud Nofunciona Esta velocidad
         {
            TIM2_PSC = 359;
            TIM2_ARR = 59999;
            UART1_Write_Text("[ 500 Bauds ]\n\r");
         }
      if( Opcion == 2 )   // 1200 baud  220ms
         {
            TIM2_PSC = 249;      // 14 Bytes Payload // 220 ms
            TIM2_ARR = 63359;    // 14 Bytes Payload

            //TIM2_PSC = 674;    // 66 Bytes Payload // 600 ms
            //TIM2_ARR = 63999;  // 66 Bytes Payload
            UART1_Write_Text("[ 1200 Bauds ]\n\r");
         }
      if( Opcion == 3 )      // 2400 baud 120 ms
         {
            TIM2_PSC = 134;     // 14 Bytes Payload // 300 ms
            TIM2_ARR = 63999;
            //TIM2_PSC = 359;    // 66 Bytes Payload // 600 ms
            //TIM2_ARR = 59999;  // 66 Bytes Payload
            UART1_Write_Text("[ 2400 Bauds ]\n\r");
         }
      if( Opcion == 4 )      // 4800 baud 80 ms
         {
            TIM2_PSC = 89;     // 14 Bytes
            TIM2_ARR = 63999;  // 14 Bytes
            //TIM2_PSC = 179;    //160 ms 66 Bytes
            //TIM2_ARR = 63999;  //160 ms 66 bytes
            UART1_Write_Text("[ 9600 Bauds ]\n\r");
         }
      if( Opcion == 5 )      // 9600 baud 55 ms
         {
            TIM2_PSC = 63;
            TIM2_ARR = 61874;
         }
      if( Opcion == 6 )      // 19200 baud 45 ms
         {
            TIM2_PSC = 49;
            TIM2_ARR = 64799;
         }
      if( Opcion == 7 )      // 38600 baud 40 ms
         {
            TIM2_PSC = 44;
            TIM2_ARR = 63999;
         }
      if( Opcion == 8 )      // 76600 baud 5 ms
         {
            TIM2_PSC = 3;
            TIM2_ARR = 59999;
         }
      if( Opcion == 9 )      // 115200 baud 3 ms
         {
            TIM2_PSC = 3;
            TIM2_ARR = 53999;
         }
*/   
     NVIC_IntEnable(IVT_INT_TIM2);
     TIM2_DIER.UIE = 1;
     TIM2_CR1.CEN = 1;
}



void main() {
     
     unsigned char  i, j;
     int chksum, chechsumLo, chechsumHi;
     float iVal;
     
     Delay_ms( 2000 );                    // delay de depuracion
     
     // Basic Init
     // LEDS
     GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_6 );
     GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_7 );
     GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_8 );
     
     //GPIO_Digital_Input( &GPIOC_BASE, _GPIO_PINMASK_12 );
     /*********************************************************************
     * RF4463Pro I/O Setup
     *********************************************************************/
     GPIO_Digital_Input( &GPIOC_BASE, _GPIO_PINMASK_12 );

     GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_12 );
     GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_11 );
     GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_11 );
     GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_10 );
     
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
     vUARTTxInit();                // configura todos las parametros de USART
     vSPI2Init();                  // configura todos los parametros de SPI
     
     // ESTABLECE PARAMETROS DEFAULT POR COMPILACION
     
     // rangos de 0 a 9
     freq3 = 9;
     freq2 = 1;
     freq1 = 5;
     
     // rangos de 0 a 7
     power = 127;
     
     rate  = dr_4p8;
     
     mode  = slave_mode;          // para transmision continua usar: tx_test_mode
     
     reset_mode = 0;
     
     // Init Device
     //ucRF4463Setup( RF4463_DEFAULT_CHANNEL, RF4463_DEFAULT_CHANNEL, RF4463_DEFAULT_NETWORK, RF4463_DEFAULT_TX_POWER );
     VRF4463SDNReset();
     vRF4463Init();
     vRF4463ClearInterrupts();
     vRF4463PartInfo ();
     
     LED_GREEN    = 0;
     LED_BLUE     = 0;
     
     UART1_Write_Text( "RF Radio ready" );
     
     while ( 1 ) {
           // Espera comando para realizar cierta accion
           if ( ucRF4463IRQ ) {
              ucRF4463IRQ = 0;       // limpia bandera
              spi_read_fifo();       // Read RX FIFO
              vRF4463FifoReset();    // FIFO RESET
              UART1_Write_Text( spi_read_buf );
           }


           if ( mode == master_mode ) {
              vRF4463TxData();
           }
           
           else if ( mode == slave_mode ) {
                vRF4463RxInit();
           }
           
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
                    {
                       if ( !nIRQ ) {          // !nIRQ
                          spi_read(9,0x22);  // aqui hay que leer  el RSSI
                          iVal = ( float ) spi_read_buf[3];
                          rssi = ((iVal / 2) - 64) -70;
                          vRF4463ClearInterrupts();
                          if ( ( spi_read_buf[ 4 ] & 0x08) == 0 ) { // crc error check
                             spi_read_fifo();
                             vRF4463FifoReset();
                             //getRSSI();
                             chksum = 0;
                             for ( i = 4; i < payload_length - 1; i++ )                // Calculation Checksum
                                 chksum += rx_buf[ i ];

                                   UART1_Write_Text("[ MENSAGGE ] = ");
                                    UART1_Write_Text( rx_buf );
                                    UART1_Write_Text("\r\n");
                                    LED_GREEN ^= 1;                                        // Data received
                                    rx_cnt++;
                                    getRSSI();

                                 vRF4463RxInit();    // The received data is wrong, you must continue to receive
                          }
                          else {
                               //UART1_Write_Text("[ CRC ] Fail\r\n");
                               UART1_Write_Text("[ CRC ] Fail\r\n" );
                               VRF4463SDNReset();
                               vRF4463Init();
                               vRF4463RxInit();
                          }
                       }
                    }
              }
           }
     }
}void getRSSI()
{
  ShortToStr(rssi,Value );
  UART1_Write_Text("[ RSSI ] = ");
  UART1_Write_Text( Value );
  UART1_Write_Text(" dBm\r\n");
}