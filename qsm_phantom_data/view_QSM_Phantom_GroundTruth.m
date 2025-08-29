close all; clearvars; clc;

load('QSM_Phantom_GroundTruth.mat');

image_idx = 104;

% View true R2* map
fig(1) = figure; 
imagesc(true_R2s_mask_3d(:, :, image_idx)); 
colormap('hot'); 
colorbar; 
axis image off; 
cl = clim; clim([0, cl(2)]);
title('Phantom True R2^* [s^{-1}]');

% View true ΔB0 map
fig(2) = figure; 
imagesc(true_deltaB0s_mask_3d(:, :, image_idx)); 
colormap('parula'); 
colorbar; 
axis image off;
title('Phantom True \DeltaB0 [Hz]');