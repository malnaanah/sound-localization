function str_out=time_str(s)
h = floor(s/(60*60));
s = s - h*60*60;

m = floor(s/60);
s = s - m*60;


str_out = [num2str(h),':',num2str(m),':',num2str(s)];
return




