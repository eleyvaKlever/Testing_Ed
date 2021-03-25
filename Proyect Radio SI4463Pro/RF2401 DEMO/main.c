
#include "define.h"
#include "time.h"

unsigned char mode,power,rssi,rate;		
unsigned char count_1s,reach_1s;
unsigned long tx_cnt = 0,rx_cnt = 0; 

unsigned char high_sen;	
unsigned char RF2401_status;	
unsigned char RecvBuf[3];			
unsigned char SendBuf[3];
unsigned char RXData[32];           

void sysclk_cfg(void);
void port_init(void); 
void timerx_init(void);
void delay_10ms(void);
void delay_x10ms(unsigned int dx10ms);
void nop_10();

void call_write_channel_frequency(unsigned long w_data);

void wake_up_RF2401(void);
void RF2401_PwrDown(void);
void reset_RF2401(void);
void call_init_RF2401(void);
unsigned char read_ram2_RSSI(void);
void write_ram2_payload_size(unsigned char write_data);
unsigned char read_RXFIFO_size();
void write_TXFIFO_RF2401(unsigned char in_data);

void RF2401_TX_DATA(void);
void RF2401_TX_ACK(void);
void change_pair_address(unsigned char w_address);
unsigned char look_RF2401mcu_busy(void);

unsigned char  SPI_1Byte(unsigned char in);
void SPI_2Byte(void);
void SPI_3Byte(void);
unsigned char read_RF2401_data(unsigned char r_mode);
void call_set_rf_data_rate(void);
void call_set_rf_auto_data_rate(void);

