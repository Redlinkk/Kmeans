function [S] = covariance(D)

N = size(D);
p = N(1);
n = N(2);

S = [0,0];
for i = 1:n
    S = S + D(:,i);
end

Ex = S / n;

Mcov = zeros(p,p);
for i = 1:n
    Mcov = Mcov + (D(:,i) - Ex)*((D(:,i) - Ex).');
end

S = Mcov / n;
