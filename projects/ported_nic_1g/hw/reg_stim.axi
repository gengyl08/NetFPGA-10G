#
# Example AXI4-Lite stimuli
#

# 4 DWORD writes to Flash controller.  Each waits for completion.
77600000, deadc0de, f, -.
77600004, acce55ed, f, -.
77600008, add1c7ed, f, -.
7760000c, cafebabe, f, -.

# 4 DWORD reads from the Flash controller.  Each read waits for completion.
-, -, -, 77600000.
-, -, -, 77600004.
-, -, -, 77600008.
-, -, -, 7760000c.
