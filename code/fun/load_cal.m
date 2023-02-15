function load_cal
global userdata
current_dir = pwd();
[f_name,f_dir] = uigetfile(current_dir,'Choose previous work directory.');

if f_name == 0; return;end
load([f_dir,f_name]);
userdata.mic_spc = mic_spc;
userdata.latency = latency;
userdata.calibrated = 1;
userdata.theta = tetra_angles();
update_gui('calibration_finish')

for index = 1:6
    set(userdata.UI.txt.mic_spc(index),'string',num2str(userdata.mic_spc(index)))
end

for index  =1:3
    set(userdata.UI.txt.latency(index),'string',num2str(userdata.latency(index)))
end


% msgbox('Session loaded successfully.')
