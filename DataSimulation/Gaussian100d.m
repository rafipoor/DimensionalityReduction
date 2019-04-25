clear;
nSubjects  = 30;
nSamples   = 96;   % number of points
nVoxels    = 125;  % dimension of emmbedding space
dIntrinsic = 125;
dIrrelevant= nVoxels - dIntrinsic; 
SignalRho  = 0;
NoiseStd   = 0.1; 
ConfigurationName = 'Gaussian';

RunInfo = sprintf('%s: nSamples=%d dIntrinsic=%d dData=%d noisestd=%1.2f',...
    ConfigurationName,nSamples,dIntrinsic,nVoxels);
FolderName = fullfile('..','Data',ConfigurationName);
mkdir(FolderName);
save(fullfile(FolderName,'SimulationOptions'));
load('WhiteNoise.mat');

for sID = 1:nSubjects
    Mu     = zeros(dIntrinsic,1);
    Signal = mvnrnd(Mu,eye(dIntrinsic)+SignalRho*ones(dIntrinsic),nSamples);
    Noise  = NoiseStd * WhiteNoise(1:nSamples,1:nVoxels,sID);
    TrueCovariance = cov(Signal);
    Data   = [Signal zeros(nSamples,dIrrelevant)] + Noise;
    Data   = bsxfun(@minus,Data,mean(Data));%centering
    nConditions = nSamples;
    fName = fullfile(FolderName,sprintf('%03d',sID));
    save(fName,'Data','Signal');
end

