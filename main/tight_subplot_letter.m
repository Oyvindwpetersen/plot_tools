function tight_subplot_letter(ha,fontsize,p_in,prepost)

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

s={'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm'};

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

    % coord_BL_X=p_all(:,1); coord_TL_X=p_all(:,1)+p_all(:,3);
    coord_BL_Y=p_all(:,2); coord_TL_Y=p_all(:,2)+p_all(:,4);

    for k=1:length(ha{j})
        DeltaY_k(k)=min(abs(coord_BL_Y(k)-coord_TL_Y));
    end

    DeltaY=mean(DeltaY_k);

    if DeltaY>0.5; DeltaY=0.1; end

    for k=1:length(ha{j})

        % 	p=get(ha{j}(k),'Position');

        p=p_all(k,:);

        if isempty(p_in)
            p2(1)=p(1)-DeltaY*0.3;
            p2(2)=p(2)-DeltaY*0.4;
            p2(3)=0.05;
            p2(4)=0.05;
        else
            p2(1)=p(1)+p_in(1);
            p2(2)=p(2)+p_in(2);
            p2(3)=0.05;
            p2(4)=0.05;
        end

        p2(p2<0)=0.01;

        a=annotation(gcf,'textbox',...
            p2,...
            'String',s{k},...
            'FitBoxToText','off',...
            'EdgeColor','none',...
            'Color',[0 0 0],...
            'FontSize',fontsize,'FontName','Arial'...
            );
    end
end

%%


%     p2(1)=p(1)-p_in(1);
%     p2(2)=p(2)-p_in(2);
%     p2(3)=p_in(3);
%     p2(4)=p_in(4);
%     else
% 	p2(1)=p(1)-p(3)*0.12*2*0;
% % 	p2(2)=p(2)-p(4)*0.2;
%     p2(2)=p(2)-0.075;
% 	p2(3)=0.05;
% 	p2(4)=0.05;
%     end
