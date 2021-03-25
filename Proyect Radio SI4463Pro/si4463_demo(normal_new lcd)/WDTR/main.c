// 	Demo ³ÌÐòÊÊÓÃ  £º     SI4463, 
// 	RF Ä£¿éµÄ²ÎÊýÉèÖÃÎª£º +/-10PPM
//	Ê¹ÄÜAFC£¬Ê¹ÄÜCRC£¬ PH + FIFO Ä£Ê½
// 	Ã¿ÃëÖÓ·¢ÉäµÄ¹Ì¶¨²âÊÔÊý¾ÝÎª£º 0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x6d, 
//  chksum:  0x6d = (0x41 +0x42 +0x43 +0x44 +0x45 +0x46 +0x47 + 0x48 +0x49)
// 	MCU : RENSAS high performance 8 bit MCU :R5f211B4, internal 8MHz
// 	src_field, ÊÇÖ¸ÄÄ¸öfield °üÀ¨ ³¤¶ÈÐÅÏ¢£¬³¤¶ÈÐÅÏ¢ÔÚÕâ¸öfield µÄ×îºóÒ»¸ö»òÕß2¸ö×Ö½Ú
// 	dst-field ÊÇÖ¸¾ßÌåµÄÄÇ¸öfield£¬Ö¸¾ßÌåµÄÄÚÈÝ¡£
// 	ÀýÈç£º Òª½«  1,2,3,4,5,6,7,8,9 Õâ9¸ö¿É±ä³¤¶ÈµÄÊý¾Ý·Åµ½field 4,ÄÇÃ´¿ÉÒÔÉèÖÃ:src-field = 1,field 1 °üÀ¨³¤¶ÈÐÅÏ¢£¬
//	ÔÚÕâ¸öfieldµÄ×îºóÒ»¸ö×Ö½Ú¾ÍÊÇ³¤¶ÈÐÅÏ¢£¬Ò²¾ÍÊÇËµ×îºóÒ»¸ö×Ö½Ú µÄÄÚÈÝÊÇ 9£¨³¤¶È£©,Dst-field = 3;ÔòÒâÎ¶×Å field 3µÄÄÚÈÝÊÇ 1£¬2£¬ ¡£¡£¡£¡£


#include "define.h"
#include "radio_config_si4463.h"
#include "flash.h"

#define NOP 							0x00 
#define PART_INFO                       0x01    // 9   ·µ»Ø 4463 
#define FUNC_INFO                       0x10    // 7  Ã»ÓÐÒâÒå
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
#define GET_CHIP_STATUS                 0x23    // 4
#define START_TX                        0x31 
#define START_RX                        0x32 
#define REQUEST_DEVICE_STAT             0x33    // 3
#define CHANGE_STATE                    0x34 
#define READ_CMD_BUFF                   0x44 
#define FRR_A_READ                      0x50    // 4
#define FRR_B_READ                      0x51 
#define FRR_C_READ                      0x53 
#define FRR_D_READ                      0x57 
#define WRITE_TX_FIFO                   0x66 
#define READ_RX_FIFO                    0x77 
#define START_MFSK                      0x35 
#define RX_HOP                          0x36 

#define payload_length  				14    //×Ü¹² header + 10¸ö×Ö½Ú

#define freq_channel		0 

#define step_500K_step1		0x88
#define step_500K_step0		0x89

#define deviation_20K_h		0x00
#define deviation_20K_m		0x05
#define deviation_20K_l		0x76

#define deviation_3K_h		0x00
#define deviation_3K_m		0x00
#define deviation_3K_l		0xd2

// add joyce

const unsigned char RF_MODEM_MOD_TYPE_12[11][12] =
{
	0x03, 0x00, 0x07, 0x00, 0x12, 0xC0, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x00,				// 1200
	0x03, 0x00, 0x07, 0x00, 0x25, 0x80, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x00,				// 2400
	0x03, 0x00, 0x07, 0x00, 0x4B, 0x00, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x00,				// 4800
	0x03, 0x00, 0x07, 0x00, 0x96, 0x00, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x00,				// 9600
	0x03, 0x00, 0x07, 0x01, 0x2C, 0x00, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x01,				// 19200
	0x03, 0x00, 0x07, 0x01, 0x2C, 0x00, 0x08, 0x2D, 0xC6, 0xC0, 0x00, 0x01,				// 38400
	0x03, 0x00, 0x07, 0x02, 0x58, 0x00, 0x08, 0x2D, 0xC6, 0xC0, 0x00, 0x01,				// 76800
	0x03, 0x00, 0x07, 0x03, 0x84, 0x00, 0x08, 0x2D, 0xC6, 0xC0, 0x00, 0x01,				// 115200
	0x03, 0x00, 0x07, 0x27, 0x10, 0x00, 0x01, 0xC9, 0xC3, 0x80, 0x00, 0x01,				// 256000
	0x03, 0x00, 0x07, 0x4C, 0x4B, 0x40, 0x01, 0xC9, 0xC3, 0x80, 0x00, 0x1b,				// 500000
	0x03, 0x00, 0x07, 0x00, 0x07, 0xD0, 0x04, 0x2D, 0xC6, 0xC0, 0x00, 0x00				// 500
};

const unsigned char RF_MODEM_TX_RAMP_DELAY_8_433[11][8]=
{
	0x01, 0x80, 0x08, 0x03, 0x80, 0x00, 0x70, 0x20,				// 1200
	0x01, 0x80, 0x08, 0x03, 0x80, 0x00, 0x70, 0x20,				// 2400
	0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x70, 0x20,				// 4800
	0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x70, 0x20,				// 9600
	0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x30, 0x10,				// 19200
	0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x20, 0x10,				// 38400
	0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x10, 0x10,				// 76800
	0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x10, 0x20,				// 115200
	0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x00, 0x30,				// 256000
	0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x00, 0x30,				// 500000
	0x01, 0x80, 0x08, 0x03, 0x80, 0x00, 0x72, 0x21				// 500
};

const unsigned char RF_MODEM_TX_RAMP_DELAY_8_850[11][8]=
{
// 1200
	0x01, 0x80, 0x08, 0x03, 0xC0, 0x00, 0x32, 0x20,
// 2400
	0x01, 0x80, 0x08, 0x03, 0xC0, 0x00, 0x30, 0x20,
// 4800
	0x01, 0x80, 0x08, 0x03, 0xC0, 0x00, 0x30, 0x20,
// 9600
	0x01, 0x00, 0x08, 0x03, 0xC0, 0x00, 0x30, 0x20,				// 5k
// 19200
	0x01, 0x00, 0x08, 0x03, 0xC0, 0x00, 0x30, 0x20,				// 10k
// 38400
	0x01, 0x00, 0x08, 0x03, 0xC0, 0x00, 0x20, 0x10,				// 10k
// 76800
	0x01, 0x00, 0x08, 0x03, 0xC0, 0x00, 0x10, 0x10,				// 10k
// 115200
	0x01, 0x00, 0x08, 0x03, 0xC0, 0x00, 0x10, 0x20,				// 15k
	0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x00, 0x30,				// 256000
	0x01, 0x00, 0x08, 0x03, 0x80, 0x00, 0x00, 0x30,				// 500000
	0x01, 0x80, 0x08, 0x03, 0x80, 0x00, 0x72, 0x21				// 500
};
const unsigned char RF_MODEM_BCR_OSR_1_9_433[11][9]=
{
	0x03, 0x0D, 0x00, 0xA7, 0xC6, 0x00, 0x54, 0x02, 0xC2,		// 1200
	0x01, 0x87, 0x01, 0x4F, 0x8B, 0x00, 0xA8, 0x02, 0xC2,		// 2400
	0x00, 0xC3, 0x02, 0x9F, 0x17, 0x02, 0x1A, 0x02, 0x00,		// 4800
	0x00, 0x62, 0x05, 0x3E, 0x2D, 0x07, 0xFF, 0x02, 0x00,		// 9600
	0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,		// 19200
	0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,		// 38400
	0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,		// 76800
	0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,		// 115200
	0x00, 0x75, 0x04, 0x5E, 0x7B, 0x05, 0x9a, 0x02, 0x00,		// 256000
	0x00, 0x3C, 0x08, 0x88, 0x89, 0x07, 0xFF, 0x02, 0x00,		// 500000
	0x03, 0xAA, 0x00, 0x8B, 0xCF, 0x00, 0x46, 0x02, 0xC2		// 500
};

const unsigned char RF_MODEM_BCR_OSR_1_9_850[11][9]=
{
// 1200
	0x03, 0x0D, 0x00, 0xA7, 0xC6, 0x00, 0x54, 0x02, 0xC2,
// 2400
	0x03, 0x0D, 0x00, 0xA7, 0xC6, 0x00, 0x54, 0x02, 0xC2,
// 4800
	0x01, 0x87, 0x01, 0x4F, 0x8B, 0x00, 0xA8, 0x02, 0xC2,
// 9600
	0x00, 0xC3, 0x02, 0x9F, 0x17, 0x01, 0x93, 0x02, 0x00,		// 5k
// 19200
	0x00, 0x62, 0x05, 0x3E, 0x2D, 0x05, 0x04, 0x02, 0x00,
// 38400
	0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,
// 76800
	0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,
// 115200
	0x00, 0x41, 0x07, 0xDD, 0x44, 0x07, 0xFF, 0x02, 0x00,
	0x00, 0x75, 0x04, 0x5E, 0x7B, 0x05, 0x9a, 0x02, 0x00,		// 256000
	0x00, 0x3C, 0x08, 0x88, 0x89, 0x07, 0xFF, 0x02, 0x00,		// 500000
	0x03, 0xAA, 0x00, 0x8B, 0xCF, 0x00, 0x46, 0x02, 0xC2		// 500
};
const unsigned char RF_MODEM_AFC_GEAR_7_433[11][7]=
{
	0x04, 0x36, 0x80, 0x03, 0x30, 0xAF, 0x80,				// 1200
	0x04, 0x36, 0x80, 0x07, 0x14, 0xDD, 0x80,				// 2400
	0x00, 0x12, 0x80, 0x2A, 0x04, 0x3A, 0xA0,				// 4800
	0x00, 0x12, 0x80, 0x54, 0x02, 0x5A, 0xA0,				// 9600
	0x00, 0x12, 0x80, 0xA8, 0x01, 0x68, 0xE0,				// 19200
	0x00, 0x12, 0x81, 0x50, 0x01, 0x20, 0xE0,				// 38400
	0x00, 0x12, 0x82, 0x9F, 0x01, 0x03, 0xE0,				// 76800
	0x00, 0x23, 0x87, 0xDD, 0x00, 0x77, 0xE0,				// 115200
	0x00, 0x23, 0x8F, 0xFF, 0x00, 0xc9, 0xE0,				// 256000
	0x00, 0x23, 0x8F, 0xFF, 0x01, 0x23, 0xE0,				// 500000
	0x04, 0x36, 0x80, 0x01, 0x50, 0x69, 0x80				// 500
};

const unsigned char RF_MODEM_AFC_GEAR_7_850[11][7]=
{
// 1200
	0x04, 0x36, 0x80, 0x01, 0x52, 0x30, 0x80,
// 2400
	0x04, 0x36, 0x80, 0x03, 0x30, 0x7F, 0x80,
// 4800
	0x04, 0x36, 0x80, 0x07, 0x17, 0x10, 0x80,
// 9600
	0x00, 0x12, 0x80, 0x2A, 0x04, 0xB1, 0xA0,				// 5k			
// 19200
	0x00, 0x12, 0x80, 0x54, 0x02, 0x9A, 0xA0,
// 38400
	0x00, 0x12, 0x80, 0xA8, 0x01, 0x8F, 0xA0,
// 76800
	0x00, 0x12, 0x81, 0x50, 0x01, 0x1F, 0xA0,
// 115200
	0x00, 0x23, 0x83, 0xEF, 0x00, 0x84, 0xA0,
	0x00, 0x23, 0x8F, 0xFF, 0x00, 0xc9, 0xE0,				// 256000
	0x00, 0x23, 0x8F, 0xFF, 0x01, 0x23, 0xE0,				// 500000
	0x04, 0x36, 0x80, 0x01, 0x50, 0x69, 0x80				// 500
};

