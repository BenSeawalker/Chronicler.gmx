///cs_proc_scenes(data, path);
var lst,path;
    lst = argument0;
    path = reduce_path(argument1,"txt");

var data = -1;
for(var i=0;i<ds_list_size(lst);i++)
{
    var mp = lst[|i];
    if(mp[?"type"] == "scene_list")
    {
        data = mp[?"data"];
        break;
    }
}

if(ds_exists(data,ds_type_list))
{
    for(var i=1;i<ds_list_size(data);i++)
    {
        if(data[|i] != "startup")
        {
            var scene = create_scene(view_wview[0],view_yview[0]/2,data[|i],true);
                add_scene_to_group(scene_list,scene);
                change_scene(scene);
            
            show_debug_message(path+data[|i]+".txt");
            var csdata = cs_to_data(path+data[|i]+".txt",true);
            cs_proc_data(csdata,0,0);
            show_debug_message("done...");
            
            cs_cleanup(csdata);
        }
    }
}
