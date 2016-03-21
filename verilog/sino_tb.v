`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2016 06:40:16 PM
// Design Name: 
// Module Name: sinosoidal
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



module sino_tb;
    reg clk;
    reg [15:0] u1;
    wire [47:0] g0;
    wire [ 47:0] g1;
    
    sino s (
    .clk(clk),
    .u1(u1),
    .g0(g0),
    .g1(g1)
    );
    
initial begin
        clk=0;
        
        #1;
        
        
           clk=~clk;
                u1=0;
                
                #1;
                clk=~clk;
                u1=1;
               #1;
               clk=~clk;
                u1=2;
                 #1;
                clk=~clk;
                u1=3;
               #1;
               clk=~clk;
                u1=4;
               
    end    
    
endmodule
