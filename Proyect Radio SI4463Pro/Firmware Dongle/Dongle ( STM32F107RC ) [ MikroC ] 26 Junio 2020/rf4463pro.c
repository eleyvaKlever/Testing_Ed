/*******************************************************************************************************************************************************************************************************
 * File:
 * Author:
 * Editor:
 * Project:
 * Version:
 * 
 * Compiler:
 * IDE:
 * Platform:
 * Kernel:
 * 
 * Notes:|
*******************************************************************************************************************************************************************************************************/
/**********************************************************************************************
 * Prototyping Header
**********************************************************************************************/
#include "rf4463pro.h"

/**********************************************************************************************
 * Global Variables
**********************************************************************************************/

/**********************************************************************************************
 * Local Variables
**********************************************************************************************/
const uint8_t RF4463_CONFIGURATION_DATA[]    = RADIO_CONFIGURATION_DATA_ARRAY;
/**********************************************************************************************
 * Instances
**********************************************************************************************/
// extern RadioParameters_t xRadioParameters;
/**********************************************************************************************
 * Function declaration
**********************************************************************************************/
/*********************************************************************
 * 
*********************************************************************/
uint8_t ucRf4463Init(){
    uint8_t pcBuffer[ 20 ];
    /*********************************************************************
     * RF4463PRO Reset
    *********************************************************************/
    vRf4463PowerOnReset();

    vRf4463SetConfiguration( RF4463_CONFIGURATION_DATA, sizeof( RF4463_CONFIGURATION_DATA ) );

    /*********************************************************************
     * Set Antenna Switch on GPIO2 and GPIO3 ( on SI4463x IC )
     * Do NOT change the settings for GPIO2, GPIO3, nIRQ and SDO Pins
    *********************************************************************/
    pcBuffer[ 0 ] = RF4463_GPIO_NO_CHANGE;
    pcBuffer[ 1 ] = RF4463_GPIO_NO_CHANGE;
    pcBuffer[ 2 ] = RF4463_GPIO_RX_STATE;
    pcBuffer[ 3 ] = RF4463_GPIO_TX_STATE;
    pcBuffer[ 4 ] = RF4463_NIRQ_INTERRUPT_SIGNAL;
    pcBuffer[ 5 ] = RF4463_GPIO_SPI_DATA_OUT;
    ucRf4463SetCommand( 6, RF4463_CMD_GPIO_PIN_CFG, pcBuffer );
    memset( pcBuffer, 20, '\0' );

    /*********************************************************************
     * Frequency Adjustment
    *********************************************************************/
    pcBuffer[ 0 ] = 98;
    ucRf4463SetProperty( RF4463_PROPERTY_GLOBAL_XO_TUNE, 1, pcBuffer );
    memset( pcBuffer, 20, '\0' );

    /*********************************************************************
     * Global Configuration Settings
    *********************************************************************/
    pcBuffer[ 0 ] = 0x00;
    ucRf4463SetProperty( RF4463_PROPERTY_GLOBAL_CONFIG, 1, pcBuffer );
    memset( pcBuffer, 20, '\0' );

    /*********************************************************************
     * RF4463 Preamble
    *********************************************************************/
    pcBuffer[ 0 ] = 0x08;
    pcBuffer[ 1 ] = 0x14;
    pcBuffer[ 2 ] = 0x00;
    pcBuffer[ 3 ] = 0x0F;
    pcBuffer[ 4 ] = RF4463_PREAMBLE_FIRST_1 | RF4463_PREAMBLE_LENGTH_BYTES | RF4463_PREAMBLE_STANDARD_1010;
    pcBuffer[ 5 ] = 0x00;
    pcBuffer[ 6 ] = 0x00;
    pcBuffer[ 7 ] = 0x00;
    pcBuffer[ 8 ] = 0x00;
    ucRf4463SetProperty( RF4463_PROPERTY_PREAMBLE_TX_LENGTH, 9, pcBuffer );

    /*********************************************************************
     * RF4463 Sync Bytes
    *********************************************************************/
    pcBuffer[ 0 ] = ( xRadioParameters.Network >> 8 );
    pcBuffer[ 1 ] = ( xRadioParameters.Network );
    ucRf4463SetSyncWords( pcBuffer, 2 );

    /*********************************************************************
     * RF4463 Set CRC
    *********************************************************************/
    pcBuffer[ 0 ] = RF4463_CRC_SEED_ALL_1S | RF4463_CRC_ITU_T;
    ucRf4463SetProperty( RF4463_PROPERTY_PKT_CRC_CONFIG, 1, pcBuffer );

    pcBuffer[ 0 ] = RF4463_CRC_ENDIAN;
    ucRf4463SetProperty( RF4463_PROPERTY_PKT_CONFIG1, 1, pcBuffer );

    pcBuffer[ 0 ] = RF4463_IN_FIFO | RF4463_DST_FIELD_ENUM_2;
    pcBuffer[ 1 ] = RF4463_SRC_FIELD_ENUM_1;
    pcBuffer[ 2 ] = 0x00;
    ucRf4463SetProperty( RF4463_PROPERTY_PKT_LEN, 3, pcBuffer );

    /*********************************************************************
     * RF4463 Set Length of Field
    *********************************************************************/
    pcBuffer[ 0 ] = 0x00;
    pcBuffer[ 1 ] = 0x01;
    pcBuffer[ 2 ] = RF4463_FIELD_CONFIG_PN_START;
    pcBuffer[ 3 ] = RF4463_FIELD_CONFIG_CRC_START | RF4463_FIELD_CONFIG_SEND_CRC | RF4463_FIELD_CONFIG_CHECK_CRC | RF4463_FIELD_CONFIG_CRC_ENABLE;
    pcBuffer[ 4 ] = 0x00;
    pcBuffer[ 5 ] = 50;
    pcBuffer[ 6 ] = RF4463_FIELD_CONFIG_PN_START;
    pcBuffer[ 7 ] = RF4463_FIELD_CONFIG_CRC_START | RF4463_FIELD_CONFIG_SEND_CRC | RF4463_FIELD_CONFIG_CHECK_CRC | RF4463_FIELD_CONFIG_CRC_ENABLE;
    pcBuffer[ 8 ] = 0x00;
    pcBuffer[ 9 ] = 0x00;
    pcBuffer[ 10 ] = 0x00;
    pcBuffer[ 11 ] = 0x00;
    ucRf4463SetProperty( RF4463_PROPERTY_PKT_FIELD_1_LENGTH_12_8, 12, pcBuffer );

    pcBuffer[ 0 ] = 0x00;
    pcBuffer[ 1 ] = 0x00;
    pcBuffer[ 2 ] = 0x00;
    pcBuffer[ 3 ] = 0x00;
    pcBuffer[ 4 ] = 0x00;
    pcBuffer[ 5 ] = 0x00;
    pcBuffer[ 6 ] = 0x00;
    pcBuffer[ 7 ] = 0x00;
    ucRf4463SetProperty( RF4463_PROPERTY_PKT_FIELD_4_LENGTH_12_8, 8, pcBuffer );

    /*********************************************************************
     * RF4463 Check RSSI Values Configuration
    *********************************************************************/
    pcBuffer[ 0 ] = 0x01;
    ucRf4463SetProperty( RF4463_PROPERTY_MODEM_RSSI_CONTROL, 1, pcBuffer );

    /*********************************************************************
     * RF4463 Set IRQ Properties
    *********************************************************************/
    pcBuffer[ 0 ] = 0x01;
    pcBuffer[ 1 ] = 0x38;
    pcBuffer[ 2 ] = 0x00;
    ucRf4463SetProperty( RF4463_PROPERTY_INT_CTL_ENABLE, 3, pcBuffer );

    /*********************************************************************
     * RF4463 Set Tx Power
    *********************************************************************/
    ucRf4463SetTxPower( xRadioParameters.TxPower );
}

