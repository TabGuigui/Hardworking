
function r=parzen(w,sig,x) %w为样本，sig为窗口参数，x为输入值
[rows,~,dimension] = size(w);
r=zeros(1,dimension);
for i = 1:rows
        g= -(0.5)*(x-w(i,:))*(x-w(i,:))'/power(sig,2);
        g=double(g);
        r= r+exp(g)/(sqrt(2*pi)*sig);
    end
    r= r/rows;

end
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明

