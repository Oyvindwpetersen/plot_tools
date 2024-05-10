function [x,y,nSignals,nSources]=separatexy(data_cell)
%% Separate x and y data for plotting
% 
% Inputs:
% data_cell: cell on the form {x,y1,y2,y3,...} (shared x-axis) or {x1,y1,x2,y2,x3,y3,...} (individual x-axis) 
%
% Outputs:
% x: cell on the form {x1,x2,x3,...} 
% y: cell on the form {y1,y2,y3,...} 
% nSignals: number of signals (size of y1)
% nSources: number of sources (length of y)
%
%%

one_x_axis=false;

if length(data_cell)==1 % One input only, no x-axis provided
    one_x_axis=NaN;
elseif any(length(data_cell)==[3:2:21]) % Odd number of input means that one x-axis is present
    one_x_axis=true;
    
    if ~isvector(data_cell{1})
        size(data_cell{1})
        error('x-axis must be a vector');
    end

    size_ref=size(data_cell{2});
    for k=2:length(data_cell)
    
        size_check=size(data_cell{k});
        if any(size_ref~=size_check)
            k
            size_ref
            size_check
            error('Size of y data not consistent');
        end
    end
    
else
    
    is_x_axis=[];
    for k=1:length(data_cell)
        
        % Assume true
        is_x_axis(k)=true;     
        
        if checkxaxis(data_cell{k})==false; is_x_axis(k)=false; continue; end
            
    end
        
    if sum(is_x_axis)>1 % Multiple x-axis
        
        if all(is_x_axis(1:2:end)==1) & all(is_x_axis(2:2:end)==0) % Must be x1,y1,x2,y2,...
            one_x_axis=false;
        else
            one_x_axis=true;
        end
        
    elseif sum(is_x_axis)==1 % One x-axis
        one_x_axis=true; 
	elseif sum(is_x_axis)==0 % No x-axis
        warning('No x-axis detected');
        one_x_axis=NaN;
    end
    
end

%% Create cell with x and y

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
    
end

nSignals=size(y{1},1);

for k=1:nSources
    
    size_y_rows(k)=size(y{k},1);
    
    if size_y_rows(k)~=nSignals
        nSignals
        size_y_rows
        error(['Size wrong: number of sources not the same' ', k=' num2str(k)]);
    end
    
end

for k=1:nSources
    
    if size(y{k},3)>1
        dim=3;
    else
        dim=2;
    end
    
    if size(y{k},dim)~=length(x{k})
        size_x=size(x{k})
        size_y=size(y{k})
        error(['Size wrong: x-axis length not same size as y-data' ', k=' num2str(k)]);
    end
    
end

