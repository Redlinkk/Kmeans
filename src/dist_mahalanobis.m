function [d] = dist_mahalanobis(x, c, D)

S = covariance(D);
S1 = inv(S);
d = sqrt( (x-c).' * S1 * (x-c) );
