function save_session()
global userdata

if ~userdata.calibrated
  figure(msgbox('Please complete calibration.'))
  return
end
mic_spc = userdata.mic_spc;
latency = userdata.latency;
save([userdata.work_dir,'/session.data'],'mic_spc','latency')
figure(msgbox('Calibration data is save in session folder.'))
