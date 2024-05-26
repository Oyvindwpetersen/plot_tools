function ha_new=splitaxes(ha_split,direction,gap_h,gap_w)

%% Split axes into two new
% Inputs:
% ha_split: axis handle
% direction: 'vertical' or 'horizontal'
% gap_h: gap between axis for vertical case
% gap_w: gap between axis for horizontal case
%
% Outputs:
% ha_new: axis handle to new axes
%
%%

pos_original=get(ha_split,'Position');

if isempty(gap_h)
    gap_h=0.1;
end

if isempty(gap_h)
    gap_w=0.1;
end

if strcmpi(direction,'vertical')
    Ly_new=(pos_original(4)-gap_h)/2;
    
    pos1=[pos_original(1) pos_original(2)+Ly_new+gap_h pos_original(3) Ly_new];
    pos2=[pos_original(1) pos_original(2) pos_original(3) Ly_new];
    
end

if strcmpi(direction,'horizontal')
    error('not implemented yet: horizontal split')
end

set(ha_split,'Position',pos1);

ha_new(1)=ha_split;
ha_new(2)=axes('Units','normalized','Position',pos2);

