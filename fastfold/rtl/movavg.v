module movavg(input wire         clk,
	      input wire 	 reset,
	      input wire [63:0]  dinA,
	      input wire [63:0]  dinB,
	      output wire [63:0] doutA,
	      output wire [63:0] doutB);

   reg [63:0] 			  tap1, tap1_next;
   reg [63:0] 			  tap2, tap2_next;
   reg [63:0] 			  tap3, tap3_next;

   always @(posedge clk)
     begin
	if (reset)
	  begin
	     tap1 <= 64'h0;
	     tap2 <= 64'h0;
	     tap3 <= 64'h0;
	  end
	else
	  begin
	     tap1 <= tap1_next;
	     tap2 <= tap2_next;
	     tap3 <= tap3_next;
	  end
     end // always @ (posedge clk)

   reg [63:0] doutregA;
   reg [63:0] doutregB;
   
   always @(*)
     begin
	doutregA   = dinA + dinB + tap1 + tap2;
	doutregB   = dinB + tap1 + tap2 + tap3;
	tap1_next  = dinA;
	tap2_next  = dinB;
	tap3_next  = tap1;	
     end

   assign doutA = doutregA;
   assign doutB = doutregB;
   
endmodule
