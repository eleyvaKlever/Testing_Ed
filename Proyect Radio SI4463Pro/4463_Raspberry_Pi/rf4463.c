#include "rf4463.h"
#include <wiringPiSPI.h>
#include "radio_config_si4463.h"

#define  SDN_HIGH()    digitalWrite(SDN, 1)
#define  SDN_LOW()     digitalWrite(SDN, 0)


#define freq_channel	0 


const unsigned char RF_FREQ_CONTROL_INTE_8_data[] = {RF_FREQ_CONTROL_INTE_8};
const unsigned char RF_POWER_UP_data[] = { RF_POWER_UP};

const unsigned char RF_FRR_CTL_A_MODE_4_data[] = { RF_FRR_CTL_A_MODE_4};

const unsigned char RF_MODEM_FREQ_DEV_0_1_data[] = { RF_MODEM_FREQ_DEV_0_1};
const unsigned char RF_MODEM_AGC_CONTROL_1_data[] = { RF_MODEM_AGC_CONTROL_1};
const unsigned char RF_MODEM_MOD_TYPE_12_data[] = {RF_MODEM_MOD_TYPE_12};
const unsigned char RF_MODEM_TX_RAMP_DELAY_12_data[] = {RF_MODEM_TX_RAMP_DELAY_12};
const unsigned char BCR_NCO_OFFSET_2_12_data[] = {RF_MODEM_BCR_NCO_OFFSET_2_12};
const unsigned char RF_MODEM_AFC_LIMITER_1_3_data[] = {RF_MODEM_AFC_LIMITER_1_3};
const unsigned char AGC_WINDOW_SIZE_12_data[] =	{RF_MODEM_AGC_WINDOW_SIZE_12};
const unsigned char RF_MODEM_RAW_CONTROL_8_data[] =	{RF_MODEM_RAW_CONTROL_8};
const unsigned char COE13_7_0_12_data[] = {RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12};
const unsigned char COE1_7_0_12_data[] = {RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12};
const unsigned char COE7_7_0_12_data[] = {RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12};
const unsigned char RF_SYNTH_PFDCP_CPFF_7_data[] = {RF_SYNTH_PFDCP_CPFF_7};
const unsigned char RF_MODEM_RAW_SEARCH2_2_data[] = {RF_MODEM_RAW_SEARCH2_2};
 
extern const unsigned char tx_ph_data[14];
extern unsigned char spi_read_buf[20];
extern unsigned char rx_buf[25];
extern unsigned char rf_reach_timeout;
extern uint16_t count_1hz, rf_timeout;
extern unsigned char is_tx;



void spi_write_fifo(void);


unsigned char check_cts(void);

void fifo_reset(void);
void enable_tx_interrupt(void);
void enable_rx_interrupt(void);

void spi_write(unsigned char tx_length, unsigned char *p);
void spi_read(unsigned char data_length, unsigned char api_command );
void tx_start(void);
void rx_start(void);

void rf_standby(void);



