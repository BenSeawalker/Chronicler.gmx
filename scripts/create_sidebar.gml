///create_sidebar(x,y,title,left);

var xx,yy,t,l;
xx = argument0;
yy = argument1;
t = argument2;
l = argument3;

with(instance_create(xx,yy,obj_sidebar))
{
    title = t;
    sminw = string_width(title)+8;
    smaxw = sminw+6;
    
    left = l;
    
    return id;
}