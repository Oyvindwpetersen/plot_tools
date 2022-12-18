function [mpcw,rotrad,psir,mpc]=rotate_modes(psi)
%% Rotation of mode shapes for best alignment with real axis
%
% [mpcw,rotrad]=rotate_modes(psi);
%
% Inputs:
%
% psi    := q x nm, complex mode shapes
% 
% Outputs:
%
% mpcw   := nm x 1, weighted modal phase collinearity
% rotrad := nm x 1, rotation of mode shapes for best alignment with +/- 90 deg.
% psir   := q x nm, complex rotated modes
%
%%
[q,nm] = size(psi);

% If emtpy, return
if isempty(psi)
   mpcw=NaN*ones(1,nm);
   mpc=NaN*ones(1,nm);
   rotrad=NaN*ones(1,nm);
   psir=NaN*ones(size(psi));
   return
end


% If real, return 
if isreal(psi)
   mpcw=100*ones(1,nm);
   mpc=100*ones(1,nm);
   rotrad=0*ones(1,nm);
   psir=psi;
   return
end

% psi=psi-repmat(sum(psi)/q,q,dumm); %Ref mail from Torodd

sxx=ones(1,q)*(real(psi).^2);
syy=ones(1,q)*(imag(psi).^2);
sxy=ones(1,q)*(real(psi).*imag(psi));
%
eta    = (syy - sxx) ./ (2 * sxy);
term0  = sqrt((eta .* eta) + 1);

beta   = eta + (sign(sxy) .* term0);
term1  = (sxx + syy) ./ 2;
term2  = sxy .* term0;
ev1    = term1 + term2;
ev2    = term1 - term2;
eratio = (ev1 - ev2) ./ (ev1 + ev2);
tau    = atan(beta);
mpcw0  = eratio .* eratio;
mpcw=100*mpcw0';
rotrad0 = tau + pi/2; % Rotation of mode shapes for best alignment with +/- 90 deg.

%% Alignment with real axis:

rotrad=rotrad0-pi/2;
psir=conj(psi) .* repmat(exp(1i*rotrad),q,1);

%% Appendix according to Torodd
% (abs value of eta or not? Different practices exist in literature)
% 
term_1 = abs(eta)+sign(eta).*term0;
% term_1 =(eta)+sign(eta).*term0;
term_2 = atan(term_1);
% MPC=(sxx+1./eta.*sxy*(2*(eta.*eta+1).*sin(term_2).*sin(term_2)-1))/(sxx+syy);
mpc=(sxx+1./eta.*sxy.*(2*(eta.*eta+1).*sin(term_2).*sin(term_2)-1))./(sxx+syy);
mpc=mpc*100;


