///cs_cleanup(data)
var lst = argument0;

for(var i=0;i<ds_list_size(lst);i++)
{
    var mp = lst[|i];
    
    switch(mp[?"type"])
    {
        case "choice":
        case "scene_list":
        case "if":
        case "elseif":
        case "else":
            ds_list_destroy(mp[?"data"]);
            ds_map_destroy(mp);
        break;
        
        default:
            ds_map_destroy(mp);
        break;
    }
}

ds_list_destroy(lst);
