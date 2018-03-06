function p1demo
%

global h_figure h_axis h_null h_grid h_space1 h_space2 h_origin h_one ...
    h_line h_point1 h_point2 h_xorig h_yorig h_theta h_h11 h_h12 ...
    h_h21 h_h22 h_hi11 h_hi12 h_hi21 h_hi22 h_p1x h_p1y h_p1xn h_p1yn ...
    h_p2x h_p2y h_p2xn h_p2yn h_p2xd h_p2yd xnull ynull phi xorig ...
    yorig theta l1 l2 l H Hinv p1 p2 p;

xlimit = [-10 10];
ylimit = [-10 10];

xorig = 0;
yorig = 2;
theta = 0;

xnull = 0;
ynull = 0;
phi = pi/4;

H = [yorig -xorig; -sin(theta) cos(theta)];
Hinv = inv(H);

scrsz = get(0, 'ScreenSize');
h_figure = figure('Position', [5 scrsz(4)/2-5 scrsz(3)/2 scrsz(4)/2]);
h_panel = uipanel('Parent', h_figure, 'Position', [.65 .1 .25 .8]);
h_axis = axes('Parent', h_figure, 'Position', [.1 .1 .5 .8]);
axis([xlimit ylimit]);
title('Demo of projective 1D space');

hold('on');

h_grid = {};
for i=xlimit(1):xlimit(2)
  h_grid = {h_grid line([i -i], [-10, 10], 'color', [0.7 0.7 0.7])};
  h_grid = {h_grid line([-10, 10], [i -i], 'color', [0.7 0.7 0.7])};
end

l1 = [0 1 -1]';
h_space1 = plot(xlimit, [1 1], 'b', 'LineWidth', 2);

[xdata ydata] = calc_line_data(xorig, yorig, theta, xlimit, ylimit);
l2 = cross([xdata(1) ydata(1) 1], [xdata(2) ydata(2) 1]);

h_space2 = line(xdata, ydata, 'color', 'g', 'LineWidth', 2);
h_origin = plot(xorig, yorig, 'om', 'MarkerSize', 5, 'MarkerFaceColor', 'm');
h_one = plot(xorig+cos(theta), yorig+sin(theta), 'oc', 'MarkerSize', 5, 'MarkerFaceColor', 'c');

[xdata ydata] = calc_line_data(xnull, ynull, phi, xlimit, ylimit);
l = cross([xdata(1) ydata(1) 1], [xdata(2) ydata(2) 1]);
h_line = line(xdata, ydata, 'color', 'k');
p1 = cross(l, l1);
p1 = p1/p1(3);
h_point1 = plot(p1(1), p1(2), 'ok', 'MarkerSize', 5, 'MarkerFaceColor', 'k');
p2 = cross(l, l2);
p2 = p2/p2(3);
h_point2 = plot(p2(1), p2(2), 'ok', 'MarkerSize', 5, 'MarkerFaceColor', 'k');

h_null = plot(0, 0, 'or', 'MarkerSize', 5, 'MarkerFaceColor', 'r');

uicontrol(h_panel, 'Style', 'text', 'String', 'New Projective Line', ...
	  'Units', 'normalized', 'Position', [0.1 0.94 0.8 0.04]);
uicontrol(h_panel, 'Style', 'text', 'String', 'Origin', 'Units', ...
	  'normalized', 'Position', [0.05 0.87 0.17 0.04], ...
	  'HorizontalAlignment', 'left');
[s msg] = sprintf('%5.1e', xorig);
h_xorig = uicontrol(h_panel, 'Style', 'edit', 'String', s, ...
		    'Units', 'normalized', 'Position', [0.25 0.88 0.3 0.04]); 
[s msg] = sprintf('%5.1e', yorig);
h_yorig = uicontrol(h_panel, 'Style', 'edit', 'String', s, ...
		    'Units', 'normalized', 'Position', [0.6 0.88 0.3 0.04]);
uicontrol(h_panel, 'Style', 'text', 'String', 'Orientation', 'Units', ...
	  'normalized', 'Position', [0.05 0.81 0.3 0.04], ...
	  'HorizontalAlignment', 'left');
[s msg] = sprintf('%5.1e', theta);
h_theta = uicontrol(h_panel, 'Style', 'edit', 'String', s, ...
		    'Units', 'normalized', 'Position', [0.4 0.82 0.3 0.04]);
