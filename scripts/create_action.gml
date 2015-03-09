with(instance_create(mouse_x-10,mouse_y-10,obj_action))
{
    obj_ctrl.mheld = true;
    obj_ctrl.can_group = false;
    drag = true;
    mxsel = mouse_x;
    mysel = mouse_y;
    mxoff = mouse_x-x;
    myoff = mouse_y-y;
}