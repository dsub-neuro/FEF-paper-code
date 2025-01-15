load('...data\Combined model simulations\combinedModel_bootstrap_allData.mat')
load('...data\Combined model simulations\combinedModel_bootstrap_summary.mat')

%% figure S3b
xspace = linspace(0, 5, 1000);
nTrials = params.nTrials;

n = 1;
currJS = jumpSize(n, nTrials/2:end)';
currResp = jProbNorm(n, nTrials/2:end)';
currPrior = prior(n, nTrials/2:end)';
currNoise = noiseOut(n, nTrials/2:end)';
currIsSac = isSac(n, nTrials/2:end)';

noiseLevels = unique(currNoise);
noNoise = currNoise == noiseLevels(1);
lowNoise = currNoise == noiseLevels(2);
highNoise = currNoise == noiseLevels(3);

lowPrior = currPrior == 0.2;
highPrior = currPrior == 0.8;

withSac = currIsSac == 1;
noSac = currIsSac == 0;

figure
subplot(1, 4, 1)
plot(currJS(lowPrior & noNoise & noSac), currResp(lowPrior & noNoise & noSac), '.', 'color', [0 0.5 0.5])
hold on
plot(currJS(highPrior & noNoise & noSac), currResp(highPrior & noNoise & noSac), '.', 'color', [1 0.65 0])
hold on
plot(xspace, curves.lowPriorNoSac(n, :), 'color', [0 0.5 0.5], 'LineWidth', 1)
hold on
plot(xspace, curves.highPriorNoSac(n, :), 'color', [1 0.65 0], 'LineWidth', 1)
ylim([0.1 0.8])
xlim([0 3])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out', 'TickLength', [0.02 0.02])

subplot(1, 4, 2)
plot(currJS(lowPrior & noNoise & withSac), currResp(lowPrior & noNoise & withSac), '.', 'color', [0 0.5 0.5])
hold on
plot(currJS(highPrior & noNoise & withSac), currResp(highPrior & noNoise & withSac), '.', 'color', [1 0.65 0])
hold on
plot(xspace, curves.lowPriorNoNoise(n, :), 'color', [0 0.5 0.5], 'LineWidth', 1)
hold on
plot(xspace, curves.highPriorNoNoise(n, :), 'color', [1 0.65 0], 'LineWidth', 1)
ylim([0.1 0.8])
xlim([0 3])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out', 'TickLength', [0.02 0.02])

subplot(1, 4, 3)
plot(currJS(lowPrior & lowNoise & withSac), currResp(lowPrior & lowNoise & withSac), '.', 'color', [0 0.5 0.5])
hold on
plot(currJS(highPrior & lowNoise & withSac), currResp(highPrior & lowNoise & withSac), '.', 'color', [1 0.65 0])
hold on
plot(xspace, curves.lowPriorLowNoise(n, :), 'color', [0 0.5 0.5], 'LineWidth', 1)
hold on
plot(xspace, curves.highPriorLowNoise(n, :), 'color', [1 0.65 0], 'LineWidth', 1)
ylim([0.1 0.8])
xlim([0 3])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out', 'TickLength', [0.02 0.02])

subplot(1, 4, 4)
plot(currJS(lowPrior & highNoise & withSac), currResp(lowPrior & highNoise & withSac), '.', 'color', [0 0.5 0.5])
hold on
plot(currJS(highPrior & highNoise & withSac), currResp(highPrior & highNoise & withSac), '.', 'color', [1 0.65 0])
hold on
plot(xspace, curves.lowPriorHighNoise(n, :), 'color', [0 0.5 0.5], 'LineWidth', 1)
hold on
plot(xspace, curves.highPriorHighNoise(n, :), 'color', [1 0.65 0], 'LineWidth', 1)
ylim([0.1 0.8])
xlim([0 3])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out', 'TickLength', [0.02 0.02])


%% Figure S3c - pooled jump sizes histogram
bootStrapIterations = 20;

pooledJS = [];
pooledResp = [];
pooledPrior = [];
pooledNoise = [];
pooledIsSac = [];
%pooled psych curves across all iterations
for ii = 1:bootStrapIterations
    currJS = jumpSize(ii, nTrials/2:end)';
    currResp = jProbNorm(ii, nTrials/2:end)';
    currPrior = prior(ii, nTrials/2:end)';
    currNoise = noiseOut(ii, nTrials/2:end)';
    currIsSac = isSac(ii, nTrials/2:end)';
 
    pooledJS = [pooledJS; currJS];
    pooledResp = [pooledResp; currResp];
    pooledPrior = [pooledPrior; currPrior];
    pooledNoise = [pooledNoise; currNoise];
    pooledIsSac = [pooledIsSac; currIsSac];
end
noiseLevels = unique(pooledNoise);
noNoise = pooledNoise == noiseLevels(1);
lowNoise = pooledNoise == noiseLevels(2);
highNoise = pooledNoise == noiseLevels(3);

lowPrior = pooledPrior == 0.2;
medPrior = pooledPrior == 0.5;
highPrior = pooledPrior == 0.8;

withSac = pooledIsSac == 1;
noSac = pooledIsSac == 0;

binEdges = 0:0.5:9;
figure
histogram(pooledJS(lowPrior), binEdges, 'FaceColor', [0 0.5 0.5])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out', 'TickLength', [0.02 0.02])
xlim([0 7])
line([2 2], [0 3000])

figure
histogram(pooledJS(highPrior), binEdges, 'FaceColor', [1 0.65 0])
hold on
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out', 'TickLength', [0.02 0.02])
xlim([0 7])
line([2 2], [0 3000])

%% Figure 1d (bottom)
% plot bins with bootstrap error bars
nBins = 4;
noSacBinDiff = nanmean(bins.highPriorNoSac(:, 1:nBins) - bins.lowPriorNoSac(:, 1:nBins), 2); 
noNoiseBinDiff = nanmean(bins.highPriorNoNoise(:, 1:nBins) - bins.lowPriorNoNoise(:, 1:nBins), 2); 
lowNoiseBinDiff = nanmean(bins.highPriorLowNoise(:, 1:nBins) - bins.lowPriorLowNoise(:, 1:nBins), 2); 
highNoiseBinDiff = nanmean(bins.highPriorHighNoise(:, 1:nBins) - bins.lowPriorHighNoise(:, 1:nBins), 2); 

medians = [median(noSacBinDiff), median(noNoiseBinDiff), median(lowNoiseBinDiff), median(highNoiseBinDiff)];

figure
for ii = 1:20
    plot(1:4, [noSacBinDiff(ii) noNoiseBinDiff(ii) lowNoiseBinDiff(ii) highNoiseBinDiff(ii)], '.-', 'color', [0.7 0.7 0.7])
    hold on
end
plot(1:4, medians, 'ko-', 'MarkerSize', 8, 'LineWidth', 1)
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out', 'TickLength', [0.02 0.02])
xlim([0.8 4.2])
xticks([1 2 3 4])




