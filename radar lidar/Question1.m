% Question 1
clear
close all

% chargement matrice ecmwf
load Petite_Matrice_ECMWF

% chargement fond de carte
load fond180.mat

% choix indice altitude et date
choix_altitude=18; % 300 hPa
choix_date=10; % 28 Jan 2013 6UT

%1ère variable longitude 2ème variable latitude 3ème variable level (hPa) 4ème variable temps (pas de 6H)
% On met les parametres dans des matrices en 2 dimensions (lon,lat)
for i=1:size(u,1);
    for j=1:size(u,2);
u2(i,j)=u(i,j,choix_altitude,choix_date);
v2(i,j)=v(i,j,choix_altitude,choix_date);
w2(i,j)=w(i,j,choix_altitude,choix_date);
r2(i,j)=r(i,j,choix_altitude,choix_date);
o32(i,j)=o3(i,j,choix_altitude,choix_date);
    end
end

% calcul du module du vent
mod=u2.^2+v2.^2;
mod=mod.^.5;

% petite matrices u et v pour les fleches
diviseur=3
u2p=u2(1:diviseur:55,1:diviseur:42);
v2p=v2(1:diviseur:55,1:diviseur:42);
latitudep=latitude(1:diviseur:42);
longitudep=longitude(1:diviseur:55);

% figure vent
figure
pcolor(longitude,latitude,mod') % trace module du vent
axis([-20 20 35 65])
shading flat
colorbar
hold on
plot(tmp(:,1),tmp(:,2),'k','linewidth',2) % trace fond de carte
hold on
quiver(longitudep,latitudep,u2p',v2p','k') % trace fleches direction du vent
titre=[date(choix_date,1:17),' / ' num2str(level(choix_altitude)) ' hPa / Vent Horiz. (m/s)'];
title(titre)
xlabel('Longitude')
ylabel('Latitude')

% figure humidité relative
figure
pcolor(longitude,latitude,r2')
axis([-20 20 35 65])
shading interp
colorbar
hold on
plot(tmp(:,1),tmp(:,2),'k','linewidth',2)
titre=[date(choix_date,1:17),' / ' num2str(level(choix_altitude)) ' hPa / Humidité Relative (%)'];
title(titre)
xlabel('Longitude')
ylabel('Latitude')

% figure ozone
figure
pcolor(longitude,latitude,o32')
axis([-20 20 35 65])
shading interp
colorbar
hold on
plot(tmp(:,1),tmp(:,2),'k','linewidth',2)
titre=[date(choix_date,1:17),' / ' num2str(level(choix_altitude)) ' hPa / Ozone (kg/kg)'];
title(titre)
xlabel('Longitude')
ylabel('Latitude')