`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2016 03:51:02 PM
// Design Name: 
// Module Name: LZDsixteen
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


module LZDsixteen(
    input [15:0] a,
    output reg [3:0] p,
    output reg v
    );
    
        wire [2:0] p2,p1;
    
    wire v2,v1;
    reg temp;
    
    LZDeight l2(
    .a(a[15:8]),
    .p(p2),
    .v(v2)
    );
    
    LZDeight l1(
      .a(a[7:0]),
      .p(p1),
      .v(v1)
    );
    
     
        always@(a,p1,v1,p2,v2) begin
                 v= v1 | v2;
                  if (v2==0)begin
                   p= {{~v2}, {p1}};
                   end
                   else begin
                  p= {{~v2}, {p2}};
                   end
                
                  end
      
endmodule
