#line 1 "D:/Kleverness/Code/Mikro C/Test/Test_TestJigv2_RF+UART/main.c"
#line 1 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/main.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/include/stdint.h"





typedef signed char int8_t;
typedef signed int int16_t;
typedef signed long int int32_t;
typedef signed long long int64_t;


typedef unsigned char uint8_t;
typedef unsigned int uint16_t;
typedef unsigned long int uint32_t;
typedef unsigned long long uint64_t;


typedef signed char int_least8_t;
typedef signed int int_least16_t;
typedef signed long int int_least32_t;
typedef signed long long int_least64_t;


typedef unsigned char uint_least8_t;
typedef unsigned int uint_least16_t;
typedef unsigned long int uint_least32_t;
typedef unsigned long long uint_least64_t;



typedef signed long int int_fast8_t;
typedef signed long int int_fast16_t;
typedef signed long int int_fast32_t;
typedef signed long long int_fast64_t;


typedef unsigned long int uint_fast8_t;
typedef unsigned long int uint_fast16_t;
typedef unsigned long int uint_fast32_t;
typedef unsigned long long uint_fast64_t;


typedef signed long int intptr_t;
typedef unsigned long int uintptr_t;


typedef signed long long intmax_t;
typedef unsigned long long uintmax_t;
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/include/stdio.h"
#line 1 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/sysdefinitions.h"
#line 1 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/main.h"
#line 25 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/sysdefinitions.h"
typedef struct{
 uint8_t Major;
 uint8_t Minor;
 uint8_t Build;
} FirmwareVersion_t;
#line 1 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/utils.h"
#line 1 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/main.h"
#line 49 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/utils.h"
uint8_t ucASCIIToByte( uint8_t * pcASCIIBuffer );
#line 61 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/utils.h"
void vASCIIToHex( uint8_t *pcHexConvertBuffer, uint8_t *pcASCIIConvertBuffer, uint8_t ucConversionLength );
#line 73 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/utils.h"
void vHexToASCII( uint8_t *pcASCIIConvertBuffer, uint8_t *pcHexConvertBuffer, uint8_t ucConversionLength );
#line 85 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/utils.h"
void vBufferSetToZero( uint8_t * pcBufferToClean, uint16_t uslength );
#line 97 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/utils.h"
void vBufferSetTo255( uint8_t * pcBufferToClean, uint16_t uslength );
#line 109 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/utils.h"
void vBufferSetToValue( uint8_t * pcBufferToClean, uint8_t ucValue, uint16_t uslength );
#line 1 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/debug.h"
#line 1 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/main.h"
#line 1 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.h"
#line 1 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/main.h"
#line 1 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.h"
#line 1 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/main.h"
#line 1 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
#line 1 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/main.h"
#line 1 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.h"
#line 1 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463commands.h"
#line 1 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463config_2400.h"
#line 1 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/si446x_patch.h"
#line 1 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463spi.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/include/stdint.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/include/stdbool.h"



 typedef char _Bool;
#line 41 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463spi.h"
void vRf4463SPIWriteBuffer( uint16_t usWriteLength, uint8_t * pcWriteBuffer );

void vRf4463SPIReadBuffer( uint16_t usReadLength, uint8_t * pcReadBuffer );

uint8_t ucRf4463SPIByte( uint8_t pcWriteData );
#line 85 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
void vRf4463Init( uint8_t ucSetTxChannel, uint8_t ucSetRxChannel, uint16_t usNetwork, uint8_t ucTxPower );
#line 97 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
void vRf4463PowerOnReset();
#line 109 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
void vRf4463SetChannels( uint8_t ucSetRxChannel, uint8_t ucSetTxChannel );
#line 121 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
void vRf4463SetNetwork( uint16_t usNetwork );
#line 137 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
void vRf4463SetConfiguration( const uint8_t * pcParameters, uint16_t usParametersLength );
#line 152 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
uint8_t ucRf4463SetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer );
#line 167 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
uint8_t ucRf4463GetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer );
#line 182 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
uint8_t ucRf4463SetProperty( uint16_t ucStartProperty, uint8_t ucLength, uint8_t * pcParametersBuffer );
#line 197 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
uint8_t ucRf4463GetProperty( uint16_t ucStartProperty, uint8_t ucLength, uint8_t * pcParametersBuffer );
#line 210 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
uint8_t ucRf4463SetSyncWords( uint8_t * pcSyncWords, uint8_t ucLength );
#line 223 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
uint8_t ucRf4463SetPreambleLength( uint8_t ucLength );
#line 241 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
uint8_t ucRf4463CheckCTS();
#line 257 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
void vRf4463RSSI();
#line 269 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
int16_t intRF4463GetLastRSSI();
#line 283 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
uint8_t ucRf4463DeviceAvailability();
#line 299 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
uint8_t ucRf4463SetGPIOMode( uint8_t ucGPIO0Mode, uint8_t GPIO1Mode );
#line 311 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
void vRf4463FIFOReset();
#line 325 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
uint8_t ucRf4463ClearInterrupts();
#line 338 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
uint8_t ucRf4463EnterStandbyMode();
#line 353 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
void vRf4463EnterTxMode();
#line 366 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
uint8_t ucRf4463SetTxInterrupt();
#line 379 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
uint8_t ucRf4463SetTxPower( uint8_t ucPower );
#line 392 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
void vRf4463WriteTxFIFO( uint8_t * pcWriteBuffer, uint8_t ucLength );
#line 409 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
uint8_t ucRf4463TxPacket( uint8_t * pcSendBuffer, uint8_t ucSendLength );
#line 425 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
uint8_t ucRf4463TxPacket_Seq( uint8_t * pcTxBuffer, uint8_t ucTxLength );
#line 440 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
void vRf4463EnterRxMode();
#line 453 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
uint8_t ucRf4463SetRxInterrupt();
#line 466 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
uint8_t ucRf4463RxInit();
#line 479 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
uint8_t ucRf4463RxPacket( uint8_t * pcRxBuffer );
#line 493 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
void vRf4463ReadRxFIFO( uint8_t * pcBuffer );
#line 1 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463spi.h"
#line 50 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.h"
typedef struct{
 uint8_t Node;
 uint8_t Channel;
 uint8_t BaudRate;
 uint8_t TxPower;
 uint16_t Network;
} RadioParameters_t;
#line 74 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.h"
void vRF4463MesageHandler();
#line 86 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.h"
void vRF4463TxMessage( uint8_t * pcOutBuffer, uint8_t ucLength, uint8_t ucRemoteNode );
#line 98 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.h"
uint8_t ucRF4463Setup( uint8_t ucRxChannel, uint8_t ucTxChannel, uint16_t usNetwork, uint8_t ucTxPower );
#line 113 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.h"
uint8_t ucRF4463GetIRQFlag();
#line 125 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.h"
void vRF4463ResetIRQFlag();
#line 53 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.h"
void vUART1MessageHandler();
#line 65 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.h"
void vUARTTxInit();
#line 77 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.h"
void vUARTRxInit();
#line 89 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.h"
void vUART1_Init_Advanced ( unsigned long ulBaudRate, unsigned int uiDataBits , unsigned int uiParity, unsigned int uiStopBits, unsigned char ucTerminalMap );
#line 101 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.h"
void vUART1_Write( unsigned char pcByte );
#line 113 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.h"
void vUART1_Write_Text( unsigned char *pcBuffer );
#line 128 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.h"
uint8_t ucUART1MessageReady();
#line 140 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.h"
void vUART1ResetIRQFlag();
#line 152 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.h"
void vUART1ResetRxBuffer();
#line 64 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/debug.h"
 void vDebugPrint( uint8_t ucPrintData );
