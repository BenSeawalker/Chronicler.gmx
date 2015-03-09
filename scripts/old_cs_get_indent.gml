///cs_get_indent(line)
/*
var line = argument0;

var indent = "";
for(var i=1;i<=string_length(line);i++)
{
    if(string_char_at(line,i) == " ")
        indent += " ";
    else
        break;
}

return indent;
