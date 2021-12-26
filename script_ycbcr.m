close all; clear all; clc;
%read  initial template image and convert to double:
% I1 = im2double(imread('smiley\fluor5_smiley_012.jpg'));

% I1 = im2double(imread('smiley\tung6_smiley_035.jpg'));

% I1 = im2double(imread('smiley\sunI4_smiley_134.jpg'));

% I2 = im2double(imread('smiley\fluor5_smiley_011.jpg'));

% % % % % % % % % % 
% FINAL DECISION OF Source IMAGE 
I1 = im2double(imread('smiley\fluor5_smiley_009.jpg'));
% FINAL DECISION OF Target IMAGE 
I2 = im2double(imread('smiley\sunD7_smiley_077.jpg'));

% % % % % % % % % % 

figure,imshow(I1);
title('RGB image');

% convert rgb to ycbcr
I=rgb2ycbcr(I1);

figure,imshow(I);
title('YCbCr image');

% Extract color channels and convert to grayscale:
% Source Image:
I_y = I1(:,:,1); 
I_cb = I1(:,:,2);
I_cr = I1(:,:,3);
I_gs=rgb2gray(I1);

% Target Image:
I_y2 = I2(:,:,1); 
I_cb2 = I2(:,:,2);
I_cr2 = I2(:,:,3);
I_gs2=rgb2gray(I2);

%Show image for cropping limits
figure , imshow(I1);

%Show Source and Target image:
figure,
subplot(1,2,1);
imshow(I1);
title('Source Image:');
subplot(1,2,2);
imshow(I2);
title('Target Image:');

% Tried before:
% Cropped reference image for rgb colors and grayscale:
% smiley\fluor5_smiley_012.jpg  :
%      R_y = I_y(126:168, 184:226);
%      R_cb = I_cb(126:168, 184:226);
%      R_cr = I_cr(126:168, 184:226);
%      R_gs = I_gs(126:168, 184:226);
%      
%  smiley\sunD7_smiley_077.jpg  :
%      R_red = I_y(18:60, 190:240);
%      R_green = I_cb(18:60, 190:240);
%      R_blue = I_cr(18:60, 190:240);
%      R_gs = I_gs(18:60, 190:240);
%      
%  smiley\fluor1_smiley_054.jpg   :
%      R_red = I_y(90:130, 100:150);
%      R_green = I_cb(90:130, 100:150);
%      R_blue = I_cr(90:130, 100:150);
%      R_gs = I_gs(90:130, 100:150);
     
    
% smiley\fluor4_smiley_111.jpg
%      R_red = I_y(100:140, 120:160);
%      R_green = I_cb(100:140, 120:160);
%      R_blue = I_cr(100:140, 120:160);
%      R_gs = I_gs(100:140, 120:160);

% smiley\tung6_smiley_035.jpg
%      R_y = I_y(120:160, 50:90);
%      R_cb = I_cb(120:160, 50:90);
%      R_cr = I_cr(120:160, 50:90);
%      R_gs = I_gs(120:160, 50:90);
%      
% smiley\sunI4_smiley_134.jpg
%      R_y = I_y(120:150, 190:230);
%      R_cb = I_cb(120:150, 190:230);
%      R_cr = I_cr(120:150, 190:230);
%      R_gs = I_gs(120:150, 190:230);
    
%smiley\fluor5_smiley_009.jpg
     R_y = I_y(90:120,100:140);
     R_cb = I_cb(90:120,100:140);
     R_cr = I_cr(90:120,100:140);
     R_gs = I_gs(90:120,100:140);
        
% Show Cropped Images for Every channel and for grayscale:
figure,
subplot(2,2,1);
imshow(R_y);
title('Cropped Image in Y channel:')
subplot(2,2,2);
imshow(R_cb);
title('Cropped Image in Cb channel:')
subplot(2,2,3);
imshow(R_cr);
title('Cropped Image in Cr channel:')
subplot(2,2,4);
imshow(R_gs);
title('Cropped Image in grayscale:')
     
