///cs_arrange_bubbles(data,xpos,ypos, width);
var lst,xpos,ypos,width;
    lst = argument[0];
    xpos = argument[1];
    ypos = argument[2];
    width = 0;
    if(argument_count > 3) width = argument[3];
    
for(var i=0;i<ds_list_size(lst);i++)
{
    var mp = lst[|i];
    with(mp[?"oid"])
    {
        y = ypos;
        x = xpos;
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
                
                var data = mp[?"data"];
                for(var ii=0;ii<ds_list_size(data);ii++)
                {
                    var mp2 = data[|ii];
                    
                }
            break;
        }
    }
}

var retdata;
    retdata[0] = xpos;
    retdata[1] = ypos;
    retdata[2] = width;

return retdata;
