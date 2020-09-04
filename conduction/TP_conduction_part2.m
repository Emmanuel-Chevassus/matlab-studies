clear
clc
close all
%------------------------------------------------------------------------------------------------
% algo T(i,k+1)=a*deltat*(T(i+1,k)-2T(i,k)+T(i-1,k))/(deltax^2)+T(i,k)
%------------------------------------------------------------------------------------------------
disp('algo 2')
a_cuivre=114*10^-6
a_verre=0.58*10^-6
delta_t=0.3;
[teq_cuivre2,T_cuivre2,temps_cuivre2,succes_cu]=conduction2(a_cuivre,delta_t);
[teq_verre2,T_verre2,temps_verre2,succes_ve]=conduction2(a_verre,delta_t);
if (succes_ve==1)&&(succes_cu==1)
  if teq_cuivre2>teq_verre2
      disp('la barre en verre a atteint plus vite l''�quilibre que la barre en cuivre')
  elseif teq_cuivre2==teq_verre2
      disp('les barres en verre et en cuivre ont mis autant de temps � atteindre l''�quilibre')
  else disp('la barre en cuivre a atteint l''�quilibre plus vite que la barre en verre')
  end
else 
    disp('equilibre non atteint pour un des mat�riaux')
end

figure(5) % comparaison de la temp�rature finale des deux barres
nb_temps_cuivre2=length(temps_cuivre2);
nb_temps_verre2=length(temps_verre2);
plot([0:0.01:1],T_cuivre2(nb_temps_cuivre2,:),'*r',[0:0.01:1],T_verre2(nb_temps_verre2,:),'-b')
xlabel('longueur de la barre en m')
ylabel('temp�rature de la barre en �C')
title('temp�ratures d''�quilibre d''une barre de 1m - dt=0.3s')
legend('barre en cuivre','barre en verre')
saveas(gcf,'Figure5.png')
%temp�rature d'�quilibre de la barre identique quelque soit le mat�riau : normal

figure(6) % �volution temporelle de la temp�rature au milieu de la tige
h_cuivre2=temps_cuivre2/(60*60);
h_verre2=temps_verre2/(60*60);
plot(h_cuivre2,T_cuivre2(:,50),'-r',h_verre2,T_verre2(:,50),'-b')
xlabel('temps �coul� en heures')
ylabel('temp�rature de la barre en �C')
title('Evolution temporelle de la temp�rature du milieu d''une barre de 1m - dt=0.3s')
legend('barre en cuivre','barre en verre')
saveas(gcf,'Figure6.png')

figure(7) % �volution temporelle de la temp�rature de la tige en cuivre
pcolor([0:0.01:1],h_cuivre2,T_cuivre2)
shading flat
xlabel('longueur de la barre en m')
ylabel('temps �coul� en heures')
title('Evolution temporelle de la temp�rature d''une barre de cuivre de 1m - dt=0.3s')
colormap(jet)
c=colorbar;
c.Label.String = 'Temp�rature en �C';
saveas(gcf,'Figure7.png')

figure(8) % �volution temporelle de la temp�rature de la tige en verre
pcolor([0:0.01:1],h_verre2,T_verre2)
shading flat
xlabel('longueur de la barre en m')
ylabel('temps �coul� en heures')
title('Evolution temporelle de la temp�rature d''une barre de verre de 1m - dt=0.3s')
colormap(jet)
c=colorbar;
c.Label.String = 'Temp�rature en �C';
saveas(gcf,'Figure8.png')

delta_t=5;
[teq_cuivre2,T_cuivre2,temps_cuivre2,succes_cu]=conduction2(a_cuivre,delta_t);
[teq_verre2,T_verre2,temps_verre2,succes_ve]=conduction2(a_verre,delta_t);
if (succes_ve==1)&&(succes_cu==1)
  if teq_cuivre2>teq_verre2
      disp('la barre en verre a atteint plus vite l''�quilibre que la barre en cuivre')
  elseif teq_cuivre2==teq_verre2
      disp('les barres en verre et en cuivre ont mis autant de temps � atteindre l''�quilibre')
  else disp('la barre en cuivre a atteint l''�quilibre plus vite que la barre en verre')
  end
else 
    disp('equilibre non atteint pour un des mat�riaux')
end

figure(9) % comparaison de la temp�rature finale des deux barres
nb_temps_cuivre2=length(temps_cuivre2);
nb_temps_verre2=length(temps_verre2);
plot([0:0.01:1],T_cuivre2(nb_temps_cuivre2,:),'*r',[0:0.01:1],T_verre2(nb_temps_verre2,:),'-b')
xlabel('longueur de la barre en m')
ylabel('temp�rature de la barre en �C')
title('temp�ratures d''�quilibre d''une barre de 1m - dt=5s')
legend('barre en cuivre','barre en verre')
saveas(gcf,'Figure9.png')

figure(10) % �volution temporelle de la temp�rature au milieu de la tige
h_cuivre2=temps_cuivre2/(60*60);
h_verre2=temps_verre2/(60*60);
plot(h_cuivre2,T_cuivre2(:,50),'-r',h_verre2,T_verre2(:,50),'-b')
xlabel('temps �coul� en heures')
ylabel('temp�rature de la barre en �C')
title('Evolution temporelle de la temp�rature du milieu d''une barre de 1m - dt=5s')
legend('barre en cuivre','barre en verre')
saveas(gcf,'Figure10.png')

figure(11) % �volution temporelle de la temp�rature de la tige en cuivre
pcolor([0:0.01:1],h_cuivre2,T_cuivre2)
shading flat
xlabel('longueur de la barre en m')
ylabel('temps �coul� en heures')
title('Evolution temporelle de la temp�rature d''une barre de cuivre de 1m - dt=5s')
colormap(jet)
c=colorbar;
c.Label.String = 'Temp�rature en �C';
saveas(gcf,'Figure11.png')

figure(12) % �volution temporelle de la temp�rature de la tige en verre
pcolor([0:0.01:1],h_verre2,T_verre2)
shading flat
xlabel('longueur de la barre en m')
ylabel('temps �coul� en heures')
title('Evolution temporelle de la temp�rature d''une barre de verre de 1m - dt=5s')
colormap(jet)
c=colorbar;
c.Label.String = 'Temp�rature en �C';
saveas(gcf,'Figure12.png')