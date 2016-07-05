% Setup input parameters
volSize = [128 128 128];
noiseSig = 0.1;
proximity_sigma = 1*[1 1 0.2]; % Cheat and filter strongest in z where phantom is identical
filt_radius = [3 3 15];
intensity_sigma = 0.2;

% Create noisy input volume
unfiltVol = repmat(phantom(volSize(1),volSize(2)),[1 1 volSize(3)]);
unfiltVol = unfiltVol + normrnd(0,noiseSig,size(unfiltVol));

% Filter noisy input volume and time calculations
tic
filtVol = bilateralFilterND(unfiltVol, filt_radius, proximity_sigma, intensity_sigma, uint32(1));
filterTime = toc 

% Show result
figure()
subplot(1,2,1)
imagesc(unfiltVol(:,:,64)); 
axis image; 
axis off; 
colormap(gray);
title('Before Bilateral Filtering');
subplot(1,2,2)
imagesc(filtVol(:,:,64)); 
axis image; 
axis off; 
colormap(gray);
title('After Bilateral Filtering');


