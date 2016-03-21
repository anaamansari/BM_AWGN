`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2016 10:39:32 PM
// Design Name: 
// Module Name: log
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


module log(
    input clk,
    input [47:0] u0, //48 bit input
    output reg signed [30:0] e // 31 bits
    );
    wire v;
    wire [5:0] exp_e;
    reg [47:0] xe;       // Mx 48bits
    reg [79:0] mult1;
    reg [127:0] mult2; // mult0= Cx*xe 32bits x 48 bits = 80 bits
    reg [47:0] ye,ln2,e1; // intermediate signals
    reg [7:0] ind;
    
   
    LZDfortyeight l(            /// exp_e is Ex
            .a(u0),
            .p(exp_e),
            .v(v)
            );

   
     reg [31:0] C0[255:0];       //(32,27)
       reg [31:0] C1[255:0];     //(32,27)
         reg [31:0] C2[255:0];   //(32,27)
         initial begin
           $readmemh("Z:/BM/BM.srcs/sources_1/imports/new/C0_log.txt", C0);
           $readmemh("Z:/BM/BM.srcs/sources_1/imports/new/C1_log.txt", C1);
           $readmemh("Z:/BM/BM.srcs/sources_1/imports/new/C2_log.txt", C2);

       end
       
       
       
       always@(posedge clk ) begin
       if (u0==0)begin   
       e=0;         //log(0)
       end
       else begin
          ind= u0[47:40];           // index is given by the first 8 bits
          xe= (u0<< exp_e);         // Mantissa 48 bits
          ln2= 'h162e42fefa3a;      // log_n(2)
          e1= ln2*exp_e;            // log_2(2)*Ex  6bits x 48 bits= 52bits
          mult1= C1[ind]*xe; // 32bits x 48 btis = 80 bits
          mult2= C2[ind]*xe*xe; // 80bits x 48bits = 128 bits
          ye<=mult2[127:80] + mult1[79:32]+ C0[ind]; // log_n(Mx) 48 bits
          e=e1[47:17]+ye; // log_n(Mx) + log_n(2)*Ex //31 bits
          end
       end
   endmodule
    
    

