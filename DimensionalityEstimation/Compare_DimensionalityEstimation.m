%%
clear;
close all;
Methods  = {'PCA','MetricMDS','Sammon','nonMetricMDS','tSNE','AutoEncoder','LLE','Isomap'};
IntrinsicDims    = 2:6;
Params.nSubjects = 15;
Params.NoiseLevel= 0.1;

AllEstimates = zeros(numel(Methods),numel(IntrinsicDims),Params.nSubjects);
Colors       = distinguishable_colors(numel(Methods));

%% main loop
for i = 1:numel(IntrinsicDims)
    figure;
    hold on;
    Params.IntrinsicDimensionality = IntrinsicDims(i);
    [DataSet,~,~,Params] = SimulateDataset(Params);
    for j=1:numel(Methods)
        AllEstimates(j,i,:) = EstimateDimensionality(DataSet,Methods{j},Colors(j,:));
        disp(j);
    end
    title(i);
    disp(i);
end
clear DataSet
save('Compare_DimensionalityEstimation');
xlabel('Dimensionality');
ylabel('Similarity');
MyPrint('DimensionalityCurves.png');
close all;
%%
load('Compare_DimensionalityEstimation.mat')
Offsets = linspace(-0.3,0.3,6);
hold on
plot(IntrinsicDims,IntrinsicDims,'k--','LineWidth',2);
set(gca,'XTick',IntrinsicDims,'YTick',IntrinsicDims);
axis square
xlabel('Intrinsic Dimensionality');
ylabel('Estimated dimensionality');

%% 
for j = 1:numel(Methods)
    data = squeeze(AllEstimates(j,:,:))';
    h1 = shadedErrorBar(IntrinsicDims,median(data),CI(data),...
        'lineprops',{'LineWidth',1,'Color',0.6 * [1 1 1]});
    h2 = plot(IntrinsicDims,median(data),'LineWidth',3,'Color',Colors(j,:));
    ylim([min(IntrinsicDims),max(IntrinsicDims)]);
    title(Methods{j})
    MyPrint(sprintf('DimensionalityEstimation_Shaded_%s.png',Methods{j}));
    delete([h1.edge h1.mainLine h1.patch]); 
    delete(h2)
end
