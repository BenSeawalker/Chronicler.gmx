var n = get_string("Project Name","New Game");
if(n != "")
{
    gamevars = "*title "+n;
    clear_project();
    
    with(instance_create(room_width/2,room_height/4,obj_bubble))
    {
        title.text = "Intro";
    }
}

/*
with(instance_create(room_width/2,room_height/4,obj_action))
{
    tbox.text = "*title New Game!";
    global.action_title = id;
    
    with(instance_create(room_width/2,room_height/4+120,obj_action))
    {
        tbox.text = "*author Default";
        other.output.link = id;
        global.action_author = id;
        
        with(instance_create(room_width/2,room_height/4+120*2+30,obj_bubble))
        {
            title.text = "Intro";
            other.output.link = id;
            global.bubble_intro = id;
        }
    }
}
*/
