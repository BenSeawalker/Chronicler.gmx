///create_variable(group,type,name,value,editable);
with(instance_create(0,0,obj_variable))
{
    type = argument1;
        if(type == vartype_title || type == vartype_author) rows = 1;
        if(type == vartype_temp) ds_list_add(current_scene.tempvars,id);
    name.text = argument2;
    value.text = argument3;
    editable = argument4;
    
    ds_list_add(argument0.vars,id);
    
    return id;
}

return noone;
