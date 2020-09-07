% Question 3

clear
close all

% chargement matrice ecmwf
load Petite_Matrice_ECMWF

indice_lat_CF=27; %=45.75°N
indice_lon_CF=32; %=3°E
 
for i=1:length(level);
    for j=1:length(temps);
u2(j,i)=u(indice_lon_CF,indice_lat_CF,i,j);
v2(j,i)=v(indice_lon_CF,indice_lat_CF,i,j);
r2(j,i)=r(indice_lon_CF,indice_lat_CF,i,j);
o32(j,i)=o3(indice_lon_CF,indice_lat_CF,i,j);
    end
end

mod=u2.^2+v2.^2;
mod=mod.^.5;

jours=26:0.25:31.75;


figure
pcolor(jours,level,mod')
shading interp
caxis([0 70])
colorbar
hold on
axis([26 31.75 100 700])
set(gca,'xtick',[26 27 28 29 30 31])
set(gca,'ydir','reverse','yscale','log','ytick',[100 200 300 400 500 600 700 800])
title(['Vent Horizontal (m/s)'])
xlabel('Janvier 2013')
ylabel('Pression (hPa)')

figure
pcolor(jours,level,r2')
shading interp
caxis([0 100])
colorbar
hold on
axis([26 31.75 100 700])
set(gca,'xtick',[26 27 28 29 30 31])
set(gca,'ydir','reverse','yscale','log','ytick',[100 200 300 400 500 600 700 800])
title(['Humidité Relative (%)'])
xlabel('Janvier 2013')
ylabel('Pression (hPa)')

figure
pcolor(jours,level,o32')
shading interp
caxis([0 1E-6])
colorbar
hold on
axis([26 31.75 100 700])
set(gca,'xtick',[26 27 28 29 30 31])
set(gca,'ydir','reverse','yscale','log','ytick',[100 200 300 400 500 600 700 800])
title(['Ozone (kg/kg)'])
xlabel('Janvier 2013')
ylabel('Pression (hPa)')
