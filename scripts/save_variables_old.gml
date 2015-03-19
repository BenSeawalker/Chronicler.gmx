if(GUI_mode)
{
    var nameless = false;
    with(obj_variable) if(name.text == "" && (type == vartype_global || type == vartype_temp)) {nameless = true; break;}
    
    if(nameless && !show_question("Some Variables don't have names.#They will be removed...##Continue?"))exit; 
    
    with(obj_variable)if(name.text == "" && (type == vartype_global || type == vartype_temp))
    {
        instance_destroy();
    }
    
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
    with(obj_variable)if(type != vartype_temp)instance_destroy();
    ds_list_clear(var_screen.vars);
        create_variable(var_screen,vartype_title,project_name,"",false);
        create_variable(var_screen,vartype_author,"","",false);
        
    var txt = "";
    var c = "";
    var line = 0;
    show_debug_message("starting string");
    var i = 1;
    for(i=1;i<=string_length(gamevars);i++)
    {
        c = string_char_at(gamevars,i);
        if(c != chr(10))
            txt += c;
        if(c == chr(10) || i==string_length(gamevars))
        {
            line++;
            if(string_pos("*title",txt))
            {
                var_screen.vars[| 0].name.text = string_trim(string_replace(txt,"*title ",""));
                project_name = var_screen.vars[| 0].name.text;
            }
            else if(string_pos("*author",txt))
                var_screen.vars[| 1].name.text = string_trim(string_replace(txt,"*author ",""));
            else if(string_pos("*create",txt) || string_pos("*temp",txt))
            {
                var t = vartype_global;
                    if(string_pos("*temp",txt)) t = vartype_temp;    
            
                txt = string_trim(string_replace(string_replace(txt,"*create ",""),"*temp ",""));
                var n = "";
                var v = "";
                   
                for(var ii=1;ii<=string_length(txt);ii++)
                {
                    c = string_char_at(txt,ii);
                    if(c!=" " && c!=chr(10)) 
                        n+=c;
                    else
                        break;
                }
                
                if(ii+1 <= string_length(txt))
                    v = string_copy(txt,ii+1,string_length(txt));
                
                var found = false;
                with(obj_variable)if(name.text == n)// && ds_list_find_index(current_scene.tempvars,id)>-1)
                {
                    found = true;
                    value.text = v;
                    add_variable(var_screen,id);
                    break;
                }
                if(!found){create_variable(var_screen,t,n,v,true); show_debug_message("creating variable");};
            }
            else if(txt != "" && !string_pos("(",txt) && !string_pos("*",txt) && !string_pos("/",txt))
            {
                if(!show_question("Error line:"+string(line)+'#"'+txt+'"##Continue anyway?'))
                {
                    show_variables();
                    exit;
                }
            }
            
            txt = "";
        }
    }
    show_debug_message(string(i));
    show_debug_message("string done");
    
    with(obj_variable) if(type == vartype_temp && !ds_list_find_index(var_screen.vars,id))
    {
        add_variable(var_screen,id);
    }
}
