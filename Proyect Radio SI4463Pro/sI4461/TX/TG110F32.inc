; Peripheral base addresses
AES		EQU	0x400E0000	; Advanced Encryption Standard 
PRS		EQU	0x400CC000	; Peripheral Reflex System
RMU		EQU	0x400CA000 	; Reset Management Unit
CMU		EQU	0x400C8000	; Clock Management Unit
EMU		EQU	0x400C6000	; Energy Management Unit
DMA		EQU	0x400C2000 	; Direct Memory Access 
MSC		EQU	0x400C0000	; Memory System Controller
LESENSE		EQU	0x4008C000 	; Low Enegry Sensor Interface
LCD		EQU	0x4008A000 	; Liquid Crystal Display
WDOG		EQU	0x40088000 	; Watchdog Timer
PCNT0		EQU	0x40086000	; Pulse Counter
LEUART0		EQU	0x40084000 	; Low Enegry UART
LETIMER0	EQU	0x40082000 	; Low Energy Timer
RTC		EQU	0x40080000 	; Real Time Clock
TIMER1		EQU	0x40010400 	; TIMER1 module
TIMER0		EQU	0x40010000 	; TIMER0 module
USART1		EQU	0x4000C400 	; USART1 module
USART0		EQU	0x4000C000 	; USART0 module
I2C0		EQU	0x4000A000 	; I2C module
GPIO		EQU	0x40006000 	; GPIO module
DAC0		EQU	0x40004000 	; DAC module
ADC0		EQU	0x40002000 	; ADC module
ACMP1		EQU	0x40001400 	; Analog comparator 1
ACMP0		EQU	0x40001000 	; Analog Comparator 0
VCMP		EQU	0x40000000 	; Voltage Comparator

;-------- CMU registers --------------------------------------------------------------------
CMU_CTRL	EQU	0x000		; CMU Control Register
CMU_HFCORECLKDIV EQU 	0x004		; High Frequency Core Clock Division Register
CMU_HFPERCLKDIV	EQU	0x008		; High Frequency Peripheral Clock Division Register
CMU_HFRCOCTRL	EQU	0x00C  		; HFRCO Control Register
CMU_LFRCOCTRL	EQU	0x010 		; LFRCO Control Register
CMU_AUXHFRCOCTRL EQU	0x014 		; AUXHFRCO Control Register
CMU_CALCTRL	EQU	0x018 		; Calibration Control Register
CMU_CALCNT	EQU	0x01C		; Calibration Counter Register
CMU_OSCENCMD	EQU	0x020 		; Oscillator Enable/Disable Command Register
CMU_CMD		EQU	0x024 		; Command Register
CMU_LFCLKSEL	EQU	0x028 		; Low Frequency Clock Select Register
CMU_STATUS	EQU	0x02C 		; Status Register
CMU_IF		EQU	0x030 		; Interrupt Flag Register
CMU_IFS		EQU	0x034 		; Interrupt Flag Set Register
CMU_IFC 	EQU	0x038 		; Interrupt Flag Clear Register
CMU_IEN 	EQU	0x03C 		; Interrupt Enable Register
CMU_HFCORECLKEN0 EQU	0x040 		; High Frequency Core Clock Enable Register 0
CMU_HFPERCLKEN0	EQU	0x044 		; High Frequency Peripheral Clock Enable Register 0
CMU_SYNCBUSY 	EQU	0x050 		; Synchronization Busy Register
CMU_FREEZE	EQU	0x054 		; Freeze Register
CMU_LFACLKEN0	EQU	0x058 		; Low Frequency A Clock Enable Register 0 (Async Reg)
CMU_LFBCLKEN0	EQU	0x060 		; Low Frequency B Clock Enable Register 0 (Async Reg)
CMU_LFAPRESC0 	EQU	0x068 		; Low Frequency A Prescaler Register 0 (Async Reg)
CMU_LFBPRESC0	EQU	0x070 		; Low Frequency B Prescaler Register 0 (Async Reg)
CMU_PCNTCTRL	EQU	0x078 		; PCNT Control Register
CMU_LCDCTRL	EQU	0x07C 		; LCD Control Register
CMU_ROUTE	EQU	0x080 		; I/O Routing Register
CMU_LOCK	EQU	0x084 		; Configuration Lock Register