#line 1 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/debug.c"
#line 1 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/debug.h"
#line 71 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/debug.c"
 void vDebugPrint( uint8_t ucPrintData ){
 vUART1_Write( ucPrintData );
 }
#line 1 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.c"
#line 1 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.h"
#line 25 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.c"
static uint8_t ucRF4463IRQ = 0;

uint8_t ucRFTxEventPending = 0;
uint8_t ucRf4463IRQEvent = 0;

uint8_t pcRF4463TxBuffer[  64  ] = { 0x00 };
uint8_t pcRF4463RxBuffer[  64  ] = { 0x00 };
#line 46 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.c"
void vISR_EXTI0_Callback() iv IVT_INT_EXTI0 ics ICS_AUTO{
 if( EXTI_PR.B0 == 1 ){

 EXTI_PR.B0 = 1;
 ucRf4463ClearInterrupts();
 ucRF4463IRQ = 1;
 }
}
#line 61 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.c"
void vRF4463MesageHandler(){
 uint8_t usRxCounter = 0;

 if( ucRFTxEventPending == 0 ){

 ucRf4463RxPacket( pcRF4463RxBuffer );
 if( pcRF4463RxBuffer[  0  ] > 0 ){

 vUART1_Write_Text( "[ RF4463 Rx ] Packet: " );
 for( usRxCounter = 0; usRxCounter < pcRF4463RxBuffer[ 0 ]; usRxCounter++ ){
 vUART1_Write( pcRF4463RxBuffer[ usRxCounter ] );
 }
 vUART1_Write( '\r' );
 vUART1_Write( '\n' );

 }
 }
 else{

 ucRFTxEventPending = 0;
 }

 ucRf4463RxInit();
}
#line 89 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.c"
void vRF4463TxMessage( uint8_t * pcOutBuffer, uint8_t ucLength, uint8_t ucRemoteNode ){
 uint8_t ucCounter = 0;
 uint8_t pcTemp[ 7 ];
#line 95 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.c"
 if( ucRFTxEventPending == 1 ){
  PrintOut( vDebugPrint , "[ RF4463 ] HW in use\r\n", ( ( void * )0 )  ) ;
 return;
 }
#line 103 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.c"
 vBufferSetToZero( pcRF4463TxBuffer,  64  );
#line 107 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.c"
 if( ( ucLength +  3  ) >=  64  ){
  PrintOut( vDebugPrint , "[ RF4463 ] Buffer Out of Size\r\n", ( ( void * )0 )  ) ;
 return;
 }
#line 114 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.c"
 pcRF4463TxBuffer[  0  ] =  3  + ucLength;
 pcRF4463TxBuffer[  1  ] = ucRemoteNode;
 pcRF4463TxBuffer[  2  ] =  1 ;
#line 120 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.c"
 if( ucLength > 0 ){
 for( ucCounter = 0; ucCounter < ucLength; ucCounter++ ){
 pcRF4463TxBuffer[  3  + ucCounter ] = pcOutBuffer[ ucCounter ];
 }
 }
#line 129 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.c"
 vUART1_Write_Text( "[ RF4463 Tx ] Packet: " );
 for( ucCounter = 0; ucCounter < pcRF4463TxBuffer[  0  ]; ucCounter++ ){
 vUART1_Write( pcRF4463TxBuffer[ ucCounter ] );
 }
 vUART1_Write( '\r' );
 vUART1_Write( '\n' );
#line 139 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.c"
 ucRf4463TxPacket( pcRF4463TxBuffer, pcRF4463TxBuffer[  0  ] );
 ucRFTxEventPending = 1;
}
#line 146 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.c"
uint8_t ucRF4463Setup( uint8_t ucRxChannel, uint8_t ucTxChannel, uint16_t usNetwork, uint8_t ucTxPower ){
 uint8_t ucRetries = 0;
 uint8_t ucIsRFAvailable =  1 ;
#line 152 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.c"
 SPI1_Init_Advanced( _SPI_FPCLK_DIV8, _SPI_MASTER | _SPI_8_BIT | _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION |
 _SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI1_PB345 );
#line 157 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.c"
 GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_8 );
 GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_9 );
 GPIO_Digital_Output( &GPIOD_BASE, _GPIO_PINMASK_1 );
 GPIO_Digital_Output( &GPIOD_BASE, _GPIO_PINMASK_2 );

 GPIO_Digital_Input( &GPIOD_BASE, _GPIO_PINMASK_0 );
#line 169 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.c"
 RCC_APB2ENRbits.SYSCFGEN = 1;
#line 173 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.c"
 SYSCFG_EXTICR1 |= 0x0003;
#line 177 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.c"
 EXTI_IMR.B0 |= 1;
 EXTI_FTSR.B0 |= 1;
#line 182 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.c"
  PrintOut( vDebugPrint , "[ RF4463 ] Tx Channel: %d\r\n", ucTxChannel ) ;
  PrintOut( vDebugPrint , "[ RF4463 ] Rx Channel: %d\r\n", ucRxChannel ) ;
  PrintOut( vDebugPrint , "[ RF4463 ] Network: %d\r\n", usNetwork ) ;
  PrintOut( vDebugPrint , "[ RF4463 ] Tx Power: %d\r\n", ucTxPower ) ;
 vRf4463Init( ucRxChannel, ucTxChannel, usNetwork, ucTxPower );
#line 191 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.c"
 for( ucRetries = 0; ucRetries < 15; ucRetries++ ){
 if( ucRf4463DeviceAvailability() ==  0  ){
  PrintOut( vDebugPrint , "[ RF4663 ] Setup Try: %d Success\r\n", ucRetries ) ;
 break;
 }
 else{
  PrintOut( vDebugPrint , "[ RF4463 ] Setup Try %d Failed\r\n", ucRetries ) ;
 Delay_ms( 50 );
 }
 }
#line 204 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.c"
 if( ucRetries == 15 ){
  PrintOut( vDebugPrint , "[ RF4463 ] Setup Retries Excedded\r\n", ( ( void * )0 )  ) ;
 return  1 ;
 }
#line 211 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.c"
 while( ucIsRFAvailable ){
 ucIsRFAvailable = ucRf4463EnterStandbyMode();
 }
