
_InitTimer0:

;main.c,115 :: 		void InitTimer0()
;main.c,117 :: 		T0CON  = 0x85;
	MOVLW       133
	MOVWF       T0CON+0 
;main.c,118 :: 		TMR0H  = 0x48;
	MOVLW       72
	MOVWF       TMR0H+0 
;main.c,119 :: 		TMR0L  = 0xE5;
	MOVLW       229
	MOVWF       TMR0L+0 
;main.c,120 :: 		GIE_bit    = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;main.c,121 :: 		TMR0IE_bit     = 1;
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;main.c,122 :: 		}
L_end_InitTimer0:
	RETURN      0
; end of _InitTimer0

_interrupt:

;main.c,127 :: 		void interrupt ()  {
;main.c,129 :: 		if (TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
	GOTO        L_interrupt0
;main.c,130 :: 		TMR0IF_bit = 0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;main.c,131 :: 		TMR0H    = 0x48;
	MOVLW       72
	MOVWF       TMR0H+0 
;main.c,132 :: 		TMR0L    = 0xE5;
	MOVLW       229
	MOVWF       TMR0L+0 
;main.c,133 :: 		LATD.B0    =~ LATD.B0;  //Version Nueva
	BTG         LATD+0, 0 
;main.c,134 :: 		}
L_interrupt0:
;main.c,136 :: 		}
L_end_interrupt:
L__interrupt33:
	RETFIE      1
; end of _interrupt

_Init_Hardware:

;main.c,164 :: 		void Init_Hardware(void)
;main.c,167 :: 		GIE_bit     = 1;                    // Enable Global interrupt
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;main.c,168 :: 		PEIE_bit    = 1;                    // Enable Peripheral interrupt
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;main.c,169 :: 		TMR0IE_bit  = 1;                    // Enable Timer0 interrupt
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;main.c,170 :: 		TMR0IP_bit  = 1;                    // Overflow Interrupt Proirity bit
	BSF         TMR0IP_bit+0, BitPos(TMR0IP_bit+0) 
;main.c,172 :: 		InitTimer0();                       // Activo el timer del Led que indica que esta trabajando todo el sistema
	CALL        _InitTimer0+0, 0
;main.c,174 :: 		Sound_Init(&PORTC, 2);              // Declaro el puerto de salida para el sonido o buzzer
	MOVLW       PORTC+0
	MOVWF       FARG_Sound_Init_snd_port+0 
	MOVLW       hi_addr(PORTC+0)
	MOVWF       FARG_Sound_Init_snd_port+1 
	MOVLW       2
	MOVWF       FARG_Sound_Init_snd_pin+0 
	CALL        _Sound_Init+0, 0
;main.c,180 :: 		UART1_Init(115200);                 // Initialize UART module at 115200
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       173
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;main.c,182 :: 		LATC.B2 = 0;                        // Pongo el Pin en 0 para evitar que se caliente el driver del Buzzer
	BCF         LATC+0, 2 
;main.c,183 :: 		}
L_end_Init_Hardware:
	RETURN      0
; end of _Init_Hardware

_main:

;main.c,197 :: 		void main()
;main.c,199 :: 		ANSELA = 0B00000000;   // Puertos Digitales o Analogicos   x--x--0--x--0--0--0--0 --> 1 Analogico , 0 Digitales , x No aplica ANSELA(0,1,2,3,5)
	CLRF        ANSELA+0 
;main.c,200 :: 		ANSELB = 0B00000000;   // Puertos Digitales o Analogicos   x--x--0--0--0--0--0--0 --> 1 Analogico , 0 Digitales , x No aplica ANSELB(0,1,2,3,4,5)
	CLRF        ANSELB+0 
;main.c,201 :: 		ANSELC = 0B00000000;   // Puertos Digitales o Analogicos   0--0--0--0--0--0--x--x --> 1 Analogico , 0 Digitales , x No aplica ANSELC(3,4,5,6,7)
	CLRF        ANSELC+0 
;main.c,202 :: 		ANSELD = 0B00000000;   // Puertos Digitales o Analogicos   0--0--0--0--0--0--x--x --> 1 Analogico , 0 Digitales , x No aplica ANSELC(3,4,5,6,7)
	CLRF        ANSELD+0 
;main.c,203 :: 		ANSELE = 0B00000000;   // Puertos Digitales o Analogicos   0--0--0--0--0--0--x--x --> 1 Analogico , 0 Digitales , x No aplica ANSELC(3,4,5,6,7)
	CLRF        ANSELE+0 
;main.c,204 :: 		ADCON1 = 0B00000000;   // Voltaje de Ref. a VDD y VSS      0--X--X--X--0--0--0--0 --> 0 VDD, 0 VSS Voltaje de Referencia.
	CLRF        ADCON1+0 
;main.c,205 :: 		ADCON2 = 0B10101111;   // Tiempo de Adqu. Datos 20TD       0--X--X--X--0--0--0--0 --> Tiempo de muestreo de datos
	MOVLW       175
	MOVWF       ADCON2+0 
;main.c,208 :: 		TRISA  = 0B00000000;   // Puertos Entrada o Salida         0--0--0--0--0--0--0--0 --> 0 Salida 1 Entrada
	CLRF        TRISA+0 
;main.c,209 :: 		TRISB  = 0B00010000;   // Puertos Entrada o Salida         0--0--0--0--0--0--0--0 --> 0 Salida 1 Entrada
	MOVLW       16
	MOVWF       TRISB+0 
;main.c,210 :: 		TRISC  = 0B01010000;   // Puertos Entrada o Salida         0--0--0--0--0--0--0--0 --> 0 Salida 1 Entrada
	MOVLW       80
	MOVWF       TRISC+0 
;main.c,211 :: 		TRISD  = 0B00000000;   // Puertos Entrada o Salida         0--0--0--0--0--0--0--0 --> 0 Salida 1 Entrada
	CLRF        TRISD+0 
;main.c,212 :: 		TRISE  = 0B00000000;   // Puertos Entrada o Salida         0--0--0--0--0--0--0--0 --> 0 Salida 1 Entrada
	CLRF        TRISE+0 
;main.c,214 :: 		PORTA  = 0B00000000;   // Borro el puerto por si hay basura
	CLRF        PORTA+0 
;main.c,215 :: 		PORTB  = 0B00000000;   // Borro el puerto por si hay basura
	CLRF        PORTB+0 
;main.c,216 :: 		PORTC  = 0B00000000;   // Borro el puerto por si hay basura
	CLRF        PORTC+0 