;-------- LETIMER0 registers -----------------------------------------------------------------
LETIMERn_CTRL	EQU	0x000		; Control Register
LETIMERn_CMD	EQU	0x004 		; Command Register
LETIMERn_STATUS	EQU	0x008  		; Status Register
LETIMERn_CNT	EQU	0x00C 		; Counter Value Register
LETIMERn_COMP0	EQU	0x010 		; Compare Value Register 0
LETIMERn_COMP1	EQU	0x014  		; Compare Value Register 1
LETIMERn_REP0	EQU	0x018  		; Repeat Counter Register 0
LETIMERn_REP1	EQU	0x01C  		; Repeat Counter Register 1
LETIMERn_IF	EQU	0x020  		; Interrupt Flag Register
LETIMERn_IFS	EQU	0x024  		; Interrupt Flag Set Register
LETIMERn_IFC	EQU	0x028  		; Interrupt Flag Clear Register
LETIMERn_IEN	EQU	0x02C  		; Interrupt Enable Register
LETIMERn_FREEZE	EQU	0x030  		; Freeze Register
LETIMERn_SYNCBUSY EQU	0x034  		; Synchronization Busy Register
LETIMERn_ROUTE	EQU	0x040  		; I/O Routing Register

;-------- I2C registers -----------------------------------------------------------------------
I2Cn_CTRL 	EQU	0x000  		; Control Register
I2Cn_CMD 	EQU	0x004   	; Command Register
I2Cn_STATE 	EQU	0x008  		; State Register
I2Cn_STATUS 	EQU	0x00C  		; Status Register
I2Cn_CLKDIV 	EQU	0x010  		; Clock Division Register
I2Cn_SADDR 	EQU	0x014  		; Slave Address Register
I2Cn_SADDRMASK	EQU	0x018  		; Slave Address Mask Register
I2Cn_RXDATA 	EQU	0x01C  		; Receive Buffer Data Register
I2Cn_RXDATAP 	EQU	0x020  		; Receive Buffer Data Peek Register
I2Cn_TXDATA 	EQU	0x024  		; Transmit Buffer Data Register
I2Cn_IF 	EQU	0x028  		; Interrupt Flag Register
I2Cn_IFS 	EQU	0x02C  		; Interrupt Flag Set Register
I2Cn_IFC 	EQU	0x030  		; Interrupt Flag Clear Register
I2Cn_IEN 	EQU	0x034  		; Interrupt Enable Register
I2Cn_ROUTE 	EQU	0x038  		; I/O Routing Register

