///cs_proc_stats(path)
var path;
    path = reduce_path(argument0,"txt");

path += "choicescript_stats.txt";

var f = FS_file_text_open_read(path);
    while(!FS_file_eof(f))
    {
        gamestats += FS_file_text_read_string(f)+chr(10);
            FS_file_text_readln(f);
    }
FS_file_text_close(f);
