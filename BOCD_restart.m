%% Bayesian Online Change-point Detection with original prior and restart

% Inputs: 
%  -- NbrRuns: 
%  -- environment: vector of piece-wise Bernoulli distributions

% Outputs:
%  -- ChangePointEstimations: vector of change-point estimations

function [ChangePointEstimations]= BOCD_restart(environment, NbrRuns)


% ----------------- Initialization -------------------
Horizon = length(environment);
gamma = (1./Horizon);
ChangePointEstimations = [];

% ---------------- Launch the online Change-point detection procedure
display('Launching BOCD with restart ...')
for run = 1:NbrRuns;
    ForecasterDistribution = [1];
    alphas = [1]; betas = [1]; % Initialization for Laplace predictor
    Restart = 1;  % Position of last restart
    CPEstimations = [];
    for t = 1:Horizon
        [~, BestForecaster] = max(ForecasterDistribution); 
        % -- Restart verification
        if (BestForecaster ~= 1) % Restart criterion
            ForecasterDistribution = [1]; alphas = [1]; betas = [1]; Restart = t+1; % Reinitialization
        end
        % -- End of restart verification
        CPEstimations = [CPEstimations Restart]; %Change-point estimation
        x = rand() < environment(t); % Get the observation from the environment
        [ForecasterDistribution] = updateForecasterDistribution(ForecasterDistribution, alphas,betas,x,gamma);
        [alphas, betas] = updateLaplacePrediction(alphas,betas, x);
    end
    ChangePointEstimations  = [ChangePointEstimations ; CPEstimations];
end
