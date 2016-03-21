`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2016 02:44:58 PM
// Design Name: 
// Module Name: LZDfour
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


module LZDfour(
    input [3:0] a,
    output reg [1:0] p,
    output reg v
    
    );
    
   wire p2,p1,v2,v1;
//   initial begin
////      p=0;
////      v=0;
////      end
 always@(a,p1,v1,p2,v2) begin
          v= v1 | v2;
           if (v2==0)begin
            p= {{~v2}, {p1}};
            end
            else begin
           p= {{~v2}, {p2}};
            end
         
           end
  
    LZDtwo l2(
    .a(a[3:2]),
    .p(p2),
    .v(v2));
    
    LZDtwo l1(
    .a(a[1:0]),
    .p(p1),
    .v(v1)
    );
   
    
   
    
endmodule
