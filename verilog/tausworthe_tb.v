`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2016 06:35:49 PM
// Design Name: 
// Module Name: tausworthe_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tausworthe_tb;
reg clk;
reg [31:0] seed;
reg reset;
wire [31:0] y;
    
tausworthe t(
.clk(clk),
.reset(reset),
.s(seed),
.y(y));

initial begin
    reset=1;
     clk=0;
    #5;
    reset=0;
    seed='h00000000;
   
    forever begin
            #5;
            clk=~clk;
            end
end

endmodule