/* $Id: emaclite_intr_header.h,v 1.1.2.1 2009/07/20 14:16:12 svemula Exp $ */


#include "xbasic_types.h"
#include "xstatus.h"

XStatus EmacLiteIntrExample(XIntc* IntcInstancePtr,
                        XEmacLite* EmacLiteInstPtr,
                        Xuint16 EmacLiteDeviceId,
                        Xuint16 EmacLiteIntrId);