const unsigned char RF_MODEM_AGC_WINDOW_SIZE_9_433[11][9]=
{
	0x11, 0xAB, 0xAB, 0x00, 0x1A, 0x14, 0x00, 0x00, 0x2B,		// 1200
	0x11, 0x56, 0x56, 0x00, 0x1A, 0xA0, 0x00, 0x00, 0x2A,		// 2400
	0x11, 0x2B, 0x2B, 0x00, 0x1A, 0x50, 0x00, 0x00, 0x29,		// 4800
	0x11, 0x15, 0x15, 0x00, 0x1A, 0x28, 0x00, 0x00, 0x28,		// 9600
	0x11, 0x0E, 0x0E, 0x00, 0x1A, 0x21, 0x55, 0x00, 0x28,		// 19200
	0x11, 0x0E, 0x0E, 0x00, 0x1A, 0x10, 0xAB, 0x00, 0x28,		// 38400
	0x11, 0x0E, 0x0E, 0x00, 0x1A, 0x08, 0x55, 0x00, 0x28,		// 76800
	0x11, 0x0E, 0x0E, 0x00, 0x1A, 0x05, 0x8E, 0x00, 0x28,		// 115200
	0x22, 0x0D, 0x0D, 0x00, 0x1A, 0x32, 0x00, 0x00, 0x28,		// 256000
	0x22, 0x07, 0x07, 0x00, 0x1A, 0x19, 0x9a, 0x00, 0x27,		// 500000
	0x11, 0xCD, 0xCD, 0x00, 0x1A, 0x30, 0x00, 0x00, 0x2B		// 500
};	

const unsigned char RF_MODEM_AGC_WINDOW_SIZE_9_850[11][9]=
{
// 1200
	0x11, 0xAB, 0xAB, 0x00, 0x02, 0xFF, 0xFF, 0x00, 0x2B,
// 2400
	0x11, 0xAB, 0xAB, 0x00, 0x02, 0xFF, 0xFF, 0x00, 0x2B,
// 4800
	0x11, 0x56, 0x56, 0x00, 0x02, 0xD5, 0x55, 0x00, 0x2A,
// 9600
	0x11, 0x2B, 0x2B, 0x00, 0x02, 0x6A, 0xAB, 0x00, 0x29,		//	5k
// 19200
	0x11, 0x15, 0x15, 0x00, 0x02, 0x42, 0xAB, 0x00, 0x28,
// 38400
	0x11, 0x0E, 0x0E, 0x00, 0x02, 0x21, 0x55, 0x00, 0x28,
// 76800
	0x11, 0x0E, 0x0E, 0x00, 0x02, 0x10, 0xAB, 0x00, 0x28,
// 115200
	0x11, 0x0E, 0x0E, 0x00, 0x02, 0x10, 0xAB, 0x00, 0x28,
	0x22, 0x0D, 0x0D, 0x00, 0x1A, 0x32, 0x00, 0x00, 0x28,		// 256000
	0x22, 0x07, 0x07, 0x00, 0x1A, 0x19, 0x9a, 0x00, 0x27,		// 500000
	0x11, 0xCD, 0xCD, 0x00, 0x1A, 0x30, 0x00, 0x00, 0x2B		// 500
};	

const unsigned char RF_MODEM_OOK_CNT1_11_433[11][11]=
{
	0xA4, 0x02, 0xD6, 0x83, 0x00, 0xAD, 0x01, 0x80, 0xFF, 0x0C, 0x00,		// 1200
	0xA4, 0x02, 0xD6, 0x83, 0x00, 0xAD, 0x01, 0x80, 0xFF, 0x0C, 0x00,		// 2400
	0xA4, 0x03, 0xD6, 0x03, 0x00, 0xCC, 0x01, 0x80, 0xFF, 0x0C, 0x00,		// 4800
	0xA4, 0x03, 0xD6, 0x03, 0x00, 0xCC, 0x01, 0x80, 0xFF, 0x0C, 0x00,		// 9600
	0xA4, 0x03, 0xD6, 0x03, 0x01, 0x00, 0x01, 0x80, 0xFF, 0x0C, 0x00,		// 19200
	0xA4, 0x03, 0xD6, 0x03, 0x00, 0x80, 0x01, 0x80, 0xFF, 0x0C, 0x00,		// 38400
	0xA4, 0x03, 0xD6, 0x03, 0x00, 0x40, 0x01, 0x80, 0xFF, 0x0C, 0x00,		// 76800
	0xA4, 0x03, 0xD6, 0x03, 0x00, 0x2B, 0x01, 0x80, 0xFF, 0x0C, 0x00,		// 115200
	0xA4, 0x03, 0xD6, 0x03, 0x00, 0xd5, 0x01, 0x80, 0xFF, 0x0C, 0x00,		// 256000
	0xA4, 0x03, 0xD6, 0x03, 0x00, 0xd5, 0x01, 0x80, 0xFF, 0x0C, 0x00,		// 500000
	0xA4, 0x02, 0xD6, 0x81, 0x02, 0xB4, 0x01, 0x80, 0xFF, 0x0C, 0x00		// 500
};	

const unsigned char RF_MODEM_OOK_CNT1_11_850[11][11]=
{
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
	0xA4, 0x03, 0xD6, 0x03, 0x00, 0xd5, 0x01, 0x80, 0xFF, 0x0C, 0x02,		// 256000
	0xA4, 0x03, 0xD6, 0x03, 0x00, 0xd5, 0x01, 0x80, 0xFF, 0x0C, 0x02,		// 500000
	0xA4, 0x02, 0xD6, 0x81, 0x02, 0xB4, 0x01, 0x80, 0xFF, 0x0C, 0x02		// 500
};

const unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433[11][12]=
{
	0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,			// 1200
	0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,			// 2400
	0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1, 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11,			// 4800
	0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5, 0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C,			// 9600
	0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1, 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11,			// 19200
	0x7E, 0x64, 0x1B, 0xBA, 0x58, 0x0B, 0xDD, 0xCE, 0xD6, 0xE6, 0xF6, 0x00,			// 38400
	0x5B, 0x47, 0x0F, 0xC0, 0x6D, 0x25, 0xF4, 0xDB, 0xD6, 0xDF, 0xEC, 0xF7,			// 76800
	0x5B, 0x47, 0x0F, 0xC0, 0x6D, 0x25, 0xF4, 0xDB, 0xD6, 0xDF, 0xEC, 0xF7,			// 115200
	0x39, 0x2B, 0x00, 0xC3, 0x7F, 0x3F, 0x0C, 0xEC, 0xDC, 0xDC, 0xE3, 0xED,			// 256000
	0xA2, 0x81, 0x26, 0xAF, 0x3F, 0xEE, 0xC8, 0xC7, 0xDB, 0xF2, 0x02, 0x08,			// 500000
	0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1, 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11			// 500
};	

const unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850[11][12]=
{
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
	0x39, 0x2B, 0x00, 0xC3, 0x7F, 0x3F, 0x0C, 0xEC, 0xDC, 0xDC, 0xE3, 0xED,			// 256000
	0xA2, 0x81, 0x26, 0xAF, 0x3F, 0xEE, 0xC8, 0xC7, 0xDB, 0xF2, 0x02, 0x08,			// 500000
	0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1, 0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11			// 500
};	

const unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433[11][12]=
{	
	0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,			// 1200
	0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,			// 2400
	0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00, 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1,			// 4800
	0x03, 0x00, 0x15, 0xFF, 0x00, 0x00, 0xFF, 0xC4, 0x30, 0x7F, 0xF5, 0xB5,			// 9600
	0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00, 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1,			// 19200
	0x03, 0x03, 0x15, 0xF0, 0x3F, 0x00, 0x7E, 0x64, 0x1B, 0xBA, 0x58, 0x0B,			// 38400	
	0xFE, 0x01, 0x15, 0xF0, 0xFF, 0x03, 0x5B, 0x47, 0x0F, 0xC0, 0x6D, 0x25,			// 76800
	0xFE, 0x01, 0x15, 0xF0, 0xFF, 0x03, 0x5B, 0x47, 0x0F, 0xC0, 0x6D, 0x25,			// 115200
	0xF6, 0xFD, 0x15, 0xC0, 0xFF, 0x0F, 0x39, 0x2B, 0x00, 0xC3, 0x7F, 0x3F,			// 256000
	0x07, 0x03, 0x15, 0xFC, 0x0F, 0x00, 0xA2, 0x81, 0x26, 0xAF, 0x3F, 0xEE,			// 500000
	0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00, 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1			// 500
};	

const unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850[11][12]=
{	
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
	0xF6, 0xFD, 0x15, 0xC0, 0xFF, 0x0F, 0x39, 0x2B, 0x00, 0xC3, 0x7F, 0x3F,			// 256000
	0x07, 0x03, 0x15, 0xFC, 0x0F, 0x00, 0xA2, 0x81, 0x26, 0xAF, 0x3F, 0xEE,			// 500000
	0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00, 0xCC, 0xA1, 0x30, 0xA0, 0x21, 0xD1			// 500
};		
const unsigned char RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433[11][12]=
{
	0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,			// 1200
	0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,			// 2400
	0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11, 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00,			// 4800
	0xB8, 0xDE, 0x05, 0x17, 0x16, 0x0C, 0x03, 0x00, 0x15, 0xFF, 0x00, 0x00,			// 9600
	0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11, 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00,			// 19200
	0xDD, 0xCE, 0xD6, 0xE6, 0xF6, 0x00, 0x03, 0x03, 0x15, 0xF0, 0x3F, 0x00,			// 38400
	0xF4, 0xDB, 0xD6, 0xDF, 0xEC, 0xF7, 0xFE, 0x01, 0x15, 0xF0, 0xFF, 0x03,			// 76800
	0xF4, 0xDB, 0xD6, 0xDF, 0xEC, 0xF7, 0xFE, 0x01, 0x15, 0xF0, 0xFF, 0x03,			// 115200
	0x0C, 0xEC, 0xDC, 0xDC, 0xE3, 0xED, 0xF6, 0xFD, 0x15, 0xC0, 0xFF, 0x0F,			// 256000
	0xC8, 0xC7, 0xDB, 0xF2, 0x02, 0x08, 0x07, 0x03, 0x15, 0xFC, 0x0F, 0x00,			// 500000
	0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11, 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00			// 500
};

const unsigned char RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850[11][12]=
{
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
	0x0C, 0xEC, 0xDC, 0xDC, 0xE3, 0xED, 0xF6, 0xFD, 0x15, 0xC0, 0xFF, 0x0F,			// 256000
	0xC8, 0xC7, 0xDB, 0xF2, 0x02, 0x08, 0x07, 0x03, 0x15, 0xFC, 0x0F, 0x00,			// 500000
	0xB9, 0xC9, 0xEA, 0x05, 0x12, 0x11, 0x0A, 0x04, 0x15, 0xFC, 0x03, 0x00			// 500
};

const unsigned char RF_SYNTH_PFDCP_CPFF_7[11][7]=
{
	0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,			// 1200
	0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,			// 2400
	0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,			// 4800
	0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,			// 9600
	0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,			// 19200
	0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03,			// 38400
	0x34, 0x04, 0x0B, 0x04, 0x07, 0x70, 0x03,			// 76800
	0x34, 0x04, 0x0B, 0x04, 0x07, 0x70, 0x03,			// 115200
	0x01, 0x05, 0x0B, 0x05, 0x02, 0x00, 0x03,			// 256000
	0x01, 0x05, 0x0B, 0x05, 0x02, 0x00, 0x03,			// 500000
	0x2C, 0x0E, 0x0B, 0x04, 0x0C, 0x73, 0x03			// 500
};	

const unsigned char RF_POWER_UP_data[] = 			   		{ RF_POWER_UP}; 
const unsigned char RF_FRR_CTL_A_MODE_4_data[] = 		   	{ RF_FRR_CTL_A_MODE_4};
const unsigned char RF_MODEM_AGC_CONTROL_1_data[] = 		{ RF_MODEM_AGC_CONTROL_1};

