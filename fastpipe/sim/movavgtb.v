`define WL 63
`define WL1 64

`timescale 1ns/1ps

// The Data Introduction Interval (DII) specifies the number of clock cycles
// between successive data inputs.
`define DII 1

// The Latency specifies the number of clock cycles between the entry of the first
// input, and the first output.
`define LATENCY 2

// The CLOCKPERIOD defines the number of time units in a clock period
`define CLOCKPERIOD 10

module movavgtb;
   
   reg clk, reset;
   
   always
     begin
	clk = 1'b0;
	#(`CLOCKPERIOD/2);
	clk = 1'b1;
	#(`CLOCKPERIOD/2);
     end
   
   initial
     begin
	reset = 1'b1;
	#(`CLOCKPERIOD);	
	reset = 1'b0;
     end
   

   reg [`WL:0] din;
   wire [`WL:0] dout;
   
   movavg DUT(.clk(clk),
	      .reset(reset),
	      .din(din),
	      .dout(dout));

   reg [`WL:0]  chk_in;
   reg [`WL:0]  chk_tap1;
   reg [`WL:0]  chk_tap2;
   reg [`WL:0]  chk_tap3;

   reg [`WL:0]  old1;
   reg [`WL:0]  old2;
   reg [`WL:0]  old3;

   integer     n;

   initial
     begin	
	$dumpfile("trace.vcd");
	$dumpvars(0, movavgtb);

	#(`CLOCKPERIOD/2); // reset delay

	chk_in   = `WL1'b0;
	chk_tap1 = `WL1'b0;
	chk_tap2 = `WL1'b0;
	chk_tap3 = `WL1'b0;
	
	for (n=0; n < 1024; n = n + 1)
          begin

	     din[31: 0] = $random;
	     din[63:32] = $random;
	     
	     chk_tap3 = chk_tap2;
	     chk_tap2 = chk_tap1;
	     chk_tap1 = chk_in;
	     chk_in   = din;

	     old3 = old2;
	     old2 = old1;
	     old1 = chk_in+chk_tap1+chk_tap2+chk_tap3;
	     	     
	     if (n == 0) 
	       repeat (`LATENCY) @(posedge clk);
	     
	     #(`CLOCKPERIOD - 1);
	     	     
	     $display("din %x dout %x exp %x OK %d", 
		      din, 
		      dout, 
		      old3, 
		      dout == old3);

	     @(posedge clk);

	  end
	
	$finish;
	
     end
   
endmodule