/*********************************************************************
 * 
*********************************************************************/
void vRf4463PowerOnReset(){
     /*
    Después de encender la alimentación, debemos configurar el pin SDN para 10uS
    de alto. Luego, debe dar un retraso máximo de 6 ms para realizar el procedimiento
    interno para POR (reinicio de encendido) .
    Entonces podemos enviar datos de configuración con Power Up a la vanguardia.
    Esperamos CTS después de cada comando enviado .
    De la figura anterior, se puede ver que en cada etapa de inicialización podemos
    usar la comprobación del estado en los pines GPIO1 y nIRQ ,
    pero es un esfuerzo innecesario.
    Todo el proceso de configuración desde el encendido hasta el modo de espera
    completo dura 15 ms .
    */
    uint8_t pcBuffer[ 7 ] = { RF_POWER_UP };

    RF4463nSDN = 1;
    Delay_us( 10 );
    RF4463nSDN = 0;
    Delay_ms( 6 );

    RF4463nSEL = 0;
    vRf4463SPIWriteBuffer( sizeof( pcBuffer ), pcBuffer );
    RF4463nSEL = 1;
}

/**************************************************************************************************
 * RF4463PRO CONFIGURATION FUNCTIONS
**************************************************************************************************/
/*********************************************************************
 * 
*********************************************************************/
void vRf4463SetConfiguration( const uint8_t * pcParameters, uint16_t usParametersLength ){
    uint8_t ucCommandLength = 0;
    uint8_t ucCommand = 0;
    uint8_t pcBuffer[ 30 ];

    uint16_t usPosition = 0;

    usParametersLength  = usParametersLength - 1;
    ucCommandLength     = pcParameters[ 0 ];
    usPosition          = ucCommandLength + 1;

    while( usPosition < usParametersLength ){
        ucCommandLength = ( pcParameters[ usPosition++ ] - 1 );
        ucCommand = pcParameters[ usPosition++ ];
        memcpy( ( uint8_t * )pcBuffer, pcParameters + usPosition, ucCommandLength );
        ucRf4463SetCommand( ucCommandLength, ucCommand, pcBuffer );
        usPosition = usPosition + ucCommandLength;
    }
}

