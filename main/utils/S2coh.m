function S_coh=S2coh(S)

%% Normalize spectral density to coherence
% 
% Inputs:
% S: spectral density matrix
%
% Outputs:
% S_coh: coherence matrix
%
%%

S_coh=zeros(size(S));

for k=1:size(S,1)
   for l=1:size(S,1)
    S_coh(k,l,:)=S(k,l,:) ./ ( S(k,k,:).*S(l,l,:) ).^0.5;
end
end