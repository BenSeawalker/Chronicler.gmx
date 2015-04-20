///data_to_choicescript(scene);
var scene, curscene;
curscene = current_scene;
scene = argument0;

//show_debug_message("dtc");
change_scene(scene,false);
//show_debug_message("scene 1");
var mode = GUI_mode;
switch_GUI_mode(false);
//show_debug_message("gui 1");

//setup vars
var choiceScript,indent, bubbles, i;

choiceScript = "";
indent = "    ";
bubbles = scene.bubbles;//sort_by_UID(true,scene);

//scenes
if(scene.title.text == "startup")
{
    choiceScript += "*scene_list"+chr(10);
    for(var i=0;i<ds_list_size(scene_list.scenes);i++)
    {
     choiceScript += indent+ds_list_find_value(scene_list.scenes,i).title.text+chr(10);
    }
    choiceScript += chr(10);
    //game variables
    //choiceScript += gamevars;
    
    if(scene == get_scene("startup"))
    {
        with(var_screen.vars[| 0]) choiceScript += "*title "+name.text+chr(10);
        with(var_screen.vars[| 1]) choiceScript += "*author "+name.text+chr(10)+chr(10);
        for(var ii=0;ii<ds_list_size(var_screen.vars);ii++)
        {
            with(var_screen.vars[|ii])
            {
                if(type == vartype_global)
                    choiceScript += "*create "+name.text+" "+value.text+chr(10);
            }
        }
    }
}
for(var i=0;i<ds_list_size(scene.tempvars);i++)
{
    with(scene.tempvars[|i])
        choiceScript += "*temp "+name.text+" "+value.text+chr(10);
}
choiceScript += chr(10);

//show_debug_message("startup");

for(var i=0;i<ds_list_size(bubbles);i+=1)
{
    with(bubbles[| i])
    {
        choiceScript += "*label "+label+chr(10);
        
        switch(object_index)
        {
            case obj_bubble:
                choiceScript += tbox.text;
                if(tbox.text != "") choiceScript += chr(10);
                
                if(ds_list_size(choices) == 2 && output.link!=noone)
                {
                    choiceScript += "*goto "+output.link.label;
                }
                else if(ds_list_size(choices)>2)
                {
                    choiceScript += "*choice";
                    for(var ii=1;ii<ds_list_size(choices)-1;ii+=1)
                    {
                        with(choices[| ii])
                        {
                            choiceScript += chr(10)+indent;
                            if(cbox.text!="")
                                choiceScript += cbox.text+" ";
                            choiceScript += "#"+tbox.text+chr(10);
                            if(link != noone)
                                choiceScript += indent+indent+"*goto "+link.label;
                            else
                                choiceScript += indent+indent+"*finish";
                        }
                    }
                }
                else
                {
                    choiceScript += "*finish";
                }
            break;
            
            case obj_choice_bubble:
                choiceScript += "*choice";
                    for(var ii=0;ii<ds_list_size(choices);ii++)
                    {
                        with(choices[| ii])
                        {
                            choiceScript += chr(10)+indent;
                            if(cbox.text!="")
                                choiceScript += cbox.text+" ";
                            choiceScript += "#"+tbox.text+chr(10);
                            if(output.link != noone)
                                choiceScript += indent+indent+"*goto "+output.link.label;
                            else
                                choiceScript += indent+indent+"*finish";
                        }
                    }
            break;
            
            case obj_condition:
                    
                choiceScript += "*if("+tbox.text+")"+chr(10);
                choiceScript += indent;
                
                if(out_true.link!=noone)
                    choiceScript += "*goto "+out_true.link.label; else choiceScript += "*finish";
                choiceScript += chr(10)+"*else"+chr(10)+indent;
                if(out_false.link!=noone)
                    choiceScript += "*goto "+out_false.link.label; else choiceScript += "*finish";
            break;
            
            case obj_action:
                choiceScript += tbox.text+chr(10);
                if(output.link!=noone)
                    choiceScript += "*goto "+output.link.label;
                else if(!string_pos("*finish",tbox.text))
                    choiceScript += "*finish";
            break;
        }
        
        choiceScript += chr(10)+chr(10);
    }
}
//show_debug_message("done");

switch_GUI_mode(mode);
//show_debug_message("gui");

change_scene(curscene,false);
//show_debug_message("scene");

return choiceScript;
    
    
    
    
    
    
    
