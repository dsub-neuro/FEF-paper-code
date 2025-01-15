%Figure 4e - plot effect sizes for all conditions

load('...data\numTrialsByCondition.mat')
load('...data\effectSize_nonParametric_reafLong.mat')
nTrials = table2array(numTrialsInEachCondition);

filter = logical(ones(91, 1));
for ii = 1:91
    if any(nTrials(ii, :) < 10) || any(isnan(nTrials(ii, :)))

        filter(ii) = 0;
    end
end

data = neuralEffReaf;
y = [nanmean(data.noSac(filter)), nanmean(data.noNoise(filter)), nanmean(data.lowNoise(filter)), nanmean(data.highNoise(filter))];
err = [nanstd(data.noSac(filter))/sqrt(sum(filter)), nanstd(data.noNoise(filter))/sqrt(sum(filter)), nanstd(data.lowNoise(filter))/sqrt(sum(filter)), nanstd(data.highNoise(filter))/sqrt(sum(filter))];
errorbar(1:4, y, err, 'ko', 'LineWidth', 1)
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
xlim([0.8 4.2])
ylim([0.1 0.3])

%% 

[h, p] = ttest(neuralEffReaf.noNoise(filter), neuralEffReaf.noSac(filter))

h =

     0


p =

    0.8101

[h, p] = ttest(neuralEffReaf.noNoise(filter), neuralEffReaf.lowNoise(filter))

h =

     1


p =

    0.0128

[h, p] = ttest(neuralEffReaf.noNoise(filter), neuralEffReaf.highNoise(filter))

h =

     1


p =

    0.0047