uicontrol(h_panel, 'Style', 'text', 'String', 'Homography', 'Units', ...
	  'normalized', 'Position', [0.1 0.74 0.8 0.04]);
uicontrol(h_panel, 'Style', 'text', 'String', 'p1 -> p2', 'Units', ...
	  'normalized', 'Position', [0.05 0.64 0.27 0.04], ...
	  'HorizontalAlignment', 'left');
[s msg] = sprintf('%5.1e', H(1,1));
h_h11 = uicontrol(h_panel, 'Style', 'edit', 'String', s, 'Units', ...
		  'normalized', 'Position', [0.35 0.68 0.25 0.04], ...
		  'Enable', 'inactive');
[s msg] = sprintf('%5.1e', H(1,2));
h_h12 = uicontrol(h_panel, 'Style', 'edit', 'String', s, 'Units', ...
		  'normalized', 'Position', [0.65 0.68 0.25 0.04], ...
		  'Enable', 'inactive');
[s msg] = sprintf('%5.1e', H(2,1));
h_h21 = uicontrol(h_panel, 'Style', 'edit', 'String', s, 'Units', ...
		  'normalized', 'Position', [0.35 0.62 0.25 0.04], ...
		  'Enable', 'inactive');
[s msg] = sprintf('%5.1e', H(2,2));
h_h22 = uicontrol(h_panel, 'Style', 'edit', 'String', s, 'Units', ...
		  'normalized', 'Position', [0.65 0.62 0.25 0.04], ...
		  'Enable', 'inactive');
uicontrol(h_panel, 'Style', 'text', 'String', 'p2 -> p1', 'Units', ...
	  'normalized', 'Position', [0.05 0.50 0.27 0.04], ...
	  'HorizontalAlignment', 'left');
[s msg] = sprintf('%5.1e', Hinv(1,1));
h_hi11 = uicontrol(h_panel, 'Style', 'edit', 'String', s, ...
		   'Units', 'normalized', 'Position', [0.35 0.54 ...
		    0.25 0.04], 'Enable', 'inactive');
[s msg] = sprintf('%5.1e', Hinv(1,2));
h_hi12 = uicontrol(h_panel, 'Style', 'edit', 'String', s, ...
		   'Units', 'normalized', 'Position', [0.65 0.54 ...
		    0.25 0.04], 'Enable', 'inactive');
[s msg] = sprintf('%5.1e', Hinv(2,1));
h_hi21 = uicontrol(h_panel, 'Style', 'edit', 'String', s, ...
		   'Units', 'normalized', 'Position', [0.35 0.48 ...
		    0.25 0.04], 'Enable', 'inactive');
[s msg] = sprintf('%5.1e', Hinv(2,2));
h_hi22 = uicontrol(h_panel, 'Style', 'edit', 'String', s, ...
		   'Units', 'normalized', 'Position', [0.65 0.48 ...
		    0.25 0.04], 'Enable', 'inactive');
uicontrol(h_panel, 'Style', 'text', 'String', 'Points', 'Units', ...
	  'normalized', 'Position', [0.1 0.40 0.8 0.04]);
uicontrol(h_panel, 'Style', 'text', 'String', 'p1', 'Units', ...
	  'normalized', 'Position', [0.05 0.33 0.1 0.04], ...
	  'HorizontalAlignment', 'left');
[s msg] = sprintf('%5.1e', p1(1));
h_p1x = uicontrol(h_panel, 'Style', 'edit', 'String', s, 'Units', ...
		  'normalized', 'Position', [0.35 0.34 0.25 0.04]);
[s msg] = sprintf('%5.1e', p1(2));
h_p1y = uicontrol(h_panel, 'Style', 'edit', 'String', s, 'Units', ...
		  'normalized', 'Position', [0.65 0.34 0.25 0.04]);
uicontrol(h_panel, 'Style', 'text', 'String', 'p1 (norm)', ...
		   'Units', 'normalized', 'Position', [0.05 0.27 ...
		    0.27 0.04], 'HorizontalAlignment', 'left');
