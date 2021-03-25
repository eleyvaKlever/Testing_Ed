// DRIVER PARA RADIO RF4463 PRO DE NICERF

// Escrito sin acentos para una mejor lectura

// DEFINICIONES
#define RF_MAX_BUFFER_LENGTH        64

unsigned char ucRF4463MatchEnableReg = 0x40;

// VARIABLES DE LIBRERIA
static unsigned char ucRF4463IRQ = 0;

//unsigned char ucSourceNode = 0;
unsigned char ucRFTxEventPending  = 0;

unsigned char pcRF4463TxBuffer[ RF_MAX_BUFFER_LENGTH ] = { 0x00 };
unsigned char pcRF4463RxBuffer[ RF_MAX_BUFFER_LENGTH ] = { 0x00 };


// FUNCIONES
void vRF4463Init ( void );
void vRF4463GPIO_SET( unsigned char ucData );


void vRF4463ClearInterrupts ( void );



#ifdef STM32F107VC
void vRF4463ISR() iv IVT_INT_EXTI15_10 ics ICS_AUTO{
    if( EXTI_PR.B12 ){
        EXTI_PR.B12 |= 1;
        LED_RED = 1;
        ucRF4463IRQ = 1;
        vRF4463ClearInterrupts();
    }
}
#endif

#ifdef STM32G071KB
void vRF4463ISR() iv IVT_INT_EXTI2_3 ics ICS_AUTO{
     if ( EXTI_FPR1bits.FPIF2 ){
        EXTI_FPR1bits.FPIF2 = 1;
        vRF4463ClearInterrupts();
        ucRF4463IRQ = 1;
     }
}
#endif


