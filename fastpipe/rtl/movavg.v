`define WL 63
`define WL1 64

module movavg(input wire         clk,
	      input wire 	 reset,
	      input wire [`WL:0]  din,
	      output wire [`WL:0] dout);

   reg [`WL:0] 			  tap1, tap1_next;
   reg [`WL:0] 			  tap2, tap2_next;
   reg [`WL:0] 			  tap3, tap3_next;

   reg [`WL:0]         pipe1a, pipe1a_next;
   reg [`WL:0]         pipe1b, pipe1b_next;
   reg [`WL:0]         pipe1c, pipe1c_next;
   reg [`WL:0]         pipe2a, pipe2a_next;
   reg [`WL:0]         pipe2b, pipe2b_next;

   always @(posedge clk)
     begin
	if (reset)
	  begin
	     tap1 <= `WL1'h0;
	     tap2 <= `WL1'h0;
	     tap3 <= `WL1'h0;
	     pipe1a <= `WL1'h0;
	     pipe1b <= `WL1'h0;
	     pipe1c <= `WL1'h0;
	     pipe2a <= `WL1'h0;
	     pipe2b <= `WL1'h0;
	  end
	else
	  begin
	     tap1   <= tap1_next;
	     tap2   <= tap2_next;
	     tap3   <= tap3_next;
	     pipe1a <= pipe1a_next;
	     pipe1b <= pipe1b_next;
	     pipe1c <= pipe1c_next;
	     pipe2a <= pipe2a_next;
	     pipe2b <= pipe2b_next;
	  end
     end // always @ (posedge clk)

   reg [`WL:0] doutreg;
   
   always @(*)
     begin
        pipe1a_next = din + tap1;
        pipe1b_next = tap2;
        pipe1c_next = tap3;
        pipe2a_next = pipe1a + pipe1b;
        pipe2b_next = pipe1c;
        doutreg     = pipe2a + pipe2b;
	tap1_next   = din;
	tap2_next   = tap1;
	tap3_next   = tap2;
     end

   assign dout = doutreg;
   
endmodule
