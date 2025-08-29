close all; clearvars; clc;

%% GENERATE DICTIONARY

M0 = 1;

% R2* [s^-1]
R2_min = 10; R2_step = 1; R2_max = 70;
R2s = R2_min:R2_step:R2_max;

% Δf [Hz]
deltaf_min = -50; deltaf_step = 1; deltaf_max = 50;
deltafs = deltaf_min:deltaf_step:deltaf_max;

% TE [s]
TE_min = 1e-3; TE_step = 0.5e-3; TE_max = 50e-3;
TEs = TE_min:TE_step:TE_max;

phase0s = 0;

[dict, dict_lut] = generateDictionary(M0, R2s, deltafs, TEs);


%% VIEW SAMPLE OF DICTIONARY ENTRIES

n_samples = 5; % number of dictionary patterns to check
idx_samples = round(linspace(1, size(dict, 1), n_samples));

% View complex patterns
fig(1) = figure;
hold on;
for k = 1:n_samples
    plot(real(dict(idx_samples(k), :)), ...
        imag(dict(idx_samples(k), :)), ...
        'DisplayName', sprintf('#%d: R2=%.1f, deltaf=%.1f', ...
        idx_samples(k), dict_lut(idx_samples(k), 1), dict_lut(idx_samples(k), 2)), ...
        'LineWidth', 1);
end
hold off;
daspect([1 1 1]);
grid on;
xlabel('Real');
ylabel('Imag');
legend show;
title('Sample Dictionary Entry Patterns');

% View magnitude patterns
fig(2) = figure;
hold on;
for k = 1:n_samples
    plot(TEs*1e3, abs(dict(idx_samples(k), :)), ...
        'DisplayName', sprintf('#%d: R2=%.1f, deltaf=%.1f', ...
        idx_samples(k), dict_lut(idx_samples(k), 1), dict_lut(idx_samples(k), 2)), ...
        'LineWidth', 1);
end
hold off;
xlabel('TE [ms]');
ylabel('Magnitude (M)');
legend show;
title('Sample Dictionary Entry Patterns');

% View phase patterns
fig(3) = figure;
hold on;
for k = 1:n_samples
    plot(TEs*1e3, angle(dict(idx_samples(k), :)), ...
        'DisplayName', sprintf('#%d: R2=%.1f, deltaf=%.1f', ...
        idx_samples(k), dict_lut(idx_samples(k), 1), dict_lut(idx_samples(k), 2)), ...
        'LineWidth', 1);
end
hold off;
xlabel('TE [ms]');
ylabel('Phase (\phi)');
legend show;
title('Sample Dictionary Entry Patterns');