;main.c,217 :: 		PORTD  = 0B00000000;   // Borro el puerto por si hay basura
	CLRF        PORTD+0 
;main.c,218 :: 		PORTE  = 0B00000000;   // Borro el puerto por si hay basura
	CLRF        PORTE+0 
;main.c,221 :: 		Init_Hardware();
	CALL        _Init_Hardware+0, 0
;main.c,223 :: 		Delay_ms(800);                            // Le doy un tiempo para evitar inestabilidad de configuracon
	MOVLW       82
	MOVWF       R11, 0
	MOVLW       43
	MOVWF       R12, 0
	MOVLW       0
	MOVWF       R13, 0
L_main1:
	DECFSZ      R13, 1, 1
	BRA         L_main1
	DECFSZ      R12, 1, 1
	BRA         L_main1
	DECFSZ      R11, 1, 1
	BRA         L_main1
	NOP
;main.c,224 :: 		Tone3();                                  // Hago un tono de inicializacion
	CALL        _Tone3+0, 0
;main.c,225 :: 		Delay_ms(100);                            // Le doy un tiempo para el sonido
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
	NOP
;main.c,226 :: 		Tone3();                                  // Hago un tono de inicializacion
	CALL        _Tone3+0, 0
;main.c,228 :: 		UART1_Write_Text( "START RADIO SI4463PRO\n\r" );
	MOVLW       ?ICS?lstr1_main+0
	MOVWF       TBLPTRL+0 
	MOVLW       hi_addr(?ICS?lstr1_main+0)
	MOVWF       TBLPTRL+1 
	MOVLW       higher_addr(?ICS?lstr1_main+0)
	MOVWF       TBLPTRL+2 
	MOVLW       ?lstr1_main+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(?lstr1_main+0)
	MOVWF       FSR1L+1 
	MOVLW       24
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr1_main+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_main+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;main.c,230 :: 		Delay_ms(50);                             // Retardo por seguridad de lectura
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
	NOP
;main.c,232 :: 		sdn_reset();// reset RF
	CALL        _sdn_reset+0, 0
;main.c,234 :: 		SI4463_init();  // RF INIT
	CALL        _SI4463_init+0, 0
;main.c,236 :: 		while(1)                                  // Loop principal
L_main4:
;main.c,241 :: 		}
	GOTO        L_main4
;main.c,242 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_Tone1:

;main.c,247 :: 		void Tone1() {                          // Rutina de Tono sw 4500 Hz
;main.c,248 :: 		Sound_Play(4500, 250);                // Frequency = 4500Hz, duration = 250ms
	MOVLW       148
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       17
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       250
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;main.c,249 :: 		LATC.B2 = 0;                          // Seteo el pin a Bajo para no activar el transistor del buzzer y se caliente.
	BCF         LATC+0, 2 
;main.c,250 :: 		}
L_end_Tone1:
	RETURN      0
; end of _Tone1

_Tone2:

;main.c,251 :: 		void Tone2() {                          // // Rutina de Tono sw 1300 Hz
;main.c,252 :: 		Sound_Play(1300, 250);                // Frequency = 1300Hz, duration = 250ms
	MOVLW       20
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       5
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       250
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;main.c,253 :: 		LATC.B2 = 0;                          // Seteo el pin a Bajo para no activar el transistor del buzzer y se caliente.
	BCF         LATC+0, 2 
;main.c,254 :: 		}
L_end_Tone2:
	RETURN      0
; end of _Tone2

_Tone3:

;main.c,255 :: 		void Tone3() {                          // Rutina de Tono sw 800 Hz
;main.c,256 :: 		Sound_Play(1000, 250);                 // Frequency = 800Hz, duration = 250ms
	MOVLW       232
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       3
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       250
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;main.c,257 :: 		LATC.B2 = 0;                          // Seteo el pin a Bajo para no activar el transistor del buzzer y se caliente.
	BCF         LATC+0, 2 
;main.c,258 :: 		}
L_end_Tone3:
	RETURN      0
; end of _Tone3

_SI4463_init:

;main.c,271 :: 		void SI4463_init(void)
;main.c,275 :: 		app_command_buf[0] = 0x13;          // SET GPIO PORT
	MOVLW       19
	MOVWF       SI4463_init_app_command_buf_L0+0 
;main.c,276 :: 		app_command_buf[1]  = 0x14;         // gpio 0 ,Rx data
	MOVLW       20
	MOVWF       SI4463_init_app_command_buf_L0+1 
;main.c,277 :: 		app_command_buf[2]  = 0x02;         // gpio1, output 0
	MOVLW       2
	MOVWF       SI4463_init_app_command_buf_L0+2 
;main.c,278 :: 		app_command_buf[3]  = 0x21;         // gpio2, hign while in receive mode
	MOVLW       33
	MOVWF       SI4463_init_app_command_buf_L0+3 
;main.c,279 :: 		app_command_buf[4]  = 0x20;         // gpio3, hign while in transmit mode
	MOVLW       32
	MOVWF       SI4463_init_app_command_buf_L0+4 
;main.c,280 :: 		app_command_buf[5]  = 0x27;         // nIRQ
	MOVLW       39
	MOVWF       SI4463_init_app_command_buf_L0+5 
;main.c,281 :: 		app_command_buf[6]  = 0x0b;         // sdo
	MOVLW       11
	MOVWF       SI4463_init_app_command_buf_L0+6 
;main.c,282 :: 		spi_write(7, app_command_buf);
	MOVLW       7
	MOVWF       FARG_spi_write_tx_length+0 
	MOVLW       SI4463_init_app_command_buf_L0+0
	MOVWF       FARG_spi_write_p+0 
	MOVLW       hi_addr(SI4463_init_app_command_buf_L0+0)
	MOVWF       FARG_spi_write_p+1 
	CALL        _spi_write+0, 0
;main.c,285 :: 		app_command_buf[0] = 0x11;
	MOVLW       17
	MOVWF       SI4463_init_app_command_buf_L0+0 
;main.c,286 :: 		app_command_buf[1]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+1 
;main.c,287 :: 		app_command_buf[2]  = 0x01;
	MOVLW       1
	MOVWF       SI4463_init_app_command_buf_L0+2 
;main.c,288 :: 		app_command_buf[3]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+3 
;main.c,289 :: 		app_command_buf[4]  = 98;           // freq  adjustment
	MOVLW       98
	MOVWF       SI4463_init_app_command_buf_L0+4 
