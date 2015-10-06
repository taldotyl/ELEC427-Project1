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

always @(posedge clk)
begin
if (rst)
begin
an[3:0] <= 4'b1111;
seg[7:0] <= 8'b11111111;
end
else
begin
 an[3:0] <= 4'b1110;
 seg[7:0] <= 8'b00001111;
 end
end

endmodule
