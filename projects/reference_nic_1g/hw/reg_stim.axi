#
# Example AXI4-Lite stimuli
#

# Four DWORD writes to MDIO (MAC) interface.  Each waits for completion.
7A000000, deadc0de, f, -.
7A000004, acce55ed, f, -.
7A000008, add1c7ed, f, -.
7A00000c, cafebabe, f, -.

# Four DWORD quick reads from the MDIO interface (without waits.)
-, -, -, 7A000000,
-, -, -, 7A000004,
-, -, -, 7A000008,
-, -, -, 7A00000c.     # Never wrap addresses until after WAIT flag!
