function init_gui()
close all;
clear all;
Font_Size = 8;
fig=findobj('tag','sslocal_gui');
if ~ isempty(fig); figure(fig);return;end


fig_w = 800;
fig_h = 300;
ui_spacing = 0.01;

fig=figure('tag', 'sslocal_gui', ...
'name', 'Sound Source Localization Project',...
'DefaultUIControlFontSize', Font_Size, ...
%   'resize', 'off', ...
'ToolBar', 'none', ... % disable default toolbar
'MenuBar','none',...
'position', [100,100, fig_w,fig_h]);

menu_session = uimenu(fig,'label','Session');
menu_start = uimenu(menu_session,'label','Start recording', 'callback','record_mics');
menu_load = uimenu(menu_session,'label','Load session','callback','load_session');
menu_stop = uimenu(menu_session,'label','End session','enable','off', 'callback','end_session');
menu_set_dir = uimenu(menu_session,'label','Set session directory','callback','set_dir');


menu_cal = uimenu(fig,'label','Calebration','enable','off');
menu_cal_x_axis = uimenu( menu_cal,'label','Destance and latency in X-axis','checked','off','callback','calibrate(''x-axis'')');
menu_cal_y_axis = uimenu( menu_cal,'label','Destance and latency in Y-axis','checked','off','callback','calibrate(''y-axis'')');
menu_cal_z_axis = uimenu( menu_cal,'label','Destance and latency in Z-axis','checked','off','callback','calibrate(''z-axis'')');
menu_cal_xy_mics = uimenu( menu_cal,'label','Destance between X-Y mics','checked','off','callback','calibrate(''xy-mics'')');
menu_cal_xz_mics = uimenu( menu_cal,'label','Destance between X-Z mics','checked','off','callback','calibrate(''xz-mics'')');
menu_cal_yz_mics = uimenu( menu_cal,'label','Destance between Y-Z mics','checked','off','callback','calibrate(''yz-mics'')');
menu_cal_load = uimenu(menu_cal,'label','Load calibration','enable','on', 'callback','load_cal');
menu_cal_save = uimenu(menu_cal,'label','Save calibration','enable','off', 'callback','save_session');

menu_plot = uimenu( fig,'label','Plot','enable','off');
menu_plot_waves = uimenu( menu_plot,'label','Sounds', 'callback','plot_wav(''create'')');
menu_plot_gcc = uimenu( menu_plot,'label','GCC', 'callback','plot_gcc(''create'')');
menu_plot_hyperboloid = uimenu( menu_plot,'label','Hyperboloid', 'callback','plot_hyp(''create'')');

menu_help = uimenu( fig,'label','Help');
menu_help_about = uimenu( menu_help,'label','About','callback','about');

pnl_btm = ui_spacing; % bottom position of panels
pnl_h = 1/6-2*ui_spacing;
pnl_w = 1-2*ui_spacing;
pnl_left = ui_spacing;
pnl = uipanel('Parent',fig,'BorderType', 'line','BorderWidth', 2, 'FontSize', Font_Size,'Title', 'Info/Time slider', 'units', 'Normalized', 'position',[pnl_left,pnl_btm,pnl_w,pnl_h]);
lbl_status=uicontrol(pnl,'style','text','FontSize',12,'Units','Normalized','position',[ui_spacing,ui_spacing,1-2*ui_spacing,1-2*ui_spacing],'string','');
sldr_sound_pos = uicontrol (pnl,'style', 'slider','visible','off','units', 'normalized','position',[ui_spacing,ui_spacing,1-2*ui_spacing,1-2*ui_spacing],'callback','update');


pnl_cnt=7;

