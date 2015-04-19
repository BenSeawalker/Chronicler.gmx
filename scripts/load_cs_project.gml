var path = get_open_filename("ChoiceScript|*.txt","startup.txt");

if(path != "")
{
    if(string_pos("startup.txt",string_lower(path)))
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
    else
    {
        var sname = string_replace(get_path_index(path,0),".txt","");
        var i = 1;
        with(obj_scene) if(title.text == sname) sname+=string(i++);
        
        var scene = create_scene(view_wview[0],view_yview[0]/2,sname,true);
            add_scene_to_group(scene_list,scene);
            change_scene(scene);
            
        var csdata = cs_to_data(path,true);
        
        cs_proc_data(csdata,0,0,true);
        
        cs_cleanup(csdata);
    }
}
