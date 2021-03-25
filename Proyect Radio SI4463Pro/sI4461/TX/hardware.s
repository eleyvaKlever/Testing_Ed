	INCLUDE TG110F32.inc		; CPU register definitions
		
	PRESERVE8
	THUMB				; use thumb instruction set

	AREA	RAM, DATA, NOINIT, READWRITE, ALIGN=3
SPIbuf	SPACE 	20			; SPI I/O buffer
	EXPORT	SPIbuf

	AREA    |.text|, CODE, READONLY

CMU_setup	PROC			; setup Clock Management Unit
	EXPORT	CMU_setup
	PUT	0x259, CMU_OSCENCMD, CMU ; enable HFRCO, LFRCO, AUHHFRCO
	PUT	0x001, CMU_LFCLKSEL	; set LFRCO as LFA
	PUT	0x004, CMU_HFCORECLKEN0	; enable LE clock 
	PUT 	0x844, CMU_HFPERCLKEN0	; enable HF clock to GPIO,SPI
	PUT	0x006, CMU_LFACLKEN0	; enable LFA to LETIMER and RTC		
	bx	LR
	ENDP

;-------------------------------------------------------------------------------
GPIO_setup	PROC			; setup I/O ports
	EXPORT	GPIO_setup
	PUT	0x24<<24, GPIO_PC_MODEH, GPIO ; in on CTS w. pull-up, out on CS	
	PUT	(0x03<<14)+2, GPIO_PC_DOUT ; set pull-up for CTS, init CS for radio
	bx	LR
	ENDP

;-------------------------------------------------------------------------------
USART_setup	PROC			; setup SPI module
	EXPORT	USART_setup
	PUT	0x50A, USARTn_ROUTE, USART0 ; enable CLK,TX pins @ location 5
	PUT	0x401, USARTn_CTRL	; synch mode, msb first	
	PUT	5, USARTn_FRAME		; use 8-bit frames
	PUT	4<<6, USARTn_CLKDIV	; set 3.5 MHz SPI clock (@ PERCLK=14 MHz)
;	PUT	2<<6, USARTn_CLKDIV	; set 14/3 MHz SPI clock (@ PERCLK=14 MHz)
	PUT	0xC14, USARTn_CMD	; Master mode, enable TX, clear TX/RX
	
	PUT	0x404004, GPIO_PB_MODEH, GPIO ; configure SCLK pin for USART0
	PUT	0x04<<28, GPIO_PB_MODEL	
	PUT	0x24, GPIO_PC_MODEL   	; configure MOSI/MISO pis for USART0	
	
	PUT	1<<4, 0, NVIC_ISER	; enable USART0 TX interrupt	
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