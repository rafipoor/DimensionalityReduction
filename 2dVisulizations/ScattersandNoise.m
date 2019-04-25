clear;
close all;
Methods  = {'PCA','MetricMDS','Sammon','nonMetricMDS','tSNE','AutoEncoder','LLE','Isomap'};

NumOfComponents = 2;
% data params
Params.NoiseLevel  = 0;
Params.nSubjects   = 1;
Params.nRuns       = 1 ;
Params.nConditions = 64;
Params.IntrinsicDimensionality = 2;
Params.SpatialSmoothingWindow  = 5;
Params.TemporalSmoothingWindow = 5;
Params.Clustered = true;
[DataSet,~,StimulusSpace,Params] = SimulateDataset(Params);
%Colors = distinguishable_colors(4);
ClusterColors = [1 0.5 0 ; 1 0 0 ; 0 1 0; 0 0.5 1];
Colors = MakeClusterColors(ClusterColors,Params.ClusterSizes);

for j  = 4:numel(Methods)
    X = squeeze(DataSet(1,1,:,:));
    Y = DimensionReduction(X,NumOfComponents,Methods{j});
    ProjRDM = squareform(pdist(Y));
    
    subplot(1,2,1);
    scatter(StimulusSpace(:,1),StimulusSpace(:,2),500,Colors,'filled'); axis('equal','tight','off');
    subplot(1,2,2);
    scatter(Y(:,1),Y(:,2),500,Colors,'filled'); axis('equal','tight','off');
    suptitle(Methods{j});
    
    drawnow;
    filename = sprintf('Scatters_%s.png',Methods{j});
    MyPrint(filename);

end
