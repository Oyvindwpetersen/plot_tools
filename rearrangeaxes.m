function rearrangeaxes(h_fig,n1,n2,gap,marg_h,marg_w)

%% Rearrange position of axes
%
% Inputs:
% nh: number of axes in hight (vertical direction)
% nw: number of axes in width (horizontal direction)
% gap: gaps between the axes in normalized units (0...1), [gap_h gap_w] for different gaps in height and width 
% marg_h: margins in height in normalized units (0...1), [lower upper] for different lower and upper margins 
% marg_w: margins in width in normalized units (0...1), [left right] for different left and right margins 
%
% Outputs:
%
%% 

ha0=getsortedaxes(h_fig);

% h_fig_new=figure('Visible','off');
h_fig_new=figure();

ha_dummy=tight_subplot(n1,n2,gap,marg_h,marg_w);

for k=1:length(ha_dummy)
    pos{k}=get(ha_dummy(k),'Position');
end

for k=1:length(ha0)
    set(ha0(k),'Position',pos{k});
%     pos{k}=get(ha(k),'Position');
end

close(h_fig_new);