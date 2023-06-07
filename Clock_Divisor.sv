`define TIME_50MHZ 32'd24999999
`define TIME_SIM 32'd5

module Clock_Divisor(clk, rst, timedClk);
  input clk, rst;
  output reg timedClk;

  reg [31:0] counter;

  always_ff @(posedge clk) 
    begin
      if (rst) 
        begin
          counter <= 32'd59; 
          timedClk <= 1'd0;
        end 
 
      else 
        begin
          counter--; 
      
          if (counter == `TIME_SIM) 
            begin
              timedClk <= 1'd1;
              counter <= 32'd0;
            end 

          else 
            begin
              timedClk <= 1'd0;
            end
        end
    end
endmodule

/*// cornometro 60'
module cronometro 
(
	input in, clk,
	output logic [6:0] dis0, 
	output logic [6:0] dis1
);

logic clk1;
logic [3:0]bin0;
logic [2:0]bin1;

divCLK div(.clk_in(clk), .clk_out(clk1));                           
dec7seg dec0(.bin(bin0), .dec(dis0));
dec7seg dec1(.bin(bin1), .dec(dis1));

always @(posedge clk1, negedge in)
 begin 
	if (in==1'b0)
	 begin
		bin0 <= 0;
		bin1 <= 0;
	 end
	else begin 
		bin0 <= bin0+1;
		if (bin0 == 9)
		 begin 
			bin0 <= 0;
			bin1 <= bin1+1;
		 end
		if (bin1 == 5 && bin0 ==9)
		 begin 
			bin1 <= 0;
		 end 
	 end
 end 
endmodule */


/*// cronometro 60' com pausa 
module cronometro 
(
	input r, clk, p,
	output logic [6:0] dis0, 
	output logic [6:0] dis1
);

logic clk1;
logic b;
logic [3:0]bin0;
logic [2:0]bin1;

divCLK div(.clk_in(clk), .clk_out(clk1));                           
dec7seg dec0(.bin(bin0), .dec(dis0));
dec7seg dec1(.bin(bin1), .dec(dis1));

always @(posedge clk1, negedge r)
 begin 
	if (r == 1'b0)
	 begin
		bin0 <= 0;
		bin1 <= 0;
	 end
	else begin
		if (b)
		 begin
		 end  
		else begin 
			bin0 <= bin0+1;
			if (bin0 == 9)
			 begin 
				bin0 <= 0;
				bin1 <= bin1+1;
			 end
			if (bin1 == 5 && bin0 == 9)
			 begin 
					bin1 <= 0;
			 end 
		end
	 end
 end
 
always @(negedge p)
 begin 
	 b <= ~b;
 end
 
endmodule 
*/
