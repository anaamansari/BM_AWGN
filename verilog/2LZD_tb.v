`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2016 01:32:34 PM
// Design Name: 
// Module Name: 2LZD_tb
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


module LZDtwo_tb(
    input a0,
    input a1,
    output p,
    output v
    );
    
   LZDtwo l (
   .a0(a0),
   .a1(a1),
   .p(p),
   .v(v));
    
    initial begin       
                    a1=0;
                    a0=0;
                    #1;
                     a1=0;
                     a0=1;
                   #1;
                  a1=1;
                   a0=0;
                    end    
endmodule