// Funcion de inicializacion.
// Seguramente requiere argumentos para configuracion
void vRF4463Init ( void ) {  // MODE,
     unsigned char ucAppCommandBuf[ 20 ], i;

     for ( i = 4; i < 16; i++ ) {
         RF_MODEM_MOD_TYPE_12_data[ i ] = RF_MODEM_MOD_TYPE_12[ ucRF4463Rate ][ i - 4 ];
     }

     //
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
     
     
     // Configura GPIO
     vRF4463GPIO_SET( ucRF4463Mode );                              // PARAMETRO CONFIGURABLE

     // spi_write(0x05, RF_GLOBAL_XO_TUNE_1_data);   //  Frequency adjustment
     ucAppCommandBuf[ 0 ] = 0x11;    // SET PROPERTY
     ucAppCommandBuf[ 1 ] = 0x00;    // 0x0000
     ucAppCommandBuf[ 2 ] = 0x01;    // Total 1 Parameters
     ucAppCommandBuf[ 3 ] = 0x00;    // 0x0000
     ucAppCommandBuf[ 4 ] = 98;      // freq  adjustment    ( rango desde 0 - 127 Low cap - High Cap )
     vSPIWrite( 5, ucAppCommandBuf );

     // spi_write(0x05, RF_GLOBAL_CONFIG_1_data);  //  *******************************************************
     ucAppCommandBuf[ 0 ] = 0x11;    // SET PROPERTY
     ucAppCommandBuf[ 1 ] = 0x00;    // 0x0003
     ucAppCommandBuf[ 2 ] = 0x01;    // Total 1 Parameters
     ucAppCommandBuf[ 3 ] = 0x03;    // 0x0003
     ucAppCommandBuf[ 4 ] = 0x40;    // tx = rx = 64 byte, ordinary PH,high performance mode  ?????????????????????
     vSPIWrite( 5, ucAppCommandBuf );

     // ************************ PRUEBA DE CONCEPTO WUT ******************************
//     ucAppCommandBuf[ 0 ] = 0x11;    // SET PROPERTY
//     ucAppCommandBuf[ 1 ] = 0x00;    // 0x0004
//     ucAppCommandBuf[ 2 ] = 0x05;    // Total 1 Parameters
//     ucAppCommandBuf[ 3 ] = 0x04;    // 0x0004
//
//     ucAppCommandBuf[ 4 ] = 0x42;    // tx = rx = 64 byte, ordinary PH,high performance mode  ?????????????????????
//     ucAppCommandBuf[ 5 ] = 0x06;
//     ucAppCommandBuf[ 6 ] = 0x6A;
//     ucAppCommandBuf[ 7 ] = 0x22;
//     ucAppCommandBuf[ 8 ] = 0x59;
//
//     vSPIWrite( 9, ucAppCommandBuf );

     // ************************ PRUEBA DE CONCEPTO ******************************



     // ************************ PRUEBA DE CONCEPTO ******************************
     // *****************************************************************************
     vSPIWrite( 0x08, RF_FRR_CTL_A_MODE_4_data );    // disable all fast response register

     // spi_write(0x0D, RF_PREAMBLE_TX_LENGTH_9_data); Preamble setting*********************************************
     ucAppCommandBuf[ 0 ] = 0x11;    // SET PROPERTY
     ucAppCommandBuf[ 1 ] = 0x10;    // 0x1000
     ucAppCommandBuf[ 2 ] = 0x09;    // Total 9 Parameters
     ucAppCommandBuf[ 3 ] = 0x00;    // 0x1000

     if ( ucRF4463Mode == tx_test_mode ) {
        ucAppCommandBuf[ 4 ] = 0xff;     //  Need to send 255 bytes of Preamble
     }
     else {
          ucAppCommandBuf[ 4 ] = 0x08;   //  Need to send 8 bytes of Preamble
     }

     //ucAppCommandBuf[4]  = 0x08;        // Need to send 8 bytes of Preamble
     ucAppCommandBuf[ 5 ]   = 0x14;       // To detect 20 bit sync word,
     ucAppCommandBuf[ 6 ]   = 0x00;       // Non-standard preamble settings, useless
     ucAppCommandBuf[ 7 ]   = 0x0f;       // Time of the preamble Timeout   ????????????????????????????????????????????????????????????
     ucAppCommandBuf[ 8 ]   = 0x31;       // The length of the preamble is   byte Calculation , 1st = 1 NO manchest  Encoding, using standard 1010.??
     ucAppCommandBuf[ 9 ]   = 0x0;        // Non-standard Preamble Patten 4th byte
     ucAppCommandBuf[ 10 ]  = 0x00;       // Non-standard Preamble Patten 3rd byte
     ucAppCommandBuf[ 11 ]  = 0x00;       // Non-standard Preamble Patten 2nd byte
     ucAppCommandBuf[ 12 ]  = 0x00;       // Non-standard Preamble Patten 1st byte
     vSPIWrite(13, ucAppCommandBuf);

     //  RF_SYNC_CONFIG_5_data,  Sync word settings *********************************************
     ucAppCommandBuf[ 0 ] = 0x11;         // SET PROPERTY
     ucAppCommandBuf[ 1 ] = 0x11;         // command = 0x1100
     ucAppCommandBuf[ 2 ] = 0x05;         // Total 5 Parameters
     ucAppCommandBuf[ 3 ] = 0x00;         // command = 0x1100
     ucAppCommandBuf[ 4 ] = 0x01;         // The synchronization word is defined and sent in the length field, and the synchronization word cannot be wrong,Not 4FSK, not manchest encoding, only 2 bytes

     if ( ucRF4463Mode == tx_test_mode ) {
        ucAppCommandBuf[ 5 ] = 0x55;      // Sync word 3
        ucAppCommandBuf[ 6 ] = 0x55;      // Sync word 2
     }
     else {
          ucAppCommandBuf[ 5 ] = 0x2d;    // Sync word 3
          ucAppCommandBuf[ 6 ] = 0xd4;    // Sync word 2
     }

     ucAppCommandBuf[ 7 ] = 0x00;         // Sync word 1
     ucAppCommandBuf[ 8 ] = 0x00;         // Sync word 0
     vSPIWrite( 9, ucAppCommandBuf );

     //  packet crc Set up *******************************************************************
     ucAppCommandBuf[ 0 ] = 0x11;        // SET PROPERTY
     ucAppCommandBuf[ 1 ] = 0x12;        // command = 0x1200
     ucAppCommandBuf[ 2 ] = 0x01;        // Total 1 Parameters
     ucAppCommandBuf[ 3 ] = 0x00;        // command = 0x1200
     ucAppCommandBuf[ 4 ] = 0x85;        // 1?cRC ??,CRC = itu-c, enable crc   ( original 0x81; )
     vSPIWrite( 5, ucAppCommandBuf );

     // packet   gernale configuration
     ucAppCommandBuf[ 0 ] = 0x11;        // SET PROPERTY
     ucAppCommandBuf[ 1 ] = 0x12;        // command = 0x1206
     ucAppCommandBuf[ 2 ] = 0x01;        // Total 1Parameters
     ucAppCommandBuf[ 3 ] = 0x06;        // command = 0x1206
     ucAppCommandBuf[ 4 ] = 0x02;        //  tx = rx = 120d--1220 (tx packet,ph enable, not 4fsk, After receiving a packet of data,RX off,CRC Do not flip ,CRC MSB, data MSB
     vSPIWrite( 5, ucAppCommandBuf );

     // spi_write(0x07, RF_PKT_LEN_3_data);   //  Fixed length, one byte in length, length information is not in Payload
     ucAppCommandBuf[ 0 ] = 0x11;        // SET PROPERTY
     ucAppCommandBuf[ 1 ] = 0x12;        // command = 0x1208
     ucAppCommandBuf[ 2 ] = 0x05;        // Total 3 Parameters
     ucAppCommandBuf[ 3 ] = 0x08;        // command = 0x1208
     ucAppCommandBuf[ 4 ] = 0x02;        // 0x00;        // Length Field = LSB,  length Only 1 byte,length Not put In FiFo, fixed packet length mode
     ucAppCommandBuf[ 5 ] = 0x01;        // 0x00;        // Used for variable packet length mode, which defines which Field contains length Filed
     ucAppCommandBuf[ 6 ] = 0x00;        // Used for variable packet length mode, adjust the length of variable packet length
     //ucAppCommandBuf[ 7 ] = 0x20;
     //ucAppCommandBuf[ 8 ] = 0x05;
     
     //ucAppCommandBuf[ 4 ] = 0x00;        // Length Field = LSB,  length Only 1 byte,length Not put In FiFo, fixed packet length mode
//     ucAppCommandBuf[ 5 ] = 0x00;        // Used for variable packet length mode, which defines which Field contains length Filed
//ucAppCommandBuf[ 6 ] = 0x00;        // Used for variable packet length mode, adjust the length of variable packet length
     vSPIWrite( 7, ucAppCommandBuf );

     // length Field 1 -- 4 setting
     ucAppCommandBuf[ 0 ]  = 0x11;
     ucAppCommandBuf[ 1 ]  = 0x12;   // 0x120d
     ucAppCommandBuf[ 2 ]  = 0x0c;   // Total 12 Parameters
     ucAppCommandBuf[ 3 ]  = 0x0d;   // 0x120d
     
     // Field 1
     ucAppCommandBuf[ 4 ]  = 0x00;   // 0x0D  // Field 1 length (?4?)                             // 0x0D
     ucAppCommandBuf[ 5 ]  = payload_length;  // field 1 length, (? 8?), ?Total14???        // 0x0E
     ucAppCommandBuf[ 6 ]  = 0x00;   // 0x0F  // field 1 Is not 4FSK,manchest, whiting, PN9,       // 0x0F
     ucAppCommandBuf[ 7 ]  = 0xaa;   // 0x10  // field 1 crc enble, check enbale, There are also launchingCRC,cRC?Seed ?CRC_seed?????
     
     // Field 2
     ucAppCommandBuf[ 8 ]  = 0x00;   // 0x11  // field 2 length(?4?)
     ucAppCommandBuf[ 9 ]  = 0x00;   // 0x12  // field 2 length, (? 8?), length = 0 Means thisfield did not use
     ucAppCommandBuf[ 10 ] = 0x00;   // 0x13  // field 2 Is not 4FSK,manchest, whiting, PN9
     ucAppCommandBuf[ 11 ] = 0x00;   // 0x14  // field 2 ?CRCSet up
     
     // Field 3
     ucAppCommandBuf[ 12 ] = 0x00;   // 0x15  // field 3 length, (? 8?), length = 0 Means thisfield did not use
     ucAppCommandBuf[ 13 ] = 0x00;   // 0x16  // field 3 length, (? 8?), length = 0 Means thisfield did not use
     ucAppCommandBuf[ 14 ] = 0x00;   // 0x17  // field 3 Is not 4FSK,manchest, whiting, PN9
     ucAppCommandBuf[ 15 ] = 0x00;   // 0x18  // field 3 ?CRCSet up
     vSPIWrite( 16, ucAppCommandBuf );

     // spi_write(0x0C, RF_PKT_FIELD_4_LENGTH_12_8_8_data);  **************************************
     ucAppCommandBuf[ 0 ]  = 0x11;
     ucAppCommandBuf[ 1 ]  = 0x12;       // 0x1219
     ucAppCommandBuf[ 2 ]  = 0x08;       // Total 8Parameters
     ucAppCommandBuf[ 3 ]  = 0x19;       // 0x1219
     ucAppCommandBuf[ 4 ]  = 0x00;       // field4 length(?4?)
     ucAppCommandBuf[ 5 ]  = 0x00;       // field 4 length, (? 8?), length = 0 Means this field did not use
     ucAppCommandBuf[ 6 ]  = 0x00;       // field 4 Is not 4FSK,manchest, whiting, PN9
     ucAppCommandBuf[ 7 ]  = 0x00;       // field 4 ?CRCSet up
     ucAppCommandBuf[ 8 ]  = 0x00;       // field5 length(?4?)
     ucAppCommandBuf[ 9 ]  = 0x00;       // field 5 length, (? 8?), length = 0 Means this field did not use
     ucAppCommandBuf[ 10 ] = 0x00;       // field 5 Is not 4FSK,manchest, whiting, PN9
     ucAppCommandBuf[ 11 ] = 0x00;       // field 5 ?CRCSet up
     vSPIWrite( 12, ucAppCommandBuf );

     // ********************************************************************************
     vSPIWrite( 0x10, RF_MODEM_MOD_TYPE_12_data );   // //  2FSK ,  module source = PH fifo, disable manchest, tx, rx Do not flip, deviation Do not flip

     //spi_write(0x05, RF_MODEM_FREQ_DEV_0_1_data); **************************************
     ucAppCommandBuf[ 0 ]  = 0x11;
     ucAppCommandBuf[ 1 ]  = 0x20;    // 0x200c
     ucAppCommandBuf[ 2 ]  = 0x01;    // Total 1Parameters
     ucAppCommandBuf[ 3 ]  = 0x0c;    // 0x200c
     //ucAppCommandBuf[4]  = 0x4f; // frequency deviation ?Bit 0--7, According to WDS
     if ( ucRF4463Freq3 < 8 ) {
        if ( ucRF4463Rate >= dr_256k ) {
           ucAppCommandBuf[ 4 ] = 0x4f;
        }
        else if ( ucRF4463Rate >= dr_19p2 ) {
             ucAppCommandBuf[ 4 ]  = 0x5e;
        }
        else {
            ucAppCommandBuf[ 4 ]  = 0xd2;
        }
     }
     else {
          if ( ucRF4463Rate >= dr_115p2 ) {
             ucAppCommandBuf[ 4 ]  = 0x69;        // 15k
          }
          else if ( ucRF4463Rate >= dr_19p2 ) {
               ucAppCommandBuf[ 4 ]  = 0x5e;      // 10k
          }
          else {
               ucAppCommandBuf[ 4 ]  = 0x18;      // 8k
          }
     }
     vSPIWrite( 5, ucAppCommandBuf );

     // ********************************************************************************
     vSPIWrite( 0x0C, RF_MODEM_TX_RAMP_DELAY_8_data );            // Without this Parameters,Not needed
     vSPIWrite( 0x0D, RF_MODEM_BCR_OSR_1_9_data );                // Without this Parameters,Not needed
     vSPIWrite( 0x0B, RF_MODEM_AFC_GEAR_7_data );                 // Without this Parameters,Not needed
     vSPIWrite( 0x05, RF_MODEM_AGC_CONTROL_1_data );              // Without this Parameters,Not needed
     vSPIWrite( 0x0D, RF_MODEM_AGC_WINDOW_SIZE_9_data );          // Without this Parameters,Not needed
     vSPIWrite( 0x0F, RF_MODEM_OOK_CNT1_11_data );                // Without this Parameters,Not needed

     // spi_write(0x05, RF_MODEM_RSSI_COMP_1_data);        **************************************************
     ucAppCommandBuf[ 0 ] = 0x11;
     ucAppCommandBuf[ 1 ] = 0x20;       // 0x204e
     ucAppCommandBuf[ 2 ] = 0x01;       // Total 1Parameters
     ucAppCommandBuf[ 3 ] = 0x4e;       // 0x204e
     
     if ( ucRF4463Rate == dr_500 ) {
        ucAppCommandBuf[ 4 ] = 0x3a;
     }
     else {
          ucAppCommandBuf[ 4 ] = 0x40;  //  rssi Reading deviation, the difference with the true value
     }
     vSPIWrite( 5, ucAppCommandBuf );

     // ********************************************************************************
     vSPIWrite( 0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data );  // Without this Parameters,Not needed
     vSPIWrite( 0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data );   // Without this Parameters,Not needed
     vSPIWrite( 0x10, RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data );   // Without this Parameters,Not needed

     // RF_PA **************************************************************************
     ucAppCommandBuf[ 0 ]  = 0x11;
     ucAppCommandBuf[ 1 ]  = 0x22;    // 0x2200
     ucAppCommandBuf[ 2 ]  = 0x04;    // Total 4Parameters
     ucAppCommandBuf[ 3 ]  = 0x00;    // 0x2200
     ucAppCommandBuf[ 4 ]  = 0x08;    //0x10;   //   PA mode  = default , ??Class E mode,?Is not Switch Current mode  ????????

     if ( ucRF4463Power > 0 || ucRF4463Power < 127 ) {
        ucAppCommandBuf[ 5 ]  = ucRF4463Power;   //  Set to maximum power
     }
     else {
          ucAppCommandBuf[ 5 ]  = 127;
     }
     
     ucAppCommandBuf[ 6 ] = 0x00; //???????? 0x00;   // CLK duty = 50%, other = Default
     
     if ( ( ucRF4463Rate <= dr_115p2 )||( ucRF4463Rate == dr_500 ) ) {
        ucAppCommandBuf[ 7 ]  = 0x3d;  // ???????? 0x5d;   // PA ramp time = default
     }
     else {
          ucAppCommandBuf[ 7 ]  = 0x5d;
     }
     vSPIWrite( 8, ucAppCommandBuf );


     // ********************************************************************************
     vSPIWrite( 0x0B , RF_SYNTH_PFDCP_CPFF_7_data );      // Without this Parameters,Not needed

     // header match ******************************************************************
     if ( ucRF4463MatchEnabled ) {
        ucAppCommandBuf[ 0 ]  = 0x11;               // SetProperty
        ucAppCommandBuf[ 1 ]  = 0x30;               // 0x30 group
        ucAppCommandBuf[ 2 ]  = 0x0c;               // Total 12 Parameters
        ucAppCommandBuf[ 3 ]  = 0x00;               // 0x00 Index
        ucAppCommandBuf[ 4 ]  = ucRF4463ByteMatch1; // match 1 Value of
        ucAppCommandBuf[ 5 ]  = ucRF4463ByteMask1;  // match 1 mask
        ucAppCommandBuf[ 6 ]  = ucRF4463MatchEnableReg; //  0x40; // enable match 1, match 1 The distance between the value of and the synchronization word, 0 = match
        ucAppCommandBuf[ 7 ]  = ucRF4463ByteMatch2; // match 2 Value of
        ucAppCommandBuf[ 8 ]  = ucRF4463ByteMask2;  // match 2 mask
        ucAppCommandBuf[ 9 ]  = 0x01;               // enable match 2, match 2 The distance between the value of and the synchronization word  , and function
        ucAppCommandBuf[ 10 ] = ucRF4463ByteMatch3; // match 3 Value of
        ucAppCommandBuf[ 11 ] = ucRF4463ByteMask3;  // match 3 mask
        ucAppCommandBuf[ 12 ] = 0x02;               // enable match 3, match 3 The distance between the value of and the synchronization word    and function
        ucAppCommandBuf[ 13 ] = ucRF4463ByteMatch4; // match 4 Value of
        ucAppCommandBuf[ 14 ] = ucRF4463ByteMask4;  // match 4 mask
        ucAppCommandBuf[ 15 ] = 0x03;               // enable match 4, match 4 The distance between the value of and the synchronization word    and function
        vSPIWrite( 16, ucAppCommandBuf );
        
        if ( ucRF4463MatchEnableReg == 0x00 ) {
           ucRF4463MatchEnabled = 0;                // deshabilita el Match
        }
        
        //ucAppCommandBuf[ 0 ]  = 0x11;    // SetProperty
//        ucAppCommandBuf[ 1 ]  = 0x30;    // 0x30 group
//        ucAppCommandBuf[ 2 ]  = 0x0c;    // Total 12 Parameters
//        ucAppCommandBuf[ 3 ]  = 0x00;    // 0x00 Index
//        ucAppCommandBuf[ 4 ]  = 's';     // match 1 Value of
//        ucAppCommandBuf[ 5 ]  = 0xFF;    // match 1 mask
//        ucAppCommandBuf[ 6 ]  = 0x40;    // enable match 1, match 1 The distance between the value of and the synchronization word, 0 = match
//        ucAppCommandBuf[ 7 ]  = 'w';     // match 2 Value of
//        ucAppCommandBuf[ 8 ]  = 0xFF;    // match 2 mask
//        ucAppCommandBuf[ 9 ]  = 0x01;    // enable match 2, match 2 The distance between the value of and the synchronization word  , and function
//        ucAppCommandBuf[ 10 ] = 'w';     // match 3 Value of
//        ucAppCommandBuf[ 11 ] = 0xFF;;   // match 3 mask
//        ucAppCommandBuf[ 12 ] = 0x02;;   // enable match 3, match 3 The distance between the value of and the synchronization word    and function
//        ucAppCommandBuf[ 13 ] = 'x';     // match 4 Value of
//        ucAppCommandBuf[ 14 ] = 0xFF;    // match 4 mask
//        ucAppCommandBuf[ 15 ] = 0x03;    // enable match 4, match 4 The distance between the value of and the synchronization word    and function
//        spi_write( 16, ucAppCommandBuf );
     }


     vRF4463InitFreq();     // FUNCION DE FRECUENCIA ( REVISAR PARAMETROS )
}


