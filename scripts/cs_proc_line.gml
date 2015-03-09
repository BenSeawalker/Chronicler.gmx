///cs_proc_line(lines,index);
var lns,index;
    lns = argument0;
    index = argument1;
    
var nmp = ds_map_create();
    
    
    var mp = lns[|index];
        ds_map_add(nmp,"type","undefined");
        //ds_map_add(nmp,"uid",mp[?"uid"]);
        ds_map_add(nmp,"data","");
        ds_map_add(nmp,"indent",mp[?"indent"]);
        
        switch(mp[?"type"])
        {
            case "blank":
                ds_map_destroy(nmp);
                return -1;
            break;
            
            case "text":
                var txt = mp[?"line"];
                var nind = index+1;
                for(var ii=nind;ii<ds_list_size(lns);ii++)
                {
                    var mp2 = lns[|ii];
                    if(mp2[?"type"] == "text" || mp2[?"type"] == "blank")
                    {
                        txt += chr(10)+mp2[?"line"];
                    }
                    else
                    {
                        nind = ii-1;
                        break;
                    }
                }
                
                ds_map_replace(nmp,"type","bubble");
                ds_map_replace(nmp,"data",txt);
                ds_map_replace(nmp,"index",nind);
            break;
            
            
            case "scene_list":
                var lst = ds_list_create();
                ds_list_add(lst,mp[?"line"]);
                var nind = index+1;
                for(var ii=nind;ii<ds_list_size(lns);ii++)
                {
                    var mp2 = lns[|ii];
                    if(mp2[?"type"] == "text")
                    {
                        ds_list_add(lst,mp2[?"line"]);
                    }
                    else
                    {
                        nind = ii-1;
                        break;
                    }
                }
                
                ds_map_replace(nmp,"type","scene_list");
                ds_map_replace(nmp,"data",lst);
                ds_map_replace(nmp,"index",nind);
            break;
            
            case "if":
            case "elseif":
            case "else":
                var block = cs_proc_block(lns,index+1);
                var nind = ds_list_size(block)-1;
                ds_map_replace(nmp,"index",block[|nind]);
                    ds_list_delete(block,nind);
                    
                ds_map_replace(nmp,"type",mp[?"type"]);
                ds_map_replace(nmp,"data",block);
                ds_map_add(nmp,"raw",mp[?"line"]);
            break;
            
            
            case "choice":
                ds_map_replace(nmp,"type","choice");
                var data = mp[?"choices"];
                ds_map_replace(nmp,"data",data);
                //show_debug_message("-----------------------"+string(index));
                for(var iii=0;iii<ds_list_size(data);iii++)
                {
                    var mp2 = data[|iii];
                    var ind = ds_list_find_index(lns,mp2)+1;
                        //show_debug_message(mp2[?"line"]);
                        var block = cs_proc_block(lns,ind);
                        var nind = ds_list_size(block)-1;
                        ds_map_replace(nmp,"index",block[|nind]);
                            ds_list_delete(block,nind);
                            
                            
                    ds_map_replace(mp2,"data",block);
                }
                //show_debug_message("***********************"+string(index));
            break;
            
            case "fake_choice":
                ds_map_replace(nmp,"type","fake_choice");
                var data = ds_list_create();
                for(var ii=0;ii<ds_list_size(mp[?"choices"]);ii++)
                {
                    var mp2 = ds_list_find_value(mp[?"choices"],ii);
                    ds_list_add(data,string_trim(mp2[?"line"],false))
                }
                ds_map_replace(nmp,"data",data);
                ds_map_replace(nmp,"index",index+ds_list_size(data)+1);
            break;
            
            
            //actions or anything left over
            default:
                ds_map_replace(nmp,"type",mp[?"type"]);
                ds_map_replace(nmp,"data",mp[?"line"]);
            break;
        }
    
return nmp;



/*
            case "if":
                show_debug_message(mp[?"line"]);
                ds_map_replace(nmp,"type","if");
                var data = mp[?"branches"];
                ds_map_replace(nmp,"data",data);
                
                var block = cs_proc_block(lns,index);
                var nind = ds_list_size(block)-1;
                ds_map_replace(nmp,"index",block[|nind]);
                    ds_list_delete(block,nind);
                var mp2 = ds_map_create();
                    ds_map_add(mp2,"type","if");
                    ds_map_add(mp2,"data",block);
                    ds_map_add(mp2,"line",mp[?"line"]);
                ds_list_insert(data,0,mp2);
                
                for(var iii=1;iii<ds_list_size(data);iii++)
                {
                    mp2 = data[|iii];
                    var ind = ds_list_find_index(lns,mp2);
                        block = cs_proc_block(lns,ind);
                        nind = ds_list_size(block)-1;
                        ds_map_replace(nmp,"index",block[|nind]);
                            ds_list_delete(block,nind);
                            
                        
                        ds_map_replace(mp2,"data",block);
                }
            break;


            case "choice":
                //cs_proc_block() ....
                var txt = "";
                var nind = index+1;
                var indent = ds_map_find_value(lns[|nind],"indent");
                for(var iii=nind;iii<ds_list_size(lns);iii++)
                {
                    var mp2 = lns[|iii];
                    if(!(mp2[?"indent"] >= indent || string_length(mp2[?"line"]) == 0))
                    {
                        nind = iii;
                        break;
                    }
                }
                
                for(var iii=0;iii<ds_list_size(mp[?"choices"]);iii++)
                {
                    var mp2 = ds_list_find_value(mp[?"choices"],iii);
                    txt += mp2[?"line"]+chr(10);
                }
                
                ds_map_replace(nmp,"type","choice");
                ds_map_replace(nmp,"data",txt);
                ds_map_replace(nmp,"index",nind);
            break;
            */
