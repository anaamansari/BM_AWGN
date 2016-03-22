`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2016 02:11:18 AM
// Design Name: 
// Module Name: BM
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


module BM(
    input clk,
    input reset,
    input [31:0] seed1,seed2,
    output v,
    output reg [15:0] x0,
    output reg [15:0] x1
    );
    
    wire [31:0] a,b;
    wire v;
    
    reg [47:0] u0;
    reg [15:0] u1;
    
    wire [30:0] e;
    
    wire [16:0] f;
    
    wire [15:0] g0,g1;
    
    tausworthe t1(
        .clk(clk),
        .reset(reset),
        .s(seed1),
        .y(a),
        .v(v));
        
     tausworthe t2(
               .clk(clk),
               .reset(reset),
               .s(seed2),
               .y(b),
               .v(v));
               
    
     
    log l (
        .clk(clk),
          .u0(u0),
           .e(e)
              );
              
    sqrt sq (
                  .clk(clk),
                  .e(e),
                  .f(f)
                  ); 
              
    sino sin_cos (
                      .clk(clk),
                      .u1(u1),
                      .g0(g0),
                      .g1(g1)
                      ); 
   always @(reset)begin
   u0=0;
   u1=0;
   end
     
     always @(posedge clk & reset==0) begin
       u0={{a},{b[31:16]}};
       u1=b[15:0];
        x0= f*g0;
        x1= f*g1;
        end              
                 
endmodule
