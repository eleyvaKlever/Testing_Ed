/***********************************************************                                                          
*  File name:	flash.c
*  Describe:	
*  Device:	
*  CPU:		R5F211B4
*  Write by:	
*  Version:	1.0
***********************************************************/
#include "define.h"
#include "flash.h"

unsigned char *write_addr;              /*  Write address   */
unsigned char block_select;             /*  Block select flag   */
unsigned char write_data[RECORD_SIZE];   /*  wirte data  */
unsigned char result;
unsigned char flash_cfg[6];

/************************************************************************************
Name:        write_address_init
Parameters:  None
Returns:     None
Description: Write address initialize
************************************************************************************/

void write_address_init()
{
	int i,j;
	unsigned char *read_addr;
	
    prcr = 0x02;
     //pm1 = 0x01;                         /*  Data block enable   */
    pm1 = 0x05;
    prcr = 0;
    fmr4 = 0x00;                        /*  Erase suspend mode disable  */    
    
    //write_addr = BLOCK_A;                   /*  first sarch address */
       
   	if(!flash_first())
   	{
	    /*  Brank record check  */
	   	while( write_addr <= BLOCK_B_END )
	    {
	        /*  Record all ff check */
	        for(j = 0; j < RECORD_SIZE; j++)
	        {
	            if( write_addr[j] != 0xff ) break;
	        }
	        if (j == RECORD_SIZE) break;
	        write_addr = write_addr + RECORD_SIZE;              /*  Check address renew */
	    }
	    
	    flash_load(write_addr - RECORD_SIZE);    
	    
	    if(write_addr >= BLOCK_B_END+1)
	    {
	        /*  if BLOCK A and BLOCK B are full then BLOCK A erase  */
	        block_erase(BLOCK_A);
	        write_addr = BLOCK_A;
	        block_select = BLOCK_A_SELECT;
	    }
	    
	    else if(write_addr >= BLOCK_B)
	    {
	        /*  Use BLOCK B */
	        block_select = BLOCK_B_SELECT;
	    }
	    
	    else
	    {
	        /*  Use BLOCK A */
	        block_select = BLOCK_A_SELECT;
	    }	
	}    	
	
	else
	{		
		config_reset();	
		write_addr = BLOCK_A; 
		flash_rewrite(flash_cfg);
	}	
}	
/************************************************************************************
Name:        flash_first
Parameters:  None
Returns:     0/1
Description: judge if first
************************************************************************************/
unsigned char flash_first()			// check if all ff??
{
	
	for(write_addr = BLOCK_A; write_addr <= BLOCK_B_END; write_addr++)
	{
		if( *write_addr != 0xff ) break;
	}
	
	if (write_addr <= BLOCK_B_END) 
	{	
		write_addr = BLOCK_A;                   /*  first search address */
		return	0;
	}	
	else
	{	
		write_addr = BLOCK_A;                   /*  first search address */
		return	1;	
	}	
}	


void flash_load(unsigned char *read_addr)
{
	unsigned char i;
	
	for(i=0;i<RECORD_SIZE;i++)
		flash_cfg[i] = read_addr[i];		
}

/************************************************************************************
Name:        flash_rewrite
Parameters:  Write record data
Returns:     Result (Complete or program error or erase error)
Description: Initial setting of SFR registers
************************************************************************************/
unsigned char flash_rewrite(unsigned char *data)
{
    unsigned char result = COMPLETE;
    
    if( (block_select == BLOCK_A_SELECT) && ((write_addr+RECORD_SIZE) > BLOCK_A_END) )
    {
        /*  BLOCK A all write   */
        if( block_erase( BLOCK_B ) != COMPLETE )
        {
            /*  Erase error occurence   */
            result = result | ERASE_ERR;
        }
        block_select = BLOCK_B_SELECT;
        write_addr = BLOCK_B;
    }
    else if( (block_select == BLOCK_B_SELECT) && ((write_addr+RECORD_SIZE) > BLOCK_B_END) )
    {
        /*  BLOCK B all write   */
        if( block_erase( BLOCK_A ) != COMPLETE )
        {
            /*  Erase error occurence   */
            result = result | ERASE_ERR;
        }
        block_select = BLOCK_A_SELECT;
        write_addr = BLOCK_A;
    }
    
    if( data_write( data ) != COMPLETE )
    {
        /*  Program error occurence */
        result = result | PROGRAM_ERR;      /*  if program error    */
    }
    /*  Next write address update   */
    write_addr = write_addr + RECORD_SIZE;
    
    return result;
    
}


/************************************************************************************
Name:        block_erase
Parameters:  Erase block address
Returns:     Erase result
Description: Block erase
************************************************************************************/
unsigned char block_erase(unsigned char *ers_addr)
{
    unsigned char erase_result;
    /*  If use interrupt then clear i flag...   */
    asm("fclr   i   "); 
    
    /*  flash control register set  */
    fmr0 = 0x01;
    asm(" ");       /*  Description for preventing the abbreviation by optimization */
    fmr0 = 0x03;                        /*  CPU rewrite enable  */
    fmr1 = 0x80;
    asm(" ");       /*  Description for preventing the abbreviation by optimization */
    fmr1 = 0x82;                        /*  EW1 mode    */
    
    *ers_addr = 0x20;                   /*  Block erase command write   */
    *ers_addr = 0xd0;                   /*  Block erase command write   */
    while( fmr00 != 1 );                /*  Ready check */
    
    /*  Erase status check  */
    if( fmr07 == 1 )
    {
        *ers_addr = 0x50;               /*  Clear stutus register   */
        erase_result = ERASE_ERR;
    }
    else
    {
        erase_result = COMPLETE;
    }
    /*  flash control register reset    */
    fmr0 = 0x01;                    /*  CPU rewrite disable */

    /*  If use interrupt then set i flag... */
    asm("fset   i   "); 

    return  erase_result;
}

/************************************************************************************
Name:        data_write
Parameters:  Record data address
Returns:     Program result
Description: Record program
************************************************************************************/
unsigned char data_write( unsigned char *write_data )
{
    unsigned char program_result = COMPLETE;
    int i;                              /*  loop counter    */
    
    /*  If use interrupt then clear i flag...   */
    asm("fclr   i   ");

    /*  flash control register set  */
    fmr0 = 0x01;
    asm(" ");       /*  Description for preventing the abbreviation by optimization */
    fmr0 = 0x03;                        /*  CPU rewrite enable  */
    fmr1 = 0x80;
    asm(" ");       /*  Description for preventing the abbreviation by optimization */
    fmr1 = 0x82;                        /*  EW1 mode    */
    
    for( i = 0; i < RECORD_SIZE; i++ )
    {
        write_addr[i] = 0x40;
        write_addr[i] = write_data[i];
        while( fmr00 != 1 );            /*  Ready check */
        /*  Program status check    */
        if( fmr06 == 1 )
        {
            /*  Program error   */
            *write_addr = 0x50;         /*  Clear stutus register   */
            program_result = PROGRAM_ERR;
            break;
        }
    }
    
    /*  flash control register reset    */
    fmr0 = 0x01;                        /*  CPU rewrite disable */
    
    /*  If use interrupt then set i flag... */
    asm("fset   i   ");

    return program_result;
}


void config_reset()
{
	flash_cfg[0] = 4;
	flash_cfg[1] = 3;
	flash_cfg[2] = 3;
	flash_cfg[3] = 7;
	flash_cfg[4] = dr_1p2;
	flash_cfg[5] = tx_normal;
}
//-------------------------------------------
