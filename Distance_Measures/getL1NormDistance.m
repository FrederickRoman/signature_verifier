function L1_distance= getL1NormDistance(hash1, hash2)
%GETL1NORM Gets the L1 norm distance between hash1 and hash2

L1_distance = sum((hash1-hash2));

end