;main.c,290 :: 		spi_write(5, app_command_buf);
	MOVLW       5
	MOVWF       FARG_spi_write_tx_length+0 
	MOVLW       SI4463_init_app_command_buf_L0+0
	MOVWF       FARG_spi_write_p+0 
	MOVLW       hi_addr(SI4463_init_app_command_buf_L0+0)
	MOVWF       FARG_spi_write_p+1 
	CALL        _spi_write+0, 0
;main.c,293 :: 		app_command_buf[0] = 0x11;
	MOVLW       17
	MOVWF       SI4463_init_app_command_buf_L0+0 
;main.c,294 :: 		app_command_buf[1]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+1 
;main.c,295 :: 		app_command_buf[2]  = 0x01;
	MOVLW       1
	MOVWF       SI4463_init_app_command_buf_L0+2 
;main.c,296 :: 		app_command_buf[3]  = 0x03;
	MOVLW       3
	MOVWF       SI4463_init_app_command_buf_L0+3 
;main.c,297 :: 		app_command_buf[4]  = 0x40;         // tx = rx = 64 byte,PH,high performance mode
	MOVLW       64
	MOVWF       SI4463_init_app_command_buf_L0+4 
;main.c,298 :: 		spi_write(5, app_command_buf);
	MOVLW       5
	MOVWF       FARG_spi_write_tx_length+0 
	MOVLW       SI4463_init_app_command_buf_L0+0
	MOVWF       FARG_spi_write_p+0 
	MOVLW       hi_addr(SI4463_init_app_command_buf_L0+0)
	MOVWF       FARG_spi_write_p+1 
	CALL        _spi_write+0, 0
;main.c,300 :: 		spi_write(8, RF_FRR_CTL_A_MODE_4_data);    // disable all fast response register
	MOVLW       8
	MOVWF       FARG_spi_write_tx_length+0 
	MOVLW       _RF_FRR_CTL_A_MODE_4_data+0
	MOVWF       FARG_spi_write_p+0 
	MOVLW       hi_addr(_RF_FRR_CTL_A_MODE_4_data+0)
	MOVWF       FARG_spi_write_p+1 
	CALL        _spi_write+0, 0
;main.c,303 :: 		app_command_buf[0] = 0x11;
	MOVLW       17
	MOVWF       SI4463_init_app_command_buf_L0+0 
;main.c,304 :: 		app_command_buf[1]  = 0x10;
	MOVLW       16
	MOVWF       SI4463_init_app_command_buf_L0+1 
;main.c,305 :: 		app_command_buf[2]  = 0x09;
	MOVLW       9
	MOVWF       SI4463_init_app_command_buf_L0+2 
;main.c,306 :: 		app_command_buf[3]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+3 
;main.c,307 :: 		app_command_buf[4]  = 0x08;                         //  8 bytes Preamble
	MOVLW       8
	MOVWF       SI4463_init_app_command_buf_L0+4 
;main.c,308 :: 		app_command_buf[5]  = 0x14;                         //  detect 20 bits
	MOVLW       20
	MOVWF       SI4463_init_app_command_buf_L0+5 
;main.c,309 :: 		app_command_buf[6]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+6 
;main.c,310 :: 		app_command_buf[7]  = 0x0f;
	MOVLW       15
	MOVWF       SI4463_init_app_command_buf_L0+7 
;main.c,311 :: 		app_command_buf[8]  = 0x31;                         //  no manchest.1010.¡£¡£
	MOVLW       49
	MOVWF       SI4463_init_app_command_buf_L0+8 
;main.c,312 :: 		app_command_buf[9]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+9 
;main.c,313 :: 		app_command_buf[10]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+10 
;main.c,314 :: 		app_command_buf[11]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+11 
;main.c,315 :: 		app_command_buf[12]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+12 
;main.c,316 :: 		spi_write(13, app_command_buf);
	MOVLW       13
	MOVWF       FARG_spi_write_tx_length+0 
	MOVLW       SI4463_init_app_command_buf_L0+0
	MOVWF       FARG_spi_write_p+0 
	MOVLW       hi_addr(SI4463_init_app_command_buf_L0+0)
	MOVWF       FARG_spi_write_p+1 
	CALL        _spi_write+0, 0
;main.c,319 :: 		app_command_buf[0] = 0x11;
	MOVLW       17
	MOVWF       SI4463_init_app_command_buf_L0+0 
;main.c,320 :: 		app_command_buf[1]  = 0x11;
	MOVLW       17
	MOVWF       SI4463_init_app_command_buf_L0+1 
;main.c,321 :: 		app_command_buf[2]  = 0x05;
	MOVLW       5
	MOVWF       SI4463_init_app_command_buf_L0+2 
;main.c,322 :: 		app_command_buf[3]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+3 
;main.c,323 :: 		app_command_buf[4]  = 0x01;                         // no manchest , 2 bytes
	MOVLW       1
	MOVWF       SI4463_init_app_command_buf_L0+4 
;main.c,324 :: 		app_command_buf[5]  = 0x2d;                         // sync byte3
	MOVLW       45
	MOVWF       SI4463_init_app_command_buf_L0+5 
;main.c,325 :: 		app_command_buf[6]  = 0xd4;                         // sync byte2
	MOVLW       212
	MOVWF       SI4463_init_app_command_buf_L0+6 
;main.c,326 :: 		app_command_buf[7]  = 0x00;                         // sync byte1
	CLRF        SI4463_init_app_command_buf_L0+7 
;main.c,327 :: 		app_command_buf[8]  = 0x00;                         // sync byte0
	CLRF        SI4463_init_app_command_buf_L0+8 
;main.c,328 :: 		spi_write(9, app_command_buf);
	MOVLW       9
	MOVWF       FARG_spi_write_tx_length+0 
	MOVLW       SI4463_init_app_command_buf_L0+0
	MOVWF       FARG_spi_write_p+0 
	MOVLW       hi_addr(SI4463_init_app_command_buf_L0+0)
	MOVWF       FARG_spi_write_p+1 
	CALL        _spi_write+0, 0
;main.c,331 :: 		app_command_buf[0] = 0x11;
	MOVLW       17
	MOVWF       SI4463_init_app_command_buf_L0+0 
;main.c,332 :: 		app_command_buf[1]  = 0x12;
	MOVLW       18
	MOVWF       SI4463_init_app_command_buf_L0+1 
;main.c,333 :: 		app_command_buf[2]  = 0x01;
	MOVLW       1
	MOVWF       SI4463_init_app_command_buf_L0+2 
