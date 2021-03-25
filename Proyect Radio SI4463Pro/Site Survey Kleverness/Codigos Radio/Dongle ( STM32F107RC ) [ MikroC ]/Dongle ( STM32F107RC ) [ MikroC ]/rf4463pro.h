/**************************************************************************************************************************************************
 * BEGIN OF HEADER
**************************************************************************************************************************************************/
#ifndef __RF4463PRO_H__
#define __RF4463PRO_H__
/*************************************************************************************************************************************************/
/**********************************************************************************************
 * Core Includes
**********************************************************************************************/
#include "main.h"
/**********************************************
 * File Includes
**********************************************/
#include "rf4463commands.h"
#include "rf4463config_2400.h"
#include "rf4463spi.h"
/**********************************************************************************************
 * Documentation group assignation/include
**********************************************************************************************/
/**
 * @addtogroup  RF4463
 * @{
 */
/**********************************************************************************************
 * Definitions
**********************************************************************************************/
#define RF_TX_POWER_20dBm       127     ///< Set Transmission power at 20dBm
#define RF_TX_POWER_17dBm       108     ///< Set Transmission power at 17dBm
#define RF_TX_POWER_15dBm       90      ///< Set Transmission power at 15dBm
#define RF_TX_POWER_10dBm       64      ///< Set Transmission power at 10dBm

#define RF_MAX_BUFFER_LENGTH    64      ///< Set Maximum number of bytes in Rx FIFO

#define GET_INT_STATUS_REPLY_INDEX_CTS              0x00
#define GET_INT_STATUS_REPLY_INDEX_INT_PEND         0x01
#define GET_INT_STATUS_REPLY_INDEX_INT_STATUS       0x02
#define GET_INT_STATUS_REPLY_INDEX_PH_PEND          0x03
#define GET_INT_STATUS_REPLY_INDEX_PH_STATUS        0x04
#define GET_INT_STATUS_REPLY_INDEX_MODEM_PEND       0x05
#define GET_INT_STATUS_REPLY_INDEX_MODEM_STATUS     0x06
#define GET_INT_STATUS_REPLY_INDEX_CHIP_PEND        0x07
#define GET_INT_STATUS_REPLY_INDEX_CHIP_STATUS      0x08

#define GET_INT_STATUS_REPLY_INT_PEND_CHIP_INT_PEND   0x04
#define GET_INT_STATUS_REPLY_INT_PEND_MODEM_INT_PEND  0x02
#define GET_INT_STATUS_REPLY_INT_PEND_PH_INT_PEND     0x01

#define GET_INT_STATUS_REPLY_INT_STATUS_CHIP_INT_STATUS         0x04
#define GET_INT_STATUS_REPLY_INT_STATUS_MODEM_INT_STATUS        0x02
#define GET_INT_STATUS_REPLY_INT_STATUS_PH_INT_STATUS           0x01

#define GET_INT_STATUS_REPLY_PH_PEND_FILTER_MATCH_PEND          0x80
#define GET_INT_STATUS_REPLY_PH_PEND_FILET_MISS_PEND            0x40
#define GET_INT_STATUS_REPLY_PH_PEND_PACKET_SENT_PEND           0x20
#define GET_INT_STATUS_REPLY_PH_PEND_PACKET_RX_PEND             0x10
#define GET_INT_STATUS_REPLY_PH_PEND_CRC_ERROR_PEND             0x08
#define GET_INT_STATUS_REPLY_PH_PEND_ALT_CRC_ERROR_PEND         0x04
#define GET_INT_STATUS_REPLY_PH_PEND_TX_FIFO_ALMOST_EMPTY_PEND  0x02
#define GET_INT_STATUS_REPLY_PH_PEND_RX_FIFO_ALMOST_FULL_PEND   0x01

#define GET_INT_STATUS_REPLY_PH_STATUS_FILTER_MATCH             0x80
#define GET_INT_STATUS_REPLY_PH_STATUS_FILTER_MISS              0x40
#define GET_INT_STATUS_REPLY_PH_STATUS_PACKET_SENT              0x20
#define GET_INT_STATUS_REPLY_PH_STATUS_PACKET_RX                0x10
#define GET_INT_STATUS_REPLY_PH_STATUS_CRC_ERROR                0x08
#define GET_INT_STATUS_REPLY_PH_STATUS_ALT_CRC_ERROR            0x04
#define GET_INT_STATUS_REPLY_PH_STATUS_TX_FIFO_ALMOST_EMPTY     0x02
#define GET_INT_STATUS_REPLY_PH_STATUS_TX_FIFO_ALMOST_FULL      0x01

