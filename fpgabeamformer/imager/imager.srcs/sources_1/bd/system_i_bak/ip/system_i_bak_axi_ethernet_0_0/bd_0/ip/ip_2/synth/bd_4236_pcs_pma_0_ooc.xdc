
# This constraints file contains default clock frequencies to be used during creation of a 
# Synthesis Design Checkpoint (DCP). For best results the frequencies should be modified 
# to match the target frequencies. 
# This constraints file is not used in top-down/global synthesis (not the default flow of Vivado).

#################
#DEFAULT CLOCK CONSTRAINTS

############################################################
# Clock Period Constraints                                 #
############################################################



create_clock -name clk125m -period 8.000 [get_ports clk125m]
# constraints for Native mode of LVDS solution
  # constraints for Component mode of LVDS solution
  create_generated_clock -name clk312 -multiply_by 5 -divide_by 2 -source [get_ports clk125m] [get_ports clk312]
  create_generated_clock -name clk625 -multiply_by 5 -source [get_ports clk125m] [get_ports clk625]


