close all; clearvars; clc;

load('QSM_volunteer_masked.mat');

TE_idx = 1;

% View magnitude image of volunteer
fig(1) = figure;
imagesc(volunteer_magnitude_mask_4d(:, :, image_idx, TE_idx));
colormap('gray');
cl = clim; clim = ([0, cl(2)]); % magnitude can't be -ve
axis image off;
title('Volunteer Magnitude');

% View phase image
fig(2) = figure;
imagesc(volunteer_phase_mask_4d(:, :, image_idx, TE_idx));
colormap('gray');
axis image off;
title('Volunteer Phase');