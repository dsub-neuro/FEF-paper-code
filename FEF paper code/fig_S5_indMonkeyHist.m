load('...data\effectSize_pVal_fix_reafLong.mat')
load('...data\numTrialsByCondition.mat')
nTrials = table2array(numTrialsInEachCondition);

filter = logical(ones(91, 1));
for ii = 1:91
    if any(nTrials(ii, :) < 10) || any(isnan(nTrials(ii, :)))
        filter(ii) = 0;
    end
end

%Monkey S = rows 1 - 55
skwizFilt = logical(zeros(91, 1));
skwizFilt(1:55) = 1;

%Monkey T = rows 56 - 91
tokiFilt = logical(zeros(91, 1));
tokiFilt(56:91) = 1;

fixSig = fixEpoch.pVal < 0.025;
reafSig = reafferentEpoch.pVal < 0.025;

edges = -1:0.1:1;

subplot(2, 2, 1)
histogram(fixEpoch.effectSize(skwizFilt & filter), edges, 'FaceColor', 'none', 'LineWidth', 1)
hold on
histogram(fixEpoch.effectSize(skwizFilt & filter & fixSig), edges, 'FaceColor', [0.67 0.6 0.71], 'LineWidth', 1)
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
xlim([-1 1])
ylim([0 15])
title('Skwiz fix')

subplot(2, 2, 2)
histogram(reafferentEpoch.effectSize(skwizFilt & filter), edges, 'FaceColor', 'none', 'LineWidth', 1)
hold on
histogram(reafferentEpoch.effectSize(skwizFilt & filter & reafSig), edges, 'FaceColor', [0.67 0.6 0.71], 'LineWidth', 1)
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
xlim([-1 1])
ylim([0 15])
title('Skwiz reaf')

subplot(2, 2, 3)
histogram(fixEpoch.effectSize(tokiFilt & filter), edges, 'FaceColor', 'none', 'LineWidth', 1)
hold on
histogram(fixEpoch.effectSize(tokiFilt & filter & fixSig), edges, 'FaceColor', [0.67 0.6 0.71], 'LineWidth', 1)
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
xlim([-1 1])
ylim([0 15])
title('Toki fix')

subplot(2, 2, 4)
histogram(reafferentEpoch.effectSize(tokiFilt & filter), edges, 'FaceColor', 'none', 'LineWidth', 1)
hold on
histogram(reafferentEpoch.effectSize(tokiFilt & filter & reafSig), edges, 'FaceColor', [0.67 0.6 0.71], 'LineWidth', 1)
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
xlim([-1 1])
ylim([0 15])
title('Toki reaf')

%% fix epoch

fixSig = fixEpoch.pVal < 0.025;
fixFilter = fixSig & filter; 

figure
histogram(fixEpoch.effectSize(filter), edges, 'FaceColor', 'none', 'LineWidth', 1)
hold on
histogram(fixEpoch.effectSize(fixFilter), edges, 'FaceColor', [0.67 0.6 0.71], 'LineWidth', 1)
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
xlim([-1 1])
%ylim([0 10])

%% reaf epoch

reafSig = reafferentEpoch.pVal < 0.025;
reafFilter = reafSig & filter; 

figure
histogram(reafferentEpoch.effectSize(filter), edges, 'FaceColor', 'none', 'LineWidth', 1)
hold on
histogram(reafferentEpoch.effectSize(reafFilter), edges, 'FaceColor', [0.67 0.6 0.71], 'LineWidth', 1)
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
xlim([-1 1])
ylim([0 25])