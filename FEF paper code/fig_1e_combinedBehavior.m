% Figure 1e - behavioral difference in response rates between high and low
% priors 

figure
%% Monkey S
load('...data\Skwiz\priorDiff_allJS_10TrialMin.mat')

n = sum(~isnan(priorDiff.noNoise));

SkwizMeans = [nanmean(priorDiff.noSaccade), nanmean(priorDiff.noNoise), nanmean(priorDiff.lowNoise), nanmean(priorDiff.highNoise)];
SkwizErr = [nanstd(priorDiff.noSaccade)/sqrt(n), nanstd(priorDiff.noNoise)/sqrt(n), nanstd(priorDiff.lowNoise)/sqrt(n), nanstd(priorDiff.highNoise)/sqrt(n)];
errorbar(1:4, SkwizMeans, SkwizErr, 'ko', 'MarkerSize', 10, 'LineWidth', 2)
xlim([0.8 4.2])
ylim([0 1])
xticks([1 2 3 4])
xticklabels({'no sac', 'low', 'medium', 'high'})
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
hold on

%% Monkey T
load('...data\Toki\priorDiff_allJS_10TrialMin.mat')

n = sum(~isnan(priorDiff.noNoise));

TokiMeans = [nanmean(priorDiff.noSaccade), nanmean(priorDiff.noNoise), nanmean(priorDiff.lowNoise), nanmean(priorDiff.highNoise)];
TokiErr = [nanstd(priorDiff.noSaccade)/sqrt(n), nanstd(priorDiff.noNoise)/sqrt(n), nanstd(priorDiff.lowNoise)/sqrt(n), nanstd(priorDiff.highNoise)/sqrt(n)];
errorbar(1:4, TokiMeans, TokiErr, 'k^', 'MarkerSize', 10, 'LineWidth', 2)
xlim([0.8 4.2])
ylim([-0.2 1])
xticks([1 2 3 4])
yticks([-0.2 0.2 0.6 1])
xticklabels({'no sac', 'low', 'medium', 'high'})
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out', 'TickLength', [0.02 0.02])
