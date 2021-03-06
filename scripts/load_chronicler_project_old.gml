///load_chronicler_project(path)
var lp = "";
var dat = false;

if(argument_count>0) lp = argument[0];
if(argument_count>1) dat = argument[1];

if(lp == "" && !dat)
{
    add_undo();
    lp = get_open_filename("Chronicler Project|*.chron","");
    project_path = lp;
}


if(lp != "" || dat)
{
    //autosave
    //obj_ctrl.alarm[1] = 1;
    
    var mode = GUI_mode;
    //switch_GUI_mode(false);
    GUI_mode = false;
    //clear existing project...
    clear_project();
    if(!dat)
    {
        ds_list_clear(obj_undo.actions);
        obj_undo.index = 0;
        
        save_path = project_path;
    }
    
    //load data into list
    var lst = ds_list_create();
    if(!dat)
    {
        if(lp == "autosave.chron")
        {
            var file = file_text_open_read(lp);
                ds_list_read(lst,file_text_read_string(file));
            file_text_close(file);
            save_path = "";
            project_path = "";
        }
        else
        {
            var file = FS_file_text_open_read(lp);
                ds_list_read(lst,FS_file_text_read_string(file));
            FS_file_text_close(file);
        }
    }
    else
    {
        ds_list_read(lst,lp);
    }
    
    //project variables
    var pv = ds_map_create();
        ds_map_read(pv,lst[| 0]);
    var save_version = real(string_replace_all(pv[? "version"],".",""));
    var cur_version = real(string_replace_all(program_version,".",""));
    var old_version = 126;
    
    project_name = pv[? "project_name"];
    GUID = pv[? "GUID"];
    gamevars = string(pv[? "gamevars"]);
    gamestats = string(pv[? "gamestats"]);
    if(save_version>=130)stats_path = string(pv[? "stats_path"]);
    scene_list.scene_count = pv[? "scene_count"];
    var load_scene = string(pv[? "cur_scene"]);
    save_variables();
    
    //scenes
    var sl = ds_list_create();
        ds_list_read(sl,pv[? "scenes"]);
    
    if(save_version >= old_version)
    {
        with(get_scene("startup"))
        {
            var sm = ds_map_create();
                ds_map_read(sm,sl[|0]);
            var tvars = ds_list_create();
                ds_list_read(tvars,sm[? "tvars"]);
            for(var i=0;i<ds_list_size(tvars);i++)
            {
                with(obj_variable) if(name.text == tvars[|i]) ds_list_add(other.tempvars,id);
            }
            path = sm[? "path"];
            
            ds_map_destroy(sm);
        }
        
        for(var i=1;i<ds_list_size(sl);i++)
        {
            var sm = ds_map_create();
                ds_map_read(sm,sl[|i]);
            var s = create_scene(window_get_width()*2,0,sm[? "title"],true);
                if(save_version>=130)s.path = sm[? "path"];
            add_scene_to_group(scene_list,s);
            
            var tvars = ds_list_create();
                ds_list_read(tvars,sm[? "tvars"]);
            with(s)
            {
                for(var ii=0;ii<ds_list_size(tvars);ii++)
                {
                    with(obj_variable) if(name.text == tvars[|ii]) ds_list_add(other.tempvars,id);
                }
            }
            ds_map_destroy(sm);
        }
    }
    else
    {
        for(var i=0;i<ds_list_size(sl);i++)
        {
            var s = create_scene(window_get_width()*2,0,sl[|i],true);
            add_scene_to_group(scene_list,s);
        }
    }
        if(save_version < old_version)
        {
            scene_list.scene_count = ds_list_size(sl)+1;
            load_scene = "startup";
        }
    ds_list_destroy(sl);
    ds_map_destroy(pv);
    
    //create the objects
    for(var i=1;i<ds_list_size(lst);i++)
    {
        var mp = ds_map_create();
        ds_map_read(mp,lst[| i]);
        
        switch(mp[? "type"])
        {
            case "bubble":
                
            current_scene = get_scene(mp[? "scene"]);
            change_scene(current_scene,false);
                with(instance_create(mp[? "x"],mp[? "y"],obj_bubble))
                {
                    UID = mp[? "UID"];
                    width = mp[? "width"];
                    height = mp[? "height"];
                    targetwidth = width;
                    targetheight = height;
                    if(save_version>=130)colour = mp[? "col"];
                    
                    tbox.text = mp[? "tbox"];
                    title.text = mp[? "title"];
//                    label = get_label(title.text,UID);
                    
                    output.link = mp[? "output"];
                    
                    if(i==3) bubble_intro = id;
                }
            break;
            
            case "condition":
            current_scene = get_scene(mp[? "scene"]);
                with(instance_create(mp[? "x"],mp[? "y"],obj_condition))
                {
                    UID = mp[? "UID"];
                    width = mp[? "width"];
                    height = mp[? "height"];
                    targetwidth = width;
                    targetheight = height;
                    //colour = mp[? "col"];
                    tbox.text = mp[? "tbox"];
                    
                    out_true.link = mp[? "out_true"];
                    out_false.link = mp[? "out_false"];
                }
            break;
            
            case "action":
            current_scene = get_scene(mp[? "scene"]);
                with(instance_create(mp[? "x"],mp[? "y"],obj_action))
                {
                    UID = mp[? "UID"];
                    width = mp[? "width"];
                    height = mp[? "height"];
                    targetwidth = width;
                    targetheight = height;
                    //colour = mp[? "col"];
                    
                    tbox.text = mp[? "tbox"];
                    output.link = mp[? "output"];
                    
                    if(i==1) action_title = id;
                    if(i==2) action_author = id;
                }
            break;
            
            case "choice":
                with(instance_create(mp[? "x"],mp[? "y"],obj_choice))
                {
                    index = mp[? "index"];
                    width = mp[? "width"];
                    if(!use_choice_bubbles)
                    {
                        height = mp[? "height"];
                        colour = mp[? "col"];
                    }
                    
                    owner = mp[? "owner"];
                    link = mp[? "link"];
                    
                    cbox.text = mp[? "cbox"];
                    tbox.text = mp[? "tbox"];
                }
            break;
        }
        
        ds_map_destroy(mp);
    }
    ds_list_destroy(lst);
    
    
    instance_activate_all();
    //post creation data
    with(obj_bubble)
    {
        var s = 20;
        output.link = get_obj_from_UID(output.link);
        textbox_draw(tbox,x+5,y+5,x+width-s-5,y+height-10,false);
    }
    with(obj_condition)
    {
        out_true.link = get_obj_from_UID(out_true.link);
        out_false.link = get_obj_from_UID(out_false.link);
    }
    with(obj_action)
    {
        output.link = get_obj_from_UID(output.link);
    }
    ///*
    var clist = 0;//ds_list_create();
    var len = 0;
    with(obj_choice) {clist[len] = id; len++}//ds_list_add(clist,id);
    
    for(var i=0; i<len; i+=1)
    {
       for (var j=1; j<(len-i); j+=1)
       {
          if (clist[j-1] > clist[j])
          {
             var hold = clist[j-1];
             clist[j-1] = clist[j];
             clist[j] = hold;
          }
       }
    }
    for(var i=0;i<len;i++)
    {
        with(clist[i])
        {
            owner = get_obj_from_UID(owner);
            link = get_obj_from_UID(link);
            add_choice_to_bubble(owner,id);
        }
    }
    
    save_variables();
    GUI_mode = mode;
    change_scene(get_scene(load_scene));
}
