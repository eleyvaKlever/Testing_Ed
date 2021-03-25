
/*****************************************************************************************************************************************************************
MOSI / SDO:Esta línea se utiliza para enviar datos a un esclavo. Se puede leer como un salve-in maestro.
MOSI / SDI:Cable MOSI utilizado para recibir datos de un esclavo. Es una línea de entrada para el maestro y una línea de salida para un esclavo.
SCLK:  Cable de señal de reloj
CS / SS:  En el caso de una configuración de un solo maestro y varios esclavos, este cable se usa para seleccionar a qué esclavo, dispositivo maestro desea enviar datos.

SDO: Salida de datos en serie del maestro y entrada al esclavo [MOSI]
IDE: Entrada de datos en serie al maestro y salida del esclavo [MISO]
SCLK: Salida de reloj en serie del maestro [SCK] Entrada al esclavo [SCK]
CE: Chip Enable o SS (selección de esclavo)

*****************************************************************************************************************************************************************/

 // #define SPI_SCK       LATCbits.LATC3        // Clock pin, PORTC pin 3 
 // #define SPI_SDO       LATCbits.LATC5        // Serial output pin, PORTC pin 5 
 // #define SPI_SDI       PORTCbits.RC4         // Serial input pin, PORTC pin 4 
 // #define SPI_nSEL      LATCbits.LATE0        // CSN output pin, PORTC pin 2
 // #define SPI_CE        LATCbits.LATE1        // CE output pin, PORTC pin 1
 // #define SPI_IRQ       PORTBbits.RB0         // IRQ input pin, PORTB pin 0
 // #define SPI_SCALE     4                     // postscaling of signal 

#include "radio_config_si4463.h"

sbit SPI_SCK  at RC3_bit;
sbit SPI_SDO  at RC5_bit;
sbit SPI_SDI  at RC4_bit;
sbit SPI_nSEL at RE0_bit;
sbit SPI_CE   at RE1_bit;
sbit SPI_IRQ  at RB0_bit;


 // Macros
 #define nop() _asm nop _endasm
 
typedef     unsigned char   U8;
typedef     unsigned int    U16;
typedef     unsigned long   U32;
typedef     char            S8;
typedef     int             S16;
typedef     long            S32;

#define PART_INFO                       0x01
#define FUNC_INFO                       0x10
#define SET_PROPERTY                    0x11 
#define GET_PROPERTY                    0x12 
#define GPIO_PIN_CFG                    0x13
#define GET_ADC_READING                 0x14 
#define FIFO_INFO                       0x15
#define PACKET_INFO                     0x16
#define IRCAL                           0x17 
#define PROTOCOL_CFG                    0x18 
#define GET_INT_STATUS                  0x20
#define GET_PH_STATUS                   0x21
#define GET_MODEM_STATUS                0x22
#define GET_CHIP_STATUS                 0x23
#define START_TX                        0x31 
#define START_RX                        0x32 
#define REQUEST_DEVICE_STAT             0x33
#define CHANGE_STATE                    0x34 
#define READ_CMD_BUFF                   0x44 
#define FRR_A_READ                      0x50
#define FRR_B_READ                      0x51 
#define FRR_C_READ                      0x53 
#define FRR_D_READ                      0x57 
#define WRITE_TX_FIFO                   0x66 
#define READ_RX_FIFO                    0x77 
#define START_MFSK                      0x35 
#define RX_HOP                          0x36 

#define payload_length                  14

#define freq_channel        0 

