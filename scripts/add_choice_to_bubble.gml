///add_choice_to_bubble(owner,choice);
var owner,c;
owner = argument0;
c = argument1;

if(owner != noone)
{
    if(owner.object_index == obj_bubble)
    {
        ds_list_insert(owner.choices,ds_list_size(owner.choices)-1,c);
        
        //handle bubble size
        owner.minwidth = max(180,30+owner.choices[| 0].minwidth*ds_list_size(owner.choices));
        owner.targetwidth = max(owner.targetwidth,owner.minwidth);
    }
    else
    {
        ds_list_add(owner.choices,c);
    }
}
