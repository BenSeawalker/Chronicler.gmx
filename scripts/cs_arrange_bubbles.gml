///cs_arrange_bubbles(data,xpos,ypos);
var lst,xpos,ypos;
    lst = argument0;
    xpos = argument1;
    ypos = argument2;
    
for(var i=0;i<ds_list_size(lst);i++)
{
    var mp = lst[|i];
    with(mp[?"oid"])
    {
        switch(mp[?"type"])
        {
            case "action":
                if((i<ds_list_size(lst)-1) && (!string_pos("*goto",mp[?"data"])))
                    output.link = ds_map_find_value(lst[|i+1],"oid");
                    
                ypos += height + 200;
            break;
            case "bubble":
                ypos += targetheight + 200;
            break;
            case "choice":
                ypos += targetheight + 200;
            break;
        }
    }
}
