%load data folder to save simulation results and summary

%% run model
%parameters
clear all
close all

params.jumpDist = 2.5;
params.noJumpDist = 0.5;
params.nTrials = 2000; 
params.learningRate = 0.5;
params.noise = 1;
params.bayesWeight = 0.1; 
params.lowNoise = 10;
params.highNoise = 20;
params.noJumpDistForBayesFactor = 2; 

bootStrapIterations = 20;

jumpSize = NaN(bootStrapIterations, params.nTrials);
isJump = NaN(bootStrapIterations, params.nTrials);
jProbNorm = NaN(bootStrapIterations, params.nTrials);
prior = NaN(bootStrapIterations, params.nTrials);
noiseOut = NaN(bootStrapIterations, params.nTrials);
isSac = NaN(bootStrapIterations, params.nTrials);
PerceptronJProbNorm = NaN(bootStrapIterations, params.nTrials);
BayesJProbNorm = NaN(bootStrapIterations, params.nTrials);

for ii = 1:bootStrapIterations
    [jumpSize(ii, :), isJump(ii, :), jProbNorm(ii, :), ~, prior(ii, :), noiseOut(ii, :), isSac(ii, :), PerceptronJProbNorm(ii, :), BayesJProbNorm(ii, :)]  = simulate_combinedModel(params.noise, params.jumpDist, params.noJumpDist, params.learningRate, params.bayesWeight, params.noJumpDistForBayesFactor, params.nTrials);
end

save('combinedModel_bootstrap_allData.mat', 'jumpSize', 'isJump', 'jProbNorm', 'prior', 'noiseOut', 'isSac', 'PerceptronJProbNorm', 'BayesJProbNorm', 'params')

%% set up data structures and summarize data
bootStrapIterations = 20;

%curves
%no saccade
curves.lowPriorNoSac = NaN(bootStrapIterations, 1000);
curves.highPriorNoSac = NaN(bootStrapIterations, 1000);

%no noise
curves.lowPriorNoNoise = NaN(bootStrapIterations, 1000);
curves.highPriorNoNoise = NaN(bootStrapIterations, 1000);

%low noise
curves.lowPriorLowNoise = NaN(bootStrapIterations, 1000);
curves.highPriorLowNoise = NaN(bootStrapIterations, 1000);

%high noise
curves.lowPriorHighNoise = NaN(bootStrapIterations, 1000);
curves.highPriorHighNoise = NaN(bootStrapIterations, 1000);

%bins
%no saccade
bins.lowPriorNoSac = NaN(bootStrapIterations, 10);
bins.highPriorNoSac = NaN(bootStrapIterations, 10);

%no noise
bins.lowPriorNoNoise = NaN(bootStrapIterations, 10);
bins.highPriorNoNoise = NaN(bootStrapIterations, 10);

%low noise
bins.lowPriorLowNoise = NaN(bootStrapIterations, 10);
bins.highPriorLowNoise = NaN(bootStrapIterations, 10);

%high noise
bins.lowPriorHighNoise = NaN(bootStrapIterations, 10);
bins.highPriorHighNoise = NaN(bootStrapIterations, 10);

%min
%no noise
min.lowPriorNoSac = NaN(bootStrapIterations, 1);
min.highPriorNoSac = NaN(bootStrapIterations, 1);

%no noise
min.lowPriorNoNoise = NaN(bootStrapIterations, 1);
min.highPriorNoNoise = NaN(bootStrapIterations, 1);

%low noise
min.lowPriorLowNoise = NaN(bootStrapIterations, 1);
min.highPriorLowNoise = NaN(bootStrapIterations, 1);

%high noise
min.lowPriorHighNoise = NaN(bootStrapIterations, 1);
min.highPriorHighNoise = NaN(bootStrapIterations, 1);


xspace = linspace(0, 5, 1000);
L = [0 0 0 0]; %min, slope, threshold, max. 0 = most liberal lower bound for min and max parameters. Adjust accordingly but note that a too-constrained value will sacrifice goodness of fit. Consider binning data with edges at a priori meaningful points (e.g., start of extinction training) instead.
U = [1 10 50 1]; %min, slope, threshold, max. 1 = most liberal upper bound for min and max parameters. Adjust accordingly - same caution as above.
st = [0 -1 5 0.4];
nTrials = params.nTrials;

