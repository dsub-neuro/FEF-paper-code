%Code used to run regression models

load('...data\Regression data\reafLongReg.mat')

regtable = [firingRate, resp, thresh, noise, sacDir, isJump, jumpSize, cellID, animalID, sessionID];
varNames = {'FR', 'resp', 'thresh', 'noise', 'sacDir', 'isJump', 'jumpSize', 'cellID', 'animalID', 'sessionID'};
regtable = array2table(regtable, 'VariableNames', varNames);
regtable.noise(regtable.noise == 12) = 1;
regtable.noise(regtable.noise == 30) = 2;
regtable.noise(regtable.noise == 42) = 3; %highest noise level for Monkey S
regtable.noise(regtable.noise == 48) = 3; %highest noise level for Monkey T

%% 
%cd to appropriate data folder to save

formula = 'FR ~ thresh + sacDir + noise + jumpSize + noise*sacDir + thresh*sacDir + thresh*noise + (thresh | cellID) + (sacDir | cellID) + (noise | cellID) + (jumpSize|cellID) + (noise*sacDir|cellID) + (thresh*sacDir|cellID) + (thresh*noise|cellID)';
mdl = fitlme(regtable, formula);
save('reafLongRegModel.mat', 'mdl', 'formula', 'firingRateWindow'); 

formula = 'resp ~ thresh + sacDir + noise + jumpSize + noise*sacDir + thresh*sacDir + thresh*noise + (thresh | sessionID) + (sacDir | sessionID) + (noise | sessionID) + (jumpSize|sessionID) + (noise*sacDir|sessionID) + (thresh*sacDir|sessionID) + (thresh*noise|sessionID)';
mdlResp = fitglme(regtable, formula, 'Distribution', 'binomial');
save('reafLongRegModel_resp.mat.mat', 'mdlResp', 'formula', 'firingRateWindow'); 

