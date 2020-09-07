% Question 5

clear
%close all
load Matrice_lidar.mat

WV_lidar_moyen=mean(WV_lidar,2); 

figure
semilogx(WV_lidar(20:4429,13),z_lidar(20:4429),'k-','linewidth',4)
hold on
semilogx(WV_lidar_moyen(20:4429),z_lidar(20:4429),'b:','linewidth',4)
legend('29 Janvier 2013','Profil moyen Janvier 2013')
axis([0.1 10 1 9])
set(gca,'xtick',[0.1 0.5 1 2 3 4 5 6 7 8 9 10]);
xlabel('Mixing ratio H2O (g/kg)');
ylabel('Altitude (km)');

