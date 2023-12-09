function u_kp1 = pas_inpainting(u0,u_k,lambda,Dx,Dy,epsilon,eta,wD)
% INPUTS: 
%   u0 (n x 1)      : signal a debruiter
%   u_k (n x 1)     : signal debruite a l'iteration k 
%   lambda (1 x 1)  : parametre de regularisation 
%   Dx (n x n)      : operateur de differences finies horizontales
%   Dy (n x n)      : operateur de differences finies verticales
%   epsilon (1 x 1) : regularisation de la valeur absolue pour eviter les divisions par zero
%   eta (1 x 1)     : critere d'arret pour evaluer la convergence
%   wD () : 
%
% OUTPUTS:
%   u_kp1 (n x 1)   : signal debruite a l'iteration k+1


    Id = speye(size(u0,1)); % Identity matrix
    
    w = 1 ./ sqrt((Dx * u_k).^2 + (Dy * u_k).^2 + epsilon); 
    W = spdiags(w, 0);

    [u_kp1,f1] = pcg((wD - lambda * (-Dx' * W * Dx - Dy' * W * Dy)), wD*u0, eta, 100, [], [], u_k);

end
