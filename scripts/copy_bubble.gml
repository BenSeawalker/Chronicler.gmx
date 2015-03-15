with(argument0)
{
    var mp = ds_map_create();
        ds_map_add(mp,"type",object_index);
        ds_map_add(mp,"UID",UID);
        ds_map_add(mp,"x",x-mouse_x);
        ds_map_add(mp,"y",y-mouse_y);
        if(object_index != obj_choice_bubble)
            ds_map_add(mp,"tbox",tbox.text);
        
        switch(object_index)
        {
            case obj_bubble:
                ds_map_add(mp,"title",title.text);
                ds_map_add(mp,"width",width);
                ds_map_add(mp,"height",height);
                ds_map_add(mp,"colour",colour);
                
                var otp = -1;
                    if(output.link != noone) otp = output.link.UID;
                ds_map_add(mp,"output",otp);
                
                var cs = ds_list_create();
                    for(var i=1;i<ds_list_size(choices)-1;i++)
                    {
                        var c = choices[|i];
                        var cm = ds_map_create();
                            var otp = -1;
                                if(c.link != noone) otp = c.link.UID;
                            ds_map_add(cm,"link",otp);
                            ds_map_add(cm,"cbox",c.cbox.text)
                            ds_map_add(cm,"tbox",c.tbox.text);
                        ds_list_add(cs,cm);
                    }
                ds_map_add(mp,"choices",cs);
            break;
            
            case obj_condition:
                var otp = -1;
                    if(out_true.link != noone) otp = out_true.link.UID;
                ds_map_add(mp,"out_true",otp);
                
                otp = -1;
                    if(out_false.link != noone) otp = out_false.link.UID;
                ds_map_add(mp,"out_false",otp);
            break;
            
            case obj_action:
                var otp = -1;
                    if(output.link != noone) otp = output.link.UID;
                ds_map_add(mp,"output",otp);
            break;
            
            case obj_choice_bubble:
                var cs = ds_list_create();
                    for(var i=0;i<ds_list_size(choices);i++)
                    {
                        var c = choices[|i];
                        var cm = ds_map_create();
                            var otp = -1;
                                if(c.output.link != noone) otp = c.output.link.UID;
                            ds_map_add(cm,"link",otp);
                            ds_map_add(cm,"cbox",c.cbox.text)
                            ds_map_add(cm,"tbox",c.tbox.text);
                        ds_list_add(cs,cm);
                    }
                ds_map_add(mp,"choices",cs);
            break;
        }
    return mp;
}

return -1;
