%% Updating the forecaster distribution using the message passing algorithm with a modified prior (q)

% Inputs: 
% -- ForecasterDistribution: Distribution of the forecasters at time t
% -- alphas and betas: historic of observations for each forecaster
% -- x: observation at time t+1
% -- gamma: input of the algorithm (swithing rate)

% Outputs:
% -- ForecasterDistribution: Distribution of the forecasters at time t+1


function [ForecasterDistribution, PseudoDist,like1] = updateForecasterDistribution_m(ForecasterDistribution, PseudoDist,alphas,betas,x,gamma,like1)
    
    if(x == 1)
        likelihood = alphas./(alphas + betas);
    else
        likelihood = betas./(alphas + betas);
    end

    Pseudo_w0 = gamma.*like1.*sum(PseudoDist); % Creating a new forecaster (using simple prior)
    PseudoDist = like1*PseudoDist;
    w0 = Pseudo_w0;
    ForecasterDistribution = likelihood.*ForecasterDistribution; % updating the existing forecasters
    ForecasterDistribution = [ForecasterDistribution w0 ]; % Including the new forecaseter into the previons ones 
    PseudoDist = [PseudoDist Pseudo_w0];
    PseudoDist = PseudoDist/sum(PseudoDist);
    ForecasterDistribution = ForecasterDistribution/sum(ForecasterDistribution); % Normalization for numerical precision
    like1 = likelihood(1);
end