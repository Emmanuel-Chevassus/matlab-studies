% Programme qui permet de lire les données radiosondages
% enregistrées dans les fichiers .COR, de les représenter graphiquement et
% d'exploiter les données par calculs de paramètres (tropopause,
% température potentielle, stabilité de l'atmosphère).

clear
clc
close all

date='9 février 2018 9h06 UTC'

%--------------------------------------------------------------------------
% lecture des données
%--------------------------------------------------------------------------

fid = fopen('CN2018020909.cor','rt');
k=0;
ligne=fgetl(fid);

while feof(fid)~=1
  ligne=fgetl(fid);
  k=k+1;
  [token, remain] = strtok(ligne);
  temps(k,1)=str2num(token);  % en secondes depuis minuit du jour du lâcher
  [token, remain] = strtok(remain);
  alt(k,1)=str2num(token); % en mètres
  [token, remain] = strtok(remain);
  lat(k,1)=str2num(token)*180/pi;  %en radians convertis en degrés
  [token, remain] = strtok(remain);
  lon(k,1)=str2num(token)*180/pi; %en radians convertis en degrés
  [token, remain] = strtok(remain);
  vent_est(k,1)=str2num(token);
  [token, remain] = strtok(remain);
  vent_nord(k,1)=str2num(token);
  [token, remain] = strtok(remain);
  vent_vert(k,1)=str2num(token);
  [token, remain] = strtok(remain);
  % vitesse du vent horizontal :
  vent_hor(k,1)=str2num(token); % en mètres par seconde
  [token, remain] = strtok(remain);
  % direction du vent :
  dir_vent(k,1)=str2num(token); % en degrés
  [token, remain] = strtok(remain);
  dew_point(k,1)=str2num(token);  % en degrés celcius
  [token, remain] = strtok(remain);
  Temp(k,1)=str2num(token);  % en degrés celcius
  [token, remain] = strtok(remain);
  humidite(k,1)=str2num(token); % en pourcent
  [token, remain] = strtok(remain);
  Press(k,1)=str2num(token);  % en hPa
  [token, remain] = strtok(remain); 
  flag(k,1)=str2num(token);
end  

fclose(fid);

%--------------------------------------------------------------------------
% représentation graphique des données à la montee
%--------------------------------------------------------------------------

% profil de pression
figure(1)
subplot(1,3,1)
plot(Press,alt/1000.)
xlabel('Pression en hPa')
ylabel('Altitude en kilomètres')

% profil de température
subplot(1,3,2)
plot(Temp,alt/1000.,'r')
hold on
plot(dew_point,alt/1000.,'b')
hold off
legend('Température masse d''air','température du point de rosée')
xlabel('Température en °C')
ylabel('Altitude en kilomètres')


% profil d'humidité
subplot(1,3,3)
plot(humidite,alt/1000.)
xlabel('Humidité en %')
ylabel('Altitude en kilomètres')
title(['radiosondage du ',date])
saveas(gcf,'PTU_montee.png', 'png')

figure(2)
% profil direction du vent
subplot(1,3,1)
plot(dir_vent,alt/1000.)
xlabel('Direction (origine) du vent en degré')
ylabel('Altitude en kilomètres')

% profil intensité du vent
subplot(1,3,2)
plot(vent_hor,alt/1000.)
xlabel('Intensité du vent en m/s')
ylabel('Altitude en kilomètres')

% profil de vent
subplot(1,3,3)
vzonal=vent_hor.*cosd(270-dir_vent);
vmeridien=vent_hor.*sind(270-dir_vent);
x=zeros(length(vmeridien),1);
%quiver(x,alt/1000.,vzonal,vmeridien,'b')
 indv=[1:50:length(x)];
 indv2=[25:50:length(x)];
 quiver(x(indv),alt(indv)/1000.,vzonal(indv),vmeridien(indv),'b')
 hold on
 quiver(x(indv2),alt(indv2)/1000.,vzonal(indv2),vmeridien(indv2),'r')
xlabel('Profil du vent horizontal')
ylabel('Altitude en kilomètres')
title(['radiosondage du ',date])
hold off
saveas(gcf,'vent_montee.png', 'png')


%--------------------------------------------------------------------------
% calculs sur les données
%--------------------------------------------------------------------------

% détermination de la tropopause

% par le minimum de température :
[minT,ind0]=min(Temp);
Tmin=Temp(ind0)
Pmin=Press(ind0)
altmin=alt(ind0)

%par le lapse-rate :
tropo=0 ;
ind=1;
ind2=1;
while (tropo==0) && (ind2(length(ind2)) ~= length(alt))
    ind2=find(alt<alt(ind)+2000.);
    diffT=(Temp(ind2(length(ind2)))-Temp(ind))/((alt(ind2(length(ind2)))-alt(ind))/1000);
    if diffT >= -2.
        tropo=1;
        alt_tropo=alt(ind)
        P_tropo=Press(ind)
        T_tropo=Temp(ind)
    else
        ind=ind+1;
    end  
end


% calcul de la température potentielle

theta=(273.15+Temp).*(1000./Press).^(2/7);
grad=(theta(10:10:length(theta))-theta(1:10:length(theta)-10))./(Press(10:10:length(theta))-Press(1:10:length(theta)-10));
% profil de température potentielle
figure(3)
subplot(1,2,1)
plot(theta,alt/1000.)
xlabel('Température potentielle en K')
ylabel('Altitude en kilomètres')

subplot(1,2,2)
plot(grad,alt(5:10:length(theta)-5)/1000.)
xlabel('Gradient vertical de température potentielle en K/hPa')
ylabel('Altitude en kilomètres')
saveas(gcf,'theta_montee.png', 'png')


% calcul du rapport de mélange en vapeur d'eau 
 TempK=Temp+273.15;
 val1=-7.90298*((373.16./TempK)-1.);
 val2=5.02808*log10(373.16./TempK);
 val3=(11.344*(1.-(TempK./373.16)));
 val4=-1.3816E-7*((10.^val3)-1.);
 val5=-(3.49149*((373.16./TempK)-1.));
 val6=8.1328*(1E-3)*((10.^val5)-1.);
 val7=val1+val2+val4+val6;
 Ps=10.^(val7+log10(1013.246));
H2Ow=(humidite.*Ps*10^6)./(100*Press);

vala=-9.09718*((273.16./TempK)-1.);
valb=-3.56654*log10(273.16./TempK);
valc=0.876793*(1.-(TempK./273.16));
vald=vala+valb+valc+log10(6.1071);
Psg=10.^vald;
H2Og=(humidite.*Psg*10^6)./(100*Press);

H2Oc=18/28.976*H2Og/1000;

figure(4)
semilogx(H2Ow,alt/1000.,'b')
hold on
semilogx(H2Og,alt/1000.,'r')
hold off
legend('saturation par rapport à l''eau liquide','saturation par rapport à la glace')
xlabel('vapeur d''eau en ppmv')
ylabel('Altitude en kilomètres')
saveas(gcf,'H2Oppmv_montee.png', 'png')


figure(5)
plot(H2Oc,alt/1000.,'b')
xlabel('vapeur d''eau en g/kg')
ylabel('Altitude en kilomètres')
saveas(gcf,'H2Ogkg_montee.png', 'png')