void SI4463_init(void)
{	
	unsigned char i,app_command_buf[20];

	app_command_buf[0] = 0x13;		// SET GPIO PORT of 4463
	app_command_buf[1] = 0x14; 		// gpio0,Rx data
	app_command_buf[2] = 0x13;    	// gpio1,TX data
	app_command_buf[3] = 0x21;  	// gpio2, hign while in receive mode
	app_command_buf[4] = 0x20; 		// gpio3, hign while in transmit mode 
	app_command_buf[5] = 0x00;   	// nIRQ
	app_command_buf[6] = 0x00;  	// sdo
	spi_write(7, app_command_buf); 
		
	// spi_write(0x05, RF_GLOBAL_XO_TUNE_1_data); 
    app_command_buf[0] = 0x11;  
	app_command_buf[1]  = 0x00;    
	app_command_buf[2]  = 0x01;    
	app_command_buf[3]  = 0x00;  
	app_command_buf[4]  = 98;  			// freq  adjustment
	spi_write(5, app_command_buf);

	// spi_write(0x05, RF_GLOBAL_CONFIG_1_data);
  	app_command_buf[0] = 0x11;  
	app_command_buf[1]  = 0x00;
	app_command_buf[2]  = 0x01; 
	app_command_buf[3]  = 0x03; 
	app_command_buf[4]  = 0x40;  		// tx = rx = 64 byte,PH,high performance mode
	spi_write(5, app_command_buf); 
    
	
	for(i=0;i<8;i++)
	{
		app_command_buf[i]=RF_FRR_CTL_A_MODE_4_data[i];
	}
    spi_write(0x08, app_command_buf);    // disable all fast response register
     
    // spi_write(0x0D, RF_PREAMBLE_TX_LENGTH_9_data); // set Preamble
 	app_command_buf[0] = 0x11;  
	app_command_buf[1]  = 0x10;    
	app_command_buf[2]  = 0x09;    
	app_command_buf[3]  = 0x00;   
	app_command_buf[4]  = 0x08;							//  8 bytes Preamble
	app_command_buf[5]  = 0x14;							//  detect 20 bits
	app_command_buf[6]  = 0x00;						
	app_command_buf[7]  = 0x0f;
	app_command_buf[8]  = 0x31;  						//  no manchest.1010.。。
	app_command_buf[9]  = 0x00;
	app_command_buf[10]  = 0x00;
	app_command_buf[11]  = 0x00;
	app_command_buf[12]  = 0x00;
	spi_write(13, app_command_buf);	
	
	//  RF_SYNC_CONFIG_5_data,							// set sync
    app_command_buf[0] = 0x11;  
	app_command_buf[1]  = 0x11;
	app_command_buf[2]  = 0x05;
	app_command_buf[3]  = 0x00;
	app_command_buf[4]  = 0x01;   						// no manchest , 2 bytes
	app_command_buf[5]  = 0x2d;   						// sync byte3
	app_command_buf[6]  = 0xd4;							// sync byte2
	app_command_buf[7]  = 0x00;							// sync byte1
	app_command_buf[8]  = 0x00;							// sync byte0
    spi_write(9, app_command_buf);
        
	//  packet crc         
    app_command_buf[0] = 0x11;  
	app_command_buf[1]  = 0x12; 
	app_command_buf[2]  = 0x01; 
	app_command_buf[3]  = 0x00;
	app_command_buf[4]  = 0x81;							// CRC = itu-c, enable crc
    spi_write(5, app_command_buf);  
        
	// packet   gernale configuration        
    app_command_buf[0] = 0x11;  
	app_command_buf[1]  = 0x12;
	app_command_buf[2]  = 0x01;
	app_command_buf[3]  = 0x06;
	app_command_buf[4]  = 0x02;							// CRC MSB， data MSB
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
	spi_write(16, app_command_buf);					// set length of Field 1 -- 4
  
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
    
	for(i=0;i<16;i++)
	{
		app_command_buf[i]=RF_MODEM_MOD_TYPE_12_data[i];
	}
    spi_write(0x10, app_command_buf); 
	
	for(i=0;i<5;i++)
	{
		app_command_buf[i]=RF_MODEM_FREQ_DEV_0_1_data[i];
	}
	spi_write(0x05, app_command_buf);
	
	for(i=0;i<16;i++)
	{
		app_command_buf[i]=RF_MODEM_TX_RAMP_DELAY_12_data[i];
	}
    spi_write(0x10, app_command_buf);
	
	for(i=0;i<16;i++)
	{
		app_command_buf[i]=BCR_NCO_OFFSET_2_12_data[i];
	}
    spi_write(0x10, app_command_buf);
	
	for(i=0;i<16;i++)
	{
		app_command_buf[i]=RF_MODEM_TX_RAMP_DELAY_12_data[i];
	}
	spi_write(0x10, app_command_buf);
	
	for(i=0;i<7;i++)
	{
		app_command_buf[i]=RF_MODEM_AFC_LIMITER_1_3_data[i];
	}
    spi_write(0x07, app_command_buf);	
	//spi_write(0x10, BCR_NCO_OFFSET_2_12_data);

	for(i=0;i<5;i++)
	{
		app_command_buf[i]=RF_MODEM_AGC_CONTROL_1_data[i];
	}
    spi_write(0x05, app_command_buf);	

	for(i=0;i<16;i++)
	{
		app_command_buf[i]=AGC_WINDOW_SIZE_12_data[i];
	}
    spi_write(0x10, app_command_buf);	
	
	for(i=0;i<12;i++)
	{
		app_command_buf[i]=RF_MODEM_RAW_CONTROL_8_data[i];
	}
    spi_write(0x0c, app_command_buf);
//	spi_write(0x10, AGC_WINDOW_SIZE_12_data);
    
	// spi_write(0x05, RF_MODEM_RSSI_COMP_1_data);
	app_command_buf[0] = 0x11;  
	app_command_buf[1] = 0x20;                                                     
	app_command_buf[2] = 0x01;                                                   
	app_command_buf[3] = 0x4e;             
	app_command_buf[4] = 0x40;
    spi_write(5, app_command_buf);            	     
   
    for(i=0;i<16;i++)
	{
		app_command_buf[i]=COE13_7_0_12_data[i];
	}
    spi_write(0x10, app_command_buf);
	
	for(i=0;i<16;i++)
	{
		app_command_buf[i]=COE1_7_0_12_data[i];
	}
    spi_write(0x10, app_command_buf);
	
	for(i=0;i<16;i++)
	{
		app_command_buf[i]=COE7_7_0_12_data[i];
	}
    spi_write(0x10, app_command_buf);       
        
	// RF_PA
	app_command_buf[0] = 0x11;  
	app_command_buf[1]  = 0x22;                                                    
	app_command_buf[2]  = 0x04;                                               
	app_command_buf[3]  = 0x00;                                                     
	app_command_buf[4]  = 0x08;
	app_command_buf[5]  = 127;							// set max power
	app_command_buf[6]  =0x00;
	app_command_buf[7]  = 0x3d;
    spi_write(8, app_command_buf);        
    
	for(i=0;i<11;i++)
	{
		app_command_buf[i]=RF_SYNTH_PFDCP_CPFF_7_data[i];
	}
	spi_write(0x0B, app_command_buf);
        
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
    
	for(i=0;i<6;i++)
	{
		app_command_buf[i]=RF_MODEM_RAW_SEARCH2_2_data[i];
	}
	spi_write(6, app_command_buf);
	
	for(i=0;i<12;i++)
	{
		app_command_buf[i]=RF_FREQ_CONTROL_INTE_8_data[i];
	}
    spi_write(12, app_command_buf); 	    // set frequency    	
}        

