%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TP3 - Analyse de donn�es
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Question 3 : coeffcients de r�gression et de corr�lation

clear
close all
load Station_PDD_horaire_1995_2017_corrige

%%%%%%%%%
% CO2
%%%%%%%%%
% S�rie temporelle des donn�es sans NaN
x=Temp(isnan(Temp)==0 & isnan(CO2pourCorrelation)==0);
y=CO2pourCorrelation(isnan(Temp)==0 & isnan(CO2pourCorrelation)==0);

% nb points de la s�rie sans NaN
N=size(x,2);

% Calcul des coeffcients de la r�gression lin�aire avec les �quations (3) � (5)
delta=N*sum(x.*x)-(sum(x)*sum(x));
a=(N*sum(x.*y)-(sum(x)*sum(y)))/delta
b=(sum(x.*x)*sum(y)-sum(x)*sum(x.*y))/delta


% Calcul du coeffcient de corr�lation avec l'�quation (6)
xm=mean(x);
ym=mean(y);
num=sum((x-xm).*(y-ym));
den_gauche=sqrt(sum((x-xm).*(x-xm)));
den_droite=sqrt(sum((y-ym).*(y-ym)));
r=num/(den_gauche*den_droite)

% Calcul des param�tres de corr�lation avec la fonction polyfit
droite=polyfit(x,y,1);
a2=droite(1) % le 1ier param�tre de la fonction polyfit est le coef. directeur
% de la droite de corr�lation
b2=droite(2) % le 2e parametre de polyfit est l'ordonn�e � l'origine de la
% droite de corr�lation

% Calcul du coeffcient de corr�lation avec la fonction corrcoef
r2=corrcoef(x,y)

% Trac� donn�es + droite de r�gression
X_droite=[min(Temp) max(Temp)];
Y_droite=[min(Temp)*a2+b2 max(Temp)*a2+b2];

figure
plot(Temp,CO2pourCorrelation,'r.')
hold on
plot(X_droite,Y_droite,'linewidth',2,'Color','b')
xlabel('Temperature �C')
ylabel('CO2 ppmv')

% Coefficients indentiques entre Matlab et �quations 3 � 6
disp('Coeffcients identiques avec les �quations 3 � 6 et les fonctions polyfit et corrcoef.')