;main.c,334 :: 		app_command_buf[3]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+3 
;main.c,335 :: 		app_command_buf[4]  = 0x81;                         // CRC = itu-c, enable crc
	MOVLW       129
	MOVWF       SI4463_init_app_command_buf_L0+4 
;main.c,336 :: 		spi_write(5, app_command_buf);
	MOVLW       5
	MOVWF       FARG_spi_write_tx_length+0 
	MOVLW       SI4463_init_app_command_buf_L0+0
	MOVWF       FARG_spi_write_p+0 
	MOVLW       hi_addr(SI4463_init_app_command_buf_L0+0)
	MOVWF       FARG_spi_write_p+1 
	CALL        _spi_write+0, 0
;main.c,339 :: 		app_command_buf[0] = 0x11;
	MOVLW       17
	MOVWF       SI4463_init_app_command_buf_L0+0 
;main.c,340 :: 		app_command_buf[1]  = 0x12;
	MOVLW       18
	MOVWF       SI4463_init_app_command_buf_L0+1 
;main.c,341 :: 		app_command_buf[2]  = 0x01;
	MOVLW       1
	MOVWF       SI4463_init_app_command_buf_L0+2 
;main.c,342 :: 		app_command_buf[3]  = 0x06;
	MOVLW       6
	MOVWF       SI4463_init_app_command_buf_L0+3 
;main.c,343 :: 		app_command_buf[4]  = 0x02;                         // CRC MSB£¬ data MSB
	MOVLW       2
	MOVWF       SI4463_init_app_command_buf_L0+4 
;main.c,344 :: 		spi_write(5, app_command_buf);
	MOVLW       5
	MOVWF       FARG_spi_write_tx_length+0 
	MOVLW       SI4463_init_app_command_buf_L0+0
	MOVWF       FARG_spi_write_p+0 
	MOVLW       hi_addr(SI4463_init_app_command_buf_L0+0)
	MOVWF       FARG_spi_write_p+1 
	CALL        _spi_write+0, 0
;main.c,347 :: 		app_command_buf[0] = 0x11;
	MOVLW       17
	MOVWF       SI4463_init_app_command_buf_L0+0 
;main.c,348 :: 		app_command_buf[1]  = 0x12;
	MOVLW       18
	MOVWF       SI4463_init_app_command_buf_L0+1 
;main.c,349 :: 		app_command_buf[2]  = 0x03;
	MOVLW       3
	MOVWF       SI4463_init_app_command_buf_L0+2 
;main.c,350 :: 		app_command_buf[3]  = 0x08;
	MOVLW       8
	MOVWF       SI4463_init_app_command_buf_L0+3 
;main.c,351 :: 		app_command_buf[4]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+4 
;main.c,352 :: 		app_command_buf[5]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+5 
;main.c,353 :: 		app_command_buf[6]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+6 
;main.c,354 :: 		spi_write(7, app_command_buf);
	MOVLW       7
	MOVWF       FARG_spi_write_tx_length+0 
	MOVLW       SI4463_init_app_command_buf_L0+0
	MOVWF       FARG_spi_write_p+0 
	MOVLW       hi_addr(SI4463_init_app_command_buf_L0+0)
	MOVWF       FARG_spi_write_p+1 
	CALL        _spi_write+0, 0
;main.c,356 :: 		app_command_buf[0] = 0x11;
	MOVLW       17
	MOVWF       SI4463_init_app_command_buf_L0+0 
;main.c,357 :: 		app_command_buf[1]  = 0x12;
	MOVLW       18
	MOVWF       SI4463_init_app_command_buf_L0+1 
;main.c,358 :: 		app_command_buf[2]  = 0x0c;
	MOVLW       12
	MOVWF       SI4463_init_app_command_buf_L0+2 
;main.c,359 :: 		app_command_buf[3]  = 0x0d;
	MOVLW       13
	MOVWF       SI4463_init_app_command_buf_L0+3 
;main.c,360 :: 		app_command_buf[4]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+4 
;main.c,361 :: 		app_command_buf[5]  = payload_length;
	MOVLW       14
	MOVWF       SI4463_init_app_command_buf_L0+5 
;main.c,362 :: 		app_command_buf[6]  = 0x04;
	MOVLW       4
	MOVWF       SI4463_init_app_command_buf_L0+6 
;main.c,363 :: 		app_command_buf[7]  = 0xaa;
	MOVLW       170
	MOVWF       SI4463_init_app_command_buf_L0+7 
;main.c,364 :: 		app_command_buf[8]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+8 
;main.c,365 :: 		app_command_buf[9]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+9 
;main.c,366 :: 		app_command_buf[10]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+10 
;main.c,367 :: 		app_command_buf[11]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+11 
;main.c,368 :: 		app_command_buf[12]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+12 
;main.c,369 :: 		app_command_buf[13]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+13 
;main.c,370 :: 		app_command_buf[14]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+14 
;main.c,371 :: 		app_command_buf[15]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+15 
;main.c,372 :: 		spi_write(16, app_command_buf);                 // set length of Field 1 -- 4
	MOVLW       16
	MOVWF       FARG_spi_write_tx_length+0 
	MOVLW       SI4463_init_app_command_buf_L0+0
	MOVWF       FARG_spi_write_p+0 
	MOVLW       hi_addr(SI4463_init_app_command_buf_L0+0)
	MOVWF       FARG_spi_write_p+1 
	CALL        _spi_write+0, 0
;main.c,375 :: 		app_command_buf[0] = 0x11;
	MOVLW       17
	MOVWF       SI4463_init_app_command_buf_L0+0 
;main.c,376 :: 		app_command_buf[1]  = 0x12;
	MOVLW       18
	MOVWF       SI4463_init_app_command_buf_L0+1 
;main.c,377 :: 		app_command_buf[2]  = 0x08;
	MOVLW       8
	MOVWF       SI4463_init_app_command_buf_L0+2 
;main.c,378 :: 		app_command_buf[3]  = 0x19;
	MOVLW       25
	MOVWF       SI4463_init_app_command_buf_L0+3 
