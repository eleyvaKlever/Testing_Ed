	INCLUDE TG110F32.inc		; CPU register definitions
	EXPORT	start

	IMPORT	CMU_setup
	IMPORT	LETIMER0_setup
	IMPORT	GPIO_setup
	IMPORT	USART_setup
	IMPORT	SI4461_setup
	IMPORT 	Send_SI4461		
	IMPORT	SPIbuf	

	PRESERVE8
	THUMB				; use thumb instruction set
	AREA    |.text|, CODE, READONLY
;----------------------------------------------------------------------------
start	PROC				; main user code		
	bl	CMU_setup		; configure clock
	bl	GPIO_setup		; configure GPIO ports		
	bl	USART_setup		; configure SPI module	
	bl	SI4461_setup		; configure radio		
	bl	LETIMER0_setup		; configure LETIMER
		
	movs	R7, #0			; init package number
loop					; MAIN LOOP	
	PUT	SLEEPDEEP, 0, SCB_SCR 	; enable deep sleep mode
	wfi				; enter deep sleep mode
	nop				; wake-up by LETIMER0

	bl	Send_Package		; compose and send out package
	add	R7, #1			; update package number

	b	loop
	ENDP

;-----------------------------------------------------------------------
Send_Package	PROC
	push	{LR}
	ldr	R11, =SPIbuf		; compose package
	movw	R1, #0x6607		
	movt	R1, #0x0005
	str	R1, [R11]
	movw	R1, #0x4241
	movt	R1, #0x4443
	str	R1, [R11, #4]
	strb	R7, [R11, #3]		; add package number	
	bl	Send_SI4461		; load package in TX FIFO
	
	ldr	R11, =SPIbuf
	movw	R1, #0x3105		; start TX
	movt	R1, #0x1000
	str	R1, [R11]
	movw	R1, #0
	strh	R1, [R11, #4]	
	bl	Send_SI4461
	pop	{PC}
	ENDP

	ALIGN
	END	