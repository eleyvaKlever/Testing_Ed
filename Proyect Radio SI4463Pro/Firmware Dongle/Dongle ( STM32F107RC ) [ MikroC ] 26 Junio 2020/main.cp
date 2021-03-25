#line 1 "C:/Users/Crow/OneDrive/Escritorio/Proyect Radio SI4463Pro/Firmware Dongle/Dongle ( STM32F107RC ) [ MikroC ] 26 Junio 2020/main.c"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/main.h"
#line 1 "c:/users/crow/onedrive/documentos/mikroelektronika/mikroc pro for arm/include/built_in.h"
#line 1 "c:/users/crow/onedrive/documentos/mikroelektronika/mikroc pro for arm/include/stdint.h"





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
#line 1 "c:/users/crow/onedrive/documentos/mikroelektronika/mikroc pro for arm/include/string.h"





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
#line 1 "c:/users/crow/onedrive/documentos/mikroelektronika/mikroc pro for arm/include/stdlib.h"







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
#line 1 "c:/users/crow/onedrive/documentos/mikroelektronika/mikroc pro for arm/include/stdio.h"
#line 1 "c:/users/crow/onedrive/documentos/mikroelektronika/mikroc pro for arm/include/stdbool.h"



 typedef char _Bool;
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/sysconfig.c"
#line 18 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/sysconfig.c"
enum DeviceModel{
 Device_Model_Dongle = 0,
 Device_Model_Hub,
 Device_Model_Switch,
 Device_Model_Dimmer,
 Device_Model_Outlet,
 TotalDevicesModel
};

enum ComponentID{
 Component_Dongle = 0,
 Component_Hub_ESP32,
 Component_Hub_ARM,
 Component_Switch,
 Component_Dimmer_Pad,
 Component_Dimmer_Supply,
 Component_Outlet,
 TotalComponentsTypes
};
#line 58 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/sysconfig.c"
const uint8_t pcOverrideKey[ TotalDevicesModel ][  32  ] = {
#line 62 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/sysconfig.c"
 {
 0x7B, 0x32, 0x53, 0x64, 0x54, 0x65, 0x71, 0x69, 0x36, 0x28, 0x4C, 0x5A, 0x40, 0x51, 0x54, 0x5D,
 0x68, 0x26, 0x47, 0x36, 0x57, 0x5D, 0x4F, 0x35, 0x4C, 0x47, 0x43, 0x59, 0x56, 0x40, 0x7A, 0x7B
 },
#line 69 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/sysconfig.c"
 {
 0xDA, 0xE5, 0xA0, 0x27, 0x6F, 0x0B, 0xF4, 0xDD, 0x02, 0x4F, 0x8E, 0x5B, 0xAD, 0x93, 0x25, 0x1B,
 0xDA, 0x1D, 0xEF, 0x31, 0xA1, 0x40, 0x96, 0xBA, 0x71, 0x00, 0x1C, 0xA5, 0xB5, 0x85, 0x6E, 0xFE
 },
#line 76 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/sysconfig.c"
 {
 0x2A, 0x1F, 0xD2, 0xBE, 0xC6, 0x5B, 0xEA, 0xD7, 0x3D, 0xD4, 0xE6, 0x79, 0xE3, 0x32, 0x2A, 0x53,
 0x48, 0xF6, 0x72, 0xB7, 0x67, 0x1B, 0x56, 0x7C, 0xF4, 0xD6, 0x48, 0xC7, 0x8C, 0x48, 0x59, 0x2D
 },
#line 83 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/sysconfig.c"
 {
 0x05, 0x53, 0x1D, 0xC0, 0x13, 0x31, 0x95, 0x7C, 0xDF, 0xB3, 0x72, 0x82, 0x53, 0x32, 0xFE, 0x05,
 0x04, 0xFE, 0xC9, 0x81, 0xC3, 0x50, 0x7D, 0xF9, 0x30, 0x81, 0xF6, 0x9A, 0x38, 0xF2, 0x2A, 0x14
 }
};
#line 92 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/sysconfig.c"
typedef struct{
 uint8_t MajorVersion;
 uint8_t MinorVersion;
 uint8_t BuildVersion;
}FirmwareVersion_t;
#line 117 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/sysconfig.c"
const uint8_t * pcModelPrefix[] = {
 "DO",
 "KH",
 "KS",
 "KD",
 "KO"
};

typedef struct{
 uint8_t Node;
 uint8_t HubNode;
 uint8_t Channel;
 uint8_t TxPower;
 uint8_t BaudRate;
 uint16_t Network;
} RadioParameters_t;

uint8_t ucRemoteNode = 0;
uint8_t ucSenderNode = 0;
uint8_t ucTableIndex = 0;
uint8_t ucCommandIndex = 0;
#line 145 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/sysconfig.c"
static uint8_t pcRAMDataAlloc[  4096  ];
#line 149 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/sysconfig.c"
static uint8_t pcTxRF4463Buffer[  66  ];
uint8_t pcRxRF4463Buffer[  66  ];

uint8_t pcTxRF4463AuxBuffer[  66  ];
uint8_t pcRxRF4463AuxBuffer[  66  ];
#line 157 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/sysconfig.c"
static uint8_t pcTxUARTBuffer[  2048  ];
static uint8_t pcRxUARTBuffer[  2048  ];
#line 162 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/sysconfig.c"
static uint8_t pcSentQR[ 15 ];
static uint8_t pcReceivedQR[ 15 ];
#line 167 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/sysconfig.c"
uint8_t pcUIDText[ 25 ];
uint8_t pcUIDHex[ 13 ];

uint8_t pcMACText[ 20 ];
uint8_t pcMACHex[ 12 ];

uint8_t pcIPText[ 20 ];
uint8_t pcIPHex[ 6 ];

uint8_t pcTempQR[ 15 ];
uint8_t ucSearchedModelId = 0;

uint8_t pcJSONBuffer[ 512 ];
#line 187 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/sysconfig.c"
uint8_t ucUARTDataReady = 0;
#line 191 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/sysconfig.c"
uint8_t ucRF4463TxEvent = 0;
uint8_t ucRadioEvent = 0;
#line 196 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/sysconfig.c"
uint8_t ucSearchActive = 0;
#line 204 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/sysconfig.c"
const uint8_t * pcModelQRPrefix[] = {
 "DO",
 "KH",
 "KS",
 "KD",
 "KO"
};
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/dongle.c"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/dongle.h"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/main.h"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463handler.h"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/main.h"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.h"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463commands.h"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463config_2400.h"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020//si446x_patch.h"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463spi.h"
#line 1 "c:/users/crow/onedrive/documentos/mikroelektronika/mikroc pro for arm/include/stdint.h"
#line 1 "c:/users/crow/onedrive/documentos/mikroelektronika/mikroc pro for arm/include/stdbool.h"
#line 41 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463spi.h"
void vRf4463SPIWriteBuffer( uint16_t usWriteLength, uint8_t * pcWriteBuffer );

void vRf4463SPIReadBuffer( uint16_t usReadLength, uint8_t * pcReadBuffer );

uint8_t ucRf4463SPIByte( uint8_t pcWriteData );
#line 49 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.h"
uint8_t ucRf4463Init();

void vRf4463PowerOnReset();




void vRf4463SetConfiguration( const uint8_t * pcParameters, uint16_t usParametersLength );

uint8_t ucRf4463SetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer );
uint8_t ucRf4463GetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer );

uint8_t ucRf4463SetProperty( uint16_t ucStartProperty, uint8_t ucLength, uint8_t * pcParametersBuffer );
uint8_t ucRf4463GetProperty( uint16_t ucStartProperty, uint8_t ucLength, uint8_t * pcParametersBuffer );

uint8_t ucRf4463SetSyncWords( uint8_t * pcSyncWords, uint8_t ucLength );

uint8_t ucRf4463SetPreambleLength( uint8_t ucLength );




uint8_t ucRf4463CheckCTS();

void vRf4463RSSI();

uint8_t ucRf4463DeviceAvailability();




uint8_t ucRf4463SetGPIOMode( uint8_t ucGPIO0Mode, uint8_t GPIO1Mode );

void vRf4463FIFOReset();

uint8_t ucRf4463ClearInterrupts();

uint8_t ucRf4463EnterStandbyMode();

uint8_t ucRf4463WaitnIRQ();




void vRf4463EnterTxMode();

uint8_t ucRf4463SetTxInterrupt();

uint8_t ucRf4463SetTxPower( uint8_t ucPower );

void vRf4463WriteTxFIFO( uint8_t * pcWriteBuffer, uint8_t ucLength );

uint8_t ucRf4463TxPacket( uint8_t * pcSendBuffer, uint8_t ucSendLength );




void vRf4463EnterRxMode();

uint8_t ucRf4463SetRxInterrupt();

uint8_t ucRf4463RxInit();

uint8_t ucRf4463RxPacket( uint8_t * pcRxBuffer );