// Genera el checksum software al final
char ucRF4463ChecksumGenerator ( unsigned char *ucBuffer ) { //, unsigned char payload_length ) {             //unsigned char ucBufferLenght
     unsigned short ucCounter = 0;
     unsigned char ucChecksum = 0;
     
     for ( ucCounter = 0; ucCounter < payload_length ; ucCounter++ ) {
         ucChecksum += ucBuffer[ ucCounter ];
     }
     
     return ucChecksum;
}



void vRF4463GPIO_SET( unsigned char ucData ) {
     unsigned char ucAppCommandBuf[ 7 ];
     
     ucAppCommandBuf[0] = 0x13;     // gpio Set up

     switch ( ucData ) {
            case tx_normal:
            case rx_normal: ucAppCommandBuf[ 1 ] = 3;                 // GPIO0=1
                            ucAppCommandBuf[ 2 ] = 2;                // GPIO1=0
                            break;

            case tx_test:   ucAppCommandBuf[ 1 ] = 3;                 // GPIO0=1
                            ucAppCommandBuf[ 2 ] = 3;                // GPIO1=1
                            break;

            case rx_test:   ucAppCommandBuf[ 1 ] = 2;                 // GPIO0=0
                            ucAppCommandBuf[ 2 ] = 20;                // GPIO1=RX DATA
                            break;

            case rf_off:    ucAppCommandBuf[ 1 ] = 2;                 // GPIO0=0
                            ucAppCommandBuf[ 2 ] = 2;                // GPIO1=0
                            break;
     }

     ucAppCommandBuf[ 3 ]  = 0x21;     //0x20;   //  gpio2, h = tx mode
     ucAppCommandBuf[ 4 ]  = 0x20;     // 0x14;  //   gpio3
     ucAppCommandBuf[ 5 ]  = 0x27;     // nIRQ
     ucAppCommandBuf[ 6 ]  = 0x0b;     // sdo
     vSPIWrite( 7, ucAppCommandBuf );
}




