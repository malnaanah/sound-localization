function end_session
global userdata
if userdata.offline
  userdata.work_dir = '';
end
userdata.recording=0;
userdata.offline=0;
update_gui('session_end')
end