typedef struct 
{
    unsigned char reach_1s              : 1;    
    unsigned char is_tx                 : 1;
    unsigned char rf_reach_timeout      : 1;
}FlagType;
//const unsigned char RF_MODEM_DSA_CTRL1_5_data[] =         {RF_MODEM_DSA_CTRL1_5};
const unsigned char * RF_FREQ_CONTROL_INTE_8_data[] =         {RF_FREQ_CONTROL_INTE_8};
const unsigned char * RF_POWER_UP_data[] =                    { RF_POWER_UP};
const unsigned char * RF_FRR_CTL_A_MODE_4_data[] =            { RF_FRR_CTL_A_MODE_4};
const unsigned char * RF_MODEM_FREQ_DEV_0_1_data[] =          { RF_MODEM_FREQ_DEV_0_1};
const unsigned char * RF_MODEM_AGC_CONTROL_1_data[] =         { RF_MODEM_AGC_CONTROL_1};
const unsigned char * RF_MODEM_MOD_TYPE_12_data[]=            {RF_MODEM_MOD_TYPE_12};
const unsigned char * RF_MODEM_TX_RAMP_DELAY_12_data[]=               {RF_MODEM_TX_RAMP_DELAY_12};
const unsigned char * BCR_NCO_OFFSET_2_12_data[]=                 {RF_MODEM_BCR_NCO_OFFSET_2_12};
const unsigned char * RF_MODEM_AFC_LIMITER_1_3_data[]=                        {RF_MODEM_AFC_LIMITER_1_3};
const unsigned char * AGC_WINDOW_SIZE_12_data[]=              {RF_MODEM_AGC_WINDOW_SIZE_12};
const unsigned char * RF_MODEM_RAW_CONTROL_8_data[]=                  {RF_MODEM_RAW_CONTROL_8};
const unsigned char * COE13_7_0_12_data[]=    {RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12};
const unsigned char * COE1_7_0_12_data[]= {RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12};
const unsigned char * COE7_7_0_12_data[]= {RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12};
const unsigned char * RF_SYNTH_PFDCP_CPFF_7_data[]=                   {RF_SYNTH_PFDCP_CPFF_7};
const unsigned char * RF_MODEM_RAW_SEARCH2_2_data[]={RF_MODEM_RAW_SEARCH2_2};

//const unsigned char tx_test_aa_data[14] = {0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa};  
const unsigned char tx_ph_data[14] = {'s','w','w','x',0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x6d};  // test signal£¬The 10th data is a former nine checksum

FlagType    Flag;

U16 count_1hz, rf_timeout;
U8 spi_read_buf[20];  
U8 rx_buf[25];
U8 mode;


//*****************************************************************************************************************************************************************/
//                                 Definicion de Variables Globales

//*****************************************************************************************************************************************************************/
//                                 Timer para demostrar que el MCU esta operando
void InitTimer0()
 {
  T0CON  = 0x85;
  TMR0H  = 0x48;
  TMR0L  = 0xE5;
  GIE_bit    = 1;
  TMR0IE_bit     = 1;
 }

//*****************************************************************************************************************************************************************/
//                                 Rutina de Interrupcion Sreial 1, Serial 2 y Timer 0

void interrupt ()  {

  if (TMR0IF_bit){ 
    TMR0IF_bit = 0;
    TMR0H    = 0x48;
    TMR0L    = 0xE5;
    LATD.B0    =~ LATD.B0;  //Version Nueva
    }

}

//*****************************************************************************************************************************************************************/
//                                 Prototipeado de Funciones

void Tone1();                                            // Funcion de Tono 1 a 4500 hz y 250 ms
void Tone2();                                            // Funcion de Tono 1 a 4500 hz y 250 ms
void Tone3();                                            // Funcion de Tono 1 a 4500 hz y 250 ms

void spi_read(U8 data_length, U8 api_command );
U8 check_cts(void);
void spi_write(unsigned char tx_length, unsigned char *p);
unsigned char spibyte(unsigned char mydata);
void sdn_reset(void);
void SI4463_init(void);

/*****************************************************************************************************************************************************************
*  Function: Init_Hardware
*
*  Description:
*  Initailize oscillator, SPI comunication with SI4463PRO, RX interrupt and etc.
*
*  In/Out parameters:
*  In: none
*  Out: none
/******************************************************************************************************************************************************************/


void Init_Hardware(void)
{
   
  GIE_bit     = 1;                    // Enable Global interrupt
  PEIE_bit    = 1;                    // Enable Peripheral interrupt
  TMR0IE_bit  = 1;                    // Enable Timer0 interrupt
  TMR0IP_bit  = 1;                    // Overflow Interrupt Proirity bit

  InitTimer0();                       // Activo el timer del Led que indica que esta trabajando todo el sistema
  
  Sound_Init(&PORTC, 2);              // Declaro el puerto de salida para el sonido o buzzer

 // Initialize SPI1 module
  //SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);

 // Inialtize EUSART 1
  UART1_Init(115200);                 // Initialize UART module at 115200
  
  LATC.B2 = 0;                        // Pongo el Pin en 0 para evitar que se caliente el driver del Buzzer
}

