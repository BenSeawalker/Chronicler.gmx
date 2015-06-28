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
            var first = ds_map_find_first(links[|index]);
            if(first > -1)
            {
                var ind = ds_list_find_index(bubbles,first);
                make_label = ((ind > index) || (is_fake_choice(first)));
            }
        }
        //*/
        
        //show_debug_message(object_get_name(object_index) + " : " + string(ds_map_find_first(links[|index]).object_index == obj_choice_bubble) + string(is_fake_choice(ds_map_find_first(links[|index]))));
        if(make_label)
            choiceScript += chr(10)+chr(10)+indent_str+"*label "+label + chr(10);
        
        switch(object_index)
        {
            case obj_bubble:
                //show_debug_message(label + " : " + string(index));
                //if(string_char_at(tbox.text,1) == chr(10)) tbox.text = string_copy(tbox.text,2,string_length(tbox.text));
                choiceScript += indent_str + string_replace_all(tbox.text,chr(10),chr(10)+indent_str);
                if(tbox.text != "") choiceScript += chr(10);
                
                if(output.link != noone)
                {
                    var ind = ds_list_find_index(bubbles,output.link);
                    if(ds_map_size(links[|ind]) > 1 || (ind < index))// || ds_map_size(links[|index]) > 1)
                        choiceScript += indent_str + "*goto "+output.link.label;
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
                                if(is_fake_choice(other) || (ds_map_size(links[|ind]) > 1 || (ind < index)))
                                    choiceScript += indent_str + indent+indent+"*goto "+output.link.label;
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
                    if(ds_map_size(links[|ind]) > 1 || (ind < index))
                        choiceScript += indent_str + indent + "*goto "+out_true.link.label;
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
                    if(ds_map_size(links[|ind]) > 1 || (ind < index))
                        choiceScript += indent_str+indent + "*goto "+out_false.link.label;
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
                        choiceScript += indent_str + "*goto "+output.link.label;
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
