% �tude de donn�es volcanologiques : grain size distributions at Puy de la
% Vache et Lassolas
% PHI : diam�tre �quivalent
% WT : masse des scories de diam�tres PHI

clc
clear
close all

%%%%%
% Partie I : Analyse statistique de la distribution des scories des puys de
% La Vache et Lassolas 
%%%%%
load puy_vache_lassolas

% a) Fr�quences relatives, cumul�es relatives et diagrammes des fr�quences
% cumul�es relatives

% Calcul des fr�quences relatives
WTQ1_rel = WT1./sum(WT1)*100;
WTQ2_rel = WT2./sum(WT2)*100;
WTQ3_rel = WT3./sum(WT3)*100;
WTQ4_rel = WT4./sum(WT4)*100;

% Calcul des fr�quences cumul�es avec la fonction MATLAB cumsum
WTQ1_cum = cumsum(WT1);
WTQ2_cum = cumsum(WT2);
WTQ3_cum = cumsum(WT3);
WTQ4_cum = cumsum(WT4);

% Calcul des fr�quences relatives cumul�es
WTQ1_rel_cum = cumsum(WTQ1_rel);
WTQ2_rel_cum = cumsum(WTQ2_rel);
WTQ3_rel_cum = cumsum(WTQ3_rel);
WTQ4_rel_cum = cumsum(WTQ4_rel);


% Alternative pour calculer une fr�quence cumul�e � l'aide d'une boucle
WT1_cumul2(1)=WTQ1_rel(1);
for i=2:length(WTQ1_rel);
    WT1_cumul2(i)=WT1_cumul2(i-1)+WTQ1_rel(i);
end

% Diagrammes des fr�quences cumul�es
% D�termination graphique des percentiles
figure
h=gca; % stockage des �l�ments graphique de la figure dans la variable h
% pour �tre format�e par la suite (meilleure visualisation) 
plot(PHI, WTQ1_rel_cum, 'r-', 'LineWidth', 1.5);
% Format du style de la grille sur la figure : aidera � la d�termination
% graphique des valeurs
grid on; % grid off pour retirer la grille si besoin
set(h, 'GridLineStyle',':');
% grid minor; 
set(h, 'XTick', [-7.5:0.5:7], 'YTick', [0:2:100]);
hold on
plot(PHI, WTQ2_rel_cum, 'b-', 'LineWidth', 1.5);
plot(PHI, WTQ3_rel_cum, 'k-', 'LineWidth', 1.5);
plot(PHI, WTQ4_rel_cum, 'g-', 'LineWidth', 1.5);
hold off
leg=legend('Niveau 1','Niveau 2','Niveau 3','Niveau 4', 'Location', 'SouthEast');
% Format de la l�gende
set(leg,'FontAngle', 'italic')
title('Diagramme des fr�quences cumul�es relatives')
xlabel('phi');
ylabel('fr�quences cumul�es');


% b) Lecture graphique des percentiles. 


% c) Histogrammes des fr�qeunces relatives
% Les donn�es sont d�j� class�es en unit� phi : utilisons la fonction bar
% plut�t que hist
figure
subplot(2,2,1)
bar(PHI,WTQ1_rel)
title('histogramme du niveau stratigraphique 1');
xlabel('phi');
ylabel('Wt %');

subplot(2,2,2)
bar(PHI,WTQ2_rel)
title('histogramme niveau stratigraphique 2');
xlabel('phi');
ylabel('Wt %');

subplot(2,2,3)
bar(PHI,WTQ3_rel)
title('histogramme niveau stratigraphique 3');
xlabel('phi');
ylabel('Wt %');

subplot(2,2,4)
bar(PHI,WTQ4_rel)
title('histogramme niveau stratigraphique 4');
xlabel('phi');
ylabel('Wt %');


% d) Calcul des param�tres statistiques des distributions

% Calcul du percentile p associ� � chaque s�rie : ce calcul se fait par 
% interpolation lin�aire sur le diagramme des fr�quences cumul�es 
p = [5, 16, 25, 50, 75, 84, 95]; %d�finition des percentiles � trouver
% Niveau Q1 :
parametres_phi_Q1 = abs_cum(WTQ1_rel_cum, PHI, p)
% Niveau Q2 :
parametres_phi_Q2 = abs_cum(WTQ2_rel_cum, PHI, p)
% Niveau Q3 :
parametres_phi_Q3 = abs_cum(WTQ3_rel_cum, PHI, p)
% Niveau Q4 :
parametres_phi_Q4 = abs_cum(WTQ4_rel_cum, PHI, p)


