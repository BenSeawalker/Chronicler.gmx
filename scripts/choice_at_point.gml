///choice_at_point(x,y);
var lst = ds_list_create();
with(obj_choice_parent)
{
    if(in_rect(argument0,argument1,x,y,width,height)) return id;
}


return noone;