% Question 2
clear
close all

load Petite_Matrice_ECMWF

Z0=44.33; P0=1013.25; a=5.26;
P=double(level);

for i=1:length(level);
altitude(i)=Z0*(1-((P(i))/P0).^(1/a));
end

figure
plot(level,altitude,'ro-')
ylabel('Altitude (km)')
xlabel('Pression (hPa)')
grid on

