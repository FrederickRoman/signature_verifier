function L3_distance= getL3NormDistance(hash1, hash2)
%GETL1NORM Gets the L1 norm distance between hash1 and hash2

L3_distance = norm((hash1-hash2),3);

end
