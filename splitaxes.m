function ha_new=splitaxes(ha_split,direction,gap_h,gap_w)

%% Split axes into two new
% Inputs:
% ha_split: axis handle
% direction: 'vertical' or 'horizontal'
% gap_h: gap between axis for vertical case
% gap_w: gap between axis for horizontal case

% Outputs:
% ha_new: axis handle to new axes

%%

PositionOriginal=get(ha_split,'Position');

if isempty(gap_h)
    gap_h=0.1;
end

if isempty(gap_h)
    gap_w=0.1;
end

if strcmpi(direction,'vertical')
    Ly_new=(PositionOriginal(4)-gap_h)/2;
    
    Position1=[PositionOriginal(1) PositionOriginal(2)+Ly_new+gap_h PositionOriginal(3) Ly_new];
    Position2=[PositionOriginal(1) PositionOriginal(2) PositionOriginal(3) Ly_new];
    
end

if strcmpi(direction,'horizontal')
    error('not implemented yet: horizontal split')
end

set(ha_split,'Position',Position1);

ha_new(1)=ha_split;
ha_new(2)=axes('Units','normalized','Position',Position2);

