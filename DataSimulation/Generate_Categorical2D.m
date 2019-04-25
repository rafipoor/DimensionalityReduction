clear;
nSubjects  = 30;
nSamples   = 96;   % number of points
nVoxels    = 125;  % dimension of emmbedding space
nCategories = 2;
dIntrinsic = nVoxels;
ConfigurationName = 'Categorical';

RunInfo = sprintf('%s: nSamples=%d dIntrinsic=%d dData=%d',...
    ConfigurationName,nSamples,dIntrinsic,nVoxels);
FolderName = fullfile('..','Data',ConfigurationName);
mkdir(FolderName);
save(fullfile(FolderName,'SimulationOptions'));
load('WhiteNoise.mat');
for sID = 1:nSubjects
    CategoriIdx   = randi(nCategories,nSamples,1);
    CategoriMeans = random('uniform',-5,5,nCategories,dIntrinsic);
    Mu     = zeros(dIntrinsic,1);
    Signal = mvnrnd(Mu,eye(dIntrinsic),nSamples);
    for i=1:nCategories
        Signal(CategoriIdx==i,:) = ...
            bsxfun(@plus,Signal(CategoriIdx==i,:),CategoriMeans(i,:));
    end
    Signal = bsxfun(@minus,Signal,mean(Signal));
    nConditions = nSamples;
    fName = fullfile(FolderName,sprintf('%03d',sID));
    save(fName,'Signal','CategoriIdx');
end

