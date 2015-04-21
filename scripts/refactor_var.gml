///refactor_var(name,newname,scene);
var oldname,newname,temp_scene;
    oldname = argument0;
    newname = argument1;
    scene = argument2;
    

show_debug_message("refactoring: "+oldname);
for(var i=0;i<ds_list_size(allbubbles);i++)
{
    var bubble = allbubbles[|i];
    instance_activate_object(bubble);
    if(instance_exists(bubble))
    {
        if(scene == "all" || scene == bubble.scene)
        {
            //if(scene == bubble.scene)
                //show_debug_message("refactoring: " + bubble.scene.title.text);
                
            if(bubble.object_index == obj_bubble)
            {
                bubble.tbox.text = string_replace_whole(bubble.tbox.text,"${"+oldname+"}","${"+newname+"}");
                bubble.tbox.text = string_replace_whole(bubble.tbox.text,"$!{"+oldname+"}","$!{"+newname+"}");
                var s = 20;
                textbox_draw(bubble.tbox,x+5,y+5,x+width-s-5,y+height-10,false);
            }
            else if(bubble.object_index == obj_choice_bubble)
            {
                for(var j=0;j<ds_list_size(bubble.choices);j++)
                {
                    with(bubble.choices[|j])
                    {
                        tbox.text = string_replace_whole(tbox.text,"${"+oldname+"}","${"+newname+"}");
                        tbox.text = string_replace_whole(tbox.text,"$!{"+oldname+"}","$!{"+newname+"}");
                        cbox.text = string_replace_whole(cbox.text,oldname,newname);
                        new = true;
                    }
                }
            }
            else
            {
                bubble.tbox.text = string_replace_whole(bubble.tbox.text,oldname,newname);
                bubble.new = true;
            }
        }
    }
    instance_deactivate_object(bubble);
}
