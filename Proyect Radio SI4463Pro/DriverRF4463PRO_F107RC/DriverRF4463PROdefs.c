#define NOP                                 0x00
#define PART_INFO                       0x01 // 9   return 4463
#define FUNC_INFO                       0x10 // 7  Pointless
#define SET_PROPERTY                    0x11
#define GET_PROPERTY                    0x12
#define GPIO_PIN_CFG                    0x13    // 8
#define GET_ADC_READING                 0x14
#define FIFO_INFO                       0x15    // 3
#define PACKET_INFO                     0x16    // 3
#define IRCAL                           0x17
#define PROTOCOL_CFG                    0x18
#define GET_INT_STATUS                  0x20    // 9
#define GET_PH_STATUS                   0x21    // 3
#define GET_MODEM_STATUS                0x22    // 9
#define GET_CHIP_STATUS                 0x23     // 4
#define START_TX                        0x31
#define START_RX                        0x32
#define REQUEST_DEVICE_STAT             0x33   // 3
#define CHANGE_STATE                    0x34
#define READ_CMD_BUFF                   0x44
#define FRR_A_READ                      0x50   // 4
#define FRR_B_READ                      0x51
#define FRR_C_READ                      0x53
#define FRR_D_READ                      0x57
#define WRITE_TX_FIFO                   0x66
#define READ_RX_FIFO                    0x77
#define START_MFSK                      0x35
#define RX_HOP                          0x36

#define payload_length                  14    //Total header + 10 bytes

#define freq_channel                    0

#define step_500K_step1                 0x88
#define step_500K_step0                 0x89

#define deviation_20K_h                 0x00
#define deviation_20K_m                 0x05
#define deviation_20K_l                 0x76

#define deviation_3K_h                  0x00
#define deviation_3K_m                  0x00
#define deviation_3K_l                  0xd2

// add joyce

const unsigned char RF_MODEM_MOD_TYPE_12[11][12] = {
        0x03, 0x00, 0x07, 0x00, 0x12, 0xC0, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x00,    // 1200
        0x03, 0x00, 0x07, 0x00, 0x25, 0x80, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x00,    // 2400
        0x03, 0x00, 0x07, 0x00, 0x4B, 0x00, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x00,    // 4800
        0x03, 0x00, 0x07, 0x00, 0x96, 0x00, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x00,    // 9600
        0x03, 0x00, 0x07, 0x01, 0x2C, 0x00, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x01,    // 19200
        0x03, 0x00, 0x07, 0x01, 0x2C, 0x00, 0x08, 0x2D, 0xC6, 0xC0, 0x00, 0x01,    // 38400
        0x03, 0x00, 0x07, 0x02, 0x58, 0x00, 0x08, 0x2D, 0xC6, 0xC0, 0x00, 0x01,    // 76800
        0x03, 0x00, 0x07, 0x03, 0x84, 0x00, 0x08, 0x2D, 0xC6, 0xC0, 0x00, 0x01,    // 115200
        0x03, 0x00, 0x07, 0x27, 0x10, 0x00, 0x01, 0xC9, 0xC3, 0x80, 0x00, 0x01,    // 256000
        0x03, 0x00, 0x07, 0x4C, 0x4B, 0x40, 0x01, 0xC9, 0xC3, 0x80, 0x00, 0x1b,    // 500000
        0x03, 0x00, 0x07, 0x00, 0x07, 0xD0, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x00     // 500
};

const unsigned char RF_MODEM_TX_RAMP_DELAY_8_433[11][8] = {
        0x01, 0x80, 0x08, 0x03, 0x80, 0x00, 0x70, 0x20,                            // 1200
        0x01, 0x80, 0x08, 0x03, 0x80, 0x00, 0x70, 0x20,                            // 2400
        0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x70, 0x20,                            // 4800
        0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x70, 0x20,                            // 9600
        0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x30, 0x10,                            // 19200
        0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x20, 0x10,                            // 38400
        0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x10, 0x10,                            // 76800
        0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x10, 0x20,                            // 115200
        0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x00, 0x30,                            // 256000
        0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x00, 0x30,                            // 500000
        0x01, 0x80, 0x08, 0x03, 0x80, 0x00, 0x72, 0x21                             // 500
};

