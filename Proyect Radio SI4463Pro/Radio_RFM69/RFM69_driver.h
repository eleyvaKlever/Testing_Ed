#ifndef RFM69_driver_H
#define RFM69_driver_H 

//#define FREQ_SEL                2                //0-----315MHz
                                //1-----434MHz
                                //2-----868MHz
                                //3-----915MHz
        

const unsigned short RF69FreqTbl[5][3] = {
        {0x0000, 0x0000, 0x0000},
        {0x074e, 0x08c0, 0x0900},        //315MHz
        {0x076c, 0x0880, 0x0900},        //434MHz
        {0x07d9, 0x0800, 0x0900},        //868MHz
        {0x07e4, 0x08c0, 0x0900},        //915MHz
                                   };

const unsigned short RF69ConfigTbl[21] = {
      // MSByte Address  LSByte Value
        0x0200,                 //RegDataModul                 FSK Packet
              //0x0208,         //RegDataModul                 OOK Packet        
        0x0502,                 //RegFdevMsb                241*61Hz = 35.2KHz        
        0x0641,                 //RegFdevLsb
              //0x0503,         //RegFdevMsb                50KHz        
              //0x0633,         //RegFdevLsb
        0x0334,                 //RegBitrateMsb                32MHz/0x3410 = 2.4kpbs
        0x0410,                 //RegBitrateLsb
                                //0x0301,         //RegBitrateMsb                32MHz/0x0190 = 80kpbs
                                //0x0490,         //RegBitrateLsb
        0x130F,                 //RegOcp                        Disable OCP
        0x1888,                 //RegLNA            200R        
             //0x1952,          //RegRxBw                        RxBW  83KHz
        0x1949,                 //RegRxBw                        RxBW  200KHz

        0x2687,                 // close clkout and set DIO4 Rxready

        0x2C00,                 //RegPreambleMsb        
        0x2D02,                 //RegPreambleLsb        2Byte Preamble
        0x2E90,                 //enable Sync.Word        2+1=3bytes
        0x2FAA,                 //0xAA                                SyncWord = aa2dd4
        0x302D,                 //0x2D
        0x31D4,                 //0xD4
                        
        0x3700,                 //RegPacketConfig1  Disable CRC£¨NRZ encode
        0x3815,                 //RegPayloadLength  21bytes for length & Fixed length
                                //0x3804,         //RegPayloadLength  4bytes for length & Fixed length
        0x3C95,                 //RegFiFoThresh        
                        
        0x581B,                 //RegTestLna        Normal sensitivity
                                //0x582D ,        //RegTestLna        increase sensitivity with LNA (Note: consumption also increase!)
        0x6F30,                 //RegTestDAGC       Improved DAGC
                                //0x6F00,       //RegTestDAGC       Normal DAGC
        0x0104                  //Ω¯»ÎStandby   
                                                        };

const unsigned short RF69RxTable[5] = {
        0x119F,         //RegPaLevel Fifo In for Rx
        0x2544,         //DIO Mapping for Rx
        0x5A55,         //Normal and TRx
        0x5C70,         //Normal and TRx                
        0x0110          //Entry to Rx
                              };

const unsigned short RFM69TxTable[5] = {
        0x2504,         //
        0x119F,         //RegPaLevel 13dBm
        0x5A55,         //Normal and TRx 
        0x5C70,         //Normal and TRx        
        0x010C,         //Entry to Tx
                             };
const unsigned short RFM69ListenTable[6] = {
        0x0DE4,         // Idle resolution 262mS,Rx resolution time 4.1ms
        0x0E0A,         //Idle time 2620ms
        0x0F0A,         //Rx time 41ms
        0x2A10,         // |
        0x2B10,         // | total Rx time 105mS
        0x29A0          // RssiThreshold -80dBm
                        //0x0140          //enable the listen mode
                              };
                             
const unsigned char RFM69Data[] = {"HopeRF RFM COBRFM69-S"};

unsigned char SPIReadByte(unsigned long address);
void SPIWriteByte(unsigned int WrPara, int SPIPort);
void RFM69_Config(void);
char Get_temperature_value(char addr);
/*void RFM69_EntryListen(void);
void RFM69_CloseListen(void);
void RFM69_OpenListen(void);
char RFM69_EntryRx(void);
char RFM69_EntryTx(void);
void RFM69_ClearFIFO(void);
void RFM69_Sleep(void);
void RFM69_Standby(void);
char RFM69_RxPacket(void);
void RFM69_TxPacket(void);
char Get_temperature_value(char addr);*/
#endif