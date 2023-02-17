% Hyperboloid function with axis rotation
% see link:
% https://www.coursehero.com/study-guides/boundless-algebra/the-hyperbola/
% https://en.wikipedia.org/wiki/Rotation_of_axes
% rotation equation for rotating x-y plane around the z-axis:
% x' = x*cos(theta) + y*sin(theta)
% y' = -x*sin(theta) + y*cos(theta)

% Notice: the origin of the hyperboloids is shifted

function f=hyper(pnt)
global userdata


a = userdata.distance-userdata.latency(1:3);
c = userdata.mic_spc(1:3);

f= [0,0,0];

theta_yh = userdata.theta(1);
theta_zv = userdata.theta(2);
#theta_zh = -userdata.theta(3);
theta_zh = userdata.theta(3);

f(1) = sqrt( pnt(1)^2+pnt(2)^2+pnt(3)^2) - sqrt( (pnt(1) -c(1))^2+pnt(2)^2+pnt(3)^2) - a(1);


% rotating y-axis hyperboloid around z-axis
x = pnt(1)*cos(theta_yh) + pnt(2)*sin(theta_yh);
y = -pnt(1)*sin(theta_yh) + pnt(2)*cos(theta_yh);
z = pnt(3);

f(2) = sqrt( x^2+y^2+z^2) - sqrt( x^2+(y -c(2))^2+z^2) - a(2);

% rotating z-axis hyperboloid around y-axis
z = pnt(3)*cos(theta_zv) + pnt(1)*sin(theta_zv);
x = - pnt(3)*sin(theta_zv) + pnt(1)*cos(theta_zv);
y = pnt(2);


% rotating z-axis hyperboloid around z-axis
xx = x*cos(theta_zh) + y*sin(theta_zh);
yy = -x*sin(theta_zh) + y*cos(theta_zh);
zz = z;

f(3) = sqrt( xx^2+yy^2+zz^2) - sqrt( xx^2+yy^2+(zz-c(3))^2) - a(3);

return
