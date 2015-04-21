///create_variable(group,type,name,value,editable);

//if(string_length(argument2) || string_length(argument3))
//{
    with(instance_create(0,0,obj_variable))
    {
        type = argument1;
            if(type == vartype_title || type == vartype_author) rows = 1;
            //if(type == vartype_temp) ds_list_add(current_scene.tempvars,id);
        name.text = argument2;
        last_name = argument2;
        value.text = argument3;
        editable = argument4;
        
        //show_debug_message("creating: "+name.text+" "+value.text);
        
        add_variable(argument0,id);
        
        return id;
    }
//}

return noone;
