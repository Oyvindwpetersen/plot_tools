function [h_surf,h_iso]=surfiso(x,f,varargin)

%%

p=inputParser;

addParameter(p,'xlabel','x',@ischar)
addParameter(p,'ylabel','y',@ischar)
addParameter(p,'zlabel','z',@ischar)
addParameter(p,'displayname','',@ischar)
addParameter(p,'isoval',[20],@isnumeric) % Number of isolines between [f_min,f_max], or vector with values
addParameter(p,'view',[40 15],@isnumeric) % Number of isolines between [f_min,f_max], or vector with values

parse(p,varargin{1:end});

xlab=p.Results.xlabel;
ylab=p.Results.ylabel;
zlab=p.Results.zlabel;
displayname=p.Results.displayname;
isoval=p.Results.isoval;
viewvec=p.Results.view;

%%

if size(x,2)~=2
    error('x must be 2 columns');
end

if size(x,1)~=size(f,1)
    error('x and f must have equal rows');
end


% Surf
tri=delaunay(x(:,1),x(:,2));
h_surf=trisurf(tri,x(:,1),x(:,2),f,'EdgeColor','none','FaceAlpha','0.8','DisplayName',displayname);
shading interp

% Isoline
SurfCell={tri,[x(:,1),x(:,2),f]};
[h_iso,V]=IsoLine(SurfCell,f,isoval,[0.5 0.5 0.5]);

colormap(brewermap(100,'GnBu'));
hc=colorbar('Location','north');
colorbarpos(hc,0.5,1.0,0,0.2);

view(viewvec);

xlabel(xlab);
ylabel(ylab);
zlabel(zlab);
