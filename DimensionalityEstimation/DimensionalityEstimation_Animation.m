%%
clear;
close all;
Methods  = {'PCA','MetricMDS','Sammon','nonMetricMDS','tSNE','AutoEncoder','Isomap'};
IntrinsicDims    = 2:6;
Params.nSubjects = 3;
Params.nRuns     = 4;
Params.NoiseLevel= 0.05;

AllEstimates = zeros(numel(Methods),numel(IntrinsicDims),Params.nSubjects);

Colors  = distinguishable_colors(numel(Methods));
Obj    = VideoWriter('EstimateAnimation.avi');
Obj.FrameRate = 1;
open(Obj);
figure('units','normalized','position',[0 0 1 1]);

%% main loop
for i = 1:numel(IntrinsicDims)
    clf;
    hold on;
    Params.IntrinsicDimensionality = IntrinsicDims(i);
    [DataSet,~,~,Params] = SimulateDataset(Params);
    for j=1:numel(Methods)
        AllEstimates(j,i,:) = EstimateDimensionality(DataSet,Methods{j},Colors(j,:));
        disp(j);
    end
    plot([IntrinsicDims(i),IntrinsicDims(i)],[0,1],'k--','LineWidth',3);
    title(sprintf('Intrinsic Dimensionality = %d',IntrinsicDims(i)));
    xlabel('Number of Dimensions'); ylabel('Across Run Similarity');
    MyPrint(sprintf('DimensionalityCurves%d.png',IntrinsicDims(i)));
    frame = getframe(gcf);
    writeVideo(Obj,frame);
end
close(Obj);
clear DataSet
save('Compare_DimensionalityEstimation');

%% 
load('Compare_DimensionalityEstimation.mat')
figure; hold on;
Offsets = linspace(-0.3,0.3,6);
for j=1:numel(Methods)
    data = squeeze(AllEstimates(j,:,:))';
    shadedErrorBar(IntrinsicDims,median(data),CI(data),...
        'lineprops',{'LineWidth',1,'Color',0.6 * [1 1 1]});
    plot(IntrinsicDims,median(data),'LineWidth',3,'Color',Colors(j,:));
end

plot(IntrinsicDims,IntrinsicDims,'k--','LineWidth',2);
axis('tight','equal');
set(gca,'XTick',IntrinsicDims,'YTick',IntrinsicDims);
xlabel('Intrinsic Dimensionality');
ylabel('Estimated');
MakeLegends(Colors,Methods);
MyPrint('DimensionalityEstimation_Shaded.png');
