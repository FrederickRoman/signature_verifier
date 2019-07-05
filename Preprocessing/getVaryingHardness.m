function getVaryingHardness(filename, cutoff)
%GETVARYINGHARDNESS Gets only the parts of the picture that are darker than
%a given cutoff. Saves the file.
[~,name, ext] = fileparts(filename);
img = imread(filename);
trimmed_picture = uint8(img <= cutoff).*img + uint8(img > cutoff).*255;
imwrite(trimmed_picture, [name '_cutoff_' num2str(cutoff) ext])


end

