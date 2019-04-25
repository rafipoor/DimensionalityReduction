clear;
close all;

nSamples = 50;
nDims    = 30;
IntrinsicDim = 15;

Methods = {'PCA','MDS','tSNE','LLE','Isomap','Laplacian\newlineEigenmaps'};
X    = randn(nSamples,IntrinsicDim)*randn(IntrinsicDim,nDims);
RDMs = zeros(nchoosek(nSamples,2),numel(Methods));

for i = 1:numel(Methods)
    Y = DimensionReduction(X,2,Methods{i});
    RDMs(:,i) = pdist(Y);
end
MethodsSimilarity = nan(numel(Methods));
MethodsPvalue     = nan(numel(Methods));

for i = 1:numel(Methods)
    for j = (i+1):numel(Methods)
     [MethodsPvalue(i,j),MethodsSimilarity(i,j)] = ...
         PermutationTest(RDMs(:,i),RDMs(:,j),1000,0);
    end
end

%%
close all
imagesc(MethodsSimilarity,'AlphaData',~isnan(MethodsSimilarity));
set(gca,'XTick',1:numel(Methods),'YTick',1:numel(Methods),...
    'XTickLabel',Methods,'YTickLabel',Methods,'XAxisLocation','top',...
    'XTickLabelRotation',30,'YTickLabelRotation',30,'Color',get(gcf,'Color')...
    ,'YAxisLocation','right');
axis('equal','tight')
title('Correlations');
colorbar;
box('off');
caxis([0,1]);
MyPrint('RDMCorrelations.png');

figure;
imagesc(MethodsPvalue,'AlphaData',~isnan(MethodsPvalue));
set(gca,'XTick',1:numel(Methods),'YTick',1:numel(Methods),...
    'XTickLabel',Methods,'YTickLabel',Methods,'XAxisLocation','top',...
    'XTickLabelRotation',30,'YTickLabelRotation',30,'Color',get(gcf,'Color')...
    ,'YAxisLocation','right');
axis('equal','tight');
title('Pvalue of Correlations');
colorbar;
box('off');

MyPrint('RDMCorrelationPvalues.png');