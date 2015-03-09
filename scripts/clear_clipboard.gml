if(ds_exists(clipboard,ds_type_list))
{
    for(var i=0;i<ds_list_size(clipboard);i++)
    {
        var mp = clipboard[|i];
        if(ds_exists(mp,ds_type_map))
        {
            if(mp[?"type"] == obj_bubble)
            {
                var cs = mp[?"choices"];
                if(ds_exists(cs,ds_type_list))
                {
                    for(var ii=0;ii<ds_list_size(cs);ii++)
                    {
                        ds_map_destroy(cs[|ii]);
                    }
                    ds_list_destroy(cs);
                }
            }
            
            ds_map_destroy(mp);
        }
    }
    ds_list_clear(clipboard);
}
