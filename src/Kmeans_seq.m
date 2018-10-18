clc;clear;close all;

% Initialisation des données (random)

M = csvread('villes_france_epurees.csv').';

T = size(M);
n = T(2);
p = T(1);
A = zeros(1,n);


rd = randperm(n);
Mrd = zeros(p,n);
for i = 1:n
    Mrd(:,i) = M(:,rd(i));
end



% Initialisation des centres
K = 10;
C = zeros(p,K); % liste des centres
for i = 1:K
    C(:,i) = Mrd(:,i); 
end


% Initialisation du poids des clusters
P = zeros(1,K);

% Ajout progressif des données

%plot(0,0); hold on
%axis([-10 10 -10 10]);

for i = 1:n
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
    C(:,minj) = C(:,minj) + (Mrd(:,i)-C(:,minj))/P(1,minj);
    A(1,i) = mod(minj,7);
end

%plot(Mrd(1,:),Mrd(2,:),'r.'); hold on
plot(C(1,:),C(2,:),'k.','MarkerSize',20); hold on


Z1 = Mrd(:,A==1);
plot(Z1(1,:),Z1(2,:),'r.');hold on
Z2 = Mrd(:,A==2);
plot(Z2(1,:),Z2(2,:),'g.');
Z3 = Mrd(:,A==3);
plot(Z3(1,:),Z3(2,:),'b.');
Z4 = Mrd(:,A==4);
plot(Z4(1,:),Z4(2,:),'k.');
Z5 = Mrd(:,A==5);
plot(Z5(1,:),Z5(2,:),'c.');
Z6 = Mrd(:,A==6);
plot(Z6(1,:),Z6(2,:),'m.');
Z7 = Mrd(:,A==0);
plot(Z7(1,:),Z7(2,:),'y.');
