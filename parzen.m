
function r=parzen(w,sig,x) %wΪ������sigΪ���ڲ�����xΪ����ֵ
[rows,~,dimension] = size(w);
r=zeros(1,dimension);
for i = 1:rows
        g= -(0.5)*(x-w(i,:))*(x-w(i,:))'/power(sig,2);
        g=double(g);
        r= r+exp(g)/(sqrt(2*pi)*sig);
    end
    r= r/rows;

end
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

