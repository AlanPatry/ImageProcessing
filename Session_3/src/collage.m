function u = collage(r,s,interieur)

% Conversion au format double :
r = double(r);
s = double(s);

% Dimensions de r :
[nb_lignes_r,nb_colonnes_r,nb_canaux_r] = size(r);

% Contours de la matrice r
contours_r = contours_matrice(r(:,:,1));

% Calcul opérateur Laplacien
[Dx,Dy,L] = finite_differences_2D(nb_lignes_r,nb_colonnes_r);
Id = speye(size(L)); % Identity matrix

A = L;
A(contours_r,:) = Id(contours_r,:);
size(contours_r)
% Calcul de l'image resultat im, canal par canal :
u = r;
for k = 1:nb_canaux_r
	s_k = s(:,:,k);
    r_k = r(:,:,k);

    g_x_k = Dx * r_k(:);
    g_x_k(interieur,:) = Dx(interieur,:) * s_k(:);

    g_y_k = Dy * r_k(:);
    g_y_k(interieur,:) = Dy(interieur,:) * s_k(:);

    b_k = div(g_x_k, g_y_k, Dx, Dy);
    b_k(contours_r) = r_k(contours_r);

	u(:,:,k) = reshape(A\b_k,nb_lignes_r,nb_colonnes_r);
end


