close;
clear;
nPoints = 250;

x2d = 2*rand(nPoints,2)-1;
[~,Idx] = sort( x2d(:,2));
x2d = x2d(Idx,:);

x3d = zeros(nPoints,3);
t = linspace(0,1,nPoints)';
f = 50;
x3d(:,1) = x2d(:,1);      
x3d(:,2) = t.*cos(f*t);
x3d(:,3) = -t.*sin(f*t);
noise = 0.02*randn(nPoints,3);
x3d   = x3d + noise;

Colors = jet(nPoints);
hold on
scatter3(x3d(:,1),x3d(:,2),x3d(:,3),30,Colors,'fill');

view(3)
axis('equal');
xlabel('channel 1');ylabel('channel 2'),zlabel('channel 3');
set(gca,'XTickLabel',[],'YTickLabel',[],'LineWidth',2,...
    'ZTickLabel',[]);
grid('on');
MyPrint('SwissRoll3dplotjet.png');

figure;
set(gcf,'Color','w');
hold on;
scatter3(x2d(:,2),x2d(:,1),0*x2d(:,1),100,Colors,'fill');
set(gca,'XTickLabel',[],'YTickLabel',[],'LineWidth',2,...
    'ZTickLabel',[]);
grid('on');
axis('tight');
xlabel('Dimension 1');ylabel('Dimension 2')

%MyPrint('SwissRoll2dsparse');
