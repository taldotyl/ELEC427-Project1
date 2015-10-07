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
reg [19:0] cycle_count;
reg [1:0] state;
reg [3:0] num;
reg [9:0] timer;
reg run_state;
wire up_db;
wire down_db;

debounce db_up_yo_face (
			.clk(clk),
			.rst(rst),
			.button(up),
			.out(up_db)
			);

debounce db_down_yo_face (
			.clk(clk),
			.rst(rst),
			.button(down),
			.out(down_db)
			);
			
debounce db_ss_yo_face (
			.clk(clk),
			.rst(rst),
			.button(startstop),
			.out(ss_db)
			);
	

always @(posedge clk)
begin
	if (rst)
	begin
		an[3:0] <= 4'b1111;
		seg[7:0] <= 8'b11111111;
		state <= 0;
		timer <= 0;
	end
	else	begin //display on the seg
	
		//Check the up button signal
		if (up_db)
		begin
			if (num < 9)
				num <= num + 1;
		end
		
		//Check the down button signal
		if (down_db)
		begin
			if (num > 0)
				num <= num - 1;
		end
		
		//Check the Start/Stop button signal
		if(ss_db) 
			run_state = !run_state;
		
		//Handle the counting
		cycle_count <= cycle_count + 1;
		if(cycle_count == 125000)
		begin
			cycle_count <= 0;
			timer <= timer + 1;
			if (timer==400) begin
				timer <= 0;
				
				if(run_state) begin
					num <= num + 1;
					if(num == 9)
						num <= 0;
				end
			end	
			case (state)
			0 : begin 
				state <= 1; 
				an[3:0] <= 4'b1101;
				if(num == 9) begin
					seg[7:0] <= 8'b10000011;
					end
				else begin
					seg[7:0] <= 8'b10001000;
					end
				end
			1 : begin 
				state <= 2; 
				an[3:0] <= 4'b1011;
				seg[7:0] <= 8'b10000000;
				end
			2 : begin 
				state <= 3; 
				an[3:0] <= 4'b0111;
				seg[7:0] <= 8'b10110000;
				end
			3 : begin 
				state <= 0; 
				an[3:0] <= 4'b1110;			
					case (num)
					0: begin
						seg[7:0] <= 8'b11111000;
						end
					1: begin
						seg[7:0] <= 8'b10000000;
						end
					2: begin
						seg[7:0] <= 8'b10010000;
						end
					3: begin
						seg[7:0] <= 8'b10001000;
						end
					4: begin
						seg[7:0] <= 8'b10000011;
						end
					5: begin
						seg[7:0] <= 8'b11000110;
						end
					6: begin
						seg[7:0] <= 8'b10100001;
						end
					7: begin
						seg[7:0] <= 8'b10000110;
						end
					8: begin
						seg[7:0] <= 8'b10001110;
						end
					9: begin
						seg[7:0] <= 8'b11000000;
						end
				endcase
				end
			endcase
			
		end //end if ==125000
	end

end

endmodule


module debounce(
			input clk,
			input rst,
			input button,
			output out
			);
//input rst;
reg state;

reg [77:0] shift;

assign out = (shift[0] & shift[77]) & !state;

//reg PB_sync_0;
//always @(posedge clk) PB_sync_0 <= button;
//reg PB_sync_1;
//always @(posedge clk) PB_sync_1 <= PB_sync_0;

//reg [15:0] PB_cnt;

always @(posedge clk)
begin
	if (rst)
	begin
		state <= 0;
		shift <= 0;
	end
	shift[77:1] <= shift[76:0];
	shift[0] <= button;
	
	if (state)
		state <= (shift[0] | shift[77]);
	else
		state <= (shift[0] & shift[77]);

//	if (out == PB_sync_1)
//		PB_cnt <= 0;
//	else
//	begin
//		PB_cnt <= PB_cnt + 1'b1;
//		if (PB_cnt == 16'hffff) out <= ~out;
//
//	end
end
endmodule
