%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TP3 - Analyse de données
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Question 1 : vérification et correction des séries temporelles

clear
close all

load Station_PDD_horaire_1995_2017

% Plots des données telles quelles
figure
subplot(2,2,1)
plot(O3,'r.')
title('O3 ppbv')
subplot(2,2,2)
plot(CO,'r.')
title('CO ppbv')
subplot(2,2,3)
plot(CO2,'r.')
title('CO2 ppmv')
subplot(2,2,4)
plot(Temp,'r.')
title('Température °C')

% Corrections: éliminations des données de concentration négatives ou non
% existantes (NaN)
% on ne garde que les données O3 positives
O3nettoye=O3(O3>0); 
% on ne garde que les données O3 positives qui ne sont pas NaN
O3nettoye=O3nettoye(isnan(O3nettoye)==0);
% idem pour CO
COnettoye=CO(CO>0); 
COnettoye=COnettoye(isnan(COnettoye)==0);
% idem pour CO2
CO2nettoye=CO2(CO2>0); 
CO2nettoye=CO2nettoye(isnan(CO2nettoye)==0);
% on ne garde que les températures qui ne sont pas NaN 
Tempnettoye=Temp(isnan(Temp)==0);

figure
subplot(2,2,1)
plot(O3nettoye,'r.')
title('O3 ppbv corrigé')
subplot(2,2,2)
plot(COnettoye,'r.')
title('CO ppbv corrigé')
subplot(2,2,3)
plot(CO2nettoye,'r.')
title('CO2 ppbv corrigé')
subplot(2,2,4)
plot(Tempnettoye,'r.')
title('Température °C corrigée')


% Attention : pour plotter un paramètre en fonction d'un autre, il faut
% que les variables dans lesquelles ils ont été stockés aient les même
% dimensions !
%
% Les données qu'on vient de corriger ne peuvent donc pas être utilisées !
%
% Pour contourner ce problème, on part des données originelles, on garde
% les valeurs NaN et on transforme les mauvaises données (négatives) en
% NaN. Les variables auront alors les mêmes dimensions ; les valeurs NaN ne
% gèneront pas les plots car Matlab les ignorera dans les plots


% Traitement des données O3, CO et CO2 ; les températures peuvent être
% aussi bien positives que négatives
O3pourCorrelation = O3;
O3pourCorrelation(O3 <= 0) = NaN;
COpourCorrelation = CO;
COpourCorrelation(CO <= 0) = NaN;

% Remarque sur la qualité des données de CO
% Les 55000 (~) premières données semblent bizarres : certaines sont très
% proches de zéro, puis elles se regroupent en un cluster autour de 380
% ppbv alors qu'elles devraient évoluer avec le temps, comme le font
% correctement les données par la suite. Nous devons donc éliminer ces
% données : nous n'avons aucune certitude de leur bonne qualité.

% CO en fonction du temps
figure
plot(temps_fractionne,CO);
% Toutes les données de CO avant 2002 semblent suspectes et sont donc
% retirées :
COpourCorrelation(an<=2002)=NaN;

% CO2 et Température
CO2pourCorrelation = CO2;
CO2pourCorrelation(CO2 <= 0) = NaN;
plot(temps_fractionne,COpourCorrelation);

% Sauvegarde des données dans un nouveau fichier
save Station_PDD_horaire_1995_2017_corrige O3pourCorrelation COpourCorrelation CO2pourCorrelation Temp an mois jour heure temps_fractionne



