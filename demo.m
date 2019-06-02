%% Demonstration of four versions of the Bayesian Online Change-point Detector

% environment -> Piece-wise stationary Bernoulli Distributions


%% Define the environment
environment = [0.8*ones(1,300)... 
               0.4*ones(1,400)...
               0.9*ones(1,350)...
               0.5*ones(1,200)]; % Piecewise stationary Bernoulli Distributions
           
NbrRuns= 300; % Nbr Run
%% Bayesian Online Change-point detector with restart

[CP_Original_restart]= BOCD_restart(environment, NbrRuns); % Original version (Adams 2007) + Restart procedure
[CP_Modified_restart]= BOCDm_restart(environment, NbrRuns); % Modified version + Restart procedure

%% Bayesian Online Change-point detector  without restart

[CP_Original]= BOCD(environment, NbrRuns); % Original version (Adams 2007)
[CP_Modified]= BOCDm(environment, NbrRuns); % Modified version (proposed in Neurips 2019)

%% Plotting the results

vectChangePoint = [1 301 701 701+350]; % Change-point position (for plotting purposes)
close all
p = PlottingResults(CP_Modified_restart, CP_Original_restart, vectChangePoint); % Plotting results for restart version of BOCD and BOCDm
PlottingResults(CP_Modified, CP_Original, vectChangePoint); %Plotting results for original version of BOCD and BOCDm (without restart)