#include <built_in.h>
#include "Hardware.h"
#include "Global_Defs.h"
#include "RFM69_driver.c"

void main() {
Hardware_Init();                               // Mando llamar a la funcion de inicio de hardware a emplear.
//for(SysTime=0;SysTime<16;);                       //delay for stabilize
 TypeID = 0x69;
 FreqSel = 2;                      //433 Mhz
 set_frame = 0;
 rfm_br = 24;
 rfm_pwr = 13;
 rfm_fdev = 350;
 RFM69_Config();
 UART1_Write(Get_temperature_value(0x4F));
// RxStatus_F = 0;
 //TxStatus_F = 0;
 //rf69_dp_rxcount = 0;*/

}