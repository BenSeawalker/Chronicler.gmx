if(GUI_mode)
{
    set_view_scale(1);
    instance_deactivate_all(false);
    instance_activate_object(obj_ctrl);
    instance_activate_object(var_screen);
    instance_activate_object(obj_variable);
    instance_activate_object(obj_scene);
    instance_activate_object(obj_file_menu);
    
    var_screen.x = view_xview[0]+view_wview[0]/2-obj_variable.width/2;
    var_screen.y = view_yview[0]+100;
    var_screen.visible = true;
}
else
{
    create_message_callback((view_wview[0]/5),0,(view_wview[0]/5)*3,view_hview[0],gamevars,obj_ctrl,0);
}