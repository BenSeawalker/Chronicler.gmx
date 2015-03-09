with(obj_parent_bubble) instance_destroy();
with(obj_choice_parent) instance_destroy();
global.GUID = -1;
var mode = GUI_mode;
switch_GUI_mode(false);

ds_list_clear(allbubbles);
ds_list_clear(allchoices);

obj_scene_group.scene_count = 1;

with(obj_variable) instance_destroy();
ds_list_clear(var_screen.vars);
gamevars =  '*title ' + project_name +chr(10)+
            '*author Your Name Here' +chr(10)+
            '*create player_name "Steve"';
gamestats = "";


with(obj_scene) instance_destroy();
ds_list_clear(scene_list.scenes);
    //add_scene_to_group(scene_list,instance_create(room_width,64,obj_add_scene));
    var s = create_scene(window_get_width()*2,0,"startup",false);
        add_scene_to_group(scene_list,s);
        current_scene = s;
        scene_list.sv[0] = noone;
        scene_list.sv[1] = s;
        scene_list.sv[2] = noone;
        change_scene(s);

save_path = "";
stats_path = "";

view_xview[0] = 0;
view_yview[0] = 0;

switch_GUI_mode(mode);
