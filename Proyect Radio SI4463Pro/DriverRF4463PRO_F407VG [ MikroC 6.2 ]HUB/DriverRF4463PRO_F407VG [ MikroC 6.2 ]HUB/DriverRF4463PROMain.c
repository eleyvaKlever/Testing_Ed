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

// COMANDOS para procesador de comandos
unsigned char CMD_RADIO_POWER_SET          [] = { "SET_POWER" };     // Probado verificado
unsigned char CMD_RADIO_BAND_SET           [] = { "SET_BAND" };      // Probado verificado
unsigned char CMD_RADIO_RATE_SET           [] = { "SET_RATE" };
unsigned char CMD_RADIO_CHANNEL_SET        [] = { "SET_CHANNEL" };   // Probado verificado
unsigned char CMD_RADIO_BW_SET             [] = { "SET_BW" };        // Probado verificado
unsigned char CMD_RADIO_NETWORK_SET        [] = { "SET_NETWORK" };
unsigned char CMD_RADIO_MODE_SET           [] = { "SET_MODE" };      // Probado verificado
unsigned char CMD_RADIO_PACKET_SEND        [] = { "SEND_PACKET" };
unsigned char CMD_RADIO_MATCH_BYTE_1_SET   [] = { "SET_MATCH_1" };   /// lo
unsigned char CMD_RADIO_MATCH_BYTE_2_SET   [] = { "SET_MATCH_2" };
unsigned char CMD_RADIO_MATCH_BYTE_3_SET   [] = { "SET_MATCH_3" };
unsigned char CMD_RADIO_MATCH_BYTE_4_SET   [] = { "SET_MATCH_4" };
unsigned char CMD_RADIO_MATCH_MASK_1_SET   [] = { "SET_MASK_1" };    // 0x0f
unsigned char CMD_RADIO_MATCH_MASK_2_SET   [] = { "SET_MASK_2" };
unsigned char CMD_RADIO_MATCH_MASK_3_SET   [] = { "SET_MASK_3" };
unsigned char CMD_RADIO_MATCH_MASK_4_SET   [] = { "SET_MASK_4" };
unsigned char CMD_RADIO_MATCH_UNSET        [] = { "UNSET_MATCH" };

// ARGUMENTOS string
data unsigned char ARG_RADIO_MODE_STBY            [] = {"STBY"};
data unsigned char ARG_RADIO_MODE_TX_CONT         [] = {"TX_CONT"};
data unsigned char ARG_RADIO_MODE_RX_CONT         [] = {"RX_CONT"};
data unsigned char ARG_RADIO_MODE_TX_MASTER       [] = {"TX_MASTER"};
data unsigned char ARG_RADIO_MODE_RX_SLAVE        [] = {"RX_SLAVE"};


// LEYENDAS para procesador de comandos
data unsigned char ANS_DEBUG_COMMAND_UNKNOWN      [] = {"[ COMMAND ] UNKNOWN: "};
data unsigned char ANS_COMMAND_VALUE_OUT_OF_RANGE [] = {"[ COMMAND ] VALUE OUT OF RANGE\r"};
data unsigned char ANS_COMMAND_VALUE_ACCEPTED     [] = {"[ COMMAND ] VALUE ACCEPTED AND APPLIED\r"};
data unsigned char ANS_COMMAND_MODE_STBY          [] = {"[ COMMAND ] MODE ACTIVE: STANDBY\r" };
data unsigned char ANS_COMMAND_MODE_TX_CONT       [] = {"[ COMMAND ] MODE ACTIVE: TX CONT\r" };
data unsigned char ANS_COMMAND_MODE_RX_CONT       [] = {"[ COMMAND ] MODE ACTIVE: RX CONT\r" };
data unsigned char ANS_COMMAND_MODE_TX_MASTER     [] = {"[ COMMAND ] MODE ACTIVE: TX MASTER\r" };
data unsigned char ANS_COMMAND_MODE_RX_SLAVE      [] = {"[ COMMAND ] MODE ACTIVE: RX SLAVE\r" };
data unsigned char ANS_COMMAND_MATCH_UNSET        [] = {"[ COMMAND ] MATCH UNSET\r" };

sfr sbit _REG_RADIO  at GPIOB_ODR.B9;         // Salida Radio