unsigned char RF_MODEM_MOD_TYPE_12_data[16]={0x11, 0x20, 0x0C, 0x00};
unsigned char RF_MODEM_TX_RAMP_DELAY_8_data[12]={0x11, 0x20, 0x08, 0x18};
unsigned char RF_MODEM_BCR_OSR_1_9_data[13]={0x11, 0x20, 0x09, 0x22};
unsigned char RF_MODEM_AFC_GEAR_7_data[13]={0x11, 0x20, 0x07, 0x2C};
unsigned char RF_MODEM_AGC_WINDOW_SIZE_9_data[13]={0x11, 0x20, 0x09, 0x38};
unsigned char RF_MODEM_OOK_CNT1_11_data[15]={0x11, 0x20, 0x0B, 0x42};
unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[16]={0x11, 0x21, 0x0C, 0x00};
unsigned char RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[16]={0x11, 0x21, 0x0C, 0x0C};
unsigned char RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[16]={0x11, 0x21, 0x0C, 0x18};
unsigned char RF_SYNTH_PFDCP_CPFF_7_data[11]={0x11, 0x23, 0x07, 0x00};	

const unsigned char tx_test_aa_data[14] = {0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa};  // Ã¿Ãë·¢ÉäµÄ¹Ì¶¨ÄÚÈÝµÄ²âÊÔÐÅºÅ£¬µÚ10¸öÊý¾ÝÊÇÇ°9¸öÊý¾ÝµÄÐ£ÑéºÍ
const unsigned char tx_ph_data[14] = {'s','w','w','x',0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x6d};  // Ã¿Ãë·¢ÉäµÄ¹Ì¶¨ÄÚÈÝµÄ²âÊÔÐÅºÅ£¬µÚ10¸öÊý¾ÝÊÇÇ°9¸öÊý¾ÝµÄÐ£ÑéºÍ

typedef struct 
{
	unsigned char reach_1s				: 1;	
	unsigned char is_tx					: 1;
	unsigned char rf_reach_timeout		: 1;
	
// add joyce	
	unsigned char flash					: 1;
	unsigned char key_valid 			: 1;		
	
}FlagType;

FlagType	Flag;

U16	count_1hz, rf_timeout;
U8 spi_read_buf[20];   // ÓÃÓÚ¶ÁÈ¡ SPIÃüÁîµÄ·µ»ØÊý¾ÝÄÚÈÝ
U8 rx_buf[25];

U8 mode;

// add joyce
const unsigned char Tab_DispCode[17]={0x77,0x24,0x6b,0x6d,0x3c,0x5d,0x5f,0x64,0x7f,0x7d,0x7e,0x1f,0x53,0x2f,0x5b,0x5a,0x00};
unsigned char 	dis_ram[28] = {00};

unsigned char	key_value;
unsigned char	have_set;
unsigned char 	set;		// ÉèÖÃÄ£Ê½
unsigned char 	old_mode;
unsigned char 	mode;		 
unsigned char 	freq3;	
unsigned char 	freq2;	
unsigned char 	freq1;		// ÔØ²¨ÆµÂÊ
unsigned char 	power;		// ·¢Éä¹¦ÂÊ
unsigned char 	rssi;		// ½ÓÊÜÐÅºÅÇ¿¶È
unsigned char 	rate;		// ËÙÂÊ

unsigned char	cnt_10s;

unsigned long   tx_cnt = 0,rx_cnt = 0; //ÊÕ·¢´ÎÊý
unsigned char 	reset_mode;

unsigned char 	reach_15hz = 0,reach_flash = 0,reach_1s = 0;
unsigned char 	count_15hz,count_flash = 0,count_1s = 0,nirq_cnt = 0;

void spi_read(U8 data_length, U8 api_command );
void tx_data(void);
void SI4463_init(void);
void sysclk_cfg(void);
void port_init(void);
void timerx_init(void);
void delay_1ms(unsigned int delay_time);
unsigned char spi_byte(unsigned char data);
unsigned char check_cts(void);
void spi_write(unsigned char tx_length, unsigned char *p);
void spi_fast_read( U8 api_command);
void spi_write_fifo(void);
void spi_read_fifo(void);
void sdn_reset(void);
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
void GPIO_SET(unsigned char data);
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

void main()
{ 
	unsigned char  i, j, chksum;
	
	asm("nop");
	asm("nop");
	asm("nop");
	asm("nop");
	asm("nop");
	DI();
	
	sysclk_cfg();	// ÉèÖÃMCUµÄ¹¤×÷Ä£¿é£¬¾§Õñ¹¤×÷Ä£Ê½
	nop_10();
	port_init();	// IO ¿ÚµÄ³õÊ¼»¯
	nop_10();
	
	full_lcd();
	delay_x10ms(200);	// for power on delay
	LED_GREEN = 0;
	LED_RED = 0;
	
	write_address_init();	
	if (flash_cfg[3]>7||flash_cfg[4]>10||flash_cfg[5]>4) 
	{
		config_reset();
		flash_rewrite(flash_cfg);		
	}
	freq3 = flash_cfg[0];
	freq2 = flash_cfg[1];
	freq1 = flash_cfg[2];
	power = flash_cfg[3];
	rate = flash_cfg[4];
	mode = flash_cfg[5];
	old_mode = mode + 1;  
	rssi = 0;
	
	clr_lcd();
	nop_10();
	poweron_dis();
	
/*	
	wdc = 0x9f;
	cspr = 0;	
	pm12 = 1;
	wdtr = 0;
	wdtr = 0xff;
	wdts = 0;
*/	
	
	timerx_init();  // 1ms ¶¨Ê±Æ÷	
	EI();
	asm("nop"); 	
 	
	while(1) 	
	{ 	
	 	asm("nop");
	 	reset_mode=0;
	 	old_mode=mode;
	 	have_set = 0;
	 	sdn_reset();
 		SI4463_init();  // RF Ä£¿é³õÊ¼»¯
	 	tx_cnt=0;
	 	rx_cnt=0;
		dis_tx();
		dis_rx();
	 	asm("nop");
	 	
	 	wdtr = 0;
		wdtr = 0xff;
		
	 	if(mode == master_mode)
	 		tx_data();
	 	if(mode == slave_mode)
	 		rx_init();
	 		
		if((reset_mode==0)&&(mode == tx_test_mode))
		{
			tx_const_aa();
			while(1)
			{
				wdtr = 0;
				wdtr = 0xff;
		
				if((!nIRQ)&&(set==0))
					tx_const_aa();
				
				time_opt();				
				if((mode!=old_mode)&&(set==0))
					break;	
				
				if((have_set)&&(set==0))
					break;
				/*	
				if(GPIO1_TEST)
					break;	
				*/			
			}
			
			LED_GREEN = 0;
			LED_RED = 0;
			reset_mode=1;
		}
				
		if((reset_mode==0)&&(mode == rx_test_mode))		
		{
			rx_init();
			
			while(1)
			{
				wdtr = 0;
				wdtr = 0xff;
				
				time_opt();				
				if((mode!=old_mode)&&(set==0))
					break;	
				
				if((have_set)&&(set==0))
					break;
				/*		
				if(GPIO1_TEST)
					break;
				*/				
			}
			
			LED_GREEN = 0;
			LED_RED = 0;
			reset_mode=1;
		}	
		
		if((reset_mode==0)&&(mode == rf_off))	
		{
			rf_standby();
			
			while(1)
			{
				wdtr = 0;
				wdtr = 0xff;
		
				time_opt();				
				if((mode!=old_mode)&&(set==0))
					break;	
				
				if((have_set)&&(set==0))
					break;						
			}
			
			LED_GREEN = 0;
			LED_RED = 0;
			reset_mode=1;
		}			
		
		if(reset_mode==0)
		{		
			count_1hz = 0;
			Flag.reach_1s = 0;		
			
			while(1)
			{		
				wdtr = 0;
				wdtr = 0xff;
		
				if(Flag.reach_1s)
				{
					Flag.reach_1s = 0;
					if((mode == master_mode)&&(set==0))
						tx_data();		// Ã¿¼ä¸ôÒ»¶ÎÊ±¼ä£¬·¢ÉäÒ»°üÊý¾Ý£¬²¢½ÓÊÕ Acknowledge ÐÅºÅ
				}
				
				if(!Flag.is_tx)
				{
					if(!nIRQ)
					{ 
						clr_interrupt();   // ÇåÖÐ¶Ï,²¢¶Á³öÖÐ¶Ï±êÖ¾	
						
						if((spi_read_buf[4] &0x08) == 0)  // crc error check
						{
							spi_read_fifo();
							fifo_reset();
							
							chksum = 0;
							for(i=4;i<payload_length-1;i++)		// ¼ÆËãChecksum
		        				chksum += rx_buf[i];          	 		
		        					
		     				if(( chksum == rx_buf[payload_length-1] )&&( rx_buf[4] == 0x41 ))  // Ç°Ãæ4¸ö×Ö½ÚÊÇHeader
		     				{
		     					LED_GREEN ^= 1;					// Êý¾ÝÊÕµ½ÁË		     					
		     					rx_cnt++;
		     					dis_rx();
		     						
		     					if((mode == slave_mode)&&(set==0))
		     					{
									delay_1ms(100);  
		     						tx_data();
		     					}	     						 
		        			} 
		        			else
		        				rx_init();     // ÊÕµ½µÄÊý¾Ý²»¶Ô£¬ÔòÒª¼ÌÐø¿ªÊ¼½ÓÊÕ
		        		}
		        		else
		        		{
		        			sdn_reset();
 							SI4463_init();  // RF Ä£¿é³õÊ¼»¯
							rx_init();   // crc error
		        		}			
		        	}	
				}
				
				time_opt();				
				if((mode!=old_mode)&&(set==0))
					break;				
				
				if((have_set)&&(set==0))
					break;
					
				if(GPIO1_TEST)
					break;					
			}
			
			LED_GREEN = 0;
			LED_RED = 0;
			reset_mode=1;
		}	
	}
}

