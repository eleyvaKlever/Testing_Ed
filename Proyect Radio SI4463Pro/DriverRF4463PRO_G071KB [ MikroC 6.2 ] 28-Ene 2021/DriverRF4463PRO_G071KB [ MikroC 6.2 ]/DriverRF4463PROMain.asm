_Int_SPI1:
;driverspi.c,54 :: 		void Int_SPI1() iv IVT_INT_SPI1 ics ICS_AUTO {
PUSH	(R14)
;driverspi.c,56 :: 		if ( SPI1_SRbits.RXNE ) {
MOVW	R0, #lo_addr(SPI1_SRbits+0)
MOVT	R0, #hi_addr(SPI1_SRbits+0)
_LX	[R0, ByteOffset(SPI1_SRbits+0)]
MOVS	R0, #1
ANDS	R0, R1
LSRS	R0, R0, #0
CMP	R0, #0
IT	EQ
BLEQ	L_Int_SPI10
;driverspi.c,57 :: 		ucSPI1ByteReceived = ( unsigned char )SPI1_DR;      // lee el Byte recibido
MOVW	R0, #lo_addr(SPI1_DR+0)
MOVT	R0, #hi_addr(SPI1_DR+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucSPI1ByteReceived+0)
MOVT	R0, #hi_addr(_ucSPI1ByteReceived+0)
STRB	R1, [R0, #0]
;driverspi.c,59 :: 		LED_GREEN = ~LED_GREEN;
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
BEQ	L__Int_SPI1468
MOVS	R1, #64
ORRS	R0, R1
B	L__Int_SPI1467
L__Int_SPI1468:
MOVS	R1, #64
BICS	R0, R1
L__Int_SPI1467:
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;driverspi.c,60 :: 		}
L_Int_SPI10:
;driverspi.c,61 :: 		}
L_end_Int_SPI1:
POP	(R15)
; end of _Int_SPI1
_DMACh1_interrupt:
;driverspi.c,68 :: 		void DMACh1_interrupt() iv IVT_INT_DMA_Channel1 ics ICS_AUTO {
PUSH	(R14)
;driverspi.c,70 :: 		if ( DMA_ISRbits.TEIF3 ) {
MOVW	R0, #lo_addr(DMA_ISRbits+0)
MOVT	R0, #hi_addr(DMA_ISRbits+0)
_LX	[R0, ByteOffset(DMA_ISRbits+0)]
MOVS	R0, #8
ANDS	R0, R1
LSRS	R0, R0, #3
CMP	R0, #0
IT	EQ
BLEQ	L_DMACh1_interrupt1
;driverspi.c,71 :: 		DMA_IFCRbits.CTEIF3 = 1;
MOVW	R2, #lo_addr(DMA_IFCRbits+0)
MOVT	R2, #hi_addr(DMA_IFCRbits+0)
_LX	[R2, ByteOffset(DMA_IFCRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(DMA_IFCRbits+0)]
;driverspi.c,72 :: 		while ( SPI1_SRbits.BSY );
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
;driverspi.c,73 :: 		while ( !SPI1_SRbits.TXE );
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
;driverspi.c,74 :: 		DMA_CCR1bits.EN = 0;
MOVW	R2, #lo_addr(DMA_CCR1bits+0)
MOVT	R2, #hi_addr(DMA_CCR1bits+0)
_LX	[R2, ByteOffset(DMA_CCR1bits+0)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(DMA_CCR1bits+0)]
;driverspi.c,75 :: 		}
L_DMACh1_interrupt1:
;driverspi.c,77 :: 		if ( DMA_ISRbits.TCIF1 ) {     // TRANSFER COMPLETE INTERRUPT FLAG = envio el frame completo
MOVW	R0, #lo_addr(DMA_ISRbits+0)
MOVT	R0, #hi_addr(DMA_ISRbits+0)
_LX	[R0, ByteOffset(DMA_ISRbits+0)]
MOVS	R0, #2
ANDS	R0, R1
LSRS	R0, R0, #1
CMP	R0, #0
IT	EQ
BLEQ	L_DMACh1_interrupt6
;driverspi.c,78 :: 		DMA_IFCRbits.CGIF0 = 1;        // limpia TODOS LOS FLAGS DE DMA
MOVW	R2, #lo_addr(DMA_IFCRbits+0)
MOVT	R2, #hi_addr(DMA_IFCRbits+0)
_LX	[R2, ByteOffset(DMA_IFCRbits+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(DMA_IFCRbits+0)]
;driverspi.c,79 :: 		while ( SPI1_SRbits.BSY );
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
;driverspi.c,80 :: 		while ( !SPI1_SRbits.TXE );
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
;driverspi.c,81 :: 		DMA_CCR1bits.EN = 0;
MOVW	R2, #lo_addr(DMA_CCR1bits+0)
MOVT	R2, #hi_addr(DMA_CCR1bits+0)
_LX	[R2, ByteOffset(DMA_CCR1bits+0)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(DMA_CCR1bits+0)]
;driverspi.c,82 :: 		}
L_DMACh1_interrupt6:
;driverspi.c,84 :: 		if ( DMA_ISRbits.GIF0 ) {
MOVW	R0, #lo_addr(DMA_ISRbits+0)
MOVT	R0, #hi_addr(DMA_ISRbits+0)
_LX	[R0, ByteOffset(DMA_ISRbits+0)]
MOVS	R0, #1
ANDS	R0, R1
LSRS	R0, R0, #0
CMP	R0, #0
IT	EQ
BLEQ	L_DMACh1_interrupt11
;driverspi.c,85 :: 		DMA_IFCRbits.CGIF0 = 1;
MOVW	R2, #lo_addr(DMA_IFCRbits+0)
MOVT	R2, #hi_addr(DMA_IFCRbits+0)
_LX	[R2, ByteOffset(DMA_IFCRbits+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(DMA_IFCRbits+0)]
;driverspi.c,86 :: 		while ( SPI1_SRbits.BSY );
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
;driverspi.c,87 :: 		while ( !SPI1_SRbits.TXE );
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
;driverspi.c,88 :: 		DMA_CCR1bits.EN = 0;
MOVW	R2, #lo_addr(DMA_CCR1bits+0)
MOVT	R2, #hi_addr(DMA_CCR1bits+0)
_LX	[R2, ByteOffset(DMA_CCR1bits+0)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(DMA_CCR1bits+0)]
;driverspi.c,89 :: 		}
L_DMACh1_interrupt11:
;driverspi.c,90 :: 		}
L_end_DMACh1_interrupt:
POP	(R15)
; end of _DMACh1_interrupt
_vRF4463SpiBufferTX:
;driverspi.c,120 :: 		char vRF4463SpiBufferTX ( unsigned long *ucBuffer, unsigned long ulSize ) {
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
;driverspi.c,122 :: 		while ( DMA_CCR1bits.EN || !SPI1_SRbits.TXE );
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
BLNE	L__vRF4463SpiBufferTX405
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
BLEQ	L__vRF4463SpiBufferTX404
IT	AL
BLAL	L_vRF4463SpiBufferTX17
L__vRF4463SpiBufferTX405:
L__vRF4463SpiBufferTX404:
IT	AL
BLAL	L_vRF4463SpiBufferTX16
L_vRF4463SpiBufferTX17:
;driverspi.c,124 :: 		SPI1_CR1bits.SPE = 1;                         // habilita el periferico
MOVW	R4, #lo_addr(SPI1_CR1bits+0)
MOVT	R4, #hi_addr(SPI1_CR1bits+0)
_LX	[R4, ByteOffset(SPI1_CR1bits+0)]
MOVS	R3, #64
ORRS	R2, R3
_SX	[R4, ByteOffset(SPI1_CR1bits+0)]
;driverspi.c,126 :: 		if ( SPI1_CR1bits.SPE && SPI1_SRbits.TXE && ulSize > 0 ) { // la transmision anterior termino?
MOVW	R2, #lo_addr(SPI1_CR1bits+0)
MOVT	R2, #hi_addr(SPI1_CR1bits+0)
_LX	[R2, ByteOffset(SPI1_CR1bits+0)]
MOVS	R2, #64
ANDS	R2, R3
LSRS	R2, R2, #6
CMP	R2, #0
IT	EQ
BLEQ	L__vRF4463SpiBufferTX408
MOVW	R2, #lo_addr(SPI1_SRbits+0)
MOVT	R2, #hi_addr(SPI1_SRbits+0)
_LX	[R2, ByteOffset(SPI1_SRbits+0)]
MOVS	R2, #2
ANDS	R2, R3
LSRS	R2, R2, #1
CMP	R2, #0
IT	EQ
BLEQ	L__vRF4463SpiBufferTX407
CMP	R0, #0
IT	LS
BLLS	L__vRF4463SpiBufferTX406
L__vRF4463SpiBufferTX402:
;driverspi.c,127 :: 		DMA_CCR1bits.EN = 0;                       // Desabilita la recepcion para poder modificar los par?metros
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
;driverspi.c,128 :: 		while ( DMA_CCR1bits.EN );                 // espera a que se haya desabilitado realmente
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
;driverspi.c,130 :: 		DMA_CMAR1 = ( unsigned long ) ucBuffer;    // Direccion de la memoria a rutear
MOVW	R2, #lo_addr(DMA_CMAR1+0)
MOVT	R2, #hi_addr(DMA_CMAR1+0)
STR	R0, [R2, #0]
; ucBuffer end address is: 0 (R0)
;driverspi.c,131 :: 		DMA_CNDTR1 = ulSize;                       // Tamagno de datos a manejar
MOVW	R2, #lo_addr(DMA_CNDTR1+0)
MOVT	R2, #hi_addr(DMA_CNDTR1+0)
STR	R1, [R2, #0]
; ulSize end address is: 4 (R1)
;driverspi.c,132 :: 		DMA_CCR1bits.EN = 1;
MOVW	R4, #lo_addr(DMA_CCR1bits+0)
MOVT	R4, #hi_addr(DMA_CCR1bits+0)
_LX	[R4, ByteOffset(DMA_CCR1bits+0)]
MOVS	R3, #1
ORRS	R2, R3
_SX	[R4, ByteOffset(DMA_CCR1bits+0)]
;driverspi.c,134 :: 		while ( DMA_CNDTR1 > 1 );                  // esperando el fin de la transmision
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
;driverspi.c,136 :: 		while ( SPI1_SRbits.FTLVL != 0 );          // SPI1_SRbits.FTLVL != 0
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
;driverspi.c,138 :: 		while ( SPI1_SRbits.BSY );
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
;driverspi.c,139 :: 		while ( !SPI1_SRbits.TXE );
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
;driverspi.c,141 :: 		DMA_CCR1bits.EN = 0;                       // DEPURACION
MOVW	R4, #lo_addr(DMA_CCR1bits+0)
MOVT	R4, #hi_addr(DMA_CCR1bits+0)
_LX	[R4, ByteOffset(DMA_CCR1bits+0)]
MOVS	R3, #1
BICS	R2, R3
_SX	[R4, ByteOffset(DMA_CCR1bits+0)]
;driverspi.c,143 :: 		return 1;
MOVS	R0, #1
IT	AL
BLAL	L_end_vRF4463SpiBufferTX
;driverspi.c,126 :: 		if ( SPI1_CR1bits.SPE && SPI1_SRbits.TXE && ulSize > 0 ) { // la transmision anterior termino?
L__vRF4463SpiBufferTX408:
L__vRF4463SpiBufferTX407:
L__vRF4463SpiBufferTX406:
;driverspi.c,145 :: 		return 0;
MOVS	R0, #0
;driverspi.c,146 :: 		}
L_end_vRF4463SpiBufferTX:
ADD	SP, SP, #4
POP	(R15)
; end of _vRF4463SpiBufferTX
_vSPI1Init:
;driverspi.c,148 :: 		void vSPI1Init( void ) {
PUSH	(R14)
;driverspi.c,150 :: 		RCC_IOPENRbits.IOPAEN       = 1;      // GPIOA Enabled
MOVW	R2, #lo_addr(RCC_IOPENRbits+0)
MOVT	R2, #hi_addr(RCC_IOPENRbits+0)
_LX	[R2, ByteOffset(RCC_IOPENRbits+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(RCC_IOPENRbits+0)]
;driverspi.c,151 :: 		GPIOA_MODERbits.MODER5      = 2;      // Altern Function
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
;driverspi.c,152 :: 		GPIOA_OTYPERbits.OT5        = 0;      // push pull
MOVW	R2, #lo_addr(GPIOA_OTYPERbits+0)
MOVT	R2, #hi_addr(GPIOA_OTYPERbits+0)
_LX	[R2, ByteOffset(GPIOA_OTYPERbits+0)]
MOVS	R1, #32
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOA_OTYPERbits+0)]
;driverspi.c,153 :: 		GPIOA_OSPEEDRbits.OSPEEDR5  = 0;      // high Speed
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
;driverspi.c,154 :: 		GPIOA_PUPDRbits.PUPDR5      = 0;      // no PU or PD
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
;driverspi.c,155 :: 		GPIOA_AFRLbits.AFSEL5       = 0;      // AF0
MOVW	R0, #lo_addr(GPIOA_AFRLbits+0)
MOVT	R0, #hi_addr(GPIOA_AFRLbits+0)
LDR	R1, [R0, #0]
MOVW	R0, #65535
MOVT	R0, #65295
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOA_AFRLbits+0)
MOVT	R0, #hi_addr(GPIOA_AFRLbits+0)
STR	R1, [R0, #0]
;driverspi.c,157 :: 		GPIOA_MODERbits.MODER6      = 2;      // Altern Function
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
;driverspi.c,158 :: 		GPIOA_OTYPERbits.OT6        = 0;      // push pull
MOVW	R2, #lo_addr(GPIOA_OTYPERbits+0)
MOVT	R2, #hi_addr(GPIOA_OTYPERbits+0)
_LX	[R2, ByteOffset(GPIOA_OTYPERbits+0)]
MOVS	R1, #64
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOA_OTYPERbits+0)]
;driverspi.c,159 :: 		GPIOA_OSPEEDRbits.OSPEEDR6  = 0;      // high Speed
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
;driverspi.c,160 :: 		GPIOA_PUPDRbits.PUPDR6      = 0;      // no PU or PD
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
;driverspi.c,161 :: 		GPIOA_AFRLbits.AFSEL6       = 0;      // AF0
MOVW	R0, #lo_addr(GPIOA_AFRLbits+0)
MOVT	R0, #hi_addr(GPIOA_AFRLbits+0)
LDR	R1, [R0, #0]
MOVW	R0, #65535
MOVT	R0, #61695
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOA_AFRLbits+0)
MOVT	R0, #hi_addr(GPIOA_AFRLbits+0)
STR	R1, [R0, #0]
;driverspi.c,163 :: 		GPIOA_MODERbits.MODER7      = 2;      // Altern Function
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
;driverspi.c,164 :: 		GPIOA_OTYPERbits.OT7        = 0;      // push pull
MOVW	R2, #lo_addr(GPIOA_OTYPERbits+0)
MOVT	R2, #hi_addr(GPIOA_OTYPERbits+0)
_LX	[R2, ByteOffset(GPIOA_OTYPERbits+0)]
MOVS	R1, #128
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOA_OTYPERbits+0)]
;driverspi.c,165 :: 		GPIOA_OSPEEDRbits.OSPEEDR7  = 0;      // high Speed
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
;driverspi.c,166 :: 		GPIOA_PUPDRbits.PUPDR7      = 0;      // no PU or PD
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
;driverspi.c,167 :: 		GPIOA_AFRLbits.AFSEL7       = 0;      // AF0
MOVW	R0, #lo_addr(GPIOA_AFRLbits+0)
MOVT	R0, #hi_addr(GPIOA_AFRLbits+0)
LDR	R1, [R0, #0]
MOVW	R0, #65535
MOVT	R0, #4095
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOA_AFRLbits+0)
MOVT	R0, #hi_addr(GPIOA_AFRLbits+0)
STR	R1, [R0, #0]
;driverspi.c,170 :: 		RCC_APBENR2bits.SPI1EN      = 1;
MOVW	R2, #lo_addr(RCC_APBENR2bits+0)
MOVT	R2, #hi_addr(RCC_APBENR2bits+0)
_LX	[R2, ByteOffset(RCC_APBENR2bits+0)]
MOVS	R1, #1
LSLS	R1, R1, #12
ORRS	R0, R1
_SX	[R2, ByteOffset(RCC_APBENR2bits+0)]
;driverspi.c,172 :: 		SPI1_CR1bits.CPHA           = 0;      // 1 if TI enabled
MOVW	R2, #lo_addr(SPI1_CR1bits+0)
MOVT	R2, #hi_addr(SPI1_CR1bits+0)
_LX	[R2, ByteOffset(SPI1_CR1bits+0)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR1bits+0)]
;driverspi.c,173 :: 		SPI1_CR1bits.CPOL           = 0;
MOVW	R2, #lo_addr(SPI1_CR1bits+0)
MOVT	R2, #hi_addr(SPI1_CR1bits+0)
_LX	[R2, ByteOffset(SPI1_CR1bits+0)]
MOVS	R1, #2
BICS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR1bits+0)]
;driverspi.c,174 :: 		SPI1_CR1bits.LSBFIRST       = 0;
MOVW	R2, #lo_addr(SPI1_CR1bits+0)
MOVT	R2, #hi_addr(SPI1_CR1bits+0)
_LX	[R2, ByteOffset(SPI1_CR1bits+0)]
MOVS	R1, #128
BICS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR1bits+0)]
;driverspi.c,175 :: 		SPI1_CR1bits.SSM            = 1;
MOVW	R2, #lo_addr(SPI1_CR1bits+0)
MOVT	R2, #hi_addr(SPI1_CR1bits+0)
_LX	[R2, ByteOffset(SPI1_CR1bits+0)]
MOVS	R1, #1
LSLS	R1, R1, #9
ORRS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR1bits+0)]
;driverspi.c,176 :: 		SPI1_CR1bits.SSI            = 1;
MOVW	R2, #lo_addr(SPI1_CR1bits+0)
MOVT	R2, #hi_addr(SPI1_CR1bits+0)
_LX	[R2, ByteOffset(SPI1_CR1bits+0)]
MOVS	R1, #1
LSLS	R1, R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR1bits+0)]
;driverspi.c,177 :: 		SPI1_CR1bits.MSTR           = 1;
MOVW	R2, #lo_addr(SPI1_CR1bits+0)
MOVT	R2, #hi_addr(SPI1_CR1bits+0)
_LX	[R2, ByteOffset(SPI1_CR1bits+0)]
MOVS	R1, #4
ORRS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR1bits+0)]
;driverspi.c,178 :: 		SPI1_CR1bits.CRCNEXT        = 0;
MOVW	R2, #lo_addr(SPI1_CR1bits+0)
MOVT	R2, #hi_addr(SPI1_CR1bits+0)
_LX	[R2, ByteOffset(SPI1_CR1bits+0)]
MOVS	R1, #1
LSLS	R1, R1, #12
BICS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR1bits+0)]
;driverspi.c,180 :: 		SPI1_CR2bits.FRF            = 0;
MOVW	R2, #lo_addr(SPI1_CR2bits+0)
MOVT	R2, #hi_addr(SPI1_CR2bits+0)
_LX	[R2, ByteOffset(SPI1_CR2bits+0)]
MOVS	R1, #16
BICS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR2bits+0)]
;driverspi.c,181 :: 		SPI1_CR2bits.DS             = 7;      // 8 bits empaquetado
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
;driverspi.c,182 :: 		SPI1_CR2bits.SSOE           = 0;
MOVW	R2, #lo_addr(SPI1_CR2bits+0)
MOVT	R2, #hi_addr(SPI1_CR2bits+0)
_LX	[R2, ByteOffset(SPI1_CR2bits+0)]
MOVS	R1, #4
BICS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR2bits+0)]
;driverspi.c,183 :: 		SPI1_CR2bits.NSSP           = 1;
MOVW	R2, #lo_addr(SPI1_CR2bits+0)
MOVT	R2, #hi_addr(SPI1_CR2bits+0)
_LX	[R2, ByteOffset(SPI1_CR2bits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR2bits+0)]
;driverspi.c,184 :: 		SPI1_CR2bits.FRXTH          = 1;
MOVW	R2, #lo_addr(SPI1_CR2bits+0)
MOVT	R2, #hi_addr(SPI1_CR2bits+0)
_LX	[R2, ByteOffset(SPI1_CR2bits+0)]
MOVS	R1, #1
LSLS	R1, R1, #12
ORRS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR2bits+0)]
;driverspi.c,185 :: 		SPI1_CR2bits.TXDMAEN        = 1;
MOVW	R2, #lo_addr(SPI1_CR2bits+0)
MOVT	R2, #hi_addr(SPI1_CR2bits+0)
_LX	[R2, ByteOffset(SPI1_CR2bits+0)]
MOVS	R1, #2
ORRS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR2bits+0)]
;driverspi.c,189 :: 		RCC_AHBENRbits.DMAEN        = 1;
MOVW	R2, #lo_addr(RCC_AHBENRbits+0)
MOVT	R2, #hi_addr(RCC_AHBENRbits+0)
_LX	[R2, ByteOffset(RCC_AHBENRbits+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(RCC_AHBENRbits+0)]
;driverspi.c,191 :: 		DMA_CCR1bits.EN = 0;
MOVW	R2, #lo_addr(DMA_CCR1bits+0)
MOVT	R2, #hi_addr(DMA_CCR1bits+0)
_LX	[R2, ByteOffset(DMA_CCR1bits+0)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(DMA_CCR1bits+0)]
;driverspi.c,192 :: 		while ( DMA_CCR1bits.EN );
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
;driverspi.c,194 :: 		PL0_bit = 1;
MOVW	R2, #lo_addr(PL0_bit+0)
MOVT	R2, #hi_addr(PL0_bit+0)
_LX	[R2, ByteOffset(PL0_bit+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(PL0_bit+0)
ORRS	R0, R1
_SX	[R2, ByteOffset(PL0_bit+0)]
;driverspi.c,195 :: 		PL1_bit = 1;
MOVW	R2, #lo_addr(PL1_bit+0)
MOVT	R2, #hi_addr(PL1_bit+0)
_LX	[R2, ByteOffset(PL1_bit+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(PL1_bit+0)
ORRS	R0, R1
_SX	[R2, ByteOffset(PL1_bit+0)]
;driverspi.c,196 :: 		DMA_CCR1bits.MINC           = 1;      // Mem increment
MOVW	R2, #lo_addr(DMA_CCR1bits+0)
MOVT	R2, #hi_addr(DMA_CCR1bits+0)
_LX	[R2, ByteOffset(DMA_CCR1bits+0)]
MOVS	R1, #128
ORRS	R0, R1
_SX	[R2, ByteOffset(DMA_CCR1bits+0)]
;driverspi.c,197 :: 		DMA_CCR1bits.DIR_           = 1;      // Read from Memory
MOVW	R2, #lo_addr(DMA_CCR1bits+0)
MOVT	R2, #hi_addr(DMA_CCR1bits+0)
_LX	[R2, ByteOffset(DMA_CCR1bits+0)]
MOVS	R1, #16
ORRS	R0, R1
_SX	[R2, ByteOffset(DMA_CCR1bits+0)]
;driverspi.c,198 :: 		DMA_CCR1bits.TEIE           = 1;      // Transfer Error Int
MOVW	R2, #lo_addr(DMA_CCR1bits+0)
MOVT	R2, #hi_addr(DMA_CCR1bits+0)
_LX	[R2, ByteOffset(DMA_CCR1bits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(DMA_CCR1bits+0)]
;driverspi.c,199 :: 		DMA_CCR1bits.TCIE           = 1;      // Transfer Complete Int
MOVW	R2, #lo_addr(DMA_CCR1bits+0)
MOVT	R2, #hi_addr(DMA_CCR1bits+0)
_LX	[R2, ByteOffset(DMA_CCR1bits+0)]
MOVS	R1, #2
ORRS	R0, R1
_SX	[R2, ByteOffset(DMA_CCR1bits+0)]
;driverspi.c,201 :: 		DMA_CPAR1 = ( unsigned long ) &SPI1_DR;    // periferico ruteado
MOVW	R1, #lo_addr(SPI1_DR+0)
MOVT	R1, #hi_addr(SPI1_DR+0)
MOVW	R0, #lo_addr(DMA_CPAR1+0)
MOVT	R0, #hi_addr(DMA_CPAR1+0)
STR	R1, [R0, #0]
;driverspi.c,203 :: 		NVIC_IntEnable( IVT_INT_DMA_Channel1 );    // habilitacion de interrupcion
MOVS	R0, #25
BL	_NVIC_IntEnable+0
;driverspi.c,205 :: 		DMAMUX_C0CRbits.DMAREQ_ID = 17;            // TX_SPI1
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
;driverspi.c,207 :: 		SPI1_CR2bits.RXNEIE = 1;                   // habilita interrupcion de recepcion SPI
MOVW	R2, #lo_addr(SPI1_CR2bits+0)
MOVT	R2, #hi_addr(SPI1_CR2bits+0)
_LX	[R2, ByteOffset(SPI1_CR2bits+0)]
MOVS	R1, #64
ORRS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR2bits+0)]
;driverspi.c,209 :: 		NVIC_IntEnable( IVT_INT_SPI1 );
MOVS	R0, #41
BL	_NVIC_IntEnable+0
;driverspi.c,210 :: 		}
L_end_vSPI1Init:
POP	(R15)
; end of _vSPI1Init
_vRF4463ISR:
;driverrf4463pro.c,41 :: 		void vRF4463ISR() iv IVT_INT_EXTI2_3 ics ICS_AUTO{
PUSH	(R14)
;driverrf4463pro.c,42 :: 		if ( EXTI_FPR1bits.FPIF2 ){
MOVW	R0, #lo_addr(EXTI_FPR1bits+0)
MOVT	R0, #hi_addr(EXTI_FPR1bits+0)
_LX	[R0, ByteOffset(EXTI_FPR1bits+0)]
MOVS	R0, #4
ANDS	R0, R1
LSRS	R0, R0, #2
CMP	R0, #0
IT	EQ
BLEQ	L_vRF4463ISR35
;driverrf4463pro.c,43 :: 		EXTI_FPR1bits.FPIF2 = 1;
MOVW	R2, #lo_addr(EXTI_FPR1bits+0)
MOVT	R2, #hi_addr(EXTI_FPR1bits+0)
_LX	[R2, ByteOffset(EXTI_FPR1bits+0)]
MOVS	R1, #4
ORRS	R0, R1
_SX	[R2, ByteOffset(EXTI_FPR1bits+0)]
;driverrf4463pro.c,44 :: 		vRF4463ClearInterrupts();
BL	_vRF4463ClearInterrupts+0
;driverrf4463pro.c,45 :: 		ucRF4463IRQ = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
STRB	R1, [R0, #0]
;driverrf4463pro.c,46 :: 		}
L_vRF4463ISR35:
;driverrf4463pro.c,47 :: 		}
L_end_vRF4463ISR:
POP	(R15)
; end of _vRF4463ISR
_vRF4463Init:
;driverrf4463pro.c,53 :: 		void vRF4463Init ( void ) {  // MODE,
PUSH	(R14)
SUB	SP, SP, #20
;driverrf4463pro.c,56 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init36:
; i start address is: 16 (R4)
CMP	R4, #16
IT	CS
BLCS	L_vRF4463Init37
;driverrf4463pro.c,57 :: 		RF_MODEM_MOD_TYPE_12_data[ i ] = RF_MODEM_MOD_TYPE_12[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,56 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,58 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init36
L_vRF4463Init37:
;driverrf4463pro.c,61 :: 		if ( ucRF4463Freq3 < 8 ) {
MOVW	R0, #lo_addr(_ucRF4463Freq3+0)
MOVT	R0, #hi_addr(_ucRF4463Freq3+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CS
BLCS	L_vRF4463Init39
;driverrf4463pro.c,62 :: 		for ( i = 4; i < 12; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init40:
; i start address is: 12 (R3)
CMP	R3, #12
IT	CS
BLCS	L_vRF4463Init41
;driverrf4463pro.c,63 :: 		RF_MODEM_TX_RAMP_DELAY_8_data[ i ] = RF_MODEM_TX_RAMP_DELAY_8_433[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,62 :: 		for ( i = 4; i < 12; i++ ) {
ADDS	R3, #1
UXTB	R3, R3
;driverrf4463pro.c,64 :: 		}
; i end address is: 12 (R3)
IT	AL
BLAL	L_vRF4463Init40
L_vRF4463Init41:
;driverrf4463pro.c,65 :: 		for ( i = 4; i < 11; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init43:
; i start address is: 16 (R4)
CMP	R4, #11
IT	CS
BLCS	L_vRF4463Init44
;driverrf4463pro.c,66 :: 		RF_MODEM_AFC_GEAR_7_data[ i ] = RF_MODEM_AFC_GEAR_7_433[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,65 :: 		for ( i = 4; i < 11; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,67 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init43
L_vRF4463Init44:
;driverrf4463pro.c,68 :: 		for ( i = 4; i < 15; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init46:
; i start address is: 16 (R4)
CMP	R4, #15
IT	CS
BLCS	L_vRF4463Init47
;driverrf4463pro.c,69 :: 		RF_MODEM_OOK_CNT1_11_data[ i ] = RF_MODEM_OOK_CNT1_11_433[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,68 :: 		for ( i = 4; i < 15; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,70 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init46
L_vRF4463Init47:
;driverrf4463pro.c,71 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init49:
; i start address is: 16 (R4)
CMP	R4, #16
IT	CS
BLCS	L_vRF4463Init50
;driverrf4463pro.c,72 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,71 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,73 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init49
L_vRF4463Init50:
;driverrf4463pro.c,74 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init52:
; i start address is: 16 (R4)
CMP	R4, #16
IT	CS
BLCS	L_vRF4463Init53
;driverrf4463pro.c,75 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,74 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,76 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init52
L_vRF4463Init53:
;driverrf4463pro.c,77 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init55:
; i start address is: 16 (R4)
CMP	R4, #16
IT	CS
BLCS	L_vRF4463Init56
;driverrf4463pro.c,78 :: 		RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,77 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,79 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init55
L_vRF4463Init56:
;driverrf4463pro.c,80 :: 		for ( i = 4; i < 13; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init58:
; i start address is: 16 (R4)
CMP	R4, #13
IT	CS
BLCS	L_vRF4463Init59
;driverrf4463pro.c,81 :: 		RF_MODEM_AGC_WINDOW_SIZE_9_data[ i ] = RF_MODEM_AGC_WINDOW_SIZE_9_433[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,80 :: 		for ( i = 4; i < 13; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,82 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init58
L_vRF4463Init59:
;driverrf4463pro.c,83 :: 		for ( i = 4; i < 13; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init61:
; i start address is: 16 (R4)
CMP	R4, #13
IT	CS
BLCS	L_vRF4463Init62
;driverrf4463pro.c,84 :: 		RF_MODEM_BCR_OSR_1_9_data[ i ] = RF_MODEM_BCR_OSR_1_9_433[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,83 :: 		for ( i = 4; i < 13; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,85 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init61
L_vRF4463Init62:
;driverrf4463pro.c,86 :: 		}
IT	AL
BLAL	L_vRF4463Init64
L_vRF4463Init39:
;driverrf4463pro.c,88 :: 		for ( i = 4; i < 12; i++ ) {
; i start address is: 12 (R3)
MOVS	R3, #4
; i end address is: 12 (R3)
L_vRF4463Init65:
; i start address is: 12 (R3)
CMP	R3, #12
IT	CS
BLCS	L_vRF4463Init66
;driverrf4463pro.c,89 :: 		RF_MODEM_TX_RAMP_DELAY_8_data[ i ] = RF_MODEM_TX_RAMP_DELAY_8_850[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,88 :: 		for ( i = 4; i < 12; i++ ) {
ADDS	R3, #1
UXTB	R3, R3
;driverrf4463pro.c,90 :: 		}
; i end address is: 12 (R3)
IT	AL
BLAL	L_vRF4463Init65
L_vRF4463Init66:
;driverrf4463pro.c,91 :: 		for ( i = 4; i < 11; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init68:
; i start address is: 16 (R4)
CMP	R4, #11
IT	CS
BLCS	L_vRF4463Init69
;driverrf4463pro.c,92 :: 		RF_MODEM_AFC_GEAR_7_data[ i ] = RF_MODEM_AFC_GEAR_7_850[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,91 :: 		for ( i = 4; i < 11; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,93 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init68
L_vRF4463Init69:
;driverrf4463pro.c,94 :: 		for ( i = 4; i < 15; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init71:
; i start address is: 16 (R4)
CMP	R4, #15
IT	CS
BLCS	L_vRF4463Init72
;driverrf4463pro.c,95 :: 		RF_MODEM_OOK_CNT1_11_data[ i ] = RF_MODEM_OOK_CNT1_11_850[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,94 :: 		for ( i = 4; i < 15; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,96 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init71
L_vRF4463Init72:
;driverrf4463pro.c,97 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init74:
; i start address is: 16 (R4)
CMP	R4, #16
IT	CS
BLCS	L_vRF4463Init75
;driverrf4463pro.c,98 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,97 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,99 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init74
L_vRF4463Init75:
;driverrf4463pro.c,100 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init77:
; i start address is: 16 (R4)
CMP	R4, #16
IT	CS
BLCS	L_vRF4463Init78
;driverrf4463pro.c,101 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,100 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,102 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init77
L_vRF4463Init78:
;driverrf4463pro.c,103 :: 		for ( i = 4; i < 16; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init80:
; i start address is: 16 (R4)
CMP	R4, #16
IT	CS
BLCS	L_vRF4463Init81
;driverrf4463pro.c,104 :: 		RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,103 :: 		for ( i = 4; i < 16; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,105 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init80
L_vRF4463Init81:
;driverrf4463pro.c,106 :: 		for ( i = 4; i < 13; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init83:
; i start address is: 16 (R4)
CMP	R4, #13
IT	CS
BLCS	L_vRF4463Init84
;driverrf4463pro.c,107 :: 		RF_MODEM_AGC_WINDOW_SIZE_9_data[ i ] = RF_MODEM_AGC_WINDOW_SIZE_9_850[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,106 :: 		for ( i = 4; i < 13; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,108 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init83
L_vRF4463Init84:
;driverrf4463pro.c,109 :: 		for ( i = 4; i < 13; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init86:
; i start address is: 16 (R4)
CMP	R4, #13
IT	CS
BLCS	L_vRF4463Init87
;driverrf4463pro.c,110 :: 		RF_MODEM_BCR_OSR_1_9_data[ i ] = RF_MODEM_BCR_OSR_1_9_850[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,109 :: 		for ( i = 4; i < 13; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,111 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init86
L_vRF4463Init87:
;driverrf4463pro.c,112 :: 		}
L_vRF4463Init64:
;driverrf4463pro.c,113 :: 		for ( i = 4; i < 11; i++ ) {
; i start address is: 16 (R4)
MOVS	R4, #4
; i end address is: 16 (R4)
L_vRF4463Init89:
; i start address is: 16 (R4)
CMP	R4, #11
IT	CS
BLCS	L_vRF4463Init90
;driverrf4463pro.c,114 :: 		RF_SYNTH_PFDCP_CPFF_7_data[ i ] = RF_SYNTH_PFDCP_CPFF_7[ ucRF4463Rate ][ i - 4 ];
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
;driverrf4463pro.c,113 :: 		for ( i = 4; i < 11; i++ ) {
ADDS	R4, #1
UXTB	R4, R4
;driverrf4463pro.c,115 :: 		}
; i end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463Init89
L_vRF4463Init90:
;driverrf4463pro.c,119 :: 		vRF4463GPIO_SET( ucRF4463Mode );                              // PARAMETRO CONFIGURABLE
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
BL	_vRF4463GPIO_SET+0
;driverrf4463pro.c,122 :: 		ucAppCommandBuf[ 0 ] = 0x11;    // SET PROPERTY
MOV	R2, SP
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,123 :: 		ucAppCommandBuf[ 1 ] = 0x00;    // 0x0000
ADDS	R1, R2, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,124 :: 		ucAppCommandBuf[ 2 ] = 0x01;    // Total 1 Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,125 :: 		ucAppCommandBuf[ 3 ] = 0x00;    // 0x0000
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,126 :: 		ucAppCommandBuf[ 4 ] = 98;      // freq  adjustment    ( rango desde 0 - 127 Low cap - High Cap )
ADDS	R1, R2, #4
MOVS	R0, #98
STRB	R0, [R1, #0]
;driverrf4463pro.c,127 :: 		vSPIWrite( 5, ucAppCommandBuf );
MOV	R1, R2
MOVS	R0, #5
BL	_vSPIWrite+0
;driverrf4463pro.c,130 :: 		ucAppCommandBuf[ 0 ] = 0x11;    // SET PROPERTY
MOV	R2, SP
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,131 :: 		ucAppCommandBuf[ 1 ] = 0x00;    // 0x0003
ADDS	R1, R2, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,132 :: 		ucAppCommandBuf[ 2 ] = 0x01;    // Total 1 Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,133 :: 		ucAppCommandBuf[ 3 ] = 0x03;    // 0x0003
ADDS	R1, R2, #3
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,134 :: 		ucAppCommandBuf[ 4 ] = 0x40;    // tx = rx = 64 byte, ordinary PH,high performance mode  ?????????????????????
ADDS	R1, R2, #4
MOVS	R0, #64
STRB	R0, [R1, #0]
;driverrf4463pro.c,135 :: 		vSPIWrite( 5, ucAppCommandBuf );
MOV	R1, R2
MOVS	R0, #5
BL	_vSPIWrite+0
;driverrf4463pro.c,157 :: 		vSPIWrite( 0x08, RF_FRR_CTL_A_MODE_4_data );    // disable all fast response register
MOVW	R1, #lo_addr(_RF_FRR_CTL_A_MODE_4_data+0)
MOVT	R1, #hi_addr(_RF_FRR_CTL_A_MODE_4_data+0)
MOVS	R0, #8
BL	_vSPIWrite+0
;driverrf4463pro.c,160 :: 		ucAppCommandBuf[ 0 ] = 0x11;    // SET PROPERTY
MOV	R2, SP
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,161 :: 		ucAppCommandBuf[ 1 ] = 0x10;    // 0x1000
ADDS	R1, R2, #1
MOVS	R0, #16
STRB	R0, [R1, #0]
;driverrf4463pro.c,162 :: 		ucAppCommandBuf[ 2 ] = 0x09;    // Total 9 Parameters
ADDS	R1, R2, #2
MOVS	R0, #9
STRB	R0, [R1, #0]
;driverrf4463pro.c,163 :: 		ucAppCommandBuf[ 3 ] = 0x00;    // 0x1000
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,165 :: 		if ( ucRF4463Mode == tx_test_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BLNE	L_vRF4463Init92
;driverrf4463pro.c,166 :: 		ucAppCommandBuf[ 4 ] = 0xff;     //  Need to send 255 bytes of Preamble
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #255
STRB	R0, [R1, #0]
;driverrf4463pro.c,167 :: 		}
IT	AL
BLAL	L_vRF4463Init93
L_vRF4463Init92:
;driverrf4463pro.c,169 :: 		ucAppCommandBuf[ 4 ] = 0x08;   //  Need to send 8 bytes of Preamble
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,170 :: 		}
L_vRF4463Init93:
;driverrf4463pro.c,173 :: 		ucAppCommandBuf[ 5 ]   = 0x14;       // To detect 20 bit sync word,
MOV	R2, SP
ADDS	R1, R2, #5
MOVS	R0, #20
STRB	R0, [R1, #0]
;driverrf4463pro.c,174 :: 		ucAppCommandBuf[ 6 ]   = 0x00;       // Non-standard preamble settings, useless
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,175 :: 		ucAppCommandBuf[ 7 ]   = 0x0f;       // Time of the preamble Timeout   ????????????????????????????????????????????????????????????
ADDS	R1, R2, #7
MOVS	R0, #15
STRB	R0, [R1, #0]
;driverrf4463pro.c,176 :: 		ucAppCommandBuf[ 8 ]   = 0x31;       // The length of the preamble is   byte Calculation , 1st = 1 NO manchest  Encoding, using standard 1010.??
MOV	R1, R2
ADDS	R1, #8
MOVS	R0, #49
STRB	R0, [R1, #0]
;driverrf4463pro.c,177 :: 		ucAppCommandBuf[ 9 ]   = 0x0;        // Non-standard Preamble Patten 4th byte
MOV	R1, R2
ADDS	R1, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,178 :: 		ucAppCommandBuf[ 10 ]  = 0x00;       // Non-standard Preamble Patten 3rd byte
MOV	R1, R2
ADDS	R1, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,179 :: 		ucAppCommandBuf[ 11 ]  = 0x00;       // Non-standard Preamble Patten 2nd byte
MOV	R1, R2
ADDS	R1, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,180 :: 		ucAppCommandBuf[ 12 ]  = 0x00;       // Non-standard Preamble Patten 1st byte
MOV	R1, R2
ADDS	R1, #12
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,181 :: 		vSPIWrite(13, ucAppCommandBuf);
MOV	R1, R2
MOVS	R0, #13
BL	_vSPIWrite+0
;driverrf4463pro.c,184 :: 		ucAppCommandBuf[ 0 ] = 0x11;         // SET PROPERTY
MOV	R2, SP
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,185 :: 		ucAppCommandBuf[ 1 ] = 0x11;         // command = 0x1100
ADDS	R1, R2, #1
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,186 :: 		ucAppCommandBuf[ 2 ] = 0x05;         // Total 5 Parameters
ADDS	R1, R2, #2
MOVS	R0, #5
STRB	R0, [R1, #0]
;driverrf4463pro.c,187 :: 		ucAppCommandBuf[ 3 ] = 0x00;         // command = 0x1100
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,188 :: 		ucAppCommandBuf[ 4 ] = 0x01;         // The synchronization word is defined and sent in the length field, and the synchronization word cannot be wrong,Not 4FSK, not manchest encoding, only 2 bytes
ADDS	R1, R2, #4
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,190 :: 		if ( ucRF4463Mode == tx_test_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BLNE	L_vRF4463Init94
;driverrf4463pro.c,191 :: 		ucAppCommandBuf[ 5 ] = 0x55;      // Sync word 3
MOV	R2, SP
ADDS	R1, R2, #5
MOVS	R0, #85
STRB	R0, [R1, #0]
;driverrf4463pro.c,192 :: 		ucAppCommandBuf[ 6 ] = 0x55;      // Sync word 2
ADDS	R1, R2, #6
MOVS	R0, #85
STRB	R0, [R1, #0]
;driverrf4463pro.c,193 :: 		}
IT	AL
BLAL	L_vRF4463Init95
L_vRF4463Init94:
;driverrf4463pro.c,195 :: 		ucAppCommandBuf[ 5 ] = 0x2d;    // Sync word 3
MOV	R2, SP
ADDS	R1, R2, #5
MOVS	R0, #45
STRB	R0, [R1, #0]
;driverrf4463pro.c,196 :: 		ucAppCommandBuf[ 6 ] = 0xd4;    // Sync word 2
ADDS	R1, R2, #6
MOVS	R0, #212
STRB	R0, [R1, #0]
;driverrf4463pro.c,197 :: 		}
L_vRF4463Init95:
;driverrf4463pro.c,199 :: 		ucAppCommandBuf[ 7 ] = 0x00;         // Sync word 1
MOV	R2, SP
ADDS	R1, R2, #7
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,200 :: 		ucAppCommandBuf[ 8 ] = 0x00;         // Sync word 0
MOV	R1, R2
ADDS	R1, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,201 :: 		vSPIWrite( 9, ucAppCommandBuf );
MOV	R1, R2
MOVS	R0, #9
BL	_vSPIWrite+0
;driverrf4463pro.c,204 :: 		ucAppCommandBuf[ 0 ] = 0x11;        // SET PROPERTY
MOV	R2, SP
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,205 :: 		ucAppCommandBuf[ 1 ] = 0x12;        // command = 0x1200
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,206 :: 		ucAppCommandBuf[ 2 ] = 0x01;        // Total 1 Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,207 :: 		ucAppCommandBuf[ 3 ] = 0x00;        // command = 0x1200
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,208 :: 		ucAppCommandBuf[ 4 ] = 0x85;        // 1?cRC ??,CRC = itu-c, enable crc   ( original 0x81; )
ADDS	R1, R2, #4
MOVS	R0, #133
STRB	R0, [R1, #0]
;driverrf4463pro.c,209 :: 		vSPIWrite( 5, ucAppCommandBuf );
MOV	R1, R2
MOVS	R0, #5
BL	_vSPIWrite+0
;driverrf4463pro.c,212 :: 		ucAppCommandBuf[ 0 ] = 0x11;        // SET PROPERTY
MOV	R2, SP
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,213 :: 		ucAppCommandBuf[ 1 ] = 0x12;        // command = 0x1206
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,214 :: 		ucAppCommandBuf[ 2 ] = 0x01;        // Total 1Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,215 :: 		ucAppCommandBuf[ 3 ] = 0x06;        // command = 0x1206
ADDS	R1, R2, #3
MOVS	R0, #6
STRB	R0, [R1, #0]
;driverrf4463pro.c,216 :: 		ucAppCommandBuf[ 4 ] = 0x02;        //  tx = rx = 120d--1220 (tx packet,ph enable, not 4fsk, After receiving a packet of data,RX off,CRC Do not flip ,CRC MSB, data MSB
ADDS	R1, R2, #4
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,217 :: 		vSPIWrite( 5, ucAppCommandBuf );
MOV	R1, R2
MOVS	R0, #5
BL	_vSPIWrite+0
;driverrf4463pro.c,220 :: 		ucAppCommandBuf[ 0 ] = 0x11;        // SET PROPERTY
MOV	R2, SP
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,221 :: 		ucAppCommandBuf[ 1 ] = 0x12;        // command = 0x1208
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,222 :: 		ucAppCommandBuf[ 2 ] = 0x05;        // Total 3 Parameters
ADDS	R1, R2, #2
MOVS	R0, #5
STRB	R0, [R1, #0]
;driverrf4463pro.c,223 :: 		ucAppCommandBuf[ 3 ] = 0x08;        // command = 0x1208
ADDS	R1, R2, #3
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,224 :: 		ucAppCommandBuf[ 4 ] = 0x02;        // 0x00;        // Length Field = LSB,  length Only 1 byte,length Not put In FiFo, fixed packet length mode
ADDS	R1, R2, #4
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,225 :: 		ucAppCommandBuf[ 5 ] = 0x01;        // 0x00;        // Used for variable packet length mode, which defines which Field contains length Filed
ADDS	R1, R2, #5
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,226 :: 		ucAppCommandBuf[ 6 ] = 0x00;        // Used for variable packet length mode, adjust the length of variable packet length
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,233 :: 		vSPIWrite( 7, ucAppCommandBuf );
MOV	R1, R2
MOVS	R0, #7
BL	_vSPIWrite+0
;driverrf4463pro.c,236 :: 		ucAppCommandBuf[ 0 ]  = 0x11;
MOV	R2, SP
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,237 :: 		ucAppCommandBuf[ 1 ]  = 0x12;   // 0x120d
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,238 :: 		ucAppCommandBuf[ 2 ]  = 0x0c;   // Total 12 Parameters
ADDS	R1, R2, #2
MOVS	R0, #12
STRB	R0, [R1, #0]
;driverrf4463pro.c,239 :: 		ucAppCommandBuf[ 3 ]  = 0x0d;   // 0x120d
ADDS	R1, R2, #3
MOVS	R0, #13
STRB	R0, [R1, #0]
;driverrf4463pro.c,242 :: 		ucAppCommandBuf[ 4 ]  = 0x00;   // 0x0D  // Field 1 length (?4?)                             // 0x0D
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,243 :: 		ucAppCommandBuf[ 5 ]  = payload_length;  // field 1 length, (? 8?), ?Total14???        // 0x0E
ADDS	R1, R2, #5
MOVS	R0, #66
STRB	R0, [R1, #0]
;driverrf4463pro.c,244 :: 		ucAppCommandBuf[ 6 ]  = 0x00;   // 0x0F  // field 1 Is not 4FSK,manchest, whiting, PN9,       // 0x0F
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,245 :: 		ucAppCommandBuf[ 7 ]  = 0xaa;   // 0x10  // field 1 crc enble, check enbale, There are also launchingCRC,cRC?Seed ?CRC_seed?????
ADDS	R1, R2, #7
MOVS	R0, #170
STRB	R0, [R1, #0]
;driverrf4463pro.c,248 :: 		ucAppCommandBuf[ 8 ]  = 0x00;   // 0x11  // field 2 length(?4?)
MOV	R1, R2
ADDS	R1, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,249 :: 		ucAppCommandBuf[ 9 ]  = 0x00;   // 0x12  // field 2 length, (? 8?), length = 0 Means thisfield did not use
MOV	R1, R2
ADDS	R1, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,250 :: 		ucAppCommandBuf[ 10 ] = 0x00;   // 0x13  // field 2 Is not 4FSK,manchest, whiting, PN9
MOV	R1, R2
ADDS	R1, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,251 :: 		ucAppCommandBuf[ 11 ] = 0x00;   // 0x14  // field 2 ?CRCSet up
MOV	R1, R2
ADDS	R1, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,254 :: 		ucAppCommandBuf[ 12 ] = 0x00;   // 0x15  // field 3 length, (? 8?), length = 0 Means thisfield did not use
MOV	R1, R2
ADDS	R1, #12
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,255 :: 		ucAppCommandBuf[ 13 ] = 0x00;   // 0x16  // field 3 length, (? 8?), length = 0 Means thisfield did not use
MOV	R1, R2
ADDS	R1, #13
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,256 :: 		ucAppCommandBuf[ 14 ] = 0x00;   // 0x17  // field 3 Is not 4FSK,manchest, whiting, PN9
MOV	R1, R2
ADDS	R1, #14
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,257 :: 		ucAppCommandBuf[ 15 ] = 0x00;   // 0x18  // field 3 ?CRCSet up
MOV	R1, R2
ADDS	R1, #15
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,258 :: 		vSPIWrite( 16, ucAppCommandBuf );
MOV	R1, R2
MOVS	R0, #16
BL	_vSPIWrite+0
;driverrf4463pro.c,261 :: 		ucAppCommandBuf[ 0 ]  = 0x11;
MOV	R2, SP
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,262 :: 		ucAppCommandBuf[ 1 ]  = 0x12;       // 0x1219
ADDS	R1, R2, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,263 :: 		ucAppCommandBuf[ 2 ]  = 0x08;       // Total 8Parameters
ADDS	R1, R2, #2
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,264 :: 		ucAppCommandBuf[ 3 ]  = 0x19;       // 0x1219
ADDS	R1, R2, #3
MOVS	R0, #25
STRB	R0, [R1, #0]
;driverrf4463pro.c,265 :: 		ucAppCommandBuf[ 4 ]  = 0x00;       // field4 length(?4?)
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,266 :: 		ucAppCommandBuf[ 5 ]  = 0x00;       // field 4 length, (? 8?), length = 0 Means this field did not use
ADDS	R1, R2, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,267 :: 		ucAppCommandBuf[ 6 ]  = 0x00;       // field 4 Is not 4FSK,manchest, whiting, PN9
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,268 :: 		ucAppCommandBuf[ 7 ]  = 0x00;       // field 4 ?CRCSet up
ADDS	R1, R2, #7
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,269 :: 		ucAppCommandBuf[ 8 ]  = 0x00;       // field5 length(?4?)
MOV	R1, R2
ADDS	R1, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,270 :: 		ucAppCommandBuf[ 9 ]  = 0x00;       // field 5 length, (? 8?), length = 0 Means this field did not use
MOV	R1, R2
ADDS	R1, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,271 :: 		ucAppCommandBuf[ 10 ] = 0x00;       // field 5 Is not 4FSK,manchest, whiting, PN9
MOV	R1, R2
ADDS	R1, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,272 :: 		ucAppCommandBuf[ 11 ] = 0x00;       // field 5 ?CRCSet up
MOV	R1, R2
ADDS	R1, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,273 :: 		vSPIWrite( 12, ucAppCommandBuf );
MOV	R1, R2
MOVS	R0, #12
BL	_vSPIWrite+0
;driverrf4463pro.c,276 :: 		vSPIWrite( 0x10, RF_MODEM_MOD_TYPE_12_data );   // //  2FSK ,  module source = PH fifo, disable manchest, tx, rx Do not flip, deviation Do not flip
MOVW	R1, #lo_addr(_RF_MODEM_MOD_TYPE_12_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_MOD_TYPE_12_data+0)
MOVS	R0, #16
BL	_vSPIWrite+0
;driverrf4463pro.c,279 :: 		ucAppCommandBuf[ 0 ]  = 0x11;
MOV	R2, SP
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,280 :: 		ucAppCommandBuf[ 1 ]  = 0x20;    // 0x200c
ADDS	R1, R2, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,281 :: 		ucAppCommandBuf[ 2 ]  = 0x01;    // Total 1Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,282 :: 		ucAppCommandBuf[ 3 ]  = 0x0c;    // 0x200c
ADDS	R1, R2, #3
MOVS	R0, #12
STRB	R0, [R1, #0]
;driverrf4463pro.c,284 :: 		if ( ucRF4463Freq3 < 8 ) {
MOVW	R0, #lo_addr(_ucRF4463Freq3+0)
MOVT	R0, #hi_addr(_ucRF4463Freq3+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CS
BLCS	L_vRF4463Init96
;driverrf4463pro.c,285 :: 		if ( ucRF4463Rate >= dr_256k ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CC
BLCC	L_vRF4463Init97
;driverrf4463pro.c,286 :: 		ucAppCommandBuf[ 4 ] = 0x4f;
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #79
STRB	R0, [R1, #0]
;driverrf4463pro.c,287 :: 		}
IT	AL
BLAL	L_vRF4463Init98
L_vRF4463Init97:
;driverrf4463pro.c,288 :: 		else if ( ucRF4463Rate >= dr_19p2 ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	CC
BLCC	L_vRF4463Init99
;driverrf4463pro.c,289 :: 		ucAppCommandBuf[ 4 ]  = 0x5e;
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #94
STRB	R0, [R1, #0]
;driverrf4463pro.c,290 :: 		}
IT	AL
BLAL	L_vRF4463Init100
L_vRF4463Init99:
;driverrf4463pro.c,292 :: 		ucAppCommandBuf[ 4 ]  = 0xd2;
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #210
STRB	R0, [R1, #0]
;driverrf4463pro.c,293 :: 		}
L_vRF4463Init100:
L_vRF4463Init98:
;driverrf4463pro.c,294 :: 		}
IT	AL
BLAL	L_vRF4463Init101
L_vRF4463Init96:
;driverrf4463pro.c,296 :: 		if ( ucRF4463Rate >= dr_115p2 ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	CC
BLCC	L_vRF4463Init102
;driverrf4463pro.c,297 :: 		ucAppCommandBuf[ 4 ]  = 0x69;        // 15k
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #105
STRB	R0, [R1, #0]
;driverrf4463pro.c,298 :: 		}
IT	AL
BLAL	L_vRF4463Init103
L_vRF4463Init102:
;driverrf4463pro.c,299 :: 		else if ( ucRF4463Rate >= dr_19p2 ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	CC
BLCC	L_vRF4463Init104
;driverrf4463pro.c,300 :: 		ucAppCommandBuf[ 4 ]  = 0x5e;      // 10k
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #94
STRB	R0, [R1, #0]
;driverrf4463pro.c,301 :: 		}
IT	AL
BLAL	L_vRF4463Init105
L_vRF4463Init104:
;driverrf4463pro.c,303 :: 		ucAppCommandBuf[ 4 ]  = 0x18;      // 8k
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #24
STRB	R0, [R1, #0]
;driverrf4463pro.c,304 :: 		}
L_vRF4463Init105:
L_vRF4463Init103:
;driverrf4463pro.c,305 :: 		}
L_vRF4463Init101:
;driverrf4463pro.c,306 :: 		vSPIWrite( 5, ucAppCommandBuf );
MOV	R0, SP
MOV	R1, R0
MOVS	R0, #5
BL	_vSPIWrite+0
;driverrf4463pro.c,309 :: 		vSPIWrite( 0x0C, RF_MODEM_TX_RAMP_DELAY_8_data );            // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
MOVS	R0, #12
BL	_vSPIWrite+0
;driverrf4463pro.c,310 :: 		vSPIWrite( 0x0D, RF_MODEM_BCR_OSR_1_9_data );                // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
MOVS	R0, #13
BL	_vSPIWrite+0
;driverrf4463pro.c,311 :: 		vSPIWrite( 0x0B, RF_MODEM_AFC_GEAR_7_data );                 // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_AFC_GEAR_7_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_AFC_GEAR_7_data+0)
MOVS	R0, #11
BL	_vSPIWrite+0
;driverrf4463pro.c,312 :: 		vSPIWrite( 0x05, RF_MODEM_AGC_CONTROL_1_data );              // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_AGC_CONTROL_1_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_AGC_CONTROL_1_data+0)
MOVS	R0, #5
BL	_vSPIWrite+0
;driverrf4463pro.c,313 :: 		vSPIWrite( 0x0D, RF_MODEM_AGC_WINDOW_SIZE_9_data );          // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
MOVS	R0, #13
BL	_vSPIWrite+0
;driverrf4463pro.c,314 :: 		vSPIWrite( 0x0F, RF_MODEM_OOK_CNT1_11_data );                // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_OOK_CNT1_11_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_OOK_CNT1_11_data+0)
MOVS	R0, #15
BL	_vSPIWrite+0
;driverrf4463pro.c,317 :: 		ucAppCommandBuf[ 0 ] = 0x11;
MOV	R2, SP
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,318 :: 		ucAppCommandBuf[ 1 ] = 0x20;       // 0x204e
ADDS	R1, R2, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,319 :: 		ucAppCommandBuf[ 2 ] = 0x01;       // Total 1Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,320 :: 		ucAppCommandBuf[ 3 ] = 0x4e;       // 0x204e
ADDS	R1, R2, #3
MOVS	R0, #78
STRB	R0, [R1, #0]
;driverrf4463pro.c,322 :: 		if ( ucRF4463Rate == dr_500 ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	NE
BLNE	L_vRF4463Init106
;driverrf4463pro.c,323 :: 		ucAppCommandBuf[ 4 ] = 0x3a;
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #58
STRB	R0, [R1, #0]
;driverrf4463pro.c,324 :: 		}
IT	AL
BLAL	L_vRF4463Init107
L_vRF4463Init106:
;driverrf4463pro.c,326 :: 		ucAppCommandBuf[ 4 ] = 0x40;  //  rssi Reading deviation, the difference with the true value
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #64
STRB	R0, [R1, #0]
;driverrf4463pro.c,327 :: 		}
L_vRF4463Init107:
;driverrf4463pro.c,328 :: 		vSPIWrite( 5, ucAppCommandBuf );
MOV	R0, SP
MOV	R1, R0
MOVS	R0, #5
BL	_vSPIWrite+0
;driverrf4463pro.c,331 :: 		vSPIWrite( 0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data );  // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVS	R0, #16
BL	_vSPIWrite+0
;driverrf4463pro.c,332 :: 		vSPIWrite( 0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data );   // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVS	R0, #16
BL	_vSPIWrite+0
;driverrf4463pro.c,333 :: 		vSPIWrite( 0x10, RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data );   // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVT	R1, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVS	R0, #16
BL	_vSPIWrite+0
;driverrf4463pro.c,336 :: 		ucAppCommandBuf[ 0 ]  = 0x11;
MOV	R2, SP
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,337 :: 		ucAppCommandBuf[ 1 ]  = 0x22;    // 0x2200
ADDS	R1, R2, #1
MOVS	R0, #34
STRB	R0, [R1, #0]
;driverrf4463pro.c,338 :: 		ucAppCommandBuf[ 2 ]  = 0x04;    // Total 4Parameters
ADDS	R1, R2, #2
MOVS	R0, #4
STRB	R0, [R1, #0]
;driverrf4463pro.c,339 :: 		ucAppCommandBuf[ 3 ]  = 0x00;    // 0x2200
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,340 :: 		ucAppCommandBuf[ 4 ]  = 0x08;    //0x10;   //   PA mode  = default , ??Class E mode,?Is not Switch Current mode  ????????
ADDS	R1, R2, #4
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,342 :: 		if ( ucRF4463Power > 0 || ucRF4463Power < 127 ) {
MOVW	R0, #lo_addr(_ucRF4463Power+0)
MOVT	R0, #hi_addr(_ucRF4463Power+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	HI
BLHI	L__vRF4463Init412
MOVW	R0, #lo_addr(_ucRF4463Power+0)
MOVT	R0, #hi_addr(_ucRF4463Power+0)
LDRB	R0, [R0, #0]
CMP	R0, #127
IT	CC
BLCC	L__vRF4463Init411
IT	AL
BLAL	L_vRF4463Init110
L__vRF4463Init412:
L__vRF4463Init411:
;driverrf4463pro.c,343 :: 		ucAppCommandBuf[ 5 ]  = ucRF4463Power;   //  Set to maximum power
MOV	R0, SP
ADDS	R1, R0, #5
MOVW	R0, #lo_addr(_ucRF4463Power+0)
MOVT	R0, #hi_addr(_ucRF4463Power+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,344 :: 		}
IT	AL
BLAL	L_vRF4463Init111
L_vRF4463Init110:
;driverrf4463pro.c,346 :: 		ucAppCommandBuf[ 5 ]  = 127;
MOV	R0, SP
ADDS	R1, R0, #5
MOVS	R0, #127
STRB	R0, [R1, #0]
;driverrf4463pro.c,347 :: 		}
L_vRF4463Init111:
;driverrf4463pro.c,349 :: 		ucAppCommandBuf[ 6 ] = 0x00; //???????? 0x00;   // CLK duty = 50%, other = Default
MOV	R0, SP
ADDS	R1, R0, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,351 :: 		if ( ( ucRF4463Rate <= dr_115p2 )||( ucRF4463Rate == dr_500 ) ) {
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	LS
BLLS	L__vRF4463Init414
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	EQ
BLEQ	L__vRF4463Init413
IT	AL
BLAL	L_vRF4463Init114
L__vRF4463Init414:
L__vRF4463Init413:
;driverrf4463pro.c,352 :: 		ucAppCommandBuf[ 7 ]  = 0x3d;  // ???????? 0x5d;   // PA ramp time = default
MOV	R0, SP
ADDS	R1, R0, #7
MOVS	R0, #61
STRB	R0, [R1, #0]
;driverrf4463pro.c,353 :: 		}
IT	AL
BLAL	L_vRF4463Init115
L_vRF4463Init114:
;driverrf4463pro.c,355 :: 		ucAppCommandBuf[ 7 ]  = 0x5d;
MOV	R0, SP
ADDS	R1, R0, #7
MOVS	R0, #93
STRB	R0, [R1, #0]
;driverrf4463pro.c,356 :: 		}
L_vRF4463Init115:
;driverrf4463pro.c,357 :: 		vSPIWrite( 8, ucAppCommandBuf );
MOV	R0, SP
MOV	R1, R0
MOVS	R0, #8
BL	_vSPIWrite+0
;driverrf4463pro.c,361 :: 		vSPIWrite( 0x0B , RF_SYNTH_PFDCP_CPFF_7_data );      // Without this Parameters,Not needed
MOVW	R1, #lo_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
MOVT	R1, #hi_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
MOVS	R0, #11
BL	_vSPIWrite+0
;driverrf4463pro.c,364 :: 		if ( ucRF4463MatchEnabled ) {
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L_vRF4463Init116
;driverrf4463pro.c,365 :: 		ucAppCommandBuf[ 0 ]  = 0x11;               // SetProperty
MOV	R2, SP
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,366 :: 		ucAppCommandBuf[ 1 ]  = 0x30;               // 0x30 group
ADDS	R1, R2, #1
MOVS	R0, #48
STRB	R0, [R1, #0]
;driverrf4463pro.c,367 :: 		ucAppCommandBuf[ 2 ]  = 0x0c;               // Total 12 Parameters
ADDS	R1, R2, #2
MOVS	R0, #12
STRB	R0, [R1, #0]
;driverrf4463pro.c,368 :: 		ucAppCommandBuf[ 3 ]  = 0x00;               // 0x00 Index
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,369 :: 		ucAppCommandBuf[ 4 ]  = ucRF4463ByteMatch1; // match 1 Value of
ADDS	R1, R2, #4
MOVW	R0, #lo_addr(_ucRF4463ByteMatch1+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch1+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,370 :: 		ucAppCommandBuf[ 5 ]  = ucRF4463ByteMask1;  // match 1 mask
ADDS	R1, R2, #5
MOVW	R0, #lo_addr(_ucRF4463ByteMask1+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask1+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,371 :: 		ucAppCommandBuf[ 6 ]  = ucRF4463MatchEnableReg; //  0x40; // enable match 1, match 1 The distance between the value of and the synchronization word, 0 = match
ADDS	R1, R2, #6
MOVW	R0, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnableReg+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,372 :: 		ucAppCommandBuf[ 7 ]  = ucRF4463ByteMatch2; // match 2 Value of
ADDS	R1, R2, #7
MOVW	R0, #lo_addr(_ucRF4463ByteMatch2+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch2+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,373 :: 		ucAppCommandBuf[ 8 ]  = ucRF4463ByteMask2;  // match 2 mask
MOV	R1, R2
ADDS	R1, #8
MOVW	R0, #lo_addr(_ucRF4463ByteMask2+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask2+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,374 :: 		ucAppCommandBuf[ 9 ]  = 0x01;               // enable match 2, match 2 The distance between the value of and the synchronization word  , and function
MOV	R1, R2
ADDS	R1, #9
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,375 :: 		ucAppCommandBuf[ 10 ] = ucRF4463ByteMatch3; // match 3 Value of
MOV	R1, R2
ADDS	R1, #10
MOVW	R0, #lo_addr(_ucRF4463ByteMatch3+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch3+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,376 :: 		ucAppCommandBuf[ 11 ] = ucRF4463ByteMask3;  // match 3 mask
MOV	R1, R2
ADDS	R1, #11
MOVW	R0, #lo_addr(_ucRF4463ByteMask3+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask3+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,377 :: 		ucAppCommandBuf[ 12 ] = 0x02;               // enable match 3, match 3 The distance between the value of and the synchronization word    and function
MOV	R1, R2
ADDS	R1, #12
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,378 :: 		ucAppCommandBuf[ 13 ] = ucRF4463ByteMatch4; // match 4 Value of
MOV	R1, R2
ADDS	R1, #13
MOVW	R0, #lo_addr(_ucRF4463ByteMatch4+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch4+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,379 :: 		ucAppCommandBuf[ 14 ] = ucRF4463ByteMask4;  // match 4 mask
MOV	R1, R2
ADDS	R1, #14
MOVW	R0, #lo_addr(_ucRF4463ByteMask4+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMask4+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,380 :: 		ucAppCommandBuf[ 15 ] = 0x03;               // enable match 4, match 4 The distance between the value of and the synchronization word    and function
MOV	R1, R2
ADDS	R1, #15
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,381 :: 		vSPIWrite( 16, ucAppCommandBuf );
MOV	R1, R2
MOVS	R0, #16
BL	_vSPIWrite+0
;driverrf4463pro.c,383 :: 		if ( ucRF4463MatchEnableReg == 0x00 ) {
MOVW	R0, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnableReg+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BLNE	L_vRF4463Init117
;driverrf4463pro.c,384 :: 		ucRF4463MatchEnabled = 0;                // deshabilita el Match
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R0, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R1, [R0, #0]
;driverrf4463pro.c,385 :: 		}
L_vRF4463Init117:
;driverrf4463pro.c,404 :: 		}
L_vRF4463Init116:
;driverrf4463pro.c,407 :: 		vRF4463InitFreq();     // FUNCION DE FRECUENCIA ( REVISAR PARAMETROS )
BL	_vRF4463InitFreq+0
;driverrf4463pro.c,408 :: 		}
L_end_vRF4463Init:
ADD	SP, SP, #20
POP	(R15)
; end of _vRF4463Init
_ucRF4463ChecksumGenerator:
;driverrf4463pro.c,412 :: 		char ucRF4463ChecksumGenerator ( unsigned char *ucBuffer ) { //, unsigned char payload_length ) {             //unsigned char ucBufferLenght
; ucBuffer start address is: 0 (R0)
PUSH	(R14)
; ucBuffer end address is: 0 (R0)
; ucBuffer start address is: 0 (R0)
;driverrf4463pro.c,413 :: 		unsigned short ucCounter = 0;
;driverrf4463pro.c,414 :: 		unsigned char ucChecksum = 0;
; ucChecksum start address is: 12 (R3)
MOVS	R3, #0
;driverrf4463pro.c,416 :: 		for ( ucCounter = 0; ucCounter < payload_length ; ucCounter++ ) {
; ucCounter start address is: 8 (R2)
MOVS	R2, #0
; ucChecksum end address is: 12 (R3)
; ucCounter end address is: 8 (R2)
L_ucRF4463ChecksumGenerator118:
; ucCounter start address is: 8 (R2)
; ucChecksum start address is: 12 (R3)
; ucBuffer start address is: 0 (R0)
; ucBuffer end address is: 0 (R0)
CMP	R2, #66
IT	CS
BLCS	L_ucRF4463ChecksumGenerator119
; ucBuffer end address is: 0 (R0)
;driverrf4463pro.c,417 :: 		ucChecksum += ucBuffer[ ucCounter ];
; ucBuffer start address is: 0 (R0)
ADDS	R1, R0, R2
LDRB	R1, [R1, #0]
ADDS	R1, R3, R1
UXTB	R3, R1
;driverrf4463pro.c,416 :: 		for ( ucCounter = 0; ucCounter < payload_length ; ucCounter++ ) {
ADDS	R2, #1
UXTB	R2, R2
;driverrf4463pro.c,418 :: 		}
; ucBuffer end address is: 0 (R0)
; ucCounter end address is: 8 (R2)
IT	AL
BLAL	L_ucRF4463ChecksumGenerator118
L_ucRF4463ChecksumGenerator119:
;driverrf4463pro.c,420 :: 		return ucChecksum;
UXTB	R0, R3
; ucChecksum end address is: 12 (R3)
;driverrf4463pro.c,421 :: 		}
L_end_ucRF4463ChecksumGenerator:
POP	(R15)
; end of _ucRF4463ChecksumGenerator
_vRF4463GPIO_SET:
;driverrf4463pro.c,425 :: 		void vRF4463GPIO_SET( unsigned char ucData ) {
; ucData start address is: 0 (R0)
PUSH	(R14)
SUB	SP, SP, #8
; ucData end address is: 0 (R0)
; ucData start address is: 0 (R0)
;driverrf4463pro.c,428 :: 		ucAppCommandBuf[0] = 0x13;     // gpio Set up
MOV	R2, SP
MOVS	R1, #19
STRB	R1, [R2, #0]
;driverrf4463pro.c,430 :: 		switch ( ucData ) {
IT	AL
BLAL	L_vRF4463GPIO_SET121
; ucData end address is: 0 (R0)
;driverrf4463pro.c,431 :: 		case tx_normal:
L_vRF4463GPIO_SET123:
;driverrf4463pro.c,432 :: 		case rx_normal: ucAppCommandBuf[ 1 ] = 3;                 // GPIO0=1
L_vRF4463GPIO_SET124:
MOV	R3, SP
ADDS	R2, R3, #1
MOVS	R1, #3
STRB	R1, [R2, #0]
;driverrf4463pro.c,433 :: 		ucAppCommandBuf[ 2 ] = 2;                // GPIO1=0
ADDS	R2, R3, #2
MOVS	R1, #2
STRB	R1, [R2, #0]
;driverrf4463pro.c,434 :: 		break;
IT	AL
BLAL	L_vRF4463GPIO_SET122
;driverrf4463pro.c,436 :: 		case tx_test:   ucAppCommandBuf[ 1 ] = 3;                 // GPIO0=1
L_vRF4463GPIO_SET125:
MOV	R3, SP
ADDS	R2, R3, #1
MOVS	R1, #3
STRB	R1, [R2, #0]
;driverrf4463pro.c,437 :: 		ucAppCommandBuf[ 2 ] = 3;                // GPIO1=1
ADDS	R2, R3, #2
MOVS	R1, #3
STRB	R1, [R2, #0]
;driverrf4463pro.c,438 :: 		break;
IT	AL
BLAL	L_vRF4463GPIO_SET122
;driverrf4463pro.c,440 :: 		case rx_test:   ucAppCommandBuf[ 1 ] = 2;                 // GPIO0=0
L_vRF4463GPIO_SET126:
MOV	R3, SP
ADDS	R2, R3, #1
MOVS	R1, #2
STRB	R1, [R2, #0]
;driverrf4463pro.c,441 :: 		ucAppCommandBuf[ 2 ] = 20;                // GPIO1=RX DATA
ADDS	R2, R3, #2
MOVS	R1, #20
STRB	R1, [R2, #0]
;driverrf4463pro.c,442 :: 		break;
IT	AL
BLAL	L_vRF4463GPIO_SET122
;driverrf4463pro.c,444 :: 		case rf_off:    ucAppCommandBuf[ 1 ] = 2;                 // GPIO0=0
L_vRF4463GPIO_SET127:
MOV	R3, SP
ADDS	R2, R3, #1
MOVS	R1, #2
STRB	R1, [R2, #0]
;driverrf4463pro.c,445 :: 		ucAppCommandBuf[ 2 ] = 2;                // GPIO1=0
ADDS	R2, R3, #2
MOVS	R1, #2
STRB	R1, [R2, #0]
;driverrf4463pro.c,446 :: 		break;
IT	AL
BLAL	L_vRF4463GPIO_SET122
;driverrf4463pro.c,447 :: 		}
L_vRF4463GPIO_SET121:
; ucData start address is: 0 (R0)
CMP	R0, #0
IT	EQ
BLEQ	L_vRF4463GPIO_SET123
CMP	R0, #1
IT	EQ
BLEQ	L_vRF4463GPIO_SET124
CMP	R0, #2
IT	EQ
BLEQ	L_vRF4463GPIO_SET125
CMP	R0, #3
IT	EQ
BLEQ	L_vRF4463GPIO_SET126
CMP	R0, #4
IT	EQ
BLEQ	L_vRF4463GPIO_SET127
; ucData end address is: 0 (R0)
L_vRF4463GPIO_SET122:
;driverrf4463pro.c,449 :: 		ucAppCommandBuf[ 3 ]  = 0x21;     //0x20;   //  gpio2, h = tx mode
MOV	R3, SP
ADDS	R2, R3, #3
MOVS	R1, #33
STRB	R1, [R2, #0]
;driverrf4463pro.c,450 :: 		ucAppCommandBuf[ 4 ]  = 0x20;     // 0x14;  //   gpio3
ADDS	R2, R3, #4
MOVS	R1, #32
STRB	R1, [R2, #0]
;driverrf4463pro.c,451 :: 		ucAppCommandBuf[ 5 ]  = 0x27;     // nIRQ
ADDS	R2, R3, #5
MOVS	R1, #39
STRB	R1, [R2, #0]
;driverrf4463pro.c,452 :: 		ucAppCommandBuf[ 6 ]  = 0x0b;     // sdo
ADDS	R2, R3, #6
MOVS	R1, #11
STRB	R1, [R2, #0]
;driverrf4463pro.c,453 :: 		vSPIWrite( 7, ucAppCommandBuf );
MOV	R1, R3
MOVS	R0, #7
BL	_vSPIWrite+0
;driverrf4463pro.c,454 :: 		}
L_end_vRF4463GPIO_SET:
ADD	SP, SP, #8
POP	(R15)
; end of _vRF4463GPIO_SET
_vRF4463FifoReset:
;driverrf4463pro.c,459 :: 		void vRF4463FifoReset( void ) {
PUSH	(R14)
SUB	SP, SP, #4
;driverrf4463pro.c,462 :: 		p[ 0 ] = FIFO_INFO;
MOV	R2, SP
MOVS	R0, #21
STRB	R0, [R2, #0]
;driverrf4463pro.c,463 :: 		p[ 1 ] = 0x03;   // reset tx ,rx fifo
ADDS	R1, R2, #1
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,464 :: 		vSPIWrite( 2, p );
MOV	R1, R2
MOVS	R0, #2
BL	_vSPIWrite+0
;driverrf4463pro.c,465 :: 		}
L_end_vRF4463FifoReset:
ADD	SP, SP, #4
POP	(R15)
; end of _vRF4463FifoReset
_vRF4463GetIntStatus:
;driverrf4463pro.c,468 :: 		void vRF4463GetIntStatus( void ) {
PUSH	(R14)
SUB	SP, SP, #4
;driverrf4463pro.c,471 :: 		p[ 0 ] = GET_INT_STATUS;
MOV	R1, SP
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,475 :: 		vSPIWrite( 1, p );
MOVS	R0, #1
BL	_vSPIWrite+0
;driverrf4463pro.c,476 :: 		vSPIRead( 9, GET_INT_STATUS );
MOVS	R1, #32
MOVS	R0, #9
BL	_vSPIRead+0
;driverrf4463pro.c,477 :: 		}
L_end_vRF4463GetIntStatus:
ADD	SP, SP, #4
POP	(R15)
; end of _vRF4463GetIntStatus
_vRF4463ClearInterrupts:
;driverrf4463pro.c,480 :: 		void vRF4463ClearInterrupts( void ) {
PUSH	(R14)
SUB	SP, SP, #4
;driverrf4463pro.c,483 :: 		p[ 0 ] = GET_INT_STATUS;
MOV	R2, SP
MOVS	R0, #32
STRB	R0, [R2, #0]
;driverrf4463pro.c,484 :: 		p[ 1 ] = 0;               // clr  PH pending
ADDS	R1, R2, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,485 :: 		p[ 2 ] = 0;               // clr modem_pending
ADDS	R1, R2, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,486 :: 		p[ 3 ] = 0;               // clr chip pending
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,487 :: 		vSPIWrite( 4, p );
MOV	R1, R2
MOVS	R0, #4
BL	_vSPIWrite+0
;driverrf4463pro.c,488 :: 		vSPIRead( 9, GET_INT_STATUS );
MOVS	R1, #32
MOVS	R0, #9
BL	_vSPIRead+0
;driverrf4463pro.c,489 :: 		}
L_end_vRF4463ClearInterrupts:
ADD	SP, SP, #4
POP	(R15)
; end of _vRF4463ClearInterrupts
_vRF4463PartInfo:
;driverrf4463pro.c,493 :: 		void vRF4463PartInfo( void ) {  // Solicitud totalmente operativa
PUSH	(R14)
SUB	SP, SP, #12
;driverrf4463pro.c,496 :: 		p[ 0 ] = PART_INFO;
MOV	R1, SP
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,497 :: 		vSPIWrite( 1, p );
MOVS	R0, #1
BL	_vSPIWrite+0
;driverrf4463pro.c,498 :: 		vSPIRead( 9, PART_INFO );
MOVS	R1, #1
MOVS	R0, #9
BL	_vSPIRead+0
;driverrf4463pro.c,499 :: 		}
L_end_vRF4463PartInfo:
ADD	SP, SP, #12
POP	(R15)
; end of _vRF4463PartInfo
_vRF4463EnableRxInterrupt:
;driverrf4463pro.c,502 :: 		void vRF4463EnableRxInterrupt( void ) {
PUSH	(R14)
SUB	SP, SP, #8
;driverrf4463pro.c,505 :: 		p[ 0 ] = 0x11;
MOV	R2, SP
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,506 :: 		p[ 1 ] = 0x01;            // 0x0100
ADDS	R1, R2, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,507 :: 		p[ 2 ] = 0x03;            // 3Parameters
ADDS	R1, R2, #2
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,508 :: 		p[ 3 ] = 0x00;            // 0100
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,509 :: 		p[ 4 ] = 0x03;            // ph, modem int       0x03;
ADDS	R1, R2, #4
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,510 :: 		p[ 5 ] = 0x18;            // 0x10;   // Pack received int
ADDS	R1, R2, #5
MOVS	R0, #24
STRB	R0, [R1, #0]
;driverrf4463pro.c,511 :: 		p[ 6 ] = 0x00;            //preamble int, sync int setting
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,512 :: 		vSPIWrite( 0x07, p );     // enable  packet receive interrupt
MOV	R1, R2
MOVS	R0, #7
BL	_vSPIWrite+0
;driverrf4463pro.c,513 :: 		}
L_end_vRF4463EnableRxInterrupt:
ADD	SP, SP, #8
POP	(R15)
; end of _vRF4463EnableRxInterrupt
_vRF4463EnableTxInterrupt:
;driverrf4463pro.c,518 :: 		void vRF4463EnableTxInterrupt( void ) {
PUSH	(R14)
SUB	SP, SP, #8
;driverrf4463pro.c,521 :: 		p[ 0 ] = 0x11;
MOV	R2, SP
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,522 :: 		p[ 1 ] = 0x01;            // 0x0100
ADDS	R1, R2, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,523 :: 		p[ 2 ] = 0x02;            // 2Parameters
ADDS	R1, R2, #2
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,524 :: 		p[ 3 ] = 0x00;            // 0x0100
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,525 :: 		p[ 4 ] = 0x01;            // Ph  int
ADDS	R1, R2, #4
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,526 :: 		p[ 5 ] = 0x20;            //  enable  packet sent interrupt
ADDS	R1, R2, #5
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,527 :: 		vSPIWrite( 0x06, p );     // enable  packet receive interrupt
MOV	R1, R2
MOVS	R0, #6
BL	_vSPIWrite+0
;driverrf4463pro.c,528 :: 		}
L_end_vRF4463EnableTxInterrupt:
ADD	SP, SP, #8
POP	(R15)
; end of _vRF4463EnableTxInterrupt
_vRF4463RfStandby:
;driverrf4463pro.c,533 :: 		void vRF4463RfStandby( void ) {
PUSH	(R14)
SUB	SP, SP, #4
;driverrf4463pro.c,536 :: 		p[ 0 ] = CHANGE_STATE ;   // CHANGE_STATE Command
MOV	R2, SP
MOVS	R0, #52
STRB	R0, [R2, #0]
;driverrf4463pro.c,537 :: 		p[ 1 ] = 0x01 ;           // sleep mode
ADDS	R1, R2, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,538 :: 		vSPIWrite( 2, p );
MOV	R1, R2
MOVS	R0, #2
BL	_vSPIWrite+0
;driverrf4463pro.c,539 :: 		}
L_end_vRF4463RfStandby:
ADD	SP, SP, #4
POP	(R15)
; end of _vRF4463RfStandby
_vRF4463TxStart:
;driverrf4463pro.c,544 :: 		void vRF4463TxStart( void ) {
PUSH	(R14)
SUB	SP, SP, #8
;driverrf4463pro.c,547 :: 		p[ 0 ] = START_TX ;              // start Command
MOV	R2, SP
MOVS	R0, #49
STRB	R0, [R2, #0]
;driverrf4463pro.c,548 :: 		p[ 1 ] = ucRF4463FreqChannel;    // channel 1 default
ADDS	R1, R2, #1
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,549 :: 		p[ 2 ] = 0x30;                   // Back after launch Readymode, Do not retransmit, launch immediately
ADDS	R1, R2, #2
MOVS	R0, #48
STRB	R0, [R1, #0]
;driverrf4463pro.c,550 :: 		p[ 3 ] = 0;
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,551 :: 		p[ 4 ] = 0;                      // payload_length; // Total to transmit 10 bytes
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,552 :: 		vSPIWrite( 5, p );
MOV	R1, R2
MOVS	R0, #5
BL	_vSPIWrite+0
;driverrf4463pro.c,553 :: 		}
L_end_vRF4463TxStart:
ADD	SP, SP, #8
POP	(R15)
; end of _vRF4463TxStart
_vRF4463RxStart:
;driverrf4463pro.c,558 :: 		void vRF4463RxStart( void ) {
PUSH	(R14)
SUB	SP, SP, #8
;driverrf4463pro.c,561 :: 		p[ 0 ] = START_RX ;              // start Command
MOV	R2, SP
MOVS	R0, #50
STRB	R0, [R2, #0]
;driverrf4463pro.c,562 :: 		p[ 1 ] = ucRF4463FreqChannel;    // channel 0
ADDS	R1, R2, #1
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,563 :: 		p[ 2 ] = 0x00;                   // Enter receiving mode immediately
ADDS	R1, R2, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,564 :: 		p[ 3 ] = 0;
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,565 :: 		p[ 4 ] = 0;                      // payload_length; // Total to receive 10 bytes
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,566 :: 		p[ 5 ] = 1;                      // unchanged after preamble timeout
ADDS	R1, R2, #5
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,569 :: 		p[ 6 ] = 0x01;
ADDS	R1, R2, #6
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,570 :: 		p[ 7 ] = 0x08;
ADDS	R1, R2, #7
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,571 :: 		vSPIWrite( 8, p );
MOV	R1, R2
MOVS	R0, #8
BL	_vSPIWrite+0
;driverrf4463pro.c,572 :: 		}
L_end_vRF4463RxStart:
ADD	SP, SP, #8
POP	(R15)
; end of _vRF4463RxStart
_vRF4463RxStartTest:
;driverrf4463pro.c,577 :: 		void vRF4463RxStartTest( void ) {
PUSH	(R14)
SUB	SP, SP, #8
;driverrf4463pro.c,580 :: 		LED_GREEN = 1;
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_LX	[R2, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #64
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,582 :: 		p[ 0 ] = START_RX;        // start Command
MOV	R2, SP
MOVS	R0, #50
STRB	R0, [R2, #0]
;driverrf4463pro.c,583 :: 		p[ 1 ] = ucRF4463FreqChannel;    // channel 0
ADDS	R1, R2, #1
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,584 :: 		p[ 2 ] = 0x00;            // Enter receiving mode immediately
ADDS	R1, R2, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,585 :: 		p[ 3 ] = 0;
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,587 :: 		p[ 4 ] = 0;
ADDS	R1, R2, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,588 :: 		p[ 5 ] = 0;               // unchanged after preamble timeout
ADDS	R1, R2, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,591 :: 		p[ 6 ] = 0x08;
ADDS	R1, R2, #6
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,592 :: 		p[ 7 ] = 0x08;
ADDS	R1, R2, #7
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,593 :: 		vSPIWrite( 8, p );
MOV	R1, R2
MOVS	R0, #8
BL	_vSPIWrite+0
;driverrf4463pro.c,594 :: 		}
L_end_vRF4463RxStartTest:
ADD	SP, SP, #8
POP	(R15)
; end of _vRF4463RxStartTest
_vRF4463RxInit:
;driverrf4463pro.c,599 :: 		void vRF4463RxInit( void ) {
PUSH	(R14)
;driverrf4463pro.c,600 :: 		Flag.is_tx = 0;
MOVW	R2, #lo_addr(_Flag+0)
MOVT	R2, #hi_addr(_Flag+0)
_LX	[R2, ByteOffset(_Flag+0)]
MOVS	R1, #2
BICS	R0, R1
_SX	[R2, ByteOffset(_Flag+0)]
;driverrf4463pro.c,601 :: 		vRF4463FifoReset();           // fifo_reset();  // Buffer empty
BL	_vRF4463FifoReset+0
;driverrf4463pro.c,602 :: 		vRF4463EnableRxInterrupt();   // enable_rx_interrupt();
BL	_vRF4463EnableRxInterrupt+0
;driverrf4463pro.c,603 :: 		vRF4463ClearInterrupts();      // clr_interrupt();  // Clear interrupt factor
BL	_vRF4463ClearInterrupts+0
;driverrf4463pro.c,605 :: 		if ( ucRF4463Mode == rx_test_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BLNE	L_vRF4463RxInit128
;driverrf4463pro.c,606 :: 		vRF4463RxStartTest();      // rx_start_test();
BL	_vRF4463RxStartTest+0
;driverrf4463pro.c,607 :: 		}
IT	AL
BLAL	L_vRF4463RxInit129
L_vRF4463RxInit128:
;driverrf4463pro.c,609 :: 		vRF4463RxStart();        // rx_start();    // Enter receiving mode, after receiving data, return to Readymode
BL	_vRF4463RxStart+0
;driverrf4463pro.c,610 :: 		}
L_vRF4463RxInit129:
;driverrf4463pro.c,611 :: 		}
L_end_vRF4463RxInit:
POP	(R15)
; end of _vRF4463RxInit
_vRF4463TxData:
;driverrf4463pro.c,616 :: 		void vRF4463TxData( void ) {
PUSH	(R14)
SUB	SP, SP, #20
;driverrf4463pro.c,619 :: 		ucRF4463IRQ = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
STRB	R1, [R0, #0]
;driverrf4463pro.c,621 :: 		Flag.is_tx = 1;
MOVW	R2, #lo_addr(_Flag+0)
MOVT	R2, #hi_addr(_Flag+0)
_LX	[R2, ByteOffset(_Flag+0)]
MOVS	R1, #2
ORRS	R0, R1
_SX	[R2, ByteOffset(_Flag+0)]
;driverrf4463pro.c,622 :: 		LED_RED ^= 1;
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_LX	[R0, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #128
ANDS	R1, R0
LSRS	R1, R1, #7
MOVS	R0, #1
EORS	R0, R1
UXTB	R3, R0
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_LX	[R2, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #1
ANDS	R1, R3
BEQ	L__vRF4463TxData489
MOVS	R1, #128
ORRS	R0, R1
B	L__vRF4463TxData488
L__vRF4463TxData489:
MOVS	R1, #128
BICS	R0, R1
L__vRF4463TxData488:
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,623 :: 		Delay_ms( 30 );
LDR	R7, [PC, #119999]
NOP
L_vRF4463TxData130:
SUBS	R7, R7, #1
BNE	L_vRF4463TxData130
B	#4
	#119999
NOP
;driverrf4463pro.c,624 :: 		LED_RED ^= 1;
MOVW	R0, #lo_addr(GPIOB_ODRbits+0)
MOVT	R0, #hi_addr(GPIOB_ODRbits+0)
_LX	[R0, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #128
ANDS	R1, R0
LSRS	R1, R1, #7
MOVS	R0, #1
EORS	R0, R1
UXTB	R3, R0
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_LX	[R2, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #1
ANDS	R1, R3
BEQ	L__vRF4463TxData491
MOVS	R1, #128
ORRS	R0, R1
B	L__vRF4463TxData490
L__vRF4463TxData491:
MOVS	R1, #128
BICS	R0, R1
L__vRF4463TxData490:
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,625 :: 		vRF4463FifoReset();            // fifo_reset();  // Buffer empty
BL	_vRF4463FifoReset+0
;driverrf4463pro.c,626 :: 		vSPIWriteFifo();               // Fill the buffer with data
BL	_vSPIWriteFifo+0
;driverrf4463pro.c,627 :: 		vRF4463EnableTxInterrupt();    // enable_tx_interrupt();
BL	_vRF4463EnableTxInterrupt+0
;driverrf4463pro.c,628 :: 		vRF4463ClearInterrupts();       // clr_interrupt();  // Clear interrupt factor
BL	_vRF4463ClearInterrupts+0
;driverrf4463pro.c,629 :: 		vRF4463TxStart();              // tx_start();    // Enter launch mode, start launch
BL	_vRF4463TxStart+0
;driverrf4463pro.c,632 :: 		Flag.rf_reach_timeout = 0;
MOVW	R2, #lo_addr(_Flag+0)
MOVT	R2, #hi_addr(_Flag+0)
_LX	[R2, ByteOffset(_Flag+0)]
MOVS	R1, #4
BICS	R0, R1
_SX	[R2, ByteOffset(_Flag+0)]
;driverrf4463pro.c,634 :: 		if ( ucRF4463IRQ ) {
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L_vRF4463TxData132
;driverrf4463pro.c,635 :: 		UART1_Write_Text( "[ UART1 ] TX INT\r\n" );
MOV	R6, SP
MOVS	R5, #19
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr1_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr1_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOV	R0, SP
BL	_UART1_Write_Text+0
;driverrf4463pro.c,636 :: 		}
L_vRF4463TxData132:
;driverrf4463pro.c,639 :: 		while ( nIRQ ) {     //nIRQ
L_vRF4463TxData133:
MOVW	R0, #lo_addr(GPIOA_IDRbits+0)
MOVT	R0, #hi_addr(GPIOA_IDRbits+0)
_LX	[R0, ByteOffset(GPIOA_IDRbits+0)]
MOVS	R0, #4
ANDS	R0, R1
LSRS	R0, R0, #2
CMP	R0, #0
IT	EQ
BLEQ	L_vRF4463TxData134
;driverrf4463pro.c,642 :: 		if ( Flag.rf_reach_timeout ) {
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
_LX	[R0, ByteOffset(_Flag+0)]
MOVS	R0, #4
ANDS	R0, R1
LSRS	R0, R0, #2
CMP	R0, #0
IT	EQ
BLEQ	L_vRF4463TxData135
;driverrf4463pro.c,643 :: 		vRF4463SDNReset();
BL	_vRF4463SDNReset+0
;driverrf4463pro.c,644 :: 		vRF4463Init();        //SI4463_init();  // RF Module initialization
BL	_vRF4463Init+0
;driverrf4463pro.c,645 :: 		break;                // Forced out
IT	AL
BLAL	L_vRF4463TxData134
;driverrf4463pro.c,646 :: 		}
L_vRF4463TxData135:
;driverrf4463pro.c,647 :: 		}
IT	AL
BLAL	L_vRF4463TxData133
L_vRF4463TxData134:
;driverrf4463pro.c,649 :: 		tx_cnt++;
MOVW	R1, #lo_addr(_tx_cnt+0)
MOVT	R1, #hi_addr(_tx_cnt+0)
LDR	R0, [R1, #0]
ADDS	R0, #1
STR	R0, [R1, #0]
;driverrf4463pro.c,651 :: 		vRF4463RxInit();          // rx_init();                //rf After the transmission is completed, enter the receiving mode
BL	_vRF4463RxInit+0
;driverrf4463pro.c,652 :: 		}
L_end_vRF4463TxData:
ADD	SP, SP, #20
POP	(R15)
; end of _vRF4463TxData
_vRF4463TxCont:
;driverrf4463pro.c,657 :: 		void vRF4463TxCont( void ) {
PUSH	(R14)
;driverrf4463pro.c,660 :: 		LED_RED = 1;
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_LX	[R2, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #128
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,661 :: 		vRF4463FifoReset();                     //  fifo_reset();  // Buffer empty
BL	_vRF4463FifoReset+0
;driverrf4463pro.c,662 :: 		vSPIWriteFifo();                        // Fill the buffer with data
BL	_vSPIWriteFifo+0
;driverrf4463pro.c,663 :: 		vRF4463EnableTxInterrupt();             //  enable_tx_interrupt();
BL	_vRF4463EnableTxInterrupt+0
;driverrf4463pro.c,664 :: 		vRF4463ClearInterrupts();               //  clr_interrupt();  // Clear interrupt factor
BL	_vRF4463ClearInterrupts+0
;driverrf4463pro.c,665 :: 		vRF4463TxStart();                       //  tx_start();    // Enter launch mode, start launch
BL	_vRF4463TxStart+0
;driverrf4463pro.c,667 :: 		Flag.rf_reach_timeout = 0;
MOVW	R2, #lo_addr(_Flag+0)
MOVT	R2, #hi_addr(_Flag+0)
_LX	[R2, ByteOffset(_Flag+0)]
MOVS	R1, #4
BICS	R0, R1
_SX	[R2, ByteOffset(_Flag+0)]
;driverrf4463pro.c,669 :: 		ucRF4463IRQ = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
STRB	R1, [R0, #0]
;driverrf4463pro.c,672 :: 		while( nIRQ ) {          //nIRQ ) {
L_vRF4463TxCont136:
MOVW	R0, #lo_addr(GPIOA_IDRbits+0)
MOVT	R0, #hi_addr(GPIOA_IDRbits+0)
_LX	[R0, ByteOffset(GPIOA_IDRbits+0)]
MOVS	R0, #4
ANDS	R0, R1
LSRS	R0, R0, #2
CMP	R0, #0
IT	EQ
BLEQ	L_vRF4463TxCont137
;driverrf4463pro.c,680 :: 		}
IT	AL
BLAL	L_vRF4463TxCont136
L_vRF4463TxCont137:
;driverrf4463pro.c,681 :: 		}
L_end_vRF4463TxCont:
POP	(R15)
; end of _vRF4463TxCont
_vRF4463InitFreq:
;driverrf4463pro.c,686 :: 		void vRF4463InitFreq ( void ) {
PUSH	(R14)
SUB	SP, SP, #36
;driverrf4463pro.c,692 :: 		ulFrequency = ( ucRF4463Freq3 * 100 ) + ( ucRF4463Freq2 * 10 ) + ucRF4463Freq1;
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
;driverrf4463pro.c,694 :: 		ulFrequency = ( ulFrequency * 10000 );
MOVW	R0, #10000
MOVT	R0, #0
MOV	R1, R0
MULS	R1, R2, R1
MOV	R2, R1
;driverrf4463pro.c,697 :: 		if ( ulFrequency >= 7600000 ) {
MOVW	R0, #63360
MOVT	R0, #115
CMP	R1, R0
IT	CC
BLCC	L_vRF4463InitFreq138
;driverrf4463pro.c,698 :: 		ucOUTDIV = 4;
; ucOUTDIV start address is: 4 (R1)
MOVS	R1, #4
;driverrf4463pro.c,699 :: 		ucBAND = 0;
; ucBAND start address is: 28 (R7)
MOVS	R7, #0
;driverrf4463pro.c,700 :: 		ucVCO = 0xFF;
; ucVCO start address is: 24 (R6)
MOVS	R6, #255
;driverrf4463pro.c,701 :: 		}
; ucVCO end address is: 24 (R6)
; ucBAND end address is: 28 (R7)
; ucOUTDIV end address is: 4 (R1)
IT	AL
BLAL	L_vRF4463InitFreq139
L_vRF4463InitFreq138:
;driverrf4463pro.c,704 :: 		else if ( ulFrequency >= 5460000 ) {
MOVW	R0, #20512
MOVT	R0, #83
CMP	R2, R0
IT	CC
BLCC	L_vRF4463InitFreq140
;driverrf4463pro.c,705 :: 		ucOUTDIV = 6;
; ucOUTDIV start address is: 4 (R1)
MOVS	R1, #6
;driverrf4463pro.c,706 :: 		ucBAND   = 1;
; ucBAND start address is: 28 (R7)
MOVS	R7, #1
;driverrf4463pro.c,707 :: 		ucVCO    = 0xFE;
; ucVCO start address is: 24 (R6)
MOVS	R6, #254
;driverrf4463pro.c,708 :: 		}
; ucVCO end address is: 24 (R6)
; ucBAND end address is: 28 (R7)
; ucOUTDIV end address is: 4 (R1)
IT	AL
BLAL	L_vRF4463InitFreq141
L_vRF4463InitFreq140:
;driverrf4463pro.c,711 :: 		else if ( ulFrequency >= 3850000 ) {
MOVW	R0, #48912
MOVT	R0, #58
CMP	R2, R0
IT	CC
BLCC	L_vRF4463InitFreq142
;driverrf4463pro.c,712 :: 		ucOUTDIV = 8;
; ucOUTDIV start address is: 0 (R0)
MOVS	R0, #8
;driverrf4463pro.c,713 :: 		ucBAND   = 2;
; ucBAND start address is: 12 (R3)
MOVS	R3, #2
;driverrf4463pro.c,714 :: 		ucVCO    = 0xFE;
; ucVCO start address is: 24 (R6)
MOVS	R6, #254
;driverrf4463pro.c,715 :: 		}
UXTB	R1, R0
; ucOUTDIV end address is: 0 (R0)
; ucBAND end address is: 12 (R3)
; ucVCO end address is: 24 (R6)
UXTB	R7, R3
IT	AL
BLAL	L_vRF4463InitFreq143
L_vRF4463InitFreq142:
;driverrf4463pro.c,718 :: 		else if ( ulFrequency >= 2730000 ) {
MOVW	R0, #43024
MOVT	R0, #41
CMP	R2, R0
IT	CC
BLCC	L_vRF4463InitFreq144
;driverrf4463pro.c,719 :: 		ucOUTDIV = 12;
; ucOUTDIV start address is: 4 (R1)
MOVS	R1, #12
;driverrf4463pro.c,720 :: 		ucBAND   = 3;
; ucBAND start address is: 12 (R3)
MOVS	R3, #3
;driverrf4463pro.c,721 :: 		ucVCO    = 0xFD;
; ucVCO start address is: 0 (R0)
MOVS	R0, #253
;driverrf4463pro.c,722 :: 		}
UXTB	R6, R0
; ucVCO end address is: 0 (R0)
; ucBAND end address is: 12 (R3)
; ucOUTDIV end address is: 4 (R1)
IT	AL
BLAL	L_vRF4463InitFreq145
L_vRF4463InitFreq144:
;driverrf4463pro.c,725 :: 		else if ( ulFrequency >= 1940000 ) {
MOVW	R0, #39456
MOVT	R0, #29
CMP	R2, R0
IT	CC
BLCC	L_vRF4463InitFreq146
;driverrf4463pro.c,726 :: 		ucOUTDIV = 16;
; ucOUTDIV start address is: 4 (R1)
MOVS	R1, #16
;driverrf4463pro.c,727 :: 		ucBAND   = 4;
; ucBAND start address is: 12 (R3)
MOVS	R3, #4
;driverrf4463pro.c,728 :: 		ucVCO    = 0xFC;
; ucVCO start address is: 0 (R0)
MOVS	R0, #252
;driverrf4463pro.c,729 :: 		}
; ucVCO end address is: 0 (R0)
; ucBAND end address is: 12 (R3)
; ucOUTDIV end address is: 4 (R1)
IT	AL
BLAL	L_vRF4463InitFreq147
L_vRF4463InitFreq146:
;driverrf4463pro.c,733 :: 		ucOUTDIV = 24;
; ucOUTDIV start address is: 4 (R1)
MOVS	R1, #24
;driverrf4463pro.c,734 :: 		ucBAND   = 5;
; ucBAND start address is: 12 (R3)
MOVS	R3, #5
;driverrf4463pro.c,735 :: 		ucVCO    = 0xFA;
; ucVCO start address is: 0 (R0)
MOVS	R0, #250
; ucVCO end address is: 0 (R0)
; ucBAND end address is: 12 (R3)
; ucOUTDIV end address is: 4 (R1)
;driverrf4463pro.c,736 :: 		}
L_vRF4463InitFreq147:
; ucVCO start address is: 0 (R0)
; ucBAND start address is: 12 (R3)
; ucOUTDIV start address is: 4 (R1)
UXTB	R6, R0
; ucVCO end address is: 0 (R0)
; ucBAND end address is: 12 (R3)
; ucOUTDIV end address is: 4 (R1)
L_vRF4463InitFreq145:
; ucOUTDIV start address is: 4 (R1)
; ucBAND start address is: 12 (R3)
; ucVCO start address is: 24 (R6)
; ucBAND end address is: 12 (R3)
; ucVCO end address is: 24 (R6)
; ucOUTDIV end address is: 4 (R1)
UXTB	R7, R3
L_vRF4463InitFreq143:
; ucVCO start address is: 24 (R6)
; ucBAND start address is: 28 (R7)
; ucOUTDIV start address is: 4 (R1)
; ucVCO end address is: 24 (R6)
; ucBAND end address is: 28 (R7)
; ucOUTDIV end address is: 4 (R1)
L_vRF4463InitFreq141:
; ucOUTDIV start address is: 4 (R1)
; ucBAND start address is: 28 (R7)
; ucVCO start address is: 24 (R6)
; ucVCO end address is: 24 (R6)
; ucBAND end address is: 28 (R7)
; ucOUTDIV end address is: 4 (R1)
L_vRF4463InitFreq139:
;driverrf4463pro.c,738 :: 		ucDIV = ucOUTDIV / 2;
; ucVCO start address is: 24 (R6)
; ucBAND start address is: 28 (R7)
; ucOUTDIV start address is: 4 (R1)
LSRS	R0, R1, #1
UXTB	R0, R0
; ucOUTDIV end address is: 4 (R1)
;driverrf4463pro.c,740 :: 		ulData = ( ulFrequency * ucDIV ) / 3;          // ucDIV = 88.5 = 88   //// UCdiv = 2
MOV	R1, R0
MULS	R1, R2, R1
; ulFrequency end address is: 8 (R2)
MOVS	R2, #3
MOV	R0, R1
BL	__Div_32x32_U+0
; ulData start address is: 16 (R4)
MOV	R4, R0
;driverrf4463pro.c,741 :: 		ucINTE = ( ulData / 100000) - 1;               // ulData = 6 000 000  //// ULdATA = 9 000 000
MOVW	R2, #34464
MOVT	R2, #1
STR	R4, [SP, #0]
BL	__Div_32x32_U+0
LDR	R4, [SP, #0]
SUBS	R0, R0, #1
; ucINTE start address is: 12 (R3)
UXTB	R3, R0
;driverrf4463pro.c,742 :: 		ulFRAC = ( ulData - ( ucINTE + 1 ) * 100000 ) * 16384 / 3125;         // ulFRAC = 15 728 640
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
;driverrf4463pro.c,743 :: 		ulFRAC = ulFRAC + 0x80000;
MOVW	R1, #0
MOVT	R1, #8
ADDS	R0, R0, R1
;driverrf4463pro.c,745 :: 		ucFRAC_0 = ulFRAC;
; ucFRAC_0 start address is: 16 (R4)
UXTB	R4, R0
;driverrf4463pro.c,746 :: 		ulFRAC >>= 8;
LSRS	R0, R0, #8
;driverrf4463pro.c,747 :: 		ucFRAC_1 = ulFRAC;
; ucFRAC_1 start address is: 20 (R5)
UXTB	R5, R0
;driverrf4463pro.c,748 :: 		ulFRAC >>= 8;
LSRS	R0, R0, #8
;driverrf4463pro.c,749 :: 		ucFRAC_2 = ulFRAC;
STR	R0, [SP, #12]
;driverrf4463pro.c,753 :: 		ucAppCommandBuf[ 0 ] = 0x11;           // SET property    MODEM_CLKGEN_BAND
MOVS	R2, #16
ADD	R2, SP, R2
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,754 :: 		ucAppCommandBuf[ 1 ] = 0x20;           // Group  // 0x2051
ADDS	R1, R2, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,755 :: 		ucAppCommandBuf[ 2 ] = 0x01;           // Num Arguments // Total 1 Parameters
ADDS	R1, R2, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,756 :: 		ucAppCommandBuf[ 3 ] = 0x51;           // Number  // 0x2051
ADDS	R1, R2, #3
MOVS	R0, #81
STRB	R0, [R1, #0]
;driverrf4463pro.c,757 :: 		ucAppCommandBuf[ 4 ] = 0x08 | ucBAND;  // Argumento  //  high performance mode , clk outpu = osc /4
ADDS	R1, R2, #4
MOVS	R0, #8
ORRS	R0, R7
; ucBAND end address is: 28 (R7)
STRB	R0, [R1, #0]
;driverrf4463pro.c,758 :: 		vSPIWrite( 5, ucAppCommandBuf );
STR	R5, [SP, #0]
STR	R4, [SP, #4]
STR	R3, [SP, #8]
MOV	R1, R2
MOVS	R0, #5
BL	_vSPIWrite+0
LDR	R3, [SP, #8]
UXTB	R3, R3
LDR	R4, [SP, #4]
UXTB	R4, R4
LDR	R5, [SP, #0]
UXTB	R5, R5
;driverrf4463pro.c,760 :: 		ucAppCommandBuf[ 0 ]  = 0x11;
MOVS	R2, #16
ADD	R2, SP, R2
MOVS	R0, #17
STRB	R0, [R2, #0]
;driverrf4463pro.c,761 :: 		ucAppCommandBuf[ 1 ]  = 0x40;    // 0x4000         FREQ_CONTROL_INTE
ADDS	R1, R2, #1
MOVS	R0, #64
STRB	R0, [R1, #0]
;driverrf4463pro.c,762 :: 		ucAppCommandBuf[ 2 ]  = 0x08;    // Total 8 Parameters
ADDS	R1, R2, #2
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,763 :: 		ucAppCommandBuf[ 3 ]  = 0x00;   // 0x4000
ADDS	R1, R2, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,764 :: 		ucAppCommandBuf[ 4 ]  = ucINTE;   //  default value
ADDS	R0, R2, #4
STRB	R3, [R0, #0]
; ucINTE end address is: 12 (R3)
;driverrf4463pro.c,765 :: 		ucAppCommandBuf[ 5 ]  = ucFRAC_2;   //  defaul value
ADDS	R1, R2, #5
LDR	R0, [SP, #12]
UXTB	R0, R0
STRB	R0, [R1, #0]
;driverrf4463pro.c,766 :: 		ucAppCommandBuf[ 6 ]  = ucFRAC_1;   //  default value
ADDS	R0, R2, #6
STRB	R5, [R0, #0]
; ucFRAC_1 end address is: 20 (R5)
;driverrf4463pro.c,767 :: 		ucAppCommandBuf[ 7 ]  = ucFRAC_0;   // frac ,from WDS
ADDS	R0, R2, #7
STRB	R4, [R0, #0]
; ucFRAC_0 end address is: 16 (R4)
;driverrf4463pro.c,770 :: 		if ( ulRF4463Step == 250 ) {
MOVW	R0, #lo_addr(_ulRF4463Step+0)
MOVT	R0, #hi_addr(_ulRF4463Step+0)
LDR	R0, [R0, #0]
CMP	R0, #250
IT	NE
BLNE	L_vRF4463InitFreq148
;driverrf4463pro.c,771 :: 		ucAppCommandBuf[ 8 ]  = step_250K_step1;   // channel step1  from wds  // al parecer aqu? esta el ancho del canal
MOVS	R2, #16
ADD	R2, SP, R2
MOV	R1, R2
ADDS	R1, #8
MOVS	R0, #34
STRB	R0, [R1, #0]
;driverrf4463pro.c,772 :: 		ucAppCommandBuf[ 9 ]  = step_250K_step0;   // channel step0  from wds
MOV	R1, R2
ADDS	R1, #9
MOVS	R0, #34
STRB	R0, [R1, #0]
;driverrf4463pro.c,773 :: 		}
IT	AL
BLAL	L_vRF4463InitFreq149
L_vRF4463InitFreq148:
;driverrf4463pro.c,774 :: 		else if ( ulRF4463Step == 500 ) {
MOVW	R0, #lo_addr(_ulRF4463Step+0)
MOVT	R0, #hi_addr(_ulRF4463Step+0)
LDR	R1, [R0, #0]
MOVS	R0, #255
ADDS	R0, #245
CMP	R1, R0
IT	NE
BLNE	L_vRF4463InitFreq150
;driverrf4463pro.c,775 :: 		ucAppCommandBuf[ 8 ]  = step_500K_step1;   // channel step1  from wds  // al parecer aqu? esta el ancho del canal
MOVS	R2, #16
ADD	R2, SP, R2
MOV	R1, R2
ADDS	R1, #8
MOVS	R0, #68
STRB	R0, [R1, #0]
;driverrf4463pro.c,776 :: 		ucAppCommandBuf[ 9 ]  = step_500K_step0;   // channel step0  from wds
MOV	R1, R2
ADDS	R1, #9
MOVS	R0, #68
STRB	R0, [R1, #0]
;driverrf4463pro.c,777 :: 		}
L_vRF4463InitFreq150:
L_vRF4463InitFreq149:
;driverrf4463pro.c,779 :: 		ucAppCommandBuf[ 10 ] = 0x20;  //  from wds Without this Values
MOVS	R2, #16
ADD	R2, SP, R2
MOV	R1, R2
ADDS	R1, #10
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,780 :: 		ucAppCommandBuf[ 11 ] = ucVCO;    // from wds Without this Values
MOV	R0, R2
ADDS	R0, #11
STRB	R6, [R0, #0]
; ucVCO end address is: 24 (R6)
;driverrf4463pro.c,794 :: 		vSPIWrite( 12, ucAppCommandBuf );
MOV	R1, R2
MOVS	R0, #12
BL	_vSPIWrite+0
;driverrf4463pro.c,795 :: 		}
L_end_vRF4463InitFreq:
ADD	SP, SP, #36
POP	(R15)
; end of _vRF4463InitFreq
_ucRF4463SPIByte:
;driverrf4463pro.c,815 :: 		unsigned char ucRF4463SPIByte( unsigned char ucData ) {
PUSH	(R14)
SUB	SP, SP, #4
STR	R0, [SP, #0]
;driverrf4463pro.c,854 :: 		ucSPI1ByteReceived = 0;
MOVS	R2, #0
MOVW	R1, #lo_addr(_ucSPI1ByteReceived+0)
MOVT	R1, #hi_addr(_ucSPI1ByteReceived+0)
STRB	R2, [R1, #0]
;driverrf4463pro.c,856 :: 		vRF4463SpiBufferTX ( &ucData, 1 );        // lo envia por DMA
MOV	R1, SP
MOV	R0, R1
MOVS	R1, #1
BL	_vRF4463SpiBufferTX+0
;driverrf4463pro.c,858 :: 		while ( SPI1_SRbits.RXNE );
L_ucRF4463SPIByte151:
MOVW	R1, #lo_addr(SPI1_SRbits+0)
MOVT	R1, #hi_addr(SPI1_SRbits+0)
_LX	[R1, ByteOffset(SPI1_SRbits+0)]
MOVS	R1, #1
ANDS	R1, R2
LSRS	R1, R1, #0
CMP	R1, #0
IT	EQ
BLEQ	L_ucRF4463SPIByte152
IT	AL
BLAL	L_ucRF4463SPIByte151
L_ucRF4463SPIByte152:
;driverrf4463pro.c,860 :: 		return ( ucSPI1ByteReceived );
MOVW	R1, #lo_addr(_ucSPI1ByteReceived+0)
MOVT	R1, #hi_addr(_ucSPI1ByteReceived+0)
LDRB	R0, [R1, #0]
;driverrf4463pro.c,862 :: 		}
L_end_ucRF4463SPIByte:
ADD	SP, SP, #4
POP	(R15)
; end of _ucRF4463SPIByte
_vSPIWrite:
;driverrf4463pro.c,867 :: 		void vSPIWrite( unsigned char ucTxLength, unsigned char *ucBuffer ) {
; i start address is: 0 (R0)
PUSH	(R14)
SUB	SP, SP, #8
;driverrf4463pro.c,870 :: 		i = 0;
;driverrf4463pro.c,867 :: 		void vSPIWrite( unsigned char ucTxLength, unsigned char *ucBuffer ) {
STR	R0, [SP, #0]
;driverrf4463pro.c,870 :: 		i = 0;
;driverrf4463pro.c,867 :: 		void vSPIWrite( unsigned char ucTxLength, unsigned char *ucBuffer ) {
STR	R1, [SP, #4]
; i end address is: 0 (R0)
;driverrf4463pro.c,870 :: 		i = 0;
; i start address is: 0 (R0)
MOVS	R0, #0
; i end address is: 0 (R0)
;driverrf4463pro.c,871 :: 		while ( i != 0xFF ) {
L_vSPIWrite153:
; i start address is: 0 (R0)
CMP	R0, #255
IT	EQ
BLEQ	L_vSPIWrite154
; i end address is: 0 (R0)
;driverrf4463pro.c,872 :: 		i = ucRF4463CheckCTS();
BL	_ucRF4463CheckCTS+0
; i start address is: 0 (R0)
;driverrf4463pro.c,873 :: 		}
; i end address is: 0 (R0)
IT	AL
BLAL	L_vSPIWrite153
L_vSPIWrite154:
;driverrf4463pro.c,875 :: 		nSEL = 0;                              // habilita escritura
MOVW	R4, #lo_addr(GPIOA_ODRbits+0)
MOVT	R4, #hi_addr(GPIOA_ODRbits+0)
_LX	[R4, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R3, #8
BICS	R2, R3
_SX	[R4, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,877 :: 		for ( i = 0; i < ucTxLength; i++ ) {
; i start address is: 28 (R7)
MOVS	R7, #0
; i end address is: 28 (R7)
UXTB	R5, R7
L_vSPIWrite155:
; i start address is: 20 (R5)
LDR	R2, [SP, #0]
UXTB	R2, R2
CMP	R5, R2
IT	CS
BLCS	L_vSPIWrite156
;driverrf4463pro.c,878 :: 		j = *( ucBuffer + i );
LDR	R2, [SP, #4]
ADDS	R2, R2, R5
;driverrf4463pro.c,879 :: 		ucRF4463SPIByte( j );
LDRB	R0, [R2, #0]
BL	_ucRF4463SPIByte+0
;driverrf4463pro.c,877 :: 		for ( i = 0; i < ucTxLength; i++ ) {
ADDS	R2, R5, #1
; i end address is: 20 (R5)
; i start address is: 28 (R7)
UXTB	R7, R2
;driverrf4463pro.c,880 :: 		}
UXTB	R5, R7
; i end address is: 28 (R7)
IT	AL
BLAL	L_vSPIWrite155
L_vSPIWrite156:
;driverrf4463pro.c,882 :: 		nSEL = 1;                              // desabilita escritura
MOVW	R4, #lo_addr(GPIOA_ODRbits+0)
MOVT	R4, #hi_addr(GPIOA_ODRbits+0)
_LX	[R4, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R3, #8
ORRS	R2, R3
_SX	[R4, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,883 :: 		}
L_end_vSPIWrite:
ADD	SP, SP, #8
POP	(R15)
; end of _vSPIWrite
_ucRF4463CheckCTS:
;driverrf4463pro.c,888 :: 		unsigned char ucRF4463CheckCTS( void ) {    // This Command follows the Command and reads the response
PUSH	(R14)
;driverrf4463pro.c,891 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,892 :: 		nSEL = 0;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,893 :: 		ucRF4463SPIByte( 0x44 );
MOVS	R0, #68
BL	_ucRF4463SPIByte+0
;driverrf4463pro.c,894 :: 		i = ucRF4463SPIByte( 0 );
MOVS	R0, #0
BL	_ucRF4463SPIByte+0
;driverrf4463pro.c,895 :: 		nSEL = 1;
MOVW	R3, #lo_addr(GPIOA_ODRbits+0)
MOVT	R3, #hi_addr(GPIOA_ODRbits+0)
_LX	[R3, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R2, #8
ORRS	R1, R2
_SX	[R3, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,896 :: 		return ( i );
;driverrf4463pro.c,897 :: 		}
L_end_ucRF4463CheckCTS:
POP	(R15)
; end of _ucRF4463CheckCTS
_vSPIRead:
;driverrf4463pro.c,902 :: 		void vSPIRead( unsigned char ucDataLength, unsigned char ucAPICommand ) {
; ucAPICommand start address is: 4 (R1)
; ucDataLength start address is: 0 (R0)
PUSH	(R14)
SUB	SP, SP, #8
; ucAPICommand end address is: 4 (R1)
; ucDataLength end address is: 0 (R0)
; ucDataLength start address is: 0 (R0)
; ucAPICommand start address is: 4 (R1)
;driverrf4463pro.c,906 :: 		p[ 0 ] = ucAPICommand;
MOV	R2, SP
STRB	R1, [R2, #0]
; ucAPICommand end address is: 4 (R1)
;driverrf4463pro.c,907 :: 		i = 0;
; i start address is: 4 (R1)
MOVS	R1, #0
; ucDataLength end address is: 0 (R0)
; i end address is: 4 (R1)
UXTB	R6, R0
UXTB	R0, R1
;driverrf4463pro.c,908 :: 		while ( i != 0xFF ) {
L_vSPIRead158:
; i start address is: 0 (R0)
; ucDataLength start address is: 24 (R6)
CMP	R0, #255
IT	EQ
BLEQ	L_vSPIRead159
; i end address is: 0 (R0)
;driverrf4463pro.c,909 :: 		i = ucRF4463CheckCTS();                // Check if you can send Command
BL	_ucRF4463CheckCTS+0
; i start address is: 0 (R0)
;driverrf4463pro.c,910 :: 		}
; i end address is: 0 (R0)
IT	AL
BLAL	L_vSPIRead158
L_vSPIRead159:
;driverrf4463pro.c,912 :: 		vSPIWrite( 1, p );    // Send Command
MOV	R2, SP
MOV	R1, R2
MOVS	R0, #1
BL	_vSPIWrite+0
;driverrf4463pro.c,914 :: 		i = 0;
; i start address is: 0 (R0)
MOVS	R0, #0
; ucDataLength end address is: 24 (R6)
; i end address is: 0 (R0)
UXTB	R5, R6
;driverrf4463pro.c,915 :: 		while ( i != 0xFF ) {
L_vSPIRead160:
; i start address is: 0 (R0)
; ucDataLength start address is: 20 (R5)
CMP	R0, #255
IT	EQ
BLEQ	L_vSPIRead161
; i end address is: 0 (R0)
;driverrf4463pro.c,916 :: 		i = ucRF4463CheckCTS();        //Check whether the data can be read
BL	_ucRF4463CheckCTS+0
; i start address is: 0 (R0)
;driverrf4463pro.c,917 :: 		}
; i end address is: 0 (R0)
IT	AL
BLAL	L_vSPIRead160
L_vSPIRead161:
;driverrf4463pro.c,919 :: 		nSEL = 1;
MOVW	R4, #lo_addr(GPIOA_ODRbits+0)
MOVT	R4, #hi_addr(GPIOA_ODRbits+0)
_LX	[R4, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R3, #8
ORRS	R2, R3
_SX	[R4, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,920 :: 		nSEL = 0;
MOVW	R4, #lo_addr(GPIOA_ODRbits+0)
MOVT	R4, #hi_addr(GPIOA_ODRbits+0)
_LX	[R4, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R3, #8
BICS	R2, R3
_SX	[R4, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,921 :: 		ucRF4463SPIByte( 0x44 );
MOVS	R0, #68
BL	_ucRF4463SPIByte+0
;driverrf4463pro.c,922 :: 		for ( i = 0; i < ucDataLength; i++ ) {        // Read data
; i start address is: 24 (R6)
MOVS	R6, #0
; ucDataLength end address is: 20 (R5)
; i end address is: 24 (R6)
L_vSPIRead162:
; i start address is: 24 (R6)
; ucDataLength start address is: 20 (R5)
CMP	R6, R5
IT	CS
BLCS	L_vSPIRead163
;driverrf4463pro.c,923 :: 		spi_read_buf[ i ] = ucRF4463SPIByte( 0x00 );             // 0x00
MOVW	R2, #lo_addr(_spi_read_buf+0)
MOVT	R2, #hi_addr(_spi_read_buf+0)
ADDS	R2, R2, R6
STR	R2, [SP, #4]
MOVS	R0, #0
BL	_ucRF4463SPIByte+0
LDR	R2, [SP, #4]
STRB	R0, [R2, #0]
;driverrf4463pro.c,922 :: 		for ( i = 0; i < ucDataLength; i++ ) {        // Read data
ADDS	R6, #1
UXTB	R6, R6
;driverrf4463pro.c,924 :: 		}
; ucDataLength end address is: 20 (R5)
; i end address is: 24 (R6)
IT	AL
BLAL	L_vSPIRead162
L_vSPIRead163:
;driverrf4463pro.c,925 :: 		nSEL = 1;
MOVW	R4, #lo_addr(GPIOA_ODRbits+0)
MOVT	R4, #hi_addr(GPIOA_ODRbits+0)
_LX	[R4, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R3, #8
ORRS	R2, R3
_SX	[R4, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,926 :: 		}
L_end_vSPIRead:
ADD	SP, SP, #8
POP	(R15)
; end of _vSPIRead
_spi_fast_read:
;driverrf4463pro.c,931 :: 		void spi_fast_read( unsigned char ucAPICommand ) {
; ucAPICommand start address is: 0 (R0)
PUSH	(R14)
SUB	SP, SP, #8
; ucAPICommand end address is: 0 (R0)
; ucAPICommand start address is: 0 (R0)
;driverrf4463pro.c,934 :: 		p[ 0 ] = ucAPICommand;
MOV	R1, SP
STRB	R0, [R1, #0]
;driverrf4463pro.c,935 :: 		i = 0;
; i start address is: 4 (R1)
MOVS	R1, #0
; ucAPICommand end address is: 0 (R0)
; i end address is: 4 (R1)
UXTB	R5, R0
;driverrf4463pro.c,936 :: 		while ( i != 0xFF ) {
L_spi_fast_read165:
; i start address is: 4 (R1)
; ucAPICommand start address is: 20 (R5)
CMP	R1, #255
IT	EQ
BLEQ	L_spi_fast_read166
; i end address is: 4 (R1)
;driverrf4463pro.c,937 :: 		i = ucRF4463CheckCTS();                // Check if you can send Command
BL	_ucRF4463CheckCTS+0
; i start address is: 4 (R1)
UXTB	R1, R0
;driverrf4463pro.c,938 :: 		}
; i end address is: 4 (R1)
IT	AL
BLAL	L_spi_fast_read165
L_spi_fast_read166:
;driverrf4463pro.c,940 :: 		nSEL = 1;
MOVW	R3, #lo_addr(GPIOA_ODRbits+0)
MOVT	R3, #hi_addr(GPIOA_ODRbits+0)
_LX	[R3, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R2, #8
ORRS	R1, R2
_SX	[R3, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,941 :: 		nSEL = 0;
MOVW	R3, #lo_addr(GPIOA_ODRbits+0)
MOVT	R3, #hi_addr(GPIOA_ODRbits+0)
_LX	[R3, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R2, #8
BICS	R1, R2
_SX	[R3, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,942 :: 		ucRF4463SPIByte( ucAPICommand );    // Send Command
UXTB	R0, R5
; ucAPICommand end address is: 20 (R5)
BL	_ucRF4463SPIByte+0
;driverrf4463pro.c,943 :: 		for ( i = 0; i < 4; i++ ) {
; i start address is: 20 (R5)
MOVS	R5, #0
; i end address is: 20 (R5)
L_spi_fast_read167:
; i start address is: 20 (R5)
CMP	R5, #4
IT	CS
BLCS	L_spi_fast_read168
;driverrf4463pro.c,944 :: 		spi_read_buf[ i ] = ucRF4463SPIByte( 0xFF );   // Read out all the 4 registers Value of
MOVW	R1, #lo_addr(_spi_read_buf+0)
MOVT	R1, #hi_addr(_spi_read_buf+0)
ADDS	R1, R1, R5
STR	R1, [SP, #4]
MOVS	R0, #255
BL	_ucRF4463SPIByte+0
LDR	R1, [SP, #4]
STRB	R0, [R1, #0]
;driverrf4463pro.c,943 :: 		for ( i = 0; i < 4; i++ ) {
ADDS	R5, #1
UXTB	R5, R5
;driverrf4463pro.c,945 :: 		}
; i end address is: 20 (R5)
IT	AL
BLAL	L_spi_fast_read167
L_spi_fast_read168:
;driverrf4463pro.c,946 :: 		nSEL = 1;
MOVW	R3, #lo_addr(GPIOA_ODRbits+0)
MOVT	R3, #hi_addr(GPIOA_ODRbits+0)
_LX	[R3, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R2, #8
ORRS	R1, R2
_SX	[R3, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,947 :: 		}
L_end_spi_fast_read:
ADD	SP, SP, #8
POP	(R15)
; end of _spi_fast_read
_vSPIWriteFifo:
;driverrf4463pro.c,952 :: 		void vSPIWriteFifo( void ) {
PUSH	(R14)
;driverrf4463pro.c,955 :: 		i = 0;
; i start address is: 0 (R0)
MOVS	R0, #0
; i end address is: 0 (R0)
;driverrf4463pro.c,956 :: 		while ( i != 0xFF ) {
L_vSPIWriteFifo170:
; i start address is: 0 (R0)
CMP	R0, #255
IT	EQ
BLEQ	L_vSPIWriteFifo171
; i end address is: 0 (R0)
;driverrf4463pro.c,957 :: 		i = ucRF4463CheckCTS();                // Check if you can send Command
BL	_ucRF4463CheckCTS+0
; i start address is: 0 (R0)
;driverrf4463pro.c,958 :: 		}
; i end address is: 0 (R0)
IT	AL
BLAL	L_vSPIWriteFifo170
L_vSPIWriteFifo171:
;driverrf4463pro.c,960 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,961 :: 		nSEL = 0;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,962 :: 		ucRF4463SPIByte( WRITE_TX_FIFO );
MOVS	R0, #102
BL	_ucRF4463SPIByte+0
;driverrf4463pro.c,964 :: 		if ( ucRF4463Mode == tx_test_mode) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BLNE	L_vSPIWriteFifo172
;driverrf4463pro.c,965 :: 		for ( i = 0; i < payload_length; i++ ) {
; i start address is: 20 (R5)
MOVS	R5, #0
; i end address is: 20 (R5)
L_vSPIWriteFifo173:
; i start address is: 20 (R5)
CMP	R5, #66
IT	CS
BLCS	L_vSPIWriteFifo174
;driverrf4463pro.c,966 :: 		ucRF4463SPIByte( tx_test_aa_data[ i ] );   // Send 10 test data
MOVW	R0, #lo_addr(_tx_test_aa_data+0)
MOVT	R0, #hi_addr(_tx_test_aa_data+0)
ADDS	R0, R0, R5
LDRB	R0, [R0, #0]
BL	_ucRF4463SPIByte+0
;driverrf4463pro.c,965 :: 		for ( i = 0; i < payload_length; i++ ) {
ADDS	R5, #1
UXTB	R5, R5
;driverrf4463pro.c,967 :: 		}
; i end address is: 20 (R5)
IT	AL
BLAL	L_vSPIWriteFifo173
L_vSPIWriteFifo174:
;driverrf4463pro.c,968 :: 		}
IT	AL
BLAL	L_vSPIWriteFifo176
L_vSPIWriteFifo172:
;driverrf4463pro.c,970 :: 		for ( i = 0; i < payload_length; i++ ) {
; i start address is: 20 (R5)
MOVS	R5, #0
; i end address is: 20 (R5)
L_vSPIWriteFifo177:
; i start address is: 20 (R5)
CMP	R5, #66
IT	CS
BLCS	L_vSPIWriteFifo178
;driverrf4463pro.c,971 :: 		ucRF4463SPIByte( ucRF4463TXdata[ i ] );
MOVW	R0, #lo_addr(_ucRF4463TXdata+0)
MOVT	R0, #hi_addr(_ucRF4463TXdata+0)
ADDS	R0, R0, R5
LDRB	R0, [R0, #0]
BL	_ucRF4463SPIByte+0
;driverrf4463pro.c,970 :: 		for ( i = 0; i < payload_length; i++ ) {
ADDS	R5, #1
UXTB	R5, R5
;driverrf4463pro.c,972 :: 		}
; i end address is: 20 (R5)
IT	AL
BLAL	L_vSPIWriteFifo177
L_vSPIWriteFifo178:
;driverrf4463pro.c,973 :: 		}
L_vSPIWriteFifo176:
;driverrf4463pro.c,974 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,975 :: 		}
L_end_vSPIWriteFifo:
POP	(R15)
; end of _vSPIWriteFifo
_spi_read_fifo:
;driverrf4463pro.c,980 :: 		void spi_read_fifo( void ) {
PUSH	(R14)
SUB	SP, SP, #4
;driverrf4463pro.c,983 :: 		i = 0;
; i start address is: 0 (R0)
MOVS	R0, #0
; i end address is: 0 (R0)
;driverrf4463pro.c,984 :: 		while ( i != 0xFF ) {
L_spi_read_fifo180:
; i start address is: 0 (R0)
CMP	R0, #255
IT	EQ
BLEQ	L_spi_read_fifo181
; i end address is: 0 (R0)
;driverrf4463pro.c,985 :: 		i = ucRF4463CheckCTS();                   // Check if you can send Command
BL	_ucRF4463CheckCTS+0
; i start address is: 0 (R0)
;driverrf4463pro.c,986 :: 		}
; i end address is: 0 (R0)
IT	AL
BLAL	L_spi_read_fifo180
L_spi_read_fifo181:
;driverrf4463pro.c,988 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,989 :: 		nSEL = 0;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,990 :: 		ucRF4463SPIByte( READ_RX_FIFO );
MOVS	R0, #119
BL	_ucRF4463SPIByte+0
;driverrf4463pro.c,991 :: 		for ( i = 0; i < payload_length; i++ ) {
; i start address is: 20 (R5)
MOVS	R5, #0
; i end address is: 20 (R5)
L_spi_read_fifo182:
; i start address is: 20 (R5)
CMP	R5, #66
IT	CS
BLCS	L_spi_read_fifo183
;driverrf4463pro.c,992 :: 		rx_buf[ i ] = ucRF4463SPIByte( 0xFF );      // Receive 10 test data
MOVW	R0, #lo_addr(_rx_buf+0)
MOVT	R0, #hi_addr(_rx_buf+0)
ADDS	R0, R0, R5
STR	R0, [SP, #0]
MOVS	R0, #255
BL	_ucRF4463SPIByte+0
LDR	R1, [SP, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,991 :: 		for ( i = 0; i < payload_length; i++ ) {
ADDS	R5, #1
UXTB	R5, R5
;driverrf4463pro.c,993 :: 		}
; i end address is: 20 (R5)
IT	AL
BLAL	L_spi_read_fifo182
L_spi_read_fifo183:
;driverrf4463pro.c,994 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,995 :: 		}
L_end_spi_read_fifo:
ADD	SP, SP, #4
POP	(R15)
; end of _spi_read_fifo
_vRF4463SDNReset:
;driverrf4463pro.c,1000 :: 		void vRF4463SDNReset( void ) {
PUSH	(R14)
;driverrf4463pro.c,1003 :: 		SDN = 1;
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_LX	[R2, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #4
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,1004 :: 		Delay_ms( 6 );        // RF Module reset  DELAY
LDR	R7, [PC, #23999]
NOP
L_vRF4463SDNReset185:
SUBS	R7, R7, #1
BNE	L_vRF4463SDNReset185
B	#4
	#23999
NOP
;driverrf4463pro.c,1005 :: 		SDN = 0;
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_LX	[R2, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #4
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,1006 :: 		Delay_ms( 10 );       // Delay 10ms for RF module to enter working state
LDR	R7, [PC, #39999]
NOP
L_vRF4463SDNReset187:
SUBS	R7, R7, #1
BNE	L_vRF4463SDNReset187
B	#4
	#39999
NOP
;driverrf4463pro.c,1008 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,1009 :: 		nSEL = 0;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,1010 :: 		for ( i = 0; i < 7; i++ ) {
; i start address is: 20 (R5)
MOVS	R5, #0
; i end address is: 20 (R5)
L_vRF4463SDNReset189:
; i start address is: 20 (R5)
CMP	R5, #7
IT	CS
BLCS	L_vRF4463SDNReset190
;driverrf4463pro.c,1011 :: 		ucRF4463SPIByte( RF_POWER_UP_data[ i ] );   // send power up Command
MOVW	R0, #lo_addr(_RF_POWER_UP_data+0)
MOVT	R0, #hi_addr(_RF_POWER_UP_data+0)
ADDS	R0, R0, R5
LDRB	R0, [R0, #0]
BL	_ucRF4463SPIByte+0
;driverrf4463pro.c,1010 :: 		for ( i = 0; i < 7; i++ ) {
ADDS	R5, #1
UXTB	R5, R5
;driverrf4463pro.c,1012 :: 		}
; i end address is: 20 (R5)
IT	AL
BLAL	L_vRF4463SDNReset189
L_vRF4463SDNReset190:
;driverrf4463pro.c,1013 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,1015 :: 		Delay_ms( 20 );       // Delay 20ms RF module enters working state, but CTS still needs to be judged later, this delay can be removed
LDR	R7, [PC, #79999]
NOP
L_vRF4463SDNReset192:
SUBS	R7, R7, #1
BNE	L_vRF4463SDNReset192
B	#4
	#79999
NOP
;driverrf4463pro.c,1016 :: 		}
L_end_vRF4463SDNReset:
POP	(R15)
; end of _vRF4463SDNReset
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
BLLS	L_ucASCIIToByte194
;utils.c,47 :: 		ucMSBNibble -= 7;
MOVW	R2, #lo_addr(_ucMSBNibble+0)
MOVT	R2, #hi_addr(_ucMSBNibble+0)
LDRB	R1, [R2, #0]
SUBS	R1, R1, #7
STRB	R1, [R2, #0]
;utils.c,48 :: 		}
L_ucASCIIToByte194:
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
BLLS	L_ucASCIIToByte195
;utils.c,52 :: 		ucLSBNibble -= 7;
MOVW	R2, #lo_addr(_ucLSBNibble+0)
MOVT	R2, #hi_addr(_ucLSBNibble+0)
LDRB	R1, [R2, #0]
SUBS	R1, R1, #7
STRB	R1, [R2, #0]
;utils.c,53 :: 		}
L_ucASCIIToByte195:
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
L_vASCIIToHex196:
; ucASCIICounter start address is: 24 (R6)
; pcHexConvertBuffer start address is: 8 (R2)
; ucConversionLength start address is: 0 (R0)
; pcASCIIConvertBuffer start address is: 4 (R1)
; pcASCIIConvertBuffer end address is: 4 (R1)
; pcHexConvertBuffer start address is: 8 (R2)
; pcHexConvertBuffer end address is: 8 (R2)
CMP	R6, R0
IT	CS
BLCS	L_vASCIIToHex197
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
BLLS	L_vASCIIToHex199
;utils.c,70 :: 		ucMSBNibble -= 7;
MOVW	R4, #lo_addr(_ucMSBNibble+0)
MOVT	R4, #hi_addr(_ucMSBNibble+0)
LDRB	R3, [R4, #0]
SUBS	R3, R3, #7
STRB	R3, [R4, #0]
;utils.c,71 :: 		}
L_vASCIIToHex199:
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
BLLS	L_vASCIIToHex200
;utils.c,75 :: 		ucLSBNibble -= 7;
MOVW	R4, #lo_addr(_ucLSBNibble+0)
MOVT	R4, #hi_addr(_ucLSBNibble+0)
LDRB	R3, [R4, #0]
SUBS	R3, R3, #7
STRB	R3, [R4, #0]
;utils.c,76 :: 		}
L_vASCIIToHex200:
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
BLAL	L_vASCIIToHex196
L_vASCIIToHex197:
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
L_vHexToASCII201:
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
BLCS	L_vHexToASCII202
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
BLAL	L_vHexToASCII201
L_vHexToASCII202:
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
L_vBufferSetToZero204:
; usPosition start address is: 16 (R4)
; pcBufferToClean start address is: 4 (R1)
; uslength start address is: 0 (R0)
; pcBufferToClean start address is: 4 (R1)
; pcBufferToClean end address is: 4 (R1)
CMP	R4, R0
IT	CS
BLCS	L_vBufferSetToZero205
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
BLAL	L_vBufferSetToZero204
L_vBufferSetToZero205:
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
L_vBufferSetTo255207:
; usPosition start address is: 16 (R4)
; pcBufferToClean start address is: 4 (R1)
; uslength start address is: 0 (R0)
; pcBufferToClean start address is: 4 (R1)
; pcBufferToClean end address is: 4 (R1)
CMP	R4, R0
IT	CS
BLCS	L_vBufferSetTo255208
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
BLAL	L_vBufferSetTo255207
L_vBufferSetTo255208:
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
L_vBufferSetToValue210:
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
BLCS	L_vBufferSetToValue211
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
BLAL	L_vBufferSetToValue210
L_vBufferSetToValue211:
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
L_vSerializeUUID213:
; ucCounter start address is: 20 (R5)
; pcTextConvertBuffer start address is: 4 (R1)
; pcHexConvertBuffer start address is: 0 (R0)
; pcHexConvertBuffer start address is: 0 (R0)
; pcHexConvertBuffer end address is: 0 (R0)
; pcTextConvertBuffer start address is: 4 (R1)
; pcTextConvertBuffer end address is: 4 (R1)
CMP	R5, #12
IT	CS
BLCS	L_vSerializeUUID214
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
BLAL	L_vSerializeUUID213
L_vSerializeUUID214:
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
L_vSerializeMACAddress216:
; usCounter start address is: 4 (R1)
; pcTextConvertBuffer start address is: 0 (R0)
CMP	R1, #6
IT	CS
BLCS	L_vSerializeMACAddress217
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
BLEQ	L_vSerializeMACAddress219
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
L_vSerializeMACAddress219:
;utils.c,148 :: 		for( usCounter = 0; usCounter < 6; usCounter++ ){
ADDS	R1, #1
UXTH	R1, R1
;utils.c,154 :: 		}
; usCounter end address is: 4 (R1)
IT	AL
BLAL	L_vSerializeMACAddress216
L_vSerializeMACAddress217:
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
L_vSerializeIPAddress220:
LDR	R2, [SP, #20]
UXTB	R2, R2
CMP	R2, #4
IT	CS
BLCS	L_vSerializeIPAddress221
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
BLEQ	L_vSerializeIPAddress223
;utils.c,174 :: 		strcat( pcTextConvertBuffer, "." );
MOVS	R6, #8
ADD	R6, SP, R6
MOVS	R5, #2
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr2_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr2_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R2, #8
ADD	R2, SP, R2
MOV	R1, R2
LDR	R0, [SP, #12]
BL	_strcat+0
;utils.c,175 :: 		}
L_vSerializeIPAddress223:
;utils.c,167 :: 		for( ucCounter = 0; ucCounter < 4; ucCounter++ ){
LDR	R2, [SP, #20]
UXTB	R2, R2
ADDS	R2, #1
STR	R2, [SP, #20]
;utils.c,176 :: 		}
IT	AL
BLAL	L_vSerializeIPAddress220
L_vSerializeIPAddress221:
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
BEQ	L__vUARTISR513
MOVS	R1, #1
LSLS	R1, R1, #8
ORRS	R0, R1
B	L__vUARTISR512
L__vUARTISR513:
MOVS	R1, #1
LSLS	R1, R1, #8
BICS	R0, R1
L__vUARTISR512:
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
;DriverRF4463PROMain.c,125 :: 		void Timer2_interrupt() iv IVT_INT_TIM2 {
SUB	SP, SP, #4
;DriverRF4463PROMain.c,126 :: 		TIM2_SR.UIF = 0;
MOVW	R2, #lo_addr(TIM2_SR+0)
MOVT	R2, #hi_addr(TIM2_SR+0)
_LX	[R2, ByteOffset(TIM2_SR+0)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(TIM2_SR+0)]
;DriverRF4463PROMain.c,127 :: 		Flag.rf_reach_timeout = 1;
MOVW	R2, #lo_addr(_Flag+0)
MOVT	R2, #hi_addr(_Flag+0)
_LX	[R2, ByteOffset(_Flag+0)]
MOVS	R1, #4
ORRS	R0, R1
_SX	[R2, ByteOffset(_Flag+0)]
;DriverRF4463PROMain.c,128 :: 		Flag.reach_1s = 1;
MOVW	R2, #lo_addr(_Flag+0)
MOVT	R2, #hi_addr(_Flag+0)
_LX	[R2, ByteOffset(_Flag+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(_Flag+0)]
;DriverRF4463PROMain.c,129 :: 		}
L_end_Timer2_interrupt:
ADD	SP, SP, #4
BX	LR
; end of _Timer2_interrupt
_vRF4463MainApplyChanges:
;DriverRF4463PROMain.c,133 :: 		void vRF4463MainApplyChanges () {
PUSH	(R14)
;DriverRF4463PROMain.c,134 :: 		vRF4463SDNReset();
BL	_vRF4463SDNReset+0
;DriverRF4463PROMain.c,135 :: 		vRF4463Init();
BL	_vRF4463Init+0
;DriverRF4463PROMain.c,136 :: 		vRF4463ClearInterrupts();
BL	_vRF4463ClearInterrupts+0
;DriverRF4463PROMain.c,137 :: 		}
L_end_vRF4463MainApplyChanges:
POP	(R15)
; end of _vRF4463MainApplyChanges
_vRF4463MainSetTXString:
;DriverRF4463PROMain.c,140 :: 		void vRF4463MainSetTXString () {
SUB	SP, SP, #4
;DriverRF4463PROMain.c,141 :: 		ucRF4463TXdata[ 0 ] = ucRF4463ByteMatch1;
MOVW	R0, #lo_addr(_ucRF4463ByteMatch1+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch1+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucRF4463TXdata+0)
MOVT	R0, #hi_addr(_ucRF4463TXdata+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,142 :: 		ucRF4463TXdata[ 1 ] = ucRF4463ByteMatch2;
MOVW	R0, #lo_addr(_ucRF4463ByteMatch2+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch2+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucRF4463TXdata+1)
MOVT	R0, #hi_addr(_ucRF4463TXdata+1)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,143 :: 		ucRF4463TXdata[ 2 ] = ucRF4463ByteMatch3;
MOVW	R0, #lo_addr(_ucRF4463ByteMatch3+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch3+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucRF4463TXdata+2)
MOVT	R0, #hi_addr(_ucRF4463TXdata+2)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,144 :: 		ucRF4463TXdata[ 3 ] = ucRF4463ByteMatch4;
MOVW	R0, #lo_addr(_ucRF4463ByteMatch4+0)
MOVT	R0, #hi_addr(_ucRF4463ByteMatch4+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucRF4463TXdata+3)
MOVT	R0, #hi_addr(_ucRF4463TXdata+3)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,145 :: 		}
L_end_vRF4463MainSetTXString:
ADD	SP, SP, #4
BX	LR
; end of _vRF4463MainSetTXString
_vRF4463MainCommandProcessor:
;DriverRF4463PROMain.c,151 :: 		void vRF4463MainCommandProcessor ( unsigned char *ucBuffer ) {
; ucBuffer start address is: 0 (R0)
PUSH	(R14)
SUB	SP, SP, #192
; ucBuffer end address is: 0 (R0)
; ucBuffer start address is: 0 (R0)
;DriverRF4463PROMain.c,152 :: 		unsigned char ucCommand [ 32 ] = { 0x00 };
MOVS	R6, #28
ADD	R6, SP, R6
MOVS	R5, #96
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICSvRF4463MainCommandProcessor_ucCommand_L0+0)
MOVT	R7, #hi_addr(?ICSvRF4463MainCommandProcessor_ucCommand_L0+0)
BL	___CC2DW+0
;DriverRF4463PROMain.c,154 :: 		unsigned char ucLongArgument[ 64 ] = { 0x00 };     // Espera argumentos de hasta 11 bytes
;DriverRF4463PROMain.c,155 :: 		unsigned char ucCounterBuffer = 0;
; ucCounterBuffer start address is: 12 (R3)
MOVS	R3, #0
;DriverRF4463PROMain.c,156 :: 		unsigned char ucCounterCommand = 0;
; ucCounterCommand start address is: 16 (R4)
MOVS	R4, #0
;DriverRF4463PROMain.c,157 :: 		unsigned char ucCounterLongArgument = 0;
; ucCounterLongArgument start address is: 20 (R5)
STR	R4, [SP, #0]
MOVS	R5, #0
LDR	R4, [SP, #0]
UXTB	R4, R4
;DriverRF4463PROMain.c,158 :: 		unsigned char ucTempChecksum = 0;
;DriverRF4463PROMain.c,160 :: 		unsigned char ucTXT [ 64 ] = { 0x00 };             // string de conversiones temporales
STR	R5, [SP, #0]
STR	R4, [SP, #4]
MOVS	R6, #124
ADD	R6, SP, R6
MOVS	R5, #64
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICSvRF4463MainCommandProcessor_ucTXT_L0+0)
MOVT	R7, #hi_addr(?ICSvRF4463MainCommandProcessor_ucTXT_L0+0)
BL	___CC2DW+0
LDR	R4, [SP, #4]
UXTB	R4, R4
LDR	R5, [SP, #0]
UXTB	R5, R5
;DriverRF4463PROMain.c,162 :: 		ulArgument = 0;
MOVS	R2, #0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R2, [R1, #0]
;DriverRF4463PROMain.c,165 :: 		if ( ucBuffer[ 0 ] > '@' && ucBuffer[ 0 ] <= 'z' ) {
LDRB	R1, [R0, #0]
CMP	R1, #64
IT	LS
BLLS	L__vRF4463MainCommandProcessor464
LDRB	R1, [R0, #0]
CMP	R1, #122
IT	HI
BLHI	L__vRF4463MainCommandProcessor465
L__vRF4463MainCommandProcessor430:
;DriverRF4463PROMain.c,167 :: 		while ( ucBuffer[ ucCounterBuffer ] != '|' && ucCounterCommand < 32 ) {      // primer token
UXTB	R2, R5
; ucCounterBuffer end address is: 12 (R3)
; ucBuffer end address is: 0 (R0)
; ucCounterLongArgument end address is: 20 (R5)
MOV	R5, R0
L_vRF4463MainCommandProcessor227:
; ucCounterCommand end address is: 16 (R4)
; ucCounterLongArgument start address is: 8 (R2)
; ucCounterCommand start address is: 16 (R4)
; ucCounterBuffer start address is: 12 (R3)
; ucBuffer start address is: 20 (R5)
ADDS	R1, R5, R3
LDRB	R1, [R1, #0]
CMP	R1, #124
IT	EQ
BLEQ	L__vRF4463MainCommandProcessor432
CMP	R4, #32
IT	CS
BLCS	L__vRF4463MainCommandProcessor431
L__vRF4463MainCommandProcessor429:
;DriverRF4463PROMain.c,168 :: 		ucCommand[ ucCounterCommand++ ] = toupper( ucBuffer[ ucCounterBuffer++ ] );
MOVS	R1, #28
ADD	R1, SP, R1
ADDS	R1, R1, R4
STR	R1, [SP, #188]
ADDS	R1, R5, R3
LDRB	R1, [R1, #0]
UXTB	R0, R1
BL	_toupper+0
LDR	R1, [SP, #188]
STRB	R0, [R1, #0]
ADDS	R4, #1
UXTB	R4, R4
ADDS	R3, #1
UXTB	R3, R3
;DriverRF4463PROMain.c,169 :: 		}
; ucCounterCommand end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463MainCommandProcessor227
;DriverRF4463PROMain.c,167 :: 		while ( ucBuffer[ ucCounterBuffer ] != '|' && ucCounterCommand < 32 ) {      // primer token
L__vRF4463MainCommandProcessor432:
L__vRF4463MainCommandProcessor431:
;DriverRF4463PROMain.c,171 :: 		ucCounterBuffer++;                                                           // evita el Token
ADDS	R4, R3, #1
UXTB	R4, R4
; ucCounterBuffer end address is: 12 (R3)
; ucCounterBuffer start address is: 16 (R4)
; ucCounterLongArgument end address is: 8 (R2)
; ucBuffer end address is: 20 (R5)
; ucCounterBuffer end address is: 16 (R4)
UXTB	R3, R2
MOV	R0, R5
;DriverRF4463PROMain.c,173 :: 		while ( ucBuffer[ ucCounterBuffer ] != CHR_CR && ucCounterLongArgument < 64 ) {   // segundo token
L_vRF4463MainCommandProcessor231:
; ucCounterBuffer start address is: 16 (R4)
; ucBuffer start address is: 0 (R0)
; ucCounterLongArgument start address is: 12 (R3)
ADDS	R1, R0, R4
LDRB	R1, [R1, #0]
CMP	R1, #13
IT	EQ
BLEQ	L__vRF4463MainCommandProcessor434
CMP	R3, #64
IT	CS
BLCS	L__vRF4463MainCommandProcessor433
L__vRF4463MainCommandProcessor428:
;DriverRF4463PROMain.c,174 :: 		ucLongArgument[ ucCounterLongArgument ] = ucBuffer[ ucCounterBuffer ] ;
MOVS	R1, #60
ADD	R1, SP, R1
ADDS	R2, R1, R3
ADDS	R1, R0, R4
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
;DriverRF4463PROMain.c,175 :: 		ucCounterBuffer++;
ADDS	R4, #1
UXTB	R4, R4
;DriverRF4463PROMain.c,176 :: 		ucCounterLongArgument++;
ADDS	R3, #1
UXTB	R3, R3
;DriverRF4463PROMain.c,177 :: 		}
; ucCounterBuffer end address is: 16 (R4)
IT	AL
BLAL	L_vRF4463MainCommandProcessor231
;DriverRF4463PROMain.c,173 :: 		while ( ucBuffer[ ucCounterBuffer ] != CHR_CR && ucCounterLongArgument < 64 ) {   // segundo token
L__vRF4463MainCommandProcessor434:
L__vRF4463MainCommandProcessor433:
;DriverRF4463PROMain.c,165 :: 		if ( ucBuffer[ 0 ] > '@' && ucBuffer[ 0 ] <= 'z' ) {
MOV	R6, R0
; ucCounterLongArgument end address is: 12 (R3)
UXTB	R5, R3
IT	AL
BLAL	L__vRF4463MainCommandProcessor436
; ucBuffer end address is: 0 (R0)
L__vRF4463MainCommandProcessor464:
MOV	R6, R0
L__vRF4463MainCommandProcessor436:
; ucCounterLongArgument start address is: 20 (R5)
; ucBuffer start address is: 24 (R6)
; ucCounterLongArgument end address is: 20 (R5)
; ucBuffer end address is: 24 (R6)
IT	AL
BLAL	L__vRF4463MainCommandProcessor435
L__vRF4463MainCommandProcessor465:
MOV	R6, R0
L__vRF4463MainCommandProcessor435:
;DriverRF4463PROMain.c,182 :: 		if ( memcmp( CMD_RADIO_POWER_SET, ucCommand, sizeof( CMD_RADIO_POWER_SET ) ) == 0x00 ) {
; ucCounterLongArgument start address is: 20 (R5)
; ucBuffer start address is: 24 (R6)
MOVS	R1, #28
ADD	R1, SP, R1
MOVS	R2, #10
MOVW	R0, #lo_addr(_CMD_RADIO_POWER_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_POWER_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor235
; ucCounterLongArgument end address is: 20 (R5)
; ucBuffer end address is: 24 (R6)
;DriverRF4463PROMain.c,183 :: 		ulArgument = StrToShort( ucLongArgument );
MOVS	R1, #60
ADD	R1, SP, R1
MOV	R0, R1
BL	_StrToShort+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,185 :: 		if ( ulArgument > 0 && ulArgument <= 127 ) {
LDR	R1, [R1, #0]
CMP	R1, #0
IT	LS
BLLS	L__vRF4463MainCommandProcessor438
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #127
IT	HI
BLHI	L__vRF4463MainCommandProcessor437
L__vRF4463MainCommandProcessor427:
;DriverRF4463PROMain.c,186 :: 		ucRF4463Power = ulArgument;
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #lo_addr(_ucRF4463Power+0)
MOVT	R1, #hi_addr(_ucRF4463Power+0)
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
;DriverRF4463PROMain.c,189 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor239
;DriverRF4463PROMain.c,185 :: 		if ( ulArgument > 0 && ulArgument <= 127 ) {
L__vRF4463MainCommandProcessor438:
L__vRF4463MainCommandProcessor437:
;DriverRF4463PROMain.c,191 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,192 :: 		}
L_vRF4463MainCommandProcessor239:
;DriverRF4463PROMain.c,193 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor240
L_vRF4463MainCommandProcessor235:
;DriverRF4463PROMain.c,197 :: 		else if ( memcmp( CMD_RADIO_BAND_SET, ucCommand, sizeof( CMD_RADIO_BAND_SET ) ) == 0x00 ) {
; ucBuffer start address is: 24 (R6)
; ucCounterLongArgument start address is: 20 (R5)
MOVS	R1, #28
ADD	R1, SP, R1
MOVS	R2, #9
MOVW	R0, #lo_addr(_CMD_RADIO_BAND_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_BAND_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor241
; ucCounterLongArgument end address is: 20 (R5)
; ucBuffer end address is: 24 (R6)
;DriverRF4463PROMain.c,198 :: 		ulArgument = StrToInt( ucLongArgument );
MOVS	R1, #60
ADD	R1, SP, R1
MOV	R0, R1
BL	_StrToInt+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,200 :: 		if ( ulArgument == 433 || ulArgument == 868 || ulArgument == 915 ) {
LDR	R2, [R1, #0]
MOVS	R1, #255
ADDS	R1, #178
CMP	R2, R1
IT	EQ
BLEQ	L__vRF4463MainCommandProcessor441
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #868
MOVT	R1, #0
CMP	R2, R1
IT	EQ
BLEQ	L__vRF4463MainCommandProcessor440
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #915
MOVT	R1, #0
CMP	R2, R1
IT	EQ
BLEQ	L__vRF4463MainCommandProcessor439
IT	AL
BLAL	L_vRF4463MainCommandProcessor244
L__vRF4463MainCommandProcessor441:
L__vRF4463MainCommandProcessor440:
L__vRF4463MainCommandProcessor439:
;DriverRF4463PROMain.c,201 :: 		ucRF4463Freq3 = ucLongArgument[ 0 ] - 48;
MOVS	R3, #60
ADD	R3, SP, R3
LDRB	R1, [R3, #0]
MOV	R2, R1
SUBS	R2, #48
MOVW	R1, #lo_addr(_ucRF4463Freq3+0)
MOVT	R1, #hi_addr(_ucRF4463Freq3+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,202 :: 		ucRF4463Freq2 = ucLongArgument[ 1 ] - 48;
ADDS	R1, R3, #1
LDRB	R1, [R1, #0]
MOV	R2, R1
SUBS	R2, #48
MOVW	R1, #lo_addr(_ucRF4463Freq2+0)
MOVT	R1, #hi_addr(_ucRF4463Freq2+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,203 :: 		ucRF4463Freq1 = ucLongArgument[ 2 ] - 48;
ADDS	R1, R3, #2
LDRB	R1, [R1, #0]
MOV	R2, R1
SUBS	R2, #48
MOVW	R1, #lo_addr(_ucRF4463Freq1+0)
MOVT	R1, #hi_addr(_ucRF4463Freq1+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,204 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,205 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,206 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor245
L_vRF4463MainCommandProcessor244:
;DriverRF4463PROMain.c,208 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,209 :: 		}
L_vRF4463MainCommandProcessor245:
;DriverRF4463PROMain.c,210 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor246
L_vRF4463MainCommandProcessor241:
;DriverRF4463PROMain.c,214 :: 		else if ( memcmp( CMD_RADIO_RATE_SET, ucCommand, sizeof( CMD_RADIO_RATE_SET ) ) == 0x00 ) {
; ucBuffer start address is: 24 (R6)
; ucCounterLongArgument start address is: 20 (R5)
MOVS	R1, #28
ADD	R1, SP, R1
MOVS	R2, #9
MOVW	R0, #lo_addr(_CMD_RADIO_RATE_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_RATE_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor247
; ucCounterLongArgument end address is: 20 (R5)
; ucBuffer end address is: 24 (R6)
;DriverRF4463PROMain.c,215 :: 		ulArgument = StrToLong( ucLongArgument );
MOVS	R1, #60
ADD	R1, SP, R1
MOV	R0, R1
BL	_StrToLong+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,217 :: 		switch ( ulArgument ) {
IT	AL
BLAL	L_vRF4463MainCommandProcessor248
;DriverRF4463PROMain.c,218 :: 		case 500      : ucRF4463Rate = dr_500;
L_vRF4463MainCommandProcessor250:
MOVS	R2, #10
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
BLAL	L_vRF4463MainCommandProcessor249
;DriverRF4463PROMain.c,222 :: 		case 1200     : ucRF4463Rate = dr_1p2;
L_vRF4463MainCommandProcessor251:
MOVS	R2, #0
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
BLAL	L_vRF4463MainCommandProcessor249
;DriverRF4463PROMain.c,226 :: 		case 2400     : ucRF4463Rate = dr_2p4;
L_vRF4463MainCommandProcessor252:
MOVS	R2, #1
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
BLAL	L_vRF4463MainCommandProcessor249
;DriverRF4463PROMain.c,230 :: 		case 4800     : ucRF4463Rate = dr_4p8;
L_vRF4463MainCommandProcessor253:
MOVS	R2, #2
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,231 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,232 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,233 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor249
;DriverRF4463PROMain.c,234 :: 		case 9600     : ucRF4463Rate = dr_9p6;
L_vRF4463MainCommandProcessor254:
MOVS	R2, #3
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,235 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,236 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,237 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor249
;DriverRF4463PROMain.c,238 :: 		case 19200    : ucRF4463Rate = dr_19p2;
L_vRF4463MainCommandProcessor255:
MOVS	R2, #4
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,239 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,240 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,241 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor249
;DriverRF4463PROMain.c,242 :: 		case 38400    : ucRF4463Rate = dr_38p4;
L_vRF4463MainCommandProcessor256:
MOVS	R2, #5
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,243 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,244 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,245 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor249
;DriverRF4463PROMain.c,246 :: 		case 76800    : ucRF4463Rate = dr_76p8;
L_vRF4463MainCommandProcessor257:
MOVS	R2, #6
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,247 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,248 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,249 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor249
;DriverRF4463PROMain.c,250 :: 		case 115200   : ucRF4463Rate = dr_115p2;
L_vRF4463MainCommandProcessor258:
MOVS	R2, #7
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,251 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,252 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,253 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor249
;DriverRF4463PROMain.c,254 :: 		case 256000   : ucRF4463Rate = dr_256k;
L_vRF4463MainCommandProcessor259:
MOVS	R2, #8
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,255 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,256 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,257 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor249
;DriverRF4463PROMain.c,258 :: 		case 500000   : ucRF4463Rate = dr_500k;
L_vRF4463MainCommandProcessor260:
MOVS	R2, #9
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,259 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,260 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,261 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor249
;DriverRF4463PROMain.c,262 :: 		default       : vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
L_vRF4463MainCommandProcessor261:
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,263 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor249
L_vRF4463MainCommandProcessor248:
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVS	R1, #255
ADDS	R1, #245
CMP	R2, R1
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor250
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #1200
MOVT	R1, #0
CMP	R2, R1
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor251
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #2400
MOVT	R1, #0
CMP	R2, R1
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor252
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #4800
MOVT	R1, #0
CMP	R2, R1
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor253
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #9600
MOVT	R1, #0
CMP	R2, R1
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor254
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #19200
MOVT	R1, #0
CMP	R2, R1
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor255
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #38400
MOVT	R1, #0
CMP	R2, R1
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor256
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #11264
MOVT	R1, #1
CMP	R2, R1
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor257
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #49664
MOVT	R1, #1
CMP	R2, R1
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor258
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #59392
MOVT	R1, #3
CMP	R2, R1
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor259
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #41248
MOVT	R1, #7
CMP	R2, R1
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor260
IT	AL
BLAL	L_vRF4463MainCommandProcessor261
L_vRF4463MainCommandProcessor249:
;DriverRF4463PROMain.c,264 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor262
L_vRF4463MainCommandProcessor247:
;DriverRF4463PROMain.c,268 :: 		else if ( memcmp( CMD_RADIO_CHANNEL_SET, ucCommand, sizeof( CMD_RADIO_CHANNEL_SET ) ) == 0x00 ) {
; ucBuffer start address is: 24 (R6)
; ucCounterLongArgument start address is: 20 (R5)
MOVS	R1, #28
ADD	R1, SP, R1
MOVS	R2, #12
MOVW	R0, #lo_addr(_CMD_RADIO_CHANNEL_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_CHANNEL_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor263
; ucCounterLongArgument end address is: 20 (R5)
; ucBuffer end address is: 24 (R6)
;DriverRF4463PROMain.c,269 :: 		ulArgument = StrToInt( ucLongArgument );
MOVS	R1, #60
ADD	R1, SP, R1
MOV	R0, R1
BL	_StrToInt+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,271 :: 		if ( ulArgument >= 0 && ulArgument <= 50 ) {
LDR	R1, [R1, #0]
CMP	R1, #0
IT	CC
BLCC	L__vRF4463MainCommandProcessor443
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #50
IT	HI
BLHI	L__vRF4463MainCommandProcessor442
L__vRF4463MainCommandProcessor425:
;DriverRF4463PROMain.c,272 :: 		ucRF4463FreqChannel = ulArgument;    // Se aplica al ejecutar funciones de TX o RX
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R1, #hi_addr(_ucRF4463FreqChannel+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,273 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,274 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,275 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor267
;DriverRF4463PROMain.c,271 :: 		if ( ulArgument >= 0 && ulArgument <= 50 ) {
L__vRF4463MainCommandProcessor443:
L__vRF4463MainCommandProcessor442:
;DriverRF4463PROMain.c,277 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,278 :: 		}
L_vRF4463MainCommandProcessor267:
;DriverRF4463PROMain.c,279 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor268
L_vRF4463MainCommandProcessor263:
;DriverRF4463PROMain.c,283 :: 		else if ( memcmp( CMD_RADIO_BW_SET, ucCommand, sizeof( CMD_RADIO_BW_SET ) ) == 0x00 ) {
; ucBuffer start address is: 24 (R6)
; ucCounterLongArgument start address is: 20 (R5)
MOVS	R1, #28
ADD	R1, SP, R1
MOVS	R2, #7
MOVW	R0, #lo_addr(_CMD_RADIO_BW_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_BW_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor269
; ucCounterLongArgument end address is: 20 (R5)
; ucBuffer end address is: 24 (R6)
;DriverRF4463PROMain.c,284 :: 		ulArgument = StrToInt( ucLongArgument );
MOVS	R1, #60
ADD	R1, SP, R1
MOV	R0, R1
BL	_StrToInt+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,286 :: 		if ( ulArgument == 250 || ulArgument == 500 ) {
LDR	R1, [R1, #0]
CMP	R1, #250
IT	EQ
BLEQ	L__vRF4463MainCommandProcessor445
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVS	R1, #255
ADDS	R1, #245
CMP	R2, R1
IT	EQ
BLEQ	L__vRF4463MainCommandProcessor444
IT	AL
BLAL	L_vRF4463MainCommandProcessor272
L__vRF4463MainCommandProcessor445:
L__vRF4463MainCommandProcessor444:
;DriverRF4463PROMain.c,287 :: 		ulRF4463Step = ulArgument;
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #lo_addr(_ulRF4463Step+0)
MOVT	R1, #hi_addr(_ulRF4463Step+0)
STR	R2, [R1, #0]
;DriverRF4463PROMain.c,288 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,289 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,290 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor273
L_vRF4463MainCommandProcessor272:
;DriverRF4463PROMain.c,292 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,293 :: 		}
L_vRF4463MainCommandProcessor273:
;DriverRF4463PROMain.c,294 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor274
L_vRF4463MainCommandProcessor269:
;DriverRF4463PROMain.c,301 :: 		else if ( memcmp( CMD_RADIO_MODE_SET, ucCommand, sizeof( CMD_RADIO_MODE_SET ) ) == 0x00 ) {
; ucBuffer start address is: 24 (R6)
; ucCounterLongArgument start address is: 20 (R5)
MOVS	R1, #28
ADD	R1, SP, R1
MOVS	R2, #9
MOVW	R0, #lo_addr(_CMD_RADIO_MODE_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MODE_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor275
; ucCounterLongArgument end address is: 20 (R5)
; ucBuffer end address is: 24 (R6)
;DriverRF4463PROMain.c,303 :: 		ucCounterCommand = 0;
; ucCounterCommand start address is: 12 (R3)
MOVS	R3, #0
; ucCounterCommand end address is: 12 (R3)
;DriverRF4463PROMain.c,305 :: 		while ( ucLongArgument[ ucCounterCommand ] != ucUSARTNull && ucCounterCommand < 32 ) {
L_vRF4463MainCommandProcessor276:
; ucCounterCommand start address is: 12 (R3)
MOVS	R1, #60
ADD	R1, SP, R1
ADDS	R1, R1, R3
LDRB	R2, [R1, #0]
MOVW	R1, #lo_addr(_ucUSARTNull+0)
MOVT	R1, #hi_addr(_ucUSARTNull+0)
LDRB	R1, [R1, #0]
CMP	R2, R1
IT	EQ
BLEQ	L__vRF4463MainCommandProcessor447
CMP	R3, #32
IT	CS
BLCS	L__vRF4463MainCommandProcessor446
L__vRF4463MainCommandProcessor423:
;DriverRF4463PROMain.c,306 :: 		ucLongArgument[ ucCounterCommand ] = toupper( ucLongArgument[ ucCounterCommand ] );
MOVS	R1, #60
ADD	R1, SP, R1
ADDS	R1, R1, R3
STR	R1, [SP, #188]
LDRB	R1, [R1, #0]
UXTB	R0, R1
BL	_toupper+0
LDR	R1, [SP, #188]
STRB	R0, [R1, #0]
;DriverRF4463PROMain.c,307 :: 		ucCounterCommand++;
ADDS	R3, #1
UXTB	R3, R3
;DriverRF4463PROMain.c,308 :: 		}
; ucCounterCommand end address is: 12 (R3)
IT	AL
BLAL	L_vRF4463MainCommandProcessor276
;DriverRF4463PROMain.c,305 :: 		while ( ucLongArgument[ ucCounterCommand ] != ucUSARTNull && ucCounterCommand < 32 ) {
L__vRF4463MainCommandProcessor447:
L__vRF4463MainCommandProcessor446:
;DriverRF4463PROMain.c,311 :: 		if ( memcmp( ARG_RADIO_MODE_STBY, ucLongArgument, sizeof( ARG_RADIO_MODE_STBY ) ) == 0x00 ) {
MOVS	R1, #60
ADD	R1, SP, R1
MOVS	R2, #5
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_STBY+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_STBY+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor280
;DriverRF4463PROMain.c,312 :: 		ucRF4463Mode = rf_off;
MOVS	R2, #4
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,313 :: 		vUSART1Start_TX( ANS_COMMAND_MODE_STBY, strlen( ANS_COMMAND_MODE_STBY ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_STBY+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_STBY+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_STBY+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_STBY+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,314 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor281
L_vRF4463MainCommandProcessor280:
;DriverRF4463PROMain.c,315 :: 		else if ( memcmp( ARG_RADIO_MODE_TX_CONT, ucLongArgument, sizeof( ARG_RADIO_MODE_TX_CONT ) ) == 0x00 ) {
MOVS	R1, #60
ADD	R1, SP, R1
MOVS	R2, #8
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_TX_CONT+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_TX_CONT+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor282
;DriverRF4463PROMain.c,316 :: 		ucRF4463Mode = tx_test_mode;
MOVS	R2, #2
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,317 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,318 :: 		vUSART1Start_TX( ANS_COMMAND_MODE_TX_CONT, strlen( ANS_COMMAND_MODE_TX_CONT ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_CONT+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_CONT+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,319 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor283
L_vRF4463MainCommandProcessor282:
;DriverRF4463PROMain.c,320 :: 		else if ( memcmp( ARG_RADIO_MODE_RX_CONT, ucLongArgument, sizeof( ARG_RADIO_MODE_RX_CONT ) ) == 0x00 ) {
MOVS	R1, #60
ADD	R1, SP, R1
MOVS	R2, #8
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_RX_CONT+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_RX_CONT+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor284
;DriverRF4463PROMain.c,321 :: 		ucRF4463Mode = rx_test_mode;
MOVS	R2, #3
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,322 :: 		vUSART1Start_TX( ANS_COMMAND_MODE_RX_CONT, strlen( ANS_COMMAND_MODE_RX_CONT ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_CONT+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_CONT+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,323 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor285
L_vRF4463MainCommandProcessor284:
;DriverRF4463PROMain.c,324 :: 		else if ( memcmp( ARG_RADIO_MODE_TX_MASTER, ucLongArgument, sizeof( ARG_RADIO_MODE_TX_MASTER ) ) == 0x00 ) {
MOVS	R1, #60
ADD	R1, SP, R1
MOVS	R2, #10
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_TX_MASTER+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_TX_MASTER+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor286
;DriverRF4463PROMain.c,325 :: 		ucRF4463Mode = master_mode;
MOVS	R2, #0
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,326 :: 		vUSART1Start_TX( ANS_COMMAND_MODE_TX_MASTER, strlen( ANS_COMMAND_MODE_TX_MASTER ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,327 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor287
L_vRF4463MainCommandProcessor286:
;DriverRF4463PROMain.c,328 :: 		else if ( memcmp( ARG_RADIO_MODE_RX_SLAVE, ucLongArgument, sizeof( ARG_RADIO_MODE_RX_SLAVE ) ) == 0x00 ) {
MOVS	R1, #60
ADD	R1, SP, R1
MOVS	R2, #9
MOVW	R0, #lo_addr(_ARG_RADIO_MODE_RX_SLAVE+0)
MOVT	R0, #hi_addr(_ARG_RADIO_MODE_RX_SLAVE+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor288
;DriverRF4463PROMain.c,329 :: 		ucRF4463Mode = slave_mode;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,330 :: 		vUSART1Start_TX( ANS_COMMAND_MODE_RX_SLAVE, strlen( ANS_COMMAND_MODE_RX_SLAVE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,331 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor289
L_vRF4463MainCommandProcessor288:
;DriverRF4463PROMain.c,333 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,334 :: 		}
L_vRF4463MainCommandProcessor289:
L_vRF4463MainCommandProcessor287:
L_vRF4463MainCommandProcessor285:
L_vRF4463MainCommandProcessor283:
L_vRF4463MainCommandProcessor281:
;DriverRF4463PROMain.c,335 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor290
L_vRF4463MainCommandProcessor275:
;DriverRF4463PROMain.c,340 :: 		else if ( memcmp( CMD_RADIO_PACKET_SEND, ucCommand, sizeof( CMD_RADIO_PACKET_SEND ) ) == 0x00 ) {
; ucBuffer start address is: 24 (R6)
; ucCounterLongArgument start address is: 20 (R5)
MOVS	R1, #28
ADD	R1, SP, R1
MOVS	R2, #12
MOVW	R0, #lo_addr(_CMD_RADIO_PACKET_SEND+0)
MOVT	R0, #hi_addr(_CMD_RADIO_PACKET_SEND+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor291
; ucBuffer end address is: 24 (R6)
;DriverRF4463PROMain.c,342 :: 		if ( ucRF4463Mode == rf_off ) {
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
LDRB	R1, [R1, #0]
CMP	R1, #4
IT	NE
BLNE	L_vRF4463MainCommandProcessor292
;DriverRF4463PROMain.c,343 :: 		vUSARTStartMEMtoMEMZero( ucRF4463TXdata, sizeof( ucRF4463TXdata ));
MOVS	R1, #66
MOVW	R0, #lo_addr(_ucRF4463TXdata+0)
MOVT	R0, #hi_addr(_ucRF4463TXdata+0)
BL	_vUSARTStartMEMtoMEMZero+0
;DriverRF4463PROMain.c,344 :: 		vRF4463MainSetTXString();
BL	_vRF4463MainSetTXString+0
;DriverRF4463PROMain.c,345 :: 		ucTempChecksum = ucRF4463ChecksumGenerator( ucLongArgument ); //, ucCounterLongArgument );
MOVS	R1, #60
ADD	R1, SP, R1
MOV	R0, R1
BL	_ucRF4463ChecksumGenerator+0
; ucTempChecksum start address is: 0 (R0)
;DriverRF4463PROMain.c,347 :: 		vUSARTStartMEMtoMEM( ucLongArgument, ucRF4463TXdata + 4, ucCounterLongArgument );      //  ucCounterLongArgument );
MOVS	R1, #60
ADD	R1, SP, R1
STR	R0, [SP, #0]
; ucCounterLongArgument end address is: 20 (R5)
UXTB	R2, R5
MOV	R0, R1
MOVW	R1, #lo_addr(_ucRF4463TXdata+4)
MOVT	R1, #hi_addr(_ucRF4463TXdata+4)
BL	_vUSARTStartMEMtoMEM+0
LDR	R0, [SP, #0]
UXTB	R0, R0
;DriverRF4463PROMain.c,349 :: 		ucRF4463TXdata [ payload_length - 1 ] = ucTempChecksum;
MOVW	R1, #lo_addr(_ucRF4463TXdata+65)
MOVT	R1, #hi_addr(_ucRF4463TXdata+65)
STRB	R0, [R1, #0]
; ucTempChecksum end address is: 0 (R0)
;DriverRF4463PROMain.c,351 :: 		ucRF4463SendMessage = 1;          // pone la bandera para transmitir
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463SendMessage+0)
MOVT	R1, #hi_addr(_ucRF4463SendMessage+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,352 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor293
L_vRF4463MainCommandProcessor292:
;DriverRF4463PROMain.c,354 :: 		vUSART1Start_TX( ANS_COMMAND_WRONG_MODE, strlen( ANS_COMMAND_WRONG_MODE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_WRONG_MODE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_WRONG_MODE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_WRONG_MODE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_WRONG_MODE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,355 :: 		}
L_vRF4463MainCommandProcessor293:
;DriverRF4463PROMain.c,356 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor294
L_vRF4463MainCommandProcessor291:
;DriverRF4463PROMain.c,361 :: 		else if ( memcmp( CMD_RADIO_GET_STATUS, ucCommand, sizeof( CMD_RADIO_GET_STATUS ) ) == 0x00 ) {
; ucBuffer start address is: 24 (R6)
MOVS	R1, #28
ADD	R1, SP, R1
MOVS	R2, #11
MOVW	R0, #lo_addr(_CMD_RADIO_GET_STATUS+0)
MOVT	R0, #hi_addr(_CMD_RADIO_GET_STATUS+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor295
; ucBuffer end address is: 24 (R6)
;DriverRF4463PROMain.c,362 :: 		vUSART1Start_TX( ANS_STATUS_REPORT, strlen( ANS_STATUS_REPORT ) );
MOVW	R0, #lo_addr(_ANS_STATUS_REPORT+0)
MOVT	R0, #hi_addr(_ANS_STATUS_REPORT+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_STATUS_REPORT+0)
MOVT	R0, #hi_addr(_ANS_STATUS_REPORT+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,365 :: 		sprintf( ucTXT, "[ STATUS ] DECIMAL POWER: %d\r\n" , ucRF4463Power );
MOVW	R1, #lo_addr(_ucRF4463Power+0)
MOVT	R1, #hi_addr(_ucRF4463Power+0)
LDRB	R3, [R1, #0]
MOVW	R2, #lo_addr(?lstr_3_DriverRF4463PROMain+0)
MOVT	R2, #hi_addr(?lstr_3_DriverRF4463PROMain+0)
MOVS	R1, #124
ADD	R1, SP, R1
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_sprintf+0
ADD	SP, SP, #12
;DriverRF4463PROMain.c,366 :: 		vUSART1Start_TX( ucTXT, strlen( ucTXT ) );
MOVS	R1, #124
ADD	R1, SP, R1
MOV	R0, R1
BL	_strlen+0
MOVS	R1, #124
ADD	R1, SP, R1
STR	R1, [SP, #0]
SXTH	R1, R0
LDR	R0, [SP, #0]
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,369 :: 		ulArgument = ( ( ucRF4463Freq3 * 100 ) + ( ucRF4463Freq2 * 10 ) + ucRF4463Freq1 ) * 1000UL;
MOVW	R1, #lo_addr(_ucRF4463Freq3+0)
MOVT	R1, #hi_addr(_ucRF4463Freq3+0)
LDRB	R2, [R1, #0]
MOVS	R1, #100
MOV	R4, R1
MULS	R4, R2, R4
SXTH	R4, R4
MOVW	R1, #lo_addr(_ucRF4463Freq2+0)
MOVT	R1, #hi_addr(_ucRF4463Freq2+0)
LDRB	R3, [R1, #0]
MOVS	R2, #10
MOV	R1, R2
MULS	R1, R3, R1
SXTH	R1, R1
ADDS	R2, R4, R1
SXTH	R2, R2
MOVW	R1, #lo_addr(_ucRF4463Freq1+0)
MOVT	R1, #hi_addr(_ucRF4463Freq1+0)
LDRB	R1, [R1, #0]
ADDS	R3, R2, R1
SXTH	R3, R3
MOVW	R1, #1000
MOVT	R1, #0
MOV	R2, R1
MULS	R2, R3, R2
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R2, [R1, #0]
;DriverRF4463PROMain.c,370 :: 		sprintf( ucTXT, "[ STATUS ] BAND: %lu KHz\r\n" , ulArgument );
MOV	R3, R2
MOVW	R2, #lo_addr(?lstr_4_DriverRF4463PROMain+0)
MOVT	R2, #hi_addr(?lstr_4_DriverRF4463PROMain+0)
MOVS	R1, #124
ADD	R1, SP, R1
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_sprintf+0
ADD	SP, SP, #12
;DriverRF4463PROMain.c,371 :: 		vUSART1Start_TX( ucTXT, strlen( ucTXT ) );
MOVS	R1, #124
ADD	R1, SP, R1
MOV	R0, R1
BL	_strlen+0
MOVS	R1, #124
ADD	R1, SP, R1
STR	R1, [SP, #0]
SXTH	R1, R0
LDR	R0, [SP, #0]
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,374 :: 		switch ( ucRF4463Rate ) {
IT	AL
BLAL	L_vRF4463MainCommandProcessor296
;DriverRF4463PROMain.c,375 :: 		case dr_1p2    : ulArgument = 1200;
L_vRF4463MainCommandProcessor298:
MOVW	R2, #1200
MOVT	R2, #0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R2, [R1, #0]
;DriverRF4463PROMain.c,376 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor297
;DriverRF4463PROMain.c,377 :: 		case dr_2p4    : ulArgument = 2400;
L_vRF4463MainCommandProcessor299:
MOVW	R2, #2400
MOVT	R2, #0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R2, [R1, #0]
;DriverRF4463PROMain.c,378 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor297
;DriverRF4463PROMain.c,379 :: 		case dr_4p8    : ulArgument = 4800;
L_vRF4463MainCommandProcessor300:
MOVW	R2, #4800
MOVT	R2, #0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R2, [R1, #0]
;DriverRF4463PROMain.c,380 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor297
;DriverRF4463PROMain.c,381 :: 		case dr_9p6    : ulArgument = 9600;
L_vRF4463MainCommandProcessor301:
MOVW	R2, #9600
MOVT	R2, #0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R2, [R1, #0]
;DriverRF4463PROMain.c,382 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor297
;DriverRF4463PROMain.c,383 :: 		case dr_19p2   : ulArgument = 19200;
L_vRF4463MainCommandProcessor302:
MOVW	R2, #19200
MOVT	R2, #0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R2, [R1, #0]
;DriverRF4463PROMain.c,384 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor297
;DriverRF4463PROMain.c,385 :: 		case dr_38p4   : ulArgument = 38400;
L_vRF4463MainCommandProcessor303:
MOVW	R2, #38400
MOVT	R2, #0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R2, [R1, #0]
;DriverRF4463PROMain.c,386 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor297
;DriverRF4463PROMain.c,387 :: 		case dr_76p8   : ulArgument = 76800;
L_vRF4463MainCommandProcessor304:
MOVW	R2, #11264
MOVT	R2, #1
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R2, [R1, #0]
;DriverRF4463PROMain.c,388 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor297
;DriverRF4463PROMain.c,389 :: 		case dr_115p2  : ulArgument = 115200;
L_vRF4463MainCommandProcessor305:
MOVW	R2, #49664
MOVT	R2, #1
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R2, [R1, #0]
;DriverRF4463PROMain.c,390 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor297
;DriverRF4463PROMain.c,391 :: 		case dr_256k   : ulArgument = 256000;
L_vRF4463MainCommandProcessor306:
MOVW	R2, #59392
MOVT	R2, #3
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R2, [R1, #0]
;DriverRF4463PROMain.c,392 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor297
;DriverRF4463PROMain.c,393 :: 		case dr_500k   : ulArgument = 500000;
L_vRF4463MainCommandProcessor307:
MOVW	R2, #41248
MOVT	R2, #7
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R2, [R1, #0]
;DriverRF4463PROMain.c,394 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor297
;DriverRF4463PROMain.c,395 :: 		case dr_500    : ulArgument = 500;
L_vRF4463MainCommandProcessor308:
MOVS	R2, #255
ADDS	R2, #245
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R2, [R1, #0]
;DriverRF4463PROMain.c,396 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor297
;DriverRF4463PROMain.c,397 :: 		}
L_vRF4463MainCommandProcessor296:
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R1, #0]
CMP	R1, #0
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor298
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R1, #0]
CMP	R1, #1
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor299
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R1, #0]
CMP	R1, #2
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor300
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R1, #0]
CMP	R1, #3
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor301
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R1, #0]
CMP	R1, #4
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor302
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R1, #0]
CMP	R1, #5
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor303
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R1, #0]
CMP	R1, #6
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor304
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R1, #0]
CMP	R1, #7
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor305
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R1, #0]
CMP	R1, #8
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor306
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R1, #0]
CMP	R1, #9
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor307
MOVW	R1, #lo_addr(_ucRF4463Rate+0)
MOVT	R1, #hi_addr(_ucRF4463Rate+0)
LDRB	R1, [R1, #0]
CMP	R1, #10
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor308
L_vRF4463MainCommandProcessor297:
;DriverRF4463PROMain.c,398 :: 		sprintf( ucTXT, "[ STATUS ] DATA RATE: %lu\r\n" , ulArgument );
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R3, [R1, #0]
MOVW	R2, #lo_addr(?lstr_5_DriverRF4463PROMain+0)
MOVT	R2, #hi_addr(?lstr_5_DriverRF4463PROMain+0)
MOVS	R1, #124
ADD	R1, SP, R1
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_sprintf+0
ADD	SP, SP, #12
;DriverRF4463PROMain.c,399 :: 		vUSART1Start_TX( ucTXT, strlen( ucTXT ) );
MOVS	R1, #124
ADD	R1, SP, R1
MOV	R0, R1
BL	_strlen+0
MOVS	R1, #124
ADD	R1, SP, R1
STR	R1, [SP, #0]
SXTH	R1, R0
LDR	R0, [SP, #0]
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,402 :: 		sprintf( ucTXT, "[ STATUS ] CHANNEL: %d\r\n" , ucRF4463FreqChannel );
MOVW	R1, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R1, #hi_addr(_ucRF4463FreqChannel+0)
LDRB	R3, [R1, #0]
MOVW	R2, #lo_addr(?lstr_6_DriverRF4463PROMain+0)
MOVT	R2, #hi_addr(?lstr_6_DriverRF4463PROMain+0)
MOVS	R1, #124
ADD	R1, SP, R1
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_sprintf+0
ADD	SP, SP, #12
;DriverRF4463PROMain.c,403 :: 		vUSART1Start_TX( ucTXT, strlen( ucTXT ) );
MOVS	R1, #124
ADD	R1, SP, R1
MOV	R0, R1
BL	_strlen+0
MOVS	R1, #124
ADD	R1, SP, R1
STR	R1, [SP, #0]
SXTH	R1, R0
LDR	R0, [SP, #0]
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,406 :: 		sprintf( ucTXT, "[ STATUS ] BW: %lu KHz\r\n" , ulRF4463Step );
MOVW	R1, #lo_addr(_ulRF4463Step+0)
MOVT	R1, #hi_addr(_ulRF4463Step+0)
LDR	R3, [R1, #0]
MOVW	R2, #lo_addr(?lstr_7_DriverRF4463PROMain+0)
MOVT	R2, #hi_addr(?lstr_7_DriverRF4463PROMain+0)
MOVS	R1, #124
ADD	R1, SP, R1
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_sprintf+0
ADD	SP, SP, #12
;DriverRF4463PROMain.c,407 :: 		vUSART1Start_TX( ucTXT, strlen( ucTXT ) );
MOVS	R1, #124
ADD	R1, SP, R1
MOV	R0, R1
BL	_strlen+0
MOVS	R1, #124
ADD	R1, SP, R1
STR	R1, [SP, #0]
SXTH	R1, R0
LDR	R0, [SP, #0]
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,411 :: 		vUSART1Start_TX( "[ STATUS ] MODE: ", 17 );
MOVS	R6, #8
ADD	R6, SP, R6
MOVS	R5, #18
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr8_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr8_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R1, #8
ADD	R1, SP, R1
MOV	R0, R1
MOVS	R1, #17
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,413 :: 		switch ( ucRF4463Mode ) {
IT	AL
BLAL	L_vRF4463MainCommandProcessor309
;DriverRF4463PROMain.c,414 :: 		case rf_off        : vUSART1Start_TX( ANS_COMMAND_MODE_STBY, strlen( ANS_COMMAND_MODE_STBY ) );
L_vRF4463MainCommandProcessor311:
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_STBY+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_STBY+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_STBY+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_STBY+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,415 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor310
;DriverRF4463PROMain.c,416 :: 		case tx_test_mode  : vUSART1Start_TX( ANS_COMMAND_MODE_TX_CONT, strlen( ANS_COMMAND_MODE_TX_CONT ) );
L_vRF4463MainCommandProcessor312:
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_CONT+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_CONT+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,417 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor310
;DriverRF4463PROMain.c,418 :: 		case rx_test_mode  : vUSART1Start_TX( ANS_COMMAND_MODE_RX_CONT, strlen( ANS_COMMAND_MODE_RX_CONT ) );
L_vRF4463MainCommandProcessor313:
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_CONT+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_CONT+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_CONT+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,419 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor310
;DriverRF4463PROMain.c,420 :: 		case master_mode   : vUSART1Start_TX( ANS_COMMAND_MODE_TX_MASTER, strlen( ANS_COMMAND_MODE_TX_MASTER ) );
L_vRF4463MainCommandProcessor314:
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_TX_MASTER+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,421 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor310
;DriverRF4463PROMain.c,422 :: 		case slave_mode    : vUSART1Start_TX( ANS_COMMAND_MODE_RX_SLAVE, strlen( ANS_COMMAND_MODE_RX_SLAVE ) );
L_vRF4463MainCommandProcessor315:
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_MODE_RX_SLAVE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,423 :: 		break;
IT	AL
BLAL	L_vRF4463MainCommandProcessor310
;DriverRF4463PROMain.c,424 :: 		}
L_vRF4463MainCommandProcessor309:
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
LDRB	R1, [R1, #0]
CMP	R1, #4
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor311
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
LDRB	R1, [R1, #0]
CMP	R1, #2
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor312
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
LDRB	R1, [R1, #0]
CMP	R1, #3
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor313
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
LDRB	R1, [R1, #0]
CMP	R1, #0
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor314
MOVW	R1, #lo_addr(_ucRF4463Mode+0)
MOVT	R1, #hi_addr(_ucRF4463Mode+0)
LDRB	R1, [R1, #0]
CMP	R1, #1
IT	EQ
BLEQ	L_vRF4463MainCommandProcessor315
L_vRF4463MainCommandProcessor310:
;DriverRF4463PROMain.c,425 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor316
L_vRF4463MainCommandProcessor295:
;DriverRF4463PROMain.c,429 :: 		else if ( memcmp( CMD_RADIO_MATCH_BYTE_1_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_1_SET ) ) == 0x00 ) {
; ucBuffer start address is: 24 (R6)
MOVS	R1, #28
ADD	R1, SP, R1
MOVS	R2, #12
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_BYTE_1_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_BYTE_1_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor317
; ucBuffer end address is: 24 (R6)
;DriverRF4463PROMain.c,430 :: 		ulArgument = StrToLong( ucLongArgument );
MOVS	R1, #60
ADD	R1, SP, R1
MOV	R0, R1
BL	_StrToLong+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,431 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BLCC	L__vRF4463MainCommandProcessor449
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #255
IT	HI
BLHI	L__vRF4463MainCommandProcessor448
L__vRF4463MainCommandProcessor422:
;DriverRF4463PROMain.c,432 :: 		ucRF4463ByteMatch1 = ulArgument;
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #lo_addr(_ucRF4463ByteMatch1+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMatch1+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,433 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,434 :: 		ucRF4463MatchEnableReg = 0x40;
MOVS	R2, #64
MOVW	R1, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,435 :: 		vRF4463MainSetTXString();
BL	_vRF4463MainSetTXString+0
;DriverRF4463PROMain.c,436 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,437 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,438 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor321
;DriverRF4463PROMain.c,431 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor449:
L__vRF4463MainCommandProcessor448:
;DriverRF4463PROMain.c,440 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,441 :: 		}
L_vRF4463MainCommandProcessor321:
;DriverRF4463PROMain.c,442 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor322
L_vRF4463MainCommandProcessor317:
;DriverRF4463PROMain.c,446 :: 		else if ( memcmp( CMD_RADIO_MATCH_BYTE_2_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_2_SET ) ) == 0x00 ) {
; ucBuffer start address is: 24 (R6)
MOVS	R1, #28
ADD	R1, SP, R1
MOVS	R2, #12
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_BYTE_2_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_BYTE_2_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor323
; ucBuffer end address is: 24 (R6)
;DriverRF4463PROMain.c,447 :: 		ulArgument = StrToLong( ucLongArgument );
MOVS	R1, #60
ADD	R1, SP, R1
MOV	R0, R1
BL	_StrToLong+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,448 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BLCC	L__vRF4463MainCommandProcessor451
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #255
IT	HI
BLHI	L__vRF4463MainCommandProcessor450
L__vRF4463MainCommandProcessor421:
;DriverRF4463PROMain.c,449 :: 		ucRF4463ByteMatch2 = ulArgument;
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #lo_addr(_ucRF4463ByteMatch2+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMatch2+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,450 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,451 :: 		ucRF4463MatchEnableReg = 0x40;
MOVS	R2, #64
MOVW	R1, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,452 :: 		vRF4463MainSetTXString();
BL	_vRF4463MainSetTXString+0
;DriverRF4463PROMain.c,453 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,454 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,455 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor327
;DriverRF4463PROMain.c,448 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor451:
L__vRF4463MainCommandProcessor450:
;DriverRF4463PROMain.c,457 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,458 :: 		}
L_vRF4463MainCommandProcessor327:
;DriverRF4463PROMain.c,459 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor328
L_vRF4463MainCommandProcessor323:
;DriverRF4463PROMain.c,463 :: 		else if ( memcmp( CMD_RADIO_MATCH_BYTE_3_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_3_SET ) ) == 0x00 ) {
; ucBuffer start address is: 24 (R6)
MOVS	R1, #28
ADD	R1, SP, R1
MOVS	R2, #12
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_BYTE_3_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_BYTE_3_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor329
; ucBuffer end address is: 24 (R6)
;DriverRF4463PROMain.c,464 :: 		ulArgument = StrToLong( ucLongArgument );
MOVS	R1, #60
ADD	R1, SP, R1
MOV	R0, R1
BL	_StrToLong+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,465 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BLCC	L__vRF4463MainCommandProcessor453
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #255
IT	HI
BLHI	L__vRF4463MainCommandProcessor452
L__vRF4463MainCommandProcessor420:
;DriverRF4463PROMain.c,466 :: 		ucRF4463ByteMatch3 = ulArgument;
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #lo_addr(_ucRF4463ByteMatch3+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMatch3+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,467 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,468 :: 		ucRF4463MatchEnableReg = 0x40;
MOVS	R2, #64
MOVW	R1, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,469 :: 		vRF4463MainSetTXString();
BL	_vRF4463MainSetTXString+0
;DriverRF4463PROMain.c,470 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,471 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,472 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor333
;DriverRF4463PROMain.c,465 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor453:
L__vRF4463MainCommandProcessor452:
;DriverRF4463PROMain.c,474 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,475 :: 		}
L_vRF4463MainCommandProcessor333:
;DriverRF4463PROMain.c,476 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor334
L_vRF4463MainCommandProcessor329:
;DriverRF4463PROMain.c,480 :: 		else if ( memcmp( CMD_RADIO_MATCH_BYTE_4_SET, ucCommand, sizeof( CMD_RADIO_MATCH_BYTE_4_SET ) ) == 0x00 ) {
; ucBuffer start address is: 24 (R6)
MOVS	R1, #28
ADD	R1, SP, R1
MOVS	R2, #12
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_BYTE_4_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_BYTE_4_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor335
; ucBuffer end address is: 24 (R6)
;DriverRF4463PROMain.c,481 :: 		ulArgument = StrToLong( ucLongArgument );
MOVS	R1, #60
ADD	R1, SP, R1
MOV	R0, R1
BL	_StrToLong+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,482 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BLCC	L__vRF4463MainCommandProcessor455
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #255
IT	HI
BLHI	L__vRF4463MainCommandProcessor454
L__vRF4463MainCommandProcessor419:
;DriverRF4463PROMain.c,483 :: 		ucRF4463ByteMatch4 = ulArgument;
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #lo_addr(_ucRF4463ByteMatch4+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMatch4+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,484 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,485 :: 		ucRF4463MatchEnableReg = 0x40;
MOVS	R2, #64
MOVW	R1, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,486 :: 		vRF4463MainSetTXString();
BL	_vRF4463MainSetTXString+0
;DriverRF4463PROMain.c,487 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,488 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,489 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor339
;DriverRF4463PROMain.c,482 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor455:
L__vRF4463MainCommandProcessor454:
;DriverRF4463PROMain.c,491 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,492 :: 		}
L_vRF4463MainCommandProcessor339:
;DriverRF4463PROMain.c,493 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor340
L_vRF4463MainCommandProcessor335:
;DriverRF4463PROMain.c,497 :: 		else if ( memcmp( CMD_RADIO_MATCH_MASK_1_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_1_SET ) ) == 0x00 ) {
; ucBuffer start address is: 24 (R6)
MOVS	R1, #28
ADD	R1, SP, R1
MOVS	R2, #11
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_MASK_1_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_MASK_1_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor341
; ucBuffer end address is: 24 (R6)
;DriverRF4463PROMain.c,498 :: 		ulArgument = StrToLong( ucLongArgument );
MOVS	R1, #60
ADD	R1, SP, R1
MOV	R0, R1
BL	_StrToLong+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,499 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BLCC	L__vRF4463MainCommandProcessor457
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #255
IT	HI
BLHI	L__vRF4463MainCommandProcessor456
L__vRF4463MainCommandProcessor418:
;DriverRF4463PROMain.c,500 :: 		ucRF4463ByteMask1 = ulArgument;
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #lo_addr(_ucRF4463ByteMask1+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMask1+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,501 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,502 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,503 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,504 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor345
;DriverRF4463PROMain.c,499 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor457:
L__vRF4463MainCommandProcessor456:
;DriverRF4463PROMain.c,506 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,507 :: 		}
L_vRF4463MainCommandProcessor345:
;DriverRF4463PROMain.c,508 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor346
L_vRF4463MainCommandProcessor341:
;DriverRF4463PROMain.c,512 :: 		else if ( memcmp( CMD_RADIO_MATCH_MASK_2_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_2_SET ) ) == 0x00 ) {
; ucBuffer start address is: 24 (R6)
MOVS	R1, #28
ADD	R1, SP, R1
MOVS	R2, #11
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_MASK_2_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_MASK_2_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor347
; ucBuffer end address is: 24 (R6)
;DriverRF4463PROMain.c,513 :: 		ulArgument = StrToLong( ucLongArgument );
MOVS	R1, #60
ADD	R1, SP, R1
MOV	R0, R1
BL	_StrToLong+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,514 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BLCC	L__vRF4463MainCommandProcessor459
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #255
IT	HI
BLHI	L__vRF4463MainCommandProcessor458
L__vRF4463MainCommandProcessor417:
;DriverRF4463PROMain.c,515 :: 		ucRF4463ByteMask2 = ulArgument;
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #lo_addr(_ucRF4463ByteMask2+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMask2+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,516 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,517 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,518 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,519 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor351
;DriverRF4463PROMain.c,514 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor459:
L__vRF4463MainCommandProcessor458:
;DriverRF4463PROMain.c,521 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,522 :: 		}
L_vRF4463MainCommandProcessor351:
;DriverRF4463PROMain.c,523 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor352
L_vRF4463MainCommandProcessor347:
;DriverRF4463PROMain.c,527 :: 		else if ( memcmp( CMD_RADIO_MATCH_MASK_3_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_3_SET ) ) == 0x00 ) {
; ucBuffer start address is: 24 (R6)
MOVS	R1, #28
ADD	R1, SP, R1
MOVS	R2, #11
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_MASK_3_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_MASK_3_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor353
; ucBuffer end address is: 24 (R6)
;DriverRF4463PROMain.c,528 :: 		ulArgument = StrToLong( ucLongArgument );
MOVS	R1, #60
ADD	R1, SP, R1
MOV	R0, R1
BL	_StrToLong+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,529 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BLCC	L__vRF4463MainCommandProcessor461
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #255
IT	HI
BLHI	L__vRF4463MainCommandProcessor460
L__vRF4463MainCommandProcessor416:
;DriverRF4463PROMain.c,530 :: 		ucRF4463ByteMask3 = ulArgument;
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #lo_addr(_ucRF4463ByteMask3+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMask3+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,531 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,532 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,533 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,534 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor357
;DriverRF4463PROMain.c,529 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor461:
L__vRF4463MainCommandProcessor460:
;DriverRF4463PROMain.c,536 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,537 :: 		}
L_vRF4463MainCommandProcessor357:
;DriverRF4463PROMain.c,538 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor358
L_vRF4463MainCommandProcessor353:
;DriverRF4463PROMain.c,542 :: 		else if ( memcmp( CMD_RADIO_MATCH_MASK_4_SET, ucCommand, sizeof( CMD_RADIO_MATCH_MASK_4_SET ) ) == 0x00 ) {
; ucBuffer start address is: 24 (R6)
MOVS	R1, #28
ADD	R1, SP, R1
MOVS	R2, #11
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_MASK_4_SET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_MASK_4_SET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor359
; ucBuffer end address is: 24 (R6)
;DriverRF4463PROMain.c,543 :: 		ulArgument = StrToLong( ucLongArgument );
MOVS	R1, #60
ADD	R1, SP, R1
MOV	R0, R1
BL	_StrToLong+0
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,544 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
CMP	R0, #0
IT	CC
BLCC	L__vRF4463MainCommandProcessor463
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R1, [R1, #0]
CMP	R1, #255
IT	HI
BLHI	L__vRF4463MainCommandProcessor462
L__vRF4463MainCommandProcessor415:
;DriverRF4463PROMain.c,545 :: 		ucRF4463ByteMask4 = ulArgument;
MOVW	R1, #lo_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
MOVT	R1, #hi_addr(vRF4463MainCommandProcessor_ulArgument_L0+0)
LDR	R2, [R1, #0]
MOVW	R1, #lo_addr(_ucRF4463ByteMask4+0)
MOVT	R1, #hi_addr(_ucRF4463ByteMask4+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,546 :: 		ucRF4463MatchEnabled = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnabled+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnabled+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,547 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,548 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,549 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor363
;DriverRF4463PROMain.c,544 :: 		if ( ulArgument >= 0 && ulArgument <= 255 ) {
L__vRF4463MainCommandProcessor463:
L__vRF4463MainCommandProcessor462:
;DriverRF4463PROMain.c,551 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_OUT_OF_RANGE, strlen( ANS_COMMAND_VALUE_OUT_OF_RANGE ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_OUT_OF_RANGE+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,552 :: 		}
L_vRF4463MainCommandProcessor363:
;DriverRF4463PROMain.c,553 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor364
L_vRF4463MainCommandProcessor359:
;DriverRF4463PROMain.c,557 :: 		else if ( memcmp( CMD_RADIO_MATCH_UNSET, ucCommand, sizeof( CMD_RADIO_MATCH_UNSET ) ) == 0x00 ) {
; ucBuffer start address is: 24 (R6)
MOVS	R1, #28
ADD	R1, SP, R1
MOVS	R2, #12
MOVW	R0, #lo_addr(_CMD_RADIO_MATCH_UNSET+0)
MOVT	R0, #hi_addr(_CMD_RADIO_MATCH_UNSET+0)
BL	_memcmp+0
CMP	R0, #0
IT	NE
BLNE	L_vRF4463MainCommandProcessor365
; ucBuffer end address is: 24 (R6)
;DriverRF4463PROMain.c,559 :: 		ucRF4463MatchEnableReg = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(_ucRF4463MatchEnableReg+0)
MOVT	R1, #hi_addr(_ucRF4463MatchEnableReg+0)
STRB	R2, [R1, #0]
;DriverRF4463PROMain.c,560 :: 		vRF4463MainApplyChanges();
BL	_vRF4463MainApplyChanges+0
;DriverRF4463PROMain.c,561 :: 		vUSART1Start_TX( ANS_COMMAND_VALUE_ACCEPTED, strlen( ANS_COMMAND_VALUE_ACCEPTED ) );
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
MOVT	R0, #hi_addr(_ANS_COMMAND_VALUE_ACCEPTED+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,566 :: 		}
IT	AL
BLAL	L_vRF4463MainCommandProcessor366
L_vRF4463MainCommandProcessor365:
;DriverRF4463PROMain.c,570 :: 		vUSART1Start_TX( ANS_DEBUG_COMMAND_UNKNOWN, strlen( ANS_DEBUG_COMMAND_UNKNOWN ) );
; ucBuffer start address is: 24 (R6)
MOVW	R0, #lo_addr(_ANS_DEBUG_COMMAND_UNKNOWN+0)
MOVT	R0, #hi_addr(_ANS_DEBUG_COMMAND_UNKNOWN+0)
BL	_strlen+0
SXTH	R1, R0
MOVW	R0, #lo_addr(_ANS_DEBUG_COMMAND_UNKNOWN+0)
MOVT	R0, #hi_addr(_ANS_DEBUG_COMMAND_UNKNOWN+0)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,571 :: 		vUSART1Start_TX( ucBuffer, strlen( ucBuffer ) );  // DEPURACION
MOV	R0, R6
BL	_strlen+0
SXTH	R1, R0
MOV	R0, R6
; ucBuffer end address is: 24 (R6)
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,572 :: 		}
L_vRF4463MainCommandProcessor366:
L_vRF4463MainCommandProcessor364:
L_vRF4463MainCommandProcessor358:
L_vRF4463MainCommandProcessor352:
L_vRF4463MainCommandProcessor346:
L_vRF4463MainCommandProcessor340:
L_vRF4463MainCommandProcessor334:
L_vRF4463MainCommandProcessor328:
L_vRF4463MainCommandProcessor322:
L_vRF4463MainCommandProcessor316:
L_vRF4463MainCommandProcessor294:
L_vRF4463MainCommandProcessor290:
L_vRF4463MainCommandProcessor274:
L_vRF4463MainCommandProcessor268:
L_vRF4463MainCommandProcessor262:
L_vRF4463MainCommandProcessor246:
L_vRF4463MainCommandProcessor240:
;DriverRF4463PROMain.c,573 :: 		}
L_end_vRF4463MainCommandProcessor:
ADD	SP, SP, #192
POP	(R15)
; end of _vRF4463MainCommandProcessor
_InitTimer2:
;DriverRF4463PROMain.c,579 :: 		void InitTimer2(){
PUSH	(R14)
;DriverRF4463PROMain.c,591 :: 		RCC_APBENR1bits.TIM2EN = 1;
MOVW	R2, #lo_addr(RCC_APBENR1bits+0)
MOVT	R2, #hi_addr(RCC_APBENR1bits+0)
_LX	[R2, ByteOffset(RCC_APBENR1bits+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(RCC_APBENR1bits+0)]
;DriverRF4463PROMain.c,592 :: 		TIM2_CR1.CEN = 0;
MOVW	R2, #lo_addr(TIM2_CR1+0)
MOVT	R2, #hi_addr(TIM2_CR1+0)
_LX	[R2, ByteOffset(TIM2_CR1+0)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(TIM2_CR1+0)]
;DriverRF4463PROMain.c,593 :: 		TIM2_PSC = 249;
MOVS	R1, #249
MOVW	R0, #lo_addr(TIM2_PSC+0)
MOVT	R0, #hi_addr(TIM2_PSC+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,594 :: 		TIM2_ARR = 63999;
MOVW	R1, #63999
MOVT	R1, #0
MOVW	R0, #lo_addr(TIM2_ARR+0)
MOVT	R0, #hi_addr(TIM2_ARR+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,595 :: 		NVIC_IntEnable( IVT_INT_TIM2 );
MOVS	R0, #31
BL	_NVIC_IntEnable+0
;DriverRF4463PROMain.c,596 :: 		TIM2_DIER.UIE = 1;
MOVW	R2, #lo_addr(TIM2_DIER+0)
MOVT	R2, #hi_addr(TIM2_DIER+0)
_LX	[R2, ByteOffset(TIM2_DIER+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(TIM2_DIER+0)]
;DriverRF4463PROMain.c,597 :: 		TIM2_CR1.CEN = 1;
MOVW	R2, #lo_addr(TIM2_CR1+0)
MOVT	R2, #hi_addr(TIM2_CR1+0)
_LX	[R2, ByteOffset(TIM2_CR1+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(TIM2_CR1+0)]
;DriverRF4463PROMain.c,599 :: 		}
L_end_InitTimer2:
POP	(R15)
; end of _InitTimer2
_main:
;DriverRF4463PROMain.c,603 :: 		void main() {
SUB	SP, SP, #100
;DriverRF4463PROMain.c,607 :: 		Delay_ms( 2000 );                    // delay de depuracion
LDR	R7, [PC, #7999999]
NOP
L_main367:
SUBS	R7, R7, #1
BNE	L_main367
B	#4
	#7999999
NOP
;DriverRF4463PROMain.c,720 :: 		GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_6 );  // r   ( Led Rojo de tarjeta de desarrollo )
MOVS	R1, #64
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,721 :: 		GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_7 );  // g
MOVS	R1, #128
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,722 :: 		GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_8 );  // b
MOVS	R1, #255
ADDS	R1, #1
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,723 :: 		GPIO_Digital_Output( &GPIOA_BASE, _GPIO_PINMASK_4 );  // Enable Led´s
MOVS	R1, #16
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,725 :: 		GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_9 );
MOVW	R1, #512
MOVT	R1, #0
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,728 :: 		GPIO_Digital_Input( &GPIOC_BASE, _GPIO_PINMASK_14 );
MOVW	R1, #16384
MOVT	R1, #0
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Input+0
;DriverRF4463PROMain.c,729 :: 		GPIO_Digital_Input( &GPIOC_BASE, _GPIO_PINMASK_15 );
MOVW	R1, #32768
MOVT	R1, #0
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Input+0
;DriverRF4463PROMain.c,734 :: 		GPIO_Digital_Input( &GPIOA_BASE, _GPIO_PINMASK_2 );          // nIRQ
MOVS	R1, #4
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Input+0
;DriverRF4463PROMain.c,736 :: 		GPIO_Digital_Output( &GPIOA_BASE, _GPIO_PINMASK_3 );         // nSEL
MOVS	R1, #8
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,737 :: 		GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_2 );         // SDN
MOVS	R1, #4
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,738 :: 		GPIO_Digital_Output( &GPIOA_BASE, _GPIO_PINMASK_11 );        // GPIO0
MOVW	R1, #2048
MOVT	R1, #0
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,739 :: 		GPIO_Digital_Output( &GPIOA_BASE, _GPIO_PINMASK_12 );        // GPIO1
MOVW	R1, #4096
MOVT	R1, #0
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,741 :: 		_REG_RADIO = 1;
MOVW	R2, #lo_addr(GPIOB_ODR+0)
MOVT	R2, #hi_addr(GPIOB_ODR+0)
_LX	[R2, ByteOffset(GPIOB_ODR+0)]
MOVS	R1, #1
LSLS	R1, R1, #9
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODR+0)]
;DriverRF4463PROMain.c,757 :: 		RCC_APBENR2bits.SYSCFGEN = 1;
MOVW	R2, #lo_addr(RCC_APBENR2bits+0)
MOVT	R2, #hi_addr(RCC_APBENR2bits+0)
_LX	[R2, ByteOffset(RCC_APBENR2bits+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(RCC_APBENR2bits+0)]
;DriverRF4463PROMain.c,759 :: 		SYSCFG_VREFBUF_CFGR1bits.UCPD1_STROBE = 1;
MOVW	R2, #lo_addr(SYSCFG_VREFBUF_CFGR1bits+0)
MOVT	R2, #hi_addr(SYSCFG_VREFBUF_CFGR1bits+0)
_LX	[R2, ByteOffset(SYSCFG_VREFBUF_CFGR1bits+0)]
MOVS	R1, #1
LSLS	R1, R1, #9
ORRS	R0, R1
_SX	[R2, ByteOffset(SYSCFG_VREFBUF_CFGR1bits+0)]
;DriverRF4463PROMain.c,762 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;DriverRF4463PROMain.c,764 :: 		LED_RED      = 0;
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_LX	[R2, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #128
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;DriverRF4463PROMain.c,765 :: 		LED_GREEN    = 0;
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_LX	[R2, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #64
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;DriverRF4463PROMain.c,766 :: 		LED_BLUE     = 0;
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_LX	[R2, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #1
LSLS	R1, R1, #8
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;DriverRF4463PROMain.c,768 :: 		Delay_ms( 100 );
LDR	R7, [PC, #399999]
NOP
L_main369:
SUBS	R7, R7, #1
BNE	L_main369
B	#4
	#399999
NOP
;DriverRF4463PROMain.c,770 :: 		LED_RED      = 1;
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_LX	[R2, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #128
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;DriverRF4463PROMain.c,771 :: 		LED_GREEN    = 1;
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_LX	[R2, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #64
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;DriverRF4463PROMain.c,772 :: 		LED_BLUE     = 1;
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_LX	[R2, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #1
LSLS	R1, R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;DriverRF4463PROMain.c,774 :: 		InitTimer2();
BL	_InitTimer2+0
;DriverRF4463PROMain.c,777 :: 		vUSARTConfigUSART1( 115200 );  // configura todos las parametros de USART
MOVW	R0, #49664
MOVT	R0, #1
BL	_vUSARTConfigUSART1+0
;DriverRF4463PROMain.c,793 :: 		vSPI1Init();           // configura todos los parametros de SPI
BL	_vSPI1Init+0
;DriverRF4463PROMain.c,799 :: 		ucRF4463Freq3 = 9;
MOVS	R1, #9
MOVW	R0, #lo_addr(_ucRF4463Freq3+0)
MOVT	R0, #hi_addr(_ucRF4463Freq3+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,800 :: 		ucRF4463Freq2 = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463Freq2+0)
MOVT	R0, #hi_addr(_ucRF4463Freq2+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,801 :: 		ucRF4463Freq1 = 5;
MOVS	R1, #5
MOVW	R0, #lo_addr(_ucRF4463Freq1+0)
MOVT	R0, #hi_addr(_ucRF4463Freq1+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,804 :: 		ucRF4463Power = 17;
MOVS	R1, #17
MOVW	R0, #lo_addr(_ucRF4463Power+0)
MOVT	R0, #hi_addr(_ucRF4463Power+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,806 :: 		ucRF4463Rate  = dr_4p8;            // BAUDRATE
MOVS	R1, #2
MOVW	R0, #lo_addr(_ucRF4463Rate+0)
MOVT	R0, #hi_addr(_ucRF4463Rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,808 :: 		ucRF4463Mode  = tx_test_mode;   //slave_mode;       // para transmision continua usar: tx_test_mode
MOVS	R1, #2
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,810 :: 		ucRF4463FreqChannel = 1;          // Establece canal
MOVS	R1, #1
MOVW	R0, #lo_addr(_ucRF4463FreqChannel+0)
MOVT	R0, #hi_addr(_ucRF4463FreqChannel+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,814 :: 		reset_mode = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_reset_mode+0)
MOVT	R0, #hi_addr(_reset_mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,819 :: 		vRF4463MainSetTXString();    // usada para establecer el encabezdo predeterminado
BL	_vRF4463MainSetTXString+0
;DriverRF4463PROMain.c,820 :: 		vRF4463SDNReset();
BL	_vRF4463SDNReset+0
;DriverRF4463PROMain.c,821 :: 		vRF4463Init();
BL	_vRF4463Init+0
;DriverRF4463PROMain.c,822 :: 		vRF4463ClearInterrupts();
BL	_vRF4463ClearInterrupts+0
;DriverRF4463PROMain.c,823 :: 		vRF4463PartInfo ();          // SOLICITA EL MODELO DEL RADIO
BL	_vRF4463PartInfo+0
;DriverRF4463PROMain.c,824 :: 		ledEnable = 1;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #16
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;DriverRF4463PROMain.c,825 :: 		LED_GREEN    = 0;
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_LX	[R2, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #64
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;DriverRF4463PROMain.c,826 :: 		LED_BLUE     = 0;
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_LX	[R2, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #1
LSLS	R1, R1, #8
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;DriverRF4463PROMain.c,827 :: 		LED_RED      = 0;
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_LX	[R2, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #128
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;DriverRF4463PROMain.c,828 :: 		UART1_Write_Text( "[ SYS STM32G ] RF Radio ready" );
MOV	R6, SP
MOVS	R5, #30
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr9_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr9_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOV	R0, SP
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,833 :: 		UART1_Write_Text( "[ SYS STM32G ] RF Radio ready\r\n" );
MOVS	R6, #32
ADD	R6, SP, R6
MOVS	R5, #32
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr10_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr10_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #32
ADD	R0, SP, R0
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,836 :: 		while ( 1 ) {
L_main371:
;DriverRF4463PROMain.c,839 :: 		if ( fUSART1Buffer == READY_TO_READ ) {
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BLNE	L_main373
;DriverRF4463PROMain.c,840 :: 		vUSARTReceivedFromUSART1();
BL	_vUSARTReceivedFromUSART1+0
;DriverRF4463PROMain.c,841 :: 		}
L_main373:
;DriverRF4463PROMain.c,844 :: 		if ( ucRF4463Mode == master_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BLNE	L_main374
;DriverRF4463PROMain.c,846 :: 		}
IT	AL
BLAL	L_main375
L_main374:
;DriverRF4463PROMain.c,849 :: 		else if ( ucRF4463Mode == slave_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BLNE	L_main376
;DriverRF4463PROMain.c,850 :: 		vRF4463RxInit();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,851 :: 		}
IT	AL
BLAL	L_main377
L_main376:
;DriverRF4463PROMain.c,854 :: 		else if ( ucRF4463Mode == rf_off ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BLNE	L_main378
;DriverRF4463PROMain.c,855 :: 		while ( 1 ) {
L_main379:
;DriverRF4463PROMain.c,857 :: 		if ( fUSART1Buffer == READY_TO_READ ) {
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BLNE	L_main381
;DriverRF4463PROMain.c,858 :: 		break;
IT	AL
BLAL	L_main380
;DriverRF4463PROMain.c,859 :: 		}
L_main381:
;DriverRF4463PROMain.c,861 :: 		if ( ucRF4463SendMessage == 1 ) {
MOVW	R0, #lo_addr(_ucRF4463SendMessage+0)
MOVT	R0, #hi_addr(_ucRF4463SendMessage+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BLNE	L_main382
;DriverRF4463PROMain.c,862 :: 		ucRF4463SendMessage = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucRF4463SendMessage+0)
MOVT	R0, #hi_addr(_ucRF4463SendMessage+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,866 :: 		UART1_Write_Text("[ TX ] DONE\r\n");
MOVS	R6, #64
ADD	R6, SP, R6
MOVS	R5, #14
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr11_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr11_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #64
ADD	R0, SP, R0
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,869 :: 		vRF4463TxData();
BL	_vRF4463TxData+0
;DriverRF4463PROMain.c,870 :: 		}
L_main382:
;DriverRF4463PROMain.c,871 :: 		}
IT	AL
BLAL	L_main379
L_main380:
;DriverRF4463PROMain.c,872 :: 		}
L_main378:
L_main377:
L_main375:
;DriverRF4463PROMain.c,875 :: 		if ( ucRF4463Mode == tx_test_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BLNE	L_main383
;DriverRF4463PROMain.c,876 :: 		vRF4463TxCont();
BL	_vRF4463TxCont+0
;DriverRF4463PROMain.c,877 :: 		while ( 1 ) {
L_main384:
;DriverRF4463PROMain.c,879 :: 		if ( fUSART1Buffer == READY_TO_READ ) {
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BLNE	L_main386
;DriverRF4463PROMain.c,880 :: 		break;
IT	AL
BLAL	L_main385
;DriverRF4463PROMain.c,881 :: 		}
L_main386:
;DriverRF4463PROMain.c,883 :: 		if ( !nIRQ ) {
MOVW	R0, #lo_addr(GPIOA_IDRbits+0)
MOVT	R0, #hi_addr(GPIOA_IDRbits+0)
_LX	[R0, ByteOffset(GPIOA_IDRbits+0)]
MOVS	R0, #4
ANDS	R0, R1
LSRS	R0, R0, #2
CMP	R0, #0
IT	NE
BLNE	L_main387
;DriverRF4463PROMain.c,884 :: 		vRF4463TxCont();
BL	_vRF4463TxCont+0
;DriverRF4463PROMain.c,885 :: 		}
L_main387:
;DriverRF4463PROMain.c,886 :: 		}
IT	AL
BLAL	L_main384
L_main385:
;DriverRF4463PROMain.c,887 :: 		}
L_main383:
;DriverRF4463PROMain.c,889 :: 		if ( ucRF4463Mode == rx_test_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BLNE	L_main388
;DriverRF4463PROMain.c,890 :: 		vRF4463RxInit ();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,891 :: 		while ( 1 ) {
L_main389:
;DriverRF4463PROMain.c,893 :: 		if ( fUSART1Buffer == READY_TO_READ ) {
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BLNE	L_main391
;DriverRF4463PROMain.c,894 :: 		break;
IT	AL
BLAL	L_main390
;DriverRF4463PROMain.c,895 :: 		}
L_main391:
;DriverRF4463PROMain.c,898 :: 		}
IT	AL
BLAL	L_main389
L_main390:
;DriverRF4463PROMain.c,899 :: 		}
L_main388:
;DriverRF4463PROMain.c,901 :: 		if ( reset_mode == 0 ) {
MOVW	R0, #lo_addr(_reset_mode+0)
MOVT	R0, #hi_addr(_reset_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BLNE	L_main392
;DriverRF4463PROMain.c,903 :: 		while ( 1 ) {
L_main393:
;DriverRF4463PROMain.c,905 :: 		if ( fUSART1Buffer == READY_TO_READ ) {
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BLNE	L_main395
;DriverRF4463PROMain.c,906 :: 		break;
IT	AL
BLAL	L_main394
;DriverRF4463PROMain.c,907 :: 		}
L_main395:
;DriverRF4463PROMain.c,910 :: 		if ( Flag.reach_1s ) {
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
_LX	[R0, ByteOffset(_Flag+0)]
MOVS	R0, #1
ANDS	R0, R1
LSRS	R0, R0, #0
CMP	R0, #0
IT	EQ
BLEQ	L_main396
;DriverRF4463PROMain.c,911 :: 		Flag.reach_1s = 0;
MOVW	R2, #lo_addr(_Flag+0)
MOVT	R2, #hi_addr(_Flag+0)
_LX	[R2, ByteOffset(_Flag+0)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(_Flag+0)]
;DriverRF4463PROMain.c,912 :: 		if ( ucRF4463Mode == master_mode ) {
MOVW	R0, #lo_addr(_ucRF4463Mode+0)
MOVT	R0, #hi_addr(_ucRF4463Mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BLNE	L_main397
;DriverRF4463PROMain.c,914 :: 		vRF4463RxInit ();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,915 :: 		}
L_main397:
;DriverRF4463PROMain.c,916 :: 		}
L_main396:
;DriverRF4463PROMain.c,919 :: 		if ( !Flag.is_tx ) {
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
_LX	[R0, ByteOffset(_Flag+0)]
MOVS	R0, #2
ANDS	R0, R1
LSRS	R0, R0, #1
CMP	R0, #0
IT	NE
BLNE	L_main398
;DriverRF4463PROMain.c,920 :: 		if ( !nIRQ ) {          // !nIRQ   // RECIBIO ALGO ?
MOVW	R0, #lo_addr(GPIOA_IDRbits+0)
MOVT	R0, #hi_addr(GPIOA_IDRbits+0)
_LX	[R0, ByteOffset(GPIOA_IDRbits+0)]
MOVS	R0, #4
ANDS	R0, R1
LSRS	R0, R0, #2
CMP	R0, #0
IT	NE
BLNE	L_main399
;DriverRF4463PROMain.c,922 :: 		vRF4463GetIntStatus();
BL	_vRF4463GetIntStatus+0
;DriverRF4463PROMain.c,926 :: 		if ( ( spi_read_buf[ 4 ] & 0x08 ) == 0 ) { // crc error check
MOVW	R0, #lo_addr(_spi_read_buf+4)
MOVT	R0, #hi_addr(_spi_read_buf+4)
LDRB	R1, [R0, #0]
MOVS	R0, #8
ANDS	R0, R1
UXTB	R0, R0
CMP	R0, #0
IT	NE
BLNE	L_main400
;DriverRF4463PROMain.c,930 :: 		spi_read_fifo();
BL	_spi_read_fifo+0
;DriverRF4463PROMain.c,931 :: 		vRF4463FifoReset();
BL	_vRF4463FifoReset+0
;DriverRF4463PROMain.c,947 :: 		UART1_Write_Text( rx_buf );
MOVW	R0, #lo_addr(_rx_buf+0)
MOVT	R0, #hi_addr(_rx_buf+0)
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,948 :: 		UART1_Write_Text("\r\n");
MOVS	R6, #80
ADD	R6, SP, R6
MOVS	R5, #3
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr12_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr12_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #80
ADD	R0, SP, R0
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,951 :: 		LED_GREEN ^= 1;                                        // Data received
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
BEQ	L__main530
MOVS	R1, #64
ORRS	R0, R1
B	L__main529
L__main530:
MOVS	R1, #64
BICS	R0, R1
L__main529:
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;DriverRF4463PROMain.c,952 :: 		rx_cnt++;
MOVW	R1, #lo_addr(_rx_cnt+0)
MOVT	R1, #hi_addr(_rx_cnt+0)
LDR	R0, [R1, #0]
ADDS	R0, #1
STR	R0, [R1, #0]
;DriverRF4463PROMain.c,961 :: 		}
IT	AL
BLAL	L_main401
L_main400:
;DriverRF4463PROMain.c,964 :: 		vUSART1Start_TX("[ CRC ] Fail\r\n", 14 );
MOVS	R6, #84
ADD	R6, SP, R6
MOVS	R5, #15
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr13_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr13_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #84
ADD	R0, SP, R0
MOVS	R1, #14
BL	_vUSART1Start_TX+0
;DriverRF4463PROMain.c,965 :: 		vRF4463SDNReset();
BL	_vRF4463SDNReset+0
;DriverRF4463PROMain.c,966 :: 		vRF4463Init();
BL	_vRF4463Init+0
;DriverRF4463PROMain.c,967 :: 		vRF4463RxInit();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,968 :: 		}
L_main401:
;DriverRF4463PROMain.c,969 :: 		}
L_main399:
;DriverRF4463PROMain.c,970 :: 		}
L_main398:
;DriverRF4463PROMain.c,971 :: 		}
IT	AL
BLAL	L_main393
L_main394:
;DriverRF4463PROMain.c,972 :: 		}
L_main392:
;DriverRF4463PROMain.c,973 :: 		}
IT	AL
BLAL	L_main371
;DriverRF4463PROMain.c,974 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
