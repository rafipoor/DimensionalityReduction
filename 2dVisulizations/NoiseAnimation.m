clear;
close all;
Methods  = {'PCA','MetricMDS','Sammon','nonMetricMDS','tSNE','AutoEncoder','LLE','Isomap'};

NoiseLevels     = fliplr([0:0.05:3 4:10 20]);
NumOfComponents = 2;

% data params
Params.nSubjects   = 1;
Params.nRuns       = 1 ;
Params.nConditions = 64;
Params.IntrinsicDimensionality = 2;
Params.SpatialSmoothingWindow  = 5;
Params.TemporalSmoothingWindow = 5;
Params.Clustered = true;

ClusterColors = [1 0.5 0 ; 1 0 0 ; 0 1 0; 0 0.5 1];

Obj    = VideoWriter('NoiseAnimation.avi');
Obj.FrameRate = 1;
open(Obj);
figure('units','normalized','position',[0 0 1 1]);
for k = 1:numel(NoiseLevels)
    Params.NoiseLevel  = NoiseLevels(k);
    [DataSet,~,StimulusSpace,Params] = SimulateDataset(Params);
    Colors  = MakeClusterColors(ClusterColors,Params.ClusterSizes);

    X = squeeze(DataSet(1,1,:,:));
    subplot(5,4,2:3);
    scatter(StimulusSpace(:,1),StimulusSpace(:,2),100,Colors,'filled');
    axis('equal','tight','off');
    title('Ground truth', 'Units','inches','FontSize',16,'Position',[1,-0.5,0]);
    
    for j  = 1:numel(Methods)
        Y = DimensionReduction(X,NumOfComponents,Methods{j});
        [~,Yadj] = procrustes(StimulusSpace,Y);

        c  = double(j<5);
        h = subplot(5,4,c*(j + 4) + (1-c) *(j+8));
        p = get(h,'Position');set(h,'Position',[p(1) p(2) p(3) 0.1]);
        text(0,0.5,Methods{j},'Fontsize',18);
        axis('tight','off');                
                
        h = subplot(5,4,c*(j + 8) + (1-c) *(j+12));
        p = get(h,'Position');set(h,'Position',[p(1) p(2) p(3) 1.5*p(4)]);
        scatter(Yadj(:,1),Yadj(:,2),100,Colors,'filled'); axis('equal','tight','off');
    end
    
    subplot(5,4,1)
    cla;
    txt = sprintf('Level of noise = %2.2f',NoiseLevels(k));
    axis('off')
    text(0,0.5,txt,'FontSize',20);

    drawnow;
    frame = getframe(gcf);
    writeVideo(Obj,frame);
    
    img = frame2im(frame);
    [img,cmap] = rgb2ind(img,256);
    if k == 1
        imwrite(img,cmap,'Noise.gif','gif','LoopCount',Inf,'DelayTime',1);
    else
        imwrite(img,cmap,'Noise.gif','gif','WriteMode','append','DelayTime',1);
    end
end

close(Obj);
