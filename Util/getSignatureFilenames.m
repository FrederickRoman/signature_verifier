function signature_filenames = getSignatureFilenames(labels, authors, start_nums, end_nums, cutoff)
%GETSIGNATUREFILENAMES Collects all the signature filenames.
%i.e. getSignatureFilenames({'Real' 'Fake' 'Fake' 'Fake'}, {'Will' 'Fred' 'Min' 'Willy'}, [1 1 1 1], [100 20 20 20], 100)

total_num_images = 0;
N=length(labels);
for i=1:N
    total_num_images = total_num_images + (end_nums(i)-start_nums(i)+1);
end
signature_filenames = cell(1,total_num_images);

if nargin==4 || cutoff == -1
    cur = 1;
    for i=1:N
        for k=start_nums(i):end_nums(i)
            signature_filenames{cur} = [labels{i} '_' authors{i} '_im' num2str(k) '.bmp'];
            cur = cur + 1;
        end
    end
else
    cur = 1;
    for i=1:N
        for k=start_nums(i):end_nums(i)
            signature_filenames{cur} = [labels{i} '_' authors{i} '_im' num2str(k) '_cutoff_' num2str(cutoff) '.bmp'];
            cur = cur + 1;
        end
    end
end



end

