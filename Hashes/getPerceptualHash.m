function hash = getPerceptualHash(filename)
%GETPERCEPTUALHASH Performs perceptual hash

orig_img = imread(filename);
% gray_img = orig_img;
gray_img = imresize(orig_img,[64 256]);

% imshow(gray_img)
% imshow(small_img)
% gray_image = rgb2gray(small_img);
% gray_image = small_img;
% imshow(gray_image)
ave = mean(gray_img(:));

black_and_white_img = (gray_img>ave);
% imshow(black_and_white_img)
% disp(black_and_white_img);
hash = black_and_white_img(:);

end