// 复位发射和接收 FIFO
void fifo_reset(void)			
{
	unsigned char p[2];
	
	p[0] = FIFO_INFO;
	p[1] = 0x03;   
	spi_write(2,p);
}	

// 清中断标志
void clr_interrupt(void)		
{
	unsigned char p[4];
	
	p[0] = GET_INT_STATUS;
	p[1] = 0;   
	p[2] = 0;   
	p[3] = 0;   
	spi_write(4,p);
	spi_read(9,GET_INT_STATUS); 
}

// 使能接收中断
void enable_rx_interrupt(void)		
{
	unsigned char p[7];

	p[0] = 0x11;
	p[1] = 0x01;  
	p[2] = 0x03;  
	p[3] = 0x00;  
	p[4] = 0x03;   
	p[5] = 0x18; 
	p[6] = 0x00;
	spi_write(0x07, p);
}	

// 使能发射中断
void enable_tx_interrupt(void)		
{	
	unsigned char p[6];

	p[0] = 0x11;
	p[1] = 0x01;
	p[2] = 0x02;
	p[3] = 0x00;
	p[4] = 0x01;
	p[5] = 0x20;
	spi_write(0x06, p);  
}	

// RF 休眠
void rf_standby(void)				
{
	unsigned char p[2];
	
	p[0] = CHANGE_STATE ;
	p[1] = 0x01 ;
	spi_write(2, p);  
} 

// 开始发射
void tx_start(void)					
{
	unsigned char p[5];
	
	p[0] = START_TX ; 
	p[1] = freq_channel ;  			// 通道0
	p[2] = 0x30; 
	p[3] = 0;
	p[4] = 0; 
	spi_write(5, p);  
} 

// 开始接收
void rx_start(void)					
{
	unsigned char p[8];
	
	p[0] = START_RX ;
	p[1] = freq_channel ; 			// 通道0
	p[2] = 0x00; 
	p[3] = 0;
	p[4] = 0;
	p[5] = 0; 
	p[6] = 0x08;  
	p[7] = 0x08;   	
	spi_write(8, p);  
}

// RX初始化
void rx_init(void)					
{
	is_tx = 0;
	fifo_reset();  					// 清空 fifo			
	enable_rx_interrupt();	
	clr_interrupt();  				// 清中断标志
	rx_start();
}
	
