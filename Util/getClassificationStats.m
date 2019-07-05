function [class_matrix, percentCorrect] = getClassificationStats(labeled_instances, labels)
%getClassificationStats Gets stats related to the classifications
% class_matrix(i,j) contains the number of times a sample with true
% labeling i was classified as having labeling j

N = length(labeled_instances);
n_labels = length(labels);
class_matrix = zeros(n_labels,n_labels);
for i = 1:N
    true_label = labeled_instances{1,i};
    classification = labeled_instances{2,i};
    true_idx = find(strcmp(true_label,labels), 1);
    class_idx = find(strcmp(classification,labels), 1);
    class_matrix(true_idx, class_idx) = class_matrix(true_idx, class_idx) + 1;
end

percentCorrect = sum(diag(class_matrix))/sum(sum(class_matrix));
end

