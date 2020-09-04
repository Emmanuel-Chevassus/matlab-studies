clear
clc
close all
%------------------------------------------------------------------------------------------------
% algo T(i,k+1)=(T(i+1,k)+T(i-1,k))/2.0
%------------------------------------------------------------------------------------------------
disp('algo 1')
a_cuivre=114*10^-6
[teq_cuivre,T_cuivre,temps_cuivre]=conduction1(a_cuivre);
teq_cuivre
a_verre=0.58*10^-6
[teq_verre,T_verre,temps_verre]=conduction1(a_verre);
teq_verre
if teq_cuivre>teq_verre
    disp('la barre en verre a atteint plus vite l''�quilibre que la barre en cuivre')
elseif teq_cuivre==teq_verre
    disp('les barres en verre et en cuivre ont mis autant de temps � atteindre l''�quilibre')
else disp('la barre en cuivre a atteint l''�quilibre plus vite que la barre en verre')
end

figure(1) % comparaison de la temp�rature finale des deux barres
nb_temps_cuivre=length(temps_cuivre)
nb_temps_verre=length(temps_verre)
plot([0:0.01:1],T_cuivre(nb_temps_cuivre,:),'*r',[0:0.01:1],T_verre(nb_temps_verre,:),'-b')
xlabel('longueur de la barre en m')
ylabel('temp�rature de la barre en �C')
title('temp�ratures d''�quilibre d''une barre de 1m')
legend('barre en cuivre','barre en verre')
%temp�rature d'�quilibre de la barre identique quelque soit le mat�riau : normal

figure(2) % �volution temporelle de la temp�rature au milieu de la tige
h_cuivre=temps_cuivre/(60*60);
h_verre=temps_verre/(60*60);
plot(h_cuivre,T_cuivre(:,50),'-r',h_verre,T_verre(:,50),'-b')
xlabel('temps �coul� en heures')
ylabel('temp�rature de la barre en �C')
title('Evolution temporelle de la temp�rature du milieu d''une barre de 1m')
legend('barre en cuivre','barre en verre')

figure(3) % �volution temporelle de la temp�rature de la tige en cuivre
pcolor([0:0.01:1],h_cuivre,T_cuivre)
shading flat
xlabel('longueur de la barre en m')
ylabel('temps �coul� en heures')
title('Evolution temporelle de la temp�rature d''une barre de cuivre de 1m')
colormap(jet)
c=colorbar;
c.Label.String = 'Temp�rature en �C';

figure(4) % �volution temporelle de la temp�rature de la tige en verre
pcolor([0:0.01:1],h_verre,T_verre)
shading flat
xlabel('longueur de la barre en m')
ylabel('temps �coul� en heures')
title('Evolution temporelle de la temp�rature d''une barre de verre de 1m')
colormap(jet)
c=colorbar;
c.Label.String = 'Temp�rature en �C';