function scattercursor(hfig,sync,cell_string)

%% Add cursor with information
%
% Inputs:
% hfig: handle to figure
% sync: true/false, sync movement between all axes
% cell_string: cell with information strings (in same order as x-data in figures)
%
% Outputs:
%
%% 

figure(hfig);

if nargin==1
    sync=false;
    cell_string=[];
elseif nargin==2
    cell_string=[];
end

if sync
    hax=getsortedaxes(gcf);

    for k=1:length(hax)
        hax_k=get(hax(k));
        
        if length(hax_k.Children)>1
            for j=1:length(hax_k.Children)
                    childType=get(hax_k.Children(j),'Type');
                    if strcmpi(childType,'Scatter')
                    childScatter=hax_k.Children(j); break %choose first
                    end
            end
        else
            childScatter=hax_k.Children;
        end
                
        if isempty(childScatter); continue; end

        data_x_all(k,:)=childScatter.XData(1,:);
        data_y_all(k,:)=childScatter.YData(1,:);
    end
else
	hax=[];
    data_x_all=[];
    data_y_all=[];
end

dcm=datacursormode(gcf);
set(dcm,'Interpreter','none');

datacursormode on
set(dcm,'updatefcn',{@infoCursor hax sync cell_string data_x_all data_y_all});


end
%%

function [output_txt] = infoCursor(obj,event_obj,hax,sync,cell_string,data_x_all,data_y_all)
% Display the position of the data cursor
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text string (string or cell array of strings).
% clc

% get(event_obj.Target.Parent)
data_x=event_obj.Target.XData(1,:);
data_y=event_obj.Target.YData(1,:);

pos = get(event_obj,'Position');

x=pos(1);
y=pos(2);

err_x=data_x-x;
err_y=data_y-y;

[~,indMin]=min(abs(err_x./max(abs(err_x)))+abs(err_y./max(abs(err_y))));

output_txt= {...    
    ['x = ' num2str(data_x(indMin),'%.3e')],...
    ['y = ' num2str(data_y(indMin),'%.3e')],...
    ['index = ' num2str(indMin,'%0.0f')],...
    };


if ~isempty(cell_string)
    output_txt{end+1}=cell_string{indMin};
end

if sync
    
    hax_current=event_obj.Target.Parent;
    
    for k=1:length(hax)
        
%         axes(hax(k));
        hLine=findobj(hax(k),'Type','Line');
        
        for j=1:length(hLine)
            if strcmpi(hLine(j).Tag,'extra')
                delete(hLine(j));
            end
        end
        
        clear hLine;
        
%         if hax(k)==hax_current; MarkerEdgeColor=[0 1 1]; MarkerSize=10; else; MarkerEdgeColor=[0.5 0.5 1]; MarkerSize=10; end
        if hax(k)==hax_current; MarkerEdgeColor=[0 1 1]; MarkerSize=10; else; MarkerEdgeColor=[1 0.5 0]; MarkerSize=10; end
%         axes(hax(k));
        hLine(k)=plot(data_x_all(k,indMin),data_y_all(k,indMin),'o','MarkerSize',MarkerSize,'MarkerEdgeColor',MarkerEdgeColor,'LineWidth',2,'Parent',hax(k));
        hLine(k).Tag='extra';
        
    end
    %    delete(hLine)
    
end

end

