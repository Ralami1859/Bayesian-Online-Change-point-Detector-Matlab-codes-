function [Proba, likelihood, ValRunlength] = updateChangeModel(Proba,alphas,betas,reward,gamma, ValRunlength)
    likelihood = [];
    if(reward == 1)
        for i=1:length(Proba);
            likelihood = [likelihood alphas(i)/(alphas(i)+betas(i))];
        end
    else
        for i=1:length(Proba);
            likelihood = [likelihood betas(i)/(alphas(i)+betas(i))];
        end
    end
    Proba0 = gamma*sum(likelihood.*Proba);
    %Proba0 = gamma*sum(0.5);
    Proba = (1-gamma).*likelihood.*Proba;
    Proba = [Proba Proba0];
    Proba = Proba/sum(Proba);
    ValRunlength = [0 ValRunlength+1];
end