void vRF4463FifoReset( void ) {
     unsigned char p[2];

     p[ 0 ] = FIFO_INFO;
     p[ 1 ] = 0x03;   // reset tx ,rx fifo
     vSPIWrite( 2, p );
}


void vRF4463GetIntStatus( void ) {
     unsigned char p[ 4 ];

     p[ 0 ] = GET_INT_STATUS;
     //p[ 1 ] = 0;               // clr  PH pending
     //p[ 2 ] = 0;               // clr modem_pending
     //p[ 3 ] = 0;               // clr chip pending
     vSPIWrite( 1, p );
     vSPIRead( 9, GET_INT_STATUS );
}


void vRF4463ClearInterrupts( void ) {
     unsigned char p[ 4 ];

     p[ 0 ] = GET_INT_STATUS;
     p[ 1 ] = 0;               // clr  PH pending
     p[ 2 ] = 0;               // clr modem_pending
     p[ 3 ] = 0;               // clr chip pending
     vSPIWrite( 4, p );
     vSPIRead( 9, GET_INT_STATUS );
}


// fucnion DEMO para solicitar el PART INFO
void vRF4463PartInfo( void ) {  // Solicitud totalmente operativa
     unsigned char p[ 9 ];

     p[ 0 ] = PART_INFO;
     vSPIWrite( 1, p );
     vSPIRead( 9, PART_INFO );
}


