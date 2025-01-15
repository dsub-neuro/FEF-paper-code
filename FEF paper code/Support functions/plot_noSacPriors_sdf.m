function plot_noSacPriors_sdf(sdfStruct, filter, window)

x = window(1):window(2);

noSacLowMean = nanmean(sdfStruct.noSacLow(filter, :));
err = nanstd(sdfStruct.noSacLow(filter, :))./sqrt(sum(filter));
shadedErrorBar(x, noSacLowMean, err, 'lineprops', {'LineWidth', 3, 'color', [0 0.5 0.5]})
hold on
noSacHighMean = nanmean(sdfStruct.noSacHigh(filter, :));
err = nanstd(sdfStruct.noSacHigh(filter, :))./sqrt(sum(filter));
shadedErrorBar(x, noSacHighMean, err, 'lineprops', {'LineWidth', 3, 'color', [1 0.65 0]})
%ylim([0 50])
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out', 'TickLength', [0.02 0.02])
ylim([-0.4 0.6])
yticks([-0.2 0 0.2 0.4])

xlim(window)

end