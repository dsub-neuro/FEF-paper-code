%% simulation parameters
jumpDist = 5;
noJumpDistWithSaccade = 0.75;
noJumpDistNoSaccade = 0.1;

maxX = 6;
x = linspace(0, maxX, 1000);

lowPrior = 0.2;
highPrior = 0.8;

noNoise = 0.4;
lowNoise = 0.65;
highNoise = 0.9;

%% Figure S2 - predicted psychometric curves
% no saccade
figure
subplot(1, 4, 1)
noSacHigh = bayes_decision_simulation(x, jumpDist, noJumpDistNoSaccade, noNoise, highPrior);
noSacLow = bayes_decision_simulation(x, jumpDist, noJumpDistNoSaccade, noNoise, lowPrior);
noSacDiff = mean(noSacHigh - noSacLow);

plot(x, noSacLow, 'color', [0 0.5 0.5], 'LineWidth', 2)
hold on
plot(x, noSacHigh, 'color', [1 0.65 0], 'LineWidth', 2)
xlim([0 maxX])
yticks([0 0.25 0.5 0.75 1])
xticks([])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
ylabel('Simulated probability of reporting "jumped"')

% no noise
subplot(1, 4, 2)
noNoiseHigh = bayes_decision_simulation(x, jumpDist, noJumpDistWithSaccade, noNoise, highPrior);
noNoiseLow = bayes_decision_simulation(x, jumpDist, noJumpDistWithSaccade, noNoise, lowPrior);
noNoiseDiff = mean(noNoiseHigh - noNoiseLow);

plot(x, noNoiseLow, 'color', [0 0.5 0.5], 'LineWidth', 2)
hold on
plot(x, noNoiseHigh, 'color', [1 0.65 0], 'LineWidth', 2)
xlim([0 maxX])
ylim([0 1])
yticks([0 0.25 0.5 0.75 1])
xticks([])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')

% low noise
subplot(1, 4, 3)
lowNoiseHigh = bayes_decision_simulation(x, jumpDist, noJumpDistWithSaccade, lowNoise, highPrior);
lowNoiseLow = bayes_decision_simulation(x, jumpDist, noJumpDistWithSaccade, lowNoise, lowPrior);
lowNoiseDiff = mean(lowNoiseHigh - lowNoiseLow);


plot(x, lowNoiseLow, 'color', [0 0.5 0.5], 'LineWidth', 2)
hold on
plot(x, lowNoiseHigh, 'color', [1 0.65 0], 'LineWidth', 2)
xlim([0 maxX])
ylim([0 1])
yticks([0 0.25 0.5 0.75 1])
xticks([])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')

%high noise
subplot(1, 4, 4)
highNoiseHigh = bayes_decision_simulation(x, jumpDist, noJumpDistWithSaccade, highNoise, highPrior);
highNoiseLow =  bayes_decision_simulation(x, jumpDist, noJumpDistWithSaccade, highNoise, lowPrior);
highNoiseDiff = mean(highNoiseHigh - highNoiseLow);

plot(x, highNoiseLow, 'color', [0 0.5 0.5], 'LineWidth', 2)
hold on
plot(x, highNoiseHigh, 'color', [1 0.65 0], 'LineWidth', 2)
xlim([0 maxX])
ylim([0 1])
yticks([0 0.25 0.5 0.75 1])
xticks([])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')

%% Figure 1D (top) - predicted difference in response rates between high and low priors
figure
plot(1:4, [noSacDiff, noNoiseDiff, lowNoiseDiff, highNoise], 'ko-', 'MarkerSize', 10, 'LineWidth', 2)
xlim([0.8 4.2])
ylim([0 1])
xticks([1 2 3 4])
yticks([0 0.5 1])
ylabel('Simulated difference in response rates (0.8 - 0.2)')
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')

