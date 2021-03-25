
#include <stdlib.h>

#include <errno.h>
#include "rf4463.h"


unsigned char reach_1s;	
unsigned char is_tx;
unsigned char rf_reach_timeout;


unsigned int chip_version;	//get the version of si4463 to test the spi bus
unsigned int count_1hz, rf_timeout;
unsigned char state;


const unsigned char tx_ph_data[14] = {'s','w','w','x',0x41,0x42,0x43,0x44,0x45,
0x46,0x47,0x49,0x48,0x6d};  //the last byte is checksum

unsigned char spi_read_buf[20]; 
unsigned char rx_buf[25];
unsigned char get_receive_data(void);

static int myFd ;


void spiSetup (int speed)
{
  if ((myFd = wiringPiSPISetup (SPI_CHAN, speed)) < 0)
  {
    fprintf (stderr, "Can't open the SPI bus: %s\n", strerror (errno)) ;
    exit (EXIT_FAILURE) ;
  }
}

int main(void)
{ 
	unsigned char  i;
	int speed=4;
	
	if(wiringPiSetup() < 0)
		return 1;
	printf("RF4463 TEST tx.........\n");
	
    pinMode(LED_GREEN,OUTPUT);
	pinMode(LED_RED,OUTPUT);
	pinMode(SDN,OUTPUT);
	
	pinMode(nIRQ,INPUT);
	pullUpDnControl(nIRQ, PUD_UP);

	
	spiSetup (speed * 1000000) ;
	
	led_green(ON);
	led_red(ON);
	delay (1000);
	led_green(OFF);
	led_red(OFF);
	
	sdn_reset();		// 复位RF
	
	printf("sdn_reset\n");
	
	chip_version = spi_read_info();
	
	printf("Chip version:%x\n",chip_version);
	delay (1000);
 	SI4463_init();  	// 初始化 RF参数
			
	count_1hz = 0;
	reach_1s = 0;		
	
	printf("start\n");
	
	while(1)
	{				
		
		tx_data();		// 2S发射一包数据，并等待回应信号
		rx_init();		// 发射数据包完毕，进入接收状态
		
		delay (1000);		
		
		state = get_receive_data();	//check if receive a correct packet
		if(state)
		{
			state=0;
			flash_led(LED_GREEN);			//flash the green led to indicate the rx
			printf("receive:");
			for(i=5;i<payload_length;i++)
			{
				if(rx_buf[i]<0x0a)
					printf("0%x ",rx_buf[i]);
				else
					printf("%x ",rx_buf[i]);
			}
			printf("\n");
		}	
	}
}

unsigned char get_receive_data(void)
{
	unsigned char  i, chksum;
	
	if(digitalRead(nIRQ) == 0)	//check if nIRQ is low
	{ 
		//flash_led(LED_GREEN);
		clr_interrupt();   // clear interrupt flag
			
		if((spi_read_buf[5] &0x08) == 0)  //check if the CRC check is correct or not
		{
			spi_read_fifo();	//get receive data from fifo
			fifo_reset();		//clear the fifo
					
			chksum = 0;	
			for(i=5;i<payload_length;i++)	//calculate	the checksum of receive data
				chksum += rx_buf[i];  
				
			// for(i=5;i<payload_length;i++)
			// {
				// if(rx_buf[i]<0x0a)
					// printf("0%x ",rx_buf[i]);
				// else
					// printf("%x ",rx_buf[i]);
			// }				
			if(( chksum == rx_buf[payload_length] )&&( rx_buf[5] == 0x41 )) //if the packet is correct
			{
				return 1;
			} 
			else
				rx_init();     					// 数据错误，初始化接收
		}
		else
		{
			rx_init();   						// crc错误，初始化接收
		}			
	}
	return 0;
}
















