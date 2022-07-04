function plotTransferFunction(varargin)

%%

p=inputParser;
p.KeepUnmatched=true;

addParameter(p,'legend',{})
addParameter(p,'ColorSet',[],@isnumeric)
addParameter(p,'MarkerSet',{},@iscell)
addParameter(p,'LineStyleSet',{},@iscell)
addParameter(p,'LineWidthSet',[],@isnumeric)
addParameter(p,'letter','no',@ischar)
addParameter(p,'xlabel',{})
addParameter(p,'ylabel',{})
addParameter(p,'nplot',6,@isnumeric)
addParameter(p,'fig',[],@isnumeric)
addParameter(p,'log','no',@ischar)
addParameter(p,'comp',[],@isnumeric)
addParameter(p,'comp1',[],@isnumeric)
addParameter(p,'comp2',[],@isnumeric)
addParameter(p,'xlim',[],@isnumeric)
addParameter(p,'button','on',@ischar)
addParameter(p,'restructure','no',@ischar)

indData=nargin;
for k=1:nargin
    if ischar(varargin{k})
        indData=k-1; break;
	end
end

vararginDataCell=varargin(1:indData);
vararginParametersCell=varargin((indData+1):nargin);

parse(p,vararginParametersCell{1:end});

legendLabels=p.Results.legend;
ColorSet=p.Results.ColorSet;
MarkerSet=p.Results.MarkerSet;
LineStyleSet=p.Results.LineStyleSet;
LineWidthSet=p.Results.LineWidthSet;
letter=p.Results.letter;
xLabels=p.Results.xlabel;
yLabels=p.Results.ylabel;
nSubPlot=p.Results.nplot;
figNoNew=p.Results.fig;
logaxis=p.Results.log;
comp=p.Results.comp;
comp1=p.Results.comp1;
comp2=p.Results.comp2;
xlimit=p.Results.xlim;
button=p.Results.button;
restructure=p.Results.restructure;

%%

% if iscell(vararginDataCell{1});
% 	vararginDataCell=vararginDataCell{1};
% elseif isnumeric(vararginDataCell{1}) & iscell(vararginDataCell{2})
%     vararginDataCell={vararginDataCell{1} vararginDataCell{2}{1:end} };
% end


nData=indData/2;

for k=1:nData;
w_k{k}=vararginDataCell{2*k-1};
H_k{k}=vararginDataCell{2*k};
end

%%

if nData==1 & size(H_k{1},3)==1
   Htemp=H_k{1}; H_k{1}=[]; H_k{1}(1,1,:)=Htemp;
end

if ~isempty(comp);
	for k=1:nData
	H_k{k}=H_k{k}(comp,comp,:);
	end
elseif ~isempty(comp1) | ~isempty(comp2)
    
    if isempty(comp1); comp1=1:size(H_k{1},1); end
    if isempty(comp2); comp2=1:size(H_k{1},2); end
    
	for k=1:nData
	H_k{k}=H_k{k}(comp1,comp2,:);
	end
end
    
n1=size(H_k{1},1);
n2=size(H_k{1},2);
n=n1*n2;


if isempty(LineWidthSet)
LineWidthSet=0.5*ones(1,nData);
end

if isempty(ColorSet)
ColorSet=GenColor(nData);
end

if isempty(MarkerSet)
MarkerSet=repcell('none',1,30);  
end

if isempty(LineStyleSet)
LineStyleSet= {'-' , '-' , '-' , '-' , '-' , '-' , '-' , '-' , '-'  , '-' , '-' , '-'};  
end

if isempty(figNoNew)
[figNoNew,~]=availablefigno(1,100);
else
[figNoNew,~]=availablefigno(figNoNew,100);
end

if isempty(legendLabels)
	legendLabels=strseq('',[1:nData]);
end

if isempty(xLabels)
    xLabels=repcell('Frequency [rad/s]',1,n1*n2);
end

if iscell(yLabels) & isempty(yLabels)
	yLabels=strseq('H',[1:n1*n2]);
elseif ischar(yLabels)
    yLabels=strseq(yLabels,[1:n1*n2]);
end

for k=1:length(yLabels)
   if ~isempty(strfind(yLabels{k},'$')); yLabelInterpreter{k}='latex';
   elseif ~isempty(strfind(yLabels{k},'{')); yLabelInterpreter{k}='tex';
   else yLabelInterpreter{k}='none'; end
end

if isempty(xlimit)

    for k=1:length(w_k)
    w_min(k)=min(w_k{k});
    w_max(k)=max(w_k{k});
    end

    w_min=min(w_min);
    w_max=max(w_max);

    xlimit=[w_min w_max];
end

%%
figure(); sizefig();

if strcmpi(restructure,'yes');
	n1_plot=ceil(sqrt(n)); n2_plot=ceil(n/n1_plot);
else
	n1_plot=n1; n2_plot=n2;
end

ha = tight_subplot(n1_plot,n2_plot,[.05 .05],[.05 .05],[.05 .05]);

kk=0;
for i=1:n1
    for j=1:n2
        kk=kk+1;
        if kk>n; continue; end
        axesfast(ha(kk)); hold on; grid on;
        
        for k=1:nData
        H_plot=squeeze(H_k{k}(i,j,:));
        if isreal(H_plot);     
        plot(w_k{k},H_plot,'Color',ColorSet(k,:),'LineStyle',LineStyleSet{k},'LineWidth',LineWidthSet(k),'Marker',MarkerSet{k});
        else
        plot(w_k{k},real(H_plot),'Color',ColorSet(k,:),'LineStyle',LineStyleSet{k},'LineWidth',LineWidthSet(k),'Marker',MarkerSet{k});
        plot(w_k{k},imag(H_plot),'Color',ColorSet(k,:),'LineStyle','--','LineWidth',LineWidthSet(k),'Marker',MarkerSet{k});
        end
        end
        
        xl=xlabel(xLabels{kk});
        yl=ylabel(yLabels(kk),'Interpreter',yLabelInterpreter{kk});
        set(xl, 'FontSize', 6);
        set(yl, 'FontSize', 6);  
        
        if strcmpi(logaxis,'yes');
        set(gca,'YScale','log');
        xlim(xlimit);
        axistight(gca,[0 0.05],'x','ylog2');
        else
        axistight(gca,[0 0.05],'x','y');
        xlim(xlimit);
        end
       
    end
end


axesfast(ha(1));

l=legend(legendLabels,'FontSize', 8,'Location','NorthEast');

if strcmpi(letter,'yes');
    tight_subplot_letter(ha{k});
end


if strcmpi(button,'on') | strcmpi(button,'yes')
% Create push button
btnBig = uicontrol('Style', 'pushbutton', 'String', 'Big',...
        'Position', [20 20 50 20],...
        'Callback', {@sizefigFig }); 
    
% Create push button
btnLog = uicontrol('Style', 'pushbutton', 'String', 'Log',...
        'Position', [20 0 50 20],...
        'Callback', {@makeLogAxes ha}); 
end


end
%%
function sizefigFig(source,event);

[f_new hax_new]=copyFigContent(gca);
sizefig('m');

btnLog = uicontrol('Style', 'pushbutton', 'String', 'Log',...
        'Position', [20 10 50 20],...
        'Callback', {@makeLogAxes hax_new}); 
    

end	

%%

function makeLogAxes(source,even,ha);

indexAxes=[1:length(ha)];

isLog=strcmpi(get(ha(1),'YScale'),'log');

for k=1:length(indexAxes);
    
    if isLog
    set(ha(indexAxes(k)),'YScale','linear');
    else
    set(ha(indexAxes(k)),'YScale','log');        
    end
    
end

end	