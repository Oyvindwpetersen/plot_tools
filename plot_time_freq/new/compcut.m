function [x,y,nSignals]=compcut(x,y,comp,cut,plotdim)

%%

% Truncate to desired components
if ~isempty(comp)

    for k=1:length(y)
        if plotdim==2
                y{k}=y{k}(comp,:);
        elseif plotdim==3
                y{k}=y{k}(comp,comp,:);
        end
    end
end

nSignals=size(y{1},1);

% Cut to desired components
if ~isempty(cut)
    
    if length(cut)==1; cut=[cut cut]; end
    range=[(1+cut(1)):(t{1}-cut(2))];
    
    for k=1:length(x)
        x{k}=x{k}(range);
        
        if plotdim==2
            y{k}=y{k}(:,range);
        elseif plotdim==3
            y{k}=y{k}(:,:,range);
        end
        
    end
    
end

