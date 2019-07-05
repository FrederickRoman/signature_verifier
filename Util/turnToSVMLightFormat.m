function [file_name] = turnToSVMLightFormat(sample_set, file_name)
%TURNTOSVMLIGHTFORMAT Summary of this function goes here
%   Detailed explanation goes here

% Write the rows of not_S_i_s into a file
test_fid = fopen(file_name,'w');


for i=1:size(sample_set,2)

    label_str = sample_set{2,i};
    if strcmp(label_str,'Real')
        label_case = '1';
    elseif strcmp(label_str,'Fake')
        label_case = '-1';
    else % degenerative case
        error('label must be either ''Real'' or ''Fake''')
    end
    x_feature_vec = sample_set{1,i};
    
    
    size(x_feature_vec);
   
    instance_line = label_case;
    for j = 1:size(x_feature_vec,1);
        x_feature = x_feature_vec(j);
        instance_line = ...
            [instance_line,...
            ' ',num2str(j),':',num2str(x_feature)];
    end
%     instance_line = [instance_line, '\n']
%     fprintf(instance_line)
   fprintf(test_fid, '%s \n',instance_line);
end


   
    fclose(test_fid);



end
