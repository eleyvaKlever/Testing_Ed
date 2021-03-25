#line 1 "C:/Users/Crow/Desktop/Lab-02/main.c"
#line 1 "c:/users/crow/desktop/lab-02/radio_config_si4463.h"
#line 25 "C:/Users/Crow/Desktop/Lab-02/main.c"
sbit SPI_SCK at RC3_bit;
sbit SPI_SDO at RC5_bit;
sbit SPI_SDI at RC4_bit;
sbit SPI_nSEL at RE0_bit;
sbit SPI_CE at RE1_bit;
sbit SPI_IRQ at RB0_bit;





typedef unsigned char U8;
typedef unsigned int U16;
typedef unsigned long U32;
typedef char S8;
typedef int S16;
typedef long S32;
#line 75 "C:/Users/Crow/Desktop/Lab-02/main.c"
typedef struct
{
 unsigned char reach_1s : 1;
 unsigned char is_tx : 1;
 unsigned char rf_reach_timeout : 1;
}FlagType;

const unsigned char * RF_FREQ_CONTROL_INTE_8_data[] = { 0x11, 0x40, 0x08, 0x00, 0x38, 0x0E, 0x66, 0x66, 0x44, 0x44, 0x20, 0xFE };
const unsigned char * RF_POWER_UP_data[] = {  0x02, 0x01, 0x00, 0x01, 0xC9, 0xC3, 0x80 };
const unsigned char * RF_FRR_CTL_A_MODE_4_data[] = {  0x11, 0x02, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00 };
const unsigned char * RF_MODEM_FREQ_DEV_0_1_data[] = {  0x11, 0x20, 0x01, 0x0C, 0x5E };
const unsigned char * RF_MODEM_AGC_CONTROL_1_data[] = {  0x11, 0x20, 0x01, 0x35, 0xE2 };
const unsigned char * RF_MODEM_MOD_TYPE_12_data[]= { 0x11, 0x20, 0x0C, 0x00, 0x02, 0x00, 0x07, 0x00, 0x2E, 0xE0, 0x01, 0xC9, 0xC3, 0x80, 0x00, 0x01 };
const unsigned char * RF_MODEM_TX_RAMP_DELAY_12_data[]= { 0x11, 0x20, 0x0C, 0x18, 0x01, 0x80, 0x08, 0x03, 0x80, 0x00, 0x70, 0x20, 0x0C, 0xE8, 0x03, 0x0D };
const unsigned char * BCR_NCO_OFFSET_2_12_data[]= { 0x11, 0x20, 0x0C, 0x24, 0x00, 0xA7, 0xC6, 0x00, 0x54, 0x02, 0xC2, 0x00, 0x04, 0x32, 0x80, 0x07 };
const unsigned char * RF_MODEM_AFC_LIMITER_1_3_data[]= { 0x11, 0x20, 0x03, 0x30, 0x17, 0x2A, 0x80 };
const unsigned char * AGC_WINDOW_SIZE_12_data[]= { 0x11, 0x20, 0x0C, 0x38, 0x11, 0xAB, 0xAB, 0x80, 0x1A, 0xFF, 0xFF, 0x00, 0x2B, 0x0C, 0xA4, 0x22 };
const unsigned char * RF_MODEM_RAW_CONTROL_8_data[]= { 0x11, 0x20, 0x08, 0x45, 0x83, 0x01, 0x55, 0x02, 0x80, 0xFF, 0x08, 0x00 };
const unsigned char * COE13_7_0_12_data[]= { 0x11, 0x21, 0x0C, 0x00, 0xFF, 0xBA, 0x0F, 0x51, 0xCF, 0xA9, 0xC9, 0xFC, 0x1B, 0x1E, 0x0F, 0x01 };
const unsigned char * COE1_7_0_12_data[]= { 0x11, 0x21, 0x0C, 0x0C, 0xFC, 0xFD, 0x15, 0xFF, 0x00, 0x0F, 0xFF, 0xBA, 0x0F, 0x51, 0xCF, 0xA9 };
const unsigned char * COE7_7_0_12_data[]= { 0x11, 0x21, 0x0C, 0x18, 0xC9, 0xFC, 0x1B, 0x1E, 0x0F, 0x01, 0xFC, 0xFD, 0x15, 0xFF, 0x00, 0x0F };
const unsigned char * RF_SYNTH_PFDCP_CPFF_7_data[]= { 0x11, 0x23, 0x07, 0x00, 0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03 };
const unsigned char * RF_MODEM_RAW_SEARCH2_2_data[]={ 0x11, 0x20, 0x02, 0x50, 0x84, 0x0A };


