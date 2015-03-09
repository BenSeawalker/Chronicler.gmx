///delete_scene(scene)
with(argument0)
{
    
    if(show_question("Are you sure you wish to delete "+title.text+"?"))
    {
        add_undo();
        var cur_s = current_scene;
        change_scene(id);
        var index = ds_list_find_index(scene_list.scenes,id);
        with(obj_parent_bubble) instance_destroy();
        
        if(cur_s==id)
            change_scene(scene_list.scenes[| (index-1)]);
        else
            change_scene(cur_s);
        
        for(var i=0;i<ds_list_size(tempvars);i++)
        {
            with(tempvars[| i]) instance_destroy();
        }
        ds_list_destroy(tempvars);
        ds_list_destroy(bubbles);
        
        ds_list_delete(scene_list.scenes,index);
        instance_destroy();
    }
}
