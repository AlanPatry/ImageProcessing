clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

% Lecture et affichage de l'image source s :
s = rgb2lab(imread('rose.jpg'));
[nb_lignes_s,nb_colonnes_s,nb_canaux] = size(s);
hfig = figure('Name','Image source','Position',[0.06*L,0.1*H,0.9*L,0.75*H]);
imagesc(lab2rgb(s));
axis image off;

% Selection et affichage d'un polygone p dans s :
disp('Selectionnez un polygone (entree pour valider)');
[x_p,y_p] = draw_polygon(hfig);
[x,y] = meshgrid(1:size(s,2),1:size(s,1)); 
p = reshape(inpolygon(x(:),y(:),x_p,y_p),size(s,1),size(s,2));

% Bornes du rectangle englobant de p :
i_p = min(max(round(y_p),1),nb_lignes_s);
j_p = min(max(round(x_p),1),nb_colonnes_s);
i_p_min = min(i_p(:));
i_p_max = max(i_p(:));
j_p_min = min(j_p(:));
j_p_max = max(j_p(:));

% Lecture et affichage de l'image cible c :
c = s;
c(:, :, 3) = 0;
c(:, :, 2) = 0;
[nb_lignes_c,nb_colonnes_c,nb_canaux] = size(c);
figure('Name','Image cible','Position',[0.06*L,0.1*H,0.9*L,0.75*H]);
imagesc(lab2rgb(c));
axis image off;

% Sous-matrice de c correspondant au rectangle r :
r = c(i_p_min:i_p_max,j_p_min:j_p_max,:);

% Seules les sous-matrices a l'interieur du rectangle englobant de p sont conservees :
s = s(i_p_min:i_p_max,j_p_min:j_p_max,:);
p = p(i_p_min:i_p_max,j_p_min:j_p_max);

% Redimensionnement de s et p aux dimensions de r :
[nb_lignes_r,nb_colonnes_r,nb_canaux] = size(r);
s = imresize(s,[nb_lignes_r,nb_colonnes_r]);
p = imresize(p,[nb_lignes_r,nb_colonnes_r]);

% Calcul et affichage de l'image resultat u :
u = c;
interieur = find(p>0);
u(i_p_min:i_p_max,j_p_min:j_p_max,:) = collage(r,s,interieur);
figure('Name','Image resultat','Position',[0.06*L,0.1*H,0.9*L,0.75*H]);
imagesc(lab2rgb(u));
axis image off;