void SI4463_init(void)
{	
	U8 app_command_buf[20],i;
	
	for(i=4;i<16;i++) 
		RF_MODEM_MOD_TYPE_12_data[i] = RF_MODEM_MOD_TYPE_12[rate][i-4];
	if(freq3<8)
	{
		for(i=4;i<12;i++)	
			RF_MODEM_TX_RAMP_DELAY_8_data[i] = RF_MODEM_TX_RAMP_DELAY_8_433[rate][i-4];
		for(i=4;i<11;i++)
			RF_MODEM_AFC_GEAR_7_data[i] = RF_MODEM_AFC_GEAR_7_433[rate][i-4];	
		for(i=4;i<15;i++)
			RF_MODEM_OOK_CNT1_11_data[i] =RF_MODEM_OOK_CNT1_11_433[rate][i-4];
		for(i=4;i<16;i++)
			RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[i] =RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433[rate][i-4];
		for(i=4;i<16;i++)
			RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[i] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433[rate][i-4];
		for(i=4;i<16;i++)
			RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[i] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433[rate][i-4];	
		for(i=4;i<13;i++)
			RF_MODEM_AGC_WINDOW_SIZE_9_data[i] = RF_MODEM_AGC_WINDOW_SIZE_9_433[rate][i-4];
		for(i=4;i<13;i++)	
			RF_MODEM_BCR_OSR_1_9_data[i] = RF_MODEM_BCR_OSR_1_9_433[rate][i-4];	
	}
	else
	{
		for(i=4;i<12;i++)	
			RF_MODEM_TX_RAMP_DELAY_8_data[i] = RF_MODEM_TX_RAMP_DELAY_8_850[rate][i-4];
		for(i=4;i<11;i++)
			RF_MODEM_AFC_GEAR_7_data[i] = RF_MODEM_AFC_GEAR_7_850[rate][i-4];		
		for(i=4;i<15;i++)
			RF_MODEM_OOK_CNT1_11_data[i] =RF_MODEM_OOK_CNT1_11_850[rate][i-4];
		for(i=4;i<16;i++)
			RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[i] =RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850[rate][i-4];
		for(i=4;i<16;i++)
			RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[i] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850[rate][i-4];
		for(i=4;i<16;i++)
			RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[i] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850[rate][i-4];	
		for(i=4;i<13;i++)
			RF_MODEM_AGC_WINDOW_SIZE_9_data[i] = RF_MODEM_AGC_WINDOW_SIZE_9_850[rate][i-4];	
		for(i=4;i<13;i++)	
			RF_MODEM_BCR_OSR_1_9_data[i] = RF_MODEM_BCR_OSR_1_9_850[rate][i-4];	
	}		
	for(i=4;i<11;i++)
		RF_SYNTH_PFDCP_CPFF_7_data[i] = RF_SYNTH_PFDCP_CPFF_7[rate][i-4];
	
	GPIO_SET(mode);
	
	// spi_write(0x05, RF_GLOBAL_XO_TUNE_1_data);   //  ÆµÂÊµ÷Õû
    app_command_buf[0]  = 0x11;  
	app_command_buf[1]  = 0x00;    // 0x0000 
	app_command_buf[2]  = 0x01;    // ¹² 1¸ö²ÎÊý
	app_command_buf[3]  = 0x00;   // 0x0000
	app_command_buf[4]  = 98;  // freq  adjustment
	spi_write(5, app_command_buf);

	// spi_write(0x05, RF_GLOBAL_CONFIG_1_data);  //  *******************************************************
  	app_command_buf[0]  = 0x11;  
	app_command_buf[1]  = 0x00;    // 0x0003 
	app_command_buf[2]  = 0x01;    // ¹² 1¸ö²ÎÊý
	app_command_buf[3]  = 0x03;   // 0x0003
	app_command_buf[4]  = 0x40;  // tx = rx = 64 byte, ÆÕÍ¨ PH£¬high performance mode  ????????????????????? 
	spi_write(5, app_command_buf); 
    
    // *****************************************************************************    
    spi_write(0x08, RF_FRR_CTL_A_MODE_4_data);    // disable all fast response register
     
    // spi_write(0x0D, RF_PREAMBLE_TX_LENGTH_9_data); Ç°µ¼ÂëÉèÖÃ*********************************************   
 	app_command_buf[0]  = 0x11;  
	app_command_buf[1]  = 0x10;    // 0x1000 
	app_command_buf[2]  = 0x09;    // ¹² 9¸ö²ÎÊý
	app_command_buf[3]  = 0x00;   // 0x1000
	
	if(mode == tx_test_mode)
	{
		app_command_buf[4]  = 0xff;   //  ÐèÒª·¢ËÍ255¸ö×Ö½ÚµÄPreamble
	}
	else
	{
		app_command_buf[4]  = 0x08;   //  ÐèÒª·¢ËÍ8¸ö×Ö½ÚµÄPreamble
	}	
	
	//app_command_buf[4]  = 0x08;   //  ÐèÒª·¢ËÍ8¸ö×Ö½ÚµÄPreamble
	app_command_buf[5]   = 0x14;   //Òª¼ì²â20 bit Í¬²½×Ö£¬
	app_command_buf[6]   = 0x00;   // ·Ç±ê×¼µÄpreamble Éè¶¨£¬Ã»ÓÐÓÃ
	app_command_buf[7]   = 0x0f;   // Ç°µ¼ÂëTimeoutµÄÊ±¼ä   ????????????????????????????????????????????????????????????
	app_command_buf[8]   = 0x31;  // Ç°µ¼ÂëµÄ³¤¶ÈÒÔ byte ¼ÆËã£¬ 1st = 1£¬Ã»ÓÐmanchest  ±àÂë£¬Ê¹ÓÃ±ê×¼µÄ 1010.¡£¡£
	app_command_buf[9]   = 0x0;  	//  ·Ç±ê×¼µÄPreambleµÄ Patten 4th byte
	app_command_buf[10]  = 0x00;   //  ·Ç±ê×¼µÄPreambleµÄ Patten 3rd byte
	app_command_buf[11]  = 0x00;  //  ·Ç±ê×¼µÄPreambleµÄ Patten 2nd byte
	app_command_buf[12]  = 0x00;  //  ·Ç±ê×¼µÄPreambleµÄ Patten 1st byte
	spi_write(13, app_command_buf);  // 	
	
	//  RF_SYNC_CONFIG_5_data,  Í¬²½×ÖµÄÉèÖÃ *********************************************
    app_command_buf[0]  = 0x11;  
	app_command_buf[1]  = 0x11;    // command = 0x1100
	app_command_buf[2]  = 0x05;    // ¹² 5¸ö²ÎÊý
	app_command_buf[3]  = 0x00;   // command = 0x1100
	app_command_buf[4]  = 0x01;   //  Í¬²½×ÖÔÚ length field ¶¨Òå²¢·¢ËÍ£¬Í¬²½×Ö²»ÄÜÓÐ´í£¬²»ÊÇ 4FSK£¬ ²»ÊÇmanchest ±àÂë£¬Ö»ÓÐ 2¸ö×Ö½Ú
	
	if(mode == tx_test_mode)
	{
		app_command_buf[5]  = 0x55;   //Í¬²½×Ö 3
		app_command_buf[6]  = 0x55;   // Í¬²½×Ö2 
	}	
	else
	{
		app_command_buf[5]  = 0x2d;   //Í¬²½×Ö 3
		app_command_buf[6]  = 0xd4;   // Í¬²½×Ö2 
	}
	
	app_command_buf[7]  = 0x00;   // Í¬²½×Ö1
	app_command_buf[8]  = 0x00;  // Í¬²½×Ö 0
    spi_write(9, app_command_buf);  //
        
	//  packet crc ÉèÖÃ *******************************************************************        
    app_command_buf[0]  = 0x11;  
	app_command_buf[1]  = 0x12;    // command = 0x1200
	app_command_buf[2]  = 0x01;    // ¹² 1¸ö²ÎÊý
	app_command_buf[3]  = 0x00;   // command = 0x1200
	app_command_buf[4]  = 0x81; //   1ÊÇcRC ÖÖ×Ó£¬CRC = itu-c, enable crc
    spi_write(5, app_command_buf);  
        
	// packet   gernale configuration        
    app_command_buf[0]  = 0x11;  
	app_command_buf[1]  = 0x12;    // command = 0x1206
	app_command_buf[2]  = 0x01;    // ¹² 1¸ö²ÎÊý
	app_command_buf[3]  = 0x06;   // command = 0x1206
	app_command_buf[4]  = 0x02;   //  tx = rx = 120d--1220 (tx packet£¬ph enable, not 4fsk, ÊÕµ½Ò»°üÊý¾Ýºó£¬RX off,CRC ²»·­×ª £¬CRC MSB£¬ data MSB
    spi_write(5, app_command_buf);  
        
  	// spi_write(0x07, RF_PKT_LEN_3_data);   //  ¹Ì¶¨³¤¶È£¬³¤¶ÈÒ»¸ö×Ö½Ú£¬³¤¶ÈÐÅÏ¢Ã»ÓÐÔÚPayloadÀïÃæ
    app_command_buf[0]  = 0x11;  
	app_command_buf[1]  = 0x12;    // command = 0x1208
	app_command_buf[2]  = 0x03;    // ¹² 3¸ö²ÎÊý
	app_command_buf[3]  = 0x08;   // command = 0x1208
	app_command_buf[4]  = 0x00;   //  Length Field = LSB,  length Ö»ÓÐ1¸ö×Ö½Ú£¬length ²»·ÅÔÚ FiFoÀïÃæ£¬¹Ì¶¨°ü³¤Ä£Ê½
	app_command_buf[5]  = 0x00;   //ÓÃÓÚ¿É±ä°ü³¤Ä£Ê½£¬¶¨ÒåÄÄ¸ö Field °üº¬ÁË length Filed
	app_command_buf[6]  = 0x00;   // ÓÃÓÚ¿É±ä°ü³¤Ä£Ê½£¬µ÷Õû¿É±ä°ü³¤µÄ length
    spi_write(7, app_command_buf); 
    
        
	// length Field 1 -- 4 µÄÉèÖÃ 
	app_command_buf[0]   = 0x11;  
	app_command_buf[1]   = 0x12;    // 0x120d 
	app_command_buf[2]   = 0x0c;    // ¹² 12¸ö²ÎÊý
	app_command_buf[3]   = 0x0d;   // 0x120d
	app_command_buf[4]   = 0x00;   //  Field 1 µÄ³¤¶È £¨¸ß4Î»£©
	app_command_buf[5]   = payload_length;   //  field 1 µÄ³¤¶È£¬ £¨µÍ 8Î»), ×Ü¹²14¸ö×Ö½Ú
	app_command_buf[6]   = 0x04;   // field 1 ²»ÊÇ 4FSK£¬manchest, whiting, PN9,   
	app_command_buf[7]   = 0xaa;   // field 1 crc enble, check enbale, ·¢ÉäÒ²ÓÐCRC£¬cRCµÄSeed ºÍCRC_seedÀïÃæµÄÒ»Ñù  
	app_command_buf[8]   = 0x00;  //  field2 µÄ³¤¶È£¨¸ß4Î»£©
	app_command_buf[9]   = 0x00;  	//  field 2 µÄ³¤¶È£¬ £¨µÍ 8Î»)£¬ ³¤¶È = 0 ±íÊ¾Õâ¸öfield Ã»ÓÐÊ¹ÓÃ
	app_command_buf[10]  = 0x00;   // field 2 ²»ÊÇ 4FSK£¬manchest, whiting, PN9
	app_command_buf[11]  = 0x00;  //  field 2 µÄCRCÉèÖÃ
	app_command_buf[12]  = 0x00;  //  field 3 µÄ³¤¶È£¬ £¨µÍ 8Î»)£¬ ³¤¶È = 0 ±íÊ¾Õâ¸öfield Ã»ÓÐÊ¹ÓÃ
	app_command_buf[13]  = 0x00;  	//  field 3 µÄ³¤¶È£¬ £¨µÍ 8Î»)£¬ ³¤¶È = 0 ±íÊ¾Õâ¸öfield Ã»ÓÐÊ¹ÓÃ
	app_command_buf[14]  = 0x00;   //  field 3 ²»ÊÇ 4FSK£¬manchest, whiting, PN9
	app_command_buf[15]  = 0x00;  //  field 3 µÄCRCÉèÖÃ
	spi_write(16, app_command_buf);  // 
  
    // spi_write(0x0C, RF_PKT_FIELD_4_LENGTH_12_8_8_data);  **************************************
    app_command_buf[0]   = 0x11;  
	app_command_buf[1]   = 0x12;    // 0x1219 
	app_command_buf[2]   = 0x08;    // ¹² 8¸ö²ÎÊý
	app_command_buf[3]   = 0x19;   // 0x1219
	app_command_buf[4]   = 0x00;   //  field4 µÄ³¤¶È£¨¸ß4Î»£©
	app_command_buf[5]   = 0x00;   //  field 4 µÄ³¤¶È£¬ £¨µÍ 8Î»)£¬ ³¤¶È = 0 ±íÊ¾Õâ¸öfield Ã»ÓÐÊ¹ÓÃ
	app_command_buf[6]   = 0x00;   //   field 4 ²»ÊÇ 4FSK£¬manchest, whiting, PN9
	app_command_buf[7]   = 0x00;   // field 4 µÄCRCÉèÖÃ
	app_command_buf[8]   = 0x00;  //  field5 µÄ³¤¶È£¨¸ß4Î»£©
	app_command_buf[9]   = 0x00;  	//   field 5 µÄ³¤¶È£¬ £¨µÍ 8Î»)£¬ ³¤¶È = 0 ±íÊ¾Õâ¸öfield Ã»ÓÐÊ¹ÓÃ
	app_command_buf[10]  = 0x00;   //  field 5 ²»ÊÇ 4FSK£¬manchest, whiting, PN9
	app_command_buf[11]  = 0x00;   // field 5 µÄCRCÉèÖÃ
    spi_write(12, app_command_buf);  //
    
    // ********************************************************************************
    spi_write(0x10, RF_MODEM_MOD_TYPE_12_data);   // //  2FSK ,  module source = PH fifo, disable manchest, tx, rx ²»·­×ª£¬ deviation ²»·­×ª
        
	//spi_write(0x05, RF_MODEM_FREQ_DEV_0_1_data); **************************************
    app_command_buf[0] = 0x11;  
	app_command_buf[1]  = 0x20;    // 0x200c                                                         
	app_command_buf[2]  = 0x01;    // ¹² 1¸ö²ÎÊý                                                     
	app_command_buf[3]  = 0x0c;   // 0x200c                                                          
	//app_command_buf[4]  = 0x4f; // frequency deviation µÄBit 0--7, ¸ù¾ÝWDS²úÉú
	if(freq3<8)
	{
		if(rate>=dr_256k)
			app_command_buf[4]  = 0x4f;
		else if(rate>=dr_19p2)
			app_command_buf[4]  = 0x5e;
		else
		    app_command_buf[4]  = 0xd2;   
	}
	else
	{
		if(rate>=dr_115p2)
			app_command_buf[4]  = 0x69;	// 15k
		else if(rate>=dr_19p2)
			app_command_buf[4]  = 0x5e;	// 10k
		else
		    app_command_buf[4]  = 0x18; // 8k
	}	  
    spi_write(5, app_command_buf);  
        
    // ********************************************************************************    
    spi_write(0x0C, RF_MODEM_TX_RAMP_DELAY_8_data);    	// Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
    spi_write(0x0D, RF_MODEM_BCR_OSR_1_9_data);			// Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
    spi_write(0x0B, RF_MODEM_AFC_GEAR_7_data);			// Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
    spi_write(0x05, RF_MODEM_AGC_CONTROL_1_data);		// Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
    spi_write(0x0D, RF_MODEM_AGC_WINDOW_SIZE_9_data);	// Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
    spi_write(0x0F, RF_MODEM_OOK_CNT1_11_data);			// Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª   
    
	// spi_write(0x05, RF_MODEM_RSSI_COMP_1_data);	**************************************************
	app_command_buf[0] = 0x11;  
	app_command_buf[1] = 0x20;    // 0x204e                                                         
	app_command_buf[2] = 0x01;    // ¹² 1¸ö²ÎÊý                                                     
	app_command_buf[3] = 0x4e;   // 0x204e 
	if(rate==dr_500)
		app_command_buf[4]  = 0x3a; 
	else                                                         
		app_command_buf[4]  = 0x40;  //  rssi ¶ÁÊýÆ«²î£¬ÓëÕæÊµÖµµÄ²îÖµ
    spi_write(5, app_command_buf);
            	     
    // ********************************************************************************    
    spi_write(0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data);  // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
    spi_write(0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data);   // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
    spi_write(0x10, RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data);   // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª        
        
	// RF_PA **************************************************************************
	app_command_buf[0] = 0x11;  
	app_command_buf[1]  = 0x22;    // 0x2200                                                         
	app_command_buf[2]  = 0x04;    // ¹² 4¸ö²ÎÊý                                                     
	app_command_buf[3]  = 0x00;   // 0x2200                                                          
	app_command_buf[4]  = 0x08;  //0x10;   //   PA mode  = default , Ê¹ÓÃClass E Ä£Ê½£¬¶ø²»ÊÇ Switch Current Ä£Ê½  ????????
	if(power==7)	
		app_command_buf[5]  = 127;   //  ÉèÖÃÎª×î´ó¹¦ÂÊ
	else if(power==6)
		app_command_buf[5]  = 50;
	else if(power==5)
		app_command_buf[5]  = 30;
	else if(power==4)
		app_command_buf[5]  = 20;
	else if(power==3)
		app_command_buf[5]  = 15;
	else if(power==2)
		app_command_buf[5]  = 10;
	else if(power==1)
		app_command_buf[5]  = 7;					
	else	
		app_command_buf[5]  = 4;		
	app_command_buf[6]  =0x00; //???????? 0x00;   // CLK duty = 50%£¬ ÆäËû = Default
	if((rate<=dr_115p2)||(rate==dr_500))
		app_command_buf[7]  = 0x3d;  // ???????? 0x5d;   // PA ramp time = default 
    else
    	app_command_buf[7]  = 0x5d;    
    spi_write(8, app_command_buf);        
    
    // ********************************************************************************     
	spi_write(0x0B, RF_SYNTH_PFDCP_CPFF_7_data);      // Ã»ÓÐÕâ¸ö²ÎÊý£¬²»ÐèÒª
        
   	// header match ******************************************************************
   	app_command_buf[0] = 0x11;  
	app_command_buf[1]  = 0x30;    // 0x3000                                                         
	app_command_buf[2]  = 0x0c;    // ¹² 12¸ö²ÎÊý                                                     
	app_command_buf[3]  = 0x00;   // 0x3000                                                          
	app_command_buf[4]  = 's';    //0x00;   //  match 1 µÄÖµ
	app_command_buf[5]  = 0xff;   //  match 1 mask
	app_command_buf[6]  = 0x40;   // eable match 1, match 1µÄÖµÓëÍ¬²½×ÖµÄÏà¾àµÄ¾àÀë, 0 = match 
	app_command_buf[7]  = 'w';    //  match 2 µÄÖµ                                        
	app_command_buf[8]  = 0xff;   //  match 2 mask                                        
	app_command_buf[9]  = 0x01;   // enable match 2, match 2µÄÖµÓëÍ¬²½×ÖµÄÏà¾àµÄ¾àÀë  , and function   
	app_command_buf[10] = 'w';   //     match 3 µÄÖµ                                        
	app_command_buf[11]  =0xff;;    //  match 3 mask                                        
	app_command_buf[12]  =0x02;;    // enable match 3, match 3µÄÖµÓëÍ¬²½×ÖµÄÏà¾àµÄ¾àÀë    and function 
	app_command_buf[13]  = 'x';    //   match 4 µÄÖµ                                        
	app_command_buf[14]  = 0xff;   //   match 4 mask                                        
	app_command_buf[15]  = 0x03;   //  enable match 4, match 4µÄÖµÓëÍ¬²½×ÖµÄÏà¾àµÄ¾àÀë    and function 
        spi_write(16, app_command_buf); 
        
	rf_init_freq();
}        