/*********************************************************************
 * 
*********************************************************************/
uint8_t ucRf4463SetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer ){
    if( ucRf4463CheckCTS() == NOT_SUCCESS ){
        return NOT_SUCCESS;
    }

    RF4463nSEL = 0;
    ucRf4463SPIByte( ucCommand );
    vRf4463SPIWriteBuffer( ucLength, pcParametersBuffer );
    RF4463nSEL = 1;
    
    return SUCCESS;
}


/*********************************************************************
 * 
*********************************************************************/
uint8_t ucRf4463GetCommand( uint8_t ucLength, uint8_t ucCommand, uint8_t * pcParametersBuffer ){
    if( ucRf4463CheckCTS() == NOT_SUCCESS ){
        return NOT_SUCCESS;
    }

    RF4463nSEL = 0;
    ucRf4463SPIByte( ucCommand );
    RF4463nSEL = 1;

    if( ucRf4463CheckCTS() == NOT_SUCCESS ){
        return NOT_SUCCESS;
    }

    RF4463nSEL = 0;
    ucRf4463SPIByte( RF4463_CMD_READ_BUF );
    vRf4463SPIReadBuffer( ucLength, pcParametersBuffer );
    RF4463nSEL = 1;

    return SUCCESS;
}

/*********************************************************************
 * 
*********************************************************************/
uint8_t ucRf4463SetProperty( uint16_t usStartProperty, uint8_t ucLength, uint8_t * pcParametersBuffer ){
    uint8_t pcBuffer[ 4 ];

    if( ucRf4463CheckCTS() == NOT_SUCCESS ){
        return NOT_SUCCESS;
    }

    pcBuffer[ 0 ] = RF4463_CMD_SET_PROPERTY;
    pcBuffer[ 1 ] = ( usStartProperty >> 8 );
    pcBuffer[ 2 ] = ucLength;
    pcBuffer[ 3 ] = ( usStartProperty & 0xFF );

    RF4463nSEL = 0;
    vRf4463SPIWriteBuffer( 4, pcBuffer );
    vRf4463SPIWriteBuffer( ucLength, pcParametersBuffer );
    RF4463nSEL = 1;

    return SUCCESS;
}

/*********************************************************************
 * 
*********************************************************************/
uint8_t ucRf4463GetProperty( uint16_t usStartProperty, uint8_t ucLength, uint8_t * pcParametersBuffer ){
    uint8_t pcBuffer[ 4 ];

    if( ucRf4463CheckCTS() == NOT_SUCCESS ){
        return NOT_SUCCESS;
    }

    pcBuffer[ 0 ] = RF4463_CMD_GET_PROPERTY;
    pcBuffer[ 1 ] = ( usStartProperty >> 8 );
    pcBuffer[ 2 ] = ucLength;
    pcBuffer[ 3 ] = ( usStartProperty & 0xFF );

    RF4463nSEL = 0;
    vRf4463SPIWriteBuffer( 4, pcBuffer );

    if( ucRf4463CheckCTS() == NOT_SUCCESS ){
        return NOT_SUCCESS;
    }
    
    RF4463nSEL = 0;
    ucRf4463SPIByte( RF4463_CMD_READ_BUF );
    vRf4463SPIReadBuffer( ucLength, pcParametersBuffer );
    RF4463nSEL = 1;

    return SUCCESS;
}

