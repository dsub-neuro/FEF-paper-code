%% Figure S7 a - b. PSTHs aligned to the fixation and probe epochs in the no saccade condition.

load('...data\SDF data\ssd_sdf_zNorm_xLong.mat')
nTrials = table2array(numTrialsInEachCondition);

filter = logical(ones(91, 1));
for ii = 1:91
    if any(nTrials(ii, :) < 10) || any(isnan(nTrials(ii, :)))

        filter(ii) = 0;
    end
end

fixWindow = [-5, 250];
probeWindow = [-100, 500];

figure
plot_noSacPriors_sdf(fixZ, filter, fixWindow)
xlim(fixWindow)
title('fix')
ylabel('Normalized firing rate (z-score)')
ylim([-0.2 0.6])
yticks([0 0.3 0.6])
xticks([0 200 400])
line([0 0], [-0.2 0.6], 'color', 'k', 'LineWidth', 1)

figure
plot_noSacPriors_sdf(probeZ, filter, probeWindow)
xlim(probeWindow)
title('probe')
ylim([-0.2 0.6])
yticks([0 0.3 0.6])
xticks([-200 0 400 800])
line([0 0], [-0.2 0.6], 'color', 'k', 'LineWidth', 1)

%% Figure S7c - plot neuron-behavior correlations in the probe epoch for the no saccade condition

load('...data\effectSizes_probeLong.mat')
load('...data\effectSizes_nonParametric_reafLong.mat')
load('...data\effectSizes_pVal_fix_reafLong.mat')
load('...\numTrialsByCondition.mat')

nTrials = table2array(numTrialsInEachCondition);

filter = logical(ones(91, 1));
for ii = 1:91
    if any(nTrials(ii, :) < 10) || any(isnan(nTrials(ii, :)))

        filter(ii) = 0;
    end
end

xNewVN = linspace(-0.5, 1.5, 100)';
%set up data
data = neuralEffReaf;
sigData = reafferentEpoch.pVal;
sigNeurons = sigData < 0.025;
bigEffectSize = sigNeurons & filter;

%behavior
noSacBehNorm = behaviorEff.noSac(bigEffectSize)./behaviorEff.noNoise(bigEffectSize);
%no saccade probe
noSacProbe = neuralEffProbe.noSac(bigEffectSize)./data.noNoise(bigEffectSize);

%plot correlations
[lineNoSacProbe, negErrorNoSacProbe, posErrorNoSacProbe] = reg_line_ci(noSacProbe, noSacBehNorm,  xNewVN);
figure
plot(noSacProbe, noSacBehNorm, 'o', 'color', [0.6 0.6 0.6], 'MarkerSize', 8, 'LineWidth', 2)
hold on
shadedErrorBar(xNewVN, lineNoSacProbe, [negErrorNoSacProbe, posErrorNoSacProbe], 'lineProps', {'LineWidth', 3, 'color', 'k'})
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
ylim([0 1.2])
yticks([0 0.4 0.8 1.2])
xlim([-1 2])
xticks([-1 0 1 2])
[rNoSacProbe, pNoSacProbe] = corr([noSacProbe, noSacBehNorm], 'Rows', 'complete', 'Type', 'Spearman');
