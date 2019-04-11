close all;
clear all;
clc;
g_src = imread('309.bmp');
g_src_gray = rgb2gray(g_src);
%���ͼƬ��С
[M,N]=size(g_src_gray);
%��ģ����
I = im2double(g_src);
load Mask;
result_1 = I(:,:,1).*Mask;
result_2 = I(:,:,2).*Mask;
result_3 = I(:,:,3).*Mask;
result = cat(3,result_1,result_2,result_3);
result = im2uint8(result);
subplot(131),imshow(g_src)
subplot(132),imshow(result)

%��ȡ������Ϣ
s = load ('array_sample.mat')
[m,n] = size(s.array_sample);
%��һ������
a1 = find(s.array_sample(:,5)==1);
num1 = length(a1);
%�ڶ�������
a2 = find(s.array_sample(:,5)==-1);
num2 = length(a2);
%�������
P_w1 = num1/m;
P_w2 = num2/m;
%��ȡ����RGB
W1_R = round(s.array_sample(a1,2)*255);%��һ��������Rֵ
W1_G = round(s.array_sample(a1,3)*255);%��һ��������Gֵ
W1_B = round(s.array_sample(a1,4)*255);
W1 = [W1_R,W1_G,W1_B];
W2_R = round(s.array_sample(a2,2)*255);
W2_G = round(s.array_sample(a2,3)*255);
W2_B = round(s.array_sample(a2,4)*255);
W2 = [W2_R,W2_G,W2_B];
%��ֵ
u1 = mean(W1)';
u2 = mean(W2)';
%Э�������
sig1=cov(W1);
sig2=cov(W2);
%����ģ�������б任
X = reshape(double(result),M*N,3)';
for k=1:M*N
    if (X(:,k)==[0;0;0])
        result_RGB(:,k) = [0;0;0];
    else
        %�������������ܶ� �� ��Ҫ���������
        P1=(exp(-0.5*(X(:,k)-u1)'*inv(sig1)*(X(:,k)-u1)))/((2*pi)^(3/2)*(det(sig1))^(1/2));
        P2=(exp(-0.5*(X(:,k)-u2)'*inv(sig2)*(X(:,k)-u2)))/((2*pi)^(3/2)*(det(sig2))^(1/2));
        %�����б���g��x���������
        g1 = -1.5*log(2*pi)-0.5 *log(det(sig1))+(-0.5)*(X(:,k)-u1)'* inv(sig1) * (X(:,k)-u1) + log(P_w1);
        g2 = -1.5*log(2*pi)-0.5 *log(det(sig2))+(-0.5)*(X(:,k)-u2)'* inv(sig2) * (X(:,k)-u2) + log(P_w2);
        if(g1>=g2)
            result_RGB(:,k)=[200,50,0];
        else
            result_RGB(:,k)=[0,100,0];
        end
    end
end
%������ת��ΪM*N*3��ͨ��ͼƬ
result_RGB = reshape((result_RGB)',M,N,3);
subplot(133),imshow(result_RGB);