;main.c,379 :: 		app_command_buf[4]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+4 
;main.c,380 :: 		app_command_buf[5]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+5 
;main.c,381 :: 		app_command_buf[6]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+6 
;main.c,382 :: 		app_command_buf[7]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+7 
;main.c,383 :: 		app_command_buf[8]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+8 
;main.c,384 :: 		app_command_buf[9]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+9 
;main.c,385 :: 		app_command_buf[10]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+10 
;main.c,386 :: 		app_command_buf[11]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+11 
;main.c,387 :: 		spi_write(12, app_command_buf);
	MOVLW       12
	MOVWF       FARG_spi_write_tx_length+0 
	MOVLW       SI4463_init_app_command_buf_L0+0
	MOVWF       FARG_spi_write_p+0 
	MOVLW       hi_addr(SI4463_init_app_command_buf_L0+0)
	MOVWF       FARG_spi_write_p+1 
	CALL        _spi_write+0, 0
;main.c,389 :: 		spi_write(0x10, RF_MODEM_MOD_TYPE_12_data);
	MOVLW       16
	MOVWF       FARG_spi_write_tx_length+0 
	MOVLW       _RF_MODEM_MOD_TYPE_12_data+0
	MOVWF       FARG_spi_write_p+0 
	MOVLW       hi_addr(_RF_MODEM_MOD_TYPE_12_data+0)
	MOVWF       FARG_spi_write_p+1 
	CALL        _spi_write+0, 0
;main.c,390 :: 		spi_write(0x05, RF_MODEM_FREQ_DEV_0_1_data);
	MOVLW       5
	MOVWF       FARG_spi_write_tx_length+0 
	MOVLW       _RF_MODEM_FREQ_DEV_0_1_data+0
	MOVWF       FARG_spi_write_p+0 
	MOVLW       hi_addr(_RF_MODEM_FREQ_DEV_0_1_data+0)
	MOVWF       FARG_spi_write_p+1 
	CALL        _spi_write+0, 0
;main.c,392 :: 		spi_write(0x10, RF_MODEM_TX_RAMP_DELAY_12_data);
	MOVLW       16
	MOVWF       FARG_spi_write_tx_length+0 
	MOVLW       _RF_MODEM_TX_RAMP_DELAY_12_data+0
	MOVWF       FARG_spi_write_p+0 
	MOVLW       hi_addr(_RF_MODEM_TX_RAMP_DELAY_12_data+0)
	MOVWF       FARG_spi_write_p+1 
	CALL        _spi_write+0, 0
;main.c,393 :: 		spi_write(0x10, BCR_NCO_OFFSET_2_12_data);
	MOVLW       16
	MOVWF       FARG_spi_write_tx_length+0 
	MOVLW       _BCR_NCO_OFFSET_2_12_data+0
	MOVWF       FARG_spi_write_p+0 
	MOVLW       hi_addr(_BCR_NCO_OFFSET_2_12_data+0)
	MOVWF       FARG_spi_write_p+1 
	CALL        _spi_write+0, 0
;main.c,394 :: 		spi_write(0x10, RF_MODEM_TX_RAMP_DELAY_12_data);
	MOVLW       16
	MOVWF       FARG_spi_write_tx_length+0 
	MOVLW       _RF_MODEM_TX_RAMP_DELAY_12_data+0
	MOVWF       FARG_spi_write_p+0 
	MOVLW       hi_addr(_RF_MODEM_TX_RAMP_DELAY_12_data+0)
	MOVWF       FARG_spi_write_p+1 
	CALL        _spi_write+0, 0
;main.c,395 :: 		spi_write(0x07, RF_MODEM_AFC_LIMITER_1_3_data);
	MOVLW       7
	MOVWF       FARG_spi_write_tx_length+0 
	MOVLW       _RF_MODEM_AFC_LIMITER_1_3_data+0
	MOVWF       FARG_spi_write_p+0 
	MOVLW       hi_addr(_RF_MODEM_AFC_LIMITER_1_3_data+0)
	MOVWF       FARG_spi_write_p+1 
	CALL        _spi_write+0, 0
;main.c,398 :: 		spi_write(0x05, RF_MODEM_AGC_CONTROL_1_data);
	MOVLW       5
	MOVWF       FARG_spi_write_tx_length+0 
	MOVLW       _RF_MODEM_AGC_CONTROL_1_data+0
	MOVWF       FARG_spi_write_p+0 
	MOVLW       hi_addr(_RF_MODEM_AGC_CONTROL_1_data+0)
	MOVWF       FARG_spi_write_p+1 
	CALL        _spi_write+0, 0
;main.c,399 :: 		spi_write(0x10, AGC_WINDOW_SIZE_12_data);
	MOVLW       16
	MOVWF       FARG_spi_write_tx_length+0 
	MOVLW       _AGC_WINDOW_SIZE_12_data+0
	MOVWF       FARG_spi_write_p+0 
	MOVLW       hi_addr(_AGC_WINDOW_SIZE_12_data+0)
	MOVWF       FARG_spi_write_p+1 
	CALL        _spi_write+0, 0
;main.c,400 :: 		spi_write(0x0c, RF_MODEM_RAW_CONTROL_8_data);
	MOVLW       12
	MOVWF       FARG_spi_write_tx_length+0 
	MOVLW       _RF_MODEM_RAW_CONTROL_8_data+0
	MOVWF       FARG_spi_write_p+0 
	MOVLW       hi_addr(_RF_MODEM_RAW_CONTROL_8_data+0)
	MOVWF       FARG_spi_write_p+1 
	CALL        _spi_write+0, 0
;main.c,404 :: 		app_command_buf[0] = 0x11;
	MOVLW       17
	MOVWF       SI4463_init_app_command_buf_L0+0 
;main.c,405 :: 		app_command_buf[1] = 0x20;
	MOVLW       32
	MOVWF       SI4463_init_app_command_buf_L0+1 
;main.c,406 :: 		app_command_buf[2] = 0x01;
	MOVLW       1
	MOVWF       SI4463_init_app_command_buf_L0+2 
;main.c,407 :: 		app_command_buf[3] = 0x4e;
	MOVLW       78
	MOVWF       SI4463_init_app_command_buf_L0+3 
;main.c,408 :: 		app_command_buf[4]  = 0x40;
	MOVLW       64
	MOVWF       SI4463_init_app_command_buf_L0+4 
;main.c,409 :: 		spi_write(5, app_command_buf);
	MOVLW       5
	MOVWF       FARG_spi_write_tx_length+0 
	MOVLW       SI4463_init_app_command_buf_L0+0
	MOVWF       FARG_spi_write_p+0 
	MOVLW       hi_addr(SI4463_init_app_command_buf_L0+0)
	MOVWF       FARG_spi_write_p+1 
	CALL        _spi_write+0, 0