% Percentiles : chaque colonne correspond au niveau stratigraphique Q1 � Q4
phi5 = [parametres_phi_Q1(1), parametres_phi_Q2(1), parametres_phi_Q3(1), parametres_phi_Q4(1)];
phi16 = [parametres_phi_Q1(2), parametres_phi_Q2(2), parametres_phi_Q3(2), parametres_phi_Q4(2)];
phi25 = [parametres_phi_Q1(3), parametres_phi_Q2(3), parametres_phi_Q3(3), parametres_phi_Q4(3)];
phi50 = [parametres_phi_Q1(4), parametres_phi_Q2(4), parametres_phi_Q3(4), parametres_phi_Q4(4)];
phi75 = [parametres_phi_Q1(5), parametres_phi_Q2(5), parametres_phi_Q3(5), parametres_phi_Q4(5)];
phi84 = [parametres_phi_Q1(6), parametres_phi_Q2(6), parametres_phi_Q3(6), parametres_phi_Q4(6)];
phi95 = [parametres_phi_Q1(7), parametres_phi_Q2(7), parametres_phi_Q3(7), parametres_phi_Q4(7)];

% Caract�risation statistique de la distribution
for numserie=1:4
    Mdphi(numserie) = phi50(numserie); % m�diane
    Mphi(numserie) = (phi16(numserie)+phi84(numserie))/2; % "moyenne" des tailles
    Mz(numserie) = (phi16(numserie)+phi50(numserie)+phi84(numserie))/3; % moyenne graphique des tailles
    sigma(numserie) = (phi84(numserie)-phi16(numserie))/4 + (phi95(numserie)-phi5(numserie))/6.6; % �cart-type graphique
    sigma_phi(numserie) = (phi84(numserie)+phi16(numserie))/2; % sorting ou �cart-type standard
    sk(numserie) = (phi84(numserie)+phi16(numserie)-2*phi50(numserie))/(2*(phi84(numserie)-phi16(numserie))) + ...
        (phi95(numserie)+phi5(numserie)-2*phi50(numserie))/(2*(phi95(numserie)-phi5(numserie))); % skewness graphique
    aphi(numserie) = (phi84(numserie)+phi16(numserie)-phi50(numserie))/sigma_phi(numserie); % skewness
    K(numserie) = (phi95(numserie)-phi5(numserie))/(2.44*(phi75(numserie)-phi25(numserie))); % kurtosis
end

% Affichage des param�tres statistiques
[Mdphi
Mphi
Mz
sigma
sigma_phi
sk
aphi
K]



%%%%%
% Partie 2 : �tude de la texture des scories de Stromboli
%%%%%
% clear all
% close all

load vesicle_stromboli
ind1 = find(Grossissement == 1);
ind2 = find(Grossissement == 2);
ind3 = find(Grossissement == 3);

% Rapport d'aspect
AR1 = b(ind1)./a(ind1);
AR2 = b(ind2)./a(ind2);
AR3 = b(ind3)./a(ind3);

% Coefficient d'�longation
e1 = (a(ind1)-b(ind1))./(a(ind1)+b(ind1));
e2 = (a(ind2)-b(ind2))./(a(ind2)+b(ind2));
e3 = (a(ind3)-b(ind3))./(a(ind3)+b(ind3));

% Facteur de forme
sf1 = 4*pi*A(ind1)./(p(ind1).*p(ind1));
sf2 = 4*pi*A(ind2)./(p(ind2).*p(ind2));
sf3 = 4*pi*A(ind3)./(p(ind3).*p(ind3));

% Param�tre de r�gularit�
rg1 = A(ind1)./(pi*a(ind1).*b(ind1));
rg2 = A(ind2)./(pi*a(ind2).*b(ind2));
rg3 = A(ind3)./(pi*a(ind3).*b(ind3));
% 

figure; plot(rg1, AR1, 'ko')
title('Grossissement 1');
xlabel('rg');
ylabel('AR');
figure; plot(rg2, AR2, 'ko')
title('Grossissement 2');
xlabel('rg');
ylabel('AR');
figure; plot(rg3, AR3, 'ko')
title('Grossissement 3');
xlabel('rg');
ylabel('AR');

figure; plot(rg1, e1, 'ro')
title('Grossissement 1');
xlabel('rg');
ylabel('epsilon');
figure; plot(rg2, e2, 'ro')
title('Grossissement 2');
xlabel('rg');
ylabel('epsilon');
figure; plot(rg3, e3, 'ro')
title('Grossissement 3');
xlabel('rg');
ylabel('epsilon');

figure; plot(rg1, sf1, 'bo')
title('Grossissement 1');
xlabel('rg');
ylabel('SF');
figure; plot(rg2, sf2, 'bo')
title('Grossissement 2');
xlabel('rg');
ylabel('SF');
figure; plot(rg3, sf3, 'bo')
title('Grossissement 3');
xlabel('rg');
ylabel('SF');
