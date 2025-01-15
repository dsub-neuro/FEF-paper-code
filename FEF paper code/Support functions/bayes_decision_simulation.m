function decision = bayes_decision_simulation(x, jumpDist, noJumpDist, noise, prior)
%equations for this simulation here: https://www.overleaf.com/project/60d0dd7b52f1af06fc85bf19    
%Bayesian decision = area under sensory noise distribution that falls above
%the decision criterion. 
%Decision criterion = point at which jump likelihood weighted by prior =
%non-jump likelihood weighted by (1 - prior)
%% calculate criterion
    %numerator = (2 * priorMinusLogOdds) + log((jumpDist^2 + noise^2)/(noJumpDist^2 + noise^2));

    numerator = (2 * (log(1 - prior) - log(prior))) + log(jumpDist^2 + noise^2) - log(noJumpDist^2 + noise^2);
    denominator = (1/(noJumpDist^2 + noise^2)) - (1/(jumpDist^2 + noise^2));
    
    criterion = max(0, numerator/denominator);
%% get decision    
    decision = 1 - ncx2cdf(criterion/noise^2, 1, x.^2/noise^2);
end