%Figure 2a - spike density functions for all included cells across the
%trial period

load('...data\SDF data\ssd_sdf_zNorm_xLong.mat')
load('...data\rtData.mat')
nTrials = table2array(numTrialsInEachCondition);

filter = logical(ones(91, 1));
for ii = 1:91
    if any(nTrials(ii, :) < 10) || any(isnan(nTrials(ii, :)))

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

%% get reaction time data
rt = rtFromReaf(~(isnan(rtFromReaf)));

%% 
figure %reafferent event epoch
plot_noNoisePriors_sdf(reafZ, filter, reafferentWindow)
hold on
%superimpose reaction time data
errorbar(median(rt), 0.55, median(rt) - quantile(rt, 0.25), median(rt) - quantile(rt, 0.75), 'horizontal', 'ko-')
xlim(reafferentWindow)
title('reaf')
ylim([-0.2 0.6])
yticks([0 0.3 0.6])
xticks([0 400 800])
line([0 0], [-0.2 0.6], 'color', 'k', 'LineWidth', 1)
