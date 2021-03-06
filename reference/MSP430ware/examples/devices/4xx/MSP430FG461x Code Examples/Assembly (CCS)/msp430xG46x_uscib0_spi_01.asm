;******************************************************************************
;   MSP430xG46x Demo - USCI_B0, SPI Interface to TLC549 8-Bit ADC
;
;   Description: This program demonstrate USCI_A1 in SPI mode interfaced to a
;   TLC549 8-bit ADC. If AIN > 0.5(REF+ - REF-), P5.1 set, else reset.
;   R15 = 8-bit ADC code.
;   ACLK = 32.768kHz, MCLK = SMCLK = default DCO ~1048k, BRCLK = SMCLK/2
;   //* VCC must be at least 3v for TLC549 *//
;
;                           MSP430FG461x
;                       -----------------
;                   /|\|              XIN|-
;        TLC549      | |                 |   32kHz
;    _____________   --|RST          XOUT|-
;   |           CS|<---|P3.0             |
;   |      DATAOUT|--->|P3.2/UCB0SOMI    |
; ~>| IN+  I/O CLK|<---|P3.3/UCB0CLK     |
;   |             |    |             P5.1|-> LED
;
;  JL Bile
;  Texas Instruments Inc.
;  June 2008
;  Built Code Composer Essentials: v3 FET
;*******************************************************************************
 .cdecls C,LIST, "msp430xG46x.h"
;-------------------------------------------------------------------------------
			.text	;Program Start
;-------------------------------------------------------------------------------
RESET       mov.w   #900,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW+WDTHOLD,&WDTCTL  ; Stop watchdog timer

OFIFGcheck  bic.b   #OFIFG,&IFG1            ; Clear OFIFG
            mov.w   #047FFh,R15             ; Wait for OFIFG to set again if
OFIFGwait   dec.w   R15                     ; not stable yet
            jnz     OFIFGwait
            bit.b   #OFIFG,&IFG1            ; Has it set again?
            jnz     OFIFGcheck              ; If so, wait some more

SetupP5     bis.b   #002h,&P5DIR            ; P5.1 output
SetupP3     bis.b   #0Ch,&P3SEL             ; P3.3,2 option select
            bis.b   #01h,&P3DIR             ; P3.0 output direction
SetupSPI    bis.b   #UCMST+UCSYNC+UCMSB,&UCB0CTL0;3-pin, 8-bit SPI mstr, MSb 1st
            bis.b   #UCSSEL_2,&UCB0CTL1     ; SMCLK
            mov.b   #02h,&UCB0BR0
            clr.b   &UCB0BR1                ;
            bic.b   #UCSWRST,&UCB0CTL1      ; **Initialize USCI state machine**
                                            ;
Mainloop    bic.b   #01h,&P3OUT             ; Enable TLC549, /CS reset
            mov.b   #00h,&UCB0TXBUF         ; Dummy write to start SPI
L1          bit.b   #UCB0RXIFG,&IFG2        ; RXBUF ready?
            jnc     L1                      ; 1 = ready
            mov.b   &UCB0RXBUF,R15          ; R15 = 00|DATA
            bis.b   #01h,&P3OUT             ; Disable TLC549, /CS set
            bic.b   #02h,&P5OUT             ; P5.1 = 0
            cmp.b   #07Fh,R15               ; R15 = AIN > 0.5(REF+ - REF-)?
            jlo     Mainloop                ; Again
            bis.b   #02h,&P5OUT             ; P5.1 = 1
            jmp     Mainloop                ; Again
                                            ;
;------------------------------------------------------------------------------
;			Interrupt Vectors
;------------------------------------------------------------------------------
            .sect	".reset"            	; RESET Vector
            .short  RESET					;
            .end   
