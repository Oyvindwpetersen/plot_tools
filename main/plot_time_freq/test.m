%%

clc
clear all
close all

x1=[1:1000]*0.01;
y1=sin(x1*9);


y1=[y1;y1.^2]; %;sin(x1*9+0.1)


x2=[1:0.3:1000]*0.01;
y2=cos(x2*10);

y2=[y2;y2.^3];


plotopt=struct();
plotopt.gap=[0.2 0.1];

plottime(x1,y1,x2,y2,'Marker',{'None' 'None'},'LineStyle',{'-' ':'},plotopt);
% 
% 
plotfreq(x1,y1,x2,y2,'comp',[],'Marker',{'None' 'None'});


tilefigs([2 2],'l');

%%

clc

y3=[y1;y1.^2];
y4=[y2;y2.^3];

[S1,f1]=estimateSpectrumWelch(y3,1/diff(x1(1:2)));
[S2,f2]=estimateSpectrumWelch(y4,1/diff(x2(1:2)));

close all

plotopt=struct();
plotopt.xlim=[0 30];
plotopt.type='all';
% plotopt.type='auto';

plotpsd(f1,S1,f2,S2,plotopt);

tilefigs([2 2],'l');
