function [x,y,nSignals,nSources]=separatexy(data_cell,plotdim)

%%

% xLabels='';

%%

one_x_axis=false;

if length(data_cell)==1 % One input only, no x-axis provided
    one_x_axis=NaN;
elseif any(length(data_cell)==[3:2:21]) % Odd means that one x-axis is present
    one_x_axis=true;
else
    
    is_x_axis=[];
    for k=1:length(data_cell)
        
        is_x_axis(k)=true;     
        
        % Matrix dimension larger than 1?
        if min(size(data_cell{k}))>1; is_x_axis(k)=false; continue; end
        
        if checkxaxis(data_cell{k})==false; is_x_axis(k)=false; continue; end
            
    end
    
    if sum(is_x_axis)>1 % Multiple x-axis
        one_x_axis=false;
    elseif sum(is_x_axis)==1 % One x-axis
        one_x_axis=true; % No x-axis
	elseif sum(is_x_axis)==0
        warning('No x-axis detected');
        one_x_axis=NaN;
    end
    
end

if one_x_axis==true
    
    nSources=length(data_cell)-1;
    x=repcell(data_cell{1},1,nSources);
    
    for k=1:nSources
        y{k}=data_cell{k+1};
    end
    
elseif one_x_axis==false
    
    nSources=length(data_cell)/2;
    
    for k=1:nSources
        x{k}=data_cell{2*k-1};
        y{k}=data_cell{2*k};
    end
        
elseif isnan(one_x_axis)
    
    nSources=length(data_cell);

    for k=1:nSources
        x{k}=[1:length(data_cell{k})];
        y{k}=data_cell{k};
    end
    
% 	xLabels='Datapoints [n]';

end

nSignals=size(y{1},1);

for k=1:nSources
    if size(y{k},1)~=nSignals
        nSignals
        size(y{k})
        error(['Size wrong: number of sources not the same' ', k=' num2str(k)]);
    end
end

for k=1:nSources
    if size(y{k},plotdim)~=length(x{k})
        size(x{k})
        size(y{k})
        error(['Size wrong: x-axis length not same size as y-data' ', k=' num2str(k)]);
    end
end

