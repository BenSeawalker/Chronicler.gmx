///string_replace_whole(string,substring,newstring)

var str, sub, new;
    str = argument0;
    sub = argument1;
    new = argument2;
  
    
var newstr = "";

var tokens = string_explode(" ",str);

for(var i=0;i<ds_list_size(tokens);i++)
{
    if(tokens[|i] == sub) tokens[|i] = new;
}
newstr = string_implode(" ",tokens);
ds_list_destroy(tokens);

show_debug_message(str+"| : "+newstr+"|");
return newstr;
      
/*
var newstr,strlen,sublen,newlen,len;
    newstr = "";
    strlen = string_length(str);
    sublen = string_length(sub);
    newlen = string_length(new);
    len = 1;

for(var i=1;i<=strlen;i++)
{
    if((sublen && strlen) && sub == string_copy(str,i,sublen))
    {
        var c1 = string_char_at(str,i-1);
        var c2 = string_char_at(str,i+sublen+1);
        if(((!is_alnum(c1) || i==1) && !is_alnum(c2)))
        {
            newstr += (string_copy(str,min(len,strlen),i-len)+new);
            len = i+newlen;
            i+=newlen;
        }
    }
}
if(len < strlen)
    newstr += (string_copy(str,len,strlen));

return newstr;

*/
