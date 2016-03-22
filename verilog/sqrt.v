`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2016 12:18:08 AM
// Design Name: 
// Module Name: sqrt
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


module sqrt(
    input clk,
    input [30:0] e,         // input (31,24)
    output reg [16:0] f         // output (17,13)
    );
  //Load Ceofficients    
       reg [31:0] C0_a[63:0]; // Coefficient precision (32,27)
       reg [31:0] C1_a[63:0]; // Coefficient precision (32,27)
       reg [31:0] C0_b[63:0]; 
       reg [31:0] C1_b[63:0];
   
      
                initial begin
                  $readmemh("Z:/BM/BM.srcs/sources_1/imports/new/C0_sqrt_1_2.txt", C0_a); // exp_f[0]=1, range[1,2) xf=xf1>>1
                  $readmemh("Z:/BM/BM.srcs/sources_1/imports/new/C1_sqrt_1_2.txt", C1_a); // exp_f[0]=1, range[1,2) xf=xf1>>1
                  $readmemh("Z:/BM/BM.srcs/sources_1/imports/new/C0_sqrt_1_2.txt", C0_b);// exp_f[0]=0, range[2,4) xf=xf1
                  $readmemh("Z:/BM/BM.srcs/sources_1/imports/new/C1_sqrt_1_2.txt", C1_b);// exp_f[0]=0, range[2,4) xf=xf1
            
              
                  
              end  
               
        wire v;
        wire [4:0] exp_f; 
        reg  [4:0] exp_f1;
        reg  [30:0] xf1;       // input as (31,24)
        reg  [30:0] yf;           // output of sqrt (31,24)
        reg  [5:0] ind;
        reg  [63:0] mult;
       
       
 
    
 
           
  //Determine exponent    
                 LZDthtwo l(
                         .a({1'b0,e}),
                         .p(exp_f),
                         .v(v)
                         );     
           
           always@(posedge clk ) begin
           if (e==0)begin  
                  mult=0;         
                  yf=0;
                  xf1=0;
                  f=0;
                  end
        //Range Reduction         
              xf1= (e<< (exp_f-2 -1));    // (31,24)
              ind=e[30:25]; // six bits fo xf for index to look up  
                if (exp_f[0])begin
                    //xf= xf1>>1;  
                    //sqrt approximation 
                      mult= C1_a[ind]*xf1;       
                      yf =mult[63:32]+ C0_a[ind];                          
                    end
                   else begin
                   //xf=xf1;
                   mult= C1_b[ind]*xf1;       
                   yf =mult[63:32]+ C0_b[ind];                          

                   end
 
              
 //Range Reconstruction
 
                 if (exp_f[0])begin
                    exp_f1= (exp_f+1)>>1;              
                    end
                   else begin
                   exp_f1= (exp_f)>>1;  
                   end
                   f= yf<<exp_f1;
                   
           end
endmodule
