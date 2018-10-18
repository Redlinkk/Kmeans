clc;clear;close all;

%%% Initialisation des données (random)

% Ici on génère des nuages de points grâce à une loi normale autour des
% points : (3,2); (4,-5); (-7,2); (-2,-2)
a = [randn(300,1)+3,randn(300,1)+2]; 
b = [randn(500,1)+4,randn(500,1)-5];
c = [randn(700,1)-7,randn(700,1)+2];
d = [randn(150,1)-2,randn(150,1)-2];
M = [a;b;c;d].';



T = size(M);
n = T(2);
p = T(1);

% On applique une permutation aléatoire sur la matrice pour éviter que la
% matrice des données soit pseudo-triée
rd = randperm(n);
Mrd = zeros(p,n);
for i = 1:n
    Mrd(:,i) = M(:,rd(i));
end


%%% Initialisation des centres
K = 4;
C = zeros(p,K); % liste des centres
for i = 1:K
    C(:,i) = Mrd(:,i);      % on initialise les centres avec les K premiers points
end



%%% Initialisation du poids des clusters
P = zeros(1,K);     % P contient le poids des classes, ie le nombre de points
A = zeros(1,n);     % la matrice A servira à servir dans quelle classe sont les points de Mrd


%%% Ajout progressif des données

for i = 1:n         % Boucle principale
    minj = 1;
    min = dist_eucl(Mrd(:,i),C(:,1));
    for j = 2:K                        % boucle pour rechercher le centre le plus proche
        d = dist_eucl(Mrd(:,i),C(:,j));
        if d < min
            min = d;
            minj = j;
        end
    end
    P(1,minj) = P(1,minj) + 1;          % on augmente le poids du cluster
    C(:,minj) = C(:,minj) + (Mrd(:,i)-C(:,minj))/P(1,minj);     % on modifie le centre de la classe
    A(1,i) = mod(minj,8);               % On indique dans quelle classe se trouve le point Mrd(i)
    %{
    % Fonction de correction
    if  (i == 250 && K < 15) || (i == K*K && K >= 15)
        affiche_cluster(Mrd, A, C);        
        [C, P, A, Mrd] = correction_init(C, A, Mrd);
        affiche_cluster(Mrd, A, C);
    end
    %}
end

affiche_cluster(Mrd, A, C);