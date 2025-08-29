close all; clearvars; clc;

load('QSM_Phantom_Masked.mat');

image_idx = 104;
TE_idx = 1;

% View magnitude image of phantom
figure;
imagesc(phantom_magnitude_4d(:, :, image_idx, TE_idx));
colormap('gray');
axis image off;
title('Phantom Magnitude');

% View phase image
figure;
imagesc(phantom_phase_4d(:, :, image_idx, TE_idx));
colormap('gray');
axis image off;
title('Phantom Phase');