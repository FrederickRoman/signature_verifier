function cropSignaturesFromScan(signatureScan, isReal, author, page_id)
%CROPSIGNATURESFROMSCAN Summary of this function goes here
%   Detailed explanation goes here

im = rgb2gray(imread(signatureScan));
CUTOFF = 220;
checkAlignment(im, CUTOFF);

x_left_top = [180, 555, 930 1305, 1680];
y_left_top = [160, 910];
x_size = 290;
y_size = 640;

X_MARGIN = 10;
Y_MARGIN = 10;

% image_prefix = [isReal '_' author '_p' page_id '_im'];
image_prefix = [isReal '_' author '_im'];
counter = 1;
for c = x_left_top
    for r = y_left_top
        sig = im(c+X_MARGIN:c+x_size-X_MARGIN,r+Y_MARGIN:r+y_size-Y_MARGIN);
        altered_sig = increaseContrastGrayscale(sig, CUTOFF);
%         imwrite(altered_sig, [image_prefix num2str(counter) '.jpeg'], 'Mode', 'lossless')
%         imwrite(altered_sig, [image_prefix num2str(counter) '.bmp'])
        imwrite(altered_sig, [image_prefix num2str((page_id-1)*10+counter) '.bmp'])
        counter = counter + 1;
    end
end

end

function new_sig = increaseContrast(sig, cutoff)
    new_sig = (sig > cutoff).*255;
end

function new_sig = increaseContrastGrayscale(sig, cutoff)
    new_sig = uint8(sig <= cutoff).*sig + uint8(sig > cutoff).*255;
end

function checkAlignment(signatureScan, cutoff)
    X_BUFFER = 2;
    y_BUFFER = 2;
    
    p1_x_left_top = 71;
    p1_x_right_bottom = 97;
    p1_y_left_top = 79;
    p1_y_right_bottom = 107;
    
    verifcation_box_1 = signatureScan(p1_x_left_top+X_BUFFER:p1_x_right_bottom-X_BUFFER,...
        p1_y_left_top+y_BUFFER:p1_y_right_bottom-y_BUFFER);
    if mean(mean(verifcation_box_1)) > cutoff
       error('The signature page is not properly aligned with TOP LEFT'); 
    end
    
    p2_x_left_top = 2098;
    p2_x_right_bottom = 2124;
    p2_y_left_top = 1602;
    p2_y_right_bottom = 1630;
    
    verifcation_box_2 = signatureScan(p2_x_left_top+X_BUFFER:p2_x_right_bottom-X_BUFFER,...
        p2_y_left_top+y_BUFFER:p2_y_right_bottom-y_BUFFER);
    if mean(mean(verifcation_box_2)) > cutoff
       error('The signature page is not properly aligned with BOTTOM RIGHT'); 
    end
    
end

