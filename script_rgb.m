close all; clear all; clc;

% We want to find the smiley template from this Source Image
I1 = im2double(imread('smiley\fluor1_smiley_056.jpg'));
% In this Target Image
I2 = im2double(imread('smiley\fluor1_smiley_057.jpg'));

% ok found

% from here 
I1 = im2double(imread('smiley\fluor1_smiley_056.jpg'));
% to here
I2 = im2double(imread('smiley\fluor2_smiley_027.jpg'));

% failed

% from here 
I1 = im2double(imread('smiley\fluor1_smiley_056.jpg'));
% to here
I2 = im2double(imread('smiley\fluor4_smiley_112.jpg'));

% failed

% Final decision of Source and Target Image: 
% We want to find the smiley template from this Source Image
I1 = im2double(imread('smiley\fluor5_smiley_009.jpg'));
% In this Target Image
I2 = im2double(imread('smiley\sunD7_smiley_077.jpg'));

% Extract color channels and convert to grayscale:
% SOURCE IMAGE
I_red = I1(:,:,1); 
I_green = I1(:,:,2);
I_blue = I1(:,:,3);
I_gs=rgb2gray(I1);

% TAGET IMAGE
I_red2 = I2(:,:,1); 
I_green2 = I2(:,:,2);
I_blue2 = I2(:,:,3);
I_gs2=rgb2gray(I2);

%Show image for cropping limits
figure , imshow(I1);

%Show source and target image:
figure,
subplot(1,2,1);
imshow(I1);
title('Source Image:');
subplot(1,2,2);
imshow(I2);
title('Target Image:');

% Cropped reference image for rgb colors and grayscale:

% THE CROPPING IS FOR THE FIRST/Source IMAGE

% smiley\fluor1_smiley_056.jpg
%      R_red = I_red(50:90, 170:220);
%      R_green = I_green(50:90, 170:220);
%      R_blue = I_blue(50:90, 170:220);
%      R_gs = I_gs(50:90, 170:220);

%  smiley\fluor5_smiley_009.jpg
     R_red = I_red(90:120,100:140);
     R_green = I_green(90:120,100:140);
     R_blue = I_blue(90:120,100:140);
     R_gs = I_gs(90:120,100:140);
          
% Show Cropped Images for Every channel and for grayscale:
figure,
subplot(2,2,1);
imshow(R_red);
title('Cropped Image in red channel:')
subplot(2,2,2);
imshow(R_green);
title('Cropped Image in green channel:')
subplot(2,2,3);
imshow(R_blue);
title('Cropped Image in blue channel:')
subplot(2,2,4);
imshow(R_gs);
title('Cropped Image in grayscale:')

% Call the funcion file Temp_Match_RGB to compute similarities:
 S_red=Temp_Match_RGB(I_red2 , R_red);
 S_green=Temp_Match_RGB(I_green2 , R_green);
 S_blue=Temp_Match_RGB(I_blue2 , R_blue);
 S_gs=Temp_Match_RGB(I_gs2 , R_gs);
 

% Merging
% compute optimization similarities: 
% take the mean and 2 other ways with weihts to merge:
S_mean=(S_red+S_green+S_blue)/3;
S_rgb2=0.2*S_red+0.3*S_green+0.5*S_blue;
S_rgb3=0.2*S_red+0.4*S_green+0.4*S_blue;


S_gs = S_gs;

% % % % diplay Simliarities all together
% to help me with the weights % % %
figure,
subplot(2,3,1);
imshow(S_red);
title('red');

subplot(2,3,2);
imshow(S_green)
title('green');

subplot(2,3,3);
imshow(S_blue);
title('blue');

subplot(2,3,4);
imshow(S_mean);
title('mean');

subplot(2,3,5);
imshow(S_rgb2);
title('rgb2');

subplot(2,3,6);
imshow(S_rgb3);
title('rgb3');

% % % % diplay Simliarity in grayscale % % %
figure, imshow(S_gs);
title('Sgs');

% Find the position(row and column) 
% and the value (mx) of the merged similarity arrays:
% in color channels:
[r_mean_2, c_mean_2, mx_mean_2 ] = local_max (S_mean);
[r_rgb2_2, c_rgb2_2, mx_rgb2_2 ] = local_max (S_rgb2);
[r_rgb3_2, c_rgb3_2, mx_rgb3_2 ] = local_max (S_rgb3);
% and in grayscale image:
[r_gs, c_gs, mx_gs ] = local_max (S_gs);

% % helps % % 
% S_mean and T_mean go with r_mean_2 c_mean_2 mx_mean_2   
% S_rgb2 and T_rgb2 go with r_rgb2_2 c_rgb2_2 mx_rgb2_2   T_rgb2
% S_rgb3 and T_rgb3 go with r_rgb2_3 c_rgb2_3 mx_rgb2_3   T_rgb3

%Thresholding:
% in merging image:
T_mean=0.9;
T_rgb2=0.9;
T_rgb3=0.9;
T_gs=0.9;
[r_mean_2, c_mean_2] = find( mx_mean_2 > T_mean * max(mx_mean_2(:)));
[r_rgb2_2, c_rgb2_2] = find( mx_rgb2_2 > T_rgb2 * max(mx_rgb2_2(:)));
[r_rgb3_2, c_rgb3_2] = find( mx_rgb3_2 > T_rgb3 * max(mx_rgb3_2(:)));
% in grayscale image
[r_gs, c_gs] = find( mx_gs > T_gs * max(mx_gs(:)));

% Apply Template Matching in the target image I2:
% with grayscale:
draw_match(I2, R_gs, [r_gs c_gs]);
title('Merging with grayscale in I2');
% with merging scenario:
draw_match(I2, R_green, [r_mean_2 c_mean_2]);
title('Merging with mean in I2');
% weights rgb2 scenario:
draw_match(I2, R_blue, [r_rgb2_2 c_rgb2_2]);
title('Merging with rgb2 in I2');
% weights rgb3 scenario:
draw_match(I2, R_red, [r_rgb3_2 c_rgb3_2]);
title('Merging with rgb3 in I2');

