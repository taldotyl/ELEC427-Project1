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
	blah_seg,
	blah_an,
	rst,
	an[1:3],
	seg[1:7],
	in1[0:3],
	in2[0:3]
    );

input clk;
output reg blah_seg;
output reg blah_an;
input rst;
output [1:3] an;
output [1:7] seg;
input [0:3] in1;
input [0:3] in2;

assign an[1:3] = 3'b111;
assign seg[1:7] = 7'b0000001;


always @(posedge clk)
begin
	blah_seg <= 0;
	blah_an <= 0;
end

endmodule
