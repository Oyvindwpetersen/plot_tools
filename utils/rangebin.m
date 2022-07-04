function range=rangebin(n,d)

%%

if n<=d
    range{1}=1:n;
    return
end

nbins=ceil(n/d);


for k=1:nbins-1
    range{1,k}=[1:d]+(k-1)*d;
end

if range{1,k}(end)<n
    range{1,nbins}=range{1,k}(end)+1:n;
end