function varargout = plotTime(varargin);

%%

p=inputParser;
% p.KeepUnmatched=true;

addParameter(p,'legend',{})
addParameter(p,'location','NorthEast')
addParameter(p,'ColorSet',[],@isnumeric)
addParameter(p,'MarkerSet',{},@iscell)
addParameter(p,'LineStyleSet',{},@iscell)
addParameter(p,'LineWidthSet',[],@isnumeric)
addParameter(p,'letter','no',@ischar)
addParameter(p,'lettersize',8,@isnumeric)
addParameter(p,'letterpos',[],@isnumeric)
addParameter(p,'xlabel',{})
addParameter(p,'ylabel',{})
addParameter(p,'nsub',6,@isnumeric)
addParameter(p,'fig',[],@isnumeric)
addParameter(p,'cut',[],@isnumeric)
addParameter(p,'gap',[.075 .075],@isnumeric)
addParameter(p,'marg_h',[.075 .05],@isnumeric)
addParameter(p,'marg_w',[.05 .025],@isnumeric)
addParameter(p,'interpreter','none',@ischar)
addParameter(p,'xlim',[],@isnumeric)
addParameter(p,'alpha',[],@isnumeric)
addParameter(p,'comp',[],@isnumeric)

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
MarkerSet=p.Results.MarkerSet;
LineStyleSet=p.Results.LineStyleSet;
LineWidthSet=p.Results.LineWidthSet;
letter=p.Results.letter;
lettersize=p.Results.lettersize;
letterpos=p.Results.letterpos;
xLabels=p.Results.xlabel;
yLabels=p.Results.ylabel;
nSubPlot=p.Results.nsub;
figNoNew=p.Results.fig;
cut=p.Results.cut;
gap=p.Results.gap;
marg_h=p.Results.marg_h;
marg_w=p.Results.marg_w;
interpreter=p.Results.interpreter;
xlimit=p.Results.xlim;
alpha=p.Results.alpha;
comp=p.Results.comp;


%%

% if no time vector is given
if length(vararginSignalCell)==1
    vararginSignalCell{2}=vararginSignalCell{1};
    vararginSignalCell{1}=1:length(vararginSignalCell{2});
    xLabels='Datapoints [n]';
end

if iscell(vararginSignalCell{1})
	vararginSignalCell=vararginSignalCell{1};
elseif isnumeric(vararginSignalCell{1}) & iscell(vararginSignalCell{2})
    vararginSignalCell={ vararginSignalCell{1} vararginSignalCell{2}{1:end} };
end

nTime=0;
nSources=0;

nTime=nTime+1; t{nTime}=vararginSignalCell{1};

for k=2:length(vararginSignalCell)

	if size(vararginSignalCell{k},1)==1 & checkXaxis(vararginSignalCell{k})
		nTime=nTime+1; t{nTime}=vararginSignalCell{k};
	else
		nSources=nSources+1; x{nSources}=vararginSignalCell{k};	
	end	
	
end

if nTime==1
    t=repcell(t{1},1,nSources);
end

nSignals=size(x{1},1);

for k=1:nSources
    if size(x{k},1)~=nSignals
    error('Size wrong: number of sources not the same');
    end
end


for k=1:nSources
    if size(x{k},2)~=length(t{k})
        error(['Vectors not same size' ',k=' num2str(k)]); return
    end
end

if ~isempty(comp)
    for k=1:nSources
        x{k}=x{k}(comp,:); 
    end
    nSignals=size(x{1},1);
end


%%
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
LineStyleSet=repcell('-',1,30);
end

if isempty(MarkerSet)
MarkerSet=repcell('none',1,30);  
end

if isempty(figNoNew)
[figNoNew,figNoTaken]=availablefigno(1,100);
else
[figNoNew,figNoTaken]=availablefigno(figNoNew,100);
end

if length(figNoTaken)>50
	error('Too many figures open in plotting, aborting.')
end

if isempty(legendLabels) & nSources>1
	legendLabels=strseq('',[1:nSources]);
    plotLegend=true;
elseif isempty(legendLabels) & nSources==1
    plotLegend=false;
else
	plotLegend=true;
end
    

if nSignals < nSubPlot
	nSubPlot=nSignals;
end

if iscell(yLabels) & isempty(yLabels)
	yLabels=strseq('Signal ',[1:nSignals]);
elseif ischar(yLabels)
    yLabels=strseq(yLabels,[1:nSignals]);
end

if isempty(xLabels)
    xLabels=repmat({'Time [s]'},1,nSignals);
elseif ischar(xLabels)
    xLabels=repcell(xLabels,1,nSignals);
end

if isempty(interpreter)
    yLabelInterpreter=repcell('none',1,nSignals);
    for k=1:nSignals
        if ~isempty(strfind(yLabels{k},'$')); yLabelInterpreter{k}='latex';
        elseif ~isempty(strfind(yLabels{k},'{')); yLabelInterpreter{k}='tex';
        end
    end
else
    yLabelInterpreter=repcell(interpreter,1,nSignals);
end

if ~isempty(cut)
    
	if length(cut)==1 & cut(1)<0.5; cut=[cut 1]; end
 	if length(cut)==1 & cut(1)>0.5; cut=[0 cut]; end
       
    n1=round(cut(1)*length(t{1}));	n2=round(cut(2)*length(t{1}));
    
    if n1==0; n1=1; end
        
    for k=1:nSources
        x{k}=x{k}(:,n1:n2); t{k}=t{k}(n1:n2);
    end
    
end

%% Plot

range=rangebin(nSignals,nSubPlot); %number of subplots per figure;
nFig=length(range);

if nFig>17
    error(['Number of figures exceeding limit: ' num2str(nFig)])
end

for k=1:nFig
nSub(k)=length(range{k});
figure(k-1+figNoNew); sizefig();
ha{k} = tight_subplot(nSub(k),1,gap,marg_h,marg_w); 
% axes('Position',[0 0 1 1],'Visible','off');

for kk=1:nSub(k)
%     axes( ha{k}(kk) ); hold on; grid on;
    axesfast( ha{k}(kk) ); hold on; grid on;

    signalNo=range{k}(kk);
    for j=1:nSources
    hp{k}(kk,j)=plot(t{j},x{j}(signalNo,:),'Color',ColorSet(j,:),'LineStyle',LineStyleSet{j},'LineWidth',LineWidthSet(j),'Marker',MarkerSet{j});
    end
    
    xl=xlabel(xLabels{signalNo});
    yl=ylabel(yLabels{signalNo},'Interpreter',yLabelInterpreter{signalNo});
    set(xl, 'FontSize', 8);
    set(yl, 'FontSize', 8);
    axistight(gca,[0 0.05],'x','y');
    
    if ~isempty(xlimit); xlim(xlimit); end;
end
% drawnow
axesfast(ha{k}(1));


if plotLegend
%     hChildren=get(gca,'Children');
    hLines=hp{k}(1,:);
    l=legend(hLines,legendLabels,'FontSize', 8,'Location',location,'Interpreter',interpreter);
end

if strcmpi(letter,'yes')
    tight_subplot_letter(ha{k},lettersize,letterpos);
end

% timeCursor(gcf);
end

if nargout==1 & nFig>1
    varargout{1}=ha;
elseif  nargout==1 & nFig==1
    varargout{1}=ha{1};
end

%%



