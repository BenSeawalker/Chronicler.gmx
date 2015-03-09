///string_implode(sep,list)
var sep,token;
    sep = argument0;
    token = argument1;

var txt = "";
for(var i=0;i<ds_list_size(token);i++)
{
    txt += token[|i]+sep;
}

ds_list_destroy(token);

return txt;
