function [dict, dict_lut] = generateDictionary(M0, R2s, deltafs, TEs)
        
% Create grid of R2* and Δf values
[R2s_grid, deltafs_grid] = ndgrid(R2s, deltafs);

% Convert grids to vectors
R2s_1d = R2s_grid(:);
deltafs_1d = deltafs_grid(:);
TEs_1d = TEs(:)';
phase0s_1d = 0; % add later as extra parameter

% Calculate magnitude and phase for all R2 and Δf combinations
magnitude = M0 .* exp(-R2s_1d .* TEs_1d);
phase = 2 * pi * deltafs_1d .* TEs_1d + phase0s_1d;

% Combine to calculate dictionary of complex signals
dict = magnitude .* exp(1i .* phase); % S(t) = M .* exp(1i .* phi);

% Store corresponding R2* and Δf values
dict_lut = [R2s_1d, deltafs_1d];

end