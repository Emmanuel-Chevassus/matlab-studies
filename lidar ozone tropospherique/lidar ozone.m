clear all
close all
clc

num_fic = [754 756 758 800 802];
ggh = 0;

for i = 1:length(num_fic)
    ggh = ggh+1;
    nom_fichier = ['tro0912241' num2str(num_fic(i)) '.mat'];
    eval(['load ' nom_fichier]);
    
    signal_a_tot_2009(:,:,ggh) = signal_a;
    signal_c_tot_2009(:,:,ggh) = signal_c;
    z_a_tot_2009(:,1) = z_a(:);
    z_c_tot_2009(:,1) = z_c(:);
end

num_fic2 = [256 258 300 302 304 306];
ggh = 0;

for i = 1:length(num_fic2)
    ggh = ggh+1;
    nom_fichier = ['tro1304022' num2str(num_fic2(i)) '.mat'];
    eval(['load ' nom_fichier]);
    signal_a_tot_2013(:,:,ggh) = signal_a(:,:);
    signal_c_tot_2013(:,:,ggh) = signal_c(:,:);
    z_a_tot_2013(:,1) = z_a(:)/1000;
    z_c_tot_2013(:,1) = z_c(:)/1000;
end

% figure(1)
% 
% title('Données 2009');
% 
signal_a_tot_2009(:,1,:) = 2613.75 - signal_a_tot_2009(:,1,:);
signal_a_tot_2009(:,2,:) = 2613.75 +32.28 - signal_a_tot_2009(:,2,:);


% 
% hold on
% for i = 1:5
%     subplot(2,5,i)
%     plot(signal_a_tot_2009(:,1,i),z_a_tot_2009,'.r');
%     ylabel('Altitude en km');
%     xlabel('Signal');
%     subplot(2,5,i+5)
%     plot(signal_a_tot_2009(:,2,i),z_a_tot_2009,'.b');
%     ylabel('Altitude en m');
%     xlabel('Signal');
% end
% 
% figure(2)
% 
% title('Données 2013');
% 
% hold on
% for i = 1:5
%     subplot(2,5,i)
%     plot(signal_a_tot_2013(:,1,i),z_a_tot_2013,'.r');
%     ylabel('Altitude en km');
%     xlabel('Signal');
%     subplot(2,5,i+5)
%     plot(signal_a_tot_2013(:,2,i),z_a_tot_2013,'.b');
%     ylabel('Altitude en km');
%     xlabel('Signal');
% end
% 

signal_a_tot_2009_abs = squeeze(signal_a_tot_2009(:,1,:));
signal_a_tot_2009_nabs = squeeze(signal_a_tot_2009(:,2,:));

signal_c_tot_2009_abs = squeeze(signal_c_tot_2009(:,1,:));
signal_c_tot_2009_nabs = squeeze(signal_c_tot_2009(:,2,:));

% 
% figure
% 
% imagesc(signal_a_tot_2009_abs)
% colorbar
% set(gca, 'YDir', 'normal')
% caxis([0 500])
% 
% figure
% 
% imagesc(signal_a_tot_2009_nabs)
% colorbar
% set(gca, 'YDir', 'normal')
% caxis([0 500])
% 
signal_a_tot_2013_abs = squeeze(signal_a_tot_2013(:,1,:));
signal_a_tot_2013_nabs = squeeze(signal_a_tot_2013(:,2,:));

signal_c_tot_2013_abs = squeeze(signal_c_tot_2013(:,1,:));
signal_c_tot_2013_nabs = squeeze(signal_c_tot_2013(:,2,:));
% 
% figure
% 
% imagesc(signal_a_tot_2013_abs)
% colorbar
% set(gca, 'YDir', 'normal')
% caxis([50 250])
% 
% figure
% 
% imagesc(signal_a_tot_2013_nabs)
% colorbar
% set(gca, 'YDir', 'normal')
% caxis([50 100])
% 
% 
% 

signal_a_tot_2009_abs_moy = mean(signal_a_tot_2009_abs,2);
signal_a_tot_2009_nabs_moy = mean(signal_a_tot_2009_nabs,2);
signal_a_tot_2013_abs_moy = mean(signal_a_tot_2013_abs,2);
signal_a_tot_2013_nabs_moy = mean(signal_a_tot_2013_nabs,2);

