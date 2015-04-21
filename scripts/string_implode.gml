///string_implode(sep,list)
var sep,token;
    sep = argument0;
    token = argument1;

var txt = "";
for(var i=0;i<ds_list_size(token);i++)
{
    if(i>0) txt += sep;
    txt += token[|i];
}

//ds_list_destroy(token);

return txt;
