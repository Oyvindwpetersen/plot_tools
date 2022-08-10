function range_cell=rangebin(n,d)

%% Divide a range [1,2,3,4,5,...] into bins with d elements each
% Last bin could have less than d elements if n and d dont devide
%
% Inputs:
% n: range length
% d: (max) length of each bin
%
% Outputs:
% range_cell: cell with range as each element
%
%%
if n<=d
    range_cell{1}=1:n;
    return
end

nbins=ceil(n/d);

for k=1:nbins-1
    range_cell{1,k}=[1:d]+(k-1)*d;
end

if range_cell{1,k}(end)<n
    range_cell{1,nbins}=range_cell{1,k}(end)+1:n;
end