///reduce_path(path,type);
var path,type;
    path = argument[0];
    type = "";
    
    var found = true;
    if(argument_count > 1)
    {
        type = "."+argument[1];
        found = false;
    }
    
var sl = string_length(path);
var i = sl;
while(i > 1)
{
    if(string_copy(path,i,sl) == type)
        found = true;
    
    if(string_char_at(path,i) == "\")
        break;
    
    i--;
}
if(found)
    path = string_copy(path,1,i);
    
return path;
