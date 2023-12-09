clear
close all

% Problem setup
t_max = 100; % Max number of time steps
delta_t = 0.015; % Time stepsize
std_noise = 0.01; % Standard deviation of the Gaussian noise added to the image
lambda = 28; % Perona-Malik parameter

% Load a grayscale image
I0 = imread('..\\img\\cameraman_avec_bruit.tif'); % Load the noised image
I0 = double(I0); % Convert to double precision

IG = imread('..\\img\\cameraman.jpg'); % Load the original image

[nr,nc] = size(I0); % Problem size

% Load finite difference matrices for this problem size
[Dx,Dy,L] = finite_differences_2D(size(I0,1),size(I0,2)); 

% Initialization of the solution
I = I0;
G = zeros(size(I));

% Plot the current result

figure(1)

subplot(1,5,1)
imagesc(I0_Gray,[0 255]);
colormap gray
axis image
title('Original')

subplot(1,5,2)
p2 = imagesc(I0,[0 255]);
colormap gray
axis image
title('Noisy image')

subplot(1,5,3)
p3 = imagesc(I,[0 255]);
colormap gray
axis image
title(sprintf('Current filtered image'))

subplot(1,5,4)
p4 = imagesc(G,[0 1]);
colormap gray
axis image
title(sprintf('Current diffusivity'))

subplot(1,5,5)
p5 = imagesc(I0 - I,[0 255]);
colormap gray
axis image
title(sprintf('Image Difference'))

progressbar(0)
for t = 1:t_max 
	
	progressbar(t/t_max)
	
	% Do one diffusion step
	[I,G] = peronamalik_diffusion_step(I,Dx,Dy,lambda,delta_t);

	% Update the plots
	set(p3, 'CData', I);
	set(p4, 'CData', G);
    set(p5, 'CData', I0 - I);
	pause(0.1)
	drawnow
	
    
	
end

