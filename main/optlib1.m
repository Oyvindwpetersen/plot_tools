function plotopt=optlib1(c,alt,add_top)

%% Axes options for grid subplot  
%
% Inputs:
% c: [nh,nw]
% alt: 1 or 2 
% add_top: if true, then 0.4 cm is added at top margin
%
% Outputs: none
%

%%

if nargin<2
    alt=1;
end

if nargin<3
    add_top=false;
end

%%

plotopt=struct();
plotopt.interpreter='latex';

% marg_h=[0.1 0.1];
% marg_w=[0.1 0.025];
% % gap=[0.1 0.125];
% 
% h_sub_cm=1.6;
% h_gap_cm=0.8;
% 
% w_sub_cm=4.5;
% w_gap_cm=1.0;
% 
% h_marg_cm=marg_h*8;
% w_marg_cm=marg_w*12;

%%

h_cm_new=NaN;
w_cm_new=NaN;

nh=c(1);
nw=c(2);

plotopt=struct();
plotopt.interpreter='latex';

%%

if alt==1

% 5 12.8
% 4 10.4
% 3 8
% 2 5.6
% 1 3.2

% 3 18
% 2 12
% 1 6

% marg_h=[0.1 0.1];
% marg_w=[0.1 0.025];
% gap=[0.1 0.125];

% h_marg_cm=marg_h*8;
% w_marg_cm=marg_w*12;

h_sub_cm=1.6;
h_gap_cm=0.8;

w_sub_cm=4.5;
w_gap_cm=1.5;

h_marg_cm=[0.8 0.8];
w_marg_cm=[1.2 0.3];

end

%%

if alt==2

% 5 18
% 4 14.5
% 3 11
% 2 7.5
% 1 4

h_sub_cm=1.6;
h_gap_cm=0.8;

w_sub_cm=2.5;
w_gap_cm=1.0;

h_marg_cm=[0.8 0.8];
w_marg_cm=[1.2 0.3];


end

%%

if alt==3

% 5 12.8
% 4 10.4
% 3 8
% 2 5.6
% 1 3.2

% 3 16.5
% 2 11
% 1 6

h_sub_cm=1.6;
h_gap_cm=0.8;

w_sub_cm=4.0;
w_gap_cm=1.5;

h_marg_cm=[0.8 0.8];
w_marg_cm=[1.2 0.3];

end


%%


if add_top
    h_marg_cm(2)=h_marg_cm(2)+0.4;
end


h_cm_new=h_sub_cm*nh+h_gap_cm*(nh-1)+h_marg_cm(1)+h_marg_cm(2);

w_cm_new=w_sub_cm*nw+w_gap_cm*(nw-1)+w_marg_cm(1)+w_marg_cm(2);

marg_h_new=h_marg_cm/h_cm_new;
marg_w_new=w_marg_cm/w_cm_new;

gap_new(1)=h_gap_cm/h_cm_new;
gap_new(2)=w_gap_cm/w_cm_new;

plotopt.marg_h=marg_h_new;
plotopt.marg_w=marg_w_new;
plotopt.gap=gap_new;



%%

% marg_h_new=h_marg_cm/h_cm_new;
% marg_w_new=w_marg_cm/w_cm_new;
% 
% gap_new(1)=h_gap_cm/h_cm_new;
% gap_new(2)=w_gap_cm/w_cm_new;
% 
% plotopt.marg_h=marg_h_new;
% plotopt.marg_w=marg_w_new;
% plotopt.gap=gap_new;


%%

% if alt~=1
% 
% plotopt=struct();
% plotopt.interpreter='latex';
% 
% marg_h=[0.1 0.1];
% marg_w=[0.1 0.025];
% % gap=[0.1 0.125];
% 
% h_sub_cm=1.6;
% h_gap_cm=0.8;
% 
% w_sub_cm=3;
% w_gap_cm=1.0;
% 
% h_marg_cm=marg_h*8;
% w_marg_cm=marg_w*12;
% 
% 
% if c(1)==2 %& a==5.6
%     h_cm_new=h_sub_cm*2+h_gap_cm*1+h_marg_cm(1)+h_marg_cm(2);
% end
% 
% if c(1)==1 %& a==3.2
%     h_cm_new=h_sub_cm*1+h_gap_cm*0+h_marg_cm(1)+h_marg_cm(2);
% end
% 
% if c(2)==5 %& b==18
%     w_cm_new=w_sub_cm*5+w_gap_cm*2+w_marg_cm(1)+w_marg_cm(2);
% end
% 
% if c(2)==4 %& b==18
%     w_cm_new=w_sub_cm*4+w_gap_cm*2+w_marg_cm(1)+w_marg_cm(2);
% end
% 
% if c(2)==3 %& b==18
%     w_cm_new=w_sub_cm*3+w_gap_cm*2+w_marg_cm(1)+w_marg_cm(2);
% end
% 
% if c(2)==2 %& b==12
%     w_cm_new=w_sub_cm*2+w_gap_cm*1+w_marg_cm(1)+w_marg_cm(2);
% end
% 
% if c(2)==1 %& b==6
%     w_cm_new=w_sub_cm*1+w_gap_cm*0+w_marg_cm(1)+w_marg_cm(2);
% end
% 
% marg_h_new=h_marg_cm/h_cm_new;
% marg_w_new=w_marg_cm/w_cm_new;
% 
% gap_new(1)=h_gap_cm/h_cm_new;
% gap_new(2)=w_gap_cm/w_cm_new;
% 
% plotopt.marg_h=marg_h_new;
% plotopt.marg_w=marg_w_new;
% plotopt.gap=gap_new;
% 
% end

