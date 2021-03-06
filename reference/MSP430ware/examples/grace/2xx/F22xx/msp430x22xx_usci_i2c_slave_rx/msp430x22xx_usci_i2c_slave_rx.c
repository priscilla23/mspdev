//******************************************************************************
//  MSP430F22x4 Demo - USCI_B0 I2C Slave RX single bytes from MSP430 Master
//
//  Description: This demo connects two MSP430's via the I2C bus. The master
//  transmits to the slave. This is the slave code. The interrupt driven
//  data receiption is demonstrated using the USCI_B0 RX interrupt.
//  ACLK = n/a, MCLK = SMCLK = default DCO = ~1.2MHz
//
//                                /|\  /|\
//               MSP430F22x4      10k  10k     MSP430F22x4
//                   slave         |    |        master
//             -----------------   |    |  -----------------
//           -|XIN  P3.1/UCB0SDA|<-|---+->|P3.1/UCB0SDA  XIN|-
//            |                 |  |      |                 |
//           -|XOUT             |  |      |             XOUT|-
//            |     P3.2/UCB0SCL|<-+----->|P3.2/UCB0SCL     |
//            |                 |         |                 |
//******************************************************************************
/*
 * ======== Standard MSP430 includes ========
 */
#include <msp430.h>

/*
 * ======== Grace and RTSC related includes ========
 */
#include <ti/mcu/msp430/csl/CSL.h>

/*
 *  ======== main ========
 */

volatile unsigned char RXData;

void main(int argc, char *argv[])
{
    CSL_init();

    while (1)
    {
      __bis_SR_register(CPUOFF + GIE);        // Enter LPM0 w/ interrupts
      __no_operation();                       // Set breakpoint >>here<< and read
    }                                         // RXData
}
void UCB0_RX_ISR (void)
{
    RXData = UCB0RXBUF;                       // Get RX data
}
