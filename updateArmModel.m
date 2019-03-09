function [alphas, betas] = updateArmModel(alphas, betas, reward, alpha0, beta0)
    alphas = alphas + reward;
    betas = betas + (1-reward);
    alphas = [alphas alpha0];
    betas = [betas beta0];
end
    