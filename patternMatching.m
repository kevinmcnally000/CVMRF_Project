function par_maps = patternMatching(MR_data, dict, dict_lut, brain_mask)

% Get MR data dimensions
dims = ndims(MR_data);
if dims == 4
    [n_x, n_y, n_z, n_TE] = size(MR_data);
    spatial_dims = [n_x, n_y, n_z];
    n_voxels = n_x .* n_y .* n_z;
elseif dims == 3
    [n_x, n_y, n_TE] = size(MR_data);
    spatial_dims = [n_x, n_y];
    n_voxels = n_x .* n_y;
else
    error('Error: MR_data must be 3D or 4D.');
end

% Extract MR signals for processing

if isempty(brain_mask)
    fprintf('No brain mask provided. Creating default mask...\n');
    brain_mask = true(spatial_dims);
end

brain_mask = logical(brain_mask); % ensures logical brain mask
MR_data_2d = reshape(MR_data, n_voxels, n_TE);
signals = MR_data_2d(brain_mask(:), :);

n_signals = size(signals, 1);

% Normalise signals and dictionary
signals_norm = signals ./ vecnorm(signals, 2, 2);
dict_norm = dict ./ vecnorm(dict, 2, 2);

% Matching preparation
dict_entry_match = zeros(n_signals, 1);
dict_entry_match_idx = zeros(n_signals, 1);
progress_steps = ceil((1:n_signals) ./ n_signals * 100); % create a progress tracker

fprintf('Dictionary matching starting...\n');

for s = 1:n_signals

    % Print status every 10%
    if mod(s, floor(n_signals / 10)) == 0
        fprintf('%d%% completed.\n', progress_steps(s));
    end

    % Extract single signal
    signal_norm = signals_norm(s, :);

    % Compute dot products (similarity scores) of dictionary and signal
    dps = abs(dict_norm * signal_norm');

    % Find max dot product / highest similarity score and index
    [dict_entry_match(s), dict_entry_match_idx(s)] = max(dps, [], 1); % extract max dot products and their row indices

end 

dict_entry_match = dict_entry_match(:); % ensure column vector for clearer indexing
dict_entry_match_idx = dict_entry_match_idx(:);

% Build parameter maps
R2s_map_2d = zeros(n_voxels, 1);
deltafs_map_2d = zeros(n_voxels, 1);

R2s_map_2d(brain_mask(:)) = dict_lut(dict_entry_match_idx, 1);
deltafs_map_2d(brain_mask(:)) = dict_lut(dict_entry_match_idx, 2);

% Reshape to spatial dimensions
par_maps.R2s_map = reshape(R2s_map_2d, spatial_dims);
par_maps.deltafs_map = reshape(deltafs_map_2d, spatial_dims);

fprintf('Dictionary matching complete.\n');

end