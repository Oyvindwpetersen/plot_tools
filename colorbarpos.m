function colorbarpos(hc,scale_x,scale_y)

%% Scale down size of color bar
%
% Inputs:
% hc: handle to color bar
% scale_x: rescale factor, between 0 and 1
% scale_y: rescale factor, between 0 and 1
%
% Outputs:
%
%%

ax=1-scale_x;
ay=1-scale_y;

Temp=hc.Position;
% [start_x start_y dx dy];

start_x=Temp(1);
start_y=Temp(2);
dx=Temp(3);
dy=Temp(4);

Temp2=[start_x+ax*dx start_y+ay*dy dx-ax*dx dy-ay*dy];

hc.Position=Temp2;