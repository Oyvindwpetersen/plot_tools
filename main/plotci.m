function h_shade=plotci(x_pred,f_pred,SD_f_pred,n_scale,varargin)

%% Plot confidence interval
%
% Inputs:
% x_pred:  vector with input locations for prediction
% SD_f_pred: vector with standard deviation for prediction
% n_scale: scaling of standard deviation, usually 1
% Color: color of shade
%
% Outputs:
% h_shade: handle to plotted object
%
%
%%

p=inputParser;
addParameter(p,'Color',[0.5 0.5 0.5],@isnumeric)
addParameter(p,'Alpha',0.5,@isnumeric)
addParameter(p,'LineStyle','none');
addParameter(p,'DisplayName','Confidende interval',@ischar)
addParameter(p,'hideanno',true)
addParameter(p,'decimation',[])

parse(p,varargin{:});

Color=p.Results.Color;
Alpha=p.Results.Alpha;
LineStyle=p.Results.LineStyle;
DisplayName=p.Results.DisplayName;
hideannotation=p.Results.hideanno;
decimation=p.Results.decimation;

%%

if min(size(x_pred))==1 & min(size(f_pred))==1 & min(size(SD_f_pred))==1
    
    if size(x_pred,1)>size(x_pred,2); x_pred=x_pred.'; end
    if size(f_pred,1)>size(f_pred,2); f_pred=f_pred.'; end
    if size(SD_f_pred,1)>size(SD_f_pred,2); SD_f_pred=SD_f_pred.'; end

end

% figure(); sizefig;
% hold on; grid on;
% plot(x,y);
% sd_y=0.1*ones(size(y));

if ~isempty(decimation)
    x_pred=x_pred(:,1:decimation:end);
    f_pred=f_pred(:,1:decimation:end);
    SD_f_pred=SD_f_pred(:,1:decimation:end);
end
    
x1=[x_pred flip(x_pred)];
y1=[f_pred-SD_f_pred*n_scale flip(f_pred+SD_f_pred*n_scale)];

h_shade=patch(x1,y1,Color,'FaceAlpha',Alpha,'LineStyle',LineStyle,'DisplayName',DisplayName);

% toc

uistack(h_shade,'bottom');

if hideannotation==true
    hideanno(h_shade);
end
% h_shade=shade(x_pred,n_scale*SD_f_pred+f_pred,x_pred,-n_scale*SD_f_pred+f_pred,'FillType',[1 2;2 1],'FillColor',FillColor,'FillAlpha',FillAlpha,'LineStyle',LineStyle);
% % 'Color',Color,'DisplayName',['\pm ' num2str(n_scale) '\sigma CI']);
% 
% set(get(get(h_shade(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% set(get(get(h_shade(2),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% set(h_shade(3),'DisplayName',DisplayName);
% 
% uistack(h_shade(3),'bottom');