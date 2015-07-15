///connections_from(from, to);

var connections = 0;

with(argument0)
{
    switch(object_index)
    {
        case obj_bubble:
            connections += (output.link == argument1); // 1 or 0
        break;
        case obj_choice_bubble:
            for(var i=0;i<ds_list_size(choices);i++)
                connections += (choices[|i].output.link == argument1); // 1 or 0
        break;
        case obj_condition:
            connections += (out_true.link == argument1); // 1 or 0
            connections += (out_false.link == argument1); // 1 or 0
        break;
        case obj_action:
            connections += (output.link == argument1); // 1 or 0
        break;
    }
}

return connections;
