_Int_SPI1:
;driverspi.c,49 :: 		void Int_SPI1() iv IVT_INT_SPI1 ics ICS_AUTO {
PUSH	(R14)
;driverspi.c,51 :: 		if ( SPI1_SRbits.RXNE ) {
MOVW	R0, #lo_addr(SPI1_SRbits+0)
MOVT	R0, #hi_addr(SPI1_SRbits+0)
_LX	[R0, ByteOffset(SPI1_SRbits+0)]
MOVS	R0, #1
ANDS	R0, R1
LSRS	R0, R0, #0
CMP	R0, #0
IT	EQ
BLEQ	L_Int_SPI10
;driverspi.c,52 :: 		ucSPI1ByteReceived = ( unsigned char )SPI1_DR;      // lee el Byte recibido
MOVW	R0, #lo_addr(SPI1_DR+0)
MOVT	R0, #hi_addr(SPI1_DR+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ucSPI1ByteReceived+0)
MOVT	R0, #hi_addr(_ucSPI1ByteReceived+0)
STRB	R1, [R0, #0]
;driverspi.c,54 :: 		LED_GREEN = ~LED_GREEN;
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_LX	[R0, ByteOffset(GPIOC_ODRbits+0)]
MOVS	R1, #64
ANDS	R1, R0
LSRS	R1, R1, #6
MOVS	R0, #1
EORS	R0, R1
UXTB	R3, R0
MOVW	R2, #lo_addr(GPIOC_ODRbits+0)
MOVT	R2, #hi_addr(GPIOC_ODRbits+0)
_LX	[R2, ByteOffset(GPIOC_ODRbits+0)]
MOVS	R1, #1
ANDS	R1, R3
BEQ	L__Int_SPI1256
MOVS	R1, #64
ORRS	R0, R1
B	L__Int_SPI1255
L__Int_SPI1256:
MOVS	R1, #64
BICS	R0, R1
L__Int_SPI1255:
_SX	[R2, ByteOffset(GPIOC_ODRbits+0)]
;driverspi.c,55 :: 		}
L_Int_SPI10:
;driverspi.c,56 :: 		}
L_end_Int_SPI1:
POP	(R15)
; end of _Int_SPI1
_DMACh1_interrupt:
;driverspi.c,63 :: 		void DMACh1_interrupt() iv IVT_INT_DMA_Channel1 ics ICS_AUTO {
PUSH	(R14)
;driverspi.c,65 :: 		if ( DMA_ISRbits.TEIF3 ) {
MOVW	R0, #lo_addr(DMA_ISRbits+0)
MOVT	R0, #hi_addr(DMA_ISRbits+0)
_LX	[R0, ByteOffset(DMA_ISRbits+0)]
MOVS	R0, #8
ANDS	R0, R1
LSRS	R0, R0, #3
CMP	R0, #0
IT	EQ
BLEQ	L_DMACh1_interrupt1
;driverspi.c,66 :: 		DMA_IFCRbits.CTEIF3 = 1;
MOVW	R2, #lo_addr(DMA_IFCRbits+0)
MOVT	R2, #hi_addr(DMA_IFCRbits+0)
_LX	[R2, ByteOffset(DMA_IFCRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(DMA_IFCRbits+0)]
;driverspi.c,67 :: 		while ( SPI1_SRbits.BSY );
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
;driverspi.c,68 :: 		while ( !SPI1_SRbits.TXE );
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
;driverspi.c,69 :: 		DMA_CCR1bits.EN = 0;
MOVW	R2, #lo_addr(DMA_CCR1bits+0)
MOVT	R2, #hi_addr(DMA_CCR1bits+0)
_LX	[R2, ByteOffset(DMA_CCR1bits+0)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(DMA_CCR1bits+0)]
;driverspi.c,70 :: 		}
L_DMACh1_interrupt1:
;driverspi.c,72 :: 		if ( DMA_ISRbits.TCIF1 ) {     // TRANSFER COMPLETE INTERRUPT FLAG = envio el frame completo
MOVW	R0, #lo_addr(DMA_ISRbits+0)
MOVT	R0, #hi_addr(DMA_ISRbits+0)
_LX	[R0, ByteOffset(DMA_ISRbits+0)]
MOVS	R0, #2
ANDS	R0, R1
LSRS	R0, R0, #1
CMP	R0, #0
IT	EQ
BLEQ	L_DMACh1_interrupt6
;driverspi.c,73 :: 		DMA_IFCRbits.CGIF0 = 1;        // limpia TODOS LOS FLAGS DE DMA
MOVW	R2, #lo_addr(DMA_IFCRbits+0)
MOVT	R2, #hi_addr(DMA_IFCRbits+0)
_LX	[R2, ByteOffset(DMA_IFCRbits+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(DMA_IFCRbits+0)]
;driverspi.c,74 :: 		while ( SPI1_SRbits.BSY );
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
;driverspi.c,75 :: 		while ( !SPI1_SRbits.TXE );
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
;driverspi.c,76 :: 		DMA_CCR1bits.EN = 0;
MOVW	R2, #lo_addr(DMA_CCR1bits+0)
MOVT	R2, #hi_addr(DMA_CCR1bits+0)
_LX	[R2, ByteOffset(DMA_CCR1bits+0)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(DMA_CCR1bits+0)]
;driverspi.c,77 :: 		}
L_DMACh1_interrupt6:
;driverspi.c,79 :: 		if ( DMA_ISRbits.GIF0 ) {
MOVW	R0, #lo_addr(DMA_ISRbits+0)
MOVT	R0, #hi_addr(DMA_ISRbits+0)
_LX	[R0, ByteOffset(DMA_ISRbits+0)]
MOVS	R0, #1
ANDS	R0, R1
LSRS	R0, R0, #0
CMP	R0, #0
IT	EQ
BLEQ	L_DMACh1_interrupt11
;driverspi.c,80 :: 		DMA_IFCRbits.CGIF0 = 1;
MOVW	R2, #lo_addr(DMA_IFCRbits+0)
MOVT	R2, #hi_addr(DMA_IFCRbits+0)
_LX	[R2, ByteOffset(DMA_IFCRbits+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(DMA_IFCRbits+0)]
;driverspi.c,81 :: 		while ( SPI1_SRbits.BSY );
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
;driverspi.c,82 :: 		while ( !SPI1_SRbits.TXE );
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
;driverspi.c,83 :: 		DMA_CCR1bits.EN = 0;
MOVW	R2, #lo_addr(DMA_CCR1bits+0)
MOVT	R2, #hi_addr(DMA_CCR1bits+0)
_LX	[R2, ByteOffset(DMA_CCR1bits+0)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(DMA_CCR1bits+0)]
;driverspi.c,84 :: 		}
L_DMACh1_interrupt11:
;driverspi.c,85 :: 		}
L_end_DMACh1_interrupt:
POP	(R15)
; end of _DMACh1_interrupt
_vRF4463SpiBufferTX:
;driverspi.c,115 :: 		char vRF4463SpiBufferTX ( unsigned long *ucBuffer, unsigned long ulSize ) {
PUSH	(R14)
;driverspi.c,117 :: 		while ( DMA_CCR1bits.EN || !SPI1_SRbits.TXE );
L_vRF4463SpiBufferTX16:
MOVW	R0, #lo_addr(DMA_CCR1bits+0)
MOVT	R0, #hi_addr(DMA_CCR1bits+0)
_LX	[R0, ByteOffset(DMA_CCR1bits+0)]
MOVS	R0, #1
ANDS	R0, R1
LSRS	R0, R0, #0
CMP	R0, #0
IT	NE
BLNE	L__vRF4463SpiBufferTX250
MOVW	R0, #lo_addr(SPI1_SRbits+0)
MOVT	R0, #hi_addr(SPI1_SRbits+0)
_LX	[R0, ByteOffset(SPI1_SRbits+0)]
MOVS	R0, #2
ANDS	R0, R1
LSRS	R0, R0, #1
CMP	R0, #0
IT	EQ
BLEQ	L__vRF4463SpiBufferTX250
IT	AL
BLAL	L_vRF4463SpiBufferTX17
L__vRF4463SpiBufferTX250:
IT	AL
BLAL	L_vRF4463SpiBufferTX16
L_vRF4463SpiBufferTX17:
;driverspi.c,119 :: 		SPI1_CR1bits.SPE = 1;                         // habilita el periferico
MOVW	R2, #lo_addr(SPI1_CR1bits+0)
MOVT	R2, #hi_addr(SPI1_CR1bits+0)
_LX	[R2, ByteOffset(SPI1_CR1bits+0)]
MOVS	R1, #64
ORRS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR1bits+0)]
;driverspi.c,121 :: 		if ( SPI1_CR1bits.SPE && SPI1_SRbits.TXE && ulSize > 0 ) { // la transmision anterior termino?
MOVW	R0, #lo_addr(SPI1_CR1bits+0)
MOVT	R0, #hi_addr(SPI1_CR1bits+0)
_LX	[R0, ByteOffset(SPI1_CR1bits+0)]
MOVS	R0, #64
ANDS	R0, R1
LSRS	R0, R0, #6
CMP	R0, #0
IT	EQ
BLEQ	L_vRF4463SpiBufferTX22
MOVW	R0, #lo_addr(SPI1_SRbits+0)
MOVT	R0, #hi_addr(SPI1_SRbits+0)
_LX	[R0, ByteOffset(SPI1_SRbits+0)]
MOVS	R0, #2
ANDS	R0, R1
LSRS	R0, R0, #1
CMP	R0, #0
IT	EQ
BLEQ	L_vRF4463SpiBufferTX22
LDR	R0, [SP, #8]
CMP	R0, #0
IT	LS
BLLS	L_vRF4463SpiBufferTX22
L__vRF4463SpiBufferTX249:
;driverspi.c,122 :: 		DMA_CCR1bits.EN = 0;                       // Desabilita la recepcion para poder modificar los par?metros
MOVW	R2, #lo_addr(DMA_CCR1bits+0)
MOVT	R2, #hi_addr(DMA_CCR1bits+0)
_LX	[R2, ByteOffset(DMA_CCR1bits+0)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(DMA_CCR1bits+0)]
;driverspi.c,123 :: 		while ( DMA_CCR1bits.EN );                 // espera a que se haya desabilitado realmente
L_vRF4463SpiBufferTX23:
MOVW	R0, #lo_addr(DMA_CCR1bits+0)
MOVT	R0, #hi_addr(DMA_CCR1bits+0)
_LX	[R0, ByteOffset(DMA_CCR1bits+0)]
MOVS	R0, #1
ANDS	R0, R1
LSRS	R0, R0, #0
CMP	R0, #0
IT	EQ
BLEQ	L_vRF4463SpiBufferTX24
IT	AL
BLAL	L_vRF4463SpiBufferTX23
L_vRF4463SpiBufferTX24:
;driverspi.c,125 :: 		DMA_CMAR1 = ( unsigned long ) ucBuffer;    // Direccion de la memoria a rutear
LDR	R1, [SP, #4]
MOVW	R0, #lo_addr(DMA_CMAR1+0)
MOVT	R0, #hi_addr(DMA_CMAR1+0)
STR	R1, [R0, #0]
;driverspi.c,126 :: 		DMA_CNDTR1 = ulSize;                       // Tamagno de datos a manejar
LDR	R1, [SP, #8]
MOVW	R0, #lo_addr(DMA_CNDTR1+0)
MOVT	R0, #hi_addr(DMA_CNDTR1+0)
STR	R1, [R0, #0]
;driverspi.c,127 :: 		DMA_CCR1bits.EN = 1;
MOVW	R2, #lo_addr(DMA_CCR1bits+0)
MOVT	R2, #hi_addr(DMA_CCR1bits+0)
_LX	[R2, ByteOffset(DMA_CCR1bits+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(DMA_CCR1bits+0)]
;driverspi.c,129 :: 		while ( DMA_CNDTR1 > 1 );                  // esperando el fin de la transmision
L_vRF4463SpiBufferTX25:
MOVW	R0, #lo_addr(DMA_CNDTR1+0)
MOVT	R0, #hi_addr(DMA_CNDTR1+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	LS
BLLS	L_vRF4463SpiBufferTX26
IT	AL
BLAL	L_vRF4463SpiBufferTX25
L_vRF4463SpiBufferTX26:
;driverspi.c,131 :: 		while ( SPI1_SRbits.FTLVL != 0 );          // SPI1_SRbits.FTLVL != 0
L_vRF4463SpiBufferTX27:
MOVW	R0, #lo_addr(SPI1_SRbits+0)
MOVT	R0, #hi_addr(SPI1_SRbits+0)
LDRH	R0, [R0, #0]
UXTH	R1, R0
MOVW	R0, #6144
MOVT	R0, #0
ANDS	R1, R0
UXTH	R1, R1
LSRS	R1, R1, #11
UXTH	R1, R1
CMP	R1, #0
IT	EQ
BLEQ	L_vRF4463SpiBufferTX28
IT	AL
BLAL	L_vRF4463SpiBufferTX27
L_vRF4463SpiBufferTX28:
;driverspi.c,133 :: 		while ( SPI1_SRbits.BSY );
L_vRF4463SpiBufferTX29:
MOVW	R0, #lo_addr(SPI1_SRbits+0)
MOVT	R0, #hi_addr(SPI1_SRbits+0)
_LX	[R0, ByteOffset(SPI1_SRbits+0)]
MOVS	R0, #128
ANDS	R0, R1
LSRS	R0, R0, #7
CMP	R0, #0
IT	EQ
BLEQ	L_vRF4463SpiBufferTX30
IT	AL
BLAL	L_vRF4463SpiBufferTX29
L_vRF4463SpiBufferTX30:
;driverspi.c,134 :: 		while ( !SPI1_SRbits.TXE );
L_vRF4463SpiBufferTX31:
MOVW	R0, #lo_addr(SPI1_SRbits+0)
MOVT	R0, #hi_addr(SPI1_SRbits+0)
_LX	[R0, ByteOffset(SPI1_SRbits+0)]
MOVS	R0, #2
ANDS	R0, R1
LSRS	R0, R0, #1
CMP	R0, #0
IT	NE
BLNE	L_vRF4463SpiBufferTX32
IT	AL
BLAL	L_vRF4463SpiBufferTX31
L_vRF4463SpiBufferTX32:
;driverspi.c,136 :: 		DMA_CCR1bits.EN = 0;                       // DEPURACION
MOVW	R2, #lo_addr(DMA_CCR1bits+0)
MOVT	R2, #hi_addr(DMA_CCR1bits+0)
_LX	[R2, ByteOffset(DMA_CCR1bits+0)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(DMA_CCR1bits+0)]
;driverspi.c,138 :: 		return 1;
MOVS	R0, #1
IT	AL
BLAL	L_end_vRF4463SpiBufferTX
;driverspi.c,139 :: 		}
L_vRF4463SpiBufferTX22:
;driverspi.c,140 :: 		return 0;
MOVS	R0, #0
;driverspi.c,141 :: 		}
L_end_vRF4463SpiBufferTX:
POP	(R15)
; end of _vRF4463SpiBufferTX
_vSPI1Init:
;driverspi.c,143 :: 		void vSPI1Init( void ) {
PUSH	(R14)
;driverspi.c,145 :: 		RCC_IOPENRbits.IOPAEN       = 1;      // GPIOA Enabled
MOVW	R2, #lo_addr(RCC_IOPENRbits+0)
MOVT	R2, #hi_addr(RCC_IOPENRbits+0)
_LX	[R2, ByteOffset(RCC_IOPENRbits+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(RCC_IOPENRbits+0)]
;driverspi.c,146 :: 		GPIOA_MODERbits.MODER5      = 2;      // Altern Function
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
;driverspi.c,147 :: 		GPIOA_OTYPERbits.OT5        = 0;      // push pull
MOVW	R2, #lo_addr(GPIOA_OTYPERbits+0)
MOVT	R2, #hi_addr(GPIOA_OTYPERbits+0)
_LX	[R2, ByteOffset(GPIOA_OTYPERbits+0)]
MOVS	R1, #32
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOA_OTYPERbits+0)]
;driverspi.c,148 :: 		GPIOA_OSPEEDRbits.OSPEEDR5  = 0;      // high Speed
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
;driverspi.c,149 :: 		GPIOA_PUPDRbits.PUPDR5      = 0;      // no PU or PD
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
;driverspi.c,150 :: 		GPIOA_AFRLbits.AFSEL5       = 0;      // AF0
MOVW	R0, #lo_addr(GPIOA_AFRLbits+0)
MOVT	R0, #hi_addr(GPIOA_AFRLbits+0)
LDR	R1, [R0, #0]
MOVW	R0, #65535
MOVT	R0, #65295
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOA_AFRLbits+0)
MOVT	R0, #hi_addr(GPIOA_AFRLbits+0)
STR	R1, [R0, #0]
;driverspi.c,152 :: 		GPIOA_MODERbits.MODER6      = 2;      // Altern Function
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
;driverspi.c,153 :: 		GPIOA_OTYPERbits.OT6        = 0;      // push pull
MOVW	R2, #lo_addr(GPIOA_OTYPERbits+0)
MOVT	R2, #hi_addr(GPIOA_OTYPERbits+0)
_LX	[R2, ByteOffset(GPIOA_OTYPERbits+0)]
MOVS	R1, #64
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOA_OTYPERbits+0)]
;driverspi.c,154 :: 		GPIOA_OSPEEDRbits.OSPEEDR6  = 0;      // high Speed
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
;driverspi.c,155 :: 		GPIOA_PUPDRbits.PUPDR6      = 0;      // no PU or PD
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
;driverspi.c,156 :: 		GPIOA_AFRLbits.AFSEL6       = 0;      // AF0
MOVW	R0, #lo_addr(GPIOA_AFRLbits+0)
MOVT	R0, #hi_addr(GPIOA_AFRLbits+0)
LDR	R1, [R0, #0]
MOVW	R0, #65535
MOVT	R0, #61695
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOA_AFRLbits+0)
MOVT	R0, #hi_addr(GPIOA_AFRLbits+0)
STR	R1, [R0, #0]
;driverspi.c,158 :: 		GPIOA_MODERbits.MODER7      = 2;      // Altern Function
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
;driverspi.c,159 :: 		GPIOA_OTYPERbits.OT7        = 0;      // push pull
MOVW	R2, #lo_addr(GPIOA_OTYPERbits+0)
MOVT	R2, #hi_addr(GPIOA_OTYPERbits+0)
_LX	[R2, ByteOffset(GPIOA_OTYPERbits+0)]
MOVS	R1, #128
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOA_OTYPERbits+0)]
;driverspi.c,160 :: 		GPIOA_OSPEEDRbits.OSPEEDR7  = 0;      // high Speed
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
;driverspi.c,161 :: 		GPIOA_PUPDRbits.PUPDR7      = 0;      // no PU or PD
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
;driverspi.c,162 :: 		GPIOA_AFRLbits.AFSEL7       = 0;      // AF0
MOVW	R0, #lo_addr(GPIOA_AFRLbits+0)
MOVT	R0, #hi_addr(GPIOA_AFRLbits+0)
LDR	R1, [R0, #0]
MOVW	R0, #65535
MOVT	R0, #4095
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOA_AFRLbits+0)
MOVT	R0, #hi_addr(GPIOA_AFRLbits+0)
STR	R1, [R0, #0]
;driverspi.c,165 :: 		RCC_APBENR2bits.SPI1EN      = 1;
MOVW	R2, #lo_addr(RCC_APBENR2bits+0)
MOVT	R2, #hi_addr(RCC_APBENR2bits+0)
_LX	[R2, ByteOffset(RCC_APBENR2bits+0)]
MOVS	R1, #1
LSLS	R1, R1, #12
ORRS	R0, R1
_SX	[R2, ByteOffset(RCC_APBENR2bits+0)]
;driverspi.c,167 :: 		SPI1_CR1bits.CPHA           = 0;      // 1 if TI enabled
MOVW	R2, #lo_addr(SPI1_CR1bits+0)
MOVT	R2, #hi_addr(SPI1_CR1bits+0)
_LX	[R2, ByteOffset(SPI1_CR1bits+0)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR1bits+0)]
;driverspi.c,168 :: 		SPI1_CR1bits.CPOL           = 0;
MOVW	R2, #lo_addr(SPI1_CR1bits+0)
MOVT	R2, #hi_addr(SPI1_CR1bits+0)
_LX	[R2, ByteOffset(SPI1_CR1bits+0)]
MOVS	R1, #2
BICS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR1bits+0)]
;driverspi.c,169 :: 		SPI1_CR1bits.LSBFIRST       = 0;
MOVW	R2, #lo_addr(SPI1_CR1bits+0)
MOVT	R2, #hi_addr(SPI1_CR1bits+0)
_LX	[R2, ByteOffset(SPI1_CR1bits+0)]
MOVS	R1, #128
BICS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR1bits+0)]
;driverspi.c,170 :: 		SPI1_CR1bits.SSM            = 1;
MOVW	R2, #lo_addr(SPI1_CR1bits+0)
MOVT	R2, #hi_addr(SPI1_CR1bits+0)
_LX	[R2, ByteOffset(SPI1_CR1bits+0)]
MOVS	R1, #1
LSLS	R1, R1, #9
ORRS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR1bits+0)]
;driverspi.c,171 :: 		SPI1_CR1bits.SSI            = 1;
MOVW	R2, #lo_addr(SPI1_CR1bits+0)
MOVT	R2, #hi_addr(SPI1_CR1bits+0)
_LX	[R2, ByteOffset(SPI1_CR1bits+0)]
MOVS	R1, #1
LSLS	R1, R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR1bits+0)]
;driverspi.c,172 :: 		SPI1_CR1bits.MSTR           = 1;
MOVW	R2, #lo_addr(SPI1_CR1bits+0)
MOVT	R2, #hi_addr(SPI1_CR1bits+0)
_LX	[R2, ByteOffset(SPI1_CR1bits+0)]
MOVS	R1, #4
ORRS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR1bits+0)]
;driverspi.c,173 :: 		SPI1_CR1bits.CRCNEXT        = 0;
MOVW	R2, #lo_addr(SPI1_CR1bits+0)
MOVT	R2, #hi_addr(SPI1_CR1bits+0)
_LX	[R2, ByteOffset(SPI1_CR1bits+0)]
MOVS	R1, #1
LSLS	R1, R1, #12
BICS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR1bits+0)]
;driverspi.c,175 :: 		SPI1_CR2bits.FRF            = 0;
MOVW	R2, #lo_addr(SPI1_CR2bits+0)
MOVT	R2, #hi_addr(SPI1_CR2bits+0)
_LX	[R2, ByteOffset(SPI1_CR2bits+0)]
MOVS	R1, #16
BICS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR2bits+0)]
;driverspi.c,176 :: 		SPI1_CR2bits.DS             = 7;      // 8 bits empaquetado
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
;driverspi.c,177 :: 		SPI1_CR2bits.SSOE           = 0;
MOVW	R2, #lo_addr(SPI1_CR2bits+0)
MOVT	R2, #hi_addr(SPI1_CR2bits+0)
_LX	[R2, ByteOffset(SPI1_CR2bits+0)]
MOVS	R1, #4
BICS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR2bits+0)]
;driverspi.c,178 :: 		SPI1_CR2bits.NSSP           = 1;
MOVW	R2, #lo_addr(SPI1_CR2bits+0)
MOVT	R2, #hi_addr(SPI1_CR2bits+0)
_LX	[R2, ByteOffset(SPI1_CR2bits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR2bits+0)]
;driverspi.c,179 :: 		SPI1_CR2bits.FRXTH          = 1;
MOVW	R2, #lo_addr(SPI1_CR2bits+0)
MOVT	R2, #hi_addr(SPI1_CR2bits+0)
_LX	[R2, ByteOffset(SPI1_CR2bits+0)]
MOVS	R1, #1
LSLS	R1, R1, #12
ORRS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR2bits+0)]
;driverspi.c,180 :: 		SPI1_CR2bits.TXDMAEN        = 1;
MOVW	R2, #lo_addr(SPI1_CR2bits+0)
MOVT	R2, #hi_addr(SPI1_CR2bits+0)
_LX	[R2, ByteOffset(SPI1_CR2bits+0)]
MOVS	R1, #2
ORRS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR2bits+0)]
;driverspi.c,184 :: 		RCC_AHBENRbits.DMAEN        = 1;
MOVW	R2, #lo_addr(RCC_AHBENRbits+0)
MOVT	R2, #hi_addr(RCC_AHBENRbits+0)
_LX	[R2, ByteOffset(RCC_AHBENRbits+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(RCC_AHBENRbits+0)]
;driverspi.c,186 :: 		DMA_CCR1bits.EN = 0;
MOVW	R2, #lo_addr(DMA_CCR1bits+0)
MOVT	R2, #hi_addr(DMA_CCR1bits+0)
_LX	[R2, ByteOffset(DMA_CCR1bits+0)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(DMA_CCR1bits+0)]
;driverspi.c,187 :: 		while ( DMA_CCR1bits.EN );
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
;driverspi.c,189 :: 		PL0_bit = 1;
MOVW	R2, #lo_addr(PL0_bit+0)
MOVT	R2, #hi_addr(PL0_bit+0)
_LX	[R2, ByteOffset(PL0_bit+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(PL0_bit+0)
ORRS	R0, R1
_SX	[R2, ByteOffset(PL0_bit+0)]
;driverspi.c,190 :: 		PL1_bit = 1;
MOVW	R2, #lo_addr(PL1_bit+0)
MOVT	R2, #hi_addr(PL1_bit+0)
_LX	[R2, ByteOffset(PL1_bit+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(PL1_bit+0)
ORRS	R0, R1
_SX	[R2, ByteOffset(PL1_bit+0)]
;driverspi.c,191 :: 		DMA_CCR1bits.MINC           = 1;      // Mem increment
MOVW	R2, #lo_addr(DMA_CCR1bits+0)
MOVT	R2, #hi_addr(DMA_CCR1bits+0)
_LX	[R2, ByteOffset(DMA_CCR1bits+0)]
MOVS	R1, #128
ORRS	R0, R1
_SX	[R2, ByteOffset(DMA_CCR1bits+0)]
;driverspi.c,192 :: 		DMA_CCR1bits.DIR_           = 1;      // Read from Memory
MOVW	R2, #lo_addr(DMA_CCR1bits+0)
MOVT	R2, #hi_addr(DMA_CCR1bits+0)
_LX	[R2, ByteOffset(DMA_CCR1bits+0)]
MOVS	R1, #16
ORRS	R0, R1
_SX	[R2, ByteOffset(DMA_CCR1bits+0)]
;driverspi.c,193 :: 		DMA_CCR1bits.TEIE           = 1;      // Transfer Error Int
MOVW	R2, #lo_addr(DMA_CCR1bits+0)
MOVT	R2, #hi_addr(DMA_CCR1bits+0)
_LX	[R2, ByteOffset(DMA_CCR1bits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(DMA_CCR1bits+0)]
;driverspi.c,194 :: 		DMA_CCR1bits.TCIE           = 1;      // Transfer Complete Int
MOVW	R2, #lo_addr(DMA_CCR1bits+0)
MOVT	R2, #hi_addr(DMA_CCR1bits+0)
_LX	[R2, ByteOffset(DMA_CCR1bits+0)]
MOVS	R1, #2
ORRS	R0, R1
_SX	[R2, ByteOffset(DMA_CCR1bits+0)]
;driverspi.c,196 :: 		DMA_CPAR1 = ( unsigned long ) &SPI1_DR;    // periferico ruteado
MOVW	R1, #lo_addr(SPI1_DR+0)
MOVT	R1, #hi_addr(SPI1_DR+0)
MOVW	R0, #lo_addr(DMA_CPAR1+0)
MOVT	R0, #hi_addr(DMA_CPAR1+0)
STR	R1, [R0, #0]
;driverspi.c,198 :: 		NVIC_IntEnable( IVT_INT_DMA_Channel1 );    // habilitacion de interrupcion
MOVS	R0, #25
BL	_NVIC_IntEnable+0
;driverspi.c,200 :: 		DMAMUX_C0CRbits.DMAREQ_ID = 17;            // TX_SPI1
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
;driverspi.c,202 :: 		SPI1_CR2bits.RXNEIE = 1;                   // habilita interrupcion de recepcion SPI
MOVW	R2, #lo_addr(SPI1_CR2bits+0)
MOVT	R2, #hi_addr(SPI1_CR2bits+0)
_LX	[R2, ByteOffset(SPI1_CR2bits+0)]
MOVS	R1, #64
ORRS	R0, R1
_SX	[R2, ByteOffset(SPI1_CR2bits+0)]
;driverspi.c,204 :: 		NVIC_IntEnable( IVT_INT_SPI1 );
MOVS	R0, #41
BL	_NVIC_IntEnable+0
;driverspi.c,205 :: 		}
L_end_vSPI1Init:
POP	(R15)
; end of _vSPI1Init
_vRF4463ISR:
;driverrf4463pro.c,39 :: 		void vRF4463ISR() iv IVT_INT_EXTI2_3 ics ICS_AUTO{
PUSH	(R14)
;driverrf4463pro.c,40 :: 		if ( EXTI_FPR1bits.FPIF2 ){
MOVW	R0, #lo_addr(EXTI_FPR1bits+0)
MOVT	R0, #hi_addr(EXTI_FPR1bits+0)
_LX	[R0, ByteOffset(EXTI_FPR1bits+0)]
MOVS	R0, #4
ANDS	R0, R1
LSRS	R0, R0, #2
CMP	R0, #0
IT	EQ
BLEQ	L_vRF4463ISR35
;driverrf4463pro.c,41 :: 		EXTI_FPR1bits.FPIF2 = 1;
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
SUB	SP, SP, #24
;driverrf4463pro.c,56 :: 		for ( i = 4; i < 16; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init36:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #16
IT	CS
BLCS	L_vRF4463Init37
;driverrf4463pro.c,57 :: 		RF_MODEM_MOD_TYPE_12_data[ i ] = RF_MODEM_MOD_TYPE_12[ rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_MOD_TYPE_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_MOD_TYPE_12_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #12
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_MOD_TYPE_12+0)
MOVT	R0, #hi_addr(_RF_MODEM_MOD_TYPE_12+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,56 :: 		for ( i = 4; i < 16; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,58 :: 		}
IT	AL
BLAL	L_vRF4463Init36
L_vRF4463Init37:
;driverrf4463pro.c,61 :: 		if ( freq3 < 8 ) {
MOVW	R0, #lo_addr(_freq3+0)
MOVT	R0, #hi_addr(_freq3+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CS
BLCS	L_vRF4463Init39
;driverrf4463pro.c,62 :: 		for ( i = 4; i < 12; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init40:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #12
IT	CS
BLCS	L_vRF4463Init41
;driverrf4463pro.c,63 :: 		RF_MODEM_TX_RAMP_DELAY_8_data[ i ] = RF_MODEM_TX_RAMP_DELAY_8_433[ rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #8
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_433+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,62 :: 		for ( i = 4; i < 12; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,64 :: 		}
IT	AL
BLAL	L_vRF4463Init40
L_vRF4463Init41:
;driverrf4463pro.c,65 :: 		for ( i = 4; i < 11; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init43:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #11
IT	CS
BLCS	L_vRF4463Init44
;driverrf4463pro.c,66 :: 		RF_MODEM_AFC_GEAR_7_data[ i ] = RF_MODEM_AFC_GEAR_7_433[ rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_AFC_GEAR_7_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AFC_GEAR_7_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #7
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_AFC_GEAR_7_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_AFC_GEAR_7_433+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,65 :: 		for ( i = 4; i < 11; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,67 :: 		}
IT	AL
BLAL	L_vRF4463Init43
L_vRF4463Init44:
;driverrf4463pro.c,68 :: 		for ( i = 4; i < 15; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init46:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #15
IT	CS
BLCS	L_vRF4463Init47
;driverrf4463pro.c,69 :: 		RF_MODEM_OOK_CNT1_11_data[ i ] = RF_MODEM_OOK_CNT1_11_433[ rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_OOK_CNT1_11_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_OOK_CNT1_11_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #11
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_OOK_CNT1_11_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_OOK_CNT1_11_433+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,68 :: 		for ( i = 4; i < 15; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,70 :: 		}
IT	AL
BLAL	L_vRF4463Init46
L_vRF4463Init47:
;driverrf4463pro.c,71 :: 		for ( i = 4; i < 16; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init49:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #16
IT	CS
BLCS	L_vRF4463Init50
;driverrf4463pro.c,72 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433[ rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #12
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_433+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,71 :: 		for ( i = 4; i < 16; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,73 :: 		}
IT	AL
BLAL	L_vRF4463Init49
L_vRF4463Init50:
;driverrf4463pro.c,74 :: 		for ( i = 4; i < 16; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init52:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #16
IT	CS
BLCS	L_vRF4463Init53
;driverrf4463pro.c,75 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433[ rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #12
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_433+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,74 :: 		for ( i = 4; i < 16; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,76 :: 		}
IT	AL
BLAL	L_vRF4463Init52
L_vRF4463Init53:
;driverrf4463pro.c,77 :: 		for ( i = 4; i < 16; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init55:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #16
IT	CS
BLCS	L_vRF4463Init56
;driverrf4463pro.c,78 :: 		RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433[ rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #12
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_433+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,77 :: 		for ( i = 4; i < 16; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,79 :: 		}
IT	AL
BLAL	L_vRF4463Init55
L_vRF4463Init56:
;driverrf4463pro.c,80 :: 		for ( i = 4; i < 13; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init58:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #13
IT	CS
BLCS	L_vRF4463Init59
;driverrf4463pro.c,81 :: 		RF_MODEM_AGC_WINDOW_SIZE_9_data[ i ] = RF_MODEM_AGC_WINDOW_SIZE_9_433[ rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #9
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_433+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,80 :: 		for ( i = 4; i < 13; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,82 :: 		}
IT	AL
BLAL	L_vRF4463Init58
L_vRF4463Init59:
;driverrf4463pro.c,83 :: 		for ( i = 4; i < 13; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init61:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #13
IT	CS
BLCS	L_vRF4463Init62
;driverrf4463pro.c,84 :: 		RF_MODEM_BCR_OSR_1_9_data[ i ] = RF_MODEM_BCR_OSR_1_9_433[ rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #9
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_BCR_OSR_1_9_433+0)
MOVT	R0, #hi_addr(_RF_MODEM_BCR_OSR_1_9_433+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,83 :: 		for ( i = 4; i < 13; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,85 :: 		}
IT	AL
BLAL	L_vRF4463Init61
L_vRF4463Init62:
;driverrf4463pro.c,86 :: 		}
IT	AL
BLAL	L_vRF4463Init64
L_vRF4463Init39:
;driverrf4463pro.c,88 :: 		for ( i = 4; i < 12; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init65:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #12
IT	CS
BLCS	L_vRF4463Init66
;driverrf4463pro.c,89 :: 		RF_MODEM_TX_RAMP_DELAY_8_data[ i ] = RF_MODEM_TX_RAMP_DELAY_8_850[ rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #8
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_850+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,88 :: 		for ( i = 4; i < 12; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,90 :: 		}
IT	AL
BLAL	L_vRF4463Init65
L_vRF4463Init66:
;driverrf4463pro.c,91 :: 		for ( i = 4; i < 11; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init68:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #11
IT	CS
BLCS	L_vRF4463Init69
;driverrf4463pro.c,92 :: 		RF_MODEM_AFC_GEAR_7_data[ i ] = RF_MODEM_AFC_GEAR_7_850[ rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_AFC_GEAR_7_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AFC_GEAR_7_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #7
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_AFC_GEAR_7_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_AFC_GEAR_7_850+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,91 :: 		for ( i = 4; i < 11; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,93 :: 		}
IT	AL
BLAL	L_vRF4463Init68
L_vRF4463Init69:
;driverrf4463pro.c,94 :: 		for ( i = 4; i < 15; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init71:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #15
IT	CS
BLCS	L_vRF4463Init72
;driverrf4463pro.c,95 :: 		RF_MODEM_OOK_CNT1_11_data[ i ] = RF_MODEM_OOK_CNT1_11_850[ rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_OOK_CNT1_11_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_OOK_CNT1_11_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #11
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_OOK_CNT1_11_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_OOK_CNT1_11_850+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,94 :: 		for ( i = 4; i < 15; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,96 :: 		}
IT	AL
BLAL	L_vRF4463Init71
L_vRF4463Init72:
;driverrf4463pro.c,97 :: 		for ( i = 4; i < 16; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init74:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #16
IT	CS
BLCS	L_vRF4463Init75
;driverrf4463pro.c,98 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850[ rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #12
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_850+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,97 :: 		for ( i = 4; i < 16; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,99 :: 		}
IT	AL
BLAL	L_vRF4463Init74
L_vRF4463Init75:
;driverrf4463pro.c,100 :: 		for ( i = 4; i < 16; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init77:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #16
IT	CS
BLCS	L_vRF4463Init78
;driverrf4463pro.c,101 :: 		RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850[ rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #12
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_850+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,100 :: 		for ( i = 4; i < 16; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,102 :: 		}
IT	AL
BLAL	L_vRF4463Init77
L_vRF4463Init78:
;driverrf4463pro.c,103 :: 		for ( i = 4; i < 16; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init80:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #16
IT	CS
BLCS	L_vRF4463Init81
;driverrf4463pro.c,104 :: 		RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data[ i ] = RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850[ rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #12
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_850+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,103 :: 		for ( i = 4; i < 16; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,105 :: 		}
IT	AL
BLAL	L_vRF4463Init80
L_vRF4463Init81:
;driverrf4463pro.c,106 :: 		for ( i = 4; i < 13; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init83:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #13
IT	CS
BLCS	L_vRF4463Init84
;driverrf4463pro.c,107 :: 		RF_MODEM_AGC_WINDOW_SIZE_9_data[ i ] = RF_MODEM_AGC_WINDOW_SIZE_9_850[ rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #9
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_850+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,106 :: 		for ( i = 4; i < 13; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,108 :: 		}
IT	AL
BLAL	L_vRF4463Init83
L_vRF4463Init84:
;driverrf4463pro.c,109 :: 		for ( i = 4; i < 13; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init86:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #13
IT	CS
BLCS	L_vRF4463Init87
;driverrf4463pro.c,110 :: 		RF_MODEM_BCR_OSR_1_9_data[ i ] = RF_MODEM_BCR_OSR_1_9_850[ rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #9
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_MODEM_BCR_OSR_1_9_850+0)
MOVT	R0, #hi_addr(_RF_MODEM_BCR_OSR_1_9_850+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,109 :: 		for ( i = 4; i < 13; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,111 :: 		}
IT	AL
BLAL	L_vRF4463Init86
L_vRF4463Init87:
;driverrf4463pro.c,112 :: 		}
L_vRF4463Init64:
;driverrf4463pro.c,113 :: 		for ( i = 4; i < 11; i++ ) {
MOVS	R0, #4
STR	R0, [SP, #20]
L_vRF4463Init89:
LDR	R0, [SP, #20]
UXTB	R0, R0
CMP	R0, #11
IT	CS
BLCS	L_vRF4463Init90
;driverrf4463pro.c,114 :: 		RF_SYNTH_PFDCP_CPFF_7_data[ i ] = RF_SYNTH_PFDCP_CPFF_7[ rate ][ i - 4 ];
LDR	R1, [SP, #20]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
MOVT	R0, #hi_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
ADDS	R3, R0, R1
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R2, [R0, #0]
MOVS	R0, #7
MOV	R1, R2
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_RF_SYNTH_PFDCP_CPFF_7+0)
MOVT	R0, #hi_addr(_RF_SYNTH_PFDCP_CPFF_7+0)
ADDS	R2, R0, R1
LDR	R0, [SP, #20]
UXTB	R0, R0
SUBS	R1, R0, #4
SXTH	R1, R1
MOV	R0, R2
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;driverrf4463pro.c,113 :: 		for ( i = 4; i < 11; i++ ) {
LDR	R0, [SP, #20]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #20]
;driverrf4463pro.c,115 :: 		}
IT	AL
BLAL	L_vRF4463Init89
L_vRF4463Init90:
;driverrf4463pro.c,119 :: 		vRF4463GPIO_SET( mode );                              // PARAMETRO CONFIGURABLE
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
PUSH	(R0)
BL	_vRF4463GPIO_SET+0
ADD	SP, SP, #4
;driverrf4463pro.c,122 :: 		app_command_buf[ 0 ] = 0x11;
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,123 :: 		app_command_buf[ 1 ] = 0x00;    // 0x0000
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,124 :: 		app_command_buf[ 2 ] = 0x01;    // Total 1 Parameters
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,125 :: 		app_command_buf[ 3 ] = 0x00;    // 0x0000
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,126 :: 		app_command_buf[ 4 ] = 98;      // freq  adjustment    ( rango desde 0 - 127 Low cap - High Cap )
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #98
STRB	R0, [R1, #0]
;driverrf4463pro.c,127 :: 		spi_write( 5, app_command_buf );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,130 :: 		app_command_buf[ 0 ] = 0x11;
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,131 :: 		app_command_buf[ 1 ] = 0x00;    // 0x0003
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,132 :: 		app_command_buf[ 2 ] = 0x01;    // Total 1 Parameters
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,133 :: 		app_command_buf[ 3 ] = 0x03;   // 0x0003
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,134 :: 		app_command_buf[ 4 ] = 0x40;  // tx = rx = 64 byte, ordinary PH,high performance mode  ?????????????????????
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #64
STRB	R0, [R1, #0]
;driverrf4463pro.c,135 :: 		spi_write( 5, app_command_buf );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,139 :: 		spi_write( 0x08, RF_FRR_CTL_A_MODE_4_data );    // disable all fast response register
MOVW	R0, #lo_addr(_RF_FRR_CTL_A_MODE_4_data+0)
MOVT	R0, #hi_addr(_RF_FRR_CTL_A_MODE_4_data+0)
PUSH	(R0)
MOVS	R0, #8
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,142 :: 		app_command_buf[ 0 ] = 0x11;
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,143 :: 		app_command_buf[ 1 ] = 0x10;    // 0x1000
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #16
STRB	R0, [R1, #0]
;driverrf4463pro.c,144 :: 		app_command_buf[ 2 ] = 0x09;    // Total 9 Parameters
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #9
STRB	R0, [R1, #0]
;driverrf4463pro.c,145 :: 		app_command_buf[ 3 ] = 0x00;   // 0x1000
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,147 :: 		if ( mode == tx_test_mode ) {
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BLNE	L_vRF4463Init92
;driverrf4463pro.c,148 :: 		app_command_buf[ 4 ] = 0xff;     //  Need to send 255 bytes of Preamble
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #255
STRB	R0, [R1, #0]
;driverrf4463pro.c,149 :: 		}
IT	AL
BLAL	L_vRF4463Init93
L_vRF4463Init92:
;driverrf4463pro.c,151 :: 		app_command_buf[ 4 ] = 0x08;   //  Need to send 8 bytes of Preamble
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,152 :: 		}
L_vRF4463Init93:
;driverrf4463pro.c,155 :: 		app_command_buf[ 5 ]   = 0x14;       //To detect 20 bit sync word,
MOV	R0, SP
ADDS	R1, R0, #5
MOVS	R0, #20
STRB	R0, [R1, #0]
;driverrf4463pro.c,156 :: 		app_command_buf[ 6 ]   = 0x00;       // Non-standard preamble settings, useless
MOV	R0, SP
ADDS	R1, R0, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,157 :: 		app_command_buf[ 7 ]   = 0x0f;       // Time of the preamble Timeout   ????????????????????????????????????????????????????????????
MOV	R0, SP
ADDS	R1, R0, #7
MOVS	R0, #15
STRB	R0, [R1, #0]
;driverrf4463pro.c,158 :: 		app_command_buf[ 8 ]   = 0x31;       // The length of the preamble is   byte Calculation , 1st = 1 NO manchest  Encoding, using standard 1010.??
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #8
MOVS	R0, #49
STRB	R0, [R1, #0]
;driverrf4463pro.c,159 :: 		app_command_buf[ 9 ]   = 0x0;        //  Non-standard Preamble Patten 4th byte
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,160 :: 		app_command_buf[ 10 ]  = 0x00;       //  Non-standard Preamble Patten 3rd byte
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,161 :: 		app_command_buf[ 11 ]  = 0x00;       //  Non-standard Preamble Patten 2nd byte
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,162 :: 		app_command_buf[ 12 ]  = 0x00;       //  Non-standard Preamble Patten 1st byte
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #12
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,163 :: 		spi_write(13, app_command_buf);
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #13
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,166 :: 		app_command_buf[ 0 ] = 0x11;
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,167 :: 		app_command_buf[ 1 ] = 0x11;         // command = 0x1100
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,168 :: 		app_command_buf[ 2 ] = 0x05;         // Total 5 Parameters
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #5
STRB	R0, [R1, #0]
;driverrf4463pro.c,169 :: 		app_command_buf[ 3 ] = 0x00;         // command = 0x1100
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,170 :: 		app_command_buf[ 4 ] = 0x01;         // The synchronization word is defined and sent in the length field, and the synchronization word cannot be wrong,Not 4FSK, not manchest encoding, only 2 bytes
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,172 :: 		if ( mode == tx_test_mode ) {
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BLNE	L_vRF4463Init94
;driverrf4463pro.c,173 :: 		app_command_buf[ 5 ] = 0x55;      //Sync word 3
MOV	R0, SP
ADDS	R1, R0, #5
MOVS	R0, #85
STRB	R0, [R1, #0]
;driverrf4463pro.c,174 :: 		app_command_buf[ 6 ] = 0x55;      // Sync word 2
MOV	R0, SP
ADDS	R1, R0, #6
MOVS	R0, #85
STRB	R0, [R1, #0]
;driverrf4463pro.c,175 :: 		}
IT	AL
BLAL	L_vRF4463Init95
L_vRF4463Init94:
;driverrf4463pro.c,177 :: 		app_command_buf[ 5 ] = 0x2d;    //Sync word 3
MOV	R0, SP
ADDS	R1, R0, #5
MOVS	R0, #45
STRB	R0, [R1, #0]
;driverrf4463pro.c,178 :: 		app_command_buf[ 6 ] = 0xd4;    // Sync word 2
MOV	R0, SP
ADDS	R1, R0, #6
MOVS	R0, #212
STRB	R0, [R1, #0]
;driverrf4463pro.c,179 :: 		}
L_vRF4463Init95:
;driverrf4463pro.c,181 :: 		app_command_buf[ 7 ] =  0x00;        // Sync word 1
MOV	R0, SP
ADDS	R1, R0, #7
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,182 :: 		app_command_buf[ 8 ] = 0x00;        // Sync word 0
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,183 :: 		spi_write( 9, app_command_buf );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #9
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,186 :: 		app_command_buf[ 0 ] = 0x11;
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,187 :: 		app_command_buf[ 1 ] = 0x12;        // command = 0x1200
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,188 :: 		app_command_buf[ 2 ] = 0x01;        // Total 1 Parameters
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,189 :: 		app_command_buf[ 3 ] = 0x00;        // command = 0x1200
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,190 :: 		app_command_buf[ 4 ] = 0x81;        // 1?cRC ??,CRC = itu-c, enable crc
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #129
STRB	R0, [R1, #0]
;driverrf4463pro.c,191 :: 		spi_write( 5, app_command_buf );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,194 :: 		app_command_buf[ 0 ] = 0x11;
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,195 :: 		app_command_buf[ 1 ] = 0x12;        // command = 0x1206
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,196 :: 		app_command_buf[ 2 ] = 0x01;        // Total 1Parameters
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,197 :: 		app_command_buf[ 3 ] = 0x06;        // command = 0x1206
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #6
STRB	R0, [R1, #0]
;driverrf4463pro.c,198 :: 		app_command_buf[ 4 ] = 0x02;        //  tx = rx = 120d--1220 (tx packet,ph enable, not 4fsk, After receiving a packet of data,RX off,CRC Do not flip ,CRC MSB, data MSB
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,199 :: 		spi_write( 5, app_command_buf );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,202 :: 		app_command_buf[ 0 ] = 0x11;
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,203 :: 		app_command_buf[ 1 ] = 0x12;        // command = 0x1208
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,204 :: 		app_command_buf[ 2 ] = 0x03;        // Total 3 Parameters
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,205 :: 		app_command_buf[ 3 ] = 0x08;        // command = 0x1208
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,206 :: 		app_command_buf[ 4 ] = 0x00;        // Length Field = LSB,  length Only 1 byte,length Not put In FiFo, fixed packet length mode
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,207 :: 		app_command_buf[ 5 ] = 0x00;        // Used for variable packet length mode, which defines which Field contains length Filed
MOV	R0, SP
ADDS	R1, R0, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,208 :: 		app_command_buf[ 6 ] = 0x00;        // Used for variable packet length mode, adjust the length of variable packet length
MOV	R0, SP
ADDS	R1, R0, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,209 :: 		spi_write( 7, app_command_buf );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #7
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,212 :: 		app_command_buf[ 0 ]  = 0x11;
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,213 :: 		app_command_buf[ 1 ]  = 0x12;       // 0x120d
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,214 :: 		app_command_buf[ 2 ]  = 0x0c;       // Total 12 Parameters
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #12
STRB	R0, [R1, #0]
;driverrf4463pro.c,215 :: 		app_command_buf[ 3 ]  = 0x0d;       // 0x120d
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #13
STRB	R0, [R1, #0]
;driverrf4463pro.c,216 :: 		app_command_buf[ 4 ]  = 0x00;       //  Field 1 length (?4?)
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,217 :: 		app_command_buf[ 5 ]  = payload_length;   //  field 1 length, (? 8?), ?Total14???
MOV	R0, SP
ADDS	R1, R0, #5
MOVS	R0, #14
STRB	R0, [R1, #0]
;driverrf4463pro.c,218 :: 		app_command_buf[ 6 ]  = 0x04;       // field 1 Is not 4FSK,manchest, whiting, PN9,
MOV	R0, SP
ADDS	R1, R0, #6
MOVS	R0, #4
STRB	R0, [R1, #0]
;driverrf4463pro.c,219 :: 		app_command_buf[ 7 ]  = 0xaa;       // field 1 crc enble, check enbale, There are also launchingCRC,cRC?Seed ?CRC_seed?????
MOV	R0, SP
ADDS	R1, R0, #7
MOVS	R0, #170
STRB	R0, [R1, #0]
;driverrf4463pro.c,220 :: 		app_command_buf[ 8 ]  = 0x00;       //  field 2 length(?4?)
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,221 :: 		app_command_buf[ 9 ]  = 0x00;           //  field 2 length, (? 8?), length = 0 Means thisfield did not use
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,222 :: 		app_command_buf[ 10 ] = 0x00;       // field 2 Is not 4FSK,manchest, whiting, PN9
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,223 :: 		app_command_buf[ 11 ] = 0x00;       //  field 2 ?CRCSet up
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,224 :: 		app_command_buf[ 12 ] = 0x00;       //  field 3 length, (? 8?), length = 0 Means thisfield did not use
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #12
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,225 :: 		app_command_buf[ 13 ] = 0x00;           //  field 3 length, (? 8?), length = 0 Means thisfield did not use
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #13
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,226 :: 		app_command_buf[ 14 ] = 0x00;       //  field 3 Is not 4FSK,manchest, whiting, PN9
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #14
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,227 :: 		app_command_buf[ 15 ] = 0x00;       //  field 3 ?CRCSet up
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #15
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,228 :: 		spi_write( 16, app_command_buf );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #16
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,231 :: 		app_command_buf[ 0 ]  = 0x11;
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,232 :: 		app_command_buf[ 1 ]  = 0x12;       // 0x1219
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #18
STRB	R0, [R1, #0]
;driverrf4463pro.c,233 :: 		app_command_buf[ 2 ]  = 0x08;       // Total 8Parameters
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,234 :: 		app_command_buf[ 3 ]  = 0x19;       // 0x1219
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #25
STRB	R0, [R1, #0]
;driverrf4463pro.c,235 :: 		app_command_buf[ 4 ]  = 0x00;       // field4 length(?4?)
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,236 :: 		app_command_buf[ 5 ]  = 0x00;       // field 4 length, (? 8?), length = 0 Means this field did not use
MOV	R0, SP
ADDS	R1, R0, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,237 :: 		app_command_buf[ 6 ]  = 0x00;       // field 4 Is not 4FSK,manchest, whiting, PN9
MOV	R0, SP
ADDS	R1, R0, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,238 :: 		app_command_buf[ 7 ]  = 0x00;       // field 4 ?CRCSet up
MOV	R0, SP
ADDS	R1, R0, #7
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,239 :: 		app_command_buf[ 8 ]  = 0x00;       // field5 length(?4?)
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #8
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,240 :: 		app_command_buf[ 9 ]  = 0x00;       // field 5 length, (? 8?), length = 0 Means this field did not use
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #9
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,241 :: 		app_command_buf[ 10 ] = 0x00;       // field 5 Is not 4FSK,manchest, whiting, PN9
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,242 :: 		app_command_buf[ 11 ] = 0x00;       // field 5 ?CRCSet up
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #11
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,243 :: 		spi_write( 12, app_command_buf );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #12
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,246 :: 		spi_write( 0x10, RF_MODEM_MOD_TYPE_12_data );   // //  2FSK ,  module source = PH fifo, disable manchest, tx, rx Do not flip, deviation Do not flip
MOVW	R0, #lo_addr(_RF_MODEM_MOD_TYPE_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_MOD_TYPE_12_data+0)
PUSH	(R0)
MOVS	R0, #16
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,249 :: 		app_command_buf[0] = 0x11;
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,250 :: 		app_command_buf[1]  = 0x20;    // 0x200c
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,251 :: 		app_command_buf[2]  = 0x01;    // Total 1Parameters
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,252 :: 		app_command_buf[3]  = 0x0c;   // 0x200c
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #12
STRB	R0, [R1, #0]
;driverrf4463pro.c,254 :: 		if ( freq3 < 8 ) {
MOVW	R0, #lo_addr(_freq3+0)
MOVT	R0, #hi_addr(_freq3+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CS
BLCS	L_vRF4463Init96
;driverrf4463pro.c,255 :: 		if ( rate >= dr_256k ) {
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CC
BLCC	L_vRF4463Init97
;driverrf4463pro.c,256 :: 		app_command_buf[ 4 ] = 0x4f;
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #79
STRB	R0, [R1, #0]
;driverrf4463pro.c,257 :: 		}
IT	AL
BLAL	L_vRF4463Init98
L_vRF4463Init97:
;driverrf4463pro.c,258 :: 		else if ( rate >= dr_19p2 ) {
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	CC
BLCC	L_vRF4463Init99
;driverrf4463pro.c,259 :: 		app_command_buf[ 4 ]  = 0x5e;
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #94
STRB	R0, [R1, #0]
;driverrf4463pro.c,260 :: 		}
IT	AL
BLAL	L_vRF4463Init100
L_vRF4463Init99:
;driverrf4463pro.c,262 :: 		app_command_buf[ 4 ]  = 0xd2;
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #210
STRB	R0, [R1, #0]
;driverrf4463pro.c,263 :: 		}
L_vRF4463Init100:
L_vRF4463Init98:
;driverrf4463pro.c,264 :: 		}
IT	AL
BLAL	L_vRF4463Init101
L_vRF4463Init96:
;driverrf4463pro.c,266 :: 		if ( rate >= dr_115p2 ) {
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	CC
BLCC	L_vRF4463Init102
;driverrf4463pro.c,267 :: 		app_command_buf[ 4 ]  = 0x69;        // 15k
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #105
STRB	R0, [R1, #0]
;driverrf4463pro.c,268 :: 		}
IT	AL
BLAL	L_vRF4463Init103
L_vRF4463Init102:
;driverrf4463pro.c,269 :: 		else if ( rate >= dr_19p2 ) {
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	CC
BLCC	L_vRF4463Init104
;driverrf4463pro.c,270 :: 		app_command_buf[ 4 ]  = 0x5e;        // 10k
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #94
STRB	R0, [R1, #0]
;driverrf4463pro.c,271 :: 		}
IT	AL
BLAL	L_vRF4463Init105
L_vRF4463Init104:
;driverrf4463pro.c,273 :: 		app_command_buf[ 4 ]  = 0x18; // 8k
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #24
STRB	R0, [R1, #0]
;driverrf4463pro.c,274 :: 		}
L_vRF4463Init105:
L_vRF4463Init103:
;driverrf4463pro.c,275 :: 		}
L_vRF4463Init101:
;driverrf4463pro.c,276 :: 		spi_write( 5, app_command_buf );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,279 :: 		spi_write( 0x0C, RF_MODEM_TX_RAMP_DELAY_8_data );            // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_TX_RAMP_DELAY_8_data+0)
PUSH	(R0)
MOVS	R0, #12
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,280 :: 		spi_write( 0x0D, RF_MODEM_BCR_OSR_1_9_data );                // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_BCR_OSR_1_9_data+0)
PUSH	(R0)
MOVS	R0, #13
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,281 :: 		spi_write( 0x0B, RF_MODEM_AFC_GEAR_7_data );                // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_AFC_GEAR_7_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AFC_GEAR_7_data+0)
PUSH	(R0)
MOVS	R0, #11
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,282 :: 		spi_write( 0x05, RF_MODEM_AGC_CONTROL_1_data );                // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_AGC_CONTROL_1_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_CONTROL_1_data+0)
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,283 :: 		spi_write( 0x0D, RF_MODEM_AGC_WINDOW_SIZE_9_data );        // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_AGC_WINDOW_SIZE_9_data+0)
PUSH	(R0)
MOVS	R0, #13
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,284 :: 		spi_write( 0x0F, RF_MODEM_OOK_CNT1_11_data );                // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_OOK_CNT1_11_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_OOK_CNT1_11_data+0)
PUSH	(R0)
MOVS	R0, #15
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,287 :: 		app_command_buf[ 0 ] = 0x11;
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,288 :: 		app_command_buf[ 1 ] = 0x20;    // 0x204e
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,289 :: 		app_command_buf[ 2 ] = 0x01;    // Total 1Parameters
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,290 :: 		app_command_buf[ 3 ] = 0x4e;   // 0x204e
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #78
STRB	R0, [R1, #0]
;driverrf4463pro.c,292 :: 		if ( rate == dr_500 ) {
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	NE
BLNE	L_vRF4463Init106
;driverrf4463pro.c,293 :: 		app_command_buf[ 4 ] = 0x3a;
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #58
STRB	R0, [R1, #0]
;driverrf4463pro.c,294 :: 		}
IT	AL
BLAL	L_vRF4463Init107
L_vRF4463Init106:
;driverrf4463pro.c,296 :: 		app_command_buf[ 4 ] = 0x40;  //  rssi Reading deviation, the difference with the true value
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #64
STRB	R0, [R1, #0]
;driverrf4463pro.c,297 :: 		}
L_vRF4463Init107:
;driverrf4463pro.c,298 :: 		spi_write( 5, app_command_buf );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,301 :: 		spi_write( 0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data );  // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE13_7_0_12_data+0)
PUSH	(R0)
MOVS	R0, #16
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,302 :: 		spi_write( 0x10, RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data );   // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX1_CHFLT_COE1_7_0_12_data+0)
PUSH	(R0)
MOVS	R0, #16
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,303 :: 		spi_write( 0x10, RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data );   // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
MOVT	R0, #hi_addr(_RF_MODEM_CHFLT_RX2_CHFLT_COE7_7_0_12_data+0)
PUSH	(R0)
MOVS	R0, #16
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,306 :: 		app_command_buf[ 0 ]  = 0x11;
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,307 :: 		app_command_buf[ 1 ]  = 0x22;    // 0x2200
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #34
STRB	R0, [R1, #0]
;driverrf4463pro.c,308 :: 		app_command_buf[ 2 ]  = 0x04;    // Total 4Parameters
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #4
STRB	R0, [R1, #0]
;driverrf4463pro.c,309 :: 		app_command_buf[ 3 ]  = 0x00;   // 0x2200
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,310 :: 		app_command_buf[ 4 ]  = 0x08;  //0x10;   //   PA mode  = default , ??Class E mode,?Is not Switch Current mode  ????????
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,336 :: 		if ( power > 0 || power < 127 ) {
MOVW	R0, #lo_addr(_power+0)
MOVT	R0, #hi_addr(_power+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	HI
BLHI	L__vRF4463Init252
MOVW	R0, #lo_addr(_power+0)
MOVT	R0, #hi_addr(_power+0)
LDRB	R0, [R0, #0]
CMP	R0, #127
IT	CC
BLCC	L__vRF4463Init252
IT	AL
BLAL	L_vRF4463Init110
L__vRF4463Init252:
;driverrf4463pro.c,337 :: 		app_command_buf[ 5 ]  = power;   //  Set to maximum power
MOV	R0, SP
ADDS	R1, R0, #5
MOVW	R0, #lo_addr(_power+0)
MOVT	R0, #hi_addr(_power+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;driverrf4463pro.c,338 :: 		}
IT	AL
BLAL	L_vRF4463Init111
L_vRF4463Init110:
;driverrf4463pro.c,340 :: 		app_command_buf[ 5 ]  = 127;
MOV	R0, SP
ADDS	R1, R0, #5
MOVS	R0, #127
STRB	R0, [R1, #0]
;driverrf4463pro.c,341 :: 		}
L_vRF4463Init111:
;driverrf4463pro.c,343 :: 		app_command_buf[ 6 ] = 0x00; //???????? 0x00;   // CLK duty = 50%, other = Default
MOV	R0, SP
ADDS	R1, R0, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,345 :: 		if ( ( rate <= dr_115p2 )||( rate == dr_500 ) ) {
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	LS
BLLS	L__vRF4463Init251
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	EQ
BLEQ	L__vRF4463Init251
IT	AL
BLAL	L_vRF4463Init114
L__vRF4463Init251:
;driverrf4463pro.c,346 :: 		app_command_buf[ 7 ]  = 0x3d;  // ???????? 0x5d;   // PA ramp time = default
MOV	R0, SP
ADDS	R1, R0, #7
MOVS	R0, #61
STRB	R0, [R1, #0]
;driverrf4463pro.c,347 :: 		}
IT	AL
BLAL	L_vRF4463Init115
L_vRF4463Init114:
;driverrf4463pro.c,349 :: 		app_command_buf[ 7 ]  = 0x5d;
MOV	R0, SP
ADDS	R1, R0, #7
MOVS	R0, #93
STRB	R0, [R1, #0]
;driverrf4463pro.c,350 :: 		}
L_vRF4463Init115:
;driverrf4463pro.c,351 :: 		spi_write( 8, app_command_buf );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #8
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,355 :: 		spi_write( 0x0B , RF_SYNTH_PFDCP_CPFF_7_data );      // Without this Parameters,Not needed
MOVW	R0, #lo_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
MOVT	R0, #hi_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
PUSH	(R0)
MOVS	R0, #11
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,358 :: 		app_command_buf[ 0 ]  = 0x11;    // SetProperty
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,359 :: 		app_command_buf[ 1 ]  = 0x30;    // 0x30 group
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #48
STRB	R0, [R1, #0]
;driverrf4463pro.c,360 :: 		app_command_buf[ 2 ]  = 0x0c;    // Total 12 Parameters
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #12
STRB	R0, [R1, #0]
;driverrf4463pro.c,361 :: 		app_command_buf[ 3 ]  = 0x00;    // 0x00 Index
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,362 :: 		app_command_buf[ 4 ]  = 's';     // match 1 Value of
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #115
STRB	R0, [R1, #0]
;driverrf4463pro.c,363 :: 		app_command_buf[ 5 ]  = 0xFF;    // match 1 mask
MOV	R0, SP
ADDS	R1, R0, #5
MOVS	R0, #255
STRB	R0, [R1, #0]
;driverrf4463pro.c,364 :: 		app_command_buf[ 6 ]  = 0x40;    // enable match 1, match 1 The distance between the value of and the synchronization word, 0 = match
MOV	R0, SP
ADDS	R1, R0, #6
MOVS	R0, #64
STRB	R0, [R1, #0]
;driverrf4463pro.c,365 :: 		app_command_buf[ 7 ]  = 'w';     // match 2 Value of
MOV	R0, SP
ADDS	R1, R0, #7
MOVS	R0, #119
STRB	R0, [R1, #0]
;driverrf4463pro.c,366 :: 		app_command_buf[ 8 ]  = 0xFF;    // match 2 mask
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #8
MOVS	R0, #255
STRB	R0, [R1, #0]
;driverrf4463pro.c,367 :: 		app_command_buf[ 9 ]  = 0x01;    // enable match 2, match 2 The distance between the value of and the synchronization word  , and function
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #9
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,368 :: 		app_command_buf[ 10 ] = 'w';     // match 3 Value of
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #10
MOVS	R0, #119
STRB	R0, [R1, #0]
;driverrf4463pro.c,369 :: 		app_command_buf[ 11 ] = 0xFF;;   // match 3 mask
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #11
MOVS	R0, #255
STRB	R0, [R1, #0]
;driverrf4463pro.c,370 :: 		app_command_buf[ 12 ] = 0x02;;   // enable match 3, match 3 The distance between the value of and the synchronization word    and function
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #12
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,371 :: 		app_command_buf[ 13 ] = 'x';     // match 4 Value of
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #13
MOVS	R0, #120
STRB	R0, [R1, #0]
;driverrf4463pro.c,372 :: 		app_command_buf[ 14 ] = 0xFF;    // match 4 mask
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #14
MOVS	R0, #255
STRB	R0, [R1, #0]
;driverrf4463pro.c,373 :: 		app_command_buf[ 15 ] = 0x03;    // enable match 4, match 4 The distance between the value of and the synchronization word    and function
MOV	R0, SP
MOV	R1, R0
ADDS	R1, #15
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,374 :: 		spi_write( 16, app_command_buf );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #16
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,376 :: 		rf_init_freq();     // FUNCION DE FRECUENCIA ( REVISAR PARAMETROS )
BL	_rf_init_freq+0
;driverrf4463pro.c,377 :: 		}
L_end_vRF4463Init:
ADD	SP, SP, #24
POP	(R15)
; end of _vRF4463Init
_vRF4463GPIO_SET:
;driverrf4463pro.c,383 :: 		void vRF4463GPIO_SET( unsigned char ucData ) {
PUSH	(R14)
SUB	SP, SP, #8
;driverrf4463pro.c,386 :: 		ucAppCommandBuf[0] = 0x13;     // gpio Set up
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #19
STRB	R0, [R1, #0]
;driverrf4463pro.c,388 :: 		switch ( ucData ) {
IT	AL
BLAL	L_vRF4463GPIO_SET116
;driverrf4463pro.c,389 :: 		case tx_normal:
L_vRF4463GPIO_SET118:
;driverrf4463pro.c,390 :: 		case rx_normal: ucAppCommandBuf[ 1 ] = 3;                 // GPIO0=1
L_vRF4463GPIO_SET119:
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,391 :: 		ucAppCommandBuf[ 2 ] = 2;                // GPIO1=0
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,392 :: 		break;
IT	AL
BLAL	L_vRF4463GPIO_SET117
;driverrf4463pro.c,394 :: 		case tx_test:   ucAppCommandBuf[ 1 ] = 3;                 // GPIO0=1
L_vRF4463GPIO_SET120:
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,395 :: 		ucAppCommandBuf[ 2 ] = 3;                // GPIO1=1
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,396 :: 		break;
IT	AL
BLAL	L_vRF4463GPIO_SET117
;driverrf4463pro.c,398 :: 		case rx_test:   ucAppCommandBuf[ 1 ] = 2;                 // GPIO0=0
L_vRF4463GPIO_SET121:
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,399 :: 		ucAppCommandBuf[ 2 ] = 20;                // GPIO1=RX DATA
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #20
STRB	R0, [R1, #0]
;driverrf4463pro.c,400 :: 		break;
IT	AL
BLAL	L_vRF4463GPIO_SET117
;driverrf4463pro.c,402 :: 		case rf_off:    ucAppCommandBuf[ 1 ] = 2;                 // GPIO0=0
L_vRF4463GPIO_SET122:
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,403 :: 		ucAppCommandBuf[ 2 ] = 2;                // GPIO1=0
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,404 :: 		break;
IT	AL
BLAL	L_vRF4463GPIO_SET117
;driverrf4463pro.c,405 :: 		}
L_vRF4463GPIO_SET116:
LDR	R0, [SP, #12]
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BLEQ	L_vRF4463GPIO_SET118
LDR	R0, [SP, #12]
UXTB	R0, R0
CMP	R0, #1
IT	EQ
BLEQ	L_vRF4463GPIO_SET119
LDR	R0, [SP, #12]
UXTB	R0, R0
CMP	R0, #2
IT	EQ
BLEQ	L_vRF4463GPIO_SET120
LDR	R0, [SP, #12]
UXTB	R0, R0
CMP	R0, #3
IT	EQ
BLEQ	L_vRF4463GPIO_SET121
LDR	R0, [SP, #12]
UXTB	R0, R0
CMP	R0, #4
IT	EQ
BLEQ	L_vRF4463GPIO_SET122
L_vRF4463GPIO_SET117:
;driverrf4463pro.c,407 :: 		ucAppCommandBuf[ 3 ]  = 0x21;     //0x20;   //  gpio2, h = tx mode
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #33
STRB	R0, [R1, #0]
;driverrf4463pro.c,408 :: 		ucAppCommandBuf[ 4 ]  = 0x20;     // 0x14;  //   gpio3
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,409 :: 		ucAppCommandBuf[ 5 ]  = 0x27;     // nIRQ
MOV	R0, SP
ADDS	R1, R0, #5
MOVS	R0, #39
STRB	R0, [R1, #0]
;driverrf4463pro.c,410 :: 		ucAppCommandBuf[ 6 ]  = 0x0b;     // sdo
MOV	R0, SP
ADDS	R1, R0, #6
MOVS	R0, #11
STRB	R0, [R1, #0]
;driverrf4463pro.c,411 :: 		spi_write( 7, ucAppCommandBuf );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #7
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,412 :: 		}
L_end_vRF4463GPIO_SET:
ADD	SP, SP, #8
POP	(R15)
; end of _vRF4463GPIO_SET
_vRF4463FifoReset:
;driverrf4463pro.c,417 :: 		void vRF4463FifoReset( void ) {
PUSH	(R14)
SUB	SP, SP, #4
;driverrf4463pro.c,420 :: 		p[ 0 ] = FIFO_INFO;
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #21
STRB	R0, [R1, #0]
;driverrf4463pro.c,421 :: 		p[ 1 ] = 0x03;   // reset tx ,rx fifo
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,422 :: 		spi_write( 2, p );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #2
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,423 :: 		}
L_end_vRF4463FifoReset:
ADD	SP, SP, #4
POP	(R15)
; end of _vRF4463FifoReset
_vRF4463ClearInterrupts:
;driverrf4463pro.c,429 :: 		void vRF4463ClearInterrupts( void ) {
PUSH	(R14)
SUB	SP, SP, #4
;driverrf4463pro.c,432 :: 		p[ 0 ] = GET_INT_STATUS;
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,433 :: 		p[ 1 ] = 0;               // clr  PH pending
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,434 :: 		p[ 2 ] = 0;               // clr modem_pending
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,435 :: 		p[ 3 ] = 0;               // clr chip pending
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,436 :: 		spi_write( 4, p );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #4
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,437 :: 		spi_read( 9, GET_INT_STATUS );
MOVS	R0, #32
PUSH	(R0)
MOVS	R0, #9
PUSH	(R0)
BL	_spi_read+0
ADD	SP, SP, #8
;driverrf4463pro.c,438 :: 		}
L_end_vRF4463ClearInterrupts:
ADD	SP, SP, #4
POP	(R15)
; end of _vRF4463ClearInterrupts
_vRF4463PartInfo:
;driverrf4463pro.c,440 :: 		void vRF4463PartInfo( void ) {  // Solicitud totalmente operativa
PUSH	(R14)
SUB	SP, SP, #12
;driverrf4463pro.c,443 :: 		p[ 0 ] = PART_INFO;
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,447 :: 		spi_write( 1, p );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #1
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,448 :: 		spi_read( 9, PART_INFO );
MOVS	R0, #1
PUSH	(R0)
MOVS	R0, #9
PUSH	(R0)
BL	_spi_read+0
ADD	SP, SP, #8
;driverrf4463pro.c,449 :: 		}
L_end_vRF4463PartInfo:
ADD	SP, SP, #12
POP	(R15)
; end of _vRF4463PartInfo
_vRF4463EnableRxInterrupt:
;driverrf4463pro.c,454 :: 		void vRF4463EnableRxInterrupt( void ) {
PUSH	(R14)
SUB	SP, SP, #8
;driverrf4463pro.c,457 :: 		p[ 0 ] = 0x11;
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,458 :: 		p[ 1 ] = 0x01;            // 0x0100
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,459 :: 		p[ 2 ] = 0x03;            // 3Parameters
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,460 :: 		p[ 3 ] = 0x00;            // 0100
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,461 :: 		p[ 4 ] = 0x03;            // ph, modem int       0x03;
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #3
STRB	R0, [R1, #0]
;driverrf4463pro.c,462 :: 		p[ 5 ] = 0x18;            // 0x10;   // Pack received int
MOV	R0, SP
ADDS	R1, R0, #5
MOVS	R0, #24
STRB	R0, [R1, #0]
;driverrf4463pro.c,463 :: 		p[ 6 ] = 0x00;            //preamble int, sync int setting
MOV	R0, SP
ADDS	R1, R0, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,464 :: 		spi_write( 0x07, p );     // enable  packet receive interrupt
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #7
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,465 :: 		}
L_end_vRF4463EnableRxInterrupt:
ADD	SP, SP, #8
POP	(R15)
; end of _vRF4463EnableRxInterrupt
_vRF4463EnableTxInterrupt:
;driverrf4463pro.c,470 :: 		void vRF4463EnableTxInterrupt( void ) {
PUSH	(R14)
SUB	SP, SP, #8
;driverrf4463pro.c,473 :: 		p[ 0 ] = 0x11;
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,474 :: 		p[ 1 ] = 0x01;            // 0x0100
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,475 :: 		p[ 2 ] = 0x02;            // 2Parameters
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #2
STRB	R0, [R1, #0]
;driverrf4463pro.c,476 :: 		p[ 3 ] = 0x00;            // 0x0100
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,477 :: 		p[ 4 ] = 0x01;            // Ph  int
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,478 :: 		p[ 5 ] = 0x20;            //  enable  packet sent interrupt
MOV	R0, SP
ADDS	R1, R0, #5
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,479 :: 		spi_write( 0x06, p );     // enable  packet receive interrupt
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #6
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,480 :: 		}
L_end_vRF4463EnableTxInterrupt:
ADD	SP, SP, #8
POP	(R15)
; end of _vRF4463EnableTxInterrupt
_vRF4463RfStandby:
;driverrf4463pro.c,485 :: 		void vRF4463RfStandby( void ) {
PUSH	(R14)
SUB	SP, SP, #4
;driverrf4463pro.c,488 :: 		p[ 0 ] = CHANGE_STATE ;   // CHANGE_STATE Command
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #52
STRB	R0, [R1, #0]
;driverrf4463pro.c,489 :: 		p[ 1 ] = 0x01 ;           // sleep mode
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,490 :: 		spi_write( 2, p );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #2
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,491 :: 		}
L_end_vRF4463RfStandby:
ADD	SP, SP, #4
POP	(R15)
; end of _vRF4463RfStandby
_vRF4463TxStart:
;driverrf4463pro.c,496 :: 		void vRF4463TxStart( void ) {
PUSH	(R14)
SUB	SP, SP, #8
;driverrf4463pro.c,499 :: 		p[ 0 ] = START_TX ;       // start Command
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #49
STRB	R0, [R1, #0]
;driverrf4463pro.c,500 :: 		p[ 1 ] = freq_channel;    // channel 0
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,501 :: 		p[ 2 ] = 0x30;            // Back after launch Readymode, Do not retransmit, launch immediately
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #48
STRB	R0, [R1, #0]
;driverrf4463pro.c,502 :: 		p[ 3 ] = 0;
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,503 :: 		p[ 4 ] = 0;               //payload_length; // Total to transmit 10 bytes
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,504 :: 		spi_write( 5, p );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,505 :: 		}
L_end_vRF4463TxStart:
ADD	SP, SP, #8
POP	(R15)
; end of _vRF4463TxStart
_vRF4463RxStart:
;driverrf4463pro.c,510 :: 		void vRF4463RxStart( void ) {
PUSH	(R14)
SUB	SP, SP, #8
;driverrf4463pro.c,513 :: 		p[ 0 ] = START_RX ;       // start Command
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #50
STRB	R0, [R1, #0]
;driverrf4463pro.c,514 :: 		p[ 1 ] = freq_channel;    // channel 0
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,515 :: 		p[ 2 ] = 0x00;            // Enter receiving mode immediately
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,516 :: 		p[ 3 ] = 0;
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,517 :: 		p[ 4 ] = 0;               // payload_length; // Total to receive 10 bytes
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,518 :: 		p[ 5 ] = 0;               // unchanged after preamble timeout
MOV	R0, SP
ADDS	R1, R0, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,521 :: 		p[ 6 ] = 0x08;
MOV	R0, SP
ADDS	R1, R0, #6
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,522 :: 		p[ 7 ] = 0x08;
MOV	R0, SP
ADDS	R1, R0, #7
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,523 :: 		spi_write( 8, p );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #8
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,524 :: 		}
L_end_vRF4463RxStart:
ADD	SP, SP, #8
POP	(R15)
; end of _vRF4463RxStart
_vRF4463RxStartTest:
;driverrf4463pro.c,529 :: 		void vRF4463RxStartTest( void ) {
PUSH	(R14)
SUB	SP, SP, #8
;driverrf4463pro.c,532 :: 		LED_GREEN = 1;
MOVW	R2, #lo_addr(GPIOC_ODRbits+0)
MOVT	R2, #hi_addr(GPIOC_ODRbits+0)
_LX	[R2, ByteOffset(GPIOC_ODRbits+0)]
MOVS	R1, #64
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOC_ODRbits+0)]
;driverrf4463pro.c,534 :: 		p[ 0 ] = START_RX;        // start Command
MOV	R0, SP
ADDS	R1, R0, #0
MOVS	R0, #50
STRB	R0, [R1, #0]
;driverrf4463pro.c,535 :: 		p[ 1 ] = freq_channel;    // channel 0
MOV	R0, SP
ADDS	R1, R0, #1
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,536 :: 		p[ 2 ] = 0x00;            // Enter receiving mode immediately
MOV	R0, SP
ADDS	R1, R0, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,537 :: 		p[ 3 ] = 0;
MOV	R0, SP
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,539 :: 		p[ 4 ] = 0;
MOV	R0, SP
ADDS	R1, R0, #4
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,540 :: 		p[ 5 ] = 0;               // unchanged after preamble timeout
MOV	R0, SP
ADDS	R1, R0, #5
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,543 :: 		p[ 6 ] = 0x08;
MOV	R0, SP
ADDS	R1, R0, #6
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,544 :: 		p[ 7 ] = 0x08;
MOV	R0, SP
ADDS	R1, R0, #7
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,545 :: 		spi_write( 8, p );
MOV	R0, SP
PUSH	(R0)
MOVS	R0, #8
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,546 :: 		}
L_end_vRF4463RxStartTest:
ADD	SP, SP, #8
POP	(R15)
; end of _vRF4463RxStartTest
_vRF4463RxInit:
;driverrf4463pro.c,551 :: 		void vRF4463RxInit( void ) {
PUSH	(R14)
;driverrf4463pro.c,552 :: 		Flag.is_tx = 0;
MOVW	R2, #lo_addr(_Flag+0)
MOVT	R2, #hi_addr(_Flag+0)
_LX	[R2, ByteOffset(_Flag+0)]
MOVS	R1, #2
BICS	R0, R1
_SX	[R2, ByteOffset(_Flag+0)]
;driverrf4463pro.c,553 :: 		vRF4463FifoReset();           // fifo_reset();  // Buffer empty
BL	_vRF4463FifoReset+0
;driverrf4463pro.c,554 :: 		vRF4463EnableRxInterrupt();   // enable_rx_interrupt();
BL	_vRF4463EnableRxInterrupt+0
;driverrf4463pro.c,555 :: 		vRF4463ClearInterrupts();      // clr_interrupt();  // Clear interrupt factor
BL	_vRF4463ClearInterrupts+0
;driverrf4463pro.c,557 :: 		if ( mode == rx_test_mode ) {
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BLNE	L_vRF4463RxInit123
;driverrf4463pro.c,558 :: 		vRF4463RxStartTest();      // rx_start_test();
BL	_vRF4463RxStartTest+0
;driverrf4463pro.c,559 :: 		}
IT	AL
BLAL	L_vRF4463RxInit124
L_vRF4463RxInit123:
;driverrf4463pro.c,561 :: 		vRF4463RxStart();        // rx_start();    // Enter receiving mode, after receiving data, return to Readymode
BL	_vRF4463RxStart+0
;driverrf4463pro.c,562 :: 		}
L_vRF4463RxInit124:
;driverrf4463pro.c,563 :: 		}
L_end_vRF4463RxInit:
POP	(R15)
; end of _vRF4463RxInit
_vRF4463TxData:
;driverrf4463pro.c,568 :: 		void vRF4463TxData( void ) {
PUSH	(R14)
SUB	SP, SP, #20
;driverrf4463pro.c,571 :: 		ucRF4463IRQ = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
STRB	R1, [R0, #0]
;driverrf4463pro.c,573 :: 		Flag.is_tx = 1;
MOVW	R2, #lo_addr(_Flag+0)
MOVT	R2, #hi_addr(_Flag+0)
_LX	[R2, ByteOffset(_Flag+0)]
MOVS	R1, #2
ORRS	R0, R1
_SX	[R2, ByteOffset(_Flag+0)]
;driverrf4463pro.c,574 :: 		LED_RED ^= 1;
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_LX	[R0, ByteOffset(GPIOC_ODRbits+0)]
MOVS	R2, #64
ANDS	R2, R0
LSRS	R2, R2, #6
MOVW	R0, #lo_addr(_ucSPI1ByteReceived+0)
MOVT	R0, #hi_addr(_ucSPI1ByteReceived+0)
LDRB	R1, [R0, #0]
MOVS	R0, BitMask(_ucSPI1ByteReceived+0)
ANDS	R0, R1
LSRS	R0, R0, BitPos(_ucSPI1ByteReceived+0)
MOV	R3, R2
EORS	R3, R0
MOVW	R2, #lo_addr(GPIOC_ODRbits+0)
MOVT	R2, #hi_addr(GPIOC_ODRbits+0)
_LX	[R2, ByteOffset(GPIOC_ODRbits+0)]
MOVS	R1, #1
ANDS	R1, R3
BEQ	L__vRF4463TxData275
MOVS	R1, #64
ORRS	R0, R1
B	L__vRF4463TxData274
L__vRF4463TxData275:
MOVS	R1, #64
BICS	R0, R1
L__vRF4463TxData274:
_SX	[R2, ByteOffset(GPIOC_ODRbits+0)]
;driverrf4463pro.c,575 :: 		Delay_ms( 30 );
LDR	R7, [PC, #119999]
NOP
L_vRF4463TxData125:
SUBS	R7, R7, #1
BNE	L_vRF4463TxData125
B	#4
	#119999
NOP
;driverrf4463pro.c,576 :: 		LED_RED ^= 1;
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_LX	[R0, ByteOffset(GPIOC_ODRbits+0)]
MOVS	R2, #64
ANDS	R2, R0
LSRS	R2, R2, #6
MOVW	R0, #lo_addr(_ucSPI1ByteReceived+0)
MOVT	R0, #hi_addr(_ucSPI1ByteReceived+0)
LDRB	R1, [R0, #0]
MOVS	R0, BitMask(_ucSPI1ByteReceived+0)
ANDS	R0, R1
LSRS	R0, R0, BitPos(_ucSPI1ByteReceived+0)
MOV	R3, R2
EORS	R3, R0
MOVW	R2, #lo_addr(GPIOC_ODRbits+0)
MOVT	R2, #hi_addr(GPIOC_ODRbits+0)
_LX	[R2, ByteOffset(GPIOC_ODRbits+0)]
MOVS	R1, #1
ANDS	R1, R3
BEQ	L__vRF4463TxData277
MOVS	R1, #64
ORRS	R0, R1
B	L__vRF4463TxData276
L__vRF4463TxData277:
MOVS	R1, #64
BICS	R0, R1
L__vRF4463TxData276:
_SX	[R2, ByteOffset(GPIOC_ODRbits+0)]
;driverrf4463pro.c,577 :: 		vRF4463FifoReset();            // fifo_reset();  // Buffer empty
BL	_vRF4463FifoReset+0
;driverrf4463pro.c,578 :: 		spi_write_fifo();              // Fill the buffer with data
BL	_spi_write_fifo+0
;driverrf4463pro.c,579 :: 		vRF4463EnableTxInterrupt();    // enable_tx_interrupt();
BL	_vRF4463EnableTxInterrupt+0
;driverrf4463pro.c,580 :: 		vRF4463ClearInterrupts();       // clr_interrupt();  // Clear interrupt factor
BL	_vRF4463ClearInterrupts+0
;driverrf4463pro.c,581 :: 		vRF4463TxStart();              // tx_start();    // Enter launch mode, start launch
BL	_vRF4463TxStart+0
;driverrf4463pro.c,582 :: 		rf_timeout = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_rf_timeout+0)
MOVT	R0, #hi_addr(_rf_timeout+0)
STRH	R1, [R0, #0]
;driverrf4463pro.c,584 :: 		Flag.rf_reach_timeout = 0;
MOVW	R2, #lo_addr(_Flag+0)
MOVT	R2, #hi_addr(_Flag+0)
_LX	[R2, ByteOffset(_Flag+0)]
MOVS	R1, #4
BICS	R0, R1
_SX	[R2, ByteOffset(_Flag+0)]
;driverrf4463pro.c,586 :: 		if ( ucRF4463IRQ ) {
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L_vRF4463TxData127
;driverrf4463pro.c,587 :: 		UART1_Write_Text( "[ UART1 ] TX INT\r\n" );
MOV	R6, SP
MOVS	R5, #19
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr1_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr1_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOV	R0, SP
MOV	R4, R0
MOV	R0, R4
BL	_UART1_Write_Text+0
;driverrf4463pro.c,588 :: 		}
L_vRF4463TxData127:
;driverrf4463pro.c,591 :: 		while ( nIRQ ) {     //nIRQ
L_vRF4463TxData128:
MOVW	R0, #lo_addr(GPIOA_IDRbits+0)
MOVT	R0, #hi_addr(GPIOA_IDRbits+0)
_LX	[R0, ByteOffset(GPIOA_IDRbits+0)]
MOVS	R0, #4
ANDS	R0, R1
LSRS	R0, R0, #2
CMP	R0, #0
IT	EQ
BLEQ	L_vRF4463TxData129
;driverrf4463pro.c,594 :: 		if ( Flag.rf_reach_timeout ) {
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
_LX	[R0, ByteOffset(_Flag+0)]
MOVS	R0, #4
ANDS	R0, R1
LSRS	R0, R0, #2
CMP	R0, #0
IT	EQ
BLEQ	L_vRF4463TxData130
;driverrf4463pro.c,595 :: 		VRF4463SDNReset();
BL	_VRF4463SDNReset+0
;driverrf4463pro.c,596 :: 		vRF4463Init();        //SI4463_init();  // RF Module initialization
BL	_vRF4463Init+0
;driverrf4463pro.c,597 :: 		break;                // Forced out
IT	AL
BLAL	L_vRF4463TxData129
;driverrf4463pro.c,598 :: 		}
L_vRF4463TxData130:
;driverrf4463pro.c,599 :: 		}
IT	AL
BLAL	L_vRF4463TxData128
L_vRF4463TxData129:
;driverrf4463pro.c,601 :: 		tx_cnt++;
MOVW	R0, #lo_addr(_tx_cnt+0)
MOVT	R0, #hi_addr(_tx_cnt+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(_tx_cnt+0)
MOVT	R0, #hi_addr(_tx_cnt+0)
STR	R1, [R0, #0]
;driverrf4463pro.c,603 :: 		vRF4463RxInit();          // rx_init();                //rf After the transmission is completed, enter the receiving mode
BL	_vRF4463RxInit+0
;driverrf4463pro.c,604 :: 		}
L_end_vRF4463TxData:
ADD	SP, SP, #20
POP	(R15)
; end of _vRF4463TxData
_vRF4463TxCont:
;driverrf4463pro.c,609 :: 		void vRF4463TxCont( void ) {
PUSH	(R14)
;driverrf4463pro.c,612 :: 		LED_RED = 1;
MOVW	R2, #lo_addr(GPIOC_ODRbits+0)
MOVT	R2, #hi_addr(GPIOC_ODRbits+0)
_LX	[R2, ByteOffset(GPIOC_ODRbits+0)]
MOVS	R1, #64
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOC_ODRbits+0)]
;driverrf4463pro.c,613 :: 		vRF4463FifoReset();                     //  fifo_reset();  // Buffer empty
BL	_vRF4463FifoReset+0
;driverrf4463pro.c,614 :: 		spi_write_fifo();                       // Fill the buffer with data
BL	_spi_write_fifo+0
;driverrf4463pro.c,615 :: 		vRF4463EnableTxInterrupt();             //  enable_tx_interrupt();
BL	_vRF4463EnableTxInterrupt+0
;driverrf4463pro.c,616 :: 		vRF4463ClearInterrupts();               //  clr_interrupt();  // Clear interrupt factor
BL	_vRF4463ClearInterrupts+0
;driverrf4463pro.c,617 :: 		vRF4463TxStart();                       //  tx_start();    // Enter launch mode, start launch
BL	_vRF4463TxStart+0
;driverrf4463pro.c,618 :: 		rf_timeout = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_rf_timeout+0)
MOVT	R0, #hi_addr(_rf_timeout+0)
STRH	R1, [R0, #0]
;driverrf4463pro.c,619 :: 		Flag.rf_reach_timeout = 0;
MOVW	R2, #lo_addr(_Flag+0)
MOVT	R2, #hi_addr(_Flag+0)
_LX	[R2, ByteOffset(_Flag+0)]
MOVS	R1, #4
BICS	R0, R1
_SX	[R2, ByteOffset(_Flag+0)]
;driverrf4463pro.c,621 :: 		ucRF4463IRQ = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
STRB	R1, [R0, #0]
;driverrf4463pro.c,624 :: 		while( nIRQ ) {          //nIRQ ) {
L_vRF4463TxCont131:
MOVW	R0, #lo_addr(GPIOA_IDRbits+0)
MOVT	R0, #hi_addr(GPIOA_IDRbits+0)
_LX	[R0, ByteOffset(GPIOA_IDRbits+0)]
MOVS	R0, #4
ANDS	R0, R1
LSRS	R0, R0, #2
CMP	R0, #0
IT	EQ
BLEQ	L_vRF4463TxCont132
;driverrf4463pro.c,632 :: 		}
IT	AL
BLAL	L_vRF4463TxCont131
L_vRF4463TxCont132:
;driverrf4463pro.c,633 :: 		}
L_end_vRF4463TxCont:
POP	(R15)
; end of _vRF4463TxCont
_rf_init_freq:
;driverrf4463pro.c,638 :: 		void rf_init_freq ( void ) {
PUSH	(R14)
SUB	SP, SP, #64
;driverrf4463pro.c,644 :: 		ulFrequency = ( freq3 * 100) + ( freq2 * 10) + freq1;
MOVW	R0, #lo_addr(_freq3+0)
MOVT	R0, #hi_addr(_freq3+0)
LDRB	R1, [R0, #0]
MOVS	R0, #100
MOV	R3, R0
MULS	R3, R1, R3
SXTH	R3, R3
MOVW	R0, #lo_addr(_freq2+0)
MOVT	R0, #hi_addr(_freq2+0)
LDRB	R2, [R0, #0]
MOVS	R1, #10
MOV	R0, R1
MULS	R0, R2, R0
SXTH	R0, R0
ADDS	R1, R3, R0
SXTH	R1, R1
MOVW	R0, #lo_addr(_freq1+0)
MOVT	R0, #hi_addr(_freq1+0)
LDRB	R0, [R0, #0]
ADDS	R0, R1, R0
SXTH	R0, R0
STR	R0, [SP, #40]
;driverrf4463pro.c,646 :: 		ulFrequency = ( ulFrequency * 10000);
LDR	R2, [SP, #40]
MOVW	R1, #10000
MOVT	R1, #0
MOV	R0, R1
MULS	R0, R2, R0
STR	R0, [SP, #40]
;driverrf4463pro.c,649 :: 		if ( ulFrequency >= 7600000 ) {
LDR	R1, [SP, #40]
MOVW	R0, #63360
MOVT	R0, #115
CMP	R1, R0
IT	CC
BLCC	L_rf_init_freq133
;driverrf4463pro.c,650 :: 		ucOUTDIV = 4;
MOVS	R0, #4
STR	R0, [SP, #0]
;driverrf4463pro.c,651 :: 		ucBAND = 0;
MOVS	R0, #0
STR	R0, [SP, #16]
;driverrf4463pro.c,652 :: 		ucVCO = 0xFF;
MOVS	R0, #255
STR	R0, [SP, #8]
;driverrf4463pro.c,653 :: 		}
IT	AL
BLAL	L_rf_init_freq134
L_rf_init_freq133:
;driverrf4463pro.c,656 :: 		else if ( ulFrequency >= 5460000 ) {
LDR	R1, [SP, #40]
MOVW	R0, #20512
MOVT	R0, #83
CMP	R1, R0
IT	CC
BLCC	L_rf_init_freq135
;driverrf4463pro.c,657 :: 		ucOUTDIV = 6;
MOVS	R0, #6
STR	R0, [SP, #0]
;driverrf4463pro.c,658 :: 		ucBAND   = 1;
MOVS	R0, #1
STR	R0, [SP, #16]
;driverrf4463pro.c,659 :: 		ucVCO    = 0xFE;
MOVS	R0, #254
STR	R0, [SP, #8]
;driverrf4463pro.c,660 :: 		}
IT	AL
BLAL	L_rf_init_freq136
L_rf_init_freq135:
;driverrf4463pro.c,663 :: 		else if ( ulFrequency >= 3850000 ) {
LDR	R1, [SP, #40]
MOVW	R0, #48912
MOVT	R0, #58
CMP	R1, R0
IT	CC
BLCC	L_rf_init_freq137
;driverrf4463pro.c,664 :: 		ucOUTDIV = 8;
MOVS	R0, #8
STR	R0, [SP, #0]
;driverrf4463pro.c,665 :: 		ucBAND   = 2;
MOVS	R0, #2
STR	R0, [SP, #16]
;driverrf4463pro.c,666 :: 		ucVCO    = 0xFE;
MOVS	R0, #254
STR	R0, [SP, #8]
;driverrf4463pro.c,667 :: 		}
IT	AL
BLAL	L_rf_init_freq138
L_rf_init_freq137:
;driverrf4463pro.c,670 :: 		else if ( ulFrequency >= 2730000 ) {
LDR	R1, [SP, #40]
MOVW	R0, #43024
MOVT	R0, #41
CMP	R1, R0
IT	CC
BLCC	L_rf_init_freq139
;driverrf4463pro.c,671 :: 		ucOUTDIV = 12;
MOVS	R0, #12
STR	R0, [SP, #0]
;driverrf4463pro.c,672 :: 		ucBAND   = 3;
MOVS	R0, #3
STR	R0, [SP, #16]
;driverrf4463pro.c,673 :: 		ucVCO    = 0xFD;
MOVS	R0, #253
STR	R0, [SP, #8]
;driverrf4463pro.c,674 :: 		}
IT	AL
BLAL	L_rf_init_freq140
L_rf_init_freq139:
;driverrf4463pro.c,677 :: 		else if ( ulFrequency >= 1940000 ) {
LDR	R1, [SP, #40]
MOVW	R0, #39456
MOVT	R0, #29
CMP	R1, R0
IT	CC
BLCC	L_rf_init_freq141
;driverrf4463pro.c,678 :: 		ucOUTDIV = 16;
MOVS	R0, #16
STR	R0, [SP, #0]
;driverrf4463pro.c,679 :: 		ucBAND   = 4;
MOVS	R0, #4
STR	R0, [SP, #16]
;driverrf4463pro.c,680 :: 		ucVCO    = 0xFC;
MOVS	R0, #252
STR	R0, [SP, #8]
;driverrf4463pro.c,681 :: 		}
IT	AL
BLAL	L_rf_init_freq142
L_rf_init_freq141:
;driverrf4463pro.c,685 :: 		ucOUTDIV = 24;
MOVS	R0, #24
STR	R0, [SP, #0]
;driverrf4463pro.c,686 :: 		ucBAND   = 5;
MOVS	R0, #5
STR	R0, [SP, #16]
;driverrf4463pro.c,687 :: 		ucVCO    = 0xFA;
MOVS	R0, #250
STR	R0, [SP, #8]
;driverrf4463pro.c,688 :: 		}
L_rf_init_freq142:
L_rf_init_freq140:
L_rf_init_freq138:
L_rf_init_freq136:
L_rf_init_freq134:
;driverrf4463pro.c,690 :: 		ucDIV = ucOUTDIV / 2;
LDR	R0, [SP, #0]
UXTB	R0, R0
MOVS	R2, #2
BL	__Div_32x32_U+0
STR	R0, [SP, #4]
;driverrf4463pro.c,692 :: 		ulData = ( ulFrequency * ucDIV ) / 3;          // ucDIV = 88.5 = 88   //// UCdiv = 2
LDR	R2, [SP, #4]
UXTB	R2, R2
LDR	R0, [SP, #40]
MOV	R1, R2
MULS	R1, R0, R1
MOVS	R2, #3
MOV	R0, R1
BL	__Div_32x32_U+0
STR	R0, [SP, #36]
;driverrf4463pro.c,693 :: 		ucINTE = ( ulData / 100000) - 1;               // ulData = 6 000 000  //// ULdATA = 9 000 000
LDR	R0, [SP, #36]
MOVW	R2, #34464
MOVT	R2, #1
BL	__Div_32x32_U+0
SUBS	R0, R0, #1
STR	R0, [SP, #12]
;driverrf4463pro.c,694 :: 		ulFRAC = ( ulData - ( ucINTE + 1 ) * 100000 ) * 16384 / 3125;         // ulFRAC = 15 728 640
LDR	R0, [SP, #12]
UXTB	R0, R0
ADDS	R2, R0, #1
SXTH	R2, R2
MOVW	R0, #34464
MOVT	R0, #1
MOV	R1, R0
MULS	R1, R2, R1
LDR	R0, [SP, #36]
SUBS	R2, R0, R1
MOVW	R0, #16384
MOVT	R0, #0
MOV	R1, R0
MULS	R1, R2, R1
MOVW	R2, #3125
MOVT	R2, #0
MOV	R0, R1
BL	__Div_32x32_U+0
STR	R0, [SP, #32]
;driverrf4463pro.c,695 :: 		ulFRAC = ulFRAC + 0x80000;
LDR	R1, [SP, #32]
MOVW	R0, #0
MOVT	R0, #8
ADDS	R0, R1, R0
STR	R0, [SP, #32]
;driverrf4463pro.c,697 :: 		ucFRAC_0 = ulFRAC;
LDR	R0, [SP, #32]
STR	R0, [SP, #28]
;driverrf4463pro.c,698 :: 		ulFRAC >>= 8;
LDR	R0, [SP, #32]
LSRS	R0, R0, #8
STR	R0, [SP, #32]
;driverrf4463pro.c,699 :: 		ucFRAC_1 = ulFRAC;
LDR	R0, [SP, #32]
STR	R0, [SP, #24]
;driverrf4463pro.c,700 :: 		ulFRAC >>= 8;
LDR	R0, [SP, #32]
LSRS	R0, R0, #8
STR	R0, [SP, #32]
;driverrf4463pro.c,701 :: 		ucFRAC_2 = ulFRAC;
LDR	R0, [SP, #32]
STR	R0, [SP, #20]
;driverrf4463pro.c,705 :: 		app_command_buf[ 0 ] = 0x11;           // SET property    MODEM_CLKGEN_BAND
MOVS	R0, #44
ADD	R0, SP, R0
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,706 :: 		app_command_buf[ 1 ] = 0x20;           // Group  // 0x2051
MOVS	R0, #44
ADD	R0, SP, R0
ADDS	R1, R0, #1
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,707 :: 		app_command_buf[ 2 ] = 0x01;           // Num Arguments // Total 1 Parameters
MOVS	R0, #44
ADD	R0, SP, R0
ADDS	R1, R0, #2
MOVS	R0, #1
STRB	R0, [R1, #0]
;driverrf4463pro.c,708 :: 		app_command_buf[ 3 ] = 0x51;           // Number  // 0x2051
MOVS	R0, #44
ADD	R0, SP, R0
ADDS	R1, R0, #3
MOVS	R0, #81
STRB	R0, [R1, #0]
;driverrf4463pro.c,709 :: 		app_command_buf[ 4 ] = 0x08 | ucBAND;  // Argumento  //  high performance mode , clk outpu = osc /4
MOVS	R0, #44
ADD	R0, SP, R0
ADDS	R2, R0, #4
LDR	R1, [SP, #16]
UXTB	R1, R1
MOVS	R0, #8
ORRS	R0, R1
STRB	R0, [R2, #0]
;driverrf4463pro.c,710 :: 		spi_write( 5, app_command_buf );
MOVS	R0, #44
ADD	R0, SP, R0
PUSH	(R0)
MOVS	R0, #5
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,712 :: 		app_command_buf[ 0 ]  = 0x11;
MOVS	R0, #44
ADD	R0, SP, R0
ADDS	R1, R0, #0
MOVS	R0, #17
STRB	R0, [R1, #0]
;driverrf4463pro.c,713 :: 		app_command_buf[ 1 ]  = 0x40;    // 0x4000         FREQ_CONTROL_INTE
MOVS	R0, #44
ADD	R0, SP, R0
ADDS	R1, R0, #1
MOVS	R0, #64
STRB	R0, [R1, #0]
;driverrf4463pro.c,714 :: 		app_command_buf[ 2 ]  = 0x08;    // Total 8 Parameters
MOVS	R0, #44
ADD	R0, SP, R0
ADDS	R1, R0, #2
MOVS	R0, #8
STRB	R0, [R1, #0]
;driverrf4463pro.c,715 :: 		app_command_buf[ 3 ]  = 0x00;   // 0x4000
MOVS	R0, #44
ADD	R0, SP, R0
ADDS	R1, R0, #3
MOVS	R0, #0
STRB	R0, [R1, #0]
;driverrf4463pro.c,716 :: 		app_command_buf[ 4 ]  = ucINTE;   //  default value
MOVS	R0, #44
ADD	R0, SP, R0
ADDS	R1, R0, #4
LDR	R0, [SP, #12]
UXTB	R0, R0
STRB	R0, [R1, #0]
;driverrf4463pro.c,717 :: 		app_command_buf[ 5 ]  = ucFRAC_2;   //  defaul value
MOVS	R0, #44
ADD	R0, SP, R0
ADDS	R1, R0, #5
LDR	R0, [SP, #20]
UXTB	R0, R0
STRB	R0, [R1, #0]
;driverrf4463pro.c,718 :: 		app_command_buf[ 6 ]  = ucFRAC_1;   //  default value
MOVS	R0, #44
ADD	R0, SP, R0
ADDS	R1, R0, #6
LDR	R0, [SP, #24]
UXTB	R0, R0
STRB	R0, [R1, #0]
;driverrf4463pro.c,719 :: 		app_command_buf[ 7 ]  = ucFRAC_0;   // frac ,from WDS
MOVS	R0, #44
ADD	R0, SP, R0
ADDS	R1, R0, #7
LDR	R0, [SP, #28]
UXTB	R0, R0
STRB	R0, [R1, #0]
;driverrf4463pro.c,720 :: 		app_command_buf[ 8 ]  = step_250K_step1;   // channel step1  from wds  // al parecer aqu? esta el ancho del canal
MOVS	R0, #44
ADD	R0, SP, R0
MOV	R1, R0
ADDS	R1, #8
MOVS	R0, #34
STRB	R0, [R1, #0]
;driverrf4463pro.c,721 :: 		app_command_buf[ 9 ]  = step_250K_step0;   // channel step0  from wds
MOVS	R0, #44
ADD	R0, SP, R0
MOV	R1, R0
ADDS	R1, #9
MOVS	R0, #34
STRB	R0, [R1, #0]
;driverrf4463pro.c,722 :: 		app_command_buf[ 10 ] = 0x20;  //  from wds Without this Values
MOVS	R0, #44
ADD	R0, SP, R0
MOV	R1, R0
ADDS	R1, #10
MOVS	R0, #32
STRB	R0, [R1, #0]
;driverrf4463pro.c,723 :: 		app_command_buf[ 11 ] = ucVCO;    // from wds Without this Values
MOVS	R0, #44
ADD	R0, SP, R0
MOV	R1, R0
ADDS	R1, #11
LDR	R0, [SP, #8]
UXTB	R0, R0
STRB	R0, [R1, #0]
;driverrf4463pro.c,737 :: 		spi_write( 12, app_command_buf );
MOVS	R0, #44
ADD	R0, SP, R0
PUSH	(R0)
MOVS	R0, #12
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,738 :: 		}
L_end_rf_init_freq:
ADD	SP, SP, #64
POP	(R15)
; end of _rf_init_freq
_ucRf4463SPIByte:
;driverrf4463pro.c,758 :: 		unsigned char ucRf4463SPIByte( unsigned char ucData ) {
PUSH	(R14)
;driverrf4463pro.c,797 :: 		ucSPI1ByteReceived = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucSPI1ByteReceived+0)
MOVT	R0, #hi_addr(_ucSPI1ByteReceived+0)
STRB	R1, [R0, #0]
;driverrf4463pro.c,799 :: 		vRF4463SpiBufferTX ( &ucData, 1 );
MOVS	R0, #1
PUSH	(R0)
MOVS	R0, #8
ADD	R0, SP, R0
PUSH	(R0)
BL	_vRF4463SpiBufferTX+0
ADD	SP, SP, #8
;driverrf4463pro.c,801 :: 		while ( SPI1_SRbits.RXNE );
L_ucRf4463SPIByte143:
MOVW	R0, #lo_addr(SPI1_SRbits+0)
MOVT	R0, #hi_addr(SPI1_SRbits+0)
_LX	[R0, ByteOffset(SPI1_SRbits+0)]
MOVS	R0, #1
ANDS	R0, R1
LSRS	R0, R0, #0
CMP	R0, #0
IT	EQ
BLEQ	L_ucRf4463SPIByte144
IT	AL
BLAL	L_ucRf4463SPIByte143
L_ucRf4463SPIByte144:
;driverrf4463pro.c,807 :: 		return ( ucSPI1ByteReceived );
MOVW	R0, #lo_addr(_ucSPI1ByteReceived+0)
MOVT	R0, #hi_addr(_ucSPI1ByteReceived+0)
LDRB	R0, [R0, #0]
;driverrf4463pro.c,809 :: 		}
L_end_ucRf4463SPIByte:
POP	(R15)
; end of _ucRf4463SPIByte
_spi_write:
;driverrf4463pro.c,814 :: 		void spi_write( unsigned char tx_length, unsigned char *p ) {
PUSH	(R14)
SUB	SP, SP, #8
;driverrf4463pro.c,817 :: 		i = 0;
MOVS	R0, #0
STR	R0, [SP, #0]
;driverrf4463pro.c,818 :: 		while ( i != 0xFF ) {
L_spi_write145:
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, #255
IT	EQ
BLEQ	L_spi_write146
;driverrf4463pro.c,819 :: 		i = check_cts();
BL	_check_cts+0
STR	R0, [SP, #0]
;driverrf4463pro.c,820 :: 		}
IT	AL
BLAL	L_spi_write145
L_spi_write146:
;driverrf4463pro.c,822 :: 		nSEL = 0;                              // habilita escritura
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,824 :: 		for ( i = 0; i < tx_length; i++ ) {
MOVS	R0, #0
STR	R0, [SP, #0]
L_spi_write147:
LDR	R1, [SP, #12]
UXTB	R1, R1
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, R1
IT	CS
BLCS	L_spi_write148
;driverrf4463pro.c,825 :: 		j = *( p + i );
LDR	R1, [SP, #0]
UXTB	R1, R1
LDR	R0, [SP, #16]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STR	R0, [SP, #4]
;driverrf4463pro.c,826 :: 		ucRf4463SPIByte( j );
LDR	R0, [SP, #4]
UXTB	R0, R0
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,824 :: 		for ( i = 0; i < tx_length; i++ ) {
LDR	R0, [SP, #0]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #0]
;driverrf4463pro.c,827 :: 		}
IT	AL
BLAL	L_spi_write147
L_spi_write148:
;driverrf4463pro.c,829 :: 		nSEL = 1;                              // desabilita escritura
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,830 :: 		}
L_end_spi_write:
ADD	SP, SP, #8
POP	(R15)
; end of _spi_write
_check_cts:
;driverrf4463pro.c,835 :: 		unsigned char check_cts( void ) {           // This Command follows the Command and reads the response
PUSH	(R14)
SUB	SP, SP, #4
;driverrf4463pro.c,838 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,839 :: 		nSEL = 0;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,840 :: 		ucRf4463SPIByte( 0x44 );
MOVS	R0, #68
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,841 :: 		i = ucRf4463SPIByte( 0 );
MOVS	R0, #0
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
STR	R0, [SP, #0]
;driverrf4463pro.c,842 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,843 :: 		return ( i );
LDR	R0, [SP, #0]
UXTB	R0, R0
;driverrf4463pro.c,844 :: 		}
L_end_check_cts:
ADD	SP, SP, #4
POP	(R15)
; end of _check_cts
_spi_read:
;driverrf4463pro.c,849 :: 		void spi_read( unsigned char data_length, unsigned char api_command ) {
PUSH	(R14)
SUB	SP, SP, #12
;driverrf4463pro.c,853 :: 		p[ 0 ] = api_command;
MOVS	R0, #4
ADD	R0, SP, R0
ADDS	R1, R0, #0
LDR	R0, [SP, #20]
UXTB	R0, R0
STRB	R0, [R1, #0]
;driverrf4463pro.c,854 :: 		i = 0;
MOVS	R0, #0
STR	R0, [SP, #0]
;driverrf4463pro.c,855 :: 		while ( i != 0xFF ) {
L_spi_read150:
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, #255
IT	EQ
BLEQ	L_spi_read151
;driverrf4463pro.c,856 :: 		i = check_cts();                // Check if you can send Command
BL	_check_cts+0
STR	R0, [SP, #0]
;driverrf4463pro.c,857 :: 		}
IT	AL
BLAL	L_spi_read150
L_spi_read151:
;driverrf4463pro.c,859 :: 		spi_write( 1, p );    // Send Command
MOVS	R0, #4
ADD	R0, SP, R0
PUSH	(R0)
MOVS	R0, #1
PUSH	(R0)
BL	_spi_write+0
ADD	SP, SP, #8
;driverrf4463pro.c,861 :: 		i = 0;
MOVS	R0, #0
STR	R0, [SP, #0]
;driverrf4463pro.c,862 :: 		while ( i != 0xFF ) {
L_spi_read152:
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, #255
IT	EQ
BLEQ	L_spi_read153
;driverrf4463pro.c,863 :: 		i = check_cts();        //Check whether the data can be read
BL	_check_cts+0
STR	R0, [SP, #0]
;driverrf4463pro.c,864 :: 		}
IT	AL
BLAL	L_spi_read152
L_spi_read153:
;driverrf4463pro.c,866 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,867 :: 		nSEL = 0;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,868 :: 		ucRf4463SPIByte( 0x44 );
MOVS	R0, #68
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,869 :: 		for ( i = 0; i < data_length; i++ ) {        // Read data
MOVS	R0, #0
STR	R0, [SP, #0]
L_spi_read154:
LDR	R1, [SP, #16]
UXTB	R1, R1
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, R1
IT	CS
BLCS	L_spi_read155
;driverrf4463pro.c,870 :: 		spi_read_buf[ i ] = ucRf4463SPIByte( 0x00 );             // 0x00
LDR	R1, [SP, #0]
UXTB	R1, R1
MOVW	R0, #lo_addr(_spi_read_buf+0)
MOVT	R0, #hi_addr(_spi_read_buf+0)
ADDS	R0, R0, R1
STR	R0, [SP, #8]
MOVS	R0, #0
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
LDR	R1, [SP, #8]
STRB	R0, [R1, #0]
;driverrf4463pro.c,869 :: 		for ( i = 0; i < data_length; i++ ) {        // Read data
LDR	R0, [SP, #0]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #0]
;driverrf4463pro.c,871 :: 		}
IT	AL
BLAL	L_spi_read154
L_spi_read155:
;driverrf4463pro.c,872 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,873 :: 		}
L_end_spi_read:
ADD	SP, SP, #12
POP	(R15)
; end of _spi_read
_spi_fast_read:
;driverrf4463pro.c,878 :: 		void spi_fast_read( unsigned char api_command ) {
PUSH	(R14)
SUB	SP, SP, #12
;driverrf4463pro.c,881 :: 		p[0] = api_command;
MOVS	R0, #4
ADD	R0, SP, R0
ADDS	R1, R0, #0
LDR	R0, [SP, #16]
UXTB	R0, R0
STRB	R0, [R1, #0]
;driverrf4463pro.c,882 :: 		i = 0;
MOVS	R0, #0
STR	R0, [SP, #0]
;driverrf4463pro.c,883 :: 		while ( i != 0xFF ) {
L_spi_fast_read157:
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, #255
IT	EQ
BLEQ	L_spi_fast_read158
;driverrf4463pro.c,884 :: 		i = check_cts();                // Check if you can send Command
BL	_check_cts+0
STR	R0, [SP, #0]
;driverrf4463pro.c,885 :: 		}
IT	AL
BLAL	L_spi_fast_read157
L_spi_fast_read158:
;driverrf4463pro.c,887 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,888 :: 		nSEL = 0;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,889 :: 		ucRf4463SPIByte( api_command );    // Send Command
LDR	R0, [SP, #16]
UXTB	R0, R0
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,890 :: 		for ( i = 0; i < 4; i++ ) {
MOVS	R0, #0
STR	R0, [SP, #0]
L_spi_fast_read159:
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, #4
IT	CS
BLCS	L_spi_fast_read160
;driverrf4463pro.c,891 :: 		spi_read_buf[ i ] = ucRf4463SPIByte( 0xFF );   // Read out all the 4 registers Value of
LDR	R1, [SP, #0]
UXTB	R1, R1
MOVW	R0, #lo_addr(_spi_read_buf+0)
MOVT	R0, #hi_addr(_spi_read_buf+0)
ADDS	R0, R0, R1
STR	R0, [SP, #8]
MOVS	R0, #255
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
LDR	R1, [SP, #8]
STRB	R0, [R1, #0]
;driverrf4463pro.c,890 :: 		for ( i = 0; i < 4; i++ ) {
LDR	R0, [SP, #0]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #0]
;driverrf4463pro.c,892 :: 		}
IT	AL
BLAL	L_spi_fast_read159
L_spi_fast_read160:
;driverrf4463pro.c,893 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,894 :: 		}
L_end_spi_fast_read:
ADD	SP, SP, #12
POP	(R15)
; end of _spi_fast_read
_spi_write_fifo:
;driverrf4463pro.c,899 :: 		void spi_write_fifo( void ) {
PUSH	(R14)
SUB	SP, SP, #4
;driverrf4463pro.c,902 :: 		i = 0;
MOVS	R0, #0
STR	R0, [SP, #0]
;driverrf4463pro.c,903 :: 		while ( i != 0xFF ) {
L_spi_write_fifo162:
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, #255
IT	EQ
BLEQ	L_spi_write_fifo163
;driverrf4463pro.c,904 :: 		i = check_cts();                // Check if you can send Command
BL	_check_cts+0
STR	R0, [SP, #0]
;driverrf4463pro.c,905 :: 		}
IT	AL
BLAL	L_spi_write_fifo162
L_spi_write_fifo163:
;driverrf4463pro.c,907 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,908 :: 		nSEL = 0;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,909 :: 		ucRf4463SPIByte( WRITE_TX_FIFO );
MOVS	R0, #102
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,911 :: 		if ( mode == tx_test_mode) {
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BLNE	L_spi_write_fifo164
;driverrf4463pro.c,912 :: 		for ( i = 0; i < payload_length; i++ ) {
MOVS	R0, #0
STR	R0, [SP, #0]
L_spi_write_fifo165:
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, #14
IT	CS
BLCS	L_spi_write_fifo166
;driverrf4463pro.c,913 :: 		ucRf4463SPIByte( tx_test_aa_data[ i ] );   // Send 10 test data
LDR	R1, [SP, #0]
UXTB	R1, R1
MOVW	R0, #lo_addr(_tx_test_aa_data+0)
MOVT	R0, #hi_addr(_tx_test_aa_data+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,912 :: 		for ( i = 0; i < payload_length; i++ ) {
LDR	R0, [SP, #0]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #0]
;driverrf4463pro.c,914 :: 		}
IT	AL
BLAL	L_spi_write_fifo165
L_spi_write_fifo166:
;driverrf4463pro.c,915 :: 		}
IT	AL
BLAL	L_spi_write_fifo168
L_spi_write_fifo164:
;driverrf4463pro.c,917 :: 		for ( i = 0; i < payload_length; i++ ) {
MOVS	R0, #0
STR	R0, [SP, #0]
L_spi_write_fifo169:
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, #14
IT	CS
BLCS	L_spi_write_fifo170
;driverrf4463pro.c,918 :: 		ucRf4463SPIByte( tx_ph_data[ i ] );
LDR	R1, [SP, #0]
UXTB	R1, R1
MOVW	R0, #lo_addr(_tx_ph_data+0)
MOVT	R0, #hi_addr(_tx_ph_data+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,917 :: 		for ( i = 0; i < payload_length; i++ ) {
LDR	R0, [SP, #0]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #0]
;driverrf4463pro.c,919 :: 		}
IT	AL
BLAL	L_spi_write_fifo169
L_spi_write_fifo170:
;driverrf4463pro.c,920 :: 		}
L_spi_write_fifo168:
;driverrf4463pro.c,921 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,922 :: 		}
L_end_spi_write_fifo:
ADD	SP, SP, #4
POP	(R15)
; end of _spi_write_fifo
_spi_read_fifo:
;driverrf4463pro.c,927 :: 		void spi_read_fifo( void ) {
PUSH	(R14)
SUB	SP, SP, #8
;driverrf4463pro.c,930 :: 		i = 0;
MOVS	R0, #0
STR	R0, [SP, #0]
;driverrf4463pro.c,931 :: 		while ( i != 0xFF ) {
L_spi_read_fifo172:
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, #255
IT	EQ
BLEQ	L_spi_read_fifo173
;driverrf4463pro.c,932 :: 		i = check_cts();                   // Check if you can send Command
BL	_check_cts+0
STR	R0, [SP, #0]
;driverrf4463pro.c,933 :: 		}
IT	AL
BLAL	L_spi_read_fifo172
L_spi_read_fifo173:
;driverrf4463pro.c,935 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,936 :: 		nSEL = 0;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,937 :: 		ucRf4463SPIByte( READ_RX_FIFO );
MOVS	R0, #119
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,938 :: 		for ( i = 0; i < payload_length; i++ ) {
MOVS	R0, #0
STR	R0, [SP, #0]
L_spi_read_fifo174:
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, #14
IT	CS
BLCS	L_spi_read_fifo175
;driverrf4463pro.c,939 :: 		rx_buf[ i ] = ucRf4463SPIByte( 0xFF );      // Receive 10 test data
LDR	R1, [SP, #0]
UXTB	R1, R1
MOVW	R0, #lo_addr(_rx_buf+0)
MOVT	R0, #hi_addr(_rx_buf+0)
ADDS	R0, R0, R1
STR	R0, [SP, #4]
MOVS	R0, #255
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
LDR	R1, [SP, #4]
STRB	R0, [R1, #0]
;driverrf4463pro.c,938 :: 		for ( i = 0; i < payload_length; i++ ) {
LDR	R0, [SP, #0]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #0]
;driverrf4463pro.c,940 :: 		}
IT	AL
BLAL	L_spi_read_fifo174
L_spi_read_fifo175:
;driverrf4463pro.c,941 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,942 :: 		}
L_end_spi_read_fifo:
ADD	SP, SP, #8
POP	(R15)
; end of _spi_read_fifo
_VRF4463SDNReset:
;driverrf4463pro.c,947 :: 		void VRF4463SDNReset( void ) {
PUSH	(R14)
SUB	SP, SP, #4
;driverrf4463pro.c,950 :: 		SDN = 1;
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_LX	[R2, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #4
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,951 :: 		Delay_ms( 6 );        // RF Module reset  DELAY
LDR	R7, [PC, #23999]
NOP
L_VRF4463SDNReset177:
SUBS	R7, R7, #1
BNE	L_VRF4463SDNReset177
B	#4
	#23999
NOP
;driverrf4463pro.c,952 :: 		SDN = 0;
MOVW	R2, #lo_addr(GPIOB_ODRbits+0)
MOVT	R2, #hi_addr(GPIOB_ODRbits+0)
_LX	[R2, ByteOffset(GPIOB_ODRbits+0)]
MOVS	R1, #4
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOB_ODRbits+0)]
;driverrf4463pro.c,953 :: 		Delay_ms( 10 );       // Delay 10ms for RF module to enter working state
LDR	R7, [PC, #39999]
NOP
L_VRF4463SDNReset179:
SUBS	R7, R7, #1
BNE	L_VRF4463SDNReset179
B	#4
	#39999
NOP
;driverrf4463pro.c,955 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,956 :: 		nSEL = 0;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,957 :: 		for ( i = 0; i < 7; i++ ) {
MOVS	R0, #0
STR	R0, [SP, #0]
L_VRF4463SDNReset181:
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, #7
IT	CS
BLCS	L_VRF4463SDNReset182
;driverrf4463pro.c,958 :: 		ucRf4463SPIByte( RF_POWER_UP_data[ i ] );   // send power up Command
LDR	R1, [SP, #0]
UXTB	R1, R1
MOVW	R0, #lo_addr(_RF_POWER_UP_data+0)
MOVT	R0, #hi_addr(_RF_POWER_UP_data+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
PUSH	(R0)
BL	_ucRf4463SPIByte+0
ADD	SP, SP, #4
;driverrf4463pro.c,957 :: 		for ( i = 0; i < 7; i++ ) {
LDR	R0, [SP, #0]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #0]
;driverrf4463pro.c,959 :: 		}
IT	AL
BLAL	L_VRF4463SDNReset181
L_VRF4463SDNReset182:
;driverrf4463pro.c,960 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;driverrf4463pro.c,962 :: 		Delay_ms( 20 );       // Delay 20ms RF module enters working state, but CTS still needs to be judged later, this delay can be removed
LDR	R7, [PC, #79999]
NOP
L_VRF4463SDNReset184:
SUBS	R7, R7, #1
BNE	L_VRF4463SDNReset184
B	#4
	#79999
NOP
;driverrf4463pro.c,963 :: 		}
L_end_VRF4463SDNReset:
ADD	SP, SP, #4
POP	(R15)
; end of _VRF4463SDNReset
_ucASCIIToByte:
;utils.c,41 :: 		unsigned char ucASCIIToByte( unsigned char * pcASCIIBuffer ){
PUSH	(R14)
;utils.c,42 :: 		ucMSBNibble = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,43 :: 		ucLSBNibble = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,45 :: 		ucMSBNibble = ( pcASCIIBuffer[ 0 ] - 0x30 );
LDR	R0, [SP, #4]
ADDS	R0, #0
LDRB	R0, [R0, #0]
MOV	R1, R0
SUBS	R1, #48
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,46 :: 		if( ucMSBNibble > 9 ){
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
LDRB	R0, [R0, #0]
CMP	R0, #9
IT	LS
BLLS	L_ucASCIIToByte186
;utils.c,47 :: 		ucMSBNibble -= 7;
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
LDRB	R0, [R0, #0]
SUBS	R1, R0, #7
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,48 :: 		}
L_ucASCIIToByte186:
;utils.c,50 :: 		ucLSBNibble = ( pcASCIIBuffer[ 1 ] - 0x30 );
LDR	R0, [SP, #4]
ADDS	R0, #1
LDRB	R0, [R0, #0]
MOV	R1, R0
SUBS	R1, #48
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,51 :: 		if( ucLSBNibble > 9 ){
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
LDRB	R0, [R0, #0]
CMP	R0, #9
IT	LS
BLLS	L_ucASCIIToByte187
;utils.c,52 :: 		ucLSBNibble -= 7;
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
LDRB	R0, [R0, #0]
SUBS	R1, R0, #7
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,53 :: 		}
L_ucASCIIToByte187:
;utils.c,55 :: 		return ( ucMSBNibble << 4 | ucLSBNibble );
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #4
UXTH	R1, R1
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
LDRB	R0, [R0, #0]
ORRS	R0, R1
UXTB	R0, R0
;utils.c,56 :: 		}
L_end_ucASCIIToByte:
POP	(R15)
; end of _ucASCIIToByte
_vASCIIToHex:
;utils.c,61 :: 		void vASCIIToHex( unsigned char *pcHexConvertBuffer, unsigned char *pcASCIIConvertBuffer, unsigned char ucConversionLength ){
PUSH	(R14)
SUB	SP, SP, #4
;utils.c,62 :: 		unsigned char ucASCIICounter = 0;
MOVS	R0, #0
STR	R0, [SP, #0]
;utils.c,64 :: 		for( ucASCIICounter = 0; ucASCIICounter < ucConversionLength; ucASCIICounter++ ){
MOVS	R0, #0
STR	R0, [SP, #0]
L_vASCIIToHex188:
LDR	R1, [SP, #16]
UXTB	R1, R1
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, R1
IT	CS
BLCS	L_vASCIIToHex189
;utils.c,65 :: 		ucMSBNibble = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,66 :: 		ucLSBNibble = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,68 :: 		ucMSBNibble = ( pcASCIIConvertBuffer[ ucASCIICounter * 2 ] - 0x30 );
LDR	R2, [SP, #0]
UXTB	R2, R2
MOVS	R0, #2
MOV	R1, R0
MULS	R1, R2, R1
SXTH	R1, R1
LDR	R0, [SP, #12]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
MOV	R1, R0
SUBS	R1, #48
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,69 :: 		if( ucMSBNibble > 9 ){
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
LDRB	R0, [R0, #0]
CMP	R0, #9
IT	LS
BLLS	L_vASCIIToHex191
;utils.c,70 :: 		ucMSBNibble -= 7;
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
LDRB	R0, [R0, #0]
SUBS	R1, R0, #7
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,71 :: 		}
L_vASCIIToHex191:
;utils.c,73 :: 		ucLSBNibble = ( pcASCIIConvertBuffer[ ( ucASCIICounter * 2 ) + 1 ] - 0x30 );
LDR	R2, [SP, #0]
UXTB	R2, R2
MOVS	R1, #2
MOV	R0, R1
MULS	R0, R2, R0
SXTH	R0, R0
ADDS	R1, R0, #1
SXTH	R1, R1
LDR	R0, [SP, #12]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
MOV	R1, R0
SUBS	R1, #48
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,74 :: 		if( ucLSBNibble > 9 ){
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
LDRB	R0, [R0, #0]
CMP	R0, #9
IT	LS
BLLS	L_vASCIIToHex192
;utils.c,75 :: 		ucLSBNibble -= 7;
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
LDRB	R0, [R0, #0]
SUBS	R1, R0, #7
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
STRB	R1, [R0, #0]
;utils.c,76 :: 		}
L_vASCIIToHex192:
;utils.c,78 :: 		pcHexConvertBuffer[ ucASCIICounter ] = ( ( ucMSBNibble << 4 ) | ucLSBNibble );
LDR	R1, [SP, #0]
UXTB	R1, R1
LDR	R0, [SP, #8]
ADDS	R2, R0, R1
MOVW	R0, #lo_addr(_ucMSBNibble+0)
MOVT	R0, #hi_addr(_ucMSBNibble+0)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #4
UXTH	R1, R1
MOVW	R0, #lo_addr(_ucLSBNibble+0)
MOVT	R0, #hi_addr(_ucLSBNibble+0)
LDRB	R0, [R0, #0]
ORRS	R0, R1
STRB	R0, [R2, #0]
;utils.c,64 :: 		for( ucASCIICounter = 0; ucASCIICounter < ucConversionLength; ucASCIICounter++ ){
LDR	R0, [SP, #0]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #0]
;utils.c,79 :: 		}
IT	AL
BLAL	L_vASCIIToHex188
L_vASCIIToHex189:
;utils.c,80 :: 		}
L_end_vASCIIToHex:
ADD	SP, SP, #4
POP	(R15)
; end of _vASCIIToHex
_vHexToASCII:
;utils.c,85 :: 		void vHexToASCII( unsigned char *pcASCIIConvertBuffer, unsigned char *pcHexConvertBuffer, unsigned char ucConversionLength ){
PUSH	(R14)
SUB	SP, SP, #4
;utils.c,86 :: 		unsigned char ucHexConvCounter = 0;
MOVS	R0, #0
STR	R0, [SP, #0]
;utils.c,88 :: 		for( ucHexConvCounter = 0; ucHexConvCounter < ucConversionLength; ucHexConvCounter++ ){
MOVS	R0, #0
STR	R0, [SP, #0]
L_vHexToASCII193:
LDR	R1, [SP, #16]
UXTB	R1, R1
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, R1
IT	CS
BLCS	L_vHexToASCII194
;utils.c,89 :: 		pcASCIIConvertBuffer[ ucHexConvCounter * 2 ]            = pcHexChar[ pcHexConvertBuffer[ ucHexConvCounter ] >> 4 ];
LDR	R2, [SP, #0]
UXTB	R2, R2
MOVS	R0, #2
MOV	R1, R0
MULS	R1, R2, R1
SXTH	R1, R1
LDR	R0, [SP, #8]
ADDS	R2, R0, R1
LDR	R1, [SP, #0]
UXTB	R1, R1
LDR	R0, [SP, #12]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
LSRS	R1, R0, #4
UXTB	R1, R1
MOVW	R0, #lo_addr(_pcHexChar+0)
MOVT	R0, #hi_addr(_pcHexChar+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;utils.c,90 :: 		pcASCIIConvertBuffer[ ( ucHexConvCounter * 2 ) + 1 ]    = pcHexChar[ ( pcHexConvertBuffer[ ucHexConvCounter ] & 0x0F ) ];
LDR	R2, [SP, #0]
UXTB	R2, R2
MOVS	R1, #2
MOV	R0, R1
MULS	R0, R2, R0
SXTH	R0, R0
ADDS	R1, R0, #1
SXTH	R1, R1
LDR	R0, [SP, #8]
ADDS	R2, R0, R1
LDR	R1, [SP, #0]
UXTB	R1, R1
LDR	R0, [SP, #12]
ADDS	R0, R0, R1
LDRB	R1, [R0, #0]
MOVS	R0, #15
ANDS	R1, R0
UXTB	R1, R1
MOVW	R0, #lo_addr(_pcHexChar+0)
MOVT	R0, #hi_addr(_pcHexChar+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;utils.c,88 :: 		for( ucHexConvCounter = 0; ucHexConvCounter < ucConversionLength; ucHexConvCounter++ ){
LDR	R0, [SP, #0]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #0]
;utils.c,91 :: 		}
IT	AL
BLAL	L_vHexToASCII193
L_vHexToASCII194:
;utils.c,92 :: 		}
L_end_vHexToASCII:
ADD	SP, SP, #4
POP	(R15)
; end of _vHexToASCII
_vBufferSetToZero:
;utils.c,97 :: 		void vBufferSetToZero( unsigned char * pcBufferToClean, unsigned int uslength ){
PUSH	(R14)
SUB	SP, SP, #4
;utils.c,98 :: 		unsigned int usPosition = 0;
MOV	R6, SP
MOVS	R5, #2
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICSvBufferSetToZero_usPosition_L0+0)
MOVT	R7, #hi_addr(?ICSvBufferSetToZero_usPosition_L0+0)
BL	___CC2DW+0
;utils.c,100 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
MOVS	R0, #0
STR	R0, [SP, #0]
L_vBufferSetToZero196:
LDR	R1, [SP, #12]
UXTH	R1, R1
LDR	R0, [SP, #0]
UXTH	R0, R0
CMP	R0, R1
IT	CS
BLCS	L_vBufferSetToZero197
;utils.c,101 :: 		pcBufferToClean[ usPosition ] = 0x00;
LDR	R1, [SP, #0]
UXTH	R1, R1
LDR	R0, [SP, #8]
ADDS	R1, R0, R1
MOVS	R0, #0
STRB	R0, [R1, #0]
;utils.c,100 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
LDR	R0, [SP, #0]
UXTH	R0, R0
ADDS	R0, #1
STR	R0, [SP, #0]
;utils.c,102 :: 		}
IT	AL
BLAL	L_vBufferSetToZero196
L_vBufferSetToZero197:
;utils.c,103 :: 		}
L_end_vBufferSetToZero:
ADD	SP, SP, #4
POP	(R15)
; end of _vBufferSetToZero
_vBufferSetTo255:
;utils.c,108 :: 		void vBufferSetTo255( unsigned char * pcBufferToClean, unsigned int uslength ){
PUSH	(R14)
SUB	SP, SP, #4
;utils.c,109 :: 		unsigned int usPosition = 0;
MOV	R6, SP
MOVS	R5, #2
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICSvBufferSetTo255_usPosition_L0+0)
MOVT	R7, #hi_addr(?ICSvBufferSetTo255_usPosition_L0+0)
BL	___CC2DW+0
;utils.c,111 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
MOVS	R0, #0
STR	R0, [SP, #0]
L_vBufferSetTo255199:
LDR	R1, [SP, #12]
UXTH	R1, R1
LDR	R0, [SP, #0]
UXTH	R0, R0
CMP	R0, R1
IT	CS
BLCS	L_vBufferSetTo255200
;utils.c,112 :: 		pcBufferToClean[ usPosition ] = 0xFF;
LDR	R1, [SP, #0]
UXTH	R1, R1
LDR	R0, [SP, #8]
ADDS	R1, R0, R1
MOVS	R0, #255
STRB	R0, [R1, #0]
;utils.c,111 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
LDR	R0, [SP, #0]
UXTH	R0, R0
ADDS	R0, #1
STR	R0, [SP, #0]
;utils.c,113 :: 		}
IT	AL
BLAL	L_vBufferSetTo255199
L_vBufferSetTo255200:
;utils.c,114 :: 		}
L_end_vBufferSetTo255:
ADD	SP, SP, #4
POP	(R15)
; end of _vBufferSetTo255
_vBufferSetToValue:
;utils.c,119 :: 		void vBufferSetToValue( unsigned char * pcBufferToClean, unsigned char ucValue, unsigned int uslength ){
PUSH	(R14)
SUB	SP, SP, #4
;utils.c,120 :: 		unsigned int usPosition = 0;
MOV	R6, SP
MOVS	R5, #2
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICSvBufferSetToValue_usPosition_L0+0)
MOVT	R7, #hi_addr(?ICSvBufferSetToValue_usPosition_L0+0)
BL	___CC2DW+0
;utils.c,122 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
MOVS	R0, #0
STR	R0, [SP, #0]
L_vBufferSetToValue202:
LDR	R1, [SP, #16]
UXTH	R1, R1
LDR	R0, [SP, #0]
UXTH	R0, R0
CMP	R0, R1
IT	CS
BLCS	L_vBufferSetToValue203
;utils.c,123 :: 		pcBufferToClean[ usPosition ] = ucValue;
LDR	R1, [SP, #0]
UXTH	R1, R1
LDR	R0, [SP, #8]
ADDS	R1, R0, R1
LDR	R0, [SP, #12]
UXTB	R0, R0
STRB	R0, [R1, #0]
;utils.c,122 :: 		for( usPosition = 0; usPosition < uslength; usPosition++ ){
LDR	R0, [SP, #0]
UXTH	R0, R0
ADDS	R0, #1
STR	R0, [SP, #0]
;utils.c,124 :: 		}
IT	AL
BLAL	L_vBufferSetToValue202
L_vBufferSetToValue203:
;utils.c,125 :: 		}
L_end_vBufferSetToValue:
ADD	SP, SP, #4
POP	(R15)
; end of _vBufferSetToValue
_vSerializeUUID:
;utils.c,130 :: 		void vSerializeUUID( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer ){
PUSH	(R14)
SUB	SP, SP, #4
;utils.c,131 :: 		unsigned char ucCounter = 0;
MOVS	R0, #0
STR	R0, [SP, #0]
;utils.c,133 :: 		for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
MOVS	R0, #0
STR	R0, [SP, #0]
L_vSerializeUUID205:
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, #12
IT	CS
BLCS	L_vSerializeUUID206
;utils.c,134 :: 		pcTextConvertBuffer[ ucCounter * 2 ]         = pcHexChar[ pcHexConvertBuffer[ ucCounter ] >> 4 ];
LDR	R2, [SP, #0]
UXTB	R2, R2
MOVS	R0, #2
MOV	R1, R0
MULS	R1, R2, R1
SXTH	R1, R1
LDR	R0, [SP, #8]
ADDS	R2, R0, R1
LDR	R1, [SP, #0]
UXTB	R1, R1
LDR	R0, [SP, #12]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
LSRS	R1, R0, #4
UXTB	R1, R1
MOVW	R0, #lo_addr(_pcHexChar+0)
MOVT	R0, #hi_addr(_pcHexChar+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;utils.c,135 :: 		pcTextConvertBuffer[ ( ucCounter * 2 ) + 1 ] = pcHexChar[ pcHexConvertBuffer[ ucCounter ] & 0x0F ];
LDR	R2, [SP, #0]
UXTB	R2, R2
MOVS	R1, #2
MOV	R0, R1
MULS	R0, R2, R0
SXTH	R0, R0
ADDS	R1, R0, #1
SXTH	R1, R1
LDR	R0, [SP, #8]
ADDS	R2, R0, R1
LDR	R1, [SP, #0]
UXTB	R1, R1
LDR	R0, [SP, #12]
ADDS	R0, R0, R1
LDRB	R1, [R0, #0]
MOVS	R0, #15
ANDS	R1, R0
UXTB	R1, R1
MOVW	R0, #lo_addr(_pcHexChar+0)
MOVT	R0, #hi_addr(_pcHexChar+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;utils.c,133 :: 		for( ucCounter = 0; ucCounter < 12; ucCounter++ ){
LDR	R0, [SP, #0]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #0]
;utils.c,136 :: 		}
IT	AL
BLAL	L_vSerializeUUID205
L_vSerializeUUID206:
;utils.c,137 :: 		}
L_end_vSerializeUUID:
ADD	SP, SP, #4
POP	(R15)
; end of _vSerializeUUID
_vSerializeMACAddress:
;utils.c,142 :: 		void vSerializeMACAddress( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer ){
PUSH	(R14)
SUB	SP, SP, #16
;utils.c,143 :: 		unsigned int usCounter = 0;
MOVS	R6, #12
ADD	R6, SP, R6
MOVS	R5, #2
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICSvSerializeMACAddress_usCounter_L0+0)
MOVT	R7, #hi_addr(?ICSvSerializeMACAddress_usCounter_L0+0)
BL	___CC2DW+0
;utils.c,146 :: 		vHexToASCII( pcDeviceMAC, pcHexConvertBuffer, 6 );
MOVS	R0, #6
PUSH	(R0)
LDR	R0, [SP, #28]
PUSH	(R0)
MOVS	R0, #8
ADD	R0, SP, R0
PUSH	(R0)
BL	_vHexToASCII+0
ADD	SP, SP, #12
;utils.c,148 :: 		for( usCounter = 0; usCounter < 6; usCounter++ ){
MOVS	R0, #0
STR	R0, [SP, #12]
L_vSerializeMACAddress208:
LDR	R0, [SP, #12]
UXTH	R0, R0
CMP	R0, #6
IT	CS
BLCS	L_vSerializeMACAddress209
;utils.c,149 :: 		pcTextConvertBuffer[ usCounter * 3 ]         = pcDeviceMAC[ usCounter * 2 ];
LDR	R2, [SP, #12]
UXTH	R2, R2
MOVS	R0, #3
MOV	R1, R0
MULS	R1, R2, R1
UXTH	R1, R1
LDR	R0, [SP, #20]
ADDS	R3, R0, R1
LDR	R2, [SP, #12]
UXTH	R2, R2
MOVS	R0, #2
MOV	R1, R0
MULS	R1, R2, R1
UXTH	R1, R1
MOV	R0, SP
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;utils.c,150 :: 		pcTextConvertBuffer[ ( usCounter * 3 ) + 1 ] = pcDeviceMAC[ ( usCounter * 2 ) + 1 ];
LDR	R2, [SP, #12]
UXTH	R2, R2
MOVS	R1, #3
MOV	R0, R1
MULS	R0, R2, R0
UXTH	R0, R0
ADDS	R1, R0, #1
UXTH	R1, R1
LDR	R0, [SP, #20]
ADDS	R3, R0, R1
LDR	R2, [SP, #12]
UXTH	R2, R2
MOVS	R1, #2
MOV	R0, R1
MULS	R0, R2, R0
UXTH	R0, R0
ADDS	R1, R0, #1
UXTH	R1, R1
MOV	R0, SP
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;utils.c,151 :: 		if( usCounter != 5 ){
LDR	R0, [SP, #12]
UXTH	R0, R0
CMP	R0, #5
IT	EQ
BLEQ	L_vSerializeMACAddress211
;utils.c,152 :: 		pcTextConvertBuffer[ ( usCounter * 3 ) + 2 ] = ':';
LDR	R2, [SP, #12]
UXTH	R2, R2
MOVS	R1, #3
MOV	R0, R1
MULS	R0, R2, R0
UXTH	R0, R0
ADDS	R1, R0, #2
UXTH	R1, R1
LDR	R0, [SP, #20]
ADDS	R1, R0, R1
MOVS	R0, #58
STRB	R0, [R1, #0]
;utils.c,153 :: 		}
L_vSerializeMACAddress211:
;utils.c,148 :: 		for( usCounter = 0; usCounter < 6; usCounter++ ){
LDR	R0, [SP, #12]
UXTH	R0, R0
ADDS	R0, #1
STR	R0, [SP, #12]
;utils.c,154 :: 		}
IT	AL
BLAL	L_vSerializeMACAddress208
L_vSerializeMACAddress209:
;utils.c,155 :: 		pcTextConvertBuffer[ 18 ] = '\0';
LDR	R0, [SP, #20]
MOV	R1, R0
ADDS	R1, #18
MOVS	R0, #0
STRB	R0, [R1, #0]
;utils.c,156 :: 		}
L_end_vSerializeMACAddress:
ADD	SP, SP, #16
POP	(R15)
; end of _vSerializeMACAddress
_vSerializeIPAddress:
;utils.c,161 :: 		void vSerializeIPAddress( unsigned char * pcTextConvertBuffer, unsigned char * pcHexConvertBuffer ){
PUSH	(R14)
SUB	SP, SP, #16
;utils.c,162 :: 		unsigned char ucCounter = 0;
MOVS	R0, #0
STR	R0, [SP, #12]
;utils.c,165 :: 		memset( pcTextConvertBuffer, '\0', sizeof( pcTextConvertBuffer ) );
MOVS	R2, #4
MOVS	R1, #0
LDR	R0, [SP, #20]
BL	_memset+0
;utils.c,167 :: 		for( ucCounter = 0; ucCounter < 4; ucCounter++ ){
MOVS	R0, #0
STR	R0, [SP, #12]
L_vSerializeIPAddress212:
LDR	R0, [SP, #12]
UXTB	R0, R0
CMP	R0, #4
IT	CS
BLCS	L_vSerializeIPAddress213
;utils.c,169 :: 		ByteToStr( pcHexConvertBuffer[ ucCounter ], pcConvertText );
MOV	R5, SP
LDR	R1, [SP, #12]
UXTB	R1, R1
LDR	R0, [SP, #24]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
UXTB	R4, R0
MOV	R1, R5
UXTB	R0, R4
BL	_ByteToStr+0
;utils.c,171 :: 		strcat( pcTextConvertBuffer, Ltrim( pcConvertText ) );
MOV	R4, SP
MOV	R0, R4
BL	_Ltrim+0
MOV	R1, R0
LDR	R0, [SP, #20]
BL	_strcat+0
;utils.c,173 :: 		if( ucCounter != 3 ){
LDR	R0, [SP, #12]
UXTB	R0, R0
CMP	R0, #3
IT	EQ
BLEQ	L_vSerializeIPAddress215
;utils.c,174 :: 		strcat( pcTextConvertBuffer, "." );
MOVS	R6, #8
ADD	R6, SP, R6
MOVS	R5, #2
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr2_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr2_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #8
ADD	R0, SP, R0
MOV	R4, R0
MOV	R1, R4
LDR	R0, [SP, #20]
BL	_strcat+0
;utils.c,175 :: 		}
L_vSerializeIPAddress215:
;utils.c,167 :: 		for( ucCounter = 0; ucCounter < 4; ucCounter++ ){
LDR	R0, [SP, #12]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #12]
;utils.c,176 :: 		}
IT	AL
BLAL	L_vSerializeIPAddress212
L_vSerializeIPAddress213:
;utils.c,177 :: 		}
L_end_vSerializeIPAddress:
ADD	SP, SP, #16
POP	(R15)
; end of _vSerializeIPAddress
_vUARTISR:
;uarthandler.c,146 :: 		void vUARTISR() iv IVT_INT_USART1 ics ICS_AUTO{
SUB	SP, SP, #4
;uarthandler.c,147 :: 		LED_BLUE =~ LED_BLUE;
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_LX	[R0, ByteOffset(GPIOC_ODRbits+0)]
MOVS	R1, #1
LSLS	R1, R1, #8
ANDS	R1, R0
LSRS	R1, R1, #8
MOVS	R0, #1
EORS	R0, R1
UXTB	R3, R0
MOVW	R2, #lo_addr(GPIOC_ODRbits+0)
MOVT	R2, #hi_addr(GPIOC_ODRbits+0)
_LX	[R2, ByteOffset(GPIOC_ODRbits+0)]
MOVS	R1, #1
ANDS	R1, R3
BEQ	L__vUARTISR299
MOVS	R1, #1
LSLS	R1, R1, #8
ORRS	R0, R1
B	L__vUARTISR298
L__vUARTISR299:
MOVS	R1, #1
LSLS	R1, R1, #8
BICS	R0, R1
L__vUARTISR298:
_SX	[R2, ByteOffset(GPIOC_ODRbits+0)]
;uarthandler.c,156 :: 		}
L_end_vUARTISR:
ADD	SP, SP, #4
BX	LR
; end of _vUARTISR
_vUSARTStartMEMtoMEMZero:
;uarthandler.c,167 :: 		unsigned char vUSARTStartMEMtoMEMZero ( unsigned long *pcBufferDestination, unsigned long ulSizeInBytes ) {
SUB	SP, SP, #4
;uarthandler.c,206 :: 		}
L_end_vUSARTStartMEMtoMEMZero:
ADD	SP, SP, #4
BX	LR
; end of _vUSARTStartMEMtoMEMZero
_vUSARTDMAMeToMemZero:
;uarthandler.c,210 :: 		void vUSARTDMAMeToMemZero ( void ) {
SUB	SP, SP, #4
;uarthandler.c,252 :: 		}
L_end_vUSARTDMAMeToMemZero:
ADD	SP, SP, #4
BX	LR
; end of _vUSARTDMAMeToMemZero
_vUSARTStartMEMtoMEM:
;uarthandler.c,257 :: 		unsigned char vUSARTStartMEMtoMEM ( unsigned long *pcBufferOrigin, unsigned long *pcBufferDestination, unsigned long ulSizeInBytes ) {
SUB	SP, SP, #4
;uarthandler.c,296 :: 		}
L_end_vUSARTStartMEMtoMEM:
ADD	SP, SP, #4
BX	LR
; end of _vUSARTStartMEMtoMEM
_vUSARTDMAMemToMem:
;uarthandler.c,300 :: 		void vUSARTDMAMemToMem ( void ) {
SUB	SP, SP, #4
;uarthandler.c,342 :: 		}
L_end_vUSARTDMAMemToMem:
ADD	SP, SP, #4
BX	LR
; end of _vUSARTDMAMemToMem
_vUSART1Start_TX:
;uarthandler.c,348 :: 		unsigned char vUSART1Start_TX ( unsigned long *ucBuffer, unsigned long ulSize ) {
SUB	SP, SP, #4
;uarthandler.c,381 :: 		}
L_end_vUSART1Start_TX:
ADD	SP, SP, #4
BX	LR
; end of _vUSART1Start_TX
_vInitDMAUSART1_TX:
;uarthandler.c,385 :: 		void vInitDMAUSART1_TX () {
SUB	SP, SP, #4
;uarthandler.c,423 :: 		}
L_end_vInitDMAUSART1_TX:
ADD	SP, SP, #4
BX	LR
; end of _vInitDMAUSART1_TX
_vUSARTConfigUSART1:
;uarthandler.c,428 :: 		void vUSARTConfigUSART1 ( unsigned long ulBaudRate ) {
PUSH	(R14)
;uarthandler.c,441 :: 		UART1_Init_Advanced( ulBaudRate, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10 );
MOVW	R0, #lo_addr(__GPIO_MODULE_USART1_PA9_10+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_USART1_PA9_10+0)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #0
MOVS	R1, #0
LDR	R0, [SP, #8]
BL	_UART1_Init_Advanced+0
ADD	SP, SP, #4
;uarthandler.c,442 :: 		USART1_CR1bits.UE = 0;
MOVW	R2, #lo_addr(USART1_CR1bits+0)
MOVT	R2, #hi_addr(USART1_CR1bits+0)
_LX	[R2, ByteOffset(USART1_CR1bits+0)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(USART1_CR1bits+0)]
;uarthandler.c,444 :: 		ulClk = Clock_MHz() * 1000000;         // paso extra para verificacion en depuracion
MOVW	R1, #9216
MOVT	R1, #244
MOVW	R0, #lo_addr(_ulClk+0)
MOVT	R0, #hi_addr(_ulClk+0)
STR	R1, [R0, #0]
;uarthandler.c,446 :: 		USART1_BRR = ( ulClk ) / ulBaudRate;
LDR	R2, [SP, #4]
MOVW	R0, #lo_addr(_ulClk+0)
MOVT	R0, #hi_addr(_ulClk+0)
LDR	R0, [R0, #0]
BL	__Div_32x32_U+0
MOVW	R1, #lo_addr(USART1_BRR+0)
MOVT	R1, #hi_addr(USART1_BRR+0)
STR	R0, [R1, #0]
;uarthandler.c,448 :: 		USART1_CR1bits.UE = 1;
MOVW	R2, #lo_addr(USART1_CR1bits+0)
MOVT	R2, #hi_addr(USART1_CR1bits+0)
_LX	[R2, ByteOffset(USART1_CR1bits+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(USART1_CR1bits+0)]
;uarthandler.c,450 :: 		}
L_end_vUSARTConfigUSART1:
POP	(R15)
; end of _vUSARTConfigUSART1
_vUSARTCleanBuffer:
;uarthandler.c,456 :: 		void vUSARTCleanBuffer ( unsigned char *ucBuffer, unsigned int uiCnt ) {
PUSH	(R14)
;uarthandler.c,458 :: 		vUSARTStartMEMtoMEMZero( ucBuffer, uiCnt );
LDR	R0, [SP, #8]
UXTH	R0, R0
PUSH	(R0)
LDR	R0, [SP, #8]
PUSH	(R0)
BL	_vUSARTStartMEMtoMEMZero+0
ADD	SP, SP, #8
;uarthandler.c,459 :: 		}
L_end_vUSARTCleanBuffer:
POP	(R15)
; end of _vUSARTCleanBuffer
_vUSARTReceivedFromUSART1:
;uarthandler.c,463 :: 		void vUSARTReceivedFromUSART1 ( ) {
PUSH	(R14)
;uarthandler.c,465 :: 		vUSARTCleanBuffer( ucUSARTActiveBuffer1, ulUSARTActiveBuffer1BytesReceived ); // borra todo el buffer
MOVW	R0, #lo_addr(_ulUSARTActiveBuffer1BytesReceived+0)
MOVT	R0, #hi_addr(_ulUSARTActiveBuffer1BytesReceived+0)
LDR	R0, [R0, #0]
PUSH	(R0)
MOVW	R0, #lo_addr(_ucUSARTActiveBuffer1+0)
MOVT	R0, #hi_addr(_ucUSARTActiveBuffer1+0)
PUSH	(R0)
BL	_vUSARTCleanBuffer+0
ADD	SP, SP, #8
;uarthandler.c,467 :: 		vUSARTStartMEMtoMEM( ucUSART1RXBuffer, ucUSARTActiveBuffer1, ulUSART1ByteReceived );
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R0, [R0, #0]
PUSH	(R0)
MOVW	R0, #lo_addr(_ucUSARTActiveBuffer1+0)
MOVT	R0, #hi_addr(_ucUSARTActiveBuffer1+0)
PUSH	(R0)
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
PUSH	(R0)
BL	_vUSARTStartMEMtoMEM+0
ADD	SP, SP, #12
;uarthandler.c,468 :: 		vUSARTCleanBuffer( ucUSART1RXBuffer, ulUSART1ByteReceived );        // lo limpia
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R0, [R0, #0]
PUSH	(R0)
MOVW	R0, #lo_addr(_ucUSART1RXBuffer+0)
MOVT	R0, #hi_addr(_ucUSART1RXBuffer+0)
PUSH	(R0)
BL	_vUSARTCleanBuffer+0
ADD	SP, SP, #8
;uarthandler.c,469 :: 		ulUSARTActiveBuffer1BytesReceived = ulUSART1ByteReceived;                // le pasa el valor
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_ulUSARTActiveBuffer1BytesReceived+0)
MOVT	R0, #hi_addr(_ulUSARTActiveBuffer1BytesReceived+0)
STR	R1, [R0, #0]
;uarthandler.c,470 :: 		ulUSART1ByteReceived = 0;                                           // pone a cero el contador
MOVS	R1, #0
MOVW	R0, #lo_addr(_ulUSART1ByteReceived+0)
MOVT	R0, #hi_addr(_ulUSART1ByteReceived+0)
STR	R1, [R0, #0]
;uarthandler.c,471 :: 		fUSART1Buffer = CLEAR_TO_WRITE;                                     // indica que esta limpio
MOVS	R1, #0
MOVW	R0, #lo_addr(_fUSART1Buffer+0)
MOVT	R0, #hi_addr(_fUSART1Buffer+0)
STR	R1, [R0, #0]
;uarthandler.c,472 :: 		vRF4463MainCommandProcessor( ucUSARTActiveBuffer1 );
MOVW	R0, #lo_addr(_ucUSARTActiveBuffer1+0)
MOVT	R0, #hi_addr(_ucUSARTActiveBuffer1+0)
PUSH	(R0)
BL	_vRF4463MainCommandProcessor+0
ADD	SP, SP, #4
;uarthandler.c,473 :: 		}
L_end_vUSARTReceivedFromUSART1:
POP	(R15)
; end of _vUSARTReceivedFromUSART1
_vUARTRxMessage:
;uarthandler.c,482 :: 		void vUARTRxMessage(){
PUSH	(R14)
SUB	SP, SP, #4
;uarthandler.c,483 :: 		unsigned int usCounter = 0;
MOV	R6, SP
MOVS	R5, #2
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICSvUARTRxMessage_usCounter_L0+0)
MOVT	R7, #hi_addr(?ICSvUARTRxMessage_usCounter_L0+0)
BL	___CC2DW+0
;uarthandler.c,495 :: 		usUARTMessageLength = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_usUARTMessageLength+0)
MOVT	R0, #hi_addr(_usUARTMessageLength+0)
STRH	R1, [R0, #0]
;uarthandler.c,496 :: 		}
L_end_vUARTRxMessage:
ADD	SP, SP, #4
POP	(R15)
; end of _vUARTRxMessage
_Timer2_interrupt:
;DriverRF4463PROMain.c,59 :: 		void Timer2_interrupt() iv IVT_INT_TIM2 {
SUB	SP, SP, #4
;DriverRF4463PROMain.c,60 :: 		TIM2_SR.UIF = 0;
MOVW	R2, #lo_addr(TIM2_SR+0)
MOVT	R2, #hi_addr(TIM2_SR+0)
_LX	[R2, ByteOffset(TIM2_SR+0)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(TIM2_SR+0)]
;DriverRF4463PROMain.c,61 :: 		Flag.rf_reach_timeout = 1; //Enter your code here
MOVW	R2, #lo_addr(_Flag+0)
MOVT	R2, #hi_addr(_Flag+0)
_LX	[R2, ByteOffset(_Flag+0)]
MOVS	R1, #4
ORRS	R0, R1
_SX	[R2, ByteOffset(_Flag+0)]
;DriverRF4463PROMain.c,62 :: 		Flag.reach_1s = 1;
MOVW	R2, #lo_addr(_Flag+0)
MOVT	R2, #hi_addr(_Flag+0)
_LX	[R2, ByteOffset(_Flag+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(_Flag+0)]
;DriverRF4463PROMain.c,63 :: 		}
L_end_Timer2_interrupt:
ADD	SP, SP, #4
BX	LR
; end of _Timer2_interrupt
_vRF4463MainCommandProcessor:
;DriverRF4463PROMain.c,67 :: 		void vRF4463MainCommandProcessor ( unsigned char *ucBuffer ) {
SUB	SP, SP, #4
;DriverRF4463PROMain.c,69 :: 		}
L_end_vRF4463MainCommandProcessor:
ADD	SP, SP, #4
BX	LR
; end of _vRF4463MainCommandProcessor
_InitTimer2:
;DriverRF4463PROMain.c,75 :: 		void InitTimer2(){
PUSH	(R14)
;DriverRF4463PROMain.c,87 :: 		RCC_APBENR1bits.TIM2EN = 1;
MOVW	R2, #lo_addr(RCC_APBENR1bits+0)
MOVT	R2, #hi_addr(RCC_APBENR1bits+0)
_LX	[R2, ByteOffset(RCC_APBENR1bits+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(RCC_APBENR1bits+0)]
;DriverRF4463PROMain.c,88 :: 		TIM2_CR1.CEN = 0;
MOVW	R2, #lo_addr(TIM2_CR1+0)
MOVT	R2, #hi_addr(TIM2_CR1+0)
_LX	[R2, ByteOffset(TIM2_CR1+0)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(TIM2_CR1+0)]
;DriverRF4463PROMain.c,89 :: 		TIM2_PSC = 249;
MOVS	R1, #249
MOVW	R0, #lo_addr(TIM2_PSC+0)
MOVT	R0, #hi_addr(TIM2_PSC+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,90 :: 		TIM2_ARR = 63999;
MOVW	R1, #63999
MOVT	R1, #0
MOVW	R0, #lo_addr(TIM2_ARR+0)
MOVT	R0, #hi_addr(TIM2_ARR+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,91 :: 		NVIC_IntEnable( IVT_INT_TIM2 );
MOVS	R0, #31
BL	_NVIC_IntEnable+0
;DriverRF4463PROMain.c,92 :: 		TIM2_DIER.UIE = 1;
MOVW	R2, #lo_addr(TIM2_DIER+0)
MOVT	R2, #hi_addr(TIM2_DIER+0)
_LX	[R2, ByteOffset(TIM2_DIER+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(TIM2_DIER+0)]
;DriverRF4463PROMain.c,93 :: 		TIM2_CR1.CEN = 1;
MOVW	R2, #lo_addr(TIM2_CR1+0)
MOVT	R2, #hi_addr(TIM2_CR1+0)
_LX	[R2, ByteOffset(TIM2_CR1+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(TIM2_CR1+0)]
;DriverRF4463PROMain.c,95 :: 		}
L_end_InitTimer2:
POP	(R15)
; end of _InitTimer2
_main:
;DriverRF4463PROMain.c,99 :: 		void main() {
SUB	SP, SP, #60
;DriverRF4463PROMain.c,103 :: 		Delay_ms( 2000 );                    // delay de depuracion
LDR	R7, [PC, #7999999]
NOP
L_main216:
SUBS	R7, R7, #1
BNE	L_main216
B	#4
	#7999999
NOP
;DriverRF4463PROMain.c,216 :: 		GPIO_Digital_Output( &GPIOC_BASE, _GPIO_PINMASK_6 );  // r   ( Led Rojo de tarjeta de desarrollo )
MOVS	R1, #64
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,221 :: 		GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_9 );
MOVW	R1, #512
MOVT	R1, #0
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,224 :: 		GPIO_Digital_Input( &GPIOC_BASE, _GPIO_PINMASK_14 );
MOVW	R1, #16384
MOVT	R1, #0
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Input+0
;DriverRF4463PROMain.c,225 :: 		GPIO_Digital_Input( &GPIOC_BASE, _GPIO_PINMASK_15 );
MOVW	R1, #32768
MOVT	R1, #0
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Input+0
;DriverRF4463PROMain.c,230 :: 		GPIO_Digital_Input( &GPIOA_BASE, _GPIO_PINMASK_2 );          // nIRQ
MOVS	R1, #4
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Input+0
;DriverRF4463PROMain.c,232 :: 		GPIO_Digital_Output( &GPIOA_BASE, _GPIO_PINMASK_3 );         // nSEL
MOVS	R1, #8
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,233 :: 		GPIO_Digital_Output( &GPIOB_BASE, _GPIO_PINMASK_2 );         // SDN
MOVS	R1, #4
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,234 :: 		GPIO_Digital_Output( &GPIOA_BASE, _GPIO_PINMASK_11 );        // GPIO0
MOVW	R1, #2048
MOVT	R1, #0
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,235 :: 		GPIO_Digital_Output( &GPIOA_BASE, _GPIO_PINMASK_12 );        // GPIO1
MOVW	R1, #4096
MOVT	R1, #0
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
;DriverRF4463PROMain.c,251 :: 		RCC_APBENR2bits.SYSCFGEN = 1;
MOVW	R2, #lo_addr(RCC_APBENR2bits+0)
MOVT	R2, #hi_addr(RCC_APBENR2bits+0)
_LX	[R2, ByteOffset(RCC_APBENR2bits+0)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(RCC_APBENR2bits+0)]
;DriverRF4463PROMain.c,253 :: 		SYSCFG_VREFBUF_CFGR1bits.UCPD1_STROBE = 1;
MOVW	R2, #lo_addr(SYSCFG_VREFBUF_CFGR1bits+0)
MOVT	R2, #hi_addr(SYSCFG_VREFBUF_CFGR1bits+0)
_LX	[R2, ByteOffset(SYSCFG_VREFBUF_CFGR1bits+0)]
MOVS	R1, #1
LSLS	R1, R1, #9
ORRS	R0, R1
_SX	[R2, ByteOffset(SYSCFG_VREFBUF_CFGR1bits+0)]
;DriverRF4463PROMain.c,256 :: 		nSEL = 1;
MOVW	R2, #lo_addr(GPIOA_ODRbits+0)
MOVT	R2, #hi_addr(GPIOA_ODRbits+0)
_LX	[R2, ByteOffset(GPIOA_ODRbits+0)]
MOVS	R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOA_ODRbits+0)]
;DriverRF4463PROMain.c,258 :: 		LED_RED      = 1;
MOVW	R2, #lo_addr(GPIOC_ODRbits+0)
MOVT	R2, #hi_addr(GPIOC_ODRbits+0)
_LX	[R2, ByteOffset(GPIOC_ODRbits+0)]
MOVS	R1, #64
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,259 :: 		LED_GREEN    = 1;
MOVW	R2, #lo_addr(GPIOC_ODRbits+0)
MOVT	R2, #hi_addr(GPIOC_ODRbits+0)
_LX	[R2, ByteOffset(GPIOC_ODRbits+0)]
MOVS	R1, #64
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,260 :: 		LED_BLUE     = 1;
MOVW	R2, #lo_addr(GPIOC_ODRbits+0)
MOVT	R2, #hi_addr(GPIOC_ODRbits+0)
_LX	[R2, ByteOffset(GPIOC_ODRbits+0)]
MOVS	R1, #1
LSLS	R1, R1, #8
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,262 :: 		Delay_ms( 100 );
LDR	R7, [PC, #399999]
NOP
L_main218:
SUBS	R7, R7, #1
BNE	L_main218
B	#4
	#399999
NOP
;DriverRF4463PROMain.c,264 :: 		LED_RED      = 0;
MOVW	R2, #lo_addr(GPIOC_ODRbits+0)
MOVT	R2, #hi_addr(GPIOC_ODRbits+0)
_LX	[R2, ByteOffset(GPIOC_ODRbits+0)]
MOVS	R1, #64
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,265 :: 		LED_GREEN    = 1;
MOVW	R2, #lo_addr(GPIOC_ODRbits+0)
MOVT	R2, #hi_addr(GPIOC_ODRbits+0)
_LX	[R2, ByteOffset(GPIOC_ODRbits+0)]
MOVS	R1, #64
ORRS	R0, R1
_SX	[R2, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,266 :: 		LED_BLUE     = 0;
MOVW	R2, #lo_addr(GPIOC_ODRbits+0)
MOVT	R2, #hi_addr(GPIOC_ODRbits+0)
_LX	[R2, ByteOffset(GPIOC_ODRbits+0)]
MOVS	R1, #1
LSLS	R1, R1, #8
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,268 :: 		InitTimer2();
BL	_InitTimer2+0
;DriverRF4463PROMain.c,271 :: 		vUSARTConfigUSART1( 115200 );  // configura todos las parametros de USART
MOVW	R0, #49664
MOVT	R0, #1
PUSH	(R0)
BL	_vUSARTConfigUSART1+0
ADD	SP, SP, #4
;DriverRF4463PROMain.c,287 :: 		vSPI1Init();           // configura todos los parametros de SPI
BL	_vSPI1Init+0
;DriverRF4463PROMain.c,293 :: 		freq3 = 9;
MOVS	R1, #9
MOVW	R0, #lo_addr(_freq3+0)
MOVT	R0, #hi_addr(_freq3+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,294 :: 		freq2 = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_freq2+0)
MOVT	R0, #hi_addr(_freq2+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,295 :: 		freq1 = 5;
MOVS	R1, #5
MOVW	R0, #lo_addr(_freq1+0)
MOVT	R0, #hi_addr(_freq1+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,298 :: 		power = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_power+0)
MOVT	R0, #hi_addr(_power+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,300 :: 		rate  = dr_1p2;                // BAUDRATE
MOVS	R1, #0
MOVW	R0, #lo_addr(_rate+0)
MOVT	R0, #hi_addr(_rate+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,302 :: 		mode  = master_mode;          // para transmision continua usar: tx_test_mode
MOVS	R1, #0
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,306 :: 		reset_mode = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_reset_mode+0)
MOVT	R0, #hi_addr(_reset_mode+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,310 :: 		VRF4463SDNReset();
BL	_VRF4463SDNReset+0
;DriverRF4463PROMain.c,311 :: 		vRF4463Init();
BL	_vRF4463Init+0
;DriverRF4463PROMain.c,312 :: 		vRF4463ClearInterrupts();
BL	_vRF4463ClearInterrupts+0
;DriverRF4463PROMain.c,313 :: 		vRF4463PartInfo ();          // SOLICITA EL MODELO DEL RADIO
BL	_vRF4463PartInfo+0
;DriverRF4463PROMain.c,315 :: 		LED_GREEN    = 0;
MOVW	R2, #lo_addr(GPIOC_ODRbits+0)
MOVT	R2, #hi_addr(GPIOC_ODRbits+0)
_LX	[R2, ByteOffset(GPIOC_ODRbits+0)]
MOVS	R1, #64
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,316 :: 		LED_BLUE     = 0;
MOVW	R2, #lo_addr(GPIOC_ODRbits+0)
MOVT	R2, #hi_addr(GPIOC_ODRbits+0)
_LX	[R2, ByteOffset(GPIOC_ODRbits+0)]
MOVS	R1, #1
LSLS	R1, R1, #8
BICS	R0, R1
_SX	[R2, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,323 :: 		UART1_Write_Text( "[ SYS STM32G ]RF Radio ready\r\n" );
MOVS	R6, #8
ADD	R6, SP, R6
MOVS	R5, #31
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr3_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr3_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #8
ADD	R0, SP, R0
MOV	R4, R0
MOV	R0, R4
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,326 :: 		while ( 1 ) {
L_main220:
;DriverRF4463PROMain.c,334 :: 		if ( ucRF4463IRQ ) {
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L_main222
;DriverRF4463PROMain.c,335 :: 		ucRF4463IRQ = 0;       // limpia bandera
MOVS	R1, #0
MOVW	R0, #lo_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
MOVT	R0, #hi_addr(DriverRF4463PROMain_ucRF4463IRQ+0)
STRB	R1, [R0, #0]
;DriverRF4463PROMain.c,336 :: 		spi_read_fifo();       // Read RX FIFO
BL	_spi_read_fifo+0
;DriverRF4463PROMain.c,337 :: 		vRF4463FifoReset();    // FIFO RESET
BL	_vRF4463FifoReset+0
;DriverRF4463PROMain.c,338 :: 		UART1_Write_Text( spi_read_buf );
MOVW	R0, #lo_addr(_spi_read_buf+0)
MOVT	R0, #hi_addr(_spi_read_buf+0)
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,339 :: 		}
L_main222:
;DriverRF4463PROMain.c,342 :: 		if ( mode == master_mode ) {
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BLNE	L_main223
;DriverRF4463PROMain.c,343 :: 		vRF4463TxData();
BL	_vRF4463TxData+0
;DriverRF4463PROMain.c,344 :: 		}
IT	AL
BLAL	L_main224
L_main223:
;DriverRF4463PROMain.c,347 :: 		else if ( mode == slave_mode ) {
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BLNE	L_main225
;DriverRF4463PROMain.c,348 :: 		vRF4463RxInit();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,349 :: 		}
L_main225:
L_main224:
;DriverRF4463PROMain.c,352 :: 		if ( mode == tx_test_mode ) {
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BLNE	L_main226
;DriverRF4463PROMain.c,353 :: 		vRF4463TxCont();
BL	_vRF4463TxCont+0
;DriverRF4463PROMain.c,354 :: 		while ( 1 ) {
L_main227:
;DriverRF4463PROMain.c,355 :: 		if ( !nIRQ ) {
MOVW	R0, #lo_addr(GPIOA_IDRbits+0)
MOVT	R0, #hi_addr(GPIOA_IDRbits+0)
_LX	[R0, ByteOffset(GPIOA_IDRbits+0)]
MOVS	R0, #4
ANDS	R0, R1
LSRS	R0, R0, #2
CMP	R0, #0
IT	NE
BLNE	L_main229
;DriverRF4463PROMain.c,356 :: 		vRF4463TxCont();
BL	_vRF4463TxCont+0
;DriverRF4463PROMain.c,357 :: 		}
L_main229:
;DriverRF4463PROMain.c,358 :: 		}
IT	AL
BLAL	L_main227
;DriverRF4463PROMain.c,359 :: 		}
L_main226:
;DriverRF4463PROMain.c,361 :: 		if ( mode == rx_test_mode ) {
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BLNE	L_main230
;DriverRF4463PROMain.c,362 :: 		vRF4463RxInit ();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,363 :: 		while ( 1 ) {
L_main231:
;DriverRF4463PROMain.c,365 :: 		}
IT	AL
BLAL	L_main231
;DriverRF4463PROMain.c,366 :: 		}
L_main230:
;DriverRF4463PROMain.c,368 :: 		if ( reset_mode == 0 ) {
MOVW	R0, #lo_addr(_reset_mode+0)
MOVT	R0, #hi_addr(_reset_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BLNE	L_main233
;DriverRF4463PROMain.c,370 :: 		while ( 1 ) {
L_main234:
;DriverRF4463PROMain.c,372 :: 		if ( Flag.reach_1s ) {
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
_LX	[R0, ByteOffset(_Flag+0)]
MOVS	R0, #1
ANDS	R0, R1
LSRS	R0, R0, #0
CMP	R0, #0
IT	EQ
BLEQ	L_main236
;DriverRF4463PROMain.c,373 :: 		Flag.reach_1s = 0;
MOVW	R2, #lo_addr(_Flag+0)
MOVT	R2, #hi_addr(_Flag+0)
_LX	[R2, ByteOffset(_Flag+0)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(_Flag+0)]
;DriverRF4463PROMain.c,374 :: 		if ( mode == master_mode ) {
MOVW	R0, #lo_addr(_mode+0)
MOVT	R0, #hi_addr(_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BLNE	L_main237
;DriverRF4463PROMain.c,375 :: 		vRF4463TxData();
BL	_vRF4463TxData+0
;DriverRF4463PROMain.c,376 :: 		}
L_main237:
;DriverRF4463PROMain.c,377 :: 		}
L_main236:
;DriverRF4463PROMain.c,380 :: 		if ( !Flag.is_tx ) {
MOVW	R0, #lo_addr(_Flag+0)
MOVT	R0, #hi_addr(_Flag+0)
_LX	[R0, ByteOffset(_Flag+0)]
MOVS	R0, #2
ANDS	R0, R1
LSRS	R0, R0, #1
CMP	R0, #0
IT	NE
BLNE	L_main238
;DriverRF4463PROMain.c,381 :: 		if ( !nIRQ ) {          // !nIRQ
MOVW	R0, #lo_addr(GPIOA_IDRbits+0)
MOVT	R0, #hi_addr(GPIOA_IDRbits+0)
_LX	[R0, ByteOffset(GPIOA_IDRbits+0)]
MOVS	R0, #4
ANDS	R0, R1
LSRS	R0, R0, #2
CMP	R0, #0
IT	NE
BLNE	L_main239
;DriverRF4463PROMain.c,382 :: 		vRF4463ClearInterrupts();
BL	_vRF4463ClearInterrupts+0
;DriverRF4463PROMain.c,384 :: 		if ( ( spi_read_buf[ 4 ] & 0x08) == 0 ) { // crc error check
MOVW	R0, #lo_addr(_spi_read_buf+4)
MOVT	R0, #hi_addr(_spi_read_buf+4)
LDRB	R1, [R0, #0]
MOVS	R0, #8
ANDS	R0, R1
UXTB	R0, R0
CMP	R0, #0
IT	NE
BLNE	L_main240
;DriverRF4463PROMain.c,386 :: 		spi_read_fifo();
BL	_spi_read_fifo+0
;DriverRF4463PROMain.c,387 :: 		vRF4463FifoReset();
BL	_vRF4463FifoReset+0
;DriverRF4463PROMain.c,389 :: 		chksum = 0;
MOVS	R0, #0
STR	R0, [SP, #4]
;DriverRF4463PROMain.c,390 :: 		for ( i = 4; i < payload_length - 1; i++ )                // Calculation Checksum
MOVS	R0, #4
STR	R0, [SP, #0]
L_main241:
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, #13
IT	GE
BLGE	L_main242
;DriverRF4463PROMain.c,391 :: 		chksum += rx_buf[ i ];
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
;DriverRF4463PROMain.c,390 :: 		for ( i = 4; i < payload_length - 1; i++ )                // Calculation Checksum
LDR	R0, [SP, #0]
UXTB	R0, R0
ADDS	R0, #1
STR	R0, [SP, #0]
;DriverRF4463PROMain.c,391 :: 		chksum += rx_buf[ i ];
IT	AL
BLAL	L_main241
L_main242:
;DriverRF4463PROMain.c,393 :: 		if ( ( chksum == rx_buf[ payload_length - 1 ] )&&( rx_buf[ 4 ] == 0x41 )) {
MOVW	R0, #lo_addr(_rx_buf+13)
MOVT	R0, #hi_addr(_rx_buf+13)
LDRB	R1, [R0, #0]
LDR	R0, [SP, #4]
UXTB	R0, R0
CMP	R0, R1
IT	NE
BLNE	L_main246
MOVW	R0, #lo_addr(_rx_buf+4)
MOVT	R0, #hi_addr(_rx_buf+4)
LDRB	R0, [R0, #0]
CMP	R0, #65
IT	NE
BLNE	L_main246
L__main253:
;DriverRF4463PROMain.c,402 :: 		UART1_Write_Text( rx_buf );
MOVW	R0, #lo_addr(_rx_buf+0)
MOVT	R0, #hi_addr(_rx_buf+0)
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,403 :: 		UART1_Write_Text("\r\n");
MOVS	R6, #40
ADD	R6, SP, R6
MOVS	R5, #3
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr4_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr4_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #40
ADD	R0, SP, R0
MOV	R4, R0
MOV	R0, R4
BL	_UART1_Write_Text+0
;DriverRF4463PROMain.c,408 :: 		LED_GREEN ^= 1;                                        // Data received
MOVW	R0, #lo_addr(GPIOC_ODRbits+0)
MOVT	R0, #hi_addr(GPIOC_ODRbits+0)
_LX	[R0, ByteOffset(GPIOC_ODRbits+0)]
MOVS	R2, #64
ANDS	R2, R0
LSRS	R2, R2, #6
MOVW	R0, #lo_addr(_ucSPI1ByteReceived+0)
MOVT	R0, #hi_addr(_ucSPI1ByteReceived+0)
LDRB	R1, [R0, #0]
MOVS	R0, BitMask(_ucSPI1ByteReceived+0)
ANDS	R0, R1
LSRS	R0, R0, BitPos(_ucSPI1ByteReceived+0)
MOV	R3, R2
EORS	R3, R0
MOVW	R2, #lo_addr(GPIOC_ODRbits+0)
MOVT	R2, #hi_addr(GPIOC_ODRbits+0)
_LX	[R2, ByteOffset(GPIOC_ODRbits+0)]
MOVS	R1, #1
ANDS	R1, R3
BEQ	L__main315
MOVS	R1, #64
ORRS	R0, R1
B	L__main314
L__main315:
MOVS	R1, #64
BICS	R0, R1
L__main314:
_SX	[R2, ByteOffset(GPIOC_ODRbits+0)]
;DriverRF4463PROMain.c,409 :: 		rx_cnt++;
MOVW	R0, #lo_addr(_rx_cnt+0)
MOVT	R0, #hi_addr(_rx_cnt+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(_rx_cnt+0)
MOVT	R0, #hi_addr(_rx_cnt+0)
STR	R1, [R0, #0]
;DriverRF4463PROMain.c,415 :: 		}
IT	AL
BLAL	L_main247
L_main246:
;DriverRF4463PROMain.c,417 :: 		vRF4463RxInit();    // The received data is wrong, you must continue to receive
BL	_vRF4463RxInit+0
L_main247:
;DriverRF4463PROMain.c,418 :: 		}
IT	AL
BLAL	L_main248
L_main240:
;DriverRF4463PROMain.c,421 :: 		vUSART1Start_TX("[ CRC ] Fail\r\n", 14 );
MOVS	R0, #14
PUSH	(R0)
MOVS	R6, #48
ADD	R6, SP, R6
MOVS	R5, #15
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICS?lstr5_DriverRF4463PROMain+0)
MOVT	R7, #hi_addr(?ICS?lstr5_DriverRF4463PROMain+0)
BL	___CC2DW+0
MOVS	R0, #48
ADD	R0, SP, R0
PUSH	(R0)
BL	_vUSART1Start_TX+0
ADD	SP, SP, #8
;DriverRF4463PROMain.c,422 :: 		VRF4463SDNReset();
BL	_VRF4463SDNReset+0
;DriverRF4463PROMain.c,423 :: 		vRF4463Init();
BL	_vRF4463Init+0
;DriverRF4463PROMain.c,424 :: 		vRF4463RxInit();
BL	_vRF4463RxInit+0
;DriverRF4463PROMain.c,425 :: 		}
L_main248:
;DriverRF4463PROMain.c,426 :: 		}
L_main239:
;DriverRF4463PROMain.c,427 :: 		}
L_main238:
;DriverRF4463PROMain.c,428 :: 		}
IT	AL
BLAL	L_main234
;DriverRF4463PROMain.c,429 :: 		}
L_main233:
;DriverRF4463PROMain.c,430 :: 		}
IT	AL
BLAL	L_main220
;DriverRF4463PROMain.c,431 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
