function [Dx,Dy,L] = finite_differences_2D(nr,nc)
% INPUTS
%    nr,nc (1 x 1): number of rows and columns
% OUTPUTS
%    Dx(nr.nc x nr.nc): matrix approximating differentiation in the horizontal direction
%    Dy(nr.nc x nr.nc): matrix approximating differentiation in the vertical direction
%    L(nr.nc x nr.nc): matrix approximating the Laplacian

	% Solution for Dx, as seen in lecture:
	Dx = spdiags([-ones(nr*nc,1) ones(nr*nc,1)],[0 nr],nr*nc,nr*nc); % Bi-diagonal matrix -- cf. doc of spdiags
	Dx(nr*nc-nr+1:1:end,:) = 0; % Set the nr last rows to zero

	% Solution for Dy:
    Dy = spdiags([-ones(nr * nc, 1), ones(nr * nc, 1)], [0, 1], nr * nc, nr * nc); % Bi-diagonal matrix
    Dy(nr:nr:nr*nc,:) = 0; % Set the last nr rows to zero

    % Solution for L:
    L = -Dx' * Dx -Dy' * Dy;
	
	
	
	
	
	
end 
