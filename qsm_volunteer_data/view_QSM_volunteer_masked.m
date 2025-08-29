close all; clearvars; clc;

load('QSM_volunteer_masked.mat');

TE_idx = 1;

% View magnitude image of volunteer
figure;
imagesc(volunteer_magnitude_mask_4d(:, :, image_idx, TE_idx));
colormap('gray');
axis image off;
title('Volunteer Magnitude');

% View phase image
figure;
imagesc(volunteer_phase_mask_4d(:, :, image_idx, TE_idx));
colormap('gray');
axis image off;
title('Volunteer Phase');