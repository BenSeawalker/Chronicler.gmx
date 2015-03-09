///create_scene(x,y,title,editable);
var xx,yy,t,ed;
xx = argument0;
yy = argument1;
t = argument2;
ed = argument3;

with(instance_create(xx,yy,obj_scene))
{
    title.text = t;
    editable = ed;
    
    minwidth = string_width(t) + 16;
    minheight = string_height(t) + 16;
    maxwidth = minwidth + 8;
    maxheight = minheight + 8;
    
    return id;
}
