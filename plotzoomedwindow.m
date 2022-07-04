function ha_zoom=plotzoomedwindow(ha,Nh,Nw,ZoomWindowCell,varargin)

%% Plot subaxes with zoomed interval of time series
%
% Inputs:
%
% Outputs:
%
%% 

%%

p=inputParser;

addParameter(p,'gap',[.175 .1],@isnumeric)
addParameter(p,'marg_h',[.075 .15],@isnumeric)
addParameter(p,'marg_w',[.05 .025],@isnumeric)
addParameter(p,'ZoomWidth',[.1],@isnumeric)
addParameter(p,'ZoomHeight',[.1],@isnumeric)
addParameter(p,'ZoomOffsetX',[.2],@isnumeric)
addParameter(p,'ZoomOffsetY',[.2],@isnumeric)

parse(p,varargin{:});

gap = p.Results.gap;
marg_h = p.Results.marg_h;
marg_w = p.Results.marg_w;
ZoomWidth = p.Results.ZoomWidth;
ZoomHeight = p.Results.ZoomHeight;
ZoomOffsetX = p.Results.ZoomOffsetX;
ZoomOffsetY = p.Results.ZoomOffsetY;


%%

n_zoom=length(ZoomWindowCell{1});

if length(ZoomWidth)==1
    ZoomWidth=ZoomWidth*ones(1,n_zoom);
end

if length(ZoomHeight)==1
    ZoomHeight=ZoomHeight*ones(1,n_zoom);
end

if length(ZoomOffsetX)==1
    ZoomOffsetX=ZoomOffsetX*ones(1,n_zoom);
end

if length(ZoomOffsetY)==1
    ZoomOffsetY=ZoomOffsetY*ones(1,n_zoom);
end

%% Assign to cell


if ~iscell(ZoomWindowCell)
    ZoomWindowCell={ZoomWindowCell}
end

for k=1:length(ZoomWindowCell)
    
    if ~iscell(ZoomWindowCell{k})
        ZoomWindowCell{k}{1}=ZoomWindowCell{k};
    end
    
    for j=1:length(ZoomWindowCell{k})
        
        ZoomOffsetXCell{k}{j}=ZoomOffsetX(j);
        ZoomOffsetYCell{k}{j}=ZoomOffsetY(j);
        
        ZoomWidthCell{k}{j}=ZoomWidth(j);
        ZoomHeightCell{k}{j}=ZoomHeight(j);
        
    end
    
end

%%


% Dummy figure to get positions of moved aces
hfig_dummy = figure('visible','off');
ha_dummy=tight_subplot(Nh,Nw,gap,marg_h,marg_w);
clear pos_original
for k=1:length(ha_dummy)
    pos_axes{k}=get(ha_dummy(k),'Position');
end
close(hfig_dummy);

% Set axes positions
for k=1:length(ha)
    set(ha(k),'Position',pos_axes{k});
end

% Copy axes content
for k=1:length(ZoomWindowCell)
    
    for j=1:length(ZoomWindowCell{k})
        
        pos_zoom{k}{j}=[ pos_axes{k}(1) pos_axes{k}(2) 0 0 ]+[ZoomOffsetXCell{k}{j} ZoomOffsetYCell{k}{j} ZoomWidthCell{k}{j} ZoomHeightCell{k}{j} ]; %[0.2 0.15 0.15 0.1] +
        
        ha_zoom{k}{j}=axes('Units','normalized','Position',pos_zoom{k}{j});
        
        copyaxescontent(ha(k),ha_zoom{k}{j},false,false,'skiplegend',true,'skipvar',{'xlabel' 'ylabel'});
        
        xl=ZoomWindowCell{k}{j};
        
        xlim(xl);
        yl=ylimxRange(ha_zoom{k}{j},xl);
        
        xl_original=get(ha(k),'xlim');
        yl_original=get(ha(k),'ylim');
        
        rectangle('Position',[xl(1) yl_original(1)+0.1*diff(yl_original) diff(xl) diff(yl_original)*(1-0.1*2)],'Curvature',0.1,...
            'EdgeColor',[0 0 0],'LineWidth',0.75,'LineStyle',':','Parent',ha(k));
        
        x1_arrow=pos_axes{k}(1)+pos_axes{k}(3)* ( ZoomWindowCell{k}{j}(1)+0.5*diff(ZoomWindowCell{k}{j}) ) / diff(xl_original);
        y1_arrow=pos_axes{k}(2)+pos_axes{k}(4);
        
        x2_arrow=pos_zoom{k}{j}(1)+pos_zoom{k}{j}(3);
        y2_arrow=pos_zoom{k}{j}(2)+pos_zoom{k}{j}(4)*0.5;
        
        h_arrow{k}{j}=annotation('arrow',[x1_arrow x2_arrow],[y1_arrow y2_arrow],...
            'LineStyle',':','LineWidth',0.75,'Color',[0 0 0],'HeadStyle','cback3','HeadLength',4,'HeadWidth',4);
        
    end
    
end

%%