//********************************************************/**************************************************************************************************


/*

  __  __       _
 |  \/  |     (_)
 | \  / | __ _ _ _ __
 | |\/| |/ _` | | '_ \
 | |  | | (_| | | | | |
 |_|  |_|\__,_|_|_| |_|
 */
void main()
{                          //                                  7--6--5--4--3--2--1--0
    ANSELA = 0B00000000;   // Puertos Digitales o Analogicos   x--x--0--x--0--0--0--0 --> 1 Analogico , 0 Digitales , x No aplica ANSELA(0,1,2,3,5)
    ANSELB = 0B00000000;   // Puertos Digitales o Analogicos   x--x--0--0--0--0--0--0 --> 1 Analogico , 0 Digitales , x No aplica ANSELB(0,1,2,3,4,5)
    ANSELC = 0B00000000;   // Puertos Digitales o Analogicos   0--0--0--0--0--0--x--x --> 1 Analogico , 0 Digitales , x No aplica ANSELC(3,4,5,6,7)
    ANSELD = 0B00000000;   // Puertos Digitales o Analogicos   0--0--0--0--0--0--x--x --> 1 Analogico , 0 Digitales , x No aplica ANSELC(3,4,5,6,7)
    ANSELE = 0B00000000;   // Puertos Digitales o Analogicos   0--0--0--0--0--0--x--x --> 1 Analogico , 0 Digitales , x No aplica ANSELC(3,4,5,6,7)
    ADCON1 = 0B00000000;   // Voltaje de Ref. a VDD y VSS      0--X--X--X--0--0--0--0 --> 0 VDD, 0 VSS Voltaje de Referencia.
    ADCON2 = 0B10101111;   // Tiempo de Adqu. Datos 20TD       0--X--X--X--0--0--0--0 --> Tiempo de muestreo de datos

                           //                                  7--6--5--4--3--2--1--0
    TRISA  = 0B00000000;   // Puertos Entrada o Salida         0--0--0--0--0--0--0--0 --> 0 Salida 1 Entrada
    TRISB  = 0B00010000;   // Puertos Entrada o Salida         0--0--0--0--0--0--0--0 --> 0 Salida 1 Entrada
    TRISC  = 0B01010000;   // Puertos Entrada o Salida         0--0--0--0--0--0--0--0 --> 0 Salida 1 Entrada
    TRISD  = 0B00000000;   // Puertos Entrada o Salida         0--0--0--0--0--0--0--0 --> 0 Salida 1 Entrada
    TRISE  = 0B00000000;   // Puertos Entrada o Salida         0--0--0--0--0--0--0--0 --> 0 Salida 1 Entrada

    PORTA  = 0B00000000;   // Borro el puerto por si hay basura
    PORTB  = 0B00000000;   // Borro el puerto por si hay basura
    PORTC  = 0B00000000;   // Borro el puerto por si hay basura
    PORTD  = 0B00000000;   // Borro el puerto por si hay basura
    PORTE  = 0B00000000;   // Borro el puerto por si hay basura


    Init_Hardware();

    Delay_ms(800);                            // Le doy un tiempo para evitar inestabilidad de configuracon
    Tone3();                                  // Hago un tono de inicializacion
    Delay_ms(100);                            // Le doy un tiempo para el sonido 
    Tone3();                                  // Hago un tono de inicializacion

    UART1_Write_Text( "START RADIO SI4463PRO\n\r" );

    Delay_ms(50);                             // Retardo por seguridad de lectura

    sdn_reset();// reset RF

    SI4463_init();  // RF INIT

    while(1)                                  // Loop principal
    {

       
       
    }
}

//*****************************************************************************************************************************************************************/
//                                 Funcion de Sonido en varias frecuencias