void vRF4463EnableRxInterrupt( void ) {
     unsigned char p[ 7 ];

     p[ 0 ] = 0x11;
     p[ 1 ] = 0x01;            // 0x0100
     p[ 2 ] = 0x03;            // 3Parameters
     p[ 3 ] = 0x00;            // 0100
     p[ 4 ] = 0x03;            // ph, modem int       0x03;
     p[ 5 ] = 0x18;            // 0x10;   // Pack received int
     p[ 6 ] = 0x00;            //preamble int, sync int setting
     vSPIWrite( 0x07, p );     // enable  packet receive interrupt
}




void vRF4463EnableTxInterrupt( void ) {
     unsigned char p[ 6 ];

     p[ 0 ] = 0x11;
     p[ 1 ] = 0x01;            // 0x0100
     p[ 2 ] = 0x02;            // 2Parameters
     p[ 3 ] = 0x00;            // 0x0100
     p[ 4 ] = 0x01;            // Ph  int
     p[ 5 ] = 0x20;            //  enable  packet sent interrupt
     vSPIWrite( 0x06, p );     // enable  packet receive interrupt
}




void vRF4463RfStandby( void ) {
     unsigned char p[ 2 ];

     p[ 0 ] = CHANGE_STATE ;   // CHANGE_STATE Command
     p[ 1 ] = 0x01 ;           // sleep mode
     vSPIWrite( 2, p );
}




void vRF4463TxStart( void ) {
     unsigned char p[ 5 ];

     p[ 0 ] = START_TX ;              // start Command
     p[ 1 ] = ucRF4463FreqChannel;    // channel 1 default
     p[ 2 ] = 0x30;                   // Back after launch Readymode, Do not retransmit, launch immediately
     p[ 3 ] = 0;
     p[ 4 ] = 0;                      // payload_length; // Total to transmit 10 bytes
     vSPIWrite( 5, p );
}




