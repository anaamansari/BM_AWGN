%   ELEN 249 SCU Winter 2016 
%   Anaam Ansari


%   Script to generate polyfit coefficients 

%% for log(x) over x [0,1)
log_seg=256;                        % Number of segments in x 
start_l=2;                    % x range start value
end_l=4;                            % x range end value 
B_log=27;                           % Number of bits used to represent the log(x)
res_log=(2^B_log)/log_seg;          % resolution of a segment
l=linspace(start_l,end_l,log_seg);  % Split the segments

%Precision for the logarithmic unit
e_w=31;                             % Total bitwidth of output 
e_f=24;                             % Fractional bitwidth of output

c2_w=32;                            % Total bitwidth of coeff C2
c2_f=27;                            % Frac bitwidth of coeff C2
c1_w=32;                            % Total bitwidth of coeff C1
c1_f=27;                            % Frac bitwidth of coeff C1
c0_w=32;                            % Total bitwidth of coeff C0
c0_f=27;                            % Frac bitwidth of coeff C0

for i=1:(length(l))
    if(i < length(l))
    l_log(i,:)=linspace(l(i),l(i+1),res_log);
%     if i==1
%         p_log(i,:)=0;
%     else
    p_log(i,:)=polyfit(l_log(i,:),log(l_log(i,:)),2);
%f_log(i,:)=polyval(p_log(i,:),l_log(i,:));
 f_log(i,:)=p_log(i,1)*l_log(i,:).^2 + p_log(i,2)*l_log(i,:) + p_log(i,3);
%     end
    else
        l_log(i,:)=linspace(l(i),end_l,res_log);
        p_log(i,:)=polyfit(l_log(i,:),log(l_log(i,:)),2);
        %f_log(i,:)=polyval(p_log(i,:),l_log(i,:));
      f_log(i,:)=p_log(i,1)*l_log(i,:).^2 + p_log(i,2)*l_log(i,:) + p_log(i,3);
    end
end

%Store the coefficients
C0=fi(p_log(:,3),1,c0_w,c0_f);
C1=fi(p_log(:,2),1,c1_w,c1_f);
C2=fi(p_log(:,1),1,c2_w,c2_f);

f_log1=reshape(f_log', 1,log_seg*res_log);
l_log1=reshape(l_log',1,log_seg*res_log);
err_log= max(abs(f_log1 - log(l_log1)));
display(err_log);

spec_err_log= 2^(-26);
display(spec_err_log);

if(err_log<=spec_err_log)
    disp('error specification is satisfied')
else
    disp('error specification is not satisfied')
end
figure(1)
plot(l_log1,f_log1,l_log1,log(l_log1)); grid on, legend('f_{log}(x)', 'log(x)')

%%

for i=1:length(C0) 
    C(i,:)=hex(C0(i));
    B(i,:)=hex(C1(i));
    A(i,:)=hex(C2(i));
end