/*********************************************************************
 * 
*********************************************************************/
uint8_t ucRf4463SetSyncWords( uint8_t * pcSyncWords, uint8_t ucLength ){
    uint8_t pcBuffer[ 5 ];
    
    if( ( ucLength == 0 ) || ( ucLength > 3 ) ){
        return NOT_SUCCESS;
    }

    pcBuffer[ 0 ] = ucLength - 1;
    memcpy( pcBuffer + 1, pcSyncWords, ucLength );
    return ucRf4463SetProperty( RF4463_PROPERTY_SYNC_CONFIG, sizeof( pcBuffer ), pcBuffer );
}

/*********************************************************************
 * 
*********************************************************************/
uint8_t ucRf4463SetPreambleLength( uint8_t ucLength ){
    return ucRf4463SetProperty( RF4463_PROPERTY_PREAMBLE_TX_LENGTH, 1, &ucLength );
}

/**************************************************************************************************
 * RF4463PRO AVAILABILITY CHECK
**************************************************************************************************/
/*********************************************************************
 * 
*********************************************************************/
uint8_t ucRf4463CheckCTS(){
    uint16_t usTimeoutCounter = 0;

    usTimeoutCounter = RF4463_CTS_TIMEOUT;

    while( usTimeoutCounter-- ){
        RF4463nSEL = 0;
        ucRf4463SPIByte( RF4463_CMD_READ_BUF );
        if( ucRf4463SPIByte( RF4463_CMD_READ_BUF ) == RF4463_CTS_REPLY ){
            RF4463nSEL = 1;
            return SUCCESS;
        }
        RF4463nSEL = 1;
    }
    return NOT_SUCCESS;
}

/*********************************************************************
 * 
*********************************************************************/
void vRf4463RSSI(){
    signed char xRSSI;
    uint8_t pcRSSI[ 9 ]; // 9
    // El valor RSSI leído por la API puede traducirse a dBm mediante la siguiente 
    // ecuación lineal: RF_Input_Level_dBm = (RSSI_value / 2) - MODEM_RSSI_COMP - 70 
    // La propiedad MODEM_RSSI_COMP proporciona un ajuste fino de la relación entre el 
    // nivel de entrada de RF real (en dBm) y El valor RSSI devuelto. Es decir, 
    // el ajuste de esta propiedad permite al usuario cambiar la curva de potencia 
    // de entrada RSSI vs RF hacia arriba y hacia abajo. Esto puede ser deseable para 
    // compensar las diferencias en la pérdida de inserción frontal entre múltiples diseños 
    // (por ejemplo, debido a la presencia de un filtro de preselección SAW o un interruptor 
    // de RF). Un valor de MODEM_RSSI_COMP = 0x40 = 64d es apropiado para la mayoría de las 
    // aplicaciones. La evaluación clara del canal (CCA) o la detección del umbral RSSI 
    // también están disponibles. Se puede establecer un umbral RSSI en la propiedad 
    // API MODEM_RSSI_THRESH. 
    // Set properties:           RF_MODEM_RAW_CONTROL_10
    // Number of properties:     10
    // Group ID:                 0x20
    // Start ID:                 0x45
    // Default values:           0x02, 0x00, 0xA3, 0x02, 0x80, 0xFF, 0x0C, 0x01, 0x00, 0x40, 
    // Descriptions:
    //   MODEM_RAW_CONTROL - Defines gain and enable controls for raw / nonstandard mode.
    //   MODEM_RAW_EYE_1 - 11 bit eye-open detector threshold.
    //   MODEM_RAW_EYE_0 - 11 bit eye-open detector threshold.
    //   MODEM_ANT_DIV_MODE - Antenna diversity mode settings.
    //   MODEM_ANT_DIV_CONTROL - Specifies controls for the Antenna Diversity algorithm.
    //   MODEM_RSSI_THRESH - Configures the RSSI threshold.
    //   MODEM_RSSI_JUMP_THRESH - Configures the RSSI Jump Detection threshold.
    //   MODEM_RSSI_CONTROL - Control of the averaging modes and latching time for reporting RSSI value(s).
    //   MODEM_RSSI_CONTROL2 - RSSI Jump Detection control.
    //   MODEM_RSSI_COMP - RSSI compensation value.
    //#define RF_MODEM_RAW_CONTROL_10 0x11, 0x20, 0x0A, 0x45, 0x81, 0x01, 0x47, 0x01, 0x00, 0xFF, 0x06, 0x00, 0x18, 0x40

    ucRf4463GetCommand( 9, RF4463_CMD_GET_MODEM_STATUS , pcRSSI );
    xRSSI = ( ( ( pcRSSI[ 4 ] / 2 ) -64 ) - 60 );

    STM_LOGD( "[ RF4463 ] RSSI: %i\r\n", xRSSI );
}

