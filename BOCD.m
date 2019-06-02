%% Bayesian Online Change-point Detection original version

% Inputs: 
%  -- NbrRuns: 
%  -- environment: vector of piece-wise Bernoulli distributions

% Outputs:
%  -- ChangePointEstimations: vector of change-point estimations

function [ChangePointEstimations]= BOCD(environment, NbrRuns)

% ----------------- Initialization -------------------
Horizon = length(environment);
gamma = (1./Horizon); % Switching rate
ChangePointEstimations = []; % Output

%----------- Launch the Online Change-point Detection procedure 
display('Launching BOCD ...')
for run = 1:NbrRuns;
    ForecasterDistribution = [1];
    CPEstimation = []; % ChangePoint estimation at each time t
    alphas = [1]; betas = [1]; % Initialization for Laplace predictor
    for t =1: Horizon
        [~, BestForecaster] = max(ForecasterDistribution); %Change-point estimation
        CPEstimation = [CPEstimation BestForecaster];
        x = rand() < environment(t); % Get the observation from the environment
        [ForecasterDistribution] = updateForecasterDistribution(ForecasterDistribution, alphas,betas,x,gamma); % Update the forecasters
        [alphas, betas] = updateLaplacePrediction(alphas,betas, x); % Update the laplace predictor
    end
    ChangePointEstimations = [ChangePointEstimations; CPEstimation]; 
end