void Tone1() {                          // Rutina de Tono sw 4500 Hz
    Sound_Play(4500, 250);                // Frequency = 4500Hz, duration = 250ms
    LATC.B2 = 0;                          // Seteo el pin a Bajo para no activar el transistor del buzzer y se caliente.
}
void Tone2() {                          // // Rutina de Tono sw 1300 Hz
    Sound_Play(1300, 250);                // Frequency = 1300Hz, duration = 250ms
    LATC.B2 = 0;                          // Seteo el pin a Bajo para no activar el transistor del buzzer y se caliente.
}
void Tone3() {                          // Rutina de Tono sw 800 Hz
    Sound_Play(1000, 250);                 // Frequency = 800Hz, duration = 250ms
    LATC.B2 = 0;                          // Seteo el pin a Bajo para no activar el transistor del buzzer y se caliente.
}

/**************************************************************************************************
*  Function: SPI BYTE
*
*  Description:
*  Writes one byte to nRF24L01, and return the byte read
*  from nRF24L01 during write, according to SPI protocol
*
*  In/Out parameters:
*  In: 'byte', current byte to be written
*  Out: 'SPI1'
**************************************************************************************************/
void SI4463_init(void)
{   
    U8 app_command_buf[20];
    //spi_write(0x07, RF_GPIO_PIN_CFG_data);   
    app_command_buf[0] = 0x13;          // SET GPIO PORT
    app_command_buf[1]  = 0x14;         // gpio 0 ,Rx data
    app_command_buf[2]  = 0x02;         // gpio1, output 0
    app_command_buf[3]  = 0x21;         // gpio2, hign while in receive mode
    app_command_buf[4]  = 0x20;         // gpio3, hign while in transmit mode 
    app_command_buf[5]  = 0x27;         // nIRQ
    app_command_buf[6]  = 0x0b;         // sdo
    spi_write(7, app_command_buf); 
        
    // spi_write(0x05, RF_GLOBAL_XO_TUNE_1_data); 
    app_command_buf[0] = 0x11;  
    app_command_buf[1]  = 0x00;    
    app_command_buf[2]  = 0x01;    
    app_command_buf[3]  = 0x00;  
    app_command_buf[4]  = 98;           // freq  adjustment
    spi_write(5, app_command_buf);

    // spi_write(0x05, RF_GLOBAL_CONFIG_1_data);
    app_command_buf[0] = 0x11;  
    app_command_buf[1]  = 0x00;
    app_command_buf[2]  = 0x01; 
    app_command_buf[3]  = 0x03; 
    app_command_buf[4]  = 0x40;         // tx = rx = 64 byte,PH,high performance mode
    spi_write(5, app_command_buf); 
    
    spi_write(8, RF_FRR_CTL_A_MODE_4_data);    // disable all fast response register
     
    // spi_write(0x0D, RF_PREAMBLE_TX_LENGTH_9_data); // set Preamble
    app_command_buf[0] = 0x11;  
    app_command_buf[1]  = 0x10;    
    app_command_buf[2]  = 0x09;    
    app_command_buf[3]  = 0x00;   
    app_command_buf[4]  = 0x08;                         //  8 bytes Preamble
    app_command_buf[5]  = 0x14;                         //  detect 20 bits
    app_command_buf[6]  = 0x00;                     
    app_command_buf[7]  = 0x0f;
    app_command_buf[8]  = 0x31;                         //  no manchest.1010.¡£¡£
    app_command_buf[9]  = 0x00;
    app_command_buf[10]  = 0x00;
    app_command_buf[11]  = 0x00;
    app_command_buf[12]  = 0x00;
    spi_write(13, app_command_buf); 
    
    //  RF_SYNC_CONFIG_5_data,                          // set sync
    app_command_buf[0] = 0x11;  
    app_command_buf[1]  = 0x11;
    app_command_buf[2]  = 0x05;
    app_command_buf[3]  = 0x00;
    app_command_buf[4]  = 0x01;                         // no manchest , 2 bytes
    app_command_buf[5]  = 0x2d;                         // sync byte3
    app_command_buf[6]  = 0xd4;                         // sync byte2
    app_command_buf[7]  = 0x00;                         // sync byte1
    app_command_buf[8]  = 0x00;                         // sync byte0
    spi_write(9, app_command_buf);
        
    //  packet crc         
    app_command_buf[0] = 0x11;  
    app_command_buf[1]  = 0x12; 
    app_command_buf[2]  = 0x01; 
    app_command_buf[3]  = 0x00;
    app_command_buf[4]  = 0x81;                         // CRC = itu-c, enable crc
    spi_write(5, app_command_buf);  
        
    // packet   gernale configuration        
    app_command_buf[0] = 0x11;  
    app_command_buf[1]  = 0x12;
    app_command_buf[2]  = 0x01;
    app_command_buf[3]  = 0x06;
    app_command_buf[4]  = 0x02;                         // CRC MSB£¬ data MSB
    spi_write(5, app_command_buf);
        
    // spi_write(0x07, RF_PKT_LEN_3_data);   
    app_command_buf[0] = 0x11;  
    app_command_buf[1]  = 0x12;
    app_command_buf[2]  = 0x03;
    app_command_buf[3]  = 0x08;
    app_command_buf[4]  = 0x00;
    app_command_buf[5]  = 0x00;
    app_command_buf[6]  = 0x00;                      
    spi_write(7, app_command_buf);         
    
    app_command_buf[0] = 0x11;  
    app_command_buf[1]  = 0x12;
    app_command_buf[2]  = 0x0c;
    app_command_buf[3]  = 0x0d;
    app_command_buf[4]  = 0x00;
    app_command_buf[5]  = payload_length;
    app_command_buf[6]  = 0x04;
    app_command_buf[7]  = 0xaa;
    app_command_buf[8]  = 0x00;
    app_command_buf[9]  = 0x00;
    app_command_buf[10]  = 0x00;
    app_command_buf[11]  = 0x00;
    app_command_buf[12]  = 0x00; 
    app_command_buf[13]  = 0x00;
    app_command_buf[14]  = 0x00;
    app_command_buf[15]  = 0x00;
    spi_write(16, app_command_buf);                 // set length of Field 1 -- 4
  
    // spi_write(0x0C, RF_PKT_FIELD_4_LENGTH_12_8_8_data);
    app_command_buf[0] = 0x11;  
    app_command_buf[1]  = 0x12; 
    app_command_buf[2]  = 0x08;
    app_command_buf[3]  = 0x19;
    app_command_buf[4]  = 0x00;
    app_command_buf[5]  = 0x00;
    app_command_buf[6]  = 0x00;
    app_command_buf[7]  = 0x00;
    app_command_buf[8]  = 0x00;
    app_command_buf[9]  = 0x00;
    app_command_buf[10]  = 0x00;
    app_command_buf[11]  = 0x00;
    spi_write(12, app_command_buf);
    
    spi_write(0x10, RF_MODEM_MOD_TYPE_12_data);        
    spi_write(0x05, RF_MODEM_FREQ_DEV_0_1_data);
    
    spi_write(0x10, RF_MODEM_TX_RAMP_DELAY_12_data);        
    spi_write(0x10, BCR_NCO_OFFSET_2_12_data);
    spi_write(0x10, RF_MODEM_TX_RAMP_DELAY_12_data);            
    spi_write(0x07, RF_MODEM_AFC_LIMITER_1_3_data); 
    //spi_write(0x10, BCR_NCO_OFFSET_2_12_data);

    spi_write(0x05, RF_MODEM_AGC_CONTROL_1_data);       
    spi_write(0x10, AGC_WINDOW_SIZE_12_data);   
    spi_write(0x0c, RF_MODEM_RAW_CONTROL_8_data);
//  spi_write(0x10, AGC_WINDOW_SIZE_12_data);
    
    // spi_write(0x05, RF_MODEM_RSSI_COMP_1_data);
    app_command_buf[0] = 0x11;  
    app_command_buf[1] = 0x20;                                                     
    app_command_buf[2] = 0x01;                                                   
    app_command_buf[3] = 0x4e;             
    app_command_buf[4]  = 0x40;
    spi_write(5, app_command_buf);                   
   
    spi_write(0x10, COE13_7_0_12_data);
    spi_write(0x10, COE1_7_0_12_data);
    spi_write(0x10, COE7_7_0_12_data);       
        
    // RF_PA
    app_command_buf[0]  = 0x11;  
    app_command_buf[1]  = 0x22;                                                    
    app_command_buf[2]  = 0x04;                                               
    app_command_buf[3]  = 0x00;                                                     
    app_command_buf[4]  = 0x08;
    app_command_buf[5]  = 127;                          // set max power
    app_command_buf[6]  = 0x00;
    app_command_buf[7]  = 0x3d;
    spi_write(8, app_command_buf);        
    
    spi_write(0x0B, RF_SYNTH_PFDCP_CPFF_7_data);
        
    // header match
    app_command_buf[0] = 0x11;  
    app_command_buf[1]  = 0x30;                                                     
    app_command_buf[2]  = 0x0c;                                                   
    app_command_buf[3]  = 0x00;                                                       
    app_command_buf[4]  = 's';
    app_command_buf[5]  = 0xff;
    app_command_buf[6]  = 0x40;
    app_command_buf[7]  = 'w';                                      
    app_command_buf[8]  = 0xff;                                       
    app_command_buf[9]  = 0x01; 
    app_command_buf[10] = 'w';                                   
    app_command_buf[11]  =0xff;                                       
    app_command_buf[12]  =0x02;
    app_command_buf[13]  = 'x';                                  
    app_command_buf[14]  = 0xff;
    app_command_buf[15]  =0x03;
    spi_write(16, app_command_buf);
    
    spi_write(6, RF_MODEM_RAW_SEARCH2_2_data);
    spi_write(12, RF_FREQ_CONTROL_INTE_8_data);         // set frequency        
}    

