load('...data\effectSize_pVal_fix_reafLong.mat')
load('...data\numTrialsByCondition.mat')
load('...data\effSizes_pVal_windows.mat')

nTrials = table2array(numTrialsInEachCondition);

filter = logical(ones(91, 1));
for ii = 1:91
    if any(nTrials(ii, :) < 10) || any(isnan(nTrials(ii, :)))

        filter(ii) = 0;
    end
end

edges = -1:0.1:1;
%% fix epoch. Figure 2b

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

%% reaf epoch. Figure 2c.

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

%% reaf epoch significant by windows. Figure 2e and 2d.

isSigInWindows = zeros(sum(filter), 15);
reafPValFiltered =  reafPVal(filter, :);
sigNum = NaN(15, 1);

%figure 2e
for ii = 1:15
currIsSig = reafPValFiltered(:, ii) < 0.025/15;
isSigInWindows(currIsSig, ii) = 1;
sigNum(ii) = sum(currIsSig); 
end
[isSigInWindowsSorted, idx] = sortrows(isSigInWindows, 'descend');
figure
imagesc(isSigInWindowsSorted)
colormap('copper')
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out', 'yDir', 'normal')
yticks([20 40 60])
ylim([1 57])

%Figure 2d
figure
xValues = windows(:, 1) + 50;
plot(xValues, sigNum/79, 'ko-', 'LineWidth', 1, 'MarkerSize', 8, 'MarkerFaceColor', [0.6 0.6 0.6])
box off
ylim([0 0.5])
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out', 'yDir', 'normal')
yticks([0 0.25 0.5])
xticks([50 250 500 750])

%% 