#define GET_INT_STATUS_REPLY_MODEM_PEND_RSSI_LATCH_PEND         0x80
#define GET_INT_STATUS_REPLY_MODEM_PEND_POSTAMBLE_DETECT_PEND   0x40
#define GET_INT_STATUS_REPLY_MODEM_PEND_INVALID_SYNC_PEND       0x20
#define GET_INT_STATUS_REPLY_MODEM_PEND_RSSI_JUMP_PEND          0x10
#define GET_INT_STATUS_REPLY_MODEM_PEND_RSSI_PEND               0x08
#define GET_INT_STATUS_REPLY_MODEM_PEND_INVALID_PREAMBLE_PEND   0x04
#define GET_INT_STATUS_REPLY_MODEM_PEND_PEAMBLE_DETECT_PEND     0x02
#define GET_INT_STATUS_REPLY_MODEM_PEND_SYNC_DETECT_PEND        0x01

#define GET_INT_STATUS_REPLY_MODEM_STATUS_RSSI_LATCH            0x80
#define GET_INT_STATUS_REPLY_MODEM_STATUS_POSTAMBLE_DETECT      0x40
#define GET_INT_STATUS_REPLY_MODEM_STATUS_INVALID_SYNC          0x20
#define GET_INT_STATUS_REPLY_MODEM_STATUS_RSSI_JUMP             0x10
#define GET_INT_STATUS_REPLY_MODEM_STATUS_RSSI                  0x08
#define GET_INT_STATUS_REPLY_MODEM_STATUS_INVALID_PREAMBLE      0x04
#define GET_INT_STATUS_REPLY_MODEM_STATUS_PEAMBLE_DETECT        0x02
#define GET_INT_STATUS_REPLY_MODEM_STATUS_SYNC_DETECT`          0x01

#define GET_INT_STATUS_REPLY_CHIP_PEND_CAL_PEND                             0x40
#define GET_INT_STATUS_REPLY_CHIP_PEND_FIFO_UNDERFLOW_OVERFLOW_ERROR_PEND   0x20
#define GET_INT_STATUS_REPLY_CHIP_PEND_STATE_CHANGE_PEND                    0x10
#define GET_INT_STATUS_REPLY_CHIP_PEND_CMD_ERROR_PEND                       0x08
#define GET_INT_STATUS_REPLY_CHIP_PEND_CHIP_READY_PEND                      0x04
#define GET_INT_STATUS_REPLY_CHIP_PEND_LOW_BATT_PEND                        0x02
#define GET_INT_STATUS_REPLY_CHIP_PEND_WUT_PEND                             0x01

#define GET_INT_STATUS_REPLY_CHIP_STATUS_CAL                               0x40
#define GET_INT_STATUS_REPLY_CHIP_STATUS_FIFO_UNDERFLOW_OVERFLOW_ERROR     0x20
#define GET_INT_STATUS_REPLY_CHIP_STATUS_STATE_CHANGE                      0x10
#define GET_INT_STATUS_REPLY_CHIP_STATUS_CMD_ERROR                         0x08
#define GET_INT_STATUS_REPLY_CHIP_STATUS_CHIP_READY                        0x04
#define GET_INT_STATUS_REPLY_CHIP_STATUS_LOW_BATT                          0x02
#define GET_INT_STATUS_REPLY_CHIP_STATUS_WUT                               0x01
/**********************************************************************************************
 * Structures
**********************************************************************************************/

/**********************************************************************************************
 * Enumerators
**********************************************************************************************/
enum RF4463ChipState{
    RF4463_CHIP_STATE_NO_CHANGE = 0,
    RF4463_CHIP_STATE_SLEEP,
    RF4463_CHIP_STATE_SPI_ACTIVE,
    RF4463_CHIP_STATE_READY,
    RF4463_CHIP_STATE_READY2,
    RF4463_CHIP_STATE_TX_TUNE,
    RF4463_CHIP_STATE_RX_TUNE,
    RF4463_CHIP_STATE_TX,
    RF4463_CHIP_STATE_RX,
    RF4463_CHIP_STATE_TOTALS
};

