///bubble_at_point(x,y);
var lst = ds_list_create();
with(obj_parent_bubble)
{
    var ib = (object_index==obj_bubble);
    
    if(in_rect(argument0,argument1,x,y-(30*ib),width,height+(30*ib))) return id;
}

return noone;