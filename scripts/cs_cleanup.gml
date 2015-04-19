///cs_cleanup(data)
var lst = argument0;

for(var i=0;i<ds_list_size(lst);i++)
{
    var mp = lst[|i];
    
    switch(mp[?"type"])
    {
        case "scene_list":
            if(ds_exists(mp,ds_type_list))
                ds_list_destroy(mp[?"data"]);
        break;
        
        case "choice":
        case "if":
        case "elseif":
        case "else":
            cs_cleanup(mp[?"data"]);
        break;
    }
    if(ds_exists(mp,ds_type_map))
        ds_map_destroy(mp);
}

if(ds_exists(mp,ds_type_list))
    ds_list_destroy(lst);
