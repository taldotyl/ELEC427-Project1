`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:20:41 09/29/2015 
// Design Name: 
// Module Name:    top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top(
	clk,
	rst,
	an[3:0],
	seg[7:0],
	startstop,
	up,
	down
    );

input clk;
input rst;
input startstop;
input up;
input down;
output reg [3:0] an;
output reg [7:0] seg;
reg [1:0] state;

always @(posedge clk)
begin
	if (rst)
	begin
		an[3:0] <= 4'b1111;
		seg[7:0] <= 8'b11111111;
		state <= 0;
	end
	else	//display on the seg
	begin
		case (state)
		0 : begin 
			state <= 1; 
			an[3:0] <= 4'b1110;
			seg[7:0] <= 8'b10110000;
			end
		1 : begin 
			state <= 2; 
			an[3:0] <= 4'b1101; 
			seg[7:0] <= 8'b10000000;
			end
		2 : begin 
			state <= 3; 
			an[3:0] <= 4'b1011; 
			end
		3 : begin 
			state <= 0; 
			an[3:0] <= 4'b0111; 
			end
			endcase
		
	end

end

endmodule
