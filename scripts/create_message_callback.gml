///create_message(x,y,width,height,text,owner,event_user[*]);
with(instance_create(argument0,argument1,obj_message_callback))
{
    width = argument2;
    height = argument3;
    tbox.text = argument4;
    owner = argument5;
    action = argument6;
}