function calc_pos()
global userdata

a = userdata.distance-userdata.latency(1:3);
c = userdata.mic_spc(1:3);

% a = a .* (abs(a)<c) + (c .* (abs(a)>=c) .* sign(a));


if ~userdata.calibrated;return;end

if ~all(userdata.gcc_ok) || any(abs(a) > c)
  userdata.pos_found = 0;
  update_gui('pos_fail')
  return
end


init_val = c + a;
userdata.position = fsolve("hyper",init_val);
userdata.pos_found = 1;
update_gui('pos_found')

return