pnl_btm = 1/6 + ui_spacing; % bottom position of panels
pnl_h = 5/6-2*ui_spacing;
pnl_w = 1/pnl_cnt-2*ui_spacing;
pnl_left = ui_spacing;
pnl = uipanel('Parent',fig,'BorderType', 'line','BorderWidth', 2, 'FontSize', Font_Size,'Title', 'Variables', 'units', 'Normalized', 'position',[pnl_left,pnl_btm,pnl_w,pnl_h]);
ui_cnt = 8;
ui_left = ui_spacing;
ui_btm = 1-1/ui_cnt+ui_spacing;
ui_w = 1-2*ui_spacing;
ui_h = 1/ui_cnt-2*ui_spacing;
uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','Sample duration');ui_btm = ui_btm-1/ui_cnt;
gcc_dur = uicontrol(pnl,'style','edit','BackgroundColor','cyan','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','0.5'); ui_btm = ui_btm-1/ui_cnt;
uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','GCC Ratio'); ui_btm = ui_btm-1/ui_cnt;
gcc_ratio = uicontrol(pnl,'style','edit','BackgroundColor','cyan','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','10'); ui_btm = ui_btm-1/ui_cnt;
uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','Sampling Rate'); ui_btm = ui_btm-1/ui_cnt;
sample_rate = uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','?????'); ui_btm = ui_btm-1/ui_cnt;
uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','Current Time'); ui_btm = ui_btm-1/ui_cnt;
current_time = uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','?????');


pnl_left = pnl_left + 1/pnl_cnt;
pnl = uipanel('Parent',fig,'BorderType', 'line','BorderWidth', 2, 'FontSize', Font_Size,'Title', 'Distance difference', 'units', 'Normalized', 'position',[pnl_left,pnl_btm,pnl_w,pnl_h]);
ui_cnt = 6;
ui_btm = 1-1/ui_cnt+ui_spacing;
uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','X-Axis');ui_btm = ui_btm-1/ui_cnt;
dst_x = uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','?????');ui_btm = ui_btm-1/ui_cnt;
uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','Y-Axis');ui_btm = ui_btm-1/ui_cnt;
dst_y = uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','?????');ui_btm = ui_btm-1/ui_cnt;
uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','Z-Axis');ui_btm = ui_btm-1/ui_cnt;
dst_z = uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','?????');



pnl_left = pnl_left + 1/pnl_cnt;
pnl = uipanel('Parent',fig,'BorderType', 'line','BorderWidth', 2, 'FontSize', Font_Size,'Title', 'Latency as distance', 'units', 'Normalized', 'position',[pnl_left,pnl_btm,pnl_w,pnl_h]);
ui_cnt = 6;
ui_btm = 1-1/ui_cnt+ui_spacing;
uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','X-Axis');ui_btm = ui_btm-1/ui_cnt;
lat_x = uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','?????');ui_btm = ui_btm-1/ui_cnt;
uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','Y-Axis');ui_btm = ui_btm-1/ui_cnt;
lat_y = uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','?????');ui_btm = ui_btm-1/ui_cnt;
uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','Z-Axis');ui_btm = ui_btm-1/ui_cnt;
lat_z = uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','?????');


pnl_left = pnl_left + 1/pnl_cnt;
pnl = uipanel('Parent',fig,'BorderType', 'line','BorderWidth', 2, 'FontSize', Font_Size,'Title', 'Mic-origin spacing', 'units', 'Normalized', 'position',[pnl_left,pnl_btm,pnl_w,pnl_h]);
ui_cnt = 6;
ui_btm = 1-1/ui_cnt+ui_spacing;
uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','X-Axis');ui_btm = ui_btm-1/ui_cnt;
mic_spc_x = uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','?????');ui_btm = ui_btm-1/ui_cnt;
uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','Y-Axis');ui_btm = ui_btm-1/ui_cnt;
mic_spc_y = uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','?????');ui_btm = ui_btm-1/ui_cnt;
uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','Z-Axis');ui_btm = ui_btm-1/ui_cnt;
mic_spc_z = uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','?????');



pnl_left = pnl_left + 1/pnl_cnt;
pnl = uipanel('Parent',fig,'BorderType', 'line','BorderWidth', 2, 'FontSize', Font_Size,'Title', 'Mic-mic spacing', 'units', 'Normalized', 'position',[pnl_left,pnl_btm,pnl_w,pnl_h]);
ui_cnt = 6;
ui_btm = 1-1/ui_cnt+ui_spacing;
uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','X-Y mics');ui_btm = ui_btm-1/ui_cnt;
mic_spc_xy = uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','?????');ui_btm = ui_btm-1/ui_cnt;
uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','X-Z mics');ui_btm = ui_btm-1/ui_cnt;
mic_spc_xz = uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','?????');ui_btm = ui_btm-1/ui_cnt;
uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','Y-Z mics');ui_btm = ui_btm-1/ui_cnt;
mic_spc_yz = uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','?????');



