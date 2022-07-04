function plotsub(h_handle,gap,marg_h,marg_w)

%% Plot subfigure into new bigger figure
%
% Inputs:
% h_handle: handle to axes
% gap: not used
% marg_h: margin in vertical
% marg_h: margin in horizontal
%
% Outputs:
%
%% 

if nargin<4
    marg_w=0.1;
end

if nargin<3
    marg_h=0.1;
end

if nargin<2
    gap=0.1;
end

if nargin==0
    ha=gca;
elseif isempty(h_handle)
    ha=gca;
else
    ha=h_handle;
end

%%

hfig_new=figure(); sizefig('m');

ha_new=tight_subplot(1,1,gap,marg_h,marg_w);
copyaxescontent(ha,ha_new,false,false);


% sizefig('m');
% end


