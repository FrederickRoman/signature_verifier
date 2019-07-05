function saveVaryingHardnessImages(src, start_num, end_num, cutoff)
%saveVaryingHardnessImages Gets how hard the person pressed down on the paper
% Hardness value is larger if the person wrote darker

for i = start_num:end_num
        getVaryingHardness([src '_im' num2str(i) '.bmp'], cutoff)
end

