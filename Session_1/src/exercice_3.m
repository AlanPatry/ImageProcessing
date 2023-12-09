clear
close all

% Problem setup
t_max = 100; % Max number of time steps
delta_t = 1; % Time stepsize
std_noise = 0.01; % Standard deviation of the Gaussian noise added to the image

% Load a grayscale image
I0 = imread('..\\img\\mandril_color.tif'); % Load an RGB image
I0 = rgb2gray(I0); % Convert to grayscale
I0 = double(I0); % Convert to double precision
I0 = 255*imnoise(I0/255,'gaussian',0,std_noise); % Add noise with std 1%

[nr,nc] = size(I0); % Problem size


% Load finite difference matrices for this problem size
[Dx,Dy,L] = finite_differences_2D(size(I0,1),size(I0,2)); 

% Initialization of the solution at time t=0
I = I0; 

% Norm of the Laplacian at time t=0
tab_t = [0];
norm_lap_I0 = norm(L*I0(:));
tab_norm_lap = [norm_lap_I0];

% Plot the current result
figure(1)
subplot(1,4,1)
imagesc(I0,[0 255]);
colormap gray
axis image
title('Graylevel image')

subplot(1,4,2)
p2 = imagesc(I,[0 255]);
colormap gray
axis image
title(sprintf('Current filtered image'))

subplot(1,4,3)
p3 = imagesc(I0 - I,[0 255]);
colormap gray
axis image
title(sprintf('Image difference'))

subplot(1,4,4)
p4 = semilogy(tab_t,tab_norm_lap); 
axis tight
xlabel('Iterations','Interpreter','Latex','Fontsize',14)
ylabel('$$\frac{\left\| \Delta u \right\|}{\left\| \Delta u_0 \right\|}$$','Interpreter','Latex','Fontsize',14)
title('Laplacian evolution')
drawnow 

p2.CData = I;
p4.XDataSource = 'tab_t';
p4.YDataSource = 'tab_norm_lap';

progressbar(0)
for t = 1:t_max 
	
	progressbar(t/t_max)
	
	tab_t = [tab_t,t];
	
	% Do one diffusion step
	I = linear_diffusion_step(I,L,delta_t,'implicit');
	
	% Compute the norm of the Laplacian at current iteration
	tab_norm_lap = [tab_norm_lap, norm(L*I(:))/norm_lap_I0];
	
	% Update the displayed filtered image	
	set(p2, 'CData', I);
	% Update the difference
	set(p3, 'CData', I0 - I);
	
	% Update the difference and Laplacian plot
	refreshdata(p4);
	
	% Draw all
	pause(0.05)
	drawnow
	
end

