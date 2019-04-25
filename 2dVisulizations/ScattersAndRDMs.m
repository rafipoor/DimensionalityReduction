clear;
close all;
Methods  = {'PCA','MetricMDS','Sammon','nonMetricMDS','tSNE','AutoEncoder','LLE','Isomap'};

NumOfComponents = 2;
% data params
Params.NoiseLevel  = 10;
Params.nSubjects   = 1;
Params.nRuns       = 1 ;
Params.nConditions = 64;
Params.IntrinsicDimensionality = 30;
Params.SpatialSmoothingWindow  = 1;
Params.TemporalSmoothingWindow = 1;
Params.Clustered = true;
[DataSet,~,StimulusSpace,Params] = SimulateDataset(Params);
%Colors = distinguishable_colors(4);
ClusterColors = [1 0.5 0 ; 1 0 0 ; 0 1 0; 0 0.5 1];
Colors = MakeClusterColors(ClusterColors,Params.ClusterSizes);

for j  = 1:numel(Methods)
    X = squeeze(DataSet(1,1,:,:));
    Y = DimensionReduction(X,NumOfComponents,Methods{j});
    ProjRDM = squareform(pdist(Y));
    subplot(1,2,1);
    scatter(Y(:,1),Y(:,2),500,Colors,'filled'); axis('equal','tight','off');
    subplot(1,2,2);
    colormap(RDMcolormap)
    imagesc(ProjRDM); axis('equal','tight','off'); colorbar;
    suptitle(Methods{j});
    filename = sprintf('Scatter_%s.png',Methods{j});
    MyPrint(filename);
end

GroundTruthRDM = pdist(StimulusSpace);
showRDMs(GroundTruthRDM);
MyPrint('GroundTruth.png');
