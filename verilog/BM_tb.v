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
    reg [15:0] xout0;
    integer f0,f1;
//    reg [15:0] out0[99:0];
//    reg [15:0]out1 [99:0];
        BM bM (
        .clk(clk),
        .reset(reset),
        .seed1(s1),
        .seed2(s2),
        .v(v),
        .x0(x0),
        .x1(x1)
        );
    always begin
    #10 clk=~clk;
    #10
     $fwrite(f0,"%h\n",x0); 
     $fwrite(f1,"%h\n",x1);
     end
    initial begin
    reset=1;
    clk=0;
     s1='h67580;
     s2='h70385;
    reset=0;
    f0= $fopen("x0.dat","w");
    f1= $fopen("x1.dat","w");
    #20000
    $fclose(f0);
    $fclose(f1);
    end
 
  
   
endmodule
