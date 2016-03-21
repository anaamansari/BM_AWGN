% Anaam Ansari
% ELEN 249 Box Muller AWGN generation

clear
% Precision Definition

% Precision for tausworthe URNG
a_w=32;
a_f=0;
b_w=32;
b_f=0;

% Precision for after rearranging the tausworth output 
u0_w=48;
u0_f=48;
u1_w=16;
u1_f=16;

%Precision for the logarithmic unit
e_w=31;
e_f=24;
%Precision for the squaroot unit
f_w=17;
f_f=13;

%Precision for the sinosoidal unit
g0_w=16;
g0_f=15;
g1_w=16;
g1_f=15;

%Precision value for the AWGN output
x0_w=16;
x0_f=11;
x1_w=16;
x1_f=11;

%%

%Generate test seed values
% seed values to generate random seed values to go in the tausworth urng
seed_1= fi(0,0,32,0);
seed_1.hex='67580';
seed_2=fi(0,0,32,0);
seed_2.hex='70385';
val=35364; 
N=1000;

%% Generate Tauseworth URNGs
    a=taus(seed_1,N);
    b=taus(seed_2,N);
    


%% Convert them to u1 and u2
u0=fi(zeros(size(a)),0,u0_w,u0_f);
u1=fi(zeros(size(a)),0,u1_w,u1_f);
for i=1:length(a.data)
    a_temp=fi(0,0,a_w,a_f);
    b_temp=fi(0,0,b_w,b_f);
    u0_temp=fi(0,0,u0_w,u0_f);
    u1_temp=fi(0,0,u1_w,u1_f);
    
    a_temp.data=a.data(i);
    b_temp.data=b.data(i);
    u0_temp.bin=[a_temp.bin,b_temp.bin(1:16)];
    u1_temp.bin=b_temp.bin(17:32);
    
    u0.data(i)= u0_temp.data;
    u1.data(i)= u1_temp.data;
end

% Generate log output using u0
e=fi(0,1,e_w,e_f);
e.data=-2*log(u0.data);

%Square-Root of e
f=fi(0,1,f_w, f_f);
f.data=sqrt(e.data);
% 
% figure(1)
% plot(u0.data,f.data);

%Generate sin/cos using u1
g0=fi(0,1,g0_w,g0_f);
g1=fi(0,1,g1_w,g1_f);

g0.data= sin(2*pi*u1.data);
g1.data= cos(2*pi*u1.data);

%Generate x0 and x1
x0=fi(0,1,x0_w,x0_f);
x1=fi(0,1,x1_w,x1_f);

x0.data=f.data.*g0.data;
x1.data=f.data.*g1.data;

%%
figure(1)
histogram(x0.data);
title('Histogram of x0');
figure(1)
histogram(x1.data);
title('Histogram of x1');

if (kstest(x0.data)==0)
display('x0 is fits a normal distribution since, it rejects the null hypothesis');
else 
    display('x0 does not describe a normal distribution');
end

    
if (kstest(x1.data)==0)
display('x1 is fits a normal distribution since, it rejects the null hypothesis');
else 
    display('x1 does not describe a normal distribution');
end