void GPIO_SET(unsigned char data)
{
	U8 app_command_buf[7];
	
	app_command_buf[0] = 0x13;     // gpio ÉèÖÃ
	
	switch(data)
	{
		case tx_normal:
		case rx_normal:
			app_command_buf[1]  = 3; 		// GPIO0=1
			app_command_buf[2]  = 2;		// GPIO1=0
		break;
		
		case tx_test:
			app_command_buf[1]  = 3; 		// GPIO0=1
			app_command_buf[2]  = 3;		// GPIO1=1
		break;
		
		case rx_test:
			app_command_buf[1]  = 2; 		// GPIO0=0
			app_command_buf[2]  = 20;		// GPIO1=RX DATA
		break;
		
		case rf_off:
			app_command_buf[1]  = 2; 		// GPIO0=0
			app_command_buf[2]  = 2;		// GPIO1=0
		break;			 
	}
	
	app_command_buf[3]  = 0x21;  //0x20;   //  gpio2, h = tx mode
	app_command_buf[4]  = 0x20; // 0x14;  //   gpio3 
	app_command_buf[5]  = 0x27;   // nIRQ
	app_command_buf[6]  = 0x0b;  // sdo
	spi_write(7, app_command_buf);	
}

void fifo_reset(void)
{
	U8 p[2];
	
	p[0] = FIFO_INFO;
	p[1] = 0x03;   // reset tx ,rx fifo
	spi_write(2,p);
}	

void clr_interrupt(void)
{
	U8 p[4];
	
	p[0] = GET_INT_STATUS;
	p[1] = 0;   // clr  PH pending
	p[2] = 0;   // clr modem_pending
	p[3] = 0;   // clr chip pending
	spi_write(4,p);
	spi_read(9,GET_INT_STATUS); 
}
	
void enable_rx_interrupt(void)
{
	U8 p[7];

	p[0] = 0x11;
	p[1] = 0x01;  // 0x0100
	p[2] = 0x03;  // 3¸ö²ÎÊý
	p[3] = 0x00;   // 0100
	p[4] = 0x03;   // ph, modem int
	p[5] = 0x18; // 0x10;   // Pack received int
	p[6] = 0x00;   //preamble int, sync int setting	
	spi_write(0x07, p);  // enable  packet receive interrupt	
}	

void enable_tx_interrupt(void)
{	
	U8 p[6];

	p[0] = 0x11;
	p[1] = 0x01;  // 0x0100
	p[2] = 0x02;   // 2¸ö²ÎÊý
	p[3] = 0x00;  // 0x0100
	p[4] = 0x01;   // Ph  int
	p[5] = 0x20; //  enable  packet sent interrupt	
	spi_write(0x06, p);  // enable  packet receive interrupt	
}	

void rf_standby(void)
{
	U8 p[2];
	
	p[0] = CHANGE_STATE ; 	// CHANGE_STATE ÃüÁî
	p[1] = 0x01 ; 			// sleep mode
	spi_write(2, p);  
} 

void tx_start(void)
{
	U8 p[5];
	
	p[0] = START_TX ; // start ÃüÁî
	p[1] = freq_channel ; // channel 0
	p[2] = 0x30; // ·¢ÉäÍêºó»Øµ½ ReadyÄ£Ê½£¬ ²»ÖØ·¢£¬Á¢¼´·¢Éä
	p[3] = 0;
	p[4] = 0; //payload_length; // ×Ü¹²Òª·¢Éä10¸ö×Ö½Ú	
	spi_write(5, p);  
} 

void rx_start(void)
{
	U8 p[8];
	
	p[0] = START_RX ; // start ÃüÁî
	p[1] = freq_channel ; // channel 0
	p[2] = 0x00; // Á¢¼´½øÈë½ÓÊÕÄ£Ê½
	p[3] = 0;
	p[4] = 0;// payload_length; // ×Ü¹²Òª½ÓÊÕ10¸ö×Ö½Ú
	p[5] = 0;  // unchanged after preamble timeout 
	//p[6] = 0x03;  // ready after valid packet received
	//p[7] = 0x0;  // unchanged after invalid packet received 	
	p[6] = 0x08;  
	p[7] = 0x08;   	
	spi_write(8, p);  
}

void rx_start_test(void)
{
	U8 p[8];
	
	LED_GREEN = 1;
	
	p[0] = START_RX ; // start ÃüÁî
	p[1] = freq_channel ; // channel 0
	p[2] = 0x00; // Á¢¼´½øÈë½ÓÊÕÄ£Ê½
	p[3] = 0;
	//p[4] = payload_length; // ×Ü¹²Òª½ÓÊÕ10¸ö×Ö½Ú
	p[4] = 0;
	p[5] = 0;  // unchanged after preamble timeout 
	//p[6] = 0x0;  // unchanged mode if valid packet received
	//p[7] = 0x0;  // unchanged mode if unvalid packet received	
	p[6] = 0x08;  
	p[7] = 0x08;  
	spi_write(8, p);  
}
	
void rx_init(void)
{
	Flag.is_tx = 0;
	fifo_reset();  // »º³åÆ÷Çå¿Õ			
	enable_rx_interrupt();	
	clr_interrupt();  // ÇåÖÐ¶ÏFactor	
	
	if(mode == rx_test_mode)
		rx_start_test();
	else
		rx_start();    // ½øÈë½ÓÊÕÄ£Ê½,½ÓÊÕµ½Êý¾Ýºó£¬»Øµ½ReadyÄ£Ê½
}	

void tx_data(void)
{	
	unsigned char i;
	
	Flag.is_tx = 1;
	LED_RED ^= 1;
	fifo_reset();  // »º³åÆ÷Çå¿Õ	
	spi_write_fifo();  // Íù»º³åÇøÌîÊý¾Ý			
	enable_tx_interrupt();	
	clr_interrupt();  // ÇåÖÐ¶ÏFactor	
	tx_start();    // ½øÈë·¢ÉäÄ£Ê½, ¿ªÊ¼·¢Éä	
	rf_timeout = 0;
	Flag.rf_reach_timeout = 0;
	
	while(nIRQ)		// µÈ´ýÖÐ¶Ï
	{
		wdtr = 0;
		wdtr = 0xff;		
		if(Flag.rf_reach_timeout)
		{
			sdn_reset();
 			SI4463_init();  // RF Ä£¿é³õÊ¼»¯
			break;		// ÔòÇ¿ÖÆÌø³ö
		}			
	}
	
	tx_cnt++;
	dis_tx();	
  	rx_init();		//rf ·¢ÉäÍê³É£¬½øÈë½ÓÊÕÄ£Ê½
}

void tx_const_aa(void)
{
	unsigned char i;
	
	LED_RED = 1;
	fifo_reset();  // »º³åÆ÷Çå¿Õ	
	spi_write_fifo();  // Íù»º³åÇøÌîÊý¾Ý			
	enable_tx_interrupt();	
	clr_interrupt();  // ÇåÖÐ¶ÏFactor	
	tx_start();    // ½øÈë·¢ÉäÄ£Ê½, ¿ªÊ¼·¢Éä	
	rf_timeout = 0;
	Flag.rf_reach_timeout = 0;
	
	while(nIRQ)		// µÈ´ýÖÐ¶Ï
	{
		wdtr = 0;
		wdtr = 0xff;		
	/*	if(Flag.rf_reach_timeout)
		{
			sdn_reset();
 			SI4463_init();  // RF Ä£¿é³õÊ¼»¯
			break;		// ÔòÇ¿ÖÆÌø³ö
		}*/			
	}	
}