[s msg] = sprintf('%5.1e', p1(1)/p1(2));
h_p1xn = uicontrol(h_panel, 'Style', 'edit', 'String', s, 'Units', ...
		   'normalized', 'Position', [0.35 0.28 0.25 0.04], ...
		   'Enable', 'inactive');
h_p1yn = uicontrol(h_panel, 'Style', 'edit', 'String', 1, 'Units', ...
		   'normalized', 'Position', [0.65 0.28 0.25 0.04], ...
		   'Enable', 'inactive');
p = H*p1(1,1:2)';
uicontrol(h_panel, 'Style', 'text', 'String', 'p2', 'Units', ...
	  'normalized', 'Position', [0.05 0.21 0.1 0.04], ...
	  'HorizontalAlignment', 'left');
[s msg] = sprintf('%5.1e', p(1));
h_p2x = uicontrol(h_panel, 'Style', 'edit', 'String', s, 'Units', ...
		  'normalized', 'Position', [0.35 0.22 0.25 0.04]);
[s msg] = sprintf('%5.1e', p(2));
h_p2y = uicontrol(h_panel, 'Style', 'edit', 'String', s, 'Units', ...
		  'normalized', 'Position', [0.65 0.22 0.25 0.04]);
uicontrol(h_panel, 'Style', 'text', 'String', 'p2 (norm)', 'Units', ...
	  'normalized', 'Position', [0.05 0.15 0.27 0.04], ...
	  'HorizontalAlignment', 'left');
[s msg] = sprintf('%5.1e', p(1)/p(2));
h_p2xn = uicontrol(h_panel, 'Style', 'edit', 'String', s, ...
		   'Units', 'normalized', 'Position', [0.35 0.16 ...
		    0.25 0.04], 'Enable', 'inactive');
h_p2yn = uicontrol(h_panel, 'Style', 'edit', 'String', 1, 'Units', ...
		   'normalized', 'Position', [0.65 0.16 0.25 0.04], ...
		   'Enable', 'inactive');
uicontrol(h_panel, 'Style', 'text', 'String', 'p2 (disp)', 'Units', ...
	  'normalized', 'Position', [0.05 0.09 0.27 0.04], ...
	  'HorizontalAlignment', 'left');
[s msg] = sprintf('%5.1e', p2(1));
h_p2xd = uicontrol(h_panel, 'Style', 'edit', 'String', s, 'Units', ...
		   'normalized', 'Position', [0.35 0.10 0.25 0.04], ...
		   'Enable', 'inactive');
[s msg] = sprintf('%5.1e', p2(2));
h_p2yd = uicontrol(h_panel, 'Style', 'edit', 'String', s, 'Units', ...
		   'normalized', 'Position', [0.65 0.10 0.25 0.04], ...
		   'Enable', 'inactive');

set(h_origin, 'ButtonDownFcn', @orig_bdcb);
set(h_space2, 'ButtonDownFcn', @space2_bdcb);
set(h_one,    'ButtonDownFcn', @space2_bdcb);
set(h_line,   'ButtonDownFcn', @line_bdcb);
set(h_point1, 'ButtonDownFcn', @line_bdcb);
set(h_point2, 'ButtonDownFcn', @line_bdcb);

set(h_xorig, 'Callback', @xorig_cb);
set(h_yorig, 'Callback', @yorig_cb);
set(h_theta, 'Callback', @theta_cb);
set(h_p1x,   'Callback', @point_cb);
set(h_p1y,   'Callback', @point_cb);
set(h_p2x,   'Callback', @point_cb);
set(h_p2y,   'Callback', @point_cb);

return


function orig_bdcb(src, event)
%

global h_figure;

update_origin;

update_space2;

set(h_figure, 'WindowButtonMotionFcn', @orig_bmcb);
set(h_figure, 'WindowButtonUpFcn', @orig_bucb);

return


function orig_bmcb(src, event)
%

update_origin;

update_space2;

return


function orig_bucb(src, event)
%

global h_figure;

update_origin;

update_space2;

set(h_figure, 'WindowButtonMotionFcn', '');
set(h_figure, 'WindowButtonUpFcn', '');

return


function space2_bdcb(src, event)
%

global h_figure;

update_theta;

update_space2;

set(h_figure, 'WindowButtonMotionFcn', @space2_bmcb);
set(h_figure, 'WindowButtonUpFcn', @space2_bucb);

return


