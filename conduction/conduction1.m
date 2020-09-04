function [teq,T,temps]=conduction1(a)
% calcule l'�volution de la temp�rature au sein d'une barre en 1D � l'aide
%   de l'�quation de la conduction thermique via l'algo T(i,k+1)=(T(i+1,k)+T(i-1,k))/2.0
% input :
%   a : diffusivit� thermique en m2/s du mat�riau constituant la barre
% output :
%   teq : temps mis pour atteindre l'�quilibre
%   T : temp�rature de la barre au cours du temps (colonne = abscisse de la
%       barre, lignes = pas de temps)
%   temps : dur�es depuis l'instant initiale jusqu'� l'�quilibre
L=1; %longueur de la barre en m�tres
nb_tranches=100;
T=zeros(1,nb_tranches+1)+20.; %temp�rature initiale de la barre
compteur=1; %compte le pas de temps jusqu'� l'�quilibre
nb=20000; % nombre maximal de pas de temps calcul� si jamais l'�quilibre n'est pas atteint
tfin=60; %temps de chauffe final en secondes
temps(1)=0; % temps �coul� en secondes
eps=10^-5; % seuil d'�quilibre
test=10*eps;
delta_x=L/nb_tranches; %pas de discr�tisation horizontal en m�tres
delta_t=(delta_x)^2/(2*a) % pas d'int�gration en secondes 
while (test > eps)&&(compteur <nb) %% compteur < nb : si jamais l'�quilibre n'est pas atteint, on arr�te au bout de nb pas de temps 
    compteur=compteur+1;
    temps(compteur)=temps(compteur-1)+delta_t;
    % d�termination de la temp�rature de la face gauche :
    if temps(compteur) <= tfin
        T(compteur,1)=T(1,1)+0.1*temps(compteur);
    else
        T(compteur,1)=T(1,1)+0.1*tfin;
    end
    T(compteur,nb_tranches+1)=20.;
    % d�termination de la temp�ratue le long de la barre � chaque pas de temps :    
    for i=2:1:nb_tranches
        T(compteur,i)=(T(compteur-1,i+1)+T(compteur-1,i-1))/2;
    end 
    test=max(abs(T(compteur,:)-T(compteur-1,:)));       
end
teq=temps(compteur); %temps mis pour converger vers la solution
end