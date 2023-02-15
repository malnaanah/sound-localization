function calibrate(action)
global userdata
global dialog_choise
dialog_choise='';

if strcmp(action,'x-axis')
    str1 = 'x-mic';
    str2 = 'origin-mic';
    data_index=1;
elseif strcmp(action,'y-axis')
    str1 = 'y-mic';
    str2 = 'origin-mic';
    data_index=2;
elseif strcmp(action,'z-axis')
    str1 = 'z-mic';
    str2 = 'origin-mic';
    data_index=3;
elseif strcmp(action,'xy-mics')
    str1 = 'x-mic';
    str2 = 'y-mic';
    data_index=1;
    userdata.cal_mics = 1;
elseif strcmp(action,'xz-mics')
    str1 = 'x-mic';
    str2 = 'z-mic';
    data_index=2;
    userdata.cal_mics = 1;
elseif strcmp(action,'yz-mics')
    str1 = 'y-mic';
    str2 = 'z-mic';
    data_index=3;
    userdata.cal_mics = 1;
end


dialog_fig(['Place sound near ',str1,' pointing to ',str2,' and press Ok'], 'Calibrating',{'Ok','Cancel'});
while strcmp(dialog_choise,'')
    update()
    drawnow
end
button = dialog_choise;
dialog_choise = '';
if strcmp(button,'Cancel'); return;end
dis_positve = zeros(1,7);
n=1;
while n <= 7
    update()
    drawnow;
    if userdata.gcc_ok(data_index)
        dis_positve(n) = userdata.distance(data_index);
        n = n+1;
    else
        continue
    end
end


dialog_fig(['Place sound near ',str2,' pointing to ',str1,' and press Ok'], 'Calibrating',{'Ok','Cancel'});
while strcmp(dialog_choise,'')
    update()
    drawnow
end
button = dialog_choise;

dialog_choise = '';

if strcmp(button,'Cancel'); return;end

dist_negative = zeros(1,7);
n =1;
while n <= 7
    update()
    drawnow;
    if userdata.gcc_ok(data_index)
        dist_negative(n) = userdata.distance(data_index);
        n = n+1;
    else
        continue
    end
end


latency = (dis_positve + dist_negative) /2;
spacing = (dis_positve - dist_negative)/2;

latency = median(latency);
spacing = median(spacing);


dialog_fig(['Latency = ',num2str(latency),'. Spacing = ',num2str(spacing),'.'], 'Calibrating',{'Accept','Retry','Cancel'});
while strcmp(dialog_choise,'')
    update()
    drawnow
end
button = dialog_choise;
dialog_choise = '';

if strcmp(button,'Cancel')
    return
elseif strcmp(button,'Retry')
    calibrate(action)
    return
end



if  strfind (action,'-mics')
    userdata.mic_spc(data_index+3) = spacing;
    set(userdata.UI.txt.mic_spc(data_index+3),'string',num2str(spacing))
    userdata.latency(data_index+3) = latency;
else
    userdata.mic_spc(data_index) = spacing;
    set(userdata.UI.txt.mic_spc(data_index),'string',num2str(spacing))
    userdata.latency(data_index) = latency;
    set(userdata.UI.txt.latency(data_index),'string',num2str(latency))
end

userdata.cal_mics = 0;

% Check if calibration is done
for i=1:6
    if ~isempty(strfind(get(userdata.UI.txt.mic_spc(i),'string'),'?'));return;end;
end

for i=1:3
    if ~isempty(strfind(get(userdata.UI.txt.latency(i),'string'),'?'));return;end;
end


userdata.calibrated = 1;
userdata.theta = tetra_angles();
update_gui('calibration_finish')
