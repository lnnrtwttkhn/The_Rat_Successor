function plot_pos

x1_max=max(x1);
x2_min=min(x1);
y1_max=max(y1);
y2_min=min(y1);

bin_size=40;
smoothing=0.8;

x_spacing=linspace(x1_max,x2_min,bin_size);
y_spacing=linspace(y1_max,y2_min,bin_size);

for iconfig = 1:1 %should be 25?
    map=zeros(bin_size,bin_size);

    for itrial = 1:10
        x1_traj=x1(~isnan(x1));
        y1_traj=y1(~isnan(y1));


        mx_plot=length(x1_traj);


        for ipos = 1:mx_plot
            %find in which x and y spacing the recorded timepoint is in.
            [ix]=find(x_spacing-x1_traj(ipos)>=0);%Where is this in the spacing?x1(ipos)
            %Get the first index where the position is contained
            ix=ix(end);
            [iy]=find(y_spacing-y1_traj(ipos)>=0);
            iy=iy(end);

            map(ix,iy)=map(ix,iy)+1;

        end
    end

    figure(iconfig)
    smoothed=SmoothDec(map,[smoothing smoothing]);
    %  t = smoothed + peaks
    %   surf(t)
    %   hold on
    % xy_test = 1:1000;
    % h(1) = surf(xy_test, xy_test, smoothed*2);
    % hold on;
    imagesc(smoothed);
    % set(h(2),'FaceColor','interp','EdgeColor','interp');
    % xlim([0 1000]);
    % ylim([0 1000]);
    % colormap('pink');
    caxis([0 1000])
    set(gca,'YDir','normal');
    colorbar;

end

end 