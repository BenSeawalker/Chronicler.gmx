///cs_proc_block(lines,index)
var lns,index;
    lns = argument0;
    index = argument1;

var objs = ds_list_create();

var imp = lns[|index];
while(imp[?"type"] == "blank") imp = lns[|++index];
var indent = ds_map_find_value(lns[|index],"indent");
    for(var i=index;i<ds_list_size(lns);i++)
    {
        var mp = ds_list_find_value(lns,i);
        if(ds_exists(mp,ds_type_map))
        {
            if(mp[?"indent"] >= indent || string_length(mp[?"line"]) == 0)
            {
                var obj = cs_proc_line(lns,i);
                if(obj != -1)
                {
                    switch(obj[?"type"])
                    {
                        case "bubble":
                        case "choice":
                        case "fake_choice":
                        case "scene_list":
                        case "if":
                        case "elseif":
                        case "else":
                            i = obj[?"index"];
                        break;
                    }
                    
                    /*
                    if(obj[?"type"] == "bubble" || obj[?"type"] == "choice" || obj[?"type"] == "fake_choice" || obj[?"type"] == "scene_list" ||
                        obj[?"type"] == "if" || obj[?"type"] == "elseif" || obj[?"type"] == "else")
                    {
                        i = obj[?"index"];
                    }*/
                    ds_list_add(objs,obj);
                }
            }
            else
            {
                ds_list_add(objs,i-1);
                break;
            }
        }
    }
return objs;
