`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:45:51 10/06/2015
// Design Name:   top
// Module Name:   U:/ELEC427/Proj1/Project1/tb_top.v
// Project Name:  Project1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_top;

	// Inputs
	reg clk;
	reg rst;
	reg startstop;
	reg up;
	reg down;

	// Outputs
	wire [3:0] an;
	wire [7:0] seg;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.clk(clk), 
		.rst(rst), 
		.an(an), 
		.seg(seg), 
		.startstop(startstop), 
		.up(up), 
		.down(down)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		startstop = 0;
		up = 0;
		down = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Reset
		rst = 1;
		#20;
		rst = 0;
		#30;
		
		//Test up/down debouncing
		up = 1;
		#1000;
		up = 0;
		#50;
		up = 1;
		#10000
		up = 0;
		#500;
		up = 1;
		#1000;
		up = 0;
		#1000;
	
		
	end
	always    
		#5 clk = !clk;
      
endmodule