const unsigned char tx_ph_data[14] = {'s','w','w','x',0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x6d};

FlagType Flag;

U16 count_1hz, rf_timeout;
U8 spi_read_buf[20];
U8 rx_buf[25];
U8 mode;







void InitTimer0()
 {
 T0CON = 0x85;
 TMR0H = 0x48;
 TMR0L = 0xE5;
 GIE_bit = 1;
 TMR0IE_bit = 1;
 }




void interrupt () {

 if (TMR0IF_bit){
 TMR0IF_bit = 0;
 TMR0H = 0x48;
 TMR0L = 0xE5;
 LATD.B0 =~ LATD.B0;
 }

}




void Tone1();
void Tone2();
void Tone3();

void spi_read(U8 data_length, U8 api_command );
U8 check_cts(void);
void spi_write(unsigned char tx_length, unsigned char *p);
unsigned char spibyte(unsigned char mydata);
void sdn_reset(void);
void SI4463_init(void);
#line 164 "C:/Users/Crow/Desktop/Lab-02/main.c"
void Init_Hardware(void)
{

 GIE_bit = 1;
 PEIE_bit = 1;
 TMR0IE_bit = 1;
 TMR0IP_bit = 1;

 InitTimer0();

 Sound_Init(&PORTC, 2);





 UART1_Init(115200);

 LATC.B2 = 0;
}
#line 197 "C:/Users/Crow/Desktop/Lab-02/main.c"
void main()
{
 ANSELA = 0B00000000;
 ANSELB = 0B00000000;
 ANSELC = 0B00000000;
 ANSELD = 0B00000000;
 ANSELE = 0B00000000;
 ADCON1 = 0B00000000;
 ADCON2 = 0B10101111;


 TRISA = 0B00000000;
 TRISB = 0B00010000;
 TRISC = 0B01010000;
 TRISD = 0B00000000;
 TRISE = 0B00000000;

 PORTA = 0B00000000;
 PORTB = 0B00000000;
 PORTC = 0B00000000;
 PORTD = 0B00000000;
 PORTE = 0B00000000;


 Init_Hardware();

 Delay_ms(800);
 Tone3();
 Delay_ms(100);
 Tone3();

 UART1_Write_Text( "START RADIO SI4463PRO\n\r" );

 Delay_ms(50);

 sdn_reset();

 SI4463_init();

 while(1)
 {



 }
}




