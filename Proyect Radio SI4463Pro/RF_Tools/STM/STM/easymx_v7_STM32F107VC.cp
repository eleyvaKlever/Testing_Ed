#line 1 "C:/Users/Crow/Desktop/STM/STM/easymx_v7_STM32F107VC.c"
#line 1 "c:/users/crow/desktop/stm/stm/easymx_v7_stm32f107vc.h"
#line 1 "c:/users/crow/desktop/stm/stm/__t_stm32.h"
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
#line 16 "c:/users/crow/desktop/stm/stm/__t_stm32.h"
typedef uint8_t T_gpio_dir;
typedef uint8_t T_mikrobus_soc;
typedef uint8_t T_mikrobus_pin;
typedef uint8_t T_mikrobus_ret;




typedef void (*T_gpio_setFp) (uint8_t);
typedef uint8_t (*T_gpio_getFp) ();


typedef uint8_t T_log_bus;
typedef uint8_t T_log_format;
typedef void (*T_log_writeFp) (unsigned int);



typedef void (*T_spi_writeFp) (unsigned int);
typedef unsigned int (*T_spi_readFp) (unsigned int);
#line 53 "c:/users/crow/desktop/stm/stm/__t_stm32.h"
typedef struct
{
 T_gpio_setFp gpioSet[ 12 ];
 T_gpio_getFp gpioGet[ 12 ];

}T_gpio_obj;



typedef struct
{
 T_spi_writeFp spiWrite;
 T_spi_readFp spiRead;

}T_spi_obj;
#line 39 "c:/users/crow/desktop/stm/stm/easymx_v7_stm32f107vc.h"
extern const uint8_t _GPIO_OUTPUT;
extern const uint8_t _GPIO_INPUT;

extern const uint8_t _MIKROBUS_AN_PIN;
extern const uint8_t _MIKROBUS_RST_PIN;
extern const uint8_t _MIKROBUS_CS_PIN;
extern const uint8_t _MIKROBUS_SCK_PIN;
extern const uint8_t _MIKROBUS_MISO_PIN;
extern const uint8_t _MIKROBUS_MOSI_PIN;
extern const uint8_t _MIKROBUS_PWM_PIN;
extern const uint8_t _MIKROBUS_INT_PIN;
extern const uint8_t _MIKROBUS_RX_PIN;
extern const uint8_t _MIKROBUS_TX_PIN;
extern const uint8_t _MIKROBUS_SCL_PIN;
extern const uint8_t _MIKROBUS_SDA_PIN;

extern const uint8_t _MIKROBUS_OK;
extern const uint8_t _MIKROBUS_ERR_BUS;
extern const uint8_t _MIKROBUS_ERR_PIN;


extern const uint8_t _MIKROBUS_ERR_SPI;
#line 69 "c:/users/crow/desktop/stm/stm/easymx_v7_stm32f107vc.h"
extern const uint8_t _LOG_BYTE;
extern const uint8_t _LOG_TEXT;
extern const uint8_t _LOG_LINE;






extern const uint8_t _MIKROBUS1;

extern const T_gpio_obj _MIKROBUS1_GPIO;


extern const T_spi_obj _MIKROBUS1_SPI;
#line 94 "c:/users/crow/desktop/stm/stm/easymx_v7_stm32f107vc.h"
extern const uint8_t _MIKROBUS2;

extern const T_gpio_obj _MIKROBUS2_GPIO;


extern const T_spi_obj _MIKROBUS2_SPI;
#line 178 "c:/users/crow/desktop/stm/stm/easymx_v7_stm32f107vc.h"
extern const uint8_t _LOG_USBUART_A;


extern const uint8_t _LOG_USBUART_B;
#line 188 "c:/users/crow/desktop/stm/stm/easymx_v7_stm32f107vc.h"
T_mikrobus_ret mikrobus_gpioInit(T_mikrobus_soc bus, T_mikrobus_pin pin, T_gpio_dir direction);



