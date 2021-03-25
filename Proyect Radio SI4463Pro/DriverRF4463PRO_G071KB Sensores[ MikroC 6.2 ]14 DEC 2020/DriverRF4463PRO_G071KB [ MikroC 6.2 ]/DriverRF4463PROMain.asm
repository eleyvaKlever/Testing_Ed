_Int_SPI1:
;driverspi.c,15 :: 		void Int_SPI1() iv IVT_INT_SPI1 ics ICS_AUTO {
PUSH	(R14)
;driverspi.c,17 :: 		if ( SPI1_SRbits.RXNE ) {
MOVW	R0, #lo_addr(SPI1_SRbits+0)
MOVT	R0, #hi_addr(SPI1_SRbits+0)
_LX	[R0, ByteOffset(SPI1_SRbits+0)]
MOVS	R0, #1
ANDS	R0, R1
LSRS	R0, R0, #0
CMP	R0, #0
IT	EQ
BLEQ	L_Int_SPI10
;driverspi.c,18 :: 		ucSPI1ByteReceived = ( unsigned char )SPI1_DR;      // lee el Byte recibido
MOVW	R0, #lo_addr(SPI1_DR+0)
MOVT	R0, #hi_addr(SPI1_DR+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucSPI1ByteReceived+0)
MOVT	R0, #hi_addr(_ucSPI1ByteReceived+0)
STRB	R1, [R0, #0]
;driverspi.c,20 :: 		LED_GREEN = ~LED_GREEN;
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_LX	[R0, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #64
ANDS	R1, R0
LSRS	R1, R1, #6
MOVS	R0, #1
EORS	R0, R1
UXTB	R3, R0
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_LX	[R2, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #1
ANDS	R1, R3
BEQ	L__Int_SPI1447
MOVS	R1, #64
ORRS	R0, R1
B	L__Int_SPI1446
L__Int_SPI1447:
MOVS	R1, #64
BICS	R0, R1
L__Int_SPI1446:
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;driverspi.c,21 :: 		}
L_Int_SPI10:
;driverspi.c,22 :: 		}
L_end_Int_SPI1:
POP	(R15)
; end of _Int_SPI1
_DMACh1_interrupt:
;driverspi.c,28 :: 		void DMACh1_interrupt() iv IVT_INT_DMA_Channel1 ics ICS_AUTO {
PUSH	(R14)
;driverspi.c,30 :: 		if ( DMA_ISRbits.TEIF3 ) {
MOVW	R0, #lo_addr(DMA_ISRbits+0)
MOVT	R0, #hi_addr(DMA_ISRbits+0)
_LX	[R0, ByteOffset(DMA_ISRbits+0)]
MOVS	R0, #8
ANDS	R0, R1
LSRS	R0, R0, #3
CMP	R0, #0
IT	EQ
BLEQ	L_DMACh1_interrupt1
;driverspi.c,31 :: 		DMA_IFCRbits.CTEIF3 = 1;
MOVW	R2, #lo_addr(DMA_IFCRbits+0)
MOVT	R2, #hi_addr(DMA_IFCRbits+0)
_LX	[R2, ByteOffset(DMA_IFCRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(DMA_IFCRbits+0)]
;driverspi.c,32 :: 		while ( SPI1_SRbits.BSY );
L_DMACh1_interrupt2:
MOVW	R0, #lo_addr(SPI1_SRbits+0)
MOVT	R0, #hi_addr(SPI1_SRbits+0)
_LX	[R0, ByteOffset(SPI1_SRbits+0)]
MOVS	R0, #128
ANDS	R0, R1
LSRS	R0, R0, #7
CMP	R0, #0
IT	EQ
BLEQ	L_DMACh1_interrupt3
IT	AL
BLAL	L_DMACh1_interrupt2
L_DMACh1_interrupt3:
;driverspi.c,33 :: 		while ( !SPI1_SRbits.TXE );
L_DMACh1_interrupt4:
MOVW	R0, #lo_addr(SPI1_SRbits+0)
MOVT	R0, #hi_addr(SPI1_SRbits+0)
_LX	[R0, ByteOffset(SPI1_SRbits+0)]
MOVS	R0, #2
ANDS	R0, R1
LSRS	R0, R0, #1
CMP	R0, #0
IT	NE
BLNE	L_DMACh1_interrupt5
IT	AL
BLAL	L_DMACh1_interrupt4
L_DMACh1_interrupt5:
;driverspi.c,34 :: 		DMA_CCR1bits.EN = 0;
MOVW	R2, #lo_addr(DMA_CCR1bits+0)
MOVT	R2, #hi_addr(DMA_CCR1bits+0)
_LX	[R2, ByteOffset(DMA_CCR1bits+0)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(DMA_CCR1bits+0)]
;driverspi.c,35 :: 		}
L_DMACh1_interrupt1:
;driverspi.c,37 :: 		if ( DMA_ISRbits.TCIF1 ) {     // TRANSFER COMPLETE INTERRUPT FLAG = envio el frame completo
MOVW	R0, #lo_addr(DMA_ISRbits+0)
MOVT	R0, #hi_addr(DMA_ISRbits+0)
_LX	[R0, ByteOffset(DMA_ISRbits+0)]
MOVS	R0, #2
ANDS	R0, R1
LSRS	R0, R0, #1
CMP	R0, #0
IT	EQ
BLEQ	L_DMACh1_interrupt6
;driverspi.c,38 :: 		DMA_IFCRbits.CGIF0 = 1;        // limpia TODOS LOS FLAGS DE DMA
MOVW	R2, #lo_addr(DMA_IFCRbits+0)
MOVT	R2, #hi_addr(DMA_IFCRbits+0)
_LX	[R2, ByteOffset(DMA_IFCRbits+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(DMA_IFCRbits+0)]
;driverspi.c,39 :: 		while ( SPI1_SRbits.BSY );
L_DMACh1_interrupt7:
MOVW	R0, #lo_addr(SPI1_SRbits+0)
MOVT	R0, #hi_addr(SPI1_SRbits+0)
_LX	[R0, ByteOffset(SPI1_SRbits+0)]
MOVS	R0, #128
ANDS	R0, R1
LSRS	R0, R0, #7
CMP	R0, #0
IT	EQ
BLEQ	L_DMACh1_interrupt8
IT	AL
BLAL	L_DMACh1_interrupt7
L_DMACh1_interrupt8:
;driverspi.c,40 :: 		while ( !SPI1_SRbits.TXE );
L_DMACh1_interrupt9:
MOVW	R0, #lo_addr(SPI1_SRbits+0)
MOVT	R0, #hi_addr(SPI1_SRbits+0)
_LX	[R0, ByteOffset(SPI1_SRbits+0)]
MOVS	R0, #2
ANDS	R0, R1
LSRS	R0, R0, #1
CMP	R0, #0
IT	NE
BLNE	L_DMACh1_interrupt10
IT	AL
BLAL	L_DMACh1_interrupt9
L_DMACh1_interrupt10:
;driverspi.c,41 :: 		DMA_CCR1bits.EN = 0;
MOVW	R2, #lo_addr(DMA_CCR1bits+0)
MOVT	R2, #hi_addr(DMA_CCR1bits+0)
_LX	[R2, ByteOffset(DMA_CCR1bits+0)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(DMA_CCR1bits+0)]
;driverspi.c,42 :: 		}
L_DMACh1_interrupt6:
;driverspi.c,44 :: 		if ( DMA_ISRbits.GIF0 ) {
MOVW	R0, #lo_addr(DMA_ISRbits+0)
MOVT	R0, #hi_addr(DMA_ISRbits+0)
_LX	[R0, ByteOffset(DMA_ISRbits+0)]
MOVS	R0, #1
ANDS	R0, R1
LSRS	R0, R0, #0
CMP	R0, #0
IT	EQ
BLEQ	L_DMACh1_interrupt11
;driverspi.c,45 :: 		DMA_IFCRbits.CGIF0 = 1;
MOVW	R2, #lo_addr(DMA_IFCRbits+0)
MOVT	R2, #hi_addr(DMA_IFCRbits+0)
_LX	[R2, ByteOffset(DMA_IFCRbits+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(DMA_IFCRbits+0)]
;driverspi.c,46 :: 		while ( SPI1_SRbits.BSY );
L_DMACh1_interrupt12:
MOVW	R0, #lo_addr(SPI1_SRbits+0)
MOVT	R0, #hi_addr(SPI1_SRbits+0)
_LX	[R0, ByteOffset(SPI1_SRbits+0)]
MOVS	R0, #128
ANDS	R0, R1
LSRS	R0, R0, #7
CMP	R0, #0
IT	EQ
BLEQ	L_DMACh1_interrupt13
IT	AL
BLAL	L_DMACh1_interrupt12
L_DMACh1_interrupt13:
;driverspi.c,47 :: 		while ( !SPI1_SRbits.TXE );
L_DMACh1_interrupt14:
MOVW	R0, #lo_addr(SPI1_SRbits+0)
MOVT	R0, #hi_addr(SPI1_SRbits+0)
_LX	[R0, ByteOffset(SPI1_SRbits+0)]
MOVS	R0, #2
ANDS	R0, R1
LSRS	R0, R0, #1
CMP	R0, #0
IT	NE
BLNE	L_DMACh1_interrupt15
IT	AL
BLAL	L_DMACh1_interrupt14
L_DMACh1_interrupt15:
;driverspi.c,48 :: 		DMA_CCR1bits.EN = 0;
MOVW	R2, #lo_addr(DMA_CCR1bits+0)
MOVT	R2, #hi_addr(DMA_CCR1bits+0)
_LX	[R2, ByteOffset(DMA_CCR1bits+0)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(DMA_CCR1bits+0)]
;driverspi.c,49 :: 		}
L_DMACh1_interrupt11:
;driverspi.c,50 :: 		}
L_end_DMACh1_interrupt:
POP	(R15)
; end of _DMACh1_interrupt
_vRF4463SpiBufferTX:
;driverspi.c,55 :: 		char vRF4463SpiBufferTX ( unsigned long *ucBuffer, unsigned long ulSize ) {
; ulSize start address is: 4 (R1)
; ucBuffer start address is: 0 (R0)
PUSH	(R14)
SUB	SP, SP, #4
; ulSize end address is: 4 (R1)
; ucBuffer end address is: 0 (R0)
; ucBuffer start address is: 0 (R0)
; ulSize start address is: 4 (R1)
STR	R1, [SP, #0]
; ucBuffer end address is: 0 (R0)
; ulSize end address is: 4 (R1)
MOV	R1, R0
LDR	R0, [SP, #0]
;driverspi.c,57 :: 		while ( DMA_CCR1bits.EN || !SPI1_SRbits.TXE );
L_vRF4463SpiBufferTX16:
; ucBuffer start address is: 4 (R1)
; ulSize start address is: 0 (R0)
; ulSize start address is: 0 (R0)
; ulSize end address is: 0 (R0)
; ucBuffer start address is: 4 (R1)
; ucBuffer end address is: 4 (R1)
MOVW	R2, #lo_addr(DMA_CCR1bits+0)
MOVT	R2, #hi_addr(DMA_CCR1bits+0)
_LX	[R2, ByteOffset(DMA_CCR1bits+0)]
MOVS	R2, #1
ANDS	R2, R3
LSRS	R2, R2, #0
CMP	R2, #0
IT	NE
BLNE	L__vRF4463SpiBufferTX381
; ulSize end address is: 0 (R0)
; ucBuffer end address is: 4 (R1)
; ucBuffer start address is: 4 (R1)
; ulSize start address is: 0 (R0)
MOVW	R2, #lo_addr(SPI1_SRbits+0)
MOVT	R2, #hi_addr(SPI1_SRbits+0)
_LX	[R2, ByteOffset(SPI1_SRbits+0)]
MOVS	R2, #2
ANDS	R2, R3
LSRS	R2, R2, #1
CMP	R2, #0
IT	EQ
BLEQ	L__vRF4463SpiBufferTX380
IT	AL
BLAL	L_vRF4463SpiBufferTX17
L__vRF4463SpiBufferTX381:
L__vRF4463SpiBufferTX380:
IT	AL
BLAL	L_vRF4463SpiBufferTX16
L_vRF4463SpiBufferTX17:
;driverspi.c,59 :: 		SPI1_CR1bits.SPE = 1;                         // habilita el periferico
MOVW	R4, #lo_addr(SPI1_CR1bits+0)
MOVT	R4, #hi_addr(SPI1_CR1bits+0)
_LX	[R4, ByteOffset(SPI1_CR1bits+0)]
MOVS	R3, #64
ORRS	R2, R3
_SX	[R4, ByteOffset(SPI1_CR1bits+0)]
;driverspi.c,61 :: 		if ( SPI1_CR1bits.SPE && SPI1_SRbits.TXE && ulSize > 0 ) { // la transmision anterior termino?
MOVW	R2, #lo_addr(SPI1_CR1bits+0)
MOVT	R2, #hi_addr(SPI1_CR1bits+0)
_LX	[R2, ByteOffset(SPI1_CR1bits+0)]
MOVS	R2, #64
ANDS	R2, R3
LSRS	R2, R2, #6
CMP	R2, #0
IT	EQ
BLEQ	L__vRF4463SpiBufferTX384
MOVW	R2, #lo_addr(SPI1_SRbits+0)
MOVT	R2, #hi_addr(SPI1_SRbits+0)
_LX	[R2, ByteOffset(SPI1_SRbits+0)]
MOVS	R2, #2
ANDS	R2, R3
LSRS	R2, R2, #1
CMP	R2, #0
IT	EQ
BLEQ	L__vRF4463SpiBufferTX383
CMP	R0, #0
IT	LS
BLLS	L__vRF4463SpiBufferTX382
L__vRF4463SpiBufferTX378:
;driverspi.c,62 :: 		DMA_CCR1bits.EN = 0;                       // Desabilita la recepcion para poder modificar los par?metros
MOVW	R4, #lo_addr(DMA_CCR1bits+0)
MOVT	R4, #hi_addr(DMA_CCR1bits+0)
_LX	[R4, ByteOffset(DMA_CCR1bits+0)]
MOVS	R3, #1
BICS	R2, R3
_SX	[R4, ByteOffset(DMA_CCR1bits+0)]
; ulSize end address is: 0 (R0)
; ucBuffer end address is: 4 (R1)
STR	R1, [SP, #0]
MOV	R1, R0
LDR	R0, [SP, #0]
;driverspi.c,63 :: 		while ( DMA_CCR1bits.EN );                 // espera a que se haya desabilitado realmente
L_vRF4463SpiBufferTX23:
; ucBuffer start address is: 0 (R0)
; ulSize start address is: 4 (R1)
MOVW	R2, #lo_addr(DMA_CCR1bits+0)
MOVT	R2, #hi_addr(DMA_CCR1bits+0)
_LX	[R2, ByteOffset(DMA_CCR1bits+0)]
MOVS	R2, #1
ANDS	R2, R3
LSRS	R2, R2, #0
CMP	R2, #0
IT	EQ
BLEQ	L_vRF4463SpiBufferTX24
IT	AL
BLAL	L_vRF4463SpiBufferTX23
L_vRF4463SpiBufferTX24:
;driverspi.c,65 :: 		DMA_CMAR1 = ( unsigned long ) ucBuffer;    // Direccion de la memoria a rutear
MOVW	R2, #lo_addr(DMA_CMAR1+0)
MOVT	R2, #hi_addr(DMA_CMAR1+0)
STR	R0, [R2, #0]
; ucBuffer end address is: 0 (R0)
;driverspi.c,66 :: 		DMA_CNDTR1 = ulSize;                       // Tamagno de datos a manejar
MOVW	R2, #lo_addr(DMA_CNDTR1+0)
MOVT	R2, #hi_addr(DMA_CNDTR1+0)
STR	R1, [R2, #0]
; ulSize end address is: 4 (R1)
;driverspi.c,67 :: 		DMA_CCR1bits.EN = 1;
MOVW	R4, #lo_addr(DMA_CCR1bits+0)
MOVT	R4, #hi_addr(DMA_CCR1bits+0)
_LX	[R4, ByteOffset(DMA_CCR1bits+0)]
MOVS	R3, #1
ORRS	R2, R3
_SX	[R4, ByteOffset(DMA_CCR1bits+0)]
;driverspi.c,69 :: 		while ( DMA_CNDTR1 > 1 );                  // esperando el fin de la transmision
L_vRF4463SpiBufferTX25:
MOVW	R2, #lo_addr(DMA_CNDTR1+0)
MOVT	R2, #hi_addr(DMA_CNDTR1+0)
LDR	R2, [R2, #0]
CMP	R2, #1
IT	LS
BLLS	L_vRF4463SpiBufferTX26
IT	AL
BLAL	L_vRF4463SpiBufferTX25
L_vRF4463SpiBufferTX26:
;driverspi.c,71 :: 		while ( SPI1_SRbits.FTLVL != 0 );          // SPI1_SRbits.FTLVL != 0
L_vRF4463SpiBufferTX27:
MOVW	R2, #lo_addr(SPI1_SRbits+0)
MOVT	R2, #hi_addr(SPI1_SRbits+0)
LDRH	R2, [R2, #0]
UXTH	R3, R2
MOVW	R2, #6144
MOVT	R2, #0
ANDS	R3, R2
UXTH	R3, R3
LSRS	R3, R3, #11
UXTH	R3, R3
CMP	R3, #0
IT	EQ
BLEQ	L_vRF4463SpiBufferTX28
IT	AL
BLAL	L_vRF4463SpiBufferTX27
L_vRF4463SpiBufferTX28:
;driverspi.c,73 :: 		while ( SPI1_SRbits.BSY );
L_vRF4463SpiBufferTX29:
MOVW	R2, #lo_addr(SPI1_SRbits+0)
MOVT	R2, #hi_addr(SPI1_SRbits+0)
_LX	[R2, ByteOffset(SPI1_SRbits+0)]
MOVS	R2, #128
ANDS	R2, R3
LSRS	R2, R2, #7
CMP	R2, #0
IT	EQ
BLEQ	L_vRF4463SpiBufferTX30
IT	AL
BLAL	L_vRF4463SpiBufferTX29
L_vRF4463SpiBufferTX30:
;driverspi.c,74 :: 		while ( !SPI1_SRbits.TXE );
L_vRF4463SpiBufferTX31:
MOVW	R2, #lo_addr(SPI1_SRbits+0)
MOVT	R2, #hi_addr(SPI1_SRbits+0)
_LX	[R2, ByteOffset(SPI1_SRbits+0)]
MOVS	R2, #2
ANDS	R2, R3
LSRS	R2, R2, #1
CMP	R2, #0
IT	NE
BLNE	L_vRF4463SpiBufferTX32
IT	AL
BLAL	L_vRF4463SpiBufferTX31
L_vRF4463SpiBufferTX32:
;driverspi.c,76 :: 		DMA_CCR1bits.EN = 0;                       // DEPURACION
MOVW	R4, #lo_addr(DMA_CCR1bits+0)
MOVT	R4, #hi_addr(DMA_CCR1bits+0)
_LX	[R4, ByteOffset(DMA_CCR1bits+0)]
MOVS	R3, #1
BICS	R2, R3
_SX	[R4, ByteOffset(DMA_CCR1bits+0)]
;driverspi.c,78 :: 		return 1;
MOVS	R0, #1
IT	AL
BLAL	L_end_vRF4463SpiBufferTX
;driverspi.c,61 :: 		if ( SPI1_CR1bits.SPE && SPI1_SRbits.TXE && ulSize > 0 ) { // la transmision anterior termino?
L__vRF4463SpiBufferTX384:
L__vRF4463SpiBufferTX383:
L__vRF4463SpiBufferTX382:
;driverspi.c,80 :: 		return 0;
MOVS	R0, #0
;driverspi.c,81 :: 		}
L_end_vRF4463SpiBufferTX:
ADD	SP, SP, #4
POP	(R15)
; end of _vRF4463SpiBufferTX
_vSPI1Init:
;driverspi.c,83 :: 		void vSPI1Init( void ) {
PUSH	(R14)
;driverspi.c,85 :: 		RCC_IOPENRbits.IOPAEN       = 1;      // GPIOA Enabled
MOVW	R2, #lo_addr(RCC_IOPENRbits+0)
MOVT	R2, #hi_addr(RCC_IOPENRbits+0)
_LX	[R2, ByteOffset(RCC_IOPENRbits+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(RCC_IOPENRbits+0)]
;driverspi.c,86 :: 		GPIOA_MODERbits.MODER5      = 2;      // Altern Function
MOVW	R1, #2048
MOVT	R1, #0
MOVW	R0, #lo_addr(GPIOA_MODERbits+0)
MOVT	R0, #hi_addr(GPIOA_MODERbits+0)
LDRH	R0, [R0, #0]
EORS	R1, R0
UXTH	R1, R1
MOVW	R0, #3072
MOVT	R0, #0
ANDS	R1, R0
UXTH	R1, R1
MOVW	R0, #lo_addr(GPIOA_MODERbits+0)
MOVT	R0, #hi_addr(GPIOA_MODERbits+0)
LDRH	R0, [R0, #0]
EORS	R1, R0
UXTH	R1, R1
MOVW	R0, #lo_addr(GPIOA_MODERbits+0)
MOVT	R0, #hi_addr(GPIOA_MODERbits+0)
STRH	R1, [R0, #0]
;driverspi.c,87 :: 		GPIOA_OTYPERbits.OT5        = 0;      // push pull
MOVW	R2, #lo_addr(GPIOA_OTYPERbits+0)
MOVT	R2, #hi_addr(GPIOA_OTYPERbits+0)
_LX	[R2, ByteOffset(GPIOA_OTYPERbits+0)]
MOVS	R1, #32
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOA_OTYPERbits+0)]
;driverspi.c,88 :: 		GPIOA_OSPEEDRbits.OSPEEDR5  = 0;      // high Speed
MOVW	R0, #lo_addr(GPIOA_OSPEEDRbits+0)
MOVT	R0, #hi_addr(GPIOA_OSPEEDRbits+0)
LDRH	R1, [R0, #0]
MOVW	R0, #62463
MOVT	R0, #0
ANDS	R1, R0
LSLS	R1, R1, #20
LSRS	R1, R1, #30
MOVW	R0, #lo_addr(GPIOA_OSPEEDRbits+0)
MOVT	R0, #hi_addr(GPIOA_OSPEEDRbits+0)
STRH	R1, [R0, #0]
;driverspi.c,89 :: 		GPIOA_PUPDRbits.PUPDR5      = 0;      // no PU or PD
MOVW	R0, #lo_addr(GPIOA_PUPDRbits+0)
MOVT	R0, #hi_addr(GPIOA_PUPDRbits+0)
LDRH	R1, [R0, #0]
MOVW	R0, #62463
MOVT	R0, #0
ANDS	R1, R0
LSLS	R1, R1, #20
LSRS	R1, R1, #30
MOVW	R0, #lo_addr(GPIOA_PUPDRbits+0)
MOVT	R0, #hi_addr(GPIOA_PUPDRbits+0)
STRH	R1, [R0, #0]
;driverspi.c,90 :: 		GPIOA_AFRLbits.AFSEL5       = 0;      // AF0
MOVW	R0, #lo_addr(GPIOA_AFRLbits+0)
MOVT	R0, #hi_addr(GPIOA_AFRLbits+0)
LDR	R1, [R0, #0]
MOVW	R0, #65535
MOVT	R0, #65295
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOA_AFRLbits+0)
MOVT	R0, #hi_addr(GPIOA_AFRLbits+0)
STR	R1, [R0, #0]
;driverspi.c,92 :: 		GPIOA_MODERbits.MODER6      = 2;      // Altern Function
MOVW	R1, #8192
MOVT	R1, #0
MOVW	R0, #lo_addr(GPIOA_MODERbits+0)
MOVT	R0, #hi_addr(GPIOA_MODERbits+0)
LDRH	R0, [R0, #0]
EORS	R1, R0
UXTH	R1, R1
MOVW	R0, #12288
MOVT	R0, #0
ANDS	R1, R0
UXTH	R1, R1
MOVW	R0, #lo_addr(GPIOA_MODERbits+0)
MOVT	R0, #hi_addr(GPIOA_MODERbits+0)
LDRH	R0, [R0, #0]
EORS	R1, R0
UXTH	R1, R1
MOVW	R0, #lo_addr(GPIOA_MODERbits+0)
MOVT	R0, #hi_addr(GPIOA_MODERbits+0)
STRH	R1, [R0, #0]
;driverspi.c,93 :: 		GPIOA_OTYPERbits.OT6        = 0;      // push pull
MOVW	R2, #lo_addr(GPIOA_OTYPERbits+0)
MOVT	R2, #hi_addr(GPIOA_OTYPERbits+0)
_LX	[R2, ByteOffset(GPIOA_OTYPERbits+0)]
MOVS	R1, #64
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOA_OTYPERbits+0)]
;driverspi.c,94 :: 		GPIOA_OSPEEDRbits.OSPEEDR6  = 0;      // high Speed
MOVW	R0, #lo_addr(GPIOA_OSPEEDRbits+0)
MOVT	R0, #hi_addr(GPIOA_OSPEEDRbits+0)
LDRH	R1, [R0, #0]
MOVW	R0, #53247
MOVT	R0, #0
ANDS	R1, R0
LSLS	R1, R1, #18
LSRS	R1, R1, #30
MOVW	R0, #lo_addr(GPIOA_OSPEEDRbits+0)
MOVT	R0, #hi_addr(GPIOA_OSPEEDRbits+0)
STRH	R1, [R0, #0]
;driverspi.c,95 :: 		GPIOA_PUPDRbits.PUPDR6      = 0;      // no PU or PD
MOVW	R0, #lo_addr(GPIOA_PUPDRbits+0)
MOVT	R0, #hi_addr(GPIOA_PUPDRbits+0)
LDRH	R1, [R0, #0]
MOVW	R0, #53247
MOVT	R0, #0
ANDS	R1, R0
LSLS	R1, R1, #18
LSRS	R1, R1, #30
MOVW	R0, #lo_addr(GPIOA_PUPDRbits+0)
MOVT	R0, #hi_addr(GPIOA_PUPDRbits+0)
STRH	R1, [R0, #0]
;driverspi.c,96 :: 		GPIOA_AFRLbits.AFSEL6       = 0;      // AF0
MOVW	R0, #lo_addr(GPIOA_AFRLbits+0)
MOVT	R0, #hi_addr(GPIOA_AFRLbits+0)
LDR	R1, [R0, #0]
MOVW	R0, #65535
MOVT	R0, #61695
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOA_AFRLbits+0)
MOVT	R0, #hi_addr(GPIOA_AFRLbits+0)
STR	R1, [R0, #0]
;driverspi.c,98 :: 		GPIOA_MODERbits.MODER7      = 2;      // Altern Function
MOVW	R1, #32768
MOVT	R1, #0
MOVW	R0, #lo_addr(GPIOA_MODERbits+0)
MOVT	R0, #hi_addr(GPIOA_MODERbits+0)
LDRH	R0, [R0, #0]
EORS	R1, R0
UXTH	R1, R1
MOVW	R0, #49152
MOVT	R0, #0
ANDS	R1, R0
UXTH	R1, R1
MOVW	R0, #lo_addr(GPIOA_MODERbits+0)
MOVT	R0, #hi_addr(GPIOA_MODERbits+0)
LDRH	R0, [R0, #0]
EORS	R1, R0
UXTH	R1, R1
MOVW	R0, #lo_addr(GPIOA_MODERbits+0)
MOVT	R0, #hi_addr(GPIOA_MODERbits+0)
STRH	R1, [R0, #0]
;driverspi.c,99 :: 		GPIOA_OTYPERbits.OT7        = 0;      // push pull
MOVW	R2, #lo_addr(GPIOA_OTYPERbits+0)
MOVT	R2, #hi_addr(GPIOA_OTYPERbits+0)
_LX	[R2, ByteOffset(GPIOA_OTYPERbits+0)]
MOVS	R1, #128
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOA_OTYPERbits+0)]
;driverspi.c,100 :: 		GPIOA_OSPEEDRbits.OSPEEDR7  = 0;      // high Speed
MOVW	R0, #lo_addr(GPIOA_OSPEEDRbits+0)
MOVT	R0, #hi_addr(GPIOA_OSPEEDRbits+0)
LDRH	R1, [R0, #0]
MOVW	R0, #16383
MOVT	R0, #0
ANDS	R1, R0
LSLS	R1, R1, #16
LSRS	R1, R1, #30
MOVW	R0, #lo_addr(GPIOA_OSPEEDRbits+0)
MOVT	R0, #hi_addr(GPIOA_OSPEEDRbits+0)
STRH	R1, [R0, #0]
;driverspi.c,101 :: 		GPIOA_PUPDRbits.PUPDR7      = 0;      // no PU or PD
MOVW	R0, #lo_addr(GPIOA_PUPDRbits+0)
MOVT	R0, #hi_addr(GPIOA_PUPDRbits+0)
LDRH	R1, [R0, #0]
MOVW	R0, #16383
MOVT	R0, #0
ANDS	R1, R0
LSLS	R1, R1, #16
LSRS	R1, R1, #30
MOVW	R0, #lo_addr(GPIOA_PUPDRbits+0)
MOVT	R0, #hi_addr(GPIOA_PUPDRbits+0)
STRH	R1, [R0, #0]
;driverspi.c,102 :: 		GPIOA_AFRLbits.AFSEL7       = 0;      // AF0
MOVW	R0, #lo_addr(GPIOA_AFRLbits+0)
MOVT	R0, #hi_addr(GPIOA_AFRLbits+0)
LDR	R1, [R0, #0]
MOVW	R0, #65535
MOVT	R0, #4095
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOA_AFRLbits+0)
MOVT	R0, #hi_addr(GPIOA_AFRLbits+0)
STR	R1, [R0, #0]
;driverspi.c,105 :: 		RCC_APBENR2bits.SPI1EN      = 1;
MOVW	R2, #lo_addr(RCC_APBENR2bits+0)
MOVT	R2, #hi_addr(RCC_APBENR2bits+0)
_LX	[R2, ByteOffset(RCC_APBENR2bits+0)]
MOVS	R1, #1
LSLS	R1, R1, #12
ORRS	R0, R1
_SX	[R2, ByteOffset(RCC_APBENR2bits+0)]
;driverspi.c,107 :: 		SPI1_CR1bits.CPHA           = 0;      // 1 if TI enabled
MOVW	R2, #lo_addr(SPI1_CR1bits+0)
MOVT	R2, #hi_addr(SPI1_CR1bits+0)
_LX	[R2, ByteOffset(SPI1_CR1bits+0)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR1bits+0)]
;driverspi.c,108 :: 		SPI1_CR1bits.CPOL           = 0;
MOVW	R2, #lo_addr(SPI1_CR1bits+0)
MOVT	R2, #hi_addr(SPI1_CR1bits+0)
_LX	[R2, ByteOffset(SPI1_CR1bits+0)]
MOVS	R1, #2
BICS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR1bits+0)]
;driverspi.c,109 :: 		SPI1_CR1bits.LSBFIRST       = 0;
MOVW	R2, #lo_addr(SPI1_CR1bits+0)
MOVT	R2, #hi_addr(SPI1_CR1bits+0)
_LX	[R2, ByteOffset(SPI1_CR1bits+0)]
MOVS	R1, #128
BICS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR1bits+0)]
;driverspi.c,110 :: 		SPI1_CR1bits.SSM            = 1;
MOVW	R2, #lo_addr(SPI1_CR1bits+0)
MOVT	R2, #hi_addr(SPI1_CR1bits+0)
_LX	[R2, ByteOffset(SPI1_CR1bits+0)]
MOVS	R1, #1
LSLS	R1, R1, #9
ORRS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR1bits+0)]
;driverspi.c,111 :: 		SPI1_CR1bits.SSI            = 1;
MOVW	R2, #lo_addr(SPI1_CR1bits+0)
MOVT	R2, #hi_addr(SPI1_CR1bits+0)
_LX	[R2, ByteOffset(SPI1_CR1bits+0)]
MOVS	R1, #1
LSLS	R1, R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR1bits+0)]
;driverspi.c,112 :: 		SPI1_CR1bits.MSTR           = 1;
MOVW	R2, #lo_addr(SPI1_CR1bits+0)
MOVT	R2, #hi_addr(SPI1_CR1bits+0)
_LX	[R2, ByteOffset(SPI1_CR1bits+0)]
MOVS	R1, #4
ORRS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR1bits+0)]
;driverspi.c,113 :: 		SPI1_CR1bits.CRCNEXT        = 0;
MOVW	R2, #lo_addr(SPI1_CR1bits+0)
MOVT	R2, #hi_addr(SPI1_CR1bits+0)
_LX	[R2, ByteOffset(SPI1_CR1bits+0)]
MOVS	R1, #1
LSLS	R1, R1, #12
BICS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR1bits+0)]
;driverspi.c,115 :: 		SPI1_CR2bits.FRF            = 0;
MOVW	R2, #lo_addr(SPI1_CR2bits+0)
MOVT	R2, #hi_addr(SPI1_CR2bits+0)
_LX	[R2, ByteOffset(SPI1_CR2bits+0)]
MOVS	R1, #16
BICS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR2bits+0)]
;driverspi.c,116 :: 		SPI1_CR2bits.DS             = 7;      // 8 bits empaquetado
MOVW	R1, #1792
MOVT	R1, #0
MOVW	R0, #lo_addr(SPI1_CR2bits+0)
MOVT	R0, #hi_addr(SPI1_CR2bits+0)
LDRH	R0, [R0, #0]
EORS	R1, R0
UXTH	R1, R1
MOVW	R0, #3840
MOVT	R0, #0
ANDS	R1, R0
UXTH	R1, R1
MOVW	R0, #lo_addr(SPI1_CR2bits+0)
MOVT	R0, #hi_addr(SPI1_CR2bits+0)
LDRH	R0, [R0, #0]
EORS	R1, R0
UXTH	R1, R1
MOVW	R0, #lo_addr(SPI1_CR2bits+0)
MOVT	R0, #hi_addr(SPI1_CR2bits+0)
STRH	R1, [R0, #0]
;driverspi.c,117 :: 		SPI1_CR2bits.SSOE           = 0;
MOVW	R2, #lo_addr(SPI1_CR2bits+0)
MOVT	R2, #hi_addr(SPI1_CR2bits+0)
_LX	[R2, ByteOffset(SPI1_CR2bits+0)]
MOVS	R1, #4
BICS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR2bits+0)]
;driverspi.c,118 :: 		SPI1_CR2bits.NSSP           = 1;
MOVW	R2, #lo_addr(SPI1_CR2bits+0)
MOVT	R2, #hi_addr(SPI1_CR2bits+0)
_LX	[R2, ByteOffset(SPI1_CR2bits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR2bits+0)]
;driverspi.c,119 :: 		SPI1_CR2bits.FRXTH          = 1;
MOVW	R2, #lo_addr(SPI1_CR2bits+0)
MOVT	R2, #hi_addr(SPI1_CR2bits+0)
_LX	[R2, ByteOffset(SPI1_CR2bits+0)]
MOVS	R1, #1
LSLS	R1, R1, #12
ORRS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR2bits+0)]
;driverspi.c,120 :: 		SPI1_CR2bits.TXDMAEN        = 1;
MOVW	R2, #lo_addr(SPI1_CR2bits+0)
MOVT	R2, #hi_addr(SPI1_CR2bits+0)
_LX	[R2, ByteOffset(SPI1_CR2bits+0)]
MOVS	R1, #2
ORRS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR2bits+0)]
;driverspi.c,124 :: 		RCC_AHBENRbits.DMAEN        = 1;
MOVW	R2, #lo_addr(RCC_AHBENRbits+0)
MOVT	R2, #hi_addr(RCC_AHBENRbits+0)
_LX	[R2, ByteOffset(RCC_AHBENRbits+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(RCC_AHBENRbits+0)]
;driverspi.c,126 :: 		DMA_CCR1bits.EN = 0;
MOVW	R2, #lo_addr(DMA_CCR1bits+0)
MOVT	R2, #hi_addr(DMA_CCR1bits+0)
_LX	[R2, ByteOffset(DMA_CCR1bits+0)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(DMA_CCR1bits+0)]
;driverspi.c,127 :: 		while ( DMA_CCR1bits.EN );
L_vSPI1Init33:
MOVW	R0, #lo_addr(DMA_CCR1bits+0)
MOVT	R0, #hi_addr(DMA_CCR1bits+0)
_LX	[R0, ByteOffset(DMA_CCR1bits+0)]
MOVS	R0, #1
ANDS	R0, R1
LSRS	R0, R0, #0
CMP	R0, #0
IT	EQ
BLEQ	L_vSPI1Init34
IT	AL
BLAL	L_vSPI1Init33
L_vSPI1Init34:
;driverspi.c,129 :: 		PL0_bit = 1;
MOVW	R2, #lo_addr(PL0_bit+0)
MOVT	R2, #hi_addr(PL0_bit+0)
_LX	[R2, ByteOffset(PL0_bit+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(PL0_bit+0)
ORRS	R0, R1
_SX	[R2, ByteOffset(PL0_bit+0)]
;driverspi.c,130 :: 		PL1_bit = 1;
MOVW	R2, #lo_addr(PL1_bit+0)
MOVT	R2, #hi_addr(PL1_bit+0)
_LX	[R2, ByteOffset(PL1_bit+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(PL1_bit+0)
ORRS	R0, R1
_SX	[R2, ByteOffset(PL1_bit+0)]
;driverspi.c,131 :: 		DMA_CCR1bits.MINC           = 1;      // Mem increment
MOVW	R2, #lo_addr(DMA_CCR1bits+0)
MOVT	R2, #hi_addr(DMA_CCR1bits+0)
_LX	[R2, ByteOffset(DMA_CCR1bits+0)]
MOVS	R1, #128
ORRS	R0, R1
_SX	[R2, ByteOffset(DMA_CCR1bits+0)]
;driverspi.c,132 :: 		DMA_CCR1bits.DIR_           = 1;      // Read from Memory
MOVW	R2, #lo_addr(DMA_CCR1bits+0)
MOVT	R2, #hi_addr(DMA_CCR1bits+0)
_LX	[R2, ByteOffset(DMA_CCR1bits+0)]
MOVS	R1, #16
ORRS	R0, R1
_SX	[R2, ByteOffset(DMA_CCR1bits+0)]
;driverspi.c,133 :: 		DMA_CCR1bits.TEIE           = 1;      // Transfer Error Int
MOVW	R2, #lo_addr(DMA_CCR1bits+0)
MOVT	R2, #hi_addr(DMA_CCR1bits+0)
_LX	[R2, ByteOffset(DMA_CCR1bits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(DMA_CCR1bits+0)]
;driverspi.c,134 :: 		DMA_CCR1bits.TCIE           = 1;      // Transfer Complete Int
MOVW	R2, #lo_addr(DMA_CCR1bits+0)
MOVT	R2, #hi_addr(DMA_CCR1bits+0)
_LX	[R2, ByteOffset(DMA_CCR1bits+0)]
MOVS	R1, #2
ORRS	R0, R1
_SX	[R2, ByteOffset(DMA_CCR1bits+0)]
;driverspi.c,136 :: 		DMA_CPAR1 = ( unsigned long ) &SPI1_DR;    // periferico ruteado
MOVW	R1, #lo_addr(SPI1_DR+0)
MOVT	R1, #hi_addr(SPI1_DR+0)
MOVW	R0, #lo_addr(DMA_CPAR1+0)
MOVT	R0, #hi_addr(DMA_CPAR1+0)
STR	R1, [R0, #0]
;driverspi.c,138 :: 		NVIC_IntEnable( IVT_INT_DMA_Channel1 );    // habilitacion de interrupcion
MOVS	R0, #25
BL	_NVIC_IntEnable+0
;driverspi.c,140 :: 		DMAMUX_C0CRbits.DMAREQ_ID = 17;            // TX_SPI1
MOVS	R1, #17
MOVW	R0, #lo_addr(DMAMUX_C0CRbits+0)
MOVT	R0, #hi_addr(DMAMUX_C0CRbits+0)
LDRB	R0, [R0, #0]
EORS	R1, R0
UXTB	R1, R1
MOVS	R0, #255
ANDS	R1, R0
UXTB	R1, R1
MOVW	R0, #lo_addr(DMAMUX_C0CRbits+0)
MOVT	R0, #hi_addr(DMAMUX_C0CRbits+0)
LDRB	R0, [R0, #0]
EORS	R1, R0
UXTB	R1, R1
MOVW	R0, #lo_addr(DMAMUX_C0CRbits+0)
MOVT	R0, #hi_addr(DMAMUX_C0CRbits+0)
STRB	R1, [R0, #0]
;driverspi.c,142 :: 		SPI1_CR2bits.RXNEIE = 1;                   // habilita interrupcion de recepcion SPI
MOVW	R2, #lo_addr(SPI1_CR2bits+0)
MOVT	R2, #hi_addr(SPI1_CR2bits+0)
_LX	[R2, ByteOffset(SPI1_CR2bits+0)]
MOVS	R1, #64
ORRS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR2bits+0)]
;driverspi.c,144 :: 		NVIC_IntEnable( IVT_INT_SPI1 );
MOVS	R0, #41
BL	_NVIC_IntEnable+0
;driverspi.c,145 :: 		}
L_end_vSPI1Init:
POP	(R15)
; end of _vSPI1Init
_vRF4463ISR:
;driverrf4463pro.c,27 :: 		void vRF4463ISR() iv IVT_INT_EXTI2_3 ics ICS_AUTO{
PUSH	(R14)
;driverrf4463pro.c,28 :: 		if ( EXTI_FPR1bits.FPIF2 ){
MOVW	R0, #lo_addr(EXTI_FPR1bits+0)
MOVT	R0, #hi_addr(EXTI_FPR1bits+0)
_LX	[R0, ByteOffset(EXTI_FPR1bits+0)]
MOVS	R0, #4
ANDS	R0, R1
LSRS	R0, R0, #2
CMP	R0, #0
IT	EQ
BLEQ	L_vRF4463ISR35
;driverrf4463pro.c,29 :: 		EXTI_FPR1bits.FPIF2 = 1;
MOVW	R2, #lo_addr(EXTI_FPR1bits+0)
MOVT	R2, #hi_addr(EXTI_FPR1bits+0)
_LX	[R2, ByteOffset(EXTI_FPR1bits+0)]
MOVS	R1, #4
ORRS	R0, R1
_SX	[R2, ByteOffset(EXTI_FPR1bits+0)]
;driverrf4463pro.c,30 :: 		vRF4463ClearInterrupts();
BL	_vRF4463ClearInterrupts+0
;driverrf4463pro.c,31 :: 		ucRF4463IRQ = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
STRB	R1, [R0, #0]
;driverrf4463pro.c,32 :: 		}
L_vRF4463ISR35:
;driverrf4463pro.c,33 :: 		}
L_end_vRF4463ISR:
POP	(R15)
; end of _vRF4463ISR
_vRF4463Init:
;driverrf4463pro.c,37 :: 		void vRF4463Init ( void ) {  // MODE,
PUSH	(R14)
SUB	SP, SP, #20
;driverrf4463pro.c,40 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init36:
; i start address is: 16 (R4)
CMP	R4, #16
IT	CS
BLCS	L_vRF4463Init37
;driverrf4463pro.c,41 :: 		RF_MODEM_MOD_TYPE_12_data[ i ] = RF_MODEM_MOD_TYPE_12[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_MOD_TYPE_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_MOD_TYPE_12_data+0)
ADDS	R3, R0, R4
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #12
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_MOD_TYPE_12+0)
MOVT	R0, #hi_addr(_RF_MODEM_MOD_TYPE_12+0)
ADDS	R1, R0, R1
SUBS	R0, R4, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,40 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,42 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init36
L_vRF4463Init37:
;driverrf4463pro.c,45 :: 		if ( ucRF4463Freq3 < 8 ) {
MOVW	R0, #lo_addr(_ucRF4463Freq3+0)
MOVT	R0, #hi_addr(_ucRF4463Freq3+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CS
BLCS	L_vRF4463Init39
;driverrf4463pro.c,46 :: 		for ( i = 4; i < 12; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init40:
; i start address is: 12 (R3)
CMP	R3, #12
IT	CS
BLCS	L_vRF4463Init41
;driverrf4463pro.c,47 :: 		RF_MODEM_TX_RAMP_DELAY_8_data[ i ] = RF_MODEM_TX_RAMP_DELAY_8_433[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #3
MOVW	R0, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_433+0)
ADDS	R1, R0, R1
SUBS	R0, R3, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;driverrf4463pro.c,46 :: 		for ( i = 4; i < 12; i++ ) {
ADDS	R3, #1
UXTB	R3, R3
;driverrf4463pro.c,48 :: 		}
; i end address is: 12 (R3)
IT	AL
BLAL	L_vRF4463Init40
L_vRF4463Init41:
;driverrf4463pro.c,49 :: 		for ( i = 4; i < 11; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init43:
; i start address is: 16 (R4)
CMP	R4, #11
IT	CS
BLCS	L_vRF4463Init44
;driverrf4463pro.c,50 :: 		RF_MODEM_AFC_GEAR_7_data[ i ] = RF_MODEM_AFC_GEAR_7_433[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_AFC_GEAR_7_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AFC_GEAR_7_data+0)
ADDS	R3, R0, R4
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #7
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_AFC_GEAR_7_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_AFC_GEAR_7_433+0)
ADDS	R1, R0, R1
SUBS	R0, R4, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,49 :: 		for ( i = 4; i < 11; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,51 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init43
L_vRF4463Init44:
;driverrf4463pro.c,52 :: 		for ( i = 4; i < 15; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init46:
; i start address is: 16 (R4)
CMP	R4, #15
IT	CS
BLCS	L_vRF4463Init47
;driverrf4463pro.c,53 :: 		RF_MODEM_OOK_CNT1_11_data[ i ] = RF_MODEM_OOK_CNT1_11_433[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_OOK_CNT1_11_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_OOK_CNT1_11_data+0)
ADDS	R3, R0, R4
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #11
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_OOK_CNT1_11_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_OOK_CNT1_11_433+0)
ADDS	R1, R0, R1
SUBS	R0, R4, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,52 :: 		for ( i = 4; i < 15; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,54 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init46
L_vRF4463Init47:
;driverrf4463pro.c,55 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init49:
; i start address is: 16 (R4)
CMP	R4, #16
IT	CS
BLCS	L_vRF4463Init50
;driverrf4463pro.c,56 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
ADDS	R3, R0, R4
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #12
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433+0)
ADDS	R1, R0, R1
SUBS	R0, R4, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,55 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,57 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init49
L_vRF4463Init50:
;driverrf4463pro.c,58 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init52:
; i start address is: 16 (R4)
CMP	R4, #16
IT	CS
BLCS	L_vRF4463Init53
;driverrf4463pro.c,59 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
ADDS	R3, R0, R4
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #12
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433+0)
ADDS	R1, R0, R1
SUBS	R0, R4, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,58 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,60 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init52
L_vRF4463Init53:
;driverrf4463pro.c,61 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init55:
; i start address is: 16 (R4)
CMP	R4, #16
IT	CS
BLCS	L_vRF4463Init56
;driverrf4463pro.c,62 :: 		RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
ADDS	R3, R0, R4
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #12
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433+0)
ADDS	R1, R0, R1
SUBS	R0, R4, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,61 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,63 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init55
L_vRF4463Init56:
;driverrf4463pro.c,64 :: 		for ( i = 4; i < 13; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init58:
; i start address is: 16 (R4)
CMP	R4, #13
IT	CS
BLCS	L_vRF4463Init59
;driverrf4463pro.c,65 :: 		RF_MODEM_AGC_WINDOW_SIZE_9_data[ i ] = RF_MODEM_AGC_WINDOW_SIZE_9_433[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
ADDS	R3, R0, R4
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #9
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_433+0)
ADDS	R1, R0, R1
SUBS	R0, R4, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,64 :: 		for ( i = 4; i < 13; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,66 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init58
L_vRF4463Init59:
;driverrf4463pro.c,67 :: 		for ( i = 4; i < 13; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init61:
; i start address is: 16 (R4)
CMP	R4, #13
IT	CS
BLCS	L_vRF4463Init62
;driverrf4463pro.c,68 :: 		RF_MODEM_BCR_OSR_1_9_data[ i ] = RF_MODEM_BCR_OSR_1_9_433[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
ADDS	R3, R0, R4
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #9
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_BCR_OSR_1_9_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_BCR_OSR_1_9_433+0)
ADDS	R1, R0, R1
SUBS	R0, R4, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,67 :: 		for ( i = 4; i < 13; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,69 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init61
L_vRF4463Init62:
;driverrf4463pro.c,70 :: 		}
IT	AL
BLAL	L_vRF4463Init64
L_vRF4463Init39:
;driverrf4463pro.c,72 :: 		for ( i = 4; i < 12; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init65:
; i start address is: 12 (R3)
CMP	R3, #12
IT	CS
BLCS	L_vRF4463Init66
;driverrf4463pro.c,73 :: 		RF_MODEM_TX_RAMP_DELAY_8_data[ i ] = RF_MODEM_TX_RAMP_DELAY_8_850[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
ADDS	R2, R0, R3
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #3
MOVW	R0, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_850+0)
ADDS	R1, R0, R1
SUBS	R0, R3, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;driverrf4463pro.c,72 :: 		for ( i = 4; i < 12; i++ ) {
ADDS	R3, #1
UXTB	R3, R3
;driverrf4463pro.c,74 :: 		}
; i end address is: 12 (R3)
IT	AL
BLAL	L_vRF4463Init65
L_vRF4463Init66:
;driverrf4463pro.c,75 :: 		for ( i = 4; i < 11; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init68:
; i start address is: 16 (R4)
CMP	R4, #11
IT	CS
BLCS	L_vRF4463Init69
;driverrf4463pro.c,76 :: 		RF_MODEM_AFC_GEAR_7_data[ i ] = RF_MODEM_AFC_GEAR_7_850[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_AFC_GEAR_7_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AFC_GEAR_7_data+0)
ADDS	R3, R0, R4
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #7
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_AFC_GEAR_7_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_AFC_GEAR_7_850+0)
ADDS	R1, R0, R1
SUBS	R0, R4, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,75 :: 		for ( i = 4; i < 11; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,77 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init68
L_vRF4463Init69:
;driverrf4463pro.c,78 :: 		for ( i = 4; i < 15; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init71:
; i start address is: 16 (R4)
CMP	R4, #15
IT	CS
BLCS	L_vRF4463Init72
;driverrf4463pro.c,79 :: 		RF_MODEM_OOK_CNT1_11_data[ i ] = RF_MODEM_OOK_CNT1_11_850[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_OOK_CNT1_11_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_OOK_CNT1_11_data+0)
ADDS	R3, R0, R4
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #11
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_OOK_CNT1_11_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_OOK_CNT1_11_850+0)
ADDS	R1, R0, R1
SUBS	R0, R4, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,78 :: 		for ( i = 4; i < 15; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,80 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init71
L_vRF4463Init72:
;driverrf4463pro.c,81 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init74:
; i start address is: 16 (R4)
CMP	R4, #16
IT	CS
BLCS	L_vRF4463Init75
;driverrf4463pro.c,82 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
ADDS	R3, R0, R4
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #12
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850+0)
ADDS	R1, R0, R1
SUBS	R0, R4, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,81 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,83 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init74
L_vRF4463Init75:
;driverrf4463pro.c,84 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init77:
; i start address is: 16 (R4)
CMP	R4, #16
IT	CS
BLCS	L_vRF4463Init78
;driverrf4463pro.c,85 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
ADDS	R3, R0, R4
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #12
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850+0)
ADDS	R1, R0, R1
SUBS	R0, R4, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,84 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,86 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init77
L_vRF4463Init78:
;driverrf4463pro.c,87 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init80:
; i start address is: 16 (R4)
CMP	R4, #16
IT	CS
BLCS	L_vRF4463Init81
;driverrf4463pro.c,88 :: 		RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
ADDS	R3, R0, R4
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #12
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850+0)
ADDS	R1, R0, R1
SUBS	R0, R4, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,87 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,89 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init80
L_vRF4463Init81:
;driverrf4463pro.c,90 :: 		for ( i = 4; i < 13; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init83:
; i start address is: 16 (R4)
CMP	R4, #13
IT	CS
BLCS	L_vRF4463Init84
;driverrf4463pro.c,91 :: 		RF_MODEM_AGC_WINDOW_SIZE_9_data[ i ] = RF_MODEM_AGC_WINDOW_SIZE_9_850[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
ADDS	R3, R0, R4
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #9
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_850+0)
ADDS	R1, R0, R1
SUBS	R0, R4, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,90 :: 		for ( i = 4; i < 13; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,92 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init83
L_vRF4463Init84:
;driverrf4463pro.c,93 :: 		for ( i = 4; i < 13; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init86:
; i start address is: 16 (R4)
CMP	R4, #13
IT	CS
BLCS	L_vRF4463Init87
;driverrf4463pro.c,94 :: 		RF_MODEM_BCR_OSR_1_9_data[ i ] = RF_MODEM_BCR_OSR_1_9_850[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
ADDS	R3, R0, R4
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #9
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_BCR_OSR_1_9_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_BCR_OSR_1_9_850+0)
ADDS	R1, R0, R1
SUBS	R0, R4, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,93 :: 		for ( i = 4; i < 13; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,95 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init86
L_vRF4463Init87:
;driverrf4463pro.c,96 :: 		}
L_vRF4463Init64:
;driverrf4463pro.c,97 :: 		for ( i = 4; i < 11; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init89:
; i start address is: 16 (R4)
CMP	R4, #11
IT	CS
BLCS	L_vRF4463Init90
;driverrf4463pro.c,98 :: 		RF_SYNTH_PFDCP_CPFF_7_data[ i ] = RF_SYNTH_PFDCP_CPFF_7[ ucRF4463Rate ][ i - 4 ];
MOVW	R0, #lo_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
MOVT	R0, #hi_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
ADDS	R3, R0, R4
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #7
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_SYNTH_PFDCP_CPFF_7+0)
MOVT	R0, #hi_addr(_RF_SYNTH_PFDCP_CPFF_7+0)
ADDS	R1, R0, R1
SUBS	R0, R4, #4
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,97 :: 		for ( i = 4; i < 11; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,99 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init89
L_vRF4463Init90:
;driverrf4463pro.c,103 :: 		vRF4463GPIO_SET( ucRF4463Mode );                              // PARAMETRO CONFIGURABLE
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
BL	_vRF4463GPIO_SET+0
;driverrf4463pro.c,106 :: 		app_command_buf[ 0 ] = 0x11;    // SET PROPERTY
MOV	R2, SP
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,107 :: 		app_command_buf[ 1 ] = 0x00;    // 0x0000
ADDS	R1, R2, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,108 :: 		app_command_buf[ 2 ] = 0x01;    // Total 1 Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,109 :: 		app_command_buf[ 3 ] = 0x00;    // 0x0000
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,110 :: 		app_command_buf[ 4 ] = 98;      // freq  adjustment    ( rango desde 0 - 127 Low cap - High Cap )
ADDS	R1, R2, #4
MOVS	R0, #98
STRB	R0, [R1, #0]
;driverrf4463pro.c,111 :: 		spi_write( 5, app_command_buf );
MOV	R1, R2
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,114 :: 		app_command_buf[ 0 ] = 0x11;    // SET PROPERTY
MOV	R2, SP
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,115 :: 		app_command_buf[ 1 ] = 0x00;    // 0x0003
ADDS	R1, R2, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,116 :: 		app_command_buf[ 2 ] = 0x01;    // Total 1 Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,117 :: 		app_command_buf[ 3 ] = 0x03;    // 0x0003
ADDS	R1, R2, #3
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,118 :: 		app_command_buf[ 4 ] = 0x40;    // tx = rx = 64 byte, ordinary PH,high performance mode  ?????????????????????
ADDS	R1, R2, #4
MOVS	R0, #64
STRB	R0, [R1, #0]
;driverrf4463pro.c,119 :: 		spi_write( 5, app_command_buf );
MOV	R1, R2
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,123 :: 		spi_write( 0x08, RF_FRR_CTL_A_MODE_4_data );    // disable all fast response register
MOVW	R1, #lo_addr(_RF_FRR_CTL_A_MODE_4_data+0)
MOVT	R1, #hi_addr(_RF_FRR_CTL_A_MODE_4_data+0)
MOVS	R0, #8
BL	_spi_write+0
;driverrf4463pro.c,126 :: 		app_command_buf[ 0 ] = 0x11;    // SET PROPERTY
MOV	R2, SP
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,127 :: 		app_command_buf[ 1 ] = 0x10;    // 0x1000
ADDS	R1, R2, #1
MOVS	R0, #16
STRB	R0, [R1, #0]
;driverrf4463pro.c,128 :: 		app_command_buf[ 2 ] = 0x09;    // Total 9 Parameters
ADDS	R1, R2, #2
MOVS	R0, #9
STRB	R0, [R1, #0]
;driverrf4463pro.c,129 :: 		app_command_buf[ 3 ] = 0x00;    // 0x1000
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,131 :: 		if ( ucRF4463Mode == tx_test_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BLNE	L_vRF4463Init92
;driverrf4463pro.c,132 :: 		app_command_buf[ 4 ] = 0xff;     //  Need to send 255 bytes of Preamble
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #255
STRB	R0, [R1, #0]
;driverrf4463pro.c,133 :: 		}
IT	AL
BLAL	L_vRF4463Init93
L_vRF4463Init92:
;driverrf4463pro.c,135 :: 		app_command_buf[ 4 ] = 0x08;   //  Need to send 8 bytes of Preamble
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,136 :: 		}
L_vRF4463Init93:
;driverrf4463pro.c,139 :: 		app_command_buf[ 5 ]   = 0x14;       // To detect 20 bit sync word,
MOV	R2, SP
ADDS	R1, R2, #5
MOVS	R0, #20
STRB	R0, [R1, #0]
;driverrf4463pro.c,140 :: 		app_command_buf[ 6 ]   = 0x00;       // Non-standard preamble settings, useless
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,141 :: 		app_command_buf[ 7 ]   = 0x0f;       // Time of the preamble Timeout   ????????????????????????????????????????????????????????????
ADDS	R1, R2, #7
MOVS	R0, #15
STRB	R0, [R1, #0]
;driverrf4463pro.c,142 :: 		app_command_buf[ 8 ]   = 0x31;       // The length of the preamble is   byte Calculation , 1st = 1 NO manchest  Encoding, using standard 1010.??
MOV	R1, R2
ADDS	R1, #8
MOVS	R0, #49
STRB	R0, [R1, #0]
;driverrf4463pro.c,143 :: 		app_command_buf[ 9 ]   = 0x0;        // Non-standard Preamble Patten 4th byte
MOV	R1, R2
ADDS	R1, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,144 :: 		app_command_buf[ 10 ]  = 0x00;       // Non-standard Preamble Patten 3rd byte
MOV	R1, R2
ADDS	R1, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,145 :: 		app_command_buf[ 11 ]  = 0x00;       // Non-standard Preamble Patten 2nd byte
MOV	R1, R2
ADDS	R1, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,146 :: 		app_command_buf[ 12 ]  = 0x00;       // Non-standard Preamble Patten 1st byte
MOV	R1, R2
ADDS	R1, #12
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,147 :: 		spi_write(13, app_command_buf);
MOV	R1, R2
MOVS	R0, #13
BL	_spi_write+0
;driverrf4463pro.c,150 :: 		app_command_buf[ 0 ] = 0x11;         // SET PROPERTY
MOV	R2, SP
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,151 :: 		app_command_buf[ 1 ] = 0x11;         // command = 0x1100
ADDS	R1, R2, #1
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,152 :: 		app_command_buf[ 2 ] = 0x05;         // Total 5 Parameters
ADDS	R1, R2, #2
MOVS	R0, #5
STRB	R0, [R1, #0]
;driverrf4463pro.c,153 :: 		app_command_buf[ 3 ] = 0x00;         // command = 0x1100
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,154 :: 		app_command_buf[ 4 ] = 0x01;         // The synchronization word is defined and sent in the length field, and the synchronization word cannot be wrong,Not 4FSK, not manchest encoding, only 2 bytes
ADDS	R1, R2, #4
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,156 :: 		if ( ucRF4463Mode == tx_test_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BLNE	L_vRF4463Init94
;driverrf4463pro.c,157 :: 		app_command_buf[ 5 ] = 0x55;      // Sync word 3
MOV	R2, SP
ADDS	R1, R2, #5
MOVS	R0, #85
STRB	R0, [R1, #0]
;driverrf4463pro.c,158 :: 		app_command_buf[ 6 ] = 0x55;      // Sync word 2
ADDS	R1, R2, #6
MOVS	R0, #85
STRB	R0, [R1, #0]
;driverrf4463pro.c,159 :: 		}
IT	AL
BLAL	L_vRF4463Init95
L_vRF4463Init94:
;driverrf4463pro.c,161 :: 		app_command_buf[ 5 ] = 0x2d;    // Sync word 3
MOV	R2, SP
ADDS	R1, R2, #5
MOVS	R0, #45
STRB	R0, [R1, #0]
;driverrf4463pro.c,162 :: 		app_command_buf[ 6 ] = 0xd4;    // Sync word 2
ADDS	R1, R2, #6
MOVS	R0, #212
STRB	R0, [R1, #0]
;driverrf4463pro.c,163 :: 		}
L_vRF4463Init95:
;driverrf4463pro.c,165 :: 		app_command_buf[ 7 ] =  0x00;        // Sync word 1
MOV	R2, SP
ADDS	R1, R2, #7
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,166 :: 		app_command_buf[ 8 ] = 0x00;         // Sync word 0
MOV	R1, R2
ADDS	R1, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,167 :: 		spi_write( 9, app_command_buf );
MOV	R1, R2
MOVS	R0, #9
BL	_spi_write+0
;driverrf4463pro.c,170 :: 		app_command_buf[ 0 ] = 0x11;        // SET PROPERTY
MOV	R2, SP
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,171 :: 		app_command_buf[ 1 ] = 0x12;        // command = 0x1200
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,172 :: 		app_command_buf[ 2 ] = 0x01;        // Total 1 Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,173 :: 		app_command_buf[ 3 ] = 0x00;        // command = 0x1200
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,174 :: 		app_command_buf[ 4 ] = 0x85;        // 1?cRC ??,CRC = itu-c, enable crc   ( original 0x81; )
ADDS	R1, R2, #4
MOVS	R0, #133
STRB	R0, [R1, #0]
;driverrf4463pro.c,175 :: 		spi_write( 5, app_command_buf );
MOV	R1, R2
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,178 :: 		app_command_buf[ 0 ] = 0x11;        // SET PROPERTY
MOV	R2, SP
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,179 :: 		app_command_buf[ 1 ] = 0x12;        // command = 0x1206
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,180 :: 		app_command_buf[ 2 ] = 0x01;        // Total 1Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,181 :: 		app_command_buf[ 3 ] = 0x06;        // command = 0x1206
ADDS	R1, R2, #3
MOVS	R0, #6
STRB	R0, [R1, #0]
;driverrf4463pro.c,182 :: 		app_command_buf[ 4 ] = 0x02;        //  tx = rx = 120d--1220 (tx packet,ph enable, not 4fsk, After receiving a packet of data,RX off,CRC Do not flip ,CRC MSB, data MSB
ADDS	R1, R2, #4
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,183 :: 		spi_write( 5, app_command_buf );
MOV	R1, R2
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,186 :: 		app_command_buf[ 0 ] = 0x11;        // SET PROPERTY
MOV	R2, SP
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,187 :: 		app_command_buf[ 1 ] = 0x12;        // command = 0x1208
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,188 :: 		app_command_buf[ 2 ] = 0x03;        // Total 3 Parameters
ADDS	R1, R2, #2
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,189 :: 		app_command_buf[ 3 ] = 0x08;        // command = 0x1208
ADDS	R1, R2, #3
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,190 :: 		app_command_buf[ 4 ] = 0x00;        // Length Field = LSB,  length Only 1 byte,length Not put In FiFo, fixed packet length mode
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,191 :: 		app_command_buf[ 5 ] = 0x00;        // Used for variable packet length mode, which defines which Field contains length Filed
ADDS	R1, R2, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,192 :: 		app_command_buf[ 6 ] = 0x00;        // Used for variable packet length mode, adjust the length of variable packet length
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,193 :: 		spi_write( 7, app_command_buf );
MOV	R1, R2
MOVS	R0, #7
BL	_spi_write+0
;driverrf4463pro.c,196 :: 		app_command_buf[ 0 ]  = 0x11;
MOV	R2, SP
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,197 :: 		app_command_buf[ 1 ]  = 0x12;       // 0x120d
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,198 :: 		app_command_buf[ 2 ]  = 0x0c;       // Total 12 Parameters
ADDS	R1, R2, #2
MOVS	R0, #12
STRB	R0, [R1, #0]
;driverrf4463pro.c,199 :: 		app_command_buf[ 3 ]  = 0x0d;       // 0x120d
ADDS	R1, R2, #3
MOVS	R0, #13
STRB	R0, [R1, #0]
;driverrf4463pro.c,200 :: 		app_command_buf[ 4 ]  = 0x00;       //  Field 1 length (?4?)
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,201 :: 		app_command_buf[ 5 ]  = payload_length;   //  field 1 length, (? 8?), ?Total14???
ADDS	R1, R2, #5
MOVS	R0, #66
STRB	R0, [R1, #0]
;driverrf4463pro.c,202 :: 		app_command_buf[ 6 ]  = 0x04;       // field 1 Is not 4FSK,manchest, whiting, PN9,
ADDS	R1, R2, #6
MOVS	R0, #4
STRB	R0, [R1, #0]
;driverrf4463pro.c,203 :: 		app_command_buf[ 7 ]  = 0xaa;       // field 1 crc enble, check enbale, There are also launchingCRC,cRC?Seed ?CRC_seed?????
ADDS	R1, R2, #7
MOVS	R0, #170
STRB	R0, [R1, #0]
;driverrf4463pro.c,204 :: 		app_command_buf[ 8 ]  = 0x00;       //  field 2 length(?4?)
MOV	R1, R2
ADDS	R1, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,205 :: 		app_command_buf[ 9 ]  = 0x00;           //  field 2 length, (? 8?), length = 0 Means thisfield did not use
MOV	R1, R2
ADDS	R1, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,206 :: 		app_command_buf[ 10 ] = 0x00;       // field 2 Is not 4FSK,manchest, whiting, PN9
MOV	R1, R2
ADDS	R1, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,207 :: 		app_command_buf[ 11 ] = 0x00;       //  field 2 ?CRCSet up
MOV	R1, R2
ADDS	R1, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,208 :: 		app_command_buf[ 12 ] = 0x00;       //  field 3 length, (? 8?), length = 0 Means thisfield did not use
MOV	R1, R2
ADDS	R1, #12
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,209 :: 		app_command_buf[ 13 ] = 0x00;           //  field 3 length, (? 8?), length = 0 Means thisfield did not use
MOV	R1, R2
ADDS	R1, #13
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,210 :: 		app_command_buf[ 14 ] = 0x00;       //  field 3 Is not 4FSK,manchest, whiting, PN9
MOV	R1, R2
ADDS	R1, #14
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,211 :: 		app_command_buf[ 15 ] = 0x00;       //  field 3 ?CRCSet up
MOV	R1, R2
ADDS	R1, #15
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,212 :: 		spi_write( 16, app_command_buf );
MOV	R1, R2
MOVS	R0, #16
BL	_spi_write+0
;driverrf4463pro.c,215 :: 		app_command_buf[ 0 ]  = 0x11;
MOV	R2, SP
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,216 :: 		app_command_buf[ 1 ]  = 0x12;       // 0x1219
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,217 :: 		app_command_buf[ 2 ]  = 0x08;       // Total 8Parameters
ADDS	R1, R2, #2
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,218 :: 		app_command_buf[ 3 ]  = 0x19;       // 0x1219
ADDS	R1, R2, #3
MOVS	R0, #25
STRB	R0, [R1, #0]
;driverrf4463pro.c,219 :: 		app_command_buf[ 4 ]  = 0x00;       // field4 length(?4?)
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,220 :: 		app_command_buf[ 5 ]  = 0x00;       // field 4 length, (? 8?), length = 0 Means this field did not use
ADDS	R1, R2, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,221 :: 		app_command_buf[ 6 ]  = 0x00;       // field 4 Is not 4FSK,manchest, whiting, PN9
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,222 :: 		app_command_buf[ 7 ]  = 0x00;       // field 4 ?CRCSet up
ADDS	R1, R2, #7
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,223 :: 		app_command_buf[ 8 ]  = 0x00;       // field5 length(?4?)
MOV	R1, R2
ADDS	R1, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,224 :: 		app_command_buf[ 9 ]  = 0x00;       // field 5 length, (? 8?), length = 0 Means this field did not use
MOV	R1, R2
ADDS	R1, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,225 :: 		app_command_buf[ 10 ] = 0x00;       // field 5 Is not 4FSK,manchest, whiting, PN9
MOV	R1, R2
ADDS	R1, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,226 :: 		app_command_buf[ 11 ] = 0x00;       // field 5 ?CRCSet up
MOV	R1, R2
ADDS	R1, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,227 :: 		spi_write( 12, app_command_buf );
MOV	R1, R2
MOVS	R0, #12
BL	_spi_write+0
;driverrf4463pro.c,230 :: 		spi_write( 0x10, RF_MODEM_MOD_TYPE_12_data );   // //  2FSK ,  module source = PH fifo, disable manchest, tx, rx Do not flip, deviation Do not flip
MOVW	R1, #lo_addr(_RF_MODEM_MOD_TYPE_12_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_MOD_TYPE_12_data+0)
MOVS	R0, #16
BL	_spi_write+0
;driverrf4463pro.c,233 :: 		app_command_buf[0] = 0x11;
MOV	R2, SP
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,234 :: 		app_command_buf[1]  = 0x20;    // 0x200c
ADDS	R1, R2, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,235 :: 		app_command_buf[2]  = 0x01;    // Total 1Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,236 :: 		app_command_buf[3]  = 0x0c;   // 0x200c
ADDS	R1, R2, #3
MOVS	R0, #12
STRB	R0, [R1, #0]
;driverrf4463pro.c,238 :: 		if ( ucRF4463Freq3 < 8 ) {
MOVW	R0, #lo_addr(_ucRF4463Freq3+0)
MOVT	R0, #hi_addr(_ucRF4463Freq3+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CS
BLCS	L_vRF4463Init96
;driverrf4463pro.c,239 :: 		if ( ucRF4463Rate >= dr_256k ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CC
BLCC	L_vRF4463Init97
;driverrf4463pro.c,240 :: 		app_command_buf[ 4 ] = 0x4f;
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #79
STRB	R0, [R1, #0]
;driverrf4463pro.c,241 :: 		}
IT	AL
BLAL	L_vRF4463Init98
L_vRF4463Init97:
;driverrf4463pro.c,242 :: 		else if ( ucRF4463Rate >= dr_19p2 ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	CC
BLCC	L_vRF4463Init99
;driverrf4463pro.c,243 :: 		app_command_buf[ 4 ]  = 0x5e;
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #94
STRB	R0, [R1, #0]
;driverrf4463pro.c,244 :: 		}
IT	AL
BLAL	L_vRF4463Init100
L_vRF4463Init99:
;driverrf4463pro.c,246 :: 		app_command_buf[ 4 ]  = 0xd2;
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #210
STRB	R0, [R1, #0]
;driverrf4463pro.c,247 :: 		}
L_vRF4463Init100:
L_vRF4463Init98:
;driverrf4463pro.c,248 :: 		}
IT	AL
BLAL	L_vRF4463Init101
L_vRF4463Init96:
;driverrf4463pro.c,250 :: 		if ( ucRF4463Rate >= dr_115p2 ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	CC
BLCC	L_vRF4463Init102
;driverrf4463pro.c,251 :: 		app_command_buf[ 4 ]  = 0x69;        // 15k
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #105
STRB	R0, [R1, #0]
;driverrf4463pro.c,252 :: 		}
IT	AL
BLAL	L_vRF4463Init103
L_vRF4463Init102:
;driverrf4463pro.c,253 :: 		else if ( ucRF4463Rate >= dr_19p2 ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	CC
BLCC	L_vRF4463Init104
;driverrf4463pro.c,254 :: 		app_command_buf[ 4 ]  = 0x5e;        // 10k
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #94
STRB	R0, [R1, #0]
;driverrf4463pro.c,255 :: 		}
IT	AL
BLAL	L_vRF4463Init105
L_vRF4463Init104:
;driverrf4463pro.c,257 :: 		app_command_buf[ 4 ]  = 0x18; // 8k
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #24
STRB	R0, [R1, #0]
;driverrf4463pro.c,258 :: 		}
L_vRF4463Init105:
L_vRF4463Init103:
;driverrf4463pro.c,259 :: 		}
L_vRF4463Init101:
;driverrf4463pro.c,260 :: 		spi_write( 5, app_command_buf );
MOV	R0, SP
MOV	R1, R0
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,263 :: 		spi_write( 0x0C, RF_MODEM_TX_RAMP_DELAY_8_data );            // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
MOVS	R0, #12
BL	_spi_write+0
;driverrf4463pro.c,264 :: 		spi_write( 0x0D, RF_MODEM_BCR_OSR_1_9_data );                // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
MOVS	R0, #13
BL	_spi_write+0
;driverrf4463pro.c,265 :: 		spi_write( 0x0B, RF_MODEM_AFC_GEAR_7_data );                // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_AFC_GEAR_7_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_AFC_GEAR_7_data+0)
MOVS	R0, #11
BL	_spi_write+0
;driverrf4463pro.c,266 :: 		spi_write( 0x05, RF_MODEM_AGC_CONTROL_1_data );                // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_AGC_CONTROL_1_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_AGC_CONTROL_1_data+0)
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,267 :: 		spi_write( 0x0D, RF_MODEM_AGC_WINDOW_SIZE_9_data );        // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
MOVS	R0, #13
BL	_spi_write+0
;driverrf4463pro.c,268 :: 		spi_write( 0x0F, RF_MODEM_OOK_CNT1_11_data );                // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_OOK_CNT1_11_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_OOK_CNT1_11_data+0)
MOVS	R0, #15
BL	_spi_write+0
;driverrf4463pro.c,271 :: 		app_command_buf[ 0 ] = 0x11;
MOV	R2, SP
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,272 :: 		app_command_buf[ 1 ] = 0x20;    // 0x204e
ADDS	R1, R2, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,273 :: 		app_command_buf[ 2 ] = 0x01;    // Total 1Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,274 :: 		app_command_buf[ 3 ] = 0x4e;   // 0x204e
ADDS	R1, R2, #3
MOVS	R0, #78
STRB	R0, [R1, #0]
;driverrf4463pro.c,276 :: 		if ( ucRF4463Rate == dr_500 ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	NE
BLNE	L_vRF4463Init106
;driverrf4463pro.c,277 :: 		app_command_buf[ 4 ] = 0x3a;
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #58
STRB	R0, [R1, #0]
;driverrf4463pro.c,278 :: 		}
IT	AL
BLAL	L_vRF4463Init107
L_vRF4463Init106:
;driverrf4463pro.c,280 :: 		app_command_buf[ 4 ] = 0x40;  //  rssi Reading deviation, the difference with the true value
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #64
STRB	R0, [R1, #0]
;driverrf4463pro.c,281 :: 		}
L_vRF4463Init107:
;driverrf4463pro.c,282 :: 		spi_write( 5, app_command_buf );
MOV	R0, SP
MOV	R1, R0
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,285 :: 		spi_write( 0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data );  // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVS	R0, #16
BL	_spi_write+0
;driverrf4463pro.c,286 :: 		spi_write( 0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data );   // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVS	R0, #16
BL	_spi_write+0
;driverrf4463pro.c,287 :: 		spi_write( 0x10, RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data );   // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVS	R0, #16
BL	_spi_write+0
;driverrf4463pro.c,290 :: 		app_command_buf[ 0 ]  = 0x11;
MOV	R2, SP
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,291 :: 		app_command_buf[ 1 ]  = 0x22;    // 0x2200
ADDS	R1, R2, #1
MOVS	R0, #34
STRB	R0, [R1, #0]
;driverrf4463pro.c,292 :: 		app_command_buf[ 2 ]  = 0x04;    // Total 4Parameters
ADDS	R1, R2, #2
MOVS	R0, #4
STRB	R0, [R1, #0]
;driverrf4463pro.c,293 :: 		app_command_buf[ 3 ]  = 0x00;   // 0x2200
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,294 :: 		app_command_buf[ 4 ]  = 0x08;  //0x10;   //   PA mode  = default , ??Class E mode,?Is not Switch Current mode  ????????
ADDS	R1, R2, #4
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,296 :: 		if ( ucRF4463Power > 0 || ucRF4463Power < 127 ) {
MOVW	R0, #lo_addr(_ucRF4463Power+0)
MOVT	R0, #hi_addr(_ucRF4463Power+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	HI
BLHI	L__vRF4463Init388
MOVW	R0, #lo_addr(_ucRF4463Power+0)
MOVT	R0, #hi_addr(_ucRF4463Power+0)
LDRB	R0, [R0, #0]
CMP	R0, #127
IT	CC
BLCC	L__vRF4463Init387
IT	AL
BLAL	L_vRF4463Init110
L__vRF4463Init388:
L__vRF4463Init387:
;driverrf4463pro.c,297 :: 		app_command_buf[ 5 ]  = ucRF4463Power;   //  Set to maximum power
MOV	R0, SP
ADDS	R1, R0, #5
MOVW	R0, #lo_addr(_ucRF4463Power+0)
MOVT	R0, #hi_addr(_ucRF4463Power+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,298 :: 		}
IT	AL
BLAL	L_vRF4463Init111
L_vRF4463Init110:
;driverrf4463pro.c,300 :: 		app_command_buf[ 5 ]  = 127;
MOV	R0, SP
ADDS	R1, R0, #5
MOVS	R0, #127
STRB	R0, [R1, #0]
;driverrf4463pro.c,301 :: 		}
L_vRF4463Init111:
;driverrf4463pro.c,303 :: 		app_command_buf[ 6 ] = 0x00; //???????? 0x00;   // CLK duty = 50%, other = Default
MOV	R0, SP
ADDS	R1, R0, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,305 :: 		if ( ( ucRF4463Rate <= dr_115p2 )||( ucRF4463Rate == dr_500 ) ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	LS
BLLS	L__vRF4463Init390
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	EQ
BLEQ	L__vRF4463Init389
IT	AL
BLAL	L_vRF4463Init114
L__vRF4463Init390:
L__vRF4463Init389:
;driverrf4463pro.c,306 :: 		app_command_buf[ 7 ]  = 0x3d;  // ???????? 0x5d;   // PA ramp time = default
MOV	R0, SP
ADDS	R1, R0, #7
MOVS	R0, #61
STRB	R0, [R1, #0]
;driverrf4463pro.c,307 :: 		}
IT	AL
BLAL	L_vRF4463Init115
L_vRF4463Init114:
;driverrf4463pro.c,309 :: 		app_command_buf[ 7 ]  = 0x5d;
MOV	R0, SP
ADDS	R1, R0, #7
MOVS	R0, #93
STRB	R0, [R1, #0]
;driverrf4463pro.c,310 :: 		}
L_vRF4463Init115:
;driverrf4463pro.c,311 :: 		spi_write( 8, app_command_buf );
MOV	R0, SP
MOV	R1, R0
MOVS	R0, #8
BL	_spi_write+0
;driverrf4463pro.c,315 :: 		spi_write( 0x0B , RF_SYNTH_PFDCP_CPFF_7_data );      // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
MOVT	R1, #hi_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
MOVS	R0, #11
BL	_spi_write+0
;driverrf4463pro.c,318 :: 		if ( ucRF4463MatchEnabled ) {
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L_vRF4463Init116
;driverrf4463pro.c,319 :: 		app_command_buf[ 0 ]  = 0x11;               // SetProperty
MOV	R2, SP
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,320 :: 		app_command_buf[ 1 ]  = 0x30;               // 0x30 group
ADDS	R1, R2, #1
MOVS	R0, #48
STRB	R0, [R1, #0]
;driverrf4463pro.c,321 :: 		app_command_buf[ 2 ]  = 0x0c;               // Total 12 Parameters
ADDS	R1, R2, #2
MOVS	R0, #12
STRB	R0, [R1, #0]
;driverrf4463pro.c,322 :: 		app_command_buf[ 3 ]  = 0x00;               // 0x00 Index
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,323 :: 		app_command_buf[ 4 ]  = ucRF4463ByteMatch1; // match 1 Value of
ADDS	R1, R2, #4
MOVW	R0, #lo_addr(_ucRF4463ByteMatch1+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch1+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,324 :: 		app_command_buf[ 5 ]  = ucRF4463ByteMask1;  // match 1 mask
ADDS	R1, R2, #5
MOVW	R0, #lo_addr(_ucRF4463ByteMask1+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask1+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,325 :: 		app_command_buf[ 6 ]  = ucRF4463MatchEnableReg; //  0x40; // enable match 1, match 1 The distance between the value of and the synchronization word, 0 = match
ADDS	R1, R2, #6
MOVW	R0, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnableReg+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,326 :: 		app_command_buf[ 7 ]  = ucRF4463ByteMatch2; // match 2 Value of
ADDS	R1, R2, #7
MOVW	R0, #lo_addr(_ucRF4463ByteMatch2+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch2+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,327 :: 		app_command_buf[ 8 ]  = ucRF4463ByteMask2;  // match 2 mask
MOV	R1, R2
ADDS	R1, #8
MOVW	R0, #lo_addr(_ucRF4463ByteMask2+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask2+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,328 :: 		app_command_buf[ 9 ]  = 0x01;               // enable match 2, match 2 The distance between the value of and the synchronization word  , and function
MOV	R1, R2
ADDS	R1, #9
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,329 :: 		app_command_buf[ 10 ] = ucRF4463ByteMatch3; // match 3 Value of
MOV	R1, R2
ADDS	R1, #10
MOVW	R0, #lo_addr(_ucRF4463ByteMatch3+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch3+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,330 :: 		app_command_buf[ 11 ] = ucRF4463ByteMask3;  // match 3 mask
MOV	R1, R2
ADDS	R1, #11
MOVW	R0, #lo_addr(_ucRF4463ByteMask3+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask3+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,331 :: 		app_command_buf[ 12 ] = 0x02;;              // enable match 3, match 3 The distance between the value of and the synchronization word    and function
MOV	R1, R2
ADDS	R1, #12
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,332 :: 		app_command_buf[ 13 ] = ucRF4463ByteMatch4; // match 4 Value of
MOV	R1, R2
ADDS	R1, #13
MOVW	R0, #lo_addr(_ucRF4463ByteMatch4+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch4+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,333 :: 		app_command_buf[ 14 ] = ucRF4463ByteMask4;  // match 4 mask
MOV	R1, R2
ADDS	R1, #14
MOVW	R0, #lo_addr(_ucRF4463ByteMask4+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask4+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,334 :: 		app_command_buf[ 15 ] = 0x03;               // enable match 4, match 4 The distance between the value of and the synchronization word    and function
MOV	R1, R2
ADDS	R1, #15
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,335 :: 		spi_write( 16, app_command_buf );
MOV	R1, R2
MOVS	R0, #16
BL	_spi_write+0
;driverrf4463pro.c,337 :: 		if ( ucRF4463MatchEnableReg == 0x00 ) {
MOVW	R0, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnableReg+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BLNE	L_vRF4463Init117
;driverrf4463pro.c,338 :: 		ucRF4463MatchEnabled = 0;                // deshabilita el Match
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R1, [R0, #0]
;driverrf4463pro.c,339 :: 		}
L_vRF4463Init117:
;driverrf4463pro.c,340 :: 		}
L_vRF4463Init116:
;driverrf4463pro.c,343 :: 		rf_init_freq();     // FUNCION DE FRECUENCIA ( REVISAR PARAMETROS )
BL	_rf_init_freq+0
;driverrf4463pro.c,344 :: 		}
L_end_vRF4463Init:
ADD	SP, SP, #20
POP	(R15)
; end of _vRF4463Init
_vRF4463GPIO_SET:
;driverrf4463pro.c,350 :: 		void vRF4463GPIO_SET( unsigned char ucData ) {
; ucData start address is: 0 (R0)
PUSH	(R14)
SUB	SP, SP, #8
; ucData end address is: 0 (R0)
; ucData start address is: 0 (R0)
;driverrf4463pro.c,353 :: 		ucAppCommandBuf[0] = 0x13;     // gpio Set up
MOV	R2, SP
MOVS	R1, #19
STRB	R1, [R2, #0]
;driverrf4463pro.c,355 :: 		switch ( ucData ) {
IT	AL
BLAL	L_vRF4463GPIO_SET118
; ucData end address is: 0 (R0)
;driverrf4463pro.c,356 :: 		case tx_normal:
L_vRF4463GPIO_SET120:
;driverrf4463pro.c,357 :: 		case rx_normal: ucAppCommandBuf[ 1 ] = 3;                 // GPIO0=1
L_vRF4463GPIO_SET121:
MOV	R3, SP
ADDS	R2, R3, #1
MOVS	R1, #3
STRB	R1, [R2, #0]
;driverrf4463pro.c,358 :: 		ucAppCommandBuf[ 2 ] = 2;                // GPIO1=0
ADDS	R2, R3, #2
MOVS	R1, #2
STRB	R1, [R2, #0]
;driverrf4463pro.c,359 :: 		break;
IT	AL
BLAL	L_vRF4463GPIO_SET119
;driverrf4463pro.c,361 :: 		case tx_test:   ucAppCommandBuf[ 1 ] = 3;                 // GPIO0=1
L_vRF4463GPIO_SET122:
MOV	R3, SP
ADDS	R2, R3, #1
MOVS	R1, #3
STRB	R1, [R2, #0]
;driverrf4463pro.c,362 :: 		ucAppCommandBuf[ 2 ] = 3;                // GPIO1=1
ADDS	R2, R3, #2
MOVS	R1, #3
STRB	R1, [R2, #0]
;driverrf4463pro.c,363 :: 		break;
IT	AL
BLAL	L_vRF4463GPIO_SET119
;driverrf4463pro.c,365 :: 		case rx_test:   ucAppCommandBuf[ 1 ] = 2;                 // GPIO0=0
L_vRF4463GPIO_SET123:
MOV	R3, SP
ADDS	R2, R3, #1
MOVS	R1, #2
STRB	R1, [R2, #0]
;driverrf4463pro.c,366 :: 		ucAppCommandBuf[ 2 ] = 20;                // GPIO1=RX DATA
ADDS	R2, R3, #2
MOVS	R1, #20
STRB	R1, [R2, #0]
;driverrf4463pro.c,367 :: 		break;
IT	AL
BLAL	L_vRF4463GPIO_SET119
;driverrf4463pro.c,369 :: 		case rf_off:    ucAppCommandBuf[ 1 ] = 2;                 // GPIO0=0
L_vRF4463GPIO_SET124:
MOV	R3, SP
ADDS	R2, R3, #1
MOVS	R1, #2
STRB	R1, [R2, #0]
;driverrf4463pro.c,370 :: 		ucAppCommandBuf[ 2 ] = 2;                // GPIO1=0
ADDS	R2, R3, #2
MOVS	R1, #2
STRB	R1, [R2, #0]
;driverrf4463pro.c,371 :: 		break;
IT	AL
BLAL	L_vRF4463GPIO_SET119
;driverrf4463pro.c,372 :: 		}
L_vRF4463GPIO_SET118:
; ucData start address is: 0 (R0)
CMP	R0, #0
IT	EQ
BLEQ	L_vRF4463GPIO_SET120
CMP	R0, #1
IT	EQ
BLEQ	L_vRF4463GPIO_SET121
CMP	R0, #2
IT	EQ
BLEQ	L_vRF4463GPIO_SET122
CMP	R0, #3
IT	EQ
BLEQ	L_vRF4463GPIO_SET123
CMP	R0, #4
IT	EQ
BLEQ	L_vRF4463GPIO_SET124
; ucData end address is: 0 (R0)
L_vRF4463GPIO_SET119:
;driverrf4463pro.c,374 :: 		ucAppCommandBuf[ 3 ]  = 0x21;     //0x20;   //  gpio2, h = tx mode
MOV	R3, SP
ADDS	R2, R3, #3
MOVS	R1, #33
STRB	R1, [R2, #0]
;driverrf4463pro.c,375 :: 		ucAppCommandBuf[ 4 ]  = 0x20;     // 0x14;  //   gpio3
ADDS	R2, R3, #4
MOVS	R1, #32
STRB	R1, [R2, #0]
;driverrf4463pro.c,376 :: 		ucAppCommandBuf[ 5 ]  = 0x27;     // nIRQ
ADDS	R2, R3, #5
MOVS	R1, #39
STRB	R1, [R2, #0]
;driverrf4463pro.c,377 :: 		ucAppCommandBuf[ 6 ]  = 0x0b;     // sdo
ADDS	R2, R3, #6
MOVS	R1, #11
STRB	R1, [R2, #0]
;driverrf4463pro.c,378 :: 		spi_write( 7, ucAppCommandBuf );
MOV	R1, R3
MOVS	R0, #7
BL	_spi_write+0
;driverrf4463pro.c,379 :: 		}
L_end_vRF4463GPIO_SET:
ADD	SP, SP, #8
POP	(R15)
; end of _vRF4463GPIO_SET
_vRF4463FifoReset:
;driverrf4463pro.c,384 :: 		void vRF4463FifoReset( void ) {
PUSH	(R14)
SUB	SP, SP, #4
;driverrf4463pro.c,387 :: 		p[ 0 ] = FIFO_INFO;
MOV	R2, SP
MOVS	R0, #21
STRB	R0, [R2, #0]
;driverrf4463pro.c,388 :: 		p[ 1 ] = 0x03;   // reset tx ,rx fifo
ADDS	R1, R2, #1
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,389 :: 		spi_write( 2, p );
MOV	R1, R2
MOVS	R0, #2
BL	_spi_write+0
;driverrf4463pro.c,390 :: 		}
L_end_vRF4463FifoReset:
ADD	SP, SP, #4
POP	(R15)
; end of _vRF4463FifoReset
_vRF4463ClearInterrupts:
;driverrf4463pro.c,392 :: 		void vRF4463ClearInterrupts( void ) {
PUSH	(R14)
SUB	SP, SP, #4
;driverrf4463pro.c,395 :: 		p[ 0 ] = GET_INT_STATUS;
MOV	R2, SP
MOVS	R0, #32
STRB	R0, [R2, #0]
;driverrf4463pro.c,396 :: 		p[ 1 ] = 0;               // clr  PH pending
ADDS	R1, R2, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,397 :: 		p[ 2 ] = 0;               // clr modem_pending
ADDS	R1, R2, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,398 :: 		p[ 3 ] = 0;               // clr chip pending
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,399 :: 		spi_write( 4, p );
MOV	R1, R2
MOVS	R0, #4
BL	_spi_write+0
;driverrf4463pro.c,400 :: 		spi_read( 9, GET_INT_STATUS );
MOVS	R1, #32
MOVS	R0, #9
BL	_spi_read+0
;driverrf4463pro.c,401 :: 		}
L_end_vRF4463ClearInterrupts:
ADD	SP, SP, #4
POP	(R15)
; end of _vRF4463ClearInterrupts
_vRF4463PartInfo:
;driverrf4463pro.c,403 :: 		void vRF4463PartInfo( void ) {  // Solicitud totalmente operativa
PUSH	(R14)
SUB	SP, SP, #12
;driverrf4463pro.c,406 :: 		p[ 0 ] = PART_INFO;
MOV	R1, SP
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,410 :: 		spi_write( 1, p );
MOVS	R0, #1
BL	_spi_write+0
;driverrf4463pro.c,411 :: 		spi_read( 9, PART_INFO );
MOVS	R1, #1
MOVS	R0, #9
BL	_spi_read+0
;driverrf4463pro.c,412 :: 		}
L_end_vRF4463PartInfo:
ADD	SP, SP, #12
POP	(R15)
; end of _vRF4463PartInfo
_vRF4463EnableRxInterrupt:
;driverrf4463pro.c,414 :: 		void vRF4463EnableRxInterrupt( void ) {
PUSH	(R14)
SUB	SP, SP, #8
;driverrf4463pro.c,417 :: 		p[ 0 ] = 0x11;
MOV	R2, SP
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,418 :: 		p[ 1 ] = 0x01;            // 0x0100
ADDS	R1, R2, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,419 :: 		p[ 2 ] = 0x03;            // 3Parameters
ADDS	R1, R2, #2
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,420 :: 		p[ 3 ] = 0x00;            // 0100
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,421 :: 		p[ 4 ] = 0x03;            // ph, modem int       0x03;
ADDS	R1, R2, #4
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,422 :: 		p[ 5 ] = 0x18;            // 0x10;   // Pack received int
ADDS	R1, R2, #5
MOVS	R0, #24
STRB	R0, [R1, #0]
;driverrf4463pro.c,423 :: 		p[ 6 ] = 0x00;            //preamble int, sync int setting
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,424 :: 		spi_write( 0x07, p );     // enable  packet receive interrupt
MOV	R1, R2
MOVS	R0, #7
BL	_spi_write+0
;driverrf4463pro.c,425 :: 		}
L_end_vRF4463EnableRxInterrupt:
ADD	SP, SP, #8
POP	(R15)
; end of _vRF4463EnableRxInterrupt
_vRF4463EnableTxInterrupt:
;driverrf4463pro.c,427 :: 		void vRF4463EnableTxInterrupt( void ) {
PUSH	(R14)
SUB	SP, SP, #8
;driverrf4463pro.c,430 :: 		p[ 0 ] = 0x11;
MOV	R2, SP
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,431 :: 		p[ 1 ] = 0x01;            // 0x0100
ADDS	R1, R2, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,432 :: 		p[ 2 ] = 0x02;            // 2Parameters
ADDS	R1, R2, #2
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,433 :: 		p[ 3 ] = 0x00;            // 0x0100
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,434 :: 		p[ 4 ] = 0x01;            // Ph  int
ADDS	R1, R2, #4
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,435 :: 		p[ 5 ] = 0x20;            //  enable  packet sent interrupt
ADDS	R1, R2, #5
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,436 :: 		spi_write( 0x06, p );     // enable  packet receive interrupt
MOV	R1, R2
MOVS	R0, #6
BL	_spi_write+0
;driverrf4463pro.c,437 :: 		}
L_end_vRF4463EnableTxInterrupt:
ADD	SP, SP, #8
POP	(R15)
; end of _vRF4463EnableTxInterrupt
_vRF4463RfStandby:
;driverrf4463pro.c,442 :: 		void vRF4463RfStandby( void ) {
PUSH	(R14)
SUB	SP, SP, #4
;driverrf4463pro.c,445 :: 		p[ 0 ] = CHANGE_STATE ;   // CHANGE_STATE Command
MOV	R2, SP
MOVS	R0, #52
STRB	R0, [R2, #0]
;driverrf4463pro.c,446 :: 		p[ 1 ] = 0x01 ;           // sleep mode
ADDS	R1, R2, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,447 :: 		spi_write( 2, p );
MOV	R1, R2
MOVS	R0, #2
BL	_spi_write+0
;driverrf4463pro.c,448 :: 		}
L_end_vRF4463RfStandby:
ADD	SP, SP, #4
POP	(R15)
; end of _vRF4463RfStandby
_vRF4463TxStart:
;driverrf4463pro.c,453 :: 		void vRF4463TxStart( void ) {
PUSH	(R14)
SUB	SP, SP, #8
;driverrf4463pro.c,456 :: 		p[ 0 ] = START_TX ;              // start Command
MOV	R2, SP
MOVS	R0, #49
STRB	R0, [R2, #0]
;driverrf4463pro.c,457 :: 		p[ 1 ] = ucRF4463FreqChannel;    // channel 1 default
ADDS	R1, R2, #1
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,458 :: 		p[ 2 ] = 0x30;                   // Back after launch Readymode, Do not retransmit, launch immediately
ADDS	R1, R2, #2
MOVS	R0, #48
STRB	R0, [R1, #0]
;driverrf4463pro.c,459 :: 		p[ 3 ] = 0;
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,460 :: 		p[ 4 ] = 0;                      // payload_length; // Total to transmit 10 bytes
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,461 :: 		spi_write( 5, p );
MOV	R1, R2
MOVS	R0, #5
BL	_spi_write+0
;driverrf4463pro.c,462 :: 		}
L_end_vRF4463TxStart:
ADD	SP, SP, #8
POP	(R15)
; end of _vRF4463TxStart
_vRF4463RxStart:
;driverrf4463pro.c,467 :: 		void vRF4463RxStart( void ) {
PUSH	(R14)
SUB	SP, SP, #8
;driverrf4463pro.c,470 :: 		p[ 0 ] = START_RX ;              // start Command
MOV	R2, SP
MOVS	R0, #50
STRB	R0, [R2, #0]
;driverrf4463pro.c,471 :: 		p[ 1 ] = ucRF4463FreqChannel;    // channel 0
ADDS	R1, R2, #1
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,472 :: 		p[ 2 ] = 0x00;                   // Enter receiving mode immediately
ADDS	R1, R2, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,473 :: 		p[ 3 ] = 0;
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,474 :: 		p[ 4 ] = 0;                      // payload_length; // Total to receive 10 bytes
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,475 :: 		p[ 5 ] = 0;                      // unchanged after preamble timeout
ADDS	R1, R2, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,478 :: 		p[ 6 ] = 0x08;
ADDS	R1, R2, #6
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,479 :: 		p[ 7 ] = 0x08;
ADDS	R1, R2, #7
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,480 :: 		spi_write( 8, p );
MOV	R1, R2
MOVS	R0, #8
BL	_spi_write+0
;driverrf4463pro.c,481 :: 		}
L_end_vRF4463RxStart:
ADD	SP, SP, #8
POP	(R15)
; end of _vRF4463RxStart
_vRF4463RxStartTest:
;driverrf4463pro.c,486 :: 		void vRF4463RxStartTest( void ) {
PUSH	(R14)
SUB	SP, SP, #8
;driverrf4463pro.c,491 :: 		p[ 0 ] = START_RX;        // start Command
MOV	R2, SP
MOVS	R0, #50
STRB	R0, [R2, #0]
;driverrf4463pro.c,492 :: 		p[ 1 ] = ucRF4463FreqChannel;    // channel 0
ADDS	R1, R2, #1
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,493 :: 		p[ 2 ] = 0x00;            // Enter receiving mode immediately
ADDS	R1, R2, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,494 :: 		p[ 3 ] = 0;
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,496 :: 		p[ 4 ] = 0;
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,497 :: 		p[ 5 ] = 0;               // unchanged after preamble timeout
ADDS	R1, R2, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,500 :: 		p[ 6 ] = 0x08;
ADDS	R1, R2, #6
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,501 :: 		p[ 7 ] = 0x08;
ADDS	R1, R2, #7
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,502 :: 		spi_write( 8, p );
MOV	R1, R2
MOVS	R0, #8
BL	_spi_write+0
;driverrf4463pro.c,503 :: 		}
L_end_vRF4463RxStartTest:
ADD	SP, SP, #8
POP	(R15)
; end of _vRF4463RxStartTest
_vRF4463RxInit:
;driverrf4463pro.c,505 :: 		void vRF4463RxInit( void ) {
PUSH	(R14)
;driverrf4463pro.c,506 :: 		Flag.is_tx = 0;
MOVW	R2, #lo_addr(_Flag+0)
MOVT	R2, #hi_addr(_Flag+0)
_LX	[R2, ByteOffset(_Flag+0)]
MOVS	R1, #2
BICS	R0, R1
_SX	[R2, ByteOffset(_Flag+0)]
;driverrf4463pro.c,507 :: 		vRF4463FifoReset();           // fifo_reset();  // Buffer empty
BL	_vRF4463FifoReset+0
;driverrf4463pro.c,508 :: 		vRF4463EnableRxInterrupt();   // enable_rx_interrupt();
BL	_vRF4463EnableRxInterrupt+0
;driverrf4463pro.c,509 :: 		vRF4463ClearInterrupts();      // clr_interrupt();  // Clear interrupt factor
BL	_vRF4463ClearInterrupts+0
;driverrf4463pro.c,511 :: 		if ( ucRF4463Mode == rx_test_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BLNE	L_vRF4463RxInit125
;driverrf4463pro.c,512 :: 		vRF4463RxStartTest();      // rx_start_test();
BL	_vRF4463RxStartTest+0
;driverrf4463pro.c,513 :: 		}
IT	AL
BLAL	L_vRF4463RxInit126
L_vRF4463RxInit125:
;driverrf4463pro.c,515 :: 		vRF4463RxStart();        // rx_start();    // Enter receiving mode, after receiving data, return to Readymode
BL	_vRF4463RxStart+0
;driverrf4463pro.c,516 :: 		}
L_vRF4463RxInit126:
;driverrf4463pro.c,517 :: 		}
L_end_vRF4463RxInit:
POP	(R15)
; end of _vRF4463RxInit
_vRF4463TxData:
;driverrf4463pro.c,519 :: 		void vRF4463TxData( void ) {
PUSH	(R14)
SUB	SP, SP, #52
;driverrf4463pro.c,521 :: 		ucRF4463IRQ = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
STRB	R1, [R0, #0]
;driverrf4463pro.c,522 :: 		Flag.is_tx = 1;
MOVW	R2, #lo_addr(_Flag+0)
MOVT	R2, #hi_addr(_Flag+0)
_LX	[R2, ByteOffset(_Flag+0)]
MOVS	R1, #2
ORRS	R0, R1
_SX	[R2, ByteOffset(_Flag+0)]
;driverrf4463pro.c,523 :: 		LED_BLUE^= 1;
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_LX	[R0, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #1
LSLS	R1, R1, #8
ANDS	R1, R0
LSRS	R1, R1, #8
MOVS	R0, #1
EORS	R0, R1
UXTB	R3, R0
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_LX	[R2, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #1
ANDS	R1, R3
BEQ	L__vRF4463TxData466
MOVS	R1, #1
LSLS	R1, R1, #8
ORRS	R0, R1
B	L__vRF4463TxData465
L__vRF4463TxData466:
MOVS	R1, #1
LSLS	R1, R1, #8
BICS	R0, R1
L__vRF4463TxData465:
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,524 :: 		Delay_ms( 30 );
LDR	R7, [PC, #119999]
NOP
L_vRF4463TxData127:
SUBS	R7, R7, #1
BNE	L_vRF4463TxData127
B	#4
	#119999
NOP
;driverrf4463pro.c,525 :: 		LED_BLUE ^= 1;
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_LX	[R0, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #1
LSLS	R1, R1, #8
ANDS	R1, R0
LSRS	R1, R1, #8
MOVS	R0, #1
EORS	R0, R1
UXTB	R3, R0
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_LX	[R2, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #1
ANDS	R1, R3
BEQ	L__vRF4463TxData468
MOVS	R1, #1
LSLS	R1, R1, #8
ORRS	R0, R1
B	L__vRF4463TxData467
L__vRF4463TxData468:
MOVS	R1, #1
LSLS	R1, R1, #8
BICS	R0, R1
L__vRF4463TxData467:
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,526 :: 		UART1_Write_Text( "[ SYS STM32G ]Transmiting...\r\n" );
MOV	R6, SP
MOVS	R5, #31
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr1_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr1_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOV	R0, SP
BL	_UART1_Write_Text+0
;driverrf4463pro.c,527 :: 		vRF4463FifoReset();            // fifo_reset();  // Buffer empty
BL	_vRF4463FifoReset+0
;driverrf4463pro.c,528 :: 		spi_write_fifo();              // Fill the buffer with data
BL	_spi_write_fifo+0
;driverrf4463pro.c,529 :: 		vRF4463EnableTxInterrupt();    // enable_tx_interrupt();
BL	_vRF4463EnableTxInterrupt+0
;driverrf4463pro.c,530 :: 		vRF4463ClearInterrupts();       // clr_interrupt();  // Clear interrupt factor
BL	_vRF4463ClearInterrupts+0
;driverrf4463pro.c,531 :: 		vRF4463TxStart();              // tx_start();    // Enter launch mode, start launch
BL	_vRF4463TxStart+0
;driverrf4463pro.c,532 :: 		rf_timeout = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_rf_timeout+0)
MOVT	R0, #hi_addr(_rf_timeout+0)
STRH	R1, [R0, #0]
;driverrf4463pro.c,534 :: 		Flag.rf_reach_timeout = 0;
MOVW	R2, #lo_addr(_Flag+0)
MOVT	R2, #hi_addr(_Flag+0)
_LX	[R2, ByteOffset(_Flag+0)]
MOVS	R1, #4
BICS	R0, R1
_SX	[R2, ByteOffset(_Flag+0)]
;driverrf4463pro.c,536 :: 		if ( ucRF4463IRQ ) {
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L_vRF4463TxData129
;driverrf4463pro.c,537 :: 		UART1_Write_Text( "[ UART1 ] TX INT\r\n" );
MOVS	R6, #32
ADD	R6, SP, R6
MOVS	R5, #19
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr2_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr2_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #32
ADD	R0, SP, R0
BL	_UART1_Write_Text+0
;driverrf4463pro.c,538 :: 		}
L_vRF4463TxData129:
;driverrf4463pro.c,541 :: 		while ( nIRQ ) {     //nIRQ
L_vRF4463TxData130:
MOVW	R0, #lo_addr(GPIOA_IDRbits+0)
MOVT	R0, #hi_addr(GPIOA_IDRbits+0)
_LX	[R0, ByteOffset(GPIOA_IDRbits+0)]
MOVS	R0, #4
ANDS	R0, R1
LSRS	R0, R0, #2
CMP	R0, #0
IT	EQ
BLEQ	L_vRF4463TxData131
;driverrf4463pro.c,544 :: 		if ( Flag.rf_reach_timeout ) {
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
_LX	[R0, ByteOffset(_Flag+0)]
MOVS	R0, #4
ANDS	R0, R1
LSRS	R0, R0, #2
CMP	R0, #0
IT	EQ
BLEQ	L_vRF4463TxData132
;driverrf4463pro.c,545 :: 		VRF4463SDNReset();
BL	_VRF4463SDNReset+0
;driverrf4463pro.c,546 :: 		vRF4463Init();        //SI4463_init();  // RF Module initialization
BL	_vRF4463Init+0
;driverrf4463pro.c,547 :: 		break;                // Forced out
IT	AL
BLAL	L_vRF4463TxData131
;driverrf4463pro.c,548 :: 		}
L_vRF4463TxData132:
;driverrf4463pro.c,549 :: 		}
IT	AL
BLAL	L_vRF4463TxData130
L_vRF4463TxData131:
;driverrf4463pro.c,551 :: 		tx_cnt++;
MOVW	R1, #lo_addr(_tx_cnt+0)
MOVT	R1, #hi_addr(_tx_cnt+0)
LDR	R0, [R1, #0]
ADDS	R0, #1
STR	R0, [R1, #0]
;driverrf4463pro.c,553 :: 		vRF4463RxInit();          // rx_init();                //rf After the transmission is completed, enter the receiving mode
BL	_vRF4463RxInit+0
;driverrf4463pro.c,554 :: 		}
L_end_vRF4463TxData:
ADD	SP, SP, #52
POP	(R15)
; end of _vRF4463TxData
_vRF4463TxCont:
;driverrf4463pro.c,559 :: 		void vRF4463TxCont( void ) {
PUSH	(R14)
;driverrf4463pro.c,563 :: 		vRF4463FifoReset();                     //  fifo_reset();  // Buffer empty
BL	_vRF4463FifoReset+0
;driverrf4463pro.c,564 :: 		spi_write_fifo();                       // Fill the buffer with data
BL	_spi_write_fifo+0
;driverrf4463pro.c,565 :: 		vRF4463EnableTxInterrupt();             //  enable_tx_interrupt();
BL	_vRF4463EnableTxInterrupt+0
;driverrf4463pro.c,566 :: 		vRF4463ClearInterrupts();               //  clr_interrupt();  // Clear interrupt factor
BL	_vRF4463ClearInterrupts+0
;driverrf4463pro.c,567 :: 		vRF4463TxStart();                       //  tx_start();    // Enter launch mode, start launch
BL	_vRF4463TxStart+0
;driverrf4463pro.c,568 :: 		rf_timeout = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_rf_timeout+0)
MOVT	R0, #hi_addr(_rf_timeout+0)
STRH	R1, [R0, #0]
;driverrf4463pro.c,569 :: 		Flag.rf_reach_timeout = 0;
MOVW	R2, #lo_addr(_Flag+0)
MOVT	R2, #hi_addr(_Flag+0)
_LX	[R2, ByteOffset(_Flag+0)]
MOVS	R1, #4
BICS	R0, R1
_SX	[R2, ByteOffset(_Flag+0)]
;driverrf4463pro.c,571 :: 		ucRF4463IRQ = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
STRB	R1, [R0, #0]
;driverrf4463pro.c,574 :: 		while( nIRQ ) {          //nIRQ ) {
L_vRF4463TxCont133:
MOVW	R0, #lo_addr(GPIOA_IDRbits+0)
MOVT	R0, #hi_addr(GPIOA_IDRbits+0)
_LX	[R0, ByteOffset(GPIOA_IDRbits+0)]
MOVS	R0, #4
ANDS	R0, R1
LSRS	R0, R0, #2
CMP	R0, #0
IT	EQ
BLEQ	L_vRF4463TxCont134
;driverrf4463pro.c,582 :: 		}
IT	AL
BLAL	L_vRF4463TxCont133
L_vRF4463TxCont134:
;driverrf4463pro.c,583 :: 		}
L_end_vRF4463TxCont:
POP	(R15)
; end of _vRF4463TxCont
_rf_init_freq:
;driverrf4463pro.c,588 :: 		void rf_init_freq ( void ) {
PUSH	(R14)
SUB	SP, SP, #36
;driverrf4463pro.c,594 :: 		ulFrequency = ( ucRF4463Freq3 * 100 ) + ( ucRF4463Freq2 * 10 ) + ucRF4463Freq1;
MOVW	R0, #lo_addr(_ucRF4463Freq3+0)
MOVT	R0, #hi_addr(_ucRF4463Freq3+0)
LDRB	R1, [R0, #0]
MOVS	R0, #100
MOV	R3, R0
MULS	R3, R1, R3
SXTH	R3, R3
MOVW	R0, #lo_addr(_ucRF4463Freq2+0)
MOVT	R0, #hi_addr(_ucRF4463Freq2+0)
LDRB	R2, [R0, #0]
MOVS	R1, #10
MOV	R0, R1
MULS	R0, R2, R0
SXTH	R0, R0
ADDS	R2, R3, R0
MOVW	R0, #lo_addr(_ucRF4463Freq1+0)
MOVT	R0, #hi_addr(_ucRF4463Freq1+0)
LDRB	R0, [R0, #0]
ADDS	R2, R2, R0
; ulFrequency start address is: 8 (R2)
SXTH	R2, R2
;driverrf4463pro.c,596 :: 		ulFrequency = ( ulFrequency * 10000 );
MOVW	R0, #10000
MOVT	R0, #0
MOV	R1, R0
MULS	R1, R2, R1
MOV	R2, R1
;driverrf4463pro.c,599 :: 		if ( ulFrequency >= 7600000 ) {
MOVW	R0, #63360
MOVT	R0, #115
CMP	R1, R0
IT	CC
BLCC	L_rf_init_freq135
;driverrf4463pro.c,600 :: 		ucOUTDIV = 4;
; ucOUTDIV start address is: 4 (R1)
MOVS	R1, #4
;driverrf4463pro.c,601 :: 		ucBAND = 0;
; ucBAND start address is: 28 (R7)
MOVS	R7, #0
;driverrf4463pro.c,602 :: 		ucVCO = 0xFF;
; ucVCO start address is: 24 (R6)
MOVS	R6, #255
;driverrf4463pro.c,603 :: 		}
; ucVCO end address is: 24 (R6)
; ucBAND end address is: 28 (R7)
; ucOUTDIV end address is: 4 (R1)
IT	AL
BLAL	L_rf_init_freq136
L_rf_init_freq135:
;driverrf4463pro.c,606 :: 		else if ( ulFrequency >= 5460000 ) {
MOVW	R0, #20512
MOVT	R0, #83
CMP	R2, R0
IT	CC
BLCC	L_rf_init_freq137
;driverrf4463pro.c,607 :: 		ucOUTDIV = 6;
; ucOUTDIV start address is: 4 (R1)
MOVS	R1, #6
;driverrf4463pro.c,608 :: 		ucBAND   = 1;
; ucBAND start address is: 28 (R7)
MOVS	R7, #1
;driverrf4463pro.c,609 :: 		ucVCO    = 0xFE;
; ucVCO start address is: 24 (R6)
MOVS	R6, #254
;driverrf4463pro.c,610 :: 		}
; ucVCO end address is: 24 (R6)
; ucBAND end address is: 28 (R7)
; ucOUTDIV end address is: 4 (R1)
IT	AL
BLAL	L_rf_init_freq138
L_rf_init_freq137:
;driverrf4463pro.c,613 :: 		else if ( ulFrequency >= 3850000 ) {
MOVW	R0, #48912
MOVT	R0, #58
CMP	R2, R0
IT	CC
BLCC	L_rf_init_freq139
;driverrf4463pro.c,614 :: 		ucOUTDIV = 8;
; ucOUTDIV start address is: 0 (R0)
MOVS	R0, #8
;driverrf4463pro.c,615 :: 		ucBAND   = 2;
; ucBAND start address is: 12 (R3)
MOVS	R3, #2
;driverrf4463pro.c,616 :: 		ucVCO    = 0xFE;
; ucVCO start address is: 24 (R6)
MOVS	R6, #254
;driverrf4463pro.c,617 :: 		}
UXTB	R1, R0
; ucOUTDIV end address is: 0 (R0)
; ucBAND end address is: 12 (R3)
; ucVCO end address is: 24 (R6)
UXTB	R7, R3
IT	AL
BLAL	L_rf_init_freq140
L_rf_init_freq139:
;driverrf4463pro.c,620 :: 		else if ( ulFrequency >= 2730000 ) {
MOVW	R0, #43024
MOVT	R0, #41
CMP	R2, R0
IT	CC
BLCC	L_rf_init_freq141
;driverrf4463pro.c,621 :: 		ucOUTDIV = 12;
; ucOUTDIV start address is: 4 (R1)
MOVS	R1, #12
;driverrf4463pro.c,622 :: 		ucBAND   = 3;
; ucBAND start address is: 12 (R3)
MOVS	R3, #3
;driverrf4463pro.c,623 :: 		ucVCO    = 0xFD;
; ucVCO start address is: 0 (R0)
MOVS	R0, #253
;driverrf4463pro.c,624 :: 		}
UXTB	R6, R0
; ucVCO end address is: 0 (R0)
; ucBAND end address is: 12 (R3)
; ucOUTDIV end address is: 4 (R1)
IT	AL
BLAL	L_rf_init_freq142
L_rf_init_freq141:
;driverrf4463pro.c,627 :: 		else if ( ulFrequency >= 1940000 ) {
MOVW	R0, #39456
MOVT	R0, #29
CMP	R2, R0
IT	CC
BLCC	L_rf_init_freq143
;driverrf4463pro.c,628 :: 		ucOUTDIV = 16;
; ucOUTDIV start address is: 4 (R1)
MOVS	R1, #16
;driverrf4463pro.c,629 :: 		ucBAND   = 4;
; ucBAND start address is: 12 (R3)
MOVS	R3, #4
;driverrf4463pro.c,630 :: 		ucVCO    = 0xFC;
; ucVCO start address is: 0 (R0)
MOVS	R0, #252
;driverrf4463pro.c,631 :: 		}
; ucVCO end address is: 0 (R0)
; ucBAND end address is: 12 (R3)
; ucOUTDIV end address is: 4 (R1)
IT	AL
BLAL	L_rf_init_freq144
L_rf_init_freq143:
;driverrf4463pro.c,635 :: 		ucOUTDIV = 24;
; ucOUTDIV start address is: 4 (R1)
MOVS	R1, #24
;driverrf4463pro.c,636 :: 		ucBAND   = 5;
; ucBAND start address is: 12 (R3)
MOVS	R3, #5
;driverrf4463pro.c,637 :: 		ucVCO    = 0xFA;
; ucVCO start address is: 0 (R0)
MOVS	R0, #250
; ucVCO end address is: 0 (R0)
; ucBAND end address is: 12 (R3)
; ucOUTDIV end address is: 4 (R1)
;driverrf4463pro.c,638 :: 		}
L_rf_init_freq144:
; ucVCO start address is: 0 (R0)
; ucBAND start address is: 12 (R3)
; ucOUTDIV start address is: 4 (R1)
UXTB	R6, R0
; ucVCO end address is: 0 (R0)
; ucBAND end address is: 12 (R3)
; ucOUTDIV end address is: 4 (R1)
L_rf_init_freq142:
; ucOUTDIV start address is: 4 (R1)
; ucBAND start address is: 12 (R3)
; ucVCO start address is: 24 (R6)
; ucBAND end address is: 12 (R3)
; ucVCO end address is: 24 (R6)
; ucOUTDIV end address is: 4 (R1)
UXTB	R7, R3
L_rf_init_freq140:
; ucVCO start address is: 24 (R6)
; ucBAND start address is: 28 (R7)
; ucOUTDIV start address is: 4 (R1)
; ucVCO end address is: 24 (R6)
; ucBAND end address is: 28 (R7)
; ucOUTDIV end address is: 4 (R1)
L_rf_init_freq138:
; ucOUTDIV start address is: 4 (R1)
; ucBAND start address is: 28 (R7)
; ucVCO start address is: 24 (R6)
; ucVCO end address is: 24 (R6)
; ucBAND end address is: 28 (R7)
; ucOUTDIV end address is: 4 (R1)
L_rf_init_freq136:
;driverrf4463pro.c,640 :: 		ucDIV = ucOUTDIV / 2;
; ucVCO start address is: 24 (R6)
; ucBAND start address is: 28 (R7)
; ucOUTDIV start address is: 4 (R1)
LSRS	R0, R1, #1
UXTB	R0, R0
; ucOUTDIV end address is: 4 (R1)
;driverrf4463pro.c,642 :: 		ulData = ( ulFrequency * ucDIV ) / 3;          // ucDIV = 88.5 = 88   //// UCdiv = 2
MOV	R1, R0
MULS	R1, R2, R1
; ulFrequency end address is: 8 (R2)
MOVS	R2, #3
MOV	R0, R1
BL	__Div_32x32_U+0
; ulData start address is: 16 (R4)
MOV	R4, R0
;driverrf4463pro.c,643 :: 		ucINTE = ( ulData / 100000) - 1;               // ulData = 6 000 000  //// ULdATA = 9 000 000
MOVW	R2, #34464
MOVT	R2, #1
STR	R4, [SP, #0]
BL	__Div_32x32_U+0
LDR	R4, [SP, #0]
SUBS	R0, R0, #1
; ucINTE start address is: 12 (R3)
UXTB	R3, R0
;driverrf4463pro.c,644 :: 		ulFRAC = ( ulData - ( ucINTE + 1 ) * 100000 ) * 16384 / 3125;         // ulFRAC = 15 728 640
UXTB	R0, R0
ADDS	R2, R0, #1
SXTH	R2, R2
MOVW	R1, #34464
MOVT	R1, #1
MOV	R0, R1
MULS	R0, R2, R0
SUBS	R0, R4, R0
; ulData end address is: 16 (R4)
LSLS	R1, R0, #14
MOVW	R2, #3125
MOVT	R2, #0
STR	R3, [SP, #0]
MOV	R0, R1
BL	__Div_32x32_U+0
LDR	R3, [SP, #0]
UXTB	R3, R3
;driverrf4463pro.c,645 :: 		ulFRAC = ulFRAC + 0x80000;
MOVW	R1, #0
MOVT	R1, #8
ADDS	R0, R0, R1
;driverrf4463pro.c,647 :: 		ucFRAC_0 = ulFRAC;
; ucFRAC_0 start address is: 16 (R4)
UXTB	R4, R0
;driverrf4463pro.c,648 :: 		ulFRAC >>= 8;
LSRS	R0, R0, #8
;driverrf4463pro.c,649 :: 		ucFRAC_1 = ulFRAC;
; ucFRAC_1 start address is: 20 (R5)
UXTB	R5, R0
;driverrf4463pro.c,650 :: 		ulFRAC >>= 8;
LSRS	R0, R0, #8
;driverrf4463pro.c,651 :: 		ucFRAC_2 = ulFRAC;
STR	R0, [SP, #12]
;driverrf4463pro.c,655 :: 		app_command_buf[ 0 ] = 0x11;           // SET property    MODEM_CLKGEN_BAND
MOVS	R2, #16
ADD	R2, SP, R2
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,656 :: 		app_command_buf[ 1 ] = 0x20;           // Group  // 0x2051
ADDS	R1, R2, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,657 :: 		app_command_buf[ 2 ] = 0x01;           // Num Arguments // Total 1 Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,658 :: 		app_command_buf[ 3 ] = 0x51;           // Number  // 0x2051
ADDS	R1, R2, #3
MOVS	R0, #81
STRB	R0, [R1, #0]
;driverrf4463pro.c,659 :: 		app_command_buf[ 4 ] = 0x08 | ucBAND;  // Argumento  //  high performance mode , clk outpu = osc /4
ADDS	R1, R2, #4
MOVS	R0, #8
ORRS	R0, R7
; ucBAND end address is: 28 (R7)
STRB	R0, [R1, #0]
;driverrf4463pro.c,660 :: 		spi_write( 5, app_command_buf );
STR	R5, [SP, #0]
STR	R4, [SP, #4]
STR	R3, [SP, #8]
MOV	R1, R2
MOVS	R0, #5
BL	_spi_write+0
LDR	R3, [SP, #8]
UXTB	R3, R3
LDR	R4, [SP, #4]
UXTB	R4, R4
LDR	R5, [SP, #0]
UXTB	R5, R5
;driverrf4463pro.c,662 :: 		app_command_buf[ 0 ]  = 0x11;
MOVS	R2, #16
ADD	R2, SP, R2
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,663 :: 		app_command_buf[ 1 ]  = 0x40;    // 0x4000         FREQ_CONTROL_INTE
ADDS	R1, R2, #1
MOVS	R0, #64
STRB	R0, [R1, #0]
;driverrf4463pro.c,664 :: 		app_command_buf[ 2 ]  = 0x08;    // Total 8 Parameters
ADDS	R1, R2, #2
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,665 :: 		app_command_buf[ 3 ]  = 0x00;   // 0x4000
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,666 :: 		app_command_buf[ 4 ]  = ucINTE;   //  default value
ADDS	R0, R2, #4
STRB	R3, [R0, #0]
; ucINTE end address is: 12 (R3)
;driverrf4463pro.c,667 :: 		app_command_buf[ 5 ]  = ucFRAC_2;   //  defaul value
ADDS	R1, R2, #5
LDR	R0, [SP, #12]
UXTB	R0, R0
STRB	R0, [R1, #0]
;driverrf4463pro.c,668 :: 		app_command_buf[ 6 ]  = ucFRAC_1;   //  default value
ADDS	R0, R2, #6
STRB	R5, [R0, #0]
; ucFRAC_1 end address is: 20 (R5)
;driverrf4463pro.c,669 :: 		app_command_buf[ 7 ]  = ucFRAC_0;   // frac ,from WDS
ADDS	R0, R2, #7
STRB	R4, [R0, #0]
; ucFRAC_0 end address is: 16 (R4)
;driverrf4463pro.c,672 :: 		if ( ulRF4463Step == 250 ) {
MOVW	R0, #lo_addr(_ulRF4463Step+0)
MOVT	R0, #hi_addr(_ulRF4463Step+0)
LDR	R0, [R0, #0]
CMP	R0, #250
IT	NE
BLNE	L_rf_init_freq145
;driverrf4463pro.c,673 :: 		app_command_buf[ 8 ]  = step_250K_step1;   // channel step1  from wds  // al parecer aqu? esta el ancho del canal
MOVS	R2, #16
ADD	R2, SP, R2
MOV	R1, R2
ADDS	R1, #8
MOVS	R0, #34
STRB	R0, [R1, #0]
;driverrf4463pro.c,674 :: 		app_command_buf[ 9 ]  = step_250K_step0;   // channel step0  from wds
MOV	R1, R2
ADDS	R1, #9
MOVS	R0, #34
STRB	R0, [R1, #0]
;driverrf4463pro.c,675 :: 		}
IT	AL
BLAL	L_rf_init_freq146
L_rf_init_freq145:
;driverrf4463pro.c,676 :: 		else if ( ulRF4463Step == 500 ) {
MOVW	R0, #lo_addr(_ulRF4463Step+0)
MOVT	R0, #hi_addr(_ulRF4463Step+0)
LDR	R1, [R0, #0]
MOVS	R0, #255
ADDS	R0, #245
CMP	R1, R0
IT	NE
BLNE	L_rf_init_freq147
;driverrf4463pro.c,677 :: 		app_command_buf[ 8 ]  = step_500K_step1;   // channel step1  from wds  // al parecer aqu? esta el ancho del canal
MOVS	R2, #16
ADD	R2, SP, R2
MOV	R1, R2
ADDS	R1, #8
MOVS	R0, #68
STRB	R0, [R1, #0]
;driverrf4463pro.c,678 :: 		app_command_buf[ 9 ]  = step_500K_step0;   // channel step0  from wds
MOV	R1, R2
ADDS	R1, #9
MOVS	R0, #68
STRB	R0, [R1, #0]
;driverrf4463pro.c,679 :: 		}
L_rf_init_freq147:
L_rf_init_freq146:
;driverrf4463pro.c,681 :: 		app_command_buf[ 10 ] = 0x20;  //  from wds Without this Values
MOVS	R2, #16
ADD	R2, SP, R2
MOV	R1, R2
ADDS	R1, #10
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,682 :: 		app_command_buf[ 11 ] = ucVCO;    // from wds Without this Values
MOV	R0, R2
ADDS	R0, #11
STRB	R6, [R0, #0]
; ucVCO end address is: 24 (R6)
;driverrf4463pro.c,684 :: 		spi_write( 12, app_command_buf );
MOV	R1, R2
MOVS	R0, #12
BL	_spi_write+0
;driverrf4463pro.c,685 :: 		}
L_end_rf_init_freq:
ADD	SP, SP, #36
POP	(R15)
; end of _rf_init_freq
_ucRf4463SPIByte:
;driverrf4463pro.c,705 :: 		unsigned char ucRf4463SPIByte( unsigned char ucData ) {
PUSH	(R14)
SUB	SP, SP, #4
STR	R0, [SP, #0]
;driverrf4463pro.c,707 :: 		ucSPI1ByteReceived = 0;
MOVS	R2, #0
MOVW	R1, #lo_addr(_ucSPI1ByteReceived+0)
MOVT	R1, #hi_addr(_ucSPI1ByteReceived+0)
STRB	R2, [R1, #0]
;driverrf4463pro.c,709 :: 		vRF4463SpiBufferTX ( &ucData, 1 );        // lo envia por DMA
MOV	R1, SP
MOV	R0, R1
MOVS	R1, #1
BL	_vRF4463SpiBufferTX+0
;driverrf4463pro.c,711 :: 		while ( SPI1_SRbits.RXNE );
L_ucRf4463SPIByte148:
MOVW	R1, #lo_addr(SPI1_SRbits+0)
MOVT	R1, #hi_addr(SPI1_SRbits+0)
_LX	[R1, ByteOffset(SPI1_SRbits+0)]
MOVS	R1, #1
ANDS	R1, R2
LSRS	R1, R1, #0
CMP	R1, #0
IT	EQ
BLEQ	L_ucRf4463SPIByte149
IT	AL
BLAL	L_ucRf4463SPIByte148
L_ucRf4463SPIByte149:
;driverrf4463pro.c,713 :: 		return ( ucSPI1ByteReceived );
MOVW	R1, #lo_addr(_ucSPI1ByteReceived+0)
MOVT	R1, #hi_addr(_ucSPI1ByteReceived+0)
LDRB	R0, [R1, #0]
;driverrf4463pro.c,714 :: 		}
L_end_ucRf4463SPIByte:
ADD	SP, SP, #4
POP	(R15)
; end of _ucRf4463SPIByte
_spi_write:
;driverrf4463pro.c,719 :: 		void spi_write( unsigned char tx_length, unsigned char *p ) {
; i start address is: 0 (R0)
PUSH	(R14)
SUB	SP, SP, #8
;driverrf4463pro.c,722 :: 		i = 0;
;driverrf4463pro.c,719 :: 		void spi_write( unsigned char tx_length, unsigned char *p ) {
STR	R0, [SP, #0]
;driverrf4463pro.c,722 :: 		i = 0;
;driverrf4463pro.c,719 :: 		void spi_write( unsigned char tx_length, unsigned char *p ) {
STR	R1, [SP, #4]
; i end address is: 0 (R0)
;driverrf4463pro.c,722 :: 		i = 0;
; i start address is: 0 (R0)
MOVS	R0, #0
; i end address is: 0 (R0)
;driverrf4463pro.c,723 :: 		while ( i != 0xFF ) {
L_spi_write150:
; i start address is: 0 (R0)
CMP	R0, #255
IT	EQ
BLEQ	L_spi_write151
; i end address is: 0 (R0)
;driverrf4463pro.c,724 :: 		i = check_cts();
BL	_check_cts+0
; i start address is: 0 (R0)
;driverrf4463pro.c,725 :: 		}
; i end address is: 0 (R0)
IT	AL
BLAL	L_spi_write150
L_spi_write151:
;driverrf4463pro.c,727 :: 		nSEL = 0;                              // habilita escritura
MOVW	R4, #lo_addr(GPIOA_ODRbits+0)
MOVT	R4, #hi_addr(GPIOA_ODRbits+0)
_LX	[R4, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R3, #8
BICS	R2, R3
_SX	[R4, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,729 :: 		for ( i = 0; i < tx_length; i++ ) {
; i start address is: 28 (R7)
MOVS	R7, #0
; i end address is: 28 (R7)
UXTB	R5, R7
L_spi_write152:
; i start address is: 20 (R5)
LDR	R2, [SP, #0]
UXTB	R2, R2
CMP	R5, R2
IT	CS
BLCS	L_spi_write153
;driverrf4463pro.c,730 :: 		j = *( p + i );
LDR	R2, [SP, #4]
ADDS	R2, R2, R5
;driverrf4463pro.c,731 :: 		ucRf4463SPIByte( j );
LDRB	R0, [R2, #0]
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,729 :: 		for ( i = 0; i < tx_length; i++ ) {
ADDS	R2, R5, #1
; i end address is: 20 (R5)
; i start address is: 28 (R7)
UXTB	R7, R2
;driverrf4463pro.c,732 :: 		}
UXTB	R5, R7
; i end address is: 28 (R7)
IT	AL
BLAL	L_spi_write152
L_spi_write153:
;driverrf4463pro.c,734 :: 		nSEL = 1;                              // desabilita escritura
MOVW	R4, #lo_addr(GPIOA_ODRbits+0)
MOVT	R4, #hi_addr(GPIOA_ODRbits+0)
_LX	[R4, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R3, #8
ORRS	R2, R3
_SX	[R4, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,735 :: 		}
L_end_spi_write:
ADD	SP, SP, #8
POP	(R15)
; end of _spi_write
_check_cts:
;driverrf4463pro.c,740 :: 		unsigned char check_cts( void ) {           // This Command follows the Command and reads the response
PUSH	(R14)
;driverrf4463pro.c,743 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,744 :: 		nSEL = 0;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,745 :: 		ucRf4463SPIByte( 0x44 );
MOVS	R0, #68
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,746 :: 		i = ucRf4463SPIByte( 0 );
MOVS	R0, #0
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,747 :: 		nSEL = 1;
MOVW	R3, #lo_addr(GPIOA_ODRbits+0)
MOVT	R3, #hi_addr(GPIOA_ODRbits+0)
_LX	[R3, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R2, #8
ORRS	R1, R2
_SX	[R3, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,748 :: 		return ( i );
;driverrf4463pro.c,749 :: 		}
L_end_check_cts:
POP	(R15)
; end of _check_cts
_spi_read:
;driverrf4463pro.c,754 :: 		void spi_read( unsigned char data_length, unsigned char api_command ) {
; api_command start address is: 4 (R1)
; data_length start address is: 0 (R0)
PUSH	(R14)
SUB	SP, SP, #8
; api_command end address is: 4 (R1)
; data_length end address is: 0 (R0)
; data_length start address is: 0 (R0)
; api_command start address is: 4 (R1)
;driverrf4463pro.c,758 :: 		p[ 0 ] = api_command;
MOV	R2, SP
STRB	R1, [R2, #0]
; api_command end address is: 4 (R1)
;driverrf4463pro.c,759 :: 		i = 0;
; i start address is: 4 (R1)
MOVS	R1, #0
; data_length end address is: 0 (R0)
; i end address is: 4 (R1)
UXTB	R6, R0
UXTB	R0, R1
;driverrf4463pro.c,760 :: 		while ( i != 0xFF ) {
L_spi_read155:
; i start address is: 0 (R0)
; data_length start address is: 24 (R6)
CMP	R0, #255
IT	EQ
BLEQ	L_spi_read156
; i end address is: 0 (R0)
;driverrf4463pro.c,761 :: 		i = check_cts();                // Check if you can send Command
BL	_check_cts+0
; i start address is: 0 (R0)
;driverrf4463pro.c,762 :: 		}
; i end address is: 0 (R0)
IT	AL
BLAL	L_spi_read155
L_spi_read156:
;driverrf4463pro.c,764 :: 		spi_write( 1, p );    // Send Command
MOV	R2, SP
MOV	R1, R2
MOVS	R0, #1
BL	_spi_write+0
;driverrf4463pro.c,766 :: 		i = 0;
; i start address is: 0 (R0)
MOVS	R0, #0
; data_length end address is: 24 (R6)
; i end address is: 0 (R0)
UXTB	R5, R6
;driverrf4463pro.c,767 :: 		while ( i != 0xFF ) {
L_spi_read157:
; i start address is: 0 (R0)
; data_length start address is: 20 (R5)
CMP	R0, #255
IT	EQ
BLEQ	L_spi_read158
; i end address is: 0 (R0)
;driverrf4463pro.c,768 :: 		i = check_cts();        //Check whether the data can be read
BL	_check_cts+0
; i start address is: 0 (R0)
;driverrf4463pro.c,769 :: 		}
; i end address is: 0 (R0)
IT	AL
BLAL	L_spi_read157
L_spi_read158:
;driverrf4463pro.c,771 :: 		nSEL = 1;
MOVW	R4, #lo_addr(GPIOA_ODRbits+0)
MOVT	R4, #hi_addr(GPIOA_ODRbits+0)
_LX	[R4, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R3, #8
ORRS	R2, R3
_SX	[R4, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,772 :: 		nSEL = 0;
MOVW	R4, #lo_addr(GPIOA_ODRbits+0)
MOVT	R4, #hi_addr(GPIOA_ODRbits+0)
_LX	[R4, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R3, #8
BICS	R2, R3
_SX	[R4, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,773 :: 		ucRf4463SPIByte( 0x44 );
MOVS	R0, #68
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,774 :: 		for ( i = 0; i < data_length; i++ ) {        // Read data
; i start address is: 24 (R6)
MOVS	R6, #0
; data_length end address is: 20 (R5)
; i end address is: 24 (R6)
L_spi_read159:
; i start address is: 24 (R6)
; data_length start address is: 20 (R5)
CMP	R6, R5
IT	CS
BLCS	L_spi_read160
;driverrf4463pro.c,775 :: 		spi_read_buf[ i ] = ucRf4463SPIByte( 0x00 );             // 0x00
MOVW	R2, #lo_addr(_spi_read_buf+0)
MOVT	R2, #hi_addr(_spi_read_buf+0)
ADDS	R2, R2, R6
STR	R2, [SP, #4]
MOVS	R0, #0
BL	_ucRf4463SPIByte+0
LDR	R2, [SP, #4]
STRB	R0, [R2, #0]
;driverrf4463pro.c,774 :: 		for ( i = 0; i < data_length; i++ ) {        // Read data
ADDS	R6, #1
UXTB	R6, R6
;driverrf4463pro.c,776 :: 		}
; data_length end address is: 20 (R5)
; i end address is: 24 (R6)
IT	AL
BLAL	L_spi_read159
L_spi_read160:
;driverrf4463pro.c,777 :: 		nSEL = 1;
MOVW	R4, #lo_addr(GPIOA_ODRbits+0)
MOVT	R4, #hi_addr(GPIOA_ODRbits+0)
_LX	[R4, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R3, #8
ORRS	R2, R3
_SX	[R4, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,778 :: 		}
L_end_spi_read:
ADD	SP, SP, #8
POP	(R15)
; end of _spi_read
_spi_fast_read:
;driverrf4463pro.c,783 :: 		void spi_fast_read( unsigned char api_command ) {
; api_command start address is: 0 (R0)
PUSH	(R14)
SUB	SP, SP, #8
; api_command end address is: 0 (R0)
; api_command start address is: 0 (R0)
;driverrf4463pro.c,786 :: 		p[0] = api_command;
MOV	R1, SP
STRB	R0, [R1, #0]
;driverrf4463pro.c,787 :: 		i = 0;
; i start address is: 4 (R1)
MOVS	R1, #0
; api_command end address is: 0 (R0)
; i end address is: 4 (R1)
UXTB	R5, R0
;driverrf4463pro.c,788 :: 		while ( i != 0xFF ) {
L_spi_fast_read162:
; i start address is: 4 (R1)
; api_command start address is: 20 (R5)
CMP	R1, #255
IT	EQ
BLEQ	L_spi_fast_read163
; i end address is: 4 (R1)
;driverrf4463pro.c,789 :: 		i = check_cts();                // Check if you can send Command
BL	_check_cts+0
; i start address is: 4 (R1)
UXTB	R1, R0
;driverrf4463pro.c,790 :: 		}
; i end address is: 4 (R1)
IT	AL
BLAL	L_spi_fast_read162
L_spi_fast_read163:
;driverrf4463pro.c,792 :: 		nSEL = 1;
MOVW	R3, #lo_addr(GPIOA_ODRbits+0)
MOVT	R3, #hi_addr(GPIOA_ODRbits+0)
_LX	[R3, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R2, #8
ORRS	R1, R2
_SX	[R3, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,793 :: 		nSEL = 0;
MOVW	R3, #lo_addr(GPIOA_ODRbits+0)
MOVT	R3, #hi_addr(GPIOA_ODRbits+0)
_LX	[R3, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R2, #8
BICS	R1, R2
_SX	[R3, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,794 :: 		ucRf4463SPIByte( api_command );    // Send Command
UXTB	R0, R5
; api_command end address is: 20 (R5)
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,795 :: 		for ( i = 0; i < 4; i++ ) {
; i start address is: 20 (R5)
MOVS	R5, #0
; i end address is: 20 (R5)
L_spi_fast_read164:
; i start address is: 20 (R5)
CMP	R5, #4
IT	CS
BLCS	L_spi_fast_read165
;driverrf4463pro.c,796 :: 		spi_read_buf[ i ] = ucRf4463SPIByte( 0xFF );   // Read out all the 4 registers Value of
MOVW	R1, #lo_addr(_spi_read_buf+0)
MOVT	R1, #hi_addr(_spi_read_buf+0)
ADDS	R1, R1, R5
STR	R1, [SP, #4]
MOVS	R0, #255
BL	_ucRf4463SPIByte+0
LDR	R1, [SP, #4]
STRB	R0, [R1, #0]
;driverrf4463pro.c,795 :: 		for ( i = 0; i < 4; i++ ) {
ADDS	R5, #1
UXTB	R5, R5
;driverrf4463pro.c,797 :: 		}
; i end address is: 20 (R5)
IT	AL
BLAL	L_spi_fast_read164
L_spi_fast_read165:
;driverrf4463pro.c,798 :: 		nSEL = 1;
MOVW	R3, #lo_addr(GPIOA_ODRbits+0)
MOVT	R3, #hi_addr(GPIOA_ODRbits+0)
_LX	[R3, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R2, #8
ORRS	R1, R2
_SX	[R3, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,799 :: 		}
L_end_spi_fast_read:
ADD	SP, SP, #8
POP	(R15)
; end of _spi_fast_read
_spi_write_fifo:
;driverrf4463pro.c,804 :: 		void spi_write_fifo( void ) {
PUSH	(R14)
;driverrf4463pro.c,807 :: 		i = 0;
; i start address is: 0 (R0)
MOVS	R0, #0
; i end address is: 0 (R0)
;driverrf4463pro.c,808 :: 		while ( i != 0xFF ) {
L_spi_write_fifo167:
; i start address is: 0 (R0)
CMP	R0, #255
IT	EQ
BLEQ	L_spi_write_fifo168
; i end address is: 0 (R0)
;driverrf4463pro.c,809 :: 		i = check_cts();                // Check if you can send Command
BL	_check_cts+0
; i start address is: 0 (R0)
;driverrf4463pro.c,810 :: 		}
; i end address is: 0 (R0)
IT	AL
BLAL	L_spi_write_fifo167
L_spi_write_fifo168:
;driverrf4463pro.c,812 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,813 :: 		nSEL = 0;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,814 :: 		ucRf4463SPIByte( WRITE_TX_FIFO );
MOVS	R0, #102
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,816 :: 		if ( ucRF4463Mode == tx_test_mode) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BLNE	L_spi_write_fifo169
;driverrf4463pro.c,817 :: 		for ( i = 0; i < payload_length; i++ ) {
; i start address is: 20 (R5)
MOVS	R5, #0
; i end address is: 20 (R5)
L_spi_write_fifo170:
; i start address is: 20 (R5)
CMP	R5, #66
IT	CS
BLCS	L_spi_write_fifo171
;driverrf4463pro.c,818 :: 		ucRf4463SPIByte( tx_test_aa_data[ i ] );   // Send 10 test data
MOVW	R0, #lo_addr(_tx_test_aa_data+0)
MOVT	R0, #hi_addr(_tx_test_aa_data+0)
ADDS	R0, R0, R5
LDRB	R0, [R0, #0]
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,817 :: 		for ( i = 0; i < payload_length; i++ ) {
ADDS	R5, #1
UXTB	R5, R5
;driverrf4463pro.c,819 :: 		}
; i end address is: 20 (R5)
IT	AL
BLAL	L_spi_write_fifo170
L_spi_write_fifo171:
;driverrf4463pro.c,820 :: 		}
IT	AL
BLAL	L_spi_write_fifo173
L_spi_write_fifo169:
;driverrf4463pro.c,822 :: 		for ( i = 0; i < payload_length; i++ ) {
; i start address is: 20 (R5)
MOVS	R5, #0
; i end address is: 20 (R5)
L_spi_write_fifo174:
; i start address is: 20 (R5)
CMP	R5, #66
IT	CS
BLCS	L_spi_write_fifo175
;driverrf4463pro.c,823 :: 		ucRf4463SPIByte( ucRF4463TXdata[ i ] );
MOVW	R0, #lo_addr(_ucRF4463TXdata+0)
MOVT	R0, #hi_addr(_ucRF4463TXdata+0)
ADDS	R0, R0, R5
LDRB	R0, [R0, #0]
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,822 :: 		for ( i = 0; i < payload_length; i++ ) {
ADDS	R5, #1
UXTB	R5, R5
;driverrf4463pro.c,824 :: 		}
; i end address is: 20 (R5)
IT	AL
BLAL	L_spi_write_fifo174
L_spi_write_fifo175:
;driverrf4463pro.c,825 :: 		}
L_spi_write_fifo173:
;driverrf4463pro.c,826 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,827 :: 		}
L_end_spi_write_fifo:
POP	(R15)
; end of _spi_write_fifo
_spi_read_fifo:
;driverrf4463pro.c,832 :: 		void spi_read_fifo( void ) {
PUSH	(R14)
SUB	SP, SP, #4
;driverrf4463pro.c,835 :: 		i = 0;
; i start address is: 0 (R0)
MOVS	R0, #0
; i end address is: 0 (R0)
;driverrf4463pro.c,836 :: 		while ( i != 0xFF ) {
L_spi_read_fifo177:
; i start address is: 0 (R0)
CMP	R0, #255
IT	EQ
BLEQ	L_spi_read_fifo178
; i end address is: 0 (R0)
;driverrf4463pro.c,837 :: 		i = check_cts();                   // Check if you can send Command
BL	_check_cts+0
; i start address is: 0 (R0)
;driverrf4463pro.c,838 :: 		}
; i end address is: 0 (R0)
IT	AL
BLAL	L_spi_read_fifo177
L_spi_read_fifo178:
;driverrf4463pro.c,840 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,841 :: 		nSEL = 0;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,842 :: 		ucRf4463SPIByte( READ_RX_FIFO );
MOVS	R0, #119
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,843 :: 		for ( i = 0; i < payload_length; i++ ) {
; i start address is: 20 (R5)
MOVS	R5, #0
; i end address is: 20 (R5)
L_spi_read_fifo179:
; i start address is: 20 (R5)
CMP	R5, #66
IT	CS
BLCS	L_spi_read_fifo180
;driverrf4463pro.c,844 :: 		rx_buf[ i ] = ucRf4463SPIByte( 0xFF );      // Receive 10 test data
MOVW	R0, #lo_addr(_rx_buf+0)
MOVT	R0, #hi_addr(_rx_buf+0)
ADDS	R0, R0, R5
STR	R0, [SP, #0]
MOVS	R0, #255
BL	_ucRf4463SPIByte+0
LDR	R1, [SP, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,843 :: 		for ( i = 0; i < payload_length; i++ ) {
ADDS	R5, #1
UXTB	R5, R5
;driverrf4463pro.c,845 :: 		}
; i end address is: 20 (R5)
IT	AL
BLAL	L_spi_read_fifo179
L_spi_read_fifo180:
;driverrf4463pro.c,846 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,847 :: 		}
L_end_spi_read_fifo:
ADD	SP, SP, #4
POP	(R15)
; end of _spi_read_fifo
_VRF4463SDNReset:
;driverrf4463pro.c,852 :: 		void VRF4463SDNReset( void ) {
PUSH	(R14)
;driverrf4463pro.c,855 :: 		SDN = 1;
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_LX	[R2, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #4
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,856 :: 		Delay_ms( 6 );        // RF Module reset  DELAY
LDR	R7, [PC, #23999]
NOP
L_VRF4463SDNReset182:
SUBS	R7, R7, #1
BNE	L_VRF4463SDNReset182
B	#4
	#23999
NOP
;driverrf4463pro.c,857 :: 		SDN = 0;
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_LX	[R2, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #4
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,858 :: 		Delay_ms( 10 );       // Delay 10ms for RF module to enter working state
LDR	R7, [PC, #39999]
NOP
L_VRF4463SDNReset184:
SUBS	R7, R7, #1
BNE	L_VRF4463SDNReset184
B	#4
	#39999
NOP
;driverrf4463pro.c,860 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,861 :: 		nSEL = 0;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,862 :: 		for ( i = 0; i < 7; i++ ) {
; i start address is: 20 (R5)
MOVS	R5, #0
; i end address is: 20 (R5)
L_VRF4463SDNReset186:
; i start address is: 20 (R5)
CMP	R5, #7
IT	CS
BLCS	L_VRF4463SDNReset187
;driverrf4463pro.c,863 :: 		ucRf4463SPIByte( RF_POWER_UP_data[ i ] );   // send power up Command
MOVW	R0, #lo_addr(_RF_POWER_UP_data+0)
MOVT	R0, #hi_addr(_RF_POWER_UP_data+0)
ADDS	R0, R0, R5
LDRB	R0, [R0, #0]
BL	_ucRf4463SPIByte+0
;driverrf4463pro.c,862 :: 		for ( i = 0; i < 7; i++ ) {
ADDS	R5, #1
UXTB	R5, R5
;driverrf4463pro.c,864 :: 		}
; i end address is: 20 (R5)
IT	AL
BLAL	L_VRF4463SDNReset186
L_VRF4463SDNReset187:
;driverrf4463pro.c,865 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,867 :: 		Delay_ms( 20 );       // Delay 20ms RF module enters working state, but CTS still needs to be judged later, this delay can be removed
LDR	R7, [PC, #79999]
NOP
L_VRF4463SDNReset189:
SUBS	R7, R7, #1
BNE	L_VRF4463SDNReset189
B	#4
	#79999
NOP
;driverrf4463pro.c,868 :: 		}
L_end_VRF4463SDNReset:
POP	(R15)
; end of _VRF4463SDNReset
_ucASCIIToByte:
;utils.c,41 :: 		unsigned char ucASCIIToByte( unsigned char * pcASCIIBuffer ){
; pcASCIIBuffer start address is: 0 (R0)
PUSH	(R14)
; pcASCIIBuffer end address is: 0 (R0)
; pcASCIIBuffer start address is: 0 (R0)
;utils.c,42 :: 		ucMSBNibble = 0;
MOVS	R1, #0
MOVW	R3, #lo_addr(_ucMSBNibble+0)
MOVT	R3, #hi_addr(_ucMSBNibble+0)
STRB	R1, [R3, #0]
;utils.c,43 :: 		ucLSBNibble = 0;
MOVS	R2, #0
MOVW	R1, #lo_addr(_ucLSBNibble+0)
MOVT	R1, #hi_addr(_ucLSBNibble+0)
STRB	R2, [R1, #0]
;utils.c,45 :: 		ucMSBNibble = ( pcASCIIBuffer[ 0 ] - 0x30 );
LDRB	R1, [R0, #0]
SUBS	R1, #48
STRB	R1, [R3, #0]
;utils.c,46 :: 		if( ucMSBNibble > 9 ){
UXTB	R1, R1
CMP	R1, #9
IT	LS
BLLS	L_ucASCIIToByte191
;utils.c,47 :: 		ucMSBNibble -= 7;
MOVW	R2, #lo_addr(_ucMSBNibble+0)
MOVT	R2, #hi_addr(_ucMSBNibble+0)
LDRB	R1, [R2, #0]
SUBS	R1, R1, #7
STRB	R1, [R2, #0]
;utils.c,48 :: 		}
L_ucASCIIToByte191:
;utils.c,50 :: 		ucLSBNibble = ( pcASCIIBuffer[ 1 ] - 0x30 );
ADDS	R1, R0, #1
; pcASCIIBuffer end address is: 0 (R0)
LDRB	R1, [R1, #0]
MOV	R2, R1
SUBS	R2, #48
MOVW	R1, #lo_addr(_ucLSBNibble+0)
MOVT	R1, #hi_addr(_ucLSBNibble+0)
STRB	R2, [R1, #0]
;utils.c,51 :: 		if( ucLSBNibble > 9 ){
UXTB	R1, R2
CMP	R1, #9
IT	LS
BLLS	L_ucASCIIToByte192
;utils.c,52 :: 		ucLSBNibble -= 7;
MOVW	R2, #lo_addr(_ucLSBNibble+0)
MOVT	R2, #hi_addr(_ucLSBNibble+0)
LDRB	R1, [R2, #0]
SUBS	R1, R1, #7
STRB	R1, [R2, #0]
;utils.c,53 :: 		}
L_ucASCIIToByte192:
;utils.c,55 :: 		return ( ucMSBNibble << 4 | ucLSBNibble );
MOVW	R1, #lo_addr(_ucMSBNibble+0)
MOVT	R1, #hi_addr(_ucMSBNibble+0)
LDRB	R1, [R1, #0]
LSLS	R2, R1, #4
UXTH	R2, R2
MOVW	R1, #lo_addr(_ucLSBNibble+0)
MOVT	R1, #hi_addr(_ucLSBNibble+0)
LDRB	R1, [R1, #0]
ORRS	R1, R2
UXTB	R0, R1
;utils.c,56 :: 		}
L_end_ucASCIIToByte:
POP	(R15)
; end of _ucASCIIToByte
_vASCIIToHex:
;utils.c,61 :: 		void vASCIIToHex( unsigned char *pcHexConvertBuffer, unsigned char *pcASCIIConvertBuffer, unsigned char ucConversionLength ){
; ucConversionLength start address is: 8 (R2)
; pcASCIIConvertBuffer start address is: 4 (R1)
; pcHexConvertBuffer start address is: 0 (R0)
PUSH	(R14)
SUB	SP, SP, #4
; ucConversionLength end address is: 8 (R2)
; pcASCIIConvertBuffer end address is: 4 (R1)
; pcHexConvertBuffer end address is: 0 (R0)
; pcHexConvertBuffer start address is: 0 (R0)
; pcASCIIConvertBuffer start address is: 4 (R1)
; ucConversionLength start address is: 8 (R2)
;utils.c,62 :: 		unsigned char ucASCIICounter = 0;
;utils.c,64 :: 		for( ucASCIICounter = 0; ucASCIICounter < ucConversionLength; ucASCIICounter++ ){
; ucASCIICounter start address is: 24 (R6)
MOVS	R6, #0
; pcHexConvertBuffer end address is: 0 (R0)
; ucConversionLength end address is: 8 (R2)
; ucASCIICounter end address is: 24 (R6)
STR	R2, [SP, #0]
MOV	R2, R0
LDR	R0, [SP, #0]
UXTB	R0, R0
L_vASCIIToHex193:
; ucASCIICounter start address is: 24 (R6)
; pcHexConvertBuffer start address is: 8 (R2)
; ucConversionLength start address is: 0 (R0)
; pcASCIIConvertBuffer start address is: 4 (R1)
; pcASCIIConvertBuffer end address is: 4 (R1)
; pcHexConvertBuffer start address is: 8 (R2)
; pcHexConvertBuffer end address is: 8 (R2)
CMP	R6, R0
IT	CS
BLCS	L_vASCIIToHex194
; pcASCIIConvertBuffer end address is: 4 (R1)
; pcHexConvertBuffer end address is: 8 (R2)
;utils.c,65 :: 		ucMSBNibble = 0;
; pcHexConvertBuffer start address is: 8 (R2)
; pcASCIIConvertBuffer start address is: 4 (R1)
MOVS	R3, #0
MOVW	R5, #lo_addr(_ucMSBNibble+0)
MOVT	R5, #hi_addr(_ucMSBNibble+0)
STRB	R3, [R5, #0]
;utils.c,66 :: 		ucLSBNibble = 0;
MOVS	R4, #0
MOVW	R3, #lo_addr(_ucLSBNibble+0)
MOVT	R3, #hi_addr(_ucLSBNibble+0)
STRB	R4, [R3, #0]
;utils.c,68 :: 		ucMSBNibble = ( pcASCIIConvertBuffer[ ucASCIICounter * 2 ] - 0x30 );
LSLS	R3, R6, #1
SXTH	R3, R3
ADDS	R3, R1, R3
LDRB	R3, [R3, #0]
SUBS	R3, #48
STRB	R3, [R5, #0]
;utils.c,69 :: 		if( ucMSBNibble > 9 ){
UXTB	R3, R3
CMP	R3, #9
IT	LS
BLLS	L_vASCIIToHex196
;utils.c,70 :: 		ucMSBNibble -= 7;
MOVW	R4, #lo_addr(_ucMSBNibble+0)
MOVT	R4, #hi_addr(_ucMSBNibble+0)
LDRB	R3, [R4, #0]
SUBS	R3, R3, #7
STRB	R3, [R4, #0]
;utils.c,71 :: 		}
L_vASCIIToHex196:
;utils.c,73 :: 		ucLSBNibble = ( pcASCIIConvertBuffer[ ( ucASCIICounter * 2 ) + 1 ] - 0x30 );
LSLS	R3, R6, #1
SXTH	R3, R3
ADDS	R3, #1
SXTH	R3, R3
ADDS	R3, R1, R3
LDRB	R3, [R3, #0]
MOV	R4, R3
SUBS	R4, #48
MOVW	R3, #lo_addr(_ucLSBNibble+0)
MOVT	R3, #hi_addr(_ucLSBNibble+0)
STRB	R4, [R3, #0]
;utils.c,74 :: 		if( ucLSBNibble > 9 ){
UXTB	R3, R4
CMP	R3, #9
IT	LS
BLLS	L_vASCIIToHex197
;utils.c,75 :: 		ucLSBNibble -= 7;
MOVW	R4, #lo_addr(_ucLSBNibble+0)
MOVT	R4, #hi_addr(_ucLSBNibble+0)
LDRB	R3, [R4, #0]
SUBS	R3, R3, #7
STRB	R3, [R4, #0]
;utils.c,76 :: 		}
L_vASCIIToHex197:
;utils.c,78 :: 		pcHexConvertBuffer[ ucASCIICounter ] = ( ( ucMSBNibble << 4 ) | ucLSBNibble );
ADDS	R5, R2, R6
MOVW	R3, #lo_addr(_ucMSBNibble+0)
MOVT	R3, #hi_addr(_ucMSBNibble+0)
LDRB	R3, [R3, #0]
LSLS	R4, R3, #4
UXTH	R4, R4
MOVW	R3, #lo_addr(_ucLSBNibble+0)
MOVT	R3, #hi_addr(_ucLSBNibble+0)
LDRB	R3, [R3, #0]
ORRS	R3, R4
STRB	R3, [R5, #0]
;utils.c,64 :: 		for( ucASCIICounter = 0; ucASCIICounter < ucConversionLength; ucASCIICounter++ ){
ADDS	R6, #1
UXTB	R6, R6
;utils.c,79 :: 		}
; ucConversionLength end address is: 0 (R0)
; pcASCIIConvertBuffer end address is: 4 (R1)
; pcHexConvertBuffer end address is: 8 (R2)
; ucASCIICounter end address is: 24 (R6)
IT	AL
BLAL	L_vASCIIToHex193
L_vASCIIToHex194:
;utils.c,80 :: 		}
L_end_vASCIIToHex:
ADD	SP, SP, #4
POP	(R15)
; end of _vASCIIToHex
_vHexToASCII:
;utils.c,85 :: 		void vHexToASCII( unsigned char *pcASCIIConvertBuffer, unsigned char *pcHexConvertBuffer, unsigned char ucConversionLength ){
; ucConversionLength start address is: 8 (R2)
; pcHexConvertBuffer start address is: 4 (R1)
; pcASCIIConvertBuffer start address is: 0 (R0)
PUSH	(R14)
SUB	SP, SP, #4
UXTB	R3, R2
MOV	R2, R1
MOV	R1, R0
; ucConversionLength end address is: 8 (R2)
; pcHexConvertBuffer end address is: 4 (R1)
; pcASCIIConvertBuffer end address is: 0 (R0)
; pcASCIIConvertBuffer start address is: 4 (R1)
; pcHexConvertBuffer start address is: 8 (R2)
; ucConversionLength start address is: 12 (R3)
;utils.c,86 :: 		unsigned char ucHexConvCounter = 0;
;utils.c,88 :: 		for( ucHexConvCounter = 0; ucHexConvCounter < ucConversionLength; ucHexConvCounter++ ){
; ucHexConvCounter start address is: 0 (R0)
MOVS	R0, #0
; pcASCIIConvertBuffer end address is: 4 (R1)
; pcHexConvertBuffer end address is: 8 (R2)
; ucConversionLength end address is: 12 (R3)
; ucHexConvCounter end address is: 0 (R0)
STR	R2, [SP, #0]
MOV	R2, R1
UXTB	R6, R0
UXTB	R0, R3
LDR	R1, [SP, #0]
L_vHexToASCII198:
; ucHexConvCounter start address is: 24 (R6)
; pcASCIIConvertBuffer start address is: 8 (R2)
; pcHexConvertBuffer start address is: 4 (R1)
; ucConversionLength start address is: 0 (R0)
; pcHexConvertBuffer start address is: 4 (R1)
; pcHexConvertBuffer end address is: 4 (R1)
; pcASCIIConvertBuffer start address is: 8 (R2)
; pcASCIIConvertBuffer end address is: 8 (R2)
CMP	R6, R0
IT	CS
BLCS	L_vHexToASCII199
; pcHexConvertBuffer end address is: 4 (R1)
; pcASCIIConvertBuffer end address is: 8 (R2)
;utils.c,89 :: 		pcASCIIConvertBuffer[ ucHexConvCounter * 2 ]            = pcHexChar[ pcHexConvertBuffer[ ucHexConvCounter ] >> 4 ];
; pcASCIIConvertBuffer start address is: 8 (R2)
; pcHexConvertBuffer start address is: 4 (R1)
LSLS	R3, R6, #1
SXTH	R3, R3
ADDS	R5, R2, R3
ADDS	R3, R1, R6
LDRB	R3, [R3, #0]
LSRS	R4, R3, #4
UXTB	R4, R4
MOVW	R3, #lo_addr(_pcHexChar+0)
MOVT	R3, #hi_addr(_pcHexChar+0)
ADDS	R3, R3, R4
LDRB	R3, [R3, #0]
STRB	R3, [R5, #0]
;utils.c,90 :: 		pcASCIIConvertBuffer[ ( ucHexConvCounter * 2 ) + 1 ]    = pcHexChar[ ( pcHexConvertBuffer[ ucHexConvCounter ] & 0x0F ) ];
LSLS	R3, R6, #1
SXTH	R3, R3
ADDS	R3, #1
SXTH	R3, R3
ADDS	R5, R2, R3
ADDS	R3, R1, R6
LDRB	R4, [R3, #0]
MOVS	R3, #15
ANDS	R4, R3
UXTB	R4, R4
MOVW	R3, #lo_addr(_pcHexChar+0)
MOVT	R3, #hi_addr(_pcHexChar+0)
ADDS	R3, R3, R4
LDRB	R3, [R3, #0]
STRB	R3, [R5, #0]
;utils.c,88 :: 		for( ucHexConvCounter = 0; ucHexConvCounter < ucConversionLength; ucHexConvCounter++ ){
ADDS	R6, #1
UXTB	R6, R6
;utils.c,91 :: 		}
; ucConversionLength end address is: 0 (R0)
; pcHexConvertBuffer end address is: 4 (R1)
; pcASCIIConvertBuffer end address is: 8 (R2)
; ucHexConvCounter end address is: 24 (R6)
IT	AL
BLAL	L_vHexToASCII198
L_vHexToASCII199:
;utils.c,92 :: 		}
L_end_vHexToASCII:
ADD	SP, SP, #4
POP	(R15)
; end of _vHexToASCII
_vBufferSetToZero:
;utils.c,97 :: 		void vBufferSetToZero( unsigned char * pcBufferToClean, unsigned int uslength ){
; uslength start address is: 4 (R1)
; pcBufferToClean start address is: 0 (R0)
PUSH	(R14)
SUB	SP, SP, #4
; uslength end address is: 4 (R1)
; pcBufferToClean end address is: 0 (R0)
; pcBufferToClean start address is: 0 (R0)
; uslength start address is: 4 (R1)
;utils.c,98 :: 		unsigned int usPosition = 0;
;utils.c,100 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
; usPosition start address is: 16 (R4)
MOVS	R4, #0
; pcBufferToClean end address is: 0 (R0)
; uslength end address is: 4 (R1)
; usPosition end address is: 16 (R4)
STR	R1, [SP, #0]
MOV	R1, R0
LDR	R0, [SP, #0]
UXTH	R0, R0
L_vBufferSetToZero201:
; usPosition start address is: 16 (R4)
; pcBufferToClean start address is: 4 (R1)
; uslength start address is: 0 (R0)
; pcBufferToClean start address is: 4 (R1)
; pcBufferToClean end address is: 4 (R1)
CMP	R4, R0
IT	CS
BLCS	L_vBufferSetToZero202
; pcBufferToClean end address is: 4 (R1)
;utils.c,101 :: 		pcBufferToClean[ usPosition ] = 0x00;
; pcBufferToClean start address is: 4 (R1)
ADDS	R3, R1, R4
MOVS	R2, #0
STRB	R2, [R3, #0]
;utils.c,100 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
ADDS	R4, #1
UXTH	R4, R4
;utils.c,102 :: 		}
; uslength end address is: 0 (R0)
; pcBufferToClean end address is: 4 (R1)
; usPosition end address is: 16 (R4)
IT	AL
BLAL	L_vBufferSetToZero201
L_vBufferSetToZero202:
;utils.c,103 :: 		}
L_end_vBufferSetToZero:
ADD	SP, SP, #4
POP	(R15)
; end of _vBufferSetToZero
_vBufferSetTo255:
;utils.c,108 :: 		void vBufferSetTo255( unsigned char * pcBufferToClean, unsigned int uslength ){
; uslength start address is: 4 (R1)
; pcBufferToClean start address is: 0 (R0)
PUSH	(R14)
SUB	SP, SP, #4
; uslength end address is: 4 (R1)
; pcBufferToClean end address is: 0 (R0)
; pcBufferToClean start address is: 0 (R0)
; uslength start address is: 4 (R1)
;utils.c,109 :: 		unsigned int usPosition = 0;
;utils.c,111 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
; usPosition start address is: 16 (R4)
MOVS	R4, #0
; pcBufferToClean end address is: 0 (R0)
; uslength end address is: 4 (R1)
; usPosition end address is: 16 (R4)
STR	R1, [SP, #0]
MOV	R1, R0
LDR	R0, [SP, #0]
UXTH	R0, R0
L_vBufferSetTo255204:
; usPosition start address is: 16 (R4)
; pcBufferToClean start address is: 4 (R1)
; uslength start address is: 0 (R0)
; pcBufferToClean start address is: 4 (R1)
; pcBufferToClean end address is: 4 (R1)
CMP	R4, R0
IT	CS
BLCS	L_vBufferSetTo255205
; pcBufferToClean end address is: 4 (R1)
;utils.c,112 :: 		pcBufferToClean[ usPosition ] = 0xFF;
; pcBufferToClean start address is: 4 (R1)
ADDS	R3, R1, R4
MOVS	R2, #255
STRB	R2, [R3, #0]
;utils.c,111 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
ADDS	R4, #1
UXTH	R4, R4
;utils.c,113 :: 		}
; uslength end address is: 0 (R0)
; pcBufferToClean end address is: 4 (R1)
; usPosition end address is: 16 (R4)
IT	AL
BLAL	L_vBufferSetTo255204
L_vBufferSetTo255205:
;utils.c,114 :: 		}
L_end_vBufferSetTo255:
ADD	SP, SP, #4
POP	(R15)
; end of _vBufferSetTo255
_vBufferSetToValue:
;utils.c,119 :: 		void vBufferSetToValue( unsigned char * pcBufferToClean, unsigned char ucValue, unsigned int uslength ){
; uslength start address is: 8 (R2)
; ucValue start address is: 4 (R1)
; pcBufferToClean start address is: 0 (R0)
PUSH	(R14)
SUB	SP, SP, #4
UXTH	R3, R2
UXTB	R2, R1
MOV	R1, R0
; uslength end address is: 8 (R2)
; ucValue end address is: 4 (R1)
; pcBufferToClean end address is: 0 (R0)
; pcBufferToClean start address is: 4 (R1)
; ucValue start address is: 8 (R2)
; uslength start address is: 12 (R3)
;utils.c,120 :: 		unsigned int usPosition = 0;
;utils.c,122 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
; usPosition start address is: 0 (R0)
MOVS	R0, #0
; pcBufferToClean end address is: 4 (R1)
; ucValue end address is: 8 (R2)
; uslength end address is: 12 (R3)
; usPosition end address is: 0 (R0)
STR	R2, [SP, #0]
MOV	R2, R1
UXTH	R4, R0
UXTH	R0, R3
LDR	R1, [SP, #0]
UXTB	R1, R1
L_vBufferSetToValue207:
; usPosition start address is: 16 (R4)
; pcBufferToClean start address is: 8 (R2)
; ucValue start address is: 4 (R1)
; uslength start address is: 0 (R0)
; ucValue start address is: 4 (R1)
; ucValue end address is: 4 (R1)
; pcBufferToClean start address is: 8 (R2)
; pcBufferToClean end address is: 8 (R2)
CMP	R4, R0
IT	CS
BLCS	L_vBufferSetToValue208
; ucValue end address is: 4 (R1)
; pcBufferToClean end address is: 8 (R2)
;utils.c,123 :: 		pcBufferToClean[ usPosition ] = ucValue;
; pcBufferToClean start address is: 8 (R2)
; ucValue start address is: 4 (R1)
ADDS	R3, R2, R4
STRB	R1, [R3, #0]
;utils.c,122 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
ADDS	R4, #1
UXTH	R4, R4
;utils.c,124 :: 		}
; uslength end address is: 0 (R0)
; ucValue end address is: 4 (R1)
; pcBufferToClean end address is: 8 (R2)
; usPosition end address is: 16 (R4)
IT	AL
BLAL	L_vBufferSetToValue207
L_vBufferSetToValue208:
;utils.c,125 :: 		}
L_end_vBufferSetToValue:
ADD	SP, SP, #4
POP	(R15)
; end of _vBufferSetToValue
_vSerializeUUID:
;utils.c,130 :: 		void vSerializeUUID( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer ){
; pcHexConvertBuffer start address is: 4 (R1)
; pcTextConvertBuffer start address is: 0 (R0)
PUSH	(R14)
SUB	SP, SP, #4
; pcHexConvertBuffer end address is: 4 (R1)
; pcTextConvertBuffer end address is: 0 (R0)
; pcTextConvertBuffer start address is: 0 (R0)
; pcHexConvertBuffer start address is: 4 (R1)
;utils.c,131 :: 		unsigned char ucCounter = 0;
;utils.c,133 :: 		for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
; ucCounter start address is: 20 (R5)
MOVS	R5, #0
; pcTextConvertBuffer end address is: 0 (R0)
; pcHexConvertBuffer end address is: 4 (R1)
; ucCounter end address is: 20 (R5)
STR	R1, [SP, #0]
MOV	R1, R0
LDR	R0, [SP, #0]
L_vSerializeUUID210:
; ucCounter start address is: 20 (R5)
; pcTextConvertBuffer start address is: 4 (R1)
; pcHexConvertBuffer start address is: 0 (R0)
; pcHexConvertBuffer start address is: 0 (R0)
; pcHexConvertBuffer end address is: 0 (R0)
; pcTextConvertBuffer start address is: 4 (R1)
; pcTextConvertBuffer end address is: 4 (R1)
CMP	R5, #12
IT	CS
BLCS	L_vSerializeUUID211
; pcHexConvertBuffer end address is: 0 (R0)
; pcTextConvertBuffer end address is: 4 (R1)
;utils.c,134 :: 		pcTextConvertBuffer[ ucCounter * 2 ]         = pcHexChar[ pcHexConvertBuffer[ ucCounter ] >> 4 ];
; pcTextConvertBuffer start address is: 4 (R1)
; pcHexConvertBuffer start address is: 0 (R0)
LSLS	R2, R5, #1
SXTH	R2, R2
ADDS	R4, R1, R2
ADDS	R2, R0, R5
LDRB	R2, [R2, #0]
LSRS	R3, R2, #4
UXTB	R3, R3
MOVW	R2, #lo_addr(_pcHexChar+0)
MOVT	R2, #hi_addr(_pcHexChar+0)
ADDS	R2, R2, R3
LDRB	R2, [R2, #0]
STRB	R2, [R4, #0]
;utils.c,135 :: 		pcTextConvertBuffer[ ( ucCounter * 2 ) + 1 ] = pcHexChar[ pcHexConvertBuffer[ ucCounter ] & 0x0F ];
LSLS	R2, R5, #1
SXTH	R2, R2
ADDS	R2, #1
SXTH	R2, R2
ADDS	R4, R1, R2
ADDS	R2, R0, R5
LDRB	R3, [R2, #0]
MOVS	R2, #15
ANDS	R3, R2
UXTB	R3, R3
MOVW	R2, #lo_addr(_pcHexChar+0)
MOVT	R2, #hi_addr(_pcHexChar+0)
ADDS	R2, R2, R3
LDRB	R2, [R2, #0]
STRB	R2, [R4, #0]
;utils.c,133 :: 		for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
ADDS	R5, #1
UXTB	R5, R5
;utils.c,136 :: 		}
; pcHexConvertBuffer end address is: 0 (R0)
; pcTextConvertBuffer end address is: 4 (R1)
; ucCounter end address is: 20 (R5)
IT	AL
BLAL	L_vSerializeUUID210
L_vSerializeUUID211:
;utils.c,137 :: 		}
L_end_vSerializeUUID:
ADD	SP, SP, #4
POP	(R15)
; end of _vSerializeUUID
_vSerializeMACAddress:
;utils.c,142 :: 		void vSerializeMACAddress( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer ){
; pcHexConvertBuffer start address is: 4 (R1)
; pcTextConvertBuffer start address is: 0 (R0)
PUSH	(R14)
SUB	SP, SP, #12
MOV	R7, R0
; pcHexConvertBuffer end address is: 4 (R1)
; pcTextConvertBuffer end address is: 0 (R0)
; pcTextConvertBuffer start address is: 28 (R7)
; pcHexConvertBuffer start address is: 4 (R1)
;utils.c,143 :: 		unsigned int usCounter = 0;
;utils.c,146 :: 		vHexToASCII( pcDeviceMAC, pcHexConvertBuffer, 6 );
MOV	R2, SP
MOV	R0, R2
; pcHexConvertBuffer end address is: 4 (R1)
MOVS	R2, #6
BL	_vHexToASCII+0
;utils.c,148 :: 		for( usCounter = 0; usCounter < 6; usCounter++ ){
; usCounter start address is: 4 (R1)
MOVS	R1, #0
; pcTextConvertBuffer end address is: 28 (R7)
; usCounter end address is: 4 (R1)
MOV	R0, R7
L_vSerializeMACAddress213:
; usCounter start address is: 4 (R1)
; pcTextConvertBuffer start address is: 0 (R0)
CMP	R1, #6
IT	CS
BLCS	L_vSerializeMACAddress214
;utils.c,149 :: 		pcTextConvertBuffer[ usCounter * 3 ]         = pcDeviceMAC[ usCounter * 2 ];
MOVS	R3, #3
MOV	R2, R3
MULS	R2, R1, R2
UXTH	R2, R2
ADDS	R3, R0, R2
LSLS	R2, R1, #1
UXTH	R2, R2
MOV	R4, SP
ADDS	R2, R4, R2
LDRB	R2, [R2, #0]
STRB	R2, [R3, #0]
;utils.c,150 :: 		pcTextConvertBuffer[ ( usCounter * 3 ) + 1 ] = pcDeviceMAC[ ( usCounter * 2 ) + 1 ];
MOVS	R3, #3
MOV	R2, R3
MULS	R2, R1, R2
UXTH	R2, R2
ADDS	R2, #1
UXTH	R2, R2
ADDS	R3, R0, R2
LSLS	R2, R1, #1
UXTH	R2, R2
ADDS	R2, #1
UXTH	R2, R2
ADDS	R2, R4, R2
LDRB	R2, [R2, #0]
STRB	R2, [R3, #0]
;utils.c,151 :: 		if( usCounter != 5 ){
CMP	R1, #5
IT	EQ
BLEQ	L_vSerializeMACAddress216
;utils.c,152 :: 		pcTextConvertBuffer[ ( usCounter * 3 ) + 2 ] = ':';
MOVS	R3, #3
MOV	R2, R3
MULS	R2, R1, R2
UXTH	R2, R2
ADDS	R2, #2
UXTH	R2, R2
ADDS	R3, R0, R2
MOVS	R2, #58
STRB	R2, [R3, #0]
;utils.c,153 :: 		}
L_vSerializeMACAddress216:
;utils.c,148 :: 		for( usCounter = 0; usCounter < 6; usCounter++ ){
ADDS	R1, #1
UXTH	R1, R1
;utils.c,154 :: 		}
; usCounter end address is: 4 (R1)
IT	AL
BLAL	L_vSerializeMACAddress213
L_vSerializeMACAddress214:
;utils.c,155 :: 		pcTextConvertBuffer[ 18 ] = '\0';
MOV	R3, R0
ADDS	R3, #18
; pcTextConvertBuffer end address is: 0 (R0)
MOVS	R2, #0
STRB	R2, [R3, #0]
;utils.c,156 :: 		}
L_end_vSerializeMACAddress:
ADD	SP, SP, #12
POP	(R15)
; end of _vSerializeMACAddress
_vSerializeIPAddress:
;utils.c,161 :: 		void vSerializeIPAddress( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer ){
PUSH	(R14)
SUB	SP, SP, #24
STR	R0, [SP, #12]
STR	R1, [SP, #16]
;utils.c,162 :: 		unsigned char ucCounter = 0;
;utils.c,165 :: 		memset( pcTextConvertBuffer, '\0', sizeof( pcTextConvertBuffer ) );
MOVS	R2, #4
MOVS	R1, #0
LDR	R0, [SP, #12]
BL	_memset+0
;utils.c,167 :: 		for( ucCounter = 0; ucCounter < 4; ucCounter++ ){
MOVS	R2, #0
STR	R2, [SP, #20]
L_vSerializeIPAddress217:
LDR	R2, [SP, #20]
UXTB	R2, R2
CMP	R2, #4
IT	CS
BLCS	L_vSerializeIPAddress218
;utils.c,169 :: 		ByteToStr( pcHexConvertBuffer[ ucCounter ], pcConvertText );
MOV	R4, SP
LDR	R3, [SP, #20]
UXTB	R3, R3
LDR	R2, [SP, #16]
ADDS	R2, R2, R3
LDRB	R2, [R2, #0]
MOV	R1, R4
UXTB	R0, R2
BL	_ByteToStr+0
;utils.c,171 :: 		strcat( pcTextConvertBuffer, Ltrim( pcConvertText ) );
MOV	R2, SP
MOV	R0, R2
BL	_Ltrim+0
MOV	R1, R0
LDR	R0, [SP, #12]
BL	_strcat+0
;utils.c,173 :: 		if( ucCounter != 3 ){
LDR	R2, [SP, #20]
UXTB	R2, R2
CMP	R2, #3
IT	EQ
BLEQ	L_vSerializeIPAddress220
;utils.c,174 :: 		strcat( pcTextConvertBuffer, "." );
MOVS	R6, #8
ADD	R6, SP, R6
MOVS	R5, #2
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr3_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr3_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R2, #8
ADD	R2, SP, R2
MOV	R1, R2
LDR	R0, [SP, #12]
BL	_strcat+0
;utils.c,175 :: 		}
L_vSerializeIPAddress220:
;utils.c,167 :: 		for( ucCounter = 0; ucCounter < 4; ucCounter++ ){
LDR	R2, [SP, #20]
UXTB	R2, R2
ADDS	R2, #1
STR	R2, [SP, #20]
;utils.c,176 :: 		}
IT	AL
BLAL	L_vSerializeIPAddress217
L_vSerializeIPAddress218:
;utils.c,177 :: 		}
L_end_vSerializeIPAddress:
ADD	SP, SP, #24
POP	(R15)
; end of _vSerializeIPAddress
_vUARTISR:
;uarthandler.c,206 :: 		void vUARTISR() iv IVT_INT_USART1 ics ICS_AUTO{
SUB	SP, SP, #4
;uarthandler.c,207 :: 		LED_BLUE =~ LED_BLUE;
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_LX	[R0, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #1
LSLS	R1, R1, #8
ANDS	R1, R0
LSRS	R1, R1, #8
MOVS	R0, #1
EORS	R0, R1
UXTB	R3, R0
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_LX	[R2, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #1
ANDS	R1, R3
BEQ	L__vUARTISR490
MOVS	R1, #1
LSLS	R1, R1, #8
ORRS	R0, R1
B	L__vUARTISR489
L__vUARTISR490:
MOVS	R1, #1
LSLS	R1, R1, #8
BICS	R0, R1
L__vUARTISR489:
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;uarthandler.c,242 :: 		}
L_end_vUARTISR:
ADD	SP, SP, #4
BX	LR
; end of _vUARTISR
_vUSARTStartMEMtoMEMZero:
;uarthandler.c,253 :: 		unsigned char vUSARTStartMEMtoMEMZero ( unsigned long *pcBufferDestination, unsigned long ulSizeInBytes ) {
SUB	SP, SP, #4
;uarthandler.c,292 :: 		}
L_end_vUSARTStartMEMtoMEMZero:
ADD	SP, SP, #4
BX	LR
; end of _vUSARTStartMEMtoMEMZero
_vUSARTDMAMeToMemZero:
;uarthandler.c,296 :: 		void vUSARTDMAMeToMemZero ( void ) {
SUB	SP, SP, #4
;uarthandler.c,337 :: 		}
L_end_vUSARTDMAMeToMemZero:
ADD	SP, SP, #4
BX	LR
; end of _vUSARTDMAMeToMemZero
_vUSARTStartMEMtoMEM:
;uarthandler.c,343 :: 		unsigned char vUSARTStartMEMtoMEM ( unsigned long *pcBufferOrigin, unsigned long *pcBufferDestination, unsigned long ulSizeInBytes ) {
SUB	SP, SP, #4
;uarthandler.c,382 :: 		}
L_end_vUSARTStartMEMtoMEM:
ADD	SP, SP, #4
BX	LR
; end of _vUSARTStartMEMtoMEM
_vUSARTDMAMemToMem:
;uarthandler.c,386 :: 		void vUSARTDMAMemToMem ( void ) {
SUB	SP, SP, #4
;uarthandler.c,428 :: 		}
L_end_vUSARTDMAMemToMem:
ADD	SP, SP, #4
BX	LR
; end of _vUSARTDMAMemToMem
_vUSART1Start_TX:
;uarthandler.c,434 :: 		unsigned char vUSART1Start_TX ( unsigned long *ucBuffer, unsigned long ulSize ) {
SUB	SP, SP, #4
;uarthandler.c,467 :: 		}
L_end_vUSART1Start_TX:
ADD	SP, SP, #4
BX	LR
; end of _vUSART1Start_TX
_vInitDMAUSART1_TX:
;uarthandler.c,471 :: 		void vInitDMAUSART1_TX () {
SUB	SP, SP, #4
;uarthandler.c,509 :: 		}
L_end_vInitDMAUSART1_TX:
ADD	SP, SP, #4
BX	LR
; end of _vInitDMAUSART1_TX
_vUSARTConfigUSART1:
;uarthandler.c,514 :: 		void vUSARTConfigUSART1 ( unsigned long ulBaudRate ) {
; ulBaudRate start address is: 0 (R0)
PUSH	(R14)
SUB	SP, SP, #4
MOV	R4, R0
; ulBaudRate end address is: 0 (R0)
; ulBaudRate start address is: 16 (R4)
;uarthandler.c,528 :: 		UART1_Init_Advanced( ulBaudRate, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10 );
MOVW	R1, #lo_addr(__GPIO_MODULE_USART1_PA9_10+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_USART1_PA9_10+0)
STR	R4, [SP, #0]
PUSH	(R1)
MOVS	R3, #0
MOVS	R2, #0
MOVS	R1, #0
MOV	R0, R4
BL	_UART1_Init_Advanced+0
ADD	SP, SP, #4
LDR	R4, [SP, #0]
;uarthandler.c,529 :: 		USART1_CR1bits.UE = 0;
MOVW	R3, #lo_addr(USART1_CR1bits+0)
MOVT	R3, #hi_addr(USART1_CR1bits+0)
_LX	[R3, ByteOffset(USART1_CR1bits+0)]
MOVS	R2, #1
BICS	R1, R2
_SX	[R3, ByteOffset(USART1_CR1bits+0)]
;uarthandler.c,531 :: 		ulClk = Clock_MHz() * 1000000;         // paso extra para verificacion en depuracion
MOVW	R2, #9216
MOVT	R2, #244
MOVW	R1, #lo_addr(_ulClk+0)
MOVT	R1, #hi_addr(_ulClk+0)
STR	R2, [R1, #0]
;uarthandler.c,533 :: 		USART1_BRR = ( ulClk ) / ulBaudRate;
MOVW	R1, #lo_addr(_ulClk+0)
MOVT	R1, #hi_addr(_ulClk+0)
LDR	R0, [R1, #0]
MOV	R2, R4
BL	__Div_32x32_U+0
; ulBaudRate end address is: 16 (R4)
MOVW	R1, #lo_addr(USART1_BRR+0)
MOVT	R1, #hi_addr(USART1_BRR+0)
STR	R0, [R1, #0]
;uarthandler.c,535 :: 		USART1_CR1bits.UE = 1;
MOVW	R3, #lo_addr(USART1_CR1bits+0)
MOVT	R3, #hi_addr(USART1_CR1bits+0)
_LX	[R3, ByteOffset(USART1_CR1bits+0)]
MOVS	R2, #1
ORRS	R1, R2
_SX	[R3, ByteOffset(USART1_CR1bits+0)]
;uarthandler.c,537 :: 		}
L_end_vUSARTConfigUSART1:
ADD	SP, SP, #4
POP	(R15)
; end of _vUSARTConfigUSART1
_vUSARTCleanBuffer:
;uarthandler.c,544 :: 		void vUSARTCleanBuffer ( unsigned char *ucBuffer, unsigned int uiCnt ) {
; uiCnt start address is: 4 (R1)
; ucBuffer start address is: 0 (R0)
PUSH	(R14)
; uiCnt end address is: 4 (R1)
; ucBuffer end address is: 0 (R0)
; ucBuffer start address is: 0 (R0)
; uiCnt start address is: 4 (R1)
;uarthandler.c,546 :: 		vUSARTStartMEMtoMEMZero( ucBuffer, uiCnt );
; uiCnt end address is: 4 (R1)
; ucBuffer end address is: 0 (R0)
BL	_vUSARTStartMEMtoMEMZero+0
;uarthandler.c,547 :: 		}
L_end_vUSARTCleanBuffer:
POP	(R15)
; end of _vUSARTCleanBuffer
_vUSARTReceivedFromUSART1:
;uarthandler.c,551 :: 		void vUSARTReceivedFromUSART1 ( ) {
PUSH	(R14)
;uarthandler.c,553 :: 		vUSARTCleanBuffer( ucUSARTActiveBuffer1, ulUSARTActiveBuffer1BytesReceived ); // borra todo el buffer
MOVW	R0, #lo_addr(_ulUSARTActiveBuffer1BytesReceived+0)
MOVT	R0, #hi_addr(_ulUSARTActiveBuffer1BytesReceived+0)
LDR	R0, [R0, #0]
UXTH	R1, R0
MOVW	R0, #lo_addr(_ucUSARTActiveBuffer1+0)
MOVT	R0, #hi_addr(_ucUSARTActiveBuffer1+0)
BL	_vUSARTCleanBuffer+0
;uarthandler.c,554 :: 		vUSARTStartMEMtoMEM( ucUSART1RXBuffer, ucUSARTActiveBuffer1, ulUSART1ByteReceived ); // copia el buffer de entrada
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R0, [R0, #0]
MOV	R2, R0
MOVW	R1, #lo_addr(_ucUSARTActiveBuffer1+0)
MOVT	R1, #hi_addr(_ucUSARTActiveBuffer1+0)
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
BL	_vUSARTStartMEMtoMEM+0
;uarthandler.c,555 :: 		vUSARTCleanBuffer( ucUSART1RXBuffer, ulUSART1ByteReceived );          // lo limpia
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R0, [R0, #0]
UXTH	R1, R0
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
BL	_vUSARTCleanBuffer+0
;uarthandler.c,556 :: 		ulUSARTActiveBuffer1BytesReceived = ulUSART1ByteReceived;             // le pasa el valor
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ulUSARTActiveBuffer1BytesReceived+0)
MOVT	R0, #hi_addr(_ulUSARTActiveBuffer1BytesReceived+0)
STR	R1, [R0, #0]
;uarthandler.c,557 :: 		ulUSART1ByteReceived = 0;                                             // pone a cero el contador
MOVS	R1, #0
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
STR	R1, [R0, #0]
;uarthandler.c,558 :: 		fUSART1Buffer = CLEAR_TO_WRITE;                                       // indica que esta limpio
MOVS	R1, #0
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
STR	R1, [R0, #0]
;uarthandler.c,559 :: 		vRF4463MainCommandProcessor( ucUSARTActiveBuffer1 );
MOVW	R0, #lo_addr(_ucUSARTActiveBuffer1+0)
MOVT	R0, #hi_addr(_ucUSARTActiveBuffer1+0)
BL	_vRF4463MainCommandProcessor+0
;uarthandler.c,560 :: 		}
L_end_vUSARTReceivedFromUSART1:
POP	(R15)
; end of _vUSARTReceivedFromUSART1
_Timer2_interrupt:
;DriverRF4463PROMain.c,100 :: 		void Timer2_interrupt() iv IVT_INT_TIM2 {
SUB	SP, SP, #4
;DriverRF4463PROMain.c,101 :: 		TIM2_SR.UIF = 0;
MOVW	R2, #lo_addr(TIM2_SR+0)
MOVT	R2, #hi_addr(TIM2_SR+0)
_LX	[R2, ByteOffset(TIM2_SR+0)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(TIM2_SR+0)]
;DriverRF4463PROMain.c,102 :: 		Flag.rf_reach_timeout = 1; //Enter your code here
MOVW	R2, #lo_addr(_Flag+0)
MOVT	R2, #hi_addr(_Flag+0)
_LX	[R2, ByteOffset(_Flag+0)]
MOVS	R1, #4
ORRS	R0, R1
_SX	[R2, ByteOffset(_Flag+0)]
;DriverRF4463PROMain.c,103 :: 		Flag.reach_1s = 1;
MOVW	R2, #lo_addr(_Flag+0)
MOVT	R2, #hi_addr(_Flag+0)
_LX	[R2, ByteOffset(_Flag+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(_Flag+0)]
;DriverRF4463PROMain.c,104 :: 		}
L_end_Timer2_interrupt:
ADD	SP, SP, #4
BX	LR
; end of _Timer2_interrupt
_vRF4463MainApplyChanges:
;DriverRF4463PROMain.c,108 :: 		void vRF4463MainApplyChanges () {
PUSH	(R14)
;DriverRF4463PROMain.c,109 :: 		VRF4463SDNReset();
BL	_VRF4463SDNReset+0
;DriverRF4463PROMain.c,110 :: 		vRF4463Init();
BL	_vRF4463Init+0
;DriverRF4463PROMain.c,111 :: 		vRF4463ClearInterrupts();
BL	_vRF4463ClearInterrupts+0
;DriverRF4463PROMain.c,112 :: 		}
L_end_vRF4463MainApplyChanges:
POP	(R15)
; end of _vRF4463MainApplyChanges
_vRF4463MainSetTXString:
;DriverRF4463PROMain.c,115 :: 		void vRF4463MainSetTXString () {
SUB	SP, SP, #4
;DriverRF4463PROMain.c,120 :: 		}
L_end_vRF4463MainSetTXString:
ADD	SP, SP, #4
BX	LR
; end of _vRF4463MainSetTXString
_vRF4463MainCommandProcessor:
;DriverRF4463PROMain.c,124 :: 		void vRF4463MainCommandProcessor ( unsigned char *ucBuffer ) {
; ucBuffer start address is: 0 (R0)
PUSH	(R14)
SUB	SP, SP, #100
; ucBuffer end address is: 0 (R0)
; ucBuffer start address is: 0 (R0)
;DriverRF4463PROMain.c,125 :: 		unsigned char ucCommand [ 32 ] = { 0x00 };
MOV	R6, SP
MOVS	R5, #96
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICSvRF4463MainCommandProcessor_ucCommand_L0+0)
MOVT	R7, #hi_addr(?ICSvRF4463MainCommandProcessor_ucCommand_L0+0)
BL	___CC2DW+0
;DriverRF4463PROMain.c,126 :: 		unsigned long ulArgument = 0;
;DriverRF4463PROMain.c,127 :: 		unsigned char ucLongArgument[ 64 ] = { 0x00 };     // Espera argumentos de hasta 11 bytes
;DriverRF4463PROMain.c,128 :: 		unsigned char ucCounterBuffer = 0;
; ucCounterBuffer start address is: 12 (R3)
MOVS	R3, #0
;DriverRF4463PROMain.c,129 :: 		unsigned char ucCounterCommand = 0;
; ucCounterCommand start address is: 16 (R4)
MOVS	R4, #0
;DriverRF4463PROMain.c,130 :: 		unsigned char ucCounterLongArgument = 0;
; ucCounterLongArgument start address is: 8 (R2)
MOVS	R2, #0
;DriverRF4463PROMain.c,133 :: 		if ( ucBuffer[ 0 ] > '@' && ucBuffer[ 0 ] <= 'z' ) {
LDRB	R1, [R0, #0]
CMP	R1, #64
IT	LS
BLLS	L__vRF4463MainCommandProcessor440
LDRB	R1, [R0, #0]
CMP	R1, #122
IT	HI
BLHI	L__vRF4463MainCommandProcessor441
L__vRF4463MainCommandProcessor406:
;DriverRF4463PROMain.c,135 :: 		while ( ucBuffer[ ucCounterBuffer ] != '|' && ucCounterCommand < 32 ) {      // primer token
MOV	R5, R0
; ucCounterCommand end address is: 16 (R4)
; ucCounterBuffer end address is: 12 (R3)
; ucBuffer end address is: 0 (R0)
L_vRF4463MainCommandProcessor224:
; ucCounterLongArgument end address is: 8 (R2)
; ucCounterLongArgument start address is: 8 (R2)
; ucCounterCommand start address is: 16 (R4)
; ucCounterBuffer start address is: 12 (R3)
; ucBuffer start address is: 20 (R5)
ADDS	R1, R5, R3
LDRB	R1, [R1, #0]
CMP	R1, #124
IT	EQ
BLEQ	L__vRF4463MainCommandProcessor408
CMP	R4, #32
IT	CS
BLCS	L__vRF4463MainCommandProcessor407
L__vRF4463MainCommandProcessor405:
;DriverRF4463PROMain.c,136 :: 		ucCommand[ ucCounterCommand++ ] = toupper( ucBuffer[ ucCounterBuffer++ ] );
MOV	R1, SP
ADDS	R1, R1, R4
STR	R1, [SP, #96]
ADDS	R1, R5, R3
LDRB	R1, [R1, #0]
UXTB	R0, R1
BL	_toupper+0
LDR	R1, [SP, #96]
STRB	R0, [R1, #0]
ADDS	R4, #1
UXTB	R4, R4
ADDS	R3, #1
UXTB	R3, R3
;DriverRF4463PROMain.c,137 :: 		}
; ucCounterCommand end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463MainCommandProcessor224
;DriverRF4463PROMain.c,135 :: 		while ( ucBuffer[ ucCounterBuffer ] != '|' && ucCounterCommand < 32 ) {      // primer token
L__vRF4463MainCommandProcessor408:
L__vRF4463MainCommandProcessor407:
;DriverRF4463PROMain.c,139 :: 		ucCounterBuffer++;                                                           // evita el Token
ADDS	R4, R3, #1
UXTB	R4, R4
; ucCounterBuffer end address is: 12 (R3)
; ucCounterBuffer start address is: 16 (R4)
; ucCounterLongArgument end address is: 8 (R2)
; ucCounterBuffer end address is: 16 (R4)
; ucBuffer end address is: 20 (R5)
UXTB	R3, R2
MOV	R0, R5
;DriverRF4463PROMain.c,141 :: 		while ( ucBuffer[ ucCounterBuffer ] != CHR_CR && ucCounterLongArgument < 64 ) {   // segundo token
L_vRF4463MainCommandProcessor228:
; ucCounterBuffer start address is: 16 (R4)
; ucBuffer start address is: 0 (R0)
; ucCounterLongArgument start address is: 12 (R3)
ADDS	R1, R0, R4
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BLEQ	L__vRF4463MainCommandProcessor410
CMP	R3, #64
IT	CS
BLCS	L__vRF4463MainCommandProcessor409
L__vRF4463MainCommandProcessor404:
;DriverRF4463PROMain.c,142 :: 		ucLongArgument[ ucCounterLongArgument ] = ucBuffer[ ucCounterBuffer ] ;   //  toupper(
MOVS	R1, #32
ADD	R1, SP, R1
ADDS	R2, R1, R3
ADDS	R1, R0, R4
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
;DriverRF4463PROMain.c,143 :: 		ucCounterBuffer++;
ADDS	R4, #1
UXTB	R4, R4
;DriverRF4463PROMain.c,144 :: 		ucCounterLongArgument++;
ADDS	R3, #1
UXTB	R3, R3
;DriverRF4463PROMain.c,145 :: 		}
; ucCounterBuffer end address is: 16 (R4)
; ucCounterLongArgument end address is: 12 (R3)
IT	AL
BLAL	L_vRF4463MainCommandProcessor228
;DriverRF4463PROMain.c,141 :: 		while ( ucBuffer[ ucCounterBuffer ] != CHR_CR && ucCounterLongArgument < 64 ) {   // segundo token
L__vRF4463MainCommandProcessor410:
L__vRF4463MainCommandProcessor409:
;DriverRF4463PROMain.c,133 :: 		if ( ucBuffer[ 0 ] > '@' && ucBuffer[ 0 ] <= 'z' ) {
MOV	R5, R0
IT	AL
BLAL	L__vRF4463MainCommandProcessor412
; ucBuffer end address is: 0 (R0)
L__vRF4463MainCommandProcessor440:
MOV	R5, R0
L__vRF4463MainCommandProcessor412:
; ucBuffer start address is: 20 (R5)
; ucBuffer end address is: 20 (R5)
IT	AL
BLAL	L__vRF4463MainCommandProcessor411
L__vRF4463MainCommandProcessor441:
MOV	R5, R0
L__vRF4463MainCommandProcessor411:
;DriverRF4463PROMain.c,150 :: 		if ( memcmp( CMD_RADIO_POWER_SET, ucCommand, sizeof( CMD_RADIO_POWER_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
MOV	R1, SP
MOVS	R2, #10
MOVW	R0, #lo_addr(_CMD_RADIO_POWER_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_POWER_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor232
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,151 :: 		ulArgument = StrToShort( ucLongArgument );
MOVS	R1, #32
ADD	R1, SP, R1
MOV	R0, R1
BL	_StrToShort+0
; ulArgument start address is: 0 (R0)
;DriverRF4463PROMain.c,153 :: 		if ( ulArgument > 0 && ulArgument <= 127 ) {
CMP	R0, #0
IT	LS
BLLS	L__vRF4463MainCommandProcessor414
CMP	R0, #127
IT	HI
BLHI	L__vRF4463MainCommandProcessor413
L__vRF4463MainCommandProcessor403:
;DriverRF4463PROMain.c,154 :: 		ucRF4463Power = ulArgument;
MOVW	R1, #lo_addr(_ucRF4463Power+0)
MOVT	R1, #hi_addr(_ucRF4463Power+0)
STRB	R0, [R1, #0]
; ulArgument end address is: 0 (R0)
;DriverRF4463PROMain.c,155 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,156 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,157 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor236
;DriverRF4463PROMain.c,153 :: 		if ( ulArgument > 0 && ulArgument <= 127 ) {
L__vRF4463MainCommandProcessor414:
L__vRF4463MainCommandProcessor413:
;DriverRF4463PROMain.c,159 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,160 :: 		}
L_vRF4463MainCommandProcessor236:
;DriverRF4463PROMain.c,161 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor237
L_vRF4463MainCommandProcessor232:
;DriverRF4463PROMain.c,165 :: 		else if ( memcmp( CMD_RADIO_BAND_SET, ucCommand, sizeof( CMD_RADIO_BAND_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
MOV	R1, SP
MOVS	R2, #9
MOVW	R0, #lo_addr(_CMD_RADIO_BAND_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_BAND_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor238
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,166 :: 		ulArgument = StrToInt( ucLongArgument );
MOVS	R1, #32
ADD	R1, SP, R1
MOV	R0, R1
BL	_StrToInt+0
; ulArgument start address is: 0 (R0)
;DriverRF4463PROMain.c,168 :: 		if ( ulArgument == 433 || ulArgument == 868 || ulArgument == 915 ) {
MOVS	R1, #255
ADDS	R1, #178
CMP	R0, R1
IT	EQ
BLEQ	L__vRF4463MainCommandProcessor417
MOVW	R1, #868
MOVT	R1, #0
CMP	R0, R1
IT	EQ
BLEQ	L__vRF4463MainCommandProcessor416
MOVW	R1, #915
MOVT	R1, #0
CMP	R0, R1
IT	EQ
BLEQ	L__vRF4463MainCommandProcessor415
; ulArgument end address is: 0 (R0)
IT	AL
BLAL	L_vRF4463MainCommandProcessor241
L__vRF4463MainCommandProcessor417:
L__vRF4463MainCommandProcessor416:
L__vRF4463MainCommandProcessor415:
;DriverRF4463PROMain.c,169 :: 		ucRF4463Freq3 = ucLongArgument[ 0 ] - 48;
MOVS	R3, #32
ADD	R3, SP, R3
LDRB	R1, [R3, #0]
MOV	R2, R1
SUBS	R2, #48
MOVW	R1, #lo_addr(_ucRF4463Freq3+0)
MOVT	R1, #hi_addr(_ucRF4463Freq3+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,170 :: 		ucRF4463Freq2 = ucLongArgument[ 1 ] - 48;
ADDS	R1, R3, #1
LDRB	R1, [R1, #0]
MOV	R2, R1
SUBS	R2, #48
MOVW	R1, #lo_addr(_ucRF4463Freq2+0)
MOVT	R1, #hi_addr(_ucRF4463Freq2+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,171 :: 		ucRF4463Freq1 = ucLongArgument[ 2 ] - 48;
ADDS	R1, R3, #2
LDRB	R1, [R1, #0]
MOV	R2, R1
SUBS	R2, #48
MOVW	R1, #lo_addr(_ucRF4463Freq1+0)
MOVT	R1, #hi_addr(_ucRF4463Freq1+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,172 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,173 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,174 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor242
L_vRF4463MainCommandProcessor241:
;DriverRF4463PROMain.c,176 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,177 :: 		}
L_vRF4463MainCommandProcessor242:
;DriverRF4463PROMain.c,178 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor243
L_vRF4463MainCommandProcessor238:
;DriverRF4463PROMain.c,182 :: 		else if ( memcmp( CMD_RADIO_RATE_SET, ucCommand, sizeof( CMD_RADIO_RATE_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
MOV	R1, SP
MOVS	R2, #9
MOVW	R0, #lo_addr(_CMD_RADIO_RATE_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_RATE_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor244
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,183 :: 		ulArgument = StrToLong( ucLongArgument );
MOVS	R1, #32
ADD	R1, SP, R1
MOV	R0, R1
BL	_StrToLong+0
; ulArgument start address is: 0 (R0)
;DriverRF4463PROMain.c,185 :: 		switch ( ulArgument ) {
IT	AL
BLAL	L_vRF4463MainCommandProcessor245
; ulArgument end address is: 0 (R0)
;DriverRF4463PROMain.c,186 :: 		case 500      : ucRF4463Rate = dr_500;
L_vRF4463MainCommandProcessor247:
MOVS	R2, #10
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,187 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,188 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,189 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor246
;DriverRF4463PROMain.c,190 :: 		case 1200     : ucRF4463Rate = dr_1p2;
L_vRF4463MainCommandProcessor248:
MOVS	R2, #0
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,191 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,192 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,193 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor246
;DriverRF4463PROMain.c,194 :: 		case 2400     : ucRF4463Rate = dr_2p4;
L_vRF4463MainCommandProcessor249:
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,195 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,196 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,197 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor246
;DriverRF4463PROMain.c,198 :: 		case 4800     : ucRF4463Rate = dr_4p8;
L_vRF4463MainCommandProcessor250:
MOVS	R2, #2
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,199 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,200 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,201 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor246
;DriverRF4463PROMain.c,202 :: 		case 9600     : ucRF4463Rate = dr_9p6;
L_vRF4463MainCommandProcessor251:
MOVS	R2, #3
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,203 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,204 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,205 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor246
;DriverRF4463PROMain.c,206 :: 		case 19200    : ucRF4463Rate = dr_19p2;
L_vRF4463MainCommandProcessor252:
MOVS	R2, #4
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,207 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,208 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,209 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor246
;DriverRF4463PROMain.c,210 :: 		case 38400    : ucRF4463Rate = dr_38p4;
L_vRF4463MainCommandProcessor253:
MOVS	R2, #5
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,211 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,212 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,213 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor246
;DriverRF4463PROMain.c,214 :: 		case 76800    : ucRF4463Rate = dr_76p8;
L_vRF4463MainCommandProcessor254:
MOVS	R2, #6
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,215 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,216 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,217 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor246
;DriverRF4463PROMain.c,218 :: 		case 115200   : ucRF4463Rate = dr_115p2;
L_vRF4463MainCommandProcessor255:
MOVS	R2, #7
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,219 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,220 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,221 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor246
;DriverRF4463PROMain.c,222 :: 		case 256000   : ucRF4463Rate = dr_256k;
L_vRF4463MainCommandProcessor256:
MOVS	R2, #8
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,223 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,224 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,225 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor246
;DriverRF4463PROMain.c,226 :: 		case 500000   : ucRF4463Rate = dr_500k;
L_vRF4463MainCommandProcessor257:
MOVS	R2, #9
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,227 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,228 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,229 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor246
;DriverRF4463PROMain.c,230 :: 		default       : vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
L_vRF4463MainCommandProcessor258:
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,231 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor246
L_vRF4463MainCommandProcessor245:
; ulArgument start address is: 0 (R0)
MOVS	R1, #255
ADDS	R1, #245
CMP	R0, R1
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor247
MOVW	R1, #1200
MOVT	R1, #0
CMP	R0, R1
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor248
MOVW	R1, #2400
MOVT	R1, #0
CMP	R0, R1
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor249
MOVW	R1, #4800
MOVT	R1, #0
CMP	R0, R1
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor250
MOVW	R1, #9600
MOVT	R1, #0
CMP	R0, R1
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor251
MOVW	R1, #19200
MOVT	R1, #0
CMP	R0, R1
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor252
MOVW	R1, #38400
MOVT	R1, #0
CMP	R0, R1
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor253
MOVW	R1, #11264
MOVT	R1, #1
CMP	R0, R1
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor254
MOVW	R1, #49664
MOVT	R1, #1
CMP	R0, R1
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor255
MOVW	R1, #59392
MOVT	R1, #3
CMP	R0, R1
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor256
MOVW	R1, #41248
MOVT	R1, #7
CMP	R0, R1
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor257
; ulArgument end address is: 0 (R0)
IT	AL
BLAL	L_vRF4463MainCommandProcessor258
L_vRF4463MainCommandProcessor246:
;DriverRF4463PROMain.c,232 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor259
L_vRF4463MainCommandProcessor244:
;DriverRF4463PROMain.c,236 :: 		else if ( memcmp( CMD_RADIO_CHANNEL_SET, ucCommand, sizeof( CMD_RADIO_CHANNEL_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
MOV	R1, SP
MOVS	R2, #12
MOVW	R0, #lo_addr(_CMD_RADIO_CHANNEL_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_CHANNEL_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor260
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,237 :: 		ulArgument = StrToInt( ucLongArgument );
MOVS	R1, #32
ADD	R1, SP, R1
MOV	R0, R1
BL	_StrToInt+0
; ulArgument start address is: 0 (R0)
;DriverRF4463PROMain.c,239 :: 		if ( ulArgument >= 0 && ulArgument <= 50 ) {
CMP	R0, #0
IT	CC
BLCC	L__vRF4463MainCommandProcessor419
CMP	R0, #50
IT	HI
BLHI	L__vRF4463MainCommandProcessor418
L__vRF4463MainCommandProcessor401:
;DriverRF4463PROMain.c,240 :: 		ucRF4463FreqChannel = ulArgument;    // Se aplica al ejecutar funciones de TX o RX
MOVW	R1, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R1, #hi_addr(_ucRF4463FreqChannel+0)
STRB	R0, [R1, #0]
; ulArgument end address is: 0 (R0)
;DriverRF4463PROMain.c,241 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,242 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,243 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor264
;DriverRF4463PROMain.c,239 :: 		if ( ulArgument >= 0 && ulArgument <= 50 ) {
L__vRF4463MainCommandProcessor419:
L__vRF4463MainCommandProcessor418:
;DriverRF4463PROMain.c,245 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,246 :: 		}
L_vRF4463MainCommandProcessor264:
;DriverRF4463PROMain.c,247 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor265
L_vRF4463MainCommandProcessor260:
;DriverRF4463PROMain.c,251 :: 		else if ( memcmp( CMD_RADIO_BW_SET, ucCommand, sizeof( CMD_RADIO_BW_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
MOV	R1, SP
MOVS	R2, #7
MOVW	R0, #lo_addr(_CMD_RADIO_BW_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_BW_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor266
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,252 :: 		ulArgument = StrToInt( ucLongArgument );
MOVS	R1, #32
ADD	R1, SP, R1
MOV	R0, R1
BL	_StrToInt+0
; ulArgument start address is: 0 (R0)
;DriverRF4463PROMain.c,254 :: 		if ( ulArgument == 250 || ulArgument == 500 ) {
CMP	R0, #250
IT	EQ
BLEQ	L__vRF4463MainCommandProcessor421
MOVS	R1, #255
ADDS	R1, #245
CMP	R0, R1
IT	EQ
BLEQ	L__vRF4463MainCommandProcessor420
; ulArgument end address is: 0 (R0)
IT	AL
BLAL	L_vRF4463MainCommandProcessor269
L__vRF4463MainCommandProcessor421:
; ulArgument start address is: 0 (R0)
L__vRF4463MainCommandProcessor420:
;DriverRF4463PROMain.c,255 :: 		ulRF4463Step = ulArgument;
MOVW	R1, #lo_addr(_ulRF4463Step+0)
MOVT	R1, #hi_addr(_ulRF4463Step+0)
STR	R0, [R1, #0]
; ulArgument end address is: 0 (R0)
;DriverRF4463PROMain.c,256 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,257 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,258 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor270
L_vRF4463MainCommandProcessor269:
;DriverRF4463PROMain.c,260 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,261 :: 		}
L_vRF4463MainCommandProcessor270:
;DriverRF4463PROMain.c,262 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor271
L_vRF4463MainCommandProcessor266:
;DriverRF4463PROMain.c,269 :: 		else if ( memcmp( CMD_RADIO_MODE_SET, ucCommand, sizeof( CMD_RADIO_MODE_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
MOV	R1, SP
MOVS	R2, #9
MOVW	R0, #lo_addr(_CMD_RADIO_MODE_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MODE_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor272
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,271 :: 		ucCounterCommand = 0;
; ucCounterCommand start address is: 12 (R3)
MOVS	R3, #0
; ucCounterCommand end address is: 12 (R3)
;DriverRF4463PROMain.c,273 :: 		while ( ucLongArgument[ ucCounterCommand ] != ucUSARTNull && ucCounterCommand < 32 ) {
L_vRF4463MainCommandProcessor273:
; ucCounterCommand start address is: 12 (R3)
MOVS	R1, #32
ADD	R1, SP, R1
ADDS	R1, R1, R3
LDRB	R2, [R1, #0]
MOVW	R1, #lo_addr(_ucUSARTNull+0)
MOVT	R1, #hi_addr(_ucUSARTNull+0)
LDRB	R1, [R1, #0]
CMP	R2, R1
IT	EQ
BLEQ	L__vRF4463MainCommandProcessor423
CMP	R3, #32
IT	CS
BLCS	L__vRF4463MainCommandProcessor422
L__vRF4463MainCommandProcessor399:
;DriverRF4463PROMain.c,274 :: 		ucLongArgument[ ucCounterCommand ] = toupper( ucLongArgument[ ucCounterCommand ] );
MOVS	R1, #32
ADD	R1, SP, R1
ADDS	R1, R1, R3
STR	R1, [SP, #96]
LDRB	R1, [R1, #0]
UXTB	R0, R1
BL	_toupper+0
LDR	R1, [SP, #96]
STRB	R0, [R1, #0]
;DriverRF4463PROMain.c,275 :: 		ucCounterCommand++;
ADDS	R3, #1
UXTB	R3, R3
;DriverRF4463PROMain.c,276 :: 		}
; ucCounterCommand end address is: 12 (R3)
IT	AL
BLAL	L_vRF4463MainCommandProcessor273
;DriverRF4463PROMain.c,273 :: 		while ( ucLongArgument[ ucCounterCommand ] != ucUSARTNull && ucCounterCommand < 32 ) {
L__vRF4463MainCommandProcessor423:
L__vRF4463MainCommandProcessor422:
;DriverRF4463PROMain.c,279 :: 		if ( memcmp( ARG_RADIO_MODE_STBY, ucLongArgument, sizeof( ARG_RADIO_MODE_STBY ) ) == 0x00 ) {
MOVS	R1, #32
ADD	R1, SP, R1
MOVS	R2, #5
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_STBY+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_STBY+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor277
;DriverRF4463PROMain.c,280 :: 		ucRF4463Mode = rf_off;
MOVS	R2, #4
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,281 :: 		vUSART1Start_TX( ANS_COMMAND_MODE_STBY, strlen( ANS_COMMAND_MODE_STBY ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_STBY+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_STBY+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_STBY+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_STBY+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,282 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor278
L_vRF4463MainCommandProcessor277:
;DriverRF4463PROMain.c,283 :: 		else if ( memcmp( ARG_RADIO_MODE_TX_CONT, ucLongArgument, sizeof( ARG_RADIO_MODE_TX_CONT ) ) == 0x00 ) {
MOVS	R1, #32
ADD	R1, SP, R1
MOVS	R2, #8
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_TX_CONT+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_TX_CONT+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor279
;DriverRF4463PROMain.c,284 :: 		ucRF4463Mode = tx_test_mode;
MOVS	R2, #2
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,285 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,286 :: 		vUSART1Start_TX( ANS_COMMAND_MODE_TX_CONT, strlen( ANS_COMMAND_MODE_TX_CONT ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_CONT+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_CONT+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,287 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor280
L_vRF4463MainCommandProcessor279:
;DriverRF4463PROMain.c,288 :: 		else if ( memcmp( ARG_RADIO_MODE_RX_CONT, ucLongArgument, sizeof( ARG_RADIO_MODE_RX_CONT ) ) == 0x00 ) {
MOVS	R1, #32
ADD	R1, SP, R1
MOVS	R2, #8
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_RX_CONT+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_RX_CONT+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor281
;DriverRF4463PROMain.c,289 :: 		ucRF4463Mode = rx_test_mode;
MOVS	R2, #3
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,290 :: 		vUSART1Start_TX( ANS_COMMAND_MODE_RX_CONT, strlen( ANS_COMMAND_MODE_RX_CONT ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_CONT+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_CONT+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,291 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor282
L_vRF4463MainCommandProcessor281:
;DriverRF4463PROMain.c,292 :: 		else if ( memcmp( ARG_RADIO_MODE_TX_MASTER, ucLongArgument, sizeof( ARG_RADIO_MODE_TX_MASTER ) ) == 0x00 ) {
MOVS	R1, #32
ADD	R1, SP, R1
MOVS	R2, #10
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_TX_MASTER+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_TX_MASTER+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor283
;DriverRF4463PROMain.c,293 :: 		ucRF4463Mode = master_mode;
MOVS	R2, #0
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,294 :: 		vUSART1Start_TX( ANS_COMMAND_MODE_TX_MASTER, strlen( ANS_COMMAND_MODE_TX_MASTER ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,295 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor284
L_vRF4463MainCommandProcessor283:
;DriverRF4463PROMain.c,296 :: 		else if ( memcmp( ARG_RADIO_MODE_RX_SLAVE, ucLongArgument, sizeof( ARG_RADIO_MODE_RX_SLAVE ) ) == 0x00 ) {
MOVS	R1, #32
ADD	R1, SP, R1
MOVS	R2, #9
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_RX_SLAVE+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_RX_SLAVE+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor285
;DriverRF4463PROMain.c,297 :: 		ucRF4463Mode = slave_mode;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,298 :: 		vUSART1Start_TX( ANS_COMMAND_MODE_RX_SLAVE, strlen( ANS_COMMAND_MODE_RX_SLAVE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,299 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor286
L_vRF4463MainCommandProcessor285:
;DriverRF4463PROMain.c,301 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,302 :: 		}
L_vRF4463MainCommandProcessor286:
L_vRF4463MainCommandProcessor284:
L_vRF4463MainCommandProcessor282:
L_vRF4463MainCommandProcessor280:
L_vRF4463MainCommandProcessor278:
;DriverRF4463PROMain.c,303 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor287
L_vRF4463MainCommandProcessor272:
;DriverRF4463PROMain.c,308 :: 		else if ( memcmp( CMD_RADIO_PACKET_SEND, ucCommand, sizeof( CMD_RADIO_PACKET_SEND ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
MOV	R1, SP
MOVS	R2, #12
MOVW	R0, #lo_addr(_CMD_RADIO_PACKET_SEND+0)
MOVT	R0, #hi_addr(_CMD_RADIO_PACKET_SEND+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor288
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,312 :: 		ulArgument = StrToLong( ucLongArgument );
MOVS	R1, #32
ADD	R1, SP, R1
MOV	R0, R1
BL	_StrToLong+0
;DriverRF4463PROMain.c,314 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,316 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor289
L_vRF4463MainCommandProcessor288:
;DriverRF4463PROMain.c,321 :: 		else if ( memcmp( CMD_RADIO_MATCH_BYTE_1_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_1_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
MOV	R1, SP
MOVS	R2, #12
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_BYTE_1_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_BYTE_1_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor290
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,322 :: 		ulArgument = StrToLong( ucLongArgument );
MOVS	R1, #32
ADD	R1, SP, R1
MOV	R0, R1
BL	_StrToLong+0
; ulArgument start address is: 8 (R2)
MOV	R2, R0
;DriverRF4463PROMain.c,323 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BLCC	L__vRF4463MainCommandProcessor425
CMP	R2, #255
IT	HI
BLHI	L__vRF4463MainCommandProcessor424
L__vRF4463MainCommandProcessor398:
;DriverRF4463PROMain.c,324 :: 		ucRF4463ByteMatch1 = ulArgument;
MOVW	R1, #lo_addr(_ucRF4463ByteMatch1+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMatch1+0)
STRB	R2, [R1, #0]
; ulArgument end address is: 8 (R2)
;DriverRF4463PROMain.c,325 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,326 :: 		ucRF4463MatchEnableReg = 0x40;
MOVS	R2, #64
MOVW	R1, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,327 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,328 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,329 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor294
;DriverRF4463PROMain.c,323 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor425:
L__vRF4463MainCommandProcessor424:
;DriverRF4463PROMain.c,331 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,332 :: 		}
L_vRF4463MainCommandProcessor294:
;DriverRF4463PROMain.c,333 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor295
L_vRF4463MainCommandProcessor290:
;DriverRF4463PROMain.c,337 :: 		else if ( memcmp( CMD_RADIO_MATCH_BYTE_2_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_2_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
MOV	R1, SP
MOVS	R2, #12
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_BYTE_2_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_BYTE_2_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor296
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,338 :: 		ulArgument = StrToLong( ucLongArgument );
MOVS	R1, #32
ADD	R1, SP, R1
MOV	R0, R1
BL	_StrToLong+0
; ulArgument start address is: 8 (R2)
MOV	R2, R0
;DriverRF4463PROMain.c,339 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BLCC	L__vRF4463MainCommandProcessor427
CMP	R2, #255
IT	HI
BLHI	L__vRF4463MainCommandProcessor426
L__vRF4463MainCommandProcessor397:
;DriverRF4463PROMain.c,340 :: 		ucRF4463ByteMatch2 = ulArgument;
MOVW	R1, #lo_addr(_ucRF4463ByteMatch2+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMatch2+0)
STRB	R2, [R1, #0]
; ulArgument end address is: 8 (R2)
;DriverRF4463PROMain.c,341 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,342 :: 		ucRF4463MatchEnableReg = 0x40;
MOVS	R2, #64
MOVW	R1, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,343 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,344 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,345 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor300
;DriverRF4463PROMain.c,339 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor427:
L__vRF4463MainCommandProcessor426:
;DriverRF4463PROMain.c,347 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,348 :: 		}
L_vRF4463MainCommandProcessor300:
;DriverRF4463PROMain.c,349 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor301
L_vRF4463MainCommandProcessor296:
;DriverRF4463PROMain.c,353 :: 		else if ( memcmp( CMD_RADIO_MATCH_BYTE_3_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_3_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
MOV	R1, SP
MOVS	R2, #12
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_BYTE_3_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_BYTE_3_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor302
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,354 :: 		ulArgument = StrToLong( ucLongArgument );
MOVS	R1, #32
ADD	R1, SP, R1
MOV	R0, R1
BL	_StrToLong+0
; ulArgument start address is: 8 (R2)
MOV	R2, R0
;DriverRF4463PROMain.c,355 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BLCC	L__vRF4463MainCommandProcessor429
CMP	R2, #255
IT	HI
BLHI	L__vRF4463MainCommandProcessor428
L__vRF4463MainCommandProcessor396:
;DriverRF4463PROMain.c,356 :: 		ucRF4463ByteMatch3 = ulArgument;
MOVW	R1, #lo_addr(_ucRF4463ByteMatch3+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMatch3+0)
STRB	R2, [R1, #0]
; ulArgument end address is: 8 (R2)
;DriverRF4463PROMain.c,357 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,358 :: 		ucRF4463MatchEnableReg = 0x40;
MOVS	R2, #64
MOVW	R1, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,359 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,360 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,361 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor306
;DriverRF4463PROMain.c,355 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor429:
L__vRF4463MainCommandProcessor428:
;DriverRF4463PROMain.c,363 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,364 :: 		}
L_vRF4463MainCommandProcessor306:
;DriverRF4463PROMain.c,365 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor307
L_vRF4463MainCommandProcessor302:
;DriverRF4463PROMain.c,369 :: 		else if ( memcmp( CMD_RADIO_MATCH_BYTE_4_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_4_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
MOV	R1, SP
MOVS	R2, #12
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_BYTE_4_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_BYTE_4_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor308
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,370 :: 		ulArgument = StrToLong( ucLongArgument );
MOVS	R1, #32
ADD	R1, SP, R1
MOV	R0, R1
BL	_StrToLong+0
; ulArgument start address is: 8 (R2)
MOV	R2, R0
;DriverRF4463PROMain.c,371 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BLCC	L__vRF4463MainCommandProcessor431
CMP	R2, #255
IT	HI
BLHI	L__vRF4463MainCommandProcessor430
L__vRF4463MainCommandProcessor395:
;DriverRF4463PROMain.c,372 :: 		ucRF4463ByteMatch4 = ulArgument;
MOVW	R1, #lo_addr(_ucRF4463ByteMatch4+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMatch4+0)
STRB	R2, [R1, #0]
; ulArgument end address is: 8 (R2)
;DriverRF4463PROMain.c,373 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,374 :: 		ucRF4463MatchEnableReg = 0x40;
MOVS	R2, #64
MOVW	R1, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,375 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,376 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,377 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor312
;DriverRF4463PROMain.c,371 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor431:
L__vRF4463MainCommandProcessor430:
;DriverRF4463PROMain.c,379 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,380 :: 		}
L_vRF4463MainCommandProcessor312:
;DriverRF4463PROMain.c,381 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor313
L_vRF4463MainCommandProcessor308:
;DriverRF4463PROMain.c,385 :: 		else if ( memcmp( CMD_RADIO_MATCH_MASK_1_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_1_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
MOV	R1, SP
MOVS	R2, #11
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_MASK_1_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_MASK_1_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor314
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,386 :: 		ulArgument = StrToLong( ucLongArgument );
MOVS	R1, #32
ADD	R1, SP, R1
MOV	R0, R1
BL	_StrToLong+0
; ulArgument start address is: 8 (R2)
MOV	R2, R0
;DriverRF4463PROMain.c,387 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BLCC	L__vRF4463MainCommandProcessor433
CMP	R2, #255
IT	HI
BLHI	L__vRF4463MainCommandProcessor432
L__vRF4463MainCommandProcessor394:
;DriverRF4463PROMain.c,388 :: 		ucRF4463ByteMask1 = ulArgument;
MOVW	R1, #lo_addr(_ucRF4463ByteMask1+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMask1+0)
STRB	R2, [R1, #0]
; ulArgument end address is: 8 (R2)
;DriverRF4463PROMain.c,389 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,390 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,391 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,392 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor318
;DriverRF4463PROMain.c,387 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor433:
L__vRF4463MainCommandProcessor432:
;DriverRF4463PROMain.c,394 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,395 :: 		}
L_vRF4463MainCommandProcessor318:
;DriverRF4463PROMain.c,396 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor319
L_vRF4463MainCommandProcessor314:
;DriverRF4463PROMain.c,400 :: 		else if ( memcmp( CMD_RADIO_MATCH_MASK_2_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_2_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
MOV	R1, SP
MOVS	R2, #11
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_MASK_2_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_MASK_2_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor320
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,401 :: 		ulArgument = StrToLong( ucLongArgument );
MOVS	R1, #32
ADD	R1, SP, R1
MOV	R0, R1
BL	_StrToLong+0
; ulArgument start address is: 8 (R2)
MOV	R2, R0
;DriverRF4463PROMain.c,402 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BLCC	L__vRF4463MainCommandProcessor435
CMP	R2, #255
IT	HI
BLHI	L__vRF4463MainCommandProcessor434
L__vRF4463MainCommandProcessor393:
;DriverRF4463PROMain.c,403 :: 		ucRF4463ByteMask2 = ulArgument;
MOVW	R1, #lo_addr(_ucRF4463ByteMask2+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMask2+0)
STRB	R2, [R1, #0]
; ulArgument end address is: 8 (R2)
;DriverRF4463PROMain.c,404 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,405 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,406 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,407 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor324
;DriverRF4463PROMain.c,402 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor435:
L__vRF4463MainCommandProcessor434:
;DriverRF4463PROMain.c,409 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,410 :: 		}
L_vRF4463MainCommandProcessor324:
;DriverRF4463PROMain.c,411 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor325
L_vRF4463MainCommandProcessor320:
;DriverRF4463PROMain.c,415 :: 		else if ( memcmp( CMD_RADIO_MATCH_MASK_3_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_3_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
MOV	R1, SP
MOVS	R2, #11
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_MASK_3_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_MASK_3_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor326
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,416 :: 		ulArgument = StrToLong( ucLongArgument );
MOVS	R1, #32
ADD	R1, SP, R1
MOV	R0, R1
BL	_StrToLong+0
; ulArgument start address is: 8 (R2)
MOV	R2, R0
;DriverRF4463PROMain.c,417 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BLCC	L__vRF4463MainCommandProcessor437
CMP	R2, #255
IT	HI
BLHI	L__vRF4463MainCommandProcessor436
L__vRF4463MainCommandProcessor392:
;DriverRF4463PROMain.c,418 :: 		ucRF4463ByteMask3 = ulArgument;
MOVW	R1, #lo_addr(_ucRF4463ByteMask3+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMask3+0)
STRB	R2, [R1, #0]
; ulArgument end address is: 8 (R2)
;DriverRF4463PROMain.c,419 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,420 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,421 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,422 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor330
;DriverRF4463PROMain.c,417 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor437:
L__vRF4463MainCommandProcessor436:
;DriverRF4463PROMain.c,424 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,425 :: 		}
L_vRF4463MainCommandProcessor330:
;DriverRF4463PROMain.c,426 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor331
L_vRF4463MainCommandProcessor326:
;DriverRF4463PROMain.c,430 :: 		else if ( memcmp( CMD_RADIO_MATCH_MASK_4_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_4_SET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
MOV	R1, SP
MOVS	R2, #11
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_MASK_4_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_MASK_4_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor332
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,431 :: 		ulArgument = StrToLong( ucLongArgument );
MOVS	R1, #32
ADD	R1, SP, R1
MOV	R0, R1
BL	_StrToLong+0
; ulArgument start address is: 8 (R2)
MOV	R2, R0
;DriverRF4463PROMain.c,432 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BLCC	L__vRF4463MainCommandProcessor439
CMP	R2, #255
IT	HI
BLHI	L__vRF4463MainCommandProcessor438
L__vRF4463MainCommandProcessor391:
;DriverRF4463PROMain.c,433 :: 		ucRF4463ByteMask4 = ulArgument;
MOVW	R1, #lo_addr(_ucRF4463ByteMask4+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMask4+0)
STRB	R2, [R1, #0]
; ulArgument end address is: 8 (R2)
;DriverRF4463PROMain.c,434 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,435 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,436 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,437 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor336
;DriverRF4463PROMain.c,432 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor439:
L__vRF4463MainCommandProcessor438:
;DriverRF4463PROMain.c,439 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,440 :: 		}
L_vRF4463MainCommandProcessor336:
;DriverRF4463PROMain.c,441 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor337
L_vRF4463MainCommandProcessor332:
;DriverRF4463PROMain.c,445 :: 		else if ( memcmp( CMD_RADIO_MATCH_UNSET, ucCommand, sizeof( CMD_RADIO_MATCH_UNSET ) ) == 0x00 ) {
; ucBuffer start address is: 20 (R5)
MOV	R1, SP
MOVS	R2, #12
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_UNSET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_UNSET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor338
; ucBuffer end address is: 20 (R5)
;DriverRF4463PROMain.c,447 :: 		ucRF4463MatchEnableReg = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,448 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,449 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,454 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor339
L_vRF4463MainCommandProcessor338:
;DriverRF4463PROMain.c,458 :: 		vUSART1Start_TX( ANS_DEBUG_COMMAND_UNKNOWN, strlen( ANS_DEBUG_COMMAND_UNKNOWN ) );
; ucBuffer start address is: 20 (R5)
MOVW	R0, #lo_addr(_ANS_DEBUG_COMMAND_UNKNOWN+0)
MOVT	R0, #hi_addr(_ANS_DEBUG_COMMAND_UNKNOWN+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_DEBUG_COMMAND_UNKNOWN+0)
MOVT	R0, #hi_addr(_ANS_DEBUG_COMMAND_UNKNOWN+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,459 :: 		vUSART1Start_TX( ucBuffer, strlen( ucBuffer ) );  // DEPURACION
MOV	R0, R5
BL	_strlen+0
SXTH	R1, R0
MOV	R0, R5
; ucBuffer end address is: 20 (R5)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,460 :: 		}
L_vRF4463MainCommandProcessor339:
L_vRF4463MainCommandProcessor337:
L_vRF4463MainCommandProcessor331:
L_vRF4463MainCommandProcessor325:
L_vRF4463MainCommandProcessor319:
L_vRF4463MainCommandProcessor313:
L_vRF4463MainCommandProcessor307:
L_vRF4463MainCommandProcessor301:
L_vRF4463MainCommandProcessor295:
L_vRF4463MainCommandProcessor289:
L_vRF4463MainCommandProcessor287:
L_vRF4463MainCommandProcessor271:
L_vRF4463MainCommandProcessor265:
L_vRF4463MainCommandProcessor259:
L_vRF4463MainCommandProcessor243:
L_vRF4463MainCommandProcessor237:
;DriverRF4463PROMain.c,461 :: 		}
L_end_vRF4463MainCommandProcessor:
ADD	SP, SP, #100
POP	(R15)
; end of _vRF4463MainCommandProcessor
_InitTimer2:
;DriverRF4463PROMain.c,467 :: 		void InitTimer2(){
PUSH	(R14)
;DriverRF4463PROMain.c,468 :: 		RCC_APBENR1bits.TIM2EN = 1;
MOVW	R2, #lo_addr(RCC_APBENR1bits+0)
MOVT	R2, #hi_addr(RCC_APBENR1bits+0)
_LX	[R2, ByteOffset(RCC_APBENR1bits+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(RCC_APBENR1bits+0)]
;DriverRF4463PROMain.c,469 :: 		TIM2_CR1.CEN = 0;
MOVW	R2, #lo_addr(TIM2_CR1+0)
MOVT	R2, #hi_addr(TIM2_CR1+0)
_LX	[R2, ByteOffset(TIM2_CR1+0)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(TIM2_CR1+0)]
;DriverRF4463PROMain.c,470 :: 		TIM2_PSC = 249;
MOVS	R1, #249
MOVW	R0, #lo_addr(TIM2_PSC+0)
MOVT	R0, #hi_addr(TIM2_PSC+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,471 :: 		TIM2_ARR = 63999;
MOVW	R1, #63999
MOVT	R1, #0
MOVW	R0, #lo_addr(TIM2_ARR+0)
MOVT	R0, #hi_addr(TIM2_ARR+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,472 :: 		NVIC_IntEnable( IVT_INT_TIM2 );
MOVS	R0, #31
BL	_NVIC_IntEnable+0
;DriverRF4463PROMain.c,473 :: 		TIM2_DIER.UIE = 1;
MOVW	R2, #lo_addr(TIM2_DIER+0)
MOVT	R2, #hi_addr(TIM2_DIER+0)
_LX	[R2, ByteOffset(TIM2_DIER+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(TIM2_DIER+0)]
;DriverRF4463PROMain.c,474 :: 		TIM2_CR1.CEN = 1;
MOVW	R2, #lo_addr(TIM2_CR1+0)
MOVT	R2, #hi_addr(TIM2_CR1+0)
_LX	[R2, ByteOffset(TIM2_CR1+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(TIM2_CR1+0)]
;DriverRF4463PROMain.c,475 :: 		}
L_end_InitTimer2:
POP	(R15)
; end of _InitTimer2
_main:
;DriverRF4463PROMain.c,479 :: 		void main() {
SUB	SP, SP, #60
;DriverRF4463PROMain.c,483 :: 		Delay_ms( 2000 );                    // delay de depuracion
LDR	R7, [PC, #7999999]
NOP
L_main340:
SUBS	R7, R7, #1
BNE	L_main340
B	#4
	#7999999
NOP
;DriverRF4463PROMain.c,486 :: 		GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_6 );  // r   ( Led Rojo de tarjeta de desarrollo )
MOVS	R1, #64
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,487 :: 		GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_7 );  // g
MOVS	R1, #128
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,488 :: 		GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_8 );  // b
MOVS	R1, #255
ADDS	R1, #1
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,489 :: 		GPIO_Digital_Output( &GPIOA_BASE, _GPIO_PINMASK_4 );  // b
MOVS	R1, #16
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,491 :: 		GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_9 );
MOVW	R1, #512
MOVT	R1, #0
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,494 :: 		GPIO_Digital_Input( &GPIOC_BASE, _GPIO_PINMASK_14 );
MOVW	R1, #16384
MOVT	R1, #0
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Input+0
;DriverRF4463PROMain.c,495 :: 		GPIO_Digital_Input( &GPIOC_BASE, _GPIO_PINMASK_15 );
MOVW	R1, #32768
MOVT	R1, #0
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Input+0
;DriverRF4463PROMain.c,500 :: 		GPIO_Digital_Input( &GPIOA_BASE, _GPIO_PINMASK_2 );          // nIRQ
MOVS	R1, #4
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Input+0
;DriverRF4463PROMain.c,502 :: 		GPIO_Digital_Output( &GPIOA_BASE, _GPIO_PINMASK_3 );         // nSEL
MOVS	R1, #8
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,503 :: 		GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_2 );         // SDN
MOVS	R1, #4
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,504 :: 		GPIO_Digital_Output( &GPIOA_BASE, _GPIO_PINMASK_11 );        // GPIO0
MOVW	R1, #2048
MOVT	R1, #0
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,505 :: 		GPIO_Digital_Output( &GPIOA_BASE, _GPIO_PINMASK_12 );        // GPIO1
MOVW	R1, #4096
MOVT	R1, #0
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,507 :: 		_REG_RADIO = 1;
MOVW	R2, #lo_addr(GPIOB_ODR+0)
MOVT	R2, #hi_addr(GPIOB_ODR+0)
_LX	[R2, ByteOffset(GPIOB_ODR+0)]
MOVS	R1, #1
LSLS	R1, R1, #9
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODR+0)]
;DriverRF4463PROMain.c,509 :: 		RCC_APBENR2bits.SYSCFGEN = 1;
MOVW	R2, #lo_addr(RCC_APBENR2bits+0)
MOVT	R2, #hi_addr(RCC_APBENR2bits+0)
_LX	[R2, ByteOffset(RCC_APBENR2bits+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(RCC_APBENR2bits+0)]
;DriverRF4463PROMain.c,511 :: 		SYSCFG_VREFBUF_CFGR1bits.UCPD1_STROBE = 1;
MOVW	R2, #lo_addr(SYSCFG_VREFBUF_CFGR1bits+0)
MOVT	R2, #hi_addr(SYSCFG_VREFBUF_CFGR1bits+0)
_LX	[R2, ByteOffset(SYSCFG_VREFBUF_CFGR1bits+0)]
MOVS	R1, #1
LSLS	R1, R1, #9
ORRS	R0, R1
_SX	[R2, ByteOffset(SYSCFG_VREFBUF_CFGR1bits+0)]
;DriverRF4463PROMain.c,513 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;DriverRF4463PROMain.c,514 :: 		Led_Enable = 1;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #16
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;DriverRF4463PROMain.c,515 :: 		LED_RED      = 1;
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_LX	[R2, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #128
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;DriverRF4463PROMain.c,516 :: 		LED_GREEN    = 1;
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_LX	[R2, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #64
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;DriverRF4463PROMain.c,517 :: 		LED_BLUE     = 1;
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_LX	[R2, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #1
LSLS	R1, R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;DriverRF4463PROMain.c,519 :: 		Delay_ms( 100 );
LDR	R7, [PC, #399999]
NOP
L_main342:
SUBS	R7, R7, #1
BNE	L_main342
B	#4
	#399999
NOP
;DriverRF4463PROMain.c,521 :: 		LED_RED      = 0;
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_LX	[R2, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #128
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;DriverRF4463PROMain.c,522 :: 		LED_GREEN    = 0;
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_LX	[R2, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #64
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;DriverRF4463PROMain.c,523 :: 		LED_BLUE     = 0;
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_LX	[R2, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #1
LSLS	R1, R1, #8
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;DriverRF4463PROMain.c,525 :: 		InitTimer2();
BL	_InitTimer2+0
;DriverRF4463PROMain.c,528 :: 		vUSARTConfigUSART1( 115200 );  // configura todos las parametros de USART
MOVW	R0, #49664
MOVT	R0, #1
BL	_vUSARTConfigUSART1+0
;DriverRF4463PROMain.c,531 :: 		vSPI1Init();           // configura todos los parametros de SPI
BL	_vSPI1Init+0
;DriverRF4463PROMain.c,536 :: 		ucRF4463Freq3 = 9;
MOVS	R1, #9
MOVW	R0, #lo_addr(_ucRF4463Freq3+0)
MOVT	R0, #hi_addr(_ucRF4463Freq3+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,537 :: 		ucRF4463Freq2 = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463Freq2+0)
MOVT	R0, #hi_addr(_ucRF4463Freq2+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,538 :: 		ucRF4463Freq1 = 5;
MOVS	R1, #5
MOVW	R0, #lo_addr(_ucRF4463Freq1+0)
MOVT	R0, #hi_addr(_ucRF4463Freq1+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,541 :: 		ucRF4463Power = 127;            // 34
MOVS	R1, #127
MOVW	R0, #lo_addr(_ucRF4463Power+0)
MOVT	R0, #hi_addr(_ucRF4463Power+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,543 :: 		ucRF4463Rate  = dr_4p8;                // BAUDRATE
MOVS	R1, #2
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,551 :: 		ucRF4463Mode  = slave_mode;          // para transmision continua usar: tx_test_mode
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,553 :: 		ucRF4463FreqChannel = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,557 :: 		reset_mode = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_reset_mode+0)
MOVT	R0, #hi_addr(_reset_mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,562 :: 		vRF4463MainSetTXString();    // usada para establecer el encabezdo predeterminado
BL	_vRF4463MainSetTXString+0
;DriverRF4463PROMain.c,563 :: 		VRF4463SDNReset();
BL	_VRF4463SDNReset+0
;DriverRF4463PROMain.c,564 :: 		vRF4463Init();
BL	_vRF4463Init+0
;DriverRF4463PROMain.c,565 :: 		vRF4463ClearInterrupts();
BL	_vRF4463ClearInterrupts+0
;DriverRF4463PROMain.c,566 :: 		vRF4463PartInfo ();          // SOLICITA EL MODELO DEL RADIO
BL	_vRF4463PartInfo+0
;DriverRF4463PROMain.c,568 :: 		UART1_Write_Text( "[ SYS STM32G ]RF Radio ready\r\n" );
MOVS	R6, #8
ADD	R6, SP, R6
MOVS	R5, #31
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr4_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr4_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #8
ADD	R0, SP, R0
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,571 :: 		while ( 1 ) {
L_main344:
;DriverRF4463PROMain.c,574 :: 		if ( fUSART1Buffer == READY_TO_READ ) {
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BLNE	L_main346
;DriverRF4463PROMain.c,575 :: 		vUSARTReceivedFromUSART1();
BL	_vUSARTReceivedFromUSART1+0
;DriverRF4463PROMain.c,576 :: 		}
L_main346:
;DriverRF4463PROMain.c,587 :: 		if ( ucRF4463Mode == master_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BLNE	L_main347
;DriverRF4463PROMain.c,588 :: 		vRF4463TxData();
BL	_vRF4463TxData+0
;DriverRF4463PROMain.c,589 :: 		}
IT	AL
BLAL	L_main348
L_main347:
;DriverRF4463PROMain.c,592 :: 		else if ( ucRF4463Mode == slave_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BLNE	L_main349
;DriverRF4463PROMain.c,593 :: 		vRF4463RxInit();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,594 :: 		}
IT	AL
BLAL	L_main350
L_main349:
;DriverRF4463PROMain.c,597 :: 		else if ( ucRF4463Mode == rf_off ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BLNE	L_main351
;DriverRF4463PROMain.c,598 :: 		vRF4463RxInit();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,599 :: 		}
L_main351:
L_main350:
L_main348:
;DriverRF4463PROMain.c,602 :: 		if ( ucRF4463Mode == tx_test_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BLNE	L_main352
;DriverRF4463PROMain.c,603 :: 		vRF4463TxCont();
BL	_vRF4463TxCont+0
;DriverRF4463PROMain.c,604 :: 		while ( 1 ) {
L_main353:
;DriverRF4463PROMain.c,606 :: 		if ( fUSART1Buffer == READY_TO_READ ) {
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BLNE	L_main355
;DriverRF4463PROMain.c,607 :: 		break;
IT	AL
BLAL	L_main354
;DriverRF4463PROMain.c,608 :: 		}
L_main355:
;DriverRF4463PROMain.c,610 :: 		if ( !nIRQ ) {
MOVW	R0, #lo_addr(GPIOA_IDRbits+0)
MOVT	R0, #hi_addr(GPIOA_IDRbits+0)
_LX	[R0, ByteOffset(GPIOA_IDRbits+0)]
MOVS	R0, #4
ANDS	R0, R1
LSRS	R0, R0, #2
CMP	R0, #0
IT	NE
BLNE	L_main356
;DriverRF4463PROMain.c,611 :: 		vRF4463TxCont();
BL	_vRF4463TxCont+0
;DriverRF4463PROMain.c,612 :: 		}
L_main356:
;DriverRF4463PROMain.c,613 :: 		}
IT	AL
BLAL	L_main353
L_main354:
;DriverRF4463PROMain.c,614 :: 		}
L_main352:
;DriverRF4463PROMain.c,616 :: 		if ( ucRF4463Mode == rx_test_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BLNE	L_main357
;DriverRF4463PROMain.c,617 :: 		vRF4463RxInit ();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,618 :: 		while ( 1 ) {
L_main358:
;DriverRF4463PROMain.c,620 :: 		if ( fUSART1Buffer == READY_TO_READ ) {
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BLNE	L_main360
;DriverRF4463PROMain.c,621 :: 		break;
IT	AL
BLAL	L_main359
;DriverRF4463PROMain.c,622 :: 		}
L_main360:
;DriverRF4463PROMain.c,625 :: 		}
IT	AL
BLAL	L_main358
L_main359:
;DriverRF4463PROMain.c,626 :: 		}
L_main357:
;DriverRF4463PROMain.c,628 :: 		if ( reset_mode == 0 ) {
MOVW	R0, #lo_addr(_reset_mode+0)
MOVT	R0, #hi_addr(_reset_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BLNE	L_main361
;DriverRF4463PROMain.c,630 :: 		while ( 1 ) {
L_main362:
;DriverRF4463PROMain.c,632 :: 		if ( fUSART1Buffer == READY_TO_READ ) {
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BLNE	L_main364
;DriverRF4463PROMain.c,633 :: 		break;
IT	AL
BLAL	L_main363
;DriverRF4463PROMain.c,634 :: 		}
L_main364:
;DriverRF4463PROMain.c,636 :: 		if ( Flag.reach_1s ) {
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
_LX	[R0, ByteOffset(_Flag+0)]
MOVS	R0, #1
ANDS	R0, R1
LSRS	R0, R0, #0
CMP	R0, #0
IT	EQ
BLEQ	L_main365
;DriverRF4463PROMain.c,637 :: 		Flag.reach_1s = 0;
MOVW	R2, #lo_addr(_Flag+0)
MOVT	R2, #hi_addr(_Flag+0)
_LX	[R2, ByteOffset(_Flag+0)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(_Flag+0)]
;DriverRF4463PROMain.c,638 :: 		if ( ucRF4463Mode == master_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BLNE	L_main366
;DriverRF4463PROMain.c,639 :: 		vRF4463TxData();
BL	_vRF4463TxData+0
;DriverRF4463PROMain.c,640 :: 		}
L_main366:
;DriverRF4463PROMain.c,641 :: 		}
L_main365:
;DriverRF4463PROMain.c,644 :: 		if ( !Flag.is_tx ) {
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
_LX	[R0, ByteOffset(_Flag+0)]
MOVS	R0, #2
ANDS	R0, R1
LSRS	R0, R0, #1
CMP	R0, #0
IT	NE
BLNE	L_main367
;DriverRF4463PROMain.c,645 :: 		if ( !nIRQ ) {          // !nIRQ
MOVW	R0, #lo_addr(GPIOA_IDRbits+0)
MOVT	R0, #hi_addr(GPIOA_IDRbits+0)
_LX	[R0, ByteOffset(GPIOA_IDRbits+0)]
MOVS	R0, #4
ANDS	R0, R1
LSRS	R0, R0, #2
CMP	R0, #0
IT	NE
BLNE	L_main368
;DriverRF4463PROMain.c,646 :: 		vRF4463ClearInterrupts();
BL	_vRF4463ClearInterrupts+0
;DriverRF4463PROMain.c,648 :: 		if ( ( spi_read_buf[ 4 ] & 0x08) == 0 ) { // crc error check
MOVW	R0, #lo_addr(_spi_read_buf+4)
MOVT	R0, #hi_addr(_spi_read_buf+4)
LDRB	R1, [R0, #0]
MOVS	R0, #8
ANDS	R0, R1
UXTB	R0, R0
CMP	R0, #0
IT	NE
BLNE	L_main369
;DriverRF4463PROMain.c,652 :: 		spi_read_fifo();
BL	_spi_read_fifo+0
;DriverRF4463PROMain.c,653 :: 		vRF4463FifoReset();
BL	_vRF4463FifoReset+0
;DriverRF4463PROMain.c,655 :: 		chksum = 0;
MOVS	R0, #0
STR	R0, [SP, #4]
;DriverRF4463PROMain.c,656 :: 		for ( i = 4; i < payload_length - 1; i++ )                // Calculation Checksum
MOVS	R0, #4
STR	R0, [SP, #0]
L_main370:
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, #65
IT	GE
BLGE	L_main371
;DriverRF4463PROMain.c,657 :: 		chksum += rx_buf[ i ];
LDR	R1, [SP, #0]
UXTB	R1, R1
MOVW	R0, #lo_addr(_rx_buf+0)
MOVT	R0, #hi_addr(_rx_buf+0)
ADDS	R0, R0, R1
LDRB	R1, [R0, #0]
LDR	R0, [SP, #4]
UXTB	R0, R0
ADDS	R0, R0, R1
STR	R0, [SP, #4]
;DriverRF4463PROMain.c,656 :: 		for ( i = 4; i < payload_length - 1; i++ )                // Calculation Checksum
LDR	R0, [SP, #0]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #0]
;DriverRF4463PROMain.c,657 :: 		chksum += rx_buf[ i ];
IT	AL
BLAL	L_main370
L_main371:
;DriverRF4463PROMain.c,659 :: 		if ( ( chksum == rx_buf[ payload_length - 1 ] )&&( rx_buf[ 4 ] == 0x41 )) {
MOVW	R0, #lo_addr(_rx_buf+65)
MOVT	R0, #hi_addr(_rx_buf+65)
LDRB	R1, [R0, #0]
LDR	R0, [SP, #4]
UXTB	R0, R0
CMP	R0, R1
IT	NE
BLNE	L__main444
MOVW	R0, #lo_addr(_rx_buf+4)
MOVT	R0, #hi_addr(_rx_buf+4)
LDRB	R0, [R0, #0]
CMP	R0, #65
IT	NE
BLNE	L__main443
L__main442:
;DriverRF4463PROMain.c,668 :: 		UART1_Write_Text( rx_buf );
MOVW	R0, #lo_addr(_rx_buf+0)
MOVT	R0, #hi_addr(_rx_buf+0)
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,669 :: 		UART1_Write_Text("\r\n");
MOVS	R6, #40
ADD	R6, SP, R6
MOVS	R5, #3
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr5_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr5_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #40
ADD	R0, SP, R0
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,672 :: 		LED_GREEN ^= 1;                                        // Data received
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_LX	[R0, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #64
ANDS	R1, R0
LSRS	R1, R1, #6
MOVS	R0, #1
EORS	R0, R1
UXTB	R3, R0
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_LX	[R2, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #1
ANDS	R1, R3
BEQ	L__main507
MOVS	R1, #64
ORRS	R0, R1
B	L__main506
L__main507:
MOVS	R1, #64
BICS	R0, R1
L__main506:
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;DriverRF4463PROMain.c,673 :: 		rx_cnt++;
MOVW	R1, #lo_addr(_rx_cnt+0)
MOVT	R1, #hi_addr(_rx_cnt+0)
LDR	R0, [R1, #0]
ADDS	R0, #1
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,679 :: 		}
IT	AL
BLAL	L_main376
;DriverRF4463PROMain.c,659 :: 		if ( ( chksum == rx_buf[ payload_length - 1 ] )&&( rx_buf[ 4 ] == 0x41 )) {
L__main444:
L__main443:
;DriverRF4463PROMain.c,681 :: 		vRF4463RxInit();    // The received data is wrong, you must continue to receive
BL	_vRF4463RxInit+0
L_main376:
;DriverRF4463PROMain.c,682 :: 		}
IT	AL
BLAL	L_main377
L_main369:
;DriverRF4463PROMain.c,685 :: 		vUSART1Start_TX("[ CRC ] Fail\r\n", 14 );
MOVS	R6, #44
ADD	R6, SP, R6
MOVS	R5, #15
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr6_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr6_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #44
ADD	R0, SP, R0
MOVS	R1, #14
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,686 :: 		VRF4463SDNReset();
BL	_VRF4463SDNReset+0
;DriverRF4463PROMain.c,687 :: 		vRF4463Init();
BL	_vRF4463Init+0
;DriverRF4463PROMain.c,688 :: 		vRF4463RxInit();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,689 :: 		}
L_main377:
;DriverRF4463PROMain.c,690 :: 		}
L_main368:
;DriverRF4463PROMain.c,691 :: 		}
L_main367:
;DriverRF4463PROMain.c,692 :: 		}
IT	AL
BLAL	L_main362
L_main363:
;DriverRF4463PROMain.c,693 :: 		}
L_main361:
;DriverRF4463PROMain.c,694 :: 		}
IT	AL
BLAL	L_main344
;DriverRF4463PROMain.c,695 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
