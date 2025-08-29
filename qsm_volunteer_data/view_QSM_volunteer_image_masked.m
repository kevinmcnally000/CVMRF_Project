close all; clearvars; clc;

load('QSM_volunteer_image_masked.mat');

TE_idx = 1;

% View magnitude image of volunteer
figure;
imagesc(volunteer_magnitude_mask_3d(:, :, TE_idx));
colormap('gray');
axis image off;
title('Volunteer Magnitude');

% View phase image
figure;
imagesc(volunteer_phase_mask_3d(:, :, TE_idx));
colormap('gray');
axis image off;
title('Volunteer Phase');