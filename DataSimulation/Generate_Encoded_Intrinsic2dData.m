
clear;
nSubjects  = 30;
nSamples   = 92;   % number of points
nVoxels    = 2;  % dimension of emmbedding space
dIntrinsic = 2;
NoiseStd   = eps;
ConfigurationName = 'Encoded2D';
EncodingMat = eye(2);%randn(dIntrinsic,nVoxels);

RunInfo     = sprintf('%s: nSamples=%d dIntrinsic=%d dData=%d noisestd=%1.2f',...
    ConfigurationName,nSamples,dIntrinsic,nVoxels);
FolderName = fullfile('..','Data',ConfigurationName);
mkdir(FolderName);
save(fullfile(FolderName,'SimulationOptions'));
load('WhiteNoise.mat');
Mu             = zeros(dIntrinsic,1);
Signal         = mvnrnd(Mu,eye(dIntrinsic),nSamples);
EncodedSignal  = Signal* EncodingMat;
TrueCovariance = cov(EncodedSignal);


for sID = 1:nSubjects
    Noise          = NoiseStd * WhiteNoise(1:nSamples,1:nVoxels,sID);
    Data           = EncodedSignal + Noise;
    Data           = bsxfun(@minus,Data,mean(Data));%centering
    nConditions    = nSamples;
    fName          = fullfile(FolderName,sprintf('%03d',sID));
    save(fName,'Data','Signal');
end

