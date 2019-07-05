function labeled_instances = kNN(training_set, testing_set, distance_measure)
%KNN Performs kNN with k=1 on the testing_set using the training_set.
% Both training_set and testing_set contain {hash, label} pairs
%Uses distance_measure to get the distance between the hashes
% labeled_instances contains {true labeling, kNN classification} pairs
% i.e. 
% labeled_instances{1,i} contains the true labeling of instance i
% labeled_instances{2,i} contains the lNN classification of instance i


nTesting = length(testing_set);
labeled_instances = cell(2,nTesting);
for j = 1:nTesting
    labeled_instances{1,j} = testing_set{2,j};
end

nTraining = length(training_set);
neighbors = cell(1,nTraining);
training_classifications = cell(1,nTraining);
for i = 1:nTraining
    neighbors{i} = training_set{1,i};
    training_classifications{i} = training_set{2,i};
end

for j = 1:nTesting
    hashed_val = testing_set{1,j};
    min_dist = Inf;
    label = '';
    for i = 1:nTraining
        dist = distance_measure(hashed_val, neighbors{i});
        if dist<min_dist
            min_dist = dist;
            label = training_classifications{i};
        end
    end
    labeled_instances{2,j} = label;
end

end

