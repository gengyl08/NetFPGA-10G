

#ifndef NETWAVE_API_H_
#define NETWAVE_API_H_
#endif /* NETWAVE_API_H_ */

// ----------------------------------------------------------------------------
// --    Netwave API definitions  -- 
// ----------------------------------------------------------------------------

// -- returns IP packet size -- 
int get_IP_packetsize(uint_data_width packet_in_data[], uint_data_width packet_out_data[]);

// -- gets IP header in packet_out_data -- 
void get_IP_header(uint_data_width packet_in_data[], int ipv4or6, uint_data_width packet_out_data[]);

// -- gets IP payload in packet_out_data -- 
void get_IP_payload(uint_data_width packet_in_data[], int ipv4or6, int packet_size, uint_data_width packet_out_data[]);

// -- gets UDP header in packet_out_data --- 
void get_UDP_header(uint_data_width packet_in_data[], uint_data_width packet_out_data[]);

// --- gets UDP payload in packet_out_data --- 
void get_UDP_payload(uint_data_width packet_in_data[], int ipv4or6, int packet_size, uint_data_width packet_out_data[]);

// --- removes RTP header and emits payload in packet_out_data -- 
void remove_RTP_header(uint_data_width packet_in_data[], uint1 offset_flag, int packet_size, uint_data_width packet_out_data_aux[], uint_data_width packet_out_data[]) ;


// -----------------------------------------------------------------------------
// --    Netwave API implementation -- 
// ------------------------------------------------------------------------------



int get_IP_packetsize(uint_data_width packet_in_data[], uint_data_width packet_out_data[]) {

#pragma AP INLINE self

  uint_data_width data_in;
  int total_length = 100, packet_size = 100;

  data_in = packet_in_data[0];

#if CONF_IPV6
  total_length = apint_get_range(data_in, 47, 32);
#else
  total_length = apint_get_range(data_in, 31, 16);
#endif
  printf("total length is ... %d \n", total_length);
  
  
  if ((total_length % 8) == 0) {
    packet_size = (total_length/8);
  } else {
    packet_size = (total_length/8) + 1;
  }
  
  packet_out_data[0] = data_in;
  return packet_size;

}

void get_IP_header(uint_data_width packet_in_data[], int ipv4or6, uint_data_width packet_out_data[]) {
  
#pragma AP INLINE self

  //#pragma AP interface ap_fifo port=packet_in_data
  //#pragma AP interface ap_fifo port=packet_out_data


  int i=0;
  int loop_limit = 2;

  if (ipv4or6) // ipv4or6=1 is ipv4; = 0 is ipv6
    loop_limit = 2;
  else
    loop_limit = 5;

  for(i=1;i<loop_limit;i++) {
    packet_out_data[i] = packet_in_data[i];
  } 

}



void get_IP_payload(uint_data_width packet_in_data[], int ipv4or6, int packet_size, uint_data_width packet_out_data[]) {
  
#pragma AP INLINE self

  //#pragma AP interface ap_fifo port=packet_in_data
  //#pragma AP interface ap_fifo port=packet_out_data


  int i=0;
  int loop_limit = 3, loop_start=2;

  if (ipv4or6) 
    loop_start = 2;
  else
    loop_start = 5;

  loop_limit = packet_size;

  for(i=loop_start;i<loop_limit;i++) {
    packet_out_data[i-loop_start] = packet_in_data[i];
  } 


}

void get_UDP_header(uint_data_width packet_in_data[], uint_data_width packet_out_data[]) {

#pragma AP INLINE self

  //#pragma AP interface ap_fifo port=packet_in_data
  //#pragma AP interface ap_fifo port=packet_out_data


  packet_out_data[0] = packet_in_data[0];
}


void get_UDP_payload(uint_data_width packet_in_data[], int ipv4or6, int packet_size, uint_data_width packet_out_data[]) {

#pragma AP INLINE self


  int i=0;
  int loop_limit = 3, loop_start=2;

  if (ipv4or6) 
    loop_start = 2;
  else
    loop_start = 5;

  loop_limit = packet_size - loop_start;

  for(i=1;i<loop_limit;i++) {
      packet_out_data[i-1] = packet_in_data[i];
  } 


}

void remove_RTP_header(uint_data_width packet_in_data[], uint1 offset_flag, int packet_size, uint_data_width packet_out_data_aux[], uint_data_width packet_out_data[]) {
  
#pragma AP INLINE self



  int input_count=0, output_count0=0, output_count1=0;
  int cc = 0, xbit=0, i=0; 
  int ehl = 0, extension_header_length = 0, csrc_length=0; 
  int loop_count1=0,loop_count2=0,loop_count3=0;
  uint_data_width data_in;
  
  
  for(i=0;i<(packet_size - 3);i++) {
    data_in = packet_in_data[input_count];
    input_count++;
    
    
    if (i < 2) {
      
      if (i == 0) {
	
	if (offset_flag == 1) {
	  cc = apint_get_range(data_in, (32+7), (32+4));
	  xbit = apint_get_range(data_in, (32+4), (32+3));
	  offset_flag = 0;
	  loop_count1 = 1;
	} else {
	  cc = apint_get_range(data_in, 7, 4);
	  xbit = apint_get_range(data_in, 4, 3);
	}
	
      }  // i==0
      
      if (i == 1) {
	
	if (cc !=0) {
	  csrc_length = cc*4;
	  if ((csrc_length % 8) == 0) { 
	    loop_count1 = loop_count1 + (csrc_length/8)+ 2;   // +2 for rtp header fixed size which we already iterated over
	  } else {
	    loop_count1 = loop_count1 + (csrc_length/8) + 1 + 2;
	    offset_flag = 1;   // no handling for the last offset as yet
	  }
	  
	} // cc!=0
	else 
	  loop_count1 = loop_count1 + 2; // still goes to third cycle if there is offset earlier
	
      } // i==1
      
      packet_out_data_aux[output_count0] = data_in;
      output_count0++;
      printf("i0 = %d, data_in = %016llx \n", i, data_in);
      
    } else if (i < loop_count1){
      if (xbit == 1) loop_count2 = loop_count1 + 1;
      
      packet_out_data_aux[output_count0] = data_in;
      output_count0++;
      printf("i0 = %d, data_in = %016llx \n", i, data_in);
      
    } else if ((xbit == 1) && (i < loop_count2)) {
      
      if (offset_flag == 1) {
	extension_header_length = apint_get_range(data_in, (32+31), (32+16));
      } else {
	extension_header_length = apint_get_range(data_in, 31, 16);
      }
      ehl = extension_header_length*4;
      
      if ((ehl % 8) == 0) {
	loop_count3 = loop_count2 + (ehl/8);
      } else {
	loop_count3 = loop_count2 + (ehl/8) + 1;
      }
      
      packet_out_data_aux[output_count0] = data_in;
      output_count0++;
      printf("i0 = %d, data_in = %016llx \n", i, data_in);
      
    } else if (i < loop_count3) {
      
      packet_out_data_aux[output_count0] = data_in;
      output_count0++;
      printf("i0 = %d, data_in = %016llx \n", i, data_in);
      
    } else {
      packet_out_data[output_count1] = data_in;
      output_count1++;
      printf("i = %d, data_in = %016llx\n", i, data_in);
      printf("header_removal/rtp: data_out: %016llx\n",data_in);
    }
    
    
  } // for loop
  
  
}
