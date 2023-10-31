function [f,G]=fft_function(x,dt,dim)

%Fourier transfom of discrete-time signal
%--------------------------------------------------------------------------
% (n1 = number of signals)
% (n2 = number of time steps)
%
% OUTPUT
% G = FFT [n1,n2]
% f = Frequency vector in Hz [1,n2]
%
%
% INPUT
% x = Time signal of row vectors [n1,n2]
% dt = Discrete time step of x

% check dimension of x

if nargin==2
    dim=2;
end

[n1 n2 n3]=size(x);

if dim==1
    
    G=fftshift(fft(x,[],1),1)/n1;
    n_points=n1;

elseif dim==2
    
    G=fftshift(fft(x,[],2),2)/n2;
    n_points=n2;

elseif dim==3
    
    G=fftshift(fft(x,[],3),3)/n3;
    n_points=n3;
    
end

Fs=1/dt;
f = Fs/2*linspace(-1,1,n_points);


%% OLD CODE
return
[n1 n2]=size(x);
if n2<n1 % make x row vectors
	x=x.';
	transform=true;
else
	transform=false;
end	

% make length of x odd numbered
% if mod(length(x),2)==0
%     x=x(:,1:end-1);
% end
[n1 n2]=size(x);


% compute fft
G=zeros(size(x));
for k=1:n1
G(k,:)=fftshift(fft(x(k,:),n2))/n2;
end

% create frequency vector
Fs=1/dt;
f = Fs/2*linspace(-1,1,n2);
