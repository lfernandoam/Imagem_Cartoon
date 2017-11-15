I=rgb2gray(imread('obama.jpg'));
med=medfilt2(I,[7 7]);
borda=edge(med,'log');
SE = strel('square',2);
bold = imdilate(borda,SE);
trueedge = bwareaopen(bold,90); % variar o threshold
imshow(trueedge)