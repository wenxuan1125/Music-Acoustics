function [handle_axes1,handle_axes2] = createFigure

% create a new figure and store handle
screenposx = 100;   % in units of pixels
screenposy = 100;
screenwidth = 800;
screenheight = 500;
% The normalized units setting means we do not need to worry about pixels or inches when creating an axis
handle_figure = figure('Position', ...
  [screenposx screenposy screenwidth screenheight], 'Units','Normalized');

% set the figure printing properties.
% NOTE: if printing to EPS, only the last 2 values matter as they define the figure size
leftmargin = 0.1;  % these are in inches
bottommargin = 0.1;
figurewidth = 10;
figureheight = 6;
set(handle_figure,'PaperOrientation','portrait', ...
  'PaperPosition',[leftmargin bottommargin figurewidth figureheight]);

% create axes and store handle
axeswidth = 0.86; % normalized units; 1 spans entire width
axesheight = 0.42;
axesmarginleft = 0.1;
axesmarginbottom = 0.12;
% always make the fontsize larger than the extremely small MATLAB default
handle_axes1 = axes('FontSize',14,'FontName','Helvetica', ...
  'position', [axesmarginleft axesmarginbottom+axesheight+0.02 axeswidth axesheight]);

handle_axes2 = axes('FontSize',14,'FontName','Helvetica', ...
  'position', [axesmarginleft axesmarginbottom axeswidth axesheight]);

doExportPlot = true;
hold on;