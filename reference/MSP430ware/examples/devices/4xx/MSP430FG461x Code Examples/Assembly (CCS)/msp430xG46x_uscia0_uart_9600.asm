;******************************************************************************
;   MSP430xG46x Demo - USCI_A0, Ultra-Low Pwr UART 9600 Echo ISR, 32kHz ACLK
;
;   Description: Echo a received character, RX ISR used. Normal mode is LPM3,
;   USCI_A0 RX interrupt triggers TX Echo.
;   ACLK = BRCLK = LFXT1 = 32768, MCLK = SMCLK = DCO~1048k
;   Baud rate divider with 32768hz XTAL @9600 = 32768Hz/9600 = 3.41 (0003h 06h )
;   //* An external watch crystal is required on XIN XOUT for ACLK *//	
;
;
;                MSP430FG461x
;             -----------------
;         /|\|              XIN|-
;          | |                 | 32kHz
;          --|RST          XOUT|-
;            |                 |
;            |     P4.7/UCA0RXD|------------>
;            |                 | 9600 - 8N1
;            |     P4.6/UCA0TXD|<------------
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
StopWDT     mov.w   #WDTPW+WDTHOLD,&WDTCTL  ; Stop WDT
SetupFLL    bis.b   #XCAP14PF,&FLL_CTL0     ; Configure load caps

OFIFGcheck  bic.b   #OFIFG,&IFG1            ; Clear OFIFG
            mov.w   #047FFh,R15             ; Wait for OFIFG to set again if
OFIFGwait   dec.w   R15                     ; not stable yet
            jnz     OFIFGwait
            bit.b   #OFIFG,&IFG1            ; Has it set again?
            jnz     OFIFGcheck              ; If so, wait some more

SetupP4     bis.b   #0C0h,&P4SEL            ; P4.7,6 = USCI_A0 RXD/TXD
SetupUART   bis.b   #UCSSEL_1,&UCA0CTL1     ; CLK = ACLK
            mov.b   #03h,&UCA0BR0           ; 32k/9600 - 3.41
            mov.b   #00h,&UCA0BR1           ;
            mov.b   #06h,&UCA0MCTL          ; Modulation
            bic.b   #UCSWRST,&UCA0CTL1      ; **Initialize USCI state machine**
            bis.b   #UCA0RXIE,&IE2          ; Enable USCI_A0 RX interrupt
                                            ;
Mainloop    bis.b   #LPM3+GIE,SR            ; Enter LPM3, interrupts enabled
            nop                             ; Required for debugger
                                            ;
;------------------------------------------------------------------------------
USCIA0RX_ISR;  Echo back RXed character, confirm TX buffer is ready first
;------------------------------------------------------------------------------
TX0         bit.b   #UCA0TXIFG,&IFG2        ; USCI_A0 TX buffer ready?
            jz      TX0                     ; Jump if TX buffer not ready
            mov.b   &UCA0RXBUF,&UCA0TXBUF   ; TX -> RXed character
            reti                            ;
                                            ;
;------------------------------------------------------------------------------
;			Interrupt Vectors
;------------------------------------------------------------------------------
            .sect	".int25"		        ; USCI_A0 Rx Vector
            .short  USCIA0RX_ISR            ;
            .sect	".reset"            	;	RESET Vector
            .short  RESET					;
            .end
            