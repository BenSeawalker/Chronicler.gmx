///bubble_chronologize(ds_list chrono, bubbles, start_bubble, position, iteration,processed,links,previous)

var chrono,bubbles,start_bubble,position,iteration,links,previous;
    chrono = argument0;
    bubbles = argument1;
    start_bubble = argument2;
    position = argument3;
    iteration = argument4;
    links = argument5;
    previous = argument6;
    
index = ds_list_find_index(bubbles,start_bubble);
if(index > -1)
{
    if((previous == -1) || (!ds_map_find_value(links[|index],previous)))
    {
        if(ds_map_size(links[|index] > 1))
            if(chrono[|index] < position) chrono[|index] = position;
        else
            chrono[|index] = position;
            
        ds_map_replace(links[|index],previous,true);
        
        with(start_bubble)
        {
            switch(object_index)
            {
                case obj_bubble:
                    if(output.link != noone)
                        iteration = bubble_chronologize(chrono,bubbles,output.link,position+1,iteration+1,links,id);
                break;
                case obj_choice_bubble:
                    for(var k=0;k<ds_list_size(choices);k++)
                    {
                        if(choices[| k].output.link != noone)
                            iteration = bubble_chronologize(chrono,bubbles,choices[| k].output.link,position+1,iteration+1,links,id);
                    }
                break;
                case obj_condition:
                    if(out_true.link != noone)
                        iteration = bubble_chronologize(chrono,bubbles,out_true.link,position+1,iteration+1,links,id);
                    if(out_false.link != noone)
                        iteration = bubble_chronologize(chrono,bubbles,out_false.link,position+1,iteration+1,links,id);
                break;
                case obj_action:
                    if(output.link != noone)
                        iteration = bubble_chronologize(chrono,bubbles,output.link,position+1,iteration+1,links,id);
                break;
            }
        }
    }
}

return iteration;
