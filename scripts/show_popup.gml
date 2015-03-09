///show_popup(message);
/*
    var h = 0;
    var dur = 0;
        with(obj_popup)
        {
            h += string_height(msg)+15;
            dur += room_speed/2;
        }
            //h += 5*instance_number(obj_popup);
    with(instance_create(0,h+5,obj_popup))
    {
        msg = argument0;
        duration += string_length(msg)+dur;
    }
*/
if(!instance_exists(obj_popup))
{
    with(instance_create(0,10,obj_popup))
    {
        msg = argument0;
        duration += string_length(msg);
    }
}
else with(obj_popup)
{
    msg = argument0;
    alpha = 1;
    time = 0;
}