#line 217 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.c"
 NVIC_IntEnable( IVT_INT_EXTI0 );
 ucRf4463ClearInterrupts();
 ucRf4463RxInit();
  PrintOut( vDebugPrint , "[ RF4463 ] Ready\r\n", ( ( void * )0 )  ) ;
 return  0 ;
}
#line 230 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.c"
uint8_t ucRF4463GetIRQFlag(){
 return ucRF4463IRQ;
}
#line 237 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463handler.c"
void vRF4463ResetIRQFlag(){
 ucRF4463IRQ = 0;
}
#line 1 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
#line 1 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.h"
#line 27 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
const uint8_t RF4463_CONFIGURATION_DATA[] =  { 0x08,0x04,0x21,0x71,0x4B,0x00,0x00,0xDC,0x95, 0x08,0x05,0xA6,0x22,0x21,0xF0,0x41,0x5B,0x26, 0x08,0xE2,0x2F,0x1C,0xBB,0x0A,0xA8,0x94,0x28, 0x08,0x05,0x87,0x67,0xE2,0x58,0x1A,0x07,0x5B, 0x08,0xE1,0xD0,0x72,0xD8,0x8A,0xB8,0x5B,0x7D, 0x08,0x05,0x11,0xEC,0x9E,0x28,0x23,0x1B,0x6D, 0x08,0xE2,0x4F,0x8A,0xB2,0xA9,0x29,0x14,0x13, 0x08,0x05,0xD1,0x2E,0x71,0x6A,0x51,0x4C,0x2C, 0x08,0xE5,0x80,0x27,0x42,0xA4,0x69,0xB0,0x7F, 0x08,0x05,0xAA,0x81,0x2A,0xBD,0x45,0xE8,0xA8, 0x08,0xEA,0xE4,0xF0,0x24,0xC9,0x9F,0xCC,0x3C, 0x08,0x05,0x08,0xF5,0x05,0x04,0x27,0x62,0x98, 0x08,0xEA,0x6B,0x62,0x84,0xA1,0xF9,0x4A,0xE2, 0x08,0x05,0xE9,0x77,0x05,0x4F,0x84,0xEE,0x35, 0x08,0xE2,0x43,0xC3,0x8D,0xFB,0xAD,0x54,0x25, 0x08,0x05,0x14,0x06,0x5E,0x39,0x36,0x2F,0x45, 0x08,0xEA,0x0C,0x1C,0x74,0xD0,0x11,0xFC,0x32, 0x08,0x05,0xDA,0x38,0xBA,0x0E,0x3C,0xE7,0x8B, 0x08,0xEA,0xB0,0x09,0xE6,0xFF,0x94,0xBB,0xA9, 0x08,0x05,0xD7,0x11,0x29,0xFE,0xDC,0x71,0xD5, 0x08,0xEA,0x7F,0x83,0xA7,0x60,0x90,0x62,0x18, 0x08,0x05,0x84,0x7F,0x6A,0xD1,0x91,0xC6,0x52, 0x08,0xEA,0x2A,0xD8,0x7B,0x8E,0x4A,0x9F,0x91, 0x08,0x05,0xBD,0xAA,0x9D,0x16,0x18,0x06,0x15, 0x08,0xE2,0x55,0xAD,0x2D,0x0A,0x14,0x1F,0x5D, 0x08,0x05,0xD3,0xE0,0x7C,0x39,0xCF,0x01,0xF0, 0x08,0xEF,0x3A,0x91,0x72,0x6A,0x03,0xBB,0x96, 0x08,0xE7,0x83,0x6D,0xA4,0x92,0xFC,0x13,0xA7, 0x08,0xEF,0xF8,0xFD,0xCF,0x62,0x07,0x6F,0x1E, 0x08,0xE7,0x4C,0xEA,0x4A,0x75,0x4F,0xD6,0xCF, 0x08,0xE2,0xF6,0x11,0xE4,0x26,0x0D,0x4D,0xC6, 0x08,0x05,0xFB,0xBF,0xE8,0x07,0x89,0xC3,0x51, 0x08,0xEF,0x82,0x27,0x04,0x3F,0x96,0xA8,0x58, 0x08,0xE7,0x41,0x29,0x3C,0x75,0x2A,0x03,0x1C, 0x08,0xEF,0xAF,0x59,0x98,0x36,0xAA,0x0F,0x06, 0x08,0xE6,0xF6,0x93,0x41,0x2D,0xEC,0x0E,0x99, 0x08,0x05,0x29,0x19,0x90,0xE5,0xAA,0x36,0x40, 0x08,0xE7,0xFB,0x68,0x10,0x7D,0x77,0x5D,0xC0, 0x08,0xE7,0xCB,0xB4,0xDD,0xCE,0x90,0x54,0xBE, 0x08,0xE7,0x72,0x8A,0xD6,0x02,0xF4,0xDD,0xCC, 0x08,0xE7,0x6A,0x21,0x0B,0x02,0x86,0xEC,0x15, 0x08,0xE7,0x7B,0x7C,0x3D,0x6B,0x81,0x03,0xD0, 0x08,0xEF,0x7D,0x61,0x36,0x94,0x7C,0xA0,0xDF, 0x08,0xEF,0xCC,0x85,0x3B,0xDA,0xE0,0x5C,0x1C, 0x08,0xE7,0xE3,0x75,0xBB,0x39,0x22,0x4B,0xA8, 0x08,0xEF,0xF9,0xCE,0xE0,0x5E,0xEB,0x1D,0xCB, 0x08,0xE7,0xBD,0xE2,0x70,0xD5,0xAB,0x4E,0x3F, 0x08,0xE7,0xB7,0x8D,0x20,0x68,0x6B,0x09,0x52, 0x08,0xEF,0xA1,0x1B,0x90,0xCD,0x98,0x00,0x63, 0x08,0xEF,0x54,0x67,0x5D,0x9C,0x11,0xFC,0x45, 0x08,0xE7,0xD4,0x9B,0xC8,0x97,0xBE,0x8A,0x07, 0x08,0xEF,0x52,0x8D,0x90,0x63,0x73,0xD5,0x2A, 0x08,0xEF,0x03,0xBC,0x6E,0x1C,0x76,0xBE,0x4A, 0x08,0xE7,0xC2,0xED,0x67,0xBA,0x5E,0x66,0x21, 0x08,0xEF,0xE7,0x3F,0x87,0xBE,0xE0,0x7A,0x6D, 0x08,0xE7,0xC9,0x70,0x93,0x1D,0x64,0xF5,0x6C, 0x08,0xEF,0xF5,0x28,0x08,0x34,0xB3,0xB6,0x2C, 0x08,0xEF,0x3A,0x0A,0xEC,0x0F,0xDB,0x56,0xCA, 0x08,0xEF,0x39,0xA0,0x6E,0xED,0x79,0xD0,0x24, 0x08,0xE7,0x6C,0x0B,0xAF,0xA9,0x4E,0x40,0xB5, 0x08,0xE9,0xB9,0xAF,0xBF,0x25,0x50,0xD1,0x37, 0x08,0x05,0x9E,0xDB,0xDE,0x3F,0x94,0xE9,0x6B, 0x08,0xEC,0xC5,0x05,0xAA,0x57,0xDC,0x8A,0x5E, 0x08,0x05,0x70,0xDA,0x84,0x84,0xDD,0xCA,0x90 , 0x07, 0x02, 0x01, 0x00, 0x01, 0xC9, 0xC3, 0x80 , 0x08, 0x13, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 , 0x06, 0x11, 0x00, 0x02, 0x00, 0x52, 0x00 , 0x05, 0x11, 0x00, 0x01, 0x03, 0x20 , 0x05, 0x11, 0x01, 0x01, 0x00, 0x00 , 0x08, 0x11, 0x02, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00 , 0x0D, 0x11, 0x10, 0x09, 0x00, 0x00, 0x14, 0x00, 0x0F, 0x11, 0x00, 0x00, 0x00, 0x00 , 0x0A, 0x11, 0x11, 0x06, 0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00 , 0x10, 0x11, 0x12, 0x0C, 0x00, 0x04, 0x01, 0x08, 0xFF, 0xFF, 0x20, 0x02, 0x00, 0x00, 0x00, 0x00, 0x30 , 0x10, 0x11, 0x12, 0x0C, 0x0C, 0x30, 0x00, 0x1E, 0x04, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 , 0x10, 0x11, 0x12, 0x0C, 0x18, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 , 0x10, 0x11, 0x12, 0x0C, 0x24, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 , 0x09, 0x11, 0x12, 0x05, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00 , 0x08, 0x11, 0x12, 0x04, 0x36, 0x00, 0x00, 0x00, 0x00 , 0x10, 0x11, 0x20, 0x0C, 0x00, 0x02, 0x00, 0x07, 0x00, 0x5D, 0xC0, 0x01, 0xC9, 0xC3, 0x80, 0x00, 0x00 , 0x05, 0x11, 0x20, 0x01, 0x0C, 0xA8 , 0x10, 0x11, 0x20, 0x0C, 0x18, 0x01, 0x80, 0x08, 0x03, 0xC0, 0x00, 0x22, 0x20, 0x0C, 0xE8, 0x03, 0x0D , 0x10, 0x11, 0x20, 0x0C, 0x24, 0x00, 0xA7, 0xC6, 0x00, 0x54, 0x02, 0xC2, 0x00, 0x04, 0x23, 0x80, 0x01 , 0x07, 0x11, 0x20, 0x03, 0x30, 0x60, 0x7B, 0x80 , 0x05, 0x11, 0x20, 0x01, 0x35, 0xE0 , 0x10, 0x11, 0x20, 0x0C, 0x38, 0x11, 0xAB, 0xAB, 0x80, 0x02, 0xFF, 0xFF, 0x00, 0x2B, 0x0C, 0xA4, 0x22 , 0x0E, 0x11, 0x20, 0x0A, 0x45, 0x81, 0x01, 0x47, 0x01, 0x00, 0xFF, 0x06, 0x00, 0x18, 0x40 , 0x06, 0x11, 0x20, 0x02, 0x50, 0x84, 0x08 , 0x06, 0x11, 0x20, 0x02, 0x54, 0x03, 0x07 , 0x05, 0x11, 0x20, 0x01, 0x57, 0x00 , 0x09, 0x11, 0x20, 0x05, 0x5B, 0x40, 0x04, 0x06, 0x78, 0x20 , 0x10, 0x11, 0x21, 0x0C, 0x00, 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1, 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11 , 0x10, 0x11, 0x21, 0x0C, 0x0C, 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00, 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1 , 0x10, 0x11, 0x21, 0x0C, 0x18, 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11, 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00 , 0x08, 0x11, 0x22, 0x04, 0x00, 0x08, 0x7F, 0x00, 0x1D , 0x0B, 0x11, 0x23, 0x07, 0x00, 0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03 , 0x10, 0x11, 0x30, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 , 0x0C, 0x11, 0x40, 0x08, 0x00, 0x3B, 0x09, 0x55, 0x55, 0x88, 0x89, 0x20, 0xFF , 0x00 } ;

