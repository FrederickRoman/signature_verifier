function hash = getPHash(filename)
%GETPHASH Performs pHash as describe on the paper

DEBUG = 0; % Change to = 1 if you want to see the process


orig_img = imread(filename);
if DEBUG
    figure(1)
    imshow(orig_img)
    title('Original image')
end



% Resize image
gray_img = imresize(orig_img,[64 256]); 



if DEBUG
    figure(2)
    imshow(gray_img)
    title('Gray resized image')
end

% Perform DCT
dct_img = dct2(gray_img);

if DEBUG
figure(3)
imshow(dct_img)
title('DCT image all frequencies')
end



if DEBUG
    figure(4)
    imshow(log(abs(dct_img)),[]), colormap(jet(64)), colorbar
    title('Image energy scale')
end



% Cut-out higher frequencies
num_freq_passed = 32; 
dct_low_freqs = dct_img(1:num_freq_passed,1:num_freq_passed);

if DEBUG
    figure(5)
    imshow(dct_low_freqs)
    title('DCT image low frequencies')
end
gray_img = dct_low_freqs;

% Exclude DC component
gray_img_vec = gray_img(:);
gray_img_without_dc_comp = gray_img_vec(2:end,1);  
ave = mean(gray_img_without_dc_comp);


black_and_white_img = (gray_img>ave).*gray_img;  
hash = black_and_white_img(:);


if DEBUG
    figure(6)
    padded = zeros(size(orig_img));
    padded(1:num_freq_passed,1:num_freq_passed) = ...
        black_and_white_img.*255
    padded
    reconstructed_img = idct2(padded, size(orig_img))
    imshow(reconstructed_img)
    title('Reconstructed grayscale without pure DC using 128 freqs')
end

end

