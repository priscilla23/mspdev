;******************************************************************************
;  MSP430F21x2 Demo - Timer1_A, PWM TA1_1, Up/Down Mode, HF XTAL ACLK
;
;  Description: This program generates one PWM output on P3.7 using
;  Timer1_A configured for up/down mode. The value in TA1CCR0, 128, defines the
;  PWM period/2 and the values in TA1CCR1 the PWM duty cycle.
;  Using HF XTAL ACLK as TA1CLK, the timer period is HF XTAL/256 with a 75%
;  duty cycle on P3.7.
;  ACLK = MCLK = TA1CLK = HF XTAL
;  /* HF XTAL REQUIRED AND NOT INSTALLED ON FET */
;  /* Min Vcc required varies with MCLK frequency - refer to datasheet */
;
;               MSP430F21x2
;            -----------------
;        /|\|              XIN|-
;         | |                 | HF XTAL (3  16MHz crystal or resonator)
;         --|RST          XOUT|-
;           |                 |
;           |       P3.7/TA1_1|--> TA1CCR1 - 75% PWM
;           |                 |
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
SetupP3     bis.b   #080h,&P3DIR            ; P3.7
            bis.b   #080h,&P3SEL            ; T3.7 otions
SetupBC     bis.b   #XTS,&BCSCTL1           ; LFXT1 = HF XTAL
            mov.b   #LFXT1S1,&BCSCTL3       ; LFXT1S1 = 3-16Mhz
SetupOsc    bic.b   #OFIFG,&IFG1            ; Clear OSC fault flag
            mov.w   #0FFh,R15               ; R15 = Delay
SetupOsc1   dec.w   R15                     ; Additional delay to ensure start
            jnz     SetupOsc1               ;
            bit.b   #OFIFG,&IFG1            ; OSC fault flag set?
            jnz     SetupOsc                ; OSC Fault, clear flag again
            bis.b   #SELM_3,&BCSCTL2        ; MCLK = LFXT1
SetupC0     mov.w   #128,&TA1CCR0           ; PWM Period/2
SetupC1     mov.w   #OUTMOD_6,&TA1CCTL1     ; TACCR1 toggle/set
            mov.w   #32,&TA1CCR1            ; TACCR1 PWM Duty Cycle
SetupTA     mov.w   #TASSEL_1+MC_3,&TA1CTL  ; ACLK, updown mode
                                            ;
Mainloop    bis.w   #CPUOFF,SR              ; CPU off
            nop                             ; Required only for debugger
                                            ;
;-------------------------------------------------------------------------------
;			Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect	".reset"				; MSP430 RESET Vector
            .short	RESET                   ;
            .end