enum RF4463Frequency{
    RF4463_FREQUENCY_433MHz = 0,
    RF4463_FREQUENCY_868MHz,
    RF4463_FREQUENCY_915MHz,
    RF4463_FREQUENCY_TOTAL
};
/**********************************************************************************************
 * Functions
**********************************************************************************************/
/**
 *  @addtogroup  Driver
 *  @brief
 *  RF4463Pro API usage functions
 * 
 *  @details
 *  Sub Module that contains all functions that configure and operates the peripheral
 *  @{
 */

/**
 *  @brief 
 *  RF4463 Initialization
 * 
 *  @details
 *  Does a POR Reset to the peripheral\n
 *  Loads the configuration profile to the RF4463Pro MCU, SI4463, through the API\n
 *  And modifies the following internal modules:\n
 *  <table>
 *      <tr><th><center>Command/Property    <th>Summary</center>
 *  	<tr><td>GPIO_PIN_CFG                <td>Configures the GPIO pins.
 *      <tr><td>GLOBAL_XO_TUNE              <td>Configure the internal capacitor frequency tuning bank for the crystal oscillator.
 *      <tr><td>GLOBAL_CONFIG               <td>Global configuration settings.
 *      <tr><td>PREAMBLE_TX_LENGTH          <td>Configure length of TX Preamble.
 *      <tr><td>SYNC_CONFIG                 <td>Sync Word configuration bits.
 *      <tr><td>PKT_CRC_CONFIG              <td>Select a CRC polynomial and seed.
 *      <tr><td>PKT_CONFIG1                 <td>General configuration bits for transmission or reception of a packet.
 *      <tr><td>PKT_LEN                     <td>Configuration bits for reception of a variable length packet.
 *      <tr><td>PKT_FIELD_1_LENGTH          <td>Unsigned 13-bit Field 1 length value.
 *      <tr><td>PKT_FIELD_4_LENGTH          <td>Unsigned 13-bit Field 4 length value.
 *      <tr><td>MODEM_RSSI_CONTROL          <td>Control of the averaging modes and latching time for reporting RSSI value(s).
 *      <tr><td>INT_CTL_ENABLE              <td>This property provides for global enabling of the three interrupt groups (Chip, Modem and Packet Handler) in order to generate HW interrupts at the NIRQ pin.
 *  </table>
 *  
 *  @param[ in ]    usTxChannel 
 *  @param[ in ]    ucRxChannel   
 *  @param[ in ]    usNetwork   Sync Word to be set
 *  @param[ in ]    ucTxPower   Tranmission Power to set
 *  @return None
*/
void vRf4463Init( uint8_t ucSetTxChannel, uint8_t ucSetRxChannel, uint16_t usNetwork, uint8_t ucTxPower, uint8_t ucFrequency );

/**
 *  @brief 
 *  RF4463 POR
 * 
 *  @details
 *  Disables and power down the RF4463 and load the intiial configuration values to signal the restart of the peripheral\n
 * 
 *  @param  None
 *  @return None
*/
void vRf4463PowerOnReset();

/**
 *  @brief 
 * 
 *  @details
 * 
 *  @param[ in ]    ucSetRxChannel
 *  @param[ in ]
 * 
 *  @return None
*/
void vRf4463SetChannels( uint8_t ucSetRxChannel, uint8_t ucSetTxChannel );

/**
 *  @brief 
 * 
 *  @details
 *  
 * 
 *  @param[ in ]    usNetwork
 * 
 *  @return None
*/
void vRf4463SetNetwork( uint16_t usNetwork );

/*********************************************************************
 * RF4463PRO CONFIGURATION FUNCTIONS
*********************************************************************/
/**
 *  @brief Configure the RF4463 according to profile
 * 
 *  @details
 *  Set the RF4463 with the initial data brought by the rf4463config file, which denotes the behaviour of the peripheral
 * 
 *  @param[ in ]    pcParameters            Pointer to the preconstructed array with the data from the configuration file
 *  @param[ in ]    usParametersLength      Amount of data to be transferred
 * 
 *  @return None
*/
void vRf4463SetConfiguration( const uint8_t * pcParameters, uint16_t usParametersLength );

