%Figure S4 - spike density functions in the no noise condition with jump
%size restricted to 0. 
load('...data\SDF data\ssd_sdf_zNorm_xLong_zeroJS.mat')
nTrials = table2array(numTrialsInEachCondition);

filter = logical(ones(91, 1));
for ii = 1:91
    if any(nTrials(ii, :) < 5) || any(isnan(nTrials(ii, :)))

        filter(ii) = 0;
    end
end

fixWindow = [-5, 250];
probeWindow = [-100, 500];
interveningSaccadeWindow = [-150, 0];
reafferentWindow = [-200, 900];

figure %fixation epoch
plot_noNoisePriors_sdf(fixZ, filter, fixWindow)
xlim(fixWindow)
title('fix')
ylabel('Normalized firing rate (z-score)')
ylim([-0.2 0.6])
yticks([0 0.3 0.6])
xticks([0 100 200])
line([0 0], [-0.2 0.6], 'color', 'k', 'LineWidth', 1)

figure %probe epoch
plot_noNoisePriors_sdf(probeZ, filter, probeWindow)
xlim(probeWindow)
title('probe')
ylim([-0.2 0.6])
yticks([0 0.3 0.6])
xticks([0 200 400])
line([0 0], [-0.2 0.6], 'color', 'k', 'LineWidth', 1)

figure %intervening saccade epoch
plot_noNoisePriors_sdf(intZ, filter, interveningSaccadeWindow)
xlim(interveningSaccadeWindow)
title('int saccade')
ylim([-0.2 0.6])
yticks([0 0.3 0.6])
xticks([-100 0])
line([0 0], [-0.2 0.6], 'color', 'k', 'LineWidth', 1)


%% 
figure %reafferent event epoch
plot_noNoisePriors_sdf(reafZ, filter, reafferentWindow)
hold on
xlim(reafferentWindow)
title('reaf')
ylim([-0.2 0.6])
yticks([0 0.3 0.6])
xticks([0 400 800])
line([0 0], [-0.2 0.6], 'color', 'k', 'LineWidth', 1)
