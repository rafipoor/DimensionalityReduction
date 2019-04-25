function [DataSet,TrueBetas,Signal,Params] = SimulateDataRSAT(Params)
if nargin==0
    Params=[];
end
%s = RandStream('mcg16807', 'seed', 5);
%RandStream.setGlobalStream(s);
Params            = FillMissingParams(Params);
simulationOptions = SetSimulationOptions(Params);

DataSet = nan(Params.nSubjects,Params.nRuns,...
    Params.nConditions,Params.nVoxels);
TrueBetas = nan(Params.nSubjects,Params.nConditions,Params.nVoxels);
Signal    = nan; % just for correspondance with the other function

for subI = 1:Params.nSubjects
 %   fprintf('simulating data Dafor subject %d \n',subI)
    [B_true,fMRI_a,fMRI_b] = simulateClusteredfMRIData(simulationOptions);
    TrueBetas(subI,:,:) = B_true;
    DataSet(subI,1,:,:) = fMRI_a.B;
    DataSet(subI,2,:,:) = fMRI_b.B;
end
Params.nConditions = size(DataSet,3);
end

function Params = FillMissingParams(Params)
if isempty(Params); Params = struct(); end
if(~isfield(Params,'nSubjects'));   Params.nSubjects  = 30;  end
if(~isfield(Params,'nRuns'));       Params.nRuns      = 2;   end
if(~isfield(Params,'Repetition'));  Params.Repetition = 10;  end
if(~isfield(Params,'nConditions')); Params.nConditions= 64;  end
if(~isfield(Params,'nVoxels'));     Params.nVoxels    = 343; end
if(~isfield(Params,'NoiseLevel'));  Params.NoiseLevel = 15;  end
if(~isfield(Params,'IntrinsicDimensionality'))
    Params.IntrinsicDimensionality  = 2;
end
if(~isfield(Params,'TemporalSmoothingWindow'))
    Params.TemporalSmoothingWindow  = 3;
end
if(~isfield(Params,'SpatialSmoothingWindow'))
    Params.SpatialSmoothingWindow   = 3;
end
Params.nTrials = Params.nConditions * Params.Repetition;
end

function simulationOptions = SetSimulationOptions(Params)
simulationOptions.volumeSize_vox = [7 7 7];
simulationOptions.voxelSize_mm = [3 3 3.75];
simulationOptions.nRepititions = Params.Repetition;
simulationOptions.stimulusDuration = 0.3;
simulationOptions.trialDuration = 3;
simulationOptions.TR = 1.5; % seconds
simulationOptions.scannerNoiseLevel = 10000 * Params.NoiseLevel;
simulationOptions.spatiotemporalSmoothingFWHM_mm_s = [4 4 4 4.5];
simulationOptions.clusterSpec = ...
    {2, {1, {0.5, 16},{0.5, 16}},{1,{0.5, 16},{0.5, 16}}};
end
