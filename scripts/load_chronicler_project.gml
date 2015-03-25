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
    var save_state = real(pv[? "save_state"]);
    
    project_name = pv[? "project_name"];
    GUID = pv[? "GUID"];
    if(save_version < 141) gamevars = string(pv[? "gamevars"]);
    gamestats = string(pv[? "gamestats"]);
    if(save_version>=130)stats_path = string(pv[? "stats_path"]);
    scene_list.scene_count = pv[? "scene_count"];
    var load_scene = string(pv[? "cur_scene"]);
    
    save_variables();
    
    //variables
    /*
    if(save_version >= 141)
    {
        var vl = ds_list_create();
        ds_list_read(vl,pv[? "variables"]);
        
        for(var i=0;i<ds_list_size(vl);i++)
        {
            var vm = ds_map_create();
            ds_map_read(vm,vl[|i]);
            
            with(create_variable(var_screen,vm[?"type"],vm[?"name"],vm[?"value"],vm[?"editable"]))
            {
                scene = vm[?"scene"];
            }
            
            ds_map_destroy(vm);
        }
        
        ds_list_destroy(vl);
    }
    switch_GUI_mode(true);
    switch_GUI_mode(false);
    */
    
    
    //scenes
    var sl = ds_list_create();
        ds_list_read(sl,pv[? "scenes"]);
    
    if(save_version >= old_version)
    {
        with(get_scene("startup"))
        {
            
            var sm = ds_map_create();
                ds_map_read(sm,sl[|0]);
                
            //if(save_version < 141)
            //{
                var tvars = ds_list_create();
                    ds_list_read(tvars,sm[? "tvars"]);
                for(var i=0;i<ds_list_size(tvars);i++)
                {
                    with(obj_variable) if(name.text == tvars[|i]) ds_list_add(other.tempvars,id);//scene = other.id;
                }
            //}
            /*
            else
            {
                with(obj_variable) if(scene == "startup") scene = other.id;
            }
            */
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
            
            //if(save_version < 141)
            //{
                var tvars = ds_list_create();
                    ds_list_read(tvars,sm[? "tvars"]);
                with(s)
                {
                    for(var ii=0;ii<ds_list_size(tvars);ii++)
                    {
                        with(obj_variable) if(name.text == tvars[|ii]) ds_list_add(other.tempvars,id);//scene = other.id;
                    }
                }
            //}
            /*
            else
            {
                with(obj_variable) if(scene == other.title.text) scene = other.id;
            }
            */
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
    
    //switch_GUI_mode(true);
    //switch_GUI_mode(false);
    
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
                    width = max(mp[? "width"],targetwidth);
                    height = max(mp[? "height"],targetheight);
                        targetwidth = width;
                        targetheight = height;
                    shift_y = real(mp[?"shift_y"]);
                    if(save_version>=130)colour = mp[? "col"];
                    
                    tbox.text = string(mp[? "tbox"]);
                    title.text = mp[? "title"];
                    label = get_label(title.text,UID);
                    
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
                    tbox.text = mp[? "tbox"];
                    shift_y = real(mp[?"shift_y"]);
                    
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
                    shift_y = real(mp[?"shift_y"]);
                    
                    tbox.text = mp[? "tbox"];
                    output.link = mp[? "output"];
                    
                    if(i==1) action_title = id;
                    if(i==2) action_author = id;
                }
            break;
            
            case "choice_bubble":
                if(use_choice_bubbles)
                {
                    with(instance_create(mp[? "x"],mp[? "y"],obj_choice_bubble))
                    {
                        UID = mp[? "UID"];
                        width = mp[? "width"];
                        height = mp[? "height"];
                        shift_y = real(mp[?"shift_y"]);
                        owner = mp[?"owner"];
                    }
                }
            break;

            case "choice":
                if(use_choice_bubbles)
                {
                    with(instance_create(mp[? "x"],mp[? "y"],obj_bchoice))
                    {
                        scene = current_scene;
                        index = mp[? "index"];
                        width = mp[? "width"];
                        
                        owner = mp[? "owner"];
                        output.link = mp[? "link"];
                        
                        cbox.text = mp[? "cbox"];
                        tbox.text = mp[? "tbox"];
                    }
                }
                else
                {
                    with(instance_create(mp[? "x"],mp[? "y"],obj_choice))
                    {
                        index = mp[? "index"];
                        width = mp[? "width"];
                        if(save_state)
                        {
                            owner = mp[? "parent"];
                        }
                        else
                        {
                            height = mp[? "height"];
                            colour = mp[? "col"];
                            owner = mp[? "owner"];
                        }
                        link = mp[? "link"];
                        
                        cbox.text = mp[? "cbox"];
                        tbox.text = mp[? "tbox"];
                    }
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
    with(obj_choice_bubble)
    {
        owner = get_obj_from_UID(owner);
    }
    ///*
    
    //sort choices by index
    var clist = 0;
    var len = 0;
    if(use_choice_bubbles)
        with(obj_bchoice) {clist[len] = id; len++}
    else
        with(obj_choice) {clist[len] = id; len++}
    
    for(var i=0; i<len; i+=1)
    {
       for (var j=1; j<(len-i); j+=1)
       {
          if (clist[j-1].index > clist[j].index)
          {
             var tmp = clist[j-1];
             clist[j-1] = clist[j];
             clist[j] = tmp;
          }
       }
    }
    for(var i=0;i<len;i++)
    {
        with(clist[i])
        {
            
            if(use_choice_bubbles)
            {
                change_scene(scene,false);
                var cb = get_obj_from_UID(owner);
                output.link = get_obj_from_UID(output.link);
            
                if(cb.object_index != obj_choice_bubble)
                {
                    //old data
                    if(cb.output.link == noone || cb.output.link.object_index != obj_choice_bubble || cb.output.link == noone)
                    {
                        
                        var ncb = instance_create(cb.x,cb.y+cb.targetheight+60,obj_choice_bubble);
                        cb.output.link = ncb;
                        ncb.owner = cb;
                        cb = ncb;
                    }
                    else
                        cb = cb.output.link;
                }
                
                owner = cb;
                //owner.colour = colour;
                //output.colour = colour;
                ds_list_add(owner.choices,id);
            }
            else
            {
                owner = get_obj_from_UID(owner);
                link = get_obj_from_UID(link);
                
                add_choice_to_bubble(owner,id);
            }
        }
    }
    
    if(use_choice_bubbles)// && save_version < 134)
    {
        if(!save_state || save_version < 134)
        {
            with(obj_choice_bubble)
            {
                var shift_amount = (ds_list_size(choices)*choices[|0].height + 300);
                with(obj_parent_bubble)
                {
                    if(y > other.y)
                    {
                        shift_y += shift_amount;
                        y = ystart + shift_y;
                    }
                }
                with(obj_bchoice)
                {
                    if(y > other.y)
                        y += shift_amount;
                }
            }
        }
    }
    else
    {
        with(obj_parent_bubble)
        {
            y -= shift_y;
            shift_y = 0;
        }
    }
    
    save_variables();
    GUI_mode = mode;
    change_scene(get_scene(load_scene));
}