T_mikrobus_ret mikrobus_spiInit(T_mikrobus_soc bus, const uint32_t *cfg);
#line 207 "c:/users/crow/desktop/stm/stm/easymx_v7_stm32f107vc.h"
T_mikrobus_ret mikrobus_logInit(T_log_bus port, const uint32_t baud);
T_mikrobus_ret mikrobus_logWrite(uint8_t* data_, T_log_format format);
#line 1 "c:/users/crow/desktop/stm/stm/__em_f107vc_gpio.c"
#line 1 "c:/users/crow/desktop/stm/stm/__t_stm32.h"
#line 13 "c:/users/crow/desktop/stm/stm/__em_f107vc_gpio.c"
const uint8_t _MIKROBUS_ERR_PIN = 1;

const uint8_t _GPIO_OUTPUT = 0;
const uint8_t _GPIO_INPUT = 1;

const uint8_t _MIKROBUS_AN_PIN = 0;
const uint8_t _MIKROBUS_RST_PIN = 1;
const uint8_t _MIKROBUS_CS_PIN = 2;
const uint8_t _MIKROBUS_SCK_PIN = 3;
const uint8_t _MIKROBUS_MISO_PIN = 4;
const uint8_t _MIKROBUS_MOSI_PIN = 5;
const uint8_t _MIKROBUS_PWM_PIN = 6;
const uint8_t _MIKROBUS_INT_PIN = 7;
const uint8_t _MIKROBUS_RX_PIN = 8;
const uint8_t _MIKROBUS_TX_PIN = 9;
const uint8_t _MIKROBUS_SCL_PIN = 10;
const uint8_t _MIKROBUS_SDA_PIN = 11;

static uint8_t _getAN_1 () { return GPIOA_IDR.B4 ; }
static uint8_t _getRST_1 () { return GPIOC_IDR.B2 ; }
static uint8_t _getCS_1 () { return GPIOD_IDR.B13; }
static uint8_t _getSCK_1 () { return GPIOC_IDR.B10; }
static uint8_t _getMISO_1() { return GPIOC_IDR.B11; }
static uint8_t _getMOSI_1() { return GPIOC_IDR.B12; }
static uint8_t _getPWM_1 () { return GPIOA_IDR.B0 ; }
static uint8_t _getINT_1 () { return GPIOD_IDR.B10; }
static uint8_t _getRX_1 () { return GPIOD_IDR.B9 ; }
static uint8_t _getTX_1 () { return GPIOD_IDR.B8 ; }
static uint8_t _getSCL_1 () { return GPIOB_IDR.B6 ; }
static uint8_t _getSDA_1 () { return GPIOB_IDR.B7 ; }
static void _setAN_1 (uint8_t value) { GPIOA_ODR.B4 = value; }
static void _setRST_1 (uint8_t value) { GPIOC_ODR.B2 = value; }
static void _setCS_1 (uint8_t value) { GPIOD_ODR.B13 = value; }
static void _setSCK_1 (uint8_t value) { GPIOC_ODR.B10 = value; }
static void _setMISO_1(uint8_t value) { GPIOC_ODR.B11 = value; }
static void _setMOSI_1(uint8_t value) { GPIOC_ODR.B12 = value; }
static void _setPWM_1 (uint8_t value) { GPIOA_ODR.B0 = value; }
static void _setINT_1 (uint8_t value) { GPIOD_ODR.B10 = value; }
static void _setRX_1 (uint8_t value) { GPIOD_ODR.B9 = value; }
static void _setTX_1 (uint8_t value) { GPIOD_ODR.B8 = value; }
static void _setSCL_1 (uint8_t value) { GPIOB_ODR.B6 = value; }
static void _setSDA_1 (uint8_t value) { GPIOB_ODR.B7 = value; }

