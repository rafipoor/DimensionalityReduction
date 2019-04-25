clear;
close all;
for j=1:30
    load(sprintf('../Data/Categorical2D/%03d.mat',j));
    hold on;
    for i=1:size(Data,1)
        plot([Data(i,1),Signal(i,1)], [Data(i,2),Signal(i,2)],'k')
    end
    scatter(Data(:,1),Data(:,2),[],'r','filled');
    scatter(Signal(:,1),Signal(:,2),[],'b','filled');
    pause;
    cla;
end