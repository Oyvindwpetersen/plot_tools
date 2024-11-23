function [h_surf,h_iso]=surfiso(x,f,varargin)

%% 2D surface with isolines
%
% Inputs:
% x: [N,2] matrix with x1 and x2 values as columns (must be a rectangular grid)
% f: [N,1] vector with surface values
%
% Outputs:
% h_surf: handle to surface
% h_iso: handle to isolines
%
%%

p=inputParser;

addParameter(p,'xlabel','x',@ischar)
addParameter(p,'ylabel','y',@ischar)
addParameter(p,'zlabel','z',@ischar)
addParameter(p,'facealpha',0.8,@isnumeric)
addParameter(p,'displayname','',@ischar)
addParameter(p,'isolines',[20],@isnumeric) % Number of isolines between [f_min,f_max]
addParameter(p,'linestyle','-',@ischar)
addParameter(p,'linewidth',0.3,@isnumeric) 
addParameter(p,'view',[40 15],@isnumeric)
addParameter(p,'cbar',[0.5 1 0 0],@isnumeric) % Set to NaN to turn off colorbar
addParameter(p,'xtick',[],@isnumeric)
addParameter(p,'ytick',[],@isnumeric)
addParameter(p,'interpreter','latex',@ischar)
addParameter(p,'xlpos',[0 0 0],@isnumeric)
addParameter(p,'xlog',false,@islogical)
addParameter(p,'ylog',false,@islogical)

addParameter(p,'markercolor',[0.5 0.5 0.5],@isnumeric)
addParameter(p,'markersize',[],@isnumeric)

parse(p,varargin{1:end});

xlab=p.Results.xlabel;
ylab=p.Results.ylabel;
zlab=p.Results.zlabel;
facealpha=p.Results.facealpha;
displayname=p.Results.displayname;
isolines=p.Results.isolines;
linestyle=p.Results.linestyle;
linewidth=p.Results.linewidth;
viewvec=p.Results.view;
cbar=p.Results.cbar;
xtick=p.Results.xtick;
ytick=p.Results.ytick;
interpreter=p.Results.interpreter;
xlpos=p.Results.xlpos;
doxlog=p.Results.xlog;
doylog=p.Results.ylog;

markercolor=p.Results.markercolor;
markersize=p.Results.markersize;

%%

if size(x,2)~=2
    error('x must be 2 columns')
end

if any(any(imag(f)))
    error('f must be real')
end

f=f(:);

if size(x,1)~=size(f,1)
    error('x and f must have equal number of rows');
end

if doxlog
    xlog;
end

if doylog
    ylog;
end

% xlabel(xlab,'interpreter',interpreter);
% ylabel(ylab,'interpreter',interpreter);
% zlabel(zlab,'interpreter',interpreter);

% Surf
tri=delaunay(x(:,1),x(:,2));
h_surf=trisurf(tri,x(:,1),x(:,2),f,'EdgeColor','none','FaceAlpha',facealpha,'DisplayName',displayname);
shading interp

% Isoline
surfcell={tri,[x(:,1),x(:,2),f]};
[h_iso,V]=IsoLine(surfcell,f,isolines,[0.5 0.5 0.5],linestyle);

for k=1:length(h_iso)
    if isnan(h_iso(k)); continue; end

    set(h_iso(k),'LineWidth',linewidth);
end

if ~isempty(markersize)
    plot3(x(:,1),x(:,2),f,'o','color',markercolor,'markersize',markersize);
end

colormap(brewermap(100,'GnBu'));

if ~isnan(cbar)
    hc=colorbar('Location','north');
    
    scale_x=cbar(1);
    scale_y=cbar(2);
    dx=cbar(3);
    dy=cbar(4);
    
    colorbarpos(hc,scale_x,scale_y,dx,dy);
end

view(viewvec);


axistight(gca,[0 0 0],'x','y','z');

if ~isempty(xtick)
    set(gca,'XTick',xtick);
end

if ~isempty(ytick)
    set(gca,'YTick',ytick);
end

h=get(gca,'XLabel'); set(h,'Position',h.Position+xlpos);

xlabel(xlab,'interpreter',interpreter);
ylabel(ylab,'interpreter',interpreter);
zlabel(zlab,'interpreter',interpreter);
