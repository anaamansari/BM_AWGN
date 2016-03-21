`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2016 04:08:08 PM
// Design Name: 
// Module Name: LZDfortyeigth
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


module LZDsixtyfour(
    input [64:0] a,
    output reg [5:0] p,
    output reg v
    );
    
    wire [4:0] p2,p1;
                                                                                                                                                                                                               
            wire v2,v1;
            reg temp;
            
            LZDthtwo l2(
            .a(a[64:32]),
            .p(p2),
            .v(v2)
            );
            
            LZDthtwo l1(
              .a(a[15:0]),
              .p(p1),
              .v(v1)
            );
            
            always@(a)
                   begin
                   temp<=~v2;
                   if (v2==0)begin
                    p<= {{temp}, {p2}};
                    end
                    else begin
                   p<= {{temp}, {p1}};
                    end
                   v <= v1 | v2;
                   end
endmodule
