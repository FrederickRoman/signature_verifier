function hash_classification_table = createHashAndClassificationTable(hash_function, signature_filenames)
%CREATEHASHANDCLASSIFICATIONTABLE Creates a hash and classification table

nSignatures = length(signature_filenames);
hash_classification_table = cell(2,nSignatures);
for i=1:nSignatures
    filename = signature_filenames{i};
    hash_classification_table{1,i} = hash_function(filename);
    temp = regexp(filename, '_', 'split');
    hash_classification_table{2,i} = temp(1);
end

end

