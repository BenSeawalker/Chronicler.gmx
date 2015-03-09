///in_ellipse(point_x,point_y,ellipse_x,ellipse_y,rad_x,rad_y)
var xx,yy,h,k,rx,ry;
xx = argument0;
yy = argument1;
h = argument2;
k = argument3;
rx = argument4;
ry = argument5;

if(rx && ry)
    if(((sqr(xx-h)/sqr(rx))+((sqr(yy-k)/sqr(ry)))) <= 1) return true;

return false;
