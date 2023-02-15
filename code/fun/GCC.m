function gcc_out = GCC(m1,m2)
M0 = fft(m1);
M = fft(m2);
COR =  M0 .* conj(M) ;
userdata.GCC_X = COR;
COR = COR ./ (abs(COR) + eps);
gcc_out = fftshift(abs(ifft(COR)));
return
