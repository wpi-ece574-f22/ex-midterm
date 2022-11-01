`define WL 63
`define WL1 64

module movavg(input wire         clk,
	      input wire 	 reset,
	      input wire [`WL:0]  din,
	      output wire [`WL:0] dout);

   reg [`WL:0] 			  tap1, tap1_next;
   reg [`WL:0] 			  tap2, tap2_next;
   reg [`WL:0] 			  tap3, tap3_next;

   always @(posedge clk)
     begin
	if (reset)
	  begin
	     tap1 <= `WL1'h0;
	     tap2 <= `WL1'h0;
	     tap3 <= `WL1'h0;
	  end
	else
	  begin
	     tap1 <= tap1_next;
	     tap2 <= tap2_next;
	     tap3 <= tap3_next;
	  end
     end // always @ (posedge clk)

   reg [`WL1:0] doutreg;
   
   always @(*)
     begin
	doutreg    = din + tap1 + tap2 + tap3;
	tap1_next  = din;
	tap2_next  = tap1;
	tap3_next  = tap2;	
     end

   assign dout = doutreg;
   
endmodule
