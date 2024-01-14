function vcursor(fig_no)

%% Add vertical cursor
%
% Inputs:
% fig_no: figure handle
%
% Outputs: none
%
%% 

h_figs_all=findall(0,'Type','figure');

if nargin==0 | isempty(fig_no)
    h_figs=h_figs_all;
else
    h_figs=[];
    for k=1:length(fig_no)
        
        if ~any([h_figs_all.Number].'==fig_no(k)); continue; end
        
        h_figs(end+1)=figure(fig_no(k));
        
    end
end

for k=1:length(h_figs)
dcm=datacursormode(h_figs(k));
set(dcm,'Enable','off');
end


%%
% Set up cursor text

allAxes=[];
for k=1:length(h_figs)
% 	if ~isempty(get(h_figs(k),'WindowButtonDownFcn'));
%     allAxes_k{k}=[];
%     else
        allAxes_k{k} = findobj(h_figs(k), 'Type', 'axes');
    
        indRemove=[];
        % check is axes is legendsmall
        for j=1:length(allAxes_k{k})
        hChildren=allAxes_k{k}(j); m=1;
        check1=isempty(hChildren(m).XLabel.String); check2=isempty(hChildren(m).YLabel.String);
        check3=isempty(hChildren(m).XTick); check4=isempty(hChildren(m).YTick);
        if all([check1 check2 check3 check4])      
                indRemove=[indRemove j];
        end
        end
        allAxes_k{k}(indRemove)=[];
        
        allAxes=[allAxes ; allAxes_k{k}];
end


allLines=[];
for k=1:length(h_figs)
	for j=1:length(allAxes_k{k})
        allLines_k = findobj(allAxes_k{k}(j), 'type', 'line');
        if isempty(allLines_k); continue; end
        allLines=[allLines ; allLines_k(end)]; %choose only last one
    end
end

hText = nan(1, length(allLines));
for id = 1:length(allLines)
   hText(id) = text(NaN, NaN, '', ...
      'Parent', get(allLines(id), 'Parent'), ...
      'BackgroundColor', 'yellow', ...
      'Color', get(allLines(id), 'Color'),'VerticalAlignment','bottom');
end


% Set up cursor lines

linkaxes(allAxes,'x');

for k=1:length(allAxes)
    yLimMax(k,:)=get(allAxes(k),'ylim');
end


for k=1:length(h_figs)
set(h_figs(k), ...
   'WindowButtonDownFcn', @clickFcn, ...
   'WindowButtonUpFcn', @unclickFcn);
end

hCur = nan(1, length(allAxes));
for id = 1:length(allAxes)
   hCur(id) = line([NaN NaN], ylim(allAxes(id)), ...
      'Color', 'black', 'Parent', allAxes(id),'HandleVisibility','off');
end
     function clickFcn(varargin)
        % Initiate cursor if clicked anywhere but the figure
        if strcmpi(get(gco, 'type'), 'figure')
           set(hCur, 'XData', [NaN NaN]);                % <-- EDIT
           set(hText, 'Position', [NaN NaN]);            % <-- EDIT
        else
           set(gcf, 'WindowButtonMotionFcn', @dragFcn)
           

           dragFcn()
%            end
        end
     end
     function dragFcn(varargin)
%                  disp(['test' num2str(randn())]);

           h_zoom=zoom(gca); zoomOnLogic=strcmpi(get(h_zoom,'Enable'),'on');
           if zoomOnLogic
               return
           end
                 
        % Get mouse location
        pt = get(gca, 'CurrentPoint');
        % Update cursor line position
        set(hCur, 'XData', [pt(1), pt(1)]);
        % Update cursor text
        
        for idx=1:length(allAxes)
            yLim=get(allAxes(idx),'ylim'); y2(idx)=yLim(2);
        end
        
        for idx = 1:length(allLines)
           xdata = get(allLines(idx), 'XData');
           ydata = get(allLines(idx), 'YData');
           if pt(1) >= xdata(1) && pt(1) <= xdata(end)
              y = interp1(xdata, ydata, pt(1));
              set(hText(idx), 'Position', [pt(1), y2(idx)], ...
                 'String', sprintf('(%0.2f, %0.2f)', pt(1), y));
           else
              set(hText(idx), 'Position', [NaN NaN]);
           end
        end
     end
     function unclickFcn(varargin)
        set(gcf, 'WindowButtonMotionFcn', '');
%         disp('test')
     end
end