function space2_bmcb(src, event)
%

update_theta;

update_space2;

return


function space2_bucb(src, event)
%

global h_figure;

update_theta;

update_space2;

set(h_figure, 'WindowButtonMotionFcn', '');
set(h_figure, 'WindowButtonUpFcn', '');

return


function line_bdcb(src, event)
%

global h_figure;

update_phi;

update_line;

set(h_figure, 'WindowButtonMotionFcn', @line_bmcb);
set(h_figure, 'WindowButtonUpFcn', @line_bucb);

return


function line_bmcb(src, event)
%

update_phi;

update_line;

return


function line_bucb(src, event)
%

global h_figure;

update_phi;

update_line;

set(h_figure, 'WindowButtonMotionFcn', '');
set(h_figure, 'WindowButtonUpFcn', '');

return


function xorig_cb(src, event)
%

global h_xorig xorig;

xorig = str2double(get(h_xorig, 'String'));

update_space2;

return


function yorig_cb(src, event)
%

global h_yorig yorig;

yorig = str2double(get(h_yorig, 'String'));

update_space2;

return


function theta_cb(src, event)
%

global h_theta theta;

theta = str2double(get(h_theta, 'String'));

update_space2;

return


function point_cb(src, event)
%

global h_p1x h_p1y xnull ynull phi;

xo = cos(phi);
yo = sin(phi);
xn = str2double(get(h_p1x, 'String'))-xnull;
yn = str2double(get(h_p1y, 'String'))-ynull;
if ((xo*xn + yo*yn) < 0)
  xn = -xn;
  yn = -yn;
end
phi = atan2(yn, xn);

update_line;

return


function update_origin
%

global h_axis h_xorig h_yorig xorig yorig;

cp = get(h_axis, 'CurrentPoint');
xorig = cp(1,1);
yorig = cp(1,2);

[s msg] = sprintf('%5.1e', xorig);
set(h_xorig, 'String', xorig);
[s msg] = sprintf('%5.1e', yorig);
set(h_yorig, 'String', s);

return


function update_theta
%

global h_axis h_theta xorig yorig theta;

cp = get(h_axis, 'CurrentPoint');
xo = cos(theta);
yo = sin(theta);
xn = cp(1,1)-xorig;
yn = cp(1,2)-yorig;
if ((xo*xn + yo*yn) < 0)
  xn = -xn;
  yn = -yn;
end
theta = atan2(yn, xn);
[s msg] = sprintf('%5.1e', theta);
set(h_theta, 'String', s);

return


function update_phi
%

global h_axis xnull ynull phi;

cp = get(h_axis, 'CurrentPoint');
xo = cos(phi);
yo = sin(phi);
xn = cp(1,1)-xnull;
yn = cp(1,2)-ynull;
if ((xo*xn + yo*yn) < 0)
  xn = -xn;
  yn = -yn;
end
phi = atan2(yn, xn);

return


function update_space2

global h_axis h_space2 h_origin h_one h_point2 h_h11 h_h12 h_h21 ...
    h_h22 h_hi11 h_hi12 h_hi21 h_hi22 h_p2x h_p2y h_p2xn h_p2yn ...
    h_p2xd h_p2yd xorig yorig theta l2 l H Hinv p1 p2 p;

H = [yorig -xorig; -sin(theta) cos(theta)];
Hinv = inv(H);

xlimit = get(h_axis, 'XLim');
ylimit = get(h_axis, 'YLim');
[xdata ydata] = calc_line_data(xorig, yorig, theta, xlimit, ylimit);
l2 = cross([xdata(1) ydata(1) 1], [xdata(2) ydata(2) 1]);

p2 = cross(l, l2);
p2 = p2/p2(3);

p = H*p1(1,1:2)';

set(h_space2, 'XData', xdata, 'YData', ydata);
if (abs(dot(l2, [0 0 1])) < 5e-2)
  set(h_space2, 'Color', 'r');
else
  set(h_space2, 'Color', 'g');
