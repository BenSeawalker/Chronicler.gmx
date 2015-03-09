///cs_proc_data(data,xpos,ypos);
var lst,xpos,ypos;
    lst = argument0;
    xpos = argument1;
    ypos = argument2;
    
for(var i=0;i<ds_list_size(lst);i++)
{
    var mp = lst[|i];
    
    if(mp[?"type"] == "choice")
    {
        //for(var ii=0;ii<ds_list_size(mp[?"data"]);ii++)
        //{
            //var mp2 = ds_list_find_value(mp[?"data"],ii);
            //output += mp2[?"line"]+chr(10);
            
            //cs_proc_data(mp2[?"data"]);
        //}
    }
    else if(mp[?"type"] == "fake_choice")
    {
        //for(var ii=0;ii<ds_list_size(mp[?"data"]);ii++)
        //{
            //output += ds_list_find_value(mp[?"data"],ii)+chr(10);
        //}
    }
    else if(mp[?"type"] == "if" || mp[?"type"] == "elseif" || mp[?"type"] == "else")
    {
        //output += ind2+mp[?"raw"]+chr(10);
        //output += cs_debug(mp[?"data"])+chr(10);
    }
    else if(mp[?"type"] == "bubble")
    {
        //output += string(mp[?"data"])+chr(10);
        if(string_length(string_trim(mp[?"data"])))
        { 
            var b = instance_create(xpos,ypos,obj_bubble);
            with(b)
            {
                tbox.text = mp[?"data"];
                targetwidth = string_width(tbox.text)+32;
                targetheight = string_height(tbox.text)+32;
                var s = 20;
                    textbox_draw(tbox,x+5,y+5,x+targetwidth-s-5,y+targetheight-10,false);
                ypos += targetheight + 100;
            }
            if(i<ds_list_size(lst)-1)
            {
                var mp2 = ds_list_find_value(lst,i+1);
                if(mp2[?"type"] == "choice")
                {
                
                }
                else if(mp2[?"type"] == "fake_choice")
                {
                
                }
            }
        }
    }
    else if(mp[?"type"] == "bubble")
    {
    
    }
}
