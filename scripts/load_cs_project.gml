var path = get_open_filename("ChoiceScript|startup.txt","startup.txt");

if(path != "")
{
    obj_ctrl.alarm[1] = room_speed*60;
    clear_project();
    switch_GUI_mode(false);
    
    gamevars = "";
    with(obj_parent_bubble)instance_destroy();
    
    var csdata = cs_to_data(path,true);
    
    cs_proc_data(csdata,0,0,true);
    
    cs_proc_stats(path);
    
    cs_proc_scenes(csdata,path);
    
    cs_cleanup(csdata);
    
    save_variables();
    switch_GUI_mode(true);
}
