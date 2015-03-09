///string_trim(str,remove_inner);
var str = argument[0];
var in = true;
if(argument_count>1) in = argument[1];

//trim front
for(var i=1;i<=string_length(str);i++)
{
    if(string_char_at(str,i) != " " && string_char_at(str,i) != chr(9))
    {
        str = string_copy(str,i,string_length(str));
        break;
    }
}
//trim end
for(var i=string_length(str);i>=1;i--)
{
    if(string_char_at(str,i) != " " && string_char_at(str,i) != chr(9))
    {
        str = string_copy(str,1,i);
        break;
    }
}
if(in)
{
    //trim extra whitespace
    str = string_replace_all(str,chr(9)," ")
    while(string_pos("  ",str))
    {
        str = string_replace(str,"  "," ");
    }
}

if(str == " ") str = "";

return str;
