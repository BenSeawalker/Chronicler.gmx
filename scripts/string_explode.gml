///string_explode(sep,str)
var token,size;
    token = ds_list_create();
        ds_list_add(token,"");
    size = 0;

for(var i=1;i<=string_length(argument1);i++)
{
    var c = string_char_at(argument1,i);
    if(c != argument0)
    {
        token[| size] += c;
    }
    else
    {
        ds_list_add(token,"");
        size++;
    }
}

return token;