for ii = 1:bootStrapIterations
    
    currJS = jumpSize(ii, nTrials/2:end)';
    currResp = jProbNorm(ii, nTrials/2:end)';
    currPrior = prior(ii, nTrials/2:end)';
    currNoise = noiseOut(ii, nTrials/2:end)';
    currIsSac = isSac(ii, nTrials/2:end)';

    noiseLevels = unique(currNoise);
    noNoise = currNoise == noiseLevels(1);
    lowNoise = currNoise == noiseLevels(2);
    highNoise = currNoise == noiseLevels(3);

    lowPrior = currPrior == 0.2;
    medPrior = currPrior == 0.5;
    highPrior = currPrior == 0.8;

    withSac = currIsSac == 1;
    noSac = currIsSac == 0;

    %min and curves
    %no saccade condition
    [min.lowPriorNoSac(ii), ~, ~, ~, curves.lowPriorNoSac(ii, :), ~] = psychCurve_4P(currJS(lowPrior & noNoise & noSac), currResp(lowPrior & noNoise & noSac), xspace, L, U, st);
    [min.highPriorNoSac(ii), ~, ~, ~, curves.highPriorNoSac(ii, :), ~] = psychCurve_4P(currJS(highPrior & noNoise & noSac), currResp(highPrior & noNoise & noSac), xspace, L, U, st);
    bins.lowPriorNoSac(ii, :) = psychCurveBins_nonBinary(currJS(lowPrior & noNoise & noSac), currResp(lowPrior & noNoise & noSac), 0.5, 5);
    bins.highPriorNoSac(ii, :) = psychCurveBins_nonBinary(currJS(highPrior & noNoise & noSac), currResp(highPrior & noNoise & noSac), 0.5, 5);

    [min.lowPriorNoNoise(ii), ~, ~, ~, curves.lowPriorNoNoise(ii, :), ~] = psychCurve_4P(currJS(lowPrior & noNoise & withSac), currResp(lowPrior & noNoise & withSac), xspace, L, U, st);
    [min.highPriorNoNoise(ii), ~, ~, ~, curves.highPriorNoNoise(ii, :), ~] = psychCurve_4P(currJS(highPrior & noNoise & withSac), currResp(highPrior & noNoise & withSac), xspace, L, U, st);
    bins.lowPriorNoNoise(ii, :) = psychCurveBins_nonBinary(currJS(lowPrior & noNoise & withSac), currResp(lowPrior & noNoise & withSac), 0.5, 5);
    bins.highPriorNoNoise(ii, :) = psychCurveBins_nonBinary(currJS(highPrior & noNoise & withSac), currResp(highPrior & noNoise & withSac), 0.5, 5);

    [min.lowPriorLowNoise(ii), ~, ~, ~, curves.lowPriorLowNoise(ii, :), ~] = psychCurve_4P(currJS(lowPrior & lowNoise & withSac), currResp(lowPrior & lowNoise & withSac), xspace, L, U, st);
    [min.highPriorLowNoise(ii), ~, ~, ~, curves.highPriorLowNoise(ii, :), ~] = psychCurve_4P(currJS(highPrior & lowNoise & withSac), currResp(highPrior & lowNoise & withSac), xspace, L, U, st);
    bins.lowPriorLowNoise(ii, :) = psychCurveBins_nonBinary(currJS(lowPrior & lowNoise & withSac), currResp(lowPrior & lowNoise & withSac), 0.5, 5);
    bins.highPriorLowNoise(ii, :) = psychCurveBins_nonBinary(currJS(highPrior & lowNoise & withSac), currResp(highPrior & lowNoise & withSac), 0.5, 5);

    [min.lowPriorHighNoise(ii), ~, ~, ~, curves.lowPriorHighNoise(ii, :), ~] = psychCurve_4P(currJS(lowPrior & highNoise & withSac), currResp(lowPrior & highNoise & withSac), xspace, L, U, st);
    [min.highPriorHighNoise(ii), ~, ~, ~, curves.highPriorHighNoise(ii, :), ~] = psychCurve_4P(currJS(highPrior & highNoise & withSac), currResp(highPrior & highNoise & withSac), xspace, L, U, st);
    bins.lowPriorHighNoise(ii, :) = psychCurveBins_nonBinary(currJS(lowPrior & highNoise & withSac), currResp(lowPrior & highNoise & withSac), 0.5, 5);
    bins.highPriorHighNoise(ii, :) = psychCurveBins_nonBinary(currJS(highPrior & highNoise & withSac), currResp(highPrior & highNoise & withSac), 0.5, 5);
end

%% 
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

[pooledMin.lowPriorNoSac, ~, ~, ~, pooledCurves.lowPriorNoSac, ~] = psychCurve_4P(pooledJS(lowPrior & noNoise & noSac), pooledResp(lowPrior & noNoise & noSac), xspace, L, U, st);
[pooledMin.highPriorNoSac, ~, ~, ~, pooledCurves.highPriorNoSac, ~] = psychCurve_4P(pooledJS(highPrior & noNoise & noSac), pooledResp(highPrior & noNoise & noSac), xspace, L, U, st);

[pooledMin.lowPriorNoNoise, ~, ~, ~, pooledCurves.lowPriorNoNoise, ~] = psychCurve_4P(pooledJS(lowPrior & noNoise & withSac), pooledResp(lowPrior & noNoise & withSac), xspace, L, U, st);
[pooledMin.highPriorNoSac, ~, ~, ~, pooledCurves.highPriorNoNoise, ~] = psychCurve_4P(pooledJS(highPrior & noNoise & withSac), pooledResp(highPrior & noNoise & withSac), xspace, L, U, st);

[pooledMin.lowPriorLowNoise, ~, ~, ~, pooledCurves.lowPriorLowNoise, ~] = psychCurve_4P(pooledJS(lowPrior & lowNoise & withSac), pooledResp(lowPrior & lowNoise & withSac), xspace, L, U, st);
[pooledMin.highPriorLowNoise, ~, ~, ~, pooledCurves.highPriorLowNoise, ~] = psychCurve_4P(pooledJS(highPrior & lowNoise & withSac), pooledResp(highPrior & lowNoise & withSac), xspace, L, U, st);

[pooledMin.lowPriorHighNoise, ~, ~, ~, pooledCurves.lowPriorHighNoise, ~] = psychCurve_4P(pooledJS(lowPrior & highNoise & withSac), pooledResp(lowPrior & highNoise & withSac), xspace, L, U, st);
[pooledMin.highPriorHighNoise, ~, ~, ~, pooledCurves.highPriorHighNoise, ~] = psychCurve_4P(pooledJS(highPrior & highNoise & withSac), pooledResp(highPrior & highNoise & withSac), xspace, L, U, st);

save('combinedModel_bootstrap_summary.mat', 'curves', 'bins', 'min', 'pooledMin', 'pooledCurves')
