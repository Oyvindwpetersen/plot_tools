function colorbarpos2(h_handle,b,h)

%% Scale down size of color bar
%
% Inputs:
% h_handle: handle to figure or axes
%
% Outputs:
%
%%

if nargin<1
    h_handle=gcf;
end

if nargin<2
    b=[];
end

if nargin<3
    h=[];
end


hax=gethandle(h_handle);

for k=1:length(hax)
    hc=get(ancestor(hax(k), 'axes'),'Colorbar');

    if isempty(hc); continue; end

    pos=get(hax(k),'Position'); %[x0 y0 Lx Ly];
    units=get(hax(k),'Units');

    % Set to right of figure, upper half 
    if isempty(b)
        Lx_cbar=0.025;
    else
        % Lx= something b
    end

    if isempty(h)
        h=0.5;
    end

    Ly_cbar=[pos(4)*h];
 
    x0=pos(1)+pos(3);
    y0=pos(2)+pos(4)-Ly_cbar;   

    hc.Position=[x0 y0 Lx_cbar Ly_cbar];

end