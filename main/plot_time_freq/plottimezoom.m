function ha=plottimezoom(varargin)
%% Plot time series with zoom window
%
% Inputs:
% t_zoom: [t_start,t_end] for zoom, can be specified for each signal as rows
% gap: gaps between the axes in normalized units (0...1), [gap_h gap_w] for different gaps in height and width
% marg_h: margins in height in normalized units (0...1), [lower upper] for different lower and upper margins
% marg_w: margins in width in normalized units (0...1), [left right] for different left and right margins
% weight_w: relative width of axes
% legend_logic: [logic_left,logic_left] to control labels
%
% Outputs:
% ha: axes handles

%%

args_in=varargin;

if isstruct(args_in{end})

    args_in_end=args_in{end};

    if isfield(args_in_end,'t_zoom')
        t_zoom=args_in_end.t_zoom;
        args_in_end=rmfield(args_in_end,'t_zoom');
    else
        t_zoom=[0 10];
    end

    if isfield(args_in_end,'weight')
        weight_w=args_in_end.weight;
        args_in_end=rmfield(args_in_end,'weight');
    else
        weight_w=[0.7 0.3];
    end

    if isfield(args_in_end,'gap')
        gap=args_in_end.gap;
    else
        gap=[0.1 0.1];
    end

    if isfield(args_in_end,'marg_h')
        marg_h=args_in_end.marg_h;
    else
        marg_h=[0.1 0.1];
    end

    if isfield(args_in_end,'marg_w')
        marg_w=args_in_end.marg_w;
    else
        marg_w=[0.1 0.1];
    end

    if isfield(args_in_end,'legend_logic')
        legend_logic=args_in_end.legend_logic;
        args_in_end=rmfield(args_in_end,'legend_logic');
    else
        legend_logic=[1 0];
    end

    args_in{end}=args_in_end;

end

%%

plottime(args_in{:});
h_fig1=gcf;
h_ax1=getsortedaxes(h_fig1);

t=args_in{1};

if size(t_zoom,1)==1
    t_zoom=repmat(t_zoom,length(h_ax1),1);
end

%%

% figure();

[~,pos]=tight_subplot(length(h_ax1),2,gap,marg_h,marg_w,[],weight_w,[],true);

ha_ori=getsortedaxes(gcf);
ha= gobjects(1,length(ha_ori)*2);
ha(1:2:length(ha_ori)*2)=ha_ori;

for k=1:2:length(pos)
    set(ha(k),'Position',pos{k});
end

for k=2:2:length(pos)
    ha(k) = axes('Units','normalized','Position',pos{k});
end


copyaxescontent(ha(1:2:end),ha(2:2:end),false,false);


% Turn off ylabel
for k=2:2:length(ha)
    YLabelProp=get(ha(k),'YLabel');
    set(YLabelProp,'Visible','off');
end


for k=1:2:length(ha)

    if legend_logic(1)==false
        leg=get(ha(k),'legend');
        set(leg,'Visible','off');
    end

    if legend_logic(2)==false
        leg=get(ha(k+1),'legend');
        set(leg,'Visible','off');
    end

end

n=0;
for k=2:2:length(ha)
    n=n+1;

    hc=get(ha(k),'Children');

    for j=1:length(hc)

        ind_zoom=indexargmin(t,t_zoom(n,:)); ind_zoom=[ind_zoom(1):ind_zoom(2)];
        hc(j).XData=hc(j).XData(:,ind_zoom);
        hc(j).YData=hc(j).YData(:,ind_zoom);

    end
    axistight(ha(k),[0 0.05],'x','y');
end




