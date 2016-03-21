`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Anaam Ansari
// 
// Create Date: 03/18/2016 07:47:22 PM
// Design Name: sinosoidal block
// Module Name: sino
// Project Name: BM
// 
//////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////
module sino(
    input clk,
    input [15:0] u1,
    output  reg signed [15:0] g0,
    output  reg signed  [15:0] g1
    );
    reg [18:0] C0[127:0];           // C0 (19,17)
    reg [18:0] C1[127:0];           // C1 (19,17)
      initial begin
        $readmemh("Z:/BM/BM.srcs/sources_1/imports/new/C0_cos.txt", C0);
        $readmemh("Z:/BM/BM.srcs/sources_1/imports/new/C1_cos.txt", C1);
    end
    
   reg [1:0] quad;                  // 2 bits to differentiate quadrants       
   reg [13:0] xg0,xg1;              // input 14 bits
   reg [6:0] ind;                   // 7 bits to address the coefficients
   reg [15:0] yg0,yg1;
   
   reg [33:0] mult0,mult1;          // titwidth for C0*xg0 and C1*xg1 (19+14+1)=31
   
    
    always@(posedge clk ) begin
         quad=u1[15:14];            // first two bits for quad
         xg0=u1[13:0];              // input   
         xg1='h1fff- u1[13:0];      // (pi/2)-xg1... (1-2^(-14)) - u1[13:0]
        ind=u1[15:8];               // first 7 bits for coefficient addressing
        mult0=C0[ind]*xg0;          // for fixed point multiplication
        mult1=C1[ind]*xg1;          // fi multiplication    
        yg0<=mult0[33:13]+ C0[ind]; // we truncate multi0 and multi1 to 19 bits 
        yg1<=mult1[33:13]+ C0[ind]; // addition after aligning the binary points
        case(quad)
        0: g0= yg1;
        1: g0= yg0;
        2: g0= -yg1;
        3: g0= -yg0;
        endcase;
        
        case(quad)
                0: g1=yg0;
                1: g1=yg1;
                2: g1= -yg0;
                3: g1= -yg1;
                endcase;
        
    end
endmodule

