function labeled_instances = hard_linear_svm(training_set, testing_set, use_best_model_found)
%HARD_LINEAR_SVM Summary of this function goes here
%   Detailed explanation goes here

% Turn training set and  testing set to svm_ligth format
training_set_svm_fname = 'training_svm_file.txt';
turnToSVMLightFormat(training_set, training_set_svm_fname);
testing_set_svm_fname = 'testing_svm_file.txt';
turnToSVMLightFormat(testing_set, testing_set_svm_fname);

% Obtain a linear model using svm_light 
if use_best_model_found % just use that model to classify
    model_svm_fname = 'best_model_so_far_svm.txt';
else % learn a new model
    model_svm_fname = 'model_svm.txt';
    % Use svm_ligth to learn
    system(['svm_learn ', training_set_svm_fname, ' ', model_svm_fname]);
end

% Use svm_ligth to classify
predictions_svm_fname = 'predictions_svm.txt'; % Save the predictions
system(['svm_classify ', testing_set_svm_fname, ' ',...
    model_svm_fname, ' ', predictions_svm_fname]);

% Retrieve actual values
fid = fopen(testing_set_svm_fname);
correct_test_labels_Cell = textscan(fid,'%d %*[^\n]','bufsize',2200000);
correct_test_labels = correct_test_labels_Cell{1,1};
fclose(fid);


% retrieve classification error
fid = fopen(predictions_svm_fname);
predicted_test_geo_margin = textscan(fid,'%f %*[^\n]','bufsize',2200000);
predicted_test_labels = sign(predicted_test_geo_margin{1,1});
fclose(fid);

% Translate label format from {1,-1} to  {'Real', 'Fake'}
num_of_instances = length(correct_test_labels);
labeled_instances = cell(2, num_of_instances);
% Translate true labels
for i =  1:num_of_instances
    correct_test_label = correct_test_labels(i);
    if correct_test_label == 1
        labeled_instances{1,i} = 'Real';
    elseif correct_test_label == -1
        labeled_instances{1,i} = 'Fake';
    else % Degenarative case
        error('Instance true label must be ''Real'' or ''Fake''')
    end
end
% Translate true labels
for i =  1:num_of_instances
    predicted_test_label = predicted_test_labels(i);
    if predicted_test_label == 1
        labeled_instances{2,i} = 'Real';
    elseif predicted_test_label == -1
        labeled_instances{2,i} = 'Fake';
    else % Degenarative case
        error('Instance predicted label must be ''Real'' or ''Fake''')
    end
end

end

