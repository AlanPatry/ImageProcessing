function I = linear_diffusion_step(I,L,delta_t,method)
% INPUTS
%    I(nr x nc): image at time t
%    L(nr.nc x nr.nc): matrix approximating the Laplacian
%    delta_t(1 x 1): stepsize
% OUTPUTS
%    I(nr x nc): image at time t+1
    
Id = speye(size(L)); % Identity matrix
size_I = size(I);

if strcmp(method, 'explicit')
    % Explicit diffusion
    I = I(:) + delta_t * (L * I(:));
elseif strcmp(method, 'implicit')
    % Implicit diffusion
    I = pcg(Id - delta_t * L, I(:));
else
    error('Invalid diffusion method. Use ''explicit'' or ''implicit''.');
end

I = reshape(I,size_I);
	
end