// 发射数据包
void tx_data(void)					
{	
	unsigned char i;
	
	is_tx = 1;
	flash_led(LED_RED);
	fifo_reset();  
	spi_write_fifo();  				// 将数据写入FIFO		
	enable_tx_interrupt();	
	clr_interrupt();
	tx_start();
	rf_timeout = 0;
	rf_reach_timeout = 0;
	
	while(digitalRead(nIRQ))						// 等待INT中断
	{		
		delay(10);
		rf_reach_timeout++;
		if(rf_reach_timeout>=100)
		{
			rf_reach_timeout=0;
			sdn_reset();
 			SI4463_init();  		// RF发射超时错误，需要复位RF
			break;		
		}	
	}
}

void spi_write(unsigned char tx_length, unsigned char *p)
{
	unsigned char i,j;
	
	i = 0;
	while(i!=0xff)
		i = check_cts();
	
	wiringPiSPIDataRW (SPI_CHAN, p, tx_length);
	
	
	// SCK = 0;
	// nSEL = 0;
	
	// for (i = 0; i < tx_length; i++) 
	// {
		// j = *(p+i);
		// spi_byte(j);
	// }
	
	// nSEL = 1;
	
}

void spi_read(unsigned char data_length, unsigned char api_command )
{
	unsigned char i;
	
	unsigned char p[1];
	p[0] = api_command;
	
	i = 0;
	while(i!=0xff)
		i = check_cts();
		
	spi_write(1, p); 
	
	i = 0;
	while(i!=0xff)
		i = check_cts();
	
	
	// p[0] = READ_CMD_BUFF;//0x44;
	// wiringPiSPIDataRW (SPI_CHAN, p, 1);
	spi_read_buf[0] = READ_CMD_BUFF;
	for (i = 1; i< data_length+1; i++)
		spi_read_buf[i] = 0xff;
	wiringPiSPIDataRW (SPI_CHAN, spi_read_buf, data_length+1);
	
	// nSEL = 1;   
	// SCK = 0;
	// nSEL = 0;
	// spi_byte(0x44);
	// for (i = 0; i< data_length; i++)
		// spi_read_buf[i] = spi_byte(0xff);
	// nSEL = 1;
	
}


unsigned char check_cts(void)
{
	unsigned char buf[2];
   
	buf[0] = 0x44;
	buf[1] = 0x00;
	wiringPiSPIDataRW (SPI_CHAN, buf, 2);
	
	return (buf[1]);
}	



unsigned int spi_read_info(void)
{
	unsigned char p[4];
	unsigned int version;
	
	p[0] = PART_INFO;
	
	spi_write(1,p);
	spi_read(9,PART_INFO);
	
	version=spi_read_buf[3];
	version=(version<<8)+spi_read_buf[4];
	//printf("Chip version:%x ",version);
	return version;
}



void spi_write_fifo(void)
{
	unsigned char i,buf[payload_length+1];
	
	i = 0;
	while(i!=0xff)
		i = check_cts();
	
	buf[0]=WRITE_TX_FIFO;
	for(i=1;i<payload_length+1;i++)
	{
		buf[i]=tx_ph_data[i-1];
	}
	
	wiringPiSPIDataRW (SPI_CHAN, buf, payload_length+1);
	
	
}	

void spi_read_fifo(void)
{
	unsigned char i;
	
	i = 0;
	while(i!=0xff)
		i = check_cts();
		
	// nSEL = 1;   
	// SCK = 0;
	// nSEL = 0;
	// spi_byte(READ_RX_FIFO);    
	// for (i = 0; i< payload_length; i++)
		// rx_buf[i] = spi_byte(0xff); 
	// nSEL = 1;
	
	rx_buf[0]=READ_RX_FIFO;
	for(i=1;i<payload_length+1;i++)
	{
		rx_buf[i] = 0xff;
	}
	
	wiringPiSPIDataRW (SPI_CHAN, rx_buf, payload_length+1);
	
}	

void sdn_reset(void)
{	
	unsigned char i,buf[8];
	
 	SDN_HIGH();
 	delay(2);
 	SDN_LOW();
 	delay(10);
 
	for (i = 0; i< 7; i++)
		buf[i] = RF_POWER_UP_data[i];
	wiringPiSPIDataRW (SPI_CHAN, buf, 7);
	
 	delay(20);
}	


