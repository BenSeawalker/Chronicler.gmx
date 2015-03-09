clear_project();

with(instance_create(room_width/2,room_height/4,obj_bubble))
{
    title.text = "Start";
    label = get_label(title.text,UID);
    start = true;
}