/*********************************************************************
 * 
*********************************************************************/
uint8_t ucRf4463DeviceAvailability(){
    uint8_t pcBuffer[ 9 ];
    static uint16_t usPartInformation = 0;

    if( ucRf4463GetCommand( 9, RF4463_CMD_PART_INFO, pcBuffer ) == NOT_SUCCESS ){
        return NOT_SUCCESS;
    }

    usPartInformation = ( ( pcBuffer[ 2 ] << 8 ) | pcBuffer[ 3 ] );

    if( usPartInformation != 0x4463 ){
        return NOT_SUCCESS;
    }

    return SUCCESS;
}

/**************************************************************************************************
 * RF4463PRO RX TX CONFIGURATION FUNCTIONS
**************************************************************************************************/
/*********************************************************************
 * 
*********************************************************************/
uint8_t ucRf4463SetGPIOMode( uint8_t ucGPIO0Mode, uint8_t ucGPIO1Mode ){
    uint8_t pcBuffer[ 6 ] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };

    pcBuffer[ 0 ] = ucGPIO0Mode;
    pcBuffer[ 1 ] = ucGPIO1Mode;

    return ucRf4463SetCommand( sizeof( pcBuffer ), RF4463_CMD_GPIO_PIN_CFG, pcBuffer );
}

/*********************************************************************
 * 
*********************************************************************/
void vRf4463FIFOReset(){
    uint8_t ucData = 0x03;

    ucRf4463SetCommand( sizeof( ucData ), RF4463_CMD_FIFO_INFO, &ucData );
}

/*********************************************************************
 * 
*********************************************************************/
uint8_t ucRf4463ClearInterrupts(){
    uint8_t pcBuffer[] = { 0x00, 0x00, 0x00 };

    return ucRf4463SetCommand( sizeof( pcBuffer ), RF4463_CMD_GET_INT_STATUS, pcBuffer );
}

/*********************************************************************
 * 
*********************************************************************/
uint8_t ucRf4463EnterStandbyMode(){
    uint8_t ucData = 0x01;

    return ucRf4463SetCommand( 1, RF4463_CMD_CHANGE_STATE, &ucData );
}

/*********************************************************************
 * 
*********************************************************************/
uint8_t ucRf4463EnterReadyMode(){
    uint8_t ucData = 0x03;

    return ucRf4463SetCommand( 1, RF4463_CMD_CHANGE_STATE, &ucData );
}

/*********************************************************************
 * 
*********************************************************************/
uint8_t ucRf4463WaitnIRQ(){
    return RF4463nIRQ;
}

/**************************************************************************************************
 * RF4463PRO TX FUNCTIONS
**************************************************************************************************/
/*********************************************************************
 * 
*********************************************************************/
void vRf4463EnterTxMode(){
    uint8_t pcBuffer[] = { 0x00, 0x30, 0x00, 0x00 };
    pcBuffer[ 0 ] = xRadioParameters.Channel;
    ucRf4463SetCommand( 4, RF4463_CMD_START_TX, pcBuffer );
}

/*********************************************************************
 * 
*********************************************************************/
uint8_t ucRf4463SetTxInterrupt(){
    uint8_t pcBuffer[ 3 ] = { 0x01, 0x20, 0x00 };
    return ucRf4463SetProperty( RF4463_PROPERTY_INT_CTL_ENABLE, 3, pcBuffer );
}