void main()
{
	unsigned char  i,chksum;
	
	sysclk_cfg();								// set MCU system clock
	nop_10();
	
	wdc = 0x9f;
	cspr = 0;	
	pm12 = 1;
	wdtr = 0;
	wdtr = 0xff;
	wdts = 0;									// enable watchdog
	
	port_init();								// initial IO port
	nop_10();	
	LED_GREEN = 0;
	LED_RED = 0;
	
	call_init_RF2401();							// initial RF2401
	delay_x10ms(50);							// for power on delay

	count_1s = 0;
	reach_1s = 0;
	
	timerx_init();	
	asm("FSET I");								// initial TIMERX and enable interrupt(for 1s send packet)
	
	mode = tx_normal;
	//mode = rx_normal;
	//mode = tx_test;
	//mode = rf_off;
			
	while(1)
	{	
		if(mode == rf_off)
		{
			RF2401_PwrDown();					// RF2401 to power down mode
			
			while(1)
			{
				asm("NOP");					
				wdtr = 0;
				wdtr = 0xff;					// clr watchdog				
				asm("NOP");	
			}	
		}
		
		asm("NOP");	
		
		if(mode == tx_test)						// tx test mode
		{		
			call_init_RF2401();
			LED_RED=1;		
			
			while(1)
			{	
				asm("NOP");				
				RF2401_TX_DATA();				
				tx_cnt += 1;
				
				asm("NOP");									
				wdtr = 0;
				wdtr = 0xff;					// clr watchdog								
				asm("NOP");	
			}	
		}		
		
		asm("NOP");	
			
		if(mode == rx_normal)									// in rx normal mode
		{		
			call_init_RF2401();
			
			if (high_sen == 1)									
				write_ram2_payload_size(TX_PAYLOAD_SIZE);		// is high sensitivity mode
				
			while(1)
			{	
				if(RF2401_IRQ)									// receive data?
				{																		
					if (read_RF2401_data(R_DATA) == r_true)		// data right?
					{																			
						LED_GREEN=LED_GREEN^1;					
						rx_cnt += 1;
						rssi=read_ram2_RSSI();					// get rssi
						delay_10ms();
						wake_up_RF2401();
						RF2401_TX_ACK();						// send back ack signal(8 bytes)：9/8/7/6/5/4/3/2
						LED_RED=LED_RED^1;						
						tx_cnt += 1;
					}
				}
				asm("NOP");									
				wdtr = 0;
				wdtr = 0xff;									// clr watchdog								
				asm("NOP");
			}	
		}		
		
		asm("NOP");	
	
		if(mode == tx_normal)										// in tx normal mode
		{				
			call_init_RF2401();
			
			while(1)
			{
				if(RF2401_IRQ)										// receive data?
				{																		
					if (read_RF2401_data(R_ACK) == r_true)			// is ack signal?
					{																			
						LED_GREEN=LED_GREEN^1;						
						rx_cnt += 1;
						rssi=read_ram2_RSSI();						// get rssi
					}
				}				
				asm("NOP");
				
				if(reach_1s)										// in tx normal mode,send packet every 1S
				{
					reach_1s = 0;
					
					wake_up_RF2401();
					RF2401_TX_DATA();
					LED_RED=LED_RED^1;						
					tx_cnt += 1;
				}	
				asm("NOP");					
				wdtr = 0;
				wdtr = 0xff;										// clr watchdog								
				asm("NOP");	
			}			
		}
	}	
}
//*****************************************************
//******************* RF subroutine *******************
//*****************************************************
unsigned char spi_rw_byte(unsigned char data)			// SPI read or write(1 byte) 
{
	unsigned char i;
	
	for (i = 0; i < 8; i++) 
	{
		if (data & 0x80)
			RF2401_MOSI = 1;
		else
			RF2401_MOSI = 0;
		data <<= 1;
		RF2401_SCK = 1;
		if (RF2401_MISO)
			data |= 0x01;
		else
			data &= 0xfe;
		RF2401_SCK = 0;
	}	
	return (data);
}
//-------------------------------------------
unsigned char  SPI_1Byte(unsigned char in)				
{   
    unsigned char tmp;
    
    RF2401_SS = 1;
    tmp = spi_rw_byte(in);
    RF2401_SS = 0;
    
    return tmp;
}
//-------------------------------------------
void SPI_2Byte(void)									
{
    RF2401_SS = 1;
    RecvBuf[0] = spi_rw_byte(SendBuf[0]);
    RecvBuf[1] = spi_rw_byte(SendBuf[1]);
    RF2401_SS = 0;
}
//-------------------------------------------
void SPI_3Byte(void)									
{
    RF2401_SS = 1;
    RecvBuf[0] = spi_rw_byte(SendBuf[0]);
    RecvBuf[1] = spi_rw_byte(SendBuf[1]);
    RecvBuf[2] = spi_rw_byte(SendBuf[2]);
    RF2401_SS = 0;
}
//-------------------------------------------
void write_ram1_RF2401(unsigned char w_address,unsigned int w_data)	// write RAM1 of Rf2401
{
	SendBuf[0] = Write_RAM1 | ((w_address)>>1);
	SendBuf[1] = ((w_address & 0x01)<< 7);
	SendBuf[1] |= (unsigned char)((w_data & 0xfe0) >> 5);
	SendBuf[2] = (unsigned char)((w_data & 0x01f)<<3);
	SPI_3Byte();
}
//-------------------------------------------
void write_ram2_RF2401(unsigned char w_address,unsigned int w_data)	// write RAM2 of Rf2401
{
	SendBuf[0] = Write_RAM2 | ((w_address&0x0f)<<1);
	SendBuf[0] |= (unsigned char)(w_data >>11);
	SendBuf[1] = ((w_data & 0x7f8) >> 3);
	SendBuf[2] = (unsigned char)((w_data & 0x007) << 5);
	SPI_3Byte();	
}
//-------------------------------------------
void write_TXFIFO_RF2401(unsigned char in_data)						// write TX FIFO
{
    SendBuf[0] = Write_TXFIFO | ((in_data & 0xf0) >> 4);
    SendBuf[1] = ((in_data & 0x0f)<<4);
    SPI_2Byte();	
}
//-------------------------------------------
unsigned char read_RXFIFO_size()									// read RX FIFO size
{
	unsigned char rxfifo_size;
	
    SendBuf[0] = Read_RXFIFO_Size ;
    SendBuf[1] = 0x00;
    SPI_2Byte();
    rxfifo_size = (RecvBuf[1]&0xf0) >> 4;
    rxfifo_size |= (RecvBuf[0]&0x01)<< 4;
    
    return (rxfifo_size);	
}
//-------------------------------------------
unsigned char look_RF2401mcu_busy(void)
{
	unsigned char RF2401_status;
	
	SPI_1Byte(Clear_IRQ);
	RF2401_status = (RecvBuf[0]&0xe0)>> 5;
	
	return (RF2401_status);
}
//-------------------------------------------
void wait_RF2401_did_command(void)
{
	while (((look_RF2401mcu_busy())&0xfe) != 0x00)		
	{	
		asm("NOP");
		asm("NOP");
		asm("NOP");		
		wdtr = 0;
		wdtr = 0xff;				//Clear_Watchdog;
	}
}
//-------------------------------------------
void change_pair_address(unsigned char w_address)
{
	SendBuf[0] = Write_RAM2 | (unsigned char)((13&0x0f)<<1);	
	SendBuf[1] = (w_address & 0xf8)>> 3;
	SendBuf[2] = (w_address & 0x07)<< 5;		
	SPI_3Byte();									
}
//-------------------------------------------
unsigned char read_ram2_RSSI(void)						// get RSSI of the received packet 
{
	unsigned char read_data;
	
	SendBuf[0] = Read_RAM2 | (unsigned char)((8&0x0f)<<1);	
	SendBuf[1] = 0x00;
	SendBuf[2] = 0x00;
	SPI_3Byte();									
	read_data = (RecvBuf[2]& 0xe0) >> 5;
	read_data |= (RecvBuf[1]& 0x01)<< 3;
	
	return(read_data);
}
//-------------------------------------------
void write_ram2_payload_size(unsigned char write_data)
{
	SendBuf[0] = Read_RAM2 | (unsigned char)((14&0x0f)<<1);		
	SendBuf[1] = 0x00;
	SendBuf[2] = 0x00;	
	SPI_3Byte();									

	SendBuf[0] = 0x00;
	SendBuf[1] = 0x00;
	SendBuf[2] = 0x00;
	SendBuf[0] = Write_RAM2 | (unsigned char)((14&0x0f)<<1);	
	SendBuf[0] |= (RecvBuf[0] & 0x01);								
	SendBuf[1] =	RecvBuf[1]&0xfc;
	SendBuf[1] |= (write_data & 0x18)>> 3;
	SendBuf[2] =	(write_data & 0x07)<< 5;		
	SPI_3Byte();									

}
//-------------------------------------------
void call_write_power(unsigned char I_PRE_PA,unsigned char I_PA)
{
	SendBuf[0] = 0x00;
	SendBuf[1] = 0x00;
	SendBuf[2] = 0x00;	
	SendBuf[0] = Write_RAM2 | ((4&0x0f)<<1);
	SendBuf[0] |= (unsigned char)((I_PRE_PA&0X10) >> 4);
	SendBuf[1] = ((I_PRE_PA&0x0F) << 4);
	SPI_3Byte();	
		
//下边行地址5要改为6
//	SendBuf[0] = Read_RAM2 | (unsigned char)((5&0x0f)<<1);		//鍏堟妸鍘熸潵鐨勫唴瀹硅鍑篟AM2@5
	SendBuf[0] = Read_RAM2 | (unsigned char)((6&0x0f)<<1);		
	SendBuf[1] = 0x00;
	SendBuf[2] = 0x00;	
	SPI_3Byte();									


	SendBuf[0] = 0x00;
	SendBuf[1] = 0x00;
	SendBuf[0] = Write_RAM2 | ((6&0x0f)<<1);			//old  	SendBuf[0] = Write_RAM2 | ((5&0x0f)<<1);
	SendBuf[0] |= (unsigned char)((I_PA&0X10) >> 4);
	SendBuf[1] = ((I_PA&0x0F) << 4);
	SendBuf[1] |= (RecvBuf[1]&0x01);
	SendBuf[2] = RecvBuf[2];
	SPI_3Byte();		
}
//-------------------------------------------
void call_write_channel_frequency(unsigned long w_data)
{
	SendBuf[0] = Read_RAM2 | (unsigned char)((14&0x0f)<<1);		
	SendBuf[1] = 0x00;
	SendBuf[2] = 0x00;	
	SPI_3Byte();									


	SendBuf[0] = 0x00;
	SendBuf[1] = 0x00;
	SendBuf[0] = Write_RAM2 | ((14&0x0f)<<1);
	SendBuf[1] = (unsigned char)((w_data&0X0001f) << 2);
	SendBuf[2] = RecvBuf[2];										
	SendBuf[1] |= (RecvBuf[1]&0x03);
	SPI_3Byte();		
	
	wait_RF2401_did_command();
	write_ram2_RF2401(15,((w_data&0x1ffe0)>>5));	
}
//-------------------------------------------
void call_set_rf_power(void)						// set RF TX POWER
{
	SPI_1Byte(Stop_Micro);
	
	switch (power)
	{
		case	0:
			call_write_power(0,2);					//power:-16.9
		break;
		
		case	1:
			call_write_power(0,7);					//power:-10.9
		break;
		
		case	2:
			call_write_power(1,3);					//power:-3.07
		break;
		
		case	3:
			call_write_power(2,2);					//power:-0.4
		break;
		
		case	4:
			call_write_power(5,1);					//power:2.77
		break;
		
		case	5:
			call_write_power(5,2);					//power:5.43
		break;
		
		case	6:
			call_write_power(7,2);					//power:7.1
		break;
		
		case	7:
			call_write_power(13,11);				//power:10.43
		break;
		
		default:
			break;
	}
	SPI_1Byte(Start_Micro);
}
//-------------------------------------------
void call_rom_boot(unsigned int rom_address)
{
	SendBuf[0] = ROM_Boot | (unsigned char)((rom_address&0x100)>>8);	
	SendBuf[1] = (unsigned char)(rom_address&0x0ff);
	SPI_2Byte();									
}
//-------------------------------------------
void call_set_rf_data_rate(void)									// set RF RATE
{
	switch (rate)
	{
		case	dr_1p5k:
			write_ram2_RF2401(12,0x180);								//channel data rate is 1.5	
		break;
		
		case	dr_3k:
			write_ram2_RF2401(12,0x2c0);								//channel data rate is 2.99	
		break;
		
		case	dr_6k:
			write_ram2_RF2401(12,0x45f);								//channel data rate is 6.02	
		break;
		
		case	dr_12k:
			write_ram2_RF2401(12,0x62f);								//channel data rate is 12.037	
		break;
					
		case	dr_24k:
			write_ram2_RF2401(12,0x817);								//channel data rate is 24.074	
		break;
		
		case	dr_48k:
			write_ram2_RF2401(12,0xa0b);								//channel data rate is 48.15	
		break;
		
		case	dr_72k:
			write_ram2_RF2401(12,0xc07);								//channel data rate is 72.22	
		break;
	}
}
//-------------------------------------------
void call_set_rf_auto_data_rate(void)									// set high sensitivity mode 
{
		switch (rate)
		{
			case	0:
					write_ram2_RF2401(12,0x180);						//channel data rate is 1.5KHz	
					break;
			case	1:
					write_ram2_RF2401(12,0x2c0);						//channel data rate is 2.99KHz	
					break;
			case	2:
					write_ram2_RF2401(12,0x45f);						//channel data rate is 6.02KHz	
					break;
			case	3:
					write_ram2_RF2401(12,0x62f);						//channel data rate is 12.037KHz	
					break;			
			case	4:
					write_ram2_RF2401(12,0x623);						//channel data rate is 24.074KHz	
					break;
			default:
					write_ram2_RF2401(12,0x180);						//channel data rate is 1.2KHz	
					break;
		}	

}
//-------------------------------------------
void call_init_RF2401(void)								// initial RF2401
{	
	RF2401_EN_REG=0;				
	delay_x10ms(10);     
	RF2401_EN_REG=1;					
	delay_x10ms(10);  

	write_ram2_RF2401(0X00,0XE04);					
	delay_x10ms(10); 
	SPI_1Byte(Clear_IRQ);							
	reset_RF2401();
	RF2401_status = RF2401_ACTIVE;					
}
//-------------------------------------------
void reset_RF2401(void)									// reset RF2401
{
	if(rate>=dr_24k)
		high_sen = 0;
	else
		high_sen = 1;
		
	call_rom_boot(0x000);							
	write_ram1_RF2401(13,1184);						
	SPI_1Byte(Start_Micro);							
	
	while(!RF2401_IRQ)
	{
		wdtr = 0;
		wdtr = 0xff;
	}	
	
	SPI_1Byte(Clear_IRQ);							
	call_rom_boot(64);	
	//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//DI002 VCO autocal subroutine located in ROM has some bug. To auto calibrate the VCO, after executing SPI
//command ROM_Boot with address 64, execute following Write_RAM1 SPI instructions            
  		write_ram1_RF2401(0X03,0X348);					//RAM1@0X03 = 0X348
  		write_ram1_RF2401(0X0E,0X931);					//RAM1@0X0E = 0X931
  		write_ram1_RF2401(0X19,0XB3A);					//RAM1@0X19 = 0XB3A
  		write_ram1_RF2401(0X1A,0X935);					//RAM1@0X1A = 0X935
   		write_ram1_RF2401(0X2C,0X939);					//RAM1@0X2C = 0X939
  		write_ram1_RF2401(0X31,0X300);					//RAM1@0X31 = 0X300
  		write_ram1_RF2401(0X32,0XFC4);					//RAM1@0X32 = 0XFC4
  		write_ram1_RF2401(0X33,0XBFF);					//RAM1@0X33 = 0XBFF
  		write_ram1_RF2401(0X34,0X90F);					//RAM1@0X34 = 0X90F
  		write_ram1_RF2401(0X35,0XB80);					//RAM1@0X35 = 0XB80
  		write_ram1_RF2401(0X36,0X300);					//RAM1@0X36 = 0X300
  		write_ram1_RF2401(0X37,0XEC4);					//RAM1@0X37 = 0XEC4
  		write_ram1_RF2401(0X38,0X91B);					//RAM1@0X38 = 0X91B
  		write_ram1_RF2401(0X39,0X300);					//RAM1@0X39 = 0X300
  		write_ram1_RF2401(0X3A,0XFC4);					//RAM1@0X3A = 0XFC4
  		write_ram1_RF2401(0X3B,0X408);					//RAM1@0X3B = 0X408
  		write_ram1_RF2401(0X3C,0X340);					//RAM1@0X3C = 0X340
  		write_ram1_RF2401(0X3D,0XC08);					//RAM1@0X3D = 0XC08
  		write_ram1_RF2401(0X3E,0X92D);					//RAM1@0X3E = 0X92D
													
	delay_x10ms(10); 
	
	write_ram1_RF2401(53,2944);							// 2440MHz
	
	SPI_1Byte(Start_Micro);								// start micro
	//wait IRQ
	while(!RF2401_IRQ)
	{
		wdtr = 0;
		wdtr = 0xff;	
	}	
	SPI_1Byte(Clear_IRQ);								// VCO PLL is right

	if(high_sen == 1)									// is high sensitivity mode
	{													
		call_set_rf_auto_data_rate();					
		wait_RF2401_did_command();
	}
	
	call_set_rf_power();								// set TX POWER
	wait_RF2401_did_command();
	change_pair_address(98);						
	wait_RF2401_did_command();
	
	call_write_channel_frequency(60494);				// set frequency 2440MHz
		
	if (high_sen == 1)									// high sensitivity				
	{												
		call_rom_boot(256);								
	}
	else												// normal mode 
	{
		SPI_1Byte(Stop_Micro);
		call_rom_boot(320);								
		call_set_rf_data_rate();					
	}
	delay_x10ms(10); 							
	SPI_1Byte(Start_Micro);
	delay_x10ms(10); 
}
//-------------------------------------------
void wake_up_RF2401(void)
{
	if (RF2401_status != RF2401_SLEEP)					// if in sleep mode,then EN_REG always LOW
	{													
		RF2401_EN_REG=0;								
		delay_10ms();     
	}
	RF2401_EN_REG=1;									// EN_REG low to high,wake up(sleep to stand by mode) 
	RF2401_status = RF2401_ACTIVE;					
	nop_10();

	write_ram2_RF2401(0X00,0XE04);
	delay_10ms();
	reset_RF2401();	
}
//-------------------------------------------
void RF2401_TX_DATA(void)								// send packet		
{							
	unsigned char w_data,i;

	w_data = 2;
	write_TXFIFO_RF2401(TX_PAYLOAD_SIZE);				// write packet length into buffer(first byte)
		
	for (i=0;i < TX_PAYLOAD_SIZE;++i)					// write 8 bytes(2/3/4/5/6/7/8/9)
	{
		write_TXFIFO_RF2401(w_data);	
		++w_data;
	}

   	RecvBuf[0]=SPI_1Byte(Send_TXFIFO);
   	while (!RF2401_IRQ)
   	{
   		wdtr = 0;
		wdtr = 0xff;	
   	}	
   	SPI_1Byte(Clear_IRQ);  
}
//-------------------------------------------
void RF2401_TX_ACK(void)									//send ACK (9/8/7/6/5/4/3/2)	
{											
	unsigned char i,w_data;
	w_data = 9;
	write_TXFIFO_RF2401(0x08);
	for (i=0;i < 8;++i)								
	{
		write_TXFIFO_RF2401(w_data);			
		--w_data;
	}
   	RecvBuf[0]=SPI_1Byte(Send_TXFIFO);
   	while (!RF2401_IRQ)
   	{
   		wdtr = 0;
		wdtr = 0xff;	
   	}	
   	SPI_1Byte(Clear_IRQ); 
}
//-------------------------------------------
unsigned char read_RF2401_data(unsigned char r_mode)		// read RX FIFO
{			
	unsigned char i,payload_size;
	
	payload_size = 31;
	for (i=0;i<32;++i)
		RXData[i] = 0x00;
		
	SPI_1Byte(Clear_IRQ);
	for (i=0;payload_size != 0;i++)						 	// read out all datas from buffer
	{
		SendBuf[0] = Read_RXFIFO;							// read out packet length
		SendBuf[1] = 0x00;
		SPI_2Byte();					
		RXData[i]= RecvBuf[1];								
		payload_size = read_RXFIFO_size();					// if RX FIFO EMPTY?
	}

	i = 1;													// compare RX content
	if (r_mode == R_DATA)									
	{														
		if (RXData[1] != 2)	{ i = 0;	}
		if (RXData[2] != 3)	{ i = 0;	}				
		if (RXData[3] != 4)	{ i = 0;	}				
		if (RXData[4] != 5)	{ i = 0;	}
		if (RXData[5] != 6)	{ i = 0;	}				
		if (RXData[6] != 7)	{ i = 0;	}				
		if (RXData[7] != 8)	{ i = 0;	}
		if (RXData[8] != 9)	{ i = 0;	}
	}
	else								
	{
		if (RXData[1] != 9)	{ i = 0;	}
		if (RXData[2] != 8)	{ i = 0;	}				
		if (RXData[3] != 7)	{ i = 0;	}				
		if (RXData[4] != 6)	{ i = 0;	}
		if (RXData[5] != 5)	{ i = 0;	}				
		if (RXData[6] != 4)	{ i = 0;	}				
		if (RXData[7] != 3)	{ i = 0;	}
		if (RXData[8] != 2)	{ i = 0;	}
	}
	if (i == 1) 
		return (r_true);
	else
		return (r_false);
}
//-------------------------------------------
void RF2401_PwrDown(void)	
{
    RF2401_EN_REG=0;					//"EN_REG" to low, RF2401 then enter power down(sleep) mode
    RF2401_status = RF2401_SLEEP;   
}
//**********************************************************
//*********************** SUBROUTINE ***********************
//**********************************************************
void sysclk_cfg()						// system clock initial
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
	hra01 = 1;							// on-chip 8M
	cm14 = 1;
	prc0 = 0;
}
//-------------------------------------------
void port_init(void)					// initial PORT
{
	pd1 = 0b11111000;
	p1 = 0b00000111;
	pd3 = 0b10111000;
	p3 = 0b00101000;
	pd4 = 0b00100000;
	p4 = 0b00000000;	
	pur0 = 0x04;
	pur1 = 0x00;
	drr = 0x00;
}
//-------------------------------------------
void delay_10ms(void)
{
	int i;
	for(i = 0; i<2790; i++)
	{
		asm("NOP");
		asm("NOP");
		asm("NOP");
		asm("NOP");
		asm("NOP");
	}		
	wdtr = 0;
	wdtr = 0xff;							// clr watchdog
}	
//-------------------------------------------
void delay_x10ms(unsigned int dx10ms)
{
	unsigned int j;
	
	for(j = 0; j<dx10ms; j++)
		delay_10ms();	
}	
//-------------------------------------------
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
//-------------------------------------------
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
	count_1s++;
	if(count_1s == 30)	
	{
		count_1s = 0;
		reach_1s = 1;	
	}	
}	