;main.c,411 :: 		spi_write(0x10, COE13_7_0_12_data);
	MOVLW       16
	MOVWF       FARG_spi_write_tx_length+0 
	MOVLW       _COE13_7_0_12_data+0
	MOVWF       FARG_spi_write_p+0 
	MOVLW       hi_addr(_COE13_7_0_12_data+0)
	MOVWF       FARG_spi_write_p+1 
	CALL        _spi_write+0, 0
;main.c,412 :: 		spi_write(0x10, COE1_7_0_12_data);
	MOVLW       16
	MOVWF       FARG_spi_write_tx_length+0 
	MOVLW       _COE1_7_0_12_data+0
	MOVWF       FARG_spi_write_p+0 
	MOVLW       hi_addr(_COE1_7_0_12_data+0)
	MOVWF       FARG_spi_write_p+1 
	CALL        _spi_write+0, 0
;main.c,413 :: 		spi_write(0x10, COE7_7_0_12_data);
	MOVLW       16
	MOVWF       FARG_spi_write_tx_length+0 
	MOVLW       _COE7_7_0_12_data+0
	MOVWF       FARG_spi_write_p+0 
	MOVLW       hi_addr(_COE7_7_0_12_data+0)
	MOVWF       FARG_spi_write_p+1 
	CALL        _spi_write+0, 0
;main.c,416 :: 		app_command_buf[0]  = 0x11;
	MOVLW       17
	MOVWF       SI4463_init_app_command_buf_L0+0 
;main.c,417 :: 		app_command_buf[1]  = 0x22;
	MOVLW       34
	MOVWF       SI4463_init_app_command_buf_L0+1 
;main.c,418 :: 		app_command_buf[2]  = 0x04;
	MOVLW       4
	MOVWF       SI4463_init_app_command_buf_L0+2 
;main.c,419 :: 		app_command_buf[3]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+3 
;main.c,420 :: 		app_command_buf[4]  = 0x08;
	MOVLW       8
	MOVWF       SI4463_init_app_command_buf_L0+4 
;main.c,421 :: 		app_command_buf[5]  = 127;                          // set max power
	MOVLW       127
	MOVWF       SI4463_init_app_command_buf_L0+5 
;main.c,422 :: 		app_command_buf[6]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+6 
;main.c,423 :: 		app_command_buf[7]  = 0x3d;
	MOVLW       61
	MOVWF       SI4463_init_app_command_buf_L0+7 
;main.c,424 :: 		spi_write(8, app_command_buf);
	MOVLW       8
	MOVWF       FARG_spi_write_tx_length+0 
	MOVLW       SI4463_init_app_command_buf_L0+0
	MOVWF       FARG_spi_write_p+0 
	MOVLW       hi_addr(SI4463_init_app_command_buf_L0+0)
	MOVWF       FARG_spi_write_p+1 
	CALL        _spi_write+0, 0
;main.c,426 :: 		spi_write(0x0B, RF_SYNTH_PFDCP_CPFF_7_data);
	MOVLW       11
	MOVWF       FARG_spi_write_tx_length+0 
	MOVLW       _RF_SYNTH_PFDCP_CPFF_7_data+0
	MOVWF       FARG_spi_write_p+0 
	MOVLW       hi_addr(_RF_SYNTH_PFDCP_CPFF_7_data+0)
	MOVWF       FARG_spi_write_p+1 
	CALL        _spi_write+0, 0
;main.c,429 :: 		app_command_buf[0] = 0x11;
	MOVLW       17
	MOVWF       SI4463_init_app_command_buf_L0+0 
;main.c,430 :: 		app_command_buf[1]  = 0x30;
	MOVLW       48
	MOVWF       SI4463_init_app_command_buf_L0+1 
;main.c,431 :: 		app_command_buf[2]  = 0x0c;
	MOVLW       12
	MOVWF       SI4463_init_app_command_buf_L0+2 
;main.c,432 :: 		app_command_buf[3]  = 0x00;
	CLRF        SI4463_init_app_command_buf_L0+3 
;main.c,433 :: 		app_command_buf[4]  = 's';
	MOVLW       115
	MOVWF       SI4463_init_app_command_buf_L0+4 
;main.c,434 :: 		app_command_buf[5]  = 0xff;
	MOVLW       255
	MOVWF       SI4463_init_app_command_buf_L0+5 
;main.c,435 :: 		app_command_buf[6]  = 0x40;
	MOVLW       64
	MOVWF       SI4463_init_app_command_buf_L0+6 
;main.c,436 :: 		app_command_buf[7]  = 'w';
	MOVLW       119
	MOVWF       SI4463_init_app_command_buf_L0+7 
;main.c,437 :: 		app_command_buf[8]  = 0xff;
	MOVLW       255
	MOVWF       SI4463_init_app_command_buf_L0+8 
;main.c,438 :: 		app_command_buf[9]  = 0x01;
	MOVLW       1
	MOVWF       SI4463_init_app_command_buf_L0+9 
;main.c,439 :: 		app_command_buf[10] = 'w';
	MOVLW       119
	MOVWF       SI4463_init_app_command_buf_L0+10 
;main.c,440 :: 		app_command_buf[11]  =0xff;
	MOVLW       255
	MOVWF       SI4463_init_app_command_buf_L0+11 
;main.c,441 :: 		app_command_buf[12]  =0x02;
	MOVLW       2
	MOVWF       SI4463_init_app_command_buf_L0+12 
;main.c,442 :: 		app_command_buf[13]  = 'x';
	MOVLW       120
	MOVWF       SI4463_init_app_command_buf_L0+13 
;main.c,443 :: 		app_command_buf[14]  = 0xff;
	MOVLW       255
	MOVWF       SI4463_init_app_command_buf_L0+14 
;main.c,444 :: 		app_command_buf[15]  =0x03;
	MOVLW       3
	MOVWF       SI4463_init_app_command_buf_L0+15 
;main.c,445 :: 		spi_write(16, app_command_buf);
	MOVLW       16
	MOVWF       FARG_spi_write_tx_length+0 
	MOVLW       SI4463_init_app_command_buf_L0+0
	MOVWF       FARG_spi_write_p+0 
	MOVLW       hi_addr(SI4463_init_app_command_buf_L0+0)
	MOVWF       FARG_spi_write_p+1 
	CALL        _spi_write+0, 0
;main.c,447 :: 		spi_write(6, RF_MODEM_RAW_SEARCH2_2_data);
	MOVLW       6
	MOVWF       FARG_spi_write_tx_length+0 
	MOVLW       _RF_MODEM_RAW_SEARCH2_2_data+0
	MOVWF       FARG_spi_write_p+0 
	MOVLW       hi_addr(_RF_MODEM_RAW_SEARCH2_2_data+0)
	MOVWF       FARG_spi_write_p+1 
	CALL        _spi_write+0, 0
