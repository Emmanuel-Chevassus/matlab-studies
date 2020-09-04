clear
clc
close all

%-----------------------------------------------------------------------------------
% 2. a) Variabilit� horizontale de la vapeur d'eau
%-----------------------------------------------------------------------------------

load('AIRS_janvier2017.mat')
load('AIRS_juillet2017.mat')

H2Ojanv = H2O1; % Changement de nom pour la variable concentration en eau 
% en janvier pour �viter un conflit avec la 2e partie du TP 
% (fichier AIRS_01072017_CF.mat). Permet aussi de garder la matrice H2O1
% originelle.
H2Ojuil = H2O7; % idem pour les concentrations mesur�es en juillet

% �tendue en latitude couverte par AIRS
disp('�tendue des donn�es en latitude :')
minlat=min(min(lat1),min(lat7)) % lat1 et lat7 = latitudes donn�es janvier et juillet
maxlat=max(max(lat1),max(lat7))

% Moyenne et �cart-type des mesures � 925 hPa 
disp('          Variabilit� horizontale et saisonni�re � 925hPa :')
disp(' ')
for i=-90:30:60
  LatitudesJanvier=find((lat1 >= i) & (lat1 < i+30));
  LatitudesJuillet=find((lat7 >= i) & (lat7 < i+30));
  fprintf('bande de latitude : de %2d� � %2d �',i, i+30)
  disp(' ')
  % Matlab calcule la moyenne et l'�cart-type d'un ensemble de donn�es avec
  % les fonction mean et std :
  fprintf('moyenne +/- �cart-type (g/kg) en janvier : %.4f +/- %.4f',...
      mean(H2Ojanv(LatitudesJanvier)), std(H2Ojanv(LatitudesJanvier)))
      % les ... permettent de couper la ligne pour une meilleure lecture du 
      % programme sans poser de probl�me � MATLAB qui consid�re cette ligne 
      % comme continue
  disp(' ')
  fprintf('moyenne +/- �cart-type (g/kg) en juillet : %.4f +/- %.4f',...
      mean(H2Ojuil(LatitudesJuillet)), std(H2Ojuil(LatitudesJuillet)))
  disp(' '),disp(' ')
end
disp(' '),disp(' ')% pour faciliter la lecture � l'�cran


% Moyenne et �cart-type des mesures � 1,1 km 
disp('          Concentration en eau � 1,1km d''altitude :')
disp(' ')
% Chaque ligne de la matrice H20 contient les mesures effectu�es �
% diff�rentes pressions � un moment donn�. Il faut donc faire
% l'interpolation sur chacune de ces lignes.
for i=1:length(lat1)
  H2Ojanv_1100m(i)=interp1(alt1(i,:),H2Ojanv(i,:),1100);
end
for i=1:length(lat7)
  H2Ojuil_1100m(i)=interp1(alt7(i,:),H2Ojuil(i,:),1100);
end
for i=-90:30:60
  LatitudesJanvier=find((lat1 >= i) & (lat1 < i+30));
  LatitudesJuillet=find((lat7 >= i) & (lat7 < i+30));
  fprintf('bande de latitude : de %2d� � %2d �',i, i+30)
  disp(' ')
  fprintf('moyenne +/- �cart-type (g/kg) en janvier : %.4f +/- %.4f',...
      mean(H2Ojanv_1100m(LatitudesJanvier)), std(H2Ojanv_1100m(LatitudesJanvier)))
 disp(' ')
  fprintf('moyenne +/- �cart-type (g/kg) en juillet : %.4f +/- %.4f',...
      mean(H2Ojuil_1100m(LatitudesJuillet)), std(H2Ojuil_1100m(LatitudesJuillet)))
  disp(' '),disp(' ')
  end
disp(' '),disp(' ')% pour faciliter la lecture � l'�cran


