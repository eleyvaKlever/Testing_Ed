#line 1 "C:/Users/Crow/Desktop/Data/Dongle/Dongle ( STM32F107RC ) [ MikroC ] 10 oct 2020/Dongle ( STM32F107RC ) [ MikroC ]/main.c"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/main.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/include/built_in.h"
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
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/include/string.h"





void * memchr(void *p, char n, unsigned int v);
int memcmp(void *s1, void *s2, int n);
void * memcpy(void * d1, void * s1, int n);
void * memmove(void * to, void * from, int n);
void * memset(void * p1, char character, int n);
char * strcat(char * to, char * from);
char * strchr(char * ptr, char chr);
int strcmp(char * s1, char * s2);
char * strcpy(char * to, char * from);
int strlen(char * s);
char * strncat(char * to, char * from, int size);
char * strncpy(char * to, char * from, int size);
int strspn(char * str1, char * str2);
char strcspn(char * s1, char * s2);
int strncmp(char * s1, char * s2, char len);
char * strpbrk(char * s1, char * s2);
char * strrchr(char *ptr, char chr);
char * strstr(char * s1, char * s2);
char * strtok(char * s1, char * s2);
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/include/stdlib.h"







 typedef struct divstruct {
 int quot;
 int rem;
 } div_t;

 typedef struct ldivstruct {
 long quot;
 long rem;
 } ldiv_t;

 typedef struct uldivstruct {
 unsigned long quot;
 unsigned long rem;
 } uldiv_t;

int abs(int a);
float atof(char * s);
int atoi(char * s);
long atol(char * s);
div_t div(int number, int denom);
ldiv_t ldiv(long number, long denom);
uldiv_t uldiv(unsigned long number, unsigned long denom);
long labs(long x);
long int max(long int a, long int b);
long int min(long int a, long int b);
void srand(unsigned x);
int rand();
int xtoi(char * s);
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/include/stdio.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/include/stdbool.h"



 typedef char _Bool;
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/sysdefinitions.c"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/sysdefinitions.h"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/main.h"
#line 64 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/sysdefinitions.h"
typedef struct{
 uint8_t Major;
 uint8_t Minor;
 uint8_t Build;
} FirmwareVersion_t;
#line 72 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/sysdefinitions.h"
enum DeviceModelID{
 DEVICE_MODEL_ID_DONGLE = 0,
 DEVICE_MODEL_ID_HUB,
 DEVICE_MODEL_ID_SWITCH,
 DEVICE_MODEL_ID_DIMMER,
 DEVICE_MODEL_ID_OUTLET,
 DEVICE_MODEL_ID_TOTAL
};

enum ComponentID{
 DEVICE_COMPONENT_ID_DONGLE = 0,
 DEVICE_COMPONENT_ID_HUB_ESP32,
 DEVICE_COMPONENT_ID_HUB_STM32,
 DEVICE_COMPONENT_ID_SWITCH,
 DEVICE_COMPONENT_ID_DIMMER_PAD,
 DEVICE_COMPONENT_ID_DIMMER_SUPPLY,
 DEVICE_COMPONENT_ID_OUTLET,
 DEVICE_COMPONENT_ID_TOTAL,
 DEVICE_COMPONENT_ID_NONE = 0xFE,
};

enum ControlID{
 DEVICE_CONTROL_ID_NOT_VALID = 0,
 DEVICE_CONTROL_ID_SWITCH_GANG_1,
 DEVICE_CONTROL_ID_SWITCH_GANG_2,
 DEVICE_CONTROL_ID_SWITCH_GANG_3,
 DEVICE_CONTROL_ID_DIMMER,
 DEVICE_CONTROL_ID_OUTLET,
 DEVICE_CONTROL_ID_TOTAL
};
#line 27 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/sysdefinitions.c"
const uint8_t pcOverrideKey[ DEVICE_MODEL_ID_TOTAL ][  32  ] = {
#line 31 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/sysdefinitions.c"
 {
 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
 },
#line 38 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/sysdefinitions.c"
 {
 0x7B, 0x32, 0x53, 0x64, 0x54, 0x65, 0x71, 0x69, 0x36, 0x28, 0x4C, 0x5A, 0x40, 0x51, 0x54, 0x5D,
 0x68, 0x26, 0x47, 0x36, 0x57, 0x5D, 0x4F, 0x35, 0x4C, 0x47, 0x43, 0x59, 0x56, 0x40, 0x7A, 0x7B
 },
#line 45 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/sysdefinitions.c"
 {
 0xDA, 0xE5, 0xA0, 0x27, 0x6F, 0x0B, 0xF4, 0xDD, 0x02, 0x4F, 0x8E, 0x5B, 0xAD, 0x93, 0x25, 0x1B,
 0xDA, 0x1D, 0xEF, 0x31, 0xA1, 0x40, 0x96, 0xBA, 0x71, 0x00, 0x1C, 0xA5, 0xB5, 0x85, 0x6E, 0xFE
 },
#line 52 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/sysdefinitions.c"
 {
 0x2A, 0x1F, 0xD2, 0xBE, 0xC6, 0x5B, 0xEA, 0xD7, 0x3D, 0xD4, 0xE6, 0x79, 0xE3, 0x32, 0x2A, 0x53,
 0x48, 0xF6, 0x72, 0xB7, 0x67, 0x1B, 0x56, 0x7C, 0xF4, 0xD6, 0x48, 0xC7, 0x8C, 0x48, 0x59, 0x2D
 },
#line 59 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/sysdefinitions.c"
 {
 0x05, 0x53, 0x1D, 0xC0, 0x13, 0x31, 0x95, 0x7C, 0xDF, 0xB3, 0x72, 0x82, 0x53, 0x32, 0xFE, 0x05,
 0x04, 0xFE, 0xC9, 0x81, 0xC3, 0x50, 0x7D, 0xF9, 0x30, 0x81, 0xF6, 0x9A, 0x38, 0xF2, 0x2A, 0x14
 }
};
#line 70 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/sysdefinitions.c"
const uint8_t * pcModelPrefix[] = {
 "DO",
 "KH",
 "KS",
 "KD",
 "KO"
};
#line 85 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/sysdefinitions.c"
static uint8_t pcSentQR[ 15 ];
static uint8_t pcReceivedQR[ 15 ];
#line 90 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/sysdefinitions.c"
uint8_t pcTempQR[ 15 ];
uint8_t ucSearchedModelId = 0;
#line 98 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/sysdefinitions.c"
uint8_t ucUARTDataReady = 0;
#line 102 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/sysdefinitions.c"
uint8_t ucRF4463TxEvent = 0;
uint8_t ucRadioEvent = 0;
#line 107 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/sysdefinitions.c"
uint8_t ucSearchActive = 0;
#line 114 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/sysdefinitions.c"
const uint8_t * pcModelQRPrefix[] = {
 "DO",
 "KH",
 "KS",
 "KD",
 "KO"
};
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/dongle.c"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/dongle.h"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/main.h"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.h"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/main.h"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/main.h"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463commands.h"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/2400b_915_250k_ch0.h"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]//si446x_patch.h"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463spi.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/include/stdint.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/include/stdbool.h"
#line 41 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463spi.h"
void vRf4463SPIWriteBuffer( uint16_t usWriteLength, uint8_t * pcWriteBuffer );

void vRf4463SPIReadBuffer( uint16_t usReadLength, uint8_t * pcReadBuffer );

uint8_t ucRf4463SPIByte( uint8_t pcWriteData );
#line 115 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
enum RF4463ChipState{
 RF4463_CHIP_STATE_NO_CHANGE = 0,
 RF4463_CHIP_STATE_SLEEP,
 RF4463_CHIP_STATE_SPI_ACTIVE,
 RF4463_CHIP_STATE_READY,
 RF4463_CHIP_STATE_READY2,
 RF4463_CHIP_STATE_TX_TUNE,
 RF4463_CHIP_STATE_RX_TUNE,
 RF4463_CHIP_STATE_TX,
 RF4463_CHIP_STATE_RX,
 RF4463_CHIP_STATE_TOTALS
};

enum RF4463Frequency{
 RF4463_FREQUENCY_433MHz = 0,
 RF4463_FREQUENCY_868MHz,
 RF4463_FREQUENCY_915MHz,
 RF4463_FREQUENCY_TOTAL
};
#line 177 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
void vRf4463Init( uint8_t ucSetTxChannel, uint8_t ucSetRxChannel, uint16_t usNetwork, uint8_t ucTxPower, uint8_t ucFrequency );
#line 189 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
void vRf4463PowerOnReset();
#line 201 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
void vRf4463SetChannels( uint8_t ucSetRxChannel, uint8_t ucSetTxChannel );
#line 213 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
void vRf4463SetNetwork( uint16_t usNetwork );
#line 229 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
void vRf4463SetConfiguration( const uint8_t * pcParameters, uint16_t usParametersLength );
#line 244 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
uint8_t ucRf4463SetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer );
#line 259 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
uint8_t ucRf4463GetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer );
#line 274 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
uint8_t ucRf4463SetProperty( uint16_t ucStartProperty, uint8_t ucLength, uint8_t * pcParametersBuffer );
#line 289 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
uint8_t ucRf4463GetProperty( uint16_t ucStartProperty, uint8_t ucLength, uint8_t * pcParametersBuffer );
#line 302 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
uint8_t ucRf4463SetSyncWords( uint8_t * pcSyncWords, uint8_t ucLength );
#line 315 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
uint8_t ucRf4463SetPreambleLength( uint8_t ucLength );
#line 333 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
uint8_t ucRf4463CheckCTS();
#line 349 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
void vRf4463RSSI();
#line 361 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
int16_t xRF4463GetLastRSSI();
#line 375 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
uint8_t ucRf4463DeviceAvailability();
#line 391 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
uint8_t ucRf4463SetGPIOMode( uint8_t ucGPIO0Mode, uint8_t GPIO1Mode );
#line 403 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
void vRf4463FIFOReset();
#line 417 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
uint8_t ucRf4463ClearInterrupts();
#line 430 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
uint8_t ucRf4463EnterStandbyMode();

