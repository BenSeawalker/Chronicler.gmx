///link_bubbles(b1,b2);
var b1,b2;
    b1 = argument0;
    b2 = argument1;

with(b1)
{
    switch(object_index)
    {
        case obj_bubble:
        case obj_action:
            if(output.link == noone)
                output.link = b2;
        break;
        
        case obj_condition:
            if(out_false.link == noone)
                out_false.link = b2;
        break;
    }
}
