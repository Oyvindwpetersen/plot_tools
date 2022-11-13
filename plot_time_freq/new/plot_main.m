function varargout=plot_main(x,y,varargin)

%%

p=inputParser;
% p.KeepUnmatched=true;

addParameter(p,'Displayname',{})
addParameter(p,'legendshow',true)
addParameter(p,'location','NorthEast')
addParameter(p,'Color',[],@isnumeric)
addParameter(p,'alpha',[],@isnumeric)
addParameter(p,'Marker',{},@iscell)
addParameter(p,'LineStyle',{},@iscell)
addParameter(p,'LineWidth',[],@isnumeric)
addParameter(p,'xlabel',{})
addParameter(p,'ylabel',{})
addParameter(p,'fontsize',8,@isnumeric)
addParameter(p,'interpreter','none',@ischar)

addParameter(p,'nh',[6],@isnumeric)
addParameter(p,'nw',[1],@isnumeric)
addParameter(p,'gap',[.075 .075],@isnumeric)
addParameter(p,'marg_h',[.075 .05],@isnumeric)
addParameter(p,'marg_w',[.05 .025],@isnumeric)

addParameter(p,'comp',[],@isnumeric)
addParameter(p,'cut',[],@isnumeric)

addParameter(p,'log',false,@islogical)
addParameter(p,'button','on',@ischar)
addParameter(p,'type','all',@ischar)
addParameter(p,'xlim',[],@isnumeric)
% addParameter(p,'xzoom',[],@isnumeric)
addParameter(p,'complexdata',false,@islogical)

parse(p,varargin{1:end});

Displayname=p.Results.Displayname;
legendshow=p.Results.legendshow;
location=p.Results.location;
Color=p.Results.Color;
alpha=p.Results.alpha;
Marker=p.Results.Marker;
LineStyle=p.Results.LineStyle;
LineWidth=p.Results.LineWidth;
x_labels=p.Results.xlabel;
y_labels=p.Results.ylabel;
fontsize=p.Results.fontsize;
interpreter=p.Results.interpreter;

nh=p.Results.nh;
nw=p.Results.nw;
gap=p.Results.gap;
marg_h=p.Results.marg_h;
marg_w=p.Results.marg_w;

comp=p.Results.comp;
cut=p.Results.cut;

log=p.Results.log;
button=p.Results.button;
type=p.Results.type;
xlimit=p.Results.xlim;
% xzoom=p.Results.xzoom;
complexdata=p.Results.complexdata;

%%

nSignals=size(y{1},1);
nSources=length(y);

[x,y,nSignals]=compcut(x,y,comp,cut);

%%

if isempty(LineWidth)
    LineWidth=0.5*ones(1,nSources);
end

if isempty(Color)
    Color=GenColor(nSources);
end

if ~isempty(alpha)
    if size(alpha,1)<size(alpha,2); alpha=alpha.'; end
    Color=[Color alpha];
end

if isempty(LineStyle)
    LineStyle=repcell('-',1,30);
end

if ~iscell(LineStyle)
    LineStyle={LineStyle};
end

if isempty(Marker)
    Marker=repcell('none',1,30);  
end

if ~iscell(Marker)
    Marker={Marker};
end

if isempty(Displayname)
	Displayname=strseq('',[1:nSources]);
end

if ~iscell(Displayname)
    Displayname={Displayname};
end

if ischar(x_labels)
    x_labels={x_labels};
end

if length(x_labels)~=nSignals
   if length(x_labels)==1
      x_labels=repcell(x_labels{1},1,nSignals);
   else
      nSignals
      x_labels
      error('Length of xlabels incorrect');
   end
end

if isempty(x_labels)
	x_labels=strseq('X ',[1:nSignals]);
end

if ischar(y_labels)
    y_labels={y_labels};
end

if isempty(y_labels)
	y_labels=strseq('Y ',[1:nSignals]);
end

%% Plot

plotopt_all={};
for j=1:nSources
    
    plotopt=struct();
    plotopt.Color=Color(j,:);
    plotopt.LineStyle=LineStyle{j};
    plotopt.LineWidth=LineWidth(j);
    plotopt.Displayname=Displayname{j};
    plotopt.Marker=Marker{j};
    
    plotopt_all{j}=plotopt;
    
	plotopt_all{j}=lowerstruct(plotopt_all{j});

end

axesopt=struct();
axesopt.xlabel=x_labels;
axesopt.ylabel=y_labels;
axesopt.fontsize=fontsize;
axesopt.interpreter=interpreter;
axesopt.xlimit=xlimit;

axesopt.location=location;
axesopt.legendshow=legendshow;

axesopt.gap=gap;
axesopt.marg_h=marg_h;
axesopt.marg_w=marg_w;
axesopt.log=log;
axesopt.complexdata=complexdata;

figopt=struct();
figopt.button=button;

[ha,hp]=plot2d(x,y,nw,nh,plotopt_all,axesopt,figopt);

%%

if length(ha)==1; ha=ha{1}; end

if nargout==1
    varargout{1}=ha;
elseif nargout==2
    varargout{1}=ha;
    varargout{2}=hp;
end

