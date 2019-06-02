%% Bayesian Online Change-point Detection modified without restart and simple prior

% Inputs: 
%  -- NbrRuns: 
%  -- environment: vector of piece-wise Bernoulli distributions

% Outputs:
%  -- ChangePointEstimations: vector of change-point estimations

function [ChangePointEstimations]= BOCDm_restart(environment, NbrRuns)

% ----------------- Initialization -------------------
Horizon = length(environment);
gamma = (1./Horizon);
ChangePointEstimations = [];

%----------- Launch the Online Change-point Detection procedure 
display('Launching BOCD Modified with restart ...')
for run = 1:NbrRuns;
    ForecasterDistribution = [1];
    PseudoDist = [1]; like1 = 1; 
    alphas = [1]; betas = [1]; % Initialization for Laplace predictor
    Restart = 1; % Position of last restart
    CPEstimation = [];
    for t = 1: Horizon
        [~, BestForecaster] = max(ForecasterDistribution);        
        if (BestForecaster ~= 1) % Restart criterion
            ForecasterDistribution = [1]; like1 = 1; alphas = [1];  betas = [1]; Restart = t+1; % Reinitialization
        end
        CPEstimation = [CPEstimation Restart]; %Change-point estimation
        x = rand() < environment(t); % Get the observation from the environment
        [ForecasterDistribution, PseudoDist,like1] = updateForecasterDistribution_m(ForecasterDistribution, PseudoDist, alphas,betas,x,gamma, like1);
        [alphas, betas] = updateLaplacePrediction(alphas,betas, x);
    end
        ChangePointEstimations = [ChangePointEstimations; CPEstimation]; 
end