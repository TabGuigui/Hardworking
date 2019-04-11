close all;
clear all;
clc;
g_src = imread('309.bmp'); %读取图片
g_gray = rgb2gray(g_src); %灰度转换
I = im2double(g_gray);%像素值转换为double类型
load Mask; %Mask为double类型
result = I.*Mask; %掩模覆盖
result = im2uint8(result);
subplot(131),imshow(g_gray),title('原图');
subplot(132),imshow(result),title('加上掩模的图');
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
subplot(133),imshow(result),title('两分类图');
            