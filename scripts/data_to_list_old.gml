///data_to_list();
var datalist = ds_list_create();

//save project variables
var pv = ds_map_create();
    ds_map_add(pv,"version",string_replace_all(program_version,".",""));
    ds_map_add(pv,"project_name",string(project_name));
    ds_map_add(pv,"GUID",real(GUID));
    ds_map_add(pv,"gamevars",string(gamevars));
    ds_map_add(pv,"gamestats",string(gamestats));
    ds_map_add(pv,"scene_count",real(scene_list.scene_count));
    ds_map_add(pv,"cur_scene",string(current_scene.title.text));
    stats_path = string(stats_path);
    ds_map_add(pv,"stats_path",string(stats_path));
    //scenes
    var sl = ds_list_create();
    
    for(var i=0;i<ds_list_size(scene_list.scenes);i++)
    {
        var sm = ds_map_create();
        var tvars = ds_list_create();
            for(var ii=0;ii<ds_list_size(scene_list.scenes[|i].tempvars);ii++)
            {
                ds_list_add(tvars,string(scene_list.scenes[|i].tempvars[|ii].name.text));
            }
        ds_map_add(sm,"tvars",ds_list_write(tvars));
        
        ds_map_add(sm,"title",string(scene_list.scenes[| i].title.text));
        ds_map_add(sm,"path",string(scene_list.scenes[| i].path));
        
        ds_list_add(sl,ds_map_write(sm));
        ds_map_destroy(sm);
    }
    ds_map_add(pv,"scenes",ds_list_write(sl));
    ds_list_destroy(sl);
    
    
    ds_list_add(datalist,ds_map_write(pv));
ds_map_destroy(pv);

//save objects
var curscene = current_scene;
for(var ii=0;ii<ds_list_size(scene_list.scenes);ii++)
{
    with(scene_list.scenes[| ii])
    {
        change_scene(id);
        for(var i=0;i<ds_list_size(bubbles);i++)
        {
            with(bubbles[| i])
            {
                var mp = ds_map_create();
                ds_map_add(mp,"scene",string(other.title.text));
                ds_map_add(mp,"UID",real(UID));
                ds_map_add(mp,"x",x);
                ds_map_add(mp,"y",y);
                ds_map_add(mp,"width",real(width));
                ds_map_add(mp,"height",real(height));
                ds_map_add(mp,"col",real(colour));
                
                ds_map_add(mp,"tbox",string(tbox.text));
                
                switch(object_index)
                {
                    case obj_bubble:
                        ds_map_add(mp,"type","bubble");
                        ds_map_add(mp,"title",string(title.text));
                        ds_map_add(mp,"output",get_UID(output.link));
                            for(var ci=1;ci<ds_list_size(choices)-1;ci++)
                            {
                                var cmp = ds_map_create();
                                
                                with(choices[| ci])
                                {
                                    ds_map_add(cmp,"type","choice");
                                    ds_map_add(cmp,"index",real(ci));
                                    ds_map_add(cmp,"x",x);
                                    ds_map_add(cmp,"y",y);
                                    ds_map_add(cmp,"width",real(width));
                                    ds_map_add(cmp,"height",real(height));
                                    ds_map_add(cmp,"col",real(colour));
                                    
                                    ds_map_add(cmp,"owner",get_UID(owner));
                                    ds_map_add(cmp,"link",get_UID(link));
                                    
                                    ds_map_add(cmp,"cbox",string(cbox.text));
                                    ds_map_add(cmp,"tbox",string(tbox.text));
                                    
                                    ds_list_add(datalist,ds_map_write(cmp));
                                }
                                ds_map_destroy(cmp);
                            }
                            
                    break;
                    
                    case obj_condition:
                        ds_map_add(mp,"type","condition");
                        ds_map_add(mp,"out_true",get_UID(out_true.link));
                        ds_map_add(mp,"out_false",get_UID(out_false.link));
                    break;
                    
                    case obj_action:
                        ds_map_add(mp,"type","action");
                        ds_map_add(mp,"output",get_UID(output.link));
                    break;
                }
                
                ds_list_add(datalist,ds_map_write(mp));
                ds_map_destroy(mp);
            }
        }
    }
}
change_scene(curscene);

return datalist;