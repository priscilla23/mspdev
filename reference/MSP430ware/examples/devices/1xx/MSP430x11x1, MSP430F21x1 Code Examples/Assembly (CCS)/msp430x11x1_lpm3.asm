;*******************************************************************************
;   MSP430x11x1 Demo - Basic Clock, LPM3 Using WDT ISR, 32kHz ACLK
;
;   Description: This program operates MSP430 normally in LPM3, pulsing P1.0
;   at 4 second intervals. WDT ISR used to wake-up system. All I/O configured
;   as low outputs to eliminate floating inputs. Current consumption does
;   increase when LED is powered on P1.0. Demo for measuring LPM3 current.
;   ACLK = LFXT1/4 = 32768/4, MCLK = SMCLK = default DCO ~800kHz
;   ;* External watch crystal installed on XIN XOUT is required for ACLK *//	
;
;                MSP430F1121
;             -----------------
;         /|\|              XIN|-
;          | |                 | 32kHz
;          --|RST          XOUT|-
;            |                 |
;            |             P1.0|-->LED
;
;   M. Buccini / Z. Albus
;   Texas Instruments Inc.
;   May 2005
;   Built with Code Composer Essentials Version: 1.0
;*******************************************************************************
 .cdecls C,LIST,  "msp430x11x1.h"
;-------------------------------------------------------------------------------
            .text                           ; Program Start
;-------------------------------------------------------------------------------
RESET       mov.w   #300h,SP                ; Initialize stackpointer
SetupWDT    mov.w   #WDT_ADLY_1000,&WDTCTL  ; WDT 1s*4 interval timer
SetupBC     bis.b   #DIVA_2,&BCSCTL1        ; ACLK/4
            bis.b   #WDTIE,&IE1             ; Enable WDT interrupt
SetupP1     mov.b   #0FFh,&P1DIR            ; All P1.x outputs
            clr.b   &P1OUT                  ; All P1.x reset
SetupP2     mov.b   #0FFh,&P2DIR            ; All P2.x outputs
            clr.b   &P2OUT                  ; All P2.x reset
                                            ;					
Mainloop    bis.w   #LPM3+GIE,SR            ; Enter LPM3, enable interrupts
            bis.b   #001h,&P1OUT            ; Set P1.0
            push.w  #5000                   ; Delay to TOS
Delay       dec.w   0(SP)                   ; Decrement TOS
            jnz     Delay                   ; Delay over?
            incd.w  SP                      ; Clean stack
            bic.b   #001h,&P1OUT            ; Reset P1.0
            jmp     Mainloop                ; Again
                                            ;
;-------------------------------------------------------------------------------
WDT_ISR  ;  Exit LPM3 on reti
;-------------------------------------------------------------------------------
            bic.w   #LPM3,0(SP)             ; Clear LPM3 from TOS
            reti                            ;
                                            ;
;-------------------------------------------------------------------------------
;           Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET                   ;
            .sect   ".int10"                ; WDT Vector
            .short  WDT_ISR                 ;
            .end
