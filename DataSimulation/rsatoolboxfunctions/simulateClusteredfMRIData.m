function [B_True,B_Estimated] = simulateClusteredfMRIData(simulationOptions)
%Hossein Edit: I changed output format, you should pass the number of runs
%in simulationoptions.nRuns
%% Generate B patterns
B_True = generateBetaPatterns(simulationOptions.clusterSpec, ...
    prod(simulationOptions.volumeSize_vox));

nConditions = size(B_True, 1);
nVoxels = size(B_True,2);

%% Generate X
sequence = [repmat(1:nConditions,1,simulationOptions.nRepititions),...
    (nConditions+1)*ones(1,ceil(nConditions*simulationOptions.nRepititions/3))];
sequence = randomlyPermute(sequence);
nTrials = numel(sequence);
nTRvols = (simulationOptions.trialDuration/simulationOptions.TR)*nTrials;
nSkippedVols = 0;
monitor = 0;
scaleTrialResponseTo1 = 1;

[X,~,~,~] = ...
    generateCognitiveModel_fastButTrialsNeedToStartOnVols...
    (sequence,simulationOptions.stimulusDuration*1000,...
    simulationOptions.trialDuration*1000,nTRvols,...
    simulationOptions.TR*1000,nSkippedVols,monitor,scaleTrialResponseTo1);

nTimePoints = size(X,1);
sig = sqrt(simulationOptions.scannerNoiseLevel);
RunWiseBetaEstimate = zeros(size(B_True,1),size(B_True,2),simulationOptions.nRuns);
for o = 1:simulationOptions.nRuns    
    %% Generate E matrix
    E = randn(nTimePoints, nVoxels);
    E = sig * E;
    
    [E, ~] = spatiallySmooth4DfMRI_mm...
        (E, simulationOptions.volumeSize_vox, ...
        simulationOptions.spatiotemporalSmoothingFWHM_mm_s(1:3),...
        simulationOptions.voxelSize_mm);
    
    % Smooth across time
    E = temporallySmoothTimeSpaceMatrix...
        (E, simulationOptions.spatiotemporalSmoothingFWHM_mm_s(4) /...
        simulationOptions.TR);
    
    %% Do GLM for Y_true matrix
    Y_true = X * B_True;
    
    %% Do GLM for Y_noise matrix
    Y_noisy = Y_true + E;
    RunWiseBetaEstimate(:,:,o) = (X' * X) \ X' * Y_noisy;    
end
B_Estimated = mean(RunWiseBetaEstimate,3);
end