/**
 *  @brief  Passes a configuration buffer to an internal module
 * 
 *  @details
 *  Writes data with a set length from a starting address
 * 
 *  @param[ in ]    ucLength                Number of bytes to be written
 *  @param[ in ]    ucCommand               Starting command address to be written
 *  @param[ in ]    pcParametersBuffer      Pointer to the buffer with the data
 * 
 *  @return SUCCESS if nothing goes wrong
 *  @return NOT_SUCCESS if the device is not available
*/
uint8_t ucRf4463SetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer );

/**
 *  @brief  Get configuration buffer from an internal module
 * 
 *  @details
 *  Reads data from a starting address
 *  
 *  @param[ in ]    ucLength                Number of bytes to be read
 *  @param[ in ]    ucCommand               Starting command addres to be read
 *  @param[ out ]   pcParametersBuffer      Pointer to dummy buffer where the data will be stored
 * 
 *  @return SUCCESS if nothing goes wrong
 *  @return NOT_SUCCESS if the device is not available
*/
uint8_t ucRf4463GetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer );

/**
 *  @brief  Set Property for a RF4463 module
 * 
 *  @details
 *  Set the properties stored in a certain module address
 * 
 *  @param[ in ]    ucStartProperty         16-bit starting address for property to be modified
 *  @param[ in ]    ucLength                Number of bytes to be written from starting address
 *  @param[ in ]    pcParametersBuffer      Pointer to buffer with data
 * 
 *  @return SUCCESS if nothing goes wrong
 *  @return NOT_SUCCESS if the peripheral is not available
*/
uint8_t ucRf4463SetProperty( uint16_t ucStartProperty, uint8_t ucLength, uint8_t * pcParametersBuffer );

/**
 *  @brief  Get Property from a RF4463 module
 * 
 *  @details
 *  Get the properties stored in a certain module address
 * 
 *  @param[ in ]    ucStartProperty         16-bit starting address for property to be read
 *  @param[ in ]    ucLength                Number of bytes to be read from starting address
 *  @param[ out ]   pcParametersBuffer      Pointer to dummy buffer where the data will be stored
 * 
 *  @return SUCCESS if nothing goes wrong
 *  @return NOT_SUCCESS if the peripheral is not available
*/
uint8_t ucRf4463GetProperty( uint16_t ucStartProperty, uint8_t ucLength, uint8_t * pcParametersBuffer );

/**
 *  @brief  Idle Task Handle
 * 
 *  @details None
 * 
 *  @param[ in ] pcSyncWords    2-byte value of the synchronization word (a.k.a Network) as a pointer
 *  @param[ in ] ucLength       Number of bytes to be written from starting address
 * 
 *  @return SUCCESS if nothing goes wrong
 *  @return NOT_SUCCESS if the peripheral is not available
*/
uint8_t ucRf4463SetSyncWords( uint8_t * pcSyncWords, uint8_t ucLength );

/**
 *  @brief  Configure length of TX Preamble.
 * 
 *  @details
 *  None
 * 
 *  @param[ in ] ucLength       Configure length of TX Preamble.
 * 
 *  @return SUCCESS if nothing goes wrong
 *  @return NOT_SUCCESS if the peripheral is not available
*/
uint8_t ucRf4463SetPreambleLength( uint8_t ucLength );

/*********************************************************************
 * RF4463PRO AVAILABILITY CHECK
*********************************************************************/
/**
 *  @brief Clear to Send check
 *  
 *  @details
 *  CTS: Clear to Send.\n
 *  Indicates that the previous command has completed execution and the response byte stream (if any) is valid.\n
 *  The next command may be sent.
 * 
 *  @param[ in ]    None
 *  
 *  @return SUCCESS if device is available
 *  @return NOT_SUCCESS if device is not available
*/
uint8_t ucRf4463CheckCTS();

/**
 *  @brief  Read 
 *  
 *  @details
 *  The value read can be translated as the following equation:\n
 *  <center>RF_Input_Level_dBm = (RSSI_value / 2) - MODEM_RSSI_COMP - 70</center>
 *  The property MODEM_RSSI_COMP provides a fine adjustment between the real strength (in dBm) and the read RSSI value.\n
 *  
 *  A treshold value of -64dBm is appropiate for most applications.\n
 * 
 *  @param[ in ]    None
 *  
 *  @return None
*/
void vRf4463RSSI();

