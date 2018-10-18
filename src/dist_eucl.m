function [d] = dist_eucl(x,y)

% Calcule la distance euclidienne entre 2 points

N = size(x);
m = N(1);

s = 0;
for i = 1:m
    s = s + (x(i) - y(i)) * (x(i) - y(i));
end

d = sqrt(s);
