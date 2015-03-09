///change_scene(scene, save);

//show_debug_message("change");

instance_deactivate_object(obj_parent_bubble);
instance_deactivate_object(obj_choice_parent);
var save = true;
if(argument_count>1) save = argument[1];
if(save)
{
    if(!GUI_mode)save_variables();
    else {switch_GUI_mode(false); switch_GUI_mode(true)}
}

//if(!instance_exists(obj_message_callback) && !var_screen.visible)
    with(current_scene)
    {
        last_view_x = view_xview[0];
        last_view_y = view_yview[0];
        last_zoom = view_scale;
    }

with(argument[0])
{
    var c = clicks;
    var ro = title.read_only;
    deselect_scenes(noone);
    current_scene = id;
    clicks = c;
    ro = title.read_only;
    selected = true;
    
    set_view_scale(last_zoom);
    view_xview[0] = last_view_x;
    view_yview[0] = last_view_y;
}
if(save)
{
    if(GUI_mode)save_variables();
    else {switch_GUI_mode(true); switch_GUI_mode(false)}
}

//view_xview[0] = 0;
//view_yview[0] = 0;
group_select = false;
obj_ctrl.can_group = false;
obj_ctrl.mx = mouse_x;
obj_ctrl.my = mouse_y;

for(var i=0;i<ds_list_size(current_scene.bubbles);i++)
{
    var b = current_scene.bubbles[| i];
    instance_activate_object(b);
    with(b)
    {
        switch(object_index)
        {
            case obj_bubble:
                for(var ii=0;ii<ds_list_size(choices);ii++)
                    instance_activate_object(choices[| ii]);
            break;
            case obj_condition:
                instance_activate_object(out_true);
                instance_activate_object(out_false);
            break;
            case obj_action:
                instance_activate_object(output);
            break;
            case obj_choice_bubble:
                for(var ii=0;ii<ds_list_size(choices);ii++)
                    instance_activate_object(choices[| ii].output);
            break;
        }
    }
}
