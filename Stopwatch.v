`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:10:07 04/10/2017 
// Design Name: 
// Module Name:    stopwatch 
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
module stopwatch(
		input clk,
		input start,
		input pause,
		input reset,
		output[3:0] counter
		);

	integer count=0;

	reg[3:0] temp;
	integer pause_check = 0;
	assign counter = temp;
	always@(posedge clk)
		begin
			if(pause == 1'b1) pause_check <= 1'b1;
			if(start == 1'b1) pause_check <= 1'b0;
			if(pause_check == 1'b0) count <= count+1;
			if(reset == 1'b1)
				begin
					temp = 4'b0000;
					pause_check <= 1'b1;
				end
			if(count == 50000000)
				if(temp == 4'b1111)
					begin
						temp = 4'b0000;
						count <= 0;
					end
				else
					begin
						temp = temp+1;
						count <= 0;
					end
			else temp = temp;
		end
endmodule