// ARCHIVOS INCLUIDOS
#include "STM32Defs.h"                  // definiciones de Hardware para micro especifico
#include "DriverSPI.c"
#include "ConfigRF4463PRO.h"            // configuracion para RF4463PRO
#include "DriverRF4463PROdefs.c"        // Definiciones para RF4463PRO
#include "DriverRF4463PRO.c"            // Libreria para RF4463PRO


// DEFINICIONES GENERALES
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


// Funcion para reinicializar el radio con el nuevo valor
void vRF4463MainApplyChanges () {
     VRF4463SDNReset();
     vRF4463Init();
     vRF4463ClearInterrupts();
}


void vRF4463MainSetTXString () {
     //ucRF4463TXdata[ 0 ] = ucRF4463ByteMatch1;
//     ucRF4463TXdata[ 1 ] = ucRF4463ByteMatch2;
//     ucRF4463TXdata[ 2 ] = ucRF4463ByteMatch3;
//     ucRF4463TXdata[ 3 ] = ucRF4463ByteMatch4;
}

//===========================================================================================================
// Procesador de comandos desde Buffers de USART
void vRF4463MainCommandProcessor ( unsigned char *ucBuffer ) {
     unsigned char ucCommand [ 32 ] = { 0x00 };
     unsigned long ulArgument = 0;
     unsigned char ucLongArgument[ 64 ] = { 0x00 };     // Espera argumentos de hasta 11 bytes
     unsigned char ucCounterBuffer = 0;
     unsigned char ucCounterCommand = 0;
     unsigned char ucCounterLongArgument = 0;
     
     // si se recibe un posible comando ASCII:
     if ( ucBuffer[ 0 ] > '@' && ucBuffer[ 0 ] <= 'z' ) {
        // localizar comandos y argumentos
        while ( ucBuffer[ ucCounterBuffer ] != '|' && ucCounterCommand < 32 ) {      // primer token
              ucCommand[ ucCounterCommand++ ] = toupper( ucBuffer[ ucCounterBuffer++ ] );
        }

        ucCounterBuffer++;                                                           // evita el Token

        while ( ucBuffer[ ucCounterBuffer ] != CHR_CR && ucCounterLongArgument < 64 ) {   // segundo token
              ucLongArgument[ ucCounterLongArgument ] = ucBuffer[ ucCounterBuffer ] ;   //  toupper(
              ucCounterBuffer++;
              ucCounterLongArgument++;
        }
     }
     
     //------------------------------------------------------------------------------------------------------
     // SET_POWER
     if ( memcmp( CMD_RADIO_POWER_SET, ucCommand, sizeof( CMD_RADIO_POWER_SET ) ) == 0x00 ) {
        ulArgument = StrToShort( ucLongArgument );
        // revisa por valor dentro de rango
        if ( ulArgument > 0 && ulArgument <= 127 ) {
           ucRF4463Power = ulArgument;
           vRF4463MainApplyChanges();
           vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
        }
        else {
             vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
        }
     }
     
     //------------------------------------------------------------------------------------------------------
     // SET_BAND
     else if ( memcmp( CMD_RADIO_BAND_SET, ucCommand, sizeof( CMD_RADIO_BAND_SET ) ) == 0x00 ) {
        ulArgument = StrToInt( ucLongArgument );
        // revisa por valor dentro de rango
        if ( ulArgument == 433 || ulArgument == 868 || ulArgument == 915 ) {
           ucRF4463Freq3 = ucLongArgument[ 0 ] - 48;
           ucRF4463Freq2 = ucLongArgument[ 1 ] - 48;
           ucRF4463Freq1 = ucLongArgument[ 2 ] - 48;
           vRF4463MainApplyChanges();
           vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
        }
        else {
             vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
        }
     }
     
     //------------------------------------------------------------------------------------------------------
     // SET_RATE
     else if ( memcmp( CMD_RADIO_RATE_SET, ucCommand, sizeof( CMD_RADIO_RATE_SET ) ) == 0x00 ) {
        ulArgument = StrToLong( ucLongArgument );
        // revisa por valor dentro de rango
        switch ( ulArgument ) {
               case 500      : ucRF4463Rate = dr_500;
                               vRF4463MainApplyChanges();
                               vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
                               break;
               case 1200     : ucRF4463Rate = dr_1p2;
                               vRF4463MainApplyChanges();
                               vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
                               break;
               case 2400     : ucRF4463Rate = dr_2p4;
                               vRF4463MainApplyChanges();
                               vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
                               break;
               case 4800     : ucRF4463Rate = dr_4p8;
                               vRF4463MainApplyChanges();
                               vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
                               break;
               case 9600     : ucRF4463Rate = dr_9p6;
                               vRF4463MainApplyChanges();
                               vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
                               break;
               case 19200    : ucRF4463Rate = dr_19p2;
                               vRF4463MainApplyChanges();
                               vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
                               break;
               case 38400    : ucRF4463Rate = dr_38p4;
                               vRF4463MainApplyChanges();
                               vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
                               break;
               case 76800    : ucRF4463Rate = dr_76p8;
                               vRF4463MainApplyChanges();
                               vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
                               break;
               case 115200   : ucRF4463Rate = dr_115p2;
                               vRF4463MainApplyChanges();
                               vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
                               break;
               case 256000   : ucRF4463Rate = dr_256k;
                               vRF4463MainApplyChanges();
                               vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
                               break;
               case 500000   : ucRF4463Rate = dr_500k;
                               vRF4463MainApplyChanges();
                               vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
                               break;
               default       : vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
        }
     }
     
     //------------------------------------------------------------------------------------------------------
     // SET_CHANNEL
     else if ( memcmp( CMD_RADIO_CHANNEL_SET, ucCommand, sizeof( CMD_RADIO_CHANNEL_SET ) ) == 0x00 ) {
        ulArgument = StrToInt( ucLongArgument );
        // revisa por valor dentro de rango
        if ( ulArgument >= 0 && ulArgument <= 50 ) {
           ucRF4463FreqChannel = ulArgument;    // Se aplica al ejecutar funciones de TX o RX
           vRF4463MainApplyChanges();
           vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
        }
        else {
             vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
        }
     }
     
     //------------------------------------------------------------------------------------------------------
     // SET_BW
     else if ( memcmp( CMD_RADIO_BW_SET, ucCommand, sizeof( CMD_RADIO_BW_SET ) ) == 0x00 ) {
        ulArgument = StrToInt( ucLongArgument );
        // revisa por valor dentro de rango
        if ( ulArgument == 250 || ulArgument == 500 ) {
           ulRF4463Step = ulArgument;
           vRF4463MainApplyChanges();
           vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
        }
        else {
             vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
        }
     }
     
     
     
     
     //------------------------------------------------------------------------------------------------------
     // SET_MODE
     else if ( memcmp( CMD_RADIO_MODE_SET, ucCommand, sizeof( CMD_RADIO_MODE_SET ) ) == 0x00 ) {
        // Lo hace estándar
        ucCounterCommand = 0;
        
        while ( ucLongArgument[ ucCounterCommand ] != ucUSARTNull && ucCounterCommand < 32 ) {
              ucLongArgument[ ucCounterCommand ] = toupper( ucLongArgument[ ucCounterCommand ] );
              ucCounterCommand++;
        }
        
        // Lo analiza
        if ( memcmp( ARG_RADIO_MODE_STBY, ucLongArgument, sizeof( ARG_RADIO_MODE_STBY ) ) == 0x00 ) {
           ucRF4463Mode = rf_off;
           vUSART1Start_TX( ANS_COMMAND_MODE_STBY, strlen( ANS_COMMAND_MODE_STBY ) );
        }
        else if ( memcmp( ARG_RADIO_MODE_TX_CONT, ucLongArgument, sizeof( ARG_RADIO_MODE_TX_CONT ) ) == 0x00 ) {
           ucRF4463Mode = tx_test_mode;
           vRF4463MainApplyChanges();
           vUSART1Start_TX( ANS_COMMAND_MODE_TX_CONT, strlen( ANS_COMMAND_MODE_TX_CONT ) );
        }
        else if ( memcmp( ARG_RADIO_MODE_RX_CONT, ucLongArgument, sizeof( ARG_RADIO_MODE_RX_CONT ) ) == 0x00 ) {
           ucRF4463Mode = rx_test_mode;
           vUSART1Start_TX( ANS_COMMAND_MODE_RX_CONT, strlen( ANS_COMMAND_MODE_RX_CONT ) );
        }
        else if ( memcmp( ARG_RADIO_MODE_TX_MASTER, ucLongArgument, sizeof( ARG_RADIO_MODE_TX_MASTER ) ) == 0x00 ) {
           ucRF4463Mode = master_mode;
           vUSART1Start_TX( ANS_COMMAND_MODE_TX_MASTER, strlen( ANS_COMMAND_MODE_TX_MASTER ) );
        }
        else if ( memcmp( ARG_RADIO_MODE_RX_SLAVE, ucLongArgument, sizeof( ARG_RADIO_MODE_RX_SLAVE ) ) == 0x00 ) {
           ucRF4463Mode = slave_mode;
           vUSART1Start_TX( ANS_COMMAND_MODE_RX_SLAVE, strlen( ANS_COMMAND_MODE_RX_SLAVE ) );
        }
        else {
             vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
        }
     }
     
     
     //------------------------------------------------------------------------------------------------------
     // SEND_PACKET
     else if ( memcmp( CMD_RADIO_PACKET_SEND, ucCommand, sizeof( CMD_RADIO_PACKET_SEND ) ) == 0x00 ) {
        //if (  ) {
//        }
        
        ulArgument = StrToLong( ucLongArgument );
        //else {
             vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
        //}
     }
     
     
     //------------------------------------------------------------------------------------------------------
     // SET_MATCH_1
     else if ( memcmp( CMD_RADIO_MATCH_BYTE_1_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_1_SET ) ) == 0x00 ) {
        ulArgument = StrToLong( ucLongArgument );
        if ( ulArgument >= 0 && ulArgument <= 255 ) {
           ucRF4463ByteMatch1 = ulArgument;
           ucRF4463MatchEnabled = 1;
           ucRF4463MatchEnableReg = 0x40;
           vRF4463MainApplyChanges();
           vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
        }
        else {
             vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
        }
     }
     
     //------------------------------------------------------------------------------------------------------
     // SET_MATCH_2
     else if ( memcmp( CMD_RADIO_MATCH_BYTE_2_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_2_SET ) ) == 0x00 ) {
        ulArgument = StrToLong( ucLongArgument );
        if ( ulArgument >= 0 && ulArgument <= 255 ) {
           ucRF4463ByteMatch2 = ulArgument;
           ucRF4463MatchEnabled = 1;
           ucRF4463MatchEnableReg = 0x40;
           vRF4463MainApplyChanges();
           vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
        }
        else {
             vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
        }
     }
     
     //------------------------------------------------------------------------------------------------------
     // SET_MATCH_3
     else if ( memcmp( CMD_RADIO_MATCH_BYTE_3_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_3_SET ) ) == 0x00 ) {
        ulArgument = StrToLong( ucLongArgument );
        if ( ulArgument >= 0 && ulArgument <= 255 ) {
           ucRF4463ByteMatch3 = ulArgument;
           ucRF4463MatchEnabled = 1;
           ucRF4463MatchEnableReg = 0x40;
           vRF4463MainApplyChanges();
           vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
        }
        else {
             vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
        }
     }
     
     //------------------------------------------------------------------------------------------------------
     // SET_MATCH_4
     else if ( memcmp( CMD_RADIO_MATCH_BYTE_4_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_4_SET ) ) == 0x00 ) {
        ulArgument = StrToLong( ucLongArgument );
        if ( ulArgument >= 0 && ulArgument <= 255 ) {
           ucRF4463ByteMatch4 = ulArgument;
           ucRF4463MatchEnabled = 1;
           ucRF4463MatchEnableReg = 0x40;
           vRF4463MainApplyChanges();
           vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
        }
        else {
             vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
        }
     }
     
     //------------------------------------------------------------------------------------------------------
     // SET_MASK_1
     else if ( memcmp( CMD_RADIO_MATCH_MASK_1_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_1_SET ) ) == 0x00 ) {
        ulArgument = StrToLong( ucLongArgument );
        if ( ulArgument >= 0 && ulArgument <= 255 ) {
           ucRF4463ByteMask1 = ulArgument;
           ucRF4463MatchEnabled = 1;
           vRF4463MainApplyChanges();
           vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
        }
        else {
             vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
        }
     }

     //------------------------------------------------------------------------------------------------------
     // SET_MASK_2
     else if ( memcmp( CMD_RADIO_MATCH_MASK_2_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_2_SET ) ) == 0x00 ) {
        ulArgument = StrToLong( ucLongArgument );
        if ( ulArgument >= 0 && ulArgument <= 255 ) {
           ucRF4463ByteMask2 = ulArgument;
           ucRF4463MatchEnabled = 1;
           vRF4463MainApplyChanges();
           vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
        }
        else {
             vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
        }
     }

     //------------------------------------------------------------------------------------------------------
     // SET_MASK_3
     else if ( memcmp( CMD_RADIO_MATCH_MASK_3_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_3_SET ) ) == 0x00 ) {
        ulArgument = StrToLong( ucLongArgument );
        if ( ulArgument >= 0 && ulArgument <= 255 ) {
           ucRF4463ByteMask3 = ulArgument;
           ucRF4463MatchEnabled = 1;
           vRF4463MainApplyChanges();
           vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
        }
        else {
             vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
        }
     }

     //------------------------------------------------------------------------------------------------------
     // SET_MASK_4
     else if ( memcmp( CMD_RADIO_MATCH_MASK_4_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_4_SET ) ) == 0x00 ) {
        ulArgument = StrToLong( ucLongArgument );
        if ( ulArgument >= 0 && ulArgument <= 255 ) {
           ucRF4463ByteMask4 = ulArgument;
           ucRF4463MatchEnabled = 1;
           vRF4463MainApplyChanges();
           vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
        }
        else {
             vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
        }
     }
     
     //------------------------------------------------------------------------------------------------------
     // UNSET_MATCH
     else if ( memcmp( CMD_RADIO_MATCH_UNSET, ucCommand, sizeof( CMD_RADIO_MATCH_UNSET ) ) == 0x00 ) {
        //if ( ulArgument >= 0 && ulArgument <= 255 ) {
           ucRF4463MatchEnableReg = 1;
           vRF4463MainApplyChanges();
           vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
        //}
        //else {
        //     vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
        //}
     }
     
     // si no coincide con ninguno...
     else {
          vUSART1Start_TX( ANS_DEBUG_COMMAND_UNKNOWN, strlen( ANS_DEBUG_COMMAND_UNKNOWN ) );
          vUSART1Start_TX( ucBuffer, strlen( ucBuffer ) );  // DEPURACION
     }
}