void vRf4463ReadRxFIFO( uint8_t * pcBuffer );
#line 47 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463handler.h"
enum{
 Table_RF_Test = 1,
 Table_RF_Setup,
 Table_RF_OTA,
 Table_RF_Global,
 Table_RF_Switch,
 Table_RF_Dimmer,
 Table_RF_Outlet,
 TotalTables
} RFCommandTable;
#line 60 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463handler.h"
enum{
 Test_PingDevice = 0,
 Test_Status,
 Test_Device_QR,
 Test_Device_Ok,
 Test_Device_Stage,
 Test_Device_Loop,
 Test_Device_Channel,
 Test_Device_Message,
 Test_Device_Info,
 TestTableSize,
 Test_Dongle_Search = 200
} RFTestTable;
#line 76 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463handler.h"
enum{
 Setup_Discover = 0,
 Setup_Qr,
 Setup_Configure,
 Setup_Register,
 Setup_Remove,
 Setup_Delete,
 Setup_HardReset,
#line 87 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463handler.h"
 Setup_Override_Enable,
 Setup_Override_Disable,
 Setup_Factory_Reset,
 Setup_Reconfigure,
 Setup_Hard_Discover,
 SetupTableSize
} RFSetupTable;
#line 97 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463handler.h"
enum{
 OTA_RF_Start = 0,
 OTA_RF_StartACK,
 OTA_RF_Header,
 OTA_RF_HeaderACK,
 OTA_RF_Line,
 OTA_RF_LineACK,
 OTA_RF_LineNACK,
 OTA_RF_EOT,
 OTA_RF_EOTACK,
 OTA_RF_Error,
 OTATableSize
} RFOTATable;
#line 113 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463handler.h"
enum{
 Global_On = 0,
 Global_Off,
 GlobalTableSize
} RF8GlobalTable;
#line 121 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463handler.h"
enum{
 Switch_On = 0,
 Switch_Off,
 Switch_Via1On,
 Switch_Via1Off,
 Switch_Via2On,
 Switch_Via2Off,
 Switch_Via3On,
 Switch_Via3Off,
 Switch_Set1Gang,
 Switch_Set2Gang,
 Switch_Set3Gang,
 Switch_Sleep,
 Switch_Wake,
 Switch_HapticEnable,
 Switch_HapticDisable,
 Switch_Enable,
 Switch_Disable,
 SwitchTableSize
} RFSwitchTable;
#line 144 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463handler.h"
enum{
 Dimmer_On = 0,
 Dimmer_Off,
 Dimmer_Lvl1,
 Dimmer_Lvl2,
 Dimmer_Lvl3,
 Dimmer_Lvl4,
 Dimmer_Lvl5,
 Dimmer_Enable,
 Dimmer_Disable,
 Dimmer_Sleep,
 Dimmer_Wake,
 DimmerTableSize
} RfDimmerTable;
#line 161 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463handler.h"
enum{
 Outlet_On = 0,
 Outlet_Off,
 Outlet_Enable,
 Outlet_Disable,
 Outlet_Sleep,
 Outlet_Wake,
 OutletTableSize
} RFOutletTable;
#line 174 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463handler.h"
void vRadioInit();

void vInitRF4463IRQ();

uint8_t ucInitRF4463Config();

void vRFRxMessage();

void vRfTxMessage( uint8_t * pcOutBuffer, uint16_t usLength );

void vRfSettingsHotSwap( uint8_t ucRfChannel, uint16_t usNetwork );
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/uarthandler.h"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/main.h"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/debug.h"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/main.h"
#line 68 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/debug.h"
 void vDebugInit();
 void vDebugPrint( uint8_t ucPrintData );
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/timer.h"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/main.h"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/debug.h"
#line 29 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/timer.h"
enum{
 TIMER_SEARCH,
 TotalsTimers
} TimerList;
#line 36 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/timer.h"
void vTimerStop( uint8_t ucTimer );

void vTimerSearchLed();
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/xorcipher.h"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/main.h"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/debug.h"
#line 34 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/xorcipher.h"
void vXORRFMessage( uint8_t * pcBuffer, uint8_t * pcXORBuffer, uint8_t ucBufferSize );
#line 23 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/uarthandler.h"
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
 UART_Commands
} UARTCommandsTable;
#line 49 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/uarthandler.h"
void vUARTTxInit();

void vUARTRxInit();

void vUARTRxMessage();

void vUARTCommands( uint8_t * pcInBuffer );
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/buttonhandler.h"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/main.h"
#line 24 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/buttonhandler.h"
void vButtonSetup();
#line 28 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/dongle.h"
void vDongleLoop();
#line 43 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/dongle.c"
void vDongleLoop(){
 NVIC_IntEnable( IVT_INT_EXTI15_10 );

 vUARTRxInit();


 UART1_Write_Text( "APP_START\r\n" );
#line 54 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/dongle.c"
 while( 1 ){
 if( ucUARTDataReady == 1 ){
 ucUARTDataReady = 0;
 vUARTRxMessage();
 }
 if( ucRadioEvent == 1 ){
 ucRadioEvent = 0;
 vRFRxMessage();
 }
 }
}
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/uarthandler.c"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/uarthandler.h"
#line 26 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/uarthandler.c"
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
 "FIND"
};
#line 57 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/uarthandler.c"
extern RadioParameters_t xRadioParameters;
#line 64 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/uarthandler.c"
void vUARTISR() iv IVT_INT_USART1 ics ICS_AUTO{
  GPIOC_ODR._GPIO_PIN_8  = 1;

 if( USART1_SRbits.RXNE == 1 && !USART1_SRbits.PE ){
 ucTempByteUART = USART1_DR;
 if( ucTempByteUART == '\n' ){
 pcRxUARTBuffer[ usUARTMessageLength++ ] = ucTempByteUART;
 ucUARTDataReady = 1;
 ucTempByteUART = 0;
  GPIOC_ODR._GPIO_PIN_8  = 0;
 }
 else{
 pcRxUARTBuffer[ usUARTMessageLength++ ] = ucTempByteUART;
 ucTempByteUART = 0;
 }
 }
 if( USART1_SRbits.ORE == 1 ){
 ucTempByteUART = USART1_SR;
 ucTempByteUART = USART1_DR;
 }
}
#line 92 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/uarthandler.c"
void vUARTTxInit(){
 UART1_Init_Advanced( 115200, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10 );
}
#line 99 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/uarthandler.c"
void vUARTRxInit(){
 USART1_CR1bits.RE = 1;
 USART1_CR1bits.RXNEIE = 1;

 NVIC_IntEnable( IVT_INT_USART1 );
}
#line 109 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/uarthandler.c"
void vUARTRxMessage(){
 uint16_t usCounter = 0;






  PrintOut( vDebugPrint , "[ UART RX ] Packet: %s", pcRxUARTBuffer ) ;

 vUARTCommands( pcRxUARTBuffer );

 memset( pcRxUARTBuffer, '\0', sizeof( pcRxUARTBuffer ) );
 usUARTMessageLength = 0;
}
#line 128 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/uarthandler.c"
void vUARTCommands( uint8_t * pcInBuffer ){
 uint8_t ucCommandCounter = 0;
 uint8_t ucCounter = 0;
 uint8_t ucPosition = 0;
 uint8_t pcTempBuffer[ 50 ];

 uint8_t pcTempTxBuffer[  66  ];

 uint16_t usTempData = 0;
 uint8_t ucDeviceModel = 0;

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
  PrintOut( vDebugPrint , "[ UART ] Send Message\r\n", 0  ) ;
 vRfSettingsHotSwap(  5 ,  5  );
 memset( pcTempBuffer, '\0', 50 );

 ucPosition = 5;

 for( ucCounter = 0; ucCounter < usUARTMessageLength; ucCounter++ ){
 if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
 break;
 }
 pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
 }



 ucRemoteNode =  255 ;
 ucSenderNode =  254 ;
 ucTableIndex = Table_RF_Test;
 ucCommandIndex = Test_Device_QR;

 vRfTxMessage( pcTempBuffer, ucCounter );
 break;
 case UART_CMD_END:
  PrintOut( vDebugPrint , "[ UART ] End Factory Stage\r\n", 0  ) ;


 memset( pcSentQR, '\0', 15 );

 ucPosition = 6;

 for( ucCounter = 0; ucCounter < usUARTMessageLength; ucCounter++ ){
 if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
 break;
 }
 pcSentQR[ ucCounter ] = pcInBuffer[ ucPosition++ ];
 }

 ucRemoteNode =  255 ;
 ucSenderNode =  254 ;
 ucTableIndex = Table_RF_Test;
 ucCommandIndex = Test_Device_Ok;

 vRfTxMessage( pcSentQR, ucCounter );
 break;
 case UART_CMD_STAGE:
  PrintOut( vDebugPrint , "[ UART ] Get Stage\r\n", 0  ) ;
 vRfSettingsHotSwap(  5 ,  5  );

 ucRemoteNode =  255 ;
 ucSenderNode =  254 ;
 ucTableIndex = Table_RF_Test;
 ucCommandIndex = Test_Device_Stage;

 vRfTxMessage(  0 ,  0  );
 break;
 case UART_CMD_REBOOT:
  PrintOut( vDebugPrint , "[ UART ] Reboot\r\n", 0  ) ;

  GPIOC_ODR._GPIO_PIN_8  = 0;
  GPIOC_ODR._GPIO_PIN_7  = 0;
  GPIOC_ODR._GPIO_PIN_6  = 1;

 Delay_ms( 1000 );
 SystemReset();
 break;
 case UART_CMD_PING:
  PrintOut( vDebugPrint , "[ UART ] Ping\r\n", 0  ) ;
 ucRemoteNode =  2 ;
 ucSenderNode =  1 ;
 ucTableIndex = Table_RF_Test;
 ucCommandIndex = Test_PingDevice;

 vRfTxMessage(  0 ,  0  );
 break;
 case UART_CMD_TEST:
  PrintOut( vDebugPrint , "[ UART ] Test\r\n", 0  ) ;
 memset( pcTempBuffer, '\0', 50 );

 ucPosition = 5;

 for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
 pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
 pcTempQR[ ucCounter ] = pcTempBuffer[ ucCounter ];
 }

 for( ucSearchedModelId = 0; ucSearchedModelId < TotalDevicesModel; ucSearchedModelId++ ){
 if( memcmp( pcTempQR, pcModelQRPrefix[ ucSearchedModelId ], 2 ) == 0 ){
 break;
 }
 }

 ucRemoteNode =  2 ;
 ucSenderNode =  1 ;
 ucTableIndex = Table_RF_Setup;
 ucCommandIndex = Setup_Qr;

 vRfTxMessage( pcTempBuffer, strlen( pcTempBuffer ) );
 break;
 case UART_CMD_REMOVE:
  PrintOut( vDebugPrint , "[ UART ] Remove\r\n", 0  ) ;

 memset( pcTempBuffer, '\0', 50 );

 ucPosition = 7;

 for( ucCounter = 0; ; ucCounter++ ){
 if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
 break;
 }
 pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
 }

 usTempData = atoi( pcTempBuffer );
 ucRemoteNode = usTempData;
 ucSenderNode =  1 ;
 ucTableIndex = Table_RF_Setup;
 ucCommandIndex = Setup_Delete;

 vRfTxMessage(  0 ,  0  );
 break;
 case UART_CMD_CHANNEL:
  PrintOut( vDebugPrint , "[ UART ] Set Channel\r\n", 0  ) ;
 memset( pcTempBuffer, '\0', 50 );

 ucPosition = 8;

 for( ucCounter = 0; ; ucCounter++ ){
 if( pcInBuffer[ ucPosition ] == '\r' || pcInBuffer[ ucPosition ] == '\n' ){
 break;
 }
 pcTempBuffer[ ucCounter ] = pcInBuffer[ ucPosition++ ];
 }

 ucRf4463EnterStandbyMode();

 usTempData = atoi( pcTempBuffer );
 vRfSettingsHotSwap( usTempData, usTempData );
 break;
 case UART_CMD_INFO:
  PrintOut( vDebugPrint , "[ UART ] Get Device Info\r\n", 0  ) ;
