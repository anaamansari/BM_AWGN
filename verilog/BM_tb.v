`timescale 1ns / 1ps

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
    reset=0;
    s1='h67580;
    s2='h70385;
    f0= $fopen("x0.txt","w");
    f1= $fopen("x1.txt","w");
    #20000
    $fclose(f0);
    $fclose(f1);
    end
 
  
   
endmodule