uint8_t vRf4463SetFrecc(float foCentral);
#line 452 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
void vRf4463EnterTxMode();
#line 465 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
uint8_t ucRf4463SetTxInterrupt();
#line 478 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
uint8_t ucRf4463SetTxPower( uint8_t ucPower );
#line 491 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
void vRf4463WriteTxFIFO( uint8_t * pcWriteBuffer, uint8_t ucLength );
#line 508 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
uint8_t ucRf4463TxPacket( uint8_t * pcSendBuffer, uint8_t ucSendLength );
#line 524 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
uint8_t ucRf4463TxPacket_Seq( uint8_t * pcTxBuffer, uint8_t ucTxLength );
#line 539 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
void vRf4463EnterRxMode();
#line 552 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
uint8_t ucRf4463SetRxInterrupt();
#line 565 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
uint8_t ucRf4463RxInit();
#line 578 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
uint8_t ucRf4463RxPacket( uint8_t * pcRxBuffer );
#line 592 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
void vRf4463ReadRxFIFO( uint8_t * pcBuffer );
#line 604 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
uint8_t ucRF4463GetModemStatus();
#line 616 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
uint8_t ucRF4463GetIntStatus();
#line 628 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
uint8_t ucRF4463CheckIntStatus();
#line 640 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
void vRF4463CheckState();
#line 652 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
void vRF4463SetState( uint8_t ucState );
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463spi.h"
#line 147 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.h"
typedef struct{
 uint8_t Node;
 uint8_t Channel;
 uint8_t BaudRate;
 uint8_t TxPower;
 uint16_t Network;
} RadioParameters_t;
#line 157 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.h"
enum RFCommandTables{
 TABLE_RF_TEST = 1,
 TABLE_RF_SETUP,
 TABLE_RF_OTA,
 TABLE_RF_GLOBAL,
 TABLE_RF_SWITCH,
 TABLE_RF_DIMMER,
 TABLE_RF_OUTLET,
 RF_TABLES
};
#line 171 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.h"
enum RFTestCommands{
 RF_TEST_DEVICE_PING = 0,
 RF_TEST_STATUS,
#line 177 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.h"
 RF_TEST_QR,
 RF_TEST_OK,
 RF_TEST_STAGE,
 RF_TEST_LOOP,
#line 184 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.h"
 RF_TEST_CHANNEL,
#line 188 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.h"
 RF_TEST_MESSAGE,
#line 192 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.h"
 RF_TEST_INFO,
 RF_TEST_TABLE
};
#line 201 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.h"
enum RFConfigurationCommands{
 RF_SETUP_DISCOVER = 0,
 RF_SETUP_FIND_BY_QR,
 RF_SETUP_SEND_CONFIG,
 RF_SETUP_REGISTER,
 RF_SETUP_PREPARE_REMOVAL,
 RF_SETUP_REMOVE,
 RF_SETUP_HARD_RESET_REQUEST,
#line 212 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.h"
 RF_SETUP_OVERRIDE_ENABLE,
 RF_SETUP_OVERRIDE_DISABLE,
 RF_SETUP_FTY_RESTORE,
 RF_SETUP_FTY_RECONFIGURE,
 RF_SETUP_FTY_DISCOVER,
#line 220 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.h"
 RF_SETUP_SET_MASTER,
 RF_SETUP_SET_SLAVE,
 RF_SETUP_TABLE
};
#line 228 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.h"
enum RFFOTACommands{
 RF_FOTA_START = 0,
 RF_FOTA_START_ACK,
 RF_FOTA_HEADER,
 RF_FOTA_HEADER_ACK,
 RF_FOTA_LINE,
 RF_FOTA_LINE_ACK,
 RF_FOTA_LINE_NACK,
 RF_FOTA_EOT,
 RF_FOTA_EOT_ACK,
 RF_FOTA_ERROR,
 RF_FOTA_DONE,
 RF_FOTA_TABLE
};
#line 246 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.h"
enum RFGlobalCommands{
 RF_GLOBAL_ON = 0,
 RF_GLOBAL_OFF,
 GlobalTableSize
};
#line 255 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.h"
enum RFSwitchCommands{
 RF_SWITCH_ON = 0,
 RF_SWITCH_OFF,
 RF_SWITCH_VIA1_ON,
 RF_SWITCH_VIA1_OFF,
 RF_SWITCH_VIA2_ON,
 RF_SWITCH_VIA2_OFF,
 RF_SWITCH_VIA3_ON,
 RF_SWITCH_VIA3_OFF,
 RF_SWITCH_SET_1_GANG,
 RF_SWITCH_SET_2_GANG,
 RF_SWITCH_SET_3_GANG,
 RF_SWITCH_SLEEP,
 RF_SWITCH_WAKE,
 RF_SWITCH_HAPTIC_ENABLE,
 RF_SWITCH_HAPTIC_DISABLE,
 RF_SWITCH_TOUCH_ENABLE,
 RF_SWITCH_TOUCH_DISABLE,
 RF_SWITCH_GET_CONSUMPTION,
 RF_SWITCH_TABLE
};
#line 280 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.h"
enum RFDimmerCommands{
 RF_DIMMER_ON = 0,
 RF_DIMMER_OFF,
 RF_DIMMER_LEVEL_1,
 RF_DIMMER_LEVEL_2,
 RF_DIMMER_LEVEL_3,
 RF_DIMMER_LEVEL_4,
 RF_DIMMER_LEVEL_5,
 RF_DIMMER_GET_ACK,
 RF_DIMMER_TOUCH_ENABLE,
 RF_DIMMER_TOUCH_DISABLE,
 RF_DIMMER_SLEEP,
 RF_DIMMER_WAKE,
 RF_DIMMER_RECALIBRATE_SUPPLY,
 RF_DIMMER_IS_ONLINE,
 RF_DIMMER_GET_CONSUMPTION,
 RF_DIMMER_CALIBRATE_OFFSET,
 RF_DIMMER_SET_OFFSET,
 RF_DIMMER_TABLE
};
#line 304 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.h"
enum RFOutletCommands{
 RF_OUTLET_ON = 0,
 RF_OUTLET_OFF,
 RF_OUTLET_BUTTON_ENABLE,
 RF_OUTLET_BUTTON_DISABLE,
 RF_OUTLET_SLEEP,
 RF_OUTLET_WAKE,
 RF_OUTLET_GET_CONSUMPTION,
 RF_OUTLET_TABLE
};
#line 328 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.h"
void vRF4463MesageHandler();
#line 340 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.h"
void vRF4463TxMessage( uint8_t * pcOutBuffer, uint8_t ucLength, uint8_t ucRemoteNode, uint8_t ucTable, uint8_t ucCommand );
#line 352 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.h"
uint8_t ucRF4463Setup( uint8_t ucRxChannel, uint8_t ucTxChannel, uint16_t usNetwork, uint8_t ucTxPower );
#line 364 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.h"
void vRF4463SetNode( uint8_t ucNode );
#line 378 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.h"
void vRF4463RxCommand();
#line 390 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.h"
void vRF4463RxFTY();
#line 405 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.h"
uint8_t ucRF4463GetIRQFlag();
#line 417 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.h"
void vRF4463ResetIRQFlag();
#line 429 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.h"
uint8_t ucRF4463GetIRQFlag();
#line 441 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.h"
void vRF4463ResetIRQFlag();
#line 453 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.h"
uint8_t ucRF4463GetActiveId();
#line 465 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.h"
void vRF4463SetActive( uint8_t ucSelectRadio );
#line 477 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.h"
void vRF4463SetPinSelect( uint8_t ucPinVal );
#line 489 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.h"
void vRF4463SetPinSDN( uint8_t ucPinVal );
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/uarthandler.h"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/main.h"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/debug.h"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/main.h"
#line 68 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/debug.h"
 void vDebugInit();
 void vDebugPrint( uint8_t ucPrintData );
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/timer.h"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/main.h"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/debug.h"
#line 29 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/timer.h"
enum{
 TIMER_SEARCH,
 TotalsTimers
} TimerList;
#line 36 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/timer.h"
void vTimerStop( uint8_t ucTimer );

void vTimerSearchLed();
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/xorcipher.h"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/main.h"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/debug.h"
#line 34 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/xorcipher.h"
void vXORRFMessage( uint8_t * pcBuffer, uint8_t * pcXORBuffer, uint8_t ucBufferSize );
#line 23 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/uarthandler.h"
enum{
 UART_CMD_WHO = 0,
 UART_CMD_SEND,
 UART_CMD_END,
 UART_CMD_STAGE,
 UART_CMD_REBOOT,
 UART_CMD_PING,
 UART_CMD_TEST,
 UART_CMD_REMOVE,
 UART_CMD_CHANNEL,
 UART_CMD_GET,
 UART_CMD_STATUS,
 UART_CMD_INFO,
 UART_CMD_DEVICE_INFO,
 UART_CMD_SEARCH,
 UART_CMD_OVERRIDE,
 UART_CMD_RESET_FTY,
 UART_CMD_OVERRIDE_SET,
 UART_CMD_DISCOVER,
 UART_CMD_FIND,
 UART_CMD_UNBLOCK,
 UART_CMD_SET_TX_POWER,
 UART_Commands
} UARTCommandsTable;
#line 51 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/uarthandler.h"
void vUARTTxInit();

void vUARTRxInit();

void vUARTRxMessage();

void vUARTCommands( uint8_t * pcInBuffer );
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/buttonhandler.h"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/main.h"
#line 24 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/buttonhandler.h"
void vButtonSetup();
#line 28 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/dongle.h"
void vDongleLoop();
#line 43 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/dongle.c"
void vDongleLoop(){
 vUARTRxInit();




  PrintOut( vDebugPrint , "[ APP ] Start\r\n", ( ( void * )0 )  ) ;


 while( 1 ){
 if( ucUARTDataReady == 1 ){
 ucUARTDataReady = 0;
 vUARTRxMessage();
 }
 if( ucRF4463GetIRQFlag() == 1 ){

 vRF4463MesageHandler();
 vRF4463ResetIRQFlag();
 }
 }
}
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/uarthandler.c"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/uarthandler.h"
#line 26 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/uarthandler.c"
uint8_t pcTxUARTBuffer[  2048  ];
uint8_t pcRxUARTBuffer[  2048  ];

uint8_t pcTxRF4463AuxBuffer[  64  ];
uint8_t pcRxRF4463AuxBuffer[  64  ];

uint16_t usBufferCounter = 0;
uint16_t usPosition = 0;
uint16_t usUARTMessageLength = 0;

uint8_t ucTempByteUART = 0;

uint8_t * pcUARTCommand[] = {
 "IFACE",
 "SEND",
 "CLOSE",
 "GET_STAGE",
 "REINIT",
 "PING",
 "TEST",
 "REMOVE",
 "CHANNEL",
 "GET_CHANNEL",
 "STATUS",
 "INFO",
 "DEVICEINFO",
 "SEARCH",
 "OVERRIDE",
 "RESET_FTY",
 "SET_FTY",
 "DISCOVER",
 "FIND",
 "SEND_UNBLOCK",
 "SETPOWER"
};
#line 65 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/uarthandler.c"
extern RadioParameters_t xRadioParameters;
#line 72 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/uarthandler.c"
void vUARTISR() iv IVT_INT_USART1 ics ICS_AUTO{
  GPIOC_ODR._GPIO_PIN_8  =~  GPIOC_ODR._GPIO_PIN_8 ;

 if( USART1_SRbits.RXNE == 1 ){
 ucTempByteUART = USART1_DR;
 if( ucTempByteUART == '\n' ){
 pcRxUARTBuffer[ usUARTMessageLength++ ] = ucTempByteUART;
 ucUARTDataReady = 1;
 ucTempByteUART = 0;
  GPIOC_ODR._GPIO_PIN_8  =  0 ;
 }
 else{
 pcRxUARTBuffer[ usUARTMessageLength++ ] = ucTempByteUART;
 ucTempByteUART = 0;
 }
 }
 if( USART1_SRbits.ORE == 1 ){
  PrintOut( vDebugPrint , "[ IRQ ] UART Overrun\r\n", ( ( void * )0 )  ) ;
 ucTempByteUART = USART1_SR;
 ucTempByteUART = USART1_DR;
  GPIOC_ODR._GPIO_PIN_8  =  0 ;
 }
}
#line 102 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/uarthandler.c"
void vUARTTxInit(){
 UART1_Init_Advanced( 921600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10 );
}
#line 109 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/uarthandler.c"
void vUARTRxInit(){
 USART1_CR1bits.RE = 1;
 USART1_CR1bits.RXNEIE = 1;

 NVIC_IntEnable( IVT_INT_USART1 );
}
#line 119 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/uarthandler.c"
void vUARTRxMessage(){
 uint16_t usCounter = 0;






  PrintOut( vDebugPrint , "[ UART RX ] Packet: %s", pcRxUARTBuffer ) ;

 vUARTCommands( pcRxUARTBuffer );

 memset( pcRxUARTBuffer, '\0', sizeof( pcRxUARTBuffer ) );
 usUARTMessageLength = 0;
}
#line 138 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/uarthandler.c"
void vUARTCommands( uint8_t * pcInBuffer ){
 uint8_t ucCommandCounter = 0;
 uint8_t ucCounter = 0;
 uint8_t ucPosition = 0;
 uint8_t pcTempBuffer[ 50 ];

 uint8_t pcTempTxBuffer[  64  ];

 uint16_t usTempData = 0;
 uint8_t ucDeviceModel = 0;

 uint16_t usTempChannel = 0;
 uint16_t usTempNetwork = 0;
 uint8_t ucIgnoreNetwork = 0;

 for( ucCommandCounter = 0; ucCommandCounter < UART_Commands; ucCommandCounter++ ){
 if( strstr( pcInBuffer, pcUARTCommand[ ucCommandCounter ] ) ){
 switch( ucCommandCounter ){
 case UART_CMD_WHO:
 UART1_Write_Text( "DONGLE\r\n" );
 Sound_Play( 1000, 100 );
 Delay_ms( 30 );
 Sound_Play( 1000, 100 );
 break;
 case UART_CMD_SEND:
  PrintOut( vDebugPrint , "[ UART ] Send Message\r\n", ( ( void * )0 )  ) ;


 memset( pcTempBuffer, '\0', 50 );

 ucPosition = 5;
 for( ucCounter = 0; ucCounter < usUARTMessageLength; ucCounter++ ){
 if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
 break;
 }
 pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
 }
 vRF4463SetNode(  254  );
 vRF4463TxMessage( pcTempBuffer, ucCounter,  255 , TABLE_RF_TEST, RF_TEST_QR );
 break;
 case UART_CMD_END:
  PrintOut( vDebugPrint , "[ UART ] End Factory Stage\r\n", ( ( void * )0 )  ) ;


 memset( pcSentQR, '\0', 15 );

 ucPosition = 6;

 for( ucCounter = 0; ucCounter < usUARTMessageLength; ucCounter++ ){
 if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
 break;
 }
 pcSentQR[ ucCounter ] = pcInBuffer[ ucPosition++ ];
 }

 vRF4463SetNode(  254  );
 vRF4463TxMessage( pcSentQR, ucCounter,  255 , TABLE_RF_TEST, RF_TEST_OK );
 break;
 case UART_CMD_STAGE:
  PrintOut( vDebugPrint , "[ UART ] Get Stage\r\n", ( ( void * )0 )  ) ;

 vRf4463SetChannels(  0 ,  0  );
 vRf4463SetNetwork(  1  );
 vRF4463SetNode(  254  );

 vRF4463TxMessage(  ( ( void * )0 ) ,  ( ( void * )0 ) ,  255 , TABLE_RF_TEST, RF_TEST_STAGE );
 break;
 case UART_CMD_REBOOT:
  PrintOut( vDebugPrint , "[ UART ] Reboot\r\n", ( ( void * )0 )  ) ;

  GPIOC_ODR._GPIO_PIN_8  = 0;
  GPIOC_ODR._GPIO_PIN_7  = 0;
  GPIOC_ODR._GPIO_PIN_6  = 1;

 Delay_ms( 1000 );
 SystemReset();
 break;
 case UART_CMD_PING:
  PrintOut( vDebugPrint , "[ UART ] Ping\r\n", ( ( void * )0 )  ) ;
 vRF4463SetNode(  1  );
 vRF4463TxMessage(  ( ( void * )0 ) ,  ( ( void * )0 ) ,  2 , TABLE_RF_TEST, RF_TEST_DEVICE_PING );
 break;
 case UART_CMD_TEST:
  PrintOut( vDebugPrint , "[ UART ] Test\r\n", ( ( void * )0 )  ) ;
 memset( pcTempBuffer, '\0', 50 );

 ucPosition = 5;

 for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
 pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
 pcTempQR[ ucCounter ] = pcTempBuffer[ ucCounter ];
 }

 for( ucSearchedModelId = 0; ucSearchedModelId < DEVICE_MODEL_ID_TOTAL; ucSearchedModelId++ ){
 if( memcmp( pcTempQR, pcModelQRPrefix[ ucSearchedModelId ], 2 ) == 0 ){
 break;
 }
 }

 vRF4463SetNode(  1  );
 vRF4463TxMessage( pcTempBuffer, strlen( pcTempBuffer ),  2 , TABLE_RF_SETUP, RF_SETUP_FIND_BY_QR );
 break;
 case UART_CMD_REMOVE:
  PrintOut( vDebugPrint , "[ UART ] Remove\r\n", ( ( void * )0 )  ) ;

 memset( pcTempBuffer, '\0', 50 );

 ucPosition = 7;

 for( ucCounter = 0; ; ucCounter++ ){
 if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
 break;
 }
 pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
 }

 usTempData = atoi( pcTempBuffer );
 vRF4463SetNode(  1  );
 vRF4463TxMessage(  ( ( void * )0 ) ,  ( ( void * )0 ) , usTempData, TABLE_RF_SETUP, RF_SETUP_REMOVE );
 break;
 case UART_CMD_CHANNEL:
  PrintOut( vDebugPrint , "[ UART ] Set Channel\r\n", ( ( void * )0 )  ) ;
 memset( pcTempBuffer, '\0', 50 );

 ucPosition = 8;

 ucRf4463EnterStandbyMode();

 for( ucCounter = 0; ; ucCounter++ ){
 if( pcInBuffer[ ucPosition ] == ',' ){
 ucPosition++;
 break;
 }
 if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
 ucIgnoreNetwork = 1;
 break;
 }
 pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
 }

 usTempChannel = atoi( pcTempBuffer );

 if( ucIgnoreNetwork == 0 ){
 for( ucCounter = 0; ; ucCounter++ ){
 if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
 break;
 }
 pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
 }
 usTempNetwork = atoi( pcTempBuffer );

 vRf4463SetChannels( usTempChannel, usTempChannel );
 vRf4463SetNetwork( usTempNetwork );
 }
 else{
 vRf4463SetChannels( usTempChannel, usTempChannel );
 vRf4463SetNetwork( usTempChannel );
 }
 ucRf4463RxInit();
 break;
 case UART_CMD_INFO:
  PrintOut( vDebugPrint , "[ UART ] Get Device Info\r\n", ( ( void * )0 )  ) ;
