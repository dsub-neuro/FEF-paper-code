load('...data\SDF data\ssd_sdf_zNorm_long_zeroJS.mat')

reafTotal = reafZ; 

nTrials = table2array(numTrialsInEachCondition);

filter = logical(ones(91, 1));
for ii = 1:91
    if any(nTrials(ii, :) < 5) || any(isnan(nTrials(ii, :)))

        filter(ii) = 0;
    end
end

x = -200:900;

%%
%no noise
figure
subplot(1, 4, 2)
noNoiseLowMean = nanmean(reafTotal.noNoiseLow(filter, :));
err = nanstd(reafTotal.noNoiseLow(filter, :))./sqrt(sum(filter));
shadedErrorBar(x, noNoiseLowMean, err, 'lineprops', {'LineWidth', 3, 'color', [0 0.5 0.5]})
hold on
noNoiseHighMean = nanmean(reafTotal.noNoiseHigh(filter, :));
err = nanstd(reafTotal.noNoiseHigh(filter, :))./sqrt(sum(filter));
shadedErrorBar(x, noNoiseHighMean, err, 'lineprops', {'LineWidth', 3, 'color', [1 0.65 0]})
%ylim([0 50])
%yticks([0 25 50])
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out', 'TickLength', [0.02 0.02])
ylim([-0.2 0.6])
title('no noise')

%low noise
%figure
subplot(1, 4, 3)
lowNoiseLowMean = nanmean(reafTotal.lowNoiseLow(filter, :));
err = nanstd(reafTotal.lowNoiseLow(filter, :))./sqrt(sum(filter));
shadedErrorBar(x, lowNoiseLowMean, err, 'lineprops', {'LineWidth', 3, 'color', [0 0.5 0.5]})
hold on
lowNoiseHighMean = nanmean(reafTotal.lowNoiseHigh(filter, :));
err = nanstd(reafTotal.lowNoiseHigh(filter, :))./sqrt(sum(filter));
shadedErrorBar(x, lowNoiseHighMean, err, 'lineprops', {'LineWidth', 3, 'color', [1 0.65 0]})
%ylim([0 50])
%yticks([0 25 50])
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out', 'TickLength', [0.02 0.02])
ylim([-0.2 0.6])
title('low noise')
%high noise
%figure
subplot(1, 4, 4)
highNoiseLowMean = nanmean(reafTotal.highNoiseLow(filter, :));
err = nanstd(reafTotal.highNoiseLow(filter, :))./sqrt(sum(filter));
shadedErrorBar(x, highNoiseLowMean, err, 'lineprops', {'LineWidth', 3, 'color', [0 0.5 0.5]})
hold on
highNoiseHighMean = nanmean(reafTotal.highNoiseHigh(filter, :));
err = nanstd(reafTotal.highNoiseHigh(filter, :))./sqrt(sum(filter));
shadedErrorBar(x, highNoiseHighMean, err, 'lineprops', {'LineWidth', 3, 'color', [1 0.65 0]})
%ylim([0 50])
%yticks([0 25 50])
title('high noise')
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out', 'TickLength', [0.02 0.02])
ylim([-0.2 0.6])
title('high noise')

%no saccade
%figure
subplot(1, 4, 1)
noSacLowMean = nanmean(reafTotal.noSacLow(filter, :));
err = nanstd(reafTotal.noSacLow(filter, :))./sqrt(sum(filter));
shadedErrorBar(x, noSacLowMean, err, 'lineprops', {'LineWidth', 3, 'color', [0 0.5 0.5]})
hold on
noSacHighMean = nanmean(reafTotal.noSacHigh(filter, :));
err = nanstd(reafTotal.noSacHigh(filter, :))./sqrt(sum(filter));
shadedErrorBar(x, noSacHighMean, err, 'lineprops', {'LineWidth', 3, 'color', [1 0.65 0]})
%ylim([0 50])
%yticks([0 25 50])
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out', 'TickLength', [0.02 0.02])
ylim([-0.2 0.6])
title('no sac')
