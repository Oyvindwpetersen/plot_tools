function [figno_new,figno_taken]=availablefigno(figno_desired,fig_increment,n_required)

%% Find available figure number to avoid collision
%
% Inputs:
% figno_desired: desired figure (base) number
% fig_increment: increment to add when figure is taken
% n_required: required number of figures
%
% Outputs:
% figno_new: available figure (base) number
%
%% Default inputs

if nargin<3
	n_required=1;
end

if nargin<2
	fig_increment=100;
end

if nargin<1
	figno_desired=1;
end

%%

% If no figures open, return
figHandles=findobj('Type', 'figure');
if isempty(figHandles)
    figno_new=figno_desired; figno_taken=[];
    return
end

% Find taken figures
for k=1:length(figHandles)
	figno_taken(k)=figHandles(k).Number;
end

% Range 
figno_test=figno_desired+[1:n_required]-1;

% Loop until range is available
figno_istaken=true;
while figno_istaken

	do_add=false;
	for k=1:length(figno_test)
		if any(figno_test(k)==figno_taken)
			do_add=true;
		end
	end

	if do_add
		figno_test=figno_test+fig_increment;
	else
		figno_new=figno_test(1);
		figno_istaken=false;
	end
	
end