//******************************************************************************
//   MSP430xG46x Demo - XT2 Oscillator Fault Detection
//
//   Description: System runs normally in LPM3 with with basic timer clocked by
//   ACLK.  BT interrupt causes an exit from LPM3, and mainloop toggles P5.1.
//   If an XT2 oscillator fault occurs, NMI is requested, pausing execution and
//   flashing LED quickly until fault is resolved.  Assumed only XT2 as NMI
//   source - code does not check for other NMI sources.
//   MCLK = XT2 = 8MHz normally, within ISRs MCLK = DCO freq ~1048kHz
//   //* An external 8MHx crystal is required between XT2 and XT2OUT , and
//   an external 32kHz crystal is required between XIN and XOUT.  *//	
//
//                MSP430xG46x
//             -----------------
//         /|\|              XIN|-
//          | |                 | 32KHz
//          --|RST          XOUT|-
//            |                 |
//            |            XT2IN|-
//            |                 | 8MHz
//            |           XT2OUT|-
//            |                 |
//            |             P5.1|--> LED
//
//  K. Quiring/ M. Mitchell
//  Texas Instruments Inc.
//  October 2006
//  Built with CCE Version: 3.2.0 and IAR Embedded Workbench Version: 3.41A
//******************************************************************************
#include  <msp430xG46x.h>

void main(void)
{
  volatile unsigned int i;

  WDTCTL = WDTPW+WDTHOLD;                   // Stop WDT
  FLL_CTL0 |= XCAP14PF;                     // Configure load caps
  FLL_CTL1 &= ~XT2OFF;                      // Clear bit = HFXT2 on

  // Wait for xtal to stabilize
  do
  {
  IFG1 &= ~OFIFG;                           // Clear OSCFault flag
  for (i = 0x47FF; i > 0; i--);             // Time for flag to set
  }
  while ((IFG1 & OFIFG));                   // OSCFault flag still set?
  FLL_CTL1 |= SELM_XT2;                     // MCLK = XT2

  P1DIR |= 0x002;                           // P1.1 output direction
  P1SEL |= 0x002;                           // P1.1 option select

  BTCTL = BT_ADLY_1000;                     // One-second interrupt
  IE2 |= BTIE;                              // Enable Basic Timer interrupt

  P5DIR |= 0x002;                           // P5.1 = output direction

// An immediate Osc Fault will occur next
  IE1 |= OFIE;                              // Enable osc fault interrupt


  while(1)
  {
    _BIS_SR(LPM3_bits + GIE);               // Enter LPM3, enable interrupts
    P5OUT ^= 0x02;                          // Toggle P5.1
  }
}

#pragma vector=NMI_VECTOR
__interrupt void nmi_ (void)
{
  volatile unsigned int i;

  do
  {
    IFG1 &= ~OFIFG;                         // Clear OSC Fault flag
    for (i = 0x47FF; i > 0; i--);           // Time for flag to set
    P5OUT ^= 0x02;                          // Toggle P5.2 using exclusive-OR
  }
  while (IFG1 & OFIFG);                     // OSC Fault flag still set?
  IE1 |= OFIE;                              // Enable Osc Fault
}


// Basic Timer interrupt service routine
#pragma vector=BASICTIMER_VECTOR
__interrupt void basic_timer(void)
{
  _BIC_SR_IRQ(LPM3_bits+GIE);               // Exit LPM3 upon ISR exit
}
