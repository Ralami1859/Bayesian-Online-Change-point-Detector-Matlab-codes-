function [GenVectRestart]= GlobalSTSBAOriginal(NbrIteration)

Horizon = 300*4;
fenetre = Horizon/4;
NbrChangement = floor(Horizon/fenetre);
BernoullisMeanMatrix = [0.7 0.1 0.6 0.2];

NbrPeriode = length(BernoullisMeanMatrix);
%Par défaut : 
gamma = NbrChangement/Horizon;

BestExpert = [0 1 2 3]*fenetre+1;
GeneralLoc = [];
GenVectRestart = [];
for iter = 1:NbrIteration;
    tic
    Proba = [1];
    Localisation = [];
    ValRunlength = [0];
    t = 0;
    %lambda = gamma;
    alpha0 = 1; beta0 = 1;
    alphas = [alpha0]; % NbrLigne = NbrProba; NbrCol = NbrBras;
    betas = [beta0]; % NbrLigne = NbrProba; NbrCol = NbrBras;
    Restart = 1;
    vectRestart = [];
    display(iter);
    while(t < Horizon)
        ind = floor(t/fenetre) + 1;
        [~, EstimBestExpert] = max(Proba);
        
        if (EstimBestExpert ~= BestExpert(ind)) % Restart criterion
            Restart = t+1;k
        end
        Localisation = [Localisation EstimBestExpert];
        bernoullisMean = BernoullisMeanMatrix(ind);
        reward = rand() < bernoullisMean;
        [Proba, Likelihood, ValRunlength] = updateChangeModel(Proba, alphas,betas,reward,gamma,...
            ValRunlength);
        [alphas, betas] = updateArmModel(alphas,betas, reward, alpha0, beta0);
        t = t+1;
    end
    GeneralLoc = [GeneralLoc; Localisation]; 
    GenVectRestart  = [GenVectRestart ; vectRestart];
    toc
end
figure; 

plot(mean(GeneralLoc,1),'r.')