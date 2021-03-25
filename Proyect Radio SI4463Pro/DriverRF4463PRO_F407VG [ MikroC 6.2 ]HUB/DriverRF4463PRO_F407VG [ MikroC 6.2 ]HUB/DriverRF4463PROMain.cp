#line 1 "C:/Users/Crow/Desktop/Proyect Radio SI4463Pro/DriverRF4463PRO_F407VG [ MikroC 6.2 ]HUB/DriverRF4463PRO_F407VG [ MikroC 6.2 ]HUB/DriverRF4463PROMain.c"
#line 22 "C:/Users/Crow/Desktop/Proyect Radio SI4463Pro/DriverRF4463PRO_F407VG [ MikroC 6.2 ]HUB/DriverRF4463PRO_F407VG [ MikroC 6.2 ]HUB/DriverRF4463PROMain.c"
void vRF4463MainCommandProcessor ( unsigned char *ucBuffer );


unsigned char CMD_RADIO_POWER_SET [] = { "SET_POWER" };
unsigned char CMD_RADIO_BAND_SET [] = { "SET_BAND" };
unsigned char CMD_RADIO_RATE_SET [] = { "SET_RATE" };
unsigned char CMD_RADIO_CHANNEL_SET [] = { "SET_CHANNEL" };
unsigned char CMD_RADIO_BW_SET [] = { "SET_BW" };
unsigned char CMD_RADIO_NETWORK_SET [] = { "SET_NETWORK" };
unsigned char CMD_RADIO_MODE_SET [] = { "SET_MODE" };
unsigned char CMD_RADIO_PACKET_SEND [] = { "SEND_PACKET" };
unsigned char CMD_RADIO_MATCH_BYTE_1_SET [] = { "SET_MATCH_1" };
unsigned char CMD_RADIO_MATCH_BYTE_2_SET [] = { "SET_MATCH_2" };
unsigned char CMD_RADIO_MATCH_BYTE_3_SET [] = { "SET_MATCH_3" };
unsigned char CMD_RADIO_MATCH_BYTE_4_SET [] = { "SET_MATCH_4" };
unsigned char CMD_RADIO_MATCH_MASK_1_SET [] = { "SET_MASK_1" };
unsigned char CMD_RADIO_MATCH_MASK_2_SET [] = { "SET_MASK_2" };
unsigned char CMD_RADIO_MATCH_MASK_3_SET [] = { "SET_MASK_3" };
unsigned char CMD_RADIO_MATCH_MASK_4_SET [] = { "SET_MASK_4" };
unsigned char CMD_RADIO_MATCH_UNSET [] = { "UNSET_MATCH" };


data unsigned char ARG_RADIO_MODE_STBY [] = {"STBY"};
data unsigned char ARG_RADIO_MODE_TX_CONT [] = {"TX_CONT"};
data unsigned char ARG_RADIO_MODE_RX_CONT [] = {"RX_CONT"};
data unsigned char ARG_RADIO_MODE_TX_MASTER [] = {"TX_MASTER"};
data unsigned char ARG_RADIO_MODE_RX_SLAVE [] = {"RX_SLAVE"};



data unsigned char ANS_DEBUG_COMMAND_UNKNOWN [] = {"[ COMMAND ] UNKNOWN: "};
data unsigned char ANS_COMMAND_VALUE_OUT_OF_RANGE [] = {"[ COMMAND ] VALUE OUT OF RANGE\r"};
data unsigned char ANS_COMMAND_VALUE_ACCEPTED [] = {"[ COMMAND ] VALUE ACCEPTED AND APPLIED\r"};
data unsigned char ANS_COMMAND_MODE_STBY [] = {"[ COMMAND ] MODE ACTIVE: STANDBY\r" };
data unsigned char ANS_COMMAND_MODE_TX_CONT [] = {"[ COMMAND ] MODE ACTIVE: TX CONT\r" };
data unsigned char ANS_COMMAND_MODE_RX_CONT [] = {"[ COMMAND ] MODE ACTIVE: RX CONT\r" };
data unsigned char ANS_COMMAND_MODE_TX_MASTER [] = {"[ COMMAND ] MODE ACTIVE: TX MASTER\r" };
data unsigned char ANS_COMMAND_MODE_RX_SLAVE [] = {"[ COMMAND ] MODE ACTIVE: RX SLAVE\r" };
data unsigned char ANS_COMMAND_MATCH_UNSET [] = {"[ COMMAND ] MATCH UNSET\r" };

sfr sbit _REG_RADIO at GPIOB_ODR.B9;
#line 1 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/stm32defs.h"
#line 1 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverspi.c"



volatile unsigned char ucSPI1ByteReceived = 0;
volatile unsigned char ucSPI2ByteReceived = 0;
volatile unsigned char ucSPI3ByteReceived = 0;




 void Int_SPI1() iv IVT_INT_SPI1 ics ICS_AUTO {

 if ( SPI1_SRbits.RXNE ) {
 ucSPI1ByteReceived = ( unsigned char )SPI1_DR;


 }
 }



void vSPI1Init ( void ) {
 SPI1_Init_Advanced( _SPI_FPCLK_DIV64, _SPI_MASTER | _SPI_8_BIT | _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION |
 _SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI1_PB345 );

 SPI1_CR2bits.RXNEIE = 1;

 NVIC_IntEnable( IVT_INT_SPI1 );
}
#line 1 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/configrf4463pro.h"
#line 1 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463prodefs.c"
#line 34 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463prodefs.c"
unsigned char ucRF4463FreqChannel = 1;









unsigned long ulRF4463Step = 250;
#line 56 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463prodefs.c"
const unsigned char RF_MODEM_MOD_TYPE_12[11][12] = {
 0x03, 0x00, 0x07, 0x00, 0x12, 0xC0, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x00,
 0x03, 0x00, 0x07, 0x00, 0x25, 0x80, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x00,
 0x03, 0x00, 0x07, 0x00, 0x4B, 0x00, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x00,
 0x03, 0x00, 0x07, 0x00, 0x96, 0x00, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x00,
 0x03, 0x00, 0x07, 0x01, 0x2C, 0x00, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x01,
 0x03, 0x00, 0x07, 0x01, 0x2C, 0x00, 0x08, 0x2D, 0xC6, 0xC0, 0x00, 0x01,
 0x03, 0x00, 0x07, 0x02, 0x58, 0x00, 0x08, 0x2D, 0xC6, 0xC0, 0x00, 0x01,
 0x03, 0x00, 0x07, 0x03, 0x84, 0x00, 0x08, 0x2D, 0xC6, 0xC0, 0x00, 0x01,
 0x03, 0x00, 0x07, 0x27, 0x10, 0x00, 0x01, 0xC9, 0xC3, 0x80, 0x00, 0x01,
 0x03, 0x00, 0x07, 0x4C, 0x4B, 0x40, 0x01, 0xC9, 0xC3, 0x80, 0x00, 0x1b,
 0x03, 0x00, 0x07, 0x00, 0x07, 0xD0, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x00
};

const unsigned char RF_MODEM_TX_RAMP_DELAY_8_433[11][8] = {
 0x01, 0x80, 0x08, 0x03, 0x80, 0x00, 0x70, 0x20,
 0x01, 0x80, 0x08, 0x03, 0x80, 0x00, 0x70, 0x20,
 0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x70, 0x20,
 0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x70, 0x20,
 0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x30, 0x10,
 0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x20, 0x10,
 0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x10, 0x10,
 0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x10, 0x20,
 0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x00, 0x30,
 0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x00, 0x30,
 0x01, 0x80, 0x08, 0x03, 0x80, 0x00, 0x72, 0x21
};

const unsigned char RF_MODEM_TX_RAMP_DELAY_8_850[ 11 ][ 8 ] = {
 0x01, 0x80, 0x08, 0x03, 0xC0, 0x00, 0x32, 0x20,
 0x01, 0x80, 0x08, 0x03, 0xC0, 0x00, 0x30, 0x20,
 0x01, 0x80, 0x08, 0x03, 0xC0, 0x00, 0x30, 0x20,

 0x01, 0x00, 0x08, 0x03, 0xC0, 0x00, 0x30, 0x20,

 0x01, 0x00, 0x08, 0x03, 0xC0, 0x00, 0x30, 0x20,

 0x01, 0x00, 0x08, 0x03, 0xC0, 0x00, 0x20, 0x10,

 0x01, 0x00, 0x08, 0x03, 0xC0, 0x00, 0x10, 0x10,

 0x01, 0x00, 0x08, 0x03, 0xC0, 0x00, 0x10, 0x20,
 0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x00, 0x30,
 0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x00, 0x30,
 0x01, 0x80, 0x08, 0x03, 0x80, 0x00, 0x72, 0x21
};

const unsigned char RF_MODEM_BCR_OSR_1_9_433[ 11 ][ 9 ] = {
 0x03, 0x0D, 0x00, 0xA7, 0xC6, 0x00, 0x54, 0x02, 0xC2,
 0x01, 0x87, 0x01, 0x4F, 0x8B, 0x00, 0xA8, 0x02, 0xC2,
 0x00, 0xC3, 0x02, 0x9F, 0x17, 0x02, 0x1A, 0x02, 0x00,
 0x00, 0x62, 0x05, 0x3E, 0x2D, 0x07, 0xFF, 0x02, 0x00,
 0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,
 0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,
 0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,
 0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,
 0x00, 0x75, 0x04, 0x5E, 0x7B, 0x05, 0x9a, 0x02, 0x00,
 0x00, 0x3C, 0x08, 0x88, 0x89, 0x07, 0xFF, 0x02, 0x00,
 0x03, 0xAA, 0x00, 0x8B, 0xCF, 0x00, 0x46, 0x02, 0xC2
};

const unsigned char RF_MODEM_BCR_OSR_1_9_850[ 11 ][ 9 ] = {

 0x03, 0x0D, 0x00, 0xA7, 0xC6, 0x00, 0x54, 0x02, 0xC2,

 0x03, 0x0D, 0x00, 0xA7, 0xC6, 0x00, 0x54, 0x02, 0xC2,

 0x01, 0x87, 0x01, 0x4F, 0x8B, 0x00, 0xA8, 0x02, 0xC2,

 0x00, 0xC3, 0x02, 0x9F, 0x17, 0x01, 0x93, 0x02, 0x00,

 0x00, 0x62, 0x05, 0x3E, 0x2D, 0x05, 0x04, 0x02, 0x00,

 0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,

 0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,

 0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,
 0x00, 0x75, 0x04, 0x5E, 0x7B, 0x05, 0x9a, 0x02, 0x00,
 0x00, 0x3C, 0x08, 0x88, 0x89, 0x07, 0xFF, 0x02, 0x00,
 0x03, 0xAA, 0x00, 0x8B, 0xCF, 0x00, 0x46, 0x02, 0xC2
};

