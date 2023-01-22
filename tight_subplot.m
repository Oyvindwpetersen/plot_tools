function ha=tight_subplot(nh,nw,gap,marg_h,marg_w,weight_h,weight_w,gapsep)

%% tight_subplot creates "subplot" axes with adjustable gaps and margins
%
% Example: 
% ha = tight_subplot(3,2,[.01 .03],[.1 .01],[.01 .01])
% for ii = 1:6; axes(ha(ii)); plot(randn(10,ii)); end
%
% Inputs:
% nh: number of axes in hight (vertical direction)
% nw: number of axes in width (horizontal direction)
% gap: gaps between the axes in normalized units (0...1), [gap_h gap_w] for different gaps in height and width 
% marg_h: margins in height in normalized units (0...1), [lower upper] for different lower and upper margins 
% marg_w: margins in width in normalized units (0...1), [left right] for different left and right margins 
% weight_h: relative height of axes
% weight_w: relative width of axes
% gapsep: 
%
% Outputs:
% ha: array of handles of the axes objects, starting from upper left corner, going row-wise like reading a book
%
% Based on the script by Pekka Kumpulainen, Tampere University of Technology 
% Modified by OWP
%
%% Input check

if nh>30 | nw>30
    error(['Too many subplots: ' 'nh=' num2str(nh) ', ' 'nw=' num2str(nw) ] );
end

if nargin<3; gap = .05; end
if nargin<4 || isempty(marg_h); marg_h = .1; end
if nargin<5; marg_w = .05; end

if  nargin<6 | isempty(weight_h)
    weight_h=ones(1,nh)/nh;
end

if nargin<6 | isempty(weight_w)
    weight_w=ones(1,nw)/nw;
end

if nargin<8 | isempty(gapsep)
    gapsep=[0 0 0];
end

%% Prepare

if numel(weight_h)~=nh
    error('Weight h not correct size');
end

if numel(weight_w)~=nw
    error('Weight w not correct size');
end

if isempty(gap)
    gap=0.1;
end

if numel(gap)==1
    gap = [gap gap];
end

if numel(marg_w)==1
    marg_w = [marg_w marg_w];
end

if numel(marg_h)==1
    marg_h = [marg_h marg_h];
end

%% Create axes

weight_h=weight_h./sum(weight_h);
weight_w=weight_w./sum(weight_w);

gap_h=gap(1)*ones(1,(nh-1));
gap_w=gap(2)*ones(1,(nw-1));

gapno=gapsep(1); gapdim=gapsep(2); gapspace=gapsep(3);        

if gapdim==1; gap_h(gapno)=gap_h(gapno)+gapspace; gapspace_h=gapspace; gapspace_w=0; 
elseif gapdim==2; gap_w(gapno)=gap_w(gapno)+gapspace; gapspace_h=0; gapspace_w=gapspace;
else  gapspace_h=0; gapspace_w=0;
end

axh = (1-gapspace_h-sum(marg_h)-(nh-1)*gap(1))/nh;  axh=axh.*nh.*weight_h;
axw = (1-gapspace_w-sum(marg_w)-(nw-1)*gap(2))/nw; axw=axw.*nw.*weight_w;

if any(axh<0)
    axh
    error('Height of subplot is negative');
end

if any(axw<0)
    axw
    error('Width of subplot is negative');
end

ha = zeros(nh*nw,1);
ii = 0;

for ih = 1:nh
       for iw = 1:nw
        
        px = marg_w(1)+sum(gap_w(1:(iw-1)))+sum(axw(1:(iw-1)));
        py = 1-( marg_h(2)+sum(gap_h(1:(ih-1)))+sum(axh(1:(ih))) );
        
        ii = ii+1;
        ha(ii) = axes('Units','normalized','Position',[px py axw(iw) axh(ih)]);
        
        Pos{ii}=[px py axw(iw) axh(ih)];

       end
end
