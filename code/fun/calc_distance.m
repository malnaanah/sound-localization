function calc_distance()
global userdata

SHFT = ceil(max(size(userdata.gcc_x)/2));

[val,index]= max(userdata.gcc_x);
if val > userdata.gcc_ratio*mean(userdata.gcc_x)
    userdata.distance(1)=index - SHFT;
    userdata.gcc_ok(1) = 1;
else
    userdata.gcc_ok(1) = 0;
end

[val,index]= max(userdata.gcc_y);
if val > userdata.gcc_ratio*mean(userdata.gcc_y)
    userdata.distance(2)=index - SHFT;
   userdata.gcc_ok(2) = 1;
else
    userdata.gcc_ok(2) = 0;
end

[val,index]= max(userdata.gcc_z);
if val > userdata.gcc_ratio*mean(userdata.gcc_z)
    userdata.distance(3)=index - SHFT;
    userdata.gcc_ok(3) = 1;
else
    userdata.gcc_ok(3) = 0;
end


userdata.distance = (userdata.distance ./ userdata.sample_rate ) * userdata.sound_speed;

return
