//add_undo()
//var data = argument0;
//show_debug_message("add_undo: "+object_get_name(object_index));
with(obj_undo)
{
    if(index<ds_list_size(actions)-1)
    {
        for(var i=index+1;i<ds_list_size(actions);i++)
        {
            ds_list_delete(actions,i);
        }
    }
    
    ///*
    var lst = data_to_list();
        ds_list_add(actions,ds_list_write(lst));
    ds_list_destroy(lst);
    //*/
    //ds_list_add(actions,data);
    index++;
}
