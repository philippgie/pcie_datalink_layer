################################################################################
# LambdaConcept PCIe Squirrel - XC7A35T-FGG484-2
# M.2 Form Factor PCIe Endpoint
#
# Pin mappings verified against:
#   - pcileech-fpga/PCIeSquirrel/src/pcileech_squirrel.xdc
#   - pcileech-fpga/PCIeSquirrel/vivado_generate_project.tcl (part: xc7a35tfgg484-2)
#   - enjoy-digital/pcie_screamer (transceiver locations)
#
# NOTE: The PCIe Squirrel uses the FGG484 package which has GTP transceivers
################################################################################

################################################################################
# PCIe Reference Clock (100MHz Differential from M.2 Slot)
# Using Bank 35 SRCC pins for clock input
# H3 = IO_L11P_T1_SRCC_35 (positive), G3 = IO_L11N_T1_SRCC_35 (negative)
################################################################################
set_property PACKAGE_PIN H3 [get_ports sys_clk_p]
set_property PACKAGE_PIN G3 [get_ports sys_clk_n]
set_property IOSTANDARD LVDS_25 [get_ports {sys_clk_p sys_clk_n}]

# Clock constraint for 100MHz PCIe reference clock
create_clock -name sys_clk_p -period 10.0 [get_ports sys_clk_p]

################################################################################
# IBUFDS_GTE2 Location Constraint
# Must be in the same quad as the GTP transceiver (X0Y2)
################################################################################
#set_property LOC IBUFDS_GTE2_X0Y2 [get_cells refclk_ibuf]

################################################################################
# GTP Transceiver Location
# Lane 0 uses GTPE2_CHANNEL_X0Y2 (verified from pcileech reference)
################################################################################
set_property LOC GTPE2_CHANNEL_X0Y2 [get_cells {pipe_wrapper_i/gtpe2_channell_i}]

################################################################################
# PCIe Lane 0 TX/RX Differential Pairs
# These are dedicated GTP transceiver pins - no IOSTANDARD needed
################################################################################
# PCIe TX Lane 0 (Endpoint -> Root Complex)
set_property PACKAGE_PIN B6  [get_ports {pci_exp_txp[0]}]
set_property PACKAGE_PIN A6  [get_ports {pci_exp_txn[0]}]

# PCIe RX Lane 0 (Root Complex -> Endpoint)
set_property PACKAGE_PIN B10 [get_ports {pci_exp_rxp[0]}]
set_property PACKAGE_PIN A10 [get_ports {pci_exp_rxn[0]}]

################################################################################
# PCIe Reset (PERST# - Active Low)
# From M.2 slot reset signal
################################################################################
set_property PACKAGE_PIN B13 [get_ports sys_rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports sys_rst_n]
set_property PULLUP true [get_ports sys_rst_n]

################################################################################
# Status LEDs
# Active-high LEDs for status indication
################################################################################
# LED 0 - Link Up Indicator
set_property PACKAGE_PIN Y6 [get_ports led_0]
set_property IOSTANDARD LVCMOS33 [get_ports led_0]

# LED 1 - Activity / Flow Control Initialized
set_property PACKAGE_PIN AB5 [get_ports led_1]
set_property IOSTANDARD LVCMOS33 [get_ports led_1]

################################################################################
# Optional PCIe Sideband Signals
# From pcileech reference - directly from M.2 connector
# Uncomment if used in your design
################################################################################
# PCIe Present Detect
# set_property PACKAGE_PIN A13 [get_ports pcie_present]
# set_property IOSTANDARD LVCMOS33 [get_ports pcie_present]

# PCIe Wake (active low)
# set_property PACKAGE_PIN A14 [get_ports pcie_wake_n]
# set_property IOSTANDARD LVCMOS33 [get_ports pcie_wake_n]

################################################################################
# Configuration Settings
################################################################################
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

# SPI Flash Configuration (for bitstream storage)
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES [current_design]

################################################################################
# Timing Constraints
################################################################################

# False paths for reset synchronizers
set_false_path -from [get_ports sys_rst_n]
