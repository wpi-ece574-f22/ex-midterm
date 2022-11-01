export DESIGN_NAME = movavg
export PLATFORM    = sky130hd

export VERILOG_FILES = /OpenROAD-flow-scripts/flow/mydesign/midterm-patrickschaumont/fastpipe/rtl/movavg.v
export SDC_FILE      = /OpenROAD-flow-scripts/flow/mydesign/midterm-patrickschaumont/fastpipe/config/constraint.sdc

# Adders degrade GCD
export ADDER_MAP_FILE :=

# These values must be multiples of placement site
export DIE_AREA    =  0  0 300 300
export CORE_AREA   = 10 10 290 290
