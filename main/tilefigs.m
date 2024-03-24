function tilefigs(tile,left_or_right,figno,gap,border_h,border_w)

%% axistight tiles figures nicely
%
% Examples:
% tilefigs()
% tilefigs([3 2],'left')
% tilefigs([3 2],'left',[1:6],)
%
% Inputs:
% tile: tile layout in [rows columns]. If empty or omitted, then a square layout is enforced.
% left_or_right: 'left' or 'right'.  If empty or omitted, then a whole screen is used.
% figno: figure number to file.  If empty or omitted, then all figures are tiled.
% gap: [gap_h gap_w] in pixels
% border_h: [border_h_bottom border_h_top] in pixels
% border_w: [border_w_left border_w_right] in pixels
%
% Outputs: none
%
% Based on the script by (Charles Plum)
% Modified by OWP
%
%% Input check

drawnow();

if nargin<1
    tile=[];
end

if nargin<2
    left_or_right='';
end

if nargin<3
    figno=[];
end

if nargin<4
    gap=[100 50];
end

if nargin<5
    border_h=[100 150];
end

if nargin<6
    border_w=[100 100];
end

if length(tile)==1
    tile=tile*[1 1];
end

if length(gap)==1
    gap=gap*[1 1];
end

if length(border_h)==1
    border_h=border_h*[1 1];
end

if length(border_w)==1
    border_w=border_w*[1 1];
end

gap_h=gap(1);
gap_w=gap(2);

%% Find tile layout

% Determine terminal size in pixels
maxpos=get(0,'screensize'); maxpos=maxpos(3:4);

offset_w=0;
offset_h=0;
if strcmpi(left_or_right,'left') | strcmpi(left_or_right,'l')
    maxpos(1)=maxpos(1)/2; offset_w=0; 
elseif strcmpi(left_or_right,'right') | strcmpi(left_or_right,'r')
    maxpos(1)=maxpos(1)/2; offset_w=maxpos(1);
elseif strcmpi(left_or_right,'lu')
    maxpos(1)=maxpos(1)/2; offset_w=0;
    maxpos(2)=maxpos(2)/2; offset_h= maxpos(2);
end

% maxpos(2)=maxpos(2) - 25;

% Get all figures
hfigall=get(0,'Children');

% If no figs open, return
if isempty(hfigall)
    return
end

% Find figure number of all figures open
for k=1:length(hfigall)
    fignoall(k)=hfigall(k).Number;
end

% Sort by figure numbers
[fignoall_sort,i_sort]=sort(fignoall);
hfigall=hfigall(i_sort);          % sort figure handles

% Select only some figures if desired
if ~isempty(figno)
    for k=1:length(figno)
        [~,ind(k)]=find(fignoall_sort==figno(k));
    end
    hfigall=hfigall(ind);
end

numfigs=size(hfigall,1);  % number of open figures
maxfigs=100;
if (numfigs>100) % figure limit check
    disp([' More than ' num2str(maxfigs) ' figures ... get serious pal'])
    return
end

if isempty(tile)
    tile=ceil(sqrt(numfigs))*[1 1];
    if (tile(1)*(tile(2)-1))>numfigs; tile(2)=tile(2)-1; end  
end

nrows=tile(1);
ncols=tile(2);
if numfigs > nrows*ncols
    disp ([' Requested tile size too small for ' num2str(numfigs) ' open figures '])
    
    tile(1)=tile(1)+1;
    disp ([' Increasing rows']);
    tilefigs(tile,left_or_right,figno,gap,border_h,border_w);
    return
end

%% Relocate figures

% hfigall=get(0,'Children');

length_h=(maxpos(2)-sum(border_h)-(nrows-1)*gap_h)/nrows;
length_w=(maxpos(1)-sum(border_w)-(ncols-1)*gap_w)/ncols;

pnum=0;

for iy=1:nrows
    ypos=maxpos(2)-iy*length_h-border_h(2)-(iy-1)*gap_h+offset_h;    
    for ix=1:ncols
        xpos=offset_w+border_w(1)+(ix-1)*length_w+(ix-1)*gap_w;      
        pnum=pnum+1;
        if (pnum>numfigs)
            break
        else
            % set(0,'CurrentFigure',hfigall(pnum));
            % set(hfigall(pnum),'WindowState','maximized');
            set(hfigall(pnum),'WindowState','normal');

            set(hfigall(pnum),'Units','pixels');
            set(hfigall(pnum),'Position',[ xpos ypos length_w length_h ]);
            figure(hfigall(pnum));
            % set(0,'CurrentFigure',hfigall(pnum));
        end
    end
end
