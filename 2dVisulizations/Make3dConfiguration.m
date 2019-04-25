clear;
close all;
 i = 10;
 r = 100;
NumOfComponents = 3;
% data params
Params.NoiseLevel  = 10;
Params.nSubjects   = 1;
Params.nRuns       = 1;
Params.nConditions = 64;
Params.IntrinsicDimensionality = 30;
Params.SpatialSmoothingWindow  = 1;
Params.TemporalSmoothingWindow = 1;
Params.Clustered = true;
[DataSet,~,StimulusSpace,Params] = SimulateDataset(Params);
%Colors = distinguishable_colors(4);
ClusterColors = [1 0.5 0 ; 1 0 0 ; 0 1 0; 0 0.5 1];
Colors        = MakeClusterColors(ClusterColors,Params.ClusterSizes);

X = squeeze(DataSet(1,1,:,:));
Y = DimensionReduction(X,NumOfComponents,'PCA');
ProjRDM = squareform(pdist(Y));
subplot(1,2,1);
scatter3(Y(:,1),Y(:,2),Y(:,3),500,Colors,'filled'); axis('equal','tight');
hold on
[xs,ys,zs] = sphere;
surf(r*xs-Y(i,1),r*ys-Y(i,2),r*zs-Y(i,3),'EdgeColor','none','FaceAlpha',.25,...
    'FaceColor',[.6,.6,.6]);

view(3);
set(gca,'XTickLabel',[],'YTickLabel',[],'ZTickLabel',[]);
grid('on');

subplot(1,2,2);
colormap(RDMcolormap)
imagesc(ProjRDM); axis('equal','tight','off'); colorbar;
filename = sprintf('3DConfigurationWithNeigbours.png');
MyPrint(filename);