void Tone1() {
 Sound_Play(4500, 250);
 LATC.B2 = 0;
}
void Tone2() {
 Sound_Play(1300, 250);
 LATC.B2 = 0;
}
void Tone3() {
 Sound_Play(1000, 250);
 LATC.B2 = 0;
}
#line 271 "C:/Users/Crow/Desktop/Lab-02/main.c"
void SI4463_init(void)
{
 U8 app_command_buf[20];

 app_command_buf[0] = 0x13;
 app_command_buf[1] = 0x14;
 app_command_buf[2] = 0x02;
 app_command_buf[3] = 0x21;
 app_command_buf[4] = 0x20;
 app_command_buf[5] = 0x27;
 app_command_buf[6] = 0x0b;
 spi_write(7, app_command_buf);


 app_command_buf[0] = 0x11;
 app_command_buf[1] = 0x00;
 app_command_buf[2] = 0x01;
 app_command_buf[3] = 0x00;
 app_command_buf[4] = 98;
 spi_write(5, app_command_buf);


 app_command_buf[0] = 0x11;
 app_command_buf[1] = 0x00;
 app_command_buf[2] = 0x01;
 app_command_buf[3] = 0x03;
 app_command_buf[4] = 0x40;
 spi_write(5, app_command_buf);

 spi_write(8, RF_FRR_CTL_A_MODE_4_data);


 app_command_buf[0] = 0x11;
 app_command_buf[1] = 0x10;
 app_command_buf[2] = 0x09;
 app_command_buf[3] = 0x00;
 app_command_buf[4] = 0x08;
 app_command_buf[5] = 0x14;
 app_command_buf[6] = 0x00;
 app_command_buf[7] = 0x0f;
 app_command_buf[8] = 0x31;
 app_command_buf[9] = 0x00;
 app_command_buf[10] = 0x00;
 app_command_buf[11] = 0x00;
 app_command_buf[12] = 0x00;
 spi_write(13, app_command_buf);


 app_command_buf[0] = 0x11;
 app_command_buf[1] = 0x11;
 app_command_buf[2] = 0x05;
 app_command_buf[3] = 0x00;
 app_command_buf[4] = 0x01;
 app_command_buf[5] = 0x2d;
 app_command_buf[6] = 0xd4;
 app_command_buf[7] = 0x00;
 app_command_buf[8] = 0x00;
 spi_write(9, app_command_buf);


 app_command_buf[0] = 0x11;
 app_command_buf[1] = 0x12;
 app_command_buf[2] = 0x01;
 app_command_buf[3] = 0x00;
 app_command_buf[4] = 0x81;
 spi_write(5, app_command_buf);


 app_command_buf[0] = 0x11;
 app_command_buf[1] = 0x12;
 app_command_buf[2] = 0x01;
 app_command_buf[3] = 0x06;
 app_command_buf[4] = 0x02;
 spi_write(5, app_command_buf);


 app_command_buf[0] = 0x11;
 app_command_buf[1] = 0x12;
 app_command_buf[2] = 0x03;
 app_command_buf[3] = 0x08;
 app_command_buf[4] = 0x00;
 app_command_buf[5] = 0x00;
 app_command_buf[6] = 0x00;
 spi_write(7, app_command_buf);

 app_command_buf[0] = 0x11;
 app_command_buf[1] = 0x12;
 app_command_buf[2] = 0x0c;
 app_command_buf[3] = 0x0d;
 app_command_buf[4] = 0x00;
 app_command_buf[5] =  14 ;
 app_command_buf[6] = 0x04;
 app_command_buf[7] = 0xaa;
 app_command_buf[8] = 0x00;
 app_command_buf[9] = 0x00;
 app_command_buf[10] = 0x00;
 app_command_buf[11] = 0x00;
 app_command_buf[12] = 0x00;
 app_command_buf[13] = 0x00;
 app_command_buf[14] = 0x00;
 app_command_buf[15] = 0x00;
 spi_write(16, app_command_buf);


 app_command_buf[0] = 0x11;
 app_command_buf[1] = 0x12;
 app_command_buf[2] = 0x08;
 app_command_buf[3] = 0x19;
 app_command_buf[4] = 0x00;
 app_command_buf[5] = 0x00;
 app_command_buf[6] = 0x00;
 app_command_buf[7] = 0x00;
 app_command_buf[8] = 0x00;
 app_command_buf[9] = 0x00;
 app_command_buf[10] = 0x00;
 app_command_buf[11] = 0x00;
 spi_write(12, app_command_buf);

 spi_write(0x10, RF_MODEM_MOD_TYPE_12_data);
 spi_write(0x05, RF_MODEM_FREQ_DEV_0_1_data);

 spi_write(0x10, RF_MODEM_TX_RAMP_DELAY_12_data);
 spi_write(0x10, BCR_NCO_OFFSET_2_12_data);
 spi_write(0x10, RF_MODEM_TX_RAMP_DELAY_12_data);
 spi_write(0x07, RF_MODEM_AFC_LIMITER_1_3_data);


 spi_write(0x05, RF_MODEM_AGC_CONTROL_1_data);
 spi_write(0x10, AGC_WINDOW_SIZE_12_data);
 spi_write(0x0c, RF_MODEM_RAW_CONTROL_8_data);



 app_command_buf[0] = 0x11;
 app_command_buf[1] = 0x20;
 app_command_buf[2] = 0x01;
 app_command_buf[3] = 0x4e;
 app_command_buf[4] = 0x40;
 spi_write(5, app_command_buf);

 spi_write(0x10, COE13_7_0_12_data);
 spi_write(0x10, COE1_7_0_12_data);
 spi_write(0x10, COE7_7_0_12_data);


 app_command_buf[0] = 0x11;
 app_command_buf[1] = 0x22;
 app_command_buf[2] = 0x04;
 app_command_buf[3] = 0x00;
 app_command_buf[4] = 0x08;
 app_command_buf[5] = 127;
 app_command_buf[6] = 0x00;
 app_command_buf[7] = 0x3d;
 spi_write(8, app_command_buf);

 spi_write(0x0B, RF_SYNTH_PFDCP_CPFF_7_data);


 app_command_buf[0] = 0x11;
 app_command_buf[1] = 0x30;
 app_command_buf[2] = 0x0c;
 app_command_buf[3] = 0x00;
 app_command_buf[4] = 's';
 app_command_buf[5] = 0xff;
 app_command_buf[6] = 0x40;
 app_command_buf[7] = 'w';
 app_command_buf[8] = 0xff;
 app_command_buf[9] = 0x01;
 app_command_buf[10] = 'w';
 app_command_buf[11] =0xff;
 app_command_buf[12] =0x02;
 app_command_buf[13] = 'x';
 app_command_buf[14] = 0xff;
 app_command_buf[15] =0x03;
 spi_write(16, app_command_buf);

 spi_write(6, RF_MODEM_RAW_SEARCH2_2_data);
 spi_write(12, RF_FREQ_CONTROL_INTE_8_data);
}
#line 463 "C:/Users/Crow/Desktop/Lab-02/main.c"
unsigned char spibyte(unsigned char mydata)
{
 unsigned char i;

 for (i = 0; i < 8; i++)
 {
 if (mydata & 0x80)
 SPI_SDI = 1;
 else
 SPI_SDI = 0;

 mydata <<= 1;
 SPI_SCK = 1;

 if (SPI_SDO)
 mydata |= 0x01;
 else
 mydata &= 0xfe;

 SPI_SCK = 0;
 }
 return (mydata);
}
#line 497 "C:/Users/Crow/Desktop/Lab-02/main.c"
void spi_write(unsigned char tx_length, unsigned char *p)
{
 unsigned char i,j;

 i = 0;
 while(i!=0xff)
 i = check_cts();

 SPI_SCK = 0;
 SPI_nSEL = 0;

 for (i = 0; i < tx_length; i++)
 {
 j = *(p+i);
 spibyte(j);
 }

 SPI_nSEL = 1;
}
#line 528 "C:/Users/Crow/Desktop/Lab-02/main.c"
U8 check_cts(void)
{
 U8 i;

 SPI_nSEL = 1;
 SPI_SCK = 0;
 SPI_nSEL = 0;
 spibyte(0x44);
 i = spibyte(0);
 SPI_nSEL = 1;
 return (i);
}
#line 552 "C:/Users/Crow/Desktop/Lab-02/main.c"
void spi_read(U8 data_length, U8 api_command )
{
 U8 i;

 U8 p[1];
 p[0] = api_command;
 i = 0;
 while(i!=0xff)
 i = check_cts();

 spi_write(1, p);

 i = 0;
 while(i!=0xff)
 i = check_cts();

 SPI_nSEL = 1;
 SPI_SCK = 0;
 SPI_nSEL = 0;
 spibyte(0x44);
 for (i = 0; i< data_length; i++)
 spi_read_buf[i] = spibyte(0xff);
 SPI_nSEL = 1;
}
#line 593 "C:/Users/Crow/Desktop/Lab-02/main.c"
void sdn_reset(void)
{
 U8 i;
 UART1_Write_Text("Start RESET Radio\n\r");
 SPI_CE = 1;
 Delay_ms(2);
 SPI_CE = 0;
 Delay_ms(10);

 SPI_nSEL = 1;
 SPI_SCK = 0;
 SPI_nSEL = 0;

 for (i = 0; i< 7; i++)
 {
 spibyte(RF_POWER_UP_data[i]);
 }
 SPI_nSEL = 1;

 Delay_ms(20);
}
