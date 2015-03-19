///cs_proc_data(data,xpos,ypos,create_intro_bubble);
var lst,xpos,ypos,create_intro_bubble;
    lst = argument[0];
    xpos = argument[1];
    ypos = argument[2];
    create_intro_bubble = false;
        if(argument_count > 3) create_intro_bubble = argument[3];
    
var first_created = noone;
var last_created = noone;
var gapx = 1000;
var gapy = 300;

if(create_intro_bubble)
{
    with(instance_create(xpos,ypos,obj_bubble))
    {
        first_created = id;
        last_created = id;
        title.text = "Intro";
        start = true;
        
        ypos += targetheight + gapy;
    }
}

var i = 0;
for(i=0;i<ds_list_size(lst);i++)
{
    var mp = lst[|i];
    if(mp[?"type"] == "action")
    {
        with(instance_create(xpos,ypos,obj_action))
        {
            link_bubbles(last_created,id);
            
            if(first_created == noone) first_created = id;
                    last_created = id;
                    
            tbox.text = mp[?"data"];
            ypos += height + 150;
        }
    }
    else if(mp[?"type"] == "if" || mp[?"type"] == "elseif" || mp[?"type"] == "else")
    {
        switch(mp[?"type"])
        {
        
            case "if":
            case "elseif":
                with(instance_create(xpos,ypos,obj_condition))
                {    
                    if(mp[?"type"] == "elseif")
                        last_created.out_false.link = id;
                    else
                        link_bubbles(last_created,id);
                    
                    
                    tbox.text = string_replace_all(string_replace_all(mp[?"raw"],"*if",""),"*elseif","");
                    
                    var xyp = cs_proc_data(mp[?"data"],xpos-gapx,ypos+200);
                    //xpos = xyp[0];
                    xpos += gapx;
                    ypos = xyp[1];
                    out_true.link = xyp[2];
                    if(mp[?"type"] == "elseif")
                        last_created.out_false.link = xyp[2];
                        
                    if(first_created == noone) first_created = id;
                        last_created = id;
                }
            break;
            case "else":
                var xyp = cs_proc_data(mp[?"data"],xpos+gapx,ypos+200);
                    //xpos = xyp[0];
                    //ypos = xyp[1];
                last_created.out_false.link = xyp[2];
            break;
        }
    }
    else if(mp[?"type"] == "bubble")
    {
        //output += string(mp[?"data"])+chr(10);
        if(string_length(string_trim(mp[?"data"])))
        { 
            var b = instance_create(xpos,ypos,obj_bubble);
            with(b)
            {
                link_bubbles(last_created,id);
                
                if(first_created == noone) first_created = id;
                    last_created = id;
                    
                tbox.text = mp[?"data"];
                //clipboard_set_text(string(mp[?"data"]));
                //targetwidth = string_width(tbox.text)+32;
                //targetheight = string_height(tbox.text)+32;
                var s = 20;
                    textbox_draw(tbox,x+5,y+5,x+targetwidth-s-5,y+targetheight-10,false);
                ypos += targetheight + 100;
            }
            if(i<ds_list_size(lst)-1)
            {
                var mp2 = lst[|i+1];//ds_list_find_value(lst,i+1);
                if(mp2[?"type"] == "choice")
                {
                    if(use_choice_bubbles)
                    {
                        with(instance_create(xpos,ypos,obj_choice_bubble))
                        {
                            
                            b.output.link = id;
                            //last_created = id;
                            
                            var data = mp2[?"data"];
                            var dsize = ds_list_size(data);
                            
                            ypos += dsize*100;
                            var temp_ypos = ypos;
                            
                            for(var ii=0;ii<dsize;ii++)
                            {
                                var mp3 = data[|ii];
                                    
                                with(instance_create(xpos,ypos,obj_bchoice))
                                {
                                    ds_map_add(mp3,"oid",id);
                                    var ltxt = mp3[?"line"];
                                    var spos = string_pos("#",ltxt);
                                    if(spos > 1)
                                    {
                                        cbox.text = string_copy(ltxt,1,spos-1);
                                        ltxt = string_delete(ltxt,1,spos);
                                    }
                                    tbox.text = string_replace(ltxt,"#","");
                                    owner = other.id;
                                    ds_list_add(other.choices,id);
                                    //ypos += height;
                                    
                                    var xyp = cs_proc_data(mp3[?"data"],xpos-gapx*(dsize/2)+gapx*ii,ypos);//+ds_list_size(other.choices)*height);
                                        //xpos = xyp[0];
                                        temp_ypos = max(xyp[1],temp_ypos);
                                    output.link = xyp[2];
                                }
                            }
                            //xpos += gapx*dsize;
                            ypos = temp_ypos + gapy;
                        }
                    }
                    //*/
                }
                else if(mp2[?"type"] == "fake_choice" && i<ds_list_size(lst)-2)
                {
                    var mp3 = lst[|i+2];
                    if(use_choice_bubbles)
                    {
                        with(instance_create(xpos,ypos,obj_choice_bubble))
                        {
                            ds_map_add(mp2,"oid",id);
                            b.output.link = id;
                            //last_created = id;
                            
                            var data = mp2[?"data"];
                            var dsize = ds_list_size(data);
                            
                            ypos += dsize*120;
                            
                            for(var ii=0;ii<dsize;ii++)
                            {
                                var mp4 = data[|ii];
                                    
                                with(instance_create(xpos,ypos,obj_bchoice))
                                {
                                    var ltxt = mp4;
                                    var spos = string_pos("#",ltxt);
                                    if(spos > 1)
                                    {
                                        cbox.text = string_copy(ltxt,1,spos-1);
                                        ltxt = string_delete(ltxt,1,spos);
                                    }
                                    tbox.text = string_replace(ltxt,"#","");
                                    owner = other.id;
                                    output.link = noone;
                                    ds_list_add(other.choices,id);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    else if(mp[?"type"] == "title" || mp[?"type"] == "author" || mp[?"type"] == "create" || mp[?"type"] == "temp")
    {
        if(!string_pos(mp[?"data"],gamevars))
        {
            var txt = string_replace(mp[?"data"],"*temp","*create");
            
            gamevars += txt + chr(10);
        }
        /*
        switch(mp[?"type"])
        {
            case "title":
                project_name = string_trim(string_replace(mp[?"data"],"*title ",""),false);
                var_screen.vars[|0].name.text = project_name;
                //show_debug_message("pname: "+project_name);
                //var vtitle = create_variable(var_screen,vartype_title,project_name,"",false);
            break;
            case "author":
                //create_variable(var_screen,vartype_author,string_trim(string_replace(mp[?"data"],"*author ",""),false),"",false);
                var_screen.vars[|1].name.text = string_trim(string_replace(mp[?"data"],"*author ",""),false);
            break;
            case "create":
                var txt = string_explode(" ",string_trim(string_replace(mp[?"data"],"*create ",""),false));
                var n,v;
                    n = string(txt[|0]);
                    v = "";
                    for(var ii = 1;ii<ds_list_size(txt);ii++)
                        v += string(txt[|ii])+" ";
                    create_variable(var_screen,vartype_global,n,v,true);
                ds_list_destroy(txt);
            break;
            case "temp":
                var txt = string_explode(" ",string_trim(string_replace(mp[?"data"],"*temp ",""),false));
                var n,v;
                    n = string(txt[|0]);
                    v = "";
                    for(var ii = 1;ii<ds_list_size(txt);ii++)
                        v += string(txt[|ii])+" ";
                    create_variable(var_screen,vartype_temp,n,v,true);
                ds_list_destroy(txt);
            break;
        }
        //*/
    }
}

var labels = ds_list_create();
    with(obj_action)
    {
        if(string_pos("*label",tbox.text))
        {
            ds_list_add(labels,id);
        }
    }
    
with(obj_action)
{
    if(string_pos("*goto",tbox.text))
    {
        var plink = noone;
            with(obj_action) if(id != other.id && output.link == other.id)
            {
                plink = id;
                break;
            }
        if(plink != noone)
        {
            var lbl = string_trim(string_replace(tbox.text,"*goto",""),true);
                for(var ii = 0;ii<ds_list_size(labels);ii++)
                {
                    with(labels[|ii])
                    {
                        if(string_pos(lbl,tbox.text) && y>other.y && abs(y-other.y)<=gapy*5)
                        {
                            plink.output.link = id;
                            with(other) instance_destroy();
                        }
                    }
                }
            }
    }
}
ds_list_destroy(labels);

var sdata;
    sdata[0] = xpos;
    sdata[1] = ypos;
    sdata[2] = first_created;
    sdata[3] = i;
    
return sdata;
