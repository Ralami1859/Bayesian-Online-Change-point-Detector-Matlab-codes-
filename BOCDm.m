%% Bayesian Online Change-point Detection modified without restart and simple prior

% Inputs: 
%  -- NbrRuns: 
%  -- environment: vector of piece-wise Bernoulli distributions

% Outputs:
%  -- ChangePointEstimations: vector of change-point estimations


function [ChangePointEstimations]= BOCDm(environment, NbrRuns)

% ----------------- Initialization -------------------
Horizon = length(environment);
gamma = (1./Horizon);
ChangePointEstimations = [];

%----------- Launch the Online Change-point Detection procedure 
display('Launching BOCD modified ...')
for run = 1:NbrRuns;
    ForecasterDistribution = [1];
    PseudoDist = [1];
    CPEstimation = []; % ChangePoint estimation at each time t
    like1 = 1;
    alphas = [1];betas = [1]; % Initialization for Laplace predictor
    for t = 1: Horizon
        [~, BestForecaster] = max(ForecasterDistribution); %Change-point estimation
        CPEstimation = [CPEstimation BestForecaster];
        x = rand() < environment(t); % Get the observation from the environment
        [ForecasterDistribution, PseudoDist,like1] = updateForecasterDistribution_m(ForecasterDistribution, PseudoDist, alphas,betas,x,gamma, like1);
        [alphas, betas] = updateLaplacePrediction(alphas,betas, x);
    end
    ChangePointEstimations = [ChangePointEstimations; CPEstimation]; 
end