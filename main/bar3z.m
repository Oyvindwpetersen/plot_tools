function  bar3z(A,varargin )
%% 3D bar chart
%
% Inputs:
% A: matrix to plot as bars
%
% Outputs: none
% 
%% Default inputs

p=inputParser;
% p.KeepUnmatched=true;

addParameter(p,'YTickLabel','',@iscell)
addParameter(p,'XTickLabel','',@iscell)
addParameter(p,'xlabel','Column',@ischar)
addParameter(p,'ylabel','Row',@ischar)
addParameter(p,'TickLabelFontSize',6,@isnumeric)
addParameter(p,'log','no',@ischar)

parse(p,varargin{:})

XTickLabel=p.Results.XTickLabel;
YTickLabel=p.Results.YTickLabel;
xl=p.Results.xlabel;
yl=p.Results.ylabel;
TickLabelFontSize=p.Results.TickLabelFontSize;
logaxis=p.Results.log;

%%

bar3c(A);

[n1,n2]=size(A);

if isempty(YTickLabel)
	YTickLabel=strseq('y',[1:n1])';
end

if isempty(XTickLabel)
	XTickLabel=strseq('x',[1:n2])';
end

set(gca,'XTick',[1:n2]);
set(gca,'YTick',[1:n1]);


set(gca,'XTickLabel',XTickLabel,'fontsize',TickLabelFontSize)
set(gca,'YTickLabel',YTickLabel,'fontsize',TickLabelFontSize)
set(gca,'TickLabelInterpreter','tex');

ylabel(yl);
xlabel(xl);

axistight(gca,[0.05 0.05 0.05],'x','y','z')

axis equal
xlim([1-0.5 n2+0.5]);
ylim([1-0.5 n1+0.5]);

view([-25 35]);

if strcmpi(logaxis,'yes')
    set(gca,'ZScale','log');
    axistight(gca,[0 0 0.05],'keepx','keepy','zlog');
end

dcm=datacursormode(gcf);
datacursormode on

set(dcm,'updatefcn',{@infoCursor A YTickLabel XTickLabel });


end

%% Text function 
function [output_txt] = infoCursor(~,event_obj,zdata,YTickLabel,XTickLabel)
% Display the position of the data cursor
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text string (string or cell array of strings).

pos = get(event_obj,'Position');
xsel = round( pos(1) );
ysel = round( pos(2) );

output_txt = {...    
    [YTickLabel{ysel}],...
    [XTickLabel{xsel}],...
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
