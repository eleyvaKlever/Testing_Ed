	INCLUDE TG110F32.inc		; CPU register definitions

	AREA    STACK, NOINIT, READWRITE, ALIGN=3
stmem 	SPACE   0x100			; stack size
top_of_stack

	AREA    RESET, DATA, READONLY;, ALIGN=8
	EXPORT  __Vectors		; Vector Table mapped to address 0 at reset
__Vectors       
	DCD     top_of_stack 		; Top of Stack        
	DCD     Reset_Handler 		; Reset Handler
	DCD     Default_Handler 	; NMI Handler
	DCD     Default_Handler  	; Hard Fault Handler
	DCD     Default_Handler  	; MPU Fault Handler
	DCD     Default_Handler  	; Bus Fault Handler
	DCD     Default_Handler  	; Usage Fault Handler
	DCD     0 			; Reserved
	DCD     0 			; Reserved
	DCD     0 			; Reserved
	DCD     0  			; Reserved
	DCD     Default_Handler  	; SVCall Handler
  	DCD     Default_Handler  	; Debug Monitor Handler
	DCD     0 			; Reserved
 	DCD     Default_Handler  	; PendSV Handler
  	DCD     Default_Handler  	; SysTick Handler

                ; External Interrupts
	DCD     Default_Handler  	; 0: DMA Interrupt
	DCD     Default_Handler  	; 1: GPIO_EVEN Interrupt
	DCD     Default_Handler  	; 2: TIMER0 Interrupt
	DCD     Default_Handler  	; 3: USART0_RX Interrupt
 	DCD     USART0_TX_Handler  	; 4: USART0_TX Interrupt
	DCD     Default_Handler  	; 5: ACMP0 Interrupt
	DCD     Default_Handler  	; 6: ADC0 Interrupt
 	DCD     Default_Handler  	; 7: DAC0 Interrupt
 	DCD     Default_Handler  	; 8: I2C0 Interrupt
  	DCD     Default_Handler  	; 9: GPIO_ODD Interrupt
	DCD     Default_Handler  	; 10: TIMER1 Interrupt
 	DCD     Default_Handler  	; 11: USART1_RX Interrupt
 	DCD     Default_Handler  	; 12: USART1_TX Interrupt
 	DCD     Default_Handler  	; 13: LESENSE Interrupt
 	DCD     Default_Handler  	; 14: LEUART0 Interrupt
 	DCD     LETIMER0_Handler  	; 15: LETIMER0 Interrupt
	DCD     Default_Handler  	; 16: PCNT0 Interrupt
	DCD     Default_Handler  	; 17: RTC Interrupt
	DCD     Default_Handler  	; 18: CMU Interrupt
	DCD     Default_Handler  	; 19: VCMP Interrupt
	DCD     Default_Handler  	; 20: LCD Interrupt
 	DCD     Default_Handler  	; 21: MSC Interrupt
	DCD     Default_Handler  	; 22: AES Interrupt

	PRESERVE8
	THUMB				; use thumb instruction set
	AREA    |.text|, CODE, READONLY
Reset_Handler   PROC
	EXPORT	Reset_Handler
	IMPORT	start
	ENTRY	
	ldr	R0, =start		; jump to main code
	bx 	R0
	ENDP

;--------------------------------------------------------------------	
USART0_TX_Handler	PROC		; SPI_TX handler
	cbz	R3, spi1	
	ldrb	R1, [R11], #1		; R1 = byte to transmit
	strb	R1, [R0, #USARTn_TXDATA]; load it to TX buffer
	subs	R3, #1			; decrement TX bytes counter
	itttt	eq
	moveq	R1, #0xF9
	streq	R1, [R0, #USARTn_IFC] 	; clear USART interrupt flags	
	moveq	R1, #0x01		
	streq	R1, [R0, #USARTn_IEN]	; enable TXC interrupt
	bx	LR			

spi1	ldr	R3, =SCB_SCR		; cancel sleep on exit 
	movs	R1, #0
	str	R1, [R3]
	PUT	0x00, USARTn_IEN	; disable TX interrupts	
	bx	LR	
	ENDP
	
;--------------------------------------------------------------------
LETIMER0_Handler	PROC
	PUT	0x004, LETIMERn_IFC, LETIMER0 ; clear underflow IF
	bx	LR
	ENDP	
	
;--------------------------------------------------------------------
Default_Handler	PROC			; default ISR placeholder
	b	.
	ENDP
	ALIGN
	END
	

