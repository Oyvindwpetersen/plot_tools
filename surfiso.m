function [h_surf,h_iso]=surfiso(x,f,varargin)

%% 2D surface with isolines
%
% Inputs:
% x: [N,2] matrix with x1 and x2 values as columns
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
addParameter(p,'view',[40 15],@isnumeric)

parse(p,varargin{1:end});

xlab=p.Results.xlabel;
ylab=p.Results.ylabel;
zlab=p.Results.zlabel;
facealpha=p.Results.facealpha;
displayname=p.Results.displayname;
isolines=p.Results.isolines;
viewvec=p.Results.view;

%%

if size(x,2)~=2
    error('x must be 2 columns');
end

f=f(:);

if size(x,1)~=size(f,1)
    error('x and f must have equal number of rows');
end

% Surf
tri=delaunay(x(:,1),x(:,2));
h_surf=trisurf(tri,x(:,1),x(:,2),f,'EdgeColor','none','FaceAlpha',facealpha,'DisplayName',displayname);
shading interp

% Isoline
surfcell={tri,[x(:,1),x(:,2),f]};
[h_iso,V]=IsoLine(surfcell,f,isolines,[0.5 0.5 0.5]);

colormap(brewermap(100,'GnBu'));
hc=colorbar('Location','north');
colorbarpos(hc,0.5,1.0,0,0.2);

view(viewvec);

xlabel(xlab);
ylabel(ylab);
zlabel(zlab);
