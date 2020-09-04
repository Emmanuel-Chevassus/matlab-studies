%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TP3 - Analyse de données
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Question 5 : désaisonalisation

clear
close all
load Station_PDD_horaire_1995_2017_corrige

%%%%%%%%%
% CO2
%%%%%%%%%
% Série CO2 sans NaN
x=temps_fractionne(isnan(CO2pourCorrelation)==0);
y=CO2pourCorrelation(isnan(CO2pourCorrelation)==0);
z=mois(isnan(CO2pourCorrelation)==0);

% Calcul des valeurs mensuelles
for i=1:12
    CO2_mensuel(i)=mean(y(z==i));
end

% Calcul des résidus
for j=1:length(x);
    residu(j)=y(j)-CO2_mensuel(z(j));
end

% Paramètres de corrélation des résidus avec polyfit
droite=polyfit(x,residu,1);
a=droite(1)
b=droite(2)

% Coeffcient de corrélation des résidus avec corrcoef
r=corrcoef(x,residu)

% Tracé évolution temporelle + droite de régression
X_droite=[min(x) max(x)];
Y_droite=[min(x)*a+b max(x)*a+b];
figure
plot(x,residu,'r.')
hold on
plot(X_droite,Y_droite,'linewidth',2,'Color','b')
xlabel('Annees')
ylabel('Residu CO2 ppmv')
phrase=['a=' num2str(a) ' r=' num2str(r(1,2))]
text(min(x),max(residu),phrase)
clear x y z residu

%%%%%%%%%
% Température
%%%%%%%%%
% Série Température sans NaN
x=temps_fractionne(isnan(Temp)==0);
y=Temp(isnan(Temp)==0);
z=mois(isnan(Temp)==0);

% Calcul des valeurs mensuelles
for i=1:12
    Temp_mensuel(i)=mean(y(z==i));
end

% Calcul des résidus
for j=1:length(x);
    residu(j)=y(j)-Temp_mensuel(z(j));
end


% Paramètres de corrélation des résidus avec polyfit
droite=polyfit(x,residu,1);
a=droite(1)
b=droite(2)

% Coeffcient de corrélation des résidus avec corrcoef
r=corrcoef(x,residu)

% Tracé évolution temporelle + droite de régression
X_droite=[min(x) max(x)];
Y_droite=[min(x)*a+b max(x)*a+b];
figure
plot(x,residu,'r.')
hold on
plot(X_droite,Y_droite,'linewidth',2,'Color','b')
xlabel('Annees')
ylabel('Residu Temperature °C')
phrase=['a=' num2str(a) ' r=' num2str(r(1,2))]
text(min(x),max(residu),phrase)
clear x y z residu