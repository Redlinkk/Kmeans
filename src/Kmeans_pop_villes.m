clc;clear;close all;

%%% Initialisation des données

Ma = csvread('pop_villes.csv').';

M = Ma(1,:);
Mab = [Ma(2,:);Ma(3,:)];

T = size(M);
n = T(2);
p = T(1);


rd = randperm(n);
Mrd = zeros(p,n);
Mrda = zeros(2,n);
for i = 1:n
    Mrd(:,i) = M(:,rd(i));
    Mrda(:,i) = Mab(:,rd(i));
end



%%% Initialisation des centres
K = 4;
C = zeros(p,K); 
for i = 1:K
    C(:,i) = Mrd(:,i); 
end


%%% Initialisation du poids des clusters
P = zeros(1,K);
A = zeros(1,n);


%%% Ajout progressif des données

for i = 1:n
    minj = 1;
    min = dist_eucl(Mrd(:,i),C(:,1));
    for j = 2:K                        
        d = dist_eucl(Mrd(:,i),C(:,j));
        if d < min
            min = d;
            minj = j;
        end
    end
    P(1,minj) = P(1,minj) + 1;          
    C(:,minj) = C(:,minj) + (Mrd(:,i)-C(:,minj))/P(1,minj);
    A(1,i) = mod(minj,7);
end


affiche_cluster(Mrda, A, C);
