module tb_pomodoro;
	timeunit 1ns;
	timeprecision 1ns;
	
	logic swPlayPause, bIncrementa5, bDecrementa5, bIncrementa1, bDecrementa1;
	logic e1, e2, e3, e4;
	logic rst;
	logic clk;
	logic timedClk;
	logic [6:0] displayUnidadeSegundos;
	logic [6:0] displayDezenaSegundos; 
	logic [6:0] displayUnidadeMinutos;
	logic [6:0] displayDezenaMinuto;
	
	mru tst_pomodoro (.*);
	timer t(.*);
	
	initial clk = 0;
	always #20 clk = ~clk;
	
	task xpect(input e1_exp, e2_exp, e3_exp, e4_exp, input [6:0] display_exp);
		if (e1_exp != e1 || e2_exp != e2 || e3_exp != e3 || e4_exp != e4 || display_exp != display) 
			begin
				$display("POMODORO TEST ERROR");
				$display("e1_exp: %b - %b | e2_exp: %b - %b | e3_exp: %b - %b | e4_exp: %b - %b | display_exp: %b - %b", e1_exp, e1, e2_exp, e2, e3_exp, e3, e4_exp, e4, display_exp, display);
				$finish;
			end
	endtask
	
	initial begin
		@(negedge clk)
		{rst, bIncrementa5, bDecrementa5, bIncrementa1, bDecrementa1} = 5'bX_X_X_X_X; @(negedge clk) xpect(1'bX, 1'bX, 1'bX, 1'bX, 7'bXXXXXXX);
		
		{rst, bIncrementa5, bDecrementa5, bIncrementa1, bDecrementa1} = 5'b1_X_X_X_X; @(negedge clk) xpect(1'b0, 1'b0, 1'b0, 1'b0, 7'b1000000);
		
		{rst, bIncrementa5, bDecrementa5, bIncrementa1, bDecrementa1} = 5'b0_0_0_0_0; @(negedge timedClk) xpect(1'b0, 1'b0, 1'b0, 1'b0, 7'b1000000);
		
		// Cada par equivale a um segundo 
		
		// Apertando no botao 1
		{rst, bIncrementa5, bDecrementa5, bIncrementa1, bDecrementa1} = 5'b0_1_0_0_0; @(negedge timedClk) xpect(1'b0, 1'b0, 1'b0, 1'b0, 7'b1000000 );
		{rst, bIncrementa5, bDecrementa5, bIncrementa1, bDecrementa1} = 5'b0_1_0_0_0; @(negedge timedClk) xpect(1'b1, 1'b0, 1'b0, 1'b0, 7'b1000000);
		
		// Apertando no botao 2
		{rst, bIncrementa5, bDecrementa5, bIncrementa1, bDecrementa1} = 5'b0_0_1_0_0; @(negedge timedClk) xpect(1'b1, 1'b0, 1'b0, 1'b0, 7'b1000000);
		{rst, bIncrementa5, bDecrementa5, bIncrementa1, bDecrementa1} = 5'b0_0_1_0_0; @(negedge timedClk) xpect(1'b1, 1'b1, 1'b0, 1'b0, 7'b1000000);
		
		// Apertando no botao 3
		{rst, bIncrementa5, bDecrementa5, bIncrementa1, bDecrementa1} = 5'b0_0_0_1_0; @(negedge timedClk) xpect(1'b1, 1'b1, 1'b0, 1'b0, 7'b1000000);
		{rst, bIncrementa5, bDecrementa5, bIncrementa1, bDecrementa1} = 5'b0_0_0_1_0; @(negedge timedClk) xpect(1'b1, 1'b1, 1'b1, 1'b0, 7'b1000000);
		
		// Apertando no botao 4
		{rst, bIncrementa5, bDecrementa5, bIncrementa1, bDecrementa1} = 5'b0_0_0_0_1; @(negedge timedClk) xpect(1'b1, 1'b1, 1'b1, 1'b0, 7'b0110000);
		{rst, bIncrementa5, bDecrementa5, bIncrementa1, bDecrementa1} = 5'b0_0_0_0_1; @(negedge timedClk) xpect(1'b1, 1'b1, 1'b0, 1'b1, 7'b0110000);
		
		$display("POMODORO TEST PASSED");
		$finish;
	end
endmodule