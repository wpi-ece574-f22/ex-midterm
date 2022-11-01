module movavg(input wire         clk,
	      input wire 	 reset,
	      input wire [63:0]  din,
	      output wire [63:0] dout);

   reg [63:0] 			  tap1, tap1_next;
   reg [63:0] 			  tap2, tap2_next;
   reg [63:0] 			  tap3, tap3_next;

   reg [3:0] state, state_next;
   reg [63:0] acc, acc_next;

   localparam S0 = 4'd0, S1 = 4'd1, S2 = 4'd2, S3 = 4'd3, S4 = 4'd4;

   always @(posedge clk)
     begin
	if (reset)
	  begin
	     tap1 <= 64'h0;
	     tap2 <= 64'h0;
	     tap3 <= 64'h0;
	     acc  <= 64'h0;
	     state <= S0;
	  end
	else
	  begin
	     tap1  <= tap1_next;
	     tap2  <= tap2_next;
	     tap3  <= tap3_next;
	     acc   <= acc_next;
	     state <= state_next;
	  end
     end // always @ (posedge clk)

   reg [63:0] doutreg;
   
   always @(*)

     begin
	state_next = state;
	acc_next   = acc;
	tap1_next  = tap1;
	tap2_next  = tap2;
	tap3_next  = tap3;	
	doutreg    = 64'h0;
	
	case (state)
     	  S0:
     	    begin
  	       acc_next   = din;
    	       state_next = S1;
	    end
	  S1:	
     	    begin
       	       acc_next   = acc + tap1;
       	       state_next = S2;  	
            end    
	  S2:
     	    begin
     	       acc_next   = acc + tap2;
       	       state_next = S3;  	
     	    end
	  S3:
     	    begin
     	       acc_next   = acc + tap3;
       	       state_next = S4;  	
     	    end
	  S4:
     	    begin
     	       doutreg    = acc;
	       tap1_next  = din;
	       tap2_next  = tap1;
	       tap3_next  = tap2;	
	       state_next = S0;
     	    end
	  default:
            state_next = S0;
	endcase
     end // always @ (*)
   
   assign dout = doutreg;
   
endmodule
