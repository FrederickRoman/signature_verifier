function labeled_instances = centroidMin(training_set, testing_set, distance_measure, labels)
%CENTROIDMIN Finds the centroid for the labels in the training_set.
% Then finds the minimum distance between the centroids and examples
% Should be used with getEuclideanDistance or the like, but
% NOT getHammingDistance

nLabels = length(labels);
labelCounts = zeros(1,nLabels);
lVector = length(training_set{1,1});
vectorSums = zeros(lVector, nLabels);
centroids = zeros(lVector, nLabels);

nTraining = length(training_set);
% neighbors = cell(1,nTraining);
% training_classifications = cell(1,nTraining);
for i = 1:nTraining
    labelNum = find(strcmp(training_set{2,i},labels), 1);
    labelCounts(labelNum) = labelCounts(labelNum) + 1;
%     size(vectorSums(:,labelNum))
%     size(training_set{1,i})
    vectorSums(:,labelNum) = vectorSums(:,labelNum) + training_set{1,i};
end
for k = 1:nLabels
    centroids(:,k)=vectorSums(:,k)/labelCounts(k);
end

nTesting = length(testing_set);
labeled_instances = cell(2,nTesting);
for j = 1:nTesting
    labeled_instances{1,j} = testing_set{2,j};
end

for j = 1:nTesting
    hashed_val = testing_set{1,j};
    min_dist = Inf;
    label = '';
    for i = 1:nLabels
        dist = distance_measure(hashed_val, centroids(:,i));
        if dist<min_dist
            min_dist = dist;
            label = labels(i);
        end
    end
    labeled_instances{2,j} = label;
end

end



