`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2016 03:34:24 PM
// Design Name: 
// Module Name: BM_tb
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


module BM_tb;
    reg reset;
    reg [31:0] s1,s2;
    wire [15:0] x0;
    wire [15:0] x1;
    wire v;
    reg clk;
    reg i;
    reg [15:0] out0[9999:0];
    reg [15:0]out1 [9999:0];
        BM bM (
        .clk(clk),
        .reset(reset),
        .seed1(s1),
        .seed2(s2),
        .v(v),
        .x0(x0),
        .x1(x1)
        );
   
    initial begin
    reset=1;
    clk=0;
    #10;
    reset=0;
    s1='h67580;
    s2='h70385;
    for (i=0;i<10000; i=i+1) begin
  //  [15:0]out0[i]=x0;
   // [15:0]out1[i]=x1;
    clk=~clk;
    #10;      
    end
    end
   
 
   
endmodule