/*********************************************************************
 * 
*********************************************************************/
uint8_t ucRf4463SetTxPower( uint8_t ucPower ){
    uint8_t pcBuffer[] = { 0x08, 0x00, 0x00, 0x3D };

    if( ucPower > 127 ){
        STM_LOGE( "[ Rf4463 ] Invalid Power Value: %d\r\n", ucPower );
        ucPower = 127;
    }

    pcBuffer[ 1 ] = ucPower;

    return ucRf4463SetProperty( RF4463_PROPERTY_PA_MODE, sizeof( pcBuffer ), pcBuffer );
}


/*********************************************************************
 * 
*********************************************************************/
void vRf4463WriteTxFIFO( uint8_t * pcWriteBuffer, uint8_t ucLength ){
    uint8_t pcBuffer[ 66 ];

    // ucRf4463SetProperty( RF4463_PROPERTY_PKT_FIELD_2_LENGTH_7_0, sizeof( pcBuffer ), &ucLength );
    ucRf4463SetProperty( RF4463_PROPERTY_PKT_FIELD_2_LENGTH_7_0, 1, &ucLength );

    pcBuffer[ 0 ] = ucLength;

    memcpy( pcBuffer + 1, pcWriteBuffer, ucLength );

    ucRf4463SetCommand( ucLength + 1, RF4463_CMD_TX_FIFO_WRITE, pcBuffer );
}

/*********************************************************************
 * 
*********************************************************************/
uint8_t ucRf4463TxPacket( uint8_t * pcTxBuffer, uint8_t ucTxLength ){
    uint8_t pcBuffer[ 3 ];

    ucRF4463TxEvent = 0;

    vRf4463FIFOReset();

    vRf4463WriteTxFIFO( pcTxBuffer, ucTxLength );

    ucRf4463ClearInterrupts();

    vRf4463EnterTxMode();

    ucRF4463TxEvent = 1;

    for( ;; ){
        if( ucRadioEvent == 1 ){
            break;
        }
        Delay_us( 1 );
    }

    ucRf4463GetCommand( 3, RF4463_CMD_REQUEST_DEVICE_STATE, pcBuffer );

    return SUCCESS;
}


/**************************************************************************************************
 * RF4463PRO RX FUNCTIONS
**************************************************************************************************/
/*********************************************************************
 * 
*********************************************************************/
void vRf4463EnterRxMode(){
    uint8_t pcBuffer[] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x08 };
    pcBuffer[ 0 ] = xRadioParameters.Channel;
    ucRf4463SetCommand( 7, RF4463_CMD_START_RX, pcBuffer );
}

/*********************************************************************
 * 
*********************************************************************/
uint8_t ucRf4463SetRxInterrupt(){
    uint8_t pcBuffer[ 3 ] = { 0x03, 0x18, 0x00 };
    return ucRf4463SetProperty( RF4463_PROPERTY_INT_CTL_ENABLE, 3, pcBuffer );
}

/*********************************************************************
 * 
*********************************************************************/
uint8_t ucRf4463RxInit(){
    uint8_t ucLength = 0;

    ucLength = 66;

    ucRf4463SetProperty( RF4463_PROPERTY_PKT_FIELD_2_LENGTH_7_0, 1, &ucLength );

    vRf4463FIFOReset(); 

    // ucRf4463ClearInterrupts();

    vRf4463EnterRxMode();

    return SUCCESS;
}

/*********************************************************************
 * 
*********************************************************************/
uint8_t ucRf4463RxPacket( uint8_t * pcRxBuffer ){
    uint8_t ucRxLength = 0;

    vRf4463ReadRxFIFO( pcRxBuffer );

    vRf4463FIFOReset();

    return ucRxLength;
}

/*********************************************************************
 * 
*********************************************************************/
void vRf4463ReadRxFIFO( uint8_t * pcBuffer ){
    uint8_t * pcReadLength;

    if( ucRf4463CheckCTS() == NOT_SUCCESS ){
        return;
    }

    RF4463nSEL = 0;
    
    ucRf4463SPIByte( RF4463_CMD_RX_FIFO_READ );
    vRf4463SPIReadBuffer( 1, ( uint8_t * )&pcReadLength );
    vRf4463SPIReadBuffer( 66, pcBuffer );

    RF4463nSEL = 1;

    return;
}

/**************************************************************************************************************************************************
 * END OF FILE
**************************************************************************************************************************************************/