clear;
close all;
Methods  = {'PCA','MetricMDS','Sammon','nonMetricMDS','tSNE','AutoEncoder','LLE','Isomap'};

IntrinsicDims   = 2:20;
NumOfComponents = 2;

% data params
Params.nSubjects   = 1;
Params.nRuns       = 1 ;
Params.nConditions = 64;
Params.NoiseLevel  = 0.2;
Params.SpatialSmoothingWindow  = 5;
Params.TemporalSmoothingWindow = 5;
Params.Clustered = true;

ClusterColors = [1 0.5 0 ; 1 0 0 ; 0 1 0; 0 0.5 1];
Colors        = MakeClusterColors(ClusterColors,Params.ClusterSizes);

Obj    = VideoWriter('IntrinsicDimensionality.avi');
Obj.FrameRate = 1;
open(Obj);

figure('units','normalized','position',[0 0 1 1]);
Params.IntrinsicDimensionality   = 2;
[~,~,StimulusSpace,Params] = SimulateDataset(Params);
subplot(5,4,2:3);
scatter(StimulusSpace(:,1),StimulusSpace(:,2),100,Colors,'filled');
axis('equal','tight','off');
title('Ground truth', 'Units','inches','FontSize',16,'Position',[0.5,-0.5,0]);

for k = 1:numel(IntrinsicDims)
    Params.IntrinsicDimensionality   = IntrinsicDims(k);
    [DataSet,~,StimulusSpace,Params] = SimulateDataset(Params);
    X = squeeze(DataSet(1,1,:,:));
    for j  = 1:numel(Methods)
        c  = double(j<5); 
        h = subplot(5,4,c*(j + 4) + (1-c) *(j+8));
        p = get(h,'Position');set(h,'Position',[p(1) p(2) p(3) 0.1]);
        text(0,0.5,Methods{j},'Fontsize',18);
        axis('tight','off');

        Y = DimensionReduction(X,NumOfComponents,Methods{j});
        
        h = subplot(5,4,c*(j + 8) + (1-c) *(j+12));
        p = get(h,'Position');set(h,'Position',[p(1) p(2) p(3) 1.5*p(4)]);
        scatter(Y(:,1),Y(:,2),100,Colors,'filled'); axis('equal','tight','off');
    end
    
    subplot(5,4,1)
    cla;
    txt = sprintf('Intrinsic Dimensionality = %d',IntrinsicDims(k));
    axis('off')
    text(0,0.5,txt,'FontSize',20);
    
    drawnow;
    frame = getframe(gcf);
    writeVideo(Obj,frame);
    
    img = frame2im(frame);
    [img,cmap] = rgb2ind(img,256);
    if k == 1
        imwrite(img,cmap,'IntrinsicDimensionality.gif','gif','LoopCount',Inf,'DelayTime',1);
    else
        imwrite(img,cmap,'IntrinsicDimensionality.gif','gif','WriteMode','append','DelayTime',1);
    end
end

close(Obj);
