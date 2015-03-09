///refactor_var(name,newname);
var oldname,newname;
    oldname = argument0;
    newname = argument1;


//even inactive bubbles
/*
var curscene = current_scene;
for(var ii=0;ii<ds_list_size(scene_list.scenes);ii++)
{
    with(scene_list.scenes[| ii])
    {
        change_scene(id,false);
        for(var i=0;i<ds_list_size(bubbles);i++)
        {
            with(bubbles[| i])
            {
                if(object_index == obj_bubble)
                {
                    tbox.text = string_replace_all(tbox.text,"${"+oldname+"}","${"+newname+"}");
                    
                    var s = 20;
                    textbox_draw(tbox,x+5,y+5,x+width-s-5,y+height-10,false);
                }
                else
                {
                    tbox.text = string_replace_all(tbox.text,oldname,newname);
                }
                new = true;
            }
        }
    }
}
change_scene(curscene,false);
instance_deactivate_all(false);
instance_activate_object(obj_ctrl);
instance_activate_object(var_screen);
instance_activate_object(obj_variable);
instance_activate_object(obj_scene);
instance_activate_object(obj_file_menu);
*/

for(var i=0;i<ds_list_size(allbubbles);i++)
{
    var bubble = allbubbles[|i];
    instance_activate_object(bubble);
    if(instance_exists(bubble))
    {
        if(bubble.object_index == obj_bubble)
        {
            bubble.tbox.text = string_replace_all(bubble.tbox.text,"${"+oldname+"}","${"+newname+"}");
            bubble.tbox.text = string_replace_all(bubble.tbox.text,"$!{"+oldname+"}","$!{"+newname+"}");
            var s = 20;
            textbox_draw(bubble.tbox,x+5,y+5,x+width-s-5,y+height-10,false);
        }
        else
        {
            bubble.tbox.text = string_replace_all(bubble.tbox.text,oldname,newname);
        }
        bubble.new = true;
    }
    instance_deactivate_object(bubble);
}