const unsigned char RF_MODEM_AFC_GEAR_7_433[ 11 ][ 7 ] = {
 0x04, 0x36, 0x80, 0x03, 0x30, 0xAF, 0x80,
 0x04, 0x36, 0x80, 0x07, 0x14, 0xDD, 0x80,
 0x00, 0x12, 0x80, 0x2A, 0x04, 0x3A, 0xA0,
 0x00, 0x12, 0x80, 0x54, 0x02, 0x5A, 0xA0,
 0x00, 0x12, 0x80, 0xA8, 0x01, 0x68, 0xE0,
 0x00, 0x12, 0x81, 0x50, 0x01, 0x20, 0xE0,
 0x00, 0x12, 0x82, 0x9F, 0x01, 0x03, 0xE0,
 0x00, 0x23, 0x87, 0xDD, 0x00, 0x77, 0xE0,
 0x00, 0x23, 0x8F, 0xFF, 0x00, 0xc9, 0xE0,
 0x00, 0x23, 0x8F, 0xFF, 0x01, 0x23, 0xE0,
 0x04, 0x36, 0x80, 0x01, 0x50, 0x69, 0x80
};

const unsigned char RF_MODEM_AFC_GEAR_7_850[ 11 ][ 7 ] = {

 0x04, 0x36, 0x80, 0x01, 0x52, 0x30, 0x80,

 0x04, 0x36, 0x80, 0x03, 0x30, 0x7F, 0x80,

 0x04, 0x36, 0x80, 0x07, 0x17, 0x10, 0x80,

 0x00, 0x12, 0x80, 0x2A, 0x04, 0xB1, 0xA0,

 0x00, 0x12, 0x80, 0x54, 0x02, 0x9A, 0xA0,

 0x00, 0x12, 0x80, 0xA8, 0x01, 0x8F, 0xA0,

 0x00, 0x12, 0x81, 0x50, 0x01, 0x1F, 0xA0,

 0x00, 0x23, 0x83, 0xEF, 0x00, 0x84, 0xA0,
 0x00, 0x23, 0x8F, 0xFF, 0x00, 0xc9, 0xE0,
 0x00, 0x23, 0x8F, 0xFF, 0x01, 0x23, 0xE0,
 0x04, 0x36, 0x80, 0x01, 0x50, 0x69, 0x80
};

const unsigned char RF_MODEM_AGC_WINDOW_SIZE_9_433[ 11 ][ 9 ] = {
 0x11, 0xAB, 0xAB, 0x00, 0x1A, 0x14, 0x00, 0x00, 0x2B,
 0x11, 0x56, 0x56, 0x00, 0x1A, 0xA0, 0x00, 0x00, 0x2A,
 0x11, 0x2B, 0x2B, 0x00, 0x1A, 0x50, 0x00, 0x00, 0x29,
 0x11, 0x15, 0x15, 0x00, 0x1A, 0x28, 0x00, 0x00, 0x28,
 0x11, 0x0E, 0x0E, 0x00, 0x1A, 0x21, 0x55, 0x00, 0x28,
 0x11, 0x0E, 0x0E, 0x00, 0x1A, 0x10, 0xAB, 0x00, 0x28,
 0x11, 0x0E, 0x0E, 0x00, 0x1A, 0x08, 0x55, 0x00, 0x28,
 0x11, 0x0E, 0x0E, 0x00, 0x1A, 0x05, 0x8E, 0x00, 0x28,
 0x22, 0x0D, 0x0D, 0x00, 0x1A, 0x32, 0x00, 0x00, 0x28,
 0x22, 0x07, 0x07, 0x00, 0x1A, 0x19, 0x9a, 0x00, 0x27,
 0x11, 0xCD, 0xCD, 0x00, 0x1A, 0x30, 0x00, 0x00, 0x2B
};

const unsigned char RF_MODEM_AGC_WINDOW_SIZE_9_850[ 11 ][ 9 ] = {

 0x11, 0xAB, 0xAB, 0x00, 0x02, 0xFF, 0xFF, 0x00, 0x2B,

 0x11, 0xAB, 0xAB, 0x00, 0x02, 0xFF, 0xFF, 0x00, 0x2B,

 0x11, 0x56, 0x56, 0x00, 0x02, 0xD5, 0x55, 0x00, 0x2A,

 0x11, 0x2B, 0x2B, 0x00, 0x02, 0x6A, 0xAB, 0x00, 0x29,

 0x11, 0x15, 0x15, 0x00, 0x02, 0x42, 0xAB, 0x00, 0x28,

 0x11, 0x0E, 0x0E, 0x00, 0x02, 0x21, 0x55, 0x00, 0x28,

 0x11, 0x0E, 0x0E, 0x00, 0x02, 0x10, 0xAB, 0x00, 0x28,

 0x11, 0x0E, 0x0E, 0x00, 0x02, 0x10, 0xAB, 0x00, 0x28,
 0x22, 0x0D, 0x0D, 0x00, 0x1A, 0x32, 0x00, 0x00, 0x28,
 0x22, 0x07, 0x07, 0x00, 0x1A, 0x19, 0x9a, 0x00, 0x27,
 0x11, 0xCD, 0xCD, 0x00, 0x1A, 0x30, 0x00, 0x00, 0x2B
};

const unsigned char RF_MODEM_OOK_CNT1_11_433[ 11 ][ 11 ] = {
 0xA4, 0x02, 0xD6, 0x83, 0x00, 0xAD, 0x01, 0x80, 0xFF, 0x0C, 0x00,
 0xA4, 0x02, 0xD6, 0x83, 0x00, 0xAD, 0x01, 0x80, 0xFF, 0x0C, 0x00,
 0xA4, 0x03, 0xD6, 0x03, 0x00, 0xCC, 0x01, 0x80, 0xFF, 0x0C, 0x00,
 0xA4, 0x03, 0xD6, 0x03, 0x00, 0xCC, 0x01, 0x80, 0xFF, 0x0C, 0x00,
 0xA4, 0x03, 0xD6, 0x03, 0x01, 0x00, 0x01, 0x80, 0xFF, 0x0C, 0x00,
 0xA4, 0x03, 0xD6, 0x03, 0x00, 0x80, 0x01, 0x80, 0xFF, 0x0C, 0x00,
 0xA4, 0x03, 0xD6, 0x03, 0x00, 0x40, 0x01, 0x80, 0xFF, 0x0C, 0x00,
 0xA4, 0x03, 0xD6, 0x03, 0x00, 0x2B, 0x01, 0x80, 0xFF, 0x0C, 0x00,
 0xA4, 0x03, 0xD6, 0x03, 0x00, 0xd5, 0x01, 0x80, 0xFF, 0x0C, 0x00,
 0xA4, 0x03, 0xD6, 0x03, 0x00, 0xd5, 0x01, 0x80, 0xFF, 0x0C, 0x00,
 0xA4, 0x02, 0xD6, 0x81, 0x02, 0xB4, 0x01, 0x80, 0xFF, 0x0C, 0x00
};

const unsigned char RF_MODEM_OOK_CNT1_11_850[ 11 ][ 11 ] = {

 0xA4, 0x02, 0xD6, 0x81, 0x03, 0x9B, 0x01, 0x80, 0xFF, 0x0C, 0x02,

 0xA4, 0x02, 0xD6, 0x83, 0x00, 0xE7, 0x01, 0x80, 0xFF, 0x0C, 0x02,

 0xA4, 0x02, 0xD6, 0x83, 0x00, 0xE7, 0x01, 0x80, 0xFF, 0x0C, 0x02,

 0xA4, 0x03, 0xD6, 0x03, 0x01, 0x11, 0x01, 0x80, 0xFF, 0x0C, 0x02,

 0xA4, 0x03, 0xD6, 0x03, 0x01, 0x55, 0x01, 0x80, 0xFF, 0x0C, 0x02,

 0xA4, 0x03, 0xD6, 0x03, 0x01, 0x00, 0x01, 0x80, 0xFF, 0x0C, 0x02,

 0xA4, 0x03, 0xD6, 0x03, 0x00, 0x80, 0x01, 0x80, 0xFF, 0x0C, 0x02,

 0xA4, 0x03, 0xD6, 0x03, 0x00, 0x80, 0x01, 0x80, 0xFF, 0x0C, 0x02,
 0xA4, 0x03, 0xD6, 0x03, 0x00, 0xd5, 0x01, 0x80, 0xFF, 0x0C, 0x02,
 0xA4, 0x03, 0xD6, 0x03, 0x00, 0xd5, 0x01, 0x80, 0xFF, 0x0C, 0x02,
 0xA4, 0x02, 0xD6, 0x81, 0x02, 0xB4, 0x01, 0x80, 0xFF, 0x0C, 0x02
};

const unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433[ 11 ][ 12 ]= {
 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,
 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,
 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1, 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11,
 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,
 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1, 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11,
 0x7E, 0x64, 0x1B, 0xBA, 0x58, 0x0B, 0xDD, 0xCE, 0xD6, 0xE6, 0xF6, 0x00,
 0x5B, 0x47, 0x0F, 0xC0, 0x6D, 0x25, 0xF4, 0xDB, 0xD6, 0xDF, 0xEC, 0xF7,
 0x5B, 0x47, 0x0F, 0xC0, 0x6D, 0x25, 0xF4, 0xDB, 0xD6, 0xDF, 0xEC, 0xF7,
 0x39, 0x2B, 0x00, 0xC3, 0x7F, 0x3F, 0x0C, 0xEC, 0xDC, 0xDC, 0xE3, 0xED,
 0xA2, 0x81, 0x26, 0xAF, 0x3F, 0xEE, 0xC8, 0xC7, 0xDB, 0xF2, 0x02, 0x08,
 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1, 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11
};

const unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850[ 11 ][ 12 ] = {

 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,

 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,

 0xFF, 0xBA, 0x0F, 0x51, 0xCF, 0xA9, 0xC9, 0xFC, 0x1B, 0x1E, 0x0F, 0x01,

 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,

 0xFF, 0xBA, 0x0F, 0x51, 0xCF, 0xA9, 0xC9, 0xFC, 0x1B, 0x1E, 0x0F, 0x01,

 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,

 0x7E, 0x64, 0x1B, 0xBA, 0x58, 0x0B, 0xDD, 0xCE, 0xD6, 0xE6, 0xF6, 0x00,

 0x7E, 0x64, 0x1B, 0xBA, 0x58, 0x0B, 0xDD, 0xCE, 0xD6, 0xE6, 0xF6, 0x00,
 0x39, 0x2B, 0x00, 0xC3, 0x7F, 0x3F, 0x0C, 0xEC, 0xDC, 0xDC, 0xE3, 0xED,
 0xA2, 0x81, 0x26, 0xAF, 0x3F, 0xEE, 0xC8, 0xC7, 0xDB, 0xF2, 0x02, 0x08,
 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1, 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11
};

const unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433[ 11 ][ 12 ] = {
 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,
 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,
 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00, 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1,
 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,
 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00, 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1,
 0x03, 0x03, 0x15, 0xF0, 0x3F, 0x00, 0x7E, 0x64, 0x1B, 0xBA, 0x58, 0x0B,
 0xFE, 0x01, 0x15, 0xF0, 0xFF, 0x03, 0x5B, 0x47, 0x0F, 0xC0, 0x6D, 0x25,
 0xFE, 0x01, 0x15, 0xF0, 0xFF, 0x03, 0x5B, 0x47, 0x0F, 0xC0, 0x6D, 0x25,
 0xF6, 0xFD, 0x15, 0xC0, 0xFF, 0x0F, 0x39, 0x2B, 0x00, 0xC3, 0x7F, 0x3F,
 0x07, 0x03, 0x15, 0xFC, 0x0F, 0x00, 0xA2, 0x81, 0x26, 0xAF, 0x3F, 0xEE,
 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00, 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1
};

const unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850[ 11 ][ 12 ] = {

 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,

 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,

 0xFC, 0xFD, 0x15, 0xFF, 0x00, 0x0F, 0xFF, 0xBA, 0x0F, 0x51, 0xCF, 0xA9,

 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,

 0xFC, 0xFD, 0x15, 0xFF, 0x00, 0x0F, 0xFF, 0xBA, 0x0F, 0x51, 0xCF, 0xA9,

 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,

 0x03, 0x03, 0x15, 0xF0, 0x3F, 0x00, 0x7E, 0x64, 0x1B, 0xBA, 0x58, 0x0B,

 0xF6, 0xFD, 0x15, 0xC0, 0xFF, 0x0F, 0x39, 0x2B, 0x00, 0xC3, 0x7F, 0x3F,
 0x07, 0x03, 0x15, 0xFC, 0x0F, 0x00, 0xA2, 0x81, 0x26, 0xAF, 0x3F, 0xEE,
 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00, 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1
};

const unsigned char RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433[ 11 ][ 12 ] = {
 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,
 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,
 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11, 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00,
 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,
 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11, 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00,
 0xDD, 0xCE, 0xD6, 0xE6, 0xF6, 0x00, 0x03, 0x03, 0x15, 0xF0, 0x3F, 0x00,
 0xF4, 0xDB, 0xD6, 0xDF, 0xEC, 0xF7, 0xFE, 0x01, 0x15, 0xF0, 0xFF, 0x03,
 0xF4, 0xDB, 0xD6, 0xDF, 0xEC, 0xF7, 0xFE, 0x01, 0x15, 0xF0, 0xFF, 0x03,
 0x0C, 0xEC, 0xDC, 0xDC, 0xE3, 0xED, 0xF6, 0xFD, 0x15, 0xC0, 0xFF, 0x0F,
 0xC8, 0xC7, 0xDB, 0xF2, 0x02, 0x08, 0x07, 0x03, 0x15, 0xFC, 0x0F, 0x00,
 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11, 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00
};

const unsigned char RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850[ 11 ][ 12 ] = {

 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,

 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,

 0xC9, 0xFC, 0x1B, 0x1E, 0x0F, 0x01, 0xFC, 0xFD, 0x15, 0xFF, 0x00, 0x0F,

 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,

 0xC9, 0xFC, 0x1B, 0x1E, 0x0F, 0x01, 0xFC, 0xFD, 0x15, 0xFF, 0x00, 0x0F,

 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,

 0xDD, 0xCE, 0xD6, 0xE6, 0xF6, 0x00, 0x03, 0x03, 0x15, 0xF0, 0x3F, 0x00,

 0x03, 0x03, 0x15, 0xF0, 0x3F, 0x00, 0x7E, 0x64, 0x1B, 0xBA, 0x58, 0x0B,
 0x0C, 0xEC, 0xDC, 0xDC, 0xE3, 0xED, 0xF6, 0xFD, 0x15, 0xC0, 0xFF, 0x0F,
 0xC8, 0xC7, 0xDB, 0xF2, 0x02, 0x08, 0x07, 0x03, 0x15, 0xFC, 0x0F, 0x00,
 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11, 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00
};

const unsigned char RF_SYNTH_PFDCP_CPFF_7[ 11 ][ 7 ] = {
 0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,
 0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,
 0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,
 0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,
 0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,
 0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,
 0x34, 0x04, 0x0B, 0x04, 0x07, 0x70, 0x03,
 0x34, 0x04, 0x0B, 0x04, 0x07, 0x70, 0x03,
 0x01, 0x05, 0x0B, 0x05, 0x02, 0x00, 0x03,
 0x01, 0x05, 0x0B, 0x05, 0x02, 0x00, 0x03,
 0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03
};



const unsigned char RF_POWER_UP_data[] = {  0x02, 0x01, 0x00, 0x01, 0xC9, 0xC3, 0x80  };
const unsigned char RF_FRR_CTL_A_MODE_4_data[] = {  0x11, 0x02, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00  };
const unsigned char RF_MODEM_AGC_CONTROL_1_data[] = {  0x11, 0x20, 0x01, 0x35, 0xE2  };

unsigned char RF_MODEM_MOD_TYPE_12_data[ 16 ] = { 0x11, 0x20, 0x0C, 0x00 };
unsigned char RF_MODEM_TX_RAMP_DELAY_8_data[ 12 ] = { 0x11, 0x20, 0x08, 0x18 };
unsigned char RF_MODEM_BCR_OSR_1_9_data[ 13 ] = { 0x11, 0x20, 0x09, 0x22 };
unsigned char RF_MODEM_AFC_GEAR_7_data[ 13 ] = { 0x11, 0x20, 0x07, 0x2C };
unsigned char RF_MODEM_AGC_WINDOW_SIZE_9_data[ 13 ] = { 0x11, 0x20, 0x09, 0x38 };
unsigned char RF_MODEM_OOK_CNT1_11_data[ 15 ] = { 0x11, 0x20, 0x0B, 0x42 };
unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[ 16 ] = { 0x11, 0x21, 0x0C, 0x00 };
unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[ 16 ] = { 0x11, 0x21, 0x0C, 0x0C };
unsigned char RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[ 16 ] = { 0x11, 0x21, 0x0C, 0x18 };
unsigned char RF_SYNTH_PFDCP_CPFF_7_data[ 11 ] = { 0x11, 0x23, 0x07, 0x00 };

const unsigned char tx_test_aa_data[ 14 ] = { 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA };


unsigned char ucRF4463Checksum = 0;

unsigned char ucRF4463MatchEnabled = 1;


unsigned char ucRF4463ByteMatch1 = 0X01;
unsigned char ucRF4463ByteMatch2 = 0x01;
unsigned char ucRF4463ByteMatch3 = 0x01;
unsigned char ucRF4463ByteMatch4 = 0x01;


unsigned char ucRF4463ByteMask1 = 0xFF;
unsigned char ucRF4463ByteMask2 = 0xFF;
unsigned char ucRF4463ByteMask3 = 0xFF;
unsigned char ucRF4463ByteMask4 = 0xFF;




const unsigned char ucRF4463TXdata[  66  ] = { 0x01, 0x01, 0x01, 0x01,'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','A','B','C','D','E','F','G','H',0x11,0xF3 };

typedef struct
{
 unsigned char reach_1s : 1;
 unsigned char is_tx : 1;
 unsigned char rf_reach_timeout : 1;


 unsigned char flash : 1;
 unsigned char key_valid : 1;

}FlagType;

FlagType Flag;

unsigned int count_1hz, rf_timeout;
unsigned char spi_read_buf[ 20 ];
unsigned char rx_buf[  66  ];







unsigned char key_value;
unsigned char have_set;
unsigned char set;
unsigned char old_mode;
unsigned char ucRF4463Mode;
unsigned char ucRF4463Freq3;
unsigned char ucRF4463Freq2;
unsigned char ucRF4463Freq1;
unsigned char ucRF4463Power;
unsigned char ucRF4463Rate;

unsigned char cnt_10s;

unsigned long tx_cnt = 0,rx_cnt = 0;
unsigned char reset_mode;

unsigned char reach_15hz = 0,reach_flash = 0,reach_1s = 0;
unsigned char count_15hz,count_flash = 0,count_1s = 0,nirq_cnt = 0;

void spi_read(unsigned char data_length, unsigned char api_command );
void tx_data(void);
void SI4463_init(void);
void sysclk_cfg(void);
void port_init(void);
void timerx_init(void);
void delay_1ms(unsigned int delay_time);
unsigned char spi_byte(unsigned char ucData);
unsigned char check_cts(void);
void spi_write(unsigned char tx_length, unsigned char *p);
void spi_fast_read( unsigned char api_command);
void spi_write_fifo(void);
void spi_read_fifo(void);
void VRF4463SDNReset(void);
void clr_interrupt(void);
void fifo_reset(void);
void enable_tx_interrupt(void);
void enable_rx_interrupt(void);
void tx_start(void);
void rx_start(void);
void rx_init(void);
void tx_const_aa(void);
void rx_start_test(void);


void vRF4463GPIO_SET(unsigned char ucData);
void rf_standby(void);
void rf_init_freq(void);
void option_load(void);
void flash_copy(void);

void time_opt();
unsigned char scan_key(void);
void key_opt(unsigned char key);
void nop_10();

void full_lcd(void);
void clr_lcd(void);
void poweron_dis(void);
void dis_freq(void);
void dis_power(void);
void dis_rssi(void);
void dis_dr(void);
void dis_fd(void);
void dis_bw(void);
void dis_tx(void);
void dis_rx(void);
void dis_sign(void);
void dis_mode(void);

void wr_data(unsigned char addr,unsigned char loop);
void wr_cmd(unsigned int cmd);
void DATA_1(void);
void DATA_0(void);

void delay_10ms(void);
void delay_x10ms(unsigned int dx10ms);
#line 1 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro.c"







unsigned char ucRF4463MatchEnableReg = 0x40;


static unsigned char ucRF4463IRQ = 0;


unsigned char ucRFTxEventPending = 0;

unsigned char pcRF4463TxBuffer[  64  ] = { 0x00 };
unsigned char pcRF4463RxBuffer[  64  ] = { 0x00 };