signal_a_tot_2009_abs_std = std(signal_a_tot_2009_abs,0,2);
signal_a_tot_2009_nabs_std = std(signal_a_tot_2009_nabs,0,2);
signal_a_tot_2013_abs_std = std(signal_a_tot_2013_abs,0,2);
signal_a_tot_2013_nabs_std = std(signal_a_tot_2013_nabs,0,2);

signal_c_tot_2009_abs_moy = mean(signal_c_tot_2009_abs,2);
signal_c_tot_2009_nabs_moy = mean(signal_c_tot_2009_nabs,2);
signal_c_tot_2013_abs_moy = mean(signal_c_tot_2013_abs,2);
signal_c_tot_2013_nabs_moy = mean(signal_c_tot_2013_nabs,2);

signal_c_tot_2009_abs_std = std(signal_c_tot_2009_abs,0,2);
signal_c_tot_2009_nabs_std = std(signal_c_tot_2009_nabs,0,2);
signal_c_tot_2013_abs_std = std(signal_c_tot_2013_abs,0,2);
signal_c_tot_2013_nabs_std = std(signal_c_tot_2013_nabs,0,2);


% [r,c] = find(signal_a_tot_2009_abs_moy<0);
% signal_a_tot_2009_abs_moy(r) = 0;
% 
% [r,c] = find(signal_a_tot_2013_abs_moy<0);
% signal_a_tot_2013_abs_moy(r) = 0;


% figure
% subplot(2,2,1);
% plot(signal_a_tot_2009_abs_moy,z_a_tot_2009);
% hold on
% plot(signal_a_tot_2009_abs_moy-signal_a_tot_2009_abs_std,z_a_tot_2009,'-r');
% plot(signal_a_tot_2009_abs_moy+signal_a_tot_2009_abs_std,z_a_tot_2009,'-r');
% title('2009 absorbé');
% ylabel('Altitude en km');
% xlabel('Signal');
% subplot(2,2,2);
% plot(signal_a_tot_2009_nabs_moy,z_a_tot_2009);
% title('2009 non-absorbé');
% ylabel('Altitude en km');
% xlabel('Signal');
% subplot(2,2,3);
% plot(signal_a_tot_2013_abs_moy,z_a_tot_2013);
% title('2013 absorbé');
% ylabel('Altitude en km');
% xlabel('Signal');
% subplot(2,2,4);
% plot(signal_a_tot_2013_nabs_moy,z_a_tot_2013);
% title('2013 non absorbé');
% ylabel('Altitude en km');
% xlabel('Signal');

% figure
% subplot(2,1,1);
% hold on
% plot(signal_a_tot_2009_abs_std,z_a_tot_2009,'-r');
% plot(signal_c_tot_2009_abs_std,z_c_tot_2009,'-b');
% subplot(2,1,2);
% hold on
% plot(signal_a_tot_2013_abs_std,z_a_tot_2013,'-r');
% plot(signal_c_tot_2013_abs_std,z_c_tot_2013,'-b');


[r1,c] = find(z_a_tot_2009>7.4);
z_a_bruit_2009 = z_a_tot_2009(r1);
signal_a_bruit_2009_abs_moy = signal_a_tot_2009_abs_moy(r1);

p = polyfit(z_a_bruit_2009,signal_a_bruit_2009_abs_moy,4);
z_simul = 7.4:0.015:max(z_a_bruit_2009);
y_a_abs = polyval(p,z_simul);

%%%%%%%%%%%%%%%%%%

[r2,c] = find(z_a_tot_2009>7.4);
z_a_bruit_2009 = z_a_tot_2009(r2);
signal_a_bruit_2009_nabs_moy = signal_a_tot_2009_nabs_moy(r2);

p = polyfit(z_a_bruit_2009,signal_a_bruit_2009_nabs_moy,4);
z_simul = 7.4:0.015:max(z_a_bruit_2009);
y_a_nabs = polyval(p,z_simul);

%%%%%%%%%%%%%%%%%

