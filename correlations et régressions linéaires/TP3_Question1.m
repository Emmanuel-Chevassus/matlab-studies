%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TP3 - Analyse de donn�es
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Question 1 : v�rification et correction des s�ries temporelles

clear
close all

load Station_PDD_horaire_1995_2017

% Plots des donn�es telles quelles
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
title('Temp�rature �C')

% Corrections: �liminations des donn�es de concentration n�gatives ou non
% existantes (NaN)
% on ne garde que les donn�es O3 positives
O3nettoye=O3(O3>0); 
% on ne garde que les donn�es O3 positives qui ne sont pas NaN
O3nettoye=O3nettoye(isnan(O3nettoye)==0);
% idem pour CO
COnettoye=CO(CO>0); 
COnettoye=COnettoye(isnan(COnettoye)==0);
% idem pour CO2
CO2nettoye=CO2(CO2>0); 
CO2nettoye=CO2nettoye(isnan(CO2nettoye)==0);
% on ne garde que les temp�ratures qui ne sont pas NaN 
Tempnettoye=Temp(isnan(Temp)==0);

figure
subplot(2,2,1)
plot(O3nettoye,'r.')
title('O3 ppbv corrig�')
subplot(2,2,2)
plot(COnettoye,'r.')
title('CO ppbv corrig�')
subplot(2,2,3)
plot(CO2nettoye,'r.')
title('CO2 ppbv corrig�')
subplot(2,2,4)
plot(Tempnettoye,'r.')
title('Temp�rature �C corrig�e')


% Attention : pour plotter un param�tre en fonction d'un autre, il faut
% que les variables dans lesquelles ils ont �t� stock�s aient les m�me
% dimensions !
%
% Les donn�es qu'on vient de corriger ne peuvent donc pas �tre utilis�es !
%
% Pour contourner ce probl�me, on part des donn�es originelles, on garde
% les valeurs NaN et on transforme les mauvaises donn�es (n�gatives) en
% NaN. Les variables auront alors les m�mes dimensions ; les valeurs NaN ne
% g�neront pas les plots car Matlab les ignorera dans les plots


% Traitement des donn�es O3, CO et CO2 ; les temp�ratures peuvent �tre
% aussi bien positives que n�gatives
O3pourCorrelation = O3;
O3pourCorrelation(O3 <= 0) = NaN;
COpourCorrelation = CO;
COpourCorrelation(CO <= 0) = NaN;

% Remarque sur la qualit� des donn�es de CO
% Les 55000 (~) premi�res donn�es semblent bizarres : certaines sont tr�s
% proches de z�ro, puis elles se regroupent en un cluster autour de 380
% ppbv alors qu'elles devraient �voluer avec le temps, comme le font
% correctement les donn�es par la suite. Nous devons donc �liminer ces
% donn�es : nous n'avons aucune certitude de leur bonne qualit�.

% CO en fonction du temps
figure
plot(temps_fractionne,CO);
% Toutes les donn�es de CO avant 2002 semblent suspectes et sont donc
% retir�es :
COpourCorrelation(an<=2002)=NaN;

% CO2 et Temp�rature
CO2pourCorrelation = CO2;
CO2pourCorrelation(CO2 <= 0) = NaN;
plot(temps_fractionne,COpourCorrelation);

% Sauvegarde des donn�es dans un nouveau fichier
save Station_PDD_horaire_1995_2017_corrige O3pourCorrelation COpourCorrelation CO2pourCorrelation Temp an mois jour heure temps_fractionne