void vRF4463Init ( void );
void vRF4463GPIO_SET( unsigned char ucData );


void vRF4463ClearInterrupts ( void );



void vRF4463ISR() iv IVT_INT_EXTI0 ics ICS_AUTO{
 if( EXTI_PR.B0 ){
 EXTI_PR.B0 |= 1;
  GPIOE_ODRbits.ODR9  = 1;
 ucRF4463IRQ = 1;
 vRF4463ClearInterrupts();
 }
}





void vRF4463Init ( void ) {
 unsigned char app_command_buf[ 20 ], i;

 for ( i = 4; i < 16; i++ ) {
 RF_MODEM_MOD_TYPE_12_data[ i ] = RF_MODEM_MOD_TYPE_12[ ucRF4463Rate ][ i - 4 ];
 }


 if ( ucRF4463Freq3 < 8 ) {
 for ( i = 4; i < 12; i++ ) {
 RF_MODEM_TX_RAMP_DELAY_8_data[ i ] = RF_MODEM_TX_RAMP_DELAY_8_433[ ucRF4463Rate ][ i - 4 ];
 }
 for ( i = 4; i < 11; i++ ) {
 RF_MODEM_AFC_GEAR_7_data[ i ] = RF_MODEM_AFC_GEAR_7_433[ ucRF4463Rate ][ i - 4 ];
 }
 for ( i = 4; i < 15; i++ ) {
 RF_MODEM_OOK_CNT1_11_data[ i ] = RF_MODEM_OOK_CNT1_11_433[ ucRF4463Rate ][ i - 4 ];
 }
 for ( i = 4; i < 16; i++ ) {
 RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433[ ucRF4463Rate ][ i - 4 ];
 }
 for ( i = 4; i < 16; i++ ) {
 RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433[ ucRF4463Rate ][ i - 4 ];
 }
 for ( i = 4; i < 16; i++ ) {
 RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433[ ucRF4463Rate ][ i - 4 ];
 }
 for ( i = 4; i < 13; i++ ) {
 RF_MODEM_AGC_WINDOW_SIZE_9_data[ i ] = RF_MODEM_AGC_WINDOW_SIZE_9_433[ ucRF4463Rate ][ i - 4 ];
 }
 for ( i = 4; i < 13; i++ ) {
 RF_MODEM_BCR_OSR_1_9_data[ i ] = RF_MODEM_BCR_OSR_1_9_433[ ucRF4463Rate ][ i - 4 ];
 }
 }
 else {
 for ( i = 4; i < 12; i++ ) {
 RF_MODEM_TX_RAMP_DELAY_8_data[ i ] = RF_MODEM_TX_RAMP_DELAY_8_850[ ucRF4463Rate ][ i - 4 ];
 }
 for ( i = 4; i < 11; i++ ) {
 RF_MODEM_AFC_GEAR_7_data[ i ] = RF_MODEM_AFC_GEAR_7_850[ ucRF4463Rate ][ i - 4 ];
 }
 for ( i = 4; i < 15; i++ ) {
 RF_MODEM_OOK_CNT1_11_data[ i ] = RF_MODEM_OOK_CNT1_11_850[ ucRF4463Rate ][ i - 4 ];
 }
 for ( i = 4; i < 16; i++ ) {
 RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850[ ucRF4463Rate ][ i - 4 ];
 }
 for ( i = 4; i < 16; i++ ) {
 RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850[ ucRF4463Rate ][ i - 4 ];
 }
 for ( i = 4; i < 16; i++ ) {
 RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850[ ucRF4463Rate ][ i - 4 ];
 }
 for ( i = 4; i < 13; i++ ) {
 RF_MODEM_AGC_WINDOW_SIZE_9_data[ i ] = RF_MODEM_AGC_WINDOW_SIZE_9_850[ ucRF4463Rate ][ i - 4 ];
 }
 for ( i = 4; i < 13; i++ ) {
 RF_MODEM_BCR_OSR_1_9_data[ i ] = RF_MODEM_BCR_OSR_1_9_850[ ucRF4463Rate ][ i - 4 ];
 }
 }
 for ( i = 4; i < 11; i++ ) {
 RF_SYNTH_PFDCP_CPFF_7_data[ i ] = RF_SYNTH_PFDCP_CPFF_7[ ucRF4463Rate ][ i - 4 ];
 }



 vRF4463GPIO_SET( ucRF4463Mode );


 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x00;
 app_command_buf[ 2 ] = 0x01;
 app_command_buf[ 3 ] = 0x00;
 app_command_buf[ 4 ] = 98;
 spi_write( 5, app_command_buf );


 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x00;
 app_command_buf[ 2 ] = 0x01;
 app_command_buf[ 3 ] = 0x03;
 app_command_buf[ 4 ] = 0x40;
 spi_write( 5, app_command_buf );



 spi_write( 0x08, RF_FRR_CTL_A_MODE_4_data );


 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x10;
 app_command_buf[ 2 ] = 0x09;
 app_command_buf[ 3 ] = 0x00;

 if ( ucRF4463Mode ==  2  ) {
 app_command_buf[ 4 ] = 0xff;
 }
 else {
 app_command_buf[ 4 ] = 0x08;
 }


 app_command_buf[ 5 ] = 0x14;
 app_command_buf[ 6 ] = 0x00;
 app_command_buf[ 7 ] = 0x0f;
 app_command_buf[ 8 ] = 0x31;
 app_command_buf[ 9 ] = 0x0;
 app_command_buf[ 10 ] = 0x00;
 app_command_buf[ 11 ] = 0x00;
 app_command_buf[ 12 ] = 0x00;
 spi_write(13, app_command_buf);


 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x11;
 app_command_buf[ 2 ] = 0x05;
 app_command_buf[ 3 ] = 0x00;
 app_command_buf[ 4 ] = 0x01;

 if ( ucRF4463Mode ==  2  ) {
 app_command_buf[ 5 ] = 0x55;
 app_command_buf[ 6 ] = 0x55;
 }
 else {
 app_command_buf[ 5 ] = 0x2d;
 app_command_buf[ 6 ] = 0xd4;
 }

 app_command_buf[ 7 ] = 0x00;
 app_command_buf[ 8 ] = 0x00;
 spi_write( 9, app_command_buf );


 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x12;
 app_command_buf[ 2 ] = 0x01;
 app_command_buf[ 3 ] = 0x00;
 app_command_buf[ 4 ] = 0x85;
 spi_write( 5, app_command_buf );


 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x12;
 app_command_buf[ 2 ] = 0x01;
 app_command_buf[ 3 ] = 0x06;
 app_command_buf[ 4 ] = 0x02;
 spi_write( 5, app_command_buf );


 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x12;
 app_command_buf[ 2 ] = 0x03;
 app_command_buf[ 3 ] = 0x08;
 app_command_buf[ 4 ] = 0x00;
 app_command_buf[ 5 ] = 0x00;
 app_command_buf[ 6 ] = 0x00;
 spi_write( 7, app_command_buf );


 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x12;
 app_command_buf[ 2 ] = 0x0c;
 app_command_buf[ 3 ] = 0x0d;
 app_command_buf[ 4 ] = 0x00;
 app_command_buf[ 5 ] =  66 ;
 app_command_buf[ 6 ] = 0x04;
 app_command_buf[ 7 ] = 0xaa;
 app_command_buf[ 8 ] = 0x00;
 app_command_buf[ 9 ] = 0x00;
 app_command_buf[ 10 ] = 0x00;
 app_command_buf[ 11 ] = 0x00;
 app_command_buf[ 12 ] = 0x00;
 app_command_buf[ 13 ] = 0x00;
 app_command_buf[ 14 ] = 0x00;
 app_command_buf[ 15 ] = 0x00;
 spi_write( 16, app_command_buf );


 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x12;
 app_command_buf[ 2 ] = 0x08;
 app_command_buf[ 3 ] = 0x19;
 app_command_buf[ 4 ] = 0x00;
 app_command_buf[ 5 ] = 0x00;
 app_command_buf[ 6 ] = 0x00;
 app_command_buf[ 7 ] = 0x00;
 app_command_buf[ 8 ] = 0x00;
 app_command_buf[ 9 ] = 0x00;
 app_command_buf[ 10 ] = 0x00;
 app_command_buf[ 11 ] = 0x00;
 spi_write( 12, app_command_buf );


 spi_write( 0x10, RF_MODEM_MOD_TYPE_12_data );


 app_command_buf[0] = 0x11;
 app_command_buf[1] = 0x20;
 app_command_buf[2] = 0x01;
 app_command_buf[3] = 0x0c;

 if ( ucRF4463Freq3 < 8 ) {
 if ( ucRF4463Rate >=  8  ) {
 app_command_buf[ 4 ] = 0x4f;
 }
 else if ( ucRF4463Rate >=  4  ) {
 app_command_buf[ 4 ] = 0x5e;
 }
 else {
 app_command_buf[ 4 ] = 0xd2;
 }
 }
 else {
 if ( ucRF4463Rate >=  7  ) {
 app_command_buf[ 4 ] = 0x69;
 }
 else if ( ucRF4463Rate >=  4  ) {
 app_command_buf[ 4 ] = 0x5e;
 }
 else {
 app_command_buf[ 4 ] = 0x18;
 }
 }
 spi_write( 5, app_command_buf );


 spi_write( 0x0C, RF_MODEM_TX_RAMP_DELAY_8_data );
 spi_write( 0x0D, RF_MODEM_BCR_OSR_1_9_data );
 spi_write( 0x0B, RF_MODEM_AFC_GEAR_7_data );
 spi_write( 0x05, RF_MODEM_AGC_CONTROL_1_data );
 spi_write( 0x0D, RF_MODEM_AGC_WINDOW_SIZE_9_data );
 spi_write( 0x0F, RF_MODEM_OOK_CNT1_11_data );


 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x20;
 app_command_buf[ 2 ] = 0x01;
 app_command_buf[ 3 ] = 0x4e;

 if ( ucRF4463Rate ==  10  ) {
 app_command_buf[ 4 ] = 0x3a;
 }
 else {
 app_command_buf[ 4 ] = 0x40;
 }
 spi_write( 5, app_command_buf );


 spi_write( 0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data );
 spi_write( 0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data );
 spi_write( 0x10, RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data );


 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x22;
 app_command_buf[ 2 ] = 0x04;
 app_command_buf[ 3 ] = 0x00;
 app_command_buf[ 4 ] = 0x08;

 if ( ucRF4463Power > 0 || ucRF4463Power < 127 ) {
 app_command_buf[ 5 ] = ucRF4463Power;
 }
 else {
 app_command_buf[ 5 ] = 127;
 }

 app_command_buf[ 6 ] = 0x00;

 if ( ( ucRF4463Rate <=  7  )||( ucRF4463Rate ==  10  ) ) {
 app_command_buf[ 7 ] = 0x3d;
 }
 else {
 app_command_buf[ 7 ] = 0x5d;
 }
 spi_write( 8, app_command_buf );



 spi_write( 0x0B , RF_SYNTH_PFDCP_CPFF_7_data );


 if ( ucRF4463MatchEnabled ) {
 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x30;
 app_command_buf[ 2 ] = 0x0c;
 app_command_buf[ 3 ] = 0x00;
 app_command_buf[ 4 ] = ucRF4463ByteMatch1;
 app_command_buf[ 5 ] = ucRF4463ByteMask1;
 app_command_buf[ 6 ] = ucRF4463MatchEnableReg;
 app_command_buf[ 7 ] = ucRF4463ByteMatch2;
 app_command_buf[ 8 ] = ucRF4463ByteMask2;
 app_command_buf[ 9 ] = 0x01;
 app_command_buf[ 10 ] = ucRF4463ByteMatch3;
 app_command_buf[ 11 ] = ucRF4463ByteMask3;
 app_command_buf[ 12 ] = 0x02;;
 app_command_buf[ 13 ] = ucRF4463ByteMatch4;
 app_command_buf[ 14 ] = ucRF4463ByteMask4;
 app_command_buf[ 15 ] = 0x03;
 spi_write( 16, app_command_buf );

 if ( ucRF4463MatchEnableReg == 0x00 ) {
 ucRF4463MatchEnabled = 0;
 }
#line 363 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro.c"
 }


 rf_init_freq();
}





