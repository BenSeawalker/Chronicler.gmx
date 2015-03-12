///cs_to_data(cs,is_file)
var cs,file;
    cs = argument0;
    is_file = argument1;

//var crlf = chr(13)+chr(10);

var lines,size;
    lines = ds_list_create();
        ds_list_add(lines,"");
    size = 0;

if(is_file)
{
    var f = FS_file_text_open_read(cs);
        while(!FS_file_eof(f))
        {
            lines[|size] = FS_file_text_read_string(f);
                FS_file_text_readln(f);
                //show_debug_message(string(lines[|size]));
            size++;
        }
    FS_file_text_close(f);
}
else
{
    for(var i=1;i<=string_length(cs);i++)
    {
        var c = string_char_at(cs,i);
        if(c != chr(10))
        {
            lines[|size] += c;
        }
        else
        {
            ds_list_add(lines,"");
            size++;
        }
    }
}
//show_debug_message(string(size));

//mark lines
//var uid = 0;
var lastif = -1;
var lastchoice = ds_list_create();
var lastindent = 0;
for(var i=0;i<ds_list_size(lines);i++)
{
    var mp = ds_map_create();
        var line = lines[|i];
        lines[|i] = mp;
        ds_map_add(mp,"line",string_trim(line,false));
        ds_map_add(mp,"indent",cs_get_indent(line));
        //ds_map_add(mp,"uid",uid++);
        
        //choices
        if(string_pos("*choice",line) || string_pos("*fake_choice",line))
        {
            if(string_pos("*choice",line))
                ds_map_add(mp,"type","choice");
            else
                ds_map_add(mp,"type","fake_choice");
                
            ds_map_add(mp,"choices",ds_list_create());
            ds_list_add(lastchoice,mp);
        }
        else if(string_pos("#",line))
        {
            var ind = ds_list_size(lastchoice)-1;
            var lc = lastchoice[|ind];
            if(lc[?"indent"] > mp[?"indent"])
            {
                ds_list_delete(lastchoice,ind);
                lc = lastchoice[|--ind];
            }
            ds_map_add(mp,"type","choiceval");
            ds_list_add(lc[?"choices"],mp);
        }
        //variables
        else if(string_pos("*title",line))
        {
            ds_map_add(mp,"type","title");
        }
        else if(string_pos("*author",line))
        {
            ds_map_add(mp,"type","author");
        }
        else if(string_pos("*create",line))
        {
            ds_map_add(mp,"type","create");
        }
        else if(string_pos("*temp",line))
        {
            ds_map_add(mp,"type","temp");
        }
        else if(string_pos("*scene_list",line))
        {
            ds_map_add(mp,"type","scene_list");
        }
        else if(string_pos("*stat_chart",line))
        {
            ds_map_add(mp,"type","stat_chart");
        }
        //conditions
        else if(string_pos("*if",line))
        {
            ds_map_add(mp,"type","if");
            lastif = mp;
        }
        else if(string_pos("*elseif",line))
        {
            ds_map_add(mp,"type","elseif");
            ds_map_add(lastif,"branch",mp);
            lastif = mp;
        }
        else if(string_pos("*else",line))
        {
            ds_map_add(mp,"type","else");
            ds_map_add(lastif,"branch",mp);
        }
        //comments
        else if(string_pos("*comment",line))
        {
            ds_map_add(mp,"type","comment");
        }
        //actions
        else if(string_pos("*",line))
        {
            ds_map_add(mp,"type","action");
        }
        //text
        else if(string_length(string_trim(line)))
        {
            ds_map_add(mp,"type","text");
        }
        //blank line
        else
        {
            ds_map_add(mp,"type","blank");
        }
}



//process lines
var objs = cs_proc_block(lines,0);

cs_sort_data(objs);
//debug
var fout = FS_file_text_open_write("C:\Users\Ben Seawalker\Documents\GameMaker\Builds\Chronicler\Dragon\output.txt");
    FS_file_text_write_string(fout,cs_debug(objs));
FS_file_text_close(fout);

/*
for(var i=0;i<ds_list_size(objs);i++)
{
    var mp = objs[|i];
    ds_map_destroy(mp)
}
ds_list_destroy(objs);
*/

//cleanup
/*
for(var i=0;i<ds_list_size(lines);i++)
{
    ds_map_destroy(lines[|i])
}
ds_list_destroy(lines);
*/
ds_list_destroy(lastchoice);



return objs;
