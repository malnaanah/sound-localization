function set_dir
global userdata
work_dir = uigetdir(userdata.work_dir,'Choose session directory');
if ~strcmp(work_dir,'');
  userdata.work_dir = work_dir;
  update_gui('set_dir')
end