void vRF4463RxStart( void ) {
     unsigned char p[ 8 ];

     p[ 0 ] = START_RX ;              // start Command
     p[ 1 ] = ucRF4463FreqChannel;    // channel 0
     p[ 2 ] = 0x00;                   // Enter receiving mode immediately
     p[ 3 ] = 0;
     p[ 4 ] = 0;                      // payload_length; // Total to receive 10 bytes
     p[ 5 ] = 1;                      // unchanged after preamble timeout
     //p[ 6 ] = 0x03;                 // ready after valid packet received
     //p[ 7 ] = 0x0;                  // unchanged after invalid packet received
     p[ 6 ] = 0x01;
     p[ 7 ] = 0x08;
     vSPIWrite( 8, p );
}




void vRF4463RxStartTest( void ) {
     unsigned char p[ 8 ];

     LED_GREEN = 1;

     p[ 0 ] = START_RX;        // start Command
     p[ 1 ] = ucRF4463FreqChannel;    // channel 0
     p[ 2 ] = 0x00;            // Enter receiving mode immediately
     p[ 3 ] = 0;
     //p[ 4 ] = payload_length; // Total to receive 10 bytes
     p[ 4 ] = 0;
     p[ 5 ] = 0;               // unchanged after preamble timeout
     //p[ 6 ] = 0x0;           // unchanged mode if valid packet received
     //p[ 7 ] = 0x0;           // unchanged mode if unvalid packet received
     p[ 6 ] = 0x08;
     p[ 7 ] = 0x08;
     vSPIWrite( 8, p );
}




void vRF4463RxInit( void ) {
     Flag.is_tx = 0;
     vRF4463FifoReset();           // fifo_reset();  // Buffer empty
     vRF4463EnableRxInterrupt();   // enable_rx_interrupt();
     vRF4463ClearInterrupts();      // clr_interrupt();  // Clear interrupt factor

     if ( ucRF4463Mode == rx_test_mode ) {
        vRF4463RxStartTest();      // rx_start_test();
     }
     else {
          vRF4463RxStart();        // rx_start();    // Enter receiving mode, after receiving data, return to Readymode
     }
}




void vRF4463TxData( void ) {
     unsigned char i;

     ucRF4463IRQ = 0;

     Flag.is_tx = 1;
     LED_RED ^= 1;
     Delay_ms( 30 );
     LED_RED ^= 1;
     vRF4463FifoReset();            // fifo_reset();  // Buffer empty
     vSPIWriteFifo();               // Fill the buffer with data
     vRF4463EnableTxInterrupt();    // enable_tx_interrupt();
     vRF4463ClearInterrupts();       // clr_interrupt();  // Clear interrupt factor
     vRF4463TxStart();              // tx_start();    // Enter launch mode, start launch
     //rf_timeout = 0;
     
     Flag.rf_reach_timeout = 0;

     if ( ucRF4463IRQ ) {
        UART1_Write_Text( "[ UART1 ] TX INT\r\n" );
     }

     // Waiting for interrupt
     while ( nIRQ ) {     //nIRQ
           //wdtr = 0;              // WatchDog
           //wdtr = 0xff;
           if ( Flag.rf_reach_timeout ) {
              vRF4463SDNReset();
              vRF4463Init();        //SI4463_init();  // RF Module initialization
              break;                // Forced out
           }
     }

     tx_cnt++;
     //dis_tx();               // display "TX"
     vRF4463RxInit();          // rx_init();                //rf After the transmission is completed, enter the receiving mode
}



// Funcion para transmitir de manera continua
void vRF4463TxCont( void ) {
     unsigned char i;

     LED_RED = 1;
     vRF4463FifoReset();                     //  fifo_reset();  // Buffer empty
     vSPIWriteFifo();                        // Fill the buffer with data
     vRF4463EnableTxInterrupt();             //  enable_tx_interrupt();
     vRF4463ClearInterrupts();               //  clr_interrupt();  // Clear interrupt factor
     vRF4463TxStart();                       //  tx_start();    // Enter launch mode, start launch
     //rf_timeout = 0;
     Flag.rf_reach_timeout = 0;

     ucRF4463IRQ = 0;

     // Waiting for interrupt
     while( nIRQ ) {          //nIRQ ) {
//                //wdtr = 0;                  // WatchDog
//                //wdtr = 0xFF;
//     /*        if ( Flag.rf_reach_timeout) {
//                  sdn_reset();
//                  SI4463_init();  // RF Module initialization
//                  break;                // Forced out
//               }*/
     }
}