% Call the funcion file Temp_Match_RGB to compute similarities:
% RGB is just the name , nothing to do with rgb color components
 S_y=Temp_Match_RGB(I_y2 , R_y);
 S_cb=Temp_Match_RGB(I_cb2 , R_cb);
 S_cr=Temp_Match_RGB(I_cr2 , R_cr);
 S_gs=Temp_Match_RGB(I_gs2 , R_gs);
 
% An idea:(proved wrong)
% invert the iluminance so that temp match works with searching 
% local maximum procedure again and not with the minimum :
% S_y = 1 - S_y;
% S_cb = 1 - S_cb;
% S_cr = 1 - S_cr;
% S_gs = 1 - S_gs;

% Merging:
% Compute optimization similarities: 
% Take the mean and 2 other ways to merge:
% Take the mean
S_mean=(S_y+S_cb+S_cr)/3;
% And with a combination of weights:
S_ycbcr2=0.5*S_y+0.2*S_cb+0.2*S_cr;
% And with another combination of weights:
S_ycbcr3=0.2*S_y+0.35*S_cb+0.35*S_cr;
% just in case i need something to change:
S_gs = S_gs;

% % % % Diplay Simliarities all together % % %
figure,
subplot(2,3,1);
imshow(S_y);
title('Y');
subplot(2,3,2);
imshow(S_cb)
title('Cb:');
subplot(2,3,3);
imshow(S_cr);
title('Cr:');
subplot(2,3,4);
imshow(S_mean);
title('Mean:');
subplot(2,3,5);
imshow(S_ycbcr2);
title('ycbcr2 combination of weights:');
subplot(2,3,6);
imshow(S_ycbcr3);
title('ycbcr3 combination of weights:');
% % % % diplay Simliarity in grayscale % % %
figure, imshow(S_gs);
title('Grayscale:');


% Find the position(row and column) 
% and the value (mx) of the merged similarity arrays:
% in color channels:
[r_mean_2, c_mean_2, mx_mean_2 ] = local_max (S_mean);
[r_ycbcr2_2, c_ycbcr2_2, mx_ycbcr2_2 ] = local_max (S_ycbcr2);
[r_ycbcr3_2, c_ycbcr3_2, mx_ycbcr3_2 ] = local_max (S_ycbcr3);
% and in grayscale image:
[r_gs, c_gs, mx_gs ] = local_max (S_gs);


%Thresholding:
% In merging:
T_mean=0.9;
T_ycbcr2=0.9;
T_ycbcr3=0.9;
T_gs=0.9;
[r_mean_2, c_mean_2] = find( mx_mean_2 > T_mean * max(mx_mean_2(:)));
[r_ycbcr2_2, c_ycbcr2_2] = find( mx_ycbcr2_2 > T_ycbcr2 * max(mx_ycbcr2_2(:)));
[r_ycbcr3_2, c_ycbcr3_2] = find( mx_ycbcr3_2 > T_ycbcr3 * max(mx_ycbcr3_2(:)));
% In grayscale image
[r_gs, c_gs] = find( mx_gs > T_gs * max(mx_gs(:)));


% Apply Template Matching in the target image I2:
% with grayscale:
draw_match(I2, R_gs, [r_gs c_gs]);
title('Merging with grayscale in I2');
% with merging scenario:
draw_match(I2, R_cb, [r_mean_2 c_mean_2]);
title('Merging with mean in I2');
% weights rgb2 scenario:
draw_match(I2, R_cb, [r_ycbcr2_2 c_ycbcr2_2]);
title('Merging with ycbcr2 in I2');
% weights rgb3 scenario:
draw_match(I2, R_cb, [r_ycbcr3_2 c_ycbcr3_2]);
title('Merging with ycbcr3 in I2');
