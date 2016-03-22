%Anaam Ansari
%

function [y]= taus(s,N)
    s0= fi(0,0,32,0);
    s1= fi(0,0,32,0);
    s2= fi(0,0,32,0);
    
    m1=fi(0,0,32,0);
    m1.hex='10850089';
    m2=fi(0,0,32,0);
    m2.hex='89305309';
    
    
    mask0= fi(0,0,32,0);
    mask1= fi(0,0,32,0);
    mask2= fi(0,0,32,0);
    
    mask0.hex='FFFFFFFE';
    mask1.hex='FFFFFFF8';
    mask2.hex='FFFFFFF0';
    
    s0=s;
    s1= bitxor(m1,s0);
    s2 =bitxor(m2,s0);  
    for i=1:N
        b= bitsrl(bitxor(bitsll(s0,13),s0),19);
        s0= bitxor(bitsll(bitand(s0,mask0),12), b);
        b= bitsrl(bitxor(bitsll(s1,2),s1),25);
        s1= bitxor(bitsll(bitand(s1,mask1),4), b);
        b= bitsrl(bitxor(bitsll(s2,3),s2),11);
        s2= bitxor(bitsll(bitand(s2,mask2),17), b);
        temp=bitxor(s0,s1);
        y(i)=bitxor(s2,temp);
    end
    
end
