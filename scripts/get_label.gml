///get_label(string,UID)
var txt,uid;
txt = string_replace_all(argument0," ","_");
uid = argument1;

var achars;
    achars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_123456789";

var tret = "";
for(var i=1;i<=string_length(txt);i++)
{
    var c = string_char_at(txt,i);
    if(string_pos(c,achars)) tret += c;
}

return tret+"_"+string(uid);