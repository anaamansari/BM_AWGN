`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2016 06:34:19 PM
// Design Name: 
// Module Name: tausworthe
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


module tausworthe(
    input clk,
    input reset,
    input [31:0] s,
    output reg v,
    output reg [31:0] y);
  reg[31:0] s0;
  reg [31:0] s1;
  reg [31:0] s2;
  reg [31:0] b;
  reg [31:0] temp;
  
   always@(reset)
                 begin
                 v=reset;
                 s0=s;
                 s1= 'h10850089 ^ s;
                 s2 = 'h89305309 ^s;
                 y=0;
                 end
          
        always@(posedge clk && reset==0)
        begin
        b= ((s0<<13)^s0)>>19;
        s0= ((s0&'hfffffffe)<<12)^b;
        b= ((s1<<2)^s1)>>25;
        s1= ((s1&'hfffffff8)<<4)^b;
        b= ((s2<<3)^s2)>>11;
        s2= ((s2&'hfffffff0)<<17)^b;
        temp=s0^s1;        
        y=s2^temp;
       end
endmodule