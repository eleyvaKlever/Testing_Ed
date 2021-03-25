#line 1 "C:/Users/Crow/Desktop/STM/STM/Click_RF_Meter_STM.c"
#line 1 "c:/users/crow/desktop/stm/stm/click_rf_meter_types.h"
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
#line 1 "c:/users/crow/desktop/stm/stm/click_rf_meter_config.h"
#line 1 "c:/users/crow/desktop/stm/stm/click_rf_meter_types.h"
#line 3 "c:/users/crow/desktop/stm/stm/click_rf_meter_config.h"
const uint32_t _RFMETER_SPI_CFG[ 2 ] =
{
 _SPI_FPCLK_DIV256,
 _SPI_FIRST_CLK_EDGE_TRANSITION |
 _SPI_CLK_IDLE_LOW |
 _SPI_MASTER |
 _SPI_MSB_FIRST |
 _SPI_8_BIT |
 _SPI_SSM_ENABLE |
 _SPI_SS_DISABLE |
 _SPI_SSI_1
};
#line 28 "C:/Users/Crow/Desktop/STM/STM/Click_RF_Meter_STM.c"
float signal;
char logTxt[ 50 ];

void systemInit()
{
 mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_AN_PIN, _GPIO_INPUT );
 mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_CS_PIN, _GPIO_OUTPUT );

 mikrobus_spiInit( _MIKROBUS1, &_RFMETER_SPI_CFG[0] );

 mikrobus_logInit( _LOG_USBUART_A, 115200 );

 Delay_ms( 100 );
}

void applicationInit()
{
 rfmeter_spiDriverInit( ( const uint8_t* )&_MIKROBUS1_GPIO, ( const uint8_t* )&_MIKROBUS1_SPI );
 Delay_ms( 100 );
 mikrobus_logWrite( "---------------------------------", _LOG_LINE );
 mikrobus_logWrite( "          RF Meter Click         ", _LOG_LINE );
 mikrobus_logWrite( "---------------------------------", _LOG_LINE );
}

void applicationTask()
{
 signal = rfmeter_getSignalStrenght( _RFMETER_DEF_SLOPE, _RFMETER_DEF_INTERCEPT );

 mikrobus_logWrite( "Signal strenght: ", _LOG_TEXT );
 FloatToStr( signal, logTxt );
 mikrobus_logWrite( logTxt, _LOG_TEXT );
 mikrobus_logWrite( "dBm", _LOG_LINE );

 Delay_ms( 100 );
 mikrobus_logWrite( "-----------------------", _LOG_LINE );
}

void main()
{
 systemInit();
 applicationInit();

 while (1)
 {
 applicationTask();
 }
}
