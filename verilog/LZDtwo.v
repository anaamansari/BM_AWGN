`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2016 01:08:56 PM
// Design Name: 
// Module Name: 2LZD
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


module LZDtwo(
    input [1:0] a,
    output reg p,
    output reg v
    );
   initial begin
   p=0;
   v=0;
   end
   
   always@(a)
   begin
   p <= a[0]& (~a[1]);
   v <= a[0]|a[1];
   end
   
endmodule