//Timer2 Prescaler :1124; Preload = 63999; Actual Interrupt Time = 1
//Place/Copy this part in declaration section
void InitTimer2(){

RCC_APB1ENR.TIM2EN = 1;
TIM2_CR1.CEN = 0;
TIM2_PSC = 1499;
TIM2_ARR = 63839;
NVIC_IntEnable( IVT_INT_TIM2 );
TIM2_DIER.UIE = 1;
TIM2_CR1.CEN = 1;
}



void main() {
     
     unsigned char  i, j, chksum;
     
     Delay_ms( 2000 );                    // delay de depuracion
     
    // Basic Init
    // LEDS
    GPIO_Digital_Output( &GPIOE_BASE, _GPIO_PINMASK_9 );
    GPIO_Digital_Output( &GPIOE_BASE, _GPIO_PINMASK_11 );
    GPIO_Digital_Output( &GPIOE_BASE, _GPIO_PINMASK_13 );

    /*********************************************************************
    * RF4463Pro I/O Setup ( MikroBUS 1 )
    *********************************************************************/
      //GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_6 );    // GPIO 0
      //GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_7 );    // GPIO 1

      GPIO_Digital_Input( &GPIOD_BASE, _GPIO_PINMASK_0 );     // nIRQ (Interrupt Request Pin)
      GPIO_Digital_Output( &GPIOD_BASE, _GPIO_PINMASK_1 );    // SDN  ()
      GPIO_Digital_Output( &GPIOD_BASE, _GPIO_PINMASK_2 );    // nSEL (Chip Select)

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

    RCC_APB2ENRbits.SYSCFGEN = 1; //Clock Enable
    SYSCFG_EXTICR1  |= 0x0003;    //Pin Configuration
    EXTI_IMR.B0     |= 1;         //Interruption Edge Flag
    EXTI_FTSR.B0    |= 1;
    
    nSEL = 1;
     
     LED_RED      = 0;
     LED_GREEN    = 0;
     LED_BLUE     = 0;
     
     Delay_ms( 100 );
     
     LED_RED      = 1;
     LED_GREEN    = 0;
     LED_BLUE     = 0;
     Delay_ms(300);
     InitTimer2();
     
     // Init driver ( MCU Specific )
     //UART1_Init_Advanced( 115200, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PB67 );
     vUSARTConfigUSART1( 115200 );  // configura todos las parametros de USART
     //vUARTRxInit();
     UART1_Write_Text("[ SYS STM32F407VC ] Start System\r\n");
     LED_RED      = 0;
     LED_GREEN    = 0;
     LED_BLUE     = 1;
     vSPI1Init();           // configura todos los parametros de SPI

     // ESTABLECE PARAMETROS DEFAULT POR COMPILACION---------------------------------------------------------
     
     // FRECUENCIA BASE PREDETERMINADA ( 0 A 9 )
     ucRF4463Freq3 = 9;
     ucRF4463Freq2 = 1;
     ucRF4463Freq1 = 5;
     
     // POTENCIA DE TRANSMISION ( rangos de 0 a 127 )
     ucRF4463Power = 127;            // 34
     
     ucRF4463Rate  = dr_1p2;                // BAUDRATE
     
     ucRF4463Mode  = master_mode;          // para transmision continua usar: tx_test_mode
     
     ucRF4463FreqChannel = 1;
     
     // ESTABLECE PARAMETROS DEFAULT POR COMPILACION---------------------------------------------------------
     
     reset_mode = 0;
     
     
     
     // Init Device
     vRF4463MainSetTXString();    // usada para establecer el encabezdo predeterminado
     VRF4463SDNReset();
     vRF4463Init();
     vRF4463ClearInterrupts();
     vRF4463PartInfo ();          // SOLICITA EL MODELO DEL RADIO
     
     LED_GREEN    = 0;
     LED_BLUE     = 0;
     
     //UART1_Write_Text( "RF Radio ready" );

     UART1_Write_Text( "[ SYS STM32F407VC ] RF Radio ready\r\n" );
 
     
     while ( 1 ) {
     
           // ESPERA INTERRUPCION POR USART
           if ( fUSART1Buffer == READY_TO_READ ) {
              vUSARTReceivedFromUSART1();
           }
     
           // Espera comando para realizar cierta accion
           //if ( ucRF4463IRQ ) {
//              ucRF4463IRQ = 0;       // limpia bandera
//              spi_read_fifo();       // Read RX FIFO
//              vRF4463FifoReset();    // FIFO RESET
//              UART1_Write_Text( spi_read_buf );
//           }

           // MODO MAESTRO
           if ( ucRF4463Mode == master_mode ) {
              vRF4463TxData();
           }
           
           // MODO ESCLAVO
           else if ( ucRF4463Mode == slave_mode ) {
                vRF4463RxInit();
           }
           
           // MODO STANDBY
           else if ( ucRF4463Mode == rf_off ) {
                vRF4463RxInit();
           }
           
           // MODO DE TRANSMISION CONTINUA
           if ( ucRF4463Mode == tx_test_mode ) {
              vRF4463TxCont();
              while ( 1 ) {
                    // habilita salida de loop infinito de modo continuo si recibe comando de configuracion
                    if ( fUSART1Buffer == READY_TO_READ ) {
                       break;
                    }
                    
                    if ( !nIRQ ) {
                       vRF4463TxCont();
                    }
              }
           }
           
           if ( ucRF4463Mode == rx_test_mode ) {
              vRF4463RxInit ();
              while ( 1 ) {
                    // habilita salida de loop infinito de modo continuo si recibe comando de configuracion
                    if ( fUSART1Buffer == READY_TO_READ ) {
                       break;
                    }
                    
                    //spi_read_fifo();           // Lee ceros
              }
           }
           
           if ( reset_mode == 0 ) {
              
              while ( 1 ) {
                    // habilita salida de loop infinito de modo continuo si recibe comando de configuracion
                    if ( fUSART1Buffer == READY_TO_READ ) {
                       break;
                    }
                    
                    if ( Flag.reach_1s ) {
                       Flag.reach_1s = 0;
                       if ( ucRF4463Mode == master_mode ) {
                          vRF4463TxData();
                       }
                    }
                    
                    // recibiendo optimo !!
                    if ( !Flag.is_tx ) {
                       if ( !nIRQ ) {          // !nIRQ
                          vRF4463ClearInterrupts();
                          
                          if ( ( spi_read_buf[ 4 ] & 0x08) == 0 ) { // crc error check
                          
                             //spi_read( 9, 0x22 );
                          
                             spi_read_fifo();
                             vRF4463FifoReset();
                          
                             chksum = 0;
                             for ( i = 4; i < payload_length - 1; i++ )                // Calculation Checksum
                                 chksum += rx_buf[ i ];

                             if ( ( chksum == rx_buf[ payload_length - 1 ] )&&( rx_buf[ 4 ] == 0x41 )) {
                             
                                //UART1_Write_Text( rx_buf );
                                //UART1_Write_Text("\r\n");
                                
                                UART1_Write_Text( rx_buf );
                                UART1_Write_Text("\r\n");
                              
                                //LED_GREEN ^= 1;                                        // Data received
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