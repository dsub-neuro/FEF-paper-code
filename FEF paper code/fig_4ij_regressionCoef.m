%% Figure 4i-j. Plot regression coefficients for two mixed-effects regression models. 
load('...data\Regression data\reafLongRegModel.mat') %firing rate regression
load('...data\Regression data\reafLongRegModel_resp.mat') %response regression

%rearrage to move noise:sacDir (Currently position 8) to position 5 
yFR = [double(mdl.Coefficients(2:4, 2));  double(mdl.Coefficients(8, 2)); double(mdl.Coefficients(5:7, 2))];
errFR = [double(mdl.Coefficients(2:4, 3));  double(mdl.Coefficients(8, 3)); double(mdl.Coefficients(5:7, 3))];
pValFR = [double(mdl.Coefficients(2:4, 6));  double(mdl.Coefficients(8, 6)); double(mdl.Coefficients(5:7, 6))];

yResp = [double(mdlResp.Coefficients(2:4, 2));  double(mdlResp.Coefficients(8, 2)); double(mdlResp.Coefficients(5:7, 2))];
errResp = [double(mdlResp.Coefficients(2:4, 3));  double(mdlResp.Coefficients(8, 3)); double(mdlResp.Coefficients(5:7, 3))];
pValResp = [double(mdlResp.Coefficients(2:4, 6));  double(mdlResp.Coefficients(8, 6)); double(mdlResp.Coefficients(5:7, 6))];

figure
errorbar(1:7, yResp, errResp, 'ko', 'LineWidth', 1, 'MarkerSize', 8)
xlim([0.8 7.2])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
box off
line([0.8 7.2], [0 0], 'color', 'k')
ylim([-3 10])
yticks([-2 0 2 4 10])

figure
errorbar(1:7, yFR, errFR, 'ko', 'LineWidth', 1, 'MarkerSize', 8)
xlim([0.8 7.2])
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
box off
line([0.8 7.2], [0 0], 'color', 'k')
ylim([-5 20])
yticks([-4 0 4 15 20])
