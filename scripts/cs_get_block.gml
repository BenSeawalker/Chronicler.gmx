///cs_get_block(mp,lines,index);
var mp,lines,index;
    mp = argument0;
    lines = argument1;
    index = argument2;
    
var il = string_length(cs_get_indent(lines[|index-1]));
var in = "";
var txt = "";

for(var ii=index;ii<ds_list_size(lines);ii++)
{
    line = lines[|ii];
    in = string_length(cs_get_indent(line));
    if((!string_pos("*",line) || string_pos("*line_break",line)) && (in>=il || in == 0))
    {
        txt += string_trim(line,false)+chr(10);
    }
    else
    {
        ds_map_add(mp,"data",txt);
        return ii;
    }
}
