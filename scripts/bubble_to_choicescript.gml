///bubble_to_choicescript(bubbles,links,processed,index,indent_level);
var bubbles,links,processed,index,indent_level;
    bubbles = argument0;
    links = argument1;
    processed = argument2;
    index = argument3;
    indent_level = argument4;
    
var choiceScript = "";
var indent = "    ";
var indent_str = string_repeat(indent,indent_level);



if(!processed[|index])
{
    with(bubbles[|index])
    {
        processed[|index] = true;
        
        choiceScript += chr(10);
        
        var make_label = (ds_map_size(links[|index]) > 1);
        ///*
        if(!make_label)
        {   
            var connecting_bubble = ds_map_find_first(links[|index]);
            if(connecting_bubble > -1)
            {
                var ind = ds_list_find_index(bubbles,connecting_bubble);
                make_label = ((ind > index) || (connections_from(connecting_bubble,id) > 1));
            }
        }
        else
        {
            if(object_index == obj_action && string_pos("*label ",tbox.text))
            {
                make_label = false;
                choiceScript += chr(10)+chr(10);
            }
        }
        //*/
        
        if(make_label)
            choiceScript += chr(10)+chr(10)+indent_str+"*label "+ get_label(scene,id) + chr(10);
        
        switch(object_index)
        {
            case obj_bubble:
                choiceScript += indent_str + string_replace_all(tbox.text,chr(10),chr(10)+indent_str);
                if(tbox.text != "") choiceScript += chr(10);
                
                if(output.link != noone)
                {
                    var ind = ds_list_find_index(bubbles,output.link);
                    if(ds_map_size(links[|ind]) > 1 || (ind < index))
                        choiceScript += indent_str + "*goto "+get_label(scene,output.link);
                    else
                       choiceScript += bubble_to_choicescript(bubbles,links,processed,ds_list_find_index(bubbles,output.link),indent_level);
                }
                else
                    choiceScript += indent_str+"*finish";
            break;
            
            case obj_choice_bubble:
                choiceScript += indent_str + "*choice";
                    for(var ii=0;ii<ds_list_size(choices);ii++)
                    {
                        with(choices[| ii])
                        {
                            choiceScript += chr(10) + indent_str + indent;
                            if(cbox.text!="")
                                choiceScript += cbox.text+" ";
                            choiceScript += "#"+tbox.text+chr(10);
                            if(output.link != noone)
                            {
                                var ind = ds_list_find_index(bubbles,output.link);
                                if((connections_from(id,output.link) > 1) || (ds_map_size(links[|ind]) > 1 || (ind < index)))
                                    choiceScript += indent_str + indent+indent+"*goto "+get_label(scene,output.link);
                                else
                                   choiceScript += bubble_to_choicescript(bubbles,links,processed,ind,indent_level+2);
                            }
                            else
                                choiceScript += indent_str + indent+indent+"*finish";
                        }
                    }
            break;
            
            case obj_condition:
                choiceScript += indent_str + "*if("+tbox.text+")"+chr(10);
                
                if(out_true.link!=noone)
                {
                    var ind = ds_list_find_index(bubbles,out_true.link);
                    if((connections_from(id,out_true.link) > 1) || ds_map_size(links[|ind]) > 1 || (ind < index))
                        choiceScript += indent_str + indent + "*goto "+get_label(scene,out_true.link);
                    else
                        choiceScript += bubble_to_choicescript(bubbles,links,processed,ind,indent_level+1);
                }
                else 
                    choiceScript += indent_str+"*finish";
                
                if(out_false.link!=noone)
                {
                    if(out_true.link!=noone)
                        choiceScript += chr(10)+indent_str+"*else"+chr(10);
                        
                    var ind = ds_list_find_index(bubbles,out_false.link);
                    if((connections_from(id,out_false.link) > 1) || ds_map_size(links[|ind]) > 1 || (ind < index))
                        choiceScript += indent_str+indent + "*goto "+get_label(scene,out_false.link);
                    else
                        choiceScript += bubble_to_choicescript(bubbles,links,processed,ind,indent_level+1);
                }
                else
                    choiceScript += indent_str+"*finish";
            break;
            
            case obj_action:
                //show_debug_message(tbox.text + " : " + string(index));
                choiceScript += indent_str + tbox.text+chr(10);
                if(output.link!=noone)
                {
                    var ind = ds_list_find_index(bubbles,output.link);
                    if(ds_map_size(links[|ind]) > 1 || (ind < index))
                        choiceScript += indent_str + "*goto "+get_label(scene,output.link);
                    else
                        choiceScript += bubble_to_choicescript(bubbles,links,processed,ind,indent_level);
                }
                else if(!string_pos("*finish",tbox.text))
                    choiceScript += indent_str + "*finish";
            break;
        }
        
        //choiceScript += chr(10);
    }
}
return choiceScript;