void vRF4463GPIO_SET( unsigned char ucData ) {
 unsigned char ucAppCommandBuf[ 7 ];

 ucAppCommandBuf[0] = 0x13;

 switch ( ucData ) {
 case  0 :
 case  1 : ucAppCommandBuf[ 1 ] = 3;
 ucAppCommandBuf[ 2 ] = 2;
 break;

 case  2 : ucAppCommandBuf[ 1 ] = 3;
 ucAppCommandBuf[ 2 ] = 3;
 break;

 case  3 : ucAppCommandBuf[ 1 ] = 2;
 ucAppCommandBuf[ 2 ] = 20;
 break;

 case  4 : ucAppCommandBuf[ 1 ] = 2;
 ucAppCommandBuf[ 2 ] = 2;
 break;
 }

 ucAppCommandBuf[ 3 ] = 0x21;
 ucAppCommandBuf[ 4 ] = 0x20;
 ucAppCommandBuf[ 5 ] = 0x27;
 ucAppCommandBuf[ 6 ] = 0x0b;
 spi_write( 7, ucAppCommandBuf );
}




void vRF4463FifoReset( void ) {
 unsigned char p[2];

 p[ 0 ] =  0x15 ;
 p[ 1 ] = 0x03;
 spi_write( 2, p );
}





void vRF4463ClearInterrupts( void ) {
 unsigned char p[ 4 ];

 p[ 0 ] =  0x20 ;
 p[ 1 ] = 0;
 p[ 2 ] = 0;
 p[ 3 ] = 0;
 spi_write( 4, p );
 spi_read( 9,  0x20  );
}

 void vRF4463PartInfo( void ) {
 unsigned char p[ 9 ];

 p[ 0 ] =  0x01 ;



 spi_write( 1, p );
 spi_read( 9,  0x01  );
 }




void vRF4463EnableRxInterrupt( void ) {
 unsigned char p[ 7 ];

 p[ 0 ] = 0x11;
 p[ 1 ] = 0x01;
 p[ 2 ] = 0x03;
 p[ 3 ] = 0x00;
 p[ 4 ] = 0x03;
 p[ 5 ] = 0x18;
 p[ 6 ] = 0x00;
 spi_write( 0x07, p );
}




void vRF4463EnableTxInterrupt( void ) {
 unsigned char p[ 6 ];

 p[ 0 ] = 0x11;
 p[ 1 ] = 0x01;
 p[ 2 ] = 0x02;
 p[ 3 ] = 0x00;
 p[ 4 ] = 0x01;
 p[ 5 ] = 0x20;
 spi_write( 0x06, p );
}




void vRF4463RfStandby( void ) {
 unsigned char p[ 2 ];

 p[ 0 ] =  0x34  ;
 p[ 1 ] = 0x01 ;
 spi_write( 2, p );
}




void vRF4463TxStart( void ) {
 unsigned char p[ 5 ];

 p[ 0 ] =  0x31  ;
 p[ 1 ] = ucRF4463FreqChannel;
 p[ 2 ] = 0x30;
 p[ 3 ] = 0;
 p[ 4 ] = 0;
 spi_write( 5, p );
}




void vRF4463RxStart( void ) {
 unsigned char p[ 8 ];

 p[ 0 ] =  0x32  ;
 p[ 1 ] = ucRF4463FreqChannel;
 p[ 2 ] = 0x00;
 p[ 3 ] = 0;
 p[ 4 ] = 0;
 p[ 5 ] = 0;


 p[ 6 ] = 0x08;
 p[ 7 ] = 0x08;
 spi_write( 8, p );
}




void vRF4463RxStartTest( void ) {
 unsigned char p[ 8 ];

  GPIOE_ODRbits.ODR9  = 1;

 p[ 0 ] =  0x32 ;
 p[ 1 ] = ucRF4463FreqChannel;
 p[ 2 ] = 0x00;
 p[ 3 ] = 0;

 p[ 4 ] = 0;
 p[ 5 ] = 0;


 p[ 6 ] = 0x08;
 p[ 7 ] = 0x08;
 spi_write( 8, p );
}




void vRF4463RxInit( void ) {
 Flag.is_tx = 0;
 vRF4463FifoReset();
 vRF4463EnableRxInterrupt();
 vRF4463ClearInterrupts();

 if ( ucRF4463Mode ==  3  ) {
 vRF4463RxStartTest();
 }
 else {
 vRF4463RxStart();
 }
}




void vRF4463TxData( void ) {
 unsigned char i;

 ucRF4463IRQ = 0;

 Flag.is_tx = 1;


  GPIOE_ODRbits.ODR11  =~  GPIOE_ODRbits.ODR11 ;
 vRF4463FifoReset();
 spi_write_fifo();
 vRF4463EnableTxInterrupt();
 vRF4463ClearInterrupts();
 vRF4463TxStart();
 rf_timeout = 0;

 Flag.rf_reach_timeout = 0;

 if ( ucRF4463IRQ ) {
 UART1_Write_Text( "[ UART1 ] TX INT\r\n" );
 }


 while (  GPIOD_IDRbits.IDR0  ) {


 if ( Flag.rf_reach_timeout ) {
 VRF4463SDNReset();
 vRF4463Init();
 break;
 }
 }

 tx_cnt++;

 vRF4463RxInit();
}




void vRF4463TxCont( void ) {
 unsigned char i;

  GPIOE_ODRbits.ODR11  = 1;
 vRF4463FifoReset();
 spi_write_fifo();
 vRF4463EnableTxInterrupt();
 vRF4463ClearInterrupts();
 vRF4463TxStart();
 rf_timeout = 0;
 Flag.rf_reach_timeout = 0;

 ucRF4463IRQ = 0;


 while(  GPIOD_IDRbits.IDR0  ) {







 }
}




void rf_init_freq ( void ) {
 unsigned char ucOUTDIV, ucDIV, ucVCO, ucINTE, ucBAND;
 unsigned char ucFD_2, ucFD_1, ucFD_0, ucFRAC_2, ucFRAC_1, ucFRAC_0;
 unsigned long ulFRAC, ulData, ulFrequency;
 unsigned char app_command_buf[ 20 ];

 ulFrequency = ( ucRF4463Freq3 * 100 ) + ( ucRF4463Freq2 * 10 ) + ucRF4463Freq1;

 ulFrequency = ( ulFrequency * 10000 );


 if ( ulFrequency >= 7600000 ) {
 ucOUTDIV = 4;
 ucBAND = 0;
 ucVCO = 0xFF;
 }


 else if ( ulFrequency >= 5460000 ) {
 ucOUTDIV = 6;
 ucBAND = 1;
 ucVCO = 0xFE;
 }


 else if ( ulFrequency >= 3850000 ) {
 ucOUTDIV = 8;
 ucBAND = 2;
 ucVCO = 0xFE;
 }


 else if ( ulFrequency >= 2730000 ) {
 ucOUTDIV = 12;
 ucBAND = 3;
 ucVCO = 0xFD;
 }


 else if ( ulFrequency >= 1940000 ) {
 ucOUTDIV = 16;
 ucBAND = 4;
 ucVCO = 0xFC;
 }


 else {
 ucOUTDIV = 24;
 ucBAND = 5;
 ucVCO = 0xFA;
 }

 ucDIV = ucOUTDIV / 2;

 ulData = ( ulFrequency * ucDIV ) / 3;
 ucINTE = ( ulData / 100000) - 1;
 ulFRAC = ( ulData - ( ucINTE + 1 ) * 100000 ) * 16384 / 3125;
 ulFRAC = ulFRAC + 0x80000;

 ucFRAC_0 = ulFRAC;
 ulFRAC >>= 8;
 ucFRAC_1 = ulFRAC;
 ulFRAC >>= 8;
 ucFRAC_2 = ulFRAC;



 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x20;
 app_command_buf[ 2 ] = 0x01;
 app_command_buf[ 3 ] = 0x51;
 app_command_buf[ 4 ] = 0x08 | ucBAND;
 spi_write( 5, app_command_buf );

 app_command_buf[ 0 ] = 0x11;
 app_command_buf[ 1 ] = 0x40;
 app_command_buf[ 2 ] = 0x08;
 app_command_buf[ 3 ] = 0x00;
 app_command_buf[ 4 ] = ucINTE;
 app_command_buf[ 5 ] = ucFRAC_2;
 app_command_buf[ 6 ] = ucFRAC_1;
 app_command_buf[ 7 ] = ucFRAC_0;


 if ( ulRF4463Step == 250 ) {
 app_command_buf[ 8 ] =  0x22 ;
 app_command_buf[ 9 ] =  0x22 ;
 }
 else if ( ulRF4463Step == 500 ) {
 app_command_buf[ 8 ] =  0x44 ;
 app_command_buf[ 9 ] =  0x44 ;
 }

 app_command_buf[ 10 ] = 0x20;
 app_command_buf[ 11 ] = ucVCO;
 spi_write( 12, app_command_buf );
}
#line 744 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro.c"
unsigned char ucRf4463SPIByte( unsigned char ucData ) {

ucSPI1ByteReceived = 0;

SPI1_DR = ucData;

while ( !SPI1_SRbits.TXE );

while ( SPI1_SRbits.BSY );

return ( ucSPI1ByteReceived );

}




