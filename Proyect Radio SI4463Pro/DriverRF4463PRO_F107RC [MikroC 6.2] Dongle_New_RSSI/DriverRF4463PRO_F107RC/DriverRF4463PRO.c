// DRIVER PARA RADIO RF4463 PRO DE NICERF

// Escrito sin acentos para una mejor lectura

// DEFINICONES
#define RF_MAX_BUFFER_LENGTH      66

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




void vRF4463ISR() iv IVT_INT_EXTI15_10 ics ICS_AUTO{
    if( EXTI_PR.B12 ){
        EXTI_PR.B12 |= 1;
        LED_RED = 1;
        ucRF4463IRQ = 1;
        vRF4463ClearInterrupts();
    }
}




// Funcion de inicializacion.
// Seguramente requiere argumentos para configuracion
void vRF4463Init ( void ) {  // MODE,
     unsigned char app_command_buf[ 20 ], i;
     unsigned char cleanBuffer[ 20 ]={0x00};

     for ( i = 4; i < 16; i++ ) {
         RF_MODEM_MOD_TYPE_12_data[ i ] = RF_MODEM_MOD_TYPE_12[ rate ][ i - 4 ];
     }

     //
     if ( freq3 < 8 ) {
        for ( i = 4; i < 12; i++ ) {
            RF_MODEM_TX_RAMP_DELAY_8_data[ i ] = RF_MODEM_TX_RAMP_DELAY_8_433[ rate ][ i - 4 ];
        }
        for ( i = 4; i < 11; i++ ) {
            RF_MODEM_AFC_GEAR_7_data[ i ] = RF_MODEM_AFC_GEAR_7_433[ rate ][ i - 4 ];
        }
        for ( i = 4; i < 15; i++ ) {
            RF_MODEM_OOK_CNT1_11_data[ i ] = RF_MODEM_OOK_CNT1_11_433[ rate ][ i - 4 ];
        }
        for ( i = 4; i < 16; i++ ) {
            RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433[ rate ][ i - 4 ];
        }
        for ( i = 4; i < 16; i++ ) {
            RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433[ rate ][ i - 4 ];
        }
        for ( i = 4; i < 16; i++ ) {
            RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433[ rate ][ i - 4 ];
        }
        for ( i = 4; i < 13; i++ ) {
            RF_MODEM_AGC_WINDOW_SIZE_9_data[ i ] = RF_MODEM_AGC_WINDOW_SIZE_9_433[ rate ][ i - 4 ];
        }
        for ( i = 4; i < 13; i++ ) {
            RF_MODEM_BCR_OSR_1_9_data[ i ] = RF_MODEM_BCR_OSR_1_9_433[ rate ][ i - 4 ];
        }
     }
     else {
          for ( i = 4; i < 12; i++ ) {
              RF_MODEM_TX_RAMP_DELAY_8_data[ i ] = RF_MODEM_TX_RAMP_DELAY_8_850[ rate ][ i - 4 ];
          }
          for ( i = 4; i < 11; i++ ) {
              RF_MODEM_AFC_GEAR_7_data[ i ] = RF_MODEM_AFC_GEAR_7_850[ rate ][ i - 4 ];
          }
          for ( i = 4; i < 15; i++ ) {
              RF_MODEM_OOK_CNT1_11_data[ i ] = RF_MODEM_OOK_CNT1_11_850[ rate ][ i - 4 ];
          }
          for ( i = 4; i < 16; i++ ) {
              RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850[ rate ][ i - 4 ];
          }
          for ( i = 4; i < 16; i++ ) {
              RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850[ rate ][ i - 4 ];
          }
          for ( i = 4; i < 16; i++ ) {
              RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850[ rate ][ i - 4 ];
          }
          for ( i = 4; i < 13; i++ ) {
              RF_MODEM_AGC_WINDOW_SIZE_9_data[ i ] = RF_MODEM_AGC_WINDOW_SIZE_9_850[ rate ][ i - 4 ];
          }
          for ( i = 4; i < 13; i++ ) {
              RF_MODEM_BCR_OSR_1_9_data[ i ] = RF_MODEM_BCR_OSR_1_9_850[ rate ][ i - 4 ];
          }
     }
     for ( i = 4; i < 11; i++ ) {
         RF_SYNTH_PFDCP_CPFF_7_data[ i ] = RF_SYNTH_PFDCP_CPFF_7[ rate ][ i - 4 ];
     }
     
     
     // Configura GPIO
     vRF4463GPIO_SET( mode );                              // PARAMETRO CONFIGURABLE
     strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
//     vBufferSetToZero( app_command_buf, 20 );
     // spi_write(0x05, RF_GLOBAL_XO_TUNE_1_data);   //  Frequency adjustment
     app_command_buf[ 0 ] = 0x11;
     app_command_buf[ 1 ] = 0x00;    // 0x0000
     app_command_buf[ 2 ] = 0x01;    // Total 1 Parameters
     app_command_buf[ 3 ] = 0x00;    // 0x0000
     app_command_buf[ 4 ] = 98;      // freq  adjustment    ( rango desde 0 - 127 Low cap - High Cap )
     spi_write( 5, app_command_buf );
     strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
     // spi_write(0x05, RF_GLOBAL_CONFIG_1_data);  //  *******************************************************
     app_command_buf[ 0 ] = 0x11;
     app_command_buf[ 1 ] = 0x00;    // 0x0003
     app_command_buf[ 2 ] = 0x01;    // Total 1 Parameters
     app_command_buf[ 3 ] = 0x03;   // 0x0003
     app_command_buf[ 4 ] = 0x40;  // tx = rx = 64 byte, ordinary PH,high performance mode  ?????????????????????
     spi_write( 5, app_command_buf );

     strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
     // *****************************************************************************
     spi_write( 0x08, RF_FRR_CTL_A_MODE_4_data );    // disable all fast response register
     strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
     // spi_write(0x0D, RF_PREAMBLE_TX_LENGTH_9_data); Preamble setting*********************************************
     app_command_buf[ 0 ] = 0x11;
     app_command_buf[ 1 ] = 0x10;    // 0x1000
     app_command_buf[ 2 ] = 0x09;    // Total 9 Parameters
     app_command_buf[ 3 ] = 0x00;   // 0x1000

     if ( mode == tx_test_mode ) {
        app_command_buf[ 4 ] = 0xff;     //  Need to send 255 bytes of Preamble
     }
     else {
          app_command_buf[ 4 ] = 0x08;   //  Need to send 8 bytes of Preamble
     }

     //app_command_buf[4]  = 0x08;       //  Need to send 8 bytes of Preamble
     app_command_buf[ 5 ]   = 0x14;       //To detect 20 bit sync word,
     app_command_buf[ 6 ]   = 0x00;       // Non-standard preamble settings, useless
     app_command_buf[ 7 ]   = 0x0f;       // Time of the preamble Timeout   ????????????????????????????????????????????????????????????
     app_command_buf[ 8 ]   = 0x31;       // The length of the preamble is   byte Calculation , 1st = 1 NO manchest  Encoding, using standard 1010.??
     app_command_buf[ 9 ]   = 0x0;        //  Non-standard Preamble Patten 4th byte
     app_command_buf[ 10 ]  = 0x00;       //  Non-standard Preamble Patten 3rd byte
     app_command_buf[ 11 ]  = 0x00;       //  Non-standard Preamble Patten 2nd byte
     app_command_buf[ 12 ]  = 0x00;       //  Non-standard Preamble Patten 1st byte
     spi_write(13, app_command_buf);
     strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
     
     //  RF_SYNC_CONFIG_5_data,  Sync word settings *********************************************
     app_command_buf[ 0 ] = 0x11;
     app_command_buf[ 1 ] = 0x11;         // command = 0x1100
     app_command_buf[ 2 ] = 0x05;         // Total 5 Parameters
     app_command_buf[ 3 ] = 0x00;         // command = 0x1100
     app_command_buf[ 4 ] = 0x01;         // The synchronization word is defined and sent in the length field, and the synchronization word cannot be wrong,Not 4FSK, not manchest encoding, only 2 bytes

     if ( mode == tx_test_mode ) {
        app_command_buf[ 5 ] = 0x55;      //Sync word 3
        app_command_buf[ 6 ] = 0x55;      // Sync word 2
     }
     else {
          app_command_buf[ 5 ] = ( Network >> 8 );    //Sync word 3
          app_command_buf[ 6 ] = ( Network );         // Sync word 2
     }

     app_command_buf[ 7 ] =  0x00;        // Sync word 1
     app_command_buf[ 8 ] = 0x00;        // Sync word 0
     spi_write( 9, app_command_buf );
     strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
     
     //  packet crc Set up *******************************************************************
     app_command_buf[ 0 ] = 0x11;
     app_command_buf[ 1 ] = 0x12;        // command = 0x1200
     app_command_buf[ 2 ] = 0x01;        // Total 1 Parameters
     app_command_buf[ 3 ] = 0x00;        // command = 0x1200
     app_command_buf[ 4 ] = 0x81;        // 1?cRC ??,CRC = itu-c, enable crc
     spi_write( 5, app_command_buf );
     strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
     
     // packet   gernale configuration
     app_command_buf[ 0 ] = 0x11;
     app_command_buf[ 1 ] = 0x12;        // command = 0x1206
     app_command_buf[ 2 ] = 0x01;        // Total 1Parameters
     app_command_buf[ 3 ] = 0x06;        // command = 0x1206
     app_command_buf[ 4 ] = 0x02;        //  tx = rx = 120d--1220 (tx packet,ph enable, not 4fsk, After receiving a packet of data,RX off,CRC Do not flip ,CRC MSB, data MSB
     spi_write( 5, app_command_buf );
     strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
     
     // spi_write(0x07, RF_PKT_LEN_3_data);   //  Fixed length, one byte in length, length information is not in Payload
     app_command_buf[ 0 ] = 0x11;
     app_command_buf[ 1 ] = 0x12;        // command = 0x1208
     app_command_buf[ 2 ] = 0x03;        // Total 3 Parameters
     app_command_buf[ 3 ] = 0x08;        // command = 0x1208
     app_command_buf[ 4 ] = 0x00;        // Length Field = LSB,  length Only 1 byte,length Not put In FiFo, fixed packet length mode
     app_command_buf[ 5 ] = 0x00;        // Used for variable packet length mode, which defines which Field contains length Filed
     app_command_buf[ 6 ] = 0x00;        // Used for variable packet length mode, adjust the length of variable packet length
     spi_write( 7, app_command_buf );
     strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
     
     // length Field 1 -- 4 setting
     app_command_buf[ 0 ]  = 0x11;
     app_command_buf[ 1 ]  = 0x12;       // 0x120d
     app_command_buf[ 2 ]  = 0x0c;       // Total 12 Parameters
     app_command_buf[ 3 ]  = 0x0d;       // 0x120d
     app_command_buf[ 4 ]  = 0x00;       //  Field 1 length (?4?)
     app_command_buf[ 5 ]  = payload_length;   //  field 1 length, (? 8?), ?Total14???
     app_command_buf[ 6 ]  = 0x04;       // field 1 Is not 4FSK,manchest, whiting, PN9,
     app_command_buf[ 7 ]  = 0xaa;       // field 1 crc enble, check enbale, There are also launchingCRC,cRC?Seed ?CRC_seed?????
     app_command_buf[ 8 ]  = 0x00;       //  field 2 length(?4?)
     app_command_buf[ 9 ]  = 0x00;           //  field 2 length, (? 8?), length = 0 Means thisfield did not use
     app_command_buf[ 10 ] = 0x00;       // field 2 Is not 4FSK,manchest, whiting, PN9
     app_command_buf[ 11 ] = 0x00;       //  field 2 ?CRCSet up
     app_command_buf[ 12 ] = 0x00;       //  field 3 length, (? 8?), length = 0 Means thisfield did not use
     app_command_buf[ 13 ] = 0x00;           //  field 3 length, (? 8?), length = 0 Means thisfield did not use
     app_command_buf[ 14 ] = 0x00;       //  field 3 Is not 4FSK,manchest, whiting, PN9
     app_command_buf[ 15 ] = 0x00;       //  field 3 ?CRCSet up
     spi_write( 16, app_command_buf );
     strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
     
     // spi_write(0x0C, RF_PKT_FIELD_4_LENGTH_12_8_8_data);  **************************************
     app_command_buf[ 0 ]  = 0x11;
     app_command_buf[ 1 ]  = 0x12;       // 0x1219
     app_command_buf[ 2 ]  = 0x08;       // Total 8Parameters
     app_command_buf[ 3 ]  = 0x19;       // 0x1219
     app_command_buf[ 4 ]  = 0x00;       // field4 length(?4?)
     app_command_buf[ 5 ]  = 0x00;       // field 4 length, (? 8?), length = 0 Means this field did not use
     app_command_buf[ 6 ]  = 0x00;       // field 4 Is not 4FSK,manchest, whiting, PN9
     app_command_buf[ 7 ]  = 0x00;       // field 4 ?CRCSet up
     app_command_buf[ 8 ]  = 0x00;       // field5 length(?4?)
     app_command_buf[ 9 ]  = 0x00;       // field 5 length, (? 8?), length = 0 Means this field did not use
     app_command_buf[ 10 ] = 0x00;       // field 5 Is not 4FSK,manchest, whiting, PN9
     app_command_buf[ 11 ] = 0x00;       // field 5 ?CRCSet up
     spi_write( 12, app_command_buf );
     strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
     
     // ********************************************************************************
     spi_write( 0x10, RF_MODEM_MOD_TYPE_12_data );   // //  2FSK ,  module source = PH fifo, disable manchest, tx, rx Do not flip, deviation Do not flip
     strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
     
     //spi_write(0x05, RF_MODEM_FREQ_DEV_0_1_data); **************************************
     app_command_buf[0] = 0x11;
     app_command_buf[1]  = 0x20;    // 0x200c
     app_command_buf[2]  = 0x01;    // Total 1Parameters
     app_command_buf[3]  = 0x0c;   // 0x200c
     //app_command_buf[4]  = 0x4f; // frequency deviation ?Bit 0--7, According to WDS
     if ( freq3 < 8 ) {
        if ( rate >= dr_256k ) {
           app_command_buf[ 4 ] = 0x4f;
        }
        else if ( rate >= dr_19p2 ) {
             app_command_buf[ 4 ]  = 0x5e;
        }
        else {
            app_command_buf[ 4 ]  = 0xd2;
        }
     }
     else {
          if ( rate >= dr_115p2 ) {
             app_command_buf[ 4 ]  = 0x69;        // 15k
          }
          else if ( rate >= dr_19p2 ) {
               app_command_buf[ 4 ]  = 0x5e;        // 10k
          }
          else {
               app_command_buf[ 4 ]  = 0x18; // 8k
          }
     }
     spi_write( 5, app_command_buf );
     strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
     
     // ********************************************************************************
     spi_write( 0x0C, RF_MODEM_TX_RAMP_DELAY_8_data );            // Without this Parameters,Not needed
     spi_write( 0x0D, RF_MODEM_BCR_OSR_1_9_data );                // Without this Parameters,Not needed
     spi_write( 0x0B, RF_MODEM_AFC_GEAR_7_data );                // Without this Parameters,Not needed
     spi_write( 0x05, RF_MODEM_AGC_CONTROL_1_data );                // Without this Parameters,Not needed
     spi_write( 0x0D, RF_MODEM_AGC_WINDOW_SIZE_9_data );        // Without this Parameters,Not needed
     spi_write( 0x0F, RF_MODEM_OOK_CNT1_11_data );                // Without this Parameters,Not needed

     // RF4463_PROPERTY_MODEM_RSSI_CONTROL
     app_command_buf[ 0 ] = 0x11;    // Set Properties
     app_command_buf[ 1 ] = 0x20;    // Group
     app_command_buf[ 2 ] = 0x01;    // Total 1, Parameters
     app_command_buf[ 3 ] = 0x4C;    // Register 0x4C
     app_command_buf[ 4 ] = 0x01;    // Data
     spi_write( 5, app_command_buf );

     strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer

     // spi_write(0x05, RF_MODEM_RSSI_COMP_1_data);        **************************************************
     /*
     app_command_buf[ 0 ] = 0x11;
     app_command_buf[ 1 ] = 0x20;    // 0x204e
     app_command_buf[ 2 ] = 0x01;    // Total 1Parameters
     app_command_buf[ 3 ] = 0x4e;   // 0x204e
    
     if ( rate == dr_500 ) {
        app_command_buf[ 4 ] = 0x3a;
     }
     else {
          app_command_buf[ 4 ] = 0x40;  //  rssi Reading deviation, the difference with the true value
     }
     spi_write( 5, app_command_buf );
     
     strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
     */
     // ********************************************************************************
     spi_write( 0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data );  // Without this Parameters,Not needed
     spi_write( 0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data );   // Without this Parameters,Not needed
     spi_write( 0x10, RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data );   // Without this Parameters,Not needed

     // RF_PA **************************************************************************
     app_command_buf[ 0 ]  = 0x11;
     app_command_buf[ 1 ]  = 0x22;    // 0x2200
     app_command_buf[ 2 ]  = 0x04;    // Total 4Parameters
     app_command_buf[ 3 ]  = 0x00;   // 0x2200
     app_command_buf[ 4 ]  = 0x08;  //0x10;   //   PA mode  = default , ??Class E mode,?Is not Switch Current mode  ????????
     /*
     if ( power == 7 ) {
        app_command_buf[ 5 ]  = 127;   //  Set to maximum power
     }
     else if ( power == 6 ) {
          app_command_buf[ 5 ]  = 50;
     }
     else if ( power == 5 ) {
          app_command_buf[ 5 ]  = 30;
     }
     else if ( power == 4 ) {
          app_command_buf[ 5 ]  = 20;
     }
     else if ( power == 3) {
          app_command_buf[ 5 ]  = 15;
     }
     else if( power == 2 ) {
          app_command_buf[ 5 ]  = 10;
     }
     else if ( power == 1 ) {
          app_command_buf[ 5 ]  = 7;
     }
     else {
          app_command_buf[ 5 ]  = 4;
     }
     */
     if ( power > 0 || power < 127 ) {
           app_command_buf[ 5 ]  = power;   //  Set to maximum power
      }
     else
     {
          app_command_buf[ 5 ]  = 127;
     }
     app_command_buf[ 6 ] = 0x00; //???????? 0x00;   // CLK duty = 50%, other = Default



     if ( ( rate <= dr_115p2 )||( rate == dr_500 ) ) {
        app_command_buf[ 7 ]  = 0x3d;  // ???????? 0x5d;   // PA ramp time = default
     }
     else {
          app_command_buf[ 7 ]  = 0x5d;
     }
     spi_write( 8, app_command_buf );

     strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
     // ********************************************************************************
     spi_write( 0x0B , RF_SYNTH_PFDCP_CPFF_7_data );      // Without this Parameters,Not needed
     strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
     // header match ******************************************************************
     app_command_buf[ 0 ]  = 0x11;
     app_command_buf[ 1 ]  = 0x30;    // 0x3000
     app_command_buf[ 2 ]  = 0x0c;    // Total 12 Parameters
     app_command_buf[ 3 ]  = 0x00;    // 0x3000
     app_command_buf[ 4 ]  = System_Lo;     // 0x00;   //  match 1 Value of
     app_command_buf[ 5 ]  = 0xff;    //  match 1 mask
     app_command_buf[ 6 ]  = 0x40;    // enable match 1, match 1 The distance between the value of and the synchronization word, 0 = match
     app_command_buf[ 7 ]  = System_Hi;     //  match 2 Value of
     app_command_buf[ 8 ]  = 0xff;    //  match 2 mask
     app_command_buf[ 9 ]  = 0x01;    // enable match 2, match 2 The distance between the value of and the synchronization word  , and function
     app_command_buf[ 10 ] = System_Higer;     //     match 3 Value of
     app_command_buf[ 11 ] = 0xff;;   //  match 3 mask
     app_command_buf[ 12 ] = 0x02;;   // enable match 3, match 3 The distance between the value of and the synchronization word    and function
     app_command_buf[ 13 ] = Systema_Higest;     //   match 4 Value of
     app_command_buf[ 14 ] = 0xff;    //   match 4 mask
     app_command_buf[ 15 ] = 0x03;    //  enable match 4, match 4 The distance between the value of and the synchronization word    and function
     spi_write( 16, app_command_buf );
     strncpy(app_command_buf,cleanBuffer,20);  // Clean buffer
     rf_init_freq();     // FUNCION DE FRECUENCIA ( REVISAR PARAMETROS )
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
     spi_write( 7, ucAppCommandBuf );
}




