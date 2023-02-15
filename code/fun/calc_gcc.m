function calc_gcc()
global userdata

if userdata.cal_mics
  userdata.gcc_x = GCC(userdata.my,userdata.mx);
  userdata.gcc_y = GCC(userdata.mz,userdata.mx);
  userdata.gcc_z = GCC(userdata.mz,userdata.my);
else
  userdata.gcc_x = GCC(userdata.m0,userdata.mx);
  userdata.gcc_y = GCC(userdata.m0,userdata.my);
  userdata.gcc_z = GCC(userdata.m0,userdata.mz);
end
return
