close;
clear;
nPoints = 5000;

x2d = 2*rand(nPoints,2)-1;
[~,Idx] = sort(x2d(:,1) + 2*x2d(:,2));
x2d = x2d(Idx,:);
w = rand(2,3)-0.5;
w = w/norm(w(:));
noise = 0.05*randn(nPoints,3);
x3d = x2d*w + noise;

Colors = hsv(nPoints);
hold on

Normal = null(w)';
Dist   = -(Normal * x3d(1,:)')/norm(Normal);
[xs,ys,zs] = plane_surf(Normal,Dist,1.05);
xs = imresize(xs,15);
ys = imresize(ys,15);
zs = imresize(zs,15);

surf(xs,ys,zs,'FaceAlpha',0.25,'EdgeColor','k');
scatter3(x3d(:,1),x3d(:,2),x3d(:,3),30,Colors,'fill');

Normal = [0,0,1];
Dist   = 0;
[xs,ys,zs] = plane_surf(Normal,Dist,2);
%surf(xs,ys,zs,'FaceAlpha',0.25);
%scatter3(x2d(:,1),x2d(:,2),0*x2d(:,1)-3,30,Colors,'fill');

view(3)
axis('equal');
xlabel('channel 1');ylabel('channel 2'),zlabel('channel 3');
set(gca,'XTickLabel',[],'YTickLabel',[],'LineWidth',2,...
    'ZTickLabel',[]);
grid('on');

Fname = '3dplot4.png';
MyPrint(Fname);

figure;
Normal = [0,0,1];
Dist   = 0;
[xs,ys,zs] = plane_surf(Normal,Dist,1.1);
xs = imresize(xs,15);
ys = imresize(ys,15);
zs = imresize(zs,15);

hold on;
%surf(xs,ys,zs,'FaceAlpha',0.25);
scatter3(x2d(:,1),x2d(:,2),0*x2d(:,1),100,Colors,'fill');
set(gca,'XTickLabel',[],'YTickLabel',[],'LineWidth',2,...
    'ZTickLabel',[]);
grid('on');
axis('tight','equal');
xlabel('Dimension 1');ylabel('Dimension 2')
Fname = '2dplot.png';
MyPrint(Fname);