void vRF4463FifoReset( void ) {
     unsigned char p[2];

     p[ 0 ] = FIFO_INFO;
     p[ 1 ] = 0x03;   // reset tx ,rx fifo
     spi_write( 2, p );
}





void vRF4463ClearInterrupts( void ) {
     unsigned char p[ 4 ];

     p[ 0 ] = GET_INT_STATUS;
     p[ 1 ] = 0;               // clr  PH pending
     p[ 2 ] = 0;               // clr modem_pending
     p[ 3 ] = 0;               // clr chip pending
     spi_write( 4, p );
     spi_read( 9, GET_INT_STATUS );
}

         void vRF4463PartInfo( void ) {  // Solicitud totalmente operativa
              unsigned char p[ 9 ];

              p[ 0 ] = PART_INFO;
              //p[ 1 ] = 0;               // clr  PH pending
              //p[ 2 ] = 0;               // clr modem_pending
              //p[ 3 ] = 0;               // clr chip pending
              spi_write( 1, p );
              spi_read( 9, PART_INFO );
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
     spi_write( 0x07, p );     // enable  packet receive interrupt
}




void vRF4463EnableTxInterrupt( void ) {
     unsigned char p[ 6 ];

     p[ 0 ] = 0x11;
     p[ 1 ] = 0x01;            // 0x0100
     p[ 2 ] = 0x02;            // 2Parameters
     p[ 3 ] = 0x00;            // 0x0100
     p[ 4 ] = 0x01;            // Ph  int
     p[ 5 ] = 0x20;            //  enable  packet sent interrupt
     spi_write( 0x06, p );     // enable  packet receive interrupt
}




