///cs_debug(data);
var lst,index;
    lst = argument0;

var output = "";
for(var i=0;i<ds_list_size(lst);i++)
{
    var mp = lst[|i];
    var ind2 = "";
        repeat(mp[?"indent"]) ind2+=" ";
        
    output += ind2+"---------------------"+chr(10);
    
    if(mp[?"type"] == "choice")
    {
            //repeat(ds_map_find_value(ds_list_find_value(mp[?"data"],0),"indent")) ind2+=" ";
        output += ind2+"Type: "+mp[?"type"]+chr(10);
        for(var ii=0;ii<ds_list_size(mp[?"data"]);ii++)
        {
            var mp2 = ds_list_find_value(mp[?"data"],ii);
            output += ind2+"^^^^^^^^^^^^^^^^^"+chr(10);
            output += mp2[?"line"]+chr(10);
            var data = mp2[?"data"];
            output += cs_debug(data);
        }
    }
    else if(mp[?"type"] == "fake_choice")
    {
        output += ind2+"Type: "+mp[?"type"]+chr(10);
        for(var ii=0;ii<ds_list_size(mp[?"data"]);ii++)
        {
            output += ds_list_find_value(mp[?"data"],ii)+chr(10);
        }
    }
    else if(mp[?"type"] == "if" || mp[?"type"] == "elseif" || mp[?"type"] == "else")
    {
        output += ind2+"Type: "+mp[?"type"]+chr(10);
        output += ind2+mp[?"raw"]+chr(10);
        output += cs_debug(mp[?"data"])+chr(10);
    }
    else
    {
        output += ind2+"Type: "+mp[?"type"]+chr(10);
        output += string(mp[?"data"])+chr(10);
    }
}

return output;
