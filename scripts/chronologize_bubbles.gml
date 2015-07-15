///chrono_setup(bubbles)

var bubbles = argument0;

//show_debug_message("linking");
var links = ds_list_create();
for(var i=0;i<ds_list_size(bubbles);i++)
{
    ds_list_add(links,ds_map_create());
        
    for(var j=0;j<ds_list_size(bubbles);j++)
    {
        if(i != j)
        {
            with(bubbles[| j])
            {
                switch(object_index)
                {
                    case obj_bubble:
                        if(output.link == bubbles[| i])
                            ds_map_add(links[|i],bubbles[|j],false);
                    break;
                    case obj_choice_bubble:
                        for(var k=0;k<ds_list_size(choices);k++)
                        {
                            if(choices[| k].output.link == bubbles[| i])
                                ds_map_add(links[|i],bubbles[|j],false);
                        }
                    break;
                    case obj_condition:
                        if(out_true.link == bubbles[| i])
                            ds_map_add(links[|i],bubbles[|j],false);
                        if(out_false.link == bubbles[| i])
                            ds_map_add(links[|i],bubbles[|j],false);
                    break;
                    case obj_action:
                        if(output.link == bubbles[| i])
                            ds_map_add(links[|i],bubbles[|j],false);
                    break;
                }
            }
        }
    }
}

//chronologizing
var chrono = ds_list_create();
for(var i=0;i<ds_list_size(bubbles);i++)
{
    ds_list_add(chrono, -1);
}

//chronologize bubbles from the start bubble
for(var i=0;i<ds_list_size(bubbles);i++)
{
    if(bubbles[|i].start)
    {
        bubble_chronologize(chrono,bubbles,bubbles[|i],0,links,-1);
        break;
    }
}

//reset order if is locked
for(var i = 0; i<ds_list_size(bubbles); i++)
{
    with(bubbles[|i])
    {
        if(order_locked)
            chrono[|i] = order;
    }
}

//sorting
var sorted = false;
var sz = ds_list_size(chrono);
for (var i = 0; i < sz; i++)
{
    sorted = true;
    for (var j = 0; j < sz - i; j++)
    {
        var b1 = chrono[|j];
        var b2 = chrono[|j+1];
        if (b1 > b2)
        {
            sorted = false
            
            //swap chrono
            var tmp = chrono[|j];
            chrono[|j] = chrono[|j+1];
            chrono[|j+1] = tmp;
            
            //swap bubbles
            tmp = bubbles[|j];
            bubbles[|j] = bubbles[|j+1];
            bubbles[|j+1] = tmp;
            
            //swap links
            tmp = links[|j];
            links[|j] = links[|j+1];
            links[|j+1] = tmp;
        }
    }
    if (sorted) break;
}

//set variables
for(var i = 0; i<ds_list_size(bubbles); i++)
{
    with(bubbles[|i])
    {
        if(!order_locked)
            order = chrono[|i];
            
        orderbox.text = string(order);
    }
}

//cleanup
ds_list_destroy(chrono);

return links;
