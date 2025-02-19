function squares(A,varargin)

%% 3D bar chart
%
% Inputs:
% A: matrix to plot as bars
%
% Outputs: none
% 
%% Default inputs

p=inputParser;
% p.KeepUnmatched=true;

addParameter(p,'YTickLabel','',@iscell)
addParameter(p,'XTickLabel','',@iscell)
addParameter(p,'xlabel','',@ischar) %Column
addParameter(p,'ylabel','',@ischar) %Row
addParameter(p,'fontsize',6,@isnumeric)
addParameter(p,'log',false,@islogical)
addParameter(p,'view',[0 90],@isnumeric)
addParameter(p,'colorbar',true,@islogical)
addParameter(p,'colormap','GnBu',@ischar)
addParameter(p,'clim',[],@isnumeric)
addParameter(p,'cbarh',[0.75],@isnumeric)
addParameter(p,'text',false,@islogical)
addParameter(p,'hax',[])
addParameter(p,'reversey',true,@islogical)

parse(p,varargin{:})

XTickLabel=p.Results.XTickLabel;
YTickLabel=p.Results.YTickLabel;
xl=p.Results.xlabel;
yl=p.Results.ylabel;
fontsize=p.Results.fontsize;
logaxis=p.Results.log;
view_angle=p.Results.view;
colorbar_logic=p.Results.colorbar;
colormap_scheme=p.Results.colormap;
clim=p.Results.clim;
cbarh=p.Results.cbarh;
text=p.Results.text;
hax=p.Results.hax;
reversey=p.Results.reversey;

%%

[n1,n2]=size(A);

if isempty(YTickLabel)
	YTickLabel=strseq('y',[1:n1])';
end

if isempty(XTickLabel)
	XTickLabel=strseq('x',[1:n2])';
end

%%

if isempty(hax)
    figure();
    hax=tight_subplot(1,1,[],[0.1 0.05],[0.0 0.05]);
    sizefig('m')
else
    axes(hax);
end

hold on; grid on;

hs=[];
hc=[];

delta=0.1;

%% Old code

% if 0
% 
%     % Loop over each element of A
%     for row = 1:n1
%         for col = 1:n2
% 
%             % Coordinates of the corners of the square in the (x,y) plane.
%             xcoord = [col-1+delta, col-delta,   col-delta,   col-1+delta]+0.5;
%             ycoord = [row-1+delta, row-1+delta, row-delta,   row-delta  ]+0.5;
% 
%             % Z is constant (the value of A) for all four corners
%             zval = A(row, col);
%             zcoord = zval * ones(1, 4);
% 
%             if isnan(zval)
%                 continue;
%             end
% 
%             % Create the patch for this matrix element
%             patch('XData', xcoord, ...
%                   'YData', ycoord, ...
%                   'ZData', zcoord, ...
%                   'FaceColor', 'flat', ...   % color each patch by its CData
%                   'CData',     zval, ...   % drives the color
%                   'EdgeColor', 'k');         % black edges
%         end
%     end
% 
% end


%% New code, avoids loop

% Generate all (row, col) pairs
[rowIdx, colIdx] = ndgrid(1:n1, 1:n2);

% Flatten into vectors
rowVec = rowIdx(:);
colVec = colIdx(:);
valVec = A(:);

% Exclude NaN values
validMask = ~isnan(valVec);
rowVec = rowVec(validMask);
colVec = colVec(validMask);
valVec = valVec(validMask);

% Number of valid squares
N = numel(valVec);

% X-coordinates of corners for each square => (N x 4)
xAll = [colVec - 1 + delta, colVec - delta, colVec - delta, colVec - 1 + delta] + 0.5;

% Y-coordinates of corners for each square => (N x 4)
yAll = [rowVec - 1 + delta, rowVec - 1 + delta, rowVec - delta, rowVec - delta] + 0.5;

% Z-coordinates (height) => (N x 4). All corners share the same Z for each cell
zAll = repmat(valVec, 1, 4);

X = xAll'; % size -> 4 x N, then flatten -> 4*N x 1
Y = yAll';
Z = zAll';

vertices = [X(:), Y(:), Z(:)];  % (4*N) x 3

% Define faces. Each square is a "face" referencing 4 consecutive vertices.
% The i-th face corresponds to vertex indices [4(i-1)+1 .. 4(i-1)+4].
faces = reshape(1:4*N, 4, N)';
% faces is N x 4, so faces(i,:) = [v1, v2, v3, v4] for the i-th square

% Plot once using 'patch' with the 'Faces' and 'Vertices' syntax.
%  We use 'FaceVertexCData' = valVec to color each face by A(row,col).
% 'FaceColor' = 'flat' means each face has a single color (per-face data).
hPatch = patch('Faces', faces, ...
                   'Vertices', vertices, ...
                   'FaceVertexCData', valVec, ...
                   'FaceColor', 'flat', ...
                   'EdgeColor', 'k'); 
axis equal

%%

set(gca,'XTick',[1:n2]);
set(gca,'YTick',[1:n1]);

set(gca,'XTickLabel',XTickLabel,'fontsize',fontsize)
set(gca,'YTickLabel',YTickLabel,'fontsize',fontsize)
set(gca,'TickLabelInterpreter','latex');

ylabel(yl);
xlabel(xl);

xlim([1 n2]+[-0.6 0.6]);
ylim([1 n1]+[-0.6 0.6]);

axistight(gca,[0.05 0.05 0.05],'keepx','keepy','z');

s=get(gca,'DataAspectRatio');
% s_new=[ 1 1 1/(s(3)*mean(s(1:2)))];
s_new=[ 1 1 1];
set(gca,'DataAspectRatio',s_new);

view(view_angle);

if logaxis
    set(gca,'ZScale','log');
    axistight(gca,[0 0 0.05],'keepx','keepy','zlog');
end

% Turn on colorbar
if colorbar_logic
    
    % Set color scheme
    [map,num,typ] = brewermap(100,colormap_scheme); colormap(map);
    
    % Adjust min/max limits
    if ~isempty(clim)
        caxis([clim]);
    end

    colorbar;
end

if reversey
    set(gca, 'YDir','reverse');
end

colorbarpos2(gca,[],cbarh);

dcm=datacursormode(gcf);
datacursormode on

set(dcm,'updatefcn',{@infoCursor A });

end

%% Text function 
function [output_txt]=infoCursor(~,event_obj,zdata)
% Display the position of the data cursor
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text string (string or cell array of strings).

pos=get(event_obj,'Position');
xsel=round( pos(1) );
ysel=round( pos(2) );

% zdata(xsel,ysel)

output_txt={...    
    ['x=' num2str(xsel,'%d')],...
    ['y=' num2str(ysel,'%d')],...
    ['z=' num2str(zdata(ysel,xsel),'%.3e')],...
    };

% h_scatter3=findobj(gca,'Type','hggroup');
h_scatter3=findobj(gca,'Type','Scatter');

if ~isempty(h_scatter3);
    delete(h_scatter3);
end

hold on;
z1=zdata(ysel,xsel);
htop=scatter3(xsel,ysel,z1,60,'d',...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[1 0 0]);
hold off;
end