const unsigned char RF_MODEM_TX_RAMP_DELAY_8_850[ 11 ][ 8 ] = {
        0x01, 0x80, 0x08, 0x03, 0xC0, 0x00, 0x32, 0x20,       // 1200
        0x01, 0x80, 0x08, 0x03, 0xC0, 0x00, 0x30, 0x20,       // 2400
        0x01, 0x80, 0x08, 0x03, 0xC0, 0x00, 0x30, 0x20,       // 4800
                                                       // 9600
        0x01, 0x00, 0x08, 0x03, 0xC0, 0x00, 0x30, 0x20,                                // 5k
// 19200
        0x01, 0x00, 0x08, 0x03, 0xC0, 0x00, 0x30, 0x20,                                // 10k
// 38400
        0x01, 0x00, 0x08, 0x03, 0xC0, 0x00, 0x20, 0x10,                                // 10k
// 76800
        0x01, 0x00, 0x08, 0x03, 0xC0, 0x00, 0x10, 0x10,                                // 10k
// 115200
        0x01, 0x00, 0x08, 0x03, 0xC0, 0x00, 0x10, 0x20,                                // 15k
        0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x00, 0x30,                                // 256000
        0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x00, 0x30,                                // 500000
        0x01, 0x80, 0x08, 0x03, 0x80, 0x00, 0x72, 0x21                                // 500
};

const unsigned char RF_MODEM_BCR_OSR_1_9_433[ 11 ][ 9 ] = {
        0x03, 0x0D, 0x00, 0xA7, 0xC6, 0x00, 0x54, 0x02, 0xC2,                // 1200
        0x01, 0x87, 0x01, 0x4F, 0x8B, 0x00, 0xA8, 0x02, 0xC2,                // 2400
        0x00, 0xC3, 0x02, 0x9F, 0x17, 0x02, 0x1A, 0x02, 0x00,                // 4800
        0x00, 0x62, 0x05, 0x3E, 0x2D, 0x07, 0xFF, 0x02, 0x00,                // 9600
        0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,                // 19200
        0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,                // 38400
        0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,                // 76800
        0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,                // 115200
        0x00, 0x75, 0x04, 0x5E, 0x7B, 0x05, 0x9a, 0x02, 0x00,                // 256000
        0x00, 0x3C, 0x08, 0x88, 0x89, 0x07, 0xFF, 0x02, 0x00,                // 500000
        0x03, 0xAA, 0x00, 0x8B, 0xCF, 0x00, 0x46, 0x02, 0xC2                // 500
};

const unsigned char RF_MODEM_BCR_OSR_1_9_850[ 11 ][ 9 ] = {
// 1200
        0x03, 0x0D, 0x00, 0xA7, 0xC6, 0x00, 0x54, 0x02, 0xC2,
// 2400
        0x03, 0x0D, 0x00, 0xA7, 0xC6, 0x00, 0x54, 0x02, 0xC2,
// 4800
        0x01, 0x87, 0x01, 0x4F, 0x8B, 0x00, 0xA8, 0x02, 0xC2,
// 9600
        0x00, 0xC3, 0x02, 0x9F, 0x17, 0x01, 0x93, 0x02, 0x00,                // 5k
// 19200
        0x00, 0x62, 0x05, 0x3E, 0x2D, 0x05, 0x04, 0x02, 0x00,
// 38400
        0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,
// 76800
        0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,
// 115200
        0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,
        0x00, 0x75, 0x04, 0x5E, 0x7B, 0x05, 0x9a, 0x02, 0x00,                // 256000
        0x00, 0x3C, 0x08, 0x88, 0x89, 0x07, 0xFF, 0x02, 0x00,                // 500000
        0x03, 0xAA, 0x00, 0x8B, 0xCF, 0x00, 0x46, 0x02, 0xC2                // 500
};

