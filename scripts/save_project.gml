//save project file
if(is_undefined(save_path)) save_path = "";
if(save_path == "" || !FS_file_exists(save_path)) save_path = get_save_filename("Chronicler Project|*.chron",project_name);

if(save_path != "")
{
    obj_ctrl.alarm[1] = -1;
    project_path = save_path;
    var vx,vy;
    
    //show_popup("Saving Scenes");
    save_choicescript();
    
    //show_popup("Saving Project");// to:#"+save_path); 
    var lst = data_to_list();

        var file = FS_file_text_open_write(save_path);
            FS_file_text_write_string(file,ds_list_write(lst));
            if(FS_file_bad(file)) show_debug_message("error:"+save_path);
        FS_file_text_close(file);
        show_debug_message("Output file: "+save_path);
        
    ds_list_destroy(lst);
    
    //show_popup("");
    show_popup("Save Complete!");
    obj_ctrl.alarm[1] = room_speed;
}