#line 325 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/uarthandler.c"
 break;
 case UART_CMD_SEARCH:
  PrintOut( vDebugPrint , "[ UART ] Search\r\n", ( ( void * )0 )  ) ;
 vRF4463SetNode(  254  );
 vRF4463TxMessage(  ( ( void * )0 ) ,  ( ( void * )0 ) ,  254 , TABLE_RF_TEST,  200  );
 break;
 case UART_CMD_OVERRIDE:
  PrintOut( vDebugPrint , "[ UART ] Override\r\n", ( ( void * )0 )  ) ;
 break;
 case UART_CMD_RESET_FTY:
  PrintOut( vDebugPrint , "[ UART ] Reset Factory\r\n", ( ( void * )0 )  ) ;
 break;
 case UART_CMD_OVERRIDE_SET:
  PrintOut( vDebugPrint , "[ UART ] Set Override\r\n", ( ( void * )0 )  ) ;
 break;
 case UART_CMD_DISCOVER:
  PrintOut( vDebugPrint , "[ UART ] Discover\r\n", ( ( void * )0 )  ) ;
 vRF4463SetNode(  254  );
 vRF4463TxMessage(  ( ( void * )0 ) ,  ( ( void * )0 ) ,  255 , TABLE_RF_SETUP, RF_SETUP_FTY_DISCOVER );
 case UART_CMD_FIND:
  PrintOut( vDebugPrint , "[ UART ] Find in Channel\r\n", ( ( void * )0 )  ) ;
 vRF4463SetNode(  1  );
 vRF4463TxMessage(  ( ( void * )0 ) ,  ( ( void * )0 ) ,  255 , TABLE_RF_TEST, RF_TEST_CHANNEL );
 break;
 case UART_CMD_UNBLOCK:
 break;
 case UART_CMD_SET_TX_POWER:
  PrintOut( vDebugPrint , "[ UART ] Set Tx Power\r\n", ( ( void * )0 )  ) ;
 memset( pcTempBuffer, '\0', 20 );
 ucPosition = 9;
 for( ucCounter = 0; ; ucCounter++ ){
 if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
 break;
 }
 pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
 }
 usTempData = atoi( pcTempBuffer );
 ucRf4463SetTxPower( usTempData );
 break;
 default:
  PrintOut( vDebugPrint , "Invalid Command\r\n", ( ( void * )0 )  ) ;
 break;
 }
 }
 }
}
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/debug.c"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/debug.h"
#line 79 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/debug.c"
 void vDebugInit(){
 UART1_Init_Advanced( 115200, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10 );
 }
#line 89 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/debug.c"
 void vDebugPrint( uint8_t ucPrintData ){
 UART1_Write( ucPrintData );
 }
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/utils.c"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/utils.h"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/main.h"
#line 49 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/utils.h"
uint8_t ucASCIIToByte( uint8_t * pcASCIIBuffer );
#line 61 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/utils.h"
void vASCIIToHex( uint8_t *pcHexConvertBuffer, uint8_t *pcASCIIConvertBuffer, uint8_t ucConversionLength );
#line 73 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/utils.h"
void vHexToASCII( uint8_t *pcASCIIConvertBuffer, uint8_t *pcHexConvertBuffer, uint8_t ucConversionLength );
#line 85 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/utils.h"
void vBufferSetToZero( uint8_t * pcBufferToClean, uint16_t uslength );
#line 97 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/utils.h"
void vBufferSetTo255( uint8_t * pcBufferToClean, uint16_t uslength );
#line 109 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/utils.h"
void vBufferSetToValue( uint8_t * pcBufferToClean, uint8_t ucValue, uint16_t uslength );
#line 121 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/utils.h"
void vSerializeUUID( uint8_t * pcTextConvertBuffer, uint8_t * pcHexConvertBuffer );
#line 133 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/utils.h"
void vSerializeMACAddress( uint8_t * pcTextConvertBuffer, uint8_t * pcHexConvertBuffer );
#line 145 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/utils.h"
void vSerializeIPAddress( uint8_t * pcTextConvertBuffer, uint8_t * pcHexConvertBuffer );
#line 25 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/utils.c"
const uint8_t pcHexChar[16] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};

uint8_t ucMSBNibble = 0;
uint8_t ucLSBNibble = 0;
#line 41 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/utils.c"
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
#line 61 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/utils.c"
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
#line 85 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/utils.c"
void vHexToASCII( uint8_t *pcASCIIConvertBuffer, uint8_t *pcHexConvertBuffer, uint8_t ucConversionLength ){
 uint8_t ucHexConvCounter = 0;

 for( ucHexConvCounter = 0; ucHexConvCounter < ucConversionLength; ucHexConvCounter++ ){
 pcASCIIConvertBuffer[ ucHexConvCounter * 2 ] = pcHexChar[ pcHexConvertBuffer[ ucHexConvCounter ] >> 4 ];
 pcASCIIConvertBuffer[ ( ucHexConvCounter * 2 ) + 1 ] = pcHexChar[ ( pcHexConvertBuffer[ ucHexConvCounter ] & 0x0F ) ];
 }
}
#line 97 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/utils.c"
void vBufferSetToZero( uint8_t * pcBufferToClean, uint16_t uslength ){
 uint16_t usPosition = 0;

 for( usPosition = 0; usPosition < uslength; usPosition++ ){
 pcBufferToClean[ usPosition ] = 0x00;
 }
}
#line 108 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/utils.c"
void vBufferSetTo255( uint8_t * pcBufferToClean, uint16_t uslength ){
 uint16_t usPosition = 0;

 for( usPosition = 0; usPosition < uslength; usPosition++ ){
 pcBufferToClean[ usPosition ] = 0xFF;
 }
}
#line 119 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/utils.c"
void vBufferSetToValue( uint8_t * pcBufferToClean, uint8_t ucValue, uint16_t uslength ){
 uint16_t usPosition = 0;

 for( usPosition = 0; usPosition < uslength; usPosition++ ){
 pcBufferToClean[ usPosition ] = ucValue;
 }
}
#line 130 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/utils.c"
void vSerializeUUID( uint8_t * pcTextConvertBuffer, uint8_t * pcHexConvertBuffer ){
 uint8_t ucCounter = 0;

 for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
 pcTextConvertBuffer[ ucCounter * 2 ] = pcHexChar[ pcHexConvertBuffer[ ucCounter ] >> 4 ];
 pcTextConvertBuffer[ ( ucCounter * 2 ) + 1 ] = pcHexChar[ pcHexConvertBuffer[ ucCounter ] & 0x0F ];
 }
}
#line 142 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/utils.c"
void vSerializeMACAddress( uint8_t * pcTextConvertBuffer, uint8_t * pcHexConvertBuffer ){
 uint16_t usCounter = 0;
 uint8_t pcDeviceMAC[ 12 ];

 vHexToASCII( pcDeviceMAC, pcHexConvertBuffer, 6 );

 for( usCounter = 0; usCounter < 6; usCounter++ ){
 pcTextConvertBuffer[ usCounter * 3 ] = pcDeviceMAC[ usCounter * 2 ];
 pcTextConvertBuffer[ ( usCounter * 3 ) + 1 ] = pcDeviceMAC[ ( usCounter * 2 ) + 1 ];
 if( usCounter != 5 ){
 pcTextConvertBuffer[ ( usCounter * 3 ) + 2 ] = ':';
 }
 }
 pcTextConvertBuffer[ 18 ] = '\0';
}
#line 161 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/utils.c"
void vSerializeIPAddress( uint8_t * pcTextConvertBuffer, uint8_t * pcHexConvertBuffer ){
 uint8_t ucCounter = 0;
 uint8_t pcConvertText[ 7 ];

 memset( pcTextConvertBuffer, '\0', sizeof( pcTextConvertBuffer ) );

 for( ucCounter = 0; ucCounter < 4; ucCounter++ ){

 ByteToStr( pcHexConvertBuffer[ ucCounter ], pcConvertText );

 strcat( pcTextConvertBuffer, Ltrim( pcConvertText ) );

 if( ucCounter != 3 ){
 strcat( pcTextConvertBuffer, "." );
 }
 }
}
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/xorcipher.c"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/xorcipher.h"
#line 26 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/xorcipher.c"
const uint8_t pcXORRFKey[ 50 ] = {
 0xE2, 0x77, 0x70, 0xA8, 0x0A, 0xF8, 0xDA, 0x9A, 0x29, 0x9A, 0xA6, 0x74, 0xB2, 0x1A, 0x09, 0x02,
 0x0B, 0xA6, 0xFF, 0xAB, 0xC7, 0x13, 0xDE, 0xD2, 0x18, 0x71, 0x2F, 0xC2, 0x77, 0x8D, 0x5C, 0xC4,
 0xF7, 0x52, 0x4C, 0x9C, 0xE0, 0x4A, 0x2F, 0x30, 0xE1, 0x35, 0x56, 0xF6, 0xC5, 0xB1, 0xA4, 0x71,
 0x69, 0x04
};
#line 49 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/xorcipher.c"
void vXORRFMessage( uint8_t * pcBuffer, uint8_t * pcXORBuffer, uint8_t ucBufferSize ){
 uint8_t ucKeyPosition = 0;
 uint8_t ucBufferPosition = 0;

 for( ucBufferPosition = 0; ucBufferPosition < ucBufferSize; ucBufferPosition++ ){
 pcXORBuffer[ ucBufferPosition ] = pcBuffer[ ucBufferPosition ] ^ pcXORRFKey[ ucKeyPosition++ ];
 }
}
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/flashhandler.c"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/flashw25q128jv.c"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/flashw25q128jv.h"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/main.h"
#line 32 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/flashw25q128jv.h"
enum{
 Select_Flash_1 = 1,
 Select_Flash_2 = 2,
 Select_Flash
};
#line 41 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/flashw25q128jv.h"
void vW25Q128JVInit();
#line 46 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/flashw25q128jv.h"
void vFlashWriteEnable( uint8_t ucMemorySelected );

uint8_t ucFlashIsWriteBusy( uint8_t ucMemorySelected );

void vFlashWriteByte( uint8_t ucMemorySelected, uint8_t pcData, uint32_t ulMemoryAddress );

void vFlashWriteWord( uint8_t ucMemorySelected, uint16_t pcData, uint32_t ulMemoryAddress );

uint8_t ucFlashWriteArray( uint8_t ucMemorySelected, uint8_t * pcData, uint16_t usBufferLength, const uint32_t ulMemoryAddress );
#line 59 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/flashw25q128jv.h"
uint8_t ucFlashReadByte( uint8_t ucMemorySelected, uint32_t ulMemoryAddress );

uint16_t usFlashReadWord( uint8_t ucMemorySelected, uint32_t ulMemoryAddress );

void vFlashReadArray( uint8_t ucMemorySelected, uint8_t * pcReceiverBuffer, uint16_t usBufferLength, uint32_t ulMemoryAddress );
#line 68 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/flashw25q128jv.h"
uint8_t ucFlashReadId( uint8_t ucMemorySelected );