static uint8_t _getAN_2 () { return GPIOA_IDR.B5 ; }
static uint8_t _getRST_2 () { return GPIOC_IDR.B3 ; }
static uint8_t _getCS_2 () { return GPIOD_IDR.B14; }
static uint8_t _getSCK_2 () { return GPIOC_IDR.B10; }
static uint8_t _getMISO_2() { return GPIOC_IDR.B11; }
static uint8_t _getMOSI_2() { return GPIOC_IDR.B12; }
static uint8_t _getPWM_2 () { return GPIOD_IDR.B12; }
static uint8_t _getINT_2 () { return GPIOD_IDR.B11; }
static uint8_t _getRX_2 () { return GPIOD_IDR.B6 ; }
static uint8_t _getTX_2 () { return GPIOD_IDR.B5 ; }
static uint8_t _getSCL_2 () { return GPIOB_IDR.B6 ; }
static uint8_t _getSDA_2 () { return GPIOB_IDR.B7 ; }
static void _setAN_2 (uint8_t value) { GPIOA_ODR.B5 = value; }
static void _setRST_2 (uint8_t value) { GPIOC_ODR.B3 = value; }
static void _setCS_2 (uint8_t value) { GPIOD_ODR.B14 = value; }
static void _setSCK_2 (uint8_t value) { GPIOC_ODR.B10 = value; }
static void _setMISO_2(uint8_t value) { GPIOC_ODR.B11 = value; }
static void _setMOSI_2(uint8_t value) { GPIOC_ODR.B12 = value; }
static void _setPWM_2 (uint8_t value) { GPIOD_ODR.B12 = value; }
static void _setINT_2 (uint8_t value) { GPIOD_ODR.B11 = value; }
static void _setRX_2 (uint8_t value) { GPIOD_ODR.B6 = value; }
static void _setTX_2 (uint8_t value) { GPIOD_ODR.B5 = value; }
static void _setSCL_2 (uint8_t value) { GPIOB_ODR.B6 = value; }
static void _setSDA_2 (uint8_t value) { GPIOB_ODR.B7 = value; }

static T_mikrobus_ret _gpioInit_1(T_mikrobus_pin pin, T_gpio_dir dir)
{
 switch( pin )
 {
 case _MIKROBUS_AN_PIN : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOA_BASE, _GPIO_PINMASK_4 ); else GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_4 ); break;
 case _MIKROBUS_RST_PIN : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOC_BASE, _GPIO_PINMASK_2 ); else GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_2 ); break;
 case _MIKROBUS_CS_PIN : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOD_BASE, _GPIO_PINMASK_13); else GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_13); break;
 case _MIKROBUS_SCK_PIN : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOC_BASE, _GPIO_PINMASK_10); else GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_10); break;
 case _MIKROBUS_MISO_PIN : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOC_BASE, _GPIO_PINMASK_11); else GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_11); break;
 case _MIKROBUS_MOSI_PIN : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOC_BASE, _GPIO_PINMASK_12); else GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_12); break;
 case _MIKROBUS_PWM_PIN : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOA_BASE, _GPIO_PINMASK_0 ); else GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_0 ); break;
 case _MIKROBUS_INT_PIN : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOD_BASE, _GPIO_PINMASK_10); else GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_10); break;
 case _MIKROBUS_RX_PIN : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOD_BASE, _GPIO_PINMASK_9 ); else GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_9 ); break;
 case _MIKROBUS_TX_PIN : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOD_BASE, _GPIO_PINMASK_8 ); else GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_8 ); break;
 case _MIKROBUS_SCL_PIN : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOB_BASE, _GPIO_PINMASK_6 ); else GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_6 ); break;
 case _MIKROBUS_SDA_PIN : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOB_BASE, _GPIO_PINMASK_7 ); else GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_7 ); break;
 default : return _MIKROBUS_ERR_PIN;
 }
 return _MIKROBUS_OK;
}

