function [verticesX,verticesY]=HoneycombPattern(L,R,C)
% 函数HoneycombPattern在已知矩形窗内绘制蜂窝状图案
% 参数说明：
%? ? L为正六边形边长
%? ? R为蜂窝行数，C为蜂窝列数
% 调用举例：
%? ? HoneycombPattern;
%? ? HoneycombPattern(5)
%? ? HoneycombPattern(1,[50 40])
% 作者：洪垚
% Time：2020/11/20

L1=C*sqrt(3)/2*L;
W1=(3*R+1)/4*L;
close all;
%生成六边形的各个中心坐标
center=GenerateCenter(L,R,C);
%根据每一个中心坐标得出每一个中心对应得6个顶点
[verticesX,verticesY]=GenerateVertices(center,L);
figure(1)
%patch函数是matlab自带函数，用于绘制多边形甚至是多面体，just help一下
%绘制矩阵窗
patch([L1,-L1,-L1,L1],...
      [W1,W1,-W1,-W1],'w')
%挥着六边形
patch(verticesX,verticesY,'w');
axis equal;
set(gca,'xlim',[-L1,L1],'ylim',[-W1,W1])
hold on
scatter(L*cos(pi/6),L*sin(pi/6),'r','filled');
hold on
grid on
grid minor
%图2美化一下
% figure(2)
% patch([0 H(1) H(1) 0],[0 0 H(2) H(2)],'b')
% hold on
% patch(verticesX,verticesY,'r');
% axis equal off;
% %图3利用fill函数绘制
% figure(3)
% fill([0 H(1) H(1) 0],[0 0 H(2) H(2)],'b')
% hold on
% h=fill(verticesX,verticesY,'r');
% set(h(16:end),'facecolor','y')
% axis equal off;
end

function center=GenerateCenter(L,R,C)
%函数GenerateCenter根据六边形的边长L和矩形H确定需要填充的六边形的各个中心和数量
%函数大致思想是分六边形的行数奇偶求对应得中心坐标
%ncol为做多容纳六边形列数（奇数行ncol1，偶数行ncol2)
if mod(R,2)==1
    R=R+1;
end
if mod(C,2)==1
    C=C+1;
end
r=floor(R/2);c=floor(C/2);
%奇数层的坐标
center_x1 = (-c:c)*L*sqrt(3);
if mod(r,2)==0
    center_y1 = (-ceil(r/2):ceil(r/2))*3*L;
end
if mod(r,2)==1
    center_y1 = ((-ceil(r/2)+1):(ceil(r/2)-1))*3*L;
end
%偶数层的坐标
center_x2 = ((-c+0.5):(c-0.5))*L*sqrt(3);
center_y2 = ((-ceil(r/2)+0.5):(ceil(r/2)-0.5))*3*L;
[center_X1,center_Y1]=meshgrid(center_x1,center_y1);
[center_X2,center_Y2]=meshgrid(center_x2,center_y2);
center=[center_X1(:) center_Y1(:);center_X2(:) center_Y2(:)];
end


function [X,Y]=GenerateVertices(ceterCoordinates,radius)
%函数GenerateVertices根据已经确定的六边形的中心坐标和外接圆半径，确定每一个中心坐标
%所对应的6个顶点的横纵坐标，并将横坐标计入矩阵X中，纵坐标计入矩阵Y中
numHexagon=length(ceterCoordinates);
theta=[0:pi/3:2*pi-pi/3]';
X=repmat(radius*sin(theta),[1 numHexagon])+repmat(ceterCoordinates(:,1)',[6 1]);
Y=repmat(radius*cos(theta),[1 numHexagon])+repmat(ceterCoordinates(:,2)',[6 1]);
end