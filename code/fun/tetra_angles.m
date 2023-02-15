% Angles made by tetrahedron of mic positions in radian
% theta(1) rotation of y-vector around z- axis
% theta(2) rotation of z-vector around y-axis
% theta(3) rotation of z-vector around z-axis

function [theta] = tetra_angles()
global userdata
theta = [0,0,0];
dx0 = userdata.mic_spc(1);
dy0 = userdata.mic_spc(2);
dz0 = userdata.mic_spc(3);
dxy = userdata.mic_spc(4);
dxz = userdata.mic_spc(5);
dyz = userdata.mic_spc(6);

% using law of cosine
% link; https://muthu.co/using-the-law-of-cosines-and-vector-dot-product-formula-to-find-the-angle-between-three-points/
% finding angle beteen tetrahedron base vectors
theta_xy = acos((dx0^2+dy0^2-dxy^2)/(2*(dx0*dy0)));


% finding the volume of the tetrahedron using Cayley-Menger Determinant
% link:https://mathworld.wolfram.com/Cayley-MengerDeterminant.html
mat = [ 0,    1,    1,    1,    1; ...
        1,    0,  dx0,  dy0,  dz0; ...
        1,  dx0,    0,  dxy,  dxz; ...
        1,  dy0,  dxy,    0,  dyz; ...
        1,  dz0,  dxz,  dyz,  0];
mat = mat .^ 2;
vol = sqrt(1/288 * det(mat));

% finding the vertical angel for z-vectro using other law for tetrahedron volume
% https://www.youtube.com/watch?v=xDGsafxeujE
theta(2) = acos(6*vol/(dx0*dy0*sin(theta_xy)*dz0)); % vertical z-vector angle

% finding z-vector x,y,and z coordinates
% link: https://math.stackexchange.com/questions/4533275/finding-azimuth-and-zenith-angles-for-tetrahedron
theta_xz = acos((dx0^2+dz0^2-dxz^2)/(2*(dx0*dz0)));
z_x = cos(theta_xz)*dz0;
z_z = cos(theta(2))*dz0;
z_y = sqrt(dz0^2 - z_x^2 - z_z^2);


% finding if y is negative or positive by finding projection of the negative and positive value on the y-vector.
[phi_1,r1] = cart2pol(z_x,-z_y);
[phi_2,r2] = cart2pol(z_x,z_y);

theta_yz = acos((dy0^2+dz0^2-dyz^2)/(2*(dy0*dz0)));
dist_yz = cos(theta_yz)*dz0;
% finding z-vector horizontal (azimuth) angle
dist_r1 = r1*cos(theta_xy - phi_1);
dist_r2 = r2*cos(theta_xy - phi_2);

dist_diff = abs([dist_yz-dist_r1, dist_yz-dist_r2]);
[val,index]=min(dist_diff);
z_y = z_y * (2*index-3);

[theta(3),rx] = cart2pol(z_x,z_y);
theta(1) = theta_xy - pi/2;
return
