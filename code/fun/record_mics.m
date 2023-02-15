function record_mics()
global userdata

%close any previously opened file
fclose('all');

[status,cmd_path] = system('which gst-launch-1.0');

if strcmp(cmd_path,'')
  figure(msgbox('Please install gst-launch-1.0'));
  return
end


userdata.recording = 1;
userdata.offline = 0;

% reset matreces to avoid errors when changing GCC duration
userdata.m0=[];
userdata.mx=[];
userdata.my=[];
userdata.mz=[];

userdata.gcc_x=[];
userdata.gcc_y=[];
userdata.gcc_z=[];

userdata.GCC_X=[];
userdata.GCC_Y=[];
userdata.GCC_Z=[];

userdata.sound_pos=0;

userdata.gcc_ratio = str2num(get(userdata.UI.txt.gcc_ratio, 'string'));
userdata.gcc_duration = str2num(get(userdata.UI.txt.gcc_duration, 'string'));
userdata.gcc_length = round(userdata.gcc_duration * userdata.sample_rate);

update_gui('program_start')

CMD ="killall gst-launch-1.0";
system (CMD);

CMD = cstrcat( "gst-launch-1.0 ", ...
"alsasrc  device=hw:1,0  ! audioconvert ! audioresample ! wavenc ! filesink location=", userdata.work_dir, "/m0.wav " , ...
"alsasrc  device=hw:2,0  ! audioconvert ! audioresample ! wavenc ! filesink location=", userdata.work_dir, "/mx.wav " , ...
"alsasrc  device=hw:3,0  ! audioconvert ! audioresample ! wavenc ! filesink location=", userdata.work_dir, "/my.wav ", ...
"alsasrc  device=hw:4,0  ! audioconvert ! audioresample ! wavenc ! filesink location=", userdata.work_dir, "/mz.wav ", ...
"1>/dev/null 2>", userdata.work_dir,"/gst-launch.error --no-position -e &");
system (CMD);
pause(0.2);
ERR = fileread([userdata.work_dir,'/gst-launch.error']);

if strfind(ERR,'ERROR')
  msgbox(["gstreamer recording error:\n",ERR])
  CMD ="killall gst-launch-1.0";
  system (CMD);
  end_session();
  return;
end


ERR = 1
while ERR
  try
    userdata.sample_rate=audioinfo([userdata.work_dir,'/m0.wav']).SampleRate;
%     tic
%     usrdata.toc = toc;
    ERR = 0;
  catch
    disp('Audio files not saved yet, waiting');
    pause(userdata.gcc_duration)
    ERR = 1;
  end
end



update_gui('record_start')


while userdata.recording
  update()
  drawnow
end

CMD ="killall gst-launch-1.0";
system (CMD);

end
