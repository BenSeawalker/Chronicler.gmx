///variable_exists(varname)
var vname = argument0;
with(obj_variable)
{
    if(name.text == string_trim(vname)) return true;
}

return false;