;main.c,448 :: 		spi_write(12, RF_FREQ_CONTROL_INTE_8_data);         // set frequency
	MOVLW       12
	MOVWF       FARG_spi_write_tx_length+0 
	MOVLW       _RF_FREQ_CONTROL_INTE_8_data+0
	MOVWF       FARG_spi_write_p+0 
	MOVLW       hi_addr(_RF_FREQ_CONTROL_INTE_8_data+0)
	MOVWF       FARG_spi_write_p+1 
	CALL        _spi_write+0, 0
;main.c,449 :: 		}
L_end_SI4463_init:
	RETURN      0
; end of _SI4463_init

_spibyte:

;main.c,463 :: 		unsigned char spibyte(unsigned char mydata)
;main.c,467 :: 		for (i = 0; i < 8; i++)
	CLRF        spibyte_i_L0+0 
L_spibyte6:
	MOVLW       8
	SUBWF       spibyte_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_spibyte7
;main.c,469 :: 		if (mydata & 0x80)
	BTFSS       FARG_spibyte_mydata+0, 7 
	GOTO        L_spibyte9
;main.c,470 :: 		SPI_SDI = 1;
	BSF         RC4_bit+0, BitPos(RC4_bit+0) 
	GOTO        L_spibyte10
L_spibyte9:
;main.c,472 :: 		SPI_SDI = 0;
	BCF         RC4_bit+0, BitPos(RC4_bit+0) 
L_spibyte10:
;main.c,474 :: 		mydata <<= 1;
	RLCF        FARG_spibyte_mydata+0, 1 
	BCF         FARG_spibyte_mydata+0, 0 
;main.c,475 :: 		SPI_SCK = 1;
	BSF         RC3_bit+0, BitPos(RC3_bit+0) 
;main.c,477 :: 		if (SPI_SDO)
	BTFSS       RC5_bit+0, BitPos(RC5_bit+0) 
	GOTO        L_spibyte11
;main.c,478 :: 		mydata |= 0x01;
	BSF         FARG_spibyte_mydata+0, 0 
	GOTO        L_spibyte12
L_spibyte11:
;main.c,480 :: 		mydata &= 0xfe;
	MOVLW       254
	ANDWF       FARG_spibyte_mydata+0, 1 
L_spibyte12:
;main.c,482 :: 		SPI_SCK = 0;
	BCF         RC3_bit+0, BitPos(RC3_bit+0) 
;main.c,467 :: 		for (i = 0; i < 8; i++)
	INCF        spibyte_i_L0+0, 1 
;main.c,483 :: 		}
	GOTO        L_spibyte6
L_spibyte7:
;main.c,484 :: 		return (mydata);
	MOVF        FARG_spibyte_mydata+0, 0 
	MOVWF       R0 
;main.c,485 :: 		}
L_end_spibyte:
	RETURN      0
; end of _spibyte

_spi_write:

;main.c,497 :: 		void spi_write(unsigned char tx_length, unsigned char *p)
;main.c,501 :: 		i = 0;
	CLRF        spi_write_i_L0+0 
;main.c,502 :: 		while(i!=0xff)
L_spi_write13:
	MOVF        spi_write_i_L0+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_spi_write14
;main.c,503 :: 		i = check_cts();
	CALL        _check_cts+0, 0
	MOVF        R0, 0 
	MOVWF       spi_write_i_L0+0 
	GOTO        L_spi_write13
L_spi_write14:
;main.c,505 :: 		SPI_SCK = 0;
	BCF         RC3_bit+0, BitPos(RC3_bit+0) 
;main.c,506 :: 		SPI_nSEL = 0;
	BCF         RE0_bit+0, BitPos(RE0_bit+0) 
;main.c,508 :: 		for (i = 0; i < tx_length; i++)
	CLRF        spi_write_i_L0+0 
L_spi_write15:
	MOVF        FARG_spi_write_tx_length+0, 0 
	SUBWF       spi_write_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_spi_write16
;main.c,510 :: 		j = *(p+i);
	MOVF        spi_write_i_L0+0, 0 
	ADDWF       FARG_spi_write_p+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_spi_write_p+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       spi_write_j_L0+0 
;main.c,511 :: 		spibyte(j);
	MOVF        spi_write_j_L0+0, 0 
	MOVWF       FARG_spibyte_mydata+0 
	CALL        _spibyte+0, 0
;main.c,508 :: 		for (i = 0; i < tx_length; i++)
	INCF        spi_write_i_L0+0, 1 
;main.c,512 :: 		}
	GOTO        L_spi_write15
L_spi_write16:
;main.c,514 :: 		SPI_nSEL = 1;
	BSF         RE0_bit+0, BitPos(RE0_bit+0) 
;main.c,515 :: 		}
L_end_spi_write:
	RETURN      0
; end of _spi_write

_check_cts:

;main.c,528 :: 		U8 check_cts(void)
;main.c,532 :: 		SPI_nSEL = 1;
	BSF         RE0_bit+0, BitPos(RE0_bit+0) 
;main.c,533 :: 		SPI_SCK = 0;
	BCF         RC3_bit+0, BitPos(RC3_bit+0) 
;main.c,534 :: 		SPI_nSEL = 0;
	BCF         RE0_bit+0, BitPos(RE0_bit+0) 
;main.c,535 :: 		spibyte(0x44);
	MOVLW       68
	MOVWF       FARG_spibyte_mydata+0 
	CALL        _spibyte+0, 0
;main.c,536 :: 		i = spibyte(0);
	CLRF        FARG_spibyte_mydata+0 
	CALL        _spibyte+0, 0
	MOVF        R0, 0 
	MOVWF       check_cts_i_L0+0 
;main.c,537 :: 		SPI_nSEL = 1;
	BSF         RE0_bit+0, BitPos(RE0_bit+0) 
;main.c,538 :: 		return (i);
	MOVF        check_cts_i_L0+0, 0 
	MOVWF       R0 
;main.c,539 :: 		}
L_end_check_cts:
	RETURN      0
; end of _check_cts

_spi_read:

;main.c,552 :: 		void spi_read(U8 data_length, U8 api_command )
;main.c,557 :: 		p[0] = api_command;
	MOVF        FARG_spi_read_api_command+0, 0 
	MOVWF       spi_read_p_L0+0 
