%% Updating the forecaster distribution using the message passing algorithm

% Inputs: 
% -- ForecasterDistribution: Distribution of the forecasters at time t
% -- alphas and betas: historic of observations for each forecaster
% -- x: observation at time t+1
% -- gamma: input of the algorithm (swithing rate)

% Outputs:
% -- ForecasterDistribution: Distribution of the forecasters at time t+1


function [ForecasterDistribution] = updateForecasterDistribution(ForecasterDistribution,alphas,betas,x,gamma)
    likelihood = [];
    if(x == 1)
        for i=1:length(ForecasterDistribution);
            likelihood = [likelihood alphas(i)/(alphas(i)+betas(i))];
        end
    else
        for i=1:length(ForecasterDistribution);
            likelihood = [likelihood betas(i)/(alphas(i)+betas(i))];
        end
    end
    w0 = gamma*sum(likelihood.*ForecasterDistribution); % Forecaster Newly created (using the original prior)
    ForecasterDistribution = (1-gamma).*likelihood.*ForecasterDistribution; % Updating forecaster Distribution
    ForecasterDistribution = [ForecasterDistribution w0]; % Including the new forecaseter into the previons ones
    ForecasterDistribution = ForecasterDistribution/sum(ForecasterDistribution); % Normalization for numerical precision
end
