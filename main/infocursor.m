function infocursor(hfig,dateData,timeData)
%%

figure(hfig);

if nargin==2;
    timeData=[];
end

dcm=datacursormode(gcf);
datacursormode on
set(dcm,'updatefcn',{@infoCursor dateData timeData});


end

%%

function [output_txt] = infoCursor(obj,event_obj,dateData,timeData)
% Display the position of the data cursor
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text string (string or cell array of strings).

pos = get(event_obj,'Position');

x=pos(1);
y=pos(2);

if isnumeric(dateData)
DateString = datestr(dateData(x),'yyyy-mm-dd');
else
DateString=dateData{x};
end

if isempty(timeData)
TimeString='';
elseif isempty(timeData{x})
TimeString='';
else
TimeString=timeData{x};
end

output_txt = {...    
    ['x = ' num2str(x,'%.2e')],...
    ['y = ' num2str(y,'%.2e')],...
    [DateString],...
    [TimeString],...
    };

end