static int16_t intRFLastRSSI = 0;
static uint8_t ucTxChannel = 0;
static uint8_t ucRxChannel = 0;
static uint8_t ucRfNetwork = 0;
#line 42 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
void vRf4463Init( uint8_t ucSetTxChannel, uint8_t ucSetRxChannel, uint16_t usNetwork, uint8_t ucTxPower ){
 uint8_t pcBuffer[ 20 ];
#line 47 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
 if( usNetwork == 0 ){
  PrintOut( vDebugPrint , "[ RF4463 ] Invalid Network\r\n", ( ( void * )0 )  ) ;
 return;
 }
 if( ( ucSetTxChannel == 0 || ucSetTxChannel >  25  ) || ( ucSetRxChannel == 0 || ucSetRxChannel >  25  ) ){
  PrintOut( vDebugPrint , "[ RF4463 ] Invalid Channel\r\n", ( ( void * )0 )  ) ;
 return;
 }

 ucRfNetwork = usNetwork;
 ucRxChannel = ucSetRxChannel;
 ucTxChannel = ucSetTxChannel;
#line 62 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
 vRf4463PowerOnReset();

 vRf4463SetConfiguration( RF4463_CONFIGURATION_DATA, sizeof( RF4463_CONFIGURATION_DATA ) );
#line 70 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
 pcBuffer[ 0 ] =  0 ;
 pcBuffer[ 1 ] =  0 ;
 pcBuffer[ 2 ] =  33 ;
 pcBuffer[ 3 ] =  32 ;
 pcBuffer[ 4 ] =  39 ;
 pcBuffer[ 5 ] =  11 ;
 ucRf4463SetCommand( 6,  0x13 , pcBuffer );
 vBufferSetToZero( pcBuffer, 20 );
#line 82 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
 pcBuffer[ 0 ] = 98;
 ucRf4463SetProperty(  0x0000 , 1, pcBuffer );
 vBufferSetToZero( pcBuffer, 20 );
#line 89 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
 pcBuffer[ 0 ] = 0x00;
 ucRf4463SetProperty(  0x0003 , 1, pcBuffer );
 vBufferSetToZero( pcBuffer, 20 );
#line 96 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
 pcBuffer[ 0 ] = 0x08;
 pcBuffer[ 1 ] = 0x14;
 pcBuffer[ 2 ] = 0x00;
 pcBuffer[ 3 ] = 0x0F;
 pcBuffer[ 4 ] =  0x20  |  0x10  |  0x01 ;
 pcBuffer[ 5 ] = 0x00;
 pcBuffer[ 6 ] = 0x00;
 pcBuffer[ 7 ] = 0x00;
 pcBuffer[ 8 ] = 0x00;
 ucRf4463SetProperty(  0x1000 , 9, pcBuffer );
#line 110 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
 pcBuffer[ 0 ] = ( usNetwork >> 8 );
 pcBuffer[ 1 ] = ( usNetwork );
 ucRf4463SetSyncWords( pcBuffer, 2 );
#line 117 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
 pcBuffer[ 0 ] =  0x80  |  0x01 ;
 ucRf4463SetProperty(  0x1200 , 1, pcBuffer );

 pcBuffer[ 0 ] =  0x02 ;
 ucRf4463SetProperty(  0x1206 , 1, pcBuffer );

 pcBuffer[ 0 ] =  0x08  |  0x02 ;
 pcBuffer[ 1 ] =  0x01 ;
 pcBuffer[ 2 ] = 0x00;
 pcBuffer[ 3 ] = 0x20;
 pcBuffer[ 4 ] = 0x05;
 ucRf4463SetProperty(  0x1208 , 5, pcBuffer );
#line 133 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
 pcBuffer[ 0 ] = 0x00;
 pcBuffer[ 1 ] = 0x01;
 pcBuffer[ 2 ] =  0x04 ;
 pcBuffer[ 3 ] =  0x80  |  0x20  |  0x08  |  0x02 ;
 pcBuffer[ 4 ] = 0x00;
 pcBuffer[ 5 ] = 50;
 pcBuffer[ 6 ] =  0x04 ;
 pcBuffer[ 7 ] =  0x80  |  0x20  |  0x08  |  0x02 ;
 pcBuffer[ 8 ] = 0x00;
 pcBuffer[ 9 ] = 0x00;
 pcBuffer[ 10 ] = 0x00;
 pcBuffer[ 11 ] = 0x00;
 ucRf4463SetProperty(  0x120d , 12, pcBuffer );

 pcBuffer[ 0 ] = 0x00;
 pcBuffer[ 1 ] = 0x00;
 pcBuffer[ 2 ] = 0x00;
 pcBuffer[ 3 ] = 0x00;
 pcBuffer[ 4 ] = 0x00;
 pcBuffer[ 5 ] = 0x00;
 pcBuffer[ 6 ] = 0x00;
 pcBuffer[ 7 ] = 0x00;
 ucRf4463SetProperty(  0x1219 , 8, pcBuffer );
#line 160 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
 pcBuffer[ 0 ] = 0x01;
 ucRf4463SetProperty(  0x204c , 1, pcBuffer );
#line 166 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
 pcBuffer[ 0 ] = 0x01;
 pcBuffer[ 1 ] = 0x38;
 pcBuffer[ 2 ] = 0x00;
 ucRf4463SetProperty(  0x0100 , 3, pcBuffer );
#line 174 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
 ucRf4463SetTxPower( ucTxPower );
}
#line 180 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
void vRf4463PowerOnReset(){
#line 193 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
 uint8_t pcBuffer[ 7 ] = {  0x02, 0x01, 0x00, 0x01, 0xC9, 0xC3, 0x80  };

  GPIOD_ODR._GPIO_PIN_1  = 1;

 Delay_us( 10 );

  GPIOD_ODR._GPIO_PIN_1  = 0;

 Delay_ms( 6 );

  GPIOD_ODR._GPIO_PIN_2  = 0;
 vRf4463SPIWriteBuffer( sizeof( pcBuffer ), pcBuffer );
  GPIOD_ODR._GPIO_PIN_2  = 1;
}
#line 211 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
void vRf4463SetChannels( uint8_t ucSetRxChannel, uint8_t ucSetTxChannel ){
#line 215 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
 if( ( ucSetTxChannel == 0 || ucSetTxChannel >  25  ) || ( ucSetRxChannel == 0 || ucSetRxChannel >  25  ) ){
  PrintOut( vDebugPrint , "[ RF4463 ] Invalid Channel\r\n", ( ( void * )0 )  ) ;
 return;
 }
 ucRxChannel = ucSetRxChannel;
 ucTxChannel = ucSetTxChannel;
}
#line 226 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
void vRf4463SetNetwork( uint16_t usNetwork ){
 if( usNetwork == 0 ){
  PrintOut( vDebugPrint , "[ RF4463 ] Invalid Network\r\n", ( ( void * )0 )  ) ;
 return;
 }

 ucRfNetwork = usNetwork;
}
#line 241 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
void vRf4463SetConfiguration( const uint8_t * pcParameters, uint16_t usParametersLength ){
 uint8_t ucCommandLength = 0;
 uint8_t ucCommand = 0;
 uint8_t pcBuffer[ 30 ];

 uint16_t usPosition = 0;

 usParametersLength = usParametersLength - 1;
 ucCommandLength = pcParameters[ 0 ];
 usPosition = ucCommandLength + 1;

 while( usPosition < usParametersLength ){
 ucCommandLength = ( pcParameters[ usPosition++ ] - 1 );
 ucCommand = pcParameters[ usPosition++ ];
 memcpy( ( uint8_t * )pcBuffer, pcParameters + usPosition, ucCommandLength );
 ucRf4463SetCommand( ucCommandLength, ucCommand, pcBuffer );
 usPosition = usPosition + ucCommandLength;
 }
}
#line 264 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
uint8_t ucRf4463SetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer ){
 if( ucRf4463CheckCTS() ==  1  ){
 return  1 ;
 }

  GPIOD_ODR._GPIO_PIN_2  = 0;
 ucRf4463SPIByte( ucCommand );
 vRf4463SPIWriteBuffer( ucLength, pcParametersBuffer );
  GPIOD_ODR._GPIO_PIN_2  = 1;

 return  0 ;
}
#line 280 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
uint8_t ucRf4463GetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer ){
 if( ucRf4463CheckCTS() ==  1  ){
 return  1 ;
 }

  GPIOD_ODR._GPIO_PIN_2  = 0;
 ucRf4463SPIByte( ucCommand );
  GPIOD_ODR._GPIO_PIN_2  = 1;

 if( ucRf4463CheckCTS() ==  1  ){
 return  1 ;
 }

  GPIOD_ODR._GPIO_PIN_2  = 0;
 ucRf4463SPIByte(  0x44  );
 vRf4463SPIReadBuffer( ucLength, pcParametersBuffer );
  GPIOD_ODR._GPIO_PIN_2  = 1;

 return  0 ;
}
#line 304 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
uint8_t ucRf4463SetProperty( uint16_t usStartProperty, uint8_t ucLength, uint8_t * pcParametersBuffer ){
 uint8_t pcBuffer[ 4 ];

 if( ucRf4463CheckCTS() ==  1  ){
 return  1 ;
 }

 pcBuffer[ 0 ] =  0x11 ;
 pcBuffer[ 1 ] = ( usStartProperty >> 8 );
 pcBuffer[ 2 ] = ucLength;
 pcBuffer[ 3 ] = ( usStartProperty & 0xFF );

  GPIOD_ODR._GPIO_PIN_2  = 0;
 vRf4463SPIWriteBuffer( 4, pcBuffer );
 vRf4463SPIWriteBuffer( ucLength, pcParametersBuffer );
  GPIOD_ODR._GPIO_PIN_2  = 1;

 return  0 ;
}
#line 327 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
uint8_t ucRf4463GetProperty( uint16_t usStartProperty, uint8_t ucLength, uint8_t * pcParametersBuffer ){
 uint8_t pcBuffer[ 4 ];

 if( ucRf4463CheckCTS() ==  1  ){
 return  1 ;
 }

 pcBuffer[ 0 ] =  0x12 ;
 pcBuffer[ 1 ] = ( usStartProperty >> 8 );
 pcBuffer[ 2 ] = ucLength;
 pcBuffer[ 3 ] = ( usStartProperty & 0xFF );

  GPIOD_ODR._GPIO_PIN_2  = 0;
 vRf4463SPIWriteBuffer( 4, pcBuffer );

 if( ucRf4463CheckCTS() ==  1  ){
 return  1 ;
 }

  GPIOD_ODR._GPIO_PIN_2  = 0;
 ucRf4463SPIByte(  0x44  );
 vRf4463SPIReadBuffer( ucLength, pcParametersBuffer );
  GPIOD_ODR._GPIO_PIN_2  = 1;

 return  0 ;
}
#line 357 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
uint8_t ucRf4463SetSyncWords( uint8_t * pcSyncWords, uint8_t ucLength ){
 uint8_t pcBuffer[ 5 ];

 if( ( ucLength == 0 ) || ( ucLength > 3 ) ){
 return  1 ;
 }

 pcBuffer[ 0 ] = ucLength - 1;
 memcpy( pcBuffer + 1, pcSyncWords, ucLength );
 return ucRf4463SetProperty(  0x1100 , sizeof( pcBuffer ), pcBuffer );
}
#line 372 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
uint8_t ucRf4463SetPreambleLength( uint8_t ucLength ){
 return ucRf4463SetProperty(  0x1000 , 1, &ucLength );
}
#line 382 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
uint8_t ucRf4463CheckCTS(){
 uint16_t usTimeoutCounter = 0;

 usTimeoutCounter =  2500 ;

 while( usTimeoutCounter-- ){
  GPIOD_ODR._GPIO_PIN_2  = 0;
 ucRf4463SPIByte(  0x44  );
 if( ucRf4463SPIByte(  0x44  ) ==  0xff  ){
  GPIOD_ODR._GPIO_PIN_2  = 1;
 return  0 ;
 }
  GPIOD_ODR._GPIO_PIN_2  = 1;
 }
 return  1 ;
}
#line 402 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
void vRf4463RSSI(){
 int intRSSI;
#line 433 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
 uint8_t pcRSSI[ 9 ];
 uint8_t pcBuffer[ 4 ];

 pcBuffer[ 0 ] = 0x20;
 pcBuffer[ 1 ] = 0x01;
 pcBuffer[ 2 ] = 0x4E;
 pcBuffer[ 3 ] = 0x40;
 ucRf4463SetCommand( 4,  0x11 , pcBuffer );
 ucRf4463GetCommand( 9,  0x22  , pcRSSI );
 intRSSI = ( ( ( pcRSSI[ 4 ] / 2 ) -64 ) - 60 );
 intRFLastRSSI = intRSSI;

  PrintOut( vDebugPrint , "[ RF4463 ] RSSI: %i\r\n", intRSSI ) ;
}
#line 451 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
int16_t intRF4463GetLastRSSI(){
  PrintOut( vDebugPrint , "[ RF4463 ] Last Measured RSSI: %i", intRFLastRSSI ) ;
 return intRFLastRSSI;
}
#line 460 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
uint8_t ucRf4463DeviceAvailability(){
 uint8_t pcBuffer[ 9 ];
 static uint16_t usPartInformation = 0;

 if( ucRf4463GetCommand( 9,  0x01 , pcBuffer ) ==  1  ){
 return  1 ;
 }

 usPartInformation = ( ( pcBuffer[ 2 ] << 8 ) | pcBuffer[ 3 ] );

 if( usPartInformation != 0x4463 ){
 return  1 ;
 }

 return  0 ;
}
#line 483 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
uint8_t ucRf4463SetGPIOMode( uint8_t ucGPIO0Mode, uint8_t ucGPIO1Mode ){
 uint8_t pcBuffer[ 6 ] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };

 pcBuffer[ 0 ] = ucGPIO0Mode;
 pcBuffer[ 1 ] = ucGPIO1Mode;

 return ucRf4463SetCommand( sizeof( pcBuffer ),  0x13 , pcBuffer );
}
#line 495 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
void vRf4463FIFOReset(){
 uint8_t ucData = 0x03;

 ucRf4463SetCommand( sizeof( ucData ),  0x15 , &ucData );
}
#line 504 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
uint8_t ucRf4463ClearInterrupts(){
 uint8_t pcBuffer[] = { 0x00, 0x00, 0x00 };

 return ucRf4463SetCommand( sizeof( pcBuffer ),  0x20 , pcBuffer );
}
#line 513 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
uint8_t ucRf4463EnterStandbyMode(){
 uint8_t ucData = 0x01;

 return ucRf4463SetCommand( 1,  0x34 , &ucData );
}
#line 525 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
void vRf4463EnterTxMode(){
 uint8_t pcBuffer[] = { 0x00, 0x30, 0x00, 0x00 };
 pcBuffer[ 0 ] = ucTxChannel;
 ucRf4463SetCommand( 4,  0x31 , pcBuffer );
}
#line 534 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
uint8_t ucRf4463SetTxInterrupt(){
 uint8_t pcBuffer[ 3 ] = { 0x01, 0x20, 0x00 };
 return ucRf4463SetProperty(  0x0100 , 3, pcBuffer );
}
#line 542 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
uint8_t ucRf4463SetTxPower( uint8_t ucPower ){
 uint8_t pcBuffer[] = { 0x08, 0x00, 0x00, 0x3D };

 if( ucPower > 127 ){
  PrintOut( vDebugPrint , "[ Rf4463 ] Invalid Power Value: %d\r\n", ucPower ) ;
 ucPower = 127;
 }

 pcBuffer[ 1 ] = ucPower;

 return ucRf4463SetProperty(  0x2200 , sizeof( pcBuffer ), pcBuffer );
}
#line 558 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
void vRf4463WriteTxFIFO( uint8_t * pcWriteBuffer, uint8_t ucLength ){
 uint8_t pcBuffer[  64  ];

 pcBuffer[ ucLength + 1 ];

 ucRf4463SetProperty(  0x1212 , 1, &ucLength );

 pcBuffer[ 0 ] = ucLength;

 memcpy( pcBuffer + 1, pcWriteBuffer, ucLength );

 ucRf4463SetCommand( ucLength + 1,  0x66 , pcBuffer );
}
#line 575 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
uint8_t ucRf4463TxPacket( uint8_t * pcTxBuffer, uint8_t ucTxLength ){

 vRf4463FIFOReset();

 vRf4463WriteTxFIFO( pcTxBuffer, ucTxLength );

 vRf4463EnterTxMode();

 return  0 ;
}
#line 589 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
uint8_t ucRf4463TxPacket_Seq( uint8_t * pcTxBuffer, uint8_t ucTxLength ){
 uint8_t pcBuffer[ 3 ];
 uint8_t ucCounter = 0;

 vRf4463FIFOReset();
 vRf4463WriteTxFIFO( pcTxBuffer, ucTxLength );
 ucRf4463ClearInterrupts();
 vRf4463EnterTxMode();

 for( ;; ){
 if( ucRF4463GetIRQFlag() == 1 ){
 break;
 }
 }

 return  0 ;
}
#line 613 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
void vRf4463EnterRxMode(){
 uint8_t pcBuffer[] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x08 };
 pcBuffer[ 0 ] = ucRxChannel;
 ucRf4463SetCommand( 7,  0x32 , pcBuffer );
}
#line 622 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
uint8_t ucRf4463SetRxInterrupt(){
 uint8_t pcBuffer[ 3 ] = { 0x03, 0x18, 0x00 };
 return ucRf4463SetProperty(  0x0100 , 3, pcBuffer );
}
#line 630 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
uint8_t ucRf4463RxInit(){
 ucRf4463SetProperty(  0x1212 , 1,  64  );

 vRf4463FIFOReset();

 vRf4463EnterRxMode();

 return  0 ;
}
#line 643 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
uint8_t ucRf4463RxPacket( uint8_t * pcRxBuffer ){
 uint8_t ucRxLength = 0;

 vRf4463ReadRxFIFO( pcRxBuffer );

 vRf4463FIFOReset();

 return ucRxLength;
}
#line 656 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463pro.c"
void vRf4463ReadRxFIFO( uint8_t * pcBuffer ){
 uint8_t * pcReadLength;

 uint8_t ucCounter = 0;

 for( ucCounter = 0; ucCounter <  64 ; ucCounter++ ){
 pcBuffer[ ucCounter ] = 0x00;
 }

 if( ucRf4463CheckCTS() ==  1  ){
 return;
 }

  GPIOD_ODR._GPIO_PIN_2  = 0;

 ucRf4463SPIByte(  0x77  );
 vRf4463SPIReadBuffer( 1, &pcReadLength );
 vRf4463SPIReadBuffer(  64 , pcBuffer );

  GPIOD_ODR._GPIO_PIN_2  = 1;


 vRf4463RSSI();


 return;
}
#line 1 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463spi.c"
#line 1 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463spi.h"
#line 35 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463spi.c"
void vRf4463SPIWriteBuffer( uint16_t usWriteLength, uint8_t * pcWriteBuffer ){
#line 39 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463spi.c"
 while( usWriteLength-- ){
 ucRf4463SPIByte( *pcWriteBuffer++ );
 }
}
#line 50 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463spi.c"
void vRf4463SPIReadBuffer( uint16_t usReadLength, uint8_t * pcReadBuffer ){
 uint8_t ucRxCounter = 0;
#line 55 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463spi.c"
 while( usReadLength-- ){
 pcReadBuffer[ ucRxCounter++ ] = ucRf4463SPIByte( 0 );
 }
}
#line 66 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/rf4463spi.c"
uint8_t ucRf4463SPIByte( uint8_t pcWriteData ){
 return SPI1_Read( pcWriteData );
}
#line 1 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.c"
#line 1 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.h"
#line 25 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.c"
static uint8_t ucUART1RxIRQFlag = 0;
uint16_t usUART1RxBufferLength = 0;
uint8_t pcUART1RxBuffer[ 256 ];
#line 41 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.c"
void vISR_UART1_Callback() iv IVT_INT_USART1 ics ICS_AUTO{
 uint8_t ucByteRead = 0;
#line 46 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.c"
 if( USART1_SRbits.ORE == 1 ){
  PrintOut( vDebugPrint , "[ UART ] Overrun Error\r\n", ( ( void * )0 )  ) ;
 ucByteRead = ( uint8_t )USART1_DR;
 }
#line 53 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.c"
 if( USART1_SRbits.RXNE == 1 ){
 ucByteRead = ( uint8_t )USART1_DR;

 if( ucByteRead != '\n' && usUART1RxBufferLength <  256  ){
 pcUART1RxBuffer[ usUART1RxBufferLength++ ] = ucByteRead;
 }
 else{
 if( pcUART1RxBuffer[ usUART1RxBufferLength - 1 ] == '\r' ){
 usUART1RxBufferLength -= 1;
 pcUART1RxBuffer[ usUART1RxBufferLength ] = 0;
 }
 ucUART1RxIRQFlag = 1;
 }
 }
}
#line 75 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.c"
void vUART1MessageHandler(){
  PrintOut( vDebugPrint , "[ UART ] Message: %s\r\n", pcUART1RxBuffer ) ;
 vRF4463TxMessage( pcUART1RxBuffer, usUART1RxBufferLength,  255  );
 vUART1ResetRxBuffer();
}
#line 84 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.c"
void vUARTTxInit(){
 vUART1_Init_Advanced( 115200, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT,  1  );
}
#line 91 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.c"
void vUARTRxInit(){
 USART1_CR1bits.RE = 1;
 USART1_CR1bits.RXNEIE = 1;

 NVIC_IntEnable( IVT_INT_USART1 );
}
#line 101 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.c"
void vUART1_Init_Advanced ( unsigned long ulBaudRate, unsigned int uiDataBits , unsigned int uiParity, unsigned int uiStopBits, unsigned char ucTerminalMap ){
#line 105 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.c"
 RCC_APB2ENRbits.USART1EN = 1;
#line 111 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.c"
 USART1_CR1bits.TE = 1;
 USART1_CR1bits.UE = 1;
#line 116 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.c"
 if( ulBaudRate == 115200 ){
 USART1_BRRbits.DIV_Fraction = 0x09;
 USART1_BRRbits.DIV_Mantissa = 0x02D;
 }
#line 123 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.c"
 else if ( ulBaudRate == 921600 ) {
 USART1_BRRbits.DIV_Fraction = 0x0B;
 USART1_BRRbits.DIV_Mantissa = 0x005;
 }
#line 130 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.c"
 USART1_CR1 |= uiParity | uiDataBits;
 USART1_CR2 |= uiStopBits;
#line 135 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.c"
 switch ( ucTerminalMap ) {
#line 139 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.c"
 case  0 :
 RCC_AHB1ENRbits.GPIOAEN = 1;
 GPIOA_MODERbits.MODER10 = 2;
 GPIOA_OTYPERbits.OT10 = 0;
 GPIOA_OSPEEDRbits.OSPEEDR10 = 3;
 GPIOA_PUPDRbits.PUPDR10 = 0;
 GPIOA_AFRHbits.AFRH10 = 7;

 GPIOA_MODERbits.MODER9 = 2;
 GPIOA_OTYPERbits.OT9 = 0;
 GPIOA_OSPEEDRbits.OSPEEDR9 = 3;
 GPIOA_PUPDRbits.PUPDR9 = 0;
 GPIOA_AFRHbits.AFRH9 = 7;
 break;
#line 156 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.c"
 case  1 :
 RCC_AHB1ENRbits.GPIOBEN = 1;
 GPIOB_MODERbits.MODER6 = 2;
 GPIOB_OTYPERbits.OT6 = 0;
 GPIOB_OSPEEDRbits.OSPEEDR6 = 3;
 GPIOB_PUPDRbits.PUPDR6 = 0;
 GPIOB_AFRLbits.AFRL6 = 7;

 GPIOB_MODERbits.MODER7 = 2;
 GPIOB_OTYPERbits.OT7 = 0;
 GPIOB_OSPEEDRbits.OSPEEDR7 = 3;
 GPIOB_PUPDRbits.PUPDR7 = 0;
 GPIOB_AFRLbits.AFRL7 = 7;
 break;
 }
}
#line 176 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.c"
void vUART1_Write( unsigned char pcByte ){
 USART1_DR = pcByte;
 if ( USART1_CR1bits.UE ) {
 while ( !USART1_SRbits.TXE );
 }
}
#line 186 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.c"
void vUART1_Write_Text( unsigned char *pcBuffer ){
 unsigned char ucCounter = 0;
 unsigned char ucBufferSize = 0;

 ucBufferSize = strlen( pcBuffer );

 for ( ucCounter = 0; ucCounter < ucBufferSize; ucCounter++ ){
 USART1_DR = pcBuffer[ ucCounter ];
 if ( USART1_CR1bits.UE ) {
 while ( !USART1_SRbits.TXE );
 }
 }
}
#line 206 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.c"
uint8_t ucUART1MessageReady(){
 return ucUART1RxIRQFlag;
}
#line 213 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.c"
void vUART1ResetIRQFlag(){
 ucUART1RxIRQFlag = 0;
}
#line 220 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/uart1handler.c"
void vUART1ResetRxBuffer(){
 for( usUART1RxBufferLength = 0; usUART1RxBufferLength < 256; usUART1RxBufferLength++ ){
 pcUART1RxBuffer[ usUART1RxBufferLength ] = 0;
 }
 usUART1RxBufferLength = 0;
}
#line 1 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/utils.c"
#line 1 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/utils.h"
#line 25 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/utils.c"
const uint8_t pcHexChar[16] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};

