close all; clearvars; clc;

%% LOAD PHANTOM DATA

load('qsm_volunteer_data/QSM_volunteer_masked.mat');

timer_start(1) = tic;


%% GENERATE DICTIONARY

timer_start(2) = tic;

% Initial magnetisation
M0 = 1;

% R2 values [s^-1]
R2_min = 1; R2_step = 1; R2_max = 90;
R2s = R2_min:R2_step:R2_max;

% Δf values [Hz] 
deltaf_min = -50; deltaf_step = 1; deltaf_max = 50;
deltafs = deltaf_min:deltaf_step:deltaf_max;

% TE values [s]
TEs = volunteer_TEs_1d;

% Initial phase offset
phase0s = 0;

[dict, dict_lut] = generateDictionary(M0, R2s, deltafs, TEs);

dict_generation_time = toc(timer_start(2));


%% PATTERN MATCHING

timer_start(3) = tic;

par_maps = ...
    patternMatching(volunteer_4d, dict, dict_lut, volunteer_brain_mask_3d);

pattern_matching_time = toc(timer_start(3));

volunteer_cvmrf_time = toc(timer_start(1));


%% SAVE RESULTS

results.par_maps = par_maps;
results.dict_generation_time = dict_generation_time;
results.pattern_matching_time = pattern_matching_time;
results.volunteer_cvmrf_time = volunteer_cvmrf_time;

results_file = 'volunteer_cvmrf_demo_results.mat';
% save(results_file, '-struct', 'results');


%% QUICKLY VIEW PARAMETER MAPS

image_idx = 111;

fig(1) = figure; 
imagesc(par_maps.R2s_map(:, :, image_idx)); 
colormap('hot'); 
colorbar;  
cl = clim; clim = ([0, cl(2)]); % R2* can't be -ve
axis image off;
title('CV-MRF R2^* [s^{-1}]');

fig(2) = figure; 
imagesc(par_maps.deltafs_map(:, :, image_idx)); 
colormap('parula'); 
colorbar; 
axis image off; 
title('CV-MRF \Deltaf [Hz]');