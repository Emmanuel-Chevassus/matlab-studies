% Question 4

clear
close all

load Matrice_VHF

module=sqrt(U_VHF.*U_VHF+V_VHF.*V_VHF);
z=z_VHF/1000; % m -> km

debut_periode=601; % 26 janvier 2013
fin_periode=744; % 31 janvier 2013

module_periode=module(1:40,debut_periode:fin_periode);

for i=debut_periode:fin_periode;
temps(i-debut_periode+1)=jour_VHF(i)+(heure_VHF(i)/24);
end

figure
pcolor(temps,z,module_periode)
shading flat
caxis([0 70])
axis([26 31.75 2 15])
colorbar
set(gca,'ytick',[4 6 8 10 12 14])
set(gca,'xtick',[26 27 28 29 30 31])
title('Vent Horiz. Radar VHF (m/s)')
xlabel('Janvier 2013')
ylabel('Altitude (km)')
