close all; clearvars; clc;


%% LOAD PHANTOM DATA

load('qsm_phantom_data/QSM_Phantom_SingleSlice.mat');

timer_start(1) = tic;
%% GENERATE DICTIONARY

timer_start(2) = tic;

M0 = 1;

R2_min = 1; R2_step = 1; R2_max = 100;
R2s = R2_min:R2_step:R2_max;

deltaf_min = -50; deltaf_step = 1; deltaf_max = 50;
deltafs = deltaf_min:deltaf_step:deltaf_max;

TEs = phantom_TEs;

phase0s = 0;

[dict, dict_lut] = generateDictionary(M0, R2s, deltafs, TEs);

dict_generation_time = toc(timer_start(2));


%% PATTERN MATCHING

timer_start(3) = tic;

par_maps = ...
    patternMatching(phantom_3d, dict, dict_lut, phantom_brain_mask_2d);

pattern_matching_time = toc(timer_start(3));

phantom_image_cvmrf_time = toc(timer_start(1));


%% SAVE RESULTS

results.par_maps = par_maps;
results.dict_generation_time = dict_generation_time;
results.pattern_matching_time = pattern_matching_time;
results.phantom_image_cvmrf_time = phantom_image_cvmrf_time;

results_file = 'phantom_image_cvmrf_demo_results.mat';
% save(results_file, '-struct', 'results');


%% QUICKLY VIEW PARAMETER MAPS

fig(1) = figure; 
imagesc(par_maps.R2s_map); 
colormap('hot'); 
colorbar; 
axis image off; 
title('CV-MRF R2^* [s^{-1}]');

fig(2) = figure; 
imagesc(par_maps.deltafs_map); 
colormap('parula'); 
colorbar; 
axis image off; 
title('CV-MRF \Deltaf [Hz]');