function isxaxis=checkxaxis(a)
%% Check if argument in is a vectorized axis, e.g. time or frequency
% It is assumed elements of the vector is in increasing order
%
% Inputs:
% a: vector with x-axis, e.g. time vector
%
% Outputs:
% isxaxis: true/false
%
%%

isxaxis=true;

if ~isnumeric(a)
	isxaxis=false;
    return
end

if sum(size(a)>1)>1
	isxaxis=false;
    return
end

if size(a,3)>1
	isxaxis=false;
    return
end

if ~isa(a,'double')
    a=double(a);
end

if sum(isnan(a))>1
	isxaxis=false;
    return
end

if any(any(any(imag(a))))
	isxaxis=false;
    return
end

n=length(a);

n_div=min(100,n);
ind_check=ceil(linspace(1,n,n_div));

if any(diff(a(ind_check))<=0)
	isxaxis=false;
    return
end    
