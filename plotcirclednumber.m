function plotcirclednumber(hax,x,y,FontSize,MarkerSize,TextColor,MarkerColor,varargin)

%%

p=inputParser;

addParameter(p,'text',{})

parse(p,varargin{1:end});

text_cell=p.Results.text;

%%

if isempty(hax)
    hax=gca;
end

axesfast(hax);

nx=length(x);
ny=length(y);

n=max([nx ny]);

if nx==1
    x=x*ones(1,n);
end

if ny==1
    y=y*ones(1,n);
end


if isempty(text_cell)
    for j=1:length(x)
        text_cell{j}=num2str(j);
    end
end

if ischar(text_cell)
    text_cell={text_cell};
end



for j=1:length(x)
    
    text(x(j),y(j),text_cell{j},'Interpreter','latex','Color',TextColor,'FontSize',FontSize,...
        'HorizontalAlignment','center','verticalAlignment','middle');

    plot(x(j),y(j),'LineStyle','none','Marker','o','MarkerSize',MarkerSize,'MarkerFaceColor','none','MarkerEdgeColor',MarkerColor);

end

% plotscriptmain('h',8,'w',15,'name','wind_time','path',[BaseFolder 'Hardanger\GPLFM\paper_journal\fig'],'labelsize',6,'ticksize',6,'legendsize',6,'titlesize',6,'box','on','format',{'pdf' 'jpg'});
