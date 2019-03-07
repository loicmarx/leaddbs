function [h,fv]=ea_plot_fiber(thisfib,numpol,show,options)
% small function selecting to either draw polygonized tube or thin line.

switch options.prefs.d3.fiberstyle
    case 'tube'
        h = streamtube({thisfib(1:3,:)'}, options.prefs.d3.fiberdiameter*2, [1 numpol]); % note that options.prefs.d3.fiberdiameter actually specifies the radius accoding to ea_plot3t 
        streamFaceColors = [];
        streamFaceColors(:,:,1) = repmat(thisfib(4,:)',1, numpol+1);
        streamFaceColors(:,:,2) = repmat(thisfib(5,:)',1, numpol+1);
        streamFaceColors(:,:,3) = repmat(thisfib(6,:)',1, numpol+1);
        set(h, 'FaceColor', 'interp', 'CData', streamFaceColors, 'CDataMapping', 'direct', 'EdgeColor', 'none', 'FaceAlpha', 0.2);
        fv = nan;       
    case 'line'
        h=surface([thisfib(1,:);thisfib(1,:)],...
            [thisfib(2,:);thisfib(2,:)],...
            [thisfib(3,:);thisfib(3,:)],...
            [thisfib(4,:);thisfib(4,:)],'facecol','no','edgecol','interp','linew',options.prefs.d3.fiberdiameter);
        fv=nan;
    otherwise
        ea_error('Please set ea_prefs.d3.fiberstyle to either tube or line');
end