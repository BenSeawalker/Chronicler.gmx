with(obj_parent_bubble) if(id!=argument0) {selected = false; right_selected = false;
                                            group_selected = false; highlighted = false;
                                            if(object_index != obj_bubble)clicks=0;}
                        else {selected = true;};

with(obj_bubble)if(id!=argument0)
{
    with(title)start = 0;
    with(tbox){start = 0;}// read_only = true;}
    //if(!selected)with(color_picker){maxw = 0; destroy = true;}
}

textbox_focus = -1;
textbox_select = -1;
