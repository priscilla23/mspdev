;******************************************************************************
;  MSP430F21x2 Demo - Timer0_A3, PWM TA0_0 - TA0_2, Up Mode, 32kHz ACLK
;
;  Description: This program generates two PWM outputs on P1.2,3 using
;  Timer0_A3 configured for up mode. The value in TA0CCR0, 512-1, defines the PWM
;  period and the values in TA0CCR1 and TA0CCR2 the PWM duty cycles. Using 32kHz
;  ACLK as TA0CLK, the timer period is 15.6ms with a 75% duty cycle on P1.2
;  and 25% on P1.3. Normal operating mode is LPM3.
;  ACLK = TA0CLK = LFXT1 = 32768Hz, MCLK = SMCLK = default DCO ~1.2MHz
;  ;* External watch crystal on XIN XOUT is required for ACLK *;
;
;               MSP430F21x2
;            -----------------
;        /|\|              XIN|-
;         | |                 | 32kHz
;         --|RST          XOUT|-
;           |                 |
;           |       P1.2/TA0_1|--> TA0CCR1 - 75% PWM
;           |       P1.3/TA0_2|--> TA0CCR2 - 25% PWM
;
;  JL Bile
;  Texas Instruments Inc.
;  May 2008
;  Built with Code Composer Essentials: v3 FET
;*******************************************************************************
 .cdecls C,LIST, "msp430x21x2.h"
;-------------------------------------------------------------------------------
 			.text							; Program Start
;-------------------------------------------------------------------------------
RESET       mov.w   #025Fh,SP         		; Initialize stackpointer
StopWDT     mov.w   #WDTPW+WDTHOLD,&WDTCTL  ; Stop WDT
SetupP1     bis.b   #00Ch,&P1DIR            ; P1.2 and P1.3 outputs
            bis.b   #00Ch,&P1SEL            ; P1.2 and P1.3 TA1/2 option
SetupC0     mov.w   #512-1,&TA0CCR0          ; PWM Period
SetupC1     mov.w   #OUTMOD_7,&TA0CCTL1      ; TACCR1 reset/set
            mov.w   #384,&TA0CCR1            ; TACCR1 PWM Duty Cycle
SetupC2     mov.w   #OUTMOD_7,&TA0CCTL2      ; TACCR2 reset/set
            mov.w   #128,&TA0CCR2            ; TACCR2 PWM duty cycle
SetupTA     mov.w   #TASSEL_1+MC_1,&TA0CTL   ; ACLK, upmode
                                            ;
Mainloop    bis.w   #LPM3,SR                ; Remain in LPM3
            nop                             ; Required only for debugger
                                            ;
;-------------------------------------------------------------------------------
;			Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect	".reset"				; MSP430 RESET Vector
            .short	RESET                   ;
            .end
