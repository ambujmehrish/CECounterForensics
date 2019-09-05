function output = plotGLCM(input)
%function output = plotGLCM(input)

offsets = [-1 1];
 
S = graycomatrix(input,'NumLevels',256,'Offset',offsets);
[m, n] = size(S);
nonzeroInd = find(S);
[x, y] = ind2sub([m n], nonzeroInd);

figure();
output = patch(x, y, S(nonzeroInd), ...
           'Marker', 's', 'MarkerFaceColor', 'flat', 'MarkerSize', 2, ...
           'EdgeColor', 'none', 'FaceColor', 'none');
set(gca, 'XLim', [0, n + 1], 'YLim', [0, m + 1], 'YDir', 'reverse', ...
    'PlotBoxAspectRatio', [n + 1, m + 1, 1]);
colorbar();




end