/**************************************************************************************************
*  Function: SPI BYTE
*
*  Description:
*  Writes one byte to nRF24L01, and return the byte read
*  from nRF24L01 during write, according to SPI protocol
*
*  In/Out parameters:
*  In: 'byte', current byte to be written
*  Out: 'SPI1'
**************************************************************************************************/

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
/**************************************************************************************************
*  Function: SPI WRITE
*
*  Description:
*  Writes one byte to nRF24L01, and return the byte read
*  from nRF24L01 during write, according to SPI protocol
*
*  In/Out parameters:
*  In: 'byte', current byte to be written
*  Out: 'SPI1'
**************************************************************************************************/
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
/**************************************************************************************************
*  Function: SPI BYTE
*
*  Description:
*  Writes one byte to nRF24L01, and return the byte read
*  from nRF24L01 during write, according to SPI protocol
*
*  In/Out parameters:
*  In: 'byte', current byte to be written
*  Out: 'SPI1'
**************************************************************************************************/

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
 
/**************************************************************************************************
*  Function: SPI BYTE
*
*  Description:
*  Writes one byte to nRF24L01, and return the byte read
*  from nRF24L01 during write, according to SPI protocol
*
*  In/Out parameters:
*  In: 'byte', current byte to be written
*  Out: 'SPI1'
**************************************************************************************************/
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

