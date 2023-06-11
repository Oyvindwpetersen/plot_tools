function hax_new=getsortedaxes(h)

%% Get axes handle of figure (sorted row by row)
%
% Inputs:
% h: handle to figure or list of axes handles
%
% Outputs:
% hax_new: axes handles
%
%% If no input then current figure is assumed

if nargin==0
h=gcf;
end

%% Find axes

if strcmp(get(h,'type'),'figure')
	hax0=findall(h,'type','axes');
else
	hax0=h;
end

if isempty(hax0)
    hax_new=[];
end

for k=1:length(hax0)

	if strcmpi(get(hax0(k),'Visible'),'on')
		isVisible(k)=true;
	else
		isVisible(k)=false;
	end
	
	pos=get(hax0(k),'Position');
	pos_x(k)=pos(1);
	pos_y(k)=pos(2);
	dim_x(k)=pos(3);
	dim_y(k)=pos(4);
	
end

[~,ind_sort_y]=sort(pos_y,'descend');
pos_x=pos_x(ind_sort_y);
pos_y=pos_y(ind_sort_y);
hax0=hax0(ind_sort_y);
isVisible=isVisible(ind_sort_y);

%% Sort

hax_new=[];
pos_tol=mean(dim_y)*0.5;
[C,IA,IC] = uniquetol(pos_y,pos_tol);
 
for k=length(C):-1:1
	ind_row=find(IC==k);
	[~,ind_sort_x]=sort(pos_x(ind_row),'ascend');
	hax_new(ind_row)=hax0(ind_row(ind_sort_x));
end