/**
 *  @brief  Returns the last RSSI stored value
 *  
 *  @details
 *  This function can be called whenever a reception is done the value is of type static.
 * 
 *  @param[ in ]    None
 *  
 *  @return Last RSSI registered value
*/
int16_t xRF4463GetLastRSSI();

/**
 *  @brief  Reports basic information about the device.
 *  
 *  @details
 *  Reads Part Number, Part Version, ROM ID, etc.\n
 *  Part Number should match 0x4463 due to the chip being Si4463
 * 
 *  @param[ in ]    None
 *  
 *  @return SUCCESS if the device part does match and the command is received
 *  @return NOT_SUCCESS if the device does not match
*/
uint8_t ucRf4463DeviceAvailability();

/*********************************************************************
 * RF4463PRO RX TX CONFIGURATION FUNCTIONS
*********************************************************************/
/**
 *  @brief  Set GPIO0 and GPIO1 mode
 *  
 *  @details
 * 
 *  @param[ in ]    GPIO0Mode   Set value for GPIO
 *  @param[ in ]    GPIO1Mode   Set value for GPIO
 *  
 *  @return SUCCESS if the device is available and the command is sent
 *  @return NOT_SUCCESS if the device is not available
*/
uint8_t ucRf4463SetGPIOMode( uint8_t ucGPIO0Mode, uint8_t GPIO1Mode );

/**
 *  @brief  Resets FIFO modules for Tx and Rx
 *  
 *  @details
 *  Sends FIFO reset command to RF4463 it does resets for Tx and Rx FIFO areas
 * 
 *  @param[ in ]    None
 *  
 *  @return None
*/
void vRf4463FIFOReset();

/**
 *  @brief  Clear Interrupt values within RF4463
 *  
 *  @details
 *  Returns the interrupt status of ALL the possible interrupt events (both STATUS and PENDING).\n
 *  Optionally, it may be used to clear latched (PENDING) interrupt events.
 * 
 *  @param[ in ]    None
 *  
 *  @return SUCCESS if the device is available and the command is sent
 *  @return NOT_SUCCESS if the device is not available
*/
uint8_t ucRf4463ClearInterrupts();

/**
 *  @brief  Set Standby Mode to RF4463
 *  
 *  @details
 *  Manually switch the chip to a desired operating state
 *  
 *  @param[ in ]    None
 *  
 *  @return SUCCESS if the device is available and the command is sent
 *  @return NOT_SUCCESS if the device is not available
*/
uint8_t ucRf4463EnterStandbyMode();

/*********************************************************************
 * RF4463PRO TX FUNCTIONS
*********************************************************************/
/**
 *  @brief  Set Transmission Mode to RF4463
 *  
 *  @details
 *  Manually switch the chip to a desired operating state
 * 
 *  @param[ in ]    None
 *  
 *  @return None
*/
void vRf4463EnterTxMode();

/**
 *  @brief  Set Interrupt Property for Transmission Mode
 *  
 *  @details
 *  Enables packet handler interrupts to assert NIRQ\n
 * 
 *  @param[ in ]    None
 *  
 *  @return SUCCESS if the device is available and the command is sent
 *  @return NOT_SUCCESS if the device is not available
*/
uint8_t ucRf4463SetTxInterrupt();

/**
 *  @brief  Set Tx Power
 *  
 *  @details
 *  If the Power passed is greater than 127 decimal it is set at the maximum value
 * 
 *  @param[ in ]    ucPower     Transmission Power
 *  
 *  @return SUCCESS if the device is available and the command is sent
 *  @return NOT_SUCCESS if the device is not available
*/
uint8_t ucRf4463SetTxPower( uint8_t ucPower );

/**
 *  @brief  Transfer data to transmit
 *  
 *  @details
 *  Transfer data to transmission FIFO area
 * 
 *  @param[ in ]    pcWriteBuffer   Buffer with the data stored
 *  @param[ in ]    ucLength        Amount of data to be written
 *  
 *  @return None
*/
void vRf4463WriteTxFIFO( uint8_t * pcWriteBuffer, uint8_t ucLength );

