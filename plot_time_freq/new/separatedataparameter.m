function [data_cell,parameter_cell,ind_data]=separatedataparameter(varargin)

%%

ind_data=nargin;
for k=1:nargin
    if ischar(varargin{k}) | isstruct(varargin{k})
        ind_data=k-1; break;
	end
end

data_cell=varargin(1:ind_data);
parameter_cell=varargin(ind_data+1:end);

