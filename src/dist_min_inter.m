function d = dist_min_inter(C,i)

% Calcul la distance minimale du centre du cluster i à tout autre centre

T = size(C);
n = T(2);

if i ~= n
    min = dist_eucl(C(:,i),C(:,i+1));
else
    min = dist_eucl(C(:,i),C(:,1));
end

for j = 1:n
    if i ~= j
        if dist_eucl(C(:,i),C(:,j)) < min
            min = dist_eucl(C(:,i),C(:,j));
        end
    end
end

d = min;