const unsigned char RF_MODEM_AFC_GEAR_7_433[ 11 ][ 7 ] = {
        0x04, 0x36, 0x80, 0x03, 0x30, 0xAF, 0x80,                       // 1200
        0x04, 0x36, 0x80, 0x07, 0x14, 0xDD, 0x80,                       // 2400
        0x00, 0x12, 0x80, 0x2A, 0x04, 0x3A, 0xA0,                       // 4800
        0x00, 0x12, 0x80, 0x54, 0x02, 0x5A, 0xA0,                       // 9600
        0x00, 0x12, 0x80, 0xA8, 0x01, 0x68, 0xE0,                       // 19200
        0x00, 0x12, 0x81, 0x50, 0x01, 0x20, 0xE0,                       // 38400
        0x00, 0x12, 0x82, 0x9F, 0x01, 0x03, 0xE0,                       // 76800
        0x00, 0x23, 0x87, 0xDD, 0x00, 0x77, 0xE0,                       // 115200
        0x00, 0x23, 0x8F, 0xFF, 0x00, 0xc9, 0xE0,                       // 256000
        0x00, 0x23, 0x8F, 0xFF, 0x01, 0x23, 0xE0,                       // 500000
        0x04, 0x36, 0x80, 0x01, 0x50, 0x69, 0x80                        // 500
};

const unsigned char RF_MODEM_AFC_GEAR_7_850[ 11 ][ 7 ] = {
// 1200
        0x04, 0x36, 0x80, 0x01, 0x52, 0x30, 0x80,
// 2400
        0x04, 0x36, 0x80, 0x03, 0x30, 0x7F, 0x80,
// 4800
        0x04, 0x36, 0x80, 0x07, 0x17, 0x10, 0x80,
// 9600
        0x00, 0x12, 0x80, 0x2A, 0x04, 0xB1, 0xA0,                       // 5k
// 19200
        0x00, 0x12, 0x80, 0x54, 0x02, 0x9A, 0xA0,
// 38400
        0x00, 0x12, 0x80, 0xA8, 0x01, 0x8F, 0xA0,
// 76800
        0x00, 0x12, 0x81, 0x50, 0x01, 0x1F, 0xA0,
// 115200
        0x00, 0x23, 0x83, 0xEF, 0x00, 0x84, 0xA0,
        0x00, 0x23, 0x8F, 0xFF, 0x00, 0xc9, 0xE0,                       // 256000
        0x00, 0x23, 0x8F, 0xFF, 0x01, 0x23, 0xE0,                       // 500000
        0x04, 0x36, 0x80, 0x01, 0x50, 0x69, 0x80                        // 500
};

const unsigned char RF_MODEM_AGC_WINDOW_SIZE_9_433[ 11 ][ 9 ] = {
        0x11, 0xAB, 0xAB, 0x00, 0x1A, 0x14, 0x00, 0x00, 0x2B,           // 1200
        0x11, 0x56, 0x56, 0x00, 0x1A, 0xA0, 0x00, 0x00, 0x2A,           // 2400
        0x11, 0x2B, 0x2B, 0x00, 0x1A, 0x50, 0x00, 0x00, 0x29,           // 4800
        0x11, 0x15, 0x15, 0x00, 0x1A, 0x28, 0x00, 0x00, 0x28,           // 9600
        0x11, 0x0E, 0x0E, 0x00, 0x1A, 0x21, 0x55, 0x00, 0x28,           // 19200
        0x11, 0x0E, 0x0E, 0x00, 0x1A, 0x10, 0xAB, 0x00, 0x28,           // 38400
        0x11, 0x0E, 0x0E, 0x00, 0x1A, 0x08, 0x55, 0x00, 0x28,           // 76800
        0x11, 0x0E, 0x0E, 0x00, 0x1A, 0x05, 0x8E, 0x00, 0x28,           // 115200
        0x22, 0x0D, 0x0D, 0x00, 0x1A, 0x32, 0x00, 0x00, 0x28,           // 256000
        0x22, 0x07, 0x07, 0x00, 0x1A, 0x19, 0x9a, 0x00, 0x27,           // 500000
        0x11, 0xCD, 0xCD, 0x00, 0x1A, 0x30, 0x00, 0x00, 0x2B            // 500
};

