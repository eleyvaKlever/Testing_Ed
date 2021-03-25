	INCLUDE TG110F32.inc		; CPU register definitions
	IMPORT	LCD_buf
		
	PRESERVE8
	THUMB				; use thumb instruction set

	AREA	RAM, DATA, NOINIT, READWRITE, ALIGN=3
SPIbuf	SPACE 	32			; SPI I/O buffer
Readbuf	SPACE	16			; response buffer
DMA_c0	SPACE 	16			; DMA channel 0 data structure
DMA_c1	SPACE	16			; DMA channel 1 data structure	
	EXPORT	SPIbuf
	EXPORT	Readbuf	
	EXPORT	DMA_c0
	EXPORT	DMA_c1

	AREA    |.text|, CODE, READONLY

CMU_setup	PROC			; setup Clock Management Unit
	EXPORT	CMU_setup
	PUT	0x259, CMU_OSCENCMD, CMU ; enable HFRCO, LFRCO, AUHHFRCO
	PUT	0x001, CMU_LFCLKSEL	; set LFRCO as LFA
	PUT	0x006, CMU_HFCORECLKEN0	; enable LE clock and DMA 
	PUT 	0x844, CMU_HFPERCLKEN0	; enable HF clock to GPIO,SPI
	PUT	0x006, CMU_LFACLKEN0	; enable LFA to LETIMER and RTC		
	bx	LR
	ENDP

;-------------------------------------------------------------------------------
GPIO_setup	PROC			; setup I/O ports
	EXPORT	GPIO_setup	
	PUT	0x24<<24, GPIO_PC_MODEH, GPIO ; in on CTS w. pull-up, out on CS	
	PUT	(0x03<<14)+2, GPIO_PC_DOUT ; set pull-up for CTS, init CS for radio
	PUT	0x09<<8, GPIO_PB_DOUT  	; set CS and RST pins for LCD
	PUT	0x02, GPIO_PA_MODEL	; configure PA0 for input with pull-up
	PUT	0x01, GPIO_PA_DOUT	; select pull-up on PA0
	PUT	0x01, GPIO_EXTIFALL	; select falling edge trigger on PA0
	PUT	0x01, GPIO_INSENSE	; enable input sensing for interrupts 
	PUT	0x02, 0, NVIC_ISER	; enable GPIO interrupts in NVIC
	ldr	R12, =GPIO		; pointer to GPIO
	bx	LR
	ENDP

;-------------------------------------------------------------------------------
USART_setup	PROC			; setup SPI module
	EXPORT	USART_setup
	PUT	0x50B, USARTn_ROUTE, USART0 ; enable CLK,TX,RX pins @ location 5
	PUT	0x401, USARTn_CTRL	; synch mode, msb first	
	PUT	5, USARTn_FRAME		; use 8-bit frames
	PUT	4<<6, USARTn_CLKDIV	; set 3.5 MHz SPI clock (@ PERCLK=14 MHz)
;	PUT	2<<6, USARTn_CLKDIV	; set 14/3 MHz SPI clock (@ PERCLK=14 MHz)
	PUT	0xC15, USARTn_CMD	; Master mode, enable TX/RX, clear TX/RX
	
	PUT	0x404004, GPIO_PB_MODEH, GPIO ; configure SCLK pin for USART0
	PUT	0x04<<28, GPIO_PB_MODEL	
	PUT	0x14, GPIO_PC_MODEL   	; configure MOSI/MISO pis for USART0	
	
	PUT	3<<3, 0, NVIC_ISER	; enable USART0 TX/RX interrupts	
	bx	LR
	ENDP

;-------------------------------------------------------------------------------
DMA_setup	PROC
	EXPORT	DMA_setup
;	ldr	R0, =(DMA_c0+16)	; fill DMA_1 data structure
	ldr	R0, =DMA_c0
	ldr	R1, =(LCD_buf - 2)	
	str	R1, [R0]		; DMA_1 source end address
	PUT	USART0+USARTn_TXDOUBLE, 4; destination address	
	PUT	0xD5000000, 8		; invalidate DMA data structure

	PUT	0xC0001, 0, DMA_CH0_CTRL+DMA ; source/signal = USART0/TXBL
	PUT	1, DMA_CONFIG, DMA	; enable DMA	 
	ldr	R1, =DMA_c0		; set up control data base pointer
	str	R1, [R0, #DMA_CTRLBASE]
	PUT	1, DMA_CHUSEBURSTS	; use burst mode for DMA_0
	PUT	1, DMA_CHREQMASKC	; enable DMA_0 requests for peripherals
	PUT	1, DMA_CHALTC		; use primary structure for DMA_0
	PUT	0x0F, 0, DMA_IFC+DMA
	PUT	1, 0, DMA_IEN+DMA	; enable DMA_0 interrupt
	PUT	1, 0, NVIC_ISER
	bx	LR
	ENDP

;-------------------------------------------------------------------------------
LETIMER0_setup	PROC			; setup low energy timer
	EXPORT	LETIMER0_setup
	PUT	0x1200, LETIMERn_CTRL, LETIMER0	; free mode with TOP=COMP0
	PUT	0x7FFF, LETIMERn_COMP0	; 1 sec delay setup
	PUT 	0x004,  LETIMERn_IEN	; enable underflow interrupt
	PUT	0x001,  LETIMERn_CMD	; start LETIMER0
	PUT	1<<15, 0, NVIC_ISER	; enable LETIMER0 interrupt
	bx	LR
	ENDP

	ALIGN
	END