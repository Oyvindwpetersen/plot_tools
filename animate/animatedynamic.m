function varargout=animatedynamic(phi,gridmatrix,varargin)

%% Inputs

p=inputParser;
p.KeepUnmatched=true;

addParameter(p,'scale',[],@isnumeric)
addParameter(p,'scalep',0.05,@isnumeric)
addParameter(p,'title','');
addParameter(p,'renderer','zbuffer',@ischar);

addParameter(p,'MarkerUndef','x');
addParameter(p,'MarkerDef','o');
addParameter(p,'MarkerSizeUndef',6);
addParameter(p,'MarkerSizeDef',6);
addParameter(p,'ColorUndef',[0 0 0]);
addParameter(p,'ColorDef',[0 0 1]);

addParameter(p,'directions','xyz',@ischar);
addParameter(p,'realpart',false);
addParameter(p,'theta',[],@isnumeric);
addParameter(p,'n_cycles',[10],@isnumeric);
addParameter(p,'n_frame',[50],@isnumeric);
addParameter(p,'view',[-30+180 30],@isnumeric);

addParameter(p,'moviename','',@ischar);
addParameter(p,'format','MPEG-4',@ischar); %Motion JPEG AVI, 'MPEG-4'
addParameter(p,'framerate',15,@isnumeric);

parse(p,varargin{:})
scale=p.Results.scale;
scalep=p.Results.scalep;
renderer=p.Results.renderer;

MarkerUndef=p.Results.MarkerUndef;
MarkerDef=p.Results.MarkerDef;
MarkerSizeUndef=p.Results.MarkerSizeUndef;
MarkerSizeDef=p.Results.MarkerSizeDef;
ColorUndef=p.Results.ColorUndef;
ColorDef=p.Results.ColorDef;

directions=p.Results.directions;
realpart=p.Results.realpart;
theta=p.Results.theta;
n_cycles=p.Results.n_cycles;
n_frame=p.Results.n_frame;
viewvector=p.Results.view;

moviename=p.Results.moviename;
format=p.Results.format;
framerate=p.Results.framerate;

%% Fill phi with zeros for missing directions

phi=phi(:);

