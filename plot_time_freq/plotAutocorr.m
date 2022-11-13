function ha=plotAutocorr(varargin)
%%
p=inputParser;
% p.KeepUnmatched=true;

addParameter(p,'legend',{})
addParameter(p,'location','NorthEast')
addParameter(p,'ColorSet',[],@isnumeric)
addParameter(p,'LineStyleSet',{},@iscell)
addParameter(p,'LineWidthSet',[],@isnumeric)
addParameter(p,'letter','no',@ischar)
addParameter(p,'lettersize',8,@isnumeric)
addParameter(p,'letterpos',[],@isnumeric)
addParameter(p,'xlabel',{})
addParameter(p,'ylabel',{})
addParameter(p,'labelsize',6,@isnumeric)
addParameter(p,'fig',[],@isnumeric)
addParameter(p,'log','no',@ischar)
addParameter(p,'xlim',20,@isnumeric)
addParameter(p,'button','on',@ischar)
addParameter(p,'component',[],@isnumeric)
addParameter(p,'type','all',@ischar)
addParameter(p,'interpreter','none',@ischar)
addParameter(p,'alpha',[],@isnumeric)
addParameter(p,'xzoom',[],@isnumeric)


addParameter(p,'n1',[],@isnumeric)
addParameter(p,'n2',[],@isnumeric)

addParameter(p,'gap',[.05 .05],@isnumeric)
addParameter(p,'marg_w',[.075 .05],@isnumeric)
addParameter(p,'marg_h',[.05 .025],@isnumeric)

indSignal=nargin;
for k=1:nargin
    if ischar(varargin{k}) | isstruct(varargin{k})
        indSignal=k-1; break;
	end
end

vararginSignalCell=varargin(1:indSignal);
vararginParametersCell=varargin((indSignal+1):nargin);

parse(p,vararginParametersCell{1:end});

legendLabels=p.Results.legend;
location=p.Results.location;
ColorSet=p.Results.ColorSet;
LineStyleSet=p.Results.LineStyleSet;
LineWidthSet=p.Results.LineWidthSet;
letter=p.Results.letter;
lettersize=p.Results.lettersize;
letterpos=p.Results.letterpos;
xLabels=p.Results.xlabel;
yLabels=p.Results.ylabel;
labelSize=p.Results.labelsize;
figNoNew=p.Results.fig;
logAxis=p.Results.log;
xlim_time=p.Results.xlim;
button=p.Results.button;
component=p.Results.component;
type=p.Results.type;
interpreter=p.Results.interpreter;
alpha=p.Results.alpha;
xzoom=p.Results.xzoom;

n1=p.Results.n1;
n2=p.Results.n2;
gap=p.Results.gap;
marg_w=p.Results.marg_w;
marg_h=p.Results.marg_h;

%%

if iscell(vararginSignalCell{1});
	vararginSignalCell=vararginSignalCell{1};
end

nTau=0;
nSources=0;

nTau=nTau+1; tau{nTau}=vararginSignalCell{1};

for k=2:length(vararginSignalCell)
	if checkxaxis(vararginSignalCell{k})
		nTau=nTau+1; tau{nTau}=vararginSignalCell{k};
	else
		nSources=nSources+1; x{nSources}=vararginSignalCell{k};	
    end
end

if nTau==1
    tau=repcell(tau{1},1,nSources);
end

nSignals=size(x{1},1);

% nSignals
% nTau
% nSources

%% parameters

if length(xlim_time)==1;
    xlim_time=[0 xlim_time];
end

if isempty(LineWidthSet)
LineWidthSet=0.5*ones(1,nSources);
end

if isempty(ColorSet)
ColorSet=GenColor(nSources);
end

if ~isempty(alpha)
    if size(alpha,1)<size(alpha,2); alpha=alpha.'; end
    ColorSet=[ColorSet alpha];
end

if isempty(LineStyleSet)
LineStyleSet= {'-' , '-' , '-' , '-' , '-' , '-' , '-' , '-' , '-'  , '-' , '--' , '--', '--' , '--' , '--'};  
end

if isempty(figNoNew)
[figNoNew,~]=availablefigno(1,1);
else
[figNoNew,~]=availablefigno(figNoNew,1);
end

if isempty(legendLabels)
	legendLabels=strseq('',[1:nSources]);
end

if ~isempty(component);
    nSignals=length(component);
    for k=1:nSources;
        x{k}=x{k}(component,component,:);
    end
end

if iscell(yLabels) & isempty(yLabels)
	yLabels=strseq('Signal ',[1:nSignals]);
elseif ischar(yLabels) & nSignals>1
    yLabels=strseq(yLabels,[1:nSignals]);
elseif ischar(yLabels) & nSignals==1
    yLabels={yLabels};
end


if ( ischar(xLabels) & nSignals>1 ) | ( length(xLabels)==1 & nSignals>1 )
    xLabels=repcell(xLabels,1,nSignals);
elseif ischar(xLabels) & nSignals==1
    xLabels={xLabels};