;main.c,558 :: 		i = 0;
	CLRF        spi_read_i_L0+0 
;main.c,559 :: 		while(i!=0xff)
L_spi_read18:
	MOVF        spi_read_i_L0+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_spi_read19
;main.c,560 :: 		i = check_cts();
	CALL        _check_cts+0, 0
	MOVF        R0, 0 
	MOVWF       spi_read_i_L0+0 
	GOTO        L_spi_read18
L_spi_read19:
;main.c,562 :: 		spi_write(1, p);
	MOVLW       1
	MOVWF       FARG_spi_write_tx_length+0 
	MOVLW       spi_read_p_L0+0
	MOVWF       FARG_spi_write_p+0 
	MOVLW       hi_addr(spi_read_p_L0+0)
	MOVWF       FARG_spi_write_p+1 
	CALL        _spi_write+0, 0
;main.c,564 :: 		i = 0;
	CLRF        spi_read_i_L0+0 
;main.c,565 :: 		while(i!=0xff)
L_spi_read20:
	MOVF        spi_read_i_L0+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_spi_read21
;main.c,566 :: 		i = check_cts();
	CALL        _check_cts+0, 0
	MOVF        R0, 0 
	MOVWF       spi_read_i_L0+0 
	GOTO        L_spi_read20
L_spi_read21:
;main.c,568 :: 		SPI_nSEL = 1;
	BSF         RE0_bit+0, BitPos(RE0_bit+0) 
;main.c,569 :: 		SPI_SCK = 0;
	BCF         RC3_bit+0, BitPos(RC3_bit+0) 
;main.c,570 :: 		SPI_nSEL = 0;
	BCF         RE0_bit+0, BitPos(RE0_bit+0) 
;main.c,571 :: 		spibyte(0x44);
	MOVLW       68
	MOVWF       FARG_spibyte_mydata+0 
	CALL        _spibyte+0, 0
;main.c,572 :: 		for (i = 0; i< data_length; i++)
	CLRF        spi_read_i_L0+0 
L_spi_read22:
	MOVF        FARG_spi_read_data_length+0, 0 
	SUBWF       spi_read_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_spi_read23
;main.c,573 :: 		spi_read_buf[i] = spibyte(0xff);
	MOVLW       _spi_read_buf+0
	MOVWF       FLOC__spi_read+0 
	MOVLW       hi_addr(_spi_read_buf+0)
	MOVWF       FLOC__spi_read+1 
	MOVF        spi_read_i_L0+0, 0 
	ADDWF       FLOC__spi_read+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__spi_read+1, 1 
	MOVLW       255
	MOVWF       FARG_spibyte_mydata+0 
	CALL        _spibyte+0, 0
	MOVFF       FLOC__spi_read+0, FSR1L+0
	MOVFF       FLOC__spi_read+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;main.c,572 :: 		for (i = 0; i< data_length; i++)
	INCF        spi_read_i_L0+0, 1 
;main.c,573 :: 		spi_read_buf[i] = spibyte(0xff);
	GOTO        L_spi_read22
L_spi_read23:
;main.c,574 :: 		SPI_nSEL = 1;
	BSF         RE0_bit+0, BitPos(RE0_bit+0) 
;main.c,575 :: 		}
L_end_spi_read:
	RETURN      0
; end of _spi_read

_sdn_reset:

;main.c,593 :: 		void sdn_reset(void)
;main.c,596 :: 		UART1_Write_Text("Start RESET Radio\n\r");
	MOVLW       ?ICS?lstr2_main+0
	MOVWF       TBLPTRL+0 
	MOVLW       hi_addr(?ICS?lstr2_main+0)
	MOVWF       TBLPTRL+1 
	MOVLW       higher_addr(?ICS?lstr2_main+0)
	MOVWF       TBLPTRL+2 
	MOVLW       ?lstr2_main+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(?lstr2_main+0)
	MOVWF       FSR1L+1 
	MOVLW       20
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr2_main+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr2_main+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;main.c,597 :: 		SPI_CE = 1;
	BSF         RE1_bit+0, BitPos(RE1_bit+0) 
;main.c,598 :: 		Delay_ms(2);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_sdn_reset25:
	DECFSZ      R13, 1, 1
	BRA         L_sdn_reset25
	DECFSZ      R12, 1, 1
	BRA         L_sdn_reset25
	NOP
	NOP
;main.c,599 :: 		SPI_CE = 0;
	BCF         RE1_bit+0, BitPos(RE1_bit+0) 
;main.c,600 :: 		Delay_ms(10);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_sdn_reset26:
	DECFSZ      R13, 1, 1
	BRA         L_sdn_reset26
	DECFSZ      R12, 1, 1
	BRA         L_sdn_reset26
	DECFSZ      R11, 1, 1
	BRA         L_sdn_reset26
	NOP
;main.c,602 :: 		SPI_nSEL = 1;
	BSF         RE0_bit+0, BitPos(RE0_bit+0) 
;main.c,603 :: 		SPI_SCK  = 0;
	BCF         RC3_bit+0, BitPos(RC3_bit+0) 
;main.c,604 :: 		SPI_nSEL = 0;
	BCF         RE0_bit+0, BitPos(RE0_bit+0) 
;main.c,606 :: 		for (i = 0; i< 7; i++)
	CLRF        sdn_reset_i_L0+0 
L_sdn_reset27:
	MOVLW       7
	SUBWF       sdn_reset_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_sdn_reset28
;main.c,608 :: 		spibyte(RF_POWER_UP_data[i]);
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        sdn_reset_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _RF_POWER_UP_data+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_RF_POWER_UP_data+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_spibyte_mydata+0 
	CALL        _spibyte+0, 0
;main.c,606 :: 		for (i = 0; i< 7; i++)
	INCF        sdn_reset_i_L0+0, 1 
;main.c,609 :: 		}
	GOTO        L_sdn_reset27
L_sdn_reset28:
;main.c,610 :: 		SPI_nSEL = 1;
	BSF         RE0_bit+0, BitPos(RE0_bit+0) 
;main.c,612 :: 		Delay_ms(20);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_sdn_reset30:
	DECFSZ      R13, 1, 1
	BRA         L_sdn_reset30
	DECFSZ      R12, 1, 1
	BRA         L_sdn_reset30
	DECFSZ      R11, 1, 1
	BRA         L_sdn_reset30
;main.c,613 :: 		}
L_end_sdn_reset:
	RETURN      0
; end of _sdn_reset
