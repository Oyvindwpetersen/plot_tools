function rgb_out=gencol(n)

%%

blue   = [ 0.0 , 0.5 , 0.9 ];
red    = [ 0.9 , 0.0 , 0.0 ];
green  = [ 0.0 , 0.6 , 0.0 ];
black  = [ 0.0 , 0.0 , 0.0 ];
orange = [ 1.0 , 0.6 , 0.0 ];
purple = [ 0.7 , 0.0 , 1.0 ];
blue2  = [ 0.0 , 0.0 , 0.9 ];

rgb=[blue2 ; red ; green ; black ; orange ; purple ; blue];


rgb_out=rgb(1:n,:);

return

close all

figure();
image(permute(rgb,[1,3,2]))
set(gca,'XTick',[],'YTick',1:N,'YDir','normal')
title('Sorted Colors')
ylabel('Colormap Index')
