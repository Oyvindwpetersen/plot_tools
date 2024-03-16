function rgb_out=gencol(n,type)


%%

if nargin<2
    type=1;
end

%%

blue_dark  = [ 0.0 , 0.0 , 0.9 ];
blue_dark2  = [ 0.0 , 0.0 , 0.4 ];
blue   = [ 0.0 , 0.5 , 0.9 ];
red    = [ 0.92 , 0.12 , 0.0 ];
green  = [ 0.0 , 0.6 , 0.0 ];
black  = [ 0.0 , 0.0 , 0.0 ];
orange = [ 1.0 , 0.66 , 0.0 ];
purple = [ 0.7 , 0.0 , 1.0 ];
blue2 = [ 0.31 , 0.51 , 0.75 ];
teal = [ 0.31 , 0.78 , 1 ];
teal2 = [ 0 , 0.8 , 0.8 ];

blue_rel=[0, 114, 178]/256;
red_rel=[213, 94, 0]/256;
green_rel=[0, 158, 115]/256;
orange_rel=[230, 159, 0]/256;
lightblue_rel=[86 , 180, 233]/256;
purple_rel=[178 75 215]/256;

rgb=[blue_dark ; red ; green ; teal2 ; orange ; purple ; blue ; blue2 ;  teal ; black ; blue_dark2];

rgb_bright=[
    blue_dark ;
    red ;
    green ;
    orange ;
    purple ;
    blue ;
    black ];

rgb_rel=[
    blue_rel ;
    red_rel ;
    green_rel ;
    orange_rel ;
    purple_rel
    lightblue_rel ;
    black];

if type==1
    rgb_out=rgb_rel(1:n,:);
elseif type==2
    rgb_out=rgb_bright(1:n,:);
end

return

close all

figure();
image(permute(rgb,[1,3,2]))
% set(gca,'XTick',[],'YTick',1:N,'YDir','normal')
title('Sorted Colors')
ylabel('Colormap Index')

figure();
image(permute(rgb_bright,[1,3,2]))
% set(gca,'XTick',[],'YTick',1:N,'YDir','normal')
title('Sorted Colors')
ylabel('Colormap Index')


figure();
image(permute(rgb_rel,[1,3,2]))
% set(gca,'XTick',[],'YTick',1:N,'YDir','normal')
title('Sorted Colors')
ylabel('Colormap Index')


tilefigs([ 3 6 ])