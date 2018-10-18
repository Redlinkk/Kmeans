function [d] = dist_moy_intra(E, c)

N = size(E);
p = N(1);
n = N(2);

s = 0;
for i = 1:n
    s = s + dist_eucl(E(:,i), c);
end

d = s / n;
