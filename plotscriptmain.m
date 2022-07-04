function plotscriptmain(varargin)

%% Plot to pdf or jpg

%plotscriptmain('h',8,'w',12,'name','plot','titlesize',8,'labelsize',6,'ticksize',6,'path','desktop','open','yes');


%%

p=inputParser;
addParameter(p,'fig',[],@ishandle)
addParameter(p,'h',8,@isnumeric)
addParameter(p,'w',12,@isnumeric)
addParameter(p,'fontname','Arial',@ischar)
addParameter(p,'titlesize',10,@isnumeric) %title of figure (above)
addParameter(p,'labelsize',8,@isnumeric) %xlabel and ylabel
addParameter(p,'ticksize',8,@isnumeric) %xticks and yticks
addParameter(p,'legendsize',8,@isnumeric)
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
% addParameter(p,'InvertHardcopy','off',@ischar)

parse(p,varargin{:});

hfig = p.Results.fig;
height = p.Results.h;
width = p.Results.w;
fontname = p.Results.fontname;
titlesize = p.Results.titlesize;
labelsize = p.Results.labelsize;
ticksize = p.Results.ticksize;
legendsize = p.Results.legendsize;
fpath = p.Results.path;
format = p.Results.format; 
fname = p.Results.name;
savefigure = p.Results.savefig;
openfile = p.Results.open;
res = p.Results.res; res=[ '-r' num2str(res)];
figure_box = p.Results.box;
legendsmall = p.Results.legendsmall;
renderer = p.Results.renderer; renderer=[ '-' renderer];
yminorgrid = p.Results.yminorgrid;
keepxtick = p.Results.keepxtick;
keepytick = p.Results.keepytick;
keepctick = p.Results.keepctick;
uicont = p.Results.uicontrol;
% InvertHardcopy = p.Results.InvertHardcopy;

%% Input

if isempty(hfig)
    hfig=gcf;
end

% set(gcf,'InvertHardcopy',InvertHardcopy)

if isempty(fpath)
fpath=cd;
end

if ~strcmp(fpath(end),'\')
fpath=[fpath '\'];
end

if exist(fpath)~=7
   error(['Path does not exist: ' fpath]); 
end

if ~iscell(format)
format={format};
end

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

hChildren = get(hfig,'Children'); 
uicontInd=[];

for m=1:size(hChildren,1)
    
    htype=get(hChildren(m),'type');
    if strcmpi(htype,'uicontextmenu') | strcmpi(htype,'polaraxes') | strcmpi(htype,'tiledlayout') | strcmpi(htype,'uimenu')  | strcmpi(htype,'uitoolbar') | strcmpi(htype,'annotationpane') 
        continue;
    elseif strcmpi(htype,'UIControl') & strcmpi(uicont,'no') 
        set(hChildren(m),'Visible','off'); continue; uicontInd(end+1)=m;
    elseif strcmpi(htype,'colorbar')
        set(hChildren(m),'FontName',fontname)
        set(hChildren(m),'FontSize',ticksize)
        set(get(hChildren(m),'Label'),'FontSize',labelsize)
    elseif strcmpi(htype,'legend')
	    set(hChildren(m),'FontSize',legendsize)
        set(hChildren(m),'FontName',fontname)
    elseif strcmpi(htype,'axes')
        set(hChildren(m),'Fontsize',ticksize)
        set(get(hChildren(m),'xlabel'),'FontSize',labelsize)
        set(get(hChildren(m),'ylabel'),'FontSize',labelsize)
        set(get(hChildren(m),'zlabel'),'FontSize',labelsize)
        set(get(hChildren(m),'title'),'FontSize',titlesize)

        set(hChildren(m),'FontName', fontname);
        set(get(hChildren(m),'ylabel'),'FontName',fontname)
        set(get(hChildren(m),'xlabel'),'FontName',fontname)
        set(get(hChildren(m),'title'),'FontName',fontname) 

        set(hChildren(m),'YMinorGrid', yminorgrid);    
    else
        warning(['Unknown type: ' htype]);
    end
    
    if strcmpi(figure_box,'on') & strcmpi(htype,'axes')
        set(hChildren(m,1),'box','on');
        set(hChildren(m,1),'LineWidth',0.3);
    elseif strcmpi(figure_box,'off') & strcmpi(htype,'axes')
        set(hChildren(m,1),'box','off');
    end

    %check is axes is a legendSmall type legend
	if strcmpi(htype,'axes') 
        check1=isempty(hChildren(m).XLabel.String); check2=isempty(hChildren(m).YLabel.String);
        check3=isempty(hChildren(m).XTick); check4=isempty(hChildren(m).YTick);
        if all([check1 check2 check3 check4]);        
        set(hChildren(m),'box','on');
        set(hChildren(m),'LineWidth',0.3);
		warning('Check if this line is activated');
        end
    end
    
    if strcmpi(keepytick,'yes') & strcmpi(htype,'axes')
       set(hChildren(m),'YTick',get(hChildren(m),'YTick'));
    end
        
    if strcmpi(keepxtick,'yes') & strcmpi(htype,'axes')
       set(hChildren(m),'XTick',get(hChildren(m),'XTick'));
    end
    
    if strcmpi(keepctick,'yes') & strcmpi(htype,'colorbar')
       set(hChildren(m),'Ticks',get(hChildren(m),'Ticks'));
    end
        
end

% Set position
set(hfig, 'PaperPositionMode', 'manual');
set(hfig, 'PaperUnits', 'centimeters');
set(hfig, 'PaperPosition', [0 0 width height],'PaperSize',[width height]);

% Save
if strcmpi(savefigure,'yes')
savefig(hfig,[fpath fname]);
end

% Print
for k=1:length(format)
	print(hfig,renderer,format{k},res,[fpath fname])
	disp(['printing ', fname ,' to ' fpath ' in ' formatShort{k}])

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

for m=1:length(hChildren)
    
    if ~isvalid(hChildren(m)); continue; end
		htype=get(hChildren(m),'type');
		if strcmpi(htype,'UIControl') & strcmpi(uicont,'no') 
			set(hChildren(m),'Visible','on');
		end
	end
end