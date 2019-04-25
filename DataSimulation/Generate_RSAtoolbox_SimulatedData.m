clear;
close all;
ConfigurationName = 'RSADemo1';
FolderName        = fullfile('..','Data',ConfigurationName);
mkdir(FolderName);
load simTruePatterns.mat;
load WhiteNoise.mat;

nSubjects   = 30;
NoiseStd    = 1;
nVoxels     = 100; 
nCond       = size(simTruePatterns2,1);
EncodingMat = randn(size(simTruePatterns2,2),nVoxels);

save(fullfile(FolderName,'SimulationOptions'));
for sID   = 1:nSubjects
    Signal= simTruePatterns2;
    Data  = simTruePatterns2*EncodingMat + NoiseStd*WhiteNoise(1:nCond,1:nVoxels,sID) ;
    Data  = bsxfun(@minus,Data,mean(Data));
    fName = fullfile(FolderName,sprintf('%03d',sID));
    save(fName,'Data','Signal');
end

