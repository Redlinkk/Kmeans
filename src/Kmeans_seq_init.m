clc;clear;close all;

% Initialisation des données (random)

% Ici on génère des nuages de points grâce à une loi normale autour des
% points : (3,2); (4,-5); (-7,2); (-2,-2)
a = [randn(300,1)+3,randn(300,1)+2]; 
b = [randn(500,1)+4,randn(500,1)-5];
c = [randn(700,1)-7,randn(700,1)+2];
d = [randn(150,1)-2,randn(150,1)-2];
M = [a;b;c;d].';


%M = csvread('villes_france_epurees.csv').';

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
K = 4;
C = zeros(p,K); % liste des centres
for i = 1:K
    C(:,i) = Mrd(:,i);
end

%{
C(:,1) = [5,5];
C(:,2) = [-5,-5];
C(:,3) = [0,0];
C(:,4) = [5,-5];
C(:,5) = [-5,5];
%}

% Initialisation du poids des clusters
P = zeros(1,K);

% Ajout progressif des données

%plot(0,0); hold on
%axis([-10 10 -10 10]);

%Initialisation avec Kmean dynamique
if K<23
    L=500; %Nombre de points pris pour l'initialisation
else
    L= K^2;
end

Deb =  zeros(p,L); %Initialisation nouvelle matrice pour kmean dynamique

for i = 1:L
    Deb(:,i)=Mrd(:,i); %on récupère les L premières coordonnées de Mrd
end

% Affectation des L premières valeurs pour le kmean dynamique
B = zeros(1,L); %B contient à l'indice i le numéro du cluster associé au point i
for i =1:K
    B(1,i)=i; %Initialisation des K clusters
end

% for i = K+1:L
%     minj = 1;
%     min = dist_eucl(Deb(:,i),C(:,1));
%     for j = 2:K                        % Boucle pour rechercher le centre le plus proche
%         d = dist_eucl(Deb(:,i),C(:,j));
%         if d < min
%             min = d;
%             minj = j;
%         end
%     end
% %     B(1,i)=minj;
% end

% test

Valide=1;
Test = zeros(1,L);
z=0; % Compteur pour noombre maximum d'itérations
while Valide==1 && z<1000
    for k = 0:K-1       % Boucle de calcul des nouveaux centres 
       Trouve=find(B==k+1);
       M1=Deb';
       C(:,k+1) = mean(M1(Trouve,:)); 
    end
    for i = 1:L
        minj = 1;
        min = dist_eucl(Deb(:,i),C(:,1));
        for j = 2:K                        % Boucle pour rechercher le centre le plus proche
            d = dist_eucl(Deb(:,i),C(:,j));
            if d < min
                min = d;
                minj = j;
            end
        end
        B(1,i)= mod(minj,7);
    end
    if B==Test  %Permet de déterminer si le Kmean dynamique converge vers une solution stable
        test=0;
    end
    Test=B;
    z=z+1;
end

% Fin initialisation Kmean dynamique

for i=1:L
    A(1,i)=B(1,i); %Les L premières valeurs de A sont égales à l'ensemble B
end
% % affichage des clusters par couleur 
% 
% Z1 = Deb(:,B==1);
% plot(Z1(1,:),Z1(2,:),'r.');hold on
% Z2 = Deb(:,B==2);
% plot(Z2(1,:),Z2(2,:),'g.');
% Z3 = Deb(:,B==3);
% plot(Z3(1,:),Z3(2,:),'.');
% Z4 = Deb(:,B==4);
% plot(Z4(1,:),Z4(2,:),'k.');
% Z5 = Deb(:,B==0);
% plot(Z5(1,:),Z5(2,:),'c.');

for i = L:n   %Début Kmean séquentiel
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

% Distance Mahalanobis : 
%{
for i = 1001:n
    minj = 1;
    min = dist_mahalanobis(Mrd(:,i),C(:,1),Mrd(:,A==1));
    for j = 2:K                        % boucle pour rechercher le centre le plus proche
        d = dist_mahalanobis(Mrd(:,i),C(:,j),Mrd(:,A==j));
        if d < min
            min = d;
            minj = j;
        end
    end
    P(1,minj) = P(1,minj) + 1;          % on augmente le poids du cluster
    C(:,minj) = C(:,minj) + (Mrd(:,i)-C(:,minj))/P(1,minj);
    A(1,i) = minj;
    
    %{
    if minj == 1
        plot(Mrd(1,i), Mrd(2, i),'r.');hold on
    elseif minj == 2
        plot(Mrd(1,i), Mrd(2, i),'g.');hold on
    elseif minj == 3
        plot(Mrd(1,i), Mrd(2, i),'b.');hold on
    elseif minj == 4
        plot(Mrd(1,i), Mrd(2, i),'k.');hold on
    else
        plot(Mrd(1,i), Mrd(2, i),'c.');hold on
    end
    pause
    %}
end
%}

% plot(Mrd(1,:),Mrd(2,:),'r.'); hold on


% Color = ['r.','g.','b.','m.','k.','c.','y.']
% for i=1:K
%     Z= Mrd(:,A==i);
%     plot(Z(1,:),Z(2,:),Color(randi(7))); hold on
% end
Z1 = Mrd(:,A==1);
plot(Z1(1,:),Z1(2,:),'r.'); hold on
Z2 = Mrd(:,A==2);
plot(Z2(1,:),Z2(2,:),'g.');
Z3 = Mrd(:,A==3);
plot(Z3(1,:),Z3(2,:),'b.');
Z4 = Mrd(:,A==4);
plot(Z4(1,:),Z4(2,:),'k.');
Z5 = Mrd(:,A==5);
plot(Z5(1,:),Z5(2,:),'c.');
% Z6 = Mrd(:,A==6);
% plot(Z6(1,:),Z6(2,:),'m.');
% Z7 = Mrd(:,A==0);
% plot(Z7(1,:),Z7(2,:),'y.');
plot(C(1,:),C(2,:),'m.','MarkerSize',30);