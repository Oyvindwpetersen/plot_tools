function [curr_pos_fig,curr_pos_leg,h_leg]=legendtop(h,w,pos)

%% Adjust legend position to align with top east or west corner
%
% Inputs:
% h: height of plot in cm
% w: width of plot in cm
% pos: east or west

% Outputs: 
% curr_pos_fig: figure position in cm before reposition
% curr_pos_leg: legend position in cm before reposition
% h_leg: legend handle
%

%%

if nargin<3
    pos='east';
end

%%

set(gcf,'Units','centimeters');
curr_pos_fig=get(gcf,'Position');

set(0,'units','centimeters');
screensize=get(0,'ScreenSize');
w_screen=screensize(3);
h_screen=screensize(4);

set(gcf,'Position',[w_screen/2-w/2 h_screen/2-h/2 w h]);

h_children=get(gcf,'Children');

h_leg=[];
for k=1:length(h_children)

    if ~strcmpi(h_children(k).Type,'axes'); continue; end

    if isempty(h_children(k).Legend); continue; end

    if strcmpi(h_children(k).Legend.Visible,'off'); continue; end
    
    h_leg=h_children(k).Legend;
end

if isempty(h_leg)
    h_leg=[];
    curr_pos_leg=[];
    return
end

h_leg.ItemTokenSize=[20,1];
set(h_leg,'NumColumns',length(h_leg.String));

set(h_leg,'Units','centimeters');
curr_pos_leg=get(h_leg,'Position');

lx=curr_pos_leg(3);
ly=0.36;

if strcmpi(pos,'east')
    x0=w-0.3-curr_pos_leg(3);
elseif strcmpi(pos,'west')
    x0=1.2;
end

y0=h-0.8+ly/2+0.1;


set(h_leg,'Position',[x0 y0 lx ly]);


