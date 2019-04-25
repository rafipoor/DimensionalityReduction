close;
clear;

nPoints = 2000;
Start   = 50;
Steps   = 50;
x2d     = 2*rand(nPoints,2)-1;
[~,Idx] = sort( x2d(:,2));
x2d     = x2d(Idx,:);

x3d = zeros(nPoints,3);
t   = linspace(0,1,nPoints)';
f   = 10;
x3d(:,1) = x2d(:,1);
x3d(:,2) = t.*cos(f*t);
x3d(:,3) = -t.*sin(f*t);
noise  = 0.02*randn(nPoints,3);
x3d    = x3d + noise;
Colors = flipud(jet(nPoints));


Perm  = randperm(nPoints);
x3d   = x3d(Perm,:);
Colors= Colors(Perm,:);

Obj  = VideoWriter('nSamples.avi');
Obj.FrameRate = 10;
open(Obj);

hold on
h = scatter3(x3d(:,1),x3d(:,2),x3d(:,3),1,'w');
delete(h);
scatter3(x3d(1:Start,1),x3d(1:Start,2),x3d(1:Start,3),50,'r','fill');
view(-75,10)
axis('equal');
set(gca,'XTickLabel',[],'YTickLabel',[],'LineWidth',2,...
    'ZTickLabel',[]);
grid('on');
MyPrint('tmp.png');
drawnow;
frame = getframe(gcf);
writeVideo(Obj,frame);
%scatter3(x3d(1:Start,1),x3d(1:Start,2),x3d(1:Start,3),70,'k');

for i = Start:Steps:nPoints-1
    drawnow;
    frame = getframe(gcf);
    writeVideo(Obj,frame);
    scatter3(x3d(i:i+Steps,1),x3d(i:i+Steps,2),x3d(i:i+Steps,3),50,'k','fill');
end

close(Obj);
