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


ax=1-scale_x;
ay=1-scale_y;

Temp=hc.Position;
% [start_x start_y Lx Ly];

start_x=Temp(1);
start_y=Temp(2);
Lx=Temp(3);
Ly=Temp(4);

Temp2=[ start_x+ax*Lx+dx ...
        start_y+ay*Ly+dy ...
        Lx-ax*Lx  ...
        Ly-ay*Ly];

hc.Position=Temp2;