static T_mikrobus_ret _gpioInit_2(T_mikrobus_pin pin, T_gpio_dir dir)
{
 switch( pin )
 {
 case _MIKROBUS_AN_PIN : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOA_BASE, _GPIO_PINMASK_5 ); else GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_5 ); break;
 case _MIKROBUS_RST_PIN : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOC_BASE, _GPIO_PINMASK_3 ); else GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_3 ); break;
 case _MIKROBUS_CS_PIN : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOD_BASE, _GPIO_PINMASK_14); else GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_14); break;
 case _MIKROBUS_SCK_PIN : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOC_BASE, _GPIO_PINMASK_10); else GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_10); break;
 case _MIKROBUS_MISO_PIN : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOC_BASE, _GPIO_PINMASK_11); else GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_11); break;
 case _MIKROBUS_MOSI_PIN : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOC_BASE, _GPIO_PINMASK_12); else GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_12); break;
 case _MIKROBUS_PWM_PIN : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOD_BASE, _GPIO_PINMASK_12); else GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_12); break;
 case _MIKROBUS_INT_PIN : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOD_BASE, _GPIO_PINMASK_11); else GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_11); break;
 case _MIKROBUS_RX_PIN : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOD_BASE, _GPIO_PINMASK_6 ); else GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_6 ); break;
 case _MIKROBUS_TX_PIN : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOD_BASE, _GPIO_PINMASK_5 ); else GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_5 ); break;
 case _MIKROBUS_SCL_PIN : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOB_BASE, _GPIO_PINMASK_6 ); else GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_6 ); break;
 case _MIKROBUS_SDA_PIN : if(dir == _GPIO_INPUT) GPIO_Digital_Input(&GPIOB_BASE, _GPIO_PINMASK_7 ); else GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_7 ); break;
 default : return _MIKROBUS_ERR_PIN;
 }
 return _MIKROBUS_OK;
}
#line 1 "c:/users/crow/desktop/stm/stm/__em_f107vc_spi.c"
#line 1 "c:/users/crow/desktop/stm/stm/__t_stm32.h"
#line 13 "c:/users/crow/desktop/stm/stm/__em_f107vc_spi.c"
const uint8_t _MIKROBUS_ERR_SPI = 3;

const T_spi_obj _MIKROBUS1_SPI =
{
 SPI3_Write,
 SPI3_Read
};

const T_spi_obj _MIKROBUS2_SPI =
{
 SPI3_Write,
 SPI3_Read
};

static T_mikrobus_ret _spiInit_1(const uint32_t* cfg)
{
 SPI3_Init_Advanced( (unsigned char)cfg[0], (long)cfg[1], &_GPIO_MODULE_SPI3_PC10_11_12 );
 return _MIKROBUS_OK;
}

static T_mikrobus_ret _spiInit_2(const uint32_t* cfg)
{
 SPI3_Init_Advanced( (unsigned char)cfg[0], (long)cfg[1], &_GPIO_MODULE_SPI3_PC10_11_12 );
 return _MIKROBUS_OK;
}
#line 1 "c:/users/crow/desktop/stm/stm/__em_f107vc_log.c"
#line 1 "c:/users/crow/desktop/stm/stm/__t_stm32.h"
#line 13 "c:/users/crow/desktop/stm/stm/__em_f107vc_log.c"
const uint8_t _MIKROBUS_ERR_LOG = 6;

T_log_writeFp logger;

static T_mikrobus_ret _log_write(uint8_t *data_)
{
 logger( *data_ );
 return 0;
}

static T_mikrobus_ret _log_init1(uint32_t baud)
{
 UART3_Init_Advanced(baud, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART3_PD89);
 logger = UART3_Write;
 return 0;
}

static T_mikrobus_ret _log_init2(uint32_t baud)
{
 UART2_Init_Advanced(baud, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART2_PD56);
 logger = UART2_Write;
 return 0;
}

static T_mikrobus_ret _log_initUartA(uint32_t baud)
{
 UART1_Init_Advanced(baud, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10);
 logger = UART1_Write;
 return 0;
}

static T_mikrobus_ret _log_initUartB(uint32_t baud)
{
 UART2_Init_Advanced(baud, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART2_PD56);
 logger = UART2_Write;
 return 0;
}
#line 38 "C:/Users/Crow/Desktop/STM/STM/easymx_v7_STM32F107VC.c"
const uint8_t _MIKROBUS_OK = 0;
const uint8_t _MIKROBUS_ERR_BUS = 1;





const uint8_t _MIKROBUS1 = 0;

