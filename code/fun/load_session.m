function load_session
global userdata

current_dir = pwd();
work_dir = uigetdir(current_dir,'Choose previous work directory.');

if work_dir == 0; return;end
file_missing = 0;
if ~ exist([work_dir,'/session.data'], 'file');file_missing=1;end
if ~ exist([work_dir,'/m0.wav'], 'file');file_missing=1;end
if ~ exist([work_dir,'/mx.wav'], 'file');file_missing=1;end
if ~ exist([work_dir,'/my.wav'], 'file');file_missing=1;end
if ~ exist([work_dir,'/mz.wav'], 'file');file_missing=1;end

if file_missing;msgbox('Some sessino files are missing.');return;end

load([work_dir,'/session.data']);
userdata.work_dir = work_dir;
userdata.mic_spc = mic_spc;
userdata.latency = latency;
userdata.offline = 1;
userdata.sample_rate=audioinfo([userdata.work_dir,'/m0.wav']).SampleRate;
userdata.gcc_duration = str2num(get(userdata.UI.txt.gcc_duration,'string'));
userdata.gcc_ratio = str2num(get(userdata.UI.txt.gcc_ratio,'string'));
userdata.calibrated = 1;
userdata.theta = tetra_angles();
userdata.sound_pos=0;
update_gui('session_loaded')
update()




% msgbox('Session loaded successfully.')

return
