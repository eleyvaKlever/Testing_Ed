	INCLUDE TG110F32.inc		; CPU register definitions
	IMPORT 	Readbuf

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
	DCD     GPIO_Handler  		; 1: GPIO_EVEN Interrupt
	DCD     Default_Handler  	; 2: TIMER0 Interrupt
	DCD     USART0_RX_Handler  	; 3: USART0_RX Interrupt
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
 	DCD     Default_Handler  	; 15: LETIMER0 Interrupt
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
GPIO_Handler	PROC
	PUT	0x01, GPIO_IFC, GPIO	; clear PA0 IF
	PUT	0x00, GPIO_IEN
	ldr	R2, =SCB_SCR		; cancel deep sleep mode 
	movs	R1, #0
	str	R1, [R2]	
	bx	LR
	ENDP
		
;--------------------------------------------------------------------	
USART0_RX_Handler	PROC		; SPI_TX handler
	ldr	R1, [R0, #USARTn_RXDATA]; get byte from RX buffer
	strb	R1, [R11], #1		; load byte to buffer
	subs	R4,	#1		; decrement RX bytes counter
	beq	rxh1			; all bytes received?
	str	R4, [R0, #USARTn_TXDATA]; NO - request next byte
	bx	LR	

rxh1	ldr	R3, =SCB_SCR		; YES - cancel sleep on exit 
	movs	R1, #0
	str	R1, [R3]
	str	R1, [R0, #USARTn_IEN]	; disable SPI interrupts
	bx	LR	
	ENDP
		
;--------------------------------------------------------------------	
USART0_TX_Handler	PROC		; SPI_TX handler
	cbz	R3, txh1	
	ldrb	R1, [R11], #1		; R1 = byte to transmit
	str	R1, [R0, #USARTn_TXDATA]; load it to TX buffer
	subs	R3, #1			; decrement TX bytes counter
	itttt	eq			; last byte sent?
	moveq	R1, #0xFF9		
	streq	R1, [R0, #USARTn_IFC] 	; YES - clear USART interrupt flags	
	moveq	R1, #0x01		
	streq	R1, [R0, #USARTn_IEN]	; and enable TXC interrupt
txh0	bx	LR			

txh1	cbz	R4, txh2		; receive bytes?
	ldr	R1, [R0, #USARTn_RXDATA]; clear RX IF
w4rs	ldr	R1, [R0, #USARTn_IF]	; YES - wait for RX flag set
	tst	R1, #0x04
	beq	w4rs
	ldr	R1, [R0, #USARTn_RXDATA]; clear RX IF
	PUT	0xFF9, USARTn_IFC 	; clear USART interrupt flags
	ldr	R3, =NVIC_ICPR		; clear pending IFs in NVIC
	movs	R1, #0x18
	str	R1, [R3]
	ldr	R11, =Readbuf		; set pointer to receive buffer
	PUT	0x04, USARTn_IEN	; enable RX dava valid interrupt
	str	R1, [R0, #USARTn_TXDATA]; request data	
	bx	LR

txh2	ldr	R3, =SCB_SCR		; cancel sleep on exit 
	movs	R1, #0
	str	R1, [R3]
	PUT	0x00, USARTn_IEN	; disable TX interrupts	
	bx	LR	
	ENDP
	
;--------------------------------------------------------------------
Default_Handler	PROC			; default ISR placeholder
	b	.
	ENDP
	ALIGN
	END
	