const unsigned char RF_MODEM_AGC_WINDOW_SIZE_9_850[ 11 ][ 9 ] = {
// 1200
        0x11, 0xAB, 0xAB, 0x00, 0x02, 0xFF, 0xFF, 0x00, 0x2B,
// 2400
        0x11, 0xAB, 0xAB, 0x00, 0x02, 0xFF, 0xFF, 0x00, 0x2B,
// 4800
        0x11, 0x56, 0x56, 0x00, 0x02, 0xD5, 0x55, 0x00, 0x2A,
// 9600
        0x11, 0x2B, 0x2B, 0x00, 0x02, 0x6A, 0xAB, 0x00, 0x29,           //        5k
// 19200
        0x11, 0x15, 0x15, 0x00, 0x02, 0x42, 0xAB, 0x00, 0x28,
// 38400
        0x11, 0x0E, 0x0E, 0x00, 0x02, 0x21, 0x55, 0x00, 0x28,
// 76800
        0x11, 0x0E, 0x0E, 0x00, 0x02, 0x10, 0xAB, 0x00, 0x28,
// 115200
        0x11, 0x0E, 0x0E, 0x00, 0x02, 0x10, 0xAB, 0x00, 0x28,
        0x22, 0x0D, 0x0D, 0x00, 0x1A, 0x32, 0x00, 0x00, 0x28,           // 256000
        0x22, 0x07, 0x07, 0x00, 0x1A, 0x19, 0x9a, 0x00, 0x27,           // 500000
        0x11, 0xCD, 0xCD, 0x00, 0x1A, 0x30, 0x00, 0x00, 0x2B            // 500
};

const unsigned char RF_MODEM_OOK_CNT1_11_433[ 11 ][ 11 ] = {
        0xA4, 0x02, 0xD6, 0x83, 0x00, 0xAD, 0x01, 0x80, 0xFF, 0x0C, 0x00,     // 1200
        0xA4, 0x02, 0xD6, 0x83, 0x00, 0xAD, 0x01, 0x80, 0xFF, 0x0C, 0x00,     // 2400
        0xA4, 0x03, 0xD6, 0x03, 0x00, 0xCC, 0x01, 0x80, 0xFF, 0x0C, 0x00,     // 4800
        0xA4, 0x03, 0xD6, 0x03, 0x00, 0xCC, 0x01, 0x80, 0xFF, 0x0C, 0x00,     // 9600
        0xA4, 0x03, 0xD6, 0x03, 0x01, 0x00, 0x01, 0x80, 0xFF, 0x0C, 0x00,     // 19200
        0xA4, 0x03, 0xD6, 0x03, 0x00, 0x80, 0x01, 0x80, 0xFF, 0x0C, 0x00,     // 38400
        0xA4, 0x03, 0xD6, 0x03, 0x00, 0x40, 0x01, 0x80, 0xFF, 0x0C, 0x00,     // 76800
        0xA4, 0x03, 0xD6, 0x03, 0x00, 0x2B, 0x01, 0x80, 0xFF, 0x0C, 0x00,     // 115200
        0xA4, 0x03, 0xD6, 0x03, 0x00, 0xd5, 0x01, 0x80, 0xFF, 0x0C, 0x00,     // 256000
        0xA4, 0x03, 0xD6, 0x03, 0x00, 0xd5, 0x01, 0x80, 0xFF, 0x0C, 0x00,     // 500000
        0xA4, 0x02, 0xD6, 0x81, 0x02, 0xB4, 0x01, 0x80, 0xFF, 0x0C, 0x00      // 500
};

const unsigned char RF_MODEM_OOK_CNT1_11_850[ 11 ][ 11 ] = {
// 1200
        0xA4, 0x02, 0xD6, 0x81, 0x03, 0x9B, 0x01, 0x80, 0xFF, 0x0C, 0x02,
// 2400
        0xA4, 0x02, 0xD6, 0x83, 0x00, 0xE7, 0x01, 0x80, 0xFF, 0x0C, 0x02,
// 4800
        0xA4, 0x02, 0xD6, 0x83, 0x00, 0xE7, 0x01, 0x80, 0xFF, 0x0C, 0x02,
// 9600
        0xA4, 0x03, 0xD6, 0x03, 0x01, 0x11, 0x01, 0x80, 0xFF, 0x0C, 0x02,
// 19200
        0xA4, 0x03, 0xD6, 0x03, 0x01, 0x55, 0x01, 0x80, 0xFF, 0x0C, 0x02,
// 38400
        0xA4, 0x03, 0xD6, 0x03, 0x01, 0x00, 0x01, 0x80, 0xFF, 0x0C, 0x02,
// 76800
        0xA4, 0x03, 0xD6, 0x03, 0x00, 0x80, 0x01, 0x80, 0xFF, 0x0C, 0x02,
// 115200
        0xA4, 0x03, 0xD6, 0x03, 0x00, 0x80, 0x01, 0x80, 0xFF, 0x0C, 0x02,
        0xA4, 0x03, 0xD6, 0x03, 0x00, 0xd5, 0x01, 0x80, 0xFF, 0x0C, 0x02,     // 256000
        0xA4, 0x03, 0xD6, 0x03, 0x00, 0xd5, 0x01, 0x80, 0xFF, 0x0C, 0x02,     // 500000
        0xA4, 0x02, 0xD6, 0x81, 0x02, 0xB4, 0x01, 0x80, 0xFF, 0x0C, 0x02      // 500
};

const unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433[ 11 ][ 12 ]= {
        0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,       // 1200
        0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,       // 2400
        0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1, 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11,       // 4800
        0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,       // 9600
        0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1, 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11,       // 19200
        0x7E, 0x64, 0x1B, 0xBA, 0x58, 0x0B, 0xDD, 0xCE, 0xD6, 0xE6, 0xF6, 0x00,       // 38400
        0x5B, 0x47, 0x0F, 0xC0, 0x6D, 0x25, 0xF4, 0xDB, 0xD6, 0xDF, 0xEC, 0xF7,       // 76800
        0x5B, 0x47, 0x0F, 0xC0, 0x6D, 0x25, 0xF4, 0xDB, 0xD6, 0xDF, 0xEC, 0xF7,       // 115200
        0x39, 0x2B, 0x00, 0xC3, 0x7F, 0x3F, 0x0C, 0xEC, 0xDC, 0xDC, 0xE3, 0xED,       // 256000
        0xA2, 0x81, 0x26, 0xAF, 0x3F, 0xEE, 0xC8, 0xC7, 0xDB, 0xF2, 0x02, 0x08,       // 500000
        0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1, 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11        // 500
};

const unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850[ 11 ][ 12 ] = {
// 1200
        0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,
// 2400
        0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,
// 4800
        0xFF, 0xBA, 0x0F, 0x51, 0xCF, 0xA9, 0xC9, 0xFC, 0x1B, 0x1E, 0x0F, 0x01,
// 9600
        0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,
// 19200
        0xFF, 0xBA, 0x0F, 0x51, 0xCF, 0xA9, 0xC9, 0xFC, 0x1B, 0x1E, 0x0F, 0x01,
// 38400
        0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,
// 76800
        0x7E, 0x64, 0x1B, 0xBA, 0x58, 0x0B, 0xDD, 0xCE, 0xD6, 0xE6, 0xF6, 0x00,
// 115200
        0x7E, 0x64, 0x1B, 0xBA, 0x58, 0x0B, 0xDD, 0xCE, 0xD6, 0xE6, 0xF6, 0x00,
        0x39, 0x2B, 0x00, 0xC3, 0x7F, 0x3F, 0x0C, 0xEC, 0xDC, 0xDC, 0xE3, 0xED,       // 256000
        0xA2, 0x81, 0x26, 0xAF, 0x3F, 0xEE, 0xC8, 0xC7, 0xDB, 0xF2, 0x02, 0x08,       // 500000
        0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1, 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11        // 500
};

const unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433[ 11 ][ 12 ] = {
        0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,       // 1200
        0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,       // 2400
        0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00, 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1,       // 4800
        0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,       // 9600
        0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00, 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1,       // 19200
        0x03, 0x03, 0x15, 0xF0, 0x3F, 0x00, 0x7E, 0x64, 0x1B, 0xBA, 0x58, 0x0B,       // 38400
        0xFE, 0x01, 0x15, 0xF0, 0xFF, 0x03, 0x5B, 0x47, 0x0F, 0xC0, 0x6D, 0x25,       // 76800
        0xFE, 0x01, 0x15, 0xF0, 0xFF, 0x03, 0x5B, 0x47, 0x0F, 0xC0, 0x6D, 0x25,       // 115200
        0xF6, 0xFD, 0x15, 0xC0, 0xFF, 0x0F, 0x39, 0x2B, 0x00, 0xC3, 0x7F, 0x3F,       // 256000
        0x07, 0x03, 0x15, 0xFC, 0x0F, 0x00, 0xA2, 0x81, 0x26, 0xAF, 0x3F, 0xEE,       // 500000
        0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00, 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1        // 500
};

const unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850[ 11 ][ 12 ] = {
// 1200
        0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,
// 2400
        0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,
// 4800
        0xFC, 0xFD, 0x15, 0xFF, 0x00, 0x0F, 0xFF, 0xBA, 0x0F, 0x51, 0xCF, 0xA9,
// 9600
        0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,
// 19200
        0xFC, 0xFD, 0x15, 0xFF, 0x00, 0x0F, 0xFF, 0xBA, 0x0F, 0x51, 0xCF, 0xA9,
// 38400
        0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,
// 76800
        0x03, 0x03, 0x15, 0xF0, 0x3F, 0x00, 0x7E, 0x64, 0x1B, 0xBA, 0x58, 0x0B,
// 115200
        0xF6, 0xFD, 0x15, 0xC0, 0xFF, 0x0F, 0x39, 0x2B, 0x00, 0xC3, 0x7F, 0x3F,       // 256000
        0x07, 0x03, 0x15, 0xFC, 0x0F, 0x00, 0xA2, 0x81, 0x26, 0xAF, 0x3F, 0xEE,       // 500000
        0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00, 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1        // 500
};

const unsigned char RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433[ 11 ][ 12 ] = {
        0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,       // 1200
        0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,       // 2400
        0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11, 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00,       // 4800
        0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,       // 9600
        0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11, 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00,       // 19200
        0xDD, 0xCE, 0xD6, 0xE6, 0xF6, 0x00, 0x03, 0x03, 0x15, 0xF0, 0x3F, 0x00,       // 38400
        0xF4, 0xDB, 0xD6, 0xDF, 0xEC, 0xF7, 0xFE, 0x01, 0x15, 0xF0, 0xFF, 0x03,       // 76800
        0xF4, 0xDB, 0xD6, 0xDF, 0xEC, 0xF7, 0xFE, 0x01, 0x15, 0xF0, 0xFF, 0x03,       // 115200
        0x0C, 0xEC, 0xDC, 0xDC, 0xE3, 0xED, 0xF6, 0xFD, 0x15, 0xC0, 0xFF, 0x0F,       // 256000
        0xC8, 0xC7, 0xDB, 0xF2, 0x02, 0x08, 0x07, 0x03, 0x15, 0xFC, 0x0F, 0x00,       // 500000
        0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11, 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00        // 500
};

const unsigned char RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850[ 11 ][ 12 ] = {
// 1200
        0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,
// 2400
        0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,
// 4800
        0xC9, 0xFC, 0x1B, 0x1E, 0x0F, 0x01, 0xFC, 0xFD, 0x15, 0xFF, 0x00, 0x0F,
// 9600
        0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,
// 19200
        0xC9, 0xFC, 0x1B, 0x1E, 0x0F, 0x01, 0xFC, 0xFD, 0x15, 0xFF, 0x00, 0x0F,
// 38400
        0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,
// 76800
        0xDD, 0xCE, 0xD6, 0xE6, 0xF6, 0x00, 0x03, 0x03, 0x15, 0xF0, 0x3F, 0x00,
// 115200
        0x03, 0x03, 0x15, 0xF0, 0x3F, 0x00, 0x7E, 0x64, 0x1B, 0xBA, 0x58, 0x0B,
        0x0C, 0xEC, 0xDC, 0xDC, 0xE3, 0xED, 0xF6, 0xFD, 0x15, 0xC0, 0xFF, 0x0F,       // 256000
        0xC8, 0xC7, 0xDB, 0xF2, 0x02, 0x08, 0x07, 0x03, 0x15, 0xFC, 0x0F, 0x00,       // 500000
        0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11, 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00        // 500
};

