function plotscriptmain(varargin)

%% Plot to pdf or jpg

%plotscriptmain('h',8,'w',12,'name','plot','titlesize',8,'labelsize',6,'ticksize',6,'path','desktop','open','yes');

%%

p=inputParser;
addParameter(p,'fig',[],@ishandle)
addParameter(p,'h',8,@isnumeric)
addParameter(p,'w',12,@isnumeric)
addParameter(p,'fontname','Arial',@ischar)
addParameter(p,'titlesize',8,@isnumeric) %title of figure (above)
addParameter(p,'labelsize',8,@isnumeric) %xlabel and ylabel
addParameter(p,'ticksize',8,@isnumeric) %xticks and yticks
addParameter(p,'legendsize',8,@isnumeric)
addParameter(p,'legpos','east',@ischar)

addParameter(p,'path','',@ischar) %folder to print to
addParameter(p,'format','pdf')
addParameter(p,'name','plot',@ischar)
addParameter(p,'savefig','no',@ischar)
addParameter(p,'open','yes',@ischar)
addParameter(p,'res',1200,@isnumeric)
addParameter(p,'box','on',@ischar)
addParameter(p,'renderer','painters',@ischar)
addParameter(p,'yminorgrid','off',@ischar)
addParameter(p,'keepxtick','no',@ischar)
addParameter(p,'keepytick','no',@ischar)
addParameter(p,'keepctick','no',@ischar)
addParameter(p,'uicontrol','no',@ischar)
addParameter(p,'BoxLineWidth',0.3,@isnumeric)

parse(p,varargin{:});

hfig=p.Results.fig;
height=p.Results.h;
width=p.Results.w;
fontname=p.Results.fontname;
titlesize=p.Results.titlesize;
labelsize=p.Results.labelsize;
ticksize=p.Results.ticksize;
legendsize=p.Results.legendsize;
legpos=p.Results.legpos;

fpath=p.Results.path;
format=p.Results.format;
fname=p.Results.name;
savefigure=p.Results.savefig;
openfile=p.Results.open;
res=p.Results.res;
figure_box=p.Results.box;
renderer=p.Results.renderer;
yminorgrid=p.Results.yminorgrid;
keepxtick=p.Results.keepxtick;
keepytick=p.Results.keepytick;
keepctick=p.Results.keepctick;
uicont=p.Results.uicontrol;
BoxLineWidth=p.Results.BoxLineWidth;

%% Input handle.

if isempty(hfig)
    hfig=gcf;
end

if isempty(fpath)
    fpath=cd;
end

if ~strcmp(fpath(end),'/')
    fpath=[fpath '/'];
end

if exist(fpath)~=7
    error(['Path does not exist: ' fpath]);
end

if ~iscell(format)
    format={format};
end

if ~strcmpi(renderer(1),'-')
    renderer=[ '-' renderer];
end

res_str=[ '-r' num2str(res)];

for k=1:length(format)

    if strcmp(format{k},'jpg')
        formatShort{k}='jpg';
        format{k}=['-d' 'jpeg'];
    elseif strcmp(format{k},'eps') | strcmp(format{k},'epsc')
        formatShort{k}='eps';
        format{k}=['-depsc'];
    else
        formatShort{k}=format{k};
        format{k}=['-d' format{k}];
    end

end

%% Change properties

hchildren=get(hfig,'Children');

for m=1:size(hchildren,1)

    htype=get(hchildren(m),'type');
    if strcmpi(htype,'uicontextmenu') | strcmpi(htype,'polaraxes') | strcmpi(htype,'tiledlayout') | strcmpi(htype,'uimenu')  | strcmpi(htype,'uitoolbar') | strcmpi(htype,'annotationpane')
        continue;
    elseif strcmpi(htype,'UIControl') & strcmpi(uicont,'no')
        set(hchildren(m),'Visible','off'); continue;
    elseif strcmpi(htype,'colorbar')
        set(hchildren(m),'FontName',fontname)
        set(hchildren(m),'FontSize',ticksize)
        set(get(hchildren(m),'Label'),'FontSize',labelsize)
    elseif strcmpi(htype,'legend')
        set(hchildren(m),'FontSize',legendsize)
        set(hchildren(m),'FontName',fontname)
    elseif strcmpi(htype,'axes')
        set(hchildren(m),'Fontsize',ticksize)
        set(get(hchildren(m),'xlabel'),'FontSize',labelsize)
        set(get(hchildren(m),'ylabel'),'FontSize',labelsize)
        set(get(hchildren(m),'zlabel'),'FontSize',labelsize)
        set(get(hchildren(m),'title'),'FontSize',titlesize)

        set(hchildren(m),'FontName', fontname);
        set(get(hchildren(m),'ylabel'),'FontName',fontname)
        set(get(hchildren(m),'xlabel'),'FontName',fontname)
        set(get(hchildren(m),'title'),'FontName',fontname)

        set(hchildren(m),'YMinorGrid', yminorgrid);
    else
        warning(['Unknown type: ' htype]);
    end

    if strcmpi(figure_box,'on') & strcmpi(htype,'axes')
        set(hchildren(m,1),'box','on');
        set(hchildren(m,1),'LineWidth',BoxLineWidth);
    elseif strcmpi(figure_box,'off') & strcmpi(htype,'axes')
        set(hchildren(m,1),'box','off');
    end

    if strcmpi(keepytick,'yes') & strcmpi(htype,'axes')
        set(hchildren(m),'YTick',get(hchildren(m),'YTick'));
    end

    if strcmpi(keepxtick,'yes') & strcmpi(htype,'axes')
        set(hchildren(m),'XTick',get(hchildren(m),'XTick'));
    end

    if strcmpi(keepctick,'yes') & strcmpi(htype,'colorbar')
        set(hchildren(m),'Ticks',get(hchildren(m),'Ticks'));
    end

end

% Set position
set(hfig,'PaperPositionMode','manual');
set(hfig,'PaperUnits','centimeters');
set(hfig,'PaperPosition', [0 0 width height],'PaperSize',[width height]);

%%

if strcmpi(legpos,'east')
    drawnow();
    [current_pos_fig,current_pos_leg,h_leg]=legendtop(height,width);
else
    h_leg=[];
end

%% Save

if strcmpi(savefigure,'yes')
    savefig(hfig,[fpath fname]);
end

%% Print

for k=1:length(format)
    print(hfig,renderer,format{k},res_str,[fpath fname])
    disp(['printing ', fname ,' to ' fpath ' in ' formatShort{k}]);

    if strcmpi(openfile,'yes') & k==1
        pause(0.1)

        fullname=[fpath fname '.' formatShort{k}];
        try
            winopen(fullname);
        catch
            disp('Error: unable to open file')
        end
    end

end

%%
if ~isempty(h_leg)
    set(gcf,'Position',current_pos_fig);
end

if ~isempty(h_leg)
    set(h_leg,'Position',current_pos_leg);
    set(h_leg,'Location','NorthWest');
end

%%

% Visible buttons
for m=1:length(hchildren)

    if ~isvalid(hchildren(m)); continue; end
    htype=get(hchildren(m),'type');
    if strcmpi(htype,'UIControl') & strcmpi(uicont,'no')
        set(hchildren(m),'Visible','on');
    end
end