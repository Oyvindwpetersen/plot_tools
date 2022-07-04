function sharedlabel(varargin)

%% Add shared xlabel, ylabel, or title to figure by adding new axes 
% Inputs:
%
% Outputs:
%
%% 

p=inputParser;
addParameter(p,'xlabel','',@ischar)
addParameter(p,'ylabel','',@ischar)
addParameter(p,'fig',[],@ishandle)
addParameter(p,'title','',@ischar)
addParameter(p,'FontSize',8,@isnumeric)
addParameter(p,'FontWeight','normal',@ischar)
addParameter(p,'adjustx',0,@isnumeric)
addParameter(p,'adjusty',0,@isnumeric)
addParameter(p,'interpreter','',@ischar)

parse(p,varargin{:});

xl = p.Results.xlabel;
yl = p.Results.ylabel;
tit = p.Results.title;
hfig = p.Results.fig;
FontSize = p.Results.FontSize;
FontWeight = p.Results.FontWeight;
adjustx = p.Results.adjustx;
adjusty = p.Results.adjusty;
interpreter = p.Results.interpreter;

%%

if isempty(hfig);
    hfig=gcf;
end
        
hax=findall(hfig,'type','axes');

for k=1:length(hax)
    set(hax(k),'Units','normalized');
end

pos_axes=get(hax,'position');
if	iscell(pos_axes)
	pos_axes=cell2mat(get(hax,'position'));
end

%Delete small axes (legendsmall type)
sizeAxisCanvas=pos_axes(:,3).*pos_axes(:,4);
if sum(sizeAxisCanvas<0.01)<4 %
    indEliminate=sizeAxisCanvas<0.01;
    pos_axes(indEliminate,:)=[];
end


pos_axes=[	min(pos_axes(:,1)),max(pos_axes(:,1)+pos_axes(:,3)),...
			min(pos_axes(:,2)),max(pos_axes(:,2)+pos_axes(:,4))];
pos_axes=[	pos_axes(1),pos_axes(3),...
			pos_axes(2)-pos_axes(1),pos_axes(4)-pos_axes(3)];
        

haxNew=axes('position',pos_axes);

% if ~isempty(tit);
%     htitle=title(tit,'FontSize',FontSize);
%     postitle=get(htitle,'position');
%     set(htitle,'position',postitle+adjusttitle);    
%     set(htitle,'visible','on');
% end    

set(haxNew,'visible','off','hittest','on');

if ~isempty(xl)
    hxl=xlabel(xl,'FontSize',FontSize,'FontWeight',FontWeight);
	pos=get(hxl,'position'); set(hxl,'position',pos+[0 adjustx 0]);
    set(hxl,'visible','on');
    if ~isempty(interpreter); set(hxl,'interpreter',interpreter); end
end    
    
if ~isempty(yl)
    hyl=ylabel(yl,'FontSize',FontSize,'FontWeight',FontWeight);
    pos=get(hyl,'position'); set(hyl,'position',pos+[adjusty 0 0]);
    set(hyl,'visible','on');
    if ~isempty(interpreter); set(hyl,'interpreter',interpreter); end
end    

if ~isempty(tit)
    htit=title(tit,'FontSize',FontSize,'FontWeight',FontWeight);
    pos=get(htit,'position'); set(htit,'position',pos+[adjustx adjusty 0]);
    set(htit,'visible','on');
    if ~isempty(interpreter); set(htit,'interpreter',interpreter); end
end    


uistack(haxNew,'bottom');
