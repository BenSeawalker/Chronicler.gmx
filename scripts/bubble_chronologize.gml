///bubble_chronologize(ds_list chrono, bubbles, start_bubble, position, links,previous)

var chrono,bubbles,start_bubble,position,links,previous;
    chrono = argument0;
    bubbles = argument1;
    start_bubble = argument2;
    position = argument3;
    links = argument4;
    previous = argument5;
    
index = ds_list_find_index(bubbles,start_bubble);
if(index > -1)
{
    //if not the first bubble and the link hasn't already been tested...
    if((previous == -1) || (!ds_map_find_value(links[|index],previous)))
    {
        if(chrono[|index] < position) chrono[|index] = position;
            
        ds_map_replace(links[|index],previous,true);
        
        with(start_bubble)
        {
            switch(object_index)
            {
                case obj_bubble:
                    if(output.link != noone)
                        bubble_chronologize(chrono,bubbles,output.link,position+1,links,id);
                break;
                case obj_choice_bubble:
                    for(var k=0;k<ds_list_size(choices);k++)
                    {
                        if(choices[| k].output.link != noone)
                            bubble_chronologize(chrono,bubbles,choices[| k].output.link,position+1,links,id);
                    }
                break;
                case obj_condition:
                    if(out_true.link != noone)
                        bubble_chronologize(chrono,bubbles,out_true.link,position+1,links,id);
                    if(out_false.link != noone)
                        bubble_chronologize(chrono,bubbles,out_false.link,position+1,links,id);
                break;
                case obj_action:
                    if(output.link != noone)
                        bubble_chronologize(chrono,bubbles,output.link,position+1,links,id);
                break;
            }
        }
    }
}
