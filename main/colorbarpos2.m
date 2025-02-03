function colorbarpos2(h_handle)

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

hax=gethandle(h_handle);

for k=1:length(hax)
    hc=get(ancestor(hax(k), 'axes'),'Colorbar');

    if isempty(hc); continue; end

    pos=get(hax(k),'Position'); %[x0 y0 Lx Ly];
    units=get(hax(k),'Units');

    % Set to right of figure, upper half 
    
    x0=pos(1)+pos(3);
    y0=pos(2)+pos(4)/2;

    Lx=0.025;
    Ly=[pos(4)/2];

    hc.Position=[x0 y0 Lx Ly];

end