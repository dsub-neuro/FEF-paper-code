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

%% 
xNewVN = linspace(-0.5, 1.5, 100)';

%% set up data
data = neuralEffReaf;
sigData = reafferentEpoch.pVal;
sigNeurons = sigData < 0.025;
bigEffectSize = sigNeurons & filter;

%behavior
noSacBehNorm = behaviorEff.noSac(bigEffectSize)./behaviorEff.noNoise(bigEffectSize);
lowNoiseBehNorm = behaviorEff.lowNoise(bigEffectSize)./behaviorEff.noNoise(bigEffectSize);
highNoiseBehNorm = behaviorEff.highNoise(bigEffectSize)./behaviorEff.noNoise(bigEffectSize);

%firing rate effect size
noSac = data.noSac(bigEffectSize)./data.noNoise(bigEffectSize);
lowNoise = data.lowNoise(bigEffectSize)./data.noNoise(bigEffectSize);
highNoise = data.highNoise(bigEffectSize)./data.noNoise(bigEffectSize);

%% plots
%no saccade reafferent
[lineNoSacReaf, negErrorNoSacReaf, posErrorNoSacReaf] = reg_line_ci(noSac, noSacBehNorm, xNewVN);

figure
plot(noSac, noSacBehNorm, 'o', 'color', [0.7 0.7 0.7], 'MarkerFaceColor', [0.7 0.7 0.7], 'MarkerSize', 6, 'LineWidth', 2)
hold on
shadedErrorBar(xNewVN, lineNoSacReaf, [negErrorNoSacReaf, posErrorNoSacReaf], 'lineProps', {'LineWidth', 3, 'color', 'k'})
title('no saccade, reaf')
xlabel('normalized firing rate effect size')
ylabel('normalized behavioral prior use')
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out', 'TickLength', [0.02 0.02])
ylim([0 1.2])
yticks([0 0.4 0.8 1.2])
xlim([-1.5 2.5])
xticks([-1 0 1 2])
[rNoSac, pNoSac, rNoSacLowerBound, rNoSacUpperBound] = corrcoef([noSac, noSacBehNorm], 'alpha', 0.05);

%low noise reafferent
[lineLowNoiseReaf, negErrorLowNoiseReaf, posErrorLowNoiseReaf] = reg_line_ci(lowNoise, lowNoiseBehNorm, xNewVN);
figure
plot(lowNoise, lowNoiseBehNorm, 'o', 'color', [0.7 0.7 0.7], 'MarkerFaceColor', [0.7 0.7 0.7],  'MarkerSize', 6, 'LineWidth', 2)
hold on
shadedErrorBar(xNewVN, lineLowNoiseReaf, [negErrorLowNoiseReaf, posErrorLowNoiseReaf], 'lineProps', {'LineWidth', 3, 'color', 'k'})
title('low noise, reaf')
xlabel('normalized firing rate effect size')
ylabel('normalized behavioral prior use')
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
ylim([0 1.2])
yticks([0 0.4 0.8 1.2])
xlim([-1.5 2.5])
xticks([-1 0 1 2])
[rLowNoise, pLowNoise, rLowNoiseLowerBound, rLowNoiseUpperBound] = corrcoef([lowNoise, lowNoiseBehNorm],  'Rows', 'complete', 'alpha', 0.05);

%high noise reafferent
[lineHighNoiseReaf, negErrorHighNoiseReaf, posErrorHighNoiseReaf] = reg_line_ci(highNoise, highNoiseBehNorm, xNewVN);
figure
plot(highNoise, highNoiseBehNorm, 'o', 'color', [0.7 0.7 0.7], 'MarkerFaceColor', [0.7 0.7 0.7], 'MarkerSize', 6, 'LineWidth', 2)
hold on
shadedErrorBar(xNewVN, lineHighNoiseReaf, [negErrorHighNoiseReaf, posErrorHighNoiseReaf], 'lineProps', {'LineWidth', 3, 'color', 'k'})
title('high noise, reaf')
ylabel('normalized behavioral prior use')
xlabel('normalized firing rate effect size')
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
ylim([0 1.2])
yticks([0 0.4 0.8 1.2])
xlim([-1.5 2.5])
xticks([-1 0 1 2])
[rHighNoise, pHighNoise, rHighNoiseLowerBound, rHighNoiseUpperBound] = corrcoef([highNoise, highNoiseBehNorm],  'Rows', 'complete', 'alpha', 0.05);