#line 308 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/uarthandler.c"
 ucRemoteNode =  255 ;
 ucSenderNode =  1 ;
 ucTableIndex = Table_RF_Test;
 ucCommandIndex = Test_Device_Info;

 vRfTxMessage(  0 ,  0  );
 break;
 case UART_CMD_SEARCH:
  PrintOut( vDebugPrint , "[ UART ] Search\r\n", 0  ) ;
 ucRemoteNode =  254 ;
 ucSenderNode =  254 ;
 ucTableIndex = Table_RF_Test;
 ucCommandIndex = Test_Dongle_Search;
 vRfTxMessage(  0 ,  0  );
 break;
 case UART_CMD_OVERRIDE:
  PrintOut( vDebugPrint , "[ UART ] Override\r\n", 0  ) ;
 case UART_CMD_RESET_FTY:
  PrintOut( vDebugPrint , "[ UART ] Reset Factory\r\n", 0  ) ;
 break;
 case UART_CMD_OVERRIDE_SET:
  PrintOut( vDebugPrint , "[ UART ] Set Override\r\n", 0  ) ;
 break;
 case UART_CMD_DISCOVER:
  PrintOut( vDebugPrint , "[ UART ] Discover\r\n", 0  ) ;
 ucRemoteNode =  255 ;
 ucSenderNode =  254 ;
 ucTableIndex = Table_RF_Setup;
 ucCommandIndex = Setup_Hard_Discover;

 vRfTxMessage(  0 ,  0  );
 case UART_CMD_FIND:
  PrintOut( vDebugPrint , "[ UART ] Find in Channel\r\n", 0  ) ;
 ucRemoteNode =  255 ;
 ucSenderNode =  1 ;
 ucTableIndex = Table_RF_Test;
 ucCommandIndex = Test_Device_Channel;

 vRfTxMessage(  0 ,  0  );
 break;


 }
 }
 }
}
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/debug.c"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/debug.h"
#line 79 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/debug.c"
 void vDebugInit(){
 UART1_Init_Advanced( 115200, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10 );
 }
#line 89 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/debug.c"
 void vDebugPrint( uint8_t ucPrintData ){
 UART1_Write( ucPrintData );
 }
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/conversion.c"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/conversion.h"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/main.h"
#line 27 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/conversion.h"
void vASCIIToHex( uint8_t *pcHexConvertBuffer, uint8_t *pcASCIIConvertBuffer, uint8_t ucConversionLength );

void vHexToASCII( uint8_t *pcASCIIConvertBuffer, uint8_t *pcHexConvertBuffer, uint8_t ucConversionLength );

void vSerializeUUID( uint8_t * pcTextConvertBuffer, uint8_t * pcHexConvertBuffer );

void vSerializeMACAddress( uint8_t * pcTextConvertBuffer, uint8_t * pcHexConvertBuffer );

void vSerializeIPAddress( uint8_t * pcTextConvertBuffer, uint8_t * pcHexConvertBuffer );
#line 26 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/conversion.c"
const uint8_t pcHexChar[16] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};

uint8_t ucMSBNibble = 0;
uint8_t ucLSBNibble = 0;
#line 41 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/conversion.c"
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
#line 65 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/conversion.c"
void vHexToASCII( uint8_t *pcASCIIConvertBuffer, uint8_t *pcHexConvertBuffer, uint8_t ucConversionLength ){
 uint8_t ucHexConvCounter = 0;

 for( ucHexConvCounter = 0; ucHexConvCounter < ucConversionLength; ucHexConvCounter++ ){
 pcASCIIConvertBuffer[ ucHexConvCounter * 2 ] = pcHexChar[ pcHexConvertBuffer[ ucHexConvCounter ] >> 4 ];
 pcASCIIConvertBuffer[ ( ucHexConvCounter * 2 ) + 1 ] = pcHexChar[ ( pcHexConvertBuffer[ ucHexConvCounter ] & 0x0F ) ];
 }
}
#line 77 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/conversion.c"
void vSerializeUUID( uint8_t * pcTextConvertBuffer, uint8_t * pcHexConvertBuffer ){
 uint8_t ucCounter = 0;

 for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
 pcTextConvertBuffer[ ucCounter * 2 ] = pcHexChar[ pcHexConvertBuffer[ ucCounter ] >> 4 ];
 pcTextConvertBuffer[ ( ucCounter * 2 ) + 1 ] = pcHexChar[ pcHexConvertBuffer[ ucCounter ] & 0x0F ];
 }
}
#line 89 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/conversion.c"
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
#line 108 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/conversion.c"
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
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/xorcipher.c"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/xorcipher.h"
#line 26 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/xorcipher.c"
const uint8_t pcXORRFKey[ 50 ] = {
 0xE2, 0x77, 0x70, 0xA8, 0x0A, 0xF8, 0xDA, 0x9A, 0x29, 0x9A, 0xA6, 0x74, 0xB2, 0x1A, 0x09, 0x02,
 0x0B, 0xA6, 0xFF, 0xAB, 0xC7, 0x13, 0xDE, 0xD2, 0x18, 0x71, 0x2F, 0xC2, 0x77, 0x8D, 0x5C, 0xC4,
 0xF7, 0x52, 0x4C, 0x9C, 0xE0, 0x4A, 0x2F, 0x30, 0xE1, 0x35, 0x56, 0xF6, 0xC5, 0xB1, 0xA4, 0x71,
 0x69, 0x04
};
#line 49 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/xorcipher.c"
void vXORRFMessage( uint8_t * pcBuffer, uint8_t * pcXORBuffer, uint8_t ucBufferSize ){
 uint8_t ucKeyPosition = 0;
 uint8_t ucBufferPosition = 0;

 for( ucBufferPosition = 0; ucBufferPosition < ucBufferSize; ucBufferPosition++ ){
 pcXORBuffer[ ucBufferPosition ] = pcBuffer[ ucBufferPosition ] ^ pcXORRFKey[ ucKeyPosition++ ];
 }
}
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/flashhandler.c"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/flashhandler.h"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/main.h"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/flashw25q128jv.h"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/main.h"
#line 32 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/flashw25q128jv.h"
enum{
 Select_Flash_1 = 1,
 Select_Flash_2 = 2,
 Select_Flash
};
#line 41 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/flashw25q128jv.h"
void vW25Q128JVInit();
#line 46 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/flashw25q128jv.h"
void vFlashWriteEnable( uint8_t ucMemorySelected );

uint8_t ucFlashIsWriteBusy( uint8_t ucMemorySelected );

void vFlashWriteByte( uint8_t ucMemorySelected, uint8_t pcData, uint32_t ulMemoryAddress );

void vFlashWriteWord( uint8_t ucMemorySelected, uint16_t pcData, uint32_t ulMemoryAddress );

uint8_t ucFlashWriteArray( uint8_t ucMemorySelected, uint8_t * pcData, uint16_t usBufferLength, const uint32_t ulMemoryAddress );
#line 59 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/flashw25q128jv.h"
uint8_t ucFlashReadByte( uint8_t ucMemorySelected, uint32_t ulMemoryAddress );

uint16_t usFlashReadWord( uint8_t ucMemorySelected, uint32_t ulMemoryAddress );

void vFlashReadArray( uint8_t ucMemorySelected, uint8_t * pcReceiverBuffer, uint16_t usBufferLength, uint32_t ulMemoryAddress );
#line 68 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/flashw25q128jv.h"
uint8_t ucFlashReadId( uint8_t ucMemorySelected );

void vFlashResetWriteProtection( uint8_t ucMemorySelected );

void vFlashChipErase( uint8_t ucMemorySelected );

void vFlashSectorErase( uint8_t ucMemorySelected, uint32_t ulMemoryAddress );

