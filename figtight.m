function plotopt=figtight(a,b)


%%

figure();

if a==3 & b==8

    plotopt=struct();
    % plotopt.xlabel='$t$';
    % plotopt.ylabel='$x(t)$';
    plotopt.marg_h=[0.25 0.10];
    plotopt.marg_w=[0.15 0.05];
    plotopt.gap=[0.15 0.15];
    % plotopt.interpreter='latex';
end

if a==5 & b==8

    plotopt=struct();
    % plotopt.xlabel='$t$';
    % plotopt.ylabel='$x(t)$';
    plotopt.marg_h=[0.15 0.10];
    plotopt.marg_w=[0.125 0.05];
    plotopt.gap=[0.15 0.15];
    % plotopt.interpreter='latex';
    % % plotopt.xlim=[0 10];
    % plotopt.legendshow=false;
end

if a==3 & b==5

    plotopt=struct();
    % plotopt.xlabel='$t$';
    % plotopt.ylabel='$x(t)$';
    plotopt.marg_h=[0.25 0.10];
    plotopt.marg_w=[0.2 0.1];
    plotopt.gap=[0.15 0.15];
    % plotopt.interpreter='latex';
    % % plotopt.xlim=[0 10];
    % plotopt.legendshow=false;
end

tight_subplot(1,1,...
    plotopt.gap,...
    plotopt.marg_h,...
    plotopt.marg_w...
    );

hold on; grid on;
