function [verticesX,verticesY]=HoneycombPattern(L,R,C)
% ����HoneycombPattern����֪���δ��ڻ��Ʒ���״ͼ��
% ����˵����
%? ? LΪ�������α߳�
%? ? RΪ����������CΪ��������
% ���þ�����
%? ? HoneycombPattern;
%? ? HoneycombPattern(5)
%? ? HoneycombPattern(1,[50 40])
% ���ߣ��鈐
% Time��2020/11/20

L1=C*sqrt(3)/2*L;
W1=(3*R+1)/4*L;
close all;
%���������εĸ�����������
center=GenerateCenter(L,R,C);
%����ÿһ����������ó�ÿһ�����Ķ�Ӧ��6������
[verticesX,verticesY]=GenerateVertices(center,L);
figure(1)
%patch������matlab�Դ����������ڻ��ƶ���������Ƕ����壬just helpһ��
%���ƾ���
patch([L1,-L1,-L1,L1],...
      [W1,W1,-W1,-W1],'w')
%����������
patch(verticesX,verticesY,'w');
axis equal;
set(gca,'xlim',[-L1,L1],'ylim',[-W1,W1])
hold on
scatter(L*cos(pi/6),L*sin(pi/6),'r','filled');
hold on
grid on
grid minor
%ͼ2����һ��
% figure(2)
% patch([0 H(1) H(1) 0],[0 0 H(2) H(2)],'b')
% hold on
% patch(verticesX,verticesY,'r');
% axis equal off;
% %ͼ3����fill��������
% figure(3)
% fill([0 H(1) H(1) 0],[0 0 H(2) H(2)],'b')
% hold on
% h=fill(verticesX,verticesY,'r');
% set(h(16:end),'facecolor','y')
% axis equal off;
end

function center=GenerateCenter(L,R,C)
%����GenerateCenter���������εı߳�L�;���Hȷ����Ҫ���������εĸ������ĺ�����
%��������˼���Ƿ������ε�������ż���Ӧ����������
%ncolΪ��������������������������ncol1��ż����ncol2)
if mod(R,2)==1
    R=R+1;
end
if mod(C,2)==1
    C=C+1;
end
r=floor(R/2);c=floor(C/2);
%�����������
center_x1 = (-c:c)*L*sqrt(3);
if mod(r,2)==0
    center_y1 = (-ceil(r/2):ceil(r/2))*3*L;
end
if mod(r,2)==1
    center_y1 = ((-ceil(r/2)+1):(ceil(r/2)-1))*3*L;
end
%ż���������
center_x2 = ((-c+0.5):(c-0.5))*L*sqrt(3);
center_y2 = ((-ceil(r/2)+0.5):(ceil(r/2)-0.5))*3*L;
[center_X1,center_Y1]=meshgrid(center_x1,center_y1);
[center_X2,center_Y2]=meshgrid(center_x2,center_y2);
center=[center_X1(:) center_Y1(:);center_X2(:) center_Y2(:)];
end


function [X,Y]=GenerateVertices(ceterCoordinates,radius)
%����GenerateVertices�����Ѿ�ȷ���������ε�������������Բ�뾶��ȷ��ÿһ����������
%����Ӧ��6������ĺ������꣬����������������X�У�������������Y��
numHexagon=length(ceterCoordinates);
theta=[0:pi/3:2*pi-pi/3]';
X=repmat(radius*sin(theta),[1 numHexagon])+repmat(ceterCoordinates(:,1)',[6 1]);
Y=repmat(radius*cos(theta),[1 numHexagon])+repmat(ceterCoordinates(:,2)',[6 1]);
end