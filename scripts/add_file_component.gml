///add_file_component(file_menu,left,sprite,image_index,action,title)
var fm,lrc,spr,ind,act,t;
fm = argument0;
lrc = argument1;
spr = argument2;
ind = argument3;
act = argument4;
t = argument5;

with(instance_create(0,0,obj_file_component))
{
    switch(lrc)
    {
        case fm_left:
            ds_list_add(fm.left,id);
        break;
        case fm_right:
            ds_list_add(fm.right,id);
        break;
        case fm_center:
            ds_list_add(fm.center,id);
        break;
    }
        
        
    sprite_index = spr;
    image_index = ind;
    action = act;
    title = t;
}
