#include "RFM69_driver.h"

/**************************************************************************************************
* Function Radio_ReadByte()
* -------------------------------------------------------------------------------------------------
* Overview: Function that reads the byte from the address
 
**************************************************************************************************/
unsigned char SPIReadByte(unsigned long WrPara)
{
unsigned int wAddr, wData;
unsigned char temp;
 wAddr = WrPara >> 8 & 0xff;                               // Extraigo la Dirección de escritura de 1 Byte
 wData = WrPara & 0xff;                                    // Extraigo el Valor que escribiré
 
 CS_Radio_Select_bit = 0;

  SPI2_Write(wAddr);
  temp = SPI2_Read(0);
  CS_Radio_Select_bit = 1;
  return temp;
}

/******************************************************************************
**Name£º    Radio Write Byte()
 
******************************************************************************/
void SPIWriteByte(unsigned int WrPara, int SPIPort)                                                                
{                                                       
 unsigned int wAddr, wData;
 WrPara |= 0x8000;                                          // Agrego el bit en 1 en el byte alto para escribir via SPI 
 wAddr = WrPara >> 8 & 0xff;                                // Extraigo la Dirección de escritura de 1 Byte
 wData = WrPara & 0xff;                                     // Extraigo el Valor que escribiré
 if( SPIPort == 2)                                                        // Si esta definido el SPI2 por el configuro el radio
        {
          CS_Radio_Select_bit = 0;                  		// Selecciono el periferico para usarlo
          SPI2_Write(wAddr);                        		// Escibo la dirección donde quiero afectar el registro
          SPI2_Write(wData);                        		// Escribo el dato en la direccion que seleccione
          CS_Radio_Select_bit = 1;                  		// Deselecciono el periferico
          //UART1_Write(wData);
        }        

}         

/******************************************************************************
**Name£º    RFM69_Config
**Function£ºInitialize RFM69 & set it entry to standby mode
**Input£º   none
**Output£º  none
******************************************************************************/
void RFM69_Config(void)
{
 char i=0;
 for(i=0;i<3;i++)
 {
    SPIWriteByte(RF69FreqTbl[FreqSel][i],2);
 }
 i=0;
 for(i=0;i<21;i++)
    {                        //base parameters
     SPIWriteByte(RF69ConfigTbl[i],2);
    }
i=0;
// Prueba de datos leidos
/*for(i=0;i<3;i++)
 {
 	UART1_Write(SPIReadByte(RF69FreqTbl[FreqSel][i]));
 }
i=0;
 for(i=0;i<21;i++)
    {                        //base parameters
     UART1_Write(SPIReadByte(RF69ConfigTbl[i]));
    }*/

}
/******************************************************************************
**Function: enable temperature sensor and read the value of it
**Input:    none
**Output:   temperature value
******************************************************************************/
int Get_temperature_value(unsigned char addr)
{
	char COURSE_TEMP_COEF = -90;
	unsigned char REG_TEMP1 = 0x4E;
    unsigned char REG_TEMP2 = 0x4F;

		//(int(~self.readReg(REG_TEMP2)) * -1) + COURSE_TEMP_COEF + calFactor
    char temp;
	RFM69_Config();
	SPIWriteByte(0x4E08,2);
    SPIWriteByte(0x4F00,2);
    delay_ms(2); //for(SysTime=0;SysTime<10;);
    temp = (((SPIReadByte(addr)) * -1) + COURSE_TEMP_COEF) -31;

    return(temp);
}