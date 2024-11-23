function tight_subplot_letter(ha,fontsize,rx,ry,p_in,prepost)

%% Add letter label to axes
%
% Inputs:
% ha: axes handle
% fontsize: size of letters
% p_in: [dx,dy] adjustment
%
% Outputs:
%
%%

if nargin<2
    fontsize=6;
end

if nargin<3
    p_in=[];
end

if nargin<4
    prepost=')';
end

if isfigure(ha)
    ha=getsortedaxes(ha);
end

if ~iscell(ha)
    ha={ha};
end

s={'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q'};

for k=1:length(s)

    if strcmpi(prepost,')')
        s{k}=[s{k} ')'];
    elseif strcmpi(prepost,'()')
        s{k}=['(' s{k} ')'];
    end
end

for j=1:length(ha)

    if length(ha{j})==1
        continue
    end

    clear p_all
    for k=1:length(ha{j})
        p_all(k,:)=get(ha{j}(k),'Position');
    end

    for k=1:length(ha{j})
            
        p=p_all(k,:);

        x0=p(1)+rx(1);
        y0=p(2)+ry(1);

        dim=[x0 y0 rx(2) ry(2) ];

        if any(dim<0)
            dim(dim<0)=0;
            warning('Subplot letter shifted to 0');
        end

        a=annotation('textbox',...
            dim,...
            'String',s{k},...
            'FitBoxToText','off',...
            'EdgeColor','none',...
            'Color',[0 0 0],...
            'FontSize',fontsize,'FontName','Arial'...
            );
    end
end

