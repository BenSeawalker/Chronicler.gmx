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
        
        if(links[|index] > 1)
            choiceScript += "*label "+label+chr(10);
        
        switch(object_index)
        {
            case obj_bubble:
                choiceScript += indent_str + string_replace_all(tbox.text,chr(10),chr(10)+indent_str);
                if(tbox.text != "") choiceScript += chr(10);
                
                if(output.link != noone)
                {
                    var ind = ds_list_find_index(bubbles,output.link);
                    if(links[|ind] > 1)
                        choiceScript += indent_str + "*goto "+output.link.label;
                    else
                       choiceScript += bubble_to_choicescript(bubbles,links,processed,ds_list_find_index(bubbles,output.link),indent_level);
                }
                else
                    choiceScript += "*finish";
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
                                if(links[|ind] > 1)
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
                    if(links[|ind] > 1)
                        choiceScript += indent_str + indent + "*goto "+out_true.link.label;
                    else
                        choiceScript += bubble_to_choicescript(bubbles,links,processed,ind,indent_level+1);
                }
                else 
                    choiceScript += "*finish";
                
                if(out_false.link!=noone)
                {
                    if(out_true.link!=noone)
                        choiceScript += chr(10)+indent_str+"*else"+chr(10);
                        
                    var ind = ds_list_find_index(bubbles,out_false.link);
                    if(links[|ind] > 1)
                        choiceScript += indent_str+indent + "*goto "+out_false.link.label;
                    else
                        choiceScript += bubble_to_choicescript(bubbles,links,processed,ind,indent_level+1);
                }
                else
                    choiceScript += "*finish";
            break;
            
            case obj_action:
                choiceScript += indent_str + tbox.text+chr(10);
                if(output.link!=noone)
                {
                    var ind = ds_list_find_index(bubbles,output.link);
                    if(links[|ind] > 1)
                        choiceScript += indent_str + "*goto "+output.link.label;
                    else
                        choiceScript += bubble_to_choicescript(bubbles,links,processed,ind,indent_level);
                }
                else if(!string_pos("*finish",tbox.text))
                    choiceScript += indent_str + "*finish";
            break;
        }
        
        choiceScript += chr(10);
    }
}
return choiceScript;
