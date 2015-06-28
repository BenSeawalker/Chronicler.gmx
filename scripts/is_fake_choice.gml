///is_fake_choice(choice_bubble)
var fc = false;

with(argument0)
{
    if(object_index == obj_choice_bubble)
    {
        if(ds_list_size(choices) > 1)
        {
            fc = true;
            var connection = choices[|0].output.link;
            for(var i=0;i<ds_list_size(choices);i++)
            {
                if(choices[|i].output.link != connection)
                    fc = false;
            }
        }
    }
}

return fc;