;-------- USART REGISTERS ---------------------------------------------------------------------
USARTn_CTRL 	EQU	0x000   	; Control Register
USARTn_FRAME 	EQU	0x004   	; USART Frame Format Register
USARTn_TRIGCTRL EQU	0x008 		; USART Trigger Control register
USARTn_CMD 	EQU	0x00C 		; Command Register
USARTn_STATUS 	EQU	0x010  		; USART Status Register
USARTn_CLKDIV 	EQU	0x014   	; Clock Control Register
USARTn_RXDATAX 	EQU	0x018   	; RX Buffer Data Extended Register
USARTn_RXDATA 	EQU	0x01C   	; RX Buffer Data Register
USARTn_RXDOUBLEX EQU	0x020   	; RX Buffer Double Data Extended Register
USARTn_RXDOUBLE EQU	0x024   	; RX FIFO Double Data Register
USARTn_RXDATAXP EQU	0x028   	; RX Buffer Data Extended Peek Register
USARTn_RXDOUBLEXP EQU	0x02C   	; RX Buffer Double Data Extended Peek Register
USARTn_TXDATAX 	EQU	0x030   	; TX Buffer Data Extended Register
USARTn_TXDATA 	EQU	0x034   	; TX Buffer Data Register
USARTn_TXDOUBLEX EQU	0x038   	; TX Buffer Double Data Extended Register
USARTn_TXDOUBLE EQU	0x03C   	; TX Buffer Double Data Register
USARTn_IF 	EQU	0x040   	; Interrupt Flag Register
USARTn_IFS 	EQU	0x044   	; Interrupt Flag Set Register
USARTn_IFC 	EQU	0x048   	; Interrupt Flag Clear Register
USARTn_IEN 	EQU	0x04C   	; Interrupt Enable Register
USARTn_IRCTRL 	EQU	0x050   	; IrDA Control Register
USARTn_ROUTE 	EQU	0x054   	; I/O Routing Register
USARTn_INPUT 	EQU	0x058   	; USART Input Register
USARTn_I2SCTRL 	EQU	0x05C   	; I2S Control Register