//-----------------------------------------------------------------------------------------------------------
// Funcion para establecer la frecuencia de la banda
void vRF4463InitFreq ( void ) {
     unsigned char ucOUTDIV, ucDIV, ucVCO, ucINTE, ucBAND;
     unsigned char ucFD_2, ucFD_1, ucFD_0, ucFRAC_2, ucFRAC_1, ucFRAC_0;
     unsigned long ulFRAC, ulData, ulFrequency;
     unsigned char ucAppCommandBuf[ 20 ];

     ulFrequency = ( ucRF4463Freq3 * 100 ) + ( ucRF4463Freq2 * 10 ) + ucRF4463Freq1;
     //ulFrequency = ( ulFrequency * 10000) + 5000;          //915.5 MHz??
     ulFrequency = ( ulFrequency * 10000 );
     
     // 760~1050
     if ( ulFrequency >= 7600000 ) {
        ucOUTDIV = 4;
        ucBAND = 0;
        ucVCO = 0xFF;
     }
     
     // 546~759.9
     else if ( ulFrequency >= 5460000 ) {
          ucOUTDIV = 6;
          ucBAND   = 1;
          ucVCO    = 0xFE;
     }
        
     // 385~545.9
     else if ( ulFrequency >= 3850000 ) {
          ucOUTDIV = 8;
          ucBAND   = 2;
          ucVCO    = 0xFE;
     }
     
     // 273~384.9
     else if ( ulFrequency >= 2730000 ) {
          ucOUTDIV = 12;
          ucBAND   = 3;
          ucVCO    = 0xFD;
     }

     // 194~272.9
     else if ( ulFrequency >= 1940000 ) {
          ucOUTDIV = 16;
          ucBAND   = 4;
          ucVCO    = 0xFC;
     }
     
     // 142~193.9
     else {
          ucOUTDIV = 24;
          ucBAND   = 5;
          ucVCO    = 0xFA;
     }

     ucDIV = ucOUTDIV / 2;

     ulData = ( ulFrequency * ucDIV ) / 3;          // ucDIV = 88.5 = 88   //// UCdiv = 2
     ucINTE = ( ulData / 100000) - 1;               // ulData = 6 000 000  //// ULdATA = 9 000 000
     ulFRAC = ( ulData - ( ucINTE + 1 ) * 100000 ) * 16384 / 3125;         // ulFRAC = 15 728 640
     ulFRAC = ulFRAC + 0x80000;

     ucFRAC_0 = ulFRAC;
     ulFRAC >>= 8;
     ucFRAC_1 = ulFRAC;
     ulFRAC >>= 8;
     ucFRAC_2 = ulFRAC;

     // send freq cmd

     ucAppCommandBuf[ 0 ] = 0x11;           // SET property    MODEM_CLKGEN_BAND
     ucAppCommandBuf[ 1 ] = 0x20;           // Group  // 0x2051
     ucAppCommandBuf[ 2 ] = 0x01;           // Num Arguments // Total 1 Parameters
     ucAppCommandBuf[ 3 ] = 0x51;           // Number  // 0x2051
     ucAppCommandBuf[ 4 ] = 0x08 | ucBAND;  // Argumento  //  high performance mode , clk outpu = osc /4
     vSPIWrite( 5, ucAppCommandBuf );

     ucAppCommandBuf[ 0 ]  = 0x11;
     ucAppCommandBuf[ 1 ]  = 0x40;    // 0x4000         FREQ_CONTROL_INTE
     ucAppCommandBuf[ 2 ]  = 0x08;    // Total 8 Parameters
     ucAppCommandBuf[ 3 ]  = 0x00;   // 0x4000
     ucAppCommandBuf[ 4 ]  = ucINTE;   //  default value
     ucAppCommandBuf[ 5 ]  = ucFRAC_2;   //  defaul value
     ucAppCommandBuf[ 6 ]  = ucFRAC_1;   //  default value
     ucAppCommandBuf[ 7 ]  = ucFRAC_0;   // frac ,from WDS
     
     // Ancho de banda
     if ( ulRF4463Step == 250 ) {
        ucAppCommandBuf[ 8 ]  = step_250K_step1;   // channel step1  from wds  // al parecer aqu? esta el ancho del canal
        ucAppCommandBuf[ 9 ]  = step_250K_step0;   // channel step0  from wds
     }
     else if ( ulRF4463Step == 500 ) {
          ucAppCommandBuf[ 8 ]  = step_500K_step1;   // channel step1  from wds  // al parecer aqu? esta el ancho del canal
          ucAppCommandBuf[ 9 ]  = step_500K_step0;   // channel step0  from wds
     }

     ucAppCommandBuf[ 10 ] = 0x20;  //  from wds Without this Values
     ucAppCommandBuf[ 11 ] = ucVCO;    // from wds Without this Values

     //ucAppCommandBuf[ 0 ]  = 0x11;
//     ucAppCommandBuf[ 1 ]  = 0x40;    // 0x4000         FREQ_CONTROL_INTE
//     ucAppCommandBuf[ 2 ]  = 0x08;    // Total 8 Parameters
//     ucAppCommandBuf[ 3 ]  = 0x00;   // 0x4000
//     ucAppCommandBuf[ 4 ]  = 0x3C;   //ucINTE;   //  default value
//     ucAppCommandBuf[ 5 ]  = 0x08;   //ucFRAC_2;   //  defaul value
//     ucAppCommandBuf[ 6 ]  = 0x00;   //ucFRAC_1;   //  default value
//     ucAppCommandBuf[ 7 ]  = 0x00;   //ucFRAC_0;   // frac ,from WDS
//     ucAppCommandBuf[ 8 ]  = 0x22;  //step_500K_step1;   // channel step1  from wds  // al parecer aqu� esta el ancho del canal
//     ucAppCommandBuf[ 9 ]  = 0x22; //step_500K_step0;   // channel step0  from wds
//     ucAppCommandBuf[ 10 ] = 0x20;  //  from wds Without this Values
//     ucAppCommandBuf[ 11 ] = 0xFF; //ucVCO;    // from wds Without this Values
     vSPIWrite( 12, ucAppCommandBuf );
}





//===========================================================================================================
// Funcion HAL: Driver de envio de SPI
//volatile unsigned char ucSPI2ByteReceived = 0;              //
//
//void Int_SPI2() iv IVT_INT_SPI2 ics ICS_AUTO {
//
//     if ( SPI2_SRbits.RXNE ) {
//        ucSPI2ByteReceived = ( unsigned char )SPI2_DR;      // lee el Byte recibido
//        // UART1_Write( ucSPI1ByteReceived );               // DEPURACION
//        // ucSPI1LastStatus = SPI1_SRbits.RXNE;
//     }
//}

