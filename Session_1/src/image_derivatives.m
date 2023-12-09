function [Ix,Iy,Idelta,Ig] = image_derivatives(I,Dx,Dy,L)
% INPUTS
%    I (nr x nc): double-precision image
%    Dx(nr.nc x nr.nc): matrix approximating differentiation in the horizontal direction
%    Dy(nr.nc x nr.nc): matrix approximating differentiation in the vertical direction
%    L(nr.nc x nr.nc): matrix approximating the Laplacian
% OUTPUTS
%    Ix (nr x nc): image of the x-derivative of I
%    Iy (nr x nc): image of the y-derivative of I
%    Idelta (nr x nc): image of the laplacian of I
%    Ig (nr x nc): image of the norm of the gradient of I

	% Get the image size
	[nr,nc] = size(I);
	
	% Vectorize the nr x nc image into a (nr*nc x 1) vector, columnwise
	u = I(:);
	
	% Compute the image derivatives in the x direction by applying the derivative linear operator
	Ix = Dx*u; % nx1 vector containing the x-derivatives
	
	% Reshape the vector of x-derivatives into an image
	Ix = reshape(Ix,nr,nc); % reshape into an image
	
	% Now do the same to compute Iy, Idelta, and Ig
	Iy = Dy*u;
    Iy = reshape(Iy,nr,nc);

    Idelta = L * u;
    Idelta = reshape(Idelta, nr , nc);

    Ig = sqrt(Ix.^2 + Iy.^2);
    
	
	
	
end