;-------- GPIO registers ---------------------------------------------------------------------
GPIO_PA_CTRL	EQU	0x000  		; Port Control Register
GPIO_PA_MODEL	EQU	0x004  		; Port Pin Mode Low Register
GPIO_PA_MODEH	EQU	0x008  		; Port Pin Mode High Register
GPIO_PA_DOUT	EQU	0x00C   	; Port Data Out Register
GPIO_PA_DOUTSET	EQU	0x010  		; Port Data Out Set Register
GPIO_PA_DOUTCLR	EQU	0x014   	; Port Data Out Clear Register
GPIO_PA_DOUTTGL	EQU	0x018   	; Port Data Out Toggle Register
GPIO_PA_DIN	EQU	0x01C   	; Port Data In Register
GPIO_PA_PINLOCKN EQU	0x020   	; Port Unlocked Pins Register
GPIO_PB_CTRL	EQU	0x024   	; Port Control Register
GPIO_PB_MODEL	EQU	0x028   	; Port Pin Mode Low Register
GPIO_PB_MODEH	EQU	0x02C   	; Port Pin Mode High Register
GPIO_PB_DOUT	EQU	0x030   	; Port Data Out Register
GPIO_PB_DOUTSET	EQU	0x034   	; Port Data Out Set Register
GPIO_PB_DOUTCLR	EQU	0x038   	; Port Data Out Clear Register
GPIO_PB_DOUTTGL	EQU	0x03C   	; Port Data Out Toggle Register
GPIO_PB_DIN	EQU	0x040   	; Port Data In Register
GPIO_PB_PINLOCKN EQU	0x044   	; Port Unlocked Pins Register
GPIO_PC_CTRL	EQU	0x048   	; Port Control Register
GPIO_PC_MODEL	EQU	0x04C   	; Port Pin Mode Low Register
GPIO_PC_MODEH	EQU	0x050   	; Port Pin Mode High Register
GPIO_PC_DOUT	EQU	0x054   	; Port Data Out Register
GPIO_PC_DOUTSET	EQU	0x058   	; Port Data Out Set Register
GPIO_PC_DOUTCLR	EQU	0x05C   	; Port Data Out Clear Register
GPIO_PC_DOUTTGL	EQU	0x060   	; Port Data Out Toggle Register
GPIO_PC_DIN	EQU	0x064   	; Port Data In Register
GPIO_PC_PINLOCKN EQU	0x068   	; Port Unlocked Pins Register
GPIO_PD_CTRL	EQU	0x06C   	; Port Control Register
GPIO_PD_MODEL	EQU	0x070   	; Port Pin Mode Low Register
GPIO_PD_MODEH	EQU	0x074   	; Port Pin Mode High Register
GPIO_PD_DOUT	EQU	0x078   	; Port Data Out Register
GPIO_PD_DOUTSET	EQU	0x07C   	; Port Data Out Set Register
GPIO_PD_DOUTCLR	EQU	0x080   	; Port Data Out Clear Register
GPIO_PD_DOUTTGL	EQU	0x084   	; Port Data Out Toggle Register
GPIO_PD_DIN	EQU	0x088   	; Port Data In Register
GPIO_PD_PINLOCKN EQU	0x08C   	; Port Unlocked Pins Register
GPIO_PE_CTRL	EQU	0x090   	; Port Control Register
GPIO_PE_MODEL	EQU	0x094   	; Port Pin Mode Low Register
GPIO_PE_MODEH	EQU	0x098   	; Port Pin Mode High Register
GPIO_PE_DOUT	EQU	0x09C   	; Port Data Out Register
GPIO_PE_DOUTSET	EQU	0x0A0   	; Port Data Out Set Register
GPIO_PE_DOUTCLR	EQU	0x0A4   	; Port Data Out Clear Register
GPIO_PE_DOUTTGL	EQU	0x0A8   	; Port Data Out Toggle Register
GPIO_PE_DIN	EQU	0x0AC   	; Port Data In Register
GPIO_PE_PINLOCKN EQU	0x0B0   	; Port Unlocked Pins Register
GPIO_PF_CTRL	EQU	0x0B4   	; Port Control Register
GPIO_PF_MODEL	EQU	0x0B8   	; Port Pin Mode Low Register
GPIO_PF_MODEH	EQU	0x0BC   	; Port Pin Mode High Register
GPIO_PF_DOUT	EQU	0x0C0   	; Port Data Out Register
GPIO_PF_DOUTSET	EQU	0x0C4   	; Port Data Out Set Register
GPIO_PF_DOUTCLR	EQU	0x0C8   	; Port Data Out Clear Register
GPIO_PF_DOUTTGL	EQU	0x0CC   	; Port Data Out Toggle Register
GPIO_PF_DIN	EQU	0x0D0   	; Port Data In Register
GPIO_PF_PINLOCKN EQU	0x0D4   	; Port Unlocked Pins Register
GPIO_EXTIPSELL	EQU	0x100   	; External Interrupt Port Select Low Register
GPIO_EXTIPSELH	EQU	0x104   	; External Interrupt Port Select High Register
GPIO_EXTIRISE	EQU	0x108   	; External Interrupt Rising Edge Trigger Register
GPIO_EXTIFALL	EQU	0x10C   	; External Interrupt Falling Edge Trigger Register
GPIO_IEN	EQU	0x110   	; Interrupt Enable Register
GPIO_IF		EQU	0x114   	; Interrupt Flag Register
GPIO_IFS	EQU	0x118   	; Interrupt Flag Set Register
GPIO_IFC	EQU	0x11C   	; Interrupt Flag Clear Register
GPIO_ROUTE	EQU	0x120   	; I/O Routing Register
GPIO_INSENSE	EQU	0x124   	; Input Sense Register
GPIO_LOCK	EQU	0x128   	; Configuration Lock Register
GPIO_CTRL	EQU	0x12C   	; GPIO Control Register
GPIO_CMD	EQU	0x130   	; EM4 Wake-up Clear Register
GPIO_EM4WUEN	EQU	0x134   	; EM4 Wake-up Enable Register
GPIO_EM4WUPOL	EQU	0x138   	; EM4 Wake-up Polarity Register
GPIO_EM4WUCAUSE	EQU	0x13C   	; EM4 Wake-up Cause Register

