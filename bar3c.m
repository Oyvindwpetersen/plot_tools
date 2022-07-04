function hh = bar3c( varargin )
%BAR3C Extension of bar3, which sets the bar color corresponding to its
%height.
%
% Extra parameter: 'MaxColorVal', maxclr
% This will make the color/height of the bar absolute against this maximum
% value. Otherwise, the colors will be relative against the maximum zdata
% value of all bars on the graph.
%

[abscolor, idxabsc]=getarg('MaxColorVal',varargin{:});
if idxabsc
varargin(idxabsc+(0:1))=[];
end

h = bar3(varargin{:});
for ii = 1:numel(h)
zdata = get(h(ii),'Zdata');
cdata = makecdata(zdata(2:6:end,2),abscolor);
set(h(ii),'Cdata',cdata, 'facecolor','flat');
end

if nargout>0,
hh = h;
end


hfigzoom = zoom(gcf); setAxes3DPanAndZoomStyle(hfigzoom,gca,'camera');


dcm=datacursormode(gcf);
datacursormode on

zdata1=varargin{1};
% set(dcm,'updatefcn',{@infoCursor zdata1 });
% set(dcm,'DisplayStyle','window')
% 
end

%%

function [val, idx] = getarg(strname,varargin)
idx = 0;
val = NaN;
for jj=1:nargin-2
if strcmpi(varargin{jj},strname)
idx = jj;
val = varargin{jj+1};
return;
end
end
end
function cdata = makecdata(clrs,maxclr)
cdata = NaN(6*numel(clrs),4);
for ii=1:numel(clrs)
cdata((ii-1)*6+(1:6),:)=makesingle_cdata(clrs(ii));
end
if nargin>=2
% it doesn't matter that we put an extra value on cdata(1,1)
% this vertex is NaN (serves as a separator
cdata(1,1)=maxclr;
end
end
function scdata = makesingle_cdata(clr)
scdata = NaN(6,4);
scdata(sub2ind(size(scdata),[3,2,2,1,2,4],[2,1,2,2,3,2]))=clr;
end


%% Text function 
function [output_txt] = infoCursor(~,event_obj,zdata)
% Display the position of the data cursor
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text string (string or cell array of strings).

pos = get(event_obj,'Position');
xsel = round( pos(1) );
ysel = round( pos(2) );

% zdata(xsel,ysel)

output_txt = {...    
    ['x=' num2str(xsel,'%d')],...
    ['y=' num2str(ysel,'%d')],...
    ['z=' num2str(zdata(ysel,xsel),'%.3e')],...
    };

% h_scatter3 = findobj(gca,'Type','hggroup');
h_scatter3 = findobj(gca,'Type','Scatter');

if ~isempty(h_scatter3);
    delete(h_scatter3);
end

hold on;
z1=zdata(ysel,xsel);
htop=scatter3(xsel,ysel,z1,60,'d',...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[1 0 0]);
hold off;
end