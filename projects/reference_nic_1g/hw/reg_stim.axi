#
# Example AXI4-Lite stimuli
#

# 4 DWORD writes to Flash controller.  Each waits for completion.
7A000000, deadc0de, f, -.
7A000004, acce55ed, f, -.
7A000008, add1c7ed, f, -.
7A00000c, cafebabe, f, -.

# 4 DWORD reads from the Flash controller.  Each read waits for completion.
-, -, -, 7A000000.
-, -, -, 7A000004.
-, -, -, 7A000008.
-, -, -, 7A00000c.