const unsigned char RF_SYNTH_PFDCP_CPFF_7[ 11 ][ 7 ] = {
        0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,                                     // 1200
        0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,                                     // 2400
        0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,                                     // 4800
        0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,                                     // 9600
        0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,                                     // 19200
        0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,                                     // 38400
        0x34, 0x04, 0x0B, 0x04, 0x07, 0x70, 0x03,                                     // 76800
        0x34, 0x04, 0x0B, 0x04, 0x07, 0x70, 0x03,                                     // 115200
        0x01, 0x05, 0x0B, 0x05, 0x02, 0x00, 0x03,                                     // 256000
        0x01, 0x05, 0x0B, 0x05, 0x02, 0x00, 0x03,                                     // 500000
        0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03                                      // 500
};


// VALORES TOMADOS DEL ARCHIVO ConfigRF4463PRO.h
const unsigned char RF_POWER_UP_data[]                         = { RF_POWER_UP };
const unsigned char RF_FRR_CTL_A_MODE_4_data[]                 = { RF_FRR_CTL_A_MODE_4 };
const unsigned char RF_MODEM_AGC_CONTROL_1_data[]              = { RF_MODEM_AGC_CONTROL_1 };

unsigned char RF_MODEM_MOD_TYPE_12_data[ 16 ]                  = { 0x11, 0x20, 0x0C, 0x00 };
unsigned char RF_MODEM_TX_RAMP_DELAY_8_data[ 12 ]              = { 0x11, 0x20, 0x08, 0x18 };
unsigned char RF_MODEM_BCR_OSR_1_9_data[ 13 ]                  = { 0x11, 0x20, 0x09, 0x22 };
unsigned char RF_MODEM_AFC_GEAR_7_data[ 13 ]                   = { 0x11, 0x20, 0x07, 0x2C };
unsigned char RF_MODEM_AGC_WINDOW_SIZE_9_data[ 13 ]            = { 0x11, 0x20, 0x09, 0x38 };
unsigned char RF_MODEM_OOK_CNT1_11_data[ 15 ]                  = { 0x11, 0x20, 0x0B, 0x42 };
unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[ 16 ] = { 0x11, 0x21, 0x0C, 0x00 };
unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[ 16 ]  = { 0x11, 0x21, 0x0C, 0x0C };
unsigned char RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[ 16 ]  = { 0x11, 0x21, 0x0C, 0x18 };
unsigned char RF_SYNTH_PFDCP_CPFF_7_data[ 11 ]                 = { 0x11, 0x23, 0x07, 0x00 };

const unsigned char tx_test_aa_data[ 14 ] = { 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA };  // Test signal of fixed content transmitted every second, the 10th data is the checksum of the first 9 data
const unsigned char tx_ph_data[ 14 ] = { 's', 'w', 'w', 'x', 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x6D };  // Test signal of fixed content transmitted every second, the 10th data is the checksum of the first 9 data

typedef struct
{
        unsigned char reach_1s         : 1;
        unsigned char is_tx            : 1;
        unsigned char rf_reach_timeout : 1;

// add joyce
        unsigned char flash            : 1;
        unsigned char key_valid        : 1;

}FlagType;

FlagType        Flag;

U16        count_1hz, rf_timeout;
unsigned char spi_read_buf[ 20 ];   // Used to read the returned data content of SPI Command
unsigned char rx_buf[ 25 ];

//U8 mode;

// add joyce
const unsigned char Tab_DispCode[ 17 ] = { 0x77, 0x24, 0x6B, 0x6D, 0x3C, 0x5D, 0x5F, 0x64, 0x7F, 0x7D, 0x7E, 0x1F, 0x53, 0x2F, 0x5B, 0x5A, 0x00};
unsigned char       dis_ram[ 28 ] = { 00 };

unsigned char        key_value;
unsigned char        have_set;
unsigned char         set;                // Set mode
unsigned char         old_mode;
unsigned char         mode;
unsigned char         freq3;
unsigned char         freq2;
unsigned char         freq1;                // Carrier frequency
unsigned char         power;                // Transmit power
unsigned char         rssi;                // Accept signal strength
unsigned char         rate;                // rate

unsigned char        cnt_10s;

unsigned long   tx_cnt = 0,rx_cnt = 0; //Number of sending and receiving
unsigned char         reset_mode;

unsigned char         reach_15hz = 0,reach_flash = 0,reach_1s = 0;
unsigned char         count_15hz,count_flash = 0,count_1s = 0,nirq_cnt = 0;

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

// joyce add
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