unsigned char spi_byte(unsigned char data)
{
	unsigned char i;
	
	for (i = 0; i < 8; i++)		// ¿ØÖÆSCK ºÍ SDI£¬·¢ÉäÒ»¸ö×Ö½ÚµÄÃüÁî£¬Í¬Ê±¶ÁÈ¡1¸ö×Ö½ÚµÄÊý¾Ý
	{				// Ã»ÓÐ°üÀ¨nSELµÄ¿ØÖÆ
		if (data & 0x80)
			SDI = 1;
		else
			SDI = 0;
			
		data <<= 1;
		SCK = 1;
		
		if (SDO)
			data |= 0x01;
		else
			data &= 0xfe;
			
		SCK = 0;
	}	
	return (data);	
}

void spi_write(unsigned char tx_length, unsigned char *p)
{
	unsigned char i,j;
	
	i = 0;
	while(i!=0xff)
		i = check_cts();
	
	SCK = 0;
	nSEL = 0;
	
	for (i = 0; i < tx_length; i++) 
	{
		j = *(p+i);
		spi_byte(j);
	}
	
	nSEL = 1;	
}

U8 check_cts(void)			// Õâ¸öÃüÁî¸úÔÚÃüÁîºóÃæ£¬¶ÁÈ¡response
{
	U8 i;
   
	nSEL = 1;   
	SCK = 0;
	nSEL = 0;
	spi_byte(0x44);
	i = spi_byte(0);
	nSEL = 1;
	return (i);
}	

void spi_read(U8 data_length, U8 api_command )
{
	U8 i;
	
	U8 p[1];
	p[0] = api_command;
	i = 0;
	while(i!=0xff)
		i = check_cts();		// ¼ì²éÊÇ·ñ¿ÉÒÔ·¢ÃüÁî
		
	spi_write(1, p);    // ·¢ÃüÁî
	
	i = 0;
	while(i!=0xff)
		i = check_cts();	//¼ì²éÊÇ·ñ¿ÉÒÔ¶ÁÊý¾ÝÁË
		
	nSEL = 1;   
	SCK = 0;
	nSEL = 0;
	spi_byte(0x44);
	for (i = 0; i< data_length; i++)	// ¶ÁÊý¾Ý
		spi_read_buf[i] = spi_byte(0xff);
	nSEL = 1;
}	

void spi_fast_read( U8 api_command)
{
	U8 i,p[1];
	
	p[0] = api_command;
	i = 0;
	while(i!=0xff)
		i = check_cts();		// ¼ì²éÊÇ·ñ¿ÉÒÔ·¢ÃüÁî
		
	nSEL = 1;   
	SCK = 0;
	nSEL = 0;
	spi_byte(api_command);    // ·¢ÃüÁî
	for (i = 0; i< 4; i++)
		spi_read_buf[i] = spi_byte(0xff);   // ½«4¸ö¼Ä´æÆ÷µÄÖµÈ«²¿¶¼¶Á³öÀ´
	nSEL = 1;
}		

void spi_write_fifo(void)
{
	U8 i;
	
	i = 0;
	while(i!=0xff)
		i = check_cts();		// ¼ì²éÊÇ·ñ¿ÉÒÔ·¢ÃüÁî
	nSEL = 1;   
	SCK = 0;
	nSEL = 0;
	spi_byte(WRITE_TX_FIFO);    
	
	if(mode == tx_test_mode)
	{
		for (i = 0; i< payload_length; i++)
		{
			spi_byte(tx_test_aa_data[i]);   // ·¢ËÍ10¸ö²âÊÔÊý¾Ý
		}
	}	
	else
	{
		for (i = 0; i< payload_length; i++)
		{
			spi_byte(tx_ph_data[i]);
		}	
	}
	nSEL = 1;
}	

void spi_read_fifo(void)
{
	U8 i;
	
	i = 0;
	while(i!=0xff)
		i = check_cts();		// ¼ì²éÊÇ·ñ¿ÉÒÔ·¢ÃüÁî
		
	nSEL = 1;   
	SCK = 0;
	nSEL = 0;
	spi_byte(READ_RX_FIFO);    
	for (i = 0; i< payload_length; i++)
		rx_buf[i] = spi_byte(0xff);   // ½ÓÊÕ10¸ö²âÊÔÊý¾Ý
	nSEL = 1;
}	

void sdn_reset(void)
{	
	U8 i;
	
 	SDN = 1;
 	delay_1ms(2);	// RF Ä£¿é¸´Î» 	
 	SDN = 0;
 	delay_1ms(10);	// ÑÓÊ±10ms RF Ä£¿é½øÈë¹¤×÷×´Ì¬
 
 	nSEL = 1;   
	SCK = 0;
	nSEL = 0;
	for (i = 0; i< 7; i++)
		spi_byte(RF_POWER_UP_data[i]);   // ·¢ËÍpower up ÃüÁî
	nSEL = 1;
 
 	delay_1ms(20);	// ÑÓÊ±20ms RF Ä£¿é½øÈë¹¤×÷×´Ì¬, µ«ÊÇºóÃæ»¹ÊÇÒªÅÐ¶Ï CTS, ´ËÑÓÊ±¿ÉÒÔÈ¥µô 	
}	
// song end 




// joyce add

//*****************************************************
//******************* key function ********************
//*****************************************************
unsigned char scan_key()
{
	unsigned char key_value;
	unsigned char temp;
	
	key_value = p1 & 0x07;
	nop_10();
	temp = p1 & 0x07;
	
	if(key_value != temp)
	{
		Flag.key_valid = 0;
		return 0;	
	}		
	
	if(key_value == NOP_KEY)
	{
		Flag.key_valid = 1;
		return 7;	
	}	
	
	if(Flag.key_valid == 0)
		return 0;
	
	return key_value;
}
//-------------------------------------------
void key_opt(unsigned char key)
{
	asm("NOP");
	
	if(!Flag.key_valid)
		return;
		
	switch(key)
	{
		case NOP_KEY:			// key release
		{
			Flag.key_valid = 1;	// set key valid flag
			break;
		}		

		case SET_KEY:			// key set
		{				
			count_flash = 0;
			reach_flash = 0;
			Flag.flash = 1;	
			cnt_10s = 10;
			
			if(set == 0)
			{	
				LED_RED = 0;
				LED_GREEN = 0;
				have_set = 1;
				set = set_freq3;				
				dis_freq();
			}	
			else if(set == set_trmode)
			{
				set = 0;	// last set item
				poweron_dis();
				flash_copy();
				flash_rewrite(flash_cfg);
				SI4463_init();  // RF Ä£¿é³õÊ¼»¯
				
				if(mode==rx_test_mode)
					rx_init();
					
				delay_x10ms(1);	
			}	
			else
			{	
				set++;	// change set item		
				count_flash = 0;
				reach_flash = 0;
				Flag.flash = 1;	
				dis_freq();
				dis_power();
				dis_dr();
				dis_mode();
			}									
			
			dis_sign();
			
			Flag.key_valid = 0;	// after valid opt,clr flag,wait key NOP
			
			break;
		}
			
		case UP_KEY:			// ket change
		{	
						
			count_flash = 0;
			reach_flash = 0;
			Flag.flash = 1;	
			cnt_10s = 10;
			
			switch(set)
			{
				case 	0:
					break;
						
				case	set_freq3:
									
					if(freq3 == 9)
						freq3 = 0;
					else
						freq3++;
					
					dis_freq();			
				break;
					
				case	set_freq2:
					if(freq2 == 9)
						freq2 = 0;
					else
						freq2++;
									
					dis_freq();
				break;
					
				case	set_freq1:
					if(freq1 == 9)
						freq1 = 0;
					else
						freq1++;
					
					dis_freq();
				break;	
					
				case 	set_power:	
				{
					if(power == 7)
						power = 0;
					else
						power += 1;
						
					dis_power();	
					break;		
				}	
					
				case	set_dr:
				{
					//if(rate == dr_500)
					if(rate == dr_500k)
						rate = dr_1p2;
					else
						rate += 1;
						
					dis_dr();	
					dis_fd();
					dis_bw();
					break;				
				}	
					
				case	set_trmode:
				{
					if(mode == rf_off)
						mode = tx_normal;
					else
						mode++;
						
					dis_mode();	
					break;				
				}			
			}				
		
			Flag.key_valid = 0;
			
			break;
		}
		
		case	DOWN_KEY:			
		{	
			
			count_flash = 0;
			reach_flash = 0;
			Flag.flash = 1;	
			cnt_10s = 10;
			
			switch(set)
			{
				case 	0:
					break;
						
				case	set_freq3:
					if(freq3 == 0)
						freq3 = 9;
					else
						freq3--;
						
					dis_freq();			
				break;
					
				case	set_freq2:
					if(freq2 == 0)
						freq2 = 9;
					else
						freq2--;
									
					dis_freq();
					
				break;	
					
				case	set_freq1:
					if(freq1 == 0)
						freq1 = 9;
					else
						freq1--;
								
					dis_freq();
				break;
					
				case 	set_power:	
				{
					if(power == 0)
						power = 7;
					else
						power -= 1;
						
					dis_power();	
					break;		
				}	
					
				case	set_dr:
				{
					if(rate == dr_1p2)
						//rate = dr_500;
						rate = dr_500k;
					else
						rate -= 1;
						
					dis_bw();
					dis_fd();
					dis_dr();	
					break;				
				}	
					
				case	set_trmode:
				{
					if(mode == tx_normal)
						mode = rf_off;
					else
						mode--;
						
					dis_mode();	
					break;				
				}			
			}				
		
			Flag.key_valid = 0;
			
			break;
		}
			
		default:				// other key invalid!
		{	
			Flag.key_valid = 0;
			break;
		}		
	}	
}

//*****************************************************
//****************** DISPLAY FUNCTION *****************
//*****************************************************

void full_lcd()
{
	unsigned char i;
	
	wr_cmd(0x0802);
	wr_cmd(0x0806);
	wr_cmd(0x0830);
	wr_cmd(0x09c6);
	
	for(i=0;i<28;i++)
		dis_ram[i] = 0xff;
		
	wr_data(0x00,56);	
}	

void clr_lcd()
{
	unsigned char i;
	
	for(i=0;i<28;i++)
		dis_ram[i] = 0;
		
	wr_data(0x00,56);	
}

void poweron_dis()
{
	count_flash = 0;
	reach_flash = 0;	
	Flag.flash = 1;
	nop_10();
	dis_freq();
	dis_power();
	dis_rssi();
	dis_dr();
	dis_fd();
	dis_bw();
	dis_tx();
	dis_rx();
	dis_mode();
	dis_sign();	
}	
//-------------------------------------------
void dis_freq()
{
	dis_ram[8] = dis_ram[8] & 0x80;
	dis_ram[9] = dis_ram[9] & 0x80;
	dis_ram[10] = dis_ram[10] & 0x80;
	dis_ram[11] = dis_ram[11] & 0x80;
	dis_ram[11] = dis_ram[11] | Tab_DispCode[5];
	
	if((set == set_freq3) && (!Flag.flash))
	{
		dis_ram[8] = dis_ram[8] | Tab_DispCode[0x10];
		dis_ram[9] = dis_ram[9] | Tab_DispCode[freq2];
		dis_ram[10] = dis_ram[10] | Tab_DispCode[freq1];
	}	
	else if	((set == set_freq2) && (!Flag.flash))
	{	
		dis_ram[8] = dis_ram[8] | Tab_DispCode[freq3];
		dis_ram[9] = dis_ram[9] | Tab_DispCode[0x10];
		dis_ram[10] = dis_ram[10] | Tab_DispCode[freq1];
	}	
	else if	((set == set_freq1) && (!Flag.flash))
	{	
		dis_ram[8] = dis_ram[8] | Tab_DispCode[freq3];
		dis_ram[9] = dis_ram[9] | Tab_DispCode[freq2];
		dis_ram[10] = dis_ram[10] | Tab_DispCode[0x10];			
	}	
	else
	{	
		dis_ram[8] = dis_ram[8] | Tab_DispCode[freq3];
		dis_ram[9] = dis_ram[9] | Tab_DispCode[freq2];
		dis_ram[10] = dis_ram[10] | Tab_DispCode[freq1];
	}	
			
	wr_data(0x08,8);
}

