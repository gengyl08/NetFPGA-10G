#
# Example AXI4-Lite stimuli
#

# Four DWORD writes to MDIO (MAC) interface.  Each waits for completion.
77600000, deadc0de, f, -.
77600004, acce55ed, f, -.
77600008, add1c7ed, f, -.
7760000c, cafebabe, f, -.

# Four DWORD quick reads from the MDIO interface (without waits.)
-, -, -, 77600000,
-, -, -, 77600004,
-, -, -, 77600008,
-, -, -, 7760000c.     # Never wrap addresses until after WAIT flag!
