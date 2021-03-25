#ifndef DEFINE_H
#define DEFINE_H

#include "sfr_r81b.h"
//======================================================================
        
#define  	LED_GREEN		p1_4
#define  	LED_RED			p1_5
#define  	RF2401_EN_REG	p1_6
#define  	RF2401_SS  		p1_7

#define  	RF2401_SCK 		p3_7 

#define  	RF2401_MOSI    	p4_5
#define  	RF2401_MISO		p4_2
#define 	RF2401_IRQ		p4_6

#define 	dr_1p5k			0
#define 	dr_3k			1
#define 	dr_6k			2	
#define 	dr_12k			3
#define		dr_24k			4
#define		dr_48k			5
#define		dr_72k			6

#define 	tx_normal 		0
#define 	rx_normal 		1
#define 	tx_test 		2
#define		rf_off			3

#define Read_RXFIFO			0xC0
#define Write_TXFIFO		0xD0
#define Read_RXFIFO_Size	0xE0
#define Read_TXFIFO_Size	0xE2
#define Read_RAM1			0x20
#define Write_RAM1			0x00
#define Read_RAM2			0x60
#define Write_RAM2			0x40
#define Reset_Micro			0xE4
#define Stop_Micro			0xE6
#define Start_Micro			0xE8
#define Clear_IRQ			0xEA
#define Send_TXFIFO			0xEC
#define Command2			0xEE
#define ROM_Boot			0xF0
#define ROM_Boot0_and_Start	0xFE

#define     RF2401_SLEEP	0
#define     RF2401_ACTIVE	1

#define 	TX_PAYLOAD_SIZE 8

#define		R_DATA		0
#define		R_ACK		1
#define		T_DATA		0
#define		T_ACK		1

#define 	r_true		1
#define 	r_false		0

#define EI();		asm("FSET I");
#define DI();		asm("FCLR I");

#endif