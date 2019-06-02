%% Updating the forecaster distribution using the message passing algorithm

% Inputs: 
% -- ForecasterDistribution: Distribution of the forecasters at time t
% -- alphas and betas: historic of observations for each forecaster
% -- x: observation at time t+1
% -- gamma: input of the algorithm (swithing rate)

% Outputs:
% -- ForecasterDistribution: Distribution of the forecasters at time t+1


function [ForecasterDistribution] = updateForecasterDistribution(ForecasterDistribution,alphas,betas,x,gamma)
    if(x == 1)
        likelihood = alphas./(alphas + betas);
    else
        likelihood = betas./(alphas + betas);
    end
    w0 = gamma*sum(likelihood.*ForecasterDistribution); % Forecaster Newly created (using the original prior)
    ForecasterDistribution = (1-gamma).*likelihood.*ForecasterDistribution; % Updating forecaster Distribution
    ForecasterDistribution = [ForecasterDistribution w0]; % Including the new forecaseter into the previons ones
    ForecasterDistribution = ForecasterDistribution/sum(ForecasterDistribution); % Normalization for numerical precision
end