void vRF4463RfStandby( void ) {
     unsigned char p[ 2 ];

     p[ 0 ] = CHANGE_STATE ;   // CHANGE_STATE Command
     p[ 1 ] = 0x01 ;           // sleep mode
     spi_write( 2, p );
}




void vRF4463TxStart( void ) {
     unsigned char p[ 5 ];

     p[ 0 ] = START_TX ;       // start Command
     p[ 1 ] = freq_channel;    // channel 0
     p[ 2 ] = 0x30;            // Back after launch Readymode, Do not retransmit, launch immediately
     p[ 3 ] = 0;
     p[ 4 ] = 0;               //payload_length; // Total to transmit 10 bytes
     spi_write( 5, p );
}




void vRF4463RxStart( void ) {
     unsigned char p[ 8 ];

     p[ 0 ] = START_RX ;       // start Command
     p[ 1 ] = freq_channel;    // channel 0
     p[ 2 ] = 0x00;            // Enter receiving mode immediately
     p[ 3 ] = 0;
     p[ 4 ] = 0;               // payload_length; // Total to receive 10 bytes
     p[ 5 ] = 0;               // unchanged after preamble timeout
     //p[ 6 ] = 0x03;          // ready after valid packet received
     //p[ 7 ] = 0x0;           // unchanged after invalid packet received
     p[ 6 ] = 0x08;
     p[ 7 ] = 0x08;
     spi_write( 8, p );
}




