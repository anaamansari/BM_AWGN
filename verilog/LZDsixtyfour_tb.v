`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2016 04:33:57 PM
// Design Name: 
// Module Name: LZDsixtyfour_tb
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


module LZDsixtyfour_tb;
   reg [47:0] a;
   wire [5:0] p;
   wire v;
    
    LZDsixtyfour l (
        .a(a),
        .p(p),
        .v(v)
        );
        
        initial begin
        a=0;
        #100;
                a=0;
                #100;
                a=1;
            
                 #100;
                  a=3;
                  #100;
                   a=4;
                   #100;
                    a=5;         
            
                
                         
            end
    
endmodule
