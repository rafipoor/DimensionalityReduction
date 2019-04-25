clear;
close all;
Methods  = {'PCA'};
Params.nSubjects = 5;
Params.nRuns     = 2;
Params.NoiseLevel= 0.1;
Params.IntrinsicDimensionality = 4;

Colors  = distinguishable_colors(numel(Methods));
figure('units','normalized','position',[0 0 1 1]);

hold on;
[DataSet,~,~,Params] = SimulateDataset(Params);
EstimateDimensionality(DataSet,Methods{1},Colors(1,:));
plot([4,4],[0,1],'k--','LineWidth',3);
xlim([1,8]);
title(sprintf('Intrinsic Dimensionality = %d',4));
xlabel('Number of Dimensions'); ylabel('Across Run Similarity');
MyPrint('DimensionalityCurve.png');