const T_gpio_obj _MIKROBUS1_GPIO =
{
 {
 _setAN_1, _setRST_1, _setCS_1, _setSCK_1, _setMISO_1, _setMOSI_1,
 _setPWM_1, _setINT_1, _setRX_1, _setTX_1, _setSCL_1, _setSDA_1
 },
 {
 _getAN_1, _getRST_1, _getCS_1, _getSCK_1, _getMISO_1, _getMOSI_1,
 _getPWM_1, _getINT_1, _getRX_1, _getTX_1, _getSCL_1, _getSDA_1
 }
};



const uint8_t _MIKROBUS2 = 1;

const T_gpio_obj _MIKROBUS2_GPIO =
{
 {
 _setAN_2, _setRST_2, _setCS_2, _setSCK_2, _setMISO_2, _setMOSI_2,
 _setPWM_2, _setINT_2, _setRX_2, _setTX_2, _setSCL_2, _setSDA_2
 },
 {
 _getAN_2, _getRST_2, _getCS_2, _getSCK_2, _getMISO_2, _getMOSI_2,
 _getPWM_2, _getINT_2, _getRX_2, _getTX_2, _getSCL_2, _getSDA_2
 }
};
#line 143 "C:/Users/Crow/Desktop/STM/STM/easymx_v7_STM32F107VC.c"
const uint8_t _LOG_BYTE = 0;
const uint8_t _LOG_TEXT = 1;
const uint8_t _LOG_LINE = 2;
#line 151 "C:/Users/Crow/Desktop/STM/STM/easymx_v7_STM32F107VC.c"
const uint8_t _LOG_USBUART_A = 0x20;


const uint8_t _LOG_USBUART_B = 0x30;







T_mikrobus_ret mikrobus_gpioInit(T_mikrobus_soc bus, T_mikrobus_pin pin, T_gpio_dir direction)
{
 switch( bus )
 {

 case _MIKROBUS1 : return _gpioInit_1(pin, direction);


 case _MIKROBUS2 : return _gpioInit_2(pin, direction);
#line 184 "C:/Users/Crow/Desktop/STM/STM/easymx_v7_STM32F107VC.c"
 default : return _MIKROBUS_ERR_BUS;
 }
 return _MIKROBUS_OK;
}




T_mikrobus_ret mikrobus_spiInit(T_mikrobus_soc bus, const uint32_t *cfg)
{
 switch( bus )
 {

 case _MIKROBUS1 : return _spiInit_1( cfg );


 case _MIKROBUS2 : return _spiInit_2( cfg );
#line 214 "C:/Users/Crow/Desktop/STM/STM/easymx_v7_STM32F107VC.c"
 default : return _MIKROBUS_ERR_BUS;
 }
 return _MIKROBUS_OK;
}
#line 283 "C:/Users/Crow/Desktop/STM/STM/easymx_v7_STM32F107VC.c"
T_mikrobus_ret mikrobus_logInit(T_log_bus port, const uint32_t baud)
{
 switch( port )
 {

 case _MIKROBUS1 : return _log_init1( baud );


 case _MIKROBUS2: return _log_init2( baud );
#line 309 "C:/Users/Crow/Desktop/STM/STM/easymx_v7_STM32F107VC.c"
 case _LOG_USBUART_A : return _log_initUartA( baud );


 case _LOG_USBUART_B : return _log_initUartB( baud );

 default : return _MIKROBUS_ERR_BUS;
 }
 return _MIKROBUS_OK;
}

T_mikrobus_ret mikrobus_logWrite(uint8_t* data_, T_log_format format)
{
 uint8_t *ptr = data_;
 uint8_t row = 13;
 uint8_t line = 10;
 switch( format )
 {
 case _LOG_BYTE :
 _log_write( ptr );
 break;
 case _LOG_TEXT :
 while( *ptr )
 {
 _log_write( ptr );
 ptr++;
 }
 break;
 case _LOG_LINE :
 while( *ptr )
 {
 _log_write( ptr );
 ptr++;
 }
 _log_write( &row );
 _log_write( &line );
 break;
 default :
 return _MIKROBUS_ERR_LOG;
 }
 return 0;
}
