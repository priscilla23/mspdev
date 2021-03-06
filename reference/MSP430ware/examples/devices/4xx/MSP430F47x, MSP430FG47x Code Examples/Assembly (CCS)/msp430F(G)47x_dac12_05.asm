;******************************************************************************
;  MSP430F(G)47x Demo - DAC12_0, Output Voltage Ramp on DAC0, DAC1 Constant, DAC ISR
;
;  Description: Using DAC12.0 outputs a 16 Step Ramp with 1 sample/sec
;  using Timer_B2 trigger. Ramp is output on P1.6. Normal mode is LPM3.
;  DAC1 outputs a constant 1.2V on P1.4.
;  Use internal 1.2V Vref.
;
;               MSP430F(G)47x
;            -----------------
;        /|\|              XIN|-
;         | |                 |
;         --|RST          XOUT|-
;           |                 |
;           |        DAC0/P1.4|--> Ramp_positive
;           |        DAC1/P1.6|--> 1.2V
;
;   P.Thanigai
;   Texas Instruments Inc.
;   September 2008
;   Built with Code Composer Essentials Version: 3.0
;******************************************************************************
 .cdecls C,LIST, "msp430xG47x.h" 

;------------------------------------------------------------------------------
            .text                           ; Program Start
;------------------------------------------------------------------------------
RESET       mov.w   #0A00h,SP               ; Initialize stack pointer
StopWDT     mov     #WDTPW+WDTHOLD,&WDTCTL  ; Stop Watchdog Timer
SetupSD16   mov.w   #SD16REFON,&SD16CTL     ; Internal 1.2V ref on
            mov.w   #OUTMOD_7,&TBCCTL2      ; Reset/set
            mov.w   #16384,&TBCCR2          ; PWM Duty Cycle
            mov.w   #32767,&TBCCR0          ; 1Hz Clock period
            mov.w   #TBSSEL_1+MC_1,&TBCTL   ; ACLK, up mode
SetupDAC120 mov.w   #DAC12IR + DAC12AMP_5 + DAC12ENC + DAC12SREF_3 + DAC12CALON + DAC12OPS + DAC12IE + DAC12LSEL_3,&DAC12_0CTL
SetupDAC121 mov.w   #DAC12IR + DAC12AMP_5 + DAC12ENC + DAC12SREF_3 + DAC12CALON + DAC12OPS,&DAC12_1CTL
            mov.w   #0FFFh,&DAC12_1DAT      ; 1.2V
            eint                            ; Interrupts enabled
            inc.w   &DAC12_0DAT             ; Positive ramp
            bis.w   #LPM3,SR                ; Enter LPM3

;------------------------------------------------------------------------------
DAC12_ISR;    Common ISR for DAC12 and DMA
;------------------------------------------------------------------------------
            bic     #DAC12IFG,&DAC12_0CTL
            add     #256,&DAC12_0DAT
            and.w   #0FFFh,&DAC12_0DAT      ;
            reti
;-----------------------------------------------------------------------------
;           Interrupt Vectors Used
;-----------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET                   ;
            .sect   ".int03"                     ; MSP430 RESET Vector
            .short  DAC12_ISR 
            .end