uint8_t ucMSBNibble = 0;
uint8_t ucLSBNibble = 0;
#line 41 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/utils.c"
uint8_t ucASCIIToByte( uint8_t * pcASCIIBuffer ){
 ucMSBNibble = 0;
 ucLSBNibble = 0;

 ucMSBNibble = ( pcASCIIBuffer[ 0 ] - 0x30 );
 if( ucMSBNibble > 9 ){
 ucMSBNibble -= 7;
 }

 ucLSBNibble = ( pcASCIIBuffer[ 1 ] - 0x30 );
 if( ucLSBNibble > 9 ){
 ucLSBNibble -= 7;
 }

 return ( ucMSBNibble << 4 | ucLSBNibble );
}
#line 61 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/utils.c"
void vASCIIToHex( uint8_t *pcHexConvertBuffer, uint8_t *pcASCIIConvertBuffer, uint8_t ucConversionLength ){
 uint8_t ucASCIICounter = 0;

 for( ucASCIICounter = 0; ucASCIICounter < ucConversionLength; ucASCIICounter++ ){
 ucMSBNibble = 0;
 ucLSBNibble = 0;

 ucMSBNibble = ( pcASCIIConvertBuffer[ ucASCIICounter * 2 ] - 0x30 );
 if( ucMSBNibble > 9 ){
 ucMSBNibble -= 7;
 }

 ucLSBNibble = ( pcASCIIConvertBuffer[ ( ucASCIICounter * 2 ) + 1 ] - 0x30 );
 if( ucLSBNibble > 9 ){
 ucLSBNibble -= 7;
 }

 pcHexConvertBuffer[ ucASCIICounter ] = ( ( ucMSBNibble << 4 ) | ucLSBNibble );
 }
}
#line 85 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/utils.c"
void vHexToASCII( uint8_t *pcASCIIConvertBuffer, uint8_t *pcHexConvertBuffer, uint8_t ucConversionLength ){
 uint8_t ucHexConvCounter = 0;

 for( ucHexConvCounter = 0; ucHexConvCounter < ucConversionLength; ucHexConvCounter++ ){
 pcASCIIConvertBuffer[ ucHexConvCounter * 2 ] = pcHexChar[ pcHexConvertBuffer[ ucHexConvCounter ] >> 4 ];
 pcASCIIConvertBuffer[ ( ucHexConvCounter * 2 ) + 1 ] = pcHexChar[ ( pcHexConvertBuffer[ ucHexConvCounter ] & 0x0F ) ];
 }
}
#line 97 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/utils.c"
void vBufferSetToZero( uint8_t * pcBufferToClean, uint16_t uslength ){
 uint16_t usPosition = 0;

 for( usPosition = 0; usPosition < uslength; usPosition++ ){
 pcBufferToClean[ usPosition ] = 0x00;
 }
}
#line 108 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/utils.c"
void vBufferSetTo255( uint8_t * pcBufferToClean, uint16_t uslength ){
 uint16_t usPosition = 0;

 for( usPosition = 0; usPosition < uslength; usPosition++ ){
 pcBufferToClean[ usPosition ] = 0xFF;
 }
}
#line 119 "d:/kleverness/code/mikro c/test/test_testjigv2_rf+uart/utils.c"
void vBufferSetToValue( uint8_t * pcBufferToClean, uint8_t ucValue, uint16_t uslength ){
 uint16_t usPosition = 0;

 for( usPosition = 0; usPosition < uslength; usPosition++ ){
 pcBufferToClean[ usPosition ] = ucValue;
 }
}
#line 59 "D:/Kleverness/Code/Mikro C/Test/Test_TestJigv2_RF+UART/main.c"
void main(){
#line 66 "D:/Kleverness/Code/Mikro C/Test/Test_TestJigv2_RF+UART/main.c"
 vUARTTxInit();
 vUARTRxInit();

 ucRF4463Setup(  5 ,  5 ,  5 ,  127  );
#line 73 "D:/Kleverness/Code/Mikro C/Test/Test_TestJigv2_RF+UART/main.c"
 vUART1ResetRxBuffer();
#line 77 "D:/Kleverness/Code/Mikro C/Test/Test_TestJigv2_RF+UART/main.c"
  PrintOut( vDebugPrint , "[ SYS ] Start Success\r\n", ( ( void * )0 )  ) ;
 while( 1 ){
 if( ucRF4463GetIRQFlag() == 1 ){

 vRF4463MesageHandler();
 vRF4463ResetIRQFlag();
 }
 if( ucUART1MessageReady() == 1 ){

 vUART1MessageHandler();
 vUART1ResetIRQFlag();
 }
 }
}
