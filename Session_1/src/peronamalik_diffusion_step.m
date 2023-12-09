function [I,G] = linear_diffusion_step(I,Dx,Dy,lambda,delta_t)
% INPUTS
%    I(nr x nc): image at time t
%    Dx, Dy(nr.nc x nr.nc): matrices approximating the gradient operator
%    lambda (1 x 1): smoothing parameter
%    delta_t(1 x 1): stepsize
% OUTPUTS
%    I(nr x nc): image at time t+1
%    G(nr x nc): diffusivity map at time t
u_t = I(:);
Id = speye(size(I).^2); % Identity matrix
L = -Dx' * Dx - Dy' * Dy;
[Ix,Iy,Idelta,Ig] = image_derivatives(I,Dx,Dy,L);

g = exp(-(Ig.^2)/lambda^2);

Dg = spdiags(g(:), 0, numel(I), numel(I));
M = speye(size(Id));
u_tp1 = pcg((Id - delta_t * (-Dx' * Dg * Dx - Dy' * Dg * Dy)), u_t, [], [], M);

I = reshape(u_tp1, size(I));
G = reshape(g, size(I));
end
