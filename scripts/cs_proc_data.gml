///cs_proc_data(data,xpos,ypos);
var lst,xpos,ypos;
    lst = argument0;
    xpos = argument1;
    ypos = argument2;
    
var first_created = noone;
var last_created = noone;
    
for(var i=0;i<ds_list_size(lst);i++)
{
    var mp = lst[|i];
    if(mp[?"type"] == "action")
    {
        with(instance_create(xpos,ypos,obj_action))
        {   if(first_created == noone) first_created = id;
                    last_created = id;
            tbox.text = mp[?"data"];
            ypos += height + 100;
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
        if(string_length(string_trim(mp[?"data"])))
        { 
            var b = instance_create(xpos,ypos,obj_bubble);
            with(b)
            {
                if(first_created == noone) first_created = id;
                    last_created = id;
                tbox.text = mp[?"data"];
                //targetwidth = string_width(tbox.text)+32;
                //targetheight = string_height(tbox.text)+32;
                var s = 20;
                    textbox_draw(tbox,x+5,y+5,x+targetwidth-s-5,y+targetheight-10,false);
                ypos += targetheight + 100;
            }
            if(i<ds_list_size(lst)-1)
            {
                var mp2 = ds_list_find_value(lst,i+1);
                if(mp2[?"type"] == "choice")
                {
                    if(use_choice_bubbles)
                    {
                        with(instance_create(xpos,ypos,obj_choice_bubble))
                        {
                            b.output.link = id;
                            last_created = id;
                            
                            var data = mp2[?"data"];
                            for(var ii=0;ii<ds_list_size(data);ii++)
                            {
                                var mp3 = data[|ii];
                                    
                                with(instance_create(xpos,ypos,obj_bchoice))
                                {
                                    tbox.text = string_replace(mp3[?"line"],"#","");
                                    owner = other.id;
                                    ds_list_add(other.choices,id);
                                    ypos += height;
                                    
                                    var xyp = cs_proc_data(mp3[?"data"],xpos+500,ypos+200);//+ds_list_size(other.choices)*height);
                                        xpos = xyp[0];
                                        //ypos = xyp[1];
                                    output.link = xyp[2];
                                }
                            }
                        }
                    }
                    //*/
                }
                else if(mp2[?"type"] == "fake_choice")
                {
                
                }
            }
        }
    }
}

var sdata;
    sdata[0] = xpos;
    sdata[1] = ypos;
    sdata[2] = first_created;
    //xypos[2] = i;
    
return sdata;