void spi_write( unsigned char tx_length, unsigned char *p ) {
 unsigned char i,j;

 i = 0;
 while ( i != 0xFF ) {
 i = check_cts();
 }

  GPIOD_ODRbits.ODR2  = 0;

 for ( i = 0; i < tx_length; i++ ) {
 j = *( p + i );
 ucRf4463SPIByte( j );
 }

  GPIOD_ODRbits.ODR2  = 1;
}




unsigned char check_cts( void ) {
 unsigned char i;

  GPIOD_ODRbits.ODR2  = 1;
  GPIOD_ODRbits.ODR2  = 0;
 ucRf4463SPIByte( 0x44 );
 i = ucRf4463SPIByte( 0 );
  GPIOD_ODRbits.ODR2  = 1;
 return ( i );
}




void spi_read( unsigned char data_length, unsigned char api_command ) {
 unsigned char i;
 unsigned char p[ 1 ];

 p[ 0 ] = api_command;
 i = 0;
 while ( i != 0xFF ) {
 i = check_cts();
 }

 spi_write( 1, p );

 i = 0;
 while ( i != 0xFF ) {
 i = check_cts();
 }

  GPIOD_ODRbits.ODR2  = 1;
  GPIOD_ODRbits.ODR2  = 0;
 ucRf4463SPIByte( 0x44 );
 for ( i = 0; i < data_length; i++ ) {
 spi_read_buf[ i ] = ucRf4463SPIByte( 0x00 );
 }
  GPIOD_ODRbits.ODR2  = 1;
}




void spi_fast_read( unsigned char api_command ) {
 unsigned char i,p[1];

 p[0] = api_command;
 i = 0;
 while ( i != 0xFF ) {
 i = check_cts();
 }

  GPIOD_ODRbits.ODR2  = 1;
  GPIOD_ODRbits.ODR2  = 0;
 ucRf4463SPIByte( api_command );
 for ( i = 0; i < 4; i++ ) {
 spi_read_buf[ i ] = ucRf4463SPIByte( 0xFF );
 }
  GPIOD_ODRbits.ODR2  = 1;
}




void spi_write_fifo( void ) {
 unsigned char i;

 i = 0;
 while ( i != 0xFF ) {
 i = check_cts();
 }

  GPIOD_ODRbits.ODR2  = 1;
  GPIOD_ODRbits.ODR2  = 0;
 ucRf4463SPIByte(  0x66  );

 if ( ucRF4463Mode ==  2 ) {
 for ( i = 0; i <  66 ; i++ ) {
 ucRf4463SPIByte( tx_test_aa_data[ i ] );
 }
 }
 else {
 for ( i = 0; i <  66 ; i++ ) {
 ucRf4463SPIByte( ucRF4463TXdata[ i ] );
 }
 }
  GPIOD_ODRbits.ODR2  = 1;
}




void spi_read_fifo( void ) {
 unsigned char i;

 i = 0;
 while ( i != 0xFF ) {
 i = check_cts();
 }

  GPIOD_ODRbits.ODR2  = 1;
  GPIOD_ODRbits.ODR2  = 0;
 ucRf4463SPIByte(  0x77  );
 for ( i = 0; i <  66 ; i++ ) {
 rx_buf[ i ] = ucRf4463SPIByte( 0xFF );
 }
  GPIOD_ODRbits.ODR2  = 1;
}




void VRF4463SDNReset( void ) {
 unsigned char i;

  GPIOD_ODRbits.ODR1  = 1;
 Delay_ms( 6 );
  GPIOD_ODRbits.ODR1  = 0;
 Delay_ms( 10 );

  GPIOD_ODRbits.ODR2  = 1;
  GPIOD_ODRbits.ODR2  = 0;
 for ( i = 0; i < 7; i++ ) {
 ucRf4463SPIByte( RF_POWER_UP_data[ i ] );
 }
  GPIOD_ODRbits.ODR2  = 1;


}
#line 1 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/utils.c"
#line 1 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/utils.h"
#line 49 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/utils.h"
unsigned char ucASCIIToByte( unsigned char * pcASCIIBuffer );
#line 61 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/utils.h"
void vASCIIToHex( unsigned char *pcHexConvertBuffer, unsigned char *pcASCIIConvertBuffer, unsigned char ucConversionLength );
#line 73 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/utils.h"
void vHexToASCII( unsigned char *pcASCIIConvertBuffer, unsigned char *pcHexConvertBuffer, unsigned char ucConversionLength );
#line 85 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/utils.h"
void vBufferSetToZero( unsigned char * pcBufferToClean, unsigned int uslength );
#line 97 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/utils.h"
void vBufferSetTo255( unsigned char * pcBufferToClean, unsigned int uslength );
#line 109 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/utils.h"
void vBufferSetToValue( unsigned char * pcBufferToClean, unsigned char ucValue, unsigned int uslength );
#line 121 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/utils.h"
void vSerializeUUID( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer );
#line 133 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/utils.h"
void vSerializeMACAddress( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer );
#line 145 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/utils.h"
void vSerializeIPAddress( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer );
#line 25 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/utils.c"
const unsigned char pcHexChar[16] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};

