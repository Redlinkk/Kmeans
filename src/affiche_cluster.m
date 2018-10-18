function [] = affiche_cluster(Mrd, A, C)

% Affichage coloré des clusters et de leur centre

figure
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
Z7 = Mrd(:,A==7);
plot(Z7(1,:),Z7(2,:),'y.');
plot(C(1,:),C(2,:),'m.','MarkerSize',20);
axis([-10 8 -8 6]);