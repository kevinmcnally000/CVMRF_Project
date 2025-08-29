close all; clearvars; clc;


%% LOAD PHANTOM DATA

load('qsm_phantom_data/QSM_Phantom_Masked.mat');


%% RUN ARLO 

timer_start(1) = tic;

R2s_map_ref_3d = arlo(phantom_TEs, phantom_magnitude_4d);

phantom_arlo_time = toc(timer_start(1));


%% SAVE RESULTS

results.R2s_map_ref_3d = R2s_map_ref_3d;
results.phantom_arlo_time = phantom_arlo_time;

results_file = 'phantom_arlo_demo_results.mat';
% save(results_file, '-struct', 'results');


%% QUICKLY VIEW PARAMETER MAP

phantom_image_idx = 111;

fig(1) = figure; 
imagesc(R2s_map_ref_3d(:, :, phantom_image_idx)); 
colormap('hot'); 
colorbar; 
cl = clim; clim([0, cl(2)]);
axis image off; 
title('ARLO R2^* [s^{-1}]');