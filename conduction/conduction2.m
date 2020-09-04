function [teq,T,temps,succes]=conduction2(a,delta_t)
% calcule l'�volution de la temp�rature au sein d'une barre en 1D � l'aide
%   de l'�quation de la conduction thermique et de l'algo T(i,k+1)=a*deltat*(T(i+1,k)-2T(i,k)+T(i-1,k))/(deltax^2)+T(i,k)
% input :
%   a : diffusivit� thermique en m2/s du mat�riau constituant la barre
%   delta_t : pas de temps d'int�gration en secondes
% output :
%   teq : temps mis pour atteindre l'�quilibre
%   T : temp�rature de la barre au cours du temps (colonne = abscisse de la
%       barre, lignes = pas de temps)
%   temps : dur�es depuis l'instant initiale jusqu'� l'�quilibre
L=1; %longueur de la barre en m�tres
nb_tranches=100;
T=zeros(1,nb_tranches+1)+20.; %temp�rature initiale de la barre
compteur=1; %compte le pas de temps jusqu'� l'�quilibre
nb=200000; % nombre maximal de pas de temps calcul� si jamais l'�quilibre n'est pas atteint
tfin=60; %temps de chauffe final en secondes
temps(1)=0; % temps �coul� en secondes
eps=10^-6; % seuil d'�quilibre
test=10*eps;
delta_x=L/nb_tranches; %pas de discr�tisation horizontal en m�tres
succes=1; %test si l'�quilibre est atteint
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
        T(compteur,i)=(a*delta_t*(T(compteur-1,i+1)-2*T(compteur-1,i)+T(compteur-1,i-1))/(delta_x^2))+T(compteur-1,i);
    end 
    test=max(abs(T(compteur,:)-T(compteur-1,:)));       
end
teq=temps(compteur); %temps mis pour converger vers la solution
if compteur==nb
    disp('�quilibre non atteint')
    succes=0
end
end