clear
close all

% Mise en place de la figure pour affichage :
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);
figure('Name','Debruitage par variation totale',...
       'Position',[0.06*L,0.1*H,0.9*L,0.7*H]);
      

             
% Parametres
lambda = 0.0125;			% Poids de la regularisation       
epsilon = 0.001; 		% Parametre pour garantir la differentiabilite de la variation totale :
u0 = double(imread('fleur_avec_defaut.png'));
D = (imread('defaut_fleur.png'));
D = D>0;
critere_arret_convergence = 1e-4;

% Normalisation de l'image entre 0 et 1
u_max = max(u0(:));
u0 = u0/u_max;

% Vectorisation de u0 
[nb_lignes,nb_colonnes,nb_canaux] = size(u0)
nb_pixels = nb_lignes*nb_colonnes;
u0 = reshape(u0,[nb_pixels nb_canaux]);
D = reshape(D, [nb_pixels, 1]);

% Operateurs de differences finies 2D (cf. TP 1):
[Dx,Dy,Lap] = finite_differences_2D(nb_lignes,nb_colonnes);

% Tableau pour stocker les criteres d'arret a chaque iteration
tab_t = [0];
tab_convergence = [NaN];

% Affichage de l'image, de l'image restauree et du critere de convergence :
subplot(1,3,1)
	imagesc(max(0,min(1,reshape(u0,nb_lignes,nb_colonnes,nb_canaux))),[0 1])
	colormap gray
	axis image off
	title('Image bruitee','FontSize',20)   
subplot(1,3,2)
p2=	imagesc(max(0,min(1,reshape(u0,nb_lignes,nb_colonnes,nb_canaux))),[0 1]);
	axis image off
	title('Image restauree','FontSize',20) 
	p2.CData = max(0,min(1,u0));
subplot(1,3,3)
	p3 = semilogy(tab_t,tab_convergence); 
	axis tight
	xlabel('Iterations','Interpreter','Latex','Fontsize',14)
	ylabel('$$\frac{\left\| u_{k+1}-u_k \right\|}{\left\| u_0 \right\|}$$','Interpreter','Latex','Fontsize',14)
	title('Convergence','FontSize',20)
	p3.XDataSource = 'tab_t';
	p3.YDataSource = 'tab_convergence';
drawnow 



% Schema iteratif :
u_k = u0;
u_kp1 = u0;
convergence = Inf;
iteration = 0;

W = spdiags(~D, 0, nb_pixels, nb_pixels);

while convergence > critere_arret_convergence
	
	% Incrementation du nombre d'iterations :
	iteration = iteration + 1;
	tab_t = [tab_t,iteration];


	% Pas de variation totale (Eq. 6)
    for i = 1:3
	    u_kp1(:,i) = pas_inpainting(u0(:,i),u_k(:,i),lambda,Dx,Dy,epsilon,critere_arret_convergence, W);
    end
	% Test de convergence :
	convergence = norm(u_kp1-u_k)/norm(u0);
	tab_convergence = [tab_convergence, convergence];
	
	% Mise a jour de l'image courante u_k :
	u_k = u_kp1;

	% Affichage de l'image restauree a chaque iteration :
	set(p2, 'CData', reshape(u_k,[nb_lignes nb_colonnes,nb_canaux]));
	
	% Affichage du critere d'arret
	refreshdata(p3);
	
	% Mise a jour des plots
	pause(0.1)
	drawnow
end



% Enregistrement du resultat    
imwrite(max(0,min(1,reshape(u_k,[nb_lignes nb_colonnes,nb_canaux]))),...
        'resultat_exercice_2.png')
