#ifndef _RF4463_h
#define _RF4463_h

typedef unsigned int uint16_t;


#include <wiringPi.h>
#include <stdio.h>


#define NOP 							0x00 
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

#define  LED_GREEN		0
#define  LED_RED		1
#define  SDN	        2
#define  nIRQ       	3

#define	SPI_CHAN		0

#define  ON	        	0
#define  OFF       		1



#define  led_green(x)  digitalWrite(LED_GREEN, (x))
#define  led_red(x)    digitalWrite(LED_RED, (x))

#define  flash_led(x)   if((x)==LED_RED){					  \
							if(digitalRead(LED_RED) == ON)	  \
								digitalWrite(LED_RED, OFF);	  \
							else							  \
								digitalWrite(LED_RED, ON);	  \
						}									  \
						else{								  \
							if(digitalRead(LED_GREEN) == ON)  \
								digitalWrite(LED_GREEN, OFF); \
							else							  \
								digitalWrite(LED_GREEN, ON);  \
						}
						
#define payload_length  14						
						
						
						
void sdn_reset(void);
void SI4463_init(void);
uint16_t spi_read_info(void);
void tx_data(void);
void rx_init(void);
void clr_interrupt(void);
void spi_read_fifo(void);
void fifo_reset(void);

#endif