elseif isempty(xLabels);
    xLabels=repcell('Time lag',1,nSignals);
end


%%
if ~strcmpi(type,'auto')

figure(figNoNew); sizefig();
ha = tight_subplot(nSignals,nSignals,gap,marg_h,marg_w); 
% axes('Position',[0 0 1 1],'Visible','off');

kk=0;
for n=1:nSignals
    for m=1:nSignals
            kk=kk+1;
            axesfast(ha(kk)); hold on; grid on;
            
            for j=1:nSources
            x_plot=squeeze(x{j}(n,m,:));
            plot(tau{j},real(x_plot),'Color',ColorSet(j,:),'LineStyle',LineStyleSet{j},'LineWidth',LineWidthSet(j));
            end
            
            if strcmpi(logAxis,'yes') & n==m
            set(gca,'yscale','log');
            xlim([xlim_time]); 
            axistight(gca,[0.05],'ylog2');   
            else
            xlim([xlim_time]);
%             axistight(gca,[0 0.05],'x','y');   
            end
            
            if ~isempty(xzoom)
                ylimxRange(gca,[xzoom]); 
            end
            
	if n==nSignals & ~isempty(yLabels)
	xlabel(xLabels{m},'FontSize',labelSize,'Interpreter',interpreter);
	end

	if m==1 & ~isempty(yLabels)
	ylabel(yLabels{n},'FontSize',labelSize,'Interpreter',interpreter);
    end

    end

end

end

%%

if strcmpi(type,'auto')

if ~isempty([ n1 n2]);
%     n1=n1; n2=n2;
elseif nSignals==1; 
    n2=1; n1=1;
elseif any(nSignals==[3 6 9])
    n2=3; n1=nSignals/3;
elseif any(nSignals==[2 4 8])
    n2=2; n1=ceil(nSignals/2);
else
	n1=ceil(sqrt(nSignals)); n2=ceil(nSignals/n1);
end


figure(figNoNew); sizefig();
ha = tight_subplot(n1,n2,gap,marg_h,marg_w); 
% axesfast('Position',[0 0 1 1],'Visible','off');

kk=0;
for m=1:nSignals
            kk=kk+1;
            axesfast(ha(kk)); hold on; grid on;
            
            for j=1:nSources
            x_plot=squeeze(x{j}(m,m,:));
            plot(tau{j},real(x_plot),'Color',ColorSet(j,:),'LineStyle',LineStyleSet{j},'LineWidth',LineWidthSet(j));
            end

            if strcmpi(logAxis,'yes') % & n==m
            set(gca,'yscale','log');
            xlim([xlim_time]); 
            axistight(gca,[0.05],'ylog2');   
            else
            axistight(gca,[0 0.05],'x','y');   
            xlim([xlim_time]);
            end
            
            if ~isempty(xzoom)
                axistightrangex(gca,[xzoom],'y0'); 
            end
            
	if ~isempty(xLabels)
	xlabel(xLabels{m},'FontSize',labelSize,'Interpreter',interpreter);
	end

	if ~isempty(yLabels)
	ylabel(yLabels{m},'FontSize',labelSize,'Interpreter',interpreter);
	end

end

end

%%

axesfast(ha(1));
l=legend(legendLabels,'FontSize', 8,'Location',location,'Interpreter',interpreter);

if strcmpi(legendLabels,'off')
    delete(l);
end


if strcmpi(letter,'yes')
    tight_subplot_letter(ha,lettersize,letterpos);
end

if strcmpi(button,'on') | strcmpi(button,'yes')
% Create push button
btnBig = uicontrol('Style', 'pushbutton', 'String', 'Big',...
        'Position', [20 20 50 20],...
        'Callback', {@buttonplotsub }); 
    
% Create push button
btnLog = uicontrol('Style', 'pushbutton', 'String', 'Log',...
        'Position', [20 0 50 20],...
        'Callback', {@buttonlogscale ha}); 
end


end

%%

% function makeBigFig(source,event);

% [f_new hax_new]=copyFigContent(gca);
% sizefig('m');

% btnLog = uicontrol('Style', 'pushbutton', 'String', 'Log',...
        % 'Position', [20 10 50 20],...
        % 'Callback', {@makeLogAxes hax_new}); 
    

% end	
%
% function makeLogAxes(source,even,ha);

% if sqrt(length(ha))==round(sqrt(length(ha))); diagonalOnly=true; else; diagonalOnly=false; end

% diagonalOnly=false;

% indexAxes=[1:length(ha)];
% if diagonalOnly
% indexAxes=diag(reshape(indexAxes,sqrt(length(ha)),sqrt(length(ha)))); 
% else
% end

% isLog=strcmpi(get(ha(1),'YScale'),'log');

% for k=1:length(indexAxes);
    
    % if isLog
    % set(ha(indexAxes(k)),'YScale','linear');
    % else
    % set(ha(indexAxes(k)),'YScale','log');        
    % end
    
% end

% end

	


