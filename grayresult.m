close all;
clear all;
clc;
g_src = imread('309.bmp'); %��ȡͼƬ
g_gray = rgb2gray(g_src); %�Ҷ�ת��
I = im2double(g_gray);%����ֵת��Ϊdouble����
load Mask; %MaskΪdouble����
result = I.*Mask; %��ģ����
result = im2uint8(result);
subplot(131),imshow(g_gray),title('ԭͼ');
subplot(132),imshow(result),title('������ģ��ͼ');
for i=1:240
    for j=1:320
        if (result(i,j)>156)
            result(i,j)=255;
        end
        if(result(i,j)<156&&result(i,j)>0)
            result(i,j)=50;
        end
    end
end
subplot(133),imshow(result),title('������ͼ');
            