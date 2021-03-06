;*******************************************************************************
;   MSP430x41x2 Demo - USCI_B0, SPI 3-Wire Slave Data Echo
;
;   Description: SPI slave talks to SPI master using 3-wire mode. Data received
;   from master is echoed back.  USCI RX ISR is used to handle communication,
;   CPU normally in LPM4.  Prior to initial data exchange, master pulses
;   slaves RST for complete reset.
;   ACLK = n/a, MCLK = SMCLK = DCO ~ 1048kHz
;
;   Use with SPI Master Incremented Data code example.  
;
;                   MSP430F41x2
;                 -----------------
;             /|\|              XIN|-
;              | |                 |  
;     Master---|-|RST          XOUT|-
;                |                 |
;                |             P6.2|-> Data Out (UCB0SIMO)
;                |                 |
;                |             P6.1|<- Data In (UCB0SOMI)
;                |                 |
;                |             P6.4|-> Serial Clock Out (UCB0CLK)
;
;  P. Thanigai
;  Texas Instruments Inc.
;  January 2009
;  Built with CCE Version: 3.1 
;******************************************************************************
 .cdecls C,LIST, "msp430x41x2.h" 
 
            .global _main

MST_Data	.equ   R6
SLV_Data	.equ   R7
;-------------------------------------------------------------------------------
			.text	;Program Start
;-------------------------------------------------------------------------------
_main
RESET       mov.w   #0400h,SP               ; Initialize stack pointer
StopWDT     mov.w   #WDTPW+WDTHOLD,&WDTCTL  ; Stop watchdog timer
OFIFGcheck  bic.b   #OFIFG,&IFG1            ; Clear OFIFG
            mov.w   #047FFh,R15             ; Wait for OFIFG to set again if
OFIFGwait   dec.w   R15                     ; not stable yet
            jnz     OFIFGwait
            bit.b   #OFIFG,&IFG1            ; Has it set again?
            jnz     OFIFGcheck              ; If so, wait some more

            mov.w   #2100,R15               ; Now with stable ACLK, wait for
DCO_delay   dec.w   R15                     ; DCO to stabilize
            jnz     DCO_delay

waitForMstr bit.b   #10h,&P6IN              ; If clock sig from mstr stays low,
            jz      waitForMstr             ; it is not yet in SPI mode

SetupP6     bis.b   #BIT1+BIT2+BIT4,&P6SEL  ; P6.1,2,4 option select

SetupSPI    mov.b   #UCSWRST,&UCB0CTL1      ; **Put state machine in reset**
            bis.b   #UCCKPL+UCMSB+UCSYNC,&UCB0CTL0;3-pin, 8-bit SPI master
            bic.b   #UCSWRST,&UCB0CTL1      ; **Initialize USCI state machine**
            bis.b   #UCB0RXIE,&IE2          ; Enable USCI_B0 RX interrupt
                                            ;
Mainloop    bis.b   #LPM4+GIE,SR            ; Enter LPM3, enable interrupts
            nop                             ; Required for debugger only
                                            ;
;-------------------------------------------------------------------------------
USCIB0RX_ISR;       Test for valid RX and TX character
;-------------------------------------------------------------------------------
TX1         bit.b   #UCB0TXIFG,&IFG2        ; USCI_B0 TX buffer ready?
            jz      TX1                     ;
            mov.b   &UCB0RXBUF,&UCB0TXBUF   ;
            reti
;-------------------------------------------------------------------------------
;			Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect 	 ".int09"		        ; USCI_B0 Rx Vector
            .short   USCIB0RX_ISR           ;
            .sect	".reset"		        ; RESET Vector
            .short   RESET                   ;
            .end
