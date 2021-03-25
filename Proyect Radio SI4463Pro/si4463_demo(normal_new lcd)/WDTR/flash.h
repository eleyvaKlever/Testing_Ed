/***********************************************************                                                          
*  File name:	flash.h
*  Describe:	
*  Device:	
*  CPU:		R5F211B4
*  Write by:	
*  Version:	1.0
***********************************************************/
#ifndef FLASH_H
#define FLASH_H


/*  Definition of const data    */
#define BLOCK_A     ((unsigned char *)0x2400)       /*  BLOCK A first address   */
#define BLOCK_A_END ((unsigned char *)0x27ff)       /*  BLOCK A last address    */
#define BLOCK_B     ((unsigned char *)0x2800)       /*  BLOCK B first address   */
#define BLOCK_B_END ((unsigned char *)0x2bff)       /*  BLOCK B last address    */

//#define RECORD_PER_BLOCK    102          /*  Record number per 1 block   */
#define RECORD_SIZE         6         /*  Record size */

#define BLOCK_A_SELECT      0           /*  Use BLOCK A */
#define BLOCK_B_SELECT      1           /*  Use BLOCK B */

#define COMPLETE            0x00        /*  FLASH write/erase complete  */
#define PROGRAM_ERR         0x01        /*  FLASH data write error  */
#define ERASE_ERR           0x02        /*  FLASH erase error   */


/* Definition of RAM area */
extern unsigned char *write_addr;              /*  Write address   */
extern unsigned char block_select;             /*  Block select flag   */
extern unsigned char write_data[RECORD_SIZE];   /*  wirte data  */
extern unsigned char result;
extern unsigned char flash_cfg[6];

//extern void flash_erasepage(U16 addr);
//extern void flash_write(U16 dest, U8 *src, U16 nbytes);
//extern void flash_read(U8 *dest, U16 src, U16 nbytes);


//extern void make_data(unsigned char *data);
extern unsigned char flash_first();
extern void flash_load(unsigned char *read_addr);
extern void write_address_init(void);
extern unsigned char flash_rewrite(unsigned char *data);
extern unsigned char block_erase(unsigned char *ers_addr);
extern unsigned char data_write( unsigned char *write_data );
extern void config_reset(void);


#endif