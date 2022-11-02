all:
	@echo "libcmd           Prepare library command file"
	@echo "iverref          Simulate (default version) with iVerilog"
	@echo "iverarea         Simulate (abc.area version) with iVerilog"
	@echo "iverspeed        Simulate (abc.speed version) with iVerilog"
	@echo "clean            Cleanup"


libcmd:
	ls /mnt/volume_nyc1_01/skywater-pdk/libraries/sky130_fd_sc_hd/latest/cells | awk '{print "+libdir+/mnt/volume_nyc1_01/skywater-pdk/libraries/sky130_fd_sc_hd/latest/cells/" $$0;}' >lib.cmd
	ls /mnt/volume_nyc1_01/skywater-pdk/libraries/sky130_fd_sc_hd/latest/cells | awk '{print "+incdir+/mnt/volume_nyc1_01/skywater-pdk/libraries/sky130_fd_sc_hd/latest/cells/" $$0;}' >>lib.cmd

# FUNCTIONAL
# specifies that functional views must be used for stdcells
# (default - BEHAVIORAL - does not seem to work)

# we first preprocess the gates to make sure only a single drive strength per cell type remains
# this is needed because skywater includes the basic functional view of a cell
# in each drive strength type, thereby leading to 'multiple defined' errors
#
# this substitute is good for functional simulation, but is obviously not correct for timing simulation

iverref:
	sed /[0-9a-z]_0/s/_0/_1/ ../syn/ref.movavg_gl.v >tmp
	sed /[0-9a-z]_2/s/_2/_1/ tmp >tmp2
	sed /[0-9a-z]_4/s/_4/_1/ tmp2 >tmp3
	sed /[0-9a-z]_6/s/_6/_1/ tmp3 >tmp4
	sed /[0-9a-z]_8/s/_8/_1/ tmp4 >tmp5
	sed /[0-9a-z]_12/s/_12/_1/ tmp5 >tmp6
	sed /[0-9a-z]_16/s/_16/_1/ tmp6 >tmp7
	iverilog -DFUNCTIONAL -c lib.cmd tmp7 movavgtb.v
	rm -f tmp tmp2 tmp3 tmp4 tmp5 tmp6 tmp7

iverarea:
	sed /[0-9a-z]_0/s/_0/_1/ ../syn/area.movavg_gl.v >tmp
	sed /[0-9a-z]_2/s/_2/_1/ tmp >tmp2
	sed /[0-9a-z]_4/s/_4/_1/ tmp2 >tmp3
	sed /[0-9a-z]_6/s/_6/_1/ tmp3 >tmp4
	sed /[0-9a-z]_8/s/_8/_1/ tmp4 >tmp5
	sed /[0-9a-z]_12/s/_12/_1/ tmp5 >tmp6
	sed /[0-9a-z]_16/s/_16/_1/ tmp6 >tmp7
	iverilog -DFUNCTIONAL -c lib.cmd tmp7 movavgtb.v
	rm -f tmp tmp2 tmp3 tmp4 tmp5 tmp6 tmp7

iverspeed:
	sed /[0-9a-z]_0/s/_0/_1/ ../syn/speed.movavg_gl.v >tmp
	sed /[0-9a-z]_2/s/_2/_1/ tmp >tmp2
	sed /[0-9a-z]_4/s/_4/_1/ tmp2 >tmp3
	sed /[0-9a-z]_6/s/_6/_1/ tmp3 >tmp4
	sed /[0-9a-z]_8/s/_8/_1/ tmp4 >tmp5
	sed /[0-9a-z]_12/s/_12/_1/ tmp5 >tmp6
	sed /[0-9a-z]_16/s/_16/_1/ tmp6 >tmp7
	iverilog -DFUNCTIONAL -c lib.cmd tmp7 movavgtb.v
	rm -f tmp tmp2 tmp3 tmp4 tmp5 tmp6 tmp7

clean:
	rm -rf  *~ *vcd a.out lib.cmd
