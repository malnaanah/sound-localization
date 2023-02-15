function update_gui(action)
global userdata

if strcmp(action,'session_loaded')
  Total_sound_steps = floor(audioinfo([userdata.work_dir,'/m0.wav']).TotalSamples/(userdata.gcc_duration*userdata.sample_rate))-1;
  set(userdata.UI.status,'visible','off')
  set(userdata.UI.sound_pos,'visible','on')
  set(userdata.UI.sound_pos,'min',0)
  set(userdata.UI.sound_pos,'max',Total_sound_steps)
  set(userdata.UI.sound_pos,'SliderStep',[1/Total_sound_steps,1/Total_sound_steps])
  set(userdata.UI.txt.sample_rate,'string',num2str(userdata.sample_rate))
  set(userdata.UI.menu.plot, 'enable', 'on');
  set(userdata.UI.menu.set_dir, 'enable', 'off');
  set(userdata.UI.menu.start, 'enable', 'off');
  set(userdata.UI.menu.load, 'enable', 'off');
  set(userdata.UI.menu.stop, 'enable', 'on');
  for index=1:6
    set(userdata.UI.txt.mic_spc(index),'string',num2str(userdata.mic_spc(index)))
  end

  for index=1:3
    set(userdata.UI.txt.latency(index),'string',num2str(userdata.latency(index)))
  end

  %updating angles display
  for i=[1:3]
    set(userdata.UI.txt.mic_angle(i),'string',num2str(180/pi*userdata.theta(i)))
  end


elseif strcmp(action,'update_finish')
    % updating distance UI
  for index=1:3
    if userdata.gcc_ok(index)
          set(userdata.UI.txt.distance(index),'ForegroundColor','blue')
    else
          set(userdata.UI.txt.distance(index),'ForegroundColor','red')
    end
          set(userdata.UI.txt.distance(index), 'string',num2str(userdata.distance(index)-userdata.latency(index)));
  end

  set(userdata.UI.txt.current_time, 'string',time_str(userdata.sound_pos *userdata.gcc_duration));



elseif strcmp(action,'record_start')

  set(userdata.UI.menu.start, 'enable','off');
  set(userdata.UI.menu.stop, 'enable','on');
  set(userdata.UI.menu.load, 'enable','off');
  set(userdata.UI.menu.save, 'enable','off');
  set(userdata.UI.menu.set_dir, 'enable','off');
  if ~userdata.calibrated
    set(userdata.UI.status,'string','Please finish calibration to show position values.')
  end

  set(userdata.UI.txt.gcc_duration, 'enable', 'off');
  set(userdata.UI.txt.gcc_ratio, 'enable', 'off');

  % enable menus
  set(userdata.UI.menu.cal, 'enable', 'on');
  set(userdata.UI.menu.plot, 'enable', 'on');

  set(userdata.UI.txt.sample_rate, 'string',num2str(userdata.sample_rate));


elseif strcmp(action,'session_end')

  set(userdata.UI.menu.start, 'enable','on');
  set(userdata.UI.menu.stop, 'enable','off');
  set(userdata.UI.txt.gcc_duration, 'enable', 'on');
  set(userdata.UI.txt.gcc_ratio, 'enable', 'on');
  set(userdata.UI.menu.cal, 'enable', 'off');
  set(userdata.UI.menu.plot, 'enable', 'off');
  set(userdata.UI.menu.save, 'enable', 'on');
  set(userdata.UI.menu.load, 'enable', 'on');
  set(userdata.UI.menu.set_dir, 'enable','on');
  set(userdata.UI.sound_pos,'visible','off')
  set(userdata.UI.status,'visible','on')
  update_gui('program_start')

elseif strcmp(action,'calibration_finish')
    set(userdata.UI.status,'string','');
    set(userdata.UI.menu.save,'enable','on');

    %updating angles display
    for i=[1:3]
      set(userdata.UI.txt.mic_angle(i),'string',num2str(180/pi*userdata.theta(i)))
    end

elseif  strcmp(action,'pos_fail')
  for index=1:3
    set(userdata.UI.txt.position(index), 'ForegroundColor',  [.5,.5,.5]);
  end
elseif  strcmp(action,'pos_found')
  for index=1:3
    set(userdata.UI.txt.position(index), 'ForegroundColor',  'blue');
    set(userdata.UI.txt.position(index), 'string',  num2str(userdata.position(index)));
  end
elseif strcmp(action,'program_start')
  % creating session folder
  if strcmp(userdata.work_dir,'')
    [status,home_dir] = system('echo -n $HOME');
    work_dir = [home_dir,'/ssloc_session/'];
    mkdir(work_dir)
    userdata.work_dir = work_dir;
  end
  set(userdata.UI.status,'string', ['Session folder is set to ',userdata.work_dir])

elseif strcmp(action,'set_dir')
  set(userdata.UI.status,'string', ['Session folder is set to ',userdata.work_dir])
end
