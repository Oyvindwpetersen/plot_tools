function [hs,hc]=bar3z_alt(A,varargin)

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
addParameter(p,'xlabel','',@ischar) %Column
addParameter(p,'ylabel','',@ischar) %Row
addParameter(p,'fontsize',6,@isnumeric)
addParameter(p,'log',false,@islogical)
addParameter(p,'view',[220 60],@isnumeric)
addParameter(p,'colorbar',true,@islogical)
addParameter(p,'colormap','GnBu',@ischar)
addParameter(p,'clim',[],@isnumeric)
addParameter(p,'text',false,@islogical)
addParameter(p,'hax',[])
addParameter(p,'cbarscale',[0.75 0.75],@isnumeric)
addParameter(p,'bar',false,@isnumeric)

parse(p,varargin{:})

XTickLabel=p.Results.XTickLabel;
YTickLabel=p.Results.YTickLabel;
xl=p.Results.xlabel;
yl=p.Results.ylabel;
fontsize=p.Results.fontsize;
logaxis=p.Results.log;
view_angle=p.Results.view;
colorbar_logic=p.Results.colorbar;
colormap_scheme=p.Results.colormap;
clim=p.Results.clim;
text=p.Results.text;
hax=p.Results.hax;
cbarscale=p.Results.cbarscale;
do_bar=p.Results.bar;

%%
[n1,n2]=size(A);

if isempty(YTickLabel)
	YTickLabel=strseq('y',[1:n1])';
end

if isempty(XTickLabel)
	XTickLabel=strseq('x',[1:n2])';
end

%%

if isempty(hax)
    figure();
    hax=tight_subplot(1,1,[],[0.1 0.05],[0.0 0.05]);
else
    axes(hax);
end
% hold on;


warning('Functionality of bar3z_alt.m is moved to squares.m')

%%
if do_bar

hs=bar3(A); tilefigs

for k=1:numel(hs)

    zdata=get(hs(k),'Zdata');

    z_col=zdata(2:6:end,2);
    
    cdata=NaN(6*numel(z_col),4);
    
    ind_del_nan=[];
    for i=1:numel(z_col)
        
        scdata=NaN(6,4);
        scdata(sub2ind(size(scdata),[3,2,2,1,2,4],[2,1,2,2,3,2]))=z_col(i);
        
        cdata((i-1)*6+(1:6),:)=scdata;
        
        if isnan(A(i,k))
            ind_del_nan=[ind_del_nan (i-1)*6+(1:6)];
        end
    end

	set(hs(k),'Cdata',cdata,'facecolor','flat');
    
    ind_del_all{k}=[ind_del_nan(:) ];
    cdata_all{k}=cdata;
end

for k=1:numel(hs)

    if ~isempty(ind_del_all{k})
%         cdata=get(hs(k),'Cdata');

        cdata=cdata_all{k};

        xdata=get(hs(k),'Xdata');
        ydata=get(hs(k),'Ydata');
        zdata=get(hs(k),'Zdata');
        
        cdata(ind_del_all{k},:)=[];
        xdata(ind_del_all{k},:)=[];
        ydata(ind_del_all{k},:)=[];
        zdata(ind_del_all{k},:)=[];
        
        if isempty(xdata); delete(hs(k)); continue; end

        set(hs(k),'Xdata',xdata,'Ydata',ydata,'Zdata',zdata,'Cdata',cdata,'facecolor','flat');
    end

end

for k1=1:size(A,1)
for k2=1:size(A,2)
        
    zz=max(max(A));
    
    if isnan(A(k1,k2))
        % str='N/A';
        continue
    else
        str=num2str(A(k1,k2),'%0.2f');
    end
    
    if text==true
         text(k2,k1,zz,str,'HorizontalAlignment','center','color',[0 0.8 0.3],'fontsize',4,...
        'BackgroundColor','none','Margin',0.1);
    end

    hold on;
    % plot3(k2,k1,A(k1,k2),'Marker','o','LineStyle','None');
    
end
end

end

%%

if do_bar==false

hs=[];

delta=0.4;

for k1=1:size(A,1)
    for k2=1:size(A,1)

        % a=A(k1,k2);
        % Corner points
        x = [k1-delta k1+delta k1+delta k1-delta];
        y = [k2-delta k2-delta k1+delta k1+delta];
        z = [0 0 0 0];

        patch('XData', x, 'YData', y, 'ZData', z, ...
        'FaceColor','blue','EdgeColor','black');

    end
end

end



%%

set(gca,'XTick',[1:n2]);
set(gca,'YTick',[1:n1]);

set(gca,'XTickLabel',XTickLabel,'fontsize',fontsize)
set(gca,'YTickLabel',YTickLabel,'fontsize',fontsize)
set(gca,'TickLabelInterpreter','latex');

ylabel(yl);
xlabel(xl);

xlim([1 n2]+[-0.6 0.6]);
ylim([1 n1]+[-0.6 0.6]);

axistight(gca,[0.05 0.05 0.05],'keepx','keepy','z');

view(view_angle);

s=get(gca,'DataAspectRatio');
s_new=[ 1 1 1/(s(3)*mean(s(1:2)))];
set(gca,'DataAspectRatio',s_new);

if logaxis
    set(gca,'ZScale','log');
    axistight(gca,[0 0 0.05],'keepx','keepy','zlog');
end



% Turn on colorbar
if colorbar_logic
    hc=colorbar;
    
    % Set color scheme
    [map,num,typ] = brewermap(100,colormap_scheme); colormap(map);
    
    % Scale colorbar smaller
    % if length(cbarscale)==2; cbarscale(3:4)=0; end
    % colorbarpos(hc,cbarscale(1),cbarscale(2),cbarscale(3),cbarscale(4));
    
    % Adjust min/max limits
    if ~isempty(clim)
        set(hc,'Limits',clim);
    end
    
end

colorbarpos2(gca)


dcm=datacursormode(gcf);
datacursormode on

set(dcm,'updatefcn',{@infoCursor A });

end

%% Text function 
function [output_txt]=infoCursor(~,event_obj,zdata)
% Display the position of the data cursor
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text string (string or cell array of strings).

pos=get(event_obj,'Position');
xsel=round( pos(1) );
ysel=round( pos(2) );

% zdata(xsel,ysel)

output_txt={...    
    ['x=' num2str(xsel,'%d')],...
    ['y=' num2str(ysel,'%d')],...
    ['z=' num2str(zdata(ysel,xsel),'%.3e')],...
    };

% h_scatter3=findobj(gca,'Type','hggroup');
h_scatter3=findobj(gca,'Type','Scatter');

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