%%


% old
% 
% 
% 
% %%
% 
% 
% plotopt=struct();
% plotopt.interpreter='latex';
% 
% marg_h=[0.1 0.1];
% marg_w=[0.1 0.025];
% % gap=[0.1 0.125];
% 
% h_sub_cm=1.6;
% h_gap_cm=0.8;
% 
% w_sub_cm=4.5;
% w_gap_cm=1.5;
% 
% h_marg_cm=marg_h*8;
% w_marg_cm=marg_w*12;
% 
% if c(1)==5 %& a==12.8
%     h_cm_new=h_sub_cm*4+h_gap_cm*3+h_marg_cm(1)+h_marg_cm(2);
% end
% 
% if c(1)==4 %& a==10.4
%     h_cm_new=h_sub_cm*4+h_gap_cm*3+h_marg_cm(1)+h_marg_cm(2);
% end
% 
% if c(1)==3 %& a==8
%     h_cm_new=h_sub_cm*3+h_gap_cm*2+h_marg_cm(1)+h_marg_cm(2);
% end
% 
% if c(1)==2 %& a==5.6
%     h_cm_new=h_sub_cm*2+h_gap_cm*1+h_marg_cm(1)+h_marg_cm(2);
% end
% 
% if c(1)==1 %& a==3.2
%     h_cm_new=h_sub_cm*1+h_gap_cm*0+h_marg_cm(1)+h_marg_cm(2);
% end
% 
% if c(2)==3 %& b==18
%     w_cm_new=w_sub_cm*3+w_gap_cm*2+w_marg_cm(1)+w_marg_cm(2);
% end
% 
% if c(2)==2 %& b==12
%     w_cm_new=w_sub_cm*2+w_gap_cm*1+w_marg_cm(1)+w_marg_cm(2);
% end
% 
% if c(2)==1 %& b==6
%     w_cm_new=w_sub_cm*1+w_gap_cm*0+w_marg_cm(1)+w_marg_cm(2);
% end
% 
% marg_h_new=h_marg_cm/h_cm_new;
% marg_w_new=w_marg_cm/w_cm_new;
% 
% gap_new(1)=h_gap_cm/h_cm_new;
% gap_new(2)=w_gap_cm/w_cm_new;
% 
% plotopt.marg_h=marg_h_new;
% plotopt.marg_w=marg_w_new;
% plotopt.gap=gap_new;
%     h_cm_new=h_sub_cm*4+h_gap_cm*3+h_marg_cm(1)+h_marg_cm(2);
% end
% 
% if c(1)==4 %& a==10.4
%     h_cm_new=h_sub_cm*4+h_gap_cm*3+h_marg_cm(1)+h_marg_cm(2);
% end
% 
% if c(1)==3 %& a==8
%     h_cm_new=h_sub_cm*3+h_gap_cm*2+h_marg_cm(1)+h_marg_cm(2);
% end
% 
% if c(1)==2 %& a==5.6
%     h_cm_new=h_sub_cm*2+h_gap_cm*1+h_marg_cm(1)+h_marg_cm(2);
% end
% 
% if c(1)==1 %& a==3.2
%     h_cm_new=h_sub_cm*1+h_gap_cm*0+h_marg_cm(1)+h_marg_cm(2);
% end
% 
% if c(2)==3 %& b==18
%     w_cm_new=w_sub_cm*3+w_gap_cm*2+w_marg_cm(1)+w_marg_cm(2);
% end
% 
% if c(2)==2 %& b==12
%     w_cm_new=w_sub_cm*2+w_gap_cm*1+w_marg_cm(1)+w_marg_cm(2);
% end
% 
% if c(2)==1 %& b==6
%     w_cm_new=w_sub_cm*1+w_gap_cm*0+w_marg_cm(1)+w_marg_cm(2);
% end
% 
% marg_h_new=h_marg_cm/h_cm_new;
% marg_w_new=w_marg_cm/w_cm_new;
% 
% gap_new(1)=h_gap_cm/h_cm_new;
% gap_new(2)=w_gap_cm/w_cm_new;
% 
% plotopt.marg_h=marg_h_new;
% plotopt.marg_w=marg_w_new;
% plotopt.gap=gap_new;