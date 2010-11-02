NetFPGA 10G Production Test
===========================
Change log
9/29/2010 James integrated XAUI and Aurora
===========================
ISE/EDK Version 12.3
Board Rev 4
===========================

Part 1. Test flow
1) Board setup
- SUPER CLOCK A SEL0-N0: UUUDDDUU
- SUPER CLOCK B SEL0-N0: UUUDUDUD
- PCIe CLOCK SEL0-SEL2: RLL
- MODE PINS M0-M2 RRR
2) Cable setup
- Connect Port 0 - Port 1 and Port 2 - Port 3 with SFP+ Direct Attach cable
- JTAG cable
- RS232 UART cable
3) Test
- Download bitstream from bin/
- In UART, press i for initialization
- In UART, press s to start testing

Part 2. Rebuld bitstream
1) XPS flow
- Open xps/system.xmp in Xilinx Platform Studio
- Click Hardware - Generate Netlist
- Click Software - Build All User Applications
2) ISE flow
- cd to ise/synth
- Run ./implement.sh
3) Bitstream
- Final bitstream is at ise/synth/final.bit
