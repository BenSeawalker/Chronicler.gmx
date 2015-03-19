if(GUI_mode)
{
    gamevars = "";
    with(var_screen.vars[| 0]) {gamevars += "*title "+name.text+chr(10); project_name = name.text;}
    with(var_screen.vars[| 1]) gamevars += "*author "+name.text+chr(10)+chr(10);
    with(obj_variable)
    {
        switch(type)
        {
            case vartype_global:
                    gamevars += "*create "+name.text+" "+value.text+chr(10);
            break;
            case vartype_temp:
                //if(ds_list_find_index(current_scene.tempvars,id)>-1)
                with(obj_scene)
                    if(ds_list_find_index(tempvars,other.id)>-1)
                        gamevars += chr(10)+"//"+title.text+chr(10);
                        
                    gamevars += "*temp "+name.text+" "+value.text+chr(10);
            break;
        }
    }
}
else if(!GUI_mode)
{
    with(obj_variable) if(type != vartype_temp) instance_destroy();
    ds_list_clear(var_screen.vars);
        create_variable(var_screen,vartype_title,project_name,"",false);
        create_variable(var_screen,vartype_author,"","",false);
    
    var lines = string_explode(chr(10),gamevars);
    for(var i=0;i<ds_list_size(lines);i++)
    {
        var line = string_explode(" ",lines[|i]);
        var ls = ds_list_size(line);
        if(ls >= 2)
        {
            switch(line[|0])
            {
                case "*title":
                    line[|0] = "";
                        project_name = string_trim(string_implode(" ",line),false);
                    var_screen.vars[|0].name.text = project_name;
                break;
                case "*author":
                    line[|0] = "";
                    var_screen.vars[|1].name.text = string_trim(string_implode(" ",line),false);
                break;
                case "*create":
                    var n,v;
                    var n = line[|1];
                    line[|0] = "";
                    line[|1] = "";
                    v = string_trim(string_implode(" ",line),false);
                    //if(ls >= 3) v = string_trim(string_implode(" ",line),false); else v = ""
                    
                    create_variable(var_screen,vartype_global,n,v,true);
                break;
                case "*temp":
                    var n,v;
                    var n = line[|1];
                    line[|0] = "";
                    line[|1] = "";
                    v = string_trim(string_implode(" ",line),false);
                    //if(ls >= 3) v = line[|2] else v = ""
                    
                    var found = false;
                    with(obj_scene)
                    {
                        for(var j=0;j<ds_list_size(tempvars);j++)
                        {
                            var tv = tempvars[|j];
                            if(tv.name.text == n)
                            {
                                tv.value.text = v;
                                add_variable(var_screen,tv);
                                
                                found = true;
                                break;
                            }
                        }
                    }
                    if(!found)
                        create_variable(var_screen,vartype_temp,n,v,true);
                break;
            }
        }
        if(ds_exists(line,ds_type_list)) ds_list_destroy(line);
    }
    ds_list_destroy(lines);
    //cleanup extras
    with(obj_variable)
    {
        if(type == vartype_temp && ds_list_find_index(var_screen.vars,id)==-1)
            instance_destroy();
    }
}
