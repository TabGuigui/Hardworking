close all;
clear all;
clc;
g_src = imread('309.bmp');
g_src_gray = rgb2gray(g_src);
%获得图片大小
[M,N]=size(g_src_gray);
%掩模操作
I = im2double(g_src);
load Mask;
result_1 = I(:,:,1).*Mask;
result_2 = I(:,:,2).*Mask;
result_3 = I(:,:,3).*Mask;
result = cat(3,result_1,result_2,result_3);
result = im2uint8(result); 
imshow(result);
s = load ('array_sample.mat');
a1 = find(s.array_sample(:,5)==1);
a2 = find(s.array_sample(:,5)==-1);
%提取第一类样本点
W1_R = round(s.array_sample(a1,2)*255);%第一类样本点R值
W1_G = round(s.array_sample(a1,3)*255);%第一类样本点G值
W1_B = round(s.array_sample(a1,4)*255);
W1 = [W1_R,W1_G,W1_B];
%提取第二类样本点
W2_R = round(s.array_sample(a2,2)*255);
W2_G = round(s.array_sample(a2,3)*255);
W2_B = round(s.array_sample(a2,4)*255);
W2 = [W2_R,W2_G,W2_B];
sig = 0.1;
for m=1:M
    for n = 1:N
        if(result(m,n,:)==0)
            X(m,n,:)=0;
        else
            r1 = parzen_RGB(W1,sig,result(m,n,:));
            r2 = parzen_RGB(W2,sig,result(m,n,:));
            if(r1>=r2)
                X(m,n,:) = 0.5;
            else
                X(m,n,:) = 0.3;
            end
        end
    end
end
figure(2);
imshow(X)