end
set(h_origin, 'XData', xorig, 'YData', yorig);
set(h_one, 'XData', xorig+cos(theta), 'YData', yorig+sin(theta));
set(h_point2, 'XData', p2(1), 'YData', p2(2));
[s msg] = sprintf('%5.1e', H(1,1));
set(h_h11, 'String', s);
[s msg] = sprintf('%5.1e', H(1,2));
set(h_h12, 'String', s);
[s msg] = sprintf('%5.1e', H(2,1));
set(h_h21, 'String', s);
[s msg] = sprintf('%5.1e', H(2,2));
set(h_h22, 'String', s);
[s msg] = sprintf('%5.1e', Hinv(1,1));
set(h_hi11, 'String', s);
[s msg] = sprintf('%5.1e', Hinv(1,2));
set(h_hi12, 'String', s);
[s msg] = sprintf('%5.1e', Hinv(2,1));
set(h_hi21, 'String', s);
[s msg] = sprintf('%5.1e', Hinv(2,2));
set(h_hi22, 'String', s);
[s msg] = sprintf('%5.1e', p(1));
set(h_p2x, 'String', s);
[s msg] = sprintf('%5.1e', p(2));
set(h_p2y, 'String', s);
[s msg] = sprintf('%5.1e', p(1)/p(2));
set(h_p2xn, 'String', s);
set(h_p2yn, 'String', 1);
[s msg] = sprintf('%5.1e', p2(1));
set(h_p2xd, 'String', s);
[s msg] = sprintf('%5.1e', p2(2));
set(h_p2yd, 'String', s);
drawnow;

return


function update_line

global h_axis h_line h_point1 h_point2 h_p1x h_p1y h_p1xn h_p1yn ...
    h_p2x h_p2y h_p2xn h_p2yn h_p2xd h_p2yd xnull ynull phi l1 l2 l ...
    H p1 p2 p;

xlimit = get(h_axis, 'XLim');
ylimit = get(h_axis, 'YLim');
[xdata ydata] = calc_line_data(xnull, ynull, phi, xlimit, ylimit);
l = cross([xdata(1) ydata(1) 1], [xdata(2) ydata(2) 1]);
set(h_line, 'XData', xdata, 'YData', ydata);
p1 = cross(l, l1);
p1 = p1/p1(3);
set(h_point1, 'XData', p1(1), 'YData', p1(2));
p2 = cross(l, l2);
p2 = p2/p2(3);
set(h_point2, 'XData', p2(1), 'YData', p2(2));
p = H*p1(1,1:2)';
[s msg] = sprintf('%5.1e', p1(1));
set(h_p1x, 'String', s);
[s msg] = sprintf('%5.1e', p1(2));
set(h_p1y, 'String', s);
[s msg] = sprintf('%5.1e', p1(1)/p1(2));
set(h_p1xn, 'String', s);
set(h_p1yn, 'String', 1);
[s msg] = sprintf('%5.1e', p(1));
set(h_p2x, 'String', s);
[s msg] = sprintf('%5.1e', p(2));
set(h_p2y, 'String', s);
[s msg] = sprintf('%5.1e', p(1)/p(2));
set(h_p2xn, 'String', s);
set(h_p2yn, 'String', 1);
[s msg] = sprintf('%5.1e', p2(1));
set(h_p2xd, 'String', s);
[s msg] = sprintf('%5.1e', p2(2));
set(h_p2yd, 'String', s);
drawnow;

return


function [xdata ydata] = calc_line_data(xorig, yorig, theta, xlimit, ylimit)
%

dx = cos(theta);
dy = sin(theta);

y = yorig + (xlimit(1) - xorig)/dx*dy;
if (y <= ylimit(1))
  x = xorig + (ylimit(1) - yorig)/dy*dx;
  xdata = [x];
  ydata = [ylimit(1)];
elseif (y >= ylimit(2))
  x = xorig + (ylimit(2) - yorig)/dy*dx;
  xdata = [x];
  ydata = [ylimit(2)];
else
  xdata = [xlimit(1)];
  ydata = [y];
end

y = yorig + (xlimit(2) - xorig)/dx*dy;
if (y <= ylimit(1))
  x = xorig + (ylimit(1) - yorig)/dy*dx;
  xdata = [xdata x];
  ydata = [ydata ylimit(1)];
elseif (y >= ylimit(2))
  x = xorig + (ylimit(2) - yorig)/dy*dx;
  xdata = [xdata x];
  ydata = [ydata ylimit(2)];
else
  xdata = [xdata xlimit(2)];
  ydata = [ydata y];
end

return