if ~strcmpi(directions,'xyz')
    
    switch directions
        
        case 'x'
            phi_filled=reshape([ phi(1:1:end,:).' ; phi(1:1:end,:).'*0 ; phi(1:1:end,:).'*0 ],[],1);
        case 'y'
            phi_filled=reshape([ phi(1:1:end,:).'*0 ; phi(1:1:end,:).' ; phi(1:1:end,:).'*0 ],[],1);
        case 'z'
            phi_filled=reshape([ phi(1:1:end,:).'*0 ; phi(1:1:end,:).'*0 ; phi(1:1:end,:).' ],[],1);
        case 'xy'
            phi_filled=reshape([ phi(1:2:end,:).' ; phi(2:2:end,:).' ; phi(2:2:end,:).'*0 ],[],1);
        case 'xz'
            phi_filled=reshape([ phi(1:2:end,:).' ; phi(2:2:end,:).'*0 ; phi(2:2:end,:).' ],[],1);
        case 'yz'
            phi_filled=reshape([ phi(1:2:end,:).'*0 ; phi(1:2:end,:).' ; phi(2:2:end,:).' ],[],1);
            
    end
    
    phi=phi_filled;
end

%% XYZ

if realpart==true
    [~,rotrad,phir]=rotate_modes(phi);
    phi=real(phir);
    disp(['Real part, rotated ' num2str(rotrad*180/pi,'%0.3f') ' degrees']);
end

%%

n_node=size(phi,1)/3;

dX=phi(1:3:end);
dY=phi(2:3:end);
dZ=phi(3:3:end);

dR=sqrt(dX.^2+dY.^2+dZ.^2);

X0=gridmatrix(:,2);
Y0=gridmatrix(:,3);
Z0=gridmatrix(:,4);

%% Scaling, automatic

if isempty(scale)
    
    xx=gridmatrix(:,2);
    yy=gridmatrix(:,3);
    zz=gridmatrix(:,4);
    D=sqrt( (xx-xx.').^2+ (yy-yy.').^2+ (zz-zz.').^2);

    L_char=max(max(D));
    scale=1/max(dR)*L_char*scalep;
end

dX=dX*scale;
dY=dY*scale;
dZ=dZ*scale;

%%

hfig=figure(); sizefig();
ha=tight_subplot(1,1,[],[0.15 0.15],[0.15 0.15]);
hold on; grid on;

set(hfig,'renderer',renderer);

axis image; %axis manual;
view(viewvector);

%% Limits

Xmin=min(min([X0-real(dX) X0+real(dX)]));
Ymin=min(min([Y0-real(dY) Y0+real(dY)]));
Zmin=min(min([Z0-real(dZ) Z0+real(dZ)]));

Xmax=max(max([X0-real(dX) X0+real(dX)]));
Ymax=max(max([Y0-real(dY) Y0+real(dY)]));
Zmax=max(max([Z0-real(dZ) Z0+real(dZ)]));

xl=[Xmin Xmax];
yl=[Ymin Ymax];
zl=[Zmin Zmax];

if Xmin==Xmax
    xl=Xmin+[-1 1];
end

if Ymin==Ymax
    yl=Ymin+[-1 1];
end

if Zmin==Zmax
    zl=Zmin+[-1 1];
end

xlim('manual'); ylim('manual'); zlim('manual');

xlim(xl); ylim(yl); zlim(zl);

%% Text

h_text=text(xl(end)-diff(xl)*0.1,yl(end)-diff(yl)*0.1,zl(end)-diff(zl)*0.1,'null',...
    'FontName','Arial','EdgeColor',[0 0 0],'BackgroundColor',[1 1 1],...
    'VerticalAlignment','bottom');
uistack(h_text,'top');

%%

plotopt_undef=struct();
plotopt_undef.Color=ColorUndef;
plotopt_undef.Marker=MarkerUndef;
plotopt_undef.MarkerSize=MarkerSizeUndef;
plotopt_undef.MarkerEdgeColor=[0 0 0];
plotopt_undef.MarkerFaceColor=ColorUndef;
plotopt_undef.LineStyle='None';

plotopt_def=struct();
plotopt_def.Color=ColorDef;
plotopt_def.Marker=MarkerDef;
plotopt_def.MarkerSize=MarkerSizeDef;
plotopt_def.MarkerEdgeColor=[0 0 0];
plotopt_def.MarkerFaceColor=ColorDef;
plotopt_def.LineStyle='None';

h_node_undef=plot3(X0,Y0,Z0,plotopt_undef);

h_node_def=plot3(X0+real(dX),Y0+real(dY),Z0+real(dZ),plotopt_def);

hfigzoom=zoom(hfig); setAxes3DPanAndZoomStyle(hfigzoom,gca,'camera');

%%

if isempty(theta)
    theta_max=2*pi*n_cycles;
    dtheta=2*pi/n_frame;
    theta=[0:dtheta:theta_max];
end

if ~isempty(moviename)
    set(hfig,'color','w');
end

for i=1:length(theta)
    
    if ~ishandle(hfig)
        break
    end
    
    timescale=exp(1i*theta(i));
    set(h_text,'String',['\theta=' num2str(mod(theta(i),2*pi)*180/pi,'%0.0f') ' deg']);
    
    dX_plot=X0+real(dX*timescale);
    dY_plot=Y0+real(dY*timescale);
    dZ_plot=Z0+real(dZ*timescale);
    
    set(h_node_def,'xdata',dX_plot,'ydata',dY_plot,'zdata',dZ_plot);
    
    drawnow limitrate
    drawnow
    
    if ~isempty(moviename)
        M(i)=getframe(hfig);
    end
    
end

if ~isempty(moviename)
    v=VideoWriter(moviename,format);
    v.FrameRate=framerate; v.Quality=100;
    open(v);
    writeVideo(v,M);
end

if nargout==1
    varargout{1}=scale;
end