//-------------------------------------------	
void dis_power()
{
	dis_ram[12] = dis_ram[12] & 0x80;
	if((!Flag.flash) && (set == set_power))
		dis_ram[12] = dis_ram[12] | Tab_DispCode[0x10];
		
	else
		dis_ram[12] = dis_ram[12] | Tab_DispCode[power];
		
	wr_data(0x0c,2);
}

//-------------------------------------------	
void dis_dr()
{
	dis_ram[24] = dis_ram[24] & 0x80;
	dis_ram[25] = dis_ram[25] & 0x80;
	dis_ram[26] = dis_ram[26] & 0x80;
		
	if((!Flag.flash) && (set == set_dr))
	{
		dis_ram[24] = dis_ram[24] | Tab_DispCode[0x10];
		dis_ram[25] = dis_ram[25] | Tab_DispCode[0x10];
		dis_ram[26] = dis_ram[26] | Tab_DispCode[0x10];
	}
	
	else
	{
		switch(rate)
		{
			case	dr_500:
			{
				dis_ram[24] = dis_ram[24] | Tab_DispCode[0x10];
				dis_ram[25] = dis_ram[25] | Tab_DispCode[0];
				dis_ram[26] = dis_ram[26] | Tab_DispCode[5];
				break;
			}
			
			case	dr_1p2:
			{
				dis_ram[24] = dis_ram[24] | Tab_DispCode[0x10];
				dis_ram[25] = dis_ram[25] | Tab_DispCode[1];
				dis_ram[26] = dis_ram[26] | Tab_DispCode[2];
				break;
			}
			
			case	dr_2p4:
			{
				dis_ram[24] = dis_ram[24] | Tab_DispCode[0x10];
				dis_ram[25] = dis_ram[25] | Tab_DispCode[2];
				dis_ram[26] = dis_ram[26] | Tab_DispCode[4];
				break;
			}
			
			case	dr_4p8:
			{
				dis_ram[24] = dis_ram[24] | Tab_DispCode[0x10];
				dis_ram[25] = dis_ram[25] | Tab_DispCode[4];
				dis_ram[26] = dis_ram[26] | Tab_DispCode[8];
				break;
			}
			
			case	dr_9p6:
			{
				dis_ram[24] = dis_ram[24] | Tab_DispCode[0x10];
				dis_ram[25] = dis_ram[25] | Tab_DispCode[9];
				dis_ram[26] = dis_ram[26] | Tab_DispCode[6];
				break;
			}
			
			case	dr_19p2:
			{
				dis_ram[24] = dis_ram[24] | Tab_DispCode[1];
				dis_ram[25] = dis_ram[25] | Tab_DispCode[9];
				dis_ram[26] = dis_ram[26] | Tab_DispCode[2];
				break;
			}
			
			case	dr_38p4:
			{
				dis_ram[24] = dis_ram[24] | Tab_DispCode[3];
				dis_ram[25] = dis_ram[25] | Tab_DispCode[8];
				dis_ram[26] = dis_ram[26] | Tab_DispCode[4];
				break;
			}
			
			case	dr_76p8:
			{
				dis_ram[24] = dis_ram[24] | Tab_DispCode[7];
				dis_ram[25] = dis_ram[25] | Tab_DispCode[6];
				dis_ram[26] = dis_ram[26] | Tab_DispCode[8];
				break;
			}
			
			case	dr_115p2:
			{
				dis_ram[24] = dis_ram[24] | Tab_DispCode[1];
				dis_ram[25] = dis_ram[25] | Tab_DispCode[1];
				dis_ram[26] = dis_ram[26] | Tab_DispCode[5];
				break;
			}
			
			case	dr_256k:
			{
				dis_ram[24] = dis_ram[24] | Tab_DispCode[2];
				dis_ram[25] = dis_ram[25] | Tab_DispCode[5];
				dis_ram[26] = dis_ram[26] | Tab_DispCode[6];
				break;
			}
			
			case	dr_500k:
			{
				dis_ram[24] = dis_ram[24] | Tab_DispCode[5];
				dis_ram[25] = dis_ram[25] | Tab_DispCode[0];
				dis_ram[26] = dis_ram[26] | Tab_DispCode[0];
				break;
			}
		}		
	}	
		
	wr_data(0x18,6);	
}

//-------------------------------------------	
void dis_fd()
{
	dis_ram[21] = dis_ram[21] & 0x80;
	dis_ram[22] = dis_ram[22] & 0x80;
	dis_ram[23] = dis_ram[23] & 0x80;
	
	if(!Flag.flash)
	{
		dis_ram[21] = dis_ram[21] | Tab_DispCode[0x10];
		dis_ram[22] = dis_ram[22] | Tab_DispCode[0x10];
		dis_ram[23] = dis_ram[23] | Tab_DispCode[0x10];
	}
	
	else
	{		
		if(freq3<8)	
		{
		if((rate == dr_500)||(rate < dr_19p2))
		{
			dis_ram[21] = dis_ram[21] | Tab_DispCode[0x10];	
			dis_ram[22] = dis_ram[22] | Tab_DispCode[3];
			dis_ram[23] = dis_ram[23] | Tab_DispCode[0];
		}	
		
		else if(rate < dr_256k)
		{
			dis_ram[21] = dis_ram[21] | Tab_DispCode[0x10];	
			dis_ram[22] = dis_ram[22] | Tab_DispCode[5];
			dis_ram[23] = dis_ram[23] | Tab_DispCode[0];
		}
		else
		{
			dis_ram[21] = dis_ram[21] | Tab_DispCode[1];	
			dis_ram[22] = dis_ram[22] | Tab_DispCode[0];
			dis_ram[23] = dis_ram[23] | Tab_DispCode[0];
		}		
		}
		else
		{
			if((rate == dr_500)||(rate < dr_19p2))
			{
				dis_ram[21] = dis_ram[21] | Tab_DispCode[0x10];	
				dis_ram[22] = dis_ram[22] | Tab_DispCode[8];
				dis_ram[23] = dis_ram[23] | Tab_DispCode[0];
			}	
		
			else if(rate < dr_115p2)
			{
				dis_ram[21] = dis_ram[21] | Tab_DispCode[1];	
				dis_ram[22] = dis_ram[22] | Tab_DispCode[0];
				dis_ram[23] = dis_ram[23] | Tab_DispCode[0];
			}
			else
			{
				dis_ram[21] = dis_ram[21] | Tab_DispCode[1];	
				dis_ram[22] = dis_ram[22] | Tab_DispCode[5];
				dis_ram[23] = dis_ram[23] | Tab_DispCode[0];
			}
		}
	}	
	
	wr_data(0x15,6);
}

//-------------------------------------------	
void dis_bw()
{	
	dis_ram[18] = dis_ram[18] & 0x80;		// Ð¡Êýµã
	dis_ram[19] = dis_ram[19] & 0x80;
	dis_ram[20] = dis_ram[20] & 0x80;
	
	if(!Flag.flash)
	{
		dis_ram[18] = dis_ram[18] | Tab_DispCode[0x10];
		dis_ram[19] = dis_ram[19] | Tab_DispCode[0x10];
		dis_ram[20] = dis_ram[20] | Tab_DispCode[0x10];
	}
	
	else
	{
		switch(rate)
		{
			case dr_500:
			case dr_1p2:
			case dr_2p4:
			case dr_9p6:
				dis_ram[18] = dis_ram[18] | Tab_DispCode[2];	
				dis_ram[19] = dis_ram[19] | Tab_DispCode[5];
				dis_ram[20] = dis_ram[20] | Tab_DispCode[8];
			break;	
				
			case dr_4p8:
				dis_ram[18] = dis_ram[18] | Tab_DispCode[2];	
				dis_ram[19] = dis_ram[19] | Tab_DispCode[3];
				dis_ram[20] = dis_ram[20] | Tab_DispCode[2];
			break;	
				
			case dr_19p2:
				dis_ram[18] = dis_ram[18] | Tab_DispCode[3];	
				dis_ram[19] = dis_ram[19] | Tab_DispCode[0];
				dis_ram[20] = dis_ram[20] | Tab_DispCode[9];
			break;	
				
			case dr_38p4:
				dis_ram[18] = dis_ram[18] | Tab_DispCode[4];	
				dis_ram[19] = dis_ram[19] | Tab_DispCode[9];
				dis_ram[20] = dis_ram[20] | Tab_DispCode[5];
			break;	
			
			case dr_76p8:
				dis_ram[18] = dis_ram[18] | Tab_DispCode[8];	
				dis_ram[19] = dis_ram[19] | Tab_DispCode[9];
				dis_ram[20] = dis_ram[20] | Tab_DispCode[2];
			break;	
			
			case dr_115p2:
				dis_ram[18] = dis_ram[18] | Tab_DispCode[1];	
				dis_ram[19] = dis_ram[19] | Tab_DispCode[3];
				dis_ram[20] = dis_ram[20] | Tab_DispCode[4];
			break;
			
			case dr_256k:
				dis_ram[18] = dis_ram[18] | Tab_DispCode[4];	
				dis_ram[19] = dis_ram[19] | Tab_DispCode[8];
				dis_ram[20] = dis_ram[20] | Tab_DispCode[4];
			break;	
			
			case dr_500k:
				dis_ram[18] = dis_ram[18] | Tab_DispCode[6];	
				dis_ram[19] = dis_ram[19] | Tab_DispCode[6];
				dis_ram[20] = dis_ram[20] | Tab_DispCode[1];
			break;				
		}			
	}			

	wr_data(0x12,6);
}

//-------------------------------------------	
void dis_tx()
{
	unsigned long temp;
	
	dis_ram[4] = dis_ram[4] & 0x80;
	dis_ram[5] = dis_ram[5] & 0x80;
	dis_ram[6] = dis_ram[6] & 0x80;
	dis_ram[7] = dis_ram[7] & 0x80;
	
	temp = tx_cnt & 0xf000;
	temp = temp >> 12;	
	dis_ram[4] = dis_ram[4] | Tab_DispCode[temp];
	
	temp = tx_cnt & 0x0f00;
	temp = temp >> 8;	
	dis_ram[5] = dis_ram[5] | Tab_DispCode[temp];
	
	temp = tx_cnt & 0x00f0;
	temp = temp >> 4;	
	dis_ram[6] = dis_ram[6] | Tab_DispCode[temp];
	
	temp = tx_cnt & 0x000f;
	dis_ram[7] = dis_ram[7] | Tab_DispCode[temp];
	
	wr_data(0x04,8);	
}

//-------------------------------------------
void dis_rx()
{
	unsigned long temp;
	
	dis_ram[0] = dis_ram[0] & 0x80;
	dis_ram[1] = dis_ram[1] & 0x80;
	dis_ram[2] = dis_ram[2] & 0x80;
	dis_ram[3] = dis_ram[3] & 0x80;
	
	temp = rx_cnt & 0xf000;
	temp = temp >> 12;	
	dis_ram[0] = dis_ram[0] | Tab_DispCode[temp];
	
	temp = rx_cnt & 0x0f00;
	temp = temp >> 8;	
	dis_ram[1] = dis_ram[1] | Tab_DispCode[temp];
	
	temp = rx_cnt & 0x00f0;
	temp = temp >> 4;	
	dis_ram[2] = dis_ram[2] | Tab_DispCode[temp];
	
	temp = rx_cnt & 0x000f;
	dis_ram[3] = dis_ram[3] | Tab_DispCode[temp];
	
	wr_data(0x00,8);	
}
	
