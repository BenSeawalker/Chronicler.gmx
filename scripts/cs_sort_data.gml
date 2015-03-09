///cs_sort_data(data);
var lst;
    lst = argument0;

var ypos = 0;
var xpos = 0;
    
for(var i=0;i<ds_list_size(lst);i++)
{
    var mp = lst[|i];
    
    if(mp[?"type"] == "choice")
    {
        for(var ii=0;ii<ds_list_size(mp[?"data"]);ii++)
        {
            //var mp2 = ds_list_find_value(mp[?"data"],ii);
            //output += mp2[?"line"]+chr(10);
            
            //cs_proc_data(mp2[?"data"]);
        }
    }
    else if(mp[?"type"] == "fake_choice")
    {
        for(var ii=0;ii<ds_list_size(mp[?"data"]);ii++)
        {
            //output += ds_list_find_value(mp[?"data"],ii)+chr(10);
        }
    }
    else if(mp[?"type"] == "if" || mp[?"type"] == "elseif" || mp[?"type"] == "else")
    {
        //output += ind2+mp[?"raw"]+chr(10);
        //output += cs_debug(mp[?"data"])+chr(10);
    }
    else if(mp[?"type"] == "bubble")
    {
        //output += string(mp[?"data"])+chr(10);
        for(var ii=i+1;ii<ds_list_size(lst);ii++)
        {
            var mp2 = ds_list_find_value(lst,ii);
            if(mp2[?"type"] == "bubble") break;
            
            if((mp2[?"type"] == "choice" || mp2[?"type"] == "fake_choice") && (ii-i)>1)
            {
                //show_debug_message("-----------------------------");
                //show_debug_message("shifting: "+chr(10)+mp[?"data"]+chr(10)+"down "+string(ii-i-1)+" lines.");
                ds_list_insert(lst,ii,mp);
                ds_list_delete(lst,i);
                break;
            }
        }
    }
    else
    {
    
    }
}

//return output;
