clear
clc
L=1;
[XX,YY]=HoneycombPattern(L,32,32);
XXX=XX(:);YYY=YY(:);
XY=[XXX,YYY];
XY=uniquetol(XY,1e-6,'ByRows',true);   
XX=XY(:,1);YY=XY(:,2);
c=1;step=1;xx=[];yy=[];
while (1)
addf=[];
if step==1
    f(1,1)=L*cos(pi/6);
    f(1,2)=L*sin(pi/6);
else
    for i=1:length(f(:,1))
        xtemp=XX((((XX-f(i,1)).^2+(YY-f(i,2)).^2)<1.05*L^2)&(((XX-f(i,1)).^2+(YY-f(i,2)).^2)>0));
        ytemp=YY((((XX-f(i,1)).^2+(YY-f(i,2)).^2)<1.05*L^2)&(((XX-f(i,1)).^2+(YY-f(i,2)).^2)>0));
        TEMP=[xtemp,ytemp];
        C=uniquetol(TEMP,'ByRows',true);   
        addf=[addf;C];   
    end
    f=[f;addf];
    f=uniquetol(f,'ByRows',true); 
    for j=1:length(xc)
        fx=f(:,1);fy=f(:,2);
        fx((abs(fx-xc(j))<0.0001)&(abs(fy-yc(j))<0.0001))=[];
        fxtemp=f(:,1);
        fy((abs(fxtemp-xc(j))<0.0001)&(abs(fy-yc(j))<0.0001))=[];
        f=[fx,fy];
    end
end
scatter(f(:,1),f(:,2),'r','filled');hold on;
[x,y] = ginput(1);
z=(XX-x).^2+(YY-y).^2;
xc(step)=XX(z==min(min(z)));
yc(step)=YY(z==min(min(z)));
scatter(xc,yc,'b','filled');hold on;
% prompt = '°´¿Õ¸ñ¼ü¼ÌÐø...';
% c = input(prompt)
step=step+1;
end


