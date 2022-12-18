function h=linevertical(h_handle,x,linestyle,linewidth,color,stack,hideleg,displayname)

%% Draw vertical line
%
% Inputs:
% h_handle: axes handles
% x: vector with positions
% linestyle: style, e.g. '--'
% linewidth: width
% color: [1,3] vector with color
% stack: stack the line 'bottom' or 'top'
% hideleg: true/false, hide line in legend
% displayname: name in legend
%
% Outputs:
% h: handle to lines
%
%% Default inputs

if nargin<8
    displayname='';
end

if nargin<7
    hideleg=true;
end

if nargin<6
    stack='bottom';
end

if nargin<5
    color=[0 0 0];
end

if nargin<4
    linewidth=0.5;
end

if nargin<3
    linestyle='-';
end

%%

if isempty(linestyle)
    linestyle='-';
end

if isempty(linewidth)
    linewidth=0.5;
end

if isempty(color)
    color=[0 0 0];
end

if isempty(stack)
    stack='bottom';
end

if isempty(hideleg)
    hideleg=true;
end

if length(x)>100
    error('Too many lines')
end

%%

if ischar(h_handle)
    if strcmpi(h_handle,'all')
        h_handle = findobj('Type', 'figure');
    end
end

if strcmp(get(h_handle(1),'type'),'axes')
    hax=h_handle;
elseif strcmp(get(h_handle(1),'type'),'figure')
    for k=1:length(h_handle)
        hax_k{k}=getsortedaxes(h_handle(k));
    end
    hax=stackHorizontal(hax_k);
end

%%

for k=1:length(hax)
    
    xLim=get(hax(k),'xlim');
    yLim=get(hax(k),'ylim');
    
    leg=get(hax(k),'legend');
    if ~isempty(leg)
        set(leg,'AutoUpdate','off');
    end
    
    x_plot(1,:)=x;
    h{k}=line(repmat(x_plot,2,1),repmat(yLim.',1,length(x)),'LineStyle',linestyle,'LineWidth',linewidth,'Color',color,'Parent',hax(k),'Tag','linevertical','DisplayName',displayname);
    uistack(h{k},stack);
    
    % Turn off legend
    if hideleg==true
        h_anno=get(h{k},'Annotation');
        if iscell(h_anno)
            
            for j=1:length(h_anno)
                set(get(h_anno{j},'LegendInformation'),'IconDisplayStyle','off');
            end
            
        else
            set(get(h_anno,'LegendInformation'),'IconDisplayStyle','off');
        end
    end
    
end


if length(hax)==1;
    h=h{1};
end