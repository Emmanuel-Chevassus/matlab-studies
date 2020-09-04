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
    disp('la barre en verre a atteint plus vite l''équilibre que la barre en cuivre')
elseif teq_cuivre==teq_verre
    disp('les barres en verre et en cuivre ont mis autant de temps à atteindre l''équilibre')
else disp('la barre en cuivre a atteint l''équilibre plus vite que la barre en verre')
end

figure(1) % comparaison de la température finale des deux barres
nb_temps_cuivre=length(temps_cuivre)
nb_temps_verre=length(temps_verre)
plot([0:0.01:1],T_cuivre(nb_temps_cuivre,:),'*r',[0:0.01:1],T_verre(nb_temps_verre,:),'-b')
xlabel('longueur de la barre en m')
ylabel('température de la barre en °C')
title('températures d''équilibre d''une barre de 1m')
legend('barre en cuivre','barre en verre')
%température d'équilibre de la barre identique quelque soit le matériau : normal

figure(2) % évolution temporelle de la température au milieu de la tige
h_cuivre=temps_cuivre/(60*60);
h_verre=temps_verre/(60*60);
plot(h_cuivre,T_cuivre(:,50),'-r',h_verre,T_verre(:,50),'-b')
xlabel('temps écoulé en heures')
ylabel('température de la barre en °C')
title('Evolution temporelle de la température du milieu d''une barre de 1m')
legend('barre en cuivre','barre en verre')

figure(3) % évolution temporelle de la température de la tige en cuivre
pcolor([0:0.01:1],h_cuivre,T_cuivre)
shading flat
xlabel('longueur de la barre en m')
ylabel('temps écoulé en heures')
title('Evolution temporelle de la température d''une barre de cuivre de 1m')
colormap(jet)
c=colorbar;
c.Label.String = 'Température en °C';

figure(4) % évolution temporelle de la température de la tige en verre
pcolor([0:0.01:1],h_verre,T_verre)
shading flat
xlabel('longueur de la barre en m')
ylabel('temps écoulé en heures')
title('Evolution temporelle de la température d''une barre de verre de 1m')
colormap(jet)
c=colorbar;
c.Label.String = 'Température en °C';