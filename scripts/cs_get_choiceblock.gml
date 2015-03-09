///cs_get_block(mp,lines,index);
var mp,lines,index;
    mp = argument0;
    lines = argument1;
    index = argument2;
    
//var choices = ds_list_create();
//var cm = ds_map_create();
    
var il = string_length(cs_get_indent(lines[|index]));
var in = "";
var txt = "";

for(var ii=index;ii<ds_list_size(lines);ii++)
{
    line = lines[|ii];
    in = string_length(cs_get_indent(line));
    if(in>=il || string_length(line) == 0)
    {
        //if(string_pos("#",line) && in == il)
        //    ds_map_add(cm,"choice",string_replace(string_trim(line,false),"#",""));
        txt += (line)+chr(10);
    }
    else
    {
        index = ii;
        ds_map_add(mp,"data",txt);
        return index;
    }
}
