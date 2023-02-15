function update()

    global userdata;
    if userdata.offline
      userdata.sound_pos = floor(get(userdata.UI.sound_pos,'value'));
    end

    n1 = userdata.sound_pos * userdata.gcc_duration * userdata.sample_rate + 1;
    n2 = (userdata.sound_pos+1) * userdata.gcc_duration * userdata.sample_rate;
    ERR = true;
    while ERR
      try
        % adjust to real time
%         while (toc-userdata.toc)<(userdata.sound_pos+2)*userdata.gcc_duration;puase (userdata.gcc_duration);end
        userdata.m0 = audioread([userdata.work_dir,'/m0.wav'], [n1,n2]);
        userdata.mx = audioread([userdata.work_dir,'/mx.wav'], [n1,n2]);
        userdata.my = audioread([userdata.work_dir,'/my.wav'], [n1,n2]);
        userdata.mz = audioread([userdata.work_dir,'/mz.wav'], [n1,n2]);
        ERR=false;
      catch
%         disp(['file end reached on position ',num2str(userdata.sound_pos)])
        if userdata.offline;return;end
        pause(userdata.gcc_duration) % delay until the enough audio is recorded
      end
    end

    if ~userdata.offline
      userdata.sound_pos = userdata.sound_pos+1;
    end


    apply_filter();
    calc_gcc();
    calc_distance();
    calc_pos();
    plot_gcc('refresh')
    plot_wav('refresh')
    plot_hyp('refresh')

  update_gui('update_finish')

return

