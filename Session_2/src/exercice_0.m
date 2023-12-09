clear
close all

% Mise en place de la figure pour affichage :
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);
figure('Name','Debruitage avec le modele de Tikhonov', ...
       'Position',[0.06*L,0.1*H,0.9*L,0.7*H]) 


       
% Parametres
lambda = 3;	 % Poids de la regularisation       
u0 = double(imread('cameraman_avec_bruit.tif')); % Image a debruiter



% Normalisation de l'image entre 0 et 1
u_max = max(u0(:));
u0 = u0/u_max;

% Affichage de l'image bruitee :
subplot(1,2,1)
	imagesc(max(0,min(1,u0)),[0 1])
	colormap gray
	axis image off
	title('Image bruitee','FontSize',20)



% Variables auxiliaires
[nb_lignes,nb_colonnes,nb_canaux] = size(u0);
nb_pixels = nb_lignes*nb_colonnes;
    
% Vectorisation de u0 :
u0 = reshape(u0,[nb_pixels 1]);

% Operateurs de differences finies 2D (cf. TP 1):
[Dx,Dy,Lap] = finite_differences_2D(nb_lignes,nb_colonnes);

% Matrice A du systeme :
A = speye(nb_pixels) - lambda*Lap;

% Second membre b du systeme :
b = u0;

% Resolution du systeme A*u = b :
% u = A\b; % Appelle la factorisation de Cholesky creuse
[u,fl] = pcg(A,b,1e-4,100,[],[],u0); % Appelle le gradient conjugue

% Affichage de l'image restauree :
subplot(1,2,2)
	imagesc(max(0,min(1,reshape(u,[nb_lignes nb_colonnes]))),[0 1])
	colormap gray
	axis image off
	title('Image restauree','FontSize',20)
 
% Enregistrement du resultat    
imwrite(max(0,min(1,reshape(u,[nb_lignes nb_colonnes]))),...
        'resultat_exercice_0.png')