void vFlashResetWriteProtection( uint8_t ucMemorySelected );

void vFlashChipErase( uint8_t ucMemorySelected );

void vFlashSectorErase( uint8_t ucMemorySelected, uint32_t ulMemoryAddress );

void vFlashReset( uint8_t ucMemorySelected );
#line 43 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/flashw25q128jv.c"
void vW25Q128JVInit( ){
  GPIOA_ODR._GPIO_PIN_4  = 1;
}
#line 50 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/flashw25q128jv.c"
void vFlashWriteEnable( uint8_t ucMemorySelected ){
  GPIOA_ODR._GPIO_PIN_4  = 0;
 SPI1_Write(  0x06  );
  GPIOA_ODR._GPIO_PIN_4  = 1;
}
#line 59 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/flashw25q128jv.c"
uint8_t ucFlashIsWriteBusy( uint8_t ucMemorySelected ){
 uint8_t ucTemp = 0;

  GPIOA_ODR._GPIO_PIN_4  = 0;
 SPI1_Write(  0x05  );
 ucTemp = SPI1_Read( 0 );
  GPIOA_ODR._GPIO_PIN_4  = 1;

 return ( ucTemp & 0x01 );
}
#line 73 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/flashw25q128jv.c"
void vFlashWriteByte( uint8_t ucMemorySelected, uint8_t pcData, uint32_t ulMemoryAddress ){
 vFlashWriteEnable( ucMemorySelected );

  GPIOA_ODR._GPIO_PIN_4  = 0;
 SPI1_Write(  0x02  );
 SPI1_Write(  ((char *)&ulMemoryAddress)[2]  );
 SPI1_Write(  ((char *)&ulMemoryAddress)[1]  );
 SPI1_Write(  ((char *)&ulMemoryAddress)[0]  );
 SPI1_Write( pcData );
  GPIOA_ODR._GPIO_PIN_4  = 1;

 while( ucFlashIsWriteBusy( ucMemorySelected ) );
}
#line 90 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/flashw25q128jv.c"
void vFlashWriteWord( uint8_t ucMemorySelected, uint16_t pcData, uint32_t ulMemoryAddress ){
 vFlashWriteByte( ucMemorySelected,  ((char *)&pcData)[1] , ulMemoryAddress );
 vFlashWriteByte( ucMemorySelected,  ((char *)&pcData)[0] , ulMemoryAddress + 1 );
}
#line 98 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/flashw25q128jv.c"
uint8_t ucFlashWriteArray( uint8_t ucMemorySelected, uint8_t * pcData, uint16_t usBufferLength, const uint32_t ulMemoryAddress ){
 uint32_t ulFlashAddress = 0;
 uint16_t usBufferCounter = 0;
 uint8_t ucTempValue = 0;

 ulFlashAddress = ulMemoryAddress;

 for( usBufferCounter = 0; usBufferCounter < usBufferLength; usBufferCounter++ ){
 vFlashWriteByte( ucMemorySelected, pcData[ usBufferCounter ], ulFlashAddress );
 ulFlashAddress++;
 }
 UART1_Write( '\r' );
 UART1_Write( '\n' );

 ulFlashAddress = ulMemoryAddress;

 for( usBufferCounter = 0; usBufferCounter < usBufferLength; usBufferCounter++ ){
 ucTempValue = 0;
 ucTempValue = ucFlashReadByte( ucMemorySelected, ulFlashAddress );
 if( pcData[ usBufferCounter ] != ucTempValue ){
 return 0;
 }
 ulFlashAddress++;
 }
 UART1_Write( '\r' );
 UART1_Write( '\n' );

 return 1;
}
#line 131 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/flashw25q128jv.c"
uint8_t ucFlashReadByte( uint8_t ucMemorySelected, uint32_t ulMemoryAddress ){
 uint8_t ucTemp = 0;

  GPIOA_ODR._GPIO_PIN_4  = 0;
 SPI1_Write(  0x03  );
 SPI1_Write(  ((char *)&ulMemoryAddress)[2]  );
 SPI1_Write(  ((char *)&ulMemoryAddress)[1]  );
 SPI1_Write(  ((char *)&ulMemoryAddress)[0]  );
 ucTemp = SPI1_Read( 0 );
  GPIOA_ODR._GPIO_PIN_4  = 1;

 return ucTemp;
}
#line 148 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/flashw25q128jv.c"
uint16_t usFlashReadWord( uint8_t ucMemorySelected, uint32_t ulMemoryAddress ){
 uint16_t usTemp = 0;

  ((char *)&usTemp)[1]  = ucFlashReadByte( ucMemorySelected, ulMemoryAddress );
  ((char *)&usTemp)[0]  = ucFlashReadByte( ucMemorySelected, ulMemoryAddress + 1 );

 return usTemp;
}
#line 160 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/flashw25q128jv.c"
void vFlashReadArray( uint8_t ucMemorySelected, uint8_t * pcReceiverBuffer, uint16_t usBufferLength, uint32_t ulMemoryAddress ){
  GPIOA_ODR._GPIO_PIN_4  = 0;

 SPI1_Write(  0x03  );
 SPI1_Write(  ((char *)&ulMemoryAddress)[2]  );
 SPI1_Write(  ((char *)&ulMemoryAddress)[1]  );
 SPI1_Write(  ((char *)&ulMemoryAddress)[0]  );

 while( usBufferLength-- ){
 *pcReceiverBuffer++ = SPI1_Read( 0 );
 }

  GPIOA_ODR._GPIO_PIN_4  = 1;
}
#line 178 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/flashw25q128jv.c"
uint8_t ucFlashReadId( uint8_t ucMemorySelected ){
 uint8_t ucTemp = 0;

  GPIOA_ODR._GPIO_PIN_4  = 0;

 SPI1_Write(  0x9F  );
 ucTemp = SPI1_Read( 0 );

  GPIOA_ODR._GPIO_PIN_4  = 1;

 return ucTemp;
}
#line 194 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/flashw25q128jv.c"
void vFlashResetWriteProtection( uint8_t ucMemorySelected ){
  GPIOA_ODR._GPIO_PIN_4  = 0;
 SPI1_Write(  0x06  );
  GPIOA_ODR._GPIO_PIN_4  = 1;

  GPIOA_ODR._GPIO_PIN_4  = 0;
 SPI1_Write(  0x06  );
 SPI1_Write( 0 );
  GPIOA_ODR._GPIO_PIN_4  = 1;
}
#line 208 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/flashw25q128jv.c"
void vFlashChipErase( uint8_t ucMemorySelected ){

 vFlashWriteEnable( ucMemorySelected );

  GPIOA_ODR._GPIO_PIN_4  = 0;
 SPI1_Write(  0xC7  );
  GPIOA_ODR._GPIO_PIN_4  = 1;

 while( ucFlashIsWriteBusy( ucMemorySelected ) );
}
#line 222 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/flashw25q128jv.c"
void vFlashSectorErase( uint8_t ucMemorySelected, uint32_t ulMemoryAddress ){

 vFlashWriteEnable( ucMemorySelected );

  GPIOA_ODR._GPIO_PIN_4  = 0;

 SPI1_Write(  0xD8  );
 SPI1_Write(  ((char *)&ulMemoryAddress)[2]  );
 SPI1_Write(  ((char *)&ulMemoryAddress)[1]  );
 SPI1_Write(  ((char *)&ulMemoryAddress)[0]  );

  GPIOA_ODR._GPIO_PIN_4  = 1;

 while( ucFlashIsWriteBusy( ucMemorySelected ) );
}
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.h"
#line 26 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
static uint8_t ucRF4463IRQ = 0;

uint8_t ucSourceNode = 0;
uint8_t ucRFTxEventPending = 0;

uint8_t pcRF4463TxBuffer[  64  ] = { 0x00 };
uint8_t pcRF4463RxBuffer[  64  ] = { 0x00 };
#line 36 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
RadioParameters_t xRadioParameters;
#line 44 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
void RFISR() iv IVT_INT_EXTI15_10 ics ICS_AUTO{
 if( EXTI_PR.B12 ){
 EXTI_PR.B12 |= 1;
  GPIOC_ODR._GPIO_PIN_6  =  1 ;
 ucRF4463IRQ = 1;
 ucRf4463ClearInterrupts();
 }
}
#line 59 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
void vRF4463MesageHandler(){
 uint16_t usCounter = 0;

 if( ucRFTxEventPending == 0 ){

 vBufferSetToZero( pcRF4463RxBuffer,  64  );
 ucRf4463RxPacket( pcRF4463RxBuffer );
 if( pcRF4463RxBuffer[  0  ] > 0 ){
#line 70 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
 if( xRF4463GetLastRSSI() <=  -100  ){
  PrintOut( vDebugPrint , "[ RF4463 ] Message may be broken\r\n", ( ( void * )0 )  ) ;
 }
#line 77 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
 UART1_Write_Text( "[ RF4463 Rx ] Packet: " );
 for( usCounter = 0; usCounter < pcRF4463RxBuffer[  0  ]; usCounter++ ){
 UART1_Write( pcRF4463RxBuffer[ usCounter ] );
 }
 UART1_Write( '\r' );
 UART1_Write( '\n' );
#line 96 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
 }
 }
 else{

 ucRFTxEventPending = 0;
 }

  GPIOC_ODR._GPIO_PIN_6  =  0 ;

 ucRf4463RxInit();
}
#line 111 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
void vRF4463TxMessage( uint8_t * pcOutBuffer, uint8_t ucLength, uint8_t ucRemoteNode, uint8_t ucTable, uint8_t ucCommand ){
 uint8_t ucCounter = 0;
 uint8_t pcTemp[ 7 ];
#line 117 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
 if( ucRFTxEventPending == 1 ){
  PrintOut( vDebugPrint , "[ RF4463 ] HW in use\r\n", ( ( void * )0 )  ) ;
 return;
 }
#line 125 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
 vBufferSetToZero( pcRF4463TxBuffer,  64  );
#line 129 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
 if( ( ucLength +  5  ) >=  64  ){
  PrintOut( vDebugPrint , "[ RF4463 ] Buffer Out of Size\r\n", ( ( void * )0 )  ) ;
 return;
 }
#line 136 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
 pcRF4463TxBuffer[  0  ] =  5  + ucLength;
 pcRF4463TxBuffer[  1  ] = ucRemoteNode;
 pcRF4463TxBuffer[  2  ] = ucSourceNode;
 pcRF4463TxBuffer[  3  ] = ucTable;
 pcRF4463TxBuffer[  4  ] = ucCommand;
#line 144 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
 if( ucLength > 0 ){
 for( ucCounter = 0; ucCounter < ucLength; ucCounter++ ){
 pcRF4463TxBuffer[  5  + ucCounter ] = pcOutBuffer[ ucCounter ];
 }
 }
#line 163 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
 ucRf4463TxPacket( pcRF4463TxBuffer, pcRF4463TxBuffer[  0  ] );
 ucRFTxEventPending = 1;
}
#line 170 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
void vRF4463SetNode( uint8_t ucNode ){
 ucSourceNode = ucNode;
}
#line 177 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
uint8_t ucRF4463Setup( uint8_t ucRxChannel, uint8_t ucTxChannel, uint16_t usNetwork, uint8_t ucTxPower ){
 uint8_t ucRetries = 0;
 int8_t ucIsRFAvailable =  1 ;
#line 183 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
 SPI2_Init_Advanced( _SPI_FPCLK_DIV8, _SPI_MASTER | _SPI_8_BIT | _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION | _SPI_MSB_FIRST |
 _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI2_PB13_14_15 );
#line 189 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
 GPIO_Digital_Input( &GPIOC_BASE, _GPIO_PINMASK_12 );

 GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_12 );
 GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_11 );
 GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_11 );
 GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_10 );
#line 201 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
 RCC_APB2ENRbits.AFIOEN = 1;
#line 205 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
 AFIO_EXTICR4 |= 0x0002;
#line 209 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
 EXTI_IMR.B12 |= 1;
 EXTI_FTSR.B12 |= 1;
#line 214 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
  PrintOut( vDebugPrint , "[ RF4463 ] Parameters\r\n", ( ( void * )0 )  ) ;
  PrintOut( vDebugPrint , "[ RF4463 ] Tx Channel: %d\r\n", ucTxChannel ) ;
  PrintOut( vDebugPrint , "[ RF4463 ] Rx Channel: %d\r\n", ucRxChannel ) ;
  PrintOut( vDebugPrint , "[ RF4463 ] Network: %d\r\n", usNetwork ) ;
  PrintOut( vDebugPrint , "[ RF4463 ] Tx Power: %d\r\n", ucTxPower ) ;
#line 222 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
 vRf4463Init( ucRxChannel, ucTxChannel, usNetwork, ucTxPower, RF4463_FREQUENCY_915MHz );
#line 227 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
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
#line 240 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
 if( ucRetries == 15 ){
  PrintOut( vDebugPrint , "[ RF4463 ] Setup Retries Excedded\r\n", ( ( void * )0 )  ) ;

 }
#line 247 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
 while( ucIsRFAvailable ){
 ucIsRFAvailable = ucRf4463EnterStandbyMode();
 }