unsigned char ucMSBNibble = 0;
unsigned char ucLSBNibble = 0;
#line 41 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/utils.c"
unsigned char ucASCIIToByte( unsigned char * pcASCIIBuffer ){
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
#line 61 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/utils.c"
void vASCIIToHex( unsigned char *pcHexConvertBuffer, unsigned char *pcASCIIConvertBuffer, unsigned char ucConversionLength ){
 unsigned char ucASCIICounter = 0;

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
#line 85 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/utils.c"
void vHexToASCII( unsigned char *pcASCIIConvertBuffer, unsigned char *pcHexConvertBuffer, unsigned char ucConversionLength ){
 unsigned char ucHexConvCounter = 0;

 for( ucHexConvCounter = 0; ucHexConvCounter < ucConversionLength; ucHexConvCounter++ ){
 pcASCIIConvertBuffer[ ucHexConvCounter * 2 ] = pcHexChar[ pcHexConvertBuffer[ ucHexConvCounter ] >> 4 ];
 pcASCIIConvertBuffer[ ( ucHexConvCounter * 2 ) + 1 ] = pcHexChar[ ( pcHexConvertBuffer[ ucHexConvCounter ] & 0x0F ) ];
 }
}
#line 97 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/utils.c"
void vBufferSetToZero( unsigned char * pcBufferToClean, unsigned int uslength ){
 unsigned int usPosition = 0;

 for( usPosition = 0; usPosition < uslength; usPosition++ ){
 pcBufferToClean[ usPosition ] = 0x00;
 }
}
#line 108 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/utils.c"
void vBufferSetTo255( unsigned char * pcBufferToClean, unsigned int uslength ){
 unsigned int usPosition = 0;

 for( usPosition = 0; usPosition < uslength; usPosition++ ){
 pcBufferToClean[ usPosition ] = 0xFF;
 }
}
#line 119 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/utils.c"
void vBufferSetToValue( unsigned char * pcBufferToClean, unsigned char ucValue, unsigned int uslength ){
 unsigned int usPosition = 0;

 for( usPosition = 0; usPosition < uslength; usPosition++ ){
 pcBufferToClean[ usPosition ] = ucValue;
 }
}
#line 130 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/utils.c"
void vSerializeUUID( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer ){
 unsigned char ucCounter = 0;

 for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
 pcTextConvertBuffer[ ucCounter * 2 ] = pcHexChar[ pcHexConvertBuffer[ ucCounter ] >> 4 ];
 pcTextConvertBuffer[ ( ucCounter * 2 ) + 1 ] = pcHexChar[ pcHexConvertBuffer[ ucCounter ] & 0x0F ];
 }
}
#line 142 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/utils.c"
void vSerializeMACAddress( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer ){
 unsigned int usCounter = 0;
 unsigned char pcDeviceMAC[ 12 ];

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
#line 161 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/utils.c"
void vSerializeIPAddress( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer ){
 unsigned char ucCounter = 0;
 unsigned char pcConvertText[ 7 ];

 memset( pcTextConvertBuffer, '\0', sizeof( pcTextConvertBuffer ) );

 for( ucCounter = 0; ucCounter < 4; ucCounter++ ){

 ByteToStr( pcHexConvertBuffer[ ucCounter ], pcConvertText );

 strcat( pcTextConvertBuffer, Ltrim( pcConvertText ) );

 if( ucCounter != 3 ){
 strcat( pcTextConvertBuffer, "." );
 }
 }
}
#line 1 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/uarthandler.c"
#line 1 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/uarthandler.h"
#line 1 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/debug.h"
#line 80 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/debug.h"
 void vDebugInit();
 void vDebugPrint();
#line 25 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/uarthandler.h"
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
 UART_CMD_SEND_RF_MESSAGE,
 UART_Commands
} UARTCommandsTable;
#line 54 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/uarthandler.h"
void vUARTTxInit();

void vUARTRxInit();

void vUARTRxMessage();

void vUARTCommands( unsigned char * pcInBuffer );
#line 44 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/uarthandler.c"
volatile unsigned char ucUSART1RXBuffer[  4096  ] = { 0x00 };
volatile unsigned long ulUSART1ByteReceived = 0UL;
volatile unsigned long fUSART1Buffer =  0 ;


unsigned char ucUSARTActiveBuffer1 [  4096  ] = { 0x00 };
unsigned long ulUSARTActiveBuffer1BytesReceived = 0;

volatile unsigned long ulClk;

unsigned char ucUSARTNull = 0x00;

volatile unsigned char ucData1 = 0;
#line 61 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/uarthandler.c"
unsigned char ucUSART1TxBuffer[  2048  ];
unsigned char ucUSART1RxBuffer[  2048  ];




unsigned int usBufferCounter = 0;
unsigned int usPosition = 0;
unsigned int usUARTMessageLength = 0;

unsigned char ucTempByteUART = 0;
#line 89 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/uarthandler.c"
void DMA2Strm7_interrupt() iv IVT_INT_DMA2_Stream7 ics ICS_AUTO {

 if ( DMA2_HISRbits.FEIF7 ) {
 DMA2_HIFCRbits.CFEIF7 = 1;
 }
 else if ( DMA2_HISRbits.DMEIF7 ) {
 DMA2_HIFCRbits.CDMEIF7 = 1;
 }
 else if ( DMA2_HISRbits.TEIF7 ) {
 DMA2_HIFCRbits.CTEIF7 = 1;

 }
 else if ( DMA2_HISRbits.HTIF7 ) {
 DMA2_HIFCRbits.CHTIF7 = 1;
 }
 else if ( DMA2_HISRbits.TCIF7 ) {
 DMA2_HIFCRbits.CTCIF7 = 1;
 DMA2_S7CRbits.EN = 0;

 }
}
#line 115 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/uarthandler.c"
void vUARTISR() iv IVT_INT_USART1 ics ICS_AUTO{
  GPIOE_ODRbits.ODR13  =~  GPIOE_ODRbits.ODR13 ;

 if( USART1_SRbits.RXNE ){
 ucData1 = USART1_DR;
 if ( ucData1 !=  0x0D  && ucData1 !=  0x0A  && ulUSART1ByteReceived <  4096  ) {

 if ( ( ucData1 ==  'S'  ||
 ucData1 ==  's'  ||
 ucData1 ==  'U'  ||
 ucData1 ==  'u'  ) &&
 ulUSART1ByteReceived == 0 ) {
 ucUSART1RXBuffer[ ulUSART1ByteReceived++ ] = ucData1;
 }

 else if ( ucUSART1RXBuffer[ 0 ] ==  'S'  ||
 ucUSART1RXBuffer[ 0 ] ==  's'  ||
 ucUSART1RXBuffer[ 0 ] ==  'U'  ||
 ucUSART1RXBuffer[ 0 ] ==  'u'  ) {
 ucUSART1RXBuffer[ ulUSART1ByteReceived++ ] = ucData1;
 }
 }

 else if ( ucData1 ==  0x0D  ) {
 ucUSART1RXBuffer[ ulUSART1ByteReceived++ ] = ucData1;
 }

 else if ( ucData1 ==  0x0A  && ucUSART1RXBuffer[ ulUSART1ByteReceived - 1 ] ==  0x0D  ) {
 ucUSART1RXBuffer[ ulUSART1ByteReceived++ ] = ucData1;
 fUSART1Buffer =  1 ;
 }
 }
}
#line 158 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/uarthandler.c"
unsigned char vUSARTStartMEMtoMEMZero ( unsigned long *pcBufferDestination, unsigned long ulSizeInBytes ) {

 while ( DMA2_S4CRbits.EN );

if ( ulSizeInBytes > 0 ) {
 DMA2_S4CRbits.EN = 0;
 while ( DMA2_S4CRbits.EN );


 DMA2_S4PAR = ( unsigned long ) &ucUSARTNull;
 DMA2_S4M0AR = ( unsigned long ) pcBufferDestination;

 DMA2_S4NDTR = ulSizeInBytes;
 DMA2_S4CRbits.EN = 1;
 while ( DMA2_S4CRbits.EN );
 return 1;
}
return 0;
}



void vUSARTDMAMeToMemZero ( void ) {

 RCC_AHB1ENRbits.DMA2EN = 1;

 DMA2_S4CRbits.EN = 0;
 while ( DMA2_S4CRbits.EN );

 DMA2_S4CRbits.CHSEL = 4;
 DMA2_S4CRbits.PL = 3;
 DMA2_S4CRbits.MINC = 1;
 DMA2_S4CRbits.PINC = 0;
 DIR0_DMA2_S4CR_bit = 0;
 DIR1_DMA2_S4CR_bit = 1;

 DMA2_S4FCRbits.DMDIS = 1;

 DMA2_S4CRbits.TEIE = 1;
 DMA2_S4CRbits.TCIE = 1;

 NVIC_IntEnable( IVT_INT_DMA2_Stream4 );

}




unsigned char vUSARTStartMEMtoMEM ( unsigned long *pcBufferOrigin, unsigned long *pcBufferDestination, unsigned long ulSizeInBytes ) {

 while ( DMA2_S1CRbits.EN );

 if ( ulSizeInBytes > 0 ) {
 DMA2_S1CRbits.EN = 0;
 while ( DMA2_S1CRbits.EN );


 DMA2_S1PAR = ( unsigned long ) pcBufferOrigin;
 DMA2_S1M0AR = ( unsigned long ) pcBufferDestination;

 DMA2_S1NDTR = ulSizeInBytes;
 DMA2_S1CRbits.EN = 1;
 while ( DMA2_S1CRbits.EN );
 return 1;
 }
 return 0;

}



void vUSARTDMAMemToMem ( void ) {
 RCC_AHB1ENRbits.DMA2EN = 1;

 DMA2_S1CRbits.EN = 0;
 while ( DMA2_S1CRbits.EN );

 DMA2_S1CRbits.CHSEL = 3;
 DMA2_S1CRbits.PL = 3;
 DMA2_S1CRbits.MINC = 1;
 DMA2_S1CRbits.PINC = 1;
 DIR0_DMA2_S1CR_bit = 0;
 DIR1_DMA2_S1CR_bit = 1;

 DMA2_S1FCRbits.DMDIS = 1;

 DMA2_S1CRbits.TEIE = 1;
 DMA2_S1CRbits.TCIE = 1;

 NVIC_IntEnable( IVT_INT_DMA2_Stream1 );

}





unsigned char vUSART1Start_TX ( unsigned long *ucBuffer, unsigned long ulSize ) {
 while ( DMA2_S7CRbits.EN || !USART1_SRbits.TC );

 if ( USART1_CR1bits.UE && USART1_SRbits.TC && ulSize > 0 ) {
 DMA2_S7CRbits.EN = 0;
 while ( DMA2_S7CRbits.EN );

 DMA2_S7M0AR = ( unsigned long ) ucBuffer;
 DMA2_S7NDTR = ulSize;
 DMA2_S7CRbits.EN = 1;
 while ( DMA2_S7CRbits.EN || !USART1_SRbits.TC );
 return 1;
 }
 return 0;

}



void vInitDMAUSART1_TX () {
 RCC_AHB1ENRbits.DMA2EN = 1;

 DMA2_S7CRbits.EN = 0;
 while ( DMA2_S7CRbits.EN );


 DMA2_S7PAR = ( unsigned long ) &USART1_DR;

 DMA2_S7CRbits.CHSEL = 4;
 DMA2_S7CRbits.PL = 3;
 DMA2_S7CRbits.MINC = 1;
 DIR0_DMA2_S7CR_bit = 1;
 DMA2_S7CRbits.TEIE = 1;
 DMA2_S7CRbits.TCIE = 1;

 NVIC_IntEnable( IVT_INT_DMA2_Stream7 );

}




void vUSARTConfigUSART1 ( unsigned long ulBaudRate ) {

UART1_Init_Advanced( ulBaudRate, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PB67 );
USART1_CR1bits.UE = 0;

ulClk = Clock_MHz() * 1000000;
#line 306 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/uarthandler.c"
USART1_CR1bits.UE = 1;

}





void vUSARTCleanBuffer ( unsigned char *ucBuffer, unsigned int uiCnt ) {

 vUSARTStartMEMtoMEMZero( ucBuffer, uiCnt );
}



void vUSARTReceivedFromUSART1 ( ) {

 vUSARTCleanBuffer( ucUSARTActiveBuffer1, ulUSARTActiveBuffer1BytesReceived );

 vUSARTStartMEMtoMEM( ucUSART1RXBuffer, ucUSARTActiveBuffer1, ulUSART1ByteReceived );
 vUSARTCleanBuffer( ucUSART1RXBuffer, ulUSART1ByteReceived );
 ulUSARTActiveBuffer1BytesReceived = ulUSART1ByteReceived;
 ulUSART1ByteReceived = 0;
 fUSART1Buffer =  0 ;
 vRF4463MainCommandProcessor( ucUSARTActiveBuffer1 );
}
#line 337 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/uarthandler.c"
void vUARTRxMessage(){
 unsigned int usCounter = 0;






  ;




 usUARTMessageLength = 0;
}
#line 1 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/debug.c"
#line 1 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/debug.h"
#line 83 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/debug.c"
 void vDebugInit();
#line 93 "c:/users/crow/desktop/proyect radio si4463pro/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/driverrf4463pro_f407vg [ mikroc 6.2 ]hub/debug.c"
 void vDebugPrint();
#line 92 "C:/Users/Crow/Desktop/Proyect Radio SI4463Pro/DriverRF4463PRO_F407VG [ MikroC 6.2 ]HUB/DriverRF4463PRO_F407VG [ MikroC 6.2 ]HUB/DriverRF4463PROMain.c"
void Timer2_interrupt() iv IVT_INT_TIM2 {
 TIM2_SR.UIF = 0;
 Flag.rf_reach_timeout = 1;
 Flag.reach_1s = 1;
}



void vRF4463MainApplyChanges () {
 VRF4463SDNReset();
 vRF4463Init();
 vRF4463ClearInterrupts();
}


void vRF4463MainSetTXString () {




}



void vRF4463MainCommandProcessor ( unsigned char *ucBuffer ) {
 unsigned char ucCommand [ 32 ] = { 0x00 };
 unsigned long ulArgument = 0;
 unsigned char ucLongArgument[ 64 ] = { 0x00 };
 unsigned char ucCounterBuffer = 0;
 unsigned char ucCounterCommand = 0;
 unsigned char ucCounterLongArgument = 0;


 if ( ucBuffer[ 0 ] > '@' && ucBuffer[ 0 ] <= 'z' ) {

 while ( ucBuffer[ ucCounterBuffer ] != '|' && ucCounterCommand < 32 ) {
 ucCommand[ ucCounterCommand++ ] = toupper( ucBuffer[ ucCounterBuffer++ ] );
 }

 ucCounterBuffer++;

 while ( ucBuffer[ ucCounterBuffer ] !=  0x0D  && ucCounterLongArgument < 64 ) {
 ucLongArgument[ ucCounterLongArgument ] = ucBuffer[ ucCounterBuffer ] ;
 ucCounterBuffer++;
 ucCounterLongArgument++;
 }
 }



 if ( memcmp( CMD_RADIO_POWER_SET, ucCommand, sizeof( CMD_RADIO_POWER_SET ) ) == 0x00 ) {
 ulArgument = StrToShort( ucLongArgument );

 if ( ulArgument > 0 && ulArgument <= 127 ) {
 ucRF4463Power = ulArgument;
 vRF4463MainApplyChanges();
 vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
 }
 else {
 vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
 }
 }



 else if ( memcmp( CMD_RADIO_BAND_SET, ucCommand, sizeof( CMD_RADIO_BAND_SET ) ) == 0x00 ) {
 ulArgument = StrToInt( ucLongArgument );

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



 else if ( memcmp( CMD_RADIO_RATE_SET, ucCommand, sizeof( CMD_RADIO_RATE_SET ) ) == 0x00 ) {
 ulArgument = StrToLong( ucLongArgument );

 switch ( ulArgument ) {
 case 500 : ucRF4463Rate =  10 ;
 vRF4463MainApplyChanges();
 vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
 break;
 case 1200 : ucRF4463Rate =  0 ;
 vRF4463MainApplyChanges();
 vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
 break;
 case 2400 : ucRF4463Rate =  1 ;
 vRF4463MainApplyChanges();
 vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
 break;
 case 4800 : ucRF4463Rate =  2 ;
 vRF4463MainApplyChanges();
 vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
 break;
 case 9600 : ucRF4463Rate =  3 ;
 vRF4463MainApplyChanges();
 vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
 break;
 case 19200 : ucRF4463Rate =  4 ;
 vRF4463MainApplyChanges();
 vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
 break;
 case 38400 : ucRF4463Rate =  5 ;
 vRF4463MainApplyChanges();
 vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
 break;
 case 76800 : ucRF4463Rate =  6 ;
 vRF4463MainApplyChanges();
 vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
 break;
 case 115200 : ucRF4463Rate =  7 ;
 vRF4463MainApplyChanges();
 vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
 break;
 case 256000 : ucRF4463Rate =  8 ;
 vRF4463MainApplyChanges();
 vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
 break;
 case 500000 : ucRF4463Rate =  9 ;
 vRF4463MainApplyChanges();
 vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
 break;
 default : vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
 }
 }



 else if ( memcmp( CMD_RADIO_CHANNEL_SET, ucCommand, sizeof( CMD_RADIO_CHANNEL_SET ) ) == 0x00 ) {
 ulArgument = StrToInt( ucLongArgument );

 if ( ulArgument >= 0 && ulArgument <= 50 ) {
 ucRF4463FreqChannel = ulArgument;
 vRF4463MainApplyChanges();
 vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
 }
 else {
 vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
 }
 }



 else if ( memcmp( CMD_RADIO_BW_SET, ucCommand, sizeof( CMD_RADIO_BW_SET ) ) == 0x00 ) {
 ulArgument = StrToInt( ucLongArgument );

 if ( ulArgument == 250 || ulArgument == 500 ) {
 ulRF4463Step = ulArgument;
 vRF4463MainApplyChanges();
 vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
 }
 else {
 vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
 }
 }






 else if ( memcmp( CMD_RADIO_MODE_SET, ucCommand, sizeof( CMD_RADIO_MODE_SET ) ) == 0x00 ) {

 ucCounterCommand = 0;

 while ( ucLongArgument[ ucCounterCommand ] != ucUSARTNull && ucCounterCommand < 32 ) {
 ucLongArgument[ ucCounterCommand ] = toupper( ucLongArgument[ ucCounterCommand ] );
 ucCounterCommand++;
 }


 if ( memcmp( ARG_RADIO_MODE_STBY, ucLongArgument, sizeof( ARG_RADIO_MODE_STBY ) ) == 0x00 ) {
 ucRF4463Mode =  4 ;
 vUSART1Start_TX( ANS_COMMAND_MODE_STBY, strlen( ANS_COMMAND_MODE_STBY ) );
 }
 else if ( memcmp( ARG_RADIO_MODE_TX_CONT, ucLongArgument, sizeof( ARG_RADIO_MODE_TX_CONT ) ) == 0x00 ) {
 ucRF4463Mode =  2 ;
 vRF4463MainApplyChanges();
 vUSART1Start_TX( ANS_COMMAND_MODE_TX_CONT, strlen( ANS_COMMAND_MODE_TX_CONT ) );
 }
 else if ( memcmp( ARG_RADIO_MODE_RX_CONT, ucLongArgument, sizeof( ARG_RADIO_MODE_RX_CONT ) ) == 0x00 ) {
 ucRF4463Mode =  3 ;
 vUSART1Start_TX( ANS_COMMAND_MODE_RX_CONT, strlen( ANS_COMMAND_MODE_RX_CONT ) );
 }
 else if ( memcmp( ARG_RADIO_MODE_TX_MASTER, ucLongArgument, sizeof( ARG_RADIO_MODE_TX_MASTER ) ) == 0x00 ) {
 ucRF4463Mode =  0 ;
 vUSART1Start_TX( ANS_COMMAND_MODE_TX_MASTER, strlen( ANS_COMMAND_MODE_TX_MASTER ) );
 }
 else if ( memcmp( ARG_RADIO_MODE_RX_SLAVE, ucLongArgument, sizeof( ARG_RADIO_MODE_RX_SLAVE ) ) == 0x00 ) {
 ucRF4463Mode =  1 ;
 vUSART1Start_TX( ANS_COMMAND_MODE_RX_SLAVE, strlen( ANS_COMMAND_MODE_RX_SLAVE ) );
 }
 else {
 vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
 }
 }




 else if ( memcmp( CMD_RADIO_PACKET_SEND, ucCommand, sizeof( CMD_RADIO_PACKET_SEND ) ) == 0x00 ) {



 ulArgument = StrToLong( ucLongArgument );

 vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );

 }




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



 else if ( memcmp( CMD_RADIO_MATCH_UNSET, ucCommand, sizeof( CMD_RADIO_MATCH_UNSET ) ) == 0x00 ) {

 ucRF4463MatchEnableReg = 1;
 vRF4463MainApplyChanges();
 vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );




 }


 else {
 vUSART1Start_TX( ANS_DEBUG_COMMAND_UNKNOWN, strlen( ANS_DEBUG_COMMAND_UNKNOWN ) );
 vUSART1Start_TX( ucBuffer, strlen( ucBuffer ) );
 }
}





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

 unsigned char i, j, chksum;

 Delay_ms( 2000 );



 GPIO_Digital_Output( &GPIOE_BASE, _GPIO_PINMASK_9 );
 GPIO_Digital_Output( &GPIOE_BASE, _GPIO_PINMASK_11 );
 GPIO_Digital_Output( &GPIOE_BASE, _GPIO_PINMASK_13 );
