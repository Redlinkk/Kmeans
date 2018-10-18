function c = calcul_centre(E)

% Calcul le centre de gravité de E

T = size(E);
n = T(2);
p = T(1);

c = zeros(2,1);

for i = 1:2
    s = 0;
    for j = 1:n
        s = s + E(i,j);
    end
    c(i,1) = s / n;
end