#line 253 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
 NVIC_IntEnable( IVT_INT_EXTI15_10 );
 ucRf4463ClearInterrupts();
 ucRf4463RxInit();
  PrintOut( vDebugPrint , "[ RF4463 ] Ready\r\n", ( ( void * )0 )  ) ;
}
#line 265 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
void vRF4463RxCommand(){
 uint8_t ucCounter = 0;
 uint8_t ucPosition =  5 ;

 uint8_t pcTempBuffer[  64  ] = { 0x00 };

 uint8_t pcQR[ 13 ] = { 0x00 };
 uint8_t pcUIDText[ 25 ] = { 0x00 };
 uint8_t pcUIDHex[ 13 ] = { 0x00 };
#line 277 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
 switch( pcRF4463RxBuffer[  3  ] ){
#line 281 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
 case TABLE_RF_TEST:
  PrintOut( vDebugPrint , "[ RF4463 ] Test Table\r\n", ( ( void * )0 )  ) ;








 break;
#line 295 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
 case TABLE_RF_SETUP:
  PrintOut( vDebugPrint , "[ RF4463 ] Setup Table\r\n", ( ( void * )0 )  ) ;
 switch( pcRF4463RxBuffer[  4  ] ){
 case RF_SETUP_FIND_BY_QR:
 if( pcRF4463RxBuffer[  2  ] ==  1  ){
  PrintOut( vDebugPrint , "[ RF4463 ] Hub Request\r\n", ( ( void * )0 )  ) ;
 for( ucCounter = 0; ucCounter <  12 ; ucCounter++ ){
 pcQR[ ucCounter ] = pcRF4463RxBuffer[ ucPosition++ ];
 }
  PrintOut( vDebugPrint , "[ RF4463 ] Request QR: %s\r\n", pcQR ) ;
 }
 else if( pcRF4463RxBuffer[  2  ] ==  2  ){
  PrintOut( vDebugPrint , "[ RF4463 ] Device Response\r\n", ( ( void * )0 )  ) ;
 for( ucCounter = 0; ucCounter <  12 ; ucCounter++ ){
 pcUIDHex[ ucCounter ] = pcRF4463RxBuffer[ ucPosition++ ];
 }
 vHexToASCII( pcUIDText, pcUIDHex,  12  );
  PrintOut( vDebugPrint , "[ RF4463 ] UID: %s\r\n", pcUIDText ) ;
 if( pcRF4463RxBuffer[  0  ] ==  24  ){
  PrintOut( vDebugPrint , "[ RF4463 ] Detected Loads: %d\r\n", pcRF4463RxBuffer[ 17  ] ) ;
  PrintOut( vDebugPrint , "[ RF4463 ] Load 1: %d\r\n", pcRF4463RxBuffer[ 18  ] ) ;
  PrintOut( vDebugPrint , "[ RF4463 ] Load 2: %d\r\n", pcRF4463RxBuffer[ 19  ] ) ;
  PrintOut( vDebugPrint , "[ RF4463 ] Load 3: %d\r\n", pcRF4463RxBuffer[ 20  ] ) ;
  PrintOut( vDebugPrint , "[ RF4463 ] Version: %d.%d.%d\r\n", pcRF4463RxBuffer[ 21  ], pcRF4463RxBuffer[ 22  ], pcRF4463RxBuffer[ 23  ] ) ;
 }
 else{
  PrintOut( vDebugPrint , "[ RF4463 ] Load Status: %d\r\n", pcRF4463RxBuffer[ 18  ] ) ;
  PrintOut( vDebugPrint , "[ RF4463 ] Version: %d.%d.%d\r\n", pcRF4463RxBuffer[ 19  ], pcRF4463RxBuffer[ 20  ], pcRF4463RxBuffer[ 21  ] ) ;
 }
 }
 break;
 default:
  PrintOut( vDebugPrint , "[ RF4463 ] Unhandled command\r\n", ( ( void * )0 )  ) ;
 return;
 }
 break;
#line 334 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
 case TABLE_RF_OTA:
  PrintOut( vDebugPrint , "[ RF4463 ] OTA Table\r\n", ( ( void * )0 )  ) ;
 switch( pcRF4463RxBuffer[  4  ] ){
 default:
  PrintOut( vDebugPrint , "[ RF4463 ] Unhandled command\r\n", ( ( void * )0 )  ) ;
 return;
 }
 break;
#line 345 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
 case TABLE_RF_GLOBAL:
  PrintOut( vDebugPrint , "[ RF4463 ] Global Table\r\n", ( ( void * )0 )  ) ;
#line 359 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
  PrintOut( vDebugPrint , "[ RF4463 ] Node: %d\r\n", pcRF4463RxBuffer[ 2  ] ) ;





 break;
#line 369 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
 case TABLE_RF_SWITCH:
  PrintOut( vDebugPrint , "[ RF4463 ] Switch Table\r\n", ( ( void * )0 )  ) ;
#line 383 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
  PrintOut( vDebugPrint , "[ RF4463 ] Node: %d\r\n", pcRF4463RxBuffer[ 2  ] ) ;





 break;
#line 393 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
 case TABLE_RF_DIMMER:
  PrintOut( vDebugPrint , "[ RF4463 ] Dimmer Table\r\n", ( ( void * )0 )  ) ;
#line 407 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
  PrintOut( vDebugPrint , "[ RF4463 ] Node: %d\r\n", pcRF4463RxBuffer[ 2  ] ) ;





 break;
#line 417 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
 case TABLE_RF_OUTLET:
  PrintOut( vDebugPrint , "[ RF4463 ] Outlet Table\r\n", ( ( void * )0 )  ) ;
#line 431 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
  PrintOut( vDebugPrint , "[ RF4463 ] Node: %d\r\n", pcRF4463RxBuffer[ 2  ] ) ;





 break;
#line 441 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
 default:
  PrintOut( vDebugPrint , "[ RF4463 ] Unhandled table\r\n", ( ( void * )0 )  ) ;
  PrintOut( vDebugPrint , "[ RF4463 ] Source node:%d\r\n", pcRF4463RxBuffer[ 2  ] ) ;
  PrintOut( vDebugPrint , "[ RF4463 ] Destination node:%d\r\n", pcRF4463RxBuffer[ 1  ] ) ;
  PrintOut( vDebugPrint , "[ RF4463 ] Table: %d\r\n", pcRF4463RxBuffer[ 3  ] ) ;
  PrintOut( vDebugPrint , "[ RF4463 ] Command: %d\r\n", pcRF4463RxBuffer[ 4  ] ) ;
 return;
 }
}
#line 454 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
void vRF4463RxFTY(){
#line 458 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
 uint16_t usCounter = 0;
 uint8_t ucPosition = 0;
 uint8_t pcTempBuffer[  64  ];
 uint8_t pcTempConvBuffer[  64  ];
#line 465 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
 uint8_t pcUIDText[ 25 ];
 uint8_t pcUIDHex[ 13 ];
 uint8_t pcMACText[ 20 ];
 uint8_t pcMACHex[ 12 ];
 uint8_t pcIPText[ 20 ];
 uint8_t pcIPHex[ 6 ];
 uint8_t pcJSONBuffer[ 512 ];
#line 475 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
 if( pcRF4463RxBuffer[  1  ] ==  254  ){
 switch( pcRF4463RxBuffer[  3  ] ){
 case TABLE_RF_TEST:
 switch( pcRF4463RxBuffer[  4  ] ){
 case RF_TEST_LOOP:

 vRF4463SetNode(  254  );
 vRF4463TxMessage( &pcRF4463RxBuffer[  5  ], ( pcRF4463RxBuffer[  0  ] -  5  ),  255 , TABLE_RF_TEST, RF_TEST_LOOP );
 break;
 case RF_TEST_QR:
 UART1_Write_Text( "RCV|" );
 for( usCounter =  5 ; usCounter < pcRF4463RxBuffer[  0  ]; usCounter++ ){
 UART1_Write( pcRF4463RxBuffer[ usCounter ] );
 }
 UART1_Write( '\r' );
 UART1_Write( '\n' );
 break;
 case RF_TEST_OK:
 for( usCounter = 0; usCounter < 12; usCounter++ ){
 pcReceivedQR[ usCounter ] = pcRF4463RxBuffer[  5  + usCounter ];
 }

 if( memcmp( pcReceivedQR, pcSentQR, 12 ) == 0 ){
 UART1_Write_Text( "FINISH|" );
 for( usCounter = 0; usCounter < 12; usCounter++ ){
 UART1_Write( pcReceivedQR[ usCounter ] );
 }
 UART1_Write( '\r' );
 UART1_Write( '\n' );
 }
 break;
 case RF_TEST_MESSAGE:
 UART1_Write_Text( "RCV|" );
 for( usCounter =  5 ; usCounter < pcRF4463RxBuffer[  0  ]; usCounter++ ){
 UART1_Write( pcRF4463RxBuffer[ usCounter ] );
 }
 UART1_Write( '\r' );
 UART1_Write( '\n' );
 break;
 case  200 :

 if( ucSearchActive == 0 ){
 ucSearchActive = 1;
 vTimerSearchLed();
 }
 else{
 ucSearchActive = 0;
 vTimerStop( TIMER_SEARCH );
  GPIOC_ODR._GPIO_PIN_7  =  1 ;
 }
 break;
 case RF_TEST_INFO:
 for( usCounter = 0; usCounter < ( pcRF4463RxBuffer[  0  ] -  5  ); usCounter++ ){
 pcTempBuffer[ usCounter ] = pcRF4463RxBuffer[ usCounter +  5  ];
 }
 memset( pcRxRF4463AuxBuffer, '\0',  64  );
 vXORRFMessage( pcTempBuffer, pcRxRF4463AuxBuffer, usCounter );
 switch( pcRxRF4463AuxBuffer[ ucPosition++ ] ){
 case DEVICE_MODEL_ID_HUB:
 UART1_Write_Text( "QR: " );
 for( usCounter = 0; usCounter < 12; usCounter++ ){
 UART1_Write( pcRxRF4463AuxBuffer[ ucPosition++ ] );
 }
 UART1_Write( '\r' );
 UART1_Write( '\n' );

 for( usCounter = 0; usCounter < 12; usCounter++ ){
 pcUIDHex[ usCounter ] = pcRxRF4463AuxBuffer[ ucPosition++ ];
 }

 vSerializeUUID( pcUIDText, pcUIDHex );

 UART1_Write_Text( "UID: " );
 UART1_Write_Text( pcUIDText );
 UART1_Write( '\r' );
 UART1_Write( '\n' );

 for( usCounter = 0; usCounter < 6; usCounter++ ){
 pcMACHex[ usCounter ] = pcRxRF4463AuxBuffer[ ucPosition++ ];
 }
 vSerializeMACAddress( pcMACText, pcMACHex );
 UART1_Write_Text( "MAC: " );
 UART1_Write_Text( pcMACText );
 UART1_Write( '\r' );
 UART1_Write( '\n' );

 for( usCounter = 0; usCounter < 4; usCounter++ ){
 pcIPHex[ usCounter ] = pcRxRF4463AuxBuffer[ ucPosition++ ];
 }
 vSerializeIPAddress( pcIPText, pcIPHex );
 UART1_Write_Text( "IP: " );
 UART1_Write_Text( pcIPText );
 UART1_Write( '\r' );
 UART1_Write( '\n' );

 memset( pcTempBuffer, '\0',  ( ( void * )0 )  );
 sprintf( pcTempBuffer, "Ver: %d.%d.%d\r\n", pcRxRF4463AuxBuffer[ ucPosition++ ], pcRxRF4463AuxBuffer[ ucPosition++ ], pcRxRF4463AuxBuffer[ ucPosition++ ] );
 UART1_Write_Text( pcTempBuffer );
 break;
 case DEVICE_MODEL_ID_SWITCH:
 break;
 case DEVICE_MODEL_ID_DIMMER:
 break;
 case DEVICE_MODEL_ID_OUTLET:
 break;
 }
 break;
 }
 break;
 case TABLE_RF_SETUP:
 switch( pcRF4463RxBuffer[  4  ] ){
 case RF_SETUP_FTY_DISCOVER:
 memset( pcTempConvBuffer, '\0',  64  );
 memset( pcTempBuffer, '\0',  64  );
 for( usCounter = 0; usCounter < 12; usCounter++ ){
 pcTempBuffer[ usCounter ] = pcRF4463RxBuffer[  5  + usCounter ];
 }

 vHexToASCII( pcTempConvBuffer, pcTempBuffer, 12 );

 UART1_Write_Text( "UID: " );
 UART1_Write_Text( pcTempConvBuffer );
 UART1_Write( '\r' );
 UART1_Write( '\n' );
 break;
 }
 break;
 }
 }
#line 607 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
 else if( pcRF4463RxBuffer[  1  ] ==  1  ){
 switch( pcRF4463RxBuffer[  3  ] ){
 case RF_SETUP_TABLE:
 switch( pcRF4463RxBuffer[  4  ] ){
 case RF_SETUP_FIND_BY_QR:
 memset( pcTempConvBuffer, '\0',  64  );
 for( usCounter = 0; usCounter < 12; usCounter++ ){
 pcTempBuffer[ usCounter ] = pcRF4463RxBuffer[  5  + usCounter ];
 }
 vHexToASCII( pcTempConvBuffer, pcTempBuffer, 12 );

 UART1_Write_Text( "UID: " );
 UART1_Write_Text( pcTempConvBuffer );
 UART1_Write( '\r' );
 UART1_Write( '\n' );

 memset( pcJSONBuffer, '\0', 512 );
 sprintf( pcJSONBuffer, "{\"qrCode\":\"%s\",\"location\":1,\"mac\":\"\",\"modelId\":%d,\"uuiddevice\":\"%s\"}\r\n", pcTempQR, ucSearchedModelId, pcTempConvBuffer );

 UART1_Write_Text( pcJSONBuffer );
 break;
 case RF_SETUP_FTY_DISCOVER:
 memset( pcTempConvBuffer, '\0',  64  );
 memset( pcTempBuffer, '\0',  64  );
 for( usCounter = 0; usCounter < 12; usCounter++ ){
 pcTempBuffer[ usCounter ] = pcRF4463RxBuffer[  5  + usCounter ];
 }

 vHexToASCII( pcTempConvBuffer, pcTempBuffer, 12 );

 UART1_Write_Text( "UID: " );
 UART1_Write_Text( pcTempConvBuffer );
 UART1_Write( '\r' );
 UART1_Write( '\n' );
 break;
 }
 break;
 }
 }
}
#line 654 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
uint8_t ucRF4463GetIRQFlag(){
 return ucRF4463IRQ;
}
#line 661 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
void vRF4463ResetIRQFlag(){
 ucRF4463IRQ = 0;
}
#line 668 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
void vRF4463SetPinSelect( uint8_t ucPinVal ){
  GPIOB_ODR._GPIO_PIN_12  = ucPinVal;
}
#line 675 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463handler.c"
void vRF4463SetPinSDN( uint8_t ucPinVal ){
  GPIOB_ODR._GPIO_PIN_11  = ucPinVal;
}
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.h"
#line 27 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
const uint8_t RF4463_CONFIGURATION_DATA[] =  { 0x08,0x04,0x21,0x71,0x4B,0x00,0x00,0xDC,0x95, 0x08,0x05,0xA6,0x22,0x21,0xF0,0x41,0x5B,0x26, 0x08,0xE2,0x2F,0x1C,0xBB,0x0A,0xA8,0x94,0x28, 0x08,0x05,0x87,0x67,0xE2,0x58,0x1A,0x07,0x5B, 0x08,0xE1,0xD0,0x72,0xD8,0x8A,0xB8,0x5B,0x7D, 0x08,0x05,0x11,0xEC,0x9E,0x28,0x23,0x1B,0x6D, 0x08,0xE2,0x4F,0x8A,0xB2,0xA9,0x29,0x14,0x13, 0x08,0x05,0xD1,0x2E,0x71,0x6A,0x51,0x4C,0x2C, 0x08,0xE5,0x80,0x27,0x42,0xA4,0x69,0xB0,0x7F, 0x08,0x05,0xAA,0x81,0x2A,0xBD,0x45,0xE8,0xA8, 0x08,0xEA,0xE4,0xF0,0x24,0xC9,0x9F,0xCC,0x3C, 0x08,0x05,0x08,0xF5,0x05,0x04,0x27,0x62,0x98, 0x08,0xEA,0x6B,0x62,0x84,0xA1,0xF9,0x4A,0xE2, 0x08,0x05,0xE9,0x77,0x05,0x4F,0x84,0xEE,0x35, 0x08,0xE2,0x43,0xC3,0x8D,0xFB,0xAD,0x54,0x25, 0x08,0x05,0x14,0x06,0x5E,0x39,0x36,0x2F,0x45, 0x08,0xEA,0x0C,0x1C,0x74,0xD0,0x11,0xFC,0x32, 0x08,0x05,0xDA,0x38,0xBA,0x0E,0x3C,0xE7,0x8B, 0x08,0xEA,0xB0,0x09,0xE6,0xFF,0x94,0xBB,0xA9, 0x08,0x05,0xD7,0x11,0x29,0xFE,0xDC,0x71,0xD5, 0x08,0xEA,0x7F,0x83,0xA7,0x60,0x90,0x62,0x18, 0x08,0x05,0x84,0x7F,0x6A,0xD1,0x91,0xC6,0x52, 0x08,0xEA,0x2A,0xD8,0x7B,0x8E,0x4A,0x9F,0x91, 0x08,0x05,0xBD,0xAA,0x9D,0x16,0x18,0x06,0x15, 0x08,0xE2,0x55,0xAD,0x2D,0x0A,0x14,0x1F,0x5D, 0x08,0x05,0xD3,0xE0,0x7C,0x39,0xCF,0x01,0xF0, 0x08,0xEF,0x3A,0x91,0x72,0x6A,0x03,0xBB,0x96, 0x08,0xE7,0x83,0x6D,0xA4,0x92,0xFC,0x13,0xA7, 0x08,0xEF,0xF8,0xFD,0xCF,0x62,0x07,0x6F,0x1E, 0x08,0xE7,0x4C,0xEA,0x4A,0x75,0x4F,0xD6,0xCF, 0x08,0xE2,0xF6,0x11,0xE4,0x26,0x0D,0x4D,0xC6, 0x08,0x05,0xFB,0xBF,0xE8,0x07,0x89,0xC3,0x51, 0x08,0xEF,0x82,0x27,0x04,0x3F,0x96,0xA8,0x58, 0x08,0xE7,0x41,0x29,0x3C,0x75,0x2A,0x03,0x1C, 0x08,0xEF,0xAF,0x59,0x98,0x36,0xAA,0x0F,0x06, 0x08,0xE6,0xF6,0x93,0x41,0x2D,0xEC,0x0E,0x99, 0x08,0x05,0x29,0x19,0x90,0xE5,0xAA,0x36,0x40, 0x08,0xE7,0xFB,0x68,0x10,0x7D,0x77,0x5D,0xC0, 0x08,0xE7,0xCB,0xB4,0xDD,0xCE,0x90,0x54,0xBE, 0x08,0xE7,0x72,0x8A,0xD6,0x02,0xF4,0xDD,0xCC, 0x08,0xE7,0x6A,0x21,0x0B,0x02,0x86,0xEC,0x15, 0x08,0xE7,0x7B,0x7C,0x3D,0x6B,0x81,0x03,0xD0, 0x08,0xEF,0x7D,0x61,0x36,0x94,0x7C,0xA0,0xDF, 0x08,0xEF,0xCC,0x85,0x3B,0xDA,0xE0,0x5C,0x1C, 0x08,0xE7,0xE3,0x75,0xBB,0x39,0x22,0x4B,0xA8, 0x08,0xEF,0xF9,0xCE,0xE0,0x5E,0xEB,0x1D,0xCB, 0x08,0xE7,0xBD,0xE2,0x70,0xD5,0xAB,0x4E,0x3F, 0x08,0xE7,0xB7,0x8D,0x20,0x68,0x6B,0x09,0x52, 0x08,0xEF,0xA1,0x1B,0x90,0xCD,0x98,0x00,0x63, 0x08,0xEF,0x54,0x67,0x5D,0x9C,0x11,0xFC,0x45, 0x08,0xE7,0xD4,0x9B,0xC8,0x97,0xBE,0x8A,0x07, 0x08,0xEF,0x52,0x8D,0x90,0x63,0x73,0xD5,0x2A, 0x08,0xEF,0x03,0xBC,0x6E,0x1C,0x76,0xBE,0x4A, 0x08,0xE7,0xC2,0xED,0x67,0xBA,0x5E,0x66,0x21, 0x08,0xEF,0xE7,0x3F,0x87,0xBE,0xE0,0x7A,0x6D, 0x08,0xE7,0xC9,0x70,0x93,0x1D,0x64,0xF5,0x6C, 0x08,0xEF,0xF5,0x28,0x08,0x34,0xB3,0xB6,0x2C, 0x08,0xEF,0x3A,0x0A,0xEC,0x0F,0xDB,0x56,0xCA, 0x08,0xEF,0x39,0xA0,0x6E,0xED,0x79,0xD0,0x24, 0x08,0xE7,0x6C,0x0B,0xAF,0xA9,0x4E,0x40,0xB5, 0x08,0xE9,0xB9,0xAF,0xBF,0x25,0x50,0xD1,0x37, 0x08,0x05,0x9E,0xDB,0xDE,0x3F,0x94,0xE9,0x6B, 0x08,0xEC,0xC5,0x05,0xAA,0x57,0xDC,0x8A,0x5E, 0x08,0x05,0x70,0xDA,0x84,0x84,0xDD,0xCA,0x90 , 0x07, 0x02, 0x01, 0x00, 0x01, 0xC9, 0xC3, 0x80 , 0x08, 0x13, 0x48, 0x00, 0x00, 0x00, 0x67, 0x00, 0x00 , 0x06, 0x11, 0x00, 0x02, 0x00, 0x52, 0x00 , 0x05, 0x11, 0x00, 0x01, 0x03, 0x20 , 0x08, 0x11, 0x01, 0x04, 0x00, 0x07, 0x38, 0x18, 0x0F , 0x08, 0x11, 0x02, 0x04, 0x00, 0x01, 0x09, 0x0A, 0x08 , 0x0D, 0x11, 0x10, 0x09, 0x00, 0x08, 0x14, 0x00, 0x0F, 0x31, 0x00, 0x00, 0x00, 0x00 , 0x0A, 0x11, 0x11, 0x06, 0x00, 0x01, 0xB4, 0x2B, 0x00, 0x00, 0x00 , 0x10, 0x11, 0x12, 0x0C, 0x00, 0x04, 0x01, 0x08, 0xFF, 0xFF, 0x20, 0x02, 0x00, 0x00, 0x00, 0x00, 0x30 , 0x10, 0x11, 0x12, 0x0C, 0x0C, 0x30, 0x00, 0x40, 0x06, 0xA8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 , 0x10, 0x11, 0x12, 0x0C, 0x18, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 , 0x10, 0x11, 0x12, 0x0C, 0x24, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 , 0x09, 0x11, 0x12, 0x05, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00 , 0x08, 0x11, 0x12, 0x04, 0x36, 0x00, 0x00, 0x00, 0x00 , 0x10, 0x11, 0x20, 0x0C, 0x00, 0x03, 0x00, 0x07, 0x01, 0x77, 0x00, 0x05, 0xC9, 0xC3, 0x80, 0x00, 0x01 , 0x05, 0x11, 0x20, 0x01, 0x0C, 0x18 , 0x10, 0x11, 0x20, 0x0C, 0x18, 0x01, 0x80, 0x08, 0x03, 0xC0, 0x00, 0x30, 0x20, 0x0C, 0xE8, 0x03, 0x0D , 0x10, 0x11, 0x20, 0x0C, 0x24, 0x00, 0xA7, 0xC6, 0x00, 0x54, 0x02, 0xC2, 0x00, 0x04, 0x23, 0x80, 0x03 , 0x07, 0x11, 0x20, 0x03, 0x30, 0x35, 0xD0, 0x80 , 0x05, 0x11, 0x20, 0x01, 0x35, 0xE0 , 0x10, 0x11, 0x20, 0x0C, 0x38, 0x11, 0xAB, 0xAB, 0x80, 0x1A, 0xFF, 0xFF, 0x00, 0x2B, 0x0C, 0xA4, 0x22 , 0x0E, 0x11, 0x20, 0x0A, 0x45, 0x83, 0x00, 0xB1, 0x01, 0x00, 0xFF, 0x06, 0x20, 0x18, 0x40 , 0x06, 0x11, 0x20, 0x02, 0x50, 0x84, 0x08 , 0x06, 0x11, 0x20, 0x02, 0x54, 0x03, 0x07 , 0x05, 0x11, 0x20, 0x01, 0x57, 0x00 , 0x09, 0x11, 0x20, 0x05, 0x5B, 0x40, 0x04, 0x07, 0x78, 0x20 , 0x10, 0x11, 0x21, 0x0C, 0x00, 0xFF, 0xBA, 0x0F, 0x51, 0xCF, 0xA9, 0xC9, 0xFC, 0x1B, 0x1E, 0x0F, 0x01 , 0x10, 0x11, 0x21, 0x0C, 0x0C, 0xFC, 0xFD, 0x15, 0xFF, 0x00, 0x0F, 0xFF, 0xBA, 0x0F, 0x51, 0xCF, 0xA9 , 0x10, 0x11, 0x21, 0x0C, 0x18, 0xC9, 0xFC, 0x1B, 0x1E, 0x0F, 0x01, 0xFC, 0xFD, 0x15, 0xFF, 0x00, 0x0F , 0x08, 0x11, 0x22, 0x04, 0x00, 0x08, 0x7F, 0x00, 0x1D , 0x0B, 0x11, 0x23, 0x07, 0x00, 0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03 , 0x10, 0x11, 0x30, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 , 0x0C, 0x11, 0x40, 0x08, 0x00, 0x3C, 0x08, 0x00, 0x00, 0x22, 0x22, 0x20, 0xFF , 0x00 } ;
const uint8_t RF4463_RF_GLOBAL_XO_TUNE_2_DATA[] = {  0x11, 0x00, 0x02, 0x00, 0x52, 0x00  };





