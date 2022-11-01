module movavg(input wire         clk,
	      input wire 	 reset,
	      input wire [63:0]  din,
	      output wire [63:0] dout);

   reg [63:0] 			  tap1, tap1_next;
   reg [63:0] 			  tap2, tap2_next;
   reg [63:0] 			  tap3, tap3_next;

   reg [5:0] 			  ctr, ctr_next;

   always @(posedge clk)
     begin
	if (reset)
	  begin
	     tap1 <= 64'h0;
	     tap2 <= 64'h0;
	     tap3 <= 64'h0;
	     ctr <= 5'd0;
	  end
	else
	  begin
	     tap1 <= tap1_next;
	     tap2 <= tap2_next;
	     tap3 <= tap3_next;
	     ctr  <= ctr_next;	     
	  end
     end // always @ (posedge clk)

   // controller
   reg ctl0, ctl1, ctl2, ctl3, ctl4;
   always @(*)
     begin
	ctr_next = ctr + 6'b1;
	ctl0 = (ctr == 6'd0);
	ctl1 = (ctr == 6'd1);
	ctl2 = (ctr == 6'd2);
	ctl3 = (ctr == 6'd3);
	ctl4 = (ctr == 6'd4);
     end
   
   // first stage: parallel to serial conversion
   wire din_s;
   ps stage1(din, ctl0, clk, din_s);

   // second stage: delay line
   always @(*)
     begin
	tap1_next = {din_s, tap1[63:1]};
	tap2_next = {tap1[0], tap2[63:1]};
	tap3_next = {tap2[0], tap3[63:1]};	
     end

   // third stage: first set of adders
   wire a1_s, a2_s;   
   serialadd a1(din_s,    tap1[0], a1_s, ctl1, clk);
   serialadd a2(tap2[0],  tap3[0], a2_s, ctl1, clk);

   // fourth stage: second adder
   wire a3_s;
   serialadd a3(a1_s, a2_s, a3_s, ctl2, clk);

   // final stage: s/p converter
   sp stage9(a3_s, ctl3, clk, dout);
   
endmodule

module ps(input wire[63:0] a,
	  input wire  sync,
	  input wire  clk,
	  output wire as);
   
   reg [63:0] 	      ra;
   
   always @(posedge clk)
     if (sync)
       ra <= a;
     else
       ra <= {1'b0, ra[63:1]};
   
   assign as = ra[0];

endmodule // ps

module sp(input wire as,
	  input wire 	     sync,
	  input wire 	     clk,
	  output wire [63:0] a);
   
   reg [63:0] 		     ra;
   
   always  @(posedge clk)
     ra <= {as, ra[63:1]};
   
   assign a  = sync ? ra : 8'b0;
   
endmodule // sp

module serialadd(input wire a, input wire b, output wire s,
                 input wire sync, input wire clk);
   
   reg 			    carry, q;
   
   always @(posedge clk)
     if (sync)
       begin
          carry <= a & b;
          q     <= a ^ b;
       end
     else
       begin
          q     <= a ^ b ^ carry;
          carry <= (a & b) | (b & carry) | (carry & a);
       end
   
   assign s = q;
   
endmodule
