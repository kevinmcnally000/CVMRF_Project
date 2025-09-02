close all; clearvars; clc;


%% LOAD PHANTOM DATA

load('qsm_phantom_data/QSM_Phantom_Masked.mat');


%% RUN NLCFF 

timer_start(1) = tic;

[field_map_3d, field_map_3d_error, rel_residual, phase_0, n_iter] = ...
    Fit_ppm_complex_TE(phantom_4d, phantom_TEs);

% Convert field map to Δf map
deltaf_map_ref_3d = -field_map_3d ...
    / (phantom_TEs(2) - phantom_TEs(1)) / (2*pi);

phantom_nlcff_time = toc(timer_start(1));


%% SAVE RESULTS

results.deltaf_map_ref_3d = deltaf_map_ref_3d;
results.phantom_nlcff_time = phantom_nlcff_time;

results_file = 'phantom_nlcff_demo_results.mat';
% save(results_file, '-struct', 'results');


%% QUICKLY VIEW PARAMETER MAP

phantom_image_idx = 111;

fig(1) = figure; 
imagesc(deltaf_map_ref_3d(:, :, phantom_image_idx)); 
colormap('parula'); 
colorbar; 
axis image off; 
title('NLCFF \Deltaf [Hz]');