///get_path_index(path,index);
var path,index;
    path = argument0;
    index = argument1;
    
var sl = string_length(path);
var i = sl;
var cindex = 0;
while(i > 1)
{
    if(string_char_at(path,i) == "\" && cindex++ == index)
        break;
    
    i--;
}

path = string_copy(path,++i,sl);
    
return path;
