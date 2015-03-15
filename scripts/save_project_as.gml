var sp = get_save_filename("Chronicler Project|*.chron",project_name);
if(sp != "")
{
    obj_ctrl.alarm[1] = -1;
    with(obj_scene) path = "";
    stats_path = "";
    save_choicescript();
    
    save_path = sp;
    project_path = sp;
    var lst = data_to_list();
        var file = file_text_open_write(save_path);
            file_text_write_string(file,ds_list_write(lst));
        file_text_close(file);
    ds_list_destroy(lst);
    show_debug_message("Output file: "+save_path);
    
    show_popup("Save Complete!");
    obj_ctrl.alarm[1] = room_speed;
}
