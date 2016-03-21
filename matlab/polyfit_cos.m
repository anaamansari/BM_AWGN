
%   ELEN 249 SCU Winter 2016 
%   Anaam Ansari


%   Script to generate polyfit coefficients 

%% for cosine(x*pi/2) over x [0,1) 

clear 
cos_seg=128;                        % Number of segments in x    
start_x=0;                          % x range start value
end_x=1;                            % x range end value                
B_cos=14;                           % Number of bits used to represent the cos(x)
%Polyfitting cos(x) for x=[0,pi/2)
res_cos=(2^B_cos)/128;              % resolution of a segment
x=linspace(start_x,end_x,cos_seg);  % Split the segments  

%Precision for the sinosoidal unit
c0_w=19;                            % Total Bit width of C0
c0_f=17;                            % Fractional Bitwidth of C0
c1_w=19;                            % Total Bit width of C1
c1_f=17;                            % Fractional Bitwidth of C1

g0_w=16;                            % Total Bit width of output g0
g0_f=15;                            % Fractional Bitwidth of output g0
g1_w=16;                            % Total Bit width of output g1
g1_f=15;                            % Fractional Bithwidth of output g1

%Defining fixed point numbertype for C0,C1, x_cos and f_cos
C0=fi(0,1,c0_w,c0_f);               % coefficient C0
C1=fi(0,1,c1_w,c1_f);               % coefficient C1
f_cos=fi(zeros(cos_seg,res_cos),1,g0_w,g0_f);       % f_cos=polyval approx  
x_cos=fi(zeros(cos_seg,res_cos),0,16,16);           % x_cos is the input 

% Polyfit approximation
for i=1:(length(x))
     if(i < length(x))
    x_cos.data(i,:)=linspace(x(i),x(i+1),res_cos);
    p_cos(i,:)=polyfit(x_cos.data(i,:),cos(x_cos.data(i,:).*pi./2),1);
    C0.data(i)=p_cos(i,2);
    C1.data(i)=p_cos(i,1);
    f_cos.data(i,:)=C1.data(i).*x_cos.data(i,:) +C0.data(i);
     else
    x_cos.data(i,:)=linspace(x(i),end_x,res_cos);
    p_cos(i,:)=polyfit(x_cos.data(i,:),cos(x_cos.data(i,:).*pi./2),1);
    C0.data(i)=p_cos(i,2);
    C1.data(i)=p_cos(i,1);
    f_cos.data(i,:)=C1.data(i).*x_cos.data(i,:) +C0.data(i);
     end
     
end


%Comarison of the polyfit reconstructed function with the inbuilt cos funct
x_cos1=reshape(x_cos.data',1,cos_seg*res_cos);
f_cos1=reshape(f_cos.data',1,cos_seg*res_cos);
err_cos= max(abs(f_cos1- cos(x_cos1.*pi./2)));
display(err_cos);

spec_err_cos= 2^(-15);
display(spec_err_cos);

if(err_cos<=spec_err_cos)
    disp('error specification is satisfied')
else
    disp('error specification is not satisfied')
end
figure(1)
plot(x_cos1*pi/2,f_cos1,x_cos1*pi/2,cos(x_cos1*pi/2)); grid on, legend('f_{cos}(x)', 'cos(x)')

%Storing the coefficients as hex numbers
for i=1:length(C0) 
    C(i,:)=hex(C0(i));
    B(i,:)=hex(C1(i));
end