[r3,c] = find(z_c_tot_2009>7.4);
z_c_bruit_2009 = z_c_tot_2009(r3);
signal_c_bruit_2009_abs_moy = signal_c_tot_2009_abs_moy(r3);

p = polyfit(z_c_bruit_2009,signal_c_bruit_2009_abs_moy,4);
z_simul = 7.4:0.015:max(z_c_bruit_2009);
y_c_abs = polyval(p,z_simul);

%%%%%%%%%%%%%%%%%

[r4,c] = find(z_c_tot_2009>7.4);
z_c_bruit_2009 = z_c_tot_2009(r4);
signal_c_bruit_2009_nabs_moy = signal_c_tot_2009_nabs_moy(r4);

p = polyfit(z_c_bruit_2009,signal_c_bruit_2009_nabs_moy,4);
z_simul = 7.4:0.015:max(z_c_bruit_2009);
y_c_nabs = polyval(p,z_simul);

%%%%%%%%%%%%%%%%%%

% figure
% hold on
% plot(signal_a_bruit_2009_abs_moy,z_a_bruit_2009,'b');
% plot(y,z_simul,'r');

%%%%%%%%%%%%

signal_a_sansbruit_2009_abs_moy = signal_a_tot_2009_abs_moy;
signal_a_sansbruit_2009_abs_moy(r1) = signal_a_tot_2009_abs_moy(r1)-signal_a_bruit_2009_abs_moy;

signal_a_sansbruit_2009_nabs_moy = signal_a_tot_2009_nabs_moy;
signal_a_sansbruit_2009_nabs_moy(r2) = signal_a_tot_2009_nabs_moy(r2)-signal_a_bruit_2009_nabs_moy;

signal_c_sansbruit_2009_abs_moy = signal_c_tot_2009_abs_moy;
signal_c_sansbruit_2009_abs_moy(r3) = signal_c_tot_2009_abs_moy(r3)-signal_c_bruit_2009_abs_moy;

signal_c_sansbruit_2009_nabs_moy = signal_c_tot_2009_nabs_moy;
signal_c_sansbruit_2009_nabs_moy(r4) = signal_c_tot_2009_nabs_moy(r4)-signal_c_bruit_2009_nabs_moy;

%%%%%%%%%%%%%

figure
hold on
plot(signal_a_tot_2009_abs_moy,z_a_tot_2009,'-b');
plot(signal_a_sansbruit_2009_abs_moy,z_a_tot_2009,'-r');

figure
subplot(2,2,1);
plot(signal_a_sansbruit_2009_abs_moy,z_a_tot_2009);
title('Analogique absorbé');
ylabel('Altitude en km');
xlabel('Signal');
subplot(2,2,2);
plot(signal_a_sansbruit_2009_nabs_moy,z_a_tot_2009);
title('Analogique non absorbé');
ylabel('Altitude en km');
xlabel('Signal');
subplot(2,2,3);
plot(signal_c_tot_2009_abs_moy,z_c_tot_2009);
title('Comptage absorbé');
ylabel('Altitude en km');
xlabel('Signal');
subplot(2,2,4);
plot(signal_c_tot_2009_nabs_moy,z_c_tot_2009);
title('Comptage non absorbé');
ylabel('Altitude en km');
xlabel('Signal');

G_a_abs = gradient(signal_a_sansbruit_2009_abs_moy.*(z_a_tot_2009).^2);
G_a_nabs = gradient(signal_a_sansbruit_2009_nabs_moy.*(z_a_tot_2009).^2);
G_c_abs = gradient(signal_c_sansbruit_2009_abs_moy.*(z_c_tot_2009).^2);
G_c_nabs = gradient(signal_c_sansbruit_2009_nabs_moy.*(z_c_tot_2009).^2);

figure
subplot(2,2,1)
plot(G_a_abs,z_a_tot_2009);
subplot(2,2,2)
plot(G_a_nabs,z_a_tot_2009);
subplot(2,2,3)
plot(G_c_abs,z_c_tot_2009);
subplot(2,2,4)
plot(G_c_nabs,z_c_tot_2009);

[r,c] = find(z_a_tot_2009>8)


G_ac_abs = G_a_abs;
G_ac_abs(r) = G_a_nabs;
