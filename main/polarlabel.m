function polarLabel(rAxis,rMax,phiAxis,zMax,varargin) 

p=inputParser;
addParameter(p,'LineWidth',1,@isnumeric)
addParameter(p,'angleLabelR',[15],@isnumeric)
addParameter(p,'colorLabelR','Black')
addParameter(p,'unitLabelR','',@ischar)
addParameter(p,'colorLabelPhi','Black')
addParameter(p,'colorGrid',[192 192 192]/256)
addParameter(p,'FontSize',6,@isnumeric)

parse(p,varargin{:});
angleLabelR = p.Results.angleLabelR;
colorLabelR = p.Results.colorLabelR;
unitLabelR = p.Results.unitLabelR;
colorLabelPhi = p.Results.colorLabelPhi;
colorGrid = p.Results.colorGrid;
LineWidth = p.Results.LineWidth;
FontSize = p.Results.FontSize;

%% Radial axis text

phi=[0:359]*pi/180;
z=zMax*ones(size(phi));
    
[~,indexAngleLabelR]=min(abs(phi-angleLabelR*pi/180));

dr=mean(diff(rAxis));
    
for k=1:length(rAxis);
    r=rAxis(k)*ones(size(phi));
    [x,y,z]=pol2cart(phi,r,z);
    plot3(x,y,z,'Color',colorGrid,'LineWidth',LineWidth);

    r_text=(rAxis(k)+dr*0.2)*ones(size(phi));
    [x_text,y_text,z_text]=pol2cart(phi,r_text,z);

	textString=[num2str(r(1))];
    ht=text(x_text(indexAngleLabelR),y_text(indexAngleLabelR),z(1),textString,'Color',colorLabelR,'LineWidth',1.5,'HorizontalAlignment','center','FontSize',FontSize);
    uistack(ht, 'top');
end

r_text=(rAxis(k)+dr*0.75)*ones(size(phi));
[x_text,y_text,z]=pol2cart(phi,r_text,z);

ht=text(x_text(indexAngleLabelR),y_text(indexAngleLabelR),z(1),unitLabelR,'Color',colorLabelR,'LineWidth',1.5,'FontSize',FontSize);
% uistack(ht, 'top')

%% Phi axis text


for k=1:length(phiAxis);
    
    r=[-rMax rMax];
    phi=phiAxis(k)*pi/180*ones(size(r));
    z=zMax*ones(size(phi));
    [x,y,z]=pol2cart(phi,r,z);
    plot3(x,y,z,'Color',colorGrid,'LineWidth',LineWidth);
    
	[xt,yt,z]=pol2cart(phi,r.*[1.125],z);
    ht1=text(xt(1),yt(1),z(1),[num2str(phi(1)*180/pi+180) '°'],'Color',colorLabelPhi,'LineWidth',1.5,'HorizontalAlignment','center','FontSize',FontSize);
    ht2=text(xt(2),yt(2),z(2),[num2str(phi(2)*180/pi) '°'],'Color',colorLabelPhi,'LineWidth',1.5,'HorizontalAlignment','center','FontSize',FontSize);
	uistack(ht1, 'top');
    uistack(ht2, 'top');

end

%% Fix axes appearance

axistight(gca,[0.175 0.175 0.05],'x','y','z');

h = get(gca,'DataAspectRatio');
if h(3)==1
      set(gca,'DataAspectRatio',[1 1 1/max(h(1:2))]);
else
      set(gca,'DataAspectRatio',[1 1 h(3)]);
end

set(gca, 'XTick', []);
set(gca, 'YTick', []);
set(gca,'box','off');
set(gca,'XColor',get(gca,'Color'));
set(gca,'YColor',get(gca,'Color'));

%%

hChildren=get(gca,'Children');

for k=1:length(hChildren)
    if strcmpi(hChildren(k).Type,'text');
	uistack(hChildren(k), 'top');
    end

end