const uint8_t RF4463_RF_GPIO_PIN_CFG_DATA[] = {  0x13, 0x48, 0x00, 0x00, 0x00, 0x67, 0x00, 0x00  };
const unsigned char RF_FRR_CTL_A_MODE_4_data[] = {  0x11, 0x02, 0x04, 0x00, 0x01, 0x09, 0x0A, 0x08 };
const unsigned char RF_SYNC_CONFIG_6_data [] = {  0x11, 0x11, 0x06, 0x00, 0x01, 0xB4, 0x2B, 0x00, 0x00, 0x00  };
const unsigned char RF_MODEM_RAW_SEARCH2_2_data [] = {  0x11, 0x20, 0x02, 0x50, 0x84, 0x08  };



static int16_t intRFLastRSSI = 0;
static uint8_t ucTxChannel = 0;
static uint8_t ucRxChannel = 0;
static uint8_t usRfNetwork = 0;
#line 57 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
void vRf4463Init( uint8_t ucSetTxChannel, uint8_t ucSetRxChannel, uint16_t usNetwork, uint8_t ucTxPower, uint8_t ucFrequency ){
 uint8_t pcBuffer[ 20 ];
#line 62 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
 if( usNetwork == 0 ){
  PrintOut( vDebugPrint , "[ RF4463 ] Invalid Network\r\n", ( ( void * )0 )  ) ;
 return;
 }
 if( ( ucSetTxChannel == 0 || ucSetTxChannel >  50  ) || ( ucSetRxChannel == 0 || ucSetRxChannel >  50  ) ){
  PrintOut( vDebugPrint , "[ RF4463 ] Invalid Channel\r\n", ( ( void * )0 )  ) ;
 return;
 }

 switch( ucFrequency ){
 case RF4463_FREQUENCY_868MHz:
  PrintOut( vDebugPrint , "[ RF4463 ] 868MHz Selected\r\n", ( ( void * )0 )  ) ;
  PrintOut( vDebugPrint , "[ RF4463 ] 868MHz Parameters not available\r\n", ( ( void * )0 )  ) ;
 break;
 case RF4463_FREQUENCY_915MHz:
  PrintOut( vDebugPrint , "[ RF4463 ] 915MHz Selected\r\n", ( ( void * )0 )  ) ;
 break;
 default:
  PrintOut( vDebugPrint , "[ RF4463 ] Invalid frequency\r\n", ( ( void * )0 )  ) ;
 return;
 }

 usRfNetwork = usNetwork;
 ucRxChannel = ucSetRxChannel;
 ucTxChannel = ucSetTxChannel;
#line 90 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
 vRf4463PowerOnReset();
 vRf4463SetConfiguration( RF4463_CONFIGURATION_DATA, sizeof( RF4463_CONFIGURATION_DATA ) );
#line 96 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
 pcBuffer[ 0 ] =  0 ;
 pcBuffer[ 1 ] =  0 ;
 pcBuffer[ 2 ] =  33 ;
 pcBuffer[ 3 ] =  32 ;
 pcBuffer[ 4 ] =  39 ;
 pcBuffer[ 5 ] =  11 ;
 ucRf4463SetCommand( 6,  0x13 , pcBuffer );
 vBufferSetToZero( pcBuffer, 20 );
#line 111 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
 pcBuffer[0] = 0x00;
 pcBuffer[1] = 0x01;
 pcBuffer[2] = 0x00;
 pcBuffer[3] = 98;

 ucRf4463SetCommand(  0x0000 , 4, pcBuffer );
 vBufferSetToZero( pcBuffer, 20 );
#line 123 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
 pcBuffer[0] = 0x11;
 pcBuffer[1] = 0x00;
 pcBuffer[2] = 0x01;
 pcBuffer[3] = 0x03;
 pcBuffer[4] = 0x40;

 ucRf4463SetCommand(  0x0003 , 5, pcBuffer );
 vBufferSetToZero( pcBuffer, 20 );
#line 136 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
 ucRf4463SetProperty(  0x0200 , 8, pcBuffer );
 vBufferSetToZero( pcBuffer, 20 );
#line 152 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
 pcBuffer[0] = 0x11;
 pcBuffer[1] = 0x10;
 pcBuffer[2] = 0x09;
 pcBuffer[3] = 0x00;
 pcBuffer[4] = 0x08;
 pcBuffer[5] = 0x14;
 pcBuffer[6] = 0x00;
 pcBuffer[7] = 0x0f;
 pcBuffer[8] = 0x31;
 pcBuffer[9] = 0x00;
 pcBuffer[10] = 0x00;
 pcBuffer[11] = 0x00;
 pcBuffer[12] = 0x00;


 ucRf4463SetCommand(  0x1000 , 13, pcBuffer );
#line 178 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
 pcBuffer[0] = 0x11;
 pcBuffer[1] = 0x11;
 pcBuffer[2] = 0x05;
 pcBuffer[3] = 0x00;
 pcBuffer[4] = 0x01;
 pcBuffer[5] = ( usNetwork >> 8 );
 pcBuffer[6] = ( usNetwork );
 pcBuffer[7] = 0x00;
 pcBuffer[8] = 0x00;
 ucRf4463SetProperty( RF_SYNC_CONFIG_6_data, 9, pcBuffer);
#line 191 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
 pcBuffer[ 0 ] =  0x80  |  0x01 ;
 ucRf4463SetProperty(  0x1200 , 1, pcBuffer );

 pcBuffer[ 0 ] =  0x02 ;
 ucRf4463SetProperty(  0x1206 , 1, pcBuffer );

 pcBuffer[ 0 ] =  0x08  |  0x02 ;
 pcBuffer[ 1 ] =  0x01 ;
 pcBuffer[ 2 ] = 0x00;
 pcBuffer[ 3 ] = 0x20;
 pcBuffer[ 4 ] = 0x81;
 ucRf4463SetProperty(  0x1208 , 5, pcBuffer );
#line 214 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
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
#line 241 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
 pcBuffer[ 0 ] = 0x01;
 ucRf4463SetProperty(  0x204c , 1, pcBuffer );
#line 247 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
 pcBuffer[ 0 ] = 0x01;
 pcBuffer[ 1 ] = 0x38;
 pcBuffer[ 2 ] = 0x00;
 ucRf4463SetProperty(  0x0100 , 3, pcBuffer );
#line 255 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
 ucRf4463SetTxPower( ucTxPower );
}
#line 261 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
void vRf4463PowerOnReset(){
#line 286 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
 uint8_t pcBuffer[ 7 ] = {  0x02, 0x01, 0x00, 0x01, 0xC9, 0xC3, 0x80  };










 vRF4463SetPinSDN(  1  );
 Delay_us( 16 );
 vRF4463SetPinSDN(  0  );

 Delay_ms( 6 );

 vRF4463SetPinSelect(  0  );
 vRf4463SPIWriteBuffer( sizeof( pcBuffer ), pcBuffer );
 vRF4463SetPinSelect(  1  );
}
#line 311 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
void vRf4463SetChannels( uint8_t ucSetRxChannel, uint8_t ucSetTxChannel ){
#line 315 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
 if( ( ucSetTxChannel == 0 || ucSetTxChannel >  50  ) || ( ucSetRxChannel == 0 || ucSetRxChannel >  50  ) ){
  PrintOut( vDebugPrint , "[ RF4463 ] Invalid Channel\r\n", ( ( void * )0 )  ) ;
 return;
 }

  PrintOut( vDebugPrint , "[ RF4463 ] Rx Channel: %d\r\n", ucSetRxChannel ) ;
  PrintOut( vDebugPrint , "[ RF4463 ] Tx Channel: %d\r\n", ucSetTxChannel ) ;
 ucRxChannel = ucSetRxChannel;
 ucTxChannel = ucSetTxChannel;
}
#line 329 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
void vRf4463SetNetwork( uint16_t usNetwork ){
 uint8_t pcBuffer[ 2 ] = { 0x00 };
 if( usNetwork == 0 ){
  PrintOut( vDebugPrint , "[ RF4463 ] Invalid Network\r\n", ( ( void * )0 )  ) ;
 return;
 }
  PrintOut( vDebugPrint , "[ RF4463 ] Network: %d\r\n", usNetwork ) ;
 usRfNetwork = usNetwork;

 pcBuffer[ 0 ] = ( usNetwork >> 8 );
 pcBuffer[ 1 ] = ( usNetwork );
 ucRf4463SetSyncWords( pcBuffer, 2 );
}
#line 349 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
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
#line 372 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
uint8_t ucRf4463SetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer ){
 if( ucRf4463CheckCTS() ==  1  ){
 return  1 ;
 }

 vRF4463SetPinSelect(  0  );
 ucRf4463SPIByte( ucCommand );
 vRf4463SPIWriteBuffer( ucLength, pcParametersBuffer );
 vRF4463SetPinSelect(  1  );

 return  0 ;
}
#line 388 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
uint8_t ucRf4463GetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer ){
 if( ucRf4463CheckCTS() ==  1  ){
 return  1 ;
 }

 vRF4463SetPinSelect(  0  );
 ucRf4463SPIByte( ucCommand );
 vRF4463SetPinSelect(  1  );

 if( ucRf4463CheckCTS() ==  1  ){
 return  1 ;
 }

 vRF4463SetPinSelect(  0  );
 ucRf4463SPIByte(  0x44  );
 vRf4463SPIReadBuffer( ucLength, pcParametersBuffer );
 vRF4463SetPinSelect(  1  );

 return  0 ;
}
#line 412 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
uint8_t ucRf4463SetProperty( uint16_t usStartProperty, uint8_t ucLength, uint8_t * pcParametersBuffer ){
 uint8_t pcBuffer[ 4 ];

 if( ucRf4463CheckCTS() ==  1  ){
 return  1 ;
 }

 pcBuffer[ 0 ] =  0x11 ;
 pcBuffer[ 1 ] = ( usStartProperty >> 8 );
 pcBuffer[ 2 ] = ucLength;
 pcBuffer[ 3 ] = ( usStartProperty & 0xFF );

 vRF4463SetPinSelect(  0  );
 vRf4463SPIWriteBuffer( 4, pcBuffer );
 vRf4463SPIWriteBuffer( ucLength, pcParametersBuffer );
 vRF4463SetPinSelect(  1  );

 return  0 ;
}
#line 435 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
uint8_t ucRf4463GetProperty( uint16_t usStartProperty, uint8_t ucLength, uint8_t * pcParametersBuffer ){
 uint8_t pcBuffer[ 4 ];

 if( ucRf4463CheckCTS() ==  1  ){
 return  1 ;
 }

 pcBuffer[ 0 ] =  0x12 ;
 pcBuffer[ 1 ] = ( usStartProperty >> 8 );
 pcBuffer[ 2 ] = ucLength;
 pcBuffer[ 3 ] = ( usStartProperty & 0xFF );

 vRF4463SetPinSelect(  0  );
 vRf4463SPIWriteBuffer( 4, pcBuffer );

 if( ucRf4463CheckCTS() ==  1  ){
 return  1 ;
 }

 vRF4463SetPinSelect(  0  );
 ucRf4463SPIByte(  0x44  );
 vRf4463SPIReadBuffer( ucLength, pcParametersBuffer );
 vRF4463SetPinSelect(  1  );

 return  0 ;
}
#line 465 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
uint8_t ucRf4463SetSyncWords( uint8_t * pcSyncWords, uint8_t ucLength ){
 uint8_t pcBuffer[ 5 ];

 if( ( ucLength == 0 ) || ( ucLength > 3 ) ){
 return  1 ;
 }

 pcBuffer[ 0 ] = ucLength - 1;
 memcpy( pcBuffer + 1, pcSyncWords, ucLength );
 return ucRf4463SetProperty(  0x1100 , sizeof( pcBuffer ), pcBuffer );
}
#line 480 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
uint8_t ucRf4463SetPreambleLength( uint8_t ucLength ){
 return ucRf4463SetProperty(  0x1000 , 1, &ucLength );
}
#line 490 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
uint8_t ucRf4463CheckCTS(){
 uint16_t usTimeoutCounter = 0;

 usTimeoutCounter =  2500 ;


 while( usTimeoutCounter-- ){
 vRF4463SetPinSelect(  0  );
 ucRf4463SPIByte(  0x44  );
 if( ucRf4463SPIByte(  0x44  ) ==  0xff  ){

 vRF4463SetPinSelect(  1  );
 return  0 ;
 }
 vRF4463SetPinSelect(  1  );
 }
  PrintOut( vDebugPrint , "[ RF4463 ] CTS failed\r\n", ( ( void * )0 )  ) ;
 return  1 ;
}
#line 513 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
void vRf4463RSSI(){
 int intRSSI;
#line 544 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
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
#line 562 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
int16_t xRF4463GetLastRSSI(){
  PrintOut( vDebugPrint , "[ RF4463 ] Last Measured RSSI: %i\r\n", intRFLastRSSI ) ;
 return intRFLastRSSI;
}
#line 571 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
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
#line 594 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
uint8_t ucRf4463SetGPIOMode( uint8_t ucGPIO0Mode, uint8_t ucGPIO1Mode ){
 uint8_t pcBuffer[ 6 ] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };

 pcBuffer[ 0 ] = ucGPIO0Mode;
 pcBuffer[ 1 ] = ucGPIO1Mode;

 return ucRf4463SetCommand( sizeof( pcBuffer ),  0x13 , pcBuffer );
}
#line 606 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
void vRf4463FIFOReset(){
 uint8_t ucData = 0x03;

 ucRf4463SetCommand( sizeof( ucData ),  0x15 , &ucData );
}
#line 615 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
uint8_t ucRf4463ClearInterrupts(){
 uint8_t pcBuffer[] = { 0x00, 0x00, 0x00 };

 return ucRf4463SetCommand( sizeof( pcBuffer ),  0x20 , pcBuffer );
}
#line 624 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
uint8_t ucRf4463EnterStandbyMode(){
 uint8_t ucData = 0x01;

 return ucRf4463SetCommand( 1,  0x34 , &ucData );
}
#line 633 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
uint8_t vRf4463SetFrecc(float foCentral)
{
 uint8_t outdiv;
 uint8_t band;
 uint32_t xtal_frequency;
 unsigned long f_pfd;
 unsigned int n;
 float ratio;
 float rest;
 unsigned long m;
 unsigned int m2;
 unsigned int m1;
 unsigned int m0;
 uint8_t freq_control[4];

 if (foCentral <= 1050.0 && foCentral >= 850.0)
 {
 outdiv = 4, band = 0;
 }
 else
 {
 return 0;
 }



 xtal_frequency =  30000000L ;
 f_pfd = 2 * xtal_frequency / outdiv;
 n = ((unsigned int)(foCentral / f_pfd)) - 1;
 ratio = foCentral / (float)f_pfd;
 rest = ratio - (float)n;
 m = (unsigned long)(rest * 524288UL);
 m2 = m / 0x10000;
 m1 = (m - m2 * 0x10000) / 0x100;
 m0 = (m - m2 * 0x10000 - m1 * 0x100);


 freq_control[0] = n;
 freq_control[1] = m2;
 freq_control[2] = m1;
 freq_control[3] = m0;




}
#line 683 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
void vRf4463EnterTxMode(){
#line 698 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
 uint8_t pcBuffer[] = { 0x00, 0x30, 0x00, 0x00, 0x00, 0x00, 0x01 };
 pcBuffer[ 0 ] = ucTxChannel;
 ucRf4463SetCommand( 7,  0x31 , pcBuffer );

}
#line 707 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
uint8_t ucRf4463SetTxInterrupt(){
 uint8_t pcBuffer[ 3 ] = { 0x01, 0x20, 0x00 };
 return ucRf4463SetProperty(  0x0100 , 3, pcBuffer );
}
#line 715 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
uint8_t ucRf4463SetTxPower( uint8_t ucPower ){

uint8_t pcBuffer[] = { 0x08, 0x7F, 0x00, 0x5D };

 if( ucPower > 127 ){
  PrintOut( vDebugPrint , "[ RF4463 ] Invalid Power Value: %d\r\n", ucPower ) ;
 ucPower = 127;
 }

 pcBuffer[ 1 ] = ucPower;
  PrintOut( vDebugPrint , "[ RF4463 ] Set Tx Power to: %d\r\n", ucPower ) ;
 return ucRf4463SetProperty(  0x2200 , sizeof( pcBuffer ), pcBuffer );
}
#line 732 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
void vRf4463WriteTxFIFO( uint8_t * pcWriteBuffer, uint8_t ucLength ){
 uint8_t pcBuffer[  64  ];

 pcBuffer[ ucLength + 1 ];

 ucRf4463SetProperty(  0x1212 , 1, &ucLength );

 pcBuffer[ 0 ] = ucLength;

 memcpy( pcBuffer + 1, pcWriteBuffer, ucLength );

 ucRf4463SetCommand( ucLength + 1,  0x66 , pcBuffer );
}
#line 749 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
uint8_t ucRf4463TxPacket( uint8_t * pcTxBuffer, uint8_t ucTxLength ){

 vRf4463FIFOReset();

 vRf4463WriteTxFIFO( pcTxBuffer, ucTxLength );

 vRf4463EnterTxMode();

 return  0 ;
}
#line 763 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
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
#line 787 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
void vRf4463EnterRxMode(){

 uint8_t pcBuffer[7] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
 pcBuffer[ 0 ] = ucRxChannel;
#line 802 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
 ucRf4463SetCommand( 7,  0x32 , pcBuffer );
}
#line 808 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
uint8_t ucRf4463SetRxInterrupt(){
 uint8_t pcBuffer[ 3 ] = { 0x03, 0x18, 0x00 };
 return ucRf4463SetProperty(  0x0100 , 3, pcBuffer );
}
#line 816 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
uint8_t ucRf4463RxInit(){
 ucRf4463SetProperty(  0x1212 , 1,  64  );

 vRf4463FIFOReset();

 vRf4463EnterRxMode();

 return  0 ;
}
#line 829 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
uint8_t ucRf4463RxPacket( uint8_t * pcRxBuffer ){
 uint8_t ucRxLength = 0;

 vRf4463ReadRxFIFO( pcRxBuffer );

 vRf4463FIFOReset();

 return ucRxLength;
}
#line 842 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
void vRf4463ReadRxFIFO( uint8_t * pcBuffer ){
 uint8_t * pcReadLength;

 if( ucRf4463CheckCTS() ==  1  ){
 return;
 }

 vRF4463SetPinSelect(  0  );

 ucRf4463SPIByte(  0x77  );
 vRf4463SPIReadBuffer( 1, &pcReadLength );

 vRf4463SPIReadBuffer(  64 , pcBuffer );

 vRF4463SetPinSelect(  1  );


 vRf4463RSSI();


 return;
}
#line 871 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
uint8_t ucRF4463GetModemStatus(){
 uint8_t pcData[ 4 ];

 ucRf4463GetCommand( 3,  0x22 , pcData );

  PrintOut( vDebugPrint , "[ RF4463 ] Modem Status\r\n", ( ( void * )0 )  ) ;
  PrintOut( vDebugPrint , "[ ] CTS:          0x%X\r\n", pcData[ 0 ] ) ;
  PrintOut( vDebugPrint , "[ ] MODEM_PEND:   0x%X\r\n", pcData[ 1 ] ) ;
  PrintOut( vDebugPrint , "[ ] MODEM_STATUS: 0x%X\r\n", pcData[ 2 ] ) ;

 return pcData[ 2 ];
}
#line 887 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
uint8_t ucRF4463GetIntStatus(){
 uint8_t pcData[ 10 ];

 ucRf4463GetCommand( 9,  0x20  , pcData );

 if( pcData[  0x08  ] == (  0x20  |  0x10  ) ){
  PrintOut( vDebugPrint , "[ RF4463 ] Underflow Overflow flag is active\r\n", ( ( void * )0 )  ) ;










 return 1;
 }
 return 0;
}
#line 912 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
uint8_t ucRF4463CheckIntStatus(){
 uint8_t pcData[ 10 ];

 ucRf4463GetCommand( 9,  0x20  , pcData );

  PrintOut( vDebugPrint , "[ RF4463 ] Get Interrupt Flags Status\r\n", ( ( void * )0 )  ) ;

  PrintOut( vDebugPrint , "[ RF4463 INT_STATUS ] INT_PEND:     0x%02x\r\n", pcData[ 0x01  ] ) ;
  PrintOut( vDebugPrint , "[ RF4463 INT_STATUS ] INT_STATUS:   0x%02x\r\n", pcData[ 0x02  ] ) ;
  PrintOut( vDebugPrint , "[ RF4463 INT_STATUS ] PH_PEND:      0x%02x\r\n", pcData[ 0x03  ] ) ;
  PrintOut( vDebugPrint , "[ RF4463 INT_STATUS ] PH_STATUS:    0x%02x\r\n", pcData[ 0x04  ] ) ;
  PrintOut( vDebugPrint , "[ RF4463 INT_STATUS ] MODEM_PEND:   0x%02x\r\n", pcData[ 0x05  ] ) ;
  PrintOut( vDebugPrint , "[ RF4463 INT_STATUS ] MODEM_STATUS: 0x%02x\r\n", pcData[ 0x06  ] ) ;
  PrintOut( vDebugPrint , "[ RF4463 INT_STATUS ] CHIP_PEND:    0x%02x\r\n", pcData[ 0x07  ] ) ;
  PrintOut( vDebugPrint , "[ RF4463 INT_STATUS ] CHIP_STATUS:  0x%02x\r\n", pcData[ 0x08  ] ) ;

 return ( pcData[  0x08  ] &  0x20  );
}
#line 934 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
void vRF4463CheckState(){
 uint8_t pcData[ 3 ];

 if( ucRf4463CheckCTS() ==  1  ){
  PrintOut( vDebugPrint , "[ RF4463 ] Failed CTS\r\n", ( ( void * )0 )  ) ;
 return;
 }

 ucRf4463GetCommand( 3,  0x33 , pcData );

  PrintOut( vDebugPrint , "[ RF4463 ] Main State: 0x%02X\r\n", pcData[ 1 ] ) ;
  PrintOut( vDebugPrint , "[ RF4463 ] Current Channel: 0x%02X\r\n", pcData[ 2 ] ) ;
}
#line 951 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463pro.c"
void vRF4463SetState( uint8_t ucState ){
 uint8_t pcData[ 2 ];

 pcData[ 0 ] = ucState;

 ucRf4463SetCommand( 1,  0x34 , pcData );
}
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463spi.c"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463spi.h"
#line 35 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463spi.c"
void vRf4463SPIWriteBuffer( uint16_t usWriteLength, uint8_t * pcWriteBuffer ){
#line 39 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463spi.c"
 while( usWriteLength-- ){
 ucRf4463SPIByte( *pcWriteBuffer++ );
 }
}
#line 50 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463spi.c"
void vRf4463SPIReadBuffer( uint16_t usReadLength, uint8_t * pcReadBuffer ){
 uint8_t ucRxCounter = 0;
#line 55 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463spi.c"
 while( usReadLength-- ){
 pcReadBuffer[ ucRxCounter++ ] = ucRf4463SPIByte( 0 );
 }
}
#line 66 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/rf4463spi.c"
uint8_t ucRf4463SPIByte( uint8_t pcWriteData ){
 return SPI2_Read( pcWriteData );
}
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/buttonhandler.c"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/buttonhandler.h"
#line 37 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/buttonhandler.c"
void vButtonISR() iv IVT_INT_EXTI9_5 ics ICS_AUTO{
 if( EXTI_PR.B8 ){
 EXTI_PR.B8 |= 1;


 }
}
#line 51 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/buttonhandler.c"
void vButtonSetup(){
 GPIO_Digital_Input( &GPIOB_BASE, _GPIO_PINMASK_8 );
#line 57 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/buttonhandler.c"
 RCC_APB2ENRbits.AFIOEN = 1;
#line 61 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/buttonhandler.c"
 AFIO_EXTICR3 |= 0x0001;
#line 65 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/buttonhandler.c"
 EXTI_IMR.B8 |= 1;
 EXTI_FTSR.B8 |= 1;

 NVIC_IntEnable( IVT_INT_EXTI9_5 );

 UART1_Write_Text( "[ SETUP ] Button Done\r\n" );
}
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/timer.c"
#line 1 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/timer.h"
#line 37 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/timer.c"
void Timer6_interrupt() iv IVT_INT_TIM6 {
 TIM6_SR.UIF = 0;

  GPIOC_ODR._GPIO_PIN_7  = ~ GPIOC_ODR._GPIO_PIN_7 ;
}
#line 49 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/timer.c"
void vTimerStop( uint8_t ucTimer ){
 if( ucTimer == TIMER_SEARCH ){
 TIM6_CR1.CEN = 0;
 }
}
#line 58 "c:/users/crow/desktop/data/dongle/dongle ( stm32f107rc ) [ mikroc ] 10 oct 2020/dongle ( stm32f107rc ) [ mikroc ]/timer.c"
void vTimerSearchLed(){
 RCC_APB1ENR.TIM6EN = 1;
 TIM6_CR1.CEN = 0;
 TIM6_PSC = 575;
 TIM6_ARR = 62499;
 NVIC_IntEnable(IVT_INT_TIM6);
 TIM6_DIER.UIE = 1;
 TIM6_CR1.CEN = 1;
}
#line 66 "C:/Users/Crow/Desktop/Data/Dongle/Dongle ( STM32F107RC ) [ MikroC ] 10 oct 2020/Dongle ( STM32F107RC ) [ MikroC ]/main.c"
void main(){
 Delay_ms( 1000 );
#line 71 "C:/Users/Crow/Desktop/Data/Dongle/Dongle ( STM32F107RC ) [ MikroC ] 10 oct 2020/Dongle ( STM32F107RC ) [ MikroC ]/main.c"
 GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_6 );
 GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_7 );
 GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_8 );

 GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_7 );
 Sound_Init( &GPIOB_ODR, 7 );
 Sound_Play( 1000, 100 );

  GPIOC_ODR._GPIO_PIN_6  = 1;
  GPIOC_ODR._GPIO_PIN_7  = 1;
  GPIOC_ODR._GPIO_PIN_8  = 1;

 vUARTTxInit();
  PrintOut( vDebugPrint , "TEST\r\n", ( ( void * )0 )  ) ;
#line 88 "C:/Users/Crow/Desktop/Data/Dongle/Dongle ( STM32F107RC ) [ MikroC ] 10 oct 2020/Dongle ( STM32F107RC ) [ MikroC ]/main.c"
 ucRF4463Setup(  0 ,  0 ,  1 ,  127  );
#line 92 "C:/Users/Crow/Desktop/Data/Dongle/Dongle ( STM32F107RC ) [ MikroC ] 10 oct 2020/Dongle ( STM32F107RC ) [ MikroC ]/main.c"
  GPIOC_ODR._GPIO_PIN_6  = 0;
  GPIOC_ODR._GPIO_PIN_8  = 0;
  GPIOC_ODR._GPIO_PIN_7  = 0;
#line 98 "C:/Users/Crow/Desktop/Data/Dongle/Dongle ( STM32F107RC ) [ MikroC ] 10 oct 2020/Dongle ( STM32F107RC ) [ MikroC ]/main.c"
 vDongleLoop();
}