;-------- DMA registers ----------------------------------------------------------------------
DMA_STATUS 	EQU	0x000 		; DMA Status Registers
DMA_CONFIG 	EQU	0x004 		; DMA Configuration Register
DMA_CTRLBASE 	EQU	0x008 		; Channel Control Data Base Pointer Register
DMA_ALTCTRLBASE EQU	0x00C 		; Channel Alternate Control Data Base Pointer Register
DMA_CHWAITSTATUS EQU	0x010  		; Channel Wait on Request Status Register
DMA_CHSWREQ 	EQU	0x014  		; Channel Software Request Register
DMA_CHUSEBURSTS EQU	0x018 		; Channel Useburst Set Register
DMA_CHUSEBURSTC EQU	0x01C 		; Channel Useburst Clear Register
DMA_CHREQMASKS 	EQU	0x020 		; Channel Request Mask Set Register
DMA_CHREQMASKC 	EQU	0x024 		; Channel Request Mask Clear Register
DMA_CHENS 	EQU	0x028 		; Channel Enable Set Register
DMA_CHENC 	EQU	0x02C 		; Channel Enable Clear Register
DMA_CHALTS 	EQU	0x030 		; Channel Alternate Set Register
DMA_CHALTC 	EQU	0x034 		; Channel Alternate Clear Register
DMA_CHPRIS 	EQU	0x038 		; Channel Priority Set Register
DMA_CHPRIC 	EQU	0x03C 		; Channel Priority Clear Register
DMA_ERRORC 	EQU	0x04C 		; Bus Error Clear Register
DMA_CHREQSTATUS EQU	0xE10 		; Channel Request Status
DMA_CHSREQSTATUS EQU	0xE18 		; Channel Single Request Status
DMA_IF 		EQU	0x1000 		; Interrupt Flag Register
DMA_IFS 	EQU	0x1004 		; Interrupt Flag Set Register
DMA_IFC 	EQU	0x1008 		; Interrupt Flag Clear Register
DMA_IEN 	EQU	0x100C 		; Interrupt Enable register
DMA_CH0_CTRL 	EQU	0x1100 		; Channel Control Register
DMA_CH1_CTRL 	EQU	0x1104 		; Channel Control Register
DMA_CH2_CTRL 	EQU	0x1108 		; Channel Control Register
DMA_CH3_CTRL 	EQU	0x110C 		; Channel Control Register
DMA_CH4_CTRL 	EQU	0x1110 		; Channel Control Register
DMA_CH5_CTRL 	EQU	0x1114 		; Channel Control Register
DMA_CH6_CTRL 	EQU	0x1118 		; Channel Control Register
DMA_CH7_CTRL 	EQU	0x111C 		; Channel Control Register

;-------- ARM Core registers -----------------------------------------------------------------
NVIC_ISER	EQU	0xE000E100	; NVIC SETENA
NVIC_ICER	EQU	0xE000E180	; NVIC CLRENA
NVIC_ISPR	EQU	0xE000E200	; NVIC SETPEND
NVIC_ICPR	EQU	0xE000E280	; NVIC CLRPEND

SCB_SCR		EQU	0xE000ED10	; System Control Register
SLEEPDEEP	EQU	0x04		; bits in System Control Register
SLEEPONEXIT	EQU	0x02

	MACRO				; store data in a given register
	PUT	$wdata, $reg, $base
	IF	"$base" <> "" 
	ldr	R0, =$base
	ENDIF
	IF	$wdata <= 0xFF
	movs	R1, #$wdata
	ELIF	$wdata <= 0xFFFF
	movw	R1, #$wdata
	ELSE
	ldr	R1, =$wdata
	ENDIF
	str	R1, [R0, #$reg]
	MEND

	MACRO
	READ	$reg, $base
	IF	"$base" <> "" 
	ldr	R0, =$base
	ENDIF
	ldr	R1, [R0, #$reg]
	MEND

	MACRO				; set bit at given peripheral address
	SETbit	$addr, $bit
	ldr	R0, =(0x42000000 + ($addr - 0x40000000) + $bit*4)
	movs	R1, #1
	str	R1, [R0]
	MEND

	END