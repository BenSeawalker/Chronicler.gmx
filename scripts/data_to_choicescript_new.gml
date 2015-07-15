///data_to_choicescript(scene);
var scene, curscene;
curscene = current_scene;
scene = argument0;


change_scene(scene,false);
var mode = GUI_mode;
switch_GUI_mode(false);

//setup vars
var choiceScript,indent, bubbles, i;

choiceScript = "";
var tmpb = ds_list_write(scene.bubbles);
bubbles = ds_list_create();
ds_list_read(bubbles,tmpb);


//variables
if(scene == get_scene("startup"))
{
    choiceScript += "*scene_list"+chr(10);
    for(var i=0;i<ds_list_size(scene_list.scenes);i++)
    {
     choiceScript += indent+ds_list_find_value(scene_list.scenes,i).title.text+chr(10);
    }
    choiceScript += chr(10);
    
    with(var_screen.vars[| 0]) choiceScript += "*title "+name.text+chr(10);
    with(var_screen.vars[| 1]) choiceScript += "*author "+name.text+chr(10)+chr(10);
    for(var ii=0;ii<ds_list_size(var_screen.vars);ii++)
    {
        with(var_screen.vars[|ii])
        {
            if(type == vartype_global)
                choiceScript += "*create "+name.text+" "+value.text+chr(10);
        }
    }
}
for(var i=0;i<ds_list_size(scene.tempvars);i++)
{
    with(scene.tempvars[|i])
        choiceScript += "*temp "+name.text+" "+value.text+chr(10);
}
choiceScript += chr(10);


//var links = ds_list_create();
var chrono = ds_list_create();
for(var i=0;i<ds_list_size(bubbles);i++)
{
    ds_list_add(chrono, ds_list_create());
}
for(var i=0;i<ds_list_size(bubbles);i++)
{
    if(bubbles[|i].start)
        bubble_chronologize(chrono,bubbles,bubbles[|i],0);
}
/*
for(var i=0;i<ds_list_size(bubbles);i++)
{
    ds_list_add(links,0);
        
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
                            links[| i]++;
                    break;
                    case obj_choice_bubble:
                        for(var k=0;k<ds_list_size(choices);k++)
                        {
                            if(choices[| k].link == bubbles[| i])
                                links[| i]++;
                        }
                    break;
                    case obj_condition:
                        if(out_true.link == bubbles[| i])
                            links[| i]++;
                        if(out_false.link == bubbles[| i])
                            links[| i]++;
                    break;
                    case obj_action:
                        if(output.link == bubbles[| i])
                            links[| i]++;
                    break;
                }
            }
        }
    }
}
*/
var processed = ds_list_create();
for(var i=0;i<ds_list_size(bubbles);i++)
{
    ds_list_add(processed,false);
}

var sorted = false;
var sz = ds_list_size(chrono);
for (var i = 0; i < sz - 1; i++)
{
    sorted = true;
    for (var j = 0; j < sz - i - 1; j++)
    {
        ds_list_sort(chrono[|j],true);
        ds_list_sort(chrono[|j+1],true);
        var b1 = ds_list_find_index(chrono[|j],0);
        var b2 = ds_list_find_index(chrono[|j+1],0);
        if (b1 < b2)
        {
            sorted = false
            var tmp = chrono[|j];
            chrono[|j] = chrono[|j+1];
            chrono[|j+1] = tmp;
            tmp = bubbles[|j];
            bubbles[|j] = bubbles[|j+1];
            bubbles[|j+1] = tmp;
        }
    }
    if (sorted) break;
}

//bubbles
for(var i=0;i<ds_list_size(bubbles);i++)
{
    if(!processed[|i])
        choiceScript += bubble_to_choicescript(bubbles,chrono,processed,i,0);
}

switch_GUI_mode(mode);

change_scene(curscene,false);

return choiceScript;
    
    
    
    
    
    
    