//-------------------------------------------
void dis_rssi()
{
	dis_ram[2] = dis_ram[2] & 0x7f;
	dis_ram[4] = dis_ram[4] & 0x7f;
	dis_ram[5] = dis_ram[5] & 0x7f;
	dis_ram[6] = dis_ram[6] & 0x7f;
	dis_ram[7] = dis_ram[7] & 0x7f;
	
	if(rssi < 20)
		;		
		
	else if(rssi < 30)
		dis_ram[2] = dis_ram[2] | 0x80;	
		
	else if(rssi < 35)
	{
		dis_ram[2] = dis_ram[2] | 0x80;
		dis_ram[4] = dis_ram[4] | 0x80;
	}	
	
	else if(rssi < 40)
	{
		dis_ram[2] = dis_ram[2] | 0x80;
		dis_ram[4] = dis_ram[4] | 0x80;
		dis_ram[5] = dis_ram[5] | 0x80;	
	}		
	
	else if(rssi < 45)
	{
		dis_ram[2] = dis_ram[2] | 0x80;
		dis_ram[4] = dis_ram[4] | 0x80;
		dis_ram[5] = dis_ram[5] | 0x80;
		dis_ram[6] = dis_ram[6] | 0x80;
	}
	
	else
	{
		dis_ram[2] = dis_ram[2] | 0x80;
		dis_ram[4] = dis_ram[4] | 0x80;
		dis_ram[5] = dis_ram[5] | 0x80;
		dis_ram[6] = dis_ram[6] | 0x80;
		dis_ram[7] = dis_ram[7] | 0x80;
	}	
		
	wr_data(0x02,2);
	wr_data(0x04,8);	
	
}

//-------------------------------------------
void dis_sign()
{	
	dis_ram[26] = dis_ram[26] | 0x80;
	wr_data(0x1a,2);						// dis s9
	dis_ram[3] = dis_ram[3] | 0x80;
	wr_data(0x03,2);						// dis s10
	dis_ram[11] = dis_ram[11] & 0x7f;
	wr_data(0x0b,2);						// GHz off
	dis_ram[8] = dis_ram[8] | 0x80;
	wr_data(0x08,2);						// dis MHz
	dis_ram[10] = dis_ram[10] | 0x80;
	wr_data(0x0a,2); 						// dis s16
	dis_ram[21] = dis_ram[21] | 0x80;
	wr_data(0x15,2); 						// dis s17
	dis_ram[25] = dis_ram[25] | 0x80;
	wr_data(0x19,2);						// dis s18
	dis_ram[19] = dis_ram[19] | 0x80;
	wr_data(0x13,2);						// dis s19	
	dis_ram[23] = dis_ram[23] | 0x80;
	wr_data(0x17,2);						// dis s25/DR	
	dis_ram[20] = dis_ram[20] | 0x80;
	wr_data(0x14,2);						// dis s29/FD	
}
	
//-------------------------------------------
void dis_mode()
{
	if((!Flag.flash) && (set == set_trmode))
		dis_ram[27] = Tab_DispCode[0x10];

	else
	{
		switch(mode)
		{
			case rx_normal:
				dis_ram[27] = 0x18;
			break;
				
			case tx_normal:
				dis_ram[27] = 0x28;
			break;
				
			case rx_test:
				dis_ram[27] = 0x14;
			break;
				
			case tx_test:
				dis_ram[27] = 0x24;
			break;
					
			case rf_off:			
				dis_ram[27] = 0x40;
			break;
		}
	}
		
	wr_data(0x1b,2);
}
	
//-------------------------------------------
void wr_data(unsigned char addr,unsigned char loop)
{
	unsigned char i = 8,wd_temp;
	wd_temp = addr << 1;
	wd_temp = wd_temp | 0x40;
	CS = 0;
	WR = 0;
	DATA_1();
	while(i--)
	{
		if(wd_temp & 0x80)	
			DATA_1();
		else
			DATA_0();
			
		wd_temp = wd_temp << 1;
	}
		
	while(loop--)	
	{
		if(loop & 0x01)
		{
			wd_temp = dis_ram[addr] & 0x0f;	
		}
		else
		{	
			wd_temp = dis_ram[addr] & 0xf0;
			wd_temp = wd_temp >> 4;			
			addr++;
		}	
		
		i = 4;
		
		while(i--)
		{			
			if(wd_temp & 0x01)
				DATA_1();
			else
				DATA_0();		
				
			wd_temp = wd_temp >> 1;			
		}
		
	}		
		
	WR = 1;	
	CS = 1;		
	DATA = 1;
}
	
//-------------------------------------------
void wr_cmd(unsigned int cmd)  
{
	unsigned char i = 12;
	
	CS = 0;
	WR = 0;
	while(i--)
	{		
		if(cmd & 0x0800)	
			DATA_1();
		else
			DATA_0();	
			
		cmd = cmd << 1;		
	}
	WR = 1;	
	CS = 1;		
}

//-------------------------------------------
void DATA_1()
{
	DATA = 1;
	WR = 1;
	nop_10();
	WR = 0;	 	
}

//-------------------------------------------
void DATA_0()	
{
	DATA = 0;
	WR = 1;
	nop_10();
	WR = 0;	 
}

//**********************************************************
//*********************** SUBROUTINE ***********************
//**********************************************************

void flash_copy()
{
	flash_cfg[0] = freq3;
	flash_cfg[1] = freq2;
	flash_cfg[2] = freq1;
	flash_cfg[3] = power;
	flash_cfg[4] = rate;
	flash_cfg[5] = mode;		
}
	
//-------------------------------------------
void time_opt()
{
	wdtr = 0;
	wdtr = 0xff;
	
	if(reach_15hz)
	{
		reach_15hz = 0;			
		key_value = scan_key();
		key_opt(key_value);	
	}
		
	asm("NOP");
		
	if(reach_flash)
	{
		reach_flash = 0;
		Flag.flash = Flag.flash ^ 1;
							
		switch(set)
		{
			case	0:
					;
			break;
					
			case	1:
			case	2:
			case	3:
				dis_freq();	
			break;	
				
			case	set_power:	
				dis_power();	
			break;	
					
			case	set_dr:	
				dis_dr();	
			break;		
					
			case	set_trmode:
				dis_mode();	
			break;					
		}		
	}	
		
	asm("NOP");
		
	if(reach_1s)
	{
		reach_1s = 0;
			
		if((set) && (cnt_10s-- == 0))
		{
			set = 0;
			poweron_dis();
			flash_copy();
			flash_rewrite(flash_cfg);
			SI4463_init();  // RF Ä£¿é³õÊ¼»¯
		}
	}		
}

void rf_init_freq(void)
{	
	unsigned char OUTDIV,DIV,VCO,INTE,BAND;
	unsigned char FD_2,FD_1,FD_0,FRAC_2,FRAC_1,FRAC_0;
	unsigned long FRAC,data,frequency;
	U8 app_command_buf[20];
	
	frequency = (freq3 * 100) + (freq2 * 10) + freq1;
	frequency = (frequency * 10000) + 5000;
	
	if(frequency>=7600000)					// 760~1050
	{
		OUTDIV = 4;
		BAND = 0;
		VCO = 0xff;	
	}	
	else if(frequency>=5460000)				// 546~759.9
	{
		OUTDIV = 6;
		BAND = 1;
		VCO = 0xfe;	
	}
	else if(frequency>=3850000)				// 385~545.9
	{
		OUTDIV = 8;
		BAND = 2;
		VCO = 0xfe;	
	}
	else if(frequency>=2730000)				// 273~384.9
	{
		OUTDIV = 12;
		BAND = 3;
		VCO = 0xfd;	
	}
	else if(frequency>=1940000)				// 194~272.9
	{
		OUTDIV = 16;
		BAND = 4;
		VCO = 0xfc;	
	}
	else									// 142~193.9
	{
		OUTDIV = 24;
		BAND = 5;
		VCO = 0xfa;
	}
	
	DIV = OUTDIV/2;
	
	data = (frequency*DIV)/3;
	INTE = (data/100000)-1;
	FRAC = (data-(INTE+1)*100000)*16384/3125;
	FRAC = FRAC+0x80000;
	
	FRAC_0 = FRAC;
	FRAC>>=8;
	FRAC_1 = FRAC;
	FRAC>>=8;
	FRAC_2 = FRAC;
	
	// send freq cmd	
	
	app_command_buf[0] = 0x11;  
	app_command_buf[1]  = 0x20;    // 0x2051                                                         
	app_command_buf[2]  = 0x01;    // ¹² 1¸ö²ÎÊý                                                     
	app_command_buf[3]  = 0x51;   // 0x2051                                                          
	app_command_buf[4]  = 0x08|BAND;  //  high performance mode , clk outpu = osc /4
    spi_write(5, app_command_buf); 	
	
	app_command_buf[0] = 0x11;  
	app_command_buf[1]  = 0x40;    // 0x4000                                                         
	app_command_buf[2]  = 0x08;    // ¹² 8¸ö²ÎÊý                                                     
	app_command_buf[3]  = 0x00;   // 0x4000                                                          
	app_command_buf[4]  = INTE;   //  default value 
	app_command_buf[5]  = FRAC_2;   //  defaul value 
	app_command_buf[6]  = FRAC_1;   //  default value 
	app_command_buf[7]  = FRAC_0;   // frac ,from WDS
	app_command_buf[8]  = step_500K_step1;   // channel step1  from wds 
	app_command_buf[9]  = step_500K_step0;   // channel step0  from wds 
	app_command_buf[10] = 0x20;  //  from wds Ã»ÓÐÕâ¸öÖµ   
	app_command_buf[11]  = VCO;    // from wds Ã»ÓÐÕâ¸öÖµ 
    spi_write(12, app_command_buf); 
} 


//system clock setup
void sysclk_cfg(void)
{
	prc0 = 1;
	prc1 = 1;
	prc3 = 1;
	
	cm02 = 0;
	cm05 = 1;
	cm06 = 0;

	cm13 = 0;
	cm15 = 1;
	cm16 = 0;
	cm17 = 0;
	cm10 = 0;	
	
	hra00 = 1;
	
	ocd0 = 0;
	ocd1 = 0;
	ocd2 = 1;
	ocd3 = 0;
	hra01 = 1;	
	cm14 = 1;			
	prc0 = 0;	
}

//IO function set
void port_init(void)
{
	pd1 = 0b01111000;
	p1 = 0b00001000;
	pd3 = 0b10111000;
	p3 = 0b00101000;
	pd4 = 0b00100000;
	p4 = 0;
	pur0 = 0x04;
	pur1 = 0x00;
	drr = 0x00;
}

void delay_1ms(unsigned int delay_time)
{
	unsigned int i;
	while(delay_time !=0)
	{
		for (i =380; i!=0; i--)   // 340 for 7.3728MHz
		{
			asm("NOP");
			asm("NOP");
		}	
		delay_time--;
	}	
}	

void delay_10ms(void)
{
	int i;
	
	for(i = 0; i<2472; i++)
	{
		;
	}	
	// add watchdog			
	wdtr = 0;
	wdtr = 0xff;
	// add watchdog
}
	
//-------------------------------------------
void delay_x10ms(unsigned int dx10ms)
{
	unsigned int j;
	
	for(j = 0; j<dx10ms; j++)
		delay_10ms();	
}

void nop_10()
{
	asm("NOP");	
	asm("NOP");	
	asm("NOP");	
	asm("NOP");	
	asm("NOP");	
	asm("NOP");	
	asm("NOP");	
	asm("NOP");	
	asm("NOP");	
	asm("NOP");	
}	

void timerx_init(void)
{
	txmr = 0x00;
	tcss = 0x01;			// f8
	prex = 0xff;
	tx = 129;				// 1/8/(255+1)(129+1) * 8M=30Hz		
	txic = 0x04;
	txs = 1;	
}

#pragma INTERRUPT INT_TimerX
void INT_TimerX(void)
{
	if(count_15hz ^= 1)
		reach_15hz = 1;	
	
	count_flash++;			// 2hz
	if(count_flash == 15)
	{
		count_flash = 0;
		reach_flash = 1;
		//LED_GREEN  ^= 1;
	}
	
	count_1s++;
	if(count_1s == 31)	
	{
		count_1s = 0;
		reach_1s = 1;	
	}	
	
	rf_timeout++;
	if(rf_timeout == 60)
	{
		rf_timeout=0;
		Flag.rf_reach_timeout = 1;	// ·¢ÉäTimeout¶¨Ê±Æ÷
	}	
	
	count_1hz++;
    //if(count_1hz==30) 
    if(count_1hz==60)				// 2S send data	
    {
       	count_1hz=0;
       	Flag.reach_1s = 1;			//Ò»Ãë µÄ¶¨Ê±Æ÷
       	//LED_RED  ^= 1;
    }
}


