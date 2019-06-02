%% Updating the laplace prediction for each forecasters

% Inputs:
% -- alphas and betas: historic of observations for each forecaster up to
% time t
% -- x: observation at time t+1

% Outputs:
% -- alphas and betas: historic of observations for each forecaster up to
% time t+1

function [alphas, betas] = updateLaplacePrediction(alphas, betas, x)
    alphas = alphas + x;
    betas = betas + (1-x);
    alphas = [alphas 1]; % Creating new forecaster
    betas = [betas 1]; % Creating new forecaster
end
    