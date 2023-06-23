function plotSVD(A,normalize)

%%

if nargin==1
    normalize=true;
end

if ~iscell(A);
    A={A};
end

n=length(A);

for k=1:n
    
    if issparse(A{k})
    [u{k},s{k},v{k}]=svds(A{k},max(size(A{k})));
    else
    [u{k},s{k},v{k}]=svd(A{k});        
    end
    sigma{k}=diag(s{k});
end

figure(); hold on; grid on;

MarkerColorMatrix={'ob' 'dr' 'sk' 'xm'};

if normalize
    for k=1:n
    sigma{k}=sigma{k}./max(sigma{k});
    end
end

for k=1:n
    plot(sigma{k},MarkerColorMatrix{k});
end



set(gca,'Yscale','log');

xlabel('No.');

if normalize;
ylabel('Singular value (normalized)');
else
ylabel('Singular value');
end

sizefig('m');