pnl_left = pnl_left + 1/pnl_cnt;
pnl = uipanel('Parent',fig,'BorderType', 'line','BorderWidth', 2, 'FontSize', Font_Size,'Title', 'Mic Angles', 'units', 'Normalized', 'position',[pnl_left,pnl_btm,pnl_w,pnl_h]);
ui_cnt = 6;
ui_btm = 1-1/ui_cnt+ui_spacing;
uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','θY Horizontal');ui_btm = ui_btm-1/ui_cnt;
mic_angle_yh = uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','?????');ui_btm = ui_btm-1/ui_cnt;
uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','θZ Vertical');ui_btm = ui_btm-1/ui_cnt;
mic_angle_zh = uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','?????');ui_btm = ui_btm-1/ui_cnt;
uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','θZ Horizontal');ui_btm = ui_btm-1/ui_cnt;
mic_angle_zv = uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','?????');



pnl_left = pnl_left + 1/pnl_cnt;
pnl = uipanel('Parent',fig,'BorderType', 'line','BorderWidth', 2, 'FontSize', Font_Size,'Title', 'Position cordinates', 'units', 'Normalized', 'position',[pnl_left,pnl_btm,pnl_w,pnl_h]);
ui_cnt = 6;
ui_btm = 1-1/ui_cnt+ui_spacing;
uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','X-Axis');ui_btm = ui_btm-1/ui_cnt;
pos_x = uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','?????');ui_btm = ui_btm-1/ui_cnt;
uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','Y-Axis');ui_btm = ui_btm-1/ui_cnt;
pos_y = uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','?????');ui_btm = ui_btm-1/ui_cnt;
uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','Z-Axis');ui_btm = ui_btm-1/ui_cnt;
pos_z = uicontrol(pnl,'style','text','units','Normalized','position',[ui_left,ui_btm,ui_w,ui_h],'string','?????');







% store userdata
user_data = struct('m0',[],'mx',[],'my',[],'mz',[],'sample_rate',[0], ...
'gcc_x' ,[],'gcc_y' ,[],'gcc_z', [],'GCC_X',[],'GCC_Y',[],'GCC_Z',[],'rec_dur',[50], ...
'mic_spc',[0,0,0,0,0,0],'latency',[0,0,0],'distance',[0,0,0],'sound_speed',[340.29],'position',[0,0,0],'theta',[0,0,0], ...
'gcc_ok',[0,0,0],'gcc_span',[1000],'refresh_t',[0],'work_dir','','cal_mics',[0],'pos_found',[0], ...
'gcc_duration',[0],'gcc_ratio',[0],'gcc_length',[],'sound_pos',[0],'recording',[0],'calibrated',[0],'offline',[0],'tic',0);

UI.menu = struct('start',[menu_start],...
'stop',[menu_stop],...
'save',[menu_cal_save],...
'load',[menu_load],...
'set_dir',[menu_set_dir],...
'plot',[menu_plot],...
'cal',[menu_cal]);

UI.txt = struct('distance',[dst_x,dst_y,dst_z], ...
        'mic_spc',[mic_spc_x,mic_spc_y,mic_spc_z,mic_spc_xy,mic_spc_xz,mic_spc_yz],...
        'mic_angle',[mic_angle_yh,mic_angle_zh,mic_angle_zv],...
        'latency',[lat_x,lat_y,lat_z],...
        'position',[pos_x,pos_y,pos_z], ...
        'gcc_duration',[gcc_dur],...
        'gcc_ratio',[gcc_ratio],...
        'sample_rate',[sample_rate],...
        'current_time',[current_time]);
UI.status = lbl_status;
UI.sound_pos  = sldr_sound_pos;


user_data.UI = UI;
figure(fig);
global userdata = user_data;

% update_gui('program_start')
return
