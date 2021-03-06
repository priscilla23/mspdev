;*******************************************************************************
;   MSP430x11x1 Demo - Software SPI Interface to TLV5616 12-Bit DAC
;
;   Description: Drive serial communications with TLV5616 12-bit DAC. A sine
;   wave is generated using a a 32-step sine look-up table Sin_Tab. R5 is
;   used as a pointer into Sin_Tab, R6 holds the 12-bit data and R7 is used
;   as a temporary bit counter.
;   ACLK = n/a, MCLK = SMCLK = default DCO ~800k
;
;                 MSP430F1121
;             -----------------
;        /|\ |              XIN|-
;         |  |                 |      TLV5616
;         ---|RST          XOUT|-   ----------
;            |             P2.3|-->|FS     OUT|--> ~75hz sine wave
;            |             P2.0|-->|DIN       |
;            |             P2.1|-->|SCLK    CS|-|
;            |                 |   |          | v
;
DOUT        .equ    001h                    ; P2.0 Data Out
SCLK        .equ    002h                    ; P2.1 Serial Clock
FS          .equ    008h                    ; P2.3 Frame Sync
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
RESET       mov.w   #0300h,SP               ; Initialize stackpointer
StopWDT     mov.w   #WDTPW+WDTHOLD,&WDTCTL  ; Stop Watchdog Timer
SetupP1     bis.b   #FS+SCLK,&P2OUT         ; FS, SCLK .set
            bis.b   #FS+SCLK+DOUT,&P2DIR    ; FS,Clk and DOUT as outputs
                                            ;
Mainloop    incd.w  R5                      ; R5 = sine table pointer
            and.w   #03Eh,R5                ; 32 steps in table
            mov.w   Sin_tab(R5),R6          ; R6 = Sine value
                                            ;
            bic.b   #FS,&P2OUT              ; FS low, enable DAC
            mov.w   #16,R7                  ; R7 = 16 bits to shift out
DAC_Loop    rlc.w   R6                      ; C = Data bit
Out_0       bic.b   #DOUT,&P2OUT            ; DOUT reset
            jnc     Clk_0                   ;
Out_1       bis.b   #DOUT,&P2OUT            ; DOUT .set
Clk_0       bic.b   #SCLK,&P2OUT            ; SCLK reset, data latched
            dec.w   R7                      ;
Clk_1       bis.b   #SCLK,&P2OUT            ; SCLK .set
            jnz     DAC_Loop                ;
            bis.b   #FS,&P2OUT              ; FS high, disable DAC
            jmp     Mainloop                ; Repeat
                                            ;
;-------------------------------------------------------------------------------
; 12-bit Sine Lookup table with 32 steps
;-------------------------------------------------------------------------------
Sin_tab     .short   2048
            .short   2447
            .short   2831
            .short   3185
            .short   3495
            .short   3750
            .short   3939
            .short   4056
            .short   4095
            .short   4056
            .short   3939
            .short   3750
            .short   3495
            .short   3185
            .short   2831
            .short   2447
            .short   2048
            .short   1648
            .short   1264
            .short   910
            .short   600
            .short   345
            .short   156
            .short   39
            .short   0
            .short   39
            .short   156
            .short   345
            .short   600
            .short   910
            .short   1264
            .short   1648
;
;-------------------------------------------------------------------------------
;           Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET                   ;
            .end

