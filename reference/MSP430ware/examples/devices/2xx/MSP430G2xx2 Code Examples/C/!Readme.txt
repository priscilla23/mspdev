File Name                        Description
----------------------------------------------------------------------------------------
msp430g2x12_ca_01.c              Comp_A, Output Reference Voltages on P1.1
msp430g2x12_ca_02.c              Comp_A, Detect Threshold, Set P1.0 if P1.1 > 0.25*Vcc
msp430g2x12_ca_03.c              Comp_A, Simple 2.2V Low Battery Detect
msp430g2x32_adc10_01.c           ADC10, Sample A0, Set P1.0 if A0 > 0.5*AVcc
msp430g2x32_adc10_02.c           ADC10, Sample A1, 1.5V Ref, Set P1.0 if A1 > 0.2V
msp430g2x32_adc10_03.c           ADC10, ADC10, Sample A10 Temp, Set P1.0 if Temp ++ ~2C
msp430g2x32_adc10_04.c           ADC10, ADC10, Sample A1, Signed, Set P1.0 if A1 > 0.5*AVcc
msp430g2x32_adc10_05.c           ADC10, ADC10, Sample A11, Lo_Batt, Set P1.0 if AVcc < 2.3V
msp430g2x32_adc10_06.c           ADC10, ADC10, Output Internal Vref on P1.4 & ADCCLK on P1.3
msp430g2x32_adc10_07.c           ADC10, DTC Sample A1 32x, AVcc, Repeat Single, DCO
msp430g2x32_adc10_08.c           ADC10, ADC10, DTC Sample A1 32x, 1.5V, Repeat Single, DCO
msp430g2x32_adc10_09.c           ADC10, ADC10, DTC Sample A10 32x, 1.5V, Repeat Single, DCO
msp430g2x32_adc10_10.c           ADC10, ADC10, DTC Sample A3-01, AVcc, Single Sequence, DCO
msp430g2x32_adc10_11.c           ADC10, ADC10, Sample A1, 1.5V, TA1 Trig, Set P1.0 if > 0.5V
msp430g2x32_adc10_12.c           ADC10, Sample A7, 1.5V, TA1 Trig, Ultra-Low Pwr
msp430g2x32_adc10_13.c           ADC10, DTC Sample A1 32x, AVcc, TA0 Trig, DCO
msp430g2x32_adc10_14.c           ADC10, DTC Sample A1-0 16x, AVcc, Repeat Seq, DCO
msp430g2x32_adc10_16.c           ADC10, ADC10, DTC Sample A0 -> TA1, AVcc, DCO
msp430g2x32_adc10_temp.c         ADC10, Sample A10 Temp and Convert to oC and oF
msp430g2xx2_1.c                  Software Toggle P1.0
msp430g2xx2_1_vlo.c              Software Toggle P1.0, MCLK = VLO/8
msp430g2xx2_clks.c               Basic Clock, Output Buffered SMCLK, ACLK and MCLK/10
msp430g2xx2_dco_calib.c          Basic Clock with preloaded DCO calibration constants 
msp430g2xx2_dco_flashcal.c       DCO Calibration Constants Programmer
msp430g2xx2_flashwrite_01.c      Flash In-System Programming, Copy SegC to SegD
msp430g2xx2_LFxtal_nmi.c         LFXT1 Oscillator Fault Detection
msp430g2xx2_lpm3.c               Basic Clock, LPM3 Using WDT ISR, 32kHz ACLK
msp430g2xx2_lpm3_vlo.c           Basic Clock, LPM3 Using WDT ISR, VLO ACLK
msp430g2xx2_nmi.c                Basic Clock, Configure RST/NMI as NMI
msp430g2xx2_P1_01.c              Software Poll P1.4, Set P1.0 if P1.4 = 1
msp430g2xx2_P1_02.c              Software Port Interrupt Service on P1.4 from LPM4
msp430g2xx2_P1_03.c              Poll P1 With Software with Internal Pull-up
msp430g2xx2_P1_04.c              P1 Interrupt from LPM4 with Internal Pull-up
msp430g2xx2_pinosc_01.c          Capacitive Touch, Pin Oscillator Method, 1 button
msp430g2xx2_pinosc_02.c          Capacitive Touch, Pin Oscillator Method, 4-buttons
msp430g2xx2_pinosc_03.c          Capacitive Touch, Pin Oscillator Method, 4-buttons, ACLK for CCR
msp430g2xx2_pinosc_04.c          Capacitive Touch, Pin Oscillator Method, 8 buttons, UART
msp430g2xx2_ta_01.c              Timer_A, Toggle P1.0, CCR0 Cont. Mode ISR, DCO SMCLK
msp430g2xx2_ta_02.c              Timer_A, Toggle P1.0, CCR0 Up Mode ISR, DCO SMCLK
msp430g2xx2_ta_03.c              Timer_A, Toggle P1.0, Overflow ISR, DCO SMCLK
msp430g2xx2_ta_04.c              Timer_A, Toggle P1.0, Overflow ISR, 32kHz ACLK
msp430g2xx2_ta_05.c              Timer_A, Toggle P1.0, CCR0 Up Mode ISR, 32kHz ACLK
msp430g2xx2_ta_06.c              Timer_A, Toggle P1.0, CCR1 Cont. Mode ISR, DCO SMCLK
msp430g2xx2_ta_07.c              Timer_A, Toggle P1.0-2, Cont. Mode ISR, DCO SMCLK
msp430g2xx2_ta_08.c              Timer_A, Toggle P1.0-2, Cont. Mode ISR, 32kHz ACLK
msp430g2xx2_ta_10.c              Timer_A, Toggle P1.1/TA0, Up Mode, DCO SMCLK
msp430g2xx2_ta_11.c              Timer_A, Toggle P1.1/TA0, Up Mode, 32kHz ACLK
msp430g2xx2_ta_13.c              Timer_A, Toggle P1.1/TA0, Up/Down Mode, DCO SMCLK
msp430g2xx2_ta_14.c              Timer_A, Toggle P1.1/TA0, Up/Down Mode, 32kHz ACLK
msp430g2xx2_ta_16.c              Timer_A, PWM TA1-2, Up Mode, DCO SMCLK
msp430g2xx2_ta_17.c              Timer_A, PWM TA1, Up Mode, 32kHz ACLK
msp430g2xx2_ta_19.c              Timer_A, PWM TA1, Up/Down Mode, DCO SMCLK
msp430g2xx2_ta_20.c              Timer_A, PWM TA1, Up/Down Mode, 32kHz ACLK
msp430g2xx2_ta_uart2400.c        Timer_A, Ultra-Low Pwr UART 2400 Echo, 32kHz ACLK
msp430g2xx2_ta_uart9600.c        Timer_A, Ultra-Low Pwr Full-duplex UART 9600, 32kHz ACLK
msp430g2xx2_usi_01.c             USICNT Used as a One-Shot Timer Function, DCO SMCLK
msp430g2xx2_usi_02.c             SPI full-Duplex 3-wire Master
msp430g2xx2_usi_03.c             SPI full-Duplex 3-wire Slave
msp430g2xx2_usi_04.c             USI SPI Interface with HC165/164 Shift Registers
msp430g2xx2_usi_05.c             USI SPI Interface to TLC549 8-bit ADC
msp430g2xx2_usi_06.c             I2C Master Receiver, single byte
msp430g2xx2_usi_07.c             I2C Master Transmitter, single byte
msp430g2xx2_usi_08.c             I2C Slave Receiver, single byte
msp430g2xx2_usi_09.c             I2C Slave Transmitter, single byte
msp430g2xx2_usi_12.c             I2C Master Transmitter / Receiver, Multiple Bytes (no rpt st) 
msp430g2xx2_usi_15.c             I2C Slave Receiver Universal code (to be used with usi_12)
msp430g2xx2_usi_16.c             I2C Master Transmitter / Reciever, Repeated Start (to be used with usi_15)
msp430g2xx2_wdt_01.c             WDT, Toggle P1.0, Interval Overflow ISR, DCO SMCLK
msp430g2xx2_wdt_02.c             WDT, Toggle P1.0, Interval Overflow ISR, 32kHz ACLK
msp430g2xx2_wdt_04.c             WDT+ Failsafe Clock, DCO SMCLK
msp430g2xx2_wdt_05.c             Reset on Invalid Address fetch, Toggle P1.0
msp430g2xx2_wdt_06.c             WDT+ Failsafe Clock, 32kHz ACLK
msp430g2xx2_wdt_07.c             WDT+ periodic reset

