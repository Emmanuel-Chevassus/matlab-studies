%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TP3 - Analyse de données
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Question 3 : coeffcients de régression et de corrélation

clear
close all
load Station_PDD_horaire_1995_2017_corrige

%%%%%%%%%
% CO2
%%%%%%%%%
% Série temporelle des données sans NaN
x=Temp(isnan(Temp)==0 & isnan(CO2pourCorrelation)==0);
y=CO2pourCorrelation(isnan(Temp)==0 & isnan(CO2pourCorrelation)==0);

% nb points de la série sans NaN
N=size(x,2);

% Calcul des coeffcients de la régression linéaire avec les équations (3) à (5)
delta=N*sum(x.*x)-(sum(x)*sum(x));
a=(N*sum(x.*y)-(sum(x)*sum(y)))/delta
b=(sum(x.*x)*sum(y)-sum(x)*sum(x.*y))/delta


% Calcul du coeffcient de corrélation avec l'équation (6)
xm=mean(x);
ym=mean(y);
num=sum((x-xm).*(y-ym));
den_gauche=sqrt(sum((x-xm).*(x-xm)));
den_droite=sqrt(sum((y-ym).*(y-ym)));
r=num/(den_gauche*den_droite)

% Calcul des paramètres de corrélation avec la fonction polyfit
droite=polyfit(x,y,1);
a2=droite(1) % le 1ier paramètre de la fonction polyfit est le coef. directeur
% de la droite de corrélation
b2=droite(2) % le 2e parametre de polyfit est l'ordonnée à l'origine de la
% droite de corrélation

% Calcul du coeffcient de corrélation avec la fonction corrcoef
r2=corrcoef(x,y)

% Tracé données + droite de régression
X_droite=[min(Temp) max(Temp)];
Y_droite=[min(Temp)*a2+b2 max(Temp)*a2+b2];

figure
plot(Temp,CO2pourCorrelation,'r.')
hold on
plot(X_droite,Y_droite,'linewidth',2,'Color','b')
xlabel('Temperature °C')
ylabel('CO2 ppmv')

% Coefficients indentiques entre Matlab et équations 3 à 6
disp('Coeffcients identiques avec les équations 3 à 6 et les fonctions polyfit et corrcoef.')