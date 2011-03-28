#include<autopilot_tech.h>
#include "header_removal.h"
#include "netwave_api.h"


void header_removal (uint_data_width packet_in_data[], uint_data_width packet_out_data_aux[], uint_data_width packet_out_data[]) {


	uint_data_width packet_out_data_tmp[1024], packet_out_data_tmp2[1024];
	int packet_size = 100;
	int total_length=0, payload_length=0;
	uint1 offset_flag=0;

	int ipv4or6 = 1;

	printf("------------ start simulation --------------- \n");
	printf(" --- IP processing starts --- \n");
        // -----------------------------------------------------------------------
	//  IP processing
	// ------------------------------------------------------------------------

#if CONF_IPV6
	offset_flag = 0;
#else
	offset_flag = 1;
#endif

	packet_size = get_IP_packetsize(packet_in_data, packet_out_data_aux);
	get_IP_header(packet_in_data, ipv4or6, packet_out_data_aux);
	get_IP_payload(packet_in_data, ipv4or6, packet_size, packet_out_data_tmp);

        // -----------------------------------------------------------------------
	//  UDP processing: 
	// ------------------------------------------------------------------------

	printf(" --- start of UDP processing --- \n");

	get_UDP_header(packet_out_data_tmp, packet_out_data_aux);
	get_UDP_payload(packet_out_data_tmp, ipv4or6, packet_size, packet_out_data_tmp2);

	printf(" --- end of UDP processing --- \n");

        // -----------------------------------------------------------------------
	//  RTP processing
        //  Assumption: No extension header if cc==0; We can remove this by adding additional guards.
	// ------------------------------------------------------------------------

	printf(" --- start of RTP processing --- \n");

	// ipv4or6? 
	remove_RTP_header(packet_out_data_tmp2, offset_flag, packet_size, packet_out_data_aux, packet_out_data);

	printf(" --- end of RTP processing --- \n");
	printf("-------------  end simulation ------------------ \n \n");
}