/**
 *  @brief  Set and transfer the packet
 *  
 *  @details
 *  Set Tx Mode\n
 *  Reset FIFO\n
 *  Transfer data to Tx FIFO\n
 *  This function only works for RTOS environments
 * 
 *  @param[ in ]    pcSendBuffer    Buffer with the data stored
 *  @param[ in ]    ucSendLength    Amount of data to be transferred
 *  
 *  @return SUCCESS if the device is available and the command is sent
 *  @return NOT_SUCCESS if the device is not available
*/
uint8_t ucRf4463TxPacket( uint8_t * pcSendBuffer, uint8_t ucSendLength );

/**
 *  @brief  Set, Transfer and Wait for Packet transmission
 *  
 *  @details
 *  Set Tx Mode\n
 *  Reset FIFO\n
 *  Transfer data to Tx FIFO\n
 *  Wait until transmission has ended\n
 * 
 *  @param[ in ]    pcSendBuffer    Buffer with the data stored
 *  @param[ in ]    ucSendLength    Amount of data to be transferred
 *  
 *  @return SUCCESS when the packet has been sent and the interruption has ocurred
*/
uint8_t ucRf4463TxPacket_Seq( uint8_t * pcTxBuffer, uint8_t ucTxLength );

/*********************************************************************
 * RF4463PRO RX FUNCTIONS
*********************************************************************/
/**
 *  @brief  Set Reception Mode to RF4463
 *  
 *  @details
 *  Manually switch the chip to a desired operating state
 * 
 *  @param[ in ]    None
 *  
 *  @return None
*/
void vRf4463EnterRxMode();

/**
 *  @brief  Set Interrupt Property for Reception Mode
 *  
 *  @details
 *  Enable pending interrupts in rx mode group to assert nNIRQ.
 * 
 *  @param[ in ]    None
 *  
 *  @return SUCCESS if the device is available and the command is sent
 *  @return NOT_SUCCESS if the device is not available
*/
uint8_t ucRf4463SetRxInterrupt();

/**
 *  @brief  Initialize and configures the RF4463 in reception Mode
 *  
 *  @details
 *  Initialize and configures the RF4463 in reception Mode\n
 *  Sets the value of the packet thresholds and the specifications for reception
 * 
 *  @param[ in ]    None
 *  
 *  @return SUCCESS always
*/
uint8_t ucRf4463RxInit();

/**
 *  @brief  Reads the data stored in reception FIFO
 *  
 *  @details
 *  Reads the data stored in reception FIFO and transfers this data to the destination buffer\n.
 *  It also resets the FIFO area for reception in RF4463
 * 
 *  @param[ out ]   pcRxBuffer Pointer to buffer where the data read from Rx FIFO will be stored
 *  
 *  @return Amount of data read
*/
uint8_t ucRf4463RxPacket( uint8_t * pcRxBuffer );

/**
 *  @brief  Reads 
 *  
 *  @details
 *  The process may be not done if the device is not availoble\n
 *  Reads ands transfers the data from the Rx FIFO area.
 *  Gets the RSSI value after the read is done\n
 * 
 *  @param[ out ]   pcBuffer Pointer to buffer where the data read from Rx FIFO will be stored
 *  
 *  @return None
*/
void vRf4463ReadRxFIFO( uint8_t * pcBuffer );

/**@brief  One sentence that can explain the function
 *  
 *  @details
 *  
 * 
 *  @param[ in ]
 *  @param[ out ]   
 *  
 *  @return
*/
uint8_t ucRF4463GetModemStatus();

/**@brief  One sentence that can explain the function
 *  
 *  @details
 *  
 * 
 *  @param[ in ]
 *  @param[ out ]   
 *  
 *  @return
*/
uint8_t ucRF4463GetIntStatus();

/**@brief  One sentence that can explain the function
 *  
 *  @details
 *  
 * 
 *  @param[ in ]
 *  @param[ out ]   
 *  
 *  @return
*/
uint8_t ucRF4463CheckIntStatus();

/**@brief  One sentence that can explain the function
 *  
 *  @details
 *  
 * 
 *  @param[ in ]
 *  @param[ out ]   
 *  
 *  @return
*/
void vRF4463CheckState();

/**@brief  One sentence that can explain the function
 *  
 *  @details
 *  
 * 
 *  @param[ in ]
 *  @param[ out ]   
 *  
 *  @return
*/
void vRF4463SetState( uint8_t ucState );

/**
 * @}
 */

/**
 * @}
 */
/*************************************************************************************************************************************************/
#endif
/**************************************************************************************************************************************************
 * END OF HEADER
**************************************************************************************************************************************************/