export DESIGN_NAME = movavg
export PLATFORM    = sky130hd

export VERILOG_FILES = /OpenROAD-flow-scripts/flow/mydesign/midterm-patrickschaumont/smallseq/rtl/movavg.v
export SDC_FILE      = /OpenROAD-flow-scripts/flow/mydesign/midterm-patrickschaumont/smallseq/config/constraint.sdc

# Adders degrade GCD
export ADDER_MAP_FILE :=

# These values must be multiples of placement site
export DIE_AREA    =  0  0 200 200
export CORE_AREA   = 10 10 190 190
