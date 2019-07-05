function labeled_instances = kNN3(training_set, testing_set, distance_measure)
%KNN Performs kNN with k=3 on the testing_set using the training_set.
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
    % This is awful programming but I don't really care right now
    min_dist1 = Inf;
    min_dist2 = Inf;
    min_dist3 = Inf;
    label1 = '';
    label2 = '';
    label3 = '';
    for i = 1:nTraining
        dist = distance_measure(hashed_val, neighbors{i});
        if dist<min_dist1
            min_dist3 = min_dist2;
            min_dist2 = min_dist1;
            min_dist1 = dist;
            label3 = label2;
            label2 = label1;
            label1 = training_classifications{i};
        elseif dist<min_dist2
            min_dist3 = min_dist2;
            min_dist2 = dist;
            label3 = label2;
            label2 = training_classifications{i};                
        elseif dist<min_dist3
            min_dist3 = dist;
            label3 = training_classifications{i};
        end
    end
    label = label1;
    if (strcmp(label2,label3))
        label = label2;
    end
    labeled_instances{2,j} = label;
end

end

