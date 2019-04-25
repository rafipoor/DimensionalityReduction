clear;
close all;
for j=1:30
    load(sprintf('../Data/RSADemo1/%03d.mat',j));
    subplot(2,2,1)
    imagesc(Signal); colorbar; title('Signal');
    subplot(2,2,3)
    imagesc(Data); colorbar;   title('Data');
    
    subplot(2,2,2)
    imagesc(squareform(pdist(Signal))); colorbar; title('Signal RDM');
    subplot(2,2,4)
    imagesc(squareform(pdist(Data))); colorbar;   title('Data RDM');
    pause;
end