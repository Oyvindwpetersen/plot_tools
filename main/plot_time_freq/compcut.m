function [x,y,nSignals]=compcut(x,y,comp,cut)
%% Trim data
%
% Inputs:
% x: cell with x-data
% y: cell with 2d or 3d y-data
% comp: components to keep, e.g. [1:3] for same for dim1 and dim2 or {[1:3] [4:6]} specified for dim1 and dim2
% cut: numbers of elements to cut at start/end
%
% Outputs:
% x: cell with x-data (trimmed)
% y: cell with 2d or 3d y-data (trimmed)
% nSignals: number of signals
%
%%

if iscell(comp)
    comp1=comp{1};
    comp2=comp{2};
else
    comp1=comp;
    comp2=comp;
end

% Truncate to desired components
if ~isempty(comp)

    for k=1:length(y)
        
        if size(y{k},3)>1
            y{k}=y{k}(comp1,comp2,:);
        else
            y{k}=y{k}(comp1,:);
        end

    end
    
end

nSignals=size(y{1},1);

% Cut to desired components
if ~isempty(cut)
    
    if length(cut)==1; cut=[cut cut]; end
    
    for k=1:length(x)
        
        range=[(1+cut(1)):(length(x{k})-cut(2))];

        x{k}=x{k}(range);
        
        if size(y{k},3)>1
            y{k}=y{k}(:,:,range);
        else
            y{k}=y{k}(:,range);
        end
        
    end
    
end

