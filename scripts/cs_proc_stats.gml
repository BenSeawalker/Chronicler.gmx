///cs_proc_stats(path)
var path;
    path = argument0;
    
var found = false;
var sl = string_length(path);
var i = sl;
while(i > 1)
{
    if(string_copy(path,i,sl) == ".txt")
        found = true;
    
    if(string_char_at(path,i) == "\")
        break;
    
    i--;
}
if(found)
    path = string_copy(path,1,i);

path += "choicescript_stats.txt";

var f = FS_file_text_open_read(path);
    while(!FS_file_eof(f))
    {
        gamestats += FS_file_text_read_string(f)+chr(10);
            FS_file_text_readln(f);
    }
FS_file_text_close(f);
