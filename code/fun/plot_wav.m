function plot_wav(action)
if nargin==0; action='refresh';end

global userdata

fig=findobj('tag','wav_plot');
if isempty(fig) && strcmp(action,'refresh');return;end




if isempty(fig) && strcmp(action,'create')
  sz = max(size(userdata.m0));
  t=([1:sz]-1)/userdata.sample_rate;
  fig=figure('tag','wav_plot', 'name', 'Waveforms');
  ax=subplot(4,1,1,'parent',fig); plot(t,userdata.m0,'parent',ax); set(ax,'ylim',[-1,1]);
  ax=subplot(4,1,2,'parent',fig); plot(t,userdata.mx,'parent',ax); set(ax,'ylim',[-1,1]);
  ax=subplot(4,1,3,'parent',fig); plot(t,userdata.my,'parent',ax); set(ax,'ylim',[-1,1]);
  ax=subplot(4,1,4,'parent',fig); plot(t,userdata.mz,'parent',ax); set(ax,'ylim',[-1,1]);
end

ax = get(fig,'children');

ln = get(ax(4),'children');
set(ln,'ydata',userdata.m0)

ln = get(ax(3),'children');
set(ln,'ydata',userdata.mx)

ln = get(ax(2),'children');
set(ln,'ydata',userdata.my)


ln = get(ax(1),'children');
set(ln,'ydata',userdata.mz)

return
