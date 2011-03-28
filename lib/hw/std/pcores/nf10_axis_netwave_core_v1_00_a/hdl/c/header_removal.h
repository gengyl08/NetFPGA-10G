#include "autopilot_tech.h"

#define READ 0
#define WRITE 1

#define BYTE_SIZE 8				/*size of a BYTE*/

#define DATA_WIDTH 64         	        	/*will determine bus widths */
typedef uint64 uint_data_width;

#define NUM_BYTES (DATA_WIDTH/8)	/*number of bytes in a received word*/

#if CONF_IPV6
#define IPH_LEN    40
#else 							/* CONF_IPV6 */
#define IPH_LEN    20    				/* Size of IP header */
#endif

#define UDPH_LEN    8    				/* Size of UDP header */

#define RTPH_LEN    12    				/* Size of RTP header */

/*
 * header_removal.h
 *
 *  Created on: Dec 3, 2010
 *      Author: ronakb
 */

#ifndef HEADER_REMOVAL_H_
#define HEADER_REMOVAL_H_


#endif /* HEADER_REMOVAL_H_ */
