% Programme qui permet de lire les donn�es radiosondages
% enregistr�es dans les fichiers .COR, de les repr�senter graphiquement et
% d'exploiter les donn�es par calculs de param�tres (tropopause,
% temp�rature potentielle, stabilit� de l'atmosph�re).

clear
clc
close all

date='9 f�vrier 2018 9h06 UTC'

%--------------------------------------------------------------------------
% lecture des donn�es
%--------------------------------------------------------------------------

fid = fopen('CN2018020909.cor','rt');
k=0;
ligne=fgetl(fid);

while feof(fid)~=1
  ligne=fgetl(fid);
  k=k+1;
  [token, remain] = strtok(ligne);
  temps(k,1)=str2num(token);  % en secondes depuis minuit du jour du l�cher
  [token, remain] = strtok(remain);
  alt(k,1)=str2num(token); % en m�tres
  [token, remain] = strtok(remain);
  lat(k,1)=str2num(token)*180/pi;  %en radians convertis en degr�s
  [token, remain] = strtok(remain);
  lon(k,1)=str2num(token)*180/pi; %en radians convertis en degr�s
  [token, remain] = strtok(remain);
  vent_est(k,1)=str2num(token);
  [token, remain] = strtok(remain);
  vent_nord(k,1)=str2num(token);
  [token, remain] = strtok(remain);
  vent_vert(k,1)=str2num(token);
  [token, remain] = strtok(remain);
  % vitesse du vent horizontal :
  vent_hor(k,1)=str2num(token); % en m�tres par seconde
  [token, remain] = strtok(remain);
  % direction du vent :
  dir_vent(k,1)=str2num(token); % en degr�s
  [token, remain] = strtok(remain);
  dew_point(k,1)=str2num(token);  % en degr�s celcius
  [token, remain] = strtok(remain);
  Temp(k,1)=str2num(token);  % en degr�s celcius
  [token, remain] = strtok(remain);
  humidite(k,1)=str2num(token); % en pourcent
  [token, remain] = strtok(remain);
  Press(k,1)=str2num(token);  % en hPa
  [token, remain] = strtok(remain); 
  flag(k,1)=str2num(token);
end  

fclose(fid);

%--------------------------------------------------------------------------
% repr�sentation graphique des donn�es � la montee
%--------------------------------------------------------------------------

% profil de pression
figure(1)
subplot(1,3,1)
plot(Press,alt/1000.)
xlabel('Pression en hPa')
ylabel('Altitude en kilom�tres')

% profil de temp�rature
subplot(1,3,2)
plot(Temp,alt/1000.,'r')
hold on
plot(dew_point,alt/1000.,'b')
hold off
legend('Temp�rature masse d''air','temp�rature du point de ros�e')
xlabel('Temp�rature en �C')
ylabel('Altitude en kilom�tres')


% profil d'humidit�
subplot(1,3,3)
plot(humidite,alt/1000.)
xlabel('Humidit� en %')
ylabel('Altitude en kilom�tres')
title(['radiosondage du ',date])
saveas(gcf,'PTU_montee.png', 'png')

figure(2)
% profil direction du vent
subplot(1,3,1)
plot(dir_vent,alt/1000.)
xlabel('Direction (origine) du vent en degr�')
ylabel('Altitude en kilom�tres')

% profil intensit� du vent
subplot(1,3,2)
plot(vent_hor,alt/1000.)
xlabel('Intensit� du vent en m/s')
ylabel('Altitude en kilom�tres')

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
ylabel('Altitude en kilom�tres')
title(['radiosondage du ',date])
hold off
saveas(gcf,'vent_montee.png', 'png')


%--------------------------------------------------------------------------
% calculs sur les donn�es
%--------------------------------------------------------------------------

% d�termination de la tropopause

% par le minimum de temp�rature :
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


% calcul de la temp�rature potentielle

theta=(273.15+Temp).*(1000./Press).^(2/7);
grad=(theta(10:10:length(theta))-theta(1:10:length(theta)-10))./(Press(10:10:length(theta))-Press(1:10:length(theta)-10));
% profil de temp�rature potentielle
figure(3)
subplot(1,2,1)
plot(theta,alt/1000.)
xlabel('Temp�rature potentielle en K')
ylabel('Altitude en kilom�tres')

subplot(1,2,2)
plot(grad,alt(5:10:length(theta)-5)/1000.)
xlabel('Gradient vertical de temp�rature potentielle en K/hPa')
ylabel('Altitude en kilom�tres')
saveas(gcf,'theta_montee.png', 'png')


% calcul du rapport de m�lange en vapeur d'eau 
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
legend('saturation par rapport � l''eau liquide','saturation par rapport � la glace')
xlabel('vapeur d''eau en ppmv')
ylabel('Altitude en kilom�tres')
saveas(gcf,'H2Oppmv_montee.png', 'png')


figure(5)
plot(H2Oc,alt/1000.,'b')
xlabel('vapeur d''eau en g/kg')
ylabel('Altitude en kilom�tres')
saveas(gcf,'H2Ogkg_montee.png', 'png')
