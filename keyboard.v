`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:27:35 04/03/2017 
// Design Name: 
// Module Name:    keyboard 
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
module keyboard( input clk,
	input wire ps2_clk,
// Clock pin form keyboard
	input wire data,
//Data pin form keyboard
	output reg [7:0] led ,
//Printing input data to led
	output reg [3:0] x
	);
	reg [7:0] data_curr;
	reg [7:0] data_pre;
	reg [3:0] b;
	reg flag;
	reg start,pause,reset;
	wire [3:0] temp; 
	
	initial begin
		b<=4'h1;
		flag<=1'b0;
		data_curr<=8'hf0;
		data_pre<=8'hf0;
		led<=8'hf0;
		x<=4'b0000;
	end 
	
	always @(negedge ps2_clk)
//Activating at negative edge of clock from keyboard
	begin
		case(b)
			1:; //first bit
			2:data_curr[0]<=data;
			3:data_curr[1]<=data;
			4:data_curr[2]<=data;
			5:data_curr[3]<=data;
			6:data_curr[4]<=data;
			7:data_curr[5]<=data;
			8:data_curr[6]<=data;
			9:data_curr[7]<=data;
			10:flag<=1'b1; //Parity bit
			11:flag<=1'b0; //Ending bit
		endcase

		if(b<=10)
		b<=b+1;
		else if(b==11)
		b<=1;
	end
	
	always @ (posedge flag)
// Printing data obtained to led
	begin 
		if(data_curr==8'hf0) 
			led<=data_pre;
			
		else if(data_curr == 8'h1b)
			begin start<=1; pause<=0; reset<=0; end
		
		else if(data_curr == 8'h4d)
			begin start<=0; pause<=1; reset<=0; end
		
		else if(data_curr == 8'h2d)
			begin start<=0; pause<=0; reset<=1; end
		
		else
			data_pre<=data_curr;
	end
	
	stopwatch w1(clk,start,pause,reset,temp);
	always @ (posedge clk)
		x[3:0] = temp[3:0];

		
endmodule