// Funcionpara transferir datos v�a SPI por SOFTWARE
unsigned char ucRF4463SPIByte( unsigned char ucData ) {

        #ifdef STM32F107RC
               ucSPI2ByteReceived = 0;

               SPI2_DR = ucData;

               while ( !SPI2_SRbits.TXE );                // espera a que el buffer este vacio
        
               while ( SPI2_SRbits.BSY );                // espera a que el buffer este vacio

               return ( ucSPI2ByteReceived );
        #endif
        
        #ifdef STM32F107VC
               ucSPI3ByteReceived = 0;

               SPI3_DR = ucData;

               while ( !SPI3_SRbits.TXE );                // espera a que el buffer este vacio

               while ( SPI3_SRbits.BSY );                // espera a que el buffer este vacio

               return ( ucSPI3ByteReceived );
        #endif
        
        #ifdef STM32F407VG
               ucSPI3ByteReceived = 0;

               SPI3_DR = ucData;

               while ( !SPI3_SRbits.TXE );                // espera a que el buffer este vacio

               while ( SPI3_SRbits.BSY );                // espera a que el buffer este vacio

               return ( ucSPI3ByteReceived );
        #endif
        
        #ifdef STM32G071KB
               ucSPI1ByteReceived = 0;

               vRF4463SpiBufferTX ( &ucData, 1 );        // lo envia por DMA

               while ( SPI1_SRbits.RXNE );

               return ( ucSPI1ByteReceived );
        #endif
}




void vSPIWrite( unsigned char ucTxLength, unsigned char *ucBuffer ) {
     unsigned char i,j;

     i = 0;
     while ( i != 0xFF ) {
           i = ucRF4463CheckCTS();
     }
     
     nSEL = 0;                              // habilita escritura

     for ( i = 0; i < ucTxLength; i++ ) {
         j = *( ucBuffer + i );
         ucRF4463SPIByte( j );
     }

     nSEL = 1;                              // desabilita escritura
}




unsigned char ucRF4463CheckCTS( void ) {    // This Command follows the Command and reads the response
     unsigned char i;

     nSEL = 1;
     nSEL = 0;
     ucRF4463SPIByte( 0x44 );
     i = ucRF4463SPIByte( 0 );
     nSEL = 1;
     return ( i );
}




void vSPIRead( unsigned char ucDataLength, unsigned char ucAPICommand ) {
     unsigned char i;
     unsigned char p[ 1 ];
     
     p[ 0 ] = ucAPICommand;
     i = 0;
     while ( i != 0xFF ) {
           i = ucRF4463CheckCTS();                // Check if you can send Command
     }
     
     vSPIWrite( 1, p );    // Send Command

     i = 0;
     while ( i != 0xFF ) {
           i = ucRF4463CheckCTS();        //Check whether the data can be read
     }
        
     nSEL = 1;
     nSEL = 0;
     ucRF4463SPIByte( 0x44 );
     for ( i = 0; i < ucDataLength; i++ ) {        // Read data
         spi_read_buf[ i ] = ucRF4463SPIByte( 0x00 );             // 0x00
     }
     nSEL = 1;
}




void spi_fast_read( unsigned char ucAPICommand ) {
     unsigned char i, p[1];

     p[ 0 ] = ucAPICommand;
     i = 0;
     while ( i != 0xFF ) {
           i = ucRF4463CheckCTS();                // Check if you can send Command
     }
     
     nSEL = 1;
     nSEL = 0;
     ucRF4463SPIByte( ucAPICommand );    // Send Command
     for ( i = 0; i < 4; i++ ) {
         spi_read_buf[ i ] = ucRF4463SPIByte( 0xFF );   // Read out all the 4 registers Value of
     }
     nSEL = 1;
}




void vSPIWriteFifo( void ) {
     unsigned char i;

     i = 0;
     while ( i != 0xFF ) {
           i = ucRF4463CheckCTS();                // Check if you can send Command
     }
        
     nSEL = 1;
     nSEL = 0;
     ucRF4463SPIByte( WRITE_TX_FIFO );

     if ( ucRF4463Mode == tx_test_mode) {
        for ( i = 0; i < payload_length; i++ ) {
            ucRF4463SPIByte( tx_test_aa_data[ i ] );   // Send 10 test data
        }
     }
     else {
          for ( i = 0; i < payload_length; i++ ) {
              ucRF4463SPIByte( ucRF4463TXdata[ i ] );
          }
     }
     nSEL = 1;
}




void spi_read_fifo( void ) {
     unsigned char i;

     i = 0;
     while ( i != 0xFF ) {
           i = ucRF4463CheckCTS();                   // Check if you can send Command
     }
     
     nSEL = 1;
     nSEL = 0;
     ucRF4463SPIByte( READ_RX_FIFO );
     for ( i = 0; i < payload_length; i++ ) {
         rx_buf[ i ] = ucRF4463SPIByte( 0xFF );      // Receive 10 test data
     }
     nSEL = 1;
}




void vRF4463SDNReset( void ) {
     unsigned char i;

     SDN = 1;
     Delay_ms( 6 );        // RF Module reset  DELAY
     SDN = 0;
     Delay_ms( 10 );       // Delay 10ms for RF module to enter working state

     nSEL = 1;
     nSEL = 0;
     for ( i = 0; i < 7; i++ ) {
         ucRF4463SPIByte( RF_POWER_UP_data[ i ] );   // send power up Command
     }
     nSEL = 1;

     Delay_ms( 20 );       // Delay 20ms RF module enters working state, but CTS still needs to be judged later, this delay can be removed
}
// song end