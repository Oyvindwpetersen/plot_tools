function arrow2(coord_start,coord_end,varargin)

%% 2 dim arrow

% coord_start=[x1 y1]
% coord_end=[x2 y2]

% HeadStyles: https://se.mathworks.com/help/matlab/ref/matlab.graphics.shape.arrow-properties.html
% 'vback2' (default) | 'plain' | 'ellipse' | 'vback1' | 'vback3' | 'cback1' | 'cback2' | ...


%% Define parameters

p=inputParser;
addParameter(p,'HeadLength',10);
addParameter(p,'Color',[0 0 0]);
addParameter(p,'HeadStyle','vback2');
addParameter(p,'HeadWidth',10);
addParameter(p,'LineStyle','-');
addParameter(p,'LineWidth',0.5);
addParameter(p,'doublesided',false);
addParameter(p,'stack','bottom');

parse(p,varargin{:})

HeadLength=p.Results.HeadLength;
Color=p.Results.Color;
HeadStyle=p.Results.HeadStyle;
HeadWidth=p.Results.HeadWidth;
LineStyle=p.Results.LineStyle;
LineWidth=p.Results.LineWidth;
doublesided=p.Results.doublesided;
stack=p.Results.stack;

%%


if doublesided==false

    x_start=coord_start(1);
    y_start=coord_start(2);

    delta_x=coord_end(1)-coord_start(1);
    delta_y=coord_end(2)-coord_start(2);

    PositionMatrix = [x_start, y_start, delta_x, delta_y];

end


if doublesided==true
    
    x_start=(coord_start(1)+coord_end(1))/2;
    y_start=(coord_start(2)+coord_end(2))/2;

    delta_x=coord_end(1)-x_start;
    delta_y=coord_end(2)-y_start;

    PositionMatrix(1,:) = [x_start, y_start, delta_x, delta_y];
    PositionMatrix(2,:) = [x_start, y_start, -delta_x, -delta_y];

end

for k=1:size(PositionMatrix,1)
    
    anArrow=annotation('arrow');
    anArrow.Position=PositionMatrix(k,:);
    anArrow.Parent=gca;

    anArrow.HeadLength=HeadLength;
    anArrow.Color=Color;
    anArrow.HeadStyle=HeadStyle;
    anArrow.HeadWidth=HeadWidth;
    anArrow.LineStyle=LineStyle;
    anArrow.LineWidth=LineWidth;
    
    uistack(anArrow,stack);


end
