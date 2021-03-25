	INCLUDE TG110F32.inc		; CPU register definitions
	EXPORT	start

	IMPORT	CMU_setup
	IMPORT	LETIMER0_setup
	IMPORT	GPIO_setup
	IMPORT	USART_setup
	IMPORT	SI4461_setup
	IMPORT 	Send_SI4461
	IMPORT	Read_SI4461	
	IMPORT	Init_LCD	
	IMPORT	SPIbuf	
	IMPORT 	Readbuf	
	IMPORT	Display_Value	

	PRESERVE8
	THUMB				; use thumb instruction set
	AREA    |.text|, CODE, READONLY
;----------------------------------------------------------------------------
start	PROC				; main user code		
	bl	CMU_setup		; configure clock
	bl	GPIO_setup		; configure GPIO ports	
	bl	USART_setup		; configure SPI module		
	bl	SI4461_setup		; configure radio
	bl	Init_LCD	
				
loop					; MAIN LOOP
	bl	Start_RX		; enter RX mode, wakeup by interrupt
	PUT	SLEEPDEEP, 0, SCB_SCR 	; enable deep sleep mode
	wfi				; enter deep sleep mode
	nop				; wake-up by LETIMER0
	
	ldr	R11, =SPIbuf
	movw	R1, #0x1502		; FIFO_INFO command
	movt	R1, #0x0000
	str	R1, [R11]		; load command to buffer			
	bl	Send_SI4461
	ldr	R11, =SPIbuf	
	movw	R1, #0x4401		; READ_CMD_BUFF command
	strh	R1, [R11]
	movs	R4, #0x03		; response length
	bl	Read_SI4461		; get response	
	ldrb	R4, [R11, #-2]		; get RX_FIFO_COUNT

	movs	R10, #0x01		; package # to display
	cbz	R4, l1			; do not read 0 length buffer
	ldr	R11, =SPIbuf
	movw	R1, #0x7701		; READ_RX_FIFO command
	strh	R1, [R11]
	bl	Read_SI4461		; load package from FIFO
	ldrb	R10, [R11, #-5]		; get package number

l1	ldr	R11, =SPIbuf
	movw	R1, #0x5001		; FRR_A_READ command
	strh	R1, [R11]		; load command to buffer
	movs	R4, #0x04		; read all 4 FRRs
	bl	Read_SI4461		; get RSSI and PH/Modem/Chip stati

	ldrb	R1, [R11, #-3]		; get PH status bits
	tst	R1, #0x08		; check for CRC bit
	beq	l2			; display OK
	movs	R10, #0
	rsb	R10, #0			; request to display ERR

l2	bl	Display_Value		; display package # and OK/ER

	ldr	R11, =SPIbuf
	movw	R1, #0x2001		; clear interrupts
	strh	R1, [R11]
	bl	Send_SI4461
	b	loop
	ENDP

;-----------------------------------------------------------------------
Start_RX	PROC			; Enter RX mode
	push	{LR}
	ldr	R11, =SPIbuf
	movw	R1, #0x1502		; FIFO_INFO command
	movt	R1, #0x0003		; clear FIFOs
	str	R1, [R11]					
	bl	Send_SI4461	
	
	ldr	R11, =SPIbuf
	movw	R1, #0x3402		; move to RX state
	movt	R1, #0x0008
	str	R1, [R11]
	bl	Send_SI4461	
		
	ldr	R11, =SPIbuf
	movw	R1, #0x3208		; start RX
	movt	R1, #0x0000
	str	R1, [R11]
	movw	R1, #0x0000
	movt	R1, #0x0803		; stay in READY (valid) or RX (timeout)
	strh	R1, [R11, #4]
	movw	R1, #0x0003		; stay in READY if invalid
	strh	R1, [R11, #8]	
	bl	Send_SI4461

sr1	ldr	R11, =SPIbuf
	movw	R1, #0x3301	
	str	R1, [R11]		; REQUEST_DEVICE_STATE			
	bl	Send_SI4461
	ldr	R11, =SPIbuf	
	movw	R1, #0x4401		; READ_CMD_BUFF command
	strh	R1, [R11]
	movs	R4, #0x03		; response length
	bl	Read_SI4461		; get response	
	ldrb	R1, [R11, #-2]		; R1 = state
	cmp	R1, #0x08		; wait for RX state
	bne	sr1

	ldr	R11, =SPIbuf
	movw	R1, #0x2001		; clear interrupts
	strh	R1, [R11]
	bl	Send_SI4461
	
	PUT	0x01, GPIO_IFC, GPIO	; clear PA0 IF
	PUT	0x01, GPIO_IEN		; enable interrupt on PA0
	pop	{PC}
	ENDP

	ALIGN
	END	