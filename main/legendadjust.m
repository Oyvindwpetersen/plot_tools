function legendadjust(pos,xy_adjust,ncol,ItemTokenSize)

%% Adjust legend position in current figure
%
% Inputs:
% pos: 'west' or 'mid' or 'east'
% xy_adjust: [dx,dy] vector with adjustments relative to axes
% ncol: number of legend columns
% ItemTokenSize: length of legend bar (-), e.g. [15 6];
%
% Outputs: none
%
%% Default inputs

if nargin<4
    ItemTokenSize=[20];
end

if nargin<3
    ncol=1;
end

if nargin<2
    xy_adjust=[0 0];
end

if nargin<1
    pos='east';
end

if isempty(xy_adjust)
    xy_adjust=[0 0];
end

if isempty(ncol)
    ncol=[1];
end
if length(ItemTokenSize)==1
    ItemTokenSize=[ItemTokenSize,1];
end

%%

hGetAxes=get(gcf,'Children');

for k=1:length(hGetAxes)

    if ~strcmpi(hGetAxes(k).Type,'axes'); continue; end

    if isempty(hGetAxes(k).Legend); continue; end

    hLeg=hGetAxes(k).Legend;

    if ~isempty(ItemTokenSize)
        hLeg.ItemTokenSize=ItemTokenSize;
    end
    
    set(hLeg,'NumColumns',ncol);
    set(hLeg,'Units','normalized');

    axesPos=hGetAxes(k).Position; % [left bottom width height]

    xy_LU_axes=[axesPos(1) axesPos(2)+axesPos(4)]; % Left upper corner
    xy_RU_axes=[axesPos(1)+axesPos(3) axesPos(2)+axesPos(4)]; % Right upper corner

    if strcmpi(pos,'east')
        set(hLeg,'Location','NorthEast');
       	legPos=hLeg.Position; % [left bottom width height]
        xy_LU_leg=[xy_RU_axes(1)-axesPos(3)*0.2-legPos(3) xy_LU_axes(2)+0.03]; % [Right_corner_axes-0.2*axes_width-leg_width Top_axes+0.03]
    elseif strcmpi(pos,'west')
        set(hLeg,'Location','NorthWest');
       	legPos=hLeg.Position;
        xy_LU_leg=[xy_LU_axes(1)+axesPos(3)*0.1 xy_RU_axes(2)+0.03]; % [Left_corner_axes+0.1*axes_width-leg_width Top_axes+0.03]
    elseif strcmpi(pos,'mid')
        set(hLeg,'Location','North');
       	legPos=hLeg.Position;
        xy_LU_leg=[xy_LU_axes(1)+axesPos(3)*0.1 xy_RU_axes(2)+0.03]; % [Left_corner_axes+0.1*axes_width-leg_width Top_axes+0.03]
    elseif strcmpi(pos,'west2')
        set(hLeg,'NumColumns',length(hLeg.String));
        set(hLeg,'Location','northwestoutside');
       	legPos=hLeg.Position;
        xy_LU_leg=[xy_LU_axes(1) xy_RU_axes(2)]; % [Left_corner_axes+0.1*axes_width-leg_width Top_axes+0.03]

        set(hLeg,'Position',[xy_LU_leg(1)+xy_adjust(1) xy_LU_leg(2)+xy_adjust(2) legPos(3) legPos(4)]);
        continue
    else
        continue
        % set(hLeg,'Position',[xy_LU_leg(1)+xy_adjust(1) xy_LU_leg(2)+xy_adjust(2) legPos(3) legPos(4)]);
    end

    set(hLeg,'Position',[xy_LU_leg(1)+xy_adjust(1) xy_LU_leg(2)+xy_adjust(2) legPos(3) legPos(4)],...
        'NumColumns',ncol);


end