% Repr�sentativit� des donn�es, nombre de donn�es et histogrammes
disp('          Repr�sentativit� des donn�es :')
disp(' ')
Nombre_de_donnees = [];% La matrice qui contiendra le nombre de donn�es dans 
% chaque bande de latitude. La 1e ligne contiendra les donn�es de janvier
% et la 2e les donn�es de juillet
Bande_de_latitudes = 0;% Ce compteur, initialis� � z�ro, repr�sente les 
% diff�rentes bandes de latitude : Bande_de_latitudes=1 pour la bande
% 90S-60S, Bande_de_latitudes=2 pour la bande 60S-30S, etc.
% Les valeurs n�gatives de latitude correspondent � l'h�msiph�re sud.
for i=-90:30:60
  Bande_de_latitudes = Bande_de_latitudes + 1;
  Janvier=find((lat1 >= i) & (lat1 < i+30));
  Juillet=find((lat7 >= i) & (lat7 < i+30));
  Nombre_de_donnees(1,Bande_de_latitudes)=length(Janvier);
  Nombre_de_donnees(2,Bande_de_latitudes)=length(Juillet);
  % Si on r�alise des histogrammes par bande de 5 degr� de longitude ou de
  % latitude, les histogrammes auront tous 12 classes quelque soit le
  % nombre de donn�es...
  nb_de_classe = 12;
  figure(1)% Histogramme des donn�es pour les longitudes par bande de 
  % latitudes pour le mois de janvier 2017 :
  subplot(2,3,Bande_de_latitudes)
  hist(lon1(Janvier),nb_de_classe);
  xlabel('longitude (�)')
  % pour ylabel on utilise num2str pour traduire les valeurs de latitudes
  % en texte :
  titre=['nb d''occurence entre ' num2str(i) '� et ' num2str(i+30) '�'];
  ylabel(titre)
  title('1 janvier 2017')
  figure(2)% Histogramme des donn�es pour les longitudes par bande de
  % latitudes pour le mois de juillet 2017 :
  subplot(2,3,Bande_de_latitudes)
  hist(lon7(Juillet),nb_de_classe);
  xlabel('longitude (�)')
  titre=['nb d''occurence entre ' num2str(i) '� et ' num2str(i+30) '�'];
  title('1 juillet 2017')
  ylabel(titre)
  figure(3) % Histogramme des donn�es pour les latitudes par bande de
  % latitudes pour le mois de janvier 2017 :
  subplot(2,3,Bande_de_latitudes)
  hist(lat1(Janvier),nb_de_classe);
  xlabel('latitude (�)')
  titre=['nb d''occurence entre ' num2str(i) '� et ' num2str(i+30) '�'];
  title('1 janvier 2017')
  ylabel(titre)
  figure(4) % Histogramme des donn�es pour les latitudes par bande de
  % latitudes pour le mois de juillet 2017 :
  subplot(2,3,Bande_de_latitudes)
  hist(lat7(Juillet),nb_de_classe);
  xlabel('latitude (�)')
  titre=['nb d''occurence entre ' num2str(i) '� et ' num2str(i+30) '�'];
  ylabel(titre)
  title('1 juillet 2017')
end
% Affichage � l'�cran du nombre de donn�es par bande de latitude en janvier
% et en juillet :
Latitudes=['      90S-60S' '     60S-30S' '      30S-0' '       0-30N'...
    '      30N-60N' '     90N-60N']
Nombre_de_donnees




%-----------------------------------------------------------------------------------
% 2. b) Variabilit� verticale de la vapeur d'eau
%-----------------------------------------------------------------------------------
load('AIRS_01072017_CF.mat')

% Profil semilog de vapeur d'eau en fonction de l'altitude
figure (5)
semilogx(H2O,alt/1000,'-r','LineWidth',3)
ylabel('altitude en km')
xlabel('H2O en g/kg')

% Interpolation des concentrations de vapeur chaque km d'altitude
z=[1:1:20];
hold on
H2O1=interp1(alt/1000,H2O,z,'nearest');
semilogx(H2O1,z,'-g')
H2O2=interp1(alt/1000,H2O,z,'next');
semilogx(H2O2,z,'-b')
H2O3=interp1(alt/1000,H2O,z,'previous');
semilogx(H2O3,z,'-y')
H2O4=interp1(alt/1000,H2O,z,'linear');
semilogx(H2O4,z,'-m')
H2O5=interp1(alt/1000,H2O,z,'spline');
semilogx(H2O5,z,'-k')
H2O6=interp1(alt/1000,H2O,z,'pchip');
semilogx(H2O6,z,'-+b')
H2O7log=interp1(alt/1000,log(H2O),z,'linear');
H2O7=exp(H2O7log);
semilogx(H2O7,z,'-c','LineWidth',2);
hold off
%legend('mesures','nearest', 'next', 'previous', 'linear','spline','pchip')
legend('mesures','nearest', 'next', 'previous', 'linear','spline','pchip','ln','ln' )