void vFlashReset( uint8_t ucMemorySelected );
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/conversion.h"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/main.h"
#line 27 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/conversion.h"
void vASCIIToHex( uint8_t *pcHexConvertBuffer, uint8_t *pcASCIIConvertBuffer, uint8_t ucConversionLength );

void vHexToASCII( uint8_t *pcASCIIConvertBuffer, uint8_t *pcHexConvertBuffer, uint8_t ucConversionLength );

void vSerializeUUID( uint8_t * pcTextConvertBuffer, uint8_t * pcHexConvertBuffer );

void vSerializeMACAddress( uint8_t * pcTextConvertBuffer, uint8_t * pcHexConvertBuffer );

void vSerializeIPAddress( uint8_t * pcTextConvertBuffer, uint8_t * pcHexConvertBuffer );
#line 34 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/flashhandler.h"
void vFlashInit();

void vFlashTest();
#line 41 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/flashhandler.c"
void vFlashInit(){
 SPI1_Init_Advanced( _SPI_FPCLK_DIV2, _SPI_MASTER | _SPI_8_BIT | _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION | _SPI_MSB_FIRST |
 _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI1_PA567 );

 GPIO_Digital_Output( &GPIOA_BASE, _GPIO_PINMASK_4 );

 UART1_Write_Text( "[ FLASH ] Start\r\n" );

 vW25Q128JVInit();
 vFlashWriteEnable( Select_Flash_1 );
 Delay_ms( 50 );
 vFlashTest();
}
#line 58 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/flashhandler.c"
void vFlashTest(){
 const uint8_t pcStringTest[] = "cf23df2207d99a74fbe169e3eba035e633b65d94";
 const uint8_t pcCompareTest[] = "da39a3ee5e6b4b0d3255bfef95601890afd80709";
 uint8_t pcEraseTest[ 40 ];

 uint8_t ucTempText[ 7 ];
 uint8_t TempData = 0;
 uint8_t FlashID = 0;

 uint8_t ucTempValue = 0;
 uint16_t usFlashCounter = 0;
 uint32_t ulFlashAddress = 0;

 UART1_Write_Text( "[ FLASH ] Test\r\n" );

 UART1_Write_Text( "[ FLASH ] Bank 1 ID: " );
 FlashID = ucFlashReadId( Select_Flash_1 );
 ByteToStr( FlashID, ucTempText );
 UART1_Write_Text( ucTempText );
 UART1_Write( '\r' );
 UART1_Write( '\n' );





 UART1_Write_Text( "[ FLASH ] ------------------------------------------ Bank 1 Test Start ------------------------------------------\r\n" );

 vFlashSectorErase( Select_Flash_1,  0x00FF1000  );

 ulFlashAddress =  0x00FF1000 ;
 for( usFlashCounter = 0; usFlashCounter < 50; usFlashCounter++ ){
 UART1_Write( ucFlashReadByte( Select_Flash_1, ulFlashAddress++ ) );
 }
 UART1_Write( '\r' );
 UART1_Write( '\n' );

 ulFlashAddress =  0x00FF1000 ;
 for( usFlashCounter = 0; usFlashCounter < 40; usFlashCounter++ ){
 vFlashWriteByte( Select_Flash_1, pcStringTest[ usFlashCounter ], ulFlashAddress++ );
 }

 ulFlashAddress =  0x00FF1000 ;
 for( usFlashCounter = 0; usFlashCounter < 50; usFlashCounter++ ){
 UART1_Write( ucFlashReadByte( Select_Flash_1, ulFlashAddress++ ) );
 }
 UART1_Write( '\r' );
 UART1_Write( '\n' );

 vFlashSectorErase( Select_Flash_1,  0x00FF1000  );

 ulFlashAddress =  0x00FF1000 ;
 for( usFlashCounter = 0; usFlashCounter < 50; usFlashCounter++ ){
 UART1_Write( ucFlashReadByte( Select_Flash_1, ulFlashAddress++ ) );
 }
 UART1_Write( '\r' );
 UART1_Write( '\n' );

 ulFlashAddress =  0x00FF1000 ;
 for( usFlashCounter = 0; usFlashCounter < 40; usFlashCounter++ ){
 vFlashWriteByte( Select_Flash_1, pcCompareTest[ usFlashCounter ], ulFlashAddress++ );
 }

 ulFlashAddress =  0x00FF1000 ;
 for( usFlashCounter = 0; usFlashCounter < 50; usFlashCounter++ ){
 UART1_Write( ucFlashReadByte( Select_Flash_1, ulFlashAddress++ ) );
 }
 UART1_Write( '\r' );
 UART1_Write( '\n' );
 UART1_Write_Text( "[ FLASH ] ------------------------------------------ Bank 1 Test Done ------------------------------------------\r\n" );


}
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/flashw25q128jv.c"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/flashw25q128jv.h"
#line 43 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/flashw25q128jv.c"
void vW25Q128JVInit( ){
  GPIOA_ODR._GPIO_PIN_4  = 1;
}
#line 50 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/flashw25q128jv.c"
void vFlashWriteEnable( uint8_t ucMemorySelected ){
  GPIOA_ODR._GPIO_PIN_4  = 0;
 SPI1_Write(  0x06  );
  GPIOA_ODR._GPIO_PIN_4  = 1;
}
#line 59 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/flashw25q128jv.c"
uint8_t ucFlashIsWriteBusy( uint8_t ucMemorySelected ){
 uint8_t ucTemp = 0;

  GPIOA_ODR._GPIO_PIN_4  = 0;
 SPI1_Write(  0x05  );
 ucTemp = SPI1_Read( 0 );
  GPIOA_ODR._GPIO_PIN_4  = 1;

 return ( ucTemp & 0x01 );
}
#line 73 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/flashw25q128jv.c"
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
#line 90 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/flashw25q128jv.c"
void vFlashWriteWord( uint8_t ucMemorySelected, uint16_t pcData, uint32_t ulMemoryAddress ){
 vFlashWriteByte( ucMemorySelected,  ((char *)&pcData)[1] , ulMemoryAddress );
 vFlashWriteByte( ucMemorySelected,  ((char *)&pcData)[0] , ulMemoryAddress + 1 );
}
#line 98 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/flashw25q128jv.c"
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
#line 131 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/flashw25q128jv.c"
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
#line 148 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/flashw25q128jv.c"
uint16_t usFlashReadWord( uint8_t ucMemorySelected, uint32_t ulMemoryAddress ){
 uint16_t usTemp = 0;

  ((char *)&usTemp)[1]  = ucFlashReadByte( ucMemorySelected, ulMemoryAddress );
  ((char *)&usTemp)[0]  = ucFlashReadByte( ucMemorySelected, ulMemoryAddress + 1 );

 return usTemp;
}
#line 160 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/flashw25q128jv.c"
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
#line 178 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/flashw25q128jv.c"
uint8_t ucFlashReadId( uint8_t ucMemorySelected ){
 uint8_t ucTemp = 0;

  GPIOA_ODR._GPIO_PIN_4  = 0;

 SPI1_Write(  0x9F  );
 ucTemp = SPI1_Read( 0 );

  GPIOA_ODR._GPIO_PIN_4  = 1;

 return ucTemp;
}
#line 194 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/flashw25q128jv.c"
void vFlashResetWriteProtection( uint8_t ucMemorySelected ){
  GPIOA_ODR._GPIO_PIN_4  = 0;
 SPI1_Write(  0x06  );
  GPIOA_ODR._GPIO_PIN_4  = 1;

  GPIOA_ODR._GPIO_PIN_4  = 0;
 SPI1_Write(  0x06  );
 SPI1_Write( 0 );
  GPIOA_ODR._GPIO_PIN_4  = 1;
}
#line 208 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/flashw25q128jv.c"
void vFlashChipErase( uint8_t ucMemorySelected ){

 vFlashWriteEnable( ucMemorySelected );

  GPIOA_ODR._GPIO_PIN_4  = 0;
 SPI1_Write(  0xC7  );
  GPIOA_ODR._GPIO_PIN_4  = 1;

 while( ucFlashIsWriteBusy( ucMemorySelected ) );
}
#line 222 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/flashw25q128jv.c"
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
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463handler.c"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463handler.h"
#line 30 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463handler.c"
RadioParameters_t xRadioParameters;
#line 38 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463handler.c"
void RFISR() iv IVT_INT_EXTI15_10 ics ICS_AUTO{
 if( EXTI_PR.B12 ){
 EXTI_PR.B12 |= 1;
  GPIOC_ODR._GPIO_PIN_6  =  1 ;
 ucRadioEvent = 1;
 ucRf4463ClearInterrupts();


 }
}
#line 55 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463handler.c"
void vRadioInit(){
 uint8_t ucTempText[ 20 ];
#line 61 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463handler.c"
 SPI2_Init_Advanced( _SPI_FPCLK_DIV16, _SPI_MASTER | _SPI_8_BIT | _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION | _SPI_MSB_FIRST |
 _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI2_PB13_14_15 );
#line 67 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463handler.c"
 GPIO_Digital_Input( &GPIOC_BASE, _GPIO_PINMASK_12 );

 GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_12 );
 GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_11 );
 GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_11 );
 GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_10 );
#line 76 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463handler.c"
 vInitRF4463IRQ();
#line 81 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463handler.c"
 xRadioParameters.Channel =  5 ;
 xRadioParameters.Network =  5 ;
 xRadioParameters.TxPower =  127 ;

 ucInitRF4463Config();
