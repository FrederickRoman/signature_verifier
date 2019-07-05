function euclidean_distance = getEuclideanDistance(hash1, hash2)
%GETEUCLIDEANDISTANCE Summary of this function goes here
%   Detailed explanation goes here

% euclidean_distance = sum((hash1-hash2).^2);
euclidean_distance = sqrt(sum((hash1-hash2).^2));

end

