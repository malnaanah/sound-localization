function plot_gcc(action)
if nargin==0; action='refresh';end

global userdata

fig=findobj('tag','gcc_plot');
if isempty(fig) && strcmp(action,'refresh');return;end


SZ = max(size(userdata.gcc_x));
MIN = -400;
MAX = 400;
n=[MIN:MAX];
SHFT = floor(SZ/2) +1;
MIN = SHFT + MIN;
MAX = SHFT + MAX;

if isempty(fig) && strcmp(action,'create')
  fig = figure('tag','gcc_plot','name', 'GCC Plots');
  ax=subplot(3,1,1,'parent',fig); plot(n, userdata.gcc_x(MIN:MAX),'parent',ax);
  ax=subplot(3,1,2,'parent',fig); plot(n, userdata.gcc_y(MIN:MAX),'parent',ax);
  ax=subplot(3,1,3,'parent',fig); plot(n, userdata.gcc_z(MIN:MAX),'parent',ax);
end

ax = get(fig,'children');

ln = get(ax(3),'children');
set(ln,'ydata',userdata.gcc_x(MIN:MAX))

ln = get(ax(2),'children');
set(ln,'ydata',userdata.gcc_y(MIN:MAX))

ln = get(ax(1),'children');
set(ln,'ydata',userdata.gcc_x(MIN:MAX))

return
