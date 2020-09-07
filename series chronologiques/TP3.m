
%on veut s'affranchir de la saisonnalité, il faut que le taille de la
%moyenne glissante soit identitique à celle de la saisonnalité.
%une image toute les 15 minutes
%cycle de 24h
%il faut 96 images
%fenêtre 2s+1=97 -impaire car moyenne arithmétique centrée
%avec s=p/2 p=periode=96
%on aura 2980-96 points au total dans movingAverage

%moyenne mobile

clc
close all
load rad_moy
load rad_max
Xt=X
Xt_s=[]
%modéle additif
%lien d'independance dans les variables pas de modéle additif 
mean(Xt)
mean(Xm)
s=96
for i = 1+s/2:length(Xt)-s/2
Mov=mean(Xt((i-s/2):(i+s/2)));
Xt_s=[Xt_s,Mov];
end
Xt_s=Xt_s'
T=length(Xt_s);
t=1:length(Xt_s);
Xt=Xt(1+s/2:length(Xt)-s/2);


%%%%%
Xct=Xt-Xt_s
figure(1)
plot(Xct,'g')
hold on
plot(Xt_s,'r') 
hold on
plot (t,Xt)
hold on
plot(Xct,'g')
hold on


nc=floor(T/s); 
rm=mod(T,s);
mo= repmat((1:s)',nc,1)
mo=vertcat(mo,(1:rm)')
Cj=[];
% moyenne indices saisoniers
%---------%
for i=1:s
    I=find(mo==i);
   st=mean(Xct(I));
   Cj=[Cj,st];
end
% 
% Cj=Cj-mean(Cj)
% figure(2)
% plot(Cj,'m') 
% 
% st_hat=[repmat(Cj',nc,1):Cj(1:rm)');
% Xcvs=Xt-st_hat;
% 
% plot(Xcvs,'m')
