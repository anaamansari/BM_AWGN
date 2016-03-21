module BM_tb;
    reg reset;
    reg [31:0] s1,s2;
    wire [15:0] x0;
    wire [15:0] x1;
    wire v;
    reg clk;
    integer f,i;
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
   
   initial begin
   f=$fopen("x0.txt","w");
   end
   
    initial begin
    reset=1;
    clk=0;
    #10;
    reset=0;
    s1='h67580;
    s2='h70385;
    for (i=0;i<100; i=i+1) begin
//    out0[i]=x0;
//    out1[i]=x1;
    clk=~clk;
    #10; 
     $fwrite(f, "%b",i);     
    end
    end
    
    initial begin
    $display("clk");
    $monitor("%b",clk);
    end
    initial begin
    $fclose(f);
    end
    
   
endmodule
