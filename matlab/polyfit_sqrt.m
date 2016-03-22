%   ELEN 249 SCU Winter 2016 
%   Anaam Ansari


%   Script to generate polyfit coefficients 

%% for sqrt(x) over x [1,2)
% We need to also approximate sqrt(x) for x[2,4)
% simply change start_m to 2 and and end_m to 4.
clear
sqrt_seg=64;            
start_m=1;
end_m=2;
B_sqrt=16;
res_sqrt=(2^B_sqrt)/sqrt_seg;
m=linspace(start_m,end_m,sqrt_seg);


%Precision for the squaroot unit
f_w=17;
f_f=14;


c0_w=32;                        % Total Bitwidth for C0
c0_f=27;                        % Fractional Bitwidth for C0
c1_w=32;                        % Total Bitwidth for C1
c1_f=27;                        % Fractional Bitwidth for C1
C0=fi(0,1,c0_w,c0_f);           % Fixed point C0
C1=fi(0,1,c1_w,c1_f);           % Fixed point C1
f_sqrt=fi(zeros(sqrt_seg,res_sqrt),0,f_w,f_f);  
m_sqrt=fi(zeros(sqrt_seg,res_sqrt),1,31,24);

for i=1:(length(m))
    if(i < length(m))
    m_sqrt.data(i,:)=linspace(m(i),m(i+1),res_sqrt);
    p_sqrt(i,:)=polyfit(m_sqrt.data(i,:),sqrt(m_sqrt.data(i,:)),1);
    C0.data(i)=p_sqrt(i,2);
    C1.data(i)=p_sqrt(i,1);
    f_sqrt.data(i,:)=C1.data(i).*m_sqrt.data(i,:) +C0.data(i);
    else
        m_sqrt.data(i,:)=linspace(m(i),end_m,res_sqrt);
       p_sqrt(i,:)=polyfit(m_sqrt.data(i,:),sqrt(m_sqrt.data(i,:)),1);
      C0.data(i)=p_sqrt(i,2);
    C1.data(i)=p_sqrt(i,1);
    f_sqrt.data(i,:)=C1.data(i).*m_sqrt.data(i,:) +C0.data(i);
    end
end

% Comparing approximation
f_sqrt1=reshape(f_sqrt.data', 1,sqrt_seg*res_sqrt);
m_sqrt1=reshape(m_sqrt.data',1,sqrt_seg*res_sqrt);
err_sqrt= max(abs(f_sqrt1 - sqrt(m_sqrt1)));
display(err_sqrt);

spec_err_sqrt= 2^(-16);
display(spec_err_sqrt);

if(err_sqrt<=spec_err_sqrt)
    disp('error specification is satisfied')
else
    disp('error specification is not satisfied')
end
figure(1)
plot(m_sqrt1,f_sqrt1,m_sqrt1,sqrt(m_sqrt1)); grid on, legend('f_{sqrt}(x)', 'sqrt(x)')

for i=1:length(C0) 
    C(i,:)=hex(C0(i));
    B(i,:)=hex(C1(i));
end

