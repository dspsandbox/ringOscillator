################################################################################

# This XDC is used only for OOC mode of synthesis, implementation
# This constraints file contains default clock frequencies to be used during
# out-of-context flows such as OOC Synthesis and Hierarchical Designs.
# This constraints file is not used in normal top-down synthesis (default flow
# of Vivado)
################################################################################
create_clock -name ck_io8 -period 5 [get_ports ck_io8]
create_clock -name PS_processing_system7_0_FCLK_CLK0 -period 5 [get_pins PS/processing_system7_0/FCLK_CLK0]

################################################################################