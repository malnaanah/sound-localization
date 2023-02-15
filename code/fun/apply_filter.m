function apply_filter()
global userdata
% adjusting average value of recorded waveforms to zero
userdata.m0 = userdata.m0-mean(userdata.m0);
userdata.mx = userdata.mx-mean(userdata.mx);
userdata.my = userdata.my-mean(userdata.my);
userdata.mz = userdata.mz-mean(userdata.mz);

return
