function hamming_distance = getHammingDistance(hash1, hash2)
%getHammingDistance gets the hamming distance between 2 hashes.

hamming_distance = sum(hash1~=hash2);



end

