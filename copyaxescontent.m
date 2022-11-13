function copyaxescontent(hax_all,hax_new_all,closesource,override,varargin)

%% Copy content from one axes to another
%
% Inputs:
% hax_all: handle to axes (original)
% hax_new_all: handle to axes (new)
% closesource: true/false, close original figures or not
% override: true/false, ignore error if length of hax_all does not match hax_new_all
%
% Outputs: none
%
%% Inputs

p=inputParser;

addParameter(p,'skiplegend',false)
addParameter(p,'skipvar',{})

parse(p,varargin{:});

skiplegend=p.Results.skiplegend;
skipvar=p.Results.skipvar;

%% Preprocess

if ~iscell(skipvar)
    skipvar={skipvar};
end

if iscell(hax_all)
    hax_all=stackVertical(hax_all);
end

if iscell(hax_new_all)
    hax_new_all=stackVertical(hax_new_all);
end

if nargin==2
    closesource=false;
    override=false;
elseif nargin==3
    override=false;
end

if override
    hax_new_all=hax_new_all(1:length(hax_all));
else
    if length(hax_all)~=length(hax_new_all)
       error('handle length not equal'); 
    end
end

do_skip_xlabel=false;
do_skip_ylabel=false;
do_skip_zlabel=false;
do_skip_title=false;

for ind=1:length(skipvar)
    
        if strcmpi(skipvar{ind},'xlabel'); do_skip_xlabel=true; end
        if strcmpi(skipvar{ind},'ylabel'); do_skip_ylabel=true; end
        if strcmpi(skipvar{ind},'zlabel'); do_skip_zlabel=true; end
        if strcmpi(skipvar{ind},'title'); do_skip_title=true; end

end


%% Copy


for j=1:length(hax_all)
    
hax=hax_all(j);
hax_new=hax_new_all(j);

% hax_prop=get(hax);

linesInAxes=get(hax,'children');
for k=length(linesInAxes):-1:1
new_handle(k) = copyobj(linesInAxes(k),hax_new);
end

if ~do_skip_title
title = copyobj(get(hax, 'Title'), hax_new);
set(hax_new, 'Title', title);
end

if ~do_skip_xlabel
xlabel = copyobj(get(hax, 'XLabel'), hax_new);
set(hax_new, 'XLabel', xlabel);
end

if ~do_skip_ylabel
ylabel = copyobj(get(hax, 'YLabel'), hax_new);
set(hax_new, 'YLabel', ylabel);
end

if ~do_skip_ylabel
zlabel = copyobj(get(hax, 'ZLabel'), hax_new);
set(hax_new, 'ZLabel', zlabel);
end


if skiplegend==false
    
legendProp=get(hax, 'Legend');

if isempty(legendProp)
%     continue
elseif strcmpi(legendProp.Visible,'on') 
    
    axes(hax_new);
	legend('Show');
    legendPropNew=get(hax_new, 'Legend');
    
    properties_str={'FontSize' 'Interpreter' 'Location' 'Visible'};
    for i=1:length(properties_str)
        set(legendPropNew, properties_str{i}, get(legendProp, properties_str{i}));
    end

end

end

% legend(legendProp);
% legendlabel = copyobj(get(hax, 'Legend'), hax_new);
% set(hax_new, 'Legend', legendlabel);

properties_str = {  'Units'
                        'ActivePositionProperty'
                        'ALim'
                        'ALimMode'
                        'AmbientLightColor'
                        'Box'
                        'CameraPosition'
                        'CameraPositionMode'
                        'CameraTarget'
                        'CameraTargetMode'
                        'CameraUpVector'
                        'CameraUpVectorMode'
                        'CameraViewAngle'
                        'CameraViewAngleMode'
                        'CLim'
                        'CLimMode'
                        'Color'
%                         'CurrentPoint'
                        'ColorMap'
                        'ColorOrder'
                        'DataAspectRatio'
                        'DataAspectRatioMode'
%                         'DrawMode'
                        'FontAngle'
                        'FontName'
                        'FontSize'
                        'FontUnits'
                        'FontWeight'
                        'GridLineStyle'
                        'Layer'
                        'LineStyleOrder'
                        'LineWidth'
                        'MinorGridLineStyle'
                        'NextPlot'
%                         'OuterPosition'
                        'PlotBoxAspectRatio'
                        'PlotBoxAspectRatioMode'
                        'Projection'
%                         'Position'
                        'TickLength'
                        'TickDir'
                        'TickDirMode'
%                         'TightInset'
                        'View'
                        'XColor'
                        'XDir'
                        'XGrid'
                        'XAxisLocation'
                        'XLim'
                        'XLimMode'
                        'XMinorGrid'
                        'XMinorTick'
                        'XScale'
                        'XTick'
                        'XTickLabel'
                        'XTickLabelMode'
                        'XTickMode'
                        'YColor'
                        'YDir'
                        'YGrid'
                        'YAxisLocation'
                        'YLim'
                        'YLimMode'
                        'YMinorGrid'
                        'YMinorTick'
                        'YScale'
                        'YTick'
                        'YTickLabel'
                        'YTickLabelMode'
                        'YTickMode'
                        'ZColor'
                        'ZDir'
                        'ZGrid'
                        'ZLim'
                        'ZLimMode'
                        'ZMinorGrid'
                        'ZMinorTick'
                        'ZScale'
                        'ZTick'
                        'ZTickLabel'
                        'ZTickLabelMode'
                        'ZTickMode'
%                         'BeingDeleted'
                        'ButtonDownFc'
                        'Clipping'
                        'CreateFcn'
                        'DeleteFcn'
                        'BusyAction'
                        'HandleVisibility'
                        'HitTest'
                        'Interruptible'
                        'Selected'
                        'SelectionHighlight'
                        'Tag'
%                         'Type'
                        'UIContextMenu'
                        'UserData'
                        'Visible'};


for i=1:length(properties_str)
    
	do_skip_propery=false;
    for ind=1:length(skipvar)
        if strcmpi(skipvar{ind},properties_str{i})
            do_skip_propery=true;
            break
        end
    end
    
    if do_skip_propery
        continue
    end       
    
	set(hax_new, properties_str{i}, get(hax, properties_str{i}));
%     set(hax_new, properties_str{i}, getfield(hax_prop, properties_str{i}));
end

% assign limits simulataneously
set(hax_new,'XLim', get(hax,'XLim'),'YLim', get(hax,'YLim'),'ZLim', get(hax,'ZLim'));

end

if closesource

for j=1:length(hax_all)
    
    if ishandle(hax_all(j))
    hFig=get(hax_all(j),'Parent');
    else
    continue
    end

    if ishandle(hFig)
    close(hFig);
    end

end

end