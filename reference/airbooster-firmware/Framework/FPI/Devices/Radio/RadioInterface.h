/**
 *  @file RadioInterface.h
 *
 *  @brief Hardware Abstraction Layer (HAL) Framework radio public interface 
 *         prototype definition header files. Requires ProcessorInterface.h to 
 *         function.
 *
 *  @see ProcessorInterface.h
 *
 *  @version  1.0
 *
 *  @attention IMPORTANT: Your use of this Software is limited to those specific 
 *             rights granted under the terms of a software license agreement 
 *             between the user who downloaded the software, his/her employer 
 *             (which must be your employer) and Anaren (the "License"). You may
 *             not use this Software unless you agree to abide by the terms of 
 *             the License. The License limits your use, and you acknowledge,
 *             that the Software may not be modified, copied or distributed unless
 *             in connection with an authentic Anaren product. Other than for the 
 *             foregoing purpose, you may not use, reproduce, copy, prepare 
 *             derivative works of, modify, distribute, reverse engineer, decompile,
 *             perform, display or sell this Software and/or its documentation 
 *             for any purpose. 
 *             YOU FURTHER ACKNOWLEDGE AND AGREE THAT THE SOFTWARE AND DOCUMENTATION
 *             ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS 
 *             OR IMPLIED, INCLUDING WITHOUT LIMITATION, ANY  WARRANTY OF 
 *             MERCHANTABILITY, TITLE, NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR 
 *             PURPOSE. IN NO EVENT SHALL ANAREN OR ITS LICENSORS BE LIABLE OR
 *             OBLIGATED UNDER CONTRACT, NEGLIGENCE, STRICT LIABILITY, CONTRIBUTION,
 *             BREACH OF WARRANTY, OR OTHER LEGAL EQUITABLE THEORY ANY DIRECT OR 
 *             INDIRECT DAMAGES OR EXPENSES INCLUDING BUT NOT LIMITED TO ANY 
 *             INCIDENTAL, SPECIAL, INDIRECT, PUNITIVE OR CONSEQUENTIAL DAMAGES, 
 *             LOST PROFITS OR LOST DATA, COST OF PROCUREMENT OF SUBSTITUTE GOODS,
 *             TECHNOLOGY, SERVICES, OR ANY CLAIMS BY THIRD PARTIES (INCLUDING BUT
 *             NOT LIMITED TO ANY DEFENSE THEREOF), OR OTHER SIMILAR COSTS.
 */
#ifndef __HAL_RADIOINTERFACE_H
#define __HAL_RADIOINTERFACE_H

#include "../../../Configuration/Config.h"

// If the board defines a radio, include the interface.
#if defined(__BOARD_RADIO)

// Radio configuration
#if defined(__RADIO_CCXXX_SERIES)
  #include "CCXXX/Configuration/CCXXXConfig.h"
#endif

// Processor interface
#include "../MCU/MCUInterface.h"

// PUBLIC INTERFACE
////////////////////////////////////////////////////////////////////////////////

#if defined(__RADIO_CCXXX_SERIES)
  #include "CCXXX/CCXXXInterface.h"
#endif

#endif  // Radio is defined on board?

#endif	// __HAL_RADIOINTERFACE_H