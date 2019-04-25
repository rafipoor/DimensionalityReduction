clear;
close all;
load('Kriegeskorte_Neuron2008_supplementalData.mat');
nConditions = 92;
load('92_brainRDMs');
DataRDM   = double(RDMs(1,4,2).RDM);
% Positions = DimensionReduction(tril(DataRDM),2,'Isomap')*200;
Positions = rand(92,2)+3;

hold on
for i = 1:nConditions
    img = flipud(stimuli_92objs(i).image);
    TrMask = 1 - all(img == 128,3);
    image(Positions(i,1),Positions(i,2),img,'CDataMapping', 'direct',...
        'AlphaData',TrMask);
end
axis('off');
MyPrint('ScatterPlot.png');
%figure
showRDMs(DataRDM);
MyPrint('RDM.png');