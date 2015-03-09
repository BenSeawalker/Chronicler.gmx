///create_flag(x,y,title,owner,action);
var xx,yy,t,o,a;
xx = argument0;
yy = argument1;
t = argument2;
o = argument3;
a = argument4;

with(instance_create(xx,yy,obj_flag))
{
    title = t;
        width = string_width(title)+8;
        height = string_height(title)+8;
    owner = o;
    action = a;
    
    return id;
}