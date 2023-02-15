% see link for two sheet parametric Hyperboloid
% link: https://mathworld.wolfram.com/Two-SheetedHyperboloid.html

function plot_hyp(action)
global userdata

if nargin==0; action='refresh';end

fig=findobj('tag','hyp_plot');
if isempty(fig) && strcmp(action,'refresh');return;end


c = userdata.mic_spc(1:3)/2;
a = (userdata.distance-userdata.latency(1:3))/2;

% a = a .* (abs(a)< c) + c .* (abs(a)>=c) .* sign(a);
b= sqrt(c .^ 2 - a .^ 2);

steps = 20;

% creating data for hyperboloid surfaces
u =linspace(0,3,steps);
v =linspace(0,2*pi,steps);
x =  cosh(u)' * (v*0 + 1);
y = sinh(u)' * cos(v);
z =  sinh(u)' * sin(v);
%     z =  cosh(u)' * ones(v);
% z =  cosh(u)' * (v*0 + 1);







if isempty(fig) && strcmp(action,'create')
    fig = figure('tag','hyp_plot','name', 'Hyperboloids');
    hold on

    set(0, 'CurrentFigure', fig)
    plt(1) = surf(x,y,z);
    plt(2) = surf(z,x,y);
    plt(3) = surf(y,z,x);
    linewidth = 6;
    plt(4) = plot3([0,0],[0,0],[0,0],'linewidth',linewidth);
    plt(5) = plot3([0,0],[0,0],[0,0],'linewidth',linewidth);
    plt(6) = plot3([0,0],[0,0],[0,0],'linewidth',linewidth);
    lmt = 1.5;
    linewidth = 3;
    plot3([-lmt,lmt],[0,0],[0,0],'linewidth',linewidth);
    plot3([0,0],[-lmt,lmt],[0,0],'linewidth',linewidth);
    plot3([0,0],[0,0],[-lmt,lmt],'linewidth',linewidth);
    hold off
    set(fig,'userdata',plt);
end




% shading interp;
colormap (cool)

ax = get(fig,'children');
set(ax,'xlabel','X-Axis')
set(ax,'ylabel','Y-Axis')
set(ax,'zlabel','Z-Axis')
set(ax, 'dataaspectratio', [1,1,1])

plt = get(fig,'userdata');

% X-axis============
xx = x *a(1) + c(1);
yy = y * b(1);
zz = z * b(1);
set(plt(1),'xdata', xx);
set(plt(1),'ydata', yy);
set(plt(1),'zdata', zz);

% Y=axis ============
yy = x * a(2) + c(2);
zz = y * b(2);
xx = z * b(2);

% apply rotation
rot_mat = rotz(userdata.theta(1)*180/pi);
for row=1:steps
  for col=1:steps
    tmp_mat= rot_mat * [xx(row,col);yy(row,col);zz(row,col)];
    xx(row,col) = tmp_mat(1);
    yy(row,col) = tmp_mat(2);
    zz(row,col) = tmp_mat(3);
  end
end

set(plt(2),'xdata', xx);
set(plt(2),'ydata', yy);
set(plt(2),'zdata', zz);


% Z-axis ============
zz = x * a(3)+ c(3);
xx = y * b(3);
yy = z * b(3);

% apply first rotation
rot_mat = roty(userdata.theta(2)*180/pi);
for row=1:steps
  for col=1:steps
    tmp_mat= rot_mat * [xx(row,col);yy(row,col);zz(row,col)];
    xx(row,col) = tmp_mat(1);
    yy(row,col) = tmp_mat(2);
    zz(row,col) = tmp_mat(3);
  end
end

% apply second rotation
rot_mat = rotz(userdata.theta(3)*180/pi);
for row=1:steps
  for col=1:steps
    tmp_mat= rot_mat * [xx(row,col);yy(row,col);zz(row,col)];
    xx(row,col) = tmp_mat(1);
    yy(row,col) = tmp_mat(2);
    zz(row,col) = tmp_mat(3);
  end
end

set(plt(3),'xdata', xx);
set(plt(3),'ydata', yy);
set(plt(3),'zdata', zz);


if userdata.pos_found
      set(plt(4),'visible','on')
      set(plt(5),'visible','on')
      set(plt(6),'visible','on')

    marker_width = abs(diff(get(plt(4),'xlim')))/10;
    marker_width = 0.5;
    ln=[userdata.position;userdata.position];

    ln_x =ln + [[-marker_width,0,0];[marker_width,0,0]];
    set(plt(4),'xdata',ln_x(:,1))
    set(plt(4),'ydata',ln_x(:,2))
    set(plt(4),'zdata',ln_x(:,3))

    ln_y =ln + [[0,-marker_width,0];[0,marker_width,0]];
    set(plt(5),'xdata',ln_y(:,1))
    set(plt(5),'ydata',ln_y(:,2))
    set(plt(5),'zdata',ln_y(:,3))

    ln_z =ln + [[0,0,-marker_width];[0,0,marker_width]];
    set(plt(6),'xdata',ln_z(:,1))
    set(plt(6),'ydata',ln_z(:,2))
    set(plt(6),'zdata',ln_z(:,3))
else
      set(plt(4),'visible','off')
      set(plt(5),'visible','off')
      set(plt(6),'visible','off')
end

return





