%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TP3 - Analyse de données
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Question 4 : tendances à long terme
clear
close all
load Station_PDD_horaire_1995_2017_corrige

%%%%%%%%%
% CO2
%%%%%%%%%
% Série CO2 sans NaN
x=temps_fractionne(isnan(CO2pourCorrelation)==0); % x=temps
y=CO2pourCorrelation(isnan(CO2pourCorrelation)==0); % y=CO2

% Paramètres de corrélation avec polyfit
droite=polyfit(x,y,1);
a=droite(1) 
b=droite(2)

% Coeffcient de corrélation avec corrcoef
r=corrcoef(x,y)

% Tracé évolution temporelle + droite de régression
X_droite=[min(x) max(x)];
Y_droite=[min(x)*a+b max(x)*a+b];
figure
subplot(2,2,1)
plot(x,y,'r.')
hold on
plot(X_droite,Y_droite,'linewidth',2,'Color','b')
xlabel('Annees')
ylabel('CO2 ppmv')
phrase=['a=' num2str(a) ',  r=' num2str(r(1,2))]
text(min(x),max(y),phrase)
clear x y

%%%%%%%%%
% CO
%%%%%%%%%
% Série CO sans NaN
x=temps_fractionne(isnan(COpourCorrelation)==0);
y=COpourCorrelation(isnan(COpourCorrelation)==0);

% Paramètres de corrélation avec polyfit
droite=polyfit(x,y,1);
a=droite(1)
b=droite(2)

% Coeffcient de corrélation avec corrcoef
r=corrcoef(x,y)

% Tracé évolution temporelle + droite de régression
X_droite=[min(x) max(x)];
Y_droite=[min(x)*a+b max(x)*a+b];
subplot(2,2,2)
plot(x,y,'r.')
hold on
plot(X_droite,Y_droite,'linewidth',2,'Color','b')
xlabel('Annees')
ylabel('CO ppbv')
phrase=['a=' num2str(a) ',  r=' num2str(r(1,2))]
text(min(x),max(y),phrase)
clear x y

%%%%%%%%%
% O3
%%%%%%%%%
% Série O3 sans NaN
x=temps_fractionne(isnan(O3pourCorrelation)==0);
y=O3pourCorrelation(isnan(O3pourCorrelation)==0);

% Paramètres de corrélation avec polyfit
droite=polyfit(x,y,1);
a=droite(1)
b=droite(2)

% Coeffcient de corrélation avec corrcoef
r=corrcoef(x,y)

% Tracé évolution temporelle + droite de régression
X_droite=[min(x) max(x)];
Y_droite=[min(x)*a+b max(x)*a+b];
% figure
subplot(2,2,3)
plot(x,y,'r.')
hold on
plot(X_droite,Y_droite,'linewidth',2,'Color','b')
xlabel('Annees')
ylabel('O3 ppbv')
phrase=['a=' num2str(a) ',  r=' num2str(r(1,2))]
text(min(x),max(y),phrase)
clear x y

%%%%%%%%%
% Température
%%%%%%%%%
% Série Température sans NaN
x=temps_fractionne(isnan(Temp)==0);
y=Temp(isnan(Temp)==0);

% Paramètres de corrélation avec polyfit
droite=polyfit(x,y,1);
a=droite(1)
b=droite(2)

% Coeffcient de corrélation avec corrcoef
r=corrcoef(x,y)

% Tracé évolution temporelle + droite de régression
X_droite=[min(x) max(x)];
Y_droite=[min(x)*a+b max(x)*a+b];
subplot(2,2,4)
plot(x,y,'r.')
hold on
plot(X_droite,Y_droite,'linewidth',2,'Color','b')
xlabel('Annees')
ylabel('Temperature °C')
phrase=['a=' num2str(a) ',  r=' num2str(r(1,2))]
text(min(x),max(y),phrase)
clear x y
