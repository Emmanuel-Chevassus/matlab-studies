%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TP3 - Analyse de donn�es
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Question 2 : corr�lations entre param�tres

clear
close all

load Station_PDD_horaire_1995_2017_corrige

% Plots des param�tres en fonctions les uns des autres
figure
subplot(2,3,1)
plot(COpourCorrelation,CO2pourCorrelation,'r.')
xlabel('CO ppbv')
ylabel('CO2 ppmv')
subplot(2,3,2)
plot(O3pourCorrelation,CO2pourCorrelation,'r.')
xlabel('O3 ppbv')
ylabel('CO2 ppmv')
subplot(2,3,3)
plot(Temp,CO2pourCorrelation,'r.')
xlabel('Temperature �C')
ylabel('CO2 ppmv')
subplot(2,3,4)
plot(O3pourCorrelation,COpourCorrelation,'r.')
xlabel('O3 ppbv')
ylabel('CO ppbv')
subplot(2,3,5)
plot(Temp,COpourCorrelation,'r.')
xlabel('Temperature �C')
ylabel('CO ppbv')
subplot(2,3,6)
plot(Temp,O3pourCorrelation,'r.')
xlabel('Temperature �C')
ylabel('O3 ppbv')



