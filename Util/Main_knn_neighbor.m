%{
Image naming convention:
[label]_[author]_im[imNum]_(cutoff_CUTOFF).bmp
For example:
Fake_Fred_im1_cutoff_100.bmp
Real_Will_im57.bmp
%}

% Clean up
clc; clear; close all;

% Set BLACKNESS to -1 if you don't want to use the cutoff
% Otherwise set it to some value we have all the pictures for already
BLACKNESS = -1;
% Set this to the number of times you want to run the clustering alg
nTrials = 100; % you can change it to 100 to compare to our results 

% YOU DO NOT HAVE TO RUN THE FOLLOWING SECTION:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This will crop the images from the scans and prepend the labels:
% cropSignaturesFromScans('Will', 'Real', 'Will', 1, 10)
% cropSignaturesFromScans('Fred', 'Fake', 'Fred', 1, 2)
% cropSignaturesFromScans('Min', 'Fake', 'Min', 1, 2)
% cropSignaturesFromScans('Willy', 'Fake', 'Willy', 1, 2)

% This will set the blackness cutoff for images starting with the provided string to 100:
% saveVaryingHardnessImages('Real_Will',1,100, 100)
% saveVaryingHardnessImages('Fake_Fred',1,20, 100)
% saveVaryingHardnessImages('Fake_Min',1,20, 100)
% saveVaryingHardnessImages('Fake_Willy',1,20, 100)

% This will set the blackness cutoff for images starting with the provided string to 120:
% saveVaryingHardnessImages('Real_Will',1,100, 120)
% saveVaryingHardnessImages('Fake_Fred',1,20, 120)
% saveVaryingHardnessImages('Fake_Min',1,20, 120)
% saveVaryingHardnessImages('Fake_Willy',1,20, 120)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% PICK ONE OF THE FOLLOWING:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Obtains the filenames of all signatures with cutoff = BLACKNESS
sfn=getSignatureFilenames({'Real' 'Fake' 'Fake' 'Fake'}, {'Will' 'Fred' 'Min' 'Willy'}, [1 1 1 1], [100 20 20 20], BLACKNESS);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Replace getPerceptualHash with any function from folder Hashes
% hash_and_classification_table=createHashAndClassificationTable(@getPerceptualHash,sfn);
  hash_and_classification_table=createHashAndClassificationTable(@getPHash,sfn);


all_percent_corrects = zeros(1,nTrials);
all_class_matrices = cell(1,nTrials);
for i = 1:nTrials
    % Do randperm to generate the test and training sets.
    % This will take 20 samples with label 'Real' and 20 samples with label
    % 'Fake' and place them in training_set
    % It will also take 10 samples with label 'Real' and 10 samples with label
    % 'Fake and place them in the testing_set
    [training_set, testing_set] = getTrainAndTestSet(hash_and_classification_table, {'Real', 'Fake'}, [20 20], [10 10]);
    
    % Then run the learning algorithm
    % (for svm 1 = use best so far, 0 =  find and use a new model)
         labeled_instances = kNN(training_set, testing_set, @getHammingDistance);
    %    labeled_instances = kNN3(training_set, testing_set, @getHammingDistance);
    %    labeled_instances = kNN3(training_set, testing_set, @getEuclideanDistance);
    %    labeled_instances = centroidMin(training_set, testing_set, @getEuclideanDistance, {'Real', 'Fake'})
    %    labeled_instances = centroidMin(training_set, testing_set, @getL1NormDistance, {'Real', 'Fake'});
    %    labeled_instances = centroidMin(training_set, testing_set,
    %    @getL3NormDistance, {'Real', 'Fake'});
    %    labeled_instances = hard_linear_svm(training_set, testing_set, 1);
    
    % Get stats on labeled_instances
    [class_matrix, percentCorrect] = getClassificationStats(labeled_instances, {'Real', 'Fake'});
    all_class_matrices{i} = class_matrix;
    all_percent_corrects(i) = percentCorrect;
end

% Print the accuracy result to the console
fprintf('  Trial   Pred Rate\n')
fprintf('-------------------\n')
for i = 1:nTrials
    fprintf(' %4d  |  %6.3f\n', i, all_percent_corrects(i));
end
average_prediction_rate = mean(all_percent_corrects);
fprintf('The average prediction rate over %d trials was %.4f\n', nTrials, average_prediction_rate);








