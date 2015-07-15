///data_to_choicescript(scene);
var scene, curscene;
curscene = current_scene;
scene = argument0;


change_scene(scene,false);
var mode = GUI_mode;
switch_GUI_mode(false);

//setup vars
var choiceScript,indent,bubbles;

choiceScript = "";
var tmpb = ds_list_write(scene.bubbles);
bubbles = ds_list_create();
ds_list_read(bubbles,tmpb);

indent = "    ";

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

//linking
var links = chronologize_bubbles(bubbles);

//processing
processed = ds_list_create();
for(var i=0;i<ds_list_size(bubbles);i++)
{
    processed[|i] = false;
}

//writing
for(var i=0;i<ds_list_size(bubbles);i++)
{
    if(!processed[|i])
        choiceScript += bubble_to_choicescript(bubbles,links,processed,i,0);
}


//cleanup
for(var i=0;i<ds_list_size(links);i++)
    ds_map_destroy(links[|i]);
    
ds_list_destroy(processed);


//finish
switch_GUI_mode(mode);
change_scene(curscene,false);

return choiceScript;
    
    
    
    
    
    
    