#line 89 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463handler.c"
  PrintOut( vDebugPrint , "[ RF4463 ] Parameters\r\n", 0  ) ;
  PrintOut( vDebugPrint , "[ RF4463 ] Node: %d\r\n", xRadioParameters.Node ) ;
  PrintOut( vDebugPrint , "[ RF4463 ] Channel: %d\r\n", xRadioParameters.Channel ) ;
  PrintOut( vDebugPrint , "[ RF4463 ] Network: %d\r\n", xRadioParameters.Network ) ;
  PrintOut( vDebugPrint , "[ RF4463 ] Tx Power: %d\r\n", xRadioParameters.TxPower ) ;
}
#line 99 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463handler.c"
void vInitRF4463IRQ(){
#line 103 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463handler.c"
 RCC_APB2ENRbits.AFIOEN = 1;
#line 107 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463handler.c"
 AFIO_EXTICR4 |= 0x0002;
#line 111 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463handler.c"
 EXTI_IMR.B12 |= 1;
 EXTI_FTSR.B12 |= 1;
}
#line 118 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463handler.c"
uint8_t ucInitRF4463Config(){
 uint8_t ucRetriesRf = 0;
 uint8_t ucIsRFAvailable =  1 ;

  PrintOut( vDebugPrint , "[ RF4463 ] Configure\r\n", 0  ) ;

 ucRf4463Init();
 ucRf4463Init();

  PrintOut( vDebugPrint , "[ RF4463 ] Configure Done\r\n", 0  ) ;

 for( ucRetriesRf = 0; ucRetriesRf < 5; ucRetriesRf++ ){
 if( ucRf4463DeviceAvailability() ==  0  ){
  PrintOut( vDebugPrint , "[ RF4463 ] Init Done\r\n", 0  ) ;
 break;
 }
 Delay_ms( 10 );
  PrintOut( vDebugPrint , "[ RF4463 ] Try: %d\r\n", ucRetriesRf ) ;
 }
#line 140 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463handler.c"
  PrintOut( vDebugPrint , "[ RF4463 ] Wait for Standby\r\n", 0  ) ;

 while( ucRf4463EnterStandbyMode() ==  1  );

  PrintOut( vDebugPrint , "[ RF4463 ] Standby\r\n", 0  ) ;

 return  0 ;
}
#line 152 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463handler.c"
void vRFRxMessage(){
 uint16_t usCounter = 0;

 uint8_t ucPosition = 0;
 uint8_t pcTempBuffer[  66  ];
 uint8_t pcTempConvBuffer[  66  ];

 if( ucRF4463TxEvent == 0 ){
 memset( pcRxRF4463Buffer, '\0', sizeof( pcRxRF4463Buffer ) );
 ucRf4463RxPacket( pcRxRF4463Buffer );

 if( pcRxRF4463Buffer[ 0 ] > 0 ){


 UART1_Write_Text( "[ RF4463 Rx ] Packet: " );
 for( usCounter = 0; usCounter < pcRxRF4463Buffer[  0  ]; usCounter++ ){
 UART1_Write( pcRxRF4463Buffer[ usCounter ] );
 }
 UART1_Write( '\r' );
 UART1_Write( '\n' );


 if( pcRxRF4463Buffer[  1  ] ==  254  ){
 switch( pcRxRF4463Buffer[  3  ] ){
 case Table_RF_Test:
 switch( pcRxRF4463Buffer[  4  ] ){
 case Test_Device_Loop:

 ucRemoteNode =  255 ;
 ucSenderNode =  254 ;
 ucTableIndex = Table_RF_Test;
 ucCommandIndex = Test_Device_Loop;

 vRfTxMessage( &pcRxRF4463Buffer[  5  ], ( pcRxRF4463Buffer[  0  ] -  5  ) );

 break;
 case Test_Device_QR:
 UART1_Write_Text( "RCV|" );
 for( usCounter =  5 ; usCounter < pcRxRF4463Buffer[  0  ]; usCounter++ ){
 UART1_Write( pcRxRF4463Buffer[ usCounter ] );
 }
 UART1_Write( '\r' );
 UART1_Write( '\n' );
 break;
 case Test_Device_Ok:
 for( usCounter = 0; usCounter < 12; usCounter++ ){
 pcReceivedQR[ usCounter ] = pcRxRF4463Buffer[  5  + usCounter ];
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
 case Test_Device_Message:
 UART1_Write_Text( "RCV|" );
 for( usCounter =  5 ; usCounter < pcRxRF4463Buffer[  0  ]; usCounter++ ){
 UART1_Write( pcRxRF4463Buffer[ usCounter ] );
 }
 UART1_Write( '\r' );
 UART1_Write( '\n' );
 break;
 case Test_Dongle_Search:

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
 case Test_Device_Info:
 for( usCounter = 0; usCounter < ( pcRxRF4463Buffer[  0  ] -  5  ); usCounter++ ){
 pcTempBuffer[ usCounter ] = pcRxRF4463Buffer[ usCounter +  5  ];
 }
 memset( pcRxRF4463AuxBuffer, '\0',  66  );
 vXORRFMessage( pcTempBuffer, pcRxRF4463AuxBuffer, usCounter );
 switch( pcRxRF4463AuxBuffer[ ucPosition++ ] ){
 case Device_Model_Hub:
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

 memset( pcTempBuffer, '\0',  0  );
 sprintf( pcTempBuffer, "Ver: %d.%d.%d\r\n", pcRxRF4463AuxBuffer[ ucPosition++ ], pcRxRF4463AuxBuffer[ ucPosition++ ], pcRxRF4463AuxBuffer[ ucPosition++ ] );
 UART1_Write_Text( pcTempBuffer );
 break;
 case Device_Model_Switch:
 break;
 case Device_Model_Dimmer:
 break;
 case Device_Model_Outlet:
 break;
 }
 break;
 }
 break;
 case Table_RF_Setup:
 switch( pcRxRF4463Buffer[  4  ] ){
 case Setup_Hard_Discover:
 memset( pcTempConvBuffer, '\0',  66  );
 memset( pcTempBuffer, '\0',  66  );
 for( usCounter = 0; usCounter < 12; usCounter++ ){
 pcTempBuffer[ usCounter ] = pcRxRF4463Buffer[  5  + usCounter ];
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
 else if( pcRxRF4463Buffer[  1  ] ==  1  ){
 switch( pcRxRF4463Buffer[  3  ] ){
 case Table_RF_Setup:
 switch( pcRxRF4463Buffer[  4  ] ){
 case Setup_Qr:
 memset( pcTempConvBuffer, '\0',  66  );
 for( usCounter = 0; usCounter < 12; usCounter++ ){
 pcTempBuffer[ usCounter ] = pcRxRF4463Buffer[  5  + usCounter ];
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
 case Setup_Hard_Discover:
 memset( pcTempConvBuffer, '\0',  66  );
 memset( pcTempBuffer, '\0',  66  );
 for( usCounter = 0; usCounter < 12; usCounter++ ){
 pcTempBuffer[ usCounter ] = pcRxRF4463Buffer[  5  + usCounter ];
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


 if( pcRxRF4463Buffer[  1  ] ==  254  ){
 switch( pcRxRF4463Buffer[  3  ] ){
 case Table_RF_Test:
 switch( pcRxRF4463Buffer[  4  ] ){

 case Test_Device_Loop:


 ucRemoteNode =  255 ;
 ucSenderNode =  254 ;
 ucTableIndex = Table_RF_Test;
 ucCommandIndex = Test_Device_Loop;
 vRfTxMessage(&pcRxRF4463Buffer[ 5 ], (pcRxRF4463Buffer[  0 ]- 5 ));

 break;

 default :
 break;
 }
 break;
 }
 }
 }
 }
 else{
 ucRF4463TxEvent = 0;
 }

  GPIOC_ODR._GPIO_PIN_6  =  0 ;

 ucRf4463RxInit();
}
#line 385 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463handler.c"
void vRfTxMessage( uint8_t * pcOutBuffer, uint16_t usLength ){
 uint16_t usCounter = 0;
 uint8_t pcTemp[ 10 ];

 memset( pcTxRF4463Buffer, '\0', sizeof( pcTxRF4463Buffer ) );

 if( usLength + 5 >=  66  ){

 return;
 }
#line 411 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463handler.c"
 pcTxRF4463Buffer[  0  ] =  5  + usLength;
 pcTxRF4463Buffer[  1  ] = ucRemoteNode;
 pcTxRF4463Buffer[  2  ] = ucSenderNode;
 pcTxRF4463Buffer[  3  ] = ucTableIndex;
 pcTxRF4463Buffer[  4  ] = ucCommandIndex;

 if( usLength > 0 ){
 for( usCounter = 0; usCounter < usLength; usCounter++ ){
 pcTxRF4463Buffer[  5  + usCounter ] = pcOutBuffer[ usCounter ];
 }
 }


 UART1_Write_Text( "[ RF4463 TX ] Packet: " );
 for( usCounter = 0; usCounter < pcTxRF4463Buffer[  0  ]; usCounter++ ){
 UART1_Write( pcTxRF4463Buffer[ usCounter ] );
 }
 UART1_Write( '\r' );
 UART1_Write( '\n' );


 ucRf4463TxPacket( pcTxRF4463Buffer, pcTxRF4463Buffer[  0  ] );

 ucRf4463RxInit();
}
#line 440 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463handler.c"
void vRfSettingsHotSwap( uint8_t ucRfChannel, uint16_t usNetwork ){
 uint8_t pcBuffer[ 5 ];
 uint8_t pcTemp[ 15 ];

 ucRf4463EnterStandbyMode();
 xRadioParameters.Channel = ucRfChannel;
 xRadioParameters.Network = usNetwork;

 pcBuffer[ 0 ] = ( xRadioParameters.Network >> 8 );
 pcBuffer[ 1 ] = xRadioParameters.Network;
 ucRf4463SetSyncWords( pcBuffer, 2 );


 UART1_Write_Text( "[ RF4463 CFG ] Channel: " );
 ByteToStr( xRadioParameters.Channel, pcTemp );
 UART1_Write_Text( pcTemp );
 UART1_Write( '\r' );
 UART1_Write( '\n' );

 UART1_Write_Text( "[ RF4463 CFG ] Network: " );
 IntToStr( xRadioParameters.Network, pcTemp );
 UART1_Write_Text( pcTemp );
 UART1_Write( '\r' );
 UART1_Write( '\n' );


 ucRf4463ClearInterrupts();

 ucRf4463RxInit();
}
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.h"
#line 27 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
const uint8_t RF4463_CONFIGURATION_DATA[] =  { 0x08,0x04,0x21,0x71,0x4B,0x00,0x00,0xDC,0x95, 0x08,0x05,0xA6,0x22,0x21,0xF0,0x41,0x5B,0x26, 0x08,0xE2,0x2F,0x1C,0xBB,0x0A,0xA8,0x94,0x28, 0x08,0x05,0x87,0x67,0xE2,0x58,0x1A,0x07,0x5B, 0x08,0xE1,0xD0,0x72,0xD8,0x8A,0xB8,0x5B,0x7D, 0x08,0x05,0x11,0xEC,0x9E,0x28,0x23,0x1B,0x6D, 0x08,0xE2,0x4F,0x8A,0xB2,0xA9,0x29,0x14,0x13, 0x08,0x05,0xD1,0x2E,0x71,0x6A,0x51,0x4C,0x2C, 0x08,0xE5,0x80,0x27,0x42,0xA4,0x69,0xB0,0x7F, 0x08,0x05,0xAA,0x81,0x2A,0xBD,0x45,0xE8,0xA8, 0x08,0xEA,0xE4,0xF0,0x24,0xC9,0x9F,0xCC,0x3C, 0x08,0x05,0x08,0xF5,0x05,0x04,0x27,0x62,0x98, 0x08,0xEA,0x6B,0x62,0x84,0xA1,0xF9,0x4A,0xE2, 0x08,0x05,0xE9,0x77,0x05,0x4F,0x84,0xEE,0x35, 0x08,0xE2,0x43,0xC3,0x8D,0xFB,0xAD,0x54,0x25, 0x08,0x05,0x14,0x06,0x5E,0x39,0x36,0x2F,0x45, 0x08,0xEA,0x0C,0x1C,0x74,0xD0,0x11,0xFC,0x32, 0x08,0x05,0xDA,0x38,0xBA,0x0E,0x3C,0xE7,0x8B, 0x08,0xEA,0xB0,0x09,0xE6,0xFF,0x94,0xBB,0xA9, 0x08,0x05,0xD7,0x11,0x29,0xFE,0xDC,0x71,0xD5, 0x08,0xEA,0x7F,0x83,0xA7,0x60,0x90,0x62,0x18, 0x08,0x05,0x84,0x7F,0x6A,0xD1,0x91,0xC6,0x52, 0x08,0xEA,0x2A,0xD8,0x7B,0x8E,0x4A,0x9F,0x91, 0x08,0x05,0xBD,0xAA,0x9D,0x16,0x18,0x06,0x15, 0x08,0xE2,0x55,0xAD,0x2D,0x0A,0x14,0x1F,0x5D, 0x08,0x05,0xD3,0xE0,0x7C,0x39,0xCF,0x01,0xF0, 0x08,0xEF,0x3A,0x91,0x72,0x6A,0x03,0xBB,0x96, 0x08,0xE7,0x83,0x6D,0xA4,0x92,0xFC,0x13,0xA7, 0x08,0xEF,0xF8,0xFD,0xCF,0x62,0x07,0x6F,0x1E, 0x08,0xE7,0x4C,0xEA,0x4A,0x75,0x4F,0xD6,0xCF, 0x08,0xE2,0xF6,0x11,0xE4,0x26,0x0D,0x4D,0xC6, 0x08,0x05,0xFB,0xBF,0xE8,0x07,0x89,0xC3,0x51, 0x08,0xEF,0x82,0x27,0x04,0x3F,0x96,0xA8,0x58, 0x08,0xE7,0x41,0x29,0x3C,0x75,0x2A,0x03,0x1C, 0x08,0xEF,0xAF,0x59,0x98,0x36,0xAA,0x0F,0x06, 0x08,0xE6,0xF6,0x93,0x41,0x2D,0xEC,0x0E,0x99, 0x08,0x05,0x29,0x19,0x90,0xE5,0xAA,0x36,0x40, 0x08,0xE7,0xFB,0x68,0x10,0x7D,0x77,0x5D,0xC0, 0x08,0xE7,0xCB,0xB4,0xDD,0xCE,0x90,0x54,0xBE, 0x08,0xE7,0x72,0x8A,0xD6,0x02,0xF4,0xDD,0xCC, 0x08,0xE7,0x6A,0x21,0x0B,0x02,0x86,0xEC,0x15, 0x08,0xE7,0x7B,0x7C,0x3D,0x6B,0x81,0x03,0xD0, 0x08,0xEF,0x7D,0x61,0x36,0x94,0x7C,0xA0,0xDF, 0x08,0xEF,0xCC,0x85,0x3B,0xDA,0xE0,0x5C,0x1C, 0x08,0xE7,0xE3,0x75,0xBB,0x39,0x22,0x4B,0xA8, 0x08,0xEF,0xF9,0xCE,0xE0,0x5E,0xEB,0x1D,0xCB, 0x08,0xE7,0xBD,0xE2,0x70,0xD5,0xAB,0x4E,0x3F, 0x08,0xE7,0xB7,0x8D,0x20,0x68,0x6B,0x09,0x52, 0x08,0xEF,0xA1,0x1B,0x90,0xCD,0x98,0x00,0x63, 0x08,0xEF,0x54,0x67,0x5D,0x9C,0x11,0xFC,0x45, 0x08,0xE7,0xD4,0x9B,0xC8,0x97,0xBE,0x8A,0x07, 0x08,0xEF,0x52,0x8D,0x90,0x63,0x73,0xD5,0x2A, 0x08,0xEF,0x03,0xBC,0x6E,0x1C,0x76,0xBE,0x4A, 0x08,0xE7,0xC2,0xED,0x67,0xBA,0x5E,0x66,0x21, 0x08,0xEF,0xE7,0x3F,0x87,0xBE,0xE0,0x7A,0x6D, 0x08,0xE7,0xC9,0x70,0x93,0x1D,0x64,0xF5,0x6C, 0x08,0xEF,0xF5,0x28,0x08,0x34,0xB3,0xB6,0x2C, 0x08,0xEF,0x3A,0x0A,0xEC,0x0F,0xDB,0x56,0xCA, 0x08,0xEF,0x39,0xA0,0x6E,0xED,0x79,0xD0,0x24, 0x08,0xE7,0x6C,0x0B,0xAF,0xA9,0x4E,0x40,0xB5, 0x08,0xE9,0xB9,0xAF,0xBF,0x25,0x50,0xD1,0x37, 0x08,0x05,0x9E,0xDB,0xDE,0x3F,0x94,0xE9,0x6B, 0x08,0xEC,0xC5,0x05,0xAA,0x57,0xDC,0x8A,0x5E, 0x08,0x05,0x70,0xDA,0x84,0x84,0xDD,0xCA,0x90 , 0x07, 0x02, 0x01, 0x00, 0x01, 0xC9, 0xC3, 0x80 , 0x08, 0x13, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 , 0x06, 0x11, 0x00, 0x02, 0x00, 0x52, 0x00 , 0x05, 0x11, 0x00, 0x01, 0x03, 0x20 , 0x05, 0x11, 0x01, 0x01, 0x00, 0x00 , 0x08, 0x11, 0x02, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00 , 0x0D, 0x11, 0x10, 0x09, 0x00, 0x00, 0x14, 0x00, 0x0F, 0x11, 0x00, 0x00, 0x00, 0x00 , 0x0A, 0x11, 0x11, 0x06, 0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00 , 0x10, 0x11, 0x12, 0x0C, 0x00, 0x04, 0x01, 0x08, 0xFF, 0xFF, 0x20, 0x02, 0x00, 0x00, 0x00, 0x00, 0x30 , 0x10, 0x11, 0x12, 0x0C, 0x0C, 0x30, 0x00, 0x1E, 0x04, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 , 0x10, 0x11, 0x12, 0x0C, 0x18, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 , 0x10, 0x11, 0x12, 0x0C, 0x24, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 , 0x09, 0x11, 0x12, 0x05, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00 , 0x08, 0x11, 0x12, 0x04, 0x36, 0x00, 0x00, 0x00, 0x00 , 0x10, 0x11, 0x20, 0x0C, 0x00, 0x02, 0x00, 0x07, 0x00, 0x5D, 0xC0, 0x01, 0xC9, 0xC3, 0x80, 0x00, 0x00 , 0x05, 0x11, 0x20, 0x01, 0x0C, 0xA8 , 0x10, 0x11, 0x20, 0x0C, 0x18, 0x01, 0x80, 0x08, 0x03, 0xC0, 0x00, 0x22, 0x20, 0x0C, 0xE8, 0x03, 0x0D , 0x10, 0x11, 0x20, 0x0C, 0x24, 0x00, 0xA7, 0xC6, 0x00, 0x54, 0x02, 0xC2, 0x00, 0x04, 0x23, 0x80, 0x01 , 0x07, 0x11, 0x20, 0x03, 0x30, 0x60, 0x7B, 0x80 , 0x05, 0x11, 0x20, 0x01, 0x35, 0xE0 , 0x10, 0x11, 0x20, 0x0C, 0x38, 0x11, 0xAB, 0xAB, 0x80, 0x02, 0xFF, 0xFF, 0x00, 0x2B, 0x0C, 0xA4, 0x22 , 0x0E, 0x11, 0x20, 0x0A, 0x45, 0x81, 0x01, 0x47, 0x01, 0x00, 0xFF, 0x06, 0x00, 0x18, 0x40 , 0x06, 0x11, 0x20, 0x02, 0x50, 0x84, 0x08 , 0x06, 0x11, 0x20, 0x02, 0x54, 0x03, 0x07 , 0x05, 0x11, 0x20, 0x01, 0x57, 0x00 , 0x09, 0x11, 0x20, 0x05, 0x5B, 0x40, 0x04, 0x06, 0x78, 0x20 , 0x10, 0x11, 0x21, 0x0C, 0x00, 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1, 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11 , 0x10, 0x11, 0x21, 0x0C, 0x0C, 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00, 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1 , 0x10, 0x11, 0x21, 0x0C, 0x18, 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11, 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00 , 0x08, 0x11, 0x22, 0x04, 0x00, 0x08, 0x7F, 0x00, 0x1D , 0x0B, 0x11, 0x23, 0x07, 0x00, 0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03 , 0x10, 0x11, 0x30, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 , 0x0C, 0x11, 0x40, 0x08, 0x00, 0x3B, 0x09, 0x55, 0x55, 0x88, 0x89, 0x20, 0xFF , 0x00 } ;
#line 38 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
uint8_t ucRf4463Init(){
 uint8_t pcBuffer[ 20 ];
#line 43 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
 vRf4463PowerOnReset();

 vRf4463SetConfiguration( RF4463_CONFIGURATION_DATA, sizeof( RF4463_CONFIGURATION_DATA ) );
#line 51 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
 pcBuffer[ 0 ] =  0 ;
 pcBuffer[ 1 ] =  0 ;
 pcBuffer[ 2 ] =  33 ;
 pcBuffer[ 3 ] =  32 ;
 pcBuffer[ 4 ] =  39 ;
 pcBuffer[ 5 ] =  11 ;
 ucRf4463SetCommand( 6,  0x13 , pcBuffer );
 memset( pcBuffer, 20, '\0' );
#line 63 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
 pcBuffer[ 0 ] = 98;
 ucRf4463SetProperty(  0x0000 , 1, pcBuffer );
 memset( pcBuffer, 20, '\0' );
#line 70 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
 pcBuffer[ 0 ] = 0x00;
 ucRf4463SetProperty(  0x0003 , 1, pcBuffer );
 memset( pcBuffer, 20, '\0' );
#line 77 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
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
#line 91 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
 pcBuffer[ 0 ] = ( xRadioParameters.Network >> 8 );
 pcBuffer[ 1 ] = ( xRadioParameters.Network );
 ucRf4463SetSyncWords( pcBuffer, 2 );
#line 98 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
 pcBuffer[ 0 ] =  0x80  |  0x01 ;
 ucRf4463SetProperty(  0x1200 , 1, pcBuffer );

 pcBuffer[ 0 ] =  0x02 ;
 ucRf4463SetProperty(  0x1206 , 1, pcBuffer );

 pcBuffer[ 0 ] =  0x08  |  0x02 ;
 pcBuffer[ 1 ] =  0x01 ;
 pcBuffer[ 2 ] = 0x00;
 ucRf4463SetProperty(  0x1208 , 3, pcBuffer );
#line 112 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
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
#line 139 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
 pcBuffer[ 0 ] = 0x01;
 ucRf4463SetProperty(  0x204c , 1, pcBuffer );
#line 145 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
 pcBuffer[ 0 ] = 0x01;
 pcBuffer[ 1 ] = 0x38;
 pcBuffer[ 2 ] = 0x00;
 ucRf4463SetProperty(  0x0100 , 3, pcBuffer );
#line 153 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
 ucRf4463SetTxPower( xRadioParameters.TxPower );
}
#line 159 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
void vRf4463PowerOnReset(){
#line 172 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
 uint8_t pcBuffer[ 7 ] = {  0x02, 0x01, 0x00, 0x01, 0xC9, 0xC3, 0x80  };

  GPIOB_ODR._GPIO_PIN_11  = 1;
 Delay_us( 10 );
  GPIOB_ODR._GPIO_PIN_11  = 0;
 Delay_ms( 6 );

  GPIOB_ODR._GPIO_PIN_12  = 0;
 vRf4463SPIWriteBuffer( sizeof( pcBuffer ), pcBuffer );
  GPIOB_ODR._GPIO_PIN_12  = 1;
}
#line 190 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
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
#line 213 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
uint8_t ucRf4463SetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer ){
 if( ucRf4463CheckCTS() ==  1  ){
 return  1 ;
 }

  GPIOB_ODR._GPIO_PIN_12  = 0;
 ucRf4463SPIByte( ucCommand );
 vRf4463SPIWriteBuffer( ucLength, pcParametersBuffer );
  GPIOB_ODR._GPIO_PIN_12  = 1;

 return  0 ;
}
#line 230 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
uint8_t ucRf4463GetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer ){
 if( ucRf4463CheckCTS() ==  1  ){
 return  1 ;
 }

  GPIOB_ODR._GPIO_PIN_12  = 0;
 ucRf4463SPIByte( ucCommand );
  GPIOB_ODR._GPIO_PIN_12  = 1;

 if( ucRf4463CheckCTS() ==  1  ){
 return  1 ;
 }

  GPIOB_ODR._GPIO_PIN_12  = 0;
 ucRf4463SPIByte(  0x44  );
 vRf4463SPIReadBuffer( ucLength, pcParametersBuffer );
  GPIOB_ODR._GPIO_PIN_12  = 1;

 return  0 ;
}
#line 254 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
uint8_t ucRf4463SetProperty( uint16_t usStartProperty, uint8_t ucLength, uint8_t * pcParametersBuffer ){
 uint8_t pcBuffer[ 4 ];

 if( ucRf4463CheckCTS() ==  1  ){
 return  1 ;
 }

 pcBuffer[ 0 ] =  0x11 ;
 pcBuffer[ 1 ] = ( usStartProperty >> 8 );
 pcBuffer[ 2 ] = ucLength;
 pcBuffer[ 3 ] = ( usStartProperty & 0xFF );

  GPIOB_ODR._GPIO_PIN_12  = 0;
 vRf4463SPIWriteBuffer( 4, pcBuffer );
 vRf4463SPIWriteBuffer( ucLength, pcParametersBuffer );
  GPIOB_ODR._GPIO_PIN_12  = 1;

 return  0 ;
}
#line 277 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
uint8_t ucRf4463GetProperty( uint16_t usStartProperty, uint8_t ucLength, uint8_t * pcParametersBuffer ){
 uint8_t pcBuffer[ 4 ];

 if( ucRf4463CheckCTS() ==  1  ){
 return  1 ;
 }

 pcBuffer[ 0 ] =  0x12 ;
 pcBuffer[ 1 ] = ( usStartProperty >> 8 );
 pcBuffer[ 2 ] = ucLength;
 pcBuffer[ 3 ] = ( usStartProperty & 0xFF );

  GPIOB_ODR._GPIO_PIN_12  = 0;
 vRf4463SPIWriteBuffer( 4, pcBuffer );

 if( ucRf4463CheckCTS() ==  1  ){
 return  1 ;
 }

  GPIOB_ODR._GPIO_PIN_12  = 0;
 ucRf4463SPIByte(  0x44  );
 vRf4463SPIReadBuffer( ucLength, pcParametersBuffer );
  GPIOB_ODR._GPIO_PIN_12  = 1;

 return  0 ;
}
#line 307 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
uint8_t ucRf4463SetSyncWords( uint8_t * pcSyncWords, uint8_t ucLength ){
 uint8_t pcBuffer[ 5 ];

 if( ( ucLength == 0 ) || ( ucLength > 3 ) ){
 return  1 ;
 }

 pcBuffer[ 0 ] = ucLength - 1;
 memcpy( pcBuffer + 1, pcSyncWords, ucLength );
 return ucRf4463SetProperty(  0x1100 , sizeof( pcBuffer ), pcBuffer );
}
#line 322 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
uint8_t ucRf4463SetPreambleLength( uint8_t ucLength ){
 return ucRf4463SetProperty(  0x1000 , 1, &ucLength );
}
#line 332 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
uint8_t ucRf4463CheckCTS(){
 uint16_t usTimeoutCounter = 0;

 usTimeoutCounter =  2500 ;

 while( usTimeoutCounter-- ){
  GPIOB_ODR._GPIO_PIN_12  = 0;
 ucRf4463SPIByte(  0x44  );
 if( ucRf4463SPIByte(  0x44  ) ==  0xff  ){
  GPIOB_ODR._GPIO_PIN_12  = 1;
 return  0 ;
 }
  GPIOB_ODR._GPIO_PIN_12  = 1;
 }
 return  1 ;
}
#line 352 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
void vRf4463RSSI(){
 signed char xRSSI;
 uint8_t pcRSSI[ 9 ];
#line 385 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
 ucRf4463GetCommand( 9,  0x22  , pcRSSI );
 xRSSI = ( ( ( pcRSSI[ 4 ] / 2 ) -64 ) - 60 );

  PrintOut( vDebugPrint , "[ RF4463 ] RSSI: %i\r\n", xRSSI ) ;
}
#line 394 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
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
#line 417 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
uint8_t ucRf4463SetGPIOMode( uint8_t ucGPIO0Mode, uint8_t ucGPIO1Mode ){
 uint8_t pcBuffer[ 6 ] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };

 pcBuffer[ 0 ] = ucGPIO0Mode;
 pcBuffer[ 1 ] = ucGPIO1Mode;

 return ucRf4463SetCommand( sizeof( pcBuffer ),  0x13 , pcBuffer );
}
#line 429 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
void vRf4463FIFOReset(){
 uint8_t ucData = 0x03;

 ucRf4463SetCommand( sizeof( ucData ),  0x15 , &ucData );
}
#line 438 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
uint8_t ucRf4463ClearInterrupts(){
 uint8_t pcBuffer[] = { 0x00, 0x00, 0x00 };

 return ucRf4463SetCommand( sizeof( pcBuffer ),  0x20 , pcBuffer );
}
#line 447 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
uint8_t ucRf4463EnterStandbyMode(){
 uint8_t ucData = 0x01;

 return ucRf4463SetCommand( 1,  0x34 , &ucData );
}
#line 456 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
uint8_t ucRf4463EnterReadyMode(){
 uint8_t ucData = 0x03;

 return ucRf4463SetCommand( 1,  0x34 , &ucData );
}
#line 465 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
uint8_t ucRf4463WaitnIRQ(){
 return  GPIOC_IDR._GPIO_PIN_12 ;
}
#line 475 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
void vRf4463EnterTxMode(){
 uint8_t pcBuffer[] = { 0x00, 0x30, 0x00, 0x00 };
 pcBuffer[ 0 ] = xRadioParameters.Channel;
 ucRf4463SetCommand( 4,  0x31 , pcBuffer );
}
#line 484 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
uint8_t ucRf4463SetTxInterrupt(){
 uint8_t pcBuffer[ 3 ] = { 0x01, 0x20, 0x00 };
 return ucRf4463SetProperty(  0x0100 , 3, pcBuffer );
}
#line 492 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
uint8_t ucRf4463SetTxPower( uint8_t ucPower ){
 uint8_t pcBuffer[] = { 0x08, 0x00, 0x00, 0x3D };

 if( ucPower > 127 ){
  PrintOut( vDebugPrint , "[ Rf4463 ] Invalid Power Value: %d\r\n", ucPower ) ;
 ucPower = 127;
 }

 pcBuffer[ 1 ] = ucPower;

 return ucRf4463SetProperty(  0x2200 , sizeof( pcBuffer ), pcBuffer );
}
#line 509 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
void vRf4463WriteTxFIFO( uint8_t * pcWriteBuffer, uint8_t ucLength ){
 uint8_t pcBuffer[ 66 ];


 ucRf4463SetProperty(  0x1212 , 1, &ucLength );

 pcBuffer[ 0 ] = ucLength;

 memcpy( pcBuffer + 1, pcWriteBuffer, ucLength );

 ucRf4463SetCommand( ucLength + 1,  0x66 , pcBuffer );
}
#line 525 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
uint8_t ucRf4463TxPacket( uint8_t * pcTxBuffer, uint8_t ucTxLength ){
 uint8_t pcBuffer[ 3 ];

 ucRF4463TxEvent = 0;

 vRf4463FIFOReset();

 vRf4463WriteTxFIFO( pcTxBuffer, ucTxLength );

 ucRf4463ClearInterrupts();

 vRf4463EnterTxMode();

 ucRF4463TxEvent = 1;

 for( ;; ){
 if( ucRadioEvent == 1 ){
 break;
 }
 Delay_us( 1 );
 }

 ucRf4463GetCommand( 3,  0x33 , pcBuffer );

 return  0 ;
}
#line 559 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
void vRf4463EnterRxMode(){
 uint8_t pcBuffer[] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x08 };
 pcBuffer[ 0 ] = xRadioParameters.Channel;
 ucRf4463SetCommand( 7,  0x32 , pcBuffer );
}
#line 568 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
uint8_t ucRf4463SetRxInterrupt(){
 uint8_t pcBuffer[ 3 ] = { 0x03, 0x18, 0x00 };
 return ucRf4463SetProperty(  0x0100 , 3, pcBuffer );
}
#line 576 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
uint8_t ucRf4463RxInit(){
 uint8_t ucLength = 0;

 ucLength = 66;

 ucRf4463SetProperty(  0x1212 , 1, &ucLength );

 vRf4463FIFOReset();



 vRf4463EnterRxMode();

 return  0 ;
}
#line 595 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
uint8_t ucRf4463RxPacket( uint8_t * pcRxBuffer ){
 uint8_t ucRxLength = 0;

 vRf4463ReadRxFIFO( pcRxBuffer );

 vRf4463FIFOReset();

 return ucRxLength;
}
#line 608 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463pro.c"
void vRf4463ReadRxFIFO( uint8_t * pcBuffer ){
 uint8_t * pcReadLength;

 if( ucRf4463CheckCTS() ==  1  ){
 return;
 }

  GPIOB_ODR._GPIO_PIN_12  = 0;

 ucRf4463SPIByte(  0x77  );
 vRf4463SPIReadBuffer( 1, ( uint8_t * )&pcReadLength );
 vRf4463SPIReadBuffer( 66, pcBuffer );

  GPIOB_ODR._GPIO_PIN_12  = 1;

 return;
}
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463spi.c"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463spi.h"
#line 35 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463spi.c"
void vRf4463SPIWriteBuffer( uint16_t usWriteLength, uint8_t * pcWriteBuffer ){
#line 39 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463spi.c"
 while( usWriteLength-- ){
 ucRf4463SPIByte( *pcWriteBuffer++ );
 }
}
#line 50 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463spi.c"
void vRf4463SPIReadBuffer( uint16_t usReadLength, uint8_t * pcReadBuffer ){
 uint8_t ucRxCounter = 0;
#line 55 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463spi.c"
 while( usReadLength-- ){
 pcReadBuffer[ ucRxCounter++ ] = ucRf4463SPIByte( 0 );
 }
}
#line 66 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/rf4463spi.c"
uint8_t ucRf4463SPIByte( uint8_t pcWriteData ){
 return SPI2_Read( pcWriteData );
}
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/buttonhandler.c"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/buttonhandler.h"
#line 37 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/buttonhandler.c"
void vButtonISR() iv IVT_INT_EXTI9_5 ics ICS_AUTO{
 if( EXTI_PR.B8 ){
 EXTI_PR.B8 |= 1;


 }
}
#line 51 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/buttonhandler.c"
void vButtonSetup(){
 GPIO_Digital_Input( &GPIOB_BASE, _GPIO_PINMASK_8 );
#line 57 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/buttonhandler.c"
 RCC_APB2ENRbits.AFIOEN = 1;
#line 61 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/buttonhandler.c"
 AFIO_EXTICR3 |= 0x0001;
#line 65 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/buttonhandler.c"
 EXTI_IMR.B8 |= 1;
 EXTI_FTSR.B8 |= 1;

 NVIC_IntEnable( IVT_INT_EXTI9_5 );


}
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/timer.c"
#line 1 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/timer.h"
#line 37 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/timer.c"
void Timer6_interrupt() iv IVT_INT_TIM6 {
 TIM6_SR.UIF = 0;

  GPIOC_ODR._GPIO_PIN_7  = ~ GPIOC_ODR._GPIO_PIN_7 ;
}
#line 49 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/timer.c"
void vTimerStop( uint8_t ucTimer ){
 if( ucTimer == TIMER_SEARCH ){
 TIM6_CR1.CEN = 0;
 }
}
#line 58 "c:/users/crow/onedrive/escritorio/proyect radio si4463pro/firmware dongle/dongle ( stm32f107rc ) [ mikroc ] 26 junio 2020/timer.c"
void vTimerSearchLed(){
 RCC_APB1ENR.TIM6EN = 1;
 TIM6_CR1.CEN = 0;
 TIM6_PSC = 575;
 TIM6_ARR = 62499;
 NVIC_IntEnable(IVT_INT_TIM6);
 TIM6_DIER.UIE = 1;
 TIM6_CR1.CEN = 1;
}
#line 66 "C:/Users/Crow/OneDrive/Escritorio/Proyect Radio SI4463Pro/Firmware Dongle/Dongle ( STM32F107RC ) [ MikroC ] 26 Junio 2020/main.c"
void main(){
 Delay_ms( 1000 );
#line 71 "C:/Users/Crow/OneDrive/Escritorio/Proyect Radio SI4463Pro/Firmware Dongle/Dongle ( STM32F107RC ) [ MikroC ] 26 Junio 2020/main.c"
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
  PrintOut( vDebugPrint , "TEST\r\n", 0  ) ;
#line 88 "C:/Users/Crow/OneDrive/Escritorio/Proyect Radio SI4463Pro/Firmware Dongle/Dongle ( STM32F107RC ) [ MikroC ] 26 Junio 2020/main.c"
 vRadioInit();
#line 92 "C:/Users/Crow/OneDrive/Escritorio/Proyect Radio SI4463Pro/Firmware Dongle/Dongle ( STM32F107RC ) [ MikroC ] 26 Junio 2020/main.c"
  GPIOC_ODR._GPIO_PIN_6  = 0;
  GPIOC_ODR._GPIO_PIN_8  = 0;
#line 97 "C:/Users/Crow/OneDrive/Escritorio/Proyect Radio SI4463Pro/Firmware Dongle/Dongle ( STM32F107RC ) [ MikroC ] 26 Junio 2020/main.c"
 vDongleLoop();
}
