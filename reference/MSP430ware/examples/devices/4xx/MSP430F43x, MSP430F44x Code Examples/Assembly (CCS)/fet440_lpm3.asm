;******************************************************************************
;   MSP-FET430P440 Demo - FLL+, LPM3 Using Basic Timer ISR, 32kHz ACLK
;
;   Description: System runs normally in LPM3 with basic timer clocked by
;   32kHz ACLK. At a 2 second interval the basic timer ISR will wake the
;   system and flash the LED on P5.1 inside of the Mainloop.
;   ACLK = LFXT1 = 32768Hz, MCLK = SMCLK = default DCO = 32 x ACLK = 1048576Hz
;   ;* An external watch crystal between XIN & XOUT is required for ACLK *//	
;
;                MSP430F449
;             -----------------
;         /|\|              XIN|-
;          | |                 | 32kHz
;          --|RST          XOUT|-
;            |                 |
;            |             P5.1|-->LED
;
;   M. Buccini / A. Dannenberg
;   Texas Instruments Inc.
;   May 2005
;   Built with Code Composer Essentials Version: 1.0
;******************************************************************************
 .cdecls C,LIST, "msp430x44x.h"
;------------------------------------------------------------------------------
            .text                  			; Program Start
;------------------------------------------------------------------------------
RESET       mov.w   #0A00h,SP               ; Initialize stackpointer
StopWDT     mov.w   #WDTPW+WDTHOLD,&WDTCTL  ; Stop WDT
SetupFLL    bis.b   #XCAP14PF,&FLL_CTL0     ; Configure load caps
SetupBT     mov.b   #BTDIV+BTIP2+BTIP1+BTIP0,&BTCTL   ; 2s Int.
            bis.b   #BTIE,&IE2              ; Enable Basic Timer interrupt
SetupPx     mov.b   #0FFh,&P6DIR            ; P6.x output
            clr.b   &P6OUT                  ;
            mov.b   #0FFh,&P5DIR            ; P5.x output
            clr.b   &P5OUT                  ;
            mov.b   #0FFh,&P4DIR            ; P4.x output
            clr.b   &P4OUT                  ;
            mov.b   #0FFh,&P3DIR            ; P3.x output
            clr.b   &P3OUT                  ;
            mov.b   #0FFh,&P2DIR            ; P2.x output
            clr.b   &P2OUT                  ;
            mov.b   #0FFh,&P1DIR            ; P1.x output
            clr.b   &P1OUT                  ;
                                            ;				          							
Mainloop    bis.w   #LPM3+GIE,SR            ; Enter LPM3, enable interrupts
            bis.b   #002h,&P5OUT            ; set P5.1
            push    #2000                   ; Delay to TOS
Pulse       dec.w   0(SP)                   ; Decrement Value at TOS
            jnz     Pulse                   ; Delay done?
            incd.w  SP                      ; Clean-up stack
            bic.b   #002h,&P5OUT            ; Reset P5.1
            jmp     Mainloop                ;
                                            ;
;------------------------------------------------------------------------------
BT_ISR;     Exit LPM3 on reti
;------------------------------------------------------------------------------
            bic.w   #LPM3,0(SP)             ;
            reti                            ;		
                                            ;
;-----------------------------------------------------------------------------
;           Interrupt Vectors
;-----------------------------------------------------------------------------
            .sect   ".reset"                ; RESET Vector
            .short  RESET                   ;
            .sect   ".int00"                ; Basic Timer Vector
            .short  BT_ISR                  ;
            .end
