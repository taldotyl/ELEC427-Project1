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
	seg[7:0]
    );

input clk;
input rst;
output reg [3:0] an;
output reg [7:0] seg;
reg [1:0] state;

always @(posedge clk)
begin
	if (rst)
	begin
		an[3:0] <= 4'b1111;
		seg[7:0] <= 8'b11111111;
	end
	else	//display on the seg
	begin
		case (state)
		0 : begin 
			state <= 1; 
			an[3:0] <= 4'b0001; 
			end
		1 : begin 
			state <= 2; 
			an[3:0] <= 4'b0010; 
			end
		2 : begin 
			state <= 3; 
			an[3:0] <= 4'b0100; 
			end
		3 : begin 
			state <= 0; 
			an[3:0] <= 4'b1000; 
			end
		an[3:0] <= 4'b1110;
		seg[7:0] <= 8'b00001111;
		endcase
	end
	seg <= 8'b10101010;
end

endmodule
