//save project file

//save stats screen
stats_path = string(stats_path);
if(stats_path == "" || !FS_file_exists(stats_path))
    stats_path = get_save_filename("ChoiceScript|choicescript_stats.txt","choicescript_stats.txt");

//show_debug_message(stats_path);    
if(stats_path != "")
{
    var f = FS_file_text_open_write(stats_path);
        FS_file_text_write_string(f,string(gamestats));
    FS_file_text_close(f);
    show_debug_message("Output file: "+stats_path);
    
    //show_popup("Saving stats");// to:#"+save_path);
}
//loop through scenes....
for(var ii=0;ii<ds_list_size(scene_list.scenes);ii++)
{
    var sc = scene_list.scenes[| ii];
    sc.path = string(sc.path);
    if(sc.path == "" || !FS_file_exists(sc.path))
        sc.path = get_save_filename("ChoiceScript|"+sc.title.text+".txt",sc.title.text);
    
    if(sc.path != "")
    {
        //save to file
        var choiceScript = "";
        if(use_new_compiler)
            choiceScript = data_to_choicescript(sc);
        else
            choiceScript = data_to_choicescript_old(sc);
        
        
        var f = FS_file_text_open_write(sc.path);
            FS_file_text_write_string(f,string(choiceScript));
        FS_file_text_close(f);
        show_debug_message("Output file: "+sc.path);
        
        //show_popup("Saving scene: "+'"'+sc.title.text+'"');//+" to:#"+sc.path);
    }
}
