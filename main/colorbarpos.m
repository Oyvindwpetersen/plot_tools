function colorbarpos(hc,scale_x,scale_y,dx,dy)

%% Scale down size of color bar
%
% Inputs:
% hc: handle to color bar
% scale_x: rescale factor, between 0 and 1
% scale_y: rescale factor, between 0 and 1
% dx: adjust x
% dy: adjust y
%
% Outputs:
%
%%

if nargin<5
    dy=0;
end

if nargin<4
    dx=0;
end

Temp=hc.Position;
% [start_x start_y Lx Ly];

start_x=Temp(1);
start_y=Temp(2);
Lx=Temp(3);
Ly=Temp(4);

xc=start_x+Lx/2;
yc=start_y+Ly/2;

start_x2=xc-Lx*scale_x/2;
start_y2=yc-Ly*scale_y/2;

Temp2=[ start_x2+dx ...
        start_y2+dy ...
        Lx*scale_x  ...
        Ly*scale_y];

hc.Position=Temp2;