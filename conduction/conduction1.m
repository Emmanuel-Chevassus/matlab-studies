function [teq,T,temps]=conduction1(a)
% calcule l'évolution de la température au sein d'une barre en 1D à l'aide
%   de l'équation de la conduction thermique via l'algo T(i,k+1)=(T(i+1,k)+T(i-1,k))/2.0
% input :
%   a : diffusivité thermique en m2/s du matériau constituant la barre
% output :
%   teq : temps mis pour atteindre l'équilibre
%   T : température de la barre au cours du temps (colonne = abscisse de la
%       barre, lignes = pas de temps)
%   temps : durées depuis l'instant initiale jusqu'à l'équilibre
L=1; %longueur de la barre en mètres
nb_tranches=100;
T=zeros(1,nb_tranches+1)+20.; %température initiale de la barre
compteur=1; %compte le pas de temps jusqu'à l'équilibre
nb=20000; % nombre maximal de pas de temps calculé si jamais l'équilibre n'est pas atteint
tfin=60; %temps de chauffe final en secondes
temps(1)=0; % temps écoulé en secondes
eps=10^-5; % seuil d'équilibre
test=10*eps;
delta_x=L/nb_tranches; %pas de discrétisation horizontal en mètres
delta_t=(delta_x)^2/(2*a) % pas d'intégration en secondes 
while (test > eps)&&(compteur <nb) %% compteur < nb : si jamais l'équilibre n'est pas atteint, on arrête au bout de nb pas de temps 
    compteur=compteur+1;
    temps(compteur)=temps(compteur-1)+delta_t;
    % détermination de la température de la face gauche :
    if temps(compteur) <= tfin
        T(compteur,1)=T(1,1)+0.1*temps(compteur);
    else
        T(compteur,1)=T(1,1)+0.1*tfin;
    end
    T(compteur,nb_tranches+1)=20.;
    % détermination de la températue le long de la barre à chaque pas de temps :    
    for i=2:1:nb_tranches
        T(compteur,i)=(T(compteur-1,i+1)+T(compteur-1,i-1))/2;
    end 
    test=max(abs(T(compteur,:)-T(compteur-1,:)));       
end
teq=temps(compteur); %temps mis pour converger vers la solution
end