void vRF4463RxStartTest( void ) {
     unsigned char p[ 8 ];

     LED_GREEN = 1;

     p[ 0 ] = START_RX;        // start Command
     p[ 1 ] = freq_channel;    // channel 0
     p[ 2 ] = 0x00;            // Enter receiving mode immediately
     p[ 3 ] = 0;
     //p[ 4 ] = payload_length; // Total to receive 10 bytes
     p[ 4 ] = 0;
     p[ 5 ] = 0;               // unchanged after preamble timeout
     //p[ 6 ] = 0x0;           // unchanged mode if valid packet received
     //p[ 7 ] = 0x0;           // unchanged mode if unvalid packet received
     p[ 6 ] = 0x08;
     p[ 7 ] = 0x08;
     spi_write( 8, p );
}




void vRF4463RxInit( void ) {
     Flag.is_tx = 0;
     vRF4463FifoReset();           // fifo_reset();  // Buffer empty
     vRF4463EnableRxInterrupt();   // enable_rx_interrupt();
     vRF4463ClearInterrupts();      // clr_interrupt();  // Clear interrupt factor

     if ( mode == rx_test_mode ) {
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
     //LED_RED ^= 1;
     //Delay_ms( 10 );
     //LED_RED ^= 1;
     vRF4463FifoReset();            // fifo_reset();  // Buffer empty
     spi_write_fifo();              // Fill the buffer with data
     vRF4463EnableTxInterrupt();    // enable_tx_interrupt();
     vRF4463ClearInterrupts();       // clr_interrupt();  // Clear interrupt factor
     vRF4463TxStart();              // tx_start();    // Enter launch mode, start launch
     rf_timeout = 0;
     
     Flag.rf_reach_timeout = 0;

     if ( ucRF4463IRQ ) {
        UART1_Write_Text( "[ UART1 ] TX INT\r\n" );
     }

     // Waiting for interrupt
     while ( nIRQ ) {     //nIRQ
           //wdtr = 0;              // WatchDog
           //wdtr = 0xff;
           if ( Flag.rf_reach_timeout ) {
              VRF4463SDNReset();
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
     spi_write_fifo();                       // Fill the buffer with data
     vRF4463EnableTxInterrupt();             //  enable_tx_interrupt();
     vRF4463ClearInterrupts();               //  clr_interrupt();  // Clear interrupt factor
     vRF4463TxStart();                       //  tx_start();    // Enter launch mode, start launch
     rf_timeout = 0;
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
void rf_init_freq ( void ) {
     unsigned char ucOUTDIV, ucDIV, ucVCO, ucINTE, ucBAND;
     unsigned char ucFD_2, ucFD_1, ucFD_0, ucFRAC_2, ucFRAC_1, ucFRAC_0;
     unsigned long ulFRAC, ulData, ulFrequency;
     unsigned char app_command_buf[ 20 ];

     ulFrequency = ( freq3 * 100) + ( freq2 * 10) + freq1;
     //ulFrequency = ( ulFrequency * 10000) + 5000;          //915.5 MHz??
     ulFrequency = ( ulFrequency * 10000);          //915.0 MHz??
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

     app_command_buf[ 0 ] = 0x11;           // SET property    MODEM_CLKGEN_BAND
     app_command_buf[ 1 ] = 0x20;           // Group  // 0x2051
     app_command_buf[ 2 ] = 0x01;           // Num Arguments // Total 1 Parameters
     app_command_buf[ 3 ] = 0x51;           // Number  // 0x2051
     app_command_buf[ 4 ] = 0x08 | ucBAND;  // Argumento  //  high performance mode , clk outpu = osc /4
     spi_write( 5, app_command_buf );

     app_command_buf[ 0 ]  = 0x11;
     app_command_buf[ 1 ]  = 0x40;    // 0x4000         FREQ_CONTROL_INTE
     app_command_buf[ 2 ]  = 0x08;    // Total 8 Parameters
     app_command_buf[ 3 ]  = 0x00;   // 0x4000
     app_command_buf[ 4 ]  = ucINTE;   //  default value
     app_command_buf[ 5 ]  = ucFRAC_2;   //  defaul value
     app_command_buf[ 6 ]  = ucFRAC_1;   //  default value
     app_command_buf[ 7 ]  = ucFRAC_0;   // frac ,from WDS
     app_command_buf[ 8 ]  = step_250K_step1;   // channel step1  from wds  // al parecer aqu� esta el ancho del canal
     app_command_buf[ 9 ]  = step_250K_step0;   // channel step0  from wds
     app_command_buf[ 10 ] = 0x20;  //  from wds Without this Values
     app_command_buf[ 11 ] = ucVCO;    // from wds Without this Values
     spi_write( 12, app_command_buf );

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


unsigned char ucRf4463SPIByte( unsigned char ucData ) {
        //unsigned char i;

        ucSPI2ByteReceived = 0;

        SPI2_DR = ucData;
        //SPI2_Write( ucData );
        //SPI2_Read ( ucData );

        //while ( !SPI2_SRbits.RXNE );                // espera la recepcion

        //while ( !SPI2_SRbits.RXNE );

        while ( !SPI2_SRbits.TXE );                // espera a que el buffer este vacio
        
        while ( SPI2_SRbits.BSY );                // espera a que el buffer este vacio
        //ucSPI2ByteReceived = ( unsigned char ) SPI2_DR;

        return ( ucSPI2ByteReceived );
}




void spi_write( unsigned char tx_length, unsigned char *p ) {
     unsigned char i,j;

     i = 0;
     while ( i != 0xFF ) {
           i = check_cts();
     }
     
     //SCK = 0;                            // Se puede comentar, se hara por Hardware
     nSEL = 0;                              // habilita escritura

     for ( i = 0; i < tx_length; i++ ) {
         j = *( p + i );
         ucRf4463SPIByte( j );
     }

     nSEL = 1;                              // desabilita escritura
}




unsigned char check_cts( void ) {           // This Command follows the Command and reads the response
     unsigned char i;

     nSEL = 1;
     //SCK = 0;                             // Se puede comentar, se hara por Hardware
     nSEL = 0;
     ucRf4463SPIByte( 0x44 );
     i = ucRf4463SPIByte( 0 );
     nSEL = 1;
     return ( i );
}




void spi_read( unsigned char data_length, unsigned char api_command ) {
     unsigned char i;
     unsigned char p[ 1 ];
     
     p[ 0 ] = api_command;
     i = 0;
     while ( i != 0xFF ) {
           i = check_cts();                // Check if you can send Command
     }
     
     spi_write( 1, p );    // Send Command

     i = 0;
     while ( i != 0xFF ) {
           i = check_cts();        //Check whether the data can be read
     }
        
     nSEL = 1;
     //SCK = 0;                      // Se puede comentar, se hara por Hardware
     nSEL = 0;
     ucRf4463SPIByte( 0x44 );
     for ( i = 0; i < data_length; i++ ) {        // Read data
         spi_read_buf[ i ] = ucRf4463SPIByte( 0x00 );             // 0x00
         Delay_ms(10);
     }
     nSEL = 1;
}




void spi_fast_read( unsigned char api_command ) {
     unsigned char i,p[1];

     p[0] = api_command;
     i = 0;
     while ( i != 0xFF ) {
           i = check_cts();                // Check if you can send Command
     }
     
     nSEL = 1;
     //SCK = 0;                             // Se puede comentar, se hara por Hardware
     nSEL = 0;
     ucRf4463SPIByte( api_command );    // Send Command
     for ( i = 0; i < 4; i++ ) {
         spi_read_buf[ i ] = ucRf4463SPIByte( 0xFF );   // Read out all the 4 registers Value of
     }
     nSEL = 1;
}




void spi_write_fifo( void ) {
     unsigned char i;

     i = 0;
     while ( i != 0xFF ) {
           i = check_cts();                // Check if you can send Command
     }
        
     nSEL = 1;
     //SCK = 0;                            // Se puede comentar, se hara por Hardware
     nSEL = 0;
     ucRf4463SPIByte( WRITE_TX_FIFO );

     if ( mode == tx_test_mode) {
        for ( i = 0; i < payload_length; i++ ) {
            ucRf4463SPIByte( tx_test_aa_data[ i ] );   // Send 10 test data
        }
     }
     else {
          for ( i = 0; i < payload_length; i++ ) {
              ucRf4463SPIByte( tx_ph_data[ i ] );
          }
     }
     nSEL = 1;
}




void spi_read_fifo( void ) {
     unsigned char i;

     i = 0;
     while ( i != 0xFF ) {
           i = check_cts();                   // Check if you can send Command
     }
     
     nSEL = 1;
     //SCK = 0;                              // Se puede comentar, se hara por Hardware
     nSEL = 0;
     ucRf4463SPIByte( READ_RX_FIFO );
     for ( i = 0; i < payload_length; i++ ) {
         rx_buf[ i ] = ucRf4463SPIByte( 0xFF );      // Receive 10 test data
     }
     nSEL = 1;
}




void VRF4463SDNReset( void ) {
     unsigned char i;

     SDN = 1;
     Delay_ms( 6 );        // delay_1ms( 2 );        // RF Module reset  DELAY
     SDN = 0;
     Delay_ms( 10 );       // delay_1ms( 10 );        // Delay 10ms for RF module to enter working state

     nSEL = 1;
     //SCK = 0;                // Se puede comentar, se hara por Hardware
     nSEL = 0;
     for ( i = 0; i < 7; i++ ) {
         ucRf4463SPIByte( RF_POWER_UP_data[ i ] );   // send power up Command
     }
     nSEL = 1;

     //Delay_ms( 20 );               //delay_1ms( 20 );        // Delay 20ms RF module enters working state, but CTS still needs to be judged later, this delay can be removed
}
// song end



void vRf4463RSSI(){
    int intRSSI;
    unsigned char rssi;
    U8 pcRSSI[ 9 ] = {0}; // 9
    U8 pcBuffer[ 4 ] = {0};
    static U16 intRFLastRSSI = 0;
    // El valor RSSI leído por la API puede traducirse a dBm mediante la siguiente 
    // ecuación lineal: RF_Input_Level_dBm = (RSSI_value / 2) - MODEM_RSSI_COMP - 70 
    // La propiedad MODEM_RSSI_COMP proporciona un ajuste fino de la relación entre el 
    // nivel de entrada de RF real (en dBm) y El valor RSSI devuelto. Es decir, 
    // el ajuste de esta propiedad permite al usuario cambiar la curva de potencia 
    // de entrada RSSI vs RF hacia arriba y hacia abajo. Esto puede ser deseable para 
    // compensar las diferencias en la pérdida de inserción frontal entre múltiples diseños 
    // (por ejemplo, debido a la presencia de un filtro de preselección SAW o un interruptor 
    // de RF). Un valor de MODEM_RSSI_COMP = 0x40 = 64d es apropiado para la mayoría de las 
    // aplicaciones. La evaluación clara del canal (CCA) o la detección del umbral RSSI 
    // también están disponibles. Se puede establecer un umbral RSSI en la propiedad 
    // API MODEM_RSSI_THRESH. 
    // Set properties:           RF_MODEM_RAW_CONTROL_10
    // Number of properties:     10
    // Group ID:                 0x20
    // Start ID:                 0x45
    // Default values:           0x02, 0x00, 0xA3, 0x02, 0x80, 0xFF, 0x0C, 0x01, 0x00, 0x40, 
    // Descriptions:
    //   MODEM_RAW_CONTROL - Defines gain and enable controls for raw / nonstandard mode.
    //   MODEM_RAW_EYE_1 - 11 bit eye-open detector threshold.
    //   MODEM_RAW_EYE_0 - 11 bit eye-open detector threshold.
    //   MODEM_ANT_DIV_MODE - Antenna diversity mode settings.
    //   MODEM_ANT_DIV_CONTROL - Specifies controls for the Antenna Diversity algorithm.
    //   MODEM_RSSI_THRESH - Configures the RSSI threshold.
    //   MODEM_RSSI_JUMP_THRESH - Configures the RSSI Jump Detection threshold.
    //   MODEM_RSSI_CONTROL - Control of the averaging modes and latching time for reporting RSSI value(s).
    //   MODEM_RSSI_CONTROL2 - RSSI Jump Detection control.
    //   MODEM_RSSI_COMP - RSSI compensation value.
    //#define RF_MODEM_RAW_CONTROL_10 0x11, 0x20, 0x0A, 0x45, 0x81, 0x01, 0x47, 0x01, 0x00, 0xFF, 0x06, 0x00, 0x18, 0x40

    pcBuffer[ 0 ] = 0x11;
    pcBuffer[ 1 ] = 0x20;
    pcBuffer[ 2 ] = 0x01;
    pcBuffer[ 3 ] = 0x4E;
    pcBuffer[ 4 ] = 0x40;
    spi_write( 5, pcBuffer );
 
    //ucRf4463SetCommand( 4, RF4463_CMD_SET_PROPERTY, pcBuffer );

    pcBuffer[ 0 ] = 0x12; // ox12
    pcBuffer[ 1 ] = 0x22;
    pcBuffer[ 2 ] = 0x4E;
    spi_write( 3, pcBuffer );
    spi_read( 9, pcRSSI );

    //ucRf4463GetCommand( 9, RF4463_CMD_GET_MODEM_STATUS , pcRSSI );
    rssi = ((pcRSSI[4] / 2) -64) -70;
    UART1_Write_Text("\r\n");
    ShortToStr(rssi, pcRSSI);
    UART1_Write_Text("[ RSSI ] = ");
    UART1_Write_Text(pcRSSI);
    UART1_Write_Text(" dBm\r\n");
}