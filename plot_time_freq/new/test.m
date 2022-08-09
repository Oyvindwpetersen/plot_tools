%%

clc
clear all
close all



x1=[1:1000]*0.01;
y1=sin(x1*9);



y1=[y1;y1.^2];


x2=[1:0.3:1000]*0.01;
y2=cos(x2*10);


y2=[y2;y2.^3];



plottime_new(x1,y1,x2,y2,'comp',[],'Marker',{'None' 'None'});


plotfreq_new(x1,y1,x2,y2,'comp',[],'Marker',{'None' 'None'});

%%




[S1,f1]=estimateSpectrumWelch(y1,1/diff(x1(1:2)));
[S2,f2]=estimateSpectrumWelch(y2,1/diff(x2(1:2)));


plotpsd_new(f1,S1,f2,S2,'type','all');
