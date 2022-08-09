function isXaxis=checkxaxis(a)

%% Check if argument in is a time axis
%
% Inputs:
% a: vector with x-axis, e.g. time vector
%
% Outputs:
% isXaxis: true/false
%
%%

isXaxis=true;

if ~isnumeric(a)
	isXaxis=false;
    return
end

if ~isa(a,'double')
    a=double(a);
end

if sum(size(a)>1)>1
	isXaxis=false;
    return
end

if any(diff(a)<=0)
    isXaxis=false;
    return
end

if sum(isnan(a))>1
	isXaxis=false;
    return
end

if any(any(any(imag(a))))
	isXaxis=false;
    return
end

if ~isnumeric(a)
	isXaxis=false;
    return
end

    
% n_window=min(100,length(a));
% n_check=10;
% 
% indCheck=floor(linspace(0,max(n_window,length(a)-n_window),n_check+1));
% indCheck=indCheck(1:end-1);

% indRemove=(indCheck+n_check)>length(a);
% indCheck(indRemove)=[];

% for k=1:length(indCheck)
    
%     indexRangeCheck=indCheck(k)+[1:n_window];
    

    
%     if max(indexRangeCheck)>length(a)
%     break; return
%     end        
    
%     ratio=std(diff(a(indexRangeCheck)))./median(diff(a(indexRangeCheck)));
% 	if ratio>1e-6
% % 	isXaxis=false;
% %     break; return
%     end
%     
% end
    
% end