/**************************************************************************************************
//  Function: nRF_SPI_Read
//
//  Description:
//  Read one byte from nRF24L01 register, 'reg'
//
//  In/Out parameters:
//  In: reg, register to read
//  Out: return reg_val, register value.
sbit SPI_SCK  at RC3_bit;
sbit SPI_SDO  at RC5_bit;
sbit SPI_SDI  at RC4_bit;
sbit SPI_nSEL at RE0_bit;
sbit SPI_CE   at RE1_bit;
sbit SPI_IRQ  at RB0_bit;
**************************************************************************************************/
void sdn_reset(void)
{   
    U8 i;
    UART1_Write_Text("Start RESET Radio\n\r");
    SPI_CE = 1;
    Delay_ms(2);
    SPI_CE = 0;
    Delay_ms(10);
 
    SPI_nSEL = 1;   
    SPI_SCK  = 0;
    SPI_nSEL = 0;

    for (i = 0; i< 7; i++)
        {
          spibyte(RF_POWER_UP_data[i]);  
        }   
    SPI_nSEL = 1;
 
    Delay_ms(20);
}

// unsigned char nRF_SPI_RW(unsigned char byte)
// {
//   return(SPI_Read(byte));                        // Perform HW SPI operation
// }

// unsigned char nRF_SPI_Read(unsigned char reg)
// {
//   unsigned char reg_val;

//   SPI_nSEL = 0;                                     // CSN low, initialize SPI communication...
//   nRF_SPI_RW(reg);                                // Select register to read from..
//   reg_val = nRF_SPI_RW(0);                        // ..then read registervalue
//   SPI_nSEL = 1;                                     // CSN high, terminate SPI communication

//   return(reg_val);                                // return register value
// }