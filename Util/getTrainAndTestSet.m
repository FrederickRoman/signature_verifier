function [training_set, testing_set] = getTrainAndTestSet(hash_and_classification_table, labels, nTrains, nTests)
%GETTRAINANDTESTSET For label(i), obtains nTrains(i) training examples and
%nTests(i) testing examples.
% Precondition: hash_and_classification_table actually has the examples
nLabels=length(labels);

nTrain = 0;
nTest = 0;
for i=1:nLabels
    nTrain = nTrain + nTrains(i);
    nTest = nTest + nTests(i);
end

training_set = cell(2,nTrain);
testing_set = cell(2,nTest);
train_index = 1;
test_index = 1;
N = length(hash_and_classification_table);
perm = randperm(N);
i=1;
while any(nTrains) || any(nTests) %nTrain > 0 || nTest > 0
    sample_num = perm(i);
    label = hash_and_classification_table{2,sample_num};
    labelNum = find(strcmp(label,labels), 1);
%     labelNum
    if ~isempty(labelNum)
        if nTrains(labelNum) > 0
%             train_index
            training_set{1,train_index} = hash_and_classification_table{1,sample_num};
            training_set{2,train_index} = hash_and_classification_table{2,sample_num};
            train_index = train_index + 1;
            nTrains(labelNum) = nTrains(labelNum) - 1;
%             nTrain = nTrain - 1;
        elseif nTests(labelNum) > 0
            testing_set{1,test_index} = hash_and_classification_table{1,sample_num};
            testing_set{2,test_index} = hash_and_classification_table{2,sample_num};
            test_index = test_index + 1;
            nTests(labelNum) = nTests(labelNum) - 1;
%             nTest = nTest - 1;
        end
    end
    i = i + 1;
%     nTrains
%     nTests
end

end