#line 490 "C:/Users/Crow/Desktop/Proyect Radio SI4463Pro/DriverRF4463PRO_F407VG [ MikroC 6.2 ]HUB/DriverRF4463PRO_F407VG [ MikroC 6.2 ]HUB/DriverRF4463PROMain.c"
 GPIO_Digital_Input( &GPIOD_BASE, _GPIO_PINMASK_0 );
 GPIO_Digital_Output( &GPIOD_BASE, _GPIO_PINMASK_1 );
 GPIO_Digital_Output( &GPIOD_BASE, _GPIO_PINMASK_2 );
#line 506 "C:/Users/Crow/Desktop/Proyect Radio SI4463Pro/DriverRF4463PRO_F407VG [ MikroC 6.2 ]HUB/DriverRF4463PRO_F407VG [ MikroC 6.2 ]HUB/DriverRF4463PROMain.c"
 RCC_APB2ENRbits.SYSCFGEN = 1;
 SYSCFG_EXTICR1 |= 0x0003;
 EXTI_IMR.B0 |= 1;
 EXTI_FTSR.B0 |= 1;

  GPIOD_ODRbits.ODR2  = 1;

  GPIOE_ODRbits.ODR11  = 0;
  GPIOE_ODRbits.ODR9  = 0;
  GPIOE_ODRbits.ODR13  = 0;

 Delay_ms( 100 );

  GPIOE_ODRbits.ODR11  = 1;
  GPIOE_ODRbits.ODR9  = 0;
  GPIOE_ODRbits.ODR13  = 0;
 Delay_ms(300);
 InitTimer2();



 vUSARTConfigUSART1( 115200 );

 UART1_Write_Text("[ SYS STM32F407VC ] Start System\r\n");
  GPIOE_ODRbits.ODR11  = 0;
  GPIOE_ODRbits.ODR9  = 0;
  GPIOE_ODRbits.ODR13  = 1;
 vSPI1Init();




 ucRF4463Freq3 = 9;
 ucRF4463Freq2 = 1;
 ucRF4463Freq1 = 5;


 ucRF4463Power = 127;

 ucRF4463Rate =  0 ;

 ucRF4463Mode =  0 ;

 ucRF4463FreqChannel = 1;



 reset_mode = 0;




 vRF4463MainSetTXString();
 VRF4463SDNReset();
 vRF4463Init();
 vRF4463ClearInterrupts();
 vRF4463PartInfo ();

  GPIOE_ODRbits.ODR9  = 0;
  GPIOE_ODRbits.ODR13  = 0;



 UART1_Write_Text( "[ SYS STM32F407VC ] RF Radio ready\r\n" );


 while ( 1 ) {


 if ( fUSART1Buffer ==  1  ) {
 vUSARTReceivedFromUSART1();
 }










 if ( ucRF4463Mode ==  0  ) {
 vRF4463TxData();
 }


 else if ( ucRF4463Mode ==  1  ) {
 vRF4463RxInit();
 }


 else if ( ucRF4463Mode ==  4  ) {
 vRF4463RxInit();
 }


 if ( ucRF4463Mode ==  2  ) {
 vRF4463TxCont();
 while ( 1 ) {

 if ( fUSART1Buffer ==  1  ) {
 break;
 }

 if ( ! GPIOD_IDRbits.IDR0  ) {
 vRF4463TxCont();
 }
 }
 }

 if ( ucRF4463Mode ==  3  ) {
 vRF4463RxInit ();
 while ( 1 ) {

 if ( fUSART1Buffer ==  1  ) {
 break;
 }


 }
 }

 if ( reset_mode == 0 ) {

 while ( 1 ) {

 if ( fUSART1Buffer ==  1  ) {
 break;
 }

 if ( Flag.reach_1s ) {
 Flag.reach_1s = 0;
 if ( ucRF4463Mode ==  0  ) {
 vRF4463TxData();
 }
 }


 if ( !Flag.is_tx ) {
 if ( ! GPIOD_IDRbits.IDR0  ) {
 vRF4463ClearInterrupts();

 if ( ( spi_read_buf[ 4 ] & 0x08) == 0 ) {



 spi_read_fifo();
 vRF4463FifoReset();

 chksum = 0;
 for ( i = 4; i <  66  - 1; i++ )
 chksum += rx_buf[ i ];

 if ( ( chksum == rx_buf[  66  - 1 ] )&&( rx_buf[ 4 ] == 0x41 )) {




 UART1_Write_Text( rx_buf );
 UART1_Write_Text("\r\n");


 rx_cnt++;





 }
 else
 vRF4463RxInit();
 }
 else {

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
